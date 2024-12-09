/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/sys/ex/L_tprdlg.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc28stlinfo.dart';
import 'package:flutter_pos/app/regs/checker/rc_ewdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rcic_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rcid_com.dart';
import 'package:flutter_pos/app/regs/checker/rcky_cha.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/checker/rckycrdtvoid.dart';
import 'package:flutter_pos/app/regs/checker/rcqc_com.dart';
import 'package:flutter_pos/app/regs/checker/rcsg_icdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcspvt_trm.dart';
import 'package:flutter_pos/app/regs/inc/rc_mem.dart';
import 'package:flutter_pos/app/regs/inc/rc_regs.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/colorfont/c_basecolor.dart';
import '../inc/L_rcspvt.dart';
import '../inc/rc_crdt.dart';
import 'rc_multi.dart';
import 'rc_qc_dsp.dart';
import 'rc_set.dart';
import 'rcfcl_com.dart';
import 'rcfncchk.dart';
import 'rcky_rfdopr.dart';
import 'rcky_clr.dart';
import 'rcstlfip.dart';
import 'rcsyschk.dart';
import 'rcut_com.dart';

// todo: TS_BUFのメモリ書き込み処理を忘れずに！
// todo: メッセージは言語ラベルの仕組みを使う

///  関連tprxソース: rcquicpay_com.c
class RcQuicPayCom {

/*----------------------------------------------------------------------*
 *                        Prototype definitions
 *----------------------------------------------------------------------*/
  static const int _OK = 0;
  static const int _NG = 1;
  static int _rcGtktimerQp = -1;
  static const int _QUICPAY_REQ_EVENT = 300;

  // static String _POP_MSG_SPVT_AGAIN = "もう一度同じカードを\nタッチして下さい";
  // static String _MSG_IC_AUTHORI = "問い合わせ中";
  // static String _POP_MSG_SPVT_FIRST = "最初にタッチしたカードを\nタッチして下さい";
  //
/*----------------------------------------------------------------------*
 *                        Main Program
 *----------------------------------------------------------------------*/
  ///  関連tprxソース: rcquicpay_com.c - rcGtkTimerAdd_QP
  static int rcGtkTimerAddQP(int timer, Function func) {
    if (_rcGtktimerQp != -1) {
      return(DlgConfirmMsgKind.MSG_SYSERR.dlgId);
    }
    _rcGtktimerQp = Fb2Gtk.gtkTimeoutAdd(timer, func, 0);
    return(_OK);
    }

  ///  関連tprxソース: rcquicpay_com.c - rcGtkTimerRemove_QP
  static int rcGtkTimerRemoveQP() {
    if(_rcGtktimerQp != -1) {
      Fb2Gtk.gtkTimeoutRemove(_rcGtktimerQp);
      rcGtkTimerInitQP();
    }
    return(_OK);
  }

  ///  関連tprxソース: rcquicpay_com.c - rcGtkTimerInit_QP
  static void rcGtkTimerInitQP() {
    _rcGtktimerQp = -1;
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_MainProc
  static Future<void> rcMultiQPMainProc(int funcCd) async {

    int errNo;
    String log = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiQPMainProc() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;
    AcMem cMem = SystemFunc.readAcMem();
    const callFunction = "rcMultiQPMainProc"; //＿FUNCTION＿

    atSing.othcntEjecterrChk = 0;
    switch(MultiQPTerminal.getDefine(await RcSysChk.rcChkMultiQPSystem()))
    {
      case MultiQPTerminal.QP_FAP_USE:
        if(await RcFncChk.rcCheckCrdtVoidSMode()) {
          errNo = _OK; /* 先にチェックするので、ここではチェックしない */
        }
        else {
          errNo = RcFclCom.rcChkFclStat();
        }
        if(errNo != _OK) {
          await RcIfEvent.rxChkTimerAdd();
          await RcExt.rcErr(callFunction, errNo);
          return;
        }
        await RcKyccin.rcOthConnectAcrAcbStop();
        RcEwdsp.rcErrNoBz(DlgConfirmMsgKind.MSG_NOWWAIT);
        await RcExt.rxChkModeSet(callFunction);
        rcGtkTimerRemoveQP();
        if(RcFclCom.rcChkFclSeqOver() != _OK) {
          await rcSetFapQPReduceData();
          cMem.ent.errNo = rcGtkTimerAddQP(_QUICPAY_REQ_EVENT, RcQuicPayCom.rcMultiQPReduceAct);
        }
        else {
          await rcSetFapQPCommonData();
          tsBuf.multi.order = FclProcNo.FCL_I_START.index;
          cMem.ent.errNo = rcGtkTimerAddQP(_QUICPAY_REQ_EVENT, RcQuicPayCom.rcChkFapQPStatR);
        }
        if(cMem.ent.errNo != 0) {
          await rcMultiQPTimrErr();
        }
        break;
      case MultiQPTerminal.QP_UT_USE  :
      case MultiQPTerminal.QP_VEGA_USE  :
        if(await RcFncChk.rcCheckCrdtVoidSMode()) {
          errNo = _OK; /* 先にチェックするので、ここではチェックしない */
        }
        else if((await CmCksys.cmYunaitoHdSystem() != 0)
            && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
            || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true))) {
          errNo = _OK; /* 先にチェックするので、ここではチェックしない */
        }
        else {
          errNo = RckyRfdopr.rcChkUtStat(MultiUseBrand.QP_OPERATION.index);
        }
        if(errNo != _OK) {
          await RcIfEvent.rxChkTimerAdd();

          await RcExt.rcErr(callFunction, errNo);
          return;
        }
        atSing.othcntEjecterrChk = 1;
        errNo = await RcKyccin.rcOthConnectAcrAcbStop();
        if(errNo != _OK) {
          log = sprintf("%s : QP not use !! because acracbstop err [%d]\n", [callFunction, errNo]);
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, log);
          await RcIfEvent.rxChkTimerAdd();

          return;
        }

        RcEwdsp.rcErrNoBz(DlgConfirmMsgKind.MSG_NOWWAIT);

        if (RcSysChk.rcChkMultiVegaSystem() != 0) {
          atSing.multiVegaWaitFlg = 1;
          if (await RcSysChk.rcQCChkQcashierSystem() == true) {
            await RcExt.rxChkModeReset(callFunction);
          }
          else {
            await RcExt.rxChkModeSet(callFunction);
          }
        }
        else {
          await RcExt.rxChkModeSet(callFunction);
        }

        rcGtkTimerRemoveQP();

        await rcSetFapQPReduceData();
        cMem.ent.errNo = rcGtkTimerAddQP(_QUICPAY_REQ_EVENT, RcQuicPayCom.rcMultiQPReduceAct);
        if(cMem.ent.errNo != 0) {
          await rcMultiQPTimrErr();
        }
        break;
      default :
        errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
        await RcExt.rcErr(callFunction, errNo);
        break;
    }
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_Cancel_Proc
  static Future<void> rcMultiQPCancelProc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiQPCancelProc() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    tsBuf.multi.flg |= 0x01;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");
    return;
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_Before_Tran
  static Future<void> rcMultiQPBeforeTran() async {
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      RcSGIcDsp.rcSGICMainBtnHide();
    }
    else {
      RcIcDsp.rcICMainBtnHide();
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "rxTaskStatRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    atSingl.spvtData.oldStep = FclStepNo.FCL_STEP_WAIT.value;
    atSingl.spvtData.checkSt = FclStep2No.FCL_STEP2_NORMAL.index;
    tsBuf.multi.order = FclProcNo.FCL_Q_TRAN_START.index;
    cMem.ent.errNo = rcGtkTimerAddQP(RcQuicPayCom._QUICPAY_REQ_EVENT, rcMultiQPBeforeTranAct() as Function);
    if (cMem.ent.errNo != 0) {
      rcMultiQPTimrErr();
    }
    return;
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_TimrErr
  static Future<void> rcMultiQPTimrErr() async {

    const callFunction = "rcMultiQPTimrErr"; //＿FUNCTION＿

    TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, "rcMultiQP_TimrErr()");
    rcGtkTimerRemoveQP();
    AcMem cMem = SystemFunc.readAcMem();
    await RcExt.rcErr(callFunction, cMem.ent.errNo);
    await RcIfEvent.rxChkTimerAdd();
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();
    if(ifSave.count > 0) {
      ifSave.count = 0;
    }
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_ActLog_Write
  static Future<void> rcMultiQPActLogWrite(int stat, int logType) async {

    String log = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiQPActLogWrite() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    FclProcNo orderDefine =  FclProcNo.getDefine(tsBuf.multi.order);
    if(await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_FAP_USE.index) {
      switch(FclProcNo.getDefine(stat))
      {
        case FclProcNo.FCL_T_START :
          log = sprintf("FCL[QUICPay] reduce_act -> multi.order [%s:%d], multi.step [%d], multi.step2 [%d]",
            [orderDefine.name, tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        case FclProcNo.FCL_Q_TRAN_START :
          log =sprintf("FCL[QUICPay] beforetran_act -> multi.order [%s:%d], multi.step [%d], multi.step2 [%d]\n",
            [orderDefine.name,tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        case FclProcNo.FCL_U_OFF_START :
          log = sprintf("FCL[QUICPay] tr_end_act -> multi.order [%s:%d], multi.step [%d], multi.step2 [%d]\n",
            [orderDefine.name,tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        default :
          return;
      }
      if(logType == LogLevelDefine.normal) {
        TprLog().logAdd(Tpraid.TPRAID_MULTI, LogLevelDefine.normal, log);
      }
      else {
        TprLog().logAdd(Tpraid.TPRAID_MULTI, LogLevelDefine.error, log);
      }
    }
    else if ((await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_UT_USE.index)
        || (await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_VEGA_USE.index)) {
      switch(FclProcNo.getDefine(stat))
      {
        case FclProcNo.FCL_T_START :
          log = sprintf("UT/VEGA[QUICPay] reduce_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        case FclProcNo.FCL_Q_TRAN_START :
          log = sprintf("UT/VEGA[QUICPay] beforetran_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        case FclProcNo.FCL_U_OFF_START :
          log = sprintf("UT/VEGA[QUICPay] tr_end_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        default :
          return;
      }
      if(logType == LogLevelDefine.normal) {
        TprLog().logAdd(Tpraid.TPRAID_MULTI, LogLevelDefine.normal, log);
      }
      else {
        TprLog().logAdd(Tpraid.TPRAID_MULTI, LogLevelDefine.error, log);
      }
    }
  }

 /*----------------------------------------------------------------------*
 *                        Program [FAP-10]
 *----------------------------------------------------------------------*/
  ///  関連tprxソース: rcquicpay_com.c - rcSet_FapQP_CommonData
  static Future<void> rcSetFapQPCommonData() async {
    await RcFclCom.rcClrFclMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFapQPCommonData() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    tsBuf.multi.step = FclStepNo.FCL_STEP_WAIT.value;
    tsBuf.multi.fclData.skind = FclService.FCL_QP;
    if(RcSysChk.rcVDOpeModeChk()) {
      tsBuf.multi.fclData.tKind = 1;
    }
    else if ((await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_VEGA_USE.index)
        && await RcFncChk.rcCheckCrdtVoidSMode())
    {
      tsBuf.multi.fclData.tKind = 1;
    }
    else if((await CmCksys.cmYunaitoHdSystem() != 0)
      && (await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_VEGA_USE.index)
      && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
      || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true) ) )
    {
      tsBuf.multi.fclData.tKind = 1;
    }
    else {
      tsBuf.multi.fclData.tKind = 0;
    }
    if(RcSysChk.rcTROpeModeChk()) {
      tsBuf.multi.fclData.mode = 3;
    }
    else {
      tsBuf.multi.fclData.mode = 1;
    }
    return;
  }

  ///  関連tprxソース: rcquicpay_com.c - rcSet_FapQP_ReduceData
  static Future<void> rcSetFapQPReduceData() async {
    RxMemRet xRet1 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet1.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFapQPReduceData() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet1.object;

    const callFunction = "rcSetFapQPReduceData"; //＿FUNCTION＿
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;

    int payPrice = RcCrdt.getPayPrice();

    if(await RcFncChk.rcCheckCrdtVoidSMode()) {
      TprDlg.tprLibDlgClear(callFunction);
    }
    else if((await CmCksys.cmYunaitoHdSystem() != 0)
        && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
            || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true)))
    {
      TprDlg.tprLibDlgClear(callFunction);
    }
    else {
      RckyClr.rcClearPopDisplay();
    }
    await RcExt.rcClearErrStat(callFunction);
    atSing.spvtData.oldStep = FclStepNo.FCL_STEP_WAIT.value;
    atSing.spvtData.checkSt = FclStep2No.FCL_STEP2_NORMAL.index;
    await rcSetFapQPCommonData();
    await rcSetFapQPTranData(payPrice);

    if (RcSysChk.rcChkMultiVegaSystem() != 0
      && (await RcSysChk.rcSGChkSelfGateSystem() == true
      || await RcSysChk.rcQCChkQcashierSystem() == true)) {
      await RcSGIcDsp.rcSGICDisplay(0, payPrice, FclService.FCL_QP.index);
    }
    else if(await RcSysChk.rcSGChkSelfGateSystem() == true) {
      await  RcSet.rcQPScrMode();
      await RcSGIcDsp.rcSGICDisplay(0, payPrice, FclService.FCL_QP.index);
    }
    else {
      if(await RcFncChk.rcCheckCrdtVoidSMode() == true) {
        await  RcSet.rcQPScrMode();
        await RcIcDsp.rcICDisplay(FuncKey.KY_CRDTVOID.keyId, payPrice);
      }
      else if((await CmCksys.cmYunaitoHdSystem() != 0)
        && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
        || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true))) {
        await RcSet.rcQPScrMode();
        if(RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true) {
          await RcIcDsp.rcICDisplay(FuncKey.KY_RCPT_VOID.keyId, payPrice);
        }
        else {
          await RcIcDsp.rcICDisplay(FuncKey.KY_RFDOPR.keyId, payPrice);
        }
      }
      else {
        if(await RcSysChk.rcSysChkHappySmile()) {
          Rc28StlInfo.colorFipWindowDestroy();
          AcMem cMem = SystemFunc.readAcMem();
          cMem.stat.happySmileScrmode = RcRegs.RG_QC_QP_DSP;
          await RcSet.rcQPScrMode();
          RcQcDsp.rcQCPayDsp();
          await RcIcDsp.rcICDisplay(0, payPrice);
        }
        else {
          await RcSet.rcQPScrMode();
          await RcIcDsp.rcICDisplay(0, payPrice);
        }
      }
      if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
        RcStFip.rcFIPReverseTran(RcRegs.FIP_NO2.toString(), payPrice);
        RcStFip.rcFIPStartScroll(RcRegs.FIP_NO2.toString(),
          ImageDefinitions.IMG_MULTI_MESSAGE1, ImageDefinitions.IMG_MULTI_MESSAGE3);
      }
      else {
        RcStFip.rcFIPReverseTran(RcRegs.FIP_NO1.toString(), payPrice);
        RcStFip.rcFIPStartScroll(RcRegs.FIP_NO1.toString(),
          ImageDefinitions.IMG_MULTI_MESSAGE1, ImageDefinitions.IMG_MULTI_MESSAGE3);
      }
    }

    tsBuf.multi.order = FclProcNo.FCL_T_START.index;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");

  }

  ///  関連tprxソース: rcquicpay_com.c - rcChk_FapQP_Stat_R
  static Future<void> rcChkFapQPStatR() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // int errNo = 0;
    // rcGtkTimerRemoveQP();
    //
    // final result = await RcSysChk.rcChkMultiiDSystem();
    // switch (MultiQPTerminal.getDefine(result)) {
    //   case MultiQPTerminal.QP_FAP_USE:
    //     errNo = RcFclCom.rcSetFclErrCode(FclProcNo.FCL_I_START.index,
    //         MultiUseBrand.QP_OPERATION.index);
    //     break;
    //   case MultiQPTerminal.QP_UT_USE:
    //     errNo = await RcutCom.rcSetUtErrCode(FclProcNo.FCL_I_START.index,
    //         MultiUseBrand.QP_OPERATION.index);
    //     break;
    //   default:
    //     errNo = DlgConfirmMsgKind.MSG_CHKSETTING.dlgId;
    //     break;
    // }
    //
    // if (errNo == OK) {
    //   RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    //   if (xRet.isInvalid()) {
    //     return;
    //   }
    //   RxTaskStatBuf tsBuf = xRet.object;
    //   AcMem cMem = SystemFunc.readAcMem();
    //   if (tsBuf.multi.order == FclProcNo.FCL_I_END.index) {
    //     rcSetFapQPReduceData();
    //     cMem.ent.errNo = rcGtkTimerAddQP(QP_REQ_EVENT, rcMultiQPReduceAct() as Function);
    //     if (cMem.ent.errNo != 0) {
    //       rcMultiQPTimrErr();
    //     }
    //   }
    //   else {
    //     cMem.ent.errNo = rcGtkTimerAddQP(QP_REQ_EVENT, rcChkFapQPStatR() as Function);
    //     if (cMem.ent.errNo != 0) {
    //       rcMultiQPTimrErr();
    //     }
    //   }
    // }
    // else {
    //   if (await RcFncChk.rcCheckCrdtVoidSMode()) {
    // TprDlg.tprLibDlgClear("rcChkFapiDStatR");
    // }
    // else if (await CmCksys.cmYunaitoHdSystem() != 0
    // && (RckyRfdopr.rcRfdOprCheckAllRefundMode()
    // || RckyRfdopr.rcRfdOprCheckRcptVoidMode()) ){
    // TprDlg.tprLibDlgClear("rcChkFapiDStatR");
    // }
    // else {
    // RckyClr.rcClearPopDisplay();
    // }
    // RcExt.rcClearErrStat("rcChkFapiDStatR");
    // rcMultiQPErrProc(errNo);
    // }
    // return;
  }

  ///  関連tprxソース: rcquicpay_com.c - rcSet_FapQP_TranData
  static Future<void> rcSetFapQPTranData(int payPrc) async {
    String slipNo;
    String icNo;
    String buf = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFapQPTranData() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;

    switch (MultiQPTerminal.getDefine(await RcSysChk.rcChkMultiQPSystem()))
    {
      case MultiQPTerminal.QP_FAP_USE:
        tsBuf.multi.fclData.sndData.printNo = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
        break;
      case MultiQPTerminal.QP_UT_USE:
      case MultiQPTerminal.QP_VEGA_USE:
        buf = await RcutCom.rcSetUtSeqNo();
        tsBuf.multi.fclData.sndData.printNo = int.tryParse(buf) ?? 0;
        break;
      default:
        break;
    }
    tsBuf.multi.fclData.sndData.ttlAmt = payPrc;
    if (RcSysChk.rcVDOpeModeChk()
      || ((await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_VEGA_USE.index) && await RcFncChk.rcCheckCrdtVoidSMode() )
      || ((await CmCksys.cmYunaitoHdSystem() != 0)
      && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
      || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true) ) ) )
    {
      slipNo = '0';
      icNo   = '0';
      if (await CmCksys.cmUt1QUICPaySystem() != 0 || await CmCksys.cmMultiVegaSystem() != 0)
      {
        slipNo = atSing.spvtData.slipNo;
        tsBuf.multi.fclData.sndData.canSlipNo = int.parse(slipNo);

        icNo = atSing.spvtData.icNo;
        tsBuf.multi.fclData.sndData.canIcNo = int.parse(icNo);
      }
      else {
        icNo = atSing.spvtData.icNo;
        tsBuf.multi.fclData.sndData.canIcNo = int.parse(icNo);
      }
    }
    return;
  }

/*----------------------------------------------------------------------*
 *                        Common Program [FAP-10] [PFM-10]
 *----------------------------------------------------------------------*/
  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_Reduce_Act
  static Future<void> rcMultiQPReduceAct() async {
    int errNo;
    int nearChk;
    String  log = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiQPReduceAct() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;

    rcGtkTimerRemoveQP();
    nearChk = 0;
    switch(MultiQPTerminal.getDefine(await RcSysChk.rcChkMultiQPSystem()))
    {
      case MultiQPTerminal.QP_FAP_USE :
        errNo = await RcFclCom.rcSetFclErrCode(FclProcNo.FCL_T_START.index,
            MultiUseBrand.QP_OPERATION.index);
        break;
      case MultiQPTerminal.QP_UT_USE :
      case MultiQPTerminal.QP_VEGA_USE :
        errNo = await RcutCom.rcSetUtErrCode(FclProcNo.FCL_T_START.index,
            MultiUseBrand.QP_OPERATION.index);
        if(errNo == _OK) {
          if ((tsBuf.multi.flg & 0x10 == 0x10) && (atSing.spvtData.tranEnd == 0)) {
            nearChk = 1;
          }
        }
        break;
      default         :
        errNo = DlgConfirmMsgKind.MSG_CHKSETTING.dlgId;
        break;
    }
    if(errNo == _OK) {
      switch(FclProcNo.getDefine(tsBuf.multi.order))
      {
        case FclProcNo.FCL_T_END :
          if (await RcSysChk.rcSysChkHappySmile()) {
            // TODO:00005 田中:rcQCMovieStartが実装されたら有効化すること
            // RcQcCom.rcQCMovieStop();
          }

          if(nearChk == 1) {
            log = "UT[QUICPay] reduce_act -> NearEnd Message !!\n";
            TprLog().logAdd(Tpraid.TPRAID_MULTI, LogLevelDefine.normal, log);
            await RcIcDsp.rcICChgMsg(BaseColor.attentionColor, LTprDlg.ER_MSG_TEXT104, addMode: true);
            atSing.spvtData.tranEnd = 1;
            AcMem cMem = SystemFunc.readAcMem();
            cMem.ent.errNo = rcGtkTimerAddQP((_QUICPAY_REQ_EVENT)*10, RcQuicPayCom.rcMultiQPReduceAct);
            if(cMem.ent.errNo != 0) {
              await rcMultiQPTimrErr();
            }
            break;
          }
          else {
            await rcMultiQPActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
            atSing.spvtData.tranEnd = 1;
            await rcMultiQPEndProc();
            break;
          }
          case FclProcNo.FCL_T_CAN_END :
            await rcMultiQPActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
            if(tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_TOUCH.value) {
              if(tsBuf.multi.step2 == FclStep2No.FCL_STEP2_RETOUCH.index) {
                // タッチしてください中のエラー.
                await RcSpvtTrn.rcSPVTAlarmTran(FclStep2No.FCL_STEP2_RETOUCH.index, MultiUseBrand.QP_OPERATION.index);
              }
            }
            if(await RcSysChk.rcQCChkQcashierSystem()) {
              if(RcFncChk.rcQCCheckQPMode()) { //リード画面
                RcQcDsp.rcQCBackBtnFunc();
              }
            }
            await rcMultiQPEndProc();
            break;
          case FclProcNo.FCL_T_END_TRAN :
            await rcMultiQPActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
            if (RcSysChk.rcChkMultiVegaSystem() != 0
                && (await RcSysChk.rcSGChkSelfGateSystem() == true
                || await RcSysChk.rcQCChkQcashierSystem() == true)) {
              RcSGIcDsp.rcSGICConf(FclProcNo.FCL_T_END_TRAN.index);
            }
            else if (await RcSysChk.rcSGChkSelfGateSystem() == true) {
              RcSGIcDsp.rcSGICConf(FclProcNo.FCL_T_END_TRAN.index);
            }
            else {
              RcIcDsp.rcICConf(FclProcNo.FCL_T_END_TRAN.index);
            }
            break;
          default :
            if (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_TOUCH.value) {
              switch(FclStep2No.getDefine(tsBuf.multi.step2)) {
                case FclStep2No.FCL_STEP2_RETOUCH :
                  await rcMultiQPActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
                  if(atSing.spvtData.checkSt != tsBuf.multi.step2) {
                    atSing.spvtData.checkSt = tsBuf.multi.step2;
                    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
                      RcStFip.rcFIPStartScroll(RcRegs.FIP_NO2.toString(),
                        ImageDefinitions.IMG_MULTI_MESSAGE2, ImageDefinitions.IMG_MULTI_MESSAGE3);
                    }
                    else {
                      RcStFip.rcFIPStartScroll(RcRegs.FIP_NO1.toString(),
                        ImageDefinitions.IMG_MULTI_MESSAGE2, ImageDefinitions.IMG_MULTI_MESSAGE3);
                    }
                    if (RcSysChk.rcChkMultiVegaSystem() != 0
                        && (await RcSysChk.rcSGChkSelfGateSystem() == true
                        || await RcSysChk.rcQCChkQcashierSystem() == true)) {
                      RcSGIcDsp.rcSGICChgMsg(BaseColor.attentionColor, LRcSpvt.POP_MSG_SPVT_AGAIN);
                    }
                    else if(await RcSysChk.rcSGChkSelfGateSystem() == true) {
                      RcSGIcDsp.rcSGICChgMsg(BaseColor.attentionColor, LRcSpvt.POP_MSG_SPVT_AGAIN);
                    }
                    else {
                      await RcIcDsp.rcICChgMsg(BaseColor.attentionColor, LRcSpvt.POP_MSG_SPVT_AGAIN);
                    }
                  }
                  break;
                case FclStep2No.FCL_STEP2_AUT :
                  await rcMultiQPActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
                  if(atSing.spvtData.checkSt != tsBuf.multi.step2) {
                    atSing.spvtData.checkSt = tsBuf.multi.step2;
                    if (RcSysChk.rcChkMultiVegaSystem() != 0
                        && (await RcSysChk.rcSGChkSelfGateSystem() == true
                        || await RcSysChk.rcQCChkQcashierSystem() == true)) {
                      RcSGIcDsp.rcSGICMainBtnHide();
                      RcSGIcDsp.rcSGICChgMsg(BaseColor.baseColor, LRcSpvt.MSG_IC_AUTHORI);
                    }
                    else if(await RcSysChk.rcSGChkSelfGateSystem()) {
                      RcSGIcDsp.rcSGICMainBtnHide();
                      RcSGIcDsp.rcSGICChgMsg(BaseColor.baseColor, LRcSpvt.MSG_IC_AUTHORI);
                    }
                    else {
                      RcIcDsp.rcICMainBtnHide();
                      await RcIcDsp.rcICChgMsg(BaseColor.baseColor, LRcSpvt.MSG_IC_AUTHORI);
                    }
                  }
                  break;
                case FclStep2No.FCL_STEP2_FIRSTCARD :
                  await rcMultiQPActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
                  if(atSing.spvtData.checkSt != tsBuf.multi.step2) {
                    atSing.spvtData.checkSt = tsBuf.multi.step2;
                    if (RcSysChk.rcChkMultiVegaSystem() != 0
                        && (await RcSysChk.rcSGChkSelfGateSystem() == true
                        || await RcSysChk.rcQCChkQcashierSystem() == true)) {
                      //rcSG_IC_MainBtn_Show();
                      RcSGIcDsp.rcSGICChgMsg(BaseColor.accentsColor, LRcSpvt.POP_MSG_SPVT_FIRST);
                    }
                    else if(await RcSysChk.rcSGChkSelfGateSystem()) {
                      RcSGIcDsp.rcSGICMainBtnShow();
                      RcSGIcDsp.rcSGICChgMsg(BaseColor.accentsColor, LRcSpvt.POP_MSG_SPVT_FIRST);
                    }
                    else {
                      RcIcDsp.rcICMainBtnShow();
                      await RcIcDsp.rcICChgMsg(BaseColor.accentsColor, LRcSpvt.POP_MSG_SPVT_FIRST);
                    }
                  }
                  break;
              default:
                break;
              }
            }
            AcMem cMem = SystemFunc.readAcMem();
            cMem.ent.errNo = rcGtkTimerAddQP(_QUICPAY_REQ_EVENT, RcQuicPayCom.rcMultiQPReduceAct);
            if(cMem.ent.errNo != 0) {
              await rcMultiQPTimrErr();
            }
            break;
        }
      }
      else {
        await rcMultiQPActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
        await rcMultiQPErrProc(errNo);
      }
    return;
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_BeforeTran_Act
  static Future<void> rcMultiQPBeforeTranAct() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    int errNo = 0;

    rcGtkTimerRemoveQP();
    final result = await RcSysChk.rcChkMultiQPSystem();
    switch (MultiQPTerminal.getDefine(result)) {
      case MultiQPTerminal.QP_FAP_USE:
        errNo = await RcFclCom.rcSetFclErrCode(FclProcNo.FCL_Q_TRAN_START.index,
                                          MultiUseBrand.QP_OPERATION.index);
        break;
      case MultiQPTerminal.QP_UT_USE:
      case MultiQPTerminal.QP_VEGA_USE:
        errNo = await RcutCom.rcSetUtErrCode(FclProcNo.FCL_Q_TRAN_START.index,
                                             MultiUseBrand.QP_OPERATION.index);
      default:
        errNo = DlgConfirmMsgKind.MSG_CHKSETTING.dlgId;
        break;
    }

    if (errNo == _OK) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "rxTaskStatRead error");
        return;
      }
      RxTaskStatBuf tsBuf = xRet.object;
      AcMem cMem = SystemFunc.readAcMem();

      if (tsBuf.multi.order == FclProcNo.FCL_Q_TRAN_END_OK.index) {
        rcMultiQPActLogWrite(FclProcNo.FCL_Q_TRAN_START.index, LogLevelDefine.normal);
        if (RcSysChk.rcChkMultiVegaSystem() != 0
            && (await RcSysChk.rcSGChkSelfGateSystem()
                || await RcSysChk.rcQCChkQcashierSystem()) ) {
          RcSGIcDsp.rcSGICConf(_OK);
        }
        else if (await RcSysChk.rcSGChkSelfGateSystem()) {
          RcSGIcDsp.rcSGICConf(_OK);
        }
        else {
          RcIcDsp.rcICConf(_OK);
        }
      }
      else if (tsBuf.multi.order == FclProcNo.FCL_Q_TRAN_END_NG.index) {
        rcMultiQPActLogWrite(FclProcNo.FCL_Q_TRAN_START.index, LogLevelDefine.normal);
        if (RcSysChk.rcChkMultiVegaSystem() != 0
            && (await RcSysChk.rcSGChkSelfGateSystem()
                || await RcSysChk.rcQCChkQcashierSystem()) ) {
          RcSGIcDsp.rcSGICConf(_NG);
        }
        else if (await RcSysChk.rcSGChkSelfGateSystem()) {
          RcSGIcDsp.rcSGICConf(_NG);
        }
        else {
          RcIcDsp.rcICConf(_NG);
        }
      }
      else if (tsBuf.multi.order == FclProcNo.FCL_Q_TRAN_END_ALARM.index) {
        rcMultiQPActLogWrite(FclProcNo.FCL_Q_TRAN_START.index, LogLevelDefine.normal);
        RcSpvtTrn.rcSPVTAlarmTran(FclStep2No.FCL_STEP2_RETOUCH.index,
                                  MultiUseBrand.QP_OPERATION.index);
        if (RcSysChk.rcChkMultiVegaSystem() != 0
            && (await RcSysChk.rcSGChkSelfGateSystem()
                || await RcSysChk.rcQCChkQcashierSystem()) ) {
          RcSGIcDsp.rcSGICConf(_NG);
        }
        else if (await RcSysChk.rcSGChkSelfGateSystem()) {
          RcSGIcDsp.rcSGICConf(_NG);
        }
        else {
          RcIcDsp.rcICConf(_NG);
        }
      }
      else {
        cMem.ent.errNo = rcGtkTimerAddQP(_QUICPAY_REQ_EVENT,
                                        rcMultiQPBeforeTranAct() as Function);
        if (cMem.ent.errNo != 0) {
          rcMultiQPTimrErr();
        }
      }
    }
    else {
      rcMultiQPActLogWrite(FclProcNo.FCL_Q_TRAN_START.index, LogLevelDefine.error);
      rcMultiQPErrProc(errNo);
    }
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_EndProc
  static Future<void> rcMultiQPEndProc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiQPEndProc() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;

    rcGtkTimerRemoveQP();

    switch(MultiQPTerminal.getDefine(await RcSysChk.rcChkMultiQPSystem()))
    {
      case MultiQPTerminal.QP_FAP_USE :
      if (RcSysChk.rcTROpeModeChk()) {
        tsBuf.multi.order = FclProcNo.FCL_U_OFF_START.index;
        cMem.ent.errNo = rcGtkTimerAddQP(_QUICPAY_REQ_EVENT, RcQuicPayCom.rcMultiQPTREndProc);
        if(cMem.ent.errNo != 0) {
          await rcMultiQPTimrErr();
        }
      }
      else {
        await rcMultiQPTranEnd();
      }
      break;

      case MultiQPTerminal.QP_VEGA_USE:
      if (atSing.spvtData.tranEnd == 1) {
        if (await RcSysChk.rcSysChkHappySmile()) {
          // 精算機以外の場合、サイン省略・・・の店舗控えが印字される為、対面の場合は店員確認画面を表示する
          cMem.stat.orgFncCode = cMem.stat.fncCode;
          RcidCom.rcPostPaySignDialog(DlgConfirmMsgKind.MSG_CRDTNOTE_SIGN3.dlgId);
        }
        else {
          await rcMultiQPTranEnd();
        }
      }
      else {
        await rcMultiQPTranEnd();
      }
      break;

      default :
        await rcMultiQPTranEnd();
        break;
    }
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_TranEnd
  static Future<void> rcMultiQPTranEnd() async {

    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiQPTranEnd() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_VEGA_USE.index) {
      if (atSing.spvtData.tranEnd == 1) {
        // スキャンなどで上書きされた場合を考慮
        cMem.stat.fncCode = RcQcDsp.rcGetQPFncCode();
      }
    }

    if (RcSysChk.rcChkMultiVegaSystem() != 0 && await RcSysChk.rcSysChkHappySmile()) {
      if(atSing.spvtData.tranEnd == 1) {
        RcQcDsp.rcQCPayEndDisp();
      }
    }

    if (RcSysChk.rcChkMultiVegaSystem() != 0
        && (await RcSysChk.rcSGChkSelfGateSystem() == true || await RcSysChk.rcQCChkQcashierSystem() == true)) {
     await RcSGIcDsp.rcSGICDispEnd();
    }
    else if(await RcSysChk.rcSGChkSelfGateSystem() == true) {
     await RcSGIcDsp.rcSGICDispEnd();
    }
    else {
      await RcIcDsp.rcICDispEnd();
    }

    if (atSing.spvtData.tranEnd == 1) {
      if(await RcFncChk.rcCheckCrdtVoidSMode()) {
        await RcKyCrdtVoid.rcCrdtVoidPostPayEnd();
      }
      else if ((await CmCksys.cmYunaitoHdSystem() != 0)
          && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
          || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true))) {
        if (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true) {
          await RcKyCrdtVoid.rcCrdtVoidPostPayEnd();
        }
        else {
          await RcKyCrdtVoid.rcCrdtVoidPostPayEnd();
        }
      }
      else {
        await RckyCha.rcChargeAmount1();
      }
    }
    else {
      await RcIfEvent.rxChkTimerAdd();
      if (await RcFncChk.rcCheckCrdtVoidSMode()) {
        RcKyCrdtVoid.rcCrdtVoidActFlgReset();
      }
      else if ((await CmCksys.cmYunaitoHdSystem() != 0)
          && ( (RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
          || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true) ) ) {
        RcKyCrdtVoid.rcCrdtVoidActFlgReset();
      }
      else {
        RcSet.rcClearEntry();
        RcItmDsp.rcEntryOutPut();
        RcRegs.kyStR0(cMem.keyStat, FncCode.KY_ENT.keyId);
      }
    }
    tsBuf.multi.order = FclProcNo.FCL_NOT_ORDER.index;
    atSing.spvtData = SpvtData();
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_ErrProc
  static Future<void> rcMultiQPErrProc(int errNo) async {

    const callFunction = "rcMultiQPErrProc"; //＿FUNCTION＿
    rcGtkTimerRemoveQP();
    await RcIfEvent.rxChkTimerAdd();

    if(await RcFncChk.rcCheckCrdtVoidSMode()) {
      RcKyCrdtVoid.rcCrdtVoidActFlgReset();
    }
    else if((await CmCksys.cmYunaitoHdSystem() != 0)
        && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
        || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true) ) )
    {
      await rcMultiQPTranEnd();
    }

    await RcExt.rcErr(callFunction, errNo);
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiQP_TR_EndProc
  static Future<void> rcMultiQPTREndProc() async {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiQPTREndProc() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    rcGtkTimerRemoveQP();
    if (tsBuf.multi.order == FclProcNo.FCL_NOT_ORDER.index) {
      await rcMultiQPActLogWrite(FclProcNo.FCL_U_OFF_START.index, LogLevelDefine.normal);
      await rcMultiQPTranEnd();
    }
    else if (tsBuf.multi.order == FclProcNo.FCL_U_OFF_END.index) {
      await rcMultiQPActLogWrite(FclProcNo.FCL_U_OFF_START.index, LogLevelDefine.normal);
      tsBuf.multi.order = FclProcNo.FCL_NOT_ORDER.index;
      cMem.ent.errNo = rcGtkTimerAddQP(_QUICPAY_REQ_EVENT, RcQuicPayCom.rcMultiQPTREndProc);
      if (cMem.ent.errNo != 0) {
        await rcMultiQPTimrErr();
      }
    }
    else {
      await rcMultiQPActLogWrite(FclProcNo.FCL_U_OFF_START.index, LogLevelDefine.normal);
      cMem.ent.errNo = rcGtkTimerAddQP(_QUICPAY_REQ_EVENT, RcQuicPayCom.rcMultiQPTREndProc);
      if(cMem.ent.errNo != 0) {
        await rcMultiQPTimrErr();
      }
    }
  }

/* end of rcquicpay_com.c */

}