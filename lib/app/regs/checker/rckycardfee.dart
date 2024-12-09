/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RckyCardFee {
  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// カード有効期限を更新する
  /// 引数:[nowValidDate] 設定する日時
  /// 戻り値: カード有効期限
  /// 関連tprxソース: rcmbrfsplevel.c - rcmbr_ValiDate_Update
  static String rcmbrValiDateUpdate(String nowValidDate) {
    return nowValidDate;
  }
}