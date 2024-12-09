/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../regs/checker/rcfncchk.dart';
import '../../regs/checker/rcky_rfdopr.dart';
import '../../regs/checker/rckytcoupon.dart';
import '../../regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/apllib/qr2txt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_ext.dart';

///  関連tprxソース: rckyrmod.c
class RcKyRmod {
  ///  関連tprxソース: rckyrmod.c - rcKyRmod
  static Future<int> rcKyRmod() async {
    AcMem cMem = SystemFunc.readAcMem();

    cMem.ent.errNo = await rcChkKyRmod();
    if(cMem.ent.errNo != 0){
      await RcExt.rcErr("rcKyRmod", cMem.ent.errNo);
      return cMem.ent.errNo;
    }else{
      // TODO:10158 商品券支払い 実装対象外
      // // RM-3800 フローティング仕様の場合、サーバに保存していた加算情報のロックを解除する。
      // if ( cm_chk_rm5900_floating_system ( ) )	// フローティング
      //     {
      //   if ( C_BUF->vtcl_rm5900_floating_stop == 0 )	// フローティング仕様 有効中
      //       {
      //     rc59_Floating_Return ( );		// 加算情報戻し
      //   }
      // }
      // rcPrg_Ky_Rmod();
      // rcEnd_Ky_Rmod();
    }
    return 0;
  }

  ///  関連tprxソース: rckyrmod.c - rcChk_Ky_Rmod
  static Future<int> rcChkKyRmod() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (RckyRfdopr.rcRfdOprCheckManualRefundMode() &&
        (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR)) {
      return OK;
    }

    if (!await RcFncChk.rcChkCashInt() &&
        ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) && !RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]))) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if (RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId]) ||
        RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
     return DlgConfirmMsgKind.MSG_NG_SPRIT_REGISTRATION_BACK.dlgId;
    }

    if (RcRegs.kyStC2(cMem.keyStat[FuncKey.KY_PRECA_CLR.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MBRCLR.keyId])) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if (RcFncChk.rcChkTenOn()) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if (RcSysChk.rcCheckCrdtStat()) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if (RcSysChk.rcCheckCalcTend()) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if ((RcSysChk.rcChkTpointSystem() != 0) &&
        RcKyTcoupon.rcCheckTcouponMode()) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    return OK;
  }
}