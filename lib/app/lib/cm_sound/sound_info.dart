/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cls_conf/soundJsonFile.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_type.dart';
import 'sound_def.dart';
import 'sound_file_info.dart';
import 'sound_volume_info.dart';

/// サウンド情報
class SoundInfo {

  /// コンストラクタ
  SoundInfo();

  /// 音量などの情報（本体）
  final SoundFileInfo soundFileInfo1 = SoundFileInfo(tid: Tpraid.TPRAID_SOUND);
  final SoundVolumeInfo soundVolumeInfo1 = SoundVolumeInfo();

  /// 音量などの情報（タワー側or客側表示パネル）
  final SoundFileInfo soundFileInfo2 = SoundFileInfo(tid: Tpraid.TPRAID_SOUND2);
  final SoundVolumeInfo soundVolumeInfo2 = SoundVolumeInfo();

  /// 初期化
  void initialize(SoundJsonFile soundJson) {
    _initialize(soundJson);
  }

  /// 音声ファイル名を取得
  Future<String> getSoundFileName({
    required TprMID tid,
    required SoundKind soundKind,
  }) async {
    // 音声ファイル情報を取得
    SoundFileInfo soundFileInfo = _getSoundFileInfo(tid: tid);

    String fileName;

    // 指定された音の情報を取得
    switch (soundKind) {
      case SoundKind.tap:             // タッチ音
        fileName = await soundFileInfo.tap;
      case SoundKind.error:           // エラー音
        fileName = await soundFileInfo.error;
      case SoundKind.warning:         // 警告音
        fileName = await soundFileInfo.warning;
      case SoundKind.popup:           // ポップアップ音
        fileName = await soundFileInfo.popup;
      case SoundKind.fanfare1:        // ファンファーレ1音
        fileName = await soundFileInfo.fanfare1;
      case SoundKind.fanfare2:        // ファンファーレ2音
        fileName = await soundFileInfo.fanfare2;
      case SoundKind.fanfare3:        // ファンファーレ3音
        fileName = await soundFileInfo.fanfare3;
      case SoundKind.verifone:		    // verifone音
        fileName = await soundFileInfo.verifone;
      case SoundKind.birth:           // 誕生日音
        fileName = await soundFileInfo.birth;
      case SoundKind.jingleBells:     // ジングルベル
        fileName = await soundFileInfo.jingleBells;
      case SoundKind.init:            // 現POSでは起動画面から開設を経由しないで遷移させるとき（メンテナンス操作）に鳴る音？
        fileName = await soundFileInfo.init;
      case SoundKind.zhqFanfare:      // ZHQ用のファンファーレ
        fileName = await soundFileInfo.zhqFanfare;
      case SoundKind.zhqPu:           // ZHQ用のエラー音？
        fileName = await soundFileInfo.zhqPu;
      case SoundKind.fanfare1_3:      // ファンファーレ音？
        fileName = await soundFileInfo.fanfare1_3;
    }

    return fileName;
  }

  /// 音量を取得
  SoundVolume getSoundVolume({
    required TprMID tid,
    required SoundVolumeKind soundVolumeKind,
  }) {
    // ステレオバランス
    // -1 - 左チャンネルは最大音量です。右チャンネルは無音です。
    // 1 - 右チャンネルは最大音量です。左チャンネルは無音です。
    // 0 - 両方のチャンネルの音量は同じです。
    late double balance;
    if (tid == Tpraid.TPRAID_SOUND) {
      // 本体側は右で鳴らす
      balance = 1.0;
    } else {
      // タワー側 or 客側表示パネルを左で鳴らす
      balance = -1.0;
    }

    // 音量情報を取得
    SoundVolumeInfo soundVolumeInfo = _getSoundVolumeInfo(tid: tid);

    // 指定された音の情報を取得
    switch (soundVolumeKind) {
      case SoundVolumeKind.tap:             // タッチ音（メイン音量）
        return SoundVolume(volume: soundVolumeInfo.tap, balance: balance);
      case SoundVolumeKind.error:           // エラー音
        return SoundVolume(volume: soundVolumeInfo.error, balance: balance);
      case SoundVolumeKind.warning:         // 警告音
        return SoundVolume(volume: soundVolumeInfo.warning, balance: balance);
      case SoundVolumeKind.popup:           // ポップアップ音
        return SoundVolume(volume: soundVolumeInfo.popup, balance: balance);
      case SoundVolumeKind.fanfare1:        // ファンファーレ1音
        return SoundVolume(volume: soundVolumeInfo.fanfare1, balance: balance);
      case SoundVolumeKind.fanfare2:        // ファンファーレ2音
        return SoundVolume(volume: soundVolumeInfo.fanfare2, balance: balance);
      case SoundVolumeKind.fanfare3:        // ファンファーレ3音
        return SoundVolume(volume: soundVolumeInfo.fanfare3, balance: balance);
      case SoundVolumeKind.verifone:		    // verifone音
        return SoundVolume(volume: soundVolumeInfo.verifone, balance: balance);
      case SoundVolumeKind.birth:           // 誕生日音
        return SoundVolume(volume: soundVolumeInfo.birth, balance: balance);
      case SoundVolumeKind.guidance:        // ガイダンス音声
        return SoundVolume(volume: soundVolumeInfo.guidance, balance: balance);
    }
  }

  /// 音声ファイル情報を取得
  SoundFileInfo _getSoundFileInfo({required TprMID tid}) {
    if (tid == Tpraid.TPRAID_SOUND2) {
      return soundFileInfo2;
    } else {
      return soundFileInfo1;
    }
  }

  /// 音量情報を取得
  SoundVolumeInfo _getSoundVolumeInfo({required TprMID tid}) {
    if (tid == Tpraid.TPRAID_SOUND2) {
      return soundVolumeInfo2;
    } else {
      return soundVolumeInfo1;
    }
  }

  /// 初期化
  void _initialize(SoundJsonFile soundJson) {

    // 本体側
    soundFileInfo1.setTap(num: soundJson.pitch.CLICK_NUM_R);                // タッチ音の種類
    soundFileInfo1.setError(num: soundJson.pitch.ERR_NUM_R);                // エラー音の種類
    soundFileInfo1.setWarning(num: soundJson.pitch.WARNING_NUM_R);          // 警告音の種類
    soundFileInfo1.setPopup(num: soundJson.pitch.POPUP_NUM_R);              // ポップアップ音の種類
    soundFileInfo1.setFanfare1(num: soundJson.pitch.FANFARE1_NUM_R);        // ファンファーレ1音の種類
    soundFileInfo1.setFanfare2(num: soundJson.pitch.FANFARE2_NUM_R);        // ファンファーレ2音の種類
    soundFileInfo1.setFanfare3(num: soundJson.pitch.FANFARE3_NUM_R);        // ファンファーレ3音の種類
    soundFileInfo1.setVerifone(num: soundJson.pitch.VERIFONE_NUM_R);        // Verifone音の種類
    soundFileInfo1.setBirth(num: soundJson.pitch.BIRTH_NUM_R);              // 記念日音の種類
    soundVolumeInfo1.setTap(volume: soundJson.volume.G1R);                  // タッチ音
    soundVolumeInfo1.setError(volume: soundJson.volume.ERR_R);              // エラー音
    soundVolumeInfo1.setWarning(volume: soundJson.volume.WARN_R);           // 警告音
    soundVolumeInfo1.setPopup(volume: soundJson.volume.POPUP_R);            // ポップアップ音
    soundVolumeInfo1.setFanfare1(volume: soundJson.volume.FANFARE1_R);      // ファンファーレ1音
    soundVolumeInfo1.setFanfare2(volume: soundJson.volume.FANFARE2_R);      // ファンファーレ2音
    soundVolumeInfo1.setFanfare3(volume: soundJson.volume.FANFARE3_R);      // ファンファーレ3音
    soundVolumeInfo1.setVerifone(volume: soundJson.volume.VERIFONE_R);      // Verifone音
    soundVolumeInfo1.setBirth(volume: soundJson.volume.BIRTH_R);            // 記念日音
    soundVolumeInfo1.setGuidance(volume: soundJson.guidance.right_volume);  // ガイダンス音声の音量

    // タワー側or客側表示パネル
    soundFileInfo2.setTap(num: soundJson.pitch.CLICK_NUM_L);                // タッチ音の種類
    soundFileInfo2.setError(num: soundJson.pitch.ERR_NUM_L);                // エラー音の種類
    soundFileInfo2.setWarning(num: soundJson.pitch.WARNING_NUM_L);          // 警告音の種類
    soundFileInfo2.setPopup(num: soundJson.pitch.POPUP_NUM_L);              // ポップアップ音の種類
    soundFileInfo2.setFanfare1(num: soundJson.pitch.FANFARE1_NUM_L);        // ファンファーレ1音の種類
    soundFileInfo2.setFanfare2(num: soundJson.pitch.FANFARE2_NUM_L);        // ファンファーレ2音の種類
    soundFileInfo2.setFanfare3(num: soundJson.pitch.FANFARE3_NUM_L);        // ファンファーレ3音の種類
    soundFileInfo2.setVerifone(num: soundJson.pitch.VERIFONE_NUM_L);        // Verifone音の種類
    soundFileInfo2.setBirth(num: soundJson.pitch.BIRTH_NUM_L);              // 記念日音の種類
    soundVolumeInfo2.setTap(volume: soundJson.volume.G1L);                  // タッチ音
    soundVolumeInfo2.setError(volume: soundJson.volume.ERR_L);              // エラー音
    soundVolumeInfo2.setWarning(volume: soundJson.volume.WARN_L);           // 警告音
    soundVolumeInfo2.setPopup(volume: soundJson.volume.POPUP_L);            // ポップアップ音
    soundVolumeInfo2.setFanfare1(volume: soundJson.volume.FANFARE1_L);      // ファンファーレ1音
    soundVolumeInfo2.setFanfare2(volume: soundJson.volume.FANFARE2_L);      // ファンファーレ2音
    soundVolumeInfo2.setFanfare3(volume: soundJson.volume.FANFARE3_L);      // ファンファーレ3音
    soundVolumeInfo2.setVerifone(volume: soundJson.volume.VERIFONE_L);      // Verifone音
    soundVolumeInfo2.setBirth(volume: soundJson.volume.BIRTH_L);            // 記念日音
    soundVolumeInfo2.setGuidance(volume: soundJson.guidance.left_volume);   // ガイダンス音声の音量
  }
}

/// 音量とバランス
class SoundVolume {
  const SoundVolume({required this.volume, required this.balance});
  final double volume;          // 音量
  final double balance;         // バランス
}
