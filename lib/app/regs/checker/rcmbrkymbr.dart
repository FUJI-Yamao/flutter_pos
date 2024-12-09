/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../dummy.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_msg.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/ean.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_mcd/cmmcdchk.dart';
import '../../lib/cm_sound/sound_def.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../../ui/controller/c_common_controller.dart';
import '../../ui/page/member/p_member_call_page.dart';
import '../common/rx_log_calc.dart';
import '../common/rxkoptcmncom.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28taborder.dart';
import 'rc_59dsp.dart';
import 'rc_assist_mnt.dart';
import 'rc_ext.dart';
import 'rc_gtktimer.dart';
import 'rc_ifevent.dart';
import 'rc_itm_dsp.dart';
import 'rc_key_cardforget.dart';
import 'rc_key_tab.dart';
import 'rc_masr.dart';
import 'rc_mcd.dart';
import 'rc_mbr_com.dart';
import 'rc_mbr_realsvr.dart';
import 'rc_mbrrealsvr_fresta.dart';
import 'rc_necrealsvr.dart';
import 'rc_obr.dart';
import 'rc_qc_dsp.dart';
import 'rc_qrinf.dart';
import 'rc_recno.dart';
import 'rc_set.dart';
import 'rc_setdate.dart';
import 'rc_sgdsp.dart';
import 'rc_sound.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rc_stl_dsp.dart';
import 'rc_timer.dart';
import 'rc_usbcam.dart';
import 'rc_vfhd_fself.dart';
import 'rcfncchk.dart';
import 'rcitmchk.dart';
import 'rcky_clr.dart';
import 'rcky_cpnprn.dart';
import 'rcky_plu.dart';
import 'rcky_rpr.dart';
import 'rcky_stl.dart';
import 'rcky_taxfreein.dart';
import 'rckydisburse.dart';
import 'rckymprc.dart';
import 'rcmbr_custdsp.dart';
import 'rcmbrcmsrv.dart';
import 'rcmbrflrd.dart';
import 'rcmbrfsptotallog.dart';
import 'rcmbrpttlset.dart';
import 'rcmbrrealsvr.dart';
import 'rcnewsg_fnc.dart';
import 'rcnochgdsp.dart';
import 'rcqc_com.dart';
import 'rcqr_com.dart';
import 'rcsp_recal.dart';
import 'rcsg_com.dart';
import 'rcsg_dev.dart';
import 'rcsg_vfhd_dsp.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';
import 'rxregmem.dart';

///  関連tprxソース: rcmbrkymbr.c
class Rcmbrkymbr {
  static const MBR_ENTRY_MAX = 20;  /* 値数桁数 */

  static TmpReadData tmpReadData = TmpReadData();
  static TelSchInfo telSch = TelSchInfo();
  static int tgtMsgDlgCount = 0;  // ターゲットメッセージダイアログ表示時の最大数
  static QrTxtStatus qrTxtStatus = QrTxtStatus.QR_TXT_STATUS_INIT;
  static int timeout3 = -1;
  static String comText1 = "";
  static String comText2 = "";
  static String comText3 = "";
  static String comText4 = "";
  static String comText5 = "";
  static String comText6 = "";
  static int qcData = 0;
  static int selfFlg = 0;
  static int receiptFlg = 0;
  static int precaOnceMbrFlg = 0;    /* CoGCa顧客一度読みフラグ */
  static int precaOnceMbrAfterProcType = 0;    /* CoGCa顧客一度読み後処理タイプ */
  static int sptendChkcnt = 0;
  static int sptendCntbk = 0;
  static String mbrId = "";  //入力した会員番号

  /// 会員呼出キー押下時呼びだし画面を開く.
  static void openMbrPage(String title) {
    // 会員呼出画面を開く
     Get.to(() => MemberCallScreen(title: title));
  }

  /// 会員呼出処理.
  ///  関連tprxソース: rcmbrkymbr.c - rcKyMbr
  static Future<void> rcKyMbr() async {
    //await RxRegMem.rcRecogMemAllSet(Tpraid.TPRAID_SYSTEM);  //sys.jsonより承認キーデータを取得する

    if (await RcMbrCom.rcmbrChkStat() == 0) {
      //顧客仕様でない
      return;
    }
    if (RcFncChk.rcCheckScnMbrMode()) {
      //会員スキャン画面表示中
      //TODO:10155 顧客呼出_実装対象外
      //　- 今回は「会員呼出画面から会員番号入力→会員呼出」のみのため、同判定以下の処理はなし
    }

    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.errNo = await rcChkKyMbr();
    if (cMem.ent.errNo == 0) {
      cMem.ent.errNo = rcReadKeyOption();
    }
    if (cMem.ent.errNo == 0) {
      cMem.ent.errNo = await rcChkMbrKeyOption();
    }

    CommonController commonCtrl = Get.find();

    if (cMem.ent.errNo != 0) {
      if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
        await RcExt.rcErr("Rcmbrkymbr.rcKyMbr()", cMem.ent.errNo);
      } else { //登録画面から実行
        await RcExt.rcErrToRegister("Rcmbrkymbr.rcKyMbr()", cMem.ent.errNo);
      }
      return;
    }

    if (await Rc28TabOrder.rcTabMoveRegStart(0) != 0 ) {
      if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
        await RcExt.rcErr("Rcmbrkymbr.rcKyMbr()", cMem.ent.errNo);
      } else { //登録画面から実行
        await RcExt.rcErrToRegister("Rcmbrkymbr.rcKyMbr()", cMem.ent.errNo);
      }
      return;
    }

    AtSingl atSing = SystemFunc.readAtSingl();
    //TODO:10155 顧客呼出_実装対象外（if (RcFncChk.rcChkTenOn())）
    //if (RcFncChk.rcChkTenOn()) {
      if (CompileFlag.RALSE_MBRSYSTEM && RcSysChk.rcChkRalseCardSystem()) {
        if (CompileFlag.ARCS_MBR) {
          //TODO:10155 顧客呼出_実装対象外（会員番号入力画面に固定のため、判定を削除）
          /*
          if (!RcSysChk.rcCheckMbrTelMode()) {
            await RcExt.rcErr("Rcmbrkymbr.rcKyMbr()", DlgConfirmMsgKind.MSG_OPEERR.dlgId);
            return;
          }
           */
          atSing.mbrTyp = Mcd.MCD_RLSCARD;
        }
        else {
          atSing.mbrTyp = 0;
        }
      }
      if (CompileFlag.SAPPORO && (await CmCksys.cmRainbowCardSystem() != 0)) {
        rcProcRainbowMbrInput();
      }
      if (RcSysChk.rcChkCustrealOPSystem()) {
        rcProcOpMbrInput();
      }
      if (RcSysChk.rcChkTpointSystem() != 0) {
        if (RcSysChk.rcCheckMbrTelMode()) {
          rcProcTpointMbrInput();
        }
        else {
          if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
            await RcExt.rcErr("Rcmbrkymbr.rcKyMbr()", DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          } else { //登録画面から実行
            await RcExt.rcErrToRegister("Rcmbrkymbr.rcKyMbr()", DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          }
          return;
        }
      }
      else {
        debugPrint('********** 実機調査ログ（会員呼出）1: Rcmbrkymbr.rcPrgKyMbr() スタート地点');
        await rcPrgKyMbr();
        debugPrint('********** 実機調査ログ（会員呼出）16: Rcmbrkymbr.rcPrgKyMbr() 終了');
      }
    //} else {
      //電話番号入力
      //TODO:10155 顧客呼出_実装対象外
      // - 今回は「会員呼出画面から会員番号入力→会員呼出」のみのため、同判定以下の処理はなし
    //}
  }

  /// 会員呼出キー押下時における仕様チェック
  /// 戻り値: エラーコード（0=OK）
  ///  関連tprxソース: rcmbrkymbr.c - rcChk_Ky_Mbr
  static Future<int> rcChkKyMbr() async {
    int errNo = 0;

    if ((errNo == 0) && (await RcItmChk.rcCheckKyMbr() != 0)) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && (await RcItmChk.rcCheckCshrNotReg())) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && (await RcSysChk.rcChkFelicaSystem())) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && (await RcSysChk.rcChkFcfSystem())) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if (CompileFlag.MC_SYSTEM) {
      if ( (errNo == 0) && RcSysChk.rcChkMcSystem()) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    else if (CompileFlag.SAPPORO) {
      if ((errNo == 0) &&
          ((await RcSysChk.rcChkSapporoPanaSystem()) ||
              (await RcSysChk.rcChkJklPanaSystem()) ||
              (await CmCksys.cmPanaMemberSystem() != 0) ||
              (await CmCksys.cmMoriyaMemberSystem() != 0))) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (CompileFlag.POINT_CARD) {
      if ((errNo == 0) && (await RcSysChk.rcChkPointCardSystem())) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (CompileFlag.IWAI) {
      if ((errNo == 0) && (await RcSysChk.rcChkORCSystem())) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (CompileFlag.REWRITE_CARD) {
      if ((errNo == 0) && (await RcSysChk.rcChkTRCSystem()) &&
          !RcMbrCom.rcChkOtherCo1()) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (CompileFlag.VISMAC) {
      if ((errNo == 0) && (await RcSysChk.rcChkVMCSystem()) &&
          !(await RcSysChk.rcChkCOOPSystem())) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if ((errNo == 0) && (await RcSysChk.rcChkMcp200System()) &&
        (await CmCksys.cmDcmpointSystem() == 0)) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && rcChkKyInput()) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && (await RcSysChk.rcChkHt2980System())) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && (await RcSysChk.rcChkAbsV31System())) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && RcSysChk.rcChkCustrealWebserSystem()) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }

    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    if ((errNo == 0) && (RcSysChk.rcChkCustrealUIDSystem() != 0) &&
        (((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
            !(await RcSysChk.rcCheckQCJCSystem())) ||
            (tsBuf.custreal2.order != 0))) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if ((errNo == 0) && RcSysChk.rcChkCustrealOPSystem() &&
        (((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
            !(await RcSysChk.rcCheckQCJCSystem())) ||
            (tsBuf.custreal2.order != 0))) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }

    if ((errNo == 0) && (await CmCksys.cmDs2GodaiSystem() != 0)) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if ((errNo == 0) && (RcSysChk.rcChkCustrealPointartistSystem() != 0) &&
        (((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
            !(await RcSysChk.rcCheckQCJCSystem())) ||
            (tsBuf.custreal2.order != 0))) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    if ((errNo == 0) && ((cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) &&
        !(await RcSysChk.rcChkChargeSlipSystem()))) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if (CompileFlag.ARCS_MBR) {
      AtSingl atSing = SystemFunc.readAtSingl();
      if ((errNo == 0) && (atSing.limitAmount != 0) ) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    if ((errNo == 0) && (CmCksys.cmJAIwateSystem() != 0)) {
      errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
    }
    if ((await RcSysChk.rcChkZHQsystem()) && RcFncChk.rcCheckScanCheck()) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if ((errNo == 0) &&
        ((RcSysChk.rcChkTpointSystem() != 0) ||
            (RcSysChk.rcChkCustrealPointTactixSystem() != 0) ||
            RcSysChk.rcChkCosme1IstyleSystem()) &&
        (cMem.stat.fncCode == FuncKey.KY_TEL.keyId)) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if ((errNo == 0) && (RcSysChk.rcChkCustrealPointTactixSystem() != 0) &&
        !(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) {
      errNo = DlgConfirmMsgKind.MSG_OPEMERR_CUSTOMERCARD.dlgId;
    }
    if (RcSysChk.rcChkWSSystem()) {
      if (cMem.stat.fncCode != FuncKey.KY_TEL.keyId) {
        if (!RcFncChk.rcChkTenOn()) {
          errNo = DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
        }
      }
    }
    if ((errNo == 0) && (await RckyTaxFreeIn.taxFreeChgChk())) {
      errNo = DlgConfirmMsgKind.MSG_TAXFREE_CHG_ERR.dlgId;
    }
    // RM-3800 フローティング仕様で会員呼出は小計画面のみとする
    if ((errNo == 0) && (await Rc59dsp.rc59ChkFloatingItemScreen() != 0)) {
      errNo = DlgConfirmMsgKind.MSG_MBR_CALL_STL.dlgId;
    }

    return errNo;
  }

  /// キーステータスと入力キーがそれぞれ「会員番号」「電話番号」で一致しているかチェックする
  /// 戻り値: true=一致  false=一致しない
  ///  関連tprxソース: rcmbrkymbr.c - rcChk_Ky_input
  static bool rcChkKyInput() {
    AcMem cMem = SystemFunc.readAcMem();
    return (((cMem.stat.fncCode == FuncKey.KY_MBR.keyId) &&
        RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId])) ||
        ((cMem.stat.fncCode == FuncKey.KY_TEL.keyId) &&
            RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_MBR.keyId])) ||
        (!RcFncChk.rcChkTenOn() &&
            RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId])));
  }

  /// キーオプションを読み取る
  /// 戻り値: 0固定
  ///  関連tprxソース: rcmbrkymbr.c - rcRead_KeyOption
  static int rcReadKeyOption() {
    return 0;
  }

  /// 会員キーオプションが有効かチェックする
  /// 戻り値: エラーコード（0=OK）
  ///  関連tprxソース: rcmbrkymbr.c - rcChk_Mbr_KeyOption
  static Future<int> rcChkMbrKeyOption() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Rcmbrkymbr.rcChkMbrKeyOption(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.stat.fncCode == FuncKey.KY_MBR.keyId) {
      if ((Rxkoptcmncom.rxChkKoptMbrTelNo(cBuf) != 0) &&
          !RcFncChk.rcChkTenOn()) {
        return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    else {
      if (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId]) &&
          RcFncChk.rcChkTenOn()) {
        return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    return 0;
  }

  /// 表示、印字するターゲットメッセージデータを読込＆格納し、連続して表示する
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_SetTargetMsg
  static int rcMbrSetTargetMsg() {
    // TODO:10155 顧客呼出_実装対象外（実機ログ未取得）
    return 0;
  }

  /// ターゲットメッセージの状態終了
  /// （ターゲットメッセージ中にエラーダイアログが出る場合があるため, 関数を追加）
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_ProcEnd_TargetMsg
  static void rcMbrProcEndTargetMsg() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // TprLibDlg.TprLibDlg_End_MultiDlg();	// 複数ダイアログ状態の終了
    // rcMbrClearTargetMsg();		// 確保したメモリを解放
  }

  /// ターゲットメッセージの格納情報のクリア
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_ClearTargetMsg
  static void rcMbrClearTargetMsg() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (TgtMsgDlgList != NULL) {
    //   free(TgtMsgDlgList);
    // }
    // TgtMsgDlgCount = 0;
    // TgtMsgDlgList = NULL;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 記念日フラグセット
  /// 関連tprxソース: rcmbrkymbr.c - AnvFlgSet()
  static void anvFlgSet() {
    /*
    RegsMem mem = SystemFunc.readRegsMem();

    mem.tTtllog.t100700Sts.uanvDate1 = 0;
    mem.tTtllog.t100700Sts.uanvDate2 = 0;
    mem.tTtllog.t100700Sts.uanvDate3 = 0;

    if (RxLogCalc.rxCalcStlTaxInAmt(mem) < 0) {
      return;
    }

    int ret = RcMbrCom.rcmbrChkAnvKind();
    if ((ret & RCMBR_ANVKIND_1) != 0) {
      mem.tTtllog.t100700Sts.uanvDate1 = 1;
    }
    if ((ret & RCMBR_ANVKIND_2) != 0) {
      if ((await CmCksys.cmPointartistConect()) == CmSys.PARTIST_SOCKET) {
    if (mem.tTtllog.t100700Sts.partistBirthFlg == 0) {
    mem.tTtllog.t100700Sts.uanvDate2 = 1;
    }
    } else {
    mem.tTtllog.t100700Sts.uanvDate2 = 1;
    }
    }
    if ((ret & RCMBR_ANVKIND_3) != 0) {
    mem.tTtllog.t100700Sts.uanvDate3 = 1;
    }
     */
    return ;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcmbrkymbr.c - rcmbr_End_fanfare
  static void rcmbrEndFanfare() {
    return ;
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rcmbrkymbr.c - rcwebreal_UID_DialogErr
  static int rcwebrealUIDDialogErr(int er_code, int user_code, String Msg) {
    return 0;
  }

  /// 会員カードの読み取りを行う [レインボーカード仕様]
  ///  関連tprxソース: rcmbrkymbr.c - rcProc_RainbowMbr_Input
  static void rcProcRainbowMbrInput() {
    // TODO:10155 顧客呼出_実装対象外
  }

  /// 会員カードの読み取りを行う [顧客リアルOP仕様]
  /// 手入力されたカード情報から、Tカード判定を行う
  ///  関連tprxソース: rcmbrkymbr.c - rcProc_OpMbr_Input
  static void rcProcOpMbrInput() {
    // TODO:10155 顧客呼出_実装対象外
  }

  /// 手入力されたカード情報から、Tカード判定を行う
  ///  関連tprxソース: rcmbrkymbr.c - rcProc_TpointMbr_Input
  static void rcProcTpointMbrInput() {
    // TODO:10155 顧客呼出_実装対象外
  }

  /// 会員キーメイン関数（エラーNoは、AcMemクラスの変数「ent.errNo」に格納する）
  /// 戻り値: エラーNo（0=エラーなし）
  ///  関連tprxソース: rcmbrkymbr.c - rcPrg_Ky_Mbr
  static Future<void> rcPrgKyMbr() async {
    if (!(await RcFncChk.rcCheckStlMode()) &&
        (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR)) {
      await RcExt.cashStatSet("Rcmbrkymbr.rcPrgKyMbr()");
    }

    AcMem cMem = SystemFunc.readAcMem();
    debugPrint('********** 実機調査ログ（会員呼出）2: Rcmbrkymbr.rcMbrProc() スタート地点');
    cMem.ent.errNo = await rcMbrProc();
    debugPrint('********** 実機調査ログ（会員呼出）16: Rcmbrkymbr.rcMbrProc() = cMem.ent.errNo = ${cMem.ent.errNo}');

    if (CompileFlag.CUSTREALSVR) {
      if ((RcSysChk.rcChkCustrealsvrSystem()) ||
          (await RcSysChk.rcChkCustrealNecSystem(0))) {
        if (cMem.ent.errNo == RcMbr.RCMBR_TEL_LIST) {
          cMem.ent.errNo = Typ.OK;
        }
        else if (cMem.ent.errNo == RcMbr.RCMBR_NON_READ) {
          RcqrCom.custrealNonQrWriteFlg = 1;
          cMem.stat.fncCode = FuncKey.KY_CLR.keyId;
          await RckyClr.rcKyClr();
          cMem.ent.errNo = Typ.OK;
          RcqrCom.custrealNonQrWriteFlg = 0;
        }
      }
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Rcmbrkymbr.rcPrgKyMbr(): rxMemRead error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    CommonController commonCtrl = Get.find();

    if (cMem.ent.errNo != 0) {
      if (!(await RcFncChk.rcCheckStlMode()) &&
          (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR)) {
        await RcSet.cashStatReset2("Rcmbrkymbr.rcPrgKyMbr()");
      }
      if (await checkMbrDialog()) {
        // クーポン or ターゲットメッセージがある場合は一旦格納
        await setMbrReadError(cMem.ent.errNo);
      }
      else if (await RcSysChk.rcQCChkQcashierSystem()) {
        if (!RcObr.rcZHQErrorCodeChk(cMem.ent.errNo)) {
          if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
            await RcExt.rcErr("Rcmbrkymbr.rcPrgKyMbr()", cMem.ent.errNo);
          } else { //登録画面から実行
            await RcExt.rcErrToRegister("Rcmbrkymbr.rcPrgKyMbr()", cMem.ent.errNo);
          }
        }
      }
      else {
        if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
          await RcExt.rcErr("Rcmbrkymbr.rcPrgKyMbr()", cMem.ent.errNo);
        } else { //登録画面から実行
          await RcExt.rcErrToRegister("Rcmbrkymbr.rcPrgKyMbr()", cMem.ent.errNo);
        }
      }
      // RM-3800 フローティング仕様の場合、特定のエラーの時は会員取消を実行する
      if (CmCksys.cmChkRm5900FloatingSystem() != 0) {
        await Rc59dsp.rc59FloatingUseMbrClear(cMem.ent.errNo);
      }
    }
    else {
      if ((cBuf.dbTrm.seikatsuclubOpe != 0) &&
          !RcSysChk.rcCheckMbrTelMode() &&
          !RcFncChk.rcCheckScanCheck()) {
        if (mem.tTtllog.t100700Sts.custStatus == 3) {
          //TODO:00002 佐野 確認ダイアログを表示する（rcUnpaid_Union_Dialog()をフロント側関数に差し替える）
          //rcUnpaid_Union_Dialog();
        }
      }
    }
    rcKyMbrEnd();

    if ((cMem.ent.errNo == 0) &&
        (await CmCksys.cmPointartistConect() == CmSys.PARTIST_SOCKET)) {
      if (RcqrCom.qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_READ.index) {
        if (mem.tTtllog.t100700.realCustsrvFlg != 0) {
          if (await RcSysChk.rcQRChkPrintSystem()) {
            RcqrCom.rcQRSystemKeyToTxt(FuncKey.KY_MBR.keyId);
          }
          if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
            await RcExt.rcErr("Rcmbrkymbr.rcPrgKyMbr()",
                DlgConfirmMsgKind.MSG_CUSTREALSVR_OFFLINE.dlgId);
          } else { //登録画面から実行
            await RcExt.rcErrToRegister("Rcmbrkymbr.rcPrgKyMbr()",
                DlgConfirmMsgKind.MSG_CUSTREALSVR_OFFLINE.dlgId);
          }
        }
      }
      else {
        if ((await RcSysChk.rcQCChkQcashierSystem()) &&
            (mem.tTtllog.t100700.realCustsrvFlg != 0)) {
          mem.tTtllog.t100700.realCustsrvFlg = 0;
        }
      }
    }

    if ((cMem.ent.errNo == 0) &&
        (RcSysChk.rcChkCustrealPointInfinitySystem())) {
      if (RcqrCom.qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_READ.index) {
        if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId]) ||
            (!ReptEjConf.rcCheckRegistration())) {
          ;
        }
        else if (mem.tTtllog.t100700.realCustsrvFlg != 0) {
          if (await RcSysChk.rcQRChkPrintSystem()) {
            RcqrCom.rcQRSystemKeyToTxt(FuncKey.KY_MBR.keyId);
          }
          if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
            await RcExt.rcErr("Rcmbrkymbr.rcPrgKyMbr()",
                DlgConfirmMsgKind.MSG_CUSTREALSVR_OFFLINE.dlgId);
          } else { //登録画面から実行
            await RcExt.rcErrToRegister("Rcmbrkymbr.rcPrgKyMbr()",
                DlgConfirmMsgKind.MSG_CUSTREALSVR_OFFLINE.dlgId);
          }
        }
      }
    }
    setMbrReadStatus(0);	// 読込中の状態初期化
  }

  /// 全員向けのダイアログ表示が存在するかチェックする
  /// 戻り値: true=存在する  false=存在しない
  ///  関連tprxソース: rcmbrkymbr.c - rcmbrkymbr_Check_MbrDialog
  static Future<bool> checkMbrDialog() async {
    if (tmpReadData.status == 1) {
      if (rcMbrChkTargetMsg()
          || (await rcMbrChkCmplntMsg())
          || (await RcMbrCustDsp.rcMbrChkCustBmp())
          || (await rcMbrChkLoyLimitOverMsg())
          || (await rcMbrChkLoyRegOverMsg())
          || (await rcMbrChkCpnMsg() != 0)) {
        return true;
      }
    }
    return false;
  }

  /// ターゲットメッセージのダイアログ表示が存在するかチェック
  /// 戻り値: true=存在する  false=存在しない
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_ChkTargetMsg
  static bool rcMbrChkTargetMsg() {
    tgtMsgDlgCount = 0;
    rcMbrSetTargetMsg();
    if (tgtMsgDlgCount > 0) {
      return true;
    }
    rcMbrClearTargetMsg();
    return false;
  }

  /// クレーム／注意メッセージのダイアログ表示する条件かチェック
  /// 戻り値: true=表示する  false=表示しない
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_ChkCmplntMsg
  static Future<bool> rcMbrChkCmplntMsg() async {
    if ((await RcSysChk.rcQCChkQcashierSystem())
        || (await RcSysChk.rcSGChkSelfGateSystem())) {
      return false;
    }
    if (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) {
      return false;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Rcmbrkymbr.rcMbrChkCmplntMsg(): rxMemRead error");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if ((await CmCksys.cmDs2GodaiSystem() != 0)
        && (cBuf.dbTrm.complaintMessageDisp == 1)  // クレーム／注意メッセージ表示が「する」
        && ((cMem.custData.cust.attrib6 != 0)  // クレーム
            || (cMem.custData.cust.attrib7 != 0)))  // 注意
    {
      return true;
    }

    return false;
  }

  /// ロイヤリティ制限個数超過登録メッセージのダイアログ表示する条件かチェック
  /// 戻り値: true=表示する  false=表示しない
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_ChkLoyLimitOverMsg
  static Future<bool> rcMbrChkLoyLimitOverMsg() async {
    if ((await RcSysChk.rcQCChkQcashierSystem()) ||
        !(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) {
      return false;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Rcmbrkymbr.rcMbrChkLoyLimitOverMsg(): rxMemRead error");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((cBuf.dbTrm.loyLimitOverAlert == 1)  // 警告表示(ロイヤリティ特典個数制限を超えた登録)が「する」
      && (RcStlCal.rcStlCalLoyUnvldFlgChk() != 0))		// ロイヤリティ無効レコード発生
    {
      return true;
    }

    return false;
  }

  /// ロイヤリティオーバーエラーメッセージのダイアログ表示する条件かチェック
  /// 戻り値: true=表示する  false=表示しない
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_ChkLoyRegOverMsg
  static Future<bool> rcMbrChkLoyRegOverMsg() async {
    if ((await RcSysChk.rcQCChkQcashierSystem()) ||
        !(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) {
      return false;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Rcmbrkymbr.rcMbrChkLoyRegOverMsg(): rxMemRead error");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if ((cBuf.dbTrm.loyLimitOverAlert == 1)	// 警告表示(ロイヤリティ特典個数制限を超えた登録)が「する」
      && (mem.tTtllog.t100001Sts.loyRegoverFlg == 1))		// ロイヤリティオーバーエラー
    {
      return true;
    }

    return false;
  }

  /// クーポンーゲットメッセージのダイアログ表示が存在するかチェック
  /// 戻り値: 1=存在する 0=存在しない
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_ChkCpnMsg
  static Future<int> rcMbrChkCpnMsg() async {
    if ((await RcSysChk.rcQCChkQcashierSystem()) &&
        !(await RcSysChk.rcChkShopAndGoSystem())) {
      return 0;
    }

    AtSingl atSing = SystemFunc.readAtSingl();
    int ret = await RcKyCpnprn.cpnTblRead(0);
    if (ret > 0) {
      return 1;
    }
    else if ((ret < 0) && (atSing.zhqCpnErrFlg == 0)) {
      return ret;
    }

    return 0;
  }

  /// 会員呼出時のFIP表示を行う
  /// 引数: 操作機種
  ///  関連tprxソース: rcmbrkymbr.c - rcmbrDispFIP
  static Future<void> rcmbrDispFIP(int type) async {
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        return;
      }
    }
    switch (type) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        RcItmDsp.rcmbrDspFIP(RcRegs.FIP_NO1);
        break;
      case RcRegs.KY_SINGLE:
        RcItmDsp.rcmbrDspFIP(RcRegs.FIP_BOTH);
        break;
      case RcRegs.KY_CHECKER:
        RcItmDsp.rcmbrDspFIP(RcRegs.FIP_NO2);
        break;
    }
  }

  /// 全員向けのダイアログ表示とエラー表示が被ってしまった場合に対応するため, 顧客呼出状態を一時保存する
  /// 引数: 0=読み込み中でない  1=読み込み中
  ///  関連tprxソース: rcmbrkymbr.c - rcmbrkymbr_Set_MbrRead_Status
  static void setMbrReadStatus(int status) {
    tmpReadData.status = status;
  }

  /// 全員向けのダイアログ表示とエラー表示が被ってしまった場合のエラー情報格納用
  /// 引数: 0以外でエラーコードを格納して全員向けメッセージの後に表示する
  ///  関連tprxソース: rcmbrkymbr.c - rcmbrkymbr_Set_MbrReadError
  static Future<void> setMbrReadError(int errCd) async {
    tmpReadData.errCd = errCd;
    if (errCd > 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Rcmbrkymbr.setMbrReadError(): set [${tmpReadData.errCd}]");
    }
  }

  /// 顧客キー終了処理
  ///  関連tprxソース: rcmbrkymbr.c - rcKy_Mbr_End
  static void rcKyMbrEnd() {
    RcSet.rcClearEntry();
  }

  /// 会員読み取り画面を表示する
  ///  関連tprxソース: rcmbrkymbr.c - Scan_Mbr_Dsp
  static void scanMbrDsp() {
    // TODO:10122 グラフィクス処理（gtk_*）
  }

  /// 会員読み取り画面を閉じる
  ///  関連tprxソース: rcmbrkymbr.c - Clr_Scan_Mbr_Dsp
  static Future<void> clrScanMbrDsp() async {
    // TODO:10122 グラフィクス処理（gtk_*）
    // GtkWidget scn_mbr_win
    // if (scn_mbr_win != NULL)
    // {
    //    gtk_widget_destroy(scn_mbr_win);
    //    rc28MainWindow_SizeChange(0);
    //    rcItmLcd_ScrMode();
    //    rcItem_Disp_LCD();
    // }

    RcSet.rcClearEntry();

    comText1 = "";
    comText2 = "";
    comText3 = "";
    comText4 = "";
    comText5 = "";
    comText6 = "";

    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    if (mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index) {
      if (ReptEjConf.rcCheckRegistration() &&
          (await RcFncChk.rcCheckOtherRegistration()) == 0) {
        cMem.postReg.change = 0;
        cMem.postReg.sub_ttl = 0;
        cMem.postReg.sum_ttl = 0;
        cMem.postReg.tend = 0;
        RcRegs.kyStR1(cMem.keyStat, FncCode.KY_REG.keyId);
      }
      await RcSet.rcClearKyItem(); /* Set Bit 3 of KY_FNAL */
    }

    if (cMem.keyStat[FuncKey.KY_MBR.keyId] != 0) {
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_MBR.keyId);
    } /* Reset MBR_TEL Refer Mode */
    if (cMem.keyStat[FuncKey.KY_TEL.keyId] != 0) {
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_TEL.keyId);
    } /* Reset TEL Refer Mode */
  }

  ///  関連tprxソース: rcmbrkymbr.c - rcDualSingle_ClearScnMbr
  static Future<void> rcDualSingleClearScnMbr() async {
    RcSet.rcClearEntry();
    if ((await RcSysChk.rcKySelf()) == RcRegs.KY_DUALCSHR) {
      RegsMem mem = SystemFunc.readRegsMem();
      AcMem cMem = SystemFunc.readAcMem();
      if (mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index) {
        if (mem.tTtllog.t100001Sts.itemlogCnt == 0) {
          cMem.postReg.change = 0;
          cMem.postReg.sub_ttl = 0;
          cMem.postReg.sum_ttl = 0;
          cMem.postReg.tend = 0;
          /* Reset Bit 1 of KY_REG */
          RcRegs.kyStR1(cMem.keyStat, FncCode.KY_REG.keyId);
        }
        await RcSet.rcClearKyItem(); /* Set Bit 3 of KY_FNAL  */
      }
      RcItmDsp.rcDualConfDestroy();
      Dummy.rcDualhalfDefault();
      RcStlLcd.rcStlLcdScrModeDualCashier();

      comText1 = "";
      comText2 = "";
      comText3 = "";
      comText4 = "";
      comText5 = "";
      comText6 = "";

      if (cMem.keyStat[FuncKey.KY_MBR.keyId] != 0) {
        RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_MBR.keyId);
      }
      /* Reset MBR_TEL Refer Mode */
      if (cMem.keyStat[FuncKey.KY_TEL.keyId] != 0) {
        RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_TEL.keyId);
      } /* Reset TEL Refer Mode */
    }

    // TODO:10122 グラフィクス処理（gtk_*）
    // GtkWidget系
    // if (DualScnMbr.window != NULL)
    //   gtk_widget_destroy(DualScnMbr.window);
    // DualScnMbr.window = NULL;
  }

  /// レシートバッファに顧客データがあるかを返す
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_Mac
  static Future<int> rcMbrMac(MbrInputType member, int waitFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    AcMem cMem = SystemFunc.readAcMem();
    int ret = await RcKyCpnprn.cpnTblRead(0);
    RegsMem mem = SystemFunc.readRegsMem();
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Rcmbrkymbr.rcMbrChkCmplntMsg(): rxMemRead error");
      return (DlgConfirmMsgKind.MSG_RPNT_DUALINPUTERR.dlgId);
    }
    RxCommonBuf cBuf = xRet.object;

    CommonController commonCtrl = Get.find();

    if (member != MbrInputType.mbrKeyInput) {
      if (RcSysChk.rcChkWSSystem()) {
        if ((ReptEjConf.rcCheckRegistration()) &&
            (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index)) {
          return (DlgConfirmMsgKind.MSG_NOTUSE_STAFFCALL.dlgId);
        }
      }
      if (((member != MbrInputType.magcardInput) &&
          (member != MbrInputType.mbrCodeInput)) &&
          ((await CmCksys.cmSpDepartmentSystem()) == 1)) {
        return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
      }
      if (((member != MbrInputType.mcardInput) &&
          (member != MbrInputType.mbrKeyInput) &&
          (member != MbrInputType.telnoInput) &&
          (member != MbrInputType.mbrCodeInput)) &&
          (await RcSysChk.rcChkEdyNoMbrSystem())) {
        return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
      }
      if ((member != MbrInputType.felicaInput) &&
          (!((cBuf.dbTrm.cardsheetPrn == 1) &&
              (member == MbrInputType.magcardInput))) &&
          (await RcSysChk.rcChkFelicaSystem())) {
        return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
      }
      if ((member != MbrInputType.mcp200Input) &&
          (await RcSysChk.rcChkFelicaSystem()) &&
          (!(await CmCksys.cmDcmpointSystem() == 1))) {
        return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
      }
      if ((await RcSysChk.rcChkFcfSystem())) {
        if (member == MbrInputType.felicaInput) {
          member = MbrInputType.barcodeInput;
        } else {
          return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
        }
      }
      if ((member != MbrInputType.hitachiInput) &&
          (await RcSysChk.rcChkHt2980System())) {
        return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
      }
      if ((member != MbrInputType.absV31Input) &&
          (await RcSysChk.rcChkAbsV31System())) {
        return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
      }
      if ((RcSysChk.rcsyschkYunaitoHdSystem() != 0) &&
          (member == MbrInputType.barReceivInput)) {
        if (cBuf.dbTrm.crdtInfoOrder == 0) {
          //特定ユーザー用　売掛会員仕様「しない」の場合
          return (DlgConfirmMsgKind.MSG_CHK_RECEIV.dlgId);
        }
      }
    }

    if ((RcSysChk.rcsyschkYunaitoHdSystem() != 0)
        && (Dummy.rcChkDPointDualMemberType() != 1)
        && (RcFncChk.rcCheckRegistration()
            || ((await RcFncChk.rcCheckESVoidSMode()) ||
                (await RcFncChk.rcCheckESVoidIMode())))) {
      if (!RcFncChk.rcCheckScanCheck()) {
        return (DlgConfirmMsgKind.MSG_DPTS_DUALINPUTERR.dlgId);
      }
    }

    /*
    * 楽天ポイント仕様が有効、かつ、１取引内における他の会員との併用をしない設定で、
    * 既に楽天ポイントカードを読んでいる場合、自社ポイントカードの読み取りはエラーにする
    */
    if ((RcSysChk.rcsyschkRpointSystem() != 0)
        && (cBuf.dbTrm.rpntDualFlg != 1)
        && (RcSysChk.rcsyschkRpointSystem() != 0)
        && RcFncChk.rcCheckRegistration()
        && !RcFncChk.rcCheckScanCheck()) {
      return (DlgConfirmMsgKind.MSG_RPNT_DUALINPUTERR.dlgId);
    }

    ret = await RcMbrFlrd.rcmbrReadAccountMstChk();
    if (ret != Typ.OK) {
      // アカウントマスタの存在チェック
      return ret;
    }

    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        if ((await RcSysChk.rcChkDPointSelfSystem())
            && (RcFncChk.rcSGCheckMbrScnMode() &&
                (RcSgDsp.mbrScnDsp.mbrcardReadtyp == MbrCardReadType.DPOINT_READ.index)) ) {
          return DlgConfirmMsgKind.MSG_READ_DPOINT.dlgId;
        }
        else if ((await RcSysChk.rcChkRPointSelfSystem())			/* 楽天ポイント仕様のフルセルフレジ */
            && (RcFncChk.rcSGCheckMbrScnMode() &&
                (RcSgDsp.mbrScnDsp.mbrcardReadtyp == MbrCardReadType.RPOINT_READ.index)) ) {
          /* 楽天ポイントカードを読ませてください */
          return DlgConfirmMsgKind.MSG_READ_RPNT.dlgId;
        }
        else if ((await RcSysChk.rcChkTomoSelfSystem())			/* 友の会仕様のフルセルフレジ */
            && (RcFncChk.rcSGCheckMbrScnMode() &&
                (RcSgDsp.mbrScnDsp.mbrcardReadtyp == MbrCardReadType.TOMO_READ.index)) ) {
          /* 友の会カードを読ませてください */
          return DlgConfirmMsgKind.MSG_READ_TOMO.dlgId;
        }
      }
    }

    debugPrint('********** 実機調査ログ（会員呼出）4: Rcmbrkymbr.mbrRead(${MbrInputType.mbrKeyInput.index}, RcMbr.RCMBR_WAIT) スタート地点');
    ret = await mbrRead(member.index, waitFlg);
    debugPrint('********** 実機調査ログ（会員呼出）12: RcMbrFlrd.mbrRead() = $ret');
    if (RcSysChk.rcChkCustrealsvrSystem() ||
        RcSysChk.rcChkCustrealsvrSystem()) {
      ret = mbrReadChk(ret, member);
    }
    else if (RcSysChk.rcChkCustrealWebserSystem()) {
      ret = mbrReadChk(ret, member);
    }
    else if (await RcSysChk.rcChkCustrealNecSystem(0)) {
      ret = mbrReadChk(ret, member);
    }
    else if (RcSysChk.rcChkCustrealOPSystem()) {
      ret = mbrReadChk(ret, member);
    }
    else if (RcSysChk.rcChkCustrealPointartistSystem() != 0) {
      ret = mbrReadChk(ret, member);
    }
    else if (RcSysChk.rcChkTpointSystem() != 0) {
      ret = mbrReadChk(ret, member);
    }
    else if (RcSysChk.rcChkCustrealPointTactixSystem() != 0) {
      ret = mbrReadChk(ret, member);
    }
    else if (RcSysChk.rcChkCustrealFrestaSystem()) {
      ret = mbrReadChk(ret, member);
    }
    else if (RcSysChk.rcChkCosme1IstyleSystem()) {
      ret = mbrReadChk(ret, member);
    }
    else {
      RckyStl.rcDisableFlgSet();
      if ((ret == Typ.OK) || (ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId)) {
        if (RcSysChk.rcChkMbrRCPdscSystem() &&
               (ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId) &&
               ((RcMbrCom.rcChkMemberRCpdsc(cMem.working.janInf.code) == true) ||
                   (RcMbrCom.rcChkMemberStaffpdsc(cMem.working.janInf.code) == true)  )) {
          if (mem.tTtllog.t100700Sts.mbrTyp == 4) {
            return (Typ.OK);
          }
        }
        else {
          if (CompileFlag.ARCS_MBR) {
            if ((ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId) && !RcSysChk.rcCheckOthMbr() &&
                ((mem.tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSCRDT) &&
                    (mem.tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSVISA) &&
                    (mem.tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSCARD))) {
              return (ret);
            }
          }
          else {
            if ((ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId) && !RcSysChk.rcCheckOthMbr()) {
              return (ret);
            }
          }
          if ((ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId)
              && (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index)
              && (member != MbrInputType.mbrprcKeyInput)) {
              /* 会員売価キー押下後存在しない会員を呼び出したとき */
            return (ret);
          }
        }
        if (RcFncChk.rcCheckScanCheck() &&
            (ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId)) {
          return (ret);
        }
        if ((await CmCksys.cmDcmpointSystem() != 0) &&
            (ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId)) {
          if (Cmmcdchk.cmMcdCheckTS3(cMem.custData.cust.cust_no!) == TS3.TS3_DAIKI_MBR_CRDT) {
            if (cBuf.dbTrm.memUseTyp == 0) {
              mem.tTtllog.t100700Sts.nombrmsgNo = 0;
            }
            else if ((mem.tTtllog.t100700Sts.nombrmsgNo == 0) && (cBuf.dbTrm.memUseTyp != 1)) {
              mem.tTtllog.t100700Sts.nombrmsgNo = ret;
            }
          }
        }
        debugPrint('********** 実機調査ログ（会員呼出）13(OK): RcMbrFlrd.rcSetMbrPrc() スタート地点');
        await rcSetMbrPrc();
        debugPrint('********** 実機調査ログ（会員呼出）14(OK): RcMbrFlrd.rcSetMbrPrc() = $ret');

        if (RcSysChk.rcsyschkAyahaSystem()) {
          AtSingl atSing = SystemFunc.readAtSingl();
          atSing.ayahaImmpromFlg = 0;
          Dummy.rcmbrrecalSetImmpromData();
          if (atSing.ayahaImmpromFlg != -1) {
            await RcExt.rxChkModeSet("rcMbrMac");
            RcRecno.rcSetRctJnlNo();
            await RcSetDate.rcSetDate();
            mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_AYAHA_IMMPROM.index;
            int errNo1 = RcIfEvent.rcSendPrint();
            int errNo2 = RcIfEvent.rcSendUpdate();
            if (errNo1 == Typ.OK) {
              RckyRpr.rcWaitResponce(FuncKey.KY_DETAIL.keyId);  //最終的にしたい事が同じなのでKY_DETAILを代用
            }
            else {
              RcSet.rcErr1timeSet();
              await RcExt.rxChkModeReset("");
            }
            if (errNo2 == Typ.OK) {
              RcRecno.rcIncRctJnlNo(false);
            }
          }
          atSing.ayahaImmpromFlg = 0;
        }
        if ((await RcSysChk.rcChkStdCust())) {
          if (mem.tTtllog.t100700.realCustsrvFlg == 3) {
            // 3: ロック中
            if (!rcChkMbrOfflineDlg()) {
              ret = DlgConfirmMsgKind.MSG_CUSTOTHUSE.dlgId;
            }
          }
          else if (mem.tTtllog.t100700.realCustsrvFlg == 1) {
            // 1: オフライン
            ret = DlgConfirmMsgKind.MSG_CUST_OFFLINE.dlgId; // 会員情報が取得できませんでした。オフライン会員として扱います
          }
        }
        // ■RM-3800 フローティング仕様の場合、フローティングサーバに格納されている加算情報の会員入力済みをチェックする
        if (ret == 0) {
          if (CmCksys.cmChkRm5900FloatingSystem() != 0) {
            ret = Dummy.rc59FloatingUseCustCheck(cMem.custData.cust.cust_no);
          }
        }
        if (mem.tTtllog.t100700Sts.nombrmsgNo != 0) {
          if (cBuf.dbTrm.memUseTyp == 0) {
            if (ret == 0) {
              if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
                await RcExt.rcErr("Rcmbrkymbr.rcMbrMac()",
                    (mem.tTtllog.t100700Sts.nombrmsgNo).abs());
              } else { //登録画面から実行
                await RcExt.rcErrToRegister("Rcmbrkymbr.rcMbrMac()",
                    (mem.tTtllog.t100700Sts.nombrmsgNo).abs());
              }
              mem.tTtllog.t100700Sts.nombrmsgNo = DbMsgMstId.DB_MSGMST_SPECIAL5.id;
            }
          }
          else {
            ret = (mem.tTtllog.t100700Sts.nombrmsgNo).abs();
            mem.tTtllog.t100700Sts.nombrmsgNo = DbMsgMstId.DB_MSGMST_SPECIAL5.id;
          }
        }
        // 会員登録時割戻しチケット印字が有効時には、会員呼出時のチケット発行枚数を保持
        // 会員登録時割戻しチケット印字が有効時には、会員呼出時に割戻しチケットを印字するため、締め処理時にはファンファーレとメッセージを動作させない。
        // ↓↓↓　2018/06/01 下記のテストについては未確認
        //            ・記念日のおめでとう表示、印字
        //            ・チケット発行キー
        //            ・他レジでのポイント変動（買上げ追加）
        //            ・他レジでのポイント変動（登録）
        //            ・オフラインテスト
        if (await rcmbrChkMbrCallSvcTk() &&
            !((await RcFncChk.rcCheckESVoidMode()) ||
                (await RcFncChk.rcCheckESVoidSMode()) ||
                (await RcFncChk.rcCheckESVoidIMode()) ||
                (await RcFncChk.rcCheckESVoidVMode()) ||
                (await RcFncChk.rcCheckESVoidCMode()) ||
                (await RcFncChk.rcCheckESVoidSDMode()))) {
          String log = "rcMbrMac : MbrCall dtip_ttlsrv = ${mem.tTtllog.t100701.dtipTtlsrv}";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
          mem.prnrBuf.mbrCallSvctk.mbrcallSvctkFlg = 1;
          mem.prnrBuf.mbrCallSvctk.dtipTtlsrv = mem.tTtllog.t100701.dtipTtlsrv;
          // 会員登録時割戻しチケット印字が有効時には、会員呼出し時のチケット発券ポイントをQRお会計券にセットする
          if (qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_READ) {
            if (await RcSysChk.rcQRChkPrintSystem()) {
              // 会員呼出処理終了後にQRへ書込み処理を行う。
              timeout3 = Fb2Gtk.gtkTimeoutAdd(500, rcmbrMarusyoQRToTxt, 0);
            }
          }
        }
        // ↑↑↑　2018/06/01
      }
      else if (CompileFlag.RALSE_MBRSYSTEM && (ret == DlgConfirmMsgKind.MSG_OTHERMBR.dlgId)) {
        mem.tTtllog.t100700.mbrNameKanji1 =  cMem.custData.cust.last_name!;
        mem.tTtllog.t100700.mbrNameKanji2 =  cMem.custData.cust.first_name!;
      }
    }
    return (ret);
  }

  /// 顧客データ読み込み
  /// 引数:[member] 会員入力方法
  /// 引数:[waitFlg] 待ち時間
  /// 戻り値: 0=正常終了  0以外=異常終了
  ///  関連tprxソース: rcmbrkymbr.c - MbrRead
  static Future<int> mbrRead(int member, int waitFlg) async {
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    String custCd = "";
    String inputCd = "";
    String birthDay = "";
    String mbrCd = "";
    int	head = 0;
    if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_MBR.keyId]) ||
        RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId])) {	/* 電話番号 */
      // TODO:10124 文字コード変換（cm_bcdtoa）
      //cm_bcdtoa(inputCd, (char *)&cMem.ent.entry[0], MBR_ENTRY_MAX, 10);
      head = MBR_ENTRY_MAX - cMem.ent.tencnt;
      if (CompileFlag.CUSTBIRTHSERCH) {
        if (member == MbrInputType.telnoInput.index) {
          birthDay = telSch.birthDay;
          if (birthDay != "0000") {
            birthDay = "    ";
          }
        }
        else {
          birthDay = "    ";
        }
      }
      else {
        birthDay = "    ";
      }
      ret = await RcMbrFlrd.rcmbrReadCust("", inputCd[head], birthDay, member, RcMbr.RCMBR_WAIT);
      if (ret == Typ.OK) {
        if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_MBR.keyId])) {
          RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_MBR.keyId);    /* Reset MBR_TEL Refer Mode */
        }
        if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId])) {
          RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_TEL.keyId);               /* Reset TEL Refer Mode */
        }
      } else {
        if ((!ReptEjConf.rcCheckRegistration()) && RcSysChk.rcCheckOthMbr()) {
          mem.tTtllog.t100700.otherStoreMbr = 0;
        }
      }
    }
    else {						/* 会員番号 */
      if (RcSysChk.rcChkCustrealsvrSystem() ||
          (RcSysChk.rcChkCustrealUIDSystem() != 0) ||
          RcSysChk.rcChkCustrealOPSystem() ||
          (RcSysChk.rcChkCustrealPointartistSystem() != 0) ||
          (RcSysChk.rcChkTpointSystem() != 0) ||
          (RcSysChk.rcChkCustrealPointTactixSystem() != 0) ||
          RcSysChk.rcChkCustrealPointInfinitySystem() ||
          RcSysChk.rcChkCustrealFrestaSystem() ||
          RcSysChk.rcChkCosme1IstyleSystem()) {
        if (CompileFlag.SELF_GATE) {
          if (await CmCksys.cmDcmpointSystem() != 0) {
            if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
              waitFlg |= RcMbr.RCMBR_MSGDSP;
            }
          }
        }
        ret = await RcMbrFlrd.rcmbrReadCust(cMem.working.janInf.code, "", "", member, waitFlg);
      }
      else if (await RcSysChk.rcChkCustrealNecSystem(0)) {
        if (CompileFlag.ARCS_MBR) {
          if (RcSysChk.rcChkRalseCardSystem() &&
              (await CmMbrSys.cmNewARCSSystem() != 0)) {
            if ((atSing.mbrTyp == Mcd.MCD_RLSOTHER) ||
                (atSing.mbrTyp == Mcd.MCD_RLSSTAFF) ||
                ( ((atSing.mbrTyp == Mcd.MCD_RLSCRDT) ||
                    (atSing.mbrTyp == Mcd.MCD_RLSVISA)) &&
                  (mem.tTtllog.t100700Sts.mbrTyp == Mcd.MCD_RLSSTAFF) &&
                  (ReptEjConf.rcCheckRegistration())) ) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "Rcmbrkymbr.mbrRead(): skip CustRealServer off line flag clear");
            }
            else {
              if (member != MbrInputType.mbrprcKeyInput.index) {
                RcNecRealSvr.necCustRealOffLineClr();
                cBuf.custOffline = 0;
              }
            }
          }
        }
        ret = await RcMbrFlrd.rcmbrReadCust(cMem.working.janInf.code, "", "", member, waitFlg);
      }
      else if (await RcSysChk.rcChkZHQsystem()) {
        if ((member == MbrInputType.mbrKeyInput.index) ||
            (member == MbrInputType.mbrCodeInput.index)) {
          mbrCd = cMem.working.janInf.code;
        }
        else {
          mbrCd = atSing.inputbuf.Acode.substring(1, CmMbrSys.cmMbrcdLen()+1);
        }
        ret = await RcMbrFlrd.rcmbrReadCust(mbrCd, "", "", member, waitFlg);
        if (RcObr.rcZHQErrorCodeChk(ret)) {
          mem.tTtllog.t100700.mbrInput = member;
        }
      }
      else {
        if (cBuf.dbTrm.nw7mbrBarcode2 != 0) {
          custCd = custCd.padLeft(Ean.ASC_EAN_13, "0");
          if (cMem.working.janInf.code.substring(0, 2) == "29") {
            custCd = custCd.substring(0, 4) + cMem.working.janInf.code.substring(4, 12);
          }
          else {
            custCd = custCd.substring(0, 4) + cMem.working.janInf.code.substring(3, 11);
          }
          ret = await RcMbrFlrd.rcmbrReadCust(custCd, "", "", member, RcMbr.RCMBR_WAIT);
        }
        else {
          debugPrint('********** 実機調査ログ（会員呼出）5: RcMbrFlrd.rcmbrReadCust(${cMem.working.janInf.code}, ${""}, ${""}, $member, RcMbr.RCMBR_WAIT) スタート地点');
          ret = await RcMbrFlrd.rcmbrReadCust(cMem.working.janInf.code, "", "", member, RcMbr.RCMBR_WAIT);
          debugPrint('********** 実機調査ログ（会員呼出）11: RcMbrFlrd.rcmbrReadCust() = $ret');
        }
      }
    }

    return ret;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（実機ログ未出力）
  /// 顧客データ読み込みのチェックおよび結果を共有メモリに格納する
  ///  関連tprxソース: rcmbrkymbr.c - MbrReadChk
  static int mbrReadChk(int readRet, MbrInputType member) {
    return 0;
  }

  ///  関連tprxソース: rcmbrkymbr.c - rcProc_telmsg_read
  static Future<int> rcProcTelmsgRead() async {
    int ret = await RcKyCpnprn.cpnTblRead(0);
    AcMem cMem = SystemFunc.readAcMem();

    Dummy.rcTimerListRemove(RC_TIMER_LISTS.RC_MBR_TEL_WAIT_TIMER);

    ret = (await rcMbrMac(
        MbrInputType.telnoInput, RcMbr.RCMBR_WAIT)); /* Member Tel in Refer */
    if (ret == RcMbr.RCMBR_TEL_LIST) {
      cMem.ent.errNo = Typ.OK;
    }
    else {
      cMem.ent.errNo = ret;
    }

    CommonController commonCtrl = Get.find();

    if (cMem.ent.errNo != 0) {
      if ((!(await RcFncChk.rcCheckStlMode())) &&
          ((await RcSysChk.rcKySelf()) != RcRegs.KY_DUALCSHR)) {
        RcSet.cashStatReset2("rcProcTelmsgRead");
      }
      if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
        await RcExt.rcErr("Rcmbrkymbr.rcProcTelmsgRead()", cMem.ent.errNo);
      } else { //登録画面から実行
        await RcExt.rcErrToRegister("Rcmbrkymbr.rcProcTelmsgRead()", cMem.ent.errNo);
      }
    }
    rcKyMbrEnd();

    return (0);
  }

  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_Proc
  static Future<int> rcMbrProc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    int ret = await RcKyCpnprn.cpnTblRead(0);

    if (RcSysChk.rcCheckMbrTelMode()) {
      if (FbInit.subinitMainSingleSpecialChk() == true) {
        cMem.stat.dualTSingle = cBuf.devId;
      }
      else {
        cMem.stat.dualTSingle = 0;
      }
      if (RcSysChk.rcChkCustrealsvrSystem() || (await RcSysChk.rcChkCustrealNecSystem(0))) {
        // CustWaitDialogConf(MSG_MBRINQUIR, 0, TPRDLG_PT10); 不要
        RcTimer.rcTimerListAdd(RC_TIMER_LISTS.RC_MBR_TEL_WAIT_TIMER, 60, rcProcTelmsgRead, 0);
        return RcMbr.RCMBR_TEL_LIST;
      }
      else {
        ret = await rcMbrMac(MbrInputType.telnoInput, RcMbr.RCMBR_WAIT);
      }
    }
    else {
      if (!(await RcFncChk.rcCheckStlMode()) && (await RcSysChk.rcKySelf()) != RcRegs.KY_DUALCSHR) {
        RcSet.cashStatReset2("rcMbrProc");
      }
      ret = await rcChkMbrCode();
      if (ret != 0) {
        if (RcSysChk.rcsyschkYunaitoHdSystem() != 0) {
          var receivflg = RcMbrCom.rcmbrGetReceivBarFlg();
          var receivCd = receivflg.toString();
          if (cMem.working.janInf.code.substring(0, 2) == receivCd) {
            cMem.working.janInf.type = JANInfConsts.JANformatChargeSlip;
            ret = await rcMbrMac(MbrInputType.barReceivInput, RcMbr.RCMBR_WAIT);
          }
          else {
            ret = await rcMbrMac(MbrInputType.mbrKeyInput, RcMbr.RCMBR_WAIT);
          }
        }
        else if (RcSysChk.rcChkCustrealsvrSystem() || (await RcSysChk.rcChkCustrealNecSystem(0))) {
          ret = await rcMbrMac(MbrInputType.mbrKeyInput, RcMbr.RCMBR_NON_WAIT);
        }
        else {
          debugPrint('********** 実機調査ログ（会員呼出）3: Rcmbrkymbr.rcMbrMac(MbrInputType.mbrKeyInput, RcMbr.RCMBR_WAIT) スタート地点');
          ret = await rcMbrMac(MbrInputType.mbrKeyInput, RcMbr.RCMBR_WAIT);
          debugPrint('********** 実機調査ログ（会員呼出）15: Rcmbrkymbr.rcMbrMac() = $ret');
        }
      }
      else {
        if (ret == 0) {
          ret = DlgConfirmMsgKind.MSG_BARFMTERR.dlgId;
        }
      }
    }
    
    if (ret == RcMbr.RCMBR_TEL_LIST) {
      return Typ.OK;
    }
    
    if (ret == 0) {
      if (RcFncChk.rcCheckScanCheck()) {
        rcScnMbr();
      }
    }
    
    await rcMbrEnd();
    return ret;
  }

  /// 会員番号かチェックする
  /// 戻り値: 0=会員コードでない / 1=会員コード / 左記以外=エラーコード
  ///  関連tprxソース: rcmbrkymbr.c - rcChk_Mbr_Code
  static Future<int> rcChkMbrCode() async {
    int ret = 1;
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcChkZHQsystem()) {
      if (cMem.ent.tencnt != CmMbrSys.cmMbrcdLen()) {
        return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
      }
    }
    if (RcSysChk.rcChkCustrealPointTactixSystem() != 0) {
      if (cMem.ent.tencnt > CmMbrSys.cmMbrcdLen()) {
        return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
      }
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    int bcdSize = (CmMbrSys.cmMbrcdLen() ~/ 2) + (CmMbrSys.cmMbrcdLen() % 2);
    String inputCd = mbrId;  //最大20桁の数値
    // TODO:10124 文字コード変換（cm_bcdtoa）
    //cm_bcdtoa(inputCd, (char *)&cMem.ent.entry[10-bcdsize], cm_mbrcd_len(), bcdsize);
    String custCd = "";
    int errNo = 0;

    cMem.ent.tencnt = inputCd.length;
    if (await RcSysChk.rcChkEdyNoMbrSystem()) {
      for (int idx = 0; idx < 2; idx++) {
        if (cMem.ent.entry[idx] != 0x00) {
          ret = DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
        }
      }
      if (ret == 1) {
        custCd = inputCd;
        cMem.working.janInf.code = custCd;
      }
      return ret;
    }
    else if (await CmCksys.cmSm36SanprazaSystem() != 0) {
      custCd = inputCd;
      cMem.working.janInf.code = custCd;
      return ret;
    }
    else {
      if (RcMbrCom.rcChkOtherCo1()) {
        errNo = RcMbrCom.rcChkMagcdDigit(inputCd);
      }
      if (errNo == 0) {
        (ret, custCd) = await RcMbrCom.rcmbrMakeMbrCode(inputCd);
      }
      else {
        ret = errNo;
      }
    }

    /* 売掛伝票印字仕様は7000001～以外はエラーとする */
    if ((cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) &&
        (await RcSysChk.rcChkChargeSlipSystem()) &&
        (custCd != "7000001")) {
      return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
    }
    RcSysChk.rcClearJanInf();
    cMem.working.janInf.code = custCd;

    int receivFlg = 0;
    int receivChk = 0;
    String receivCd = "";

    if (RcSysChk.rcsyschkYunaitoHdSystem() != 0) {
      receivFlg = RcMbrCom.rcmbrGetReceivBarFlg();
      receivCd = "$receivFlg";
      if (cMem.working.janInf.code.substring(0, 2) == receivCd) {
        receivChk = 1;
      }
    }
    if (await RcSysChk.rcChkZHQsystem()) {
      ret = 1;
    }
    else if (await CmCksys.cmDs2GodaiSystem() != 0) {
      ret = 1;
    }
    else if (RcSysChk.rcChkCustrealPointTactixSystem() != 0) {
      ret = 1;
    }
    else if (RcSysChk.rcChkCosme1IstyleSystem()) {
      ret = 1;
    }
    else if (receivChk == 1) {
      ret = 1;
    }
    else if (!((cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) &&
        (await RcSysChk.rcChkChargeSlipSystem()) &&
        (custCd != "7000001"))) {
      if (await RcMbrCom.rcmbrChkMbrCode()) {
        ret = 1;
      }
      else {
        ret = 0;
      }
    }
    else {
      /* サンワドーは、c/dなしなので強制的にOKにする */
      ret = 1;
    }

    return ret;
  }

  /// 会員登録時に割戻チケットを印字する設定であるかチェックする
  /// 戻り値: true=設定有効  false=設定無効
  /// 関連tprxソース: rcmbrkymbr.c - rcmbr_Chk_MbrCallSvcTk
  static Future<bool> rcmbrChkMbrCallSvcTk() async {
    if (!rcmbrChkMarusyoSystem()) {
      return false;
    }
    if (!( ((await RcSysChk.rcQCChkQcashierSystem()) &&
        RcFncChk.rcQCCheckMenteDspMode() ) ||  // QCashierのメンテナンス
        (await RcSysChk.rcQRChkPrintSystem()) )) {  // Speeza
      return false;
    }

    return true;
  }

  /// スキャン時における会員チェック
  /// 関連tprxソース: rcmbrkymbr.c - rcScnMbr
  static Future<void> rcScnMbr() async {
    if (await Rcmbrrealsvr.custRealSvrWaitChk()) {
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    CommonController commonCtrl = Get.find();

    if (RcFncChk.rcCheckScanCheck()) {  /* Scanning Check ? */
      if (await RcFncChk.rcCheckPrcChkMode()) {
        return;
      }
      if (CompileFlag.ARCS_MBR) {
        if (RcSysChk.rcChkRalseCardSystem()) {
          await RcMcd.rcRalseMcdCrdtRegClr();
        }
      }
      else if (CompileFlag.RALSE_MBRSYSTEM) {
        if (RcSysChk.rcChkRalseCardSystem()) {
          if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
            await RcExt.rcErr("rcScnMbr", DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          } else { //登録画面から実行
            await RcExt.rcErrToRegister("rcScnMbr", DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          }
          if (mem.tTtllog.t100001Sts.itemlogCnt == 0) {
            cMem.postReg = PostReg();
            RcRegs.kyStR1(cMem.keyStat, FncCode.KY_REG.keyId);
          }
          return;
        }
      }
      if (!(RcSysChk.rcTROpeModeChk()
          || (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_TRAINING))) {
        if (cBuf.dbTrm.custsvrCnctOfflineChk != 0) {
          if (Rcmbrrealsvr.svrOfflineChkFlg == 1) {
            return;
          }
        }
      }

      if (RcFncChk.rcCheckScnMbrMode()) {
        await clrScanMbrDsp();
        if (FbInit.subinitMainSingleSpecialChk()) {
          await rcDualSingleClearScnMbr();
        }
      }
      if (await RcFncChk.rcChkScnMbrModeDualCshr()) {
        await rcDualSingleClearScnMbr();
      }
      await RckyClr.rcClearBuffer();
      // TODO:10155 顧客情報（電話番号一覧表示は対象外のため、コメント化）
      //if (! rcmbrTelListClrKeyFnc()) {
        RckyClr.rcClearDisplay();
      //}
      RcSet.rcSetScnItmSel();
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR)
          && (await RcFncChk.rcCheckStlMode())) {
        await RcSet.rcScnMbrModeDualCshr();
      }
      else {
        RcSet.rcScnMbrMode();
      }
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_CHECKER:
        case RcRegs.KY_SINGLE:
          scanMbrDsp();
          if (FbInit.subinitMainSingleSpecialChk()) {
            rcDualSingleScanMbr();
          }
          break;
        case RcRegs.KY_DUALCSHR:
          if (await RcFncChk.rcChkScnMbrModeDualCshr()) {
            rcDualSingleScanMbr();
          }
          else {
            scanMbrDsp();
          }
          break;
        default:
          break;
      }
      // TODO:10122 グラフィックス処理
      /*
      rcScnChk_PrInit(&((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->ScnChk);
      CustNo_Draw();
      if (CompileFlag.ARCS_MBR) {
        if (!RcSysChk.rcChkRalseCardSystem()) {
          CustName_Draw();
          TotalBuyAmt_Draw();
        }
      }
      else {
        CustName_Draw();
        TotalBuyAmt_Draw();
      }
      if (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT) != 0) {
         TotalPoint_Draw();
      }
      if (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_FSP) != 0) {
        FspTAmt_Draw();
        FspLvl_Draw();
      }
       */
    }
  }

  /// 顧客データ表示
  ///  関連tprxソース: rcmbrkymbr.c - rcmbrDispTextSet
  static Future<void> rcmbrDispTextSet() async {
    if (RcFncChk.rcCheckScanCheck()) {
      return;
    }
    if (CompileFlag.DEPARTMENT_STORE) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      /*
      if (RcFncChk.rcCheckHouseCardMode()) {
        return;
      }
       */
    }
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.ent.errStat != 0) {
      RckyClr.rcClearPopDisplay();
      await RcExt.rcClearErrStat("rcmbrDispTextSet");
    }

    /* 会員販売 */
    await RcItmDsp.rcDspClrmkLCD();
    if ((await RcFncChk.rcCheckStlMode()) &&
        (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
      RcItmDsp.rcItemScreen();
    }

    /* ポイント セット */
    await RcMbrPttlSet.rcmbrPTtlSet();

    /* 登録画面表示 */
    if (await RcFncChk.rcCheckItmMode() || RcFncChk.rcCheckMemberCardMode()) {
      // 特定DS2仕様向け 会員番号入力モードの場合も表示する
      if (CompileFlag.CUSTREALSVR &&
          (RcSysChk.rcChkCustrealsvrSystem() ||
              (await RcSysChk.rcChkCustrealNecSystem(0)))) {
        if ((!RcFncChk.rcChkTenOn() &&
            !RcItmChk.rcCheckKyDsc() &&
            !RcItmChk.rcCheckKyPm() &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_VOID.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_REF.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PRC.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PCHG.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) ||
            (!Rcmbrrealsvr.custRealMbrDspChk())) {
          await RcItmDsp.rcMbrDisplay();
        }
      }
      else {
        await RcItmDsp.rcMbrDisplay();  /* 顧客名 & ポイント表示(LCD) */
      }
      rcmbrDispFIP(await RcSysChk.rcKySelf());  /* ポイント(FIP) */
      if (FbInit.subinitMainSingleSpecialChk()) {
        dispTextSet(RegsDef.dualSubttl);
      }
      if (CompileFlag.CUSTREALSVR && RcSysChk.rcChkCustrealsvrSystem()) {
        if ((!RcFncChk.rcChkTenOn() &&
            !RcItmChk.rcCheckKyDsc() &&
            !RcItmChk.rcCheckKyPm() &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_VOID.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_REF.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PRC.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PCHG.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) ||
            (!Rcmbrrealsvr.custRealMbrDspChk())) {
          await RcItmDsp.dualTSingleCshrDspClr();
        }
      }
      else {
        await RcItmDsp.dualTSingleCshrDspClr();
      }
      if (CompileFlag.CUSTREALSVR &&
          (RcSysChk.rcChkCustrealsvrSystem() ||
              (await RcSysChk.rcChkCustrealNecSystem(0)))) {
        if ((!RcFncChk.rcChkTenOn() &&
            !RcItmChk.rcCheckKyDsc() &&
            !RcItmChk.rcCheckKyPm() &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_VOID.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_REF.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PRC.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PCHG.keyId]) &&
            !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) ||
            (!Rcmbrrealsvr.custRealMbrDspChk())) {
          RcItmDsp.dualTSingleCshrTendChgClr();
        }
      }
      else {
        RcItmDsp.dualTSingleCshrTendChgClr();
      }
      return;
    }

    if (await RcFncChk.rcCheckStlMode()) {
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.KY_SINGLE:
          if (FbInit.subinitMainSingleSpecialChk()) {
            dispTextSet(RegsDef.dualSubttl);
          }
          if (CompileFlag.CUSTREALSVR &&
              (RcSysChk.rcChkCustrealsvrSystem() ||
                  (await RcSysChk.rcChkCustrealNecSystem(0)))) {
            if ((!RcFncChk.rcChkTenOn() &&
                !RcItmChk.rcCheckKyDsc() &&
                !RcItmChk.rcCheckKyPm() &&
                !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_VOID.keyId]) &&
                !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_REF.keyId]) &&
                !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PRC.keyId]) &&
                !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PCHG.keyId]) &&
                !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) ||
                !RcMbrRealsvr.custRealMbrDspChk()) {
              await RcItmDsp.dualTSingleCshrDspClr();
              RcItmDsp.dualTSingleCshrTendChgClr();
            }
          }
          else {
            await RcItmDsp.dualTSingleCshrDspClr();
            RcItmDsp.dualTSingleCshrTendChgClr();
          }
          break;
        case RcRegs.DESKTOPTYPE :
        case RcRegs.KY_CHECKER  :
        case RcRegs.KY_DUALCSHR :
          dispTextSet(RegsDef.subttl);
          break;
      }
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        if (RcFncChk.rcSGCheckMntMode()) {
          await RcItmDsp.rcMbrDisplay();  /* 顧客名 & ポイント表示(LCD) */
        }
      }
    }
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 小計画面のラベルを更新する
  ///  関連tprxソース: rcmbrkymbr.c - rcmbr_DispTextSet
  static void dispTextSet(SubttlInfo pSubttl) {}

  /// 丸正総本店様対応：割戻しチケット印字を会員呼出時に行う設定かチェックする
  /// 戻り値: true=設定が有効  false=設定が無効
  ///  関連tprxソース: rcmbrkymbr.c - rcmbr_Chk_Marusyo_System
  static bool rcmbrChkMarusyoSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    // 会員登録時割戻しチケット印字が無効時のみ
    if (cBuf.dbTrm.printWmticket == 0) {
      return false;
    }
    // 即時割戻の今回本日ポイント扱区分無効設定時に動作させる。
    if (cBuf.dbTrm.nwRvtPointTyp == 1) {
      return false;
    }
    // 会員登録済みかチェック
    if (RcMbrCom.rcmbrChkCust()) {
      return false;
    }
    return true;
  }

  ///  関連tprxソース: rcmbrkymbr.c - secondcardcheck
  static bool secondCardCheck() {
    bool staffPdscMbr;
    bool rcPdscMbr;

    if (RcSysChk.rcChkMbrRCPdscSystem()) {
    AcMem cMem = SystemFunc.readAcMem();
      if (ReptEjConf.rcCheckRegistration()) {
      RegsMem mem = SystemFunc.readRegsMem();
        if (mem.tTtllog.t100700Sts.mbrTyp < 5) {
          staffPdscMbr = RcMbrCom.rcChkMemberStaffpdsc(cMem.working.janInf.code);
          rcPdscMbr = RcMbrCom.rcChkMemberRCpdsc(cMem.working.janInf.code);
          if ( (((mem.tTtllog.t100700Sts.mbrTyp == 1) ||
                (mem.tTtllog.t100700Sts.mbrTyp == 2)) &&
              ((staffPdscMbr != true) && (rcPdscMbr != true)))
              || ((mem.tTtllog.t100700Sts.mbrTyp == 4) &&
                  ((staffPdscMbr == true) || (rcPdscMbr == true))) ) {
            return true;
          }
        }
      }
    }
    return false;
  }

  ///  関連tprxソース: rcmbrkymbr.c - rcChk_DispChk
  static Future<int> rcChkDispChk() async {
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if ((await RcSysChk.rcSGChkSelfGateSystem()) && (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {
      if (tsBuf.custreal2.stat == 0) {
        return 0;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 1;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stat_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 1;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty &&
          (tsBuf.custreal2.data.uid.rec.card_dupli_flg == 2)) {
        return 6;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 7;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 7;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty &&
          (tsBuf.custreal2.data.uid.rec.card_dupli_flg == 2)) {
        return 6;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 4;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 4;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stat_flg == 1) ||
          (tsBuf.custreal2.data.uid.rec.card_stat_flg == 2) ||
          (tsBuf.custreal2.data.uid.rec.card_dupli_flg == 2)) {
        if (tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
          return 1;
        }
      }
      else if (tsBuf.custreal2.data.uid.rec.card_stat_flg == 1) {
        return 1;
      }
      else if (tsBuf.custreal2.data.uid.rec.card_stat_flg == 2) {
        return 1;
      }
      else if (tsBuf.custreal2.data.uid.rec.card_dupli_flg == 2) {
        return 1;
      }
      else {
        return 0;
      }
    }
    else {
      if (tsBuf.custreal2.stat == 0) {
        return 0;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 2;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 1;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty &&
          (tsBuf.custreal2.data.uid.rec.card_dupli_flg == 2)) {
        return 9;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 8;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 7;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty &&
          (tsBuf.custreal2.data.uid.rec.card_dupli_flg == 2)) {
        return 6;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 5;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stop_flg != 0) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 4;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_dupli_flg == 1) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty &&
          tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
        return 0;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_dupli_flg == 1) &&
          tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty) {
        return 3;
      }
      else if ((tsBuf.custreal2.data.uid.rec.card_stat_flg == 1) ||
          (tsBuf.custreal2.data.uid.rec.card_stat_flg == 2) ||
          (tsBuf.custreal2.data.uid.rec.card_dupli_flg == 2)) {
        if (tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty) {
          if (await RckyDisBurse.rcCheckKYDisBurse()) {
            return 3;
          }
          else {
            mem.tTtllog.t100900.vmcStkhesoacv = 2;
            return 2;
          }
        }
      }
      else if (tsBuf.custreal2.data.uid.rec.card_stat_flg == 1) {
        return 1;
      }
      else if (tsBuf.custreal2.data.uid.rec.card_stat_flg == 2) {
        return 1;
      }
      else if (tsBuf.custreal2.data.uid.rec.card_dupli_flg == 2) {
        return 1;
      }
      else if (tsBuf.custreal2.data.uid.rec.now_rank_name.isNotEmpty &&
          !await RckyDisBurse.rcCheckKYDisBurse()) {
        return 3;
      }
      else {
        return 0;
      }
    }
    return 0;
  }
  
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_End
  static Future<void> rcMbrEnd() async {
    await RcSet.rcClearKyItem();
  }

  ///**********************************************************************
  ///	ファンファーレとメッセージ
  ///**********************************************************************
  /// ターゲットメッセージを表示するため, 従来の即時割戻メッセージを後にするようにした関数
  /// 引数: MBRDLG_CHK_ORDERの値をセット
  /// - MBRDLG_ORDER_BEFORE_WAIT:   1番初めの状態  会員と同時処理しなければいけない別タスク（プリカ等）の処理を待ちます
  /// - MBRDLG_ORDER_CPNMSG:	クーポンメッセージ表示
  /// - MBRDLG_ORDER_CUST_BMP:	クーポンメッセージ表示後 声かけ画面表示
  /// - MBRDLG_ORDER_CMPLNTMSG:	声かけ画面表示後 ターゲットメッセージ表示
  /// - MBRDLG_ORDER_BUYHIST:	クレーム／注意メッセージ表示後 購買履歴画面表示(ゴダイ様特定会員)
  /// - MBRDLG_ORDER_TGTMSG:	購買履歴画面表示後 ターゲットメッセージ表示
  /// - MBRDLG_ORDER_LOYLIMITOVER:	ロイヤリティ制限個数超過登録メッセージ表示
  /// - MBRDLG_ORDER_LOYREGOVER:	ロイヤリティオーバーエラーメッセージ表示
  /// - MBRDLG_ORDER_FANFARE:	ファンファーレ表示
  ///  関連tprxソース: rcmbrkymbr.c - rcmbr_Proc_DlgAndSound
  static Future<void> rcmbrProcDlgAndSound(MbrDlgChkOrder nowOrder) async {
    MbrDlgChkOrder order; // 表示順
    int ret;
    RegsMem mem = SystemFunc.readRegsMem();
    
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    order = nowOrder;

    if ((await CmCksys.cmDs2GodaiSystem() != 0)
        && ((Dummy.rcMemberGetProcStep() == 1) ||
            (Dummy.rcMemberGetProcStep() == 3) ||
            (Dummy.rcMemberRtnFuncCode() == FuncKey.KY_BUY_HIST.keyId))) {
      return;
    }

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_BEFORE_WAIT) {
      ret = Dummy.rcMbrChkWaitMsg();
      if (ret == 0) {
        order = MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG;
      }
      else {
        Dummy.rcMbrProcWaitMsg(ret);
      }
    }

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG) {
      ret = await Rcmbrkymbr.rcMbrChkCpnMsg();
      if (ret == 0) {
        order = MbrDlgChkOrder.MBRDLG_ORDER_CUST_BMP;
      }
      else {
        Dummy.rcMbrProcCpnMsg(ret);
      }
    }

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_CUST_BMP) {
      ret = await RcMbrCustDsp.rcMbrChkCustBmp()? 1:0;
      if (ret == 0) {
        order = MbrDlgChkOrder.MBRDLG_ORDER_CMPLNTMSG;
      }
      else {
        Dummy.rcmbrCustbmpDraw(0);
      }
    }

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_CMPLNTMSG) {
      ret = await rcMbrChkCmplntMsg()? 1:0;
      if (ret == 0) {
        order = MbrDlgChkOrder.MBRDLG_ORDER_BUYHIST;
      }
      else {
        Dummy.rcMbrProcCmplntMsg();
      }
    }

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_BUYHIST) {
      ret = Dummy.rcMbrChkBuyHist();
      if (ret == 0) {
        order = MbrDlgChkOrder.MBRDLG_ORDER_TGTMSG;
      }
      else {
        if (Dummy.rcCheckMemberCardMode()) {
          Dummy.rcMcardBuyHistFlgSet(3);
        }
        else {
          Dummy.rckyBuyHistProc(3);
        }
      }
    }

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_TGTMSG) {
      ret = rcMbrChkTargetMsg()? 1:0;
      if (ret == 0) {
        order = MbrDlgChkOrder.MBRDLG_ORDER_LOYLIMITOVER;
      }
      else {
        Dummy.rcMbrProcTargetMsg();
      }
    }

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_LOYLIMITOVER) {
      ret = (await rcMbrChkLoyLimitOverMsg()) ? 1:0;
      if (ret == 0) {
        order = MbrDlgChkOrder.MBRDLG_ORDER_LOYREGOVER;
      }
      else {
        await RcKyPlu.rcPluLoyLimitOverDlg(1);
      }
    }

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_LOYREGOVER) {
      ret = (await rcMbrChkLoyRegOverMsg()) ? 1:0;
      if (ret == 0) {
        order = MbrDlgChkOrder.MBRDLG_ORDER_FANFARE;
      }
      else {
        await RcKyPlu.rcPluLoyRegOverDlg(1);
      }
    }

    CommonController commonCtrl = Get.find();

    if (order == MbrDlgChkOrder.MBRDLG_ORDER_FANFARE) {
      if (tmpReadData.errCd > 0) {
        if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
          await RcExt.rcErr("Rcmbrkymbr.rcmbrProcDlgAndSound()", tmpReadData.errCd);
        } else { //登録画面から実行
          await RcExt.rcErrToRegister("Rcmbrkymbr.rcmbrProcDlgAndSound()", tmpReadData.errCd);
        }
        await setMbrReadError(0);
      }
      else if (RcSysChk.rcChkCustrealFrestaSystem()
          && (mem.tTtllog.t100700.realCustsrvFlg == 1)) {
        RcMbrrealsvrFresta.offlineMessage();
      }
      else if ((cBuf.dbTrm.fanfareNoEfect == 0)
          && !(await RcSysChk.rcQCChkQcashierSystem() &&
              (cBuf.dbTrm.acoopPrintFunc1 == 2))) {
        rcmbrFanfare();
      }
      else if ((cBuf.dbTrm.fanfareNoEfect != 0)
          && await RcSysChk.rcQCChkQcashierSystem()
          && (cBuf.dbTrm.acoopPrintFunc1 != 2)
          && (await CmCksys.cmIchiyamaMartSystem() != 0)) {
        rcmbrFanfare();
      }
    }
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（サウンド関連）
  /// ファンファーレ音を鳴らす
  ///  関連tprxソース: rcmbrkymbr.c - rcmbr_fanfare
  static void rcmbrFanfare() {}

  ///  関連tprxソース: rcmbrkymbr.c - GetMbrInputErrNo
  static Future<int> getMbrInputErrNo() async {
    int no;
    RegsMem mem = SystemFunc.readRegsMem();

    if (RcSysChk.rcChkRalseCardSystem()) {
      if (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSSTAFF, mem)) {
        no = DlgConfirmMsgKind.MSG_STAFFINPUT.dlgId;
      }
      else if (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSOTHER, mem)) {
        no = DlgConfirmMsgKind.MSG_OTHCARDINPUT.dlgId;
      }
      else {
        no = DlgConfirmMsgKind.MSG_MBRINPUT.dlgId;
      }
    }
    else {
      if ((RcSysChk.rcsyschkYunaitoHdSystem() != 0)
          && (mem.tTtllog.t100700.mbrInput == MbrInputType.barReceivInput.index)) {
        no = DlgConfirmMsgKind.MSG_RECEIVINPUT.dlgId;
      }
      else {
        no = DlgConfirmMsgKind.MSG_MBRINPUT.dlgId;
      }
    }

    return no;
  }

  /// 丸正総本店様対応、rc_QR_System_Marusyou_dtip_to_Txtを呼ぶ
  ///  関連tprxソース: rcmbrkymbr.c - rcmbr_Marusyo_QR_to_Txt
  static void rcmbrMarusyoQRToTxt() {
    if (timeout3 != -1) {
      Fb2Gtk.gtkTimeoutRemove(timeout3);
      timeout3 = -1;
    }
    RcqrCom.rcQRSystemMarusyoDtipToTxt();
  }

  ///  関連tprxソース: rcmbrkymbr.c - rcNoRankMbr_Point
  static void rcNoRankMbrPoint() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    if ((cBuf.dbTrm.vmcOutRankPnt != 0)
        && (mem.tTtllog.t100700.fspLvl == 0)
        && (cBuf.dbTrm.memAnyprcStet != 0)) {
      mem.tTtllog.t100001Sts.msRbtMbr = 1;
    }
  }

  /// アヤハディオ様仕様における会員別スケジュール仕様のデータセット
  ///  関連tprxソース: rcmbrkymbr.c - rcMbr_Ayaha_ItmSch_data
  static Future<void> rcMbrAyahaItmSchData() async {
    if (!RcMbrCom.rcChkAyahaItmSch()) {
      return;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    PPromschMst	brgnsch;
    PBrgnitemMst brgnitem;
    CPluitemMst pluitem;
    for (var p = 0; p < mem.tTtllog.t100001Sts.itemlogCnt; p++) {
      brgnsch = PPromschMst();
      brgnitem = PBrgnitemMst();
      pluitem = CPluitemMst();
      RcMbrFlrd.rcmbrReadAyahaItmSch(mem.tItemLog[p].t10000.pluCd1_2
                                , mem.tItemLog[p].t10003.uPrc
                                , brgnsch, brgnitem, pluitem);
      if (brgnsch.prom_cd != 0) {
        if ((mem.tItemLog[p].t10100.brgnCd == 0)
            || (mem.tItemLog[p].t10003.ubrgnPrc > brgnitem.brgn_prc)) {
          mem.tItemLog[p].t10100.brgnCd = brgnsch.prom_cd!;
          if ((brgnsch.plan_cd != null) && brgnsch.plan_cd!.isNotEmpty) {
            mem.tItemLog[p].t10100.brgnPlanCd = brgnsch.plan_cd!;
          }
          mem.tItemLog[p].t10100.brgnTyp = brgnsch.sch_typ;
          if ((brgnsch.sch_typ == 5) || (brgnsch.sch_typ == 6)) {
            mem.tItemLog[p].t10100Sts.ubrgnDsc = brgnsch.dsc_val;
          }
          else {
            mem.tItemLog[p].t10100Sts.ubrgnDsc = 0;
          }
          mem.tItemLog[p].t10003.ubrgnPrc = brgnitem.brgn_prc;
          
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, 
              'Set BrgnSch plu_cd=${mem.tItemLog[p].t10000.pluCd1_2} plan_cd=${mem.tItemLog[p].t10100.brgnPlanCd}');
        }
      }
    }
  }

  /// 会員呼出_後処理
  ///  関連tprxソース: rcmbrkymbr.c - rcAfter_Mbr_Proc
  static Future<void> rcAfterMbrProc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xtRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Rcmbrkymbr.rcAfterMbrProc(): rxMemRead error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xtRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (precaOnceMbrAfterProcType != 0) {	/* CoGCaIC顧客一度読みの後処理へ */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcAfter_Preca_Once_Mbr: Rcmbrkymbr.rcAfterMbrProc() Goto");
      if (await RcSysChk.rcChkAjsEmoneySystem()) {
        rcmbrDispTextSet();
      }
      cogcaIccdMbrProc();
    }
    RcStlCal.rcstlcalLoyUnvldChkOn(1);
    StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
    RcStlCal.rcstlcalLoyUnvldChkOff();

    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        RcSgCom.rcSGManageLogSend(RcSgDsp.regLog);
        RcAssistMnt.rcAssistSend(20137);
        if (!RcFncChk.rcSGCheckMntMode()) {
          RcSet.rcSetStTFlag(1);
        }
        if (RcSgCom.rcSGMbrAutoPerDscFncCode() != 0) {
          if (((RcSgDsp.selfMem.auto_pdsc_flg == 0) ||
              (RcSgDsp.selfMem.auto_pdsc_flg == 1))
              && (mem.tTtllog.calcData.stldscBaseAmt >=
                  cBuf.dbTrm.selfAutoPdscLmt)) {
            await RcSgCom.rcSGAutoPerDscProc();
          }
          else if ((RcSgDsp.selfMem.auto_pdsc_flg == 1)
              && (mem.tTtllog.calcData.stldscBaseAmt <
                  cBuf.dbTrm.selfAutoPdscLmt)) {
            RcSgDsp.selfMem.auto_pdsc_flg = -1;
          }
        }
        if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
          if ( ( !( (await RcSysChk.rcChkRwcSystem()) &&
                    (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index) &&
                    ( ((cBuf.dbTrm.rvtBeep == 0) && (mem.tTtllog.t100701.dtipTtlsrv > 0)) ||
                      (await RcSysChk.rcSGCheckMcp200System()) ) ) )
              && !( (await RcSysChk.rcChkDPointSelfSystem()) &&
                    (RcSysChk.rcChkDPointDualMemberType() == 1) &&
                    ( RcFncChk.rcSGCheckMbrScnMode() &&
                      (RcSgDsp.mbrScnDsp.mbrcardReadtyp != MbrCardReadType.DPOINT_READ.index) ) )
              && !( (await RcSysChk.rcChkRPointSelfSystem()) &&
                    (RcSysChk.rcChkRPointDualMemberType() == 1) &&
                    ( RcFncChk.rcSGCheckMbrScnMode() &&
                      (RcSgDsp.mbrScnDsp.mbrcardReadtyp != MbrCardReadType.RPOINT_READ.index) ) )
              && !( (await RcSysChk.rcChkRPointSelfSystem()) &&
                    ( RcFncChk.rcSGCheckMbrScnMode() &&
                      (RcSgDsp.mbrScnDsp.mbrcardReadtyp != MbrCardReadType.TOMO_READ.index) ) ) ) {
            if ((CmCksys.cmWizAbjSystem() == 0)
                && !((await RcFncChk.rcHappySelfChkTb1System()) &&
                     (mem.tTtllog.t100700.mbrInput== 12))
                && (RckyMprc.rcMprcCardForgotBtnFlagCheck() == 0)) {
              // TODO:00002 佐野 サウンド関連（再生ファイルの確認が必要）
              //RcSound.play(sndFile: SoundDef.***);  //SND_1020="snd_1020.wav"「会員カードを読みました」
            }
          }
          else if ((await RcSysChk.rcChkRPointSelfSystem())
              && (await CmCksys.cmQCCustSettingSystem() != 0)
              && (RcFncChk.rcSGCheckMbrScnMode() &&
                  (RcSgDsp.mbrScnDsp.mbrcardReadtyp != MbrCardReadType.RPOINT_READ.index)) ) {
            // TODO:00002 佐野 サウンド関連（再生ファイルの確認が必要）
            //RcSound.play(sndFile: SoundDef.***);  //SND_1020="snd_1020.wav"「会員カードを読みました」
          }
        }
        else if (RcSysChk.rcSGChkAmpmSystem()) {
          RcSgCom.quickIniPageOld = 15;
          String sound = "";
          // RcSgCom.quickSelfIni.data[page]の値は、rcSG_Quick_Ini_Read()で設定される
          if (RcFncChk.rcSGCheckMbrScnMode()) {
            if (cBuf.dbTrm.selfPresetDisp == 0) {
              sound = "snd_${"${RcSgCom.quickSelfIni.data[RcSgCom.quickIniPageOld].sound2}".padLeft(4, "0")}.wav";
            }
            else {
              sound = "snd_${"${RcSgCom.quickSelfIni.data[RcSgCom.quickIniPageOld].sound2 + 2}".padLeft(4, "0")}.wav";
            }
          }
          else {
            sound = "snd_${"${RcSgCom.quickSelfIni.data[RcSgCom.quickIniPageOld].sound3}".padLeft(4, "0")}.wav";
          }
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "Rcmbrkymbr.rcAfterMbrProc(): rcAfter_Mbr_Proc Sound[$sound]");
          // TODO:00002 佐野 サウンド関連（再生ファイルの確認が必要）
          //RcSound.play(sndFile: SoundDef.***);  //SND_1020="snd_***.wav"
        }
        else {
          if (!((await RcSysChk.rcChkRwcSystem()) &&
              (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index) &&
              (cBuf.dbTrm.rvtBeep == 0) &&
              (mem.tTtllog.t100701.dtipTtlsrv > 0)) ) {
            if (!((await RcSysChk.rcChkFelicaSystem()) &&
                (cBuf.dbTrm.selfSlctKeyCd == 4) &&
                (cBuf.dbTrm.selfChgTimingFelicaTouch != 0)) ) {
              // TODO:00002 佐野 サウンド関連（再生ファイルの確認が必要）
              //RcSound.play(sndFile: SoundDef.***);  //SND_0058="snd_0058.wav"「会員カードを読みました」
            }
          }
        }
        if (RcFncChk.rcSGCheckMbrScnMode()) {
          RcsgDev.rcSGSndGtkTimerRemove();
          if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
            RcNewSgFnc.rcNewSGDspGtkTimerRemove();
            if ((await RcSysChk.rcChkDPointSelfSystem())
                && (RcSysChk.rcChkDPointDualMemberType() == 1)
                && (RcFncChk.rcSGCheckMbrScnMode() &&
                    (RcSgDsp.mbrScnDsp.mbrcardReadtyp != MbrCardReadType.DPOINT_READ.index))) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "Rcmbrkymbr.rcAfterMbrProc(): [SELF-GATE] dPoint Card Check");
              if (RcSgDsp.mbrChkDsp.mbrchkDisp == 1) {
                RcSgDsp.rcSGMemberCheckWindowDestroy();
              }
              else if (RcSgDsp.dPtsMbrChkDsp.mbrchkDisp == 1) {
                RcSgDsp.rcSGdPointMemberCheckWindowDestroy();
              }
              else if (RcSgDsp.mbrScnDsp.mbrscnDisp == 1) {
                if (await RcSysChk.rcChkVFHDSelfSystem())	 {
                  RcUsbCam.rcQCMovieStop();	/* 会員カード読取画面で動画再生しているので動画ストップ処理実行 */
                }
                RcSgDsp.rcSGMemberScanWindowDestroy();
              }
              RcSgDsp.mbrChkDsp.mbrchkDisp = 0;
              RcSgDsp.dPtsMbrChkDsp.mbrchkDisp = 0;
              RcSgDsp.mbrScnDsp.mbrscnDisp = 0;
              if (cBuf.dbTrm.selfNocustUseFlg != 0) {
                //会員以外のセルフレジの使用のフラグをチェック
                RcSgDsp.mbrScnDsp.mbrcardReadtyp = MbrCardReadType.DPOINT_READ.index;
                RcSgDsp.rcSGDispMemberScanWindow();
                tsBuf.chk.selfmove_flg = 0;
                if (RcSgDsp.selfMem.select_type == 2) {
                  tsBuf.chk.selfctrl_flg = 0;
                }
                else {
                  await RcNewSgFnc.rcSGSetSelfCtrlFlag();
                }
                RcNewSgFnc.rcNewSGComTimerGifDsp();
                RcObr.rcScanEnable();
              }
              else {
                RcSgDsp.mbrChkDsp.mbrcardReadtyp = MbrCardReadType.DPOINT_READ.index;
                RcSgDsp.rcSGDispMemberCheckWindow();
              }
            }
            else if ((await RcSysChk.rcChkRPointSelfSystem())
                && (RcSysChk.rcChkRPointDualMemberType() == 1)
                && (RcFncChk.rcSGCheckMbrScnMode() &&
                    (RcSgDsp.mbrScnDsp.mbrcardReadtyp != MbrCardReadType.RPOINT_READ.index))) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "Rcmbrkymbr.rcAfterMbrProc(): RPoint Card Check");
              if (RcSgDsp.mbrChkDsp.mbrchkDisp == 1) {
                RcSgDsp.rcSGMemberCheckWindowDestroy();
              }
              else if (RcSgDsp.rPtsMbrChkDsp.mbrchkDisp == 1) {
                RcSgDsp.rcSGRPointMemberCheckWindowDestroy();
              }
              else if (RcSgDsp.mbrScnDsp.mbrscnDisp == 1) {
                if (await RcSysChk.rcChkVFHDSelfSystem()) {
                  RcUsbCam.rcQCMovieStop();	/* 会員カード読取画面で動画再生しているので動画ストップ処理実行 */
                }
                RcSgDsp.rcSGMemberScanWindowDestroy();
              }
              RcSgDsp.mbrChkDsp.mbrchkDisp = 0;
              RcSgDsp.rPtsMbrChkDsp.mbrchkDisp = 0;
              RcSgDsp.mbrScnDsp.mbrscnDisp = 0;
              if (cBuf.dbTrm.selfNocustUseFlg != 0) {
                //会員以外のセルフレジの使用のフラグをチェック
                RcSgDsp.mbrScnDsp.mbrcardReadtyp = MbrCardReadType.RPOINT_READ.index;
                RcSgDsp.rcSGDispMemberScanWindow();
                tsBuf.chk.selfmove_flg = 0;
                if (RcSgDsp.selfMem.select_type == 2) {
                  tsBuf.chk.selfctrl_flg = 0;
                }
                else {
                  await RcNewSgFnc.rcSGSetSelfCtrlFlag();
                }
                RcNewSgFnc.rcNewSGComTimerGifDsp();
                RcObr.rcScanEnable();
              }
              else {
                RcSgDsp.mbrChkDsp.mbrcardReadtyp = MbrCardReadType.RPOINT_READ.index;
                RcSgDsp.rcSGDispMemberCheckWindow();
              }
            }
            else if ((await RcSysChk.rcChkTomoSelfSystem())
                && (RcFncChk.rcSGCheckMbrScnMode() &&
                    (RcSgDsp.mbrScnDsp.mbrcardReadtyp != MbrCardReadType.TOMO_READ.index))) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "Rcmbrkymbr.rcAfterMbrProc(): [SELF-GATE] TOMO Card Check");
              if (RcSgDsp.mbrChkDsp.mbrchkDisp == 1) {
                RcSgDsp.rcSGMemberCheckWindowDestroy();
              }
              else if (RcSgDsp.mbrScnDsp.mbrscnDisp == 1) {
                if (await RcSysChk.rcChkVFHDSelfSystem())	{
                  RcUsbCam.rcQCMovieStop();	/* 会員カード読取画面で動画再生しているので動画ストップ処理実行 */
                }
                RcSgDsp.rcSGMemberScanWindowDestroy();
              }
              RcSgDsp.mbrChkDsp.mbrchkDisp = 0;
              RcSgDsp.tomoMbrChkDsp.mbrchkDisp = 0;
              RcSgDsp.mbrScnDsp.mbrscnDisp = 0;
              if (cBuf.dbTrm.selfNocustUseFlg != 0) {
                //会員以外のセルフレジの使用のフラグをチェック
                RcSgDsp.mbrScnDsp.mbrcardReadtyp = MbrCardReadType.TOMO_READ.index;
                RcSgDsp.rcSGDispMemberScanWindow();
                tsBuf.chk.selfmove_flg = 0;
                if (RcSgDsp.selfMem.select_type == 2) {
                  tsBuf.chk.selfctrl_flg = 0;
                }
                else {
                  await RcNewSgFnc.rcSGSetSelfCtrlFlag();
                }
                RcNewSgFnc.rcNewSGComTimerGifDsp();
                RcObr.rcScanEnable();
              }
              else {
                RcSgDsp.mbrChkDsp.mbrcardReadtyp = MbrCardReadType.TOMO_READ.index;
                RcSgDsp.rcSGDispMemberCheckWindow();
              }
            }
            else {
              if (RcSysChk.rcChkCustrealFrestaSystem() &&
                  RcFncChk.rcCheckMasrSystem() &&
                  (RcSgDsp.mbrScnDsp.mbrscnDisp == 1)) {
                // 自走式カードリーダをストップ
                await RcMasr.rcMasrChkEnd();
                RcqrCom.rcQCLedCom(QcLedNo.QC_LED_CRDT.index,
                    RcQcDsp.QC_LED_MASR_RED_COLOR.index,
                    QcLedDisp.QC_LED_DISP_OFF.index, 0, 0, 0);
              }
              RcNewSgFnc.newExpDsp.dspCnt = 6;
              if (RcSgDsp.selfMem.select_type != 2) {
                tsBuf.chk.selfmove_flg = 0;
                await RcNewSgFnc.rcSGSetSelfCtrlFlag();
                // TODO:10122 グラフィクス処理（gtk_*）
                //gtk_widget_destroy(RcSgDsp.mbrScnDsp.stf_btn);
                //gtk_widget_destroy(RcSgDsp.mbrScnDsp.mnt_btn);
                if ((cBuf.dbTrm.dispMbrcardExist != 0)
                    || (cBuf.dbTrm.selfNocustUseFlg == 0)) {
                  // TODO:10122 グラフィクス処理（gtk_*）
                  //gtk_widget_destroy(RcSgDsp.mbrScnDsp.nocard_btn);
                }
                RcGtkTimer.rcGtkTimerAdd(2000, RcNewSgFnc.rcNewSGExplainTimerProc);
              }
              else {
                RcNewSgFnc.rcNewSGExplainTimerProc();
              }
            }
          }
          else {
            RcGtkTimer.rcGtkTimerAdd(4000, RcSgDsp.rcSGBarSncSoundProc);
            RcSgDsp.rcSGDispInstructionWindow();  /* Instruction Display */
            RcSgDsp.mbrScnDsp.mbrscnDisp = 0;
            RcSgDsp.rcSGMemberScanWindowDestroy();
          }
          await rcmbrProcDlgAndSound(MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG);
          return;
        }
        else if (RcFncChk.rcSGCheckMbrScnMode2()) {
          if (RcSgDsp.mbrScnDsp2.mbrscnDisp == 1) {
            RcSgDsp.rcSGBackBtnDestroy();
            // TODO:10122 グラフィクス処理（gtk_*）
            //gtk_widget_destroy(RcSgDsp.mbrScnDsp2.window);
            RcSgDsp.mbrScnDsp2.mbrscnDisp = 0;
          }
          await RcSound.stop();
          RcsgDev.rcSGSndGtkTimerRemove();
          RcNewSgFnc.rcNewSGDspGtkTimerRemove();
          await rcmbrProcDlgAndSound(MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG);
          if (RcMbrCmSrv.rcSPCardMbrChk() == 0) {
            await RcExt.rxChkModeReset("rcAfterMbrProc");
          }
          await RcSet.rcSGEndScrMode();
          RcSgDsp.rcSGDispWindowType();
          return;
        }
        else if (RcFncChk.rcSGCheckMbrInputMode()) {
          // TODO:10122 グラフィクス処理（gtk_*）
          /*
          if (RcSgDsp.mbrScnDsp.window != NULL) {
            await RcSound.stop();
            RcsgDev.rcSGSndGtkTimerRemove();
            RcNewSgFnc.rcNewSGDspGtkTimerRemove();
            await rcmbrProcDlgAndSound(MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG);
            if (RcMbrCmSrv.rcSPCardMbrChk() == 0) {
              await RcExt.rxChkModeReset("rcAfterMbrProc");
            }
            await RcSet.rcSGEndScrMode();
            RcSgDsp.rcSGDispWindowType();
          }
           */
          return;
        }
        else if (RcFncChk.rcSGCheckEndModeChk()) {
          RcStlLcd.rcStlLcdMbrInfo(RegsDef.subttl);
        }
        else if (RcFncChk.rcSGCheckSlctMode()) {
          RcsgDev.rcSGSndGtkTimerRemove();
          RcGtkTimer.rcGtkTimerAdd(3000, RcSgDsp.rcSGSlctSoundProc);
        }
        else if (RcFncChk.rcSGCheckCrdtReadMode()) {
          RcsgDev.rcSGSndGtkTimerRemove();
          RcGtkTimer.rcGtkTimerAdd(3000, RcSgCom.rcSGReadCardSoundProc);
        }
        if (RcFncChk.rcSGCheckPreMode()) {
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_signal_disconnect(GTK_OBJECT(regs_page_note), regs_page_connect_id);
          RcSgDsp.rcSGListWindowDestroy();
          RcSgDsp.rcSGPresetWindowDestroy();
          RcSgDsp.selfMem.preset_dsp = 0;
          if (RcSgDsp.mntDsp.mntDsp == 1) {
            RcSet.rcSGMntScrMode();
          }
          else {
            if (RcSgDsp.selfMem.exp_disp == 1) {
              RcStlDsp.rcStlFunctionDisp();
              // TODO:10122 グラフィクス処理（gtk_*）
              /*
              if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
                gtk_widget_destroy(NewExpDsp.window);
              } else {
                if (InstDsp.window != NULL) {
                  gtk_widget_destroy(InstDsp.window);
                  InstDsp.window = NULL;
                }
              }
               */
              RcSgDsp.selfMem.exp_disp = 0;
              await rcmbrProcDlgAndSound(MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG);
              return;
            }
            else {
              await RcStlLcd.rcStlLcdScrMode();
            }
          }
        }
        if (RcFncChk.rcSGCheckInstMode() || RcFncChk.rcNewSGCheckExplainMode()) {
          RcStlDsp.rcStlFunctionDisp();
          // TODO:10122 グラフィクス処理（gtk_*）
          /*
          if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
            gtk_widget_destroy(NewExpDsp.window);
          } else {
            if (InstDsp.window != NULL) {
              gtk_widget_destroy(InstDsp.window);
              InstDsp.window = NULL;
            }
          }
           */
          RcSgDsp.selfMem.exp_disp = 0;
          await rcmbrProcDlgAndSound(MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG);
          if (RcSgCom.rcSGGuidancePresetDspCheck()) {
            RcSgDsp.rcSGDispListWindow();
          }
          return;
        }
        if ((await RcFncChk.rcCheckStlMode()) || RcFncChk.rcSGCheckMntMode()) {
          rcmbrDispTextSet();
          if (await RcFncChk.rcCheckStlMode()) {
            if (await RcSysChk.rcChkVFHDSelfSystem()) {
              RcsgVfhdDsp.rcSGVFHDItemListDsp();	/* 表示内容更新 */
            }
            else {
              RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
            }
            if (RcSysChk.rcSGChkAmpmSystem()
                && (cMem.ent.errNo == 0)
                && (RxLogCalc.rxCalcStlTaxAmt(mem) <= RcSgCom.edyBalanceAmt)
                && (RcSgCom.sgCnclFlg == 0)) {
              RcSgCom.quickIniPage = 3;
              RcSgCom.rcSGIniSoundProcMain(0);
              RcSgDsp.rcSGNoActTimer();
              if ((await RcSgCom.rcSGChkEdyDirect())
                  && (cBuf.dbTrm.loasonNw7mbr != 0)) {
                RcSgDsp.rcSGStlEdyBtnTimer();
              }
            }
            if (await RcNewSgFnc.rcSGHappyItemRegDspState(1) == Typ.OK) {
              /* 登録操作無時警告：する Happyフルセルフ商品登録画面 */
              RcNewSgFnc.rcNewSGDspGtkTimerRemove();
              if (RcQcDsp.qCashierIni.noOperationSignpaulTime != 0) {
                /* ｻｲﾝﾎﾟｰﾙ点灯までの経過時間 設定あり */
                RcsgDev.rcSGSignPSignOn(RcSgDsp.GREEN_COLOR.index);
                RcGtkTimer.rcGtkTimerAdd((RcQcDsp.qCashierIni.noOperationSignpaulTime*1000), RcNewSgFnc.rcNewSGStlDspTimerProc);
              }
              else {
                RcGtkTimer.rcGtkTimerAdd(50, RcNewSgFnc.rcNewSGStlDspTimerProc);
              }
            }
          }
          else if (RcFncChk.rcSGCheckMntMode()) {
            // TODO:10122 グラフィクス処理（gtk_*）
            /*
            if (RcSgDsp.mntDsp.start_btn != NULL) {
              gtk_widget_destroy(RcSgDsp.mntDsp.start_btn);
              RcSgDsp.mntDsp.start_btn = NULL;
            }
             */
            RcSgDsp.selfMem.mbr_call = 1;
          }
        }
        await rcmbrProcDlgAndSound(MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG);
        return;
      }
    }

    int sm5ChkFlg = 0;
    int sagIcReadmbrFlg = 0;
    if ((await RcSysChk.rcQCChkQcashierSystem())
        && RcFncChk.rcCheckQCMbrNReadDspMode()
        && (await RcSysChk.rcChkShopAndGoSystem())) {
      if (await RcFncChk.rcfncchkSagSm5ItokuRpointCheck() != 0) {
        if ((await RcSysChk.rcChkCogcaSystem())
            && (RcQcDsp.qcMbrChkDsp.mbrcardReadtyp == MbrCardReadType.IC_READ.index)) {
          if (RcFncChk.rcCheckRegistration()) {
            sm5ChkFlg = 1;
          }
        }
      }
      /* 自走式カードリーダをストップする */
      if (RcFncChk.rcCheckMasrSystem()) {
        await RcMasr.rcMasrChkEnd();
      }
      /* 会員読取画面がプリカ宣言からの会員読取でCoGCa1度読みの設定が有効かチェック */
      if (await RcQcDsp.rcQCSAGChkMbrCardReadTypIcRead() != 0) {
        /* このタイミングでMEM->work_in_typeの値がプリカ宣言状態にならないので注意 */
        sagIcReadmbrFlg = Typ.ON;
      }

      // 会員リード画面の削除
      RcQcDsp.rcQCMbrReadDspDestroy();

      // ＱＲリード画面状態にする
      await RcSet.rcQCStartDspScrMode();
      RcObr.rcScanEnable();
      if (sm5ChkFlg != 1) {
        RcAssistMnt.rcAssistSend(30137);
      }
      RcSet.rcSetStTFlag(3);	// STL Timer Start

      // 音声を鳴らさない
      RcQcDsp.qcSoundOffFlg = 1;
      RcQcDsp.rcQCLangChgFunc();  //rcQC_LangChgFunc(NULL,NULL);
      if (!(await RcQcCom.rcCheckLangSlctSystem())) {
        // 上記の切替で言語が変わるため、元に戻す
        RcQcDsp.rcQCLangChgFunc();  //rcQC_LangChgFunc(NULL,NULL);
      }
      RcQcDsp.qcSoundOffFlg = 0;
      if (sm5ChkFlg == 1) {
        RcAssistMnt.rcAssistSend(30202);
      }
      else {
        RcAssistMnt.rcAssistSend(30210);
      }

      if ((await RcMbrCom.rcmbrChkStat() != 0)
          && (RcQcDsp.qCashierIni.shopAndGoMbrChkDsp == QcMbrDspStatus.QC_MBRDSP_STATUS_BEFORE_READ.index)) {
        // 会員読取後の音声再生を実行
        // NEC_EMONEY_SOUND_TAPが存在しないのでコメントアウト
        //rcSAG_MbrRead_Sound (NEC_EMONEY_SOUND_TAP, sag_ic_readmbr_flg);
        /* 以下の対応は暫定対応のためenum値がマージされた際には上記のコメントアウトされた処理に戻すこと */
        /* NEC_EMONEY_SOUND_TAPは14Verではenum値が4のためその値を引数にセット */
        RcSound.rcSAGMbrReadSound(4, sagIcReadmbrFlg);
        sagIcReadmbrFlg = Typ.OFF;
      }

      // 精算中は戻るボタンを表示しない
      if (RcFncChk.rcCheckRegistration()) {
        // TODO:10122 グラフィクス処理（gtk_*）
        /*
        // 「会員入力済み」画像を表示
        if (RcQcDsp.qcStrDsp.mbrinfo_pixmap != NULL) {
          gtk_widget_show(RcQcDsp.qcStrDsp.mbrinfo_pixmap);
        }
         */
      }
      if (await CmCksys.cmZHQSystem() != 0) {
        await rcmbrProcDlgAndSound(MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG);
      }
      return;
    }

    if ((await CmCksys.cmSpecialCouponSystem() != 0)
        && (mem.tTtllog.t100001Sts.cardForgotFlg != 0)
        && (await CmCksys.cmPalcoopCardForgotCheck() == 0)) {
      RcKyCardForget.rcPrgKyCardForgot(1);
    }

    if (RcSysChk.rcsyschkFselfMbrscan2ndScannerUse() != 0) {
      if (RcFncChk.rcCheckRegistration()
          && (RcFncChk.rcCheckMbrInput() || (RcSysChk.rcChkdPointRead() != 0))) {
        RcVfhdFself.rcVFHDFselfMbrScanStatusClear(
            QcMbrScanStatus.QC_MBRSCAN_DONE.id, 0);
        if (cMem.stat.fncCode != FuncKey.KY_STL.keyId) {
          RcKyPlu.rcPluDlgProc(PluDlgChkStep.PLUDLG_STEP_FSELF_MBRREAD_END,
              PluDlgItemType.PLUDLG_ITEM_NONE);
        }
      }
    }

    if (CompileFlag.FSP_REWRITE && CompileFlag.VISMAC) {
      if ( ( !( (await RcSysChk.rcChkFspRewriteSystem()) &&
                (mem.tTtllog.t100700.mbrInput == MbrInputType.rwCardInput.index) ) )
          && ( ! ( (await RcSysChk.rcChkVMCSystem()) &&
                (mem.tTtllog.t100700.mbrInput == MbrInputType.vismacCardInput.index) ) ) ) {
        rcmbrDispTextSet();
        if ((await RcFncChk.rcCheckStlMode()) && !RcFncChk.rcCheckSItmMode()) {
          /* 小計画面？ */
          RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
          if (!(await RcSysChk.rcChkTRCSystem() &&
              (mem.tTtllog.t100700.mbrInput == MbrInputType.rwCardInput.index))) {
            rcmbrDispFIP(await RcSysChk.rcKySelf());  /* 合計値段(FIP) */
          }
        }
        else if (RcFncChk.rcCheckSItmMode()) {
          await RcStlDsp.rcStlDspTotalizers(1); /* 小計合計表示 */
          RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
          if (!(await RcSysChk.rcChkTRCSystem() &&
              (mem.tTtllog.t100700.mbrInput == MbrInputType.rwCardInput.index))) {
            rcmbrDispFIP(await RcSysChk.rcKySelf());  /* 合計値段(FIP) */
          }
        }
      }
    }
    else if (CompileFlag.FSP_REWRITE) {
      if (!( (await RcSysChk.rcChkFspRewriteSystem()) &&
          (mem.tTtllog.t100700.mbrInput == MbrInputType.rwCardInput.index))) {
        rcmbrDispTextSet();
        if ((await RcFncChk.rcCheckStlMode()) && !RcFncChk.rcCheckSItmMode()) {
          /* 小計画面？ */
          RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
          rcmbrDispFIP(await RcSysChk.rcKySelf());  /* 合計値段(FIP) */
        }
        else if (RcFncChk.rcCheckSItmMode()) {
          await RcStlDsp.rcStlDspTotalizers(1); /* 小計合計表示 */
          RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
          rcmbrDispFIP(await RcSysChk.rcKySelf());  /* 合計値段(FIP) */
        }
      }
    }
    else if (CompileFlag.VISMAC) {
      if (!((await RcSysChk.rcChkVMCSystem()) &&
          (mem.tTtllog.t100700.mbrInput == MbrInputType.vismacCardInput.index))) {
        rcmbrDispTextSet();
        if ((await RcFncChk.rcCheckStlMode()) && !RcFncChk.rcCheckSItmMode()) {
          /* 小計画面？ */
          RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
          rcmbrDispFIP(await RcSysChk.rcKySelf());  /* 合計値段(FIP) */
        }
        else if (RcFncChk.rcCheckSItmMode()) {
          await RcStlDsp.rcStlDspTotalizers(1); /* 小計合計表示 */
          RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
          rcmbrDispFIP(await RcSysChk.rcKySelf());  /* 合計値段(FIP) */
        }
      }
    }
    else {
      rcmbrDispTextSet();
      if ((await RcFncChk.rcCheckStlMode()) && !RcFncChk.rcCheckSItmMode()) {
        /* 小計画面？ */
        RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
        rcmbrDispFIP(await RcSysChk.rcKySelf());  /* 合計値段(FIP) */
      }
      else if (RcFncChk.rcCheckSItmMode()) {
        await RcStlDsp.rcStlDspTotalizers(1); /* 小計合計表示 */
        RcStlDsp.rcStlDspMember(1);     /* 小計合計表示 */
        rcmbrDispFIP(await RcSysChk.rcKySelf());  /* 合計値段(FIP) */
      }
    }

    if ((await RcFncChk.rcCheckItmMode())
        && (RcSysChk.rcChkItemDisplayType())) {
      await RcItmDsp.rcDspTtlPrcLCD(RcRegs.OPE_START);
    }
    if (CompileFlag.PRESET_ITEM) {
      await RcItmDsp.presetItemDsp();
    }
    if (precaOnceMbrFlg != 0) {
      /* CoGCa残高照会処理後に行うのでリターン */
      precaOnceMbrFlg = 0;
      precaOnceMbrAfterProcType = 1;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "Rcmbrkymbr.rcAfterMbrProc(): Skip");
      return;
    }

    cogcaIccdMbrProc();

    await rcmbrProcDlgAndSound(MbrDlgChkOrder.MBRDLG_ORDER_CPNMSG);
    sptendCntReset(0,0,0,0,0);
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加（Cogca仕様は対象外）
  /// CoGCa IC顧客の後処理
  ///  関連tprxソース: rcmbrkymbr.c - rcAfter_Mbr_Proc
  static void cogcaIccdMbrProc() {}

  /// 各種パラメタを引数の値にセットする
  ///  関連tprxソース: rcmbrkymbr.c - rcmbrkymbr_sptendCntReset
  static void sptendCntReset(int cnt, int bk, int data, int flg, int receipt) {
    sptendChkcnt = cnt;
    sptendCntbk = bk;
    qcData = data;
    selfFlg = flg;
    receiptFlg = receipt;
  }

  ///  関連tprxソース: rcmbrkymbr.c - rcmbrkymbr_sptendCalcCntSet
  static Future<void> sptendCalcCntSet() async {
    if ((await RcFncChk.rcChkQcashierMemberReadSystem())
        && (await RcFncChk.rcChkQcashierMemberReadEntryMode())) {
      RegsMem mem = SystemFunc.readRegsMem();
      AcMem cMem = SystemFunc.readAcMem();
      int qcEntry = 0;

      RcQcDsp.qc_mbrread_entry2 = 0;
      RcQcDsp.qc_mbrread_data2 = 0;
      /* 再計算前のスプリット段数を保存 */
      sptendCntbk = mem.tTtllog.t100001Sts.sptendCnt;
      /* レシート/領収書選択の場合、最終スプリットを含める為、スプリット段数をカウントアップ */
      if (await RcQcDsp.rcChkQcashierMemberReadReadErrCallScrMode(
          "sptendCalcCntSet()") == QcScreen.QC_SCREEN_RECEIPT_SELECT.index) {
        mem.tTtllog.t100001Sts.sptendCnt++;
      }
      /* 再計算後の比較用スプリット段数を保存 */
      sptendChkcnt = mem.tTtllog.t100001Sts.sptendCnt;
      /* 再計算処理前と後で残余額に差があるか確認するため残余額を取得 */
      await RcNoChgDsp.rcChgGetSptendData(qcEntry, qcData);

      await RcQcDsp.rcQcashierMemberReadCashEndFlgSet("sptendCalcCntSet()", 0);

      selfFlg = 1;
      receiptFlg = await RcQcDsp.rcChkQcashierMemberReadReadErrCallScrMode("sptendCalcCntSet()");

      await RcspRecal.rcSPTendBufEdit(0);  /* 現在のスプリット情報をバッファに退避 */
      RcspRecal.rcSPTendTtllogClear(); /* スプリット情報をクリア */
      cMem.ent.tencnt = 0;
    }
  }

  /// 顧客情報を設定する
  ///  関連tprxソース: rcmbrkymbr.c - rcSet_Mbr_Prc
  static Future<int> rcSetMbrPrc() async {
    if (RcFncChk.rcCheckScanCheck()) {
      return Typ.OK;
    }
    await RcMbrCmSrv.rcmbrComCustDataSet();
    if (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_FSP) != 0) {
      await RcmbrFspTotalLog.rcmbrFspCustDataSet();
    }
    rcNoRankMbrPoint();
    await RcMbrCmSrv.rcmbrComCashSet(0);
    anvFlgSet();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xtRet.isInvalid()) {
      return Typ.OK;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xtRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (!(await RcFncChk.rcCheckEESVoidMode())) {
      if (RcSysChk.rcsyschkAyahaSystem()) {
        await rcMbrAyahaItmSchData();
      }
      if (!CompileFlag.MC_SYSTEM && !CompileFlag.DEPARTMENT_STORE) {
        /* 有効期限・年会費 */
        if ((await RcSysChk.rcChkCardFeeSystem())
            && (mem.tTtllog.t100702.joinFeeAmt != 0)) {
          if (CompileFlag.CUSTREALSVR) {
            if ((RcSysChk.rcChkCustrealsvrSystem() ||
                (await RcSysChk.rcChkCustrealNecSystem(0)))
                && (cBuf.custOffline == 2)) {
              mem.tTtllog.t100001.validDate = mem.custTtlTbl.d_data10!;
              mem.tTtllog.t100702.joinFeeCust = 0;
              mem.tTtllog.t100702.joinFeeAmt = 0;
              await rcAfterMbrProc();
            }
            else {
              rcMbrConfCardFee();
            }
          }
          else {
            rcMbrConfCardFee();
          }
        }
        else if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
          if (tsBuf.custreal2.stat != 0) {
            mem.tTtllog.t100900.vmcStkhesoacv = 1;
            if ((await RcSysChk.rcSGChkSelfGateSystem())
                && (RcSgDsp.mntDsp.mntDsp == 0)
                && (RcSgDsp.selfMem.Staff_Call == 0)) {
              await rcAfterMbrProc();
            }
            else {
              rcwebrealUIDDialogErr(tsBuf.custreal2.stat, 1, "");
            }
          }
          else {
            mem.tTtllog.t100900.vmcStkhesoacv = await rcChkDispChk();
            if (mem.tTtllog.t100900.vmcStkhesoacv == 3) {
              rcwebrealUIDDialogErr(
                  -1, 1, tsBuf.custreal2.data.uid.rec.now_rank_name);
            }
            else if (mem.tTtllog.t100900.vmcStkhesoacv == 4) {
              rcwebrealUIDDialogErr(1, 1, "");
            }
            else if ((mem.tTtllog.t100900.vmcStkhesoacv == 5) ||
                (mem.tTtllog.t100900.vmcStkhesoacv == 6) ||
                (mem.tTtllog.t100900.vmcStkhesoacv == 9)) {
              rcwebrealUIDDialogErr(1, mem.tTtllog.t100900.vmcStkhesoacv, "");
            }
            else if (mem.tTtllog.t100900.vmcStkhesoacv != 0) {
              rcwebrealUIDDialogErr(0, mem.tTtllog.t100900.vmcStkhesoacv,
                  tsBuf.custreal2.data.uid.rec.err_msg);
            }
            else {
              await rcAfterMbrProc();
            }
          }
        }
      }
      else {
        await rcAfterMbrProc();
      }
    }

    // RM-3800 フローティング仕様 中身あり貸瓶仕様 顧客入力済み
    if ((Rc59dsp.rc59FloatingDepoinpluChk() != 0) &&
        (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index)) {
      Rc59dsp.rc59FloatingDepoinpluMbrInput();	// 商品加算の実行
    }
    // RM-3800 デポジット商品の顧客確定で入力状態クリアする
    if (cBuf.vtclRm5900RegsOnFlg != 0) {    // RM-3800
      Rc59dsp.rc59DepoinpluMbrInput(0);		// デポジット商品の管理/顧客入力状態を解除
    }

    return Typ.OK;
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rcmbrkymbr.c ‐ rcmbrkymbr_CheckOfflineDlg
  static bool rcChkMbrOfflineDlg() {
    return false;
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// カード有効期限切れダイアログを表示する
  ///  関連tprxソース: rcmbrkymbr.c ‐ rcMbr_Conf_CardFee
  static void rcMbrConfCardFee() {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// ワタリ仕様 未登録会員確認ダイアログを表示する
  ///  関連tprxソース: rcmbrkymbr.c ‐ rcWatari_OtherMbr_Dialog
  static void rcWatariOtherMbrDialog(int errNo) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加（フロント処理）
  /// Dual Single mode Scan Member Disp
  ///  関連tprxソース: rcmbrkymbr.c ‐ rcDualSingle_ScanMbr
  static void rcDualSingleScanMbr() {}

  /// [CoGCa仕様] 顧客一度読みの会員呼出の後処理タイプチェック
  /// 戻り値: 後処理タイプ
  ///  関連tprxソース: rcmbrkymbr.c ‐ rcAfter_Preca_Once_Mbr_Type_Chk
  static int rcAfterPrecaOnceMbrTypeChk() {
    return precaOnceMbrAfterProcType;
  }

  /// [CoGCa仕様] 顧客一度読みフラグの初期化
  ///  関連tprxソース: rcmbrkymbr.c ‐ rcAfter_Preca_Once_Mbr_Reset
  static Future<void> rcAfterPrecaOnceMbrReset() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "Rcmbrkymbr.rcAfterPrecaOnceMbrReset()");
    precaOnceMbrFlg = 0;
    precaOnceMbrAfterProcType = 0;
  }
}

/// 全員向けの(クーポン印字 or ターゲットメッセージ)と顧客エラーが同時に起きた場合に対処するための情報格納
///  関連tprxソース: rcmbrkymbr.c - struct TmpReadData
class TmpReadData {
  /// 状態: 0=通常  1=顧客読込中(このときだけ動作したいため)
  int status = 0;
  /// エラーコード
  int errCd = 0;
}

/// 電話番号情報
///  関連tprxソース: rcmbrkymbr.c - struct TELSCHINFO
class TelSchInfo {
  int inptCnt = 0;
  int inptKind = 0;
  String telNo = "";
  String birthDay = "";
}