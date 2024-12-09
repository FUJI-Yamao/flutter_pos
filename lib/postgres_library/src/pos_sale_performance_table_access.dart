/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
13_POS販売実績テーブル
13_1	レジ・扱者日別取引	rdly_deal
13_2	レジ・扱者日別取引時間帯	rdly_deal_hour
13_3	レジ・扱者日別在高	rdly_flow
13_4	レジ日別釣銭機	rdly_acr
13_5	レジ日別分類	rdly_class
13_6	レジ日別分類時間帯	rdly_class_hour
13_7	レジ日別商品	rdly_plu
13_8	レジ日別商品時間帯	rdly_plu_hour
13_9	レジ日別値下	rdly_dsc
13_10	レジ日別プロモーション	rdly_prom
13_11	会員日別実績	rdly_cust
13_12	サービス分類日別実績	rdly_svs
13_13	レジ・扱者日別コード決済在高	rdly_cdpayflow
13_14	レジ・扱者日別税別明細	rdly_tax_deal
13_15	レジ・扱者日別時間帯税明細	rdly_tax_deal_hour
13_16	実績ワーク	wk_que
 */

//region 13_1	レジ・扱者日別取引	rdly_deal
/// 13_1  レジ・扱者日別取引  rdly_dealクラス
class RdlyDealColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int chkr_no = 0;
  int cshr_no = 0;
  String? sale_date;
  String? kind_cd;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  double? data10 = 0;

  @override
  String _getTableName() => "rdly_deal";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND chkr_no = ? AND cshr_no = ? AND sale_date = ? AND kind_cd = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(chkr_no);
    rn.add(cshr_no);
    rn.add(sale_date);
    rn.add(kind_cd);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyDealColumns rn = RdlyDealColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.kind_cd = maps[i]['kind_cd'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyDealColumns rn = RdlyDealColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.kind_cd = maps[0]['kind_cd'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyDealField.comp_cd : this.comp_cd,
      RdlyDealField.stre_cd : this.stre_cd,
      RdlyDealField.mac_no : this.mac_no,
      RdlyDealField.chkr_no : this.chkr_no,
      RdlyDealField.cshr_no : this.cshr_no,
      RdlyDealField.sale_date : this.sale_date,
      RdlyDealField.kind_cd : this.kind_cd,
      RdlyDealField.sub : this.sub,
      RdlyDealField.data1 : this.data1,
      RdlyDealField.data2 : this.data2,
      RdlyDealField.data3 : this.data3,
      RdlyDealField.data4 : this.data4,
      RdlyDealField.data5 : this.data5,
      RdlyDealField.data6 : this.data6,
      RdlyDealField.data7 : this.data7,
      RdlyDealField.data8 : this.data8,
      RdlyDealField.data9 : this.data9,
      RdlyDealField.data10 : this.data10,
    };
  }
}

/// 13_1  レジ・扱者日別取引  rdly_dealのフィールド名設定用クラス
class RdlyDealField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const chkr_no = "chkr_no";
  static const cshr_no = "cshr_no";
  static const sale_date = "sale_date";
  static const kind_cd = "kind_cd";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
}
//endregion
//region 13_2	レジ・扱者日別取引時間帯	rdly_deal_hour
/// 13_2  レジ・扱者日別取引時間帯 rdly_deal_hourクラス
class RdlyDealHourColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int chkr_no = 0;
  int cshr_no = 0;
  String? sale_date;
  String? date_hour;
  int? mode;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  double? data10 = 0;
  double? data11 = 0;

  @override
  String _getTableName() => "rdly_deal_hour";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND chkr_no = ? AND cshr_no = ? AND sale_date = ? AND date_hour = ? AND mode = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(chkr_no);
    rn.add(cshr_no);
    rn.add(sale_date);
    rn.add(date_hour);
    rn.add(mode);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyDealHourColumns rn = RdlyDealHourColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.date_hour = maps[i]['date_hour'];
      rn.mode = maps[i]['mode'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyDealHourColumns rn = RdlyDealHourColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.date_hour = maps[0]['date_hour'];
    rn.mode = maps[0]['mode'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyDealHourField.comp_cd : this.comp_cd,
      RdlyDealHourField.stre_cd : this.stre_cd,
      RdlyDealHourField.mac_no : this.mac_no,
      RdlyDealHourField.chkr_no : this.chkr_no,
      RdlyDealHourField.cshr_no : this.cshr_no,
      RdlyDealHourField.sale_date : this.sale_date,
      RdlyDealHourField.date_hour : this.date_hour,
      RdlyDealHourField.mode : this.mode,
      RdlyDealHourField.sub : this.sub,
      RdlyDealHourField.data1 : this.data1,
      RdlyDealHourField.data2 : this.data2,
      RdlyDealHourField.data3 : this.data3,
      RdlyDealHourField.data4 : this.data4,
      RdlyDealHourField.data5 : this.data5,
      RdlyDealHourField.data6 : this.data6,
      RdlyDealHourField.data7 : this.data7,
      RdlyDealHourField.data8 : this.data8,
      RdlyDealHourField.data9 : this.data9,
      RdlyDealHourField.data10 : this.data10,
      RdlyDealHourField.data11 : this.data11,
    };
  }
}

/// 13_2  レジ・扱者日別取引時間帯 rdly_deal_hourのフィールド名設定用クラス
class RdlyDealHourField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const chkr_no = "chkr_no";
  static const cshr_no = "cshr_no";
  static const sale_date = "sale_date";
  static const date_hour = "date_hour";
  static const mode = "mode";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
}
//endregion
//region 13_3	レジ・扱者日別在高	rdly_flow
/// 13_3  レジ・扱者日別在高  rdly_flowクラス
class RdlyFlowColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int chkr_no = 0;
  int cshr_no = 0;
  String? sale_date;
  int? kind;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;

  @override
  String _getTableName() => "rdly_flow";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND chkr_no = ? AND cshr_no = ? AND sale_date = ? AND kind = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(chkr_no);
    rn.add(cshr_no);
    rn.add(sale_date);
    rn.add(kind);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyFlowColumns rn = RdlyFlowColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.kind = maps[i]['kind'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyFlowColumns rn = RdlyFlowColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.kind = maps[0]['kind'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyFlowField.comp_cd : this.comp_cd,
      RdlyFlowField.stre_cd : this.stre_cd,
      RdlyFlowField.mac_no : this.mac_no,
      RdlyFlowField.chkr_no : this.chkr_no,
      RdlyFlowField.cshr_no : this.cshr_no,
      RdlyFlowField.sale_date : this.sale_date,
      RdlyFlowField.kind : this.kind,
      RdlyFlowField.sub : this.sub,
      RdlyFlowField.data1 : this.data1,
      RdlyFlowField.data2 : this.data2,
      RdlyFlowField.data3 : this.data3,
      RdlyFlowField.data4 : this.data4,
      RdlyFlowField.data5 : this.data5,
      RdlyFlowField.data6 : this.data6,
    };
  }
}

/// 13_3  レジ・扱者日別在高  rdly_flowのフィールド名設定用クラス
class RdlyFlowField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const chkr_no = "chkr_no";
  static const cshr_no = "cshr_no";
  static const sale_date = "sale_date";
  static const kind = "kind";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
}
//endregion
//region 13_4	レジ日別釣銭機	rdly_acr
/// 13_4  レジ日別釣銭機  rdly_acrクラス
class RdlyAcrColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  String? sale_date;
  int acr_1_sht = 0;
  int acr_5_sht = 0;
  int acr_10_sht = 0;
  int acr_50_sht = 0;
  int acr_100_sht = 0;
  int acr_500_sht = 0;
  int acb_1000_sht = 0;
  int acb_2000_sht = 0;
  int acb_5000_sht = 0;
  int acb_10000_sht = 0;
  int acr_1_pol_sht = 0;
  int acr_5_pol_sht = 0;
  int acr_10_pol_sht = 0;
  int acr_50_pol_sht = 0;
  int acr_100_pol_sht = 0;
  int acr_500_pol_sht = 0;
  int acr_oth_pol_sht = 0;
  int acb_1000_pol_sht = 0;
  int acb_2000_pol_sht = 0;
  int acb_5000_pol_sht = 0;
  int acb_10000_pol_sht = 0;
  int acb_fill_pol_sht = 0;
  int acb_reject_cnt = 0;

  @override
  String _getTableName() => "rdly_acr";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND sale_date = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(sale_date);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyAcrColumns rn = RdlyAcrColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.acr_1_sht = maps[i]['acr_1_sht'];
      rn.acr_5_sht = maps[i]['acr_5_sht'];
      rn.acr_10_sht = maps[i]['acr_10_sht'];
      rn.acr_50_sht = maps[i]['acr_50_sht'];
      rn.acr_100_sht = maps[i]['acr_100_sht'];
      rn.acr_500_sht = maps[i]['acr_500_sht'];
      rn.acb_1000_sht = maps[i]['acb_1000_sht'];
      rn.acb_2000_sht = maps[i]['acb_2000_sht'];
      rn.acb_5000_sht = maps[i]['acb_5000_sht'];
      rn.acb_10000_sht = maps[i]['acb_10000_sht'];
      rn.acr_1_pol_sht = maps[i]['acr_1_pol_sht'];
      rn.acr_5_pol_sht = maps[i]['acr_5_pol_sht'];
      rn.acr_10_pol_sht = maps[i]['acr_10_pol_sht'];
      rn.acr_50_pol_sht = maps[i]['acr_50_pol_sht'];
      rn.acr_100_pol_sht = maps[i]['acr_100_pol_sht'];
      rn.acr_500_pol_sht = maps[i]['acr_500_pol_sht'];
      rn.acr_oth_pol_sht = maps[i]['acr_oth_pol_sht'];
      rn.acb_1000_pol_sht = maps[i]['acb_1000_pol_sht'];
      rn.acb_2000_pol_sht = maps[i]['acb_2000_pol_sht'];
      rn.acb_5000_pol_sht = maps[i]['acb_5000_pol_sht'];
      rn.acb_10000_pol_sht = maps[i]['acb_10000_pol_sht'];
      rn.acb_fill_pol_sht = maps[i]['acb_fill_pol_sht'];
      rn.acb_reject_cnt = maps[i]['acb_reject_cnt'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyAcrColumns rn = RdlyAcrColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.acr_1_sht = maps[0]['acr_1_sht'];
    rn.acr_5_sht = maps[0]['acr_5_sht'];
    rn.acr_10_sht = maps[0]['acr_10_sht'];
    rn.acr_50_sht = maps[0]['acr_50_sht'];
    rn.acr_100_sht = maps[0]['acr_100_sht'];
    rn.acr_500_sht = maps[0]['acr_500_sht'];
    rn.acb_1000_sht = maps[0]['acb_1000_sht'];
    rn.acb_2000_sht = maps[0]['acb_2000_sht'];
    rn.acb_5000_sht = maps[0]['acb_5000_sht'];
    rn.acb_10000_sht = maps[0]['acb_10000_sht'];
    rn.acr_1_pol_sht = maps[0]['acr_1_pol_sht'];
    rn.acr_5_pol_sht = maps[0]['acr_5_pol_sht'];
    rn.acr_10_pol_sht = maps[0]['acr_10_pol_sht'];
    rn.acr_50_pol_sht = maps[0]['acr_50_pol_sht'];
    rn.acr_100_pol_sht = maps[0]['acr_100_pol_sht'];
    rn.acr_500_pol_sht = maps[0]['acr_500_pol_sht'];
    rn.acr_oth_pol_sht = maps[0]['acr_oth_pol_sht'];
    rn.acb_1000_pol_sht = maps[0]['acb_1000_pol_sht'];
    rn.acb_2000_pol_sht = maps[0]['acb_2000_pol_sht'];
    rn.acb_5000_pol_sht = maps[0]['acb_5000_pol_sht'];
    rn.acb_10000_pol_sht = maps[0]['acb_10000_pol_sht'];
    rn.acb_fill_pol_sht = maps[0]['acb_fill_pol_sht'];
    rn.acb_reject_cnt = maps[0]['acb_reject_cnt'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyAcrField.comp_cd : this.comp_cd,
      RdlyAcrField.stre_cd : this.stre_cd,
      RdlyAcrField.mac_no : this.mac_no,
      RdlyAcrField.sale_date : this.sale_date,
      RdlyAcrField.acr_1_sht : this.acr_1_sht,
      RdlyAcrField.acr_5_sht : this.acr_5_sht,
      RdlyAcrField.acr_10_sht : this.acr_10_sht,
      RdlyAcrField.acr_50_sht : this.acr_50_sht,
      RdlyAcrField.acr_100_sht : this.acr_100_sht,
      RdlyAcrField.acr_500_sht : this.acr_500_sht,
      RdlyAcrField.acb_1000_sht : this.acb_1000_sht,
      RdlyAcrField.acb_2000_sht : this.acb_2000_sht,
      RdlyAcrField.acb_5000_sht : this.acb_5000_sht,
      RdlyAcrField.acb_10000_sht : this.acb_10000_sht,
      RdlyAcrField.acr_1_pol_sht : this.acr_1_pol_sht,
      RdlyAcrField.acr_5_pol_sht : this.acr_5_pol_sht,
      RdlyAcrField.acr_10_pol_sht : this.acr_10_pol_sht,
      RdlyAcrField.acr_50_pol_sht : this.acr_50_pol_sht,
      RdlyAcrField.acr_100_pol_sht : this.acr_100_pol_sht,
      RdlyAcrField.acr_500_pol_sht : this.acr_500_pol_sht,
      RdlyAcrField.acr_oth_pol_sht : this.acr_oth_pol_sht,
      RdlyAcrField.acb_1000_pol_sht : this.acb_1000_pol_sht,
      RdlyAcrField.acb_2000_pol_sht : this.acb_2000_pol_sht,
      RdlyAcrField.acb_5000_pol_sht : this.acb_5000_pol_sht,
      RdlyAcrField.acb_10000_pol_sht : this.acb_10000_pol_sht,
      RdlyAcrField.acb_fill_pol_sht : this.acb_fill_pol_sht,
      RdlyAcrField.acb_reject_cnt : this.acb_reject_cnt,
    };
  }
}

/// 13_4  レジ日別釣銭機  rdly_acrのフィールド名設定用クラス
class RdlyAcrField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const sale_date = "sale_date";
  static const acr_1_sht = "acr_1_sht";
  static const acr_5_sht = "acr_5_sht";
  static const acr_10_sht = "acr_10_sht";
  static const acr_50_sht = "acr_50_sht";
  static const acr_100_sht = "acr_100_sht";
  static const acr_500_sht = "acr_500_sht";
  static const acb_1000_sht = "acb_1000_sht";
  static const acb_2000_sht = "acb_2000_sht";
  static const acb_5000_sht = "acb_5000_sht";
  static const acb_10000_sht = "acb_10000_sht";
  static const acr_1_pol_sht = "acr_1_pol_sht";
  static const acr_5_pol_sht = "acr_5_pol_sht";
  static const acr_10_pol_sht = "acr_10_pol_sht";
  static const acr_50_pol_sht = "acr_50_pol_sht";
  static const acr_100_pol_sht = "acr_100_pol_sht";
  static const acr_500_pol_sht = "acr_500_pol_sht";
  static const acr_oth_pol_sht = "acr_oth_pol_sht";
  static const acb_1000_pol_sht = "acb_1000_pol_sht";
  static const acb_2000_pol_sht = "acb_2000_pol_sht";
  static const acb_5000_pol_sht = "acb_5000_pol_sht";
  static const acb_10000_pol_sht = "acb_10000_pol_sht";
  static const acb_fill_pol_sht = "acb_fill_pol_sht";
  static const acb_reject_cnt = "acb_reject_cnt";
}
//endregion
//region 13_5	レジ日別分類	rdly_class
/// 13_5  レジ日別分類 rdly_classクラス
class RdlyClassColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? lgpcls_cd;
  int? grpcls_cd;
  int? lrgcls_cd;
  int? mdlcls_cd;
  int? smlcls_cd;
  int? tnycls_cd;
  String? sale_date;
  int? mode;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  double? data20 = 0;
  double? data21 = 0;
  String? data22;

  @override
  String _getTableName() => "rdly_class";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND lgpcls_cd = ? AND grpcls_cd = ? AND lrgcls_cd = ? AND mdlcls_cd = ? AND smlcls_cd = ? AND tnycls_cd = ? AND sale_date = ? AND mode = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(lgpcls_cd);
    rn.add(grpcls_cd);
    rn.add(lrgcls_cd);
    rn.add(mdlcls_cd);
    rn.add(smlcls_cd);
    rn.add(tnycls_cd);
    rn.add(sale_date);
    rn.add(mode);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyClassColumns rn = RdlyClassColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.lgpcls_cd = maps[i]['lgpcls_cd'];
      rn.grpcls_cd = maps[i]['grpcls_cd'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.tnycls_cd = maps[i]['tnycls_cd'];
      rn.sale_date = maps[i]['sale_date'];
      rn.mode = maps[i]['mode'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      rn.data12 = maps[i]['data12'];
      rn.data13 = maps[i]['data13'];
      rn.data14 = maps[i]['data14'];
      rn.data15 = maps[i]['data15'];
      rn.data16 = maps[i]['data16'];
      rn.data17 = maps[i]['data17'];
      rn.data18 = maps[i]['data18'];
      rn.data19 = maps[i]['data19'];
      rn.data20 = maps[i]['data20'];
      rn.data21 = maps[i]['data21'];
      rn.data22 = maps[i]['data22'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyClassColumns rn = RdlyClassColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.lgpcls_cd = maps[0]['lgpcls_cd'];
    rn.grpcls_cd = maps[0]['grpcls_cd'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.tnycls_cd = maps[0]['tnycls_cd'];
    rn.sale_date = maps[0]['sale_date'];
    rn.mode = maps[0]['mode'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    rn.data12 = maps[0]['data12'];
    rn.data13 = maps[0]['data13'];
    rn.data14 = maps[0]['data14'];
    rn.data15 = maps[0]['data15'];
    rn.data16 = maps[0]['data16'];
    rn.data17 = maps[0]['data17'];
    rn.data18 = maps[0]['data18'];
    rn.data19 = maps[0]['data19'];
    rn.data20 = maps[0]['data20'];
    rn.data21 = maps[0]['data21'];
    rn.data22 = maps[0]['data22'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyClassField.comp_cd : this.comp_cd,
      RdlyClassField.stre_cd : this.stre_cd,
      RdlyClassField.mac_no : this.mac_no,
      RdlyClassField.lgpcls_cd : this.lgpcls_cd,
      RdlyClassField.grpcls_cd : this.grpcls_cd,
      RdlyClassField.lrgcls_cd : this.lrgcls_cd,
      RdlyClassField.mdlcls_cd : this.mdlcls_cd,
      RdlyClassField.smlcls_cd : this.smlcls_cd,
      RdlyClassField.tnycls_cd : this.tnycls_cd,
      RdlyClassField.sale_date : this.sale_date,
      RdlyClassField.mode : this.mode,
      RdlyClassField.sub : this.sub,
      RdlyClassField.data1 : this.data1,
      RdlyClassField.data2 : this.data2,
      RdlyClassField.data3 : this.data3,
      RdlyClassField.data4 : this.data4,
      RdlyClassField.data5 : this.data5,
      RdlyClassField.data6 : this.data6,
      RdlyClassField.data7 : this.data7,
      RdlyClassField.data8 : this.data8,
      RdlyClassField.data9 : this.data9,
      RdlyClassField.data10 : this.data10,
      RdlyClassField.data11 : this.data11,
      RdlyClassField.data12 : this.data12,
      RdlyClassField.data13 : this.data13,
      RdlyClassField.data14 : this.data14,
      RdlyClassField.data15 : this.data15,
      RdlyClassField.data16 : this.data16,
      RdlyClassField.data17 : this.data17,
      RdlyClassField.data18 : this.data18,
      RdlyClassField.data19 : this.data19,
      RdlyClassField.data20 : this.data20,
      RdlyClassField.data21 : this.data21,
      RdlyClassField.data22 : this.data22,
    };
  }
}

/// 13_5  レジ日別分類 rdly_classのフィールド名設定用クラス
class RdlyClassField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const lgpcls_cd = "lgpcls_cd";
  static const grpcls_cd = "grpcls_cd";
  static const lrgcls_cd = "lrgcls_cd";
  static const mdlcls_cd = "mdlcls_cd";
  static const smlcls_cd = "smlcls_cd";
  static const tnycls_cd = "tnycls_cd";
  static const sale_date = "sale_date";
  static const mode = "mode";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
  static const data12 = "data12";
  static const data13 = "data13";
  static const data14 = "data14";
  static const data15 = "data15";
  static const data16 = "data16";
  static const data17 = "data17";
  static const data18 = "data18";
  static const data19 = "data19";
  static const data20 = "data20";
  static const data21 = "data21";
  static const data22 = "data22";
}
//endregion
//region 13_6	レジ日別分類時間帯	rdly_class_hour
/// 13_6  レジ日別分類時間帯  rdly_class_hourクラス
class RdlyClassHourColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? lgpcls_cd;
  int? grpcls_cd;
  int? lrgcls_cd;
  int? mdlcls_cd;
  int? smlcls_cd;
  int? tnycls_cd;
  String? sale_date;
  String? date_hour;
  int? mode;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  double? data20 = 0;
  double? data21 = 0;
  String? data22;

  @override
  String _getTableName() => "rdly_class_hour";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND lgpcls_cd = ? AND grpcls_cd = ? AND lrgcls_cd = ? AND mdlcls_cd = ? AND smlcls_cd = ? AND tnycls_cd = ? AND sale_date = ? AND date_hour = ? AND mode = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(lgpcls_cd);
    rn.add(grpcls_cd);
    rn.add(lrgcls_cd);
    rn.add(mdlcls_cd);
    rn.add(smlcls_cd);
    rn.add(tnycls_cd);
    rn.add(sale_date);
    rn.add(date_hour);
    rn.add(mode);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyClassHourColumns rn = RdlyClassHourColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.lgpcls_cd = maps[i]['lgpcls_cd'];
      rn.grpcls_cd = maps[i]['grpcls_cd'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.tnycls_cd = maps[i]['tnycls_cd'];
      rn.sale_date = maps[i]['sale_date'];
      rn.date_hour = maps[i]['date_hour'];
      rn.mode = maps[i]['mode'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      rn.data12 = maps[i]['data12'];
      rn.data13 = maps[i]['data13'];
      rn.data14 = maps[i]['data14'];
      rn.data15 = maps[i]['data15'];
      rn.data16 = maps[i]['data16'];
      rn.data17 = maps[i]['data17'];
      rn.data18 = maps[i]['data18'];
      rn.data19 = maps[i]['data19'];
      rn.data20 = maps[i]['data20'];
      rn.data21 = maps[i]['data21'];
      rn.data22 = maps[i]['data22'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyClassHourColumns rn = RdlyClassHourColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.lgpcls_cd = maps[0]['lgpcls_cd'];
    rn.grpcls_cd = maps[0]['grpcls_cd'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.tnycls_cd = maps[0]['tnycls_cd'];
    rn.sale_date = maps[0]['sale_date'];
    rn.date_hour = maps[0]['date_hour'];
    rn.mode = maps[0]['mode'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    rn.data12 = maps[0]['data12'];
    rn.data13 = maps[0]['data13'];
    rn.data14 = maps[0]['data14'];
    rn.data15 = maps[0]['data15'];
    rn.data16 = maps[0]['data16'];
    rn.data17 = maps[0]['data17'];
    rn.data18 = maps[0]['data18'];
    rn.data19 = maps[0]['data19'];
    rn.data20 = maps[0]['data20'];
    rn.data21 = maps[0]['data21'];
    rn.data22 = maps[0]['data22'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyClassHourField.comp_cd : this.comp_cd,
      RdlyClassHourField.stre_cd : this.stre_cd,
      RdlyClassHourField.mac_no : this.mac_no,
      RdlyClassHourField.lgpcls_cd : this.lgpcls_cd,
      RdlyClassHourField.grpcls_cd : this.grpcls_cd,
      RdlyClassHourField.lrgcls_cd : this.lrgcls_cd,
      RdlyClassHourField.mdlcls_cd : this.mdlcls_cd,
      RdlyClassHourField.smlcls_cd : this.smlcls_cd,
      RdlyClassHourField.tnycls_cd : this.tnycls_cd,
      RdlyClassHourField.sale_date : this.sale_date,
      RdlyClassHourField.date_hour : this.date_hour,
      RdlyClassHourField.mode : this.mode,
      RdlyClassHourField.sub : this.sub,
      RdlyClassHourField.data1 : this.data1,
      RdlyClassHourField.data2 : this.data2,
      RdlyClassHourField.data3 : this.data3,
      RdlyClassHourField.data4 : this.data4,
      RdlyClassHourField.data5 : this.data5,
      RdlyClassHourField.data6 : this.data6,
      RdlyClassHourField.data7 : this.data7,
      RdlyClassHourField.data8 : this.data8,
      RdlyClassHourField.data9 : this.data9,
      RdlyClassHourField.data10 : this.data10,
      RdlyClassHourField.data11 : this.data11,
      RdlyClassHourField.data12 : this.data12,
      RdlyClassHourField.data13 : this.data13,
      RdlyClassHourField.data14 : this.data14,
      RdlyClassHourField.data15 : this.data15,
      RdlyClassHourField.data16 : this.data16,
      RdlyClassHourField.data17 : this.data17,
      RdlyClassHourField.data18 : this.data18,
      RdlyClassHourField.data19 : this.data19,
      RdlyClassHourField.data20 : this.data20,
      RdlyClassHourField.data21 : this.data21,
      RdlyClassHourField.data22 : this.data22,
    };
  }
}

/// 13_6  レジ日別分類時間帯  rdly_class_hourのフィールド名設定用クラス
class RdlyClassHourField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const lgpcls_cd = "lgpcls_cd";
  static const grpcls_cd = "grpcls_cd";
  static const lrgcls_cd = "lrgcls_cd";
  static const mdlcls_cd = "mdlcls_cd";
  static const smlcls_cd = "smlcls_cd";
  static const tnycls_cd = "tnycls_cd";
  static const sale_date = "sale_date";
  static const date_hour = "date_hour";
  static const mode = "mode";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
  static const data12 = "data12";
  static const data13 = "data13";
  static const data14 = "data14";
  static const data15 = "data15";
  static const data16 = "data16";
  static const data17 = "data17";
  static const data18 = "data18";
  static const data19 = "data19";
  static const data20 = "data20";
  static const data21 = "data21";
  static const data22 = "data22";
}
//endregion
//region 13_7	レジ日別商品	rdly_plu
/// 13_7  レジ日別商品 rdly_pluクラス
class RdlyPluColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  String? plu_cd;
  int? smlcls_cd;
  String? sale_date;
  int? mode;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  double? data20 = 0;
  double? data21 = 0;
  String? data22;

  @override
  String _getTableName() => "rdly_plu";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND plu_cd = ? AND smlcls_cd = ? AND sale_date = ? AND mode = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(plu_cd);
    rn.add(smlcls_cd);
    rn.add(sale_date);
    rn.add(mode);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyPluColumns rn = RdlyPluColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.sale_date = maps[i]['sale_date'];
      rn.mode = maps[i]['mode'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      rn.data12 = maps[i]['data12'];
      rn.data13 = maps[i]['data13'];
      rn.data14 = maps[i]['data14'];
      rn.data15 = maps[i]['data15'];
      rn.data16 = maps[i]['data16'];
      rn.data17 = maps[i]['data17'];
      rn.data18 = maps[i]['data18'];
      rn.data19 = maps[i]['data19'];
      rn.data20 = maps[i]['data20'];
      rn.data21 = maps[i]['data21'];
      rn.data22 = maps[i]['data22'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyPluColumns rn = RdlyPluColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.sale_date = maps[0]['sale_date'];
    rn.mode = maps[0]['mode'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    rn.data12 = maps[0]['data12'];
    rn.data13 = maps[0]['data13'];
    rn.data14 = maps[0]['data14'];
    rn.data15 = maps[0]['data15'];
    rn.data16 = maps[0]['data16'];
    rn.data17 = maps[0]['data17'];
    rn.data18 = maps[0]['data18'];
    rn.data19 = maps[0]['data19'];
    rn.data20 = maps[0]['data20'];
    rn.data21 = maps[0]['data21'];
    rn.data22 = maps[0]['data22'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyPluField.comp_cd : this.comp_cd,
      RdlyPluField.stre_cd : this.stre_cd,
      RdlyPluField.mac_no : this.mac_no,
      RdlyPluField.plu_cd : this.plu_cd,
      RdlyPluField.smlcls_cd : this.smlcls_cd,
      RdlyPluField.sale_date : this.sale_date,
      RdlyPluField.mode : this.mode,
      RdlyPluField.sub : this.sub,
      RdlyPluField.data1 : this.data1,
      RdlyPluField.data2 : this.data2,
      RdlyPluField.data3 : this.data3,
      RdlyPluField.data4 : this.data4,
      RdlyPluField.data5 : this.data5,
      RdlyPluField.data6 : this.data6,
      RdlyPluField.data7 : this.data7,
      RdlyPluField.data8 : this.data8,
      RdlyPluField.data9 : this.data9,
      RdlyPluField.data10 : this.data10,
      RdlyPluField.data11 : this.data11,
      RdlyPluField.data12 : this.data12,
      RdlyPluField.data13 : this.data13,
      RdlyPluField.data14 : this.data14,
      RdlyPluField.data15 : this.data15,
      RdlyPluField.data16 : this.data16,
      RdlyPluField.data17 : this.data17,
      RdlyPluField.data18 : this.data18,
      RdlyPluField.data19 : this.data19,
      RdlyPluField.data20 : this.data20,
      RdlyPluField.data21 : this.data21,
      RdlyPluField.data22 : this.data22,
    };
  }
}

/// 13_7  レジ日別商品 rdly_pluのフィールド名設定用クラス
class RdlyPluField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const plu_cd = "plu_cd";
  static const smlcls_cd = "smlcls_cd";
  static const sale_date = "sale_date";
  static const mode = "mode";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
  static const data12 = "data12";
  static const data13 = "data13";
  static const data14 = "data14";
  static const data15 = "data15";
  static const data16 = "data16";
  static const data17 = "data17";
  static const data18 = "data18";
  static const data19 = "data19";
  static const data20 = "data20";
  static const data21 = "data21";
  static const data22 = "data22";
}
//endregion
//region 13_8	レジ日別商品時間帯	rdly_plu_hour
/// 13_8  レジ日別商品時間帯  rdly_plu_hourクラス
class RdlyPluHourColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  String? plu_cd;
  int? smlcls_cd;
  String? sale_date;
  String? date_hour;
  int? mode;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  double? data20 = 0;
  double? data21 = 0;
  String? data22;

  @override
  String _getTableName() => "rdly_plu_hour";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND plu_cd = ? AND smlcls_cd = ? AND sale_date = ? AND date_hour = ? AND mode = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(plu_cd);
    rn.add(smlcls_cd);
    rn.add(sale_date);
    rn.add(date_hour);
    rn.add(mode);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyPluHourColumns rn = RdlyPluHourColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.sale_date = maps[i]['sale_date'];
      rn.date_hour = maps[i]['date_hour'];
      rn.mode = maps[i]['mode'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      rn.data12 = maps[i]['data12'];
      rn.data13 = maps[i]['data13'];
      rn.data14 = maps[i]['data14'];
      rn.data15 = maps[i]['data15'];
      rn.data16 = maps[i]['data16'];
      rn.data17 = maps[i]['data17'];
      rn.data18 = maps[i]['data18'];
      rn.data19 = maps[i]['data19'];
      rn.data20 = maps[i]['data20'];
      rn.data21 = maps[i]['data21'];
      rn.data22 = maps[i]['data22'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyPluHourColumns rn = RdlyPluHourColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.sale_date = maps[0]['sale_date'];
    rn.date_hour = maps[0]['date_hour'];
    rn.mode = maps[0]['mode'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    rn.data12 = maps[0]['data12'];
    rn.data13 = maps[0]['data13'];
    rn.data14 = maps[0]['data14'];
    rn.data15 = maps[0]['data15'];
    rn.data16 = maps[0]['data16'];
    rn.data17 = maps[0]['data17'];
    rn.data18 = maps[0]['data18'];
    rn.data19 = maps[0]['data19'];
    rn.data20 = maps[0]['data20'];
    rn.data21 = maps[0]['data21'];
    rn.data22 = maps[0]['data22'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyPluHourField.comp_cd : this.comp_cd,
      RdlyPluHourField.stre_cd : this.stre_cd,
      RdlyPluHourField.mac_no : this.mac_no,
      RdlyPluHourField.plu_cd : this.plu_cd,
      RdlyPluHourField.smlcls_cd : this.smlcls_cd,
      RdlyPluHourField.sale_date : this.sale_date,
      RdlyPluHourField.date_hour : this.date_hour,
      RdlyPluHourField.mode : this.mode,
      RdlyPluHourField.sub : this.sub,
      RdlyPluHourField.data1 : this.data1,
      RdlyPluHourField.data2 : this.data2,
      RdlyPluHourField.data3 : this.data3,
      RdlyPluHourField.data4 : this.data4,
      RdlyPluHourField.data5 : this.data5,
      RdlyPluHourField.data6 : this.data6,
      RdlyPluHourField.data7 : this.data7,
      RdlyPluHourField.data8 : this.data8,
      RdlyPluHourField.data9 : this.data9,
      RdlyPluHourField.data10 : this.data10,
      RdlyPluHourField.data11 : this.data11,
      RdlyPluHourField.data12 : this.data12,
      RdlyPluHourField.data13 : this.data13,
      RdlyPluHourField.data14 : this.data14,
      RdlyPluHourField.data15 : this.data15,
      RdlyPluHourField.data16 : this.data16,
      RdlyPluHourField.data17 : this.data17,
      RdlyPluHourField.data18 : this.data18,
      RdlyPluHourField.data19 : this.data19,
      RdlyPluHourField.data20 : this.data20,
      RdlyPluHourField.data21 : this.data21,
      RdlyPluHourField.data22 : this.data22,
    };
  }
}

/// 13_8  レジ日別商品時間帯  rdly_plu_hourのフィールド名設定用クラス
class RdlyPluHourField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const plu_cd = "plu_cd";
  static const smlcls_cd = "smlcls_cd";
  static const sale_date = "sale_date";
  static const date_hour = "date_hour";
  static const mode = "mode";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
  static const data12 = "data12";
  static const data13 = "data13";
  static const data14 = "data14";
  static const data15 = "data15";
  static const data16 = "data16";
  static const data17 = "data17";
  static const data18 = "data18";
  static const data19 = "data19";
  static const data20 = "data20";
  static const data21 = "data21";
  static const data22 = "data22";
}
//endregion
//region 13_9	レジ日別値下	rdly_dsc
/// 13_9  レジ日別値下 rdly_dscクラス
class RdlyDscColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  String? plu_cd;
  int? smlcls_cd;
  String? sale_date;
  int? mode;
  int? kind;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;

  @override
  String _getTableName() => "rdly_dsc";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND plu_cd = ? AND smlcls_cd = ? AND sale_date = ? AND mode = ? AND kind = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(plu_cd);
    rn.add(smlcls_cd);
    rn.add(sale_date);
    rn.add(mode);
    rn.add(kind);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyDscColumns rn = RdlyDscColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.sale_date = maps[i]['sale_date'];
      rn.mode = maps[i]['mode'];
      rn.kind = maps[i]['kind'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyDscColumns rn = RdlyDscColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.sale_date = maps[0]['sale_date'];
    rn.mode = maps[0]['mode'];
    rn.kind = maps[0]['kind'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyDscField.comp_cd : this.comp_cd,
      RdlyDscField.stre_cd : this.stre_cd,
      RdlyDscField.mac_no : this.mac_no,
      RdlyDscField.plu_cd : this.plu_cd,
      RdlyDscField.smlcls_cd : this.smlcls_cd,
      RdlyDscField.sale_date : this.sale_date,
      RdlyDscField.mode : this.mode,
      RdlyDscField.kind : this.kind,
      RdlyDscField.sub : this.sub,
      RdlyDscField.data1 : this.data1,
      RdlyDscField.data2 : this.data2,
      RdlyDscField.data3 : this.data3,
      RdlyDscField.data4 : this.data4,
      RdlyDscField.data5 : this.data5,
      RdlyDscField.data6 : this.data6,
    };
  }
}

/// 13_9  レジ日別値下 rdly_dscのフィールド名設定用クラス
class RdlyDscField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const plu_cd = "plu_cd";
  static const smlcls_cd = "smlcls_cd";
  static const sale_date = "sale_date";
  static const mode = "mode";
  static const kind = "kind";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
}
//endregion
//region 13_10	レジ日別プロモーション	rdly_prom
/// 13_10 レジ日別プロモーション  rdly_promクラス
class RdlyPromColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? sch_cd;
  String? plu_cd;
  int? cls_cd;
  String? sale_date;
  int? mode;
  int? prom_typ;
  int? sch_typ;
  int? kind;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;

  @override
  String _getTableName() => "rdly_prom";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND sch_cd = ? AND plu_cd = ? AND cls_cd = ? AND sale_date = ? AND mode = ? AND prom_typ = ? AND sch_typ = ? AND kind = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(sch_cd);
    rn.add(plu_cd);
    rn.add(cls_cd);
    rn.add(sale_date);
    rn.add(mode);
    rn.add(prom_typ);
    rn.add(sch_typ);
    rn.add(kind);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyPromColumns rn = RdlyPromColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.sch_cd = maps[i]['sch_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.cls_cd = maps[i]['cls_cd'];
      rn.sale_date = maps[i]['sale_date'];
      rn.mode = maps[i]['mode'];
      rn.prom_typ = maps[i]['prom_typ'];
      rn.sch_typ = maps[i]['sch_typ'];
      rn.kind = maps[i]['kind'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyPromColumns rn = RdlyPromColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.sch_cd = maps[0]['sch_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.cls_cd = maps[0]['cls_cd'];
    rn.sale_date = maps[0]['sale_date'];
    rn.mode = maps[0]['mode'];
    rn.prom_typ = maps[0]['prom_typ'];
    rn.sch_typ = maps[0]['sch_typ'];
    rn.kind = maps[0]['kind'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyPromField.comp_cd : this.comp_cd,
      RdlyPromField.stre_cd : this.stre_cd,
      RdlyPromField.mac_no : this.mac_no,
      RdlyPromField.sch_cd : this.sch_cd,
      RdlyPromField.plu_cd : this.plu_cd,
      RdlyPromField.cls_cd : this.cls_cd,
      RdlyPromField.sale_date : this.sale_date,
      RdlyPromField.mode : this.mode,
      RdlyPromField.prom_typ : this.prom_typ,
      RdlyPromField.sch_typ : this.sch_typ,
      RdlyPromField.kind : this.kind,
      RdlyPromField.data1 : this.data1,
      RdlyPromField.data2 : this.data2,
      RdlyPromField.data3 : this.data3,
      RdlyPromField.data4 : this.data4,
      RdlyPromField.data5 : this.data5,
      RdlyPromField.data6 : this.data6,
    };
  }
}

/// 13_10 レジ日別プロモーション  rdly_promのフィールド名設定用クラス
class RdlyPromField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const sch_cd = "sch_cd";
  static const plu_cd = "plu_cd";
  static const cls_cd = "cls_cd";
  static const sale_date = "sale_date";
  static const mode = "mode";
  static const prom_typ = "prom_typ";
  static const sch_typ = "sch_typ";
  static const kind = "kind";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
}
//endregion
//region 13_11	会員日別実績	rdly_cust
/// 13_11 会員日別実績 rdly_custクラス
class RdlyCustColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  String? cust_no;
  int custzone_cd = 0;
  int? svs_cls_cd;
  String? sale_date;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  int data20 = 0;
  int data21 = 0;
  int data22 = 0;
  int data23 = 0;
  int data24 = 0;
  double? data25 = 0;

  @override
  String _getTableName() => "rdly_cust";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND cust_no = ? AND custzone_cd = ? AND svs_cls_cd = ? AND sale_date = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(cust_no);
    rn.add(custzone_cd);
    rn.add(svs_cls_cd);
    rn.add(sale_date);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyCustColumns rn = RdlyCustColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.cust_no = maps[i]['cust_no'];
      rn.custzone_cd = maps[i]['custzone_cd'];
      rn.svs_cls_cd = maps[i]['svs_cls_cd'];
      rn.sale_date = maps[i]['sale_date'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      rn.data12 = maps[i]['data12'];
      rn.data13 = maps[i]['data13'];
      rn.data14 = maps[i]['data14'];
      rn.data15 = maps[i]['data15'];
      rn.data16 = maps[i]['data16'];
      rn.data17 = maps[i]['data17'];
      rn.data18 = maps[i]['data18'];
      rn.data19 = maps[i]['data19'];
      rn.data20 = maps[i]['data20'];
      rn.data21 = maps[i]['data21'];
      rn.data22 = maps[i]['data22'];
      rn.data23 = maps[i]['data23'];
      rn.data24 = maps[i]['data24'];
      rn.data25 = maps[i]['data25'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyCustColumns rn = RdlyCustColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.cust_no = maps[0]['cust_no'];
    rn.custzone_cd = maps[0]['custzone_cd'];
    rn.svs_cls_cd = maps[0]['svs_cls_cd'];
    rn.sale_date = maps[0]['sale_date'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    rn.data12 = maps[0]['data12'];
    rn.data13 = maps[0]['data13'];
    rn.data14 = maps[0]['data14'];
    rn.data15 = maps[0]['data15'];
    rn.data16 = maps[0]['data16'];
    rn.data17 = maps[0]['data17'];
    rn.data18 = maps[0]['data18'];
    rn.data19 = maps[0]['data19'];
    rn.data20 = maps[0]['data20'];
    rn.data21 = maps[0]['data21'];
    rn.data22 = maps[0]['data22'];
    rn.data23 = maps[0]['data23'];
    rn.data24 = maps[0]['data24'];
    rn.data25 = maps[0]['data25'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyCustField.comp_cd : this.comp_cd,
      RdlyCustField.stre_cd : this.stre_cd,
      RdlyCustField.cust_no : this.cust_no,
      RdlyCustField.custzone_cd : this.custzone_cd,
      RdlyCustField.svs_cls_cd : this.svs_cls_cd,
      RdlyCustField.sale_date : this.sale_date,
      RdlyCustField.sub : this.sub,
      RdlyCustField.data1 : this.data1,
      RdlyCustField.data2 : this.data2,
      RdlyCustField.data3 : this.data3,
      RdlyCustField.data4 : this.data4,
      RdlyCustField.data5 : this.data5,
      RdlyCustField.data6 : this.data6,
      RdlyCustField.data7 : this.data7,
      RdlyCustField.data8 : this.data8,
      RdlyCustField.data9 : this.data9,
      RdlyCustField.data10 : this.data10,
      RdlyCustField.data11 : this.data11,
      RdlyCustField.data12 : this.data12,
      RdlyCustField.data13 : this.data13,
      RdlyCustField.data14 : this.data14,
      RdlyCustField.data15 : this.data15,
      RdlyCustField.data16 : this.data16,
      RdlyCustField.data17 : this.data17,
      RdlyCustField.data18 : this.data18,
      RdlyCustField.data19 : this.data19,
      RdlyCustField.data20 : this.data20,
      RdlyCustField.data21 : this.data21,
      RdlyCustField.data22 : this.data22,
      RdlyCustField.data23 : this.data23,
      RdlyCustField.data24 : this.data24,
      RdlyCustField.data25 : this.data25,
    };
  }
}

/// 13_11 会員日別実績 rdly_custのフィールド名設定用クラス
class RdlyCustField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const cust_no = "cust_no";
  static const custzone_cd = "custzone_cd";
  static const svs_cls_cd = "svs_cls_cd";
  static const sale_date = "sale_date";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
  static const data12 = "data12";
  static const data13 = "data13";
  static const data14 = "data14";
  static const data15 = "data15";
  static const data16 = "data16";
  static const data17 = "data17";
  static const data18 = "data18";
  static const data19 = "data19";
  static const data20 = "data20";
  static const data21 = "data21";
  static const data22 = "data22";
  static const data23 = "data23";
  static const data24 = "data24";
  static const data25 = "data25";
}
//endregion
//region 13_12	サービス分類日別実績	rdly_svs
/// 13_12 サービス分類日別実績 rdly_svsクラス
class RdlySvsColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? svs_cls_cd;
  String? sale_date;
  int? sub;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  int data20 = 0;
  int data21 = 0;
  int data22 = 0;
  int data23 = 0;
  int data24 = 0;
  double? data25 = 0;

  @override
  String _getTableName() => "rdly_svs";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND svs_cls_cd = ? AND sale_date = ? AND sub = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(svs_cls_cd);
    rn.add(sale_date);
    rn.add(sub);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlySvsColumns rn = RdlySvsColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.svs_cls_cd = maps[i]['svs_cls_cd'];
      rn.sale_date = maps[i]['sale_date'];
      rn.sub = maps[i]['sub'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      rn.data12 = maps[i]['data12'];
      rn.data13 = maps[i]['data13'];
      rn.data14 = maps[i]['data14'];
      rn.data15 = maps[i]['data15'];
      rn.data16 = maps[i]['data16'];
      rn.data17 = maps[i]['data17'];
      rn.data18 = maps[i]['data18'];
      rn.data19 = maps[i]['data19'];
      rn.data20 = maps[i]['data20'];
      rn.data21 = maps[i]['data21'];
      rn.data22 = maps[i]['data22'];
      rn.data23 = maps[i]['data23'];
      rn.data24 = maps[i]['data24'];
      rn.data25 = maps[i]['data25'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlySvsColumns rn = RdlySvsColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.svs_cls_cd = maps[0]['svs_cls_cd'];
    rn.sale_date = maps[0]['sale_date'];
    rn.sub = maps[0]['sub'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    rn.data12 = maps[0]['data12'];
    rn.data13 = maps[0]['data13'];
    rn.data14 = maps[0]['data14'];
    rn.data15 = maps[0]['data15'];
    rn.data16 = maps[0]['data16'];
    rn.data17 = maps[0]['data17'];
    rn.data18 = maps[0]['data18'];
    rn.data19 = maps[0]['data19'];
    rn.data20 = maps[0]['data20'];
    rn.data21 = maps[0]['data21'];
    rn.data22 = maps[0]['data22'];
    rn.data23 = maps[0]['data23'];
    rn.data24 = maps[0]['data24'];
    rn.data25 = maps[0]['data25'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlySvsField.comp_cd : this.comp_cd,
      RdlySvsField.stre_cd : this.stre_cd,
      RdlySvsField.svs_cls_cd : this.svs_cls_cd,
      RdlySvsField.sale_date : this.sale_date,
      RdlySvsField.sub : this.sub,
      RdlySvsField.data1 : this.data1,
      RdlySvsField.data2 : this.data2,
      RdlySvsField.data3 : this.data3,
      RdlySvsField.data4 : this.data4,
      RdlySvsField.data5 : this.data5,
      RdlySvsField.data6 : this.data6,
      RdlySvsField.data7 : this.data7,
      RdlySvsField.data8 : this.data8,
      RdlySvsField.data9 : this.data9,
      RdlySvsField.data10 : this.data10,
      RdlySvsField.data11 : this.data11,
      RdlySvsField.data12 : this.data12,
      RdlySvsField.data13 : this.data13,
      RdlySvsField.data14 : this.data14,
      RdlySvsField.data15 : this.data15,
      RdlySvsField.data16 : this.data16,
      RdlySvsField.data17 : this.data17,
      RdlySvsField.data18 : this.data18,
      RdlySvsField.data19 : this.data19,
      RdlySvsField.data20 : this.data20,
      RdlySvsField.data21 : this.data21,
      RdlySvsField.data22 : this.data22,
      RdlySvsField.data23 : this.data23,
      RdlySvsField.data24 : this.data24,
      RdlySvsField.data25 : this.data25,
    };
  }
}

/// 13_12 サービス分類日別実績 rdly_svsのフィールド名設定用クラス
class RdlySvsField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const svs_cls_cd = "svs_cls_cd";
  static const sale_date = "sale_date";
  static const sub = "sub";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
  static const data12 = "data12";
  static const data13 = "data13";
  static const data14 = "data14";
  static const data15 = "data15";
  static const data16 = "data16";
  static const data17 = "data17";
  static const data18 = "data18";
  static const data19 = "data19";
  static const data20 = "data20";
  static const data21 = "data21";
  static const data22 = "data22";
  static const data23 = "data23";
  static const data24 = "data24";
  static const data25 = "data25";
}
//endregion
//region 13_13	レジ・扱者日別コード決済在高	rdly_cdpayflow
/// 13_13 レジ・扱者日別コード決済在高 rdly_cdpayflowクラス
class RdlyCdpayflowColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int chkr_no = 0;
  int cshr_no = 0;
  String? sale_date;
  int? kind;
  int? sub;
  int payopera_cd = 0;
  String? payopera_typ;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;

  @override
  String _getTableName() => "rdly_cdpayflow";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND chkr_no = ? AND cshr_no = ? AND sale_date = ? AND kind = ? AND sub = ? AND payopera_cd = ? AND payopera_typ = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(chkr_no);
    rn.add(cshr_no);
    rn.add(sale_date);
    rn.add(kind);
    rn.add(sub);
    rn.add(payopera_cd);
    rn.add(payopera_typ);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyCdpayflowColumns rn = RdlyCdpayflowColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.kind = maps[i]['kind'];
      rn.sub = maps[i]['sub'];
      rn.payopera_cd = maps[i]['payopera_cd'];
      rn.payopera_typ = maps[i]['payopera_typ'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyCdpayflowColumns rn = RdlyCdpayflowColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.kind = maps[0]['kind'];
    rn.sub = maps[0]['sub'];
    rn.payopera_cd = maps[0]['payopera_cd'];
    rn.payopera_typ = maps[0]['payopera_typ'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyCdpayflowField.comp_cd : this.comp_cd,
      RdlyCdpayflowField.stre_cd : this.stre_cd,
      RdlyCdpayflowField.mac_no : this.mac_no,
      RdlyCdpayflowField.chkr_no : this.chkr_no,
      RdlyCdpayflowField.cshr_no : this.cshr_no,
      RdlyCdpayflowField.sale_date : this.sale_date,
      RdlyCdpayflowField.kind : this.kind,
      RdlyCdpayflowField.sub : this.sub,
      RdlyCdpayflowField.payopera_cd : this.payopera_cd,
      RdlyCdpayflowField.payopera_typ : this.payopera_typ,
      RdlyCdpayflowField.data1 : this.data1,
      RdlyCdpayflowField.data2 : this.data2,
      RdlyCdpayflowField.data3 : this.data3,
      RdlyCdpayflowField.data4 : this.data4,
      RdlyCdpayflowField.data5 : this.data5,
      RdlyCdpayflowField.data6 : this.data6,
    };
  }
}

/// 13_13 レジ・扱者日別コード決済在高 rdly_cdpayflowのフィールド名設定用クラス
class RdlyCdpayflowField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const chkr_no = "chkr_no";
  static const cshr_no = "cshr_no";
  static const sale_date = "sale_date";
  static const kind = "kind";
  static const sub = "sub";
  static const payopera_cd = "payopera_cd";
  static const payopera_typ = "payopera_typ";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
}
//endregion
//region 13_14	レジ・扱者日別税別明細	rdly_tax_deal
/// 13_14 レジ・扱者日別税別明細  rdly_tax_dealクラス
class RdlyTaxDealColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? chkr_no;
  int? cshr_no;
  String? sale_date;
  int? mode;
  int? kind;
  int? sub;
  int? func_cd;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  double? data20 = 0;
  double? data21 = 0;

  @override
  String _getTableName() => "rdly_tax_deal";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND chkr_no = ? AND cshr_no = ? AND sale_date = ? AND mode = ? AND kind = ? AND sub = ? AND func_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(chkr_no);
    rn.add(cshr_no);
    rn.add(sale_date);
    rn.add(mode);
    rn.add(kind);
    rn.add(sub);
    rn.add(func_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyTaxDealColumns rn = RdlyTaxDealColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.mode = maps[i]['mode'];
      rn.kind = maps[i]['kind'];
      rn.sub = maps[i]['sub'];
      rn.func_cd = maps[i]['func_cd'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      rn.data12 = maps[i]['data12'];
      rn.data13 = maps[i]['data13'];
      rn.data14 = maps[i]['data14'];
      rn.data15 = maps[i]['data15'];
      rn.data16 = maps[i]['data16'];
      rn.data17 = maps[i]['data17'];
      rn.data18 = maps[i]['data18'];
      rn.data19 = maps[i]['data19'];
      rn.data20 = maps[i]['data20'];
      rn.data21 = maps[i]['data21'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyTaxDealColumns rn = RdlyTaxDealColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.mode = maps[0]['mode'];
    rn.kind = maps[0]['kind'];
    rn.sub = maps[0]['sub'];
    rn.func_cd = maps[0]['func_cd'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    rn.data12 = maps[0]['data12'];
    rn.data13 = maps[0]['data13'];
    rn.data14 = maps[0]['data14'];
    rn.data15 = maps[0]['data15'];
    rn.data16 = maps[0]['data16'];
    rn.data17 = maps[0]['data17'];
    rn.data18 = maps[0]['data18'];
    rn.data19 = maps[0]['data19'];
    rn.data20 = maps[0]['data20'];
    rn.data21 = maps[0]['data21'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyTaxDealField.comp_cd : this.comp_cd,
      RdlyTaxDealField.stre_cd : this.stre_cd,
      RdlyTaxDealField.mac_no : this.mac_no,
      RdlyTaxDealField.chkr_no : this.chkr_no,
      RdlyTaxDealField.cshr_no : this.cshr_no,
      RdlyTaxDealField.sale_date : this.sale_date,
      RdlyTaxDealField.mode : this.mode,
      RdlyTaxDealField.kind : this.kind,
      RdlyTaxDealField.sub : this.sub,
      RdlyTaxDealField.func_cd : this.func_cd,
      RdlyTaxDealField.data1 : this.data1,
      RdlyTaxDealField.data2 : this.data2,
      RdlyTaxDealField.data3 : this.data3,
      RdlyTaxDealField.data4 : this.data4,
      RdlyTaxDealField.data5 : this.data5,
      RdlyTaxDealField.data6 : this.data6,
      RdlyTaxDealField.data7 : this.data7,
      RdlyTaxDealField.data8 : this.data8,
      RdlyTaxDealField.data9 : this.data9,
      RdlyTaxDealField.data10 : this.data10,
      RdlyTaxDealField.data11 : this.data11,
      RdlyTaxDealField.data12 : this.data12,
      RdlyTaxDealField.data13 : this.data13,
      RdlyTaxDealField.data14 : this.data14,
      RdlyTaxDealField.data15 : this.data15,
      RdlyTaxDealField.data16 : this.data16,
      RdlyTaxDealField.data17 : this.data17,
      RdlyTaxDealField.data18 : this.data18,
      RdlyTaxDealField.data19 : this.data19,
      RdlyTaxDealField.data20 : this.data20,
      RdlyTaxDealField.data21 : this.data21,
    };
  }
}

/// 13_14 レジ・扱者日別税別明細  rdly_tax_dealのフィールド名設定用クラス
class RdlyTaxDealField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const chkr_no = "chkr_no";
  static const cshr_no = "cshr_no";
  static const sale_date = "sale_date";
  static const mode = "mode";
  static const kind = "kind";
  static const sub = "sub";
  static const func_cd = "func_cd";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
  static const data12 = "data12";
  static const data13 = "data13";
  static const data14 = "data14";
  static const data15 = "data15";
  static const data16 = "data16";
  static const data17 = "data17";
  static const data18 = "data18";
  static const data19 = "data19";
  static const data20 = "data20";
  static const data21 = "data21";
}
//endregion
//region 13_15	レジ・扱者日別時間帯税明細	rdly_tax_deal_hour
/// 13_15 レジ・扱者日別時間帯税明細  rdly_tax_deal_hourクラス
class RdlyTaxDealHourColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? chkr_no;
  int? cshr_no;
  String? sale_date;
  String? date_hour;
  int? mode;
  int? kind;
  int? sub;
  int? func_cd;
  int data1 = 0;
  int data2 = 0;
  int data3 = 0;
  int data4 = 0;
  int data5 = 0;
  int data6 = 0;
  int data7 = 0;
  int data8 = 0;
  int data9 = 0;
  int data10 = 0;
  int data11 = 0;
  int data12 = 0;
  int data13 = 0;
  int data14 = 0;
  int data15 = 0;
  int data16 = 0;
  int data17 = 0;
  int data18 = 0;
  int data19 = 0;
  double? data20 = 0;
  double? data21 = 0;

  @override
  String _getTableName() => "rdly_tax_deal_hour";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND chkr_no = ? AND cshr_no = ? AND sale_date = ? AND date_hour = ? AND mode = ? AND kind = ? AND sub = ? AND func_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(chkr_no);
    rn.add(cshr_no);
    rn.add(sale_date);
    rn.add(date_hour);
    rn.add(mode);
    rn.add(kind);
    rn.add(sub);
    rn.add(func_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      RdlyTaxDealHourColumns rn = RdlyTaxDealHourColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.chkr_no = maps[i]['chkr_no'];
      rn.cshr_no = maps[i]['cshr_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.date_hour = maps[i]['date_hour'];
      rn.mode = maps[i]['mode'];
      rn.kind = maps[i]['kind'];
      rn.sub = maps[i]['sub'];
      rn.func_cd = maps[i]['func_cd'];
      rn.data1 = maps[i]['data1'];
      rn.data2 = maps[i]['data2'];
      rn.data3 = maps[i]['data3'];
      rn.data4 = maps[i]['data4'];
      rn.data5 = maps[i]['data5'];
      rn.data6 = maps[i]['data6'];
      rn.data7 = maps[i]['data7'];
      rn.data8 = maps[i]['data8'];
      rn.data9 = maps[i]['data9'];
      rn.data10 = maps[i]['data10'];
      rn.data11 = maps[i]['data11'];
      rn.data12 = maps[i]['data12'];
      rn.data13 = maps[i]['data13'];
      rn.data14 = maps[i]['data14'];
      rn.data15 = maps[i]['data15'];
      rn.data16 = maps[i]['data16'];
      rn.data17 = maps[i]['data17'];
      rn.data18 = maps[i]['data18'];
      rn.data19 = maps[i]['data19'];
      rn.data20 = maps[i]['data20'];
      rn.data21 = maps[i]['data21'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    RdlyTaxDealHourColumns rn = RdlyTaxDealHourColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.chkr_no = maps[0]['chkr_no'];
    rn.cshr_no = maps[0]['cshr_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.date_hour = maps[0]['date_hour'];
    rn.mode = maps[0]['mode'];
    rn.kind = maps[0]['kind'];
    rn.sub = maps[0]['sub'];
    rn.func_cd = maps[0]['func_cd'];
    rn.data1 = maps[0]['data1'];
    rn.data2 = maps[0]['data2'];
    rn.data3 = maps[0]['data3'];
    rn.data4 = maps[0]['data4'];
    rn.data5 = maps[0]['data5'];
    rn.data6 = maps[0]['data6'];
    rn.data7 = maps[0]['data7'];
    rn.data8 = maps[0]['data8'];
    rn.data9 = maps[0]['data9'];
    rn.data10 = maps[0]['data10'];
    rn.data11 = maps[0]['data11'];
    rn.data12 = maps[0]['data12'];
    rn.data13 = maps[0]['data13'];
    rn.data14 = maps[0]['data14'];
    rn.data15 = maps[0]['data15'];
    rn.data16 = maps[0]['data16'];
    rn.data17 = maps[0]['data17'];
    rn.data18 = maps[0]['data18'];
    rn.data19 = maps[0]['data19'];
    rn.data20 = maps[0]['data20'];
    rn.data21 = maps[0]['data21'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      RdlyTaxDealHourField.comp_cd : this.comp_cd,
      RdlyTaxDealHourField.stre_cd : this.stre_cd,
      RdlyTaxDealHourField.mac_no : this.mac_no,
      RdlyTaxDealHourField.chkr_no : this.chkr_no,
      RdlyTaxDealHourField.cshr_no : this.cshr_no,
      RdlyTaxDealHourField.sale_date : this.sale_date,
      RdlyTaxDealHourField.date_hour : this.date_hour,
      RdlyTaxDealHourField.mode : this.mode,
      RdlyTaxDealHourField.kind : this.kind,
      RdlyTaxDealHourField.sub : this.sub,
      RdlyTaxDealHourField.func_cd : this.func_cd,
      RdlyTaxDealHourField.data1 : this.data1,
      RdlyTaxDealHourField.data2 : this.data2,
      RdlyTaxDealHourField.data3 : this.data3,
      RdlyTaxDealHourField.data4 : this.data4,
      RdlyTaxDealHourField.data5 : this.data5,
      RdlyTaxDealHourField.data6 : this.data6,
      RdlyTaxDealHourField.data7 : this.data7,
      RdlyTaxDealHourField.data8 : this.data8,
      RdlyTaxDealHourField.data9 : this.data9,
      RdlyTaxDealHourField.data10 : this.data10,
      RdlyTaxDealHourField.data11 : this.data11,
      RdlyTaxDealHourField.data12 : this.data12,
      RdlyTaxDealHourField.data13 : this.data13,
      RdlyTaxDealHourField.data14 : this.data14,
      RdlyTaxDealHourField.data15 : this.data15,
      RdlyTaxDealHourField.data16 : this.data16,
      RdlyTaxDealHourField.data17 : this.data17,
      RdlyTaxDealHourField.data18 : this.data18,
      RdlyTaxDealHourField.data19 : this.data19,
      RdlyTaxDealHourField.data20 : this.data20,
      RdlyTaxDealHourField.data21 : this.data21,
    };
  }
}

/// 13_15 レジ・扱者日別時間帯税明細  rdly_tax_deal_hourのフィールド名設定用クラス
class RdlyTaxDealHourField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const chkr_no = "chkr_no";
  static const cshr_no = "cshr_no";
  static const sale_date = "sale_date";
  static const date_hour = "date_hour";
  static const mode = "mode";
  static const kind = "kind";
  static const sub = "sub";
  static const func_cd = "func_cd";
  static const data1 = "data1";
  static const data2 = "data2";
  static const data3 = "data3";
  static const data4 = "data4";
  static const data5 = "data5";
  static const data6 = "data6";
  static const data7 = "data7";
  static const data8 = "data8";
  static const data9 = "data9";
  static const data10 = "data10";
  static const data11 = "data11";
  static const data12 = "data12";
  static const data13 = "data13";
  static const data14 = "data14";
  static const data15 = "data15";
  static const data16 = "data16";
  static const data17 = "data17";
  static const data18 = "data18";
  static const data19 = "data19";
  static const data20 = "data20";
  static const data21 = "data21";
}
//endregion
//region 13_16	実績ワーク	wk_que
/// 13_16 実績ワーク  wk_queクラス
class WkQueColumns extends TableColumns{
  String? serial_no;
  int? pid;
  int? wk_step;
  String? endtime;

  @override
  String _getTableName() => "wk_que";

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
      WkQueColumns rn = WkQueColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.pid = maps[i]['pid'];
      rn.wk_step = maps[i]['wk_step'];
      rn.endtime = maps[i]['endtime'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    WkQueColumns rn = WkQueColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.pid = maps[0]['pid'];
    rn.wk_step = maps[0]['wk_step'];
    rn.endtime = maps[0]['endtime'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      WkQueField.serial_no : this.serial_no,
      WkQueField.pid : this.pid,
      WkQueField.wk_step : this.wk_step,
      WkQueField.endtime : this.endtime,
    };
  }
}

/// 13_16 実績ワーク  wk_queのフィールド名設定用クラス
class WkQueField {
  static const serial_no = "serial_no";
  static const pid = "pid";
  static const wk_step = "wk_step";
  static const endtime = "endtime";
}
//endregion