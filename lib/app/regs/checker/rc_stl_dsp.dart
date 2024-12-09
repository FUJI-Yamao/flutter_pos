/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_elog.dart';
import 'rc_mbr_com.dart';
import 'rcfncchk.dart';
import 'rcky_esvoid.dart';
import 'rcky_spdsp.dart';
import 'rckycrdtvoid.dart';
import 'rckyprecavoid.dart';
import 'rcmbrpttlset.dart';
import 'rcstlfip.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

class RcStlDsp {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcstldsp.c - rcStlReTtlLcd
  static void rcStlReTtlLcd(int wFctrl) {
    return;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// Change to Subtotal Screen
  /// 関連tprxソース:rcstldsp.c - rcStlFunctionDisp
  static void rcStlFunctionDisp() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// Subtotal Display Function (Member portion)
  /// 関連tprxソース:rcstldsp.c - rcStlFunctionDisp
  static void rcStlDspMember(int wFctrl) {}

  ///  Subtotal Display Function (Total portion)
  /// 関連tprxソース:rcstldsp.c - rcStlDsp_Totalizers
  static Future<void> rcStlDspTotalizers(int wFctrl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    if (CompileFlag.SMART_SELF) {
      if ((await RcSysChk.rcChkSmartSelfSystem()) &&
          ((await RcSysChk.rcNewSGChkNewSelfGateSystem()) ||
              (await RcSysChk.rcQCChkQcashierSystem()))) {
        if (RcFncChk.rcCheckSpritMode()) {
          RckySpDsp.rcSPChangDspPrg(RcStlLcd.FSTLLCD_RESET_ITEMINDEX);
        } else {
          await RcStlLcd.rcStlLcdTotalizers(RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
        }
        return;
      }
    }

    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
    case RcRegs.DESKTOPTYPE:
      if (cMem.stat.fncCode != FuncKey.KY_OFF.keyId) {
        RcStFip.rcStlFip(RcRegs.FIP_NO1);
      }
      if (RcFncChk.rcCheckSpritMode()) {
        RckySpDsp.rcSPChangDspPrg(RcStlLcd.FSTLLCD_RESET_ITEMINDEX);
      } else {
        await RcStlLcd.rcStlLcdTotalizers(RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
      }
      break;
    case RcRegs.KY_CHECKER:
      if (cMem.stat.fncCode != FuncKey.KY_OFF.keyId) {
        RcStFip.rcStlFip(RcRegs.FIP_NO2);
      }
      if (RcFncChk.rcCheckSpritMode() && (await RcSysChk.rcCheckQCJCSystem())) {
        RckySpDsp.rcSPChangDspPrg(RcStlLcd.FSTLLCD_RESET_ITEMINDEX);
      } else {
        await RcStlLcd.rcStlLcdTotalizers(RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
      }
      break;
    case RcRegs.KY_SINGLE:
      if ((await RcFncChk.rcCheckERefRMode()) ||
          (await RcFncChk.rcCheckERefIMode())) {
        if (ERef().nowDisplay == RcElog.EREF_LCDDISP) {
          if (FbInit.subinitMainSingleSpecialChk()) {
            if (cMem.stat.dualTSingle == 1) {
              RcStFip.rcStlFip(RcRegs.FIP_NO1);
            } else {
              RcStFip.rcStlFip(RcRegs.FIP_NO2);
            }
          } else {
            RcStFip.rcStlFip(RcRegs.FIP_NO2);
          }
          await RcStlLcd.rcStlLcdTotalizers(RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
        } else {
          RcStFip.rcStlFip(RcRegs.FIP_NO1);
          if (RcFncChk.rcCheckSItmMode() &&
              (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_SCRVOID.keyId]))) {
            if ((await RcMbrCom.rcmbrChkStat() != 0)
                && (RcMbrCom.rcmbrChkCust() != 0)) {
              await RcMbrPttlSet.rcmbrPTtlSet();
            }
          }
        }
        return;
      } else if ((await RcFncChk.rcCheckESVoidVMode()) ||
          (await RcFncChk.rcCheckESVoidSDMode()) ||
          (await RcFncChk.rcCheckESVoidCMode()) ||
          (await RcFncChk.rcCheckESVoidIMode())) {
        if (RcKyesVoid.esVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
          if (FbInit.subinitMainSingleSpecialChk()) {
            if (cMem.stat.dualTSingle == 1) {
              RcStFip.rcStlFip(RcRegs.FIP_NO1);
              await RcStlLcd.rcStlLcdTotalizers(
                  RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.dualSubttl);
            } else {
              RcStFip.rcStlFip(RcRegs.FIP_NO2);
              await RcStlLcd.rcStlLcdTotalizers(
                  RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
            }
          } else {
            RcStFip.rcStlFip(RcRegs.FIP_NO2);
            await RcStlLcd.rcStlLcdTotalizers(
                RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
          }
        } else {
          RcStFip.rcStlFip(RcRegs.FIP_NO1);
          if (RcFncChk.rcCheckSItmMode() &&
              (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_SCRVOID.keyId]))) {
            if ((await RcMbrCom.rcmbrChkStat() != 0)
                && (RcMbrCom.rcmbrChkCust() != 0)) {
              await RcMbrPttlSet.rcmbrPTtlSet();
            }
          }
        }
        return;
      } else if (await RcFncChk.rcCheckCrdtVoidIMode()) {
        if (RcKyCrdtVoid.crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
          if (FbInit.subinitMainSingleSpecialChk()) {
            if (cMem.stat.dualTSingle == 1) {
              RcStFip.rcStlFip(RcRegs.FIP_NO1);
              await RcStlLcd.rcStlLcdTotalizers(
                  RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.dualSubttl);
            } else {
              RcStFip.rcStlFip(RcRegs.FIP_NO2);
              await RcStlLcd.rcStlLcdTotalizers(
                  RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
            }
          } else {
            RcStFip.rcStlFip(RcRegs.FIP_NO2);
            await RcStlLcd.rcStlLcdTotalizers(
                RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
          }
        } else {
          RcStFip.rcStlFip(RcRegs.FIP_NO1);
          if (RcFncChk.rcCheckSItmMode() &&
              (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_SCRVOID.keyId]))) {
            if ((await RcMbrCom.rcmbrChkStat() != 0)
                && (RcMbrCom.rcmbrChkCust() != 0)) {
              await RcMbrPttlSet.rcmbrPTtlSet();
            }
          }
        }
        return;
      } else if (await RcFncChk.rcCheckPrecaVoidIMode()) {
        if (RcKyPrecaVoid.precaVoid.nowDisplay == RcElog.PRECAVOID_LCDDISP) {
          if (FbInit.subinitMainSingleSpecialChk()) {
            if (cMem.stat.dualTSingle == 1) {
              RcStFip.rcStlFip(RcRegs.FIP_NO1);
              await RcStlLcd.rcStlLcdTotalizers(
                  RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.dualSubttl);
            } else {
              RcStFip.rcStlFip(RcRegs.FIP_NO2);
              await RcStlLcd.rcStlLcdTotalizers(
                  RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
            }
          } else {
            RcStFip.rcStlFip(RcRegs.FIP_NO2);
            await RcStlLcd.rcStlLcdTotalizers(
                RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
          }
        } else {
          RcStFip.rcStlFip(RcRegs.FIP_NO1);
          if (RcFncChk.rcCheckSItmMode() &&
              (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_SCRVOID.keyId]))) {
            if ((await RcMbrCom.rcmbrChkStat() != 0)
                && (RcMbrCom.rcmbrChkCust() != 0)) {
              await RcMbrPttlSet.rcmbrPTtlSet();
            }
          }
        }
        return;
      }
      if (cMem.stat.fncCode != FuncKey.KY_OFF.keyId) {
        RcStFip.rcStlFip(RcRegs.FIP_NO1);
        RcStFip.rcStlFip(RcRegs.FIP_NO2);
      }
      if (RcFncChk.rcCheckSpritMode()) {
        RckySpDsp.rcSPChangDspPrg(RcStlLcd.FSTLLCD_RESET_ITEMINDEX);
        return;
      } else {
        await RcStlLcd.rcStlLcdTotalizers(
            RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
      }
      if (RcFncChk.rcCheckSItmMode() &&
          (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_SCRVOID.keyId]))) {
        if ((await RcMbrCom.rcmbrChkStat() != 0)
            && (RcMbrCom.rcmbrChkCust() != 0)) {
          await RcMbrPttlSet.rcmbrPTtlSet();
        }
        RcStlLcd.rcStlLcdItems(RegsDef.subttl);
      }
      if (FbInit.subinitMainSingleSpecialChk()) {
        if (CompileFlag.SELF_GATE && !(await RcSysChk.rcSGChkSelfGateSystem())) {
          await RcStlLcd.rcStlLcdTotalizers(
              RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.dualSubttl);
        }
      }
      break;
    case RcRegs.KY_DUALCSHR:
      if (cMem.stat.fncCode != FuncKey.KY_OFF.keyId) {
        RcStFip.rcStlFip(RcRegs.FIP_NO1);
      }
      if ((!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_SCRVOID.keyId])) &&
          ((cMem.stat.fncCode != FuncKey.KY_CNCL.keyId) &&
              (cMem.stat.fncCode != FuncKey.KY_SPCNCL.keyId))) {
        RcStlLcd.rcStlLcd(RcStlLcd.FSTLLCD_NOT_LCDINIT, RegsDef.subttl);
      }
      if (RcFncChk.rcCheckSpritMode()) {
        RckySpDsp.rcSPChangDspPrg(RcStlLcd.FSTLLCD_RESET_ITEMINDEX);
      } else {
        await RcStlLcd.rcStlLcdTotalizers(
            RcStlLcd.FSTLLCD_RESET_ITEMINDEX, RegsDef.subttl);
      }
      if ((!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_SCRVOID.keyId])) &&
          ((cMem.stat.fncCode != FuncKey.KY_CNCL.keyId) &&
              (cMem.stat.fncCode != FuncKey.KY_SPCNCL.keyId))) {
        AtSingl atSing = SystemFunc.readAtSingl();
        RcStlLcd.rcStlLcdSetPage(atSing.tStlLcdItem.pageMax);
        await Rc28StlInfo.rcStlLcd28SetDispStatus(atSing.tStlLcdItem.itemMax);
      }
      break;
    }
  }
}