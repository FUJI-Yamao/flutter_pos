/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
06_ノンプロモーション系
06_1	企画マスタ	c_plan_mst
06_2	特売マスタ	s_brgn_mst
06_3	バンドルミックスマッチスケジュールマスタ	s_bdlsch_mst
06_4	バンドルミックスマッチ商品マスタ	s_bdlitem_mst
06_5	セットマッチマスタ	s_stmsch_mst
06_6	セットマッチ商品マスタ	s_stmitem_mst
06_7	商品加算ポイントマスタ	s_plu_point_mst
06_8	小計割引スケジュール	s_subtsch_mst
06_9	分類一括割引スケジュール	s_clssch_mst
06_10	サービス分類スケジュールマスタ	s_svs_sch_mst
 */

//region 06_1	企画マスタ	c_plan_mst
/// 06_1  企画マスタ  c_plan_mstクラス
class CPlanMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  String? name;
  String? short_name;
  int loy_flg = 0;
  int? prom_typ;
  String? start_datetime;
  String? end_datetime;
  int trends_typ = 0;
  String? poptitle;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_plan_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CPlanMstColumns rn = CPlanMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.loy_flg = maps[i]['loy_flg'];
      rn.prom_typ = maps[i]['prom_typ'];
      rn.start_datetime = maps[i]['start_datetime'];
      rn.end_datetime = maps[i]['end_datetime'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.poptitle = maps[i]['poptitle'];
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
    CPlanMstColumns rn = CPlanMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.loy_flg = maps[0]['loy_flg'];
    rn.prom_typ = maps[0]['prom_typ'];
    rn.start_datetime = maps[0]['start_datetime'];
    rn.end_datetime = maps[0]['end_datetime'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.poptitle = maps[0]['poptitle'];
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
      CPlanMstField.comp_cd : this.comp_cd,
      CPlanMstField.stre_cd : this.stre_cd,
      CPlanMstField.plan_cd : this.plan_cd,
      CPlanMstField.name : this.name,
      CPlanMstField.short_name : this.short_name,
      CPlanMstField.loy_flg : this.loy_flg,
      CPlanMstField.prom_typ : this.prom_typ,
      CPlanMstField.start_datetime : this.start_datetime,
      CPlanMstField.end_datetime : this.end_datetime,
      CPlanMstField.trends_typ : this.trends_typ,
      CPlanMstField.poptitle : this.poptitle,
      CPlanMstField.promo_ext_id : this.promo_ext_id,
      CPlanMstField.ins_datetime : this.ins_datetime,
      CPlanMstField.upd_datetime : this.upd_datetime,
      CPlanMstField.status : this.status,
      CPlanMstField.send_flg : this.send_flg,
      CPlanMstField.upd_user : this.upd_user,
      CPlanMstField.upd_system : this.upd_system,
    };
  }
}

/// 06_1  企画マスタ  c_plan_mstのフィールド名設定用クラス
class CPlanMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plan_cd = "plan_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const loy_flg = "loy_flg";
  static const prom_typ = "prom_typ";
  static const start_datetime = "start_datetime";
  static const end_datetime = "end_datetime";
  static const trends_typ = "trends_typ";
  static const poptitle = "poptitle";
  static const promo_ext_id = "promo_ext_id";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 06_2	特売マスタ	s_brgn_mst
/// 06_2	特売マスタ	s_brgn_mstクラス
class SBrgnMstColumns extends TableColumns {
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? brgn_cd;
  String? plu_cd;
  int showorder = 0;
  int brgn_typ = 0;
  String? name;
  String? short_name;
  int dsc_flg = 0;
  int svs_typ = 0;
  int dsc_typ = 0;
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
  int trends_typ = 0;
  int brgn_prc = 0;
  int brgncust_prc = 0;
  double? brgn_cost = 0;
  int consist_val1 = 0;
  int gram_prc = 0;
  int markdown_flg = 0;
  int markdown = 0;
  int imagedata_cd = 0;
  int advantize_cd = 0;
  int labelsize = 0;
  int auto_order_flg = 0;
  int div_cd = 0;
  String? promo_ext_id;
  String? comment1;
  String? comment2;
  String? memo1;
  String? memo2;
  int sale_cnt = 0;
  String? sale_unit;
  String? limit_info;
  String? first_service;
  int card1 = 0;
  int card2 = 0;
  int card3 = 0;
  int card4 = 0;
  int card5 = 0;
  int timeprc_dsc_flg = 0;
  int brgn_div = 0;
  double? brgn_costper = 0;
  String? notes;
  int qty_flg = 0;
  int row_order_cnt = 0;
  int row_order_add_cnt = 0;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int date_flg1 = 0;
  int date_flg2 = 0;
  int date_flg3 = 0;
  int date_flg4 = 0;
  int date_flg5 = 0;

  @override
  String _getTableName() => 's_brgn_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND brgn_cd = ? AND plu_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(brgn_cd);
    rn.add(plu_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      SBrgnMstColumns rn = SBrgnMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.brgn_cd = maps[i]['brgn_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.showorder = maps[i]['showorder'];
      rn.brgn_typ = maps[i]['brgn_typ'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.dsc_flg = maps[i]['dsc_flg'];
      rn.svs_typ = maps[i]['svs_typ'];
      rn.dsc_typ = maps[i]['dsc_typ'];
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
      rn.trends_typ = maps[i]['trends_typ'];
      rn.brgn_prc = maps[i]['brgn_prc'];
      rn.brgncust_prc = maps[i]['brgncust_prc'];
      rn.brgn_cost = maps[i]['brgn_cost'];
      rn.consist_val1 = maps[i]['consist_val1'];
      rn.gram_prc = maps[i]['gram_prc'];
      rn.markdown_flg = maps[i]['markdown_flg'];
      rn.markdown = maps[i]['markdown'];
      rn.imagedata_cd = maps[i]['imagedata_cd'];
      rn.advantize_cd = maps[i]['advantize_cd'];
      rn.labelsize = maps[i]['labelsize'];
      rn.auto_order_flg = maps[i]['auto_order_flg'];
      rn.div_cd = maps[i]['div_cd'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.comment1 = maps[i]['comment1'];
      rn.comment2 = maps[i]['comment2'];
      rn.memo1 = maps[i]['memo1'];
      rn.memo2 = maps[i]['memo2'];
      rn.sale_cnt = maps[i]['sale_cnt'];
      rn.sale_unit = maps[i]['sale_unit'];
      rn.limit_info = maps[i]['limit_info'];
      rn.first_service = maps[i]['first_service'];
      rn.card1 = maps[i]['card1'];
      rn.card2 = maps[i]['card2'];
      rn.card3 = maps[i]['card3'];
      rn.card4 = maps[i]['card4'];
      rn.card5 = maps[i]['card5'];
      rn.timeprc_dsc_flg = maps[i]['timeprc_dsc_flg'];
      rn.brgn_div = maps[i]['brgn_div'];
      rn.brgn_costper = maps[i]['brgn_costper'];
      rn.notes = maps[i]['notes'];
      rn.qty_flg = maps[i]['qty_flg'];
      rn.row_order_cnt = maps[i]['row_order_cnt'];
      rn.row_order_add_cnt = maps[i]['row_order_add_cnt'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.date_flg1 = maps[i]['date_flg1'];
      rn.date_flg2 = maps[i]['date_flg2'];
      rn.date_flg3 = maps[i]['date_flg3'];
      rn.date_flg4 = maps[i]['date_flg4'];
      rn.date_flg5 = maps[i]['date_flg5'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SBrgnMstColumns rn = SBrgnMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.brgn_cd = maps[0]['brgn_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.showorder = maps[0]['showorder'];
    rn.brgn_typ = maps[0]['brgn_typ'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.dsc_flg = maps[0]['dsc_flg'];
    rn.svs_typ = maps[0]['svs_typ'];
    rn.dsc_typ = maps[0]['dsc_typ'];
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
    rn.trends_typ = maps[0]['trends_typ'];
    rn.brgn_prc = maps[0]['brgn_prc'];
    rn.brgncust_prc = maps[0]['brgncust_prc'];
    rn.brgn_cost = maps[0]['brgn_cost'];
    rn.consist_val1 = maps[0]['consist_val1'];
    rn.gram_prc = maps[0]['gram_prc'];
    rn.markdown_flg = maps[0]['markdown_flg'];
    rn.markdown = maps[0]['markdown'];
    rn.imagedata_cd = maps[0]['imagedata_cd'];
    rn.advantize_cd = maps[0]['advantize_cd'];
    rn.labelsize = maps[0]['labelsize'];
    rn.auto_order_flg = maps[0]['auto_order_flg'];
    rn.div_cd = maps[0]['div_cd'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.comment1 = maps[0]['comment1'];
    rn.comment2 = maps[0]['comment2'];
    rn.memo1 = maps[0]['memo1'];
    rn.memo2 = maps[0]['memo2'];
    rn.sale_cnt = maps[0]['sale_cnt'];
    rn.sale_unit = maps[0]['sale_unit'];
    rn.limit_info = maps[0]['limit_info'];
    rn.first_service = maps[0]['first_service'];
    rn.card1 = maps[0]['card1'];
    rn.card2 = maps[0]['card2'];
    rn.card3 = maps[0]['card3'];
    rn.card4 = maps[0]['card4'];
    rn.card5 = maps[0]['card5'];
    rn.timeprc_dsc_flg = maps[0]['timeprc_dsc_flg'];
    rn.brgn_div = maps[0]['brgn_div'];
    rn.brgn_costper = maps[0]['brgn_costper'];
    rn.notes = maps[0]['notes'];
    rn.qty_flg = maps[0]['qty_flg'];
    rn.row_order_cnt = maps[0]['row_order_cnt'];
    rn.row_order_add_cnt = maps[0]['row_order_add_cnt'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.date_flg1 = maps[0]['date_flg1'];
    rn.date_flg2 = maps[0]['date_flg2'];
    rn.date_flg3 = maps[0]['date_flg3'];
    rn.date_flg4 = maps[0]['date_flg4'];
    rn.date_flg5 = maps[0]['date_flg5'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SBrgnMstField.comp_cd: comp_cd,
      SBrgnMstField.stre_cd: stre_cd,
      SBrgnMstField.plan_cd: plan_cd,
      SBrgnMstField.brgn_cd: brgn_cd,
      SBrgnMstField.plu_cd: plu_cd,
      SBrgnMstField.showorder: showorder,
      SBrgnMstField.brgn_typ: brgn_typ,
      SBrgnMstField.name: name,
      SBrgnMstField.short_name: short_name,
      SBrgnMstField.dsc_flg: dsc_flg,
      SBrgnMstField.svs_typ: svs_typ,
      SBrgnMstField.dsc_typ: dsc_typ,
      SBrgnMstField.start_datetime: start_datetime,
      SBrgnMstField.end_datetime: end_datetime,
      SBrgnMstField.timesch_flg: timesch_flg,
      SBrgnMstField.sun_flg: sun_flg,
      SBrgnMstField.mon_flg: mon_flg,
      SBrgnMstField.tue_flg: tue_flg,
      SBrgnMstField.wed_flg: wed_flg,
      SBrgnMstField.thu_flg: thu_flg,
      SBrgnMstField.fri_flg: fri_flg,
      SBrgnMstField.sat_flg: sat_flg,
      SBrgnMstField.trends_typ: trends_typ,
      SBrgnMstField.brgn_prc: brgn_prc,
      SBrgnMstField.brgncust_prc: brgncust_prc,
      SBrgnMstField.brgn_cost: brgn_cost,
      SBrgnMstField.consist_val1: consist_val1,
      SBrgnMstField.gram_prc: gram_prc,
      SBrgnMstField.markdown_flg: markdown_flg,
      SBrgnMstField.markdown: markdown,
      SBrgnMstField.imagedata_cd: imagedata_cd,
      SBrgnMstField.advantize_cd: advantize_cd,
      SBrgnMstField.labelsize: labelsize,
      SBrgnMstField.auto_order_flg: auto_order_flg,
      SBrgnMstField.div_cd: div_cd,
      SBrgnMstField.promo_ext_id: promo_ext_id,
      SBrgnMstField.comment1: comment1,
      SBrgnMstField.comment2: comment2,
      SBrgnMstField.memo1: memo1,
      SBrgnMstField.memo2: memo2,
      SBrgnMstField.sale_cnt: sale_cnt,
      SBrgnMstField.sale_unit: sale_unit,
      SBrgnMstField.limit_info: limit_info,
      SBrgnMstField.first_service: first_service,
      SBrgnMstField.card1: card1,
      SBrgnMstField.card2: card2,
      SBrgnMstField.card3: card3,
      SBrgnMstField.card4: card4,
      SBrgnMstField.card5: card5,
      SBrgnMstField.timeprc_dsc_flg: timeprc_dsc_flg,
      SBrgnMstField.brgn_div: brgn_div,
      SBrgnMstField.brgn_costper: brgn_costper,
      SBrgnMstField.notes: notes,
      SBrgnMstField.qty_flg: qty_flg,
      SBrgnMstField.row_order_cnt: row_order_cnt,
      SBrgnMstField.row_order_add_cnt: row_order_add_cnt,
      SBrgnMstField.stop_flg: stop_flg,
      SBrgnMstField.ins_datetime: ins_datetime,
      SBrgnMstField.upd_datetime: upd_datetime,
      SBrgnMstField.status: status,
      SBrgnMstField.send_flg: send_flg,
      SBrgnMstField.upd_user: upd_user,
      SBrgnMstField.upd_system: upd_system,
      SBrgnMstField.date_flg1: date_flg1,
      SBrgnMstField.date_flg2: date_flg2,
      SBrgnMstField.date_flg3: date_flg3,
      SBrgnMstField.date_flg4: date_flg4,
      SBrgnMstField.date_flg5: date_flg5,
    };
  }
}

/// 06_2	特売マスタ	s_brgn_mstのフィールド名設定用クラス
class SBrgnMstField {
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const plan_cd = 'plan_cd';
  static const brgn_cd = 'brgn_cd';
  static const plu_cd = 'plu_cd';
  static const showorder = 'showorder';
  static const brgn_typ = 'brgn_typ';
  static const name = 'name';
  static const short_name = 'short_name';
  static const dsc_flg = 'dsc_flg';
  static const svs_typ = 'svs_typ';
  static const dsc_typ = 'dsc_typ';
  static const start_datetime = 'start_datetime';
  static const end_datetime = 'end_datetime';
  static const timesch_flg = 'timesch_flg';
  static const sun_flg = 'sun_flg';
  static const mon_flg = 'mon_flg';
  static const tue_flg = 'tue_flg';
  static const wed_flg = 'wed_flg';
  static const thu_flg = 'thu_flg';
  static const fri_flg = 'fri_flg';
  static const sat_flg = 'sat_flg';
  static const trends_typ = 'trends_typ';
  static const brgn_prc = 'brgn_prc';
  static const brgncust_prc = 'brgncust_prc';
  static const brgn_cost = 'brgn_cost';
  static const consist_val1 = 'consist_val1';
  static const gram_prc = 'gram_prc';
  static const markdown_flg = 'markdown_flg';
  static const markdown = 'markdown';
  static const imagedata_cd = 'imagedata_cd';
  static const advantize_cd = 'advantize_cd';
  static const labelsize = 'labelsize';
  static const auto_order_flg = 'auto_order_flg';
  static const div_cd = 'div_cd';
  static const promo_ext_id = 'promo_ext_id';
  static const comment1 = 'comment1';
  static const comment2 = 'comment2';
  static const memo1 = 'memo1';
  static const memo2 = 'memo2';
  static const sale_cnt = 'sale_cnt';
  static const sale_unit = 'sale_unit';
  static const limit_info = 'limit_info';
  static const first_service = 'first_service';
  static const card1 = 'card1';
  static const card2 = 'card2';
  static const card3 = 'card3';
  static const card4 = 'card4';
  static const card5 = 'card5';
  static const timeprc_dsc_flg = 'timeprc_dsc_flg';
  static const brgn_div = 'brgn_div';
  static const brgn_costper = 'brgn_costper';
  static const notes = 'notes';
  static const qty_flg = 'qty_flg';
  static const row_order_cnt = 'row_order_cnt';
  static const row_order_add_cnt = 'row_order_add_cnt';
  static const stop_flg = 'stop_flg';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
  static const date_flg1 = 'date_flg1';
  static const date_flg2 = 'date_flg2';
  static const date_flg3 = 'date_flg3';
  static const date_flg4 = 'date_flg4';
  static const date_flg5 = 'date_flg5';
}
//endregion
//region 06_3	バンドルミックスマッチスケジュールマスタ	s_bdlsch_mst
/// 06_3	バンドルミックスマッチスケジュールマスタ	s_bdlsch_mstクラス
class SBdlschMstColumns extends TableColumns {
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? bdl_cd;
  int bdl_typ = 0;
  String? name;
  String? short_name;
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
  int trends_typ = 0;
  int bdl_qty1 = 0;
  int bdl_qty2 = 0;
  int bdl_qty3 = 0;
  int bdl_qty4 = 0;
  int bdl_qty5 = 0;
  int bdl_prc1 = 0;
  int bdl_prc2 = 0;
  int bdl_prc3 = 0;
  int bdl_prc4 = 0;
  int bdl_prc5 = 0;
  int bdl_avprc = 0;
  int limit_cnt = 0;
  int low_limit = 0;
  int mbdl_prc1 = 0;
  int mbdl_prc2 = 0;
  int mbdl_prc3 = 0;
  int mbdl_prc4 = 0;
  int mbdl_prc5 = 0;
  int mbdl_avprc = 0;
  int stop_flg = 0;
  int dsc_flg = 0;
  int div_cd = 0;
  int avprc_adpt_flg = 0;
  int avprc_util_flg = 0;
  String? comment1;
  String? comment2;
  String? memo1;
  String? memo2;
  String? sale_unit;
  String? limit_info;
  String? first_service;
  int card1 = 0;
  int card2 = 0;
  int card3 = 0;
  int card4 = 0;
  int card5 = 0;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int date_flg1 = 0;
  int date_flg2 = 0;
  int date_flg3 = 0;
  int date_flg4 = 0;
  int date_flg5 = 0;

  @override
  String _getTableName() => 's_bdlsch_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND bdl_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(bdl_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      SBdlschMstColumns rn = SBdlschMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.bdl_cd = maps[i]['bdl_cd'];
      rn.bdl_typ = maps[i]['bdl_typ'];
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
      rn.trends_typ = maps[i]['trends_typ'];
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
      rn.bdl_avprc = maps[i]['bdl_avprc'];
      rn.limit_cnt = maps[i]['limit_cnt'];
      rn.low_limit = maps[i]['low_limit'];
      rn.mbdl_prc1 = maps[i]['mbdl_prc1'];
      rn.mbdl_prc2 = maps[i]['mbdl_prc2'];
      rn.mbdl_prc3 = maps[i]['mbdl_prc3'];
      rn.mbdl_prc4 = maps[i]['mbdl_prc4'];
      rn.mbdl_prc5 = maps[i]['mbdl_prc5'];
      rn.mbdl_avprc = maps[i]['mbdl_avprc'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.dsc_flg = maps[i]['dsc_flg'];
      rn.div_cd = maps[i]['div_cd'];
      rn.avprc_adpt_flg = maps[i]['avprc_adpt_flg'];
      rn.avprc_util_flg = maps[i]['avprc_util_flg'];
      rn.comment1 = maps[i]['comment1'];
      rn.comment2 = maps[i]['comment2'];
      rn.memo1 = maps[i]['memo1'];
      rn.memo2 = maps[i]['memo2'];
      rn.sale_unit = maps[i]['sale_unit'];
      rn.limit_info = maps[i]['limit_info'];
      rn.first_service = maps[i]['first_service'];
      rn.card1 = maps[i]['card1'];
      rn.card2 = maps[i]['card2'];
      rn.card3 = maps[i]['card3'];
      rn.card4 = maps[i]['card4'];
      rn.card5 = maps[i]['card5'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.date_flg1 = maps[i]['date_flg1'];
      rn.date_flg2 = maps[i]['date_flg2'];
      rn.date_flg3 = maps[i]['date_flg3'];
      rn.date_flg4 = maps[i]['date_flg4'];
      rn.date_flg5 = maps[i]['date_flg5'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SBdlschMstColumns rn = SBdlschMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.bdl_cd = maps[0]['bdl_cd'];
    rn.bdl_typ = maps[0]['bdl_typ'];
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
    rn.trends_typ = maps[0]['trends_typ'];
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
    rn.bdl_avprc = maps[0]['bdl_avprc'];
    rn.limit_cnt = maps[0]['limit_cnt'];
    rn.low_limit = maps[0]['low_limit'];
    rn.mbdl_prc1 = maps[0]['mbdl_prc1'];
    rn.mbdl_prc2 = maps[0]['mbdl_prc2'];
    rn.mbdl_prc3 = maps[0]['mbdl_prc3'];
    rn.mbdl_prc4 = maps[0]['mbdl_prc4'];
    rn.mbdl_prc5 = maps[0]['mbdl_prc5'];
    rn.mbdl_avprc = maps[0]['mbdl_avprc'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.dsc_flg = maps[0]['dsc_flg'];
    rn.div_cd = maps[0]['div_cd'];
    rn.avprc_adpt_flg = maps[0]['avprc_adpt_flg'];
    rn.avprc_util_flg = maps[0]['avprc_util_flg'];
    rn.comment1 = maps[0]['comment1'];
    rn.comment2 = maps[0]['comment2'];
    rn.memo1 = maps[0]['memo1'];
    rn.memo2 = maps[0]['memo2'];
    rn.sale_unit = maps[0]['sale_unit'];
    rn.limit_info = maps[0]['limit_info'];
    rn.first_service = maps[0]['first_service'];
    rn.card1 = maps[0]['card1'];
    rn.card2 = maps[0]['card2'];
    rn.card3 = maps[0]['card3'];
    rn.card4 = maps[0]['card4'];
    rn.card5 = maps[0]['card5'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.date_flg1 = maps[0]['date_flg1'];
    rn.date_flg2 = maps[0]['date_flg2'];
    rn.date_flg3 = maps[0]['date_flg3'];
    rn.date_flg4 = maps[0]['date_flg4'];
    rn.date_flg5 = maps[0]['date_flg5'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SBdlschMstField.comp_cd: comp_cd,
      SBdlschMstField.stre_cd: stre_cd,
      SBdlschMstField.plan_cd: plan_cd,
      SBdlschMstField.bdl_cd: bdl_cd,
      SBdlschMstField.bdl_typ: bdl_typ,
      SBdlschMstField.name: name,
      SBdlschMstField.short_name: short_name,
      SBdlschMstField.start_datetime: start_datetime,
      SBdlschMstField.end_datetime: end_datetime,
      SBdlschMstField.timesch_flg: timesch_flg,
      SBdlschMstField.sun_flg: sun_flg,
      SBdlschMstField.mon_flg: mon_flg,
      SBdlschMstField.tue_flg: tue_flg,
      SBdlschMstField.wed_flg: wed_flg,
      SBdlschMstField.thu_flg: thu_flg,
      SBdlschMstField.fri_flg: fri_flg,
      SBdlschMstField.sat_flg: sat_flg,
      SBdlschMstField.trends_typ: trends_typ,
      SBdlschMstField.bdl_qty1: bdl_qty1,
      SBdlschMstField.bdl_qty2: bdl_qty2,
      SBdlschMstField.bdl_qty3: bdl_qty3,
      SBdlschMstField.bdl_qty4: bdl_qty4,
      SBdlschMstField.bdl_qty5: bdl_qty5,
      SBdlschMstField.bdl_prc1: bdl_prc1,
      SBdlschMstField.bdl_prc2: bdl_prc2,
      SBdlschMstField.bdl_prc3: bdl_prc3,
      SBdlschMstField.bdl_prc4: bdl_prc4,
      SBdlschMstField.bdl_prc5: bdl_prc5,
      SBdlschMstField.bdl_avprc: bdl_avprc,
      SBdlschMstField.limit_cnt: limit_cnt,
      SBdlschMstField.low_limit: low_limit,
      SBdlschMstField.mbdl_prc1: mbdl_prc1,
      SBdlschMstField.mbdl_prc2: mbdl_prc2,
      SBdlschMstField.mbdl_prc3: mbdl_prc3,
      SBdlschMstField.mbdl_prc4: mbdl_prc4,
      SBdlschMstField.mbdl_prc5: mbdl_prc5,
      SBdlschMstField.mbdl_avprc: mbdl_avprc,
      SBdlschMstField.stop_flg: stop_flg,
      SBdlschMstField.dsc_flg: dsc_flg,
      SBdlschMstField.div_cd: div_cd,
      SBdlschMstField.avprc_adpt_flg: avprc_adpt_flg,
      SBdlschMstField.avprc_util_flg: avprc_util_flg,
      SBdlschMstField.comment1: comment1,
      SBdlschMstField.comment2: comment2,
      SBdlschMstField.memo1: memo1,
      SBdlschMstField.memo2: memo2,
      SBdlschMstField.sale_unit: sale_unit,
      SBdlschMstField.limit_info: limit_info,
      SBdlschMstField.first_service: first_service,
      SBdlschMstField.card1: card1,
      SBdlschMstField.card2: card2,
      SBdlschMstField.card3: card3,
      SBdlschMstField.card4: card4,
      SBdlschMstField.card5: card5,
      SBdlschMstField.promo_ext_id: promo_ext_id,
      SBdlschMstField.ins_datetime: ins_datetime,
      SBdlschMstField.upd_datetime: upd_datetime,
      SBdlschMstField.status: status,
      SBdlschMstField.send_flg: send_flg,
      SBdlschMstField.upd_user: upd_user,
      SBdlschMstField.upd_system: upd_system,
      SBdlschMstField.date_flg1: date_flg1,
      SBdlschMstField.date_flg2: date_flg2,
      SBdlschMstField.date_flg3: date_flg3,
      SBdlschMstField.date_flg4: date_flg4,
      SBdlschMstField.date_flg5: date_flg5,
    };
  }
}

/// 06_3	バンドルミックスマッチスケジュールマスタ	s_bdlsch_mstのフィールド名設定用クラス
class SBdlschMstField {
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const plan_cd = 'plan_cd';
  static const bdl_cd = 'bdl_cd';
  static const bdl_typ = 'bdl_typ';
  static const name = 'name';
  static const short_name = 'short_name';
  static const start_datetime = 'start_datetime';
  static const end_datetime = 'end_datetime';
  static const timesch_flg = 'timesch_flg';
  static const sun_flg = 'sun_flg';
  static const mon_flg = 'mon_flg';
  static const tue_flg = 'tue_flg';
  static const wed_flg = 'wed_flg';
  static const thu_flg = 'thu_flg';
  static const fri_flg = 'fri_flg';
  static const sat_flg = 'sat_flg';
  static const trends_typ = 'trends_typ';
  static const bdl_qty1 = 'bdl_qty1';
  static const bdl_qty2 = 'bdl_qty2';
  static const bdl_qty3 = 'bdl_qty3';
  static const bdl_qty4 = 'bdl_qty4';
  static const bdl_qty5 = 'bdl_qty5';
  static const bdl_prc1 = 'bdl_prc1';
  static const bdl_prc2 = 'bdl_prc2';
  static const bdl_prc3 = 'bdl_prc3';
  static const bdl_prc4 = 'bdl_prc4';
  static const bdl_prc5 = 'bdl_prc5';
  static const bdl_avprc = 'bdl_avprc';
  static const limit_cnt = 'limit_cnt';
  static const low_limit = 'low_limit';
  static const mbdl_prc1 = 'mbdl_prc1';
  static const mbdl_prc2 = 'mbdl_prc2';
  static const mbdl_prc3 = 'mbdl_prc3';
  static const mbdl_prc4 = 'mbdl_prc4';
  static const mbdl_prc5 = 'mbdl_prc5';
  static const mbdl_avprc = 'mbdl_avprc';
  static const stop_flg = 'stop_flg';
  static const dsc_flg = 'dsc_flg';
  static const div_cd = 'div_cd';
  static const avprc_adpt_flg = 'avprc_adpt_flg';
  static const avprc_util_flg = 'avprc_util_flg';
  static const comment1 = 'comment1';
  static const comment2 = 'comment2';
  static const memo1 = 'memo1';
  static const memo2 = 'memo2';
  static const sale_unit = 'sale_unit';
  static const limit_info = 'limit_info';
  static const first_service = 'first_service';
  static const card1 = 'card1';
  static const card2 = 'card2';
  static const card3 = 'card3';
  static const card4 = 'card4';
  static const card5 = 'card5';
  static const promo_ext_id = 'promo_ext_id';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
  static const date_flg1 = 'date_flg1';
  static const date_flg2 = 'date_flg2';
  static const date_flg3 = 'date_flg3';
  static const date_flg4 = 'date_flg4';
  static const date_flg5 = 'date_flg5';
}
//endregion
//region 06_4	バンドルミックスマッチ商品マスタ	s_bdlitem_mst
/// 06_4	バンドルミックスマッチ商品マスタ	s_bdlitem_mstクラス
class SBdlitemMstColumns extends TableColumns {
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? bdl_cd;
  String? plu_cd;
  int showorder = 0;
  int stop_flg = 0;
  String? promo_ext_id;
  String? comment1;
  String? comment2;
  String? memo1;
  String? memo2;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => 's_bdlitem_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND bdl_cd = ? AND plu_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(bdl_cd);
    rn.add(plu_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      SBdlitemMstColumns rn = SBdlitemMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.bdl_cd = maps[i]['bdl_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.showorder = maps[i]['showorder'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.comment1 = maps[i]['comment1'];
      rn.comment2 = maps[i]['comment2'];
      rn.memo1 = maps[i]['memo1'];
      rn.memo2 = maps[i]['memo2'];
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
    SBdlitemMstColumns rn = SBdlitemMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.bdl_cd = maps[0]['bdl_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.showorder = maps[0]['showorder'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.comment1 = maps[0]['comment1'];
    rn.comment2 = maps[0]['comment2'];
    rn.memo1 = maps[0]['memo1'];
    rn.memo2 = maps[0]['memo2'];
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
      SBdlitemMstField.comp_cd: comp_cd,
      SBdlitemMstField.stre_cd: stre_cd,
      SBdlitemMstField.plan_cd: plan_cd,
      SBdlitemMstField.bdl_cd: bdl_cd,
      SBdlitemMstField.plu_cd: plu_cd,
      SBdlitemMstField.showorder: showorder,
      SBdlitemMstField.stop_flg: stop_flg,
      SBdlitemMstField.promo_ext_id: promo_ext_id,
      SBdlitemMstField.comment1: comment1,
      SBdlitemMstField.comment2: comment2,
      SBdlitemMstField.memo1: memo1,
      SBdlitemMstField.memo2: memo2,
      SBdlitemMstField.ins_datetime: ins_datetime,
      SBdlitemMstField.upd_datetime: upd_datetime,
      SBdlitemMstField.status: status,
      SBdlitemMstField.send_flg: send_flg,
      SBdlitemMstField.upd_user: upd_user,
      SBdlitemMstField.upd_system: upd_system,
    };
  }
}

/// 06_4	バンドルミックスマッチ商品マスタ	s_bdlitem_mstのフィールド名設定用クラス
class SBdlitemMstField {
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const plan_cd = 'plan_cd';
  static const bdl_cd = 'bdl_cd';
  static const plu_cd = 'plu_cd';
  static const showorder = 'showorder';
  static const stop_flg = 'stop_flg';
  static const promo_ext_id = 'promo_ext_id';
  static const comment1 = 'comment1';
  static const comment2 = 'comment2';
  static const memo1 = 'memo1';
  static const memo2 = 'memo2';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
}
//endregion
//region 06_5	セットマッチマスタ	s_stmsch_mst
/// 06_5	セットマッチマスタ	s_stmsch_mstクラス
class SStmschMstColumns extends TableColumns {
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? stm_cd;
  String? name;
  String? short_name;
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
  int member_qty = 0;
  int limit_cnt = 0;
  int stop_flg = 0;
  int trends_typ = 0;
  int dsc_flg = 0;
  int stm_prc = 0;
  int stm_prc2 = 0;
  int stm_prc3 = 0;
  int stm_prc4 = 0;
  int stm_prc5 = 0;
  int mstm_prc = 0;
  int mstm_prc2 = 0;
  int mstm_prc3 = 0;
  int mstm_prc4 = 0;
  int mstm_prc5 = 0;
  int div_cd = 0;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int date_flg1 = 0;
  int date_flg2 = 0;
  int date_flg3 = 0;
  int date_flg4 = 0;
  int date_flg5 = 0;

  @override
  String _getTableName() => 's_stmsch_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND stm_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(stm_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      SStmschMstColumns rn = SStmschMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.stm_cd = maps[i]['stm_cd'];
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
      rn.member_qty = maps[i]['member_qty'];
      rn.limit_cnt = maps[i]['limit_cnt'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.dsc_flg = maps[i]['dsc_flg'];
      rn.stm_prc = maps[i]['stm_prc'];
      rn.stm_prc2 = maps[i]['stm_prc2'];
      rn.stm_prc3 = maps[i]['stm_prc3'];
      rn.stm_prc4 = maps[i]['stm_prc4'];
      rn.stm_prc5 = maps[i]['stm_prc5'];
      rn.mstm_prc = maps[i]['mstm_prc'];
      rn.mstm_prc2 = maps[i]['mstm_prc2'];
      rn.mstm_prc3 = maps[i]['mstm_prc3'];
      rn.mstm_prc4 = maps[i]['mstm_prc4'];
      rn.mstm_prc5 = maps[i]['mstm_prc5'];
      rn.div_cd = maps[i]['div_cd'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.date_flg1 = maps[i]['date_flg1'];
      rn.date_flg2 = maps[i]['date_flg2'];
      rn.date_flg3 = maps[i]['date_flg3'];
      rn.date_flg4 = maps[i]['date_flg4'];
      rn.date_flg5 = maps[i]['date_flg5'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SStmschMstColumns rn = SStmschMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.stm_cd = maps[0]['stm_cd'];
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
    rn.member_qty = maps[0]['member_qty'];
    rn.limit_cnt = maps[0]['limit_cnt'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.dsc_flg = maps[0]['dsc_flg'];
    rn.stm_prc = maps[0]['stm_prc'];
    rn.stm_prc2 = maps[0]['stm_prc2'];
    rn.stm_prc3 = maps[0]['stm_prc3'];
    rn.stm_prc4 = maps[0]['stm_prc4'];
    rn.stm_prc5 = maps[0]['stm_prc5'];
    rn.mstm_prc = maps[0]['mstm_prc'];
    rn.mstm_prc2 = maps[0]['mstm_prc2'];
    rn.mstm_prc3 = maps[0]['mstm_prc3'];
    rn.mstm_prc4 = maps[0]['mstm_prc4'];
    rn.mstm_prc5 = maps[0]['mstm_prc5'];
    rn.div_cd = maps[0]['div_cd'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.date_flg1 = maps[0]['date_flg1'];
    rn.date_flg2 = maps[0]['date_flg2'];
    rn.date_flg3 = maps[0]['date_flg3'];
    rn.date_flg4 = maps[0]['date_flg4'];
    rn.date_flg5 = maps[0]['date_flg5'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SStmschMstField.comp_cd: comp_cd,
      SStmschMstField.stre_cd: stre_cd,
      SStmschMstField.plan_cd: plan_cd,
      SStmschMstField.stm_cd: stm_cd,
      SStmschMstField.name: name,
      SStmschMstField.short_name: short_name,
      SStmschMstField.start_datetime: start_datetime,
      SStmschMstField.end_datetime: end_datetime,
      SStmschMstField.timesch_flg: timesch_flg,
      SStmschMstField.sun_flg: sun_flg,
      SStmschMstField.mon_flg: mon_flg,
      SStmschMstField.tue_flg: tue_flg,
      SStmschMstField.wed_flg: wed_flg,
      SStmschMstField.thu_flg: thu_flg,
      SStmschMstField.fri_flg: fri_flg,
      SStmschMstField.sat_flg: sat_flg,
      SStmschMstField.member_qty: member_qty,
      SStmschMstField.limit_cnt: limit_cnt,
      SStmschMstField.stop_flg: stop_flg,
      SStmschMstField.trends_typ: trends_typ,
      SStmschMstField.dsc_flg: dsc_flg,
      SStmschMstField.stm_prc: stm_prc,
      SStmschMstField.stm_prc2: stm_prc2,
      SStmschMstField.stm_prc3: stm_prc3,
      SStmschMstField.stm_prc4: stm_prc4,
      SStmschMstField.stm_prc5: stm_prc5,
      SStmschMstField.mstm_prc: mstm_prc,
      SStmschMstField.mstm_prc2: mstm_prc2,
      SStmschMstField.mstm_prc3: mstm_prc3,
      SStmschMstField.mstm_prc4: mstm_prc4,
      SStmschMstField.mstm_prc5: mstm_prc5,
      SStmschMstField.div_cd: div_cd,
      SStmschMstField.promo_ext_id: promo_ext_id,
      SStmschMstField.ins_datetime: ins_datetime,
      SStmschMstField.upd_datetime: upd_datetime,
      SStmschMstField.status: status,
      SStmschMstField.send_flg: send_flg,
      SStmschMstField.upd_user: upd_user,
      SStmschMstField.upd_system: upd_system,
      SStmschMstField.date_flg1: date_flg1,
      SStmschMstField.date_flg2: date_flg2,
      SStmschMstField.date_flg3: date_flg3,
      SStmschMstField.date_flg4: date_flg4,
      SStmschMstField.date_flg5: date_flg5,
    };
  }
}

/// 06_5	セットマッチマスタ	s_stmsch_mstのフィールド名設定用クラス
class SStmschMstField {
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const plan_cd = 'plan_cd';
  static const stm_cd = 'stm_cd';
  static const name = 'name';
  static const short_name = 'short_name';
  static const start_datetime = 'start_datetime';
  static const end_datetime = 'end_datetime';
  static const timesch_flg = 'timesch_flg';
  static const sun_flg = 'sun_flg';
  static const mon_flg = 'mon_flg';
  static const tue_flg = 'tue_flg';
  static const wed_flg = 'wed_flg';
  static const thu_flg = 'thu_flg';
  static const fri_flg = 'fri_flg';
  static const sat_flg = 'sat_flg';
  static const member_qty = 'member_qty';
  static const limit_cnt = 'limit_cnt';
  static const stop_flg = 'stop_flg';
  static const trends_typ = 'trends_typ';
  static const dsc_flg = 'dsc_flg';
  static const stm_prc = 'stm_prc';
  static const stm_prc2 = 'stm_prc2';
  static const stm_prc3 = 'stm_prc3';
  static const stm_prc4 = 'stm_prc4';
  static const stm_prc5 = 'stm_prc5';
  static const mstm_prc = 'mstm_prc';
  static const mstm_prc2 = 'mstm_prc2';
  static const mstm_prc3 = 'mstm_prc3';
  static const mstm_prc4 = 'mstm_prc4';
  static const mstm_prc5 = 'mstm_prc5';
  static const div_cd = 'div_cd';
  static const promo_ext_id = 'promo_ext_id';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
  static const date_flg1 = 'date_flg1';
  static const date_flg2 = 'date_flg2';
  static const date_flg3 = 'date_flg3';
  static const date_flg4 = 'date_flg4';
  static const date_flg5 = 'date_flg5';
}
//endregion
//region 06_6	セットマッチ商品マスタ	s_stmitem_mst
/// 06_6	セットマッチ商品マスタ	s_stmitem_mstクラス
class SStmitemMstColumns extends TableColumns {
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? stm_cd;
  String? plu_cd;
  int? grpno;
  int stm_qty = 0;
  int? showorder;
  int? poppy_flg;
  int? stop_flg;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => 's_stmitem_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND stm_cd = ? AND plu_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(stm_cd);
    rn.add(plu_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      SStmitemMstColumns rn = SStmitemMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.stm_cd = maps[i]['stm_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.grpno = maps[i]['grpno'];
      rn.stm_qty = maps[i]['stm_qty'];
      rn.showorder = maps[i]['showorder'];
      rn.poppy_flg = maps[i]['poppy_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
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
    SStmitemMstColumns rn = SStmitemMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.stm_cd = maps[0]['stm_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.grpno = maps[0]['grpno'];
    rn.stm_qty = maps[0]['stm_qty'];
    rn.showorder = maps[0]['showorder'];
    rn.poppy_flg = maps[0]['poppy_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
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
      SStmitemMstField.comp_cd: comp_cd,
      SStmitemMstField.stre_cd: stre_cd,
      SStmitemMstField.plan_cd: plan_cd,
      SStmitemMstField.stm_cd: stm_cd,
      SStmitemMstField.plu_cd: plu_cd,
      SStmitemMstField.grpno: grpno,
      SStmitemMstField.stm_qty: stm_qty,
      SStmitemMstField.showorder: showorder,
      SStmitemMstField.poppy_flg: poppy_flg,
      SStmitemMstField.stop_flg: stop_flg,
      SStmitemMstField.promo_ext_id: promo_ext_id,
      SStmitemMstField.ins_datetime: ins_datetime,
      SStmitemMstField.upd_datetime: upd_datetime,
      SStmitemMstField.status: status,
      SStmitemMstField.send_flg: send_flg,
      SStmitemMstField.upd_user: upd_user,
      SStmitemMstField.upd_system: upd_system,
    };
  }
}

/// 06_6	セットマッチ商品マスタ	s_stmitem_mstのフィールド名設定用クラス
class SStmitemMstField {
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const plan_cd = 'plan_cd';
  static const stm_cd = 'stm_cd';
  static const plu_cd = 'plu_cd';
  static const grpno = 'grpno';
  static const stm_qty = 'stm_qty';
  static const showorder = 'showorder';
  static const poppy_flg = 'poppy_flg';
  static const stop_flg = 'stop_flg';
  static const promo_ext_id = 'promo_ext_id';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
}
//endregion
//region 06_7	商品加算ポイントマスタ	s_plu_point_mst
/// 06_7  商品加算ポイントマスタ  s_plu_point_mstクラス
class SPluPointMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? plusch_cd;
  String? plu_cd;
  String? name;
  String? short_name;
  int showorder = 0;
  int point_add = 0;
  int prom_cd1 = 0;
  int prom_cd2 = 0;
  int prom_cd3 = 0;
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
  int trends_typ = 0;
  int acct_cd = 0;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? tnycls_cd;
  int? plu_cls_flg;
  int? pts_type;
  double? pts_rate = 0;
  int? lrgcls_cd;
  int? mdlcls_cd;
  int? smlcls_cd;

  @override
  String _getTableName() => "s_plu_point_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND plusch_cd = ? AND plu_cd = ? AND tnycls_cd = ? AND plu_cls_flg = ? AND pts_type = ? AND lrgcls_cd = ? AND mdlcls_cd = ? AND smlcls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(plusch_cd);
    rn.add(plu_cd);
    rn.add(tnycls_cd);
    rn.add(plu_cls_flg);
    rn.add(pts_type);
    rn.add(lrgcls_cd);
    rn.add(mdlcls_cd);
    rn.add(smlcls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SPluPointMstColumns rn = SPluPointMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.plusch_cd = maps[i]['plusch_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.showorder = maps[i]['showorder'];
      rn.point_add = maps[i]['point_add'];
      rn.prom_cd1 = maps[i]['prom_cd1'];
      rn.prom_cd2 = maps[i]['prom_cd2'];
      rn.prom_cd3 = maps[i]['prom_cd3'];
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
      rn.trends_typ = maps[i]['trends_typ'];
      rn.acct_cd = maps[i]['acct_cd'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.tnycls_cd = maps[i]['tnycls_cd'];
      rn.plu_cls_flg = maps[i]['plu_cls_flg'];
      rn.pts_type = maps[i]['pts_type'];
      rn.pts_rate = maps[i]['pts_rate'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SPluPointMstColumns rn = SPluPointMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.plusch_cd = maps[0]['plusch_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.showorder = maps[0]['showorder'];
    rn.point_add = maps[0]['point_add'];
    rn.prom_cd1 = maps[0]['prom_cd1'];
    rn.prom_cd2 = maps[0]['prom_cd2'];
    rn.prom_cd3 = maps[0]['prom_cd3'];
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
    rn.trends_typ = maps[0]['trends_typ'];
    rn.acct_cd = maps[0]['acct_cd'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.tnycls_cd = maps[0]['tnycls_cd'];
    rn.plu_cls_flg = maps[0]['plu_cls_flg'];
    rn.pts_type = maps[0]['pts_type'];
    rn.pts_rate = maps[0]['pts_rate'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SPluPointMstField.comp_cd : this.comp_cd,
      SPluPointMstField.stre_cd : this.stre_cd,
      SPluPointMstField.plan_cd : this.plan_cd,
      SPluPointMstField.plusch_cd : this.plusch_cd,
      SPluPointMstField.plu_cd : this.plu_cd,
      SPluPointMstField.name : this.name,
      SPluPointMstField.short_name : this.short_name,
      SPluPointMstField.showorder : this.showorder,
      SPluPointMstField.point_add : this.point_add,
      SPluPointMstField.prom_cd1 : this.prom_cd1,
      SPluPointMstField.prom_cd2 : this.prom_cd2,
      SPluPointMstField.prom_cd3 : this.prom_cd3,
      SPluPointMstField.start_datetime : this.start_datetime,
      SPluPointMstField.end_datetime : this.end_datetime,
      SPluPointMstField.timesch_flg : this.timesch_flg,
      SPluPointMstField.sun_flg : this.sun_flg,
      SPluPointMstField.mon_flg : this.mon_flg,
      SPluPointMstField.tue_flg : this.tue_flg,
      SPluPointMstField.wed_flg : this.wed_flg,
      SPluPointMstField.thu_flg : this.thu_flg,
      SPluPointMstField.fri_flg : this.fri_flg,
      SPluPointMstField.sat_flg : this.sat_flg,
      SPluPointMstField.stop_flg : this.stop_flg,
      SPluPointMstField.trends_typ : this.trends_typ,
      SPluPointMstField.acct_cd : this.acct_cd,
      SPluPointMstField.promo_ext_id : this.promo_ext_id,
      SPluPointMstField.ins_datetime : this.ins_datetime,
      SPluPointMstField.upd_datetime : this.upd_datetime,
      SPluPointMstField.status : this.status,
      SPluPointMstField.send_flg : this.send_flg,
      SPluPointMstField.upd_user : this.upd_user,
      SPluPointMstField.upd_system : this.upd_system,
      SPluPointMstField.tnycls_cd : this.tnycls_cd,
      SPluPointMstField.plu_cls_flg : this.plu_cls_flg,
      SPluPointMstField.pts_type : this.pts_type,
      SPluPointMstField.pts_rate : this.pts_rate,
      SPluPointMstField.lrgcls_cd : this.lrgcls_cd,
      SPluPointMstField.mdlcls_cd : this.mdlcls_cd,
      SPluPointMstField.smlcls_cd : this.smlcls_cd,
    };
  }
}

/// 06_7  商品加算ポイントマスタ  s_plu_point_mstのフィールド名設定用クラス
class SPluPointMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plan_cd = "plan_cd";
  static const plusch_cd = "plusch_cd";
  static const plu_cd = "plu_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const showorder = "showorder";
  static const point_add = "point_add";
  static const prom_cd1 = "prom_cd1";
  static const prom_cd2 = "prom_cd2";
  static const prom_cd3 = "prom_cd3";
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
  static const trends_typ = "trends_typ";
  static const acct_cd = "acct_cd";
  static const promo_ext_id = "promo_ext_id";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const tnycls_cd = "tnycls_cd";
  static const plu_cls_flg = "plu_cls_flg";
  static const pts_type = "pts_type";
  static const pts_rate = "pts_rate";
  static const lrgcls_cd = "lrgcls_cd";
  static const mdlcls_cd = "mdlcls_cd";
  static const smlcls_cd = "smlcls_cd";
}
//endregion
//region 06_8	小計割引スケジュール	s_subtsch_mst
/// 06_8  小計割引スケジュール s_subtsch_mstクラス
class SSubtschMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? subt_cd;
  String? name;
  String? short_name;
  int svs_typ = 0;
  int dsc_typ = 0;
  int dsc_prc = 0;
  int mdsc_prc = 0;
  int stl_form_amt = 0;
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
  int trends_typ = 0;
  int stop_flg = 0;
  int div_cd = 0;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "s_subtsch_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND subt_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(subt_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SSubtschMstColumns rn = SSubtschMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.subt_cd = maps[i]['subt_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.svs_typ = maps[i]['svs_typ'];
      rn.dsc_typ = maps[i]['dsc_typ'];
      rn.dsc_prc = maps[i]['dsc_prc'];
      rn.mdsc_prc = maps[i]['mdsc_prc'];
      rn.stl_form_amt = maps[i]['stl_form_amt'];
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
      rn.trends_typ = maps[i]['trends_typ'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.div_cd = maps[i]['div_cd'];
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
    SSubtschMstColumns rn = SSubtschMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.subt_cd = maps[0]['subt_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.svs_typ = maps[0]['svs_typ'];
    rn.dsc_typ = maps[0]['dsc_typ'];
    rn.dsc_prc = maps[0]['dsc_prc'];
    rn.mdsc_prc = maps[0]['mdsc_prc'];
    rn.stl_form_amt = maps[0]['stl_form_amt'];
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
    rn.trends_typ = maps[0]['trends_typ'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.div_cd = maps[0]['div_cd'];
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
      SSubtschMstField.comp_cd : this.comp_cd,
      SSubtschMstField.stre_cd : this.stre_cd,
      SSubtschMstField.plan_cd : this.plan_cd,
      SSubtschMstField.subt_cd : this.subt_cd,
      SSubtschMstField.name : this.name,
      SSubtschMstField.short_name : this.short_name,
      SSubtschMstField.svs_typ : this.svs_typ,
      SSubtschMstField.dsc_typ : this.dsc_typ,
      SSubtschMstField.dsc_prc : this.dsc_prc,
      SSubtschMstField.mdsc_prc : this.mdsc_prc,
      SSubtschMstField.stl_form_amt : this.stl_form_amt,
      SSubtschMstField.start_datetime : this.start_datetime,
      SSubtschMstField.end_datetime : this.end_datetime,
      SSubtschMstField.timesch_flg : this.timesch_flg,
      SSubtschMstField.sun_flg : this.sun_flg,
      SSubtschMstField.mon_flg : this.mon_flg,
      SSubtschMstField.tue_flg : this.tue_flg,
      SSubtschMstField.wed_flg : this.wed_flg,
      SSubtschMstField.thu_flg : this.thu_flg,
      SSubtschMstField.fri_flg : this.fri_flg,
      SSubtschMstField.sat_flg : this.sat_flg,
      SSubtschMstField.trends_typ : this.trends_typ,
      SSubtschMstField.stop_flg : this.stop_flg,
      SSubtschMstField.div_cd : this.div_cd,
      SSubtschMstField.promo_ext_id : this.promo_ext_id,
      SSubtschMstField.ins_datetime : this.ins_datetime,
      SSubtschMstField.upd_datetime : this.upd_datetime,
      SSubtschMstField.status : this.status,
      SSubtschMstField.send_flg : this.send_flg,
      SSubtschMstField.upd_user : this.upd_user,
      SSubtschMstField.upd_system : this.upd_system,
    };
  }
}

/// 06_8  小計割引スケジュール s_subtsch_mstのフィールド名設定用クラス
class SSubtschMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plan_cd = "plan_cd";
  static const subt_cd = "subt_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const svs_typ = "svs_typ";
  static const dsc_typ = "dsc_typ";
  static const dsc_prc = "dsc_prc";
  static const mdsc_prc = "mdsc_prc";
  static const stl_form_amt = "stl_form_amt";
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
  static const trends_typ = "trends_typ";
  static const stop_flg = "stop_flg";
  static const div_cd = "div_cd";
  static const promo_ext_id = "promo_ext_id";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 06_9	分類一括割引スケジュール	s_clssch_mst
/// 06_9  分類一括割引スケジュール s_clssch_mstクラス
class SClsschMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? sch_cd;
  int? lrgcls_cd;
  int? mdlcls_cd;
  int? smlcls_cd;
  int? tnycls_cd;
  int svs_class = 0;
  String? name;
  String? short_name;
  int svs_typ = 0;
  int dsc_typ = 0;
  int dsc_prc = 0;
  int mdsc_prc = 0;
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
  int trends_typ = 0;
  int stop_flg = 0;
  int div_cd = 0;
  String? promo_ext_id;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "s_clssch_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND sch_cd = ? AND lrgcls_cd = ? AND mdlcls_cd = ? AND smlcls_cd = ? AND tnycls_cd = ? AND svs_class = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(sch_cd);
    rn.add(lrgcls_cd);
    rn.add(mdlcls_cd);
    rn.add(smlcls_cd);
    rn.add(tnycls_cd);
    rn.add(svs_class);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SClsschMstColumns rn = SClsschMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.sch_cd = maps[i]['sch_cd'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.tnycls_cd = maps[i]['tnycls_cd'];
      rn.svs_class = maps[i]['svs_class'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.svs_typ = maps[i]['svs_typ'];
      rn.dsc_typ = maps[i]['dsc_typ'];
      rn.dsc_prc = maps[i]['dsc_prc'];
      rn.mdsc_prc = maps[i]['mdsc_prc'];
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
      rn.trends_typ = maps[i]['trends_typ'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.div_cd = maps[i]['div_cd'];
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
    SClsschMstColumns rn = SClsschMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.sch_cd = maps[0]['sch_cd'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.tnycls_cd = maps[0]['tnycls_cd'];
    rn.svs_class = maps[0]['svs_class'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.svs_typ = maps[0]['svs_typ'];
    rn.dsc_typ = maps[0]['dsc_typ'];
    rn.dsc_prc = maps[0]['dsc_prc'];
    rn.mdsc_prc = maps[0]['mdsc_prc'];
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
    rn.trends_typ = maps[0]['trends_typ'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.div_cd = maps[0]['div_cd'];
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
      SClsschMstField.comp_cd : this.comp_cd,
      SClsschMstField.stre_cd : this.stre_cd,
      SClsschMstField.plan_cd : this.plan_cd,
      SClsschMstField.sch_cd : this.sch_cd,
      SClsschMstField.lrgcls_cd : this.lrgcls_cd,
      SClsschMstField.mdlcls_cd : this.mdlcls_cd,
      SClsschMstField.smlcls_cd : this.smlcls_cd,
      SClsschMstField.tnycls_cd : this.tnycls_cd,
      SClsschMstField.svs_class : this.svs_class,
      SClsschMstField.name : this.name,
      SClsschMstField.short_name : this.short_name,
      SClsschMstField.svs_typ : this.svs_typ,
      SClsschMstField.dsc_typ : this.dsc_typ,
      SClsschMstField.dsc_prc : this.dsc_prc,
      SClsschMstField.mdsc_prc : this.mdsc_prc,
      SClsschMstField.start_datetime : this.start_datetime,
      SClsschMstField.end_datetime : this.end_datetime,
      SClsschMstField.timesch_flg : this.timesch_flg,
      SClsschMstField.sun_flg : this.sun_flg,
      SClsschMstField.mon_flg : this.mon_flg,
      SClsschMstField.tue_flg : this.tue_flg,
      SClsschMstField.wed_flg : this.wed_flg,
      SClsschMstField.thu_flg : this.thu_flg,
      SClsschMstField.fri_flg : this.fri_flg,
      SClsschMstField.sat_flg : this.sat_flg,
      SClsschMstField.trends_typ : this.trends_typ,
      SClsschMstField.stop_flg : this.stop_flg,
      SClsschMstField.div_cd : this.div_cd,
      SClsschMstField.promo_ext_id : this.promo_ext_id,
      SClsschMstField.ins_datetime : this.ins_datetime,
      SClsschMstField.upd_datetime : this.upd_datetime,
      SClsschMstField.status : this.status,
      SClsschMstField.send_flg : this.send_flg,
      SClsschMstField.upd_user : this.upd_user,
      SClsschMstField.upd_system : this.upd_system,
    };
  }
}

/// 06_9  分類一括割引スケジュール s_clssch_mstのフィールド名設定用クラス
class SClsschMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plan_cd = "plan_cd";
  static const sch_cd = "sch_cd";
  static const lrgcls_cd = "lrgcls_cd";
  static const mdlcls_cd = "mdlcls_cd";
  static const smlcls_cd = "smlcls_cd";
  static const tnycls_cd = "tnycls_cd";
  static const svs_class = "svs_class";
  static const name = "name";
  static const short_name = "short_name";
  static const svs_typ = "svs_typ";
  static const dsc_typ = "dsc_typ";
  static const dsc_prc = "dsc_prc";
  static const mdsc_prc = "mdsc_prc";
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
  static const trends_typ = "trends_typ";
  static const stop_flg = "stop_flg";
  static const div_cd = "div_cd";
  static const promo_ext_id = "promo_ext_id";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 06_10	サービス分類スケジュールマスタ	s_svs_sch_mst
/// 06_10 サービス分類スケジュールマスタ  s_svs_sch_mstクラス
class SSvsSchMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? plan_cd;
  int? svs_cls_sch_cd;
  int? svs_cls_cd;
  String? svs_cls_sch_name;
  double? point_add_magn = 0;
  int point_add_mem_typ = 0;
  double? f_data1 = 0;
  int s_data1 = 0;
  int s_data2 = 0;
  int s_data3 = 0;
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
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int acct_cd = 0;

  @override
  String _getTableName() => "s_svs_sch_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND svs_cls_sch_cd = ? AND svs_cls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(svs_cls_sch_cd);
    rn.add(svs_cls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SSvsSchMstColumns rn = SSvsSchMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.svs_cls_sch_cd = maps[i]['svs_cls_sch_cd'];
      rn.svs_cls_cd = maps[i]['svs_cls_cd'];
      rn.svs_cls_sch_name = maps[i]['svs_cls_sch_name'];
      rn.point_add_magn = maps[i]['point_add_magn'];
      rn.point_add_mem_typ = maps[i]['point_add_mem_typ'];
      rn.f_data1 = maps[i]['f_data1'];
      rn.s_data1 = maps[i]['s_data1'];
      rn.s_data2 = maps[i]['s_data2'];
      rn.s_data3 = maps[i]['s_data3'];
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
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.acct_cd = maps[i]['acct_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    SSvsSchMstColumns rn = SSvsSchMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.svs_cls_sch_cd = maps[0]['svs_cls_sch_cd'];
    rn.svs_cls_cd = maps[0]['svs_cls_cd'];
    rn.svs_cls_sch_name = maps[0]['svs_cls_sch_name'];
    rn.point_add_magn = maps[0]['point_add_magn'];
    rn.point_add_mem_typ = maps[0]['point_add_mem_typ'];
    rn.f_data1 = maps[0]['f_data1'];
    rn.s_data1 = maps[0]['s_data1'];
    rn.s_data2 = maps[0]['s_data2'];
    rn.s_data3 = maps[0]['s_data3'];
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
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.acct_cd = maps[0]['acct_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      SSvsSchMstField.comp_cd : this.comp_cd,
      SSvsSchMstField.stre_cd : this.stre_cd,
      SSvsSchMstField.plan_cd : this.plan_cd,
      SSvsSchMstField.svs_cls_sch_cd : this.svs_cls_sch_cd,
      SSvsSchMstField.svs_cls_cd : this.svs_cls_cd,
      SSvsSchMstField.svs_cls_sch_name : this.svs_cls_sch_name,
      SSvsSchMstField.point_add_magn : this.point_add_magn,
      SSvsSchMstField.point_add_mem_typ : this.point_add_mem_typ,
      SSvsSchMstField.f_data1 : this.f_data1,
      SSvsSchMstField.s_data1 : this.s_data1,
      SSvsSchMstField.s_data2 : this.s_data2,
      SSvsSchMstField.s_data3 : this.s_data3,
      SSvsSchMstField.start_datetime : this.start_datetime,
      SSvsSchMstField.end_datetime : this.end_datetime,
      SSvsSchMstField.timesch_flg : this.timesch_flg,
      SSvsSchMstField.sun_flg : this.sun_flg,
      SSvsSchMstField.mon_flg : this.mon_flg,
      SSvsSchMstField.tue_flg : this.tue_flg,
      SSvsSchMstField.wed_flg : this.wed_flg,
      SSvsSchMstField.thu_flg : this.thu_flg,
      SSvsSchMstField.fri_flg : this.fri_flg,
      SSvsSchMstField.sat_flg : this.sat_flg,
      SSvsSchMstField.stop_flg : this.stop_flg,
      SSvsSchMstField.ins_datetime : this.ins_datetime,
      SSvsSchMstField.upd_datetime : this.upd_datetime,
      SSvsSchMstField.status : this.status,
      SSvsSchMstField.send_flg : this.send_flg,
      SSvsSchMstField.upd_user : this.upd_user,
      SSvsSchMstField.upd_system : this.upd_system,
      SSvsSchMstField.acct_cd : this.acct_cd,
    };
  }
}

/// 06_10 サービス分類スケジュールマスタ  s_svs_sch_mstのフィールド名設定用クラス
class SSvsSchMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plan_cd = "plan_cd";
  static const svs_cls_sch_cd = "svs_cls_sch_cd";
  static const svs_cls_cd = "svs_cls_cd";
  static const svs_cls_sch_name = "svs_cls_sch_name";
  static const point_add_magn = "point_add_magn";
  static const point_add_mem_typ = "point_add_mem_typ";
  static const f_data1 = "f_data1";
  static const s_data1 = "s_data1";
  static const s_data2 = "s_data2";
  static const s_data3 = "s_data3";
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
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const acct_cd = "acct_cd";
}
//endregion