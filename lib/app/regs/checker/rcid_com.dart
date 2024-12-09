/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/image.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc28stlinfo.dart';
import 'package:flutter_pos/app/regs/checker/rc_crdt_fnc.dart';
import 'package:flutter_pos/app/regs/checker/rc_ewdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_multi.dart';
import 'package:flutter_pos/app/regs/checker/rc_qc_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_usbcam.dart';
import 'package:flutter_pos/app/regs/checker/rcfcl_com.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcic_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rcky_cha.dart';
import 'package:flutter_pos/app/regs/checker/rcky_clr.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfdopr.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/checker/rckycrdtvoid.dart';
import 'package:flutter_pos/app/regs/checker/rcsg_icdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcspvt_trm.dart';
import 'package:flutter_pos/app/regs/checker/rcstlfip.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/checker/rcut_com.dart';
import 'package:flutter_pos/app/regs/inc/L_rcspvt.dart';
import 'package:sprintf/sprintf.dart';

import '../../fb/fb2gtk.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_fcl.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/colorfont/c_basecolor.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

/// 関連tprxソース:rcid_com.c
class RcidCom {
/*----------------------------------------------------------------------*
 *                        Define Data
 *----------------------------------------------------------------------*/
  static const int ID_REQ_EVENT = 300;

   static const int FALSE = 0;
   static const int TRUE = 1;
   static const int OK = 0;
   static const int NG = 1;

   static int rcGtktimerId = -1;

  static int pinLimit = 0;

/*----------------------------------------------------------------------*
 *                        Main Program
 *----------------------------------------------------------------------*/

   /// 関連tprxソース:rcid_com.c - rcGtkTimerAdd_iD()
   static int rcGtkTimerAddID(int timer, Function func) {
     if (rcGtktimerId != -1) {
       return (DlgConfirmMsgKind.MSG_SYSERR.dlgId);
     }
     rcGtktimerId = Fb2Gtk.gtkTimeoutAdd(timer, func, 0);
     return (OK);
   }

   /// 関連tprxソース:rcid_com.c - rcGtkTimerRemove_iD()
   static int rcGtkTimerRemoveID() {
     if (rcGtktimerId != -1) {
       Fb2Gtk.gtkTimeoutRemove(rcGtktimerId);
       rcGtkTimerInitID();
     }
     return (OK);
   }

   /// 関連tprxソース:rcid_com.c - rcGtkTimerInit_iD()
   static void rcGtkTimerInitID() {
     rcGtktimerId = -1;
   }

  /// 関連tprxソース:rcid_com.c - rcMultiiD_MainProc()
  static Future<void> rcMultiiDMainProc(int funcCd) async {

    int errNo;
    String log = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiiDMainProc() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();

    atSing.saveAcbTotalPrice = 0;
    AcMem cMem = SystemFunc.readAcMem();
    const String callFunction = "rcMultiiDMainProc";

    atSing.othcntEjecterrChk = 0;
    pinLimit = 0;
    switch (MultiIDTerminal.getDefine(await RcSysChk.rcChkMultiiDSystem())) {
      case MultiIDTerminal.ID_FAP_USE:
        if (await RcFncChk.rcCheckCrdtVoidSMode()) {
          errNo = OK; /* 先にチェックするので、ここではチェックしない */
        }
        else {
          errNo = RcFclCom.rcChkFclStat();
        }
        if (errNo != OK) {
          await RcIfEvent.rxChkTimerAdd();
          await RcExt.rcErr(callFunction, errNo);
          return;
        }
        await RcKyccin.rcOthConnectAcrAcbStop();
        RcEwdsp.rcErrNoBz(DlgConfirmMsgKind.MSG_NOWWAIT);
        await RcExt.rxChkModeSet(callFunction);
        rcGtkTimerRemoveID();
        if (RcFclCom.rcChkFclSeqOver() != OK) {
          await rcSetFapiDReduceData();
          cMem.ent.errNo = rcGtkTimerAddID(ID_REQ_EVENT, rcMultiiDReduceAct);
        }
        else {
          await rcSetFapiDCommonData();
          tsBuf.multi.order = FclProcNo.FCL_I_START.index;
          cMem.ent.errNo = rcGtkTimerAddID(ID_REQ_EVENT, rcChkFapiDStatR);
        }
        if (cMem.ent.errNo != 0) {
          rcMultiiDTimrErr();
          break;
        }
      case MultiIDTerminal.ID_UT_USE:
      case MultiIDTerminal.ID_VEGA_USE:
        if (await RcFncChk.rcCheckCrdtVoidSMode()) {
          errNo = OK; /* 先にチェックするので、ここではチェックしない */
        }
        else if ((await CmCksys.cmYunaitoHdSystem() != 0)
            && ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true)
            || (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true))) {
          errNo = OK; /* 先にチェックするので、ここではチェックしない */
        }
        else {
          errNo = RcutCom.rcChkUtStat(MultiUseBrand.ID_OPERATION.index);
        }
        if (errNo != OK) {
          await RcIfEvent.rxChkTimerAdd();
          await RcExt.rcErr(callFunction, errNo);
          return;
        }
        atSing.othcntEjecterrChk = 1;
        errNo = await RcKyccin.rcOthConnectAcrAcbStop();
        if (errNo != OK) {
          log = sprintf("%s : iD not use !! because acracbstop err [%d]\n", [callFunction, errNo]);
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
          await RcIfEvent.rxChkTimerAdd();
          return;
        }

        RcEwdsp.rcErrNoBz(DlgConfirmMsgKind.MSG_NOWWAIT);

        if (RcSysChk.rcChkMultiVegaSystem() != 0) {
          atSing.multiVegaWaitFlg = 1;
          if (await RcSysChk.rcQCChkQcashierSystem()) {
            await RcExt.rxChkModeReset(callFunction);
          }
          else {
            await RcExt.rxChkModeSet(callFunction);
          }
        }
        else {
          await RcExt.rxChkModeSet(callFunction);
        }

        rcGtkTimerRemoveID();
        await rcSetFapiDReduceData();
        cMem.ent.errNo = rcGtkTimerAddID(ID_REQ_EVENT, rcMultiiDReduceAct);
        if (cMem.ent.errNo != 0) {
          rcMultiiDTimrErr();
        }
        break;
      default         :
        errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
        await RcExt.rcErr(callFunction, errNo);
        break;
    }
  }

  /// 関連tprxソース:rcid_com.c - rcMultiiD_TimrErr()
  static void rcMultiiDTimrErr() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
  }

  /// 関連tprxソース:rcid_com.c - rcMultiiD_ActLog_Write()
  static void rcMultiiDPinAgain()  {
    // TODO:10121 QUICPay、iD 202404実装対象外

  }

  /// 関連tprxソース:rcid_com.c - rcMultiiD_ActLog_Write()
  static Future<void> rcMultiiDActLogWrite(int stat, int logType) async {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiiDActLogWrite() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    String log = "";

    if (await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_FAP_USE.index) {
      switch(FclProcNo.getDefine(stat))
      {
        case FclProcNo.FCL_T_START:
          log = sprintf("FCL[iD] reduce_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        case FclProcNo.FCL_Q_TRAN_START:
          log = sprintf("FCL[iD] beforetran_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        case FclProcNo.FCL_U_OFF_START:
          log = sprintf("FCL[iD] tr_end_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        default               :
          return;
      }
      if (logType == LogLevelDefine.normal) {
        TprLog().logAdd(await RcSysChk.getTid(), logType, log);
      }
      else {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      }
    }
    else if ((await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_UT_USE.index)
        || (await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_VEGA_USE.index)) {
      switch(FclProcNo.getDefine(stat))
      {
        case FclProcNo.FCL_T_START:
          log = sprintf("UT[iD] reduce_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        case FclProcNo.FCL_Q_TRAN_START:
          log = sprintf("UT[iD] beforetran_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        case FclProcNo.FCL_U_OFF_START:
          log = sprintf("UT[iD] tr_end_act -> multi.order [%d], multi.step [%d], multi.step2 [%d]\n",
            [tsBuf.multi.order, tsBuf.multi.step, tsBuf.multi.step2]);
          break;
        default:
          return;
      }
      if (logType == LogLevelDefine.normal) {
        TprLog().logAdd(await RcSysChk.getTid(), logType, log);
      }
      else {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      }
    }
  }

/*----------------------------------------------------------------------*
 *                        Program [FAP-10]
 *----------------------------------------------------------------------*/

  /// 関連tprxソース:rcid_com.c - rcSet_FapiD_CommonData()
  static Future<void> rcSetFapiDCommonData() async {
    await RcFclCom.rcClrFclMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFapiDCommonData() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    tsBuf.multi.step = FclStepNo.FCL_STEP_WAIT.index;
    tsBuf.multi.fclData.skind = FclService.FCL_ID;
    if (RcSysChk.rcVDOpeModeChk()) {
      tsBuf.multi.fclData.tKind = 1;
    }
    else if ((await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_VEGA_USE.index)
        && await RcFncChk.rcCheckCrdtVoidSMode()) {
      tsBuf.multi.fclData.tKind = 1;
    }
    else if ((await CmCksys.cmYunaitoHdSystem() != 0)
        && (await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_VEGA_USE.index)
        && ((RckyRfdopr.rcRfdOprCheckAllRefundMode())
        || (RckyRfdopr.rcRfdOprCheckRcptVoidMode()) )) {
      tsBuf.multi.fclData.tKind = 1;
    }
    else {
      tsBuf.multi.fclData.tKind = 0;
    }

    if (RcSysChk.rcTROpeModeChk()) {
      tsBuf.multi.fclData.mode = 3;
    }
    else {
      tsBuf.multi.fclData.mode = 1;
    }
    return;
  }

  /// 関連tprxソース:rcid_com.c - rcSet_FapiD_ReduceData()
  static Future<void> rcSetFapiDReduceData() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFapiDReduceData() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    const String callFunction = "rcSetFapiDReduceData";
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;


    if (await RcFncChk.rcCheckCrdtVoidSMode()) {
      TprDlg.tprLibDlgClear(callFunction);
    }
    else if ((await CmCksys.cmYunaitoHdSystem() != 0)
        && ((RckyRfdopr.rcRfdOprCheckAllRefundMode())
        || (RckyRfdopr.rcRfdOprCheckRcptVoidMode()))) {
      TprDlg.tprLibDlgClear(callFunction);
    }
    else {
      RckyClr.rcClearPopDisplay();
    }
    await RcExt.rcClearErrStat(callFunction);
    atSing.spvtData.oldStep = FclStepNo.FCL_STEP_WAIT.index;
    atSing.spvtData.checkSt = FclStep2No.FCL_STEP2_NORMAL.index;
    await rcSetFapiDCommonData();
    await rcSetFapiDTranData(RcCrdtFnc.payPrice());

    if (RcSysChk.rcChkMultiVegaSystem() != 0
        && (await RcSysChk.rcSGChkSelfGateSystem() || await RcSysChk.rcQCChkQcashierSystem())) {
      await RcSGIcDsp.rcSGICDisplay(0, RcCrdtFnc.payPrice(), FclService.FCL_ID.index);
    }
    else if (await RcSysChk.rcSGChkSelfGateSystem()) {
      await RcSet.rciDScrMode();
      await RcSGIcDsp.rcSGICDisplay(0, RcCrdtFnc.payPrice(), FclService.FCL_ID.index);
    }
    else {
      if(await RcFncChk.rcCheckCrdtVoidSMode()) {
        await RcSet.rciDScrMode();
        await RcIcDsp.rcICDisplay(FuncKey.KY_CRDTVOID.keyId, RcCrdtFnc.payPrice());
      }
      else if ((await CmCksys.cmYunaitoHdSystem() != 0)
          && ((RckyRfdopr.rcRfdOprCheckAllRefundMode())
          || (RckyRfdopr.rcRfdOprCheckRcptVoidMode()))) {
        await RcSet.rciDScrMode();
        if(RckyRfdopr.rcRfdOprCheckRcptVoidMode()) {
          await RcIcDsp.rcICDisplay(FuncKey.KY_RCPT_VOID.index, RcCrdtFnc.payPrice());
        }
        else {
          await RcIcDsp.rcICDisplay(FuncKey.KY_RFDOPR.index, RcCrdtFnc.payPrice());
        }
      }
      else {
        if (await RcSysChk.rcSysChkHappySmile()) {
          Rc28StlInfo.colorFipWindowDestroy();
          cMem.stat.happySmileScrmode = RcRegs.RG_QC_ID_DSP;
          await RcSet.rciDScrMode();
          RcQcDsp.rcQCPayDsp();
          await RcIcDsp.rcICDisplay(0, RcCrdtFnc.payPrice());
        }
        else {
          await RcSet.rciDScrMode();
          await RcIcDsp.rcICDisplay(0, RcCrdtFnc.payPrice());
        }
      }
      if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
        RcStFip.rcFIPReverseTran(RcRegs.FIP_NO2.toString(), RcCrdtFnc.payPrice());
        RcStFip.rcFIPStartScroll(RcRegs.FIP_NO2.toString(),
            ImageDefinitions.IMG_MULTI_MESSAGE1, ImageDefinitions.IMG_MULTI_MESSAGE3);
      }
      else {
        RcStFip.rcFIPReverseTran(RcRegs.FIP_NO1.toString(), RcCrdtFnc.payPrice());
        RcStFip.rcFIPStartScroll(RcRegs.FIP_NO1.toString(),
            ImageDefinitions.IMG_MULTI_MESSAGE1, ImageDefinitions.IMG_MULTI_MESSAGE3);
      }
    }

    tsBuf.multi.order = FclProcNo.FCL_T_START.index;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");
  }

  /// 関連tprxソース:rcid_com.c - rcChk_FapiD_Stat_R()
  static Future<void> rcChkFapiDStatR() async {
    ///TODO: 20240410日計対応 対象外のためコメントアウト
    // int errNo = 0;
    // rcGtkTimerRemoveID();
    //
    // final result = await RcSysChk.rcChkMultiiDSystem();
    // switch (MultiIDTerminal.getDefine(result)) {
    //   case MultiIDTerminal.ID_FAP_USE:
    //     errNo = RcFclCom.rcSetFclErrCode(FclProcNo.FCL_I_START.index,
    //                                     MultiUseBrand.ID_OPERATION.index);
    //     break;
    //   case MultiIDTerminal.ID_UT_USE:
    //     errNo = await RcutCom.rcSetUtErrCode(FclProcNo.FCL_I_START.index,
    //                                    MultiUseBrand.ID_OPERATION.index);
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
    //     rcSetFapiDReduceData();
    //     cMem.ent.errNo = rcGtkTimerAddID(ID_REQ_EVENT, rcMultiiDReduceAct() as Function);
    //     if (cMem.ent.errNo != 0) {
    //       rcMultiiDTimrErr();
    //     }
    //   }
    //   else {
    //     cMem.ent.errNo = rcGtkTimerAddID(ID_REQ_EVENT, rcChkFapiDStatR() as Function);
    //     if (cMem.ent.errNo != 0) {
    //       rcMultiiDTimrErr();
    //     }
    //   }
    // }
    // else {
    //   if (await RcFncChk.rcCheckCrdtVoidSMode()) {
    //     TprDlg.tprLibDlgClear("rcChkFapiDStatR");
    //   }
    //   else if (await CmCksys.cmYunaitoHdSystem() != 0
    //           && (RckyRfdopr.rcRfdOprCheckAllRefundMode()
    //             || RckyRfdopr.rcRfdOprCheckRcptVoidMode()) ){
    //     TprDlg.tprLibDlgClear("rcChkFapiDStatR");
    //   }
    //   else {
    //     RckyClr.rcClearPopDisplay();
    //   }
    //   RcExt.rcClearErrStat("rcChkFapiDStatR");
    //   rcMultiiDErrProc(errNo);
    // }
    return;
  }

  /// 関連tprxソース:rcid_com.c - rcSet_FapiD_TranData()
  static Future<void> rcSetFapiDTranData(int payPrc)  async {

    String icNo;
    String buf;
    RxMemRet xRet1 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet1.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFapiDTranData() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet1.object;
    RxMemRet xRet2 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet2.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFapiDTranData() rxMemRead error\n");
      return ;
    }
    RxCommonBuf cBuf = xRet2.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;
    AcMem cMem = SystemFunc.readAcMem();

    switch (MultiIDTerminal.getDefine(await RcSysChk.rcChkMultiiDSystem())) {
      case MultiIDTerminal.ID_FAP_USE:
        tsBuf.multi.fclData.sndData.printNo =
          await Counter.competitionGetRcptNo(await RcSysChk.getTid());
        break;
      case MultiIDTerminal.ID_UT_USE:
      case MultiIDTerminal.ID_VEGA_USE:
        buf = await RcutCom.rcSetUtSeqNo();
        tsBuf.multi.fclData.sndData.printNo = int.parse(buf);
        break;
      default:
        break;
    }
    tsBuf.multi.fclData.sndData.ttlAmt  = payPrc;
    tsBuf.multi.fclData.sndData.cardId = "";
    if (await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_VEGA_USE.index) {
      tsBuf.multi.fclData.sndData.pluCd = 0x00.toString();
    }
    else {
      tsBuf.multi.fclData.sndData.pluCd = "0";
    }
    if (cBuf.dbTrm.itemCode != 0) {
      buf = cBuf.dbTrm.itemCode.toString().padLeft(8,'0');
      tsBuf.multi.fclData.sndData.pluCd = buf;
    }

    if (RcSysChk.rcVDOpeModeChk()
        || ((await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_VEGA_USE.index)
        && await RcFncChk.rcCheckCrdtVoidSMode())
        || ((await CmCksys.cmYunaitoHdSystem() != 0)
        && ((RckyRfdopr.rcRfdOprCheckAllRefundMode())
        || (RckyRfdopr.rcRfdOprCheckRcptVoidMode())))) {
      icNo = atSing.spvtData.icNo;
      tsBuf.multi.fclData.sndData.canSlipNo = int.parse(icNo);
      if (cMem.working.crdtReg.stat & 0x0080 == 0x0080) {

        tsBuf.multi.fclData.sndData.cKind = 1; /* 取消 */
      }
      else {
        tsBuf.multi.fclData.sndData.cKind = 2; /* 返品 */
      }
    }
  }

/*----------------------------------------------------------------------*
 *                        Common Program [FAP-10] [PFM-10]
 *----------------------------------------------------------------------*/

  /// 関連tprxソース:rcid_com.c - rcMultiiD_Reduce_Act()
  static Future<void> rcMultiiDReduceAct() async {

    int errNo = 0;
    int nearChk;
    String log = "";
    String fipNo = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiiDReduceAct() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      fipNo = RcRegs.FIP_NO2.toString();
    }
    else {
      fipNo = RcRegs.FIP_NO1.toString();
    }
    rcGtkTimerRemoveID();

    nearChk = 0;
    switch (MultiIDTerminal.getDefine(await RcSysChk.rcChkMultiiDSystem())) {
      case MultiIDTerminal.ID_FAP_USE:
        errNo = await RcFclCom.rcSetFclErrCode(
            FclProcNo.FCL_T_START.index, MultiUseBrand.ID_OPERATION.index);
        break;
      case MultiIDTerminal.ID_UT_USE:
      case MultiIDTerminal.ID_VEGA_USE:
        errNo = await RcutCom.rcSetUtErrCode(
            FclProcNo.FCL_T_START.index, MultiUseBrand.ID_OPERATION.index);
        if (errNo == OK) {
          if ((tsBuf.multi.flg & 0x10 == 0x10) && (atSing.spvtData.tranEnd == 0)) {
            nearChk = 1;
          }
        }
        break;
      default         :
        errNo = DlgConfirmMsgKind.MSG_CHKSETTING.dlgId;
        break;
    }
    if (errNo == OK) {
      switch (FclProcNo.getDefine(tsBuf.multi.order)) {
        case FclProcNo.FCL_T_END:
          if (await RcSysChk.rcSysChkHappySmile()) {
            // TODO:00005 田中:rcQCMovieStartが実装されたら有効化すること
            // RcUsbCam.rcQCMovieStop();
          }
          if (nearChk == 1) {
            log = "UT[iD] reduce_act -> NearEnd Message !!\n";
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            await RcIcDsp.rcICChgMsg(BaseColor.attentionColor, LTprDlg.ER_MSG_TEXT104, addMode: true);
            atSing.spvtData.tranEnd = 1;
            cMem.ent.errNo = rcGtkTimerAddID((ID_REQ_EVENT)*10, rcMultiiDReduceAct);
            if (cMem.ent.errNo != 0) {
              rcMultiiDTimrErr();
            }
            break;
          }
          else {
            await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
            atSing.spvtData.tranEnd = 1;
            await rcMultiiDEndProc();
            break;
          }
        case FclProcNo.FCL_T_CAN_END:
          await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
          if (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_TOUCH.index) {
            if (tsBuf.multi.step2 == FclStep2No.FCL_STEP2_RETOUCH.index) {
              await RcSpvtTrn.rcSPVTAlarmTran(
              FclStep2No.FCL_STEP2_RETOUCH.index, MultiUseBrand.ID_OPERATION.index);
            }
          }
          if (await RcSysChk.rcQCChkQcashierSystem()) {
            if (await RcFncChk.rcQCCheckIDMode()) { //リード画面
              RcQcDsp.rcQCBackBtnFunc();
            }
          }
          await rcMultiiDEndProc();
          break;
        case FclProcNo.FCL_T_END_PIN:
          await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
          if (atSing.spvtData.oldStep != tsBuf.multi.order) {
            atSing.spvtData.oldStep = tsBuf.multi.order;
            if (pinLimit < 3) {
              pinLimit++;
              if (RcSysChk.rcChkMultiVegaSystem() != 0
                  && (await RcSysChk.rcSGChkSelfGateSystem()
                  || await RcSysChk.rcQCChkQcashierSystem())) {
                RcSGIcDsp.rcSGICSelectAct();
              }
              else if (await RcSysChk.rcSGChkSelfGateSystem()) {
                RcSGIcDsp.rcSGICSelectAct();
              }
              else {
                RcIcDsp.rcICSelectAct();
              }
            }
            else {
              pinLimit = 0;
              if (RcSysChk.rcChkMultiVegaSystem() != 0
                  && (await RcSysChk.rcSGChkSelfGateSystem()
                  || await RcSysChk.rcQCChkQcashierSystem())) {
                RcSGIcDsp.rcSGICConf(FclProcNo.FCL_T_END_PIN.index);
              }
              else if (await RcSysChk.rcSGChkSelfGateSystem()) {
                RcSGIcDsp.rcSGICConf(FclProcNo.FCL_T_END_PIN.index);
              }
              else {
                RcIcDsp.rcICConf(FclProcNo.FCL_T_END_PIN.index);
              }
            }
          }
          break;
        default:
        if (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_TOUCH.index) {
          switch (FclStep2No.getDefine(tsBuf.multi.step2)) {
            case FclStep2No.FCL_STEP2_RETOUCH:
              await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
              if (atSing.spvtData.checkSt != tsBuf.multi.step2) {
                atSing.spvtData.checkSt = tsBuf.multi.step2;
                RcStFip.rcFIPStartScroll(
                  fipNo, ImageDefinitions.IMG_MULTI_MESSAGE2,
                  ImageDefinitions.IMG_MULTI_MESSAGE3);
                if (RcSysChk.rcChkMultiVegaSystem() != 0
                    && (await RcSysChk.rcSGChkSelfGateSystem()
                    || await RcSysChk.rcQCChkQcashierSystem())) {
                  RcSGIcDsp.rcSGICChgMsg(BaseColor.attentionColor, LRcSpvt.POP_MSG_SPVT_AGAIN);
                }
                else if (await RcSysChk.rcSGChkSelfGateSystem()) {
                  RcSGIcDsp.rcSGICChgMsg(BaseColor.attentionColor, LRcSpvt.POP_MSG_SPVT_AGAIN);
                }
                else {
                  await RcIcDsp.rcICChgMsg(BaseColor.attentionColor, LRcSpvt.POP_MSG_SPVT_AGAIN);
                }
              }
              break;
            case FclStep2No.FCL_STEP2_AUT:
              await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
              if (atSing.spvtData.checkSt != tsBuf.multi.step2) {
                atSing.spvtData.checkSt = tsBuf.multi.step2;
                if (RcSysChk.rcChkMultiVegaSystem() != 0
                    && (await RcSysChk.rcSGChkSelfGateSystem()
                    || await RcSysChk.rcQCChkQcashierSystem()
                    || await RcSysChk.rcSysChkHappySmile())) {
                  RcSGIcDsp.rcSGICMainBtnHide();
                  RcSGIcDsp.rcSGICChgMsg(BaseColor.baseColor, LRcSpvt.MSG_IC_AUTHORI);

                  if (await RcSysChk.rcSysChkHappySmile()) {
                    RcIcDsp.rcICMainBtnHide();
                    await  RcIcDsp.rcICChgMsg(BaseColor.baseColor, LRcSpvt.MSG_IC_AUTHORI);
                  }
                }
                else if (await RcSysChk.rcSGChkSelfGateSystem()) {
                  RcSGIcDsp.rcSGICMainBtnHide();
                  RcSGIcDsp.rcSGICChgMsg(BaseColor.baseColor, LRcSpvt.MSG_IC_AUTHORI);
                }
                else {
                  RcIcDsp.rcICMainBtnHide();
                  await  RcIcDsp.rcICChgMsg(BaseColor.baseColor, LRcSpvt.MSG_IC_AUTHORI);
                }
              }
              break;
            case FclStep2No.FCL_STEP2_PIN:
              await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
              if (atSing.spvtData.checkSt != tsBuf.multi.step2) {
                atSing.spvtData.checkSt = tsBuf.multi.step2;
                RcStFip.rcFIPStartScroll(fipNo,
                  ImageDefinitions.IMG_MULTI_MESSAGE1, ImageDefinitions.IMG_PIN_NO_INPUT);
                if (RcSysChk.rcChkMultiVegaSystem() != 0
                    && (await RcSysChk.rcSGChkSelfGateSystem()
                    || await RcSysChk.rcQCChkQcashierSystem() || await RcSysChk.rcSysChkHappySmile())) {
                  rcQCClearMovie();
                  RcQcDsp.rcQCDspDestroy();     /* 新規に画面生成行うため */
                  RcQcDsp.rcQCPayDsp();

                  RcSGIcDsp.rcSGICChgMsg(BaseColor.accentsColor, LRcSpvt.MSG_IC_PIN);

                  if (await RcSysChk.rcSysChkHappySmile()) {
                    await RcIcDsp.rcICChgMsg(BaseColor.accentsColor, LRcSpvt.MSG_IC_PIN);
                  }
                }
                else if (await RcSysChk.rcSGChkSelfGateSystem()) {
                  RcSGIcDsp.rcSGICChgMsg(BaseColor.accentsColor, LRcSpvt.MSG_IC_PIN);
                }
                else {
                  await RcIcDsp.rcICChgMsg(BaseColor.accentsColor, LRcSpvt.MSG_IC_PIN);
                }
              }
              break;
            case FclStep2No.FCL_STEP2_REPIN:
              await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
              if (atSing.spvtData.checkSt != tsBuf.multi.step2) {
                atSing.spvtData.checkSt = tsBuf.multi.step2;
                RcStFip.rcFIPStartScroll(fipNo,
                  ImageDefinitions.IMG_MULTI_MESSAGE1, ImageDefinitions.IMG_PIN_NO_INPUT);
                if (RcSysChk.rcChkMultiVegaSystem() != 0
                    && (await RcSysChk.rcSGChkSelfGateSystem()
                    || await RcSysChk.rcQCChkQcashierSystem()
                    || await RcSysChk.rcSysChkHappySmile())) {
                  rcQCClearMovie();
                  RcQcDsp.rcQCDspDestroy();     /* 新規に画面生成行うため */
                  RcQcDsp.rcQCPayDsp();

                  RcSGIcDsp.rcSGICChgMsg(BaseColor.attentionColor, LRcSpvt.MSG_IC_PIN_AGAIN);

                  if (await RcSysChk.rcSysChkHappySmile()) {
                    await RcIcDsp.rcICChgMsg(BaseColor.attentionColor, LRcSpvt.MSG_IC_PIN_AGAIN);
                  }
                }
                else if (await RcSysChk.rcSGChkSelfGateSystem()) {
                  await RcIcDsp.rcICChgMsg(BaseColor.attentionColor, LRcSpvt.MSG_IC_PIN_AGAIN);
                }
                else {
                  await RcIcDsp.rcICChgMsg(BaseColor.attentionColor, LRcSpvt.MSG_IC_PIN_AGAIN);
                }
              }
              break;
            case FclStep2No.FCL_STEP2_FIRSTCARD:
              await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.normal);
              if (atSing.spvtData.checkSt != tsBuf.multi.step2) {
                atSing.spvtData.checkSt = tsBuf.multi.step2;
                if (RcSysChk.rcChkMultiVegaSystem() != 0
                    && (await RcSysChk.rcSGChkSelfGateSystem()
                    || await RcSysChk.rcQCChkQcashierSystem())) {
                  RcSGIcDsp.rcSGICMainBtnShow();
                  RcSGIcDsp.rcSGICChgMsg(BaseColor.accentsColor, LRcSpvt.POP_MSG_SPVT_FIRST);
                }
                else if (await RcSysChk.rcSGChkSelfGateSystem()) {
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
        cMem.ent.errNo = rcGtkTimerAddID(ID_REQ_EVENT, rcMultiiDReduceAct);
        if (cMem.ent.errNo != 0) {
          rcMultiiDTimrErr();
        }
        break;
      }
    }
    else {
      await rcMultiiDActLogWrite(FclProcNo.FCL_T_START.index, LogLevelDefine.error);
      await rcMultiiDErrProc(errNo);
    }
  }

  /// 関連tprxソース:rcid_com.c - rcMultiiD_EndProc()
  static Future<void> rcMultiiDEndProc() async {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiiDEndProc() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.saveAcbTotalPrice = 0;

    rcGtkTimerRemoveID();

    switch (MultiIDTerminal.getDefine(await RcSysChk.rcChkMultiiDSystem())) {
      case MultiIDTerminal.ID_FAP_USE:
        if(RcSysChk.rcTROpeModeChk()) {
          tsBuf.multi.order = FclProcNo.FCL_U_OFF_START.index;
          cMem.ent.errNo = rcGtkTimerAddID(ID_REQ_EVENT, rcMultiiDTREndProc);
            if(cMem.ent.errNo == 0) {
            rcMultiiDTimrErr();
          }
        }
        else {
          await rcMultiiDTranEnd();
        }
        break;
      case MultiIDTerminal.ID_VEGA_USE:
        if (atSing.spvtData.tranEnd == 1) {
          if (await RcSysChk.rcSysChkHappySmile()) {
            // 精算機以外の場合、サイン省略・・・の店舗控えが印字される為、対面の場合は店員確認画面を表示する
            cMem.stat.orgFncCode = cMem.stat.fncCode;
            rcPostPaySignDialog(DlgConfirmMsgKind.MSG_CRDTNOTE_SIGN3.dlgId);
          }
          else {
            await rcMultiiDTranEnd();
          }
        }
        else {
          await rcMultiiDTranEnd();
        }
        break;
      default :
          await rcMultiiDTranEnd();
        break;
    }
  }

  /// 関連tprxソース:rcid_com.c - rcMultiiD_TranEnd()
  static Future<void> rcMultiiDTranEnd() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem acMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiiDTranEnd() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await RcSysChk.rcChkMultiiDSystem() == MultiIDTerminal.ID_VEGA_USE.index) {
      if (atSingl.spvtData.tranEnd == 1) {
        // スキャンなどで上書きされた場合を考慮
        acMem.stat.fncCode = RcQcDsp.rcGetIDFncCode();
      }
    }
    if ((RcSysChk.rcChkMultiVegaSystem() != 0)
        && (await RcSysChk.rcSysChkHappySmile())) {
      if(atSingl.spvtData.tranEnd  == 1) {
        RcQcDsp.rcQCPayEndDisp();
      }
    }

    if ((RcSysChk.rcChkMultiVegaSystem() != 0)
        && ((await RcSysChk.rcSGChkSelfGateSystem())
            ||  (await RcSysChk.rcQCChkQcashierSystem()))) {
      await RcSGIcDsp.rcSGICDispEnd();
    } else if(await RcSysChk.rcSGChkSelfGateSystem()) {
      await RcSGIcDsp.rcSGICDispEnd();
    } else {
      await RcIcDsp.rcICDispEnd();
    }

    if (atSingl.spvtData.tranEnd == 1) {
      if (await RcFncChk.rcCheckCrdtVoidSMode()) {
        await RcKyCrdtVoid.rcCrdtVoidPostPayEnd();
      } else if ((await CmCksys.cmYunaitoHdSystem() != 0)
          && ((RckyRfdopr.rcRfdOprCheckAllRefundMode())
              ||  (RckyRfdopr.rcRfdOprCheckRcptVoidMode()))) {
        if (RckyRfdopr.rcRfdOprCheckRcptVoidMode()) {
          await RcKyCrdtVoid.rcCrdtVoidPostPayEnd();
        } else {
          await RcKyCrdtVoid.rcCrdtVoidPostPayEnd();
        }
      } else {
        await RckyCha.rcChargeAmount1();
      }
    } else {
      await RcIfEvent.rxChkTimerAdd();
      if (await RcFncChk.rcCheckCrdtVoidSMode()) {
        RcKyCrdtVoid.rcCrdtVoidActFlgReset();
      } else if ((await CmCksys.cmYunaitoHdSystem() != 0)
          && ((RckyRfdopr.rcRfdOprCheckAllRefundMode())
              ||  (RckyRfdopr.rcRfdOprCheckRcptVoidMode()))) {
        RcKyCrdtVoid.rcCrdtVoidActFlgReset();
      } else {
        RcSet.rcClearEntry();
        RcItmDsp.rcEntryOutPut();
        RcRegs.kyStR0(acMem.keyStat, FncCode.KY_ENT.keyId);
      }
    }
    tsBuf.multi.order = FclProcNo.FCL_NOT_ORDER.index;
    atSingl.spvtData = SpvtData();
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");
  }

  /// 関連tprxソース:rcid_com.c - rcMultiiD_ErrProc()
  static Future<void> rcMultiiDErrProc(int errNo) async {

    rcGtkTimerRemoveID();
    await RcIfEvent.rxChkTimerAdd();

    if (await RcFncChk.rcCheckCrdtVoidSMode()) {
      RcKyCrdtVoid.rcCrdtVoidActFlgReset();
    }
    else if ((await CmCksys.cmYunaitoHdSystem() != 0)
        && ((RckyRfdopr.rcRfdOprCheckAllRefundMode())
            || (RckyRfdopr.rcRfdOprCheckRcptVoidMode()))) {
      await rcMultiiDTranEnd();
    }

    await RcExt.rcErr("rcMultiiDErrProc", errNo);
  }

  /// 関連tprxソース:rcid_com.c - rcMultiiD_TR_EndProc()
  static void rcMultiiDTREndProc() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
  }

  /// 関連tprxソース:rcid_com.c - rcQC_Clear_Movie()
  static void rcQCClearMovie() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
  }

  /// 関連tprxソース:rcid_com.c - rcPostPay_SignDialog()
  static void rcPostPaySignDialog(int errNo) {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
  }

  ///  関連tprxソース: rcquicpay_com.c - rcMultiiD_Cancel_Proc
  static Future<void> rcMultiiDCancelProc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiiDCancelProc() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    tsBuf.multi.flg |= 0x01;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");
    return;
  }

}

