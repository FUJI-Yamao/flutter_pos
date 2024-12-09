/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
07_ロイヤリティプロモーション系
07_1	アカウントマスタ	c_acct_mst
07_2	クーポンヘッダー	c_cpnhdr_mst
07_3	クーポン明細	c_cpnbdy_mst
07_4	顧客クーポン印字情報	s_cust_cpn_tbl
07_5	クーポン管理マスタ	c_cpn_ctrl_mst
07_6	ロイヤリティ企画対象店舗マスタ	c_loystre_mst
07_7	ロイヤリティ企画マスタ	c_loypln_mst
07_8	ロイヤリティ企画商品マスタ	c_loyplu_mst
07_9	ロイヤリティ企画メッセージマスタ	c_loytgt_mst
07_10	顧客プロモーションテーブル	s_cust_loy_tbl
07_11	顧客別累計購買情報テーブル	s_cust_ttl_tbl
07_12	ランク判定マスタ	c_rank_mst
07_13	ターミナル予約マスタ	c_trm_rsrv_mst
07_14	ポイントスケジュールマスタ	c_pntsch_mst
07_15	ポイントスケジュールグループマスタ	c_pntschgrp_mst
07_16	ターミナル企画番号マスタ	c_trm_plan_mst
07_17	顧客スタンプカードテーブル	s_cust_stp_tbl
07_18	スタンプカード企画マスタ	c_stppln_mst
 */

//region 07_1	アカウントマスタ	c_acct_mst
/// 07_1  アカウントマスタ c_acct_mstクラス
class CAcctMstColumns extends TableColumns{
  int? acct_cd;
  int mthr_acct_cd = 0;
  String? acct_name;
  int rcpt_prn_flg = 0;
  int prn_seq_no = 0;
  int acct_typ = 0;
  String? start_date;
  String? end_date;
  String? plus_end_date;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? comp_cd;
  int? stre_cd;
  int acct_cal_typ = 0;

  @override
  String _getTableName() => "c_acct_mst";

  @override
  String? _getKeyCondition() => 'acct_cd = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(acct_cd);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CAcctMstColumns rn = CAcctMstColumns();
      rn.acct_cd = maps[i]['acct_cd'];
      rn.mthr_acct_cd = maps[i]['mthr_acct_cd'];
      rn.acct_name = maps[i]['acct_name'];
      rn.rcpt_prn_flg = maps[i]['rcpt_prn_flg'];
      rn.prn_seq_no = maps[i]['prn_seq_no'];
      rn.acct_typ = maps[i]['acct_typ'];
      rn.start_date = maps[i]['start_date'];
      rn.end_date = maps[i]['end_date'];
      rn.plus_end_date = maps[i]['plus_end_date'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.acct_cal_typ = maps[i]['acct_cal_typ'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CAcctMstColumns rn = CAcctMstColumns();
    rn.acct_cd = maps[0]['acct_cd'];
    rn.mthr_acct_cd = maps[0]['mthr_acct_cd'];
    rn.acct_name = maps[0]['acct_name'];
    rn.rcpt_prn_flg = maps[0]['rcpt_prn_flg'];
    rn.prn_seq_no = maps[0]['prn_seq_no'];
    rn.acct_typ = maps[0]['acct_typ'];
    rn.start_date = maps[0]['start_date'];
    rn.end_date = maps[0]['end_date'];
    rn.plus_end_date = maps[0]['plus_end_date'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.acct_cal_typ = maps[0]['acct_cal_typ'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CAcctMstField.acct_cd : this.acct_cd,
      CAcctMstField.mthr_acct_cd : this.mthr_acct_cd,
      CAcctMstField.acct_name : this.acct_name,
      CAcctMstField.rcpt_prn_flg : this.rcpt_prn_flg,
      CAcctMstField.prn_seq_no : this.prn_seq_no,
      CAcctMstField.acct_typ : this.acct_typ,
      CAcctMstField.start_date : this.start_date,
      CAcctMstField.end_date : this.end_date,
      CAcctMstField.plus_end_date : this.plus_end_date,
      CAcctMstField.ins_datetime : this.ins_datetime,
      CAcctMstField.upd_datetime : this.upd_datetime,
      CAcctMstField.status : this.status,
      CAcctMstField.send_flg : this.send_flg,
      CAcctMstField.upd_user : this.upd_user,
      CAcctMstField.upd_system : this.upd_system,
      CAcctMstField.comp_cd : this.comp_cd,
      CAcctMstField.stre_cd : this.stre_cd,
      CAcctMstField.acct_cal_typ : this.acct_cal_typ,
    };
  }
}

/// 07_1  アカウントマスタ c_acct_mstのフィールド名設定用クラス
class CAcctMstField {
  static const acct_cd = "acct_cd";
  static const mthr_acct_cd = "mthr_acct_cd";
  static const acct_name = "acct_name";
  static const rcpt_prn_flg = "rcpt_prn_flg";
  static const prn_seq_no = "prn_seq_no";
  static const acct_typ = "acct_typ";
  static const start_date = "start_date";
  static const end_date = "end_date";
  static const plus_end_date = "plus_end_date";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const acct_cal_typ = "acct_cal_typ";
}
//endregion
//region 07_2	クーポンヘッダー	c_cpnhdr_mst
/// 07_2  クーポンヘッダー c_cpnhdr_mstクラス
class CCpnhdrMstColumns extends TableColumns{
  int? cpn_id;
  int? comp_cd;
  int? stre_cd;
  String? prn_stre_name;
  String? prn_time;
  String? start_date;
  String? end_date;
  String? template_id;
  String? pict_path;
  String? notes;
  int line = 0;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int all_cust_flg = 0;
  int prn_val = 0;
  int val_flg = 0;
  int prn_qty = 1;
  int tran_qty = 1;
  int day_qty = 0;
  int ttl_qty = 0;
  int reward_prom_cd = 0;
  int linked_prom_cd = 0;
  int rec_srch_id = 0;
  int prn_upp_lim = 0;
  int ref_typ = 0;
  int stp_acct_cd = 0;
  int stp_red_amt = 0;
  int sng_prn_flg = 0;
  int cust_kind_flg = 0;
  int timesch_flg = 0;
  int sun_flg = 0;
  int mon_flg = 0;
  int tue_flg = 0;
  int wed_flg = 0;
  int thu_flg = 0;
  int fri_flg = 0;
  int sat_flg = 0;
  int date_flg1 = 0;
  int date_flg2 = 0;
  int date_flg3 = 0;
  int date_flg4 = 0;
  int date_flg5 = 0;
  int? stp_cpn_id;
  String cust_kind_trgt = '{0}';
  int ref_typ2 = 0;
  int cust_card_kind = 0;
  int n_custom1 = 0;
  int n_custom2 = 0;
  int n_custom3 = 0;
  int n_custom4 = 0;
  int n_custom5 = 0;
  int n_custom6 = 0;
  int n_custom7 = 0;
  int n_custom8 = 0;
  int s_custom1 = 0;
  int s_custom2 = 0;
  int s_custom3 = 0;
  int s_custom4 = 0;
  int s_custom5 = 0;
  int s_custom6 = 0;
  int s_custom7 = 0;
  int s_custom8 = 0;
  String? c_custom1;
  String? c_custom2;
  String? c_custom3;
  String? c_custom4;
  String? d_custom1;
  String? d_custom2;
  String? d_custom3;
  String? d_custom4;

  @override
  String _getTableName() => "c_cpnhdr_mst";

  @override
  String? _getKeyCondition() => 'cpn_id = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cpn_id);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCpnhdrMstColumns rn = CCpnhdrMstColumns();
      rn.cpn_id = maps[i]['cpn_id'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.prn_stre_name = maps[i]['prn_stre_name'];
      rn.prn_time = maps[i]['prn_time'];
      rn.start_date = maps[i]['start_date'];
      rn.end_date = maps[i]['end_date'];
      rn.template_id = maps[i]['template_id'];
      rn.pict_path = maps[i]['pict_path'];
      rn.notes = maps[i]['notes'];
      rn.line = maps[i]['line'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.all_cust_flg = maps[i]['all_cust_flg'];
      rn.prn_val = maps[i]['prn_val'];
      rn.val_flg = maps[i]['val_flg'];
      rn.prn_qty = maps[i]['prn_qty'];
      rn.tran_qty = maps[i]['tran_qty'];
      rn.day_qty = maps[i]['day_qty'];
      rn.ttl_qty = maps[i]['ttl_qty'];
      rn.reward_prom_cd = maps[i]['reward_prom_cd'];
      rn.linked_prom_cd = maps[i]['linked_prom_cd'];
      rn.rec_srch_id = maps[i]['rec_srch_id'];
      rn.prn_upp_lim = maps[i]['prn_upp_lim'];
      rn.ref_typ = maps[i]['ref_typ'];
      rn.stp_acct_cd = maps[i]['stp_acct_cd'];
      rn.stp_red_amt = maps[i]['stp_red_amt'];
      rn.sng_prn_flg = maps[i]['sng_prn_flg'];
      rn.cust_kind_flg = maps[i]['cust_kind_flg'];
      rn.timesch_flg = maps[i]['timesch_flg'];
      rn.sun_flg = maps[i]['sun_flg'];
      rn.mon_flg = maps[i]['mon_flg'];
      rn.tue_flg = maps[i]['tue_flg'];
      rn.wed_flg = maps[i]['wed_flg'];
      rn.thu_flg = maps[i]['thu_flg'];
      rn.fri_flg = maps[i]['fri_flg'];
      rn.sat_flg = maps[i]['sat_flg'];
      rn.date_flg1 = maps[i]['date_flg1'];
      rn.date_flg2 = maps[i]['date_flg2'];
      rn.date_flg3 = maps[i]['date_flg3'];
      rn.date_flg4 = maps[i]['date_flg4'];
      rn.date_flg5 = maps[i]['date_flg5'];
      rn.stp_cpn_id = maps[i]['stp_cpn_id'];
      rn.cust_kind_trgt = maps[i]['cust_kind_trgt'];
      rn.ref_typ2 = maps[i]['ref_typ2'];
      rn.cust_card_kind = maps[i]['cust_card_kind'];
      rn.n_custom1 = maps[i]['n_custom1'];
      rn.n_custom2 = maps[i]['n_custom2'];
      rn.n_custom3 = maps[i]['n_custom3'];
      rn.n_custom4 = maps[i]['n_custom4'];
      rn.n_custom5 = maps[i]['n_custom5'];
      rn.n_custom6 = maps[i]['n_custom6'];
      rn.n_custom7 = maps[i]['n_custom7'];
      rn.n_custom8 = maps[i]['n_custom8'];
      rn.s_custom1 = maps[i]['s_custom1'];
      rn.s_custom2 = maps[i]['s_custom2'];
      rn.s_custom3 = maps[i]['s_custom3'];
      rn.s_custom4 = maps[i]['s_custom4'];
      rn.s_custom5 = maps[i]['s_custom5'];
      rn.s_custom6 = maps[i]['s_custom6'];
      rn.s_custom7 = maps[i]['s_custom7'];
      rn.s_custom8 = maps[i]['s_custom8'];
      rn.c_custom1 = maps[i]['c_custom1'];
      rn.c_custom2 = maps[i]['c_custom2'];
      rn.c_custom3 = maps[i]['c_custom3'];
      rn.c_custom4 = maps[i]['c_custom4'];
      rn.d_custom1 = maps[i]['d_custom1'];
      rn.d_custom2 = maps[i]['d_custom2'];
      rn.d_custom3 = maps[i]['d_custom3'];
      rn.d_custom4 = maps[i]['d_custom4'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CCpnhdrMstColumns rn = CCpnhdrMstColumns();
    rn.cpn_id = maps[0]['cpn_id'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.prn_stre_name = maps[0]['prn_stre_name'];
    rn.prn_time = maps[0]['prn_time'];
    rn.start_date = maps[0]['start_date'];
    rn.end_date = maps[0]['end_date'];
    rn.template_id = maps[0]['template_id'];
    rn.pict_path = maps[0]['pict_path'];
    rn.notes = maps[0]['notes'];
    rn.line = maps[0]['line'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.all_cust_flg = maps[0]['all_cust_flg'];
    rn.prn_val = maps[0]['prn_val'];
    rn.val_flg = maps[0]['val_flg'];
    rn.prn_qty = maps[0]['prn_qty'];
    rn.tran_qty = maps[0]['tran_qty'];
    rn.day_qty = maps[0]['day_qty'];
    rn.ttl_qty = maps[0]['ttl_qty'];
    rn.reward_prom_cd = maps[0]['reward_prom_cd'];
    rn.linked_prom_cd = maps[0]['linked_prom_cd'];
    rn.rec_srch_id = maps[0]['rec_srch_id'];
    rn.prn_upp_lim = maps[0]['prn_upp_lim'];
    rn.ref_typ = maps[0]['ref_typ'];
    rn.stp_acct_cd = maps[0]['stp_acct_cd'];
    rn.stp_red_amt = maps[0]['stp_red_amt'];
    rn.sng_prn_flg = maps[0]['sng_prn_flg'];
    rn.cust_kind_flg = maps[0]['cust_kind_flg'];
    rn.timesch_flg = maps[0]['timesch_flg'];
    rn.sun_flg = maps[0]['sun_flg'];
    rn.mon_flg = maps[0]['mon_flg'];
    rn.tue_flg = maps[0]['tue_flg'];
    rn.wed_flg = maps[0]['wed_flg'];
    rn.thu_flg = maps[0]['thu_flg'];
    rn.fri_flg = maps[0]['fri_flg'];
    rn.sat_flg = maps[0]['sat_flg'];
    rn.date_flg1 = maps[0]['date_flg1'];
    rn.date_flg2 = maps[0]['date_flg2'];
    rn.date_flg3 = maps[0]['date_flg3'];
    rn.date_flg4 = maps[0]['date_flg4'];
    rn.date_flg5 = maps[0]['date_flg5'];
    rn.stp_cpn_id = maps[0]['stp_cpn_id'];
    rn.cust_kind_trgt = maps[0]['cust_kind_trgt'];
    rn.ref_typ2 = maps[0]['ref_typ2'];
    rn.cust_card_kind = maps[0]['cust_card_kind'];
    rn.n_custom1 = maps[0]['n_custom1'];
    rn.n_custom2 = maps[0]['n_custom2'];
    rn.n_custom3 = maps[0]['n_custom3'];
    rn.n_custom4 = maps[0]['n_custom4'];
    rn.n_custom5 = maps[0]['n_custom5'];
    rn.n_custom6 = maps[0]['n_custom6'];
    rn.n_custom7 = maps[0]['n_custom7'];
    rn.n_custom8 = maps[0]['n_custom8'];
    rn.s_custom1 = maps[0]['s_custom1'];
    rn.s_custom2 = maps[0]['s_custom2'];
    rn.s_custom3 = maps[0]['s_custom3'];
    rn.s_custom4 = maps[0]['s_custom4'];
    rn.s_custom5 = maps[0]['s_custom5'];
    rn.s_custom6 = maps[0]['s_custom6'];
    rn.s_custom7 = maps[0]['s_custom7'];
    rn.s_custom8 = maps[0]['s_custom8'];
    rn.c_custom1 = maps[0]['c_custom1'];
    rn.c_custom2 = maps[0]['c_custom2'];
    rn.c_custom3 = maps[0]['c_custom3'];
    rn.c_custom4 = maps[0]['c_custom4'];
    rn.d_custom1 = maps[0]['d_custom1'];
    rn.d_custom2 = maps[0]['d_custom2'];
    rn.d_custom3 = maps[0]['d_custom3'];
    rn.d_custom4 = maps[0]['d_custom4'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CCpnhdrMstField.cpn_id : this.cpn_id,
      CCpnhdrMstField.comp_cd : this.comp_cd,
      CCpnhdrMstField.stre_cd : this.stre_cd,
      CCpnhdrMstField.prn_stre_name : this.prn_stre_name,
      CCpnhdrMstField.prn_time : this.prn_time,
      CCpnhdrMstField.start_date : this.start_date,
      CCpnhdrMstField.end_date : this.end_date,
      CCpnhdrMstField.template_id : this.template_id,
      CCpnhdrMstField.pict_path : this.pict_path,
      CCpnhdrMstField.notes : this.notes,
      CCpnhdrMstField.line : this.line,
      CCpnhdrMstField.stop_flg : this.stop_flg,
      CCpnhdrMstField.ins_datetime : this.ins_datetime,
      CCpnhdrMstField.upd_datetime : this.upd_datetime,
      CCpnhdrMstField.status : this.status,
      CCpnhdrMstField.send_flg : this.send_flg,
      CCpnhdrMstField.upd_user : this.upd_user,
      CCpnhdrMstField.upd_system : this.upd_system,
      CCpnhdrMstField.all_cust_flg : this.all_cust_flg,
      CCpnhdrMstField.prn_val : this.prn_val,
      CCpnhdrMstField.val_flg : this.val_flg,
      CCpnhdrMstField.prn_qty : this.prn_qty,
      CCpnhdrMstField.tran_qty : this.tran_qty,
      CCpnhdrMstField.day_qty : this.day_qty,
      CCpnhdrMstField.ttl_qty : this.ttl_qty,
      CCpnhdrMstField.reward_prom_cd : this.reward_prom_cd,
      CCpnhdrMstField.linked_prom_cd : this.linked_prom_cd,
      CCpnhdrMstField.rec_srch_id : this.rec_srch_id,
      CCpnhdrMstField.prn_upp_lim : this.prn_upp_lim,
      CCpnhdrMstField.ref_typ : this.ref_typ,
      CCpnhdrMstField.stp_acct_cd : this.stp_acct_cd,
      CCpnhdrMstField.stp_red_amt : this.stp_red_amt,
      CCpnhdrMstField.sng_prn_flg : this.sng_prn_flg,
      CCpnhdrMstField.cust_kind_flg : this.cust_kind_flg,
      CCpnhdrMstField.timesch_flg : this.timesch_flg,
      CCpnhdrMstField.sun_flg : this.sun_flg,
      CCpnhdrMstField.mon_flg : this.mon_flg,
      CCpnhdrMstField.tue_flg : this.tue_flg,
      CCpnhdrMstField.wed_flg : this.wed_flg,
      CCpnhdrMstField.thu_flg : this.thu_flg,
      CCpnhdrMstField.fri_flg : this.fri_flg,
      CCpnhdrMstField.sat_flg : this.sat_flg,
      CCpnhdrMstField.date_flg1 : this.date_flg1,
      CCpnhdrMstField.date_flg2 : this.date_flg2,
      CCpnhdrMstField.date_flg3 : this.date_flg3,
      CCpnhdrMstField.date_flg4 : this.date_flg4,
      CCpnhdrMstField.date_flg5 : this.date_flg5,
      CCpnhdrMstField.stp_cpn_id : this.stp_cpn_id,
      CCpnhdrMstField.cust_kind_trgt : this.cust_kind_trgt,
      CCpnhdrMstField.ref_typ2 : this.ref_typ2,
      CCpnhdrMstField.cust_card_kind : this.cust_card_kind,
      CCpnhdrMstField.n_custom1 : this.n_custom1,
      CCpnhdrMstField.n_custom2 : this.n_custom2,
      CCpnhdrMstField.n_custom3 : this.n_custom3,
      CCpnhdrMstField.n_custom4 : this.n_custom4,
      CCpnhdrMstField.n_custom5 : this.n_custom5,
      CCpnhdrMstField.n_custom6 : this.n_custom6,
      CCpnhdrMstField.n_custom7 : this.n_custom7,
      CCpnhdrMstField.n_custom8 : this.n_custom8,
      CCpnhdrMstField.s_custom1 : this.s_custom1,
      CCpnhdrMstField.s_custom2 : this.s_custom2,
      CCpnhdrMstField.s_custom3 : this.s_custom3,
      CCpnhdrMstField.s_custom4 : this.s_custom4,
      CCpnhdrMstField.s_custom5 : this.s_custom5,
      CCpnhdrMstField.s_custom6 : this.s_custom6,
      CCpnhdrMstField.s_custom7 : this.s_custom7,
      CCpnhdrMstField.s_custom8 : this.s_custom8,
      CCpnhdrMstField.c_custom1 : this.c_custom1,
      CCpnhdrMstField.c_custom2 : this.c_custom2,
      CCpnhdrMstField.c_custom3 : this.c_custom3,
      CCpnhdrMstField.c_custom4 : this.c_custom4,
      CCpnhdrMstField.d_custom1 : this.d_custom1,
      CCpnhdrMstField.d_custom2 : this.d_custom2,
      CCpnhdrMstField.d_custom3 : this.d_custom3,
      CCpnhdrMstField.d_custom4 : this.d_custom4,
    };
  }
}

/// 07_2  クーポンヘッダー c_cpnhdr_mstのフィールド名設定用クラス
class CCpnhdrMstField {
  static const cpn_id = "cpn_id";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const prn_stre_name = "prn_stre_name";
  static const prn_time = "prn_time";
  static const start_date = "start_date";
  static const end_date = "end_date";
  static const template_id = "template_id";
  static const pict_path = "pict_path";
  static const notes = "notes";
  static const line = "line";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const all_cust_flg = "all_cust_flg";
  static const prn_val = "prn_val";
  static const val_flg = "val_flg";
  static const prn_qty = "prn_qty";
  static const tran_qty = "tran_qty";
  static const day_qty = "day_qty";
  static const ttl_qty = "ttl_qty";
  static const reward_prom_cd = "reward_prom_cd";
  static const linked_prom_cd = "linked_prom_cd";
  static const rec_srch_id = "rec_srch_id";
  static const prn_upp_lim = "prn_upp_lim";
  static const ref_typ = "ref_typ";
  static const stp_acct_cd = "stp_acct_cd";
  static const stp_red_amt = "stp_red_amt";
  static const sng_prn_flg = "sng_prn_flg";
  static const cust_kind_flg = "cust_kind_flg";
  static const timesch_flg = "timesch_flg";
  static const sun_flg = "sun_flg";
  static const mon_flg = "mon_flg";
  static const tue_flg = "tue_flg";
  static const wed_flg = "wed_flg";
  static const thu_flg = "thu_flg";
  static const fri_flg = "fri_flg";
  static const sat_flg = "sat_flg";
  static const date_flg1 = "date_flg1";
  static const date_flg2 = "date_flg2";
  static const date_flg3 = "date_flg3";
  static const date_flg4 = "date_flg4";
  static const date_flg5 = "date_flg5";
  static const stp_cpn_id = "stp_cpn_id";
  static const cust_kind_trgt = "cust_kind_trgt";
  static const ref_typ2 = "ref_typ2";
  static const cust_card_kind = "cust_card_kind";
  static const n_custom1 = "n_custom1";
  static const n_custom2 = "n_custom2";
  static const n_custom3 = "n_custom3";
  static const n_custom4 = "n_custom4";
  static const n_custom5 = "n_custom5";
  static const n_custom6 = "n_custom6";
  static const n_custom7 = "n_custom7";
  static const n_custom8 = "n_custom8";
  static const s_custom1 = "s_custom1";
  static const s_custom2 = "s_custom2";
  static const s_custom3 = "s_custom3";
  static const s_custom4 = "s_custom4";
  static const s_custom5 = "s_custom5";
  static const s_custom6 = "s_custom6";
  static const s_custom7 = "s_custom7";
  static const s_custom8 = "s_custom8";
  static const c_custom1 = "c_custom1";
  static const c_custom2 = "c_custom2";
  static const c_custom3 = "c_custom3";
  static const c_custom4 = "c_custom4";
  static const d_custom1 = "d_custom1";
  static const d_custom2 = "d_custom2";
  static const d_custom3 = "d_custom3";
  static const d_custom4 = "d_custom4";
}
//endregion
//region 07_3	クーポン明細	c_cpnbdy_mst
/// 07_3  クーポン明細 c_cpnbdy_mstクラス
class CCpnbdyMstColumns extends TableColumns{
  int? plan_cd;
  int? cpn_id;
  String? cpn_content;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? comp_cd;

  @override
  String _getTableName() => "c_cpnbdy_mst";

  @override
  String? _getKeyCondition() => 'plan_cd = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(plan_cd);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCpnbdyMstColumns rn = CCpnbdyMstColumns();
      rn.plan_cd = maps[i]['plan_cd'];
      rn.cpn_id = maps[i]['cpn_id'];
      rn.cpn_content = maps[i]['cpn_content'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.comp_cd = maps[i]['comp_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CCpnbdyMstColumns rn = CCpnbdyMstColumns();
    rn.plan_cd = maps[0]['plan_cd'];
    rn.cpn_id = maps[0]['cpn_id'];
    rn.cpn_content = maps[0]['cpn_content'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.comp_cd = maps[0]['comp_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CCpnbdyMstField.plan_cd : this.plan_cd,
      CCpnbdyMstField.cpn_id : this.cpn_id,
      CCpnbdyMstField.cpn_content : this.cpn_content,
      CCpnbdyMstField.ins_datetime : this.ins_datetime,
      CCpnbdyMstField.upd_datetime : this.upd_datetime,
      CCpnbdyMstField.status : this.status,
      CCpnbdyMstField.send_flg : this.send_flg,
      CCpnbdyMstField.upd_user : this.upd_user,
      CCpnbdyMstField.upd_system : this.upd_system,
      CCpnbdyMstField.comp_cd : this.comp_cd,
    };
  }
}

/// 07_3  クーポン明細 c_cpnbdy_mstのフィールド名設定用クラス
class CCpnbdyMstField {
  static const plan_cd = "plan_cd";
  static const cpn_id = "cpn_id";
  static const cpn_content = "cpn_content";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const comp_cd = "comp_cd";
}
//endregion
//region 07_4	顧客クーポン印字情報	s_cust_cpn_tbl
/// 07_4  顧客クーポン印字情報 s_cust_cpn_tblクラス
class SCustCpnTblColumns extends TableColumns{
  String? cust_no;
  int? cpn_id;
  int? comp_cd;
  String? print_datetime;
  String? cpn_data;
  String print_flg = '{0}';
  int stop_flg = 0;
  int prn_comp_cd = 0;
  int prn_stre_cd = 0;
  int prn_mac_no = 0;
  int prn_staff_cd = 0;
  String? prn_datetime;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int tday_cnt = 0;
  int total_cnt = 0;

  @override
  String _getTableName() => "s_cust_cpn_tbl";

  @override
  String? _getKeyCondition() => 'cust_no = ? AND cpn_id = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cust_no);
    rn.add(cpn_id);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SCustCpnTblColumns rn = SCustCpnTblColumns();
      rn.cust_no = maps[i]['cust_no'];
      rn.cpn_id = maps[i]['cpn_id'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.print_datetime = maps[i]['print_datetime'];
      rn.cpn_data = maps[i]['cpn_data'];
      rn.print_flg = maps[i]['print_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.prn_comp_cd = maps[i]['prn_comp_cd'];
      rn.prn_stre_cd = maps[i]['prn_stre_cd'];
      rn.prn_mac_no = maps[i]['prn_mac_no'];
      rn.prn_staff_cd = maps[i]['prn_staff_cd'];
      rn.prn_datetime = maps[i]['prn_datetime'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.tday_cnt = maps[i]['tday_cnt'];
      rn.total_cnt = maps[i]['total_cnt'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SCustCpnTblColumns rn = SCustCpnTblColumns();
    rn.cust_no = maps[0]['cust_no'];
    rn.cpn_id = maps[0]['cpn_id'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.print_datetime = maps[0]['print_datetime'];
    rn.cpn_data = maps[0]['cpn_data'];
    rn.print_flg = maps[0]['print_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.prn_comp_cd = maps[0]['prn_comp_cd'];
    rn.prn_stre_cd = maps[0]['prn_stre_cd'];
    rn.prn_mac_no = maps[0]['prn_mac_no'];
    rn.prn_staff_cd = maps[0]['prn_staff_cd'];
    rn.prn_datetime = maps[0]['prn_datetime'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.tday_cnt = maps[0]['tday_cnt'];
    rn.total_cnt = maps[0]['total_cnt'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SCustCpnTblField.cust_no : this.cust_no,
      SCustCpnTblField.cpn_id : this.cpn_id,
      SCustCpnTblField.comp_cd : this.comp_cd,
      SCustCpnTblField.print_datetime : this.print_datetime,
      SCustCpnTblField.cpn_data : this.cpn_data,
      SCustCpnTblField.print_flg : this.print_flg,
      SCustCpnTblField.stop_flg : this.stop_flg,
      SCustCpnTblField.prn_comp_cd : this.prn_comp_cd,
      SCustCpnTblField.prn_stre_cd : this.prn_stre_cd,
      SCustCpnTblField.prn_mac_no : this.prn_mac_no,
      SCustCpnTblField.prn_staff_cd : this.prn_staff_cd,
      SCustCpnTblField.prn_datetime : this.prn_datetime,
      SCustCpnTblField.ins_datetime : this.ins_datetime,
      SCustCpnTblField.upd_datetime : this.upd_datetime,
      SCustCpnTblField.status : this.status,
      SCustCpnTblField.send_flg : this.send_flg,
      SCustCpnTblField.upd_user : this.upd_user,
      SCustCpnTblField.upd_system : this.upd_system,
      SCustCpnTblField.tday_cnt : this.tday_cnt,
      SCustCpnTblField.total_cnt : this.total_cnt,
    };
  }
}

/// 07_4  顧客クーポン印字情報 s_cust_cpn_tblのフィールド名設定用クラス
class SCustCpnTblField {
  static const cust_no = "cust_no";
  static const cpn_id = "cpn_id";
  static const comp_cd = "comp_cd";
  static const print_datetime = "print_datetime";
  static const cpn_data = "cpn_data";
  static const print_flg = "print_flg";
  static const stop_flg = "stop_flg";
  static const prn_comp_cd = "prn_comp_cd";
  static const prn_stre_cd = "prn_stre_cd";
  static const prn_mac_no = "prn_mac_no";
  static const prn_staff_cd = "prn_staff_cd";
  static const prn_datetime = "prn_datetime";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const tday_cnt = "tday_cnt";
  static const total_cnt = "total_cnt";
}
//endregion
//region 07_5	クーポン管理マスタ	c_cpn_ctrl_mst
/// 07_5  クーポン管理マスタ  c_cpn_ctrl_mstクラス
class CCpnCtrlMstColumns extends TableColumns{
  int? cpn_id;
  String? name;
  String? start_datetime;
  String? end_datetime;
  String? cpn_start_datetime;
  String? cpn_end_datetime;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? comp_cd;

  @override
  String _getTableName() => "c_cpn_ctrl_mst";

  @override
  String? _getKeyCondition() => 'cpn_id = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cpn_id);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCpnCtrlMstColumns rn = CCpnCtrlMstColumns();
      rn.cpn_id = maps[i]['cpn_id'];
      rn.name = maps[i]['name'];
      rn.start_datetime = maps[i]['start_datetime'];
      rn.end_datetime = maps[i]['end_datetime'];
      rn.cpn_start_datetime = maps[i]['cpn_start_datetime'];
      rn.cpn_end_datetime = maps[i]['cpn_end_datetime'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.comp_cd = maps[i]['comp_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CCpnCtrlMstColumns rn = CCpnCtrlMstColumns();
    rn.cpn_id = maps[0]['cpn_id'];
    rn.name = maps[0]['name'];
    rn.start_datetime = maps[0]['start_datetime'];
    rn.end_datetime = maps[0]['end_datetime'];
    rn.cpn_start_datetime = maps[0]['cpn_start_datetime'];
    rn.cpn_end_datetime = maps[0]['cpn_end_datetime'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.comp_cd = maps[0]['comp_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CCpnCtrlMstField.cpn_id : this.cpn_id,
      CCpnCtrlMstField.name : this.name,
      CCpnCtrlMstField.start_datetime : this.start_datetime,
      CCpnCtrlMstField.end_datetime : this.end_datetime,
      CCpnCtrlMstField.cpn_start_datetime : this.cpn_start_datetime,
      CCpnCtrlMstField.cpn_end_datetime : this.cpn_end_datetime,
      CCpnCtrlMstField.stop_flg : this.stop_flg,
      CCpnCtrlMstField.ins_datetime : this.ins_datetime,
      CCpnCtrlMstField.upd_datetime : this.upd_datetime,
      CCpnCtrlMstField.status : this.status,
      CCpnCtrlMstField.send_flg : this.send_flg,
      CCpnCtrlMstField.upd_user : this.upd_user,
      CCpnCtrlMstField.upd_system : this.upd_system,
      CCpnCtrlMstField.comp_cd : this.comp_cd,
    };
  }
}

/// 07_5  クーポン管理マスタ  c_cpn_ctrl_mstのフィールド名設定用クラス
class CCpnCtrlMstField {
  static const cpn_id = "cpn_id";
  static const name = "name";
  static const start_datetime = "start_datetime";
  static const end_datetime = "end_datetime";
  static const cpn_start_datetime = "cpn_start_datetime";
  static const cpn_end_datetime = "cpn_end_datetime";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const comp_cd = "comp_cd";
}
//endregion
//region 07_6	ロイヤリティ企画対象店舗マスタ	c_loystre_mst
/// 07_6  ロイヤリティ企画対象店舗マスタ  c_loystre_mstクラス
class CLoystreMstColumns extends TableColumns{
  int? cpn_id;
  int? comp_cd;
  int? stre_cd;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_loystre_mst";

  @override
  String? _getKeyCondition() => 'cpn_id = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cpn_id);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CLoystreMstColumns rn = CLoystreMstColumns();
      rn.cpn_id = maps[i]['cpn_id'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CLoystreMstColumns rn = CLoystreMstColumns();
    rn.cpn_id = maps[0]['cpn_id'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CLoystreMstField.cpn_id : this.cpn_id,
      CLoystreMstField.comp_cd : this.comp_cd,
      CLoystreMstField.stre_cd : this.stre_cd,
      CLoystreMstField.stop_flg : this.stop_flg,
      CLoystreMstField.ins_datetime : this.ins_datetime,
      CLoystreMstField.upd_datetime : this.upd_datetime,
      CLoystreMstField.status : this.status,
      CLoystreMstField.send_flg : this.send_flg,
      CLoystreMstField.upd_user : this.upd_user,
      CLoystreMstField.upd_system : this.upd_system,
    };
  }
}

/// 07_6  ロイヤリティ企画対象店舗マスタ  c_loystre_mstのフィールド名設定用クラス
class CLoystreMstField {
  static const cpn_id = "cpn_id";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 07_7	ロイヤリティ企画マスタ	c_loypln_mst
/// 07_7  ロイヤリティ企画マスタ  c_loypln_mstクラス
class CLoyplnMstColumns extends TableColumns{
  int? plan_cd;
  int? cpn_id;
  int all_cust_flg = 0;
  int all_stre_flg = 0;
  String? prom_name;
  String? rcpt_name;
  int svs_class = 0;
  int svs_typ = 0;
  int reward_val = 0;
  int bdl_prc_flg = 0;
  String bdl_qty = '{0,0,0,0,0}';
  String bdl_prc = '{0,0,0,0,0}';
  String bdl_reward_val = '{0,0,0,0,0}';
  int form_amt = 0;
  int form_qty = 0;
  int rec_limit = 0;
  int day_limit = 0;
  int max_limit = 0;
  String? start_datetime;
  String? end_datetime;
  int stop_flg = 0;
  int timesch_flg = 0;
  int sun_flg = 0;
  int mon_flg = 0;
  int tue_flg = 0;
  int wed_flg = 0;
  int thu_flg = 0;
  int fri_flg = 0;
  int sat_flg = 0;
  int acct_cd = 0;
  int seq_no = 0;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int cpn_kind = 0;
  int svs_kind = 0;
  int refer_comp_cd = 0;
  int? comp_cd;
  double? mul_val = 0;
  int reward_flg = 0;
  int bcd_all_cust_flg = 0;
  String? loy_bcd;
  int low_lim = 0;
  int upp_lim = 0;
  int val_flg = 0;
  int ref_typ = 0;
  int apl_cnt = 1;
  int stp_acct_cd = 0;
  int stp_red_amt = 0;
  int cust_kind_flg = 0;
  int date_flg1 = 0;
  int date_flg2 = 0;
  int date_flg3 = 0;
  int date_flg4 = 0;
  int date_flg5 = 0;
  int? stp_cpn_id;
  String? svs_content;
  String cust_kind_trgt = '{0}';
  int ref_typ2 = 0;
  int pay_key_cd = 0;
  int cust_card_kind = 0;
  int n_custom1 = 0;
  int n_custom2 = 0;
  int n_custom3 = 0;
  int n_custom4 = 0;
  int n_custom5 = 0;
  int n_custom6 = 0;
  int n_custom7 = 0;
  int n_custom8 = 0;
  int s_custom1 = 0;
  int s_custom2 = 0;
  int s_custom3 = 0;
  int s_custom4 = 0;
  int s_custom5 = 0;
  int s_custom6 = 0;
  int s_custom7 = 0;
  int s_custom8 = 0;
  String? c_custom1;
  String? c_custom2;
  String? c_custom3;
  String? c_custom4;
  String? d_custom1;
  String? d_custom2;
  String? d_custom3;
  String? d_custom4;

  @override
  String _getTableName() => "c_loypln_mst";

  @override
  String? _getKeyCondition() => 'plan_cd = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(plan_cd);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CLoyplnMstColumns rn = CLoyplnMstColumns();
      rn.plan_cd = maps[i]['plan_cd'];
      rn.cpn_id = maps[i]['cpn_id'];
      rn.all_cust_flg = maps[i]['all_cust_flg'];
      rn.all_stre_flg = maps[i]['all_stre_flg'];
      rn.prom_name = maps[i]['prom_name'];
      rn.rcpt_name = maps[i]['rcpt_name'];
      rn.svs_class = maps[i]['svs_class'];
      rn.svs_typ = maps[i]['svs_typ'];
      rn.reward_val = maps[i]['reward_val'];
      rn.bdl_prc_flg = maps[i]['bdl_prc_flg'];
      rn.bdl_qty = maps[i]['bdl_qty'];
      rn.bdl_prc = maps[i]['bdl_prc'];
      rn.bdl_reward_val = maps[i]['bdl_reward_val'];
      rn.form_amt = maps[i]['form_amt'];
      rn.form_qty = maps[i]['form_qty'];
      rn.rec_limit = maps[i]['rec_limit'];
      rn.day_limit = maps[i]['day_limit'];
      rn.max_limit = maps[i]['max_limit'];
      rn.start_datetime = maps[i]['start_datetime'];
      rn.end_datetime = maps[i]['end_datetime'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.timesch_flg = maps[i]['timesch_flg'];
      rn.sun_flg = maps[i]['sun_flg'];
      rn.mon_flg = maps[i]['mon_flg'];
      rn.tue_flg = maps[i]['tue_flg'];
      rn.wed_flg = maps[i]['wed_flg'];
      rn.thu_flg = maps[i]['thu_flg'];
      rn.fri_flg = maps[i]['fri_flg'];
      rn.sat_flg = maps[i]['sat_flg'];
      rn.acct_cd = maps[i]['acct_cd'];
      rn.seq_no = maps[i]['seq_no'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.cpn_kind = maps[i]['cpn_kind'];
      rn.svs_kind = maps[i]['svs_kind'];
      rn.refer_comp_cd = maps[i]['refer_comp_cd'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.mul_val = maps[i]['mul_val'];
      rn.reward_flg = maps[i]['reward_flg'];
      rn.bcd_all_cust_flg = maps[i]['bcd_all_cust_flg'];
      rn.loy_bcd = maps[i]['loy_bcd'];
      rn.low_lim = maps[i]['low_lim'];
      rn.upp_lim = maps[i]['upp_lim'];
      rn.val_flg = maps[i]['val_flg'];
      rn.ref_typ = maps[i]['ref_typ'];
      rn.apl_cnt = maps[i]['apl_cnt'];
      rn.stp_acct_cd = maps[i]['stp_acct_cd'];
      rn.stp_red_amt = maps[i]['stp_red_amt'];
      rn.cust_kind_flg = maps[i]['cust_kind_flg'];
      rn.date_flg1 = maps[i]['date_flg1'];
      rn.date_flg2 = maps[i]['date_flg2'];
      rn.date_flg3 = maps[i]['date_flg3'];
      rn.date_flg4 = maps[i]['date_flg4'];
      rn.date_flg5 = maps[i]['date_flg5'];
      rn.stp_cpn_id = maps[i]['stp_cpn_id'];
      rn.svs_content = maps[i]['svs_content'];
      rn.cust_kind_trgt = maps[i]['cust_kind_trgt'];
      rn.ref_typ2 = maps[i]['ref_typ2'];
      rn.pay_key_cd = maps[i]['pay_key_cd'];
      rn.cust_card_kind = maps[i]['cust_card_kind'];
      rn.n_custom1 = maps[i]['n_custom1'];
      rn.n_custom2 = maps[i]['n_custom2'];
      rn.n_custom3 = maps[i]['n_custom3'];
      rn.n_custom4 = maps[i]['n_custom4'];
      rn.n_custom5 = maps[i]['n_custom5'];
      rn.n_custom6 = maps[i]['n_custom6'];
      rn.n_custom7 = maps[i]['n_custom7'];
      rn.n_custom8 = maps[i]['n_custom8'];
      rn.s_custom1 = maps[i]['s_custom1'];
      rn.s_custom2 = maps[i]['s_custom2'];
      rn.s_custom3 = maps[i]['s_custom3'];
      rn.s_custom4 = maps[i]['s_custom4'];
      rn.s_custom5 = maps[i]['s_custom5'];
      rn.s_custom6 = maps[i]['s_custom6'];
      rn.s_custom7 = maps[i]['s_custom7'];
      rn.s_custom8 = maps[i]['s_custom8'];
      rn.c_custom1 = maps[i]['c_custom1'];
      rn.c_custom2 = maps[i]['c_custom2'];
      rn.c_custom3 = maps[i]['c_custom3'];
      rn.c_custom4 = maps[i]['c_custom4'];
      rn.d_custom1 = maps[i]['d_custom1'];
      rn.d_custom2 = maps[i]['d_custom2'];
      rn.d_custom3 = maps[i]['d_custom3'];
      rn.d_custom4 = maps[i]['d_custom4'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CLoyplnMstColumns rn = CLoyplnMstColumns();
    rn.plan_cd = maps[0]['plan_cd'];
    rn.cpn_id = maps[0]['cpn_id'];
    rn.all_cust_flg = maps[0]['all_cust_flg'];
    rn.all_stre_flg = maps[0]['all_stre_flg'];
    rn.prom_name = maps[0]['prom_name'];
    rn.rcpt_name = maps[0]['rcpt_name'];
    rn.svs_class = maps[0]['svs_class'];
    rn.svs_typ = maps[0]['svs_typ'];
    rn.reward_val = maps[0]['reward_val'];
    rn.bdl_prc_flg = maps[0]['bdl_prc_flg'];
    rn.bdl_qty = maps[0]['bdl_qty'];
    rn.bdl_prc = maps[0]['bdl_prc'];
    rn.bdl_reward_val = maps[0]['bdl_reward_val'];
    rn.form_amt = maps[0]['form_amt'];
    rn.form_qty = maps[0]['form_qty'];
    rn.rec_limit = maps[0]['rec_limit'];
    rn.day_limit = maps[0]['day_limit'];
    rn.max_limit = maps[0]['max_limit'];
    rn.start_datetime = maps[0]['start_datetime'];
    rn.end_datetime = maps[0]['end_datetime'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.timesch_flg = maps[0]['timesch_flg'];
    rn.sun_flg = maps[0]['sun_flg'];
    rn.mon_flg = maps[0]['mon_flg'];
    rn.tue_flg = maps[0]['tue_flg'];
    rn.wed_flg = maps[0]['wed_flg'];
    rn.thu_flg = maps[0]['thu_flg'];
    rn.fri_flg = maps[0]['fri_flg'];
    rn.sat_flg = maps[0]['sat_flg'];
    rn.acct_cd = maps[0]['acct_cd'];
    rn.seq_no = maps[0]['seq_no'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.cpn_kind = maps[0]['cpn_kind'];
    rn.svs_kind = maps[0]['svs_kind'];
    rn.refer_comp_cd = maps[0]['refer_comp_cd'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.mul_val = maps[0]['mul_val'];
    rn.reward_flg = maps[0]['reward_flg'];
    rn.bcd_all_cust_flg = maps[0]['bcd_all_cust_flg'];
    rn.loy_bcd = maps[0]['loy_bcd'];
    rn.low_lim = maps[0]['low_lim'];
    rn.upp_lim = maps[0]['upp_lim'];
    rn.val_flg = maps[0]['val_flg'];
    rn.ref_typ = maps[0]['ref_typ'];
    rn.apl_cnt = maps[0]['apl_cnt'];
    rn.stp_acct_cd = maps[0]['stp_acct_cd'];
    rn.stp_red_amt = maps[0]['stp_red_amt'];
    rn.cust_kind_flg = maps[0]['cust_kind_flg'];
    rn.date_flg1 = maps[0]['date_flg1'];
    rn.date_flg2 = maps[0]['date_flg2'];
    rn.date_flg3 = maps[0]['date_flg3'];
    rn.date_flg4 = maps[0]['date_flg4'];
    rn.date_flg5 = maps[0]['date_flg5'];
    rn.stp_cpn_id = maps[0]['stp_cpn_id'];
    rn.svs_content = maps[0]['svs_content'];
    rn.cust_kind_trgt = maps[0]['cust_kind_trgt'];
    rn.ref_typ2 = maps[0]['ref_typ2'];
    rn.pay_key_cd = maps[0]['pay_key_cd'];
    rn.cust_card_kind = maps[0]['cust_card_kind'];
    rn.n_custom1 = maps[0]['n_custom1'];
    rn.n_custom2 = maps[0]['n_custom2'];
    rn.n_custom3 = maps[0]['n_custom3'];
    rn.n_custom4 = maps[0]['n_custom4'];
    rn.n_custom5 = maps[0]['n_custom5'];
    rn.n_custom6 = maps[0]['n_custom6'];
    rn.n_custom7 = maps[0]['n_custom7'];
    rn.n_custom8 = maps[0]['n_custom8'];
    rn.s_custom1 = maps[0]['s_custom1'];
    rn.s_custom2 = maps[0]['s_custom2'];
    rn.s_custom3 = maps[0]['s_custom3'];
    rn.s_custom4 = maps[0]['s_custom4'];
    rn.s_custom5 = maps[0]['s_custom5'];
    rn.s_custom6 = maps[0]['s_custom6'];
    rn.s_custom7 = maps[0]['s_custom7'];
    rn.s_custom8 = maps[0]['s_custom8'];
    rn.c_custom1 = maps[0]['c_custom1'];
    rn.c_custom2 = maps[0]['c_custom2'];
    rn.c_custom3 = maps[0]['c_custom3'];
    rn.c_custom4 = maps[0]['c_custom4'];
    rn.d_custom1 = maps[0]['d_custom1'];
    rn.d_custom2 = maps[0]['d_custom2'];
    rn.d_custom3 = maps[0]['d_custom3'];
    rn.d_custom4 = maps[0]['d_custom4'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CLoyplnMstField.plan_cd : this.plan_cd,
      CLoyplnMstField.cpn_id : this.cpn_id,
      CLoyplnMstField.all_cust_flg : this.all_cust_flg,
      CLoyplnMstField.all_stre_flg : this.all_stre_flg,
      CLoyplnMstField.prom_name : this.prom_name,
      CLoyplnMstField.rcpt_name : this.rcpt_name,
      CLoyplnMstField.svs_class : this.svs_class,
      CLoyplnMstField.svs_typ : this.svs_typ,
      CLoyplnMstField.reward_val : this.reward_val,
      CLoyplnMstField.bdl_prc_flg : this.bdl_prc_flg,
      CLoyplnMstField.bdl_qty : this.bdl_qty,
      CLoyplnMstField.bdl_prc : this.bdl_prc,
      CLoyplnMstField.bdl_reward_val : this.bdl_reward_val,
      CLoyplnMstField.form_amt : this.form_amt,
      CLoyplnMstField.form_qty : this.form_qty,
      CLoyplnMstField.rec_limit : this.rec_limit,
      CLoyplnMstField.day_limit : this.day_limit,
      CLoyplnMstField.max_limit : this.max_limit,
      CLoyplnMstField.start_datetime : this.start_datetime,
      CLoyplnMstField.end_datetime : this.end_datetime,
      CLoyplnMstField.stop_flg : this.stop_flg,
      CLoyplnMstField.timesch_flg : this.timesch_flg,
      CLoyplnMstField.sun_flg : this.sun_flg,
      CLoyplnMstField.mon_flg : this.mon_flg,
      CLoyplnMstField.tue_flg : this.tue_flg,
      CLoyplnMstField.wed_flg : this.wed_flg,
      CLoyplnMstField.thu_flg : this.thu_flg,
      CLoyplnMstField.fri_flg : this.fri_flg,
      CLoyplnMstField.sat_flg : this.sat_flg,
      CLoyplnMstField.acct_cd : this.acct_cd,
      CLoyplnMstField.seq_no : this.seq_no,
      CLoyplnMstField.promo_ext_id : this.promo_ext_id,
      CLoyplnMstField.ins_datetime : this.ins_datetime,
      CLoyplnMstField.upd_datetime : this.upd_datetime,
      CLoyplnMstField.status : this.status,
      CLoyplnMstField.send_flg : this.send_flg,
      CLoyplnMstField.upd_user : this.upd_user,
      CLoyplnMstField.upd_system : this.upd_system,
      CLoyplnMstField.cpn_kind : this.cpn_kind,
      CLoyplnMstField.svs_kind : this.svs_kind,
      CLoyplnMstField.refer_comp_cd : this.refer_comp_cd,
      CLoyplnMstField.comp_cd : this.comp_cd,
      CLoyplnMstField.mul_val : this.mul_val,
      CLoyplnMstField.reward_flg : this.reward_flg,
      CLoyplnMstField.bcd_all_cust_flg : this.bcd_all_cust_flg,
      CLoyplnMstField.loy_bcd : this.loy_bcd,
      CLoyplnMstField.low_lim : this.low_lim,
      CLoyplnMstField.upp_lim : this.upp_lim,
      CLoyplnMstField.val_flg : this.val_flg,
      CLoyplnMstField.ref_typ : this.ref_typ,
      CLoyplnMstField.apl_cnt : this.apl_cnt,
      CLoyplnMstField.stp_acct_cd : this.stp_acct_cd,
      CLoyplnMstField.stp_red_amt : this.stp_red_amt,
      CLoyplnMstField.cust_kind_flg : this.cust_kind_flg,
      CLoyplnMstField.date_flg1 : this.date_flg1,
      CLoyplnMstField.date_flg2 : this.date_flg2,
      CLoyplnMstField.date_flg3 : this.date_flg3,
      CLoyplnMstField.date_flg4 : this.date_flg4,
      CLoyplnMstField.date_flg5 : this.date_flg5,
      CLoyplnMstField.stp_cpn_id : this.stp_cpn_id,
      CLoyplnMstField.svs_content : this.svs_content,
      CLoyplnMstField.cust_kind_trgt : this.cust_kind_trgt,
      CLoyplnMstField.ref_typ2 : this.ref_typ2,
      CLoyplnMstField.pay_key_cd : this.pay_key_cd,
      CLoyplnMstField.cust_card_kind : this.cust_card_kind,
      CLoyplnMstField.n_custom1 : this.n_custom1,
      CLoyplnMstField.n_custom2 : this.n_custom2,
      CLoyplnMstField.n_custom3 : this.n_custom3,
      CLoyplnMstField.n_custom4 : this.n_custom4,
      CLoyplnMstField.n_custom5 : this.n_custom5,
      CLoyplnMstField.n_custom6 : this.n_custom6,
      CLoyplnMstField.n_custom7 : this.n_custom7,
      CLoyplnMstField.n_custom8 : this.n_custom8,
      CLoyplnMstField.s_custom1 : this.s_custom1,
      CLoyplnMstField.s_custom2 : this.s_custom2,
      CLoyplnMstField.s_custom3 : this.s_custom3,
      CLoyplnMstField.s_custom4 : this.s_custom4,
      CLoyplnMstField.s_custom5 : this.s_custom5,
      CLoyplnMstField.s_custom6 : this.s_custom6,
      CLoyplnMstField.s_custom7 : this.s_custom7,
      CLoyplnMstField.s_custom8 : this.s_custom8,
      CLoyplnMstField.c_custom1 : this.c_custom1,
      CLoyplnMstField.c_custom2 : this.c_custom2,
      CLoyplnMstField.c_custom3 : this.c_custom3,
      CLoyplnMstField.c_custom4 : this.c_custom4,
      CLoyplnMstField.d_custom1 : this.d_custom1,
      CLoyplnMstField.d_custom2 : this.d_custom2,
      CLoyplnMstField.d_custom3 : this.d_custom3,
      CLoyplnMstField.d_custom4 : this.d_custom4,
    };
  }
}

/// 07_7  ロイヤリティ企画マスタ  c_loypln_mstのフィールド名設定用クラス
class CLoyplnMstField {
  static const plan_cd = "plan_cd";
  static const cpn_id = "cpn_id";
  static const all_cust_flg = "all_cust_flg";
  static const all_stre_flg = "all_stre_flg";
  static const prom_name = "prom_name";
  static const rcpt_name = "rcpt_name";
  static const svs_class = "svs_class";
  static const svs_typ = "svs_typ";
  static const reward_val = "reward_val";
  static const bdl_prc_flg = "bdl_prc_flg";
  static const bdl_qty = "bdl_qty";
  static const bdl_prc = "bdl_prc";
  static const bdl_reward_val = "bdl_reward_val";
  static const form_amt = "form_amt";
  static const form_qty = "form_qty";
  static const rec_limit = "rec_limit";
  static const day_limit = "day_limit";
  static const max_limit = "max_limit";
  static const start_datetime = "start_datetime";
  static const end_datetime = "end_datetime";
  static const stop_flg = "stop_flg";
  static const timesch_flg = "timesch_flg";
  static const sun_flg = "sun_flg";
  static const mon_flg = "mon_flg";
  static const tue_flg = "tue_flg";
  static const wed_flg = "wed_flg";
  static const thu_flg = "thu_flg";
  static const fri_flg = "fri_flg";
  static const sat_flg = "sat_flg";
  static const acct_cd = "acct_cd";
  static const seq_no = "seq_no";
  static const promo_ext_id = "promo_ext_id";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const cpn_kind = "cpn_kind";
  static const svs_kind = "svs_kind";
  static const refer_comp_cd = "refer_comp_cd";
  static const comp_cd = "comp_cd";
  static const mul_val = "mul_val";
  static const reward_flg = "reward_flg";
  static const bcd_all_cust_flg = "bcd_all_cust_flg";
  static const loy_bcd = "loy_bcd";
  static const low_lim = "low_lim";
  static const upp_lim = "upp_lim";
  static const val_flg = "val_flg";
  static const ref_typ = "ref_typ";
  static const apl_cnt = "apl_cnt";
  static const stp_acct_cd = "stp_acct_cd";
  static const stp_red_amt = "stp_red_amt";
  static const cust_kind_flg = "cust_kind_flg";
  static const date_flg1 = "date_flg1";
  static const date_flg2 = "date_flg2";
  static const date_flg3 = "date_flg3";
  static const date_flg4 = "date_flg4";
  static const date_flg5 = "date_flg5";
  static const stp_cpn_id = "stp_cpn_id";
  static const svs_content = "svs_content";
  static const cust_kind_trgt = "cust_kind_trgt";
  static const ref_typ2 = "ref_typ2";
  static const pay_key_cd = "pay_key_cd";
  static const cust_card_kind = "cust_card_kind";
  static const n_custom1 = "n_custom1";
  static const n_custom2 = "n_custom2";
  static const n_custom3 = "n_custom3";
  static const n_custom4 = "n_custom4";
  static const n_custom5 = "n_custom5";
  static const n_custom6 = "n_custom6";
  static const n_custom7 = "n_custom7";
  static const n_custom8 = "n_custom8";
  static const s_custom1 = "s_custom1";
  static const s_custom2 = "s_custom2";
  static const s_custom3 = "s_custom3";
  static const s_custom4 = "s_custom4";
  static const s_custom5 = "s_custom5";
  static const s_custom6 = "s_custom6";
  static const s_custom7 = "s_custom7";
  static const s_custom8 = "s_custom8";
  static const c_custom1 = "c_custom1";
  static const c_custom2 = "c_custom2";
  static const c_custom3 = "c_custom3";
  static const c_custom4 = "c_custom4";
  static const d_custom1 = "d_custom1";
  static const d_custom2 = "d_custom2";
  static const d_custom3 = "d_custom3";
  static const d_custom4 = "d_custom4";
}
//endregion
//region 07_8	ロイヤリティ企画商品マスタ	c_loyplu_mst
/// 07_8  ロイヤリティ企画商品マスタ  c_loyplu_mstクラス
class CLoypluMstColumns extends TableColumns{
  int? plan_cd;
  String? prom_cd;
  int? cpn_id;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? comp_cd;
  double? val = 0;
  int? ref_flg;
  int exclude_flg = 0;
  String? prom_cd2 = '0';
  int sub_cls_cd = 0;

  @override
  String _getTableName() => "c_loyplu_mst";

  @override
  String? _getKeyCondition() => 'plan_cd = ? AND prom_cd = ? AND comp_cd = ? AND ref_flg = ? AND prom_cd2 = ? AND sub_cls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(plan_cd);
    rn.add(prom_cd);
    rn.add(comp_cd);
    rn.add(ref_flg);
    rn.add(prom_cd2);
    rn.add(sub_cls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CLoypluMstColumns rn = CLoypluMstColumns();
      rn.plan_cd = maps[i]['plan_cd'];
      rn.prom_cd = maps[i]['prom_cd'];
      rn.cpn_id = maps[i]['cpn_id'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.val = maps[i]['val'];
      rn.ref_flg = maps[i]['ref_flg'];
      rn.exclude_flg = maps[i]['exclude_flg'];
      rn.prom_cd2 = maps[i]['prom_cd2'];
      rn.sub_cls_cd = maps[i]['sub_cls_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CLoypluMstColumns rn = CLoypluMstColumns();
    rn.plan_cd = maps[0]['plan_cd'];
    rn.prom_cd = maps[0]['prom_cd'];
    rn.cpn_id = maps[0]['cpn_id'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.val = maps[0]['val'];
    rn.ref_flg = maps[0]['ref_flg'];
    rn.exclude_flg = maps[0]['exclude_flg'];
    rn.prom_cd2 = maps[0]['prom_cd2'];
    rn.sub_cls_cd = maps[0]['sub_cls_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CLoypluMstField.plan_cd : this.plan_cd,
      CLoypluMstField.prom_cd : this.prom_cd,
      CLoypluMstField.cpn_id : this.cpn_id,
      CLoypluMstField.stop_flg : this.stop_flg,
      CLoypluMstField.ins_datetime : this.ins_datetime,
      CLoypluMstField.upd_datetime : this.upd_datetime,
      CLoypluMstField.status : this.status,
      CLoypluMstField.send_flg : this.send_flg,
      CLoypluMstField.upd_user : this.upd_user,
      CLoypluMstField.upd_system : this.upd_system,
      CLoypluMstField.comp_cd : this.comp_cd,
      CLoypluMstField.val : this.val,
      CLoypluMstField.ref_flg : this.ref_flg,
      CLoypluMstField.exclude_flg : this.exclude_flg,
      CLoypluMstField.prom_cd2 : this.prom_cd2,
      CLoypluMstField.sub_cls_cd : this.sub_cls_cd,
    };
  }
}

/// 07_8  ロイヤリティ企画商品マスタ  c_loyplu_mstのフィールド名設定用クラス
class CLoypluMstField {
  static const plan_cd = "plan_cd";
  static const prom_cd = "prom_cd";
  static const cpn_id = "cpn_id";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const comp_cd = "comp_cd";
  static const val = "val";
  static const ref_flg = "ref_flg";
  static const exclude_flg = "exclude_flg";
  static const prom_cd2 = "prom_cd2";
  static const sub_cls_cd = "sub_cls_cd";
}
//endregion
//region 07_9	ロイヤリティ企画メッセージマスタ	c_loytgt_mst
/// 07_9  ロイヤリティ企画メッセージマスタ c_loytgt_mstクラス
class CLoytgtMstColumns extends TableColumns{
  int? plan_cd;
  int? cpn_id;
  String? title_data;
  int title_col = 0;
  int title_siz = 0;
  String? message1;
  int message1_col = 0;
  int message1_siz = 0;
  String? message2;
  int message2_col = 0;
  int message2_siz = 0;
  String? message3;
  int message3_col = 0;
  int message3_siz = 0;
  String? message4;
  int message4_col = 0;
  int message4_siz = 0;
  String? message5;
  int message5_col = 0;
  int message5_siz = 0;
  int dialog_typ = 0;
  int dialog_img_cd = 0;
  int dialog_icon_cd = 0;
  int dialog_sound_cd = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? comp_cd;

  @override
  String _getTableName() => "c_loytgt_mst";

  @override
  String? _getKeyCondition() => 'plan_cd = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(plan_cd);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CLoytgtMstColumns rn = CLoytgtMstColumns();
      rn.plan_cd = maps[i]['plan_cd'];
      rn.cpn_id = maps[i]['cpn_id'];
      rn.title_data = maps[i]['title_data'];
      rn.title_col = maps[i]['title_col'];
      rn.title_siz = maps[i]['title_siz'];
      rn.message1 = maps[i]['message1'];
      rn.message1_col = maps[i]['message1_col'];
      rn.message1_siz = maps[i]['message1_siz'];
      rn.message2 = maps[i]['message2'];
      rn.message2_col = maps[i]['message2_col'];
      rn.message2_siz = maps[i]['message2_siz'];
      rn.message3 = maps[i]['message3'];
      rn.message3_col = maps[i]['message3_col'];
      rn.message3_siz = maps[i]['message3_siz'];
      rn.message4 = maps[i]['message4'];
      rn.message4_col = maps[i]['message4_col'];
      rn.message4_siz = maps[i]['message4_siz'];
      rn.message5 = maps[i]['message5'];
      rn.message5_col = maps[i]['message5_col'];
      rn.message5_siz = maps[i]['message5_siz'];
      rn.dialog_typ = maps[i]['dialog_typ'];
      rn.dialog_img_cd = maps[i]['dialog_img_cd'];
      rn.dialog_icon_cd = maps[i]['dialog_icon_cd'];
      rn.dialog_sound_cd = maps[i]['dialog_sound_cd'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.comp_cd = maps[i]['comp_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CLoytgtMstColumns rn = CLoytgtMstColumns();
    rn.plan_cd = maps[0]['plan_cd'];
    rn.cpn_id = maps[0]['cpn_id'];
    rn.title_data = maps[0]['title_data'];
    rn.title_col = maps[0]['title_col'];
    rn.title_siz = maps[0]['title_siz'];
    rn.message1 = maps[0]['message1'];
    rn.message1_col = maps[0]['message1_col'];
    rn.message1_siz = maps[0]['message1_siz'];
    rn.message2 = maps[0]['message2'];
    rn.message2_col = maps[0]['message2_col'];
    rn.message2_siz = maps[0]['message2_siz'];
    rn.message3 = maps[0]['message3'];
    rn.message3_col = maps[0]['message3_col'];
    rn.message3_siz = maps[0]['message3_siz'];
    rn.message4 = maps[0]['message4'];
    rn.message4_col = maps[0]['message4_col'];
    rn.message4_siz = maps[0]['message4_siz'];
    rn.message5 = maps[0]['message5'];
    rn.message5_col = maps[0]['message5_col'];
    rn.message5_siz = maps[0]['message5_siz'];
    rn.dialog_typ = maps[0]['dialog_typ'];
    rn.dialog_img_cd = maps[0]['dialog_img_cd'];
    rn.dialog_icon_cd = maps[0]['dialog_icon_cd'];
    rn.dialog_sound_cd = maps[0]['dialog_sound_cd'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.comp_cd = maps[0]['comp_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CLoytgtMstField.plan_cd : this.plan_cd,
      CLoytgtMstField.cpn_id : this.cpn_id,
      CLoytgtMstField.title_data : this.title_data,
      CLoytgtMstField.title_col : this.title_col,
      CLoytgtMstField.title_siz : this.title_siz,
      CLoytgtMstField.message1 : this.message1,
      CLoytgtMstField.message1_col : this.message1_col,
      CLoytgtMstField.message1_siz : this.message1_siz,
      CLoytgtMstField.message2 : this.message2,
      CLoytgtMstField.message2_col : this.message2_col,
      CLoytgtMstField.message2_siz : this.message2_siz,
      CLoytgtMstField.message3 : this.message3,
      CLoytgtMstField.message3_col : this.message3_col,
      CLoytgtMstField.message3_siz : this.message3_siz,
      CLoytgtMstField.message4 : this.message4,
      CLoytgtMstField.message4_col : this.message4_col,
      CLoytgtMstField.message4_siz : this.message4_siz,
      CLoytgtMstField.message5 : this.message5,
      CLoytgtMstField.message5_col : this.message5_col,
      CLoytgtMstField.message5_siz : this.message5_siz,
      CLoytgtMstField.dialog_typ : this.dialog_typ,
      CLoytgtMstField.dialog_img_cd : this.dialog_img_cd,
      CLoytgtMstField.dialog_icon_cd : this.dialog_icon_cd,
      CLoytgtMstField.dialog_sound_cd : this.dialog_sound_cd,
      CLoytgtMstField.ins_datetime : this.ins_datetime,
      CLoytgtMstField.upd_datetime : this.upd_datetime,
      CLoytgtMstField.status : this.status,
      CLoytgtMstField.send_flg : this.send_flg,
      CLoytgtMstField.upd_user : this.upd_user,
      CLoytgtMstField.upd_system : this.upd_system,
      CLoytgtMstField.comp_cd : this.comp_cd,
    };
  }
}

/// 07_9  ロイヤリティ企画メッセージマスタ c_loytgt_mstのフィールド名設定用クラス
class CLoytgtMstField {
  static const plan_cd = "plan_cd";
  static const cpn_id = "cpn_id";
  static const title_data = "title_data";
  static const title_col = "title_col";
  static const title_siz = "title_siz";
  static const message1 = "message1";
  static const message1_col = "message1_col";
  static const message1_siz = "message1_siz";
  static const message2 = "message2";
  static const message2_col = "message2_col";
  static const message2_siz = "message2_siz";
  static const message3 = "message3";
  static const message3_col = "message3_col";
  static const message3_siz = "message3_siz";
  static const message4 = "message4";
  static const message4_col = "message4_col";
  static const message4_siz = "message4_siz";
  static const message5 = "message5";
  static const message5_col = "message5_col";
  static const message5_siz = "message5_siz";
  static const dialog_typ = "dialog_typ";
  static const dialog_img_cd = "dialog_img_cd";
  static const dialog_icon_cd = "dialog_icon_cd";
  static const dialog_sound_cd = "dialog_sound_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const comp_cd = "comp_cd";
}
//endregion
//region 07_10	顧客プロモーションテーブル	s_cust_loy_tbl
/// 07_10 顧客プロモーションテーブル  s_cust_loy_tblクラス
class SCustLoyTblColumns extends TableColumns{
  String? cust_no;
  int? cpn_id;
  int? comp_cd;
  String plan_cd = '{0}';
  String tday_cnt = '{0}';
  String total_cnt = '{0}';
  String? last_sellday;
  String prn_seq_no = '{0}';
  String prn_flg = '{0}';
  String target_flg = '{0}';
  String stop_flg = '{0}';
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "s_cust_loy_tbl";

  @override
  String? _getKeyCondition() => 'cust_no = ? AND cpn_id = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cust_no);
    rn.add(cpn_id);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SCustLoyTblColumns rn = SCustLoyTblColumns();
      rn.cust_no = maps[i]['cust_no'];
      rn.cpn_id = maps[i]['cpn_id'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.tday_cnt = maps[i]['tday_cnt'];
      rn.total_cnt = maps[i]['total_cnt'];
      rn.last_sellday = maps[i]['last_sellday'];
      rn.prn_seq_no = maps[i]['prn_seq_no'];
      rn.prn_flg = maps[i]['prn_flg'];
      rn.target_flg = maps[i]['target_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SCustLoyTblColumns rn = SCustLoyTblColumns();
    rn.cust_no = maps[0]['cust_no'];
    rn.cpn_id = maps[0]['cpn_id'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.tday_cnt = maps[0]['tday_cnt'];
    rn.total_cnt = maps[0]['total_cnt'];
    rn.last_sellday = maps[0]['last_sellday'];
    rn.prn_seq_no = maps[0]['prn_seq_no'];
    rn.prn_flg = maps[0]['prn_flg'];
    rn.target_flg = maps[0]['target_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SCustLoyTblField.cust_no : this.cust_no,
      SCustLoyTblField.cpn_id : this.cpn_id,
      SCustLoyTblField.comp_cd : this.comp_cd,
      SCustLoyTblField.plan_cd : this.plan_cd,
      SCustLoyTblField.tday_cnt : this.tday_cnt,
      SCustLoyTblField.total_cnt : this.total_cnt,
      SCustLoyTblField.last_sellday : this.last_sellday,
      SCustLoyTblField.prn_seq_no : this.prn_seq_no,
      SCustLoyTblField.prn_flg : this.prn_flg,
      SCustLoyTblField.target_flg : this.target_flg,
      SCustLoyTblField.stop_flg : this.stop_flg,
      SCustLoyTblField.ins_datetime : this.ins_datetime,
      SCustLoyTblField.upd_datetime : this.upd_datetime,
      SCustLoyTblField.status : this.status,
      SCustLoyTblField.send_flg : this.send_flg,
      SCustLoyTblField.upd_user : this.upd_user,
      SCustLoyTblField.upd_system : this.upd_system,
    };
  }
}

/// 07_10 顧客プロモーションテーブル  s_cust_loy_tblのフィールド名設定用クラス
class SCustLoyTblField {
  static const cust_no = "cust_no";
  static const cpn_id = "cpn_id";
  static const comp_cd = "comp_cd";
  static const plan_cd = "plan_cd";
  static const tday_cnt = "tday_cnt";
  static const total_cnt = "total_cnt";
  static const last_sellday = "last_sellday";
  static const prn_seq_no = "prn_seq_no";
  static const prn_flg = "prn_flg";
  static const target_flg = "target_flg";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 07_11	顧客別累計購買情報テーブル	s_cust_ttl_tbl
/// 07_11 顧客別累計購買情報テーブル  s_cust_ttl_tblクラス
class SCustTtlTblColumns extends TableColumns{
  String? cust_no;
  int? comp_cd;
  int? stre_cd;
  String? srch_cust_no;
  int acct_cd_1 = 0;
  int acct_totalpnt_1 = 0;
  int acct_totalamt_1 = 0;
  int acct_totalqty_1 = 0;
  int acct_cd_2 = 0;
  int acct_totalpnt_2 = 0;
  int acct_totalamt_2 = 0;
  int acct_totalqty_2 = 0;
  int acct_cd_3 = 0;
  int acct_totalpnt_3 = 0;
  int acct_totalamt_3 = 0;
  int acct_totalqty_3 = 0;
  int acct_cd_4 = 0;
  int acct_totalpnt_4 = 0;
  int acct_totalamt_4 = 0;
  int acct_totalqty_4 = 0;
  int acct_cd_5 = 0;
  int acct_totalpnt_5 = 0;
  int acct_totalamt_5 = 0;
  int acct_totalqty_5 = 0;
  int month_amt_1 = 0;
  int month_amt_2 = 0;
  int month_amt_3 = 0;
  int month_amt_4 = 0;
  int month_amt_5 = 0;
  int month_amt_6 = 0;
  int month_amt_7 = 0;
  int month_amt_8 = 0;
  int month_amt_9 = 0;
  int month_amt_10 = 0;
  int month_amt_11 = 0;
  int month_amt_12 = 0;
  String? month_visit_date_1;
  String? month_visit_date_2;
  String? month_visit_date_3;
  String? month_visit_date_4;
  String? month_visit_date_5;
  String? month_visit_date_6;
  String? month_visit_date_7;
  String? month_visit_date_8;
  String? month_visit_date_9;
  String? month_visit_date_10;
  String? month_visit_date_11;
  String? month_visit_date_12;
  int month_visit_cnt_1 = 0;
  int month_visit_cnt_2 = 0;
  int month_visit_cnt_3 = 0;
  int month_visit_cnt_4 = 0;
  int month_visit_cnt_5 = 0;
  int month_visit_cnt_6 = 0;
  int month_visit_cnt_7 = 0;
  int month_visit_cnt_8 = 0;
  int month_visit_cnt_9 = 0;
  int month_visit_cnt_10 = 0;
  int month_visit_cnt_11 = 0;
  int month_visit_cnt_12 = 0;
  int bnsdsc_amt = 0;
  String? bnsdsc_visit_date;
  int ttl_amt = 0;
  String? delivery_date;
  String? last_name;
  String? first_name;
  String? birth_day;
  String? tel_no1;
  String? tel_no2;
  String? last_visit_date;
  int pnt_service_type = 0;
  int pnt_service_limit = 0;
  int portal_flg = 0;
  int enq_comp_cd = 0;
  int enq_stre_cd = 0;
  int enq_mac_no = 0;
  String? enq_datetime;
  int cust_status = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int targ_typ = 0;
  int staff_flg = 0;
  int cust_prc_type = 0;
  int sch_acct_cd_1 = 0;
  int acct_accval_1 = 0;
  int acct_optotal_1 = 0;
  int sch_acct_cd_2 = 0;
  int acct_accval_2 = 0;
  int acct_optotal_2 = 0;
  int sch_acct_cd_3 = 0;
  int acct_accval_3 = 0;
  int acct_optotal_3 = 0;
  int sch_acct_cd_4 = 0;
  int acct_accval_4 = 0;
  int acct_optotal_4 = 0;
  int sch_acct_cd_5 = 0;
  int acct_accval_5 = 0;
  int acct_optotal_5 = 0;
  String? c_data1;
  int n_data1 = 0;
  int n_data2 = 0;
  int n_data3 = 0;
  int n_data4 = 0;
  int n_data5 = 0;
  int n_data6 = 0;
  int n_data7 = 0;
  int n_data8 = 0;
  int n_data9 = 0;
  int n_data10 = 0;
  int n_data11 = 0;
  int n_data12 = 0;
  int n_data13 = 0;
  int n_data14 = 0;
  int n_data15 = 0;
  int n_data16 = 0;
  int s_data1 = 0;
  int s_data2 = 0;
  int s_data3 = 0;
  String? d_data1;
  String? d_data2;
  String? d_data3;
  String? d_data4;
  String? d_data5;
  String? d_data6;
  String? d_data7;
  String? d_data8;
  String? d_data9;
  String? d_data10;

  @override
  String _getTableName() => "s_cust_ttl_tbl";

  @override
  String? _getKeyCondition() => 'cust_no = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cust_no);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SCustTtlTblColumns rn = SCustTtlTblColumns();
      rn.cust_no = maps[i]['cust_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.srch_cust_no = maps[i]['srch_cust_no'];
      rn.acct_cd_1 = maps[i]['acct_cd_1'];
      rn.acct_totalpnt_1 = maps[i]['acct_totalpnt_1'];
      rn.acct_totalamt_1 = maps[i]['acct_totalamt_1'];
      rn.acct_totalqty_1 = maps[i]['acct_totalqty_1'];
      rn.acct_cd_2 = maps[i]['acct_cd_2'];
      rn.acct_totalpnt_2 = maps[i]['acct_totalpnt_2'];
      rn.acct_totalamt_2 = maps[i]['acct_totalamt_2'];
      rn.acct_totalqty_2 = maps[i]['acct_totalqty_2'];
      rn.acct_cd_3 = maps[i]['acct_cd_3'];
      rn.acct_totalpnt_3 = maps[i]['acct_totalpnt_3'];
      rn.acct_totalamt_3 = maps[i]['acct_totalamt_3'];
      rn.acct_totalqty_3 = maps[i]['acct_totalqty_3'];
      rn.acct_cd_4 = maps[i]['acct_cd_4'];
      rn.acct_totalpnt_4 = maps[i]['acct_totalpnt_4'];
      rn.acct_totalamt_4 = maps[i]['acct_totalamt_4'];
      rn.acct_totalqty_4 = maps[i]['acct_totalqty_4'];
      rn.acct_cd_5 = maps[i]['acct_cd_5'];
      rn.acct_totalpnt_5 = maps[i]['acct_totalpnt_5'];
      rn.acct_totalamt_5 = maps[i]['acct_totalamt_5'];
      rn.acct_totalqty_5 = maps[i]['acct_totalqty_5'];
      rn.month_amt_1 = maps[i]['month_amt_1'];
      rn.month_amt_2 = maps[i]['month_amt_2'];
      rn.month_amt_3 = maps[i]['month_amt_3'];
      rn.month_amt_4 = maps[i]['month_amt_4'];
      rn.month_amt_5 = maps[i]['month_amt_5'];
      rn.month_amt_6 = maps[i]['month_amt_6'];
      rn.month_amt_7 = maps[i]['month_amt_7'];
      rn.month_amt_8 = maps[i]['month_amt_8'];
      rn.month_amt_9 = maps[i]['month_amt_9'];
      rn.month_amt_10 = maps[i]['month_amt_10'];
      rn.month_amt_11 = maps[i]['month_amt_11'];
      rn.month_amt_12 = maps[i]['month_amt_12'];
      rn.month_visit_date_1 = maps[i]['month_visit_date_1'];
      rn.month_visit_date_2 = maps[i]['month_visit_date_2'];
      rn.month_visit_date_3 = maps[i]['month_visit_date_3'];
      rn.month_visit_date_4 = maps[i]['month_visit_date_4'];
      rn.month_visit_date_5 = maps[i]['month_visit_date_5'];
      rn.month_visit_date_6 = maps[i]['month_visit_date_6'];
      rn.month_visit_date_7 = maps[i]['month_visit_date_7'];
      rn.month_visit_date_8 = maps[i]['month_visit_date_8'];
      rn.month_visit_date_9 = maps[i]['month_visit_date_9'];
      rn.month_visit_date_10 = maps[i]['month_visit_date_10'];
      rn.month_visit_date_11 = maps[i]['month_visit_date_11'];
      rn.month_visit_date_12 = maps[i]['month_visit_date_12'];
      rn.month_visit_cnt_1 = maps[i]['month_visit_cnt_1'];
      rn.month_visit_cnt_2 = maps[i]['month_visit_cnt_2'];
      rn.month_visit_cnt_3 = maps[i]['month_visit_cnt_3'];
      rn.month_visit_cnt_4 = maps[i]['month_visit_cnt_4'];
      rn.month_visit_cnt_5 = maps[i]['month_visit_cnt_5'];
      rn.month_visit_cnt_6 = maps[i]['month_visit_cnt_6'];
      rn.month_visit_cnt_7 = maps[i]['month_visit_cnt_7'];
      rn.month_visit_cnt_8 = maps[i]['month_visit_cnt_8'];
      rn.month_visit_cnt_9 = maps[i]['month_visit_cnt_9'];
      rn.month_visit_cnt_10 = maps[i]['month_visit_cnt_10'];
      rn.month_visit_cnt_11 = maps[i]['month_visit_cnt_11'];
      rn.month_visit_cnt_12 = maps[i]['month_visit_cnt_12'];
      rn.bnsdsc_amt = maps[i]['bnsdsc_amt'];
      rn.bnsdsc_visit_date = maps[i]['bnsdsc_visit_date'];
      rn.ttl_amt = maps[i]['ttl_amt'];
      rn.delivery_date = maps[i]['delivery_date'];
      rn.last_name = maps[i]['last_name'];
      rn.first_name = maps[i]['first_name'];
      rn.birth_day = maps[i]['birth_day'];
      rn.tel_no1 = maps[i]['tel_no1'];
      rn.tel_no2 = maps[i]['tel_no2'];
      rn.last_visit_date = maps[i]['last_visit_date'];
      rn.pnt_service_type = maps[i]['pnt_service_type'];
      rn.pnt_service_limit = maps[i]['pnt_service_limit'];
      rn.portal_flg = maps[i]['portal_flg'];
      rn.enq_comp_cd = maps[i]['enq_comp_cd'];
      rn.enq_stre_cd = maps[i]['enq_stre_cd'];
      rn.enq_mac_no = maps[i]['enq_mac_no'];
      rn.enq_datetime = maps[i]['enq_datetime'];
      rn.cust_status = maps[i]['cust_status'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.targ_typ = maps[i]['targ_typ'];
      rn.staff_flg = maps[i]['staff_flg'];
      rn.cust_prc_type = maps[i]['cust_prc_type'];
      rn.sch_acct_cd_1 = maps[i]['sch_acct_cd_1'];
      rn.acct_accval_1 = maps[i]['acct_accval_1'];
      rn.acct_optotal_1 = maps[i]['acct_optotal_1'];
      rn.sch_acct_cd_2 = maps[i]['sch_acct_cd_2'];
      rn.acct_accval_2 = maps[i]['acct_accval_2'];
      rn.acct_optotal_2 = maps[i]['acct_optotal_2'];
      rn.sch_acct_cd_3 = maps[i]['sch_acct_cd_3'];
      rn.acct_accval_3 = maps[i]['acct_accval_3'];
      rn.acct_optotal_3 = maps[i]['acct_optotal_3'];
      rn.sch_acct_cd_4 = maps[i]['sch_acct_cd_4'];
      rn.acct_accval_4 = maps[i]['acct_accval_4'];
      rn.acct_optotal_4 = maps[i]['acct_optotal_4'];
      rn.sch_acct_cd_5 = maps[i]['sch_acct_cd_5'];
      rn.acct_accval_5 = maps[i]['acct_accval_5'];
      rn.acct_optotal_5 = maps[i]['acct_optotal_5'];
      rn.c_data1 = maps[i]['c_data1'];
      rn.n_data1 = maps[i]['n_data1'];
      rn.n_data2 = maps[i]['n_data2'];
      rn.n_data3 = maps[i]['n_data3'];
      rn.n_data4 = maps[i]['n_data4'];
      rn.n_data5 = maps[i]['n_data5'];
      rn.n_data6 = maps[i]['n_data6'];
      rn.n_data7 = maps[i]['n_data7'];
      rn.n_data8 = maps[i]['n_data8'];
      rn.n_data9 = maps[i]['n_data9'];
      rn.n_data10 = maps[i]['n_data10'];
      rn.n_data11 = maps[i]['n_data11'];
      rn.n_data12 = maps[i]['n_data12'];
      rn.n_data13 = maps[i]['n_data13'];
      rn.n_data14 = maps[i]['n_data14'];
      rn.n_data15 = maps[i]['n_data15'];
      rn.n_data16 = maps[i]['n_data16'];
      rn.s_data1 = maps[i]['s_data1'];
      rn.s_data2 = maps[i]['s_data2'];
      rn.s_data3 = maps[i]['s_data3'];
      rn.d_data1 = maps[i]['d_data1'];
      rn.d_data2 = maps[i]['d_data2'];
      rn.d_data3 = maps[i]['d_data3'];
      rn.d_data4 = maps[i]['d_data4'];
      rn.d_data5 = maps[i]['d_data5'];
      rn.d_data6 = maps[i]['d_data6'];
      rn.d_data7 = maps[i]['d_data7'];
      rn.d_data8 = maps[i]['d_data8'];
      rn.d_data9 = maps[i]['d_data9'];
      rn.d_data10 = maps[i]['d_data10'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SCustTtlTblColumns rn = SCustTtlTblColumns();
    rn.cust_no = maps[0]['cust_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.srch_cust_no = maps[0]['srch_cust_no'];
    rn.acct_cd_1 = maps[0]['acct_cd_1'];
    rn.acct_totalpnt_1 = maps[0]['acct_totalpnt_1'];
    rn.acct_totalamt_1 = maps[0]['acct_totalamt_1'];
    rn.acct_totalqty_1 = maps[0]['acct_totalqty_1'];
    rn.acct_cd_2 = maps[0]['acct_cd_2'];
    rn.acct_totalpnt_2 = maps[0]['acct_totalpnt_2'];
    rn.acct_totalamt_2 = maps[0]['acct_totalamt_2'];
    rn.acct_totalqty_2 = maps[0]['acct_totalqty_2'];
    rn.acct_cd_3 = maps[0]['acct_cd_3'];
    rn.acct_totalpnt_3 = maps[0]['acct_totalpnt_3'];
    rn.acct_totalamt_3 = maps[0]['acct_totalamt_3'];
    rn.acct_totalqty_3 = maps[0]['acct_totalqty_3'];
    rn.acct_cd_4 = maps[0]['acct_cd_4'];
    rn.acct_totalpnt_4 = maps[0]['acct_totalpnt_4'];
    rn.acct_totalamt_4 = maps[0]['acct_totalamt_4'];
    rn.acct_totalqty_4 = maps[0]['acct_totalqty_4'];
    rn.acct_cd_5 = maps[0]['acct_cd_5'];
    rn.acct_totalpnt_5 = maps[0]['acct_totalpnt_5'];
    rn.acct_totalamt_5 = maps[0]['acct_totalamt_5'];
    rn.acct_totalqty_5 = maps[0]['acct_totalqty_5'];
    rn.month_amt_1 = maps[0]['month_amt_1'];
    rn.month_amt_2 = maps[0]['month_amt_2'];
    rn.month_amt_3 = maps[0]['month_amt_3'];
    rn.month_amt_4 = maps[0]['month_amt_4'];
    rn.month_amt_5 = maps[0]['month_amt_5'];
    rn.month_amt_6 = maps[0]['month_amt_6'];
    rn.month_amt_7 = maps[0]['month_amt_7'];
    rn.month_amt_8 = maps[0]['month_amt_8'];
    rn.month_amt_9 = maps[0]['month_amt_9'];
    rn.month_amt_10 = maps[0]['month_amt_10'];
    rn.month_amt_11 = maps[0]['month_amt_11'];
    rn.month_amt_12 = maps[0]['month_amt_12'];
    rn.month_visit_date_1 = maps[0]['month_visit_date_1'];
    rn.month_visit_date_2 = maps[0]['month_visit_date_2'];
    rn.month_visit_date_3 = maps[0]['month_visit_date_3'];
    rn.month_visit_date_4 = maps[0]['month_visit_date_4'];
    rn.month_visit_date_5 = maps[0]['month_visit_date_5'];
    rn.month_visit_date_6 = maps[0]['month_visit_date_6'];
    rn.month_visit_date_7 = maps[0]['month_visit_date_7'];
    rn.month_visit_date_8 = maps[0]['month_visit_date_8'];
    rn.month_visit_date_9 = maps[0]['month_visit_date_9'];
    rn.month_visit_date_10 = maps[0]['month_visit_date_10'];
    rn.month_visit_date_11 = maps[0]['month_visit_date_11'];
    rn.month_visit_date_12 = maps[0]['month_visit_date_12'];
    rn.month_visit_cnt_1 = maps[0]['month_visit_cnt_1'];
    rn.month_visit_cnt_2 = maps[0]['month_visit_cnt_2'];
    rn.month_visit_cnt_3 = maps[0]['month_visit_cnt_3'];
    rn.month_visit_cnt_4 = maps[0]['month_visit_cnt_4'];
    rn.month_visit_cnt_5 = maps[0]['month_visit_cnt_5'];
    rn.month_visit_cnt_6 = maps[0]['month_visit_cnt_6'];
    rn.month_visit_cnt_7 = maps[0]['month_visit_cnt_7'];
    rn.month_visit_cnt_8 = maps[0]['month_visit_cnt_8'];
    rn.month_visit_cnt_9 = maps[0]['month_visit_cnt_9'];
    rn.month_visit_cnt_10 = maps[0]['month_visit_cnt_10'];
    rn.month_visit_cnt_11 = maps[0]['month_visit_cnt_11'];
    rn.month_visit_cnt_12 = maps[0]['month_visit_cnt_12'];
    rn.bnsdsc_amt = maps[0]['bnsdsc_amt'];
    rn.bnsdsc_visit_date = maps[0]['bnsdsc_visit_date'];
    rn.ttl_amt = maps[0]['ttl_amt'];
    rn.delivery_date = maps[0]['delivery_date'];
    rn.last_name = maps[0]['last_name'];
    rn.first_name = maps[0]['first_name'];
    rn.birth_day = maps[0]['birth_day'];
    rn.tel_no1 = maps[0]['tel_no1'];
    rn.tel_no2 = maps[0]['tel_no2'];
    rn.last_visit_date = maps[0]['last_visit_date'];
    rn.pnt_service_type = maps[0]['pnt_service_type'];
    rn.pnt_service_limit = maps[0]['pnt_service_limit'];
    rn.portal_flg = maps[0]['portal_flg'];
    rn.enq_comp_cd = maps[0]['enq_comp_cd'];
    rn.enq_stre_cd = maps[0]['enq_stre_cd'];
    rn.enq_mac_no = maps[0]['enq_mac_no'];
    rn.enq_datetime = maps[0]['enq_datetime'];
    rn.cust_status = maps[0]['cust_status'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.targ_typ = maps[0]['targ_typ'];
    rn.staff_flg = maps[0]['staff_flg'];
    rn.cust_prc_type = maps[0]['cust_prc_type'];
    rn.sch_acct_cd_1 = maps[0]['sch_acct_cd_1'];
    rn.acct_accval_1 = maps[0]['acct_accval_1'];
    rn.acct_optotal_1 = maps[0]['acct_optotal_1'];
    rn.sch_acct_cd_2 = maps[0]['sch_acct_cd_2'];
    rn.acct_accval_2 = maps[0]['acct_accval_2'];
    rn.acct_optotal_2 = maps[0]['acct_optotal_2'];
    rn.sch_acct_cd_3 = maps[0]['sch_acct_cd_3'];
    rn.acct_accval_3 = maps[0]['acct_accval_3'];
    rn.acct_optotal_3 = maps[0]['acct_optotal_3'];
    rn.sch_acct_cd_4 = maps[0]['sch_acct_cd_4'];
    rn.acct_accval_4 = maps[0]['acct_accval_4'];
    rn.acct_optotal_4 = maps[0]['acct_optotal_4'];
    rn.sch_acct_cd_5 = maps[0]['sch_acct_cd_5'];
    rn.acct_accval_5 = maps[0]['acct_accval_5'];
    rn.acct_optotal_5 = maps[0]['acct_optotal_5'];
    rn.c_data1 = maps[0]['c_data1'];
    rn.n_data1 = maps[0]['n_data1'];
    rn.n_data2 = maps[0]['n_data2'];
    rn.n_data3 = maps[0]['n_data3'];
    rn.n_data4 = maps[0]['n_data4'];
    rn.n_data5 = maps[0]['n_data5'];
    rn.n_data6 = maps[0]['n_data6'];
    rn.n_data7 = maps[0]['n_data7'];
    rn.n_data8 = maps[0]['n_data8'];
    rn.n_data9 = maps[0]['n_data9'];
    rn.n_data10 = maps[0]['n_data10'];
    rn.n_data11 = maps[0]['n_data11'];
    rn.n_data12 = maps[0]['n_data12'];
    rn.n_data13 = maps[0]['n_data13'];
    rn.n_data14 = maps[0]['n_data14'];
    rn.n_data15 = maps[0]['n_data15'];
    rn.n_data16 = maps[0]['n_data16'];
    rn.s_data1 = maps[0]['s_data1'];
    rn.s_data2 = maps[0]['s_data2'];
    rn.s_data3 = maps[0]['s_data3'];
    rn.d_data1 = maps[0]['d_data1'];
    rn.d_data2 = maps[0]['d_data2'];
    rn.d_data3 = maps[0]['d_data3'];
    rn.d_data4 = maps[0]['d_data4'];
    rn.d_data5 = maps[0]['d_data5'];
    rn.d_data6 = maps[0]['d_data6'];
    rn.d_data7 = maps[0]['d_data7'];
    rn.d_data8 = maps[0]['d_data8'];
    rn.d_data9 = maps[0]['d_data9'];
    rn.d_data10 = maps[0]['d_data10'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SCustTtlTblField.cust_no : this.cust_no,
      SCustTtlTblField.comp_cd : this.comp_cd,
      SCustTtlTblField.stre_cd : this.stre_cd,
      SCustTtlTblField.srch_cust_no : this.srch_cust_no,
      SCustTtlTblField.acct_cd_1 : this.acct_cd_1,
      SCustTtlTblField.acct_totalpnt_1 : this.acct_totalpnt_1,
      SCustTtlTblField.acct_totalamt_1 : this.acct_totalamt_1,
      SCustTtlTblField.acct_totalqty_1 : this.acct_totalqty_1,
      SCustTtlTblField.acct_cd_2 : this.acct_cd_2,
      SCustTtlTblField.acct_totalpnt_2 : this.acct_totalpnt_2,
      SCustTtlTblField.acct_totalamt_2 : this.acct_totalamt_2,
      SCustTtlTblField.acct_totalqty_2 : this.acct_totalqty_2,
      SCustTtlTblField.acct_cd_3 : this.acct_cd_3,
      SCustTtlTblField.acct_totalpnt_3 : this.acct_totalpnt_3,
      SCustTtlTblField.acct_totalamt_3 : this.acct_totalamt_3,
      SCustTtlTblField.acct_totalqty_3 : this.acct_totalqty_3,
      SCustTtlTblField.acct_cd_4 : this.acct_cd_4,
      SCustTtlTblField.acct_totalpnt_4 : this.acct_totalpnt_4,
      SCustTtlTblField.acct_totalamt_4 : this.acct_totalamt_4,
      SCustTtlTblField.acct_totalqty_4 : this.acct_totalqty_4,
      SCustTtlTblField.acct_cd_5 : this.acct_cd_5,
      SCustTtlTblField.acct_totalpnt_5 : this.acct_totalpnt_5,
      SCustTtlTblField.acct_totalamt_5 : this.acct_totalamt_5,
      SCustTtlTblField.acct_totalqty_5 : this.acct_totalqty_5,
      SCustTtlTblField.month_amt_1 : this.month_amt_1,
      SCustTtlTblField.month_amt_2 : this.month_amt_2,
      SCustTtlTblField.month_amt_3 : this.month_amt_3,
      SCustTtlTblField.month_amt_4 : this.month_amt_4,
      SCustTtlTblField.month_amt_5 : this.month_amt_5,
      SCustTtlTblField.month_amt_6 : this.month_amt_6,
      SCustTtlTblField.month_amt_7 : this.month_amt_7,
      SCustTtlTblField.month_amt_8 : this.month_amt_8,
      SCustTtlTblField.month_amt_9 : this.month_amt_9,
      SCustTtlTblField.month_amt_10 : this.month_amt_10,
      SCustTtlTblField.month_amt_11 : this.month_amt_11,
      SCustTtlTblField.month_amt_12 : this.month_amt_12,
      SCustTtlTblField.month_visit_date_1 : this.month_visit_date_1,
      SCustTtlTblField.month_visit_date_2 : this.month_visit_date_2,
      SCustTtlTblField.month_visit_date_3 : this.month_visit_date_3,
      SCustTtlTblField.month_visit_date_4 : this.month_visit_date_4,
      SCustTtlTblField.month_visit_date_5 : this.month_visit_date_5,
      SCustTtlTblField.month_visit_date_6 : this.month_visit_date_6,
      SCustTtlTblField.month_visit_date_7 : this.month_visit_date_7,
      SCustTtlTblField.month_visit_date_8 : this.month_visit_date_8,
      SCustTtlTblField.month_visit_date_9 : this.month_visit_date_9,
      SCustTtlTblField.month_visit_date_10 : this.month_visit_date_10,
      SCustTtlTblField.month_visit_date_11 : this.month_visit_date_11,
      SCustTtlTblField.month_visit_date_12 : this.month_visit_date_12,
      SCustTtlTblField.month_visit_cnt_1 : this.month_visit_cnt_1,
      SCustTtlTblField.month_visit_cnt_2 : this.month_visit_cnt_2,
      SCustTtlTblField.month_visit_cnt_3 : this.month_visit_cnt_3,
      SCustTtlTblField.month_visit_cnt_4 : this.month_visit_cnt_4,
      SCustTtlTblField.month_visit_cnt_5 : this.month_visit_cnt_5,
      SCustTtlTblField.month_visit_cnt_6 : this.month_visit_cnt_6,
      SCustTtlTblField.month_visit_cnt_7 : this.month_visit_cnt_7,
      SCustTtlTblField.month_visit_cnt_8 : this.month_visit_cnt_8,
      SCustTtlTblField.month_visit_cnt_9 : this.month_visit_cnt_9,
      SCustTtlTblField.month_visit_cnt_10 : this.month_visit_cnt_10,
      SCustTtlTblField.month_visit_cnt_11 : this.month_visit_cnt_11,
      SCustTtlTblField.month_visit_cnt_12 : this.month_visit_cnt_12,
      SCustTtlTblField.bnsdsc_amt : this.bnsdsc_amt,
      SCustTtlTblField.bnsdsc_visit_date : this.bnsdsc_visit_date,
      SCustTtlTblField.ttl_amt : this.ttl_amt,
      SCustTtlTblField.delivery_date : this.delivery_date,
      SCustTtlTblField.last_name : this.last_name,
      SCustTtlTblField.first_name : this.first_name,
      SCustTtlTblField.birth_day : this.birth_day,
      SCustTtlTblField.tel_no1 : this.tel_no1,
      SCustTtlTblField.tel_no2 : this.tel_no2,
      SCustTtlTblField.last_visit_date : this.last_visit_date,
      SCustTtlTblField.pnt_service_type : this.pnt_service_type,
      SCustTtlTblField.pnt_service_limit : this.pnt_service_limit,
      SCustTtlTblField.portal_flg : this.portal_flg,
      SCustTtlTblField.enq_comp_cd : this.enq_comp_cd,
      SCustTtlTblField.enq_stre_cd : this.enq_stre_cd,
      SCustTtlTblField.enq_mac_no : this.enq_mac_no,
      SCustTtlTblField.enq_datetime : this.enq_datetime,
      SCustTtlTblField.cust_status : this.cust_status,
      SCustTtlTblField.ins_datetime : this.ins_datetime,
      SCustTtlTblField.upd_datetime : this.upd_datetime,
      SCustTtlTblField.status : this.status,
      SCustTtlTblField.send_flg : this.send_flg,
      SCustTtlTblField.upd_user : this.upd_user,
      SCustTtlTblField.upd_system : this.upd_system,
      SCustTtlTblField.targ_typ : this.targ_typ,
      SCustTtlTblField.staff_flg : this.staff_flg,
      SCustTtlTblField.cust_prc_type : this.cust_prc_type,
      SCustTtlTblField.sch_acct_cd_1 : this.sch_acct_cd_1,
      SCustTtlTblField.acct_accval_1 : this.acct_accval_1,
      SCustTtlTblField.acct_optotal_1 : this.acct_optotal_1,
      SCustTtlTblField.sch_acct_cd_2 : this.sch_acct_cd_2,
      SCustTtlTblField.acct_accval_2 : this.acct_accval_2,
      SCustTtlTblField.acct_optotal_2 : this.acct_optotal_2,
      SCustTtlTblField.sch_acct_cd_3 : this.sch_acct_cd_3,
      SCustTtlTblField.acct_accval_3 : this.acct_accval_3,
      SCustTtlTblField.acct_optotal_3 : this.acct_optotal_3,
      SCustTtlTblField.sch_acct_cd_4 : this.sch_acct_cd_4,
      SCustTtlTblField.acct_accval_4 : this.acct_accval_4,
      SCustTtlTblField.acct_optotal_4 : this.acct_optotal_4,
      SCustTtlTblField.sch_acct_cd_5 : this.sch_acct_cd_5,
      SCustTtlTblField.acct_accval_5 : this.acct_accval_5,
      SCustTtlTblField.acct_optotal_5 : this.acct_optotal_5,
      SCustTtlTblField.c_data1 : this.c_data1,
      SCustTtlTblField.n_data1 : this.n_data1,
      SCustTtlTblField.n_data2 : this.n_data2,
      SCustTtlTblField.n_data3 : this.n_data3,
      SCustTtlTblField.n_data4 : this.n_data4,
      SCustTtlTblField.n_data5 : this.n_data5,
      SCustTtlTblField.n_data6 : this.n_data6,
      SCustTtlTblField.n_data7 : this.n_data7,
      SCustTtlTblField.n_data8 : this.n_data8,
      SCustTtlTblField.n_data9 : this.n_data9,
      SCustTtlTblField.n_data10 : this.n_data10,
      SCustTtlTblField.n_data11 : this.n_data11,
      SCustTtlTblField.n_data12 : this.n_data12,
      SCustTtlTblField.n_data13 : this.n_data13,
      SCustTtlTblField.n_data14 : this.n_data14,
      SCustTtlTblField.n_data15 : this.n_data15,
      SCustTtlTblField.n_data16 : this.n_data16,
      SCustTtlTblField.s_data1 : this.s_data1,
      SCustTtlTblField.s_data2 : this.s_data2,
      SCustTtlTblField.s_data3 : this.s_data3,
      SCustTtlTblField.d_data1 : this.d_data1,
      SCustTtlTblField.d_data2 : this.d_data2,
      SCustTtlTblField.d_data3 : this.d_data3,
      SCustTtlTblField.d_data4 : this.d_data4,
      SCustTtlTblField.d_data5 : this.d_data5,
      SCustTtlTblField.d_data6 : this.d_data6,
      SCustTtlTblField.d_data7 : this.d_data7,
      SCustTtlTblField.d_data8 : this.d_data8,
      SCustTtlTblField.d_data9 : this.d_data9,
      SCustTtlTblField.d_data10 : this.d_data10,
    };
  }
}

/// 07_11 顧客別累計購買情報テーブル  s_cust_ttl_tblのフィールド名設定用クラス
class SCustTtlTblField {
  static const cust_no = "cust_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const srch_cust_no = "srch_cust_no";
  static const acct_cd_1 = "acct_cd_1";
  static const acct_totalpnt_1 = "acct_totalpnt_1";
  static const acct_totalamt_1 = "acct_totalamt_1";
  static const acct_totalqty_1 = "acct_totalqty_1";
  static const acct_cd_2 = "acct_cd_2";
  static const acct_totalpnt_2 = "acct_totalpnt_2";
  static const acct_totalamt_2 = "acct_totalamt_2";
  static const acct_totalqty_2 = "acct_totalqty_2";
  static const acct_cd_3 = "acct_cd_3";
  static const acct_totalpnt_3 = "acct_totalpnt_3";
  static const acct_totalamt_3 = "acct_totalamt_3";
  static const acct_totalqty_3 = "acct_totalqty_3";
  static const acct_cd_4 = "acct_cd_4";
  static const acct_totalpnt_4 = "acct_totalpnt_4";
  static const acct_totalamt_4 = "acct_totalamt_4";
  static const acct_totalqty_4 = "acct_totalqty_4";
  static const acct_cd_5 = "acct_cd_5";
  static const acct_totalpnt_5 = "acct_totalpnt_5";
  static const acct_totalamt_5 = "acct_totalamt_5";
  static const acct_totalqty_5 = "acct_totalqty_5";
  static const month_amt_1 = "month_amt_1";
  static const month_amt_2 = "month_amt_2";
  static const month_amt_3 = "month_amt_3";
  static const month_amt_4 = "month_amt_4";
  static const month_amt_5 = "month_amt_5";
  static const month_amt_6 = "month_amt_6";
  static const month_amt_7 = "month_amt_7";
  static const month_amt_8 = "month_amt_8";
  static const month_amt_9 = "month_amt_9";
  static const month_amt_10 = "month_amt_10";
  static const month_amt_11 = "month_amt_11";
  static const month_amt_12 = "month_amt_12";
  static const month_visit_date_1 = "month_visit_date_1";
  static const month_visit_date_2 = "month_visit_date_2";
  static const month_visit_date_3 = "month_visit_date_3";
  static const month_visit_date_4 = "month_visit_date_4";
  static const month_visit_date_5 = "month_visit_date_5";
  static const month_visit_date_6 = "month_visit_date_6";
  static const month_visit_date_7 = "month_visit_date_7";
  static const month_visit_date_8 = "month_visit_date_8";
  static const month_visit_date_9 = "month_visit_date_9";
  static const month_visit_date_10 = "month_visit_date_10";
  static const month_visit_date_11 = "month_visit_date_11";
  static const month_visit_date_12 = "month_visit_date_12";
  static const month_visit_cnt_1 = "month_visit_cnt_1";
  static const month_visit_cnt_2 = "month_visit_cnt_2";
  static const month_visit_cnt_3 = "month_visit_cnt_3";
  static const month_visit_cnt_4 = "month_visit_cnt_4";
  static const month_visit_cnt_5 = "month_visit_cnt_5";
  static const month_visit_cnt_6 = "month_visit_cnt_6";
  static const month_visit_cnt_7 = "month_visit_cnt_7";
  static const month_visit_cnt_8 = "month_visit_cnt_8";
  static const month_visit_cnt_9 = "month_visit_cnt_9";
  static const month_visit_cnt_10 = "month_visit_cnt_10";
  static const month_visit_cnt_11 = "month_visit_cnt_11";
  static const month_visit_cnt_12 = "month_visit_cnt_12";
  static const bnsdsc_amt = "bnsdsc_amt";
  static const bnsdsc_visit_date = "bnsdsc_visit_date";
  static const ttl_amt = "ttl_amt";
  static const delivery_date = "delivery_date";
  static const last_name = "last_name";
  static const first_name = "first_name";
  static const birth_day = "birth_day";
  static const tel_no1 = "tel_no1";
  static const tel_no2 = "tel_no2";
  static const last_visit_date = "last_visit_date";
  static const pnt_service_type = "pnt_service_type";
  static const pnt_service_limit = "pnt_service_limit";
  static const portal_flg = "portal_flg";
  static const enq_comp_cd = "enq_comp_cd";
  static const enq_stre_cd = "enq_stre_cd";
  static const enq_mac_no = "enq_mac_no";
  static const enq_datetime = "enq_datetime";
  static const cust_status = "cust_status";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const targ_typ = "targ_typ";
  static const staff_flg = "staff_flg";
  static const cust_prc_type = "cust_prc_type";
  static const sch_acct_cd_1 = "sch_acct_cd_1";
  static const acct_accval_1 = "acct_accval_1";
  static const acct_optotal_1 = "acct_optotal_1";
  static const sch_acct_cd_2 = "sch_acct_cd_2";
  static const acct_accval_2 = "acct_accval_2";
  static const acct_optotal_2 = "acct_optotal_2";
  static const sch_acct_cd_3 = "sch_acct_cd_3";
  static const acct_accval_3 = "acct_accval_3";
  static const acct_optotal_3 = "acct_optotal_3";
  static const sch_acct_cd_4 = "sch_acct_cd_4";
  static const acct_accval_4 = "acct_accval_4";
  static const acct_optotal_4 = "acct_optotal_4";
  static const sch_acct_cd_5 = "sch_acct_cd_5";
  static const acct_accval_5 = "acct_accval_5";
  static const acct_optotal_5 = "acct_optotal_5";
  static const c_data1 = "c_data1";
  static const n_data1 = "n_data1";
  static const n_data2 = "n_data2";
  static const n_data3 = "n_data3";
  static const n_data4 = "n_data4";
  static const n_data5 = "n_data5";
  static const n_data6 = "n_data6";
  static const n_data7 = "n_data7";
  static const n_data8 = "n_data8";
  static const n_data9 = "n_data9";
  static const n_data10 = "n_data10";
  static const n_data11 = "n_data11";
  static const n_data12 = "n_data12";
  static const n_data13 = "n_data13";
  static const n_data14 = "n_data14";
  static const n_data15 = "n_data15";
  static const n_data16 = "n_data16";
  static const s_data1 = "s_data1";
  static const s_data2 = "s_data2";
  static const s_data3 = "s_data3";
  static const d_data1 = "d_data1";
  static const d_data2 = "d_data2";
  static const d_data3 = "d_data3";
  static const d_data4 = "d_data4";
  static const d_data5 = "d_data5";
  static const d_data6 = "d_data6";
  static const d_data7 = "d_data7";
  static const d_data8 = "d_data8";
  static const d_data9 = "d_data9";
  static const d_data10 = "d_data10";
}
//endregion
//region 07_12	ランク判定マスタ	c_rank_mst
/// 07_12 ランク判定マスタ c_rank_mstクラス
class CRankMstColumns extends TableColumns{
  int? comp_cd;
  int? rank_cd;
  int? rank_kind;
  String? rank_name;
  int reward_typ = 0;
  int rank_judge_1 = 0;
  int rank_judge_2 = 0;
  int rank_judge_3 = 0;
  int rank_judge_4 = 0;
  int rank_judge_5 = 0;
  int rank_judge_6 = 0;
  int rank_judge_7 = 0;
  int rank_judge_8 = 0;
  int rank_judge_9 = 0;
  int rank_judge_10 = 0;
  int rank_reward_1 = 0;
  int rank_reward_2 = 0;
  int rank_reward_3 = 0;
  int rank_reward_4 = 0;
  int rank_reward_5 = 0;
  int rank_reward_6 = 0;
  int rank_reward_7 = 0;
  int rank_reward_8 = 0;
  int rank_reward_9 = 0;
  int rank_reward_10 = 0;
  String? start_datetime;
  String? end_datetime;
  int timesch_flg = 0;
  int sun_flg = 0;
  int mon_flg = 0;
  int tue_flg = 0;
  int wed_flg = 0;
  int thu_flg = 0;
  int fri_flg = 0;
  int sat_flg = 0;
  int seq_no = 0;
  String? promo_ext_id;
  int acct_cd = 0;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_rank_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND rank_cd = ? AND rank_kind = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(rank_cd);
    rn.add(rank_kind);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CRankMstColumns rn = CRankMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.rank_cd = maps[i]['rank_cd'];
      rn.rank_kind = maps[i]['rank_kind'];
      rn.rank_name = maps[i]['rank_name'];
      rn.reward_typ = maps[i]['reward_typ'];
      rn.rank_judge_1 = maps[i]['rank_judge_1'];
      rn.rank_judge_2 = maps[i]['rank_judge_2'];
      rn.rank_judge_3 = maps[i]['rank_judge_3'];
      rn.rank_judge_4 = maps[i]['rank_judge_4'];
      rn.rank_judge_5 = maps[i]['rank_judge_5'];
      rn.rank_judge_6 = maps[i]['rank_judge_6'];
      rn.rank_judge_7 = maps[i]['rank_judge_7'];
      rn.rank_judge_8 = maps[i]['rank_judge_8'];
      rn.rank_judge_9 = maps[i]['rank_judge_9'];
      rn.rank_judge_10 = maps[i]['rank_judge_10'];
      rn.rank_reward_1 = maps[i]['rank_reward_1'];
      rn.rank_reward_2 = maps[i]['rank_reward_2'];
      rn.rank_reward_3 = maps[i]['rank_reward_3'];
      rn.rank_reward_4 = maps[i]['rank_reward_4'];
      rn.rank_reward_5 = maps[i]['rank_reward_5'];
      rn.rank_reward_6 = maps[i]['rank_reward_6'];
      rn.rank_reward_7 = maps[i]['rank_reward_7'];
      rn.rank_reward_8 = maps[i]['rank_reward_8'];
      rn.rank_reward_9 = maps[i]['rank_reward_9'];
      rn.rank_reward_10 = maps[i]['rank_reward_10'];
      rn.start_datetime = maps[i]['start_datetime'];
      rn.end_datetime = maps[i]['end_datetime'];
      rn.timesch_flg = maps[i]['timesch_flg'];
      rn.sun_flg = maps[i]['sun_flg'];
      rn.mon_flg = maps[i]['mon_flg'];
      rn.tue_flg = maps[i]['tue_flg'];
      rn.wed_flg = maps[i]['wed_flg'];
      rn.thu_flg = maps[i]['thu_flg'];
      rn.fri_flg = maps[i]['fri_flg'];
      rn.sat_flg = maps[i]['sat_flg'];
      rn.seq_no = maps[i]['seq_no'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.acct_cd = maps[i]['acct_cd'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CRankMstColumns rn = CRankMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.rank_cd = maps[0]['rank_cd'];
    rn.rank_kind = maps[0]['rank_kind'];
    rn.rank_name = maps[0]['rank_name'];
    rn.reward_typ = maps[0]['reward_typ'];
    rn.rank_judge_1 = maps[0]['rank_judge_1'];
    rn.rank_judge_2 = maps[0]['rank_judge_2'];
    rn.rank_judge_3 = maps[0]['rank_judge_3'];
    rn.rank_judge_4 = maps[0]['rank_judge_4'];
    rn.rank_judge_5 = maps[0]['rank_judge_5'];
    rn.rank_judge_6 = maps[0]['rank_judge_6'];
    rn.rank_judge_7 = maps[0]['rank_judge_7'];
    rn.rank_judge_8 = maps[0]['rank_judge_8'];
    rn.rank_judge_9 = maps[0]['rank_judge_9'];
    rn.rank_judge_10 = maps[0]['rank_judge_10'];
    rn.rank_reward_1 = maps[0]['rank_reward_1'];
    rn.rank_reward_2 = maps[0]['rank_reward_2'];
    rn.rank_reward_3 = maps[0]['rank_reward_3'];
    rn.rank_reward_4 = maps[0]['rank_reward_4'];
    rn.rank_reward_5 = maps[0]['rank_reward_5'];
    rn.rank_reward_6 = maps[0]['rank_reward_6'];
    rn.rank_reward_7 = maps[0]['rank_reward_7'];
    rn.rank_reward_8 = maps[0]['rank_reward_8'];
    rn.rank_reward_9 = maps[0]['rank_reward_9'];
    rn.rank_reward_10 = maps[0]['rank_reward_10'];
    rn.start_datetime = maps[0]['start_datetime'];
    rn.end_datetime = maps[0]['end_datetime'];
    rn.timesch_flg = maps[0]['timesch_flg'];
    rn.sun_flg = maps[0]['sun_flg'];
    rn.mon_flg = maps[0]['mon_flg'];
    rn.tue_flg = maps[0]['tue_flg'];
    rn.wed_flg = maps[0]['wed_flg'];
    rn.thu_flg = maps[0]['thu_flg'];
    rn.fri_flg = maps[0]['fri_flg'];
    rn.sat_flg = maps[0]['sat_flg'];
    rn.seq_no = maps[0]['seq_no'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.acct_cd = maps[0]['acct_cd'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CRankMstField.comp_cd : this.comp_cd,
      CRankMstField.rank_cd : this.rank_cd,
      CRankMstField.rank_kind : this.rank_kind,
      CRankMstField.rank_name : this.rank_name,
      CRankMstField.reward_typ : this.reward_typ,
      CRankMstField.rank_judge_1 : this.rank_judge_1,
      CRankMstField.rank_judge_2 : this.rank_judge_2,
      CRankMstField.rank_judge_3 : this.rank_judge_3,
      CRankMstField.rank_judge_4 : this.rank_judge_4,
      CRankMstField.rank_judge_5 : this.rank_judge_5,
      CRankMstField.rank_judge_6 : this.rank_judge_6,
      CRankMstField.rank_judge_7 : this.rank_judge_7,
      CRankMstField.rank_judge_8 : this.rank_judge_8,
      CRankMstField.rank_judge_9 : this.rank_judge_9,
      CRankMstField.rank_judge_10 : this.rank_judge_10,
      CRankMstField.rank_reward_1 : this.rank_reward_1,
      CRankMstField.rank_reward_2 : this.rank_reward_2,
      CRankMstField.rank_reward_3 : this.rank_reward_3,
      CRankMstField.rank_reward_4 : this.rank_reward_4,
      CRankMstField.rank_reward_5 : this.rank_reward_5,
      CRankMstField.rank_reward_6 : this.rank_reward_6,
      CRankMstField.rank_reward_7 : this.rank_reward_7,
      CRankMstField.rank_reward_8 : this.rank_reward_8,
      CRankMstField.rank_reward_9 : this.rank_reward_9,
      CRankMstField.rank_reward_10 : this.rank_reward_10,
      CRankMstField.start_datetime : this.start_datetime,
      CRankMstField.end_datetime : this.end_datetime,
      CRankMstField.timesch_flg : this.timesch_flg,
      CRankMstField.sun_flg : this.sun_flg,
      CRankMstField.mon_flg : this.mon_flg,
      CRankMstField.tue_flg : this.tue_flg,
      CRankMstField.wed_flg : this.wed_flg,
      CRankMstField.thu_flg : this.thu_flg,
      CRankMstField.fri_flg : this.fri_flg,
      CRankMstField.sat_flg : this.sat_flg,
      CRankMstField.seq_no : this.seq_no,
      CRankMstField.promo_ext_id : this.promo_ext_id,
      CRankMstField.acct_cd : this.acct_cd,
      CRankMstField.stop_flg : this.stop_flg,
      CRankMstField.ins_datetime : this.ins_datetime,
      CRankMstField.upd_datetime : this.upd_datetime,
      CRankMstField.status : this.status,
      CRankMstField.send_flg : this.send_flg,
      CRankMstField.upd_user : this.upd_user,
      CRankMstField.upd_system : this.upd_system,
    };
  }
}

/// 07_12 ランク判定マスタ c_rank_mstのフィールド名設定用クラス
class CRankMstField {
  static const comp_cd = "comp_cd";
  static const rank_cd = "rank_cd";
  static const rank_kind = "rank_kind";
  static const rank_name = "rank_name";
  static const reward_typ = "reward_typ";
  static const rank_judge_1 = "rank_judge_1";
  static const rank_judge_2 = "rank_judge_2";
  static const rank_judge_3 = "rank_judge_3";
  static const rank_judge_4 = "rank_judge_4";
  static const rank_judge_5 = "rank_judge_5";
  static const rank_judge_6 = "rank_judge_6";
  static const rank_judge_7 = "rank_judge_7";
  static const rank_judge_8 = "rank_judge_8";
  static const rank_judge_9 = "rank_judge_9";
  static const rank_judge_10 = "rank_judge_10";
  static const rank_reward_1 = "rank_reward_1";
  static const rank_reward_2 = "rank_reward_2";
  static const rank_reward_3 = "rank_reward_3";
  static const rank_reward_4 = "rank_reward_4";
  static const rank_reward_5 = "rank_reward_5";
  static const rank_reward_6 = "rank_reward_6";
  static const rank_reward_7 = "rank_reward_7";
  static const rank_reward_8 = "rank_reward_8";
  static const rank_reward_9 = "rank_reward_9";
  static const rank_reward_10 = "rank_reward_10";
  static const start_datetime = "start_datetime";
  static const end_datetime = "end_datetime";
  static const timesch_flg = "timesch_flg";
  static const sun_flg = "sun_flg";
  static const mon_flg = "mon_flg";
  static const tue_flg = "tue_flg";
  static const wed_flg = "wed_flg";
  static const thu_flg = "thu_flg";
  static const fri_flg = "fri_flg";
  static const sat_flg = "sat_flg";
  static const seq_no = "seq_no";
  static const promo_ext_id = "promo_ext_id";
  static const acct_cd = "acct_cd";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 07_13	ターミナル予約マスタ	c_trm_rsrv_mst
/// 07_13 ターミナル予約マスタ c_trm_rsrv_mstクラス
class CTrmRsrvMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? trm_cd;
  int? kopt_cd;
  String? rsrv_datetime;
  double? trm_data = 0;
  String? trm_data_str;
  int trm_data_typ = 0;
  int trm_ref_flg = 0;
  int? seq_no;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int stop_flg = 0;

  @override
  String _getTableName() => "c_trm_rsrv_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND trm_cd = ? AND kopt_cd = ? AND rsrv_datetime = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(trm_cd);
    rn.add(kopt_cd);
    rn.add(rsrv_datetime);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTrmRsrvMstColumns rn = CTrmRsrvMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.trm_cd = maps[i]['trm_cd'];
      rn.kopt_cd = maps[i]['kopt_cd'];
      rn.rsrv_datetime = maps[i]['rsrv_datetime'];
      rn.trm_data = maps[i]['trm_data'];
      rn.trm_data_str = maps[i]['trm_data_str'];
      rn.trm_data_typ = maps[i]['trm_data_typ'];
      rn.trm_ref_flg = maps[i]['trm_ref_flg'];
      rn.seq_no = maps[i]['seq_no'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.stop_flg = maps[i]['stop_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CTrmRsrvMstColumns rn = CTrmRsrvMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.trm_cd = maps[0]['trm_cd'];
    rn.kopt_cd = maps[0]['kopt_cd'];
    rn.rsrv_datetime = maps[0]['rsrv_datetime'];
    rn.trm_data = maps[0]['trm_data'];
    rn.trm_data_str = maps[0]['trm_data_str'];
    rn.trm_data_typ = maps[0]['trm_data_typ'];
    rn.trm_ref_flg = maps[0]['trm_ref_flg'];
    rn.seq_no = maps[0]['seq_no'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.stop_flg = maps[0]['stop_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CTrmRsrvMstField.comp_cd : this.comp_cd,
      CTrmRsrvMstField.stre_cd : this.stre_cd,
      CTrmRsrvMstField.trm_cd : this.trm_cd,
      CTrmRsrvMstField.kopt_cd : this.kopt_cd,
      CTrmRsrvMstField.rsrv_datetime : this.rsrv_datetime,
      CTrmRsrvMstField.trm_data : this.trm_data,
      CTrmRsrvMstField.trm_data_str : this.trm_data_str,
      CTrmRsrvMstField.trm_data_typ : this.trm_data_typ,
      CTrmRsrvMstField.trm_ref_flg : this.trm_ref_flg,
      CTrmRsrvMstField.seq_no : this.seq_no,
      CTrmRsrvMstField.promo_ext_id : this.promo_ext_id,
      CTrmRsrvMstField.ins_datetime : this.ins_datetime,
      CTrmRsrvMstField.upd_datetime : this.upd_datetime,
      CTrmRsrvMstField.status : this.status,
      CTrmRsrvMstField.send_flg : this.send_flg,
      CTrmRsrvMstField.upd_user : this.upd_user,
      CTrmRsrvMstField.upd_system : this.upd_system,
      CTrmRsrvMstField.stop_flg : this.stop_flg,
    };
  }
}

/// 07_13 ターミナル予約マスタ c_trm_rsrv_mstのフィールド名設定用クラス
class CTrmRsrvMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const trm_cd = "trm_cd";
  static const kopt_cd = "kopt_cd";
  static const rsrv_datetime = "rsrv_datetime";
  static const trm_data = "trm_data";
  static const trm_data_str = "trm_data_str";
  static const trm_data_typ = "trm_data_typ";
  static const trm_ref_flg = "trm_ref_flg";
  static const seq_no = "seq_no";
  static const promo_ext_id = "promo_ext_id";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const stop_flg = "stop_flg";
}
//endregion
//region 07_14	ポイントスケジュールマスタ	c_pntsch_mst
/// 07_14 ポイントスケジュールマスタ  c_pntsch_mstクラス
class CPntschMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? pntsch_cd;
  String? name;
  String? start_datetime;
  String? end_datetime;
  int timesch_flg = 0;
  int sun_flg = 1;
  int mon_flg = 1;
  int tue_flg = 1;
  int wed_flg = 1;
  int thu_flg = 1;
  int fri_flg = 1;
  int sat_flg = 1;
  int stop_flg = 0;
  int? seq_no;
  String? promo_ext_id;
  int acct_cd = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_pntsch_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND pntsch_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(pntsch_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CPntschMstColumns rn = CPntschMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.pntsch_cd = maps[i]['pntsch_cd'];
      rn.name = maps[i]['name'];
      rn.start_datetime = maps[i]['start_datetime'];
      rn.end_datetime = maps[i]['end_datetime'];
      rn.timesch_flg = maps[i]['timesch_flg'];
      rn.sun_flg = maps[i]['sun_flg'];
      rn.mon_flg = maps[i]['mon_flg'];
      rn.tue_flg = maps[i]['tue_flg'];
      rn.wed_flg = maps[i]['wed_flg'];
      rn.thu_flg = maps[i]['thu_flg'];
      rn.fri_flg = maps[i]['fri_flg'];
      rn.sat_flg = maps[i]['sat_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.seq_no = maps[i]['seq_no'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.acct_cd = maps[i]['acct_cd'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CPntschMstColumns rn = CPntschMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.pntsch_cd = maps[0]['pntsch_cd'];
    rn.name = maps[0]['name'];
    rn.start_datetime = maps[0]['start_datetime'];
    rn.end_datetime = maps[0]['end_datetime'];
    rn.timesch_flg = maps[0]['timesch_flg'];
    rn.sun_flg = maps[0]['sun_flg'];
    rn.mon_flg = maps[0]['mon_flg'];
    rn.tue_flg = maps[0]['tue_flg'];
    rn.wed_flg = maps[0]['wed_flg'];
    rn.thu_flg = maps[0]['thu_flg'];
    rn.fri_flg = maps[0]['fri_flg'];
    rn.sat_flg = maps[0]['sat_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.seq_no = maps[0]['seq_no'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.acct_cd = maps[0]['acct_cd'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CPntschMstField.comp_cd : this.comp_cd,
      CPntschMstField.stre_cd : this.stre_cd,
      CPntschMstField.pntsch_cd : this.pntsch_cd,
      CPntschMstField.name : this.name,
      CPntschMstField.start_datetime : this.start_datetime,
      CPntschMstField.end_datetime : this.end_datetime,
      CPntschMstField.timesch_flg : this.timesch_flg,
      CPntschMstField.sun_flg : this.sun_flg,
      CPntschMstField.mon_flg : this.mon_flg,
      CPntschMstField.tue_flg : this.tue_flg,
      CPntschMstField.wed_flg : this.wed_flg,
      CPntschMstField.thu_flg : this.thu_flg,
      CPntschMstField.fri_flg : this.fri_flg,
      CPntschMstField.sat_flg : this.sat_flg,
      CPntschMstField.stop_flg : this.stop_flg,
      CPntschMstField.seq_no : this.seq_no,
      CPntschMstField.promo_ext_id : this.promo_ext_id,
      CPntschMstField.acct_cd : this.acct_cd,
      CPntschMstField.ins_datetime : this.ins_datetime,
      CPntschMstField.upd_datetime : this.upd_datetime,
      CPntschMstField.status : this.status,
      CPntschMstField.send_flg : this.send_flg,
      CPntschMstField.upd_user : this.upd_user,
      CPntschMstField.upd_system : this.upd_system,
    };
  }
}

/// 07_14 ポイントスケジュールマスタ  c_pntsch_mstのフィールド名設定用クラス
class CPntschMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const pntsch_cd = "pntsch_cd";
  static const name = "name";
  static const start_datetime = "start_datetime";
  static const end_datetime = "end_datetime";
  static const timesch_flg = "timesch_flg";
  static const sun_flg = "sun_flg";
  static const mon_flg = "mon_flg";
  static const tue_flg = "tue_flg";
  static const wed_flg = "wed_flg";
  static const thu_flg = "thu_flg";
  static const fri_flg = "fri_flg";
  static const sat_flg = "sat_flg";
  static const stop_flg = "stop_flg";
  static const seq_no = "seq_no";
  static const promo_ext_id = "promo_ext_id";
  static const acct_cd = "acct_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 07_15	ポイントスケジュールグループマスタ	c_pntschgrp_mst
/// 07_15 ポイントスケジュールグループマスタ  c_pntschgrp_mstクラス
class CPntschgrpMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? pntsch_cd;
  int? trm_grp_cd;
  int? trm_cd;
  double? trm_data = 0;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int low_lim = 0;
  int acct_cd = 0;

  @override
  String _getTableName() => "c_pntschgrp_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND pntsch_cd = ? AND trm_grp_cd = ? AND trm_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(pntsch_cd);
    rn.add(trm_grp_cd);
    rn.add(trm_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CPntschgrpMstColumns rn = CPntschgrpMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.pntsch_cd = maps[i]['pntsch_cd'];
      rn.trm_grp_cd = maps[i]['trm_grp_cd'];
      rn.trm_cd = maps[i]['trm_cd'];
      rn.trm_data = maps[i]['trm_data'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.low_lim = maps[i]['low_lim'];
      rn.acct_cd = maps[i]['acct_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CPntschgrpMstColumns rn = CPntschgrpMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.pntsch_cd = maps[0]['pntsch_cd'];
    rn.trm_grp_cd = maps[0]['trm_grp_cd'];
    rn.trm_cd = maps[0]['trm_cd'];
    rn.trm_data = maps[0]['trm_data'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.low_lim = maps[0]['low_lim'];
    rn.acct_cd = maps[0]['acct_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CPntschgrpMstField.comp_cd : this.comp_cd,
      CPntschgrpMstField.stre_cd : this.stre_cd,
      CPntschgrpMstField.pntsch_cd : this.pntsch_cd,
      CPntschgrpMstField.trm_grp_cd : this.trm_grp_cd,
      CPntschgrpMstField.trm_cd : this.trm_cd,
      CPntschgrpMstField.trm_data : this.trm_data,
      CPntschgrpMstField.stop_flg : this.stop_flg,
      CPntschgrpMstField.ins_datetime : this.ins_datetime,
      CPntschgrpMstField.upd_datetime : this.upd_datetime,
      CPntschgrpMstField.status : this.status,
      CPntschgrpMstField.send_flg : this.send_flg,
      CPntschgrpMstField.upd_user : this.upd_user,
      CPntschgrpMstField.upd_system : this.upd_system,
      CPntschgrpMstField.low_lim : this.low_lim,
      CPntschgrpMstField.acct_cd : this.acct_cd,
    };
  }
}

/// 07_15 ポイントスケジュールグループマスタ  c_pntschgrp_mstのフィールド名設定用クラス
class CPntschgrpMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const pntsch_cd = "pntsch_cd";
  static const trm_grp_cd = "trm_grp_cd";
  static const trm_cd = "trm_cd";
  static const trm_data = "trm_data";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const low_lim = "low_lim";
  static const acct_cd = "acct_cd";
}
//endregion
//region 07_16	ターミナル企画番号マスタ	c_trm_plan_mst
/// 07_16 ターミナル企画番号マスタ c_trm_plan_mstクラス
class CTrmPlanMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? acct_cd;
  int acct_flg = 0;
  int? seq_no;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_trm_plan_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND acct_cd = ? AND acct_flg = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(acct_cd);
    rn.add(acct_flg);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTrmPlanMstColumns rn = CTrmPlanMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.acct_cd = maps[i]['acct_cd'];
      rn.acct_flg = maps[i]['acct_flg'];
      rn.seq_no = maps[i]['seq_no'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CTrmPlanMstColumns rn = CTrmPlanMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.acct_cd = maps[0]['acct_cd'];
    rn.acct_flg = maps[0]['acct_flg'];
    rn.seq_no = maps[0]['seq_no'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CTrmPlanMstField.comp_cd : this.comp_cd,
      CTrmPlanMstField.stre_cd : this.stre_cd,
      CTrmPlanMstField.acct_cd : this.acct_cd,
      CTrmPlanMstField.acct_flg : this.acct_flg,
      CTrmPlanMstField.seq_no : this.seq_no,
      CTrmPlanMstField.promo_ext_id : this.promo_ext_id,
      CTrmPlanMstField.ins_datetime : this.ins_datetime,
      CTrmPlanMstField.upd_datetime : this.upd_datetime,
      CTrmPlanMstField.status : this.status,
      CTrmPlanMstField.send_flg : this.send_flg,
      CTrmPlanMstField.upd_user : this.upd_user,
      CTrmPlanMstField.upd_system : this.upd_system,
    };
  }
}

/// 07_16 ターミナル企画番号マスタ c_trm_plan_mstのフィールド名設定用クラス
class CTrmPlanMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const acct_cd = "acct_cd";
  static const acct_flg = "acct_flg";
  static const seq_no = "seq_no";
  static const promo_ext_id = "promo_ext_id";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 07_17	顧客スタンプカードテーブル	s_cust_stp_tbl
/// 07_17 顧客スタンプカードテーブル  s_cust_stp_tblクラス
class SCustStpTblColumns extends TableColumns{
  String? cust_no;
  int? comp_cd;
  int? acct_cd;
  int acc_amt = 0;
  int red_amt = 0;
  String? last_upd_date;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? cpn_id;
  int tday_acc_amt = 0;

  @override
  String _getTableName() => "s_cust_stp_tbl";

  @override
  String? _getKeyCondition() => 'cust_no = ? AND comp_cd = ? AND acct_cd = ? AND cpn_id = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cust_no);
    rn.add(comp_cd);
    rn.add(acct_cd);
    rn.add(cpn_id);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SCustStpTblColumns rn = SCustStpTblColumns();
      rn.cust_no = maps[i]['cust_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.acct_cd = maps[i]['acct_cd'];
      rn.acc_amt = maps[i]['acc_amt'];
      rn.red_amt = maps[i]['red_amt'];
      rn.last_upd_date = maps[i]['last_upd_date'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.cpn_id = maps[i]['cpn_id'];
      rn.tday_acc_amt = maps[i]['tday_acc_amt'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SCustStpTblColumns rn = SCustStpTblColumns();
    rn.cust_no = maps[0]['cust_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.acct_cd = maps[0]['acct_cd'];
    rn.acc_amt = maps[0]['acc_amt'];
    rn.red_amt = maps[0]['red_amt'];
    rn.last_upd_date = maps[0]['last_upd_date'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.cpn_id = maps[0]['cpn_id'];
    rn.tday_acc_amt = maps[0]['tday_acc_amt'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SCustStpTblField.cust_no : this.cust_no,
      SCustStpTblField.comp_cd : this.comp_cd,
      SCustStpTblField.acct_cd : this.acct_cd,
      SCustStpTblField.acc_amt : this.acc_amt,
      SCustStpTblField.red_amt : this.red_amt,
      SCustStpTblField.last_upd_date : this.last_upd_date,
      SCustStpTblField.stop_flg : this.stop_flg,
      SCustStpTblField.ins_datetime : this.ins_datetime,
      SCustStpTblField.upd_datetime : this.upd_datetime,
      SCustStpTblField.status : this.status,
      SCustStpTblField.send_flg : this.send_flg,
      SCustStpTblField.upd_user : this.upd_user,
      SCustStpTblField.upd_system : this.upd_system,
      SCustStpTblField.cpn_id : this.cpn_id,
      SCustStpTblField.tday_acc_amt : this.tday_acc_amt,
    };
  }
}

/// 07_17 顧客スタンプカードテーブル  s_cust_stp_tblのフィールド名設定用クラス
class SCustStpTblField {
  static const cust_no = "cust_no";
  static const comp_cd = "comp_cd";
  static const acct_cd = "acct_cd";
  static const acc_amt = "acc_amt";
  static const red_amt = "red_amt";
  static const last_upd_date = "last_upd_date";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const cpn_id = "cpn_id";
  static const tday_acc_amt = "tday_acc_amt";
}
//endregion
//region 07_18	スタンプカード企画マスタ	c_stppln_mst
/// 07_18 スタンプカード企画マスタ c_stppln_mstクラス
class CStpplnMstColumns extends TableColumns{
  int? cpn_id;
  int? plan_cd;
  int? comp_cd;
  int? stre_cd;
  int all_cust_flg = 0;
  int cust_kind_flg = 0;
  String? plan_name;
  String? rcpt_name;
  int? format_flg = 0;
  String? pict_path;
  String? notes;
  String? prn_stre_name;
  String? prn_time;
  String? c_data1;
  String? c_data2;
  String? c_data3;
  String? c_data4;
  String? c_data5;
  String? c_data6;
  int? s_data1 = 0;
  int? s_data2 = 0;
  int? s_data3 = 0;
  int ref_unit_flg = 0;
  int cond_class_flg = 0;
  int low_lim = 0;
  int upp_lim = 0;
  int rec_limit = 0;
  int day_limit = 0;
  int max_limit = 0;
  String? start_datetime;
  String? end_datetime;
  String? svs_start_datetime;
  String? svs_end_datetime;
  int stop_flg = 0;
  int timesch_flg = 0;
  int sun_flg = 0;
  int mon_flg = 0;
  int tue_flg = 0;
  int wed_flg = 0;
  int thu_flg = 0;
  int fri_flg = 0;
  int sat_flg = 0;
  int date_flg1 = 0;
  int date_flg2 = 0;
  int date_flg3 = 0;
  int date_flg4 = 0;
  int date_flg5 = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  String cust_kind_trgt = '{0}';
  int n_custom1 = 0;
  int n_custom2 = 0;
  int n_custom3 = 0;
  int n_custom4 = 0;
  int n_custom5 = 0;
  int n_custom6 = 0;
  int n_custom7 = 0;
  int n_custom8 = 0;
  int s_custom1 = 0;
  int s_custom2 = 0;
  int s_custom3 = 0;
  int s_custom4 = 0;
  int s_custom5 = 0;
  int s_custom6 = 0;
  int s_custom7 = 0;
  int s_custom8 = 0;
  String? c_custom1;
  String? c_custom2;
  String? c_custom3;
  String? c_custom4;
  String? d_custom1;
  String? d_custom2;
  String? d_custom3;
  String? d_custom4;

  @override
  String _getTableName() => "c_stppln_mst";

  @override
  String? _getKeyCondition() => 'cpn_id = ? AND plan_cd = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cpn_id);
    rn.add(plan_cd);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStpplnMstColumns rn = CStpplnMstColumns();
      rn.cpn_id = maps[i]['cpn_id'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.all_cust_flg = maps[i]['all_cust_flg'];
      rn.cust_kind_flg = maps[i]['cust_kind_flg'];
      rn.plan_name = maps[i]['plan_name'];
      rn.rcpt_name = maps[i]['rcpt_name'];
      rn.format_flg = maps[i]['format_flg'];
      rn.pict_path = maps[i]['pict_path'];
      rn.notes = maps[i]['notes'];
      rn.prn_stre_name = maps[i]['prn_stre_name'];
      rn.prn_time = maps[i]['prn_time'];
      rn.c_data1 = maps[i]['c_data1'];
      rn.c_data2 = maps[i]['c_data2'];
      rn.c_data3 = maps[i]['c_data3'];
      rn.c_data4 = maps[i]['c_data4'];
      rn.c_data5 = maps[i]['c_data5'];
      rn.c_data6 = maps[i]['c_data6'];
      rn.s_data1 = maps[i]['s_data1'];
      rn.s_data2 = maps[i]['s_data2'];
      rn.s_data3 = maps[i]['s_data3'];
      rn.ref_unit_flg = maps[i]['ref_unit_flg'];
      rn.cond_class_flg = maps[i]['cond_class_flg'];
      rn.low_lim = maps[i]['low_lim'];
      rn.upp_lim = maps[i]['upp_lim'];
      rn.rec_limit = maps[i]['rec_limit'];
      rn.day_limit = maps[i]['day_limit'];
      rn.max_limit = maps[i]['max_limit'];
      rn.start_datetime = maps[i]['start_datetime'];
      rn.end_datetime = maps[i]['end_datetime'];
      rn.svs_start_datetime = maps[i]['svs_start_datetime'];
      rn.svs_end_datetime = maps[i]['svs_end_datetime'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.timesch_flg = maps[i]['timesch_flg'];
      rn.sun_flg = maps[i]['sun_flg'];
      rn.mon_flg = maps[i]['mon_flg'];
      rn.tue_flg = maps[i]['tue_flg'];
      rn.wed_flg = maps[i]['wed_flg'];
      rn.thu_flg = maps[i]['thu_flg'];
      rn.fri_flg = maps[i]['fri_flg'];
      rn.sat_flg = maps[i]['sat_flg'];
      rn.date_flg1 = maps[i]['date_flg1'];
      rn.date_flg2 = maps[i]['date_flg2'];
      rn.date_flg3 = maps[i]['date_flg3'];
      rn.date_flg4 = maps[i]['date_flg4'];
      rn.date_flg5 = maps[i]['date_flg5'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.cust_kind_trgt = maps[i]['cust_kind_trgt'];
      rn.n_custom1 = maps[i]['n_custom1'];
      rn.n_custom2 = maps[i]['n_custom2'];
      rn.n_custom3 = maps[i]['n_custom3'];
      rn.n_custom4 = maps[i]['n_custom4'];
      rn.n_custom5 = maps[i]['n_custom5'];
      rn.n_custom6 = maps[i]['n_custom6'];
      rn.n_custom7 = maps[i]['n_custom7'];
      rn.n_custom8 = maps[i]['n_custom8'];
      rn.s_custom1 = maps[i]['s_custom1'];
      rn.s_custom2 = maps[i]['s_custom2'];
      rn.s_custom3 = maps[i]['s_custom3'];
      rn.s_custom4 = maps[i]['s_custom4'];
      rn.s_custom5 = maps[i]['s_custom5'];
      rn.s_custom6 = maps[i]['s_custom6'];
      rn.s_custom7 = maps[i]['s_custom7'];
      rn.s_custom8 = maps[i]['s_custom8'];
      rn.c_custom1 = maps[i]['c_custom1'];
      rn.c_custom2 = maps[i]['c_custom2'];
      rn.c_custom3 = maps[i]['c_custom3'];
      rn.c_custom4 = maps[i]['c_custom4'];
      rn.d_custom1 = maps[i]['d_custom1'];
      rn.d_custom2 = maps[i]['d_custom2'];
      rn.d_custom3 = maps[i]['d_custom3'];
      rn.d_custom4 = maps[i]['d_custom4'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CStpplnMstColumns rn = CStpplnMstColumns();
    rn.cpn_id = maps[0]['cpn_id'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.all_cust_flg = maps[0]['all_cust_flg'];
    rn.cust_kind_flg = maps[0]['cust_kind_flg'];
    rn.plan_name = maps[0]['plan_name'];
    rn.rcpt_name = maps[0]['rcpt_name'];
    rn.format_flg = maps[0]['format_flg'];
    rn.pict_path = maps[0]['pict_path'];
    rn.notes = maps[0]['notes'];
    rn.prn_stre_name = maps[0]['prn_stre_name'];
    rn.prn_time = maps[0]['prn_time'];
    rn.c_data1 = maps[0]['c_data1'];
    rn.c_data2 = maps[0]['c_data2'];
    rn.c_data3 = maps[0]['c_data3'];
    rn.c_data4 = maps[0]['c_data4'];
    rn.c_data5 = maps[0]['c_data5'];
    rn.c_data6 = maps[0]['c_data6'];
    rn.s_data1 = maps[0]['s_data1'];
    rn.s_data2 = maps[0]['s_data2'];
    rn.s_data3 = maps[0]['s_data3'];
    rn.ref_unit_flg = maps[0]['ref_unit_flg'];
    rn.cond_class_flg = maps[0]['cond_class_flg'];
    rn.low_lim = maps[0]['low_lim'];
    rn.upp_lim = maps[0]['upp_lim'];
    rn.rec_limit = maps[0]['rec_limit'];
    rn.day_limit = maps[0]['day_limit'];
    rn.max_limit = maps[0]['max_limit'];
    rn.start_datetime = maps[0]['start_datetime'];
    rn.end_datetime = maps[0]['end_datetime'];
    rn.svs_start_datetime = maps[0]['svs_start_datetime'];
    rn.svs_end_datetime = maps[0]['svs_end_datetime'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.timesch_flg = maps[0]['timesch_flg'];
    rn.sun_flg = maps[0]['sun_flg'];
    rn.mon_flg = maps[0]['mon_flg'];
    rn.tue_flg = maps[0]['tue_flg'];
    rn.wed_flg = maps[0]['wed_flg'];
    rn.thu_flg = maps[0]['thu_flg'];
    rn.fri_flg = maps[0]['fri_flg'];
    rn.sat_flg = maps[0]['sat_flg'];
    rn.date_flg1 = maps[0]['date_flg1'];
    rn.date_flg2 = maps[0]['date_flg2'];
    rn.date_flg3 = maps[0]['date_flg3'];
    rn.date_flg4 = maps[0]['date_flg4'];
    rn.date_flg5 = maps[0]['date_flg5'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.cust_kind_trgt = maps[0]['cust_kind_trgt'];
    rn.n_custom1 = maps[0]['n_custom1'];
    rn.n_custom2 = maps[0]['n_custom2'];
    rn.n_custom3 = maps[0]['n_custom3'];
    rn.n_custom4 = maps[0]['n_custom4'];
    rn.n_custom5 = maps[0]['n_custom5'];
    rn.n_custom6 = maps[0]['n_custom6'];
    rn.n_custom7 = maps[0]['n_custom7'];
    rn.n_custom8 = maps[0]['n_custom8'];
    rn.s_custom1 = maps[0]['s_custom1'];
    rn.s_custom2 = maps[0]['s_custom2'];
    rn.s_custom3 = maps[0]['s_custom3'];
    rn.s_custom4 = maps[0]['s_custom4'];
    rn.s_custom5 = maps[0]['s_custom5'];
    rn.s_custom6 = maps[0]['s_custom6'];
    rn.s_custom7 = maps[0]['s_custom7'];
    rn.s_custom8 = maps[0]['s_custom8'];
    rn.c_custom1 = maps[0]['c_custom1'];
    rn.c_custom2 = maps[0]['c_custom2'];
    rn.c_custom3 = maps[0]['c_custom3'];
    rn.c_custom4 = maps[0]['c_custom4'];
    rn.d_custom1 = maps[0]['d_custom1'];
    rn.d_custom2 = maps[0]['d_custom2'];
    rn.d_custom3 = maps[0]['d_custom3'];
    rn.d_custom4 = maps[0]['d_custom4'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CStpplnMstField.cpn_id : this.cpn_id,
      CStpplnMstField.plan_cd : this.plan_cd,
      CStpplnMstField.comp_cd : this.comp_cd,
      CStpplnMstField.stre_cd : this.stre_cd,
      CStpplnMstField.all_cust_flg : this.all_cust_flg,
      CStpplnMstField.cust_kind_flg : this.cust_kind_flg,
      CStpplnMstField.plan_name : this.plan_name,
      CStpplnMstField.rcpt_name : this.rcpt_name,
      CStpplnMstField.format_flg : this.format_flg,
      CStpplnMstField.pict_path : this.pict_path,
      CStpplnMstField.notes : this.notes,
      CStpplnMstField.prn_stre_name : this.prn_stre_name,
      CStpplnMstField.prn_time : this.prn_time,
      CStpplnMstField.c_data1 : this.c_data1,
      CStpplnMstField.c_data2 : this.c_data2,
      CStpplnMstField.c_data3 : this.c_data3,
      CStpplnMstField.c_data4 : this.c_data4,
      CStpplnMstField.c_data5 : this.c_data5,
      CStpplnMstField.c_data6 : this.c_data6,
      CStpplnMstField.s_data1 : this.s_data1,
      CStpplnMstField.s_data2 : this.s_data2,
      CStpplnMstField.s_data3 : this.s_data3,
      CStpplnMstField.ref_unit_flg : this.ref_unit_flg,
      CStpplnMstField.cond_class_flg : this.cond_class_flg,
      CStpplnMstField.low_lim : this.low_lim,
      CStpplnMstField.upp_lim : this.upp_lim,
      CStpplnMstField.rec_limit : this.rec_limit,
      CStpplnMstField.day_limit : this.day_limit,
      CStpplnMstField.max_limit : this.max_limit,
      CStpplnMstField.start_datetime : this.start_datetime,
      CStpplnMstField.end_datetime : this.end_datetime,
      CStpplnMstField.svs_start_datetime : this.svs_start_datetime,
      CStpplnMstField.svs_end_datetime : this.svs_end_datetime,
      CStpplnMstField.stop_flg : this.stop_flg,
      CStpplnMstField.timesch_flg : this.timesch_flg,
      CStpplnMstField.sun_flg : this.sun_flg,
      CStpplnMstField.mon_flg : this.mon_flg,
      CStpplnMstField.tue_flg : this.tue_flg,
      CStpplnMstField.wed_flg : this.wed_flg,
      CStpplnMstField.thu_flg : this.thu_flg,
      CStpplnMstField.fri_flg : this.fri_flg,
      CStpplnMstField.sat_flg : this.sat_flg,
      CStpplnMstField.date_flg1 : this.date_flg1,
      CStpplnMstField.date_flg2 : this.date_flg2,
      CStpplnMstField.date_flg3 : this.date_flg3,
      CStpplnMstField.date_flg4 : this.date_flg4,
      CStpplnMstField.date_flg5 : this.date_flg5,
      CStpplnMstField.ins_datetime : this.ins_datetime,
      CStpplnMstField.upd_datetime : this.upd_datetime,
      CStpplnMstField.status : this.status,
      CStpplnMstField.send_flg : this.send_flg,
      CStpplnMstField.upd_user : this.upd_user,
      CStpplnMstField.upd_system : this.upd_system,
      CStpplnMstField.cust_kind_trgt : this.cust_kind_trgt,
      CStpplnMstField.n_custom1 : this.n_custom1,
      CStpplnMstField.n_custom2 : this.n_custom2,
      CStpplnMstField.n_custom3 : this.n_custom3,
      CStpplnMstField.n_custom4 : this.n_custom4,
      CStpplnMstField.n_custom5 : this.n_custom5,
      CStpplnMstField.n_custom6 : this.n_custom6,
      CStpplnMstField.n_custom7 : this.n_custom7,
      CStpplnMstField.n_custom8 : this.n_custom8,
      CStpplnMstField.s_custom1 : this.s_custom1,
      CStpplnMstField.s_custom2 : this.s_custom2,
      CStpplnMstField.s_custom3 : this.s_custom3,
      CStpplnMstField.s_custom4 : this.s_custom4,
      CStpplnMstField.s_custom5 : this.s_custom5,
      CStpplnMstField.s_custom6 : this.s_custom6,
      CStpplnMstField.s_custom7 : this.s_custom7,
      CStpplnMstField.s_custom8 : this.s_custom8,
      CStpplnMstField.c_custom1 : this.c_custom1,
      CStpplnMstField.c_custom2 : this.c_custom2,
      CStpplnMstField.c_custom3 : this.c_custom3,
      CStpplnMstField.c_custom4 : this.c_custom4,
      CStpplnMstField.d_custom1 : this.d_custom1,
      CStpplnMstField.d_custom2 : this.d_custom2,
      CStpplnMstField.d_custom3 : this.d_custom3,
      CStpplnMstField.d_custom4 : this.d_custom4,
    };
  }
}

/// 07_18 スタンプカード企画マスタ c_stppln_mstのフィールド名設定用クラス
class CStpplnMstField {
  static const cpn_id = "cpn_id";
  static const plan_cd = "plan_cd";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const all_cust_flg = "all_cust_flg";
  static const cust_kind_flg = "cust_kind_flg";
  static const plan_name = "plan_name";
  static const rcpt_name = "rcpt_name";
  static const format_flg = "format_flg";
  static const pict_path = "pict_path";
  static const notes = "notes";
  static const prn_stre_name = "prn_stre_name";
  static const prn_time = "prn_time";
  static const c_data1 = "c_data1";
  static const c_data2 = "c_data2";
  static const c_data3 = "c_data3";
  static const c_data4 = "c_data4";
  static const c_data5 = "c_data5";
  static const c_data6 = "c_data6";
  static const s_data1 = "s_data1";
  static const s_data2 = "s_data2";
  static const s_data3 = "s_data3";
  static const ref_unit_flg = "ref_unit_flg";
  static const cond_class_flg = "cond_class_flg";
  static const low_lim = "low_lim";
  static const upp_lim = "upp_lim";
  static const rec_limit = "rec_limit";
  static const day_limit = "day_limit";
  static const max_limit = "max_limit";
  static const start_datetime = "start_datetime";
  static const end_datetime = "end_datetime";
  static const svs_start_datetime = "svs_start_datetime";
  static const svs_end_datetime = "svs_end_datetime";
  static const stop_flg = "stop_flg";
  static const timesch_flg = "timesch_flg";
  static const sun_flg = "sun_flg";
  static const mon_flg = "mon_flg";
  static const tue_flg = "tue_flg";
  static const wed_flg = "wed_flg";
  static const thu_flg = "thu_flg";
  static const fri_flg = "fri_flg";
  static const sat_flg = "sat_flg";
  static const date_flg1 = "date_flg1";
  static const date_flg2 = "date_flg2";
  static const date_flg3 = "date_flg3";
  static const date_flg4 = "date_flg4";
  static const date_flg5 = "date_flg5";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const cust_kind_trgt = "cust_kind_trgt";
  static const n_custom1 = "n_custom1";
  static const n_custom2 = "n_custom2";
  static const n_custom3 = "n_custom3";
  static const n_custom4 = "n_custom4";
  static const n_custom5 = "n_custom5";
  static const n_custom6 = "n_custom6";
  static const n_custom7 = "n_custom7";
  static const n_custom8 = "n_custom8";
  static const s_custom1 = "s_custom1";
  static const s_custom2 = "s_custom2";
  static const s_custom3 = "s_custom3";
  static const s_custom4 = "s_custom4";
  static const s_custom5 = "s_custom5";
  static const s_custom6 = "s_custom6";
  static const s_custom7 = "s_custom7";
  static const s_custom8 = "s_custom8";
  static const c_custom1 = "c_custom1";
  static const c_custom2 = "c_custom2";
  static const c_custom3 = "c_custom3";
  static const c_custom4 = "c_custom4";
  static const d_custom1 = "d_custom1";
  static const d_custom2 = "d_custom2";
  static const d_custom3 = "d_custom3";
  static const d_custom4 = "d_custom4";
}
//endregion