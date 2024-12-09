/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/cmd_func.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/cm_jan/set_jinf.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/cm_sys/cm_cktwr.dart';
import '../../lib/if_scan/if_scan.dart';
import '../../lib/if_yomoca/if_yomoca.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_flrd.dart';
import 'rcfncchk.dart';
import 'rcsg_dsp.dart';
import 'rcsyschk.dart';

class RcObr {

  static int scanEnableFlg = 0;

  /// 関連tprxソース:C rc_obr.c - rcScan_Enable()
  static Future<void> rcScanEnable() async {
    if (await RcSysChk.rcChkSQRCTicketSystem()) {
      return;
    }
    scanEnableFlg = 1;
    rcScanEnableSub();
    if (RcRegs.rcInfoMem.rcRecog.recogYomocasystem != 0) {
      rcYomocaEnable();
    }
  }

  /// 関連tprxソース:C rc_obr.c - rcScan_Disable()
  static Future<void> rcScanDisable() async {
    if (await RcSysChk.rcChkSQRCTicketSystem()) {
      return;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcsgDsp.rcSGCheckPanaCard() &&
          RcFncChk.rcCheckSpritMode()) {
        return;
      }
    }
    scanEnableFlg = 0;
    rcScanDisableSub();
    if (RcRegs.rcInfoMem.rcRecog.recogYomocasystem != 0) {
      rcYomocaDisable();
    }
  }

  /// 従業員バーコード仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rc_obr.c - rcChkStfBarcode()
  static Future<bool> rcChkStfBarcode() async {
    RcSysChk.rcClearJanInf();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    cMem.working.janInf.code = atSing.inputbuf.Acode;
    await SetJinf.cmSetJanInf(cMem.working.janInf, 1, RcRegs.CHKDGT_CALC);

    switch (cMem.working.janInf.type) {
      case JANInfConsts.JANtypeClerk:
      case JANInfConsts.JANtypeClerk2:
      case JANInfConsts.JANtypeClerk3:
      case JANInfConsts.JANtypeSalemente:
        return true;
      default:
        break;
    }
    return false;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース:C rc_obr.c - rcScan_Lay_Enable
  static void rcScanLayEnable() {
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース:C rc_obr.c - rcScan_Disable_Sub
  static void rcScanDisableSub() {
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース:C rc_obr.c - rcScan_Enable_Sub
  static void rcScanEnableSub() {
  }

  /// 関連tprxソース:C rc_obr.c - rcYomoca_Enable
  static Future<void> rcYomocaEnable() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    CmdFunc cmdFunc = CmdFunc();

    if (((CmCksys.cmQCashierJCSystem() == 0) && (await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)) ||
        ((CmCksys.cmQCashierJCSystem() != 0) && (tsBuf.chk.cash_pid != cmdFunc.getPid()))) {
      TprMID aid = await RcFlrd.rcGetProcessID();
      IfYomoca.ifYomocaEnable(aid);
    }
  }

  /// 関連tprxソース:C rc_obr.c - rcYomoca_Disable
  static Future<void> rcYomocaDisable() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    CmdFunc cmdFunc = CmdFunc();

    if (((CmCksys.cmQCashierJCSystem() == 0) && (await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)) ||
        ((CmCksys.cmQCashierJCSystem() != 0) && (tsBuf.chk.cash_pid != cmdFunc.getPid()))) {
      TprMID aid = await RcFlrd.rcGetProcessID();
      IfYomoca.ifYomocaDisable(aid);
    }
  }

  /// 全日食様仕様におけるエラーコードかチェックする
  /// 引数: エラーコード
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rc_obr.c - rcZHQ_ErrorCode_Chk()
  static bool rcZHQErrorCodeChk(int errCd) {
    if ((errCd == DlgConfirmMsgKind.MSG_SVRCNCTERR.dlgId) ||
        (errCd == DlgConfirmMsgKind.MSG_CUSTOTHUSE.dlgId) ||
        (errCd == DlgConfirmMsgKind.MSG_TTLTBL_NOTREAD.dlgId) ||
        (errCd == DlgConfirmMsgKind.MSG_CPNTBL_NOTREAD.dlgId) ||
        (errCd == DlgConfirmMsgKind.MSG_LOYTBL_NOTREAD.dlgId)) {
      return true;
    }
    return false;
  }

  /// 2ndスキャナ無効化（12verから移植）
  /// 関連tprxソース: rc_obr.c - rc_Happy2ndScannerDisable()
  static Future<void> rcHappy2ndScannerDisable() async {
    if (!(await RcSysChk.rcChkSmartSelfSystem())) {
      return;
    }

    String callFunc = "RcObr.rcHappy2ndScannerDisable()";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, callFunc);
      return;
    }
    RxCommonBuf pCom = xRet.object;

    Mac_infoJsonFile macInfo = pCom.iniMacInfo;
    JsonRet jsonRet = await macInfo.getValueWithName("scanner", "scan_happyself_2nd");
    if (jsonRet.result) {
      int scannerType = int.tryParse(jsonRet.value) ?? 0;
      if (scannerType == 0) {
        await IfScan.hwDisableMacType(CmCktWr.TPR_TYPE_TOWER);
      }
      if (scannerType == 2) {
        await IfScan.pscDisableMacType(CmCktWr.TPR_TYPE_TOWER);
      }
    }
    else {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: scan_happyself_2nd get error");
    }
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_obr.c - rcObr_ryubo_staff_pdsc(short)
  static int rcObrRyuboStaffPdsc(){
    return 0;
  }
  
}
