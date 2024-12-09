/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


/// 関連tprxソース:rccatalina.h
class RcCatalinaDef {
/*-----  デファイン                        -----*/
  static const String	CA_NAME	= "CATALINA";
  static const int CA_VERSION = 0x20;

  static const int CA_MSG_REGSTART = 0x30;
  static const int CA_MSG_ITEM = 0x31;
  static const int CA_MSG_SINONOFF = 0x32;
  static const int CA_MSG_STLTTL = 0x33;
  static const int CA_MSG_SPTEND = 0x34;
  static const int CA_MSG_REGEND = 0x35;
  static const int CA_MSG_SUSPEND = 0x37;
  static const int CA_MSG_MBR = 0x38;
  static const int CA_MSG_PRCCHG = 0x3a;
  static const int CA_MSG_COUPON = 0x3b;

  static const int CA_SPMSG_REGSTART = 0x00;
  static const int CA_SPMSG_ITEM = 0x05;
  static const int CA_SPMSG_SINONOFF = 0x02;
  static const int CA_SPMSG_STLTTL = 0x01;
  static const int CA_SPMSG_SPTEND = 0x00;
  static const int CA_SPMSG_REGEND = 0x03;
  static const int CA_SPMSG_SUSPEND = 0x00;
  static const int CA_SPMSG_MBR = 0x01;
  static const int CA_SPMSG_PRCCHG = 0x00;
  static const int CA_SPMSG_COUPON = 0x01;

  static const int CA_ST_CASHIER = 0x01;
  static const int CA_ST_CHECKER = 0x02;

  static const int CA_ACT_SINON = 0x00;
  static const int CA_ACT_SINOFF = 0x01;

  static const int CA_REG_MODE1 = 0x00;
  static const int CA_REG_MODE2 = 0x01;
  static const int CA_REG_MODETR = 0x02;

  static const int CA_TYP_CHASH = 0x00;
  static const int CA_TYP_STLDSC = 0x01;
  static const int CA_TYP_STLPDSC = 0x02;

  static const String CA_STLDSC_CD = "988";
  static const String CA_STLPDSC_CD = "987";
}