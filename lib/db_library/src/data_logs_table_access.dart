/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
実績データログ 日付別
c_data_log_01	実績データログ01
c_data_log_02	実績データログ02
c_data_log_03	実績データログ03
c_data_log_04	実績データログ04
c_data_log_05	実績データログ05
c_data_log_06	実績データログ06
c_data_log_07	実績データログ07
c_data_log_08	実績データログ08
c_data_log_09	実績データログ09
c_data_log_10	実績データログ10
c_data_log_11	実績データログ11
c_data_log_12	実績データログ12
c_data_log_13	実績データログ13
c_data_log_14	実績データログ14
c_data_log_15	実績データログ15
c_data_log_16	実績データログ16
c_data_log_17	実績データログ17
c_data_log_18	実績データログ18
c_data_log_19	実績データログ19
c_data_log_20	実績データログ20
c_data_log_21	実績データログ21
c_data_log_22	実績データログ22
c_data_log_23	実績データログ23
c_data_log_24	実績データログ24
c_data_log_25	実績データログ25
c_data_log_26	実績データログ26
c_data_log_27	実績データログ27
c_data_log_28	実績データログ28
c_data_log_29	実績データログ29
c_data_log_30	実績データログ30
c_data_log_31	実績データログ31
c_data_log_reserv	実績データログ予約
c_data_log_reserv_01	実績データログ予約01
 */

//region c_data_log_01  実績データログ01
/// c_data_log_01 実績データログ01クラス
class CDataLog01Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_01";

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
      CDataLog01Columns rn = CDataLog01Columns();
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
    CDataLog01Columns rn = CDataLog01Columns();
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
      CDataLog01Field.serial_no : this.serial_no,
      CDataLog01Field.seq_no : this.seq_no,
      CDataLog01Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog01Field.func_cd : this.func_cd,
      CDataLog01Field.func_seq_no : this.func_seq_no,
      CDataLog01Field.c_data1 : this.c_data1,
      CDataLog01Field.c_data2 : this.c_data2,
      CDataLog01Field.c_data3 : this.c_data3,
      CDataLog01Field.c_data4 : this.c_data4,
      CDataLog01Field.c_data5 : this.c_data5,
      CDataLog01Field.c_data6 : this.c_data6,
      CDataLog01Field.c_data7 : this.c_data7,
      CDataLog01Field.c_data8 : this.c_data8,
      CDataLog01Field.c_data9 : this.c_data9,
      CDataLog01Field.c_data10 : this.c_data10,
      CDataLog01Field.n_data1 : this.n_data1,
      CDataLog01Field.n_data2 : this.n_data2,
      CDataLog01Field.n_data3 : this.n_data3,
      CDataLog01Field.n_data4 : this.n_data4,
      CDataLog01Field.n_data5 : this.n_data5,
      CDataLog01Field.n_data6 : this.n_data6,
      CDataLog01Field.n_data7 : this.n_data7,
      CDataLog01Field.n_data8 : this.n_data8,
      CDataLog01Field.n_data9 : this.n_data9,
      CDataLog01Field.n_data10 : this.n_data10,
      CDataLog01Field.n_data11 : this.n_data11,
      CDataLog01Field.n_data12 : this.n_data12,
      CDataLog01Field.n_data13 : this.n_data13,
      CDataLog01Field.n_data14 : this.n_data14,
      CDataLog01Field.n_data15 : this.n_data15,
      CDataLog01Field.n_data16 : this.n_data16,
      CDataLog01Field.n_data17 : this.n_data17,
      CDataLog01Field.n_data18 : this.n_data18,
      CDataLog01Field.n_data19 : this.n_data19,
      CDataLog01Field.n_data20 : this.n_data20,
      CDataLog01Field.n_data21 : this.n_data21,
      CDataLog01Field.n_data22 : this.n_data22,
      CDataLog01Field.n_data23 : this.n_data23,
      CDataLog01Field.n_data24 : this.n_data24,
      CDataLog01Field.n_data25 : this.n_data25,
      CDataLog01Field.n_data26 : this.n_data26,
      CDataLog01Field.n_data27 : this.n_data27,
      CDataLog01Field.n_data28 : this.n_data28,
      CDataLog01Field.n_data29 : this.n_data29,
      CDataLog01Field.n_data30 : this.n_data30,
      CDataLog01Field.d_data1 : this.d_data1,
      CDataLog01Field.d_data2 : this.d_data2,
      CDataLog01Field.d_data3 : this.d_data3,
      CDataLog01Field.d_data4 : this.d_data4,
      CDataLog01Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_01 実績データログ01のフィールド名設定用クラス
class CDataLog01Field {
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
//region c_data_log_02  実績データログ02
/// c_data_log_02 実績データログ02クラス
class CDataLog02Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_02";

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
      CDataLog02Columns rn = CDataLog02Columns();
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
    CDataLog02Columns rn = CDataLog02Columns();
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
      CDataLog02Field.serial_no : this.serial_no,
      CDataLog02Field.seq_no : this.seq_no,
      CDataLog02Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog02Field.func_cd : this.func_cd,
      CDataLog02Field.func_seq_no : this.func_seq_no,
      CDataLog02Field.c_data1 : this.c_data1,
      CDataLog02Field.c_data2 : this.c_data2,
      CDataLog02Field.c_data3 : this.c_data3,
      CDataLog02Field.c_data4 : this.c_data4,
      CDataLog02Field.c_data5 : this.c_data5,
      CDataLog02Field.c_data6 : this.c_data6,
      CDataLog02Field.c_data7 : this.c_data7,
      CDataLog02Field.c_data8 : this.c_data8,
      CDataLog02Field.c_data9 : this.c_data9,
      CDataLog02Field.c_data10 : this.c_data10,
      CDataLog02Field.n_data1 : this.n_data1,
      CDataLog02Field.n_data2 : this.n_data2,
      CDataLog02Field.n_data3 : this.n_data3,
      CDataLog02Field.n_data4 : this.n_data4,
      CDataLog02Field.n_data5 : this.n_data5,
      CDataLog02Field.n_data6 : this.n_data6,
      CDataLog02Field.n_data7 : this.n_data7,
      CDataLog02Field.n_data8 : this.n_data8,
      CDataLog02Field.n_data9 : this.n_data9,
      CDataLog02Field.n_data10 : this.n_data10,
      CDataLog02Field.n_data11 : this.n_data11,
      CDataLog02Field.n_data12 : this.n_data12,
      CDataLog02Field.n_data13 : this.n_data13,
      CDataLog02Field.n_data14 : this.n_data14,
      CDataLog02Field.n_data15 : this.n_data15,
      CDataLog02Field.n_data16 : this.n_data16,
      CDataLog02Field.n_data17 : this.n_data17,
      CDataLog02Field.n_data18 : this.n_data18,
      CDataLog02Field.n_data19 : this.n_data19,
      CDataLog02Field.n_data20 : this.n_data20,
      CDataLog02Field.n_data21 : this.n_data21,
      CDataLog02Field.n_data22 : this.n_data22,
      CDataLog02Field.n_data23 : this.n_data23,
      CDataLog02Field.n_data24 : this.n_data24,
      CDataLog02Field.n_data25 : this.n_data25,
      CDataLog02Field.n_data26 : this.n_data26,
      CDataLog02Field.n_data27 : this.n_data27,
      CDataLog02Field.n_data28 : this.n_data28,
      CDataLog02Field.n_data29 : this.n_data29,
      CDataLog02Field.n_data30 : this.n_data30,
      CDataLog02Field.d_data1 : this.d_data1,
      CDataLog02Field.d_data2 : this.d_data2,
      CDataLog02Field.d_data3 : this.d_data3,
      CDataLog02Field.d_data4 : this.d_data4,
      CDataLog02Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_02 実績データログ02のフィールド名設定用クラス
class CDataLog02Field {
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
//region c_data_log_03  実績データログ03
/// c_data_log_03 実績データログ03クラス
class CDataLog03Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_03";

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
      CDataLog03Columns rn = CDataLog03Columns();
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
    CDataLog03Columns rn = CDataLog03Columns();
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
      CDataLog03Field.serial_no : this.serial_no,
      CDataLog03Field.seq_no : this.seq_no,
      CDataLog03Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog03Field.func_cd : this.func_cd,
      CDataLog03Field.func_seq_no : this.func_seq_no,
      CDataLog03Field.c_data1 : this.c_data1,
      CDataLog03Field.c_data2 : this.c_data2,
      CDataLog03Field.c_data3 : this.c_data3,
      CDataLog03Field.c_data4 : this.c_data4,
      CDataLog03Field.c_data5 : this.c_data5,
      CDataLog03Field.c_data6 : this.c_data6,
      CDataLog03Field.c_data7 : this.c_data7,
      CDataLog03Field.c_data8 : this.c_data8,
      CDataLog03Field.c_data9 : this.c_data9,
      CDataLog03Field.c_data10 : this.c_data10,
      CDataLog03Field.n_data1 : this.n_data1,
      CDataLog03Field.n_data2 : this.n_data2,
      CDataLog03Field.n_data3 : this.n_data3,
      CDataLog03Field.n_data4 : this.n_data4,
      CDataLog03Field.n_data5 : this.n_data5,
      CDataLog03Field.n_data6 : this.n_data6,
      CDataLog03Field.n_data7 : this.n_data7,
      CDataLog03Field.n_data8 : this.n_data8,
      CDataLog03Field.n_data9 : this.n_data9,
      CDataLog03Field.n_data10 : this.n_data10,
      CDataLog03Field.n_data11 : this.n_data11,
      CDataLog03Field.n_data12 : this.n_data12,
      CDataLog03Field.n_data13 : this.n_data13,
      CDataLog03Field.n_data14 : this.n_data14,
      CDataLog03Field.n_data15 : this.n_data15,
      CDataLog03Field.n_data16 : this.n_data16,
      CDataLog03Field.n_data17 : this.n_data17,
      CDataLog03Field.n_data18 : this.n_data18,
      CDataLog03Field.n_data19 : this.n_data19,
      CDataLog03Field.n_data20 : this.n_data20,
      CDataLog03Field.n_data21 : this.n_data21,
      CDataLog03Field.n_data22 : this.n_data22,
      CDataLog03Field.n_data23 : this.n_data23,
      CDataLog03Field.n_data24 : this.n_data24,
      CDataLog03Field.n_data25 : this.n_data25,
      CDataLog03Field.n_data26 : this.n_data26,
      CDataLog03Field.n_data27 : this.n_data27,
      CDataLog03Field.n_data28 : this.n_data28,
      CDataLog03Field.n_data29 : this.n_data29,
      CDataLog03Field.n_data30 : this.n_data30,
      CDataLog03Field.d_data1 : this.d_data1,
      CDataLog03Field.d_data2 : this.d_data2,
      CDataLog03Field.d_data3 : this.d_data3,
      CDataLog03Field.d_data4 : this.d_data4,
      CDataLog03Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_03 実績データログ03のフィールド名設定用クラス
class CDataLog03Field {
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
//region c_data_log_04  実績データログ04
/// c_data_log_04 実績データログ04クラス
class CDataLog04Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_04";

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
      CDataLog04Columns rn = CDataLog04Columns();
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
    CDataLog04Columns rn = CDataLog04Columns();
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
      CDataLog04Field.serial_no : this.serial_no,
      CDataLog04Field.seq_no : this.seq_no,
      CDataLog04Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog04Field.func_cd : this.func_cd,
      CDataLog04Field.func_seq_no : this.func_seq_no,
      CDataLog04Field.c_data1 : this.c_data1,
      CDataLog04Field.c_data2 : this.c_data2,
      CDataLog04Field.c_data3 : this.c_data3,
      CDataLog04Field.c_data4 : this.c_data4,
      CDataLog04Field.c_data5 : this.c_data5,
      CDataLog04Field.c_data6 : this.c_data6,
      CDataLog04Field.c_data7 : this.c_data7,
      CDataLog04Field.c_data8 : this.c_data8,
      CDataLog04Field.c_data9 : this.c_data9,
      CDataLog04Field.c_data10 : this.c_data10,
      CDataLog04Field.n_data1 : this.n_data1,
      CDataLog04Field.n_data2 : this.n_data2,
      CDataLog04Field.n_data3 : this.n_data3,
      CDataLog04Field.n_data4 : this.n_data4,
      CDataLog04Field.n_data5 : this.n_data5,
      CDataLog04Field.n_data6 : this.n_data6,
      CDataLog04Field.n_data7 : this.n_data7,
      CDataLog04Field.n_data8 : this.n_data8,
      CDataLog04Field.n_data9 : this.n_data9,
      CDataLog04Field.n_data10 : this.n_data10,
      CDataLog04Field.n_data11 : this.n_data11,
      CDataLog04Field.n_data12 : this.n_data12,
      CDataLog04Field.n_data13 : this.n_data13,
      CDataLog04Field.n_data14 : this.n_data14,
      CDataLog04Field.n_data15 : this.n_data15,
      CDataLog04Field.n_data16 : this.n_data16,
      CDataLog04Field.n_data17 : this.n_data17,
      CDataLog04Field.n_data18 : this.n_data18,
      CDataLog04Field.n_data19 : this.n_data19,
      CDataLog04Field.n_data20 : this.n_data20,
      CDataLog04Field.n_data21 : this.n_data21,
      CDataLog04Field.n_data22 : this.n_data22,
      CDataLog04Field.n_data23 : this.n_data23,
      CDataLog04Field.n_data24 : this.n_data24,
      CDataLog04Field.n_data25 : this.n_data25,
      CDataLog04Field.n_data26 : this.n_data26,
      CDataLog04Field.n_data27 : this.n_data27,
      CDataLog04Field.n_data28 : this.n_data28,
      CDataLog04Field.n_data29 : this.n_data29,
      CDataLog04Field.n_data30 : this.n_data30,
      CDataLog04Field.d_data1 : this.d_data1,
      CDataLog04Field.d_data2 : this.d_data2,
      CDataLog04Field.d_data3 : this.d_data3,
      CDataLog04Field.d_data4 : this.d_data4,
      CDataLog04Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_04 実績データログ04のフィールド名設定用クラス
class CDataLog04Field {
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
//region c_data_log_05  実績データログ05
/// c_data_log_05 実績データログ05クラス
class CDataLog05Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_05";

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
      CDataLog05Columns rn = CDataLog05Columns();
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
    CDataLog05Columns rn = CDataLog05Columns();
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
      CDataLog05Field.serial_no : this.serial_no,
      CDataLog05Field.seq_no : this.seq_no,
      CDataLog05Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog05Field.func_cd : this.func_cd,
      CDataLog05Field.func_seq_no : this.func_seq_no,
      CDataLog05Field.c_data1 : this.c_data1,
      CDataLog05Field.c_data2 : this.c_data2,
      CDataLog05Field.c_data3 : this.c_data3,
      CDataLog05Field.c_data4 : this.c_data4,
      CDataLog05Field.c_data5 : this.c_data5,
      CDataLog05Field.c_data6 : this.c_data6,
      CDataLog05Field.c_data7 : this.c_data7,
      CDataLog05Field.c_data8 : this.c_data8,
      CDataLog05Field.c_data9 : this.c_data9,
      CDataLog05Field.c_data10 : this.c_data10,
      CDataLog05Field.n_data1 : this.n_data1,
      CDataLog05Field.n_data2 : this.n_data2,
      CDataLog05Field.n_data3 : this.n_data3,
      CDataLog05Field.n_data4 : this.n_data4,
      CDataLog05Field.n_data5 : this.n_data5,
      CDataLog05Field.n_data6 : this.n_data6,
      CDataLog05Field.n_data7 : this.n_data7,
      CDataLog05Field.n_data8 : this.n_data8,
      CDataLog05Field.n_data9 : this.n_data9,
      CDataLog05Field.n_data10 : this.n_data10,
      CDataLog05Field.n_data11 : this.n_data11,
      CDataLog05Field.n_data12 : this.n_data12,
      CDataLog05Field.n_data13 : this.n_data13,
      CDataLog05Field.n_data14 : this.n_data14,
      CDataLog05Field.n_data15 : this.n_data15,
      CDataLog05Field.n_data16 : this.n_data16,
      CDataLog05Field.n_data17 : this.n_data17,
      CDataLog05Field.n_data18 : this.n_data18,
      CDataLog05Field.n_data19 : this.n_data19,
      CDataLog05Field.n_data20 : this.n_data20,
      CDataLog05Field.n_data21 : this.n_data21,
      CDataLog05Field.n_data22 : this.n_data22,
      CDataLog05Field.n_data23 : this.n_data23,
      CDataLog05Field.n_data24 : this.n_data24,
      CDataLog05Field.n_data25 : this.n_data25,
      CDataLog05Field.n_data26 : this.n_data26,
      CDataLog05Field.n_data27 : this.n_data27,
      CDataLog05Field.n_data28 : this.n_data28,
      CDataLog05Field.n_data29 : this.n_data29,
      CDataLog05Field.n_data30 : this.n_data30,
      CDataLog05Field.d_data1 : this.d_data1,
      CDataLog05Field.d_data2 : this.d_data2,
      CDataLog05Field.d_data3 : this.d_data3,
      CDataLog05Field.d_data4 : this.d_data4,
      CDataLog05Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_05 実績データログ05のフィールド名設定用クラス
class CDataLog05Field {
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
//region c_data_log_06  実績データログ06
/// c_data_log_06 実績データログ06クラス
class CDataLog06Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_06";

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
      CDataLog06Columns rn = CDataLog06Columns();
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
    CDataLog06Columns rn = CDataLog06Columns();
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
      CDataLog06Field.serial_no : this.serial_no,
      CDataLog06Field.seq_no : this.seq_no,
      CDataLog06Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog06Field.func_cd : this.func_cd,
      CDataLog06Field.func_seq_no : this.func_seq_no,
      CDataLog06Field.c_data1 : this.c_data1,
      CDataLog06Field.c_data2 : this.c_data2,
      CDataLog06Field.c_data3 : this.c_data3,
      CDataLog06Field.c_data4 : this.c_data4,
      CDataLog06Field.c_data5 : this.c_data5,
      CDataLog06Field.c_data6 : this.c_data6,
      CDataLog06Field.c_data7 : this.c_data7,
      CDataLog06Field.c_data8 : this.c_data8,
      CDataLog06Field.c_data9 : this.c_data9,
      CDataLog06Field.c_data10 : this.c_data10,
      CDataLog06Field.n_data1 : this.n_data1,
      CDataLog06Field.n_data2 : this.n_data2,
      CDataLog06Field.n_data3 : this.n_data3,
      CDataLog06Field.n_data4 : this.n_data4,
      CDataLog06Field.n_data5 : this.n_data5,
      CDataLog06Field.n_data6 : this.n_data6,
      CDataLog06Field.n_data7 : this.n_data7,
      CDataLog06Field.n_data8 : this.n_data8,
      CDataLog06Field.n_data9 : this.n_data9,
      CDataLog06Field.n_data10 : this.n_data10,
      CDataLog06Field.n_data11 : this.n_data11,
      CDataLog06Field.n_data12 : this.n_data12,
      CDataLog06Field.n_data13 : this.n_data13,
      CDataLog06Field.n_data14 : this.n_data14,
      CDataLog06Field.n_data15 : this.n_data15,
      CDataLog06Field.n_data16 : this.n_data16,
      CDataLog06Field.n_data17 : this.n_data17,
      CDataLog06Field.n_data18 : this.n_data18,
      CDataLog06Field.n_data19 : this.n_data19,
      CDataLog06Field.n_data20 : this.n_data20,
      CDataLog06Field.n_data21 : this.n_data21,
      CDataLog06Field.n_data22 : this.n_data22,
      CDataLog06Field.n_data23 : this.n_data23,
      CDataLog06Field.n_data24 : this.n_data24,
      CDataLog06Field.n_data25 : this.n_data25,
      CDataLog06Field.n_data26 : this.n_data26,
      CDataLog06Field.n_data27 : this.n_data27,
      CDataLog06Field.n_data28 : this.n_data28,
      CDataLog06Field.n_data29 : this.n_data29,
      CDataLog06Field.n_data30 : this.n_data30,
      CDataLog06Field.d_data1 : this.d_data1,
      CDataLog06Field.d_data2 : this.d_data2,
      CDataLog06Field.d_data3 : this.d_data3,
      CDataLog06Field.d_data4 : this.d_data4,
      CDataLog06Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_06 実績データログ06のフィールド名設定用クラス
class CDataLog06Field {
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
//region c_data_log_07  実績データログ07
/// c_data_log_07 実績データログ07クラス
class CDataLog07Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_07";

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
      CDataLog07Columns rn = CDataLog07Columns();
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
    CDataLog07Columns rn = CDataLog07Columns();
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
      CDataLog07Field.serial_no : this.serial_no,
      CDataLog07Field.seq_no : this.seq_no,
      CDataLog07Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog07Field.func_cd : this.func_cd,
      CDataLog07Field.func_seq_no : this.func_seq_no,
      CDataLog07Field.c_data1 : this.c_data1,
      CDataLog07Field.c_data2 : this.c_data2,
      CDataLog07Field.c_data3 : this.c_data3,
      CDataLog07Field.c_data4 : this.c_data4,
      CDataLog07Field.c_data5 : this.c_data5,
      CDataLog07Field.c_data6 : this.c_data6,
      CDataLog07Field.c_data7 : this.c_data7,
      CDataLog07Field.c_data8 : this.c_data8,
      CDataLog07Field.c_data9 : this.c_data9,
      CDataLog07Field.c_data10 : this.c_data10,
      CDataLog07Field.n_data1 : this.n_data1,
      CDataLog07Field.n_data2 : this.n_data2,
      CDataLog07Field.n_data3 : this.n_data3,
      CDataLog07Field.n_data4 : this.n_data4,
      CDataLog07Field.n_data5 : this.n_data5,
      CDataLog07Field.n_data6 : this.n_data6,
      CDataLog07Field.n_data7 : this.n_data7,
      CDataLog07Field.n_data8 : this.n_data8,
      CDataLog07Field.n_data9 : this.n_data9,
      CDataLog07Field.n_data10 : this.n_data10,
      CDataLog07Field.n_data11 : this.n_data11,
      CDataLog07Field.n_data12 : this.n_data12,
      CDataLog07Field.n_data13 : this.n_data13,
      CDataLog07Field.n_data14 : this.n_data14,
      CDataLog07Field.n_data15 : this.n_data15,
      CDataLog07Field.n_data16 : this.n_data16,
      CDataLog07Field.n_data17 : this.n_data17,
      CDataLog07Field.n_data18 : this.n_data18,
      CDataLog07Field.n_data19 : this.n_data19,
      CDataLog07Field.n_data20 : this.n_data20,
      CDataLog07Field.n_data21 : this.n_data21,
      CDataLog07Field.n_data22 : this.n_data22,
      CDataLog07Field.n_data23 : this.n_data23,
      CDataLog07Field.n_data24 : this.n_data24,
      CDataLog07Field.n_data25 : this.n_data25,
      CDataLog07Field.n_data26 : this.n_data26,
      CDataLog07Field.n_data27 : this.n_data27,
      CDataLog07Field.n_data28 : this.n_data28,
      CDataLog07Field.n_data29 : this.n_data29,
      CDataLog07Field.n_data30 : this.n_data30,
      CDataLog07Field.d_data1 : this.d_data1,
      CDataLog07Field.d_data2 : this.d_data2,
      CDataLog07Field.d_data3 : this.d_data3,
      CDataLog07Field.d_data4 : this.d_data4,
      CDataLog07Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_07 実績データログ07のフィールド名設定用クラス
class CDataLog07Field {
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
//region c_data_log_08  実績データログ08
/// c_data_log_08 実績データログ08クラス
class CDataLog08Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_08";

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
      CDataLog08Columns rn = CDataLog08Columns();
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
    CDataLog08Columns rn = CDataLog08Columns();
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
      CDataLog08Field.serial_no : this.serial_no,
      CDataLog08Field.seq_no : this.seq_no,
      CDataLog08Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog08Field.func_cd : this.func_cd,
      CDataLog08Field.func_seq_no : this.func_seq_no,
      CDataLog08Field.c_data1 : this.c_data1,
      CDataLog08Field.c_data2 : this.c_data2,
      CDataLog08Field.c_data3 : this.c_data3,
      CDataLog08Field.c_data4 : this.c_data4,
      CDataLog08Field.c_data5 : this.c_data5,
      CDataLog08Field.c_data6 : this.c_data6,
      CDataLog08Field.c_data7 : this.c_data7,
      CDataLog08Field.c_data8 : this.c_data8,
      CDataLog08Field.c_data9 : this.c_data9,
      CDataLog08Field.c_data10 : this.c_data10,
      CDataLog08Field.n_data1 : this.n_data1,
      CDataLog08Field.n_data2 : this.n_data2,
      CDataLog08Field.n_data3 : this.n_data3,
      CDataLog08Field.n_data4 : this.n_data4,
      CDataLog08Field.n_data5 : this.n_data5,
      CDataLog08Field.n_data6 : this.n_data6,
      CDataLog08Field.n_data7 : this.n_data7,
      CDataLog08Field.n_data8 : this.n_data8,
      CDataLog08Field.n_data9 : this.n_data9,
      CDataLog08Field.n_data10 : this.n_data10,
      CDataLog08Field.n_data11 : this.n_data11,
      CDataLog08Field.n_data12 : this.n_data12,
      CDataLog08Field.n_data13 : this.n_data13,
      CDataLog08Field.n_data14 : this.n_data14,
      CDataLog08Field.n_data15 : this.n_data15,
      CDataLog08Field.n_data16 : this.n_data16,
      CDataLog08Field.n_data17 : this.n_data17,
      CDataLog08Field.n_data18 : this.n_data18,
      CDataLog08Field.n_data19 : this.n_data19,
      CDataLog08Field.n_data20 : this.n_data20,
      CDataLog08Field.n_data21 : this.n_data21,
      CDataLog08Field.n_data22 : this.n_data22,
      CDataLog08Field.n_data23 : this.n_data23,
      CDataLog08Field.n_data24 : this.n_data24,
      CDataLog08Field.n_data25 : this.n_data25,
      CDataLog08Field.n_data26 : this.n_data26,
      CDataLog08Field.n_data27 : this.n_data27,
      CDataLog08Field.n_data28 : this.n_data28,
      CDataLog08Field.n_data29 : this.n_data29,
      CDataLog08Field.n_data30 : this.n_data30,
      CDataLog08Field.d_data1 : this.d_data1,
      CDataLog08Field.d_data2 : this.d_data2,
      CDataLog08Field.d_data3 : this.d_data3,
      CDataLog08Field.d_data4 : this.d_data4,
      CDataLog08Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_08 実績データログ08のフィールド名設定用クラス
class CDataLog08Field {
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
//region c_data_log_09  実績データログ09
/// c_data_log_09 実績データログ09クラス
class CDataLog09Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_09";

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
      CDataLog09Columns rn = CDataLog09Columns();
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
    CDataLog09Columns rn = CDataLog09Columns();
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
      CDataLog09Field.serial_no : this.serial_no,
      CDataLog09Field.seq_no : this.seq_no,
      CDataLog09Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog09Field.func_cd : this.func_cd,
      CDataLog09Field.func_seq_no : this.func_seq_no,
      CDataLog09Field.c_data1 : this.c_data1,
      CDataLog09Field.c_data2 : this.c_data2,
      CDataLog09Field.c_data3 : this.c_data3,
      CDataLog09Field.c_data4 : this.c_data4,
      CDataLog09Field.c_data5 : this.c_data5,
      CDataLog09Field.c_data6 : this.c_data6,
      CDataLog09Field.c_data7 : this.c_data7,
      CDataLog09Field.c_data8 : this.c_data8,
      CDataLog09Field.c_data9 : this.c_data9,
      CDataLog09Field.c_data10 : this.c_data10,
      CDataLog09Field.n_data1 : this.n_data1,
      CDataLog09Field.n_data2 : this.n_data2,
      CDataLog09Field.n_data3 : this.n_data3,
      CDataLog09Field.n_data4 : this.n_data4,
      CDataLog09Field.n_data5 : this.n_data5,
      CDataLog09Field.n_data6 : this.n_data6,
      CDataLog09Field.n_data7 : this.n_data7,
      CDataLog09Field.n_data8 : this.n_data8,
      CDataLog09Field.n_data9 : this.n_data9,
      CDataLog09Field.n_data10 : this.n_data10,
      CDataLog09Field.n_data11 : this.n_data11,
      CDataLog09Field.n_data12 : this.n_data12,
      CDataLog09Field.n_data13 : this.n_data13,
      CDataLog09Field.n_data14 : this.n_data14,
      CDataLog09Field.n_data15 : this.n_data15,
      CDataLog09Field.n_data16 : this.n_data16,
      CDataLog09Field.n_data17 : this.n_data17,
      CDataLog09Field.n_data18 : this.n_data18,
      CDataLog09Field.n_data19 : this.n_data19,
      CDataLog09Field.n_data20 : this.n_data20,
      CDataLog09Field.n_data21 : this.n_data21,
      CDataLog09Field.n_data22 : this.n_data22,
      CDataLog09Field.n_data23 : this.n_data23,
      CDataLog09Field.n_data24 : this.n_data24,
      CDataLog09Field.n_data25 : this.n_data25,
      CDataLog09Field.n_data26 : this.n_data26,
      CDataLog09Field.n_data27 : this.n_data27,
      CDataLog09Field.n_data28 : this.n_data28,
      CDataLog09Field.n_data29 : this.n_data29,
      CDataLog09Field.n_data30 : this.n_data30,
      CDataLog09Field.d_data1 : this.d_data1,
      CDataLog09Field.d_data2 : this.d_data2,
      CDataLog09Field.d_data3 : this.d_data3,
      CDataLog09Field.d_data4 : this.d_data4,
      CDataLog09Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_09 実績データログ09のフィールド名設定用クラス
class CDataLog09Field {
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
//region c_data_log_10  実績データログ10
/// c_data_log_10 実績データログ10クラス
class CDataLog10Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_10";

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
      CDataLog10Columns rn = CDataLog10Columns();
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
    CDataLog10Columns rn = CDataLog10Columns();
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
      CDataLog10Field.serial_no : this.serial_no,
      CDataLog10Field.seq_no : this.seq_no,
      CDataLog10Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog10Field.func_cd : this.func_cd,
      CDataLog10Field.func_seq_no : this.func_seq_no,
      CDataLog10Field.c_data1 : this.c_data1,
      CDataLog10Field.c_data2 : this.c_data2,
      CDataLog10Field.c_data3 : this.c_data3,
      CDataLog10Field.c_data4 : this.c_data4,
      CDataLog10Field.c_data5 : this.c_data5,
      CDataLog10Field.c_data6 : this.c_data6,
      CDataLog10Field.c_data7 : this.c_data7,
      CDataLog10Field.c_data8 : this.c_data8,
      CDataLog10Field.c_data9 : this.c_data9,
      CDataLog10Field.c_data10 : this.c_data10,
      CDataLog10Field.n_data1 : this.n_data1,
      CDataLog10Field.n_data2 : this.n_data2,
      CDataLog10Field.n_data3 : this.n_data3,
      CDataLog10Field.n_data4 : this.n_data4,
      CDataLog10Field.n_data5 : this.n_data5,
      CDataLog10Field.n_data6 : this.n_data6,
      CDataLog10Field.n_data7 : this.n_data7,
      CDataLog10Field.n_data8 : this.n_data8,
      CDataLog10Field.n_data9 : this.n_data9,
      CDataLog10Field.n_data10 : this.n_data10,
      CDataLog10Field.n_data11 : this.n_data11,
      CDataLog10Field.n_data12 : this.n_data12,
      CDataLog10Field.n_data13 : this.n_data13,
      CDataLog10Field.n_data14 : this.n_data14,
      CDataLog10Field.n_data15 : this.n_data15,
      CDataLog10Field.n_data16 : this.n_data16,
      CDataLog10Field.n_data17 : this.n_data17,
      CDataLog10Field.n_data18 : this.n_data18,
      CDataLog10Field.n_data19 : this.n_data19,
      CDataLog10Field.n_data20 : this.n_data20,
      CDataLog10Field.n_data21 : this.n_data21,
      CDataLog10Field.n_data22 : this.n_data22,
      CDataLog10Field.n_data23 : this.n_data23,
      CDataLog10Field.n_data24 : this.n_data24,
      CDataLog10Field.n_data25 : this.n_data25,
      CDataLog10Field.n_data26 : this.n_data26,
      CDataLog10Field.n_data27 : this.n_data27,
      CDataLog10Field.n_data28 : this.n_data28,
      CDataLog10Field.n_data29 : this.n_data29,
      CDataLog10Field.n_data30 : this.n_data30,
      CDataLog10Field.d_data1 : this.d_data1,
      CDataLog10Field.d_data2 : this.d_data2,
      CDataLog10Field.d_data3 : this.d_data3,
      CDataLog10Field.d_data4 : this.d_data4,
      CDataLog10Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_10 実績データログ10のフィールド名設定用クラス
class CDataLog10Field {
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
//region c_data_log_11  実績データログ11
/// c_data_log_11 実績データログ11クラス
class CDataLog11Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_11";

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
      CDataLog11Columns rn = CDataLog11Columns();
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
    CDataLog11Columns rn = CDataLog11Columns();
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
      CDataLog11Field.serial_no : this.serial_no,
      CDataLog11Field.seq_no : this.seq_no,
      CDataLog11Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog11Field.func_cd : this.func_cd,
      CDataLog11Field.func_seq_no : this.func_seq_no,
      CDataLog11Field.c_data1 : this.c_data1,
      CDataLog11Field.c_data2 : this.c_data2,
      CDataLog11Field.c_data3 : this.c_data3,
      CDataLog11Field.c_data4 : this.c_data4,
      CDataLog11Field.c_data5 : this.c_data5,
      CDataLog11Field.c_data6 : this.c_data6,
      CDataLog11Field.c_data7 : this.c_data7,
      CDataLog11Field.c_data8 : this.c_data8,
      CDataLog11Field.c_data9 : this.c_data9,
      CDataLog11Field.c_data10 : this.c_data10,
      CDataLog11Field.n_data1 : this.n_data1,
      CDataLog11Field.n_data2 : this.n_data2,
      CDataLog11Field.n_data3 : this.n_data3,
      CDataLog11Field.n_data4 : this.n_data4,
      CDataLog11Field.n_data5 : this.n_data5,
      CDataLog11Field.n_data6 : this.n_data6,
      CDataLog11Field.n_data7 : this.n_data7,
      CDataLog11Field.n_data8 : this.n_data8,
      CDataLog11Field.n_data9 : this.n_data9,
      CDataLog11Field.n_data10 : this.n_data10,
      CDataLog11Field.n_data11 : this.n_data11,
      CDataLog11Field.n_data12 : this.n_data12,
      CDataLog11Field.n_data13 : this.n_data13,
      CDataLog11Field.n_data14 : this.n_data14,
      CDataLog11Field.n_data15 : this.n_data15,
      CDataLog11Field.n_data16 : this.n_data16,
      CDataLog11Field.n_data17 : this.n_data17,
      CDataLog11Field.n_data18 : this.n_data18,
      CDataLog11Field.n_data19 : this.n_data19,
      CDataLog11Field.n_data20 : this.n_data20,
      CDataLog11Field.n_data21 : this.n_data21,
      CDataLog11Field.n_data22 : this.n_data22,
      CDataLog11Field.n_data23 : this.n_data23,
      CDataLog11Field.n_data24 : this.n_data24,
      CDataLog11Field.n_data25 : this.n_data25,
      CDataLog11Field.n_data26 : this.n_data26,
      CDataLog11Field.n_data27 : this.n_data27,
      CDataLog11Field.n_data28 : this.n_data28,
      CDataLog11Field.n_data29 : this.n_data29,
      CDataLog11Field.n_data30 : this.n_data30,
      CDataLog11Field.d_data1 : this.d_data1,
      CDataLog11Field.d_data2 : this.d_data2,
      CDataLog11Field.d_data3 : this.d_data3,
      CDataLog11Field.d_data4 : this.d_data4,
      CDataLog11Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_11 実績データログ11のフィールド名設定用クラス
class CDataLog11Field {
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
//region c_data_log_12  実績データログ12
/// c_data_log_12 実績データログ12クラス
class CDataLog12Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_12";

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
      CDataLog12Columns rn = CDataLog12Columns();
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
    CDataLog12Columns rn = CDataLog12Columns();
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
      CDataLog12Field.serial_no : this.serial_no,
      CDataLog12Field.seq_no : this.seq_no,
      CDataLog12Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog12Field.func_cd : this.func_cd,
      CDataLog12Field.func_seq_no : this.func_seq_no,
      CDataLog12Field.c_data1 : this.c_data1,
      CDataLog12Field.c_data2 : this.c_data2,
      CDataLog12Field.c_data3 : this.c_data3,
      CDataLog12Field.c_data4 : this.c_data4,
      CDataLog12Field.c_data5 : this.c_data5,
      CDataLog12Field.c_data6 : this.c_data6,
      CDataLog12Field.c_data7 : this.c_data7,
      CDataLog12Field.c_data8 : this.c_data8,
      CDataLog12Field.c_data9 : this.c_data9,
      CDataLog12Field.c_data10 : this.c_data10,
      CDataLog12Field.n_data1 : this.n_data1,
      CDataLog12Field.n_data2 : this.n_data2,
      CDataLog12Field.n_data3 : this.n_data3,
      CDataLog12Field.n_data4 : this.n_data4,
      CDataLog12Field.n_data5 : this.n_data5,
      CDataLog12Field.n_data6 : this.n_data6,
      CDataLog12Field.n_data7 : this.n_data7,
      CDataLog12Field.n_data8 : this.n_data8,
      CDataLog12Field.n_data9 : this.n_data9,
      CDataLog12Field.n_data10 : this.n_data10,
      CDataLog12Field.n_data11 : this.n_data11,
      CDataLog12Field.n_data12 : this.n_data12,
      CDataLog12Field.n_data13 : this.n_data13,
      CDataLog12Field.n_data14 : this.n_data14,
      CDataLog12Field.n_data15 : this.n_data15,
      CDataLog12Field.n_data16 : this.n_data16,
      CDataLog12Field.n_data17 : this.n_data17,
      CDataLog12Field.n_data18 : this.n_data18,
      CDataLog12Field.n_data19 : this.n_data19,
      CDataLog12Field.n_data20 : this.n_data20,
      CDataLog12Field.n_data21 : this.n_data21,
      CDataLog12Field.n_data22 : this.n_data22,
      CDataLog12Field.n_data23 : this.n_data23,
      CDataLog12Field.n_data24 : this.n_data24,
      CDataLog12Field.n_data25 : this.n_data25,
      CDataLog12Field.n_data26 : this.n_data26,
      CDataLog12Field.n_data27 : this.n_data27,
      CDataLog12Field.n_data28 : this.n_data28,
      CDataLog12Field.n_data29 : this.n_data29,
      CDataLog12Field.n_data30 : this.n_data30,
      CDataLog12Field.d_data1 : this.d_data1,
      CDataLog12Field.d_data2 : this.d_data2,
      CDataLog12Field.d_data3 : this.d_data3,
      CDataLog12Field.d_data4 : this.d_data4,
      CDataLog12Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_12 実績データログ12のフィールド名設定用クラス
class CDataLog12Field {
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
//region c_data_log_13  実績データログ13
/// c_data_log_13 実績データログ13クラス
class CDataLog13Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_13";

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
      CDataLog13Columns rn = CDataLog13Columns();
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
    CDataLog13Columns rn = CDataLog13Columns();
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
      CDataLog13Field.serial_no : this.serial_no,
      CDataLog13Field.seq_no : this.seq_no,
      CDataLog13Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog13Field.func_cd : this.func_cd,
      CDataLog13Field.func_seq_no : this.func_seq_no,
      CDataLog13Field.c_data1 : this.c_data1,
      CDataLog13Field.c_data2 : this.c_data2,
      CDataLog13Field.c_data3 : this.c_data3,
      CDataLog13Field.c_data4 : this.c_data4,
      CDataLog13Field.c_data5 : this.c_data5,
      CDataLog13Field.c_data6 : this.c_data6,
      CDataLog13Field.c_data7 : this.c_data7,
      CDataLog13Field.c_data8 : this.c_data8,
      CDataLog13Field.c_data9 : this.c_data9,
      CDataLog13Field.c_data10 : this.c_data10,
      CDataLog13Field.n_data1 : this.n_data1,
      CDataLog13Field.n_data2 : this.n_data2,
      CDataLog13Field.n_data3 : this.n_data3,
      CDataLog13Field.n_data4 : this.n_data4,
      CDataLog13Field.n_data5 : this.n_data5,
      CDataLog13Field.n_data6 : this.n_data6,
      CDataLog13Field.n_data7 : this.n_data7,
      CDataLog13Field.n_data8 : this.n_data8,
      CDataLog13Field.n_data9 : this.n_data9,
      CDataLog13Field.n_data10 : this.n_data10,
      CDataLog13Field.n_data11 : this.n_data11,
      CDataLog13Field.n_data12 : this.n_data12,
      CDataLog13Field.n_data13 : this.n_data13,
      CDataLog13Field.n_data14 : this.n_data14,
      CDataLog13Field.n_data15 : this.n_data15,
      CDataLog13Field.n_data16 : this.n_data16,
      CDataLog13Field.n_data17 : this.n_data17,
      CDataLog13Field.n_data18 : this.n_data18,
      CDataLog13Field.n_data19 : this.n_data19,
      CDataLog13Field.n_data20 : this.n_data20,
      CDataLog13Field.n_data21 : this.n_data21,
      CDataLog13Field.n_data22 : this.n_data22,
      CDataLog13Field.n_data23 : this.n_data23,
      CDataLog13Field.n_data24 : this.n_data24,
      CDataLog13Field.n_data25 : this.n_data25,
      CDataLog13Field.n_data26 : this.n_data26,
      CDataLog13Field.n_data27 : this.n_data27,
      CDataLog13Field.n_data28 : this.n_data28,
      CDataLog13Field.n_data29 : this.n_data29,
      CDataLog13Field.n_data30 : this.n_data30,
      CDataLog13Field.d_data1 : this.d_data1,
      CDataLog13Field.d_data2 : this.d_data2,
      CDataLog13Field.d_data3 : this.d_data3,
      CDataLog13Field.d_data4 : this.d_data4,
      CDataLog13Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_13 実績データログ13のフィールド名設定用クラス
class CDataLog13Field {
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
//region c_data_log_14  実績データログ14
/// c_data_log_14 実績データログ14クラス
class CDataLog14Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_14";

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
      CDataLog14Columns rn = CDataLog14Columns();
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
    CDataLog14Columns rn = CDataLog14Columns();
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
      CDataLog14Field.serial_no : this.serial_no,
      CDataLog14Field.seq_no : this.seq_no,
      CDataLog14Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog14Field.func_cd : this.func_cd,
      CDataLog14Field.func_seq_no : this.func_seq_no,
      CDataLog14Field.c_data1 : this.c_data1,
      CDataLog14Field.c_data2 : this.c_data2,
      CDataLog14Field.c_data3 : this.c_data3,
      CDataLog14Field.c_data4 : this.c_data4,
      CDataLog14Field.c_data5 : this.c_data5,
      CDataLog14Field.c_data6 : this.c_data6,
      CDataLog14Field.c_data7 : this.c_data7,
      CDataLog14Field.c_data8 : this.c_data8,
      CDataLog14Field.c_data9 : this.c_data9,
      CDataLog14Field.c_data10 : this.c_data10,
      CDataLog14Field.n_data1 : this.n_data1,
      CDataLog14Field.n_data2 : this.n_data2,
      CDataLog14Field.n_data3 : this.n_data3,
      CDataLog14Field.n_data4 : this.n_data4,
      CDataLog14Field.n_data5 : this.n_data5,
      CDataLog14Field.n_data6 : this.n_data6,
      CDataLog14Field.n_data7 : this.n_data7,
      CDataLog14Field.n_data8 : this.n_data8,
      CDataLog14Field.n_data9 : this.n_data9,
      CDataLog14Field.n_data10 : this.n_data10,
      CDataLog14Field.n_data11 : this.n_data11,
      CDataLog14Field.n_data12 : this.n_data12,
      CDataLog14Field.n_data13 : this.n_data13,
      CDataLog14Field.n_data14 : this.n_data14,
      CDataLog14Field.n_data15 : this.n_data15,
      CDataLog14Field.n_data16 : this.n_data16,
      CDataLog14Field.n_data17 : this.n_data17,
      CDataLog14Field.n_data18 : this.n_data18,
      CDataLog14Field.n_data19 : this.n_data19,
      CDataLog14Field.n_data20 : this.n_data20,
      CDataLog14Field.n_data21 : this.n_data21,
      CDataLog14Field.n_data22 : this.n_data22,
      CDataLog14Field.n_data23 : this.n_data23,
      CDataLog14Field.n_data24 : this.n_data24,
      CDataLog14Field.n_data25 : this.n_data25,
      CDataLog14Field.n_data26 : this.n_data26,
      CDataLog14Field.n_data27 : this.n_data27,
      CDataLog14Field.n_data28 : this.n_data28,
      CDataLog14Field.n_data29 : this.n_data29,
      CDataLog14Field.n_data30 : this.n_data30,
      CDataLog14Field.d_data1 : this.d_data1,
      CDataLog14Field.d_data2 : this.d_data2,
      CDataLog14Field.d_data3 : this.d_data3,
      CDataLog14Field.d_data4 : this.d_data4,
      CDataLog14Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_14 実績データログ14のフィールド名設定用クラス
class CDataLog14Field {
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
//region c_data_log_15  実績データログ15
/// c_data_log_15 実績データログ15クラス
class CDataLog15Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_15";

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
      CDataLog15Columns rn = CDataLog15Columns();
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
    CDataLog15Columns rn = CDataLog15Columns();
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
      CDataLog15Field.serial_no : this.serial_no,
      CDataLog15Field.seq_no : this.seq_no,
      CDataLog15Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog15Field.func_cd : this.func_cd,
      CDataLog15Field.func_seq_no : this.func_seq_no,
      CDataLog15Field.c_data1 : this.c_data1,
      CDataLog15Field.c_data2 : this.c_data2,
      CDataLog15Field.c_data3 : this.c_data3,
      CDataLog15Field.c_data4 : this.c_data4,
      CDataLog15Field.c_data5 : this.c_data5,
      CDataLog15Field.c_data6 : this.c_data6,
      CDataLog15Field.c_data7 : this.c_data7,
      CDataLog15Field.c_data8 : this.c_data8,
      CDataLog15Field.c_data9 : this.c_data9,
      CDataLog15Field.c_data10 : this.c_data10,
      CDataLog15Field.n_data1 : this.n_data1,
      CDataLog15Field.n_data2 : this.n_data2,
      CDataLog15Field.n_data3 : this.n_data3,
      CDataLog15Field.n_data4 : this.n_data4,
      CDataLog15Field.n_data5 : this.n_data5,
      CDataLog15Field.n_data6 : this.n_data6,
      CDataLog15Field.n_data7 : this.n_data7,
      CDataLog15Field.n_data8 : this.n_data8,
      CDataLog15Field.n_data9 : this.n_data9,
      CDataLog15Field.n_data10 : this.n_data10,
      CDataLog15Field.n_data11 : this.n_data11,
      CDataLog15Field.n_data12 : this.n_data12,
      CDataLog15Field.n_data13 : this.n_data13,
      CDataLog15Field.n_data14 : this.n_data14,
      CDataLog15Field.n_data15 : this.n_data15,
      CDataLog15Field.n_data16 : this.n_data16,
      CDataLog15Field.n_data17 : this.n_data17,
      CDataLog15Field.n_data18 : this.n_data18,
      CDataLog15Field.n_data19 : this.n_data19,
      CDataLog15Field.n_data20 : this.n_data20,
      CDataLog15Field.n_data21 : this.n_data21,
      CDataLog15Field.n_data22 : this.n_data22,
      CDataLog15Field.n_data23 : this.n_data23,
      CDataLog15Field.n_data24 : this.n_data24,
      CDataLog15Field.n_data25 : this.n_data25,
      CDataLog15Field.n_data26 : this.n_data26,
      CDataLog15Field.n_data27 : this.n_data27,
      CDataLog15Field.n_data28 : this.n_data28,
      CDataLog15Field.n_data29 : this.n_data29,
      CDataLog15Field.n_data30 : this.n_data30,
      CDataLog15Field.d_data1 : this.d_data1,
      CDataLog15Field.d_data2 : this.d_data2,
      CDataLog15Field.d_data3 : this.d_data3,
      CDataLog15Field.d_data4 : this.d_data4,
      CDataLog15Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_15 実績データログ15のフィールド名設定用クラス
class CDataLog15Field {
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
//region c_data_log_16  実績データログ16
/// c_data_log_16 実績データログ16クラス
class CDataLog16Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_16";

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
      CDataLog16Columns rn = CDataLog16Columns();
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
    CDataLog16Columns rn = CDataLog16Columns();
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
      CDataLog16Field.serial_no : this.serial_no,
      CDataLog16Field.seq_no : this.seq_no,
      CDataLog16Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog16Field.func_cd : this.func_cd,
      CDataLog16Field.func_seq_no : this.func_seq_no,
      CDataLog16Field.c_data1 : this.c_data1,
      CDataLog16Field.c_data2 : this.c_data2,
      CDataLog16Field.c_data3 : this.c_data3,
      CDataLog16Field.c_data4 : this.c_data4,
      CDataLog16Field.c_data5 : this.c_data5,
      CDataLog16Field.c_data6 : this.c_data6,
      CDataLog16Field.c_data7 : this.c_data7,
      CDataLog16Field.c_data8 : this.c_data8,
      CDataLog16Field.c_data9 : this.c_data9,
      CDataLog16Field.c_data10 : this.c_data10,
      CDataLog16Field.n_data1 : this.n_data1,
      CDataLog16Field.n_data2 : this.n_data2,
      CDataLog16Field.n_data3 : this.n_data3,
      CDataLog16Field.n_data4 : this.n_data4,
      CDataLog16Field.n_data5 : this.n_data5,
      CDataLog16Field.n_data6 : this.n_data6,
      CDataLog16Field.n_data7 : this.n_data7,
      CDataLog16Field.n_data8 : this.n_data8,
      CDataLog16Field.n_data9 : this.n_data9,
      CDataLog16Field.n_data10 : this.n_data10,
      CDataLog16Field.n_data11 : this.n_data11,
      CDataLog16Field.n_data12 : this.n_data12,
      CDataLog16Field.n_data13 : this.n_data13,
      CDataLog16Field.n_data14 : this.n_data14,
      CDataLog16Field.n_data15 : this.n_data15,
      CDataLog16Field.n_data16 : this.n_data16,
      CDataLog16Field.n_data17 : this.n_data17,
      CDataLog16Field.n_data18 : this.n_data18,
      CDataLog16Field.n_data19 : this.n_data19,
      CDataLog16Field.n_data20 : this.n_data20,
      CDataLog16Field.n_data21 : this.n_data21,
      CDataLog16Field.n_data22 : this.n_data22,
      CDataLog16Field.n_data23 : this.n_data23,
      CDataLog16Field.n_data24 : this.n_data24,
      CDataLog16Field.n_data25 : this.n_data25,
      CDataLog16Field.n_data26 : this.n_data26,
      CDataLog16Field.n_data27 : this.n_data27,
      CDataLog16Field.n_data28 : this.n_data28,
      CDataLog16Field.n_data29 : this.n_data29,
      CDataLog16Field.n_data30 : this.n_data30,
      CDataLog16Field.d_data1 : this.d_data1,
      CDataLog16Field.d_data2 : this.d_data2,
      CDataLog16Field.d_data3 : this.d_data3,
      CDataLog16Field.d_data4 : this.d_data4,
      CDataLog16Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_16 実績データログ16のフィールド名設定用クラス
class CDataLog16Field {
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
//region c_data_log_17  実績データログ17
/// c_data_log_17 実績データログ17クラス
class CDataLog17Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_17";

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
      CDataLog17Columns rn = CDataLog17Columns();
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
    CDataLog17Columns rn = CDataLog17Columns();
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
      CDataLog17Field.serial_no : this.serial_no,
      CDataLog17Field.seq_no : this.seq_no,
      CDataLog17Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog17Field.func_cd : this.func_cd,
      CDataLog17Field.func_seq_no : this.func_seq_no,
      CDataLog17Field.c_data1 : this.c_data1,
      CDataLog17Field.c_data2 : this.c_data2,
      CDataLog17Field.c_data3 : this.c_data3,
      CDataLog17Field.c_data4 : this.c_data4,
      CDataLog17Field.c_data5 : this.c_data5,
      CDataLog17Field.c_data6 : this.c_data6,
      CDataLog17Field.c_data7 : this.c_data7,
      CDataLog17Field.c_data8 : this.c_data8,
      CDataLog17Field.c_data9 : this.c_data9,
      CDataLog17Field.c_data10 : this.c_data10,
      CDataLog17Field.n_data1 : this.n_data1,
      CDataLog17Field.n_data2 : this.n_data2,
      CDataLog17Field.n_data3 : this.n_data3,
      CDataLog17Field.n_data4 : this.n_data4,
      CDataLog17Field.n_data5 : this.n_data5,
      CDataLog17Field.n_data6 : this.n_data6,
      CDataLog17Field.n_data7 : this.n_data7,
      CDataLog17Field.n_data8 : this.n_data8,
      CDataLog17Field.n_data9 : this.n_data9,
      CDataLog17Field.n_data10 : this.n_data10,
      CDataLog17Field.n_data11 : this.n_data11,
      CDataLog17Field.n_data12 : this.n_data12,
      CDataLog17Field.n_data13 : this.n_data13,
      CDataLog17Field.n_data14 : this.n_data14,
      CDataLog17Field.n_data15 : this.n_data15,
      CDataLog17Field.n_data16 : this.n_data16,
      CDataLog17Field.n_data17 : this.n_data17,
      CDataLog17Field.n_data18 : this.n_data18,
      CDataLog17Field.n_data19 : this.n_data19,
      CDataLog17Field.n_data20 : this.n_data20,
      CDataLog17Field.n_data21 : this.n_data21,
      CDataLog17Field.n_data22 : this.n_data22,
      CDataLog17Field.n_data23 : this.n_data23,
      CDataLog17Field.n_data24 : this.n_data24,
      CDataLog17Field.n_data25 : this.n_data25,
      CDataLog17Field.n_data26 : this.n_data26,
      CDataLog17Field.n_data27 : this.n_data27,
      CDataLog17Field.n_data28 : this.n_data28,
      CDataLog17Field.n_data29 : this.n_data29,
      CDataLog17Field.n_data30 : this.n_data30,
      CDataLog17Field.d_data1 : this.d_data1,
      CDataLog17Field.d_data2 : this.d_data2,
      CDataLog17Field.d_data3 : this.d_data3,
      CDataLog17Field.d_data4 : this.d_data4,
      CDataLog17Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_17 実績データログ17のフィールド名設定用クラス
class CDataLog17Field {
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
//region c_data_log_18  実績データログ18
/// c_data_log_18 実績データログ18クラス
class CDataLog18Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_18";

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
      CDataLog18Columns rn = CDataLog18Columns();
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
    CDataLog18Columns rn = CDataLog18Columns();
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
      CDataLog18Field.serial_no : this.serial_no,
      CDataLog18Field.seq_no : this.seq_no,
      CDataLog18Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog18Field.func_cd : this.func_cd,
      CDataLog18Field.func_seq_no : this.func_seq_no,
      CDataLog18Field.c_data1 : this.c_data1,
      CDataLog18Field.c_data2 : this.c_data2,
      CDataLog18Field.c_data3 : this.c_data3,
      CDataLog18Field.c_data4 : this.c_data4,
      CDataLog18Field.c_data5 : this.c_data5,
      CDataLog18Field.c_data6 : this.c_data6,
      CDataLog18Field.c_data7 : this.c_data7,
      CDataLog18Field.c_data8 : this.c_data8,
      CDataLog18Field.c_data9 : this.c_data9,
      CDataLog18Field.c_data10 : this.c_data10,
      CDataLog18Field.n_data1 : this.n_data1,
      CDataLog18Field.n_data2 : this.n_data2,
      CDataLog18Field.n_data3 : this.n_data3,
      CDataLog18Field.n_data4 : this.n_data4,
      CDataLog18Field.n_data5 : this.n_data5,
      CDataLog18Field.n_data6 : this.n_data6,
      CDataLog18Field.n_data7 : this.n_data7,
      CDataLog18Field.n_data8 : this.n_data8,
      CDataLog18Field.n_data9 : this.n_data9,
      CDataLog18Field.n_data10 : this.n_data10,
      CDataLog18Field.n_data11 : this.n_data11,
      CDataLog18Field.n_data12 : this.n_data12,
      CDataLog18Field.n_data13 : this.n_data13,
      CDataLog18Field.n_data14 : this.n_data14,
      CDataLog18Field.n_data15 : this.n_data15,
      CDataLog18Field.n_data16 : this.n_data16,
      CDataLog18Field.n_data17 : this.n_data17,
      CDataLog18Field.n_data18 : this.n_data18,
      CDataLog18Field.n_data19 : this.n_data19,
      CDataLog18Field.n_data20 : this.n_data20,
      CDataLog18Field.n_data21 : this.n_data21,
      CDataLog18Field.n_data22 : this.n_data22,
      CDataLog18Field.n_data23 : this.n_data23,
      CDataLog18Field.n_data24 : this.n_data24,
      CDataLog18Field.n_data25 : this.n_data25,
      CDataLog18Field.n_data26 : this.n_data26,
      CDataLog18Field.n_data27 : this.n_data27,
      CDataLog18Field.n_data28 : this.n_data28,
      CDataLog18Field.n_data29 : this.n_data29,
      CDataLog18Field.n_data30 : this.n_data30,
      CDataLog18Field.d_data1 : this.d_data1,
      CDataLog18Field.d_data2 : this.d_data2,
      CDataLog18Field.d_data3 : this.d_data3,
      CDataLog18Field.d_data4 : this.d_data4,
      CDataLog18Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_18 実績データログ18のフィールド名設定用クラス
class CDataLog18Field {
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
//region c_data_log_19  実績データログ19
/// c_data_log_19 実績データログ19クラス
class CDataLog19Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_19";

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
      CDataLog19Columns rn = CDataLog19Columns();
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
    CDataLog19Columns rn = CDataLog19Columns();
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
      CDataLog19Field.serial_no : this.serial_no,
      CDataLog19Field.seq_no : this.seq_no,
      CDataLog19Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog19Field.func_cd : this.func_cd,
      CDataLog19Field.func_seq_no : this.func_seq_no,
      CDataLog19Field.c_data1 : this.c_data1,
      CDataLog19Field.c_data2 : this.c_data2,
      CDataLog19Field.c_data3 : this.c_data3,
      CDataLog19Field.c_data4 : this.c_data4,
      CDataLog19Field.c_data5 : this.c_data5,
      CDataLog19Field.c_data6 : this.c_data6,
      CDataLog19Field.c_data7 : this.c_data7,
      CDataLog19Field.c_data8 : this.c_data8,
      CDataLog19Field.c_data9 : this.c_data9,
      CDataLog19Field.c_data10 : this.c_data10,
      CDataLog19Field.n_data1 : this.n_data1,
      CDataLog19Field.n_data2 : this.n_data2,
      CDataLog19Field.n_data3 : this.n_data3,
      CDataLog19Field.n_data4 : this.n_data4,
      CDataLog19Field.n_data5 : this.n_data5,
      CDataLog19Field.n_data6 : this.n_data6,
      CDataLog19Field.n_data7 : this.n_data7,
      CDataLog19Field.n_data8 : this.n_data8,
      CDataLog19Field.n_data9 : this.n_data9,
      CDataLog19Field.n_data10 : this.n_data10,
      CDataLog19Field.n_data11 : this.n_data11,
      CDataLog19Field.n_data12 : this.n_data12,
      CDataLog19Field.n_data13 : this.n_data13,
      CDataLog19Field.n_data14 : this.n_data14,
      CDataLog19Field.n_data15 : this.n_data15,
      CDataLog19Field.n_data16 : this.n_data16,
      CDataLog19Field.n_data17 : this.n_data17,
      CDataLog19Field.n_data18 : this.n_data18,
      CDataLog19Field.n_data19 : this.n_data19,
      CDataLog19Field.n_data20 : this.n_data20,
      CDataLog19Field.n_data21 : this.n_data21,
      CDataLog19Field.n_data22 : this.n_data22,
      CDataLog19Field.n_data23 : this.n_data23,
      CDataLog19Field.n_data24 : this.n_data24,
      CDataLog19Field.n_data25 : this.n_data25,
      CDataLog19Field.n_data26 : this.n_data26,
      CDataLog19Field.n_data27 : this.n_data27,
      CDataLog19Field.n_data28 : this.n_data28,
      CDataLog19Field.n_data29 : this.n_data29,
      CDataLog19Field.n_data30 : this.n_data30,
      CDataLog19Field.d_data1 : this.d_data1,
      CDataLog19Field.d_data2 : this.d_data2,
      CDataLog19Field.d_data3 : this.d_data3,
      CDataLog19Field.d_data4 : this.d_data4,
      CDataLog19Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_19 実績データログ19のフィールド名設定用クラス
class CDataLog19Field {
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
//region c_data_log_20  実績データログ20
/// c_data_log_20 実績データログ20クラス
class CDataLog20Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_20";

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
      CDataLog20Columns rn = CDataLog20Columns();
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
    CDataLog20Columns rn = CDataLog20Columns();
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
      CDataLog20Field.serial_no : this.serial_no,
      CDataLog20Field.seq_no : this.seq_no,
      CDataLog20Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog20Field.func_cd : this.func_cd,
      CDataLog20Field.func_seq_no : this.func_seq_no,
      CDataLog20Field.c_data1 : this.c_data1,
      CDataLog20Field.c_data2 : this.c_data2,
      CDataLog20Field.c_data3 : this.c_data3,
      CDataLog20Field.c_data4 : this.c_data4,
      CDataLog20Field.c_data5 : this.c_data5,
      CDataLog20Field.c_data6 : this.c_data6,
      CDataLog20Field.c_data7 : this.c_data7,
      CDataLog20Field.c_data8 : this.c_data8,
      CDataLog20Field.c_data9 : this.c_data9,
      CDataLog20Field.c_data10 : this.c_data10,
      CDataLog20Field.n_data1 : this.n_data1,
      CDataLog20Field.n_data2 : this.n_data2,
      CDataLog20Field.n_data3 : this.n_data3,
      CDataLog20Field.n_data4 : this.n_data4,
      CDataLog20Field.n_data5 : this.n_data5,
      CDataLog20Field.n_data6 : this.n_data6,
      CDataLog20Field.n_data7 : this.n_data7,
      CDataLog20Field.n_data8 : this.n_data8,
      CDataLog20Field.n_data9 : this.n_data9,
      CDataLog20Field.n_data10 : this.n_data10,
      CDataLog20Field.n_data11 : this.n_data11,
      CDataLog20Field.n_data12 : this.n_data12,
      CDataLog20Field.n_data13 : this.n_data13,
      CDataLog20Field.n_data14 : this.n_data14,
      CDataLog20Field.n_data15 : this.n_data15,
      CDataLog20Field.n_data16 : this.n_data16,
      CDataLog20Field.n_data17 : this.n_data17,
      CDataLog20Field.n_data18 : this.n_data18,
      CDataLog20Field.n_data19 : this.n_data19,
      CDataLog20Field.n_data20 : this.n_data20,
      CDataLog20Field.n_data21 : this.n_data21,
      CDataLog20Field.n_data22 : this.n_data22,
      CDataLog20Field.n_data23 : this.n_data23,
      CDataLog20Field.n_data24 : this.n_data24,
      CDataLog20Field.n_data25 : this.n_data25,
      CDataLog20Field.n_data26 : this.n_data26,
      CDataLog20Field.n_data27 : this.n_data27,
      CDataLog20Field.n_data28 : this.n_data28,
      CDataLog20Field.n_data29 : this.n_data29,
      CDataLog20Field.n_data30 : this.n_data30,
      CDataLog20Field.d_data1 : this.d_data1,
      CDataLog20Field.d_data2 : this.d_data2,
      CDataLog20Field.d_data3 : this.d_data3,
      CDataLog20Field.d_data4 : this.d_data4,
      CDataLog20Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_20 実績データログ20のフィールド名設定用クラス
class CDataLog20Field {
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
//region c_data_log_21  実績データログ21
/// c_data_log_21 実績データログ21クラス
class CDataLog21Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_21";

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
      CDataLog21Columns rn = CDataLog21Columns();
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
    CDataLog21Columns rn = CDataLog21Columns();
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
      CDataLog21Field.serial_no : this.serial_no,
      CDataLog21Field.seq_no : this.seq_no,
      CDataLog21Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog21Field.func_cd : this.func_cd,
      CDataLog21Field.func_seq_no : this.func_seq_no,
      CDataLog21Field.c_data1 : this.c_data1,
      CDataLog21Field.c_data2 : this.c_data2,
      CDataLog21Field.c_data3 : this.c_data3,
      CDataLog21Field.c_data4 : this.c_data4,
      CDataLog21Field.c_data5 : this.c_data5,
      CDataLog21Field.c_data6 : this.c_data6,
      CDataLog21Field.c_data7 : this.c_data7,
      CDataLog21Field.c_data8 : this.c_data8,
      CDataLog21Field.c_data9 : this.c_data9,
      CDataLog21Field.c_data10 : this.c_data10,
      CDataLog21Field.n_data1 : this.n_data1,
      CDataLog21Field.n_data2 : this.n_data2,
      CDataLog21Field.n_data3 : this.n_data3,
      CDataLog21Field.n_data4 : this.n_data4,
      CDataLog21Field.n_data5 : this.n_data5,
      CDataLog21Field.n_data6 : this.n_data6,
      CDataLog21Field.n_data7 : this.n_data7,
      CDataLog21Field.n_data8 : this.n_data8,
      CDataLog21Field.n_data9 : this.n_data9,
      CDataLog21Field.n_data10 : this.n_data10,
      CDataLog21Field.n_data11 : this.n_data11,
      CDataLog21Field.n_data12 : this.n_data12,
      CDataLog21Field.n_data13 : this.n_data13,
      CDataLog21Field.n_data14 : this.n_data14,
      CDataLog21Field.n_data15 : this.n_data15,
      CDataLog21Field.n_data16 : this.n_data16,
      CDataLog21Field.n_data17 : this.n_data17,
      CDataLog21Field.n_data18 : this.n_data18,
      CDataLog21Field.n_data19 : this.n_data19,
      CDataLog21Field.n_data20 : this.n_data20,
      CDataLog21Field.n_data21 : this.n_data21,
      CDataLog21Field.n_data22 : this.n_data22,
      CDataLog21Field.n_data23 : this.n_data23,
      CDataLog21Field.n_data24 : this.n_data24,
      CDataLog21Field.n_data25 : this.n_data25,
      CDataLog21Field.n_data26 : this.n_data26,
      CDataLog21Field.n_data27 : this.n_data27,
      CDataLog21Field.n_data28 : this.n_data28,
      CDataLog21Field.n_data29 : this.n_data29,
      CDataLog21Field.n_data30 : this.n_data30,
      CDataLog21Field.d_data1 : this.d_data1,
      CDataLog21Field.d_data2 : this.d_data2,
      CDataLog21Field.d_data3 : this.d_data3,
      CDataLog21Field.d_data4 : this.d_data4,
      CDataLog21Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_21 実績データログ21のフィールド名設定用クラス
class CDataLog21Field {
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
//region c_data_log_22  実績データログ22
/// c_data_log_22 実績データログ22クラス
class CDataLog22Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_22";

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
      CDataLog22Columns rn = CDataLog22Columns();
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
    CDataLog22Columns rn = CDataLog22Columns();
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
      CDataLog22Field.serial_no : this.serial_no,
      CDataLog22Field.seq_no : this.seq_no,
      CDataLog22Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog22Field.func_cd : this.func_cd,
      CDataLog22Field.func_seq_no : this.func_seq_no,
      CDataLog22Field.c_data1 : this.c_data1,
      CDataLog22Field.c_data2 : this.c_data2,
      CDataLog22Field.c_data3 : this.c_data3,
      CDataLog22Field.c_data4 : this.c_data4,
      CDataLog22Field.c_data5 : this.c_data5,
      CDataLog22Field.c_data6 : this.c_data6,
      CDataLog22Field.c_data7 : this.c_data7,
      CDataLog22Field.c_data8 : this.c_data8,
      CDataLog22Field.c_data9 : this.c_data9,
      CDataLog22Field.c_data10 : this.c_data10,
      CDataLog22Field.n_data1 : this.n_data1,
      CDataLog22Field.n_data2 : this.n_data2,
      CDataLog22Field.n_data3 : this.n_data3,
      CDataLog22Field.n_data4 : this.n_data4,
      CDataLog22Field.n_data5 : this.n_data5,
      CDataLog22Field.n_data6 : this.n_data6,
      CDataLog22Field.n_data7 : this.n_data7,
      CDataLog22Field.n_data8 : this.n_data8,
      CDataLog22Field.n_data9 : this.n_data9,
      CDataLog22Field.n_data10 : this.n_data10,
      CDataLog22Field.n_data11 : this.n_data11,
      CDataLog22Field.n_data12 : this.n_data12,
      CDataLog22Field.n_data13 : this.n_data13,
      CDataLog22Field.n_data14 : this.n_data14,
      CDataLog22Field.n_data15 : this.n_data15,
      CDataLog22Field.n_data16 : this.n_data16,
      CDataLog22Field.n_data17 : this.n_data17,
      CDataLog22Field.n_data18 : this.n_data18,
      CDataLog22Field.n_data19 : this.n_data19,
      CDataLog22Field.n_data20 : this.n_data20,
      CDataLog22Field.n_data21 : this.n_data21,
      CDataLog22Field.n_data22 : this.n_data22,
      CDataLog22Field.n_data23 : this.n_data23,
      CDataLog22Field.n_data24 : this.n_data24,
      CDataLog22Field.n_data25 : this.n_data25,
      CDataLog22Field.n_data26 : this.n_data26,
      CDataLog22Field.n_data27 : this.n_data27,
      CDataLog22Field.n_data28 : this.n_data28,
      CDataLog22Field.n_data29 : this.n_data29,
      CDataLog22Field.n_data30 : this.n_data30,
      CDataLog22Field.d_data1 : this.d_data1,
      CDataLog22Field.d_data2 : this.d_data2,
      CDataLog22Field.d_data3 : this.d_data3,
      CDataLog22Field.d_data4 : this.d_data4,
      CDataLog22Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_22 実績データログ22のフィールド名設定用クラス
class CDataLog22Field {
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
//region c_data_log_23  実績データログ23
/// c_data_log_23 実績データログ23クラス
class CDataLog23Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_23";

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
      CDataLog23Columns rn = CDataLog23Columns();
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
    CDataLog23Columns rn = CDataLog23Columns();
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
      CDataLog23Field.serial_no : this.serial_no,
      CDataLog23Field.seq_no : this.seq_no,
      CDataLog23Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog23Field.func_cd : this.func_cd,
      CDataLog23Field.func_seq_no : this.func_seq_no,
      CDataLog23Field.c_data1 : this.c_data1,
      CDataLog23Field.c_data2 : this.c_data2,
      CDataLog23Field.c_data3 : this.c_data3,
      CDataLog23Field.c_data4 : this.c_data4,
      CDataLog23Field.c_data5 : this.c_data5,
      CDataLog23Field.c_data6 : this.c_data6,
      CDataLog23Field.c_data7 : this.c_data7,
      CDataLog23Field.c_data8 : this.c_data8,
      CDataLog23Field.c_data9 : this.c_data9,
      CDataLog23Field.c_data10 : this.c_data10,
      CDataLog23Field.n_data1 : this.n_data1,
      CDataLog23Field.n_data2 : this.n_data2,
      CDataLog23Field.n_data3 : this.n_data3,
      CDataLog23Field.n_data4 : this.n_data4,
      CDataLog23Field.n_data5 : this.n_data5,
      CDataLog23Field.n_data6 : this.n_data6,
      CDataLog23Field.n_data7 : this.n_data7,
      CDataLog23Field.n_data8 : this.n_data8,
      CDataLog23Field.n_data9 : this.n_data9,
      CDataLog23Field.n_data10 : this.n_data10,
      CDataLog23Field.n_data11 : this.n_data11,
      CDataLog23Field.n_data12 : this.n_data12,
      CDataLog23Field.n_data13 : this.n_data13,
      CDataLog23Field.n_data14 : this.n_data14,
      CDataLog23Field.n_data15 : this.n_data15,
      CDataLog23Field.n_data16 : this.n_data16,
      CDataLog23Field.n_data17 : this.n_data17,
      CDataLog23Field.n_data18 : this.n_data18,
      CDataLog23Field.n_data19 : this.n_data19,
      CDataLog23Field.n_data20 : this.n_data20,
      CDataLog23Field.n_data21 : this.n_data21,
      CDataLog23Field.n_data22 : this.n_data22,
      CDataLog23Field.n_data23 : this.n_data23,
      CDataLog23Field.n_data24 : this.n_data24,
      CDataLog23Field.n_data25 : this.n_data25,
      CDataLog23Field.n_data26 : this.n_data26,
      CDataLog23Field.n_data27 : this.n_data27,
      CDataLog23Field.n_data28 : this.n_data28,
      CDataLog23Field.n_data29 : this.n_data29,
      CDataLog23Field.n_data30 : this.n_data30,
      CDataLog23Field.d_data1 : this.d_data1,
      CDataLog23Field.d_data2 : this.d_data2,
      CDataLog23Field.d_data3 : this.d_data3,
      CDataLog23Field.d_data4 : this.d_data4,
      CDataLog23Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_23 実績データログ23のフィールド名設定用クラス
class CDataLog23Field {
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
//region c_data_log_24  実績データログ24
/// c_data_log_24 実績データログ24クラス
class CDataLog24Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_24";

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
      CDataLog24Columns rn = CDataLog24Columns();
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
    CDataLog24Columns rn = CDataLog24Columns();
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
      CDataLog24Field.serial_no : this.serial_no,
      CDataLog24Field.seq_no : this.seq_no,
      CDataLog24Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog24Field.func_cd : this.func_cd,
      CDataLog24Field.func_seq_no : this.func_seq_no,
      CDataLog24Field.c_data1 : this.c_data1,
      CDataLog24Field.c_data2 : this.c_data2,
      CDataLog24Field.c_data3 : this.c_data3,
      CDataLog24Field.c_data4 : this.c_data4,
      CDataLog24Field.c_data5 : this.c_data5,
      CDataLog24Field.c_data6 : this.c_data6,
      CDataLog24Field.c_data7 : this.c_data7,
      CDataLog24Field.c_data8 : this.c_data8,
      CDataLog24Field.c_data9 : this.c_data9,
      CDataLog24Field.c_data10 : this.c_data10,
      CDataLog24Field.n_data1 : this.n_data1,
      CDataLog24Field.n_data2 : this.n_data2,
      CDataLog24Field.n_data3 : this.n_data3,
      CDataLog24Field.n_data4 : this.n_data4,
      CDataLog24Field.n_data5 : this.n_data5,
      CDataLog24Field.n_data6 : this.n_data6,
      CDataLog24Field.n_data7 : this.n_data7,
      CDataLog24Field.n_data8 : this.n_data8,
      CDataLog24Field.n_data9 : this.n_data9,
      CDataLog24Field.n_data10 : this.n_data10,
      CDataLog24Field.n_data11 : this.n_data11,
      CDataLog24Field.n_data12 : this.n_data12,
      CDataLog24Field.n_data13 : this.n_data13,
      CDataLog24Field.n_data14 : this.n_data14,
      CDataLog24Field.n_data15 : this.n_data15,
      CDataLog24Field.n_data16 : this.n_data16,
      CDataLog24Field.n_data17 : this.n_data17,
      CDataLog24Field.n_data18 : this.n_data18,
      CDataLog24Field.n_data19 : this.n_data19,
      CDataLog24Field.n_data20 : this.n_data20,
      CDataLog24Field.n_data21 : this.n_data21,
      CDataLog24Field.n_data22 : this.n_data22,
      CDataLog24Field.n_data23 : this.n_data23,
      CDataLog24Field.n_data24 : this.n_data24,
      CDataLog24Field.n_data25 : this.n_data25,
      CDataLog24Field.n_data26 : this.n_data26,
      CDataLog24Field.n_data27 : this.n_data27,
      CDataLog24Field.n_data28 : this.n_data28,
      CDataLog24Field.n_data29 : this.n_data29,
      CDataLog24Field.n_data30 : this.n_data30,
      CDataLog24Field.d_data1 : this.d_data1,
      CDataLog24Field.d_data2 : this.d_data2,
      CDataLog24Field.d_data3 : this.d_data3,
      CDataLog24Field.d_data4 : this.d_data4,
      CDataLog24Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_24 実績データログ24のフィールド名設定用クラス
class CDataLog24Field {
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
//region c_data_log_25  実績データログ25
/// c_data_log_25 実績データログ25クラス
class CDataLog25Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_25";

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
      CDataLog25Columns rn = CDataLog25Columns();
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
    CDataLog25Columns rn = CDataLog25Columns();
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
      CDataLog25Field.serial_no : this.serial_no,
      CDataLog25Field.seq_no : this.seq_no,
      CDataLog25Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog25Field.func_cd : this.func_cd,
      CDataLog25Field.func_seq_no : this.func_seq_no,
      CDataLog25Field.c_data1 : this.c_data1,
      CDataLog25Field.c_data2 : this.c_data2,
      CDataLog25Field.c_data3 : this.c_data3,
      CDataLog25Field.c_data4 : this.c_data4,
      CDataLog25Field.c_data5 : this.c_data5,
      CDataLog25Field.c_data6 : this.c_data6,
      CDataLog25Field.c_data7 : this.c_data7,
      CDataLog25Field.c_data8 : this.c_data8,
      CDataLog25Field.c_data9 : this.c_data9,
      CDataLog25Field.c_data10 : this.c_data10,
      CDataLog25Field.n_data1 : this.n_data1,
      CDataLog25Field.n_data2 : this.n_data2,
      CDataLog25Field.n_data3 : this.n_data3,
      CDataLog25Field.n_data4 : this.n_data4,
      CDataLog25Field.n_data5 : this.n_data5,
      CDataLog25Field.n_data6 : this.n_data6,
      CDataLog25Field.n_data7 : this.n_data7,
      CDataLog25Field.n_data8 : this.n_data8,
      CDataLog25Field.n_data9 : this.n_data9,
      CDataLog25Field.n_data10 : this.n_data10,
      CDataLog25Field.n_data11 : this.n_data11,
      CDataLog25Field.n_data12 : this.n_data12,
      CDataLog25Field.n_data13 : this.n_data13,
      CDataLog25Field.n_data14 : this.n_data14,
      CDataLog25Field.n_data15 : this.n_data15,
      CDataLog25Field.n_data16 : this.n_data16,
      CDataLog25Field.n_data17 : this.n_data17,
      CDataLog25Field.n_data18 : this.n_data18,
      CDataLog25Field.n_data19 : this.n_data19,
      CDataLog25Field.n_data20 : this.n_data20,
      CDataLog25Field.n_data21 : this.n_data21,
      CDataLog25Field.n_data22 : this.n_data22,
      CDataLog25Field.n_data23 : this.n_data23,
      CDataLog25Field.n_data24 : this.n_data24,
      CDataLog25Field.n_data25 : this.n_data25,
      CDataLog25Field.n_data26 : this.n_data26,
      CDataLog25Field.n_data27 : this.n_data27,
      CDataLog25Field.n_data28 : this.n_data28,
      CDataLog25Field.n_data29 : this.n_data29,
      CDataLog25Field.n_data30 : this.n_data30,
      CDataLog25Field.d_data1 : this.d_data1,
      CDataLog25Field.d_data2 : this.d_data2,
      CDataLog25Field.d_data3 : this.d_data3,
      CDataLog25Field.d_data4 : this.d_data4,
      CDataLog25Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_25 実績データログ25のフィールド名設定用クラス
class CDataLog25Field {
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
//region c_data_log_26  実績データログ26
/// c_data_log_26 実績データログ26クラス
class CDataLog26Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_26";

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
      CDataLog26Columns rn = CDataLog26Columns();
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
    CDataLog26Columns rn = CDataLog26Columns();
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
      CDataLog26Field.serial_no : this.serial_no,
      CDataLog26Field.seq_no : this.seq_no,
      CDataLog26Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog26Field.func_cd : this.func_cd,
      CDataLog26Field.func_seq_no : this.func_seq_no,
      CDataLog26Field.c_data1 : this.c_data1,
      CDataLog26Field.c_data2 : this.c_data2,
      CDataLog26Field.c_data3 : this.c_data3,
      CDataLog26Field.c_data4 : this.c_data4,
      CDataLog26Field.c_data5 : this.c_data5,
      CDataLog26Field.c_data6 : this.c_data6,
      CDataLog26Field.c_data7 : this.c_data7,
      CDataLog26Field.c_data8 : this.c_data8,
      CDataLog26Field.c_data9 : this.c_data9,
      CDataLog26Field.c_data10 : this.c_data10,
      CDataLog26Field.n_data1 : this.n_data1,
      CDataLog26Field.n_data2 : this.n_data2,
      CDataLog26Field.n_data3 : this.n_data3,
      CDataLog26Field.n_data4 : this.n_data4,
      CDataLog26Field.n_data5 : this.n_data5,
      CDataLog26Field.n_data6 : this.n_data6,
      CDataLog26Field.n_data7 : this.n_data7,
      CDataLog26Field.n_data8 : this.n_data8,
      CDataLog26Field.n_data9 : this.n_data9,
      CDataLog26Field.n_data10 : this.n_data10,
      CDataLog26Field.n_data11 : this.n_data11,
      CDataLog26Field.n_data12 : this.n_data12,
      CDataLog26Field.n_data13 : this.n_data13,
      CDataLog26Field.n_data14 : this.n_data14,
      CDataLog26Field.n_data15 : this.n_data15,
      CDataLog26Field.n_data16 : this.n_data16,
      CDataLog26Field.n_data17 : this.n_data17,
      CDataLog26Field.n_data18 : this.n_data18,
      CDataLog26Field.n_data19 : this.n_data19,
      CDataLog26Field.n_data20 : this.n_data20,
      CDataLog26Field.n_data21 : this.n_data21,
      CDataLog26Field.n_data22 : this.n_data22,
      CDataLog26Field.n_data23 : this.n_data23,
      CDataLog26Field.n_data24 : this.n_data24,
      CDataLog26Field.n_data25 : this.n_data25,
      CDataLog26Field.n_data26 : this.n_data26,
      CDataLog26Field.n_data27 : this.n_data27,
      CDataLog26Field.n_data28 : this.n_data28,
      CDataLog26Field.n_data29 : this.n_data29,
      CDataLog26Field.n_data30 : this.n_data30,
      CDataLog26Field.d_data1 : this.d_data1,
      CDataLog26Field.d_data2 : this.d_data2,
      CDataLog26Field.d_data3 : this.d_data3,
      CDataLog26Field.d_data4 : this.d_data4,
      CDataLog26Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_26 実績データログ26のフィールド名設定用クラス
class CDataLog26Field {
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
//region c_data_log_27  実績データログ27
/// c_data_log_27 実績データログ27クラス
class CDataLog27Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_27";

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
      CDataLog27Columns rn = CDataLog27Columns();
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
    CDataLog27Columns rn = CDataLog27Columns();
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
      CDataLog27Field.serial_no : this.serial_no,
      CDataLog27Field.seq_no : this.seq_no,
      CDataLog27Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog27Field.func_cd : this.func_cd,
      CDataLog27Field.func_seq_no : this.func_seq_no,
      CDataLog27Field.c_data1 : this.c_data1,
      CDataLog27Field.c_data2 : this.c_data2,
      CDataLog27Field.c_data3 : this.c_data3,
      CDataLog27Field.c_data4 : this.c_data4,
      CDataLog27Field.c_data5 : this.c_data5,
      CDataLog27Field.c_data6 : this.c_data6,
      CDataLog27Field.c_data7 : this.c_data7,
      CDataLog27Field.c_data8 : this.c_data8,
      CDataLog27Field.c_data9 : this.c_data9,
      CDataLog27Field.c_data10 : this.c_data10,
      CDataLog27Field.n_data1 : this.n_data1,
      CDataLog27Field.n_data2 : this.n_data2,
      CDataLog27Field.n_data3 : this.n_data3,
      CDataLog27Field.n_data4 : this.n_data4,
      CDataLog27Field.n_data5 : this.n_data5,
      CDataLog27Field.n_data6 : this.n_data6,
      CDataLog27Field.n_data7 : this.n_data7,
      CDataLog27Field.n_data8 : this.n_data8,
      CDataLog27Field.n_data9 : this.n_data9,
      CDataLog27Field.n_data10 : this.n_data10,
      CDataLog27Field.n_data11 : this.n_data11,
      CDataLog27Field.n_data12 : this.n_data12,
      CDataLog27Field.n_data13 : this.n_data13,
      CDataLog27Field.n_data14 : this.n_data14,
      CDataLog27Field.n_data15 : this.n_data15,
      CDataLog27Field.n_data16 : this.n_data16,
      CDataLog27Field.n_data17 : this.n_data17,
      CDataLog27Field.n_data18 : this.n_data18,
      CDataLog27Field.n_data19 : this.n_data19,
      CDataLog27Field.n_data20 : this.n_data20,
      CDataLog27Field.n_data21 : this.n_data21,
      CDataLog27Field.n_data22 : this.n_data22,
      CDataLog27Field.n_data23 : this.n_data23,
      CDataLog27Field.n_data24 : this.n_data24,
      CDataLog27Field.n_data25 : this.n_data25,
      CDataLog27Field.n_data26 : this.n_data26,
      CDataLog27Field.n_data27 : this.n_data27,
      CDataLog27Field.n_data28 : this.n_data28,
      CDataLog27Field.n_data29 : this.n_data29,
      CDataLog27Field.n_data30 : this.n_data30,
      CDataLog27Field.d_data1 : this.d_data1,
      CDataLog27Field.d_data2 : this.d_data2,
      CDataLog27Field.d_data3 : this.d_data3,
      CDataLog27Field.d_data4 : this.d_data4,
      CDataLog27Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_27 実績データログ27のフィールド名設定用クラス
class CDataLog27Field {
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
//region c_data_log_28  実績データログ28
/// c_data_log_28 実績データログ28クラス
class CDataLog28Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_28";

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
      CDataLog28Columns rn = CDataLog28Columns();
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
    CDataLog28Columns rn = CDataLog28Columns();
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
      CDataLog28Field.serial_no : this.serial_no,
      CDataLog28Field.seq_no : this.seq_no,
      CDataLog28Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog28Field.func_cd : this.func_cd,
      CDataLog28Field.func_seq_no : this.func_seq_no,
      CDataLog28Field.c_data1 : this.c_data1,
      CDataLog28Field.c_data2 : this.c_data2,
      CDataLog28Field.c_data3 : this.c_data3,
      CDataLog28Field.c_data4 : this.c_data4,
      CDataLog28Field.c_data5 : this.c_data5,
      CDataLog28Field.c_data6 : this.c_data6,
      CDataLog28Field.c_data7 : this.c_data7,
      CDataLog28Field.c_data8 : this.c_data8,
      CDataLog28Field.c_data9 : this.c_data9,
      CDataLog28Field.c_data10 : this.c_data10,
      CDataLog28Field.n_data1 : this.n_data1,
      CDataLog28Field.n_data2 : this.n_data2,
      CDataLog28Field.n_data3 : this.n_data3,
      CDataLog28Field.n_data4 : this.n_data4,
      CDataLog28Field.n_data5 : this.n_data5,
      CDataLog28Field.n_data6 : this.n_data6,
      CDataLog28Field.n_data7 : this.n_data7,
      CDataLog28Field.n_data8 : this.n_data8,
      CDataLog28Field.n_data9 : this.n_data9,
      CDataLog28Field.n_data10 : this.n_data10,
      CDataLog28Field.n_data11 : this.n_data11,
      CDataLog28Field.n_data12 : this.n_data12,
      CDataLog28Field.n_data13 : this.n_data13,
      CDataLog28Field.n_data14 : this.n_data14,
      CDataLog28Field.n_data15 : this.n_data15,
      CDataLog28Field.n_data16 : this.n_data16,
      CDataLog28Field.n_data17 : this.n_data17,
      CDataLog28Field.n_data18 : this.n_data18,
      CDataLog28Field.n_data19 : this.n_data19,
      CDataLog28Field.n_data20 : this.n_data20,
      CDataLog28Field.n_data21 : this.n_data21,
      CDataLog28Field.n_data22 : this.n_data22,
      CDataLog28Field.n_data23 : this.n_data23,
      CDataLog28Field.n_data24 : this.n_data24,
      CDataLog28Field.n_data25 : this.n_data25,
      CDataLog28Field.n_data26 : this.n_data26,
      CDataLog28Field.n_data27 : this.n_data27,
      CDataLog28Field.n_data28 : this.n_data28,
      CDataLog28Field.n_data29 : this.n_data29,
      CDataLog28Field.n_data30 : this.n_data30,
      CDataLog28Field.d_data1 : this.d_data1,
      CDataLog28Field.d_data2 : this.d_data2,
      CDataLog28Field.d_data3 : this.d_data3,
      CDataLog28Field.d_data4 : this.d_data4,
      CDataLog28Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_28 実績データログ28のフィールド名設定用クラス
class CDataLog28Field {
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
//region c_data_log_29  実績データログ29
/// c_data_log_29 実績データログ29クラス
class CDataLog29Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_29";

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
      CDataLog29Columns rn = CDataLog29Columns();
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
    CDataLog29Columns rn = CDataLog29Columns();
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
      CDataLog29Field.serial_no : this.serial_no,
      CDataLog29Field.seq_no : this.seq_no,
      CDataLog29Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog29Field.func_cd : this.func_cd,
      CDataLog29Field.func_seq_no : this.func_seq_no,
      CDataLog29Field.c_data1 : this.c_data1,
      CDataLog29Field.c_data2 : this.c_data2,
      CDataLog29Field.c_data3 : this.c_data3,
      CDataLog29Field.c_data4 : this.c_data4,
      CDataLog29Field.c_data5 : this.c_data5,
      CDataLog29Field.c_data6 : this.c_data6,
      CDataLog29Field.c_data7 : this.c_data7,
      CDataLog29Field.c_data8 : this.c_data8,
      CDataLog29Field.c_data9 : this.c_data9,
      CDataLog29Field.c_data10 : this.c_data10,
      CDataLog29Field.n_data1 : this.n_data1,
      CDataLog29Field.n_data2 : this.n_data2,
      CDataLog29Field.n_data3 : this.n_data3,
      CDataLog29Field.n_data4 : this.n_data4,
      CDataLog29Field.n_data5 : this.n_data5,
      CDataLog29Field.n_data6 : this.n_data6,
      CDataLog29Field.n_data7 : this.n_data7,
      CDataLog29Field.n_data8 : this.n_data8,
      CDataLog29Field.n_data9 : this.n_data9,
      CDataLog29Field.n_data10 : this.n_data10,
      CDataLog29Field.n_data11 : this.n_data11,
      CDataLog29Field.n_data12 : this.n_data12,
      CDataLog29Field.n_data13 : this.n_data13,
      CDataLog29Field.n_data14 : this.n_data14,
      CDataLog29Field.n_data15 : this.n_data15,
      CDataLog29Field.n_data16 : this.n_data16,
      CDataLog29Field.n_data17 : this.n_data17,
      CDataLog29Field.n_data18 : this.n_data18,
      CDataLog29Field.n_data19 : this.n_data19,
      CDataLog29Field.n_data20 : this.n_data20,
      CDataLog29Field.n_data21 : this.n_data21,
      CDataLog29Field.n_data22 : this.n_data22,
      CDataLog29Field.n_data23 : this.n_data23,
      CDataLog29Field.n_data24 : this.n_data24,
      CDataLog29Field.n_data25 : this.n_data25,
      CDataLog29Field.n_data26 : this.n_data26,
      CDataLog29Field.n_data27 : this.n_data27,
      CDataLog29Field.n_data28 : this.n_data28,
      CDataLog29Field.n_data29 : this.n_data29,
      CDataLog29Field.n_data30 : this.n_data30,
      CDataLog29Field.d_data1 : this.d_data1,
      CDataLog29Field.d_data2 : this.d_data2,
      CDataLog29Field.d_data3 : this.d_data3,
      CDataLog29Field.d_data4 : this.d_data4,
      CDataLog29Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_29 実績データログ29のフィールド名設定用クラス
class CDataLog29Field {
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
//region c_data_log_30  実績データログ30
/// c_data_log_30 実績データログ30クラス
class CDataLog30Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_30";

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
      CDataLog30Columns rn = CDataLog30Columns();
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
    CDataLog30Columns rn = CDataLog30Columns();
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
      CDataLog30Field.serial_no : this.serial_no,
      CDataLog30Field.seq_no : this.seq_no,
      CDataLog30Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog30Field.func_cd : this.func_cd,
      CDataLog30Field.func_seq_no : this.func_seq_no,
      CDataLog30Field.c_data1 : this.c_data1,
      CDataLog30Field.c_data2 : this.c_data2,
      CDataLog30Field.c_data3 : this.c_data3,
      CDataLog30Field.c_data4 : this.c_data4,
      CDataLog30Field.c_data5 : this.c_data5,
      CDataLog30Field.c_data6 : this.c_data6,
      CDataLog30Field.c_data7 : this.c_data7,
      CDataLog30Field.c_data8 : this.c_data8,
      CDataLog30Field.c_data9 : this.c_data9,
      CDataLog30Field.c_data10 : this.c_data10,
      CDataLog30Field.n_data1 : this.n_data1,
      CDataLog30Field.n_data2 : this.n_data2,
      CDataLog30Field.n_data3 : this.n_data3,
      CDataLog30Field.n_data4 : this.n_data4,
      CDataLog30Field.n_data5 : this.n_data5,
      CDataLog30Field.n_data6 : this.n_data6,
      CDataLog30Field.n_data7 : this.n_data7,
      CDataLog30Field.n_data8 : this.n_data8,
      CDataLog30Field.n_data9 : this.n_data9,
      CDataLog30Field.n_data10 : this.n_data10,
      CDataLog30Field.n_data11 : this.n_data11,
      CDataLog30Field.n_data12 : this.n_data12,
      CDataLog30Field.n_data13 : this.n_data13,
      CDataLog30Field.n_data14 : this.n_data14,
      CDataLog30Field.n_data15 : this.n_data15,
      CDataLog30Field.n_data16 : this.n_data16,
      CDataLog30Field.n_data17 : this.n_data17,
      CDataLog30Field.n_data18 : this.n_data18,
      CDataLog30Field.n_data19 : this.n_data19,
      CDataLog30Field.n_data20 : this.n_data20,
      CDataLog30Field.n_data21 : this.n_data21,
      CDataLog30Field.n_data22 : this.n_data22,
      CDataLog30Field.n_data23 : this.n_data23,
      CDataLog30Field.n_data24 : this.n_data24,
      CDataLog30Field.n_data25 : this.n_data25,
      CDataLog30Field.n_data26 : this.n_data26,
      CDataLog30Field.n_data27 : this.n_data27,
      CDataLog30Field.n_data28 : this.n_data28,
      CDataLog30Field.n_data29 : this.n_data29,
      CDataLog30Field.n_data30 : this.n_data30,
      CDataLog30Field.d_data1 : this.d_data1,
      CDataLog30Field.d_data2 : this.d_data2,
      CDataLog30Field.d_data3 : this.d_data3,
      CDataLog30Field.d_data4 : this.d_data4,
      CDataLog30Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_30 実績データログ30のフィールド名設定用クラス
class CDataLog30Field {
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
//region c_data_log_31  実績データログ31
/// c_data_log_31 実績データログ31クラス
class CDataLog31Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_31";

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
      CDataLog31Columns rn = CDataLog31Columns();
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
    CDataLog31Columns rn = CDataLog31Columns();
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
      CDataLog31Field.serial_no : this.serial_no,
      CDataLog31Field.seq_no : this.seq_no,
      CDataLog31Field.cnct_seq_no : this.cnct_seq_no,
      CDataLog31Field.func_cd : this.func_cd,
      CDataLog31Field.func_seq_no : this.func_seq_no,
      CDataLog31Field.c_data1 : this.c_data1,
      CDataLog31Field.c_data2 : this.c_data2,
      CDataLog31Field.c_data3 : this.c_data3,
      CDataLog31Field.c_data4 : this.c_data4,
      CDataLog31Field.c_data5 : this.c_data5,
      CDataLog31Field.c_data6 : this.c_data6,
      CDataLog31Field.c_data7 : this.c_data7,
      CDataLog31Field.c_data8 : this.c_data8,
      CDataLog31Field.c_data9 : this.c_data9,
      CDataLog31Field.c_data10 : this.c_data10,
      CDataLog31Field.n_data1 : this.n_data1,
      CDataLog31Field.n_data2 : this.n_data2,
      CDataLog31Field.n_data3 : this.n_data3,
      CDataLog31Field.n_data4 : this.n_data4,
      CDataLog31Field.n_data5 : this.n_data5,
      CDataLog31Field.n_data6 : this.n_data6,
      CDataLog31Field.n_data7 : this.n_data7,
      CDataLog31Field.n_data8 : this.n_data8,
      CDataLog31Field.n_data9 : this.n_data9,
      CDataLog31Field.n_data10 : this.n_data10,
      CDataLog31Field.n_data11 : this.n_data11,
      CDataLog31Field.n_data12 : this.n_data12,
      CDataLog31Field.n_data13 : this.n_data13,
      CDataLog31Field.n_data14 : this.n_data14,
      CDataLog31Field.n_data15 : this.n_data15,
      CDataLog31Field.n_data16 : this.n_data16,
      CDataLog31Field.n_data17 : this.n_data17,
      CDataLog31Field.n_data18 : this.n_data18,
      CDataLog31Field.n_data19 : this.n_data19,
      CDataLog31Field.n_data20 : this.n_data20,
      CDataLog31Field.n_data21 : this.n_data21,
      CDataLog31Field.n_data22 : this.n_data22,
      CDataLog31Field.n_data23 : this.n_data23,
      CDataLog31Field.n_data24 : this.n_data24,
      CDataLog31Field.n_data25 : this.n_data25,
      CDataLog31Field.n_data26 : this.n_data26,
      CDataLog31Field.n_data27 : this.n_data27,
      CDataLog31Field.n_data28 : this.n_data28,
      CDataLog31Field.n_data29 : this.n_data29,
      CDataLog31Field.n_data30 : this.n_data30,
      CDataLog31Field.d_data1 : this.d_data1,
      CDataLog31Field.d_data2 : this.d_data2,
      CDataLog31Field.d_data3 : this.d_data3,
      CDataLog31Field.d_data4 : this.d_data4,
      CDataLog31Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_31 実績データログ31のフィールド名設定用クラス
class CDataLog31Field {
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
//region c_data_log_reserv  実績データログ予約
/// c_data_log_reserv 実績データログ予約クラス
class CDataLogReservColumns extends TableColumns{
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
  String _getTableName() => "c_data_log_reserv";

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
      CDataLogReservColumns rn = CDataLogReservColumns();
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
    CDataLogReservColumns rn = CDataLogReservColumns();
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
      CDataLogReservField.serial_no : this.serial_no,
      CDataLogReservField.seq_no : this.seq_no,
      CDataLogReservField.cnct_seq_no : this.cnct_seq_no,
      CDataLogReservField.func_cd : this.func_cd,
      CDataLogReservField.func_seq_no : this.func_seq_no,
      CDataLogReservField.c_data1 : this.c_data1,
      CDataLogReservField.c_data2 : this.c_data2,
      CDataLogReservField.c_data3 : this.c_data3,
      CDataLogReservField.c_data4 : this.c_data4,
      CDataLogReservField.c_data5 : this.c_data5,
      CDataLogReservField.c_data6 : this.c_data6,
      CDataLogReservField.c_data7 : this.c_data7,
      CDataLogReservField.c_data8 : this.c_data8,
      CDataLogReservField.c_data9 : this.c_data9,
      CDataLogReservField.c_data10 : this.c_data10,
      CDataLogReservField.n_data1 : this.n_data1,
      CDataLogReservField.n_data2 : this.n_data2,
      CDataLogReservField.n_data3 : this.n_data3,
      CDataLogReservField.n_data4 : this.n_data4,
      CDataLogReservField.n_data5 : this.n_data5,
      CDataLogReservField.n_data6 : this.n_data6,
      CDataLogReservField.n_data7 : this.n_data7,
      CDataLogReservField.n_data8 : this.n_data8,
      CDataLogReservField.n_data9 : this.n_data9,
      CDataLogReservField.n_data10 : this.n_data10,
      CDataLogReservField.n_data11 : this.n_data11,
      CDataLogReservField.n_data12 : this.n_data12,
      CDataLogReservField.n_data13 : this.n_data13,
      CDataLogReservField.n_data14 : this.n_data14,
      CDataLogReservField.n_data15 : this.n_data15,
      CDataLogReservField.n_data16 : this.n_data16,
      CDataLogReservField.n_data17 : this.n_data17,
      CDataLogReservField.n_data18 : this.n_data18,
      CDataLogReservField.n_data19 : this.n_data19,
      CDataLogReservField.n_data20 : this.n_data20,
      CDataLogReservField.n_data21 : this.n_data21,
      CDataLogReservField.n_data22 : this.n_data22,
      CDataLogReservField.n_data23 : this.n_data23,
      CDataLogReservField.n_data24 : this.n_data24,
      CDataLogReservField.n_data25 : this.n_data25,
      CDataLogReservField.n_data26 : this.n_data26,
      CDataLogReservField.n_data27 : this.n_data27,
      CDataLogReservField.n_data28 : this.n_data28,
      CDataLogReservField.n_data29 : this.n_data29,
      CDataLogReservField.n_data30 : this.n_data30,
      CDataLogReservField.d_data1 : this.d_data1,
      CDataLogReservField.d_data2 : this.d_data2,
      CDataLogReservField.d_data3 : this.d_data3,
      CDataLogReservField.d_data4 : this.d_data4,
      CDataLogReservField.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_reserv 実績データログ予約のフィールド名設定用クラス
class CDataLogReservField {
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
//region c_data_log_reserv_01  実績データログ予約01
/// c_data_log_reserv_01 実績データログ予約01クラス
class CDataLogReserv01Columns extends TableColumns{
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
  String _getTableName() => "c_data_log_reserv_01";

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
      CDataLogReserv01Columns rn = CDataLogReserv01Columns();
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
    CDataLogReserv01Columns rn = CDataLogReserv01Columns();
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
      CDataLogReserv01Field.serial_no : this.serial_no,
      CDataLogReserv01Field.seq_no : this.seq_no,
      CDataLogReserv01Field.cnct_seq_no : this.cnct_seq_no,
      CDataLogReserv01Field.func_cd : this.func_cd,
      CDataLogReserv01Field.func_seq_no : this.func_seq_no,
      CDataLogReserv01Field.c_data1 : this.c_data1,
      CDataLogReserv01Field.c_data2 : this.c_data2,
      CDataLogReserv01Field.c_data3 : this.c_data3,
      CDataLogReserv01Field.c_data4 : this.c_data4,
      CDataLogReserv01Field.c_data5 : this.c_data5,
      CDataLogReserv01Field.c_data6 : this.c_data6,
      CDataLogReserv01Field.c_data7 : this.c_data7,
      CDataLogReserv01Field.c_data8 : this.c_data8,
      CDataLogReserv01Field.c_data9 : this.c_data9,
      CDataLogReserv01Field.c_data10 : this.c_data10,
      CDataLogReserv01Field.n_data1 : this.n_data1,
      CDataLogReserv01Field.n_data2 : this.n_data2,
      CDataLogReserv01Field.n_data3 : this.n_data3,
      CDataLogReserv01Field.n_data4 : this.n_data4,
      CDataLogReserv01Field.n_data5 : this.n_data5,
      CDataLogReserv01Field.n_data6 : this.n_data6,
      CDataLogReserv01Field.n_data7 : this.n_data7,
      CDataLogReserv01Field.n_data8 : this.n_data8,
      CDataLogReserv01Field.n_data9 : this.n_data9,
      CDataLogReserv01Field.n_data10 : this.n_data10,
      CDataLogReserv01Field.n_data11 : this.n_data11,
      CDataLogReserv01Field.n_data12 : this.n_data12,
      CDataLogReserv01Field.n_data13 : this.n_data13,
      CDataLogReserv01Field.n_data14 : this.n_data14,
      CDataLogReserv01Field.n_data15 : this.n_data15,
      CDataLogReserv01Field.n_data16 : this.n_data16,
      CDataLogReserv01Field.n_data17 : this.n_data17,
      CDataLogReserv01Field.n_data18 : this.n_data18,
      CDataLogReserv01Field.n_data19 : this.n_data19,
      CDataLogReserv01Field.n_data20 : this.n_data20,
      CDataLogReserv01Field.n_data21 : this.n_data21,
      CDataLogReserv01Field.n_data22 : this.n_data22,
      CDataLogReserv01Field.n_data23 : this.n_data23,
      CDataLogReserv01Field.n_data24 : this.n_data24,
      CDataLogReserv01Field.n_data25 : this.n_data25,
      CDataLogReserv01Field.n_data26 : this.n_data26,
      CDataLogReserv01Field.n_data27 : this.n_data27,
      CDataLogReserv01Field.n_data28 : this.n_data28,
      CDataLogReserv01Field.n_data29 : this.n_data29,
      CDataLogReserv01Field.n_data30 : this.n_data30,
      CDataLogReserv01Field.d_data1 : this.d_data1,
      CDataLogReserv01Field.d_data2 : this.d_data2,
      CDataLogReserv01Field.d_data3 : this.d_data3,
      CDataLogReserv01Field.d_data4 : this.d_data4,
      CDataLogReserv01Field.d_data5 : this.d_data5,
    };
  }
}

/// c_data_log_reserv_01 実績データログ予約01のフィールド名設定用クラス
class CDataLogReserv01Field {
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
