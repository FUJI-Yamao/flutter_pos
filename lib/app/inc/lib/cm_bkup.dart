/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: cm_bkup.h

/// 関連tprxソース: bkup.c - dbtbl_no
enum DbtblNo
{
	C_CUST_MST(0, "c_cust_mst"),
	S_CUST_TTL_TBL(1, "s_cust_ttl_tbl"),
	S_CUST_CPN_TBL(2, "s_cust_cpn_tbl"),
	S_CUST_LOY_TBL(3, "s_cust_loy_tbl");

  final int idx;
  final String name;
  const DbtblNo(this.idx, this.name);
}

/// 関連tprxソース: bkup.h - BKUP_KIND
enum BkupKind
{
  BU_RECOVER,
  BU_INIT,
  BU_CLOSE,
  BU_CLR,
  BU_LEVEL,
  BU_POINT,
  BU_SELECT,
  BU_CUSTCLR,
  BU_P_CLR
}

class CmBkup {
  static const String WORKDIR = "/tmp/cust/";
  static const String Q_BACKUP = "copy %s to '%s' delimiters ',' WITH NULL AS '';";
  static const String Q_RECOVER = "copy %s from '%s' delimiters ',' WITH NULL AS '';";
  static const String Q_TRUNCATE = "truncate %s;";
  static const String SYS_CHMOD = "chmod a+w %s%s";

  // 顧客ENQ群のクリア
  static const String SQL_CUST_CURSOR = "cust_cursor ";

  // s_cust_ttl_tbl
  static const String SQL_CLR_SET_CUST_TTL = "UPDATE %s SET "
    "acct_cd_1='0', acct_totalpnt_1='0', acct_totalamt_1='0', acct_totalqty_1='0', "
    "acct_cd_2='0', acct_totalpnt_2='0', acct_totalamt_2='0', acct_totalqty_2='0', "
    "acct_cd_3='0', acct_totalpnt_3='0', acct_totalamt_3='0', acct_totalqty_3='0', "
    "acct_cd_4='0', acct_totalpnt_4='0', acct_totalamt_4='0', acct_totalqty_4='0', "
    "acct_cd_5='0', acct_totalpnt_5='0', acct_totalamt_5='0', acct_totalqty_5='0', "
    "month_amt_1='0', month_amt_2='0', month_amt_3='0', month_amt_4='0', month_amt_5='0', month_amt_6='0', "
    "month_amt_7='0', month_amt_8='0', month_amt_9='0', month_amt_10='0',month_amt_11='0', month_amt_12='0', "
    "month_visit_date_1=NULL, month_visit_date_2=NULL, month_visit_date_3=NULL, month_visit_date_4=NULL, month_visit_date_5=NULL, month_visit_date_6=NULL, "
    "month_visit_date_7=NULL, month_visit_date_8=NULL, month_visit_date_9=NULL, month_visit_date_10=NULL, month_visit_date_11=NULL, month_visit_date_12=NULL, "
    "month_visit_cnt_1='0', month_visit_cnt_2='0', month_visit_cnt_3='0', month_visit_cnt_4='0', month_visit_cnt_5='0', month_visit_cnt_6='0', "
    "month_visit_cnt_7='0', month_visit_cnt_8='0', month_visit_cnt_9='0', month_visit_cnt_10='0', month_visit_cnt_11='0', month_visit_cnt_12='0', "
    "bnsdsc_amt='0', bnsdsc_visit_date=NULL, ttl_amt='0', delivery_date=NULL, last_visit_date=NULL, portal_flg='0', "
    "enq_comp_cd='0', enq_stre_cd='0', enq_mac_no='0', enq_datetime=NULL, cust_status='0', "
    "sch_acct_cd_1='0', acct_accval_1='0', acct_optotal_1='0', "
    "sch_acct_cd_2='0', acct_accval_2='0', acct_optotal_2='0', "
    "sch_acct_cd_3='0', acct_accval_3='0', acct_optotal_3='0', "
    "sch_acct_cd_4='0', acct_accval_4='0', acct_optotal_4='0', "
    "sch_acct_cd_5='0', acct_accval_5='0', acct_optotal_5='0',  "
    "upd_datetime='now', upd_user='999999' "
    "WHERE comp_cd='%ld' %s ;";

  static const String SQL_PCLR_SET_CUST_TTL = "UPDATE %s SET "
    "acct_cd_1='0', acct_totalpnt_1='0', acct_totalamt_1='0', acct_totalqty_1='0', "
    "acct_cd_2='0', acct_totalpnt_2='0', acct_totalamt_2='0', acct_totalqty_2='0', "
    "acct_cd_3='0', acct_totalpnt_3='0', acct_totalamt_3='0', acct_totalqty_3='0', "
    "acct_cd_4='0', acct_totalpnt_4='0', acct_totalamt_4='0', acct_totalqty_4='0', "
    "acct_cd_5='0', acct_totalpnt_5='0', acct_totalamt_5='0', acct_totalqty_5='0', "
    "month_amt_1='0', month_amt_2='0', month_amt_3='0', month_amt_4='0', month_amt_5='0', month_amt_6='0', "
    "month_amt_7='0', month_amt_8='0', month_amt_9='0', month_amt_10='0',month_amt_11='0', month_amt_12='0', "
    "month_visit_date_1=NULL, month_visit_date_2=NULL, month_visit_date_3=NULL, month_visit_date_4=NULL, month_visit_date_5=NULL, month_visit_date_6=NULL, "
    "month_visit_date_7=NULL, month_visit_date_8=NULL, month_visit_date_9=NULL, month_visit_date_10=NULL, month_visit_date_11=NULL, month_visit_date_12=NULL, "
    "month_visit_cnt_1='0', month_visit_cnt_2='0', month_visit_cnt_3='0', month_visit_cnt_4='0', month_visit_cnt_5='0', month_visit_cnt_6='0', "
    "month_visit_cnt_7='0', month_visit_cnt_8='0', month_visit_cnt_9='0', month_visit_cnt_10='0', month_visit_cnt_11='0', month_visit_cnt_12='0', "
    "bnsdsc_amt='0', bnsdsc_visit_date=NULL, ttl_amt='0', portal_flg='0', "
    "enq_comp_cd='0', enq_stre_cd='0', enq_mac_no='0', enq_datetime=NULL, "
    "upd_datetime='now', upd_user='999999' "
    "WHERE comp_cd='%ld' %s ;";

  // s_cust_cpn_tbl
  static const String SQL_GET_CUST_CPN = "DECLARE %s CURSOR FOR SELECT "
    "cust_no, cpn_id, array_length(cpn_data,1)  AS cnt1, array_length(print_flg,1)  AS cnt2 "
    "FROM %s "
    "WHERE comp_cd='%ld' %s "
    "GROUP BY cust_no, cpn_id, cpn_data, print_flg;";

  // s_cust_cpn_tbl
  static const String SQL_CLR_SET_CUST_CPN = "UPDATE %s SET "
    "print_datetime = NULL, prn_comp_cd='0', prn_stre_cd='0', prn_mac_no='0', prn_staff_cd='0', prn_datetime=NULL, tday_cnt='0', total_cnt='0', "
    "upd_datetime='now', upd_user='999999' "
    "WHERE cust_no='%.20s' AND cpn_id='%.11s' AND comp_cd='%ld';";

  // s_cust_loy_tbl
  static const String SQL_GET_CUST_LOY = "DECLARE %s CURSOR FOR SELECT "
    "cust_no, cpn_id, array_length(tday_cnt,1)  AS cnt1, array_length(total_cnt,1)  AS cnt2 "
    "FROM %s "
    "WHERE comp_cd='%ld' %s "
    "GROUP BY cust_no, cpn_id, tday_cnt, total_cnt;";

  // s_cust_loy_tbl
  static const String SQL_CLR_SET_CUST_LOY = "UPDATE %s SET "
    "%s %s last_sellday = NULL "
    "upd_datetime='now', upd_user='999999' "
    "WHERE cust_no='%.20s' AND cpn_id='%.11s' AND comp_cd='%ld';";
}