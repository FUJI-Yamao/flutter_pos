/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
実績ジャーナルデータログ 日付別
c_ej_log_01	実績ジャーナルデータログ01
c_ej_log_02	実績ジャーナルデータログ02
c_ej_log_03	実績ジャーナルデータログ03
c_ej_log_04	実績ジャーナルデータログ04
c_ej_log_05	実績ジャーナルデータログ05
c_ej_log_06	実績ジャーナルデータログ06
c_ej_log_07	実績ジャーナルデータログ07
c_ej_log_08	実績ジャーナルデータログ08
c_ej_log_09	実績ジャーナルデータログ09
c_ej_log_10	実績ジャーナルデータログ10
c_ej_log_11	実績ジャーナルデータログ11
c_ej_log_12	実績ジャーナルデータログ12
c_ej_log_13	実績ジャーナルデータログ13
c_ej_log_14	実績ジャーナルデータログ14
c_ej_log_15	実績ジャーナルデータログ15
c_ej_log_16	実績ジャーナルデータログ16
c_ej_log_17	実績ジャーナルデータログ17
c_ej_log_18	実績ジャーナルデータログ18
c_ej_log_19	実績ジャーナルデータログ19
c_ej_log_20	実績ジャーナルデータログ20
c_ej_log_21	実績ジャーナルデータログ21
c_ej_log_22	実績ジャーナルデータログ22
c_ej_log_23	実績ジャーナルデータログ23
c_ej_log_24	実績ジャーナルデータログ24
c_ej_log_25	実績ジャーナルデータログ25
c_ej_log_26	実績ジャーナルデータログ26
c_ej_log_27	実績ジャーナルデータログ27
c_ej_log_28	実績ジャーナルデータログ28
c_ej_log_29	実績ジャーナルデータログ29
c_ej_log_30	実績ジャーナルデータログ30
c_ej_log_31	実績ジャーナルデータログ31
 */

//region c_ej_log_01  実績ジャーナルデータログ01
/// c_ej_log_01 実績ジャーナルデータログ01クラス
class CEjLog01Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_01";

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
      CEjLog01Columns rn = CEjLog01Columns();
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
    CEjLog01Columns rn = CEjLog01Columns();
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
      CEjLog01Field.serial_no : this.serial_no,
      CEjLog01Field.comp_cd : this.comp_cd,
      CEjLog01Field.stre_cd : this.stre_cd,
      CEjLog01Field.mac_no : this.mac_no,
      CEjLog01Field.print_no : this.print_no,
      CEjLog01Field.seq_no : this.seq_no,
      CEjLog01Field.receipt_no : this.receipt_no,
      CEjLog01Field.end_rec_flg : this.end_rec_flg,
      CEjLog01Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog01Field.cshr_no : this.cshr_no,
      CEjLog01Field.chkr_no : this.chkr_no,
      CEjLog01Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog01Field.sale_date : this.sale_date,
      CEjLog01Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog01Field.print_data : this.print_data,
      CEjLog01Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog01Field.trankey_search : this.trankey_search,
      CEjLog01Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_01 実績ジャーナルデータログ01のフィールド名設定用クラス
class CEjLog01Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_02  実績ジャーナルデータログ02
/// c_ej_log_02 実績ジャーナルデータログ02クラス
class CEjLog02Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_02";

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
      CEjLog02Columns rn = CEjLog02Columns();
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
    CEjLog02Columns rn = CEjLog02Columns();
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
      CEjLog02Field.serial_no : this.serial_no,
      CEjLog02Field.comp_cd : this.comp_cd,
      CEjLog02Field.stre_cd : this.stre_cd,
      CEjLog02Field.mac_no : this.mac_no,
      CEjLog02Field.print_no : this.print_no,
      CEjLog02Field.seq_no : this.seq_no,
      CEjLog02Field.receipt_no : this.receipt_no,
      CEjLog02Field.end_rec_flg : this.end_rec_flg,
      CEjLog02Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog02Field.cshr_no : this.cshr_no,
      CEjLog02Field.chkr_no : this.chkr_no,
      CEjLog02Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog02Field.sale_date : this.sale_date,
      CEjLog02Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog02Field.print_data : this.print_data,
      CEjLog02Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog02Field.trankey_search : this.trankey_search,
      CEjLog02Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_02 実績ジャーナルデータログ02のフィールド名設定用クラス
class CEjLog02Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_03  実績ジャーナルデータログ03
/// c_ej_log_03 実績ジャーナルデータログ03クラス
class CEjLog03Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_03";

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
      CEjLog03Columns rn = CEjLog03Columns();
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
    CEjLog03Columns rn = CEjLog03Columns();
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
      CEjLog03Field.serial_no : this.serial_no,
      CEjLog03Field.comp_cd : this.comp_cd,
      CEjLog03Field.stre_cd : this.stre_cd,
      CEjLog03Field.mac_no : this.mac_no,
      CEjLog03Field.print_no : this.print_no,
      CEjLog03Field.seq_no : this.seq_no,
      CEjLog03Field.receipt_no : this.receipt_no,
      CEjLog03Field.end_rec_flg : this.end_rec_flg,
      CEjLog03Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog03Field.cshr_no : this.cshr_no,
      CEjLog03Field.chkr_no : this.chkr_no,
      CEjLog03Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog03Field.sale_date : this.sale_date,
      CEjLog03Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog03Field.print_data : this.print_data,
      CEjLog03Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog03Field.trankey_search : this.trankey_search,
      CEjLog03Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_03 実績ジャーナルデータログ03のフィールド名設定用クラス
class CEjLog03Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_04  実績ジャーナルデータログ04
/// c_ej_log_04 実績ジャーナルデータログ04クラス
class CEjLog04Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_04";

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
      CEjLog04Columns rn = CEjLog04Columns();
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
    CEjLog04Columns rn = CEjLog04Columns();
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
      CEjLog04Field.serial_no : this.serial_no,
      CEjLog04Field.comp_cd : this.comp_cd,
      CEjLog04Field.stre_cd : this.stre_cd,
      CEjLog04Field.mac_no : this.mac_no,
      CEjLog04Field.print_no : this.print_no,
      CEjLog04Field.seq_no : this.seq_no,
      CEjLog04Field.receipt_no : this.receipt_no,
      CEjLog04Field.end_rec_flg : this.end_rec_flg,
      CEjLog04Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog04Field.cshr_no : this.cshr_no,
      CEjLog04Field.chkr_no : this.chkr_no,
      CEjLog04Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog04Field.sale_date : this.sale_date,
      CEjLog04Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog04Field.print_data : this.print_data,
      CEjLog04Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog04Field.trankey_search : this.trankey_search,
      CEjLog04Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_04 実績ジャーナルデータログ04のフィールド名設定用クラス
class CEjLog04Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_05  実績ジャーナルデータログ05
/// c_ej_log_05 実績ジャーナルデータログ05クラス
class CEjLog05Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_05";

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
      CEjLog05Columns rn = CEjLog05Columns();
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
    CEjLog05Columns rn = CEjLog05Columns();
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
      CEjLog05Field.serial_no : this.serial_no,
      CEjLog05Field.comp_cd : this.comp_cd,
      CEjLog05Field.stre_cd : this.stre_cd,
      CEjLog05Field.mac_no : this.mac_no,
      CEjLog05Field.print_no : this.print_no,
      CEjLog05Field.seq_no : this.seq_no,
      CEjLog05Field.receipt_no : this.receipt_no,
      CEjLog05Field.end_rec_flg : this.end_rec_flg,
      CEjLog05Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog05Field.cshr_no : this.cshr_no,
      CEjLog05Field.chkr_no : this.chkr_no,
      CEjLog05Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog05Field.sale_date : this.sale_date,
      CEjLog05Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog05Field.print_data : this.print_data,
      CEjLog05Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog05Field.trankey_search : this.trankey_search,
      CEjLog05Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_05 実績ジャーナルデータログ05のフィールド名設定用クラス
class CEjLog05Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_06  実績ジャーナルデータログ06
/// c_ej_log_06 実績ジャーナルデータログ06クラス
class CEjLog06Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_06";

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
      CEjLog06Columns rn = CEjLog06Columns();
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
    CEjLog06Columns rn = CEjLog06Columns();
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
      CEjLog06Field.serial_no : this.serial_no,
      CEjLog06Field.comp_cd : this.comp_cd,
      CEjLog06Field.stre_cd : this.stre_cd,
      CEjLog06Field.mac_no : this.mac_no,
      CEjLog06Field.print_no : this.print_no,
      CEjLog06Field.seq_no : this.seq_no,
      CEjLog06Field.receipt_no : this.receipt_no,
      CEjLog06Field.end_rec_flg : this.end_rec_flg,
      CEjLog06Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog06Field.cshr_no : this.cshr_no,
      CEjLog06Field.chkr_no : this.chkr_no,
      CEjLog06Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog06Field.sale_date : this.sale_date,
      CEjLog06Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog06Field.print_data : this.print_data,
      CEjLog06Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog06Field.trankey_search : this.trankey_search,
      CEjLog06Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_06 実績ジャーナルデータログ06のフィールド名設定用クラス
class CEjLog06Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_07  実績ジャーナルデータログ07
/// c_ej_log_07 実績ジャーナルデータログ07クラス
class CEjLog07Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_07";

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
      CEjLog07Columns rn = CEjLog07Columns();
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
    CEjLog07Columns rn = CEjLog07Columns();
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
      CEjLog07Field.serial_no : this.serial_no,
      CEjLog07Field.comp_cd : this.comp_cd,
      CEjLog07Field.stre_cd : this.stre_cd,
      CEjLog07Field.mac_no : this.mac_no,
      CEjLog07Field.print_no : this.print_no,
      CEjLog07Field.seq_no : this.seq_no,
      CEjLog07Field.receipt_no : this.receipt_no,
      CEjLog07Field.end_rec_flg : this.end_rec_flg,
      CEjLog07Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog07Field.cshr_no : this.cshr_no,
      CEjLog07Field.chkr_no : this.chkr_no,
      CEjLog07Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog07Field.sale_date : this.sale_date,
      CEjLog07Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog07Field.print_data : this.print_data,
      CEjLog07Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog07Field.trankey_search : this.trankey_search,
      CEjLog07Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_07 実績ジャーナルデータログ07のフィールド名設定用クラス
class CEjLog07Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_08  実績ジャーナルデータログ08
/// c_ej_log_08 実績ジャーナルデータログ08クラス
class CEjLog08Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_08";

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
      CEjLog08Columns rn = CEjLog08Columns();
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
    CEjLog08Columns rn = CEjLog08Columns();
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
      CEjLog08Field.serial_no : this.serial_no,
      CEjLog08Field.comp_cd : this.comp_cd,
      CEjLog08Field.stre_cd : this.stre_cd,
      CEjLog08Field.mac_no : this.mac_no,
      CEjLog08Field.print_no : this.print_no,
      CEjLog08Field.seq_no : this.seq_no,
      CEjLog08Field.receipt_no : this.receipt_no,
      CEjLog08Field.end_rec_flg : this.end_rec_flg,
      CEjLog08Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog08Field.cshr_no : this.cshr_no,
      CEjLog08Field.chkr_no : this.chkr_no,
      CEjLog08Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog08Field.sale_date : this.sale_date,
      CEjLog08Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog08Field.print_data : this.print_data,
      CEjLog08Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog08Field.trankey_search : this.trankey_search,
      CEjLog08Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_08 実績ジャーナルデータログ08のフィールド名設定用クラス
class CEjLog08Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_09  実績ジャーナルデータログ09
/// c_ej_log_09 実績ジャーナルデータログ09クラス
class CEjLog09Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_09";

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
      CEjLog09Columns rn = CEjLog09Columns();
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
    CEjLog09Columns rn = CEjLog09Columns();
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
      CEjLog09Field.serial_no : this.serial_no,
      CEjLog09Field.comp_cd : this.comp_cd,
      CEjLog09Field.stre_cd : this.stre_cd,
      CEjLog09Field.mac_no : this.mac_no,
      CEjLog09Field.print_no : this.print_no,
      CEjLog09Field.seq_no : this.seq_no,
      CEjLog09Field.receipt_no : this.receipt_no,
      CEjLog09Field.end_rec_flg : this.end_rec_flg,
      CEjLog09Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog09Field.cshr_no : this.cshr_no,
      CEjLog09Field.chkr_no : this.chkr_no,
      CEjLog09Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog09Field.sale_date : this.sale_date,
      CEjLog09Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog09Field.print_data : this.print_data,
      CEjLog09Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog09Field.trankey_search : this.trankey_search,
      CEjLog09Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_09 実績ジャーナルデータログ09のフィールド名設定用クラス
class CEjLog09Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_10  実績ジャーナルデータログ10
/// c_ej_log_10 実績ジャーナルデータログ10クラス
class CEjLog10Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_10";

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
      CEjLog10Columns rn = CEjLog10Columns();
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
    CEjLog10Columns rn = CEjLog10Columns();
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
      CEjLog10Field.serial_no : this.serial_no,
      CEjLog10Field.comp_cd : this.comp_cd,
      CEjLog10Field.stre_cd : this.stre_cd,
      CEjLog10Field.mac_no : this.mac_no,
      CEjLog10Field.print_no : this.print_no,
      CEjLog10Field.seq_no : this.seq_no,
      CEjLog10Field.receipt_no : this.receipt_no,
      CEjLog10Field.end_rec_flg : this.end_rec_flg,
      CEjLog10Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog10Field.cshr_no : this.cshr_no,
      CEjLog10Field.chkr_no : this.chkr_no,
      CEjLog10Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog10Field.sale_date : this.sale_date,
      CEjLog10Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog10Field.print_data : this.print_data,
      CEjLog10Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog10Field.trankey_search : this.trankey_search,
      CEjLog10Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_10 実績ジャーナルデータログ10のフィールド名設定用クラス
class CEjLog10Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_11  実績ジャーナルデータログ11
/// c_ej_log_11 実績ジャーナルデータログ11クラス
class CEjLog11Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_11";

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
      CEjLog11Columns rn = CEjLog11Columns();
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
    CEjLog11Columns rn = CEjLog11Columns();
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
      CEjLog11Field.serial_no : this.serial_no,
      CEjLog11Field.comp_cd : this.comp_cd,
      CEjLog11Field.stre_cd : this.stre_cd,
      CEjLog11Field.mac_no : this.mac_no,
      CEjLog11Field.print_no : this.print_no,
      CEjLog11Field.seq_no : this.seq_no,
      CEjLog11Field.receipt_no : this.receipt_no,
      CEjLog11Field.end_rec_flg : this.end_rec_flg,
      CEjLog11Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog11Field.cshr_no : this.cshr_no,
      CEjLog11Field.chkr_no : this.chkr_no,
      CEjLog11Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog11Field.sale_date : this.sale_date,
      CEjLog11Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog11Field.print_data : this.print_data,
      CEjLog11Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog11Field.trankey_search : this.trankey_search,
      CEjLog11Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_11 実績ジャーナルデータログ11のフィールド名設定用クラス
class CEjLog11Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_12  実績ジャーナルデータログ12
/// c_ej_log_12 実績ジャーナルデータログ12クラス
class CEjLog12Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_12";

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
      CEjLog12Columns rn = CEjLog12Columns();
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
    CEjLog12Columns rn = CEjLog12Columns();
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
      CEjLog12Field.serial_no : this.serial_no,
      CEjLog12Field.comp_cd : this.comp_cd,
      CEjLog12Field.stre_cd : this.stre_cd,
      CEjLog12Field.mac_no : this.mac_no,
      CEjLog12Field.print_no : this.print_no,
      CEjLog12Field.seq_no : this.seq_no,
      CEjLog12Field.receipt_no : this.receipt_no,
      CEjLog12Field.end_rec_flg : this.end_rec_flg,
      CEjLog12Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog12Field.cshr_no : this.cshr_no,
      CEjLog12Field.chkr_no : this.chkr_no,
      CEjLog12Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog12Field.sale_date : this.sale_date,
      CEjLog12Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog12Field.print_data : this.print_data,
      CEjLog12Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog12Field.trankey_search : this.trankey_search,
      CEjLog12Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_12 実績ジャーナルデータログ12のフィールド名設定用クラス
class CEjLog12Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_13  実績ジャーナルデータログ13
/// c_ej_log_13 実績ジャーナルデータログ13クラス
class CEjLog13Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_13";

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
      CEjLog13Columns rn = CEjLog13Columns();
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
    CEjLog13Columns rn = CEjLog13Columns();
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
      CEjLog13Field.serial_no : this.serial_no,
      CEjLog13Field.comp_cd : this.comp_cd,
      CEjLog13Field.stre_cd : this.stre_cd,
      CEjLog13Field.mac_no : this.mac_no,
      CEjLog13Field.print_no : this.print_no,
      CEjLog13Field.seq_no : this.seq_no,
      CEjLog13Field.receipt_no : this.receipt_no,
      CEjLog13Field.end_rec_flg : this.end_rec_flg,
      CEjLog13Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog13Field.cshr_no : this.cshr_no,
      CEjLog13Field.chkr_no : this.chkr_no,
      CEjLog13Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog13Field.sale_date : this.sale_date,
      CEjLog13Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog13Field.print_data : this.print_data,
      CEjLog13Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog13Field.trankey_search : this.trankey_search,
      CEjLog13Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_13 実績ジャーナルデータログ13のフィールド名設定用クラス
class CEjLog13Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_14  実績ジャーナルデータログ14
/// c_ej_log_14 実績ジャーナルデータログ14クラス
class CEjLog14Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_14";

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
      CEjLog14Columns rn = CEjLog14Columns();
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
    CEjLog14Columns rn = CEjLog14Columns();
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
      CEjLog14Field.serial_no : this.serial_no,
      CEjLog14Field.comp_cd : this.comp_cd,
      CEjLog14Field.stre_cd : this.stre_cd,
      CEjLog14Field.mac_no : this.mac_no,
      CEjLog14Field.print_no : this.print_no,
      CEjLog14Field.seq_no : this.seq_no,
      CEjLog14Field.receipt_no : this.receipt_no,
      CEjLog14Field.end_rec_flg : this.end_rec_flg,
      CEjLog14Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog14Field.cshr_no : this.cshr_no,
      CEjLog14Field.chkr_no : this.chkr_no,
      CEjLog14Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog14Field.sale_date : this.sale_date,
      CEjLog14Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog14Field.print_data : this.print_data,
      CEjLog14Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog14Field.trankey_search : this.trankey_search,
      CEjLog14Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_14 実績ジャーナルデータログ14のフィールド名設定用クラス
class CEjLog14Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_15  実績ジャーナルデータログ15
/// c_ej_log_15 実績ジャーナルデータログ15クラス
class CEjLog15Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_15";

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
      CEjLog15Columns rn = CEjLog15Columns();
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
    CEjLog15Columns rn = CEjLog15Columns();
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
      CEjLog15Field.serial_no : this.serial_no,
      CEjLog15Field.comp_cd : this.comp_cd,
      CEjLog15Field.stre_cd : this.stre_cd,
      CEjLog15Field.mac_no : this.mac_no,
      CEjLog15Field.print_no : this.print_no,
      CEjLog15Field.seq_no : this.seq_no,
      CEjLog15Field.receipt_no : this.receipt_no,
      CEjLog15Field.end_rec_flg : this.end_rec_flg,
      CEjLog15Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog15Field.cshr_no : this.cshr_no,
      CEjLog15Field.chkr_no : this.chkr_no,
      CEjLog15Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog15Field.sale_date : this.sale_date,
      CEjLog15Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog15Field.print_data : this.print_data,
      CEjLog15Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog15Field.trankey_search : this.trankey_search,
      CEjLog15Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_15 実績ジャーナルデータログ15のフィールド名設定用クラス
class CEjLog15Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_16  実績ジャーナルデータログ16
/// c_ej_log_16 実績ジャーナルデータログ16クラス
class CEjLog16Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_16";

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
      CEjLog16Columns rn = CEjLog16Columns();
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
    CEjLog16Columns rn = CEjLog16Columns();
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
      CEjLog16Field.serial_no : this.serial_no,
      CEjLog16Field.comp_cd : this.comp_cd,
      CEjLog16Field.stre_cd : this.stre_cd,
      CEjLog16Field.mac_no : this.mac_no,
      CEjLog16Field.print_no : this.print_no,
      CEjLog16Field.seq_no : this.seq_no,
      CEjLog16Field.receipt_no : this.receipt_no,
      CEjLog16Field.end_rec_flg : this.end_rec_flg,
      CEjLog16Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog16Field.cshr_no : this.cshr_no,
      CEjLog16Field.chkr_no : this.chkr_no,
      CEjLog16Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog16Field.sale_date : this.sale_date,
      CEjLog16Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog16Field.print_data : this.print_data,
      CEjLog16Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog16Field.trankey_search : this.trankey_search,
      CEjLog16Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_16 実績ジャーナルデータログ16のフィールド名設定用クラス
class CEjLog16Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_17  実績ジャーナルデータログ17
/// c_ej_log_17 実績ジャーナルデータログ17クラス
class CEjLog17Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_17";

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
      CEjLog17Columns rn = CEjLog17Columns();
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
    CEjLog17Columns rn = CEjLog17Columns();
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
      CEjLog17Field.serial_no : this.serial_no,
      CEjLog17Field.comp_cd : this.comp_cd,
      CEjLog17Field.stre_cd : this.stre_cd,
      CEjLog17Field.mac_no : this.mac_no,
      CEjLog17Field.print_no : this.print_no,
      CEjLog17Field.seq_no : this.seq_no,
      CEjLog17Field.receipt_no : this.receipt_no,
      CEjLog17Field.end_rec_flg : this.end_rec_flg,
      CEjLog17Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog17Field.cshr_no : this.cshr_no,
      CEjLog17Field.chkr_no : this.chkr_no,
      CEjLog17Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog17Field.sale_date : this.sale_date,
      CEjLog17Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog17Field.print_data : this.print_data,
      CEjLog17Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog17Field.trankey_search : this.trankey_search,
      CEjLog17Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_17 実績ジャーナルデータログ17のフィールド名設定用クラス
class CEjLog17Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_18  実績ジャーナルデータログ18
/// c_ej_log_18 実績ジャーナルデータログ18クラス
class CEjLog18Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_18";

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
      CEjLog18Columns rn = CEjLog18Columns();
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
    CEjLog18Columns rn = CEjLog18Columns();
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
      CEjLog18Field.serial_no : this.serial_no,
      CEjLog18Field.comp_cd : this.comp_cd,
      CEjLog18Field.stre_cd : this.stre_cd,
      CEjLog18Field.mac_no : this.mac_no,
      CEjLog18Field.print_no : this.print_no,
      CEjLog18Field.seq_no : this.seq_no,
      CEjLog18Field.receipt_no : this.receipt_no,
      CEjLog18Field.end_rec_flg : this.end_rec_flg,
      CEjLog18Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog18Field.cshr_no : this.cshr_no,
      CEjLog18Field.chkr_no : this.chkr_no,
      CEjLog18Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog18Field.sale_date : this.sale_date,
      CEjLog18Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog18Field.print_data : this.print_data,
      CEjLog18Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog18Field.trankey_search : this.trankey_search,
      CEjLog18Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_18 実績ジャーナルデータログ18のフィールド名設定用クラス
class CEjLog18Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_19  実績ジャーナルデータログ19
/// c_ej_log_19 実績ジャーナルデータログ19クラス
class CEjLog19Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_19";

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
      CEjLog19Columns rn = CEjLog19Columns();
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
    CEjLog19Columns rn = CEjLog19Columns();
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
      CEjLog19Field.serial_no : this.serial_no,
      CEjLog19Field.comp_cd : this.comp_cd,
      CEjLog19Field.stre_cd : this.stre_cd,
      CEjLog19Field.mac_no : this.mac_no,
      CEjLog19Field.print_no : this.print_no,
      CEjLog19Field.seq_no : this.seq_no,
      CEjLog19Field.receipt_no : this.receipt_no,
      CEjLog19Field.end_rec_flg : this.end_rec_flg,
      CEjLog19Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog19Field.cshr_no : this.cshr_no,
      CEjLog19Field.chkr_no : this.chkr_no,
      CEjLog19Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog19Field.sale_date : this.sale_date,
      CEjLog19Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog19Field.print_data : this.print_data,
      CEjLog19Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog19Field.trankey_search : this.trankey_search,
      CEjLog19Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_19 実績ジャーナルデータログ19のフィールド名設定用クラス
class CEjLog19Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_20  実績ジャーナルデータログ20
/// c_ej_log_20 実績ジャーナルデータログ20クラス
class CEjLog20Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_20";

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
      CEjLog20Columns rn = CEjLog20Columns();
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
    CEjLog20Columns rn = CEjLog20Columns();
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
      CEjLog20Field.serial_no : this.serial_no,
      CEjLog20Field.comp_cd : this.comp_cd,
      CEjLog20Field.stre_cd : this.stre_cd,
      CEjLog20Field.mac_no : this.mac_no,
      CEjLog20Field.print_no : this.print_no,
      CEjLog20Field.seq_no : this.seq_no,
      CEjLog20Field.receipt_no : this.receipt_no,
      CEjLog20Field.end_rec_flg : this.end_rec_flg,
      CEjLog20Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog20Field.cshr_no : this.cshr_no,
      CEjLog20Field.chkr_no : this.chkr_no,
      CEjLog20Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog20Field.sale_date : this.sale_date,
      CEjLog20Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog20Field.print_data : this.print_data,
      CEjLog20Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog20Field.trankey_search : this.trankey_search,
      CEjLog20Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_20 実績ジャーナルデータログ20のフィールド名設定用クラス
class CEjLog20Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_21  実績ジャーナルデータログ21
/// c_ej_log_21 実績ジャーナルデータログ21クラス
class CEjLog21Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_21";

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
      CEjLog21Columns rn = CEjLog21Columns();
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
    CEjLog21Columns rn = CEjLog21Columns();
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
      CEjLog21Field.serial_no : this.serial_no,
      CEjLog21Field.comp_cd : this.comp_cd,
      CEjLog21Field.stre_cd : this.stre_cd,
      CEjLog21Field.mac_no : this.mac_no,
      CEjLog21Field.print_no : this.print_no,
      CEjLog21Field.seq_no : this.seq_no,
      CEjLog21Field.receipt_no : this.receipt_no,
      CEjLog21Field.end_rec_flg : this.end_rec_flg,
      CEjLog21Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog21Field.cshr_no : this.cshr_no,
      CEjLog21Field.chkr_no : this.chkr_no,
      CEjLog21Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog21Field.sale_date : this.sale_date,
      CEjLog21Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog21Field.print_data : this.print_data,
      CEjLog21Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog21Field.trankey_search : this.trankey_search,
      CEjLog21Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_21 実績ジャーナルデータログ21のフィールド名設定用クラス
class CEjLog21Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_22  実績ジャーナルデータログ22
/// c_ej_log_22 実績ジャーナルデータログ22クラス
class CEjLog22Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_22";

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
      CEjLog22Columns rn = CEjLog22Columns();
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
    CEjLog22Columns rn = CEjLog22Columns();
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
      CEjLog22Field.serial_no : this.serial_no,
      CEjLog22Field.comp_cd : this.comp_cd,
      CEjLog22Field.stre_cd : this.stre_cd,
      CEjLog22Field.mac_no : this.mac_no,
      CEjLog22Field.print_no : this.print_no,
      CEjLog22Field.seq_no : this.seq_no,
      CEjLog22Field.receipt_no : this.receipt_no,
      CEjLog22Field.end_rec_flg : this.end_rec_flg,
      CEjLog22Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog22Field.cshr_no : this.cshr_no,
      CEjLog22Field.chkr_no : this.chkr_no,
      CEjLog22Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog22Field.sale_date : this.sale_date,
      CEjLog22Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog22Field.print_data : this.print_data,
      CEjLog22Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog22Field.trankey_search : this.trankey_search,
      CEjLog22Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_22 実績ジャーナルデータログ22のフィールド名設定用クラス
class CEjLog22Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_23  実績ジャーナルデータログ23
/// c_ej_log_23 実績ジャーナルデータログ23クラス
class CEjLog23Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_23";

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
      CEjLog23Columns rn = CEjLog23Columns();
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
    CEjLog23Columns rn = CEjLog23Columns();
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
      CEjLog23Field.serial_no : this.serial_no,
      CEjLog23Field.comp_cd : this.comp_cd,
      CEjLog23Field.stre_cd : this.stre_cd,
      CEjLog23Field.mac_no : this.mac_no,
      CEjLog23Field.print_no : this.print_no,
      CEjLog23Field.seq_no : this.seq_no,
      CEjLog23Field.receipt_no : this.receipt_no,
      CEjLog23Field.end_rec_flg : this.end_rec_flg,
      CEjLog23Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog23Field.cshr_no : this.cshr_no,
      CEjLog23Field.chkr_no : this.chkr_no,
      CEjLog23Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog23Field.sale_date : this.sale_date,
      CEjLog23Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog23Field.print_data : this.print_data,
      CEjLog23Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog23Field.trankey_search : this.trankey_search,
      CEjLog23Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_23 実績ジャーナルデータログ23のフィールド名設定用クラス
class CEjLog23Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_24  実績ジャーナルデータログ24
/// c_ej_log_24 実績ジャーナルデータログ24クラス
class CEjLog24Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_24";

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
      CEjLog24Columns rn = CEjLog24Columns();
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
    CEjLog24Columns rn = CEjLog24Columns();
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
      CEjLog24Field.serial_no : this.serial_no,
      CEjLog24Field.comp_cd : this.comp_cd,
      CEjLog24Field.stre_cd : this.stre_cd,
      CEjLog24Field.mac_no : this.mac_no,
      CEjLog24Field.print_no : this.print_no,
      CEjLog24Field.seq_no : this.seq_no,
      CEjLog24Field.receipt_no : this.receipt_no,
      CEjLog24Field.end_rec_flg : this.end_rec_flg,
      CEjLog24Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog24Field.cshr_no : this.cshr_no,
      CEjLog24Field.chkr_no : this.chkr_no,
      CEjLog24Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog24Field.sale_date : this.sale_date,
      CEjLog24Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog24Field.print_data : this.print_data,
      CEjLog24Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog24Field.trankey_search : this.trankey_search,
      CEjLog24Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_24 実績ジャーナルデータログ24のフィールド名設定用クラス
class CEjLog24Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_25  実績ジャーナルデータログ25
/// c_ej_log_25 実績ジャーナルデータログ25クラス
class CEjLog25Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_25";

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
      CEjLog25Columns rn = CEjLog25Columns();
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
    CEjLog25Columns rn = CEjLog25Columns();
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
      CEjLog25Field.serial_no : this.serial_no,
      CEjLog25Field.comp_cd : this.comp_cd,
      CEjLog25Field.stre_cd : this.stre_cd,
      CEjLog25Field.mac_no : this.mac_no,
      CEjLog25Field.print_no : this.print_no,
      CEjLog25Field.seq_no : this.seq_no,
      CEjLog25Field.receipt_no : this.receipt_no,
      CEjLog25Field.end_rec_flg : this.end_rec_flg,
      CEjLog25Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog25Field.cshr_no : this.cshr_no,
      CEjLog25Field.chkr_no : this.chkr_no,
      CEjLog25Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog25Field.sale_date : this.sale_date,
      CEjLog25Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog25Field.print_data : this.print_data,
      CEjLog25Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog25Field.trankey_search : this.trankey_search,
      CEjLog25Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_25 実績ジャーナルデータログ25のフィールド名設定用クラス
class CEjLog25Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_26  実績ジャーナルデータログ26
/// c_ej_log_26 実績ジャーナルデータログ26クラス
class CEjLog26Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_26";

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
      CEjLog26Columns rn = CEjLog26Columns();
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
    CEjLog26Columns rn = CEjLog26Columns();
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
      CEjLog26Field.serial_no : this.serial_no,
      CEjLog26Field.comp_cd : this.comp_cd,
      CEjLog26Field.stre_cd : this.stre_cd,
      CEjLog26Field.mac_no : this.mac_no,
      CEjLog26Field.print_no : this.print_no,
      CEjLog26Field.seq_no : this.seq_no,
      CEjLog26Field.receipt_no : this.receipt_no,
      CEjLog26Field.end_rec_flg : this.end_rec_flg,
      CEjLog26Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog26Field.cshr_no : this.cshr_no,
      CEjLog26Field.chkr_no : this.chkr_no,
      CEjLog26Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog26Field.sale_date : this.sale_date,
      CEjLog26Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog26Field.print_data : this.print_data,
      CEjLog26Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog26Field.trankey_search : this.trankey_search,
      CEjLog26Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_26 実績ジャーナルデータログ26のフィールド名設定用クラス
class CEjLog26Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_27  実績ジャーナルデータログ27
/// c_ej_log_27 実績ジャーナルデータログ27クラス
class CEjLog27Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_27";

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
      CEjLog27Columns rn = CEjLog27Columns();
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
    CEjLog27Columns rn = CEjLog27Columns();
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
      CEjLog27Field.serial_no : this.serial_no,
      CEjLog27Field.comp_cd : this.comp_cd,
      CEjLog27Field.stre_cd : this.stre_cd,
      CEjLog27Field.mac_no : this.mac_no,
      CEjLog27Field.print_no : this.print_no,
      CEjLog27Field.seq_no : this.seq_no,
      CEjLog27Field.receipt_no : this.receipt_no,
      CEjLog27Field.end_rec_flg : this.end_rec_flg,
      CEjLog27Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog27Field.cshr_no : this.cshr_no,
      CEjLog27Field.chkr_no : this.chkr_no,
      CEjLog27Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog27Field.sale_date : this.sale_date,
      CEjLog27Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog27Field.print_data : this.print_data,
      CEjLog27Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog27Field.trankey_search : this.trankey_search,
      CEjLog27Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_27 実績ジャーナルデータログ27のフィールド名設定用クラス
class CEjLog27Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_28  実績ジャーナルデータログ28
/// c_ej_log_28 実績ジャーナルデータログ28クラス
class CEjLog28Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_28";

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
      CEjLog28Columns rn = CEjLog28Columns();
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
    CEjLog28Columns rn = CEjLog28Columns();
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
      CEjLog28Field.serial_no : this.serial_no,
      CEjLog28Field.comp_cd : this.comp_cd,
      CEjLog28Field.stre_cd : this.stre_cd,
      CEjLog28Field.mac_no : this.mac_no,
      CEjLog28Field.print_no : this.print_no,
      CEjLog28Field.seq_no : this.seq_no,
      CEjLog28Field.receipt_no : this.receipt_no,
      CEjLog28Field.end_rec_flg : this.end_rec_flg,
      CEjLog28Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog28Field.cshr_no : this.cshr_no,
      CEjLog28Field.chkr_no : this.chkr_no,
      CEjLog28Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog28Field.sale_date : this.sale_date,
      CEjLog28Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog28Field.print_data : this.print_data,
      CEjLog28Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog28Field.trankey_search : this.trankey_search,
      CEjLog28Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_28 実績ジャーナルデータログ28のフィールド名設定用クラス
class CEjLog28Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_29  実績ジャーナルデータログ29
/// c_ej_log_29 実績ジャーナルデータログ29クラス
class CEjLog29Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_29";

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
      CEjLog29Columns rn = CEjLog29Columns();
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
    CEjLog29Columns rn = CEjLog29Columns();
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
      CEjLog29Field.serial_no : this.serial_no,
      CEjLog29Field.comp_cd : this.comp_cd,
      CEjLog29Field.stre_cd : this.stre_cd,
      CEjLog29Field.mac_no : this.mac_no,
      CEjLog29Field.print_no : this.print_no,
      CEjLog29Field.seq_no : this.seq_no,
      CEjLog29Field.receipt_no : this.receipt_no,
      CEjLog29Field.end_rec_flg : this.end_rec_flg,
      CEjLog29Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog29Field.cshr_no : this.cshr_no,
      CEjLog29Field.chkr_no : this.chkr_no,
      CEjLog29Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog29Field.sale_date : this.sale_date,
      CEjLog29Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog29Field.print_data : this.print_data,
      CEjLog29Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog29Field.trankey_search : this.trankey_search,
      CEjLog29Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_29 実績ジャーナルデータログ29のフィールド名設定用クラス
class CEjLog29Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_30  実績ジャーナルデータログ30
/// c_ej_log_30 実績ジャーナルデータログ30クラス
class CEjLog30Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_30";

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
      CEjLog30Columns rn = CEjLog30Columns();
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
    CEjLog30Columns rn = CEjLog30Columns();
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
      CEjLog30Field.serial_no : this.serial_no,
      CEjLog30Field.comp_cd : this.comp_cd,
      CEjLog30Field.stre_cd : this.stre_cd,
      CEjLog30Field.mac_no : this.mac_no,
      CEjLog30Field.print_no : this.print_no,
      CEjLog30Field.seq_no : this.seq_no,
      CEjLog30Field.receipt_no : this.receipt_no,
      CEjLog30Field.end_rec_flg : this.end_rec_flg,
      CEjLog30Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog30Field.cshr_no : this.cshr_no,
      CEjLog30Field.chkr_no : this.chkr_no,
      CEjLog30Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog30Field.sale_date : this.sale_date,
      CEjLog30Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog30Field.print_data : this.print_data,
      CEjLog30Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog30Field.trankey_search : this.trankey_search,
      CEjLog30Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_30 実績ジャーナルデータログ30のフィールド名設定用クラス
class CEjLog30Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion
//region c_ej_log_31  実績ジャーナルデータログ31
/// c_ej_log_31 実績ジャーナルデータログ31クラス
class CEjLog31Columns extends TableColumns{
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
  String _getTableName() => "c_ej_log_31";

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
      CEjLog31Columns rn = CEjLog31Columns();
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
    CEjLog31Columns rn = CEjLog31Columns();
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
      CEjLog31Field.serial_no : this.serial_no,
      CEjLog31Field.comp_cd : this.comp_cd,
      CEjLog31Field.stre_cd : this.stre_cd,
      CEjLog31Field.mac_no : this.mac_no,
      CEjLog31Field.print_no : this.print_no,
      CEjLog31Field.seq_no : this.seq_no,
      CEjLog31Field.receipt_no : this.receipt_no,
      CEjLog31Field.end_rec_flg : this.end_rec_flg,
      CEjLog31Field.only_ejlog_flg : this.only_ejlog_flg,
      CEjLog31Field.cshr_no : this.cshr_no,
      CEjLog31Field.chkr_no : this.chkr_no,
      CEjLog31Field.now_sale_datetime : this.now_sale_datetime,
      CEjLog31Field.sale_date : this.sale_date,
      CEjLog31Field.ope_mode_flg : this.ope_mode_flg,
      CEjLog31Field.print_data : this.print_data,
      CEjLog31Field.sub_only_ejlog_flg : this.sub_only_ejlog_flg,
      CEjLog31Field.trankey_search : this.trankey_search,
      CEjLog31Field.etckey_search : this.etckey_search,
    };
  }
}

/// c_ej_log_31 実績ジャーナルデータログ31のフィールド名設定用クラス
class CEjLog31Field {
  static const serial_no = "serial_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const print_no = "print_no";
  static const seq_no = "seq_no";
  static const receipt_no = "receipt_no";
  static const end_rec_flg = "end_rec_flg";
  static const only_ejlog_flg = "only_ejlog_flg";
  static const cshr_no = "cshr_no";
  static const chkr_no = "chkr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const print_data = "print_data";
  static const sub_only_ejlog_flg = "sub_only_ejlog_flg";
  static const trankey_search = "trankey_search";
  static const etckey_search = "etckey_search";
}
//endregion