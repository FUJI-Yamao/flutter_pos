/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///
/// 関連tprxソース: if_suica.h - struct NIMOCA_DATA

class NimocaData {
  String cardIdi = "";  /* カードIDi  */
  String cardType = "";  /* カード区分 */
  int rctId = 0;  /* 一件明細ID */
  int actCd = 0;  /* 活性化事業者コード */
  int subCd = 0;  /* サブコード */
  int price = 0;  /* 売上金額   */
  int point = 0;  /* ポイント数 */
}

/// 関連tprxソース: if_suica.h
class IfSuica{
  /// Auto Coin Changer Common Definition
  static const STX = 0x02;
  static const DC1 = 0x11;
  static const ETX = 0x03;
  static const ENQ = 0x05;
  static const DLE = 0x10;

  static const ACK = 0x06;
  static const NAK = 0x15;
  static const CAN = 0x18;		/* Abnormal End */
  static const ETB = 0x17;		/* Near End */
  static const DC3 = 0x13;
  static const SUB = 0x1A;		/* Active */
  static const BON = 0x1C;		/* Active */
  static const DC4 = 0x14;
}