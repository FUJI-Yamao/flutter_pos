/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../inc/L_rc_sgdsp.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_assist_mnt.dart';
import 'rc_ext.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rcfncchk.dart';
import 'rcstldsc.dart';
import 'rcsyschk.dart';

class RcSgCom {
  static String mngPcLog= '';
  static int selfAcbacrErrFlg = 0;
  static int quickIniPage = 0;
  static int quickIniPageOld = 0;
  static int quickselfUseIc = 0;
  static int edyBalanceAmt = 0;
  static int sgCnclFlg = 0;
  static QuickSgIni quickSelfIni = QuickSgIni();

  /// Manage-PC Log Data Set
  /// 関連tprxソース:C rcsg_com.c - rcSG_ManageLog_Send
  static void rcSGManageLogSend(int flag) {
    if(RcSysChk.rcChkAssistMonitor()) {
      RcAssistMnt.asstPcLog = RcAssistMnt.asstPcLog + mngPcLog;
    }

    mngPcLog = "$mngPcLog\n";
    // TODO:00013 三浦 実装必要ある？
    // TprLibOpeLog(flag, mngPcLog);

    mngPcLog= '';
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcsg_com.c - rcSG_ReStart_Dsp
  static void rcSGReStartDsp(int waitT) {
    return;
  }

  ///  関連tprxソース: rcsg_com.c - rcSG_ManageLog_Button
  static void rcSGManageLogButton() {
    RcSgCom.mngPcLog += LRcScdsp.SG_BUTTON_LOG;
  }

  // TODO:00016 佐藤 定義のみ追加
  ///  関連tprxソース: rcsg_com.c - rcSG_ManageLog_YesNo
  static void rcSGManageLogYesNo(int jdg) {
  }

  /// 関連tprxソース:C rcsg_com.c - rcSG_GuidancePresetDsp_Check
  static bool rcSGGuidancePresetDspCheck() {
    return false;
  }

  /// 関連tprxソース:C rcsg_com.c - rcSG_Chk_Edy_Direct
  static Future<bool> rcSGChkEdyDirect() async {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return false;
      }
      RxCommonBuf cBuf = xRet.object;
    if (await RcSysChk.rcChkQuickSelfSystem()) {
      if (cBuf.dbTrm.selfSlctKeyCd == 6 &&
          await CmCksys.cmEdyCardSystem() != 0 &&
          RcSysChk.rcSGChkAmpmSystem()) {
        return true;
      } else if (cBuf.dbTrm.selfSlctKeyCd == 8 &&
          await CmCksys.cmEdyCardSystem() != 0 &&
          RcSysChk.rcSGChkAmpmSystem() &&
          quickselfUseIc == 1) {
        return true;
      } else if (cBuf.dbTrm.selfSlctKeyCd == 9 &&
          await CmCksys.cmEdyCardSystem() != 0 &&
          RcSysChk.rcSGChkAmpmSystem() &&
          RcSysChk.rcChkSmartplusSystem() &&
          (quickselfUseIc == 0 || quickselfUseIc == 1)) {
        return true;
      } else if (cBuf.dbTrm.selfSlctKeyCd == 10 &&
          await CmCksys.cmEdyCardSystem() != 0 &&
          RcSysChk.rcSGChkAmpmSystem() &&
          RcSysChk.rcChkSmartplusSystem() &&
          RcSysChk.rcChkSmartplusSystem() &&
          (quickselfUseIc == 0 || quickselfUseIc == 1)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// 関連tprxソース:C rcsg_com.c - rcNewSG_Chk_NonAcr
  static bool rcNewSGChkNonAcr() {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (cBuf.dbTrm.selfSlctKeyCd == 2 ||
        cBuf.dbTrm.selfSlctKeyCd == 5 ||
        cBuf.dbTrm.selfSlctKeyCd == 6 ||
        cBuf.dbTrm.selfSlctKeyCd == 7 ||
        cBuf.dbTrm.selfSlctKeyCd == 8 ||
        cBuf.dbTrm.selfSlctKeyCd == 9 ||
        cBuf.dbTrm.selfSlctKeyCd == 10) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース:C rcsg_com.c - rcSG_Chk_Suica_Direct
  static Future<bool> rcSGChkSuicaDirect() async {
    if (await RcSysChk.rcChkQuickSelfSystem()) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return false;
      }
      RxCommonBuf cBuf = xRet.object;
      if (cBuf.dbTrm.selfSlctKeyCd == 7 &&
          await RcSysChk.rcChkSuicaSystem() &&
          RcSysChk.rcSGChkAmpmSystem()) {
        return true;
      } else if (cBuf.dbTrm.selfSlctKeyCd == 8 &&
          await RcSysChk.rcChkSuicaSystem() &&
          RcSysChk.rcSGChkAmpmSystem() &&
          quickselfUseIc == 2) {
        return true;
      } else if (cBuf.dbTrm.selfSlctKeyCd == 8 &&
          await RcSysChk.rcChkSuicaSystem() &&
          RcSysChk.rcSGChkAmpmSystem() &&
          quickselfUseIc == 3) {
        return true;
      } else if (cBuf.dbTrm.selfSlctKeyCd == 10 &&
          await RcSysChk.rcChkSuicaSystem() &&
          RcSysChk.rcSGChkAmpmSystem() &&
          (quickselfUseIc == 2 || quickselfUseIc == 3)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// 関連tprxソース:C rcsg_com.c - rcSG_MbrAutoPerDsc_FncCode
  static int rcSGMbrAutoPerDscFncCode() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    int fncCode = 0;
    switch (cBuf.dbTrm.selfMbrstlpdscKey) {
      case 1:
        fncCode = FuncKey.KY_PM1.keyId;
        break;
      case 2:
        fncCode = FuncKey.KY_PM2.keyId;
        break;
      case 3:
        fncCode = FuncKey.KY_PM3.keyId;
        break;
      case 4:
        fncCode = FuncKey.KY_PM4.keyId;
        break;
      case 5:
        fncCode = FuncKey.KY_PM5.keyId;
        break;
      default:
        break;
    }
    return fncCode;
  }

  /// Auto Percent Discount
  /// 関連tprxソース:C rcsg_com.c - rcSG_AutoPerDsc_Proc
  static Future<void> rcSGAutoPerDscProc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    int fncCode = 0;
    if (RcFncChk.rcCheckMbrInput()) {
      fncCode = rcSGMbrAutoPerDscFncCode();
      if (fncCode != 0) {
        RcSgDsp.selfMem.auto_pdsc_flg = 2;
      }
    }
    if (fncCode == 0) {
      switch (cBuf.dbTrm.selfStlpdscKey) {
        case 1:
          fncCode = FuncKey.KY_PM1.keyId;
          break;
        case 2:
          fncCode = FuncKey.KY_PM2.keyId;
          break;
        case 3:
          fncCode = FuncKey.KY_PM3.keyId;
          break;
        case 4:
          fncCode = FuncKey.KY_PM4.keyId;
          break;
        case 5:
          fncCode = FuncKey.KY_PM5.keyId;
          break;
        default:
          return;
      }
      RcSgDsp.selfMem.auto_pdsc_flg = 1;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcSgCom.rcSGAutoPerDscProc(): [SELF-GATE] Auto Subttl %Discount");
    int errNo = Typ.OK;
    int kPm1_0 = Rxkoptcmncom.rxChkKoptPdscPdscPer(cBuf, fncCode);
    if ((kPm1_0 == 0) || (kPm1_0 > 99)) {
      errNo = DlgConfirmMsgKind.MSG_CHKSETTING.dlgId;
    } else {
      cMem.working.dataReg.kPm1_0 = kPm1_0;
    }
    if (errNo == 0) {
      cMem.working.dataReg.kPm1_0 *= 100;
      RcRegs.kyStS0(cMem.keyStat, fncCode);
      errNo = await RcStlDsc.rcStlPm(fncCode, 0);
      RcRegs.kyStR0(cMem.keyStat, fncCode);
      RcRegs.kyStR0(cMem.keyStat, FncCode.KY_ENT.keyId);
      RcSet.rcClearPluReg();
      await RcSet.rcClearDataReg();
    }

    if (errNo != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcSgCom.rcSGAutoPerDscProc(): SELF Auto PerDsc Error[$errNo]");
      await RcExt.rcClearErrStat("rcSGAutoPerDscProc");
      RcSgDsp.selfMem.auto_pdsc_flg = 0;
    }
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（サウンド関連）
  /// 関連tprxソース:C rcsg_com.c - rcSG_ReadCardSound_Proc
  static void rcSGReadCardSoundProc() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（サウンド関連）
  /// 関連tprxソース:C rcsg_com.c - rcSG_IniSound_Proc_Main
  static void rcSGIniSoundProcMain(int typ) {}
}