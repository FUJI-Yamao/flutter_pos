/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:typed_data';

import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/db/c_ttllog.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/inc/lib/apllib.dart';
import 'package:flutter_pos/app/regs/checker/rc_acbstopdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_advanceout.dart';
import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'package:flutter_pos/app/regs/checker/rc_auto.dart';
import 'package:flutter_pos/app/regs/checker/rc_cash_recycle.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_changer.dart';
import 'package:flutter_pos/app/regs/checker/rc_ewdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rc_gtktimer.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifprint.dart';
import 'package:flutter_pos/app/regs/checker/rc_inout.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_reserv.dart';
import 'package:flutter_pos/app/regs/checker/rcky_pick.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin_acb.dart';
import 'package:flutter_pos/app/regs/checker/rcqc_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_recno.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl.dart';
import 'package:flutter_pos/app/regs/checker/rc_usbcam1.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcinoutdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcky_cin.dart';
import 'package:flutter_pos/app/regs/checker/rcky_prc.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rpr.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/checker/rcsg_vfhd_cashback.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/lib/cm_chg/bcdtol.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_auto.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_com.dart';
import 'package:flutter_pos/app/inc/lib/if_th.dart';
import 'package:flutter_pos/app/lib/cm_ary/chk_spc.dart';

import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff_keyopt.dart';
import '../../inc/db/c_ttllog_sts.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../acx/rc_acx.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

class RckyOut {
  static int nearEndEmptyNo = Typ.OK;
  static int nearEndEmptyStopNo = Typ.OK;
  static int acrErrno = 0;
  static int popWarn = 0;
  static int printErr = 0;
  static int updateErr = 0;
  static int price = 0;

/*----------------------------------------------------------------------*
 * Constant Values
 *----------------------------------------------------------------------*/
  static List<int> lumpOut0 = [
    FncCode.KY_REG.keyId,
    FncCode.KY_ENT.keyId,
    FuncKey.KY_MAN.keyId,
    FuncKey.KY_SEN.keyId,
    FuncKey.KY_5SEN.keyId,
// #if TW
    // KY_5HYAKU,
// #endif
    0
  ];
  static const List<int> lumpOut1 = [0];
  static const List<int> lumpOut2 = [0];
  static const List<int> lumpOut3 = [0];
  static const List<int> lumpOut4 = [0];
  static List<int> diffOut0 = [
    FncCode.KY_REG.keyId,
    FncCode.KY_ENT.keyId,
    FuncKey.KY_PLU.keyId,
    0
  ];
  static const List<int> diffOut1 = [0];
  static const List<int> diffOut2 = [0];
  static const List<int> diffOut3 = [0];
  static const List<int> diffOut4 = [0];
  static List<int> rsvOut0 = [
    FncCode.KY_REG.keyId,
    0
  ];
  static const List<int>  rsvOut1 = [0];
  static const List<int>  rsvOut2 = [0];
  static const List<int>  rsvOut3 = [0];
  static const List<int>  rsvOut4 = [0];

  static InOutInfo inOut = InOutInfo();
  static KoptinoutBuff kortInOut = KoptinoutBuff();
  static TprLog myLog = TprLog();


  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // TODO:未実装関数とりあえずここに定義 実装したら削除願います！
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // static void rc_usbcam_start_stop( int type, int force ){}
  // static int rcAcrAcb_StopWindow_Check(){return 0;}
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  /// 関数名     :
  /// 機能概要   :支払
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     :
  ///  関連tprxソース: rcky_out.c - rcKyOut
  static Future<void> rcKyOut() async {
    popWarn = 0;
    acrErrno = Typ.OK;
    printErr = Typ.OK;
    updateErr = Typ.OK;
    price = 0;

    if (CompileFlag.RESERV_SYSTEM) {
      if (await rcReservOutChk() || (await RcAdvanceOut.rcChkAdvanceOut())) {
        rcReservOut();
        return;
      }
    }

    if (await rcDrwchgOutChk()) {
      await rcDrwchgOut();
      return;
    }

    AcMem cMem = SystemFunc.readAcMem();

    if ((await CmCksys.cmNetDoAreservSystem() != 0) &&
        (cMem.stat.fncCode == FuncKey.KY_OUT14.keyId)) {
      cMem.ent.errNo = await rcCheckKyNetDoARsvOut(0);
      if (cMem.ent.errNo != 0) {
        await ReptEjConf.rcErr("rcKyOut", cMem.ent.errNo);
      }
      else {
        await RcAdvanceOut.rcAdvanceOutAdj();
      }
      return;
    }

    cMem.ent.errNo = await rcCheckKyOut(0);
    if (cMem.ent.errNo == 0) {
      await RcFlrda.rcReadKoptinout(cMem.stat.fncCode, kortInOut);
      cMem.ent.errNo = await rcKyLumpOut();
    }
    if (cMem.ent.errNo != 0) {
      await ReptEjConf.rcErr("rcKyOut", cMem.ent.errNo);
    }
  }

  /// 関数名     :
  /// 機能概要   :キーステータスのチェック関数
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     : short chkCtrlFlg
  ///            : 0以外で特定のチェック処理を除外する
  ///            : 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  ///            : 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  static Future<int> rcCheckKyOut(int chkCtrlFlg) async {
    int  ret;

    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        (!await RcSysChk.rcCheckQCJCSystem())) {
      return (DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId);
    }

    AcMem cMem = SystemFunc.readAcMem();

    //釣銭機が動作するキーのチェック
    switch(FuncKey.values[cMem.stat.fncCode]) {
      case FuncKey.KY_CHGOUT:
        if(await RcAcracb.rcCheckAcrAcbON(1) == 0) {
          /* 釣銭機未接続(使用不可モード含む) */
          return(RcAcracb.rcCheckAcrAcbOFFType(0));
        }
        break;
      case FuncKey.KY_CHG_MENTEOUT:
        if(await RcAcracb.rcCheckAcrAcbON(1) != CoinChanger.ACR_COINBILL) {
          /* 釣札機でない */
          return(RcAcracb.rcCheckAcrAcbOFFType(1));
        }
        if(! ((AcxCom.ifAcbSelect() != 0) & (CoinChanger.RT_300_X != 0))) {
          return(DlgConfirmMsgKind.MSG_TEXT205.dlgId);
        }
        if(await CmCksys.cmAcxControlMode() == 0) {
          /* 現金管理機モードでない */
          return(DlgConfirmMsgKind.MSG_TEXT206.dlgId);
        }
        break;
      default:
        break;
    }
    if(RcSysChk.rcChkTRDrwAcxNotUse()) {
      return(DlgConfirmMsgKind.MSG_TR_ACX_NOTUSE.dlgId);	//練習モードでの釣銭機「禁止」に設定されています
    }

    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    List<int> p = [];
    int i;
    p = lumpOut0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb, i); i++; }
    p = lumpOut1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb, i); i++; }
    p = lumpOut2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb, i); i++; }
    p = lumpOut3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb, i); i++; }
    p = lumpOut4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb, i); i++; }
    p = diffOut0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb, i); i++; }
    p = diffOut1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb, i); i++; }
    p = diffOut2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb, i); i++; }
    p = diffOut3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb, i); i++; }
    p = diffOut4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb, i); i++; }
    ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return (RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret));
    }

    return(Typ.OK);
  }

  /// 関数名     :
  /// 機能概要   : 画面表示チェックし画面表示を行う
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     :
  static Future<int> rcKyLumpOut() async {
    int errNo;
    int camStop = 0;
    int camStart = 0;

    errNo = rcChkLumpOut(0);
    if (errNo == 0) {
      // 支払及び釣機払出を行った場合のUSBカメラのスタート
      if (await RcSysChk.rcQCChkQcashierSystem()) {
        // QCashier
        camStop = UsbCamStat.QC_CAM_STOP.index;
        camStart = UsbCamStat.QC_CAM_START.index;
      }
      else {
        // 卓上レジ
        camStop = UsbCamStat.CA_CAM_STOP.index;
        camStart = UsbCamStat.CA_CAM_START.index;
      }

      AcMem cMem = SystemFunc.readAcMem();
      AtSingl atSingle = SystemFunc.readAtSingl();

      // 釣銭機が接続され時、支払の金種別登録「釣銭機利用」、釣機払出のチェック
      if (await RcAcracb.rcCheckAcrAcbON(1) != 0 // 釣銭釣札機が接続されているか
          && (kortInOut.frcSelectFlg == 0 // 支払キー：金種別登録を「釣銭機利用」
              ||
              (cMem.stat.fncCode == FuncKey.KY_CHGOUT.keyId))) // 釣機払出キー：金種別登録の設定に関わらず録画
      {
        RcUsbCam1.rcUsbcamStopSet(0, camStop);
        RcUsbCam1.rcUsbcamStartStop(camStart, 0);
      }

      if ((!await RcFncChk.rcCheckStlMode()) && (!RcFncChk.rcCheckSItmMode())) {
        if (!ChkSpc.cmChkSpc(cMem.scrData.subibuf, cMem.scrData.subibuf.length)) {
          await RcItmDsp.rcDspEntLCD();
          await RcItmDsp.rcQtyClr();
        }
      }
      if ((await RcFncChk.rcCheckStlMode()) &&
          (!(RcFncChk.rcCheckRegistration()))) {
        atSingle.fselfInoutChk = 1; /* 常時入金仕様時、このタイミングで釣銭機をIN状態にさせない為 */
        RcItmDsp.rcItemScreen();
      }
      rcEditKeyData();
      rcPrgLumpOut();
      RcRegs.kyStS0(cMem.keyStat, inOut.fncCode); /* Set Bit 0 of KY_CIN? */
      RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); /* Set Bit 0 of FncCode.KY_REG.keyId */
      if (await Rcinoutdsp.rcChkNominalOpe() != 0) {
        // 金種別の払出設定
        cMem.ent.errNo = await Rcinoutdsp.rcProcNominalOpe();
        if (cMem.ent.errNo != Typ.OK) {
          await ReptEjConf.rcErr("rcKyLumpOut", cMem.ent.errNo);
        }
      }
      else if (kortInOut.frcSelectFlg == 1 &&
          (cMem.stat.fncCode != FuncKey.KY_CHGOUT.keyId)) /* 金種別登録する */ {
        await Rcinoutdsp.rcInOutDifferentDisp(Inout_Disp_Type.INOUT_DISP_NOMAL);
      }
      else
        /* 金種別登録する以外 */ {
        await Rcinoutdsp.rcInOutDifferentDisp(Inout_Disp_Type.INOUT_DISP_NEW_OUT);
      }
    }

    return (errNo);
  }

  /// 関数名     :
  /// 機能概要   : 登録画面の表示チェック
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     : short chkCtrlFlg
  ///            : 0以外で特定のチェック処理を除外する
  ///            : 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  ///            : 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  static int rcChkLumpOut(int chkCtrlFlg) {
    AtSingl atSingle = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (RcSysChk.rcChkMammyMartSystem()) /* マミーマート様向け仕様 */ {
      if (atSingle.beamReleaseFlg == 0) /* 桁解除が無効な場合 */ {
        if ((cMem.ent.tencnt > 8)
            || (cMem.ent.tencnt > kortInOut.digit)) /* Put on Over ? */ {
          return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
        }
        if (RcKyPrc.rcKyPriceLimitChk(
            Bcdtol.cmBcdToL(cMem.ent.entry.sublist(3)),
            Rxkoptcmncom.rxChkKoptPrcAmtLimit(cBuf)) != 0) {
          /* 金額制限確認 */
          return (DlgConfirmMsgKind.MSG_PRICEOVER.dlgId);
        }
      }
    }
    else {
      if ((cMem.ent.tencnt > 8) || (cMem.ent.tencnt > kortInOut.digit)) {
        /* Put on Over ? */
        return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
      }

      /* 金種別登録する かつ 置数中*/
      if ((kortInOut.frcSelectFlg == 1) && (cMem.ent.tencnt != 0)) {
        return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
      }
    }

    return (Typ.OK);
  }

  static Future<void> rcEndLumpOut6() async {
    RcGtkTimer.rcGtkTimerRemove();

    price = 0;
    if ((printErr != 0) || (updateErr != 0)) {
      printErr = Typ.OK;
      updateErr = Typ.OK;
      rcEndKyOut();
    }
    else {
      RckyRpr.rcWaitResponce(inOut.fncCode);
    }

    if (RcSysChk.rcChkMammyMartSystem()) /* マミーマート様向け仕様 */ {
      AtSingl atSingle = SystemFunc.readAtSingl();
      if (atSingle.beamReleaseFlg == 1) /* 支払終了毎に桁解除を無効にする */ {
        atSingle.beamReleaseFlg = 0;
        await RcItmDsp.rcDspSusmkLCD(); /* 桁解除表示消去 */
      }
    }
  }

  /// 関数名     :
  /// 機能概要   : ドロアオープン
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     :
  static Future<void> rcPrgLumpOut() async {
    if (kortInOut.frcSelectFlg == 1) {
      //金種別登録する->ドロア開けて出金
      await Rcinoutdsp.rcInoutDrawOpen(0);
    }
    await RcExt.cashStatSet("rcPrgLumpOut");
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    tsBuf.cash.inout_flg = 1;
    return;
  }

  static Future<void> rcUpdateLumpOut() async {
    rcUpdateLumpEdit();
    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      /* Coin/Bill-Changer ON ? */
      acrErrno = await RcAcracb.rcAcrAcbStockUpdate(1);
    }
  }

  static Future<void> rcUpdateLumpEdit() async {
// #if RESERV_SYSTEM
//  c_reserv_log   reserv;
// #endif
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); /* Ttl Buffer All Clear */

    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_OUT_FLAG; /* OUT flag */
    regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_OUT.index;
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
    regsMem.tTtllog.t105300.outCd = inOut.fncCode;
    regsMem.tTtllog.t105300Sts.chgInoutAmt = inOut.Pdata.TotalPrice;

    rcUpdateDiffEditOut();
    await Rcinoutdsp.rcInOutLumpAmtSetCmn(-1, kortInOut, inOut.Pdata.TotalPrice, 0);
  }

  ///  関連tprxソース: rcky_out.c - rcEnd_DifferentOut
  static Future<(int, int)> rcEndDifferentOut(int type, int step, int chgData0) async {
    int errNo = Typ.OK;
    int errStat = 0;
    int totalDspChk = 0;
    int chgOutAmt;
    String callFunc = 'rcEndDifferentOut';

    step = 0;
    RegsMem regsMem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
    }
    RxCommonBuf cBuf = xRetC.object;

    if ((type == PrnterControlTypeIdx.TYPE_OZEKI_CASHBACK.index) &&
        await RcgVfhdCashBack.rcSgVFHDCheckCashBackMode()) {
      //釣機払出機能をキャッシュバックモードで動作させる為
      inOut.fncCode = FuncKey.KY_CASHBACK.keyId;
      inOut.dispType = Inout_Disp_Type.INOUT_DISP_CASHBACK;
      inOut.InOutBtn[InoutDisp.INOUT_Y10000].Amount =
          regsMem.tTtllog.t100701.dtipTtlsrv; //キャッシュバック利用ポイント(チケット発行ポイント)
    }
    Rcinoutdsp.rcCalDifferentTtl();
    if ((cMem.scrData.price == 0) && (chgData0 == 0)) {
      return (DlgConfirmMsgKind.MSG_TRC_TTL_ZERO.dlgId, step);
    }

    //釣銭機が接続されており、金種別登録「釣銭機利用」であれば出金
    if ((await RcAcracb.rcCheckAcrAcbON(1) != 0) && (kortInOut.frcSelectFlg == 0)) {
      chgOutAmt = chgData0;
      errNo = await RcAcracb.rcPrgAcrAcbChangeOut(chgOutAmt);
      if (errNo != Typ.OK) {
        return (errNo, step);
      }
    }

    if (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) {
      totalDspChk = 1;
    }
    else {
      if (await RcSysChk.rcChkDesktopCashier()) {
        totalDspChk = 1;
      }
    }

    await rcUpdateDiffOut(type); //実績メモリ作成

    // TODO:一括入力金額（円）ここで設定　本来は「rcUpdateDiffOut」で設定されるべき
    regsMem.tTtllog.t105300Sts.chgInoutAmt = chgData0;

    if (totalDspChk == 1) {
      await rcInputTotalDisp();
    }

    if (type == PrnterControlTypeIdx.TYPE_CCHG.index) {
      return (errNo, step);
    }
    if (type == PrnterControlTypeIdx.TYPE_OZEKI_CASHBACK.index) {
      return (errNo, step); //キャッシュバック処理で実績上げと印字を行う為
    }

    step = 1; //これ以降、エラー発生後も入出金画面は消去
    errNo = await RcFncChk.rcChkRPrinter();
    if (errNo != Typ.OK) {
      await ReptEjConf.rcErr("rcEndDifferentOut", errNo);
      RcKyPick.rcChkKopttranUpdateDiff(); //RcIfEvent.rcSendUpdate
      await RcRecno.rcIncRctJnlNo(true);
      rcEndKyOut();
    }
    else {
      AtSingl atSingle = SystemFunc.readAtSingl();
      atSingle.rctChkCnt = 0;
      await RcExt.rxChkModeSet("rcEndDifferentOut");
      CalcResultChanger retData = await RcClxosChanger.changerOut(cBuf);
      errNo = retData.retSts!;
      if (0 != errNo) {
        await ReptEjConf.rcErr("rcEndDifferentOut", errNo);
        errNo = Typ.OK;
        errStat = 1;
      }
      else {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
      }
      errNo = RcKyPick.rcChkKopttranUpdateDiff(); //RcIfEvent.rcSendUpdate
      await RcRecno.rcIncRctJnlNo(true);
      if ((errNo != 0) || (errStat != 0)) {
        rcEndKyOut();
        await RcExt.rxChkModeReset("rcEndDifferentOut");
      }
      else {
        if (inOut.fncCode != 0) {
          RckyRpr.rcWaitResponce(inOut.fncCode);
        } else {
          RckyRpr.rcWaitResponce(FuncKey.KY_OUT1.keyId);
        }
      }
    }
    return (errNo, step);
  }

  static Future<void> rcUpdateDiffOut(int type) async {
    await rcUpdateDiffEdit(type);
    if(await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      /* Coin/Bill-Changer ON ? */
      await RcAcracb.rcAcrAcbStockUpdate(1);
    }
  }

  static void rcUpdatePrnTypeEdit(int type) {
    RegsMem regsMem = SystemFunc.readRegsMem();
    switch (PrnterControlTypeIdx.values[type]) {
      case PrnterControlTypeIdx.TYPE_RCPT: //指定なし
        regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_OUT.index;
        break;
      case PrnterControlTypeIdx.TYPE_CCHG:
        regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_SELECT_COUT.index;
        break;
      default: //指定あり
        regsMem.tHeader.prn_typ = type;
        break;
    }
  }

  static Future<void> rcUpdateDiffEdit(int type) async {
    String log = "";
    int amtData = 0;

    if (inOut.dispType >= Inout_Disp_Type.INOUT_DISP_NEW_OUT) {
      inOut.InOutBtn[InoutDisp.INOUT_Y10000].Amount = inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count = 0;
      inOut.InOutBtn[InoutDisp.INOUT_Y5000].Amount = inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count = 0;
      inOut.InOutBtn[InoutDisp.INOUT_Y2000].Amount = inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count = 0;
    }
    RegsMem regsMem = SystemFunc.readRegsMem();
    T105100Sts stsBk = T105100Sts();
    stsBk = regsMem.tTtllog.t105100Sts;

    if (await RcgVfhdCashBack.rcSgVFHDCheckCashBackMode() && (inOut.fncCode == FuncKey.KY_CASHBACK.keyId)) {
      //キャッシュバックモードでは、在高以外の実績も必要な為
    }
    else {
      /* Ttl Buffer All Clear */
      RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL);
    }
    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_OUT_FLAG; /* OUT flag */
    rcUpdatePrnTypeEdit(type);
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
    //出金実績(t105300)
    regsMem.tTtllog.t105300.outCd = inOut.fncCode;
    log = "rcUpdateDiffEdit Out key_cd(${regsMem.tTtllog.t105300.outCd})";
    myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    regsMem.tTtllog.t105300.divCd = inOut.divCd;
    regsMem.tTtllog.t105300Sts.divName = "";
    regsMem.tTtllog.t105300Sts.divName = inOut.divName;

    if (inOut.dispType >= Inout_Disp_Type.INOUT_DISP_NEW_OUT) {
      regsMem.tTtllog.t105300Sts.chgInoutAmt = inOut.Pdata.TotalPrice;
      //金額指定出金のため、どの金種が何枚出金されたかは認識できない。
      //よってt105300Sts.mny_*_shtは、作成しない。
    }
    else if (type == PrnterControlTypeIdx.TYPE_CCHG.index) {
      regsMem.tTtllog.t105300Sts.chgInoutAmt = regsMem.tTtllog.t105400.exchgAmt;
      regsMem.tTtllog.t105300Sts.mny10000Sht	= regsMem.tTtllog.t105400Sts.aftrSht10000;
      regsMem.tTtllog.t105300Sts.mny5000Sht	= regsMem.tTtllog.t105400Sts.aftrSht5000;
      regsMem.tTtllog.t105300Sts.mny2000Sht	= regsMem.tTtllog.t105400Sts.aftrSht2000;
      regsMem.tTtllog.t105300Sts.mny1000Sht	= regsMem.tTtllog.t105400Sts.aftrSht1000;
      regsMem.tTtllog.t105300Sts.mny500Sht	= regsMem.tTtllog.t105400Sts.aftrSht500;
      regsMem.tTtllog.t105300Sts.mny100Sht	= regsMem.tTtllog.t105400Sts.aftrSht10;
      regsMem.tTtllog.t105300Sts.mny50Sht	= regsMem.tTtllog.t105400Sts.aftrSht50;
      regsMem.tTtllog.t105300Sts.mny10Sht	= regsMem.tTtllog.t105400Sts.aftrSht10;
      regsMem.tTtllog.t105300Sts.mny5Sht	= regsMem.tTtllog.t105400Sts.aftrSht5;
      regsMem.tTtllog.t105300Sts.mny1Sht	= regsMem.tTtllog.t105400Sts.aftrSht1;
    }
    else {
      regsMem.tTtllog.t105300Sts.chgInoutAmt	= inOut.Pdata.TotalPrice;
      regsMem.tTtllog.t105300Sts.mny10000Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count;
      regsMem.tTtllog.t105300Sts.mny5000Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count;
      regsMem.tTtllog.t105300Sts.mny2000Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count;
      regsMem.tTtllog.t105300Sts.mny1000Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y1000].Count;
      regsMem.tTtllog.t105300Sts.mny500Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y500].Count;
      regsMem.tTtllog.t105300Sts.mny100Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y100].Count;
      regsMem.tTtllog.t105300Sts.mny50Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y50].Count;
      regsMem.tTtllog.t105300Sts.mny10Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y10].Count;
      regsMem.tTtllog.t105300Sts.mny5Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y5].Count;
      regsMem.tTtllog.t105300Sts.mny1Sht	= inOut.InOutBtn[InoutDisp.INOUT_Y1].Count;
      //ドロア開が行われている場合のみデータ加算
      if((await CmCksys.cmAcxChgdrwSystem() != 0) && (AcbInfo.drwdataSav == 1)) {
        RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (xRetS.isInvalid()) {
          return;
        }
        RxTaskStatBuf tsBuf = xRetS.object;
        //棒金ドロア出金枚数 = 開ける前の在高 - 閉めた後の在高
        regsMem.tTtllog.t105300Sts.mny500Sht  += (regsMem.tTtllog.t100600Sts.bfreStockPolSht500 - tsBuf.acx.coinStock.drawData!.coin500);
        regsMem.tTtllog.t105300Sts.mny100Sht  += (regsMem.tTtllog.t100600Sts.bfreStockPolSht100 - tsBuf.acx.coinStock.drawData!.coin100);
        regsMem.tTtllog.t105300Sts.mny50Sht   += (regsMem.tTtllog.t100600Sts.bfreStockPolSht500 - tsBuf.acx.coinStock.drawData!.coin50);
        regsMem.tTtllog.t105300Sts.mny10Sht   += (regsMem.tTtllog.t100600Sts.bfreStockPolSht100 - tsBuf.acx.coinStock.drawData!.coin10);
        regsMem.tTtllog.t105300Sts.mny5Sht    += (regsMem.tTtllog.t100600Sts.bfreStockPolSht500 - tsBuf.acx.coinStock.drawData!.coin5);
        regsMem.tTtllog.t105300Sts.mny1Sht    += (regsMem.tTtllog.t100600Sts.bfreStockPolSht100 - tsBuf.acx.coinStock.drawData!.coin1);
        }
    }

    rcUpdateDiffEditOut();
    regsMem.tTtllog.t105300.sht10000 = regsMem.tTtllog.t105300Sts.mny10000Sht;
    regsMem.tTtllog.t105300.sht5000 = regsMem.tTtllog.t105300Sts.mny5000Sht;
    regsMem.tTtllog.t105300.sht2000 = regsMem.tTtllog.t105300Sts.mny2000Sht;
    regsMem.tTtllog.t105300.sht1000 = regsMem.tTtllog.t105300Sts.mny1000Sht;
    regsMem.tTtllog.t105300.sht500 = regsMem.tTtllog.t105300Sts.mny500Sht;
    regsMem.tTtllog.t105300.sht100 = regsMem.tTtllog.t105300Sts.mny100Sht;
    regsMem.tTtllog.t105300.sht50 = regsMem.tTtllog.t105300Sts.mny50Sht;
    regsMem.tTtllog.t105300.sht10 = regsMem.tTtllog.t105300Sts.mny10Sht;
    regsMem.tTtllog.t105300.sht5 = regsMem.tTtllog.t105300Sts.mny5Sht;
    regsMem.tTtllog.t105300.sht1 = regsMem.tTtllog.t105300Sts.mny1Sht;

    //在高実績
    if ((type == PrnterControlTypeIdx.TYPE_COUT.index) ||
        (type == PrnterControlTypeIdx.TYPE_CHG_MENTEOUT.index) ||
        (type == PrnterControlTypeIdx.TYPE_CCHG.index) ||
        (inOut.dispType >= Inout_Disp_Type.INOUT_DISP_NEW_OUT) || (type ==
        PrnterControlTypeIdx.TYPE_OZEKI_CASHBACK.index)) {
      //釣機払出、キャッシュリサイクル、釣機両替、金種別登録しない
      amtData = regsMem.tTtllog.t105300Sts.chgInoutAmt;

      await Rcinoutdsp.rcInOutLumpAmtSetCmn(-1, kortInOut, amtData, 0);
    }
    else if (type == PrnterControlTypeIdx.TYPE_SELECT_COUT.index) {
      //金種別釣機払出
      amtData = regsMem.tTtllog.t105300Sts.chgInoutAmt;

      await Rcinoutdsp.rcInOutDiffAmtSetCmn(-1, kortInOut, amtData, 1);
    }
    else {
      await Rcinoutdsp.rcInOutDiffAmtSetCmn(-1, kortInOut, 0, 0);
    }

    regsMem.tTtllog.t105100Sts.kindoutPrnFlg = stsBk.kindoutPrnFlg;
    regsMem.tTtllog.t105100Sts.cpickErrno = stsBk.cpickErrno;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno1 = stsBk.kindoutPrnErrno1;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat1 = stsBk.kindoutPrnStat1;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno2 = stsBk.kindoutPrnErrno2;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat2 = stsBk.kindoutPrnStat2;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno3 = stsBk.kindoutPrnErrno3;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat3 = stsBk.kindoutPrnStat3;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno4 = stsBk.kindoutPrnErrno4;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat4 = stsBk.kindoutPrnStat4;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno5 = stsBk.kindoutPrnErrno5;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat5 = stsBk.kindoutPrnStat5;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno6 = stsBk.kindoutPrnErrno6;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat6 = stsBk.kindoutPrnStat6;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno7 = stsBk.kindoutPrnErrno7;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat7 = stsBk.kindoutPrnStat7;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno8 = stsBk.kindoutPrnErrno8;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat8 = stsBk.kindoutPrnStat8;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno9 = stsBk.kindoutPrnErrno9;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat9 = stsBk.kindoutPrnStat9;
    regsMem.tTtllog.t105100Sts.kindoutPrnErrno10 = stsBk.kindoutPrnErrno10;
    regsMem.tTtllog.t105100Sts.kindoutPrnStat10 = stsBk.kindoutPrnStat10;
  }

  static void rcUpdateDiffEditOut() {
    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tTtllog.t105300.outCnt = 1;
    regsMem.tTtllog.t105300.outAmt = regsMem.tTtllog.t105300Sts.chgInoutAmt;
  }

/*----------------------------------------------------------------------*
 * KY_OUT 1 -> 16 Management Functions
 *----------------------------------------------------------------------*/
  static void rcEditKeyData() {
    InOutInfo inOut = InOutInfo();
    AcMem cMem = SystemFunc.readAcMem();
    inOut.fncCode = cMem.stat.fncCode;
  }

  static Future<void> rcInputTotalDisp() async {
    switch (FuncKey.values[inOut.fncCode]) {
      case FuncKey.KY_OUT1 :
      case FuncKey.KY_OUT2 :
      case FuncKey.KY_OUT3 :
      case FuncKey.KY_OUT4 :
      case FuncKey.KY_OUT5 :
      case FuncKey.KY_OUT6 :
      case FuncKey.KY_OUT7 :
      case FuncKey.KY_OUT8 :
      case FuncKey.KY_OUT9 :
      case FuncKey.KY_OUT10:
      case FuncKey.KY_OUT11:
      case FuncKey.KY_OUT12:
      case FuncKey.KY_OUT13:
      case FuncKey.KY_OUT14:
      case FuncKey.KY_OUT15:
      case FuncKey.KY_OUT16:
      case FuncKey.KY_CHGOUT:
        await RcItmDsp.rcInOutTotalDisp(inOut.fncCode);
        break;
      default:
        break;
    }
  }

  ///  関連tprxソース: rcky_out.c - rcEnd_Ky_Out
  static Future<void> rcEndKyOut() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.ent.errNo != Typ.OK) {
      RcKyccin.ccinErrDialog2("rcEndKyOut", cMem.ent.errNo, 0);
    }

    RcSet.rcClearEntry();
    await RcSet.rcClearDataReg();
    cMem.postReg = PostReg();
// #if RESERV_SYSTEM
    if (!await RcAdvanceOut.rcChkAdvanceOut()) {
// #endif
      RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL);
    }
    RcSet.rcErr1timeSet();

    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    tsBuf.cash.inout_flg = 0;
    RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
    if (((cMem.keyStat.length) >= inOut.fncCode) && (inOut.fncCode >= 0)) {
      /* FORTIFY */
      RcRegs.kyStR0(cMem.keyStat, inOut.fncCode);
    }
    /* Reset Bit 0 of KY_OUT? */
    RcRegs.kyStS3(cMem.keyStat, FncCode.KY_FNAL.keyId);

    // USBカメラ録画終了
    // QC仕様ではない場合またはQCのメンテモードでないとき録画を停止する
    if (await RcSysChk.rcQCChkQcashierSystem() || !await RcQcDsp.rcQcChkScreenMente()) {
      RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
      RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.CA_CAM_STOP.index);
    }

    rcEndKyOut2();
  }

  static Future<void> rcEndKyOut2() async {
    int result;
    int popTimer;
    int cautionFlg;

    cautionFlg = 0;
    if (await RcSysChk.rcChkAcrAcbForgetChange()) {
      cautionFlg = 1;
    }
// #if COLORFIP
    else if (await RcSysChk.rcChkFselfSystem()) {
      /* 対面セルフの場合、LEDを消したいのでメッセージを表示させる */
      if (RcSysChk.rcChkChangeAfterReceipt()) {
        cautionFlg = 1;
      }
    }
// #endif
    else if (await RcSysChk.rcQCChkQcashierSystem()) {
      cautionFlg = 1;
    }

    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;

    RcGtkTimer.rcGtkTimerRemove();
    if ((await RcAcracb.rcCheckAcrAcbON(1) != 0) &&
        ((AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) ||
            (cautionFlg == 1))) {
      if ((result = RckyccinAcb.rcChkPopWindowChgOutWarn(0)) != 0) {
        cBuf.kymenuUpFlg = 2;
        popTimer = await RcAcracb.rcAcrAcbPopTimerCalc(result);

        AcMem cMem = SystemFunc.readAcMem();
        cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(popTimer, rcEndKyOut2);
        if (cMem.ent.errNo != 0) {
          await ReptEjConf.rcErr("rcEndKyOut2", cMem.ent.errNo);
          RcAuto.rcAutoEndFunc2(AutoLibEj.AUTOLIB_EJ_ERROR, cMem.ent.errNo);
// #if CASH_RECYCLE
          RcCashRecycle.rcCashRecycleChgOutEnd();
// #endif
          await RcExt.rxChkModeReset("rcEndKyOut2");
          if (RcSysChk.rcCheckRegFnal()) {
            await RcSet.cashStatReset2("rcEndKyOut2");
          }
          if (await RcSysChk.rcCheckQCJCChecker()) {
            await RcSet.rcClearDualChkReg();
          }
          cBuf.kymenuUpFlg = 0;
        }
        return;
      }
    }

// #if RESERV_SYSTEM
    if (!(await rcReservOutChk() || !await RcAdvanceOut.rcChkAdvanceOut())) {
// #endif
      nearEndEmptyStopNo = Typ.OK;
      if (!await RcFncChk.rcCheckCashRecycleMode()) {
        //キャッシュリサイクル出金では、ニアエンドが起きている金種を出金の対象にしていない。
        //よって、この出金のタイミングで指定枚数未満停止の条件になることはない。
        //この停止画面を表示を出してしまうとキャッシュリサイクル画面の上に出てくるので注意が必要。
        if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
          if (await RcFncChk.rcCheckAcbStopDsp()) {
            /* 釣銭機指定枚数未満停止仕様 */
            if ((nearEndEmptyStopNo = await RcAcracb.rcAcrAcbStopWindowCheck()) != Typ.OK) {
              nearEndEmptyNo = Typ.OK;
            }
          }
        }
      }
      IfWaitSave ifSave = SystemFunc.readIfWaitSave();
      if (nearEndEmptyNo != Typ.OK) {
        if (ifSave.count != 0) {
          ifSave = IfWaitSave();
        }
        /*　クリアキーがsaveされていてエラー表示と同時に確認せずに消去されるのを回避 */
        await ReptEjConf.rcErr("rcEndKyOut2", nearEndEmptyNo);
        nearEndEmptyNo = Typ.OK;
      }

      if (nearEndEmptyStopNo != Typ.OK) {
        /* 釣銭機指定枚数未満停止仕様 */
        if (ifSave.count != 0) {
          ifSave = IfWaitSave();
        }
        /*　クリアキーがsaveされていてエラー表示と同時に確認せずに消去されるのを回避 */
        nearEndEmptyStopNo = Typ.OK;
        await RcAcbStopdsp.rcAcbStopDspDraw();
      }
// #if RESERV_SYSTEM
    }
// #endif

    await RcExt.rxChkModeReset("rcEndKyOut2");
    if (RcSysChk.rcCheckRegFnal()) {
      await RcSet.cashStatReset2("rcEndKyOut2");
    }
    if (await RcSysChk.rcCheckQCJCChecker()) {
      await RcSet.rcClearDualChkReg();
    }
    cBuf.kymenuUpFlg = 0;

// #if RESERV_SYSTEM
    if (await RcAdvanceOut.rcChkAdvanceOut()) {
      // TODO:いらなそう
      //rc_AdvanceOut_EndBtn(NULL, 0);
    }
// #endif

// #if CASH_RECYCLE
    RcCashRecycle.rcCashRecycleChgOutEnd();
// #endif

    return;
  }

// #if RESERV_SYSTEM
  static Future<bool> rcReservOutChk() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ((await CmCksys.cmReservSystem() != 0 ||
        await CmCksys.cmNetDoAreservSystem() != 0) &&
        (cMem.stat.fncCode == FuncKey.KY_OUT15.keyId) &&
        (RcReserv.rcReservPrnSkipChk()));
  }

  static Future<void> rcReservOut() async {
    Uint8List entry = Uint8List(4);
    String log = "";
    int errNo = Typ.OK;
    int errStat = 0;
    String callFunc = 'rcReservOut';

    await RcExt.cashStatSet("rcReservOut");

    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    tsBuf.cash.inout_flg = 1;

    rcEditKeyData();

    AcMem cMem = SystemFunc.readAcMem();
    entry = cMem.ent.entry.sublist(3);
    inOut.Pdata.TotalPrice = Bcdtol.cmBcdToL(entry);
    cMem.scrData.price = inOut.Pdata.TotalPrice;

    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;
    if (cBuf.dbTrm.cashKindSelectReserveope != 0) {
      await RcFlrda.rcReadKoptinout(cMem.stat.fncCode, kortInOut);
      RegsMem regsMem = SystemFunc.readRegsMem();
      kortInOut.kyTyp = regsMem.tTtllog.t100100[0].sptendCd;
    }
    else if (await RcAdvanceOut.rcChkAdvanceOut()) {
      await RcFlrda.rcReadKoptinout(cMem.stat.fncCode, kortInOut);
      kortInOut.kyTyp = FuncKey.KY_CASH.index;
      if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
        /* Coin/Bill-Changer ON ?*/
        if (kortInOut.acbDrwFlg != 0) {
          await RcIfPrint.rcDrwopen(); /* Drawer Open !! */
          cMem.stat.clkStatus |= RcIf.OPEN_DRW;
          RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
          taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
        }
        else {
          cMem.stat.clkStatus &= ~RcIf.OPEN_DRW;
        }
      }
      else {
        await RcIfPrint.rcDrwopen(); /* Drawer Open !! */
        cMem.stat.clkStatus |= RcIf.OPEN_DRW;
        RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
        taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
      }
    }

    log = "";
    log = "rcReservOut price ${inOut.Pdata.TotalPrice} ";
    myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    if (((cMem.keyStat.length) >= inOut.fncCode) && (inOut.fncCode >= 0)) {
      /* FORTIFY */
      RcRegs.kyStS0(cMem.keyStat, inOut.fncCode); /* Set Bit 0 of KY_OUT? */
    }
    RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); /* Set Bit 0 of FncCode.KY_REG.keyId */

    await rcUpdateLumpOut();
    if (await RcAdvanceOut.rcChkAdvanceOut()) {
      errNo = await RcFncChk.rcChkRPrinter();
      if (errNo != Typ.OK) {
        await ReptEjConf.rcErr("rcReservOut", errNo);
        RcIfEvent.rcSendUpdate();
        await RcRecno.rcIncRctJnlNo(true);
        rcEndKyOut();
      }
      else {
        AtSingl atSingle = SystemFunc.readAtSingl();
        atSingle.rctChkCnt = 0;
        await RcExt.rxChkModeSet("rcReservOut");
        CalcResultChanger retData = await RcClxosChanger.changerOut(cBuf);
        errNo = retData.retSts!;
        if (0 != errNo) {
          await ReptEjConf.rcErr("rcReservOut", errNo);
          errNo = Typ.OK;
          errStat = 1;
        }
        else {
          // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
          await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
        }
        errNo = RcIfEvent.rcSendUpdate();
        await RcRecno.rcIncRctJnlNo(true);
        if ((errNo != 0) || (errStat != 0)) {
          await RckyCin.rcEndKyCin();
          await RcExt.rxChkModeReset("rcReservOut");
        }
        else {
          RckyRpr.rcWaitResponce(inOut.fncCode);
        }
      }
    }
    else {
      RcIfEvent.rcSendUpdate();
      await RcRecno.rcIncRctJnlNo(true);
      rcEndKyOut();
    }
  }
// #endif

  static Future<bool> rcDrwchgOutChk() async {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return true;
    }
    RxCommonBuf cBuf = xRetC.object;
    return ((cBuf.dbTrm.coopaizuFunc1 != 0) && (await RcFncChk.rcCheckAccountOffsetMode()));
  }

  static Future<void> rcDrwchgOut() async {
    String log = "";
    String callFunc = 'rcDrwchgOut';

    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
    }
    RxCommonBuf cBuf = xRetC.object;
    AcMem cMem = SystemFunc.readAcMem();
    cMem.scrData.price = inOut.Pdata.TotalPrice;

    log = "rcDrwChgOut price ${inOut.Pdata.TotalPrice} ";
    myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    if (((cMem.keyStat.length) >= inOut.fncCode) && (inOut.fncCode >= 0)) {
      /* FORTIFY */
      RcRegs.kyStS0(cMem.keyStat, inOut.fncCode); /* Set Bit 0 of KY_OUT? */
    }
    RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); /* Set Bit 0 of FncCode.KY_REG.keyId */

    RcSet.rcClearEntry();

    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_OUT_FLAG; /* OUT flag */
    regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_OUT.index;
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
    regsMem.tTtllog.t105300Sts.chgInoutAmt = inOut.Pdata.TotalPrice;
    rcUpdateDiffEditOut();

    await RcExt.rxChkModeSet("rcDrwchgOut");
    printErr = await RcFncChk.rcChkRPrinter();
    if (printErr == Typ.OK) {
      AtSingl atSingle = SystemFunc.readAtSingl();
      atSingle.rctChkCnt = 0;
      CalcResultChanger retData = await RcClxosChanger.changerOut(cBuf);
      printErr = retData.retSts!;
      if (0 != retData.retSts) {
        printErr = Typ.NG;
        await ReptEjConf.rcErr("rcReservOut", printErr);
      }
      else {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
      }
    }
    updateErr = RcIfEvent.rcSendUpdate();
    await RcRecno.rcIncRctJnlNo(true);

    if (printErr != Typ.OK) {
      cMem.ent.errNo = printErr;
    } else {
      if (updateErr != Typ.OK) {
        cMem.ent.errNo = updateErr;
      }
    }
    if (cMem.ent.errNo != Typ.OK) {
      await ReptEjConf.rcErr("rcDrwchgOut", cMem.ent.errNo);
    }

    cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(1, rcEndLumpOut6);
    if (cMem.ent.errNo != 0) {
      await ReptEjConf.rcErr("rcDrwchgOut", cMem.ent.errNo);
      await RcExt.rxChkModeReset("rcDrwchgOut");
    }

    return;
  }

  ///chkCtrlFlg : 0以外で特定のチェック処理を除外する
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  static Future<int> rcCheckKyNetDoARsvOut(int chkCtrlFlg) async {

    if((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) && (! await RcSysChk.rcCheckQCJCSystem())) {
      return(DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    }
    AcMem cMem = SystemFunc.readAcMem();
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);

    List<int> p = [];
    int i;
    p = rsvOut0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb, i); i++; }
    p = rsvOut1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb, i); i++; }
    p = rsvOut2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb, i); i++; }
    p = rsvOut3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb, i); i++; }
    p = rsvOut4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb, i); i++; }
    if(RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
      return(DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    }
    return(Typ.OK);
  }

  ///  関連tprxソース: rcky_out.c - rcCheck_AcrAcb_OutDigit
  Future<int> rcCheckAcrAcbOutDigit() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINONLY) {
      if (cMem.ent.tencnt > 3) {
        //釣銭機接続では百の位まで
        return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
      }
    }
    else if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
      if (AcxCom.ifAcbSelect() != 0 & CoinChanger.ACB_20) {
        if (cMem.ent.tencnt > 4) {
          //万券出金に対応していない
          return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
        }
      }
      if (((AcxCom.ifAcbSelect() != 0 & CoinChanger.ACB_50_X) ||
          (AcxCom.ifAcbSelect() != 0 & CoinChanger.ECS_X)) &&
          (cBuf.iniMacInfo.acx_flg.acb50_ssw24_0 == 1)) {
        if (cMem.ent.tencnt > 6) {
          //設定にて6桁出金可能
          return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
        }
      }
      else {
        if (cMem.ent.tencnt > 5) {
          //万券出金可能
          return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
        }
      }
    }
    return (Typ.OK);
  }

  ///  関連tprxソース: rcky_out.c - rcUpdate_CashRecycle
  static Future<void> rcUpdateCashRecycle() async {
    T111000 ttlBk = T111000();
    int errNo, errNo2;
    String callFunc = 'rcUpdateCashRecycle';

    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
    }
    RxCommonBuf cBuf = xRetC.object;
    RegsMem regsMem = SystemFunc.readRegsMem();
    ttlBk = regsMem.tTtllog.t111000;
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); /* Ttl Buffer All Clear */
    await RcItmDsp.dualTSingleCshrDspClr();

    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_OUT_FLAG; /* OUT flag */
    rcUpdatePrnTypeEdit(PrnterControlTypeIdx.TYPE_CASHRECYCLE_OUT.index);
    regsMem.tTtllog.t105300.outCd = FuncKey.KY_CASHRECYCLE_OUT.keyId;
    errNo = await RcAcracb.rcAcrAcbStockUpdate(1);
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();

    errNo = Typ.OK;
    errNo2 = Typ.OK;
    await RcCashRecycle.rcCashRecycleBeforeShtSet();
    regsMem.tTtllog.t111000 = ttlBk;

    //出金実績(t105300)
    regsMem.tTtllog.t105300.outCd = FuncKey.KY_CASHRECYCLE_OUT.keyId;
    regsMem.tTtllog.t105300Sts.chgInoutAmt =
        regsMem.tTtllog.t111000.sht10000 * 10000
            + regsMem.tTtllog.t111000.sht5000 * 5000
            + regsMem.tTtllog.t111000.sht2000 * 2000
            + regsMem.tTtllog.t111000.sht1000 * 1000
            + regsMem.tTtllog.t111000.sht500 * 500
            + regsMem.tTtllog.t111000.sht100 * 100
            + regsMem.tTtllog.t111000.sht50 * 50
            + regsMem.tTtllog.t111000.sht10 * 10
            + regsMem.tTtllog.t111000.sht5 * 5
            + regsMem.tTtllog.t111000.sht1 * 1;
    regsMem.tTtllog.t105300Sts.mny10000Sht = regsMem.tTtllog.t111000.sht10000;
    regsMem.tTtllog.t105300Sts.mny5000Sht = regsMem.tTtllog.t111000.sht5000;
    regsMem.tTtllog.t105300Sts.mny2000Sht = regsMem.tTtllog.t111000.sht2000;
    regsMem.tTtllog.t105300Sts.mny1000Sht = regsMem.tTtllog.t111000.sht1000;
    regsMem.tTtllog.t105300Sts.mny500Sht = regsMem.tTtllog.t111000.sht500;
    regsMem.tTtllog.t105300Sts.mny100Sht = regsMem.tTtllog.t111000.sht100;
    regsMem.tTtllog.t105300Sts.mny50Sht = regsMem.tTtllog.t111000.sht50;
    regsMem.tTtllog.t105300Sts.mny10Sht = regsMem.tTtllog.t111000.sht10;
    regsMem.tTtllog.t105300Sts.mny5Sht = regsMem.tTtllog.t111000.sht5;
    regsMem.tTtllog.t105300Sts.mny1Sht = regsMem.tTtllog.t111000.sht1;

    regsMem.tTtllog.t105300.sht10000 = regsMem.tTtllog.t105300Sts.mny10000Sht;
    regsMem.tTtllog.t105300.sht5000 = regsMem.tTtllog.t105300Sts.mny5000Sht;
    regsMem.tTtllog.t105300.sht2000 = regsMem.tTtllog.t105300Sts.mny2000Sht;
    regsMem.tTtllog.t105300.sht1000 = regsMem.tTtllog.t105300Sts.mny1000Sht;
    regsMem.tTtllog.t105300.sht500 = regsMem.tTtllog.t105300Sts.mny500Sht;
    regsMem.tTtllog.t105300.sht100 = regsMem.tTtllog.t105300Sts.mny100Sht;
    regsMem.tTtllog.t105300.sht50 = regsMem.tTtllog.t105300Sts.mny50Sht;
    regsMem.tTtllog.t105300.sht10 = regsMem.tTtllog.t105300Sts.mny10Sht;
    regsMem.tTtllog.t105300.sht5 = regsMem.tTtllog.t105300Sts.mny5Sht;
    regsMem.tTtllog.t105300.sht1 = regsMem.tTtllog.t105300Sts.mny1Sht;
    rcUpdateDiffEditOut();

    regsMem.tTtllog.t111000.inoutTyp = 1;
    regsMem.tTtllog.t111000.inoutCnt = 1;
    regsMem.tTtllog.t111000.ttlAmt = regsMem.tTtllog.t105300Sts.chgInoutAmt;
    if (CashRecycleData().chgout != 0) {
      regsMem.tTtllog.t111000.exchgFlg = 1;
      regsMem.prnrBuf.crinfo.chgout_amt = CashRecycleData().chgout_amt;
    }
    else {
      regsMem.tTtllog.t111000.exchgFlg = 0;
      regsMem.prnrBuf.crinfo.chgout_amt = 0;
    }

    regsMem.prnrBuf.opeStaffName = "";
    regsMem.prnrBuf.opeStaffName = CashRecycleData().staff_name;

    regsMem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
    -regsMem.tTtllog.t105300Sts.chgInoutAmt;
    //在高実績のky_cdとamt_cnt作成
    RcAtct.rcAmtKyCdMakeTtlLog();

    errNo2 = await RcFncChk.rcChkRPrinter();
    if (errNo2 == Typ.OK) {
      AtSingl atSingle = SystemFunc.readAtSingl();
      atSingle.rctChkCnt = 0;
      await RcExt.rxChkModeSet("rcUpdateCashRecycle");
      CalcResultChanger retData = await RcClxosChanger.changerOut(cBuf);
      errNo2 = retData.retSts!;
      if (0 == errNo2) {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
      }
    }
    AcMem cMem = SystemFunc.readAcMem();
    if ((cMem.ent.errNo = RcIfEvent.rcSendUpdate()) == Typ.OK) {
      if (errNo != Typ.OK) {
        cMem.ent.errNo = errNo;
      }
      else if (errNo2 != Typ.OK) {
        cMem.ent.errNo = errNo2;
      }
    }
    await RcRecno.rcIncRctJnlNo(true);
    if ((errNo != Typ.OK) || (errNo2 == Typ.OK) || (cMem.ent.errNo != Typ.OK)) {
      rcEndKyOut();
      await RcExt.rxChkModeReset("rcUpdateCashRecycle");
    }
    else {
      RckyRpr.rcWaitResponce(FuncKey.KY_CASHRECYCLE_OUT.keyId);
    }
  }

  //キー使用不可確認関数
  ///  関連tprxソース: rcky_out.c - rcChk_rcKyOut_MechaKeysCheck
  static Future<int> rcChkrcKyOutMechaKeysCheck() async {
    int errNo = 0;

// #if RESERV_SYSTEM
    if (await rcReservOutChk() || await RcAdvanceOut.rcChkAdvanceOut()) {
      myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChkrcKyOutMechaKeysCheck : RESERV_SYSTEM Non Check");
      return errNo; //チェック未対応
    }
// #endif

    if (await rcDrwchgOutChk()) {
      myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChkrcKyOutMechaKeysCheck : rcDrwchgOutChk Non Check");
      return errNo; //チェック未対応
    }

    AcMem cMem = SystemFunc.readAcMem();

    if (await CmCksys.cmNetDoAreservSystem() != 0 &&
        (cMem.stat.fncCode == FuncKey.KY_OUT14.keyId)) {
      errNo = await rcCheckKyNetDoARsvOut(1);
      return errNo;
    }

    errNo = await rcCheckKyOut(1);
    if (errNo == 0) {
      errNo = rcChkLumpOut(1);
    }

    return errNo;
  }
  static void rckyOutClose() {
  }
}
