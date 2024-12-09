/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 音量情報
class SoundVolumeInfo {

  /// コンストラクタ
  SoundVolumeInfo();

  /// タッチ音
  late double _tap;
  double get tap => _tap;

  /// エラー音
  late double _error;
  double get error => _error;

  /// 警告音
  late double _warning;
  double get warning => _warning;

  /// ポップアップ音
  late double _popup;
  double get popup => _popup;

  /// ファンファーレ音
  late double _fanfare1;
  double get fanfare1 => _fanfare1;
  late double _fanfare2;
  double get fanfare2 => _fanfare2;
  late double _fanfare3;
  double get fanfare3 => _fanfare3;

  /// Verifone音
  late double _verifone;
  double get verifone => _verifone;

  /// 記念日音
  late double _birth;
  double get birth => _birth;

  /// ガイダンス音声の音量
  late double _guidance;
  double get guidance => _guidance;

  /// タッチ音の設定
  void setTap({
    required int volume,  // 音量
  }) {
    _tap = _convertVolume(volume);
  }

  /// エラー音の設定
  void setError({required int volume}) {
    _error = _convertVolume(volume);
  }

  /// 警告音の設定
  void setWarning({required int volume}) {
    _warning = _convertVolume(volume);
  }

  /// ポップアップ音の設定
  void setPopup({required int volume}) {
    _popup = _convertVolume(volume);
  }

  /// ファンファーレ1音の設定
  void setFanfare1({required int volume}) {
    _fanfare1 = _convertVolume(volume);
  }

  /// ファンファーレ2音の設定
  void setFanfare2({required int volume}) {
    _fanfare2 = _convertVolume(volume);
  }

  /// ファンファーレ3音の設定
  void setFanfare3({required int volume}) {
    _fanfare3 = _convertVolume(volume);
  }

  /// Verifone音の設定
  void setVerifone({required int volume}) {
    _verifone = _convertVolume(volume);
  }

  /// 記念日音の設定
  void setBirth({required int volume}) {
    _birth = _convertVolume(volume);
  }

  /// ガイダンス音声の音量の設定
  void setGuidance({required int volume}) {
    _guidance = _convertVolume(volume);
  }

  /// 音量値のコンバート
  /// SoundJsonFileで音量を保持しているint型をAudioPlayerで使用するdouble型に変換する
  double _convertVolume(int volume) {
    /// AudioPlayerの音量
    /// 0 はミュート、
    /// 1 は最大音量です。
    /// 0 と 1 の間の値は線形補間されます。
    return volume / 100.0;
  }
}
