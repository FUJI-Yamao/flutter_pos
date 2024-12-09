/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/environment.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// 標準ライブラリ関数を寺岡アプリ用に簡便化したり, ログ付けなどをした関数群
/// 関連tprxソース: AplLib_StdAdd.c
class AplLibStdAdd {
  /// remove関数へのログ追加
  /// ディレクトリを指定した場合に削除出来るように拡張
  /// 関連tprxソース: AplLib_StdAdd.c - AplLibRemove()
  static bool aplLibRemove(TprMID tid, String name) {
    try {
      if (name.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
            "aplLibRemove()：　 Error argument",
            errId: -1);
        return false;
      }
      // TODO:10082 ディレクトリからファイル検索&操作
      // ﾌｧｲﾙ判定の方法がぱっと出てこなかったので、一旦突貫の対応してます
      // 引数がディレクトリだったら中身ごと削除
      // 引数がファイルだったらそのまま削除.
      if (TprxPlatform.getFile(name).existsSync()) {
        TprxPlatform.getFile(name).delete();
      } else if (TprxPlatform.getDirectory(name).existsSync()) {
        TprxPlatform.getDirectory(name).deleteSync(recursive: true);
      }

      return true;
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "aplLibRemove()：name[$name] errno $e,$s",
          errId: -1);
      return false;
    }
  }

  // rename関数へのログ追加
  /// 関連tprxソース: AplLib_StdAdd.c - AplLibRename()
  static bool aplLibRename(TprMID tid, String oldName, String newName) {
    String log = '';
    String callFunc = 'aplLibRename';

    try {
      // 引数チェック
      if ((oldName.isEmpty) || (newName.isEmpty)) {
        log = sprintf("%s: Error argument\n", [callFunc]);
        TprLog().logAdd(tid, LogLevelDefine.error, log);
        return false;
      }

      // TODO:10082 ディレクトリからファイル検索&操作
      // 引数がファイルだったらファイル名変更.
      // 引数がディレクトリだったらディレクトリ名変更.
      if (TprxPlatform.getFile(oldName).existsSync()) {
        oldName = newName;
      } else if (TprxPlatform.getDirectory(oldName).existsSync()) {
        oldName = newName;
      }
      return true;

    } catch (e) {
      log = sprintf(
          "%s: errno[%i]old[%s]new[%s]", [callFunc, e, oldName, newName]);
      TprLog().logAdd(tid, LogLevelDefine.error, log);
      return false;
    }
  }

  /// ディレクトリ作成
  /// 関連tprxソース: AplLib_StdAdd.c - aplLibMkdir()
  static Future<int>	aplLibMkdir(TprMID tid, String dirName, String mode ) async {
    String callFunc = 'aplLibMkdir';
    // 引数チェック
    if (dirName.isEmpty) {
      TprLog().logAdd(tid, LogLevelDefine.error, sprintf("%s: Error argument\n", [callFunc]));
      return -1;
    }

    // 存在確認
    Directory dirp = Directory(dirName);
    if (dirp.existsSync()) {
      TprLog().logAdd(tid, LogLevelDefine.normal, sprintf("%s: Already dir[%s]\n", [callFunc, dirName]));
      return 0;
    }

    try {
      dirp.createSync(recursive: true);
      if (Platform.isLinux) {
        await Process.run('chmod', [mode, dirp.path]);
      }
    } catch (e) {
      TprLog().logAdd(tid, LogLevelDefine.error, sprintf("%s: errno[%d]dirName[%s]\n", [callFunc, e, dirName]));
      return -1;
    }
    return 0;
  }

  /// ディレクトリ配下のファイルに対してコールバック処理を実行する
  /// 関連tprxソース: AplLib_StdAdd.c - AplLibProcScanDirBeta
  static int aplLibProcScanDirBeta(TprMID tid, String dirName, String? scanDirArg
      , Function(TprMID tid, String fileName, String path, String? scanDirArg) execFunc) {

    // 引数チェック
    if (dirName.isEmpty) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, "aplLibProcScanDirBeta: Error argument\n");
      return -1;
    }

    int fileCnt = 0;
    // ディレクトリ走査 (アルファベット順)
    Directory dirp = TprxPlatform.getDirectory(dirName);
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();

      // ファイルを昇順でチェックしていく
      Iterable<FileSystemEntity> files = entities
                  .whereType<File>().sortedBy((element) => basename(element.path));

      for (FileSystemEntity file in files) {

        var ret = execFunc(tid, basename(file.path), file.path, scanDirArg);

        if (ret == SCAN_DIR_RESULT.SCAN_DIR_OK || ret == SCAN_DIR_RESULT.SCAN_DIR_BREAK) {
          // ファイルに対する実行が成功.
          fileCnt++;
        }

        if (ret == SCAN_DIR_RESULT.SCAN_DIR_BREAK) {
          // 終了処理.
          break;
        }

        if (ret == SCAN_DIR_RESULT.SCAN_DIR_ERROR) {
          TprLog().logAdd(
              tid, LogLevelDefine.error, "aplLibProcScanDirBeta: Error ${file.path}\n");
          return -1;
        }
      }
    }

    return fileCnt;
  }

  // fopen関数へのログ追加
  /// 関連tprxソース: AplLib_StdAdd.c - AplLibFileOpen()
  static File? aplLibFileOpen(TprMID tid, String? name, String? mode) {
    File fp;
    String log = '';
    String callFunc = 'aplLibFileOpen';

    // 引数チェック
    if (name == null || mode == null) {
      log = "%$callFunc: Error argument\n";
      TprLog().logAdd(tid, LogLevelDefine.error, log);
      return null;
    }

    try {
      fp = TprxPlatform.getFile(name);
      if (!fp.existsSync()) {
        return null;
      }
      return fp;
    } catch (e) {
      log = "$callFunc: errno[$e]name[$name]mode[$mode]";
      TprLog().logAdd(tid, LogLevelDefine.error, log);
    }

    return null;
  }
}
