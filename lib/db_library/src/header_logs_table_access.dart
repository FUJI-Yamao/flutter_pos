/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
実績ヘッダログ 日付別
c_header_log_01	実績ヘッダログ01
c_header_log_02	実績ヘッダログ02
c_header_log_03	実績ヘッダログ03
c_header_log_04	実績ヘッダログ04
c_header_log_05	実績ヘッダログ05
c_header_log_06	実績ヘッダログ06
c_header_log_07	実績ヘッダログ07
c_header_log_08	実績ヘッダログ08
c_header_log_09	実績ヘッダログ09
c_header_log_10	実績ヘッダログ10
c_header_log_11	実績ヘッダログ11
c_header_log_12	実績ヘッダログ12
c_header_log_13	実績ヘッダログ13
c_header_log_14	実績ヘッダログ14
c_header_log_15	実績ヘッダログ15
c_header_log_16	実績ヘッダログ16
c_header_log_17	実績ヘッダログ17
c_header_log_18	実績ヘッダログ18
c_header_log_19	実績ヘッダログ19
c_header_log_20	実績ヘッダログ20
c_header_log_21	実績ヘッダログ21
c_header_log_22	実績ヘッダログ22
c_header_log_23	実績ヘッダログ23
c_header_log_24	実績ヘッダログ24
c_header_log_25	実績ヘッダログ25
c_header_log_26	実績ヘッダログ26
c_header_log_27	実績ヘッダログ27
c_header_log_28	実績ヘッダログ28
c_header_log_29	実績ヘッダログ29
c_header_log_30	実績ヘッダログ30
c_header_log_31	実績ヘッダログ31
c_header_log_reserv	実績ヘッダログ予約
c_header_log_reserv_01	実績ヘッダログ予約01
 */

//region c_header_log_01  実績ヘッダログ01
/// c_header_log_01 実績ヘッダログ01クラス
class CHeaderLog01Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_01";

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
      CHeaderLog01Columns rn = CHeaderLog01Columns();
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
    CHeaderLog01Columns rn = CHeaderLog01Columns();
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
      CHeaderLog01Field.serial_no : this.serial_no,
      CHeaderLog01Field.comp_cd : this.comp_cd,
      CHeaderLog01Field.stre_cd : this.stre_cd,
      CHeaderLog01Field.mac_no : this.mac_no,
      CHeaderLog01Field.receipt_no : this.receipt_no,
      CHeaderLog01Field.print_no : this.print_no,
      CHeaderLog01Field.cshr_no : this.cshr_no,
      CHeaderLog01Field.chkr_no : this.chkr_no,
      CHeaderLog01Field.cust_no : this.cust_no,
      CHeaderLog01Field.sale_date : this.sale_date,
      CHeaderLog01Field.starttime : this.starttime,
      CHeaderLog01Field.endtime : this.endtime,
      CHeaderLog01Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog01Field.inout_flg : this.inout_flg,
      CHeaderLog01Field.prn_typ : this.prn_typ,
      CHeaderLog01Field.void_serial_no : this.void_serial_no,
      CHeaderLog01Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog01Field.void_kind : this.void_kind,
      CHeaderLog01Field.void_sale_date : this.void_sale_date,
      CHeaderLog01Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog01Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog01Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog01Field.tran_flg : this.tran_flg,
      CHeaderLog01Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog01Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog01Field.various_flg_1 : this.various_flg_1,
      CHeaderLog01Field.various_flg_2 : this.various_flg_2,
      CHeaderLog01Field.various_flg_3 : this.various_flg_3,
      CHeaderLog01Field.various_num_1 : this.various_num_1,
      CHeaderLog01Field.various_num_2 : this.various_num_2,
      CHeaderLog01Field.various_num_3 : this.various_num_3,
      CHeaderLog01Field.various_data : this.various_data,
      CHeaderLog01Field.various_flg_4 : this.various_flg_4,
      CHeaderLog01Field.various_flg_5 : this.various_flg_5,
      CHeaderLog01Field.various_flg_6 : this.various_flg_6,
      CHeaderLog01Field.various_flg_7 : this.various_flg_7,
      CHeaderLog01Field.various_flg_8 : this.various_flg_8,
      CHeaderLog01Field.various_flg_9 : this.various_flg_9,
      CHeaderLog01Field.various_flg_10 : this.various_flg_10,
      CHeaderLog01Field.various_flg_11 : this.various_flg_11,
      CHeaderLog01Field.various_flg_12 : this.various_flg_12,
      CHeaderLog01Field.various_flg_13 : this.various_flg_13,
      CHeaderLog01Field.reserv_flg : this.reserv_flg,
      CHeaderLog01Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog01Field.reserv_status : this.reserv_status,
      CHeaderLog01Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog01Field.reserv_cd : this.reserv_cd,
      CHeaderLog01Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_01 実績ヘッダログ01のフィールド名設定用クラス
class CHeaderLog01Field {
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
//region c_header_log_02  実績ヘッダログ02
/// c_header_log_02 実績ヘッダログ02クラス
class CHeaderLog02Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_02";

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
      CHeaderLog02Columns rn = CHeaderLog02Columns();
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
    CHeaderLog02Columns rn = CHeaderLog02Columns();
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
      CHeaderLog02Field.serial_no : this.serial_no,
      CHeaderLog02Field.comp_cd : this.comp_cd,
      CHeaderLog02Field.stre_cd : this.stre_cd,
      CHeaderLog02Field.mac_no : this.mac_no,
      CHeaderLog02Field.receipt_no : this.receipt_no,
      CHeaderLog02Field.print_no : this.print_no,
      CHeaderLog02Field.cshr_no : this.cshr_no,
      CHeaderLog02Field.chkr_no : this.chkr_no,
      CHeaderLog02Field.cust_no : this.cust_no,
      CHeaderLog02Field.sale_date : this.sale_date,
      CHeaderLog02Field.starttime : this.starttime,
      CHeaderLog02Field.endtime : this.endtime,
      CHeaderLog02Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog02Field.inout_flg : this.inout_flg,
      CHeaderLog02Field.prn_typ : this.prn_typ,
      CHeaderLog02Field.void_serial_no : this.void_serial_no,
      CHeaderLog02Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog02Field.void_kind : this.void_kind,
      CHeaderLog02Field.void_sale_date : this.void_sale_date,
      CHeaderLog02Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog02Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog02Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog02Field.tran_flg : this.tran_flg,
      CHeaderLog02Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog02Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog02Field.various_flg_1 : this.various_flg_1,
      CHeaderLog02Field.various_flg_2 : this.various_flg_2,
      CHeaderLog02Field.various_flg_3 : this.various_flg_3,
      CHeaderLog02Field.various_num_1 : this.various_num_1,
      CHeaderLog02Field.various_num_2 : this.various_num_2,
      CHeaderLog02Field.various_num_3 : this.various_num_3,
      CHeaderLog02Field.various_data : this.various_data,
      CHeaderLog02Field.various_flg_4 : this.various_flg_4,
      CHeaderLog02Field.various_flg_5 : this.various_flg_5,
      CHeaderLog02Field.various_flg_6 : this.various_flg_6,
      CHeaderLog02Field.various_flg_7 : this.various_flg_7,
      CHeaderLog02Field.various_flg_8 : this.various_flg_8,
      CHeaderLog02Field.various_flg_9 : this.various_flg_9,
      CHeaderLog02Field.various_flg_10 : this.various_flg_10,
      CHeaderLog02Field.various_flg_11 : this.various_flg_11,
      CHeaderLog02Field.various_flg_12 : this.various_flg_12,
      CHeaderLog02Field.various_flg_13 : this.various_flg_13,
      CHeaderLog02Field.reserv_flg : this.reserv_flg,
      CHeaderLog02Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog02Field.reserv_status : this.reserv_status,
      CHeaderLog02Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog02Field.reserv_cd : this.reserv_cd,
      CHeaderLog02Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_02 実績ヘッダログ02のフィールド名設定用クラス
class CHeaderLog02Field {
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
//region c_header_log_03  実績ヘッダログ03
/// c_header_log_03 実績ヘッダログ03クラス
class CHeaderLog03Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_03";

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
      CHeaderLog03Columns rn = CHeaderLog03Columns();
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
    CHeaderLog03Columns rn = CHeaderLog03Columns();
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
      CHeaderLog03Field.serial_no : this.serial_no,
      CHeaderLog03Field.comp_cd : this.comp_cd,
      CHeaderLog03Field.stre_cd : this.stre_cd,
      CHeaderLog03Field.mac_no : this.mac_no,
      CHeaderLog03Field.receipt_no : this.receipt_no,
      CHeaderLog03Field.print_no : this.print_no,
      CHeaderLog03Field.cshr_no : this.cshr_no,
      CHeaderLog03Field.chkr_no : this.chkr_no,
      CHeaderLog03Field.cust_no : this.cust_no,
      CHeaderLog03Field.sale_date : this.sale_date,
      CHeaderLog03Field.starttime : this.starttime,
      CHeaderLog03Field.endtime : this.endtime,
      CHeaderLog03Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog03Field.inout_flg : this.inout_flg,
      CHeaderLog03Field.prn_typ : this.prn_typ,
      CHeaderLog03Field.void_serial_no : this.void_serial_no,
      CHeaderLog03Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog03Field.void_kind : this.void_kind,
      CHeaderLog03Field.void_sale_date : this.void_sale_date,
      CHeaderLog03Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog03Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog03Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog03Field.tran_flg : this.tran_flg,
      CHeaderLog03Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog03Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog03Field.various_flg_1 : this.various_flg_1,
      CHeaderLog03Field.various_flg_2 : this.various_flg_2,
      CHeaderLog03Field.various_flg_3 : this.various_flg_3,
      CHeaderLog03Field.various_num_1 : this.various_num_1,
      CHeaderLog03Field.various_num_2 : this.various_num_2,
      CHeaderLog03Field.various_num_3 : this.various_num_3,
      CHeaderLog03Field.various_data : this.various_data,
      CHeaderLog03Field.various_flg_4 : this.various_flg_4,
      CHeaderLog03Field.various_flg_5 : this.various_flg_5,
      CHeaderLog03Field.various_flg_6 : this.various_flg_6,
      CHeaderLog03Field.various_flg_7 : this.various_flg_7,
      CHeaderLog03Field.various_flg_8 : this.various_flg_8,
      CHeaderLog03Field.various_flg_9 : this.various_flg_9,
      CHeaderLog03Field.various_flg_10 : this.various_flg_10,
      CHeaderLog03Field.various_flg_11 : this.various_flg_11,
      CHeaderLog03Field.various_flg_12 : this.various_flg_12,
      CHeaderLog03Field.various_flg_13 : this.various_flg_13,
      CHeaderLog03Field.reserv_flg : this.reserv_flg,
      CHeaderLog03Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog03Field.reserv_status : this.reserv_status,
      CHeaderLog03Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog03Field.reserv_cd : this.reserv_cd,
      CHeaderLog03Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_03 実績ヘッダログ03のフィールド名設定用クラス
class CHeaderLog03Field {
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
//region c_header_log_04  実績ヘッダログ04
/// c_header_log_04 実績ヘッダログ04クラス
class CHeaderLog04Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_04";

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
      CHeaderLog04Columns rn = CHeaderLog04Columns();
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
    CHeaderLog04Columns rn = CHeaderLog04Columns();
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
      CHeaderLog04Field.serial_no : this.serial_no,
      CHeaderLog04Field.comp_cd : this.comp_cd,
      CHeaderLog04Field.stre_cd : this.stre_cd,
      CHeaderLog04Field.mac_no : this.mac_no,
      CHeaderLog04Field.receipt_no : this.receipt_no,
      CHeaderLog04Field.print_no : this.print_no,
      CHeaderLog04Field.cshr_no : this.cshr_no,
      CHeaderLog04Field.chkr_no : this.chkr_no,
      CHeaderLog04Field.cust_no : this.cust_no,
      CHeaderLog04Field.sale_date : this.sale_date,
      CHeaderLog04Field.starttime : this.starttime,
      CHeaderLog04Field.endtime : this.endtime,
      CHeaderLog04Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog04Field.inout_flg : this.inout_flg,
      CHeaderLog04Field.prn_typ : this.prn_typ,
      CHeaderLog04Field.void_serial_no : this.void_serial_no,
      CHeaderLog04Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog04Field.void_kind : this.void_kind,
      CHeaderLog04Field.void_sale_date : this.void_sale_date,
      CHeaderLog04Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog04Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog04Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog04Field.tran_flg : this.tran_flg,
      CHeaderLog04Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog04Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog04Field.various_flg_1 : this.various_flg_1,
      CHeaderLog04Field.various_flg_2 : this.various_flg_2,
      CHeaderLog04Field.various_flg_3 : this.various_flg_3,
      CHeaderLog04Field.various_num_1 : this.various_num_1,
      CHeaderLog04Field.various_num_2 : this.various_num_2,
      CHeaderLog04Field.various_num_3 : this.various_num_3,
      CHeaderLog04Field.various_data : this.various_data,
      CHeaderLog04Field.various_flg_4 : this.various_flg_4,
      CHeaderLog04Field.various_flg_5 : this.various_flg_5,
      CHeaderLog04Field.various_flg_6 : this.various_flg_6,
      CHeaderLog04Field.various_flg_7 : this.various_flg_7,
      CHeaderLog04Field.various_flg_8 : this.various_flg_8,
      CHeaderLog04Field.various_flg_9 : this.various_flg_9,
      CHeaderLog04Field.various_flg_10 : this.various_flg_10,
      CHeaderLog04Field.various_flg_11 : this.various_flg_11,
      CHeaderLog04Field.various_flg_12 : this.various_flg_12,
      CHeaderLog04Field.various_flg_13 : this.various_flg_13,
      CHeaderLog04Field.reserv_flg : this.reserv_flg,
      CHeaderLog04Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog04Field.reserv_status : this.reserv_status,
      CHeaderLog04Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog04Field.reserv_cd : this.reserv_cd,
      CHeaderLog04Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_04 実績ヘッダログ04のフィールド名設定用クラス
class CHeaderLog04Field {
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
//region c_header_log_05  実績ヘッダログ05
/// c_header_log_05 実績ヘッダログ05クラス
class CHeaderLog05Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_05";

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
      CHeaderLog05Columns rn = CHeaderLog05Columns();
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
    CHeaderLog05Columns rn = CHeaderLog05Columns();
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
      CHeaderLog05Field.serial_no : this.serial_no,
      CHeaderLog05Field.comp_cd : this.comp_cd,
      CHeaderLog05Field.stre_cd : this.stre_cd,
      CHeaderLog05Field.mac_no : this.mac_no,
      CHeaderLog05Field.receipt_no : this.receipt_no,
      CHeaderLog05Field.print_no : this.print_no,
      CHeaderLog05Field.cshr_no : this.cshr_no,
      CHeaderLog05Field.chkr_no : this.chkr_no,
      CHeaderLog05Field.cust_no : this.cust_no,
      CHeaderLog05Field.sale_date : this.sale_date,
      CHeaderLog05Field.starttime : this.starttime,
      CHeaderLog05Field.endtime : this.endtime,
      CHeaderLog05Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog05Field.inout_flg : this.inout_flg,
      CHeaderLog05Field.prn_typ : this.prn_typ,
      CHeaderLog05Field.void_serial_no : this.void_serial_no,
      CHeaderLog05Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog05Field.void_kind : this.void_kind,
      CHeaderLog05Field.void_sale_date : this.void_sale_date,
      CHeaderLog05Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog05Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog05Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog05Field.tran_flg : this.tran_flg,
      CHeaderLog05Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog05Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog05Field.various_flg_1 : this.various_flg_1,
      CHeaderLog05Field.various_flg_2 : this.various_flg_2,
      CHeaderLog05Field.various_flg_3 : this.various_flg_3,
      CHeaderLog05Field.various_num_1 : this.various_num_1,
      CHeaderLog05Field.various_num_2 : this.various_num_2,
      CHeaderLog05Field.various_num_3 : this.various_num_3,
      CHeaderLog05Field.various_data : this.various_data,
      CHeaderLog05Field.various_flg_4 : this.various_flg_4,
      CHeaderLog05Field.various_flg_5 : this.various_flg_5,
      CHeaderLog05Field.various_flg_6 : this.various_flg_6,
      CHeaderLog05Field.various_flg_7 : this.various_flg_7,
      CHeaderLog05Field.various_flg_8 : this.various_flg_8,
      CHeaderLog05Field.various_flg_9 : this.various_flg_9,
      CHeaderLog05Field.various_flg_10 : this.various_flg_10,
      CHeaderLog05Field.various_flg_11 : this.various_flg_11,
      CHeaderLog05Field.various_flg_12 : this.various_flg_12,
      CHeaderLog05Field.various_flg_13 : this.various_flg_13,
      CHeaderLog05Field.reserv_flg : this.reserv_flg,
      CHeaderLog05Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog05Field.reserv_status : this.reserv_status,
      CHeaderLog05Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog05Field.reserv_cd : this.reserv_cd,
      CHeaderLog05Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_05 実績ヘッダログ05のフィールド名設定用クラス
class CHeaderLog05Field {
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
//region c_header_log_06  実績ヘッダログ06
/// c_header_log_06 実績ヘッダログ06クラス
class CHeaderLog06Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_06";

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
      CHeaderLog06Columns rn = CHeaderLog06Columns();
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
    CHeaderLog06Columns rn = CHeaderLog06Columns();
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
      CHeaderLog06Field.serial_no : this.serial_no,
      CHeaderLog06Field.comp_cd : this.comp_cd,
      CHeaderLog06Field.stre_cd : this.stre_cd,
      CHeaderLog06Field.mac_no : this.mac_no,
      CHeaderLog06Field.receipt_no : this.receipt_no,
      CHeaderLog06Field.print_no : this.print_no,
      CHeaderLog06Field.cshr_no : this.cshr_no,
      CHeaderLog06Field.chkr_no : this.chkr_no,
      CHeaderLog06Field.cust_no : this.cust_no,
      CHeaderLog06Field.sale_date : this.sale_date,
      CHeaderLog06Field.starttime : this.starttime,
      CHeaderLog06Field.endtime : this.endtime,
      CHeaderLog06Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog06Field.inout_flg : this.inout_flg,
      CHeaderLog06Field.prn_typ : this.prn_typ,
      CHeaderLog06Field.void_serial_no : this.void_serial_no,
      CHeaderLog06Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog06Field.void_kind : this.void_kind,
      CHeaderLog06Field.void_sale_date : this.void_sale_date,
      CHeaderLog06Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog06Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog06Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog06Field.tran_flg : this.tran_flg,
      CHeaderLog06Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog06Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog06Field.various_flg_1 : this.various_flg_1,
      CHeaderLog06Field.various_flg_2 : this.various_flg_2,
      CHeaderLog06Field.various_flg_3 : this.various_flg_3,
      CHeaderLog06Field.various_num_1 : this.various_num_1,
      CHeaderLog06Field.various_num_2 : this.various_num_2,
      CHeaderLog06Field.various_num_3 : this.various_num_3,
      CHeaderLog06Field.various_data : this.various_data,
      CHeaderLog06Field.various_flg_4 : this.various_flg_4,
      CHeaderLog06Field.various_flg_5 : this.various_flg_5,
      CHeaderLog06Field.various_flg_6 : this.various_flg_6,
      CHeaderLog06Field.various_flg_7 : this.various_flg_7,
      CHeaderLog06Field.various_flg_8 : this.various_flg_8,
      CHeaderLog06Field.various_flg_9 : this.various_flg_9,
      CHeaderLog06Field.various_flg_10 : this.various_flg_10,
      CHeaderLog06Field.various_flg_11 : this.various_flg_11,
      CHeaderLog06Field.various_flg_12 : this.various_flg_12,
      CHeaderLog06Field.various_flg_13 : this.various_flg_13,
      CHeaderLog06Field.reserv_flg : this.reserv_flg,
      CHeaderLog06Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog06Field.reserv_status : this.reserv_status,
      CHeaderLog06Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog06Field.reserv_cd : this.reserv_cd,
      CHeaderLog06Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_06 実績ヘッダログ06のフィールド名設定用クラス
class CHeaderLog06Field {
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
//region c_header_log_07  実績ヘッダログ07
/// c_header_log_07 実績ヘッダログ07クラス
class CHeaderLog07Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_07";

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
      CHeaderLog07Columns rn = CHeaderLog07Columns();
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
    CHeaderLog07Columns rn = CHeaderLog07Columns();
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
      CHeaderLog07Field.serial_no : this.serial_no,
      CHeaderLog07Field.comp_cd : this.comp_cd,
      CHeaderLog07Field.stre_cd : this.stre_cd,
      CHeaderLog07Field.mac_no : this.mac_no,
      CHeaderLog07Field.receipt_no : this.receipt_no,
      CHeaderLog07Field.print_no : this.print_no,
      CHeaderLog07Field.cshr_no : this.cshr_no,
      CHeaderLog07Field.chkr_no : this.chkr_no,
      CHeaderLog07Field.cust_no : this.cust_no,
      CHeaderLog07Field.sale_date : this.sale_date,
      CHeaderLog07Field.starttime : this.starttime,
      CHeaderLog07Field.endtime : this.endtime,
      CHeaderLog07Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog07Field.inout_flg : this.inout_flg,
      CHeaderLog07Field.prn_typ : this.prn_typ,
      CHeaderLog07Field.void_serial_no : this.void_serial_no,
      CHeaderLog07Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog07Field.void_kind : this.void_kind,
      CHeaderLog07Field.void_sale_date : this.void_sale_date,
      CHeaderLog07Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog07Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog07Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog07Field.tran_flg : this.tran_flg,
      CHeaderLog07Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog07Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog07Field.various_flg_1 : this.various_flg_1,
      CHeaderLog07Field.various_flg_2 : this.various_flg_2,
      CHeaderLog07Field.various_flg_3 : this.various_flg_3,
      CHeaderLog07Field.various_num_1 : this.various_num_1,
      CHeaderLog07Field.various_num_2 : this.various_num_2,
      CHeaderLog07Field.various_num_3 : this.various_num_3,
      CHeaderLog07Field.various_data : this.various_data,
      CHeaderLog07Field.various_flg_4 : this.various_flg_4,
      CHeaderLog07Field.various_flg_5 : this.various_flg_5,
      CHeaderLog07Field.various_flg_6 : this.various_flg_6,
      CHeaderLog07Field.various_flg_7 : this.various_flg_7,
      CHeaderLog07Field.various_flg_8 : this.various_flg_8,
      CHeaderLog07Field.various_flg_9 : this.various_flg_9,
      CHeaderLog07Field.various_flg_10 : this.various_flg_10,
      CHeaderLog07Field.various_flg_11 : this.various_flg_11,
      CHeaderLog07Field.various_flg_12 : this.various_flg_12,
      CHeaderLog07Field.various_flg_13 : this.various_flg_13,
      CHeaderLog07Field.reserv_flg : this.reserv_flg,
      CHeaderLog07Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog07Field.reserv_status : this.reserv_status,
      CHeaderLog07Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog07Field.reserv_cd : this.reserv_cd,
      CHeaderLog07Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_07 実績ヘッダログ07のフィールド名設定用クラス
class CHeaderLog07Field {
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
//region c_header_log_08  実績ヘッダログ08
/// c_header_log_08 実績ヘッダログ08クラス
class CHeaderLog08Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_08";

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
      CHeaderLog08Columns rn = CHeaderLog08Columns();
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
    CHeaderLog08Columns rn = CHeaderLog08Columns();
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
      CHeaderLog08Field.serial_no : this.serial_no,
      CHeaderLog08Field.comp_cd : this.comp_cd,
      CHeaderLog08Field.stre_cd : this.stre_cd,
      CHeaderLog08Field.mac_no : this.mac_no,
      CHeaderLog08Field.receipt_no : this.receipt_no,
      CHeaderLog08Field.print_no : this.print_no,
      CHeaderLog08Field.cshr_no : this.cshr_no,
      CHeaderLog08Field.chkr_no : this.chkr_no,
      CHeaderLog08Field.cust_no : this.cust_no,
      CHeaderLog08Field.sale_date : this.sale_date,
      CHeaderLog08Field.starttime : this.starttime,
      CHeaderLog08Field.endtime : this.endtime,
      CHeaderLog08Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog08Field.inout_flg : this.inout_flg,
      CHeaderLog08Field.prn_typ : this.prn_typ,
      CHeaderLog08Field.void_serial_no : this.void_serial_no,
      CHeaderLog08Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog08Field.void_kind : this.void_kind,
      CHeaderLog08Field.void_sale_date : this.void_sale_date,
      CHeaderLog08Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog08Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog08Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog08Field.tran_flg : this.tran_flg,
      CHeaderLog08Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog08Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog08Field.various_flg_1 : this.various_flg_1,
      CHeaderLog08Field.various_flg_2 : this.various_flg_2,
      CHeaderLog08Field.various_flg_3 : this.various_flg_3,
      CHeaderLog08Field.various_num_1 : this.various_num_1,
      CHeaderLog08Field.various_num_2 : this.various_num_2,
      CHeaderLog08Field.various_num_3 : this.various_num_3,
      CHeaderLog08Field.various_data : this.various_data,
      CHeaderLog08Field.various_flg_4 : this.various_flg_4,
      CHeaderLog08Field.various_flg_5 : this.various_flg_5,
      CHeaderLog08Field.various_flg_6 : this.various_flg_6,
      CHeaderLog08Field.various_flg_7 : this.various_flg_7,
      CHeaderLog08Field.various_flg_8 : this.various_flg_8,
      CHeaderLog08Field.various_flg_9 : this.various_flg_9,
      CHeaderLog08Field.various_flg_10 : this.various_flg_10,
      CHeaderLog08Field.various_flg_11 : this.various_flg_11,
      CHeaderLog08Field.various_flg_12 : this.various_flg_12,
      CHeaderLog08Field.various_flg_13 : this.various_flg_13,
      CHeaderLog08Field.reserv_flg : this.reserv_flg,
      CHeaderLog08Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog08Field.reserv_status : this.reserv_status,
      CHeaderLog08Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog08Field.reserv_cd : this.reserv_cd,
      CHeaderLog08Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_08 実績ヘッダログ08のフィールド名設定用クラス
class CHeaderLog08Field {
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
//region c_header_log_09  実績ヘッダログ09
/// c_header_log_09 実績ヘッダログ09クラス
class CHeaderLog09Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_09";

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
      CHeaderLog09Columns rn = CHeaderLog09Columns();
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
    CHeaderLog09Columns rn = CHeaderLog09Columns();
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
      CHeaderLog09Field.serial_no : this.serial_no,
      CHeaderLog09Field.comp_cd : this.comp_cd,
      CHeaderLog09Field.stre_cd : this.stre_cd,
      CHeaderLog09Field.mac_no : this.mac_no,
      CHeaderLog09Field.receipt_no : this.receipt_no,
      CHeaderLog09Field.print_no : this.print_no,
      CHeaderLog09Field.cshr_no : this.cshr_no,
      CHeaderLog09Field.chkr_no : this.chkr_no,
      CHeaderLog09Field.cust_no : this.cust_no,
      CHeaderLog09Field.sale_date : this.sale_date,
      CHeaderLog09Field.starttime : this.starttime,
      CHeaderLog09Field.endtime : this.endtime,
      CHeaderLog09Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog09Field.inout_flg : this.inout_flg,
      CHeaderLog09Field.prn_typ : this.prn_typ,
      CHeaderLog09Field.void_serial_no : this.void_serial_no,
      CHeaderLog09Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog09Field.void_kind : this.void_kind,
      CHeaderLog09Field.void_sale_date : this.void_sale_date,
      CHeaderLog09Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog09Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog09Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog09Field.tran_flg : this.tran_flg,
      CHeaderLog09Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog09Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog09Field.various_flg_1 : this.various_flg_1,
      CHeaderLog09Field.various_flg_2 : this.various_flg_2,
      CHeaderLog09Field.various_flg_3 : this.various_flg_3,
      CHeaderLog09Field.various_num_1 : this.various_num_1,
      CHeaderLog09Field.various_num_2 : this.various_num_2,
      CHeaderLog09Field.various_num_3 : this.various_num_3,
      CHeaderLog09Field.various_data : this.various_data,
      CHeaderLog09Field.various_flg_4 : this.various_flg_4,
      CHeaderLog09Field.various_flg_5 : this.various_flg_5,
      CHeaderLog09Field.various_flg_6 : this.various_flg_6,
      CHeaderLog09Field.various_flg_7 : this.various_flg_7,
      CHeaderLog09Field.various_flg_8 : this.various_flg_8,
      CHeaderLog09Field.various_flg_9 : this.various_flg_9,
      CHeaderLog09Field.various_flg_10 : this.various_flg_10,
      CHeaderLog09Field.various_flg_11 : this.various_flg_11,
      CHeaderLog09Field.various_flg_12 : this.various_flg_12,
      CHeaderLog09Field.various_flg_13 : this.various_flg_13,
      CHeaderLog09Field.reserv_flg : this.reserv_flg,
      CHeaderLog09Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog09Field.reserv_status : this.reserv_status,
      CHeaderLog09Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog09Field.reserv_cd : this.reserv_cd,
      CHeaderLog09Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_09 実績ヘッダログ09のフィールド名設定用クラス
class CHeaderLog09Field {
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
//region c_header_log_10  実績ヘッダログ10
/// c_header_log_10 実績ヘッダログ10クラス
class CHeaderLog10Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_10";

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
      CHeaderLog10Columns rn = CHeaderLog10Columns();
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
    CHeaderLog10Columns rn = CHeaderLog10Columns();
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
      CHeaderLog10Field.serial_no : this.serial_no,
      CHeaderLog10Field.comp_cd : this.comp_cd,
      CHeaderLog10Field.stre_cd : this.stre_cd,
      CHeaderLog10Field.mac_no : this.mac_no,
      CHeaderLog10Field.receipt_no : this.receipt_no,
      CHeaderLog10Field.print_no : this.print_no,
      CHeaderLog10Field.cshr_no : this.cshr_no,
      CHeaderLog10Field.chkr_no : this.chkr_no,
      CHeaderLog10Field.cust_no : this.cust_no,
      CHeaderLog10Field.sale_date : this.sale_date,
      CHeaderLog10Field.starttime : this.starttime,
      CHeaderLog10Field.endtime : this.endtime,
      CHeaderLog10Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog10Field.inout_flg : this.inout_flg,
      CHeaderLog10Field.prn_typ : this.prn_typ,
      CHeaderLog10Field.void_serial_no : this.void_serial_no,
      CHeaderLog10Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog10Field.void_kind : this.void_kind,
      CHeaderLog10Field.void_sale_date : this.void_sale_date,
      CHeaderLog10Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog10Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog10Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog10Field.tran_flg : this.tran_flg,
      CHeaderLog10Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog10Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog10Field.various_flg_1 : this.various_flg_1,
      CHeaderLog10Field.various_flg_2 : this.various_flg_2,
      CHeaderLog10Field.various_flg_3 : this.various_flg_3,
      CHeaderLog10Field.various_num_1 : this.various_num_1,
      CHeaderLog10Field.various_num_2 : this.various_num_2,
      CHeaderLog10Field.various_num_3 : this.various_num_3,
      CHeaderLog10Field.various_data : this.various_data,
      CHeaderLog10Field.various_flg_4 : this.various_flg_4,
      CHeaderLog10Field.various_flg_5 : this.various_flg_5,
      CHeaderLog10Field.various_flg_6 : this.various_flg_6,
      CHeaderLog10Field.various_flg_7 : this.various_flg_7,
      CHeaderLog10Field.various_flg_8 : this.various_flg_8,
      CHeaderLog10Field.various_flg_9 : this.various_flg_9,
      CHeaderLog10Field.various_flg_10 : this.various_flg_10,
      CHeaderLog10Field.various_flg_11 : this.various_flg_11,
      CHeaderLog10Field.various_flg_12 : this.various_flg_12,
      CHeaderLog10Field.various_flg_13 : this.various_flg_13,
      CHeaderLog10Field.reserv_flg : this.reserv_flg,
      CHeaderLog10Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog10Field.reserv_status : this.reserv_status,
      CHeaderLog10Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog10Field.reserv_cd : this.reserv_cd,
      CHeaderLog10Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_10 実績ヘッダログ10のフィールド名設定用クラス
class CHeaderLog10Field {
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
//region c_header_log_11  実績ヘッダログ11
/// c_header_log_11 実績ヘッダログ11クラス
class CHeaderLog11Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_11";

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
      CHeaderLog11Columns rn = CHeaderLog11Columns();
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
    CHeaderLog11Columns rn = CHeaderLog11Columns();
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
      CHeaderLog11Field.serial_no : this.serial_no,
      CHeaderLog11Field.comp_cd : this.comp_cd,
      CHeaderLog11Field.stre_cd : this.stre_cd,
      CHeaderLog11Field.mac_no : this.mac_no,
      CHeaderLog11Field.receipt_no : this.receipt_no,
      CHeaderLog11Field.print_no : this.print_no,
      CHeaderLog11Field.cshr_no : this.cshr_no,
      CHeaderLog11Field.chkr_no : this.chkr_no,
      CHeaderLog11Field.cust_no : this.cust_no,
      CHeaderLog11Field.sale_date : this.sale_date,
      CHeaderLog11Field.starttime : this.starttime,
      CHeaderLog11Field.endtime : this.endtime,
      CHeaderLog11Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog11Field.inout_flg : this.inout_flg,
      CHeaderLog11Field.prn_typ : this.prn_typ,
      CHeaderLog11Field.void_serial_no : this.void_serial_no,
      CHeaderLog11Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog11Field.void_kind : this.void_kind,
      CHeaderLog11Field.void_sale_date : this.void_sale_date,
      CHeaderLog11Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog11Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog11Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog11Field.tran_flg : this.tran_flg,
      CHeaderLog11Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog11Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog11Field.various_flg_1 : this.various_flg_1,
      CHeaderLog11Field.various_flg_2 : this.various_flg_2,
      CHeaderLog11Field.various_flg_3 : this.various_flg_3,
      CHeaderLog11Field.various_num_1 : this.various_num_1,
      CHeaderLog11Field.various_num_2 : this.various_num_2,
      CHeaderLog11Field.various_num_3 : this.various_num_3,
      CHeaderLog11Field.various_data : this.various_data,
      CHeaderLog11Field.various_flg_4 : this.various_flg_4,
      CHeaderLog11Field.various_flg_5 : this.various_flg_5,
      CHeaderLog11Field.various_flg_6 : this.various_flg_6,
      CHeaderLog11Field.various_flg_7 : this.various_flg_7,
      CHeaderLog11Field.various_flg_8 : this.various_flg_8,
      CHeaderLog11Field.various_flg_9 : this.various_flg_9,
      CHeaderLog11Field.various_flg_10 : this.various_flg_10,
      CHeaderLog11Field.various_flg_11 : this.various_flg_11,
      CHeaderLog11Field.various_flg_12 : this.various_flg_12,
      CHeaderLog11Field.various_flg_13 : this.various_flg_13,
      CHeaderLog11Field.reserv_flg : this.reserv_flg,
      CHeaderLog11Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog11Field.reserv_status : this.reserv_status,
      CHeaderLog11Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog11Field.reserv_cd : this.reserv_cd,
      CHeaderLog11Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_11 実績ヘッダログ11のフィールド名設定用クラス
class CHeaderLog11Field {
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
//region c_header_log_12  実績ヘッダログ12
/// c_header_log_12 実績ヘッダログ12クラス
class CHeaderLog12Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_12";

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
      CHeaderLog12Columns rn = CHeaderLog12Columns();
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
    CHeaderLog12Columns rn = CHeaderLog12Columns();
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
      CHeaderLog12Field.serial_no : this.serial_no,
      CHeaderLog12Field.comp_cd : this.comp_cd,
      CHeaderLog12Field.stre_cd : this.stre_cd,
      CHeaderLog12Field.mac_no : this.mac_no,
      CHeaderLog12Field.receipt_no : this.receipt_no,
      CHeaderLog12Field.print_no : this.print_no,
      CHeaderLog12Field.cshr_no : this.cshr_no,
      CHeaderLog12Field.chkr_no : this.chkr_no,
      CHeaderLog12Field.cust_no : this.cust_no,
      CHeaderLog12Field.sale_date : this.sale_date,
      CHeaderLog12Field.starttime : this.starttime,
      CHeaderLog12Field.endtime : this.endtime,
      CHeaderLog12Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog12Field.inout_flg : this.inout_flg,
      CHeaderLog12Field.prn_typ : this.prn_typ,
      CHeaderLog12Field.void_serial_no : this.void_serial_no,
      CHeaderLog12Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog12Field.void_kind : this.void_kind,
      CHeaderLog12Field.void_sale_date : this.void_sale_date,
      CHeaderLog12Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog12Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog12Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog12Field.tran_flg : this.tran_flg,
      CHeaderLog12Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog12Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog12Field.various_flg_1 : this.various_flg_1,
      CHeaderLog12Field.various_flg_2 : this.various_flg_2,
      CHeaderLog12Field.various_flg_3 : this.various_flg_3,
      CHeaderLog12Field.various_num_1 : this.various_num_1,
      CHeaderLog12Field.various_num_2 : this.various_num_2,
      CHeaderLog12Field.various_num_3 : this.various_num_3,
      CHeaderLog12Field.various_data : this.various_data,
      CHeaderLog12Field.various_flg_4 : this.various_flg_4,
      CHeaderLog12Field.various_flg_5 : this.various_flg_5,
      CHeaderLog12Field.various_flg_6 : this.various_flg_6,
      CHeaderLog12Field.various_flg_7 : this.various_flg_7,
      CHeaderLog12Field.various_flg_8 : this.various_flg_8,
      CHeaderLog12Field.various_flg_9 : this.various_flg_9,
      CHeaderLog12Field.various_flg_10 : this.various_flg_10,
      CHeaderLog12Field.various_flg_11 : this.various_flg_11,
      CHeaderLog12Field.various_flg_12 : this.various_flg_12,
      CHeaderLog12Field.various_flg_13 : this.various_flg_13,
      CHeaderLog12Field.reserv_flg : this.reserv_flg,
      CHeaderLog12Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog12Field.reserv_status : this.reserv_status,
      CHeaderLog12Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog12Field.reserv_cd : this.reserv_cd,
      CHeaderLog12Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_12 実績ヘッダログ12のフィールド名設定用クラス
class CHeaderLog12Field {
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
//region c_header_log_13  実績ヘッダログ13
/// c_header_log_13 実績ヘッダログ13クラス
class CHeaderLog13Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_13";

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
      CHeaderLog13Columns rn = CHeaderLog13Columns();
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
    CHeaderLog13Columns rn = CHeaderLog13Columns();
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
      CHeaderLog13Field.serial_no : this.serial_no,
      CHeaderLog13Field.comp_cd : this.comp_cd,
      CHeaderLog13Field.stre_cd : this.stre_cd,
      CHeaderLog13Field.mac_no : this.mac_no,
      CHeaderLog13Field.receipt_no : this.receipt_no,
      CHeaderLog13Field.print_no : this.print_no,
      CHeaderLog13Field.cshr_no : this.cshr_no,
      CHeaderLog13Field.chkr_no : this.chkr_no,
      CHeaderLog13Field.cust_no : this.cust_no,
      CHeaderLog13Field.sale_date : this.sale_date,
      CHeaderLog13Field.starttime : this.starttime,
      CHeaderLog13Field.endtime : this.endtime,
      CHeaderLog13Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog13Field.inout_flg : this.inout_flg,
      CHeaderLog13Field.prn_typ : this.prn_typ,
      CHeaderLog13Field.void_serial_no : this.void_serial_no,
      CHeaderLog13Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog13Field.void_kind : this.void_kind,
      CHeaderLog13Field.void_sale_date : this.void_sale_date,
      CHeaderLog13Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog13Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog13Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog13Field.tran_flg : this.tran_flg,
      CHeaderLog13Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog13Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog13Field.various_flg_1 : this.various_flg_1,
      CHeaderLog13Field.various_flg_2 : this.various_flg_2,
      CHeaderLog13Field.various_flg_3 : this.various_flg_3,
      CHeaderLog13Field.various_num_1 : this.various_num_1,
      CHeaderLog13Field.various_num_2 : this.various_num_2,
      CHeaderLog13Field.various_num_3 : this.various_num_3,
      CHeaderLog13Field.various_data : this.various_data,
      CHeaderLog13Field.various_flg_4 : this.various_flg_4,
      CHeaderLog13Field.various_flg_5 : this.various_flg_5,
      CHeaderLog13Field.various_flg_6 : this.various_flg_6,
      CHeaderLog13Field.various_flg_7 : this.various_flg_7,
      CHeaderLog13Field.various_flg_8 : this.various_flg_8,
      CHeaderLog13Field.various_flg_9 : this.various_flg_9,
      CHeaderLog13Field.various_flg_10 : this.various_flg_10,
      CHeaderLog13Field.various_flg_11 : this.various_flg_11,
      CHeaderLog13Field.various_flg_12 : this.various_flg_12,
      CHeaderLog13Field.various_flg_13 : this.various_flg_13,
      CHeaderLog13Field.reserv_flg : this.reserv_flg,
      CHeaderLog13Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog13Field.reserv_status : this.reserv_status,
      CHeaderLog13Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog13Field.reserv_cd : this.reserv_cd,
      CHeaderLog13Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_13 実績ヘッダログ13のフィールド名設定用クラス
class CHeaderLog13Field {
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
//region c_header_log_14  実績ヘッダログ14
/// c_header_log_14 実績ヘッダログ14クラス
class CHeaderLog14Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_14";

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
      CHeaderLog14Columns rn = CHeaderLog14Columns();
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
    CHeaderLog14Columns rn = CHeaderLog14Columns();
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
      CHeaderLog14Field.serial_no : this.serial_no,
      CHeaderLog14Field.comp_cd : this.comp_cd,
      CHeaderLog14Field.stre_cd : this.stre_cd,
      CHeaderLog14Field.mac_no : this.mac_no,
      CHeaderLog14Field.receipt_no : this.receipt_no,
      CHeaderLog14Field.print_no : this.print_no,
      CHeaderLog14Field.cshr_no : this.cshr_no,
      CHeaderLog14Field.chkr_no : this.chkr_no,
      CHeaderLog14Field.cust_no : this.cust_no,
      CHeaderLog14Field.sale_date : this.sale_date,
      CHeaderLog14Field.starttime : this.starttime,
      CHeaderLog14Field.endtime : this.endtime,
      CHeaderLog14Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog14Field.inout_flg : this.inout_flg,
      CHeaderLog14Field.prn_typ : this.prn_typ,
      CHeaderLog14Field.void_serial_no : this.void_serial_no,
      CHeaderLog14Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog14Field.void_kind : this.void_kind,
      CHeaderLog14Field.void_sale_date : this.void_sale_date,
      CHeaderLog14Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog14Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog14Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog14Field.tran_flg : this.tran_flg,
      CHeaderLog14Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog14Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog14Field.various_flg_1 : this.various_flg_1,
      CHeaderLog14Field.various_flg_2 : this.various_flg_2,
      CHeaderLog14Field.various_flg_3 : this.various_flg_3,
      CHeaderLog14Field.various_num_1 : this.various_num_1,
      CHeaderLog14Field.various_num_2 : this.various_num_2,
      CHeaderLog14Field.various_num_3 : this.various_num_3,
      CHeaderLog14Field.various_data : this.various_data,
      CHeaderLog14Field.various_flg_4 : this.various_flg_4,
      CHeaderLog14Field.various_flg_5 : this.various_flg_5,
      CHeaderLog14Field.various_flg_6 : this.various_flg_6,
      CHeaderLog14Field.various_flg_7 : this.various_flg_7,
      CHeaderLog14Field.various_flg_8 : this.various_flg_8,
      CHeaderLog14Field.various_flg_9 : this.various_flg_9,
      CHeaderLog14Field.various_flg_10 : this.various_flg_10,
      CHeaderLog14Field.various_flg_11 : this.various_flg_11,
      CHeaderLog14Field.various_flg_12 : this.various_flg_12,
      CHeaderLog14Field.various_flg_13 : this.various_flg_13,
      CHeaderLog14Field.reserv_flg : this.reserv_flg,
      CHeaderLog14Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog14Field.reserv_status : this.reserv_status,
      CHeaderLog14Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog14Field.reserv_cd : this.reserv_cd,
      CHeaderLog14Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_14 実績ヘッダログ14のフィールド名設定用クラス
class CHeaderLog14Field {
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
//region c_header_log_15  実績ヘッダログ15
/// c_header_log_15 実績ヘッダログ15クラス
class CHeaderLog15Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_15";

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
      CHeaderLog15Columns rn = CHeaderLog15Columns();
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
    CHeaderLog15Columns rn = CHeaderLog15Columns();
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
      CHeaderLog15Field.serial_no : this.serial_no,
      CHeaderLog15Field.comp_cd : this.comp_cd,
      CHeaderLog15Field.stre_cd : this.stre_cd,
      CHeaderLog15Field.mac_no : this.mac_no,
      CHeaderLog15Field.receipt_no : this.receipt_no,
      CHeaderLog15Field.print_no : this.print_no,
      CHeaderLog15Field.cshr_no : this.cshr_no,
      CHeaderLog15Field.chkr_no : this.chkr_no,
      CHeaderLog15Field.cust_no : this.cust_no,
      CHeaderLog15Field.sale_date : this.sale_date,
      CHeaderLog15Field.starttime : this.starttime,
      CHeaderLog15Field.endtime : this.endtime,
      CHeaderLog15Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog15Field.inout_flg : this.inout_flg,
      CHeaderLog15Field.prn_typ : this.prn_typ,
      CHeaderLog15Field.void_serial_no : this.void_serial_no,
      CHeaderLog15Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog15Field.void_kind : this.void_kind,
      CHeaderLog15Field.void_sale_date : this.void_sale_date,
      CHeaderLog15Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog15Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog15Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog15Field.tran_flg : this.tran_flg,
      CHeaderLog15Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog15Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog15Field.various_flg_1 : this.various_flg_1,
      CHeaderLog15Field.various_flg_2 : this.various_flg_2,
      CHeaderLog15Field.various_flg_3 : this.various_flg_3,
      CHeaderLog15Field.various_num_1 : this.various_num_1,
      CHeaderLog15Field.various_num_2 : this.various_num_2,
      CHeaderLog15Field.various_num_3 : this.various_num_3,
      CHeaderLog15Field.various_data : this.various_data,
      CHeaderLog15Field.various_flg_4 : this.various_flg_4,
      CHeaderLog15Field.various_flg_5 : this.various_flg_5,
      CHeaderLog15Field.various_flg_6 : this.various_flg_6,
      CHeaderLog15Field.various_flg_7 : this.various_flg_7,
      CHeaderLog15Field.various_flg_8 : this.various_flg_8,
      CHeaderLog15Field.various_flg_9 : this.various_flg_9,
      CHeaderLog15Field.various_flg_10 : this.various_flg_10,
      CHeaderLog15Field.various_flg_11 : this.various_flg_11,
      CHeaderLog15Field.various_flg_12 : this.various_flg_12,
      CHeaderLog15Field.various_flg_13 : this.various_flg_13,
      CHeaderLog15Field.reserv_flg : this.reserv_flg,
      CHeaderLog15Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog15Field.reserv_status : this.reserv_status,
      CHeaderLog15Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog15Field.reserv_cd : this.reserv_cd,
      CHeaderLog15Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_15 実績ヘッダログ15のフィールド名設定用クラス
class CHeaderLog15Field {
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
//region c_header_log_16  実績ヘッダログ16
/// c_header_log_16 実績ヘッダログ16クラス
class CHeaderLog16Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_16";

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
      CHeaderLog16Columns rn = CHeaderLog16Columns();
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
    CHeaderLog16Columns rn = CHeaderLog16Columns();
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
      CHeaderLog16Field.serial_no : this.serial_no,
      CHeaderLog16Field.comp_cd : this.comp_cd,
      CHeaderLog16Field.stre_cd : this.stre_cd,
      CHeaderLog16Field.mac_no : this.mac_no,
      CHeaderLog16Field.receipt_no : this.receipt_no,
      CHeaderLog16Field.print_no : this.print_no,
      CHeaderLog16Field.cshr_no : this.cshr_no,
      CHeaderLog16Field.chkr_no : this.chkr_no,
      CHeaderLog16Field.cust_no : this.cust_no,
      CHeaderLog16Field.sale_date : this.sale_date,
      CHeaderLog16Field.starttime : this.starttime,
      CHeaderLog16Field.endtime : this.endtime,
      CHeaderLog16Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog16Field.inout_flg : this.inout_flg,
      CHeaderLog16Field.prn_typ : this.prn_typ,
      CHeaderLog16Field.void_serial_no : this.void_serial_no,
      CHeaderLog16Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog16Field.void_kind : this.void_kind,
      CHeaderLog16Field.void_sale_date : this.void_sale_date,
      CHeaderLog16Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog16Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog16Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog16Field.tran_flg : this.tran_flg,
      CHeaderLog16Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog16Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog16Field.various_flg_1 : this.various_flg_1,
      CHeaderLog16Field.various_flg_2 : this.various_flg_2,
      CHeaderLog16Field.various_flg_3 : this.various_flg_3,
      CHeaderLog16Field.various_num_1 : this.various_num_1,
      CHeaderLog16Field.various_num_2 : this.various_num_2,
      CHeaderLog16Field.various_num_3 : this.various_num_3,
      CHeaderLog16Field.various_data : this.various_data,
      CHeaderLog16Field.various_flg_4 : this.various_flg_4,
      CHeaderLog16Field.various_flg_5 : this.various_flg_5,
      CHeaderLog16Field.various_flg_6 : this.various_flg_6,
      CHeaderLog16Field.various_flg_7 : this.various_flg_7,
      CHeaderLog16Field.various_flg_8 : this.various_flg_8,
      CHeaderLog16Field.various_flg_9 : this.various_flg_9,
      CHeaderLog16Field.various_flg_10 : this.various_flg_10,
      CHeaderLog16Field.various_flg_11 : this.various_flg_11,
      CHeaderLog16Field.various_flg_12 : this.various_flg_12,
      CHeaderLog16Field.various_flg_13 : this.various_flg_13,
      CHeaderLog16Field.reserv_flg : this.reserv_flg,
      CHeaderLog16Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog16Field.reserv_status : this.reserv_status,
      CHeaderLog16Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog16Field.reserv_cd : this.reserv_cd,
      CHeaderLog16Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_16 実績ヘッダログ16のフィールド名設定用クラス
class CHeaderLog16Field {
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
//region c_header_log_17  実績ヘッダログ17
/// c_header_log_17 実績ヘッダログ17クラス
class CHeaderLog17Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_17";

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
      CHeaderLog17Columns rn = CHeaderLog17Columns();
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
    CHeaderLog17Columns rn = CHeaderLog17Columns();
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
      CHeaderLog17Field.serial_no : this.serial_no,
      CHeaderLog17Field.comp_cd : this.comp_cd,
      CHeaderLog17Field.stre_cd : this.stre_cd,
      CHeaderLog17Field.mac_no : this.mac_no,
      CHeaderLog17Field.receipt_no : this.receipt_no,
      CHeaderLog17Field.print_no : this.print_no,
      CHeaderLog17Field.cshr_no : this.cshr_no,
      CHeaderLog17Field.chkr_no : this.chkr_no,
      CHeaderLog17Field.cust_no : this.cust_no,
      CHeaderLog17Field.sale_date : this.sale_date,
      CHeaderLog17Field.starttime : this.starttime,
      CHeaderLog17Field.endtime : this.endtime,
      CHeaderLog17Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog17Field.inout_flg : this.inout_flg,
      CHeaderLog17Field.prn_typ : this.prn_typ,
      CHeaderLog17Field.void_serial_no : this.void_serial_no,
      CHeaderLog17Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog17Field.void_kind : this.void_kind,
      CHeaderLog17Field.void_sale_date : this.void_sale_date,
      CHeaderLog17Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog17Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog17Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog17Field.tran_flg : this.tran_flg,
      CHeaderLog17Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog17Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog17Field.various_flg_1 : this.various_flg_1,
      CHeaderLog17Field.various_flg_2 : this.various_flg_2,
      CHeaderLog17Field.various_flg_3 : this.various_flg_3,
      CHeaderLog17Field.various_num_1 : this.various_num_1,
      CHeaderLog17Field.various_num_2 : this.various_num_2,
      CHeaderLog17Field.various_num_3 : this.various_num_3,
      CHeaderLog17Field.various_data : this.various_data,
      CHeaderLog17Field.various_flg_4 : this.various_flg_4,
      CHeaderLog17Field.various_flg_5 : this.various_flg_5,
      CHeaderLog17Field.various_flg_6 : this.various_flg_6,
      CHeaderLog17Field.various_flg_7 : this.various_flg_7,
      CHeaderLog17Field.various_flg_8 : this.various_flg_8,
      CHeaderLog17Field.various_flg_9 : this.various_flg_9,
      CHeaderLog17Field.various_flg_10 : this.various_flg_10,
      CHeaderLog17Field.various_flg_11 : this.various_flg_11,
      CHeaderLog17Field.various_flg_12 : this.various_flg_12,
      CHeaderLog17Field.various_flg_13 : this.various_flg_13,
      CHeaderLog17Field.reserv_flg : this.reserv_flg,
      CHeaderLog17Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog17Field.reserv_status : this.reserv_status,
      CHeaderLog17Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog17Field.reserv_cd : this.reserv_cd,
      CHeaderLog17Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_17 実績ヘッダログ17のフィールド名設定用クラス
class CHeaderLog17Field {
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
//region c_header_log_18  実績ヘッダログ18
/// c_header_log_18 実績ヘッダログ18クラス
class CHeaderLog18Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_18";

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
      CHeaderLog18Columns rn = CHeaderLog18Columns();
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
    CHeaderLog18Columns rn = CHeaderLog18Columns();
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
      CHeaderLog18Field.serial_no : this.serial_no,
      CHeaderLog18Field.comp_cd : this.comp_cd,
      CHeaderLog18Field.stre_cd : this.stre_cd,
      CHeaderLog18Field.mac_no : this.mac_no,
      CHeaderLog18Field.receipt_no : this.receipt_no,
      CHeaderLog18Field.print_no : this.print_no,
      CHeaderLog18Field.cshr_no : this.cshr_no,
      CHeaderLog18Field.chkr_no : this.chkr_no,
      CHeaderLog18Field.cust_no : this.cust_no,
      CHeaderLog18Field.sale_date : this.sale_date,
      CHeaderLog18Field.starttime : this.starttime,
      CHeaderLog18Field.endtime : this.endtime,
      CHeaderLog18Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog18Field.inout_flg : this.inout_flg,
      CHeaderLog18Field.prn_typ : this.prn_typ,
      CHeaderLog18Field.void_serial_no : this.void_serial_no,
      CHeaderLog18Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog18Field.void_kind : this.void_kind,
      CHeaderLog18Field.void_sale_date : this.void_sale_date,
      CHeaderLog18Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog18Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog18Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog18Field.tran_flg : this.tran_flg,
      CHeaderLog18Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog18Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog18Field.various_flg_1 : this.various_flg_1,
      CHeaderLog18Field.various_flg_2 : this.various_flg_2,
      CHeaderLog18Field.various_flg_3 : this.various_flg_3,
      CHeaderLog18Field.various_num_1 : this.various_num_1,
      CHeaderLog18Field.various_num_2 : this.various_num_2,
      CHeaderLog18Field.various_num_3 : this.various_num_3,
      CHeaderLog18Field.various_data : this.various_data,
      CHeaderLog18Field.various_flg_4 : this.various_flg_4,
      CHeaderLog18Field.various_flg_5 : this.various_flg_5,
      CHeaderLog18Field.various_flg_6 : this.various_flg_6,
      CHeaderLog18Field.various_flg_7 : this.various_flg_7,
      CHeaderLog18Field.various_flg_8 : this.various_flg_8,
      CHeaderLog18Field.various_flg_9 : this.various_flg_9,
      CHeaderLog18Field.various_flg_10 : this.various_flg_10,
      CHeaderLog18Field.various_flg_11 : this.various_flg_11,
      CHeaderLog18Field.various_flg_12 : this.various_flg_12,
      CHeaderLog18Field.various_flg_13 : this.various_flg_13,
      CHeaderLog18Field.reserv_flg : this.reserv_flg,
      CHeaderLog18Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog18Field.reserv_status : this.reserv_status,
      CHeaderLog18Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog18Field.reserv_cd : this.reserv_cd,
      CHeaderLog18Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_18 実績ヘッダログ18のフィールド名設定用クラス
class CHeaderLog18Field {
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
//region c_header_log_19  実績ヘッダログ19
/// c_header_log_19 実績ヘッダログ19クラス
class CHeaderLog19Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_19";

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
      CHeaderLog19Columns rn = CHeaderLog19Columns();
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
    CHeaderLog19Columns rn = CHeaderLog19Columns();
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
      CHeaderLog19Field.serial_no : this.serial_no,
      CHeaderLog19Field.comp_cd : this.comp_cd,
      CHeaderLog19Field.stre_cd : this.stre_cd,
      CHeaderLog19Field.mac_no : this.mac_no,
      CHeaderLog19Field.receipt_no : this.receipt_no,
      CHeaderLog19Field.print_no : this.print_no,
      CHeaderLog19Field.cshr_no : this.cshr_no,
      CHeaderLog19Field.chkr_no : this.chkr_no,
      CHeaderLog19Field.cust_no : this.cust_no,
      CHeaderLog19Field.sale_date : this.sale_date,
      CHeaderLog19Field.starttime : this.starttime,
      CHeaderLog19Field.endtime : this.endtime,
      CHeaderLog19Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog19Field.inout_flg : this.inout_flg,
      CHeaderLog19Field.prn_typ : this.prn_typ,
      CHeaderLog19Field.void_serial_no : this.void_serial_no,
      CHeaderLog19Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog19Field.void_kind : this.void_kind,
      CHeaderLog19Field.void_sale_date : this.void_sale_date,
      CHeaderLog19Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog19Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog19Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog19Field.tran_flg : this.tran_flg,
      CHeaderLog19Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog19Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog19Field.various_flg_1 : this.various_flg_1,
      CHeaderLog19Field.various_flg_2 : this.various_flg_2,
      CHeaderLog19Field.various_flg_3 : this.various_flg_3,
      CHeaderLog19Field.various_num_1 : this.various_num_1,
      CHeaderLog19Field.various_num_2 : this.various_num_2,
      CHeaderLog19Field.various_num_3 : this.various_num_3,
      CHeaderLog19Field.various_data : this.various_data,
      CHeaderLog19Field.various_flg_4 : this.various_flg_4,
      CHeaderLog19Field.various_flg_5 : this.various_flg_5,
      CHeaderLog19Field.various_flg_6 : this.various_flg_6,
      CHeaderLog19Field.various_flg_7 : this.various_flg_7,
      CHeaderLog19Field.various_flg_8 : this.various_flg_8,
      CHeaderLog19Field.various_flg_9 : this.various_flg_9,
      CHeaderLog19Field.various_flg_10 : this.various_flg_10,
      CHeaderLog19Field.various_flg_11 : this.various_flg_11,
      CHeaderLog19Field.various_flg_12 : this.various_flg_12,
      CHeaderLog19Field.various_flg_13 : this.various_flg_13,
      CHeaderLog19Field.reserv_flg : this.reserv_flg,
      CHeaderLog19Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog19Field.reserv_status : this.reserv_status,
      CHeaderLog19Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog19Field.reserv_cd : this.reserv_cd,
      CHeaderLog19Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_19 実績ヘッダログ19のフィールド名設定用クラス
class CHeaderLog19Field {
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
//region c_header_log_20  実績ヘッダログ20
/// c_header_log_20 実績ヘッダログ20クラス
class CHeaderLog20Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_20";

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
      CHeaderLog20Columns rn = CHeaderLog20Columns();
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
    CHeaderLog20Columns rn = CHeaderLog20Columns();
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
      CHeaderLog20Field.serial_no : this.serial_no,
      CHeaderLog20Field.comp_cd : this.comp_cd,
      CHeaderLog20Field.stre_cd : this.stre_cd,
      CHeaderLog20Field.mac_no : this.mac_no,
      CHeaderLog20Field.receipt_no : this.receipt_no,
      CHeaderLog20Field.print_no : this.print_no,
      CHeaderLog20Field.cshr_no : this.cshr_no,
      CHeaderLog20Field.chkr_no : this.chkr_no,
      CHeaderLog20Field.cust_no : this.cust_no,
      CHeaderLog20Field.sale_date : this.sale_date,
      CHeaderLog20Field.starttime : this.starttime,
      CHeaderLog20Field.endtime : this.endtime,
      CHeaderLog20Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog20Field.inout_flg : this.inout_flg,
      CHeaderLog20Field.prn_typ : this.prn_typ,
      CHeaderLog20Field.void_serial_no : this.void_serial_no,
      CHeaderLog20Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog20Field.void_kind : this.void_kind,
      CHeaderLog20Field.void_sale_date : this.void_sale_date,
      CHeaderLog20Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog20Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog20Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog20Field.tran_flg : this.tran_flg,
      CHeaderLog20Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog20Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog20Field.various_flg_1 : this.various_flg_1,
      CHeaderLog20Field.various_flg_2 : this.various_flg_2,
      CHeaderLog20Field.various_flg_3 : this.various_flg_3,
      CHeaderLog20Field.various_num_1 : this.various_num_1,
      CHeaderLog20Field.various_num_2 : this.various_num_2,
      CHeaderLog20Field.various_num_3 : this.various_num_3,
      CHeaderLog20Field.various_data : this.various_data,
      CHeaderLog20Field.various_flg_4 : this.various_flg_4,
      CHeaderLog20Field.various_flg_5 : this.various_flg_5,
      CHeaderLog20Field.various_flg_6 : this.various_flg_6,
      CHeaderLog20Field.various_flg_7 : this.various_flg_7,
      CHeaderLog20Field.various_flg_8 : this.various_flg_8,
      CHeaderLog20Field.various_flg_9 : this.various_flg_9,
      CHeaderLog20Field.various_flg_10 : this.various_flg_10,
      CHeaderLog20Field.various_flg_11 : this.various_flg_11,
      CHeaderLog20Field.various_flg_12 : this.various_flg_12,
      CHeaderLog20Field.various_flg_13 : this.various_flg_13,
      CHeaderLog20Field.reserv_flg : this.reserv_flg,
      CHeaderLog20Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog20Field.reserv_status : this.reserv_status,
      CHeaderLog20Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog20Field.reserv_cd : this.reserv_cd,
      CHeaderLog20Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_20 実績ヘッダログ20のフィールド名設定用クラス
class CHeaderLog20Field {
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
//region c_header_log_21  実績ヘッダログ21
/// c_header_log_21 実績ヘッダログ21クラス
class CHeaderLog21Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_21";

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
      CHeaderLog21Columns rn = CHeaderLog21Columns();
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
    CHeaderLog21Columns rn = CHeaderLog21Columns();
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
      CHeaderLog21Field.serial_no : this.serial_no,
      CHeaderLog21Field.comp_cd : this.comp_cd,
      CHeaderLog21Field.stre_cd : this.stre_cd,
      CHeaderLog21Field.mac_no : this.mac_no,
      CHeaderLog21Field.receipt_no : this.receipt_no,
      CHeaderLog21Field.print_no : this.print_no,
      CHeaderLog21Field.cshr_no : this.cshr_no,
      CHeaderLog21Field.chkr_no : this.chkr_no,
      CHeaderLog21Field.cust_no : this.cust_no,
      CHeaderLog21Field.sale_date : this.sale_date,
      CHeaderLog21Field.starttime : this.starttime,
      CHeaderLog21Field.endtime : this.endtime,
      CHeaderLog21Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog21Field.inout_flg : this.inout_flg,
      CHeaderLog21Field.prn_typ : this.prn_typ,
      CHeaderLog21Field.void_serial_no : this.void_serial_no,
      CHeaderLog21Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog21Field.void_kind : this.void_kind,
      CHeaderLog21Field.void_sale_date : this.void_sale_date,
      CHeaderLog21Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog21Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog21Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog21Field.tran_flg : this.tran_flg,
      CHeaderLog21Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog21Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog21Field.various_flg_1 : this.various_flg_1,
      CHeaderLog21Field.various_flg_2 : this.various_flg_2,
      CHeaderLog21Field.various_flg_3 : this.various_flg_3,
      CHeaderLog21Field.various_num_1 : this.various_num_1,
      CHeaderLog21Field.various_num_2 : this.various_num_2,
      CHeaderLog21Field.various_num_3 : this.various_num_3,
      CHeaderLog21Field.various_data : this.various_data,
      CHeaderLog21Field.various_flg_4 : this.various_flg_4,
      CHeaderLog21Field.various_flg_5 : this.various_flg_5,
      CHeaderLog21Field.various_flg_6 : this.various_flg_6,
      CHeaderLog21Field.various_flg_7 : this.various_flg_7,
      CHeaderLog21Field.various_flg_8 : this.various_flg_8,
      CHeaderLog21Field.various_flg_9 : this.various_flg_9,
      CHeaderLog21Field.various_flg_10 : this.various_flg_10,
      CHeaderLog21Field.various_flg_11 : this.various_flg_11,
      CHeaderLog21Field.various_flg_12 : this.various_flg_12,
      CHeaderLog21Field.various_flg_13 : this.various_flg_13,
      CHeaderLog21Field.reserv_flg : this.reserv_flg,
      CHeaderLog21Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog21Field.reserv_status : this.reserv_status,
      CHeaderLog21Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog21Field.reserv_cd : this.reserv_cd,
      CHeaderLog21Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_21 実績ヘッダログ21のフィールド名設定用クラス
class CHeaderLog21Field {
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
//region c_header_log_22  実績ヘッダログ22
/// c_header_log_22 実績ヘッダログ22クラス
class CHeaderLog22Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_22";

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
      CHeaderLog22Columns rn = CHeaderLog22Columns();
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
    CHeaderLog22Columns rn = CHeaderLog22Columns();
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
      CHeaderLog22Field.serial_no : this.serial_no,
      CHeaderLog22Field.comp_cd : this.comp_cd,
      CHeaderLog22Field.stre_cd : this.stre_cd,
      CHeaderLog22Field.mac_no : this.mac_no,
      CHeaderLog22Field.receipt_no : this.receipt_no,
      CHeaderLog22Field.print_no : this.print_no,
      CHeaderLog22Field.cshr_no : this.cshr_no,
      CHeaderLog22Field.chkr_no : this.chkr_no,
      CHeaderLog22Field.cust_no : this.cust_no,
      CHeaderLog22Field.sale_date : this.sale_date,
      CHeaderLog22Field.starttime : this.starttime,
      CHeaderLog22Field.endtime : this.endtime,
      CHeaderLog22Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog22Field.inout_flg : this.inout_flg,
      CHeaderLog22Field.prn_typ : this.prn_typ,
      CHeaderLog22Field.void_serial_no : this.void_serial_no,
      CHeaderLog22Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog22Field.void_kind : this.void_kind,
      CHeaderLog22Field.void_sale_date : this.void_sale_date,
      CHeaderLog22Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog22Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog22Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog22Field.tran_flg : this.tran_flg,
      CHeaderLog22Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog22Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog22Field.various_flg_1 : this.various_flg_1,
      CHeaderLog22Field.various_flg_2 : this.various_flg_2,
      CHeaderLog22Field.various_flg_3 : this.various_flg_3,
      CHeaderLog22Field.various_num_1 : this.various_num_1,
      CHeaderLog22Field.various_num_2 : this.various_num_2,
      CHeaderLog22Field.various_num_3 : this.various_num_3,
      CHeaderLog22Field.various_data : this.various_data,
      CHeaderLog22Field.various_flg_4 : this.various_flg_4,
      CHeaderLog22Field.various_flg_5 : this.various_flg_5,
      CHeaderLog22Field.various_flg_6 : this.various_flg_6,
      CHeaderLog22Field.various_flg_7 : this.various_flg_7,
      CHeaderLog22Field.various_flg_8 : this.various_flg_8,
      CHeaderLog22Field.various_flg_9 : this.various_flg_9,
      CHeaderLog22Field.various_flg_10 : this.various_flg_10,
      CHeaderLog22Field.various_flg_11 : this.various_flg_11,
      CHeaderLog22Field.various_flg_12 : this.various_flg_12,
      CHeaderLog22Field.various_flg_13 : this.various_flg_13,
      CHeaderLog22Field.reserv_flg : this.reserv_flg,
      CHeaderLog22Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog22Field.reserv_status : this.reserv_status,
      CHeaderLog22Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog22Field.reserv_cd : this.reserv_cd,
      CHeaderLog22Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_22 実績ヘッダログ22のフィールド名設定用クラス
class CHeaderLog22Field {
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
//region c_header_log_23  実績ヘッダログ23
/// c_header_log_23 実績ヘッダログ23クラス
class CHeaderLog23Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_23";

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
      CHeaderLog23Columns rn = CHeaderLog23Columns();
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
    CHeaderLog23Columns rn = CHeaderLog23Columns();
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
      CHeaderLog23Field.serial_no : this.serial_no,
      CHeaderLog23Field.comp_cd : this.comp_cd,
      CHeaderLog23Field.stre_cd : this.stre_cd,
      CHeaderLog23Field.mac_no : this.mac_no,
      CHeaderLog23Field.receipt_no : this.receipt_no,
      CHeaderLog23Field.print_no : this.print_no,
      CHeaderLog23Field.cshr_no : this.cshr_no,
      CHeaderLog23Field.chkr_no : this.chkr_no,
      CHeaderLog23Field.cust_no : this.cust_no,
      CHeaderLog23Field.sale_date : this.sale_date,
      CHeaderLog23Field.starttime : this.starttime,
      CHeaderLog23Field.endtime : this.endtime,
      CHeaderLog23Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog23Field.inout_flg : this.inout_flg,
      CHeaderLog23Field.prn_typ : this.prn_typ,
      CHeaderLog23Field.void_serial_no : this.void_serial_no,
      CHeaderLog23Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog23Field.void_kind : this.void_kind,
      CHeaderLog23Field.void_sale_date : this.void_sale_date,
      CHeaderLog23Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog23Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog23Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog23Field.tran_flg : this.tran_flg,
      CHeaderLog23Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog23Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog23Field.various_flg_1 : this.various_flg_1,
      CHeaderLog23Field.various_flg_2 : this.various_flg_2,
      CHeaderLog23Field.various_flg_3 : this.various_flg_3,
      CHeaderLog23Field.various_num_1 : this.various_num_1,
      CHeaderLog23Field.various_num_2 : this.various_num_2,
      CHeaderLog23Field.various_num_3 : this.various_num_3,
      CHeaderLog23Field.various_data : this.various_data,
      CHeaderLog23Field.various_flg_4 : this.various_flg_4,
      CHeaderLog23Field.various_flg_5 : this.various_flg_5,
      CHeaderLog23Field.various_flg_6 : this.various_flg_6,
      CHeaderLog23Field.various_flg_7 : this.various_flg_7,
      CHeaderLog23Field.various_flg_8 : this.various_flg_8,
      CHeaderLog23Field.various_flg_9 : this.various_flg_9,
      CHeaderLog23Field.various_flg_10 : this.various_flg_10,
      CHeaderLog23Field.various_flg_11 : this.various_flg_11,
      CHeaderLog23Field.various_flg_12 : this.various_flg_12,
      CHeaderLog23Field.various_flg_13 : this.various_flg_13,
      CHeaderLog23Field.reserv_flg : this.reserv_flg,
      CHeaderLog23Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog23Field.reserv_status : this.reserv_status,
      CHeaderLog23Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog23Field.reserv_cd : this.reserv_cd,
      CHeaderLog23Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_23 実績ヘッダログ23のフィールド名設定用クラス
class CHeaderLog23Field {
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
//region c_header_log_24  実績ヘッダログ24
/// c_header_log_24 実績ヘッダログ24クラス
class CHeaderLog24Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_24";

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
      CHeaderLog24Columns rn = CHeaderLog24Columns();
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
    CHeaderLog24Columns rn = CHeaderLog24Columns();
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
      CHeaderLog24Field.serial_no : this.serial_no,
      CHeaderLog24Field.comp_cd : this.comp_cd,
      CHeaderLog24Field.stre_cd : this.stre_cd,
      CHeaderLog24Field.mac_no : this.mac_no,
      CHeaderLog24Field.receipt_no : this.receipt_no,
      CHeaderLog24Field.print_no : this.print_no,
      CHeaderLog24Field.cshr_no : this.cshr_no,
      CHeaderLog24Field.chkr_no : this.chkr_no,
      CHeaderLog24Field.cust_no : this.cust_no,
      CHeaderLog24Field.sale_date : this.sale_date,
      CHeaderLog24Field.starttime : this.starttime,
      CHeaderLog24Field.endtime : this.endtime,
      CHeaderLog24Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog24Field.inout_flg : this.inout_flg,
      CHeaderLog24Field.prn_typ : this.prn_typ,
      CHeaderLog24Field.void_serial_no : this.void_serial_no,
      CHeaderLog24Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog24Field.void_kind : this.void_kind,
      CHeaderLog24Field.void_sale_date : this.void_sale_date,
      CHeaderLog24Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog24Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog24Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog24Field.tran_flg : this.tran_flg,
      CHeaderLog24Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog24Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog24Field.various_flg_1 : this.various_flg_1,
      CHeaderLog24Field.various_flg_2 : this.various_flg_2,
      CHeaderLog24Field.various_flg_3 : this.various_flg_3,
      CHeaderLog24Field.various_num_1 : this.various_num_1,
      CHeaderLog24Field.various_num_2 : this.various_num_2,
      CHeaderLog24Field.various_num_3 : this.various_num_3,
      CHeaderLog24Field.various_data : this.various_data,
      CHeaderLog24Field.various_flg_4 : this.various_flg_4,
      CHeaderLog24Field.various_flg_5 : this.various_flg_5,
      CHeaderLog24Field.various_flg_6 : this.various_flg_6,
      CHeaderLog24Field.various_flg_7 : this.various_flg_7,
      CHeaderLog24Field.various_flg_8 : this.various_flg_8,
      CHeaderLog24Field.various_flg_9 : this.various_flg_9,
      CHeaderLog24Field.various_flg_10 : this.various_flg_10,
      CHeaderLog24Field.various_flg_11 : this.various_flg_11,
      CHeaderLog24Field.various_flg_12 : this.various_flg_12,
      CHeaderLog24Field.various_flg_13 : this.various_flg_13,
      CHeaderLog24Field.reserv_flg : this.reserv_flg,
      CHeaderLog24Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog24Field.reserv_status : this.reserv_status,
      CHeaderLog24Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog24Field.reserv_cd : this.reserv_cd,
      CHeaderLog24Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_24 実績ヘッダログ24のフィールド名設定用クラス
class CHeaderLog24Field {
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
//region c_header_log_25  実績ヘッダログ25
/// c_header_log_25 実績ヘッダログ25クラス
class CHeaderLog25Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_25";

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
      CHeaderLog25Columns rn = CHeaderLog25Columns();
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
    CHeaderLog25Columns rn = CHeaderLog25Columns();
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
      CHeaderLog25Field.serial_no : this.serial_no,
      CHeaderLog25Field.comp_cd : this.comp_cd,
      CHeaderLog25Field.stre_cd : this.stre_cd,
      CHeaderLog25Field.mac_no : this.mac_no,
      CHeaderLog25Field.receipt_no : this.receipt_no,
      CHeaderLog25Field.print_no : this.print_no,
      CHeaderLog25Field.cshr_no : this.cshr_no,
      CHeaderLog25Field.chkr_no : this.chkr_no,
      CHeaderLog25Field.cust_no : this.cust_no,
      CHeaderLog25Field.sale_date : this.sale_date,
      CHeaderLog25Field.starttime : this.starttime,
      CHeaderLog25Field.endtime : this.endtime,
      CHeaderLog25Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog25Field.inout_flg : this.inout_flg,
      CHeaderLog25Field.prn_typ : this.prn_typ,
      CHeaderLog25Field.void_serial_no : this.void_serial_no,
      CHeaderLog25Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog25Field.void_kind : this.void_kind,
      CHeaderLog25Field.void_sale_date : this.void_sale_date,
      CHeaderLog25Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog25Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog25Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog25Field.tran_flg : this.tran_flg,
      CHeaderLog25Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog25Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog25Field.various_flg_1 : this.various_flg_1,
      CHeaderLog25Field.various_flg_2 : this.various_flg_2,
      CHeaderLog25Field.various_flg_3 : this.various_flg_3,
      CHeaderLog25Field.various_num_1 : this.various_num_1,
      CHeaderLog25Field.various_num_2 : this.various_num_2,
      CHeaderLog25Field.various_num_3 : this.various_num_3,
      CHeaderLog25Field.various_data : this.various_data,
      CHeaderLog25Field.various_flg_4 : this.various_flg_4,
      CHeaderLog25Field.various_flg_5 : this.various_flg_5,
      CHeaderLog25Field.various_flg_6 : this.various_flg_6,
      CHeaderLog25Field.various_flg_7 : this.various_flg_7,
      CHeaderLog25Field.various_flg_8 : this.various_flg_8,
      CHeaderLog25Field.various_flg_9 : this.various_flg_9,
      CHeaderLog25Field.various_flg_10 : this.various_flg_10,
      CHeaderLog25Field.various_flg_11 : this.various_flg_11,
      CHeaderLog25Field.various_flg_12 : this.various_flg_12,
      CHeaderLog25Field.various_flg_13 : this.various_flg_13,
      CHeaderLog25Field.reserv_flg : this.reserv_flg,
      CHeaderLog25Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog25Field.reserv_status : this.reserv_status,
      CHeaderLog25Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog25Field.reserv_cd : this.reserv_cd,
      CHeaderLog25Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_25 実績ヘッダログ25のフィールド名設定用クラス
class CHeaderLog25Field {
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
//region c_header_log_26  実績ヘッダログ26
/// c_header_log_26 実績ヘッダログ26クラス
class CHeaderLog26Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_26";

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
      CHeaderLog26Columns rn = CHeaderLog26Columns();
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
    CHeaderLog26Columns rn = CHeaderLog26Columns();
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
      CHeaderLog26Field.serial_no : this.serial_no,
      CHeaderLog26Field.comp_cd : this.comp_cd,
      CHeaderLog26Field.stre_cd : this.stre_cd,
      CHeaderLog26Field.mac_no : this.mac_no,
      CHeaderLog26Field.receipt_no : this.receipt_no,
      CHeaderLog26Field.print_no : this.print_no,
      CHeaderLog26Field.cshr_no : this.cshr_no,
      CHeaderLog26Field.chkr_no : this.chkr_no,
      CHeaderLog26Field.cust_no : this.cust_no,
      CHeaderLog26Field.sale_date : this.sale_date,
      CHeaderLog26Field.starttime : this.starttime,
      CHeaderLog26Field.endtime : this.endtime,
      CHeaderLog26Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog26Field.inout_flg : this.inout_flg,
      CHeaderLog26Field.prn_typ : this.prn_typ,
      CHeaderLog26Field.void_serial_no : this.void_serial_no,
      CHeaderLog26Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog26Field.void_kind : this.void_kind,
      CHeaderLog26Field.void_sale_date : this.void_sale_date,
      CHeaderLog26Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog26Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog26Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog26Field.tran_flg : this.tran_flg,
      CHeaderLog26Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog26Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog26Field.various_flg_1 : this.various_flg_1,
      CHeaderLog26Field.various_flg_2 : this.various_flg_2,
      CHeaderLog26Field.various_flg_3 : this.various_flg_3,
      CHeaderLog26Field.various_num_1 : this.various_num_1,
      CHeaderLog26Field.various_num_2 : this.various_num_2,
      CHeaderLog26Field.various_num_3 : this.various_num_3,
      CHeaderLog26Field.various_data : this.various_data,
      CHeaderLog26Field.various_flg_4 : this.various_flg_4,
      CHeaderLog26Field.various_flg_5 : this.various_flg_5,
      CHeaderLog26Field.various_flg_6 : this.various_flg_6,
      CHeaderLog26Field.various_flg_7 : this.various_flg_7,
      CHeaderLog26Field.various_flg_8 : this.various_flg_8,
      CHeaderLog26Field.various_flg_9 : this.various_flg_9,
      CHeaderLog26Field.various_flg_10 : this.various_flg_10,
      CHeaderLog26Field.various_flg_11 : this.various_flg_11,
      CHeaderLog26Field.various_flg_12 : this.various_flg_12,
      CHeaderLog26Field.various_flg_13 : this.various_flg_13,
      CHeaderLog26Field.reserv_flg : this.reserv_flg,
      CHeaderLog26Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog26Field.reserv_status : this.reserv_status,
      CHeaderLog26Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog26Field.reserv_cd : this.reserv_cd,
      CHeaderLog26Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_26 実績ヘッダログ26のフィールド名設定用クラス
class CHeaderLog26Field {
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
//region c_header_log_27  実績ヘッダログ27
/// c_header_log_27 実績ヘッダログ27クラス
class CHeaderLog27Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_27";

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
      CHeaderLog27Columns rn = CHeaderLog27Columns();
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
    CHeaderLog27Columns rn = CHeaderLog27Columns();
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
      CHeaderLog27Field.serial_no : this.serial_no,
      CHeaderLog27Field.comp_cd : this.comp_cd,
      CHeaderLog27Field.stre_cd : this.stre_cd,
      CHeaderLog27Field.mac_no : this.mac_no,
      CHeaderLog27Field.receipt_no : this.receipt_no,
      CHeaderLog27Field.print_no : this.print_no,
      CHeaderLog27Field.cshr_no : this.cshr_no,
      CHeaderLog27Field.chkr_no : this.chkr_no,
      CHeaderLog27Field.cust_no : this.cust_no,
      CHeaderLog27Field.sale_date : this.sale_date,
      CHeaderLog27Field.starttime : this.starttime,
      CHeaderLog27Field.endtime : this.endtime,
      CHeaderLog27Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog27Field.inout_flg : this.inout_flg,
      CHeaderLog27Field.prn_typ : this.prn_typ,
      CHeaderLog27Field.void_serial_no : this.void_serial_no,
      CHeaderLog27Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog27Field.void_kind : this.void_kind,
      CHeaderLog27Field.void_sale_date : this.void_sale_date,
      CHeaderLog27Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog27Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog27Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog27Field.tran_flg : this.tran_flg,
      CHeaderLog27Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog27Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog27Field.various_flg_1 : this.various_flg_1,
      CHeaderLog27Field.various_flg_2 : this.various_flg_2,
      CHeaderLog27Field.various_flg_3 : this.various_flg_3,
      CHeaderLog27Field.various_num_1 : this.various_num_1,
      CHeaderLog27Field.various_num_2 : this.various_num_2,
      CHeaderLog27Field.various_num_3 : this.various_num_3,
      CHeaderLog27Field.various_data : this.various_data,
      CHeaderLog27Field.various_flg_4 : this.various_flg_4,
      CHeaderLog27Field.various_flg_5 : this.various_flg_5,
      CHeaderLog27Field.various_flg_6 : this.various_flg_6,
      CHeaderLog27Field.various_flg_7 : this.various_flg_7,
      CHeaderLog27Field.various_flg_8 : this.various_flg_8,
      CHeaderLog27Field.various_flg_9 : this.various_flg_9,
      CHeaderLog27Field.various_flg_10 : this.various_flg_10,
      CHeaderLog27Field.various_flg_11 : this.various_flg_11,
      CHeaderLog27Field.various_flg_12 : this.various_flg_12,
      CHeaderLog27Field.various_flg_13 : this.various_flg_13,
      CHeaderLog27Field.reserv_flg : this.reserv_flg,
      CHeaderLog27Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog27Field.reserv_status : this.reserv_status,
      CHeaderLog27Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog27Field.reserv_cd : this.reserv_cd,
      CHeaderLog27Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_27 実績ヘッダログ27のフィールド名設定用クラス
class CHeaderLog27Field {
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
//region c_header_log_28  実績ヘッダログ28
/// c_header_log_28 実績ヘッダログ28クラス
class CHeaderLog28Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_28";

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
      CHeaderLog28Columns rn = CHeaderLog28Columns();
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
    CHeaderLog28Columns rn = CHeaderLog28Columns();
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
      CHeaderLog28Field.serial_no : this.serial_no,
      CHeaderLog28Field.comp_cd : this.comp_cd,
      CHeaderLog28Field.stre_cd : this.stre_cd,
      CHeaderLog28Field.mac_no : this.mac_no,
      CHeaderLog28Field.receipt_no : this.receipt_no,
      CHeaderLog28Field.print_no : this.print_no,
      CHeaderLog28Field.cshr_no : this.cshr_no,
      CHeaderLog28Field.chkr_no : this.chkr_no,
      CHeaderLog28Field.cust_no : this.cust_no,
      CHeaderLog28Field.sale_date : this.sale_date,
      CHeaderLog28Field.starttime : this.starttime,
      CHeaderLog28Field.endtime : this.endtime,
      CHeaderLog28Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog28Field.inout_flg : this.inout_flg,
      CHeaderLog28Field.prn_typ : this.prn_typ,
      CHeaderLog28Field.void_serial_no : this.void_serial_no,
      CHeaderLog28Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog28Field.void_kind : this.void_kind,
      CHeaderLog28Field.void_sale_date : this.void_sale_date,
      CHeaderLog28Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog28Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog28Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog28Field.tran_flg : this.tran_flg,
      CHeaderLog28Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog28Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog28Field.various_flg_1 : this.various_flg_1,
      CHeaderLog28Field.various_flg_2 : this.various_flg_2,
      CHeaderLog28Field.various_flg_3 : this.various_flg_3,
      CHeaderLog28Field.various_num_1 : this.various_num_1,
      CHeaderLog28Field.various_num_2 : this.various_num_2,
      CHeaderLog28Field.various_num_3 : this.various_num_3,
      CHeaderLog28Field.various_data : this.various_data,
      CHeaderLog28Field.various_flg_4 : this.various_flg_4,
      CHeaderLog28Field.various_flg_5 : this.various_flg_5,
      CHeaderLog28Field.various_flg_6 : this.various_flg_6,
      CHeaderLog28Field.various_flg_7 : this.various_flg_7,
      CHeaderLog28Field.various_flg_8 : this.various_flg_8,
      CHeaderLog28Field.various_flg_9 : this.various_flg_9,
      CHeaderLog28Field.various_flg_10 : this.various_flg_10,
      CHeaderLog28Field.various_flg_11 : this.various_flg_11,
      CHeaderLog28Field.various_flg_12 : this.various_flg_12,
      CHeaderLog28Field.various_flg_13 : this.various_flg_13,
      CHeaderLog28Field.reserv_flg : this.reserv_flg,
      CHeaderLog28Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog28Field.reserv_status : this.reserv_status,
      CHeaderLog28Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog28Field.reserv_cd : this.reserv_cd,
      CHeaderLog28Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_28 実績ヘッダログ28のフィールド名設定用クラス
class CHeaderLog28Field {
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
//region c_header_log_29  実績ヘッダログ29
/// c_header_log_29 実績ヘッダログ29クラス
class CHeaderLog29Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_29";

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
      CHeaderLog29Columns rn = CHeaderLog29Columns();
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
    CHeaderLog29Columns rn = CHeaderLog29Columns();
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
      CHeaderLog29Field.serial_no : this.serial_no,
      CHeaderLog29Field.comp_cd : this.comp_cd,
      CHeaderLog29Field.stre_cd : this.stre_cd,
      CHeaderLog29Field.mac_no : this.mac_no,
      CHeaderLog29Field.receipt_no : this.receipt_no,
      CHeaderLog29Field.print_no : this.print_no,
      CHeaderLog29Field.cshr_no : this.cshr_no,
      CHeaderLog29Field.chkr_no : this.chkr_no,
      CHeaderLog29Field.cust_no : this.cust_no,
      CHeaderLog29Field.sale_date : this.sale_date,
      CHeaderLog29Field.starttime : this.starttime,
      CHeaderLog29Field.endtime : this.endtime,
      CHeaderLog29Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog29Field.inout_flg : this.inout_flg,
      CHeaderLog29Field.prn_typ : this.prn_typ,
      CHeaderLog29Field.void_serial_no : this.void_serial_no,
      CHeaderLog29Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog29Field.void_kind : this.void_kind,
      CHeaderLog29Field.void_sale_date : this.void_sale_date,
      CHeaderLog29Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog29Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog29Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog29Field.tran_flg : this.tran_flg,
      CHeaderLog29Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog29Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog29Field.various_flg_1 : this.various_flg_1,
      CHeaderLog29Field.various_flg_2 : this.various_flg_2,
      CHeaderLog29Field.various_flg_3 : this.various_flg_3,
      CHeaderLog29Field.various_num_1 : this.various_num_1,
      CHeaderLog29Field.various_num_2 : this.various_num_2,
      CHeaderLog29Field.various_num_3 : this.various_num_3,
      CHeaderLog29Field.various_data : this.various_data,
      CHeaderLog29Field.various_flg_4 : this.various_flg_4,
      CHeaderLog29Field.various_flg_5 : this.various_flg_5,
      CHeaderLog29Field.various_flg_6 : this.various_flg_6,
      CHeaderLog29Field.various_flg_7 : this.various_flg_7,
      CHeaderLog29Field.various_flg_8 : this.various_flg_8,
      CHeaderLog29Field.various_flg_9 : this.various_flg_9,
      CHeaderLog29Field.various_flg_10 : this.various_flg_10,
      CHeaderLog29Field.various_flg_11 : this.various_flg_11,
      CHeaderLog29Field.various_flg_12 : this.various_flg_12,
      CHeaderLog29Field.various_flg_13 : this.various_flg_13,
      CHeaderLog29Field.reserv_flg : this.reserv_flg,
      CHeaderLog29Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog29Field.reserv_status : this.reserv_status,
      CHeaderLog29Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog29Field.reserv_cd : this.reserv_cd,
      CHeaderLog29Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_29 実績ヘッダログ29のフィールド名設定用クラス
class CHeaderLog29Field {
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
//region c_header_log_30  実績ヘッダログ30
/// c_header_log_30 実績ヘッダログ30クラス
class CHeaderLog30Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_30";

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
      CHeaderLog30Columns rn = CHeaderLog30Columns();
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
    CHeaderLog30Columns rn = CHeaderLog30Columns();
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
      CHeaderLog30Field.serial_no : this.serial_no,
      CHeaderLog30Field.comp_cd : this.comp_cd,
      CHeaderLog30Field.stre_cd : this.stre_cd,
      CHeaderLog30Field.mac_no : this.mac_no,
      CHeaderLog30Field.receipt_no : this.receipt_no,
      CHeaderLog30Field.print_no : this.print_no,
      CHeaderLog30Field.cshr_no : this.cshr_no,
      CHeaderLog30Field.chkr_no : this.chkr_no,
      CHeaderLog30Field.cust_no : this.cust_no,
      CHeaderLog30Field.sale_date : this.sale_date,
      CHeaderLog30Field.starttime : this.starttime,
      CHeaderLog30Field.endtime : this.endtime,
      CHeaderLog30Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog30Field.inout_flg : this.inout_flg,
      CHeaderLog30Field.prn_typ : this.prn_typ,
      CHeaderLog30Field.void_serial_no : this.void_serial_no,
      CHeaderLog30Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog30Field.void_kind : this.void_kind,
      CHeaderLog30Field.void_sale_date : this.void_sale_date,
      CHeaderLog30Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog30Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog30Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog30Field.tran_flg : this.tran_flg,
      CHeaderLog30Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog30Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog30Field.various_flg_1 : this.various_flg_1,
      CHeaderLog30Field.various_flg_2 : this.various_flg_2,
      CHeaderLog30Field.various_flg_3 : this.various_flg_3,
      CHeaderLog30Field.various_num_1 : this.various_num_1,
      CHeaderLog30Field.various_num_2 : this.various_num_2,
      CHeaderLog30Field.various_num_3 : this.various_num_3,
      CHeaderLog30Field.various_data : this.various_data,
      CHeaderLog30Field.various_flg_4 : this.various_flg_4,
      CHeaderLog30Field.various_flg_5 : this.various_flg_5,
      CHeaderLog30Field.various_flg_6 : this.various_flg_6,
      CHeaderLog30Field.various_flg_7 : this.various_flg_7,
      CHeaderLog30Field.various_flg_8 : this.various_flg_8,
      CHeaderLog30Field.various_flg_9 : this.various_flg_9,
      CHeaderLog30Field.various_flg_10 : this.various_flg_10,
      CHeaderLog30Field.various_flg_11 : this.various_flg_11,
      CHeaderLog30Field.various_flg_12 : this.various_flg_12,
      CHeaderLog30Field.various_flg_13 : this.various_flg_13,
      CHeaderLog30Field.reserv_flg : this.reserv_flg,
      CHeaderLog30Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog30Field.reserv_status : this.reserv_status,
      CHeaderLog30Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog30Field.reserv_cd : this.reserv_cd,
      CHeaderLog30Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_30 実績ヘッダログ30のフィールド名設定用クラス
class CHeaderLog30Field {
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
//region c_header_log_31  実績ヘッダログ31
/// c_header_log_31 実績ヘッダログ31クラス
class CHeaderLog31Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_31";

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
      CHeaderLog31Columns rn = CHeaderLog31Columns();
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
    CHeaderLog31Columns rn = CHeaderLog31Columns();
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
      CHeaderLog31Field.serial_no : this.serial_no,
      CHeaderLog31Field.comp_cd : this.comp_cd,
      CHeaderLog31Field.stre_cd : this.stre_cd,
      CHeaderLog31Field.mac_no : this.mac_no,
      CHeaderLog31Field.receipt_no : this.receipt_no,
      CHeaderLog31Field.print_no : this.print_no,
      CHeaderLog31Field.cshr_no : this.cshr_no,
      CHeaderLog31Field.chkr_no : this.chkr_no,
      CHeaderLog31Field.cust_no : this.cust_no,
      CHeaderLog31Field.sale_date : this.sale_date,
      CHeaderLog31Field.starttime : this.starttime,
      CHeaderLog31Field.endtime : this.endtime,
      CHeaderLog31Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLog31Field.inout_flg : this.inout_flg,
      CHeaderLog31Field.prn_typ : this.prn_typ,
      CHeaderLog31Field.void_serial_no : this.void_serial_no,
      CHeaderLog31Field.qc_serial_no : this.qc_serial_no,
      CHeaderLog31Field.void_kind : this.void_kind,
      CHeaderLog31Field.void_sale_date : this.void_sale_date,
      CHeaderLog31Field.data_log_cnt : this.data_log_cnt,
      CHeaderLog31Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLog31Field.status_log_cnt : this.status_log_cnt,
      CHeaderLog31Field.tran_flg : this.tran_flg,
      CHeaderLog31Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLog31Field.off_entry_flg : this.off_entry_flg,
      CHeaderLog31Field.various_flg_1 : this.various_flg_1,
      CHeaderLog31Field.various_flg_2 : this.various_flg_2,
      CHeaderLog31Field.various_flg_3 : this.various_flg_3,
      CHeaderLog31Field.various_num_1 : this.various_num_1,
      CHeaderLog31Field.various_num_2 : this.various_num_2,
      CHeaderLog31Field.various_num_3 : this.various_num_3,
      CHeaderLog31Field.various_data : this.various_data,
      CHeaderLog31Field.various_flg_4 : this.various_flg_4,
      CHeaderLog31Field.various_flg_5 : this.various_flg_5,
      CHeaderLog31Field.various_flg_6 : this.various_flg_6,
      CHeaderLog31Field.various_flg_7 : this.various_flg_7,
      CHeaderLog31Field.various_flg_8 : this.various_flg_8,
      CHeaderLog31Field.various_flg_9 : this.various_flg_9,
      CHeaderLog31Field.various_flg_10 : this.various_flg_10,
      CHeaderLog31Field.various_flg_11 : this.various_flg_11,
      CHeaderLog31Field.various_flg_12 : this.various_flg_12,
      CHeaderLog31Field.various_flg_13 : this.various_flg_13,
      CHeaderLog31Field.reserv_flg : this.reserv_flg,
      CHeaderLog31Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLog31Field.reserv_status : this.reserv_status,
      CHeaderLog31Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLog31Field.reserv_cd : this.reserv_cd,
      CHeaderLog31Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_31 実績ヘッダログ31のフィールド名設定用クラス
class CHeaderLog31Field {
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
//region c_header_log_reserv  実績ヘッダログ予約
/// c_header_log_reserv 実績ヘッダログ予約クラス
class CHeaderLogReservColumns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_reserv";

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
      CHeaderLogReservColumns rn = CHeaderLogReservColumns();
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
    CHeaderLogReservColumns rn = CHeaderLogReservColumns();
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
      CHeaderLogReservField.serial_no : this.serial_no,
      CHeaderLogReservField.comp_cd : this.comp_cd,
      CHeaderLogReservField.stre_cd : this.stre_cd,
      CHeaderLogReservField.mac_no : this.mac_no,
      CHeaderLogReservField.receipt_no : this.receipt_no,
      CHeaderLogReservField.print_no : this.print_no,
      CHeaderLogReservField.cshr_no : this.cshr_no,
      CHeaderLogReservField.chkr_no : this.chkr_no,
      CHeaderLogReservField.cust_no : this.cust_no,
      CHeaderLogReservField.sale_date : this.sale_date,
      CHeaderLogReservField.starttime : this.starttime,
      CHeaderLogReservField.endtime : this.endtime,
      CHeaderLogReservField.ope_mode_flg : this.ope_mode_flg,
      CHeaderLogReservField.inout_flg : this.inout_flg,
      CHeaderLogReservField.prn_typ : this.prn_typ,
      CHeaderLogReservField.void_serial_no : this.void_serial_no,
      CHeaderLogReservField.qc_serial_no : this.qc_serial_no,
      CHeaderLogReservField.void_kind : this.void_kind,
      CHeaderLogReservField.void_sale_date : this.void_sale_date,
      CHeaderLogReservField.data_log_cnt : this.data_log_cnt,
      CHeaderLogReservField.ej_log_cnt : this.ej_log_cnt,
      CHeaderLogReservField.status_log_cnt : this.status_log_cnt,
      CHeaderLogReservField.tran_flg : this.tran_flg,
      CHeaderLogReservField.sub_tran_flg : this.sub_tran_flg,
      CHeaderLogReservField.off_entry_flg : this.off_entry_flg,
      CHeaderLogReservField.various_flg_1 : this.various_flg_1,
      CHeaderLogReservField.various_flg_2 : this.various_flg_2,
      CHeaderLogReservField.various_flg_3 : this.various_flg_3,
      CHeaderLogReservField.various_num_1 : this.various_num_1,
      CHeaderLogReservField.various_num_2 : this.various_num_2,
      CHeaderLogReservField.various_num_3 : this.various_num_3,
      CHeaderLogReservField.various_data : this.various_data,
      CHeaderLogReservField.various_flg_4 : this.various_flg_4,
      CHeaderLogReservField.various_flg_5 : this.various_flg_5,
      CHeaderLogReservField.various_flg_6 : this.various_flg_6,
      CHeaderLogReservField.various_flg_7 : this.various_flg_7,
      CHeaderLogReservField.various_flg_8 : this.various_flg_8,
      CHeaderLogReservField.various_flg_9 : this.various_flg_9,
      CHeaderLogReservField.various_flg_10 : this.various_flg_10,
      CHeaderLogReservField.various_flg_11 : this.various_flg_11,
      CHeaderLogReservField.various_flg_12 : this.various_flg_12,
      CHeaderLogReservField.various_flg_13 : this.various_flg_13,
      CHeaderLogReservField.reserv_flg : this.reserv_flg,
      CHeaderLogReservField.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLogReservField.reserv_status : this.reserv_status,
      CHeaderLogReservField.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLogReservField.reserv_cd : this.reserv_cd,
      CHeaderLogReservField.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_reserv 実績ヘッダログ予約のフィールド名設定用クラス
class CHeaderLogReservField {
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
//region c_header_log_reserv_01  実績ヘッダログ予約01
/// c_header_log_reserv_01 実績ヘッダログ予約01クラス
class CHeaderLogReserv01Columns extends TableColumns{
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
  String? void_serial_no = '0';
  String? qc_serial_no = '0';
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
  String _getTableName() => "c_header_log_reserv_01";

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
      CHeaderLogReserv01Columns rn = CHeaderLogReserv01Columns();
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
    CHeaderLogReserv01Columns rn = CHeaderLogReserv01Columns();
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
      CHeaderLogReserv01Field.serial_no : this.serial_no,
      CHeaderLogReserv01Field.comp_cd : this.comp_cd,
      CHeaderLogReserv01Field.stre_cd : this.stre_cd,
      CHeaderLogReserv01Field.mac_no : this.mac_no,
      CHeaderLogReserv01Field.receipt_no : this.receipt_no,
      CHeaderLogReserv01Field.print_no : this.print_no,
      CHeaderLogReserv01Field.cshr_no : this.cshr_no,
      CHeaderLogReserv01Field.chkr_no : this.chkr_no,
      CHeaderLogReserv01Field.cust_no : this.cust_no,
      CHeaderLogReserv01Field.sale_date : this.sale_date,
      CHeaderLogReserv01Field.starttime : this.starttime,
      CHeaderLogReserv01Field.endtime : this.endtime,
      CHeaderLogReserv01Field.ope_mode_flg : this.ope_mode_flg,
      CHeaderLogReserv01Field.inout_flg : this.inout_flg,
      CHeaderLogReserv01Field.prn_typ : this.prn_typ,
      CHeaderLogReserv01Field.void_serial_no : this.void_serial_no,
      CHeaderLogReserv01Field.qc_serial_no : this.qc_serial_no,
      CHeaderLogReserv01Field.void_kind : this.void_kind,
      CHeaderLogReserv01Field.void_sale_date : this.void_sale_date,
      CHeaderLogReserv01Field.data_log_cnt : this.data_log_cnt,
      CHeaderLogReserv01Field.ej_log_cnt : this.ej_log_cnt,
      CHeaderLogReserv01Field.status_log_cnt : this.status_log_cnt,
      CHeaderLogReserv01Field.tran_flg : this.tran_flg,
      CHeaderLogReserv01Field.sub_tran_flg : this.sub_tran_flg,
      CHeaderLogReserv01Field.off_entry_flg : this.off_entry_flg,
      CHeaderLogReserv01Field.various_flg_1 : this.various_flg_1,
      CHeaderLogReserv01Field.various_flg_2 : this.various_flg_2,
      CHeaderLogReserv01Field.various_flg_3 : this.various_flg_3,
      CHeaderLogReserv01Field.various_num_1 : this.various_num_1,
      CHeaderLogReserv01Field.various_num_2 : this.various_num_2,
      CHeaderLogReserv01Field.various_num_3 : this.various_num_3,
      CHeaderLogReserv01Field.various_data : this.various_data,
      CHeaderLogReserv01Field.various_flg_4 : this.various_flg_4,
      CHeaderLogReserv01Field.various_flg_5 : this.various_flg_5,
      CHeaderLogReserv01Field.various_flg_6 : this.various_flg_6,
      CHeaderLogReserv01Field.various_flg_7 : this.various_flg_7,
      CHeaderLogReserv01Field.various_flg_8 : this.various_flg_8,
      CHeaderLogReserv01Field.various_flg_9 : this.various_flg_9,
      CHeaderLogReserv01Field.various_flg_10 : this.various_flg_10,
      CHeaderLogReserv01Field.various_flg_11 : this.various_flg_11,
      CHeaderLogReserv01Field.various_flg_12 : this.various_flg_12,
      CHeaderLogReserv01Field.various_flg_13 : this.various_flg_13,
      CHeaderLogReserv01Field.reserv_flg : this.reserv_flg,
      CHeaderLogReserv01Field.reserv_stre_cd : this.reserv_stre_cd,
      CHeaderLogReserv01Field.reserv_status : this.reserv_status,
      CHeaderLogReserv01Field.reserv_chg_cnt : this.reserv_chg_cnt,
      CHeaderLogReserv01Field.reserv_cd : this.reserv_cd,
      CHeaderLogReserv01Field.lock_cd : this.lock_cd,
    };
  }
}

/// c_header_log_reserv_01 実績ヘッダログ予約01のフィールド名設定用クラス
class CHeaderLogReserv01Field {
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
