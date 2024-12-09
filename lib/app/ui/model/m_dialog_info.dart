/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// ダイアログ表示情報
class DialogInfo{
  DialogInfo({
    this.messages = "",
    this.titleImgCd = 0,
    this.title = "",
    this.titleColorCd = 0,
    this.result = false,
  });

  /// 表示メッセージ
  String messages;
  /// タイトル文字列のimg_cd
  int titleImgCd;
  /// タイトル
  String title;
  /// タイトル色のコード
  int titleColorCd;
  /// DB取得結果
  /// false：取得失敗、true：取得成功
  bool result;
}
