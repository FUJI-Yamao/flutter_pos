/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
02_販売マスタ系
02_1	商品マスタ	c_plu_mst
02_2	スキャニングＰＬＵテーブル	c_scanplu_mst
02_3	セット商品マスタ	c_setitem_mst
02_4	ケース商品マスタ	c_caseitem_mst
02_5	属性マスタ	c_attrib_mst
02_6	属性商品マスタ	c_attribitem_mst
02_7	酒類分類マスタ	c_liqrcls_mst
02_8	産地・メーカーマスタ	c_maker_mst
02_9	生産者品目マスタ	c_producer_mst
酒品目マスタ c_liqritem_mst
酒税マスタ c_liqrtax_mst
 */

//region 02_1	商品マスタ	c_plu_mst
/// 商品マスタクラス
class CPluMstColumns extends TableColumns {
  int? comp_cd;
  int? stre_cd;
  String? plu_cd;
  int lrgcls_cd = 0;
  int mdlcls_cd = 0;
  int smlcls_cd = 0;
  int tnycls_cd = 0;
  String? eos_cd;
  int bar_typ = 0;
  int item_typ = 0;
  String? item_name;
  String? pos_name;
  String? list_typcapa;
  int list_prc = 0;
  int instruct_prc = 0;
  int pos_prc = 0;
  int cust_prc = 0;
  double? cost_prc = 0;
  int chk_amt = 0;
  int tax_cd_1 = 0;
  int tax_cd_2 = 0;
  int tax_cd_3 = 0;
  int tax_cd_4 = 0;
  int cost_tax_cd = 0;
  double? cost_per = 0;
  double? rbtpremium_per = 1;
  int nonact_flg = 0;
  int prc_chg_flg = 0;
  int rbttarget_flg = 0;
  int stl_dsc_flg = 0;
  int weight_cnt = 0;
  int plu_tare = 0;
  int self_cnt_flg = 0;
  int guara_month = 0;
  int multprc_flg = 0;
  double? multprc_per = 0;
  int weight_flg = 0;
  int mbrdsc_flg = 0;
  int mbrdsc_prc = 0;
  int mny_tckt_flg = 0;
  int stlplus_flg = 0;
  int prom_tckt_no = 0;
  int weight = 0;
  int pctr_tckt_flg = 0;
  int btl_prc = 0;
  int clsdsc_flg = 0;
  int cpn_flg = 0;
  int cpn_prc = 0;
  int plu_cd_flg = 0;
  int self_alert_flg = 0;
  int chg_ckt_flg = 0;
  int self_weight_flg = 0;
  String? msg_name;
  int msg_flg = 0;
  int msg_name_cd = 0;
  String? pop_msg;
  int pop_msg_flg = 0;
  int pop_msg_cd = 0;
  int liqrcls_cd = 0;
  int liqr_typcapa = 0;
  double? alcohol_per = 0;
  int liqrtax_cd = 0;
  String? use1_start_date;
  String? use2_start_date;
  int prc_exe_flg = 0;
  int tmp_exe_flg = 0;
  int cust_dtl_flg = 0;
  int tax_exemption_flg = 0;
  int point_add = 0;
  int coupon_flg = 0;
  int kitchen_prn_flg = 0;
  int pricing_flg = 0;
  int bc_tckt_cnt = 0;
  String? last_sale_datetime;
  int maker_cd = 0;
  int user_val_1 = 0;
  int user_val_2 = 0;
  int user_val_3 = 0;
  int user_val_4 = 0;
  int user_val_5 = 0;
  String? user_val_6;
  int prc_upd_system = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int cust_prc2 = 0;
  int mbrdsc_prc2 = 0;
  int producer_cd = 0;
  int certificate_typ = 0;
  int kind_cd = 0;
  int div_cd = 0;
  int sub1_lrg_cd = 0;
  int sub1_mdl_cd = 0;
  int sub1_sml_cd = 0;
  int sub2_lrg_cd = 0;
  int sub2_mdl_cd = 0;
  int sub2_sml_cd = 0;
  int disc_cd = 0;
  String? typ_no;
  int dlug_flg = 0;
  int otc_flg = 0;
  int item_flg1 = 0;
  int item_flg2 = 0;
  int item_flg3 = 0;
  int item_flg4 = 0;
  int item_flg5 = 0;
  int item_flg6 = 0;
  int item_flg7 = 0;
  int item_flg8 = 0;
  int item_flg9 = 0;
  int item_flg10 = 0;
  int dpnt_rbttarget_flg = 0;
  int dpnt_usetarget_flg = 0;

  @override
  String _getTableName() => 'c_plu_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plu_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plu_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CPluMstColumns rn = CPluMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.tnycls_cd = maps[i]['tnycls_cd'];
      rn.eos_cd = maps[i]['eos_cd'];
      rn.bar_typ = maps[i]['bar_typ'];
      rn.item_typ = maps[i]['item_typ'];
      rn.item_name = maps[i]['item_name'];
      rn.pos_name = maps[i]['pos_name'];
      rn.list_typcapa = maps[i]['list_typcapa'];
      rn.list_prc = maps[i]['list_prc'];
      rn.instruct_prc = maps[i]['instruct_prc'];
      rn.pos_prc = maps[i]['pos_prc'];
      rn.cust_prc = maps[i]['cust_prc'];
      rn.cost_prc = maps[i]['cost_prc'];
      rn.chk_amt = maps[i]['chk_amt'];
      rn.tax_cd_1 = maps[i]['tax_cd_1'];
      rn.tax_cd_2 = maps[i]['tax_cd_2'];
      rn.tax_cd_3 = maps[i]['tax_cd_3'];
      rn.tax_cd_4 = maps[i]['tax_cd_4'];
      rn.cost_tax_cd = maps[i]['cost_tax_cd'];
      rn.cost_per = maps[i]['cost_per'];
      rn.rbtpremium_per = maps[i]['rbtpremium_per'];
      rn.nonact_flg = maps[i]['nonact_flg'];
      rn.prc_chg_flg = maps[i]['prc_chg_flg'];
      rn.rbttarget_flg = maps[i]['rbttarget_flg'];
      rn.stl_dsc_flg = maps[i]['stl_dsc_flg'];
      rn.weight_cnt = maps[i]['weight_cnt'];
      rn.plu_tare = maps[i]['plu_tare'];
      rn.self_cnt_flg = maps[i]['self_cnt_flg'];
      rn.guara_month = maps[i]['guara_month'];
      rn.multprc_flg = maps[i]['multprc_flg'];
      rn.multprc_per = maps[i]['multprc_per'];
      rn.weight_flg = maps[i]['weight_flg'];
      rn.mbrdsc_flg = maps[i]['mbrdsc_flg'];
      rn.mbrdsc_prc = maps[i]['mbrdsc_prc'];
      rn.mny_tckt_flg = maps[i]['mny_tckt_flg'];
      rn.stlplus_flg = maps[i]['stlplus_flg'];
      rn.prom_tckt_no = maps[i]['prom_tckt_no'];
      rn.weight = maps[i]['weight'];
      rn.pctr_tckt_flg = maps[i]['pctr_tckt_flg'];
      rn.btl_prc = maps[i]['btl_prc'];
      rn.clsdsc_flg = maps[i]['clsdsc_flg'];
      rn.cpn_flg = maps[i]['cpn_flg'];
      rn.cpn_prc = maps[i]['cpn_prc'];
      rn.plu_cd_flg = maps[i]['plu_cd_flg'];
      rn.self_alert_flg = maps[i]['self_alert_flg'];
      rn.chg_ckt_flg = maps[i]['chg_ckt_flg'];
      rn.self_weight_flg = maps[i]['self_weight_flg'];
      rn.msg_name = maps[i]['msg_name'];
      rn.msg_flg = maps[i]['msg_flg'];
      rn.msg_name_cd = maps[i]['msg_name_cd'];
      rn.pop_msg = maps[i]['pop_msg'];
      rn.pop_msg_flg = maps[i]['pop_msg_flg'];
      rn.pop_msg_cd = maps[i]['pop_msg_cd'];
      rn.liqrcls_cd = maps[i]['liqrcls_cd'];
      rn.liqr_typcapa = maps[i]['liqr_typcapa'];
      rn.alcohol_per = maps[i]['alcohol_per'];
      rn.liqrtax_cd = maps[i]['liqrtax_cd'];
      rn.use1_start_date = maps[i]['use1_start_date'];
      rn.use2_start_date = maps[i]['use2_start_date'];
      rn.prc_exe_flg = maps[i]['prc_exe_flg'];
      rn.tmp_exe_flg = maps[i]['tmp_exe_flg'];
      rn.cust_dtl_flg = maps[i]['cust_dtl_flg'];
      rn.tax_exemption_flg = maps[i]['tax_exemption_flg'];
      rn.point_add = maps[i]['point_add'];
      rn.coupon_flg = maps[i]['coupon_flg'];
      rn.kitchen_prn_flg = maps[i]['kitchen_prn_flg'];
      rn.pricing_flg = maps[i]['pricing_flg'];
      rn.bc_tckt_cnt = maps[i]['bc_tckt_cnt'];
      rn.last_sale_datetime = maps[i]['last_sale_datetime'];
      rn.maker_cd = maps[i]['maker_cd'];
      rn.user_val_1 = maps[i]['user_val_1'];
      rn.user_val_2 = maps[i]['user_val_2'];
      rn.user_val_3 = maps[i]['user_val_3'];
      rn.user_val_4 = maps[i]['user_val_4'];
      rn.user_val_5 = maps[i]['user_val_5'];
      rn.user_val_6 = maps[i]['user_val_6'];
      rn.prc_upd_system = maps[i]['prc_upd_system'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.cust_prc2 = maps[i]['cust_prc2'];
      rn.mbrdsc_prc2 = maps[i]['mbrdsc_prc2'];
      rn.producer_cd = maps[i]['producer_cd'];
      rn.certificate_typ = maps[i]['certificate_typ'];
      rn.kind_cd = maps[i]['kind_cd'];
      rn.div_cd = maps[i]['div_cd'];
      rn.sub1_lrg_cd = maps[i]['sub1_lrg_cd'];
      rn.sub1_mdl_cd = maps[i]['sub1_mdl_cd'];
      rn.sub1_sml_cd = maps[i]['sub1_sml_cd'];
      rn.sub2_lrg_cd = maps[i]['sub2_lrg_cd'];
      rn.sub2_mdl_cd = maps[i]['sub2_mdl_cd'];
      rn.sub2_sml_cd = maps[i]['sub2_sml_cd'];
      rn.disc_cd = maps[i]['disc_cd'];
      rn.typ_no = maps[i]['typ_no'];
      rn.dlug_flg = maps[i]['dlug_flg'];
      rn.otc_flg = maps[i]['otc_flg'];
      rn.item_flg1 = maps[i]['item_flg1'];
      rn.item_flg2 = maps[i]['item_flg2'];
      rn.item_flg3 = maps[i]['item_flg3'];
      rn.item_flg4 = maps[i]['item_flg4'];
      rn.item_flg5 = maps[i]['item_flg5'];
      rn.item_flg6 = maps[i]['item_flg6'];
      rn.item_flg7 = maps[i]['item_flg7'];
      rn.item_flg8 = maps[i]['item_flg8'];
      rn.item_flg9 = maps[i]['item_flg9'];
      rn.item_flg10 = maps[i]['item_flg10'];
      rn.dpnt_rbttarget_flg = maps[i]['dpnt_rbttarget_flg'];
      rn.dpnt_usetarget_flg = maps[i]['dpnt_usetarget_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CPluMstColumns rn = CPluMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.tnycls_cd = maps[0]['tnycls_cd'];
    rn.eos_cd = maps[0]['eos_cd'];
    rn.bar_typ = maps[0]['bar_typ'];
    rn.item_typ = maps[0]['item_typ'];
    rn.item_name = maps[0]['item_name'];
    rn.pos_name = maps[0]['pos_name'];
    rn.list_typcapa = maps[0]['list_typcapa'];
    rn.list_prc = maps[0]['list_prc'];
    rn.instruct_prc = maps[0]['instruct_prc'];
    rn.pos_prc = maps[0]['pos_prc'];
    rn.cust_prc = maps[0]['cust_prc'];
    rn.cost_prc = maps[0]['cost_prc'];
    rn.chk_amt = maps[0]['chk_amt'];
    rn.tax_cd_1 = maps[0]['tax_cd_1'];
    rn.tax_cd_2 = maps[0]['tax_cd_2'];
    rn.tax_cd_3 = maps[0]['tax_cd_3'];
    rn.tax_cd_4 = maps[0]['tax_cd_4'];
    rn.cost_tax_cd = maps[0]['cost_tax_cd'];
    rn.cost_per = maps[0]['cost_per'];
    rn.rbtpremium_per = maps[0]['rbtpremium_per'];
    rn.nonact_flg = maps[0]['nonact_flg'];
    rn.prc_chg_flg = maps[0]['prc_chg_flg'];
    rn.rbttarget_flg = maps[0]['rbttarget_flg'];
    rn.stl_dsc_flg = maps[0]['stl_dsc_flg'];
    rn.weight_cnt = maps[0]['weight_cnt'];
    rn.plu_tare = maps[0]['plu_tare'];
    rn.self_cnt_flg = maps[0]['self_cnt_flg'];
    rn.guara_month = maps[0]['guara_month'];
    rn.multprc_flg = maps[0]['multprc_flg'];
    rn.multprc_per = maps[0]['multprc_per'];
    rn.weight_flg = maps[0]['weight_flg'];
    rn.mbrdsc_flg = maps[0]['mbrdsc_flg'];
    rn.mbrdsc_prc = maps[0]['mbrdsc_prc'];
    rn.mny_tckt_flg = maps[0]['mny_tckt_flg'];
    rn.stlplus_flg = maps[0]['stlplus_flg'];
    rn.prom_tckt_no = maps[0]['prom_tckt_no'];
    rn.weight = maps[0]['weight'];
    rn.pctr_tckt_flg = maps[0]['pctr_tckt_flg'];
    rn.btl_prc = maps[0]['btl_prc'];
    rn.clsdsc_flg = maps[0]['clsdsc_flg'];
    rn.cpn_flg = maps[0]['cpn_flg'];
    rn.cpn_prc = maps[0]['cpn_prc'];
    rn.plu_cd_flg = maps[0]['plu_cd_flg'];
    rn.self_alert_flg = maps[0]['self_alert_flg'];
    rn.chg_ckt_flg = maps[0]['chg_ckt_flg'];
    rn.self_weight_flg = maps[0]['self_weight_flg'];
    rn.msg_name = maps[0]['msg_name'];
    rn.msg_flg = maps[0]['msg_flg'];
    rn.msg_name_cd = maps[0]['msg_name_cd'];
    rn.pop_msg = maps[0]['pop_msg'];
    rn.pop_msg_flg = maps[0]['pop_msg_flg'];
    rn.pop_msg_cd = maps[0]['pop_msg_cd'];
    rn.liqrcls_cd = maps[0]['liqrcls_cd'];
    rn.liqr_typcapa = maps[0]['liqr_typcapa'];
    rn.alcohol_per = maps[0]['alcohol_per'];
    rn.liqrtax_cd = maps[0]['liqrtax_cd'];
    rn.use1_start_date = maps[0]['use1_start_date'];
    rn.use2_start_date = maps[0]['use2_start_date'];
    rn.prc_exe_flg = maps[0]['prc_exe_flg'];
    rn.tmp_exe_flg = maps[0]['tmp_exe_flg'];
    rn.cust_dtl_flg = maps[0]['cust_dtl_flg'];
    rn.tax_exemption_flg = maps[0]['tax_exemption_flg'];
    rn.point_add = maps[0]['point_add'];
    rn.coupon_flg = maps[0]['coupon_flg'];
    rn.kitchen_prn_flg = maps[0]['kitchen_prn_flg'];
    rn.pricing_flg = maps[0]['pricing_flg'];
    rn.bc_tckt_cnt = maps[0]['bc_tckt_cnt'];
    rn.last_sale_datetime = maps[0]['last_sale_datetime'];
    rn.maker_cd = maps[0]['maker_cd'];
    rn.user_val_1 = maps[0]['user_val_1'];
    rn.user_val_2 = maps[0]['user_val_2'];
    rn.user_val_3 = maps[0]['user_val_3'];
    rn.user_val_4 = maps[0]['user_val_4'];
    rn.user_val_5 = maps[0]['user_val_5'];
    rn.user_val_6 = maps[0]['user_val_6'];
    rn.prc_upd_system = maps[0]['prc_upd_system'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.cust_prc2 = maps[0]['cust_prc2'];
    rn.mbrdsc_prc2 = maps[0]['mbrdsc_prc2'];
    rn.producer_cd = maps[0]['producer_cd'];
    rn.certificate_typ = maps[0]['certificate_typ'];
    rn.kind_cd = maps[0]['kind_cd'];
    rn.div_cd = maps[0]['div_cd'];
    rn.sub1_lrg_cd = maps[0]['sub1_lrg_cd'];
    rn.sub1_mdl_cd = maps[0]['sub1_mdl_cd'];
    rn.sub1_sml_cd = maps[0]['sub1_sml_cd'];
    rn.sub2_lrg_cd = maps[0]['sub2_lrg_cd'];
    rn.sub2_mdl_cd = maps[0]['sub2_mdl_cd'];
    rn.sub2_sml_cd = maps[0]['sub2_sml_cd'];
    rn.disc_cd = maps[0]['disc_cd'];
    rn.typ_no = maps[0]['typ_no'];
    rn.dlug_flg = maps[0]['dlug_flg'];
    rn.otc_flg = maps[0]['otc_flg'];
    rn.item_flg1 = maps[0]['item_flg1'];
    rn.item_flg2 = maps[0]['item_flg2'];
    rn.item_flg3 = maps[0]['item_flg3'];
    rn.item_flg4 = maps[0]['item_flg4'];
    rn.item_flg5 = maps[0]['item_flg5'];
    rn.item_flg6 = maps[0]['item_flg6'];
    rn.item_flg7 = maps[0]['item_flg7'];
    rn.item_flg8 = maps[0]['item_flg8'];
    rn.item_flg9 = maps[0]['item_flg9'];
    rn.item_flg10 = maps[0]['item_flg10'];
    rn.dpnt_rbttarget_flg = maps[0]['dpnt_rbttarget_flg'];
    rn.dpnt_usetarget_flg = maps[0]['dpnt_usetarget_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CPluMstField.comp_cd: comp_cd,
      CPluMstField.stre_cd: stre_cd,
      CPluMstField.plu_cd: plu_cd,
      CPluMstField.lrgcls_cd: lrgcls_cd,
      CPluMstField.mdlcls_cd: mdlcls_cd,
      CPluMstField.smlcls_cd: smlcls_cd,
      CPluMstField.tnycls_cd: tnycls_cd,
      CPluMstField.eos_cd: eos_cd,
      CPluMstField.bar_typ: bar_typ,
      CPluMstField.item_typ: item_typ,
      CPluMstField.item_name: item_name,
      CPluMstField.pos_name: pos_name,
      CPluMstField.list_typcapa: list_typcapa,
      CPluMstField.list_prc: list_prc,
      CPluMstField.instruct_prc: instruct_prc,
      CPluMstField.pos_prc: pos_prc,
      CPluMstField.cust_prc: cust_prc,
      CPluMstField.cost_prc: cost_prc,
      CPluMstField.chk_amt: chk_amt,
      CPluMstField.tax_cd_1: tax_cd_1,
      CPluMstField.tax_cd_2: tax_cd_2,
      CPluMstField.tax_cd_3: tax_cd_3,
      CPluMstField.tax_cd_4: tax_cd_4,
      CPluMstField.cost_tax_cd: cost_tax_cd,
      CPluMstField.cost_per: cost_per,
      CPluMstField.rbtpremium_per: rbtpremium_per,
      CPluMstField.nonact_flg: nonact_flg,
      CPluMstField.prc_chg_flg: prc_chg_flg,
      CPluMstField.rbttarget_flg: rbttarget_flg,
      CPluMstField.stl_dsc_flg: stl_dsc_flg,
      CPluMstField.weight_cnt: weight_cnt,
      CPluMstField.plu_tare: plu_tare,
      CPluMstField.self_cnt_flg: self_cnt_flg,
      CPluMstField.guara_month: guara_month,
      CPluMstField.multprc_flg: multprc_flg,
      CPluMstField.multprc_per: multprc_per,
      CPluMstField.weight_flg: weight_flg,
      CPluMstField.mbrdsc_flg: mbrdsc_flg,
      CPluMstField.mbrdsc_prc: mbrdsc_prc,
      CPluMstField.mny_tckt_flg: mny_tckt_flg,
      CPluMstField.stlplus_flg: stlplus_flg,
      CPluMstField.prom_tckt_no: prom_tckt_no,
      CPluMstField.weight: weight,
      CPluMstField.pctr_tckt_flg: pctr_tckt_flg,
      CPluMstField.btl_prc: btl_prc,
      CPluMstField.clsdsc_flg: clsdsc_flg,
      CPluMstField.cpn_flg: cpn_flg,
      CPluMstField.cpn_prc: cpn_prc,
      CPluMstField.plu_cd_flg: plu_cd_flg,
      CPluMstField.self_alert_flg: self_alert_flg,
      CPluMstField.chg_ckt_flg: chg_ckt_flg,
      CPluMstField.self_weight_flg: self_weight_flg,
      CPluMstField.msg_name: msg_name,
      CPluMstField.msg_flg: msg_flg,
      CPluMstField.msg_name_cd: msg_name_cd,
      CPluMstField.pop_msg: pop_msg,
      CPluMstField.pop_msg_flg: pop_msg_flg,
      CPluMstField.pop_msg_cd: pop_msg_cd,
      CPluMstField.liqrcls_cd: liqrcls_cd,
      CPluMstField.liqr_typcapa: liqr_typcapa,
      CPluMstField.alcohol_per: alcohol_per,
      CPluMstField.liqrtax_cd: liqrtax_cd,
      CPluMstField.use1_start_date: use1_start_date,
      CPluMstField.use2_start_date: use2_start_date,
      CPluMstField.prc_exe_flg: prc_exe_flg,
      CPluMstField.tmp_exe_flg: tmp_exe_flg,
      CPluMstField.cust_dtl_flg: cust_dtl_flg,
      CPluMstField.tax_exemption_flg: tax_exemption_flg,
      CPluMstField.point_add: point_add,
      CPluMstField.coupon_flg: coupon_flg,
      CPluMstField.kitchen_prn_flg: kitchen_prn_flg,
      CPluMstField.pricing_flg: pricing_flg,
      CPluMstField.bc_tckt_cnt: bc_tckt_cnt,
      CPluMstField.last_sale_datetime: last_sale_datetime,
      CPluMstField.maker_cd: maker_cd,
      CPluMstField.user_val_1: user_val_1,
      CPluMstField.user_val_2: user_val_2,
      CPluMstField.user_val_3: user_val_3,
      CPluMstField.user_val_4: user_val_4,
      CPluMstField.user_val_5: user_val_5,
      CPluMstField.user_val_6: user_val_6,
      CPluMstField.prc_upd_system: prc_upd_system,
      CPluMstField.ins_datetime: ins_datetime,
      CPluMstField.upd_datetime: upd_datetime,
      CPluMstField.status: status,
      CPluMstField.send_flg: send_flg,
      CPluMstField.upd_user: upd_user,
      CPluMstField.upd_system: upd_system,
      CPluMstField.cust_prc2: cust_prc2,
      CPluMstField.mbrdsc_prc2: mbrdsc_prc2,
      CPluMstField.producer_cd: producer_cd,
      CPluMstField.certificate_typ: certificate_typ,
      CPluMstField.kind_cd: kind_cd,
      CPluMstField.div_cd: div_cd,
      CPluMstField.sub1_lrg_cd: sub1_lrg_cd,
      CPluMstField.sub1_mdl_cd: sub1_mdl_cd,
      CPluMstField.sub1_sml_cd: sub1_sml_cd,
      CPluMstField.sub2_lrg_cd: sub2_lrg_cd,
      CPluMstField.sub2_mdl_cd: sub2_mdl_cd,
      CPluMstField.sub2_sml_cd: sub2_sml_cd,
      CPluMstField.disc_cd: disc_cd,
      CPluMstField.typ_no: typ_no,
      CPluMstField.dlug_flg: dlug_flg,
      CPluMstField.otc_flg: otc_flg,
      CPluMstField.item_flg1: item_flg1,
      CPluMstField.item_flg2: item_flg2,
      CPluMstField.item_flg3: item_flg3,
      CPluMstField.item_flg4: item_flg4,
      CPluMstField.item_flg5: item_flg5,
      CPluMstField.item_flg6: item_flg6,
      CPluMstField.item_flg7: item_flg7,
      CPluMstField.item_flg8: item_flg8,
      CPluMstField.item_flg9: item_flg9,
      CPluMstField.item_flg10: item_flg10,
      CPluMstField.dpnt_rbttarget_flg: dpnt_rbttarget_flg,
      CPluMstField.dpnt_usetarget_flg: dpnt_usetarget_flg,
    };
  }
}

/// 商品マスタのフィールド名設定用クラス
class CPluMstField {
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const plu_cd = 'plu_cd';
  static const lrgcls_cd = 'lrgcls_cd';
  static const mdlcls_cd = 'mdlcls_cd';
  static const smlcls_cd = 'smlcls_cd';
  static const tnycls_cd = 'tnycls_cd';
  static const eos_cd = 'eos_cd';
  static const bar_typ = 'bar_typ';
  static const item_typ = 'item_typ';
  static const item_name = 'item_name';
  static const pos_name = 'pos_name';
  static const list_typcapa = 'list_typcapa';
  static const list_prc = 'list_prc';
  static const instruct_prc = 'instruct_prc';
  static const pos_prc = 'pos_prc';
  static const cust_prc = 'cust_prc';
  static const cost_prc = 'cost_prc';
  static const chk_amt = 'chk_amt';
  static const tax_cd_1 = 'tax_cd_1';
  static const tax_cd_2 = 'tax_cd_2';
  static const tax_cd_3 = 'tax_cd_3';
  static const tax_cd_4 = 'tax_cd_4';
  static const cost_tax_cd = 'cost_tax_cd';
  static const cost_per = 'cost_per';
  static const rbtpremium_per = 'rbtpremium_per';
  static const nonact_flg = 'nonact_flg';
  static const prc_chg_flg = 'prc_chg_flg';
  static const rbttarget_flg = 'rbttarget_flg';
  static const stl_dsc_flg = 'stl_dsc_flg';
  static const weight_cnt = 'weight_cnt';
  static const plu_tare = 'plu_tare';
  static const self_cnt_flg = 'self_cnt_flg';
  static const guara_month = 'guara_month';
  static const multprc_flg = 'multprc_flg';
  static const multprc_per = 'multprc_per';
  static const weight_flg = 'weight_flg';
  static const mbrdsc_flg = 'mbrdsc_flg';
  static const mbrdsc_prc = 'mbrdsc_prc';
  static const mny_tckt_flg = 'mny_tckt_flg';
  static const stlplus_flg = 'stlplus_flg';
  static const prom_tckt_no = 'prom_tckt_no';
  static const weight = 'weight';
  static const pctr_tckt_flg = 'pctr_tckt_flg';
  static const btl_prc = 'btl_prc';
  static const clsdsc_flg = 'clsdsc_flg';
  static const cpn_flg = 'cpn_flg';
  static const cpn_prc = 'cpn_prc';
  static const plu_cd_flg = 'plu_cd_flg';
  static const self_alert_flg = 'self_alert_flg';
  static const chg_ckt_flg = 'chg_ckt_flg';
  static const self_weight_flg = 'self_weight_flg';
  static const msg_name = 'msg_name';
  static const msg_flg = 'msg_flg';
  static const msg_name_cd = 'msg_name_cd';
  static const pop_msg = 'pop_msg';
  static const pop_msg_flg = 'pop_msg_flg';
  static const pop_msg_cd = 'pop_msg_cd';
  static const liqrcls_cd = 'liqrcls_cd';
  static const liqr_typcapa = 'liqr_typcapa';
  static const alcohol_per = 'alcohol_per';
  static const liqrtax_cd = 'liqrtax_cd';
  static const use1_start_date = 'use1_start_date';
  static const use2_start_date = 'use2_start_date';
  static const prc_exe_flg = 'prc_exe_flg';
  static const tmp_exe_flg = 'tmp_exe_flg';
  static const cust_dtl_flg = 'cust_dtl_flg';
  static const tax_exemption_flg = 'tax_exemption_flg';
  static const point_add = 'point_add';
  static const coupon_flg = 'coupon_flg';
  static const kitchen_prn_flg = 'kitchen_prn_flg';
  static const pricing_flg = 'pricing_flg';
  static const bc_tckt_cnt = 'bc_tckt_cnt';
  static const last_sale_datetime = 'last_sale_datetime';
  static const maker_cd = 'maker_cd';
  static const user_val_1 = 'user_val_1';
  static const user_val_2 = 'user_val_2';
  static const user_val_3 = 'user_val_3';
  static const user_val_4 = 'user_val_4';
  static const user_val_5 = 'user_val_5';
  static const user_val_6 = 'user_val_6';
  static const prc_upd_system = 'prc_upd_system';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
  static const cust_prc2 = 'cust_prc2';
  static const mbrdsc_prc2 = 'mbrdsc_prc2';
  static const producer_cd = 'producer_cd';
  static const certificate_typ = 'certificate_typ';
  static const kind_cd = 'kind_cd';
  static const div_cd = 'div_cd';
  static const sub1_lrg_cd = 'sub1_lrg_cd';
  static const sub1_mdl_cd = 'sub1_mdl_cd';
  static const sub1_sml_cd = 'sub1_sml_cd';
  static const sub2_lrg_cd = 'sub2_lrg_cd';
  static const sub2_mdl_cd = 'sub2_mdl_cd';
  static const sub2_sml_cd = 'sub2_sml_cd';
  static const disc_cd = 'disc_cd';
  static const typ_no = 'typ_no';
  static const dlug_flg = 'dlug_flg';
  static const otc_flg = 'otc_flg';
  static const item_flg1 = 'item_flg1';
  static const item_flg2 = 'item_flg2';
  static const item_flg3 = 'item_flg3';
  static const item_flg4 = 'item_flg4';
  static const item_flg5 = 'item_flg5';
  static const item_flg6 = 'item_flg6';
  static const item_flg7 = 'item_flg7';
  static const item_flg8 = 'item_flg8';
  static const item_flg9 = 'item_flg9';
  static const item_flg10 = 'item_flg10';
  static const dpnt_rbttarget_flg = 'dpnt_rbttarget_flg';
  static const dpnt_usetarget_flg = 'dpnt_usetarget_flg';
}
//endregion
//region 02_2	スキャニングＰＬＵテーブル	c_scanplu_mst
/// 02_2  スキャニングＰＬＵテーブル  c_scanplu_mstクラス
class CScanpluMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  String? sku_cd;
  String? plu_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_scanplu_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND sku_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(sku_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CScanpluMstColumns rn = CScanpluMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.sku_cd = maps[i]['sku_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
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
    CScanpluMstColumns rn = CScanpluMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.sku_cd = maps[0]['sku_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
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
      CScanpluMstField.comp_cd : this.comp_cd,
      CScanpluMstField.stre_cd : this.stre_cd,
      CScanpluMstField.sku_cd : this.sku_cd,
      CScanpluMstField.plu_cd : this.plu_cd,
      CScanpluMstField.ins_datetime : this.ins_datetime,
      CScanpluMstField.upd_datetime : this.upd_datetime,
      CScanpluMstField.status : this.status,
      CScanpluMstField.send_flg : this.send_flg,
      CScanpluMstField.upd_user : this.upd_user,
      CScanpluMstField.upd_system : this.upd_system,
    };
  }
}

/// 02_2  スキャニングＰＬＵテーブル  c_scanplu_mstのフィールド名設定用クラス
class CScanpluMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const sku_cd = "sku_cd";
  static const plu_cd = "plu_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 02_3	セット商品マスタ	c_setitem_mst
/// 02_3  セット商品マスタ c_setitem_mstクラス
class CSetitemMstColumns extends TableColumns{
  int? comp_cd;
  String? setplu_cd;
  String? plu_cd;
  int item_qty = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_setitem_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND setplu_cd = ? AND plu_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(setplu_cd);
    rn.add(plu_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CSetitemMstColumns rn = CSetitemMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.setplu_cd = maps[i]['setplu_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.item_qty = maps[i]['item_qty'];
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
    CSetitemMstColumns rn = CSetitemMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.setplu_cd = maps[0]['setplu_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.item_qty = maps[0]['item_qty'];
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
      CSetitemMstField.comp_cd : this.comp_cd,
      CSetitemMstField.setplu_cd : this.setplu_cd,
      CSetitemMstField.plu_cd : this.plu_cd,
      CSetitemMstField.item_qty : this.item_qty,
      CSetitemMstField.ins_datetime : this.ins_datetime,
      CSetitemMstField.upd_datetime : this.upd_datetime,
      CSetitemMstField.status : this.status,
      CSetitemMstField.send_flg : this.send_flg,
      CSetitemMstField.upd_user : this.upd_user,
      CSetitemMstField.upd_system : this.upd_system,
    };
  }
}

/// 02_3  セット商品マスタ c_setitem_mstのフィールド名設定用クラス
class CSetitemMstField {
  static const comp_cd = "comp_cd";
  static const setplu_cd = "setplu_cd";
  static const plu_cd = "plu_cd";
  static const item_qty = "item_qty";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 02_4	ケース商品マスタ	c_caseitem_mst
/// 02_4  ケース商品マスタ c_caseitem_mstクラス
class CCaseitemMstColumns extends TableColumns{
  int? comp_cd;
  String? caseitem_cd;
  String? plu_cd;
  int item_qty = 0;
  int val_prc = 0;
  int case_typ = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_caseitem_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND caseitem_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(caseitem_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCaseitemMstColumns rn = CCaseitemMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.caseitem_cd = maps[i]['caseitem_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.item_qty = maps[i]['item_qty'];
      rn.val_prc = maps[i]['val_prc'];
      rn.case_typ = maps[i]['case_typ'];
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
    CCaseitemMstColumns rn = CCaseitemMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.caseitem_cd = maps[0]['caseitem_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.item_qty = maps[0]['item_qty'];
    rn.val_prc = maps[0]['val_prc'];
    rn.case_typ = maps[0]['case_typ'];
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
      CCaseitemMstField.comp_cd : this.comp_cd,
      CCaseitemMstField.caseitem_cd : this.caseitem_cd,
      CCaseitemMstField.plu_cd : this.plu_cd,
      CCaseitemMstField.item_qty : this.item_qty,
      CCaseitemMstField.val_prc : this.val_prc,
      CCaseitemMstField.case_typ : this.case_typ,
      CCaseitemMstField.ins_datetime : this.ins_datetime,
      CCaseitemMstField.upd_datetime : this.upd_datetime,
      CCaseitemMstField.status : this.status,
      CCaseitemMstField.send_flg : this.send_flg,
      CCaseitemMstField.upd_user : this.upd_user,
      CCaseitemMstField.upd_system : this.upd_system,
    };
  }
}

/// 02_4  ケース商品マスタ c_caseitem_mstのフィールド名設定用クラス
class CCaseitemMstField {
  static const comp_cd = "comp_cd";
  static const caseitem_cd = "caseitem_cd";
  static const plu_cd = "plu_cd";
  static const item_qty = "item_qty";
  static const val_prc = "val_prc";
  static const case_typ = "case_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 02_5	属性マスタ	c_attrib_mst
/// 02_5  属性マスタ  c_attrib_mstクラス
class CAttribMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? attrib_cd;
  String? name;
  String? short_name;
  int hq_send_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_attrib_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND attrib_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(attrib_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CAttribMstColumns rn = CAttribMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.attrib_cd = maps[i]['attrib_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.hq_send_flg = maps[i]['hq_send_flg'];
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
    CAttribMstColumns rn = CAttribMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.attrib_cd = maps[0]['attrib_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.hq_send_flg = maps[0]['hq_send_flg'];
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
      CAttribMstField.comp_cd : this.comp_cd,
      CAttribMstField.stre_cd : this.stre_cd,
      CAttribMstField.attrib_cd : this.attrib_cd,
      CAttribMstField.name : this.name,
      CAttribMstField.short_name : this.short_name,
      CAttribMstField.hq_send_flg : this.hq_send_flg,
      CAttribMstField.ins_datetime : this.ins_datetime,
      CAttribMstField.upd_datetime : this.upd_datetime,
      CAttribMstField.status : this.status,
      CAttribMstField.send_flg : this.send_flg,
      CAttribMstField.upd_user : this.upd_user,
      CAttribMstField.upd_system : this.upd_system,
    };
  }
}

/// 02_5  属性マスタ  c_attrib_mstのフィールド名設定用クラス
class CAttribMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const attrib_cd = "attrib_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const hq_send_flg = "hq_send_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 02_6	属性商品マスタ	c_attribitem_mst
/// 02_6  属性商品マスタ  c_attribitem_mstクラス
class CAttribitemMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? attrib_cd;
  String? plu_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_attribitem_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND attrib_cd = ? AND plu_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(attrib_cd);
    rn.add(plu_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CAttribitemMstColumns rn = CAttribitemMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.attrib_cd = maps[i]['attrib_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
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
    CAttribitemMstColumns rn = CAttribitemMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.attrib_cd = maps[0]['attrib_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
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
      CAttribitemMstField.comp_cd : this.comp_cd,
      CAttribitemMstField.stre_cd : this.stre_cd,
      CAttribitemMstField.attrib_cd : this.attrib_cd,
      CAttribitemMstField.plu_cd : this.plu_cd,
      CAttribitemMstField.ins_datetime : this.ins_datetime,
      CAttribitemMstField.upd_datetime : this.upd_datetime,
      CAttribitemMstField.status : this.status,
      CAttribitemMstField.send_flg : this.send_flg,
      CAttribitemMstField.upd_user : this.upd_user,
      CAttribitemMstField.upd_system : this.upd_system,
    };
  }
}

/// 02_6  属性商品マスタ  c_attribitem_mstのフィールド名設定用クラス
class CAttribitemMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const attrib_cd = "attrib_cd";
  static const plu_cd = "plu_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 02_7	酒類分類マスタ	c_liqrcls_mst
/// 02_7  酒類分類マスタ  c_liqrcls_mstクラス
class CLiqrclsMstColumns extends TableColumns{
  int? comp_cd;
  int? liqrcls_cd;
  String? liqrcls_name;
  int prn_order = 0;
  int odd_flg = 0;
  int vcnmng = 0;
  int amt_prn = 0;
  int amtclr_flg = 0;
  int powliqr_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_liqrcls_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND liqrcls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(liqrcls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CLiqrclsMstColumns rn = CLiqrclsMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.liqrcls_cd = maps[i]['liqrcls_cd'];
      rn.liqrcls_name = maps[i]['liqrcls_name'];
      rn.prn_order = maps[i]['prn_order'];
      rn.odd_flg = maps[i]['odd_flg'];
      rn.vcnmng = maps[i]['vcnmng'];
      rn.amt_prn = maps[i]['amt_prn'];
      rn.amtclr_flg = maps[i]['amtclr_flg'];
      rn.powliqr_flg = maps[i]['powliqr_flg'];
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
    CLiqrclsMstColumns rn = CLiqrclsMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.liqrcls_cd = maps[0]['liqrcls_cd'];
    rn.liqrcls_name = maps[0]['liqrcls_name'];
    rn.prn_order = maps[0]['prn_order'];
    rn.odd_flg = maps[0]['odd_flg'];
    rn.vcnmng = maps[0]['vcnmng'];
    rn.amt_prn = maps[0]['amt_prn'];
    rn.amtclr_flg = maps[0]['amtclr_flg'];
    rn.powliqr_flg = maps[0]['powliqr_flg'];
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
      CLiqrclsMstField.comp_cd : this.comp_cd,
      CLiqrclsMstField.liqrcls_cd : this.liqrcls_cd,
      CLiqrclsMstField.liqrcls_name : this.liqrcls_name,
      CLiqrclsMstField.prn_order : this.prn_order,
      CLiqrclsMstField.odd_flg : this.odd_flg,
      CLiqrclsMstField.vcnmng : this.vcnmng,
      CLiqrclsMstField.amt_prn : this.amt_prn,
      CLiqrclsMstField.amtclr_flg : this.amtclr_flg,
      CLiqrclsMstField.powliqr_flg : this.powliqr_flg,
      CLiqrclsMstField.ins_datetime : this.ins_datetime,
      CLiqrclsMstField.upd_datetime : this.upd_datetime,
      CLiqrclsMstField.status : this.status,
      CLiqrclsMstField.send_flg : this.send_flg,
      CLiqrclsMstField.upd_user : this.upd_user,
      CLiqrclsMstField.upd_system : this.upd_system,
    };
  }
}

/// 02_7  酒類分類マスタ  c_liqrcls_mstのフィールド名設定用クラス
class CLiqrclsMstField {
  static const comp_cd = "comp_cd";
  static const liqrcls_cd = "liqrcls_cd";
  static const liqrcls_name = "liqrcls_name";
  static const prn_order = "prn_order";
  static const odd_flg = "odd_flg";
  static const vcnmng = "vcnmng";
  static const amt_prn = "amt_prn";
  static const amtclr_flg = "amtclr_flg";
  static const powliqr_flg = "powliqr_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 02_8	産地・メーカーマスタ	c_maker_mst
/// 02_8  産地・メーカーマスタ c_maker_mstクラス
class CMakerMstColumns extends TableColumns{
  int? comp_cd;
  int? maker_cd;
  int? parentmaker_cd;
  String? name;
  String? short_name;
  String? kana_name;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_maker_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND maker_cd = ? AND parentmaker_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(maker_cd);
    rn.add(parentmaker_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMakerMstColumns rn = CMakerMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.maker_cd = maps[i]['maker_cd'];
      rn.parentmaker_cd = maps[i]['parentmaker_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.kana_name = maps[i]['kana_name'];
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
    CMakerMstColumns rn = CMakerMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.maker_cd = maps[0]['maker_cd'];
    rn.parentmaker_cd = maps[0]['parentmaker_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.kana_name = maps[0]['kana_name'];
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
      CMakerMstField.comp_cd : this.comp_cd,
      CMakerMstField.maker_cd : this.maker_cd,
      CMakerMstField.parentmaker_cd : this.parentmaker_cd,
      CMakerMstField.name : this.name,
      CMakerMstField.short_name : this.short_name,
      CMakerMstField.kana_name : this.kana_name,
      CMakerMstField.ins_datetime : this.ins_datetime,
      CMakerMstField.upd_datetime : this.upd_datetime,
      CMakerMstField.status : this.status,
      CMakerMstField.send_flg : this.send_flg,
      CMakerMstField.upd_user : this.upd_user,
      CMakerMstField.upd_system : this.upd_system,
    };
  }
}

/// 02_8  産地・メーカーマスタ c_maker_mstのフィールド名設定用クラス
class CMakerMstField {
  static const comp_cd = "comp_cd";
  static const maker_cd = "maker_cd";
  static const parentmaker_cd = "parentmaker_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const kana_name = "kana_name";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 02_9	生産者品目マスタ	c_producer_mst
/// 02_9  生産者品目マスタ c_producer_mstクラス
class CProducerMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? producer_cd;
  String? name;
  String? short_name;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int tax_cd = 0;
  int producer_misc_1 = 0;
  int producer_misc_2 = 0;
  int producer_misc_3 = 0;
  int producer_misc_4 = 0;
  int producer_misc_5 = 0;

  @override
  String _getTableName() => "c_producer_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND producer_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(producer_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CProducerMstColumns rn = CProducerMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.producer_cd = maps[i]['producer_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.tax_cd = maps[i]['tax_cd'];
      rn.producer_misc_1 = maps[i]['producer_misc_1'];
      rn.producer_misc_2 = maps[i]['producer_misc_2'];
      rn.producer_misc_3 = maps[i]['producer_misc_3'];
      rn.producer_misc_4 = maps[i]['producer_misc_4'];
      rn.producer_misc_5 = maps[i]['producer_misc_5'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CProducerMstColumns rn = CProducerMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.producer_cd = maps[0]['producer_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.tax_cd = maps[0]['tax_cd'];
    rn.producer_misc_1 = maps[0]['producer_misc_1'];
    rn.producer_misc_2 = maps[0]['producer_misc_2'];
    rn.producer_misc_3 = maps[0]['producer_misc_3'];
    rn.producer_misc_4 = maps[0]['producer_misc_4'];
    rn.producer_misc_5 = maps[0]['producer_misc_5'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CProducerMstField.comp_cd : this.comp_cd,
      CProducerMstField.stre_cd : this.stre_cd,
      CProducerMstField.producer_cd : this.producer_cd,
      CProducerMstField.name : this.name,
      CProducerMstField.short_name : this.short_name,
      CProducerMstField.ins_datetime : this.ins_datetime,
      CProducerMstField.upd_datetime : this.upd_datetime,
      CProducerMstField.status : this.status,
      CProducerMstField.send_flg : this.send_flg,
      CProducerMstField.upd_user : this.upd_user,
      CProducerMstField.upd_system : this.upd_system,
      CProducerMstField.tax_cd : this.tax_cd,
      CProducerMstField.producer_misc_1 : this.producer_misc_1,
      CProducerMstField.producer_misc_2 : this.producer_misc_2,
      CProducerMstField.producer_misc_3 : this.producer_misc_3,
      CProducerMstField.producer_misc_4 : this.producer_misc_4,
      CProducerMstField.producer_misc_5 : this.producer_misc_5,
    };
  }
}

/// 02_9  生産者品目マスタ c_producer_mstのフィールド名設定用クラス
class CProducerMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const producer_cd = "producer_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const tax_cd = "tax_cd";
  static const producer_misc_1 = "producer_misc_1";
  static const producer_misc_2 = "producer_misc_2";
  static const producer_misc_3 = "producer_misc_3";
  static const producer_misc_4 = "producer_misc_4";
  static const producer_misc_5 = "producer_misc_5";
}
//endregion
//region 酒品目マスタ c_liqritem_mst
/// 酒品目マスタ c_liqritem_mstクラス
class CLiqritemMstColumns extends TableColumns{
  int? comp_cd;
  int? liqritem_cd;
  String? liqritem_name1;
  String? liqritem_name2;
  String? liqritem_name3;
  int powliqr_flg = 0;
  String? data_c_01;
  String? data_c_02;
  int? data_n_01;
  int? data_n_02;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_liqritem_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND liqritem_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(liqritem_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CLiqritemMstColumns rn = CLiqritemMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.liqritem_cd = maps[i]['liqritem_cd'];
      rn.liqritem_name1 = maps[i]['liqritem_name1'];
      rn.liqritem_name2 = maps[i]['liqritem_name2'];
      rn.liqritem_name3 = maps[i]['liqritem_name3'];
      rn.powliqr_flg = maps[i]['powliqr_flg'];
      rn.data_c_01 = maps[i]['data_c_01'];
      rn.data_c_02 = maps[i]['data_c_02'];
      rn.data_n_01 = maps[i]['data_n_01'];
      rn.data_n_02 = maps[i]['data_n_02'];
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
    CLiqritemMstColumns rn = CLiqritemMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.liqritem_cd = maps[0]['liqritem_cd'];
    rn.liqritem_name1 = maps[0]['liqritem_name1'];
    rn.liqritem_name2 = maps[0]['liqritem_name2'];
    rn.liqritem_name3 = maps[0]['liqritem_name3'];
    rn.powliqr_flg = maps[0]['powliqr_flg'];
    rn.data_c_01 = maps[0]['data_c_01'];
    rn.data_c_02 = maps[0]['data_c_02'];
    rn.data_n_01 = maps[0]['data_n_01'];
    rn.data_n_02 = maps[0]['data_n_02'];
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
      CLiqritemMstField.comp_cd : this.comp_cd,
      CLiqritemMstField.liqritem_cd : this.liqritem_cd,
      CLiqritemMstField.liqritem_name1 : this.liqritem_name1,
      CLiqritemMstField.liqritem_name2 : this.liqritem_name2,
      CLiqritemMstField.liqritem_name3 : this.liqritem_name3,
      CLiqritemMstField.powliqr_flg : this.powliqr_flg,
      CLiqritemMstField.data_c_01 : this.data_c_01,
      CLiqritemMstField.data_c_02 : this.data_c_02,
      CLiqritemMstField.data_n_01 : this.data_n_01,
      CLiqritemMstField.data_n_02 : this.data_n_02,
      CLiqritemMstField.ins_datetime : this.ins_datetime,
      CLiqritemMstField.upd_datetime : this.upd_datetime,
      CLiqritemMstField.status : this.status,
      CLiqritemMstField.send_flg : this.send_flg,
      CLiqritemMstField.upd_user : this.upd_user,
      CLiqritemMstField.upd_system : this.upd_system,
    };
  }
}

/// 酒品目マスタ c_liqritem_mstのフィールド名設定用クラス
class CLiqritemMstField {
  static const comp_cd = "comp_cd";
  static const liqritem_cd = "liqritem_cd";
  static const liqritem_name1 = "liqritem_name1";
  static const liqritem_name2 = "liqritem_name2";
  static const liqritem_name3 = "liqritem_name3";
  static const powliqr_flg = "powliqr_flg";
  static const data_c_01 = "data_c_01";
  static const data_c_02 = "data_c_02";
  static const data_n_01 = "data_n_01";
  static const data_n_02 = "data_n_02";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 酒税マスタ c_liqrtax_mst
/// 酒税マスタ c_liqrtax_mstクラス
class CLiqrtaxMstColumns extends TableColumns{
  int? comp_cd;
  int? liqrtax_cd;
  String? liqrtax_name;
  int liqrtax_rate = 0;
  double? liqrtax_alc = 0;
  double? liqrtax_add = 0;
  int liqrtax_add_amt = 0;
  int? liqrtax_odd_flg;
  String? data_c_01;
  int? data_n_01;
  int? data_n_02;
  double? data_n_03;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_liqrtax_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND liqrtax_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(liqrtax_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CLiqrtaxMstColumns rn = CLiqrtaxMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.liqrtax_cd = maps[i]['liqrtax_cd'];
      rn.liqrtax_name = maps[i]['liqrtax_name'];
      rn.liqrtax_rate = maps[i]['liqrtax_rate'];
      rn.liqrtax_alc = maps[i]['liqrtax_alc'];
      rn.liqrtax_add = maps[i]['liqrtax_add'];
      rn.liqrtax_add_amt = maps[i]['liqrtax_add_amt'];
      rn.liqrtax_odd_flg = maps[i]['liqrtax_odd_flg'];
      rn.data_c_01 = maps[i]['data_c_01'];
      rn.data_n_01 = maps[i]['data_n_01'];
      rn.data_n_02 = maps[i]['data_n_02'];
      rn.data_n_03 = maps[i]['data_n_03'];
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
    CLiqrtaxMstColumns rn = CLiqrtaxMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.liqrtax_cd = maps[0]['liqrtax_cd'];
    rn.liqrtax_name = maps[0]['liqrtax_name'];
    rn.liqrtax_rate = maps[0]['liqrtax_rate'];
    rn.liqrtax_alc = maps[0]['liqrtax_alc'];
    rn.liqrtax_add = maps[0]['liqrtax_add'];
    rn.liqrtax_add_amt = maps[0]['liqrtax_add_amt'];
    rn.liqrtax_odd_flg = maps[0]['liqrtax_odd_flg'];
    rn.data_c_01 = maps[0]['data_c_01'];
    rn.data_n_01 = maps[0]['data_n_01'];
    rn.data_n_02 = maps[0]['data_n_02'];
    rn.data_n_03 = maps[0]['data_n_03'];
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
    CLiqrtaxMstField.comp_cd : this.comp_cd,
    CLiqrtaxMstField.liqrtax_cd : this.liqrtax_cd,
    CLiqrtaxMstField.liqrtax_name : this.liqrtax_name,
    CLiqrtaxMstField.liqrtax_rate : this.liqrtax_rate,
    CLiqrtaxMstField.liqrtax_alc : this.liqrtax_alc,
    CLiqrtaxMstField.liqrtax_add : this.liqrtax_add,
    CLiqrtaxMstField.liqrtax_add_amt : this.liqrtax_add_amt,
    CLiqrtaxMstField.liqrtax_odd_flg : this.liqrtax_odd_flg,
    CLiqrtaxMstField.data_c_01 : this.data_c_01,
    CLiqrtaxMstField.data_n_01 : this.data_n_01,
    CLiqrtaxMstField.data_n_02 : this.data_n_02,
    CLiqrtaxMstField.data_n_03 : this.data_n_03,
    CLiqrtaxMstField.ins_datetime : this.ins_datetime,
    CLiqrtaxMstField.upd_datetime : this.upd_datetime,
    CLiqrtaxMstField.status : this.status,
    CLiqrtaxMstField.send_flg : this.send_flg,
    CLiqrtaxMstField.upd_user : this.upd_user,
    CLiqrtaxMstField.upd_system : this.upd_system,
  };
  }
}

/// 酒税マスタ c_liqrtax_mstのフィールド名設定用クラス
class CLiqrtaxMstField {
  static const comp_cd = "comp_cd";
  static const liqrtax_cd = "liqrtax_cd";
  static const liqrtax_name = "liqrtax_name";
  static const liqrtax_rate = "liqrtax_rate";
  static const liqrtax_alc = "liqrtax_alc";
  static const liqrtax_add = "liqrtax_add";
  static const liqrtax_add_amt = "liqrtax_add_amt";
  static const liqrtax_odd_flg = "liqrtax_odd_flg";
  static const data_c_01 = "data_c_01";
  static const data_n_01 = "data_n_01";
  static const data_n_02 = "data_n_02";
  static const data_n_03 = "data_n_03";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion