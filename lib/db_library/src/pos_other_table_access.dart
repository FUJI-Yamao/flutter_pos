/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
04_POS_その他
04_1	予約テーブル	c_reserv_tbl
04_2	公共料金_残高情報テーブル	p_pbchg_balance_tbl
04_3	公共料金_店舗情報テーブル	p_pbchg_stre_tbl
04_4	公共料金_収納企業情報テーブル	p_pbchg_corp_tbl
04_5	公共料金_端末別収納不可企業情報テーブル	p_pbchg_ncorp_tbl
04_6	公共料金_NTT東日本局番情報テーブル	p_pbchg_ntte_tbl
04_7	クレジット会社請求テーブル	c_crdt_demand_tbl
04_8	予約売価変更スケジュールマスタ	p_prcchg_sch_mst
04_9	予約売価変更商品マスタ	p_prcchg_item_mst
04_10	売価変更マスタ	p_prcchg_mst
04_11	ﾊﾞｯｸﾔｰﾄﾞ機器ﾏｽﾀ	s_backyard_grp_mst
04_12	Wiz情報テーブル	c_wiz_inf_tbl
04_13	パスポート情報マスタ	c_passport_info_mst
04_14	緊急ﾒﾝﾃﾅﾝｽｵﾌﾗｲﾝﾃｰﾌﾞﾙ	p_notfplu_off_tbl
 */

//region 04_1	予約テーブル	c_reserv_tbl
/// 04_1  予約テーブル c_reserv_tblクラス
class CReservTblColumns extends TableColumns{
  String? serial_no = '0';
  String? cust_no;
  String? last_name;
  String? first_name;
  String? tel_no1;
  String? tel_no2;
  String? post_no;
  String? address1;
  String? address2;
  String? address3;
  String? recept_date;
  String? ferry_date;
  String? arrival_date;
  int qty = 0;
  int ttl = 0;
  int advance_money = 0;
  String? memo1;
  String? memo2;
  int finish = 0;

  @override
  String _getTableName() => "c_reserv_tbl";

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
      CReservTblColumns rn = CReservTblColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.cust_no = maps[i]['cust_no'];
      rn.last_name = maps[i]['last_name'];
      rn.first_name = maps[i]['first_name'];
      rn.tel_no1 = maps[i]['tel_no1'];
      rn.tel_no2 = maps[i]['tel_no2'];
      rn.post_no = maps[i]['post_no'];
      rn.address1 = maps[i]['address1'];
      rn.address2 = maps[i]['address2'];
      rn.address3 = maps[i]['address3'];
      rn.recept_date = maps[i]['recept_date'];
      rn.ferry_date = maps[i]['ferry_date'];
      rn.arrival_date = maps[i]['arrival_date'];
      rn.qty = maps[i]['qty'];
      rn.ttl = maps[i]['ttl'];
      rn.advance_money = maps[i]['advance_money'];
      rn.memo1 = maps[i]['memo1'];
      rn.memo2 = maps[i]['memo2'];
      rn.finish = maps[i]['finish'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReservTblColumns rn = CReservTblColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.cust_no = maps[0]['cust_no'];
    rn.last_name = maps[0]['last_name'];
    rn.first_name = maps[0]['first_name'];
    rn.tel_no1 = maps[0]['tel_no1'];
    rn.tel_no2 = maps[0]['tel_no2'];
    rn.post_no = maps[0]['post_no'];
    rn.address1 = maps[0]['address1'];
    rn.address2 = maps[0]['address2'];
    rn.address3 = maps[0]['address3'];
    rn.recept_date = maps[0]['recept_date'];
    rn.ferry_date = maps[0]['ferry_date'];
    rn.arrival_date = maps[0]['arrival_date'];
    rn.qty = maps[0]['qty'];
    rn.ttl = maps[0]['ttl'];
    rn.advance_money = maps[0]['advance_money'];
    rn.memo1 = maps[0]['memo1'];
    rn.memo2 = maps[0]['memo2'];
    rn.finish = maps[0]['finish'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReservTblField.serial_no : this.serial_no,
      CReservTblField.cust_no : this.cust_no,
      CReservTblField.last_name : this.last_name,
      CReservTblField.first_name : this.first_name,
      CReservTblField.tel_no1 : this.tel_no1,
      CReservTblField.tel_no2 : this.tel_no2,
      CReservTblField.post_no : this.post_no,
      CReservTblField.address1 : this.address1,
      CReservTblField.address2 : this.address2,
      CReservTblField.address3 : this.address3,
      CReservTblField.recept_date : this.recept_date,
      CReservTblField.ferry_date : this.ferry_date,
      CReservTblField.arrival_date : this.arrival_date,
      CReservTblField.qty : this.qty,
      CReservTblField.ttl : this.ttl,
      CReservTblField.advance_money : this.advance_money,
      CReservTblField.memo1 : this.memo1,
      CReservTblField.memo2 : this.memo2,
      CReservTblField.finish : this.finish,
    };
  }
}

/// 04_1  予約テーブル c_reserv_tblのフィールド名設定用クラス
class CReservTblField {
  static const serial_no = "serial_no";
  static const cust_no = "cust_no";
  static const last_name = "last_name";
  static const first_name = "first_name";
  static const tel_no1 = "tel_no1";
  static const tel_no2 = "tel_no2";
  static const post_no = "post_no";
  static const address1 = "address1";
  static const address2 = "address2";
  static const address3 = "address3";
  static const recept_date = "recept_date";
  static const ferry_date = "ferry_date";
  static const arrival_date = "arrival_date";
  static const qty = "qty";
  static const ttl = "ttl";
  static const advance_money = "advance_money";
  static const memo1 = "memo1";
  static const memo2 = "memo2";
  static const finish = "finish";
}
//endregion
//region 04_2	公共料金_残高情報テーブル	p_pbchg_balance_tbl
/// 04_2  公共料金_残高情報テーブル  p_pbchg_balance_tblクラス
class PPbchgBalanceTblColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? groupcd;
  int? officecd;
  int dwn_balance = 0;
  int validflag = 0;
  int now_balance = 0;
  int pay_amt = 0;
  int settle_flg = 0;
  int fil1 = 0;
  int fil2 = 0;

  @override
  String _getTableName() => "p_pbchg_balance_tbl";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND groupcd = ? AND officecd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(groupcd);
    rn.add(officecd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPbchgBalanceTblColumns rn = PPbchgBalanceTblColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.groupcd = maps[i]['groupcd'];
      rn.officecd = maps[i]['officecd'];
      rn.dwn_balance = maps[i]['dwn_balance'];
      rn.validflag = maps[i]['validflag'];
      rn.now_balance = maps[i]['now_balance'];
      rn.pay_amt = maps[i]['pay_amt'];
      rn.settle_flg = maps[i]['settle_flg'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PPbchgBalanceTblColumns rn = PPbchgBalanceTblColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.groupcd = maps[0]['groupcd'];
    rn.officecd = maps[0]['officecd'];
    rn.dwn_balance = maps[0]['dwn_balance'];
    rn.validflag = maps[0]['validflag'];
    rn.now_balance = maps[0]['now_balance'];
    rn.pay_amt = maps[0]['pay_amt'];
    rn.settle_flg = maps[0]['settle_flg'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PPbchgBalanceTblField.comp_cd : this.comp_cd,
      PPbchgBalanceTblField.stre_cd : this.stre_cd,
      PPbchgBalanceTblField.groupcd : this.groupcd,
      PPbchgBalanceTblField.officecd : this.officecd,
      PPbchgBalanceTblField.dwn_balance : this.dwn_balance,
      PPbchgBalanceTblField.validflag : this.validflag,
      PPbchgBalanceTblField.now_balance : this.now_balance,
      PPbchgBalanceTblField.pay_amt : this.pay_amt,
      PPbchgBalanceTblField.settle_flg : this.settle_flg,
      PPbchgBalanceTblField.fil1 : this.fil1,
      PPbchgBalanceTblField.fil2 : this.fil2,
    };
  }
}

/// 04_2  公共料金_残高情報テーブル  p_pbchg_balance_tblのフィールド名設定用クラス
class PPbchgBalanceTblField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const groupcd = "groupcd";
  static const officecd = "officecd";
  static const dwn_balance = "dwn_balance";
  static const validflag = "validflag";
  static const now_balance = "now_balance";
  static const pay_amt = "pay_amt";
  static const settle_flg = "settle_flg";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
}
//endregion
//region 04_3	公共料金_店舗情報テーブル	p_pbchg_stre_tbl
/// 04_3  公共料金_店舗情報テーブル  p_pbchg_stre_tblクラス
class PPbchgStreTblColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? groupcd;
  int? officecd;
  int? strecd;
  int? termcd;
  int minimum = 0;
  int svcstopclassify = 0;
  int svcstopmoney = 0;
  int office_svcclassify = 0;
  int office_validflag = 0;
  String? office_changed;
  int stre_svcclassify = 0;
  int stre_validflag = 0;
  String? stre_changed;
  int eastclassify = 0;
  int westclassify = 0;
  int term_svcclassify = 0;
  int term_validflag = 0;
  String? term_changed;
  int fil1 = 0;
  int fil2 = 0;

  @override
  String _getTableName() => "p_pbchg_stre_tbl";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND groupcd = ? AND officecd = ? AND strecd = ? AND termcd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(groupcd);
    rn.add(officecd);
    rn.add(strecd);
    rn.add(termcd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPbchgStreTblColumns rn = PPbchgStreTblColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.groupcd = maps[i]['groupcd'];
      rn.officecd = maps[i]['officecd'];
      rn.strecd = maps[i]['strecd'];
      rn.termcd = maps[i]['termcd'];
      rn.minimum = maps[i]['minimum'];
      rn.svcstopclassify = maps[i]['svcstopclassify'];
      rn.svcstopmoney = maps[i]['svcstopmoney'];
      rn.office_svcclassify = maps[i]['office_svcclassify'];
      rn.office_validflag = maps[i]['office_validflag'];
      rn.office_changed = maps[i]['office_changed'];
      rn.stre_svcclassify = maps[i]['stre_svcclassify'];
      rn.stre_validflag = maps[i]['stre_validflag'];
      rn.stre_changed = maps[i]['stre_changed'];
      rn.eastclassify = maps[i]['eastclassify'];
      rn.westclassify = maps[i]['westclassify'];
      rn.term_svcclassify = maps[i]['term_svcclassify'];
      rn.term_validflag = maps[i]['term_validflag'];
      rn.term_changed = maps[i]['term_changed'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PPbchgStreTblColumns rn = PPbchgStreTblColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.groupcd = maps[0]['groupcd'];
    rn.officecd = maps[0]['officecd'];
    rn.strecd = maps[0]['strecd'];
    rn.termcd = maps[0]['termcd'];
    rn.minimum = maps[0]['minimum'];
    rn.svcstopclassify = maps[0]['svcstopclassify'];
    rn.svcstopmoney = maps[0]['svcstopmoney'];
    rn.office_svcclassify = maps[0]['office_svcclassify'];
    rn.office_validflag = maps[0]['office_validflag'];
    rn.office_changed = maps[0]['office_changed'];
    rn.stre_svcclassify = maps[0]['stre_svcclassify'];
    rn.stre_validflag = maps[0]['stre_validflag'];
    rn.stre_changed = maps[0]['stre_changed'];
    rn.eastclassify = maps[0]['eastclassify'];
    rn.westclassify = maps[0]['westclassify'];
    rn.term_svcclassify = maps[0]['term_svcclassify'];
    rn.term_validflag = maps[0]['term_validflag'];
    rn.term_changed = maps[0]['term_changed'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PPbchgStreTblField.comp_cd : this.comp_cd,
      PPbchgStreTblField.stre_cd : this.stre_cd,
      PPbchgStreTblField.groupcd : this.groupcd,
      PPbchgStreTblField.officecd : this.officecd,
      PPbchgStreTblField.strecd : this.strecd,
      PPbchgStreTblField.termcd : this.termcd,
      PPbchgStreTblField.minimum : this.minimum,
      PPbchgStreTblField.svcstopclassify : this.svcstopclassify,
      PPbchgStreTblField.svcstopmoney : this.svcstopmoney,
      PPbchgStreTblField.office_svcclassify : this.office_svcclassify,
      PPbchgStreTblField.office_validflag : this.office_validflag,
      PPbchgStreTblField.office_changed : this.office_changed,
      PPbchgStreTblField.stre_svcclassify : this.stre_svcclassify,
      PPbchgStreTblField.stre_validflag : this.stre_validflag,
      PPbchgStreTblField.stre_changed : this.stre_changed,
      PPbchgStreTblField.eastclassify : this.eastclassify,
      PPbchgStreTblField.westclassify : this.westclassify,
      PPbchgStreTblField.term_svcclassify : this.term_svcclassify,
      PPbchgStreTblField.term_validflag : this.term_validflag,
      PPbchgStreTblField.term_changed : this.term_changed,
      PPbchgStreTblField.fil1 : this.fil1,
      PPbchgStreTblField.fil2 : this.fil2,
    };
  }
}

/// 04_3  公共料金_店舗情報テーブル  p_pbchg_stre_tblのフィールド名設定用クラス
class PPbchgStreTblField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const groupcd = "groupcd";
  static const officecd = "officecd";
  static const strecd = "strecd";
  static const termcd = "termcd";
  static const minimum = "minimum";
  static const svcstopclassify = "svcstopclassify";
  static const svcstopmoney = "svcstopmoney";
  static const office_svcclassify = "office_svcclassify";
  static const office_validflag = "office_validflag";
  static const office_changed = "office_changed";
  static const stre_svcclassify = "stre_svcclassify";
  static const stre_validflag = "stre_validflag";
  static const stre_changed = "stre_changed";
  static const eastclassify = "eastclassify";
  static const westclassify = "westclassify";
  static const term_svcclassify = "term_svcclassify";
  static const term_validflag = "term_validflag";
  static const term_changed = "term_changed";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
}
//endregion
//region 04_4	公共料金_収納企業情報テーブル	p_pbchg_corp_tbl
/// 04_4  公共料金_収納企業情報テーブル  p_pbchg_corp_tblクラス
class PPbchgCorpTblColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? corpcd;
  int? subclassify;
  int? subcd;
  String? name;
  String? kana;
  int isntt = 0;
  int corp_svcclassify = 0;
  int corp_validflag = 0;
  String? corp_svcstart;
  int barcodekind = 0;
  int sclassify = 0;
  int sjclassify = 0;
  int sjmoney = 0;
  int sjcolumn = 0;
  int sjrow = 0;
  int pclassify = 0;
  int ddclassify = 0;
  int ddcolumn = 0;
  int ddrows = 0;
  int ddrowe = 0;
  int ddmethod = 0;
  int orgcolumn = 0;
  int orgrows = 0;
  int orgrowe = 0;
  int rclassify = 0;
  int fclassify = 0;
  int fmoney1 = 0;
  int funit1 = 0;
  int fee1 = 0;
  int fmoney2 = 0;
  int funit2 = 0;
  int fee2 = 0;
  int fmoney3 = 0;
  int funit3 = 0;
  int fee3 = 0;
  int fmoney4 = 0;
  int funit4 = 0;
  int fee4 = 0;
  int fmoney5 = 0;
  int funit5 = 0;
  int fee5 = 0;
  int limit_amt = 0;
  int decision_svcclassify = 0;
  int decision_validflag = 0;
  String? decision_changed;
  int fil1 = 0;
  int fil2 = 0;

  @override
  String _getTableName() => "p_pbchg_corp_tbl";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND corpcd = ? AND subclassify = ? AND subcd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(corpcd);
    rn.add(subclassify);
    rn.add(subcd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPbchgCorpTblColumns rn = PPbchgCorpTblColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.corpcd = maps[i]['corpcd'];
      rn.subclassify = maps[i]['subclassify'];
      rn.subcd = maps[i]['subcd'];
      rn.name = maps[i]['name'];
      rn.kana = maps[i]['kana'];
      rn.isntt = maps[i]['isntt'];
      rn.corp_svcclassify = maps[i]['corp_svcclassify'];
      rn.corp_validflag = maps[i]['corp_validflag'];
      rn.corp_svcstart = maps[i]['corp_svcstart'];
      rn.barcodekind = maps[i]['barcodekind'];
      rn.sclassify = maps[i]['sclassify'];
      rn.sjclassify = maps[i]['sjclassify'];
      rn.sjmoney = maps[i]['sjmoney'];
      rn.sjcolumn = maps[i]['sjcolumn'];
      rn.sjrow = maps[i]['sjrow'];
      rn.pclassify = maps[i]['pclassify'];
      rn.ddclassify = maps[i]['ddclassify'];
      rn.ddcolumn = maps[i]['ddcolumn'];
      rn.ddrows = maps[i]['ddrows'];
      rn.ddrowe = maps[i]['ddrowe'];
      rn.ddmethod = maps[i]['ddmethod'];
      rn.orgcolumn = maps[i]['orgcolumn'];
      rn.orgrows = maps[i]['orgrows'];
      rn.orgrowe = maps[i]['orgrowe'];
      rn.rclassify = maps[i]['rclassify'];
      rn.fclassify = maps[i]['fclassify'];
      rn.fmoney1 = maps[i]['fmoney1'];
      rn.funit1 = maps[i]['funit1'];
      rn.fee1 = maps[i]['fee1'];
      rn.fmoney2 = maps[i]['fmoney2'];
      rn.funit2 = maps[i]['funit2'];
      rn.fee2 = maps[i]['fee2'];
      rn.fmoney3 = maps[i]['fmoney3'];
      rn.funit3 = maps[i]['funit3'];
      rn.fee3 = maps[i]['fee3'];
      rn.fmoney4 = maps[i]['fmoney4'];
      rn.funit4 = maps[i]['funit4'];
      rn.fee4 = maps[i]['fee4'];
      rn.fmoney5 = maps[i]['fmoney5'];
      rn.funit5 = maps[i]['funit5'];
      rn.fee5 = maps[i]['fee5'];
      rn.limit_amt = maps[i]['limit_amt'];
      rn.decision_svcclassify = maps[i]['decision_svcclassify'];
      rn.decision_validflag = maps[i]['decision_validflag'];
      rn.decision_changed = maps[i]['decision_changed'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PPbchgCorpTblColumns rn = PPbchgCorpTblColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.corpcd = maps[0]['corpcd'];
    rn.subclassify = maps[0]['subclassify'];
    rn.subcd = maps[0]['subcd'];
    rn.name = maps[0]['name'];
    rn.kana = maps[0]['kana'];
    rn.isntt = maps[0]['isntt'];
    rn.corp_svcclassify = maps[0]['corp_svcclassify'];
    rn.corp_validflag = maps[0]['corp_validflag'];
    rn.corp_svcstart = maps[0]['corp_svcstart'];
    rn.barcodekind = maps[0]['barcodekind'];
    rn.sclassify = maps[0]['sclassify'];
    rn.sjclassify = maps[0]['sjclassify'];
    rn.sjmoney = maps[0]['sjmoney'];
    rn.sjcolumn = maps[0]['sjcolumn'];
    rn.sjrow = maps[0]['sjrow'];
    rn.pclassify = maps[0]['pclassify'];
    rn.ddclassify = maps[0]['ddclassify'];
    rn.ddcolumn = maps[0]['ddcolumn'];
    rn.ddrows = maps[0]['ddrows'];
    rn.ddrowe = maps[0]['ddrowe'];
    rn.ddmethod = maps[0]['ddmethod'];
    rn.orgcolumn = maps[0]['orgcolumn'];
    rn.orgrows = maps[0]['orgrows'];
    rn.orgrowe = maps[0]['orgrowe'];
    rn.rclassify = maps[0]['rclassify'];
    rn.fclassify = maps[0]['fclassify'];
    rn.fmoney1 = maps[0]['fmoney1'];
    rn.funit1 = maps[0]['funit1'];
    rn.fee1 = maps[0]['fee1'];
    rn.fmoney2 = maps[0]['fmoney2'];
    rn.funit2 = maps[0]['funit2'];
    rn.fee2 = maps[0]['fee2'];
    rn.fmoney3 = maps[0]['fmoney3'];
    rn.funit3 = maps[0]['funit3'];
    rn.fee3 = maps[0]['fee3'];
    rn.fmoney4 = maps[0]['fmoney4'];
    rn.funit4 = maps[0]['funit4'];
    rn.fee4 = maps[0]['fee4'];
    rn.fmoney5 = maps[0]['fmoney5'];
    rn.funit5 = maps[0]['funit5'];
    rn.fee5 = maps[0]['fee5'];
    rn.limit_amt = maps[0]['limit_amt'];
    rn.decision_svcclassify = maps[0]['decision_svcclassify'];
    rn.decision_validflag = maps[0]['decision_validflag'];
    rn.decision_changed = maps[0]['decision_changed'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PPbchgCorpTblField.comp_cd : this.comp_cd,
      PPbchgCorpTblField.stre_cd : this.stre_cd,
      PPbchgCorpTblField.corpcd : this.corpcd,
      PPbchgCorpTblField.subclassify : this.subclassify,
      PPbchgCorpTblField.subcd : this.subcd,
      PPbchgCorpTblField.name : this.name,
      PPbchgCorpTblField.kana : this.kana,
      PPbchgCorpTblField.isntt : this.isntt,
      PPbchgCorpTblField.corp_svcclassify : this.corp_svcclassify,
      PPbchgCorpTblField.corp_validflag : this.corp_validflag,
      PPbchgCorpTblField.corp_svcstart : this.corp_svcstart,
      PPbchgCorpTblField.barcodekind : this.barcodekind,
      PPbchgCorpTblField.sclassify : this.sclassify,
      PPbchgCorpTblField.sjclassify : this.sjclassify,
      PPbchgCorpTblField.sjmoney : this.sjmoney,
      PPbchgCorpTblField.sjcolumn : this.sjcolumn,
      PPbchgCorpTblField.sjrow : this.sjrow,
      PPbchgCorpTblField.pclassify : this.pclassify,
      PPbchgCorpTblField.ddclassify : this.ddclassify,
      PPbchgCorpTblField.ddcolumn : this.ddcolumn,
      PPbchgCorpTblField.ddrows : this.ddrows,
      PPbchgCorpTblField.ddrowe : this.ddrowe,
      PPbchgCorpTblField.ddmethod : this.ddmethod,
      PPbchgCorpTblField.orgcolumn : this.orgcolumn,
      PPbchgCorpTblField.orgrows : this.orgrows,
      PPbchgCorpTblField.orgrowe : this.orgrowe,
      PPbchgCorpTblField.rclassify : this.rclassify,
      PPbchgCorpTblField.fclassify : this.fclassify,
      PPbchgCorpTblField.fmoney1 : this.fmoney1,
      PPbchgCorpTblField.funit1 : this.funit1,
      PPbchgCorpTblField.fee1 : this.fee1,
      PPbchgCorpTblField.fmoney2 : this.fmoney2,
      PPbchgCorpTblField.funit2 : this.funit2,
      PPbchgCorpTblField.fee2 : this.fee2,
      PPbchgCorpTblField.fmoney3 : this.fmoney3,
      PPbchgCorpTblField.funit3 : this.funit3,
      PPbchgCorpTblField.fee3 : this.fee3,
      PPbchgCorpTblField.fmoney4 : this.fmoney4,
      PPbchgCorpTblField.funit4 : this.funit4,
      PPbchgCorpTblField.fee4 : this.fee4,
      PPbchgCorpTblField.fmoney5 : this.fmoney5,
      PPbchgCorpTblField.funit5 : this.funit5,
      PPbchgCorpTblField.fee5 : this.fee5,
      PPbchgCorpTblField.limit_amt : this.limit_amt,
      PPbchgCorpTblField.decision_svcclassify : this.decision_svcclassify,
      PPbchgCorpTblField.decision_validflag : this.decision_validflag,
      PPbchgCorpTblField.decision_changed : this.decision_changed,
      PPbchgCorpTblField.fil1 : this.fil1,
      PPbchgCorpTblField.fil2 : this.fil2,
    };
  }
}

/// 04_4  公共料金_収納企業情報テーブル  p_pbchg_corp_tblのフィールド名設定用クラス
class PPbchgCorpTblField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const corpcd = "corpcd";
  static const subclassify = "subclassify";
  static const subcd = "subcd";
  static const name = "name";
  static const kana = "kana";
  static const isntt = "isntt";
  static const corp_svcclassify = "corp_svcclassify";
  static const corp_validflag = "corp_validflag";
  static const corp_svcstart = "corp_svcstart";
  static const barcodekind = "barcodekind";
  static const sclassify = "sclassify";
  static const sjclassify = "sjclassify";
  static const sjmoney = "sjmoney";
  static const sjcolumn = "sjcolumn";
  static const sjrow = "sjrow";
  static const pclassify = "pclassify";
  static const ddclassify = "ddclassify";
  static const ddcolumn = "ddcolumn";
  static const ddrows = "ddrows";
  static const ddrowe = "ddrowe";
  static const ddmethod = "ddmethod";
  static const orgcolumn = "orgcolumn";
  static const orgrows = "orgrows";
  static const orgrowe = "orgrowe";
  static const rclassify = "rclassify";
  static const fclassify = "fclassify";
  static const fmoney1 = "fmoney1";
  static const funit1 = "funit1";
  static const fee1 = "fee1";
  static const fmoney2 = "fmoney2";
  static const funit2 = "funit2";
  static const fee2 = "fee2";
  static const fmoney3 = "fmoney3";
  static const funit3 = "funit3";
  static const fee3 = "fee3";
  static const fmoney4 = "fmoney4";
  static const funit4 = "funit4";
  static const fee4 = "fee4";
  static const fmoney5 = "fmoney5";
  static const funit5 = "funit5";
  static const fee5 = "fee5";
  static const limit_amt = "limit_amt";
  static const decision_svcclassify = "decision_svcclassify";
  static const decision_validflag = "decision_validflag";
  static const decision_changed = "decision_changed";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
}
//endregion
//region 04_5	公共料金_端末別収納不可企業情報テーブル	p_pbchg_ncorp_tbl
/// 04_5  公共料金_端末別収納不可企業情報テーブル p_pbchg_ncorp_tblクラス
class PPbchgNcorpTblColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? groupcd;
  int? officecd;
  int? strecd;
  int? termcd;
  int? corpcd;
  int? subcd;
  int validflag = 0;
  String? changed;
  int fil1 = 0;
  int fil2 = 0;

  @override
  String _getTableName() => "p_pbchg_ncorp_tbl";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND groupcd = ? AND officecd = ? AND strecd = ? AND termcd = ? AND corpcd = ? AND subcd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(groupcd);
    rn.add(officecd);
    rn.add(strecd);
    rn.add(termcd);
    rn.add(corpcd);
    rn.add(subcd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPbchgNcorpTblColumns rn = PPbchgNcorpTblColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.groupcd = maps[i]['groupcd'];
      rn.officecd = maps[i]['officecd'];
      rn.strecd = maps[i]['strecd'];
      rn.termcd = maps[i]['termcd'];
      rn.corpcd = maps[i]['corpcd'];
      rn.subcd = maps[i]['subcd'];
      rn.validflag = maps[i]['validflag'];
      rn.changed = maps[i]['changed'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PPbchgNcorpTblColumns rn = PPbchgNcorpTblColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.groupcd = maps[0]['groupcd'];
    rn.officecd = maps[0]['officecd'];
    rn.strecd = maps[0]['strecd'];
    rn.termcd = maps[0]['termcd'];
    rn.corpcd = maps[0]['corpcd'];
    rn.subcd = maps[0]['subcd'];
    rn.validflag = maps[0]['validflag'];
    rn.changed = maps[0]['changed'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PPbchgNcorpTblField.comp_cd : this.comp_cd,
      PPbchgNcorpTblField.stre_cd : this.stre_cd,
      PPbchgNcorpTblField.groupcd : this.groupcd,
      PPbchgNcorpTblField.officecd : this.officecd,
      PPbchgNcorpTblField.strecd : this.strecd,
      PPbchgNcorpTblField.termcd : this.termcd,
      PPbchgNcorpTblField.corpcd : this.corpcd,
      PPbchgNcorpTblField.subcd : this.subcd,
      PPbchgNcorpTblField.validflag : this.validflag,
      PPbchgNcorpTblField.changed : this.changed,
      PPbchgNcorpTblField.fil1 : this.fil1,
      PPbchgNcorpTblField.fil2 : this.fil2,
    };
  }
}

/// 04_5  公共料金_端末別収納不可企業情報テーブル p_pbchg_ncorp_tblのフィールド名設定用クラス
class PPbchgNcorpTblField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const groupcd = "groupcd";
  static const officecd = "officecd";
  static const strecd = "strecd";
  static const termcd = "termcd";
  static const corpcd = "corpcd";
  static const subcd = "subcd";
  static const validflag = "validflag";
  static const changed = "changed";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
}
//endregion
//region 04_6	公共料金_NTT東日本局番情報テーブル	p_pbchg_ntte_tbl
/// 04_6  公共料金_NTT東日本局番情報テーブル  p_pbchg_ntte_tblクラス
class PPbchgNtteTblColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int startno = 0;
  int endno = 0;
  int validflag = 0;
  String? changed;
  int fil1 = 0;
  int fil2 = 0;

  @override
  String _getTableName() => "p_pbchg_ntte_tbl";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPbchgNtteTblColumns rn = PPbchgNtteTblColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.startno = maps[i]['startno'];
      rn.endno = maps[i]['endno'];
      rn.validflag = maps[i]['validflag'];
      rn.changed = maps[i]['changed'];
      rn.fil1 = maps[i]['fil1'];
      rn.fil2 = maps[i]['fil2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PPbchgNtteTblColumns rn = PPbchgNtteTblColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.startno = maps[0]['startno'];
    rn.endno = maps[0]['endno'];
    rn.validflag = maps[0]['validflag'];
    rn.changed = maps[0]['changed'];
    rn.fil1 = maps[0]['fil1'];
    rn.fil2 = maps[0]['fil2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PPbchgNtteTblField.comp_cd : this.comp_cd,
      PPbchgNtteTblField.stre_cd : this.stre_cd,
      PPbchgNtteTblField.startno : this.startno,
      PPbchgNtteTblField.endno : this.endno,
      PPbchgNtteTblField.validflag : this.validflag,
      PPbchgNtteTblField.changed : this.changed,
      PPbchgNtteTblField.fil1 : this.fil1,
      PPbchgNtteTblField.fil2 : this.fil2,
    };
  }
}

/// 04_6  公共料金_NTT東日本局番情報テーブル  p_pbchg_ntte_tblのフィールド名設定用クラス
class PPbchgNtteTblField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const startno = "startno";
  static const endno = "endno";
  static const validflag = "validflag";
  static const changed = "changed";
  static const fil1 = "fil1";
  static const fil2 = "fil2";
}
//endregion
//region 04_7	クレジット会社請求テーブル	c_crdt_demand_tbl
/// 04_7  クレジット会社請求テーブル  c_crdt_demand_tblクラス
class CCrdtDemandTblColumns extends TableColumns{
  int? comp_cd = 0;
  int? card_kind = 0;
  int company_cd = 0;
  String? id;
  int business = 0;
  int mbr_no_from = 0;
  int mbr_no_to = 0;
  int mbr_no_position = 1;
  int mbr_no_digit = 1;
  int ckdigit_chk = 0;
  String? ckdigit_wait;
  String? card_company_name;
  int good_thru_position = 1;
  int pay_autoinput_chk = 0;
  int pay_shut_day = 1;
  int pay_day = 1;
  int lump = 0;
  int twice = 0;
  int divide = 0;
  int bonus_lump = 0;
  int bonus_twice = 0;
  int bonus_use = 0;
  int ribo = 0;
  int skip = 0;
  int divide3 = 0;
  int divide4 = 0;
  int divide5 = 0;
  int divide6 = 0;
  int divide7 = 0;
  int divide8 = 0;
  int divide9 = 0;
  int divide10 = 0;
  int divide11 = 0;
  int divide12 = 0;
  int divide15 = 0;
  int divide18 = 0;
  int divide20 = 0;
  int divide24 = 0;
  int divide25 = 0;
  int divide30 = 0;
  int divide35 = 0;
  int divide36 = 0;
  int divide3_limit = 0;
  int divide4_limit = 0;
  int divide5_limit = 0;
  int divide6_limit = 0;
  int divide7_limit = 0;
  int divide8_limit = 0;
  int divide9_limit = 0;
  int divide10_limit = 0;
  int divide11_limit = 0;
  int divide12_limit = 0;
  int divide15_limit = 0;
  int divide18_limit = 0;
  int divide20_limit = 0;
  int divide24_limit = 0;
  int divide25_limit = 0;
  int divide30_limit = 0;
  int divide35_limit = 0;
  int divide36_limit = 0;
  int bonus_use2 = 0;
  int bonus_use3 = 0;
  int bonus_use4 = 0;
  int bonus_use5 = 0;
  int bonus_use6 = 0;
  int bonus_use7 = 0;
  int bonus_use8 = 0;
  int bonus_use9 = 0;
  int bonus_use10 = 0;
  int bonus_use11 = 0;
  int bonus_use12 = 0;
  int bonus_use15 = 0;
  int bonus_use18 = 0;
  int bonus_use20 = 0;
  int bonus_use24 = 0;
  int bonus_use25 = 0;
  int bonus_use30 = 0;
  int bonus_use35 = 0;
  int bonus_use36 = 0;
  int bonus_use2_limit = 0;
  int bonus_use3_limit = 0;
  int bonus_use4_limit = 0;
  int bonus_use5_limit = 0;
  int bonus_use6_limit = 0;
  int bonus_use7_limit = 0;
  int bonus_use8_limit = 0;
  int bonus_use9_limit = 0;
  int bonus_use10_limit = 0;
  int bonus_use11_limit = 0;
  int bonus_use12_limit = 0;
  int bonus_use15_limit = 0;
  int bonus_use18_limit = 0;
  int bonus_use20_limit = 0;
  int bonus_use24_limit = 0;
  int bonus_use25_limit = 0;
  int bonus_use30_limit = 0;
  int bonus_use35_limit = 0;
  int bonus_use36_limit = 0;
  int pay_input_chk = 0;
  int winter_bonus_from = 0;
  int winter_bonus_to = 0;
  int winter_bonus_pay1 = 0;
  int winter_bonus_pay2 = 0;
  int winter_bonus_pay3 = 0;
  int summer_bonus_from = 0;
  int summer_bonus_to = 0;
  int summer_bonus_pay1 = 0;
  int summer_bonus_pay2 = 0;
  int summer_bonus_pay3 = 0;
  int bonus_lump_limit = 0;
  int bonus_twice_limit = 0;
  int offline_limit = 0;
  int card_jis = 0;
  String? ins_datetime;
  String? upd_datetime;
  int? status;
  int? send_flg;
  int upd_user = 0;
  int? upd_system;
  int company_cd_to = 0;
  int stlcrdtdsc_per = 0;
  int mkr_cd = 0;
  String? destination;
  int signless_flg = 0;
  int coopcode1 = 0;
  int coopcode2 = 0;
  int coopcode3 = 0;
  int bonus_add_input_chk = 0;
  int bonus_cnt_input_chk = 0;
  int bonus_cnt = 0;
  int paymonth_input_chk = 0;
  int sign_amt = 0;
  int effect_code = 0;
  int fil1 = 0;

  @override
  String _getTableName() => "c_crdt_demand_tbl";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND card_kind = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(card_kind);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCrdtDemandTblColumns rn = CCrdtDemandTblColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.card_kind = maps[i]['card_kind'];
      rn.company_cd = maps[i]['company_cd'];
      rn.id = maps[i]['id'];
      rn.business = maps[i]['business'];
      rn.mbr_no_from = maps[i]['mbr_no_from'];
      rn.mbr_no_to = maps[i]['mbr_no_to'];
      rn.mbr_no_position = maps[i]['mbr_no_position'];
      rn.mbr_no_digit = maps[i]['mbr_no_digit'];
      rn.ckdigit_chk = maps[i]['ckdigit_chk'];
      rn.ckdigit_wait = maps[i]['ckdigit_wait'];
      rn.card_company_name = maps[i]['card_company_name'];
      rn.good_thru_position = maps[i]['good_thru_position'];
      rn.pay_autoinput_chk = maps[i]['pay_autoinput_chk'];
      rn.pay_shut_day = maps[i]['pay_shut_day'];
      rn.pay_day = maps[i]['pay_day'];
      rn.lump = maps[i]['lump'];
      rn.twice = maps[i]['twice'];
      rn.divide = maps[i]['divide'];
      rn.bonus_lump = maps[i]['bonus_lump'];
      rn.bonus_twice = maps[i]['bonus_twice'];
      rn.bonus_use = maps[i]['bonus_use'];
      rn.ribo = maps[i]['ribo'];
      rn.skip = maps[i]['skip'];
      rn.divide3 = maps[i]['divide3'];
      rn.divide4 = maps[i]['divide4'];
      rn.divide5 = maps[i]['divide5'];
      rn.divide6 = maps[i]['divide6'];
      rn.divide7 = maps[i]['divide7'];
      rn.divide8 = maps[i]['divide8'];
      rn.divide9 = maps[i]['divide9'];
      rn.divide10 = maps[i]['divide10'];
      rn.divide11 = maps[i]['divide11'];
      rn.divide12 = maps[i]['divide12'];
      rn.divide15 = maps[i]['divide15'];
      rn.divide18 = maps[i]['divide18'];
      rn.divide20 = maps[i]['divide20'];
      rn.divide24 = maps[i]['divide24'];
      rn.divide25 = maps[i]['divide25'];
      rn.divide30 = maps[i]['divide30'];
      rn.divide35 = maps[i]['divide35'];
      rn.divide36 = maps[i]['divide36'];
      rn.divide3_limit = maps[i]['divide3_limit'];
      rn.divide4_limit = maps[i]['divide4_limit'];
      rn.divide5_limit = maps[i]['divide5_limit'];
      rn.divide6_limit = maps[i]['divide6_limit'];
      rn.divide7_limit = maps[i]['divide7_limit'];
      rn.divide8_limit = maps[i]['divide8_limit'];
      rn.divide9_limit = maps[i]['divide9_limit'];
      rn.divide10_limit = maps[i]['divide10_limit'];
      rn.divide11_limit = maps[i]['divide11_limit'];
      rn.divide12_limit = maps[i]['divide12_limit'];
      rn.divide15_limit = maps[i]['divide15_limit'];
      rn.divide18_limit = maps[i]['divide18_limit'];
      rn.divide20_limit = maps[i]['divide20_limit'];
      rn.divide24_limit = maps[i]['divide24_limit'];
      rn.divide25_limit = maps[i]['divide25_limit'];
      rn.divide30_limit = maps[i]['divide30_limit'];
      rn.divide35_limit = maps[i]['divide35_limit'];
      rn.divide36_limit = maps[i]['divide36_limit'];
      rn.bonus_use2 = maps[i]['bonus_use2'];
      rn.bonus_use3 = maps[i]['bonus_use3'];
      rn.bonus_use4 = maps[i]['bonus_use4'];
      rn.bonus_use5 = maps[i]['bonus_use5'];
      rn.bonus_use6 = maps[i]['bonus_use6'];
      rn.bonus_use7 = maps[i]['bonus_use7'];
      rn.bonus_use8 = maps[i]['bonus_use8'];
      rn.bonus_use9 = maps[i]['bonus_use9'];
      rn.bonus_use10 = maps[i]['bonus_use10'];
      rn.bonus_use11 = maps[i]['bonus_use11'];
      rn.bonus_use12 = maps[i]['bonus_use12'];
      rn.bonus_use15 = maps[i]['bonus_use15'];
      rn.bonus_use18 = maps[i]['bonus_use18'];
      rn.bonus_use20 = maps[i]['bonus_use20'];
      rn.bonus_use24 = maps[i]['bonus_use24'];
      rn.bonus_use25 = maps[i]['bonus_use25'];
      rn.bonus_use30 = maps[i]['bonus_use30'];
      rn.bonus_use35 = maps[i]['bonus_use35'];
      rn.bonus_use36 = maps[i]['bonus_use36'];
      rn.bonus_use2_limit = maps[i]['bonus_use2_limit'];
      rn.bonus_use3_limit = maps[i]['bonus_use3_limit'];
      rn.bonus_use4_limit = maps[i]['bonus_use4_limit'];
      rn.bonus_use5_limit = maps[i]['bonus_use5_limit'];
      rn.bonus_use6_limit = maps[i]['bonus_use6_limit'];
      rn.bonus_use7_limit = maps[i]['bonus_use7_limit'];
      rn.bonus_use8_limit = maps[i]['bonus_use8_limit'];
      rn.bonus_use9_limit = maps[i]['bonus_use9_limit'];
      rn.bonus_use10_limit = maps[i]['bonus_use10_limit'];
      rn.bonus_use11_limit = maps[i]['bonus_use11_limit'];
      rn.bonus_use12_limit = maps[i]['bonus_use12_limit'];
      rn.bonus_use15_limit = maps[i]['bonus_use15_limit'];
      rn.bonus_use18_limit = maps[i]['bonus_use18_limit'];
      rn.bonus_use20_limit = maps[i]['bonus_use20_limit'];
      rn.bonus_use24_limit = maps[i]['bonus_use24_limit'];
      rn.bonus_use25_limit = maps[i]['bonus_use25_limit'];
      rn.bonus_use30_limit = maps[i]['bonus_use30_limit'];
      rn.bonus_use35_limit = maps[i]['bonus_use35_limit'];
      rn.bonus_use36_limit = maps[i]['bonus_use36_limit'];
      rn.pay_input_chk = maps[i]['pay_input_chk'];
      rn.winter_bonus_from = maps[i]['winter_bonus_from'];
      rn.winter_bonus_to = maps[i]['winter_bonus_to'];
      rn.winter_bonus_pay1 = maps[i]['winter_bonus_pay1'];
      rn.winter_bonus_pay2 = maps[i]['winter_bonus_pay2'];
      rn.winter_bonus_pay3 = maps[i]['winter_bonus_pay3'];
      rn.summer_bonus_from = maps[i]['summer_bonus_from'];
      rn.summer_bonus_to = maps[i]['summer_bonus_to'];
      rn.summer_bonus_pay1 = maps[i]['summer_bonus_pay1'];
      rn.summer_bonus_pay2 = maps[i]['summer_bonus_pay2'];
      rn.summer_bonus_pay3 = maps[i]['summer_bonus_pay3'];
      rn.bonus_lump_limit = maps[i]['bonus_lump_limit'];
      rn.bonus_twice_limit = maps[i]['bonus_twice_limit'];
      rn.offline_limit = maps[i]['offline_limit'];
      rn.card_jis = maps[i]['card_jis'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.company_cd_to = maps[i]['company_cd_to'];
      rn.stlcrdtdsc_per = maps[i]['stlcrdtdsc_per'];
      rn.mkr_cd = maps[i]['mkr_cd'];
      rn.destination = maps[i]['destination'];
      rn.signless_flg = maps[i]['signless_flg'];
      rn.coopcode1 = maps[i]['coopcode1'];
      rn.coopcode2 = maps[i]['coopcode2'];
      rn.coopcode3 = maps[i]['coopcode3'];
      rn.bonus_add_input_chk = maps[i]['bonus_add_input_chk'];
      rn.bonus_cnt_input_chk = maps[i]['bonus_cnt_input_chk'];
      rn.bonus_cnt = maps[i]['bonus_cnt'];
      rn.paymonth_input_chk = maps[i]['paymonth_input_chk'];
      rn.sign_amt = maps[i]['sign_amt'];
      rn.effect_code = maps[i]['effect_code'];
      rn.fil1 = maps[i]['fil1'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CCrdtDemandTblColumns rn = CCrdtDemandTblColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.card_kind = maps[0]['card_kind'];
    rn.company_cd = maps[0]['company_cd'];
    rn.id = maps[0]['id'];
    rn.business = maps[0]['business'];
    rn.mbr_no_from = maps[0]['mbr_no_from'];
    rn.mbr_no_to = maps[0]['mbr_no_to'];
    rn.mbr_no_position = maps[0]['mbr_no_position'];
    rn.mbr_no_digit = maps[0]['mbr_no_digit'];
    rn.ckdigit_chk = maps[0]['ckdigit_chk'];
    rn.ckdigit_wait = maps[0]['ckdigit_wait'];
    rn.card_company_name = maps[0]['card_company_name'];
    rn.good_thru_position = maps[0]['good_thru_position'];
    rn.pay_autoinput_chk = maps[0]['pay_autoinput_chk'];
    rn.pay_shut_day = maps[0]['pay_shut_day'];
    rn.pay_day = maps[0]['pay_day'];
    rn.lump = maps[0]['lump'];
    rn.twice = maps[0]['twice'];
    rn.divide = maps[0]['divide'];
    rn.bonus_lump = maps[0]['bonus_lump'];
    rn.bonus_twice = maps[0]['bonus_twice'];
    rn.bonus_use = maps[0]['bonus_use'];
    rn.ribo = maps[0]['ribo'];
    rn.skip = maps[0]['skip'];
    rn.divide3 = maps[0]['divide3'];
    rn.divide4 = maps[0]['divide4'];
    rn.divide5 = maps[0]['divide5'];
    rn.divide6 = maps[0]['divide6'];
    rn.divide7 = maps[0]['divide7'];
    rn.divide8 = maps[0]['divide8'];
    rn.divide9 = maps[0]['divide9'];
    rn.divide10 = maps[0]['divide10'];
    rn.divide11 = maps[0]['divide11'];
    rn.divide12 = maps[0]['divide12'];
    rn.divide15 = maps[0]['divide15'];
    rn.divide18 = maps[0]['divide18'];
    rn.divide20 = maps[0]['divide20'];
    rn.divide24 = maps[0]['divide24'];
    rn.divide25 = maps[0]['divide25'];
    rn.divide30 = maps[0]['divide30'];
    rn.divide35 = maps[0]['divide35'];
    rn.divide36 = maps[0]['divide36'];
    rn.divide3_limit = maps[0]['divide3_limit'];
    rn.divide4_limit = maps[0]['divide4_limit'];
    rn.divide5_limit = maps[0]['divide5_limit'];
    rn.divide6_limit = maps[0]['divide6_limit'];
    rn.divide7_limit = maps[0]['divide7_limit'];
    rn.divide8_limit = maps[0]['divide8_limit'];
    rn.divide9_limit = maps[0]['divide9_limit'];
    rn.divide10_limit = maps[0]['divide10_limit'];
    rn.divide11_limit = maps[0]['divide11_limit'];
    rn.divide12_limit = maps[0]['divide12_limit'];
    rn.divide15_limit = maps[0]['divide15_limit'];
    rn.divide18_limit = maps[0]['divide18_limit'];
    rn.divide20_limit = maps[0]['divide20_limit'];
    rn.divide24_limit = maps[0]['divide24_limit'];
    rn.divide25_limit = maps[0]['divide25_limit'];
    rn.divide30_limit = maps[0]['divide30_limit'];
    rn.divide35_limit = maps[0]['divide35_limit'];
    rn.divide36_limit = maps[0]['divide36_limit'];
    rn.bonus_use2 = maps[0]['bonus_use2'];
    rn.bonus_use3 = maps[0]['bonus_use3'];
    rn.bonus_use4 = maps[0]['bonus_use4'];
    rn.bonus_use5 = maps[0]['bonus_use5'];
    rn.bonus_use6 = maps[0]['bonus_use6'];
    rn.bonus_use7 = maps[0]['bonus_use7'];
    rn.bonus_use8 = maps[0]['bonus_use8'];
    rn.bonus_use9 = maps[0]['bonus_use9'];
    rn.bonus_use10 = maps[0]['bonus_use10'];
    rn.bonus_use11 = maps[0]['bonus_use11'];
    rn.bonus_use12 = maps[0]['bonus_use12'];
    rn.bonus_use15 = maps[0]['bonus_use15'];
    rn.bonus_use18 = maps[0]['bonus_use18'];
    rn.bonus_use20 = maps[0]['bonus_use20'];
    rn.bonus_use24 = maps[0]['bonus_use24'];
    rn.bonus_use25 = maps[0]['bonus_use25'];
    rn.bonus_use30 = maps[0]['bonus_use30'];
    rn.bonus_use35 = maps[0]['bonus_use35'];
    rn.bonus_use36 = maps[0]['bonus_use36'];
    rn.bonus_use2_limit = maps[0]['bonus_use2_limit'];
    rn.bonus_use3_limit = maps[0]['bonus_use3_limit'];
    rn.bonus_use4_limit = maps[0]['bonus_use4_limit'];
    rn.bonus_use5_limit = maps[0]['bonus_use5_limit'];
    rn.bonus_use6_limit = maps[0]['bonus_use6_limit'];
    rn.bonus_use7_limit = maps[0]['bonus_use7_limit'];
    rn.bonus_use8_limit = maps[0]['bonus_use8_limit'];
    rn.bonus_use9_limit = maps[0]['bonus_use9_limit'];
    rn.bonus_use10_limit = maps[0]['bonus_use10_limit'];
    rn.bonus_use11_limit = maps[0]['bonus_use11_limit'];
    rn.bonus_use12_limit = maps[0]['bonus_use12_limit'];
    rn.bonus_use15_limit = maps[0]['bonus_use15_limit'];
    rn.bonus_use18_limit = maps[0]['bonus_use18_limit'];
    rn.bonus_use20_limit = maps[0]['bonus_use20_limit'];
    rn.bonus_use24_limit = maps[0]['bonus_use24_limit'];
    rn.bonus_use25_limit = maps[0]['bonus_use25_limit'];
    rn.bonus_use30_limit = maps[0]['bonus_use30_limit'];
    rn.bonus_use35_limit = maps[0]['bonus_use35_limit'];
    rn.bonus_use36_limit = maps[0]['bonus_use36_limit'];
    rn.pay_input_chk = maps[0]['pay_input_chk'];
    rn.winter_bonus_from = maps[0]['winter_bonus_from'];
    rn.winter_bonus_to = maps[0]['winter_bonus_to'];
    rn.winter_bonus_pay1 = maps[0]['winter_bonus_pay1'];
    rn.winter_bonus_pay2 = maps[0]['winter_bonus_pay2'];
    rn.winter_bonus_pay3 = maps[0]['winter_bonus_pay3'];
    rn.summer_bonus_from = maps[0]['summer_bonus_from'];
    rn.summer_bonus_to = maps[0]['summer_bonus_to'];
    rn.summer_bonus_pay1 = maps[0]['summer_bonus_pay1'];
    rn.summer_bonus_pay2 = maps[0]['summer_bonus_pay2'];
    rn.summer_bonus_pay3 = maps[0]['summer_bonus_pay3'];
    rn.bonus_lump_limit = maps[0]['bonus_lump_limit'];
    rn.bonus_twice_limit = maps[0]['bonus_twice_limit'];
    rn.offline_limit = maps[0]['offline_limit'];
    rn.card_jis = maps[0]['card_jis'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.company_cd_to = maps[0]['company_cd_to'];
    rn.stlcrdtdsc_per = maps[0]['stlcrdtdsc_per'];
    rn.mkr_cd = maps[0]['mkr_cd'];
    rn.destination = maps[0]['destination'];
    rn.signless_flg = maps[0]['signless_flg'];
    rn.coopcode1 = maps[0]['coopcode1'];
    rn.coopcode2 = maps[0]['coopcode2'];
    rn.coopcode3 = maps[0]['coopcode3'];
    rn.bonus_add_input_chk = maps[0]['bonus_add_input_chk'];
    rn.bonus_cnt_input_chk = maps[0]['bonus_cnt_input_chk'];
    rn.bonus_cnt = maps[0]['bonus_cnt'];
    rn.paymonth_input_chk = maps[0]['paymonth_input_chk'];
    rn.sign_amt = maps[0]['sign_amt'];
    rn.effect_code = maps[0]['effect_code'];
    rn.fil1 = maps[0]['fil1'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
    CCrdtDemandTblField.comp_cd : this.comp_cd,
    CCrdtDemandTblField.card_kind : this.card_kind,
    CCrdtDemandTblField.company_cd : this.company_cd,
    CCrdtDemandTblField.id : this.id,
    CCrdtDemandTblField.business : this.business,
    CCrdtDemandTblField.mbr_no_from : this.mbr_no_from,
    CCrdtDemandTblField.mbr_no_to : this.mbr_no_to,
    CCrdtDemandTblField.mbr_no_position : this.mbr_no_position,
    CCrdtDemandTblField.mbr_no_digit : this.mbr_no_digit,
    CCrdtDemandTblField.ckdigit_chk : this.ckdigit_chk,
    CCrdtDemandTblField.ckdigit_wait : this.ckdigit_wait,
    CCrdtDemandTblField.card_company_name : this.card_company_name,
    CCrdtDemandTblField.good_thru_position : this.good_thru_position,
    CCrdtDemandTblField.pay_autoinput_chk : this.pay_autoinput_chk,
    CCrdtDemandTblField.pay_shut_day : this.pay_shut_day,
    CCrdtDemandTblField.pay_day : this.pay_day,
    CCrdtDemandTblField.lump : this.lump,
    CCrdtDemandTblField.twice : this.twice,
    CCrdtDemandTblField.divide : this.divide,
    CCrdtDemandTblField.bonus_lump : this.bonus_lump,
    CCrdtDemandTblField.bonus_twice : this.bonus_twice,
    CCrdtDemandTblField.bonus_use : this.bonus_use,
    CCrdtDemandTblField.ribo : this.ribo,
    CCrdtDemandTblField.skip : this.skip,
    CCrdtDemandTblField.divide3 : this.divide3,
    CCrdtDemandTblField.divide4 : this.divide4,
    CCrdtDemandTblField.divide5 : this.divide5,
    CCrdtDemandTblField.divide6 : this.divide6,
    CCrdtDemandTblField.divide7 : this.divide7,
    CCrdtDemandTblField.divide8 : this.divide8,
    CCrdtDemandTblField.divide9 : this.divide9,
    CCrdtDemandTblField.divide10 : this.divide10,
    CCrdtDemandTblField.divide11 : this.divide11,
    CCrdtDemandTblField.divide12 : this.divide12,
    CCrdtDemandTblField.divide15 : this.divide15,
    CCrdtDemandTblField.divide18 : this.divide18,
    CCrdtDemandTblField.divide20 : this.divide20,
    CCrdtDemandTblField.divide24 : this.divide24,
    CCrdtDemandTblField.divide25 : this.divide25,
    CCrdtDemandTblField.divide30 : this.divide30,
    CCrdtDemandTblField.divide35 : this.divide35,
    CCrdtDemandTblField.divide36 : this.divide36,
    CCrdtDemandTblField.divide3_limit : this.divide3_limit,
    CCrdtDemandTblField.divide4_limit : this.divide4_limit,
    CCrdtDemandTblField.divide5_limit : this.divide5_limit,
    CCrdtDemandTblField.divide6_limit : this.divide6_limit,
    CCrdtDemandTblField.divide7_limit : this.divide7_limit,
    CCrdtDemandTblField.divide8_limit : this.divide8_limit,
    CCrdtDemandTblField.divide9_limit : this.divide9_limit,
    CCrdtDemandTblField.divide10_limit : this.divide10_limit,
    CCrdtDemandTblField.divide11_limit : this.divide11_limit,
    CCrdtDemandTblField.divide12_limit : this.divide12_limit,
    CCrdtDemandTblField.divide15_limit : this.divide15_limit,
    CCrdtDemandTblField.divide18_limit : this.divide18_limit,
    CCrdtDemandTblField.divide20_limit : this.divide20_limit,
    CCrdtDemandTblField.divide24_limit : this.divide24_limit,
    CCrdtDemandTblField.divide25_limit : this.divide25_limit,
    CCrdtDemandTblField.divide30_limit : this.divide30_limit,
    CCrdtDemandTblField.divide35_limit : this.divide35_limit,
    CCrdtDemandTblField.divide36_limit : this.divide36_limit,
    CCrdtDemandTblField.bonus_use2 : this.bonus_use2,
    CCrdtDemandTblField.bonus_use3 : this.bonus_use3,
    CCrdtDemandTblField.bonus_use4 : this.bonus_use4,
    CCrdtDemandTblField.bonus_use5 : this.bonus_use5,
    CCrdtDemandTblField.bonus_use6 : this.bonus_use6,
    CCrdtDemandTblField.bonus_use7 : this.bonus_use7,
    CCrdtDemandTblField.bonus_use8 : this.bonus_use8,
    CCrdtDemandTblField.bonus_use9 : this.bonus_use9,
    CCrdtDemandTblField.bonus_use10 : this.bonus_use10,
    CCrdtDemandTblField.bonus_use11 : this.bonus_use11,
    CCrdtDemandTblField.bonus_use12 : this.bonus_use12,
    CCrdtDemandTblField.bonus_use15 : this.bonus_use15,
    CCrdtDemandTblField.bonus_use18 : this.bonus_use18,
    CCrdtDemandTblField.bonus_use20 : this.bonus_use20,
    CCrdtDemandTblField.bonus_use24 : this.bonus_use24,
    CCrdtDemandTblField.bonus_use25 : this.bonus_use25,
    CCrdtDemandTblField.bonus_use30 : this.bonus_use30,
    CCrdtDemandTblField.bonus_use35 : this.bonus_use35,
    CCrdtDemandTblField.bonus_use36 : this.bonus_use36,
    CCrdtDemandTblField.bonus_use2_limit : this.bonus_use2_limit,
    CCrdtDemandTblField.bonus_use3_limit : this.bonus_use3_limit,
    CCrdtDemandTblField.bonus_use4_limit : this.bonus_use4_limit,
    CCrdtDemandTblField.bonus_use5_limit : this.bonus_use5_limit,
    CCrdtDemandTblField.bonus_use6_limit : this.bonus_use6_limit,
    CCrdtDemandTblField.bonus_use7_limit : this.bonus_use7_limit,
    CCrdtDemandTblField.bonus_use8_limit : this.bonus_use8_limit,
    CCrdtDemandTblField.bonus_use9_limit : this.bonus_use9_limit,
    CCrdtDemandTblField.bonus_use10_limit : this.bonus_use10_limit,
    CCrdtDemandTblField.bonus_use11_limit : this.bonus_use11_limit,
    CCrdtDemandTblField.bonus_use12_limit : this.bonus_use12_limit,
    CCrdtDemandTblField.bonus_use15_limit : this.bonus_use15_limit,
    CCrdtDemandTblField.bonus_use18_limit : this.bonus_use18_limit,
    CCrdtDemandTblField.bonus_use20_limit : this.bonus_use20_limit,
    CCrdtDemandTblField.bonus_use24_limit : this.bonus_use24_limit,
    CCrdtDemandTblField.bonus_use25_limit : this.bonus_use25_limit,
    CCrdtDemandTblField.bonus_use30_limit : this.bonus_use30_limit,
    CCrdtDemandTblField.bonus_use35_limit : this.bonus_use35_limit,
    CCrdtDemandTblField.bonus_use36_limit : this.bonus_use36_limit,
    CCrdtDemandTblField.pay_input_chk : this.pay_input_chk,
    CCrdtDemandTblField.winter_bonus_from : this.winter_bonus_from,
    CCrdtDemandTblField.winter_bonus_to : this.winter_bonus_to,
    CCrdtDemandTblField.winter_bonus_pay1 : this.winter_bonus_pay1,
    CCrdtDemandTblField.winter_bonus_pay2 : this.winter_bonus_pay2,
    CCrdtDemandTblField.winter_bonus_pay3 : this.winter_bonus_pay3,
    CCrdtDemandTblField.summer_bonus_from : this.summer_bonus_from,
    CCrdtDemandTblField.summer_bonus_to : this.summer_bonus_to,
    CCrdtDemandTblField.summer_bonus_pay1 : this.summer_bonus_pay1,
    CCrdtDemandTblField.summer_bonus_pay2 : this.summer_bonus_pay2,
    CCrdtDemandTblField.summer_bonus_pay3 : this.summer_bonus_pay3,
    CCrdtDemandTblField.bonus_lump_limit : this.bonus_lump_limit,
    CCrdtDemandTblField.bonus_twice_limit : this.bonus_twice_limit,
    CCrdtDemandTblField.offline_limit : this.offline_limit,
    CCrdtDemandTblField.card_jis : this.card_jis,
    CCrdtDemandTblField.ins_datetime : this.ins_datetime,
    CCrdtDemandTblField.upd_datetime : this.upd_datetime,
    CCrdtDemandTblField.status : this.status,
    CCrdtDemandTblField.send_flg : this.send_flg,
    CCrdtDemandTblField.upd_user : this.upd_user,
    CCrdtDemandTblField.upd_system : this.upd_system,
    CCrdtDemandTblField.company_cd_to : this.company_cd_to,
    CCrdtDemandTblField.stlcrdtdsc_per : this.stlcrdtdsc_per,
    CCrdtDemandTblField.mkr_cd : this.mkr_cd,
    CCrdtDemandTblField.destination : this.destination,
    CCrdtDemandTblField.signless_flg : this.signless_flg,
    CCrdtDemandTblField.coopcode1 : this.coopcode1,
    CCrdtDemandTblField.coopcode2 : this.coopcode2,
    CCrdtDemandTblField.coopcode3 : this.coopcode3,
    CCrdtDemandTblField.bonus_add_input_chk : this.bonus_add_input_chk,
    CCrdtDemandTblField.bonus_cnt_input_chk : this.bonus_cnt_input_chk,
    CCrdtDemandTblField.bonus_cnt : this.bonus_cnt,
    CCrdtDemandTblField.paymonth_input_chk : this.paymonth_input_chk,
    CCrdtDemandTblField.sign_amt : this.sign_amt,
    CCrdtDemandTblField.effect_code : this.effect_code,
    CCrdtDemandTblField.fil1 : this.fil1,
    };
  }
}

/// 04_7  クレジット会社請求テーブル  c_crdt_demand_tblのフィールド名設定用クラス
class CCrdtDemandTblField {
  static const comp_cd = "comp_cd";
  static const card_kind = "card_kind";
  static const company_cd = "company_cd";
  static const id = "id";
  static const business = "business";
  static const mbr_no_from = "mbr_no_from";
  static const mbr_no_to = "mbr_no_to";
  static const mbr_no_position = "mbr_no_position";
  static const mbr_no_digit = "mbr_no_digit";
  static const ckdigit_chk = "ckdigit_chk";
  static const ckdigit_wait = "ckdigit_wait";
  static const card_company_name = "card_company_name";
  static const good_thru_position = "good_thru_position";
  static const pay_autoinput_chk = "pay_autoinput_chk";
  static const pay_shut_day = "pay_shut_day";
  static const pay_day = "pay_day";
  static const lump = "lump";
  static const twice = "twice";
  static const divide = "divide";
  static const bonus_lump = "bonus_lump";
  static const bonus_twice = "bonus_twice";
  static const bonus_use = "bonus_use";
  static const ribo = "ribo";
  static const skip = "skip";
  static const divide3 = "divide3";
  static const divide4 = "divide4";
  static const divide5 = "divide5";
  static const divide6 = "divide6";
  static const divide7 = "divide7";
  static const divide8 = "divide8";
  static const divide9 = "divide9";
  static const divide10 = "divide10";
  static const divide11 = "divide11";
  static const divide12 = "divide12";
  static const divide15 = "divide15";
  static const divide18 = "divide18";
  static const divide20 = "divide20";
  static const divide24 = "divide24";
  static const divide25 = "divide25";
  static const divide30 = "divide30";
  static const divide35 = "divide35";
  static const divide36 = "divide36";
  static const divide3_limit = "divide3_limit";
  static const divide4_limit = "divide4_limit";
  static const divide5_limit = "divide5_limit";
  static const divide6_limit = "divide6_limit";
  static const divide7_limit = "divide7_limit";
  static const divide8_limit = "divide8_limit";
  static const divide9_limit = "divide9_limit";
  static const divide10_limit = "divide10_limit";
  static const divide11_limit = "divide11_limit";
  static const divide12_limit = "divide12_limit";
  static const divide15_limit = "divide15_limit";
  static const divide18_limit = "divide18_limit";
  static const divide20_limit = "divide20_limit";
  static const divide24_limit = "divide24_limit";
  static const divide25_limit = "divide25_limit";
  static const divide30_limit = "divide30_limit";
  static const divide35_limit = "divide35_limit";
  static const divide36_limit = "divide36_limit";
  static const bonus_use2 = "bonus_use2";
  static const bonus_use3 = "bonus_use3";
  static const bonus_use4 = "bonus_use4";
  static const bonus_use5 = "bonus_use5";
  static const bonus_use6 = "bonus_use6";
  static const bonus_use7 = "bonus_use7";
  static const bonus_use8 = "bonus_use8";
  static const bonus_use9 = "bonus_use9";
  static const bonus_use10 = "bonus_use10";
  static const bonus_use11 = "bonus_use11";
  static const bonus_use12 = "bonus_use12";
  static const bonus_use15 = "bonus_use15";
  static const bonus_use18 = "bonus_use18";
  static const bonus_use20 = "bonus_use20";
  static const bonus_use24 = "bonus_use24";
  static const bonus_use25 = "bonus_use25";
  static const bonus_use30 = "bonus_use30";
  static const bonus_use35 = "bonus_use35";
  static const bonus_use36 = "bonus_use36";
  static const bonus_use2_limit = "bonus_use2_limit";
  static const bonus_use3_limit = "bonus_use3_limit";
  static const bonus_use4_limit = "bonus_use4_limit";
  static const bonus_use5_limit = "bonus_use5_limit";
  static const bonus_use6_limit = "bonus_use6_limit";
  static const bonus_use7_limit = "bonus_use7_limit";
  static const bonus_use8_limit = "bonus_use8_limit";
  static const bonus_use9_limit = "bonus_use9_limit";
  static const bonus_use10_limit = "bonus_use10_limit";
  static const bonus_use11_limit = "bonus_use11_limit";
  static const bonus_use12_limit = "bonus_use12_limit";
  static const bonus_use15_limit = "bonus_use15_limit";
  static const bonus_use18_limit = "bonus_use18_limit";
  static const bonus_use20_limit = "bonus_use20_limit";
  static const bonus_use24_limit = "bonus_use24_limit";
  static const bonus_use25_limit = "bonus_use25_limit";
  static const bonus_use30_limit = "bonus_use30_limit";
  static const bonus_use35_limit = "bonus_use35_limit";
  static const bonus_use36_limit = "bonus_use36_limit";
  static const pay_input_chk = "pay_input_chk";
  static const winter_bonus_from = "winter_bonus_from";
  static const winter_bonus_to = "winter_bonus_to";
  static const winter_bonus_pay1 = "winter_bonus_pay1";
  static const winter_bonus_pay2 = "winter_bonus_pay2";
  static const winter_bonus_pay3 = "winter_bonus_pay3";
  static const summer_bonus_from = "summer_bonus_from";
  static const summer_bonus_to = "summer_bonus_to";
  static const summer_bonus_pay1 = "summer_bonus_pay1";
  static const summer_bonus_pay2 = "summer_bonus_pay2";
  static const summer_bonus_pay3 = "summer_bonus_pay3";
  static const bonus_lump_limit = "bonus_lump_limit";
  static const bonus_twice_limit = "bonus_twice_limit";
  static const offline_limit = "offline_limit";
  static const card_jis = "card_jis";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const company_cd_to = "company_cd_to";
  static const stlcrdtdsc_per = "stlcrdtdsc_per";
  static const mkr_cd = "mkr_cd";
  static const destination = "destination";
  static const signless_flg = "signless_flg";
  static const coopcode1 = "coopcode1";
  static const coopcode2 = "coopcode2";
  static const coopcode3 = "coopcode3";
  static const bonus_add_input_chk = "bonus_add_input_chk";
  static const bonus_cnt_input_chk = "bonus_cnt_input_chk";
  static const bonus_cnt = "bonus_cnt";
  static const paymonth_input_chk = "paymonth_input_chk";
  static const sign_amt = "sign_amt";
  static const effect_code = "effect_code";
  static const fil1 = "fil1";
}

//endregion
//region 04_8	予約売価変更スケジュールマスタ	p_prcchg_sch_mst
/// 04_8  予約売価変更スケジュールマスタ  p_prcchg_sch_mstクラス
class PPrcchgSchMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? prcchg_cd;
  int div_cd = 0;
  String? start_datetime;
  String? end_datetime;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "p_prcchg_sch_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND prcchg_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(prcchg_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPrcchgSchMstColumns rn = PPrcchgSchMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.prcchg_cd = maps[i]['prcchg_cd'];
      rn.div_cd = maps[i]['div_cd'];
      rn.start_datetime = maps[i]['start_datetime'];
      rn.end_datetime = maps[i]['end_datetime'];
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
    PPrcchgSchMstColumns rn = PPrcchgSchMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.prcchg_cd = maps[0]['prcchg_cd'];
    rn.div_cd = maps[0]['div_cd'];
    rn.start_datetime = maps[0]['start_datetime'];
    rn.end_datetime = maps[0]['end_datetime'];
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
      PPrcchgSchMstField.comp_cd : this.comp_cd,
      PPrcchgSchMstField.stre_cd : this.stre_cd,
      PPrcchgSchMstField.prcchg_cd : this.prcchg_cd,
      PPrcchgSchMstField.div_cd : this.div_cd,
      PPrcchgSchMstField.start_datetime : this.start_datetime,
      PPrcchgSchMstField.end_datetime : this.end_datetime,
      PPrcchgSchMstField.ins_datetime : this.ins_datetime,
      PPrcchgSchMstField.upd_datetime : this.upd_datetime,
      PPrcchgSchMstField.status : this.status,
      PPrcchgSchMstField.send_flg : this.send_flg,
      PPrcchgSchMstField.upd_user : this.upd_user,
      PPrcchgSchMstField.upd_system : this.upd_system,
    };
  }
}

/// 04_8  予約売価変更スケジュールマスタ  p_prcchg_sch_mstのフィールド名設定用クラス
class PPrcchgSchMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const prcchg_cd = "prcchg_cd";
  static const div_cd = "div_cd";
  static const start_datetime = "start_datetime";
  static const end_datetime = "end_datetime";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 04_9	予約売価変更商品マスタ	p_prcchg_item_mst
/// 04_9  予約売価変更商品マスタ  p_prcchg_item_mstクラス
class PPrcchgItemMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? prcchg_cd;
  int? bkup_flg;
  String? plu_cd;
  String? item_name;
  int pos_prc = 0;
  int cust_prc = 0;
  double? cost_prc = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "p_prcchg_item_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND prcchg_cd = ? AND bkup_flg = ? AND plu_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(prcchg_cd);
    rn.add(bkup_flg);
    rn.add(plu_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPrcchgItemMstColumns rn = PPrcchgItemMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.prcchg_cd = maps[i]['prcchg_cd'];
      rn.bkup_flg = maps[i]['bkup_flg'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.item_name = maps[i]['item_name'];
      rn.pos_prc = maps[i]['pos_prc'];
      rn.cust_prc = maps[i]['cust_prc'];
      rn.cost_prc = maps[i]['cost_prc'];
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
    PPrcchgItemMstColumns rn = PPrcchgItemMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.prcchg_cd = maps[0]['prcchg_cd'];
    rn.bkup_flg = maps[0]['bkup_flg'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.item_name = maps[0]['item_name'];
    rn.pos_prc = maps[0]['pos_prc'];
    rn.cust_prc = maps[0]['cust_prc'];
    rn.cost_prc = maps[0]['cost_prc'];
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
      PPrcchgItemMstField.comp_cd : this.comp_cd,
      PPrcchgItemMstField.stre_cd : this.stre_cd,
      PPrcchgItemMstField.prcchg_cd : this.prcchg_cd,
      PPrcchgItemMstField.bkup_flg : this.bkup_flg,
      PPrcchgItemMstField.plu_cd : this.plu_cd,
      PPrcchgItemMstField.item_name : this.item_name,
      PPrcchgItemMstField.pos_prc : this.pos_prc,
      PPrcchgItemMstField.cust_prc : this.cust_prc,
      PPrcchgItemMstField.cost_prc : this.cost_prc,
      PPrcchgItemMstField.ins_datetime : this.ins_datetime,
      PPrcchgItemMstField.upd_datetime : this.upd_datetime,
      PPrcchgItemMstField.status : this.status,
      PPrcchgItemMstField.send_flg : this.send_flg,
      PPrcchgItemMstField.upd_user : this.upd_user,
      PPrcchgItemMstField.upd_system : this.upd_system,
    };
  }
}

/// 04_9  予約売価変更商品マスタ  p_prcchg_item_mstのフィールド名設定用クラス
class PPrcchgItemMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const prcchg_cd = "prcchg_cd";
  static const bkup_flg = "bkup_flg";
  static const plu_cd = "plu_cd";
  static const item_name = "item_name";
  static const pos_prc = "pos_prc";
  static const cust_prc = "cust_prc";
  static const cost_prc = "cost_prc";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 04_10	売価変更マスタ	p_prcchg_mst
/// 04_10 売価変更マスタ  p_prcchg_mstクラス
class PPrcchgMstColumns extends TableColumns{
  int? serial_no;
  String? plu_cd;
  String? item_name;
  int pos_prc = 0;
  int cust_prc = 0;
  double? cost_prc = 0;
  int prcchg_cd = 0;
  int mac_no = 0;
  int div_cd = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "p_prcchg_mst";

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
      PPrcchgMstColumns rn = PPrcchgMstColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.item_name = maps[i]['item_name'];
      rn.pos_prc = maps[i]['pos_prc'];
      rn.cust_prc = maps[i]['cust_prc'];
      rn.cost_prc = maps[i]['cost_prc'];
      rn.prcchg_cd = maps[i]['prcchg_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.div_cd = maps[i]['div_cd'];
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
    PPrcchgMstColumns rn = PPrcchgMstColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.item_name = maps[0]['item_name'];
    rn.pos_prc = maps[0]['pos_prc'];
    rn.cust_prc = maps[0]['cust_prc'];
    rn.cost_prc = maps[0]['cost_prc'];
    rn.prcchg_cd = maps[0]['prcchg_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.div_cd = maps[0]['div_cd'];
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
      PPrcchgMstField.serial_no : this.serial_no,
      PPrcchgMstField.plu_cd : this.plu_cd,
      PPrcchgMstField.item_name : this.item_name,
      PPrcchgMstField.pos_prc : this.pos_prc,
      PPrcchgMstField.cust_prc : this.cust_prc,
      PPrcchgMstField.cost_prc : this.cost_prc,
      PPrcchgMstField.prcchg_cd : this.prcchg_cd,
      PPrcchgMstField.mac_no : this.mac_no,
      PPrcchgMstField.div_cd : this.div_cd,
      PPrcchgMstField.ins_datetime : this.ins_datetime,
      PPrcchgMstField.upd_datetime : this.upd_datetime,
      PPrcchgMstField.status : this.status,
      PPrcchgMstField.send_flg : this.send_flg,
      PPrcchgMstField.upd_user : this.upd_user,
      PPrcchgMstField.upd_system : this.upd_system,
    };
  }
}

/// 04_10 売価変更マスタ  p_prcchg_mstのフィールド名設定用クラス
class PPrcchgMstField {
  static const serial_no = "serial_no";
  static const plu_cd = "plu_cd";
  static const item_name = "item_name";
  static const pos_prc = "pos_prc";
  static const cust_prc = "cust_prc";
  static const cost_prc = "cost_prc";
  static const prcchg_cd = "prcchg_cd";
  static const mac_no = "mac_no";
  static const div_cd = "div_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 04_11	ﾊﾞｯｸﾔｰﾄﾞ機器ﾏｽﾀ	s_backyard_grp_mst
/// 04_11 ﾊﾞｯｸﾔｰﾄﾞ機器ﾏｽﾀ  s_backyard_grp_mstクラス
class SBackyardGrpMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? cnct_no;
  int? cls_typ;
  int? cls_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "s_backyard_grp_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND cnct_no = ? AND cls_typ = ? AND cls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(cnct_no);
    rn.add(cls_typ);
    rn.add(cls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SBackyardGrpMstColumns rn = SBackyardGrpMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.cnct_no = maps[i]['cnct_no'];
      rn.cls_typ = maps[i]['cls_typ'];
      rn.cls_cd = maps[i]['cls_cd'];
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
    SBackyardGrpMstColumns rn = SBackyardGrpMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.cnct_no = maps[0]['cnct_no'];
    rn.cls_typ = maps[0]['cls_typ'];
    rn.cls_cd = maps[0]['cls_cd'];
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
      SBackyardGrpMstField.comp_cd : this.comp_cd,
      SBackyardGrpMstField.stre_cd : this.stre_cd,
      SBackyardGrpMstField.cnct_no : this.cnct_no,
      SBackyardGrpMstField.cls_typ : this.cls_typ,
      SBackyardGrpMstField.cls_cd : this.cls_cd,
      SBackyardGrpMstField.ins_datetime : this.ins_datetime,
      SBackyardGrpMstField.upd_datetime : this.upd_datetime,
      SBackyardGrpMstField.status : this.status,
      SBackyardGrpMstField.send_flg : this.send_flg,
      SBackyardGrpMstField.upd_user : this.upd_user,
      SBackyardGrpMstField.upd_system : this.upd_system,
    };
  }
}

/// 04_11 ﾊﾞｯｸﾔｰﾄﾞ機器ﾏｽﾀ  s_backyard_grp_mstのフィールド名設定用クラス
class SBackyardGrpMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const cnct_no = "cnct_no";
  static const cls_typ = "cls_typ";
  static const cls_cd = "cls_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 04_12	Wiz情報テーブル	c_wiz_inf_tbl
/// 04_12 Wiz情報テーブル  c_wiz_inf_tblクラス
class CWizInfTblColumns extends TableColumns{
  int? cd;
  String? ipaddr;
  String? mac_addr;
  int? pwr_sts;
  int? run_flg;
  String? run_bfre_date;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_wiz_inf_tbl";

  @override
  String? _getKeyCondition() => 'cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CWizInfTblColumns rn = CWizInfTblColumns();
      rn.cd = maps[i]['cd'];
      rn.ipaddr = maps[i]['ipaddr'];
      rn.mac_addr = maps[i]['mac_addr'];
      rn.pwr_sts = maps[i]['pwr_sts'];
      rn.run_flg = maps[i]['run_flg'];
      rn.run_bfre_date = maps[i]['run_bfre_date'];
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
    CWizInfTblColumns rn = CWizInfTblColumns();
    rn.cd = maps[0]['cd'];
    rn.ipaddr = maps[0]['ipaddr'];
    rn.mac_addr = maps[0]['mac_addr'];
    rn.pwr_sts = maps[0]['pwr_sts'];
    rn.run_flg = maps[0]['run_flg'];
    rn.run_bfre_date = maps[0]['run_bfre_date'];
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
      CWizInfTblField.cd : this.cd,
      CWizInfTblField.ipaddr : this.ipaddr,
      CWizInfTblField.mac_addr : this.mac_addr,
      CWizInfTblField.pwr_sts : this.pwr_sts,
      CWizInfTblField.run_flg : this.run_flg,
      CWizInfTblField.run_bfre_date : this.run_bfre_date,
      CWizInfTblField.ins_datetime : this.ins_datetime,
      CWizInfTblField.upd_datetime : this.upd_datetime,
      CWizInfTblField.status : this.status,
      CWizInfTblField.send_flg : this.send_flg,
      CWizInfTblField.upd_user : this.upd_user,
      CWizInfTblField.upd_system : this.upd_system,
    };
  }
}

/// 04_12 Wiz情報テーブル  c_wiz_inf_tblのフィールド名設定用クラス
class CWizInfTblField {
  static const cd = "cd";
  static const ipaddr = "ipaddr";
  static const mac_addr = "mac_addr";
  static const pwr_sts = "pwr_sts";
  static const run_flg = "run_flg";
  static const run_bfre_date = "run_bfre_date";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 04_13	パスポート情報マスタ	c_passport_info_mst
/// 04_13 パスポート情報マスタ c_passport_info_mstクラス
class CPassportInfoMstColumns extends TableColumns{
  int? kind;
  int? code;
  String? data_jp;
  String? data_ex;
  int? langue;
  String? data_01;
  String? data_02;
  int? country_code;
  String? data_03;
  int? flg_01;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_passport_info_mst";

  @override
  String? _getKeyCondition() => 'kind = ? AND code = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(kind);
    rn.add(code);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CPassportInfoMstColumns rn = CPassportInfoMstColumns();
      rn.kind = maps[i]['kind'];
      rn.code = maps[i]['code'];
      rn.data_jp = maps[i]['data_jp'];
      rn.data_ex = maps[i]['data_ex'];
      rn.langue = maps[i]['langue'];
      rn.data_01 = maps[i]['data_01'];
      rn.data_02 = maps[i]['data_02'];
      rn.country_code = maps[i]['country_code'];
      rn.data_03 = maps[i]['data_03'];
      rn.flg_01 = maps[i]['flg_01'];
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
    CPassportInfoMstColumns rn = CPassportInfoMstColumns();
    rn.kind = maps[0]['kind'];
    rn.code = maps[0]['code'];
    rn.data_jp = maps[0]['data_jp'];
    rn.data_ex = maps[0]['data_ex'];
    rn.langue = maps[0]['langue'];
    rn.data_01 = maps[0]['data_01'];
    rn.data_02 = maps[0]['data_02'];
    rn.country_code = maps[0]['country_code'];
    rn.data_03 = maps[0]['data_03'];
    rn.flg_01 = maps[0]['flg_01'];
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
      CPassportInfoMstField.kind : this.kind,
      CPassportInfoMstField.code : this.code,
      CPassportInfoMstField.data_jp : this.data_jp,
      CPassportInfoMstField.data_ex : this.data_ex,
      CPassportInfoMstField.langue : this.langue,
      CPassportInfoMstField.data_01 : this.data_01,
      CPassportInfoMstField.data_02 : this.data_02,
      CPassportInfoMstField.country_code : this.country_code,
      CPassportInfoMstField.data_03 : this.data_03,
      CPassportInfoMstField.flg_01 : this.flg_01,
      CPassportInfoMstField.ins_datetime : this.ins_datetime,
      CPassportInfoMstField.upd_datetime : this.upd_datetime,
      CPassportInfoMstField.status : this.status,
      CPassportInfoMstField.send_flg : this.send_flg,
      CPassportInfoMstField.upd_user : this.upd_user,
      CPassportInfoMstField.upd_system : this.upd_system,
    };
  }
}

/// 04_13 パスポート情報マスタ c_passport_info_mstのフィールド名設定用クラス
class CPassportInfoMstField {
  static const kind = "kind";
  static const code = "code";
  static const data_jp = "data_jp";
  static const data_ex = "data_ex";
  static const langue = "langue";
  static const data_01 = "data_01";
  static const data_02 = "data_02";
  static const country_code = "country_code";
  static const data_03 = "data_03";
  static const flg_01 = "flg_01";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 04_14	緊急ﾒﾝﾃﾅﾝｽｵﾌﾗｲﾝﾃｰﾌﾞﾙ	p_notfplu_off_tbl
/// 04_14 緊急ﾒﾝﾃﾅﾝｽｵﾌﾗｲﾝﾃｰﾌﾞﾙ p_notfplu_off_tblクラス
class PNotfpluOffTblColumns extends TableColumns{
  String? plu_cd;
  int lrgcls_cd = 0;
  int mdlcls_cd = 0;
  int smlcls_cd = 0;
  int tnycls_cd = 0;
  String? item_name;
  String? pos_name;
  int pos_prc = 0;
  int tax_cd_1 = 0;
  int mac_no = 0;
  int staff_cd = 0;

  @override
  String _getTableName() => "p_notfplu_off_tbl";

  @override
  String? _getKeyCondition() => 'plu_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(plu_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PNotfpluOffTblColumns rn = PNotfpluOffTblColumns();
      rn.plu_cd = maps[i]['plu_cd'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.tnycls_cd = maps[i]['tnycls_cd'];
      rn.item_name = maps[i]['item_name'];
      rn.pos_name = maps[i]['pos_name'];
      rn.pos_prc = maps[i]['pos_prc'];
      rn.tax_cd_1 = maps[i]['tax_cd_1'];
      rn.mac_no = maps[i]['mac_no'];
      rn.staff_cd = maps[i]['staff_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PNotfpluOffTblColumns rn = PNotfpluOffTblColumns();
    rn.plu_cd = maps[0]['plu_cd'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.tnycls_cd = maps[0]['tnycls_cd'];
    rn.item_name = maps[0]['item_name'];
    rn.pos_name = maps[0]['pos_name'];
    rn.pos_prc = maps[0]['pos_prc'];
    rn.tax_cd_1 = maps[0]['tax_cd_1'];
    rn.mac_no = maps[0]['mac_no'];
    rn.staff_cd = maps[0]['staff_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PNotfpluOffTblField.plu_cd : this.plu_cd,
      PNotfpluOffTblField.lrgcls_cd : this.lrgcls_cd,
      PNotfpluOffTblField.mdlcls_cd : this.mdlcls_cd,
      PNotfpluOffTblField.smlcls_cd : this.smlcls_cd,
      PNotfpluOffTblField.tnycls_cd : this.tnycls_cd,
      PNotfpluOffTblField.item_name : this.item_name,
      PNotfpluOffTblField.pos_name : this.pos_name,
      PNotfpluOffTblField.pos_prc : this.pos_prc,
      PNotfpluOffTblField.tax_cd_1 : this.tax_cd_1,
      PNotfpluOffTblField.mac_no : this.mac_no,
      PNotfpluOffTblField.staff_cd : this.staff_cd,
    };
  }
}

/// 04_14 緊急ﾒﾝﾃﾅﾝｽｵﾌﾗｲﾝﾃｰﾌﾞﾙ p_notfplu_off_tblのフィールド名設定用クラス
class PNotfpluOffTblField {
  static const plu_cd = "plu_cd";
  static const lrgcls_cd = "lrgcls_cd";
  static const mdlcls_cd = "mdlcls_cd";
  static const smlcls_cd = "smlcls_cd";
  static const tnycls_cd = "tnycls_cd";
  static const item_name = "item_name";
  static const pos_name = "pos_name";
  static const pos_prc = "pos_prc";
  static const tax_cd_1 = "tax_cd_1";
  static const mac_no = "mac_no";
  static const staff_cd = "staff_cd";
}
//endregion