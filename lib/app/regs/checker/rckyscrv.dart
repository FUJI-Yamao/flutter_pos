/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

/// 関連tprxソース: rckyscrv.c
class RckyScrv {
  static const List<int> scrVoidList0 = [0];
  static const List<int> scrVoidList1 = [0];
  static const List<int> scrVoidList2 = [0];
  static const List<int> scrVoidList3 = [0];
  static List<int> scrVoidList4 = [FuncKey.KY_SCRVOID.keyId, 0];

  /// 関連tprxソース: rckyscrv.c - rcCheck_Ky_ScrVoid
  static Future<int> rcCheckKyScrVoid() async {
    int errNo;

    if ((await RcFncChk.rcCheckERefSMode()) ||
        (await RcFncChk.rcCheckERefIMode())) {
      return (0);
    } else if ((await RcFncChk.rcCheckESVoidSMode()) ||
        (await RcFncChk.rcCheckESVoidIMode())) {
      return (0);
    } else if (await RcFncChk.rcCheckDelivSvcSdspMode()) {
      return (0);
    }
    errNo = rcChkKyScrVoid();
    if (errNo != 0) {
      return (errNo);
    }

    AcMem cMem = SystemFunc.readAcMem();

    if ((RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId])) || /* nessecary Registration */
        (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) || /* nessecary Registration */
        (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
      /* sprit tendering ? */
      return (DlgConfirmMsgKind.MSG_OPEERR.dlgId); /* Ope Error */
    }

    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xFF);
    RcFncChk.rcKyStL0(cMem.keyChkb, scrVoidList0);
    RcFncChk.rcKyStL1(cMem.keyChkb, scrVoidList1);
    RcFncChk.rcKyStL2(cMem.keyChkb, scrVoidList2);
    RcFncChk.rcKyStL3(cMem.keyChkb, scrVoidList3);
    RcFncChk.rcKyStL4(cMem.keyChkb, scrVoidList4);
    if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO1) != 0) {
      return (DlgConfirmMsgKind.MSG_OPEERR.dlgId); /* Ope Error */
    }
    return (0); /* OK */
  }

  /// 関連tprxソース: rckyscrv.c - rcChk_Ky_ScrVoid
  static int rcChkKyScrVoid() {
    return (0); /* OK */
  }
}
