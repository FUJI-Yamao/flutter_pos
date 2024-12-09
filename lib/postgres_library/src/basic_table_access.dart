/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
01_基本マスタ系
01_1	企業マスタ	c_comp_mst
01_2	店舗マスタ	c_stre_mst
01_3	店舗通信マスタ	c_connect_mst
01_4	分類マスタ	c_cls_mst
01_5	分類グループマスタ	c_grp_mst
01_6	郵便番号マスタ	c_zipcode_mst
01_7	税金テーブルマスタ	c_tax_mst
01_8	カレンダーマスタ	c_caldr_mst
01_9	祝日マスタ	s_nathldy_mst
01_10	サブ1分類マスタ	c_sub1_cls_mst
01_11	サブ2分類マスタ	c_sub2_cls_mst
 */

//region 01_1	企業マスタ	c_comp_mst
/// 01_1	企業マスタ	c_comp_mstクラス
class CCompMstColumns extends TableColumns {
  int? comp_cd;
  int comp_typ = 0;
  int rtr_id = 0;
  String? name;
  String? short_name;
  String? kana_name;
  String? post_no;
  String? adress1;
  String? adress2;
  String? adress3;
  String? telno1;
  String? telno2;
  String? srch_telno1;
  String? srch_telno2;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => 'c_comp_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CCompMstColumns rn = CCompMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.comp_typ = maps[i]['comp_typ'];
      rn.rtr_id = maps[i]['rtr_id'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.kana_name = maps[i]['kana_name'];
      rn.post_no = maps[i]['post_no'];
      rn.adress1 = maps[i]['adress1'];
      rn.adress2 = maps[i]['adress2'];
      rn.adress3 = maps[i]['adress3'];
      rn.telno1 = maps[i]['telno1'];
      rn.telno2 = maps[i]['telno2'];
      rn.srch_telno1 = maps[i]['srch_telno1'];
      rn.srch_telno2 = maps[i]['srch_telno2'];
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
    CCompMstColumns rn = CCompMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.comp_typ = maps[0]['comp_typ'];
    rn.rtr_id = maps[0]['rtr_id'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.kana_name = maps[0]['kana_name'];
    rn.post_no = maps[0]['post_no'];
    rn.adress1 = maps[0]['adress1'];
    rn.adress2 = maps[0]['adress2'];
    rn.adress3 = maps[0]['adress3'];
    rn.telno1 = maps[0]['telno1'];
    rn.telno2 = maps[0]['telno2'];
    rn.srch_telno1 = maps[0]['srch_telno1'];
    rn.srch_telno2 = maps[0]['srch_telno2'];
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
      CCompMstField.comp_cd: comp_cd,
      CCompMstField.comp_typ: comp_typ,
      CCompMstField.rtr_id: rtr_id,
      CCompMstField.name: name,
      CCompMstField.short_name: short_name,
      CCompMstField.kana_name: kana_name,
      CCompMstField.post_no: post_no,
      CCompMstField.adress1: adress1,
      CCompMstField.adress2: adress2,
      CCompMstField.adress3: adress3,
      CCompMstField.telno1: telno1,
      CCompMstField.telno2: telno2,
      CCompMstField.srch_telno1: srch_telno1,
      CCompMstField.srch_telno2: srch_telno2,
      CCompMstField.ins_datetime: ins_datetime,
      CCompMstField.upd_datetime: upd_datetime,
      CCompMstField.status: status,
      CCompMstField.send_flg: send_flg,
      CCompMstField.upd_user: upd_user,
      CCompMstField.upd_system: upd_system,
    };
  }
}

/// 企業マスタのフィールド名設定用クラス
class CCompMstField {
  static const comp_cd = 'comp_cd';
  static const comp_typ = 'comp_typ';
  static const rtr_id = 'rtr_id';
  static const name = 'name';
  static const short_name = 'short_name';
  static const kana_name = 'kana_name';
  static const post_no = 'post_no';
  static const adress1 = 'adress1';
  static const adress2 = 'adress2';
  static const adress3 = 'adress3';
  static const telno1 = 'telno1';
  static const telno2 = 'telno2';
  static const srch_telno1 = 'srch_telno1';
  static const srch_telno2 = 'srch_telno2';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
}
//endregion
//region 01_2	店舗マスタ	c_stre_mst
/// 01_2	店舗マスタ	c_stre_mstクラス
class CStreMstColumns extends TableColumns{
  int? stre_cd;
  int? comp_cd;
  int zone_cd = 0;
  int bsct_cd = 0;
  String? name;
  String? short_name;
  String? kana_name;
  String? post_no;
  String? adress1;
  String? adress2;
  String? adress3;
  String? telno1;
  String? telno2;
  String? srch_telno1;
  String? srch_telno2;
  String? ip_addr;
  int trends_typ = 0;
  int stre_typ = 0;
  int flg_shp = 0;
  int business_typ1 = 0;
  int business_typ2 = 0;
  int chain_other_flg = 0;
  int locate_typ = 0;
  int openclose_flg = 0;
  String? opentime;
  String? closetime;
  double? floorspace = 0;
  String? today;
  String? bfrday;
  String? twodaybfr;
  String? nextday;
  int sysflg_base = 0;
  int sysflg_sale = 0;
  int sysflg_purchs = 0;
  int sysflg_order = 0;
  int sysflg_invtry = 0;
  int sysflg_cust = 0;
  int sysflg_poppy = 0;
  int sysflg_elslbl = 0;
  int sysflg_fresh = 0;
  int sysflg_wdslbl = 0;
  int sysflg_24hour = 0;
  int showorder = 0;
  String? opendate;
  int stre_ver_flg = 0;
  int sunday_off_flg = 0;
  int monday_off_flg = 0;
  int tuesday_off_flg = 0;
  int wednesday_off_flg = 0;
  int thursday_off_flg = 0;
  int friday_off_flg = 0;
  int saturday_off_flg = 0;
  int itemstock_flg = 0;
  String? wait_time;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  String? entry_no;

  @override
  String _getTableName() => "c_stre_mst";

  @override
  String? _getKeyCondition() => 'stre_cd = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(stre_cd);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStreMstColumns rn = CStreMstColumns();
      rn.stre_cd = maps[i]['stre_cd'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.zone_cd = maps[i]['zone_cd'];
      rn.bsct_cd = maps[i]['bsct_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.kana_name = maps[i]['kana_name'];
      rn.post_no = maps[i]['post_no'];
      rn.adress1 = maps[i]['adress1'];
      rn.adress2 = maps[i]['adress2'];
      rn.adress3 = maps[i]['adress3'];
      rn.telno1 = maps[i]['telno1'];
      rn.telno2 = maps[i]['telno2'];
      rn.srch_telno1 = maps[i]['srch_telno1'];
      rn.srch_telno2 = maps[i]['srch_telno2'];
      rn.ip_addr = maps[i]['ip_addr'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.stre_typ = maps[i]['stre_typ'];
      rn.flg_shp = maps[i]['flg_shp'];
      rn.business_typ1 = maps[i]['business_typ1'];
      rn.business_typ2 = maps[i]['business_typ2'];
      rn.chain_other_flg = maps[i]['chain_other_flg'];
      rn.locate_typ = maps[i]['locate_typ'];
      rn.openclose_flg = maps[i]['openclose_flg'];
      rn.opentime = maps[i]['opentime'];
      rn.closetime = maps[i]['closetime'];
      rn.floorspace = maps[i]['floorspace'];
      rn.today = maps[i]['today'];
      rn.bfrday = maps[i]['bfrday'];
      rn.twodaybfr = maps[i]['twodaybfr'];
      rn.nextday = maps[i]['nextday'];
      rn.sysflg_base = maps[i]['sysflg_base'];
      rn.sysflg_sale = maps[i]['sysflg_sale'];
      rn.sysflg_purchs = maps[i]['sysflg_purchs'];
      rn.sysflg_order = maps[i]['sysflg_order'];
      rn.sysflg_invtry = maps[i]['sysflg_invtry'];
      rn.sysflg_cust = maps[i]['sysflg_cust'];
      rn.sysflg_poppy = maps[i]['sysflg_poppy'];
      rn.sysflg_elslbl = maps[i]['sysflg_elslbl'];
      rn.sysflg_fresh = maps[i]['sysflg_fresh'];
      rn.sysflg_wdslbl = maps[i]['sysflg_wdslbl'];
      rn.sysflg_24hour = maps[i]['sysflg_24hour'];
      rn.showorder = maps[i]['showorder'];
      rn.opendate = maps[i]['opendate'];
      rn.stre_ver_flg = maps[i]['stre_ver_flg'];
      rn.sunday_off_flg = maps[i]['sunday_off_flg'];
      rn.monday_off_flg = maps[i]['monday_off_flg'];
      rn.tuesday_off_flg = maps[i]['tuesday_off_flg'];
      rn.wednesday_off_flg = maps[i]['wednesday_off_flg'];
      rn.thursday_off_flg = maps[i]['thursday_off_flg'];
      rn.friday_off_flg = maps[i]['friday_off_flg'];
      rn.saturday_off_flg = maps[i]['saturday_off_flg'];
      rn.itemstock_flg = maps[i]['itemstock_flg'];
      rn.wait_time = maps[i]['wait_time'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.entry_no = maps[i]['entry_no'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CStreMstColumns rn = CStreMstColumns();
    rn.stre_cd = maps[0]['stre_cd'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.zone_cd = maps[0]['zone_cd'];
    rn.bsct_cd = maps[0]['bsct_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.kana_name = maps[0]['kana_name'];
    rn.post_no = maps[0]['post_no'];
    rn.adress1 = maps[0]['adress1'];
    rn.adress2 = maps[0]['adress2'];
    rn.adress3 = maps[0]['adress3'];
    rn.telno1 = maps[0]['telno1'];
    rn.telno2 = maps[0]['telno2'];
    rn.srch_telno1 = maps[0]['srch_telno1'];
    rn.srch_telno2 = maps[0]['srch_telno2'];
    rn.ip_addr = maps[0]['ip_addr'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.stre_typ = maps[0]['stre_typ'];
    rn.flg_shp = maps[0]['flg_shp'];
    rn.business_typ1 = maps[0]['business_typ1'];
    rn.business_typ2 = maps[0]['business_typ2'];
    rn.chain_other_flg = maps[0]['chain_other_flg'];
    rn.locate_typ = maps[0]['locate_typ'];
    rn.openclose_flg = maps[0]['openclose_flg'];
    rn.opentime = maps[0]['opentime'];
    rn.closetime = maps[0]['closetime'];
    rn.floorspace = maps[0]['floorspace'];
    rn.today = maps[0]['today'];
    rn.bfrday = maps[0]['bfrday'];
    rn.twodaybfr = maps[0]['twodaybfr'];
    rn.nextday = maps[0]['nextday'];
    rn.sysflg_base = maps[0]['sysflg_base'];
    rn.sysflg_sale = maps[0]['sysflg_sale'];
    rn.sysflg_purchs = maps[0]['sysflg_purchs'];
    rn.sysflg_order = maps[0]['sysflg_order'];
    rn.sysflg_invtry = maps[0]['sysflg_invtry'];
    rn.sysflg_cust = maps[0]['sysflg_cust'];
    rn.sysflg_poppy = maps[0]['sysflg_poppy'];
    rn.sysflg_elslbl = maps[0]['sysflg_elslbl'];
    rn.sysflg_fresh = maps[0]['sysflg_fresh'];
    rn.sysflg_wdslbl = maps[0]['sysflg_wdslbl'];
    rn.sysflg_24hour = maps[0]['sysflg_24hour'];
    rn.showorder = maps[0]['showorder'];
    rn.opendate = maps[0]['opendate'];
    rn.stre_ver_flg = maps[0]['stre_ver_flg'];
    rn.sunday_off_flg = maps[0]['sunday_off_flg'];
    rn.monday_off_flg = maps[0]['monday_off_flg'];
    rn.tuesday_off_flg = maps[0]['tuesday_off_flg'];
    rn.wednesday_off_flg = maps[0]['wednesday_off_flg'];
    rn.thursday_off_flg = maps[0]['thursday_off_flg'];
    rn.friday_off_flg = maps[0]['friday_off_flg'];
    rn.saturday_off_flg = maps[0]['saturday_off_flg'];
    rn.itemstock_flg = maps[0]['itemstock_flg'];
    rn.wait_time = maps[0]['wait_time'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.entry_no = maps[0]['entry_no'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CStreMstField.stre_cd : this.stre_cd,
      CStreMstField.comp_cd : this.comp_cd,
      CStreMstField.zone_cd : this.zone_cd,
      CStreMstField.bsct_cd : this.bsct_cd,
      CStreMstField.name : this.name,
      CStreMstField.short_name : this.short_name,
      CStreMstField.kana_name : this.kana_name,
      CStreMstField.post_no : this.post_no,
      CStreMstField.adress1 : this.adress1,
      CStreMstField.adress2 : this.adress2,
      CStreMstField.adress3 : this.adress3,
      CStreMstField.telno1 : this.telno1,
      CStreMstField.telno2 : this.telno2,
      CStreMstField.srch_telno1 : this.srch_telno1,
      CStreMstField.srch_telno2 : this.srch_telno2,
      CStreMstField.ip_addr : this.ip_addr,
      CStreMstField.trends_typ : this.trends_typ,
      CStreMstField.stre_typ : this.stre_typ,
      CStreMstField.flg_shp : this.flg_shp,
      CStreMstField.business_typ1 : this.business_typ1,
      CStreMstField.business_typ2 : this.business_typ2,
      CStreMstField.chain_other_flg : this.chain_other_flg,
      CStreMstField.locate_typ : this.locate_typ,
      CStreMstField.openclose_flg : this.openclose_flg,
      CStreMstField.opentime : this.opentime,
      CStreMstField.closetime : this.closetime,
      CStreMstField.floorspace : this.floorspace,
      CStreMstField.today : this.today,
      CStreMstField.bfrday : this.bfrday,
      CStreMstField.twodaybfr : this.twodaybfr,
      CStreMstField.nextday : this.nextday,
      CStreMstField.sysflg_base : this.sysflg_base,
      CStreMstField.sysflg_sale : this.sysflg_sale,
      CStreMstField.sysflg_purchs : this.sysflg_purchs,
      CStreMstField.sysflg_order : this.sysflg_order,
      CStreMstField.sysflg_invtry : this.sysflg_invtry,
      CStreMstField.sysflg_cust : this.sysflg_cust,
      CStreMstField.sysflg_poppy : this.sysflg_poppy,
      CStreMstField.sysflg_elslbl : this.sysflg_elslbl,
      CStreMstField.sysflg_fresh : this.sysflg_fresh,
      CStreMstField.sysflg_wdslbl : this.sysflg_wdslbl,
      CStreMstField.sysflg_24hour : this.sysflg_24hour,
      CStreMstField.showorder : this.showorder,
      CStreMstField.opendate : this.opendate,
      CStreMstField.stre_ver_flg : this.stre_ver_flg,
      CStreMstField.sunday_off_flg : this.sunday_off_flg,
      CStreMstField.monday_off_flg : this.monday_off_flg,
      CStreMstField.tuesday_off_flg : this.tuesday_off_flg,
      CStreMstField.wednesday_off_flg : this.wednesday_off_flg,
      CStreMstField.thursday_off_flg : this.thursday_off_flg,
      CStreMstField.friday_off_flg : this.friday_off_flg,
      CStreMstField.saturday_off_flg : this.saturday_off_flg,
      CStreMstField.itemstock_flg : this.itemstock_flg,
      CStreMstField.wait_time : this.wait_time,
      CStreMstField.ins_datetime : this.ins_datetime,
      CStreMstField.upd_datetime : this.upd_datetime,
      CStreMstField.status : this.status,
      CStreMstField.send_flg : this.send_flg,
      CStreMstField.upd_user : this.upd_user,
      CStreMstField.upd_system : this.upd_system,
      CStreMstField.entry_no : this.entry_no,
    };
  }
}

/// 01_2  店舗マスタ  c_stre_mstのフィールド名設定用クラス
class CStreMstField {
  static const stre_cd = "stre_cd";
  static const comp_cd = "comp_cd";
  static const zone_cd = "zone_cd";
  static const bsct_cd = "bsct_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const kana_name = "kana_name";
  static const post_no = "post_no";
  static const adress1 = "adress1";
  static const adress2 = "adress2";
  static const adress3 = "adress3";
  static const telno1 = "telno1";
  static const telno2 = "telno2";
  static const srch_telno1 = "srch_telno1";
  static const srch_telno2 = "srch_telno2";
  static const ip_addr = "ip_addr";
  static const trends_typ = "trends_typ";
  static const stre_typ = "stre_typ";
  static const flg_shp = "flg_shp";
  static const business_typ1 = "business_typ1";
  static const business_typ2 = "business_typ2";
  static const chain_other_flg = "chain_other_flg";
  static const locate_typ = "locate_typ";
  static const openclose_flg = "openclose_flg";
  static const opentime = "opentime";
  static const closetime = "closetime";
  static const floorspace = "floorspace";
  static const today = "today";
  static const bfrday = "bfrday";
  static const twodaybfr = "twodaybfr";
  static const nextday = "nextday";
  static const sysflg_base = "sysflg_base";
  static const sysflg_sale = "sysflg_sale";
  static const sysflg_purchs = "sysflg_purchs";
  static const sysflg_order = "sysflg_order";
  static const sysflg_invtry = "sysflg_invtry";
  static const sysflg_cust = "sysflg_cust";
  static const sysflg_poppy = "sysflg_poppy";
  static const sysflg_elslbl = "sysflg_elslbl";
  static const sysflg_fresh = "sysflg_fresh";
  static const sysflg_wdslbl = "sysflg_wdslbl";
  static const sysflg_24hour = "sysflg_24hour";
  static const showorder = "showorder";
  static const opendate = "opendate";
  static const stre_ver_flg = "stre_ver_flg";
  static const sunday_off_flg = "sunday_off_flg";
  static const monday_off_flg = "monday_off_flg";
  static const tuesday_off_flg = "tuesday_off_flg";
  static const wednesday_off_flg = "wednesday_off_flg";
  static const thursday_off_flg = "thursday_off_flg";
  static const friday_off_flg = "friday_off_flg";
  static const saturday_off_flg = "saturday_off_flg";
  static const itemstock_flg = "itemstock_flg";
  static const wait_time = "wait_time";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const entry_no = "entry_no";
}

//endregion
//region 01_3	店舗通信マスタ	c_connect_mst
/// 01_3  店舗通信マスタ  c_connect_mstクラス
class CConnectMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? connect_cd;
  int connect_typ = 0;
  String? name;
  String? short_name;
  String? kana_name;
  String? host_name;
  String? opentime;
  String? closetime;
  int format_typ = 0;
  int network_typ = 0;
  String? telno1;
  String? telno2;
  String? srch_telno1;
  String? srch_telno2;
  String? ip_addr;
  int retry_cnt = 0;
  int retry_time = 0;
  int time_out = 0;
  String? ftp_put_dir;
  String? ftp_get_dir;
  int connect_time1 = 0;
  int connect_time2 = 0;
  String? cnt_usr;
  String? cnt_pwd;
  int wait_time1 = 0;
  int wait_time2 = 0;
  int cnt_interval1 = 0;
  int cnt_interval2 = 0;
  int stre_chk_dgt = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_connect_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND connect_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(connect_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CConnectMstColumns rn = CConnectMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.connect_cd = maps[i]['connect_cd'];
      rn.connect_typ = maps[i]['connect_typ'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.kana_name = maps[i]['kana_name'];
      rn.host_name = maps[i]['host_name'];
      rn.opentime = maps[i]['opentime'];
      rn.closetime = maps[i]['closetime'];
      rn.format_typ = maps[i]['format_typ'];
      rn.network_typ = maps[i]['network_typ'];
      rn.telno1 = maps[i]['telno1'];
      rn.telno2 = maps[i]['telno2'];
      rn.srch_telno1 = maps[i]['srch_telno1'];
      rn.srch_telno2 = maps[i]['srch_telno2'];
      rn.ip_addr = maps[i]['ip_addr'];
      rn.retry_cnt = maps[i]['retry_cnt'];
      rn.retry_time = maps[i]['retry_time'];
      rn.time_out = maps[i]['time_out'];
      rn.ftp_put_dir = maps[i]['ftp_put_dir'];
      rn.ftp_get_dir = maps[i]['ftp_get_dir'];
      rn.connect_time1 = maps[i]['connect_time1'];
      rn.connect_time2 = maps[i]['connect_time2'];
      rn.cnt_usr = maps[i]['cnt_usr'];
      rn.cnt_pwd = maps[i]['cnt_pwd'];
      rn.wait_time1 = maps[i]['wait_time1'];
      rn.wait_time2 = maps[i]['wait_time2'];
      rn.cnt_interval1 = maps[i]['cnt_interval1'];
      rn.cnt_interval2 = maps[i]['cnt_interval2'];
      rn.stre_chk_dgt = maps[i]['stre_chk_dgt'];
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
    CConnectMstColumns rn = CConnectMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.connect_cd = maps[0]['connect_cd'];
    rn.connect_typ = maps[0]['connect_typ'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.kana_name = maps[0]['kana_name'];
    rn.host_name = maps[0]['host_name'];
    rn.opentime = maps[0]['opentime'];
    rn.closetime = maps[0]['closetime'];
    rn.format_typ = maps[0]['format_typ'];
    rn.network_typ = maps[0]['network_typ'];
    rn.telno1 = maps[0]['telno1'];
    rn.telno2 = maps[0]['telno2'];
    rn.srch_telno1 = maps[0]['srch_telno1'];
    rn.srch_telno2 = maps[0]['srch_telno2'];
    rn.ip_addr = maps[0]['ip_addr'];
    rn.retry_cnt = maps[0]['retry_cnt'];
    rn.retry_time = maps[0]['retry_time'];
    rn.time_out = maps[0]['time_out'];
    rn.ftp_put_dir = maps[0]['ftp_put_dir'];
    rn.ftp_get_dir = maps[0]['ftp_get_dir'];
    rn.connect_time1 = maps[0]['connect_time1'];
    rn.connect_time2 = maps[0]['connect_time2'];
    rn.cnt_usr = maps[0]['cnt_usr'];
    rn.cnt_pwd = maps[0]['cnt_pwd'];
    rn.wait_time1 = maps[0]['wait_time1'];
    rn.wait_time2 = maps[0]['wait_time2'];
    rn.cnt_interval1 = maps[0]['cnt_interval1'];
    rn.cnt_interval2 = maps[0]['cnt_interval2'];
    rn.stre_chk_dgt = maps[0]['stre_chk_dgt'];
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
      CConnectMstField.comp_cd : this.comp_cd,
      CConnectMstField.stre_cd : this.stre_cd,
      CConnectMstField.connect_cd : this.connect_cd,
      CConnectMstField.connect_typ : this.connect_typ,
      CConnectMstField.name : this.name,
      CConnectMstField.short_name : this.short_name,
      CConnectMstField.kana_name : this.kana_name,
      CConnectMstField.host_name : this.host_name,
      CConnectMstField.opentime : this.opentime,
      CConnectMstField.closetime : this.closetime,
      CConnectMstField.format_typ : this.format_typ,
      CConnectMstField.network_typ : this.network_typ,
      CConnectMstField.telno1 : this.telno1,
      CConnectMstField.telno2 : this.telno2,
      CConnectMstField.srch_telno1 : this.srch_telno1,
      CConnectMstField.srch_telno2 : this.srch_telno2,
      CConnectMstField.ip_addr : this.ip_addr,
      CConnectMstField.retry_cnt : this.retry_cnt,
      CConnectMstField.retry_time : this.retry_time,
      CConnectMstField.time_out : this.time_out,
      CConnectMstField.ftp_put_dir : this.ftp_put_dir,
      CConnectMstField.ftp_get_dir : this.ftp_get_dir,
      CConnectMstField.connect_time1 : this.connect_time1,
      CConnectMstField.connect_time2 : this.connect_time2,
      CConnectMstField.cnt_usr : this.cnt_usr,
      CConnectMstField.cnt_pwd : this.cnt_pwd,
      CConnectMstField.wait_time1 : this.wait_time1,
      CConnectMstField.wait_time2 : this.wait_time2,
      CConnectMstField.cnt_interval1 : this.cnt_interval1,
      CConnectMstField.cnt_interval2 : this.cnt_interval2,
      CConnectMstField.stre_chk_dgt : this.stre_chk_dgt,
      CConnectMstField.ins_datetime : this.ins_datetime,
      CConnectMstField.upd_datetime : this.upd_datetime,
      CConnectMstField.status : this.status,
      CConnectMstField.send_flg : this.send_flg,
      CConnectMstField.upd_user : this.upd_user,
      CConnectMstField.upd_system : this.upd_system,
    };
  }
}

/// 01_3  店舗通信マスタ  c_connect_mstのフィールド名設定用クラス
class CConnectMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const connect_cd = "connect_cd";
  static const connect_typ = "connect_typ";
  static const name = "name";
  static const short_name = "short_name";
  static const kana_name = "kana_name";
  static const host_name = "host_name";
  static const opentime = "opentime";
  static const closetime = "closetime";
  static const format_typ = "format_typ";
  static const network_typ = "network_typ";
  static const telno1 = "telno1";
  static const telno2 = "telno2";
  static const srch_telno1 = "srch_telno1";
  static const srch_telno2 = "srch_telno2";
  static const ip_addr = "ip_addr";
  static const retry_cnt = "retry_cnt";
  static const retry_time = "retry_time";
  static const time_out = "time_out";
  static const ftp_put_dir = "ftp_put_dir";
  static const ftp_get_dir = "ftp_get_dir";
  static const connect_time1 = "connect_time1";
  static const connect_time2 = "connect_time2";
  static const cnt_usr = "cnt_usr";
  static const cnt_pwd = "cnt_pwd";
  static const wait_time1 = "wait_time1";
  static const wait_time2 = "wait_time2";
  static const cnt_interval1 = "cnt_interval1";
  static const cnt_interval2 = "cnt_interval2";
  static const stre_chk_dgt = "stre_chk_dgt";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 01_4	分類マスタ	c_cls_mst
/// 01_4  分類マスタ  c_cls_mstクラス
class CClsMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? cls_typ;
  int? lrgcls_cd;
  int? mdlcls_cd;
  int? smlcls_cd;
  int? tnycls_cd;
  String? plu_cd;
  int cls_flg = 0;
  int tax_cd1 = 0;
  int tax_cd2 = 0;
  int tax_cd3 = 0;
  int tax_cd4 = 0;
  String? name;
  String? short_name;
  String? kana_name;
  int margin_flg = 0;
  int regsale_flg = 0;
  int clothdeal_flg = 0;
  int dfltcls_cd = 0;
  String? msg_name;
  String? pop_msg;
  int nonact_flg = 0;
  int max_prc = 0;
  int min_prc = 0;
  double? cost_per = 0;
  double? loss_per = 0;
  double? rbtpremium_per = 1;
  int prc_chg_flg = 0;
  int rbttarget_flg = 0;
  int stl_dsc_flg = 0;
  int labeldept_cd = 0;
  int multprc_flg = 0;
  double? multprc_per = 0;
  int sch_flg = 0;
  int stlplus_flg = 0;
  int pctr_tckt_flg = 0;
  int clothing_flg = 0;
  int spclsdsc_flg = 0;
  int bdl_dsc_flg = 0;
  int self_alert_flg = 0;
  int chg_ckt_flg = 0;
  int self_weight_flg = 0;
  int msg_flg = 0;
  int pop_msg_flg = 0;
  int itemstock_flg = 0;
  int orderpatrn_flg = 0;
  int orderbook_flg = 0;
  double? safestock_per = 0;
  int autoorder_typ = 0;
  int casecntup_typ = 0;
  int producer_cd = 0;
  int cust_dtl_flg = 0;
  int coupon_flg = 0;
  int kitchen_prn_flg = 0;
  int pricing_flg = 0;
  int user_val_1 = 0;
  int user_val_2 = 0;
  int user_val_3 = 0;
  int user_val_4 = 0;
  int user_val_5 = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int tax_exemption_flg = 0;
  int dpnt_rbttarget_flg = 0;
  int dpnt_usetarget_flg = 0;

  @override
  String _getTableName() => "c_cls_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND cls_typ = ? AND lrgcls_cd = ? AND mdlcls_cd = ? AND smlcls_cd = ? AND tnycls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(cls_typ);
    rn.add(lrgcls_cd);
    rn.add(mdlcls_cd);
    rn.add(smlcls_cd);
    rn.add(tnycls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CClsMstColumns rn = CClsMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.cls_typ = maps[i]['cls_typ'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.tnycls_cd = maps[i]['tnycls_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.cls_flg = maps[i]['cls_flg'];
      rn.tax_cd1 = maps[i]['tax_cd1'];
      rn.tax_cd2 = maps[i]['tax_cd2'];
      rn.tax_cd3 = maps[i]['tax_cd3'];
      rn.tax_cd4 = maps[i]['tax_cd4'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.kana_name = maps[i]['kana_name'];
      rn.margin_flg = maps[i]['margin_flg'];
      rn.regsale_flg = maps[i]['regsale_flg'];
      rn.clothdeal_flg = maps[i]['clothdeal_flg'];
      rn.dfltcls_cd = maps[i]['dfltcls_cd'];
      rn.msg_name = maps[i]['msg_name'];
      rn.pop_msg = maps[i]['pop_msg'];
      rn.nonact_flg = maps[i]['nonact_flg'];
      rn.max_prc = maps[i]['max_prc'];
      rn.min_prc = maps[i]['min_prc'];
      rn.cost_per = maps[i]['cost_per'];
      rn.loss_per = maps[i]['loss_per'];
      rn.rbtpremium_per = maps[i]['rbtpremium_per'];
      rn.prc_chg_flg = maps[i]['prc_chg_flg'];
      rn.rbttarget_flg = maps[i]['rbttarget_flg'];
      rn.stl_dsc_flg = maps[i]['stl_dsc_flg'];
      rn.labeldept_cd = maps[i]['labeldept_cd'];
      rn.multprc_flg = maps[i]['multprc_flg'];
      rn.multprc_per = maps[i]['multprc_per'];
      rn.sch_flg = maps[i]['sch_flg'];
      rn.stlplus_flg = maps[i]['stlplus_flg'];
      rn.pctr_tckt_flg = maps[i]['pctr_tckt_flg'];
      rn.clothing_flg = maps[i]['clothing_flg'];
      rn.spclsdsc_flg = maps[i]['spclsdsc_flg'];
      rn.bdl_dsc_flg = maps[i]['bdl_dsc_flg'];
      rn.self_alert_flg = maps[i]['self_alert_flg'];
      rn.chg_ckt_flg = maps[i]['chg_ckt_flg'];
      rn.self_weight_flg = maps[i]['self_weight_flg'];
      rn.msg_flg = maps[i]['msg_flg'];
      rn.pop_msg_flg = maps[i]['pop_msg_flg'];
      rn.itemstock_flg = maps[i]['itemstock_flg'];
      rn.orderpatrn_flg = maps[i]['orderpatrn_flg'];
      rn.orderbook_flg = maps[i]['orderbook_flg'];
      rn.safestock_per = maps[i]['safestock_per'];
      rn.autoorder_typ = maps[i]['autoorder_typ'];
      rn.casecntup_typ = maps[i]['casecntup_typ'];
      rn.producer_cd = maps[i]['producer_cd'];
      rn.cust_dtl_flg = maps[i]['cust_dtl_flg'];
      rn.coupon_flg = maps[i]['coupon_flg'];
      rn.kitchen_prn_flg = maps[i]['kitchen_prn_flg'];
      rn.pricing_flg = maps[i]['pricing_flg'];
      rn.user_val_1 = maps[i]['user_val_1'];
      rn.user_val_2 = maps[i]['user_val_2'];
      rn.user_val_3 = maps[i]['user_val_3'];
      rn.user_val_4 = maps[i]['user_val_4'];
      rn.user_val_5 = maps[i]['user_val_5'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.tax_exemption_flg = maps[i]['tax_exemption_flg'];
      rn.dpnt_rbttarget_flg = maps[i]['dpnt_rbttarget_flg'];
      rn.dpnt_usetarget_flg = maps[i]['dpnt_usetarget_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CClsMstColumns rn = CClsMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.cls_typ = maps[0]['cls_typ'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.tnycls_cd = maps[0]['tnycls_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.cls_flg = maps[0]['cls_flg'];
    rn.tax_cd1 = maps[0]['tax_cd1'];
    rn.tax_cd2 = maps[0]['tax_cd2'];
    rn.tax_cd3 = maps[0]['tax_cd3'];
    rn.tax_cd4 = maps[0]['tax_cd4'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.kana_name = maps[0]['kana_name'];
    rn.margin_flg = maps[0]['margin_flg'];
    rn.regsale_flg = maps[0]['regsale_flg'];
    rn.clothdeal_flg = maps[0]['clothdeal_flg'];
    rn.dfltcls_cd = maps[0]['dfltcls_cd'];
    rn.msg_name = maps[0]['msg_name'];
    rn.pop_msg = maps[0]['pop_msg'];
    rn.nonact_flg = maps[0]['nonact_flg'];
    rn.max_prc = maps[0]['max_prc'];
    rn.min_prc = maps[0]['min_prc'];
    rn.cost_per = maps[0]['cost_per'];
    rn.loss_per = maps[0]['loss_per'];
    rn.rbtpremium_per = maps[0]['rbtpremium_per'];
    rn.prc_chg_flg = maps[0]['prc_chg_flg'];
    rn.rbttarget_flg = maps[0]['rbttarget_flg'];
    rn.stl_dsc_flg = maps[0]['stl_dsc_flg'];
    rn.labeldept_cd = maps[0]['labeldept_cd'];
    rn.multprc_flg = maps[0]['multprc_flg'];
    rn.multprc_per = maps[0]['multprc_per'];
    rn.sch_flg = maps[0]['sch_flg'];
    rn.stlplus_flg = maps[0]['stlplus_flg'];
    rn.pctr_tckt_flg = maps[0]['pctr_tckt_flg'];
    rn.clothing_flg = maps[0]['clothing_flg'];
    rn.spclsdsc_flg = maps[0]['spclsdsc_flg'];
    rn.bdl_dsc_flg = maps[0]['bdl_dsc_flg'];
    rn.self_alert_flg = maps[0]['self_alert_flg'];
    rn.chg_ckt_flg = maps[0]['chg_ckt_flg'];
    rn.self_weight_flg = maps[0]['self_weight_flg'];
    rn.msg_flg = maps[0]['msg_flg'];
    rn.pop_msg_flg = maps[0]['pop_msg_flg'];
    rn.itemstock_flg = maps[0]['itemstock_flg'];
    rn.orderpatrn_flg = maps[0]['orderpatrn_flg'];
    rn.orderbook_flg = maps[0]['orderbook_flg'];
    rn.safestock_per = maps[0]['safestock_per'];
    rn.autoorder_typ = maps[0]['autoorder_typ'];
    rn.casecntup_typ = maps[0]['casecntup_typ'];
    rn.producer_cd = maps[0]['producer_cd'];
    rn.cust_dtl_flg = maps[0]['cust_dtl_flg'];
    rn.coupon_flg = maps[0]['coupon_flg'];
    rn.kitchen_prn_flg = maps[0]['kitchen_prn_flg'];
    rn.pricing_flg = maps[0]['pricing_flg'];
    rn.user_val_1 = maps[0]['user_val_1'];
    rn.user_val_2 = maps[0]['user_val_2'];
    rn.user_val_3 = maps[0]['user_val_3'];
    rn.user_val_4 = maps[0]['user_val_4'];
    rn.user_val_5 = maps[0]['user_val_5'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.tax_exemption_flg = maps[0]['tax_exemption_flg'];
    rn.dpnt_rbttarget_flg = maps[0]['dpnt_rbttarget_flg'];
    rn.dpnt_usetarget_flg = maps[0]['dpnt_usetarget_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CClsMstField.comp_cd : this.comp_cd,
      CClsMstField.stre_cd : this.stre_cd,
      CClsMstField.cls_typ : this.cls_typ,
      CClsMstField.lrgcls_cd : this.lrgcls_cd,
      CClsMstField.mdlcls_cd : this.mdlcls_cd,
      CClsMstField.smlcls_cd : this.smlcls_cd,
      CClsMstField.tnycls_cd : this.tnycls_cd,
      CClsMstField.plu_cd : this.plu_cd,
      CClsMstField.cls_flg : this.cls_flg,
      CClsMstField.tax_cd1 : this.tax_cd1,
      CClsMstField.tax_cd2 : this.tax_cd2,
      CClsMstField.tax_cd3 : this.tax_cd3,
      CClsMstField.tax_cd4 : this.tax_cd4,
      CClsMstField.name : this.name,
      CClsMstField.short_name : this.short_name,
      CClsMstField.kana_name : this.kana_name,
      CClsMstField.margin_flg : this.margin_flg,
      CClsMstField.regsale_flg : this.regsale_flg,
      CClsMstField.clothdeal_flg : this.clothdeal_flg,
      CClsMstField.dfltcls_cd : this.dfltcls_cd,
      CClsMstField.msg_name : this.msg_name,
      CClsMstField.pop_msg : this.pop_msg,
      CClsMstField.nonact_flg : this.nonact_flg,
      CClsMstField.max_prc : this.max_prc,
      CClsMstField.min_prc : this.min_prc,
      CClsMstField.cost_per : this.cost_per,
      CClsMstField.loss_per : this.loss_per,
      CClsMstField.rbtpremium_per : this.rbtpremium_per,
      CClsMstField.prc_chg_flg : this.prc_chg_flg,
      CClsMstField.rbttarget_flg : this.rbttarget_flg,
      CClsMstField.stl_dsc_flg : this.stl_dsc_flg,
      CClsMstField.labeldept_cd : this.labeldept_cd,
      CClsMstField.multprc_flg : this.multprc_flg,
      CClsMstField.multprc_per : this.multprc_per,
      CClsMstField.sch_flg : this.sch_flg,
      CClsMstField.stlplus_flg : this.stlplus_flg,
      CClsMstField.pctr_tckt_flg : this.pctr_tckt_flg,
      CClsMstField.clothing_flg : this.clothing_flg,
      CClsMstField.spclsdsc_flg : this.spclsdsc_flg,
      CClsMstField.bdl_dsc_flg : this.bdl_dsc_flg,
      CClsMstField.self_alert_flg : this.self_alert_flg,
      CClsMstField.chg_ckt_flg : this.chg_ckt_flg,
      CClsMstField.self_weight_flg : this.self_weight_flg,
      CClsMstField.msg_flg : this.msg_flg,
      CClsMstField.pop_msg_flg : this.pop_msg_flg,
      CClsMstField.itemstock_flg : this.itemstock_flg,
      CClsMstField.orderpatrn_flg : this.orderpatrn_flg,
      CClsMstField.orderbook_flg : this.orderbook_flg,
      CClsMstField.safestock_per : this.safestock_per,
      CClsMstField.autoorder_typ : this.autoorder_typ,
      CClsMstField.casecntup_typ : this.casecntup_typ,
      CClsMstField.producer_cd : this.producer_cd,
      CClsMstField.cust_dtl_flg : this.cust_dtl_flg,
      CClsMstField.coupon_flg : this.coupon_flg,
      CClsMstField.kitchen_prn_flg : this.kitchen_prn_flg,
      CClsMstField.pricing_flg : this.pricing_flg,
      CClsMstField.user_val_1 : this.user_val_1,
      CClsMstField.user_val_2 : this.user_val_2,
      CClsMstField.user_val_3 : this.user_val_3,
      CClsMstField.user_val_4 : this.user_val_4,
      CClsMstField.user_val_5 : this.user_val_5,
      CClsMstField.ins_datetime : this.ins_datetime,
      CClsMstField.upd_datetime : this.upd_datetime,
      CClsMstField.status : this.status,
      CClsMstField.send_flg : this.send_flg,
      CClsMstField.upd_user : this.upd_user,
      CClsMstField.upd_system : this.upd_system,
      CClsMstField.tax_exemption_flg : this.tax_exemption_flg,
      CClsMstField.dpnt_rbttarget_flg : this.dpnt_rbttarget_flg,
      CClsMstField.dpnt_usetarget_flg : this.dpnt_usetarget_flg,
    };
  }
}

/// 01_4  分類マスタ  c_cls_mstのフィールド名設定用クラス
class CClsMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const cls_typ = "cls_typ";
  static const lrgcls_cd = "lrgcls_cd";
  static const mdlcls_cd = "mdlcls_cd";
  static const smlcls_cd = "smlcls_cd";
  static const tnycls_cd = "tnycls_cd";
  static const plu_cd = "plu_cd";
  static const cls_flg = "cls_flg";
  static const tax_cd1 = "tax_cd1";
  static const tax_cd2 = "tax_cd2";
  static const tax_cd3 = "tax_cd3";
  static const tax_cd4 = "tax_cd4";
  static const name = "name";
  static const short_name = "short_name";
  static const kana_name = "kana_name";
  static const margin_flg = "margin_flg";
  static const regsale_flg = "regsale_flg";
  static const clothdeal_flg = "clothdeal_flg";
  static const dfltcls_cd = "dfltcls_cd";
  static const msg_name = "msg_name";
  static const pop_msg = "pop_msg";
  static const nonact_flg = "nonact_flg";
  static const max_prc = "max_prc";
  static const min_prc = "min_prc";
  static const cost_per = "cost_per";
  static const loss_per = "loss_per";
  static const rbtpremium_per = "rbtpremium_per";
  static const prc_chg_flg = "prc_chg_flg";
  static const rbttarget_flg = "rbttarget_flg";
  static const stl_dsc_flg = "stl_dsc_flg";
  static const labeldept_cd = "labeldept_cd";
  static const multprc_flg = "multprc_flg";
  static const multprc_per = "multprc_per";
  static const sch_flg = "sch_flg";
  static const stlplus_flg = "stlplus_flg";
  static const pctr_tckt_flg = "pctr_tckt_flg";
  static const clothing_flg = "clothing_flg";
  static const spclsdsc_flg = "spclsdsc_flg";
  static const bdl_dsc_flg = "bdl_dsc_flg";
  static const self_alert_flg = "self_alert_flg";
  static const chg_ckt_flg = "chg_ckt_flg";
  static const self_weight_flg = "self_weight_flg";
  static const msg_flg = "msg_flg";
  static const pop_msg_flg = "pop_msg_flg";
  static const itemstock_flg = "itemstock_flg";
  static const orderpatrn_flg = "orderpatrn_flg";
  static const orderbook_flg = "orderbook_flg";
  static const safestock_per = "safestock_per";
  static const autoorder_typ = "autoorder_typ";
  static const casecntup_typ = "casecntup_typ";
  static const producer_cd = "producer_cd";
  static const cust_dtl_flg = "cust_dtl_flg";
  static const coupon_flg = "coupon_flg";
  static const kitchen_prn_flg = "kitchen_prn_flg";
  static const pricing_flg = "pricing_flg";
  static const user_val_1 = "user_val_1";
  static const user_val_2 = "user_val_2";
  static const user_val_3 = "user_val_3";
  static const user_val_4 = "user_val_4";
  static const user_val_5 = "user_val_5";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const tax_exemption_flg = "tax_exemption_flg";
  static const dpnt_rbttarget_flg = "dpnt_rbttarget_flg";
  static const dpnt_usetarget_flg = "dpnt_usetarget_flg";
}
//endregion
//region 01_5	分類グループマスタ	c_grp_mst
/// 01_5  分類グループマスタ  c_grp_mstクラス
class CGrpMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? cls_grp_cd;
  int? mdl_smlcls_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_grp_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND cls_grp_cd = ? AND mdl_smlcls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(cls_grp_cd);
    rn.add(mdl_smlcls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CGrpMstColumns rn = CGrpMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.cls_grp_cd = maps[i]['cls_grp_cd'];
      rn.mdl_smlcls_cd = maps[i]['mdl_smlcls_cd'];
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
    CGrpMstColumns rn = CGrpMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.cls_grp_cd = maps[0]['cls_grp_cd'];
    rn.mdl_smlcls_cd = maps[0]['mdl_smlcls_cd'];
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
      CGrpMstField.comp_cd : this.comp_cd,
      CGrpMstField.stre_cd : this.stre_cd,
      CGrpMstField.cls_grp_cd : this.cls_grp_cd,
      CGrpMstField.mdl_smlcls_cd : this.mdl_smlcls_cd,
      CGrpMstField.ins_datetime : this.ins_datetime,
      CGrpMstField.upd_datetime : this.upd_datetime,
      CGrpMstField.status : this.status,
      CGrpMstField.send_flg : this.send_flg,
      CGrpMstField.upd_user : this.upd_user,
      CGrpMstField.upd_system : this.upd_system,
    };
  }
}

/// 01_5  分類グループマスタ  c_grp_mstのフィールド名設定用クラス
class CGrpMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const cls_grp_cd = "cls_grp_cd";
  static const mdl_smlcls_cd = "mdl_smlcls_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 01_6	郵便番号マスタ	c_zipcode_mst
/// 01_6  郵便番号マスタ  c_zipcode_mstクラス
class CZipcodeMstColumns extends TableColumns{
  int? serial_no;
  String? post_no;
  String? address1;
  String? address2;
  String? address3;
  String? kana_address1;
  String? kana_address2;
  String? kana_address3;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_zipcode_mst";

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
      CZipcodeMstColumns rn = CZipcodeMstColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.post_no = maps[i]['post_no'];
      rn.address1 = maps[i]['address1'];
      rn.address2 = maps[i]['address2'];
      rn.address3 = maps[i]['address3'];
      rn.kana_address1 = maps[i]['kana_address1'];
      rn.kana_address2 = maps[i]['kana_address2'];
      rn.kana_address3 = maps[i]['kana_address3'];
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
    CZipcodeMstColumns rn = CZipcodeMstColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.post_no = maps[0]['post_no'];
    rn.address1 = maps[0]['address1'];
    rn.address2 = maps[0]['address2'];
    rn.address3 = maps[0]['address3'];
    rn.kana_address1 = maps[0]['kana_address1'];
    rn.kana_address2 = maps[0]['kana_address2'];
    rn.kana_address3 = maps[0]['kana_address3'];
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
      CZipcodeMstField.serial_no : this.serial_no,
      CZipcodeMstField.post_no : this.post_no,
      CZipcodeMstField.address1 : this.address1,
      CZipcodeMstField.address2 : this.address2,
      CZipcodeMstField.address3 : this.address3,
      CZipcodeMstField.kana_address1 : this.kana_address1,
      CZipcodeMstField.kana_address2 : this.kana_address2,
      CZipcodeMstField.kana_address3 : this.kana_address3,
      CZipcodeMstField.ins_datetime : this.ins_datetime,
      CZipcodeMstField.upd_datetime : this.upd_datetime,
      CZipcodeMstField.status : this.status,
      CZipcodeMstField.send_flg : this.send_flg,
      CZipcodeMstField.upd_user : this.upd_user,
      CZipcodeMstField.upd_system : this.upd_system,
    };
  }
}

/// 01_6  郵便番号マスタ  c_zipcode_mstのフィールド名設定用クラス
class CZipcodeMstField {
  static const serial_no = "serial_no";
  static const post_no = "post_no";
  static const address1 = "address1";
  static const address2 = "address2";
  static const address3 = "address3";
  static const kana_address1 = "kana_address1";
  static const kana_address2 = "kana_address2";
  static const kana_address3 = "kana_address3";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 01_7	税金テーブルマスタ	c_tax_mst
/// 税金テーブルマスタクラス
class CTaxMstColumns extends TableColumns {
  int? comp_cd;
  int? tax_cd;
  String? tax_name;
  int tax_typ = 0;
  int odd_flg = 0;
  double? tax_per = 0;
  int mov_cd = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => 'c_tax_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND tax_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(tax_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CTaxMstColumns rn = CTaxMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.tax_cd = maps[i]['tax_cd'];
      rn.tax_name = maps[i]['tax_name'];
      rn.tax_typ = maps[i]['tax_typ'];
      rn.odd_flg = maps[i]['odd_flg'];
      rn.tax_per = maps[i]['tax_per'];
      rn.mov_cd = maps[i]['mov_cd'];
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
    CTaxMstColumns rn = CTaxMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.tax_cd = maps[0]['tax_cd'];
    rn.tax_name = maps[0]['tax_name'];
    rn.tax_typ = maps[0]['tax_typ'];
    rn.odd_flg = maps[0]['odd_flg'];
    rn.tax_per = maps[0]['tax_per'];
    rn.mov_cd = maps[0]['mov_cd'];
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
      CTaxMstField.comp_cd: comp_cd,
      CTaxMstField.tax_cd: tax_cd,
      CTaxMstField.tax_name: tax_name,
      CTaxMstField.tax_typ: tax_typ,
      CTaxMstField.odd_flg: odd_flg,
      CTaxMstField.tax_per: tax_per,
      CTaxMstField.mov_cd: mov_cd,
      CTaxMstField.ins_datetime: ins_datetime,
      CTaxMstField.upd_datetime: upd_datetime,
      CTaxMstField.status: status,
      CTaxMstField.send_flg: send_flg,
      CTaxMstField.upd_user: upd_user,
      CTaxMstField.upd_system: upd_system,
    };
  }
}

/// 税金テーブルマスタのフィールド名設定用クラス
class CTaxMstField {
  static const comp_cd = 'comp_cd';
  static const tax_cd = 'tax_cd';
  static const tax_name = 'tax_name';
  static const tax_typ = 'tax_typ';
  static const odd_flg = 'odd_flg';
  static const tax_per = 'tax_per';
  static const mov_cd = 'mov_cd';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
}
//endregion
//region 01_8	カレンダーマスタ	c_caldr_mst
/// 01_8  カレンダーマスタ c_caldr_mstクラス
class CCaldrMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  String? caldr_date;
  int dayoff_flg = 0;
  String? comment1;
  String? comment2;
  int am_weather = 0;
  int pm_weather = 0;
  double? min_temp = 0;
  double? max_temp = 0;
  int close_flg = 0;
  int open_rslt = 0;
  int close_rslt = 0;
  int rsrv_cust = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? rsrv_cust_ai;

  @override
  String _getTableName() => "c_caldr_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND caldr_date = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(caldr_date);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCaldrMstColumns rn = CCaldrMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.caldr_date = maps[i]['caldr_date'];
      rn.dayoff_flg = maps[i]['dayoff_flg'];
      rn.comment1 = maps[i]['comment1'];
      rn.comment2 = maps[i]['comment2'];
      rn.am_weather = maps[i]['am_weather'];
      rn.pm_weather = maps[i]['pm_weather'];
      rn.min_temp = maps[i]['min_temp'];
      rn.max_temp = maps[i]['max_temp'];
      rn.close_flg = maps[i]['close_flg'];
      rn.open_rslt = maps[i]['open_rslt'];
      rn.close_rslt = maps[i]['close_rslt'];
      rn.rsrv_cust = maps[i]['rsrv_cust'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.rsrv_cust_ai = maps[i]['rsrv_cust_ai'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CCaldrMstColumns rn = CCaldrMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.caldr_date = maps[0]['caldr_date'];
    rn.dayoff_flg = maps[0]['dayoff_flg'];
    rn.comment1 = maps[0]['comment1'];
    rn.comment2 = maps[0]['comment2'];
    rn.am_weather = maps[0]['am_weather'];
    rn.pm_weather = maps[0]['pm_weather'];
    rn.min_temp = maps[0]['min_temp'];
    rn.max_temp = maps[0]['max_temp'];
    rn.close_flg = maps[0]['close_flg'];
    rn.open_rslt = maps[0]['open_rslt'];
    rn.close_rslt = maps[0]['close_rslt'];
    rn.rsrv_cust = maps[0]['rsrv_cust'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.rsrv_cust_ai = maps[0]['rsrv_cust_ai'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CCaldrMstField.comp_cd : this.comp_cd,
      CCaldrMstField.stre_cd : this.stre_cd,
      CCaldrMstField.caldr_date : this.caldr_date,
      CCaldrMstField.dayoff_flg : this.dayoff_flg,
      CCaldrMstField.comment1 : this.comment1,
      CCaldrMstField.comment2 : this.comment2,
      CCaldrMstField.am_weather : this.am_weather,
      CCaldrMstField.pm_weather : this.pm_weather,
      CCaldrMstField.min_temp : this.min_temp,
      CCaldrMstField.max_temp : this.max_temp,
      CCaldrMstField.close_flg : this.close_flg,
      CCaldrMstField.open_rslt : this.open_rslt,
      CCaldrMstField.close_rslt : this.close_rslt,
      CCaldrMstField.rsrv_cust : this.rsrv_cust,
      CCaldrMstField.ins_datetime : this.ins_datetime,
      CCaldrMstField.upd_datetime : this.upd_datetime,
      CCaldrMstField.status : this.status,
      CCaldrMstField.send_flg : this.send_flg,
      CCaldrMstField.upd_user : this.upd_user,
      CCaldrMstField.upd_system : this.upd_system,
      CCaldrMstField.rsrv_cust_ai : this.rsrv_cust_ai,
    };
  }
}

/// 01_8  カレンダーマスタ c_caldr_mstのフィールド名設定用クラス
class CCaldrMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const caldr_date = "caldr_date";
  static const dayoff_flg = "dayoff_flg";
  static const comment1 = "comment1";
  static const comment2 = "comment2";
  static const am_weather = "am_weather";
  static const pm_weather = "pm_weather";
  static const min_temp = "min_temp";
  static const max_temp = "max_temp";
  static const close_flg = "close_flg";
  static const open_rslt = "open_rslt";
  static const close_rslt = "close_rslt";
  static const rsrv_cust = "rsrv_cust";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const rsrv_cust_ai = "rsrv_cust_ai";
}
//endregion
//region 01_9	祝日マスタ	s_nathldy_mst
/// 01_9  祝日マスタ  s_nathldy_mstクラス
class SNathldyMstColumns extends TableColumns{
  String? caldr_date;
  String? comment1;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "s_nathldy_mst";

  @override
  String? _getKeyCondition() => 'caldr_date = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(caldr_date);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SNathldyMstColumns rn = SNathldyMstColumns();
      rn.caldr_date = maps[i]['caldr_date'];
      rn.comment1 = maps[i]['comment1'];
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
    SNathldyMstColumns rn = SNathldyMstColumns();
    rn.caldr_date = maps[0]['caldr_date'];
    rn.comment1 = maps[0]['comment1'];
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
      SNathldyMstField.caldr_date : this.caldr_date,
      SNathldyMstField.comment1 : this.comment1,
      SNathldyMstField.ins_datetime : this.ins_datetime,
      SNathldyMstField.upd_datetime : this.upd_datetime,
      SNathldyMstField.status : this.status,
      SNathldyMstField.send_flg : this.send_flg,
      SNathldyMstField.upd_user : this.upd_user,
      SNathldyMstField.upd_system : this.upd_system,
    };
  }
}

/// 01_9  祝日マスタ  s_nathldy_mstのフィールド名設定用クラス
class SNathldyMstField {
  static const caldr_date = "caldr_date";
  static const comment1 = "comment1";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 01_10	サブ1分類マスタ	c_sub1_cls_mst
/// 01_10 サブ1分類マスタ c_sub1_cls_mstクラス
class CSub1ClsMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? cls_typ;
  int? sub1_lrg_cd;
  int? sub1_mdl_cd;
  int? sub1_sml_cd;
  String? name;
  String? short_name;
  String? kana_name;
  int rbttarget_flg = 0;
  int stl_dsc_flg = 0;
  int stlplus_flg = 0;
  int pctr_tckt_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  double? rbtpremium_per = 1;

  @override
  String _getTableName() => "c_sub1_cls_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND cls_typ = ? AND sub1_lrg_cd = ? AND sub1_mdl_cd = ? AND sub1_sml_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(cls_typ);
    rn.add(sub1_lrg_cd);
    rn.add(sub1_mdl_cd);
    rn.add(sub1_sml_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CSub1ClsMstColumns rn = CSub1ClsMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.cls_typ = maps[i]['cls_typ'];
      rn.sub1_lrg_cd = maps[i]['sub1_lrg_cd'];
      rn.sub1_mdl_cd = maps[i]['sub1_mdl_cd'];
      rn.sub1_sml_cd = maps[i]['sub1_sml_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.kana_name = maps[i]['kana_name'];
      rn.rbttarget_flg = maps[i]['rbttarget_flg'];
      rn.stl_dsc_flg = maps[i]['stl_dsc_flg'];
      rn.stlplus_flg = maps[i]['stlplus_flg'];
      rn.pctr_tckt_flg = maps[i]['pctr_tckt_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.rbtpremium_per = maps[i]['rbtpremium_per'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CSub1ClsMstColumns rn = CSub1ClsMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.cls_typ = maps[0]['cls_typ'];
    rn.sub1_lrg_cd = maps[0]['sub1_lrg_cd'];
    rn.sub1_mdl_cd = maps[0]['sub1_mdl_cd'];
    rn.sub1_sml_cd = maps[0]['sub1_sml_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.kana_name = maps[0]['kana_name'];
    rn.rbttarget_flg = maps[0]['rbttarget_flg'];
    rn.stl_dsc_flg = maps[0]['stl_dsc_flg'];
    rn.stlplus_flg = maps[0]['stlplus_flg'];
    rn.pctr_tckt_flg = maps[0]['pctr_tckt_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.rbtpremium_per = maps[0]['rbtpremium_per'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CSub1ClsMstField.comp_cd : this.comp_cd,
      CSub1ClsMstField.stre_cd : this.stre_cd,
      CSub1ClsMstField.cls_typ : this.cls_typ,
      CSub1ClsMstField.sub1_lrg_cd : this.sub1_lrg_cd,
      CSub1ClsMstField.sub1_mdl_cd : this.sub1_mdl_cd,
      CSub1ClsMstField.sub1_sml_cd : this.sub1_sml_cd,
      CSub1ClsMstField.name : this.name,
      CSub1ClsMstField.short_name : this.short_name,
      CSub1ClsMstField.kana_name : this.kana_name,
      CSub1ClsMstField.rbttarget_flg : this.rbttarget_flg,
      CSub1ClsMstField.stl_dsc_flg : this.stl_dsc_flg,
      CSub1ClsMstField.stlplus_flg : this.stlplus_flg,
      CSub1ClsMstField.pctr_tckt_flg : this.pctr_tckt_flg,
      CSub1ClsMstField.ins_datetime : this.ins_datetime,
      CSub1ClsMstField.upd_datetime : this.upd_datetime,
      CSub1ClsMstField.status : this.status,
      CSub1ClsMstField.send_flg : this.send_flg,
      CSub1ClsMstField.upd_user : this.upd_user,
      CSub1ClsMstField.upd_system : this.upd_system,
      CSub1ClsMstField.rbtpremium_per : this.rbtpremium_per,
    };
  }
}

/// 01_10 サブ1分類マスタ c_sub1_cls_mstのフィールド名設定用クラス
class CSub1ClsMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const cls_typ = "cls_typ";
  static const sub1_lrg_cd = "sub1_lrg_cd";
  static const sub1_mdl_cd = "sub1_mdl_cd";
  static const sub1_sml_cd = "sub1_sml_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const kana_name = "kana_name";
  static const rbttarget_flg = "rbttarget_flg";
  static const stl_dsc_flg = "stl_dsc_flg";
  static const stlplus_flg = "stlplus_flg";
  static const pctr_tckt_flg = "pctr_tckt_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const rbtpremium_per = "rbtpremium_per";
}
//endregion
//region 01_11	サブ2分類マスタ	c_sub2_cls_mst
/// 01_11 サブ2分類マスタ c_sub2_cls_mstクラス
class CSub2ClsMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? cls_typ;
  int? sub2_lrg_cd;
  int? sub2_mdl_cd;
  int? sub2_sml_cd;
  String? name;
  String? short_name;
  String? kana_name;
  int rbttarget_flg = 0;
  int stl_dsc_flg = 0;
  int stlplus_flg = 0;
  int pctr_tckt_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  double? rbtpremium_per = 1;

  @override
  String _getTableName() => "c_sub2_cls_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND cls_typ = ? AND sub2_lrg_cd = ? AND sub2_mdl_cd = ? AND sub2_sml_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(cls_typ);
    rn.add(sub2_lrg_cd);
    rn.add(sub2_mdl_cd);
    rn.add(sub2_sml_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CSub2ClsMstColumns rn = CSub2ClsMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.cls_typ = maps[i]['cls_typ'];
      rn.sub2_lrg_cd = maps[i]['sub2_lrg_cd'];
      rn.sub2_mdl_cd = maps[i]['sub2_mdl_cd'];
      rn.sub2_sml_cd = maps[i]['sub2_sml_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.kana_name = maps[i]['kana_name'];
      rn.rbttarget_flg = maps[i]['rbttarget_flg'];
      rn.stl_dsc_flg = maps[i]['stl_dsc_flg'];
      rn.stlplus_flg = maps[i]['stlplus_flg'];
      rn.pctr_tckt_flg = maps[i]['pctr_tckt_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.rbtpremium_per = maps[i]['rbtpremium_per'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CSub2ClsMstColumns rn = CSub2ClsMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.cls_typ = maps[0]['cls_typ'];
    rn.sub2_lrg_cd = maps[0]['sub2_lrg_cd'];
    rn.sub2_mdl_cd = maps[0]['sub2_mdl_cd'];
    rn.sub2_sml_cd = maps[0]['sub2_sml_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.kana_name = maps[0]['kana_name'];
    rn.rbttarget_flg = maps[0]['rbttarget_flg'];
    rn.stl_dsc_flg = maps[0]['stl_dsc_flg'];
    rn.stlplus_flg = maps[0]['stlplus_flg'];
    rn.pctr_tckt_flg = maps[0]['pctr_tckt_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.rbtpremium_per = maps[0]['rbtpremium_per'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CSub2ClsMstField.comp_cd : this.comp_cd,
      CSub2ClsMstField.stre_cd : this.stre_cd,
      CSub2ClsMstField.cls_typ : this.cls_typ,
      CSub2ClsMstField.sub2_lrg_cd : this.sub2_lrg_cd,
      CSub2ClsMstField.sub2_mdl_cd : this.sub2_mdl_cd,
      CSub2ClsMstField.sub2_sml_cd : this.sub2_sml_cd,
      CSub2ClsMstField.name : this.name,
      CSub2ClsMstField.short_name : this.short_name,
      CSub2ClsMstField.kana_name : this.kana_name,
      CSub2ClsMstField.rbttarget_flg : this.rbttarget_flg,
      CSub2ClsMstField.stl_dsc_flg : this.stl_dsc_flg,
      CSub2ClsMstField.stlplus_flg : this.stlplus_flg,
      CSub2ClsMstField.pctr_tckt_flg : this.pctr_tckt_flg,
      CSub2ClsMstField.ins_datetime : this.ins_datetime,
      CSub2ClsMstField.upd_datetime : this.upd_datetime,
      CSub2ClsMstField.status : this.status,
      CSub2ClsMstField.send_flg : this.send_flg,
      CSub2ClsMstField.upd_user : this.upd_user,
      CSub2ClsMstField.upd_system : this.upd_system,
      CSub2ClsMstField.rbtpremium_per : this.rbtpremium_per,
    };
  }
}

/// 01_11 サブ2分類マスタ c_sub2_cls_mstのフィールド名設定用クラス
class CSub2ClsMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const cls_typ = "cls_typ";
  static const sub2_lrg_cd = "sub2_lrg_cd";
  static const sub2_mdl_cd = "sub2_mdl_cd";
  static const sub2_sml_cd = "sub2_sml_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const kana_name = "kana_name";
  static const rbttarget_flg = "rbttarget_flg";
  static const stl_dsc_flg = "stl_dsc_flg";
  static const stlplus_flg = "stlplus_flg";
  static const pctr_tckt_flg = "pctr_tckt_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const rbtpremium_per = "rbtpremium_per";
}
//endregion