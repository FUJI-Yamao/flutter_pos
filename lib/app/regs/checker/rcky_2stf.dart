/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/cm_sys/cm_stf.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_auto.dart';
import 'rc_ext.dart';
import 'rc_key_stf.dart';
import 'rc_mbr_realsvr.dart';
import 'rc_mcd.dart';
import 'rc_obr.dart';
import 'rc_set.dart';
import 'rcfncchk.dart';
import 'rcky_regassist.dart';
import 'rcsyschk.dart';

class Rcky2Stf {
  static List<int> staffList0 = [FncCode.KY_ENT.keyId, FncCode.KY_REG.keyId, 0];
  static List<int> staffList1 = [FncCode.KY_SCAN.keyId, FncCode.KY_PSET.keyId, 0];
  static List<int> staffList2 = [0];
  static List<int> staffList3 = [FncCode.KY_FNAL.keyId, 0];
  static List<int> staffList4 = [0];

  ///  関連tprxソース: rcky_2stf.c - rcKyStf2
  static Future<void> rcKyStf2() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcKyStf2(): Start");
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcKyStf2() rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    cMem.ent.errNo = await rcChkKyStaff2DisableEnt();
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcKyStf", cMem.ent.errNo);
      RcSet.rcClearEntry();
      await rcAutoStrOpnClsStop(cMem.ent.errNo);
      tsBuf.chk.qcjc_frcclk_flg = 0;
      return;
    }
    tsBuf.chk.stat = 1;

    cMem.ent.errNo = await rcChkKyStaff2(0);
    if (cMem.ent.errNo == 0) {  // OK
      tsBuf.chk.stat = 0;
      //領収書・再発行画面が小計画面更新にて画面裏に隠れてしまう場合があるので一度消去
      RckyRegassist.rcRegAssistRprDispDestroy();
      if (await RcKyStf.rcStfStaffEventChk() == 0) {		// 従業員オープン画面表示中でない
        await RcKyStf.rcSimpleStaffDisp(0);
        if (FbInit.subinitMainSingleSpecialChk()) {
          await RcKyStf.rcSimpleStaffDisp(1);
        }
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcKyStf2(): Normal End");
      return;
    }
    await RcExt.rcErr("rcKyStf", cMem.ent.errNo);
    RcSet.rcClearEntry();
    tsBuf.chk.stat = 0;
    await rcAutoStrOpnClsStop(cMem.ent.errNo);
    tsBuf.chk.qcjc_frcclk_flg = 0;
  }

  /// 置数禁止設定(disable_ent_ope_simple_openclose)での従業員キー判定
  /// 戻り値: エラーNo
  ///  関連tprxソース: rcky_2stf.c - rcChk_Ky_Staff2_Disable_Ent
  static Future<int> rcChkKyStaff2DisableEnt() async {
    RxMemRet xRetCmn = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetCmn.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyStaff2DisableEnt(): rxMemRead(common) error");
      return 0;
    }
    RxCommonBuf cBuf = xRetCmn.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "rcChkKyStaff2DisableEnt() rxMemRead(stat) error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    if (!(await RcObr.rcChkStfBarcode()) && (cBuf.dbTrm.frcClkFlg != 0) &&
        (cBuf.dbTrm.disableEntOpeSimpleOpenclose != 0)) {
      if (RcFncChk.rcChkTenOn() ||
          ((atSing.inputbuf.Smlcode != 0) &&
              (tsBuf.chk.qcjc_frcclk_flg == 0))) {		/* QCJC変身フラグ */
        return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
      } else if (await CmStf.cmPersonChk() == 1) {
        if ((await RcSysChk.rcChkStfMode() == 0) && RcFncChk.rcChkTenOn()) {
          return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
        }
      } else if (await CmStf.cmPersonChk() == 2) {
        if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
          if ((cBuf.dbStaffopen.cshr_status == 0) && RcFncChk.rcChkTenOn()) {
            return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
          }
        } else if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
          if ((cBuf.dbStaffopen.chkr_status == 0) && RcFncChk.rcChkTenOn()) {
            return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
          }
        }
      }
    }
    return 0;
  }

  /// 引数:[errNo] エラーNo
  ///  関連tprxソース: rcky_2stf.c - rcAuto_StrOpnCls_Stop
  static Future<void> rcAutoStrOpnClsStop(int	errNo) async {
    if ((AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) &&
        (!(await RcFncChk.rcCheckChgInOutMode())) &&  //釣機回収、
        (!(await RcFncChk.rcCheckInOutMode())) &&  //差異チェック、売上回収,釣準備
        !RcFncChk.rcCheckChgRefMode()) {  //釣機参照画面表示中は精算中断しない
      await RcAuto.rcAutoStrOpnClsFuncErrStop(errNo);  /* エラー発生の為、自動化中止 */
    }
  }

  /// キー押下時のチェックを判定する
  /// 引数:[chkFlg] 0以外=特定のチェック処理を除外する
  /// 戻り値: 0:標準キー押下時のチェック  0以外:キー押下前の動作可能かチェック
  ///  関連tprxソース: rcky_2stf.c - rcChk_Ky_Staff2
  static Future<int> rcChkKyStaff2(int chkFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyStaff2(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    if (cBuf.dbTrm.frcClkFlg != 2) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyStaff2(): frc_clk_flg != 2");
      return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChkKyStaff2(): reg staff not change");
      return DlgConfirmMsgKind.MSG_REGSTFNOTCHG.dlgId;
    }
    if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChkKyStaff2(): tran staff not change");
      return DlgConfirmMsgKind.MSG_TRANSTFNOTCHG.dlgId;
    }

    if (await RcSysChk.rcChkDesktopCashier() &&
        (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChkKyStaff2(): at Checker of Desktop_Cashier Type");  //スマイルセルフのチェッカー側では従業員変更不可とする
      return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }

    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    for (int i = 0; i < staffList0.length; i++) {
      if (staffList0[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, staffList0[i]);
    }
    for (int i = 0; i < staffList1.length; i++) {
      if (staffList1[i] == 0) {
        break;
      }
      RcRegs.kyStR1(cMem.keyChkb, staffList1[i]);
    }
    for (int i = 0; i < staffList2.length; i++) {
      if (staffList2[i] == 0) {
        break;
      }
      RcRegs.kyStR2(cMem.keyChkb, staffList2[i]);
    }
    for (int i = 0; i < staffList3.length; i++) {
      if (staffList3[i] == 0) {
        break;
      }
      RcRegs.kyStR3(cMem.keyChkb, staffList3[i]);
    }
    for (int i = 0; i < staffList4.length; i++) {
      if (staffList4[i] == 0) {
        break;
      }
      RcRegs.kyStR4(cMem.keyChkb, staffList4[i]);
    }
    if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyStaff2(): key err");
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if (CompileFlag.CUSTREALSVR) {
      if (chkFlg == 0) {
        if ((RcSysChk.rcChkCustrealsvrSystem() != false) ||
            (await RcSysChk.rcChkCustrealNecSystem(0) != false)) {
          if ((RcMbrRealsvr.custRealSvrWaitChk() != 0) ||
              (RcMcd.rcMcdMbrWaitChk() != 0)) {
            return DlgConfirmMsgKind.MSG_MBRINQUIR.dlgId;
          }
        }
      }
    }

    return 0;
  }
}