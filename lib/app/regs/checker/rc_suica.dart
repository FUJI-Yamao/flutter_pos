/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: rc_suica.h - 構造体SUICAPROCNO
enum SuicaProcNo {
  SUICA_NOT_ORDER,
  SUICA_COMMUNICATE_REF,
  SUICA_COMMUNICATE_READ,
  SUICA_COMMUNICATE_CNCL,
  SUICA_COMREF_GET,
  SUICA_COMREAD_GET,
  SUICA_COMCNCL_GET,
  SUICA_COMREF_FIN,
  SUICA_COMREAD_FIN,
  SUICA_COMCNCL_FIN,
  SUICA_ID_SET,
  SUICA_INFO_READ,
  SUICA_RESET,
  SUICA_NG_START,
  SUICA_NG_READ,
  SUICA_SELF_CHK,
  SUICA_STAT_READ,
  SUICA_OPEN,
  SUICA_CLOSE,
  SUICA_DETAIL,
  SUICA_INFO_CHK,
  SUICA_INFO_CHK_TASK,
  SUICA_INFO_OK,
  SUICA_REF_READ,
  SUICA_REF_READ_GET,
  SUICA_REF_READ_CHK,
  SUICA_REF_READ_GET_OK,
  SUICA_READ,
  SUICA_READ_GET,
  SUICA_READ_CHK,
  SUICA_READ_GET_OK,
  SUICA_CNCL,
  SUICA_CNCL_CHK,
  SUICA_CNCL_GET,
  SUICA_FINISH,
  SUICA_CONNECT_START,
  SUICA_CONNECT,
  SUICA_CONNECT_GET,
  SUICA_CONNECT_CHK1,
  SUICA_CHK1_GET,
  SUICA_CONNECT_CHK2,
  SUICA_CHK2_GET,
  SUICA_CONNECTGET_OK,
  SUICA_DETAIL_CHK,
  SUICA_DETAIL_OK,
  SUICA_RETRY_READ,
  SUICA_RETRY_CNCL,
  SUICA_DETAIL_TASK,
  SUICA_DETAIL_TIME,
  SUICA_OPNCLS,
  SUICA_TIME_READ_GET,
  SUICA_COMREF_RETRY,
  SUICA_COMREAD_RETRY,
  SUICA_COMCNCL_RETRY,
  SUICA_CONNECT_RETRY,
  SUICA_CONNECT_RETRYGET,
  SUICA_CONNECT_START1,
  SUICA_CONNECT_START2,
  SUICA_BEFORE_CONNECT,
  SUICA_BEFORE_CONNECTGET,
  SUICA_CONNECT_BFCHK1,
  SUICA_CHK1_BFGET,
  SUICA_CONNECT_BFCHK2,
  SUICA_CHK2_BFGET,
  SUICA_LACK_FINAL,
  SUICA_RETRY_FINISH,
  SUICA_SENSE_READ_GET,
  SUICA_SENSE_GET_OK,
  SUICA_SENSE_START,
  SUICA_SENSE_INFO_GET,
  SUICA_POINT,
  SUICA_POINT_GET,
  SUICA_UNKNOWN,
  SUICA_REFER,
  SUICA_REFER_OK,
  SUICA_REFER_NO;
}