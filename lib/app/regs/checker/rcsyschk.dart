/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos.dart';
import 'package:flutter_pos/app/regs/common/rx_log_calc.dart';
import 'package:flutter_pos/app/inc/lib/cm_sys.dart';
import 'package:flutter_pos/app/inc/lib/ean.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/inc/lib/if_fcl.dart';
import 'package:flutter_pos/app/inc/lib/jan_inf.dart';
import 'package:flutter_pos/app/inc/lib/mcd.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_auto.dart';
import 'package:flutter_pos/app/lib/apllib/cmd_func.dart';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:flutter_pos/app/lib/apllib/recog.dart';
import 'package:flutter_pos/app/lib/apllib/sio_chk.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cktwr.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_stf.dart';
import 'package:flutter_pos/app/lib/cm_jan/set_jinf.dart';
import '../../regs/checker/rc_qc_dsp.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_barcode_pay.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../regs/inc/rc_regs.dart';
import '../../regs/inc/rc_mem.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../common/rxkoptcmncom.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mbr.dart';
import 'rc_clxos.dart';
import 'rc_ifevent.dart';
import 'rc_mbr_com.dart';
import 'rc_multi.dart';
import 'rcky_taxfreein.dart';

class RcSysChk {
  static int happyQCType = 0; /* report でコンパイルエラーになるためrcqr_com.c から移動 */
  static const int FALSE = 0;
  static const int TRUE = 1;

  RcCnctLists rcCnctLists = RcCnctLists();

  ///  関連tprxソース: rcsyschk.c - rcSG_Chk_SelfGate_System
  ///  pCom.iniMacInfo.select_self.self_mode → pCom.iniMacInfo.select_self.kpi_hs_modeに変更
  static Future<bool> rcSGChkSelfGateSystem() async {
    int res = 0;

    if (await rcChkSQRCTicketSystem()) {
      return true;
    }

    if ((RcRegs.rcInfoMem.rcRecog.recogSelfGate != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogHappyselfSystem != 0)) {
      res = 1;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((await rcChk2800System()) && (rcChkDeskTopType())) {
      if ((pCom.iniMacInfo.select_self.kpi_hs_mode == 1) &&
          (res == 1) &&
          (pCom.iniMacInfo.select_self.self_mac_mode == 1) &&
          (!await rcChkQuickSelfSystem())) {
        return true;
      } else {
        return false;
      }
    }

    return (((pCom.iniMacInfo.select_self.kpi_hs_mode == 1) &&
            (res == 1) &&
            (!await rcChk2800System()) &&
            (!rcChkDeskTopType())) ||
        (await rcChkQuickSelfSystem()));
  }

  /// 下記仕様であるかチェックする
  /// 『SQRCチケット発券システム and web2800系 and デスクトップ型 and
  /// セルフモード and クイックセルフ仕様以外』
  /// 戻り値: false:上記仕様でない  true:上記仕様
  ///  関連tprxソース: rcsyschk.c - rcChk_SQRC_Ticket_System
  static Future<bool> rcChkSQRCTicketSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    if ((await CmCksys.cmSqrcTicketSystem() != 0) &&
        (await rcChk2800System()) &&
        (rcChkDeskTopType()) &&
        (pCom.iniMacInfo.select_self.self_mode == 1) &&
        (!await rcChkQuickSelfSystem())) {
      return true;
    } else {
      return false;
    }
  }

  /// 機種がweb2800系かチェックする
  /// 戻り値: false:2800系以外  true:2800系
  ///  関連tprxソース: rcsyschk.c - rcChk_2800_System
  static Future<bool> rcChk2800System() async {
    // #if defined(FB_EL)
    // return(FALSE);
    // #else
    int web_type;

    web_type = await CmCksys.cmWebType();
    if (web_type == CmSys.WEBTYPE_WEB2800) {
      return true;
    } else {
      return false;
    }
  }

  /// 機種がデスクトップ型（Desktop ECR Type?）であるかチェックする
  /// 戻り値: false:タワー型  true:デスクトップ型
  ///  関連tprxソース: rcsyschk.c - rcChk_DeskTopType
  static bool rcChkDeskTopType() /* Desk Top ECR type ? */
  {
    if (CmCktWr.cm_chk_tower() == CmSys.TPR_TYPE_DESK) {
      return true;
    } else {
      return false;
    }
  }

  /// 機種がデスクトップ型（Desktop ECR Type?）であるかチェックする
  /// 戻り値: false:タワー型  true:デスクトップ型
  ///  関連tprxソース: rcsyschk.c - rcChk_Quick_Self_System
  static Future<bool> rcChkQuickSelfSystem() async {
    int res = 0;

    if (RcRegs.rcInfoMem.rcRecog.recogQuickSelf != 0) {
      res = 1;
    }

    if (RcRegs.rcInfoMem.rcRecog.recogQuickSelfChg !=
        RecogValue.RECOG_NO.index) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return false;
      }
      RxCommonBuf pCom = xRet.object;
      return ((pCom.iniMacInfo.select_self.self_mode == 1) &&
          (!await rcChk2800System()) &&
          (res == 1) &&
          (rcChkDeskTopType()));
    } else {
      return ((res == 1) && (!await rcChk2800System()) && (rcChkDeskTopType()));
    }
  }

  /// タスクIDを設定する
  /// 戻値: タスクID
  ///  関連tprxソース: rcsyschk.c - GetTid
  static Future<int> getTid() async {
    if (rcCheckPrchker()) {
      return Tpraid.TPRAID_IIS;
    }
    if (rcCheckMobilePos()) {
      return Tpraid.TPRAID_MOBILE;
    }
    if (rcCheckWiz()) {
      return Tpraid.TPRAID_WIZS;
    }
    if (await rcKySelf() == RcRegs.KY_DUALCSHR) {
      return Tpraid.TPRAID_CASH;
    }

    return Tpraid.TPRAID_CHK;
  }

  /************************************************************************/
  /*                           Check Clerk Mode                           */
  /************************************************************************/
  /// キー操作を判別する
  /// 戻り値: 操作を行う機種（デスクトップ、1人制、キャッシャー、デュアルキャッシャー、チェッカー）
  ///  関連tprxソース: rcsyschk.c - rcKy_Self
  static Future<int> rcKySelf() async /* Check Checker/Cashier */
  {
    int type = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return type;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    Onetime ot = SystemFunc.readOnetime();
    CmdFunc cmdFunc = CmdFunc();

    if (rcChkDeskTopType()) {
      type = MachineType.desktopType.value;
    } else if (!await rcChk2Clk()) {
      type = MachineType.kySingle.value;
    } else {
      type = ot.flags.clk_mode;
    }

    if (await rcChkDesktopCashier()) {
      if (tsBuf.chk.cash_pid == cmdFunc.getPid()) {
        type = RcRegs.KY_DUALCSHR;
      } else {
        type = RcRegs.KY_CHECKER;
      }
    }

    return type;
  }

  /// 機種がデスクトップ型のキャッシャーであるかチェックする
  /// 戻り値: false:上記仕様でない  true:上記仕様
  ///関連tprxソース: rcsyschk.c - rcChk_Desktop_Cashier
  static Future<bool> rcChkDesktopCashier() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
        Tpraid.TPRAID_NONE,
        LogLevelDefine.error,
        "rcChkDesktopCashier rxMemRead isInvalid",
      );
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (!rcChkDeskTopType()) {
      return false;
    }

    if (!await rcChk2800System()) {
      return false;
    }
    // 【dart置き換え時コメント】original codeにて#if 0となっているのでこの部分コメントアウトしています
    // #if 0
    // if(C_BUF->db_trm.frc_clk_flg != 0) {
    //   return(FALSE);
    // }
    //
    // if(C_BUF->db_trm.chg_button_area_openclose) {
    //   return(FALSE);
    // }
    // #endif
    RecogRetData status1 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM, RecogTypes.RECOG_GETMEM);
    RecogRetData status2 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_HAPPYSELF_SYSTEM, RecogTypes.RECOG_GETMEM);
    RecogRetData status3 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM, RecogTypes.RECOG_GETMEM);

    if ((status1.result != RecogValue.RECOG_NO) ||
        (status2.result != RecogValue.RECOG_NO) ||
        (status3.result != RecogValue.RECOG_NO) ||
        !RcClxosCommon.validClxos) {
      if (pCom.dbStaffopen.chkr_status == 1) {
        return true;
      } else {
        if ((pCom.dbTrm.frcClkFlg != 0) && (await CmStf.cmPersonChk() == 2)) {
          return true;
        }
        return false;
      }
    } else {
      return false;
    }
  }

  /// HT2980に接続しているかチェックする
  /// 戻り値: false:未接続  true:接続
  /// 関連tprxソース: rcsyschk.c - rcChk_Ht2980_System
  static Future<bool> rcChkHt2980System() async {
    if (await rcCheckOutSider() || rcSROpeModeChk()) {
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_POINT > 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 9) &&
        (await CmCksys.cmHitachiBluechipSystem() > 0) &&
        ((await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 5) ||
            (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 6) ||
            (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 7)));
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  static bool rcChkDepartmentSystem() {
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Custrealsvr_System
  static bool rcChkCustrealsvrSystem() {
    bool recog1 = false;
    bool recog2 = false;

    if (RcRegs.rcInfoMem.rcRecog.recogCustrealsvr != 0) {
      recog1 = true;
    }
    if (RcRegs.rcInfoMem.rcRecog.recogCustrealNetdoa != 0) {
      recog2 = true;
    }

    return ((RcMbrCom.rcmbrChkStat() != 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctCustrealsvrCnct != 0) &&
        (recog1 || recog2));
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Custreal_Nec_System
  static Future<bool> rcChkCustrealNecSystem(int cnctchk) async {
    return ((await RcMbrCom.rcmbrChkStat() != 0) &&
        (RcRegs.rcInfoMem.rcRecog.recogCustrealNec != 0) &&
        ((RcRegs.rcInfoMem.rcCnct.cnctCustrealsvrCnct != 0) || (cnctchk != 0)));
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 顧客リアル[UID]仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  ///関連tprxソース: rcsyschk.c - rcChk_Custreal_UID_System
  static int rcChkCustrealUIDSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogCustrealUid != 0) &&
        (RcRegs.rcInfoMem.rcRecog.recogMembersystem != 0)) {
      return 1;
    }
    return 0;
  }

  /// 顧客リアル[OP]仕様のフラグを返す。
  /// 関連tprxソース: rcsyschk.c - rcChk_Custreal_OP_System
  /// 引数：なし
  /// 戻値：true:顧客リアル[OP]仕様  false:顧客リアル[OP]仕様ではない
  static bool rcChkCustrealOPSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogCustrealOp != 0) &&
        (RcRegs.rcInfoMem.rcRecog.recogMembersystem != 0)) {
      return true;
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcChk_Custreal_Pointartist_System
  static int rcChkCustrealPointartistSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogCustrealPointartist > 0) &&
        (RcRegs.rcInfoMem.rcRecog.recogMembersystem > 0)) {
      return 1;
    } else {
      return 0;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcCheck_RcptBar_Item
  static bool rcCheckRcptBarItem() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.rcptBar.rcptBarFlg == 1);
  }

  ///関連tprxソース: rcsyschk.c - rcClear_RcptBar
  static void rcClearRcptBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.rcptBar = RcptBar();
    cMem.rcptBar.rcptBarFlg = 0;
    cMem.rcptBar.rcptBar1Flg = 0;
    cMem.rcptBar.rcptBar2Flg = 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Tpoint_System
  static int rcChkTpointSystem() {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 顧客リアル[PT]仕様であるかチェックする
  /// 戻り値: 0=上記仕様でない  1=上記仕様
  ///関連tprxソース: rcsyschk.c - rcChk_Custreal_PointTactix_System
  static int rcChkCustrealPointTactixSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogCustrealPtactix != 0) &&
        (RcRegs.rcInfoMem.rcRecog.recogMembersystem != 0)) {
      return 1;
    } else {
      return 0;
    }
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 顧客リアル[PI]仕様かチェックする
  /// 戻り値: 0=上記仕様でない  1=上記仕様
  /// 関連tprxソース: rcsyschk.c - rcChk_Custreal_PointInfinity_System
  static bool rcChkCustrealPointInfinitySystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogCustrealPointinfinity != 0) &&
        (RcRegs.rcInfoMem.rcRecog.recogMembersystem != 0)) {
      return true;
    } else {
      return false;
    }
  }

  /// 下記仕様であるかチェックする
  /// 『QCashierJC and web2800系 and タワー型 and 2人制 and QCモード
  /// 　and「登録モード or 訓練モード or「訂正モード and 登録機実績の訂正」」』
  /// 戻り値: false:上記仕様でない  true:上記仕様
  /// 関連tprxソース: rcsyschk.c - rcCheck_QCJC_System
  static Future<bool> rcCheckQCJCSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    if (await rcChk2800System() &&
        !rcChkDeskTopType() &&
        await rcChk2Clk() &&
        CmCksys.cmQCashierJCSystem() == 1 &&
        pCom.iniMacInfo.select_self.qc_mode == 1 &&
        (pCom.iniMacInfo.internal_flg.mode == 1 ||
            pCom.iniMacInfo.internal_flg.mode == 4 ||
            (pCom.iniMacInfo.internal_flg.mode == 3 &&
                pCom.qcjc_voidmode_flg == 1))) {
      return true;
    }
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_AcrAcb_AnyTime_CinStart
  static bool rcChkAcrAcbAnyTimeCinStart() {
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_SmartSelf_System
  static Future<bool> rcChkSmartSelfSystem() async {
    if ((await rcChk2800System()) /* Web2800系？ */
        &&
        (rcChkDeskTopType()) /* DESKTOPタイプ？ */
        &&
        ((RcRegs.rcInfoMem.rcRecog.recogHappyselfSystem != 0) /* HappySelf仕様 */
            ||
            (RcRegs.rcInfoMem.rcRecog.recogHappyselfSmileSystem !=
                0))) /* HappySelf仕様[SmileSelf用] */
    {
      return true;
    } else {
      return false;
    }
  }

  /// RALSEカード仕様かチェックする
  /// 戻り値: false:上記仕様でない  true:上記仕様
  ///関連tprxソース: rcsyschk.c - rcChk_RalseCard_System
  static bool rcChkRalseCardSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.ralseMagFmt == 1) {
      return true;
    }
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Ajs_Emoney_System
  static bool rcChkAjsEmoneySystem() {
    /*
    if ((RcRegs.rcInfoMem.rcRecog.recogAjsEmoneySystem != 0) &&
        !(await RcSysChk.rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      return true;
    } else {
      return false;
    }
     */
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcCheck_Calc_Tend
  static bool rcCheckCalcTend() {
    AcMem cMem = SystemFunc.readAcMem();
    return (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CALC.keyId]));
  }

  /// HappySelfシステムでSmileSelf状態かチェックする
  /// 戻り値: true=上記状態  false=上記状態でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_happy_smile
  static Future<bool> rcSysChkHappySmile() async {
    if (await rcChkSmartSelfSystem()) {
      if (await rcChkFselfMain()) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcChk_HappySelf_QCashier
  ///report でコンパイルエラーになるためrcqr_com.c から移動
  ///関数名　　：rcChk_HappySelf_QCashier
  ///機能概要　：HappySelf仕様 対面セルフからQCashierへ切替え
  ///パラメータ：なし
  ///戻り値　　：TRUE:はい FALSE:いいえ
  static Future<bool> rcChkHappySelfQCashier() async {
    if (await rcChkSmartSelfSystem() && /* HappySelf仕様？ */
        await rcQCChkQcashierSystem() && /* QCashier状態？ */
        happyQCType == 1) {
      /* QC切替えを行った？ */
      return true;
    } else {
      return false;
    }
  }

  /// COOP仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_COOP_System
  static Future<bool> rcChkCOOPSystem() async {
    if ((await rcCheckOutSider()) || rcSROpeModeChk()) {
      return false;
    }

    bool res1 = false;
    bool res2 = false;
    if (RcRegs.rcInfoMem.rcRecog.recogCoopsystem != 0) {
      res1 = true;
    }
    if (RcRegs.rcInfoMem.rcRecog.recogGreenstampSys != 0) {
      res2 = true;
    }

    return (res1 && res2 && (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 3));
  }

  /// 顧客リアル[Webサービス]仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Custreal_Webser_System
  static bool rcChkCustrealWebserSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogCustrealWebser != 0) &&
        (RcRegs.rcInfoMem.rcRecog.recogMembersystem != 0)) {
      return true;
    }
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_NTTD_Preca_System
  static Future<bool> rcChkNTTDPrecaSystem() async {
    if (((await CmCksys.cmNttdPrecaSystem() != 0) &&
        (!await rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem())))) {
      return true;
    } else {
      return false;
    }
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_TRK_Preca_System
  static bool rcChkTRKPrecaSystem() {
    /*
    if ((RcRegs.rcInfoMem.rcRecog.recogTrkPreca != 0) &&
        !((await RcSysChk.rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((rcKySelf() != RcRegs.KY_CHECKER) || (await RcSysChk.rcCheckQCJCSystem())))) {
      return true;
    }
    return false;
     */
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Repica_System
  static bool rcChkRepicaSystem() {
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 「ミックスマッチ複数選択」の承認状態を返す
  /// 戻り値: true=PLUコード生成  false=対象外
  /// 関連tprxソース: rcsyschk.c - rcChk_Cogca_System
  static bool rcChkCogcaSystem() {
    /*
    if ((RcRegs.rcInfoMem.rcRecog.recogCogcaSystem != 0) &&
        (!(await RcSysChk.rcCheckOutSider())) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((rcKySelf() != RcRegs.KY_CHECKER) || (await RcSysChk.rcCheckQCJCSystem()))) {
      return true;
    }
    return false;
     */
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_ValueCard_System
  static bool rcChkValueCardSystem() {
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcSR_OpeModeChk
  static bool rcSROpeModeChk() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.opeMode == RcRegs.SR) {
      return true;
    } else {
      return false;
    }
  }

  /// オペモードが棚卸モードかチェックする
  /// 戻り値: false:上記モードではない  true:上記モード
  /// 関連tprxソース: rcsyschk.c - rcIV_OpeModeChk
  static bool rcIVOpeModeChk() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.opeMode == RcRegs.IV) {
      return true;
    }
    return false;
  }

  /// オペモードが生産モードかチェックする
  /// 戻り値: false:上記モードではない  true:上記モード
  /// 関連tprxソース: rcsyschk.c - rcPD_OpeModeChk
  static bool rcPDOpeModeChk() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.opeMode == RcRegs.PD) {
      return true;
    }
    return false;
  }

  /// オペモードが発注モードかチェックする
  /// 戻り値: false:上記モードではない  true:上記モード
  /// 関連tprxソース: rcsyschk.c - rcOD_OpeModeChk
  static bool rcODOpeModeChk() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.opeMode == RcRegs.OD) {
      return true;
    }
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_MultiSuica_System
  static Future<int> rcChkMultiSuicaSystem() async {
    if ((await CmCksys.cmPFMJRICSystem() != 0)) {
      if ((await rcCheckOutSider()) ||
          (rcSROpeModeChk()) ||
          ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
              (await rcCheckQCJCSystem() == false))) {
        return 0;
      } else {
        return 1;
      }
    } else if (await rcChkMultiVegaPayMethod(FclService.FCL_SUIC)) {
      if ((await rcCheckOutSider()) ||
          (rcSROpeModeChk()) ||
          ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
              (await rcCheckQCJCSystem() == false))) {
        return 0;
      } else {
        return 2;
      }
    } else {
      return 0;
    }
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Suica_System
  static Future<bool> rcChkSuicaSystem() async {
    int res1 = 0;
    int res2 = 0;
    if (RcRegs.rcInfoMem.rcRecog.recogIccardsystem != 0) {
      res1 = 1;
    }
    if (RcRegs.rcInfoMem.rcRecog.recogJremMultisystem != 0) {
      res2 = 1;
    }

    return ((!(await RcSysChk.rcCheckOutSider())) && // IIS21 or MOBILE-POS?
        (!rcSROpeModeChk()) && // Scrap Mode?
        ((rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem())) && // CHECKER?
        (res1 == 1) && // Suica System?
        (res2 == 0) && // JREM Multi System?
        (RcRegs.rcInfoMem.rcCnct.cnctSuicaCnct != 0)); // Suica Connect?
  }

  ///関連tprxソース: rcsyschk.c - rcQC_Chk_Qcashier_System
  static Future<bool> rcQCChkQcashierSystem() async {
    int res = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (await rcNewSGChkNewSelfGateSystem()) {
      return false;
    }

    if ((RcRegs.rcInfoMem.rcRecog.recogQcashierSystem != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogHappyselfSystem != 0)) {
      res = 1;
    }

    if (await rcCheckQCJCCashier()) {
      return ((res == 1) &&
          (pCom.iniMacInfo.select_self.qc_mode == 1) &&
          (await rcChk2800System()) &&
          ((pCom.iniMacInfo.internal_flg.mode == 1) ||
              ((pCom.iniMacInfo.internal_flg.mode == 3) &&
                  (pCom.qcjc_voidmode_flg == 1)) ||
              (pCom.iniMacInfo.internal_flg.mode == 4)));
    }
    return ((res == 1) &&
        (pCom.iniMacInfo.select_self.qc_mode == 1) &&
        (await rcChk2800System()) &&
        (rcChkDeskTopType()) &&
        ((pCom.iniMacInfo.internal_flg.mode == 1) ||
            (pCom.iniMacInfo.internal_flg.mode == 4)));
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Ytrm_System
  static bool rcChkYtrmSystem() {
    return false;
  }

  /// オペモードが登録モードかチェックする
  /// 戻り値: false:上記モードではない  true:上記モード
  /// 関連tprxソース: rcsyschk.c - rcRG_OpeModeChk
  static bool rcRGOpeModeChk() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.opeMode == RcRegs.RG) {
      return true;
    }
    return false;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外 →通番訂正にて実装しました
  /// オペモードが訓練モードかチェックする
  /// 戻り値: false:上記モードではない  true:上記モード
  /// 関連tprxソース: rcsyschk.c - rcTR_OpeModeChk
  static bool rcTROpeModeChk() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.opeMode == RcRegs.TR) {
      return true;
    }
    return false;
  }

  /// タカヤナギ様仕様のフラグを返す
  /// 戻り値: 0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm55_takayanagi_system
  static int rcsyschkSm55TakayanagiSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogSm55TakayanagiSystem > 0) {
      return 1;
    }
    return 0;
  }

  /// 伊徳様仕様のフラグを返す
  /// 戻り値: 0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm5_itoku_system
  static int rcsyschkSm5ItokuSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogSm5ItokuSystem > 0) {
      return 1;
    }
    return 0;
  }

  /// ベスカ決済端末仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_vesca_system
  static bool rcsyschkVescaSystem() {
    if((RcRegs.rcInfoMem.rcRecog.recogVescaSystem != 0)
        && (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 18)){
      return true;
    } else {
      return false;
    }
  }

  /// 引数で指定した支払方法がVEGA3000電子マネー仕様で利用できるか確認する
  /// 引数:[payMthd] 確認する支払方法
  /// 戻り値: false=利用不可  true=利用可能
  /// 関連tprxソース: rcsyschk.c - rcChk_MultiVega_PayMethod
  static Future<bool> rcChkMultiVegaPayMethod(FclService payMthd) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcSysChk.rcChkMultiVegaPayMethod(): rxMemRead error");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (rcChkMultiVegaSystem() == 0) {
      return false;
    }
    switch (payMthd) {
      case FclService.FCL_SUIC:
        if (cBuf.ini_multi.Suica_tid.isNotEmpty) {
          return true;
        }
        break;
      case FclService.FCL_EDY:
        if (cBuf.ini_multi.Edy_tid.isNotEmpty) {
          return true;
        }
        break;
      case FclService.FCL_QP:
        if (cBuf.ini_multi.QP_tid.isNotEmpty) {
          return true;
        }
        break;
      case FclService.FCL_ID:
        if (cBuf.ini_multi.iD_tid.isNotEmpty) {
          return true;
        }
        break;
      default:
        break;
    }
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_MultiVega_System
  static int rcChkMultiVegaSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogMultiVegaSystem != 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctMultiCnct == 6)) {
      return 1;
    }
    return 0;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_Assort_System
  static Future<bool> rcChkAssortSystem() async {
    return ((CmCksys.cmStmSystem() != 0) &&
        (await CmCksys.cmAssortSystem() != 0));
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Mc_System
  static bool rcChkMcSystem() {
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcCheck_QCJC_FrcClk_System
  static Future<bool> rcCheckQCJCFrcClkSystem() async {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRetC.object;

    if ((await RcSysChk.rcChk2800System()) &&
        (!RcSysChk.rcChkDeskTopType()) &&
        (cBuf.dbTrm.frcClkFlg == 2) &&
        (CmCksys.cmQCashierJCSystem() != 0) &&
        (cBuf.iniMacInfo.select_self.qc_mode == 1) &&
        ((cBuf.iniMacInfo.internal_flg.mode == 1) ||
            (cBuf.iniMacInfo.internal_flg.mode == 4) ||
            ((cBuf.iniMacInfo.internal_flg.mode == 3) &&
                (cBuf.qcjc_voidmode_flg == 1)))) {
      return true;
    } else {
      return false;
    }
  }

  /// DBより取得したクレジットユーザーNoを返す
  /// 戻り値: クレジットユーザーNo
  /// 関連tprxソース: rcsyschk.c - rcChk_Crdt_User
  static int rcChkCrdtUser() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbTrm.crdtUserNo);
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_MultiEdy_System
  static Future<int> rcChkMultiEdySystem() async {
    if ((await rcCheckOutSider()) ||
        (rcSROpeModeChk()) ||
        ((await rcKySelf() == RcRegs.KY_CHECKER) &&
            (!await rcCheckQCJCSystem()))) {
      return 0;
    } else {
      if (await CmCksys.cmFclEdySystem() != 0) {
        return 1;
      } else if (await CmCksys.cmMultiVegaSystem() != 0) {
        return MultiEdyTerminal.EDY_VEGA_USE.index; // 4
      } else {
        return 0;
      }
    }
  }

  /// 機能概要: 楽天ポイント仕様判定処理
  /// 呼出方法: #include "rc_ext.h"
  ///       : rcsyschk_Rpoint_System();
  /// 引数   : なし
  /// 戻り値 : 0:楽天ポイント仕様無効
  ///       : 1:楽天ポイント仕様有効
  ///関連tprxソース: rcsyschk.c - rcsyschk_Rpoint_System
  static int rcsyschkRpointSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogRpointSystem > 0) &&
        (RcRegs.rcInfoMem.rcRecog.recogMembersystem > 0)) {
      return 1;
    }
    return 0;
  }

  ///関連tprxソース: rcsyschk.c - rcNewSG_Chk_NewSelfGate_System
  static Future<bool> rcNewSGChkNewSelfGateSystem() async {
    if (await rcChkSQRCTicketSystem()) {
      return true;
    }
    //#if SELF_GATE
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    if ((pCom.iniMacInfo.select_self.self_mac_mode == 1) &&
        (await rcSGChkSelfGateSystem())) {
      return true;
    } else {
      //#endif
      return false;
    }
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcChk_Change_After_Receipt
  static bool rcChkChangeAfterReceipt() {
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcsyschk.c - rcCheck_S2Print
  static int rcCheckS2Print() {
    return 0; //false
  }

  /// 西鉄ストアWiz仕様の実績上げ途中かチェックする
  /// 戻り値: true=実績上げ中  false=実績上げ中でない
  /// 関連tprxソース: rcsyschk.c - rc_Check_WizAdj_Update
  static Future<bool> rcCheckWizAdjUpdate() async {
    /* Wiz精算仕様で、ソケットのQRデータから実績を作成する条件 */
    if (RegsMem().prnrBuf == null) {
      return false;
    }
    if ((await CmCksys.cmWizAbjSystem() != 0) &&
        (RegsMem().prnrBuf.wizQrData.tranStat == 1)) {
      return true;
    } else {
      return false;
    }
  }

  /// タワー型の2人制であるかチェックする
  /// 戻り値: false:上記仕様でない  true:上記仕様
  /// 関連tprxソース: rcsyschk.c - rcChk_2Clk
  static Future<bool> rcChk2Clk() async {
    if (rcChkDeskTopType()) {
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    if (CompileFlag.SIMPLE_2STAFF) {
      /* 04.Jan.13 */
      /*if (C_BUF->db_trm.frc_clk_flg == 2)*/
      /* 2011/02/09 >>> */
      if ((pCom.dbTrm.frcClkFlg == 2) ||
          ((await CmCksys.cmChkKasumi2Person() == 1) &&
              (pCom.stf2.twopersonKeyFlag == 1))) {
        /* <<< 2011/02/09 */
        return (await CmStf.cmPersonChk() == 2); /* two person */
      } else {
        return (pCom.dbStaffopen.chkr_status !=
            RcRegs.CLK_CL); /* Not Close Checker ? */
      }
    } else {
      return (pCom.dbStaffopen.chkr_status !=
          RcRegs.CLK_CL); /* Not Close Checker ? */
    }
  }

  ///関連tprxソース: rcsyschk.c - rcsyschk_p11_prize_system
  ///**********************************************************************
  ///    関数：rcsyschk_p11_prize_system(void)
  ///    機能：懸賞企画仕様が利用可能かどうか判定する
  ///   引数：なし
  ///    戻値：結果
  ///***********************************************************************
  static bool rcSysChkP11PrizeSystem() {
    if (RcRecogLists().recogAyahaSystem != 0) {
      return true;
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcChk_purchase_ticket_system
  ///**********************************************************************
  ///    関数：rcChk_purchase_ticket_system(void)
  ///    機能：特定売上チケット発券のフラグを返す。
  ///    引数：なし
  ///    戻値：TRUE 特定売上チケット発券  FALSE 特定売上チケット発券ではない
  /// ***********************************************************************
  static Future<bool> rcChkPurchaseTicketSystem() async {
    if (RcRecogLists().recogPurchaseTicketSystem != 0 &&
        !await rcCheckOutSider() &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        (await rcKySelf() != RcRegs.KY_CHECKER || await rcCheckQCJCSystem())) {
      return true;
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcChk_fself_Main
  static Future<bool> rcChkFselfMain() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    if (RcRegs.rcInfoMem.rcRecog.recogSelfGate != 0) {
      if (cBuf.iniMacInfo.select_self.self_mode == 1) {
        return false;
      }
    }

    if (RcRegs.rcInfoMem.rcRecog.recogQuickSelf != 0) {
      return false;
    }

    if (RcRegs.rcInfoMem.rcRecog.recogQcashierSystem != 0) {
      if (cBuf.iniMacInfo.select_self.qc_mode == 1) {
        return false;
      }
    }

    if (await rcChkSmartSelfSystem()) {
      if ((cBuf.iniMacInfo.select_self.self_mode == 1) ||
          (cBuf.iniMacInfo.select_self.qc_mode == 1)) {
        return false;
      }
    }

    if ((RcRegs.rcInfoMem.rcRecog.recogFrontSelfSystem != 0)
        || (RcRegs.rcInfoMem.rcRecog.recogHappyselfSystem != 0)
        || (RcRegs.rcInfoMem.rcRecog.recogHappyselfSmileSystem != 0)) {
      return true;
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcChk_fself_system
  static Future<bool> rcChkFselfSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return false;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (RcRegs.rcInfoMem.rcCnct.cnctColordspCnct != 1) {
      return false;
    }

    if (await rcChkFselfMain()) {
      if (await rcKySelf() == RcRegs.KY_CHECKER) {
        if (rcChkFselfOptWindowUse()) {
          if (tsBuf.cash.stat == 1 || tsBuf.chk.stlkey_retn_function == 1) {
            return false;
          }
        } else {
          return false;
        }
      }
      if (await rcChkFselfMain()) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  ///**********************************************************************
  ///   関数：rcChk_fself_optwindow_use(void)
  ///   機能：客側表示のサブ画面（チェッカーで画面を作成）を利用するかを判定する
  ///   引数：なし
  ///   戻値：なし
  ///***********************************************************************
  static bool rcChkFselfOptWindowUse() {
    return true; //設定値を参照しないように変更
  }

  /// Check Have a KY_INT in
  /// 引数: エラーチェックフラグ
  /// 関連tprxソース: rcsyschk.c - rcCheck_KY_INT_IN
  static bool rcCheckKyIntIn(bool errChk) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return ((cBuf.intFlag == 1) || ((cBuf.intFlag == 2) && errChk));
  }

  /// QUICPay[マルチ]仕様のターミナルをチェックする
  /// 戻り値: MultiQPTerminal列挙型を参照
  ///関連tprxソース: rcsyschk.c - rcChk_MultiQP_System
  static Future<int> rcChkMultiQPSystem() async {
    if ((await CmCksys.cmFclQUICPaySystem() != 0) &&
        (await CmCksys.cmCrdtSystem() != 0)) {
      if (await rcCheckOutSider() ||
          rcSROpeModeChk() ||
          ((await rcKySelf() == RcRegs.KY_CHECKER) &&
              !(await rcCheckQCJCSystem()))) {
        return 0;
      } else {
        if (rcChkCrdtUser() == 1) {
          /* kasumi */
          return 0;
        } else {
          return 1;
        }
      }
    } else if ((await CmCksys.cmUt1QUICPaySystem() != 0) &&
        (await CmCksys.cmCrdtSystem() != 0)) {
      if (await rcCheckOutSider() ||
          rcSROpeModeChk() ||
          ((await rcKySelf() == RcRegs.KY_CHECKER) &&
              !(await rcCheckQCJCSystem()))) {
        return 0;
      } else {
        if (rcChkCrdtUser() == 1) {
          /* kasumi */
          return 0;
        } else {
          return MultiQPTerminal.QP_VEGA_USE.index; // 4
        }
      }
    } else if ((await CmCksys.cmMultiVegaSystem() != 0) &&
        (await CmCksys.cmCrdtSystem() != 0)) {
      if (await rcCheckOutSider() ||
          rcSROpeModeChk() ||
          ((await rcKySelf() == RcRegs.KY_CHECKER) &&
              !(await rcCheckQCJCSystem()))) {
        return 0;
      } else {
        return MultiQPTerminal.QP_VEGA_USE.index; // 4
      }
    }
    return 0;
  }

  /// iD[マルチ]仕様のターミナルをチェックする
  /// 戻り値: MultiIDTerminal列挙型を参照
  /// 関連tprxソース: rcsyschk.c - rcChk_MultiiD_System
  static Future<int> rcChkMultiiDSystem() async {
    if (await CmCksys.cmCrdtSystem() == 1) {
      if (await CmCksys.cmFclIDSystem() == 1) {
        if (await rcCheckOutSider() ||
            rcSROpeModeChk() ||
            ((await rcKySelf() == RcRegs.KY_CHECKER) &&
                !(await rcCheckQCJCSystem()))) {
          return 0;
        } else {
          if (rcChkCrdtUser() == 1) {
            /* kasumi */
            return 0;
          } else {
            return 1;
          }
        }
      } else if (await CmCksys.cmUt1IDSystem() == 1) {
        if (await rcCheckOutSider() ||
            rcSROpeModeChk() ||
            ((await rcKySelf() == RcRegs.KY_CHECKER) &&
                !(await rcCheckQCJCSystem()))) {
          return 0;
        } else {
          if (rcChkCrdtUser() == 1) {
            /* kasumi */
            return 0;
          } else {
            return 3;
          }
        }
      } else if (await CmCksys.cmMultiVegaSystem() == 1) {
        if (await rcCheckOutSider() ||
            rcSROpeModeChk() ||
            ((await rcKySelf() == RcRegs.KY_CHECKER) &&
                !(await rcCheckQCJCSystem()))) {
          return 0;
        } else {
          return MultiIDTerminal.ID_VEGA_USE.index; // 4
        }
      }
    }
    return 0;
  }

  /// PiTaPa[マルチ]仕様のターミナルをチェックする
  /// 戻り値: MultiPitapaTerminal列挙型を参照
  ///　関連tprxソース: rcsyschk.c - rcChk_MultiPiTaPa_System
  static Future<int> rcChkMultiPiTaPaSystem() async {
    if ((await CmCksys.cmPFMPiTaPaSystem() == 1) &&
        (await CmCksys.cmCrdtSystem() == 1)) {
      if (await rcCheckOutSider() ||
          rcSROpeModeChk() ||
          ((await rcKySelf() == RcRegs.KY_CHECKER) &&
              !(await rcCheckQCJCSystem()))) {
        return 0;
      } else {
        return 2;
      }
    }
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///関連tprxソース: rcsyschk.c - rcChk_Edy_System
  static Future<bool> rcChkEdySystem() async {
    int res = 0;
    if (RcRegs.rcInfoMem.rcRecog.recogEdysystem != 0) {
      res = 1;
    }
    return ((!(await rcCheckOutSider())) && // IIS21 or MOBILE-POS?
        (!rcVDOpeModeChk()) && // Void Mode?
        (!rcSROpeModeChk()) && // Scrap Mode?
        ((rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem())) && // CHECKER?
        (res == 1) && // Edy System?
        ((RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 5) || // SIP-60 Connect?
            (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 7))); // SIP-100 Connect?
  }

  ///関連tprxソース: rcsyschk.c - rcVD_OpeModeChk
  static bool rcVDOpeModeChk() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.opeMode == RcRegs.VD) {
      return true;
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcChk_RcptBarCode
  static int rcChk_RcptBarCode(String rcptBarCd) {
    ///  TODO:00007 梶原 元のerr_noにはOKが入っているが、これが0でいいのか調べて置き換える必要あり
    int errNo = 0;
    // err_no = OK;
    String tmp;

    rcClearJanInf();

    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.janInf.code = rcptBarCd.substring(0, Ean.ASC_EAN_26 - 1);

    ///  TODO:00007 梶原 中身の実装中
    SetJinf.cmSetJanInf(cMem.working.janInf, 1, RcRegs.CHKDGT_CALC);

    switch (cMem.working.janInf.type) {
      case JANInfConsts.JANtypeRcptBar26:
        cMem.rcptBar.rcptBar1Flg = 1;
        cMem.rcptBar.rcptBar2Flg = 1;
        String yy = rcptBarCd.substring(2, 4);
        String mm = rcptBarCd.substring(4, 6);
        String dd = rcptBarCd.substring(6, 8);
        cMem.rcptBar.saleDate = '20$yy-$mm-$dd';

        tmp = rcptBarCd.substring(8, 12);
        cMem.rcptBar.receiptNo = int.parse(tmp);

        tmp = rcptBarCd.substring(15, 21);
        cMem.rcptBar.macNo = int.parse(tmp);

        tmp = rcptBarCd.substring(21, 25);
        cMem.rcptBar.printNo = int.parse(tmp);
        cMem.rcptBar.rcptBarFlg = 1;
        break;
      case JANInfConsts.JANtypeIllPcd:
      case JANInfConsts.JANtypeIllCd:
      case JANInfConsts.JANtypeIllegal:
        errNo = DlgConfirmMsgKind.MSG_BARFMTERR.dlgId;
        break;
      case JANInfConsts.JANtypeIllSys:
        errNo = DlgConfirmMsgKind.MSG_NONUSECODE.dlgId;
        break;
      default:
        if (rcCheckRcptBar1Flg() || rcCheckRcptBar2Flg()) {
          errNo = DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
        }
        break;
    }
    return errNo;
  }

  ///関連tprxソース: rcsyschk.c - rcClearJan_inf
  static void rcClearJanInf() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.janInf = JANInf();
  }

  ///関連tprxソース: rcsyschk.c - rcCheck_RcptBar1_Flg
  static bool rcCheckRcptBar1Flg() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.rcptBar.rcptBarFlg == 1);
  }

  ///関連tprxソース: rcsyschk.c - rcCheck_RcptBar2_Flg
  static bool rcCheckRcptBar2Flg() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.rcptBar.rcptBar2Flg == 1);
  }

  ///関連tprxソース: rcsyschk.c - rcChk_Barcode_Pay_System
  static Future<int> rcChkBarcodePaySystem() async {
    if (await rcChkOnepaySystem()) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_ALIPAY.id);
    } else if (await rcChkLinePaySystem()) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_LINEPAY.id);
    } else if (await rcChkBarcodePay1System()) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_BARCODE_PAY1.id);
    } else if (await rcChkCANALPaymentServiceSystem()) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_CANALPAY.id);
    } else if (await rcChkFujitsuFIPCodepaySystem()) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_FIP.id);
    } else if (await rcChkMultiOnepaySystem()) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_MULTIONEPAY.id);
    } else if (await rcChkNetstarsCodepaySystem()) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_NETSTARS.id);
    } else if (await rcsyschkQuizCodepaySystem() != 0) {
      return (BCDPAY_TYPE.BCDPAY_TYPE_QUIZ.id);
    } else {
      return 0;
    }
  }

  /// カード決済機接続(デビット/クレジット)がJET-Meか否か判定
  /// 関連tprxソース : rcsyschk.c - rcChk_JET_Me_Process
  /// 引数 : なし
  /// 戻り値 : true=JET-Me, false=JET-Meでない
  static bool rcChkJETMeProcess() {
    return (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 17);
  }

  ///関連tprxソース: rcsyschk.c - rcQR_Chk_Print_System
  static Future<bool> rcQRChkPrintSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    int res1 = 0;
    int res2 = 0;

    if (RcRegs.rcInfoMem.rcRecog.recogReceiptQrSystem != 0) {
      res1 = 1;
    }
    if ((RcRegs.rcInfoMem.rcRecog.recogQcashierSystem != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogHappyselfSystem != 0)) {
      res2 = 1;
    }
    if (await rcCheckQCJCChecker()) {
      return ((res1 == 1) && (await rcChk2800System()));
    }
    if (await rcChkDesktopCashier()) {
      // スマイルセルフでQC指定がしたいとの事
      if (await rcChkFselfMain()) {
        if ((res1 == 1) && (await rcChk2800System())) {
          return true;
        }
      }
    }
    if (await rcSGChkInterruptSystem() != 0) {
      //HappySelf[フルセルフ]でお会計券発券
      res2 = 0;
    }

    return ((res1 == 1) &&
        (res2 == 0) &&
        ((cBuf.iniMacInfo.internal_flg.mode == 1) ||
            (cBuf.iniMacInfo.internal_flg.mode == 4)) &&
        ((await rcChk2800System() || CmCksys.cmRm5900System() != 0)) &&
        (rcChkDeskTopType() ||
            (!await rcChk2Clk()) ||
            (await rcChkCashierQRPrint())));
  }

  /// 関連tprxソース: rcsyschk.c - rcSG_Chk_Interrupt_System
  static Future<int> rcSGChkInterruptSystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogReceiptQrSystem != 0) /* レシートQR印字 */
        &&
        (await rcChkSmartSelfSystem()) /* HappySelf仕様 */
        &&
        (!await rcSysChkHappySmile()) /* HappySelf対面モードでない */
        &&
        (!await rcChkHappySelfQCashier())) /* QC切替を行っていない */
    {
      return 1;
    } else if ((await rcChkShopAndGoSystem()) /* Shop&Go仕様 */
        &&
        (RcRegs.rcInfoMem.rcRecog.recogReceiptQrSystem != 0)) /* レシートQR印字 */
    {
      return 1;
    } else {
      return 0;
    }
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// レピカポイント仕様承認キー設定有無を判別
  /// 関連tprxソース: rcsyschk.c - rcsyschk_repica_point_system
  /// 引数 : なし
  /// 戻り値 : true :レピカポイント仕様である, false :レピカポイント仕様でない
  static bool rcsyschkRepicaPointSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogRepicaPointSystem != 0) {
      return true;
    } else {
      return false;
    }
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///関連tprxソース: rcsyschk.c - rcsyschk_employee_card_payment_system
  static bool rcsyschkEmployeeCardPaymentSystem() {
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcCheck_Crdt_Stat
  static bool rcCheckCrdtStat() {
    AcMem cMem = SystemFunc.readAcMem();
    return (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_BARIN.keyId]));
  }

  /// 釣りあり品券、会計レシートをQCashier側で発行する場合の選択画面表示
  /// 関連tprxソース: rcsyschk.c - rcsyschk_creditreceipt_issue_qc_side
  /// 引数 : なし
  /// 戻り値 : 結果
  static Future<bool> rcsyschkCreditreceiptIssueQcSide() async {
    if (await rcQCChkQcashierSystem()) {
      return true;
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcsyschk_qc_nimoca_system
  static Future<bool> rcsyschkQcNimocaSystem() async {
    if ((await CmCksys.cmTb1System() != 0) // 現状は、西鉄仕様時に利用可能
        && (RcRegs.rcInfoMem.rcRecog.recogNimocaPointSystem != 0)) {
      return true;
    } else {
      return false;
    }
  }

  /// 特定SM1仕様かどうかを判定する
  /// 関連tprxソース: rcsyschk.c - rcChk_Mammy_Mart_System
  /// 引数 : なし
  /// 戻り値 : 結果
  static bool rcChkMammyMartSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogMammySystem != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// dポイント仕様かを判定
  /// 関連tprxソース: rcsyschk.c - rcChk_dPoint_System
  /// 引数 : なし
  /// 戻り値 : true :dポイント仕様である, false :dポイント仕様ではない
  static bool rcChkDPointSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogDpointSystem != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// Tポイント仕様かどうかを判定する
  /// 関連tprxソース: rcsyschk.c - rcsyschk_Tpoint_System
  /// 引数 : なし
  /// 戻り値 : 結果
  static bool rcsyschkTpointSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogCustrealTpoint != 0)
        && (RcRegs.rcInfoMem.rcRecog.recogMembersystem != 0)) {
      return true;
    }
    return false;
  }

  /// Tポイント仕様追加機能が有効かどうかを判定する
  /// 関連tprxソース: rcsyschk.c - rcsyschk_Tpoint_Advanced_System
  /// 引数 : 追加機能の種類
  /// 戻り値 : 結果
  static bool rcsyschkTpointAdvancedSystem(int typ) {
    if (!rcsyschkTpointSystem()) {
      return false;
    }
    switch (typ) {
      case 1: // ポイント利用キー押下時に還元通信を行う仕様
        return true;
      case 2: // ポイント利用画面を表示する仕様
        return true;
      default:
        break;
    }
    return false;
  }

  /// 友の会仕様[リウボウストア様]のチェック
  /// 関連tprxソース: rcsyschk.c - rcsyschk_tomoIF_system
  /// 引数 : なし
  /// 戻り値 : true :仕様である, false :仕様ではない
  static bool rcsyschkTomoIFSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogTomoifSystem != 0) {
      return true;
    }
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_KY_CHA(short FncCode)
  static bool rcChkKYCHA(int fncCd) {
    return ((fncCd == FuncKey.KY_CHA1.keyId) ||
        (fncCd == FuncKey.KY_CHA2.keyId) ||
        (fncCd == FuncKey.KY_CHA3.keyId) ||
        (fncCd == FuncKey.KY_CHA4.keyId) ||
        (fncCd == FuncKey.KY_CHA5.keyId) ||
        (fncCd == FuncKey.KY_CHA6.keyId) ||
        (fncCd == FuncKey.KY_CHA7.keyId) ||
        (fncCd == FuncKey.KY_CHA8.keyId) ||
        (fncCd == FuncKey.KY_CHA9.keyId) ||
        (fncCd == FuncKey.KY_CHA10.keyId) ||
        (fncCd == FuncKey.KY_CHA11.keyId) ||
        (fncCd == FuncKey.KY_CHA12.keyId) ||
        (fncCd == FuncKey.KY_CHA13.keyId) ||
        (fncCd == FuncKey.KY_CHA14.keyId) ||
        (fncCd == FuncKey.KY_CHA15.keyId) ||
        (fncCd == FuncKey.KY_CHA16.keyId) ||
        (fncCd == FuncKey.KY_CHA17.keyId) ||
        (fncCd == FuncKey.KY_CHA18.keyId) ||
        (fncCd == FuncKey.KY_CHA19.keyId) ||
        (fncCd == FuncKey.KY_CHA20.keyId) ||
        (fncCd == FuncKey.KY_CHA21.keyId) ||
        (fncCd == FuncKey.KY_CHA22.keyId) ||
        (fncCd == FuncKey.KY_CHA23.keyId) ||
        (fncCd == FuncKey.KY_CHA24.keyId) ||
        (fncCd == FuncKey.KY_CHA25.keyId) ||
        (fncCd == FuncKey.KY_CHA26.keyId) ||
        (fncCd == FuncKey.KY_CHA27.keyId) ||
        (fncCd == FuncKey.KY_CHA28.keyId) ||
        (fncCd == FuncKey.KY_CHA29.keyId) ||
        (fncCd == FuncKey.KY_CHA30.keyId) ||
        (fncCd == FuncKey.KY_CHK1.keyId) ||
        (fncCd == FuncKey.KY_CHK2.keyId) ||
        (fncCd == FuncKey.KY_CHK3.keyId) ||
        (fncCd == FuncKey.KY_CHK4.keyId) ||
        (fncCd == FuncKey.KY_CHK5.keyId));
  }

  ///関連tprxソース: rcsyschk.c - rcCheck_RegFnal(void)
  static bool rcCheckRegFnal() {
    // TODO:10147 CMEM->key_stat の実装が完了したら正式対応
    /*
    AcMem cMem = SystemFunc.readAcMem();
    return
      (((!RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId])) &&    /* Check Registration ? */
        (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) &&
        (!RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) &&    /* Check Sprit ?        */
        (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))));
     */
    if (RegsMem().tTtllog.getItemLogCount() == 0) {
      return true;
    }
    return false;
    // <-- TODO:10147暫定対応     
  }

  ///関連tprxソース: rcsyschk.c - rcChk_JET_B_Process
  static bool rcChkJETBProcess() {
    return (((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 0)
        && (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 1))
        || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 1));
  }

  ///関連tprxソース: rcsyschk.c - rcChk_JET_A_Standard_Process
  static bool rcChkJETAStandardProcess() {
    return (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 10);
  }

  ///関連tprxソース: rcsyschk.c - rcChk_Mst_Process
  ///**********************************************************************
  ///関数：rcChk_Mst_Process(void)
  ///機能:  MST接続仕様のフラグを返す
  ///引数:  なし
  ///戻値:  1: MST接続仕様    0: それ以外
  ///***********************************************************************
  static Future<bool> rcChkMstProcess() async {
    if (await CmCksys.cmMstConnectSystem() != 0) {
      return true;
    }
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_INFOX_Process
  static bool rcChkINFOXProcess() {
  // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
  // DEPARTMENT_STOREが0で定義されていたので、この部分はコメントアウトしておく。
  //#if DEPARTMENT_STORE
  //   if(((RC_INFO_MEM->RC_CNCT.CNCT_GCAT_CNCT == 0) && (RC_INFO_MEM->RC_CNCT.CNCT_CARD_CNCT == 4)) ||
  //   (RC_INFO_MEM->RC_CNCT.CNCT_GCAT_CNCT == 4) || (RC_INFO_MEM->RC_CNCT.CNCT_GCAT_CNCT == 20) || (RC_INFO_MEM->RC_CNCT.CNCT_GCAT_CNCT == 24)) {
  //   if(rc_Check_Marine5_Simizuya()) {
  //   if((CMEM->stat.Depart_Flg & 0x01           ) ||   /* 自社クレジット宣言中？ */
  //   (CMEM->working.crdt_reg.multi_flg & 0x20) ||   /* 承認番号取得済み取引   */
  //   (CMEM->working.crdt_reg.multi_flg & 0x08)) {   /* 個別割賦払い利用       */
  //   return(FALSE);
  //   }
  //   else {
  //   return(TRUE);   /* CCT連動は他クレのみ */
  //   }
  //   }
  //   else {
  //   return(TRUE);
  //   }
  //   }
  //   else {
  //   return(FALSE);
  //   }
  //#else
    return (((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 0)
        && (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 4))
        || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 4)
        || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 20)
        || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 24));
   //#endif
  }

  ///関連tprxソース: rcsyschk.c - rcChk_EdyNoMbr_System
  static Future<bool> rcChkEdyNoMbrSystem() async {
    return ((!await RcSysChk.rcCheckOutSider()) &&
        (!RcSysChk.rcSROpeModeChk()) &&
        (await CmCksys.cmEdyNoMbrSystem() != 0));
  }

  ///関連tprxソース: rcsyschk.c - rcChk_Ytrm_Process
  static bool rcChkYtrmProcess() {
    return (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 13);
  }

  ///関連tprxソース: rcsyschk.c - rcChk_SuicaCAT_System
  static bool rcChkSuicaCATSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogSuicaCat != RecogValue.RECOG_NO.index)
        && ((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 5)
            || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 9)
            || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 14))) {
      /* 承認キー：Suica決済[CAT接続]する ＆ スペック(周辺装置)カード決済機接続：IP-3100 or MP-70 or F-CAT */
      return true;
    } else if (((RcRegs.rcInfoMem.rcRecog.recogSuicaCat != RecogValue.RECOG_NO.index)
        || (RcRegs.rcInfoMem.rcRecog.recogCctEmoneySystem != RecogValue.RECOG_NO.index))
        && (RcRegs.rcInfoMem.rcRecog.recogYamatoSystem == RecogValue.RECOG_NO.index)
        && ((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 3)
            || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 12)
            || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 16)
            || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 4)
            || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 20)
            || (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 24))){
      /* 承認キー：Suica決済[CAT接続]する 又は CCT電子マネー決済する + ヤマト電子マネー決済しない */
      /* スペック(周辺装置)カード決済機接続：JET-B or INFOX or CATS701 or SHOPCRAID */
      return true;
    } else {
      return false;
    }
  }

  /// NEC製決済端末(SHOPCRAID)が接続されているかどうか判定
  /// 関連tprxソース: rcsyschk.c - rcsyschk_shopcraid_process
  /// 引数 : 追加機能の種類
  /// 戻り値 : 結果
  static bool rcsyschkShopcraidProcess() {
    if (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 16) {
      return true;
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcChk_CATS701_Process
  static bool rcChkCATS701Process() {
    return (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 12);
  }

  //実装は必要だがARKS対応では除外
  /// PCT端末接続されているか確認
  /// 関連tprxソース: rcsyschk.c - rcsyschk_pct_connect_system
  /// 引数 : なし
  /// 戻り値 : true :PCT端末接続している, false :PCT端末接続していない
  static bool rcsyschkPctConnectSystem() {
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_Onepay_System
  static Future<bool> rcChkOnepaySystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogOnepaysystem != 0) &&
        (!await rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem()))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_LinePay_System
  static Future<bool> rcChkLinePaySystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogLinepaySystem != 0) &&
        (!await rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem()))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_BarcodePay1_System
  static Future<bool> rcChkBarcodePay1System() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogBarcodePay1System != 0) &&
        (!await rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem()))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_CANALPaymentService_System
  static Future<bool> rcChkCANALPaymentServiceSystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogCanalPaymentServiceSystem != 0) &&
        (await CmCksys.cmCanalPaymentServiceSystem() != 0) &&
        (!await rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem()))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_FujitsuFIPCodepay_System
  static Future<bool> rcChkFujitsuFIPCodepaySystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogFujitsuFipCodepaySystem != 0) &&
        (await CmCksys.cmFujitsuFipCodepaySystem() != 0) &&
        (!await rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem()))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_MultiOnepay_System
  static Future<bool> rcChkMultiOnepaySystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogMultiOnepaysystem != 0) &&
        (await CmCksys.cmMultiOnepaySystem() != 0) &&
        (!await rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem()))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_NetstarsCodepay_System
  static Future<bool> rcChkNetstarsCodepaySystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogNetstarsCodepaySystem != 0) &&
        (await CmCksys.cmNetstarsCodepaySystem() != 0) &&
        (!await rcCheckOutSider()) &&
        (rcRGOpeModeChk() || rcVDOpeModeChk() || rcTROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem()))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcsyschk_QuizCodepay_System
  static Future<int> rcsyschkQuizCodepaySystem() async {
    if ((rcsyschkQuizPaymentSystem() != 0) &&
        (!await rcCheckOutSider()) &&
        ((rcRGOpeModeChk()) || (rcVDOpeModeChk()) || (rcTROpeModeChk())) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem()))) {
      return 1;
    } else {
      return 0;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcsyschk_quiz_payment_system
  static int rcsyschkQuizPaymentSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogQuizPaymentSystem != 0) {
      return 1;
    }
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///関連tprxソース: rcsyschk.c - rcChk_Smartplus_System
  static bool rcChkSmartplusSystem() {
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_FWT_Process
  static bool rcChkFWTProcess() {
    return (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 14);
  }

  ///関連tprxソース: rcsyschk.c - rcChk_G_CAT_Connect
  static bool rcChkGCATConnect() {
    return (((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 0) &&
            (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 1)) ||
        (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 1));
  }

  ///関連tprxソース: rcsyschk.c - rcChk_SG_T_Connect
  static bool rcChkSGTConnect() {
    return (((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 0) &&
            (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 2)) ||
        (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 2));
  }

  ///関連tprxソース: rcsyschk.c - rcChk_JET_A_Process
  static bool rcChkJETAProcess() {
    return (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 8);
  }

  ///関連tprxソース: rcsyschk.c - rcChk_CT3100_Process
  static bool rcChkCT3100Process() {
    if (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 7) {
      return true;
    } else {
      return false;
    }
  }

  ///関連tprxソース: rcsyschk.c - rcChk_IP3100_Process
  static bool rcChkIP3100Process() {
    return ((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 5) ||
        (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 9)); /* IP-3100 or MP-70 */
  }

  /// GMO提供のVEGA端末の連動チェック
  /// 関連tprxソース: rcsyschk.c - rcsyschk_GMO_VEGA_system
  /// 引数 : なし
  /// 戻り値 : 結果
  static Future<bool> rcsyschkGMOVEGASystem() async {
    if (RcRegs.rcInfoMem.rcRecog.recogCctConnectSystem != 0) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) { // フルセルフでは利用しない
        return false;
      }
      if (await rcQCChkQcashierSystem()) { // QCashierでは利用しない
        return false;
      }
      //QCJC機能は対象外のためコメント化
      // if((mac_infojson.internal_flg.gcat_cnct == 21)
      //     || (mac_infojson.internal_flg.gcat_cnct == 21)){ // QCJCも気にしておく
      //   return true;
      // }
    }
    return false;
  }

  ///関連tprxソース: rcsyschk.c - rcChk_FSCa_AutoPoint
  static Future<bool> rcChkFSCaAutoPoint() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    if ((await CmCksys.cmCT3100PointSystem() != 0) &&
        (pCom.dbTrm.autoPointWorkCt3100 != 0)) {
      return true;
    } else {
      return false;
    }
  }

  /// 明細送信[INFOX]仕様キーがセットされているか判定する
  /// 関連tprxソース: rcsyschk.c - rcsyschk_infox_creditdetail_send_system
  /// 引数 : なし
  /// 戻り値 : true :セットされている, false :セットされていない
  static bool rcsyschkInfoxCreditdetailSendSystem() {
    if (!rcChkINFOXProcess()) {
      return false;
    }

    if (RcRegs.rcInfoMem.rcRecog.recogInfoxDetailSendSystem != 0) {
      return true;
    } else {
      return false;
    }
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///関連tprxソース: rcsyschk.c - rcChk_Mbrprc_System
  static bool rcChkMbrprcSystem() {
    return false;
  }

  /// 関連tprxソース: rcsyschk.c -rcChk_PrecaTyp
  /*************************************************************************
      関数：rcChk_PrecaTyp(void)
      機能：プリカ仕様の承認キーを判別する
      引数：なし
      戻値：0 : 該当仕様無し
      1 : CoGCa
      2 : 寺岡プリカ
      3 : レピカ
      4 : ゆめか
      5 : バリューカード
      6 : AJS
      7 : NEC(IEMS) 特定SM19仕様 ニシムタ様特注
      8 : NEC(IEMS) 標準
      ※新規プリカはここへ追加すること(アークス版プリカは除く)
      ※戻り値はrcregs.hで定義した値を使用すること
  *************************************************************************/
  static Future<int> rcChkPrecaTyp() async {
    if ((await rcChkCogcaSystem())) {
      return PRECA_TYPE.PRECA_COGCA.precaTypeCd;
    } else if (rcChkRepicaSystem()) {
      return PRECA_TYPE.PRECA_REPICA.precaTypeCd;
    } else if (rcChkValueCardSystem()) {
      return PRECA_TYPE.PRECA_VALUE.precaTypeCd;
    } else if ((await rcChkAjsEmoneySystem())) {
      return PRECA_TYPE.PRECA_AJS.precaTypeCd;
    } else {
      return 0;
    }
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///関連tprxソース: rcsyschk.c - rcsyschk_2800_VFHD_system
  static bool rcsyschk2800VFHDSystem() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///関連tprxソース: rcsyschk.c - rcChk_RPointMbr_Read_TMC_QCashier
  static int rcChkRPointMbrReadTMCQCashier() {
    return 0;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///関連tprxソース: rcsyschk.c - rcChk_FIP_Emoney_Standard_System
  static bool rcChkFIPEmoneyStandardSystem() {
    return false;
  }

  /// 特定WS仕様のフラグを返す
  /// 戻り値: false=上記仕様ではない  true=上記仕様
  /// 関連tprxソース: rcsyschk.c - rcChk_WS_System
  static bool rcChkWSSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogWsSystem != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_QCJC_Checker
  static Future<bool> rcCheckQCJCChecker() async {
    if ((await rcCheckQCJCSystem()) && (CmCksys.cmQCJCCSystem() == 1)) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_QCJC_Cashier
  static Future<bool> rcCheckQCJCCashier() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return false;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    CmdFunc cmdFunc = CmdFunc();

    if ((await rcCheckQCJCSystem()) &&
        (tsBuf.chk.cash_pid == cmdFunc.getPid())) {
      return true;
    } else {
      return false;
    }
  }

  /// 置数 + クレジット宣言が可能かを判断する
  /// 関連tprxソース: rcsyschk.c - rcCheckEntryCrdtMode
  /// 引数：なし
  /// 戻値：true:可能  false:不可能
  static Future<bool> rcCheckEntryCrdtMode() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (rcsyschkSm66FrestaSystem()) {
      return false;
    }

    if ((pCom.dbTrm.enableEntCreditOpe != 0) &&
        (await CmCksys.cmCrdtSystem() == 1) // クレジット仕様
        //  && (C_BUF->db_trm.separate_chg_amt == 0)		// 個別釣銭仕様  しない
        &&
        (await rcCheckIndividChange() == false) // 個別釣銭仕様  しない
        &&
        (pCom.dbTrm.nonChangeOverAmt == 0) // 券面金額お釣無し仕様でないこと
        &&
        (pCom.dbTrm.originalCardOpe == 0) // ハピー仕様でないこと
        &&
        (pCom.dbTrm.atreCashPointIp3100 == 0) // atre仕様でないこと
        &&
        (pCom.dbTrm.crdtStlpdscOpe == 0) // クレジット小計割引  しない
        //  && (cm_catalina_system() == FALSE)
        &&
        (rcChkCustrealOPSystem() == false) &&
        (await rcSGChkSelfGateSystem() == false) &&
        (await rcQCChkQcashierSystem() == false)) {
      return true;
    }
    return false;
  }

  /// 特定SM66仕様(フレスタ様)の承認キー設定有無判定
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm66_fresta_system
  /// 引数：なし
  /// 戻値：true:特定SM66仕様である  false:特定SM66仕様ではない
  static bool rcsyschkSm66FrestaSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogSm66FrestaSystem != 0) {
      return true;
    }
    return false;
  }

  /// 個別釣銭仕様が有効かどうかのチェック
  /// 関連tprxソース: rcsyschk.c - rcCheck_Individ_Change
  /// 引数：なし
  /// 戻値：true:この仕様は有効  false:この仕様は無効
  static Future<bool> rcCheckIndividChange() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (!(await CmCksys.cmReceiptQrSystem() != 0)) {
      if (pCom.dbTrm.separateChgAmt == 1) {
        return true;
      }
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_CAPS_CAFIS_System
  static Future<bool> rcChkCapSCafisSystem() async {
    if ((await CmCksys.cmCapsCafisSystem() != 0) &&
        (!await rcCheckOutSider()) &&
        ((rcRGOpeModeChk()) || (rcVDOpeModeChk()) || (rcTROpeModeChk()))
        //    && (rcKy_Self() != KY_CHECKER)
        &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem())) &&
        (!(rcChkCrdtUser() != 0))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_CAPS_CAFIS_Standard_System
  static Future<bool> rcChkCapsCafisStandardSystem() async {
    if ((await CmCksys.cmCAPSCAFISStandardSystem() != 0) &&
        (!await rcCheckOutSider()) &&
        ((rcRGOpeModeChk()) || (rcVDOpeModeChk()) || (rcTROpeModeChk()))
        //    && (rcKy_Self() != KY_CHECKER) )
        //    && (rcKy_Self() != KY_CHECKER)
        &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem())) &&
        (!(rcChkCrdtUser() != 0))) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_OutSider
  static Future<bool> rcCheckOutSider() async {
    if (await CmCksys.cmWizAbjSystem() != 0) {
      if ((rcCheckPrchker()) || (rcCheckMobilePos()) || (rcCheckWiz())) {
        return true;
      } else {
        if (await rcCheckWizAdjUpdate() == true) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return ((rcCheckPrchker()) || (rcCheckMobilePos()) || (rcCheckWiz()));
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_V_Chain
  static bool rcCheckVChain() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((rcChkCrdtUser() == 0) && (pCom.dbTrm.connectSbsCredit2 != 0)) {
      return true;
    } else {
      return false;
    }
  }

  /// 全日食様仕様のフラグを返す
  /// 関連tprxソース: rcsyschk.c - rcChk_ZHQ_system
  /// 引数：なし
  /// true:全日食様仕様  false:それ以外
  static Future<bool> rcChkZHQsystem() async {
    if (await CmCksys.cmZHQSystem() != 0) {
      return true;
    }
    return false;
  }

  /// 置数数 + クレジット宣言が可能か判定(フレスタ様）
  /// 関連tprxソース: rcsyschk.c - rcCheckEntryCrdtSystem
  /// 引数：なし
  /// 戻値：true:利用可能  false:利用不可
  static Future<bool> rcCheckEntryCrdtSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((rcsyschkSm66FrestaSystem()) &&
        (await CmCksys.cmCrdtSystem() == 1)
        //    && (rcCheck_Individ_Change() == FALSE)	// 個別釣銭仕様  しない
        //    && ((C_BUF->db_trm.non_change_over_amt) == 0)	// 券面金額お釣無し仕様でないこと
        &&
        (pCom.dbTrm.originalCardOpe == 0) &&
        (pCom.dbTrm.atreCashPointIp3100 == 0) &&
        (pCom.dbTrm.crdtStlpdscOpe == 0) &&
        (!await rcSGChkSelfGateSystem()) &&
        (!await rcQCChkQcashierSystem())) {
      return true;
    }
    return false;
  }

  /// 後通信仕様[置数○○仕様]が有効か判定する
  /// 関連tprxソース: rcsyschk.c - rcsyschk_LastComm_system
  /// 引数：なし
  /// 戻値：true:後通信仕様[置数○○仕様]が有効  false:後通信仕様[置数○○仕様]が無効
  static Future<bool> rcsyschkLastCommSystem() async {
    if ((await rcCheckEntryCrdtMode()) ||
        (await rcChkEntryPrecaTyp() != 0) ||
        (rcsyschkRpointSystem() != 0)) {
      return true;
    }
    return false;
  }

  /// 置数プリペイド対応（後通信）プリカ仕様の承認キーを判別する
  /// 関連tprxソース: rcsyschk.c - rcChk_EntryPrecaTyp
  /// 引数：なし
  /// 戻値：0:該当仕様無し, 1:CoGCa, 3:レピカ, 4:ゆめか, 5:バリューカード,
  ///      6:AJS, 7:NEC(IEMS) 特定SM19仕様 ニシムタ様特注, 8:NEC(IEMS) 標準
  ///     ※新規で置数プリペイド対応した場合はここへ追加すること
  ///     ※戻り値はrcregs.hで定義した値を使用すること
  static Future<int> rcChkEntryPrecaTyp() async {
    if ((await rcChkCogcaSystem())) {
      return PRECA_TYPE.PRECA_COGCA.precaTypeCd;
    } else if (rcChkRepicaSystem()) {
      return PRECA_TYPE.PRECA_REPICA.precaTypeCd;
    }
    //#if 0	//@@@ 15ver_merge
    //   else if(rcChk_Yumeca_pol_System())
    //   {
    //   return(PRECA_YUMECA);
    //   }
    //#endif
    else if (rcChkValueCardSystem()) {
      return PRECA_TYPE.PRECA_VALUE.precaTypeCd;
    } else if ((await rcChkAjsEmoneySystem())) {
      return PRECA_TYPE.PRECA_AJS.precaTypeCd;
    }
    //#if 0	//@@@ 15ver_merge
    //   else if ( rcChk_Nec_Emoney_System() && RC_INFO_MEM->RC_RECOG.RECOG_SM19_NISHIMUTA_SYSTEM )
    //   {	// 特定SM19仕様 ニシムタ様特注
    //   return (PRECA_NMONEY);
    //   }
    //   else if (rcChk_Nec_Emoney_System())
    //   {
    //   return(PRECA_NMONEY_STD);
    //   }
    //   else if (rcChk_CoopSaving_System())
    //   {
    //   return(PRECA_COOP_SAVING);
    //   }
    //#endif
    else {
      return 0;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_RegAssist_System
  static Future<bool> rcChkRegAssistSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (!await rcChkRegAssistSystemChkType(1)) {
      //web2500は不可
      return false;
    }
    if (pCom.dbTrm.easyUiMode != 0) {
      return false;
    }
    if (await rcSGChkSelfGateSystem()) {
      return false;
    }
    if (await rcQCChkQcashierSystem()) {
      return false;
    }
    return true;
  }

  /// 拡張機能の有無を確認する
  /// 引数:[chkFlg] 機種確認（0=しない  1=する）
  /// 関連tprxソース: rcsyschk.c - rcChk_RegAssist_System_ChkType
  static Future<bool> rcChkRegAssistSystemChkType(int chkFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    int webTyp = await CmCksys.cmWebType();
    switch (webTyp) {
      case CmSys.WEBTYPE_WEB2100:
      case CmSys.WEBTYPE_WEBPRIME:
      case CmSys.WEBTYPE_WEB2200:
      case CmSys.WEBTYPE_WEBPLUS:
      case CmSys.WEBTYPE_WEB2300:
      case CmSys.WEBTYPE_WEB2350:
      case CmSys.WEBTYPE_WEBPLUS2:
        return false;
      case CmSys.WEBTYPE_WEB2500:
        if (pCom.vtclRm5900RegsOnFlg) {
          break;
        }
        if (chkFlg == 1) {
          //機種確認する
          return false; //使用不可
        }
        break; //機種確認しない仕様では使用可
      case CmSys.WEBTYPE_WEB2800:
        //#if 0
        //   //イレギュラーなものはホワイトリストで判定
        //   if(cm_web3800_system( ) )	//Web3800
        //       {
        //   return(1);	//使用可
        //   }
        //   if(cm_HappySelf_system())	//HappySelf
        //       {
        //   return(1);	//使用可
        //   }
        //
        //   if(chk_flg == 1)	//機種確認する
        //       {
        //   web28_type = cm_Web2800Type();
        //   switch(web28_type)
        //   { //WEBTYPE_WEB2800の中で使用不可のものリスト
        //   case WEB28TYPE_I   :
        //   case WEB28TYPE_SP  :
        //   case WEB28TYPE_IP  :
        //   case WEB28TYPE_IM  :
        //   case WEB28TYPE_SPP :
        //   case WEB28TYPE_SP3 :
        //   case WEB28TYPE_I3  :
        //   return(0);
        //   case WEB28TYPE_A3 :
        //   //イレギュラーなものあり。 *** 注意 ***
        //   return(0);
        //   default :
        //   break;
        //   }
        //   }
        //#endif
        break; //機種確認しない仕様では使用可
      default:
        break;
    }
    return true;
  }

  /// Shop&Go仕様かを判定
  /// 関連tprxソース: rcsyschk.c - rcChk_Shop_and_Go_System
  /// 引数：なし
  /// 戻値：true:Shop&Go仕様である  false:Shop&Go仕様ではない
  static Future<bool> rcChkShopAndGoSystem() async {
    if (!await rcQCChkQcashierSystem()) {
      /* QCashier以外は無効 */
      return false;
    }
    if (RcRegs.rcInfoMem.rcRecog.recogShopAndGoSystem != 0) {
      return true;
    }
    return false;
  }

  // TODO:00014 日向 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcsyschk.c - rcChk_Shop_and_Go_DeskTop_System
  static bool rcChkShopAndGoDeskTopSystem() {
    return false;
  }

  /// Cashierお会計券印字仕様かを判定する
  /// 関連tprxソース: rcsyschk.c - rcChk_Cashier_QR_Print
  /// 引数：なし
  /// 戻値：true:Cashierお会計券印字仕様である  false:Cashierお会計券印字仕様でない
  static Future<bool> rcChkCashierQRPrint() async {
    if (rcsyschkYunaitoHdSystem() != 0) {
      return false;
    }
    if (!await rcsyschkNormalMode()) {
      return false;
    }
    if ((RcRegs.rcInfoMem.rcRecog.recogReceiptQrSystem != 0)
        && (await rcKySelf() == RcRegs.KY_DUALCSHR)
        && ((rcRGOpeModeChk()) || (rcTROpeModeChk()))){
      return true;
    }

    return false;
  }

  //実装は必要だがARKS対応では除
  /// ユナイトホールディングス様仕様かを判定
  /// 関連tprxソース: rcsyschk.c - rcsyschk_yunaito_hd_system
  /// 引数：なし
  /// 戻値：true:ユナイトホールディングス様仕様である  false:ユナイトホールディングス様仕様でない
  static int rcsyschkYunaitoHdSystem() {
    if ((rcsyschkSm55TakayanagiSystem() == 1) ||
        (rcsyschkSm5ItokuSystem() == 1)) {
      return 1;
    }
    return 0;
  }

  /// happy,smile以外の通常有人レジ
  /// 関連tprxソース: rcsyschk.c - rcsyschk_normal_mode
  /// 引数：なし
  /// 戻値：true:通常レジである  false:通常レジではない
  static Future<bool> rcsyschkNormalMode() async {
    if ((await rcChkSmartSelfSystem()) ||
        (await rcCheckQCJCSystem()) ||
        (await rcQCChkQcashierSystem()) ||
        (await rcChkShopAndGoSystem()) ||
        (await rcChkDesktopCashier())) {
      return false;
    }
    return true;
  }

  /// Speezaで精算された品券、会計取引実績をQCashier側でUPDATEするか否かを判定する
  /// 関連tprxソース: rcsyschk.c - rcsyschk_alltran_update_qc_side
  /// 引数：なし
  /// 戻値：true:UPDATEする  false:UPDATEしない
  static Future<bool> rcsyschkAlltranUpdateQCSide() async {
    if (await rcQRChkPrintSystem()) {
      return true;
    }
    return false;
  }

  /// 特殊乗算オペレーションか判定結果を返す
  /// 関連tprxソース: rcsyschk.c - rcChk_SpecialMultiOpe
  /// 引数：なし
  /// 戻値：true:特殊乗算オペレーション  false:特殊乗算オペレーションではない
  static bool rcChkSpecialMultiOpe() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((pCom.dbTrm.specialMultiOpe == 1) && (rcCheckTECOperation() == 2)) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_TEC_Operation
  static int rcCheckTECOperation() {
    int ret;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (rcChkWSSystem()) {
      if ((RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_GRATIS.keyId])) ||
          (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_NOTAX.keyId]))) {
        return 0;
      }
    }

    ret = 0;
    if (!rcCheckEtcOperation()) {
      ret = pCom.dbTrm.mulSmlDscUsetyp;
    }
    return ret;
  }

  /// オペレーションが「その他」かチェックする（＝カネスエ様仕様かチェックする）
  /// 関連tprxソース: rcsyschk.c - rcCheck_etc_Operation
  static bool rcCheckEtcOperation() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.kanesueNewopeFunc != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// ユナイト様　登録オペレーション設定判断
  /// 関連tprxソース: rcsyschk.c - rcsyschk_Unite_RegTerm
  /// 引数：なし
  /// 戻値：true:ユナイト様　登録オペレーション  false:ユナイト様　登録オペレーションではない
  static bool rcsyschkUniteRegTerm() {
    if ((rcsyschkYunaitoHdSystem() != 0) &&
        (rcCheckTECOperation() == 2) &&
        (!rcCheckEtcOperation())) {
      return true;
    }
    return false;
  }

  /// IIS21接続しているかチェックする
  /// 戻り値: false:未接続　 true:接続
  /// 関連tprxソース: rcsyschk.c - rcCheck_Prchker
  static bool rcCheckPrchker() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PRC.keyId]))
        && (RcRegs.kyStC7(cMem.keyStat[FuncKey.KY_PRC.keyId]))
        && (RcRegs.rcInfoMem.rcCnct.cnctMobileCnct == 0));
  }

  /// モバイルPOS接続しているかチェックする
  /// 戻り値: false:未接続　 true:接続
  /// 関連tprxソース: rcsyschk.c - rcCheck_MobilePos
  static bool rcCheckMobilePos() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((!(RcRegs.rcInfoMem.rcCnct.cnctMobileCnct == 0))
        && (RcRegs.kyStC7(cMem.keyStat[FuncKey.KY_PRC.keyId])));
  }

  /// Wiz仕様のフラグを返す
  /// 戻り値: 0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース: rcsyschk.c - rcCheck_Wiz
  static bool rcCheckWiz() {
    AcMem cMem = SystemFunc.readAcMem();
    return (RcRegs.kyStC6(cMem.keyStat[FuncKey.KY_PRC.keyId]));
  }

  /// 金種商品バーコードを小計画面でのみ読み込み可能とする仕様
  /// 関連tprxソース: rcsyschk.c - rcsyschk_NotePlu_Stl_ModeOnly
  /// 引数：なし
  /// 戻値：true:仕様が有効  false:仕様が無効
  static Future<bool> rcsyschkNotePluStlModeOnly() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (((rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
            (await CmCksys.cmCrdtSystem() != 0)) ||
        (pCom.dbTrm.notePluReg == 0)) {
      return true;
    }
    return false;
  }

  /// QCashierなどでキーオプションの設定を変更する際に使用する仕様
  /// 関連tprxソース: rcsyschk.c - rcChk_QR_Kopt_Status_Change
  /// 引数：なし
  /// 戻値：true:仕様が有効  false:仕様が無効
  static bool rcChkQRKoptStatusChange() {
    AcMem cMem = SystemFunc.readAcMem();

    return (cMem.qrChgKoptFlg != 0);
  }

  /// カード決済機接続(デビット/クレジット)がVEGAか否か判定
  /// 関連tprxソース: rcsyschk.c - rcChk_VEGA_Process
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static Future<bool> rcChkVegaProcess() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (CompileFlag.CENTOS) {
      if (CompileFlag.ARCS_VEGA) {
        //VEGA仕様（12verで追加）
        RegsMem regsMem = SystemFunc.readRegsMem();
        if (!((((regsMem.tTtllog.t100700Sts.mbrTyp == Mcd.MCD_RLSCARD) &&
                    ((regsMem.workInType == 2) || (regsMem.workInType == 1))) ||
                (regsMem.tTtllog.t100700Sts.mbrTyp == Mcd.MCD_RLSHOUSE) ||
                (regsMem.tTtllog.t100700Sts.mbrTyp == Mcd.MCD_RLSPREPAID)) &&
            (ReptEjConf.rcCheckRegistration()))) {
          AcMem cMem = SystemFunc.readAcMem();
          if (((cMem.working.crdtReg.stat & 0x0001) == 1) &&
              (await CmCksys.cmNttaspSystem() == 1)) {
            return false;
          }
          if ((await CmCksys.cmUSBICCardChk() == 0) //ICカードリーダ未設定
                  &&
                  (await CmCksys.cmCogcaSystem() == 1) //CoGCa仕様
                  &&
                  (CmCksys.cmQCashierJCSystem() == 1) //QCashierJCモード
                  &&
                  (pCom.iniMacInfo.internal_flg.mode == 3) //訂正モード
              ) {
            return (pCom.iniMacInfo.internal_flg.gcat_cnct == 19);
            /*
          //元ソースの return は、QCJC周辺装置(WebSpeezaC)用iniファイルも参照する
          return ((pCom.iniMacInfo.internal_flg.gcat_cnct == 19)
              || (pCom.iniMacInfoJcC.internal_flg.gcat_cnct == 19));
           */
          } else {
            return (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 19);
          }
        }
      } else {
        if ((await CmCksys.cmUSBICCardChk() == 0) //ICカードリーダ未設定
                &&
                (await CmCksys.cmCogcaSystem() == 1) //CoGCa仕様
                &&
                (CmCksys.cmQCashierJCSystem() == 1) //QCashierJCモード
                &&
                (pCom.iniMacInfo.internal_flg.mode == 3) //訂正モード
            ) {
          return (pCom.iniMacInfo.internal_flg.gcat_cnct == 19);
          /*
          //元ソースの return は、QCJC周辺装置(WebSpeezaC)用iniファイルも参照する
          return ((pCom.iniMacInfo.internal_flg.gcat_cnct == 19)
              || (pCom.iniMacInfoJcC.internal_flg.gcat_cnct == 19));
           */
        } else {
          return (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 19);
        }
      }
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcSG_Check_RfmPrn_System
  static bool rcSGCheckRfmPrnSystem() {
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Prom_Alert
  static Future<bool> rcChkPromAlert() async {
    if (await CmCksys.cmPromotionUniqueBmp() != 0) {
      RegsMem mem = RegsMem();
      if ((mem.tHeader.ope_mode_flg != OpeModeFlagList.OPE_MODE_VOID) &&
          (mem.tTtllog.t100003.voidFlg != 1) &&
          (mem.tmpbuf.prombmpNonfile == 1)) {
        return true;
      }
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_dPointRead
  static int rcChkdPointRead() {
    RegsMem mem = RegsMem();
    if ((rcChkDPointSystem()) && (mem.tTtllog.t100770.dpntInMethod != 0)) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_Segment
  static Future<bool> rcCheckSegment() async {
    if (await CmCksys.cmSegmentChk() == 1) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Felica_System
  static Future<bool> rcChkFelicaSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    return ((!await rcCheckOutSider()) &&
        (!rcSROpeModeChk()) &&
        ((await rcKySelf() != RcRegs.KY_CHECKER) ||
            (await rcCheckQCJCSystem())) &&
        (await RcMbrCom.rcmbrChkStat() != 0) &&
        (await CmCksys.cmEdySystem() != 0 ||
            await CmCksys.cmSPVTSystem() != 0) &&
        (await CmCksys.cmFeliCaSystem() != 0) &&
        (await CmCksys.cmMcSystem() == 0) &&
        ((RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 5) ||
            (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 7) ||
            await CmCksys.cmSPVTSystem() != 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 0) &&
        (cBuf.dbTrm.memUseTyp == 1) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) != 1) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) != 2) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) != 3) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) != 4) &&
        ((!await rcSGChkSelfGateSystem()) ||
            ((await rcSGChkSelfGateSystem()) &&
                ((cBuf.dbTrm.selfSlctKeyCd == 3) ||
                    (cBuf.dbTrm.selfSlctKeyCd == 4) ||
                    (cBuf.dbTrm.selfSlctKeyCd == 5)))));
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_SelfCrdt_System
  static Future<bool> rcChkSelfCrdtSystem() async {
    return ((await CmCksys.cmCrdtSystem() != 0) &&
        ((RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 0) ||
            (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 5) ||
            (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 7)));
  }

  /// 免税仕様の承認キーがセットされているか判定する
  /// 引数：なし
  /// 戻値：0:セットされていない 1:セットされている
  /// 関連tprxソース: rcky_taxfreein.c - rcsyschk_taxfree_system
  static Future<int> rcsyschkTaxfreeSystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogTaxFreeSystem != 0) ||
        (await rcsyschkTaxfreeServerSystem() != 0)) {
      return 1;
    } else {
      return 0;
    }
  }

  /// 免税電子化仕様の承認キーがセットされているか判定する
  /// 引数：なし
  /// 戻値：0:セットされていない 1:セットされている
  /// 関連tprxソース: rcky_taxfreein.c - rcsyschk_taxfree_server_system
  static Future<int> rcsyschkTaxfreeServerSystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogTaxfreeServerSystem != 0) &&
        (await CmCksys.cmTaxfreeServerSystem() != 0)) {
      return 1;
    } else {
      return 0;
    }
  }

  /// Sapporo Realシステムかチェックする
  /// 関連tprxソース: rcsyschk.c - rcChk_Sapporo_Real_System
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static Future<bool> rcChkSapporoRealSystem() async {
    if (await rcCheckOutSider()) {
      return false;
    }
    if (rcSROpeModeChk()) {
      return false;
    }
    return (await CmCksys.cmSapporoRealSystem() != 0);
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  ///
  /// 関連tprxソース: rcsyschk.c - rcChk_Recipe_System
  static bool rcChkRecipeSystem() {
    return false;
  }

  /// one to one プロモーション仕様のフラグを返す
  /// 関連tprxソース: rcsyschk.c - rcChk_OneToOneProm_System
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static Future<bool> rcChkOneToOnePromSystem() async {
    if (await RcMbrCom.rcmbrChkStat() != 0) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_RefundStlDsc_System
  static bool rcChkRefundStlDscSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    return (pCom.dbTrm.refundStldsc == 1);
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_StlPDsc_OneTenth
  static bool rcChkStlPDscOneTenth() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.stlAutodisc1_10times != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_MbrRCPdsc_System
  static bool rcChkMbrRCPdscSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    return ((pCom.dbTrm.rcDiscOpe != 0) && (rcChkMbrPriSystem()));
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Mbr_Pri_System
  static bool rcChkMbrPriSystem() {
    return true;
  }

  /// 特定QR読込1仕様の承認キー設定有無判定
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sp1_qr_read_system
  /// 引数：なし
  /// 戻値：true:仕様が有効  false:仕様が無効
  static bool rcsyschkSp1QrReadSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogSp1QrReadSystem != 0) {
      return true;
    }
    return false;
  }

  /// Jakkulu Panaシステムかチェックする
  /// 関連tprxソース: rcsyschk.c - rcChk_Jkl_Pana_System
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static Future<bool> rcChkJklPanaSystem() async {
    if (await rcCheckOutSider() || rcSROpeModeChk()) {
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    return (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT == 1) &&
        (await CmCksys.cmSapporoPanaSystem() == 1) &&
        (pCom.dbTrm.memUseTyp == 1) &&
        (pCom.dbTrm.rwtInfo == 0) &&
        (pCom.dbTrm.jackleDispMbrnum16d == 0));
  }

  /// マルチパーセント割引システムかチェックする
  /// 関連tprxソース: rcsyschk.c - rcChk_TtlMulPDsc_System
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static bool rcChkTtlMulPDscSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.chgCulcItemcatDisc == 1) {
      return true;
    }
    return false;
  }

  /// アヤハディオ仕様かチェックする
  /// 関連tprxソース: rcsyschk.c - rcsyschk_ayaha_system
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static bool rcsyschkAyahaSystem() {
    return (RcRegs.rcInfoMem.rcRecog.recogAyahaSystem == 1);
  }

  /// クレジット訂正時に品券実績を現金扱いにするかチェックする
  /// 関連tprxソース: rcsyschk.c - rcCheckCrdtVoidGiftToCash
  /// 引数：なし
  /// 戻値：true:現金扱いする  false:現金扱いしない
  static bool rcCheckCrdtVoidGiftToCash() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((pCom.dbTrm.creditvoidChkFunc != 0) &&
        (pCom.dbTrm.acxDischaCreditVoid == 0)) {
      return true;
    }
    return false;
  }

  /// 税込値引仕様かチェックする
  /// 関連tprxソース: rcsyschk.c - rcChk_IntaxDsc_System
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static bool rcChkIntaxDscSystem() {
    return false;
  }

  /// Fresh Roaster 仕様かチェックする
  /// 関連tprxソース: rcsyschk.c - rcCheck_Fresh_Roaster
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static bool rcCheckFreshRoaster() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    if ((rcChkCrdtUser() == 0) && (pCom.dbTrm.connectSbsCredit1 > 0)) {
      return true;
    }
    return false;
  }

  /// SP/VT仕様かつクレジット仕様かチェックする
  /// 関連tprxソース: rcsyschk.c - rcChk_SPVT_System
  /// 引数：なし
  /// 戻値：true:上記仕様  false:上記仕様でない
  static Future<bool> rcChkSPVTSystem() async {
    if ((await CmCksys.cmSPVTSystem() == 1) &&
        (await CmCksys.cmCrdtSystem() == 1)) {
      if ((await rcCheckOutSider()) ||
          rcSROpeModeChk() ||
          ((await rcKySelf() == RcRegs.KY_CHECKER) &&
              !(await rcCheckQCJCSystem()))) {
        return false;
      } else {
        if ((rcChkCrdtUser() == 1) || (rcChkCrdtUser() == 3)) {
          return false;
        } else {
          return true;
        }
      }
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcCL_OpeModeChk
  static Future<bool> rcCLOpeModeChk() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.opeMode == RcRegs.CL) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_ReceiptIssue_ClerkSide
  static Future<bool> rcChkReceiptIssueClerkSide() async {
/*
#if COLORFIP
*/
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await rcChkFselfMain()) {
      if (cBuf.dbTrm.frontSelfReceipt == 1) {
        return (true);
      } else {
        return (false);
      }
    } else {
/*
#endif
*/
      return (false);
/*
#if COLORFIP
*/
    }
/*
#endif
*/
  }

  /// 関数名      : rcChk_ShopAndGo_Mode
  /// 機能概要    : Shop&Go仕様、Shop&Go状態か確認する
  /// パラメータ  : なし
  /// 戻り値      : 1 : Yes
  ///              0 : No
  /// 関連tprxソース: rcsyschk.c - rcChk_ShopAndGo_Mode
  static Future<int> rcChkShopAndGoMode() async {
    //Shop&Go仕様
    if (await rcChkShopAndGoSystem()) {
      //HappySelf仕様
      if (await rcChkShopAndGoMode() != 0) {
        //QC切替を行っている = Shop&Goモード
        if (happyQCType == 1) {
          return (1);
        } else {
          //QC切替を行っていない = フルセルフの精算画面
          return (0);
        }
      } else {
        //HappySelfでなければ、純粋なShop&Go(QCashier)
        return (1);
      }
    } else {
      return (0);
    }
  }

  /// 機能：ＣＲ５．０仕様
  /// 引数：なし
  /// 戻値：0:仕様でない 1:ＣＲ５．０仕様
  /// 関連tprxソース: rcsyschk.c - rcsyschk_cr50_system
  static Future<int> rcSysChkCr50System() async {
    if ((await rcChk2800System()) &&
        (RcRegs.rcInfoMem.rcRecog.recogCr50System != 0)) {
      return (1);
    } else {
      return (0);
    }
  }

  /// 関連tprxソース: rcsyschk.c - cm_realitmsend_system
  static bool cmRealItmSendSystem() {
    bool res = false;
    bool res2 = false;

    if (RcRegs.rcInfoMem.rcRecog.recogRealitmsend != 0) {
      res = true;
    }
    if (RcRegs.rcInfoMem.rcCnct.cnctRealitmsendCnct != 0) {
      res2 = true;
    }
    return ((res) && (res2));
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_Esvoid_Proc
  static bool rcCheckEsVoidProc() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return (cBuf.batchRptFlag);
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_AcrAcb_CinLcd
  static Future<bool> rcChkAcrAcbCinLcd() async {
    if (RcRegs.rcInfoMem.rcRecog.recogQcashierSystem != 0) {
      return (false);
    }

    if (RcRegs.rcInfoMem.rcRecog.recogSelfGate != 0) {
      return (false);
    }
/*
#if ARCS_MBR
*/
    if (await rcChkFselfMain()) {
      return (true);
    } else {
      if (RcRegs.rcInfoMem.rcRecog.recogPriceSound != 0) {
        // 暫定版対面セルフ
        return (true);
      } else {
        return (true);
      }
    }
/*
#else

#if COLORFIP
  if (rcChk_fself_Main()) {
    return(TRUE);
  } else {
#endif
    return(FALSE);
#if COLORFIP
  }
#endif
#endif
*/
  }

  /// 関数名　：rcChkQCMultiSuicaSystem
  ///
  /// 機能概要：精算機接続が可能、かつ、交通系IC支払可能なマルチ端末かチェック
  ///
  /// 引数　　：なし
  ///
  /// 戻り値　：0: 精算機接続可能、かつ、交通系IC支払可能なマルチ端末ではない
  ///
  /// 　　　　：1: 精算機接続可能、かつ、交通系IC支払可能なマルチ端末
  ///
  /// 関連tprxソース: rcsyschk.c - rcChk_QCMultiSuica_System
  static int rcChkQCMultiSuicaSystem() {
    if (rcChkMultiSuicaSystem() == MultiSuicaTerminal.SUICA_VEGA_USE.index) {
      return (1);
    }
    return (0);
  }

  /// VISMAC仕様かチェックする
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_VMC_System
  static Future<bool> rcChkVMCSystem() async {
    int res = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (await rcCheckOutSider()) {
      return false;
    }
    if (rcSROpeModeChk()) {
      return false;
    }
    // rxMemPtr(RXMEM_COMMON,(void **)&pCom);

    if (RcRegs.rcInfoMem.rcRecog.recogVismacsystem != 0) {
      res = 1;
    }

    return (((((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT) !=
                0) ||
            (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT) !=
                0)) // Member system?
        &&
        (res != 0) // Vismac System?
        &&
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 3) // Rewrite card connect?
        &&
        (!rcVDOpeModeChk()) &&
        ((await Rxmbrcom.rcmbrGetSvsMthd(pCom, null) == 5) // Service form?
            ||
            (await Rxmbrcom.rcmbrGetSvsMthd(pCom, null) == 6) ||
            (await Rxmbrcom.rcmbrGetSvsMthd(pCom, null) == 7)));
  }

  /// 関連tprxソース: rcsyschk.c - rc_Check_CustomerCard_Inq
  static Future<bool> rcCheckCustomerCardInq() async {
    /* Wiz精算仕様で、カスタマーカードを処理する条件 */
    AtSingl atSingl = SystemFunc.readAtSingl();
    if ((await CmCksys.cmWizAbjSystem() != 0) &&
        (atSingl.customercardFlg != 0)) {
      return true;
    } else {
      return false;
    }
  }

  /// 機能: 分類別明細非印字仕様の判定
  /// 引数: なし
  /// 戻値: 1:分類別明細非印字仕様である  0:分類別明細非印字仕様ではない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_detail_noprn_system
  static int rcSysChkDetailNoprnSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogDetailNoprnSystem != 0) {
      return 1;
    }
    return 0;
  }

  /// 機能：ｻｰﾋﾞｽ分類別割引仕様かを判定
  /// 引数：なし
  /// 戻値：0:ｻｰﾋﾞｽ分類別割引仕様では無い  1:ｻｰﾋﾞｽ分類別割引仕様
  /// 関連tprxソース: rcsyschk.c - rcsyschk_svscls_stlpdsc_system
  static int rcsyschkSvsclsStlpdscSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogSvsclsStlpdscSystem != 0) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rcsyschk.c - rcsyschk_kitchen_print_num_system
  static int rcsyschkKitchenPrintNumSystem() {
    if ((RcRegs.rcInfoMem.rcRecog.recogKitchenPrintNumSystem != 0)) {
      return 1;
    } else {
      return 0;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Flight_System
  static bool rcChkFlightSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    return ((pCom.dbTrm.userCd2 & 1 == 1) /* user_cd2 & 1 ?       */
        ||
        (pCom.dbTrm.userCd2 & 2 == 1) /* user_cd2 & 2 ?       */
        ||
        (pCom.dbTrm.userCd2 & 4 == 1) /* user_cd2 & 4 ?       */
        ||
        (pCom.dbTrm.userCd2 & 32 == 1)); /* user_cd2 & 32 ?      */
  }

  /// 顧客リアル[ﾕﾆｼｽ]のポイント会員か判断して返す
  /// 引数:[custNo] 会員番号
  /// 戻値: true=ポイント会員  false=ポイント会員ではない
  /// 関連tprxソース: rcsyschk.c - rcChk_unisys_member
  static Future<bool> rcChkUnisysMember(int? custNo) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((await CmCksys.cmCustrealUniSystem() == 0) || (custNo == null)) {
      return false;
    }

    // インストアマーキングから顧客のインストアフラグを取得
    String instreFlg = "";
    for (int i = 0; i < RxMem.DB_INSTRE_MAX; i++) {
      if (pCom.dbInstre[i].format_typ == 3) {
        // バーコードタイプが顧客
        instreFlg = pCom.dbInstre[i].instre_flg;
        break;
      }
    }
    // 顧客のインストアフラグと異なる会員番号なら、ポイント会員
    if (custNo != instreFlg) {
      return true;
    }

    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Recipt_NearEnd
  static Future<int> rcChkReciptNearEnd() async {
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        await getTid(),
        CompetitionIniLists.COMPETITION_INI_RCT_NEAREND_CHK,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    if (ret.value == 1) {
      return RcIfEvent.rctNearendStatus;
    }
    return 0;
  }

  /// 「ミックスマッチセットマッチ複数選択」の状態を返す
  /// TRUE 対象 FALSE 対象外
  /// 関連tprxソース: rcsyschk.c - rcChk_sch_multi_select_system
  static Future<bool> rcChkSchMultiSelectSystem() async {
    return await rcChkStmMultiSelectSystem() ||
        await rcChkBdlMultiSelectSystem();
  }

  /// 「セットマッチ複数選択」の承認状態を返す
  ///  TRUE 対象 FALSE 対象外
  /// 関連tprxソース: rcsyschk.c - rcChk_stm_multi_select_system
  static Future<bool> rcChkStmMultiSelectSystem() async {
    if ((await CmCksys.cmToySystem()) != 0 &&
        (!await rcCheckOutSider()) &&
        (RcSysChk.rcRGOpeModeChk() ||
            RcSysChk.rcVDOpeModeChk() ||
            RcSysChk.rcTROpeModeChk())) {
      return true;
    }
    return false;
  }

  ///「ミックスマッチ複数選択」の承認状態を返す
  /// TRUE PLUコード生成  FALSE 対象外
  /// 関連tprxソース: rcsyschk.c - rcChk_bdl_multi_select_system
  static Future<bool> rcChkBdlMultiSelectSystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogBdlMultiSelectSystem != 0) &&
        (!await rcCheckOutSider()) &&
        (RcSysChk.rcRGOpeModeChk() ||
            RcSysChk.rcVDOpeModeChk() ||
            RcSysChk.rcTROpeModeChk()) &&
        (await rcKySelf() != RcRegs.KY_CHECKER ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      return true;
    }
    return false;
  }

  /// Check Manual/Auto Decision System
  /// TRUE PLUコード生成  FALSE 対象外
  /// 関連tprxソース: rcsyschk.c - rcChk_AcxDecision_System
  static Future<bool> rcChkAcxDecisionSystem() async {
    if ((RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin != 0)) {
      return true;
    }
    if (await RcSysChk.rcQCChkQcashierSystem() ||
        await RcSysChk.rcSGChkSelfGateSystem()) {
      if (rcChkTRDrwAcxNotUse()) {
        return true; //精算機で練習モード時釣銭機禁止の場合、疑似的に入金確定する
      }
    }
    return false;
  }

  /// 訓練でのドロア／釣銭機の使用を禁止条件判定結果を返す
  /// 0:訓練でドロア／釣銭機を禁止する
  //           1:訓練でドロア／釣銭機を禁止しない
  /// 関連tprxソース: rcsyschk.c - rcChk_TR_DrwAcxNotUse
  static bool rcChkTRDrwAcxNotUse() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    if (RcSysChk.rcTROpeModeChk() && cBuf.dbTrm.traningDrawAcxFlg == 0) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Rwc_System
  static Future<bool> rcChkRwcSystem() async {
    return (((await rcChkSapporoPanaSystem()) ||
            (await RcSysChk.rcChkJklPanaSystem()) ||
            (await CmCksys.cmRainbowCardSystem() != 0) ||
            (await CmCksys.cmPanaMemberSystem() != 0)) ||
        (await rcChkPointCardSystem()) ||
        (await rcChkORCSystem()) ||
        (await RcSysChk.rcChkVMCSystem()) ||
        (await rcChkTRCSystem()) ||
        (await rcChkMcp200System()) ||
        (await RcSysChk.rcChkHt2980System()) ||
        (await rcChkAbsV31System()));
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_PW410_System
  static bool rcChkPW410System() {
    ///TODO:00014 日向 現計対応 定義のみ先行して追加
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_ICC_System
  static bool rcChkICCSystem() {
    ///TODO:00014 日向 現計対応 定義のみ先行して追加
    return false;
  }

  /// 顧客リアル[SM66]仕様(フレスタ様)であるかチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Custreal_Fresta_System
  static bool rcChkCustrealFrestaSystem() {
    ///TODO:00014 日向 現計対応 定義のみ先行して追加
    /*
    if (rcsyschkSm66FrestaSystem())	{
      return true;
    }
     */
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcsyschk_cosme1_istyle_system
  static bool rcsyschkCosme1IstyleSystem() {
    ///TODO:00014 日向 現計対応 定義のみ先行して追加
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_UsePoint_SelfSystem
  static bool rcChkUsePointSelfSystem() {
    ///TODO:00014 日向 現計対応 定義のみ先行して追加
    return false;
  }

  /// サッポロパナ仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Sapporo_Pana_System
  static Future<bool> rcChkSapporoPanaSystem() async {
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    if (await rcCheckOutSider()) {
      return false;
    }
    if (rcSROpeModeChk()) {
      return false;
    }
    return ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_POINT) != 0 &&
        (await CmCksys.cmSapporoPanaSystem() != 0) &&
        (cBuf.dbTrm.memUseTyp == 1) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 5) &&
        (cBuf.dbTrm.rwtInfo == 0) &&
        (cBuf.dbTrm.jackleDispMbrnum16d == 0));
  }

  /// ポイントカード仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_PointCard_System
  static Future<bool> rcChkPointCardSystem() async {
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    int res = 0;
    if (await rcCheckOutSider()) {
      return false;
    }
    if (rcSROpeModeChk()) {
      return false;
    }
    if (RcRegs.rcInfoMem.rcRecog.recogPointcardsystem != 0) {
      res = 1;
    }
    return ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_POINT) != 0 &&
        (res != 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 4) &&
        (cBuf.dbTrm.memUseTyp == 1) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 7) &&
        (cBuf.dbTrm.rwtInfo == 0));
  }

  /// ORC仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_ORC_System
  static Future<bool> rcChkORCSystem() async {
    int res = 0;
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    if (await rcCheckOutSider()) {
      return false;
    }
    if (rcSROpeModeChk()) {
      return false;
    }
    if (RcRegs.rcInfoMem.rcRecog.recogIwaisystem != 0) {
      res = 1;
    }
    return ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_POINT) != 0 &&
        (res != 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 2) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 7) &&
        (cBuf.dbTrm.rwtInfo == 0));
  }

  /// TRC仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_TRC_System
  static Future<bool> rcChkTRCSystem() async {
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    if (await rcCheckOutSider()) {
      return false;
    }
    if (rcSROpeModeChk()) {
      return false;
    }
    return ((await rcChkFspRewriteSystem()) ||
        ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_POINT) != 0 &&
            (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 1) &&
            ((await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 5) ||
                (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 6) ||
                (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 7))));
  }

  /// FSPリライトカード仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_FspRewrite_System
  static Future<bool> rcChkFspRewriteSystem() async {
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    return ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_FSP) != 0 &&
        (!rcSROpeModeChk()) &&
        (!rcCheckPrchker()) &&
        (!await RcSysChk.rcCheckOutSider()) &&
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 1) &&
        (cBuf.dbTrm.memAnyprcReduStet == 1) &&
        (cBuf.dbTrm.fspCd != 0) &&
        (cBuf.dbTrm.smpluStldscTyp != 0) &&
        ((await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 0) ||
            (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 5) ||
            (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 6) ||
            (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 7)));
  }

  /// MCP200仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Mcp200_System
  static Future<bool> rcChkMcp200System() async {
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    if (await rcCheckOutSider()) {
      return false;
    }
    if (rcSROpeModeChk()) {
      return false;
    }
    return ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_POINT) != 0 &&
        (await CmCksys.cmMcp200System() != 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 8) &&
        ((cBuf.dbTrm.memUseTyp == 1) ||
            (await CmCksys.cmDcmpointSystem() != 0)) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 5) &&
        (cBuf.dbTrm.rwtInfo == 0));
  }

  /// ABS_V31仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_AbsV31_System
  static Future<bool> rcChkAbsV31System() async {
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    if (await rcCheckOutSider()) {
      return false;
    }
    if (rcSROpeModeChk()) {
      return false;
    }
    return ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_POINT) != 0 &&
        (await CmCksys.cmAbsV31RwtSystem() != 0) &&
        (cBuf.dbTrm.memUseTyp == 1) &&
        ((await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 5) ||
            (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 6) ||
            (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 7)));
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_vesca_center_connect
  //実装は必要だがARKS対応では除外
  static int rcChkVescaCenterConnect(int cncttype) {
    return 0;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_MultiSuspend_System
  static Future<bool> rcChkMultiSuspendSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return cBuf.dbTrm.susTypFlg != 0 &&
        (await CmCksys.cmDishCalcsystem() == 0 ||
            (await CmCksys.cmDishCalcsystem() != 0 &&
                (await RcSysChk.rcKySelf() != RcRegs.DESKTOPTYPE))) &&
//	        (rcKy_Self() != KY_CHECKER) &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem())) &&
        (!rcCheckMobileEnt());
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_MobileEnt
  static bool rcCheckMobileEnt() {
    AcMem cMem = SystemFunc.readAcMem();

    return !(RcRegs.rcInfoMem.rcCnct.cnctMobileCnct == 0) &&
        RcRegs.kyStC0(cMem.keyStat[FncCode.KY_ENT.keyId]);
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_ChargeSlip_System
  static Future<bool> rcChkChargeSlipSystem() async {
    if (await rcCheckOutSider()) {
      return false;
    }
    if (!(rcRGOpeModeChk() || rcTROpeModeChk() || rcVDOpeModeChk())) {
      return false;
    }

    return await RcMbrCom.rcmbrChkStat() !=
            0 & RcMbr.RCMBR_STAT_POINT && /* Member system? */
        ((RcSysChk.rcChkCustrealsvrSystem() == 1) ||
            (RcSysChk.rcsyschkAyahaSystem())) &&
        await CmCksys.cmChargeSlipSystem() == 1;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Assist_Monitor
  static bool rcChkAssistMonitor() {
    int res = 0;
    if (RcRegs.rcInfoMem.rcRecog.recogAssistMonitor != 0) {
      res = 1;
    }
    return res == 1;
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_Prime_Stat
  static Future<int> rcCheckPrimeStat() async {
    return await CmCksys.cmWebPrimetowerSystem();
  }

  /// Check Item Display Type
  /// 関連tprxソース: rcsyschk.c - rcChk_Item_Display_Type
  static bool rcChkItemDisplayType() {
    // return((C_BUF->db_trm.trm_filler58 == 1) || (rcChk_2800_System()));
    return true; // 15ver
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_AcrAcb_System
  static Future<int> rcChkAcrAcbSystem(int modeChk) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    if (await rcCheckOutSider()) {
      return 0;
    }
    if (rcSyschkRcptAcrAcbChk() != 0) {
      return 0;
    }
    // RM-5900で自動小計の場合は、釣銭機動作は不要とする。
    if ((cBuf.vtclRm5900RegsOnFlg) && (cBuf.vtclRm5900RegsStlAcxFlg != 0)) {
      return 0;
    }
    if (modeChk != 0) {
      if (RcSysChk.rcSROpeModeChk() ||
          rcVDOpeModeChk() ||
          rcODOpeModeChk() ||
          rcIVOpeModeChk() ||
          rcPDOpeModeChk()) {
        if ((!await rcCheckQCJCSystem()) || (!rcVDOpeModeChk())) {
          return 0;
        }
      }
      if (rcChkTRDrwAcxNotUse()) {
        //訓練で釣銭機禁止する
        //釣銭機接続設定でなくても精算機を動作させるために
        if (await rcQCChkQcashierSystem()) {
          return (CoinChanger.ACR_COINBILL);
        } else if (await rcSGChkSelfGateSystem()) {
          return (CoinChanger.ACR_COINBILL);
        } else {
          return 0; //精算機以外は釣銭機非接続時の動作にする
        }
      }
    }
    switch (RcRegs.rcInfoMem.rcCnct.cnctAcrCnct) {
      case 1:
        return (CoinChanger.ACR_COINONLY);
      case 2:
        return (CoinChanger.ACR_COINBILL);
      case 0:
        return 0;
      default:
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "Abnormaly acr_cnct Not Use AcrAcb in rcChk_AcrAcb_System()");
        return 0;
    }
  }

  /// 機能：通番訂正再売中の現金支払い開始ボタン表示中は釣銭釣札機の動作しない
  /// 戻値：0:動作する  1:動作しない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_Rcpt_AcrAcb_Chk
  static int rcSyschkRcptAcrAcbChk() {
    if (RcRegs.rcInfoMem.rcCnct.cnctRcptCnct != 0) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rcsyschk.c - rcsyschk_HappySelf_AutoStrCls_Chk
  /// TODO:00010 長田 定義のみ追加
  static int rcSysChkHappySelfAutoStrClsChk() {
    return 0;
  }

  /// 従業員モードかチェックする
  /// 戻り値: 従業員モード
  /// 関連tprxソース: rcsyschk.c - rcChk_StfMode
  static Future<int> rcChkStfMode() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    int mode = 0;
    if ((cBuf.dbStaffopen.chkr_status != 1) &&
        (cBuf.dbStaffopen.cshr_status == 1)) {
      //checker close, cashier open
      mode = 1; // 1 person
    } else if ((cBuf.dbStaffopen.chkr_status == 1) &&
        (cBuf.dbStaffopen.cshr_status == 1) &&
        (cBuf.dbStaffopen.chkr_cd.toString() == cBuf.dbStaffopen.cshr_cd)) {
      //checker open, cashier open
      mode = 2; // 1-2 person
    } else if ((cBuf.dbStaffopen.chkr_status == 1) &&
        (cBuf.dbStaffopen.cshr_status == 1) &&
        (cBuf.dbStaffopen.chkr_cd.toString() != cBuf.dbStaffopen.cshr_cd)) {
      //checker open, cashier open
      mode = 3; // 2 person
    } else if ((cBuf.dbStaffopen.chkr_status == 1) &&
        (cBuf.dbStaffopen.cshr_status != 1)) {
      //checker open, cashier close
      mode = 4; // only checker
    } else if ((cBuf.dbStaffopen.chkr_status != 1) &&
        (cBuf.dbStaffopen.cshr_status == 1)) {
      //checker close, cashier open
      mode = 5; // only cashier
    } else if ((cBuf.dbStaffopen.chkr_status != 1) &&
        (cBuf.dbStaffopen.cshr_status != 1)) {
      //checker close, cashier close
      mode = 0; // nobody
    }

    return mode;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_SptendInfo
  static Future<bool> rcChkSptendInfo() async {
    if (await rcSGChkSelfGateSystem()) {
      return false;
    } else {
      return true;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rc_Chk_dPoint_MedicinePos_System
  static int rcChkdPointMedicinePosSystem() {
    if (rcChkDPointSystem()) {
      return 1;
    }
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 多慶屋様 対面セルフ会員カード読込かチェックする
  /// 戻り値: true=上記読込  false=上記読込でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_fself_mbrscan_2nd_scanner_use
  static int rcsyschkFselfMbrscan2ndScannerUse() {
    /*
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    if (Dummy.rcsyschkVFHDHappySelfSystem() != 0) {
      ret = cBuf.dbTrm.frontSelfMbrscanFlg;
    }
    return ret;
     */
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcsyschk.c - rcChkRewrite_CheckerCnct
  static bool rcChkRewriteCheckerCnct() {
    return false;
  }

  /// todo 定義のみ追加
  /// 関連tprxソース: rcsyschk.c - rc_Check_WizAdj_System
  static bool rcCheckWizAdjSystem() {
    return false;
  }

  /// FCF仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Fcf_System
  static Future<bool> rcChkFcfSystem() async {
    return (!(await RcSysChk.rcCheckOutSider()) &&
        !RcSysChk.rcSROpeModeChk() &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem())) &&
        (await RcMbrCom.rcmbrChkStat() != 0) &&
        (await CmCksys.cmEdySystem() != 0) &&
        (await CmCksys.cmFcfMbrSystem() != 0) &&
        (await CmCksys.cmMcSystem() == 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctCardCnct == 7) &&
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 0));
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_ItemDetail_Auto
  static Future<bool> rcCheckItemDetailAuto() async {
    if (CompileFlag.DEPARTMENT_STORE) {
      return (false);
    } else {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(
            await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
        return (false);
      }
      RxCommonBuf cBuf = xRet.object;
      if ((await CmCksys.cmSpDepartmentSystem() != 0) &&
          (cBuf.dbTrm.userCd22 & 32) != 0) {
        AtSingl atSing = SystemFunc.readAtSingl();
        if (atSing.itemdetailFlg != 0) {
          return (false);
        } else {
          return (true);
        }
      } else {
        return (false);
      }
    }
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcsyschk.c - rc_Check_SignP_Ctrl
  static int rcCheckSignPCtrl() {
    return 0;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_ManuDecision_System
  static Future<bool> rcChkManuDecisionSystem() async {
    return (((RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 1) ||
            (RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 3)) &&
        !await rcSGChkSelfGateSystem() &&
        !await rcQCChkQcashierSystem());
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_AutoDecision_System
  static Future<bool> rcChkAutoDecisionSystem() async {
    return ((RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 2) ||
        (RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 4) ||
        await rcSGChkSelfGateSystem() ||
        await rcQCChkQcashierSystem());
  }

  /// todo 動作未確認
  /// 関連tprxソース: rcsyschk.c - rcCheck_RegDual
  static Future<bool> rcCheckRegDual() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return false;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    return ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
        (tsBuf.chk.reg_flg == 1)); /* Check Registration ? */
  }

  /// todo 動作未確認
  /// 関連tprxソース: rcsyschk.c - rcCheck_ChkrEnd_Dual
  static Future<int> rcCheckChkrEndDual() async {
    if (await rcKySelf() == RcRegs.KY_DUALCSHR) {
      if (ChkrStatChk() != 0) return 1;
    }
    return 0;
  }

  /// Displayサイズによる表示制限判定
  /// 関連tprxソース: rcsyschk.c - rcChk_DisplayType
  /// 引数   : なし
  /// 戻り値 : false:表示不可 true:表示可
  static Future<bool> rcChkDisplayType() async {
    int webType = await CmCksys.cmWebType();
    switch (webType) {
      case CmSys.WEBTYPE_WEB2100:
      case CmSys.WEBTYPE_WEBPRIME:
      case CmSys.WEBTYPE_WEB2200:
      case CmSys.WEBTYPE_WEBPLUS:
      case CmSys.WEBTYPE_WEB2300:
      case CmSys.WEBTYPE_WEB2350:
      case CmSys.WEBTYPE_WEBPLUS2:
      case CmSys.WEBTYPE_WEB2500:
        return false;
      default:
        return true;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_AcrAcb_Forget_Change
  static Future<bool> rcChkAcrAcbForgetChange() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkAcrAcbForgetChange(): rxMemRead error");
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (pCom.dbTrm.acxWarnChangeEcs07 != 0) {
      return true;
    } else if (AplLibAuto.AplLibAutoGetRunMode(await getTid()) != 0) {
      /* 自動動作中           */
      //自動開閉設時には貨幣取り忘れ警告仕様で動作させる
      return true;
    } else if ((await rcChkAjsEmoneySystem()) &&
        !await rcQRChkPrintSystem() &&
        (mem.tmpbuf.ajsEMoneyAutoCallFlg == 1)) {
      return true;
    } else {
      if (CompileFlag.COLORFIP) {
        if (await rcChkFselfMain()) {
          if (!rcChkChangeAfterReceipt()) {
            return true;
          } else {
            return false;
          }
        }
      }
      return false;
    }
  }

  /// 処理概要：縦型15.6(21.5)インチフルセルフであるかを判定
  /// パラメータ：なし
  /// 戻り値：true :縦型15.6インチフルセルフである
  ///       false :縦型15.6インチフルセルフではない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_VFHD_self_system
  static Future<bool> rcSysChkVFHDSelfSystem() async {
    if (await RcSysChk.rcChkShopAndGoSystem()) {
      /* Shop&Go */
      return false;
    }
    if (rcsyschk2800VFHDSystem() != 0) {
      /* 15.6インチ画面か(21.5と同じ画面サイズ比) */
      if (await rcChkSmartSelfSystem() && /* HappySelf仕様 */
          !await rcSysChkHappySmile() && /* HappySelf対面モードでない */
          !await rcChkHappySelfQCashier() && /* QC切替を行っていない */
          (RcRegs.rcInfoMem.rcCnct.cnctColordspCnct == 0)) {
        /* カラー客表接続：しない */
        return true;
      } else if (rcChk2800VFHDfselfSystem() && /* 15.6インチ客表付レジ */
          await rcChkSmartSelfSystem() && /* HappySelf仕様 */
          !await rcSysChkHappySmile() && /* HappySelf対面モードでない */
          !await rcChkHappySelfQCashier()) {
        /* QC切替を行っていない */
        return true;
      }
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChkTwoCnctSystem
  static Future<bool> rcChkTwoCnctSystem() async {
    if (await RcSysChk.rcChkDesktopCashier()) {
      return false;
    }

    if ((await rcChkTwoCnctChecker() == true) ||
        (await rcChkTwoCnctCashier() == true)) {
      return true;
    }
    return false;
  }

  /// 表示画面にタブがあるかチェックする
  /// 戻り値: true=タブあり  false=タブなし
  /// 関連tprxソース: rcsyschk.c - rcChk_2800_TabOrder
  static Future<bool> rcChk2800TabOrder() async {
    if (await rcChkDesktopCashier()) {
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((await rcChk2800System()) && (cBuf.dbTrm.tabDisplay == 1)) {
      return true;
    }
    // TODO:10114 コンパイルスイッチ(RM3800_DSP)
    //#if !(RM3800_DSP)
    if ((CmCksys.cmRm5900System() != 0) && (cBuf.dbTrm.tabDisplay == 1)) {
      return true;
    }
    //#endif

    return false;
  }

  /// レジの流し方向を返す
  /// 戻り値: レジの流し方向
  /// 関連tprxソース: rcsyschk.c - rcChk_2800_Reg_Cruising
  static Future<int> rcChk2800RegCruising() async {
    int ret = await CmCksys.cmWeb2800RegCruising();
    if (ret == CmSys.FACE_FLOW) {
      if ((await rcChk2800TabOrder()) || (await rcChkDesktopCashier())) {
        return CmSys.RIGHT_FLOW;
      }
    }

    return ret;
  }

  /// 電話番号入力・参照中かチェックする
  /// 戻り値: true=入力・参照中  false=入力・参照中でない
  /// 関連tprxソース: rcsyschk.c - rcCheck_MbrTelMode
  static bool rcCheckMbrTelMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_MBR.keyId]) ||
        RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId]));
  }

  /// スプール中かチェックする
  /// 戻り値: true=スプール中  false=スプール中でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Spool_Exist
  static bool rcChkSpoolExist() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return false;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (tsBuf.spl.spoolCnt != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// 承認キー 特定コスメ1仕様[アイスタイルリテイル様]かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_cosme1_istyle_system
  static bool rcChkCosme1IstyleSystem() {
    return (RcRegs.rcInfoMem.rcRecog.recogCosme1IstyleSystem != 0);
  }

  /// 全日食様向けだったクーポン仕様を動作させるかチェックする
  /// 戻り値: true=動作する  false=動作しない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_Zcpnprn_CheckUser
  static bool rcChkZcpnprnCheckUser() {
    return !rcChkWSSystem();
  }

  /// 特定SM61仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm61_fujifilm_system
  static bool rcChkSm61FujifilmSystem() {
    return (RcRegs.rcInfoMem.rcRecog.recogSm61FujifilmSystem != 0);
  }

  /// 特定SM71仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm71_selection_system
  static bool rcChkSm71SelectionSystem() {
    return (RcRegs.rcInfoMem.rcRecog.recogSm71SelectionSystem != 0);
  }

  /// 縦型15.6(21.5)インチフルセルフであるかチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_VFHD_self_system
  static Future<bool> rcChkVFHDSelfSystem() async {
    if (await rcChkShopAndGoSystem()) /* Shop&Go */ {
      return false;
    }
    if (rcsyschk2800VFHDSystem() != 0) /* 15.6インチ画面か(21.5と同じ画面サイズ比) */ {
      if ((await rcChkSmartSelfSystem()) /* HappySelf仕様 */
          &&
          !(await rcSysChkHappySmile()) /* HappySelf対面モードでない */
          &&
          !(await rcChkHappySelfQCashier()) /* QC切替を行っていない */
          &&
          (RcRegs.rcInfoMem.rcCnct.cnctColordspCnct == 0)) /* カラー客表接続：しない */ {
        return true;
      } else if (rcChk2800VFHDfselfSystem() /* 15.6インチ客表付レジ */
          &&
          (await rcChkSmartSelfSystem()) /* HappySelf仕様 */
          &&
          !(await rcSysChkHappySmile()) /* HappySelf対面モードでない */
          &&
          !(await rcChkHappySelfQCashier())) /* QC切替を行っていない */ {
        return true;
      }
    }
    return false;
  }

  /// 縦型15.6インチ客表付レジであるかチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_2800_VFHD_fself_system
  static bool rcChk2800VFHDfselfSystem() {
    if (CmCksys.cmChkVtclFHDFselfSystem() != 0) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcSG_Check_Other_Pay
  static bool rcSGCheckOtherPay() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    if (cBuf.dbTrm.selfOtherPay != 0) {
      return true;
    }
    return false;
  }

  /// ユナイト仕様でスキャンされたバーコードの種類をチェックする
  /// 戻り値: 0=該当なし  1=掛売バーコード
  /// 関連tprxソース: rcsyschk.c - rcChk_receiv_BarcodeTyp
  static int rcChkReceivBarcodeTyp() {
    if (RcSysChk.rcsyschkYunaitoHdSystem() == 0) {
      return 0;
    }

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    if (cMem.working.janInf.type == JANInfConsts.JANformatChargeSlip.value) {
      return 1;
    } else if (mem.tTtllog.t100700.mbrInput ==
        MbrInputType.barReceivInput.index) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rcsyschk.c - rcCheck_Oth_Mbr
  static bool rcCheckOthMbr() {
    RegsMem mem = SystemFunc.readRegsMem();
    return (mem.tTtllog.t100700.otherStoreMbr == 1);
  }

  /// 標準顧客仕様であるかチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_StdCust
  static Future<bool> rcChkStdCust() async {
    // 顧客仕様かつ特注リアル顧客仕様でない場合のみtrueを返す
    if ((await RcMbrCom.rcmbrChkStat() != 0) &&
        (!await rcChkZHQsystem()) &&
        (await CmCksys.cmSm36SanprazaSystem() != 0) &&
        (await CmCksys.cmSm36SanprazaSystem() != 0) &&
        (await CmCksys.cmSm74OzekiSystem() != 0)) {
      return true;
    } else {
      return false;
    }
  }
  
  /// 関連tprxソース: rcsyschk.c - 関数：rcChk_CardFee_System
  static Future<bool> rcChkCardFeeSystem() async {
    RxCommonBuf pCom = RxCommonBuf();
    if (CompileFlag.MC_SYSTEM || CompileFlag.TW) {
      return false;
    } else {
      if (await RcSysChk.rcCheckOutSider() != 0) return false;
      if (RcSysChk.rcSROpeModeChk()) return false;
      if (await RcMbrCom.rcmbrChkStat() != 0) return false;
      if (pCom.dbTrm.memUseTyp == 1) return false;
      if (pCom.dbTrm.validYear != 0) return false;
    }
    return true;
  }

  // TODO:中身未実装
  // 関連tprxソース: rcsyschk.c - rcHistErrCheck
  static int rcHistErrCheck() {
    return 0;
  }

  /// 標準顧客仕様であるかチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_IWAI_Real_System
  static Future<bool> rcChkIWAIRealSystem() async {
    if ((await rcCheckOutSider()) || rcSROpeModeChk()) {
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT != 0) &&  /* Member system? */
        (RcRegs.rcInfoMem.rcRecog.recogIwaisystem != 0) &&  /* Iwai System? */
        (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 0) &&  /* OKI rewrite card connect? */
        (Rxmbrcom.rcmbrGetSvsMthd(cBuf, null) == 7) &&  /* Service form */
        rcChkCustrealsvrSystem());
  }

  /// 愛媛電算NW7仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_NW7_System
  static Future<bool> rcChkNW7System() async {
    if ((await rcCheckOutSider()) || rcSROpeModeChk()) {
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT !=
            0) && /* Member system? */
        (cBuf.dbTrm.memUseTyp == 1) && /* Save data */
        (cBuf.dbTrm.nw7mbrBarcode1 != 0)); /* User Code */
  }

  /// Pharmacy仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Pharmacy_System
  static Future<bool> rcChkPharmacySystem() async {
    if (CompileFlag.POINT_CARD) {
      if ((await rcCheckOutSider()) || rcSROpeModeChk()) {
        return false;
      }
      if (CompileFlag.SAPPORO) {
        return ((await rcChkSapporoPanaSystem()) ||
            (await rcChkJklPanaSystem()) ||
            (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT == 1) &&
                (await CmCksys.cmPharmacySystem() != 0)));
      } else {
        return (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT ==
                1) &&
            (await CmCksys.cmPharmacySystem() != 0));
      }
    }

    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_BdlStmPrgSet_System
  static Future<bool> rcChkBdlStmPrgSetSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (CompileFlag.RESERV_SYSTEM) {
      return (((await CmCksys.cmReservSystem() != 0) ||
              (await CmCksys.cmNetDoAreservSystem() != 0)) &&
          (cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3));
    }

    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_BdlStmPrgRd_System
  static Future<bool> rcChkBdlStmPrgRdSystem() async {
    if (CompileFlag.RESERV_SYSTEM) {
      RegsMem mem = SystemFunc.readRegsMem();
      return ((await rcChkBdlStmPrgSetSystem()) &&
          (mem.tmpbuf.reservTyp == RcRegs.RESERV_CALL));
    }

    return false;
  }

  /// 顧客マルチ（ポイントパーセント付）仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_MbrMulti_PointPer
  static Future<bool> rcChkMbrMultiPointPer(int type) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (type == 0) {
      /* Point Calculation */
      if ((((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_FSP) != 0) &&
          (cBuf.dbTrm.memMuladdKnd != 0) &&
          ((cBuf.dbTrm.pluRgsAnyprcTrm == 1) ||
              (cBuf.dbTrm.pluRgsAnyprcTrm == 2)) &&
          ((cBuf.dbTrm.memAnyprcStet == 2) ||
              (cBuf.dbTrm.memAnyprcStet == 3))) {
        if (CmCksys.cmMmSystem() != 0) {
          /* M/M System */
          if (cBuf.regReduFspCd != 0) {
            /* Check Service Fsp Code Add */
            return true;
          } else {
            /* Check Service Fsp Code Not Add */
            return false;
          }
        }
        return true;
      } else {
        return false;
      }
    } else {
      /* Fsp Calculation */
      if ((((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_FSP) != 0) &&
          (cBuf.dbTrm.memMuladdKnd != 0) &&
          ((cBuf.dbTrm.pluRgsAnyprcTrm == 0) ||
              (cBuf.dbTrm.pluRgsAnyprcTrm == 2)) &&
          ((cBuf.dbTrm.memAnyprcStet == 2) ||
              (cBuf.dbTrm.memAnyprcStet == 3))) {
        if (CmCksys.cmMmSystem() != 0) {
          /* M/M System */
          if (cBuf.regReduFspCd != 0) {
            /* Check Service Fsp Code Add */
            return true;
          } else {
            /* Check Service Fsp Code Not Add */
            return false;
          }
        }
        return true;
      } else {
        return false;
      }
    }
  }

  /// dポイント仕様の時、1取引内で他の会員カードとの併用を許可するかチェックする
  /// 戻り値: 0=一取引内での併用なし / 1=一取引内での併用あり / 
  /// 戻り値: 2=一取引内での併用なし、かつ、他の会員カードなし
  /// 関連tprxソース: rcsyschk.c - rcChk_dPoint_DualMemberType
  static int rcChkDPointDualMemberType() {
    if (rcChkDPointSystem() == 0) {
      return 0;
    }
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      RxCommonBuf cBuf = xRet.object;
    
    return cBuf.dbTrm.dpntDualmember; // １取引内における他の会員との併用
  }

  /// dポイント仕様のフルセルフレジかチェックする
  /// 戻り値: true=上記仕様 / false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_dPoint_SelfSystem
  static Future<bool> rcChkDPointSelfSystem() async {
    if (rcChkDPointSystem()) {
      if (await rcChkSmartSelfSystem() &&
          !(await rcSysChkHappySmile()) &&
          !(await rcChkHappySelfQCashier())) {
        return true;
      }
    }

    return false;
  }

  /// 楽天ポイント仕様のフルセルフレジかチェックする
  /// 戻り値: true=上記仕様 / false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_RPoint_SelfSystem
  static Future<bool> rcChkRPointSelfSystem() async {
    if (rcsyschkRpointSystem() != 0) {
      if ((await rcChkSmartSelfSystem()) &&
          !(await rcSysChkHappySmile()) &&
          !(await rcChkHappySelfQCashier())) {
        return true;
      }
    }

    return false;
  }

  /// 友の会仕様のフルセルフレジかチェックする
  /// 戻り値: true=上記仕様 / false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Tomo_SelfSystem
  static Future<bool> rcChkTomoSelfSystem() async {
    if (rcsyschkTomoIFSystem()) {
      if ((await rcChkSmartSelfSystem()) &&
          !(await rcSysChkHappySmile()) &&
          !(await rcChkHappySelfQCashier())) {
        return true;
      }
    }

    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcSG_Check_Mcp200_System
  static Future<bool> rcSGCheckMcp200System() async {
    if ((await rcNewSGChkNewSelfGateSystem()) &&
        (await rcChkMcp200System()) &&
        !(await rcChkQuickSelfSystem())) {
      return true;
    } else {
      return false;
    }
  }

  /// 楽天ポイント仕様の時、1取引内で他の会員カードとの併用を許可するかチェックする
  /// 戻り値: 0=一取引内での併用なし / 1=一取引内での併用あり / 
  /// 戻り値: 2=一取引内での併用なし、かつ、他の会員カードなし
  /// 関連tprxソース: rcsyschk.c - rcChk_RPoint_DualMemberType
  static int rcChkRPointDualMemberType() {
    if (rcsyschkRpointSystem() == 0) {
      return 0;
    }
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      RxCommonBuf cBuf = xRet.object;
    
    return cBuf.dbTrm.rpntDualFlg; // １取引内における他の会員との併用
  }

  /// @@@V15 削除対象チェック関数
  /// 関連tprxソース: rcsyschk.c - 関数：rcSG_Chk_Ampm_System
  static bool rcSGChkAmpmSystem() {
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm11_nara_coop_system
  int rcsyschkSm11NaraCoopSystem() {
    //@@@V15用にとりあえずダミー
    return 0;
  }

  /// 関連tprxソース: rcsyschk.c - rcSG_Check_PanaMbr_System
  static Future<bool> rcSGCheckPanaMbrSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    if ((await RcSysChk.rcSGChkSelfGateSystem()) &&
        (CmCksys.cmPanaMemberSystem() != 0) &&
        (cBuf.dbTrm.nalsePanacode != 0 ||
            cBuf.dbTrm.patioMbrpointPanacode != 0) &&
        !(await rcNewSGChkNewSelfGateSystem()) &&
        !(await rcChkQuickSelfSystem())) {
      return true;
    } else {
      return false;
    }
  }

  // チェッカー操作中かチェック
  /// todo 動作未確認
  /// 関連tprxソース: rcsyschk.c - Chkr_Stat_Chk
  static int ChkrStatChk() {
    RxMemRet xRetTsBuf = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetTsBuf.isInvalid()) {
      return 1;
    }
    RxTaskStatBuf tsBuf = xRetTsBuf.object;

    if (tsBuf.chk.stat_dual != 0) {
      return (1);
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 1;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.frcClkFlg != 0) /* 簡易従業員入力 */
    {
      if ((cBuf.dbStaffopen.chkr_status == 0) &&
          (tsBuf.chk.staff_pw & 0x01 != 0) &&
          (tsBuf.chk.staff_pw & 0x02 != 0)) //処理中
      {
        return (1);
      }
    }

    return (0);
  }

  /// 特定SM65仕様(リウボウ様)かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm65_ryubo_system
  static bool rcChkSm65RyuboSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogSm65RyuboSystem != 0) {
      return true;
    }
    return false;
  }

  /// 小計画面かチェックする
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcsyschk.c - rcCheck_SpMode_KY_STL
  static bool rcCheckSpMode_KY_STL() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC1.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC2.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC3.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC4.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC5.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM1.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM2.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM3.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM4.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM5.keyId])));
  }

  /// 小計画面かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcCheck_WatariCard_System
  static Future<bool> rcCheckWatariCardSystem() async {
    /* t_ttllog の crdt_no を流用する為、同時には利用出来ない（既存仕様を優先とする） */
    if (CompileFlag.RALSE_CREDIT) {
      return false;
    } else {
      if ((await CmCksys.cmJremMultiSystem() != 0) ||
          (await CmCksys.cmJremMultiSystem() != 0) ||
          (await CmCksys.cmUTCnctSystem() != 0)) {
        return false;
      } else {
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if (xRet.isInvalid()) {
          return false;
        }
        RxCommonBuf cBuf = xRet.object;
        if ((await RcMbrCom.rcmbrChkStat() != 0) &&
            (cBuf.dbTrm.wataricardOpe != 0)) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  /// おおさかパルコープ様での退会会員表示変更仕様が有効かチェックする
  ///＊注意：カード忘れ仕様と共通のユーザーコードを使用している
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_PalCoop_Withdrawal_System
  static bool rcChkPalCoopWithdrawalSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.delShopbagVoiceSsps != 0) {
      return true;
    }
    return false;
  }

  /// 特定SM74仕様かチェックする
  ///＊注意：カード忘れ仕様と共通のユーザーコードを使用している
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm74_ozeki_system
  static bool rcChkSm74OzekiSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogSm74OzekiSystem != 0) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChkTwoCnctChecker
  static Future<bool> rcChkTwoCnctChecker() async {
    if (await CmCksys.cmTwoConnectChecker() == true) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChkTwoCnctCashier
  static Future<bool> rcChkTwoCnctCashier() async {
    if (await RcSysChk.rcChkDesktopCashier()) {
      return false;
    }

    if (await CmCksys.cmTwoConnectCashier() == true) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rc_Check_ScanDlg
  /// マルト様取引終了後のスキャン開始メッセージ表示か否か判定する
  /// 引数：なし
  /// 戻値：結果
  static Future<int> rcCheckScanDlg() async {
    // マルト様登録機側のみの対応となります
    // 機種、ユーザー様の追加は可能ですが、動作の保証はしません
    if (await CmCksys.cmMarutoSystem() != 0 &&
        await RcSysChk.rcQRChkPrintSystem()) {
      // マルト様登録機側
      return 1;
    }

    return 0;
  }

  /// 処理概要：縦型15.6インチ客表付レジであるかを判定
  /// パラメータ：なし
  /// 戻り値：true :縦型15.6インチ客表付レジである
  ///       false :縦型15.6インチ客表付レジではない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_2800_VFHD_fself_system
  static bool rcSysChk2800VFHDFSelfSystem() {
    if (CmCksys.cmChkVtclFHDFselfSystem() != 0) {
      return true;
    }
    return false;
  }

  /// [Speeza] 再書込みカードのステータスを取得する
  /// 戻り値: カードのステータス
  /// 関連tprxソース: rcsyschk.c - rcCheck_Speeza_RewriteCnct
  static Future<int> rcCheckSpeezaRewriteCnct() async {
    int rwcStatus = 0;
    if (await CmCksys.cmFeliCaSystem() == 0) {
      if ((await CmCksys.cmReceiptQrSystem() != 0)
          && rcChkRewriteCheckerCnct()) {
        rwcStatus = RcRegs.rcInfoMem.rcCnct.cnctRwtCnct;
      }
    }
    return rwcStatus;
  }

  /// 理由選択仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Reason_Select_System
  static bool rcChkReasonSelectSystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogReasonSelectStdSystem != 0) {
      return true;
    }
    else {
      return false;
    }
  }

  /// 特定TOY仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Toy_System
  static bool rcChkToySystem() {
    if (RcRegs.rcInfoMem.rcRecog.recogToySystem != 0) {
      return true;
    }
    else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Gs1Bar_System()
  static Future<bool> rcChkGs1BarSystem() async {
    return (await CmCksys.cmGS1BarcodeSystem() != 0);
  }

  /// 縦型15.6(21.5)インチ精算機であるかをチェックする
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_VFHD_QC_system
  static Future<bool> rcChkVFHDQCSystem() async {
    if ((await rcChkVFHDSelfSystem()) || (await rcChkShopAndGoSystem())) {
      return false;
    }
    if (rcsyschk2800VFHDSystem()) {
      if ((await rcChkHappySelfQCashier()) || (await rcQCChkQcashierSystem())) {
        return true;
      }
    }
    return false;
  }

  /// PROMシステム仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Prom_System()
  static Future<bool> rcChkPromSystem() async {
    if (!CompileFlag.PROM) {
      return false;
    }
    if ((await rcCheckOutSider()) || rcSROpeModeChk()) {
      return false;
    }

    if (RcRegs.rcInfoMem.rcRecog.recogPromsystem != 0) {
      return (await RcMbrCom.rcmbrChkStat() != 0);
    }
    return false;
  }

  /// [HappySelf] 自走式磁気リーダーが接続されているかチェックする
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_happyself_masr_system
  static Future<bool> rcChkHappySelfMasrSystem() async {
    return ((CmCksys.cmMasrSystem() != 0)
        && (SioChk.sioCheck(Sio.SIO_MASR) == Typ.YES))
        && (await rcChkSmartSelfSystem());
  }

  /// [HappySelf] 自走式カードリーダーの常時読み込み禁止仕様の条件をチェックする
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_happyself_masr_ctrl
  static Future<bool> rcChkHappySelfMasrCtrl() async {
    if (await rcChkSmartSelfSystem()) {
      if (rcRGOpeModeChk()) {
        if (rcChkCrdtUser() == Datas.KASUMI_CRDT) {  // 常時読み込み禁止
          return true;
        }
      }
    }
    return false;
  }

  /// [CoGCa] 一度読みが可能かチェックする
  /// 戻値: true=可能  false=不可
  /// 関連tprxソース: rcsyschk.c - rcIccd_Cogca_General_System
  static bool rcIccdCogcaGeneralSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    int memberCd = Rxkoptcmncom.rxChkKoptPrecaInMemberCompanyCd(cBuf);
    String checkCd = "$memberCd";

    /* 桁数チェック 6桁 */
    if (checkCd.length == 6) {
      /* 頭3桁のチェック 8(固定値)70(CGC) */
      if (checkCd.startsWith("870")) {
        return true;
      }
    }
    return false;
  }

  /// [CoGCa] IC顧客仕様かチェックする（買上追加対応と訂正モードでのCoGCa宣言対応）
  /// ※新規でCoGCa IC顧客対応した場合はここへ追加すること
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Cogca_IC_Member_System
  static bool rcChkCogcaICMemberSystem() {
    return (rcChkCogcaSystem() && rcIccdCogcaGeneralSystem());
  }

  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm8_taiyo_system
  static int rcChkSm8TaiyoSystem() {
    //@@@V15用にとりあえずダミー
    return 0;
  }

  /// Verifone接続でのT-Point仕様の条件をチェックする
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_vesca_tpoint_system
  static bool rcChkVescaTpointSystem() {
    return (rcsyschkVescaSystem() && rcsyschkTpointSystem());
  }

  /// 端末カード読込機能がチェックする
  /// 戻値: true=上記機能  false=上記機能でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Cat_CardRead_system
  static Future<bool> rcChkCatCardReadSystem() async {
    // TODO:ARCS仕様のため、条件式は rcChkVegaProcess() のみとする
    if ((await rcChkVegaProcess()) /*&& rcsyschkSm66FrestaSystem()*/) {
      /* 1VerのVEGA端末磁気カード会員読込はフレスタ様のみ有効の為 */
      return true;
    }
    else {
      if (rcChkVescaTpointSystem()) {
        return true;
      }
      else {
        if (rcsyschkVescaSystem()) {
          return true;
        }
      }
    }
    return false;
  }

  /// レピカ(アララ)をVerifoneで読ませる仕様でアプリ側のカスタマイズをするかチェックする
  /// 戻値: true=カスタマイズする  false=カスタマイズしない
  /// 関連tprxソース: rcsyschk.c - rcChk_Repica_Verifone_Read_System_for_apl
  static bool rcChkRepicaVerifoneReadSystemForApl() {
    /* このチェック関数でやっていること */
    /* レピカの締め操作を課税対象とする（Verifone標準プリペイドは課税対象から除外） */
    /* 精算機で残高不足となった場合にメンテナンス画面で中断可能にする */
    if (RcRegs.rcInfoMem.rcRecog.recogRepicaSystem == 0) {
      return false;
    }
    if (!rcsyschkVescaSystem()) {
      return false;
    }
    return true;
  }

  /// アークス様 フルセルフまたはShop&Goレジ仕様チェック（12Verから移植）
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_Arcs_SmartSelf_or_Shop_System
  static Future<bool> rcChkArcsSmartSelfOrShopSystem() async {
    if ((await rcChkSmartSelfSystem())
        && !(await rcSysChkHappySmile())
        && !(await rcChkHappySelfQCashier()) ) {
      /* フルセルフ仕様 */
      return true;
    }
    else if (await rcChkShopAndGoSystem()) {
      /* Shop&Go仕様 */
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_AplDlg_EntryMode
  static bool rcChkAplDlgEntryMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.apldlgPtn == 2);
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_AplDlg_EntryPasswordMode
  static bool rcChkAplDlgEntryPasswordMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.apldlgPtn == 3);
  }

  /// 機能概要    : 特定公共料金3仕様の承認キー設定有無判定
  /// 戻り値      : 1 :特定公共料金3仕様である
  ///              0 :特定公共料金3仕様ではない
  /// 関連tprxソース: rcsyschk.c - rcsyschk_public_barcode_pay3_system
  static int rcSysChkPublicBarcodePay3System() {
    if (RcRegs.rcInfoMem.rcRecog.recogPublicBarcodePay3System != 0) {
      return (1);
    }
    return (0);
  }

  /// 機能概要: 金種商品を登録画面で登録・小計画面で使用する仕様
  /// 関連tprxソース: rcsyschk.c - rcChk_NotePlu_Sale
  static Future<bool> rcChkNotePluSale() async {
    return (await CmCksys.cmMarutoSystem() != 0 ? true : false);
  }

  /// 機能概要: Check Multi Percent Discount System
  /// 関連tprxソース: rcsyschk.c - rcChk_MulPerDisc_System
  static Future<bool> rcChkMulPerDiscSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return (false);
    }
    RxCommonBuf cBuf = xRet.object;
    if (cBuf.dbTrm.chgCulcMulDiscitem != 0) {
      // Multi Percent Discount System
      return (true);
    } else {
      // Normal System
      return (false);
    }
  }

  /// 機能：茨城タイヨー様(特定SM16)仕様の承認キーがセットされているか判定する
  ///  ※鹿児島タイヨー様(特定SM8)と混同しないよう注意
  /// 引数：なし
  /// 戻値：1:有効 0:無効
  /// 関連tprxソース: rcsyschk.c - rcsyschk_sm16_taiyo_toyocho_system
  static Future<int> rcSysChkSm16TaiyoToyochoSystem() async {
    if (RcRegs.rcInfoMem.rcRecog.recogSm16TaiyoToyochoSystem != 0) {
      return (1);
    }
    else {
      return (0);
    }
  }

  /// 機能概要    : フルセルフ（HappySelf)一個限りミックスマッチ制限個数確認対応
  /// パラメータ  : なし
  /// 戻り値      : 1:一個限りミックスマッチ制限個数確認する
  ///               0:確認ない
  /// 関連tprxソース: rcsyschk.c - rcCheck_OneMixLimit_Self
  static Future<int> rcCheckOneMixLimitSelf() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    if ((await rcSysChkSm16TaiyoToyochoSystem() != 0) ||
        (await CmCksys.cmSm66FrestaSystem() != 0)
    ) {
      if (cBuf.dbTrm.dispBdlQtyLimit1 != 0) {
        return 1;
      }
    }
    return 0;
  }

  //実装は必要だがARKS対応では除外
  ///  関連tprxソース: rcsyschk.c - rcsyschk_vesca_change_ui
  static int rcSyschkVescaChangeUi(){
    return 0;
  }

  /// 機能：カスミICクレジット仕様かどうかを判定する
  /// 関連tprxソース: rcsyschk.c - rcsyschk_kasumi_EMV_system
  static Future<bool> rcsyschkKasumiEMVSystem() async {
    if (await rcsyschkMultiWAONSystem()) {
      // WAON端末<Panasonic製>が必須の為
      if ((RcRegs.rcInfoMem.rcRecog.recogCreditsystem != 0) &&
          (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct == 21)) {
        return (true);
      } else {
        return (false);
      }
    } else {
      return (false);
    }
  }

  /// 機能：WAON（マルチ端末）仕様かどうかを判定する
  /// 関連tprxソース: rcsyschk.c - rcsyschk_multiWAON_system
  static Future<bool> rcsyschkMultiWAONSystem() async {
    if ((RcRegs.rcInfoMem.rcRecog.recogPanawaonsystem != 0) &&
        (RcRegs.rcInfoMem.rcCnct.cnctMultiCnct == 5)) {
      if ((await rcCheckOutSider()) ||
          (((await rcKySelf()) == RcRegs.KY_CHECKER) &&
              (!(await rcCheckQCJCSystem())))) {
        return (false);
      } else {
        return (true);
      }
    } else {
      return (false);
    }
  }

  /// 機能 : HappySelf 自走式磁気リーダーが接続されているか判定
  /// 関連tprxソース: rcsyschk.c - rcsyschk_happyself_masr_system
  static Future<int> rcsyschkHappyselfMasrSystem() async {
    if (((CmCksys.cmMasrSystem() != 0) &&
            (SioChk.sioCheck(Sio.SIO_MASR) == Typ.YES)) &&
        (await rcChkSmartSelfSystem())) {
      return (1);
    }

    return (0);
  }

  /// 機能 : APPYSELFで自走式カードリーダーの常時読み込み禁止仕様の条件をチェックする
  /// 関連tprxソース: rcsyschk.c - rcsyschk_happyself_masr_ctrl
  static Future<int> rcsyschkHappyselfMasrCtrl() async {
    if (await rcChkSmartSelfSystem()) {
      if ((CmCksys.cmSm19NishimutaSystem() != 0) &&
          (await rcChkSmartSelfSystem())) {
        //常時読み込み禁止
        return (1);
      }

      if ((await RcSysChk.rcsyschkYoneyaHappySmileSystem()) != 0) {
        return (1);
      }

      if (RcSysChk.rcRGOpeModeChk()) {
        if (rcChkCrdtUser() == Datas.KASUMI_CRDT) {
          // 常時読み込み禁止
          return (1);
        } else {
          return (0);
        }
      } else {
        return (0);
      }
    } else {
      return (0);
    }
  }

  /// 機能 : よねや仕様でHappySelf[対面]が使用可能か判定
  /// 関連tprxソース: rcsyschk.c - rcsyschk_yoneya_happy_smile_system
  static Future<int> rcsyschkYoneyaHappySmileSystem() async {
    if (((await CmCksys.cmYumecaPolSystem()) != 0) &&
        ((await CmCksys.cmCustrealUniSystem()) != 0) &&
        ((CmCksys.cmSm40YoneyaSystem()))) {
      if ((await RcSysChk.rcChkSmartSelfSystem()) //HappySelf仕様
          &&
          (await rcSysChkHappySmile())) {
        //HappySelf対面モード
        return (1);
      }
    }
    return (0);
  }

  // TODO:10166 クレジット決済 20241004実装対象外
  /// 関連tprxソース: rcsyschk.c - rc_Check_Marine5_Simizuya
  static bool rcCheckMarine5Simizuya() {
    return false;
  }

  /// 処理概要：クレジットEMV仕様かどうか判定する
  /// パラメータ：なし
  /// 戻り値：true :EMV仕様である
  ///       false :MV仕様でない
  /// 関連tprxソース: rcsyschk.c - rcChk_EMVCredit_system
  static Future<bool> rcChkEMVCreditSystem() async {
    if (await RcSysChk.rcChkVegaProcess()) /* VEGA3000接続 */ {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_CrdtDsc_System
  static Future<bool> rcChkCrdtDscSystem() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcChkCrdtDscSystem() rxMemRead error\n");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await RckyTaxFreeIn.rcTaxFreeChkTaxFreeIn() != 0) {
      // 免税の場合はクレジット小計割引無効
      return false;
    }

    if (cBuf.dbTrm.crdtStlpdscOpe != 1) {
      if ((rcVDOpeModeChk()) &&
          (!rcCheckCrdtStat()) &&
          (cMem.working.refData.crdtTbl.stlcrdtdsc_per != 0)) {
        return true;
      }
    }

    if (CompileFlag.DEPARTMENT_STORE) {
      if (rcChkDepartmentSystem()) {
        if (cBuf.dbTrm.crdtStlpdscOpe == 1) {
          if (((RegsMem().tTtllog.t100700Sts.nextFspLvl == 0) &&
                  (RegsMem().tTtllog.calcData.card1timeAmt % 1000 != 841)) ||
              ((RegsMem().tTtllog.t100700Sts.nextFspLvl == 1) &&
                  (RegsMem().tTtllog.calcData.card1timeAmt % 1000 == 501))) {
            return true;
          } else {
            return false;
          }
        } else {
          if ((cMem.stat.departFlg & 0x08) != 0) {
            return true;
          } else {
            return false;
          }
        }
      } else {
        if (cBuf.dbTrm.crdtStlpdscOpe == 1) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      if (cBuf.dbTrm.crdtStlpdscOpe == 1) {
        if (cBuf.dbTrm.disableStldiscCreditStldisc != 0) {
          if ((RegsMem().tTtllog.t100002.nmStlpdscAmt != 0) ||
              (RxLogCalc.rxCalcStlDscAllAmt(RegsMem()) != 0) ||
              (RxLogCalc.rxCalcStlPdscAllAmt(RegsMem()) != 0)) {
            return false;
          } else {
            return true;
          }
        } else {
          if (await rcChkActiveStlDscPer()) {
            // 一般自動小計割引率がクレジット割引率より高い為、クレジット割引を適用しない
            if (RegsMem().tTtllog.t100001Sts.qcReadQrReceiptNo != 0) {
              if ((RegsMem().tTtllog.calcData.nmStlpdscPer >=
                      cMem.working.refData.crdtTbl.stlcrdtdsc_per) &&
                  (RegsMem().tTtllog.calcData.nmStlpdscPer != 0) &&
                  (cMem.working.refData.crdtTbl.stlcrdtdsc_per != 0)) {
                return false;
              } else {
                return true;
              }
            } else {
              if ((RegsMem().tTtllog.t100002Sts.prgNmStldscPer >=
                      cMem.working.refData.crdtTbl.stlcrdtdsc_per) &&
                  (RegsMem().tTtllog.t100002Sts.prgNmStldscPer != 0) &&
                  (cMem.working.refData.crdtTbl.stlcrdtdsc_per != 0)) {
                return false;
              } else {
                return true;
              }
            }
          } else {
            return true;
          }
        }
      } else {
        return false;
      }
    }
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_Active_StlDscPer
  static Future<bool> rcChkActiveStlDscPer() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcChkActiveStlDscPer() rxMemRead error\n");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.crdtStlpdscOpe == 1 && cBuf.dbTrm.priorityStldsc != 0) {
      return true;
    } else {
      return false;
    }
  }

  /// 機能概要  ：ICカードリーダが使用可能かどうか判定する
  /// パラメータ：なし
  /// 戻り値    ：0:使用不可 1:使用可能
  /// 関連tprxソース: rcsyschk.c - rcCheck_USBICCard_Cnct
  static Future<int> rcCheckUSBICCardCnct() async {
    if (await CmCksys.cmUSBICCardChk() == 0) {
      /* ICカードリーダ未設定 */
      return 0;
    }
    if (CmCksys.cmQCashierJCSystem() != 0) {
      /* QCashierJCモード */
      // TODO:10166 クレジット決済 20241004実装対象外
      // if(C_BUF->ini_macinfo.mode == 3)
      // {
      // if(rcChk_VEGA_Process())
      // {
      // /* VEG3000接続との併用の場合は、設定と一致しているかどうかを判定する */
      // if( (C_BUF->qcjc_voidmode_flg == 1)			/* 登録機実績の訂正 */
      // && (C_BUF->ini_macinfo.iccard_cnct == 1) )	/* ICカードリーダ接続：する */
      // {
      // return(1);
      // }
      // else if( (C_BUF->qcjc_voidmode_flg == 0)		/* 精算機実績の訂正 */
      // && (C_BUF->ini_macinfo.iccard_cnct == 2) )	/* ICカードリーダ接続：する(QC) */
      // {
      // return(1);
      // }
      // else
      // {
      // return(0);
      // }
      // }
      // else
      // {
      // /* 他レジでの訂正を禁止している場合を考慮して
      // 			 * 訂正モードの場合は、接続設定と一致しているかどうかは判定しない */
      // return(1);
      // }
      // }
      // else
      // {
      // if( (rcCheck_QCJC_Checker())				/* WebSpeezaC */
      // && (C_BUF->ini_macinfo.iccard_cnct == 1) )	/* ICカードリーダ接続：する */
      // {
      // return(1);
      // }
      // else if( (rcCheck_QCJC_Cashier())			/* QCashier */
      // && (C_BUF->ini_macinfo.iccard_cnct == 2) )	/* ICカードリーダ接続：する(QC) */
      // {
      // return(1);
      // }
      // else
      // {
      // return(0);
      // }
      // }
    } else {
      /* QCJCでない場合判定しない */
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rcsyschk.c - rcChk_MsrCtrl_System
  static Future<bool> rcChkMsrCtrlSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return false;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((await CmCksys.cmNttaspSystem() != 0) && (rcChkRalseCardSystem())) {
      return false;
    }

    if (((CmCksys.cmWeb2300System() != 0) ||
            (CmCksys.cmWebplusSystem() != 0)) &&
        (tsBuf.msr.stat == 1)) {
      return true;
    } else {
      return false;
    }
  }  
}
