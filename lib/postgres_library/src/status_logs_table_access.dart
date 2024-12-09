/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
実績ステータスログ 日付別
c_status_log_01	実績ステータスログ01
c_status_log_02	実績ステータスログ02
c_status_log_03	実績ステータスログ03
c_status_log_04	実績ステータスログ04
c_status_log_05	実績ステータスログ05
c_status_log_06	実績ステータスログ06
c_status_log_07	実績ステータスログ07
c_status_log_08	実績ステータスログ08
c_status_log_09	実績ステータスログ09
c_status_log_10	実績ステータスログ10
c_status_log_11	実績ステータスログ11
c_status_log_12	実績ステータスログ12
c_status_log_13	実績ステータスログ13
c_status_log_14	実績ステータスログ14
c_status_log_15	実績ステータスログ15
c_status_log_16	実績ステータスログ16
c_status_log_17	実績ステータスログ17
c_status_log_18	実績ステータスログ18
c_status_log_19	実績ステータスログ19
c_status_log_20	実績ステータスログ20
c_status_log_21	実績ステータスログ21
c_status_log_22	実績ステータスログ22
c_status_log_23	実績ステータスログ23
c_status_log_24	実績ステータスログ24
c_status_log_25	実績ステータスログ25
c_status_log_26	実績ステータスログ26
c_status_log_27	実績ステータスログ27
c_status_log_28	実績ステータスログ28
c_status_log_29	実績ステータスログ29
c_status_log_30	実績ステータスログ30
c_status_log_31	実績ステータスログ31
c_status_log_reserv	実績ステータスログ予約
c_status_log_reserv_01	実績ステータスログ予約01
 */

//region c_status_log_01  実績ステータスログ01
/// c_status_log_01 実績ステータスログ01クラス
class CStatusLog01Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_01";

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
      CStatusLog01Columns rn = CStatusLog01Columns();
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
    CStatusLog01Columns rn = CStatusLog01Columns();
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
      CStatusLog01Field.serial_no : this.serial_no,
      CStatusLog01Field.seq_no : this.seq_no,
      CStatusLog01Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog01Field.func_cd : this.func_cd,
      CStatusLog01Field.func_seq_no : this.func_seq_no,
      CStatusLog01Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_01 実績ステータスログ01のフィールド名設定用クラス
class CStatusLog01Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_02  実績ステータスログ02
/// c_status_log_02 実績ステータスログ02クラス
class CStatusLog02Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_02";

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
      CStatusLog02Columns rn = CStatusLog02Columns();
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
    CStatusLog02Columns rn = CStatusLog02Columns();
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
      CStatusLog02Field.serial_no : this.serial_no,
      CStatusLog02Field.seq_no : this.seq_no,
      CStatusLog02Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog02Field.func_cd : this.func_cd,
      CStatusLog02Field.func_seq_no : this.func_seq_no,
      CStatusLog02Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_02 実績ステータスログ02のフィールド名設定用クラス
class CStatusLog02Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_03  実績ステータスログ03
/// c_status_log_03 実績ステータスログ03クラス
class CStatusLog03Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_03";

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
      CStatusLog03Columns rn = CStatusLog03Columns();
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
    CStatusLog03Columns rn = CStatusLog03Columns();
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
      CStatusLog03Field.serial_no : this.serial_no,
      CStatusLog03Field.seq_no : this.seq_no,
      CStatusLog03Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog03Field.func_cd : this.func_cd,
      CStatusLog03Field.func_seq_no : this.func_seq_no,
      CStatusLog03Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_03 実績ステータスログ03のフィールド名設定用クラス
class CStatusLog03Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_04  実績ステータスログ04
/// c_status_log_04 実績ステータスログ04クラス
class CStatusLog04Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_04";

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
      CStatusLog04Columns rn = CStatusLog04Columns();
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
    CStatusLog04Columns rn = CStatusLog04Columns();
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
      CStatusLog04Field.serial_no : this.serial_no,
      CStatusLog04Field.seq_no : this.seq_no,
      CStatusLog04Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog04Field.func_cd : this.func_cd,
      CStatusLog04Field.func_seq_no : this.func_seq_no,
      CStatusLog04Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_04 実績ステータスログ04のフィールド名設定用クラス
class CStatusLog04Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_05  実績ステータスログ05
/// c_status_log_05 実績ステータスログ05クラス
class CStatusLog05Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_05";

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
      CStatusLog05Columns rn = CStatusLog05Columns();
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
    CStatusLog05Columns rn = CStatusLog05Columns();
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
      CStatusLog05Field.serial_no : this.serial_no,
      CStatusLog05Field.seq_no : this.seq_no,
      CStatusLog05Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog05Field.func_cd : this.func_cd,
      CStatusLog05Field.func_seq_no : this.func_seq_no,
      CStatusLog05Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_05 実績ステータスログ05のフィールド名設定用クラス
class CStatusLog05Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_06  実績ステータスログ06
/// c_status_log_06 実績ステータスログ06クラス
class CStatusLog06Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_06";

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
      CStatusLog06Columns rn = CStatusLog06Columns();
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
    CStatusLog06Columns rn = CStatusLog06Columns();
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
      CStatusLog06Field.serial_no : this.serial_no,
      CStatusLog06Field.seq_no : this.seq_no,
      CStatusLog06Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog06Field.func_cd : this.func_cd,
      CStatusLog06Field.func_seq_no : this.func_seq_no,
      CStatusLog06Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_06 実績ステータスログ06のフィールド名設定用クラス
class CStatusLog06Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_07  実績ステータスログ07
/// c_status_log_07 実績ステータスログ07クラス
class CStatusLog07Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_07";

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
      CStatusLog07Columns rn = CStatusLog07Columns();
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
    CStatusLog07Columns rn = CStatusLog07Columns();
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
      CStatusLog07Field.serial_no : this.serial_no,
      CStatusLog07Field.seq_no : this.seq_no,
      CStatusLog07Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog07Field.func_cd : this.func_cd,
      CStatusLog07Field.func_seq_no : this.func_seq_no,
      CStatusLog07Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_07 実績ステータスログ07のフィールド名設定用クラス
class CStatusLog07Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_08  実績ステータスログ08
/// c_status_log_08 実績ステータスログ08クラス
class CStatusLog08Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_08";

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
      CStatusLog08Columns rn = CStatusLog08Columns();
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
    CStatusLog08Columns rn = CStatusLog08Columns();
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
      CStatusLog08Field.serial_no : this.serial_no,
      CStatusLog08Field.seq_no : this.seq_no,
      CStatusLog08Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog08Field.func_cd : this.func_cd,
      CStatusLog08Field.func_seq_no : this.func_seq_no,
      CStatusLog08Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_08 実績ステータスログ08のフィールド名設定用クラス
class CStatusLog08Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_09  実績ステータスログ09
/// c_status_log_09 実績ステータスログ09クラス
class CStatusLog09Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_09";

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
      CStatusLog09Columns rn = CStatusLog09Columns();
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
    CStatusLog09Columns rn = CStatusLog09Columns();
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
      CStatusLog09Field.serial_no : this.serial_no,
      CStatusLog09Field.seq_no : this.seq_no,
      CStatusLog09Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog09Field.func_cd : this.func_cd,
      CStatusLog09Field.func_seq_no : this.func_seq_no,
      CStatusLog09Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_09 実績ステータスログ09のフィールド名設定用クラス
class CStatusLog09Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_10  実績ステータスログ10
/// c_status_log_10 実績ステータスログ10クラス
class CStatusLog10Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_10";

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
      CStatusLog10Columns rn = CStatusLog10Columns();
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
    CStatusLog10Columns rn = CStatusLog10Columns();
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
      CStatusLog10Field.serial_no : this.serial_no,
      CStatusLog10Field.seq_no : this.seq_no,
      CStatusLog10Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog10Field.func_cd : this.func_cd,
      CStatusLog10Field.func_seq_no : this.func_seq_no,
      CStatusLog10Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_10 実績ステータスログ10のフィールド名設定用クラス
class CStatusLog10Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_11  実績ステータスログ11
/// c_status_log_11 実績ステータスログ11クラス
class CStatusLog11Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_11";

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
      CStatusLog11Columns rn = CStatusLog11Columns();
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
    CStatusLog11Columns rn = CStatusLog11Columns();
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
      CStatusLog11Field.serial_no : this.serial_no,
      CStatusLog11Field.seq_no : this.seq_no,
      CStatusLog11Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog11Field.func_cd : this.func_cd,
      CStatusLog11Field.func_seq_no : this.func_seq_no,
      CStatusLog11Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_11 実績ステータスログ11のフィールド名設定用クラス
class CStatusLog11Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_12  実績ステータスログ12
/// c_status_log_12 実績ステータスログ12クラス
class CStatusLog12Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_12";

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
      CStatusLog12Columns rn = CStatusLog12Columns();
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
    CStatusLog12Columns rn = CStatusLog12Columns();
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
      CStatusLog12Field.serial_no : this.serial_no,
      CStatusLog12Field.seq_no : this.seq_no,
      CStatusLog12Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog12Field.func_cd : this.func_cd,
      CStatusLog12Field.func_seq_no : this.func_seq_no,
      CStatusLog12Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_12 実績ステータスログ12のフィールド名設定用クラス
class CStatusLog12Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_13  実績ステータスログ13
/// c_status_log_13 実績ステータスログ13クラス
class CStatusLog13Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_13";

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
      CStatusLog13Columns rn = CStatusLog13Columns();
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
    CStatusLog13Columns rn = CStatusLog13Columns();
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
      CStatusLog13Field.serial_no : this.serial_no,
      CStatusLog13Field.seq_no : this.seq_no,
      CStatusLog13Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog13Field.func_cd : this.func_cd,
      CStatusLog13Field.func_seq_no : this.func_seq_no,
      CStatusLog13Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_13 実績ステータスログ13のフィールド名設定用クラス
class CStatusLog13Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_14  実績ステータスログ14
/// c_status_log_14 実績ステータスログ14クラス
class CStatusLog14Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_14";

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
      CStatusLog14Columns rn = CStatusLog14Columns();
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
    CStatusLog14Columns rn = CStatusLog14Columns();
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
      CStatusLog14Field.serial_no : this.serial_no,
      CStatusLog14Field.seq_no : this.seq_no,
      CStatusLog14Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog14Field.func_cd : this.func_cd,
      CStatusLog14Field.func_seq_no : this.func_seq_no,
      CStatusLog14Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_14 実績ステータスログ14のフィールド名設定用クラス
class CStatusLog14Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_15  実績ステータスログ15
/// c_status_log_15 実績ステータスログ15クラス
class CStatusLog15Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_15";

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
      CStatusLog15Columns rn = CStatusLog15Columns();
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
    CStatusLog15Columns rn = CStatusLog15Columns();
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
      CStatusLog15Field.serial_no : this.serial_no,
      CStatusLog15Field.seq_no : this.seq_no,
      CStatusLog15Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog15Field.func_cd : this.func_cd,
      CStatusLog15Field.func_seq_no : this.func_seq_no,
      CStatusLog15Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_15 実績ステータスログ15のフィールド名設定用クラス
class CStatusLog15Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_16  実績ステータスログ16
/// c_status_log_16 実績ステータスログ16クラス
class CStatusLog16Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_16";

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
      CStatusLog16Columns rn = CStatusLog16Columns();
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
    CStatusLog16Columns rn = CStatusLog16Columns();
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
      CStatusLog16Field.serial_no : this.serial_no,
      CStatusLog16Field.seq_no : this.seq_no,
      CStatusLog16Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog16Field.func_cd : this.func_cd,
      CStatusLog16Field.func_seq_no : this.func_seq_no,
      CStatusLog16Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_16 実績ステータスログ16のフィールド名設定用クラス
class CStatusLog16Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_17  実績ステータスログ17
/// c_status_log_17 実績ステータスログ17クラス
class CStatusLog17Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_17";

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
      CStatusLog17Columns rn = CStatusLog17Columns();
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
    CStatusLog17Columns rn = CStatusLog17Columns();
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
      CStatusLog17Field.serial_no : this.serial_no,
      CStatusLog17Field.seq_no : this.seq_no,
      CStatusLog17Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog17Field.func_cd : this.func_cd,
      CStatusLog17Field.func_seq_no : this.func_seq_no,
      CStatusLog17Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_17 実績ステータスログ17のフィールド名設定用クラス
class CStatusLog17Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_18  実績ステータスログ18
/// c_status_log_18 実績ステータスログ18クラス
class CStatusLog18Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_18";

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
      CStatusLog18Columns rn = CStatusLog18Columns();
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
    CStatusLog18Columns rn = CStatusLog18Columns();
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
      CStatusLog18Field.serial_no : this.serial_no,
      CStatusLog18Field.seq_no : this.seq_no,
      CStatusLog18Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog18Field.func_cd : this.func_cd,
      CStatusLog18Field.func_seq_no : this.func_seq_no,
      CStatusLog18Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_18 実績ステータスログ18のフィールド名設定用クラス
class CStatusLog18Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_19  実績ステータスログ19
/// c_status_log_19 実績ステータスログ19クラス
class CStatusLog19Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_19";

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
      CStatusLog19Columns rn = CStatusLog19Columns();
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
    CStatusLog19Columns rn = CStatusLog19Columns();
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
      CStatusLog19Field.serial_no : this.serial_no,
      CStatusLog19Field.seq_no : this.seq_no,
      CStatusLog19Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog19Field.func_cd : this.func_cd,
      CStatusLog19Field.func_seq_no : this.func_seq_no,
      CStatusLog19Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_19 実績ステータスログ19のフィールド名設定用クラス
class CStatusLog19Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_20  実績ステータスログ20
/// c_status_log_20 実績ステータスログ20クラス
class CStatusLog20Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_20";

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
      CStatusLog20Columns rn = CStatusLog20Columns();
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
    CStatusLog20Columns rn = CStatusLog20Columns();
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
      CStatusLog20Field.serial_no : this.serial_no,
      CStatusLog20Field.seq_no : this.seq_no,
      CStatusLog20Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog20Field.func_cd : this.func_cd,
      CStatusLog20Field.func_seq_no : this.func_seq_no,
      CStatusLog20Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_20 実績ステータスログ20のフィールド名設定用クラス
class CStatusLog20Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_21  実績ステータスログ21
/// c_status_log_21 実績ステータスログ21クラス
class CStatusLog21Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_21";

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
      CStatusLog21Columns rn = CStatusLog21Columns();
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
    CStatusLog21Columns rn = CStatusLog21Columns();
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
      CStatusLog21Field.serial_no : this.serial_no,
      CStatusLog21Field.seq_no : this.seq_no,
      CStatusLog21Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog21Field.func_cd : this.func_cd,
      CStatusLog21Field.func_seq_no : this.func_seq_no,
      CStatusLog21Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_21 実績ステータスログ21のフィールド名設定用クラス
class CStatusLog21Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_22  実績ステータスログ22
/// c_status_log_22 実績ステータスログ22クラス
class CStatusLog22Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_22";

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
      CStatusLog22Columns rn = CStatusLog22Columns();
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
    CStatusLog22Columns rn = CStatusLog22Columns();
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
      CStatusLog22Field.serial_no : this.serial_no,
      CStatusLog22Field.seq_no : this.seq_no,
      CStatusLog22Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog22Field.func_cd : this.func_cd,
      CStatusLog22Field.func_seq_no : this.func_seq_no,
      CStatusLog22Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_22 実績ステータスログ22のフィールド名設定用クラス
class CStatusLog22Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_23  実績ステータスログ23
/// c_status_log_23 実績ステータスログ23クラス
class CStatusLog23Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_23";

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
      CStatusLog23Columns rn = CStatusLog23Columns();
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
    CStatusLog23Columns rn = CStatusLog23Columns();
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
      CStatusLog23Field.serial_no : this.serial_no,
      CStatusLog23Field.seq_no : this.seq_no,
      CStatusLog23Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog23Field.func_cd : this.func_cd,
      CStatusLog23Field.func_seq_no : this.func_seq_no,
      CStatusLog23Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_23 実績ステータスログ23のフィールド名設定用クラス
class CStatusLog23Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_24  実績ステータスログ24
/// c_status_log_24 実績ステータスログ24クラス
class CStatusLog24Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_24";

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
      CStatusLog24Columns rn = CStatusLog24Columns();
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
    CStatusLog24Columns rn = CStatusLog24Columns();
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
      CStatusLog24Field.serial_no : this.serial_no,
      CStatusLog24Field.seq_no : this.seq_no,
      CStatusLog24Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog24Field.func_cd : this.func_cd,
      CStatusLog24Field.func_seq_no : this.func_seq_no,
      CStatusLog24Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_24 実績ステータスログ24のフィールド名設定用クラス
class CStatusLog24Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_25  実績ステータスログ25
/// c_status_log_25 実績ステータスログ25クラス
class CStatusLog25Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_25";

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
      CStatusLog25Columns rn = CStatusLog25Columns();
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
    CStatusLog25Columns rn = CStatusLog25Columns();
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
      CStatusLog25Field.serial_no : this.serial_no,
      CStatusLog25Field.seq_no : this.seq_no,
      CStatusLog25Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog25Field.func_cd : this.func_cd,
      CStatusLog25Field.func_seq_no : this.func_seq_no,
      CStatusLog25Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_25 実績ステータスログ25のフィールド名設定用クラス
class CStatusLog25Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_26  実績ステータスログ26
/// c_status_log_26 実績ステータスログ26クラス
class CStatusLog26Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_26";

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
      CStatusLog26Columns rn = CStatusLog26Columns();
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
    CStatusLog26Columns rn = CStatusLog26Columns();
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
      CStatusLog26Field.serial_no : this.serial_no,
      CStatusLog26Field.seq_no : this.seq_no,
      CStatusLog26Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog26Field.func_cd : this.func_cd,
      CStatusLog26Field.func_seq_no : this.func_seq_no,
      CStatusLog26Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_26 実績ステータスログ26のフィールド名設定用クラス
class CStatusLog26Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_27  実績ステータスログ27
/// c_status_log_27 実績ステータスログ27クラス
class CStatusLog27Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_27";

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
      CStatusLog27Columns rn = CStatusLog27Columns();
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
    CStatusLog27Columns rn = CStatusLog27Columns();
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
      CStatusLog27Field.serial_no : this.serial_no,
      CStatusLog27Field.seq_no : this.seq_no,
      CStatusLog27Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog27Field.func_cd : this.func_cd,
      CStatusLog27Field.func_seq_no : this.func_seq_no,
      CStatusLog27Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_27 実績ステータスログ27のフィールド名設定用クラス
class CStatusLog27Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_28  実績ステータスログ28
/// c_status_log_28 実績ステータスログ28クラス
class CStatusLog28Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_28";

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
      CStatusLog28Columns rn = CStatusLog28Columns();
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
    CStatusLog28Columns rn = CStatusLog28Columns();
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
      CStatusLog28Field.serial_no : this.serial_no,
      CStatusLog28Field.seq_no : this.seq_no,
      CStatusLog28Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog28Field.func_cd : this.func_cd,
      CStatusLog28Field.func_seq_no : this.func_seq_no,
      CStatusLog28Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_28 実績ステータスログ28のフィールド名設定用クラス
class CStatusLog28Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_29  実績ステータスログ29
/// c_status_log_29 実績ステータスログ29クラス
class CStatusLog29Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_29";

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
      CStatusLog29Columns rn = CStatusLog29Columns();
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
    CStatusLog29Columns rn = CStatusLog29Columns();
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
      CStatusLog29Field.serial_no : this.serial_no,
      CStatusLog29Field.seq_no : this.seq_no,
      CStatusLog29Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog29Field.func_cd : this.func_cd,
      CStatusLog29Field.func_seq_no : this.func_seq_no,
      CStatusLog29Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_29 実績ステータスログ29のフィールド名設定用クラス
class CStatusLog29Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_30  実績ステータスログ30
/// c_status_log_30 実績ステータスログ30クラス
class CStatusLog30Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_30";

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
      CStatusLog30Columns rn = CStatusLog30Columns();
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
    CStatusLog30Columns rn = CStatusLog30Columns();
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
      CStatusLog30Field.serial_no : this.serial_no,
      CStatusLog30Field.seq_no : this.seq_no,
      CStatusLog30Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog30Field.func_cd : this.func_cd,
      CStatusLog30Field.func_seq_no : this.func_seq_no,
      CStatusLog30Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_30 実績ステータスログ30のフィールド名設定用クラス
class CStatusLog30Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_31  実績ステータスログ31
/// c_status_log_31 実績ステータスログ31クラス
class CStatusLog31Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_31";

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
      CStatusLog31Columns rn = CStatusLog31Columns();
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
    CStatusLog31Columns rn = CStatusLog31Columns();
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
      CStatusLog31Field.serial_no : this.serial_no,
      CStatusLog31Field.seq_no : this.seq_no,
      CStatusLog31Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLog31Field.func_cd : this.func_cd,
      CStatusLog31Field.func_seq_no : this.func_seq_no,
      CStatusLog31Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_31 実績ステータスログ31のフィールド名設定用クラス
class CStatusLog31Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_reserv  実績ステータスログ予約
/// c_status_log_reserv 実績ステータスログ予約クラス
class CStatusLogReservColumns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_reserv";

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
      CStatusLogReservColumns rn = CStatusLogReservColumns();
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
    CStatusLogReservColumns rn = CStatusLogReservColumns();
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
      CStatusLogReservField.serial_no : this.serial_no,
      CStatusLogReservField.seq_no : this.seq_no,
      CStatusLogReservField.cnct_seq_no : this.cnct_seq_no,
      CStatusLogReservField.func_cd : this.func_cd,
      CStatusLogReservField.func_seq_no : this.func_seq_no,
      CStatusLogReservField.status_data : this.status_data,
    };
  }
}

/// c_status_log_reserv 実績ステータスログ予約のフィールド名設定用クラス
class CStatusLogReservField {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion
//region c_status_log_reserv_01  実績ステータスログ予約01
/// c_status_log_reserv_01 実績ステータスログ予約01クラス
class CStatusLogReserv01Columns extends TableColumns{
  String? serial_no = '0';
  int? seq_no;
  int cnct_seq_no = 0;
  int func_cd = 0;
  int func_seq_no = 0;
  String? status_data;

  @override
  String _getTableName() => "c_status_log_reserv_01";

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
      CStatusLogReserv01Columns rn = CStatusLogReserv01Columns();
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
    CStatusLogReserv01Columns rn = CStatusLogReserv01Columns();
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
      CStatusLogReserv01Field.serial_no : this.serial_no,
      CStatusLogReserv01Field.seq_no : this.seq_no,
      CStatusLogReserv01Field.cnct_seq_no : this.cnct_seq_no,
      CStatusLogReserv01Field.func_cd : this.func_cd,
      CStatusLogReserv01Field.func_seq_no : this.func_seq_no,
      CStatusLogReserv01Field.status_data : this.status_data,
    };
  }
}

/// c_status_log_reserv_01 実績ステータスログ予約01のフィールド名設定用クラス
class CStatusLogReserv01Field {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const cnct_seq_no = "cnct_seq_no";
  static const func_cd = "func_cd";
  static const func_seq_no = "func_seq_no";
  static const status_data = "status_data";
}
//endregion