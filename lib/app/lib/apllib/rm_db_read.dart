/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:math';

import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../../postgres_library/src/basic_table_access.dart';
import '../../../../../../postgres_library/src/pos_basic_table_access.dart';
import '../../../../../../postgres_library/src/staff_table_access.dart';
import '../../fb/fb_lib.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/trm_list.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import 'recog.dart';
import 'rm_common.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_msg.dart';
import '../../inc/lib/apllib.dart';
import 'apllib_img_read.dart';
import 'apllib_other.dart';
import 'competition_ini.dart';
import 'get_func_color.dart';
import 'lib_fb_memo.dart';
import 'rcsch.dart';
import 'rcsch_other.dart';
import 'recog_db.dart';
import 'staff_auth.dart';

/// 関連tprxソース: rmdbread.c
class RmDBRead {
  late RxCommonBuf _pCom;
  DlgConfirmMsgKind _msgKind = DlgConfirmMsgKind.MSG_NONE;

  RmDBRead() {
    _pCom = SystemFunc.readRxCommonBuf();
    _msgKind = DlgConfirmMsgKind.MSG_NONE;
  }

  /// エラーダイアログIDを上書きする関数.
  void _setErrDlgId(DlgConfirmMsgKind kind) {
    if (_msgKind != DlgConfirmMsgKind.MSG_NONE) {
      return;
    }
    _msgKind = kind;
  }

  /// 関連tprxソース: rmdbread.c - rmDbReadMain()
  Future<DlgConfirmMsgKind> rmDbReadMain() async {
    await rmDbReadStage1();
    // rmDbReadStage1の情報を使ってDBを読み込むため同期処理.
    await rmDbReadStage2();
    await rmDbReadStage3();

    // await dbAccess.closeDB();
    return _msgKind;
  }

  /// 関連tprxソース: rmdbread.c - rmDbReadMain_Sub()
  Future<DlgConfirmMsgKind> rmDbReadMainSub() async {
    await rmDbReadStage3();
    return _msgKind;
  }

  /// 関連tprxソース: rmdbread.c - rmDbReadStage1()
  Future<void> rmDbReadStage1() async {
    await rmDbRegInfoRead(); // レジ情報マスタ
    await _rmDbStreRead(); /* 店舗マスタ */
    await _rmDbCompRead(); /* 企業マスタ */
    await _rmDbCtrlRead(); // 共通コントロール
    await _rmDbTrmRead(); /* ターミナルマスタ */

    await RcSchOther.rcSchTrmRsvRead(0); // 予約ターミナルマスタ

    await _rmDbReportCntRead();
    await rmDbOpenCloseRead(); /* レジ開閉店情報マスタ */
    await _rmDbTrmPlanRead(); // ターミナル企画番号
  }

  /// 関連tprxソース: rmdbread.c - rmDbReadStage2()
  Future<void> rmDbReadStage2() async {
    // Aを使ってBを読み込むという処理がない(それぞれが独立している)ので、非同期で効率的に処理を行う.
    List<Future> futures = [];
    futures.add(rmDbStaffopenRead()); // 従業員オープン情報マスタ
    futures.add(_rmDbInstreRead()); // インストアマーキングマスタ
    futures.add(_rmDbTaxRead()); // 税金テーブルマスタ

    futures.add(_rmDbRecmsgRead()); // レシートメッセージマスタ
    futures.add(_rmDbRecmsgSchRead()); // レシートメッセージスケジュール
    futures.add(rmDbKeyFncRead());
    futures.add(_rmDbImgRead()); // イメージマスタ
    futures.add(rmDbCashrecycleRead()); //キャッシュリサイクルマスタ
    await Future.wait(futures);
  }

  /// 関連tprxソース: rmdbread.c - rmDbReadStage3()
  Future<void> rmDbReadStage3() async {
    List<Future> futures = [];
    futures.add(rmDbPresetMkey1Read()); /* 本体メカキープリセット */
    /* Jr本体メカキープリセット */
    /* 2800i本体メカキープリセット */
    /* 2800iM本体メカキープリセット */
    /* 3800a 35メカキープリセット */
    futures.add(rmDbPresetMkey2Read()); //  タワーメカキープリセット
    //
    futures.add(rmDbStaffopenRead()); // 従業員オープン情報マスタ
    await Future.wait(futures);
  }

  /// イメージマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbImgRead()
  Future<bool> _rmDbImgRead() async {
    var db = DbManipulationPs();

    try {
      String sql =
          "select img_cd ,img_data from c_img_mst where comp_cd = ${_pCom.dbRegCtrl.compCd} AND stre_cd = ${_pCom.dbRegCtrl.streCd} AND img_grp_cd = '${_pCom.dbRegCtrl.imgGrpCd}' order by img_cd";

      Result result = await db.dbCon.execute(sql);

      if (result == null || result.isEmpty) {
        return false;
      }
      int loopMax = min(result.length, RxImg.getDBImgMax());
      _pCom.imgMax = loopMax;
      for (int i = 0; i < loopMax; i++) {
        Map<String, dynamic> data = result[i].toColumnMap();
        _pCom.img.imgCd[i] = getIntValueFromDbMap(data["img_cd"]);
        if (_pCom.img.imgCd[i] <= 0) {
          break;
        }
        _pCom.img.imgData[i] = getStringValueFromDbMap(data["img_data"]);
      }
      if (loopMax < RxImg.getDBImgMax()) {
        // 足りてないDBデータの分を埋める.
        for (int i = loopMax; i < RxImg.getDBImgMax(); i++) {
          _pCom.img.imgCd[i] = i + 10000;
          _pCom.img.imgData[i] = "     ";
          _pCom.imgMax++;
        }
      }
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "イメージ max = ${_pCom.imgMax} [${_pCom.img.imgCd[0]}-${_pCom.img.imgData[0]}][${_pCom.img.imgCd[RxImg.getDBImgMax() - 1]}-${_pCom.img.imgData[RxImg.getDBImgMax() - 1]}]");

      return true;
    } catch (e, s) {
      TprLog().logAdd(
        Tpraid.TPRAID_SYST,
        LogLevelDefine.error,
        "_rmDbImgRead() : $e $s )",
      );
      _setErrDlgId(DlgConfirmMsgKind.MSG_IMG_NOTREAD);
      return false;
    }
  }

  /// レジ情報マスタ, レジ情報グループ管理マスタの読み込み
  ///  関連tprxソース:rmdbread.c - rmDbReginfoRead()
  Future<DlgConfirmMsgKind> rmDbRegInfoRead() async {
    int macno = _pCom.iniMacInfo.system.macno;
    if (macno == 0) {
      CompetitionIniRet ret =
          await CompetitionIni.competitionIniGetMacNo(Tpraid.TPRAID_SYSTEM);
      macno = ret.isSuccess ? ret.value : -1;
    }
    late Map<String, dynamic> result;
    try {
      result = await _getDdMacInfoData(macno);
    } catch (e) {
      if (_pCom.dbRegCtrl.compCd != _pCom.iniMacInfoCrpNoNo ||
          _pCom.dbRegCtrl.streCd != _pCom.iniMacInfoShopNo) {
        _pCom.dbRegCtrl.compCd = _pCom.iniMacInfoCrpNoNo;
        _pCom.dbRegCtrl.streCd = _pCom.iniMacInfoShopNo;
        _pCom.dbRegCtrl.presetGrpCd = 1;
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "Default Comp, Stre Set(from ini): comp_cd[${_pCom.iniMacInfoCrpNoNo}] stre_cd[${_pCom.iniMacInfoShopNo}].$e");
      }
      _setErrDlgId(DlgConfirmMsgKind.MSG_REGCTLR_NOTREAD);
      return _msgKind;
    }
    _pCom.dbRegCtrl.compCd = int.tryParse(result["comp_cd"]) ?? 0;
    _pCom.dbRegCtrl.streCd = int.tryParse(result["stre_cd"]) ?? 0;
    _pCom.dbRegCtrl.macNo = int.tryParse(result["mac_no"]) ?? 0;
    _pCom.dbRegCtrl.macTyp = result["mac_typ"] ?? 0;
    _pCom.dbRegCtrl.macAddr = result["mac_addr"] ?? "";
    _pCom.dbRegCtrl.ipAddr = result["ip_addr"] ?? "";
    _pCom.dbRegCtrl.brdcastAddr = result["brdcast_addr"] ?? "";
    _pCom.dbRegCtrl.ipAddr2 = result["ip_addr2"] ?? "";
    _pCom.dbRegCtrl.brdcastAddr2 = result["brdcast_addr2"] ?? "";

    _pCom.dbRegCtrl.orgMacNo = int.tryParse(result["org_mac_no"]) ?? 0;
    _pCom.dbRegCtrl.crdtTrmCd = result["crdt_trm_cd"] ?? "";

    _pCom.dbRegCtrl.setOwnerFlg = result["set_owner_flg"] ?? 0;
    _pCom.dbRegCtrl.macRole1 = result["mac_role1"] ?? 0;
    _pCom.dbRegCtrl.macRole2 = result["mac_role2"] ?? 0;
    _pCom.dbRegCtrl.macRole3 = result["mac_role3"] ?? 0;

    _pCom.dbRegCtrl.macRole2 = result["pbchg_flg"] ?? 0;
    _pCom.dbRegCtrl.startDatetime = result["start_datetime"] == null
        ? DateUtil.invalidDate
        : result["start_datetime"];
    _pCom.dbRegCtrl.endDatetime = result["end_datetime"] == null
        ? DateUtil.invalidDate
        : result["start_datetime"];

    _pCom.dbRegCtrl.autoOpnCshrCd = int.tryParse(result["auto_opn_cshr_cd"]) ?? 0;
    _pCom.dbRegCtrl.autoOpnChkrCd = int.tryParse(result["auto_opn_chkr_cd"]) ?? 0;
    _pCom.dbRegCtrl.autoClsCshrCd = int.tryParse(result["auto_cls_cshr_cd"]) ?? 0;

    _pCom.dbRegCtrl.clsGrpCd = int.tryParse(result["cls_grp_cd"]) ?? 0;
    _pCom.dbRegCtrl.trmGrpCd = int.tryParse(result["trm_grp_cd"]) ?? 0;
    _pCom.dbRegCtrl.presetGrpCd = int.tryParse(result["preset_grp_cd"]) ?? 0;

    _pCom.dbRegCtrl.koptGrpCd = int.tryParse(result["kopt_grp_cd"]) ?? 0;
    _pCom.dbRegCtrl.batchGrpCd = int.tryParse(result["batch_grp_cd"]) ?? 0;
    _pCom.dbRegCtrl.imgGrpCd = int.tryParse(result["img_grp_cd"]) ?? 0;

    _pCom.dbRegCtrl.msgGrpCd = int.tryParse(result["msg_grp_cd"]) ?? 0;
    _pCom.dbRegCtrl.cashrecycleGrpCd =
        int.tryParse(result["cashrecycle_grp_cd"]) ?? 0;
    _pCom.dbRegCtrl.cardCompCd = int.tryParse(result["card_comp_cd"]) ?? 0;
    _pCom.dbRegCtrl.cardStreCd = int.tryParse(result["card_stre_cd"]) ?? 0;
    _pCom.dbRegCtrl.stropnclsGrpCd =
        int.tryParse(result["stropncls_grp_cd"]) ?? 0;
    _pCom.dbRegCtrl.forcestrclsGrpCd =
        int.tryParse(result["forcestrcls_grp_cd"]) ?? 0;
    return _msgKind;
  }

  Future<Map<String, dynamic>> _getDdMacInfoData(int macNo) async {
    String sql = '''SELECT 
	inf.comp_cd AS comp_cd, inf.stre_cd AS stre_cd, inf.mac_no AS mac_no, 
	MAX(inf.mac_typ) AS mac_typ, MAX(inf.mac_addr) AS mac_addr, MAX(inf.ip_addr) AS ip_addr, 
	MAX(inf.brdcast_addr) AS brdcast_addr, MAX(inf.ip_addr2) AS ip_addr2, MAX(inf.brdcast_addr2) AS brdcast_addr2, 
	MAX(inf.org_mac_no) AS org_mac_no, MAX(inf.crdt_trm_cd) AS crdt_trm_cd, MAX(inf.set_owner_flg) AS set_owner_flg, 
	MAX(inf.mac_role1) AS mac_role1, MAX(inf.mac_role2) AS mac_role2, MAX(inf.mac_role3) AS mac_role3, 
	MAX(inf.pbchg_flg) AS pbchg_flg, MAX(inf.start_datetime) AS start_datetime, MAX(inf.end_datetime) AS end_datetime, 
	MAX(inf.auto_opn_cshr_cd) AS auto_opn_cshr_cd, MAX(inf.auto_opn_chkr_cd) AS auto_opn_chkr_cd, MAX(inf.auto_cls_cshr_cd) AS auto_cls_cshr_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_CLS.typeCd}' THEN grp.grp_cd ELSE '0' END) AS cls_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_TRM.typeCd}' THEN grp.grp_cd ELSE '1' END) AS trm_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_PRESET.typeCd}' THEN grp.grp_cd ELSE '1' END) AS preset_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_KOPT.typeCd}' THEN grp.grp_cd ELSE '1' END) AS kopt_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_BATCH.typeCd}' THEN grp.grp_cd ELSE '1' END) AS batch_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_IMG.typeCd}' THEN grp.grp_cd ELSE '1' END) AS img_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_MSG.typeCd}' THEN grp.grp_cd ELSE '1' END) AS msg_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_CASHRECYCLE.typeCd}' THEN grp.grp_cd ELSE '0' END) AS cashrecycle_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_CARDCOMP.typeCd}' THEN grp.grp_cd ELSE '1' END) AS card_comp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_CARDSTRE.typeCd}' THEN grp.grp_cd ELSE '1' END) AS card_stre_cd 
	, MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_STROPNCLS.typeCd}' THEN grp.grp_cd ELSE '1' END) AS stropncls_grp_cd, 
	MAX(CASE WHEN grp.grp_typ = '${REGGRP_LISTS.REGGRP_FORCESTRCLS.typeCd}' THEN grp.grp_cd ELSE '0' END) AS forcestrcls_grp_cd
	FROM c_reginfo_mst inf 
	LEFT OUTER JOIN c_reginfo_grp_mst grp 
	ON inf.comp_cd = grp.comp_cd AND inf.stre_cd = grp.stre_cd AND inf.mac_no = grp.mac_no 
	WHERE inf.comp_cd = '${_pCom.iniMacInfoCrpNoNo}' AND inf.stre_cd = '${_pCom.iniMacInfoShopNo}' AND inf.mac_no = '$macNo'
	GROUP BY inf.comp_cd, inf.stre_cd, inf.mac_no
	''';

    var db = DbManipulationPs();

    Result result = await db.dbCon.execute(sql);

    if (result.isEmpty) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_REGCTLR_NOTREAD);
      throw "_getDdBMacInfoData() : dataList is empty error";
    }
    //一つだけ取得できるはず.
    return result.first.toColumnMap();
  }

  /// 店舗マスタ読み込み.
  ///  関連tprxソース: rmdbread.c - rmDbStreRead();
  Future<bool> _rmDbStreRead() async {
    try {
      var db = DbManipulationPs();

      String sql1 =
          "select * from c_stre_mst where stre_cd = @p1 and comp_cd = @p2";
      Map<String, dynamic>? subValues = {
        "p1": _pCom.dbRegCtrl.streCd,
        "p2": _pCom.dbRegCtrl.compCd
      };
      Result result =
          await db.dbCon.execute(Sql.named(sql1), parameters: subValues);

      if (result.isEmpty) {
        _setErrDlgId(DlgConfirmMsgKind.MSG_STRE_NOTREAD);
        return false;
      }
      Map<String, dynamic> data = result.first.toColumnMap();
      // TODO:00007 梶原 DB置き換え 型を後で直す
      CStreMstColumns rn = CStreMstColumns();
      rn.stre_cd = int.parse(data['stre_cd']);
      rn.comp_cd = int.parse(data['comp_cd']);
      rn.zone_cd = int.parse(data['zone_cd']);
      rn.bsct_cd = int.parse(data['bsct_cd']);
      rn.name = data['name'];
      rn.short_name = data['short_name'];
      rn.kana_name = data['kana_name'];
      rn.post_no = data['post_no'];
      rn.adress1 = data['adress1'];
      rn.adress2 = data['adress2'];
      rn.adress3 = data['adress3'];
      rn.telno1 = data['telno1'];
      rn.telno2 = data['telno2'];
      rn.srch_telno1 = data['srch_telno1'];
      rn.srch_telno2 = data['srch_telno2'];
      rn.ip_addr = data['ip_addr'];
      rn.trends_typ = data['trends_typ'];
      rn.stre_typ = data['stre_typ'];
      rn.flg_shp = data['flg_shp'];
      rn.business_typ1 = data['business_typ1'];
      rn.business_typ2 = data['business_typ2'];
      rn.chain_other_flg = data['chain_other_flg'];
      rn.locate_typ = data['locate_typ'];
      rn.openclose_flg = data['openclose_flg'];
      rn.opentime = (data['opentime']).toString();
      rn.closetime = (data['closetime']).toString();
      rn.floorspace = double.parse(data['floorspace']);
      rn.today = (data['today']).toString();
      rn.bfrday = (data['bfrday']).toString();
      rn.twodaybfr = (data['twodaybfr']).toString();
      rn.nextday = (data['nextday']).toString();
      rn.sysflg_base = data['sysflg_base'];
      rn.sysflg_sale = data['sysflg_sale'];
      rn.sysflg_purchs = data['sysflg_purchs'];
      rn.sysflg_order = data['sysflg_order'];
      rn.sysflg_invtry = data['sysflg_invtry'];
      rn.sysflg_cust = data['sysflg_cust'];
      rn.sysflg_poppy = data['sysflg_poppy'];
      rn.sysflg_elslbl = data['sysflg_elslbl'];
      rn.sysflg_fresh = data['sysflg_fresh'];
      rn.sysflg_wdslbl = data['sysflg_wdslbl'];
      rn.sysflg_24hour = data['sysflg_24hour'];
      rn.showorder = data['showorder'];
      rn.opendate = (data['opendate']).toString();
      rn.stre_ver_flg = data['stre_ver_flg'];
      rn.sunday_off_flg = data['sunday_off_flg'];
      rn.monday_off_flg = data['monday_off_flg'];
      rn.tuesday_off_flg = data['tuesday_off_flg'];
      rn.wednesday_off_flg = data['wednesday_off_flg'];
      rn.thursday_off_flg = data['thursday_off_flg'];
      rn.friday_off_flg = data['friday_off_flg'];
      rn.saturday_off_flg = data['saturday_off_flg'];
      rn.itemstock_flg = data['itemstock_flg'];
      rn.wait_time = data['wait_time'];
      rn.ins_datetime = (data['ins_datetime']).toString();
      rn.upd_datetime = (data['upd_datetime']).toString();
      rn.status = data['status'];
      rn.send_flg = data['send_flg'];
      rn.upd_user = int.parse(data['upd_user']);
      rn.upd_system = data['upd_system'];
      rn.entry_no = data['entry_no'];
      _pCom.dbStr = rn;
      return true;
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "rmDbRegInfoRead() : $e $s )");
      _setErrDlgId(DlgConfirmMsgKind.MSG_STRE_NOTREAD);
      return false;
    }
  }

  /// 企業マスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbCompRead();
  Future<bool> _rmDbCompRead() async {
    try {
      var db = DbManipulationPs();

      String sql1 = "select * from c_comp_mst where comp_cd = @p1";
      Map<String, dynamic>? subValues = {"p1": _pCom.dbRegCtrl.compCd};
      Result result =
          await db.dbCon.execute(Sql.named(sql1), parameters: subValues);

      if (result.isEmpty) {
        _setErrDlgId(DlgConfirmMsgKind.MSG_STRE_NOTREAD);
        return false;
      }
      Map<String, dynamic> data = result.first.toColumnMap();
      CCompMstColumns rn = CCompMstColumns();
      rn.comp_cd = int.parse(data['comp_cd']);
      rn.comp_typ = data['comp_typ'];
      rn.rtr_id = int.parse(data['rtr_id']);
      rn.name = data['name'];
      rn.short_name = data['short_name'];
      rn.kana_name = data['kana_name'];
      rn.post_no = data['post_no'];
      rn.adress1 = data['adress1'];
      rn.adress2 = data['adress2'];
      rn.adress3 = data['adress3'];
      rn.telno1 = data['telno1'];
      rn.telno2 = data['telno2'];
      rn.srch_telno1 = data['srch_telno1'];
      rn.srch_telno2 = data['srch_telno2'];
      rn.ins_datetime = (data['ins_datetime']).toString();
      rn.upd_datetime = (data['upd_datetime']).toString();
      rn.status = data['status'];
      rn.send_flg = data['send_flg'];
      rn.upd_user = int.parse(data['upd_user']);
      rn.upd_system = data['upd_system'];
      _pCom.dbComp = rn;
      return true;
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "_rmDbCompRead() : $e $s )");
      _setErrDlgId(DlgConfirmMsgKind.MSG_COMP_NOTREAD);
      return false;
    }
  }

  /// 共通コントロール読み込み
  /// 関連tprxソース: rmdbread.c - rmDbCtrlRead();
  Future<bool> _rmDbCtrlRead() async {
    try {
      var db = DbManipulationPs();

      String sql1 =
          "select ctrl_cd,ctrl_data from c_ctrl_mst where comp_cd = @p1";
      Map<String, dynamic>? subValues = {"p1": _pCom.dbRegCtrl.compCd};
      Result result =
          await db.dbCon.execute(Sql.named(sql1), parameters: subValues);

      if (result.isEmpty) {
        _setErrDlgId(DlgConfirmMsgKind.MSG_CTLR_NOTREAD);
        return false;
      }
      // for (var data in dataList) {
      for (int i = 0; i < result.length; i++) {
        Map<String, dynamic> data = result[i].toColumnMap();
        int ctrlCd = int.parse(data["ctrl_cd"]);
        double ctrlData = double.parse(data["ctrl_data"]);
        CtrlCodeList def = CtrlCodeList.getDefine(ctrlCd);

        switch (def) {
          case CtrlCodeList.CTRLNO_COST_PER_CLS:
            _pCom.dbCtrl.costPerCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_NONACT_CLS:
            _pCom.dbCtrl.nonactCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_DSC_CLS:
            _pCom.dbCtrl.dscCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_RBT_CLS_FLG:
            _pCom.dbCtrl.rbtClsFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_PRCCHG_FLG:
            _pCom.dbCtrl.prcchgFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_STLDSC_FLG:
            _pCom.dbCtrl.stldscFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_REGSALE_CLS:
            _pCom.dbCtrl.regsaleCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_TAXTBL_CLS:
            _pCom.dbCtrl.taxtblCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_TREAT_CLS_FLG:
            _pCom.dbCtrl.treatClsFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_WGH_CD_BASE_FLG:
            _pCom.dbCtrl.wghCdBaseFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_WGH_CD_RND_FLG:
            _pCom.dbCtrl.wghCdRndFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_UDT_BOTH_FLG:
            _pCom.dbCtrl.udtBothFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_REG_TENANT_FLG:
            _pCom.dbCtrl.regTenantFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_MULTPRC_CLS:
            _pCom.dbCtrl.multprcCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_PRESET_IMG_CLS_FLG:
            _pCom.dbCtrl.presetImgClsFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_STLPLUS_FLG:
            _pCom.dbCtrl.stlplusFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_PCTR_TCKT_CLS:
            _pCom.dbCtrl.pctrTcktCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_CLOTHING_CLS:
            _pCom.dbCtrl.clothingCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_ALERT_CLS:
            _pCom.dbCtrl.alertCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_CHG_CKT_CLS:
            _pCom.dbCtrl.chgCktCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_KITCHEN_PRN_CLS:
            _pCom.dbCtrl.kitchenPrnCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_PRICING_CLS:
            _pCom.dbCtrl.pricingCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_COUPON_CLS:
            _pCom.dbCtrl.couponCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SELF_WEIGHT_CLS:
            _pCom.dbCtrl.selfWeightCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_MSG_CLS:
            _pCom.dbCtrl.msgCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_POP_CLS:
            _pCom.dbCtrl.popCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_CUST_DETAIL_CLS:
            _pCom.dbCtrl.custDetailCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_MAG_CLS:
            _pCom.dbCtrl.magazineCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_TAX_EXEMPTION_CLS:
            _pCom.dbCtrl.taxExemptionCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_BOOK_CLS:
            _pCom.dbCtrl.bookCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_CUST_UNLOCK:
            _pCom.dbCtrl.custUnlock = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_CLS_POINTS_FLG:
            _pCom.dbCtrl.clsPointsFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SUB1_POINTS_FLG:
            _pCom.dbCtrl.sub1PointsFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SUB1_STLDSC_FLG:
            _pCom.dbCtrl.sub1StldscFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SUB1_STLPLUS_FLG:
            _pCom.dbCtrl.sub1StlplusFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SUB1_PCTR_TCKT_CLS:
            _pCom.dbCtrl.sub1PctrTcktCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SUB2_POINTS_FLG:
            _pCom.dbCtrl.sub2PointsFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SUB2_STLDSC_FLG:
            _pCom.dbCtrl.sub2StldscFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SUB2_STLPLUS_FLG:
            _pCom.dbCtrl.sub2StlplusFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_SUB2_PCTR_TCKT_CLS:
            _pCom.dbCtrl.sub2PctrTcktCls = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_DPNT_ADD_CLS_FLG:
            _pCom.dbCtrl.dpntAddClsFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_DPNT_USE_CLS_FLG:
            _pCom.dbCtrl.dpntUseClsFlg = ctrlData.toInt();
            break;
          case CtrlCodeList.CTRLNO_VOL_CD_RND_FLG:
            _pCom.dbCtrl.volCdRndFlg = ctrlData.toInt();
            break;
          default:
            break;
        }
      }

      return true;
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "_rmDbCtrlRead() : $e $s )");
      _setErrDlgId(DlgConfirmMsgKind.MSG_CTLR_NOTREAD);
      return false;
    }
  }

  /// ターミナルマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbTrmRead();
  Future<bool> _rmDbTrmRead() async {
    try {
      var db = DbManipulationPs();

      String sql =
          "select * from c_trm_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and  stre_cd = '${_pCom.dbRegCtrl.streCd}' and  trm_grp_cd = '${_pCom.dbRegCtrl.trmGrpCd}'";
      if (CompileFlag.DB_SUB_GROUP) {
        if (_pCom.dbRegCtrl.trmGrpCd == 1) {
          // 1.基本グループ.
          sql =
              "SELECT trm_grp_cd, trm_cd, trm_data from c_trm_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and  stre_cd = '${_pCom.dbRegCtrl.streCd}' and  trm_grp_cd = '${_pCom.dbRegCtrl.trmGrpCd}'";
        } else {
          // グループ2以上:基本グループと異なる設定データのみ保持
          sql = '''SELECT
			case when another.trm_grp_cd is not NULL then another.trm_grp_cd else base.trm_grp_cd end as trm_grp_cd,
			case when another.trm_grp_cd is not NULL then another.trm_cd else base.trm_cd end as trm_cd,
			case when another.trm_grp_cd is not NULL then another.trm_data else base.trm_data end as trm_data
			FROM
			(
			 (select trm_grp_cd, trm_cd, trm_data from c_trm_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and  stre_cd = '${_pCom.dbRegCtrl.streCd}' and  trm_grp_cd = '1') as base
			  full outer join
			 (select trm_grp_cd, trm_cd, trm_data from c_trm_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and  stre_cd = '${_pCom.dbRegCtrl.streCd}' and  trm_grp_cd = '${_pCom.dbRegCtrl.trmGrpCd}') as another on base.trm_cd = another.trm_cd
			)
			ORDER BY trm_grp_cd, trm_cd
          ''';
        }
      }

      Result result = await db.dbCon.execute(sql);

      rmDbTrmDtRead(Tpraid.TPRAID_SYST, result, false, _pCom);

      _rmDbTrmReadFloating();
      _rmDbTrmReadHitouch();
    } catch (e) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_TRM_NOTREAD);
      return false;
    }
    Recog recog = Recog();
    RecogValue selfSystem = (await recog.recogGet(Tpraid.TPRAID_NONE,
            RecogLists.RECOG_FRONT_SELF_SYSTEM, RecogTypes.RECOG_GETSYS))
        .result;
    if (selfSystem != RecogValue.RECOG_NO) {
      RecogValue cashierSystem = (await recog.recogGet(Tpraid.TPRAID_NONE,
              RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM, RecogTypes.RECOG_GETSYS))
          .result;
      if (cashierSystem != RecogValue.RECOG_NO) {
        // スマイルセルフ状態ならば.
        if (_pCom.dbTrm.frcClkFlg != 0) {
          _pCom.dbTrm.frcClkFlg = 2; // 簡易従業員は常に二人制
        }
        if (CompileFlag.SMART_SELF) {
          // 但し、15インチ対応の場合は、条件により「簡易従業員しない」とする
          RecogValue qcashierSystem = (await recog.recogGet(Tpraid.TPRAID_NONE,
                  RecogLists.RECOG_QCASHIER_SYSTEM, RecogTypes.RECOG_GETSYS))
              .result;
          if (qcashierSystem != RecogValue.RECOG_NO &&
              _pCom.iniMacInfo.select_self.qc_mode == 1) {
            _pCom.dbTrm.frcClkFlg = 0;
          }

          RecogValue selfGate = (await recog.recogGet(Tpraid.TPRAID_NONE,
                  RecogLists.RECOG_SELF_GATE, RecogTypes.RECOG_GETSYS))
              .result;
          if (selfGate != RecogValue.RECOG_NO &&
              _pCom.iniMacInfo.select_self.self_mode == 1) {
            _pCom.dbTrm.frcClkFlg = 0;
          }
        }
      }
    }

    if ((await CmCksys.cmQCashierSystem() == 1) &&
        (_pCom.iniSys.type.tower == 0.toString())) {
      RecogValue self = (await recog.recogGet(Tpraid.TPRAID_NONE,
              RecogLists.RECOG_HAPPYSELF_SYSTEM, RecogTypes.RECOG_GETSYS))
          .result;
      RecogValue smileself = (await recog.recogGet(Tpraid.TPRAID_NONE,
              RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM, RecogTypes.RECOG_GETSYS))
          .result;
      if (self == RecogValue.RECOG_NO && smileself == RecogValue.RECOG_NO) {
        //HappySelf仕様ではない.
        if (_pCom.dbTrm.frcClkFlg != 0) {
          //簡易従業員設定ならば オープンクローズにする.
          _pCom.dbTrm.frcClkFlg = 0;
        }
      }
    }
    if (CompileFlag.SMART_SELF) {
      RecogValue self = (await recog.recogGet(Tpraid.TPRAID_NONE,
              RecogLists.RECOG_HAPPYSELF_SYSTEM, RecogTypes.RECOG_GETSYS))
          .result;
      RecogValue smileSelf = (await recog.recogGet(Tpraid.TPRAID_NONE,
              RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM, RecogTypes.RECOG_GETSYS))
          .result;
      if (self != RecogValue.RECOG_NO || smileSelf != RecogValue.RECOG_NO) {
        // HappySelf仕様.
        // pCom->frc_clk_flgが0の時はここでコピーしておく
        _pCom.frcClkFlgCpt = _pCom.dbTrm.frcClkFlg;
        if (_pCom.dbTrm.frcClkFlg != 0) {
          // 簡易従業員は常に二人制.
          _pCom.dbTrm.frcClkFlg = 2;
          _pCom.frcClkFlgCpt = 2;
        }
        if (self != RecogValue.RECOG_NO) {
          if (_pCom.iniMacInfo.select_self.qc_mode == 1 ||
              _pCom.iniMacInfo.select_self.self_mode == 1) {
            _pCom.dbTrm.frcClkFlg = 0;
          }
        }
      }
    }
    // オートアップデートしないでok0893を立てることもあるので、無効にする箇所を削除
    // 共有メモリで無理やりok0893扱いにするように修正する
    // オートアップデートするorしないの設定がターミナルなのでここで行う
    if ((await CmCksys.cmZHQSystem() == 0) &&
        CmCksys.cmAutoUpdateSystem() != 0) {
      //  全日食様はZクイックで行うので何もしない.
      RecogValue remoteServer = (await recog.recogGet(Tpraid.TPRAID_SYST,
              RecogLists.RECOG_REMOTESERVER, RecogTypes.RECOG_GETSYS))
          .result;
      if (remoteServer == RecogValue.RECOG_NO) {
        // オートアップデートする、リモート監視サーバー仕様の承認キーが無効の場合は強制有効
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
            "recog remoteserver ok0893 ON");
        recog.recogSet(Tpraid.TPRAID_SYST, RecogLists.RECOG_REMOTESERVER,
            RecogTypes.RECOG_SETSYS, RecogValue.RECOG_OK0893.index);
        RecogDB.RecogSetDB(Tpraid.TPRAID_SYST, RecogLists.RECOG_REMOTESERVER,
            RecogValue.RECOG_OK0893);
      }
    }
    LibFbMemo.memoReadFlgSet(Tpraid.TPRAID_SYST, null, _pCom);
    return true;
  }

  /// ターミナルに設定されているフローティングレジのIPアドレスを設定する
  /// 関連tprxソース: rmdbread.c - rmDbTrmRead_Floating();
  void _rmDbTrmReadFloating() {
    if (_pCom.dbTrm.scalermFroatingMacNo > 0) {
      // 対象レジ番号の設定あり
      // pCom->FloatingIpAddr に取り込む
      // TODO:10024 フローティングレジ
    }
  }

  /// ターミナルに設定されているハイタッチレジのIPアドレスを設定する
  /// 関連tprxソース: rmdbread.c - rmDbTrmRead_Hitouch();
  void _rmDbTrmReadHitouch() {
    if (_pCom.dbTrm.hiTouchMacNo > 0) {
      // 対象レジ番号の設定あり
      // pCom->hi_touch_IpAddr に取り込む
      // TODO:10025 ハイタッチレジ
    }
  }

  /// DBのターミナルデータを共有メモリにセットする.
  /// 関連tprxソース: rmdbread.c - rmDbTrmDtRead();
  static void rmDbTrmDtRead(
      TprMID tid, Result dataList, bool logFlag, RxCommonBuf pCom) {
    if (dataList.isEmpty) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, "_rmDbTrmDtRead() : res NULL error",
          errId: -1);
    }

    int subGrpCnt = 0;
    for (int i = 0; i < dataList.length; i++) {
      final data = dataList[i].toColumnMap();
      int trmGrpCd = int.tryParse(data["trm_grp_cd"] ?? "0") ?? 0;
      if (trmGrpCd == pCom.dbRegCtrl.trmGrpCd) {
        subGrpCnt++;
      }

      int trmCd = int.tryParse(data["trm_cd"] ?? "0") ?? 0;
      dynamic trmData = double.tryParse(data["trm_data"] ?? "0.0") ?? 0.0;
      TrmCdList def = TrmCdList.getDefine(trmCd);
      pCom.dbTrm.setValueFromTrmData(def, trmData);
      if (logFlag) {
        TprLog().logAdd(tid, LogLevelDefine.normal,
            "_rmDbTrmDtRead() : set trm_cd [$trmCd], trm_data ${trmData.toString()}");
      }
    }
    TprLog().logAdd(tid, LogLevelDefine.normal,
        "_rmDbTrmDtRead(): tuple [${dataList.length}] sub_grp( cd[${pCom.dbRegCtrl.trmGrpCd}] cnt[$subGrpCnt] )");
  }

  /// レポートカウンタ読み込み
  ///  関連tprxソース: rmdbread.c - rmDbReportCntRead()
  Future<bool> _rmDbReportCntRead() async {
    var db = DbManipulationPs();

    try {
      String sql =
          "select bfr_datetime from c_report_cnt where report_cnt_cd = '1002' and comp_cd  = '${_pCom.dbRegCtrl.compCd}' and stre_cd = '${_pCom.dbRegCtrl.streCd}' and mac_no = '${_pCom.dbRegCtrl.macNo}'";

      Result result = await db.dbCon.execute(sql);

      if (result.isEmpty) {
        return false;
      }
      Map<String, dynamic> data = result.first.toColumnMap();
      _pCom.dbReportCnt.bfr_datetime = (data["bfr_datetime"]).toString();
      return true;
    } catch (e, s) {
      return false;
    }
  }

  /// レポートカウンタ読み込み
  ///  関連tprxソース: rmdbread.c - rmDbOpencloseRead()
  Future<bool> rmDbOpenCloseRead() async {
    try {
      var (int error, String date) = await DateUtil.dateTimeChange(null,
          DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE,
          DateTimeFormatKind.FT_YYYYMMDD_HYPHEN,
          DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
      String saleDate = date;
      if (saleDate == "0000-00-00") {
        _setErrDlgId(DlgConfirmMsgKind.MSG_OPENCLOSE_NOTREAD);
        return false;
      }

      var db = DbManipulationPs();
      String sql1 =
          "select * from c_openclose_mst where comp_cd = @p1 AND stre_cd = @p2 AND mac_no = @p3 AND sale_date = @p4";
      Map<String, dynamic>? subValues = {
        "p1": _pCom.dbRegCtrl.compCd,
        "p2": _pCom.dbRegCtrl.streCd,
        "p3": _pCom.dbRegCtrl.macNo,
        "p4": saleDate
      };
      Result result =
          await db.dbCon.execute(Sql.named(sql1), parameters: subValues);

      if (result.isEmpty) {
        _setErrDlgId(DlgConfirmMsgKind.MSG_OPENCLOSE_NOTREAD);
        _pCom.dbOpenClose = COpencloseMstColumns();
        return false;
      }
      Map<String, dynamic> data = result.first.toColumnMap();
      COpencloseMstColumns rn = COpencloseMstColumns();
      rn.comp_cd = int.parse(data['comp_cd']);
      rn.stre_cd = int.parse(data['stre_cd']);
      rn.mac_no = int.parse(data['mac_no']);
      rn.sale_date = (data['sale_date']).toString();
      rn.open_flg = data['open_flg'];
      rn.close_flg = data['close_flg'];
      rn.not_update_flg = data['not_update_flg'];
      rn.log_not_sndflg = data['log_not_sndflg'];
      rn.custlog_not_sndflg = data['custlog_not_sndflg'];
      rn.custlog_not_delflg = data['custlog_not_delflg'];
      rn.stepup_flg = data['stepup_flg'];
      rn.ins_datetime = (data['ins_datetime']).toString();
      rn.upd_datetime = (data['upd_datetime']).toString();
      rn.status = data['status'];
      rn.send_flg = data['send_flg'];
      rn.upd_user = int.parse(data['upd_user']);
      rn.upd_system = data['upd_system'];
      rn.pos_ver = data['pos_ver'];
      rn.pos_sub_ver = data['pos_sub_ver'];
      rn.recal_flg = data['recal_flg'];
      _pCom.dbOpenClose = rn;

      return true;
    } catch (e) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_OPENCLOSE_NOTREAD);
      return false;
    }
  }

  ///  関連tprxソース: rmdbread.c - rmDbTrmPlanRead()
  Future<bool> _rmDbTrmPlanRead() async {
    try {
      var db = DbManipulationPs();
      String sql =
          "select * from c_trm_plan_mst where comp_cd = ${_pCom.dbRegCtrl.compCd} AND stre_cd = '${_pCom.dbRegCtrl.streCd}'";
      Result result = await db.dbCon.execute(sql);

      if (result.isEmpty) {
        return false;
      }
      if (CntList.trmplanMax < result.length) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "_rmDbTrmPlanRead() : tuples num error [${result.length}]",
            errId: -1);
      }
      for (int i = 0; i < CntList.trmplanMax; i++) {
        if (result.length <= i) {
          _pCom.dbTrmPlan[i].acctCd = 0;
          _pCom.dbTrmPlan[i].acctFlg = 0;
          _pCom.dbTrmPlan[i].promoExtId = "";
        } else {
          Map<String, dynamic> data = result[i].toColumnMap();
          _pCom.dbTrmPlan[i].acctCd = int.parse(data["acct_cd"]);
          _pCom.dbTrmPlan[i].acctFlg = data["acct_flg"];
          _pCom.dbTrmPlan[i].promoExtId = data["promo_ext_id"];
        }
      }

      return true;
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "_rmDbTrmPlanRead() : $e $s]",
          errId: -1);
      return false;
    }
  }

  /// 従業員オープン情報マスタ読み込み
  ///  関連tprxソース: rmdbread.c - rmDbStaffopenRead()
  Future<bool> rmDbStaffopenRead() async {
    try {
      var db = DbManipulationPs();

      String sql1 = "select * from c_staffopen_mst where mac_no = @p1";
      Map<String, dynamic>? subValues = {"p1": _pCom.dbRegCtrl.macNo};
      Result result =
          await db.dbCon.execute(Sql.named(sql1), parameters: subValues);

      if (result.isEmpty) {
        _setErrDlgId(DlgConfirmMsgKind.MSG_STAFFOPEN_NOTREAD);
        // データがなかったので初期値にリセット.
        StaffAuth.SetStaffInfo(Tpraid.TPRAID_SYST, _pCom,
            StaffInfoIndex.STAFF_INFO_CASHIER, -1, "", 0);
        StaffAuth.SetStaffInfo(Tpraid.TPRAID_SYST, _pCom,
            StaffInfoIndex.STAFF_INFO_CHECKER, -1, "", 0);
        _pCom.dbStaffopen = CStaffopenMstColumns();
        return false;
      }
      Map<String, dynamic> data = result.first.toColumnMap();
      CStaffopenMstColumns rn = CStaffopenMstColumns();
      rn.comp_cd = int.parse(data['comp_cd']);
      rn.stre_cd = int.parse(data['stre_cd']);
      rn.mac_no = int.parse(data['mac_no']);
      try {
        rn.chkr_cd = int.parse(data['chkr_cd']);
      } catch(e) {
        rn.chkr_cd = null;
      }
      rn.chkr_name = data['chkr_name'];
      rn.chkr_status = data['chkr_status'];
      rn.chkr_open_time = (data['chkr_open_time']).toString();
      rn.chkr_start_no = int.parse(data['chkr_start_no']);
      rn.chkr_end_no = int.parse(data['chkr_end_no']);
      rn.cshr_cd = data['cshr_cd'];
      rn.cshr_name = data['cshr_name'];
      rn.cshr_status = data['cshr_status'];
      rn.cshr_open_time = (data['cshr_open_time']).toString();
      rn.cshr_start_no = int.parse(data['cshr_start_no']);
      rn.cshr_end_no = int.parse(data['cshr_end_no']);
      rn.ins_datetime = (data['ins_datetime']).toString();
      rn.upd_datetime = (data['upd_datetime']).toString();
      rn.status = data['status'];
      rn.send_flg = data['send_flg'];
      rn.upd_user = int.parse(data['upd_user']);
      rn.upd_system = data['upd_system'];
      _pCom.dbStaffopen = rn;

      //　キャッシャーの設定.
      if (_pCom.dbStaffopen.cshr_status != 0 ) {
        String cdStr = _pCom.dbStaffopen.cshr_cd ?? "";
        int cd = int.tryParse(cdStr) ?? 0;
        int level = await StaffAuth.getStaffAuth(
            Tpraid.TPRAID_SYST, _pCom.dbStaffopen.cshr_cd ?? "");
        StaffAuth.SetStaffInfo(
            Tpraid.TPRAID_SYST,
            _pCom,
            StaffInfoIndex.STAFF_INFO_CASHIER,
            level,
            _pCom.dbStaffopen.cshr_name,
            cd);
      } else {
        StaffAuth.SetStaffInfo(Tpraid.TPRAID_SYST, _pCom,
            StaffInfoIndex.STAFF_INFO_CASHIER, -1, "", 0);
      }
      // チェッカーの設定.
      if (_pCom.dbStaffopen.chkr_status != 0) {
        String cdStr = _pCom.dbStaffopen.cshr_cd ?? "";
        int cd = int.tryParse(cdStr) ?? 0;
        int level = await StaffAuth.getStaffAuth(
            Tpraid.TPRAID_SYST, _pCom.dbStaffopen.cshr_cd ?? "");
        StaffAuth.SetStaffInfo(
            Tpraid.TPRAID_SYST,
            _pCom,
            StaffInfoIndex.STAFF_INFO_CHECKER,
            level,
            _pCom.dbStaffopen.chkr_name,
            cd);
      } else {
        StaffAuth.SetStaffInfo(Tpraid.TPRAID_SYST, _pCom,
            StaffInfoIndex.STAFF_INFO_CHECKER, -1, "", 0);
      }

      return true;
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "_rmDbTrmPlanRead() : $e $s]",
          errId: -1);
      return false;
    }
  }

  /// インストアマーキングマスタ読み込み
  ///  関連tprxソース: rmdbread.c - rmDbInstreRead()
  Future<bool> _rmDbInstreRead() async {
    try {
      var db = DbManipulationPs();
      String sql1 =
          "select * from c_instre_mst where comp_cd = ${_pCom.dbRegCtrl.compCd}  order by format_typ";
      Result result = await db.dbCon.execute(sql1);

      List<CInstreMstColumns> dataList = List.generate(result.length, (i) {
        Map<String, dynamic> data = result[i].toColumnMap();
        CInstreMstColumns rn = CInstreMstColumns();
        rn.comp_cd = int.parse(data['comp_cd']);
        rn.instre_flg = data['instre_flg'];
        rn.format_no = int.parse(data['format_no']);
        rn.format_typ = int.parse(data['format_typ']);
        rn.cls_code = int.parse(data['cls_code']);
        rn.ins_datetime = (data['ins_datetime']).toString();
        rn.upd_datetime = (data['upd_datetime']).toString();
        rn.status = data['status'];
        rn.send_flg = data['send_flg'];
        rn.upd_user = int.parse(data['upd_user']);
        rn.upd_system = data['upd_system'];
        return rn;
      });

      _pCom.mbrcdLength = Mcd.DEF_MBRCD_LEN;
      _pCom.magcdLength = Mcd.ASC_MCD_CD;
      if (_pCom.dbTrm.crdtUserNo == 1) {
        // カスミ様
        _pCom.mbrcdLength = 14;
        _pCom.magcdLength = 14;
      }
      for (int i = 0; i < RxMem.DB_INSTRE_MAX; i++) {
        if (i < dataList.length) {
          _rmDbInstreDataSet(i, dataList[i]);
        } else {
          _rmDbInstreDataSet(i, null);
        }
      }

      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_INSTRE_NOTREAD);
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "_rmDbTrmPlanRead() : $e $s]",
          errId: -1);
      return false;
    }
  }

  ///  関連tprxソース: rmdbread.c - rmDbInstreDataSet()
  Future<bool> _rmDbInstreDataSet(int index, CInstreMstColumns? data) async {
    if (data == null) {
      _pCom.dbInstre[index] = CInstreMstColumns();
      return true;
    }
    _pCom.dbInstre[index] = data;

    if (await CmCksys.cmEdyNoMbrSystem() != 0) {
      _pCom.mbrcdLength = 16;
      return true;
    }
    if (CompileFlag.DEPARTMENT_STORE &&
        (await CmCksys.cmDepartmentStoreSystem() != 0)) {
      _pCom.mbrcdLength = 16;
      return true;
    }
    if (_pCom.dbTrm.loasonNw7mbr > 0) {
      _pCom.mbrcdLength = 15;
      return true;
    }
    if (await CmCksys.cmDcmpointSystem() != 0) {
      _pCom.mbrcdLength = 16;
      _pCom.magcdLength = 16;
      return true;
    }
    if (await CmCksys.cmHitachiBluechipSystem() != 0) {
      _pCom.mbrcdLength = 19;
      return true;
    }
    if (await CmCksys.cmCustrealWebserSystem() != 0) {
      _pCom.mbrcdLength = 16;
      _pCom.magcdLength = 16;
      return true;
    }
    if (CmCksys.cmIKEASystem() != 0) {
      _pCom.mbrcdLength = 19;
      _pCom.magcdLength = 10;
      return true;
    }
    if (await CmCksys.cmCustrealOpSystem() != 0) {
      _pCom.mbrcdLength = 16;
      _pCom.magcdLength = 16;
      return true;
    }
    if (CmCksys.cmJAIwateSystem() != 0) {
      _pCom.mbrcdLength = 16;
      _pCom.magcdLength = 16;
      return true;
    }
    if (await CmCksys.cmIchiyamaMartSystem() != 0) {
      _pCom.mbrcdLength = 16;
      _pCom.magcdLength = 14;
      return true;
    }
    if (CmCksys.cmCustrealTpointSystem() != 0) {
      _pCom.mbrcdLength = 16;
      _pCom.magcdLength = 16;
      return true;
    }
    if (await CmCksys.cmMarutoSystem() != 0) {
      _pCom.mbrcdLength = 16;
      _pCom.magcdLength = 16;
      return true;
    }
    if (await CmCksys.cmZHQSystem() != 0) {
      _pCom.mbrcdLength = 16;
      return true;
    }
    if (await CmCksys.cmSm36SanprazaSystem() != 0) {
      _pCom.mbrcdLength = 13;
      _pCom.magcdLength = 13;
      return true;
    }
    if (await CmCksys.cmCustrealPtactixSystem() != 0) {
      _pCom.mbrcdLength = 19;
      _pCom.magcdLength = 19;
      return true;
    }
    if (await CmCksys.cmSm66FrestaSystem() != 0) {
      _pCom.mbrcdLength = 10;
      _pCom.magcdLength = 16;
      return true;
    }
    if (_pCom.dbInstre[index].format_typ != Mcd.FMT_TYP_MBR) {
      return true;
    }
    switch (_pCom.dbInstre[index].format_no) {
      case Mcd.FMT_NO_MBR8:
      case Mcd.FMT_NO_MBR13:
        if (CompileFlag.ARCS_MBR) {
          _pCom.mbrcdLength = Mcd.MBRCD16_LEN;
          _pCom.magcdLength = Mcd.ASC_MCD_CD_MBR16;
        } else {
          _pCom.mbrcdLength = Mcd.DEF_MBRCD_LEN;
        }
        if (_pCom.dbTrm.othcmpMagEfctNo >= 9) {
          _pCom.magcdLength = _pCom.dbTrm.othcmpMagEfctNo;
        } else {
          _pCom.magcdLength = Mcd.ASC_MCD_CD;
        }
        break;
      default:
        _pCom.mbrcdLength = 13;
        if (_pCom.dbTrm.othcmpMagEfctNo >= 9) {
          _pCom.magcdLength = _pCom.dbTrm.othcmpMagEfctNo;
        } else {
          _pCom.magcdLength = Mcd.ASC_MCD_CD;
        }
        break;
    }
    return true;
  }

  /// 税金テーブルマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbTaxRead()
  Future<bool> _rmDbTaxRead() async {
    try {
      var db = DbManipulationPs();
      String sql1 =
          "select * from c_tax_mst where tax_cd > 0 and comp_cd = ${_pCom.dbRegCtrl.compCd} order by tax_cd";
      Result result = await db.dbCon.execute(sql1);

      List<CTaxMstColumns> dataList = List.generate(result.length, (i) {
        Map<String, dynamic> data = result[i].toColumnMap();
        CTaxMstColumns rn = CTaxMstColumns();
        rn.comp_cd = int.parse(data['comp_cd']);
        rn.tax_cd = data['tax_cd'];
        rn.tax_name = data['tax_name'];
        rn.tax_typ = data['tax_typ'];
        rn.odd_flg = data['odd_flg'];
        rn.tax_per = double.parse(data['tax_per']);
        rn.mov_cd = data['mov_cd'];
        rn.ins_datetime = (data['ins_datetime']).toString();
        rn.upd_datetime = (data['upd_datetime']).toString();
        rn.status = data['status'];
        rn.send_flg = data['send_flg'];
        rn.upd_user = int.parse(data['upd_user']);
        rn.upd_system = data['upd_system'];
        return rn;
      });

      for (int i = 0; i < RxMem.DB_TAX_MAX; i++) {
        if (dataList.length <= i) {
          break;
        }
        CTaxMstColumns data = dataList[i];
        _pCom.dbTax[data.tax_cd! - 1] = data;
      }
      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_TAX_NOTREAD);
      return false;
    }
  }

  /// レシートメッセージ, 及び, FIPメッセージの読み込み
  /// 関連tprxソース: rmdbread.c - rmDbRecmsgRead()
  Future<bool> _rmDbRecmsgRead() async {
    try {
      var db = DbManipulationPs();
      String sql = '''
         SELECT 
		 lay.comp_cd AS comp_cd, lay.stre_cd AS stre_cd, lay.msggrp_cd AS msggrp_cd, lay.msg_typ AS msg_typ, lay.msg_cd AS msg_cd, lay.target_typ AS target_typ, 
		 msg.msg_kind AS msg_kind, msg.msg_data_1 AS msg_data_1, msg.msg_data_2 AS msg_data_2, 
		 msg.msg_data_3 AS msg_data_3, msg.msg_data_4 AS msg_data_4, msg.msg_data_5 AS msg_data_5, 
		 msg.ins_datetime AS ins_datetime, msg.upd_datetime AS upd_datetime, msg.status AS status, 
		 msg.send_flg AS send_flg, msg.upd_user AS upd_user, msg.upd_system AS upd_system 

		 , msg.msg_size_1 AS msg_size_1, msg.msg_size_2 AS msg_size_2, msg.msg_size_3 AS msg_size_3, msg.msg_size_4 AS msg_size_4, msg.msg_size_5 AS msg_size_5 
		 , msg.msg_color_1 AS msg_color_1, msg.msg_color_2 AS msg_color_2, msg.msg_color_3 AS msg_color_3, msg.msg_color_4 AS msg_color_4, msg.msg_color_5 AS msg_color_5 
		 , msg.back_color AS back_color, msg.back_pict_typ AS back_pict_typ 
		 , msg.second AS second, msg.flg_01 AS flg_01, msg.flg_02 AS flg_02, msg.flg_03 AS flg_03, msg.flg_04 AS flg_04, msg.flg_05 AS flg_05 

		 FROM c_msglayout_mst lay LEFT OUTER JOIN c_msg_mst msg 
		 ON lay.comp_cd = msg.comp_cd AND lay.stre_cd = msg.stre_cd AND lay.msg_cd = msg.msg_cd 
		 WHERE lay.comp_cd = '${_pCom.iniMacInfoCrpNoNo}' AND lay.stre_cd = '${_pCom.iniMacInfoShopNo}' AND lay.msggrp_cd = '${_pCom.dbRegCtrl.msgGrpCd}' ORDER BY lay.msg_typ	
         ''';

      Result result = await db.dbCon.execute(sql);

      // List<Map<String, dynamic>> dataList =
      //     await dbAccess.database.rawQuery(sql);
      int loopMax = min(
          result.length,
          DbMsgMstId.DB_MSGMST_MAX +
              DbMsgMstFipId.DB_MSGMST_FIP_MAX +
              DbMsgMstColorDspId.DB_MSGMST_COLORDSP_MAX +
              1);

      for (int i = 0; i < loopMax; i++) {
        _setDBMsgDataToMemory(result[i].toColumnMap());
      }
      return true;
    } catch (e, s) {
      TprLog().logAdd(
        Tpraid.TPRAID_SYST,
        LogLevelDefine.error,
        "_rmDbRecmsgRead() : $e $s )",
      );
      _setErrDlgId(DlgConfirmMsgKind.MSG_RECMSG_NOTREAD);
      return false;
    }
  }

  /// レシートメッセージ, 及び, FIPメッセージのスケジュール読み込み
  /// メッセージレイアウトマスタで取得した情報にスケジュール情報を上書きする
  /// 関連tprxソース: rmdbread.c - rmDbRecmsgSchRead()
  Future<bool> _rmDbRecmsgSchRead() async {
    try {
      var db = DbManipulationPs();
      String whereSql =
          RcSch.rcSchPrioritySqlCreate("msgsch_cd", null, null, null);
      String sql = '''
      SELECT 
		  lay.comp_cd AS comp_cd, lay.stre_cd AS stre_cd, lay.msgsch_cd as msgsch_cd, lay.msggrp_cd AS msggrp_cd, lay.msg_typ AS msg_typ, lay.msg_cd AS msg_cd, lay.target_typ AS target_typ, 
		  msg.msg_kind AS msg_kind, msg.msg_data_1 AS msg_data_1, msg.msg_data_2 AS msg_data_2, 
		  msg.msg_data_3 AS msg_data_3, msg.msg_data_4 AS msg_data_4, msg.msg_data_5 AS msg_data_5, 
		  msg.ins_datetime AS ins_datetime, msg.upd_datetime AS upd_datetime, msg.status AS status, 
		  msg.send_flg AS send_flg, msg.upd_user AS upd_user, msg.upd_system AS upd_system 

		 , msg.msg_size_1 AS msg_size_1, msg.msg_size_2 AS msg_size_2, msg.msg_size_3 AS msg_size_3, msg.msg_size_4 AS msg_size_4, msg.msg_size_5 AS msg_size_5 
		 , msg.msg_color_1 AS msg_color_1, msg.msg_color_2 AS msg_color_2, msg.msg_color_3 AS msg_color_3, msg.msg_color_4 AS msg_color_4, msg.msg_color_5 AS msg_color_5 
		 , msg.back_color AS back_color, msg.back_pict_typ AS back_pict_typ 
		 , msg.second AS second, msg.flg_01 AS flg_01, msg.flg_02 AS flg_02, msg.flg_03 AS flg_03, msg.flg_04 AS flg_04, msg.flg_05 AS flg_05 

		FROM 
		  c_msgsch_layout_mst lay 
		LEFT OUTER JOIN 
		  c_msg_mst msg 
		ON 
		  lay.comp_cd = msg.comp_cd AND lay.stre_cd = msg.stre_cd AND lay.msg_cd = msg.msg_cd 
		WHERE 
		  lay.comp_cd = '${_pCom.iniMacInfoCrpNoNo}' AND lay.stre_cd = '${_pCom.iniMacInfoShopNo}' AND lay.stop_flg = 0 AND lay.msggrp_cd = '${_pCom.dbRegCtrl.msgGrpCd}' 
		  AND lay.msgsch_cd IN (SELECT msgsch_cd FROM c_msgsch_mst WHERE $whereSql) 
		ORDER BY lay.msg_typ 
      ''';

      Result result = await db.dbCon.execute(sql);

      int loopMax = min(
          result.length,
          DbMsgMstId.DB_MSGMST_MAX +
              DbMsgMstFipId.DB_MSGMST_FIP_MAX +
              DbMsgMstColorDspId.DB_MSGMST_COLORDSP_MAX +
              1);
      if (result.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
            "_rmDbRecmsgSchRead() : msgsch read empty");
        return false;
      }
      Map<String,dynamic> firstData = result.first.toColumnMap();
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "_rmDbRecmsgSchRead() : msgsch read. cd is [${firstData["msgsch_cd"]?.toString()}]");
      for (int i = 0; i < loopMax; i++) {
        Map<String, dynamic> data = result[i].toColumnMap();
        _setDBMsgDataToMemory(data);
      }

      return true;
    } catch (e, s) {
      TprLog().logAdd(
        Tpraid.TPRAID_SYST,
        LogLevelDefine.error,
        "_rmDbRecmsgSchRead() : $e $s )",
      );
      _setErrDlgId(DlgConfirmMsgKind.MSG_RECMSG_NOTREAD);
      return false;
    }
  }

  /// キーファンクションマスタ, キーオプションマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbKeyFncRead()
  Future<bool> rmDbKeyFncRead() async {
    try {
      var db = DbManipulationPs();
      String whereSql =
          RcSch.rcSchPrioritySqlCreate("msgsch_cd", null, null, null);
      String sql = "";
      // c_keyfnc_mst ------
      if (!CompileFlag.DB_SUB_GROUP || _pCom.dbRegCtrl.koptGrpCd == 1) {
        // グループ1:基本グループ
        sql =
            "SELECT kopt_grp_cd,fnc_cd,fnc_name,fnc_disp_flg FROM c_keyfnc_mst WHERE comp_cd = '${_pCom.dbRegCtrl.compCd}' AND stre_cd = '${_pCom.dbRegCtrl.streCd}' AND kopt_grp_cd = '${_pCom.dbRegCtrl.koptGrpCd}'";
      } else {
        // グループ2以上:基本グループと異なる設定データのみ保持
        // updateをしない場合にはright joinとleftjoinを組み合わせる

        sql = '''
        SELECT
    case when another.kopt_grp_cd is not NULL then another.kopt_grp_cd else base.kopt_grp_cd end as kopt_grp_cd,
    case when another.kopt_grp_cd is not NULL then another.fnc_cd else base.fnc_cd end as fnc_cd,
    case when another.kopt_grp_cd is not NULL then another.fnc_name else base.fnc_name end as fnc_name,
    case when another.kopt_grp_cd is not NULL then another.fnc_disp_flg else base.fnc_disp_flg end as fnc_disp_flg
    FROM
    (
    (select kopt_grp_cd, fnc_cd, fnc_name, fnc_disp_flg from c_keyfnc_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and  stre_cd = '${_pCom.dbRegCtrl.streCd}' and  kopt_grp_cd = '1') as base
         full outer join
         (select kopt_grp_cd, fnc_cd, fnc_name, fnc_disp_flg from c_keyfnc_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and  stre_cd = '${_pCom.dbRegCtrl.streCd}' and  kopt_grp_cd = '${_pCom.dbRegCtrl.koptGrpCd}') as another
         ON (base.fnc_cd = another.fnc_cd)
        )
        ORDER BY kopt_grp_cd, fnc_cd
            ''';
      }

      // List<Map<String, dynamic>> dataList =
      //     await dbAccess.database.rawQuery(sql);
      Result result = await db.dbCon.execute(sql);
      int subGrpCount = 0;
      // DBの値が正しくとれているかどうか.
      bool isSuccess = true;
      // for (var data in dataList) {
      for (int i = 0; i < result.length; i++) {
        Map<String, dynamic> data = result[i].toColumnMap();
        DBMapChangeRet<int> koptGrpCdRet =
            getIntValueFromDbMapRet(data["kopt_grp_cd"]);
        isSuccess &= koptGrpCdRet.isSuccess;
        if (koptGrpCdRet.value == _pCom.dbRegCtrl.koptGrpCd) {
          subGrpCount++;
        }
        DBMapChangeRet<int> fCdRet = getIntValueFromDbMapRet(data["fnc_cd"]);
        isSuccess &= fCdRet.isSuccess;
        if (fCdRet.value <= 0 || FuncKey.keyMax <= fCdRet.value) {
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
              "rmDbKeyFncRead : fnc_cd error ",
              errId: -1);
          continue;
        }
        if (isSuccess) {
          _pCom.dbKfnc[fCdRet.value].fncCd = fCdRet.value;
          DBMapChangeRet<bool> fDspFlgRet =
              getBoolValueFromDbMapIntValueRet(data["fnc_disp_flg"]);
          isSuccess &= fDspFlgRet.isSuccess;
          _pCom.dbKfnc[fCdRet.value].fncDispFlg = fDspFlgRet.value;
          DBMapChangeRet<String> fNameRet =
              getStringValueFromDbMapRet(data["fnc_name"]);
          isSuccess &= fNameRet.isSuccess;
          _pCom.dbKfnc[fCdRet.value].fncName = fNameRet.value;
        }
      }
      TprLog().logAdd(
        Tpraid.TPRAID_SYST,
        LogLevelDefine.normal,
        "rmDbKeyFncRead() : keyfnc tuple [${result.length}] sub_grp( cd[${_pCom.dbRegCtrl.koptGrpCd}] cnt[$subGrpCount] )",
      );
      if (!isSuccess) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rmDbKeyFncRead() : c_keyfnc_mst error ",
            errId: -1);
        _setErrDlgId(DlgConfirmMsgKind.MSG_KOPTTRN_NOTREAD);
        return false;
      }

      // c_keyopt_mst ------
      if (!CompileFlag.DB_SUB_GROUP || _pCom.dbRegCtrl.koptGrpCd == 1) {
        // グループ1:基本グループ
        sql =
            "SELECT  kopt_grp_cd,fnc_cd,kopt_cd,kopt_data,kopt_str_data FROM c_keyopt_mst WHERE comp_cd = '${_pCom.dbRegCtrl.compCd}' AND stre_cd = '${_pCom.dbRegCtrl.streCd}' AND kopt_grp_cd = '${_pCom.dbRegCtrl.koptGrpCd}'";
      } else {
        // グループ2以上:基本グループと異なる設定データのみ保持

        sql = '''
          SELECT
			 case when another.kopt_grp_cd is not NULL then another.kopt_grp_cd else base.kopt_grp_cd end as kopt_grp_cd,
			 case when another.kopt_grp_cd is not NULL then another.fnc_cd else base.fnc_cd end as fnc_cd,
			 case when another.kopt_grp_cd is not NULL then another.kopt_cd else base.kopt_cd end as kopt_cd,
			 case when another.kopt_grp_cd is not NULL then another.kopt_data else base.kopt_data end as kopt_data,
			 case when another.kopt_grp_cd is not NULL then another.kopt_str_data else base.kopt_str_data end as kopt_str_data
			FROM
			(
			 (select kopt_grp_cd, fnc_cd, kopt_cd, kopt_data, kopt_str_data from c_keyopt_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and  stre_cd = '${_pCom.dbRegCtrl.streCd}' and  kopt_grp_cd = '1') as base
			  full outer join
			 (select kopt_grp_cd, fnc_cd, kopt_cd, kopt_data, kopt_str_data from c_keyopt_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and  stre_cd = '${_pCom.dbRegCtrl.streCd}' and  kopt_grp_cd = '${_pCom.dbRegCtrl.koptGrpCd}') as another
			  ON (base.fnc_cd = another.fnc_cd AND base.kopt_cd = another.kopt_cd)
			)
			ORDER BY kopt_grp_cd, fnc_cd, kopt_cd;
            ''';
      }
      int kyOptSubGroupCount = 0;

      Result kyOptList = await db.dbCon.execute(sql);
      // List<Map<String, dynamic>> kyOptList =
      //     await dbAccess.database.rawQuery(sql);
      // for (var data in kyOptList) {
      for (int i = 0; i < kyOptList.length; i++) {
        Map<String, dynamic> data = kyOptList[i].toColumnMap();
        bool isSuccessKyOpt = true;
        DBMapChangeRet<int> grpCd =
            getIntValueFromDbMapRet(data["kopt_grp_cd"]);
        isSuccessKyOpt &= grpCd.isSuccess;
        if (grpCd.value == _pCom.dbRegCtrl.koptGrpCd) {
          kyOptSubGroupCount++;
        }

        DBMapChangeRet<int> fncCd = getIntValueFromDbMapRet(data["fnc_cd"]);
        isSuccessKyOpt &= fncCd.isSuccess;
        if (!isSuccessKyOpt) {
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
              "rmDbKeyFncRead() : c_keyopt_mst error fncCd",
              errId: -1);
          break;
        }
        isSuccessKyOpt &=
            _pCom.dbKfnc[fncCd.value].opt.setDataFromDBMap(_pCom, data);
        if (!isSuccessKyOpt) {
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
              "rmDbKeyFncRead() : c_keyopt_mst error ",
              errId: -1);
          break;
        }
      }
      TprLog().logAdd(
        Tpraid.TPRAID_SYST,
        LogLevelDefine.normal,
        "rmDbKeyFncRead() : keyopt tuple [${kyOptList.length}] sub_grp( cd[${_pCom.dbRegCtrl.koptGrpCd}] cnt[$kyOptSubGroupCount] )",
      );
      return true;
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "rmDbKeyFncRead() : $e $s )");
      _setErrDlgId(DlgConfirmMsgKind.MSG_KOPTTRN_NOTREAD);
      return false;
    }
  }

  /// キャッシュリサイクルマスタの読み込み.
  /// 関連tprxソース: rmdbread.c - rmDbCashrecycleRead()
  Future<bool> rmDbCashrecycleRead() async {
    try {
      var db = DbManipulationPs();
      String sql1 =
          "select * from c_cashrecycle_info_mst where comp_cd = ${_pCom.dbRegCtrl.compCd}  and stre_cd = '${_pCom.dbRegCtrl.streCd}' and mac_no = '${_pCom.dbRegCtrl.macNo}'";
      Result result = await db.dbCon.execute(sql1);

      if (result.length > 1) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rmDbCashrecycleRead(): tuples not match[${result.length}]");
        _setErrDlgId(DlgConfirmMsgKind.MSG_CASHRECYCLE_NOTREAD);
        return false;
      }
      int cashrecycleGrp = 0;
      if (result.length == 1) {
        Map<String, dynamic> data = result.first.toColumnMap();
        CCashrecycleInfoMstColumns rn = CCashrecycleInfoMstColumns();
        rn.comp_cd = int.parse(data['comp_cd']);
        rn.stre_cd = int.parse(data['stre_cd']);
        rn.mac_no = int.parse(data['mac_no']);
        rn.cashrecycle_grp = int.parse(data['cashrecycle_grp']);
        rn.cal_grp_cd = int.parse(data['cal_grp_cd']);
        rn.server = data['server'];
        rn.server_macno = int.parse(data['server_macno']);
        rn.server_info = data['server_info'];
        rn.sub_server = data['sub_server'];
        rn.sub_server_macno = int.parse(data['sub_server_macno']);
        rn.sub_server_info = data['sub_server_info'];
        rn.first_disp_macno1 = int.parse(data['first_disp_macno1']);
        rn.first_disp_macno2 = int.parse(data['first_disp_macno2']);
        rn.first_disp_macno3 = int.parse(data['first_disp_macno3']);
        rn.ins_datetime = (data['ins_datetime']).toString();
        rn.upd_datetime = (data['upd_datetime']).toString();
        rn.status = data['status'];
        rn.send_flg = data['send_flg'];
        rn.upd_user = int.parse(data['upd_user']);
        rn.upd_system = data['upd_system'];
        _pCom.dbCashrecycle.cashrycycleInfo = rn;
        cashrecycleGrp = _pCom.dbCashrecycle.cashrycycleInfo.cashrecycle_grp;
      } else {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rmDbCashrecycleRead(): tuples is 0");
      }

      if (cashrecycleGrp == 0) {
        cashrecycleGrp = 1;
      }

      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "rmDbCashrecycleRead(): Get set_grp[$cashrecycleGrp], cal_grp[${_pCom.dbCashrecycle.cashrycycleInfo.cal_grp_cd}]");
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "rmDbCashrecycleRead():  Get Server[${_pCom.dbCashrecycle.cashrycycleInfo.server}][${_pCom.dbCashrecycle.cashrycycleInfo.server_macno}][${_pCom.dbCashrecycle.cashrycycleInfo.server_info}]");
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "rmDbCashrecycleRead(): Get Sub Server[${_pCom.dbCashrecycle.cashrycycleInfo.sub_server}][${_pCom.dbCashrecycle.cashrycycleInfo.sub_server_macno}][${_pCom.dbCashrecycle.cashrycycleInfo.sub_server_info}]");
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "rmDbCashrecycleRead(): Get first show macno[${_pCom.dbCashrecycle.cashrycycleInfo.first_disp_macno1}][${_pCom.dbCashrecycle.cashrycycleInfo.first_disp_macno2}][${_pCom.dbCashrecycle.cashrycycleInfo.first_disp_macno3}]");

      String cashrecycleMstSql =
          "SELECT code, data, data_typ FROM c_cashrecycle_mst WHERE comp_cd = ${_pCom.dbRegCtrl.compCd}  and stre_cd = '${_pCom.dbRegCtrl.streCd}' and cashrecycle_grp ='$cashrecycleGrp' order by code";

      Result cashrecycleMstDataList = await db.dbCon.execute(cashrecycleMstSql);

      if (cashrecycleMstDataList.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rmDbCashrecycleRead():  c_cashrecycle_mst tuples is 0");
        _setErrDlgId(DlgConfirmMsgKind.MSG_CASHRECYCLE_NOTREAD);
        return false;
      }
      for (int i = 0; i < cashrecycleMstDataList.length; i++) {
        Map<String, dynamic> data = cashrecycleMstDataList[i].toColumnMap();
        DBMapChangeRet<int> codeRet = getIntValueFromDbMapRet(data["code"]);
        DBMapChangeRet<int> dataRet = getIntValueFromDbMapRet(data["data"]);
        if (!codeRet.isSuccess || !dataRet.isSuccess) {
          _setErrDlgId(DlgConfirmMsgKind.MSG_CASHRECYCLE_NOTREAD);
          return false;
        }
        _pCom.dbCashrecycle
            .setValueCashrycycleMst(codeRet.value, dataRet.value);
      }

      TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.normal,
          sprintf(
              "rmDbCashrecycleRead(): btn_often_show[%d] btn_color[%d], btn_color_alert[%d] allot_method[%d]",
              [
                _pCom.dbCashrecycle.btnOftenShow,
                _pCom.dbCashrecycle.btnColor,
                _pCom.dbCashrecycle.btnColorAlert,
                _pCom.dbCashrecycle.allotMethod
              ]));
      TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.normal,
          sprintf(
              "          roll_unit[%d]  [%d][%d][%d][%d][%d][%d][%d][%d][%d][%d]",
              [
                _pCom.dbCashrecycle.rollUnitInout,
                _pCom.dbCashrecycle.rollUnit10000,
                _pCom.dbCashrecycle.rollUnit5000,
                _pCom.dbCashrecycle.rollUnit2000,
                _pCom.dbCashrecycle.rollUnit1000,
                _pCom.dbCashrecycle.rollUnit500,
                _pCom.dbCashrecycle.rollUnit100,
                _pCom.dbCashrecycle.rollUnit50,
                _pCom.dbCashrecycle.rollUnit10,
                _pCom.dbCashrecycle.rollUnit5,
                _pCom.dbCashrecycle.rollUnit1
              ]));
      TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.normal,
          sprintf(
              "          keep_sht[%d] [%d][%d][%d][%d][%d][%d][%d][%d][%d]", [
            _pCom.dbCashrecycle.keepSht,
            _pCom.dbCashrecycle.keepSht5000,
            _pCom.dbCashrecycle.keepSht2000,
            _pCom.dbCashrecycle.keepSht1000,
            _pCom.dbCashrecycle.keepSht500,
            _pCom.dbCashrecycle.keepSht100,
            _pCom.dbCashrecycle.keepSht50,
            _pCom.dbCashrecycle.keepSht10,
            _pCom.dbCashrecycle.keepSht5,
            _pCom.dbCashrecycle.keepSht1
          ]));
      TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.normal,
          sprintf(
              "          btn_sht_show[%d] rcp_prn[%d] conf_stamp_prn[%d] staff_input[%d] rein_prn[%d]",
              [
                _pCom.dbCashrecycle.btnShtShow,
                _pCom.dbCashrecycle.rcpPrn,
                _pCom.dbCashrecycle.confStampPrn,
                _pCom.dbCashrecycle.staffInput,
                _pCom.dbCashrecycle.reinPrn
              ]));
      TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.normal,
          sprintf("          cin_cncl[%d] cchg[%d] man_inout[%d]", [
            _pCom.dbCashrecycle.cinCncl,
            _pCom.dbCashrecycle.cchg,
            _pCom.dbCashrecycle.manInout
          ]));
      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_CASHRECYCLE_NOTREAD);
      return false;
    } finally {
      LibFbMemo.tmemoReadFlgSet(Tpraid.TPRAID_SYST, null, _pCom);
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "rmDbCashrecycleRead(): End");
    }
  }

  /// 本体メカキープリセットマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbPresetMkey1Read()
  Future<bool> rmDbPresetMkey1Read() async {
    try {
      bool isSuccess = true;
      var db = DbManipulationPs();
      int presetCd = RxMemKey.getPresetCdFromKeyD(_pCom.mkeyD);
      _pCom.preMk = MkeyInfo();

      String sql =
          "select  ky_cd, ky_plu_cd, ky_smlcls_cd, ky_name   from c_preset_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and stre_cd = '${_pCom.dbRegCtrl.streCd}' and preset_grp_cd = '${_pCom.dbRegCtrl.presetGrpCd}' and preset_cd = '$presetCd'  order by preset_no";
      Result result = await db.dbCon.execute(sql);

      // データ数チェック.
      int max = RxMemKey.getMkeyMaxFromKey(_pCom.mkeyD);
      _pCom.preMk.row = RxMemKey.getRowFromKey(_pCom.mkeyD);
      _pCom.preMk.line = RxMemKey.getLineFromKey(_pCom.mkeyD);
      if (_pCom.mkeyD == RxMemKey.KEYTYPE_84 ||
          _pCom.mkeyD == RxMemKey.KEYTYPE_68 ||
          _pCom.mkeyD == RxMemKey.KEYTYPE_52 ||
          _pCom.mkeyD == RxMemKey.KEYTYPE_35) {
        if (await CmCksys.cmPresetMkeyShow() != 0) {
          _rmFBSoftKeyNoSet(_pCom.mkeyD);
          _pCom.preMk.keyMax = min(RxMem.PRESET_MKEY_MAX, max);
          for (int i = 0; i < _pCom.preMk.keyMax; i++) {
            _pCom.preMk.preMkInfo[i].presetColor =
                FbColorGroup.MediumGray.index;
            _pCom.preMk.preMkInfo[i].kyName = "";
          }
        }
      }
      if (result.length < max) {
        isSuccess = false;
        TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.error,
          "rmDbPresetMkey1Read()  Count ERROR [${result.length}($max)]",
        );
      }
      int loopMax = min(max, result.length);
      List<RmComPre>? keyList = RmCommon().getPreListKeyTypeD(_pCom.mkeyD);
      if (keyList == null) {
        TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.error,
          "rmDbPresetMkey1Read()  Unknown Desktop KeyType:[${_pCom.mkeyD}]",
        );
        return false;
      }
      for (int i = 0; i < loopMax; i++) {
        Map<String, dynamic> data = result[i].toColumnMap();

        String tmpPluCd = '';
        // メカキーの PLU CODEが NULLか0ならNULLをセット
        DBMapChangeRet<int> tmpCdRet =
            getIntValueFromDbMapRet(data["ky_plu_cd"]);
        if (tmpCdRet.isSuccess && tmpCdRet.value != 0) {
          tmpPluCd = getStringValueFromDbMap(data["ky_plu_cd"]);
        }

        keyList[i].kyCd = getIntValueFromDbMap(data["ky_cd"]);
        keyList[i].kyPluCd = tmpPluCd;
        keyList[i].kySmlclsCd = getIntValueFromDbMap(data["ky_smlcls_cd"]);

        if (await CmCksys.cmPresetMkeyShow() != 0) {
          _rmFBPreMkeySet(_pCom.mkeyD, data);
        }
      }
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "メカキー ${_pCom.mkeyD} [${keyList[0].kyCd - keyList[keyList.length - 1].kyCd}]");

      if (!isSuccess) {
        return false;
      }
      return true;
    } catch (e, s) {
      TprLog().logAdd(
        Tpraid.TPRAID_SYST,
        LogLevelDefine.error,
        "rmDbPresetMkey1Read() : $e $s )",
      );
      if (_pCom.mkeyD == RxMemKey.KEYTYPE_30 ||
          _pCom.mkeyD == RxMemKey.KEYTYPE_30_23) {
        _setErrDlgId(DlgConfirmMsgKind.MSG_JRMEK1PRESET_NOTREAD);
      } else {
        _setErrDlgId(DlgConfirmMsgKind.MSG_MEK1PRESET_NOTREAD);
      }

      return false;
    }
  }

  /// タワーメカキープリセットマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbPresetMkey2Read()
  Future<bool> rmDbPresetMkey2Read() async {
    try {
      var db = DbManipulationPs();
      int presetCd = RxMemKey.getPresetCdFromKeyT(_pCom.mkeyT);
      _pCom.preMk = MkeyInfo();

      String sql =
          "select  ky_cd, ky_plu_cd, ky_smlcls_cd from c_preset_mst where comp_cd = '${_pCom.dbRegCtrl.compCd}' and stre_cd = '${_pCom.dbRegCtrl.streCd}' and preset_grp_cd = '${_pCom.dbRegCtrl.presetGrpCd}' and preset_cd = '$presetCd'  order by preset_no";
      Result result = await db.dbCon.execute(sql);

      // データ数チェック.
      int max = RxMemKey.getMkeyMaxFromKey(_pCom.mkeyT, isTower: true);

      if (result.length < max) {
        TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.error,
          "rmDbPresetMkey2Read()  Count ERROR [${result.length}($max)]",
        );
      }
      int loopMax = min(max, result.length);
      List<RmComPre>? keyList = RmCommon().getPreListKeyTypeT(_pCom.mkeyT);
      if (keyList == null) {
        TprLog().logAdd(
          Tpraid.TPRAID_SYST,
          LogLevelDefine.error,
          "rmDbPresetMkey2Read()  Unknown Tower KeyType:[${_pCom.mkeyT}]",
        );
        return false;
      }
      // プリセットテーブルにデータを書き込み
      for (int i = 0; i < loopMax; i++) {
        Map<String, dynamic> data = result[i].toColumnMap();
        ;
        String? tmpPluCd = '';
        // メカキーの PLU CODEが NULLか0ならNULLをセット
        DBMapChangeRet<int> tmpCdRet =
            getIntValueFromDbMapRet(data["ky_plu_cd"]);
        if (tmpCdRet.isSuccess && tmpCdRet.value != 0) {
          tmpPluCd =
              getStringValueFromDbMap(data["ky_plu_cd"]);
        }
        keyList[i].kyCd = getIntValueFromDbMap(data["ky_cd"]);
        keyList[i].kyPluCd = tmpPluCd;
        keyList[i].kySmlclsCd =
            getIntValueFromDbMap(data["ky_smlcls_cd"]);
      }
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "メカキー ${_pCom.mkeyD} [${keyList[0].kyCd - keyList[keyList.length - 1].kyCd}]");

      return true;
    } catch (e, s) {
      TprLog().logAdd(
        Tpraid.TPRAID_SYST,
        LogLevelDefine.error,
        "rmDbPresetMkey2Read() : $e $s )",
      );
      _setErrDlgId(DlgConfirmMsgKind.MSG_MEK2PRESET_NOTREAD);

      return false;
    }
  }

  /// 自動開閉店マスタの読み込み
  /// 関連tprxソース: rmdbread.c - rmDbStropnclsRead()
  Future<bool> rmDbStropnclsRead() async {
    try {
      // TODO:10058 自動開閉店
      return true;
    } catch (e, s) {
      TprLog().logAdd(
        Tpraid.TPRAID_SYST,
        LogLevelDefine.error,
        "rmDbStropnclsRead() : $e $s )",
      );
      _setErrDlgId(DlgConfirmMsgKind.MSG_MEK2PRESET_NOTREAD);

      return false;
    }
  }

  /// ダイアログマスタの読み込み
  /// 関連tprxソース: rmdbread.c - rmDbDialogRead()
  Future<bool> rmDbDialogRead() async {
    try {
      // TODO:10075 メッセージデータのテキスト管理
      // 関連:TprLibMsgGet()
      // DBからメッセージデータを読み込んでtxtに出力し、表示などではテキストからメッセージを読んでいる.
      // Flutterでのやり方は要検討.
      return true;
    } catch (e, s) {
      return false;
    }
  }

  ///  関連tprxソース: rmdbread.c- rmFBPreMkey_Set()
  void _rmFBPreMkeySet(int id, Map<String, dynamic> data) {
    if (id >= RxMem.PRESET_MKEY_MAX) {
      return;
    }
    int kyCd = getIntValueFromDbMap(data["ky_cd"]);
    if (kyCd <= 0) {
      _pCom.preMk.preMkInfo[id].presetColor = FbColorGroup.MediumGray.index;
      _pCom.preMk.preMkInfo[id].kyName = "";
      return;
    }
    int kySmlClsCd = getIntValueFromDbMap(data["ky_smlcls_cd"]);
    int kyPlu = getIntValueFromDbMap(data["ky_plu_cd"]);
    String imgBuf = "";
    if (kyPlu > 0 || kySmlClsCd > 0) {
      imgBuf = getStringValueFromDbMap(data["ky_name"]);
    } else {
      EucAdj adf = AplLibImgRead.aplLibImgRead(kyCd);
      if (adf.byte == 0 && adf.count == 0) {
        imgBuf = ' ';
      }
      imgBuf = AplLibOther.prgPresetSetReturn2(imgBuf);
      _pCom.preMk.preMkInfo[id].kyName = imgBuf;
      _pCom.preMk.preMkInfo[id].presetColor =
          FuncColorDefine().getFuncColorCdFromKeyId(kyCd);
    }
  }

  ///  関連tprxソース: rmdbread.c- rmFBSoftKeyNo_Set()
  void _rmFBSoftKeyNoSet(int type) {
    if (type == RxMemKey.KEYTYPE_84) {
      _pCom.preMk.softKeyNo[0] = 22;
      _pCom.preMk.softKeyNo[1] = 23;
      _pCom.preMk.softKeyNo[2] = 24;
      _pCom.preMk.softKeyNo[3] = 25;
      _pCom.preMk.softKeyNo[4] = 26;
      _pCom.preMk.softKeyNo[5] = 27;
      _pCom.preMk.softKeyNo[6] = 29;
      _pCom.preMk.softKeyNo[7] = 36;
    } else {
      _pCom.preMk.softKeyNo[0] = 20;
      _pCom.preMk.softKeyNo[1] = 24;
      _pCom.preMk.softKeyNo[2] = 25;
      _pCom.preMk.softKeyNo[3] = 26;
      _pCom.preMk.softKeyNo[4] = 40;
      _pCom.preMk.softKeyNo[5] = 41;
      _pCom.preMk.softKeyNo[6] = 42;
      _pCom.preMk.softKeyNo[7] = 43;
    }
  }

  ///  関連tprxソース: rmdbread.c- rmGetKoptcmnIdx(short)
  //実装は必要だがARKS対応では除外
  static int rmGetKoptcmnIdx(int){
    return 0;
  }
  
  /// DBから持ってきたmsgのDBデータマップを[_pCom]に格納する.
  void _setDBMsgDataToMemory(Map<String, dynamic> data) {
    int msgCd = getIntValueFromDbMap(data["msg_cd"]);
    if (msgCd <= 0) {
      return;
    }
    int grpCd = getIntValueFromDbMap(data["msggrp_cd"]);
    if (grpCd <= 0) {
      return;
    }
    int posi = getIntValueFromDbMap(data["msg_typ"], initValue: -1);
    if (posi <= -1) {
      return;
    }
    if (posi < DbMsgMstId.DB_MSGMST_MAX) {
      _pCom.dbRecMsg[posi].msg_cd = getIntValueFromDbMap(data["msg_cd"]);
      _pCom.dbRecMsg[posi].msg_kind = getIntValueFromDbMap(data["msg_kind"]);
      _pCom.dbRecMsg[posi].msg_data_1 =
          getStringValueFromDbMap(data["msg_data_1"]);
      _pCom.dbRecMsg[posi].msg_data_2 =
          getStringValueFromDbMap(data["msg_data_2"]);
      _pCom.dbRecMsg[posi].msg_data_3 =
          getStringValueFromDbMap(data["msg_data_3"]);
      _pCom.dbRecMsg[posi].msg_data_4 =
          getStringValueFromDbMap(data["msg_data_4"]);
      _pCom.dbRecMsg[posi].msg_data_5 =
          getStringValueFromDbMap(data["msg_data_5"]);
      _pCom.dbRecMsg[posi].msggrp_cd = getIntValueFromDbMap(data["msggrp_cd"]);
      _pCom.dbRecMsg[posi].msg_typ = getIntValueFromDbMap(data["msg_typ"]);
      _pCom.dbRecMsg[posi].target_typ =
          getIntValueFromDbMap(data["target_typ"]);
    } else if (DbMsgMstFipId.isFipPosi(posi)) {
      posi = DbMsgMstFipId.getIdFromPosi(posi);
      _pCom.dbRecMsg[posi].msg_cd = getIntValueFromDbMap(data["msg_cd"]);
      _pCom.dbRecMsg[posi].msg_kind = getIntValueFromDbMap(data["msg_kind"]);
      _pCom.dbRecMsg[posi].msg_data_1 =
          getStringValueFromDbMap(data["msg_data_1"]);
      _pCom.dbRecMsg[posi].msg_data_2 =
          getStringValueFromDbMap(data["msg_data_2"]);
      _pCom.dbRecMsg[posi].msg_data_3 =
          getStringValueFromDbMap(data["msg_data_3"]);
      _pCom.dbRecMsg[posi].msggrp_cd = getIntValueFromDbMap(data["msggrp_cd"]);
      _pCom.dbRecMsg[posi].msg_typ = getIntValueFromDbMap(data["msg_typ"]);
      _pCom.dbRecMsg[posi].target_typ =
          getIntValueFromDbMap(data["target_typ"]);
    } else if (DbMsgMstColorDspId.isColorFipPosi(posi)) {
      posi = DbMsgMstColorDspId.getIdFromPosi(posi);
      _pCom.dbRecMsg[posi].msg_cd = getIntValueFromDbMap(data["msg_cd"]);
      _pCom.dbRecMsg[posi].msg_kind = getIntValueFromDbMap(data["msg_kind"]);
      _pCom.dbRecMsg[posi].msg_data_1 =
          getStringValueFromDbMap(data["msg_data_1"]);
      _pCom.dbRecMsg[posi].msg_data_2 =
          getStringValueFromDbMap(data["msg_data_2"]);
      _pCom.dbRecMsg[posi].msg_data_3 =
          getStringValueFromDbMap(data["msg_data_3"]);
      _pCom.dbRecMsg[posi].msg_data_4 =
          getStringValueFromDbMap(data["msg_data_4"]);

      _pCom.dbRecMsg[posi].msggrp_cd = getIntValueFromDbMap(data["msggrp_cd"]);
      _pCom.dbRecMsg[posi].msg_typ = getIntValueFromDbMap(data["msg_typ"]);
      _pCom.dbRecMsg[posi].target_typ =
          getIntValueFromDbMap(data["target_typ"]);

      _pCom.dbRecMsg[posi].msg_size_1 =
          getIntValueFromDbMap(data["msg_size_1"]);
      _pCom.dbRecMsg[posi].msg_size_2 =
          getIntValueFromDbMap(data["msg_size_2"]);
      _pCom.dbRecMsg[posi].msg_size_3 =
          getIntValueFromDbMap(data["msg_size_3"]);
      _pCom.dbRecMsg[posi].msg_size_4 =
          getIntValueFromDbMap(data["msg_size_4"]);

      _pCom.dbRecMsg[posi].msg_color_1 =
          getIntValueFromDbMap(data["msg_color_1"]);
      _pCom.dbRecMsg[posi].msg_color_2 =
          getIntValueFromDbMap(data["msg_color_2"]);
      _pCom.dbRecMsg[posi].msg_color_3 =
          getIntValueFromDbMap(data["msg_color_3"]);
      _pCom.dbRecMsg[posi].msg_color_4 =
          getIntValueFromDbMap(data["msg_color_4"]);

      _pCom.dbRecMsg[posi].back_color =
          getIntValueFromDbMap(data["back_color"]);
      _pCom.dbRecMsg[posi].back_pict_typ =
          getIntValueFromDbMap(data["back_pict_typ"]);
      _pCom.dbRecMsg[posi].second = getIntValueFromDbMap(data["second"]);
      _pCom.dbRecMsg[posi].flg_01 = getIntValueFromDbMap(data["flg_01"]);
      _pCom.dbRecMsg[posi].flg_02 = getIntValueFromDbMap(data["flg_02"]);
      _pCom.dbRecMsg[posi].flg_03 = getIntValueFromDbMap(data["flg_03"]);
      _pCom.dbRecMsg[posi].flg_04 = getIntValueFromDbMap(data["flg_04"]);
      _pCom.dbRecMsg[posi].flg_05 = getIntValueFromDbMap(data["flg_05"]);
    }
  }

  //***************************************************************************************************
  //	DBから取得した値の加工.
  //***************************************************************************************************

  /// DBから取得した値をint型に直す
  /// nullだった場合はinitValueを返す.
  static int getIntValueFromDbMap(dynamic value, {int initValue = 0}) {
    DBMapChangeRet<int> result = getIntValueFromDbMapRet(value);
    return result.isSuccess ? result.value : initValue;
  }

  /// DBから取得した値をint型に直す
  /// nullだった場合はinitValueを返す.
  static String getStringValueFromDbMap(dynamic value,
      {String initValue = ""}) {
    DBMapChangeRet<String> result = getStringValueFromDbMapRet(value);
    return result.isSuccess ? result.value : initValue;
  }

  /// DBから取得した値をint型に直す
  /// nullだったりintに変換できなかった場合はDBMapChangeRet.isSuccessがfalseになる.
  static DBMapChangeRet<int> getIntValueFromDbMapRet(dynamic value) {
    if (value is int) {
      return DBMapChangeRet(value, true);
    }
    if (value is double) {
      return DBMapChangeRet(value.toInt(), true);
    }
    if (value == null) {
      return DBMapChangeRet(0, false);
    }
    int? result = int.tryParse(value);
    if (result == null) {
      return DBMapChangeRet(0, false);
    }
    return DBMapChangeRet(result, true);
  }

  /// DBから取得した値(数値)をbool型に直す
  /// 0より大きければtrue
  static DBMapChangeRet<bool> getBoolValueFromDbMapIntValueRet(dynamic value) {
    if (value is bool) {
      return DBMapChangeRet(value, true);
    }
    if (value is int) {
      return DBMapChangeRet(value > 0, true);
    }
    if (value == null) {
      return DBMapChangeRet(false, false);
    }
    int? result = int.tryParse(value);
    if (result == null) {
      return DBMapChangeRet(false, false);
    }
    bool isTrue = result > 0;
    return DBMapChangeRet(isTrue, true);
  }

  /// DBから取得した値(数値)をbool型に直す
  /// 0より大きければtrue
  static DBMapChangeRet<String> getStringValueFromDbMapRet(dynamic value) {
    if (value == null) {
      return DBMapChangeRet("", false);
    }
    return DBMapChangeRet(value, true);
  }
}

/// DBマップから[T]型へ変換した結果クラス.
class DBMapChangeRet<T> {
  /// 変換後の値
  T value;

  /// 変換成功したかどうか.
  bool isSuccess;

  DBMapChangeRet(this.value, this.isSuccess);
}
