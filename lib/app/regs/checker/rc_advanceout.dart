/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcmanualmix.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

// TODO: 中間 釣機関数実装のため、必要な定義のみ追加
///  関連tprxソース: rc_advanceout.h - ADVANCEOUT
class AdvanceOut {
  int execMode = 0;
/* 0: advance input 1: advance print */
}

///  関連tprxソース: rc_advanceout.c
class RcAdvanceOut {
  static AdvanceOut advOutDsp = AdvanceOut();

  /// 関連tprxソース: rc_advanceout.c - rc_AdvanceOut_Adj()
  static Future<void> rcAdvanceOutAdj() async {
    int errorNo = await rcAdvanceOutChk();
    if (errorNo == 0) {
      rcAdvanceOutProg();
    } else {
      RcExt.rcErr("rcAdvanceOutAdj", errorNo);
    }
  }

  /// 関連tprxソース: rc_advanceout.c - rc_AdvanceOut_chk()
  static Future<int> rcAdvanceOutChk() async {
    int errorNo = 0;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (RcFncChk.rcCheckRegistration()) {
      errorNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if (RcManualMix.rcAssortManualMixChk() ||
        (mem.tmpbuf.manualMixcd != 0)) {
      errorNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        errorNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
      }
    }
    if (!((cMem.stat.opeMode == RcRegs.RG) ||
        (cMem.stat.opeMode == RcRegs.TR))) {
      errorNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }
    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        !await RcSysChk.rcCheckQCJCSystem()) {
      errorNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    return errorNo;
  }

  /// 関連tprxソース: rc_advanceout.c - rc_AdvanceOut_prog()
  static int rcAdvanceOutProg() {
    rcAdvanceOutModeSet();
    rcAdvanceOutDataClear();
    rcAdvanceOutDsp();
    return 0;
  }

  /// 関連tprxソース: rc_advanceout.c - rc_AdvanceOut_Mode_Set()
  static Future<void> rcAdvanceOutModeSet() async {
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        RcSet.rcAdvanceOutScrMode();
        break;
      default:
        break;
    }
  }

  /// 関連tprxソース: rc_advanceout.c - rc_AdvanceOut_DataClear()
  static void rcAdvanceOutDataClear() {
    advOutDsp = AdvanceOut();
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_advanceout.c - rc_AdvanceOut_dsp()
  static void rcAdvanceOutDsp() {
  }

  /// 関連tprxソース: rc_advanceout.c - rcChk_AdvanceOut()
  static Future<bool> rcChkAdvanceOut() async {
    return ((await CmCksys.cmNetDoAreservSystem() != 0) &&
        (advOutDsp.execMode != 0));
  }
}