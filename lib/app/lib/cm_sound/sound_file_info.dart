/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'sound_def.dart';
import 'sound_file_util.dart';

/// 音声ファイル情報
class SoundFileInfo {

  /// コンストラクタ
  SoundFileInfo({required this.tid});

  final TprMID tid;

  /// タッチ音
  late String _tap;
  Future<String> get tap => _checkFile(settingFileName: _tap, soundKind: SoundKind.tap);

  /// エラー音
  late String _error;
  Future<String> get error => _checkFile(settingFileName: _error, soundKind: SoundKind.error);

  /// 警告音
  late String _warning;
  Future<String> get warning => _checkFile(settingFileName: _warning, soundKind: SoundKind.warning);

  /// ポップアップ音
  late String _popup;
  Future<String> get popup => _checkFile(settingFileName: _popup, soundKind: SoundKind.popup);

  /// ファンファーレ音
  late String _fanfare1;
  Future<String> get fanfare1 => _checkFile(settingFileName: _fanfare1, soundKind: SoundKind.fanfare1);
  late String _fanfare2;
  Future<String> get fanfare2 => _checkFile(settingFileName: _fanfare2, soundKind: SoundKind.fanfare2);
  late String _fanfare3;
  Future<String> get fanfare3 => _checkFile(settingFileName: _fanfare3, soundKind: SoundKind.fanfare3);

  /// Verifone音
  late String _verifone;
  Future<String> get verifone => _checkFile(settingFileName: _verifone, soundKind: SoundKind.verifone);

  /// 記念日音
  late String _birth;
  Future<String> get birth => _checkFile(settingFileName: _birth, soundKind: SoundKind.birth);

  /// ジングルベル
  late final String _jingleBells = SoundFileUtil.fixedFileName(fileName: SoundDef.jingleBellsFile);
  Future<String> get jingleBells => _checkFile(settingFileName: _jingleBells, soundKind: SoundKind.jingleBells);

  /// 現POSでは起動画面から開設を経由しないで遷移させるとき（メンテナンス操作）に鳴る音？
  late final String _init = SoundFileUtil.fixedFileName(fileName: SoundDef.initFile);
  Future<String> get init => _checkFile(settingFileName: _init, soundKind: SoundKind.init);

  /// ZHQ用のファンファーレ
  late final String _zhqFanfare = SoundFileUtil.fixedFileName(fileName: SoundDef.zhqFanfareFile);
  Future<String> get zhqFanfare => _checkFile(settingFileName: _zhqFanfare, soundKind: SoundKind.zhqFanfare);

  /// ZHQ用のエラー音？
  late final String _zhqPu = SoundFileUtil.fixedFileName(fileName: SoundDef.zhqPuFile);
  Future<String> get zhqPu => _checkFile(settingFileName: _zhqPu, soundKind: SoundKind.zhqPu);

  /// ファンファーレ音？
  late final String _fanfare1_3 = SoundFileUtil.fixedFileName(fileName: SoundDef.fanfare1_3File);
  Future<String> get fanfare1_3 => _checkFile(settingFileName: _fanfare1_3, soundKind: SoundKind.fanfare1_3);


  /// タッチ音の設定
  void setTap({required int num}) {
    _tap = SoundFileUtil.makeFileName(
      preFileName: SoundDef.preTapFile,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// エラー音の設定
  void setError({required int num}) {
    _error = SoundFileUtil.makeFileName(
      preFileName: SoundDef.preErrFile,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// 警告音の設定
  void setWarning({required int num}) {
    _warning = SoundFileUtil.makeFileName(
      preFileName: SoundDef.preWarnFile,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// ポップアップ音の設定
  void setPopup({required int num}) {
    _popup = SoundFileUtil.makeFileName(
      preFileName: SoundDef.prePopupFile,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// ファンファーレ1音の設定
  void setFanfare1({required int num}) {
    _fanfare1 = SoundFileUtil.makeFileName(
      preFileName: SoundDef.preFnfl1File,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// ファンファーレ2音の設定
  void setFanfare2({required int num}) {
    _fanfare2 = SoundFileUtil.makeFileName(
      preFileName: SoundDef.preFnfl2File,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// ファンファーレ3音の設定
  void setFanfare3({required int num}) {
    _fanfare3 = SoundFileUtil.makeFileName(
      preFileName: SoundDef.preFnfl3File,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// Verifone音の設定
  void setVerifone({required int num}) {
    _verifone = SoundFileUtil.makeFileName(
      preFileName: SoundDef.preVerifoneFile,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// 記念日音の設定
  void setBirth({required int num}) {
    _birth = SoundFileUtil.makeFileName(
      preFileName: SoundDef.preBirthFile,
      num: num,
      ext: SoundDef.extWav,
    );
  }

  /// 音声ファイルの存在確認
  Future<String> _checkFile({
    required String settingFileName,
    required SoundKind soundKind,
  }) async {

    // 音声ファイルが存在するか確認する
    if (await _checkFileExist(fileName: settingFileName)) {
      return settingFileName;
    }

    // 音声ファイルが存在しない場合は、デフォルトの音声ファイルを使用する
    // （音声ファイル追加機能で追加されたファイルはAsstesないに存在しないため。このルートにくる。このケースがあるかは2024/01/17時点で未定）
    String defFileName = _getFileNameForDefault(settingFileName: settingFileName, soundKind: soundKind);
    await _checkFileExist(fileName: defFileName);
    return defFileName;
  }

  /// 音声ファイルが存在するか確認する
  /// 存在しない場合は、Asstesからコピーする
  Future<bool> _checkFileExist({required String fileName}) async {
    // 音声ファイルが存在するかチェックする
    if (File(fileName).existsSync()) {
      // 存在する
      return true;
    }

    // 存在しない場合は、同名の音声ファイルをAsstesからコピーする
    String assetsFileName = SoundFileUtil.makeAsstesFileName(fileName: fileName);
    await SoundFileUtil.copyFile(tid: tid, assetsFileName: assetsFileName, destFileName: fileName);

    // コピー成功したか確認する
    return File(fileName).existsSync();
  }

  /// デフォルトの音声ファイル名を取得
  String _getFileNameForDefault({
    required String settingFileName,
    required SoundKind soundKind,
  }) {
    // デフォルトの音声ファイル名を取得
    String defFileName;
    switch (soundKind) {
      case SoundKind.tap:             // タッチ音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.preTapFile, num: SoundDef.defTapNum, ext: SoundDef.extWav);
        _tap = defFileName;
      case SoundKind.error:           // エラー音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.preErrFile, num: SoundDef.defErrNum, ext: SoundDef.extWav);
        _error = defFileName;
      case SoundKind.warning:         // 警告音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.preWarnFile, num: SoundDef.defWarnNum, ext: SoundDef.extWav);
        _warning = defFileName;
      case SoundKind.popup:           // ポップアップ音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.prePopupFile, num: SoundDef.defPopupNum, ext: SoundDef.extWav);
        _popup = defFileName;
      case SoundKind.fanfare1:        // ファンファーレ1音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.preFnfl1File, num: SoundDef.defFnfl1Num, ext: SoundDef.extWav);
        _fanfare1 = defFileName;
      case SoundKind.fanfare2:        // ファンファーレ2音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.preFnfl2File, num: SoundDef.defFnfl2Num, ext: SoundDef.extWav);
        _fanfare2 = defFileName;
      case SoundKind.fanfare3:        // ファンファーレ3音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.preFnfl3File, num: SoundDef.defFnfl3Num, ext: SoundDef.extWav);
        _fanfare3 = defFileName;
      case SoundKind.verifone:		    // verifone音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.preVerifoneFile, num: SoundDef.defVerifoneNum, ext: SoundDef.extWav);
        _verifone = defFileName;
      case SoundKind.birth:           // 誕生日音
        defFileName = SoundFileUtil.makeFileName(preFileName: SoundDef.preBirthFile, num: SoundDef.defBirthNum, ext: SoundDef.extWav);
        _birth = defFileName;
      default:
        // 異なる番号の音声ファイルが存在しないので、設定されている音声ファイル名を返す
        return settingFileName;
    }

    TprLog().logAdd(tid, LogLevelDefine.warning,
        "SoundFileInfo change to default name=$defFileName");

    // デフォルトの音声ファイル名を返す
    return defFileName;
  }
}
