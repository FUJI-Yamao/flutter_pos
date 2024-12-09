/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
08_顧客マスタ系
08_1	顧客マスタ	c_cust_mst
08_2	購買履歴確認除外商品テーブル	s_daybook_spplu_tbl
08_3	自店カード判定マスタ	c_cust_jdg_mst
08_4	会員カード判定マスタ	c_mbrcard_mst
08_5	会員カードサービス判定マスタ	c_mbrcard_svs_mst
 */

//region 08_1	顧客マスタ	c_cust_mst
/// 08_1  顧客マスタ  c_cust_mstクラス
class CCustMstColumns extends TableColumns{
  String? cust_no;
  int? comp_cd;
  int stre_cd = 0;
  String? last_name;
  String? first_name;
  String? kana_last_name;
  String? kana_first_name;
  String? birth_day;
  String? tel_no1;
  String? tel_no2;
  int sex = 0;
  int cust_status = 0;
  String? admission_date;
  String? withdraw_date;
  int withdraw_typ = 0;
  String? withdraw_resn;
  int card_clct_typ = 0;
  int custzone_cd = 0;
  String? post_no;
  String? address1;
  String? address2;
  String? address3;
  String? mail_addr;
  int mail_flg = 0;
  int dm_flg = 0;
  String? password;
  int targ_typ = 0;
  int attrib1 = 0;
  int attrib2 = 0;
  int attrib3 = 0;
  int attrib4 = 0;
  int attrib5 = 0;
  int attrib6 = 0;
  int attrib7 = 0;
  int attrib8 = 0;
  int attrib9 = 0;
  int attrib10 = 0;
  int mov_flg = 0;
  String? pre_cust_no;
  String? remark;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int? svs_cls_cd;
  int staff_flg = 0;
  int cust_prc_type = 0;
  String? address4;
  int tel_flg = 0;

  @override
  String _getTableName() => "c_cust_mst";

  @override
  String? _getKeyCondition() => 'cust_no = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cust_no);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCustMstColumns rn = CCustMstColumns();
      rn.cust_no = maps[i]['cust_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.last_name = maps[i]['last_name'];
      rn.first_name = maps[i]['first_name'];
      rn.kana_last_name = maps[i]['kana_last_name'];
      rn.kana_first_name = maps[i]['kana_first_name'];
      rn.birth_day = maps[i]['birth_day'];
      rn.tel_no1 = maps[i]['tel_no1'];
      rn.tel_no2 = maps[i]['tel_no2'];
      rn.sex = maps[i]['sex'];
      rn.cust_status = maps[i]['cust_status'];
      rn.admission_date = maps[i]['admission_date'];
      rn.withdraw_date = maps[i]['withdraw_date'];
      rn.withdraw_typ = maps[i]['withdraw_typ'];
      rn.withdraw_resn = maps[i]['withdraw_resn'];
      rn.card_clct_typ = maps[i]['card_clct_typ'];
      rn.custzone_cd = maps[i]['custzone_cd'];
      rn.post_no = maps[i]['post_no'];
      rn.address1 = maps[i]['address1'];
      rn.address2 = maps[i]['address2'];
      rn.address3 = maps[i]['address3'];
      rn.mail_addr = maps[i]['mail_addr'];
      rn.mail_flg = maps[i]['mail_flg'];
      rn.dm_flg = maps[i]['dm_flg'];
      rn.password = maps[i]['password'];
      rn.targ_typ = maps[i]['targ_typ'];
      rn.attrib1 = maps[i]['attrib1'];
      rn.attrib2 = maps[i]['attrib2'];
      rn.attrib3 = maps[i]['attrib3'];
      rn.attrib4 = maps[i]['attrib4'];
      rn.attrib5 = maps[i]['attrib5'];
      rn.attrib6 = maps[i]['attrib6'];
      rn.attrib7 = maps[i]['attrib7'];
      rn.attrib8 = maps[i]['attrib8'];
      rn.attrib9 = maps[i]['attrib9'];
      rn.attrib10 = maps[i]['attrib10'];
      rn.mov_flg = maps[i]['mov_flg'];
      rn.pre_cust_no = maps[i]['pre_cust_no'];
      rn.remark = maps[i]['remark'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.svs_cls_cd = maps[i]['svs_cls_cd'];
      rn.staff_flg = maps[i]['staff_flg'];
      rn.cust_prc_type = maps[i]['cust_prc_type'];
      rn.address4 = maps[i]['address4'];
      rn.tel_flg = maps[i]['tel_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CCustMstColumns rn = CCustMstColumns();
    rn.cust_no = maps[0]['cust_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.last_name = maps[0]['last_name'];
    rn.first_name = maps[0]['first_name'];
    rn.kana_last_name = maps[0]['kana_last_name'];
    rn.kana_first_name = maps[0]['kana_first_name'];
    rn.birth_day = maps[0]['birth_day'];
    rn.tel_no1 = maps[0]['tel_no1'];
    rn.tel_no2 = maps[0]['tel_no2'];
    rn.sex = maps[0]['sex'];
    rn.cust_status = maps[0]['cust_status'];
    rn.admission_date = maps[0]['admission_date'];
    rn.withdraw_date = maps[0]['withdraw_date'];
    rn.withdraw_typ = maps[0]['withdraw_typ'];
    rn.withdraw_resn = maps[0]['withdraw_resn'];
    rn.card_clct_typ = maps[0]['card_clct_typ'];
    rn.custzone_cd = maps[0]['custzone_cd'];
    rn.post_no = maps[0]['post_no'];
    rn.address1 = maps[0]['address1'];
    rn.address2 = maps[0]['address2'];
    rn.address3 = maps[0]['address3'];
    rn.mail_addr = maps[0]['mail_addr'];
    rn.mail_flg = maps[0]['mail_flg'];
    rn.dm_flg = maps[0]['dm_flg'];
    rn.password = maps[0]['password'];
    rn.targ_typ = maps[0]['targ_typ'];
    rn.attrib1 = maps[0]['attrib1'];
    rn.attrib2 = maps[0]['attrib2'];
    rn.attrib3 = maps[0]['attrib3'];
    rn.attrib4 = maps[0]['attrib4'];
    rn.attrib5 = maps[0]['attrib5'];
    rn.attrib6 = maps[0]['attrib6'];
    rn.attrib7 = maps[0]['attrib7'];
    rn.attrib8 = maps[0]['attrib8'];
    rn.attrib9 = maps[0]['attrib9'];
    rn.attrib10 = maps[0]['attrib10'];
    rn.mov_flg = maps[0]['mov_flg'];
    rn.pre_cust_no = maps[0]['pre_cust_no'];
    rn.remark = maps[0]['remark'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.svs_cls_cd = maps[0]['svs_cls_cd'];
    rn.staff_flg = maps[0]['staff_flg'];
    rn.cust_prc_type = maps[0]['cust_prc_type'];
    rn.address4 = maps[0]['address4'];
    rn.tel_flg = maps[0]['tel_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CCustMstField.cust_no : this.cust_no,
      CCustMstField.comp_cd : this.comp_cd,
      CCustMstField.stre_cd : this.stre_cd,
      CCustMstField.last_name : this.last_name,
      CCustMstField.first_name : this.first_name,
      CCustMstField.kana_last_name : this.kana_last_name,
      CCustMstField.kana_first_name : this.kana_first_name,
      CCustMstField.birth_day : this.birth_day,
      CCustMstField.tel_no1 : this.tel_no1,
      CCustMstField.tel_no2 : this.tel_no2,
      CCustMstField.sex : this.sex,
      CCustMstField.cust_status : this.cust_status,
      CCustMstField.admission_date : this.admission_date,
      CCustMstField.withdraw_date : this.withdraw_date,
      CCustMstField.withdraw_typ : this.withdraw_typ,
      CCustMstField.withdraw_resn : this.withdraw_resn,
      CCustMstField.card_clct_typ : this.card_clct_typ,
      CCustMstField.custzone_cd : this.custzone_cd,
      CCustMstField.post_no : this.post_no,
      CCustMstField.address1 : this.address1,
      CCustMstField.address2 : this.address2,
      CCustMstField.address3 : this.address3,
      CCustMstField.mail_addr : this.mail_addr,
      CCustMstField.mail_flg : this.mail_flg,
      CCustMstField.dm_flg : this.dm_flg,
      CCustMstField.password : this.password,
      CCustMstField.targ_typ : this.targ_typ,
      CCustMstField.attrib1 : this.attrib1,
      CCustMstField.attrib2 : this.attrib2,
      CCustMstField.attrib3 : this.attrib3,
      CCustMstField.attrib4 : this.attrib4,
      CCustMstField.attrib5 : this.attrib5,
      CCustMstField.attrib6 : this.attrib6,
      CCustMstField.attrib7 : this.attrib7,
      CCustMstField.attrib8 : this.attrib8,
      CCustMstField.attrib9 : this.attrib9,
      CCustMstField.attrib10 : this.attrib10,
      CCustMstField.mov_flg : this.mov_flg,
      CCustMstField.pre_cust_no : this.pre_cust_no,
      CCustMstField.remark : this.remark,
      CCustMstField.ins_datetime : this.ins_datetime,
      CCustMstField.upd_datetime : this.upd_datetime,
      CCustMstField.status : this.status,
      CCustMstField.send_flg : this.send_flg,
      CCustMstField.upd_user : this.upd_user,
      CCustMstField.upd_system : this.upd_system,
      CCustMstField.svs_cls_cd : this.svs_cls_cd,
      CCustMstField.staff_flg : this.staff_flg,
      CCustMstField.cust_prc_type : this.cust_prc_type,
      CCustMstField.address4 : this.address4,
      CCustMstField.tel_flg : this.tel_flg,
    };
  }
}

/// 08_1  顧客マスタ  c_cust_mstのフィールド名設定用クラス
class CCustMstField {
  static const cust_no = "cust_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const last_name = "last_name";
  static const first_name = "first_name";
  static const kana_last_name = "kana_last_name";
  static const kana_first_name = "kana_first_name";
  static const birth_day = "birth_day";
  static const tel_no1 = "tel_no1";
  static const tel_no2 = "tel_no2";
  static const sex = "sex";
  static const cust_status = "cust_status";
  static const admission_date = "admission_date";
  static const withdraw_date = "withdraw_date";
  static const withdraw_typ = "withdraw_typ";
  static const withdraw_resn = "withdraw_resn";
  static const card_clct_typ = "card_clct_typ";
  static const custzone_cd = "custzone_cd";
  static const post_no = "post_no";
  static const address1 = "address1";
  static const address2 = "address2";
  static const address3 = "address3";
  static const mail_addr = "mail_addr";
  static const mail_flg = "mail_flg";
  static const dm_flg = "dm_flg";
  static const password = "password";
  static const targ_typ = "targ_typ";
  static const attrib1 = "attrib1";
  static const attrib2 = "attrib2";
  static const attrib3 = "attrib3";
  static const attrib4 = "attrib4";
  static const attrib5 = "attrib5";
  static const attrib6 = "attrib6";
  static const attrib7 = "attrib7";
  static const attrib8 = "attrib8";
  static const attrib9 = "attrib9";
  static const attrib10 = "attrib10";
  static const mov_flg = "mov_flg";
  static const pre_cust_no = "pre_cust_no";
  static const remark = "remark";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const svs_cls_cd = "svs_cls_cd";
  static const staff_flg = "staff_flg";
  static const cust_prc_type = "cust_prc_type";
  static const address4 = "address4";
  static const tel_flg = "tel_flg";
}
//endregion
//region 08_2	購買履歴確認除外商品テーブル	s_daybook_spplu_tbl
/// 08_2  購買履歴確認除外商品テーブル s_daybook_spplu_tblクラス
class SDaybookSppluTblColumns extends TableColumns{
  String? plu_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "s_daybook_spplu_tbl";

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
      SDaybookSppluTblColumns rn = SDaybookSppluTblColumns();
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
    SDaybookSppluTblColumns rn = SDaybookSppluTblColumns();
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
      SDaybookSppluTblField.plu_cd : this.plu_cd,
      SDaybookSppluTblField.ins_datetime : this.ins_datetime,
      SDaybookSppluTblField.upd_datetime : this.upd_datetime,
      SDaybookSppluTblField.status : this.status,
      SDaybookSppluTblField.send_flg : this.send_flg,
      SDaybookSppluTblField.upd_user : this.upd_user,
      SDaybookSppluTblField.upd_system : this.upd_system,
    };
  }
}

/// 08_2  購買履歴確認除外商品テーブル s_daybook_spplu_tblのフィールド名設定用クラス
class SDaybookSppluTblField {
  static const plu_cd = "plu_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 08_3	自店カード判定マスタ	c_cust_jdg_mst
/// 08_3  自店カード判定マスタ c_cust_jdg_mstクラス
class CCustJdgMstColumns extends TableColumns{
  int? comp_cd;
  int? refer_stre_cd;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_cust_jdg_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND refer_stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(refer_stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCustJdgMstColumns rn = CCustJdgMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.refer_stre_cd = maps[i]['refer_stre_cd'];
      rn.stop_flg = maps[i]['stop_flg'];
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
    CCustJdgMstColumns rn = CCustJdgMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.refer_stre_cd = maps[0]['refer_stre_cd'];
    rn.stop_flg = maps[0]['stop_flg'];
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
      CCustJdgMstField.comp_cd : this.comp_cd,
      CCustJdgMstField.refer_stre_cd : this.refer_stre_cd,
      CCustJdgMstField.stop_flg : this.stop_flg,
      CCustJdgMstField.ins_datetime : this.ins_datetime,
      CCustJdgMstField.upd_datetime : this.upd_datetime,
      CCustJdgMstField.status : this.status,
      CCustJdgMstField.send_flg : this.send_flg,
      CCustJdgMstField.upd_user : this.upd_user,
      CCustJdgMstField.upd_system : this.upd_system,
    };
  }
}

/// 08_3  自店カード判定マスタ c_cust_jdg_mstのフィールド名設定用クラス
class CCustJdgMstField {
  static const comp_cd = "comp_cd";
  static const refer_stre_cd = "refer_stre_cd";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 08_4	会員カード判定マスタ	c_mbrcard_mst
/// 08_4  会員カード判定マスタ c_mbrcard_mstクラス
class CMbrcardMstColumns extends TableColumns{
  int? seq_no;
  int? comp_cd;
  String? code_from;
  String? code_to;
  String? c_data1;
  String? c_data2;
  String? c_data3;
  int s_data1 = 0;
  int s_data2 = 0;
  int n_data1 = 0;
  int n_data2 = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_mbrcard_mst";

  @override
  String? _getKeyCondition() => 'seq_no = ? AND comp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(seq_no);
    rn.add(comp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMbrcardMstColumns rn = CMbrcardMstColumns();
      rn.seq_no = maps[i]['seq_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.code_from = maps[i]['code_from'];
      rn.code_to = maps[i]['code_to'];
      rn.c_data1 = maps[i]['c_data1'];
      rn.c_data2 = maps[i]['c_data2'];
      rn.c_data3 = maps[i]['c_data3'];
      rn.s_data1 = maps[i]['s_data1'];
      rn.s_data2 = maps[i]['s_data2'];
      rn.n_data1 = maps[i]['n_data1'];
      rn.n_data2 = maps[i]['n_data2'];
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
    CMbrcardMstColumns rn = CMbrcardMstColumns();
    rn.seq_no = maps[0]['seq_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.code_from = maps[0]['code_from'];
    rn.code_to = maps[0]['code_to'];
    rn.c_data1 = maps[0]['c_data1'];
    rn.c_data2 = maps[0]['c_data2'];
    rn.c_data3 = maps[0]['c_data3'];
    rn.s_data1 = maps[0]['s_data1'];
    rn.s_data2 = maps[0]['s_data2'];
    rn.n_data1 = maps[0]['n_data1'];
    rn.n_data2 = maps[0]['n_data2'];
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
      CMbrcardMstField.seq_no : this.seq_no,
      CMbrcardMstField.comp_cd : this.comp_cd,
      CMbrcardMstField.code_from : this.code_from,
      CMbrcardMstField.code_to : this.code_to,
      CMbrcardMstField.c_data1 : this.c_data1,
      CMbrcardMstField.c_data2 : this.c_data2,
      CMbrcardMstField.c_data3 : this.c_data3,
      CMbrcardMstField.s_data1 : this.s_data1,
      CMbrcardMstField.s_data2 : this.s_data2,
      CMbrcardMstField.n_data1 : this.n_data1,
      CMbrcardMstField.n_data2 : this.n_data2,
      CMbrcardMstField.ins_datetime : this.ins_datetime,
      CMbrcardMstField.upd_datetime : this.upd_datetime,
      CMbrcardMstField.status : this.status,
      CMbrcardMstField.send_flg : this.send_flg,
      CMbrcardMstField.upd_user : this.upd_user,
      CMbrcardMstField.upd_system : this.upd_system,
    };
  }
}

/// 08_4  会員カード判定マスタ c_mbrcard_mstのフィールド名設定用クラス
class CMbrcardMstField {
  static const seq_no = "seq_no";
  static const comp_cd = "comp_cd";
  static const code_from = "code_from";
  static const code_to = "code_to";
  static const c_data1 = "c_data1";
  static const c_data2 = "c_data2";
  static const c_data3 = "c_data3";
  static const s_data1 = "s_data1";
  static const s_data2 = "s_data2";
  static const n_data1 = "n_data1";
  static const n_data2 = "n_data2";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 08_5	会員カードサービス判定マスタ	c_mbrcard_svs_mst
/// 08_5  会員カードサービス判定マスタ c_mbrcard_svs_mstクラス
class CMbrcardSvsMstColumns extends TableColumns{
  int? rec_id;
  int? comp_cd;
  int? card_kind;
  int? svs_cd;
  String? c_data1;
  String? c_data2;
  String? c_data3;
  int s_data1 = 0;
  int s_data2 = 0;
  int n_data1 = 0;
  int n_data2 = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_mbrcard_svs_mst";

  @override
  String? _getKeyCondition() => 'rec_id = ? AND comp_cd = ? AND card_kind = ? AND svs_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(rec_id);
    rn.add(comp_cd);
    rn.add(card_kind);
    rn.add(svs_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMbrcardSvsMstColumns rn = CMbrcardSvsMstColumns();
      rn.rec_id = maps[i]['rec_id'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.card_kind = maps[i]['card_kind'];
      rn.svs_cd = maps[i]['svs_cd'];
      rn.c_data1 = maps[i]['c_data1'];
      rn.c_data2 = maps[i]['c_data2'];
      rn.c_data3 = maps[i]['c_data3'];
      rn.s_data1 = maps[i]['s_data1'];
      rn.s_data2 = maps[i]['s_data2'];
      rn.n_data1 = maps[i]['n_data1'];
      rn.n_data2 = maps[i]['n_data2'];
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
    CMbrcardSvsMstColumns rn = CMbrcardSvsMstColumns();
    rn.rec_id = maps[0]['rec_id'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.card_kind = maps[0]['card_kind'];
    rn.svs_cd = maps[0]['svs_cd'];
    rn.c_data1 = maps[0]['c_data1'];
    rn.c_data2 = maps[0]['c_data2'];
    rn.c_data3 = maps[0]['c_data3'];
    rn.s_data1 = maps[0]['s_data1'];
    rn.s_data2 = maps[0]['s_data2'];
    rn.n_data1 = maps[0]['n_data1'];
    rn.n_data2 = maps[0]['n_data2'];
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
      CMbrcardSvsMstField.rec_id : this.rec_id,
      CMbrcardSvsMstField.comp_cd : this.comp_cd,
      CMbrcardSvsMstField.card_kind : this.card_kind,
      CMbrcardSvsMstField.svs_cd : this.svs_cd,
      CMbrcardSvsMstField.c_data1 : this.c_data1,
      CMbrcardSvsMstField.c_data2 : this.c_data2,
      CMbrcardSvsMstField.c_data3 : this.c_data3,
      CMbrcardSvsMstField.s_data1 : this.s_data1,
      CMbrcardSvsMstField.s_data2 : this.s_data2,
      CMbrcardSvsMstField.n_data1 : this.n_data1,
      CMbrcardSvsMstField.n_data2 : this.n_data2,
      CMbrcardSvsMstField.ins_datetime : this.ins_datetime,
      CMbrcardSvsMstField.upd_datetime : this.upd_datetime,
      CMbrcardSvsMstField.status : this.status,
      CMbrcardSvsMstField.send_flg : this.send_flg,
      CMbrcardSvsMstField.upd_user : this.upd_user,
      CMbrcardSvsMstField.upd_system : this.upd_system,
    };
  }
}

/// 08_5  会員カードサービス判定マスタ c_mbrcard_svs_mstのフィールド名設定用クラス
class CMbrcardSvsMstField {
  static const rec_id = "rec_id";
  static const comp_cd = "comp_cd";
  static const card_kind = "card_kind";
  static const svs_cd = "svs_cd";
  static const c_data1 = "c_data1";
  static const c_data2 = "c_data2";
  static const c_data3 = "c_data3";
  static const s_data1 = "s_data1";
  static const s_data2 = "s_data2";
  static const n_data1 = "n_data1";
  static const n_data2 = "n_data2";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion