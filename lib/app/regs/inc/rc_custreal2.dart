/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 日立仕様 通信処理区分リスト
/// 関連tprxソース:rc_custreal2.h - enum CUSTREAL2_HI;
enum CustReal2Hi {
  CUSTREAL2_HI_MBR_INQ, // 会員情報照会
  CUSTREAL2_HI_MBR_CHG, // 会員情報更新
  CUSTREAL2_HI_MBR_JOIN, // 会員統合
  CUSTREAL2_HI_MBR_ADD, // ﾎﾟｲﾝﾄ付与
  CUSTREAL2_HI_MBR_ADD_CNCL, // ﾎﾟｲﾝﾄ付与ｷｬﾝｾﾙ
  CUSTREAL2_HI_MBR_USE, // ﾎﾟｲﾝﾄ利用
  CUSTREAL2_HI_MBR_USE_CNCL, // ﾎﾟｲﾝﾄ利用ｷｬﾝｾﾙ
  CUSTREAL2_HI_MBR_HIST, // ﾎﾟｲﾝﾄ履歴照会
  CUSTREAL2_HI_EC_INQ, // EC受注明細取得
  CUSTREAL2_HI_EC_UPD, // EC店舗受取更新
  CUSTREAL2_HI_EC_CNCL, // EC店舗受取ｷｬﾝｾﾙ
  CUSTREAL2_HI_USD_INQ, // 中古商品照会
  CUSTREAL2_HI_KB_HIST, // 購買履歴情報取得
  CUSTREAL2_HI_CPN_UPDPRN, // ｸｰﾎﾟﾝ発行履歴更新
  CUSTREAL2_HI_CPN_UPDUSE, // ｸｰﾎﾟﾝ使用履歴更新
  CUSTREAL2_HI_CPN_SNDPRN, // ｸｰﾎﾟﾝ発行ﾌｧｲﾙ出力
  CUSTREAL2_HI_CHK_CPN_INFO, // ｸｰﾎﾟﾝ利用可否判定
  CUSTREAL2_HI_RIYO_CPN_INFO, // 利用ｸｰﾎﾟﾝ照会
  CUSTREAL2_HI_CPN_DELETE, // ｸｰﾎﾟﾝ使用履歴削除
  CUSTREAL2_HI_MBR_SEARCH, // 会員情報検索（電話番号検索）
  CUSTREAL2_HI_GET_CPN_INFO, // クーポン照会
  CUSTREAL2_HI_MBR_ADD_ERROR, // ポイント付与（エラー）
  CUSTREAL2_HI_MBR_USE_ERROR, // ポイント利用（エラー）
}