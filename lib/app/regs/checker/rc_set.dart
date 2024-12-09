/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:sprintf/sprintf.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/t_item_log.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_28dsp.dart';
import 'rc_itm_dsp.dart';
import 'rc_key_tab.dart';
import 'rc_qc_dsp.dart';
import 'rc_qrinf.dart';
import 'rc_tab.dart';
import 'rcfncchk.dart';
import 'rcitmchk.dart';
import 'rcky_collectkey.dart';
import 'rcky_mul.dart';
import 'rcky_plu.dart';
import 'rcqr_com.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';
import 'rxregstr.dart';

class RcSet {
/************************************************************************/
/*                           Common Functions                           */
/************************************************************************/

  ///  関連tprxソース: rc_set.c - rcClear_Regs
  static void rcClearRegs() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.pluFlrdFlg != 0) {
      return;
    }
    rcClearRefData();
    rcClearNotfReg();
  }

  ///  関連tprxソース: rc_set.c - rcClearData_Reg
  static Future<void> rcClearDataReg() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.pluFlrdFlg != 0) {
      return;
    }
    if (CompileFlag.BDL_PER) {
      if (!(((await CmCksys.cmIchiyamaMartSystem() != 0) || (await RcSysChk.rcChkSchMultiSelectSystem()))
          && (cMem.scrData.mulkey != 0)
          && (cMem.working.dataReg.kMul1 != 0)
          && (cMem.working.dataReg.kMul1 <= cMem.scrData.mulkey)
      )) {
        cMem.working.dataReg = DataReg();
      }

    }
  }

  ///  関連tprxソース: rc_set.c - rc_set_checker_updctrl_flg
  static Future<void> rcSetCheckerUpdctrlFlg(int ctrl) async {
    if (!CompileFlag.SMART_SELF) {
      return;
    }
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    if ((await RcSysChk.rcChkDesktopCashier()) && await RcSysChk.rcQRChkPrintSystem()) {
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.KY_DUALCSHR:
          tsBuf.cash.ky_cash_cha_flg = ctrl;
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcSetCheckerUpdctrlFlg()  : cash.ky_cash_cha_flg[${tsBuf.cash.ky_cash_cha_flg}]");
        case RcRegs.KY_CHECKER:
          tsBuf.chk.ky_qcselect_flg = ctrl;
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcSetCheckerUpdctrlFlg()  : chk.ky_qcselect_flg[${tsBuf.chk.ky_qcselect_flg}]");
        default:

      }
    }

    return;
  }

  ///  関連tprxソース: rc_set.c - Cash_Stat_Reset, Cash_Stat_Reset2
  static Future<void> cashStatReset2(String callFunc) async {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      if (tsBuf.cash.stat != 0) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "Cash_Stat_Reset( callFunc : $callFunc)");
        tsBuf.cash.stat = 0;
      }

    } else if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      AcMem cMem = SystemFunc.readAcMem();
      if (cMem.stat.fncCode != FuncKey.KY_OFF.keyId
          && cMem.stat.fncCode != FuncKey.KY_PRC.keyId
          && cMem.stat.fncCode != FuncKey.KY_SUS.keyId
          && cMem.stat.fncCode != FuncKey.KY_PRCCHK.keyId
      ) {
        if (tsBuf.chk.stat != 0) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "Chk_Stat_Reset( callFunc : $callFunc)");
          tsBuf.chk.stat = 0;
        }
      }
      if (tsBuf.chk.stat_dual != 0) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "Chk_Stat_Dual_Reset( callFunc : $callFunc)");
        tsBuf.chk.stat_dual = 0;
      }
    }
  }

  ///  関連tprxソース: rc_set.c - rcSet_DualChkReg
  static Future<void> rcSetDualChkReg() async {
    if (CmCksys.cmFbDualSystem() == 2 && await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRetStat.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRetStat.object;
      tsBuf.chk.reg_flg = 1;
    }
    return;
  }

  ///  関連tprxソース: rc_set.c - rcClear_DualChkReg
  static Future<void> rcClearDualChkReg() async {
    if (CmCksys.cmFbDualSystem() == 2 && await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRetStat.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRetStat.object;
      tsBuf.chk.reg_flg = 0;
    }
    return;
  }

  ///  TODO:00007 梶原 中身の実装が必要
  ///  関連tprxソース: rc_ext.h - rcClear_int_flag #define rcClear_int_flag() rcClear_Int_Flag(0)
  ///  関連tprxソース: rc_set.c - rcClear_Int_Flag
  static void rcClearIntFlag({int clear = 0}) {
//     /* 04.02.16 T.Habara */
//     if (!(C_BUF->db_trm.keep_int_2person) || clear)
//     {
//       OT->flags.int_flag = (char)0;
//     C_BUF->int_flag = (char)0;
//     TS_BUF->chk.intkey_flag = 0;
// //     TS_BUF->chk.intBook_flag = 0;
//     if (cm_fb_dual_system() == 2)
//     rc_dual_conf_destroy();
//   }
  }

  /// クレジットレジストリを初期化する
  ///  関連tprxソース: rc_set.c - rcClearCrdt_Reg
  static void rcClearCrdtReg() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.crdtReg = CrdtReg();
    cMem.working.refData.crdtTbl = CCrdtDemandTbl();
    cMem.working.refData.crdtTbl.card_company_name = "";
  }

  ///  関連tprxソース: rc_set.c - rcClearRef_Data
  static void rcClearRefData() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.refData.plu = CPluMst();
    cMem.working.refData.plu.pos_name = " ";
    cMem.working.refData.tax = CTaxMst();
    cMem.working.refData.tax.tax_name = " ";
    cMem.working.refData.crdtTbl = CCrdtDemandTbl();
    cMem.working.refData.crdtTbl.card_company_name = " ";
  }

  ///  関連tprxソース: rc_set.c - rcClearNotf_Reg
  static void rcClearNotfReg() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.notfReg = CPluMst();
  }

  /// エントリーバッファを初期化する
  ///  関連tprxソース: rc_set.c - rcClearEntry
  static void rcClearEntry() {
    AcMem cMem = SystemFunc.readAcMem();
    CmAry.cmClr(cMem.ent.entry, cMem.ent.entry.length);
    cMem.ent.tencnt = 0;
    cMem.ent.deccnt = 0;
    rcClearDKEnt();
  }

  /// エントリーパラメタ（BCD, ディジットカウント）を初期化する
  ///  関連tprxソース: rc_set.c - rcClear_D_k_ent
  static void rcClearDKEnt() {
    AcMem cMem = SystemFunc.readAcMem();
    CmAry.cmClr(cMem.working.dataReg.kEnt0, cMem.working.dataReg.kEnt0.length);
    cMem.working.dataReg.kEnt1 = 0;
  }

  /// 共有メモリのエラーステータスを初期化する
  /// 引数:[cFunc] 呼び出し元の関数名（ログ出力用）
  ///  関連tprxソース: rc_set.c - rcClearErr_Stat2
  static Future rcClearErrStat2(String cFunc) async {
    AcMem cMem = SystemFunc.readAcMem();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcClearErrStat2( call_func : $cFunc )");
    cMem.ent.errStat = 0;
    cMem.ent.errNo = 0;
    cMem.ent.bzwarnNo = 0;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcClearErrStat2(): RxTaskStatBuf isInvalid");
      return;
    }
    RxTaskStatBuf taskStat = xRet.object;
    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      taskStat.cash.err_stat = 0;
    } else if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      if ((CmCksys.cmFbDualSystem() == 2) ||
          (await RcSysChk.rcChkDesktopCashier())) {
        taskStat.chk.err_stat = 0;
      }
    }
  }

  /// 指定した値より、インターバルタイマーをチェッカーorキャッシャーにセットする
  /// 引数:[flg] タイマー種類
  ///  関連tprxソース: rc_set.c - rcSet_ST_T_Flag
  static void rcSetStTFlag(int flg) {
    // TODO:10070 タイマータスク
    return;
  }

  /// 指定した値より、インターバルタイマーをチェッカーorキャッシャーにセットする
  ///  関連tprxソース: rc_set.c - rcSet_Timer_Data
  static void rcSetTimerData() {
    // TODO:10070 タイマータスク
    return;
  }

  /// アテンド時間の計測終了＆実績のメモリへ加算
  ///  関連tprxソース: rc_set.c - rcAttendEndDataSet
  static void rcAttendEndDataSet() {
    // TODO:10070 タイマータスク
    return;
  }

  ///  関連tprxソース: rc_set.c - rcQP_ScrMode　
  static Future<bool> rcQPScrMode() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QUICPay ScrMode");
    await rcMovScrMode();
    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.scrType = RcRegs.LCD_104Inch;
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_ITM :
      case RcRegs.RG_STL :
      case RcRegs.RG_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.RG_QP;
        return false;
      case RcRegs.VD_ITM :
      case RcRegs.VD_STL :
      case RcRegs.VD_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.VD_QP;
        return false;
      case RcRegs.TR_ITM :
      case RcRegs.TR_STL :
      case RcRegs.TR_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.TR_QP;
        return false;
      case RcRegs.SR_ITM :
      case RcRegs.SR_STL :
      case RcRegs.SR_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.SR_QP;
        return false;
      default :
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rciD_ScrMode
  static Future<bool> rciDScrMode() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "iD ScrMode");
    await rcMovScrMode();
    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.scrType = RcRegs.LCD_104Inch;
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_ITM :
      case RcRegs.RG_STL :
      case RcRegs.RG_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.RG_ID;
        return false;
      case RcRegs.VD_ITM :
      case RcRegs.VD_STL :
      case RcRegs.VD_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.VD_ID;
        return false;
      case RcRegs.TR_ITM :
      case RcRegs.TR_STL :
      case RcRegs.TR_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.TR_ID;
        return false;
      case RcRegs.SR_ITM :
      case RcRegs.SR_STL :
      case RcRegs.SR_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.SR_ID;
        return false;
      default :
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcMov_ScrMode
  static Future<void> rcMovScrMode() async {
    String log = "";
    AcMem cMem = SystemFunc.readAcMem();
    int? orgScrMode = cMem.stat.bkScrMode;

    final result = await RcSysChk.rcKySelf();
    switch (result) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        cMem.stat.scrType = RcRegs.LCD_104Inch;
        cMem.stat.bkScrMode = cMem.stat.scrMode;
        break;
      case RcRegs.KY_SINGLE:
        RxInputBuf iBuf = SystemFunc.readRxInputBuf();
        if (iBuf.devInf.devId == TprDidDef.TPRDIDMECKEY1 ||
            iBuf.devInf.devId == TprDidDef.TPRDIDTOUKEY1) {
          cMem.stat.scrType = RcRegs.LCD_57Inch;
          cMem.stat.bkScrMode = cMem.stat.subScrMode;
        }
        else {
          cMem.stat.scrType = RcRegs.LCD_104Inch;
          cMem.stat.bkScrMode = cMem.stat.scrMode;
        }
        break;
    }
    if (orgScrMode != cMem.stat.bkScrMode) {
      //BkScrModeの値を変更した
      log = sprintf("rcMovScrMode : BkScrMode[%d] Save\n", [cMem.stat.bkScrMode]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
  }

  ///  関連tprxソース: rc_set.c - rcReMov_ScrMode
  static void rcReMovScrMode() {
    String log = "";
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
      log = "rcReMovScrMode : ScrMode[${cMem.stat.scrMode}] -> [${cMem.stat.bkScrMode}] Load";
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);
      cMem.stat.scrMode = cMem.stat.bkScrMode;
    }
    if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
      log = "rcReMovScrMode : SubScrMode[${cMem.stat.subScrMode}] -> [${cMem.stat.bkScrMode}] Load";
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);
      cMem.stat.subScrMode = cMem.stat.bkScrMode;
    }
    cMem.stat.bkScrMode = 0;
    RckyCollectKey.rcCollectKeyDispRefresh();


  }

  /// 取引を行っているモードをセット(Happyの対面、QC、フル、WizSelf)
  /// 引数: なし
  /// 戻値: 0固定
  ///  関連tprxソース: rc_set.c - rc_set_tran_mode
  static Future<int> rcSetTranMode() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (await RcSysChk.rcChkSmartSelfSystem()) { // HappySelf
      if (await RcSysChk.rcSysChkHappySmile()) { // 対面
        mem.prnrBuf.tran_mode = 1;
      }
      else if (await RcSysChk.rcChkHappySelfQCashier()) { // QCashier
        //		else if　(rcQC_Chk_Qcashier_System())	// QCashier (これだとフルセルフモードのときにここに入ってしまうので戻す)
        mem.prnrBuf.tran_mode = 2;
      }
      else {
        if (cBuf.wizSelfChg == 1) { // WizSelf
          mem.prnrBuf.tran_mode = 4;
        }
        else { // フルセルフ
          mem.prnrBuf.tran_mode = 3;
        }
      }
    }
    else {
      mem.prnrBuf.tran_mode = 0;
    }
    TprLog().logAdd(await RcSysChk.getTid(), Tpraid.TPRAID_CHK,
        "rcSetTranMode : tran_mode[${mem.prnrBuf.tran_mode}]");

    return 0;
  }

  ///  関連tprxソース: rc_set.c - rcErr_Stat_Set2
  /// #define rcErr_Stat_Set()	rcErr_Stat_Set2(__FUNCTION__)
  static Future<void> rcErrStatSet2(String callFunc) async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (cMem.ent.errStat != 1) {
      String log = sprintf("rcErrStatSet2( call_func : %s )\n", [callFunc]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    cMem.ent.errStat = 1;
    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) { /* I'm Cashier ?  */
      tsBuf.cash.err_stat = 1;
    }
    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER
        && CmCksys.cmFbDualSystem() == 2) {
      tsBuf.chk.err_stat = 1;
    }
    if (await RcSysChk.rcChkDesktopCashier()) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
        tsBuf.chk.err_stat = 1;
      }
    }
  }

  ///  関連tprxソース: rc_set.c - rcClearRepeat_Buf
  static void rcClearRepeatBuf() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.scrData.repeatCnt = 0;
  }

  /// 「登録、訂正、訓練、廃棄」モードの場合、画面を SubTotal に設定する
  /// 戻値: true=上記モードでない  false=設定実行
  ///  関連tprxソース: rc_set.c - rcCrdtVoidS_ScrMode
  static bool rcCrdtVoidSScrMode() {
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.stat.scrMode) {
      case RcRegs.RG_CRDTVOIDI:
      case RcRegs.RG_CRDTVOIDA:
      case RcRegs.RG_CRDTVOID:
        cMem.stat.scrMode = RcRegs.RG_CRDTVOIDS; //登録
        return false;
      case RcRegs.VD_CRDTVOIDI:
      case RcRegs.VD_CRDTVOIDA:
      case RcRegs.VD_CRDTVOID:
        cMem.stat.scrMode = RcRegs.VD_CRDTVOIDS; //訂正
        return false;
      case RcRegs.TR_CRDTVOIDI:
      case RcRegs.TR_CRDTVOIDA:
      case RcRegs.TR_CRDTVOID:
        cMem.stat.scrMode = RcRegs.TR_CRDTVOIDS; //訓練
        return false;
      case RcRegs.SR_CRDTVOIDI:
      case RcRegs.SR_CRDTVOIDA:
      case RcRegs.SR_CRDTVOID:
        cMem.stat.scrMode = RcRegs.SR_CRDTVOIDS; //廃棄
        return false;
      default:
        break;
    }
    return true;
  }

  /// 「登録、訂正、訓練、廃棄」モードの場合、画面を SubItem に設定する
  /// 戻値: true=上記モードでない  false=設定実行
  ///  関連tprxソース: rc_set.c - rcCrdtVoidI_ScrMode
  static bool rcCrdtVoidIScrMode() {
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.stat.scrMode) {
      case RcRegs.RG_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.RG_CRDTVOIDI; //登録
        return false;
      case RcRegs.VD_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.VD_CRDTVOIDI; //訂正
        return false;
      case RcRegs.TR_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.TR_CRDTVOIDI; //訓練
        return false;
      case RcRegs.SR_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.SR_CRDTVOIDI; //廃棄
        return false;
      default:
        break;
    }
    return true;
  }

  /// 「登録、訂正、訓練、廃棄」モードの場合、サブ画面を SubItem に設定する
  /// 戻値: true=上記モードでない  false=設定実行
  ///  関連tprxソース: rc_set.c - rcCrdtVoidI_SubScrMode
  static bool rcCrdtVoidISubScrMode() {
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.stat.subScrMode) {
      case RcRegs.RG_CRDTVOIDS:
        cMem.stat.subScrMode = RcRegs.RG_CRDTVOIDI;
        return false;
      case RcRegs.VD_CRDTVOIDS:
        cMem.stat.subScrMode = RcRegs.VD_CRDTVOIDI;
        return false;
      case RcRegs.TR_CRDTVOIDS:
        cMem.stat.subScrMode = RcRegs.TR_CRDTVOIDI;
        return false;
      case RcRegs.SR_CRDTVOIDS:
        cMem.stat.subScrMode = RcRegs.SR_CRDTVOIDI;
        return false;
      default:
        break;
    }
    return true;
  }

  /// クレジットエラーコードを初期化する
  ///  関連tprxソース: rc_set.c - rcClear_CreditErr_Code
  static void rcClearCreditErrCode() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.crdtErrCd = "";
  }

  ///  関連tprxソース: rc_set.c - rcClear_WizStaff_No
  static void rcClearWizStaffNo() {
    RegsMem().tmpbuf.chkrNo = 0;
    RegsMem().tmpbuf.chkrName = '';
  }

  ///  関連tprxソース: rc_set.c - Cash_Stat_Set2
  static Future<void> cashStatSet2(String callFunc) async {
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      if (tsBuf.cash.stat != 1) {
        log = sprintf("Cash_Stat_Set(callFunc : %s)\n", [callFunc]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        tsBuf.cash.stat = 1;
      }
    } else if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      if (cMem.stat.fncCode != FuncKey.KY_OFF.keyId &&
          cMem.stat.fncCode != FuncKey.KY_PRC.keyId
          && cMem.stat.fncCode != FuncKey.KY_SUS.keyId &&
          cMem.stat.fncCode != FuncKey.KY_PRCCHK.keyId) {
        if (tsBuf.chk.stat != 1) {
          log = sprintf("Chk_Stat_Set( call_func : %s)\n", [callFunc]);
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          tsBuf.chk.stat = 1;
        }
      }
      if (tsBuf.chk.stat_dual != 1) {
        log = sprintf("Chk_Stat_Dual_Set( call_func : %s)\n", [callFunc]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        tsBuf.chk.stat_dual = 1;
      }
    }
  }

  ///  関連tprxソース: rc_set.c - rcErr_1time_Set
  static void rcErr1timeSet() {
    AcMem cMem = SystemFunc.readAcMem();

    cMem.stat.clkStatus |= RcRegs.VDTR_CTRL; /* Error VD&TR Status ON */
    cMem.stat.clkStatus |= RcRegs.ERR_1TIME; /* Error 1Time Status ON */
    cMem.stat.clkStatus |= RcRegs.STAT_SvrOffLine; /* Error Server Offline ON */
    cMem.stat.msgDspStatus |= RcRegs.MSDSP_CustTrmChg; /* 登録開始時メッセージ表示OFF */
    cMem.stat.tomoifLibCheck |= RcRegs.FILCHECK_TomoLib_Reg; /* 各取引開始時 チェックON */
  }

  ///  関連tprxソース: rc_set.c - rcItmLcd_ScrMode
  static Future<bool> rcItmLcdScrMode() async {
    int flg = 0;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    if (await RcFncChk.rcCheckStlMode()) {

    }
//      FNC(D_TchOldFuncWhiteDsp();
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_STL :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_STL :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_STL :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_STL :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.OD_STL :
        cMem.stat.scrMode = RcRegs.OD_ITM;
        flg = 1;
        break;
      case RcRegs.IV_STL :
        cMem.stat.scrMode = RcRegs.IV_ITM;
        flg = 1;
        break;
      case RcRegs.PD_STL :
        cMem.stat.scrMode = RcRegs.PD_ITM;
        flg = 1;
        break;
      case RcRegs.RG_INOUT:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_INOUT:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_INOUT:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_INOUT:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_BADD :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_BADD :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_BADD :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_BADD :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_TELST:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_TELST:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_TELST:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_TELST:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_CRDT :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_CRDT :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_CRDT :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_CRDT :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_EJCONF:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_EJCONF:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_EJCONF:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_EJCONF:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.OD_EJCONF:
        cMem.stat.scrMode = RcRegs.OD_ITM;
        flg = 1;
        break;
      case RcRegs.IV_EJCONF:
        cMem.stat.scrMode = RcRegs.IV_ITM;
        flg = 1;
        break;
      case RcRegs.PD_EJCONF:
        cMem.stat.scrMode = RcRegs.PD_ITM;
        flg = 1;
        break;
      case RcRegs.RG_EVOID:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_EVOID:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_EVOID:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_EVOID:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_EREFS:
      case RcRegs.RG_EREFI:
      case RcRegs.RG_EREF:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_EREFS:
      case RcRegs.VD_EREFI:
      case RcRegs.VD_EREF:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_EREFS:
      case RcRegs.TR_EREFI:
      case RcRegs.TR_EREF:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_EREFS:
      case RcRegs.SR_EREFI:
      case RcRegs.SR_EREF:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_ESVOIDS:
      case RcRegs.RG_ESVOIDI:
      case RcRegs.RG_ESVOID:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_ESVOIDS:
      case RcRegs.VD_ESVOIDI:
      case RcRegs.VD_ESVOID:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_ESVOIDS:
      case RcRegs.TR_ESVOIDI:
      case RcRegs.TR_ESVOID:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_ESVOIDS:
      case RcRegs.SR_ESVOIDI:
      case RcRegs.SR_ESVOID:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_ERCTFM:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_ERCTFM:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_ERCTFM:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_ERCTFM:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_EJFIND:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_EJFIND:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_EJFIND:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_EJFIND:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.OD_EJFIND:
        cMem.stat.scrMode = RcRegs.OD_ITM;
        flg = 1;
        break;
      case RcRegs.IV_EJFIND:
        cMem.stat.scrMode = RcRegs.IV_ITM;
        flg = 1;
        break;
      case RcRegs.PD_EJFIND:
        cMem.stat.scrMode = RcRegs.PD_ITM;
        flg = 1;
        break;
      case RcRegs.RG_CRDTVOIDS:
      case RcRegs.RG_CRDTVOIDI:
      case RcRegs.RG_CRDTVOID :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_CRDTVOIDS:
      case RcRegs.VD_CRDTVOIDI:
      case RcRegs.VD_CRDTVOID :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_CRDTVOIDS:
      case RcRegs.TR_CRDTVOIDI:
      case RcRegs.TR_CRDTVOID :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_CRDTVOIDS:
      case RcRegs.SR_CRDTVOIDI:
      case RcRegs.SR_CRDTVOID :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_PRECAVOIDS:
      case RcRegs.RG_PRECAVOIDI:
      case RcRegs.RG_PRECAVOID :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_PRECAVOIDS:
      case RcRegs.VD_PRECAVOIDI:
      case RcRegs.VD_PRECAVOID :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_PRECAVOIDS:
      case RcRegs.TR_PRECAVOIDI:
      case RcRegs.TR_PRECAVOID :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_PRECAVOIDS:
      case RcRegs.SR_PRECAVOIDI:
      case RcRegs.SR_PRECAVOID :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_TKISSU :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_TKISSU :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_TKISSU :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_TKISSU :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_SCNMBR :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_SCNMBR :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_SCNMBR :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_SCNMBR :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_CLSCNCL:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_CLSCNCL:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_CLSCNCL:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_CLSCNCL:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
/* TWNO_S2PR */
//   #if TW
//   case RG_TWNOSET: cMem.stat.scrMode = RcRegs.RG_ITM;
//   flg = 1;
//   break;
//   case VD_TWNOSET: cMem.stat.scrMode = RcRegs.VD_ITM;
//   flg = 1;
//   break;
//   case TR_TWNOSET: cMem.stat.scrMode = RcRegs.TR_ITM;
//   flg = 1;
//   break;
//   case SR_TWNOSET: cMem.stat.scrMode = RcRegs.SR_ITM;
//   flg = 1;
//   break;
//   case RG_TWNOSR : cMem.stat.scrMode = RcRegs.RG_ITM;
//   flg = 1;
//   break;
//   case VD_TWNOSR : cMem.stat.scrMode = RcRegs.VD_ITM;
//   flg = 1;
//   break;
//   case TR_TWNOSR : cMem.stat.scrMode = RcRegs.TR_ITM;
//   flg = 1;
//   break;
//   case SR_TWNOSR : cMem.stat.scrMode = RcRegs.SR_ITM;
//   flg = 1;
//   break;
// /* 04.May.06 */
//   case RG_TWNOREF: cMem.stat.scrMode = RcRegs.RG_ITM;
//   flg = 1;
//   break;
//   case VD_TWNOREF: cMem.stat.scrMode = RcRegs.VD_ITM;
//   flg = 1;
//   break;
//   case TR_TWNOREF: cMem.stat.scrMode = RcRegs.TR_ITM;
//   flg = 1;
//   break;
//   case SR_TWNOREF: cMem.stat.scrMode = RcRegs.SR_ITM;
//   flg = 1;
//   break;
//   #endif
//   #if CN_NSC
//   case RG_NSCCR: cMem.stat.scrMode = RcRegs.RG_ITM;
//   flg = 1;
//   break;
//   case VD_NSCCR: cMem.stat.scrMode = RcRegs.VD_ITM;
//   flg = 1;
//   break;
//   case TR_NSCCR: cMem.stat.scrMode = RcRegs.TR_ITM;
//   flg = 1;
//   break;
//   case SR_NSCCR: cMem.stat.scrMode = RcRegs.SR_ITM;
//   flg = 1;
//   break;
//   #endif
      case RcRegs.RG_CPWR :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_CPWR :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_CPWR :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_CPWR :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_MANUALMM :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_MANUALMM :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_MANUALMM :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_MANUALMM :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_CHGINOUT :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_CHGINOUT :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_CHGINOUT :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_CHGINOUT :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;

    // #if DEPARTMENT_STORE
    // case RG_ITMINF : cMem.stat.scrMode = RcRegs.RG_ITM;
    // flg = 1;
    // break;
    // case VD_ITMINF : cMem.stat.scrMode = RcRegs.VD_ITM;
    // flg = 1;
    // break;
    // case TR_ITMINF : cMem.stat.scrMode = RcRegs.TR_ITM;
    // flg = 1;
    // break;
    // case SR_ITMINF : cMem.stat.scrMode = RcRegs.SR_ITM;
    // flg = 1;
    // break;
    // case RG_TTLINF : cMem.stat.scrMode = RcRegs.RG_ITM;
    // flg = 1;
    // break;
    // case VD_TTLINF : cMem.stat.scrMode = RcRegs.VD_ITM;
    // flg = 1;
    // break;
    // case TR_TTLINF : cMem.stat.scrMode = RcRegs.TR_ITM;
    // flg = 1;
    // break;
    // case SR_TTLINF : cMem.stat.scrMode = RcRegs.SR_ITM;
    // flg = 1;
    // break;
    // case RG_REFDATE : cMem.stat.scrMode = RcRegs.RG_ITM;
    // flg = 1;
    // break;
    // case VD_REFDATE : cMem.stat.scrMode = RcRegs.VD_ITM;
    // flg = 1;
    // break;
    // case TR_REFDATE : cMem.stat.scrMode = RcRegs.TR_ITM;
    // flg = 1;
    // break;
    // case SR_REFDATE : cMem.stat.scrMode = RcRegs.SR_ITM;
    // flg = 1;
    // break;
    // #endif
      case RcRegs.RG_CHGLOAN:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_CHGLOAN:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_CHGLOAN:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_CHGLOAN:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_EDY_SETERRCONF :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.TR_EDY_SETERRCONF :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_CHGPTN :
        cMem.stat.scrMode = RcRegs.RG_ITM;
//			flg = 1; // 釣機両替のPGが登録画面へ戻ってからお金を払い出すので、入金状態に出来ない
        break;
      case RcRegs.VD_CHGPTN :
        cMem.stat.scrMode = RcRegs.VD_ITM;
//			flg = 1; // 釣機両替のPGが登録画面へ戻ってからお金を払い出すので、入金状態に出来ない
        break;
      case RcRegs.TR_CHGPTN :
        cMem.stat.scrMode = RcRegs.TR_ITM;
//			flg = 1; // 釣機両替のPGが登録画面へ戻ってからお金を払い出すので、入金状態に出来ない
        break;
      case RcRegs.SR_CHGPTN :
        cMem.stat.scrMode = RcRegs.SR_ITM;
//			flg = 1; // 釣機両替のPGが登録画面へ戻ってからお金を払い出すので、入金状態に出来ない
        break;
      case RcRegs.RG_TUO_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_TUO_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_TUO_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_TUO_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_TUOCARD_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_TUOCARD_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_TUOCARD_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_TUOCARD_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_MDA_CRDT_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_MDA_CRDT_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_MDA_CRDT_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_MDA_CRDT_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
    // #if MP1_PRINT
    // case RG_MP1PRN: cMem.stat.scrMode = RcRegs.RG_ITM;
    // flg = 1;
    // break;
    // case VD_MP1PRN: cMem.stat.scrMode = RcRegs.VD_ITM;
    // flg = 1;
    // break;
    // case TR_MP1PRN: cMem.stat.scrMode = RcRegs.TR_ITM;
    // flg = 1;
    // break;
    // case SR_MP1PRN: cMem.stat.scrMode = RcRegs.SR_ITM;
    // flg = 1;
    // break;
    // #endif
      case RcRegs.RG_CHGPTN_COOP_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
//			flg = 1; // 釣機両替のPGが登録画面へ戻ってからお金を払い出すので、入金状態に出来ない
        break;
      case RcRegs.VD_CHGPTN_COOP_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
//			flg = 1; // 釣機両替のPGが登録画面へ戻ってからお金を払い出すので、入金状態に出来ない
        break;
      case RcRegs.TR_CHGPTN_COOP_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
//			flg = 1; // 釣機両替のPGが登録画面へ戻ってからお金を払い出すので、入金状態に出来ない
        break;
      case RcRegs.SR_CHGPTN_COOP_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
//			flg = 1; // 釣機両替のPGが登録画面へ戻ってからお金を払い出すので、入金状態に出来ない
        break;
      case RcRegs.RG_SRCH_REG_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_SRCH_REG_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_SRCH_REG_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_SRCH_REG_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_WIZ_RENT_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_WIZ_RENT_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_WIZ_RENT_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_WIZ_RENT_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_ACB_STOP_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_ACB_STOP_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_ACB_STOP_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_ACB_STOP_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_QR_RPR :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_QR_RPR :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_QR_RPR :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_QR_RPR :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_ACCOUNT_OFFSET_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_ACCOUNT_OFFSET_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_ACCOUNT_OFFSET_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_ACCOUNT_OFFSET_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_CHARGESLIP_CHK_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM; //アヤハディオ様売掛伝票対応
        flg = 1;
        break;
      case RcRegs.VD_CHARGESLIP_CHK_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM; //アヤハディオ様売掛伝票対応
        flg = 1;
        break;
      case RcRegs.TR_CHARGESLIP_CHK_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM; //アヤハディオ様売掛伝票対応
        flg = 1;
        break;
      case RcRegs.SR_CHARGESLIP_CHK_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM; //アヤハディオ様売掛伝票対応
        flg = 1;
        break;
      case RcRegs.RG_DELIV_SVCS_DSP:
      case RcRegs.RG_DELIV_SVC_DSP:
        cMem.stat.scrMode = RcRegs.RG_ITM; //アヤハディオ様宅配発行対応
        flg = 1;
        break;
      case RcRegs.VD_DELIV_SVCS_DSP:
      case RcRegs.VD_DELIV_SVC_DSP:
        cMem.stat.scrMode = RcRegs.VD_ITM; //アヤハディオ様宅配発行対応
        flg = 1;
        break;
      case RcRegs.TR_DELIV_SVCS_DSP:
      case RcRegs.TR_DELIV_SVC_DSP:
        cMem.stat.scrMode = RcRegs.TR_ITM; //アヤハディオ様宅配発行対応
        flg = 1;
        break;
      case RcRegs.SR_DELIV_SVCS_DSP:
      case RcRegs.SR_DELIV_SVC_DSP:
        cMem.stat.scrMode = RcRegs.SR_ITM; //アヤハディオ様宅配発行対応
        flg = 1;
        break;
      case RcRegs.RG_REGASSIST_CASH_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM; //登録補助：現金入力画面
        flg = 1;
        break;
      case RcRegs.VD_REGASSIST_CASH_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM; //登録補助：現金入力画面
        flg = 1;
        break;
      case RcRegs.TR_REGASSIST_CASH_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM; //登録補助：現金入力画面
        flg = 1;
        break;
      case RcRegs.SR_REGASSIST_CASH_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM; //登録補助：現金入力画面
        flg = 1;
        break;
      case RcRegs.RG_OVERFLOW_MOVE_DSP:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_OVERFLOW_MOVE_DSP:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_OVERFLOW_MOVE_DSP:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_OVERFLOW_MOVE_DSP:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_OVERFLOW_MENTE_DSP:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_OVERFLOW_MENTE_DSP:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_OVERFLOW_MENTE_DSP:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_OVERFLOW_MENTE_DSP:
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_DPTS_ORGTRAN_DSP:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_DPTS_ORGTRAN_DSP:
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_DPTS_ORGTRAN_DSP:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_DPTS_MODIFY_DSP:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.TR_DPTS_MODIFY_DSP:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_REPICAPNT_MODIFY_DSP:
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.TR_REPICAPNT_MODIFY_DSP:
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_CREDIT_SIGN_ERR_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.TR_CREDIT_SIGN_ERR_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.VD_CREDIT_SIGN_ERR_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.SR_CREDIT_SIGN_ERR_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      case RcRegs.RG_UNREAD_CASH_AMT_DSP :
        cMem.stat.scrMode = RcRegs.RG_ITM;
        flg = 1;
        break;
      case RcRegs.VD_UNREAD_CASH_AMT_DSP :
        cMem.stat.scrMode = RcRegs.VD_ITM;
        flg = 1;
        break;
      case RcRegs.TR_UNREAD_CASH_AMT_DSP :
        cMem.stat.scrMode = RcRegs.TR_ITM;
        flg = 1;
        break;
      case RcRegs.SR_UNREAD_CASH_AMT_DSP :
        cMem.stat.scrMode = RcRegs.SR_ITM;
        flg = 1;
        break;
      default :
        flg = 0;
        break;
    }

    if (flg == 1) {
      await RcKyPlu.rcAnyTimeCinStartProc();
      atSing.fselfInoutChk = 0;
      return false;
    } else {
      return true;
    }
  }

  ///  関連tprxソース: rc_set.c - rcRfm_ScrMode
  static Future<bool> rcRfmScrMode() async {
    await rcMovScrMode();
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_ITM:
      case RcRegs.RG_SG_MNT:
      case RcRegs.RG_ACB_STOP_DSP:
      case RcRegs.RG_STL:
        cMem.stat.scrMode = RcRegs.RG_RFM;
        return false;
      case RcRegs.VD_ITM:
      case RcRegs.VD_ACB_STOP_DSP:
      case RcRegs.VD_STL:
        cMem.stat.scrMode = RcRegs.VD_RFM;
        return false;
      case RcRegs.TR_ITM:
      case RcRegs.TR_SG_MNT:
      case RcRegs.TR_ACB_STOP_DSP:
      case RcRegs.TR_STL:
        cMem.stat.scrMode = RcRegs.TR_RFM;
        return false;
      case RcRegs.SR_ITM:
      case RcRegs.SR_ACB_STOP_DSP:
      case RcRegs.SR_STL:
        cMem.stat.scrMode = RcRegs.SR_RFM;
        return false;
      default:
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcRfm_SubScrMode
  static Future<bool> rcRfmSubScrMode() async {
    await rcMovScrMode();
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.subScrMode) {
      case RcRegs.RG_ITM:
      case RcRegs.RG_STL:
      case RcRegs.RG_SITM:
        cMem.stat.subScrMode = RcRegs.RG_RFM;
        return false;
      case RcRegs.VD_ITM:
      case RcRegs.VD_STL:
      case RcRegs.VD_SITM:
        cMem.stat.subScrMode = RcRegs.VD_RFM;
        return false;
      case RcRegs.TR_ITM:
      case RcRegs.TR_STL:
      case RcRegs.TR_SITM:
        cMem.stat.subScrMode = RcRegs.TR_RFM;
        return false;
      case RcRegs.SR_ITM:
      case RcRegs.SR_STL:
      case RcRegs.SR_SITM:
        cMem.stat.subScrMode = RcRegs.SR_RFM;
        return false;
      default:
        break;
    }
    return true;
  }

  // TODO:00016 佐藤 定義のみ追加
  ///  関連tprxソース: rc_set.c - rcAdvanceIn_ScrMode
  static bool rcAdvanceInScrMode() {
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcAdvanceOut_ScrMode
  static bool rcAdvanceOutScrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.scrType = RcRegs.LCD_104Inch;
    cMem.stat.bkScrMode = cMem.stat.scrMode;
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_ITM:
      case RcRegs.RG_STL:
        cMem.stat.scrMode = RcRegs.RG_ADVANCE_OUT_DSP;
        return false;
      case RcRegs.VD_ITM:
      case RcRegs.VD_STL:
        cMem.stat.scrMode = RcRegs.VD_ADVANCE_OUT_DSP;
        return false;
      case RcRegs.TR_ITM:
      case RcRegs.TR_STL:
        cMem.stat.scrMode = RcRegs.TR_ADVANCE_OUT_DSP;
        return false;
      case RcRegs.SR_ITM:
      case RcRegs.SR_STL:
        cMem.stat.scrMode = RcRegs.TR_ADVANCE_OUT_DSP;
        return false;
      default:
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcChgCin_ScrMode
  /// TODO:00010 長田 定義のみ追加
  static bool rcChgCinScrMode() {
    return false;
  }

  ///  関連tprxソース: rc_set.c - Cash_Notice_Reset
  static Future<void> cashNoticeReset() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      tsBuf.cash.notice_flg = 0;
      tsBuf.cash.notice_msg_cd = 0;
      if (tsBuf.chk.kycash_redy_flg == 2) {
        tsBuf.chk.kycash_redy_flg = 1; // 入金完了通知の優先度を戻す
      }
    }
  }

  ///  関連tprxソース: rc_set.c - Cash_Notice_Set
  static Future<void> cashNoticeSet(int errNo) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      tsBuf.cash.notice_flg = 1;
      tsBuf.cash.notice_msg_cd = errNo;

      if (tsBuf.chk.kycash_redy_flg == 1) {
        tsBuf.chk.kycash_redy_flg = 2; // 入金完了通知の優先度を下げる
      }
    }
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rc_set.c - rcTimer_Reset
  static void rcTimerReset() {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rc_set.c - rcItmSubLcd_ScrMode
  static bool rcItmSubLcdScrMode() {
    return false;
  }

  ///  関連tprxソース: rc_set.c - Cash_IntStat_Set
  static Future<void> cashIntStatSet() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      tsBuf.cash.int_stat = 1;
    }
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rc_set.c - rc28DispStatusInit
  static void rc28DispStatusInit() {
    return;
  }

  ///  関連tprxソース: rc_set.c - rcacb_stopdsp_ScrMode
  static bool rcAcbStopDspScrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_CHGPTN:
      case RcRegs.RG_CHGPTN_COOP_DSP:
      case RcRegs.RG_ITM:
      case RcRegs.RG_STL:
        cMem.stat.scrMode = RcRegs.RG_ACB_STOP_DSP;
        return false;
      case RcRegs.VD_CHGPTN:
      case RcRegs.VD_CHGPTN_COOP_DSP:
      case RcRegs.VD_ITM:
      case RcRegs.VD_STL:
        cMem.stat.scrMode = RcRegs.VD_ACB_STOP_DSP;
        return false;
      case RcRegs.TR_CHGPTN:
      case RcRegs.TR_CHGPTN_COOP_DSP:
      case RcRegs.TR_ITM:
      case RcRegs.TR_STL:
        cMem.stat.scrMode = RcRegs.TR_ACB_STOP_DSP;
        return false;
      case RcRegs.SR_CHGPTN:
      case RcRegs.SR_CHGPTN_COOP_DSP:
      case RcRegs.SR_ITM:
      case RcRegs.SR_STL:
        cMem.stat.scrMode = RcRegs.SR_ACB_STOP_DSP;
        return false;
      default:
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - Cash_IntStat_Reset
  static Future<void> cashIntStatReset() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "cashIntStatReset() rxMemRead error\n");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      tsBuf.cash.int_stat = 0;
    }
  }

  ///  関連tprxソース: rc_set.c - rcChgRef_ScrMode
  static Future<int> rcChgRefScrMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    int oldScrMode = cMem.stat.scrMode;

    await RcSet.rcMovScrMode();
    cMem.stat.scrType = RcRegs.LCD_104Inch;
    if (CompileFlag.SELF_GATE) {
      switch (cMem.stat.scrMode) {
        case RcRegs.RG_ITM:
        case RcRegs.RG_SG_MNT:
        case RcRegs.RG_QC_MENTE:
        case RcRegs.RG_ACB_STOP_DSP:
        case RcRegs.RG_STL:
          cMem.stat.scrMode = RcRegs.RG_CREF;
          return oldScrMode;
        case RcRegs.VD_ITM:
        case RcRegs.VD_ACB_STOP_DSP:
        case RcRegs.VD_STL:
          cMem.stat.scrMode = RcRegs.VD_CREF;
          return oldScrMode;
        case RcRegs.TR_ITM:
        case RcRegs.TR_SG_MNT:
        case RcRegs.TR_QC_MENTE:
        case RcRegs.TR_ACB_STOP_DSP:
        case RcRegs.TR_STL:
          cMem.stat.scrMode = RcRegs.TR_CREF;
          return oldScrMode;
        case RcRegs.SR_ITM:
        case RcRegs.SR_ACB_STOP_DSP:
        case RcRegs.SR_STL:
          cMem.stat.scrMode = RcRegs.SR_CREF;
          return oldScrMode;
        default:
          return 0;
      }
    } else {
      switch (cMem.stat.scrMode) {
        case RcRegs.RG_ITM:
        case RcRegs.RG_QC_MENTE:
        case RcRegs.RG_ACB_STOP_DSP:
        case RcRegs.RG_STL:
          cMem.stat.scrMode = RcRegs.RG_CREF;
          return oldScrMode;
        case RcRegs.VD_ITM:
        case RcRegs.VD_ACB_STOP_DSP:
        case RcRegs.VD_STL:
          cMem.stat.scrMode = RcRegs.VD_CREF;
          return oldScrMode;
        case RcRegs.TR_ITM:
        case RcRegs.TR_QC_MENTE:
        case RcRegs.TR_ACB_STOP_DSP:
        case RcRegs.TR_STL:
          cMem.stat.scrMode = RcRegs.TR_CREF;
          return oldScrMode;
        case RcRegs.SR_ITM:
        case RcRegs.SR_ACB_STOP_DSP:
        case RcRegs.SR_STL:
          cMem.stat.scrMode = RcRegs.SR_CREF;
          return oldScrMode;
        default:
          return 0;
      }
    }
  }

  ///  関連tprxソース: rc_set.c - rcERefI_SubScrMode
  static bool rcERefISubScrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.subScrMode) {
      case RcRegs.RG_EREFS:
        cMem.stat.subScrMode = RcRegs.RG_EREFI;
        return false;
      case RcRegs.VD_EREFS:
        cMem.stat.subScrMode = RcRegs.VD_EREFI;
        return false;
      case RcRegs.TR_EREFS:
        cMem.stat.subScrMode = RcRegs.TR_EREFI;
        return false;
      case RcRegs.SR_EREFS:
        cMem.stat.subScrMode = RcRegs.SR_EREFI;
        return false;
      default:
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcESVoidI_SubScrMode
  static bool rcESVoidISubScrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.subScrMode) {
      case RcRegs.RG_ESVOIDSD:
      case RcRegs.RG_ESVOIDS:
        cMem.stat.subScrMode = RcRegs.RG_ESVOIDI;
        return false;
      case RcRegs.VD_ESVOIDSD:
      case RcRegs.VD_ESVOIDS:
        cMem.stat.subScrMode = RcRegs.VD_ESVOIDI;
        return false;
      case RcRegs.TR_ESVOIDSD:
      case RcRegs.TR_ESVOIDS:
        cMem.stat.subScrMode = RcRegs.TR_ESVOIDI;
        return false;
      case RcRegs.SR_ESVOIDSD:
      case RcRegs.SR_ESVOIDS:
        cMem.stat.subScrMode = RcRegs.SR_ESVOIDI;
        return false;
      default:
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcESVoidI_SubScrMode
  static bool rcPrecaVoidISubScrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.subScrMode) {
      case RcRegs.RG_PRECAVOIDS:
        cMem.stat.subScrMode = RcRegs.RG_PRECAVOIDI;
        return false;
      case RcRegs.VD_PRECAVOIDS:
        cMem.stat.subScrMode = RcRegs.VD_PRECAVOIDI;
        return false;
      case RcRegs.TR_PRECAVOIDS:
        cMem.stat.subScrMode = RcRegs.TR_PRECAVOIDI;
        return false;
      case RcRegs.SR_PRECAVOIDS:
        cMem.stat.subScrMode = RcRegs.SR_PRECAVOIDI;
        return false;
      default:
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcClearKy_Item
  static Future<void> rcClearKyItem() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_VOID.keyId]) ||
        (!RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DECIMAL.keyId])) &&
            (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId]))) {
      rcClearRepeatBuf();
    }
    if (RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
      RcFncChk.rcKyResetStat(
          cMem.keyStat, RcRegs.MACRO0 + RcRegs.MACRO1 + RcRegs.MACRO3);
      if (((await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) &&
          (RcFncChk.rcChkErrNon())) || /* Corresponding Half Message for Dual */
          ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
              (tsBuf.cash.err_stat == 0))) {
        RcRegs.kyStR4(cMem.keyStat, FncCode.KY_FNAL.keyId);
      }
      RcRegs.kyStS1(cMem.keyStat, FncCode.KY_REG.keyId);
    } else {
      RcFncChk.rcKyResetStat(
          cMem.keyStat, RcRegs.MACRO0 + RcRegs.MACRO1 + RcRegs.MACRO3);
      if (((await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) &&
          (RcFncChk.rcChkErrNon())) || /* Corresponding Half Message for Dual */
          ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
              (tsBuf.cash.err_stat == 0))) {
        RcRegs.kyStR4(cMem.keyStat, FncCode.KY_FNAL.keyId);
      }
      RcRegs.kyStS3(cMem.keyStat, FncCode.KY_FNAL.keyId);
    }
    await RcItmDsp.rcMarkKyDisplay(0);
    if (CompileFlag.PRESET_ITEM) {
      if (await RegistInitData.presetItemChk()) {
        RcStlLcd.rcStlLcdItems(RegsDef.tran.itemSubTtl);
      }
    }
    Rc28dsp.rcTabDataDisplay(RcKyTab.tabInfo.nextDspTab);
    if (FbInit.subinitMainSingleSpecialChk()) {
      Rc28dsp.rcTabDataStlDisplay(
          RcKyTab.tabInfo.nextDspTab, RegsDef.dualSubttl, TabDef.DATA_DSP);
    }
  }

  ///  関連tprxソース: rc_set.c - rcClearPlu_Reg
  static void rcClearPluReg() {
    if (!(RcSysChk.rcCheckPrchker() ||
        RcSysChk.rcCheckMobilePos() ||
        RcSysChk.rcCheckWiz())) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.working.pluReg = TItemLog();
      cMem.working.pluReg.t10000.posName =
          cMem.working.pluReg.t10000.posName.padLeft(301, " ");
    }
  }

  ///  関連tprxソース: rc_set.c - rcInc_itmcnt
  static Future<void> rcIncItmCnt() async {
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    mem.tTtllog.t100001Sts.itemlogCnt++;
    cMem.regsItemlogCnt = mem.tTtllog.t100001Sts.itemlogCnt;
    if (CompileFlag.BDL_PER) {
      if (((await CmCksys.cmIchiyamaMartSystem() != 0) ||
          (await RcSysChk.rcChkBdlMultiSelectSystem()))
          && !(await RckyMul.rcChkKyMulBusyIchiyama(cMem.working.dataReg.kMul1)) ) {
        // TODO:00002 佐野 202408向け仕様対象外のため、コメント化
        //rcstl_Ichiyama_Bdl_itm_Clear();
      }
    }

    rcSetRegNearEnd();
  }

  ///  関連tprxソース: rc_set.c - rcSet_RegNearEnd
  static void rcSetRegNearEnd() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    int nearendCnt = cBuf.dbTrm.nearendDsp;
    int itemMax = cMem.ItemMax;
    if (nearendCnt != 0) {
      if ((nearendCnt < itemMax) && ((itemMax - nearendCnt) == mem.tTtllog.t100001Sts.itemlogCnt)) {
        cMem.stat.clkStatus |= RcRegs.STAT_RegNearEnd;
      }
    }
  }

  ///  関連tprxソース: rc_set.c - rcSG_Mnt_ScrMode
  static bool rcSGMntScrMode() {
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.stat.scrMode) {
      case RcRegs.RG_STL:
      case RcRegs.RG_SG_LIST:
      case RcRegs.RG_SG_PRE:
      case RcRegs.RG_SG_MBRSCN:
      case RcRegs.RG_NEWSG_STRBTN:
      case RcRegs.RG_NEWSG_EXP:
      case RcRegs.RG_INOUT:
      case RcRegs.RG_CCIN:
      case RcRegs.RG_CREF:
      case RcRegs.RG_CHGINOUT:
      case RcRegs.RG_CHGLOAN:
      case RcRegs.RG_SG_STR:
      case RcRegs.RG_EJCONF:
      case RcRegs.RG_NEWSG_MDSLCT:
      case RcRegs.RG_SG_WRT_WGT_DSP:
      case RcRegs.RG_SG_INST:
      case RcRegs.RG_SRCH_REG_DSP:
      case RcRegs.RG_WIZ_RENT_DSP:
      case RcRegs.RG_QC_USBCAMERADSP:
      case RcRegs.RG_QC_MENTE:
      case RcRegs.RG_CHGPTN_COOP_DSP:
        cMem.stat.scrMode = RcRegs.RG_SG_MNT;
        return false;
      case RcRegs.TR_STL:
      case RcRegs.TR_SG_LIST:
      case RcRegs.TR_SG_PRE:
      case RcRegs.TR_SG_MBRSCN:
      case RcRegs.TR_NEWSG_STRBTN:
      case RcRegs.TR_NEWSG_EXP:
      case RcRegs.TR_INOUT:
      case RcRegs.TR_CCIN:
      case RcRegs.TR_CREF:
      case RcRegs.TR_CHGINOUT:
      case RcRegs.TR_CHGLOAN:
      case RcRegs.TR_SG_STR:
      case RcRegs.TR_EJCONF:
      case RcRegs.TR_NEWSG_MDSLCT:
      case RcRegs.TR_SG_WRT_WGT_DSP:
      case RcRegs.TR_SG_INST:
      case RcRegs.TR_SRCH_REG_DSP:
      case RcRegs.TR_WIZ_RENT_DSP:
      case RcRegs.TR_QC_USBCAMERADSP:
      case RcRegs.TR_QC_MENTE:
      case RcRegs.TR_CHGPTN_COOP_DSP:
        cMem.stat.scrMode = RcRegs.TR_SG_MNT;
        return false;
      default:
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcSG_End_ScrMode
  static Future<bool> rcSGEndScrMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    await rcMovScrMode();
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_STL:
      case RcRegs.RG_SG_RWRD:
      case RcRegs.RG_SG_PANAMBR_DSP:
      case RcRegs.RG_SG_MCP200_DSP:
      case RcRegs.RG_SG_DMC_SLCT:
      case RcRegs.RG_SG_MCP200_2:
      case RcRegs.RG_SG_MBRSCN_2:
      case RcRegs.RG_SG_MBRINPUT:
      case RcRegs.RG_SG_HT2980:
      case RcRegs.RG_SG_FLRD:
        cMem.stat.scrMode = RcRegs.RG_SG_END;
        return false;
      case RcRegs.TR_STL:
      case RcRegs.TR_SG_RWRD:
      case RcRegs.TR_SG_PANAMBR_DSP:
      case RcRegs.TR_SG_MCP200_DSP:
      case RcRegs.TR_SG_DMC_SLCT:
      case RcRegs.TR_SG_MCP200_2:
      case RcRegs.TR_SG_MBRSCN_2:
      case RcRegs.TR_SG_MBRINPUT:
      case RcRegs.TR_SG_HT2980:
      case RcRegs.TR_SG_FLRD:
        cMem.stat.scrMode = RcRegs.TR_SG_END;
        return false;
      default:
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcQC_StartDsp_ScrMode
  static Future<bool> rcQCStartDspScrMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_ITM:
      case RcRegs.RG_STL:
      case RcRegs.RG_QC_CASH:
      case RcRegs.RG_QC_CRDT:
      case RcRegs.RG_QC_SLCT:
      case RcRegs.RG_QC_ITEM:
      case RcRegs.RG_QC_CALL:
      //case RcRegs.RG_QC_CRDTUSE:
      case RcRegs.RG_QC_CRDTEND:
      /*
      case RcRegs.RG_QC_EDY:
      case RcRegs.RG_QC_EDYUSE:
      case RcRegs.RG_QC_EDYEND:
       */
      case RcRegs.RG_QC_EMNY_SLCT:
      case RcRegs.RG_QC_EMNY_EDY:
      case RcRegs.RG_QC_EMNY_EDYEND:
      case RcRegs.RG_QC_SUICA_TCH:
      /*
      case RcRegs.RG_QC_SUICA_USE:
      case RcRegs.RG_QC_SUICA_BAL:
      case RcRegs.RG_QC_SUICA_END:
       */
      case RcRegs.RG_QC_SUICA_CHK:
      /*
      case RcRegs.RG_QC_SUICA_CHKAF:
      case RcRegs.RG_QC_SUICA_ALL:
      case RcRegs.RG_QC_SUICA_TRAN_TIME:
      case RcRegs.RG_CHGTRAN_DSP:
       */
      case RcRegs.RG_QC_PREPAID_READ:
      case RcRegs.RG_QC_PREPAID_PAY:
      /*
      case RcRegs.RG_QC_PREPAID_END:
       */
      case RcRegs.RG_QC_PREPAID_BALANCESHORT:
      case RcRegs.RG_QC_PREPAID_ENTRY:
      /*
      case RcRegs.RG_QC_PRECHARGE_END:
       */
      case RcRegs.RG_QC_CHARGE_ITEM_SLECT_DSP:
      /*
      case RcRegs.RG_QC_NIMOCA_YES_NO_DSP:
      case RcRegs.RG_QC_RECEIPT_SELECT_DSP:
      case RcRegs.RG_QC_NOT_NIMOCA_DSP:
      case RcRegs.RG_QC_ANYCUST_CARDSELECT_DSP:
      case RcRegs.RG_QC_ANYCUST_CARDREAD_DSP:
      case RcRegs.RG_QC_BCDPAY_READ:
      case RcRegs.RG_QC_BCDPAY_END:
      case RcRegs.RG_QC_BCDPAY_BALANCESHORT:
      case RcRegs.RG_QC_BCDPAY_QR_READ:
      case RcRegs.RG_QC_MBR_N_SLCT:
       */
      case RcRegs.RG_QC_MBR_N_READ:
      case RcRegs.RG_QC_MENTE:
      /*
      case RcRegs.RG_QC_DPTS_ENTDSP:
      case RcRegs.RG_QC_DPTS_USE:
      case RcRegs.RG_QC_DPTS_END:
      case RcRegs.RG_QC_EMPLOYEECARD_PAYDSP:
      case RcRegs.RG_QC_EMPLOYEECARD_PAYEND_DSP:
      case RcRegs.RG_QC_COGCAPNT_ENTDSP:
      case RcRegs.RG_QC_COGCAPNT_USEDSP:
      case RcRegs.RG_QC_COGCAPNT_ENDDSP:
       */
      case RcRegs.RG_QC_QP_DSP:
      case RcRegs.RG_QC_ID_DSP:
      case RcRegs.RG_QC_ID_END_DSP:
      /*
      case RcRegs.RG_QC_QP_END_DSP:
      case RcRegs.RG_QC_REPICAPNT_ENTDSP:
      case RcRegs.RG_QC_REPICAPNT_USEDSP:
      case RcRegs.RG_QC_REPICAPNT_ENDDSP:
      case RcRegs.RG_QC_REPICAPNT_READ:
       */
      case RcRegs.RG_QC_EMNY_PRECA_DSP:
      case RcRegs.RG_QC_EMNY_PRECAEND_DSP:
      /*
      case RcRegs.RG_QC_VESCA_USE:
      case RcRegs.RG_QC_VESCA_END:
      case RcRegs.RG_QC_RPTS_MBR_YES_NO_DSP:
      case RcRegs.RG_QC_RPTS_MBR_READ_DSP:
      case RcRegs.RG_QC_TOMO_USE:
      case RcRegs.RG_QC_TOMO_END:
      case RcRegs.RG_QC_RPTS_PAY_CONF_DSP:
      case RcRegs.RG_QCASHIER_MEMBER_READ_SELECT_DSP:
      case RcRegs.RG_QCASHIER_MEMBER_READ_ENTRY_DSP:
      case RcRegs.RG_QC_NIMOCA_CANCEL_YES_NO_DSP:
       */
        cMem.stat.scrMode = RcRegs.RG_QC_START;
        return false;
      case RcRegs.RG_QC_SUSDSP:
        if (RcFncChk.rcQCCheckSusDspOverFlowType()) {
          cMem.stat.scrMode = RcRegs.RG_QC_START;
          await RcQcDsp.rcQCSusDspOverFlowTypeSet(0);
          return false;
        } else {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcQSet.rcQCStartDspScrMode(): Set fail ScrMode[${cMem.stat
                  .scrMode}] overflow_flg[${RcFncChk
                  .rcQCCheckSusDspOverFlowType()}]");
        }
        break;
      case RcRegs.TR_ITM:
      case RcRegs.TR_STL:
      case RcRegs.TR_QC_CASH:
      case RcRegs.TR_QC_CRDT:
      case RcRegs.TR_QC_SLCT:
      case RcRegs.TR_QC_ITEM:
      case RcRegs.TR_QC_CALL:
      //case RcRegs.TR_QC_CRDTUSE:
      case RcRegs.TR_QC_CRDTEND:
      /*
      case RcRegs.TR_QC_EDY:
      case RcRegs.TR_QC_EDYUSE:
      case RcRegs.TR_QC_EDYEND:
       */
      case RcRegs.TR_QC_EMNY_SLCT:
      case RcRegs.TR_QC_EMNY_EDY:
      case RcRegs.TR_QC_EMNY_EDYEND:
      case RcRegs.TR_QC_SUICA_TCH:
      /*
      case RcRegs.TR_QC_SUICA_USE:
      case RcRegs.TR_QC_SUICA_BAL:
      case RcRegs.TR_QC_SUICA_END:
       */
      case RcRegs.TR_QC_SUICA_CHK:
      /*
      case RcRegs.TR_QC_SUICA_CHKAF:
      case RcRegs.TR_QC_SUICA_ALL:
      case RcRegs.TR_QC_SUICA_TRAN_TIME:
      case RcRegs.TR_CHGTRAN_DSP:
      case RcRegs.TR_QC_PREPAID_READ:
      case RcRegs.TR_QC_PREPAID_PAY:
      case RcRegs.TR_QC_PREPAID_END:
      case RcRegs.TR_QC_PREPAID_BALANCESHORT:
      case RcRegs.TR_QC_PREPAID_ENTRY:
      case RcRegs.TR_QC_PRECHARGE_END:
      case RcRegs.TR_QC_CHARGE_ITEM_SLECT_DSP:
      case RcRegs.TR_QC_NIMOCA_YES_NO_DSP:
      case RcRegs.TR_QC_RECEIPT_SELECT_DSP:
      case RcRegs.TR_QC_NOT_NIMOCA_DSP:
      case RcRegs.TR_QC_ANYCUST_CARDSELECT_DSP:
      case RcRegs.TR_QC_ANYCUST_CARDREAD_DSP:
      case RcRegs.TR_QC_BCDPAY_READ:
      case RcRegs.TR_QC_BCDPAY_END:
      case RcRegs.TR_QC_BCDPAY_BALANCESHORT:
      case RcRegs.TR_QC_BCDPAY_QR_READ:
      case RcRegs.TR_QC_MBR_N_SLCT:
       */
      case RcRegs.TR_QC_MBR_N_READ:
      case RcRegs.TR_QC_MENTE:
      /*
      case RcRegs.TR_QC_DPTS_ENTDSP:
      case RcRegs.TR_QC_DPTS_USE:
      case RcRegs.TR_QC_DPTS_END:
      case RcRegs.TR_QC_EMPLOYEECARD_PAYDSP:
      case RcRegs.TR_QC_EMPLOYEECARD_PAYEND_DSP:
      case RcRegs.TR_QC_COGCAPNT_ENTDSP:
      case RcRegs.TR_QC_COGCAPNT_USEDSP:
      case RcRegs.TR_QC_COGCAPNT_ENDDSP:
       */
      case RcRegs.TR_QC_QP_DSP:
      case RcRegs.TR_QC_ID_DSP:
      case RcRegs.TR_QC_ID_END_DSP:
      /*
      case RcRegs.TR_QC_QP_END_DSP:
      case RcRegs.TR_QC_REPICAPNT_ENTDSP:
      case RcRegs.TR_QC_REPICAPNT_USEDSP:
      case RcRegs.TR_QC_REPICAPNT_ENDDSP:
      case RcRegs.TR_QC_REPICAPNT_READ:
       */
      case RcRegs.TR_QC_EMNY_PRECA_DSP:
      case RcRegs.TR_QC_EMNY_PRECAEND_DSP:
      /*
      case RcRegs.TR_QC_VESCA_USE:
      case RcRegs.TR_QC_VESCA_END:
      case RcRegs.TR_QC_RPTS_MBR_YES_NO_DSP:
      case RcRegs.TR_QC_RPTS_MBR_READ_DSP:
      case RcRegs.TR_QC_TOMO_USE:
      case RcRegs.TR_QC_TOMO_END:
      case RcRegs.TR_QC_RPTS_PAY_CONF_DSP:
      case RcRegs.TR_QCASHIER_MEMBER_READ_SELECT_DSP:
      case RcRegs.TR_QCASHIER_MEMBER_READ_ENTRY_DSP:
      case RcRegs.TR_QC_NIMOCA_CANCEL_YES_NO_DSP:
       */
        cMem.stat.scrMode = RcRegs.TR_QC_START;
        return false;
      case RcRegs.TR_QC_SUSDSP:
        if (RcFncChk.rcQCCheckSusDspOverFlowType()) {
          cMem.stat.scrMode = RcRegs.TR_QC_START;
          await RcQcDsp.rcQCSusDspOverFlowTypeSet(0);
          return false;
        } else {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcQSet.rcQCStartDspScrMode(): Set fail ScrMode[${cMem.stat
                  .scrMode}] overflow_flg[${RcFncChk
                  .rcQCCheckSusDspOverFlowType()}]");
        }
        break;
      default:
        if (!RcFncChk.rcQCCheckStartDspMode()) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcQSet.rcQCStartDspScrMode(): Set fail ScrMode[${cMem.stat
                  .scrMode}]");
        }
        break;
    }
    return true;
  }

  /// 登録開始したシステム日時を登録のメモリにセットする (YYYY-MM-DD HH:MM:SS)
  /// 引数:[tid] タスクID
  ///	引数:[txtWtFlg] QRデータ書き込みフラグ
  ///  関連tprxソース: rc_set.c - rcSet_StartTime
  static Future<void> rcSetStartTime(TprMID tid, int txtWtFlg) async {
    if (RcFncChk.rcCheckRegistration()) {
      return; // 登録中はセットしない
    }
    if (RcqrCom.qrTxtStatus == QrTxtStatus.QR_TXT_STATUS_READ.index) {
      TprLog().logAdd(tid, LogLevelDefine.normal, "QR Read Start Time Set Skip");
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    // システム日時の格納
    mem.tHeader.starttime = "";
    DateUtil.dateTimeChange(null, DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE,
        DateTimeFormatKind.FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS_COLON, DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);

    // 共有メモリの更新
    if ((await RcFncChk.rcCheckItmMode()) ||
        (await RcFncChk.rcCheckStlMode())) {
      Rxregstr.rxSetShmUpdate(await RcSysChk.getTid());
    }

    if (cBuf.dbTrm.sameItem1prcTran != 0) {
      if ((await RcSysChk.rcQRChkPrintSystem()) && (txtWtFlg != 0)) {
        await RcqrCom.rcQRSystemOthToTxt(QR_REG_STARTTIME);
      }
    }
    return;
  }

  /// 関連tprxソース: rc_set.c - rcQC_MenteDsp_ScrMode
  static Future<bool> rcQCMenteDspScrMode() async {
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.stat.scrMode) {
      case RcRegs.RG_QC_ITEM :
      case RcRegs.RG_QC_STAFF :
      case RcRegs.RG_QC_PASWD :
      case RcRegs.RG_INOUT :
      case RcRegs.RG_CCIN :
      case RcRegs.RG_CREF :
      case RcRegs.RG_CHGINOUT :
      case RcRegs.RG_CHGLOAN :
      case RcRegs.RG_CHGTRAN_DSP :
      case RcRegs.RG_CHGCHK_DSP :
      case RcRegs.RG_EJCONF :
      case RcRegs.RG_ESVOID :
      case RcRegs.RG_ESVOIDI :
      case RcRegs.RG_ESVOIDS :
      case RcRegs.RG_SRCH_REG_DSP :
      case RcRegs.RG_WIZ_RENT_DSP :
      case RcRegs.RG_QC_SUSDSP :
      case RcRegs.RG_QC_USBCAMERADSP:
      case RcRegs.RG_QC_PLUADD :
      case RcRegs.RG_STL:
      case RcRegs.RG_SG_PRE:
      case RcRegs.RG_SG_MBRCHK:
      case RcRegs.RG_SG_MBRSCN:
      case RcRegs.RG_NEWSG_STRBTN:
      case RcRegs.RG_SG_MNT:
      case RcRegs.RG_QC_BCDPAY_QR_READ :
      case RcRegs.RG_QC_BCDPAY_READ :
      case RcRegs.RG_QC_BCDPAY_BALANCESHORT :
      case RcRegs.RG_SG_LIST:
      case RcRegs.RG_CHGPTN_COOP_DSP:
      case RcRegs.RG_OVERFLOW_MOVE_DSP:
      case RcRegs.RG_OVERFLOW_MENTE_DSP:
      case RcRegs.RG_QC_QP_DSP:
      case RcRegs.RG_QC_ID_DSP:
      case RcRegs.RG_QC_DPTS_ENTDSP :
      case RcRegs.RG_QC_COGCAPNT_ENTDSP :
      case RcRegs.RG_QC_REPICAPNT_ENTDSP :
      case RcRegs.RG_ERCTFM :
      case RcRegs.RG_SG_RPTSMBRCHK:
      case RcRegs.RG_UNREAD_CASH_AMT_DSP:
      case RcRegs.RG_HCARD :
      case RcRegs.RG_CASHBACK_START_DSP :
      case RcRegs.RG_CASHBACK_POINTENTRY_DSP :
        cMem.stat.scrMode = RcRegs.RG_QC_MENTE;
        return false;
      case RcRegs.TR_QC_ITEM :
      case RcRegs.TR_QC_STAFF :
      case RcRegs.TR_QC_PASWD :
      case RcRegs.TR_INOUT :
      case RcRegs.TR_CCIN :
      case RcRegs.TR_CREF :
      case RcRegs.TR_CHGINOUT :
      case RcRegs.TR_CHGLOAN :
      case RcRegs.TR_CHGTRAN_DSP :
      case RcRegs.TR_CHGCHK_DSP :
      case RcRegs.TR_EJCONF :
      case RcRegs.TR_ESVOID :
      case RcRegs.TR_ESVOIDI :
      case RcRegs.TR_ESVOIDS :
      case RcRegs.TR_SRCH_REG_DSP :
      case RcRegs.TR_WIZ_RENT_DSP :
      case RcRegs.TR_QC_SUSDSP :
      case RcRegs.TR_QC_USBCAMERADSP:
      case RcRegs.TR_QC_PLUADD :
      case RcRegs.TR_STL:
      case RcRegs.TR_SG_PRE:
      case RcRegs.TR_SG_MBRCHK:
      case RcRegs.TR_SG_MBRSCN:
      case RcRegs.TR_NEWSG_STRBTN:
      case RcRegs.TR_SG_MNT:
      case RcRegs.TR_QC_BCDPAY_QR_READ :
      case RcRegs.TR_QC_BCDPAY_READ :
      case RcRegs.TR_QC_BCDPAY_BALANCESHORT :
      case RcRegs.TR_SG_LIST:
      case RcRegs.TR_CHGPTN_COOP_DSP:
      case RcRegs.TR_OVERFLOW_MOVE_DSP:
      case RcRegs.TR_OVERFLOW_MENTE_DSP:
      case RcRegs.TR_QC_QP_DSP:
      case RcRegs.TR_QC_ID_DSP:
      case RcRegs.TR_QC_DPTS_ENTDSP :
      case RcRegs.TR_QC_COGCAPNT_ENTDSP :
      case RcRegs.TR_QC_REPICAPNT_ENTDSP :
      case RcRegs.TR_ERCTFM :
      case RcRegs.TR_SG_RPTSMBRCHK:
      case RcRegs.TR_UNREAD_CASH_AMT_DSP:
      case RcRegs.TR_HCARD :
      case RcRegs.TR_CASHBACK_START_DSP :
      case RcRegs.TR_CASHBACK_POINTENTRY_DSP :
        cMem.stat.scrMode = RcRegs.TR_QC_MENTE;
        return false;
      default :
        if (!RcFncChk.rcQCCheckMenteDspMode()) {
          log = "rcQC_MenteDsp_ScrMode Set fail ScrMode[${cMem.stat.scrMode}]";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
        }
        break;
    }
    return true;
  }

  ///  関連tprxソース: rc_set.c - rcSet_DscBar_Data
  static Future<int> rcSetDscBarData() async {
    int ret = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcItmChk.rcCheckGs1BarItem()) {
      cMem.dscBar?.dscPluCd = cMem.gs1Bar!.pluCd;
    } else {
      cMem.dscBar?.dscPluCd = cMem.dscBar!.dscBarCd1.substring(2, 12);
      cMem.dscBar?.dscPluCd += cMem.dscBar!.dscBarCd2.substring(2, 5);
    }
    ret = await rcSetDscBarDscData();
    if ((cMem.dscBar?.dscBarType == "2") &&
        (cMem.dscBar!.dscBarData > 99)) {
      cMem.dscBar?.dscBarType = "0";
      cMem.dscBar?.dscBarData = 0;
    }
    return ret;
  }

  ///  関連tprxソース: rc_set.c - rcSet_DscBar_DscData
  static Future<int> rcSetDscBarDscData() async {
    String? prcData = "";
    String? dscData = "";
    String? dscDataOff = "";
    String log = "";
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return DlgConfirmMsgKind.MSG_NONE.dlgId;
    }
    RxCommonBuf pCom = xRet.object;

    if (await CmCksys.cmItemPrcReductionCouponSystem() != 0) {
      cMem.dscBar?.dscBarType = cMem.dscBar!.dscBarCd2[6];
      switch (cMem.dscBar?.dscBarType) {
        case "4":
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
              "rcSetDscBarDscData : coupon flg${cMem.dscBar?.dscBarType}");
          dscData = cMem.dscBar?.dscBarCd2.substring(7, 12);
          cMem.dscBar?.dscBarData = int.parse(dscData!);
          return DlgConfirmMsgKind.MSG_NONE.dlgId;
        case "5":
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
              "rcSetDscBarDscData : coupon flg${cMem.dscBar?.dscBarType}");
          dscData = cMem.dscBar?.dscBarCd2.substring(7, 12);
          cMem.dscBar?.dscBarData = int.parse(dscData!);
          return DlgConfirmMsgKind.MSG_NONE.dlgId;
        default:
          break;
      }
    }

    if (await RcItmChk.rcCheckGs1BarItem()) {
      cMem.dscBar?.dscBarType = cMem.dscBar!.dscBarCd2[6];
      dscDataOff = cMem.dscBar?.dscBarCd2.substring(6, 13);
      cMem.dscBar?.dscBarData = int.parse(dscDataOff!);
    } else if (await RcSysChk.rcChkZHQsystem()) {
      dscData = "";
      if (cMem.dscBar?.dscBarCd2[6] == "3") {
        //HeartOne側でズバリ売価の実績を処理できないので全日食仕様ではエラーとする
        cMem.dscBar?.dscBarType = "0";
        return DlgConfirmMsgKind.MSG_DSCBAR_FLG3_ERROR.dlgId;
      } else {
        cMem.dscBar?.dscBarType = cMem.dscBar!.dscBarCd2[6];
      }
      dscData = cMem.dscBar?.dscBarCd2.substring(7, 12);
      cMem.dscBar?.dscBarData = int.parse(dscData!);
    } else if (pCom.dbTrm.dscBarcodeAmt != 0) { /* 関西スーパー特注 */
      dscDataOff = "";
      cMem.dscBar?.dscBarType = "3";
      dscDataOff = cMem.dscBar?.dscBarCd2.substring(6, 12);
      cMem.dscBar?.dscBarData = int.parse(dscDataOff!);
    } else if (pCom.dbTrm.ralseDisc2barcode != 0) { /* ラルズ特注 */
      dscDataOff = "";
      if (cMem.dscBar?.dscBarCd2[5] == "0") {
        cMem.dscBar?.dscBarType = "3";
      } else if (cMem.dscBar?.dscBarCd2[5] == "1") {
        cMem.dscBar?.dscBarType = "2";
      } else {
        cMem.dscBar?.dscBarType = "0";
        return DlgConfirmMsgKind.MSG_PLUERROR.dlgId;
      }
      dscDataOff = cMem.dscBar?.dscBarCd2.substring(6, 12);
      cMem.dscBar?.dscBarData = int.parse(dscDataOff!);
    } else if (pCom.dbTrm.chgDiscBarcodeFlag != 0) { /* エコス特注 */
      dscData = "";
      if (cMem.dscBar?.dscBarCd2[6] == "1") {
        cMem.dscBar?.dscBarType = "2";
      } else if (cMem.dscBar?.dscBarCd2[6] == "2") {
        cMem.dscBar?.dscBarType = "1";
      } else {
        cMem.dscBar?.dscBarType = "0";
        dscData = cMem.dscBar?.dscBarCd2.substring(7, 12);
        cMem.dscBar?.dscBarData = int.parse(dscData!);
      }
    } else if (pCom.dbTrm.kasumiDiscBarcode != 0) { /* カスミ特注 */
      prcData = "";
      cMem.dscBar?.dscBarType = "3";
      prcData = cMem.dscBar?.dscBarCd2.substring(8, 12);
      cMem.dscBar?.dscBarData = int.parse(prcData!);
    } else if (pCom.dbTrm.chgDiscbacodeFlg == 1) {  /* */
      dscData = "";
      if (cMem.dscBar?.dscBarCd2[6] == "1") {
        cMem.dscBar?.dscBarType = "2";
      } else if (cMem.dscBar?.dscBarCd2[6] == "2") {
        cMem.dscBar?.dscBarType = "1";
      } else if (cMem.dscBar?.dscBarCd2[6] == "3") {
        cMem.dscBar?.dscBarType = "3";
      } else {
        cMem.dscBar?.dscBarType = "0";
      }
      dscData = cMem.dscBar?.dscBarCd2.substring(7, 12);
      cMem.dscBar?.dscBarData = int.parse(dscData!);
    } else if (pCom.dbTrm.tacFunc != 0) {
      // タック様仕様: 値引割引はしない
      dscData = "";
      cMem.dscBar?.dscBarType = "0";
      cMem.dscBar?.dscBarData = 0;
    } else if (((await CmCksys.cmSm66FrestaSystem() != 0)	|| (pCom.dbTrm.chgDiscbacodeFlg == 2)) &&
        (cMem.dscBar?.dscBarCd2[5] != "0")) {
      /* フレスタ様 22桁値引バーコード */
      dscDataOff = "";
      if (cMem.dscBar?.dscBarCd2[5] == "1") {
        cMem.dscBar?.dscBarType = "3";
      } else if (cMem.dscBar?.dscBarCd2[5] == "2") {
        cMem.dscBar?.dscBarType = "1";
      } else if (cMem.dscBar?.dscBarCd2[5] == "3") {
        cMem.dscBar?.dscBarType = "2";
      } else {
        cMem.dscBar?.dscBarType = "0";
        dscDataOff = cMem.dscBar?.dscBarCd2.substring(6, 12);
        cMem.dscBar?.dscBarData = int.parse(dscDataOff!);
      }
    } else {
      dscData = "";
      cMem.dscBar?.dscBarType = cMem.dscBar!.dscBarCd2[6];
      dscData = cMem.dscBar?.dscBarCd2.substring(7, 12);
      cMem.dscBar?.dscBarData = int.parse(dscData!);
    }

    switch (cMem.dscBar?.dscBarType) {
      case "1":
        if ((RcItmChk.rcCheckKyDscPm()) || (RcItmChk.rcCheckKyPrc())) {
          cMem.dscBar?.dscBarType = "0";
        } else {
          cMem.working.dataReg.kDsc0 = cMem.dscBar!.dscBarData;
        }
        break;
      case "2":
        if ((RcItmChk.rcCheckKyDscPm()) || (RcItmChk.rcCheckKyPrc())) {
          cMem.dscBar?.dscBarType = "0";
        } else {
          cMem.working.dataReg.kPm1_0 = cMem.dscBar!.dscBarData;
          cMem.working.dataReg.kPm1_0 *= 100;
        }
        break;
      case "3":
        if (RcItmChk.rcCheckKyPrc()) {
          cMem.dscBar?.dscBarType = "0";
        } else {
          cMem.working.dataReg.kPri0 = cMem.dscBar!.dscBarData;
        }
        break;
      default:
        break;
    }
    return DlgConfirmMsgKind.MSG_NONE.dlgId;
  }

  /// 端末カード読込画面に切り替えるかチェックする
  /// 戻り値: true=切り替えない  false=切り替える
  ///  関連tprxソース: rc_set.c - rcCat_CardRead_ScrMode
  static Future<bool> rcCatCardReadScrMode() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcSet.rcCatCardReadScrMode(): CAT Card Read ScrMode");
    await rcMovScrMode();

    AcMem cMem = SystemFunc.readAcMem();

    cMem.stat.scrType = RcRegs.LCD_104Inch;
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_ITM :
      case RcRegs.RG_BADD :
      case RcRegs.RG_RESERV_DSP :
      case RcRegs.RG_ESVOIDS :
      case RcRegs.RG_STL :
        cMem.stat.scrMode = RcRegs.RG_CAT_CARDREAD_DSP;
        return false;
      case RcRegs.VD_ITM :
      case RcRegs.VD_BADD :
      case RcRegs.VD_RESERV_DSP :
      case RcRegs.VD_ESVOIDS :
      case RcRegs.VD_STL :
        cMem.stat.scrMode = RcRegs.VD_CAT_CARDREAD_DSP;
        return false;
      case RcRegs.TR_ITM :
      case RcRegs.TR_BADD :
      case RcRegs.TR_RESERV_DSP :
      case RcRegs.TR_ESVOIDS :
      case RcRegs.TR_STL :
        cMem.stat.scrMode = RcRegs.TR_CAT_CARDREAD_DSP;
        return false;
      case RcRegs.SR_ITM :
      case RcRegs.SR_BADD :
      case RcRegs.SR_RESERV_DSP :
      case RcRegs.SR_ESVOIDS :
      case RcRegs.SR_STL :
        cMem.stat.scrMode = RcRegs.SR_CAT_CARDREAD_DSP;
        return false;
      default:
        break;
    }
    return true;
  }

  /// 端末カード読込画面に切り替えるかチェックする
  ///  関連tprxソース: rc_set.c - rcSet_ScnItmSel
  static void rcSetScnItmSel() {
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.scnchkSelflg = Typ.ON;
  }

  /// 画面を会員スキャンモードに設定する
  /// 戻り値: true=設定なし  false=設定
  ///  関連tprxソース: rc_set.c - rcScnMbrMode
  static bool rcScnMbrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_ITM:
      case RcRegs.RG_STL:
      case RcRegs.RG_SITM:
        cMem.stat.scrMode = RcRegs.RG_SCNMBR;
        return false;
      case RcRegs.VD_ITM:
      case RcRegs.VD_STL:
      case RcRegs.VD_SITM:
        cMem.stat.scrMode = RcRegs.VD_SCNMBR;
        return false;
      case RcRegs.TR_ITM:
      case RcRegs.TR_STL:
      case RcRegs.TR_SITM:
        cMem.stat.scrMode = RcRegs.TR_SCNMBR;
        return false;
      case RcRegs.SR_ITM:
      case RcRegs.SR_STL:
      case RcRegs.SR_SITM:
        cMem.stat.scrMode = RcRegs.SR_SCNMBR;
        return false;
      default:
        break;
    }
    return true;
  }

  /// 画面を会員スキャンモードに設定する（デュアルキャッシャー仕様）
  /// 戻り値: true=設定なし  false=設定
  ///  関連tprxソース: rc_set.c - rcScnMbrMode_DualCshr
  static Future<bool> rcScnMbrModeDualCshr() async {
    if (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) {
      return true;
    }

    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.scrMode) {
      case RcRegs.RG_STL:
        cMem.stat.scrMode = RcRegs.RG_DUALSCNMBR;
        return false;
      case RcRegs.VD_STL:
        cMem.stat.scrMode = RcRegs.VD_DUALSCNMBR;
        return false;
      case RcRegs.TR_STL:
        cMem.stat.scrMode = RcRegs.TR_DUALSCNMBR;
        return false;
      case RcRegs.SR_STL:
        cMem.stat.scrMode = RcRegs.SR_DUALSCNMBR;
        return false;
      default:
        break;
    }
    return true;
  }

  /// 乗算キー内容のクリア
  ///  関連tprxソース: rc_set.c - rcClear_Mul
  static Future<void> rcClearMul() async {
    if (CompileFlag.BDL_PER) {
      if ((await CmCksys.cmIchiyamaMartSystem() != 0)
          || (await RcSysChk.rcChkBdlMultiSelectSystem())) {
        /* mulkeyの値は次の商品を登録するまで残っているが */
        /* いちやまマート様乗算の場合は、残っていると乗算中扱いになる為 */
        /* ゼロクリアするようにした。他ユーザーはクリアしないままにしている */
        AcMem cMem = SystemFunc.readAcMem();
        cMem.scrData.mulkey = 0;
      }
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_FuncKeyBar
  static void rcClearFuncKeyBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.funcBar = FunctionBar();
    cMem.funcBar!.funcBarFlg = "";
    cMem.funcBar!.funcBarKycd = 0;
    cMem.funcBar!.funcBarFree = 0;
  }

  ///  関連tprxソース: rc_set.c - rcClear_FreshBar
  static void rcClearFreshBar() {
    if (CompileFlag.FRESH_BARCODE) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.freshBar = FreshBar();
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_DscBar
  static void rcClearDscBar() {
    if (CompileFlag.DISC_BARCODE) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.dscBar = DscBar();
      cMem.dscBar!.dscBarType = "";
      cMem.dscBar!.dscBarFlg = "";
      cMem.dscBar!.dscBar1Flg = "";
      cMem.dscBar!.dscBar2Flg = "";
    }
  }

  ///  関連tprxソース: rc_set.c - rcClearCode128_inf
  static void rcClearCode128Inf() {
    if (CompileFlag.DISC_BARCODE) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.working.code128Inf = Code128Inf();
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_BookBar
  static void rcClearBookBar() {
    if (CompileFlag.BOOK_BARCODE) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.bookBar = BookBar();
      cMem.bookBar!.bookBarFlg = "";
      cMem.bookBar!.bookBar1Flg = "";
      cMem.bookBar!.bookBar2Flg = "";
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_ClothesBar
  static void rcClearClothesBar() {
    if (CompileFlag.CLOTHES_BARCODE) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.clothesBar = ClothesBar();
      cMem.clothesBar!.clothesBarFlg = "";
      cMem.clothesBar!.clothesBar1Fno = 0;
      cMem.clothesBar!.clothesBar1Flg = "";
      cMem.clothesBar!.clothesBar2Flg = "";
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_MagazineBar
  static void rcClearMagazineBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.magazineBar = MagazineBar();
    cMem.magazineBar!.mgznBarFlg = "";
  }

  ///  関連tprxソース: rc_set.c - rcClear_ItfBar
  static void rcClearItfBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.itfBar = ItfBar();
    cMem.itfBar!.itfBarFlg = "";
    cMem.itfBar!.itfBarPrc = 0;
    cMem.itfBar!.itfBarAmt = 0;
  }

  ///  関連tprxソース: rc_set.c - rcClear_PriceTagBar
  static void rcClearPriceTagBar() {
    if (CompileFlag.DEPARTMENT_STORE) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.pricetagBar = PricetagBar();
      cMem.pricetagBar!.prctagBarFlg = "";
      cMem.pricetagBar!.prctagBar1Fno = 0;
      cMem.pricetagBar!.prctagBar1Flg = "";
      cMem.pricetagBar!.prctagBar2Flg = "";
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_GiftBar
  static void rcClearGiftBar() {
    if (CompileFlag.DEPARTMENT_STORE) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.giftBar = GiftBar();
      cMem.giftBar!.giftBarFlg = "";
      cMem.giftBar!.giftBar1Fno = 0;
      cMem.giftBar!.giftBar1Flg = "";
      cMem.giftBar!.giftBar2Flg = "";
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_DeptFreshBar
  static void rcClearDeptFreshBar() {
    if (CompileFlag.DEPARTMENT_STORE) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.deptfreshBar = DeptfreshBar();
      cMem.deptfreshBar!.deptfreshtBarFlg = "";
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_TicketBar
  static void rcClearTicketBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ticketBar.ticketBarCd = "";
    cMem.ticketBar.ticketBarFlg = 0;
    cMem.ticketBar.ticketBarStore = 0;
    cMem.ticketBar.ticketBarMacno = 0;
    cMem.ticketBar.ticketBarNum = 0;
    cMem.ticketBar.ticketBarPrc = "";
  }

  ///  関連tprxソース: rc_set.c - rcClear_TicketBarSprit
  static void rcClearTicketBarSprit() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ticketBar = PointtcktBar();
    cMem.ticketBar.ticketBarFlg = 0;
    cMem.ticketBar.ticketBarStore = 0;
    cMem.ticketBar.ticketBarMacno = 0;
    cMem.ticketBar.ticketBarNum = 0;
    cMem.ticketBar.ticketBarPrc = "";
    cMem.ticketBar.ticketBarCnt = 0;
  }

  ///  関連tprxソース: rc_set.c - rcClear_SalLmtBar
  static void rcClearSalLmtBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.sallmtBar = SallmtBar();
    if (CompileFlag.SALELMT_BAR) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.sallmtBar = SallmtBar();
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_Gs1Bar
  static void rcClearGs1Bar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.gs1Bar = Gs1Bar();
  }

  ///  関連tprxソース: rc_set.c - rcClear_Card_ForgetBar
  static Future<void> rcClearCardForgetBar() async {
    if ((await RcItmChk.rcCheckCardForgetBar1Flg())
        || (await RcItmChk.rcCheckCardForgetBar2Flg())) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.cardforgetBar = CardforgetBar();
      cMem.cardforgetBar!.forgetBarFlg = "";
      cMem.cardforgetBar!.forgetBar1Flg = "";
      cMem.cardforgetBar!.forgetBar2Flg = "";
      cMem.cardforgetBar!.forgetBarCompcd = 0;
      cMem.cardforgetBar!.forgetBarPoint = 0;
      cMem.cardforgetBar!.forgetMacNo = 0;
      cMem.cardforgetBar!.forgetReceiptNo = 0;
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_BenefitBar
  static Future<void> rcClearBenefitBar() async {
    if (await RcItmChk.rcCheckBenefitBarItem()) {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.benefitBar = BenefitBar();
      cMem.benefitBar!.couponBarFlg = "";
      cMem.benefitBar!.couponBarCompcd = 0;
      cMem.benefitBar!.couponBarBenefitcd = 0;
      cMem.benefitBar!.couponBarPlancd = 0;
      cMem.benefitBar!.couponBarValue = 0;
    }
  }

  ///  関連tprxソース: rc_set.c - rcClear_BenefitBar
  static void rcClearRedPriceTagBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.rptagBar = RptagBar();
    cMem.rptagBar!.rptagBarFlg = "";
    cMem.rptagBar!.rptagBar1Flg = "";
    cMem.rptagBar!.rptagBar2Flg = "";
    cMem.rptagBar!.rptagBar1Fno = 0;
    cMem.rptagBar!.rptagBar1Flg = "";
    cMem.rptagBar!.rptagBar2Fno = 0;
    cMem.rptagBar!.rptagBar2Flg = "";
    cMem.rptagBar!.rptagBarPrc = 0;
  }

  ///  関連tprxソース: rc_set.c - rcClear_BenefitBar
  static void rcClearGoodsNumBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.gnBar = GoodsnumBar();
    cMem.gnBar!.goodsnumBarFlg = "";
    cMem.gnBar!.goodsnumBarSml = 0;
    cMem.gnBar!.goodsnumBarClass = 0;
  }

  /// プレゼントポイントバーコードデータをクリアする
  ///  関連tprxソース: rc_set.c - rc_clear_ayaha_gift_point_clear
  static void rcClearAyahaGiftPointBar() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ayahaBar = AyahaGiftPointBar();
  }

  /// 中古品情報をクリアする
  ///  関連tprxソース: rc_set.c - rcClear_WsUsedItemInfo
  static void rcClearWsUsedItemInfo() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.wsUsedInfo = WsUsedInfo();
  }

  /// 生産者2段バーコードメモリクリア
  ///  関連tprxソース: rc_set.c - rcClear_ProdBar_2St
  static void rcClearProdBar2St() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.prodBar = ProducerBar();
  }

  ///  関連tprxソース: rc_set.c - rcClear_PublicBar3_Expdate
  static void rcClearPublicBar3Expdate() {
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.publicBarcodeExpdateName = "";
    atSing.publicBarcodeExpdateDate = "";
  }

  /// オオゼキ様　雑収入区分データをクリアする
  ///  関連tprxソース: rc_set.c - rc_set_divdata_clea
  static void rcClearDivdata() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.divData = DivData();
    cMem.divData?.divCd = 0;
    cMem.divData?.taxCd = 0;
  }

  /// 機能：プレゼントポイントバーコードデータをクリアする
  /// 関連tprxソース: rc_set.c - rc_set_ayaha_gift_point_clear
  static void rcSetAyahaGiftPointClear() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ayahaBar = AyahaGiftPointBar();
    cMem.ayahaBar!.giftPointBarFlg = "";
    cMem.ayahaBar!.giftPointBarSumcd = 0;
    cMem.ayahaBar!.giftPointBarPoint = 0;
  }

  /// 関連tprxソース: rc_set.c - rcUTcnct_Work_ScrMode
  static Future<bool> rcUTcnctWorkScrMode() async
  {
    await rcMovScrMode();
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.stat.scrMode) {
      case RcRegs.RG_ITM:
      case RcRegs.RG_STL:
        cMem.stat.scrMode = RcRegs.RG_UTCNCTWORK_DSP;
        return (false);
      case RcRegs.VD_ITM:
      case RcRegs.VD_STL:
        cMem.stat.scrMode = RcRegs.VD_UTCNCTWORK_DSP;
        return (false);
      case RcRegs.TR_ITM:
      case RcRegs.TR_STL:
        cMem.stat.scrMode = RcRegs.TR_UTCNCTWORK_DSP;
        return (false);
      case RcRegs.SR_ITM:
      case RcRegs.SR_STL:
        cMem.stat.scrMode = RcRegs.SR_UTCNCTWORK_DSP;
        return (false);
      default:
        break;
    }
    return (true);
  }

  ///  関連tprxソース: rc_set.c - rcQC_CrdtDsp_ScrMode
  static Future<bool> rcQCCrdtDspScrMode() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch(cMem.stat.scrMode) {
        case RcRegs.RG_QC_SLCT       : 
        case RcRegs.RG_QC_CALL       : 
        case RcRegs.RG_QC_CRDTUSE    : 
        case RcRegs.RG_QC_MENTE      :
            cMem.stat.scrMode = RcRegs.RG_QC_CRDT; return(false);

        case RcRegs.TR_QC_SLCT       : 
        case RcRegs.TR_QC_CALL       : 
        case RcRegs.TR_QC_CRDTUSE    : 
        case RcRegs.TR_QC_MENTE      :
            cMem.stat.scrMode = RcRegs.TR_QC_CRDT; return(false);

        default                      :
            if(!RcFncChk.rcQCCheckCrdtDspMode()) {
              TprLog().logAdd(
                  await RcSysChk.getTid()
                , LogLevelDefine.error
                , "rcQC_CrdtDsp_ScrMode Set fail ScrMode[${cMem.stat.scrMode}]"); 
            }
            break;
    }
    return true ;
  }

  ///  関連tprxソース: rc_set.c - rcCrdt_ScrMode
  static bool rcCrdtScrMode() {
    rcMovScrMode();

    AcMem cMem = SystemFunc.readAcMem();
    switch(cMem.stat.scrMode) {
        case RcRegs.RG_ITM:
        case RcRegs.RG_STL: cMem.stat.scrMode = RcRegs.RG_CRDT; return(false);
        case RcRegs.VD_ITM:
        case RcRegs.VD_STL: cMem.stat.scrMode = RcRegs.VD_CRDT; return(false);
        case RcRegs.TR_ITM:
        case RcRegs.TR_STL: cMem.stat.scrMode = RcRegs.TR_CRDT; return(false);
        case RcRegs.SR_ITM:
        case RcRegs.SR_STL: cMem.stat.scrMode = RcRegs.SR_CRDT; return(false);
        default:     break;
    }
    return(true);
  }

  ///  関連tprxソース: rc_set.c - rcCrdt_SubScrMode
  static bool rcCrdtSubScrMode() {
    rcMovScrMode();

    AcMem cMem = SystemFunc.readAcMem();
    switch(cMem.stat.scrMode) {
        case RcRegs.RG_ITM:
        case RcRegs.RG_STL:
        case RcRegs.RG_SITM: cMem.stat.scrMode = RcRegs.RG_CRDT; return(false);
        case RcRegs.VD_ITM:
        case RcRegs.VD_STL:
        case RcRegs.VD_SITM: cMem.stat.scrMode = RcRegs.VD_CRDT; return(false);
        case RcRegs.TR_ITM:
        case RcRegs.TR_STL:
        case RcRegs.TR_SITM: cMem.stat.scrMode = RcRegs.TR_CRDT; return(false);
        case RcRegs.SR_ITM:
        case RcRegs.SR_STL:
        case RcRegs.SR_SITM: cMem.stat.scrMode = RcRegs.SR_CRDT; return(false);
        default:     break;
    }
    return(true);
  }

  ///  関連tprxソース: rc_set.c - rcSet_CreditErr_Code
  static Future<void> rcSetCreditErrCode(String err_cd) async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.crdtErrCd = err_cd;
    if (await CmCksys.cmNttaspSystem() == 0) {
      cMem.working.crdtReg.cardcrewErr = err_cd;
    }
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:  rc_set.c -rc_set_qc_not_nimoca_confirm_scrmode
  static int rcSetQcNotNimocaConfirmScrmode(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:  rc_set.c -rc_set_qc_nimoca_yes_no_scrmode
  static int rcSetQcNimocaYesNoScrmode(){
    return 0;
  }
  
}