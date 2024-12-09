/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rcalert.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_plu.dart';
import 'package:flutter_pos/app/regs/checker/rckychgqty.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/lib/cm_jan/set_jinf.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcsyschk.dart';

/// 関連tprxソース: rcky_yao_detail.c
class RckyYaoDetail{

/*----------------------------------------------------------------------*
 *                        Constatnt Value
 *----------------------------------------------------------------------*/
  static List<int> yaoTInfList0 = [FncCode.KY_REG.keyId, FncCode.KY_ENT.keyId, 0];
  static List<int> yaoTInfList1 = [0];
  static List<int> yaoTInfList2 = [0];
  static List<int> yaoTInfList3 = [0];
  static List<int> yaoTInfList4 = [0];

  /// 関連tprxソース: rcky_yao_detail.c - rcKyItmDetail
  static Future<void> rcKyItmDetail(int stat) async {
    int errNo;
    AtSingl atSing = SystemFunc.readAtSingl();

    if (await RcKyPlu.rcPopMsgCheck() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "Skip rcKyItmDetail Because rcPopMsg_Check Now Popup");
      atSing.yaoDetailFlg = stat;
      return;
    }

    if (await RcAlert.rcAlertModeChk() != 0) {
      atSing.yaoDetailFlg = stat;
      return;
    }

    atSing.yaoDetailFlg = 0;
    errNo = await rcChkKyItmDetail(stat);
    if ((!RcFncChk.rcCheckScanCheck()) && (errNo == OK)) {
      if (stat == 2) {
        // errNo = rcPrg_KyItmDetail_MdlProc(); // 描画処理なので移植しない
      } else {
        // errNo = rcPrg_KyItmDetailProc(stat); // 描画処理なので移植しない
      }
    }
    if (errNo != OK) {
      RcExt.rcErr("rcKyItmDetail", errNo);
    }
  }

  /// 関連tprxソース: rcky_yao_detail.c - rcChk_KyItmDetail
  static Future<int> rcChkKyItmDetail(int stat) async {
    int errNo = OK;
    int p;

    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        return (DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId);
      }
    }
    if (stat != 0) {
      // No Check
      return (OK);
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "PLU rxMemRead error");
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    if (mem.tTtllog.calcData.stldscAmt != 0) {
      errNo = DlgConfirmMsgKind.MSG_TEXT125.dlgId;
    }
    if ((errNo == OK) && (await RcSysChk.rcChkMulPerDiscSystem())) {
      /* 関西スーパー特注仕様 */
      errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
    }
    if ((errNo == OK) && (RcSysChk.rcChkTtlMulPDscSystem())) {
      /* 関西スーパー特注仕様 */
      errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
    }
    if ((errNo == OK) && (cBuf.dbTrm.enableActsaleTermPrcchg != 0)) {
      /* 丸久特注仕様         */
      errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
    }
    if ((errNo == OK) &&
        ((!await RcFncChk.rcCheckItmMode()) &&
            (!await RcFncChk.rcCheckStlMode()))) {
      errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
    }
    if ((errNo == OK) && (rcChkItmDtlRegistration() != true)) {
      errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
    }

    if (errNo == OK) {
      if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_SCRVOID.keyId])) {
        errNo = await RckyChgQty.rcChkKyChgQty();
        if (errNo == OK) {
          p = atSing.tStlLcdItem.iI;
          errNo = rcChkItmDtlQtyRqty(p);
        }
      } else {
        errNo = DlgConfirmMsgKind.MSG_BEFORSELPLU.dlgId;
      }
    }
    return (errNo);
  }

  /// 関連tprxソース: rcky_yao_detail.c - rcChk_ItmDtl_Registration
  static bool rcChkItmDtlRegistration() {
    AcMem cMem = SystemFunc.readAcMem();
    if ((RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId])) ||
        (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) ||
        (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
      return (false);
    } else {
      return (true);
    }
  }

  /// 関連tprxソース: rcky_yao_detail.c - rcChk_ItmDtl_Qty_Rqty
  static int rcChkItmDtlQtyRqty(int p) {
    int errNo = OK;
    RegsMem mem = SystemFunc.readRegsMem();

    if ((mem.tItemLog[p].t10000.itemTtlQty) !=
        (mem.tItemLog[p].t10000.realQty)) {
      errNo = DlgConfirmMsgKind.MSG_VOIDERR.dlgId;
    }

    return (errNo);
  }
}

