/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: if_masr.h - enum MASR_RES
enum MasrRes {
  MASR_RES_NORMAL(0),
  MASR_RES_CARD_NONE(1),
  MASR_RES_CARD_GATE(2),
  MASR_RES_CARD_IN(3),
  MASR_RES_STOP_OK(4),
  MASR_RES_SENDERR(8000),
  MASR_RES_FINDFDSERR(8001),
  MASR_RES_PARAMERR(8002),
  MASR_RES_CMDNOTFNDERR(8003),
  MASR_RES_UNKNOWNERR(8004),
  MASR_RES_ANSWRERR(8005),
  MASR_RES_CMD_DIFF_ERR(9000),	/* Another Command Responce Error */
  MASR_RES_CMD_ERR(9001),		/* Command Error */
  MASR_RES_WITHDROWTOUT_ERR(9002),	/* With Draw Time Out Error */
  MASR_RES_JAM_ERR(9003),		/* Card Jam Error */
  MASR_RES_SHUTTER_ERR(9004),		/* Shutter Error */
  MASR_RES_CARD_ERR(9005),		/* Card Error */
  MASR_RES_CARD_POSI_ERR(9006),		/* Card Position Error */
  MASR_RES_2CARD_ERR(9007),		/* 2 Card Error */
  MASR_RES_READ_ERR(9008),		/* Read Error */
  MASR_RES_OFFLINE(9009),		/* OFFLINE */
  MASR_RES_INIT_ERR(9010),		/* Not Exec Initial Command Error */
  MASR_RES_STOP_ERR(9011),		/* Stop Error */
  MASR_RES_OTHER_ERR(9012),		/* Other Error */
  MASR_RES_TIMEOUT_ERR(9013);		/* Timeout Error */

  final int value;
  const MasrRes(this.value);
}
