/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/cm_cal/cm_div.dart';
import '../../lib/cm_cal/cm_mul.dart';
import '../../lib/cm_cal/cm_round.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_sm65_ryubo.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rcfncchk.dart';
import 'rcitmset.dart';
import 'rcky_stl.dart';
import 'rckytcoupon.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcstldsc.c
class RcStlDsc {
  /// 値下額を算出する
  /// 引数:[wFncCode] ファンクションコード
  /// 引数:[checkFlg] エラーコードチェック
  /// 戻り値: エラーコード（0=エラーなし）
  ///  関連tprxソース: rcstfip.c - rcStlPm
  static Future<int> rcStlPm(int wFncCode, int checkFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if ((await CmCksys.cmDs2GodaiSystem() != 0)
        && (mem.tTtllog.t100002.quotationFlg != 0)) {
      return DlgConfirmMsgKind.MSG_QUO_STLDSCPLUS_FORBIDDEN.dlgId;
    }
    StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_NORMAL);

    if (await rcErrStlPm(wFncCode)) {
      return cMem.ent.errNo;
    }

    int trgtAmt = 0;	// 割引対象金額
    Onetime ot = SystemFunc.readOnetime();
    if (await CmCksys.cmWsSystem() != 0) {
      trgtAmt = mem.tTtllog.t100001Sts.stldscManuBfrAmt;	// 小計割引対象額
    } else {
      trgtAmt = ot.tStlDscTbl.obj;
    }
    if (!((wFncCode == RcSm65Ryubo.RYUBOTMBR_DSCKEY) && RcSysChk.rcChkSm65RyuboSystem())) {
      if (RcSysChk.rcChkRefundStlDscSystem()) {
        if (trgtAmt == 0) {  /* subtotal discount object ? */
          if (mem.tTtllog.t100001.stldscBfrAmt != 0) {
            return DlgConfirmMsgKind.MSG_NOT_DISCOUNT_TARGET.dlgId;
          } else {
            return DlgConfirmMsgKind.MSG_LACK_SUBTOTAL_TO_DISCOUNT.dlgId;
          }
        }
      } else {
        if (trgtAmt <= 0) {  /* subtotal discount object ? */
          if (mem.tTtllog.t100001.stldscBfrAmt != 0) {
            return DlgConfirmMsgKind.MSG_NOT_DISCOUNT_TARGET.dlgId;
          } else {
            return DlgConfirmMsgKind.MSG_LACK_SUBTOTAL_TO_DISCOUNT.dlgId;
          }
        }
      }
    }
    List<int> tmp = [0, 0];
    tmp = CmMul.cmLMul(trgtAmt, cMem.working.dataReg.kPm1_0);
    tmp = CmDiv.cmLDiv(tmp, 100);
    tmp[1] = CmRound.cmRound(cBuf.dbTrm.rndDscntFlg, tmp[0], 100);
    cMem.working.dataReg.kDsc0 = tmp[1] ~/ 100;
    if (RcSysChk.rcChkTpointSystem() != 0) {
      if (cMem.working.dataReg.kDsc0 > (mem.tTtllog.t100001.stldscBfrAmt - mem.tTtllog.calcData.stldscpdscAmt)) {
        return DlgConfirmMsgKind.MSG_LACK_SUBTOTAL_TO_DISCOUNT.dlgId;
      }
    }

    if (checkFlg != 1) {
      await RcItmSet.rcSetIstlPm();
    }

    if (RckyStl.rcChkOneMix()) {
      StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_NORMAL);
    }
    StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
    if ((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
        (await CmCksys.cmCrdtSystem() != 0)) {
      if (mem.tTtllog.calcData.stldscpdscAmt > mem.tTtllog.calcData.stldscBaseAmt) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_DISCOUNT_TARGETOVER.dlgId;
        return cMem.ent.errNo;
      }
    }
    return 0;
  }

  /// エラーチェック
  /// 引数:[wFncCode] ファンクションコード
  /// 戻り値: true=エラーあり  false=エラーなし
  ///  関連tprxソース: rcstfip.c - rcErrStlPm
  static Future<bool> rcErrStlPm(int wFncCode) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if ((await RcFncChk.rcCheckChgItmMode()) ||
        (await RcFncChk.rcCheckChgSelectItemsMode())) {
      return false;
    }

    if ((RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) ||
        (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) ||
        (RcRegs.kyStC4(cMem.keyStat[FncCode.KY_FNAL.keyId])) ) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      return true;
    }

    for (int p = 0; p < mem.tTtllog.t100001Sts.itemlogCnt; p++) {
      if (RcStl.rcChkItmRBufStlDsc(p) &&
        (RcSysChk.rcChkTpointSystem() == 0) &&
        !RcStl.rcChkItmRBufScrVoid(p) ) {
          if (CompileFlag.CATALINA_SYSTEM && (!RcStl.rcChkItmRBufCatalinaStlDsc(p) ||
              (RcStl.rcChkItmRBufCatalinaStlDsc(p) &&
                  (mem.tItemLog[p].t10000.realQty != 0)))) {
            if (!RcStl.rcChkItmRBufBarStlDsc(p) ||
                (RcStl.rcChkItmRBufBarStlDsc(p) &&
                    (mem.tItemLog[p].t10000.realQty != 0))) {
              if (!((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
                  (await CmCksys.cmCrdtSystem() != 0)) ) {
                cMem.ent.errNo = DlgConfirmMsgKind.MSG_INHAFTRDSC.dlgId;
                return true;
              }
            }
          }
        }
      }
      if (!Rxkoptcmncom.rxChkKeyKindPdsc(cBuf, wFncCode)) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_FILEREADERR.dlgId;
        return true;
      }
      if (Rxkoptcmncom.rxChkKoptPdscStlPdsc(cBuf, wFncCode) != 0) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
        return true;
      }
      if (RcSysChk.rcChkTpointSystem() != 0) {
        if (!RcKyTcoupon.rcCheckTcouponMode()) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
          return true;
        }
      }

    return false;  /* OK */
  }
}
