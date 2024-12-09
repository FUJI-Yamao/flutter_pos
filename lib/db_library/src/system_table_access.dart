/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
10_システム系
10_1	履歴ログ	c_histlog_mst
10_2	レジ履歴ログカウント	c_histlog_chg_cnt
10_3	履歴ログ制御コントロールマスタ	hist_ctrl_mst
10_4	履歴ログスキップ番号	histlog_skip_num
 */

//region 10_1	履歴ログ	c_histlog_mst
/// 10_1  履歴ログ c_histlog_mstクラス
class CHistlogMstColumns extends TableColumns{
  int? hist_cd;
  String? ins_datetime;
  int comp_cd = 0;
  int stre_cd = 0;
  String? table_name;
  int mode = 0;
  int? mac_flg;
  String? data1;
  String? data2;

  @override
  String _getTableName() => "c_histlog_mst";

  @override
  String? _getKeyCondition() => 'hist_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(hist_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CHistlogMstColumns rn = CHistlogMstColumns();
      rn.hist_cd = maps[i]['hist_cd'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.table_name = maps[i]['table_name'];
      rn.mode = maps[i]['mode'];
      rn.mac_flg = maps[i]['mac_flg'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CHistlogMstColumns rn = CHistlogMstColumns();
    rn.hist_cd = maps[0]['hist_cd'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.table_name = maps[0]['table_name'];
    rn.mode = maps[0]['mode'];
    rn.mac_flg = maps[0]['mac_flg'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CHistlogMstField.hist_cd : this.hist_cd,
      CHistlogMstField.ins_datetime : this.ins_datetime,
      CHistlogMstField.comp_cd : this.comp_cd,
      CHistlogMstField.stre_cd : this.stre_cd,
      CHistlogMstField.table_name : this.table_name,
      CHistlogMstField.mode : this.mode,
      CHistlogMstField.mac_flg : this.mac_flg,
      CHistlogMstField.data1 : this.data1,
      CHistlogMstField.data2 : this.data2,
    };
  }
}

/// 10_1  履歴ログ c_histlog_mstのフィールド名設定用クラス
class CHistlogMstField {
  static const hist_cd = "hist_cd";
  static const ins_datetime = "ins_datetime";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const table_name = "table_name";
  static const mode = "mode";
  static const mac_flg = "mac_flg";
  static const data1 = "data1";
  static const data2 = "data2";
}
//endregion
//region 10_2	レジ履歴ログカウント	c_histlog_chg_cnt
/// 10_2  レジ履歴ログカウント c_histlog_chg_cntクラス
class CHistlogChgCntColumns extends TableColumns{
  int? counter_cd;
  int? hist_cd;
  String? ins_datetime;

  @override
  String _getTableName() => "c_histlog_chg_cnt";

  @override
  String? _getKeyCondition() => 'counter_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(counter_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CHistlogChgCntColumns rn = CHistlogChgCntColumns();
      rn.counter_cd = maps[i]['counter_cd'];
      rn.hist_cd = maps[i]['hist_cd'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CHistlogChgCntColumns rn = CHistlogChgCntColumns();
    rn.counter_cd = maps[0]['counter_cd'];
    rn.hist_cd = maps[0]['hist_cd'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CHistlogChgCntField.counter_cd : this.counter_cd,
      CHistlogChgCntField.hist_cd : this.hist_cd,
      CHistlogChgCntField.ins_datetime : this.ins_datetime,
    };
  }
}

/// 10_2  レジ履歴ログカウント c_histlog_chg_cntのフィールド名設定用クラス
class CHistlogChgCntField {
  static const counter_cd = "counter_cd";
  static const hist_cd = "hist_cd";
  static const ins_datetime = "ins_datetime";
}
//endregion
//region 10_3	履歴ログ制御コントロールマスタ	hist_ctrl_mst
/// 10_3  履歴ログ制御コントロールマスタ  hist_ctrl_mstクラス
class HistCtrlMstColumns extends TableColumns{
  int? ctrl_cd;
  int? flg1;
  int? flg2;
  int? flg3;
  int? flg4;
  int? flg5;
  int? flg6;
  int? flg7;
  int? flg8;
  int? flg9;
  int? flg10;

  @override
  String _getTableName() => "hist_ctrl_mst";

  @override
  String? _getKeyCondition() => 'ctrl_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(ctrl_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      HistCtrlMstColumns rn = HistCtrlMstColumns();
      rn.ctrl_cd = maps[i]['ctrl_cd'];
      rn.flg1 = maps[i]['flg1'];
      rn.flg2 = maps[i]['flg2'];
      rn.flg3 = maps[i]['flg3'];
      rn.flg4 = maps[i]['flg4'];
      rn.flg5 = maps[i]['flg5'];
      rn.flg6 = maps[i]['flg6'];
      rn.flg7 = maps[i]['flg7'];
      rn.flg8 = maps[i]['flg8'];
      rn.flg9 = maps[i]['flg9'];
      rn.flg10 = maps[i]['flg10'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    HistCtrlMstColumns rn = HistCtrlMstColumns();
    rn.ctrl_cd = maps[0]['ctrl_cd'];
    rn.flg1 = maps[0]['flg1'];
    rn.flg2 = maps[0]['flg2'];
    rn.flg3 = maps[0]['flg3'];
    rn.flg4 = maps[0]['flg4'];
    rn.flg5 = maps[0]['flg5'];
    rn.flg6 = maps[0]['flg6'];
    rn.flg7 = maps[0]['flg7'];
    rn.flg8 = maps[0]['flg8'];
    rn.flg9 = maps[0]['flg9'];
    rn.flg10 = maps[0]['flg10'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      HistCtrlMstField.ctrl_cd : this.ctrl_cd,
      HistCtrlMstField.flg1 : this.flg1,
      HistCtrlMstField.flg2 : this.flg2,
      HistCtrlMstField.flg3 : this.flg3,
      HistCtrlMstField.flg4 : this.flg4,
      HistCtrlMstField.flg5 : this.flg5,
      HistCtrlMstField.flg6 : this.flg6,
      HistCtrlMstField.flg7 : this.flg7,
      HistCtrlMstField.flg8 : this.flg8,
      HistCtrlMstField.flg9 : this.flg9,
      HistCtrlMstField.flg10 : this.flg10,
    };
  }
}

/// 10_3  履歴ログ制御コントロールマスタ  hist_ctrl_mstのフィールド名設定用クラス
class HistCtrlMstField {
  static const ctrl_cd = "ctrl_cd";
  static const flg1 = "flg1";
  static const flg2 = "flg2";
  static const flg3 = "flg3";
  static const flg4 = "flg4";
  static const flg5 = "flg5";
  static const flg6 = "flg6";
  static const flg7 = "flg7";
  static const flg8 = "flg8";
  static const flg9 = "flg9";
  static const flg10 = "flg10";
}
//endregion
//region 10_4	履歴ログスキップ番号	histlog_skip_num
/// 10_4  履歴ログスキップ番号 histlog_skip_numクラス
class HistlogSkipNumColumns extends TableColumns{
  int? hist_cd;

  @override
  String _getTableName() => "histlog_skip_num";

  @override
  String? _getKeyCondition() => 'hist_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(hist_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      HistlogSkipNumColumns rn = HistlogSkipNumColumns();
      rn.hist_cd = maps[i]['hist_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    HistlogSkipNumColumns rn = HistlogSkipNumColumns();
    rn.hist_cd = maps[0]['hist_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      HistlogSkipNumField.hist_cd : this.hist_cd,
    };
  }
}

/// 10_4  履歴ログスキップ番号 histlog_skip_numのフィールド名設定用クラス
class HistlogSkipNumField {
  static const hist_cd = "hist_cd";
}
//endregion