/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
part of 'db_manipulation.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
09_従業員マスタ系
09_1	従業員マスタ	c_staff_mst
09_2	従業員権限マスタ	c_staffauth_mst
09_3	サーバー従業員権限マスタ	s_svr_staffauth_mst
09_4	ファンクション操作権限マスタ	c_keyauth_mst
09_5	レジメニュー操作権限マスタ	c_menuauth_mst
09_6	従業員オープン情報マスタ	c_staffopen_mst
09_7	特定操作マスタ	c_operation_mst
09_8	特定操作権限マスタ	c_operationauth_mst
 */

//region 09_1	従業員マスタ	c_staff_mst
/// 09_1  従業員マスタ c_staff_mstクラス
class CStaffMstColumns extends TableColumns{
  int? comp_cd;
  int? staff_cd;
  int? stre_cd;
  String? name;
  String? passwd;
  int auth_lvl = 0;
  int svr_auth_lvl = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int nochk_overlap = 0;

  @override
  String _getTableName() => "c_staff_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND staff_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(staff_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStaffMstColumns rn = CStaffMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.staff_cd = maps[i]['staff_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.name = maps[i]['name'];
      rn.passwd = maps[i]['passwd'];
      rn.auth_lvl = maps[i]['auth_lvl'];
      rn.svr_auth_lvl = maps[i]['svr_auth_lvl'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.nochk_overlap = maps[i]['nochk_overlap'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CStaffMstColumns rn = CStaffMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.staff_cd = maps[0]['staff_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.name = maps[0]['name'];
    rn.passwd = maps[0]['passwd'];
    rn.auth_lvl = maps[0]['auth_lvl'];
    rn.svr_auth_lvl = maps[0]['svr_auth_lvl'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.nochk_overlap = maps[0]['nochk_overlap'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CStaffMstField.comp_cd : this.comp_cd,
      CStaffMstField.staff_cd : this.staff_cd,
      CStaffMstField.stre_cd : this.stre_cd,
      CStaffMstField.name : this.name,
      CStaffMstField.passwd : this.passwd,
      CStaffMstField.auth_lvl : this.auth_lvl,
      CStaffMstField.svr_auth_lvl : this.svr_auth_lvl,
      CStaffMstField.ins_datetime : this.ins_datetime,
      CStaffMstField.upd_datetime : this.upd_datetime,
      CStaffMstField.status : this.status,
      CStaffMstField.send_flg : this.send_flg,
      CStaffMstField.upd_user : this.upd_user,
      CStaffMstField.upd_system : this.upd_system,
      CStaffMstField.nochk_overlap : this.nochk_overlap,
    };
  }
}

/// 09_1  従業員マスタ c_staff_mstのフィールド名設定用クラス
class CStaffMstField {
  static const comp_cd = "comp_cd";
  static const staff_cd = "staff_cd";
  static const stre_cd = "stre_cd";
  static const name = "name";
  static const passwd = "passwd";
  static const auth_lvl = "auth_lvl";
  static const svr_auth_lvl = "svr_auth_lvl";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const nochk_overlap = "nochk_overlap";
}
//endregion
//region 09_2	従業員権限マスタ	c_staffauth_mst
/// 09_2  従業員権限マスタ c_staffauth_mstクラス
class CStaffauthMstColumns extends TableColumns{
  int? comp_cd;
  int? auth_lvl;
  String? auth_name;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_staffauth_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND auth_lvl = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(auth_lvl);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStaffauthMstColumns rn = CStaffauthMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.auth_lvl = maps[i]['auth_lvl'];
      rn.auth_name = maps[i]['auth_name'];
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
    CStaffauthMstColumns rn = CStaffauthMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.auth_lvl = maps[0]['auth_lvl'];
    rn.auth_name = maps[0]['auth_name'];
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
      CStaffauthMstField.comp_cd : this.comp_cd,
      CStaffauthMstField.auth_lvl : this.auth_lvl,
      CStaffauthMstField.auth_name : this.auth_name,
      CStaffauthMstField.ins_datetime : this.ins_datetime,
      CStaffauthMstField.upd_datetime : this.upd_datetime,
      CStaffauthMstField.status : this.status,
      CStaffauthMstField.send_flg : this.send_flg,
      CStaffauthMstField.upd_user : this.upd_user,
      CStaffauthMstField.upd_system : this.upd_system,
    };
  }
}

/// 09_2  従業員権限マスタ c_staffauth_mstのフィールド名設定用クラス
class CStaffauthMstField {
  static const comp_cd = "comp_cd";
  static const auth_lvl = "auth_lvl";
  static const auth_name = "auth_name";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 09_3	サーバー従業員権限マスタ	s_svr_staffauth_mst
/// 09_3  サーバー従業員権限マスタ s_svr_staffauth_mstクラス
class SSvrStaffauthMstColumns extends TableColumns{
  int? comp_cd;
  int? svr_auth_lvl;
  String? svr_auth_name;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "s_svr_staffauth_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND svr_auth_lvl = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(svr_auth_lvl);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      SSvrStaffauthMstColumns rn = SSvrStaffauthMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.svr_auth_lvl = maps[i]['svr_auth_lvl'];
      rn.svr_auth_name = maps[i]['svr_auth_name'];
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
    SSvrStaffauthMstColumns rn = SSvrStaffauthMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.svr_auth_lvl = maps[0]['svr_auth_lvl'];
    rn.svr_auth_name = maps[0]['svr_auth_name'];
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
      SSvrStaffauthMstField.comp_cd : this.comp_cd,
      SSvrStaffauthMstField.svr_auth_lvl : this.svr_auth_lvl,
      SSvrStaffauthMstField.svr_auth_name : this.svr_auth_name,
      SSvrStaffauthMstField.ins_datetime : this.ins_datetime,
      SSvrStaffauthMstField.upd_datetime : this.upd_datetime,
      SSvrStaffauthMstField.status : this.status,
      SSvrStaffauthMstField.send_flg : this.send_flg,
      SSvrStaffauthMstField.upd_user : this.upd_user,
      SSvrStaffauthMstField.upd_system : this.upd_system,
    };
  }
}

/// 09_3  サーバー従業員権限マスタ s_svr_staffauth_mstのフィールド名設定用クラス
class SSvrStaffauthMstField {
  static const comp_cd = "comp_cd";
  static const svr_auth_lvl = "svr_auth_lvl";
  static const svr_auth_name = "svr_auth_name";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 09_4	ファンクション操作権限マスタ	c_keyauth_mst
/// 09_4  ファンクション操作権限マスタ c_keyauth_mstクラス
class CKeyauthMstColumns extends TableColumns{
  int? comp_cd;
  int? auth_lvl;
  int? fnc_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_keyauth_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND auth_lvl = ? AND fnc_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(auth_lvl);
    rn.add(fnc_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CKeyauthMstColumns rn = CKeyauthMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.auth_lvl = maps[i]['auth_lvl'];
      rn.fnc_cd = maps[i]['fnc_cd'];
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
    CKeyauthMstColumns rn = CKeyauthMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.auth_lvl = maps[0]['auth_lvl'];
    rn.fnc_cd = maps[0]['fnc_cd'];
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
      CKeyauthMstField.comp_cd : this.comp_cd,
      CKeyauthMstField.auth_lvl : this.auth_lvl,
      CKeyauthMstField.fnc_cd : this.fnc_cd,
      CKeyauthMstField.ins_datetime : this.ins_datetime,
      CKeyauthMstField.upd_datetime : this.upd_datetime,
      CKeyauthMstField.status : this.status,
      CKeyauthMstField.send_flg : this.send_flg,
      CKeyauthMstField.upd_user : this.upd_user,
      CKeyauthMstField.upd_system : this.upd_system,
    };
  }
}

/// 09_4  ファンクション操作権限マスタ c_keyauth_mstのフィールド名設定用クラス
class CKeyauthMstField {
  static const comp_cd = "comp_cd";
  static const auth_lvl = "auth_lvl";
  static const fnc_cd = "fnc_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 09_5	レジメニュー操作権限マスタ	c_menuauth_mst
/// 09_5  レジメニュー操作権限マスタ  c_menuauth_mstクラス
class CMenuauthMstColumns extends TableColumns{
  int? comp_cd;
  int? auth_lvl;
  int? appl_grp_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int menu_chk_flg = 0;

  @override
  String _getTableName() => "c_menuauth_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND auth_lvl = ? AND appl_grp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(auth_lvl);
    rn.add(appl_grp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMenuauthMstColumns rn = CMenuauthMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.auth_lvl = maps[i]['auth_lvl'];
      rn.appl_grp_cd = maps[i]['appl_grp_cd'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.menu_chk_flg = maps[i]['menu_chk_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CMenuauthMstColumns rn = CMenuauthMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.auth_lvl = maps[0]['auth_lvl'];
    rn.appl_grp_cd = maps[0]['appl_grp_cd'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.menu_chk_flg = maps[0]['menu_chk_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CMenuauthMstField.comp_cd : this.comp_cd,
      CMenuauthMstField.auth_lvl : this.auth_lvl,
      CMenuauthMstField.appl_grp_cd : this.appl_grp_cd,
      CMenuauthMstField.ins_datetime : this.ins_datetime,
      CMenuauthMstField.upd_datetime : this.upd_datetime,
      CMenuauthMstField.status : this.status,
      CMenuauthMstField.send_flg : this.send_flg,
      CMenuauthMstField.upd_user : this.upd_user,
      CMenuauthMstField.upd_system : this.upd_system,
      CMenuauthMstField.menu_chk_flg : this.menu_chk_flg,
    };
  }
}

/// 09_5  レジメニュー操作権限マスタ  c_menuauth_mstのフィールド名設定用クラス
class CMenuauthMstField {
  static const comp_cd = "comp_cd";
  static const auth_lvl = "auth_lvl";
  static const appl_grp_cd = "appl_grp_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const menu_chk_flg = "menu_chk_flg";
}
//endregion
//region 09_6	従業員オープン情報マスタ	c_staffopen_mst
/// 09_6  従業員オープン情報マスタ c_staffopen_mstクラス
class CStaffopenMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  String? chkr_cd;
  String? chkr_name;
  int chkr_status = 0;
  String? chkr_open_time;
  int chkr_start_no = 0;
  int chkr_end_no = 0;
  String? cshr_cd;
  String? cshr_name;
  int cshr_status = 0;
  String? cshr_open_time;
  int cshr_start_no = 0;
  int cshr_end_no = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_staffopen_mst";

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
      CStaffopenMstColumns rn = CStaffopenMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.chkr_cd = maps[i]['chkr_cd'];
      rn.chkr_name = maps[i]['chkr_name'];
      rn.chkr_status = maps[i]['chkr_status'];
      rn.chkr_open_time = maps[i]['chkr_open_time'];
      rn.chkr_start_no = maps[i]['chkr_start_no'];
      rn.chkr_end_no = maps[i]['chkr_end_no'];
      rn.cshr_cd = maps[i]['cshr_cd'];
      rn.cshr_name = maps[i]['cshr_name'];
      rn.cshr_status = maps[i]['cshr_status'];
      rn.cshr_open_time = maps[i]['cshr_open_time'];
      rn.cshr_start_no = maps[i]['cshr_start_no'];
      rn.cshr_end_no = maps[i]['cshr_end_no'];
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
    CStaffopenMstColumns rn = CStaffopenMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.chkr_cd = maps[0]['chkr_cd'];
    rn.chkr_name = maps[0]['chkr_name'];
    rn.chkr_status = maps[0]['chkr_status'];
    rn.chkr_open_time = maps[0]['chkr_open_time'];
    rn.chkr_start_no = maps[0]['chkr_start_no'];
    rn.chkr_end_no = maps[0]['chkr_end_no'];
    rn.cshr_cd = maps[0]['cshr_cd'];
    rn.cshr_name = maps[0]['cshr_name'];
    rn.cshr_status = maps[0]['cshr_status'];
    rn.cshr_open_time = maps[0]['cshr_open_time'];
    rn.cshr_start_no = maps[0]['cshr_start_no'];
    rn.cshr_end_no = maps[0]['cshr_end_no'];
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
      CStaffopenMstField.comp_cd : this.comp_cd,
      CStaffopenMstField.stre_cd : this.stre_cd,
      CStaffopenMstField.mac_no : this.mac_no,
      CStaffopenMstField.chkr_cd : this.chkr_cd,
      CStaffopenMstField.chkr_name : this.chkr_name,
      CStaffopenMstField.chkr_status : this.chkr_status,
      CStaffopenMstField.chkr_open_time : this.chkr_open_time,
      CStaffopenMstField.chkr_start_no : this.chkr_start_no,
      CStaffopenMstField.chkr_end_no : this.chkr_end_no,
      CStaffopenMstField.cshr_cd : this.cshr_cd,
      CStaffopenMstField.cshr_name : this.cshr_name,
      CStaffopenMstField.cshr_status : this.cshr_status,
      CStaffopenMstField.cshr_open_time : this.cshr_open_time,
      CStaffopenMstField.cshr_start_no : this.cshr_start_no,
      CStaffopenMstField.cshr_end_no : this.cshr_end_no,
      CStaffopenMstField.ins_datetime : this.ins_datetime,
      CStaffopenMstField.upd_datetime : this.upd_datetime,
      CStaffopenMstField.status : this.status,
      CStaffopenMstField.send_flg : this.send_flg,
      CStaffopenMstField.upd_user : this.upd_user,
      CStaffopenMstField.upd_system : this.upd_system,
    };
  }
}

/// 09_6  従業員オープン情報マスタ c_staffopen_mstのフィールド名設定用クラス
class CStaffopenMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const chkr_cd = "chkr_cd";
  static const chkr_name = "chkr_name";
  static const chkr_status = "chkr_status";
  static const chkr_open_time = "chkr_open_time";
  static const chkr_start_no = "chkr_start_no";
  static const chkr_end_no = "chkr_end_no";
  static const cshr_cd = "cshr_cd";
  static const cshr_name = "cshr_name";
  static const cshr_status = "cshr_status";
  static const cshr_open_time = "cshr_open_time";
  static const cshr_start_no = "cshr_start_no";
  static const cshr_end_no = "cshr_end_no";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 09_7	特定操作マスタ	c_operation_mst
/// 09_7  特定操作マスタ  c_operation_mstクラス
class COperationMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? ope_cd;
  String? ope_name;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_operation_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND ope_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(ope_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      COperationMstColumns rn = COperationMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.ope_cd = maps[i]['ope_cd'];
      rn.ope_name = maps[i]['ope_name'];
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
    COperationMstColumns rn = COperationMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.ope_cd = maps[0]['ope_cd'];
    rn.ope_name = maps[0]['ope_name'];
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
      COperationMstField.comp_cd : this.comp_cd,
      COperationMstField.stre_cd : this.stre_cd,
      COperationMstField.ope_cd : this.ope_cd,
      COperationMstField.ope_name : this.ope_name,
      COperationMstField.ins_datetime : this.ins_datetime,
      COperationMstField.upd_datetime : this.upd_datetime,
      COperationMstField.status : this.status,
      COperationMstField.send_flg : this.send_flg,
      COperationMstField.upd_user : this.upd_user,
      COperationMstField.upd_system : this.upd_system,
    };
  }
}

/// 09_7  特定操作マスタ  c_operation_mstのフィールド名設定用クラス
class COperationMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const ope_cd = "ope_cd";
  static const ope_name = "ope_name";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 09_8	特定操作権限マスタ	c_operationauth_mst
/// 09_8  特定操作権限マスタ  c_operationauth_mstクラス
class COperationauthMstColumns extends TableColumns{
  int? comp_cd;
  int? auth_lvl;
  int? ope_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_operationauth_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND auth_lvl = ? AND ope_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(auth_lvl);
    rn.add(ope_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      COperationauthMstColumns rn = COperationauthMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.auth_lvl = maps[i]['auth_lvl'];
      rn.ope_cd = maps[i]['ope_cd'];
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
    COperationauthMstColumns rn = COperationauthMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.auth_lvl = maps[0]['auth_lvl'];
    rn.ope_cd = maps[0]['ope_cd'];
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
      COperationauthMstField.comp_cd : this.comp_cd,
      COperationauthMstField.auth_lvl : this.auth_lvl,
      COperationauthMstField.ope_cd : this.ope_cd,
      COperationauthMstField.ins_datetime : this.ins_datetime,
      COperationauthMstField.upd_datetime : this.upd_datetime,
      COperationauthMstField.status : this.status,
      COperationauthMstField.send_flg : this.send_flg,
      COperationauthMstField.upd_user : this.upd_user,
      COperationauthMstField.upd_system : this.upd_system,
    };
  }
}

/// 09_8  特定操作権限マスタ  c_operationauth_mstのフィールド名設定用クラス
class COperationauthMstField {
  static const comp_cd = "comp_cd";
  static const auth_lvl = "auth_lvl";
  static const ope_cd = "ope_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion