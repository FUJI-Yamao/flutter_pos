/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_acbstopdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_assist_mnt.dart';
import 'package:flutter_pos/app/regs/checker/rc_auto.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../tprlib/TprLibDlg.dart';
import '../inc/L_rckyccin.dart';
import '../inc/rc_mem.dart';

/// 関連tprxソース: rc_cash_recycle.c - CashRecycle_ActStep
enum CashRecycleActStep {
  cashRecycleStepStart(0),
  cashRecycleStepCmdSend1(1),
  cashRecycleStepCmdSend2(2),
  cashRecycleStepOutDrw(3),
  cashRecycleStepInout1(4),
  cashRecycleStepInout2(5),
  cashRecycleStepEnd(6);

  final int id;
  const CashRecycleActStep(this.id);
}

/// 関連tprxソース: rc_cash_recycle.c - CashRecycle_DrwChg_BackUp
class CashRecycleDrwChgBackUp {
  String file = "";	//ファイル名
  String data = "";	//取得データ
  int	cpyStart = 0;	//開始位置
}

/// 関連tprxソース:rc_cash_recycle.c
class RcCashRecycle {
  static const int cBillAll = 10;	//10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1の10金種
  static int janType = 0;
  static int inOutType = 0;
  static int cashRecycleChgDrw = 0;
  static int cashRecycleChgDrwPrc = 0;
  static int cashRecycleActStep = 0;
  static int cashRecycleRoopStop = 0;
  static int cashRecycleOutErrClose = 0;
  static int cashRecycleAcxStopCnt = 0;
  static int cashRecycleOutErrCnt = 0;
  static CBillKind shtData = CBillKind();	//指示枚数（排出可能間異数への計算後）
  static CBillKind drwData = CBillKind();
  static CashRecycleInf cashRecycleInf = CashRecycleInf();
  static CashRecycleDrwChgBackUp chgOutBkInfo = CashRecycleDrwChgBackUp();
  static int chgInFlg = 0;
  static CoinData orgCoinData = CoinData();
  static CashRecycleData cashRecycleData = CashRecycleData();
  static int autoStrClsFlg = 0;	/* 1:自動精算 */

  /// 関連tprxソース:rc_cash_recycle.c - rc_CashRecycle_ChgOut_End
  static Future<void> rcCashRecycleChgOutEnd() async {
    IfWaitSave ifWaitSave = SystemFunc.readIfWaitSave();

    if (await RcFncChk.rcCheckCashRecycleMode() &&
        (autoStrClsFlg != 0)) {
      if (ifWaitSave.count != 0) {
        SystemFunc.ifSave = IfWaitSave();
      }
      if (!((RcFncChk.rcChkErr() != 0) ||
            (TprLibDlg.tprLibDlgCheck2(1) != 0))) {   /* ダイアログ表示中 */
        rcCashRecycleExecFuncMain(1);
      }
    }
  }

  /// 関連tprxソース:rc_cash_recycle.c - rc_CashRecycle_ExecFunc_Main
  static Future<void>	rcCashRecycleExecFuncMain(int data) async {
    String buf = "";
    int	errNo = rcCashRecycleDiffChk(null);

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcCashRecycleExecFuncMain: rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCashRecycleExecFuncMain Start");
    if ((inOutType == JANInfConsts.JANtypeCashRecycleOut.value) ||
        (chgInFlg != 0)) {
      RcAcracb.rcGtkTimerRemoveAcb();
      await RcSet.cashStatReset2("rcCashRecycleExecFuncMain");
      rcCashRecycleDispEnd();
      if ((chgInFlg != 0) &&
          (await RcFncChk.rcCheckAcbStopDspMode())) {
        await RcAcbStopdsp.rcacbStopdspTotalchk();
      }
      rcCashRecycleDataReset();
      cMem.acbData.keyChgcinFlg = "0";
      if (pCom.iniMacInfo.acx_flg.acr50_ssw14_7 == 1) {
        RcAcracb.rcAcbSsw14Set(0);
      }
      if (data == 0) {
        if (RcAcracb.rcChkChgStockState() != 0) {
          buf = "1,NG";
        } else {
          buf = "0,NG";
        }
        AplLibAuto.aplLibCmAutoMsgSend(await RcSysChk.getTid(), buf);
      } else {
        await RcAuto.rcAutoResultSend();
      }
      if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
        // TODO:10121 QUICPay、iD 202404実装対象外(一旦無視する)
        // if (IF_SAVE->count) {
        //  memset((char *)IF_SAVE, 0, sizeof(IF_SAVE));
        // }
        await RcAuto.rcAutoStrOpnClsNextJudg();
      }
    } else {
      if (AcbInfo.autoDecisionFlg == 1) {
        AcbInfo.autoDecisionFlg = 0;
      }
      cMem.ent.errNo = await RcAcracb.rcAcrAcbCinReadDtl();/* add 04.01.26 */
      RcKyccin.rcAcbPriceDataSet();
      if ((autoStrClsFlg == 0) &&
          (errNo != 0)) {
        await rcCashRecycleExecConf(errNo);
      } else if (cashRecycleData.total_price == 0) {
        await rcCashRecycleExecConf(DlgConfirmMsgKind.MSG_TRC_TTL_ZERO.dlgId);
      } else {
        rcCashRecycleExecYes();
      }
    }
  }

  /// 関連tprxソース:rc_cash_recycle.c - rc_CashRecycle_BeforeSht_Set
  static Future<void> rcCashRecycleBeforeShtSet() async {
    await RcAcracb.rcAcrAcbBeforeMemorySet(orgCoinData);
  }

  /// 関連tprxソース: rc_cash_recycle.c - rc_CashRecycle_ForceEnd_AplDlg
  static void rcCashRecycleForceEndAplDlg() {
    return;
  }

  /// 関連tprxソース: rc_cash_recycle.c - rc_CashRecycle_Disp_End
  static int rcCashRecycleDispEnd() {
    return rcCashRecycleDispEnd2(0);
  }

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース: rc_cash_recycle.c - rc_CashRecycle_Disp_End2
  static int rcCashRecycleDispEnd2(int flg) {
    return 0;
  }

  /// 関連tprxソース: rc_cash_recycle.c - rc_CashRecycle_DataReset
  static Future<void> rcCashRecycleDataReset() async {
    RegsMem mem = SystemFunc.readRegsMem();
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCashRecycleDataReset");
    janType = 0;
    inOutType = 0;
    cashRecycleChgDrw = 0;
    cashRecycleChgDrwPrc = 0;
    cashRecycleActStep = CashRecycleActStep.cashRecycleStepStart.id;
    cashRecycleRoopStop = 0;
    cashRecycleOutErrClose = 0;
    cashRecycleAcxStopCnt = 0;
    cashRecycleOutErrCnt = 0;
    AcbInfo.drwdataSav = 0;
    shtData = CBillKind();
    drwData = CBillKind();
    cashRecycleInf = CashRecycleInf();
    cashRecycleData = CashRecycleData();
    chgOutBkInfo = CashRecycleDrwChgBackUp();
    mem.prnrBuf.crinfo = CashRecycle();
    mem.prnrBuf.opeStaffName = "";
  }

  /// 関連tprxソース: rc_cash_recycle.c - rc_CashRecycle_Diff_Chk
  static int rcCashRecycleDiffChk(CBillKind? shtData) {
    CBillKind cCinSht = CBillKind();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    if ((inOutType == JANInfConsts.JANtypeCashRecycleIn.value) &&
        (cashRecycleData.chgout_amt != 0)) {	//両替入金
      if (cashRecycleData.chgout_amt != cMem.acbData.totalPrice) {
        return DlgConfirmMsgKind.MSG_DIFF_IN.dlgId;
      }
      return 0;
    }
    if (shtData != null) {
      cCinSht = shtData;
    } else {
      cCinSht = cashRecycleData.cin_data;
    }
    mem.prnrBuf.crinfo.in_diff[0] = cCinSht.bill10000 - cashRecycleInf.acx10000Sht;
    mem.prnrBuf.crinfo.in_diff[1] = cCinSht.bill5000 - cashRecycleInf.acx5000Sht;
    mem.prnrBuf.crinfo.in_diff[2] = cCinSht.bill2000 - cashRecycleInf.acx2000Sht;
    mem.prnrBuf.crinfo.in_diff[3] = cCinSht.bill1000 - cashRecycleInf.acx1000Sht;
    mem.prnrBuf.crinfo.in_diff[4] = cCinSht.coin500 - cashRecycleInf.acx500Sht;
    mem.prnrBuf.crinfo.in_diff[5] = cCinSht.coin100 - cashRecycleInf.acx100Sht;
    mem.prnrBuf.crinfo.in_diff[6] = cCinSht.coin50 - cashRecycleInf.acx50Sht;
    mem.prnrBuf.crinfo.in_diff[7] = cCinSht.coin10 - cashRecycleInf.acx10Sht;
    mem.prnrBuf.crinfo.in_diff[8] = cCinSht.coin5 - cashRecycleInf.acx5Sht;
    mem.prnrBuf.crinfo.in_diff[9] = cCinSht.coin1 - cashRecycleInf.acx1Sht;

    for (int i = 0; i < cBillAll; i++) {
      if (mem.prnrBuf.crinfo.in_diff[i] != 0) {
        return DlgConfirmMsgKind.MSG_CASHRECYCLE_DIFF.dlgId;
      }
    }
    return 0;
  }

  /// 関連tprxソース: rc_cash_recycle.c - rc_CashRecycle_ExecConf
  static Future<void>	rcCashRecycleExecConf(int errNo) async {
    tprDlgParam_t param = tprDlgParam_t();
    param.erCode = errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (errNo == DlgConfirmMsgKind.MSG_TRC_TTL_ZERO.dlgId) {
      param.user_code_4 = LRckyCcin.CCIN_IN_END;
    } else {
      param.title = LTprDlg.BTN_CONF;
    }
    param.dialogPtn = DlgPattern.TPRDLG_PT1.dlgPtnId;
    param.msg1 = LTprDlg.BTN_YES;
    param.msg2 = LTprDlg.BTN_NO;
    param.func1 = rcCashRecycleExecYes;
    param.func2 = rcCashRecycleExecNo;

    if (!CompileFlag.SELF_GATE ||
        (CompileFlag.SELF_GATE && await RcSysChk.rcSGChkSelfGateSystem()) ||
        (CompileFlag.SELF_GATE && !await RcSysChk.rcSGChkSelfGateSystem())) {
      TprLibDlg.tprLibDlg2("rcCashRecycleExecConf", param);
      if (FbInit.subinitMainSingleSpecialChk()) {
        param.dual_dsp = 3;
        TprLibDlg.tprLibDlg2("rcCashRecycleExecConf", param);
      }
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem() ||
          await RcSysChk.rcQCChkQcashierSystem()) {
        RcAssistMnt.asstPcLog += tsBuf.managePc.msgLogBuf;
        RcAssistMnt.rcAssistSend(errNo);
      }
    }
  }

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース: rc_cash_recycle.c - rc_CashRecycle_ExecYes
  static void	rcCashRecycleExecYes() {
  }

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース: rc_cash_recycle.c - rc_CashRecycle_ExecNo
  static void	rcCashRecycleExecNo() {
  }
}
