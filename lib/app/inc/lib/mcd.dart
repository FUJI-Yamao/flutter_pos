/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  File used include files
///  関連tprxソース: mcd.h
class Mcd {
/************************************************************************/
/*                      Magnetic Card efinition                         */
/************************************************************************/
  static const MCD_CNT = 72;
  static const YEAR_BASE = 1900;
  static const MONTH_BASE = 1;
  static const ASC_MCD_CD = 8;
  static const ASC_MBR_CD = 13;

  // MEMO:日向　マクロ定義のため、ASC_MBR_CDがソースで書かれているところをcm_mbrcd_len()に置き換えてください.
  //  static const  ASC_MBR_CD  = cm_mbrcd_len()

  static const FMT_TYP_MBR = 3;
  static const FMT_NO_MBR8 = 10;
  static const FMT_NO_MBR8_2 = 11;
  static const FMT_NO_MBR13 = 135;
  static const DEF_MBRCD_LEN = 13;
  // TODO:10036 コンパイルスイッチ(ARCS_MBR)
  static const MBRCD16_LEN = 16;
  static const ASC_MCD_CD_MBR16 = 12;
  // -----------------

/************************************************************************/
/*            CARD Format Type [c_cust_trm_mst.mag_card_typ]            */
/************************************************************************/

  static const TERAOKA = 0;
  static const OTHER_CO = 99;
  static const OTHER_CO1 = 98;
  static const OTHER_CO2 = 97;
  static const OTHER_CO3 = 96;
  static const OTHER_CO4 = 95;
  static const OTHER_CO5 = 94;
  static const OTHER_CO6 = 93;
  static const OTHER_CO7 = 92;

  /************************************************************************/
  /*            RALSE System                                              */
  /************************************************************************/
  static const int MCD_RLSCKCDST = 7;
  static const int MCD_RLSCKCRDTCDST = 44;
  static const String MCD_RLSSTAFFCD = "9999";
  static const String MCD_RLSCARDCD = "5256";
  static const String MCD_RLSCRDTCD = "9661";
  static const String MCD_RLSCRDTCD2 = "65256";
  static const int MCD_RLSOTHER_RALSE_CREDIT = 4;
  static const int MCD_RLSOTHER = -1;
  static const int MCD_RLSSTAFF = 1;
  static const int MCD_RLSCARD = 2;
  static const int MCD_RLSCRDT = 3;
  static const int MCD_RLSCRDTONLY = 9;
  static const int MCD_RLSCKVISACDST = 44;
  static const String MCD_RLSVISACD = "9663";
  static const String MCD_RLSVISACD2 = "65256";
  static const int MCD_RLSVISA = 5;
  static const int MCD_RLSHOUSE = 6;
  static const int MCD_RLSPREPAID = 7;
  static const int MCD_RLSJACCS = 8;  //12Verから移植
  static const String MCD_RLSJACCSCD = "9110";  //12Verから移植
  static const String MCD_RLSJACCSCD2 = "65256";  //12Verから移植
  static const int MCD_RLSCKJACCSCDST = 44;
}

/// 関連tprxソース: \mcd.h - enum
enum TS3 {
  OTH_CRDT(0),
  TS3_CRDT(1),
  TS3_DAIKI_MBR_CRDT(2);

  final int value;
  const TS3(this.value);
}

/// 関連tprxソース: mcd.h - NSMT_MBR_TYPE
enum NsmtMbrType {
  NONE(0),
  OTHER_PONTA(1),	    /* 他社Ponta */
  NSMT_PONTA(2),		  /* ニシムタPonta */
  NSMT_PONTAJCB(3),		/* ニシムタPontaJCB */
  JACCS_PONTA(4),		  /* JACCSPontaクレジット */
  OTHER_PONTA_CRDT(5);	/* 他社Pontaクレジット */

  final int value;
  const NsmtMbrType(this.value);
}
