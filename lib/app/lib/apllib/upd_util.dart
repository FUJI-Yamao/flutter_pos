/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/common/cls_conf/mac_infoJsonFile.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cls_conf/versionJsonFile.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/l_upd_err_chk.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/upd.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../../inc/sys/tpr_type.dart';
import '../../common/environment.dart';
import '../../common/cmn_sysfunc.dart';
import '../../lib/apllib/competition_ini.dart';

import 'cmd_func.dart';

/// 関連tprxソース: UpdUtil.c
class UpdUtil {

  /// 関連tprxソース: UpdUtil.c - Upd_BaseDir
  static String updBaseDir(TprMID tid) {
    return sprintf(AplLib.UPD_DIRNM, [EnvironmentData().env['TPRX_HOME']]);
  }

  /// 関連tprxソース: UpdUtil.c - Upd_BaseOldDir
  static String updBaseOldDir(TprMID tid) {
    return sprintf(AplLib.UPD_OLDDIRNM, [EnvironmentData().env['TPRX_HOME']]);
  }


  /// アップデート関連ディレクトリの作成.
  ///  関連tprxソース:UpdUtil.c - Upd_DirCreate()
  // TODO:10030 ファイル操作 各OSの動作確認　windowsOK. linux,Android未確認.
  static Future<bool> updDirCreate(int tid) async {
    TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_DirCreate start");
    String updDirName = "";
    try {
      updDirName = sprintf(
          AplLib.UPD_DIRNM, [EnvironmentData().sysHomeDir]);
      final updDir = TprxPlatform.getDirectory(updDirName);
      await updDir.create(recursive: true);
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "Upd_DirCreate mkdir[$updDirName] end\n");
      CmdFunc.chmodAll(updDirName);
      updDirName = sprintf(
          AplLib.UPD_OLDDIRNM, [EnvironmentData().sysHomeDir]);
      final updOldDir = TprxPlatform.getDirectory(updDirName);
      await updOldDir.create(recursive: true);
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "Upd_DirCreate mkdir[$updDirName] end");
      CmdFunc.chmodAll(updDirName);
    } catch (e, s) {
      // フォルダ作成エラー.
      TprLog().logAdd(tid, LogLevelDefine.error,
          "Upd_DirCreate mkdir[$updDirName] error[$e] stacktrace[$s]");
      return false;
    }
    return true;
  }

  // 追加V14->V15
  ///  関連tprxソース:UpdUtil.c - Upd_USB_DirCreate()
  static int updUSBDirCreate() {
    return 0;
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース:UpdUtil.c - Void_MEM_Send()
  static int voidMemSend(TprMID tid, String ipadr, RegsMem mem) {
    return 0;
  }

  ///  関連tprxソース:UpdUtil.c - Upd_RestCnt_Chk()
  static Future<int> updRestCntChk(TprMID tid) async {
    int num = 0;
    int bkNum = 0;
    int tCnt = 0;
    String log = '';

    int result = await updReadRest(tid);
    num = result;
    bkNum = result;

    log = sprintf("Upd_RestCnt_Chk Start num[%d]", [num]);
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    while (num != 0) {
      num = await updReadRest(tid);
      if (bkNum == num) {
        tCnt++;
      }
      else {
        tCnt = 0;
        bkNum = num;
      }
      if (tCnt >= 10 * 5) {
        log = sprintf("Upd_RestCnt_Chk timeout [%d]", [num]);
        TprLog().logAdd(tid, LogLevelDefine.error, log);
        return num;
      }
      TprMacro.usleep(200000);
    }
    return num;
  }

  ///  関連tprxソース:UpdUtil.c - Upd_Read_Rest()
  static Future<int> updReadRest(TprMID tid) async {
    String dirName = '';
    String erLog = '';

    int num = 0;

    TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_Read_Rest start\n");
    dirName = sprintf(AplLib.UPD_DIRNM, [EnvironmentData().sysHomeDir]);

    var dp = Directory(dirName);
    if (!await dp.exists()) {
      erLog = sprintf("Upd_Read_Rest opendir[%s] error[%d]\n", [dirName]);
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return -1;
    }

    await for (var entry in dp.list(recursive: false, followLinks: false)) {
      var stat = await entry.stat();
      if (stat.type == FileSystemEntityType.file) {
        if ((stat.mode & 0x0020) == 0) {
          continue;
        }
        else if (entry.path.endsWith('.zip')) {
          num++;
        }
        else if(entry.path.startsWith(AplLib.VOIDEJ_MEM_HEADNAME)) {
          num++;
        }
        else if(entry.path.startsWith(AplLib.VOIDEJ_MEM_HEADNAME)) {
          num++;
        }
        else if (entry.path.startsWith(AplLib.UPD_NMINIT)) {
          num++;
        }
      }
    }
    TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_Read_Rest end\n");
    return num;
  }

  ///  関連tprxソース:UpdUtil.c - Upd_Erlog_Mv
  static Future<int> updErlogMv(TprMID tid) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, 'Upd_Erlog_Mv rxMemPtr error');
      updErrLogCreate(tid, 0, 'Upd_Erlog_Mv rxMemPtr error!!!!!!!',
          UpdErrChkNum.UPD_ERR_CHK_SYSTEM);
      return -1;
    }
    TprLog().logAdd(tid, LogLevelDefine.normal, 'Upd_Erlog_Mv\n');

    // エラーログファイルのパスを作成
    // /home/postgres/upd_err.log
    var fname = AplLib.UPD_ERR_LOG_NAME;
    var file = File(fname);
    if (file.existsSync() == false) {
      TprLog().logAdd(tid, LogLevelDefine.normal,
          'Upd_Erlog_Mv not found[$AplLib.UPD_ERR_LOG_NAME]\n');
      return 0;
    }

    var now = DateTime.now();

    // 移動先のファイル名を作成
    // TPRX_HOME/log/Upd_erlog_historyマシン番号年月日時分秒
    // "%s/log/Upd_erlog_history%06ld%04d%02d%02d%02d%02d%02d"
    var mv_fname = sprintf(AplLib.UPD_ERLOG_MV_FNAME, [
      EnvironmentData().sysHomeDir,
      (await CompetitionIni.competitionIniGetMacNo(tid)).value,
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second
    ]);

    // rename関数で現在のログファイルを過去のログファイルにリネーム
    TprLog()
        .logAdd(tid, LogLevelDefine.normal, 'rename[$fname]->[$mv_fname]\n');

    try {
      File(fname).renameSync(mv_fname);
    } catch (e) {
      TprLog().logAdd(tid, LogLevelDefine.error, 'rename error[$e]\n');
      return -1;
    }
    return 1;
  }

  
  ///  関連tprxソース:UpdUtil.c - Upd_ErrChk_AllMv
  static Future<int> updErrChkAllMv(TprMID tid, UpdErrChkNum execPosi) async {
    TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_ErrChk_AllMv_Backend start[$execPosi]\n");

    Mac_infoJsonFile macini = Mac_infoJsonFile();
    await macini.load();

    int macno = macini.system.macno;
    TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_ErrChk_AllMv_Backend macno OK[${macno.toString()}]\n");

    int num = await updReadRest(tid);

    VersionJsonFile verini = VersionJsonFile();
    var tmpbuf = verini.apl.ver;
    if (tmpbuf.isEmpty) {
      tmpbuf = "vX.XXXXX ";
    }
    String version = tmpbuf[1] == 'A' ? tmpbuf.substring(0, 10) : tmpbuf.substring(0, 8);

    DateTime now = DateTime.now();
    String updPath = updBaseDir(tid);
    String tpxHome = EnvironmentData().env['TPRX_HOME']!;
    // "%s/log/Upd_erlog_history%06d%04d%02d%02d%02d%02d%02d
    String fname = sprintf(Upd.UPD_ERLOG_MV_LISTNAME, [tpxHome, version, macno
                                                , now.year, now.month, now.day
                                                , now.hour, now.minute, now.second]);
    if (Platform.isLinux) {
      try {
        String command = "ls -al -R $updPath > $fname";
        Process.runSync("sh", ["-c", command]);
        TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_ErrChk_AllMv_Backend list create[$updPath][$fname]");

        command = "tar cfz $fname $updPath";
        Process.runSync("sh", ["-c", command]);
        TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_ErrChk_AllMv_Backend tar create[$fname][$updPath]");
      } catch (e) {
        TprLog().logAdd(tid, LogLevelDefine.error, "Upd_ErrChk_AllMv_Backend error $e");
        return -1;
      }
    }

    // "echo $updPath/* | xargs rm -f";
    Directory updDir = TprxPlatform.getDirectory(updPath);
    if (updDir.existsSync()) {
      for (FileSystemEntity file in updDir.listSync()) {
        file.deleteSync();
      }
      TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_ErrChk_AllMv_Backend 1 remove[$updPath]\n");
    }

    // echo $updPath/* | xargs rm -f
    updPath = updBaseOldDir(tid);
    updDir = TprxPlatform.getDirectory(updPath);
    if (updDir.existsSync()) {
      for (FileSystemEntity file in Directory(updPath).listSync()) {
        file.deleteSync();
      }
      TprLog().logAdd(tid, LogLevelDefine.normal, "Upd_ErrChk_AllMv_Backend 2 remove[$updPath]\n");
    }

    if (num != 0) {
      updErrLogCreate(tid, 0, LUpdErrChk.UPD_ERLOG_MSG_MV, execPosi);
    }

    return num;
  }

  ///  関連tprxソース:UpdUtil.c - UpdErrLogCreate
  static int updErrLogCreate(TprMID tid, int flg, String msg, UpdErrChkNum errPosi) {
    try {
      // "/home/postgres/upd_err.log"
      var file = File(AplLib.UPD_ERR_LOG_NAME);

      var now = DateTime.now();
      // エラーログファイルを日付付きとして出力
      // "%04d-%02d-%02d %02d:%02d:%02d\t%d\t%d\t%s\n";
      var buf = sprintf(AplLib.UPDERRLOG_CREATE_DATA, [
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
        flg,
        errPosi.index,
        msg
      ]);

      // エラーログファイルに追記
      file.writeAsStringSync(buf, mode: FileMode.append);
    } catch (e) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'updErrLogCreate fopen error[$msg]\n');
      return -1;
    }
    return 0;
  }
}
