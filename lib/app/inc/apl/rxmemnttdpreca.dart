/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// NTT DATA Precaタスクステータス - 受信データ
/// 関連tprxソース:rxmemnttdpreca.h - struct RXMEMNTTDPRECA_RX
class RxMemNttdPrecaRx {
  int trnCd = 0;
  int ssCd = 0;
  int dnpCd = 0;
  String dispDate = "";
  int money = 0;
  int rednpCd = 0;
  String errCd = "";
  int cvvChk = 0;
  int cvv = 0;
  String valDate = "";
  int zan = 0;
  String cpnValds = "";
  String cpnValde = "";
  int cpnZan = 0;
  String pcTime = "";
  int pcserNo = 0;
  String cardId = "";
  int schemeId = 0;
  int corpId = 0;
  int shopId = 0;
  int termType = 0;
  String termId = "";
  int format = 0;
  int privType = 0;
  int givePriv = 0;
  int usePriv = 0;
  int privZan = 0;
  int privStg = 0;
  int msgFlg = 0;
  int zanBefore = 0;
}

/// NTT DATA Precaタスクステータス - 送信データ
/// 関連tprxソース:rxmemnttdpreca.h - struct RXMEMNTTDPRECA_TX
class RxMemNttdPrecaTx {
  int trnCd = 0;
  int ssCd = 0;
  int dnpCd = 0;
  String dispdate = "";
  int money = 0;
  int rednpCd = 0;
  int bizCd = 0;
  int entCd = 0;
  int cvv = 0;
  int cstax = 0;
  int cpn = 0;
  int cvvTry = 0;
  int persCd = 0;
  int goods1 = 0;
  int goods2 = 0;
  int goods3 = 0;
  int goods4 = 0;
  int goods5 = 0;
  String ppTime = "";
  int ppserNo = 0;
  String cardId = "";
  int schemeId = 0;
  int corpId = 0;
  int termType = 0;
  String termId = "";
  int format = 0;
  int usePriv = 0;
  String reqTime = "";
}