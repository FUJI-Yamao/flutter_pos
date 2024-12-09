/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';

/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
p_regcounter_log CLxOSレジごとのカウンター
 */

// p_regcounter_log
class PRecogCounterLogColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  String? sale_date;
  String? last_sale_date;
  String? ins_datetime;
  String? upd_datetime;
  Map<String, dynamic> cnt_json_data = {};

  // Map<String, dynamic>? cnt_json_data = {
  //   "receipt_no" : 0,
  //   "print_no": 0,
  //   "rcpt_print_no" : 0
  // }; // jsonデータ

  @override
  String _getTableName() => "c_reginfo_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PRecogCounterLogColumns rn = PRecogCounterLogColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.last_sale_date = maps[i]['last_sale_date'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.cnt_json_data = maps[i]['cnt_json_data'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PRecogCounterLogColumns rn = PRecogCounterLogColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.last_sale_date = maps[0]['last_sale_date'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.cnt_json_data = maps[0]['cnt_json_data'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PRecogCounterLogField.comp_cd:this.comp_cd,
      PRecogCounterLogField.stre_cd:this.stre_cd,
      PRecogCounterLogField.mac_no:this.mac_no,
      PRecogCounterLogField.sale_date:this.sale_date,
      PRecogCounterLogField.last_sale_date:this.last_sale_date,
      PRecogCounterLogField.ins_datetime:this.ins_datetime,
      PRecogCounterLogField.upd_datetime:this.upd_datetime,
      PRecogCounterLogField.cnt_json_data:this.cnt_json_data,
    };
  }
}

class PRecogCounterLogField{
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const sale_date = "sale_date";
  static const last_sale_date = "last_sale_date";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const cnt_json_data = "cnt_json_data";
}