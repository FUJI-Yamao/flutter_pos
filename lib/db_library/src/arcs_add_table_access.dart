/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
arcs_アークス様用追加テーブル
arcs_1  社員割引スケジュールマスタ (c_smlsch_mst)
arcs_2	社員割引商品マスタ（c_smlitem_mst）
arcs_3	特売、会員特売スケジュールマスタ（c_brgnsch_mst）
arcs_4	特売、会員特売商品マスタ（c_brgnitem_mst）
arcs_5	ミックスマッチスケジュールマスタ（c_bdlsch_mst)
arcs_6	ミックスマッチ商品マスタ（c_bdlitem_mst）
arcs_7	商品加算ポイントスケジュールマスタ（c_plusch_mst)
arcs_8	商品加算ポイントマスタ（c_pluitem_mst)
arcs_9	クレジット請求ログ（c_crdt_actual_log)
 */

//region arcs_1 社員割引スケジュールマスタ c_smlsch_mst
/// 社員割引スケジュールマスタ（c_smlsch_mst）クラス
class CSmlschMstColumns extends TableColumns {
  int? stre_cd;
  int? smlsch_cd;
  int? plan_cd;
  String? name;
  String? short_name;
  String? start_datetime;
  String? end_datetime;
  int? timesch_flg;
  int? sun_flg;
  int? mon_flg;
  int? tue_flg;
  int? wed_flg;
  int? thu_flg;
  int? fri_flg;
  int? sat_flg;
  int? poppy_flg;
  int? stop_flg;
  int? trends_typ;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int? upd_user;
  int? upd_system;
  int? upd_machin;
  int? efct_flg;

  @override
  String getTableName() => "c_smlsch_mst";

  @override
  String? getKeyCondition() => 'stre_cd = ? AND smlsch_cd = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(smlsch_cd);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CSmlschMstColumns rn = CSmlschMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.smlsch_cd = maps[i]['smlsch_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
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
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.upd_machin = maps[i]['upd_machin'];
      rn.efct_flg = maps[i]['efct_flg'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CSmlschMstColumns rn = CSmlschMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.smlsch_cd = maps[0]['smlsch_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
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
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.upd_machin = maps[0]['upd_machin'];
    rn.efct_flg = maps[0]['efct_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CSmlschMstField.stre_cd: this.stre_cd,
      CSmlschMstField.smlsch_cd: this.smlsch_cd,
      CSmlschMstField.plan_cd: this.plan_cd,
      CSmlschMstField.name: this.name,
      CSmlschMstField.short_name: this.short_name,
      CSmlschMstField.start_datetime: this.start_datetime,
      CSmlschMstField.end_datetime: this.end_datetime,
      CSmlschMstField.timesch_flg: this.timesch_flg,
      CSmlschMstField.sun_flg: this.sun_flg,
      CSmlschMstField.mon_flg: this.mon_flg,
      CSmlschMstField.tue_flg: this.tue_flg,
      CSmlschMstField.wed_flg: this.wed_flg,
      CSmlschMstField.thu_flg: this.thu_flg,
      CSmlschMstField.fri_flg: this.fri_flg,
      CSmlschMstField.sat_flg: this.sat_flg,
      CSmlschMstField.poppy_flg: this.poppy_flg,
      CSmlschMstField.stop_flg: this.stop_flg,
      CSmlschMstField.trends_typ: this.trends_typ,
      CSmlschMstField.ins_datetime: this.ins_datetime,
      CSmlschMstField.upd_datetime: this.upd_datetime,
      CSmlschMstField.status: this.status,
      CSmlschMstField.send_flg: this.send_flg,
      CSmlschMstField.upd_user: this.upd_user,
      CSmlschMstField.upd_system: this.upd_system,
      CSmlschMstField.upd_machin: this.upd_machin,
      CSmlschMstField.efct_flg: this.efct_flg,
    };
  }
}

/// 社員割引スケジュールマスタ（c_smlsch_mst）のフィールド名設定用クラス
class CSmlschMstField {
  static const stre_cd = "stre_cd";
  static const smlsch_cd = "smlsch_cd";
  static const plan_cd = "plan_cd";
  static const name = "name";
  static const short_name = "short_name";
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
  static const poppy_flg = "poppy_flg";
  static const stop_flg = "stop_flg";
  static const trends_typ = "trends_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const upd_machin = "upd_machin";
  static const efct_flg = "efct_flg";
}
//endregion

//region arcs_2	社員割引商品マスタ（c_smlitem_mst）
/// 社員割引商品マスタ（c_smlitem_mst）クラス
class CSmlitemMstColumns extends TableColumns {
  int? stre_cd;
  int? smlcls_cd;
  int? smlsch_cd;
  int? showorder;
  int? poppy_flg;
  int? stop_flg;
  int? dsc_flg;
  int? dsc_prc;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int? upd_user;
  int? upd_system;
  int? upd_machin;
  int? mdsc_prc;
  int? efct_flg;

  @override
  String getTableName() => "c_smlitem_mst";

  @override
  String? getKeyCondition() =>
      'stre_cd = ? AND smlcls_cd = ? AND smlsch_cd = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(smlcls_cd);
    rn.add(smlsch_cd);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CSmlitemMstColumns rn = CSmlitemMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.smlsch_cd = maps[i]['smlsch_cd'];
      rn.showorder = maps[i]['showorder'];
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.dsc_flg = maps[i]['dsc_flg'];
      rn.dsc_prc = maps[i]['dsc_prc'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.upd_machin = maps[i]['upd_machin'];
      rn.mdsc_prc = maps[i]['mdsc_prc'];
      rn.efct_flg = maps[i]['efct_flg'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CSmlitemMstColumns rn = CSmlitemMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.smlsch_cd = maps[0]['smlsch_cd'];
    rn.showorder = maps[0]['showorder'];
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.dsc_flg = maps[0]['dsc_flg'];
    rn.dsc_prc = maps[0]['dsc_prc'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.upd_machin = maps[0]['upd_machin'];
    rn.mdsc_prc = maps[0]['mdsc_prc'];
    rn.efct_flg = maps[0]['efct_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CSmlitemMstField.stre_cd: this.stre_cd,
      CSmlitemMstField.smlcls_cd: this.smlcls_cd,
      CSmlitemMstField.smlsch_cd: this.smlsch_cd,
      CSmlitemMstField.showorder: this.showorder,
      CSmlitemMstField.poppy_flg: this.poppy_flg,
      CSmlitemMstField.stop_flg: this.stop_flg,
      CSmlitemMstField.dsc_flg: this.dsc_flg,
      CSmlitemMstField.dsc_prc: this.dsc_prc,
      CSmlitemMstField.ins_datetime: this.ins_datetime,
      CSmlitemMstField.upd_datetime: this.upd_datetime,
      CSmlitemMstField.status: this.status,
      CSmlitemMstField.send_flg: this.send_flg,
      CSmlitemMstField.upd_user: this.upd_user,
      CSmlitemMstField.upd_system: this.upd_system,
      CSmlitemMstField.upd_machin: this.upd_machin,
      CSmlitemMstField.mdsc_prc: this.mdsc_prc,
      CSmlitemMstField.efct_flg: this.efct_flg,
    };
  }
}

/// 社員割引商品マスタ（c_smlitem_mst）のフィールド名設定用クラス
class CSmlitemMstField {
  static const stre_cd = "stre_cd";
  static const smlcls_cd = "smlcls_cd";
  static const smlsch_cd = "smlsch_cd";
  static const showorder = "showorder";
  static const poppy_flg = "poppy_flg";
  static const stop_flg = "stop_flg";
  static const dsc_flg = "dsc_flg";
  static const dsc_prc = "dsc_prc";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const upd_machin = "upd_machin";
  static const mdsc_prc = "mdsc_prc";
  static const efct_flg = "efct_flg";
}
//endregion

//region arcs_3	特売、会員特売スケジュールマスタ（c_brgnsch_mst）
/// 特売、会員特売スケジュールマスタ（c_brgnsch_mst）クラス
class CBrgnschMstColumns extends TableColumns {
  int? stre_cd;
  int? brgn_cd;
  int? plan_cd;
  String? name;
  String? short_name;
  String? start_datetime;
  String? end_datetime;
  int? timesch_flg;
  int? sun_flg;
  int? mon_flg;
  int? tue_flg;
  int? wed_flg;
  int? thu_flg;
  int? fri_flg;
  int? sat_flg;
  int? poppy_flg;
  int? stop_flg;
  int? trends_typ;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int? upd_user;
  int? upd_system;
  int? upd_machin;
  int? efct_flg;
  int? brgn_typ;

  @override
  String getTableName() => "c_brgnsch_mst";

  @override
  String? getKeyCondition() => 'stre_cd = ? AND brgn_cd = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(brgn_cd);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CBrgnschMstColumns rn = CBrgnschMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.brgn_cd = maps[i]['brgn_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
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
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.upd_machin = maps[i]['upd_machin'];
      rn.efct_flg = maps[i]['efct_flg'];
      rn.brgn_typ = maps[i]['brgn_typ'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CBrgnschMstColumns rn = CBrgnschMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.brgn_cd = maps[0]['brgn_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
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
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.upd_machin = maps[0]['upd_machin'];
    rn.efct_flg = maps[0]['efct_flg'];
    rn.brgn_typ = maps[0]['brgn_typ'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CBrgnschMstField.stre_cd: this.stre_cd,
      CBrgnschMstField.brgn_cd: this.brgn_cd,
      CBrgnschMstField.plan_cd: this.plan_cd,
      CBrgnschMstField.name: this.name,
      CBrgnschMstField.short_name: this.short_name,
      CBrgnschMstField.start_datetime: this.start_datetime,
      CBrgnschMstField.end_datetime: this.end_datetime,
      CBrgnschMstField.timesch_flg: this.timesch_flg,
      CBrgnschMstField.sun_flg: this.sun_flg,
      CBrgnschMstField.mon_flg: this.mon_flg,
      CBrgnschMstField.tue_flg: this.tue_flg,
      CBrgnschMstField.wed_flg: this.wed_flg,
      CBrgnschMstField.thu_flg: this.thu_flg,
      CBrgnschMstField.fri_flg: this.fri_flg,
      CBrgnschMstField.sat_flg: this.sat_flg,
      CBrgnschMstField.poppy_flg: this.poppy_flg,
      CBrgnschMstField.stop_flg: this.stop_flg,
      CBrgnschMstField.trends_typ: this.trends_typ,
      CBrgnschMstField.ins_datetime: this.ins_datetime,
      CBrgnschMstField.upd_datetime: this.upd_datetime,
      CBrgnschMstField.status: this.status,
      CBrgnschMstField.send_flg: this.send_flg,
      CBrgnschMstField.upd_user: this.upd_user,
      CBrgnschMstField.upd_system: this.upd_system,
      CBrgnschMstField.upd_machin: this.upd_machin,
      CBrgnschMstField.efct_flg: this.efct_flg,
      CBrgnschMstField.brgn_typ: this.brgn_typ,
    };
  }
}

/// 特売、会員特売スケジュールマスタ（c_brgnsch_mst）のフィールド名設定用クラス
class CBrgnschMstField {
  static const stre_cd = "stre_cd";
  static const brgn_cd = "brgn_cd";
  static const plan_cd = "plan_cd";
  static const name = "name";
  static const short_name = "short_name";
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
  static const poppy_flg = "poppy_flg";
  static const stop_flg = "stop_flg";
  static const trends_typ = "trends_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const upd_machin = "upd_machin";
  static const efct_flg = "efct_flg";
  static const brgn_typ = "brgn_typ";
}
//endregion

//region arcs_4	特売、会員特売商品マスタ（c_brgnitem_mst）
/// 特売、会員特売商品マスタ（c_brgnitem_mst）クラス
class CBrgnitemMstColumns extends TableColumns {
  int? stre_cd;
  String? plu_cd;
  int? brgn_cd;
  int? brgn_typ;
  int? showorder;
  int? brgn_prc;
  double? brgn_cost;
  int? brgncust_prc;
  int? consist_val1;
  int? consist_val2;
  int? consist_val3;
  int? consist_val4;
  int? consist_val5;
  int? consist_prc1;
  int? consist_prc2;
  int? consist_prc3;
  int? consist_prc4;
  int? consist_prc5;
  int? gram_prc;
  int? markdown_flg;
  int? markdown;
  int? imagedata_cd;
  int? advantize_cd;
  int? labelsize;
  int? poppy_flg;
  int? stop_flg;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int? upd_user;
  int? upd_system;
  int? upd_machin;
  int? brgn_dsc;
  int? mbrbrgn_dsc;
  int? brgn_div;
  double? brgn_costper;
  int? ts_fil_cd1;
  int? ts_fil_cd2;
  int? ts_fil_cd3;
  int? ts_fil_cd4;
  int? ts_fil_cd5;

  @override
  String getTableName() => "c_brgnitem_mst";

  @override
  String? getKeyCondition() => 'stre_cd = ? AND plu_cd = ? AND brgn_cd = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(plu_cd);
    rn.add(brgn_cd);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CBrgnitemMstColumns rn = CBrgnitemMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.brgn_cd = maps[i]['brgn_cd'];
      rn.brgn_typ = maps[i]['brgn_typ'];
      rn.showorder = maps[i]['showorder'];
      rn.brgn_prc = maps[i]['brgn_prc'];
      rn.brgn_cost = maps[i]['brgn_cost'];
      rn.brgncust_prc = maps[i]['brgncust_prc'];
      rn.consist_val1 = maps[i]['consist_val1'];
      rn.consist_val2 = maps[i]['consist_val2'];
      rn.consist_val3 = maps[i]['consist_val3'];
      rn.consist_val4 = maps[i]['consist_val4'];
      rn.consist_val5 = maps[i]['consist_val5'];
      rn.consist_prc1 = maps[i]['consist_prc1'];
      rn.consist_prc2 = maps[i]['consist_prc2'];
      rn.consist_prc3 = maps[i]['consist_prc3'];
      rn.consist_prc4 = maps[i]['consist_prc4'];
      rn.consist_prc5 = maps[i]['consist_prc5'];
      rn.gram_prc = maps[i]['gram_prc'];
      rn.markdown_flg = maps[i]['markdown_flg'];
      rn.markdown = maps[i]['markdown'];
      rn.imagedata_cd = maps[i]['imagedata_cd'];
      rn.advantize_cd = maps[i]['advantize_cd'];
      rn.labelsize = maps[i]['labelsize'];
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.upd_machin = maps[i]['upd_machin'];
      rn.brgn_dsc = maps[i]['brgn_dsc'];
      rn.mbrbrgn_dsc = maps[i]['mbrbrgn_dsc'];
      rn.brgn_div = maps[i]['brgn_div'];
      rn.brgn_costper = maps[i]['brgn_costper'];
      rn.ts_fil_cd1 = maps[i]['ts_fil_cd1'];
      rn.ts_fil_cd2 = maps[i]['ts_fil_cd2'];
      rn.ts_fil_cd3 = maps[i]['ts_fil_cd3'];
      rn.ts_fil_cd4 = maps[i]['ts_fil_cd4'];
      rn.ts_fil_cd5 = maps[i]['ts_fil_cd5'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CBrgnitemMstColumns rn = CBrgnitemMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.brgn_cd = maps[0]['brgn_cd'];
    rn.brgn_typ = maps[0]['brgn_typ'];
    rn.showorder = maps[0]['showorder'];
    rn.brgn_prc = maps[0]['brgn_prc'];
    rn.brgn_cost = maps[0]['brgn_cost'];
    rn.brgncust_prc = maps[0]['brgncust_prc'];
    rn.consist_val1 = maps[0]['consist_val1'];
    rn.consist_val2 = maps[0]['consist_val2'];
    rn.consist_val3 = maps[0]['consist_val3'];
    rn.consist_val4 = maps[0]['consist_val4'];
    rn.consist_val5 = maps[0]['consist_val5'];
    rn.consist_prc1 = maps[0]['consist_prc1'];
    rn.consist_prc2 = maps[0]['consist_prc2'];
    rn.consist_prc3 = maps[0]['consist_prc3'];
    rn.consist_prc4 = maps[0]['consist_prc4'];
    rn.consist_prc5 = maps[0]['consist_prc5'];
    rn.gram_prc = maps[0]['gram_prc'];
    rn.markdown_flg = maps[0]['markdown_flg'];
    rn.markdown = maps[0]['markdown'];
    rn.imagedata_cd = maps[0]['imagedata_cd'];
    rn.advantize_cd = maps[0]['advantize_cd'];
    rn.labelsize = maps[0]['labelsize'];
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.upd_machin = maps[0]['upd_machin'];
    rn.brgn_dsc = maps[0]['brgn_dsc'];
    rn.mbrbrgn_dsc = maps[0]['mbrbrgn_dsc'];
    rn.brgn_div = maps[0]['brgn_div'];
    rn.brgn_costper = maps[0]['brgn_costper'];
    rn.ts_fil_cd1 = maps[0]['ts_fil_cd1'];
    rn.ts_fil_cd2 = maps[0]['ts_fil_cd2'];
    rn.ts_fil_cd3 = maps[0]['ts_fil_cd3'];
    rn.ts_fil_cd4 = maps[0]['ts_fil_cd4'];
    rn.ts_fil_cd5 = maps[0]['ts_fil_cd5'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CBrgnitemMstField.stre_cd: this.stre_cd,
      CBrgnitemMstField.plu_cd: this.plu_cd,
      CBrgnitemMstField.brgn_cd: this.brgn_cd,
      CBrgnitemMstField.brgn_typ: this.brgn_typ,
      CBrgnitemMstField.showorder: this.showorder,
      CBrgnitemMstField.brgn_prc: this.brgn_prc,
      CBrgnitemMstField.brgn_cost: this.brgn_cost,
      CBrgnitemMstField.brgncust_prc: this.brgncust_prc,
      CBrgnitemMstField.consist_val1: this.consist_val1,
      CBrgnitemMstField.consist_val2: this.consist_val2,
      CBrgnitemMstField.consist_val3: this.consist_val3,
      CBrgnitemMstField.consist_val4: this.consist_val4,
      CBrgnitemMstField.consist_val5: this.consist_val5,
      CBrgnitemMstField.consist_prc1: this.consist_prc1,
      CBrgnitemMstField.consist_prc2: this.consist_prc2,
      CBrgnitemMstField.consist_prc3: this.consist_prc3,
      CBrgnitemMstField.consist_prc4: this.consist_prc4,
      CBrgnitemMstField.consist_prc5: this.consist_prc5,
      CBrgnitemMstField.gram_prc: this.gram_prc,
      CBrgnitemMstField.markdown_flg: this.markdown_flg,
      CBrgnitemMstField.markdown: this.markdown,
      CBrgnitemMstField.imagedata_cd: this.imagedata_cd,
      CBrgnitemMstField.advantize_cd: this.advantize_cd,
      CBrgnitemMstField.labelsize: this.labelsize,
      CBrgnitemMstField.poppy_flg: this.poppy_flg,
      CBrgnitemMstField.stop_flg: this.stop_flg,
      CBrgnitemMstField.ins_datetime: this.ins_datetime,
      CBrgnitemMstField.upd_datetime: this.upd_datetime,
      CBrgnitemMstField.status: this.status,
      CBrgnitemMstField.send_flg: this.send_flg,
      CBrgnitemMstField.upd_user: this.upd_user,
      CBrgnitemMstField.upd_system: this.upd_system,
      CBrgnitemMstField.upd_machin: this.upd_machin,
      CBrgnitemMstField.brgn_dsc: this.brgn_dsc,
      CBrgnitemMstField.mbrbrgn_dsc: this.mbrbrgn_dsc,
      CBrgnitemMstField.brgn_div: this.brgn_div,
      CBrgnitemMstField.brgn_costper: this.brgn_costper,
      CBrgnitemMstField.ts_fil_cd1: this.ts_fil_cd1,
      CBrgnitemMstField.ts_fil_cd2: this.ts_fil_cd2,
      CBrgnitemMstField.ts_fil_cd3: this.ts_fil_cd3,
      CBrgnitemMstField.ts_fil_cd4: this.ts_fil_cd4,
      CBrgnitemMstField.ts_fil_cd5: this.ts_fil_cd5,
    };
  }
}

/// 特売、会員特売商品マスタ（c_brgnitem_mst）のフィールド名設定用クラス
class CBrgnitemMstField {
  static const stre_cd = "stre_cd";
  static const plu_cd = "plu_cd";
  static const brgn_cd = "brgn_cd";
  static const brgn_typ = "brgn_typ";
  static const showorder = "showorder";
  static const brgn_prc = "brgn_prc";
  static const brgn_cost = "brgn_cost";
  static const brgncust_prc = "brgncust_prc";
  static const consist_val1 = "consist_val1";
  static const consist_val2 = "consist_val2";
  static const consist_val3 = "consist_val3";
  static const consist_val4 = "consist_val4";
  static const consist_val5 = "consist_val5";
  static const consist_prc1 = "consist_prc1";
  static const consist_prc2 = "consist_prc2";
  static const consist_prc3 = "consist_prc3";
  static const consist_prc4 = "consist_prc4";
  static const consist_prc5 = "consist_prc5";
  static const gram_prc = "gram_prc";
  static const markdown_flg = "markdown_flg";
  static const markdown = "markdown";
  static const imagedata_cd = "imagedata_cd";
  static const advantize_cd = "advantize_cd";
  static const labelsize = "labelsize";
  static const poppy_flg = "poppy_flg";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const upd_machin = "upd_machin";
  static const brgn_dsc = "brgn_dsc";
  static const mbrbrgn_dsc = "mbrbrgn_dsc";
  static const brgn_div = "brgn_div";
  static const brgn_costper = "brgn_costper";
  static const ts_fil_cd1 = "ts_fil_cd1";
  static const ts_fil_cd2 = "ts_fil_cd2";
  static const ts_fil_cd3 = "ts_fil_cd3";
  static const ts_fil_cd4 = "ts_fil_cd4";
  static const ts_fil_cd5 = "ts_fil_cd5";
}
//endregion

//region arcs_5	ミックスマッチスケジュールマスタ（c_bdlsch_mst)
/// ミックスマッチスケジュールマスタ（c_bdlsch_mst）クラス
class CBdlschMstColumns extends TableColumns {
  int? stre_cd;
  int? bdl_cd;
  int? plan_cd;
  String? name;
  String? short_name;
  String? start_datetime;
  String? end_datetime;
  int? timesch_flg;
  int? sun_flg;
  int? mon_flg;
  int? tue_flg;
  int? wed_flg;
  int? thu_flg;
  int? fri_flg;
  int? sat_flg;
  int? bdl_qty1;
  int? bdl_qty2;
  int? bdl_qty3;
  int? bdl_qty4;
  int? bdl_qty5;
  int? bdl_prc1;
  int? bdl_prc2;
  int? bdl_prc3;
  int? bdl_prc4;
  int? bdl_prc5;
  int? limit_cnt;
  int? poppy_flg;
  int? stop_flg;
  int? trends_typ;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int? upd_user;
  int? upd_system;
  int? upd_machin;
  int? efct_flg;
  int? mbdl_prc1;
  int? mbdl_prc2;
  int? mbdl_prc3;
  int? mbdl_prc4;
  int? mbdl_prc5;
  int? bdl_typ;

  @override
  String getTableName() => "c_bdlsch_mst";

  @override
  String? getKeyCondition() => 'stre_cd = ? AND bdl_cd = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(bdl_cd);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CBdlschMstColumns rn = CBdlschMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.bdl_cd = maps[i]['bdl_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
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
      rn.bdl_qty1 = maps[i]['bdl_qty1'];
      rn.bdl_qty2 = maps[i]['bdl_qty2'];
      rn.bdl_qty3 = maps[i]['bdl_qty3'];
      rn.bdl_qty4 = maps[i]['bdl_qty4'];
      rn.bdl_qty5 = maps[i]['bdl_qty5'];
      rn.bdl_prc1 = maps[i]['bdl_prc1'];
      rn.bdl_prc2 = maps[i]['bdl_prc2'];
      rn.bdl_prc3 = maps[i]['bdl_prc3'];
      rn.bdl_prc4 = maps[i]['bdl_prc4'];
      rn.bdl_prc5 = maps[i]['bdl_prc5'];
      rn.limit_cnt = maps[i]['limit_cnt'];
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.upd_machin = maps[i]['upd_machin'];
      rn.efct_flg = maps[i]['efct_flg'];
      rn.mbdl_prc1 = maps[i]['mbdl_prc1'];
      rn.mbdl_prc2 = maps[i]['mbdl_prc2'];
      rn.mbdl_prc3 = maps[i]['mbdl_prc3'];
      rn.mbdl_prc4 = maps[i]['mbdl_prc4'];
      rn.mbdl_prc5 = maps[i]['mbdl_prc5'];
      rn.bdl_typ = maps[i]['bdl_typ'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CBdlschMstColumns rn = CBdlschMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.bdl_cd = maps[0]['bdl_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
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
    rn.bdl_qty1 = maps[0]['bdl_qty1'];
    rn.bdl_qty2 = maps[0]['bdl_qty2'];
    rn.bdl_qty3 = maps[0]['bdl_qty3'];
    rn.bdl_qty4 = maps[0]['bdl_qty4'];
    rn.bdl_qty5 = maps[0]['bdl_qty5'];
    rn.bdl_prc1 = maps[0]['bdl_prc1'];
    rn.bdl_prc2 = maps[0]['bdl_prc2'];
    rn.bdl_prc3 = maps[0]['bdl_prc3'];
    rn.bdl_prc4 = maps[0]['bdl_prc4'];
    rn.bdl_prc5 = maps[0]['bdl_prc5'];
    rn.limit_cnt = maps[0]['limit_cnt'];
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.upd_machin = maps[0]['upd_machin'];
    rn.efct_flg = maps[0]['efct_flg'];
    rn.mbdl_prc1 = maps[0]['mbdl_prc1'];
    rn.mbdl_prc2 = maps[0]['mbdl_prc2'];
    rn.mbdl_prc3 = maps[0]['mbdl_prc3'];
    rn.mbdl_prc4 = maps[0]['mbdl_prc4'];
    rn.mbdl_prc5 = maps[0]['mbdl_prc5'];
    rn.bdl_typ = maps[0]['bdl_typ'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CBdlschMstField.stre_cd: this.stre_cd,
      CBdlschMstField.bdl_cd: this.bdl_cd,
      CBdlschMstField.plan_cd: this.plan_cd,
      CBdlschMstField.name: this.name,
      CBdlschMstField.short_name: this.short_name,
      CBdlschMstField.start_datetime: this.start_datetime,
      CBdlschMstField.end_datetime: this.end_datetime,
      CBdlschMstField.timesch_flg: this.timesch_flg,
      CBdlschMstField.sun_flg: this.sun_flg,
      CBdlschMstField.mon_flg: this.mon_flg,
      CBdlschMstField.tue_flg: this.tue_flg,
      CBdlschMstField.wed_flg: this.wed_flg,
      CBdlschMstField.thu_flg: this.thu_flg,
      CBdlschMstField.fri_flg: this.fri_flg,
      CBdlschMstField.sat_flg: this.sat_flg,
      CBdlschMstField.bdl_qty1: this.bdl_qty1,
      CBdlschMstField.bdl_qty2: this.bdl_qty2,
      CBdlschMstField.bdl_qty3: this.bdl_qty3,
      CBdlschMstField.bdl_qty4: this.bdl_qty4,
      CBdlschMstField.bdl_qty5: this.bdl_qty5,
      CBdlschMstField.bdl_prc1: this.bdl_prc1,
      CBdlschMstField.bdl_prc2: this.bdl_prc2,
      CBdlschMstField.bdl_prc3: this.bdl_prc3,
      CBdlschMstField.bdl_prc4: this.bdl_prc4,
      CBdlschMstField.bdl_prc5: this.bdl_prc5,
      CBdlschMstField.limit_cnt: this.limit_cnt,
      CBdlschMstField.poppy_flg: this.poppy_flg,
      CBdlschMstField.stop_flg: this.stop_flg,
      CBdlschMstField.trends_typ: this.trends_typ,
      CBdlschMstField.ins_datetime: this.ins_datetime,
      CBdlschMstField.upd_datetime: this.upd_datetime,
      CBdlschMstField.status: this.status,
      CBdlschMstField.send_flg: this.send_flg,
      CBdlschMstField.upd_user: this.upd_user,
      CBdlschMstField.upd_system: this.upd_system,
      CBdlschMstField.upd_machin: this.upd_machin,
      CBdlschMstField.efct_flg: this.efct_flg,
      CBdlschMstField.mbdl_prc1: this.mbdl_prc1,
      CBdlschMstField.mbdl_prc2: this.mbdl_prc2,
      CBdlschMstField.mbdl_prc3: this.mbdl_prc3,
      CBdlschMstField.mbdl_prc4: this.mbdl_prc4,
      CBdlschMstField.mbdl_prc5: this.mbdl_prc5,
      CBdlschMstField.bdl_typ: this.bdl_typ,
    };
  }
}

/// ミックスマッチスケジュールマスタ（c_bdlsch_mst）のフィールド名設定用クラス
class CBdlschMstField {
  static const stre_cd = "stre_cd";
  static const bdl_cd = "bdl_cd";
  static const plan_cd = "plan_cd";
  static const name = "name";
  static const short_name = "short_name";
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
  static const bdl_qty1 = "bdl_qty1";
  static const bdl_qty2 = "bdl_qty2";
  static const bdl_qty3 = "bdl_qty3";
  static const bdl_qty4 = "bdl_qty4";
  static const bdl_qty5 = "bdl_qty5";
  static const bdl_prc1 = "bdl_prc1";
  static const bdl_prc2 = "bdl_prc2";
  static const bdl_prc3 = "bdl_prc3";
  static const bdl_prc4 = "bdl_prc4";
  static const bdl_prc5 = "bdl_prc5";
  static const limit_cnt = "limit_cnt";
  static const poppy_flg = "poppy_flg";
  static const stop_flg = "stop_flg";
  static const trends_typ = "trends_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const upd_machin = "upd_machin";
  static const efct_flg = "efct_flg";
  static const mbdl_prc1 = "mbdl_prc1";
  static const mbdl_prc2 = "mbdl_prc2";
  static const mbdl_prc3 = "mbdl_prc3";
  static const mbdl_prc4 = "mbdl_prc4";
  static const mbdl_prc5 = "mbdl_prc5";
  static const bdl_typ = "bdl_typ";
}
//endregion

//region arcs_6	ミックスマッチ商品マスタ（c_bdlitem_mst）
/// ミックスマッチ商品マスタ（c_bdlitem_mst）クラス
class CBdlitemMstColumns extends TableColumns {
  int? stre_cd;
  String? plu_cd;
  int? bdl_cd;
  int? showorder;
  int? poppy_flg;
  int? stop_flg;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int? upd_user;
  int? upd_system;
  int? upd_machin;
  int? sat_flg;
  int? trends_typ;
  int? efct_flg;
  int? brgn_typ;

  @override
  String getTableName() => "c_bdlitem_mst";

  @override
  String? getKeyCondition() => 'stre_cd = ? AND plu_cd = ? AND bdl_cd = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(plu_cd);
    rn.add(bdl_cd);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CBdlitemMstColumns rn = CBdlitemMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.bdl_cd = maps[i]['bdl_cd'];
      rn.showorder = maps[i]['showorder'];
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.upd_machin = maps[i]['upd_machin'];
      rn.sat_flg = maps[i]['sat_flg'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.efct_flg = maps[i]['efct_flg'];
      rn.brgn_typ = maps[i]['brgn_typ'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CBdlitemMstColumns rn = CBdlitemMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.bdl_cd = maps[0]['bdl_cd'];
    rn.showorder = maps[0]['showorder'];
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.upd_machin = maps[0]['upd_machin'];
    rn.sat_flg = maps[0]['sat_flg'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.efct_flg = maps[0]['efct_flg'];
    rn.brgn_typ = maps[0]['brgn_typ'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CBdlitemMstField.stre_cd: this.stre_cd,
      CBdlitemMstField.plu_cd: this.plu_cd,
      CBdlitemMstField.bdl_cd: this.bdl_cd,
      CBdlitemMstField.showorder: this.showorder,
      CBdlitemMstField.poppy_flg: this.poppy_flg,
      CBdlitemMstField.stop_flg: this.stop_flg,
      CBdlitemMstField.ins_datetime: this.ins_datetime,
      CBdlitemMstField.upd_datetime: this.upd_datetime,
      CBdlitemMstField.status: this.status,
      CBdlitemMstField.send_flg: this.send_flg,
      CBdlitemMstField.upd_user: this.upd_user,
      CBdlitemMstField.upd_system: this.upd_system,
      CBdlitemMstField.upd_machin: this.upd_machin,
      CBdlitemMstField.sat_flg: this.sat_flg,
      CBdlitemMstField.trends_typ: this.trends_typ,
      CBdlitemMstField.efct_flg: this.efct_flg,
      CBdlitemMstField.brgn_typ: this.brgn_typ,
    };
  }
}

/// ミックスマッチ商品マスタ（c_bdlitem_mst）のフィールド名設定用クラス
class CBdlitemMstField {
  static const stre_cd = "stre_cd";
  static const plu_cd = "plu_cd";
  static const bdl_cd = "bdl_cd";
  static const showorder = "showorder";
  static const poppy_flg = "poppy_flg";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const upd_machin = "upd_machin";
  static const sat_flg = "sat_flg";
  static const trends_typ = "trends_typ";
  static const efct_flg = "efct_flg";
  static const brgn_typ = "brgn_typ";
}
//endregion

//region arcs_7	商品加算ポイントスケジュールマスタ（c_plusch_mst)
/// 商品加算ポイントスケジュールマスタ（c_plusch_mst)クラス
class CPluschMstColumns extends TableColumns {
  int? stre_cd;
  int? plusch_cd;
  int? plan_cd;
  String? name;
  String? short_name;
  String? start_datetime;
  String? end_datetime;
  int? timesch_flg;
  int? sun_flg;
  int? mon_flg;
  int? tue_flg;
  int? wed_flg;
  int? thu_flg;
  int? fri_flg;
  int? sat_flg;
  int? poppy_flg;
  int? stop_flg;
  int? trends_typ;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int? upd_user;
  int? upd_system;
  int? upd_machin;
  int? efct_flg;

  @override
  String getTableName() => "c_plusch_mst";

  @override
  String? getKeyCondition() => 'stre_cd = ? AND plusch_cd = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(plusch_cd);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CPluschMstColumns rn = CPluschMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plusch_cd = maps[i]['plusch_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
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
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.upd_machin = maps[i]['upd_machin'];
      rn.efct_flg = maps[i]['efct_flg'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CPluschMstColumns rn = CPluschMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plusch_cd = maps[0]['plusch_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
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
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.upd_machin = maps[0]['upd_machin'];
    rn.efct_flg = maps[0]['efct_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CPluschMstField.stre_cd: this.stre_cd,
      CPluschMstField.plusch_cd: this.plusch_cd,
      CPluschMstField.plan_cd: this.plan_cd,
      CPluschMstField.name: this.name,
      CPluschMstField.short_name: this.short_name,
      CPluschMstField.start_datetime: this.start_datetime,
      CPluschMstField.end_datetime: this.end_datetime,
      CPluschMstField.timesch_flg: this.timesch_flg,
      CPluschMstField.sun_flg: this.sun_flg,
      CPluschMstField.mon_flg: this.mon_flg,
      CPluschMstField.tue_flg: this.tue_flg,
      CPluschMstField.wed_flg: this.wed_flg,
      CPluschMstField.thu_flg: this.thu_flg,
      CPluschMstField.fri_flg: this.fri_flg,
      CPluschMstField.sat_flg: this.sat_flg,
      CPluschMstField.poppy_flg: this.poppy_flg,
      CPluschMstField.stop_flg: this.stop_flg,
      CPluschMstField.trends_typ: this.trends_typ,
      CPluschMstField.ins_datetime: this.ins_datetime,
      CPluschMstField.upd_datetime: this.upd_datetime,
      CPluschMstField.status: this.status,
      CPluschMstField.send_flg: this.send_flg,
      CPluschMstField.upd_user: this.upd_user,
      CPluschMstField.upd_system: this.upd_system,
      CPluschMstField.upd_machin: this.upd_machin,
      CPluschMstField.efct_flg: this.efct_flg,
    };
  }
}

/// 商品加算ポイントスケジュールマスタ（c_plusch_mst)のフィールド名設定用クラス
class CPluschMstField {
  static const stre_cd = "stre_cd";
  static const plusch_cd = "plusch_cd";
  static const plan_cd = "plan_cd";
  static const name = "name";
  static const short_name = "short_name";
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
  static const poppy_flg = "poppy_flg";
  static const stop_flg = "stop_flg";
  static const trends_typ = "trends_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const upd_machin = "upd_machin";
  static const efct_flg = "efct_flg";
}
//endregion

//region arcs_8	商品加算ポイントマスタ（c_pluitem_mst)
/// 商品加算ポイントマスタ（c_pluitem_mst)クラス
class CPluitemMstColumns extends TableColumns {
  int? stre_cd;
  String? plu_cd;
  int? plusch_cd;
  int? showorder;
  int? poppy_flg;
  int? stop_flg;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int? upd_user;
  int? upd_system;
  int? upd_machin;
  int? point_add;
  int? prom_cd1;
  int? prom_cd2;
  int? prom_cd3;
  int? efct_flg;
  int? brgn_typ;

  @override
  String getTableName() => "c_pluitem_mst";

  @override
  String? getKeyCondition() => 'stre_cd = ? AND plu_cd = ? AND plusch_cd = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(plu_cd);
    rn.add(plusch_cd);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CPluitemMstColumns rn = CPluitemMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.plusch_cd = maps[i]['plusch_cd'];
      rn.showorder = maps[i]['showorder'];
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.upd_machin = maps[i]['upd_machin'];
      rn.point_add = maps[i]['point_add'];
      rn.prom_cd1 = maps[i]['prom_cd1'];
      rn.prom_cd2 = maps[i]['prom_cd2'];
      rn.prom_cd3 = maps[i]['prom_cd3'];
      rn.efct_flg = maps[i]['efct_flg'];
      rn.brgn_typ = maps[i]['brgn_typ'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CPluitemMstColumns rn = CPluitemMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.plusch_cd = maps[0]['plusch_cd'];
    rn.showorder = maps[0]['showorder'];
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.upd_machin = maps[0]['upd_machin'];
    rn.point_add = maps[0]['point_add'];
    rn.prom_cd1 = maps[0]['prom_cd1'];
    rn.prom_cd2 = maps[0]['prom_cd2'];
    rn.prom_cd3 = maps[0]['prom_cd3'];
    rn.efct_flg = maps[0]['efct_flg'];
    rn.brgn_typ = maps[0]['brgn_typ'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CPluitemMstField.stre_cd: this.stre_cd,
      CPluitemMstField.plu_cd: this.plu_cd,
      CPluitemMstField.plusch_cd: this.plusch_cd,
      CPluitemMstField.showorder: this.showorder,
      CPluitemMstField.poppy_flg: this.poppy_flg,
      CPluitemMstField.stop_flg: this.stop_flg,
      CPluitemMstField.ins_datetime: this.ins_datetime,
      CPluitemMstField.upd_datetime: this.upd_datetime,
      CPluitemMstField.status: this.status,
      CPluitemMstField.send_flg: this.send_flg,
      CPluitemMstField.upd_user: this.upd_user,
      CPluitemMstField.upd_system: this.upd_system,
      CPluitemMstField.upd_machin: this.upd_machin,
      CPluitemMstField.point_add: this.point_add,
      CPluitemMstField.prom_cd1: this.prom_cd1,
      CPluitemMstField.prom_cd2: this.prom_cd2,
      CPluitemMstField.prom_cd3: this.prom_cd3,
      CPluitemMstField.efct_flg: this.efct_flg,
      CPluitemMstField.brgn_typ: this.brgn_typ,
    };
  }
}

/// 商品加算ポイントマスタ（c_pluitem_mst)のフィールド名設定用クラス
class CPluitemMstField {
  static const stre_cd = "stre_cd";
  static const plu_cd = "plu_cd";
  static const plusch_cd = "plusch_cd";
  static const showorder = "showorder";
  static const poppy_flg = "poppy_flg";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const upd_machin = "upd_machin";
  static const point_add = "point_add";
  static const prom_cd1 = "prom_cd1";
  static const prom_cd2 = "prom_cd2";
  static const prom_cd3 = "prom_cd3";
  static const efct_flg = "efct_flg";
  static const brgn_typ = "brgn_typ";
}
//endregion

//region arcs_9	クレジット請求ログ（c_crdt_actual_log)
/// クレジット請求ログ（c_crdt_actual_log)クラス
class CCrdtActualLogColumns extends TableColumns {
  int? serial_no;
  String? crdt_flg;
  int? stre_cd;
  int? mac_no;
  int? receipt_no;
  int? print_no;
  int? chkr_no;
  int? cshr_no;
  String? now_sale_datetime;
  String? sale_date;
  int? ope_mode_flg;
  int? crdt_no;
  String? data_stat;
  String? data_div;
  String? ttl_lvl;
  int? tran_div;
  String? tran_cd;
  int? demand_1st_yymm;
  int? divide_cnt;
  String? stre_join_no;
  String? mbr_cd;
  int? sale_yymmdd;
  int? sale_price;
  int? tax_postage;
  int? sale_amt;
  int? recogn_no;
  int? good_thru;
  String? filler;
  String? bonus_month_sign;
  String? bonus_cnt;
  int? bonus_amt;
  int? bonus_1st_yymm;
  String? pos_recogn_no;
  int? pos_receipt_no;
  int? item_cd;
  String? space;
  int? cha_cnt1;
  int? cha_amt1;
  int? cha_cnt2;
  int? cha_amt2;
  int? cha_cnt3;
  int? cha_amt3;
  int? cha_cnt4;
  int? cha_amt4;
  int? cha_cnt5;
  int? cha_amt5;
  int? cha_cnt6;
  int? cha_amt6;
  int? cha_cnt7;
  int? cha_amt7;
  int? cha_cnt8;
  int? cha_amt8;
  int? cha_cnt9;
  int? cha_amt9;
  int? cha_cnt10;
  int? cha_amt10;
  String? cncl_reason;
  int? sell_sts;
  int? sell_kind;
  String? sale_kind;
  int? seq_inq_no;
  int? mng_pos_no;
  int? seq_pos_no;
  int? tenant_cd;
  int? div_com;
  String? judg_cd;
  String? black_check;
  int? card_comp_cd;
  int? change_chk_no;
  int? cncl_slip_no;
  String? sign;
  int? card_stre_cd;
  String? req_code;
  String? card_jis1;
  String? card_jis2;
  String? handle_div;
  String? pay_a_way;
  int? void_mac_no;
  int? void_receipt_no;
  int? void_print_no;
  int? person_cd;

  @override
  String getTableName() => "c_crdt_actual_log";

  @override
  String? getKeyCondition() => 'serial_no = ?';

  @override
  List getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    return rn;
  }

  @override
  List<TableColumns> toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CCrdtActualLogColumns rn = CCrdtActualLogColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.crdt_flg = maps[i]['crdt_flg'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.receipt_no = maps[i]['receipt_no'];
      rn.print_no = maps[i]['print_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.now_sale_datetime = maps[i]['now_sale_datetime'];
      rn.sale_date = maps[i]['sale_date'];
      rn.ope_mode_flg = maps[i]['ope_mode_flg'];
      rn.crdt_no = maps[i]['crdt_no'];
      rn.data_stat = maps[i]['data_stat'];
      rn.data_div = maps[i]['data_div'];
      rn.ttl_lvl = maps[i]['ttl_lvl'];
      rn.tran_div = maps[i]['tran_div'];
      rn.tran_cd = maps[i]['tran_cd'];
      rn.demand_1st_yymm = maps[i]['demand_1st_yymm'];
      rn.divide_cnt = maps[i]['divide_cnt'];
      rn.stre_join_no = maps[i]['stre_join_no'];
      rn.mbr_cd = maps[i]['mbr_cd'];
      rn.sale_yymmdd = maps[i]['sale_yymmdd'];
      rn.sale_price = maps[i]['sale_price'];
      rn.tax_postage = maps[i]['tax_postage'];
      rn.sale_amt = maps[i]['sale_amt'];
      rn.recogn_no = maps[i]['recogn_no'];
      rn.good_thru = maps[i]['good_thru'];
      rn.filler = maps[i]['filler'];
      rn.bonus_month_sign = maps[i]['bonus_month_sign'];
      rn.bonus_cnt = maps[i]['bonus_cnt'];
      rn.bonus_amt = maps[i]['bonus_amt'];
      rn.bonus_1st_yymm = maps[i]['bonus_1st_yymm'];
      rn.pos_recogn_no = maps[i]['pos_recogn_no'];
      rn.pos_receipt_no = maps[i]['pos_receipt_no'];
      rn.item_cd = maps[i]['item_cd'];
      rn.space = maps[i]['space'];
      rn.cha_cnt1 = maps[i]['cha_cnt1'];
      rn.cha_amt1 = maps[i]['cha_amt1'];
      rn.cha_cnt2 = maps[i]['cha_cnt2'];
      rn.cha_amt2 = maps[i]['cha_amt2'];
      rn.cha_cnt3 = maps[i]['cha_cnt3'];
      rn.cha_amt3 = maps[i]['cha_amt3'];
      rn.cha_cnt4 = maps[i]['cha_cnt4'];
      rn.cha_amt4 = maps[i]['cha_amt4'];
      rn.cha_cnt5 = maps[i]['cha_cnt5'];
      rn.cha_amt5 = maps[i]['cha_amt5'];
      rn.cha_cnt6 = maps[i]['cha_cnt6'];
      rn.cha_amt6 = maps[i]['cha_amt6'];
      rn.cha_cnt7 = maps[i]['cha_cnt7'];
      rn.cha_amt7 = maps[i]['cha_amt7'];
      rn.cha_cnt8 = maps[i]['cha_cnt8'];
      rn.cha_amt8 = maps[i]['cha_amt8'];
      rn.cha_cnt9 = maps[i]['cha_cnt9'];
      rn.cha_amt9 = maps[i]['cha_amt9'];
      rn.cha_cnt10 = maps[i]['cha_cnt10'];
      rn.cha_amt10 = maps[i]['cha_amt10'];
      rn.cncl_reason = maps[i]['cncl_reason'];
      rn.sell_sts = maps[i]['sell_sts'];
      rn.sell_kind = maps[i]['sell_kind'];
      rn.sale_kind = maps[i]['sale_kind'];
      rn.seq_inq_no = maps[i]['seq_inq_no'];
      rn.mng_pos_no = maps[i]['mng_pos_no'];
      rn.seq_pos_no = maps[i]['seq_pos_no'];
      rn.tenant_cd = maps[i]['tenant_cd'];
      rn.div_com = maps[i]['div_com'];
      rn.judg_cd = maps[i]['judg_cd'];
      rn.black_check = maps[i]['black_check'];
      rn.card_comp_cd = maps[i]['card_comp_cd'];
      rn.change_chk_no = maps[i]['change_chk_no'];
      rn.cncl_slip_no = maps[i]['cncl_slip_no'];
      rn.sign = maps[i]['sign'];
      rn.card_stre_cd = maps[i]['card_stre_cd'];
      rn.req_code = maps[i]['req_code'];
      rn.card_jis1 = maps[i]['card_jis1'];
      rn.card_jis2 = maps[i]['card_jis2'];
      rn.handle_div = maps[i]['handle_div'];
      rn.pay_a_way = maps[i]['pay_a_way'];
      rn.void_mac_no = maps[i]['void_mac_no'];
      rn.void_receipt_no = maps[i]['void_receipt_no'];
      rn.void_print_no = maps[i]['void_print_no'];
      rn.person_cd = maps[i]['person_cd'];
      return rn;
    });
  }

  @override
  TableColumns toTable(List<Map<String, dynamic>> maps) {
    CCrdtActualLogColumns rn = CCrdtActualLogColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.crdt_flg = maps[0]['crdt_flg'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.receipt_no = maps[0]['receipt_no'];
    rn.print_no = maps[0]['print_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.now_sale_datetime = maps[0]['now_sale_datetime'];
    rn.sale_date = maps[0]['sale_date'];
    rn.ope_mode_flg = maps[0]['ope_mode_flg'];
    rn.crdt_no = maps[0]['crdt_no'];
    rn.data_stat = maps[0]['data_stat'];
    rn.data_div = maps[0]['data_div'];
    rn.ttl_lvl = maps[0]['ttl_lvl'];
    rn.tran_div = maps[0]['tran_div'];
    rn.tran_cd = maps[0]['tran_cd'];
    rn.demand_1st_yymm = maps[0]['demand_1st_yymm'];
    rn.divide_cnt = maps[0]['divide_cnt'];
    rn.stre_join_no = maps[0]['stre_join_no'];
    rn.mbr_cd = maps[0]['mbr_cd'];
    rn.sale_yymmdd = maps[0]['sale_yymmdd'];
    rn.sale_price = maps[0]['sale_price'];
    rn.tax_postage = maps[0]['tax_postage'];
    rn.sale_amt = maps[0]['sale_amt'];
    rn.recogn_no = maps[0]['recogn_no'];
    rn.good_thru = maps[0]['good_thru'];
    rn.filler = maps[0]['filler'];
    rn.bonus_month_sign = maps[0]['bonus_month_sign'];
    rn.bonus_cnt = maps[0]['bonus_cnt'];
    rn.bonus_amt = maps[0]['bonus_amt'];
    rn.bonus_1st_yymm = maps[0]['bonus_1st_yymm'];
    rn.pos_recogn_no = maps[0]['pos_recogn_no'];
    rn.pos_receipt_no = maps[0]['pos_receipt_no'];
    rn.item_cd = maps[0]['item_cd'];
    rn.space = maps[0]['space'];
    rn.cha_cnt1 = maps[0]['cha_cnt1'];
    rn.cha_amt1 = maps[0]['cha_amt1'];
    rn.cha_cnt2 = maps[0]['cha_cnt2'];
    rn.cha_amt2 = maps[0]['cha_amt2'];
    rn.cha_cnt3 = maps[0]['cha_cnt3'];
    rn.cha_amt3 = maps[0]['cha_amt3'];
    rn.cha_cnt4 = maps[0]['cha_cnt4'];
    rn.cha_amt4 = maps[0]['cha_amt4'];
    rn.cha_cnt5 = maps[0]['cha_cnt5'];
    rn.cha_amt5 = maps[0]['cha_amt5'];
    rn.cha_cnt6 = maps[0]['cha_cnt6'];
    rn.cha_amt6 = maps[0]['cha_amt6'];
    rn.cha_cnt7 = maps[0]['cha_cnt7'];
    rn.cha_amt7 = maps[0]['cha_amt7'];
    rn.cha_cnt8 = maps[0]['cha_cnt8'];
    rn.cha_amt8 = maps[0]['cha_amt8'];
    rn.cha_cnt9 = maps[0]['cha_cnt9'];
    rn.cha_amt9 = maps[0]['cha_amt9'];
    rn.cha_cnt10 = maps[0]['cha_cnt10'];
    rn.cha_amt10 = maps[0]['cha_amt10'];
    rn.cncl_reason = maps[0]['cncl_reason'];
    rn.sell_sts = maps[0]['sell_sts'];
    rn.sell_kind = maps[0]['sell_kind'];
    rn.sale_kind = maps[0]['sale_kind'];
    rn.seq_inq_no = maps[0]['seq_inq_no'];
    rn.mng_pos_no = maps[0]['mng_pos_no'];
    rn.seq_pos_no = maps[0]['seq_pos_no'];
    rn.tenant_cd = maps[0]['tenant_cd'];
    rn.div_com = maps[0]['div_com'];
    rn.judg_cd = maps[0]['judg_cd'];
    rn.black_check = maps[0]['black_check'];
    rn.card_comp_cd = maps[0]['card_comp_cd'];
    rn.change_chk_no = maps[0]['change_chk_no'];
    rn.cncl_slip_no = maps[0]['cncl_slip_no'];
    rn.sign = maps[0]['sign'];
    rn.card_stre_cd = maps[0]['card_stre_cd'];
    rn.req_code = maps[0]['req_code'];
    rn.card_jis1 = maps[0]['card_jis1'];
    rn.card_jis2 = maps[0]['card_jis2'];
    rn.handle_div = maps[0]['handle_div'];
    rn.pay_a_way = maps[0]['pay_a_way'];
    rn.void_mac_no = maps[0]['void_mac_no'];
    rn.void_receipt_no = maps[0]['void_receipt_no'];
    rn.void_print_no = maps[0]['void_print_no'];
    rn.person_cd = maps[0]['person_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> toMap() {
    return {
      CCrdtActualLogField.serial_no: this.serial_no,
      CCrdtActualLogField.crdt_flg: this.crdt_flg,
      CCrdtActualLogField.stre_cd: this.stre_cd,
      CCrdtActualLogField.mac_no: this.mac_no,
      CCrdtActualLogField.receipt_no: this.receipt_no,
      CCrdtActualLogField.print_no: this.print_no,
      CCrdtActualLogField.chkr_no: this.chkr_no,
      CCrdtActualLogField.cshr_no: this.cshr_no,
      CCrdtActualLogField.now_sale_datetime: this.now_sale_datetime,
      CCrdtActualLogField.sale_date: this.sale_date,
      CCrdtActualLogField.ope_mode_flg: this.ope_mode_flg,
      CCrdtActualLogField.crdt_no: this.crdt_no,
      CCrdtActualLogField.data_stat: this.data_stat,
      CCrdtActualLogField.data_div: this.data_div,
      CCrdtActualLogField.ttl_lvl: this.ttl_lvl,
      CCrdtActualLogField.tran_div: this.tran_div,
      CCrdtActualLogField.tran_cd: this.tran_cd,
      CCrdtActualLogField.demand_1st_yymm: this.demand_1st_yymm,
      CCrdtActualLogField.divide_cnt: this.divide_cnt,
      CCrdtActualLogField.stre_join_no: this.stre_join_no,
      CCrdtActualLogField.mbr_cd: this.mbr_cd,
      CCrdtActualLogField.sale_yymmdd: this.sale_yymmdd,
      CCrdtActualLogField.sale_price: this.sale_price,
      CCrdtActualLogField.tax_postage: this.tax_postage,
      CCrdtActualLogField.sale_amt: this.sale_amt,
      CCrdtActualLogField.recogn_no: this.recogn_no,
      CCrdtActualLogField.good_thru: this.good_thru,
      CCrdtActualLogField.filler: this.filler,
      CCrdtActualLogField.bonus_month_sign: this.bonus_month_sign,
      CCrdtActualLogField.bonus_cnt: this.bonus_cnt,
      CCrdtActualLogField.bonus_amt: this.bonus_amt,
      CCrdtActualLogField.bonus_1st_yymm: this.bonus_1st_yymm,
      CCrdtActualLogField.pos_recogn_no: this.pos_recogn_no,
      CCrdtActualLogField.pos_receipt_no: this.pos_receipt_no,
      CCrdtActualLogField.item_cd: this.item_cd,
      CCrdtActualLogField.space: this.space,
      CCrdtActualLogField.cha_cnt1: this.cha_cnt1,
      CCrdtActualLogField.cha_amt1: this.cha_amt1,
      CCrdtActualLogField.cha_cnt2: this.cha_cnt2,
      CCrdtActualLogField.cha_amt2: this.cha_amt2,
      CCrdtActualLogField.cha_cnt3: this.cha_cnt3,
      CCrdtActualLogField.cha_amt3: this.cha_amt3,
      CCrdtActualLogField.cha_cnt4: this.cha_cnt4,
      CCrdtActualLogField.cha_amt4: this.cha_amt4,
      CCrdtActualLogField.cha_cnt5: this.cha_cnt5,
      CCrdtActualLogField.cha_amt5: this.cha_amt5,
      CCrdtActualLogField.cha_cnt6: this.cha_cnt6,
      CCrdtActualLogField.cha_amt6: this.cha_amt6,
      CCrdtActualLogField.cha_cnt7: this.cha_cnt7,
      CCrdtActualLogField.cha_amt7: this.cha_amt7,
      CCrdtActualLogField.cha_cnt8: this.cha_cnt8,
      CCrdtActualLogField.cha_amt8: this.cha_amt8,
      CCrdtActualLogField.cha_cnt9: this.cha_cnt9,
      CCrdtActualLogField.cha_amt9: this.cha_amt9,
      CCrdtActualLogField.cha_cnt10: this.cha_cnt10,
      CCrdtActualLogField.cha_amt10: this.cha_amt10,
      CCrdtActualLogField.cncl_reason: this.cncl_reason,
      CCrdtActualLogField.sell_sts: this.sell_sts,
      CCrdtActualLogField.sell_kind: this.sell_kind,
      CCrdtActualLogField.sale_kind: this.sale_kind,
      CCrdtActualLogField.seq_inq_no: this.seq_inq_no,
      CCrdtActualLogField.mng_pos_no: this.mng_pos_no,
      CCrdtActualLogField.seq_pos_no: this.seq_pos_no,
      CCrdtActualLogField.tenant_cd: this.tenant_cd,
      CCrdtActualLogField.div_com: this.div_com,
      CCrdtActualLogField.judg_cd: this.judg_cd,
      CCrdtActualLogField.black_check: this.black_check,
      CCrdtActualLogField.card_comp_cd: this.card_comp_cd,
      CCrdtActualLogField.change_chk_no: this.change_chk_no,
      CCrdtActualLogField.cncl_slip_no: this.cncl_slip_no,
      CCrdtActualLogField.sign: this.sign,
      CCrdtActualLogField.card_stre_cd: this.card_stre_cd,
      CCrdtActualLogField.req_code: this.req_code,
      CCrdtActualLogField.card_jis1: this.card_jis1,
      CCrdtActualLogField.card_jis2: this.card_jis2,
      CCrdtActualLogField.handle_div: this.handle_div,
      CCrdtActualLogField.pay_a_way: this.pay_a_way,
      CCrdtActualLogField.void_mac_no: this.void_mac_no,
      CCrdtActualLogField.void_receipt_no: this.void_receipt_no,
      CCrdtActualLogField.void_print_no: this.void_print_no,
      CCrdtActualLogField.person_cd: this.person_cd,
    };
  }
}

/// クレジット請求ログ（c_crdt_actual_log)のフィールド名設定用クラス
class CCrdtActualLogField {
  static const serial_no = "serial_no";
  static const crdt_flg = "crdt_flg";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const receipt_no = "receipt_no";
  static const print_no = "print_no";
  static const chkr_no = "chkr_no";
  static const cshr_no = "cshr_no";
  static const now_sale_datetime = "now_sale_datetime";
  static const sale_date = "sale_date";
  static const ope_mode_flg = "ope_mode_flg";
  static const crdt_no = "crdt_no";
  static const data_stat = "data_stat";
  static const data_div = "data_div";
  static const ttl_lvl = "ttl_lvl";
  static const tran_div = "tran_div";
  static const tran_cd = "tran_cd";
  static const demand_1st_yymm = "demand_1st_yymm";
  static const divide_cnt = "divide_cnt";
  static const stre_join_no = "stre_join_no";
  static const mbr_cd = "mbr_cd";
  static const sale_yymmdd = "sale_yymmdd";
  static const sale_price = "sale_price";
  static const tax_postage = "tax_postage";
  static const sale_amt = "sale_amt";
  static const recogn_no = "recogn_no";
  static const good_thru = "good_thru";
  static const filler = "filler";
  static const bonus_month_sign = "bonus_month_sign";
  static const bonus_cnt = "bonus_cnt";
  static const bonus_amt = "bonus_amt";
  static const bonus_1st_yymm = "bonus_1st_yymm";
  static const pos_recogn_no = "pos_recogn_no";
  static const pos_receipt_no = "pos_receipt_no";
  static const item_cd = "item_cd";
  static const space = "space";
  static const cha_cnt1 = "cha_cnt1";
  static const cha_amt1 = "cha_amt1";
  static const cha_cnt2 = "cha_cnt2";
  static const cha_amt2 = "cha_amt2";
  static const cha_cnt3 = "cha_cnt3";
  static const cha_amt3 = "cha_amt3";
  static const cha_cnt4 = "cha_cnt4";
  static const cha_amt4 = "cha_amt4";
  static const cha_cnt5 = "cha_cnt5";
  static const cha_amt5 = "cha_amt5";
  static const cha_cnt6 = "cha_cnt6";
  static const cha_amt6 = "cha_amt6";
  static const cha_cnt7 = "cha_cnt7";
  static const cha_amt7 = "cha_amt7";
  static const cha_cnt8 = "cha_cnt8";
  static const cha_amt8 = "cha_amt8";
  static const cha_cnt9 = "cha_cnt9";
  static const cha_amt9 = "cha_amt9";
  static const cha_cnt10 = "cha_cnt10";
  static const cha_amt10 = "cha_amt10";
  static const cncl_reason = "cncl_reason";
  static const sell_sts = "sell_sts";
  static const sell_kind = "sell_kind";
  static const sale_kind = "sale_kind";
  static const seq_inq_no = "seq_inq_no";
  static const mng_pos_no = "mng_pos_no";
  static const seq_pos_no = "seq_pos_no";
  static const tenant_cd = "tenant_cd";
  static const div_com = "div_com";
  static const judg_cd = "judg_cd";
  static const black_check = "black_check";
  static const card_comp_cd = "card_comp_cd";
  static const change_chk_no = "change_chk_no";
  static const cncl_slip_no = "cncl_slip_no";
  static const sign = "sign";
  static const card_stre_cd = "card_stre_cd";
  static const req_code = "req_code";
  static const card_jis1 = "card_jis1";
  static const card_jis2 = "card_jis2";
  static const handle_div = "handle_div";
  static const pay_a_way = "pay_a_way";
  static const void_mac_no = "void_mac_no";
  static const void_receipt_no = "void_receipt_no";
  static const void_print_no = "void_print_no";
  static const person_cd = "person_cd";
}
//endregion
