/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// サウンド関連の定義
class SoundDef {
  /// assetsフォルダ名
  static const String assetsPath = 'assets/'; // assetsフォルダの場合は、「\」でなく、「/」でないとダメ
  /// 音声ファイルのフォルダ名
  static const String soundPath = 'sound';

  /// 拡張子
  static const String extWav = '.wav';

  /// ファイル名(番号付き)
  static const String preTapFile = 'plus/click_'; // タッチ音
  static const String preErrFile = 'plus/err_'; // エラー音
  static const String preWarnFile = 'plus/warning_'; // 警告音
  static const String prePopupFile = 'plus/popup_'; // ポップアップ音
  static const String preFnfl1File = 'plus/fanfare1_'; // ファンファーレ1音
  static const String preFnfl2File = 'plus/fanfare2_'; // ファンファーレ2音
  static const String preFnfl3File = 'plus/fanfare3_'; // ファンファーレ3音
  static const String preVerifoneFile = 'plus/verifone_'; // Verifone音
  static const String preBirthFile = 'plus/birth_'; // 記念日音

  /// デフォルトの番号
  static const int defTapNum = 1; // タッチ音
  static const int defErrNum = 1; // エラー音
  static const int defWarnNum = 1; // 警告音
  static const int defPopupNum = 1; // ポップアップ音
  static const int defFnfl1Num = 1; // ファンファーレ1音
  static const int defFnfl2Num = 1; // ファンファーレ2音
  static const int defFnfl3Num = 1; // ファンファーレ3音
  static const int defVerifoneNum = 1; // Verifone音
  static const int defBirthNum = 1; // 記念日音

  /// ファイル名(固定)
  static const String jingleBellsFile = 'plus/jgbell.wav'; // ジングルベル
  static const String initFile =
      'plus/init.wav'; // 現POSでは起動画面から開設を経由しないで遷移させるとき（メンテナンス操作）に鳴る音？
  static const String zhqFanfareFile = 'plus/zhq_fanfare.wav'; // ZHQ用のファンファーレ
  static const String zhqPuFile = 'plus/err_14_Z.wav'; // ZHQ用のエラー音？
  static const String fanfare1_3File = 'plus/fanfare1_3.wav'; // ファンファーレ音
  static const String ageCautionFile = 'plus/snd_0110.wav'; // 年齢確認の警告音

  /// ガイダンス音声のサンプル音
  static const String guidanceSampleFile = 'snd_6003.wav'; // ガイダンス音声のサンプル音

  /// ガイダンス音声のwait
  static const int guidanceWait = 300;

  /// フルセルフのガイダンス音声
  static const String guidanceFullSelfStart = 'snd_6546.wav';         // フルセルフのスタート画面で流れるガイダンス音声
  static const String guidanceFullSelfRegister = 'snd_6503.wav';      // フルセルフの商品登録画面で流れるガイダンス音声
  static const String guidanceFullSelfRegisterAfter = 'snd_6522.wav'; // フルセルフの商品登録画面で商品登録後に流れるガイダンス音声
  static const String guidanceFullSelfSelectPay = 'snd_6129.wav';     // フルセルフの支払い方法選択画面で流れるガイダンス音声
  static const String guidanceFullSelfPayComplete = 'snd_6133.wav';   // フルセルフ取引完了画面で流れるガイダンス音声

  /// ガイダンス音声の繰り返し出力時のインターバル
  static const int guidanceRepeatInterval = 2000;

  /// フルセルフのガイダンス音声番号
  static const int guidanceFullSelfStartNumber = 6546;         // フルセルフのスタート画面で流れるガイダンス音声番号
  static const int guidanceFullSelfRegisterNumber = 6503;      // フルセルフの商品登録画面で流れるガイダンス音声番号
  static const int guidanceFullSelfRegisterAfterNumber = 6522; // フルセルフの商品登録画面で商品登録後に流れるガイダンス音声番号
  static const int guidanceFullSelfSelectPayNumber = 6129;     // フルセルフの支払い方法選択画面で流れるガイダンス音声番号
  static const int guidanceFullSelfPayNumber = 6180;           // フルセルフ取引現金入金画面で流れるガイダンス音声番号
  static const int guidanceFullSelfPayChangeNumber = 6179;     // フルセルフ取引現金入金後の画面で流れるガイダンス音声番号
  static const int guidanceFullSelfPayCompleteNumber = 6133;   // フルセルフ取引完了画面で流れるガイダンス音声番号

  /// フルセルフのガイダンス音声のファイル名の先頭
  static const String fselfSoundFileHead = 'snd'; // フルセルフのガイダンス音声のファイル名の先頭

  /// 言語ごとの音声ファイルにつく文字列
  /// 参考：rcky_langchg.h
  static const String fselfLangEx = 'ex'; // 英語
  static const String fselfLangChn = 'chn'; // 中国語
  static const String fselfLangKor = 'kor'; // 韓国語
}

/// 音の種類
/// 関連tprxソース:if_spk.h
/// playSound関数で指定するパラメータ
/// タッチ音（BUZZER_PI）は、playTapSound関数を使用すること
enum SoundKind {
  tap(SoundVolumeKind.tap), // タッチ音（BUZZER_PI）は、playTapSound関数を使用すること
  error(SoundVolumeKind.error), // エラー音（BUZZER_PI_PO/BUZZER_PIPIPI）
  warning(SoundVolumeKind.warning), // 警告音（BUZZER_WARNING）
  popup(SoundVolumeKind.popup), // ポップアップ音（BUZZER_POPUP）
  fanfare1(
      SoundVolumeKind.fanfare1), // ファンファーレ1音（SPK_MUSIC_FANFARE/MUSIC_FANFARE）
  fanfare2(SoundVolumeKind
      .fanfare2), // ファンファーレ2音（SPK_MUSIC_FANFARE2/SPK_MUSIC_FANFARE2）
  fanfare3(
      SoundVolumeKind.fanfare3), // ファンファーレ3音（SPK_MUSIC_FANFARE3/MUSIC_FANFARE3）
  verifone(
      SoundVolumeKind.verifone), // verifone音（SPK_MUSIC_VERIFONE/MUSIC_VERIFONE）
  birth(SoundVolumeKind.birth), // 誕生日音（SPK_MUSIC_BIRTHDAY/MUSIC_BIRTHDAY）
  jingleBells(SoundVolumeKind.tap), // ジングルベル（SPK_MUSIC_J_BELL/MUSIC_J_BELL）
  init(SoundVolumeKind
      .tap), // 現POSでは起動画面から開設を経由しないで遷移させるとき（メンテナンス操作）に鳴る音？（BUZZER_INIT）
  zhqFanfare(SoundVolumeKind.tap), // ZHQ用のファンファーレ（SPK_MUSIC_ZHQ_FANFARE）
  zhqPu(SoundVolumeKind.tap), // ZHQ用のエラー音？（BUZZER_ZHQ_PU）
  fanfare1_3(SoundVolumeKind.tap); // ファンファーレ音（MUSIC_FANFARE1_3）

  final SoundVolumeKind soundVolumeKind; // 使用する音量を紐付け
  const SoundKind(this.soundVolumeKind);
}

/// 音量の種類
/// 関連tprxソース:inc\lib\cm_sound.h
enum SoundVolumeKind {
  tap, // タッチ音（メイン音量）
  error, // エラー音
  warning, // 警告音
  popup, // ポップアップ音
  fanfare1, // ファンファーレ1音
  fanfare2, // ファンファーレ2音
  fanfare3, // ファンファーレ3音
  verifone, // verifone音
  birth, // 誕生日音
  // designated,  // 現POSでも使用していないので、新POSでも実装しない
  guidance, // ガイダンス音声
  // stereo,      // 現POSではKY_SINGLE（１人制）の時にステレオにしている。新POSではKY_SINGLEをなくす予定なので実装しない
}
