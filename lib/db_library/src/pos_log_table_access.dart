/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
05_POS_ログ
05_1	実績ヘッダログ	c_header_log
05_2	実績データログ	c_data_log
05_3	実績ステータスログ	c_status_log
05_4	実績ジャーナルデータログ	c_ej_log
05_5	訂正確認ログ	c_void_log_01
05_6	公共料金_収納ログ	c_pbchg_log
05_7	予約ログ	c_reserv_log
05_8	リカバリー確認用テーブル	c_recover_tbl
公共料金_収納ログ01	c_pbchg_log_01
予約ログ01	c_reserv_log_01
RM3800 フローティング用実績ヘッダログ	c_header_log_floating
RM3800 フローティング用実績データログ	c_data_log_floating
RM3800 フローティング用実績ステータスログ c_status_log_floating
ハイタッチ受信ログ c_hitouch_rcv_log
 */

//region 05_1	実績ヘッダログ	c_header_log
/// 05_1  実績ヘッダログ  c_header_logクラス
class CHeaderLogColumns extends TableColumns{
  String? serial_no = '0';
  int comp_cd = 0;
  int stre_cd = 0;
  int mac_no = 0;
  int receipt_no = 0;
  int print_no = 0;
  int cshr_no = 0;
  int chkr_no = 0;
  String? cust_no;
  String? sale_date;
  String? starttime;
  String? endtime;
  int ope_mode_flg = 0;
  int inout_flg = 0;
  int prn_typ = 0;
  String void_serial_no = '0';
  String qc_serial_no = '0';
  int void_kind = 0;
  String? void_sale_date;
  int data_log_cnt = 0;
  int ej_log_cnt = 0;
  int status_log_cnt = 0;
  int tran_flg = 0;
  int sub_tran_flg = 0;
  int off_entry_flg = 0;
  int various_flg_1 = 0;
  int various_flg_2 = 0;
  int various_flg_3 = 0;
  int various_num_1 = 0;
  int various_num_2 = 0;
  int various_num_3 = 0;
  String? various_data;
  int various_flg_4 = 0;
  int various_flg_5 = 0;
  int various_flg_6 = 0;
  int various_flg_7 = 0;
  int various_flg_8 = 0;
  int various_flg_9 = 0;
  int various_flg_10 = 0;
  int various_flg_11 = 0;
  int various_flg_12 = 0;
  int various_flg_13 = 0;
  int reserv_flg = 0;
  int reserv_stre_cd = 0;
  int reserv_status = 0;
  int reserv_chg_cnt = 0;
  String? reserv_cd;
  String? lock_cd;

  @override
  String _getTableName() => "c_header_log";

  @override
  String? _getKeyCondition() => 'serial_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CHeaderLogColumns rn = CHeaderLogColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.receipt_no = maps[i]['receipt_no'];
      rn.print_no = maps[i]['print_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cust_no = maps[i]['cust_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.starttime = maps[i]['starttime'];
      rn.endtime = maps[i]['endtime'];
      rn.ope_mode_flg = maps[i]['ope_mode_flg'];
      rn.inout_flg = maps[i]['inout_flg'];
      rn.prn_typ = maps[i]['prn_typ'];
      rn.void_serial_no = maps[i]['void_serial_no'];
      rn.qc_serial_no = maps[i]['qc_serial_no'];
      rn.void_kind = maps[i]['void_kind'];
      rn.void_sale_date = maps[i]['void_sale_date'];
      rn.data_log_cnt = maps[i]['data_log_cnt'];
      rn.ej_log_cnt = maps[i]['ej_log_cnt'];
      rn.status_log_cnt = maps[i]['status_log_cnt'];
      rn.tran_flg = maps[i]['tran_flg'];
      rn.sub_tran_flg = maps[i]['sub_tran_flg'];
      rn.off_entry_flg = maps[i]['off_entry_flg'];
      rn.various_flg_1 = maps[i]['various_flg_1'];
      rn.various_flg_2 = maps[i]['various_flg_2'];
      rn.various_flg_3 = maps[i]['various_flg_3'];
      rn.various_num_1 = maps[i]['various_num_1'];
      rn.various_num_2 = maps[i]['various_num_2'];
      rn.various_num_3 = maps[i]['various_num_3'];
      rn.various_data = maps[i]['various_data'];
      rn.various_flg_4 = maps[i]['various_flg_4'];
      rn.various_flg_5 = maps[i]['various_flg_5'];
      rn.various_flg_6 = maps[i]['various_flg_6'];
      rn.various_flg_7 = maps[i]['various_flg_7'];
      rn.various_flg_8 = maps[i]['various_flg_8'];
      rn.various_flg_9 = maps[i]['various_flg_9'];
      rn.various_flg_10 = maps[i]['various_flg_10'];
      rn.various_flg_11 = maps[i]['various_flg_11'];
      rn.various_flg_12 = maps[i]['various_flg_12'];
      rn.various_flg_13 = maps[i]['various_flg_13'];
      rn.reserv_flg = maps[i]['reserv_flg'];
      rn.reserv_stre_cd = maps[i]['reserv_stre_cd'];
      rn.reserv_status = maps[i]['reserv_status'];
      rn.reserv_chg_cnt = maps[i]['reserv_chg_cnt'];
      rn.reserv_cd = maps[i]['reserv_cd'];
      rn.lock_cd = maps[i]['lock_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CHeaderLogColumns rn = CHeaderLogColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.receipt_no = maps[0]['receipt_no'];
    rn.print_no = maps[0]['print_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cust_no = maps[0]['cust_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.starttime = maps[0]['starttime'];
    rn.endtime = maps[0]['endtime'];
    rn.ope_mode_flg = maps[0]['ope_mode_flg'];
    rn.inout_flg = maps[0]['inout_flg'];
    rn.prn_typ = maps[0]['prn_typ'];
    rn.void_serial_no = maps[0]['void_serial_no'];
    rn.qc_serial_no = maps[0]['qc_serial_no'];
    rn.void_kind = maps[0]['void_kind'];
    rn.void_sale_date = maps[0]['void_sale_date'];
    rn.data_log_cnt = maps[0]['data_log_cnt'];
    rn.ej_log_cnt = maps[0]['ej_log_cnt'];
    rn.status_log_cnt = maps[0]['status_log_cnt'];
    rn.tran_flg = maps[0]['tran_flg'];
    rn.sub_tran_flg = maps[0]['sub_tran_flg'];
    rn.off_entry_flg = maps[0]['off_entry_flg'];
    rn.various_flg_1 = maps[0]['various_flg_1'];
    rn.various_flg_2 = maps[0]['various_flg_2'];
    rn.various_flg_3 = maps[0]['various_flg_3'];
    rn.various_num_1 = maps[0]['various_num_1'];
    rn.various_num_2 = maps[0]['various_num_2'];
    rn.various_num_3 = maps[0]['various_num_3'];
    rn.various_data = maps[0]['various_data'];
    rn.various_flg_4 = maps[0]['various_flg_4'];
    rn.various_flg_5 = maps[0]['various_flg_5'];
    rn.various_flg_6 = maps[0]['various_flg_6'];
    rn.various_flg_7 = maps[0]['various_flg_7'];
    rn.various_flg_8 = maps[0]['various_flg_8'];
    rn.various_flg_9 = maps[0]['various_flg_9'];
    rn.various_flg_10 = maps[0]['various_flg_10'];
    rn.various_flg_11 = maps[0]['various_flg_11'];
    rn.various_flg_12 = maps[0]['various_flg_12'];
    rn.various_flg_13 = maps[0]['various_flg_13'];
    rn.reserv_flg = maps[0]['reserv_flg'];
    rn.reserv_stre_cd = maps[0]['reserv_stre_cd'];
    rn.reserv_status = maps[0]['reserv_status'];
    rn.reserv_chg_cnt = maps[0]['reserv_chg_cnt'];
    rn.reserv_cd = maps[0]['reserv_cd'];
    rn.lock_cd = maps[0]['lock_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CHeaderLogField.serial_no : this.serial_no,
      CHeaderLogField.comp_cd : this.comp_cd,
      CHeaderLogField.stre_cd : this.stre_cd,
      CHeaderLogField.mac_no : this.mac_no,
      CHeaderLogField.receipt_no : this.receipt_no,
      CHeaderLogField.print_no : this.print_no,
      CHeaderLogField.cshr_no : this.cshr_no,
      CHeaderLogField.chkr_no : this.chkr_no,
      CHeaderLogField.cust_no : this.cust_no,
      CHeaderLogField.sale_date : this.sale_date,
      CHeaderLogField.starttime : this.starttime,
      CHeaderLogField.endtime : this.endtime,
      CHeaderLogField.ope_mode_flg : this.ope_mode_flg,
      CHeaderLogField.inout_flg : this.inout_flg,
      CHeaderLogField.prn_typ : this.prn_typ,
      CHeaderLogField.void_serial_no : this.void_serial_no,
      CHeaderLogField.qc_serial_no : this.qc_serial_no,
      CHeaderLogField.void_kind : this.void_kind,
      CHeaderLogField.void_sale_date : this.void_sale_date,
      CHeaderLogField.data_log_cnt : this.data_log_cnt,
      CHeaderLogField.ej_log_cnt : this.ej_log_cnt,
      CHeaderLogField.status_log_cnt : this.status_log_cnt,
      CHeaderLogField.tran_flg : this.tran_flg,
      CHeaderLogField.sub_tran_flg : this.sub_tran_flg,
      CHeaderLogField.off_entry_flg : this.off_entry_flg,
      CHeaderLogField.various_flg_1 : this.various_flg_1,
      CHeaderLogField.various_flg_2 : this.various_flg_2,
      CHeaderLogField.various_flg_3 : this.various_flg_3,
      CHeaderLogField.various_num_1 : this.various_num_1,
      CHeaderLogField.various_num_2 : this.various_num_2,
      CHeaderLogField.various_num_3 : this.various_num_3,
      CHeaderLogField.various_data : this.various_data,
      CHeaderLogField.various_flg_4 : this.various_flg_4,
      CHeaderLogField.various_flg_5 : this.various_flg_5,
      CHeaderLogField.various_flg_6 : this.various_flg_6,
      CHeaderLogField.various_flg_7 : this.various_flg_7,
      CHeaderLogField.various_flg_8 : this.various_flg_8,
      CHeaderLogField.various_flg_9 : this.various_flg_9,
      CHeaderLogField.various_flg_10 : this.various_flg_10,
      CHeaderLogField.various_flg_11 : this.various_flg_11,
      CHeaderLogField.various_flg_12 : this.various_flg_12,
      CHeaderLogField.various_flg_13 : this.various_flg_13,
      CHeaderLogField.reserv_flg : this.reserv_flg,
      CHeaderLogField.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLogField.reserv_status : this.reserv_status,
      CHeaderLogField.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLogField.reserv_cd : this.reserv_cd,
      CHeaderLogField.lock_cd : this.lock_cd,
    };
  }
}

/// 05_1  実績ヘッダログ  c_header_logのフィールド名設定用クラス
class CHeaderLogField {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const receipt_no = "receipt_no";
  static const print_no = "print_no";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const cust_no = "cust_no";
  static const sale_date = "sale_date";
  static const starttime = "starttime";
  static const endtime = "endtime";
  static const ope_mode_flg = "ope_mode_flg";
  static const inout_flg = "inout_flg";
  static const prn_typ = "prn_typ";
  static const void_serial_no = "void_serial_no";
  static const qc_serial_no = "qc_serial_no";
  static const void_kind = "void_kind";
  static const void_sale_date = "void_sale_date";
  static const data_log_cnt = "data_log_cnt";
  static const ej_log_cnt = "ej_log_cnt";
  static const status_log_cnt = "status_log_cnt";
  static const tran_flg = "tran_flg";
  static const sub_tran_flg = "sub_tran_flg";
  static const off_entry_flg = "off_entry_flg";
  static const various_flg_1 = "various_flg_1";
  static const various_flg_2 = "various_flg_2";
  static const various_flg_3 = "various_flg_3";
  static const various_num_1 = "various_num_1";
  static const various_num_2 = "various_num_2";
  static const various_num_3 = "various_num_3";
  static const various_data = "various_data";
  static const various_flg_4 = "various_flg_4";
  static const various_flg_5 = "various_flg_5";
  static const various_flg_6 = "various_flg_6";
  static const various_flg_7 = "various_flg_7";
  static const various_flg_8 = "various_flg_8";
  static const various_flg_9 = "various_flg_9";
  static const various_flg_10 = "various_flg_10";
  static const various_flg_11 = "various_flg_11";
  static const various_flg_12 = "various_flg_12";
  static const various_flg_13 = "various_flg_13";
  static const reserv_flg = "reserv_flg";
  static const reserv_stre_cd = "reserv_stre_cd";
  static const reserv_status = "reserv_status";
  static const reserv_chg_cnt = "reserv_chg_cnt";
  static const reserv_cd = "reserv_cd";
  static const lock_cd = "lock_cd";
}
//endregion
//region 05_2	実績データログ	c_data_log
/// 05_2  実績データログ  c_data_logクラス
class CDataLogColumns extends TableColumns{
  String? serial_no = '0';
  int seq_no = 0;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? c_data1;
  String? c_data2;
  String? c_data3;
  String? c_data4;
  String? c_data5;
  String? c_data6;
  String? c_data7;
  String? c_data8;
  String? c_data9;
  String? c_data10;
  double? n_data1 = 0;
  double? n_data2 = 0;
  double? n_data3 = 0;
  double? n_data4 = 0;
  double? n_data5 = 0;
  double? n_data6 = 0;
  double? n_data7 = 0;
  double? n_data8 = 0;
  double? n_data9 = 0;
  double? n_data10 = 0;
  double? n_data11 = 0;
  double? n_data12 = 0;
  double? n_data13 = 0;
  double? n_data14 = 0;
  double? n_data15 = 0;
  double? n_data16 = 0;
  double? n_data17 = 0;
  double? n_data18 = 0;
  double? n_data19 = 0;
  double? n_data20 = 0;
  double? n_data21 = 0;
  double? n_data22 = 0;
  double? n_data23 = 0;
  double? n_data24 = 0;
  double? n_data25 = 0;
  double? n_data26 = 0;
  double? n_data27 = 0;
  double? n_data28 = 0;
  double? n_data29 = 0;
  double? n_data30 = 0;
  String? d_data1;
  String? d_data2;
  String? d_data3;
  String? d_data4;
  String? d_data5;

  @override
  String _getTableName() => "c_data_log";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CDataLogColumns rn = CDataLogColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.cnct_seq_no = maps[i]['cnct_seq_no'];
      rn.func_cd = maps[i]['func_cd'];
      rn.func_seq_no = maps[i]['func_seq_no'];
      rn.c_data1 = maps[i]['c_data1'];
      rn.c_data2 = maps[i]['c_data2'];
      rn.c_data3 = maps[i]['c_data3'];
      rn.c_data4 = maps[i]['c_data4'];
      rn.c_data5 = maps[i]['c_data5'];
      rn.c_data6 = maps[i]['c_data6'];
      rn.c_data7 = maps[i]['c_data7'];
      rn.c_data8 = maps[i]['c_data8'];
      rn.c_data9 = maps[i]['c_data9'];
      rn.c_data10 = maps[i]['c_data10'];
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
      rn.n_data17 = maps[i]['n_data17'];
      rn.n_data18 = maps[i]['n_data18'];
      rn.n_data19 = maps[i]['n_data19'];
      rn.n_data20 = maps[i]['n_data20'];
      rn.n_data21 = maps[i]['n_data21'];
      rn.n_data22 = maps[i]['n_data22'];
      rn.n_data23 = maps[i]['n_data23'];
      rn.n_data24 = maps[i]['n_data24'];
      rn.n_data25 = maps[i]['n_data25'];
      rn.n_data26 = maps[i]['n_data26'];
      rn.n_data27 = maps[i]['n_data27'];
      rn.n_data28 = maps[i]['n_data28'];
      rn.n_data29 = maps[i]['n_data29'];
      rn.n_data30 = maps[i]['n_data30'];
      rn.d_data1 = maps[i]['d_data1'];
      rn.d_data2 = maps[i]['d_data2'];
      rn.d_data3 = maps[i]['d_data3'];
      rn.d_data4 = maps[i]['d_data4'];
      rn.d_data5 = maps[i]['d_data5'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CDataLogColumns rn = CDataLogColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.cnct_seq_no = maps[0]['cnct_seq_no'];
    rn.func_cd = maps[0]['func_cd'];
    rn.func_seq_no = maps[0]['func_seq_no'];
    rn.c_data1 = maps[0]['c_data1'];
    rn.c_data2 = maps[0]['c_data2'];
    rn.c_data3 = maps[0]['c_data3'];
    rn.c_data4 = maps[0]['c_data4'];
    rn.c_data5 = maps[0]['c_data5'];
    rn.c_data6 = maps[0]['c_data6'];
    rn.c_data7 = maps[0]['c_data7'];
    rn.c_data8 = maps[0]['c_data8'];
    rn.c_data9 = maps[0]['c_data9'];
    rn.c_data10 = maps[0]['c_data10'];
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
    rn.n_data17 = maps[0]['n_data17'];
    rn.n_data18 = maps[0]['n_data18'];
    rn.n_data19 = maps[0]['n_data19'];
    rn.n_data20 = maps[0]['n_data20'];
    rn.n_data21 = maps[0]['n_data21'];
    rn.n_data22 = maps[0]['n_data22'];
    rn.n_data23 = maps[0]['n_data23'];
    rn.n_data24 = maps[0]['n_data24'];
    rn.n_data25 = maps[0]['n_data25'];
    rn.n_data26 = maps[0]['n_data26'];
    rn.n_data27 = maps[0]['n_data27'];
    rn.n_data28 = maps[0]['n_data28'];
    rn.n_data29 = maps[0]['n_data29'];
    rn.n_data30 = maps[0]['n_data30'];
    rn.d_data1 = maps[0]['d_data1'];
    rn.d_data2 = maps[0]['d_data2'];
    rn.d_data3 = maps[0]['d_data3'];
    rn.d_data4 = maps[0]['d_data4'];
    rn.d_data5 = maps[0]['d_data5'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CDataLogField.serial_no : this.serial_no,
      CDataLogField.seq_no : this.seq_no,
      CDataLogField.cnct_seq_no : this.cnct_seq_no,
      CDataLogField.func_cd : this.func_cd,
      CDataLogField.func_seq_no : this.func_seq_no,
      CDataLogField.c_data1 : this.c_data1,
      CDataLogField.c_data2 : this.c_data2,
      CDataLogField.c_data3 : this.c_data3,
      CDataLogField.c_data4 : this.c_data4,
      CDataLogField.c_data5 : this.c_data5,
      CDataLogField.c_data6 : this.c_data6,
      CDataLogField.c_data7 : this.c_data7,
      CDataLogField.c_data8 : this.c_data8,
      CDataLogField.c_data9 : this.c_data9,
      CDataLogField.c_data10 : this.c_data10,
      CDataLogField.n_data1 : this.n_data1,
      CDataLogField.n_data2 : this.n_data2,
      CDataLogField.n_data3 : this.n_data3,
      CDataLogField.n_data4 : this.n_data4,
      CDataLogField.n_data5 : this.n_data5,
      CDataLogField.n_data6 : this.n_data6,
      CDataLogField.n_data7 : this.n_data7,
      CDataLogField.n_data8 : this.n_data8,
      CDataLogField.n_data9 : this.n_data9,
      CDataLogField.n_data10 : this.n_data10,
      CDataLogField.n_data11 : this.n_data11,
      CDataLogField.n_data12 : this.n_data12,
      CDataLogField.n_data13 : this.n_data13,
      CDataLogField.n_data14 : this.n_data14,
      CDataLogField.n_data15 : this.n_data15,
      CDataLogField.n_data16 : this.n_data16,
      CDataLogField.n_data17 : this.n_data17,
      CDataLogField.n_data18 : this.n_data18,
      CDataLogField.n_data19 : this.n_data19,
      CDataLogField.n_data20 : this.n_data20,
      CDataLogField.n_data21 : this.n_data21,
      CDataLogField.n_data22 : this.n_data22,
      CDataLogField.n_data23 : this.n_data23,
      CDataLogField.n_data24 : this.n_data24,
      CDataLogField.n_data25 : this.n_data25,
      CDataLogField.n_data26 : this.n_data26,
      CDataLogField.n_data27 : this.n_data27,
      CDataLogField.n_data28 : this.n_data28,
      CDataLogField.n_data29 : this.n_data29,
      CDataLogField.n_data30 : this.n_data30,
      CDataLogField.d_data1 : this.d_data1,
      CDataLogField.d_data2 : this.d_data2,
      CDataLogField.d_data3 : this.d_data3,
      CDataLogField.d_data4 : this.d_data4,
      CDataLogField.d_data5 : this.d_data5,
    };
  }
}

/// 05_2  実績データログ  c_data_logのフィールド名設定用クラス
class CDataLogField {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const c_data1 = "c_data1";
  static const c_data2 = "c_data2";
  static const c_data3 = "c_data3";
  static const c_data4 = "c_data4";
  static const c_data5 = "c_data5";
  static const c_data6 = "c_data6";
  static const c_data7 = "c_data7";
  static const c_data8 = "c_data8";
  static const c_data9 = "c_data9";
  static const c_data10 = "c_data10";
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
  static const n_data17 = "n_data17";
  static const n_data18 = "n_data18";
  static const n_data19 = "n_data19";
  static const n_data20 = "n_data20";
  static const n_data21 = "n_data21";
  static const n_data22 = "n_data22";
  static const n_data23 = "n_data23";
  static const n_data24 = "n_data24";
  static const n_data25 = "n_data25";
  static const n_data26 = "n_data26";
  static const n_data27 = "n_data27";
  static const n_data28 = "n_data28";
  static const n_data29 = "n_data29";
  static const n_data30 = "n_data30";
  static const d_data1 = "d_data1";
  static const d_data2 = "d_data2";
  static const d_data3 = "d_data3";
  static const d_data4 = "d_data4";
  static const d_data5 = "d_data5";
}
//endregion
//region 05_3	実績ステータスログ	c_status_log
/// 05_3  実績ステータスログ  c_status_logクラス
class CStatusLogColumns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStatusLogColumns rn = CStatusLogColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.cnct_seq_no = maps[i]['cnct_seq_no'];
      rn.func_cd = maps[i]['func_cd'];
      rn.func_seq_no = maps[i]['func_seq_no'];
      rn.status_data = maps[i]['status_data'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CStatusLogColumns rn = CStatusLogColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.cnct_seq_no = maps[0]['cnct_seq_no'];
    rn.func_cd = maps[0]['func_cd'];
    rn.func_seq_no = maps[0]['func_seq_no'];
    rn.status_data = maps[0]['status_data'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CStatusLogField.serial_no : this.serial_no,
      CStatusLogField.seq_no : this.seq_no,
      CStatusLogField.cnct_seq_no : this.cnct_seq_no,
      CStatusLogField.func_cd : this.func_cd,
      CStatusLogField.func_seq_no : this.func_seq_no,
      CStatusLogField.status_data : this.status_data,
    };
  }
}

/// 05_3  実績ステータスログ  c_status_logのフィールド名設定用クラス
class CStatusLogField {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region 05_4	実績ジャーナルデータログ	c_ej_log
/// 05_4	実績ジャーナルデータログ	c_ej_logクラス
class CEjLogColumns extends TableColumns {
  String? serial_no = '0';
  int comp_cd = 0;
  int stre_cd = 0;
  int mac_no = 0;
  int print_no = 0;
  int? seq_no;
  int receipt_no = 0;
  int end_rec_flg = 0;
  int only_ejlog_flg = 0;
  int cshr_no = 0;
  int chkr_no = 0;
  String? now_sale_datetime;
  String? sale_date;
  int ope_mode_flg = 0;
  String? print_data;
  int sub_only_ejlog_flg = 0;
  String? trankey_search;
  String? etckey_search;

  @override
  String _getTableName() => 'c_ej_log';

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CEjLogColumns rn = CEjLogColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.print_no = maps[i]['print_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.receipt_no = maps[i]['receipt_no'];
      rn.end_rec_flg = maps[i]['end_rec_flg'];
      rn.only_ejlog_flg = maps[i]['only_ejlog_flg'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.now_sale_datetime = maps[i]['now_sale_datetime'];
      rn.sale_date = maps[i]['sale_date'];
      rn.ope_mode_flg = maps[i]['ope_mode_flg'];
      rn.print_data = maps[i]['print_data'];
      rn.sub_only_ejlog_flg = maps[i]['sub_only_ejlog_flg'];
      rn.trankey_search = maps[i]['trankey_search'];
      rn.etckey_search = maps[i]['etckey_search'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CEjLogColumns rn = CEjLogColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.print_no = maps[0]['print_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.receipt_no = maps[0]['receipt_no'];
    rn.end_rec_flg = maps[0]['end_rec_flg'];
    rn.only_ejlog_flg = maps[0]['only_ejlog_flg'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.now_sale_datetime = maps[0]['now_sale_datetime'];
    rn.sale_date = maps[0]['sale_date'];
    rn.ope_mode_flg = maps[0]['ope_mode_flg'];
    rn.print_data = maps[0]['print_data'];
    rn.sub_only_ejlog_flg = maps[0]['sub_only_ejlog_flg'];
    rn.trankey_search = maps[0]['trankey_search'];
    rn.etckey_search = maps[0]['etckey_search'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CEjLogField.serial_no: serial_no,
      CEjLogField.comp_cd: comp_cd,
      CEjLogField.stre_cd: stre_cd,
      CEjLogField.mac_no: mac_no,
      CEjLogField.print_no: print_no,
      CEjLogField.seq_no: seq_no,
      CEjLogField.receipt_no: receipt_no,
      CEjLogField.end_rec_flg: end_rec_flg,
      CEjLogField.only_ejlog_flg: only_ejlog_flg,
      CEjLogField.cshr_no: cshr_no,
      CEjLogField.chkr_no: chkr_no,
      CEjLogField.now_sale_datetime: now_sale_datetime,
      CEjLogField.sale_date: sale_date,
      CEjLogField.ope_mode_flg: ope_mode_flg,
      CEjLogField.print_data: print_data,
      CEjLogField.sub_only_ejlog_flg: sub_only_ejlog_flg,
      CEjLogField.trankey_search: trankey_search,
      CEjLogField.etckey_search: etckey_search,
    };
  }
}

/// 05_4	実績ジャーナルデータログ	c_ej_logのフィールド名設定用クラス
class CEjLogField {
  static const serial_no = 'serial_no';
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const mac_no = 'mac_no';
  static const print_no = 'print_no';
  static const seq_no = 'seq_no';
  static const receipt_no = 'receipt_no';
  static const end_rec_flg = 'end_rec_flg';
  static const only_ejlog_flg = 'only_ejlog_flg';
  static const cshr_no = 'cshr_no';
  static const chkr_no = 'chkr_no';
  static const now_sale_datetime = 'now_sale_datetime';
  static const sale_date = 'sale_date';
  static const ope_mode_flg = 'ope_mode_flg';
  static const print_data = 'print_data';
  static const sub_only_ejlog_flg = 'sub_only_ejlog_flg';
  static const trankey_search = 'trankey_search';
  static const etckey_search = 'etckey_search';
}
//endregion
//region 05_5	訂正確認ログ	c_void_log_01
/// 05_5  訂正確認ログ c_void_log_01クラス
class CVoidLog01Columns extends TableColumns{
  String? serial_no = '0';
  String? void_serial_no = '0';
  int mac_no = 0;
  String? sale_date;
  String? void_sale_date;
  int void_kind = 0;
  String? void_taxfree_no;
  String? various_data1;
  String? various_data2;

  @override
  String _getTableName() => "c_void_log_01";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND void_serial_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(void_serial_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CVoidLog01Columns rn = CVoidLog01Columns();
      rn.serial_no = maps[i]['serial_no'];
      rn.void_serial_no = maps[i]['void_serial_no'];
      rn.mac_no = maps[i]['mac_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.void_sale_date = maps[i]['void_sale_date'];
      rn.void_kind = maps[i]['void_kind'];
      rn.void_taxfree_no = maps[i]['void_taxfree_no'];
      rn.various_data1 = maps[i]['various_data1'];
      rn.various_data2 = maps[i]['various_data2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CVoidLog01Columns rn = CVoidLog01Columns();
    rn.serial_no = maps[0]['serial_no'];
    rn.void_serial_no = maps[0]['void_serial_no'];
    rn.mac_no = maps[0]['mac_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.void_sale_date = maps[0]['void_sale_date'];
    rn.void_kind = maps[0]['void_kind'];
    rn.void_taxfree_no = maps[0]['void_taxfree_no'];
    rn.various_data1 = maps[0]['various_data1'];
    rn.various_data2 = maps[0]['various_data2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CVoidLog01Field.serial_no : this.serial_no,
      CVoidLog01Field.void_serial_no : this.void_serial_no,
      CVoidLog01Field.mac_no : this.mac_no,
      CVoidLog01Field.sale_date : this.sale_date,
      CVoidLog01Field.void_sale_date : this.void_sale_date,
      CVoidLog01Field.void_kind : this.void_kind,
      CVoidLog01Field.void_taxfree_no : this.void_taxfree_no,
      CVoidLog01Field.various_data1 : this.various_data1,
      CVoidLog01Field.various_data2 : this.various_data2,
    };
  }
}

/// 05_5  訂正確認ログ c_void_log_01のフィールド名設定用クラス
class CVoidLog01Field {
  static const serial_no = "serial_no";
  static const void_serial_no = "void_serial_no";
  static const mac_no = "mac_no";
  static const sale_date = "sale_date";
  static const void_sale_date = "void_sale_date";
  static const void_kind = "void_kind";
  static const void_taxfree_no = "void_taxfree_no";
  static const various_data1 = "various_data1";
  static const various_data2 = "various_data2";
}
//endregion
//region 05_6	公共料金_収納ログ	c_pbchg_log
/// 05_6  公共料金_収納ログ  c_pbchg_logクラス
class CPbchgLogColumns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int comp_cd = 0;
  int stre_cd = 0;
  int mac_no = 0;
  String? date;
  String? time;
  int groupcd = 0;
  int officecd = 0;
  int strecd = 0;
  int termcd = 0;
  int dealseqno = 0;
  String? servicekind;
  int serviceseqno = 0;
  int settlestatus = 0;
  int settlekind = 0;
  int cashamt = 0;
  int charge1 = 0;
  int charge2 = 0;
  int dealererr = 0;
  int receipterr = 0;
  String? validdate;
  int barcodekind = 0;
  String? barcode1;
  String? barcode2;
  String? barcode3;
  String? barcode4;
  int receiptmsgno = 0;
  int comparestatus = 0;
  String? name;
  int tran_flg = 0;
  int sub_tran_flg = 0;
  int receipt_flg = 0;
  int matching_flg = 0;
  int check_flg = 0;
  int fil1 = 0;
  int fil2 = 0;

  @override
  String _getTableName() => "c_pbchg_log";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CPbchgLogColumns rn = CPbchgLogColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.date = maps[i]['date'];
      rn.time = maps[i]['time'];
      rn.groupcd = maps[i]['groupcd'];
      rn.officecd = maps[i]['officecd'];
      rn.strecd = maps[i]['strecd'];
      rn.termcd = maps[i]['termcd'];
      rn.dealseqno = maps[i]['dealseqno'];
      rn.servicekind = maps[i]['servicekind'];
      rn.serviceseqno = maps[i]['serviceseqno'];
      rn.settlestatus = maps[i]['settlestatus'];
      rn.settlekind = maps[i]['settlekind'];
      rn.cashamt = maps[i]['cashamt'];
      rn.charge1 = maps[i]['charge1'];
      rn.charge2 = maps[i]['charge2'];
      rn.dealererr = maps[i]['dealererr'];
      rn.receipterr = maps[i]['receipterr'];
      rn.validdate = maps[i]['validdate'];
      rn.barcodekind = maps[i]['barcodekind'];
      rn.barcode1 = maps[i]['barcode1'];
      rn.barcode2 = maps[i]['barcode2'];
      rn.barcode3 = maps[i]['barcode3'];
      rn.barcode4 = maps[i]['barcode4'];
      rn.receiptmsgno = maps[i]['receiptmsgno'];
      rn.comparestatus = maps[i]['comparestatus'];
      rn.name = maps[i]['name'];
      rn.tran_flg = maps[i]['tran_flg'];
      rn.sub_tran_flg = maps[i]['sub_tran_flg'];
      rn.receipt_flg = maps[i]['receipt_flg'];
      rn.matching_flg = maps[i]['matching_flg'];
      rn.check_flg = maps[i]['check_flg'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CPbchgLogColumns rn = CPbchgLogColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.date = maps[0]['date'];
    rn.time = maps[0]['time'];
    rn.groupcd = maps[0]['groupcd'];
    rn.officecd = maps[0]['officecd'];
    rn.strecd = maps[0]['strecd'];
    rn.termcd = maps[0]['termcd'];
    rn.dealseqno = maps[0]['dealseqno'];
    rn.servicekind = maps[0]['servicekind'];
    rn.serviceseqno = maps[0]['serviceseqno'];
    rn.settlestatus = maps[0]['settlestatus'];
    rn.settlekind = maps[0]['settlekind'];
    rn.cashamt = maps[0]['cashamt'];
    rn.charge1 = maps[0]['charge1'];
    rn.charge2 = maps[0]['charge2'];
    rn.dealererr = maps[0]['dealererr'];
    rn.receipterr = maps[0]['receipterr'];
    rn.validdate = maps[0]['validdate'];
    rn.barcodekind = maps[0]['barcodekind'];
    rn.barcode1 = maps[0]['barcode1'];
    rn.barcode2 = maps[0]['barcode2'];
    rn.barcode3 = maps[0]['barcode3'];
    rn.barcode4 = maps[0]['barcode4'];
    rn.receiptmsgno = maps[0]['receiptmsgno'];
    rn.comparestatus = maps[0]['comparestatus'];
    rn.name = maps[0]['name'];
    rn.tran_flg = maps[0]['tran_flg'];
    rn.sub_tran_flg = maps[0]['sub_tran_flg'];
    rn.receipt_flg = maps[0]['receipt_flg'];
    rn.matching_flg = maps[0]['matching_flg'];
    rn.check_flg = maps[0]['check_flg'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CPbchgLogField.serial_no : this.serial_no,
      CPbchgLogField.seq_no : this.seq_no,
      CPbchgLogField.comp_cd : this.comp_cd,
      CPbchgLogField.stre_cd : this.stre_cd,
      CPbchgLogField.mac_no : this.mac_no,
      CPbchgLogField.date : this.date,
      CPbchgLogField.time : this.time,
      CPbchgLogField.groupcd : this.groupcd,
      CPbchgLogField.officecd : this.officecd,
      CPbchgLogField.strecd : this.strecd,
      CPbchgLogField.termcd : this.termcd,
      CPbchgLogField.dealseqno : this.dealseqno,
      CPbchgLogField.servicekind : this.servicekind,
      CPbchgLogField.serviceseqno : this.serviceseqno,
      CPbchgLogField.settlestatus : this.settlestatus,
      CPbchgLogField.settlekind : this.settlekind,
      CPbchgLogField.cashamt : this.cashamt,
      CPbchgLogField.charge1 : this.charge1,
      CPbchgLogField.charge2 : this.charge2,
      CPbchgLogField.dealererr : this.dealererr,
      CPbchgLogField.receipterr : this.receipterr,
      CPbchgLogField.validdate : this.validdate,
      CPbchgLogField.barcodekind : this.barcodekind,
      CPbchgLogField.barcode1 : this.barcode1,
      CPbchgLogField.barcode2 : this.barcode2,
      CPbchgLogField.barcode3 : this.barcode3,
      CPbchgLogField.barcode4 : this.barcode4,
      CPbchgLogField.receiptmsgno : this.receiptmsgno,
      CPbchgLogField.comparestatus : this.comparestatus,
      CPbchgLogField.name : this.name,
      CPbchgLogField.tran_flg : this.tran_flg,
      CPbchgLogField.sub_tran_flg : this.sub_tran_flg,
      CPbchgLogField.receipt_flg : this.receipt_flg,
      CPbchgLogField.matching_flg : this.matching_flg,
      CPbchgLogField.check_flg : this.check_flg,
      CPbchgLogField.fil1 : this.fil1,
      CPbchgLogField.fil2 : this.fil2,
    };
  }
}

/// 05_6  公共料金_収納ログ  c_pbchg_logのフィールド名設定用クラス
class CPbchgLogField {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const date = "date";
  static const time = "time";
  static const groupcd = "groupcd";
  static const officecd = "officecd";
  static const strecd = "strecd";
  static const termcd = "termcd";
  static const dealseqno = "dealseqno";
  static const servicekind = "servicekind";
  static const serviceseqno = "serviceseqno";
  static const settlestatus = "settlestatus";
  static const settlekind = "settlekind";
  static const cashamt = "cashamt";
  static const charge1 = "charge1";
  static const charge2 = "charge2";
  static const dealererr = "dealererr";
  static const receipterr = "receipterr";
  static const validdate = "validdate";
  static const barcodekind = "barcodekind";
  static const barcode1 = "barcode1";
  static const barcode2 = "barcode2";
  static const barcode3 = "barcode3";
  static const barcode4 = "barcode4";
  static const receiptmsgno = "receiptmsgno";
  static const comparestatus = "comparestatus";
  static const name = "name";
  static const tran_flg = "tran_flg";
  static const sub_tran_flg = "sub_tran_flg";
  static const receipt_flg = "receipt_flg";
  static const matching_flg = "matching_flg";
  static const check_flg = "check_flg";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
}
//endregion
//region 05_7	予約ログ	c_reserv_log
/// 05_7  予約ログ c_reserv_logクラス
class CReservLogColumns extends TableColumns{
  String? serial_no = '0';
  String? now_sale_datetime;
  String? void_serial_no = '0';
  String? cust_no;
  String? last_name;
  String? first_name;
  String? tel_no1;
  String? tel_no2;
  String? address1;
  String? address2;
  String? address3;
  String? recept_date;
  String? ferry_date;
  String? arrival_date;
  int? qty;
  int? ttl;
  int? advance_money;
  String? memo1;
  String? memo2;
  int? fil1;
  int? fil2;
  int? fil3;
  int? finish;
  int? tran_flg;
  int? sub_tran_flg;
  int? center_flg;
  int? update_flg;

  @override
  String _getTableName() => "c_reserv_log";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND now_sale_datetime = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(now_sale_datetime);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReservLogColumns rn = CReservLogColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.now_sale_datetime = maps[i]['now_sale_datetime'];
      rn.void_serial_no = maps[i]['void_serial_no'];
      rn.cust_no = maps[i]['cust_no'];
      rn.last_name = maps[i]['last_name'];
      rn.first_name = maps[i]['first_name'];
      rn.tel_no1 = maps[i]['tel_no1'];
      rn.tel_no2 = maps[i]['tel_no2'];
      rn.address1 = maps[i]['address1'];
      rn.address2 = maps[i]['address2'];
      rn.address3 = maps[i]['address3'];
      rn.recept_date = maps[i]['recept_date'];
      rn.ferry_date = maps[i]['ferry_date'];
      rn.arrival_date = maps[i]['arrival_date'];
      rn.qty = maps[i]['qty'];
      rn.ttl = maps[i]['ttl'];
      rn.advance_money = maps[i]['advance_money'];
      rn.memo1 = maps[i]['memo1'];
      rn.memo2 = maps[i]['memo2'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      rn.fil3 = maps[i]['fil3'];
      rn.finish = maps[i]['finish'];
      rn.tran_flg = maps[i]['tran_flg'];
      rn.sub_tran_flg = maps[i]['sub_tran_flg'];
      rn.center_flg = maps[i]['center_flg'];
      rn.update_flg = maps[i]['update_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReservLogColumns rn = CReservLogColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.now_sale_datetime = maps[0]['now_sale_datetime'];
    rn.void_serial_no = maps[0]['void_serial_no'];
    rn.cust_no = maps[0]['cust_no'];
    rn.last_name = maps[0]['last_name'];
    rn.first_name = maps[0]['first_name'];
    rn.tel_no1 = maps[0]['tel_no1'];
    rn.tel_no2 = maps[0]['tel_no2'];
    rn.address1 = maps[0]['address1'];
    rn.address2 = maps[0]['address2'];
    rn.address3 = maps[0]['address3'];
    rn.recept_date = maps[0]['recept_date'];
    rn.ferry_date = maps[0]['ferry_date'];
    rn.arrival_date = maps[0]['arrival_date'];
    rn.qty = maps[0]['qty'];
    rn.ttl = maps[0]['ttl'];
    rn.advance_money = maps[0]['advance_money'];
    rn.memo1 = maps[0]['memo1'];
    rn.memo2 = maps[0]['memo2'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    rn.fil3 = maps[0]['fil3'];
    rn.finish = maps[0]['finish'];
    rn.tran_flg = maps[0]['tran_flg'];
    rn.sub_tran_flg = maps[0]['sub_tran_flg'];
    rn.center_flg = maps[0]['center_flg'];
    rn.update_flg = maps[0]['update_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReservLogField.serial_no : this.serial_no,
      CReservLogField.now_sale_datetime : this.now_sale_datetime,
      CReservLogField.void_serial_no : this.void_serial_no,
      CReservLogField.cust_no : this.cust_no,
      CReservLogField.last_name : this.last_name,
      CReservLogField.first_name : this.first_name,
      CReservLogField.tel_no1 : this.tel_no1,
      CReservLogField.tel_no2 : this.tel_no2,
      CReservLogField.address1 : this.address1,
      CReservLogField.address2 : this.address2,
      CReservLogField.address3 : this.address3,
      CReservLogField.recept_date : this.recept_date,
      CReservLogField.ferry_date : this.ferry_date,
      CReservLogField.arrival_date : this.arrival_date,
      CReservLogField.qty : this.qty,
      CReservLogField.ttl : this.ttl,
      CReservLogField.advance_money : this.advance_money,
      CReservLogField.memo1 : this.memo1,
      CReservLogField.memo2 : this.memo2,
      CReservLogField.fil1 : this.fil1,
      CReservLogField.fil2 : this.fil2,
      CReservLogField.fil3 : this.fil3,
      CReservLogField.finish : this.finish,
      CReservLogField.tran_flg : this.tran_flg,
      CReservLogField.sub_tran_flg : this.sub_tran_flg,
      CReservLogField.center_flg : this.center_flg,
      CReservLogField.update_flg : this.update_flg,
    };
  }
}

/// 05_7  予約ログ c_reserv_logのフィールド名設定用クラス
class CReservLogField {
  static const serial_no = "serial_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const void_serial_no = "void_serial_no";
  static const cust_no = "cust_no";
  static const last_name = "last_name";
  static const first_name = "first_name";
  static const tel_no1 = "tel_no1";
  static const tel_no2 = "tel_no2";
  static const address1 = "address1";
  static const address2 = "address2";
  static const address3 = "address3";
  static const recept_date = "recept_date";
  static const ferry_date = "ferry_date";
  static const arrival_date = "arrival_date";
  static const qty = "qty";
  static const ttl = "ttl";
  static const advance_money = "advance_money";
  static const memo1 = "memo1";
  static const memo2 = "memo2";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
  static const fil3 = "fil3";
  static const finish = "finish";
  static const tran_flg = "tran_flg";
  static const sub_tran_flg = "sub_tran_flg";
  static const center_flg = "center_flg";
  static const update_flg = "update_flg";
}
//endregion
//region 05_8	リカバリー確認用テーブル	c_recover_tbl
/// 05_8  リカバリー確認用テーブル c_recover_tblクラス
class CRecoverTblColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  String? sale_date;
  int exec_flg = 0;
  String? ins_datetime;
  String? upd_datetime;

  @override
  String _getTableName() => "c_recover_tbl";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND sale_date = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(sale_date);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CRecoverTblColumns rn = CRecoverTblColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.exec_flg = maps[i]['exec_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CRecoverTblColumns rn = CRecoverTblColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.exec_flg = maps[0]['exec_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CRecoverTblField.comp_cd : this.comp_cd,
      CRecoverTblField.stre_cd : this.stre_cd,
      CRecoverTblField.mac_no : this.mac_no,
      CRecoverTblField.sale_date : this.sale_date,
      CRecoverTblField.exec_flg : this.exec_flg,
      CRecoverTblField.ins_datetime : this.ins_datetime,
      CRecoverTblField.upd_datetime : this.upd_datetime,
    };
  }
}

/// 05_8  リカバリー確認用テーブル c_recover_tblのフィールド名設定用クラス
class CRecoverTblField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const sale_date = "sale_date";
  static const exec_flg = "exec_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
}
//endregion
//region 公共料金_収納ログ01	c_pbchg_log_01
/// 公共料金_収納ログ01 c_pbchg_log_01クラス
class CPbchgLog01Columns extends TableColumns{
  String? serial_no;
  int? seq_no;
  int comp_cd = 0;
  int stre_cd = 0;
  int mac_no = 0;
  String? date;
  String? time;
  int groupcd = 0;
  int officecd = 0;
  int strecd = 0;
  int termcd = 0;
  int dealseqno = 0;
  String? servicekind;
  int serviceseqno = 0;
  int settlestatus = 0;
  int settlekind = 0;
  int cashamt = 0;
  int charge1 = 0;
  int charge2 = 0;
  int dealererr = 0;
  int receipterr = 0;
  String? validdate;
  int barcodekind = 0;
  String? barcode1;
  String? barcode2;
  String? barcode3;
  String? barcode4;
  int receiptmsgno = 0;
  int comparestatus = 0;
  String? name;
  int tran_flg = 0;
  int sub_tran_flg = 0;
  int receipt_flg = 0;
  int matching_flg = 0;
  int check_flg = 0;
  int fil1 = 0;
  int fil2 = 0;

  @override
  String _getTableName() => "c_pbchg_log_01";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CPbchgLog01Columns rn = CPbchgLog01Columns();
      rn.serial_no = maps[i]['serial_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.date = maps[i]['date'];
      rn.time = maps[i]['time'];
      rn.groupcd = maps[i]['groupcd'];
      rn.officecd = maps[i]['officecd'];
      rn.strecd = maps[i]['strecd'];
      rn.termcd = maps[i]['termcd'];
      rn.dealseqno = maps[i]['dealseqno'];
      rn.servicekind = maps[i]['servicekind'];
      rn.serviceseqno = maps[i]['serviceseqno'];
      rn.settlestatus = maps[i]['settlestatus'];
      rn.settlekind = maps[i]['settlekind'];
      rn.cashamt = maps[i]['cashamt'];
      rn.charge1 = maps[i]['charge1'];
      rn.charge2 = maps[i]['charge2'];
      rn.dealererr = maps[i]['dealererr'];
      rn.receipterr = maps[i]['receipterr'];
      rn.validdate = maps[i]['validdate'];
      rn.barcodekind = maps[i]['barcodekind'];
      rn.barcode1 = maps[i]['barcode1'];
      rn.barcode2 = maps[i]['barcode2'];
      rn.barcode3 = maps[i]['barcode3'];
      rn.barcode4 = maps[i]['barcode4'];
      rn.receiptmsgno = maps[i]['receiptmsgno'];
      rn.comparestatus = maps[i]['comparestatus'];
      rn.name = maps[i]['name'];
      rn.tran_flg = maps[i]['tran_flg'];
      rn.sub_tran_flg = maps[i]['sub_tran_flg'];
      rn.receipt_flg = maps[i]['receipt_flg'];
      rn.matching_flg = maps[i]['matching_flg'];
      rn.check_flg = maps[i]['check_flg'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CPbchgLog01Columns rn = CPbchgLog01Columns();
    rn.serial_no = maps[0]['serial_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.date = maps[0]['date'];
    rn.time = maps[0]['time'];
    rn.groupcd = maps[0]['groupcd'];
    rn.officecd = maps[0]['officecd'];
    rn.strecd = maps[0]['strecd'];
    rn.termcd = maps[0]['termcd'];
    rn.dealseqno = maps[0]['dealseqno'];
    rn.servicekind = maps[0]['servicekind'];
    rn.serviceseqno = maps[0]['serviceseqno'];
    rn.settlestatus = maps[0]['settlestatus'];
    rn.settlekind = maps[0]['settlekind'];
    rn.cashamt = maps[0]['cashamt'];
    rn.charge1 = maps[0]['charge1'];
    rn.charge2 = maps[0]['charge2'];
    rn.dealererr = maps[0]['dealererr'];
    rn.receipterr = maps[0]['receipterr'];
    rn.validdate = maps[0]['validdate'];
    rn.barcodekind = maps[0]['barcodekind'];
    rn.barcode1 = maps[0]['barcode1'];
    rn.barcode2 = maps[0]['barcode2'];
    rn.barcode3 = maps[0]['barcode3'];
    rn.barcode4 = maps[0]['barcode4'];
    rn.receiptmsgno = maps[0]['receiptmsgno'];
    rn.comparestatus = maps[0]['comparestatus'];
    rn.name = maps[0]['name'];
    rn.tran_flg = maps[0]['tran_flg'];
    rn.sub_tran_flg = maps[0]['sub_tran_flg'];
    rn.receipt_flg = maps[0]['receipt_flg'];
    rn.matching_flg = maps[0]['matching_flg'];
    rn.check_flg = maps[0]['check_flg'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CPbchgLog01Field.serial_no : this.serial_no,
      CPbchgLog01Field.seq_no : this.seq_no,
      CPbchgLog01Field.comp_cd : this.comp_cd,
      CPbchgLog01Field.stre_cd : this.stre_cd,
      CPbchgLog01Field.mac_no : this.mac_no,
      CPbchgLog01Field.date : this.date,
      CPbchgLog01Field.time : this.time,
      CPbchgLog01Field.groupcd : this.groupcd,
      CPbchgLog01Field.officecd : this.officecd,
      CPbchgLog01Field.strecd : this.strecd,
      CPbchgLog01Field.termcd : this.termcd,
      CPbchgLog01Field.dealseqno : this.dealseqno,
      CPbchgLog01Field.servicekind : this.servicekind,
      CPbchgLog01Field.serviceseqno : this.serviceseqno,
      CPbchgLog01Field.settlestatus : this.settlestatus,
      CPbchgLog01Field.settlekind : this.settlekind,
      CPbchgLog01Field.cashamt : this.cashamt,
      CPbchgLog01Field.charge1 : this.charge1,
      CPbchgLog01Field.charge2 : this.charge2,
      CPbchgLog01Field.dealererr : this.dealererr,
      CPbchgLog01Field.receipterr : this.receipterr,
      CPbchgLog01Field.validdate : this.validdate,
      CPbchgLog01Field.barcodekind : this.barcodekind,
      CPbchgLog01Field.barcode1 : this.barcode1,
      CPbchgLog01Field.barcode2 : this.barcode2,
      CPbchgLog01Field.barcode3 : this.barcode3,
      CPbchgLog01Field.barcode4 : this.barcode4,
      CPbchgLog01Field.receiptmsgno : this.receiptmsgno,
      CPbchgLog01Field.comparestatus : this.comparestatus,
      CPbchgLog01Field.name : this.name,
      CPbchgLog01Field.tran_flg : this.tran_flg,
      CPbchgLog01Field.sub_tran_flg : this.sub_tran_flg,
      CPbchgLog01Field.receipt_flg : this.receipt_flg,
      CPbchgLog01Field.matching_flg : this.matching_flg,
      CPbchgLog01Field.check_flg : this.check_flg,
      CPbchgLog01Field.fil1 : this.fil1,
      CPbchgLog01Field.fil2 : this.fil2,
    };
  }
}

/// 公共料金_収納ログ01 c_pbchg_log_01のフィールド名設定用クラス
class CPbchgLog01Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const date = "date";
  static const time = "time";
  static const groupcd = "groupcd";
  static const officecd = "officecd";
  static const strecd = "strecd";
  static const termcd = "termcd";
  static const dealseqno = "dealseqno";
  static const servicekind = "servicekind";
  static const serviceseqno = "serviceseqno";
  static const settlestatus = "settlestatus";
  static const settlekind = "settlekind";
  static const cashamt = "cashamt";
  static const charge1 = "charge1";
  static const charge2 = "charge2";
  static const dealererr = "dealererr";
  static const receipterr = "receipterr";
  static const validdate = "validdate";
  static const barcodekind = "barcodekind";
  static const barcode1 = "barcode1";
  static const barcode2 = "barcode2";
  static const barcode3 = "barcode3";
  static const barcode4 = "barcode4";
  static const receiptmsgno = "receiptmsgno";
  static const comparestatus = "comparestatus";
  static const name = "name";
  static const tran_flg = "tran_flg";
  static const sub_tran_flg = "sub_tran_flg";
  static const receipt_flg = "receipt_flg";
  static const matching_flg = "matching_flg";
  static const check_flg = "check_flg";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
}
//endregion
//region 予約ログ01	c_reserv_log_01
/// 予約ログ01  c_reserv_log_01クラス
class CReservLog01Columns extends TableColumns{
  String? serial_no = '0';
  String? now_sale_datetime;
  String? void_serial_no = '0';
  String? cust_no;
  String? last_name;
  String? first_name;
  String? tel_no1;
  String? tel_no2;
  String? address1;
  String? address2;
  String? address3;
  String? recept_date;
  String? ferry_date;
  String? arrival_date;
  int? qty;
  int? ttl;
  int? advance_money;
  String? memo1;
  String? memo2;
  int? fil1;
  int? fil2;
  int? fil3;
  int? finish;
  int? tran_flg;
  int? sub_tran_flg;
  int? center_flg;
  int? update_flg;

  @override
  String _getTableName() => "c_reserv_log_01";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND now_sale_datetime = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(now_sale_datetime);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReservLog01Columns rn = CReservLog01Columns();
      rn.serial_no = maps[i]['serial_no'];
      rn.now_sale_datetime = maps[i]['now_sale_datetime'];
      rn.void_serial_no = maps[i]['void_serial_no'];
      rn.cust_no = maps[i]['cust_no'];
      rn.last_name = maps[i]['last_name'];
      rn.first_name = maps[i]['first_name'];
      rn.tel_no1 = maps[i]['tel_no1'];
      rn.tel_no2 = maps[i]['tel_no2'];
      rn.address1 = maps[i]['address1'];
      rn.address2 = maps[i]['address2'];
      rn.address3 = maps[i]['address3'];
      rn.recept_date = maps[i]['recept_date'];
      rn.ferry_date = maps[i]['ferry_date'];
      rn.arrival_date = maps[i]['arrival_date'];
      rn.qty = maps[i]['qty'];
      rn.ttl = maps[i]['ttl'];
      rn.advance_money = maps[i]['advance_money'];
      rn.memo1 = maps[i]['memo1'];
      rn.memo2 = maps[i]['memo2'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      rn.fil3 = maps[i]['fil3'];
      rn.finish = maps[i]['finish'];
      rn.tran_flg = maps[i]['tran_flg'];
      rn.sub_tran_flg = maps[i]['sub_tran_flg'];
      rn.center_flg = maps[i]['center_flg'];
      rn.update_flg = maps[i]['update_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReservLog01Columns rn = CReservLog01Columns();
    rn.serial_no = maps[0]['serial_no'];
    rn.now_sale_datetime = maps[0]['now_sale_datetime'];
    rn.void_serial_no = maps[0]['void_serial_no'];
    rn.cust_no = maps[0]['cust_no'];
    rn.last_name = maps[0]['last_name'];
    rn.first_name = maps[0]['first_name'];
    rn.tel_no1 = maps[0]['tel_no1'];
    rn.tel_no2 = maps[0]['tel_no2'];
    rn.address1 = maps[0]['address1'];
    rn.address2 = maps[0]['address2'];
    rn.address3 = maps[0]['address3'];
    rn.recept_date = maps[0]['recept_date'];
    rn.ferry_date = maps[0]['ferry_date'];
    rn.arrival_date = maps[0]['arrival_date'];
    rn.qty = maps[0]['qty'];
    rn.ttl = maps[0]['ttl'];
    rn.advance_money = maps[0]['advance_money'];
    rn.memo1 = maps[0]['memo1'];
    rn.memo2 = maps[0]['memo2'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    rn.fil3 = maps[0]['fil3'];
    rn.finish = maps[0]['finish'];
    rn.tran_flg = maps[0]['tran_flg'];
    rn.sub_tran_flg = maps[0]['sub_tran_flg'];
    rn.center_flg = maps[0]['center_flg'];
    rn.update_flg = maps[0]['update_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReservLog01Field.serial_no : this.serial_no,
      CReservLog01Field.now_sale_datetime : this.now_sale_datetime,
      CReservLog01Field.void_serial_no : this.void_serial_no,
      CReservLog01Field.cust_no : this.cust_no,
      CReservLog01Field.last_name : this.last_name,
      CReservLog01Field.first_name : this.first_name,
      CReservLog01Field.tel_no1 : this.tel_no1,
      CReservLog01Field.tel_no2 : this.tel_no2,
      CReservLog01Field.address1 : this.address1,
      CReservLog01Field.address2 : this.address2,
      CReservLog01Field.address3 : this.address3,
      CReservLog01Field.recept_date : this.recept_date,
      CReservLog01Field.ferry_date : this.ferry_date,
      CReservLog01Field.arrival_date : this.arrival_date,
      CReservLog01Field.qty : this.qty,
      CReservLog01Field.ttl : this.ttl,
      CReservLog01Field.advance_money : this.advance_money,
      CReservLog01Field.memo1 : this.memo1,
      CReservLog01Field.memo2 : this.memo2,
      CReservLog01Field.fil1 : this.fil1,
      CReservLog01Field.fil2 : this.fil2,
      CReservLog01Field.fil3 : this.fil3,
      CReservLog01Field.finish : this.finish,
      CReservLog01Field.tran_flg : this.tran_flg,
      CReservLog01Field.sub_tran_flg : this.sub_tran_flg,
      CReservLog01Field.center_flg : this.center_flg,
      CReservLog01Field.update_flg : this.update_flg,
    };
  }
}

/// 予約ログ01  c_reserv_log_01のフィールド名設定用クラス
class CReservLog01Field {
  static const serial_no = "serial_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const void_serial_no = "void_serial_no";
  static const cust_no = "cust_no";
  static const last_name = "last_name";
  static const first_name = "first_name";
  static const tel_no1 = "tel_no1";
  static const tel_no2 = "tel_no2";
  static const address1 = "address1";
  static const address2 = "address2";
  static const address3 = "address3";
  static const recept_date = "recept_date";
  static const ferry_date = "ferry_date";
  static const arrival_date = "arrival_date";
  static const qty = "qty";
  static const ttl = "ttl";
  static const advance_money = "advance_money";
  static const memo1 = "memo1";
  static const memo2 = "memo2";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
  static const fil3 = "fil3";
  static const finish = "finish";
  static const tran_flg = "tran_flg";
  static const sub_tran_flg = "sub_tran_flg";
  static const center_flg = "center_flg";
  static const update_flg = "update_flg";
}
//endregion
//region RM3800 フローティング用実績ヘッダログ	c_header_log_floating
/// RM3800 フローティング用実績ヘッダログ  c_header_log_floatingクラス
class CHeaderLogFloatingColumns extends TableColumns{
  String? serial_no;
  int comp_cd = 0;
  int stre_cd = 0;
  int mac_no = 0;
  int receipt_no = 0;
  int print_no = 0;
  int cshr_no = 0;
  int chkr_no = 0;
  String? cust_no;
  String? sale_date;
  String? starttime;
  String? endtime;
  int ope_mode_flg = 0;
  int inout_flg = 0;
  int prn_typ = 0;
  String? void_serial_no;
  String? qc_serial_no;
  int void_kind = 0;
  String? void_sale_date;
  int data_log_cnt = 0;
  int ej_log_cnt = 0;
  int status_log_cnt = 0;
  int tran_flg = 0;
  int sub_tran_flg = 0;
  int off_entry_flg = 0;
  int various_flg_1 = 0;
  int various_flg_2 = 0;
  int various_flg_3 = 0;
  int various_num_1 = 0;
  int various_num_2 = 0;
  int various_num_3 = 0;
  String? various_data;
  int various_flg_4 = 0;
  int various_flg_5 = 0;
  int various_flg_6 = 0;
  int various_flg_7 = 0;
  int various_flg_8 = 0;
  int various_flg_9 = 0;
  int various_flg_10 = 0;
  int various_flg_11 = 0;
  int various_flg_12 = 0;
  int various_flg_13 = 0;
  int reserv_flg = 0;
  int reserv_stre_cd = 0;
  int reserv_status = 0;
  int reserv_chg_cnt = 0;
  String? reserv_cd;
  String? lock_cd;

  @override
  String _getTableName() => "c_header_log_floating";

  @override
  String? _getKeyCondition() => 'serial_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CHeaderLogFloatingColumns rn = CHeaderLogFloatingColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.receipt_no = maps[i]['receipt_no'];
      rn.print_no = maps[i]['print_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cust_no = maps[i]['cust_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.starttime = maps[i]['starttime'];
      rn.endtime = maps[i]['endtime'];
      rn.ope_mode_flg = maps[i]['ope_mode_flg'];
      rn.inout_flg = maps[i]['inout_flg'];
      rn.prn_typ = maps[i]['prn_typ'];
      rn.void_serial_no = maps[i]['void_serial_no'];
      rn.qc_serial_no = maps[i]['qc_serial_no'];
      rn.void_kind = maps[i]['void_kind'];
      rn.void_sale_date = maps[i]['void_sale_date'];
      rn.data_log_cnt = maps[i]['data_log_cnt'];
      rn.ej_log_cnt = maps[i]['ej_log_cnt'];
      rn.status_log_cnt = maps[i]['status_log_cnt'];
      rn.tran_flg = maps[i]['tran_flg'];
      rn.sub_tran_flg = maps[i]['sub_tran_flg'];
      rn.off_entry_flg = maps[i]['off_entry_flg'];
      rn.various_flg_1 = maps[i]['various_flg_1'];
      rn.various_flg_2 = maps[i]['various_flg_2'];
      rn.various_flg_3 = maps[i]['various_flg_3'];
      rn.various_num_1 = maps[i]['various_num_1'];
      rn.various_num_2 = maps[i]['various_num_2'];
      rn.various_num_3 = maps[i]['various_num_3'];
      rn.various_data = maps[i]['various_data'];
      rn.various_flg_4 = maps[i]['various_flg_4'];
      rn.various_flg_5 = maps[i]['various_flg_5'];
      rn.various_flg_6 = maps[i]['various_flg_6'];
      rn.various_flg_7 = maps[i]['various_flg_7'];
      rn.various_flg_8 = maps[i]['various_flg_8'];
      rn.various_flg_9 = maps[i]['various_flg_9'];
      rn.various_flg_10 = maps[i]['various_flg_10'];
      rn.various_flg_11 = maps[i]['various_flg_11'];
      rn.various_flg_12 = maps[i]['various_flg_12'];
      rn.various_flg_13 = maps[i]['various_flg_13'];
      rn.reserv_flg = maps[i]['reserv_flg'];
      rn.reserv_stre_cd = maps[i]['reserv_stre_cd'];
      rn.reserv_status = maps[i]['reserv_status'];
      rn.reserv_chg_cnt = maps[i]['reserv_chg_cnt'];
      rn.reserv_cd = maps[i]['reserv_cd'];
      rn.lock_cd = maps[i]['lock_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CHeaderLogFloatingColumns rn = CHeaderLogFloatingColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.receipt_no = maps[0]['receipt_no'];
    rn.print_no = maps[0]['print_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cust_no = maps[0]['cust_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.starttime = maps[0]['starttime'];
    rn.endtime = maps[0]['endtime'];
    rn.ope_mode_flg = maps[0]['ope_mode_flg'];
    rn.inout_flg = maps[0]['inout_flg'];
    rn.prn_typ = maps[0]['prn_typ'];
    rn.void_serial_no = maps[0]['void_serial_no'];
    rn.qc_serial_no = maps[0]['qc_serial_no'];
    rn.void_kind = maps[0]['void_kind'];
    rn.void_sale_date = maps[0]['void_sale_date'];
    rn.data_log_cnt = maps[0]['data_log_cnt'];
    rn.ej_log_cnt = maps[0]['ej_log_cnt'];
    rn.status_log_cnt = maps[0]['status_log_cnt'];
    rn.tran_flg = maps[0]['tran_flg'];
    rn.sub_tran_flg = maps[0]['sub_tran_flg'];
    rn.off_entry_flg = maps[0]['off_entry_flg'];
    rn.various_flg_1 = maps[0]['various_flg_1'];
    rn.various_flg_2 = maps[0]['various_flg_2'];
    rn.various_flg_3 = maps[0]['various_flg_3'];
    rn.various_num_1 = maps[0]['various_num_1'];
    rn.various_num_2 = maps[0]['various_num_2'];
    rn.various_num_3 = maps[0]['various_num_3'];
    rn.various_data = maps[0]['various_data'];
    rn.various_flg_4 = maps[0]['various_flg_4'];
    rn.various_flg_5 = maps[0]['various_flg_5'];
    rn.various_flg_6 = maps[0]['various_flg_6'];
    rn.various_flg_7 = maps[0]['various_flg_7'];
    rn.various_flg_8 = maps[0]['various_flg_8'];
    rn.various_flg_9 = maps[0]['various_flg_9'];
    rn.various_flg_10 = maps[0]['various_flg_10'];
    rn.various_flg_11 = maps[0]['various_flg_11'];
    rn.various_flg_12 = maps[0]['various_flg_12'];
    rn.various_flg_13 = maps[0]['various_flg_13'];
    rn.reserv_flg = maps[0]['reserv_flg'];
    rn.reserv_stre_cd = maps[0]['reserv_stre_cd'];
    rn.reserv_status = maps[0]['reserv_status'];
    rn.reserv_chg_cnt = maps[0]['reserv_chg_cnt'];
    rn.reserv_cd = maps[0]['reserv_cd'];
    rn.lock_cd = maps[0]['lock_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
    CHeaderLogFloatingField.serial_no : this.serial_no,
    CHeaderLogFloatingField.comp_cd : this.comp_cd,
    CHeaderLogFloatingField.stre_cd : this.stre_cd,
    CHeaderLogFloatingField.mac_no : this.mac_no,
    CHeaderLogFloatingField.receipt_no : this.receipt_no,
    CHeaderLogFloatingField.print_no : this.print_no,
    CHeaderLogFloatingField.cshr_no : this.cshr_no,
    CHeaderLogFloatingField.chkr_no : this.chkr_no,
    CHeaderLogFloatingField.cust_no : this.cust_no,
    CHeaderLogFloatingField.sale_date : this.sale_date,
    CHeaderLogFloatingField.starttime : this.starttime,
    CHeaderLogFloatingField.endtime : this.endtime,
    CHeaderLogFloatingField.ope_mode_flg : this.ope_mode_flg,
    CHeaderLogFloatingField.inout_flg : this.inout_flg,
    CHeaderLogFloatingField.prn_typ : this.prn_typ,
    CHeaderLogFloatingField.void_serial_no : this.void_serial_no,
    CHeaderLogFloatingField.qc_serial_no : this.qc_serial_no,
    CHeaderLogFloatingField.void_kind : this.void_kind,
    CHeaderLogFloatingField.void_sale_date : this.void_sale_date,
    CHeaderLogFloatingField.data_log_cnt : this.data_log_cnt,
    CHeaderLogFloatingField.ej_log_cnt : this.ej_log_cnt,
    CHeaderLogFloatingField.status_log_cnt : this.status_log_cnt,
    CHeaderLogFloatingField.tran_flg : this.tran_flg,
    CHeaderLogFloatingField.sub_tran_flg : this.sub_tran_flg,
    CHeaderLogFloatingField.off_entry_flg : this.off_entry_flg,
    CHeaderLogFloatingField.various_flg_1 : this.various_flg_1,
    CHeaderLogFloatingField.various_flg_2 : this.various_flg_2,
    CHeaderLogFloatingField.various_flg_3 : this.various_flg_3,
    CHeaderLogFloatingField.various_num_1 : this.various_num_1,
    CHeaderLogFloatingField.various_num_2 : this.various_num_2,
    CHeaderLogFloatingField.various_num_3 : this.various_num_3,
    CHeaderLogFloatingField.various_data : this.various_data,
    CHeaderLogFloatingField.various_flg_4 : this.various_flg_4,
    CHeaderLogFloatingField.various_flg_5 : this.various_flg_5,
    CHeaderLogFloatingField.various_flg_6 : this.various_flg_6,
    CHeaderLogFloatingField.various_flg_7 : this.various_flg_7,
    CHeaderLogFloatingField.various_flg_8 : this.various_flg_8,
    CHeaderLogFloatingField.various_flg_9 : this.various_flg_9,
    CHeaderLogFloatingField.various_flg_10 : this.various_flg_10,
    CHeaderLogFloatingField.various_flg_11 : this.various_flg_11,
    CHeaderLogFloatingField.various_flg_12 : this.various_flg_12,
    CHeaderLogFloatingField.various_flg_13 : this.various_flg_13,
    CHeaderLogFloatingField.reserv_flg : this.reserv_flg,
    CHeaderLogFloatingField.reserv_stre_cd : this.reserv_stre_cd,
    CHeaderLogFloatingField.reserv_status : this.reserv_status,
    CHeaderLogFloatingField.reserv_chg_cnt : this.reserv_chg_cnt,
    CHeaderLogFloatingField.reserv_cd : this.reserv_cd,
    CHeaderLogFloatingField.lock_cd : this.lock_cd,
  };
  }
}

/// RM3800 フローティング用実績ヘッダログ  c_header_log_floatingのフィールド名設定用クラス
class CHeaderLogFloatingField {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const receipt_no = "receipt_no";
  static const print_no = "print_no";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const cust_no = "cust_no";
  static const sale_date = "sale_date";
  static const starttime = "starttime";
  static const endtime = "endtime";
  static const ope_mode_flg = "ope_mode_flg";
  static const inout_flg = "inout_flg";
  static const prn_typ = "prn_typ";
  static const void_serial_no = "void_serial_no";
  static const qc_serial_no = "qc_serial_no";
  static const void_kind = "void_kind";
  static const void_sale_date = "void_sale_date";
  static const data_log_cnt = "data_log_cnt";
  static const ej_log_cnt = "ej_log_cnt";
  static const status_log_cnt = "status_log_cnt";
  static const tran_flg = "tran_flg";
  static const sub_tran_flg = "sub_tran_flg";
  static const off_entry_flg = "off_entry_flg";
  static const various_flg_1 = "various_flg_1";
  static const various_flg_2 = "various_flg_2";
  static const various_flg_3 = "various_flg_3";
  static const various_num_1 = "various_num_1";
  static const various_num_2 = "various_num_2";
  static const various_num_3 = "various_num_3";
  static const various_data = "various_data";
  static const various_flg_4 = "various_flg_4";
  static const various_flg_5 = "various_flg_5";
  static const various_flg_6 = "various_flg_6";
  static const various_flg_7 = "various_flg_7";
  static const various_flg_8 = "various_flg_8";
  static const various_flg_9 = "various_flg_9";
  static const various_flg_10 = "various_flg_10";
  static const various_flg_11 = "various_flg_11";
  static const various_flg_12 = "various_flg_12";
  static const various_flg_13 = "various_flg_13";
  static const reserv_flg = "reserv_flg";
  static const reserv_stre_cd = "reserv_stre_cd";
  static const reserv_status = "reserv_status";
  static const reserv_chg_cnt = "reserv_chg_cnt";
  static const reserv_cd = "reserv_cd";
  static const lock_cd = "lock_cd";
}
//endregion
//region RM3800 フローティング用実績データログ	c_data_log_floating
/// RM3800 フローティング用実績データログ  c_data_log_floatingクラス
class CDataLogFloatingColumns extends TableColumns{
  String? serial_no;
  int seq_no = 0;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? c_data1;
  String? c_data2;
  String? c_data3;
  String? c_data4;
  String? c_data5;
  String? c_data6;
  String? c_data7;
  String? c_data8;
  String? c_data9;
  String? c_data10;
  double? n_data1 = 0;
  double? n_data2 = 0;
  double? n_data3 = 0;
  double? n_data4 = 0;
  double? n_data5 = 0;
  double? n_data6 = 0;
  double? n_data7 = 0;
  double? n_data8 = 0;
  double? n_data9 = 0;
  double? n_data10 = 0;
  double? n_data11 = 0;
  double? n_data12 = 0;
  double? n_data13 = 0;
  double? n_data14 = 0;
  double? n_data15 = 0;
  double? n_data16 = 0;
  double? n_data17 = 0;
  double? n_data18 = 0;
  double? n_data19 = 0;
  double? n_data20 = 0;
  double? n_data21 = 0;
  double? n_data22 = 0;
  double? n_data23 = 0;
  double? n_data24 = 0;
  double? n_data25 = 0;
  double? n_data26 = 0;
  double? n_data27 = 0;
  double? n_data28 = 0;
  double? n_data29 = 0;
  double? n_data30 = 0;
  String? d_data1;
  String? d_data2;
  String? d_data3;
  String? d_data4;
  String? d_data5;

  @override
  String _getTableName() => "c_data_log_floating";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CDataLogFloatingColumns rn = CDataLogFloatingColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.cnct_seq_no = maps[i]['cnct_seq_no'];
      rn.func_cd = maps[i]['func_cd'];
      rn.func_seq_no = maps[i]['func_seq_no'];
      rn.c_data1 = maps[i]['c_data1'];
      rn.c_data2 = maps[i]['c_data2'];
      rn.c_data3 = maps[i]['c_data3'];
      rn.c_data4 = maps[i]['c_data4'];
      rn.c_data5 = maps[i]['c_data5'];
      rn.c_data6 = maps[i]['c_data6'];
      rn.c_data7 = maps[i]['c_data7'];
      rn.c_data8 = maps[i]['c_data8'];
      rn.c_data9 = maps[i]['c_data9'];
      rn.c_data10 = maps[i]['c_data10'];
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
      rn.n_data17 = maps[i]['n_data17'];
      rn.n_data18 = maps[i]['n_data18'];
      rn.n_data19 = maps[i]['n_data19'];
      rn.n_data20 = maps[i]['n_data20'];
      rn.n_data21 = maps[i]['n_data21'];
      rn.n_data22 = maps[i]['n_data22'];
      rn.n_data23 = maps[i]['n_data23'];
      rn.n_data24 = maps[i]['n_data24'];
      rn.n_data25 = maps[i]['n_data25'];
      rn.n_data26 = maps[i]['n_data26'];
      rn.n_data27 = maps[i]['n_data27'];
      rn.n_data28 = maps[i]['n_data28'];
      rn.n_data29 = maps[i]['n_data29'];
      rn.n_data30 = maps[i]['n_data30'];
      rn.d_data1 = maps[i]['d_data1'];
      rn.d_data2 = maps[i]['d_data2'];
      rn.d_data3 = maps[i]['d_data3'];
      rn.d_data4 = maps[i]['d_data4'];
      rn.d_data5 = maps[i]['d_data5'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CDataLogFloatingColumns rn = CDataLogFloatingColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.cnct_seq_no = maps[0]['cnct_seq_no'];
    rn.func_cd = maps[0]['func_cd'];
    rn.func_seq_no = maps[0]['func_seq_no'];
    rn.c_data1 = maps[0]['c_data1'];
    rn.c_data2 = maps[0]['c_data2'];
    rn.c_data3 = maps[0]['c_data3'];
    rn.c_data4 = maps[0]['c_data4'];
    rn.c_data5 = maps[0]['c_data5'];
    rn.c_data6 = maps[0]['c_data6'];
    rn.c_data7 = maps[0]['c_data7'];
    rn.c_data8 = maps[0]['c_data8'];
    rn.c_data9 = maps[0]['c_data9'];
    rn.c_data10 = maps[0]['c_data10'];
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
    rn.n_data17 = maps[0]['n_data17'];
    rn.n_data18 = maps[0]['n_data18'];
    rn.n_data19 = maps[0]['n_data19'];
    rn.n_data20 = maps[0]['n_data20'];
    rn.n_data21 = maps[0]['n_data21'];
    rn.n_data22 = maps[0]['n_data22'];
    rn.n_data23 = maps[0]['n_data23'];
    rn.n_data24 = maps[0]['n_data24'];
    rn.n_data25 = maps[0]['n_data25'];
    rn.n_data26 = maps[0]['n_data26'];
    rn.n_data27 = maps[0]['n_data27'];
    rn.n_data28 = maps[0]['n_data28'];
    rn.n_data29 = maps[0]['n_data29'];
    rn.n_data30 = maps[0]['n_data30'];
    rn.d_data1 = maps[0]['d_data1'];
    rn.d_data2 = maps[0]['d_data2'];
    rn.d_data3 = maps[0]['d_data3'];
    rn.d_data4 = maps[0]['d_data4'];
    rn.d_data5 = maps[0]['d_data5'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
    CDataLogFloatingField.serial_no : this.serial_no,
    CDataLogFloatingField.seq_no : this.seq_no,
    CDataLogFloatingField.cnct_seq_no : this.cnct_seq_no,
    CDataLogFloatingField.func_cd : this.func_cd,
    CDataLogFloatingField.func_seq_no : this.func_seq_no,
    CDataLogFloatingField.c_data1 : this.c_data1,
    CDataLogFloatingField.c_data2 : this.c_data2,
    CDataLogFloatingField.c_data3 : this.c_data3,
    CDataLogFloatingField.c_data4 : this.c_data4,
    CDataLogFloatingField.c_data5 : this.c_data5,
    CDataLogFloatingField.c_data6 : this.c_data6,
    CDataLogFloatingField.c_data7 : this.c_data7,
    CDataLogFloatingField.c_data8 : this.c_data8,
    CDataLogFloatingField.c_data9 : this.c_data9,
    CDataLogFloatingField.c_data10 : this.c_data10,
    CDataLogFloatingField.n_data1 : this.n_data1,
    CDataLogFloatingField.n_data2 : this.n_data2,
    CDataLogFloatingField.n_data3 : this.n_data3,
    CDataLogFloatingField.n_data4 : this.n_data4,
    CDataLogFloatingField.n_data5 : this.n_data5,
    CDataLogFloatingField.n_data6 : this.n_data6,
    CDataLogFloatingField.n_data7 : this.n_data7,
    CDataLogFloatingField.n_data8 : this.n_data8,
    CDataLogFloatingField.n_data9 : this.n_data9,
    CDataLogFloatingField.n_data10 : this.n_data10,
    CDataLogFloatingField.n_data11 : this.n_data11,
    CDataLogFloatingField.n_data12 : this.n_data12,
    CDataLogFloatingField.n_data13 : this.n_data13,
    CDataLogFloatingField.n_data14 : this.n_data14,
    CDataLogFloatingField.n_data15 : this.n_data15,
    CDataLogFloatingField.n_data16 : this.n_data16,
    CDataLogFloatingField.n_data17 : this.n_data17,
    CDataLogFloatingField.n_data18 : this.n_data18,
    CDataLogFloatingField.n_data19 : this.n_data19,
    CDataLogFloatingField.n_data20 : this.n_data20,
    CDataLogFloatingField.n_data21 : this.n_data21,
    CDataLogFloatingField.n_data22 : this.n_data22,
    CDataLogFloatingField.n_data23 : this.n_data23,
    CDataLogFloatingField.n_data24 : this.n_data24,
    CDataLogFloatingField.n_data25 : this.n_data25,
    CDataLogFloatingField.n_data26 : this.n_data26,
    CDataLogFloatingField.n_data27 : this.n_data27,
    CDataLogFloatingField.n_data28 : this.n_data28,
    CDataLogFloatingField.n_data29 : this.n_data29,
    CDataLogFloatingField.n_data30 : this.n_data30,
    CDataLogFloatingField.d_data1 : this.d_data1,
    CDataLogFloatingField.d_data2 : this.d_data2,
    CDataLogFloatingField.d_data3 : this.d_data3,
    CDataLogFloatingField.d_data4 : this.d_data4,
    CDataLogFloatingField.d_data5 : this.d_data5,
  };
  }
}

/// RM3800 フローティング用実績データログ  c_data_log_floatingのフィールド名設定用クラス
class CDataLogFloatingField {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const c_data1 = "c_data1";
  static const c_data2 = "c_data2";
  static const c_data3 = "c_data3";
  static const c_data4 = "c_data4";
  static const c_data5 = "c_data5";
  static const c_data6 = "c_data6";
  static const c_data7 = "c_data7";
  static const c_data8 = "c_data8";
  static const c_data9 = "c_data9";
  static const c_data10 = "c_data10";
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
  static const n_data17 = "n_data17";
  static const n_data18 = "n_data18";
  static const n_data19 = "n_data19";
  static const n_data20 = "n_data20";
  static const n_data21 = "n_data21";
  static const n_data22 = "n_data22";
  static const n_data23 = "n_data23";
  static const n_data24 = "n_data24";
  static const n_data25 = "n_data25";
  static const n_data26 = "n_data26";
  static const n_data27 = "n_data27";
  static const n_data28 = "n_data28";
  static const n_data29 = "n_data29";
  static const n_data30 = "n_data30";
  static const d_data1 = "d_data1";
  static const d_data2 = "d_data2";
  static const d_data3 = "d_data3";
  static const d_data4 = "d_data4";
  static const d_data5 = "d_data5";
}
//endregion
//region RM3800 フローティング用実績ステータスログ c_status_log_floating
/// RM3800 フローティング用実績ステータスログ c_status_log_floatingクラス
class CStatusLogFloatingColumns extends TableColumns{
  String? serial_no;
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_floating";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStatusLogFloatingColumns rn = CStatusLogFloatingColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.cnct_seq_no = maps[i]['cnct_seq_no'];
      rn.func_cd = maps[i]['func_cd'];
      rn.func_seq_no = maps[i]['func_seq_no'];
      rn.status_data = maps[i]['status_data'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CStatusLogFloatingColumns rn = CStatusLogFloatingColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.cnct_seq_no = maps[0]['cnct_seq_no'];
    rn.func_cd = maps[0]['func_cd'];
    rn.func_seq_no = maps[0]['func_seq_no'];
    rn.status_data = maps[0]['status_data'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
    CStatusLogFloatingField.serial_no : this.serial_no,
    CStatusLogFloatingField.seq_no : this.seq_no,
    CStatusLogFloatingField.cnct_seq_no : this.cnct_seq_no,
    CStatusLogFloatingField.func_cd : this.func_cd,
    CStatusLogFloatingField.func_seq_no : this.func_seq_no,
    CStatusLogFloatingField.status_data : this.status_data,
  };
  }
}

/// RM3800 フローティング用実績ステータスログ c_status_log_floatingのフィールド名設定用クラス
class CStatusLogFloatingField {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region ハイタッチ受信ログ c_hitouch_rcv_log
/// ハイタッチ受信ログ c_hitouch_rcv_logクラス
class CHitouchRcvLogColumns extends TableColumns{
  String? rcv_datetime;
  String? tag_id;
  String? plu_cd;
  int upd_flg = 0;

  @override
  String _getTableName() => "c_hitouch_rcv_log";

  @override
  String? _getKeyCondition() => 'rcv_datetime = ? AND tag_id = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(rcv_datetime);
    rn.add(tag_id);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CHitouchRcvLogColumns rn = CHitouchRcvLogColumns();
      rn.rcv_datetime = maps[i]['rcv_datetime'];
      rn.tag_id = maps[i]['tag_id'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.upd_flg = maps[i]['upd_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CHitouchRcvLogColumns rn = CHitouchRcvLogColumns();
    rn.rcv_datetime = maps[0]['rcv_datetime'];
    rn.tag_id = maps[0]['tag_id'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.upd_flg = maps[0]['upd_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
    CHitouchRcvLogField.rcv_datetime : this.rcv_datetime,
    CHitouchRcvLogField.tag_id : this.tag_id,
    CHitouchRcvLogField.plu_cd : this.plu_cd,
    CHitouchRcvLogField.upd_flg : this.upd_flg,
  };
  }
}

/// ハイタッチ受信ログ c_hitouch_rcv_logのフィールド名設定用クラス
class CHitouchRcvLogField {
  static const rcv_datetime = "rcv_datetime";
  static const tag_id = "tag_id";
  static const plu_cd = "plu_cd";
  static const upd_flg = "upd_flg";
}
//endregion
