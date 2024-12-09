/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  MEMO:validFlg short->bool
///
/// クレジット：ステータスデータ
/// 関連tprxソース:c_crdt_actual_log_sts.h

class T400000Sts {
  bool validFlg = false;
  int crdtNo = 0;
  int ttlLvl = 0;
  int demand1stYyMm = 0;
  int saleYyMmDd = 0;
  int salePrice = 0;
  int taxPostage = 0;
  String filler = '';
  int bonusMonthSign = 0;
  int bonus1stYyMm = 0;
  int itemCd = 0;
  int chaCnt1 = 0;
  int chaAmt1 = 0;
  int chaCnt2 = 0;
  int chaAmt2 = 0;
  int chaCnt4 = 0;
  int chaAmt4 = 0;
  int chaCnt5 = 0;
  int chaAmt5 = 0;
  int chaCnt6 = 0;
  int chaAmt6 = 0;
  int chaCnt7 = 0;
  int chaAmt7 = 0;
  int chaCnt8 = 0;
  int chaAmt8 = 0;
  int chaCnt9 = 0;
  int chaAmt9 = 0;
  int chaCnt10 = 0;
  int chaAmt10 = 0;
  int cnclReason = 0;
  int sellSts = 0;
  int sellKind = 0;
  int saleKind = 0;
  String seqInqNo = '';
  String mngPosNo = '';
  String seqPosNo = '';
  int divCom = 0;
  int judgCd = 0;
  int sign = 0;
  String reqCode = '';
  String handleDiv = '';
  int cardKind = 0;
  int compCode = 0;
  int crdtNonPrn = 0;
  String cardJis1 = '';
  String cardJis2 = '';
}
