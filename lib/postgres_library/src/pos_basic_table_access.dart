/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
03_POS基本マスタ系
03_1	レジ情報マスタ	c_reginfo_mst
03_2	レジ開閉店情報マスタ	c_openclose_mst
03_3	レジ接続機器SIO情報マスタ	c_regcnct_sio_mst
03_4	SIO情報マスタ	c_sio_mst
03_5	レジ情報グループ管理マスタ	c_reginfo_grp_mst
03_6	イメージマスタ	c_img_mst
03_7	プリセットキーマスタ	c_preset_mst
03_8	画像プリセットマスタ	c_preset_img_mst
03_9	共通コントロールマスタ	c_ctrl_mst
03_10	共通コントロール設定マスタ	c_ctrl_set_mst
03_11	共通コントロールサブマスタ	c_ctrl_sub_mst
03_12	ターミナルマスタ	c_trm_mst
03_13	ターミナル設定マスタ	c_trm_set_mst
03_14	ターミナルサブマスタ	c_trm_sub_mst
03_15	ターミナルメニューマスタ	c_trm_menu_mst
03_16	ターミナルタググループマスタ	c_trm_tag_grp_mst
03_17	ファンクションキーマスタ	c_keyfnc_mst
03_18	キーオプションマスタ	c_keyopt_mst
03_19	キー種別マスタ	c_keykind_mst
03_20	キー種別管理マスタ	c_keykind_grp_mst
03_21	キーオプション設定マスタ	c_keyopt_set_mst
03_22	キーオプションサブマスタ	c_keyopt_sub_mst
03_23	区分マスタ	c_divide_mst
03_24	仮登録ログ	c_tmp_log
03_25	売価変更マスタ	c_prcchg_mst
03_26	予約レポートマスタ	c_batrepo_mst
03_27	レポートカウンタ	c_report_cnt
03_28	レジメモマスタ	c_memo_mst
03_29	レジメモ連絡先マスタ	c_memosnd_mst
03_30	承認キーグループマスタ	c_recog_grp_mst
03_31	承認キーマスタ	p_recog_mst
03_32	承認キー情報マスタ	c_recoginfo_mst
03_33	帳票マスタ	c_report_mst
03_34	メニューオブジェクト割当マスタ	c_menu_obj_mst
03_35	トリガーキー割当マスタ	p_trigger_key_mst
03_36	ファイル初期・リクエストマスタ	c_finit_mst
03_37	ファイル初期・リクエストグループマスタ	c_finit_grp_mst
03_38	テーブル名管理マスタ	c_set_tbl_name_mst
03_39	アプリグループマスタ	c_appl_grp_mst
03_40	アプリマスタ	p_appl_mst
03_41	ダイアログマスタ	c_dialog_mst
03_42	ダイアログマスタ(英語)	c_dialog_ex_mst
03_43	プロモーションスケジュールマスタ	p_promsch_mst
03_44	プロモーション商品マスタ	p_promitem_mst
03_45	インストアマーキングマスタ	c_instre_mst
03_46	フォーマットタイプマスタ	c_fmttyp_mst
03_47	バーコードフォーマットマスタ	c_barfmt_mst
03_48	メッセージマスタ	c_msg_mst
03_49	メッセージレイアウトマスタ	c_msglayout_mst
03_50	メッセージスケジュールマスタ	c_msgsch_mst
03_51	メッセージスケジュールレイアウトマスタ	c_msgsch_layout_mst
03_52	ターミナルチェックマスタ	c_trm_chk_mst
03_53	帳票印字条件マスタ	c_report_cond_mst
03_54	帳票属性マスタ	c_report_attr_mst
03_55	帳票属性サブマスタ	c_report_attr_sub_mst
03_56	帳票SQLマスタ	c_report_sql_mst
03_57	件数確認マスタ	c_tcount_mst
03_58	自動開閉店マスタ	c_stropncls_mst
03_59	自動開閉店設定マスタ	c_stropncls_set_mst
03_60	自動開閉店サブマスタ	c_stropncls_sub_mst
03_61	キャッシュリサイクルマスタ	c_cashrecycle_mst
03_62	キャッシュリサイクル設定マスタ	c_cashrecycle_set_mst
03_63	キャッシュリサイクルサブマスタ	c_cashrecycle_sub_mst
03_64	キャッシュリサイクル管理マスタ	c_cashrecycle_info_mst
03_65	メッセージレイアウト設定マスタ	c_msglayout_set_mst
03_66	コード決済事業者マスタ	c_payoperator_mst
c_batprcchg_mst c_batprcchg_mst
区分マスタ2 c_divide2_mst
 */
//region 03_1	レジ情報マスタ	c_reginfo_mst
/// 03_1  レジ情報マスタ  c_reginfo_mstクラス
class CReginfoMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int mac_typ = 0;
  String? mac_addr;
  String? ip_addr;
  String? brdcast_addr;
  String? ip_addr2;
  String? brdcast_addr2;
  int org_mac_no = 0;
  String? crdt_trm_cd;
  int set_owner_flg = 0;
  int mac_role1 = 0;
  int mac_role2 = 0;
  int mac_role3 = 0;
  int pbchg_flg = 0;
  int auto_opn_cshr_cd = 0;
  int auto_opn_chkr_cd = 0;
  int auto_cls_cshr_cd = 0;
  String? start_datetime;
  String? end_datetime;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  String? mac_name;

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
      CReginfoMstColumns rn = CReginfoMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.mac_typ = maps[i]['mac_typ'];
      rn.mac_addr = maps[i]['mac_addr'];
      rn.ip_addr = maps[i]['ip_addr'];
      rn.brdcast_addr = maps[i]['brdcast_addr'];
      rn.ip_addr2 = maps[i]['ip_addr2'];
      rn.brdcast_addr2 = maps[i]['brdcast_addr2'];
      rn.org_mac_no = maps[i]['org_mac_no'];
      rn.crdt_trm_cd = maps[i]['crdt_trm_cd'];
      rn.set_owner_flg = maps[i]['set_owner_flg'];
      rn.mac_role1 = maps[i]['mac_role1'];
      rn.mac_role2 = maps[i]['mac_role2'];
      rn.mac_role3 = maps[i]['mac_role3'];
      rn.pbchg_flg = maps[i]['pbchg_flg'];
      rn.auto_opn_cshr_cd = maps[i]['auto_opn_cshr_cd'];
      rn.auto_opn_chkr_cd = maps[i]['auto_opn_chkr_cd'];
      rn.auto_cls_cshr_cd = maps[i]['auto_cls_cshr_cd'];
      rn.start_datetime = maps[i]['start_datetime'];
      rn.end_datetime = maps[i]['end_datetime'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.mac_name = maps[i]['mac_name'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReginfoMstColumns rn = CReginfoMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.mac_typ = maps[0]['mac_typ'];
    rn.mac_addr = maps[0]['mac_addr'];
    rn.ip_addr = maps[0]['ip_addr'];
    rn.brdcast_addr = maps[0]['brdcast_addr'];
    rn.ip_addr2 = maps[0]['ip_addr2'];
    rn.brdcast_addr2 = maps[0]['brdcast_addr2'];
    rn.org_mac_no = maps[0]['org_mac_no'];
    rn.crdt_trm_cd = maps[0]['crdt_trm_cd'];
    rn.set_owner_flg = maps[0]['set_owner_flg'];
    rn.mac_role1 = maps[0]['mac_role1'];
    rn.mac_role2 = maps[0]['mac_role2'];
    rn.mac_role3 = maps[0]['mac_role3'];
    rn.pbchg_flg = maps[0]['pbchg_flg'];
    rn.auto_opn_cshr_cd = maps[0]['auto_opn_cshr_cd'];
    rn.auto_opn_chkr_cd = maps[0]['auto_opn_chkr_cd'];
    rn.auto_cls_cshr_cd = maps[0]['auto_cls_cshr_cd'];
    rn.start_datetime = maps[0]['start_datetime'];
    rn.end_datetime = maps[0]['end_datetime'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.mac_name = maps[0]['mac_name'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReginfoMstField.comp_cd : this.comp_cd,
      CReginfoMstField.stre_cd : this.stre_cd,
      CReginfoMstField.mac_no : this.mac_no,
      CReginfoMstField.mac_typ : this.mac_typ,
      CReginfoMstField.mac_addr : this.mac_addr,
      CReginfoMstField.ip_addr : this.ip_addr,
      CReginfoMstField.brdcast_addr : this.brdcast_addr,
      CReginfoMstField.ip_addr2 : this.ip_addr2,
      CReginfoMstField.brdcast_addr2 : this.brdcast_addr2,
      CReginfoMstField.org_mac_no : this.org_mac_no,
      CReginfoMstField.crdt_trm_cd : this.crdt_trm_cd,
      CReginfoMstField.set_owner_flg : this.set_owner_flg,
      CReginfoMstField.mac_role1 : this.mac_role1,
      CReginfoMstField.mac_role2 : this.mac_role2,
      CReginfoMstField.mac_role3 : this.mac_role3,
      CReginfoMstField.pbchg_flg : this.pbchg_flg,
      CReginfoMstField.auto_opn_cshr_cd : this.auto_opn_cshr_cd,
      CReginfoMstField.auto_opn_chkr_cd : this.auto_opn_chkr_cd,
      CReginfoMstField.auto_cls_cshr_cd : this.auto_cls_cshr_cd,
      CReginfoMstField.start_datetime : this.start_datetime,
      CReginfoMstField.end_datetime : this.end_datetime,
      CReginfoMstField.ins_datetime : this.ins_datetime,
      CReginfoMstField.upd_datetime : this.upd_datetime,
      CReginfoMstField.status : this.status,
      CReginfoMstField.send_flg : this.send_flg,
      CReginfoMstField.upd_user : this.upd_user,
      CReginfoMstField.upd_system : this.upd_system,
      CReginfoMstField.mac_name : this.mac_name,
    };
  }
}

/// 03_1  レジ情報マスタ  c_reginfo_mstのフィールド名設定用クラス
class CReginfoMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const mac_typ = "mac_typ";
  static const mac_addr = "mac_addr";
  static const ip_addr = "ip_addr";
  static const brdcast_addr = "brdcast_addr";
  static const ip_addr2 = "ip_addr2";
  static const brdcast_addr2 = "brdcast_addr2";
  static const org_mac_no = "org_mac_no";
  static const crdt_trm_cd = "crdt_trm_cd";
  static const set_owner_flg = "set_owner_flg";
  static const mac_role1 = "mac_role1";
  static const mac_role2 = "mac_role2";
  static const mac_role3 = "mac_role3";
  static const pbchg_flg = "pbchg_flg";
  static const auto_opn_cshr_cd = "auto_opn_cshr_cd";
  static const auto_opn_chkr_cd = "auto_opn_chkr_cd";
  static const auto_cls_cshr_cd = "auto_cls_cshr_cd";
  static const start_datetime = "start_datetime";
  static const end_datetime = "end_datetime";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const mac_name = "mac_name";
}
//endregion
//region 03_2	レジ開閉店情報マスタ	c_openclose_mst
/// 03_2  レジ開閉店情報マスタ c_openclose_mstクラス
class COpencloseMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  String? sale_date;
  int open_flg = 0;
  int close_flg = 0;
  int not_update_flg = 0;
  int log_not_sndflg = 0;
  int custlog_not_sndflg = 0;
  int custlog_not_delflg = 0;
  int stepup_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  String? pos_ver;
  String? pos_sub_ver;
  int recal_flg = 0;

  @override
  String _getTableName() => "c_openclose_mst";

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
      COpencloseMstColumns rn = COpencloseMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.sale_date = maps[i]['sale_date'];
      rn.open_flg = maps[i]['open_flg'];
      rn.close_flg = maps[i]['close_flg'];
      rn.not_update_flg = maps[i]['not_update_flg'];
      rn.log_not_sndflg = maps[i]['log_not_sndflg'];
      rn.custlog_not_sndflg = maps[i]['custlog_not_sndflg'];
      rn.custlog_not_delflg = maps[i]['custlog_not_delflg'];
      rn.stepup_flg = maps[i]['stepup_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.pos_ver = maps[i]['pos_ver'];
      rn.pos_sub_ver = maps[i]['pos_sub_ver'];
      rn.recal_flg = maps[i]['recal_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    COpencloseMstColumns rn = COpencloseMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.sale_date = maps[0]['sale_date'];
    rn.open_flg = maps[0]['open_flg'];
    rn.close_flg = maps[0]['close_flg'];
    rn.not_update_flg = maps[0]['not_update_flg'];
    rn.log_not_sndflg = maps[0]['log_not_sndflg'];
    rn.custlog_not_sndflg = maps[0]['custlog_not_sndflg'];
    rn.custlog_not_delflg = maps[0]['custlog_not_delflg'];
    rn.stepup_flg = maps[0]['stepup_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.pos_ver = maps[0]['pos_ver'];
    rn.pos_sub_ver = maps[0]['pos_sub_ver'];
    rn.recal_flg = maps[0]['recal_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      COpencloseMstField.comp_cd : this.comp_cd,
      COpencloseMstField.stre_cd : this.stre_cd,
      COpencloseMstField.mac_no : this.mac_no,
      COpencloseMstField.sale_date : this.sale_date,
      COpencloseMstField.open_flg : this.open_flg,
      COpencloseMstField.close_flg : this.close_flg,
      COpencloseMstField.not_update_flg : this.not_update_flg,
      COpencloseMstField.log_not_sndflg : this.log_not_sndflg,
      COpencloseMstField.custlog_not_sndflg : this.custlog_not_sndflg,
      COpencloseMstField.custlog_not_delflg : this.custlog_not_delflg,
      COpencloseMstField.stepup_flg : this.stepup_flg,
      COpencloseMstField.ins_datetime : this.ins_datetime,
      COpencloseMstField.upd_datetime : this.upd_datetime,
      COpencloseMstField.status : this.status,
      COpencloseMstField.send_flg : this.send_flg,
      COpencloseMstField.upd_user : this.upd_user,
      COpencloseMstField.upd_system : this.upd_system,
      COpencloseMstField.pos_ver : this.pos_ver,
      COpencloseMstField.pos_sub_ver : this.pos_sub_ver,
      COpencloseMstField.recal_flg : this.recal_flg,
    };
  }
}

/// 03_2  レジ開閉店情報マスタ c_openclose_mstのフィールド名設定用クラス
class COpencloseMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const sale_date = "sale_date";
  static const open_flg = "open_flg";
  static const close_flg = "close_flg";
  static const not_update_flg = "not_update_flg";
  static const log_not_sndflg = "log_not_sndflg";
  static const custlog_not_sndflg = "custlog_not_sndflg";
  static const custlog_not_delflg = "custlog_not_delflg";
  static const stepup_flg = "stepup_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const pos_ver = "pos_ver";
  static const pos_sub_ver = "pos_sub_ver";
  static const recal_flg = "recal_flg";
}
//endregion
//region 03_3	レジ接続機器SIO情報マスタ	c_regcnct_sio_mst
/// 03_3  レジ接続機器SIO情報マスタ c_regcnct_sio_mstクラス
class CRegcnctSioMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? com_port_no;
  int cnct_kind = 0;
  int cnct_grp = 0;
  int sio_rate = 0;
  int sio_stop = 0;
  int sio_record = 0;
  int sio_parity = 0;
  int qcjc_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_regcnct_sio_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND com_port_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(com_port_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CRegcnctSioMstColumns rn = CRegcnctSioMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.com_port_no = maps[i]['com_port_no'];
      rn.cnct_kind = maps[i]['cnct_kind'];
      rn.cnct_grp = maps[i]['cnct_grp'];
      rn.sio_rate = maps[i]['sio_rate'];
      rn.sio_stop = maps[i]['sio_stop'];
      rn.sio_record = maps[i]['sio_record'];
      rn.sio_parity = maps[i]['sio_parity'];
      rn.qcjc_flg = maps[i]['qcjc_flg'];
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
    CRegcnctSioMstColumns rn = CRegcnctSioMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.com_port_no = maps[0]['com_port_no'];
    rn.cnct_kind = maps[0]['cnct_kind'];
    rn.cnct_grp = maps[0]['cnct_grp'];
    rn.sio_rate = maps[0]['sio_rate'];
    rn.sio_stop = maps[0]['sio_stop'];
    rn.sio_record = maps[0]['sio_record'];
    rn.sio_parity = maps[0]['sio_parity'];
    rn.qcjc_flg = maps[0]['qcjc_flg'];
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
      CRegcnctSioMstField.comp_cd : this.comp_cd,
      CRegcnctSioMstField.stre_cd : this.stre_cd,
      CRegcnctSioMstField.mac_no : this.mac_no,
      CRegcnctSioMstField.com_port_no : this.com_port_no,
      CRegcnctSioMstField.cnct_kind : this.cnct_kind,
      CRegcnctSioMstField.cnct_grp : this.cnct_grp,
      CRegcnctSioMstField.sio_rate : this.sio_rate,
      CRegcnctSioMstField.sio_stop : this.sio_stop,
      CRegcnctSioMstField.sio_record : this.sio_record,
      CRegcnctSioMstField.sio_parity : this.sio_parity,
      CRegcnctSioMstField.qcjc_flg : this.qcjc_flg,
      CRegcnctSioMstField.ins_datetime : this.ins_datetime,
      CRegcnctSioMstField.upd_datetime : this.upd_datetime,
      CRegcnctSioMstField.status : this.status,
      CRegcnctSioMstField.send_flg : this.send_flg,
      CRegcnctSioMstField.upd_user : this.upd_user,
      CRegcnctSioMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_3  レジ接続機器SIO情報マスタ c_regcnct_sio_mstのフィールド名設定用クラス
class CRegcnctSioMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const com_port_no = "com_port_no";
  static const cnct_kind = "cnct_kind";
  static const cnct_grp = "cnct_grp";
  static const sio_rate = "sio_rate";
  static const sio_stop = "sio_stop";
  static const sio_record = "sio_record";
  static const sio_parity = "sio_parity";
  static const qcjc_flg = "qcjc_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_4	SIO情報マスタ	c_sio_mst
/// 03_4  SIO情報マスタ c_sio_mstクラス
class CSioMstColumns extends TableColumns{
  int? cnct_kind;
  int cnct_grp = 0;
  String? drv_sec_name;
  int sio_image_cd = 0;
  int sio_rate = 0;
  int sio_stop = 0;
  int sio_record = 0;
  int sio_parity = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_sio_mst";

  @override
  String? _getKeyCondition() => 'cnct_kind = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(cnct_kind);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CSioMstColumns rn = CSioMstColumns();
      rn.cnct_kind = maps[i]['cnct_kind'];
      rn.cnct_grp = maps[i]['cnct_grp'];
      rn.drv_sec_name = maps[i]['drv_sec_name'];
      rn.sio_image_cd = maps[i]['sio_image_cd'];
      rn.sio_rate = maps[i]['sio_rate'];
      rn.sio_stop = maps[i]['sio_stop'];
      rn.sio_record = maps[i]['sio_record'];
      rn.sio_parity = maps[i]['sio_parity'];
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
    CSioMstColumns rn = CSioMstColumns();
    rn.cnct_kind = maps[0]['cnct_kind'];
    rn.cnct_grp = maps[0]['cnct_grp'];
    rn.drv_sec_name = maps[0]['drv_sec_name'];
    rn.sio_image_cd = maps[0]['sio_image_cd'];
    rn.sio_rate = maps[0]['sio_rate'];
    rn.sio_stop = maps[0]['sio_stop'];
    rn.sio_record = maps[0]['sio_record'];
    rn.sio_parity = maps[0]['sio_parity'];
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
      CSioMstField.cnct_kind : this.cnct_kind,
      CSioMstField.cnct_grp : this.cnct_grp,
      CSioMstField.drv_sec_name : this.drv_sec_name,
      CSioMstField.sio_image_cd : this.sio_image_cd,
      CSioMstField.sio_rate : this.sio_rate,
      CSioMstField.sio_stop : this.sio_stop,
      CSioMstField.sio_record : this.sio_record,
      CSioMstField.sio_parity : this.sio_parity,
      CSioMstField.ins_datetime : this.ins_datetime,
      CSioMstField.upd_datetime : this.upd_datetime,
      CSioMstField.status : this.status,
      CSioMstField.send_flg : this.send_flg,
      CSioMstField.upd_user : this.upd_user,
      CSioMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_4  SIO情報マスタ c_sio_mstのフィールド名設定用クラス
class CSioMstField {
  static const cnct_kind = "cnct_kind";
  static const cnct_grp = "cnct_grp";
  static const drv_sec_name = "drv_sec_name";
  static const sio_image_cd = "sio_image_cd";
  static const sio_rate = "sio_rate";
  static const sio_stop = "sio_stop";
  static const sio_record = "sio_record";
  static const sio_parity = "sio_parity";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_5	レジ情報グループ管理マスタ	c_reginfo_grp_mst
/// 03_5  レジ情報グループ管理マスタ  c_reginfo_grp_mstクラス
class CReginfoGrpMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? grp_typ;
  int? grp_cd = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_reginfo_grp_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND grp_typ = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(grp_typ);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReginfoGrpMstColumns rn = CReginfoGrpMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.grp_typ = maps[i]['grp_typ'];
      rn.grp_cd = maps[i]['grp_cd'];
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
    CReginfoGrpMstColumns rn = CReginfoGrpMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.grp_typ = maps[0]['grp_typ'];
    rn.grp_cd = maps[0]['grp_cd'];
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
      CReginfoGrpMstField.comp_cd : this.comp_cd,
      CReginfoGrpMstField.stre_cd : this.stre_cd,
      CReginfoGrpMstField.mac_no : this.mac_no,
      CReginfoGrpMstField.grp_typ : this.grp_typ,
      CReginfoGrpMstField.grp_cd : this.grp_cd,
      CReginfoGrpMstField.ins_datetime : this.ins_datetime,
      CReginfoGrpMstField.upd_datetime : this.upd_datetime,
      CReginfoGrpMstField.status : this.status,
      CReginfoGrpMstField.send_flg : this.send_flg,
      CReginfoGrpMstField.upd_user : this.upd_user,
      CReginfoGrpMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_5  レジ情報グループ管理マスタ  c_reginfo_grp_mstのフィールド名設定用クラス
class CReginfoGrpMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const grp_typ = "grp_typ";
  static const grp_cd = "grp_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_6	イメージマスタ	c_img_mst
/// 03_6  イメージマスタ  c_img_mstクラス
class CImgMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? img_grp_cd;
  int? img_cd;
  String? img_data;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_img_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND img_grp_cd = ? AND img_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(img_grp_cd);
    rn.add(img_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CImgMstColumns rn = CImgMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.img_grp_cd = maps[i]['img_grp_cd'];
      rn.img_cd = maps[i]['img_cd'];
      rn.img_data = maps[i]['img_data'];
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
    CImgMstColumns rn = CImgMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.img_grp_cd = maps[0]['img_grp_cd'];
    rn.img_cd = maps[0]['img_cd'];
    rn.img_data = maps[0]['img_data'];
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
      CImgMstField.comp_cd : this.comp_cd,
      CImgMstField.stre_cd : this.stre_cd,
      CImgMstField.img_grp_cd : this.img_grp_cd,
      CImgMstField.img_cd : this.img_cd,
      CImgMstField.img_data : this.img_data,
      CImgMstField.ins_datetime : this.ins_datetime,
      CImgMstField.upd_datetime : this.upd_datetime,
      CImgMstField.status : this.status,
      CImgMstField.send_flg : this.send_flg,
      CImgMstField.upd_user : this.upd_user,
      CImgMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_6  イメージマスタ  c_img_mstのフィールド名設定用クラス
class CImgMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const img_grp_cd = "img_grp_cd";
  static const img_cd = "img_cd";
  static const img_data = "img_data";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_7	プリセットキーマスタ	c_preset_mst
/// プリセットキーマスタクラス
class CPresetMstColumns extends TableColumns {
  int? comp_cd;
  int? stre_cd;
  int? preset_grp_cd;
  int? preset_cd;
  int? preset_no;
  int presetcolor = 0;
  int ky_cd = 0;
  String? ky_plu_cd;
  int ky_smlcls_cd = 0;
  int ky_size_flg = 0;
  int ky_status = 0;
  String? ky_name;
  int img_num = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => 'c_preset_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND preset_grp_cd = ? AND preset_cd = ? AND preset_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(preset_grp_cd);
    rn.add(preset_cd);
    rn.add(preset_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CPresetMstColumns rn = CPresetMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.preset_grp_cd = maps[i]['preset_grp_cd'];
      rn.preset_cd = maps[i]['preset_cd'];
      rn.preset_no = maps[i]['preset_no'];
      rn.presetcolor = maps[i]['presetcolor'];
      rn.ky_cd = maps[i]['ky_cd'];
      rn.ky_plu_cd = maps[i]['ky_plu_cd'];
      rn.ky_smlcls_cd = maps[i]['ky_smlcls_cd'];
      rn.ky_size_flg = maps[i]['ky_size_flg'];
      rn.ky_status = maps[i]['ky_status'];
      rn.ky_name = maps[i]['ky_name'];
      rn.img_num = maps[i]['img_num'];
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
    CPresetMstColumns rn = CPresetMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.preset_grp_cd = maps[0]['preset_grp_cd'];
    rn.preset_cd = maps[0]['preset_cd'];
    rn.preset_no = maps[0]['preset_no'];
    rn.presetcolor = maps[0]['presetcolor'];
    rn.ky_cd = maps[0]['ky_cd'];
    rn.ky_plu_cd = maps[0]['ky_plu_cd'];
    rn.ky_smlcls_cd = maps[0]['ky_smlcls_cd'];
    rn.ky_size_flg = maps[0]['ky_size_flg'];
    rn.ky_status = maps[0]['ky_status'];
    rn.ky_name = maps[0]['ky_name'];
    rn.img_num = maps[0]['img_num'];
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
      CPresetMstField.comp_cd: comp_cd,
      CPresetMstField.stre_cd: stre_cd,
      CPresetMstField.preset_grp_cd: preset_grp_cd,
      CPresetMstField.preset_cd: preset_cd,
      CPresetMstField.preset_no: preset_no,
      CPresetMstField.presetcolor: presetcolor,
      CPresetMstField.ky_cd: ky_cd,
      CPresetMstField.ky_plu_cd: ky_plu_cd,
      CPresetMstField.ky_smlcls_cd: ky_smlcls_cd,
      CPresetMstField.ky_size_flg: ky_size_flg,
      CPresetMstField.ky_status: ky_status,
      CPresetMstField.ky_name: ky_name,
      CPresetMstField.img_num: img_num,
      CPresetMstField.ins_datetime: ins_datetime,
      CPresetMstField.upd_datetime: upd_datetime,
      CPresetMstField.status: status,
      CPresetMstField.send_flg: send_flg,
      CPresetMstField.upd_user: upd_user,
      CPresetMstField.upd_system: upd_system,
    };
  }
}

/// プリセットキーマスタのフィールド名設定用クラス
class CPresetMstField {
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const preset_grp_cd = 'preset_grp_cd';
  static const preset_cd = 'preset_cd';
  static const preset_no = 'preset_no';
  static const presetcolor = 'presetcolor';
  static const ky_cd = 'ky_cd';
  static const ky_plu_cd = 'ky_plu_cd';
  static const ky_smlcls_cd = 'ky_smlcls_cd';
  static const ky_size_flg = 'ky_size_flg';
  static const ky_status = 'ky_status';
  static const ky_name = 'ky_name';
  static const img_num = 'img_num';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
}
//endregion
//region 03_8	画像プリセットマスタ	c_preset_img_mst
/// 画像プリセットマスタクラス
class CPresetImgMstColumns extends TableColumns {
  int? comp_cd;
  int? img_num;
  int cls_cd = 0;
  int typ = 0;
  String? name;
  int size1 = 0;
  int size2 = 0;
  int color = 0;
  int contrast = 0;
  String? memo;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => 'c_preset_img_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND img_num = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(img_num);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CPresetImgMstColumns rn = CPresetImgMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.img_num = maps[i]['img_num'];
      rn.cls_cd = maps[i]['cls_cd'];
      rn.typ = maps[i]['typ'];
      rn.name = maps[i]['name'];
      rn.size1 = maps[i]['size1'];
      rn.size2 = maps[i]['size2'];
      rn.color = maps[i]['color'];
      rn.contrast = maps[i]['contrast'];
      rn.memo = maps[i]['memo'];
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
    CPresetImgMstColumns rn = CPresetImgMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.img_num = maps[0]['img_num'];
    rn.cls_cd = maps[0]['cls_cd'];
    rn.typ = maps[0]['typ'];
    rn.name = maps[0]['name'];
    rn.size1 = maps[0]['size1'];
    rn.size2 = maps[0]['size2'];
    rn.color = maps[0]['color'];
    rn.contrast = maps[0]['contrast'];
    rn.memo = maps[0]['memo'];
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
      CPresetImgMstField.comp_cd: comp_cd,
      CPresetImgMstField.img_num: img_num,
      CPresetImgMstField.cls_cd: cls_cd,
      CPresetImgMstField.typ: typ,
      CPresetImgMstField.name: name,
      CPresetImgMstField.size1: size1,
      CPresetImgMstField.size2: size2,
      CPresetImgMstField.color: color,
      CPresetImgMstField.contrast: contrast,
      CPresetImgMstField.memo: memo,
      CPresetImgMstField.ins_datetime: ins_datetime,
      CPresetImgMstField.upd_datetime: upd_datetime,
      CPresetImgMstField.status: status,
      CPresetImgMstField.send_flg: send_flg,
      CPresetImgMstField.upd_user: upd_user,
      CPresetImgMstField.upd_system: upd_system,
    };
  }
}

/// 画像プリセットマスタのフィールド名設定用クラス
class CPresetImgMstField {
  static const comp_cd = 'comp_cd';
  static const img_num = 'img_num';
  static const cls_cd = 'cls_cd';
  static const typ = 'typ';
  static const name = 'name';
  static const size1 = 'size1';
  static const size2 = 'size2';
  static const color = 'color';
  static const contrast = 'contrast';
  static const memo = 'memo';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
}
//endregion
//region 03_9	共通コントロールマスタ	c_ctrl_mst
/// 03_9  共通コントロールマスタ  c_ctrl_mstクラス
class CCtrlMstColumns extends TableColumns{
  int? comp_cd;
  int? ctrl_cd;
  double? ctrl_data = 0;
  int data_typ = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_ctrl_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND ctrl_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(ctrl_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCtrlMstColumns rn = CCtrlMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.ctrl_cd = maps[i]['ctrl_cd'];
      rn.ctrl_data = maps[i]['ctrl_data'];
      rn.data_typ = maps[i]['data_typ'];
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
    CCtrlMstColumns rn = CCtrlMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.ctrl_cd = maps[0]['ctrl_cd'];
    rn.ctrl_data = maps[0]['ctrl_data'];
    rn.data_typ = maps[0]['data_typ'];
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
      CCtrlMstField.comp_cd : this.comp_cd,
      CCtrlMstField.ctrl_cd : this.ctrl_cd,
      CCtrlMstField.ctrl_data : this.ctrl_data,
      CCtrlMstField.data_typ : this.data_typ,
      CCtrlMstField.ins_datetime : this.ins_datetime,
      CCtrlMstField.upd_datetime : this.upd_datetime,
      CCtrlMstField.status : this.status,
      CCtrlMstField.send_flg : this.send_flg,
      CCtrlMstField.upd_user : this.upd_user,
      CCtrlMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_9  共通コントロールマスタ  c_ctrl_mstのフィールド名設定用クラス
class CCtrlMstField {
  static const comp_cd = "comp_cd";
  static const ctrl_cd = "ctrl_cd";
  static const ctrl_data = "ctrl_data";
  static const data_typ = "data_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_10	共通コントロール設定マスタ	c_ctrl_set_mst
/// 03_10 共通コントロール設定マスタ  c_ctrl_set_mstクラス
class CCtrlSetMstColumns extends TableColumns{
  int? ctrl_cd;
  String? ctrl_name;
  int ctrl_dsp_cond = 0;
  int ctrl_inp_cond = 0;
  double? ctrl_limit_max = 0;
  double? ctrl_limit_min = 0;
  int ctrl_digits = 0;
  int ctrl_zero_typ = 0;
  int ctrl_btn_color = 0;
  String? ctrl_info_comment;
  int ctrl_info_pic = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_ctrl_set_mst";

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
      CCtrlSetMstColumns rn = CCtrlSetMstColumns();
      rn.ctrl_cd = maps[i]['ctrl_cd'];
      rn.ctrl_name = maps[i]['ctrl_name'];
      rn.ctrl_dsp_cond = maps[i]['ctrl_dsp_cond'];
      rn.ctrl_inp_cond = maps[i]['ctrl_inp_cond'];
      rn.ctrl_limit_max = maps[i]['ctrl_limit_max'];
      rn.ctrl_limit_min = maps[i]['ctrl_limit_min'];
      rn.ctrl_digits = maps[i]['ctrl_digits'];
      rn.ctrl_zero_typ = maps[i]['ctrl_zero_typ'];
      rn.ctrl_btn_color = maps[i]['ctrl_btn_color'];
      rn.ctrl_info_comment = maps[i]['ctrl_info_comment'];
      rn.ctrl_info_pic = maps[i]['ctrl_info_pic'];
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
    CCtrlSetMstColumns rn = CCtrlSetMstColumns();
    rn.ctrl_cd = maps[0]['ctrl_cd'];
    rn.ctrl_name = maps[0]['ctrl_name'];
    rn.ctrl_dsp_cond = maps[0]['ctrl_dsp_cond'];
    rn.ctrl_inp_cond = maps[0]['ctrl_inp_cond'];
    rn.ctrl_limit_max = maps[0]['ctrl_limit_max'];
    rn.ctrl_limit_min = maps[0]['ctrl_limit_min'];
    rn.ctrl_digits = maps[0]['ctrl_digits'];
    rn.ctrl_zero_typ = maps[0]['ctrl_zero_typ'];
    rn.ctrl_btn_color = maps[0]['ctrl_btn_color'];
    rn.ctrl_info_comment = maps[0]['ctrl_info_comment'];
    rn.ctrl_info_pic = maps[0]['ctrl_info_pic'];
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
      CCtrlSetMstField.ctrl_cd : this.ctrl_cd,
      CCtrlSetMstField.ctrl_name : this.ctrl_name,
      CCtrlSetMstField.ctrl_dsp_cond : this.ctrl_dsp_cond,
      CCtrlSetMstField.ctrl_inp_cond : this.ctrl_inp_cond,
      CCtrlSetMstField.ctrl_limit_max : this.ctrl_limit_max,
      CCtrlSetMstField.ctrl_limit_min : this.ctrl_limit_min,
      CCtrlSetMstField.ctrl_digits : this.ctrl_digits,
      CCtrlSetMstField.ctrl_zero_typ : this.ctrl_zero_typ,
      CCtrlSetMstField.ctrl_btn_color : this.ctrl_btn_color,
      CCtrlSetMstField.ctrl_info_comment : this.ctrl_info_comment,
      CCtrlSetMstField.ctrl_info_pic : this.ctrl_info_pic,
      CCtrlSetMstField.ins_datetime : this.ins_datetime,
      CCtrlSetMstField.upd_datetime : this.upd_datetime,
      CCtrlSetMstField.status : this.status,
      CCtrlSetMstField.send_flg : this.send_flg,
      CCtrlSetMstField.upd_user : this.upd_user,
      CCtrlSetMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_10 共通コントロール設定マスタ  c_ctrl_set_mstのフィールド名設定用クラス
class CCtrlSetMstField {
  static const ctrl_cd = "ctrl_cd";
  static const ctrl_name = "ctrl_name";
  static const ctrl_dsp_cond = "ctrl_dsp_cond";
  static const ctrl_inp_cond = "ctrl_inp_cond";
  static const ctrl_limit_max = "ctrl_limit_max";
  static const ctrl_limit_min = "ctrl_limit_min";
  static const ctrl_digits = "ctrl_digits";
  static const ctrl_zero_typ = "ctrl_zero_typ";
  static const ctrl_btn_color = "ctrl_btn_color";
  static const ctrl_info_comment = "ctrl_info_comment";
  static const ctrl_info_pic = "ctrl_info_pic";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_11	共通コントロールサブマスタ	c_ctrl_sub_mst
/// 03_11 共通コントロールサブマスタ  c_ctrl_sub_mstクラス
class CCtrlSubMstColumns extends TableColumns{
  int? ctrl_cd;
  int? ctrl_ordr;
  double? ctrl_data = 0;
  int img_cd = 0;
  String? ctrl_comment;
  int ctrl_btn_color = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_ctrl_sub_mst";

  @override
  String? _getKeyCondition() => 'ctrl_cd = ? AND ctrl_ordr = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(ctrl_cd);
    rn.add(ctrl_ordr);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCtrlSubMstColumns rn = CCtrlSubMstColumns();
      rn.ctrl_cd = maps[i]['ctrl_cd'];
      rn.ctrl_ordr = maps[i]['ctrl_ordr'];
      rn.ctrl_data = maps[i]['ctrl_data'];
      rn.img_cd = maps[i]['img_cd'];
      rn.ctrl_comment = maps[i]['ctrl_comment'];
      rn.ctrl_btn_color = maps[i]['ctrl_btn_color'];
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
    CCtrlSubMstColumns rn = CCtrlSubMstColumns();
    rn.ctrl_cd = maps[0]['ctrl_cd'];
    rn.ctrl_ordr = maps[0]['ctrl_ordr'];
    rn.ctrl_data = maps[0]['ctrl_data'];
    rn.img_cd = maps[0]['img_cd'];
    rn.ctrl_comment = maps[0]['ctrl_comment'];
    rn.ctrl_btn_color = maps[0]['ctrl_btn_color'];
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
      CCtrlSubMstField.ctrl_cd : this.ctrl_cd,
      CCtrlSubMstField.ctrl_ordr : this.ctrl_ordr,
      CCtrlSubMstField.ctrl_data : this.ctrl_data,
      CCtrlSubMstField.img_cd : this.img_cd,
      CCtrlSubMstField.ctrl_comment : this.ctrl_comment,
      CCtrlSubMstField.ctrl_btn_color : this.ctrl_btn_color,
      CCtrlSubMstField.ins_datetime : this.ins_datetime,
      CCtrlSubMstField.upd_datetime : this.upd_datetime,
      CCtrlSubMstField.status : this.status,
      CCtrlSubMstField.send_flg : this.send_flg,
      CCtrlSubMstField.upd_user : this.upd_user,
      CCtrlSubMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_11 共通コントロールサブマスタ  c_ctrl_sub_mstのフィールド名設定用クラス
class CCtrlSubMstField {
  static const ctrl_cd = "ctrl_cd";
  static const ctrl_ordr = "ctrl_ordr";
  static const ctrl_data = "ctrl_data";
  static const img_cd = "img_cd";
  static const ctrl_comment = "ctrl_comment";
  static const ctrl_btn_color = "ctrl_btn_color";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_12	ターミナルマスタ	c_trm_mst
/// 03_12 ターミナルマスタ c_trm_mstクラス
class CTrmMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? trm_grp_cd;
  int? trm_cd;
  double? trm_data = 0;
  int trm_data_typ = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_trm_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND trm_grp_cd = ? AND trm_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(trm_grp_cd);
    rn.add(trm_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTrmMstColumns rn = CTrmMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.trm_grp_cd = maps[i]['trm_grp_cd'];
      rn.trm_cd = maps[i]['trm_cd'];
      rn.trm_data = maps[i]['trm_data'];
      rn.trm_data_typ = maps[i]['trm_data_typ'];
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
    CTrmMstColumns rn = CTrmMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.trm_grp_cd = maps[0]['trm_grp_cd'];
    rn.trm_cd = maps[0]['trm_cd'];
    rn.trm_data = maps[0]['trm_data'];
    rn.trm_data_typ = maps[0]['trm_data_typ'];
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
      CTrmMstField.comp_cd : this.comp_cd,
      CTrmMstField.stre_cd : this.stre_cd,
      CTrmMstField.trm_grp_cd : this.trm_grp_cd,
      CTrmMstField.trm_cd : this.trm_cd,
      CTrmMstField.trm_data : this.trm_data,
      CTrmMstField.trm_data_typ : this.trm_data_typ,
      CTrmMstField.ins_datetime : this.ins_datetime,
      CTrmMstField.upd_datetime : this.upd_datetime,
      CTrmMstField.status : this.status,
      CTrmMstField.send_flg : this.send_flg,
      CTrmMstField.upd_user : this.upd_user,
      CTrmMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_12 ターミナルマスタ c_trm_mstのフィールド名設定用クラス
class CTrmMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const trm_grp_cd = "trm_grp_cd";
  static const trm_cd = "trm_cd";
  static const trm_data = "trm_data";
  static const trm_data_typ = "trm_data_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_13	ターミナル設定マスタ	c_trm_set_mst
/// 03_13 ターミナル設定マスタ c_trm_set_mstクラス
class CTrmSetMstColumns extends TableColumns{
  int? trm_cd;
  String? trm_name;
  int trm_dsp_cond = 0;
  int trm_inp_cond = 0;
  double? trm_limit_max = 0;
  double? trm_limit_min = 0;
  int trm_digits = 0;
  int trm_zero_typ = 0;
  int trm_btn_color = 0;
  String? trm_info_comment;
  int trm_info_pic = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_trm_set_mst";

  @override
  String? _getKeyCondition() => 'trm_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(trm_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTrmSetMstColumns rn = CTrmSetMstColumns();
      rn.trm_cd = maps[i]['trm_cd'];
      rn.trm_name = maps[i]['trm_name'];
      rn.trm_dsp_cond = maps[i]['trm_dsp_cond'];
      rn.trm_inp_cond = maps[i]['trm_inp_cond'];
      rn.trm_limit_max = maps[i]['trm_limit_max'];
      rn.trm_limit_min = maps[i]['trm_limit_min'];
      rn.trm_digits = maps[i]['trm_digits'];
      rn.trm_zero_typ = maps[i]['trm_zero_typ'];
      rn.trm_btn_color = maps[i]['trm_btn_color'];
      rn.trm_info_comment = maps[i]['trm_info_comment'];
      rn.trm_info_pic = maps[i]['trm_info_pic'];
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
    CTrmSetMstColumns rn = CTrmSetMstColumns();
    rn.trm_cd = maps[0]['trm_cd'];
    rn.trm_name = maps[0]['trm_name'];
    rn.trm_dsp_cond = maps[0]['trm_dsp_cond'];
    rn.trm_inp_cond = maps[0]['trm_inp_cond'];
    rn.trm_limit_max = maps[0]['trm_limit_max'];
    rn.trm_limit_min = maps[0]['trm_limit_min'];
    rn.trm_digits = maps[0]['trm_digits'];
    rn.trm_zero_typ = maps[0]['trm_zero_typ'];
    rn.trm_btn_color = maps[0]['trm_btn_color'];
    rn.trm_info_comment = maps[0]['trm_info_comment'];
    rn.trm_info_pic = maps[0]['trm_info_pic'];
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
      CTrmSetMstField.trm_cd : this.trm_cd,
      CTrmSetMstField.trm_name : this.trm_name,
      CTrmSetMstField.trm_dsp_cond : this.trm_dsp_cond,
      CTrmSetMstField.trm_inp_cond : this.trm_inp_cond,
      CTrmSetMstField.trm_limit_max : this.trm_limit_max,
      CTrmSetMstField.trm_limit_min : this.trm_limit_min,
      CTrmSetMstField.trm_digits : this.trm_digits,
      CTrmSetMstField.trm_zero_typ : this.trm_zero_typ,
      CTrmSetMstField.trm_btn_color : this.trm_btn_color,
      CTrmSetMstField.trm_info_comment : this.trm_info_comment,
      CTrmSetMstField.trm_info_pic : this.trm_info_pic,
      CTrmSetMstField.ins_datetime : this.ins_datetime,
      CTrmSetMstField.upd_datetime : this.upd_datetime,
      CTrmSetMstField.status : this.status,
      CTrmSetMstField.send_flg : this.send_flg,
      CTrmSetMstField.upd_user : this.upd_user,
      CTrmSetMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_13 ターミナル設定マスタ c_trm_set_mstのフィールド名設定用クラス
class CTrmSetMstField {
  static const trm_cd = "trm_cd";
  static const trm_name = "trm_name";
  static const trm_dsp_cond = "trm_dsp_cond";
  static const trm_inp_cond = "trm_inp_cond";
  static const trm_limit_max = "trm_limit_max";
  static const trm_limit_min = "trm_limit_min";
  static const trm_digits = "trm_digits";
  static const trm_zero_typ = "trm_zero_typ";
  static const trm_btn_color = "trm_btn_color";
  static const trm_info_comment = "trm_info_comment";
  static const trm_info_pic = "trm_info_pic";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_14	ターミナルサブマスタ	c_trm_sub_mst
/// 03_14 ターミナルサブマスタ c_trm_sub_mstクラス
class CTrmSubMstColumns extends TableColumns{
  int? trm_cd;
  int? trm_ordr;
  double? trm_data = 0;
  int fnc_cd = 0;
  int img_cd = 0;
  String? trm_comment;
  int trm_btn_color = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_trm_sub_mst";

  @override
  String? _getKeyCondition() => 'trm_cd = ? AND trm_ordr = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(trm_cd);
    rn.add(trm_ordr);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTrmSubMstColumns rn = CTrmSubMstColumns();
      rn.trm_cd = maps[i]['trm_cd'];
      rn.trm_ordr = maps[i]['trm_ordr'];
      rn.trm_data = maps[i]['trm_data'];
      rn.fnc_cd = maps[i]['fnc_cd'];
      rn.img_cd = maps[i]['img_cd'];
      rn.trm_comment = maps[i]['trm_comment'];
      rn.trm_btn_color = maps[i]['trm_btn_color'];
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
    CTrmSubMstColumns rn = CTrmSubMstColumns();
    rn.trm_cd = maps[0]['trm_cd'];
    rn.trm_ordr = maps[0]['trm_ordr'];
    rn.trm_data = maps[0]['trm_data'];
    rn.fnc_cd = maps[0]['fnc_cd'];
    rn.img_cd = maps[0]['img_cd'];
    rn.trm_comment = maps[0]['trm_comment'];
    rn.trm_btn_color = maps[0]['trm_btn_color'];
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
      CTrmSubMstField.trm_cd : this.trm_cd,
      CTrmSubMstField.trm_ordr : this.trm_ordr,
      CTrmSubMstField.trm_data : this.trm_data,
      CTrmSubMstField.fnc_cd : this.fnc_cd,
      CTrmSubMstField.img_cd : this.img_cd,
      CTrmSubMstField.trm_comment : this.trm_comment,
      CTrmSubMstField.trm_btn_color : this.trm_btn_color,
      CTrmSubMstField.ins_datetime : this.ins_datetime,
      CTrmSubMstField.upd_datetime : this.upd_datetime,
      CTrmSubMstField.status : this.status,
      CTrmSubMstField.send_flg : this.send_flg,
      CTrmSubMstField.upd_user : this.upd_user,
      CTrmSubMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_14 ターミナルサブマスタ c_trm_sub_mstのフィールド名設定用クラス
class CTrmSubMstField {
  static const trm_cd = "trm_cd";
  static const trm_ordr = "trm_ordr";
  static const trm_data = "trm_data";
  static const fnc_cd = "fnc_cd";
  static const img_cd = "img_cd";
  static const trm_comment = "trm_comment";
  static const trm_btn_color = "trm_btn_color";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_15	ターミナルメニューマスタ	c_trm_menu_mst
/// 03_15 ターミナルメニューマスタ c_trm_menu_mstクラス
class CTrmMenuMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? menu_kind;
  String? trm_title;
  int trm_btn_max = 0;
  int? trm_page;
  int? trm_btn_pos;
  String? trm_btn_name;
  int trm_btn_color = 0;
  int trm_menu = 0;
  int trm_tag = 0;
  int trm_quick = 0;
  int cust_disp_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_trm_menu_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND menu_kind = ? AND trm_page = ? AND trm_btn_pos = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(menu_kind);
    rn.add(trm_page);
    rn.add(trm_btn_pos);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTrmMenuMstColumns rn = CTrmMenuMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.menu_kind = maps[i]['menu_kind'];
      rn.trm_title = maps[i]['trm_title'];
      rn.trm_btn_max = maps[i]['trm_btn_max'];
      rn.trm_page = maps[i]['trm_page'];
      rn.trm_btn_pos = maps[i]['trm_btn_pos'];
      rn.trm_btn_name = maps[i]['trm_btn_name'];
      rn.trm_btn_color = maps[i]['trm_btn_color'];
      rn.trm_menu = maps[i]['trm_menu'];
      rn.trm_tag = maps[i]['trm_tag'];
      rn.trm_quick = maps[i]['trm_quick'];
      rn.cust_disp_flg = maps[i]['cust_disp_flg'];
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
    CTrmMenuMstColumns rn = CTrmMenuMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.menu_kind = maps[0]['menu_kind'];
    rn.trm_title = maps[0]['trm_title'];
    rn.trm_btn_max = maps[0]['trm_btn_max'];
    rn.trm_page = maps[0]['trm_page'];
    rn.trm_btn_pos = maps[0]['trm_btn_pos'];
    rn.trm_btn_name = maps[0]['trm_btn_name'];
    rn.trm_btn_color = maps[0]['trm_btn_color'];
    rn.trm_menu = maps[0]['trm_menu'];
    rn.trm_tag = maps[0]['trm_tag'];
    rn.trm_quick = maps[0]['trm_quick'];
    rn.cust_disp_flg = maps[0]['cust_disp_flg'];
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
      CTrmMenuMstField.comp_cd : this.comp_cd,
      CTrmMenuMstField.stre_cd : this.stre_cd,
      CTrmMenuMstField.menu_kind : this.menu_kind,
      CTrmMenuMstField.trm_title : this.trm_title,
      CTrmMenuMstField.trm_btn_max : this.trm_btn_max,
      CTrmMenuMstField.trm_page : this.trm_page,
      CTrmMenuMstField.trm_btn_pos : this.trm_btn_pos,
      CTrmMenuMstField.trm_btn_name : this.trm_btn_name,
      CTrmMenuMstField.trm_btn_color : this.trm_btn_color,
      CTrmMenuMstField.trm_menu : this.trm_menu,
      CTrmMenuMstField.trm_tag : this.trm_tag,
      CTrmMenuMstField.trm_quick : this.trm_quick,
      CTrmMenuMstField.cust_disp_flg : this.cust_disp_flg,
      CTrmMenuMstField.ins_datetime : this.ins_datetime,
      CTrmMenuMstField.upd_datetime : this.upd_datetime,
      CTrmMenuMstField.status : this.status,
      CTrmMenuMstField.send_flg : this.send_flg,
      CTrmMenuMstField.upd_user : this.upd_user,
      CTrmMenuMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_15 ターミナルメニューマスタ c_trm_menu_mstのフィールド名設定用クラス
class CTrmMenuMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const menu_kind = "menu_kind";
  static const trm_title = "trm_title";
  static const trm_btn_max = "trm_btn_max";
  static const trm_page = "trm_page";
  static const trm_btn_pos = "trm_btn_pos";
  static const trm_btn_name = "trm_btn_name";
  static const trm_btn_color = "trm_btn_color";
  static const trm_menu = "trm_menu";
  static const trm_tag = "trm_tag";
  static const trm_quick = "trm_quick";
  static const cust_disp_flg = "cust_disp_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_16	ターミナルタググループマスタ	c_trm_tag_grp_mst
/// 03_16 ターミナルタググループマスタ c_trm_tag_grp_mstクラス
class CTrmTagGrpMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? trm_tag;
  int? trm_ordr;
  int? trm_cd;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_trm_tag_grp_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND trm_tag = ? AND trm_ordr = ? AND trm_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(trm_tag);
    rn.add(trm_ordr);
    rn.add(trm_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTrmTagGrpMstColumns rn = CTrmTagGrpMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.trm_tag = maps[i]['trm_tag'];
      rn.trm_ordr = maps[i]['trm_ordr'];
      rn.trm_cd = maps[i]['trm_cd'];
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
    CTrmTagGrpMstColumns rn = CTrmTagGrpMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.trm_tag = maps[0]['trm_tag'];
    rn.trm_ordr = maps[0]['trm_ordr'];
    rn.trm_cd = maps[0]['trm_cd'];
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
      CTrmTagGrpMstField.comp_cd : this.comp_cd,
      CTrmTagGrpMstField.stre_cd : this.stre_cd,
      CTrmTagGrpMstField.trm_tag : this.trm_tag,
      CTrmTagGrpMstField.trm_ordr : this.trm_ordr,
      CTrmTagGrpMstField.trm_cd : this.trm_cd,
      CTrmTagGrpMstField.ins_datetime : this.ins_datetime,
      CTrmTagGrpMstField.upd_datetime : this.upd_datetime,
      CTrmTagGrpMstField.status : this.status,
      CTrmTagGrpMstField.send_flg : this.send_flg,
      CTrmTagGrpMstField.upd_user : this.upd_user,
      CTrmTagGrpMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_16 ターミナルタググループマスタ c_trm_tag_grp_mstのフィールド名設定用クラス
class CTrmTagGrpMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const trm_tag = "trm_tag";
  static const trm_ordr = "trm_ordr";
  static const trm_cd = "trm_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_17	ファンクションキーマスタ	c_keyfnc_mst
/// ファンクションキーマスタクラス
class CKeyfncMstColumns extends TableColumns {
  int? comp_cd;
  int? stre_cd;
  int? kopt_grp_cd;
  int? fnc_cd;
  String? fnc_name;
  String? fnc_comment;
  int fnc_disp_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int ext_preset_disp = 0;

  @override
  String _getTableName() => 'c_keyfnc_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND kopt_grp_cd = ? AND fnc_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(kopt_grp_cd);
    rn.add(fnc_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CKeyfncMstColumns rn = CKeyfncMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.kopt_grp_cd = maps[i]['kopt_grp_cd'];
      rn.fnc_cd = maps[i]['fnc_cd'];
      rn.fnc_name = maps[i]['fnc_name'];
      rn.fnc_comment = maps[i]['fnc_comment'];
      rn.fnc_disp_flg = maps[i]['fnc_disp_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.ext_preset_disp = maps[i]['ext_preset_disp'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CKeyfncMstColumns rn = CKeyfncMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.kopt_grp_cd = maps[0]['kopt_grp_cd'];
    rn.fnc_cd = maps[0]['fnc_cd'];
    rn.fnc_name = maps[0]['fnc_name'];
    rn.fnc_comment = maps[0]['fnc_comment'];
    rn.fnc_disp_flg = maps[0]['fnc_disp_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.ext_preset_disp = maps[0]['ext_preset_disp'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CKeyfncMstField.comp_cd: comp_cd,
      CKeyfncMstField.stre_cd: stre_cd,
      CKeyfncMstField.kopt_grp_cd: kopt_grp_cd,
      CKeyfncMstField.fnc_cd: fnc_cd,
      CKeyfncMstField.fnc_name: fnc_name,
      CKeyfncMstField.fnc_comment: fnc_comment,
      CKeyfncMstField.fnc_disp_flg: fnc_disp_flg,
      CKeyfncMstField.ins_datetime: ins_datetime,
      CKeyfncMstField.upd_datetime: upd_datetime,
      CKeyfncMstField.status: status,
      CKeyfncMstField.send_flg: send_flg,
      CKeyfncMstField.upd_user: upd_user,
      CKeyfncMstField.upd_system: upd_system,
      CKeyfncMstField.ext_preset_disp: ext_preset_disp,
    };
  }
}

/// ファンクションキーマスタのフィールド名設定用クラス
class CKeyfncMstField {
  static const comp_cd = 'comp_cd';
  static const stre_cd = 'stre_cd';
  static const kopt_grp_cd = 'kopt_grp_cd';
  static const fnc_cd = 'fnc_cd';
  static const fnc_name = 'fnc_name';
  static const fnc_comment = 'fnc_comment';
  static const fnc_disp_flg = 'fnc_disp_flg';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
  static const ext_preset_disp = 'ext_preset_disp';
}
//endregion
//region 03_18	キーオプションマスタ	c_keyopt_mst
/// 03_18 キーオプションマスタ c_keyopt_mstクラス
class CKeyoptMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? kopt_grp_cd;
  int? fnc_cd;
  int? kopt_cd;
  int kopt_data = 0;
  String? kopt_str_data;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_keyopt_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND kopt_grp_cd = ? AND fnc_cd = ? AND kopt_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(kopt_grp_cd);
    rn.add(fnc_cd);
    rn.add(kopt_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CKeyoptMstColumns rn = CKeyoptMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.kopt_grp_cd = maps[i]['kopt_grp_cd'];
      rn.fnc_cd = maps[i]['fnc_cd'];
      rn.kopt_cd = maps[i]['kopt_cd'];
      rn.kopt_data = maps[i]['kopt_data'];
      rn.kopt_str_data = maps[i]['kopt_str_data'];
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
    CKeyoptMstColumns rn = CKeyoptMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.kopt_grp_cd = maps[0]['kopt_grp_cd'];
    rn.fnc_cd = maps[0]['fnc_cd'];
    rn.kopt_cd = maps[0]['kopt_cd'];
    rn.kopt_data = maps[0]['kopt_data'];
    rn.kopt_str_data = maps[0]['kopt_str_data'];
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
      CKeyoptMstField.comp_cd : this.comp_cd,
      CKeyoptMstField.stre_cd : this.stre_cd,
      CKeyoptMstField.kopt_grp_cd : this.kopt_grp_cd,
      CKeyoptMstField.fnc_cd : this.fnc_cd,
      CKeyoptMstField.kopt_cd : this.kopt_cd,
      CKeyoptMstField.kopt_data : this.kopt_data,
      CKeyoptMstField.kopt_str_data : this.kopt_str_data,
      CKeyoptMstField.ins_datetime : this.ins_datetime,
      CKeyoptMstField.upd_datetime : this.upd_datetime,
      CKeyoptMstField.status : this.status,
      CKeyoptMstField.send_flg : this.send_flg,
      CKeyoptMstField.upd_user : this.upd_user,
      CKeyoptMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_18 キーオプションマスタ c_keyopt_mstのフィールド名設定用クラス
class CKeyoptMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const kopt_grp_cd = "kopt_grp_cd";
  static const fnc_cd = "fnc_cd";
  static const kopt_cd = "kopt_cd";
  static const kopt_data = "kopt_data";
  static const kopt_str_data = "kopt_str_data";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_19	キー種別マスタ	c_keykind_mst
/// 03_19 キー種別マスタ  c_keykind_mstクラス
class CKeykindMstColumns extends TableColumns{
  int? key_kind_cd;
  String? kind_name;

  @override
  String _getTableName() => "c_keykind_mst";

  @override
  String? _getKeyCondition() => 'key_kind_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(key_kind_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CKeykindMstColumns rn = CKeykindMstColumns();
      rn.key_kind_cd = maps[i]['key_kind_cd'];
      rn.kind_name = maps[i]['kind_name'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CKeykindMstColumns rn = CKeykindMstColumns();
    rn.key_kind_cd = maps[0]['key_kind_cd'];
    rn.kind_name = maps[0]['kind_name'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CKeykindMstField.key_kind_cd : this.key_kind_cd,
      CKeykindMstField.kind_name : this.kind_name,
    };
  }
}

/// 03_19 キー種別マスタ  c_keykind_mstのフィールド名設定用クラス
class CKeykindMstField {
  static const key_kind_cd = "key_kind_cd";
  static const kind_name = "kind_name";
}
//endregion
//region 03_20	キー種別管理マスタ	c_keykind_grp_mst
/// キー種別管理マスタクラス
class CKeykindGrpMstColumns extends TableColumns {
  int? key_kind_cd;
  int? fnc_cd;
  int? ref_fnc_cd;

  @override
  String _getTableName() => 'c_keykind_grp_mst';

  @override
  String? _getKeyCondition() => 'key_kind_cd = ? AND fnc_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(key_kind_cd);
    rn.add(fnc_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CKeykindGrpMstColumns rn = CKeykindGrpMstColumns();
      rn.key_kind_cd = maps[i]['key_kind_cd'];
      rn.fnc_cd = maps[i]['fnc_cd'];
      rn.ref_fnc_cd = maps[i]['ref_fnc_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CKeykindGrpMstColumns rn = CKeykindGrpMstColumns();
    rn.key_kind_cd = maps[0]['key_kind_cd'];
    rn.fnc_cd = maps[0]['fnc_cd'];
    rn.ref_fnc_cd = maps[0]['ref_fnc_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CKeykindGrpMstField.key_kind_cd: key_kind_cd,
      CKeykindGrpMstField.fnc_cd: fnc_cd,
      CKeykindGrpMstField.ref_fnc_cd: ref_fnc_cd,
    };
  }
}

/// キー種別管理マスタのフィールド名設定用クラス
class CKeykindGrpMstField {
  static const key_kind_cd = 'key_kind_cd';
  static const fnc_cd = 'fnc_cd';
  static const ref_fnc_cd = 'ref_fnc_cd';
}
//endregion
//region 03_21	キーオプション設定マスタ	c_keyopt_set_mst
/// 03_21 キーオプション設定マスタ c_keyopt_set_mstクラス
class CKeyoptSetMstColumns extends TableColumns{
  int? ref_fnc_cd;
  int? kopt_cd;
  String? kopt_name;
  int kopt_dsp_cond = 0;
  int kopt_inp_cond = 0;
  int kopt_limit_max = 0;
  int kopt_limit_min = 0;
  int kopt_digits = 0;
  int kopt_zero_typ = 0;
  int kopt_btn_color = 0;
  String? kopt_info_comment;
  int kopt_info_pic = 0;
  int kopt_div_kind_cd = 0;

  @override
  String _getTableName() => "c_keyopt_set_mst";

  @override
  String? _getKeyCondition() => 'ref_fnc_cd = ? AND kopt_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(ref_fnc_cd);
    rn.add(kopt_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CKeyoptSetMstColumns rn = CKeyoptSetMstColumns();
      rn.ref_fnc_cd = maps[i]['ref_fnc_cd'];
      rn.kopt_cd = maps[i]['kopt_cd'];
      rn.kopt_name = maps[i]['kopt_name'];
      rn.kopt_dsp_cond = maps[i]['kopt_dsp_cond'];
      rn.kopt_inp_cond = maps[i]['kopt_inp_cond'];
      rn.kopt_limit_max = maps[i]['kopt_limit_max'];
      rn.kopt_limit_min = maps[i]['kopt_limit_min'];
      rn.kopt_digits = maps[i]['kopt_digits'];
      rn.kopt_zero_typ = maps[i]['kopt_zero_typ'];
      rn.kopt_btn_color = maps[i]['kopt_btn_color'];
      rn.kopt_info_comment = maps[i]['kopt_info_comment'];
      rn.kopt_info_pic = maps[i]['kopt_info_pic'];
      rn.kopt_div_kind_cd = maps[i]['kopt_div_kind_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CKeyoptSetMstColumns rn = CKeyoptSetMstColumns();
    rn.ref_fnc_cd = maps[0]['ref_fnc_cd'];
    rn.kopt_cd = maps[0]['kopt_cd'];
    rn.kopt_name = maps[0]['kopt_name'];
    rn.kopt_dsp_cond = maps[0]['kopt_dsp_cond'];
    rn.kopt_inp_cond = maps[0]['kopt_inp_cond'];
    rn.kopt_limit_max = maps[0]['kopt_limit_max'];
    rn.kopt_limit_min = maps[0]['kopt_limit_min'];
    rn.kopt_digits = maps[0]['kopt_digits'];
    rn.kopt_zero_typ = maps[0]['kopt_zero_typ'];
    rn.kopt_btn_color = maps[0]['kopt_btn_color'];
    rn.kopt_info_comment = maps[0]['kopt_info_comment'];
    rn.kopt_info_pic = maps[0]['kopt_info_pic'];
    rn.kopt_div_kind_cd = maps[0]['kopt_div_kind_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CKeyoptSetMstField.ref_fnc_cd : this.ref_fnc_cd,
      CKeyoptSetMstField.kopt_cd : this.kopt_cd,
      CKeyoptSetMstField.kopt_name : this.kopt_name,
      CKeyoptSetMstField.kopt_dsp_cond : this.kopt_dsp_cond,
      CKeyoptSetMstField.kopt_inp_cond : this.kopt_inp_cond,
      CKeyoptSetMstField.kopt_limit_max : this.kopt_limit_max,
      CKeyoptSetMstField.kopt_limit_min : this.kopt_limit_min,
      CKeyoptSetMstField.kopt_digits : this.kopt_digits,
      CKeyoptSetMstField.kopt_zero_typ : this.kopt_zero_typ,
      CKeyoptSetMstField.kopt_btn_color : this.kopt_btn_color,
      CKeyoptSetMstField.kopt_info_comment : this.kopt_info_comment,
      CKeyoptSetMstField.kopt_info_pic : this.kopt_info_pic,
      CKeyoptSetMstField.kopt_div_kind_cd : this.kopt_div_kind_cd,
    };
  }
}

/// 03_21 キーオプション設定マスタ c_keyopt_set_mstのフィールド名設定用クラス
class CKeyoptSetMstField {
  static const ref_fnc_cd = "ref_fnc_cd";
  static const kopt_cd = "kopt_cd";
  static const kopt_name = "kopt_name";
  static const kopt_dsp_cond = "kopt_dsp_cond";
  static const kopt_inp_cond = "kopt_inp_cond";
  static const kopt_limit_max = "kopt_limit_max";
  static const kopt_limit_min = "kopt_limit_min";
  static const kopt_digits = "kopt_digits";
  static const kopt_zero_typ = "kopt_zero_typ";
  static const kopt_btn_color = "kopt_btn_color";
  static const kopt_info_comment = "kopt_info_comment";
  static const kopt_info_pic = "kopt_info_pic";
  static const kopt_div_kind_cd = "kopt_div_kind_cd";
}
//endregion
//region 03_22	キーオプションサブマスタ	c_keyopt_sub_mst
/// 03_22 キーオプションサブマスタ c_keyopt_sub_mstクラス
class CKeyoptSubMstColumns extends TableColumns{
  int? ref_fnc_cd;
  int? kopt_cd;
  int? koptsub_ordr;
  int koptsub_data = 0;
  int fnc_cd = 0;
  int img_cd = 0;
  String? koptsub_comment;
  int koptsub_btn_color = 0;

  @override
  String _getTableName() => "c_keyopt_sub_mst";

  @override
  String? _getKeyCondition() => 'ref_fnc_cd = ? AND kopt_cd = ? AND koptsub_ordr = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(ref_fnc_cd);
    rn.add(kopt_cd);
    rn.add(koptsub_ordr);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CKeyoptSubMstColumns rn = CKeyoptSubMstColumns();
      rn.ref_fnc_cd = maps[i]['ref_fnc_cd'];
      rn.kopt_cd = maps[i]['kopt_cd'];
      rn.koptsub_ordr = maps[i]['koptsub_ordr'];
      rn.koptsub_data = maps[i]['koptsub_data'];
      rn.fnc_cd = maps[i]['fnc_cd'];
      rn.img_cd = maps[i]['img_cd'];
      rn.koptsub_comment = maps[i]['koptsub_comment'];
      rn.koptsub_btn_color = maps[i]['koptsub_btn_color'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CKeyoptSubMstColumns rn = CKeyoptSubMstColumns();
    rn.ref_fnc_cd = maps[0]['ref_fnc_cd'];
    rn.kopt_cd = maps[0]['kopt_cd'];
    rn.koptsub_ordr = maps[0]['koptsub_ordr'];
    rn.koptsub_data = maps[0]['koptsub_data'];
    rn.fnc_cd = maps[0]['fnc_cd'];
    rn.img_cd = maps[0]['img_cd'];
    rn.koptsub_comment = maps[0]['koptsub_comment'];
    rn.koptsub_btn_color = maps[0]['koptsub_btn_color'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CKeyoptSubMstField.ref_fnc_cd : this.ref_fnc_cd,
      CKeyoptSubMstField.kopt_cd : this.kopt_cd,
      CKeyoptSubMstField.koptsub_ordr : this.koptsub_ordr,
      CKeyoptSubMstField.koptsub_data : this.koptsub_data,
      CKeyoptSubMstField.fnc_cd : this.fnc_cd,
      CKeyoptSubMstField.img_cd : this.img_cd,
      CKeyoptSubMstField.koptsub_comment : this.koptsub_comment,
      CKeyoptSubMstField.koptsub_btn_color : this.koptsub_btn_color,
    };
  }
}

/// 03_22 キーオプションサブマスタ c_keyopt_sub_mstのフィールド名設定用クラス
class CKeyoptSubMstField {
  static const ref_fnc_cd = "ref_fnc_cd";
  static const kopt_cd = "kopt_cd";
  static const koptsub_ordr = "koptsub_ordr";
  static const koptsub_data = "koptsub_data";
  static const fnc_cd = "fnc_cd";
  static const img_cd = "img_cd";
  static const koptsub_comment = "koptsub_comment";
  static const koptsub_btn_color = "koptsub_btn_color";
}
//endregion
//region 03_23	区分マスタ	c_divide_mst
/// 03_23 区分マスタ  c_divide_mstクラス
class CDivideMstColumns extends TableColumns{
  int? comp_cd;
  int? kind_cd;
  int? div_cd;
  String? name;
  String? short_name;
  int? exp_cd1;
  int? exp_cd2;
  String? exp_data;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int exp_amt = 0;

  @override
  String _getTableName() => "c_divide_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND kind_cd = ? AND div_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(kind_cd);
    rn.add(div_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CDivideMstColumns rn = CDivideMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.kind_cd = maps[i]['kind_cd'];
      rn.div_cd = maps[i]['div_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.exp_cd1 = maps[i]['exp_cd1'];
      rn.exp_cd2 = maps[i]['exp_cd2'];
      rn.exp_data = maps[i]['exp_data'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.exp_amt = maps[i]['exp_amt'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CDivideMstColumns rn = CDivideMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.kind_cd = maps[0]['kind_cd'];
    rn.div_cd = maps[0]['div_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.exp_cd1 = maps[0]['exp_cd1'];
    rn.exp_cd2 = maps[0]['exp_cd2'];
    rn.exp_data = maps[0]['exp_data'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.exp_amt = maps[0]['exp_amt'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CDivideMstField.comp_cd : this.comp_cd,
      CDivideMstField.kind_cd : this.kind_cd,
      CDivideMstField.div_cd : this.div_cd,
      CDivideMstField.name : this.name,
      CDivideMstField.short_name : this.short_name,
      CDivideMstField.exp_cd1 : this.exp_cd1,
      CDivideMstField.exp_cd2 : this.exp_cd2,
      CDivideMstField.exp_data : this.exp_data,
      CDivideMstField.ins_datetime : this.ins_datetime,
      CDivideMstField.upd_datetime : this.upd_datetime,
      CDivideMstField.status : this.status,
      CDivideMstField.send_flg : this.send_flg,
      CDivideMstField.upd_user : this.upd_user,
      CDivideMstField.upd_system : this.upd_system,
      CDivideMstField.exp_amt : this.exp_amt,
    };
  }
}

/// 03_23 区分マスタ  c_divide_mstのフィールド名設定用クラス
class CDivideMstField {
  static const comp_cd = "comp_cd";
  static const kind_cd = "kind_cd";
  static const div_cd = "div_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const exp_cd1 = "exp_cd1";
  static const exp_cd2 = "exp_cd2";
  static const exp_data = "exp_data";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const exp_amt = "exp_amt";
}
//endregion
//region 03_24	仮登録ログ	c_tmp_log
/// 03_24 仮登録ログ  c_tmp_logクラス
class CTmpLogColumns extends TableColumns{
  String? serial_no;
  int seq_no = 0;
  int? comp_cd;
  int? stre_cd;
  int mac_no = 0;
  int cshr_cd = 0;
  String? plu_cd;
  int lrgcls_cd = 0;
  int mdlcls_cd = 0;
  int smlcls_cd = 0;
  int dflttnycls_cd = 0;
  int u_prc = 0;
  String? item_name;
  int tran_flg = 0;
  int sub_tran_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_tmp_log";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTmpLogColumns rn = CTmpLogColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.cshr_cd = maps[i]['cshr_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.dflttnycls_cd = maps[i]['dflttnycls_cd'];
      rn.u_prc = maps[i]['u_prc'];
      rn.item_name = maps[i]['item_name'];
      rn.tran_flg = maps[i]['tran_flg'];
      rn.sub_tran_flg = maps[i]['sub_tran_flg'];
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
    CTmpLogColumns rn = CTmpLogColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.cshr_cd = maps[0]['cshr_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.dflttnycls_cd = maps[0]['dflttnycls_cd'];
    rn.u_prc = maps[0]['u_prc'];
    rn.item_name = maps[0]['item_name'];
    rn.tran_flg = maps[0]['tran_flg'];
    rn.sub_tran_flg = maps[0]['sub_tran_flg'];
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
      CTmpLogField.serial_no : this.serial_no,
      CTmpLogField.seq_no : this.seq_no,
      CTmpLogField.comp_cd : this.comp_cd,
      CTmpLogField.stre_cd : this.stre_cd,
      CTmpLogField.mac_no : this.mac_no,
      CTmpLogField.cshr_cd : this.cshr_cd,
      CTmpLogField.plu_cd : this.plu_cd,
      CTmpLogField.lrgcls_cd : this.lrgcls_cd,
      CTmpLogField.mdlcls_cd : this.mdlcls_cd,
      CTmpLogField.smlcls_cd : this.smlcls_cd,
      CTmpLogField.dflttnycls_cd : this.dflttnycls_cd,
      CTmpLogField.u_prc : this.u_prc,
      CTmpLogField.item_name : this.item_name,
      CTmpLogField.tran_flg : this.tran_flg,
      CTmpLogField.sub_tran_flg : this.sub_tran_flg,
      CTmpLogField.ins_datetime : this.ins_datetime,
      CTmpLogField.upd_datetime : this.upd_datetime,
      CTmpLogField.status : this.status,
      CTmpLogField.send_flg : this.send_flg,
      CTmpLogField.upd_user : this.upd_user,
      CTmpLogField.upd_system : this.upd_system,
    };
  }
}

/// 03_24 仮登録ログ  c_tmp_logのフィールド名設定用クラス
class CTmpLogField {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const cshr_cd = "cshr_cd";
  static const plu_cd = "plu_cd";
  static const lrgcls_cd = "lrgcls_cd";
  static const mdlcls_cd = "mdlcls_cd";
  static const smlcls_cd = "smlcls_cd";
  static const dflttnycls_cd = "dflttnycls_cd";
  static const u_prc = "u_prc";
  static const item_name = "item_name";
  static const tran_flg = "tran_flg";
  static const sub_tran_flg = "sub_tran_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_25	売価変更マスタ	c_prcchg_mst
/// 03_25 売価変更マスタ  c_prcchg_mstクラス
class CPrcchgMstColumns extends TableColumns{
  String? serial_no;
  int seq_no = 0;
  int? comp_cd;
  int? stre_cd;
  String? plu_cd;
  int pos_prc = 0;
  int cust_prc = 0;
  int mac_no = 0;
  int staff_cd = 0;
  int maker_cd = 0;
  int tran_flg = 0;
  int sub_tran_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_prcchg_mst";

  @override
  String? _getKeyCondition() => 'serial_no = ? AND seq_no = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(serial_no);
    rn.add(seq_no);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CPrcchgMstColumns rn = CPrcchgMstColumns();
      rn.serial_no = maps[i]['serial_no'];
      rn.seq_no = maps[i]['seq_no'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.pos_prc = maps[i]['pos_prc'];
      rn.cust_prc = maps[i]['cust_prc'];
      rn.mac_no = maps[i]['mac_no'];
      rn.staff_cd = maps[i]['staff_cd'];
      rn.maker_cd = maps[i]['maker_cd'];
      rn.tran_flg = maps[i]['tran_flg'];
      rn.sub_tran_flg = maps[i]['sub_tran_flg'];
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
    CPrcchgMstColumns rn = CPrcchgMstColumns();
    rn.serial_no = maps[0]['serial_no'];
    rn.seq_no = maps[0]['seq_no'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.pos_prc = maps[0]['pos_prc'];
    rn.cust_prc = maps[0]['cust_prc'];
    rn.mac_no = maps[0]['mac_no'];
    rn.staff_cd = maps[0]['staff_cd'];
    rn.maker_cd = maps[0]['maker_cd'];
    rn.tran_flg = maps[0]['tran_flg'];
    rn.sub_tran_flg = maps[0]['sub_tran_flg'];
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
      CPrcchgMstField.serial_no : this.serial_no,
      CPrcchgMstField.seq_no : this.seq_no,
      CPrcchgMstField.comp_cd : this.comp_cd,
      CPrcchgMstField.stre_cd : this.stre_cd,
      CPrcchgMstField.plu_cd : this.plu_cd,
      CPrcchgMstField.pos_prc : this.pos_prc,
      CPrcchgMstField.cust_prc : this.cust_prc,
      CPrcchgMstField.mac_no : this.mac_no,
      CPrcchgMstField.staff_cd : this.staff_cd,
      CPrcchgMstField.maker_cd : this.maker_cd,
      CPrcchgMstField.tran_flg : this.tran_flg,
      CPrcchgMstField.sub_tran_flg : this.sub_tran_flg,
      CPrcchgMstField.ins_datetime : this.ins_datetime,
      CPrcchgMstField.upd_datetime : this.upd_datetime,
      CPrcchgMstField.status : this.status,
      CPrcchgMstField.send_flg : this.send_flg,
      CPrcchgMstField.upd_user : this.upd_user,
      CPrcchgMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_25 売価変更マスタ  c_prcchg_mstのフィールド名設定用クラス
class CPrcchgMstField {
  static const serial_no = "serial_no";
  static const seq_no = "seq_no";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plu_cd = "plu_cd";
  static const pos_prc = "pos_prc";
  static const cust_prc = "cust_prc";
  static const mac_no = "mac_no";
  static const staff_cd = "staff_cd";
  static const maker_cd = "maker_cd";
  static const tran_flg = "tran_flg";
  static const sub_tran_flg = "sub_tran_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_26	予約レポートマスタ	c_batrepo_mst
/// 03_26 予約レポートマスタ  c_batrepo_mstクラス
class CBatrepoMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? batch_grp_cd;
  int? batch_no;
  int? report_ordr;
  int batch_flg = 0;
  String? batch_name;
  int batch_report_no = 0;
  int condi_typ1 = 0;
  int condi_typ2 = 0;
  int condi_typ3 = 0;
  int condi_typ4 = 0;
  int condi_typ5 = 0;
  int condi_typ6 = 0;
  int condi_typ7 = 0;
  int condi_typ8 = 0;
  int condi_typ9 = 0;
  int out_dvc_flg = 0;
  int batch_flg2 = 0;
  int condi_start1 = 0;
  int condi_end1 = 0;
  int condi_start2 = 0;
  int condi_end2 = 0;
  int condi_start3 = 0;
  int condi_end3 = 0;
  int condi_start4 = 0;
  int condi_end4 = 0;
  int condi_start5 = 0;
  int condi_end5 = 0;
  int condi_start6 = 0;
  int condi_end6 = 0;
  int condi_start7 = 0;
  int condi_end7 = 0;
  int condi_start8 = 0;
  int condi_end8 = 0;
  int condi_start9 = 0;
  int condi_end9 = 0;
  int sel_mac_type = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_batrepo_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND batch_grp_cd = ? AND batch_no = ? AND report_ordr = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(batch_grp_cd);
    rn.add(batch_no);
    rn.add(report_ordr);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CBatrepoMstColumns rn = CBatrepoMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.batch_grp_cd = maps[i]['batch_grp_cd'];
      rn.batch_no = maps[i]['batch_no'];
      rn.report_ordr = maps[i]['report_ordr'];
      rn.batch_flg = maps[i]['batch_flg'];
      rn.batch_name = maps[i]['batch_name'];
      rn.batch_report_no = maps[i]['batch_report_no'];
      rn.condi_typ1 = maps[i]['condi_typ1'];
      rn.condi_typ2 = maps[i]['condi_typ2'];
      rn.condi_typ3 = maps[i]['condi_typ3'];
      rn.condi_typ4 = maps[i]['condi_typ4'];
      rn.condi_typ5 = maps[i]['condi_typ5'];
      rn.condi_typ6 = maps[i]['condi_typ6'];
      rn.condi_typ7 = maps[i]['condi_typ7'];
      rn.condi_typ8 = maps[i]['condi_typ8'];
      rn.condi_typ9 = maps[i]['condi_typ9'];
      rn.out_dvc_flg = maps[i]['out_dvc_flg'];
      rn.batch_flg2 = maps[i]['batch_flg2'];
      rn.condi_start1 = maps[i]['condi_start1'];
      rn.condi_end1 = maps[i]['condi_end1'];
      rn.condi_start2 = maps[i]['condi_start2'];
      rn.condi_end2 = maps[i]['condi_end2'];
      rn.condi_start3 = maps[i]['condi_start3'];
      rn.condi_end3 = maps[i]['condi_end3'];
      rn.condi_start4 = maps[i]['condi_start4'];
      rn.condi_end4 = maps[i]['condi_end4'];
      rn.condi_start5 = maps[i]['condi_start5'];
      rn.condi_end5 = maps[i]['condi_end5'];
      rn.condi_start6 = maps[i]['condi_start6'];
      rn.condi_end6 = maps[i]['condi_end6'];
      rn.condi_start7 = maps[i]['condi_start7'];
      rn.condi_end7 = maps[i]['condi_end7'];
      rn.condi_start8 = maps[i]['condi_start8'];
      rn.condi_end8 = maps[i]['condi_end8'];
      rn.condi_start9 = maps[i]['condi_start9'];
      rn.condi_end9 = maps[i]['condi_end9'];
      rn.sel_mac_type = maps[i]['sel_mac_type'];
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
    CBatrepoMstColumns rn = CBatrepoMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.batch_grp_cd = maps[0]['batch_grp_cd'];
    rn.batch_no = maps[0]['batch_no'];
    rn.report_ordr = maps[0]['report_ordr'];
    rn.batch_flg = maps[0]['batch_flg'];
    rn.batch_name = maps[0]['batch_name'];
    rn.batch_report_no = maps[0]['batch_report_no'];
    rn.condi_typ1 = maps[0]['condi_typ1'];
    rn.condi_typ2 = maps[0]['condi_typ2'];
    rn.condi_typ3 = maps[0]['condi_typ3'];
    rn.condi_typ4 = maps[0]['condi_typ4'];
    rn.condi_typ5 = maps[0]['condi_typ5'];
    rn.condi_typ6 = maps[0]['condi_typ6'];
    rn.condi_typ7 = maps[0]['condi_typ7'];
    rn.condi_typ8 = maps[0]['condi_typ8'];
    rn.condi_typ9 = maps[0]['condi_typ9'];
    rn.out_dvc_flg = maps[0]['out_dvc_flg'];
    rn.batch_flg2 = maps[0]['batch_flg2'];
    rn.condi_start1 = maps[0]['condi_start1'];
    rn.condi_end1 = maps[0]['condi_end1'];
    rn.condi_start2 = maps[0]['condi_start2'];
    rn.condi_end2 = maps[0]['condi_end2'];
    rn.condi_start3 = maps[0]['condi_start3'];
    rn.condi_end3 = maps[0]['condi_end3'];
    rn.condi_start4 = maps[0]['condi_start4'];
    rn.condi_end4 = maps[0]['condi_end4'];
    rn.condi_start5 = maps[0]['condi_start5'];
    rn.condi_end5 = maps[0]['condi_end5'];
    rn.condi_start6 = maps[0]['condi_start6'];
    rn.condi_end6 = maps[0]['condi_end6'];
    rn.condi_start7 = maps[0]['condi_start7'];
    rn.condi_end7 = maps[0]['condi_end7'];
    rn.condi_start8 = maps[0]['condi_start8'];
    rn.condi_end8 = maps[0]['condi_end8'];
    rn.condi_start9 = maps[0]['condi_start9'];
    rn.condi_end9 = maps[0]['condi_end9'];
    rn.sel_mac_type = maps[0]['sel_mac_type'];
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
      CBatrepoMstField.comp_cd : this.comp_cd,
      CBatrepoMstField.stre_cd : this.stre_cd,
      CBatrepoMstField.batch_grp_cd : this.batch_grp_cd,
      CBatrepoMstField.batch_no : this.batch_no,
      CBatrepoMstField.report_ordr : this.report_ordr,
      CBatrepoMstField.batch_flg : this.batch_flg,
      CBatrepoMstField.batch_name : this.batch_name,
      CBatrepoMstField.batch_report_no : this.batch_report_no,
      CBatrepoMstField.condi_typ1 : this.condi_typ1,
      CBatrepoMstField.condi_typ2 : this.condi_typ2,
      CBatrepoMstField.condi_typ3 : this.condi_typ3,
      CBatrepoMstField.condi_typ4 : this.condi_typ4,
      CBatrepoMstField.condi_typ5 : this.condi_typ5,
      CBatrepoMstField.condi_typ6 : this.condi_typ6,
      CBatrepoMstField.condi_typ7 : this.condi_typ7,
      CBatrepoMstField.condi_typ8 : this.condi_typ8,
      CBatrepoMstField.condi_typ9 : this.condi_typ9,
      CBatrepoMstField.out_dvc_flg : this.out_dvc_flg,
      CBatrepoMstField.batch_flg2 : this.batch_flg2,
      CBatrepoMstField.condi_start1 : this.condi_start1,
      CBatrepoMstField.condi_end1 : this.condi_end1,
      CBatrepoMstField.condi_start2 : this.condi_start2,
      CBatrepoMstField.condi_end2 : this.condi_end2,
      CBatrepoMstField.condi_start3 : this.condi_start3,
      CBatrepoMstField.condi_end3 : this.condi_end3,
      CBatrepoMstField.condi_start4 : this.condi_start4,
      CBatrepoMstField.condi_end4 : this.condi_end4,
      CBatrepoMstField.condi_start5 : this.condi_start5,
      CBatrepoMstField.condi_end5 : this.condi_end5,
      CBatrepoMstField.condi_start6 : this.condi_start6,
      CBatrepoMstField.condi_end6 : this.condi_end6,
      CBatrepoMstField.condi_start7 : this.condi_start7,
      CBatrepoMstField.condi_end7 : this.condi_end7,
      CBatrepoMstField.condi_start8 : this.condi_start8,
      CBatrepoMstField.condi_end8 : this.condi_end8,
      CBatrepoMstField.condi_start9 : this.condi_start9,
      CBatrepoMstField.condi_end9 : this.condi_end9,
      CBatrepoMstField.sel_mac_type : this.sel_mac_type,
      CBatrepoMstField.ins_datetime : this.ins_datetime,
      CBatrepoMstField.upd_datetime : this.upd_datetime,
      CBatrepoMstField.status : this.status,
      CBatrepoMstField.send_flg : this.send_flg,
      CBatrepoMstField.upd_user : this.upd_user,
      CBatrepoMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_26 予約レポートマスタ  c_batrepo_mstのフィールド名設定用クラス
class CBatrepoMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const batch_grp_cd = "batch_grp_cd";
  static const batch_no = "batch_no";
  static const report_ordr = "report_ordr";
  static const batch_flg = "batch_flg";
  static const batch_name = "batch_name";
  static const batch_report_no = "batch_report_no";
  static const condi_typ1 = "condi_typ1";
  static const condi_typ2 = "condi_typ2";
  static const condi_typ3 = "condi_typ3";
  static const condi_typ4 = "condi_typ4";
  static const condi_typ5 = "condi_typ5";
  static const condi_typ6 = "condi_typ6";
  static const condi_typ7 = "condi_typ7";
  static const condi_typ8 = "condi_typ8";
  static const condi_typ9 = "condi_typ9";
  static const out_dvc_flg = "out_dvc_flg";
  static const batch_flg2 = "batch_flg2";
  static const condi_start1 = "condi_start1";
  static const condi_end1 = "condi_end1";
  static const condi_start2 = "condi_start2";
  static const condi_end2 = "condi_end2";
  static const condi_start3 = "condi_start3";
  static const condi_end3 = "condi_end3";
  static const condi_start4 = "condi_start4";
  static const condi_end4 = "condi_end4";
  static const condi_start5 = "condi_start5";
  static const condi_end5 = "condi_end5";
  static const condi_start6 = "condi_start6";
  static const condi_end6 = "condi_end6";
  static const condi_start7 = "condi_start7";
  static const condi_end7 = "condi_end7";
  static const condi_start8 = "condi_start8";
  static const condi_end8 = "condi_end8";
  static const condi_start9 = "condi_start9";
  static const condi_end9 = "condi_end9";
  static const sel_mac_type = "sel_mac_type";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_27	レポートカウンタ	c_report_cnt
/// 03_27 レポートカウンタ c_report_cntクラス
class CReportCntColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? report_cnt_cd;
  int settle_cnt = 0;
  String? bfr_datetime;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_report_cnt";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND report_cnt_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(report_cnt_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReportCntColumns rn = CReportCntColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.report_cnt_cd = maps[i]['report_cnt_cd'];
      rn.settle_cnt = maps[i]['settle_cnt'];
      rn.bfr_datetime = maps[i]['bfr_datetime'];
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
    CReportCntColumns rn = CReportCntColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.report_cnt_cd = maps[0]['report_cnt_cd'];
    rn.settle_cnt = maps[0]['settle_cnt'];
    rn.bfr_datetime = maps[0]['bfr_datetime'];
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
      CReportCntField.comp_cd : this.comp_cd,
      CReportCntField.stre_cd : this.stre_cd,
      CReportCntField.mac_no : this.mac_no,
      CReportCntField.report_cnt_cd : this.report_cnt_cd,
      CReportCntField.settle_cnt : this.settle_cnt,
      CReportCntField.bfr_datetime : this.bfr_datetime,
      CReportCntField.ins_datetime : this.ins_datetime,
      CReportCntField.upd_datetime : this.upd_datetime,
      CReportCntField.status : this.status,
      CReportCntField.send_flg : this.send_flg,
      CReportCntField.upd_user : this.upd_user,
      CReportCntField.upd_system : this.upd_system,
    };
  }
}

/// 03_27 レポートカウンタ c_report_cntのフィールド名設定用クラス
class CReportCntField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const report_cnt_cd = "report_cnt_cd";
  static const settle_cnt = "settle_cnt";
  static const bfr_datetime = "bfr_datetime";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_28	レジメモマスタ	c_memo_mst
/// 03_28 レジメモマスタ  c_memo_mstクラス
class CMemoMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? img_cd;
  int color = 0;
  String? memo1;
  String? memo2;
  String? memo3;
  String? memo4;
  String? memo5;
  String? memo6;
  String? memo7;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  String? title;
  String? img_name;
  int stop_flg = 0;
  int read_flg = 0;
  int renew_flg = 0;

  @override
  String _getTableName() => "c_memo_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND img_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(img_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMemoMstColumns rn = CMemoMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.img_cd = maps[i]['img_cd'];
      rn.color = maps[i]['color'];
      rn.memo1 = maps[i]['memo1'];
      rn.memo2 = maps[i]['memo2'];
      rn.memo3 = maps[i]['memo3'];
      rn.memo4 = maps[i]['memo4'];
      rn.memo5 = maps[i]['memo5'];
      rn.memo6 = maps[i]['memo6'];
      rn.memo7 = maps[i]['memo7'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.title = maps[i]['title'];
      rn.img_name = maps[i]['img_name'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.read_flg = maps[i]['read_flg'];
      rn.renew_flg = maps[i]['renew_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CMemoMstColumns rn = CMemoMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.img_cd = maps[0]['img_cd'];
    rn.color = maps[0]['color'];
    rn.memo1 = maps[0]['memo1'];
    rn.memo2 = maps[0]['memo2'];
    rn.memo3 = maps[0]['memo3'];
    rn.memo4 = maps[0]['memo4'];
    rn.memo5 = maps[0]['memo5'];
    rn.memo6 = maps[0]['memo6'];
    rn.memo7 = maps[0]['memo7'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.title = maps[0]['title'];
    rn.img_name = maps[0]['img_name'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.read_flg = maps[0]['read_flg'];
    rn.renew_flg = maps[0]['renew_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CMemoMstField.comp_cd : this.comp_cd,
      CMemoMstField.stre_cd : this.stre_cd,
      CMemoMstField.img_cd : this.img_cd,
      CMemoMstField.color : this.color,
      CMemoMstField.memo1 : this.memo1,
      CMemoMstField.memo2 : this.memo2,
      CMemoMstField.memo3 : this.memo3,
      CMemoMstField.memo4 : this.memo4,
      CMemoMstField.memo5 : this.memo5,
      CMemoMstField.memo6 : this.memo6,
      CMemoMstField.memo7 : this.memo7,
      CMemoMstField.ins_datetime : this.ins_datetime,
      CMemoMstField.upd_datetime : this.upd_datetime,
      CMemoMstField.status : this.status,
      CMemoMstField.send_flg : this.send_flg,
      CMemoMstField.upd_user : this.upd_user,
      CMemoMstField.upd_system : this.upd_system,
      CMemoMstField.title : this.title,
      CMemoMstField.img_name : this.img_name,
      CMemoMstField.stop_flg : this.stop_flg,
      CMemoMstField.read_flg : this.read_flg,
      CMemoMstField.renew_flg : this.renew_flg,
    };
  }
}

/// 03_28 レジメモマスタ  c_memo_mstのフィールド名設定用クラス
class CMemoMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const img_cd = "img_cd";
  static const color = "color";
  static const memo1 = "memo1";
  static const memo2 = "memo2";
  static const memo3 = "memo3";
  static const memo4 = "memo4";
  static const memo5 = "memo5";
  static const memo6 = "memo6";
  static const memo7 = "memo7";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const title = "title";
  static const img_name = "img_name";
  static const stop_flg = "stop_flg";
  static const read_flg = "read_flg";
  static const renew_flg = "renew_flg";
}
//endregion
//region 03_29	レジメモ連絡先マスタ	c_memosnd_mst
/// 03_29 レジメモ連絡先マスタ c_memosnd_mstクラス
class CMemosndMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? img_cd;
  int? ecr_no;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_memosnd_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND img_cd = ? AND ecr_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(img_cd);
    rn.add(ecr_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMemosndMstColumns rn = CMemosndMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.img_cd = maps[i]['img_cd'];
      rn.ecr_no = maps[i]['ecr_no'];
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
    CMemosndMstColumns rn = CMemosndMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.img_cd = maps[0]['img_cd'];
    rn.ecr_no = maps[0]['ecr_no'];
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
      CMemosndMstField.comp_cd : this.comp_cd,
      CMemosndMstField.stre_cd : this.stre_cd,
      CMemosndMstField.img_cd : this.img_cd,
      CMemosndMstField.ecr_no : this.ecr_no,
      CMemosndMstField.ins_datetime : this.ins_datetime,
      CMemosndMstField.upd_datetime : this.upd_datetime,
      CMemosndMstField.status : this.status,
      CMemosndMstField.send_flg : this.send_flg,
      CMemosndMstField.upd_user : this.upd_user,
      CMemosndMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_29 レジメモ連絡先マスタ c_memosnd_mstのフィールド名設定用クラス
class CMemosndMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const img_cd = "img_cd";
  static const ecr_no = "ecr_no";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_30	承認キーグループマスタ	c_recog_grp_mst
/// 03_30 承認キーグループマスタ  c_recog_grp_mstクラス
class CRecogGrpMstColumns extends TableColumns{
  int? recog_grp_cd;
  int? recog_sub_grp_cd;
  int? page;
  int? posi;
  int recog_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_recog_grp_mst";

  @override
  String? _getKeyCondition() => 'recog_grp_cd = ? AND recog_sub_grp_cd = ? AND page = ? AND posi = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(recog_grp_cd);
    rn.add(recog_sub_grp_cd);
    rn.add(page);
    rn.add(posi);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CRecogGrpMstColumns rn = CRecogGrpMstColumns();
      rn.recog_grp_cd = maps[i]['recog_grp_cd'];
      rn.recog_sub_grp_cd = maps[i]['recog_sub_grp_cd'];
      rn.page = maps[i]['page'];
      rn.posi = maps[i]['posi'];
      rn.recog_flg = maps[i]['recog_flg'];
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
    CRecogGrpMstColumns rn = CRecogGrpMstColumns();
    rn.recog_grp_cd = maps[0]['recog_grp_cd'];
    rn.recog_sub_grp_cd = maps[0]['recog_sub_grp_cd'];
    rn.page = maps[0]['page'];
    rn.posi = maps[0]['posi'];
    rn.recog_flg = maps[0]['recog_flg'];
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
      CRecogGrpMstField.recog_grp_cd : this.recog_grp_cd,
      CRecogGrpMstField.recog_sub_grp_cd : this.recog_sub_grp_cd,
      CRecogGrpMstField.page : this.page,
      CRecogGrpMstField.posi : this.posi,
      CRecogGrpMstField.recog_flg : this.recog_flg,
      CRecogGrpMstField.ins_datetime : this.ins_datetime,
      CRecogGrpMstField.upd_datetime : this.upd_datetime,
      CRecogGrpMstField.status : this.status,
      CRecogGrpMstField.send_flg : this.send_flg,
      CRecogGrpMstField.upd_user : this.upd_user,
      CRecogGrpMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_30 承認キーグループマスタ  c_recog_grp_mstのフィールド名設定用クラス
class CRecogGrpMstField {
  static const recog_grp_cd = "recog_grp_cd";
  static const recog_sub_grp_cd = "recog_sub_grp_cd";
  static const page = "page";
  static const posi = "posi";
  static const recog_flg = "recog_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_31	承認キーマスタ	p_recog_mst
/// 03_31 承認キーマスタ  p_recog_mstクラス
class PRecogMstColumns extends TableColumns{
  int? page;
  int? posi;
  String? recog_name;
  int recog_set_flg = 0;

  @override
  String _getTableName() => "p_recog_mst";

  @override
  String? _getKeyCondition() => 'page = ? AND posi = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(page);
    rn.add(posi);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PRecogMstColumns rn = PRecogMstColumns();
      rn.page = maps[i]['page'];
      rn.posi = maps[i]['posi'];
      rn.recog_name = maps[i]['recog_name'];
      rn.recog_set_flg = maps[i]['recog_set_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PRecogMstColumns rn = PRecogMstColumns();
    rn.page = maps[0]['page'];
    rn.posi = maps[0]['posi'];
    rn.recog_name = maps[0]['recog_name'];
    rn.recog_set_flg = maps[0]['recog_set_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PRecogMstField.page : this.page,
      PRecogMstField.posi : this.posi,
      PRecogMstField.recog_name : this.recog_name,
      PRecogMstField.recog_set_flg : this.recog_set_flg,
    };
  }
}

/// 03_31 承認キーマスタ  p_recog_mstのフィールド名設定用クラス
class PRecogMstField {
  static const page = "page";
  static const posi = "posi";
  static const recog_name = "recog_name";
  static const recog_set_flg = "recog_set_flg";
}
//endregion
//region 03_32	承認キー情報マスタ	c_recoginfo_mst
/// 03_32 承認キー情報マスタ  c_recoginfo_mstクラス
class CRecoginfoMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int? page;
  String? password;
  String? fcode;
  String? qcjc_type;
  String? emergency_type;
  String? emergency_date;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_recoginfo_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND mac_no = ? AND page = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(mac_no);
    rn.add(page);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CRecoginfoMstColumns rn = CRecoginfoMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.page = maps[i]['page'];
      rn.password = maps[i]['password'];
      rn.fcode = maps[i]['fcode'];
      rn.qcjc_type = maps[i]['qcjc_type'];
      rn.emergency_type = maps[i]['emergency_type'];
      rn.emergency_date = maps[i]['emergency_date'];
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
    CRecoginfoMstColumns rn = CRecoginfoMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.page = maps[0]['page'];
    rn.password = maps[0]['password'];
    rn.fcode = maps[0]['fcode'];
    rn.qcjc_type = maps[0]['qcjc_type'];
    rn.emergency_type = maps[0]['emergency_type'];
    rn.emergency_date = maps[0]['emergency_date'];
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
      CRecoginfoMstField.comp_cd : this.comp_cd,
      CRecoginfoMstField.stre_cd : this.stre_cd,
      CRecoginfoMstField.mac_no : this.mac_no,
      CRecoginfoMstField.page : this.page,
      CRecoginfoMstField.password : this.password,
      CRecoginfoMstField.fcode : this.fcode,
      CRecoginfoMstField.qcjc_type : this.qcjc_type,
      CRecoginfoMstField.emergency_type : this.emergency_type,
      CRecoginfoMstField.emergency_date : this.emergency_date,
      CRecoginfoMstField.ins_datetime : this.ins_datetime,
      CRecoginfoMstField.upd_datetime : this.upd_datetime,
      CRecoginfoMstField.status : this.status,
      CRecoginfoMstField.send_flg : this.send_flg,
      CRecoginfoMstField.upd_user : this.upd_user,
      CRecoginfoMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_32 承認キー情報マスタ  c_recoginfo_mstのフィールド名設定用クラス
class CRecoginfoMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const page = "page";
  static const password = "password";
  static const fcode = "fcode";
  static const qcjc_type = "qcjc_type";
  static const emergency_type = "emergency_type";
  static const emergency_date = "emergency_date";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_33	帳票マスタ	c_report_mst
/// 03_33 帳票マスタ  c_report_mstクラス
class CReportMstColumns extends TableColumns{
  int? code;
  int? prn_ordr;
  int srch_ordr = 0;
  int? grp_cd;
  int sub_grp_cd = 0;
  int left_offset = 0;
  int typ = 0;
  int val_kind = 0;
  int val_calc = 0;
  int val_mark = 0;
  int fmt_typ = 0;
  int img_cd = 0;
  String? field1;
  String? field2;
  String? field3;
  String? condi1;
  String? condi2;
  String? condi3;
  int repo_sql_cd = 0;
  int recog_grp_cd = 0;
  int trm_chk_grp_cd = 0;
  String? judge;
  int printer_no = 0;

  @override
  String _getTableName() => "c_report_mst";

  @override
  String? _getKeyCondition() => 'code = ? AND prn_ordr = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(code);
    rn.add(prn_ordr);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReportMstColumns rn = CReportMstColumns();
      rn.code = maps[i]['code'];
      rn.prn_ordr = maps[i]['prn_ordr'];
      rn.srch_ordr = maps[i]['srch_ordr'];
      rn.grp_cd = maps[i]['grp_cd'];
      rn.sub_grp_cd = maps[i]['sub_grp_cd'];
      rn.left_offset = maps[i]['left_offset'];
      rn.typ = maps[i]['typ'];
      rn.val_kind = maps[i]['val_kind'];
      rn.val_calc = maps[i]['val_calc'];
      rn.val_mark = maps[i]['val_mark'];
      rn.fmt_typ = maps[i]['fmt_typ'];
      rn.img_cd = maps[i]['img_cd'];
      rn.field1 = maps[i]['field1'];
      rn.field2 = maps[i]['field2'];
      rn.field3 = maps[i]['field3'];
      rn.condi1 = maps[i]['condi1'];
      rn.condi2 = maps[i]['condi2'];
      rn.condi3 = maps[i]['condi3'];
      rn.repo_sql_cd = maps[i]['repo_sql_cd'];
      rn.recog_grp_cd = maps[i]['recog_grp_cd'];
      rn.trm_chk_grp_cd = maps[i]['trm_chk_grp_cd'];
      rn.judge = maps[i]['judge'];
      rn.printer_no = maps[i]['printer_no'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReportMstColumns rn = CReportMstColumns();
    rn.code = maps[0]['code'];
    rn.prn_ordr = maps[0]['prn_ordr'];
    rn.srch_ordr = maps[0]['srch_ordr'];
    rn.grp_cd = maps[0]['grp_cd'];
    rn.sub_grp_cd = maps[0]['sub_grp_cd'];
    rn.left_offset = maps[0]['left_offset'];
    rn.typ = maps[0]['typ'];
    rn.val_kind = maps[0]['val_kind'];
    rn.val_calc = maps[0]['val_calc'];
    rn.val_mark = maps[0]['val_mark'];
    rn.fmt_typ = maps[0]['fmt_typ'];
    rn.img_cd = maps[0]['img_cd'];
    rn.field1 = maps[0]['field1'];
    rn.field2 = maps[0]['field2'];
    rn.field3 = maps[0]['field3'];
    rn.condi1 = maps[0]['condi1'];
    rn.condi2 = maps[0]['condi2'];
    rn.condi3 = maps[0]['condi3'];
    rn.repo_sql_cd = maps[0]['repo_sql_cd'];
    rn.recog_grp_cd = maps[0]['recog_grp_cd'];
    rn.trm_chk_grp_cd = maps[0]['trm_chk_grp_cd'];
    rn.judge = maps[0]['judge'];
    rn.printer_no = maps[0]['printer_no'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReportMstField.code : this.code,
      CReportMstField.prn_ordr : this.prn_ordr,
      CReportMstField.srch_ordr : this.srch_ordr,
      CReportMstField.grp_cd : this.grp_cd,
      CReportMstField.sub_grp_cd : this.sub_grp_cd,
      CReportMstField.left_offset : this.left_offset,
      CReportMstField.typ : this.typ,
      CReportMstField.val_kind : this.val_kind,
      CReportMstField.val_calc : this.val_calc,
      CReportMstField.val_mark : this.val_mark,
      CReportMstField.fmt_typ : this.fmt_typ,
      CReportMstField.img_cd : this.img_cd,
      CReportMstField.field1 : this.field1,
      CReportMstField.field2 : this.field2,
      CReportMstField.field3 : this.field3,
      CReportMstField.condi1 : this.condi1,
      CReportMstField.condi2 : this.condi2,
      CReportMstField.condi3 : this.condi3,
      CReportMstField.repo_sql_cd : this.repo_sql_cd,
      CReportMstField.recog_grp_cd : this.recog_grp_cd,
      CReportMstField.trm_chk_grp_cd : this.trm_chk_grp_cd,
      CReportMstField.judge : this.judge,
      CReportMstField.printer_no : this.printer_no,
    };
  }
}

/// 03_33 帳票マスタ  c_report_mstのフィールド名設定用クラス
class CReportMstField {
  static const code = "code";
  static const prn_ordr = "prn_ordr";
  static const srch_ordr = "srch_ordr";
  static const grp_cd = "grp_cd";
  static const sub_grp_cd = "sub_grp_cd";
  static const left_offset = "left_offset";
  static const typ = "typ";
  static const val_kind = "val_kind";
  static const val_calc = "val_calc";
  static const val_mark = "val_mark";
  static const fmt_typ = "fmt_typ";
  static const img_cd = "img_cd";
  static const field1 = "field1";
  static const field2 = "field2";
  static const field3 = "field3";
  static const condi1 = "condi1";
  static const condi2 = "condi2";
  static const condi3 = "condi3";
  static const repo_sql_cd = "repo_sql_cd";
  static const recog_grp_cd = "recog_grp_cd";
  static const trm_chk_grp_cd = "trm_chk_grp_cd";
  static const judge = "judge";
  static const printer_no = "printer_no";
}
//endregion
//region 03_34	メニューオブジェクト割当マスタ	c_menu_obj_mst
/// 03_34 メニューオブジェクト割当マスタ  c_menu_obj_mstクラス
class CMenuObjMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  String? proc;
  String? win_name;
  int? page;
  int? btn_pos_x;
  int? btn_pos_y;
  int btn_width = 0;
  int btn_height = 0;
  int object_div = 0;
  int appl_grp_cd = 0;
  int btn_color = 0;
  String? img_name;
  int pass_chk_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_menu_obj_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND proc = ? AND win_name = ? AND page = ? AND btn_pos_x = ? AND btn_pos_y = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(proc);
    rn.add(win_name);
    rn.add(page);
    rn.add(btn_pos_x);
    rn.add(btn_pos_y);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMenuObjMstColumns rn = CMenuObjMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.proc = maps[i]['proc'];
      rn.win_name = maps[i]['win_name'];
      rn.page = maps[i]['page'];
      rn.btn_pos_x = maps[i]['btn_pos_x'];
      rn.btn_pos_y = maps[i]['btn_pos_y'];
      rn.btn_width = maps[i]['btn_width'];
      rn.btn_height = maps[i]['btn_height'];
      rn.object_div = maps[i]['object_div'];
      rn.appl_grp_cd = maps[i]['appl_grp_cd'];
      rn.btn_color = maps[i]['btn_color'];
      rn.img_name = maps[i]['img_name'];
      rn.pass_chk_flg = maps[i]['pass_chk_flg'];
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
    CMenuObjMstColumns rn = CMenuObjMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.proc = maps[0]['proc'];
    rn.win_name = maps[0]['win_name'];
    rn.page = maps[0]['page'];
    rn.btn_pos_x = maps[0]['btn_pos_x'];
    rn.btn_pos_y = maps[0]['btn_pos_y'];
    rn.btn_width = maps[0]['btn_width'];
    rn.btn_height = maps[0]['btn_height'];
    rn.object_div = maps[0]['object_div'];
    rn.appl_grp_cd = maps[0]['appl_grp_cd'];
    rn.btn_color = maps[0]['btn_color'];
    rn.img_name = maps[0]['img_name'];
    rn.pass_chk_flg = maps[0]['pass_chk_flg'];
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
      CMenuObjMstField.comp_cd : this.comp_cd,
      CMenuObjMstField.stre_cd : this.stre_cd,
      CMenuObjMstField.proc : this.proc,
      CMenuObjMstField.win_name : this.win_name,
      CMenuObjMstField.page : this.page,
      CMenuObjMstField.btn_pos_x : this.btn_pos_x,
      CMenuObjMstField.btn_pos_y : this.btn_pos_y,
      CMenuObjMstField.btn_width : this.btn_width,
      CMenuObjMstField.btn_height : this.btn_height,
      CMenuObjMstField.object_div : this.object_div,
      CMenuObjMstField.appl_grp_cd : this.appl_grp_cd,
      CMenuObjMstField.btn_color : this.btn_color,
      CMenuObjMstField.img_name : this.img_name,
      CMenuObjMstField.pass_chk_flg : this.pass_chk_flg,
      CMenuObjMstField.ins_datetime : this.ins_datetime,
      CMenuObjMstField.upd_datetime : this.upd_datetime,
      CMenuObjMstField.status : this.status,
      CMenuObjMstField.send_flg : this.send_flg,
      CMenuObjMstField.upd_user : this.upd_user,
      CMenuObjMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_34 メニューオブジェクト割当マスタ  c_menu_obj_mstのフィールド名設定用クラス
class CMenuObjMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const proc = "proc";
  static const win_name = "win_name";
  static const page = "page";
  static const btn_pos_x = "btn_pos_x";
  static const btn_pos_y = "btn_pos_y";
  static const btn_width = "btn_width";
  static const btn_height = "btn_height";
  static const object_div = "object_div";
  static const appl_grp_cd = "appl_grp_cd";
  static const btn_color = "btn_color";
  static const img_name = "img_name";
  static const pass_chk_flg = "pass_chk_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_35	トリガーキー割当マスタ	p_trigger_key_mst
/// 03_35 トリガーキー割当マスタ  p_trigger_key_mstクラス
class PTriggerKeyMstColumns extends TableColumns{
  String? proc;
  String? win_name;
  String? trigger_key;
  int call_type = 0;
  int target_code = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "p_trigger_key_mst";

  @override
  String? _getKeyCondition() => 'proc = ? AND win_name = ? AND trigger_key = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(proc);
    rn.add(win_name);
    rn.add(trigger_key);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PTriggerKeyMstColumns rn = PTriggerKeyMstColumns();
      rn.proc = maps[i]['proc'];
      rn.win_name = maps[i]['win_name'];
      rn.trigger_key = maps[i]['trigger_key'];
      rn.call_type = maps[i]['call_type'];
      rn.target_code = maps[i]['target_code'];
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
    PTriggerKeyMstColumns rn = PTriggerKeyMstColumns();
    rn.proc = maps[0]['proc'];
    rn.win_name = maps[0]['win_name'];
    rn.trigger_key = maps[0]['trigger_key'];
    rn.call_type = maps[0]['call_type'];
    rn.target_code = maps[0]['target_code'];
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
      PTriggerKeyMstField.proc : this.proc,
      PTriggerKeyMstField.win_name : this.win_name,
      PTriggerKeyMstField.trigger_key : this.trigger_key,
      PTriggerKeyMstField.call_type : this.call_type,
      PTriggerKeyMstField.target_code : this.target_code,
      PTriggerKeyMstField.ins_datetime : this.ins_datetime,
      PTriggerKeyMstField.upd_datetime : this.upd_datetime,
      PTriggerKeyMstField.status : this.status,
      PTriggerKeyMstField.send_flg : this.send_flg,
      PTriggerKeyMstField.upd_user : this.upd_user,
      PTriggerKeyMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_35 トリガーキー割当マスタ  p_trigger_key_mstのフィールド名設定用クラス
class PTriggerKeyMstField {
  static const proc = "proc";
  static const win_name = "win_name";
  static const trigger_key = "trigger_key";
  static const call_type = "call_type";
  static const target_code = "target_code";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_36	ファイル初期・リクエストマスタ	c_finit_mst
/// 03_36 ファイル初期・リクエストマスタ  c_finit_mstクラス
class CFinitMstColumns extends TableColumns{
  int? finit_grp_cd;
  int? finit_cd;
  String? set_tbl_name;
  int? set_tbl_typ;
  int finit_dsp_chk_div = 0;
  int freq_dsp_chk_div = 0;
  int freq_ope_mode = 0;
  int offline_chk_flg = 1;
  String? seq_name;
  int freq_csrv_cnct_skip = 1;
  int freq_csrc_cust_real_skip = 1;
  String? freq_csrv_cnct_key;
  int freq_csrv_del_oth_stre = 0;
  int svr_div = 0;
  String? default_file_name;
  int rmst_freq_dsp_chk_div = 0;

  @override
  String _getTableName() => "c_finit_mst";

  @override
  String? _getKeyCondition() => 'finit_grp_cd = ? AND finit_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(finit_grp_cd);
    rn.add(finit_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CFinitMstColumns rn = CFinitMstColumns();
      rn.finit_grp_cd = maps[i]['finit_grp_cd'];
      rn.finit_cd = maps[i]['finit_cd'];
      rn.set_tbl_name = maps[i]['set_tbl_name'];
      rn.set_tbl_typ = maps[i]['set_tbl_typ'];
      rn.finit_dsp_chk_div = maps[i]['finit_dsp_chk_div'];
      rn.freq_dsp_chk_div = maps[i]['freq_dsp_chk_div'];
      rn.freq_ope_mode = maps[i]['freq_ope_mode'];
      rn.offline_chk_flg = maps[i]['offline_chk_flg'];
      rn.seq_name = maps[i]['seq_name'];
      rn.freq_csrv_cnct_skip = maps[i]['freq_csrv_cnct_skip'];
      rn.freq_csrc_cust_real_skip = maps[i]['freq_csrc_cust_real_skip'];
      rn.freq_csrv_cnct_key = maps[i]['freq_csrv_cnct_key'];
      rn.freq_csrv_del_oth_stre = maps[i]['freq_csrv_del_oth_stre'];
      rn.svr_div = maps[i]['svr_div'];
      rn.default_file_name = maps[i]['default_file_name'];
      rn.rmst_freq_dsp_chk_div = maps[i]['rmst_freq_dsp_chk_div'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CFinitMstColumns rn = CFinitMstColumns();
    rn.finit_grp_cd = maps[0]['finit_grp_cd'];
    rn.finit_cd = maps[0]['finit_cd'];
    rn.set_tbl_name = maps[0]['set_tbl_name'];
    rn.set_tbl_typ = maps[0]['set_tbl_typ'];
    rn.finit_dsp_chk_div = maps[0]['finit_dsp_chk_div'];
    rn.freq_dsp_chk_div = maps[0]['freq_dsp_chk_div'];
    rn.freq_ope_mode = maps[0]['freq_ope_mode'];
    rn.offline_chk_flg = maps[0]['offline_chk_flg'];
    rn.seq_name = maps[0]['seq_name'];
    rn.freq_csrv_cnct_skip = maps[0]['freq_csrv_cnct_skip'];
    rn.freq_csrc_cust_real_skip = maps[0]['freq_csrc_cust_real_skip'];
    rn.freq_csrv_cnct_key = maps[0]['freq_csrv_cnct_key'];
    rn.freq_csrv_del_oth_stre = maps[0]['freq_csrv_del_oth_stre'];
    rn.svr_div = maps[0]['svr_div'];
    rn.default_file_name = maps[0]['default_file_name'];
    rn.rmst_freq_dsp_chk_div = maps[0]['rmst_freq_dsp_chk_div'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CFinitMstField.finit_grp_cd : this.finit_grp_cd,
      CFinitMstField.finit_cd : this.finit_cd,
      CFinitMstField.set_tbl_name : this.set_tbl_name,
      CFinitMstField.set_tbl_typ : this.set_tbl_typ,
      CFinitMstField.finit_dsp_chk_div : this.finit_dsp_chk_div,
      CFinitMstField.freq_dsp_chk_div : this.freq_dsp_chk_div,
      CFinitMstField.freq_ope_mode : this.freq_ope_mode,
      CFinitMstField.offline_chk_flg : this.offline_chk_flg,
      CFinitMstField.seq_name : this.seq_name,
      CFinitMstField.freq_csrv_cnct_skip : this.freq_csrv_cnct_skip,
      CFinitMstField.freq_csrc_cust_real_skip : this.freq_csrc_cust_real_skip,
      CFinitMstField.freq_csrv_cnct_key : this.freq_csrv_cnct_key,
      CFinitMstField.freq_csrv_del_oth_stre : this.freq_csrv_del_oth_stre,
      CFinitMstField.svr_div : this.svr_div,
      CFinitMstField.default_file_name : this.default_file_name,
      CFinitMstField.rmst_freq_dsp_chk_div : this.rmst_freq_dsp_chk_div,
    };
  }
}

/// 03_36 ファイル初期・リクエストマスタ  c_finit_mstのフィールド名設定用クラス
class CFinitMstField {
  static const finit_grp_cd = "finit_grp_cd";
  static const finit_cd = "finit_cd";
  static const set_tbl_name = "set_tbl_name";
  static const set_tbl_typ = "set_tbl_typ";
  static const finit_dsp_chk_div = "finit_dsp_chk_div";
  static const freq_dsp_chk_div = "freq_dsp_chk_div";
  static const freq_ope_mode = "freq_ope_mode";
  static const offline_chk_flg = "offline_chk_flg";
  static const seq_name = "seq_name";
  static const freq_csrv_cnct_skip = "freq_csrv_cnct_skip";
  static const freq_csrc_cust_real_skip = "freq_csrc_cust_real_skip";
  static const freq_csrv_cnct_key = "freq_csrv_cnct_key";
  static const freq_csrv_del_oth_stre = "freq_csrv_del_oth_stre";
  static const svr_div = "svr_div";
  static const default_file_name = "default_file_name";
  static const rmst_freq_dsp_chk_div = "rmst_freq_dsp_chk_div";
}
//endregion
//region 03_37	ファイル初期・リクエストグループマスタ	c_finit_grp_mst
/// 03_37 ファイル初期・リクエストグループマスタ  c_finit_grp_mstクラス
class CFinitGrpMstColumns extends TableColumns{
  int? finit_grp_cd;
  String? finit_grp_name;

  @override
  String _getTableName() => "c_finit_grp_mst";

  @override
  String? _getKeyCondition() => 'finit_grp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(finit_grp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CFinitGrpMstColumns rn = CFinitGrpMstColumns();
      rn.finit_grp_cd = maps[i]['finit_grp_cd'];
      rn.finit_grp_name = maps[i]['finit_grp_name'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CFinitGrpMstColumns rn = CFinitGrpMstColumns();
    rn.finit_grp_cd = maps[0]['finit_grp_cd'];
    rn.finit_grp_name = maps[0]['finit_grp_name'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CFinitGrpMstField.finit_grp_cd : this.finit_grp_cd,
      CFinitGrpMstField.finit_grp_name : this.finit_grp_name,
    };
  }
}

/// 03_37 ファイル初期・リクエストグループマスタ  c_finit_grp_mstのフィールド名設定用クラス
class CFinitGrpMstField {
  static const finit_grp_cd = "finit_grp_cd";
  static const finit_grp_name = "finit_grp_name";
}
//endregion
//region 03_38	テーブル名管理マスタ	c_set_tbl_name_mst
/// 03_38 テーブル名管理マスタ c_set_tbl_name_mstクラス
class CSetTblNameMstColumns extends TableColumns{
  String? set_tbl_name;
  String? disp_name;

  @override
  String _getTableName() => "c_set_tbl_name_mst";

  @override
  String? _getKeyCondition() => 'set_tbl_name = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(set_tbl_name);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CSetTblNameMstColumns rn = CSetTblNameMstColumns();
      rn.set_tbl_name = maps[i]['set_tbl_name'];
      rn.disp_name = maps[i]['disp_name'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CSetTblNameMstColumns rn = CSetTblNameMstColumns();
    rn.set_tbl_name = maps[0]['set_tbl_name'];
    rn.disp_name = maps[0]['disp_name'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CSetTblNameMstField.set_tbl_name : this.set_tbl_name,
      CSetTblNameMstField.disp_name : this.disp_name,
    };
  }
}

/// 03_38 テーブル名管理マスタ c_set_tbl_name_mstのフィールド名設定用クラス
class CSetTblNameMstField {
  static const set_tbl_name = "set_tbl_name";
  static const disp_name = "disp_name";
}
//endregion
//region 03_39	アプリグループマスタ	c_appl_grp_mst
/// 03_39 アプリグループマスタ c_appl_grp_mstクラス
class CApplGrpMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? appl_grp_cd;
  String? appl_name;
  String? cond_con_typ;
  int cond_trm_cd = 0;
  int recog_grp_cd = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int menu_chk_flg = 0;
  int flg_1 = 0;
  int flg_2 = 0;
  int flg_3 = 0;
  int flg_4 = 0;

  @override
  String _getTableName() => "c_appl_grp_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND appl_grp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(appl_grp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CApplGrpMstColumns rn = CApplGrpMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.appl_grp_cd = maps[i]['appl_grp_cd'];
      rn.appl_name = maps[i]['appl_name'];
      rn.cond_con_typ = maps[i]['cond_con_typ'];
      rn.cond_trm_cd = maps[i]['cond_trm_cd'];
      rn.recog_grp_cd = maps[i]['recog_grp_cd'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.menu_chk_flg = maps[i]['menu_chk_flg'];
      rn.flg_1 = maps[i]['flg_1'];
      rn.flg_2 = maps[i]['flg_2'];
      rn.flg_3 = maps[i]['flg_3'];
      rn.flg_4 = maps[i]['flg_4'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CApplGrpMstColumns rn = CApplGrpMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.appl_grp_cd = maps[0]['appl_grp_cd'];
    rn.appl_name = maps[0]['appl_name'];
    rn.cond_con_typ = maps[0]['cond_con_typ'];
    rn.cond_trm_cd = maps[0]['cond_trm_cd'];
    rn.recog_grp_cd = maps[0]['recog_grp_cd'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.menu_chk_flg = maps[0]['menu_chk_flg'];
    rn.flg_1 = maps[0]['flg_1'];
    rn.flg_2 = maps[0]['flg_2'];
    rn.flg_3 = maps[0]['flg_3'];
    rn.flg_4 = maps[0]['flg_4'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CApplGrpMstField.comp_cd : this.comp_cd,
      CApplGrpMstField.stre_cd : this.stre_cd,
      CApplGrpMstField.appl_grp_cd : this.appl_grp_cd,
      CApplGrpMstField.appl_name : this.appl_name,
      CApplGrpMstField.cond_con_typ : this.cond_con_typ,
      CApplGrpMstField.cond_trm_cd : this.cond_trm_cd,
      CApplGrpMstField.recog_grp_cd : this.recog_grp_cd,
      CApplGrpMstField.ins_datetime : this.ins_datetime,
      CApplGrpMstField.upd_datetime : this.upd_datetime,
      CApplGrpMstField.status : this.status,
      CApplGrpMstField.send_flg : this.send_flg,
      CApplGrpMstField.upd_user : this.upd_user,
      CApplGrpMstField.upd_system : this.upd_system,
      CApplGrpMstField.menu_chk_flg : this.menu_chk_flg,
      CApplGrpMstField.flg_1 : this.flg_1,
      CApplGrpMstField.flg_2 : this.flg_2,
      CApplGrpMstField.flg_3 : this.flg_3,
      CApplGrpMstField.flg_4 : this.flg_4,
    };
  }
}

/// 03_39 アプリグループマスタ c_appl_grp_mstのフィールド名設定用クラス
class CApplGrpMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const appl_grp_cd = "appl_grp_cd";
  static const appl_name = "appl_name";
  static const cond_con_typ = "cond_con_typ";
  static const cond_trm_cd = "cond_trm_cd";
  static const recog_grp_cd = "recog_grp_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const menu_chk_flg = "menu_chk_flg";
  static const flg_1 = "flg_1";
  static const flg_2 = "flg_2";
  static const flg_3 = "flg_3";
  static const flg_4 = "flg_4";
}
//endregion
//region 03_40	アプリマスタ	p_appl_mst
/// 03_40 アプリマスタ p_appl_mstクラス
class PApplMstColumns extends TableColumns{
  int? appl_grp_cd;
  int? appl_cd;
  int call_type = 0;
  String? name;
  String? position;
  String? param1;
  String? param2;
  String? param3;
  String? param4;
  String? param5;
  int recog_grp_cd = 0;
  int pause_flg = 0;

  @override
  String _getTableName() => "p_appl_mst";

  @override
  String? _getKeyCondition() => 'appl_grp_cd = ? AND appl_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(appl_grp_cd);
    rn.add(appl_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PApplMstColumns rn = PApplMstColumns();
      rn.appl_grp_cd = maps[i]['appl_grp_cd'];
      rn.appl_cd = maps[i]['appl_cd'];
      rn.call_type = maps[i]['call_type'];
      rn.name = maps[i]['name'];
      rn.position = maps[i]['position'];
      rn.param1 = maps[i]['param1'];
      rn.param2 = maps[i]['param2'];
      rn.param3 = maps[i]['param3'];
      rn.param4 = maps[i]['param4'];
      rn.param5 = maps[i]['param5'];
      rn.recog_grp_cd = maps[i]['recog_grp_cd'];
      rn.pause_flg = maps[i]['pause_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    PApplMstColumns rn = PApplMstColumns();
    rn.appl_grp_cd = maps[0]['appl_grp_cd'];
    rn.appl_cd = maps[0]['appl_cd'];
    rn.call_type = maps[0]['call_type'];
    rn.name = maps[0]['name'];
    rn.position = maps[0]['position'];
    rn.param1 = maps[0]['param1'];
    rn.param2 = maps[0]['param2'];
    rn.param3 = maps[0]['param3'];
    rn.param4 = maps[0]['param4'];
    rn.param5 = maps[0]['param5'];
    rn.recog_grp_cd = maps[0]['recog_grp_cd'];
    rn.pause_flg = maps[0]['pause_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      PApplMstField.appl_grp_cd : this.appl_grp_cd,
      PApplMstField.appl_cd : this.appl_cd,
      PApplMstField.call_type : this.call_type,
      PApplMstField.name : this.name,
      PApplMstField.position : this.position,
      PApplMstField.param1 : this.param1,
      PApplMstField.param2 : this.param2,
      PApplMstField.param3 : this.param3,
      PApplMstField.param4 : this.param4,
      PApplMstField.param5 : this.param5,
      PApplMstField.recog_grp_cd : this.recog_grp_cd,
      PApplMstField.pause_flg : this.pause_flg,
    };
  }
}

/// 03_40 アプリマスタ p_appl_mstのフィールド名設定用クラス
class PApplMstField {
  static const appl_grp_cd = "appl_grp_cd";
  static const appl_cd = "appl_cd";
  static const call_type = "call_type";
  static const name = "name";
  static const position = "position";
  static const param1 = "param1";
  static const param2 = "param2";
  static const param3 = "param3";
  static const param4 = "param4";
  static const param5 = "param5";
  static const recog_grp_cd = "recog_grp_cd";
  static const pause_flg = "pause_flg";
}
//endregion
//region 03_41	ダイアログマスタ	c_dialog_mst
/// 03_41 ダイアログマスタ c_dialog_mstクラス
class CDialogMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? dialog_cd;
  int title_img_cd = 0;
  int title_col = 0;
  int title_siz = 0;
  String? message1;
  int message1_col = 0;
  int message1_siz = 0;
  String? message2;
  int message2_col = 0;
  int message2_siz = 0;
  String? message3;
  int message3_col = 0;
  int message3_siz = 0;
  String? message4;
  int message4_col = 0;
  int message4_siz = 0;
  String? message5;
  int message5_col = 0;
  int message5_siz = 0;
  int dialog_typ = 0;
  int dialog_img_cd = 0;
  int dialog_icon_cd = 0;
  int dialog_sound_cd = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_dialog_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND dialog_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(dialog_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CDialogMstColumns rn = CDialogMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.dialog_cd = maps[i]['dialog_cd'];
      rn.title_img_cd = maps[i]['title_img_cd'];
      rn.title_col = maps[i]['title_col'];
      rn.title_siz = maps[i]['title_siz'];
      rn.message1 = maps[i]['message1'];
      rn.message1_col = maps[i]['message1_col'];
      rn.message1_siz = maps[i]['message1_siz'];
      rn.message2 = maps[i]['message2'];
      rn.message2_col = maps[i]['message2_col'];
      rn.message2_siz = maps[i]['message2_siz'];
      rn.message3 = maps[i]['message3'];
      rn.message3_col = maps[i]['message3_col'];
      rn.message3_siz = maps[i]['message3_siz'];
      rn.message4 = maps[i]['message4'];
      rn.message4_col = maps[i]['message4_col'];
      rn.message4_siz = maps[i]['message4_siz'];
      rn.message5 = maps[i]['message5'];
      rn.message5_col = maps[i]['message5_col'];
      rn.message5_siz = maps[i]['message5_siz'];
      rn.dialog_typ = maps[i]['dialog_typ'];
      rn.dialog_img_cd = maps[i]['dialog_img_cd'];
      rn.dialog_icon_cd = maps[i]['dialog_icon_cd'];
      rn.dialog_sound_cd = maps[i]['dialog_sound_cd'];
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
    CDialogMstColumns rn = CDialogMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.dialog_cd = maps[0]['dialog_cd'];
    rn.title_img_cd = maps[0]['title_img_cd'];
    rn.title_col = maps[0]['title_col'];
    rn.title_siz = maps[0]['title_siz'];
    rn.message1 = maps[0]['message1'];
    rn.message1_col = maps[0]['message1_col'];
    rn.message1_siz = maps[0]['message1_siz'];
    rn.message2 = maps[0]['message2'];
    rn.message2_col = maps[0]['message2_col'];
    rn.message2_siz = maps[0]['message2_siz'];
    rn.message3 = maps[0]['message3'];
    rn.message3_col = maps[0]['message3_col'];
    rn.message3_siz = maps[0]['message3_siz'];
    rn.message4 = maps[0]['message4'];
    rn.message4_col = maps[0]['message4_col'];
    rn.message4_siz = maps[0]['message4_siz'];
    rn.message5 = maps[0]['message5'];
    rn.message5_col = maps[0]['message5_col'];
    rn.message5_siz = maps[0]['message5_siz'];
    rn.dialog_typ = maps[0]['dialog_typ'];
    rn.dialog_img_cd = maps[0]['dialog_img_cd'];
    rn.dialog_icon_cd = maps[0]['dialog_icon_cd'];
    rn.dialog_sound_cd = maps[0]['dialog_sound_cd'];
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
      CDialogMstField.comp_cd : this.comp_cd,
      CDialogMstField.stre_cd : this.stre_cd,
      CDialogMstField.dialog_cd : this.dialog_cd,
      CDialogMstField.title_img_cd : this.title_img_cd,
      CDialogMstField.title_col : this.title_col,
      CDialogMstField.title_siz : this.title_siz,
      CDialogMstField.message1 : this.message1,
      CDialogMstField.message1_col : this.message1_col,
      CDialogMstField.message1_siz : this.message1_siz,
      CDialogMstField.message2 : this.message2,
      CDialogMstField.message2_col : this.message2_col,
      CDialogMstField.message2_siz : this.message2_siz,
      CDialogMstField.message3 : this.message3,
      CDialogMstField.message3_col : this.message3_col,
      CDialogMstField.message3_siz : this.message3_siz,
      CDialogMstField.message4 : this.message4,
      CDialogMstField.message4_col : this.message4_col,
      CDialogMstField.message4_siz : this.message4_siz,
      CDialogMstField.message5 : this.message5,
      CDialogMstField.message5_col : this.message5_col,
      CDialogMstField.message5_siz : this.message5_siz,
      CDialogMstField.dialog_typ : this.dialog_typ,
      CDialogMstField.dialog_img_cd : this.dialog_img_cd,
      CDialogMstField.dialog_icon_cd : this.dialog_icon_cd,
      CDialogMstField.dialog_sound_cd : this.dialog_sound_cd,
      CDialogMstField.ins_datetime : this.ins_datetime,
      CDialogMstField.upd_datetime : this.upd_datetime,
      CDialogMstField.status : this.status,
      CDialogMstField.send_flg : this.send_flg,
      CDialogMstField.upd_user : this.upd_user,
      CDialogMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_41 ダイアログマスタ c_dialog_mstのフィールド名設定用クラス
class CDialogMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const dialog_cd = "dialog_cd";
  static const title_img_cd = "title_img_cd";
  static const title_col = "title_col";
  static const title_siz = "title_siz";
  static const message1 = "message1";
  static const message1_col = "message1_col";
  static const message1_siz = "message1_siz";
  static const message2 = "message2";
  static const message2_col = "message2_col";
  static const message2_siz = "message2_siz";
  static const message3 = "message3";
  static const message3_col = "message3_col";
  static const message3_siz = "message3_siz";
  static const message4 = "message4";
  static const message4_col = "message4_col";
  static const message4_siz = "message4_siz";
  static const message5 = "message5";
  static const message5_col = "message5_col";
  static const message5_siz = "message5_siz";
  static const dialog_typ = "dialog_typ";
  static const dialog_img_cd = "dialog_img_cd";
  static const dialog_icon_cd = "dialog_icon_cd";
  static const dialog_sound_cd = "dialog_sound_cd";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_42	ダイアログマスタ(英語)	c_dialog_ex_mst
/// 03_42 ダイアログマスタ(英語) c_dialog_ex_mstクラス
class CDialogExMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? dialog_cd;
  int title_img_cd = 0;
  int title_col = 0;
  int title_siz = 0;
  String? message1;
  int message1_col = 0;
  int message1_siz = 0;
  String? message2;
  int message2_col = 0;
  int message2_siz = 0;
  String? message3;
  int message3_col = 0;
  int message3_siz = 0;
  String? message4;
  int message4_col = 0;
  int message4_siz = 0;
  String? message5;
  int message5_col = 0;
  int message5_siz = 0;
  int dialog_typ = 0;
  int dialog_img_cd = 0;
  int dialog_icon_cd = 0;
  int dialog_sound_cd = 0;
  String? btn1_msg;
  String? btn2_msg;
  String? btn3_msg;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_dialog_ex_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND dialog_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(dialog_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CDialogExMstColumns rn = CDialogExMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.dialog_cd = maps[i]['dialog_cd'];
      rn.title_img_cd = maps[i]['title_img_cd'];
      rn.title_col = maps[i]['title_col'];
      rn.title_siz = maps[i]['title_siz'];
      rn.message1 = maps[i]['message1'];
      rn.message1_col = maps[i]['message1_col'];
      rn.message1_siz = maps[i]['message1_siz'];
      rn.message2 = maps[i]['message2'];
      rn.message2_col = maps[i]['message2_col'];
      rn.message2_siz = maps[i]['message2_siz'];
      rn.message3 = maps[i]['message3'];
      rn.message3_col = maps[i]['message3_col'];
      rn.message3_siz = maps[i]['message3_siz'];
      rn.message4 = maps[i]['message4'];
      rn.message4_col = maps[i]['message4_col'];
      rn.message4_siz = maps[i]['message4_siz'];
      rn.message5 = maps[i]['message5'];
      rn.message5_col = maps[i]['message5_col'];
      rn.message5_siz = maps[i]['message5_siz'];
      rn.dialog_typ = maps[i]['dialog_typ'];
      rn.dialog_img_cd = maps[i]['dialog_img_cd'];
      rn.dialog_icon_cd = maps[i]['dialog_icon_cd'];
      rn.dialog_sound_cd = maps[i]['dialog_sound_cd'];
      rn.btn1_msg = maps[i]['btn1_msg'];
      rn.btn2_msg = maps[i]['btn2_msg'];
      rn.btn3_msg = maps[i]['btn3_msg'];
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
    CDialogExMstColumns rn = CDialogExMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.dialog_cd = maps[0]['dialog_cd'];
    rn.title_img_cd = maps[0]['title_img_cd'];
    rn.title_col = maps[0]['title_col'];
    rn.title_siz = maps[0]['title_siz'];
    rn.message1 = maps[0]['message1'];
    rn.message1_col = maps[0]['message1_col'];
    rn.message1_siz = maps[0]['message1_siz'];
    rn.message2 = maps[0]['message2'];
    rn.message2_col = maps[0]['message2_col'];
    rn.message2_siz = maps[0]['message2_siz'];
    rn.message3 = maps[0]['message3'];
    rn.message3_col = maps[0]['message3_col'];
    rn.message3_siz = maps[0]['message3_siz'];
    rn.message4 = maps[0]['message4'];
    rn.message4_col = maps[0]['message4_col'];
    rn.message4_siz = maps[0]['message4_siz'];
    rn.message5 = maps[0]['message5'];
    rn.message5_col = maps[0]['message5_col'];
    rn.message5_siz = maps[0]['message5_siz'];
    rn.dialog_typ = maps[0]['dialog_typ'];
    rn.dialog_img_cd = maps[0]['dialog_img_cd'];
    rn.dialog_icon_cd = maps[0]['dialog_icon_cd'];
    rn.dialog_sound_cd = maps[0]['dialog_sound_cd'];
    rn.btn1_msg = maps[0]['btn1_msg'];
    rn.btn2_msg = maps[0]['btn2_msg'];
    rn.btn3_msg = maps[0]['btn3_msg'];
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
      CDialogExMstField.comp_cd : this.comp_cd,
      CDialogExMstField.stre_cd : this.stre_cd,
      CDialogExMstField.dialog_cd : this.dialog_cd,
      CDialogExMstField.title_img_cd : this.title_img_cd,
      CDialogExMstField.title_col : this.title_col,
      CDialogExMstField.title_siz : this.title_siz,
      CDialogExMstField.message1 : this.message1,
      CDialogExMstField.message1_col : this.message1_col,
      CDialogExMstField.message1_siz : this.message1_siz,
      CDialogExMstField.message2 : this.message2,
      CDialogExMstField.message2_col : this.message2_col,
      CDialogExMstField.message2_siz : this.message2_siz,
      CDialogExMstField.message3 : this.message3,
      CDialogExMstField.message3_col : this.message3_col,
      CDialogExMstField.message3_siz : this.message3_siz,
      CDialogExMstField.message4 : this.message4,
      CDialogExMstField.message4_col : this.message4_col,
      CDialogExMstField.message4_siz : this.message4_siz,
      CDialogExMstField.message5 : this.message5,
      CDialogExMstField.message5_col : this.message5_col,
      CDialogExMstField.message5_siz : this.message5_siz,
      CDialogExMstField.dialog_typ : this.dialog_typ,
      CDialogExMstField.dialog_img_cd : this.dialog_img_cd,
      CDialogExMstField.dialog_icon_cd : this.dialog_icon_cd,
      CDialogExMstField.dialog_sound_cd : this.dialog_sound_cd,
      CDialogExMstField.btn1_msg : this.btn1_msg,
      CDialogExMstField.btn2_msg : this.btn2_msg,
      CDialogExMstField.btn3_msg : this.btn3_msg,
      CDialogExMstField.ins_datetime : this.ins_datetime,
      CDialogExMstField.upd_datetime : this.upd_datetime,
      CDialogExMstField.status : this.status,
      CDialogExMstField.send_flg : this.send_flg,
      CDialogExMstField.upd_user : this.upd_user,
      CDialogExMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_42 ダイアログマスタ(英語) c_dialog_ex_mstのフィールド名設定用クラス
class CDialogExMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const dialog_cd = "dialog_cd";
  static const title_img_cd = "title_img_cd";
  static const title_col = "title_col";
  static const title_siz = "title_siz";
  static const message1 = "message1";
  static const message1_col = "message1_col";
  static const message1_siz = "message1_siz";
  static const message2 = "message2";
  static const message2_col = "message2_col";
  static const message2_siz = "message2_siz";
  static const message3 = "message3";
  static const message3_col = "message3_col";
  static const message3_siz = "message3_siz";
  static const message4 = "message4";
  static const message4_col = "message4_col";
  static const message4_siz = "message4_siz";
  static const message5 = "message5";
  static const message5_col = "message5_col";
  static const message5_siz = "message5_siz";
  static const dialog_typ = "dialog_typ";
  static const dialog_img_cd = "dialog_img_cd";
  static const dialog_icon_cd = "dialog_icon_cd";
  static const dialog_sound_cd = "dialog_sound_cd";
  static const btn1_msg = "btn1_msg";
  static const btn2_msg = "btn2_msg";
  static const btn3_msg = "btn3_msg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_43	プロモーションスケジュールマスタ	p_promsch_mst
/// 03_43 プロモーションスケジュールマスタ p_promsch_mstクラス
class PPromschMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  String? plan_cd;
  int? prom_cd;
  int? prom_typ;
  int sch_typ = 0;
  String? prom_name;
  int reward_val = 0;
  String? item_cd;
  int lrgcls_cd = 0;
  int mdlcls_cd = 0;
  int smlcls_cd = 0;
  int tnycls_cd = 0;
  int dsc_val = 0;
  double? cost = 0;
  double? cost_per = 0;
  int cust_dsc_val = 0;
  int form_qty1 = 0;
  int form_qty2 = 0;
  int form_qty3 = 0;
  int form_qty4 = 0;
  int form_qty5 = 0;
  int form_prc1 = 0;
  int form_prc2 = 0;
  int form_prc3 = 0;
  int form_prc4 = 0;
  int form_prc5 = 0;
  int cust_form_prc1 = 0;
  int cust_form_prc2 = 0;
  int cust_form_prc3 = 0;
  int cust_form_prc4 = 0;
  int cust_form_prc5 = 0;
  int av_prc = 0;
  int cust_av_prc = 0;
  int avprc_adpt_flg = 0;
  int avprc_util_flg = 0;
  int low_limit = 0;
  int svs_typ = 0;
  int dsc_typ = 0;
  int rec_limit = 0;
  int rec_buy_limit = 0;
  String? start_datetime;
  String? end_datetime;
  int timesch_flg = 0;
  int sun_flg = 0;
  int mon_flg = 0;
  int tue_flg = 0;
  int wed_flg = 0;
  int thu_flg = 0;
  int fri_flg = 0;
  int sat_flg = 0;
  int eachsch_typ = 0;
  String? eachsch_flg;
  int stop_flg = 0;
  int min_prc = 0;
  int max_prc = 0;
  int tax_flg = 0;
  int member_qty = 0;
  int? div_cd = 0;
  int acct_cd = 0;
  String promo_ext_id = '0';
  int trends_typ = 0;
  int user_val_1 = 0;
  int user_val_2 = 0;
  int user_val_3 = 0;
  int user_val_4 = 0;
  int user_val_5 = 0;
  String? user_val_6;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  double? point_add_magn = 0;
  int point_add_mem_typ = 0;
  double? svs_cls_f_data1 = 0;
  int svs_cls_s_data1 = 0;
  int svs_cls_s_data2 = 0;
  int svs_cls_s_data3 = 0;
  double? plupts_rate = 0;
  int custsvs_unit = 0;
  int ref_acct = 0;
  int linked_prom_id = 0;
  int date_flg1 = 0;
  int date_flg2 = 0;
  int date_flg3 = 0;
  int date_flg4 = 0;
  int date_flg5 = 0;

  @override
  String _getTableName() => "p_promsch_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND prom_cd = ? AND prom_typ = ? AND item_cd = ? AND lrgcls_cd = ? AND mdlcls_cd = ? AND smlcls_cd = ? AND tnycls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(prom_cd);
    rn.add(prom_typ);
    rn.add(item_cd);
    rn.add(lrgcls_cd);
    rn.add(mdlcls_cd);
    rn.add(smlcls_cd);
    rn.add(tnycls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPromschMstColumns rn = PPromschMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.prom_cd = maps[i]['prom_cd'];
      rn.prom_typ = maps[i]['prom_typ'];
      rn.sch_typ = maps[i]['sch_typ'];
      rn.prom_name = maps[i]['prom_name'];
      rn.reward_val = maps[i]['reward_val'];
      rn.item_cd = maps[i]['item_cd'];
      rn.lrgcls_cd = maps[i]['lrgcls_cd'];
      rn.mdlcls_cd = maps[i]['mdlcls_cd'];
      rn.smlcls_cd = maps[i]['smlcls_cd'];
      rn.tnycls_cd = maps[i]['tnycls_cd'];
      rn.dsc_val = maps[i]['dsc_val'];
      rn.cost = maps[i]['cost'];
      rn.cost_per = maps[i]['cost_per'];
      rn.cust_dsc_val = maps[i]['cust_dsc_val'];
      rn.form_qty1 = maps[i]['form_qty1'];
      rn.form_qty2 = maps[i]['form_qty2'];
      rn.form_qty3 = maps[i]['form_qty3'];
      rn.form_qty4 = maps[i]['form_qty4'];
      rn.form_qty5 = maps[i]['form_qty5'];
      rn.form_prc1 = maps[i]['form_prc1'];
      rn.form_prc2 = maps[i]['form_prc2'];
      rn.form_prc3 = maps[i]['form_prc3'];
      rn.form_prc4 = maps[i]['form_prc4'];
      rn.form_prc5 = maps[i]['form_prc5'];
      rn.cust_form_prc1 = maps[i]['cust_form_prc1'];
      rn.cust_form_prc2 = maps[i]['cust_form_prc2'];
      rn.cust_form_prc3 = maps[i]['cust_form_prc3'];
      rn.cust_form_prc4 = maps[i]['cust_form_prc4'];
      rn.cust_form_prc5 = maps[i]['cust_form_prc5'];
      rn.av_prc = maps[i]['av_prc'];
      rn.cust_av_prc = maps[i]['cust_av_prc'];
      rn.avprc_adpt_flg = maps[i]['avprc_adpt_flg'];
      rn.avprc_util_flg = maps[i]['avprc_util_flg'];
      rn.low_limit = maps[i]['low_limit'];
      rn.svs_typ = maps[i]['svs_typ'];
      rn.dsc_typ = maps[i]['dsc_typ'];
      rn.rec_limit = maps[i]['rec_limit'];
      rn.rec_buy_limit = maps[i]['rec_buy_limit'];
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
      rn.eachsch_typ = maps[i]['eachsch_typ'];
      rn.eachsch_flg = maps[i]['eachsch_flg'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.min_prc = maps[i]['min_prc'];
      rn.max_prc = maps[i]['max_prc'];
      rn.tax_flg = maps[i]['tax_flg'];
      rn.member_qty = maps[i]['member_qty'];
      rn.div_cd = maps[i]['div_cd'];
      rn.acct_cd = maps[i]['acct_cd'];
      rn.promo_ext_id = maps[i]['promo_ext_id'];
      rn.trends_typ = maps[i]['trends_typ'];
      rn.user_val_1 = maps[i]['user_val_1'];
      rn.user_val_2 = maps[i]['user_val_2'];
      rn.user_val_3 = maps[i]['user_val_3'];
      rn.user_val_4 = maps[i]['user_val_4'];
      rn.user_val_5 = maps[i]['user_val_5'];
      rn.user_val_6 = maps[i]['user_val_6'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.point_add_magn = maps[i]['point_add_magn'];
      rn.point_add_mem_typ = maps[i]['point_add_mem_typ'];
      rn.svs_cls_f_data1 = maps[i]['svs_cls_f_data1'];
      rn.svs_cls_s_data1 = maps[i]['svs_cls_s_data1'];
      rn.svs_cls_s_data2 = maps[i]['svs_cls_s_data2'];
      rn.svs_cls_s_data3 = maps[i]['svs_cls_s_data3'];
      rn.plupts_rate = maps[i]['plupts_rate'];
      rn.custsvs_unit = maps[i]['custsvs_unit'];
      rn.ref_acct = maps[i]['ref_acct'];
      rn.linked_prom_id = maps[i]['linked_prom_id'];
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
    PPromschMstColumns rn = PPromschMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.prom_cd = maps[0]['prom_cd'];
    rn.prom_typ = maps[0]['prom_typ'];
    rn.sch_typ = maps[0]['sch_typ'];
    rn.prom_name = maps[0]['prom_name'];
    rn.reward_val = maps[0]['reward_val'];
    rn.item_cd = maps[0]['item_cd'];
    rn.lrgcls_cd = maps[0]['lrgcls_cd'];
    rn.mdlcls_cd = maps[0]['mdlcls_cd'];
    rn.smlcls_cd = maps[0]['smlcls_cd'];
    rn.tnycls_cd = maps[0]['tnycls_cd'];
    rn.dsc_val = maps[0]['dsc_val'];
    rn.cost = maps[0]['cost'];
    rn.cost_per = maps[0]['cost_per'];
    rn.cust_dsc_val = maps[0]['cust_dsc_val'];
    rn.form_qty1 = maps[0]['form_qty1'];
    rn.form_qty2 = maps[0]['form_qty2'];
    rn.form_qty3 = maps[0]['form_qty3'];
    rn.form_qty4 = maps[0]['form_qty4'];
    rn.form_qty5 = maps[0]['form_qty5'];
    rn.form_prc1 = maps[0]['form_prc1'];
    rn.form_prc2 = maps[0]['form_prc2'];
    rn.form_prc3 = maps[0]['form_prc3'];
    rn.form_prc4 = maps[0]['form_prc4'];
    rn.form_prc5 = maps[0]['form_prc5'];
    rn.cust_form_prc1 = maps[0]['cust_form_prc1'];
    rn.cust_form_prc2 = maps[0]['cust_form_prc2'];
    rn.cust_form_prc3 = maps[0]['cust_form_prc3'];
    rn.cust_form_prc4 = maps[0]['cust_form_prc4'];
    rn.cust_form_prc5 = maps[0]['cust_form_prc5'];
    rn.av_prc = maps[0]['av_prc'];
    rn.cust_av_prc = maps[0]['cust_av_prc'];
    rn.avprc_adpt_flg = maps[0]['avprc_adpt_flg'];
    rn.avprc_util_flg = maps[0]['avprc_util_flg'];
    rn.low_limit = maps[0]['low_limit'];
    rn.svs_typ = maps[0]['svs_typ'];
    rn.dsc_typ = maps[0]['dsc_typ'];
    rn.rec_limit = maps[0]['rec_limit'];
    rn.rec_buy_limit = maps[0]['rec_buy_limit'];
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
    rn.eachsch_typ = maps[0]['eachsch_typ'];
    rn.eachsch_flg = maps[0]['eachsch_flg'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.min_prc = maps[0]['min_prc'];
    rn.max_prc = maps[0]['max_prc'];
    rn.tax_flg = maps[0]['tax_flg'];
    rn.member_qty = maps[0]['member_qty'];
    rn.div_cd = maps[0]['div_cd'];
    rn.acct_cd = maps[0]['acct_cd'];
    rn.promo_ext_id = maps[0]['promo_ext_id'];
    rn.trends_typ = maps[0]['trends_typ'];
    rn.user_val_1 = maps[0]['user_val_1'];
    rn.user_val_2 = maps[0]['user_val_2'];
    rn.user_val_3 = maps[0]['user_val_3'];
    rn.user_val_4 = maps[0]['user_val_4'];
    rn.user_val_5 = maps[0]['user_val_5'];
    rn.user_val_6 = maps[0]['user_val_6'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.point_add_magn = maps[0]['point_add_magn'];
    rn.point_add_mem_typ = maps[0]['point_add_mem_typ'];
    rn.svs_cls_f_data1 = maps[0]['svs_cls_f_data1'];
    rn.svs_cls_s_data1 = maps[0]['svs_cls_s_data1'];
    rn.svs_cls_s_data2 = maps[0]['svs_cls_s_data2'];
    rn.svs_cls_s_data3 = maps[0]['svs_cls_s_data3'];
    rn.plupts_rate = maps[0]['plupts_rate'];
    rn.custsvs_unit = maps[0]['custsvs_unit'];
    rn.ref_acct = maps[0]['ref_acct'];
    rn.linked_prom_id = maps[0]['linked_prom_id'];
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
      PPromschMstField.comp_cd : this.comp_cd,
      PPromschMstField.stre_cd : this.stre_cd,
      PPromschMstField.plan_cd : this.plan_cd,
      PPromschMstField.prom_cd : this.prom_cd,
      PPromschMstField.prom_typ : this.prom_typ,
      PPromschMstField.sch_typ : this.sch_typ,
      PPromschMstField.prom_name : this.prom_name,
      PPromschMstField.reward_val : this.reward_val,
      PPromschMstField.item_cd : this.item_cd,
      PPromschMstField.lrgcls_cd : this.lrgcls_cd,
      PPromschMstField.mdlcls_cd : this.mdlcls_cd,
      PPromschMstField.smlcls_cd : this.smlcls_cd,
      PPromschMstField.tnycls_cd : this.tnycls_cd,
      PPromschMstField.dsc_val : this.dsc_val,
      PPromschMstField.cost : this.cost,
      PPromschMstField.cost_per : this.cost_per,
      PPromschMstField.cust_dsc_val : this.cust_dsc_val,
      PPromschMstField.form_qty1 : this.form_qty1,
      PPromschMstField.form_qty2 : this.form_qty2,
      PPromschMstField.form_qty3 : this.form_qty3,
      PPromschMstField.form_qty4 : this.form_qty4,
      PPromschMstField.form_qty5 : this.form_qty5,
      PPromschMstField.form_prc1 : this.form_prc1,
      PPromschMstField.form_prc2 : this.form_prc2,
      PPromschMstField.form_prc3 : this.form_prc3,
      PPromschMstField.form_prc4 : this.form_prc4,
      PPromschMstField.form_prc5 : this.form_prc5,
      PPromschMstField.cust_form_prc1 : this.cust_form_prc1,
      PPromschMstField.cust_form_prc2 : this.cust_form_prc2,
      PPromschMstField.cust_form_prc3 : this.cust_form_prc3,
      PPromschMstField.cust_form_prc4 : this.cust_form_prc4,
      PPromschMstField.cust_form_prc5 : this.cust_form_prc5,
      PPromschMstField.av_prc : this.av_prc,
      PPromschMstField.cust_av_prc : this.cust_av_prc,
      PPromschMstField.avprc_adpt_flg : this.avprc_adpt_flg,
      PPromschMstField.avprc_util_flg : this.avprc_util_flg,
      PPromschMstField.low_limit : this.low_limit,
      PPromschMstField.svs_typ : this.svs_typ,
      PPromschMstField.dsc_typ : this.dsc_typ,
      PPromschMstField.rec_limit : this.rec_limit,
      PPromschMstField.rec_buy_limit : this.rec_buy_limit,
      PPromschMstField.start_datetime : this.start_datetime,
      PPromschMstField.end_datetime : this.end_datetime,
      PPromschMstField.timesch_flg : this.timesch_flg,
      PPromschMstField.sun_flg : this.sun_flg,
      PPromschMstField.mon_flg : this.mon_flg,
      PPromschMstField.tue_flg : this.tue_flg,
      PPromschMstField.wed_flg : this.wed_flg,
      PPromschMstField.thu_flg : this.thu_flg,
      PPromschMstField.fri_flg : this.fri_flg,
      PPromschMstField.sat_flg : this.sat_flg,
      PPromschMstField.eachsch_typ : this.eachsch_typ,
      PPromschMstField.eachsch_flg : this.eachsch_flg,
      PPromschMstField.stop_flg : this.stop_flg,
      PPromschMstField.min_prc : this.min_prc,
      PPromschMstField.max_prc : this.max_prc,
      PPromschMstField.tax_flg : this.tax_flg,
      PPromschMstField.member_qty : this.member_qty,
      PPromschMstField.div_cd : this.div_cd,
      PPromschMstField.acct_cd : this.acct_cd,
      PPromschMstField.promo_ext_id : this.promo_ext_id,
      PPromschMstField.trends_typ : this.trends_typ,
      PPromschMstField.user_val_1 : this.user_val_1,
      PPromschMstField.user_val_2 : this.user_val_2,
      PPromschMstField.user_val_3 : this.user_val_3,
      PPromschMstField.user_val_4 : this.user_val_4,
      PPromschMstField.user_val_5 : this.user_val_5,
      PPromschMstField.user_val_6 : this.user_val_6,
      PPromschMstField.ins_datetime : this.ins_datetime,
      PPromschMstField.upd_datetime : this.upd_datetime,
      PPromschMstField.status : this.status,
      PPromschMstField.send_flg : this.send_flg,
      PPromschMstField.upd_user : this.upd_user,
      PPromschMstField.upd_system : this.upd_system,
      PPromschMstField.point_add_magn : this.point_add_magn,
      PPromschMstField.point_add_mem_typ : this.point_add_mem_typ,
      PPromschMstField.svs_cls_f_data1 : this.svs_cls_f_data1,
      PPromschMstField.svs_cls_s_data1 : this.svs_cls_s_data1,
      PPromschMstField.svs_cls_s_data2 : this.svs_cls_s_data2,
      PPromschMstField.svs_cls_s_data3 : this.svs_cls_s_data3,
      PPromschMstField.plupts_rate : this.plupts_rate,
      PPromschMstField.custsvs_unit : this.custsvs_unit,
      PPromschMstField.ref_acct : this.ref_acct,
      PPromschMstField.linked_prom_id : this.linked_prom_id,
      PPromschMstField.date_flg1 : this.date_flg1,
      PPromschMstField.date_flg2 : this.date_flg2,
      PPromschMstField.date_flg3 : this.date_flg3,
      PPromschMstField.date_flg4 : this.date_flg4,
      PPromschMstField.date_flg5 : this.date_flg5,
    };
  }
}

/// 03_43 プロモーションスケジュールマスタ p_promsch_mstのフィールド名設定用クラス
class PPromschMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plan_cd = "plan_cd";
  static const prom_cd = "prom_cd";
  static const prom_typ = "prom_typ";
  static const sch_typ = "sch_typ";
  static const prom_name = "prom_name";
  static const reward_val = "reward_val";
  static const item_cd = "item_cd";
  static const lrgcls_cd = "lrgcls_cd";
  static const mdlcls_cd = "mdlcls_cd";
  static const smlcls_cd = "smlcls_cd";
  static const tnycls_cd = "tnycls_cd";
  static const dsc_val = "dsc_val";
  static const cost = "cost";
  static const cost_per = "cost_per";
  static const cust_dsc_val = "cust_dsc_val";
  static const form_qty1 = "form_qty1";
  static const form_qty2 = "form_qty2";
  static const form_qty3 = "form_qty3";
  static const form_qty4 = "form_qty4";
  static const form_qty5 = "form_qty5";
  static const form_prc1 = "form_prc1";
  static const form_prc2 = "form_prc2";
  static const form_prc3 = "form_prc3";
  static const form_prc4 = "form_prc4";
  static const form_prc5 = "form_prc5";
  static const cust_form_prc1 = "cust_form_prc1";
  static const cust_form_prc2 = "cust_form_prc2";
  static const cust_form_prc3 = "cust_form_prc3";
  static const cust_form_prc4 = "cust_form_prc4";
  static const cust_form_prc5 = "cust_form_prc5";
  static const av_prc = "av_prc";
  static const cust_av_prc = "cust_av_prc";
  static const avprc_adpt_flg = "avprc_adpt_flg";
  static const avprc_util_flg = "avprc_util_flg";
  static const low_limit = "low_limit";
  static const svs_typ = "svs_typ";
  static const dsc_typ = "dsc_typ";
  static const rec_limit = "rec_limit";
  static const rec_buy_limit = "rec_buy_limit";
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
  static const eachsch_typ = "eachsch_typ";
  static const eachsch_flg = "eachsch_flg";
  static const stop_flg = "stop_flg";
  static const min_prc = "min_prc";
  static const max_prc = "max_prc";
  static const tax_flg = "tax_flg";
  static const member_qty = "member_qty";
  static const div_cd = "div_cd";
  static const acct_cd = "acct_cd";
  static const promo_ext_id = "promo_ext_id";
  static const trends_typ = "trends_typ";
  static const user_val_1 = "user_val_1";
  static const user_val_2 = "user_val_2";
  static const user_val_3 = "user_val_3";
  static const user_val_4 = "user_val_4";
  static const user_val_5 = "user_val_5";
  static const user_val_6 = "user_val_6";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const point_add_magn = "point_add_magn";
  static const point_add_mem_typ = "point_add_mem_typ";
  static const svs_cls_f_data1 = "svs_cls_f_data1";
  static const svs_cls_s_data1 = "svs_cls_s_data1";
  static const svs_cls_s_data2 = "svs_cls_s_data2";
  static const svs_cls_s_data3 = "svs_cls_s_data3";
  static const plupts_rate = "plupts_rate";
  static const custsvs_unit = "custsvs_unit";
  static const ref_acct = "ref_acct";
  static const linked_prom_id = "linked_prom_id";
  static const date_flg1 = "date_flg1";
  static const date_flg2 = "date_flg2";
  static const date_flg3 = "date_flg3";
  static const date_flg4 = "date_flg4";
  static const date_flg5 = "date_flg5";
}
//endregion
//region 03_44	プロモーション商品マスタ	p_promitem_mst
/// 03_44 プロモーション商品マスタ p_promitem_mstクラス
class PPromitemMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  String? plan_cd;
  int? prom_cd;
  int? prom_typ;
  int item_typ = 0;
  String? item_cd;
  String? item_cd2;
  int stop_flg = 0;
  int set_qty = 0;
  int? grp_cd;
  int user_val_1 = 0;
  int user_val_2 = 0;
  int user_val_3 = 0;
  int user_val_4 = 0;
  int user_val_5 = 0;
  String? user_val_6;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "p_promitem_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND plan_cd = ? AND prom_cd = ? AND item_cd = ? AND item_cd2 = ? AND grp_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(plan_cd);
    rn.add(prom_cd);
    rn.add(item_cd);
    rn.add(item_cd2);
    rn.add(grp_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      PPromitemMstColumns rn = PPromitemMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plan_cd = maps[i]['plan_cd'];
      rn.prom_cd = maps[i]['prom_cd'];
      rn.prom_typ = maps[i]['prom_typ'];
      rn.item_typ = maps[i]['item_typ'];
      rn.item_cd = maps[i]['item_cd'];
      rn.item_cd2 = maps[i]['item_cd2'];
      rn.stop_flg = maps[i]['stop_flg'];
      rn.set_qty = maps[i]['set_qty'];
      rn.grp_cd = maps[i]['grp_cd'];
      rn.user_val_1 = maps[i]['user_val_1'];
      rn.user_val_2 = maps[i]['user_val_2'];
      rn.user_val_3 = maps[i]['user_val_3'];
      rn.user_val_4 = maps[i]['user_val_4'];
      rn.user_val_5 = maps[i]['user_val_5'];
      rn.user_val_6 = maps[i]['user_val_6'];
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
    PPromitemMstColumns rn = PPromitemMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plan_cd = maps[0]['plan_cd'];
    rn.prom_cd = maps[0]['prom_cd'];
    rn.prom_typ = maps[0]['prom_typ'];
    rn.item_typ = maps[0]['item_typ'];
    rn.item_cd = maps[0]['item_cd'];
    rn.item_cd2 = maps[0]['item_cd2'];
    rn.stop_flg = maps[0]['stop_flg'];
    rn.set_qty = maps[0]['set_qty'];
    rn.grp_cd = maps[0]['grp_cd'];
    rn.user_val_1 = maps[0]['user_val_1'];
    rn.user_val_2 = maps[0]['user_val_2'];
    rn.user_val_3 = maps[0]['user_val_3'];
    rn.user_val_4 = maps[0]['user_val_4'];
    rn.user_val_5 = maps[0]['user_val_5'];
    rn.user_val_6 = maps[0]['user_val_6'];
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
      PPromitemMstField.comp_cd : this.comp_cd,
      PPromitemMstField.stre_cd : this.stre_cd,
      PPromitemMstField.plan_cd : this.plan_cd,
      PPromitemMstField.prom_cd : this.prom_cd,
      PPromitemMstField.prom_typ : this.prom_typ,
      PPromitemMstField.item_typ : this.item_typ,
      PPromitemMstField.item_cd : this.item_cd,
      PPromitemMstField.item_cd2 : this.item_cd2,
      PPromitemMstField.stop_flg : this.stop_flg,
      PPromitemMstField.set_qty : this.set_qty,
      PPromitemMstField.grp_cd : this.grp_cd,
      PPromitemMstField.user_val_1 : this.user_val_1,
      PPromitemMstField.user_val_2 : this.user_val_2,
      PPromitemMstField.user_val_3 : this.user_val_3,
      PPromitemMstField.user_val_4 : this.user_val_4,
      PPromitemMstField.user_val_5 : this.user_val_5,
      PPromitemMstField.user_val_6 : this.user_val_6,
      PPromitemMstField.ins_datetime : this.ins_datetime,
      PPromitemMstField.upd_datetime : this.upd_datetime,
      PPromitemMstField.status : this.status,
      PPromitemMstField.send_flg : this.send_flg,
      PPromitemMstField.upd_user : this.upd_user,
      PPromitemMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_44 プロモーション商品マスタ p_promitem_mstのフィールド名設定用クラス
class PPromitemMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plan_cd = "plan_cd";
  static const prom_cd = "prom_cd";
  static const prom_typ = "prom_typ";
  static const item_typ = "item_typ";
  static const item_cd = "item_cd";
  static const item_cd2 = "item_cd2";
  static const stop_flg = "stop_flg";
  static const set_qty = "set_qty";
  static const grp_cd = "grp_cd";
  static const user_val_1 = "user_val_1";
  static const user_val_2 = "user_val_2";
  static const user_val_3 = "user_val_3";
  static const user_val_4 = "user_val_4";
  static const user_val_5 = "user_val_5";
  static const user_val_6 = "user_val_6";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_45	インストアマーキングマスタ	c_instre_mst
/// インストアマーキングマスタクラス
class CInstreMstColumns extends TableColumns {
  int comp_cd = 0;
  String instre_flg = '';
  int format_no = 0;
  int format_typ = 0;
  int cls_code = 0;
  String ins_datetime = '';
  String upd_datetime = '';
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => 'c_instre_mst';

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND instre_flg = ? AND format_no = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(instre_flg);
    rn.add(format_no);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      CInstreMstColumns rn = CInstreMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.instre_flg = maps[i]['instre_flg'];
      rn.format_no = maps[i]['format_no'];
      rn.format_typ = maps[i]['format_typ'];
      rn.cls_code = maps[i]['cls_code'];
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
    CInstreMstColumns rn = CInstreMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.instre_flg = maps[0]['instre_flg'];
    rn.format_no = maps[0]['format_no'];
    rn.format_typ = maps[0]['format_typ'];
    rn.cls_code = maps[0]['cls_code'];
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
      CInstreMstField.comp_cd: comp_cd,
      CInstreMstField.instre_flg: instre_flg,
      CInstreMstField.format_no: format_no,
      CInstreMstField.format_typ: format_typ,
      CInstreMstField.cls_code: cls_code,
      CInstreMstField.ins_datetime: ins_datetime,
      CInstreMstField.upd_datetime: upd_datetime,
      CInstreMstField.status: status,
      CInstreMstField.send_flg: send_flg,
      CInstreMstField.upd_user: upd_user,
      CInstreMstField.upd_system: upd_system,
    };
  }
}

/// インストアマーキングマスタのフィールド名設定用クラス
class CInstreMstField {
  static const comp_cd = 'comp_cd';
  static const instre_flg = 'instre_flg';
  static const format_no = 'format_no';
  static const format_typ = 'format_typ';
  static const cls_code = 'cls_code';
  static const ins_datetime = 'ins_datetime';
  static const upd_datetime = 'upd_datetime';
  static const status = 'status';
  static const send_flg = 'send_flg';
  static const upd_user = 'upd_user';
  static const upd_system = 'upd_system';
}
//endregion
//region 03_46	フォーマットタイプマスタ	c_fmttyp_mst
/// 03_46 フォーマットタイプマスタ c_fmttyp_mstクラス
class CFmttypMstColumns extends TableColumns{
  int? format_typ;
  String? format_typ_name;
  int disp_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_fmttyp_mst";

  @override
  String? _getKeyCondition() => 'format_typ = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(format_typ);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CFmttypMstColumns rn = CFmttypMstColumns();
      rn.format_typ = maps[i]['format_typ'];
      rn.format_typ_name = maps[i]['format_typ_name'];
      rn.disp_flg = maps[i]['disp_flg'];
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
    CFmttypMstColumns rn = CFmttypMstColumns();
    rn.format_typ = maps[0]['format_typ'];
    rn.format_typ_name = maps[0]['format_typ_name'];
    rn.disp_flg = maps[0]['disp_flg'];
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
      CFmttypMstField.format_typ : this.format_typ,
      CFmttypMstField.format_typ_name : this.format_typ_name,
      CFmttypMstField.disp_flg : this.disp_flg,
      CFmttypMstField.ins_datetime : this.ins_datetime,
      CFmttypMstField.upd_datetime : this.upd_datetime,
      CFmttypMstField.status : this.status,
      CFmttypMstField.send_flg : this.send_flg,
      CFmttypMstField.upd_user : this.upd_user,
      CFmttypMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_46 フォーマットタイプマスタ c_fmttyp_mstのフィールド名設定用クラス
class CFmttypMstField {
  static const format_typ = "format_typ";
  static const format_typ_name = "format_typ_name";
  static const disp_flg = "disp_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_47	バーコードフォーマットマスタ	c_barfmt_mst
/// 03_47 バーコードフォーマットマスタ c_barfmt_mstクラス
class CBarfmtMstColumns extends TableColumns{
  int? format_no;
  int? format_typ;
  String? format;
  int flg_num = 0;
  int format_num = 0;
  int disp_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int cls_flg = 0;

  @override
  String _getTableName() => "c_barfmt_mst";

  @override
  String? _getKeyCondition() => 'format_no = ? AND format_typ = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(format_no);
    rn.add(format_typ);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CBarfmtMstColumns rn = CBarfmtMstColumns();
      rn.format_no = maps[i]['format_no'];
      rn.format_typ = maps[i]['format_typ'];
      rn.format = maps[i]['format'];
      rn.flg_num = maps[i]['flg_num'];
      rn.format_num = maps[i]['format_num'];
      rn.disp_flg = maps[i]['disp_flg'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.cls_flg = maps[i]['cls_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CBarfmtMstColumns rn = CBarfmtMstColumns();
    rn.format_no = maps[0]['format_no'];
    rn.format_typ = maps[0]['format_typ'];
    rn.format = maps[0]['format'];
    rn.flg_num = maps[0]['flg_num'];
    rn.format_num = maps[0]['format_num'];
    rn.disp_flg = maps[0]['disp_flg'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.cls_flg = maps[0]['cls_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CBarfmtMstField.format_no : this.format_no,
      CBarfmtMstField.format_typ : this.format_typ,
      CBarfmtMstField.format : this.format,
      CBarfmtMstField.flg_num : this.flg_num,
      CBarfmtMstField.format_num : this.format_num,
      CBarfmtMstField.disp_flg : this.disp_flg,
      CBarfmtMstField.ins_datetime : this.ins_datetime,
      CBarfmtMstField.upd_datetime : this.upd_datetime,
      CBarfmtMstField.status : this.status,
      CBarfmtMstField.send_flg : this.send_flg,
      CBarfmtMstField.upd_user : this.upd_user,
      CBarfmtMstField.upd_system : this.upd_system,
      CBarfmtMstField.cls_flg : this.cls_flg,
    };
  }
}

/// 03_47 バーコードフォーマットマスタ c_barfmt_mstのフィールド名設定用クラス
class CBarfmtMstField {
  static const format_no = "format_no";
  static const format_typ = "format_typ";
  static const format = "format";
  static const flg_num = "flg_num";
  static const format_num = "format_num";
  static const disp_flg = "disp_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const cls_flg = "cls_flg";
}
//endregion
//region 03_48	メッセージマスタ	c_msg_mst
/// 03_48 メッセージマスタ c_msg_mstクラス
class CMsgMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? msg_cd;
  int msg_kind = 0;
  String? msg_data_1;
  String? msg_data_2;
  String? msg_data_3;
  String? msg_data_4;
  String? msg_data_5;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;
  int msg_size_1 = 0;
  int msg_size_2 = 0;
  int msg_size_3 = 0;
  int msg_size_4 = 0;
  int msg_size_5 = 0;
  int? msg_color_1 = 1;
  int? msg_color_2 = 1;
  int? msg_color_3 = 1;
  int? msg_color_4 = 1;
  int? msg_color_5 = 1;
  int? back_color = 1;
  int back_pict_typ = 0;
  int? second;
  int flg_01 = 0;
  int flg_02 = 0;
  int flg_03 = 0;
  int flg_04 = 0;
  int flg_05 = 0;
  String? msg_data_6;
  String? msg_data_7;
  String? msg_data_8;
  String? msg_data_9;
  String? msg_data_10;
  int msg_size_6 = 0;
  int msg_size_7 = 0;
  int msg_size_8 = 0;
  int msg_size_9 = 0;
  int msg_size_10 = 0;
  int? msg_color_6 = 1;
  int? msg_color_7 = 1;
  int? msg_color_8 = 1;
  int? msg_color_9 = 1;
  int? msg_color_10 = 1;
  int flg_06 = 0;
  int flg_07 = 0;
  int flg_08 = 0;
  int flg_09 = 0;
  int flg_10 = 0;

  @override
  String _getTableName() => "c_msg_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND msg_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(msg_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMsgMstColumns rn = CMsgMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.msg_cd = maps[i]['msg_cd'];
      rn.msg_kind = maps[i]['msg_kind'];
      rn.msg_data_1 = maps[i]['msg_data_1'];
      rn.msg_data_2 = maps[i]['msg_data_2'];
      rn.msg_data_3 = maps[i]['msg_data_3'];
      rn.msg_data_4 = maps[i]['msg_data_4'];
      rn.msg_data_5 = maps[i]['msg_data_5'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.status = maps[i]['status'];
      rn.send_flg = maps[i]['send_flg'];
      rn.upd_user = maps[i]['upd_user'];
      rn.upd_system = maps[i]['upd_system'];
      rn.msg_size_1 = maps[i]['msg_size_1'];
      rn.msg_size_2 = maps[i]['msg_size_2'];
      rn.msg_size_3 = maps[i]['msg_size_3'];
      rn.msg_size_4 = maps[i]['msg_size_4'];
      rn.msg_size_5 = maps[i]['msg_size_5'];
      rn.msg_color_1 = maps[i]['msg_color_1'];
      rn.msg_color_2 = maps[i]['msg_color_2'];
      rn.msg_color_3 = maps[i]['msg_color_3'];
      rn.msg_color_4 = maps[i]['msg_color_4'];
      rn.msg_color_5 = maps[i]['msg_color_5'];
      rn.back_color = maps[i]['back_color'];
      rn.back_pict_typ = maps[i]['back_pict_typ'];
      rn.second = maps[i]['second'];
      rn.flg_01 = maps[i]['flg_01'];
      rn.flg_02 = maps[i]['flg_02'];
      rn.flg_03 = maps[i]['flg_03'];
      rn.flg_04 = maps[i]['flg_04'];
      rn.flg_05 = maps[i]['flg_05'];
      rn.msg_data_6 = maps[i]['msg_data_6'];
      rn.msg_data_7 = maps[i]['msg_data_7'];
      rn.msg_data_8 = maps[i]['msg_data_8'];
      rn.msg_data_9 = maps[i]['msg_data_9'];
      rn.msg_data_10 = maps[i]['msg_data_10'];
      rn.msg_size_6 = maps[i]['msg_size_6'];
      rn.msg_size_7 = maps[i]['msg_size_7'];
      rn.msg_size_8 = maps[i]['msg_size_8'];
      rn.msg_size_9 = maps[i]['msg_size_9'];
      rn.msg_size_10 = maps[i]['msg_size_10'];
      rn.msg_color_6 = maps[i]['msg_color_6'];
      rn.msg_color_7 = maps[i]['msg_color_7'];
      rn.msg_color_8 = maps[i]['msg_color_8'];
      rn.msg_color_9 = maps[i]['msg_color_9'];
      rn.msg_color_10 = maps[i]['msg_color_10'];
      rn.flg_06 = maps[i]['flg_06'];
      rn.flg_07 = maps[i]['flg_07'];
      rn.flg_08 = maps[i]['flg_08'];
      rn.flg_09 = maps[i]['flg_09'];
      rn.flg_10 = maps[i]['flg_10'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CMsgMstColumns rn = CMsgMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.msg_cd = maps[0]['msg_cd'];
    rn.msg_kind = maps[0]['msg_kind'];
    rn.msg_data_1 = maps[0]['msg_data_1'];
    rn.msg_data_2 = maps[0]['msg_data_2'];
    rn.msg_data_3 = maps[0]['msg_data_3'];
    rn.msg_data_4 = maps[0]['msg_data_4'];
    rn.msg_data_5 = maps[0]['msg_data_5'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.status = maps[0]['status'];
    rn.send_flg = maps[0]['send_flg'];
    rn.upd_user = maps[0]['upd_user'];
    rn.upd_system = maps[0]['upd_system'];
    rn.msg_size_1 = maps[0]['msg_size_1'];
    rn.msg_size_2 = maps[0]['msg_size_2'];
    rn.msg_size_3 = maps[0]['msg_size_3'];
    rn.msg_size_4 = maps[0]['msg_size_4'];
    rn.msg_size_5 = maps[0]['msg_size_5'];
    rn.msg_color_1 = maps[0]['msg_color_1'];
    rn.msg_color_2 = maps[0]['msg_color_2'];
    rn.msg_color_3 = maps[0]['msg_color_3'];
    rn.msg_color_4 = maps[0]['msg_color_4'];
    rn.msg_color_5 = maps[0]['msg_color_5'];
    rn.back_color = maps[0]['back_color'];
    rn.back_pict_typ = maps[0]['back_pict_typ'];
    rn.second = maps[0]['second'];
    rn.flg_01 = maps[0]['flg_01'];
    rn.flg_02 = maps[0]['flg_02'];
    rn.flg_03 = maps[0]['flg_03'];
    rn.flg_04 = maps[0]['flg_04'];
    rn.flg_05 = maps[0]['flg_05'];
    rn.msg_data_6 = maps[0]['msg_data_6'];
    rn.msg_data_7 = maps[0]['msg_data_7'];
    rn.msg_data_8 = maps[0]['msg_data_8'];
    rn.msg_data_9 = maps[0]['msg_data_9'];
    rn.msg_data_10 = maps[0]['msg_data_10'];
    rn.msg_size_6 = maps[0]['msg_size_6'];
    rn.msg_size_7 = maps[0]['msg_size_7'];
    rn.msg_size_8 = maps[0]['msg_size_8'];
    rn.msg_size_9 = maps[0]['msg_size_9'];
    rn.msg_size_10 = maps[0]['msg_size_10'];
    rn.msg_color_6 = maps[0]['msg_color_6'];
    rn.msg_color_7 = maps[0]['msg_color_7'];
    rn.msg_color_8 = maps[0]['msg_color_8'];
    rn.msg_color_9 = maps[0]['msg_color_9'];
    rn.msg_color_10 = maps[0]['msg_color_10'];
    rn.flg_06 = maps[0]['flg_06'];
    rn.flg_07 = maps[0]['flg_07'];
    rn.flg_08 = maps[0]['flg_08'];
    rn.flg_09 = maps[0]['flg_09'];
    rn.flg_10 = maps[0]['flg_10'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CMsgMstField.comp_cd : this.comp_cd,
      CMsgMstField.stre_cd : this.stre_cd,
      CMsgMstField.msg_cd : this.msg_cd,
      CMsgMstField.msg_kind : this.msg_kind,
      CMsgMstField.msg_data_1 : this.msg_data_1,
      CMsgMstField.msg_data_2 : this.msg_data_2,
      CMsgMstField.msg_data_3 : this.msg_data_3,
      CMsgMstField.msg_data_4 : this.msg_data_4,
      CMsgMstField.msg_data_5 : this.msg_data_5,
      CMsgMstField.ins_datetime : this.ins_datetime,
      CMsgMstField.upd_datetime : this.upd_datetime,
      CMsgMstField.status : this.status,
      CMsgMstField.send_flg : this.send_flg,
      CMsgMstField.upd_user : this.upd_user,
      CMsgMstField.upd_system : this.upd_system,
      CMsgMstField.msg_size_1 : this.msg_size_1,
      CMsgMstField.msg_size_2 : this.msg_size_2,
      CMsgMstField.msg_size_3 : this.msg_size_3,
      CMsgMstField.msg_size_4 : this.msg_size_4,
      CMsgMstField.msg_size_5 : this.msg_size_5,
      CMsgMstField.msg_color_1 : this.msg_color_1,
      CMsgMstField.msg_color_2 : this.msg_color_2,
      CMsgMstField.msg_color_3 : this.msg_color_3,
      CMsgMstField.msg_color_4 : this.msg_color_4,
      CMsgMstField.msg_color_5 : this.msg_color_5,
      CMsgMstField.back_color : this.back_color,
      CMsgMstField.back_pict_typ : this.back_pict_typ,
      CMsgMstField.second : this.second,
      CMsgMstField.flg_01 : this.flg_01,
      CMsgMstField.flg_02 : this.flg_02,
      CMsgMstField.flg_03 : this.flg_03,
      CMsgMstField.flg_04 : this.flg_04,
      CMsgMstField.flg_05 : this.flg_05,
      CMsgMstField.msg_data_6 : this.msg_data_6,
      CMsgMstField.msg_data_7 : this.msg_data_7,
      CMsgMstField.msg_data_8 : this.msg_data_8,
      CMsgMstField.msg_data_9 : this.msg_data_9,
      CMsgMstField.msg_data_10 : this.msg_data_10,
      CMsgMstField.msg_size_6 : this.msg_size_6,
      CMsgMstField.msg_size_7 : this.msg_size_7,
      CMsgMstField.msg_size_8 : this.msg_size_8,
      CMsgMstField.msg_size_9 : this.msg_size_9,
      CMsgMstField.msg_size_10 : this.msg_size_10,
      CMsgMstField.msg_color_6 : this.msg_color_6,
      CMsgMstField.msg_color_7 : this.msg_color_7,
      CMsgMstField.msg_color_8 : this.msg_color_8,
      CMsgMstField.msg_color_9 : this.msg_color_9,
      CMsgMstField.msg_color_10 : this.msg_color_10,
      CMsgMstField.flg_06 : this.flg_06,
      CMsgMstField.flg_07 : this.flg_07,
      CMsgMstField.flg_08 : this.flg_08,
      CMsgMstField.flg_09 : this.flg_09,
      CMsgMstField.flg_10 : this.flg_10,
    };
  }
}

/// 03_48 メッセージマスタ c_msg_mstのフィールド名設定用クラス
class CMsgMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const msg_cd = "msg_cd";
  static const msg_kind = "msg_kind";
  static const msg_data_1 = "msg_data_1";
  static const msg_data_2 = "msg_data_2";
  static const msg_data_3 = "msg_data_3";
  static const msg_data_4 = "msg_data_4";
  static const msg_data_5 = "msg_data_5";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
  static const msg_size_1 = "msg_size_1";
  static const msg_size_2 = "msg_size_2";
  static const msg_size_3 = "msg_size_3";
  static const msg_size_4 = "msg_size_4";
  static const msg_size_5 = "msg_size_5";
  static const msg_color_1 = "msg_color_1";
  static const msg_color_2 = "msg_color_2";
  static const msg_color_3 = "msg_color_3";
  static const msg_color_4 = "msg_color_4";
  static const msg_color_5 = "msg_color_5";
  static const back_color = "back_color";
  static const back_pict_typ = "back_pict_typ";
  static const second = "second";
  static const flg_01 = "flg_01";
  static const flg_02 = "flg_02";
  static const flg_03 = "flg_03";
  static const flg_04 = "flg_04";
  static const flg_05 = "flg_05";
  static const msg_data_6 = "msg_data_6";
  static const msg_data_7 = "msg_data_7";
  static const msg_data_8 = "msg_data_8";
  static const msg_data_9 = "msg_data_9";
  static const msg_data_10 = "msg_data_10";
  static const msg_size_6 = "msg_size_6";
  static const msg_size_7 = "msg_size_7";
  static const msg_size_8 = "msg_size_8";
  static const msg_size_9 = "msg_size_9";
  static const msg_size_10 = "msg_size_10";
  static const msg_color_6 = "msg_color_6";
  static const msg_color_7 = "msg_color_7";
  static const msg_color_8 = "msg_color_8";
  static const msg_color_9 = "msg_color_9";
  static const msg_color_10 = "msg_color_10";
  static const flg_06 = "flg_06";
  static const flg_07 = "flg_07";
  static const flg_08 = "flg_08";
  static const flg_09 = "flg_09";
  static const flg_10 = "flg_10";
}
//endregion
//region 03_49	メッセージレイアウトマスタ	c_msglayout_mst
/// 03_49 メッセージレイアウトマスタ  c_msglayout_mstクラス
class CMsglayoutMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? msggrp_cd;
  int msg_typ = 0;
  int msg_cd = 0;
  int target_typ = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_msglayout_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND msggrp_cd = ? AND msg_typ = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(msggrp_cd);
    rn.add(msg_typ);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMsglayoutMstColumns rn = CMsglayoutMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.msggrp_cd = maps[i]['msggrp_cd'];
      rn.msg_typ = maps[i]['msg_typ'];
      rn.msg_cd = maps[i]['msg_cd'];
      rn.target_typ = maps[i]['target_typ'];
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
    CMsglayoutMstColumns rn = CMsglayoutMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.msggrp_cd = maps[0]['msggrp_cd'];
    rn.msg_typ = maps[0]['msg_typ'];
    rn.msg_cd = maps[0]['msg_cd'];
    rn.target_typ = maps[0]['target_typ'];
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
      CMsglayoutMstField.comp_cd : this.comp_cd,
      CMsglayoutMstField.stre_cd : this.stre_cd,
      CMsglayoutMstField.msggrp_cd : this.msggrp_cd,
      CMsglayoutMstField.msg_typ : this.msg_typ,
      CMsglayoutMstField.msg_cd : this.msg_cd,
      CMsglayoutMstField.target_typ : this.target_typ,
      CMsglayoutMstField.ins_datetime : this.ins_datetime,
      CMsglayoutMstField.upd_datetime : this.upd_datetime,
      CMsglayoutMstField.status : this.status,
      CMsglayoutMstField.send_flg : this.send_flg,
      CMsglayoutMstField.upd_user : this.upd_user,
      CMsglayoutMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_49 メッセージレイアウトマスタ  c_msglayout_mstのフィールド名設定用クラス
class CMsglayoutMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const msggrp_cd = "msggrp_cd";
  static const msg_typ = "msg_typ";
  static const msg_cd = "msg_cd";
  static const target_typ = "target_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_50	メッセージスケジュールマスタ	c_msgsch_mst
/// 03_50 メッセージスケジュールマスタ c_msgsch_mstクラス
class CMsgschMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? msgsch_cd;
  String? name;
  String? short_name;
  String? start_datetime;
  String? end_datetime;
  int timesch_flg = 0;
  int sun_flg = 0;
  int mon_flg = 0;
  int tue_flg = 0;
  int wed_flg = 0;
  int thu_flg = 0;
  int fri_flg = 0;
  int sat_flg = 0;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_msgsch_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND msgsch_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(msgsch_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMsgschMstColumns rn = CMsgschMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.msgsch_cd = maps[i]['msgsch_cd'];
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
    CMsgschMstColumns rn = CMsgschMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.msgsch_cd = maps[0]['msgsch_cd'];
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
      CMsgschMstField.comp_cd : this.comp_cd,
      CMsgschMstField.stre_cd : this.stre_cd,
      CMsgschMstField.msgsch_cd : this.msgsch_cd,
      CMsgschMstField.name : this.name,
      CMsgschMstField.short_name : this.short_name,
      CMsgschMstField.start_datetime : this.start_datetime,
      CMsgschMstField.end_datetime : this.end_datetime,
      CMsgschMstField.timesch_flg : this.timesch_flg,
      CMsgschMstField.sun_flg : this.sun_flg,
      CMsgschMstField.mon_flg : this.mon_flg,
      CMsgschMstField.tue_flg : this.tue_flg,
      CMsgschMstField.wed_flg : this.wed_flg,
      CMsgschMstField.thu_flg : this.thu_flg,
      CMsgschMstField.fri_flg : this.fri_flg,
      CMsgschMstField.sat_flg : this.sat_flg,
      CMsgschMstField.stop_flg : this.stop_flg,
      CMsgschMstField.ins_datetime : this.ins_datetime,
      CMsgschMstField.upd_datetime : this.upd_datetime,
      CMsgschMstField.status : this.status,
      CMsgschMstField.send_flg : this.send_flg,
      CMsgschMstField.upd_user : this.upd_user,
      CMsgschMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_50 メッセージスケジュールマスタ c_msgsch_mstのフィールド名設定用クラス
class CMsgschMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const msgsch_cd = "msgsch_cd";
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
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_51	メッセージスケジュールレイアウトマスタ	c_msgsch_layout_mst
/// 03_51 メッセージスケジュールレイアウトマスタ  c_msgsch_layout_mstクラス
class CMsgschLayoutMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? msgsch_cd;
  int? msggrp_cd;
  int msg_typ = 0;
  int msg_cd = 0;
  int target_typ = 0;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_msgsch_layout_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND msgsch_cd = ? AND msggrp_cd = ? AND msg_typ = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(msgsch_cd);
    rn.add(msggrp_cd);
    rn.add(msg_typ);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMsgschLayoutMstColumns rn = CMsgschLayoutMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.msgsch_cd = maps[i]['msgsch_cd'];
      rn.msggrp_cd = maps[i]['msggrp_cd'];
      rn.msg_typ = maps[i]['msg_typ'];
      rn.msg_cd = maps[i]['msg_cd'];
      rn.target_typ = maps[i]['target_typ'];
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
    CMsgschLayoutMstColumns rn = CMsgschLayoutMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.msgsch_cd = maps[0]['msgsch_cd'];
    rn.msggrp_cd = maps[0]['msggrp_cd'];
    rn.msg_typ = maps[0]['msg_typ'];
    rn.msg_cd = maps[0]['msg_cd'];
    rn.target_typ = maps[0]['target_typ'];
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
      CMsgschLayoutMstField.comp_cd : this.comp_cd,
      CMsgschLayoutMstField.stre_cd : this.stre_cd,
      CMsgschLayoutMstField.msgsch_cd : this.msgsch_cd,
      CMsgschLayoutMstField.msggrp_cd : this.msggrp_cd,
      CMsgschLayoutMstField.msg_typ : this.msg_typ,
      CMsgschLayoutMstField.msg_cd : this.msg_cd,
      CMsgschLayoutMstField.target_typ : this.target_typ,
      CMsgschLayoutMstField.stop_flg : this.stop_flg,
      CMsgschLayoutMstField.ins_datetime : this.ins_datetime,
      CMsgschLayoutMstField.upd_datetime : this.upd_datetime,
      CMsgschLayoutMstField.status : this.status,
      CMsgschLayoutMstField.send_flg : this.send_flg,
      CMsgschLayoutMstField.upd_user : this.upd_user,
      CMsgschLayoutMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_51 メッセージスケジュールレイアウトマスタ  c_msgsch_layout_mstのフィールド名設定用クラス
class CMsgschLayoutMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const msgsch_cd = "msgsch_cd";
  static const msggrp_cd = "msggrp_cd";
  static const msg_typ = "msg_typ";
  static const msg_cd = "msg_cd";
  static const target_typ = "target_typ";
  static const stop_flg = "stop_flg";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_52	ターミナルチェックマスタ	c_trm_chk_mst
/// 03_52 ターミナルチェックマスタ c_trm_chk_mstクラス
class CTrmChkMstColumns extends TableColumns{
  int? trm_chk_grp_cd;
  int? trm_cd;
  double? trm_data = 0;
  int trm_chk_eq_flg = 0;

  @override
  String _getTableName() => "c_trm_chk_mst";

  @override
  String? _getKeyCondition() => 'trm_chk_grp_cd = ? AND trm_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(trm_chk_grp_cd);
    rn.add(trm_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTrmChkMstColumns rn = CTrmChkMstColumns();
      rn.trm_chk_grp_cd = maps[i]['trm_chk_grp_cd'];
      rn.trm_cd = maps[i]['trm_cd'];
      rn.trm_data = maps[i]['trm_data'];
      rn.trm_chk_eq_flg = maps[i]['trm_chk_eq_flg'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CTrmChkMstColumns rn = CTrmChkMstColumns();
    rn.trm_chk_grp_cd = maps[0]['trm_chk_grp_cd'];
    rn.trm_cd = maps[0]['trm_cd'];
    rn.trm_data = maps[0]['trm_data'];
    rn.trm_chk_eq_flg = maps[0]['trm_chk_eq_flg'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CTrmChkMstField.trm_chk_grp_cd : this.trm_chk_grp_cd,
      CTrmChkMstField.trm_cd : this.trm_cd,
      CTrmChkMstField.trm_data : this.trm_data,
      CTrmChkMstField.trm_chk_eq_flg : this.trm_chk_eq_flg,
    };
  }
}

/// 03_52 ターミナルチェックマスタ c_trm_chk_mstのフィールド名設定用クラス
class CTrmChkMstField {
  static const trm_chk_grp_cd = "trm_chk_grp_cd";
  static const trm_cd = "trm_cd";
  static const trm_data = "trm_data";
  static const trm_chk_eq_flg = "trm_chk_eq_flg";
}
//endregion
//region 03_53	帳票印字条件マスタ	c_report_cond_mst
/// 03_53 帳票印字条件マスタ  c_report_cond_mstクラス
class CReportCondMstColumns extends TableColumns{
  int? code;
  int? menu_kind;
  int? sub_menu_kind;
  int? btn_stp;
  int btn_grp = 0;
  int attr_cd = 0;

  @override
  String _getTableName() => "c_report_cond_mst";

  @override
  String? _getKeyCondition() => 'code = ? AND menu_kind = ? AND sub_menu_kind = ? AND btn_stp = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(code);
    rn.add(menu_kind);
    rn.add(sub_menu_kind);
    rn.add(btn_stp);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReportCondMstColumns rn = CReportCondMstColumns();
      rn.code = maps[i]['code'];
      rn.menu_kind = maps[i]['menu_kind'];
      rn.sub_menu_kind = maps[i]['sub_menu_kind'];
      rn.btn_stp = maps[i]['btn_stp'];
      rn.btn_grp = maps[i]['btn_grp'];
      rn.attr_cd = maps[i]['attr_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReportCondMstColumns rn = CReportCondMstColumns();
    rn.code = maps[0]['code'];
    rn.menu_kind = maps[0]['menu_kind'];
    rn.sub_menu_kind = maps[0]['sub_menu_kind'];
    rn.btn_stp = maps[0]['btn_stp'];
    rn.btn_grp = maps[0]['btn_grp'];
    rn.attr_cd = maps[0]['attr_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReportCondMstField.code : this.code,
      CReportCondMstField.menu_kind : this.menu_kind,
      CReportCondMstField.sub_menu_kind : this.sub_menu_kind,
      CReportCondMstField.btn_stp : this.btn_stp,
      CReportCondMstField.btn_grp : this.btn_grp,
      CReportCondMstField.attr_cd : this.attr_cd,
    };
  }
}

/// 03_53 帳票印字条件マスタ  c_report_cond_mstのフィールド名設定用クラス
class CReportCondMstField {
  static const code = "code";
  static const menu_kind = "menu_kind";
  static const sub_menu_kind = "sub_menu_kind";
  static const btn_stp = "btn_stp";
  static const btn_grp = "btn_grp";
  static const attr_cd = "attr_cd";
}
//endregion
//region 03_54	帳票属性マスタ	c_report_attr_mst
/// 03_54 帳票属性マスタ  c_report_attr_mstクラス
class CReportAttrMstColumns extends TableColumns{
  int? attr_cd;
  int attr_sub_cd = 0;
  int attr_typ = 0;
  String? start_data;
  String? end_data;
  int digits = 0;
  int img_cd = 0;
  int repo_sql_cd = 0;

  @override
  String _getTableName() => "c_report_attr_mst";

  @override
  String? _getKeyCondition() => 'attr_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(attr_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReportAttrMstColumns rn = CReportAttrMstColumns();
      rn.attr_cd = maps[i]['attr_cd'];
      rn.attr_sub_cd = maps[i]['attr_sub_cd'];
      rn.attr_typ = maps[i]['attr_typ'];
      rn.start_data = maps[i]['start_data'];
      rn.end_data = maps[i]['end_data'];
      rn.digits = maps[i]['digits'];
      rn.img_cd = maps[i]['img_cd'];
      rn.repo_sql_cd = maps[i]['repo_sql_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReportAttrMstColumns rn = CReportAttrMstColumns();
    rn.attr_cd = maps[0]['attr_cd'];
    rn.attr_sub_cd = maps[0]['attr_sub_cd'];
    rn.attr_typ = maps[0]['attr_typ'];
    rn.start_data = maps[0]['start_data'];
    rn.end_data = maps[0]['end_data'];
    rn.digits = maps[0]['digits'];
    rn.img_cd = maps[0]['img_cd'];
    rn.repo_sql_cd = maps[0]['repo_sql_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReportAttrMstField.attr_cd : this.attr_cd,
      CReportAttrMstField.attr_sub_cd : this.attr_sub_cd,
      CReportAttrMstField.attr_typ : this.attr_typ,
      CReportAttrMstField.start_data : this.start_data,
      CReportAttrMstField.end_data : this.end_data,
      CReportAttrMstField.digits : this.digits,
      CReportAttrMstField.img_cd : this.img_cd,
      CReportAttrMstField.repo_sql_cd : this.repo_sql_cd,
    };
  }
}

/// 03_54 帳票属性マスタ  c_report_attr_mstのフィールド名設定用クラス
class CReportAttrMstField {
  static const attr_cd = "attr_cd";
  static const attr_sub_cd = "attr_sub_cd";
  static const attr_typ = "attr_typ";
  static const start_data = "start_data";
  static const end_data = "end_data";
  static const digits = "digits";
  static const img_cd = "img_cd";
  static const repo_sql_cd = "repo_sql_cd";
}
//endregion
//region 03_55	帳票属性サブマスタ	c_report_attr_sub_mst
/// 03_55 帳票属性サブマスタ  c_report_attr_sub_mstクラス
class CReportAttrSubMstColumns extends TableColumns{
  int? attr_sub_cd;
  int? attr_sub_ordr;
  int? img_cd = 0;
  int? repo_sql_cd = 0;

  @override
  String _getTableName() => "c_report_attr_sub_mst";

  @override
  String? _getKeyCondition() => 'attr_sub_cd = ? AND attr_sub_ordr = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(attr_sub_cd);
    rn.add(attr_sub_ordr);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReportAttrSubMstColumns rn = CReportAttrSubMstColumns();
      rn.attr_sub_cd = maps[i]['attr_sub_cd'];
      rn.attr_sub_ordr = maps[i]['attr_sub_ordr'];
      rn.img_cd = maps[i]['img_cd'];
      rn.repo_sql_cd = maps[i]['repo_sql_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReportAttrSubMstColumns rn = CReportAttrSubMstColumns();
    rn.attr_sub_cd = maps[0]['attr_sub_cd'];
    rn.attr_sub_ordr = maps[0]['attr_sub_ordr'];
    rn.img_cd = maps[0]['img_cd'];
    rn.repo_sql_cd = maps[0]['repo_sql_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReportAttrSubMstField.attr_sub_cd : this.attr_sub_cd,
      CReportAttrSubMstField.attr_sub_ordr : this.attr_sub_ordr,
      CReportAttrSubMstField.img_cd : this.img_cd,
      CReportAttrSubMstField.repo_sql_cd : this.repo_sql_cd,
    };
  }
}

/// 03_55 帳票属性サブマスタ  c_report_attr_sub_mstのフィールド名設定用クラス
class CReportAttrSubMstField {
  static const attr_sub_cd = "attr_sub_cd";
  static const attr_sub_ordr = "attr_sub_ordr";
  static const img_cd = "img_cd";
  static const repo_sql_cd = "repo_sql_cd";
}
//endregion
//region 03_56	帳票SQLマスタ	c_report_sql_mst
/// 03_56 帳票SQLマスタ c_report_sql_mstクラス
class CReportSqlMstColumns extends TableColumns{
  int? repo_sql_cd;
  int? repo_sql_typ;
  String? cond_sql;
  int? cnct_sql1;
  String? cond_sql1;
  int? cnct_sql2;
  String? cond_sql2;

  @override
  String _getTableName() => "c_report_sql_mst";

  @override
  String? _getKeyCondition() => 'repo_sql_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(repo_sql_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CReportSqlMstColumns rn = CReportSqlMstColumns();
      rn.repo_sql_cd = maps[i]['repo_sql_cd'];
      rn.repo_sql_typ = maps[i]['repo_sql_typ'];
      rn.cond_sql = maps[i]['cond_sql'];
      rn.cnct_sql1 = maps[i]['cnct_sql1'];
      rn.cond_sql1 = maps[i]['cond_sql1'];
      rn.cnct_sql2 = maps[i]['cnct_sql2'];
      rn.cond_sql2 = maps[i]['cond_sql2'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CReportSqlMstColumns rn = CReportSqlMstColumns();
    rn.repo_sql_cd = maps[0]['repo_sql_cd'];
    rn.repo_sql_typ = maps[0]['repo_sql_typ'];
    rn.cond_sql = maps[0]['cond_sql'];
    rn.cnct_sql1 = maps[0]['cnct_sql1'];
    rn.cond_sql1 = maps[0]['cond_sql1'];
    rn.cnct_sql2 = maps[0]['cnct_sql2'];
    rn.cond_sql2 = maps[0]['cond_sql2'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CReportSqlMstField.repo_sql_cd : this.repo_sql_cd,
      CReportSqlMstField.repo_sql_typ : this.repo_sql_typ,
      CReportSqlMstField.cond_sql : this.cond_sql,
      CReportSqlMstField.cnct_sql1 : this.cnct_sql1,
      CReportSqlMstField.cond_sql1 : this.cond_sql1,
      CReportSqlMstField.cnct_sql2 : this.cnct_sql2,
      CReportSqlMstField.cond_sql2 : this.cond_sql2,
    };
  }
}

/// 03_56 帳票SQLマスタ c_report_sql_mstのフィールド名設定用クラス
class CReportSqlMstField {
  static const repo_sql_cd = "repo_sql_cd";
  static const repo_sql_typ = "repo_sql_typ";
  static const cond_sql = "cond_sql";
  static const cnct_sql1 = "cnct_sql1";
  static const cond_sql1 = "cond_sql1";
  static const cnct_sql2 = "cnct_sql2";
  static const cond_sql2 = "cond_sql2";
}
//endregion
//region 03_57	件数確認マスタ	c_tcount_mst
/// 03_57 件数確認マスタ  c_tcount_mstクラス
class CTcountMstColumns extends TableColumns{
  int? tcount_cd;
  String? set_tbl_name;
  int set_tbl_typ = 0;
  String? file_dir;
  int dat_div = 0;
  int recog_grp_cd = 0;

  @override
  String _getTableName() => "c_tcount_mst";

  @override
  String? _getKeyCondition() => 'tcount_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(tcount_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CTcountMstColumns rn = CTcountMstColumns();
      rn.tcount_cd = maps[i]['tcount_cd'];
      rn.set_tbl_name = maps[i]['set_tbl_name'];
      rn.set_tbl_typ = maps[i]['set_tbl_typ'];
      rn.file_dir = maps[i]['file_dir'];
      rn.dat_div = maps[i]['dat_div'];
      rn.recog_grp_cd = maps[i]['recog_grp_cd'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CTcountMstColumns rn = CTcountMstColumns();
    rn.tcount_cd = maps[0]['tcount_cd'];
    rn.set_tbl_name = maps[0]['set_tbl_name'];
    rn.set_tbl_typ = maps[0]['set_tbl_typ'];
    rn.file_dir = maps[0]['file_dir'];
    rn.dat_div = maps[0]['dat_div'];
    rn.recog_grp_cd = maps[0]['recog_grp_cd'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CTcountMstField.tcount_cd : this.tcount_cd,
      CTcountMstField.set_tbl_name : this.set_tbl_name,
      CTcountMstField.set_tbl_typ : this.set_tbl_typ,
      CTcountMstField.file_dir : this.file_dir,
      CTcountMstField.dat_div : this.dat_div,
      CTcountMstField.recog_grp_cd : this.recog_grp_cd,
    };
  }
}

/// 03_57 件数確認マスタ  c_tcount_mstのフィールド名設定用クラス
class CTcountMstField {
  static const tcount_cd = "tcount_cd";
  static const set_tbl_name = "set_tbl_name";
  static const set_tbl_typ = "set_tbl_typ";
  static const file_dir = "file_dir";
  static const dat_div = "dat_div";
  static const recog_grp_cd = "recog_grp_cd";
}
//endregion
//region 03_58	自動開閉店マスタ	c_stropncls_mst
/// 03_58 自動開閉店マスタ c_stropncls_mstクラス
class CStropnclsMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? stropncls_grp;
  int? stropncls_cd;
  double? stropncls_data = 0;
  int data_typ = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_stropncls_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND stropncls_grp = ? AND stropncls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(stropncls_grp);
    rn.add(stropncls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStropnclsMstColumns rn = CStropnclsMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.stropncls_grp = maps[i]['stropncls_grp'];
      rn.stropncls_cd = maps[i]['stropncls_cd'];
      rn.stropncls_data = maps[i]['stropncls_data'];
      rn.data_typ = maps[i]['data_typ'];
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
    CStropnclsMstColumns rn = CStropnclsMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.stropncls_grp = maps[0]['stropncls_grp'];
    rn.stropncls_cd = maps[0]['stropncls_cd'];
    rn.stropncls_data = maps[0]['stropncls_data'];
    rn.data_typ = maps[0]['data_typ'];
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
      CStropnclsMstField.comp_cd : this.comp_cd,
      CStropnclsMstField.stre_cd : this.stre_cd,
      CStropnclsMstField.stropncls_grp : this.stropncls_grp,
      CStropnclsMstField.stropncls_cd : this.stropncls_cd,
      CStropnclsMstField.stropncls_data : this.stropncls_data,
      CStropnclsMstField.data_typ : this.data_typ,
      CStropnclsMstField.ins_datetime : this.ins_datetime,
      CStropnclsMstField.upd_datetime : this.upd_datetime,
      CStropnclsMstField.status : this.status,
      CStropnclsMstField.send_flg : this.send_flg,
      CStropnclsMstField.upd_user : this.upd_user,
      CStropnclsMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_58 自動開閉店マスタ c_stropncls_mstのフィールド名設定用クラス
class CStropnclsMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const stropncls_grp = "stropncls_grp";
  static const stropncls_cd = "stropncls_cd";
  static const stropncls_data = "stropncls_data";
  static const data_typ = "data_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_59	自動開閉店設定マスタ	c_stropncls_set_mst
/// 03_59 自動開閉店設定マスタ c_stropncls_set_mstクラス
class CStropnclsSetMstColumns extends TableColumns{
  int? stropncls_cd;
  String? stropncls_name;
  int stropncls_dsp_cond = 0;
  int stropncls_inp_cond = 0;
  double? stropncls_limit_max = 0;
  double? stropncls_limit_min = 0;
  int stropncls_digits = 0;
  int stropncls_zero_typ = 0;
  int stropncls_btn_color = 0;
  String? stropncls_info_comment;
  int stropncls_info_pic = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_stropncls_set_mst";

  @override
  String? _getKeyCondition() => 'stropncls_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(stropncls_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStropnclsSetMstColumns rn = CStropnclsSetMstColumns();
      rn.stropncls_cd = maps[i]['stropncls_cd'];
      rn.stropncls_name = maps[i]['stropncls_name'];
      rn.stropncls_dsp_cond = maps[i]['stropncls_dsp_cond'];
      rn.stropncls_inp_cond = maps[i]['stropncls_inp_cond'];
      rn.stropncls_limit_max = maps[i]['stropncls_limit_max'];
      rn.stropncls_limit_min = maps[i]['stropncls_limit_min'];
      rn.stropncls_digits = maps[i]['stropncls_digits'];
      rn.stropncls_zero_typ = maps[i]['stropncls_zero_typ'];
      rn.stropncls_btn_color = maps[i]['stropncls_btn_color'];
      rn.stropncls_info_comment = maps[i]['stropncls_info_comment'];
      rn.stropncls_info_pic = maps[i]['stropncls_info_pic'];
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
    CStropnclsSetMstColumns rn = CStropnclsSetMstColumns();
    rn.stropncls_cd = maps[0]['stropncls_cd'];
    rn.stropncls_name = maps[0]['stropncls_name'];
    rn.stropncls_dsp_cond = maps[0]['stropncls_dsp_cond'];
    rn.stropncls_inp_cond = maps[0]['stropncls_inp_cond'];
    rn.stropncls_limit_max = maps[0]['stropncls_limit_max'];
    rn.stropncls_limit_min = maps[0]['stropncls_limit_min'];
    rn.stropncls_digits = maps[0]['stropncls_digits'];
    rn.stropncls_zero_typ = maps[0]['stropncls_zero_typ'];
    rn.stropncls_btn_color = maps[0]['stropncls_btn_color'];
    rn.stropncls_info_comment = maps[0]['stropncls_info_comment'];
    rn.stropncls_info_pic = maps[0]['stropncls_info_pic'];
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
      CStropnclsSetMstField.stropncls_cd : this.stropncls_cd,
      CStropnclsSetMstField.stropncls_name : this.stropncls_name,
      CStropnclsSetMstField.stropncls_dsp_cond : this.stropncls_dsp_cond,
      CStropnclsSetMstField.stropncls_inp_cond : this.stropncls_inp_cond,
      CStropnclsSetMstField.stropncls_limit_max : this.stropncls_limit_max,
      CStropnclsSetMstField.stropncls_limit_min : this.stropncls_limit_min,
      CStropnclsSetMstField.stropncls_digits : this.stropncls_digits,
      CStropnclsSetMstField.stropncls_zero_typ : this.stropncls_zero_typ,
      CStropnclsSetMstField.stropncls_btn_color : this.stropncls_btn_color,
      CStropnclsSetMstField.stropncls_info_comment : this.stropncls_info_comment,
      CStropnclsSetMstField.stropncls_info_pic : this.stropncls_info_pic,
      CStropnclsSetMstField.ins_datetime : this.ins_datetime,
      CStropnclsSetMstField.upd_datetime : this.upd_datetime,
      CStropnclsSetMstField.status : this.status,
      CStropnclsSetMstField.send_flg : this.send_flg,
      CStropnclsSetMstField.upd_user : this.upd_user,
      CStropnclsSetMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_59 自動開閉店設定マスタ c_stropncls_set_mstのフィールド名設定用クラス
class CStropnclsSetMstField {
  static const stropncls_cd = "stropncls_cd";
  static const stropncls_name = "stropncls_name";
  static const stropncls_dsp_cond = "stropncls_dsp_cond";
  static const stropncls_inp_cond = "stropncls_inp_cond";
  static const stropncls_limit_max = "stropncls_limit_max";
  static const stropncls_limit_min = "stropncls_limit_min";
  static const stropncls_digits = "stropncls_digits";
  static const stropncls_zero_typ = "stropncls_zero_typ";
  static const stropncls_btn_color = "stropncls_btn_color";
  static const stropncls_info_comment = "stropncls_info_comment";
  static const stropncls_info_pic = "stropncls_info_pic";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_60	自動開閉店サブマスタ	c_stropncls_sub_mst
/// 03_60 自動開閉店サブマスタ c_stropncls_sub_mstクラス
class CStropnclsSubMstColumns extends TableColumns{
  int? stropncls_cd;
  int? stropncls_ordr;
  double? stropncls_data = 0;
  int img_cd = 0;
  String? stropncls_comment;
  int stropncls_btn_color = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_stropncls_sub_mst";

  @override
  String? _getKeyCondition() => 'stropncls_cd = ? AND stropncls_ordr = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(stropncls_cd);
    rn.add(stropncls_ordr);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CStropnclsSubMstColumns rn = CStropnclsSubMstColumns();
      rn.stropncls_cd = maps[i]['stropncls_cd'];
      rn.stropncls_ordr = maps[i]['stropncls_ordr'];
      rn.stropncls_data = maps[i]['stropncls_data'];
      rn.img_cd = maps[i]['img_cd'];
      rn.stropncls_comment = maps[i]['stropncls_comment'];
      rn.stropncls_btn_color = maps[i]['stropncls_btn_color'];
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
    CStropnclsSubMstColumns rn = CStropnclsSubMstColumns();
    rn.stropncls_cd = maps[0]['stropncls_cd'];
    rn.stropncls_ordr = maps[0]['stropncls_ordr'];
    rn.stropncls_data = maps[0]['stropncls_data'];
    rn.img_cd = maps[0]['img_cd'];
    rn.stropncls_comment = maps[0]['stropncls_comment'];
    rn.stropncls_btn_color = maps[0]['stropncls_btn_color'];
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
      CStropnclsSubMstField.stropncls_cd : this.stropncls_cd,
      CStropnclsSubMstField.stropncls_ordr : this.stropncls_ordr,
      CStropnclsSubMstField.stropncls_data : this.stropncls_data,
      CStropnclsSubMstField.img_cd : this.img_cd,
      CStropnclsSubMstField.stropncls_comment : this.stropncls_comment,
      CStropnclsSubMstField.stropncls_btn_color : this.stropncls_btn_color,
      CStropnclsSubMstField.ins_datetime : this.ins_datetime,
      CStropnclsSubMstField.upd_datetime : this.upd_datetime,
      CStropnclsSubMstField.status : this.status,
      CStropnclsSubMstField.send_flg : this.send_flg,
      CStropnclsSubMstField.upd_user : this.upd_user,
      CStropnclsSubMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_60 自動開閉店サブマスタ c_stropncls_sub_mstのフィールド名設定用クラス
class CStropnclsSubMstField {
  static const stropncls_cd = "stropncls_cd";
  static const stropncls_ordr = "stropncls_ordr";
  static const stropncls_data = "stropncls_data";
  static const img_cd = "img_cd";
  static const stropncls_comment = "stropncls_comment";
  static const stropncls_btn_color = "stropncls_btn_color";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_61	キャッシュリサイクルマスタ	c_cashrecycle_mst
/// 03_61 キャッシュリサイクルマスタ  c_cashrecycle_mstクラス
class CCashrecycleMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? cashrecycle_grp;
  int? code;
  double? data = 0;
  int data_typ = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_cashrecycle_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND cashrecycle_grp = ? AND code = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(cashrecycle_grp);
    rn.add(code);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCashrecycleMstColumns rn = CCashrecycleMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.cashrecycle_grp = maps[i]['cashrecycle_grp'];
      rn.code = maps[i]['code'];
      rn.data = maps[i]['data'];
      rn.data_typ = maps[i]['data_typ'];
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
    CCashrecycleMstColumns rn = CCashrecycleMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.cashrecycle_grp = maps[0]['cashrecycle_grp'];
    rn.code = maps[0]['code'];
    rn.data = maps[0]['data'];
    rn.data_typ = maps[0]['data_typ'];
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
      CCashrecycleMstField.comp_cd : this.comp_cd,
      CCashrecycleMstField.stre_cd : this.stre_cd,
      CCashrecycleMstField.cashrecycle_grp : this.cashrecycle_grp,
      CCashrecycleMstField.code : this.code,
      CCashrecycleMstField.data : this.data,
      CCashrecycleMstField.data_typ : this.data_typ,
      CCashrecycleMstField.ins_datetime : this.ins_datetime,
      CCashrecycleMstField.upd_datetime : this.upd_datetime,
      CCashrecycleMstField.status : this.status,
      CCashrecycleMstField.send_flg : this.send_flg,
      CCashrecycleMstField.upd_user : this.upd_user,
      CCashrecycleMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_61 キャッシュリサイクルマスタ  c_cashrecycle_mstのフィールド名設定用クラス
class CCashrecycleMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const cashrecycle_grp = "cashrecycle_grp";
  static const code = "code";
  static const data = "data";
  static const data_typ = "data_typ";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_62	キャッシュリサイクル設定マスタ	c_cashrecycle_set_mst
/// 03_62 キャッシュリサイクル設定マスタ  c_cashrecycle_set_mstクラス
class CCashrecycleSetMstColumns extends TableColumns{
  int? code;
  String? set_name;
  int dsp_cond = 0;
  int inp_cond = 0;
  double? limit_max = 0;
  double? limit_min = 0;
  int digits = 0;
  int zero_typ = 0;
  int btn_color = 0;
  String? info_comment;
  int info_pic = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_cashrecycle_set_mst";

  @override
  String? _getKeyCondition() => 'code = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(code);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCashrecycleSetMstColumns rn = CCashrecycleSetMstColumns();
      rn.code = maps[i]['code'];
      rn.set_name = maps[i]['set_name'];
      rn.dsp_cond = maps[i]['dsp_cond'];
      rn.inp_cond = maps[i]['inp_cond'];
      rn.limit_max = maps[i]['limit_max'];
      rn.limit_min = maps[i]['limit_min'];
      rn.digits = maps[i]['digits'];
      rn.zero_typ = maps[i]['zero_typ'];
      rn.btn_color = maps[i]['btn_color'];
      rn.info_comment = maps[i]['info_comment'];
      rn.info_pic = maps[i]['info_pic'];
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
    CCashrecycleSetMstColumns rn = CCashrecycleSetMstColumns();
    rn.code = maps[0]['code'];
    rn.set_name = maps[0]['set_name'];
    rn.dsp_cond = maps[0]['dsp_cond'];
    rn.inp_cond = maps[0]['inp_cond'];
    rn.limit_max = maps[0]['limit_max'];
    rn.limit_min = maps[0]['limit_min'];
    rn.digits = maps[0]['digits'];
    rn.zero_typ = maps[0]['zero_typ'];
    rn.btn_color = maps[0]['btn_color'];
    rn.info_comment = maps[0]['info_comment'];
    rn.info_pic = maps[0]['info_pic'];
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
      CCashrecycleSetMstField.code : this.code,
      CCashrecycleSetMstField.set_name : this.set_name,
      CCashrecycleSetMstField.dsp_cond : this.dsp_cond,
      CCashrecycleSetMstField.inp_cond : this.inp_cond,
      CCashrecycleSetMstField.limit_max : this.limit_max,
      CCashrecycleSetMstField.limit_min : this.limit_min,
      CCashrecycleSetMstField.digits : this.digits,
      CCashrecycleSetMstField.zero_typ : this.zero_typ,
      CCashrecycleSetMstField.btn_color : this.btn_color,
      CCashrecycleSetMstField.info_comment : this.info_comment,
      CCashrecycleSetMstField.info_pic : this.info_pic,
      CCashrecycleSetMstField.ins_datetime : this.ins_datetime,
      CCashrecycleSetMstField.upd_datetime : this.upd_datetime,
      CCashrecycleSetMstField.status : this.status,
      CCashrecycleSetMstField.send_flg : this.send_flg,
      CCashrecycleSetMstField.upd_user : this.upd_user,
      CCashrecycleSetMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_62 キャッシュリサイクル設定マスタ  c_cashrecycle_set_mstのフィールド名設定用クラス
class CCashrecycleSetMstField {
  static const code = "code";
  static const set_name = "set_name";
  static const dsp_cond = "dsp_cond";
  static const inp_cond = "inp_cond";
  static const limit_max = "limit_max";
  static const limit_min = "limit_min";
  static const digits = "digits";
  static const zero_typ = "zero_typ";
  static const btn_color = "btn_color";
  static const info_comment = "info_comment";
  static const info_pic = "info_pic";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_63	キャッシュリサイクルサブマスタ	c_cashrecycle_sub_mst
/// 03_63 キャッシュリサイクルサブマスタ  c_cashrecycle_sub_mstクラス
class CCashrecycleSubMstColumns extends TableColumns{
  int? code;
  int? ordr;
  double? data = 0;
  int img_cd = 0;
  String? comment;
  int btn_color = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_cashrecycle_sub_mst";

  @override
  String? _getKeyCondition() => 'code = ? AND ordr = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(code);
    rn.add(ordr);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CCashrecycleSubMstColumns rn = CCashrecycleSubMstColumns();
      rn.code = maps[i]['code'];
      rn.ordr = maps[i]['ordr'];
      rn.data = maps[i]['data'];
      rn.img_cd = maps[i]['img_cd'];
      rn.comment = maps[i]['comment'];
      rn.btn_color = maps[i]['btn_color'];
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
    CCashrecycleSubMstColumns rn = CCashrecycleSubMstColumns();
    rn.code = maps[0]['code'];
    rn.ordr = maps[0]['ordr'];
    rn.data = maps[0]['data'];
    rn.img_cd = maps[0]['img_cd'];
    rn.comment = maps[0]['comment'];
    rn.btn_color = maps[0]['btn_color'];
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
      CCashrecycleSubMstField.code : this.code,
      CCashrecycleSubMstField.ordr : this.ordr,
      CCashrecycleSubMstField.data : this.data,
      CCashrecycleSubMstField.img_cd : this.img_cd,
      CCashrecycleSubMstField.comment : this.comment,
      CCashrecycleSubMstField.btn_color : this.btn_color,
      CCashrecycleSubMstField.ins_datetime : this.ins_datetime,
      CCashrecycleSubMstField.upd_datetime : this.upd_datetime,
      CCashrecycleSubMstField.status : this.status,
      CCashrecycleSubMstField.send_flg : this.send_flg,
      CCashrecycleSubMstField.upd_user : this.upd_user,
      CCashrecycleSubMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_63 キャッシュリサイクルサブマスタ  c_cashrecycle_sub_mstのフィールド名設定用クラス
class CCashrecycleSubMstField {
  static const code = "code";
  static const ordr = "ordr";
  static const data = "data";
  static const img_cd = "img_cd";
  static const comment = "comment";
  static const btn_color = "btn_color";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_64	キャッシュリサイクル管理マスタ	c_cashrecycle_info_mst
/// 03_64 キャッシュリサイクル管理マスタ  c_cashrecycle_info_mstクラス
class CCashrecycleInfoMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? mac_no;
  int cashrecycle_grp = 1;
  int cal_grp_cd = 0;
  int server = 0;
  int server_macno = 0;
  String? server_info;
  int sub_server = 0;
  int sub_server_macno = 0;
  String? sub_server_info;
  int first_disp_macno1 = 0;
  int first_disp_macno2 = 0;
  int first_disp_macno3 = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_cashrecycle_info_mst";

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
      CCashrecycleInfoMstColumns rn = CCashrecycleInfoMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.mac_no = maps[i]['mac_no'];
      rn.cashrecycle_grp = maps[i]['cashrecycle_grp'];
      rn.cal_grp_cd = maps[i]['cal_grp_cd'];
      rn.server = maps[i]['server'];
      rn.server_macno = maps[i]['server_macno'];
      rn.server_info = maps[i]['server_info'];
      rn.sub_server = maps[i]['sub_server'];
      rn.sub_server_macno = maps[i]['sub_server_macno'];
      rn.sub_server_info = maps[i]['sub_server_info'];
      rn.first_disp_macno1 = maps[i]['first_disp_macno1'];
      rn.first_disp_macno2 = maps[i]['first_disp_macno2'];
      rn.first_disp_macno3 = maps[i]['first_disp_macno3'];
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
    CCashrecycleInfoMstColumns rn = CCashrecycleInfoMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.mac_no = maps[0]['mac_no'];
    rn.cashrecycle_grp = maps[0]['cashrecycle_grp'];
    rn.cal_grp_cd = maps[0]['cal_grp_cd'];
    rn.server = maps[0]['server'];
    rn.server_macno = maps[0]['server_macno'];
    rn.server_info = maps[0]['server_info'];
    rn.sub_server = maps[0]['sub_server'];
    rn.sub_server_macno = maps[0]['sub_server_macno'];
    rn.sub_server_info = maps[0]['sub_server_info'];
    rn.first_disp_macno1 = maps[0]['first_disp_macno1'];
    rn.first_disp_macno2 = maps[0]['first_disp_macno2'];
    rn.first_disp_macno3 = maps[0]['first_disp_macno3'];
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
      CCashrecycleInfoMstField.comp_cd : this.comp_cd,
      CCashrecycleInfoMstField.stre_cd : this.stre_cd,
      CCashrecycleInfoMstField.mac_no : this.mac_no,
      CCashrecycleInfoMstField.cashrecycle_grp : this.cashrecycle_grp,
      CCashrecycleInfoMstField.cal_grp_cd : this.cal_grp_cd,
      CCashrecycleInfoMstField.server : this.server,
      CCashrecycleInfoMstField.server_macno : this.server_macno,
      CCashrecycleInfoMstField.server_info : this.server_info,
      CCashrecycleInfoMstField.sub_server : this.sub_server,
      CCashrecycleInfoMstField.sub_server_macno : this.sub_server_macno,
      CCashrecycleInfoMstField.sub_server_info : this.sub_server_info,
      CCashrecycleInfoMstField.first_disp_macno1 : this.first_disp_macno1,
      CCashrecycleInfoMstField.first_disp_macno2 : this.first_disp_macno2,
      CCashrecycleInfoMstField.first_disp_macno3 : this.first_disp_macno3,
      CCashrecycleInfoMstField.ins_datetime : this.ins_datetime,
      CCashrecycleInfoMstField.upd_datetime : this.upd_datetime,
      CCashrecycleInfoMstField.status : this.status,
      CCashrecycleInfoMstField.send_flg : this.send_flg,
      CCashrecycleInfoMstField.upd_user : this.upd_user,
      CCashrecycleInfoMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_64 キャッシュリサイクル管理マスタ  c_cashrecycle_info_mstのフィールド名設定用クラス
class CCashrecycleInfoMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const mac_no = "mac_no";
  static const cashrecycle_grp = "cashrecycle_grp";
  static const cal_grp_cd = "cal_grp_cd";
  static const server = "server";
  static const server_macno = "server_macno";
  static const server_info = "server_info";
  static const sub_server = "sub_server";
  static const sub_server_macno = "sub_server_macno";
  static const sub_server_info = "sub_server_info";
  static const first_disp_macno1 = "first_disp_macno1";
  static const first_disp_macno2 = "first_disp_macno2";
  static const first_disp_macno3 = "first_disp_macno3";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_65	メッセージレイアウト設定マスタ	c_msglayout_set_mst
/// 03_65 メッセージレイアウト設定マスタ  c_msglayout_set_mstクラス
class CMsglayoutSetMstColumns extends TableColumns{
  int? msg_set_kind;
  int msg_data = 0;
  String? msg_name;
  int msg_dsp_cond = 0;
  int msg_target_dsp_cond = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_msglayout_set_mst";

  @override
  String? _getKeyCondition() => 'msg_set_kind = ? AND msg_data = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(msg_set_kind);
    rn.add(msg_data);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CMsglayoutSetMstColumns rn = CMsglayoutSetMstColumns();
      rn.msg_set_kind = maps[i]['msg_set_kind'];
      rn.msg_data = maps[i]['msg_data'];
      rn.msg_name = maps[i]['msg_name'];
      rn.msg_dsp_cond = maps[i]['msg_dsp_cond'];
      rn.msg_target_dsp_cond = maps[i]['msg_target_dsp_cond'];
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
    CMsglayoutSetMstColumns rn = CMsglayoutSetMstColumns();
    rn.msg_set_kind = maps[0]['msg_set_kind'];
    rn.msg_data = maps[0]['msg_data'];
    rn.msg_name = maps[0]['msg_name'];
    rn.msg_dsp_cond = maps[0]['msg_dsp_cond'];
    rn.msg_target_dsp_cond = maps[0]['msg_target_dsp_cond'];
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
      CMsglayoutSetMstField.msg_set_kind : this.msg_set_kind,
      CMsglayoutSetMstField.msg_data : this.msg_data,
      CMsglayoutSetMstField.msg_name : this.msg_name,
      CMsglayoutSetMstField.msg_dsp_cond : this.msg_dsp_cond,
      CMsglayoutSetMstField.msg_target_dsp_cond : this.msg_target_dsp_cond,
      CMsglayoutSetMstField.ins_datetime : this.ins_datetime,
      CMsglayoutSetMstField.upd_datetime : this.upd_datetime,
      CMsglayoutSetMstField.status : this.status,
      CMsglayoutSetMstField.send_flg : this.send_flg,
      CMsglayoutSetMstField.upd_user : this.upd_user,
      CMsglayoutSetMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_65 メッセージレイアウト設定マスタ  c_msglayout_set_mstのフィールド名設定用クラス
class CMsglayoutSetMstField {
  static const msg_set_kind = "msg_set_kind";
  static const msg_data = "msg_data";
  static const msg_name = "msg_name";
  static const msg_dsp_cond = "msg_dsp_cond";
  static const msg_target_dsp_cond = "msg_target_dsp_cond";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region 03_66	コード決済事業者マスタ	c_payoperator_mst
/// 03_66 コード決済事業者マスタ  c_payoperator_mstクラス
class CPayoperatorMstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  String? payopera_typ;
  int payopera_cd = 0;
  String? name;
  String? short_name;
  int misc_cd = 0;
  int showorder = 1;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_payoperator_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND payopera_typ = ? AND payopera_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(payopera_typ);
    rn.add(payopera_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CPayoperatorMstColumns rn = CPayoperatorMstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.payopera_typ = maps[i]['payopera_typ'];
      rn.payopera_cd = maps[i]['payopera_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.misc_cd = maps[i]['misc_cd'];
      rn.showorder = maps[i]['showorder'];
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
    CPayoperatorMstColumns rn = CPayoperatorMstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.payopera_typ = maps[0]['payopera_typ'];
    rn.payopera_cd = maps[0]['payopera_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.misc_cd = maps[0]['misc_cd'];
    rn.showorder = maps[0]['showorder'];
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
      CPayoperatorMstField.comp_cd : this.comp_cd,
      CPayoperatorMstField.stre_cd : this.stre_cd,
      CPayoperatorMstField.payopera_typ : this.payopera_typ,
      CPayoperatorMstField.payopera_cd : this.payopera_cd,
      CPayoperatorMstField.name : this.name,
      CPayoperatorMstField.short_name : this.short_name,
      CPayoperatorMstField.misc_cd : this.misc_cd,
      CPayoperatorMstField.showorder : this.showorder,
      CPayoperatorMstField.ins_datetime : this.ins_datetime,
      CPayoperatorMstField.upd_datetime : this.upd_datetime,
      CPayoperatorMstField.status : this.status,
      CPayoperatorMstField.send_flg : this.send_flg,
      CPayoperatorMstField.upd_user : this.upd_user,
      CPayoperatorMstField.upd_system : this.upd_system,
    };
  }
}

/// 03_66 コード決済事業者マスタ  c_payoperator_mstのフィールド名設定用クラス
class CPayoperatorMstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const payopera_typ = "payopera_typ";
  static const payopera_cd = "payopera_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const misc_cd = "misc_cd";
  static const showorder = "showorder";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion
//region c_batprcchg_mst c_batprcchg_mst
/// c_batprcchg_mst c_batprcchg_mstクラス
class CBatprcchgMstColumns extends TableColumns{
  int? prcchg_cd;
  int? order_cd;
  int? comp_cd;
  int? stre_cd;
  String? plu_cd;
  int? flg;
  int pos_prc = 0;
  int cust_prc = 0;
  String? start_datetime;
  String? end_datetime;
  int timesch_flg = 0;
  int sun_flg = 0;
  int mon_flg = 0;
  int tue_flg = 0;
  int wed_flg = 0;
  int thu_flg = 0;
  int fri_flg = 0;
  int sat_flg = 0;
  int stop_flg = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_batprcchg_mst";

  @override
  String? _getKeyCondition() => 'prcchg_cd = ? AND order_cd = ? AND comp_cd = ? AND stre_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(prcchg_cd);
    rn.add(order_cd);
    rn.add(comp_cd);
    rn.add(stre_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CBatprcchgMstColumns rn = CBatprcchgMstColumns();
      rn.prcchg_cd = maps[i]['prcchg_cd'];
      rn.order_cd = maps[i]['order_cd'];
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.plu_cd = maps[i]['plu_cd'];
      rn.flg = maps[i]['flg'];
      rn.pos_prc = maps[i]['pos_prc'];
      rn.cust_prc = maps[i]['cust_prc'];
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
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    CBatprcchgMstColumns rn = CBatprcchgMstColumns();
    rn.prcchg_cd = maps[0]['prcchg_cd'];
    rn.order_cd = maps[0]['order_cd'];
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.plu_cd = maps[0]['plu_cd'];
    rn.flg = maps[0]['flg'];
    rn.pos_prc = maps[0]['pos_prc'];
    rn.cust_prc = maps[0]['cust_prc'];
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
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      CBatprcchgMstField.prcchg_cd : this.prcchg_cd,
      CBatprcchgMstField.order_cd : this.order_cd,
      CBatprcchgMstField.comp_cd : this.comp_cd,
      CBatprcchgMstField.stre_cd : this.stre_cd,
      CBatprcchgMstField.plu_cd : this.plu_cd,
      CBatprcchgMstField.flg : this.flg,
      CBatprcchgMstField.pos_prc : this.pos_prc,
      CBatprcchgMstField.cust_prc : this.cust_prc,
      CBatprcchgMstField.start_datetime : this.start_datetime,
      CBatprcchgMstField.end_datetime : this.end_datetime,
      CBatprcchgMstField.timesch_flg : this.timesch_flg,
      CBatprcchgMstField.sun_flg : this.sun_flg,
      CBatprcchgMstField.mon_flg : this.mon_flg,
      CBatprcchgMstField.tue_flg : this.tue_flg,
      CBatprcchgMstField.wed_flg : this.wed_flg,
      CBatprcchgMstField.thu_flg : this.thu_flg,
      CBatprcchgMstField.fri_flg : this.fri_flg,
      CBatprcchgMstField.sat_flg : this.sat_flg,
      CBatprcchgMstField.stop_flg : this.stop_flg,
      CBatprcchgMstField.ins_datetime : this.ins_datetime,
      CBatprcchgMstField.upd_datetime : this.upd_datetime,
      CBatprcchgMstField.status : this.status,
      CBatprcchgMstField.send_flg : this.send_flg,
      CBatprcchgMstField.upd_user : this.upd_user,
      CBatprcchgMstField.upd_system : this.upd_system,
    };
  }
}

/// c_batprcchg_mst c_batprcchg_mstのフィールド名設定用クラス
class CBatprcchgMstField {
  static const prcchg_cd = "prcchg_cd";
  static const order_cd = "order_cd";
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const plu_cd = "plu_cd";
  static const flg = "flg";
  static const pos_prc = "pos_prc";
  static const cust_prc = "cust_prc";
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
}
//endregion
//region 区分マスタ2 c_divide2_mst
/// 区分マスタ2 c_divide2_mstクラス
class CDivide2MstColumns extends TableColumns{
  int? comp_cd;
  int? stre_cd;
  int? kind_cd;
  int? div_cd;
  String? name;
  String? short_name;
  int? exp_cd1;
  int? exp_cd2;
  int exp_cd3 = 0;
  int exp_cd4 = 0;
  String? exp_data1;
  String? exp_data2;
  String? exp_data3;
  int exp_l_cd1 = 0;
  int exp_l_cd2 = 0;
  int exp_l_cd3 = 0;
  double? exp_d_cd1 = 0;
  double? exp_d_cd2 = 0;
  int exp_amt = 0;
  String? ins_datetime;
  String? upd_datetime;
  int status = 0;
  int send_flg = 0;
  int upd_user = 0;
  int upd_system = 0;

  @override
  String _getTableName() => "c_divide2_mst";

  @override
  String? _getKeyCondition() => 'comp_cd = ? AND stre_cd = ? AND kind_cd = ? AND div_cd = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(comp_cd);
    rn.add(stre_cd);
    rn.add(kind_cd);
    rn.add(div_cd);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      CDivide2MstColumns rn = CDivide2MstColumns();
      rn.comp_cd = maps[i]['comp_cd'];
      rn.stre_cd = maps[i]['stre_cd'];
      rn.kind_cd = maps[i]['kind_cd'];
      rn.div_cd = maps[i]['div_cd'];
      rn.name = maps[i]['name'];
      rn.short_name = maps[i]['short_name'];
      rn.exp_cd1 = maps[i]['exp_cd1'];
      rn.exp_cd2 = maps[i]['exp_cd2'];
      rn.exp_cd3 = maps[i]['exp_cd3'];
      rn.exp_cd4 = maps[i]['exp_cd4'];
      rn.exp_data1 = maps[i]['exp_data1'];
      rn.exp_data2 = maps[i]['exp_data2'];
      rn.exp_data3 = maps[i]['exp_data3'];
      rn.exp_l_cd1 = maps[i]['exp_l_cd1'];
      rn.exp_l_cd2 = maps[i]['exp_l_cd2'];
      rn.exp_l_cd3 = maps[i]['exp_l_cd3'];
      rn.exp_d_cd1 = maps[i]['exp_d_cd1'];
      rn.exp_d_cd2 = maps[i]['exp_d_cd2'];
      rn.exp_amt = maps[i]['exp_amt'];
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
    CDivide2MstColumns rn = CDivide2MstColumns();
    rn.comp_cd = maps[0]['comp_cd'];
    rn.stre_cd = maps[0]['stre_cd'];
    rn.kind_cd = maps[0]['kind_cd'];
    rn.div_cd = maps[0]['div_cd'];
    rn.name = maps[0]['name'];
    rn.short_name = maps[0]['short_name'];
    rn.exp_cd1 = maps[0]['exp_cd1'];
    rn.exp_cd2 = maps[0]['exp_cd2'];
    rn.exp_cd3 = maps[0]['exp_cd3'];
    rn.exp_cd4 = maps[0]['exp_cd4'];
    rn.exp_data1 = maps[0]['exp_data1'];
    rn.exp_data2 = maps[0]['exp_data2'];
    rn.exp_data3 = maps[0]['exp_data3'];
    rn.exp_l_cd1 = maps[0]['exp_l_cd1'];
    rn.exp_l_cd2 = maps[0]['exp_l_cd2'];
    rn.exp_l_cd3 = maps[0]['exp_l_cd3'];
    rn.exp_d_cd1 = maps[0]['exp_d_cd1'];
    rn.exp_d_cd2 = maps[0]['exp_d_cd2'];
    rn.exp_amt = maps[0]['exp_amt'];
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
      CDivide2MstField.comp_cd : this.comp_cd,
      CDivide2MstField.stre_cd : this.stre_cd,
      CDivide2MstField.kind_cd : this.kind_cd,
      CDivide2MstField.div_cd : this.div_cd,
      CDivide2MstField.name : this.name,
      CDivide2MstField.short_name : this.short_name,
      CDivide2MstField.exp_cd1 : this.exp_cd1,
      CDivide2MstField.exp_cd2 : this.exp_cd2,
      CDivide2MstField.exp_cd3 : this.exp_cd3,
      CDivide2MstField.exp_cd4 : this.exp_cd4,
      CDivide2MstField.exp_data1 : this.exp_data1,
      CDivide2MstField.exp_data2 : this.exp_data2,
      CDivide2MstField.exp_data3 : this.exp_data3,
      CDivide2MstField.exp_l_cd1 : this.exp_l_cd1,
      CDivide2MstField.exp_l_cd2 : this.exp_l_cd2,
      CDivide2MstField.exp_l_cd3 : this.exp_l_cd3,
      CDivide2MstField.exp_d_cd1 : this.exp_d_cd1,
      CDivide2MstField.exp_d_cd2 : this.exp_d_cd2,
      CDivide2MstField.exp_amt : this.exp_amt,
      CDivide2MstField.ins_datetime : this.ins_datetime,
      CDivide2MstField.upd_datetime : this.upd_datetime,
      CDivide2MstField.status : this.status,
      CDivide2MstField.send_flg : this.send_flg,
      CDivide2MstField.upd_user : this.upd_user,
      CDivide2MstField.upd_system : this.upd_system,
    };
  }
}

/// 区分マスタ2 c_divide2_mstのフィールド名設定用クラス
class CDivide2MstField {
  static const comp_cd = "comp_cd";
  static const stre_cd = "stre_cd";
  static const kind_cd = "kind_cd";
  static const div_cd = "div_cd";
  static const name = "name";
  static const short_name = "short_name";
  static const exp_cd1 = "exp_cd1";
  static const exp_cd2 = "exp_cd2";
  static const exp_cd3 = "exp_cd3";
  static const exp_cd4 = "exp_cd4";
  static const exp_data1 = "exp_data1";
  static const exp_data2 = "exp_data2";
  static const exp_data3 = "exp_data3";
  static const exp_l_cd1 = "exp_l_cd1";
  static const exp_l_cd2 = "exp_l_cd2";
  static const exp_l_cd3 = "exp_l_cd3";
  static const exp_d_cd1 = "exp_d_cd1";
  static const exp_d_cd2 = "exp_d_cd2";
  static const exp_amt = "exp_amt";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const status = "status";
  static const send_flg = "send_flg";
  static const upd_user = "upd_user";
  static const upd_system = "upd_system";
}
//endregion