/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_elog.dart';
import 'rc_ext.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rc_voidupdate.dart';
import 'rcky_cashvoid.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

class RcKyesVoid {
  static EsVoid esVoid = EsVoid();

  // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  /// 関連tprxソース: rcky_esvoid.c - rcESVoid_VoidUpChk
  static int rcESVoidVoidUpChk() {
      return 0;
  }

  ///  Confirm Dialog
  /// 関連tprxソース: rcky_esvoid.c - ESVoid_PopUp
  // TODO:00004 小出 QUICKPAY実装のため、定義のみ追加
  static void eSVoidPopUp(int err_no) {
    //ESVoid_DialogErr(err_no, 1, NULL);
  }

  /// 関連tprxソース: rcky_esvoid.c - ESVoid_DialogErr
  static int esVoidDialogErr(int erCode, int userCode, String msg) {
    /// TODO:00014 日向 定義のみ先行追加
    return 0;
  }

  /// 関連tprxソース: rcky_esvoid.c - rckyesv_EndConfMsg
  static void rckyESVEndConfMsg() {
    /// TODO:00014 日向 定義のみ先行追加
    return;
  }

  // TODO:00005 中間 現計実装のため、定義のみ追加
  /// 関連tprxソース: rcky_esvoid.c - rckyesv_chkallcncl
  static int rckyESVCheckAllCancel() {
    return 0;
  }

  /// 関連tprxソース: rcky_esvoid.c - rckyesv_chkdrwamt
  static int rckyECVChkdrwamt() {
    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt > 0 ) {
      return (mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt);
    }
    return 0;
  }

  /// 関連tprxソース: rcky_esvoid.c - ESvoid_AllCncl
  static void esVoidAllCncl() {
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    int p = 0;
    /// TODO:00010 長田 定義のみ追加
    // if (RckyCashVoid.rcCheckCashVoidDsp()) {
    //   esVoid.allcnclflg = !esVoid.allcnclflg;
    //   RckyCashVoid.rcCashVoidAllCncl(esVoid.allcnclflg);
    //   return;
    // }
    // // cm_clr((char *)&CMEM->custdata, sizeof(CMEM->custdata));
    // CmAry.cmClr(cMem.custData, cMem.custData.length);
    // // memcpy(MEM, &ESVOID_MEM, sizeof(REGSMEM));
    // esVoid.allcnclflg = !esVoid.allcnclflg;
    //
    // for (p = mem.tTtllog.t100001Sts.itemlogCnt - 1; p >= 0; p--) {
    //   if (rcChk_ItmRBuf_Corr(p)) {
    //     p--;
    //     continue;
    //   }
    //   esVoid.cnclflg[p] = esVoid.allcnclflg;
    //   if (esVoid.allcnclflg!) {
    //     mem.tItemLog[p].t10002.scrvoidFlg = true;
    //     mem.tItemLog[p].t10002.scrvoidQty = abs(mem.tItemLog[p].t10000.itemTtlQty);
    //     mem.tItemLog[p].t10002.scrvoidAmt = labs(mem.tItemLog[p].t10003.uusePrc);
    //   }
    // }
    //
    // for (p = CashKind.ESV_CASH.cd; p < CashKind.ESV_CASHMAX.cd; p++) {
    //   if (esVoid.allcnclflg!) {
    //     esVoid.cash[RcElog.ESV_NEW][p] = 0;
    //   }
    //   else {
    //     esVoid.cash[RcElog.ESV_NEW][p] = esVoid.cash[RcElog.ESV_OLD][p];
    //   }
    // }
    //
    // if ((rcsyschk_NotePlu_Stl_ModeOnly() == 2) && (esVoid.allcnclflg!)) {
    //   for (p = CashKind.ESV_CASH.cd; p < CashKind.ESV_CASHMAX.cd; p++) {
    //     if (ESVoid_ChkNotePlu_Stl_ModeOnly(p) == 1) {
    //       /* 特定の締めキーの値はクリアしない */
    //       esVoid.cash[RcElog.ESV_NEW][p] = esVoid.cash[RcElog.ESV_OLD][p];
    //     }
    //   }
    //
    //   for (p = mem.tTtllog.t100001Sts.itemlogCnt - 1; p >= 0; p--) {
    //     if (rcChk_ItmRBuf_Corr(p)) {
    //       p--;
    //       continue;
    //     }
    //     /* 金種商品は、画面訂正扱いにはせず、元の実績の内容を戻す */
    //     if (RcStl.rcChkItmRBufNotePlu(p)) {
    //       mem.tItemLog[p].t10002.scrvoidFlg =
    //           ESVOID_MEM.tItemLog[p].t10002.scrvoid_flg;
    //       mem.tItemLog[p].t10002.scrvoidQty =
    //           ESVOID_MEM.tItemLog[p].t10002.scrvoid_qty;
    //       mem.tItemLog[p].t10002.scrvoidAmt =
    //           ESVOID_MEM.tItemLog[p].t10002.scrvoid_amt;
    //     }
    //   }
    // }
    //
    // RcStlCal.rcStlItemCalcMain(RcRegs.STLCALC_INC_MBRRBT);
    // esVoidRtnChgCal();
    // esVoidReDsp();
    return;
  }

  /// 関連tprxソース: rcky_esvoid.c - ESVoid_RtnChgCal
  static void esVoidRtnChgCal() {
    RegsMem mem = SystemFunc.readRegsMem();

    esVoid.chg = esVoid.ttl - RxLogCalc.rxCalcStlTaxInAmt(mem);
    mem.tTtllog.t100001Sts.lastChg = esVoid.chgamt;
    mem.tTtllog.t100001Sts.rtnChg = (esVoid.chg - esVoid.chgamt) * -1;
    esVoid.rtnChg = (esVoid.chg - esVoid.chgamt) * -1;
    return;
  }

  /// 関連tprxソース: rcky_esvoid.c - ESVoid_RtnChgCal
  /// TODO:00010 長田 定義のみ追加
  static void esVoidReDsp() {
    AcMem cMem = SystemFunc.readAcMem();
    // if (esVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
    //   if ((FbInit.subinitMainSingleSpecialChk() == true)
    //       && (cMem.stat.dualTSingle == 1)) {
    //     if (RckyCashVoid.rcCheckCashVoidDsp()) {
    //       return;
    //     }
    //     gtk_widget_destroy(Dual_Subttl.window);
    //     rcStlLcd(FSTLLCD_RESET_ITEMINDEX, &Dual_Subttl);
    //     rcStlLcd_MbrInfo(&Dual_Subttl);
    //     if (C_BUF->db_trm.rwt_prn_mbrfile != 0)
    //       rcStlLcd_Person(&Dual_Subttl);
    //   }
    //   else {
    //     rcStlLcd(FSTLLCD_NOT_LCDINIT, &Subttl); /* display Subtotal screen */
    //     rcStlLcd_Items(&Subttl);
    //     rcKyExtKey_ReDisp(EXTKEY_MAKE);
    //   }
    // }
    return;
  }

  /// 検索訂正画面を構成するパラメタの設定を行う
  /// 関連tprxソース: rcky_esvoid.c - ESVoid_MemberDsp
  static void esVoidMemberDsp() {
    if (esVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
      AcMem cMem = SystemFunc.readAcMem();
      if (FbInit.subinitMainSingleSpecialChk() && (cMem.stat.dualTSingle == 1)) {
        RcStlLcd.rcStlLcdTotalizers(RcStlLcd.FSTLLCD_NOT_LCDINIT, RegsDef.dualSubttl);
        RcStlLcd.rcStlLcdItems(RegsDef.dualSubttl);
        RcStlLcd.rcStlLcdMbrInfo(RegsDef.dualSubttl);
      }
      else {
        RcStlLcd.rcStlLcdTotalizers(RcStlLcd.FSTLLCD_NOT_LCDINIT, RegsDef.subttl);
        RcStlLcd.rcStlLcdItems(RegsDef.subttl);
        RcStlLcd.rcStlLcdMbrInfo(RegsDef.subttl);
      }
    }
  }

  /// 検索訂正画面の描画を行う
  /// 関連tprxソース: rcky_esvoid.c - ESVoid_MbrInputMbrDsp
  static void esVoidMbrInputMbrDsp() {
    rcESVoidTimerAdd(50, esVoidCardReadDsp);
  }

  /// 検索訂正画面の描画を行う（メイン処理）
  /// 関連tprxソース: rcky_esvoid.c - ESVoid_CardReadDsp
  static Future<void> esVoidCardReadDsp() async {
    String callFunc = "RcKyesVoid.esVoidCardReadDsp()";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemPtr() error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    rcESVoidTimerRemove();
    if (cBuf.dbTrm.scanPanelOpe != 0) {
      await RcExt.rxChkModeReset(callFunc);
    }
    RegsMem mem = SystemFunc.readRegsMem();
    for (int p = 0; p < mem.tTtllog.t100001Sts.itemlogCnt; p++) {
      mem.tItemLog[p].t11100.pluPointTtl = mem.tItemLog[p].t11100Sts.upluPoint * mem.tItemLog[p].t10000.itemTtlQty;
      mem.tItemLog[p].t11100Sts.mbrInput = mem.tTtllog.t100700.mbrInput;
    }
    StlItemCalcMain.rcStlItemCalcMain(StlCalc.incMbrRbt.index);
    esVoidRtnChgCal();
    esVoidMemberDsp();
  }

  /// タイマ処理
  /// 関連tprxソース: rcky_esvoid.c - rcESVoidTimerAdd
  static Future<void> rcESVoidTimerAdd(int timer, Function func) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcESVoid Timer Add [${RcVoidUpdate.rcVoidProcTimerChk()}]");

    if (RcVoidUpdate.rcVoidProcTimerChk()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "rcESVoid Timer Add [${RcVoidUpdate.rcVoidProcTimerChk()}] Err Timer Remove");
      await rcESVoidTimerRemove();
    }
    RcVoidUpdate.rcVoidProcTimerAdd(timer, func, 0);
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcESVoid Timer Add [${RcVoidUpdate.rcVoidProcTimerChk()}]");
  }

  /// タイマイベント削除
  /// 関連tprxソース: rcky_esvoid.c - rcESVoidTimerRemove
  static Future<void> rcESVoidTimerRemove() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcESVoid Timer Remove [${RcVoidUpdate.rcVoidProcTimerChk()}]");
    RcVoidUpdate.rcVoidProcTimerRemove();
  }
}
