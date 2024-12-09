/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../tprlib/TprLibDlg.dart';
import '../inc/L_rc_acb_stopdsp.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import '../../inc/lib/typ.dart';

///  関連tprxソース: rc_acb_stopdsp.c
class RcAcbStopdsp {
  // TODO: 中間 釣機関数実装のため、定義のみ追加
  static int rcAcbStopdsp = -1;
  static int oldScrMode = 0;
  static int oldBkScrMode = 0;

  ///  関連tprxソース: rc_acb_stopdsp.c - rc_acb_stopdsp_Draw
  static Future<int> rcAcbStopDspDraw() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcAcbStopDspDraw() : rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();

    if (!await RcFncChk.rcCheckAcbStopDsp()) {
      return 0;
    }
    if ((RcFncChk.rcChkErr() != 0) ||
        (TprLibDlg.tprLibDlgCheck2(1) != 0)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcAcbStopDsp() err not disp");
      return 0;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcAcbStopDsp() DISP");

    if (FbInit.subinitMainSingleSpecialChk()) {
      cMem.stat.dualTSingle = pCom.devId;
    } else {
      cMem.stat.dualTSingle = 0;
    }

    await RcExt.cashStatSet("rcAcbStopDspDraw");
    rcAcbStopDspModeSet();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
        if (FbInit.subinitMainSingleSpecialChk()) {
          rcLcdStopDspMsgDisp();
          rcAcbStopDspBtnDraw();
        } else {
          if ((iBuf.devInf.devId == TprDidDef.TPRDIDTOUKEY1) ||
              (iBuf.devInf.devId == TprDidDef.TPRDIDMECKEY1)) {
            rcLcdStopDspMsgDisp();
          } else {
            rcAcbStopDspBtnDraw();
          }
        }
        break;
      default:
        rcAcbStopDspBtnDraw();
        break;
    }
    return 0;
  }

  ///  関連tprxソース: rc_acb_stopdsp.c - rc_acb_stopdspMode_Set
  static Future<void>	rcAcbStopDspModeSet() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        oldScrMode = cMem.stat.scrMode;
        oldBkScrMode = cMem.stat.bkScrMode;
        RcSet.rcAcbStopDspScrMode();
        break;
    }
  }

  /// 処理概要：10.4 inch not main display is message display
  ///  関連tprxソース: rc_acb_stopdsp.c - rcLcd_StopDsp_MsgDisp
  static Future<void>	rcLcdStopDspMsgDisp() async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.scrData.msgLcd = LRcAcbStopDsp.ACB_STOPDSP_SUBMSG;
    if (FbInit.subinitMainSingleSpecialChk()) {
      if (cMem.stat.dualTSingle == 1) {
        RcItmDsp.dualTSingleDlgHW(cMem.scrData.msgLcd, 0, 0);
      } else {
        RcItmDsp.dualTSingleDlgHW(cMem.scrData.msgLcd, 1, 0);
      }
    } else {
      RcItmDsp.rcLcdPrice();
      await RcItmDsp.rcQtyClr();
    }
  }

  // TODO:00016 佐藤 定義のみ追加
  ///  関連tprxソース: rc_acb_stopdsp.c - rc_acb_stopdspBtn_Draw
  static void	rcAcbStopDspBtnDraw() {
  }
  
  ///  関連tprxソース: rc_acb_stopdsp.c - rcacb_stopdsp_totalchk
  static Future<int> rcacbStopdspTotalchk() async {
    if (rcAcbStopdsp != -1) {
      // gtk_timeout_remove is not available in Dart
      rcAcbStopdsp = -1;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,"rcacb_stopdsp_totalchk()");
    if (rcAcrAcbStopWindowCheck() != Typ.OK) {
      // gtk_timeout_add is not available in Dart
      rcAcbStopdsp = 0; // Replace with appropriate timer implementation in Dart
      return 0;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,"rcacb_stopdsp_totalchk() show btn_end2");
    // Replace with appropriate code to show btn_end2 in Dart
    return 0;
  }
  
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_StopWindow_Check
  static int rcAcrAcbStopWindowCheck() {
    return 0;
  }

}