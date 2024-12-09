/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../ui/controller/c_common_controller.dart';
import '../../ui/language/l_languagedbcall.dart';
import 'sound_def.dart';

/// 音声ファイル関連の処理
class SoundFileUtil {

  // 音声ファイルの置き場所のルートディレクトリ
  static late final String _rootSoundPath;

  /// 音声ファイルのルートディレクトリを決定
  static void initialize() {
    // /pj/tprx/sound に配置する
    _rootSoundPath = join(EnvironmentData().sysHomeDir, SoundDef.soundPath);
  }

  /// 音声番号と言語種別によって、音声ファイル名を取得する
  static String getFileNameByNumber({
    required int soundNum,
  }) {
    // 言語情報を管理しているコントローラを取得
    CommonController commonController = Get.find();

    // 言語の種別によって、音声ファイル名を返却
    LocaleNo localeNo = LocaleNo.values.firstWhere(
        (element) => element.no == commonController.intCountry.value);
    switch (localeNo) {
      case LocaleNo.English:
        return '${SoundDef.fselfSoundFileHead}${SoundDef.fselfLangEx}_$soundNum${SoundDef.extWav}';
      case LocaleNo.Chinese:
        return '${SoundDef.fselfSoundFileHead}${SoundDef.fselfLangChn}_$soundNum${SoundDef.extWav}';
      case LocaleNo.Korean:
        return '${SoundDef.fselfSoundFileHead}${SoundDef.fselfLangKor}_$soundNum${SoundDef.extWav}';
      case LocaleNo.Japanese:
      default:
        return '${SoundDef.fselfSoundFileHead}_$soundNum${SoundDef.extWav}';
    }
  }

  /// ファイル名生成（固定）
  static String fixedFileName({
    required String fileName,
  }) {
    return '$_rootSoundPath/$fileName';
  }

  /// ファイル名生成（番号付き）
  static String makeFileName({
    required String preFileName,
    required int num,
    required String ext,
  }) {
    return '$_rootSoundPath/$preFileName$num$ext';
  }

  /// ユーザーフォルダのファイル名からAsstesファイル名を生成する
  static String makeAsstesFileName({
    required String fileName,
  }) {
    String name = fileName.substring(_rootSoundPath.length+1);  // +1は、[/]の分
    return '${SoundDef.assetsPath}${SoundDef.soundPath}/$name';
  }

  /// Assetsフォルダ内の音声ファイルをユーザーディレクトリにコピーする
  static Future<void> copyFiles({
    required TprMID tid,
  }) async {
    // Assetsフォルダ内の音声ファイルの一覧取得
    String assetsSoundPath = join(SoundDef.assetsPath, SoundDef.soundPath);
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    List<String> assetsList = assetManifest.listAssets().where((e) => e.startsWith(assetsSoundPath)).toList();

    // assetsフォルダ内にある全ての音声ファイルのコピーする
    for (String assetsFile in assetsList) {
      // コピー先のファイル名
      String destFileName = join(_rootSoundPath, assetsFile.substring(assetsSoundPath.length+1)); // +1は、[/]の分

      // 指定されたAssetsフォルダ内の音声ファイルをユーザーディレクトリにコピーする
      await copyFile(tid: tid, assetsFileName: assetsFile, destFileName: destFileName);
    }
  }

  /// 指定されたAssetsフォルダ内の音声ファイルをユーザーディレクトリにコピーする
  static Future<void> copyFile({
    required TprMID tid,
    required String assetsFileName,
    required String destFileName,
  }) async {
    try {
      // コピー先のディレクトリ確認
      Directory destDir = Directory(dirname(destFileName));
      if (!destDir.existsSync()) {
        destDir.createSync(recursive: true);
        TprLog().logAdd(tid, LogLevelDefine.warning,
            "SoundFileUtil Create Directory ${destDir.path}");
      }

      // コピー先のファイル確認
      if (!File(destFileName).existsSync()) {
        // 音声ファイルのコピー
        ByteData data = await rootBundle.load(assetsFileName);
        List<int> bytes = data.buffer.asUint8List(
            data.offsetInBytes, data.lengthInBytes);
        await File(destFileName).writeAsBytes(bytes);
        TprLog().logAdd(tid, LogLevelDefine.warning,
            "SoundFileUtil Copy File $destFileName");
      }
    } catch (e) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "SoundFileUtil copyFile error $e assetsFileName=$assetsFileName destFileName=$destFileName");
    }
  }

  /// 番号の一覧を取得する
  static Future<List<int>> getNumberList(SoundKind soundKind) async {
    // 対象の音声ファイル名を取得
    String targetName;
    switch (soundKind) {
      case SoundKind.tap:             // タッチ音
        targetName = SoundDef.preTapFile;
      case SoundKind.error:           // エラー音
        targetName = SoundDef.preErrFile;
      case SoundKind.warning:         // 警告音
        targetName = SoundDef.preWarnFile;
      case SoundKind.popup:           // ポップアップ音
        targetName = SoundDef.prePopupFile;
      case SoundKind.fanfare1:        // ファンファーレ1音
        targetName = SoundDef.preFnfl1File;
      case SoundKind.fanfare2:        // ファンファーレ2音
        targetName = SoundDef.preFnfl2File;
      case SoundKind.fanfare3:        // ファンファーレ3音
        targetName = SoundDef.preFnfl3File;
      case SoundKind.verifone:		    // verifone音
        targetName = SoundDef.preVerifoneFile;
      case SoundKind.birth:           // 誕生日音
        targetName = SoundDef.preBirthFile;
      default:
        return [];    // 番号付きの音声ファイルではないので、空を返す
    }

    // 音声ファイルのフルパスを取得して、ディレクトリ部分とファイル名部分を分ける
    final String targetPreFilePath = fixedFileName(fileName: targetName);
    final Directory targetDir = Directory(dirname(targetPreFilePath));
    final String targetPreFileName = basename(targetPreFilePath);

    // ディレクトリ内の一覧を取得する
    List<int> list = targetDir.listSync()
        .where((e) => _soundFileFilter(e, targetPreFileName))
        .map((e) => _extractNumber(e.path))
        .toList();
    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  /// 対象の音声ファイル
  static bool _soundFileFilter(FileSystemEntity fileSystemEntity, String targetPreFileName) {
    String fileName = basename(fileSystemEntity.path);
    return (fileSystemEntity is File)                             // ディレクトリではなく、ファイルか？
        && (fileName.startsWith(targetPreFileName))               // 音声ファイルのプレフィックスが同じか？
        && (fileName.indexOf('_') == fileName.lastIndexOf('_'));  // ファイル名に使用されている「_」が1つか？
  }

  /// plus/click_n.wavのnの部分を取得する
  static int _extractNumber(String filePath) {
    String fileName = basename(filePath);
    int idxStart = fileName.indexOf('_');
    int idxEnd = fileName.indexOf('.');
    return int.parse(fileName.substring(idxStart+1, idxEnd));
  }
}
