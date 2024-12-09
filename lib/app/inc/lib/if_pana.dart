/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 標準カードデータ構造体
/// 関連tprxソース: if_pana.h - struct PANA_DATA
class PanaData {
  String cardId = "";  /* カードID             */
  String businessCd = "";  /* 業態コード           */
  String scrtNo = "";  /* 暗証番号             */
  int compCd = 0;  /* 企業コード           */
  String mbrCd = "";  /* 顧客No.              */
  int spterm = 0;  /* 最新累計ポイント     */
  String splDay = "";  /* 最新更新年月日       */
  String lmtDay = "";  /* カード管理費有効期限 */
  int ttlPurPrc = 0;  /* 累計購入金額 */
}

/// 標準カードデータ構造体
/// 関連tprxソース: if_pana.h - struct PANA_RAINBOW_DATA
class PanaRainbowData {
  String mbrCd = "";
  int spterm = 0;
  String splDay = "";
  String jis2 = "";
  int typ = 0;  /* 0:組合 1:組合+クレジット 2:クレジット */
  int cardTyp = 0;  /* 0:現行ｶｰﾄﾞ 1:ﾚｲﾝﾎﾞｰ21 2:ﾚｲﾝﾎﾞｰ21ｼﾆｱ 3:ﾚｲﾝﾎﾞｰ21本証 4:ﾚｲﾝﾎﾞｰ21家族証 5:クレジット */
}

/// 松源様向け構造体
/// 関連tprxソース: if_pana.h - struct PANA_MATSUGEN_DATA
class PanaMatsugenData {
  String mbrCd = "";
  int totalPoint = 0;
  int type = 0;
}