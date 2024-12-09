/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/lib/apllib/qr2txt.dart';
import 'package:flutter_pos/app/regs/checker/rc_assist_mnt.dart';
import 'package:flutter_pos/app/regs/checker/rc_elog.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_reserv.dart';
import 'package:flutter_pos/app/regs/checker/rc_sgdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_timer.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_acx_overflow_move.dart';
import 'package:flutter_pos/app/regs/checker/rcky_drawchk.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin_acb.dart';
import 'package:flutter_pos/app/regs/checker/rcsg_com.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../fb/fb_lib.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_acx/acx_answ.dart';
import '../../lib/if_acx/acx_coin.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../lib/if_acx/acx_csta.dart';
import '../../lib/if_acx/acx_cstp.dart';
import '../../lib/if_acx/acx_mente_in.dart';
import '../../lib/if_acx/acx_mente_spco.dart';
import '../../lib/if_acx/acx_outerr_in.dart';
import '../../lib/if_acx/acx_pick.dart';
import '../../lib/if_acx/acx_resu.dart';
import '../../lib/if_acx/acx_spco.dart';
import '../../lib/if_acx/acx_ssw.dart';
import '../../lib/if_acx/acx_stcg.dart';
import '../../lib/if_acx/acx_stcr.dart';
import '../../lib/if_acx/ecs_cend.dart';
import '../../lib/if_acx/ecs_csta.dart';
import '../../lib/if_acx/ecs_opes.dart';
import '../../lib/if_acx/ecs_verr.dart';
import '../../lib/if_acx/sst1_fclr.dart';
import '../../tprlib/TprLibDlg.dart';
import '../acx/rc_acx.dart';
import '../common/rx_log_calc.dart';
import '../inc/L_rc_sgdsp.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_atct.dart';
import 'rc_fself.dart';
import 'rc_ifevent.dart';
import 'rc_qc_dsp.dart';
import 'rccatalina.dart';
import 'rcky_chgstatus.dart';
import 'rcky_clr.dart';
import 'rcky_plu.dart';
import 'rckyccin.dart';
import 'rcqc_com.dart';
import 'rcqr_com.dart';
import 'rcsyschk.dart';

class ChgStatDisp {
  String err_disp_name = "";
  String err_text_name = "";
  String err_text = "";
}

///  関連tprxソース: rc_acracb.c
class AcbInfo {
  static int totalPrice = 0;
  static int reStartCnt = 0;
  static int autoChkCnt = 0;
  static int autoDecErrcnt = 0;
  static int autoDecClrcnt = 0;
  static int manuDecWaitCnt = 0; //入金確定開始から入金受付終了までの待機
  static int ccinDialog = 0;

  // long  AcbDisp_Prc;
  static int autoDecisionFlg = 0;
  static int stepCnt = 0;
  static int othConnectAcbStopFlg = 0;

  // short CoinBillOut_Err;
  static CinData cindata = CinData(); //入金枚数（開始から終了まで）
  static CinData reindata = CinData(); //入金累計枚数（一取引内の累計：開始から終了の度に加算）
  CBillKind outdata = CBillKind(); //出金枚数（入金超過分の返金枚数）
  // short input_flg;	/* 入力部押下 */
  static int inpFirstFlg = 0;

  /* 入力中フラグ 1:個別釣銭 2:手入力入金額 */
  // short input_cnt;	/* 入力桁数 */
  // long  oldinp_prc;
  static int recalcPrc = 0;

  // char  move_flg;
  // long  oldccin_add_prc;
  // int   ChgOutWarn_cnt;
  static int errRestartFlg = 0;
  static int fnalRestartFlg = 0; //締め処理での入金確定終了後、締め不可の場合に入金監視に戻す
  // ChgStatDisp Disp[ChgStat_page_MAX];
  // short now_page;
  // short total_page;
  static int cPickRsltCnt = 0;
  static int acxErrCode = 0; //アシストモニタログへ送信するエラーコードとして保存
  // short restore_flg;
  static int stopwaitActFlg = 0;

  // short cpick_kind;
  static int acbStopdspFlg = 0;
  static int drwdataSav = 0;
  static Function? forceEndAft; //強制終了後の後処理にコールする関数
  static int autoDecisionFnal = 0; //ClsCom_Acx_AutoDecision_Fnal()にて終了処理完了状態
  static int forceEndFlg = 0; //強制終了処理
  static int tempErrNo =
      0; //cMem.ent.err_noがタイマー処理を挟んでいる時にクリアキー等でクリアされてしまうことがあるので退避
  static int oldCcinPrice = 0;
}

/// オーバーフロー庫移動情報(acx_overflow_mov.txtのデータ)
///  関連tprxソース: rc_acracb.h OverFlow_Data
class OverFlowData {
  int type = 0;
  int stock_price = 0; //オーバーフロー庫内金額合計
  //オーバーフロー庫内金種毎枚数
  List<int> stock_count = List.filled(CoinBillKindList.CB_KIND_MAX.id, 0);
}

/// 上記Acb_InfoのようにResetタイミングが固定でないもの
///  関連tprxソース: rc_acracb.h Acb_Mem
class AcbMem {
  int ccin_stop_flg = 0;
  int FncCode = 0;
  int acx_error_num = 0; //エラー復旧ガイダンス表示条件にて釣銭機処理でのエラーか判断するために保存
  late Function? acx_err_gui_end_func; //エラー復旧ガイダンス終了時コール関数
  int overflow_move_actflg =
      0; //オーバーフロー移動実行判定 ニアフル休止画面表示で実行されるが、セルフレジ等２回休止画面表示が行われていたため、このフラグで制御
  OverFlowData overflow_data = OverFlowData(); //オーバーフロー移動履歴
  int overflow_data_no = 0; //オーバーフロー移動履歴取得判定(現在print_noで判定する)
}

///  関連tprxソース: rc_acracb.h CashRecycle_Data
class CashRecycleData {
  int office_prc = 0;
  int office_sht10000 = 0; //事務所一括枚数
  int office_sht5000 = 0; //事務所一括枚数
  int office_sht2000 = 0; //事務所一括枚数
  int office_sht1000 = 0; //事務所一括枚数
  int office_sht500 = 0; //事務所一括枚数
  int office_sht100 = 0; //事務所一括枚数
  int office_sht50 = 0; //事務所一括枚数
  int office_sht10 = 0; //事務所一括枚数
  int office_sht5 = 0; //事務所一括枚数
  int office_sht1 = 0; //事務所一括枚数
  int staff_no = 0;
  String staff_name = ""; // [sizeof(((c_staff_mst *)NULL)->name)];
  int seq_no = 0;
  CBillKind cin_data =
      CBillKind(); //キャッシュリサイクル入金枚数（戻し入れ入金で入金データが上書きされるため、専用メモリを用意）
  int total_price = 0; //キャッシュリサイクル入金額（戻し入れ入金で入金データが上書きされるため、専用メモリを用意）
  List<int> inout_no = List<int>.filled(21, 0); //   [21];		//発行番号
  CBillKind keep_num = CBillKind(); //各金種最低保有枚数
  int chgout = 0; //両替出金
  int chgout_amt = 0; //両替出金金額(入金時のみセット)
  int Dual_Dsp = 0;
  CBillKind chgout_data = CBillKind(); //両替入金枚数(入金時のみセット)
  CBillKind chgdrw_data = CBillKind(); //棒金指示枚数
}

/// Define定義
///  関連tprxソース: rc_acracb.h - #define
class RcAcrAcbDef {
  /*----------------------------------------------------------------------*
  * Constamt values
  *----------------------------------------------------------------------*/
  /*----------------------------------------------------------------------*
  * Changer Maximum
  *----------------------------------------------------------------------*/
  static const COIN_EMPTY = 0;
  static const BILL10000_MAX = 100;
  static const BILL5000_MAX = 100;
  static const BILL2000_MAX = 100;
  static const BILL1000_MAX = 300;
  static const COIN500_MAX = 60;
  static const COIN100_MAX = 100;
  static const COIN050_MAX = 100;
  static const COIN010_MAX = 100;
  static const COIN005_MAX = 100;
  static const COIN001_MAX = 100;

  //OSのwrite遅延問題への安全策として最小でもタイムアウト値は6秒以上にすること
  static const ACX_STATE_CNT = 70;
  static const ACX_STATE_WAIT = 100000;
  static const ACX_STOCK_RETRY = 15;
  static const ECS_STOCK_RETRY = 20;
  static const ACX_STOCK_CNT = 70;
  static const ACX_STOCK_WAIT = 100000;
  static const ACX_RESULT_CNT = 600;
  static const ACX_RESULT_WAIT = 100000;
  static const ACX_ANSWER_CNT = 200;
  static const ACX_ANSWER_WAIT = 35000;
  static const ACB_DTSET_CNT = 70;
  static const ACB_DTSET_WAIT = 100000;
  static const ACX_ENUM_CNT = 300;
  static const ACX_ENUM_WAIT = 100000;
  static const ACX_PICKUP_CNT = 700;
  static const ACX_PICKUP_WAIT = 3000000;
  static const ECS_END_CNT = 4500;
  static const ECS_END_WAIT = 100000;
  static const SST_CANCEL_CNT = 3300;
  static const SST_CANCEL_WAIT = 100000;
  static const ACX_CREADGET_CNT = 150;
  static const ACX_CREADGET_WAIT = 50000;
  static const ACX_CREADGET_EVENT = (ACX_CREADGET_WAIT / 1000);
  static const ECS_OPESET_CNT = 110; //動作条件設定コマンド 11sec
  static const ECS_OPESET_WAIT = 100000;
  static const ACX_OVERFLOW_CNT = 600;
  static const ACX_OVERFLOW_WAIT = 1000000;

  static const FORCE_ERRCHKCNT = 30000; //カウントメモリがshortのため
  static const FORCE_CLRCNT = 3; //３回消去を繰り返すと強制終了選択
  static const FORCE_ERRCNT = 5;
  static const FORCE_ERRCNT_SST = 4;
  static const FORCE_ERRCNT_ECS = 10;
  static const FORCE_ERRCNT_DISPEND = 2;
  static const ECS_MANUAL_SUSPEND = 1; //0:現物返却ができない

  static const ACB_DEBUG = 0;
}

///  関連tprxソース: rc_acracb.h - AcbAct_Final_Flg
enum AcbActFinalFlg {
  Cncl_Flg(1),
  End_Flg(2),
  Cash_Flg(3),
  KyCash_Flg(4),
  KyCheck_Flg(5),
  KyCharge_Flg(6),
  KyCncl_Flg(7),
  KySus_Flg(8),
  ReStart_Flg(9),
  Exec_Flg(10);

  final int flgId;

  const AcbActFinalFlg(this.flgId);
}

class RcAcracb {
  static const int FALSE = 0;
  static const int TRUE = 1;

  static EcsPayout ecsPayoutData = EcsPayout();

  static EsVoid esVoid = EsVoid();
  static const bool DEPARTMENT_STORE = false;
  static const bool CATALINA_SYSTEM = true;
  static const bool RESERV_SYSTEM = true;
  static const bool SS_CR2 = false;

  static const int SPTEND_MAX = 36; // スプリット段数の最大
  static int happySmileCinReset = 0;
  static int inAmoutSetFlg = 0;
  static int sqrcTakeMoneyFlg = 0;

  static const OVERFLOW_STOCK_MAX =	1000;	//110+170+160+170+160+170=940 (500～1円の収納枚数合算分は入る収納BOX)
  static const COIN_PICKALL =	100;
  static const OVERSHT_PICK =	200;

  static const List<int> unit = [10000,5000,2000,1000,500,100,50,10,5,1];
  static const SEP_STR = "\r\n\t";

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_PopTimer_Calc
  static Future<int> rcAcrAcbPopTimerCalc(int result) async {
    //釣銭取り忘れ警告のタイマー計算処理
    int popTimer = 0;
    QCashierIni? qCashierIni;

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      // QCの場合、音声を鳴らすのでタイマーを少し遅くする
      popTimer =
          qCashierIni!.data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3;
      if (popTimer == 0) {
        popTimer = 2;
      } else if (popTimer > 10) {
        popTimer = 10;
      }
      popTimer = popTimer * 200;
    } else if (result == 2) {
      popTimer = 50;
    } else {
      popTimer = 2700;
    }
    return popTimer;
  }

  ///  関連tprxソース: rc_acracb.c - rcGtkTimerRemoveAcb
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static int rcGtkTimerRemoveAcb() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcGtkTimerAddAcb(int timer, int (*func)())
  static int rcGtkTimerAddAcb(int timer, void func) {
    if (RcTimer.rcTimerListRun(RC_TIMER_LISTS.RC_GTK_ACB_TIMER)) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "rcGtkTimerAddAcb : SYSTEM ERROR !!!\n");
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }

    RcTimer.rcTimerListAdd(RC_TIMER_LISTS.RC_GTK_ACB_TIMER, timer, func, 0);
    return OK;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_ChangeOut
  static Future<int> rcAcrAcbChangeOut(int price) async {
    // before call rcAcrAcb_AnswerRead() & rcAcrAcb_ResultGet()
    // return after call rcPrg_AcrAcb_ResultGet()
    int errNo = 0;
    int type = await rcCheckAcrAcbON(1);
    String log = "";
    // TODO:10141 cmEditUnitPriceUtf関数の第二引数の型が既存と合わないためList<int>型の変数追加
    List<int> logTmp = [1, 2, 3];
    CmEditCtrl fCtrl = CmEditCtrl();
    int bytes = 0;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "$rcAcrAcbChangeOut($price)");

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      if (DualDsp.cncl_fnc_flg == 1) {
        log = LRcScdsp.SG_CASHOUT;
      } else {
        AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_CHANGE);
      }
      RcSgCom.mngPcLog += log;
      // TODO:10142 例外発生するため一旦保留
      //CmNedit().cmEditUnitPriceUtf(fCtrl, logTmp, logTmp.length, 11, price, bytes);
      log = String.fromCharCodes(logTmp);
      RcSgCom.mngPcLog += log;
      RcSgCom.rcSGManageLogSend(SgDsp.REG_LOG);

      if (DualDsp.cncl_fnc_flg == 1) {
        RcAssistMnt.rcAssistSend(23116);
      } else {
        RcAssistMnt.rcAssistSend(23100);
      }
    }

    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.acrMode &= ~RcRegs.GET_MODE; // Reset Answer Get Mode
    if (type != 0) {
      rcAcrAcbChgOutDataSet(AcxProcNo.ACX_CHANGE_OUT.no, price, null, null);
      RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();
      tsBuf.acx.order = AcxProcNo.ACX_CHANGE_OUT.no;
      errNo = await AcxCoin.ifAcxChangeOut(Tpraid.TPRAID_ACX, type, price);
      if (errNo == OK) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
      if (await RcSysChk.rcChkAcrAcbCinLcd()) {
        await rcAcrAcbCinLcdCtrl(0, price);
      }
    } else {
      errNo = OK;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != OK) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcAcrAcbChangeOut(): err_no[$errNo]");
    }
    return errNo; // OK or MSG_ACRLINEOFF or MSG_ACRERROR
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_VoidChgOut
  static Future<int> rcAcrAcbVoidChgOut(int price) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return 0;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "$rcAcrAcbVoidChgOut($price)");

    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */

    int errNo = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    int type = await rcCheckAcrAcbON(0);
    if (type != 0) {
      rcAcrAcbChgOutDataSet(AcxProcNo.ACX_CHANGE_OUT.no, price, null, null);
      tsBuf.acx.order = AcxProcNo.ACX_CHANGE_OUT.no;
      errNo = await AcxCoin.ifAcxChangeOut(Tpraid.TPRAID_ACX, type, price);
      if (errNo == OK) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
      if (await RcSysChk.rcChkAcrAcbCinLcd()) {
        await RcAcracb.rcAcrAcbCinLcdCtrl(0, price);
      }
    } else {
      errNo = OK;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != OK) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcAcrAcbVoidChgOut(): err_no[$errNo]");
    }
    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_ShtSpecifyOut
  static Future<int> rcAcrAcbShtSpecifyOut(
      CBillKind ccinSht, int shtchgFlg, int menteFlg) async {
    // 枚数指定出金
    // shtchg_flg 0:代替計算行わない 0以外:代替計算行う
    // 使い方の目安:入金貨幣に応じた出金は代替必要。入金貨幣に制限なくとも出金不可貨幣が存在するため。
    //             収納庫枚数に応じた出金は代替必要無し。出金不可貨幣は収納庫に入らないため。
    //             画面に出金する貨幣を表示している場合にここで代替を行うと画面と異なる出金になるので注意。
    int errNo = 0;
    int type = 0;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    log = "rcAcrAcbShtSpecifyOut shtchg_flg($shtchgFlg) mente_flg($menteFlg)";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */
    if ((type = await rcCheckAcrAcbON(1)) != 0) {
      if (shtchgFlg != 0) {
        rcAcrAcbBillShtChange(
            ccinSht); //釣機両替での代替計算は両替機能内で行う(ここでの処理はuser_cd17&16の現物返却のため)
      }
      rcAcrAcbChgOutDataSet(AcxProcNo.ACX_SPECIFY_OUT.no, 0, ccinSht, null);
      tsBuf.acx.order = AcxProcNo.ACX_SPECIFY_OUT.no;
      if ((menteFlg == 1) &&
          (AcxCom.ifAcbSelect() != 0 & CoinChanger.RT_300_X)) {
        errNo = await AcxMenteSpco.ifAcxMenteShtSpecifyOut(
            Tpraid.TPRAID_ACX, type, ccinSht);
      } else {
        errNo =
            await AcxSpco.ifAcxShtSpecifyOut(Tpraid.TPRAID_ACX, type, ccinSht);
      }
      if (errNo == 0) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
      if ((await RcSysChk.rcChkAcrAcbCinLcd()) ||
          (await RcSysChk.rcQCChkQcashierSystem())) {
        await rcAcrAcbCinLcdCtrl(0, 1); /* 金額が分からないので、１固定 */
      }
    } else {
      errNo = 0;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != 0) {
      log = "rcAcrAcbShtSpecifyOut: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_BillShtChange
  static Future<void> rcAcrAcbBillShtChange(CBillKind ccinSht) async {
    int lackSht = 0;
    String log = '';
    int acbSelect = 0;
    RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();

    //万券出金ができない機種は代替処理
    acbSelect = AcxCom.ifAcbSelect();
    if ((acbSelect == CoinChanger.ACB_20) || (acbSelect == CoinChanger.SST1)) {
      if (ccinSht.bill10000 != 0) {
        ccinSht.bill5000 += ccinSht.bill10000 * 2;
        log =
            "rcAcrAcbBillShtChange 10000[${ccinSht.bill10000}] -> 5000[${ccinSht.bill5000}]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        ccinSht.bill10000 = 0;
        if (ccinSht.bill5000 > tsBuf.acx.coinStock.holder!.bill5000) {
          lackSht = ccinSht.bill5000 -
              tsBuf.acx.coinStock.holder!.bill5000; /* 5000不足枚数 */
          ccinSht.bill5000 = tsBuf.acx.coinStock.holder!.bill5000;
          ccinSht.bill1000 += lackSht * 5; /* 5000不足枚数を1000に代替 */
          log =
              "rcAcrAcbBillShtChange 5000[$lackSht] -> 1000[${ccinSht.bill1000}]\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        }
      }
    }
    if (ccinSht.bill2000 != 0) {
      ccinSht.bill1000 += ccinSht.bill2000 * 2;
      log =
          "rcAcrAcbBillShtChange 2000[${ccinSht.bill2000}] -> 1000[${ccinSht.bill1000}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      ccinSht.bill2000 = 0;
    }
  }

  /// 再出金処理のための情報セーブ
  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_ChgOut_DataSet
  static void rcAcrAcbChgOutDataSet(
      int type, int price, CBillKind? ccinSht, PickData? pickData) {
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.chgOutData.type = type;
    atSing.chgOutData.price = price;
    if (type == AcxProcNo.ACX_SPECIFY_OUT.no) {
      if (ccinSht != null) {
        atSing.chgOutData.data.cBillKind = ccinSht;
      }
    } else if (type == AcxProcNo.ACX_PICKUP.no) {
      if (pickData != null) {
        atSing.chgOutData.data = pickData;
      }
    }
  }

  /// acxタスクが釣銭釣札機からのレスポンスを受け取った後、メッセージコードとして返す関数
  /// (訂正モード等でもチェック可能)
  ///  関連tprxソース: rc_acracb.c - rcPrg_AcrAcb_ModeOffResultGet
  static Future<int> rcPrgAcrAcbModeOffResultGet() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return 0;
    }

    int errNo = OK;
    int waitCnt = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if ((cMem.stat.acrMode & RcRegs.GET_MODE) != 0) {
      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) &&
          ((tsBuf.acx.order == AcxProcNo.ACX_CHANGE_OUT.no) ||
              (tsBuf.acx.order == AcxProcNo.ACX_SPECIFY_OUT.no))) {
        waitCnt = RcAcrAcbDef.ACX_RESULT_CNT * 3;
      } else {
        waitCnt = RcAcrAcbDef.ACX_RESULT_CNT;
      }
      for (int i = 0; i < waitCnt; i++) {
        await RcAcx.rcAcxMain();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if ((tsBuf.acx.order == AcxProcNo.ACX_RESULT_GET.no) ||
            (tsBuf.acx.order == AcxProcNo.ACX_CHANGE_OUT_GET.no) ||
            (tsBuf.acx.order == AcxProcNo.ACX_PICKUP_GET.no)) {
          errNo = await rcAcrAcbModeOffResultGet(tsBuf.acx.devAck);
          if ((errNo == OK) &&
              (AcxCom.ifAcbSelect() & CoinChanger.ECS_777 != 0)) {
            await rcEcsPayOutReadAfterOut(tsBuf.acx.order);
          }
          rcResetAcrOdr();
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk("rcPrgAcrAcbModeOffResultGet()");
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        sleep(const Duration(
            microseconds: RcAcrAcbDef.ACX_RESULT_WAIT)); /* Soft Wait 100ms */
      }
    }
    if (errNo != OK) {
      rcResetAcrOdr();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcPrgAcrAcbModeOffResultGet(): err_no[$errNo]");
    }

    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_LINEOFF_Chk
  static Future<int> rcAcrAcbLineoffChk(int errNo, int orderFlg) async {
    int chkErrNo = errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    switch (errNo) {
      case IfAcxDef.MSG_ACRSENDERR: //errNo : -1
      case IfAcxDef.MSG_ACRFLGERR: //errNo : 2
      case IfAcxDef.MSG_ACRLINEOFF:
      case 3035: //DlgConfirmMsgKind.MSG_OFFLINE
      case IfAcxDef.MSG_INPUTERR:
        errNo = IfAcxDef.MSG_ACRLINEOFF;
        if (orderFlg != 0) {
          rcResetAcrOdr();
        }
        break;
      case IfAcxDef.MSG_ACRCMDERR: //errNo : -2
        if (tsBuf.acx.order == AcxProcNo.ACX_START_GET.no) {
          errNo = DlgConfirmMsgKind.MSG_ACB_START_ERR.dlgId;
        } else {
          errNo = IfAcxDef.MSG_ACRERROR;
        }
        if (orderFlg != 0) {
          rcResetAcrOdr();
        }
        break;
    }
    if ((errNo != 0) &&
        (errNo != chkErrNo) &&
        (TprLibDlg.tprLibDlgCheck2(1) == 0)) {
      //errNoの変更があった場合ログ記載
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcAcrAcbLineoffChk(): err_no[$chkErrNo] -> [$errNo]");
    }

    // 釣機のエラー状態を格納 (他レジに伝えるため用. 現在未使用)
    tsBuf.acx.errMsg = 0;
    //釣銭機のエラーを保存(エラー復旧GUIとリンクさせるため)
    RcKyccin.acbMem.acx_error_num = errNo;

    return errNo;
  }

  /// 釣銭釣札機からのレスポンスをメッセージコードに変換する関数 (訂正モード等でもチェック可能)
  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_ModeOffResultGet
  static Future<int> rcAcrAcbModeOffResultGet(TprMsgDevAck2_t rcvBuf) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return 0;
    }

    int errNo = 0;
    int clrFlg = 0; // 再出金用メモリクリアフラグ  0:何もしない  1:クリア
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((tsBuf.acx.order == AcxProcNo.ACX_CHANGE_OUT_GET.no) ||
        (tsBuf.acx.order == AcxProcNo.ACX_PICKUP_GET.no)) {
      clrFlg = 1;
    }
    if (await rcCheckAcrAcbON(0) != 0) {
      // TODO:10125 通番訂正 202404実装対象外
      /*
      errNo = if_acx_ResultGet(Tpraid.TPRAID_ACX, rcvBuf);
      if ((errNo == OK) && (AcxCom.ifAcbSelect() & CoinChanger.ECS_777 != 0)) {
        await rcEcsPayOutReadAfterOut(tsBuf.acx.order);
      }
       */
    } else {
      errNo = OK;
    }
    rcResetAcrOdr();

    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != OK) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcAcrAcbModeOffResultGet(): err_no[$errNo]");
    } else {
      if (clrFlg == 1) {
        //出金・回収結果が正常のため、再出金用メモリをクリア
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcAcrAcbModeOffResultGet(): CHGOUT_DATA Clear");
        AtSingl atSing = SystemFunc.readAtSingl();
        atSing.chgOutData = ChgOutData();
      }
    }

    return errNo; /* OK or MSG_ACRACT or MSG_CHANGING or MSG_SETTINGERR or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_Result_OrderChk
  static Future<int> rcAcrAcbResultOrderChk(String func) async {
    int errNo = 0;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if (tsBuf.acx.order == AcxProcNo.ACX_NOT_ORDER.no) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.normal, "$func: Skip");
      errNo = OK;
    } else {
      errNo = DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId;
    }

    return errNo;
  }

  /// 払出枚数Read
  ///  関連tprxソース: rc_acracb.c - rcEcs_PayOut_Read_After_Out
  static Future<int> rcEcsPayOutReadAfterOut(int order) async {
    int errNo = 0;

    switch (order) {
      case 50: //AcxProcNo.ACX_CHANGE_OUT_GET
        errNo = await rcEcsPayOutReadDtl();
        break;
      default:
        errNo = 0;
        break;
    }

    return errNo;
  }

  /// 払出枚数Read（メイン処理）
  ///  関連tprxソース: rc_acracb.c - rcEcs_PayOut_Read_Dtl
  static Future<int> rcEcsPayOutReadDtl() async {
    if (await RcSysChk.rcCheckOutSider() ||
        (AcxCom.ifAcbSelect() & CoinChanger.ECS_777 == 0)) {
      return 0;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcEcsPayOutReadDtl(): Start");

    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }

    // TODO:10125 通番訂正 202404実装対象外
    /*
    int errNo = rcEcs_PayOut_Read();
    if (errNo == OK) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcEcsPayOutReadDtl(): ResultGet");
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        return 0;
      }
      RxTaskStatBuf tsBuf = xRet.object;
      for (int i = 0; i < RcAcrAcbDef.ECS_OPESET_CNT; i++) {
        RcIfEvent.rcWaitSave();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ECS_PAYOUT_GET.no) {
          errNo = if_ecs_PayOutReadGet(Tpraid.TPRAID_ACX, ecsPayoutData, tsBuf.acx.devAck );
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk("rcEcsPayOutReadDtl()");
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        sleep(const Duration(microseconds: RcAcrAcbDef.ECS_OPESET_WAIT));  /* Soft Wait 100ms */
      }
    }
    if (errNo != OK) {
      rcResetAcrOdr();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcEcsPayOutReadDtl(): err_no[$errNo]");
    }
    return errNo;	/* OK or MSG_ACRLINEOFF */
     */
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcReset_AcrOdr
  static Future<void> rcResetAcrOdr() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    tsBuf.acx.order = AcxProcNo.ACX_NOT_ORDER.no;
  }

  ///  関連tprxソース: rc_acracb.c - rcCheck_AcrAcb_OFF_Type
  static int rcCheckAcrAcbOFFType(int billChk) {
    //rcCheck_AcrAcb_ON()にて判断された釣銭機非接続理由を返す
    int acrCnct = RcRegs.rcInfoMem.rcCnct.cnctAcrCnct;

    if (RcRegs.rcInfoMem.rcCnct.cnctAcrOnoff != 0) {
      return DlgConfirmMsgKind.MSG_TEXT188.dlgId; //釣銭機ＯＦＦ状態です。\n釣機ＯＮへ変更して下さい。
    }
    if (billChk == 1) {
      if (acrCnct != 2) {
        return DlgConfirmMsgKind.MSG_ACB_NEED.dlgId; //この機能は釣銭釣札機接続でないと\n使用できません
      }
    }
    if (acrCnct == 0) {
      return DlgConfirmMsgKind
          .MSG_TEXT189.dlgId; //自動釣銭釣札機設定が正しくありま\nせん。スペック設定を行って下さい
    }
    if (RcSysChk.rcChkTRDrwAcxNotUse()) {
      return DlgConfirmMsgKind
          .MSG_TR_ACX_NOTUSE.dlgId; //練習モードでの釣銭機「禁止」に設定されています
    }
    return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_MemorySet
  //rcClr_TtlRBuf()後に行わないとクリアされることに注意
  static Future<void> rcAcrAcbMemorySet(CoinStock coinData) async {
    int type = await rcCheckAcrAcbON(0);
    int chgDrwSystem = await CmCksys.cmAcxChgdrwSystem();
    int flg = 0;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (await rcCheckAcrAcbNotAct() != 0) {
      return;
    }

    if (type != 0) {
      mem.tTtllog.t100600.acr1Sht = coinData.holder!.coin1;
      mem.tTtllog.t100600.acr5Sht = coinData.holder!.coin5;
      mem.tTtllog.t100600.acr10Sht = coinData.holder!.coin10;
      mem.tTtllog.t100600.acr50Sht = coinData.holder!.coin50;
      mem.tTtllog.t100600.acr100Sht = coinData.holder!.coin100;
      mem.tTtllog.t100600.acr500Sht = coinData.holder!.coin500;
      mem.tTtllog.t100600.acr1PolSht = coinData.overflow!.coin1;
      mem.tTtllog.t100600.acr5PolSht = coinData.overflow!.coin5;
      mem.tTtllog.t100600.acr10PolSht = coinData.overflow!.coin10;
      mem.tTtllog.t100600.acr50PolSht = coinData.overflow!.coin50;
      mem.tTtllog.t100600.acr100PolSht = coinData.overflow!.coin100;
      mem.tTtllog.t100600.acr500PolSht = coinData.overflow!.coin500;
      mem.tTtllog.t100600.acrOthPolSht = coinData.coinRjct;
      mem.tTtllog.t100600Sts.acrCoinSlot = cMem.coinData.coinslot;
      flg = 1;
    }
    if (type == CoinChanger.ACR_COINBILL) {
      mem.tTtllog.t100600.acb1000Sht = coinData.holder!.bill1000;
      mem.tTtllog.t100600.acb2000Sht = coinData.holder!.bill2000;
      mem.tTtllog.t100600.acb5000Sht = coinData.holder!.bill5000;
      mem.tTtllog.t100600.acb10000Sht = coinData.holder!.bill10000;
      mem.tTtllog.t100600.acb1000PolSht = coinData.overflow!.bill1000;
      mem.tTtllog.t100600.acb2000PolSht = coinData.overflow!.bill2000;
      mem.tTtllog.t100600.acb5000PolSht = coinData.overflow!.bill5000;
      mem.tTtllog.t100600.acb10000PolSht = coinData.overflow!.bill10000;
      mem.tTtllog.t100600.acbRejectCnt = coinData.billRjct;
      mem.tTtllog.t100600.acbFillPolSht = 0;
      flg = 1;
    }
    if (chgDrwSystem == 1) {
      TprLog().logAdd(
          await RcSysChk.getTid(),
          LogLevelDefine.normal,
          "AcxMemSet    : ChgDrw  ["
          "${coinData.drawData!.coin500}, "
          "${coinData.drawData!.coin100}, "
          "${coinData.drawData!.coin50}, "
          "${coinData.drawData!.coin10}, "
          "${coinData.drawData!.coin5}, "
          "${coinData.drawData!.coin1}]");
      mem.tTtllog.t100600.acr1PolSht += coinData.drawData!.coin1;
      mem.tTtllog.t100600.acr5PolSht += coinData.drawData!.coin5;
      mem.tTtllog.t100600.acr10PolSht += coinData.drawData!.coin10;
      mem.tTtllog.t100600.acr50PolSht += coinData.drawData!.coin50;
      mem.tTtllog.t100600.acr100PolSht += coinData.drawData!.coin100;
      mem.tTtllog.t100600.acr500PolSht += coinData.drawData!.coin500;
      flg = 1;
    }
    if (RcKyDrawChk.rcChkDrawChkOverFlowStockInclude() != 0) {
      TprLog().logAdd(
          await RcSysChk.getTid(),
          LogLevelDefine.normal,
          "AcxMemSet    : OverFlow["
          "${RcKyccin.acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00500.id]}, "
          "${RcKyccin.acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00100.id]}, "
          "${RcKyccin.acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00050.id]}, "
          "${RcKyccin.acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00010.id]}, "
          "${RcKyccin.acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00005.id]}, "
          "${RcKyccin.acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00001.id]}]");
      mem.tTtllog.t100600.acr1PolSht += RcKyccin
          .acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00001.id];
      mem.tTtllog.t100600.acr5PolSht += RcKyccin
          .acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00005.id];
      mem.tTtllog.t100600.acr10PolSht += RcKyccin
          .acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00010.id];
      mem.tTtllog.t100600.acr50PolSht += RcKyccin
          .acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00050.id];
      mem.tTtllog.t100600.acr100PolSht += RcKyccin
          .acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00100.id];
      mem.tTtllog.t100600.acr500PolSht += RcKyccin
          .acbMem.overflow_data.stock_count[CoinBillKindList.CB_KIND_00500.id];
      flg = 1;
    }
    //在高不確定情報セット
    mem.tTtllog.t100600Sts.chgStockStateErr = cMem.acbData.chgStockStateErr;

    if (flg == 1) {
      //実績セットがあった
      //在高取得日時セット
      mem.tTtllog.t100600.stockDatetime = coinData.dateTime;

      //ログ出力
      TprLog().logAdd(
          await RcSysChk.getTid(),
          LogLevelDefine.normal,
          "AcxMemSet    : Stock   ["
          "${mem.tTtllog.t100600.acb10000Sht}, "
          "${mem.tTtllog.t100600.acb5000Sht}, "
          "${mem.tTtllog.t100600.acb2000Sht}, "
          "${mem.tTtllog.t100600.acb1000Sht}, "
          "${mem.tTtllog.t100600.acr500Sht}, "
          "${mem.tTtllog.t100600.acr100Sht}, "
          "${mem.tTtllog.t100600.acr50Sht}, "
          "${mem.tTtllog.t100600.acr10Sht}, "
          "${mem.tTtllog.t100600.acr5Sht}, "
          "${mem.tTtllog.t100600.acr1Sht}]");
      TprLog().logAdd(
          await RcSysChk.getTid(),
          LogLevelDefine.normal,
          "AcxMemSet    : Pol     ["
          "${mem.tTtllog.t100600.acb10000PolSht}, "
          "${mem.tTtllog.t100600.acb5000PolSht}, "
          "${mem.tTtllog.t100600.acb2000PolSht}, "
          "${mem.tTtllog.t100600.acb1000PolSht}, "
          "${mem.tTtllog.t100600.acr500PolSht}, "
          "${mem.tTtllog.t100600.acr100PolSht}, "
          "${mem.tTtllog.t100600.acr50PolSht}, "
          "${mem.tTtllog.t100600.acr10PolSht}, "
          "${mem.tTtllog.t100600.acr5PolSht}, "
          "${mem.tTtllog.t100600.acr1PolSht}]");
      TprLog().logAdd(
          await RcSysChk.getTid(),
          LogLevelDefine.normal,
          "AcxMemSet    : Stock_State_Err  ["
          "${mem.tTtllog.t100600Sts.chgStockStateErr}]   "
          "Get_DateTime[${mem.tTtllog.t100600.stockDatetime}]");
    }
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_StockSet
  static Future<void> rcAcrAcbStockSet() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcAcrAcbStockSet() rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return;
    }
    rcAcrAcbMemorySet(tsBuf.acx.coinStock);
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_StockUpdate
  static Future<int> rcAcrAcbStockUpdate(int pop) async {
    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    int errNo = await rcChkAcrAcbChkStock(pop);
    await rcAcrAcbStockSet();
    return errNo; /* OK or MSG_ACRLINEOFF */
  }

  ///  関連tprxソース: rc_acracb.c - rcCheck_AcrAcb_NotAct
  static Future<int> rcCheckAcrAcbNotAct() async {
    //釣銭機を動作させないか判定
    if (await RcSysChk.rcCheckOutSider()) {
      return 1;
    }
    if (RcSysChk.rcChkTRDrwAcxNotUse()) {
      return 1;
    }
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcPrg_AcrAcb_ChangeOut
  static Future<int> rcPrgAcrAcbChangeOut(int price) async {
    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    int errNo = await rcAcrAcbAnswerRead2();
    if (price != 0) {
      if (errNo == Typ.OK) {
        errNo = await rcAcrAcbChangeOut(price);
      }
      if (errNo == Typ.OK) {
        errNo = await rcPrgAcrAcbResultGet();
      }
      // TODO : 動作中で帰ってきた場合のみ無視して先に進む
      if (errNo == DlgConfirmMsgKind.MSG_ACRACT.dlgId) {
        errNo = 0;
      }
    }
    if (errNo == Typ.OK) {
      errNo = await rcAcrAcbStockUpdate(1);
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinStatus_Chk
  static bool rcAcrAcbCinStatusChk(int errNo) {
    return ((errNo == DlgConfirmMsgKind.MSG_ACB_CINSTATUS.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACB_STOPSTATUS.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_TEXT196.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_TEXT197.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_TEXT198.dlgId));
  }

  ///  関連tprxソース: rc_acracb.c - rcPrg_AcrAcb_ResultGet
  static Future<int> rcPrgAcrAcbResultGet() async {
    int errNo = Typ.OK;
    int waitCnt = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    if ((cMem.stat.acrMode & RcRegs.GET_MODE) != 0) {
      /* Answer Get Mode ? */
      if ((tsBuf.acx.order == AcxProcNo.ACX_CHANGE_OUT.no) ||
          (tsBuf.acx.order == AcxProcNo.ACX_SPECIFY_OUT.no)) {
        waitCnt = RcAcrAcbDef.ACX_RESULT_CNT * 6;
      } else {
        waitCnt = RcAcrAcbDef.ACX_RESULT_CNT;
      }
      for (int i = 0; i < waitCnt; i++) {
        await RcAcx.rcAcxMain();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if ((tsBuf.acx.order == AcxProcNo.ACX_RESULT_GET.no) ||
            (tsBuf.acx.order == AcxProcNo.ACX_CHANGE_OUT_GET.no) ||
            (tsBuf.acx.order == AcxProcNo.ACX_PICKUP_GET.no)) {
          errNo = await rcAcrAcbResultGet(tsBuf.acx.devAck);
          if ((errNo == Typ.OK) &&
              ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) != 0)) {
            rcEcsPayOutReadAfterOut(tsBuf.acx.order);
          }
          rcResetAcrOdr();
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk("rcPrgAcrAcbResultGet");
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        await Future.delayed(
            const Duration(microseconds: RcAcrAcbDef.ACX_RESULT_WAIT));
      }
    }
    if (errNo != Typ.OK) {
      rcResetAcrOdr();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcPrgAcrAcbResultGet: errNo[$errNo]");
    }
    return errNo;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_ChkNearFull
  static int rcAcrAcbChkNearFull() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_StopWindow_Check
  static Future<int> rcAcrAcbStopWindowCheck() async {
    CBillKind stopDispAcr = CBillKind(); /* Binary Data Buffer*/
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem regsMem = RegsMem();
    int tId = await RcSysChk.getTid();
    String? tprxHome = EnvironmentData().env['TPRX_HOME'];
    String iniName = '$tprxHome/conf/mac_info.ini';

    TprLog().logAdd(
        tId, LogLevelDefine.normal, 'rcAcrAcb_StopWindow_Check() start');

    if (!await RcFncChk.rcCheckAcbStopDsp()) {
      /* 釣銭機指定枚数停止仕様が有効ではない */
      TprLog().logAdd(
          tId, LogLevelDefine.normal, 'rcAcrAcb_StopWindow_Check() off Return');
      return OK;
    }
    if (RcFncChk.rcCheckChgErrMode() &&
        !(await RcFncChk.rcCheckAcbStopDspMode())) {
      /* エラー画面表示 */
      TprLog().logAdd(tId, LogLevelDefine.normal,
          'rcAcrAcb_StopWindow_Check() ErrorDisp Return');
      AcbInfo.acbStopdspFlg = 1;
      return OK; /* OKを返しておく */
    }

    int acrMode = cMem.stat.acrMode & RcRegs.POP_MODE;
    int type = await RcAcracb.rcCheckAcrAcbON(0);
    if (type != 0 && acrMode != 0) {
      JsonRet ret =
          await getJsonValue(iniName, "acx_stop_info", "acx_stop_5000");
      if (!ret.result) {
        stopDispAcr.bill5000 = int.parse(ret.value);
      }

      ret = await getJsonValue(iniName, "acx_stop_info", "acx_stop_2000");
      if (!ret.result) {
        stopDispAcr.bill2000 = int.parse(ret.value);
      }

      ret = await getJsonValue(iniName, "acx_stop_info", "acx_stop_1000");
      if (!ret.result) {
        stopDispAcr.bill1000 = int.parse(ret.value);
      }

      ret = await getJsonValue(iniName, "acx_stop_info", "acx_stop_500");
      if (!ret.result) {
        stopDispAcr.coin500 = int.parse(ret.value);
      }

      ret = await getJsonValue(iniName, "acx_stop_info", "acx_stop_100");
      if (!ret.result) {
        stopDispAcr.coin100 = int.parse(ret.value);
      }

      ret = await getJsonValue(iniName, "acx_stop_info", "acx_stop_50");
      if (!ret.result) {
        stopDispAcr.coin50 = int.parse(ret.value);
      }

      ret = await getJsonValue(iniName, "acx_stop_info", "acx_stop_10");
      if (!ret.result) {
        stopDispAcr.coin10 = int.parse(ret.value);
      }

      ret = await getJsonValue(iniName, "acx_stop_info", "acx_stop_5");
      if (!ret.result) {
        stopDispAcr.coin5 = int.parse(ret.value);
      }

      ret = await getJsonValue(iniName, "acx_stop_info", "acx_stop_1");
      if (!ret.result) {
        stopDispAcr.coin1 = int.parse(ret.value);
      }

      if (((stopDispAcr.coin1 != 0) &&
              (regsMem.tTtllog.t100600.acr1Sht < stopDispAcr.coin1)) ||
          ((stopDispAcr.coin5 != 0) &&
              (regsMem.tTtllog.t100600.acr5Sht < stopDispAcr.coin5)) ||
          ((stopDispAcr.coin10 != 0) &&
              (regsMem.tTtllog.t100600.acr10Sht < stopDispAcr.coin10)) ||
          ((stopDispAcr.coin50 != 0) &&
              (regsMem.tTtllog.t100600.acr50Sht < stopDispAcr.coin50)) ||
          ((stopDispAcr.coin100 != 0) &&
              (regsMem.tTtllog.t100600.acr100Sht < stopDispAcr.coin100)) ||
          ((stopDispAcr.coin500 != 0) &&
              (regsMem.tTtllog.t100600.acr500Sht < stopDispAcr.coin500)) ||
          ((stopDispAcr.bill1000 != 0) &&
              (regsMem.tTtllog.t100600.acb1000Sht < stopDispAcr.bill1000)) ||
          ((stopDispAcr.bill2000 != 0) &&
              (regsMem.tTtllog.t100600.acb2000Sht < stopDispAcr.bill2000)) ||
          ((stopDispAcr.bill5000 != 0) &&
              (regsMem.tTtllog.t100600.acb5000Sht < stopDispAcr.bill5000))) {
        String message = 'rcAcracbStopWindow_Check(): '
            '1[$regsMem.tTtllog.t100600.acr1Sht]<[$stopDispAcr.coin1] '
            '5[$regsMem.tTtllog.t100600.acr5Sht]<[$stopDispAcr.coin5] '
            '10[$regsMem.tTtllog.t100600.acr10Sht]<[$stopDispAcr.coin10] '
            '50[$regsMem.tTtllog.t100600.acr50Sht]<[$stopDispAcr.coin50] '
            '100[$regsMem.tTtllog.t100600.acr100Sht]<[$stopDispAcr.coin100] '
            '500[$regsMem.tTtllog.t100600.acr500Sht]<[$stopDispAcr.coin500] '
            '1000[$regsMem.tTtllog.t100600.acb1000Sht]<[$stopDispAcr.bill1000] '
            '2000[$regsMem.tTtllog.t100600.acb2000Sht]<[$stopDispAcr.bill2000] '
            '5000[$regsMem.tTtllog.t100600.acb5000Sht]<[$stopDispAcr.bill5000]\n';
        TprLog().logAdd(tId, LogLevelDefine.normal, message);

        return DlgConfirmMsgKind.MSG_MONEY_SUPPLEMENT2.dlgId;
      }
    }
    String message = 'rcAcracbStopWindow_Check(): '
        '1[$regsMem.tTtllog.t100600.acr1Sht]<[$stopDispAcr.coin1] '
        '5[$regsMem.tTtllog.t100600.acr5Sht]<[$stopDispAcr.coin5] '
        '10[$regsMem.tTtllog.t100600.acr10Sht]<[$stopDispAcr.coin10] '
        '50[$regsMem.tTtllog.t100600.acr50Sht]<[$stopDispAcr.coin50] '
        '100[$regsMem.tTtllog.t100600.acr100Sht]<[$stopDispAcr.coin100] '
        '500[$regsMem.tTtllog.t100600.acr500Sht]<[$stopDispAcr.coin500] '
        '1000[$regsMem.tTtllog.t100600.acb1000Sht]<[$stopDispAcr.bill1000] '
        '2000[$regsMem.tTtllog.t100600.acb2000Sht]<[$stopDispAcr.bill2000] '
        '5000[$regsMem.tTtllog.t100600.acb_5000Sht]<[$stopDispAcr.bill5000]\n';
    TprLog().logAdd(tId, LogLevelDefine.normal, message);

    TprLog().logAdd(
        tId, LogLevelDefine.normal, 'rcAcrAcb_StopWindow_Check() ok end');

    return OK;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_acracb.c - rc_Acb_Inhale
  static int rcAcbInhale() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rc_AcrAcb_AnswerReadDtl
  static Future<int> rcAcrAcbAnswerReadDtl() async {
    int errNo = 0;
    int i = 0;
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (cBuf.apbfActFlg == 1) {
      return 0;
    }
    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    errNo = await _rcAcrAcb_AnswerRead(); /* OK or MSG_ACRLINEOFF */
    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    if (errNo == OK) {
      log = "rcAcrAcbAnswerReadDtl: ResultGet\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      await RcAcx.rcAcxMain();
      if (tsBuf.acx.stat != 0) {
        errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
        tsBuf.acx.stat = 0;
      }
      if (tsBuf.acx.order == AcxProcNo.ACX_RESULT_GET.no) {
        errNo = await RcAcracb.rcAcrAcbResultGet(tsBuf.acx.devAck);
        if (errNo != 0) {
          log = "rcAcrAcbAnswerReadDtl: ResultGet->errNo[$errNo]\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          if (errNo == DlgConfirmMsgKind.MSG_ACB_CINSTATUS.dlgId) {
            log =
                "ChgCin Device Stat:[${cMem.acbData.acbDeviceStat}] -> CinWait in AnswerRead\n";
            TprLog()
                .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            cMem.acbData.acbDeviceStat = AcxStatus.CinWait.id; /* CinWait */
            if (AcxCom.ifAcbSelect() & CoinChanger.RT_300_X != 0) {
              errNo = DlgConfirmMsgKind.MSG_TEXT198.dlgId;
            } else if (AcxCom.ifAcbSelect() & CoinChanger.ACB_20_X != 0) {
              errNo = DlgConfirmMsgKind.MSG_TEXT196.dlgId;
            } else {
              errNo = DlgConfirmMsgKind.MSG_TEXT197.dlgId;
            }
          } else if (errNo == DlgConfirmMsgKind.MSG_ACB_STOPSTATUS.dlgId) {
            log =
                "ChgCin Device Stat:[${cMem.acbData.acbDeviceStat}] -> CinStop in AnswerRead\n";
            TprLog()
                .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            cMem.acbData.acbDeviceStat = AcxStatus.CinStop.id; /* CinStop */
            if (AcxCom.ifAcbSelect() & CoinChanger.RT_300_X != 0) {
              errNo = DlgConfirmMsgKind.MSG_TEXT198.dlgId;
            } else if (AcxCom.ifAcbSelect() & CoinChanger.ACB_20_X != 0) {
              errNo = DlgConfirmMsgKind.MSG_TEXT196.dlgId;
            } else {
              errNo = DlgConfirmMsgKind.MSG_TEXT197.dlgId;
            }
          } else if ((RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 0) &&
              ((errNo == DlgConfirmMsgKind.MSG_ACRACT.dlgId) ||
                  (errNo == DlgConfirmMsgKind.MSG_CHARGING.dlgId)) &&
              (!await RcFncChk.rcCheckCPWRMode())) {
            log = "rcAcrAcbAnswerReadDtl: errNo[$errNo] set OK\n";
            TprLog()
                .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            errNo = 0;
          }
        }
      } else {
        errNo = await rcAcrAcbResultOrderChk('rcAcrAcbAnswerReadDtl');
        if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {}
      }
      await Future.delayed(
          const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
    }

    if (errNo != OK) {
      rcResetAcrOdr();
      log = "rcAcrAcbAnswerReadDtl: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinStart_Proc
  static Future<int> rcAcrAcbCinStartProc(int type, int startType) async {
    int errNo = OK;
    switch (startType) {
      case 1:
        errNo = await AcxOuterrIn.ifAcxOutErrIn(Tpraid.TPRAID_ACX, type);
        break;
      case 2:
        errNo = await AcxMenteIn.ifAcxMenteIn(Tpraid.TPRAID_ACX, type);
        break;
      case 3:
        CinStartEcs cinStartEcs = CinStartEcs();
        CinData reject = CinData();
        cinStartEcs.total_sht = 1;
        cinStartEcs.auto_continue = 0;
        cinStartEcs.suspention = 0;
        cinStartEcs.reject = reject;
        errNo = await EcsCsta.ifEcsCinStart(Tpraid.TPRAID_ACX, cinStartEcs);
        break;
      default:
        errNo = await AcxCsta.ifAcxCinStart(Tpraid.TPRAID_ACX, type);
        break;
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinStart
  static Future<int> rcAcrAcbCinStart(int startType) async {
    int errNo = OK;
    int type = 0;
    const callFunction = "rcAcrAcbCinStart";

    if (await rcCheckAcrAcbNotAct() != 0) {
      return FbLibDef.FALSE;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.acbData.acbFullStat == "0") {
      TprLog()
          .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "CinStart");
    }
    await RcExt.rcCinReadGetWait(callFunction);

    cMem.stat.acrMode &= ~RcRegs.GET_MODE; // Reset Answer Get Mode
    if ((type = await rcCheckAcrAcbON(1)) != 0) {
      RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();
      tsBuf.acx.order = AcxProcNo.ACX_START.no;
      if ((errNo = await rcAcrAcbCinStartProc(type, startType)) == OK) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "$rcAcrAcbCinStart: rcCheck_AcrAcb_ON -> 0");
      errNo = OK;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != OK) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "$rcAcrAcbCinStart: errNo$errNo]");
    }
    return errNo; // OK or MSG_ACRLINEOFF or MSG_ACRERROR
  }

  ///  関連tprxソース: rc_acracb.c - rc_AcrAcb_CinStartDtl
  static Future<int> rcAcrAcbCinStartDtl(int startType) async {
    int errNo = OK;

    AcMem cMem = SystemFunc.readAcMem();
    RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();
    AtSingl atSingl = SystemFunc.readAtSingl();

    if (await rcCheckAcrAcbNotAct() != 0) {
      cMem.acbData.acbDeviceStat = AcxStatus.CinWait.id;
      return FbLibDef.FALSE;
    }
    errNo = await rcAcrAcbCinStart(startType); /* OK or MSG_ACRLINEOFF */
    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    if (errNo == OK) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "$rcAcrAcbCinStartDtl: ResultGet");
      for (int i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
        if (AcbInfo.reStartCnt == 0) {
          await RcAcx.rcAcxMain();
        }
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_START_GET.no) {
          errNo = await rcAcrAcbResultGet(tsBuf.acx.devAck);
          // TODO:グローリー対策
          errNo = OK;
          if (errNo == OK) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "ChgCin Device Stat:CinStart");
            cMem.acbData.acbDeviceStat = AcxStatus.CinStart.id;
            RcKyccin.rcAcbFullPriceSet();
            RcKyccin.rcAcrAcbReinShtSet();
            tsBuf.acx.initFlg = 0;
            atSingl.acracbStartFlg = 1; /* 入金確定　開始フラグ */
            AcbInfo.oldCcinPrice = 0;
          }
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk("rcAcrAcbCinStartDtl");
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        await Future.delayed(
            const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
      }
    }

    if (errNo != OK) {
      rcResetAcrOdr();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "$rcAcrAcbCinStartDtl: err_no[$errNo]");
    }
    return errNo;
  }

  /// 関連tprxソース: rc_acracb.c - rcChk_AcrAcb_FullErr
  static bool rcChkAcrAcbFullErr(int errNo) {
    return ((errNo == DlgConfirmMsgKind.MSG_ACRBILLFULL.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRCOINFULL.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRCBILLFULL.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRBILLFULL2.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRCOINFULL2.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRCBILLFULL2.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRBILLFULL3.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRCOINFULL3.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRCBILLFULL3.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRBILLFULL4.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRCOINFULL4.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACRCBILLFULL4.dlgId));
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinEnd
  static Future<int> rcAcrAcbCinEnd() async {
    int errNo = 0;
    int acbSelect;
    int ldata;
    int type;
    String log;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "CinEnd");
    await RckyccinAcb.rcCinReadGetWait2('rcAcrAcbCinEnd');

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((type = await rcCheckAcrAcbON(1)) != 0) {
      acbSelect = AcxCom.ifAcbSelect();
      if (acbSelect & CoinChanger.ECS_X == 1) {
        ldata = rcAcrAcbCngPriceMake();
        if (((cMem.acbData.keyChgcinFlg == '0') && /* 釣機入金実績上げでない */
                (cMem.acbData.totalPrice > ldata)) || /* スプリットでない */
            (cMem.acbData.totalPrice == 0)) {
          tsBuf.acx.order = AcxProcNo.ECS_CIN_END.no;
        } else {
          /* スプリット時は保留金30枚制限のため取り込む */
          tsBuf.acx.order = AcxProcNo.ECS_CIN_END_MOTION2.no;
        }
      } else {
        tsBuf.acx.pData = type;
        tsBuf.acx.order = AcxProcNo.ACX_CIN_END.no;
      }
      await RcAcx.rcAcxMain();
    } else {
      log = 'rcAcrAcbCinEnd: rcCheck_AcrAcb_ON -> 0';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      errNo = 0;
    }
    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CngPriceMake
  static int rcAcrAcbCngPriceMake() {
    int ldata = 0;
    RegsMem mem = SystemFunc.readRegsMem();

    if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
      ldata = RxLogCalc.rxCalcStlTaxAmt(mem);
    } else {
      ldata = -mem
          .tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt - 1].sptendChgAmt;
    }
    return (ldata);
  }

  // TODO:00016 佐藤 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinLcd_Ctrl
  static Future<void> rcAcrAcbCinLcdCtrl(int acbDeviceStat, int outPrc) async {
    int errNo;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();

    switch (acbDeviceStat) {
      case 2: // AcxStatus.CinAct.id
      case 3: // AcxStatus.CinWait.id
        if (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
          RcQcCom.rcQCLedCom(
              QcLedNo.QC_LED_COININ.index,
              QcLedColor.QC_LED_WHITE_COLOR.index,
              QcLedDisp.QC_LED_DISP_BRINK.index,
              50,
              50,
              6000);
          atSingl.ledCtrlFlg = 0;
        } else {
          if (RxLogCalc.rxCalcStlTaxAmt(mem) > cMem.acbData.totalPrice) {
            RcQcCom.rcQCLedCom(
                QcLedNo.QC_LED_COININ.index,
                QcLedColor.QC_LED_WHITE_COLOR.index,
                QcLedDisp.QC_LED_DISP_BRINK.index,
                50,
                50,
                6000);
            atSingl.ledCtrlFlg = 0;

            if (await RcSysChk.rcSysChkHappySmile()) {
              if (happySmileCinReset == 1) {
                if (atSingl.rckySelfMnt == 0) {
                  await RcfSelf.rcFselfQcCashDispRemake();
                }
                happySmileCinReset = 0;
              }
            }
          } else {
            if ((RxLogCalc.rxCalcStlTaxAmt(mem)) > 0) {
              // 商品登録後の画面訂正、指定訂正でLEDが緑に変わらないようにする為
              if (atSingl.ledCtrlFlg != 1) {
                RcqrCom.rcQcLeDAllOff(QcLedNo.QC_LED_ALL.index);
                RcQcCom.rcQCLedCom(
                    QcLedNo.QC_LED_COININ.index,
                    QcLedColor.QC_LED_GREEN_COLOR.index,
                    QcLedDisp.QC_LED_DISP_ON.index,
                    50,
                    50,
                    6000);
                atSingl.ledCtrlFlg = 1;
              }
            }
          }
        }
        break;
      default: // LEDの制御（全消灯）に影響を受け、締め処理（レシート印字）が遅くなっていたので、タイマーで処理するように変更
        await rcGtkTimerRemoveLedAfter();
        errNo = rcGtkTimerAddLedAfter(300, rcAcrAcbCinLcdAfter(outPrc), outPrc);
        if (errNo != 0) {
          log = 'rcAcrAcbCinLcdCtrl : Timer Error !!\n';
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
          await rcGtkTimerRemoveLedAfter();
        }
        break;
    }
  }

  ///  関連tprxソース: rc_acracb.c - rcGtkTimerRemoveLedAfter
  static Future<int> rcGtkTimerRemoveLedAfter() async {
    await RcTimer.rcTimerListRemove(RC_TIMER_LISTS.RC_GTK_LED_AFTER_TIMER.id);
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcGtkTimerAddLedAfter
  static int rcGtkTimerAddLedAfter(int timer, void func, int data) {
    if (RcTimer.rcTimerListRun(RC_TIMER_LISTS.RC_GTK_LED_AFTER_TIMER)) {
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }
    RcTimer.rcTimerListAdd(
        RC_TIMER_LISTS.RC_GTK_LED_AFTER_TIMER, timer, func, data);
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinLcd_After
  /// TODO:00010 長田 定義のみ追加
  static void rcAcrAcbCinLcdAfter(int data) {
    return;
  }

  ///  関連tprxソース: rc_acracb.c - rc_AcrAcb_CinEndDtl
  static Future<int> rcAcrAcbCinEndDtl() async {
    int errNo;
    int waitCnt;
    int i;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId); /* Set Bit 0 of KY_CHGCIN   */
      cMem.acbData.acbDeviceStat = AcxStatus.CinEnd.id;
      return 0;
    }
    errNo = await rcAcrAcbCinEnd(); /* OK or MSG_ACRLINEOFF */
    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    if (errNo == 0) {
      if (AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) {
        waitCnt = RcAcrAcbDef.ECS_END_CNT;
      } else {
        waitCnt = RcAcrAcbDef.ACX_ANSWER_CNT;
      }
      log = 'rcAcrAcbCinEndDtl: ResultGet\n';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      for (i = 0; i < waitCnt; i++) {
        await RcAcx.rcAcxMain();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_CIN_END_GET.no) {
          //errNo = rcAcrAcb_ResultGet(tsBuf.acx.devack);
          errNo = tsBuf.acx.stat;
          rcResetAcrOdr();
          if (errNo == 0) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "ChgCin Device Stat:CinEnd");
            cMem.acbData.acbDeviceStat = AcxStatus.CinEnd.id;
            RcSgCom.selfAcbacrErrFlg = 0;
          }
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk("rcAcrAcbCinEndDtl");
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
          if (AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) {
            if ((i > 0) && ((i % 100) == 0)) {
              log = 'rcAcrAcbCinEndDtl: ResultGet Retry cnt[$i]\n';
              TprLog()
                  .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            }
          }
        }
        if (AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) {
          await Future.delayed(
              const Duration(microseconds: RcAcrAcbDef.ECS_END_WAIT));
        } else {
          await Future.delayed(
              const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
        }
      }
    }
    if (errNo != 0) {
      rcResetAcrOdr();
      log = 'rcAcrAcbCinEndDtl: errNo[$errNo]\n';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId); /* Set Bit 0 of KY_CHGCIN   */
    if (await RcSysChk.rcChkAcrAcbCinLcd()) {
      await rcAcrAcbCinLcdCtrl(cMem.acbData.acbDeviceStat, 0);
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcATCT_CoinBillOut
  static Future<int> rcATCTCoinBillOut(TendType? eTendType) async {
    int sptendNo = 0; // スプリット段数の配列番号
    int acrChange = 0;
    int acrChangeflg = 0;
    int cha1flg;
    int ttlPrc = 0;
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem rMem = SystemFunc.readRegsMem();
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    KopttranBuff kopttranBuff = KopttranBuff();
    AtSingl atSingl = AtSingl();

    // TODO: 中間 釣銭機呼び出しのため一旦コメントアウト
    /*
    sptendNo = rMem.tTtllog.t100001Sts.sptendCnt - 1;
    if ( await RcAcracb.rcCheckAcrAcbNotAct() == 1 ) {
      return 0;
    }

    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
        if (await RcFncChk.rcCheckESVoidSMode() ||
            await RcFncChk.rcCheckESVoidIMode()) {
          if (esVoid.rtnChg < 0) {
            if (RcKyesVoid.rckyESVCheckAllCancel() == 0 &&
                await CmCksys.cmTb1System() == 0) {
              acrChange = RcKyesVoid.rckyECVChkdrwamt();
            } else {
              acrChange = esVoid.rtnChg.abs();
            }
          }
        } else {
          if (rMem.tTtllog.t100100[sptendNo].sptendData < 0) {
            if (rMem.tTtllog.t100100[sptendNo].sptendCd ==
                FuncKey.KY_CASH.keyId) {
              acrChange = rMem.tTtllog.t100100[sptendNo].sptendData.abs();
              if (RcSysChk.rcsyschkSm66FrestaSystem()
                  && RcFncChk.rcCheckRcptvoidLoadOrgTran()) {
                acrChange -= rMem.tTtllog.t100002Sts.rcptCashReturncash;
              }
            }
          }
        }
        break;
      case TendType.TEND_TYPE_TEND_AMOUNT:
        if (DEPARTMENT_STORE) {
          if (RckyWorkin.rcWorkinChkWorkType(rMem.tTtllog) ==
              WkTyp.WK_ORDER.index) {
            acrChangeflg = rcChkMoneyConfChangeFlg();
            if (acrChangeflg == 1) {
              break;
            }
          }
        }
        if (await RcFncChk.rcCheckESVoidSMode() ||
            await RcFncChk.rcCheckESVoidIMode()) {
          if (esVoid.rtnChg < 0) {
            if (RcKyesVoid.rckyESVCheckAllCancel() == 0 &&
                await CmCksys.cmTb1System() == 0) {
              acrChange = RcKyesVoid.rckyECVChkdrwamt();
            } else {
              acrChange = esVoid.rtnChg.abs();
            }
          }
        } else {
          acrChange = rMem.tTtllog.t100100[sptendNo].sptendChgAmt;
        }
        break;
      case TendType.TEND_TYPE_POST_TEND_END:
        if (await RcFncChk.rcCheckESVoidSMode() ||
            await RcFncChk.rcCheckESVoidIMode()) {
          if (esVoid.rtnChg < 0) {
            if (RcKyesVoid.rckyESVCheckAllCancel() == 0 &&
                await CmCksys.cmTb1System() == 0) {
              acrChange = RcKyesVoid.rckyECVChkdrwamt();
            } else {
              acrChange = esVoid.rtnChg.abs();
            }
          }
        } else {
          acrChange = cMem.postReg.change;
        }
        break;
      default:
        acrChangeflg = rcChkMoneyConfChangeFlg();
        if (acrChangeflg == 1) {
          break;
        }
        return OK;
    }

    if (cBuf.dbTrm.seikatsuclubOpe == 0) {
      if (!await RcFncChk.rcCheckESVoidSMode() ||
          await RcFncChk.rcCheckESVoidIMode()) {
        cha1flg =
        rMem.tTtllog.t100100[sptendNo].sptendCd == FuncKey.KY_CHA1.keyId ? 1 : 0;
        if (cha1flg == 1) {
          acrChange = 0;
        }
      }
    }

    if ( await rcCheckIndividChange() == true) {
      if (cMem.acbData.inputPrice == 0) {
        cMem.acbData.inputPrice = cMem.acbData.totalPrice;
      }
      if (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
        ttlPrc = rcGetChgAmt();
      } else {
        ttlPrc = RxLogCalc.rxCalcStlTaxOutAmt(rMem);
      }

      if (CATALINA_SYSTEM) {
        if (RcExt.cmCatalinaSystem()) {
          ttlPrc -= rMem.tmpbuf.catalinaTtlamt;
        }
      }

      if (cBuf.dbTrm.discBarcode28d == 0) {
        ttlPrc -= rMem.tmpbuf.beniyaTtlamt;
      }

      ttlPrc -= rMem.tmpbuf.notepluTtlamt;

      if (RESERV_SYSTEM) {
        if (CmCksys.cmReservSystem() == 0 ||
            CmCksys.cmNetDoAreservSystem() == 0
                && RcReserv.rcReservReceiptCall()) {
          ttlPrc -= await RcReserv.rcreservReceiptAdvance();
        }
      }
    }

    if (ttlPrc <= cMem.acbData.inputPrice) {
      cMem.acbData.inputPrice = cMem.acbData.totalPrice;
    }

    if (cMem.acbData.totalPrice != 0 &&
        cMem.acbData.totalPrice != cMem.acbData.inputPrice) {
      acrChange = cMem.acbData.totalPrice - cMem.acbData.inputPrice;
    } else if (cMem.acbData.totalPrice == 0 && acrChangeflg == 1) {
      if (await RcFncChk.rcCheckESVoidSMode() ||
          await RcFncChk.rcCheckESVoidIMode()) {
        if (sptendNo >= 0 && sptendNo < SPTEND_MAX) {
          acrChange = rMem.tTtllog.t100100[sptendNo].sptendFaceAmt -
              rMem.tTtllog.t100100[sptendNo].sptendData;
          if (DEPARTMENT_STORE) {
            if (rMem.tTtllog.t100100[sptendNo].sptendData >
                rMem.tTtllog.t100100[sptendNo].sptendInAmt &&
                RckyWorkin.rcWorkinChkWorkType(rMem.tTtllog) ==
                    WkTyp.WK_ORDER.index) {
              acrChange = rMem.tTtllog.t100100[sptendNo].sptendFaceAmt -
                  RxLogCalc.rxCalcStlTaxAmt(rMem);
            }
          }
        }
      }
    }

    // 手動返品時は現金合算分を出金する
    if (RckyRfdopr.rcRfdOprCheckManualRefundMode() == true) {
      if (eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA
          || eTendType == TendType.TEND_TYPE_TEND_AMOUNT) {
        int num = 0;
        List<T100100> spltData; // スプリットデータ格納ポインタ
        spltData = rMem.tTtllog.t100100;
        for (num = 0; num < rMem.tTtllog.t100001Sts.sptendCnt; num++) {
          if (spltData[num].sptendCd == FuncKey.KY_CASH.keyId) {
            acrChange += spltData[num].sptendData.abs();
          }
        }
      }
    }
*/
    /* 売掛伝票印字仕様でサンワドーの場合は、払出を０とするため */
    // TODO: 中間 釣銭機呼び出しのため一旦コメントアウト
    /*   if (await RcSysChk.rcChkChargeSlipSystem() &&
        await RcExt.rcChkMemberChargeSlipCard() &&
        cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) {
      await RcFlrda.rcReadKopttran(
          rMem.tTtllog.t100100[0].sptendCd, kopttranBuff);

      if (kopttranBuff.crdtTyp == 27) {
        // TODO:00005 中間 現計実装のため、ログ出力一旦コメントアウト
        //TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0,
        //   "rcATCT_CoinBillOut() set acrChange 0 for ChargeSlip_System" );
        acrChange = 0;
      }
    }
*/
    if (SS_CR2) {
      // TODO:00005 中間 現計実装のため、Define宣言無しの部分を一旦コメントアウト
      /* 特定CR2接続仕様では、訓練モードの現金は入金額の返却、
   お釣りのみの取引の場合、払出を０とする */
      /*     if ((rcChk_CR2_NSW_Data_System())
        && (MEM->ttlrbuf.ope_mode_flg == OM_TRAINIG))
    {
      if ( MEM->ttlrbuf.sptend_cnt == qr_read_sptend_cnt )	// お釣りのみの取引の場合
          {
        TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcATCT_CoinBillOut() set acrChange 0 for CR2 Now Only Chg" );
        acrChange = 0;
      }
      else if ( MEM->ttlrbuf.refund_amt != 0 )	// 返品取引の場合
          {
        TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcATCT_CoinBillOut() set acrChange 0 for CR2 Now Refund" );
        acrChange = 0;
      }
      else
      {
        TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcATCT_CoinBillOut() set acrChange totalPrice for CR2 " );
        acrChange = cMem.acbData.totalPrice;
      }
    }
*/
    }

    // TODO: 中間 釣銭機呼び出しのため一旦コメントアウト
    /* 釣銭釣札機ON & 通番訂正差額設定 */
    /*
    if ( RcFncChk.rcFncchkRcptAcracbCheck() ) {
      if ( atSingl.rcptCash.status == 1 || atSingl.rcptCash.actChk == 0 ) {
        /* 返金額ステータスOFF */
        atSingl.rcptCash.status = 0;
        acrChange += atSingl.rcptCash.pay;
      }
    }

    int type = rcCheckAcrAcbOn( 1 );
    if ( type == CoinChanger.ACR_COINBILL ) {
      int selectFlgAcb50X =  AcxCom.ifAcbSelect() & CoinChanger.ACB_50_X;
      int selectFlgEcsX =  AcxCom.ifAcbSelect() & CoinChanger.ECS_X;
      if ( ( selectFlgAcb50X > 0 || selectFlgEcsX > 0 ) &&
          cBuf.iniMacInfo.acx_flg.acb50_ssw24_0 == 1 ) {
        acrChange %= 1000000;
      } else {
        acrChange %= 100000;
      }
    } else if ( type == CoinChanger.ACR_COINONLY ) {
      acrChange %= 1000;
    }
    if (type != 0) {
     */
    errNo = await rcAcrAcbChangeOut(acrChange);
    /*
    }
    */
    return errNo;
  }

  /// 関連tprxソース: rc_acracb.c - rcChk_MoneyConf_ChangeFlg
  static Future<int> rcChkMoneyConfChangeFlg() async {
    int acrChangeflg = 0;
    int ttlPrc = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return acrChangeflg;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await RcSysChk.rcCheckIndividChange()) {
      if (cMem.acbData.inputPrice == 0) {
        cMem.acbData.inputPrice = cMem.acbData.totalPrice;
      }
      if (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
        /* sprit tend ? */
        ttlPrc = rcGetChgAmt();
      } else {
        ttlPrc = RxLogCalc.rxCalcStlTaxInAmt(mem);
        if (RcCatalina.cmCatalinaSystem(0)) {
          ttlPrc -= mem.tmpbuf.catalinaTtlamt;
        }
        if (cBuf.dbTrm.discBarcode28d != 0) {
          ttlPrc -= mem.tmpbuf.beniyaTtlamt;
        } else {
          ttlPrc -= mem.tmpbuf.notepluTtlamt;
        }
        if (((await CmCksys.cmReservSystem() != 0) ||
                (await CmCksys.cmNetDoAreservSystem() != 0)) &&
            RcReserv.rcReservReceiptCall()) {
          ttlPrc -= await RcReserv.rcreservReceiptAdvance();
        }
      }
      if (ttlPrc <= cMem.acbData.inputPrice) {
        cMem.acbData.inputPrice = cMem.acbData.totalPrice;
      }
      if ((cMem.acbData.totalPrice != 0) &&
          (cMem.acbData.totalPrice != cMem.acbData.inputPrice)) {
        acrChangeflg = 1;
      } else if (cMem.acbData.totalPrice == 0) {
        if (!((await RcFncChk.rcCheckESVoidSMode()) ||
            (await RcFncChk.rcCheckESVoidIMode()))) {
          if (mem.tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt - 1]
                  .sptendCd ==
              FuncKey.KY_CASH.keyId) {
            if ((mem.tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt - 1]
                        .sptendFaceAmt !=
                    0) &&
                (mem.tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt - 1]
                        .sptendFaceAmt >=
                    mem.tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt - 1]
                        .sptendData)) {
              acrChangeflg = 1;
            }
          }
        }
      }
    }
    return acrChangeflg;
  }

  /// 関連tprxソース: rc_acracb.c - rc_GetChg_amt
  static int rcGetChgAmt() {
    int acrChange = 0;
    int sptendNum;
    RegsMem rMem = RegsMem();

    sptendNum = rMem.tTtllog.t100001Sts.sptendCnt - 2;
    if (sptendNum >= 0) {
      acrChange = rMem.tTtllog.t100100[sptendNum].sptendChgAmt;
    }

    if (acrChange < 0) {
      acrChange = -acrChange;
    } else {
      acrChange = 0;
    }
    return acrChange;
  }

  /// 関連tprxソース: rc_acracb.c - rcCheck_AcrAcb_ON
  static Future<int> rcCheckAcrAcbON(int mode_chk) async {
    /* Coin-Changer 0:No 1:ACR and ACB 2:ACR only */
    if (RcRegs.rcInfoMem.rcCnct.cnctAcrOnoff != 0) {
      return 0;
    }
    return await RcSysChk.rcChkAcrAcbSystem(mode_chk);
  }

  /// 処理概要：コマンド送信とセットで使用する場合のレスポンス取得関数.
  ///         類似関数:rcAcrAcb_ModeOffResultGet
  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_ResultGet
  static Future<int> rcAcrAcbResultGet(TprMsgDevAck2_t rcvBuf) async {
    /* コマンド送信とセットで使用する場合のレスポンス取得関数.  類似関数:rcAcrAcb_ModeOffResultGet */
    int errNo = 0;
    int clrFlg = 0;
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSingl = SystemFunc.readAtSingl();

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    if (tsBuf.acx.order == AcxProcNo.ACX_NOT_ORDER.no) {
      return 0; //NOT_ORDER=ACX_ORDER_RESET(skip)と考え、何もせずOKとする
    }
    if ((tsBuf.acx.order == AcxProcNo.ACX_CHANGE_OUT_GET.no) ||
        (tsBuf.acx.order == AcxProcNo.ACX_PICKUP_GET.no)) {
      clrFlg = 1;
    }
    if (await rcCheckAcrAcbON(1) != 0) {
      errNo = AcxResu.ifAcxResultGet(Tpraid.TPRAID_ACX, rcvBuf);
      if ((errNo == 0) && ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) != 0)) {
        await rcEcsPayOutReadAfterOut(tsBuf.acx.order);
      }
      rcResetAcrOdr();
    } else {
      errNo = 0;
      rcResetAcrOdr();
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != 0) {
      log = 'rcAcrAcbResultGet: errNo[$errNo]\n';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    } else {
      if (clrFlg == 1) {
        //出金・回収結果が正常のため、再出金用メモリをクリア
        log = 'rcAcrAcbResultGet CHGOUT_DATA Clear';
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        atSingl.chgOutData.type = 0;
        atSingl.chgOutData.price = 0;
        atSingl.chgOutData.data.bill = 0;
        atSingl.chgOutData.data.billMode = 0;
        atSingl.chgOutData.data.coin = 0;
        atSingl.chgOutData.data.coinMode = 0;
        atSingl.chgOutData.data.leave = 1;
        atSingl.chgOutData.data.cBillKind.coin1 = 0;
        atSingl.chgOutData.data.cBillKind.coin5 = 0;
        atSingl.chgOutData.data.cBillKind.coin10 = 0;
        atSingl.chgOutData.data.cBillKind.coin50 = 0;
        atSingl.chgOutData.data.cBillKind.coin100 = 0;
        atSingl.chgOutData.data.cBillKind.coin500 = 0;
        atSingl.chgOutData.data.cBillKind.bill1000 = 0;
        atSingl.chgOutData.data.cBillKind.bill2000 = 0;
        atSingl.chgOutData.data.cBillKind.bill5000 = 0;
        atSingl.chgOutData.data.cBillKind.bill10000 = 0;
      }
    }
    return errNo; /* OK or MSG_ACRACT or MSG_CHANGING or MSG_SETTINGERR or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  /// 関連tprxソース: rc_acracb.c - rcChk_AcrAcb_RjctErr
  static bool rcChkAcrAcbRjctErr(int errNo) {
    return ((errNo == DlgConfirmMsgKind.MSG_TEXT141.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_TEXT143.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_TEXT144.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_TEXT126.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_TEXT127.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_ACR_REJECT.dlgId));
  }

  /// 関連tprxソース: rc_acracb.c - rc_AcrAcb_CinReadDtl
  static Future<int> rcAcrAcbCinReadDtl() async {
    int errNo = 0;
    String log;
    int i;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (cBuf.apbfActFlg == 1) {
      return 0;
    }
    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    errNo = await rcAcrAcbCinRead(); /* OK or MSG_ACRLINEOFF */
    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    if (errNo == 0) {
      if (AcbInfo.autoDecisionFlg == 1) {
        rcGtkTimerRemoveAcb();
        AcbInfo.stepCnt = 1;
        errNo = rcGtkTimerAddAcb(
            RcAcrAcbDef.ACX_CREADGET_EVENT.toInt(), rcAcbAutoDecChk);
      } else {
        for (i = 0; i < RcAcrAcbDef.ACX_CREADGET_CNT; i++) {
          await RcAcx.rcAcxMain();
          if (tsBuf.acx.stat != 0) {
            errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
            tsBuf.acx.stat = 0;
            break;
          }
          if (tsBuf.acx.order == AcxProcNo.ACX_CIN_GET.no) {
            errNo = await rcAcrAcbCinReadGet();
            break;
          } else {
            errNo = await rcAcrAcbResultOrderChk("rcAcrAcbCinReadDtl");
            if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
              break;
            }
          }
          await Future.delayed(
              const Duration(microseconds: RcAcrAcbDef.ACX_CREADGET_WAIT));
        }
      }
    }

    if (errNo != 0) {
      rcResetAcrOdr();
      log = "rcAcrAcbCinReadDtl: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcChgCinCancelDtl
  static Future<int> rcChgCinCancelDtl() async {
    int errNo = 0;
    int acbSelect = AcxCom.ifAcbSelect();
    AtSingl atSingl = SystemFunc.readAtSingl();

    if (acbSelect & CoinChanger.ECS_X != 0) {
      errNo = await rcEcsCinCancelDtl();
    } else if (acbSelect & CoinChanger.SST1 != 0) {
      errNo = rcSstCinCancelProc();
    }
    if (atSingl.chgstopCtrlFlg == 2) {
      await RcKyPlu.rcAnyTimeCinStartProc();
      atSingl.chgstopCtrlFlg = 0;
    }
    return errNo;
  }

  ///　処理概要：処理前釣銭機在高セット
  ///          rcClr_TtlRBuf()後に行わないとクリアされることに注意
  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_BeforeMemorySet
  static Future<void> rcAcrAcbBeforeMemorySet(CoinData coinData) async {
    int type = await rcCheckAcrAcbON(0);
    int chgDrwSystem = await CmCksys.cmAcxChgdrwSystem();
    int flg = 0;
    RegsMem mem = SystemFunc.readRegsMem();

    if (await rcCheckAcrAcbNotAct() != 0) {
      return;
    }
    if (type != 0) {
      mem.tTtllog.t100600Sts.bfreStockSht1 = coinData.holder.coin1;
      mem.tTtllog.t100600Sts.bfreStockSht5 = coinData.holder.coin5;
      mem.tTtllog.t100600Sts.bfreStockSht10 = coinData.holder.coin10;
      mem.tTtllog.t100600Sts.bfreStockSht50 = coinData.holder.coin50;
      mem.tTtllog.t100600Sts.bfreStockSht100 = coinData.holder.coin100;
      mem.tTtllog.t100600Sts.bfreStockSht500 = coinData.holder.coin500;
      mem.tTtllog.t100600Sts.bfreStockPolSht1 = coinData.overflow.coin1;
      mem.tTtllog.t100600Sts.bfreStockPolSht5 = coinData.overflow.coin5;
      mem.tTtllog.t100600Sts.bfreStockPolSht10 = coinData.overflow.coin10;
      mem.tTtllog.t100600Sts.bfreStockPolSht50 = coinData.overflow.coin50;
      mem.tTtllog.t100600Sts.bfreStockPolSht100 = coinData.overflow.coin100;
      mem.tTtllog.t100600Sts.bfreStockPolSht500 = coinData.overflow.coin500;
      flg = 1;
    }
    if (type == CoinChanger.ACR_COINBILL) {
      mem.tTtllog.t100600Sts.bfreStockSht1000 = coinData.holder.bill1000;
      mem.tTtllog.t100600Sts.bfreStockSht2000 = coinData.holder.bill2000;
      mem.tTtllog.t100600Sts.bfreStockSht5000 = coinData.holder.bill5000;
      mem.tTtllog.t100600Sts.bfreStockSht10000 = coinData.holder.bill10000;
      mem.tTtllog.t100600Sts.bfreStockPolSht1000 = coinData.overflow.bill1000;
      mem.tTtllog.t100600Sts.bfreStockPolSht2000 = coinData.overflow.bill2000;
      mem.tTtllog.t100600Sts.bfreStockPolSht5000 = coinData.overflow.bill5000;
      mem.tTtllog.t100600Sts.bfreStockPolSht10000 = coinData.overflow.bill10000;
      flg = 1;
    }
    if (chgDrwSystem == 1) {
      mem.tTtllog.t100600Sts.bfreStockPolSht1 += coinData.drawData.coin1;
      mem.tTtllog.t100600Sts.bfreStockPolSht5 += coinData.drawData.coin5;
      mem.tTtllog.t100600Sts.bfreStockPolSht10 += coinData.drawData.coin10;
      mem.tTtllog.t100600Sts.bfreStockPolSht50 += coinData.drawData.coin50;
      mem.tTtllog.t100600Sts.bfreStockPolSht100 += coinData.drawData.coin100;
      mem.tTtllog.t100600Sts.bfreStockPolSht500 += coinData.drawData.coin500;
      flg = 1;
    }

    if (flg == 1) {
      TprLog().logAdd(
          await RcSysChk.getTid(),
          LogLevelDefine.normal,
          "AcxMemBefore : Stock["
          "${mem.tTtllog.t100600Sts.bfreStockSht10000}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht5000}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht2000}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht1000}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht500}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht100}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht50}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht10}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht5}, "
          "${mem.tTtllog.t100600Sts.bfreStockSht1}]");
      TprLog().logAdd(
          await RcSysChk.getTid(),
          LogLevelDefine.normal,
          "AcxMemBefore : Pol  ["
          "${mem.tTtllog.t100600Sts.bfreStockPolSht10000}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht5000}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht2000}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht1000}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht500}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht100}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht50}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht10}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht5}, "
          "${mem.tTtllog.t100600Sts.bfreStockPolSht1}]");
    }
  }

  ///  関連tprxソース: rc_acracb.c - rc_Acb_ssw14Set
  /// TODO:00010 長田 定義のみ追加
  static int rcAcbSsw14Set(int chgFlg) {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcEcs_StateReadDtl
  static Future<int> rcEcsStateReadDtl(StateEcs stateEcs) async {
    String __FUNCTION__ = 'rcEcsStateReadDtl';
    int errNo = 0;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBUF = xRet.object;

    if (cBuf.apbfActFlg == 1) {
      return (OK);
    }

    if (await rcCheckAcrAcbNotAct() != 0) {
      stateEcs = StateEcs();
      return 0;
    }
    int select = AcxCom.ifAcbSelect() & CoinChanger.ECS_X;
    if ((await rcCheckAcrAcbON(1) == 0) || (select == 0)) {
      return 0;
    }

    rcAcxStateRead(0);
    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    for (int i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
      await RcIfEvent.rcWaitSave();
      if (tsBUF.acx.stat != 0) {
        errNo = await rcAcrAcbLineoffChk(tsBUF.acx.stat, 0);
        tsBUF.acx.stat = 0;
        break;
      }
      if (tsBUF.acx.order == AcxProcNo.ECS_STATE_GET.no) {
        stateEcs = tsBUF.acx.stateEcs;
        errNo = OK;
        rcResetAcrOdr();
        break;
      } else {
        errNo = await rcAcrAcbResultOrderChk(__FUNCTION__);
        if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
          break;
        }
      }
      await Future.delayed(
          const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
    }

    if (errNo != OK) {
      rcResetAcrOdr();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          '$__FUNCTION__ : %s: errNo[$errNo]\n');
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcGtkTimerRemoveCcin
  static Future<int> rcGtkTimerRemoveCcin() async {
    await RcTimer.rcTimerListRemove(RC_TIMER_LISTS.RC_GTK_ACB_CCIN_TIMER.id);
    return 0;
  }

  /// 入金取消処理用タイマ関数
  /// 関連tprxソース: rc_acracb.c - rcGtkTimerAddCcin
  static int rcGtkTimerAddCcin(int timer, void func) {
    if (RcTimer.rcTimerListRun(RC_TIMER_LISTS.RC_GTK_ACB_CCIN_TIMER)) {
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }
    RcTimer.rcTimerListAdd(
        RC_TIMER_LISTS.RC_GTK_ACB_CCIN_TIMER, timer, func, 0);
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcEcs_CinCancelDtl
  static Future<int> rcEcsCinCancelDtl() async {
    int errNo = 0;
    int waitCnt = 0;
    String log = '';
    int i = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId); /* Set Bit 0 of KY_CHGCIN   */
      cMem.acbData.acbDeviceStat = AcxStatus.CinEnd.id;
      return 0;
    }
    if ((await rcCheckAcrAcbON(1) != CoinChanger.ACR_COINBILL) ||
        (!(AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0))) {
      return 0;
    }

    errNo = await rcEcsCinCancel(); /* OK or MSG_ACRLINEOFF */
    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    if (errNo == 0) {
      waitCnt = RcAcrAcbDef.ECS_END_CNT;
      log = "rcEcsCinCancelDtl: ResultGet\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      for (i = 0; i < waitCnt; i++) {
        await RcAcx.rcAcxMain();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_RESULT_GET.no) {
          errNo = await rcAcrAcbResultGet(tsBuf.acx.devAck);
          if (errNo == 0) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "ChgCin Device Stat:CinEnd");
            cMem.acbData.acbDeviceStat = AcxStatus.CinEnd.id;
          }
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk("rcEcsCinCancelDtl");
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
          if ((i > 0) && ((i % 100) == 0)) {
            log = "rcEcsCinCancelDtl: ResultGet Retry cnt[$i]\n";
            TprLog()
                .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          }
        }
        await Future.delayed(
            const Duration(microseconds: RcAcrAcbDef.ECS_END_WAIT));
      }
    }
    if (errNo != 0) {
      rcResetAcrOdr();
      log = "rcEcsCinCancelDtl: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId); /* Set Bit 0 of KY_CHGCIN   */

    if (await RcSysChk.rcChkAcrAcbCinLcd()) {
      await rcAcrAcbCinLcdCtrl(cMem.acbData.acbDeviceStat, 0);
    }
    if (await RcSysChk.rcChkFselfMain()) {
      // 入金取消した場合は、入金完了通知状態を初期化する
      tsBuf.chk.kycash_redy_flg = -1;
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcSst_CinCancelProc
  /// TODO:00010 長田 定義のみ追加
  static int rcSstCinCancelProc() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcEcs_CinCancel
  static Future<int> rcEcsCinCancel() async {
    int errNo = 0;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    log = "rcEcsCinCancel (CinEnd)";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    await RcExt.rcCinReadGetWait("rcEcsCinCancel");

    // TODO:10154 釣銭機UI関連
    // #if COLORFIP
    // ColorFipWindowCreateStlTendChange_Acb(0, NULL, 0, 2);
    // ColorFipWindowCreateStlTendChange_Acb(1, NULL, 0, 2);
    // #endif

    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */
    if (await rcCheckAcrAcbON(1) != 0) {
      tsBuf.acx.order = AcxProcNo.ACX_CANCEL.no;
      if ((errNo = await EcsCend.ifEcsCinEnd(Tpraid.TPRAID_ACX, 0, 1)) == 0) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      log = "rcEcsCinCancel: rcCheckAcrAcbON -> 0";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      errNo = 0;
    }
    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinReadGet
  static Future<int> rcAcrAcbCinReadGet() async {
    String log = '';
    int errNo = 0;
    int ret;
    int rejectType;
    int acbSelect;
    int dlgErrno;
    CinInfo cinInfo = CinInfo();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }

    acbSelect = AcxCom.ifAcbSelect();
    await RcAcx.rcAcxMain();
    if (tsBuf.acx.order == AcxProcNo.ACX_CIN_GET.no) {
      AcbInfo.stepCnt = 0;
      cinInfo = tsBuf.acx.cinInfo;
      errNo = await rcAcrAcbDeviceStatSetCom();
      if ((errNo == 0) || (RcAcracb.rcChkAcrAcbRjctErr(errNo))) {
        rcAcracbCinTimeWatching();
        await rcCcinPriceSetCom();
        rcAcrAcbInTimeAmountSet();
        if (((ret = rcCinReadChgFullChk()) != 0) &&
            (rcAcrAcbFullDispChk() != 0)) {
          errNo = ret;
          if (acbSelect & CoinChanger.RT_300_X != 0) {
            if (RcFncChk.rcChkErr() != 0) {
              //フルとリジェクトが同時発生時、釣機のステータスはリジェクトになっている。
              //リジェクト解除後、釣機のステータスがフルになったらリジェクトエラーはクリアしてフルエラーに差し替える
              dlgErrno = TprLibDlg.tprLibDlgNoCheck();
              if (RcAcracb.rcChkAcrAcbRjctErr(dlgErrno)) {
                RckyClr.rcClearPopDisplay();
                RcExt.rcClearErrStat("rcAcrAcbCinReadGet");
              }
            }

            cMem.acbData.acbFullNodisp = 1; //フルエラーをずっと表示し続けないよう非表示する制御
          } else {
            if (AcbInfo.autoDecisionFlg != 2) {
              RcKyccin.rcAcbPriceDataSet();
              if (AcbInfo.autoDecisionFlg == 1) {
                AcbInfo.autoDecisionFlg = 2;
              }
              await RcKyccin.rcAcrAcbCinFinish();
              if (AcbInfo.autoDecisionFlg == 2) {
                AcbInfo.autoDecisionFlg = 1;
              }
              cMem.acbData.acbFullStat = '1';
            }
          }
        } else if ((rcCinReadBillErrChk(cinInfo)) ||
            (rcCinReadCoinErrChk(cinInfo))) {
          errNo = DlgConfirmMsgKind.MSG_ACRERROR.dlgId;
        } else if (((acbSelect & CoinChanger.SST1 != 0) &&
                ((rejectType = rcChkSstRjStock()) != 0)) ||
            ((acbSelect & CoinChanger.FAL2 != 0) &&
                ((rejectType = rcChkFal2RjStock()) != 0)) ||
            ((acbSelect & CoinChanger.ECS_X != 0) &&
                ((rejectType = rcChkEcsRjStock()) != 0)) ||
            ((acbSelect & CoinChanger.ACB_50_X != 0) &&
                ((rejectType = rcChkAcbRjStock()) != 0))) {
          errNo = rcAcrAcbCinReadGetRjct(rejectType);
          inAmoutSetFlg = 1;
          rcAcrAcbInTimeAmountSet();
        } else if (rcCinReadCinStopReservChk(cinInfo)) {
          errNo = DlgConfirmMsgKind.MSG_ACRACT.dlgId;
        } else {
          if ((await RcSysChk.rcQCChkQcashierSystem()) &&
              (RcQcDsp.qc_take_money_flg != 0)) {
            log = "rcAcrAcbCinReadGet: Take Bill OK!\n";
            TprLog()
                .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            RcExt.rcWarnPopDownLcd("rcAcrAcbCinReadGet");
            RcQcDsp.qc_take_money_flg = 0;
            RcQcCom.rcQCBzGtkTimerRemove();
            if (!(RcFncChk.rcQCCheckMenteDspMode()) &&
                !(await RcFncChk.rcCheckChgLoanMode()) &&
                !(RcFncChk.rcCheckChgCinMode()) &&
                !(await RcFncChk.rcCheckChgPtnCoopMode())) {
              RcQcCom.rcQCMovieFileSet(RcQcCom.qc_com_screen);
              RcQcCom.rcQCMovieStart();
              RcQcCom.rcQCSound(
                  RcQcCom.qc_com_screen, QcSoundTyp.QC_SOUND_TYP1);
            }
          } else if ((await RcSysChk.rcChkSQRCTicketSystem()) &&
              (sqrcTakeMoneyFlg != 0)) {
            log = "rcAcrAcbCinReadGet: Take Bill OK!\n";
            TprLog()
                .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            RcExt.rcWarnPopDownLcd("rcAcrAcbCinReadGet");
            sqrcTakeMoneyFlg = 0;
          }
        }
      }
      cMem.ent.errNo = await rcAcrAcbLineoffChk(errNo, 0);
      if ((cMem.ent.errNo != 0) && (TprLibDlg.tprLibDlgCheck2(1) == 0)) {
        //ダイアログ表示中のログ記載省略（ログが多くなるので）
        log = "rcAcrAcbCinReadGet: errNo[${cMem.ent.errNo}]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      }
      rcResetAcrOdr();
    }
    debugPrint(
        "**** rcAcrAcbCinReadGet cMem.ent.errNo = ${cMem.ent.errNo} *****");
    return cMem.ent.errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_DeviceStat_Set_Com
  static Future<int> rcAcrAcbDeviceStatSetCom() async {
    int errNo = 0;
    CinInfo cinInfo = CinInfo();
    StateEcs stateEcs = StateEcs();
    StateFal2 stateFal2 = StateFal2();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) {
      stateEcs = tsBuf.acx.stateEcs;
      errNo = await rcEcsDeviceStatSet(stateEcs);
    } else if (AcxCom.ifAcbSelect() & CoinChanger.FAL2 != 0) {
      stateFal2 = tsBuf.acx.stateFal2;
      errNo = rcFal2DeviceStatSet(stateFal2);
    } else {
      cinInfo = tsBuf.acx.cinInfo;
      errNo = await rcAcrAcbDeviceStatSet(cinInfo);
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rc_acracb_CinTime_Watching
  /// TODO:00010 長田 定義のみ追加
  static void rcAcracbCinTimeWatching() {}

  ///  関連tprxソース: rc_acracb.c - rcCcinPrice_Set_Com
  static Future<void> rcCcinPriceSetCom() async {
    String log = "";
    AtSingl AT_SING = SystemFunc.readAtSingl();
    AcMem CMEM = SystemFunc.readAcMem();
    RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();

    if(AT_SING.acracbStartFlg != 1){
      log = "rcCcinPriceSetCom: start_flg[${AT_SING.acracbStartFlg}] Prince Not Set";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return;
    }
    int acxType = AcxCom.ifAcbSelect();
    if (((acxType & CoinChanger.RT_300_X) != 0) && (CMEM.acbData.acbDeviceStat == AcxStatus.CinEnd.id)) {
      //RT-380では待機状態で硬貨投入強制排出が動作する。これが動作すると入金終了後の入金額が０(?)になっているため、入金終了後の入金額更新を行わない。
      log = "rcCcinPriceSetCom: RT-300 device_stat[${CMEM.acbData.acbDeviceStat}] ccin_price[${CMEM.acbData.ccinPrice}] Not Change\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return;
    }
    if ((acxType & CoinChanger.ECS_X) != 0) {
      RcAcracb.rcCcinPriceSetEcs(tsBuf.acx.cinInfoEcs);
    }
    else if ((acxType & CoinChanger.FAL2) != 0) {
      RcAcracb.rcCcinPriceSetFal2(tsBuf.acx.stateFal2);
    }
    else{
      RcAcracb.rcCcinPriceSet(tsBuf.acx.cinInfo);
    }
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_In_Time_Amount_Set
  /// TODO:00010 長田 定義のみ追加
  static void rcAcrAcbInTimeAmountSet() {}

  ///  関連tprxソース: rc_acracb.c - rcCinRead_ChgFullChk
  /// TODO:00010 長田 定義のみ追加
  static int rcCinReadChgFullChk() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_FullDispChk
  /// TODO:00010 長田 定義のみ追加
  static int rcAcrAcbFullDispChk() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcCinRead_BillErrChk
  /// TODO:00010 長田 定義のみ追加
  static bool rcCinReadBillErrChk(CinInfo cinInfo) {
    return false;
  }

  ///  関連tprxソース: rc_acracb.c - rcCinRead_CoinErrChk
  /// TODO:00010 長田 定義のみ追加
  static bool rcCinReadCoinErrChk(CinInfo cinInfo) {
    return false;
  }

  ///  関連tprxソース: rc_acracb.c - rcChk_Sst_RjStock
  /// TODO:00010 長田 定義のみ追加
  static int rcChkSstRjStock() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcChk_Fal2_RjStock
  /// TODO:00010 長田 定義のみ追加
  static int rcChkFal2RjStock() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcChk_Ecs_RjStock
  /// TODO:00010 長田 定義のみ追加
  static int rcChkEcsRjStock() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcChk_Acb_RjStock
  /// TODO:00010 長田 定義のみ追加
  static int rcChkAcbRjStock() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinReadGet_Rjct
  /// TODO:00010 長田 定義のみ追加
  static int rcAcrAcbCinReadGetRjct(int reject_type) {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcCinRead_CinStop_ReservChk
  /// TODO:00010 長田 定義のみ追加
  static bool rcCinReadCinStopReservChk(CinInfo cinInfo) {
    return false;
  }

  ///  関連tprxソース: rc_acracb.c - rcEcs_DeviceStat_Set
  static Future<int> rcEcsDeviceStatSet(StateEcs stateEcs) async {
    AcMem cMem = SystemFunc.readAcMem();
    AcbMem acbMem = SystemFunc.readAcbMem();

    if((stateEcs.actMode - 0x30) == 2){	//リセット中
      if(cMem.acbData.acbDeviceStat != AcxStatus.CinReset.id){
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "ChgCin Device Stat:CinReset");
        cMem.acbData.acbDeviceStat = AcxStatus.CinReset.id;  /* CinReset */

        if (await RcSysChk.rcSysChkHappySmile())
        {
          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR)
          {
            if (RcFncChk.rcCheckChgCinMode())
            {
              happySmileCinReset = 1;
            }
          }
        }
      }
    }
    else if((stateEcs.actMode - 0x30) == 1){	//異常中
      return (IfAcxDef.MSG_ACRERROR);
    }
    else if ((stateEcs.detail.bill == "10") || (stateEcs.detail.coin == "10")){
      return (IfAcxDef.MSG_ACRERROR);
    }
    else if((stateEcs.detail.bill == "31") || (stateEcs.detail.coin == "31")) {
      if(cMem.acbData.acbDeviceStat != AcxStatus.CinAct.id){
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "ChgCin Device Stat:CinAct");
        cMem.acbData.acbDeviceStat = AcxStatus.CinAct.id;  /* CinAct */
        acbMem.ccin_stop_flg = 0;	//入金額の更新許可（釣銭機動作中のため）
      }
    }
    else if(((stateEcs.detail.bill == "33") || (stateEcs.detail.bill == "30")) &&
            ((stateEcs.detail.coin == "33") || (stateEcs.detail.coin == "30"))){
      if(cMem.acbData.acbDeviceStat != AcxStatus.CinWait.id){
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "ChgCin Device Stat:CinWait");
        cMem.acbData.acbDeviceStat = AcxStatus.CinWait.id;  /* CinWait */
        acbMem.ccin_stop_flg = 0;	//入金額の更新許可（釣銭機動作中のため）
        inAmoutSetFlg = 1;
      }
    }
    else if((stateEcs.detail.bill == "00") && (stateEcs.detail.coin == "00")){
      if(cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id){
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "ChgCin Device Stat:CinEnd");
        cMem.acbData.acbDeviceStat = AcxStatus.CinEnd.id;  /* CinEnd */
        inAmoutSetFlg = 1;
      }
    }
    if ((await RcSysChk.rcChkAcrAcbCinLcd())
    || ((await RcSysChk.rcQCChkQcashierSystem()) && (RcFncChk.rcQCCheckMenteDspMode()))) {
      rcAcrAcbCinLcdCtrl(cMem.acbData.acbDeviceStat, 0);
    }
    return(0);
  }

  ///  関連tprxソース: rc_acracb.c - rcFal2_DeviceStat_Set
  /// TODO:00010 長田 定義のみ追加
  static int rcFal2DeviceStatSet(StateFal2 stateFal2) {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_DeviceStat_Set
  static Future<int> rcAcrAcbDeviceStatSet(CinInfo cinInfo) async {
    int err_no = 0;
    AcMem cMem = SystemFunc.readAcMem();
    AcbMem acbMem = SystemFunc.readAcbMem();

    if (cMem.acbData.acbDeviceStat == AcxStatus.CinStart.id) {
      if (cinInfo.cinflg.device_state != 1) {
        err_no = DlgConfirmMsgKind.MSG_ACB_START_ERR.dlgId;
      }
    }

    if (cinInfo.cinflg.device_state == 1) {
      cMem.acbData.acbFullStat = 0.toString();
      if ((cinInfo.cinflg.coindetail == 2) ||
          (cinInfo.cinflg.billdetail == 2)) {
        if (cMem.acbData.acbDeviceStat != AcxStatus.CinAct.id) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "ChgCin Device Stat:CinAct");
          cMem.acbData.acbDeviceStat = AcxStatus.CinAct.id; /* CinAct */
          acbMem.ccin_stop_flg = 0; //入金額の更新許可（釣銭機動作中のため）
        }
      } else {
        if (cMem.acbData.acbDeviceStat != AcxStatus.CinWait.id) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "ChgCin Device Stat:CinWait");
          cMem.acbData.acbDeviceStat = AcxStatus.CinWait.id; /* CinWait */
          acbMem.ccin_stop_flg = 0; //入金額の更新許可（釣銭機動作中のため）
          inAmoutSetFlg = 1;
        }
      }
    } else if (cinInfo.cinflg.device_state == 2) {
      if (cMem.acbData.acbDeviceStat != AcxStatus.CinStop.id) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "ChgCin Device Stat:CinStop");
        cMem.acbData.acbDeviceStat = AcxStatus.CinStop.id; /* CinStop */
        inAmoutSetFlg = 1;
      }
    } else if (cinInfo.cinflg.device_state == 0) {
      if (cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "ChgCin Device Stat:CinEnd");
        cMem.acbData.acbDeviceStat = AcxStatus.CinEnd.id; /* CinEnd */
        inAmoutSetFlg = 1;
      }
    }
    if (await RcSysChk.rcChkAcrAcbCinLcd()) {
      await rcAcrAcbCinLcdCtrl(cMem.acbData.acbDeviceStat, 0);
    }

    return (err_no);
  }

  ///  関連tprxソース: rc_acracb.c - rc_AcrAcb_CinStopDtl
  static Future<int> rcAcrAcbCinStopDtl() async {
    int errNo = 0;
    String log;
    int i;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) {
      return 0;
    }
    if (await rcCheckAcrAcbNotAct() != 0) {
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId); /* Set Bit 0 of KY_CHGCIN   */
      cMem.acbData.acbDeviceStat = AcxStatus.CinStop.id;
      return 0;
    }
    errNo = await rcAcrAcbCinStop(); /* OK or MSG_ACRLINEOFF */
    if (await RcAcracb.rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    if (errNo == 0) {
      log = "rcAcrAcbCinStopDtl: ResultGet\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      for (i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
        await RcAcx.rcAcxMain();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_RESULT_GET.no) {
          errNo = await rcAcrAcbResultGet(tsBuf.acx.devAck);
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk('rcAcrAcbCinStopDtl');
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        await Future.delayed(
            const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
      }
    }

    if (errNo != 0) {
      rcResetAcrOdr();
      log = "rcAcrAcbCinStopDtl: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHGCIN.keyId); /* Set Bit 0 of KY_CHGCIN   */
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinStop
  static Future<int> rcAcrAcbCinStop() async {
    int errNo = 0;
    int type = 0;
    String log;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "CinStop");
    await RcExt.rcCinReadGetWait("rcAcrAcbCinStop");

    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */
    if ((type = await rcCheckAcrAcbON(1)) != 0) {
      tsBuf.acx.order = AcxProcNo.ACX_STOP.no;
      if ((errNo = await AcxCstp.ifAcxCinStop(Tpraid.TPRAID_ACX, type)) == 0) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      log = "rcAcrAcbCinStop: rcCheckAcrAcbON -> 0";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      errNo = 0;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != 0) {
      log = "rcAcrAcbCinStop: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rc_Ecs_CinStartDtl
  static Future<int> rcEcsCinStartDtl(
      int autoContinue, int suspention, CinData? reject) async {
    int errNo = 0;
    String log;
    int i;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcbMem acbMem = AcbMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      cMem.acbData.acbDeviceStat = AcxStatus.CinWait.id;
      return 0;
    }
    errNo = await rcEcsCinStart(
        autoContinue, suspention, reject!); /* OK or MSG_ACRLINEOFF */
    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    if (errNo == 0) {
      log = "rcEcsCinStartDtl: ResultGet\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      for (i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
        if (AcbInfo.reStartCnt == 0) {
          await RcAcx.rcAcxMain();
        }
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_START_GET.no) {
          errNo = await rcAcrAcbResultGet(tsBuf.acx.devAck);
          if (errNo == 0) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "ChgCin Device Stat:CinAct");
            cMem.acbData.acbDeviceStat = AcxStatus.CinAct.id;
            acbMem.ccin_stop_flg = 0; //入金額の更新許可（釣銭機動作中のため）
            RcKyccin.rcAcbFullPriceSet();
            RcKyccin.rcAcrAcbReinShtSet();
            tsBuf.acx.initFlg = 0;
            atSingl.acracbStartFlg = 1; /* 入金確定　開始フラグ */
            AcbInfo.oldCcinPrice = 0;
          }
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk("rcEcsCinStartDtl");
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        await Future.delayed(
            const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
      }
    }

    if (errNo != 0) {
      rcResetAcrOdr();
      log = "rcEcsCinStartDtl: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcEcs_CinStart
  static Future<int> rcEcsCinStart(
      int autoContinue, int suspention, CinData reject) async {
    int errNo = 0;
    int type = 0;
    CinStartEcs cinStartEcs = CinStartEcs();
    String log;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "CinStart");
    await RcExt.rcCinReadGetWait('rcEcsCinStart');

    cinStartEcs.total_sht = 1;
    cinStartEcs.auto_continue = autoContinue;
    cinStartEcs.suspention = suspention;
    cinStartEcs.reject = reject;
    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */
    if ((type = await RcAcracb.rcCheckAcrAcbON(1)) != 0) {
      tsBuf.acx.order = AcxProcNo.ACX_START.no;
      if ((errNo = await EcsCsta.ifEcsCinStart(Tpraid.TPRAID_ACX, cinStartEcs)) == 0) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      log = "rcEcsCinStart: rcCheckAcrAcbON -> 0";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      errNo = 0;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != 0) {
      log = "rcEcsCinStart: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rcChk_AcrAcb_ChkStock
  static Future<int> rcChkAcrAcbChkStock(int pop) async {
    int errNo = 0;
    int waitCnt = 0;
    int i = 0, j = 0;
    String log = "";
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }

    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) {
      waitCnt = RcAcrAcbDef.ECS_STOCK_RETRY;
    } else {
      waitCnt = RcAcrAcbDef.ACX_STOCK_RETRY;
    }
    for (j = 0; j < waitCnt; j++) {
      for (i = 0; i < 5; i++) {
        if ((errNo = await rcAcrAcbStockRead()) != 0) {
          await Future.delayed(const Duration(microseconds: 10000));
          continue;
        } else {
          break;
        }
      }
      if (errNo != 0) {
        log = "rcChkAcrAcbChkStock($pop) StockRead->errNo[$errNo]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return errNo; /* MSG_ACRLINEOFF */
      }
      if (await rcCheckAcrAcbON(0) == 0) {
        return 0;
      }
      for (i = 0; i < RcAcrAcbDef.ACX_STOCK_CNT; i++) {
        await RcAcx.rcAcxMain();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_STOCK_GET.no) {
          errNo = await rcAcrAcbStockGet(tsBuf.acx.devAck);
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk("rcChkAcrAcbChkStock");
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        await Future.delayed(
            const Duration(microseconds: RcAcrAcbDef.ACX_STOCK_WAIT));
      }
      if (((errNo == DlgConfirmMsgKind.MSG_CHARGING.dlgId) ||
              (errNo == DlgConfirmMsgKind.MSG_ACRACT.dlgId) ||
              (errNo == DlgConfirmMsgKind.MSG_TEXT37.dlgId) ||
              (cMem.coinData.billfull.actFlg == 1)) &&
          (pop == 0)) {
        log =
            "rcChkAcrAcbChkStock($pop) StockGet CHARGE CONTINUE : errNo($errNo) act_flg(${cMem.coinData.billfull.actFlg})\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        await Future.delayed(const Duration(microseconds: 200000));
        continue;
      } else {
        break;
      }
    }
    switch (errNo) {
      case 3073: // DlgConfirmMsgKind.MSG_ACRLINEOFF
        log = "rcChkAcrAcbChkStock($pop) StockGet ACRLINEOFF\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        break;
      case 3417: // DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR
        log = "rcChkAcrAcbChkStock($pop) StockGet TELEGRAGHERR\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        break;
      case 0:
        log = "rcChkAcrAcbChkStock($pop) StockGet OK\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        break;
      default:
        log = "rcChkAcrAcbChkStock($pop) StockGet->errNo[$errNo] another err\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        if (pop == 1) {
          errNo = 0;
        }
        break;
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_StockRead
  static Future<int> rcAcrAcbStockRead() async {
    /* return after rcAcrAcb_StockGet() */
    int errNo = 0;
    int type = 0;
    String log;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    cMem.stat.acrMode &= ~RcRegs.POP_MODE; /* Reset Can Pop Window */
    if ((type = await RcAcracb.rcCheckAcrAcbON(0)) != 0) {
      tsBuf.acx.order = AcxProcNo.ACX_STOCK_READ.no;
      errNo = await AcxStcr.ifAcxStockRead(Tpraid.TPRAID_ACX, type);
      if (errNo != 0) {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      errNo = 0;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 1);
    if (errNo != 0) {
      log = "rcAcrAcbStockRead: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_StockGet
  static Future<int> rcAcrAcbStockGet(TprMsgDevAck2_t rcvBuf) async {
    /* before call rcAcrAcb_StockRead() */
    int errNo = 0;
    CoinData coinData = CoinData();
    coinData.holder = CBillKind();
    int type = 0;
    String log = "";
    AcMem cMem = SystemFunc.readAcMem();

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    cMem.stat.acrMode &= ~RcRegs.POP_MODE; /* Reset Can Pop Window */
    if ((type = await rcCheckAcrAcbON(0)) != 0) {
      errNo = await AcxStcg.ifAcxStockGet(
          Tpraid.TPRAID_ACX, type, coinData, rcvBuf);
      if (errNo == 0) {
        log = "rcAcrAcbStockGet OK\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        if (await RcFncChk.rcCheckItmMode()) {
          //登録画面での釣機払出や釣機入金
          RckyChgStatus.rckyChgstatusDraw(3, 0); //登録画面の釣機状態ラベル更新
        }
        if (await RcFncChk.rcCheckStlMode()) {
          //会計終了後に小計画面と登録画面の釣機状態ラベル更新
          RckyChgStatus.rckyChgstatusDraw(4, 0);
          RckyChgStatus.rckyChgstatusDraw(3, 0);
        }
        if (await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) {
          //１人制タワータイプは卓上機側は常に小計画面(Dual_Subttl)
          RckyChgStatus.rckyChgstatusDraw(4, 1);
        }
        cMem.coinData = coinData;
        rcAcrAcbChgStockStateSet(); //取得したデータより、在高不確定情報をセット
      }
      rcResetAcrOdr();
    } else {
      errNo = DlgConfirmMsgKind.MSG_ACROFF.dlgId;
      rcResetAcrOdr();
    }
    cMem.stat.acrMode |= RcRegs.POP_MODE; /* Set Can Pop Window */
    if (errNo == DlgConfirmMsgKind.MSG_ACROFF.dlgId) {
      errNo = 0;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != 0) {
      log = "rcAcrAcbStockGet errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_ChgStockState_Set
  static void rcAcrAcbChgStockStateSet() {
    //在高不確定状態セット
    AcMem cMem = SystemFunc.readAcMem();

    cMem.acbData.chgStockStateErr = 0;

    if(AcxCom.ifAcxStockStateChk(cMem.coinData.stockState) != 0)
    {
      if((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) {
        cMem.acbData.chgStockStateErr = DlgConfirmMsgKind.MSG_ACB_RECALC.dlgId;
      }
      else {
        cMem.acbData.chgStockStateErr = DlgConfirmMsgKind.MSG_TEXT43.dlgId;
      }
    }
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CoinInsertDtl
  static int rcAcrAcbCoinInsertDtl() {
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcb_AutoDecChk
  static Future<int> rcAcbAutoDecChk() async {
    String log;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }

    rcGtkTimerRemoveAcb();
    if ((AcbInfo.stepCnt < RcAcrAcbDef.ACX_CREADGET_CNT) &&
        (tsBuf.acx.order != AcxProcNo.ACX_NOT_ORDER.no) &&
        (tsBuf.acx.stat == 0)) {
      await RcAcx.rcAcxMain();
      if (tsBuf.acx.order == AcxProcNo.ACX_CIN_GET.no) {
        cMem.ent.errNo = await rcAcrAcbCinReadGet();
        if (AcbInfo.autoDecisionFlg == 1) {
          AcbInfo.autoDecisionFlg = 0;
          await RckyccinAcb.rcAutoDecision2();
        }
      } else {
        if ((await RcSysChk.rcChkAutoDecisionSystem()) &&
            (!await RcSysChk.rcSGChkSelfGateSystem()) &&
            (!await RcSysChk.rcQCChkQcashierSystem())) {
          AcbInfo.stepCnt++;
        }
        cMem.ent.errNo = rcGtkTimerAddAcb(
            RcAcrAcbDef.ACX_CREADGET_EVENT.toInt(), rcAcbAutoDecChk());
      }
      return cMem.ent.errNo;
    } else {
      rcResetAcrOdr();
      AcbInfo.stepCnt = 0;
      if (AcbInfo.autoDecisionFlg == 1) {
        AcbInfo.autoDecisionFlg = 0;
      }
      cMem.ent.errNo = rcGtkTimerAddAcb(100, RckyccinAcb.rcAutoDecision2());
      if (cMem.ent.errNo == 0) {
        if (tsBuf.acx.stat != 0) {
          cMem.ent.errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          if ((cMem.ent.errNo != 0) &&
              (!RcFncChk.rcCheckChgErrMode()) &&
              (!RckyccinAcb.rcChkCcinDialog()) &&
              (TprLibDlg.tprLibDlgCheck2(1) == 0)) {
            log = "rcAcbAutoDecChk: errNo[${cMem.ent.errNo}]\n";
            TprLog()
                .logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          }
          tsBuf.acx.stat = 0;
        } else if (AcbInfo.stepCnt == RcAcrAcbDef.ACX_CREADGET_CNT) {
          /* ACX_NOT_ORDERの時は交信エラーにしない。rcCinReadGet_WaitにてGet処理済の可能性があるため。 */
          log = "rcAcbAutoDecChk: retry over";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId;
        }
      }
      tsBuf.acx.stat = 0;
      AcbInfo.tempErrNo =
          cMem.ent.errNo; //タイマー処理を挟むことによりクリアキー等でerr_noがクリアされることがあるため退避
      return cMem.ent.errNo;
    }
  }

  ///  関連tprxソース: rc_acracb.c - rc_AcrAcb_AnswerRead
  static Future<int> rcAcrAcbAnswerRead2() async {
    /* 特定エラーを表示しない場合 */
    int errNo = 0;
    String log;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    errNo = await rcAcrAcbAnswerReadDtl();
    if ((errNo == DlgConfirmMsgKind.MSG_ACRACT.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_CHARGING.dlgId) ||
        (rcAcrAcbCinStatusChk(errNo))) {
      log = "rc_AcrAcb_AnswerRead: AnswerRead->errNo[$errNo] -> OK\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      errNo = 0;
    }
    if (errNo != 0) {
      rcResetAcrOdr();
      log = "rc_AcrAcb_AnswerRead: AnswerRead->errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return errNo;
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_CinRead
  static Future<int> rcAcrAcbCinRead() async {
    int acbSelect;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return 0;
    }
    acbSelect = AcxCom.ifAcbSelect();
    debugPrint("rcAcrAcb_CinRead startします。");
    await RcExt.rcCinReadGetWait('rcAcrAcbCinRead');
    if ((acbSelect & CoinChanger.SST1) != 0) {
      tsBuf.acx.order = AcxProcNo.SST_CIN_READ.no;
    } else if ((acbSelect & CoinChanger.FAL2) != 0) {
      tsBuf.acx.order = AcxProcNo.FAL2_CIN_READ.no;
    } else if ((acbSelect & CoinChanger.ECS_X) != 0) {
      tsBuf.acx.order = AcxProcNo.ECS_CIN_READ.no;
    } else {
      tsBuf.acx.order = AcxProcNo.ACX_CIN_READ.no;
    }
    //　メイン処理を呼ぶ
    await RcAcx.rcAcxMain();
    return 0;
  }

  ///  関連tprxソース: rc_acracb.c - rcChk_ChgStockState
  static int rcChkChgStockState() {
    //在高不確定チェック
    AcMem cMem = SystemFunc.readAcMem();
    return cMem.acbData.chgStockStateErr;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcrAcb_AnswerRead
  static Future<int> _rcAcrAcb_AnswerRead() async {
    /* return after call rcPrg_AcrAcb_ResultGet() */
    int err_no = 0;
    int type = 0;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return (FALSE);
    }
    RckyccinAcb.rcCinReadGetWait2("_rcAcrAcb_AnswerRead");

    AcMem CMEM = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return (FALSE);
    }
    RxTaskStatBuf TS_BUF = xRet.object;

    CMEM.stat.acrMode &= ~(RcRegs.GET_MODE); /* Reset Answer Get Mode */
    if ((type = await rcCheckAcrAcbON(1)) != 0) {
      TS_BUF.acx.order = AcxProcNo.ACX_ANS_READ.no;
      if ((err_no = await AcxAnsw.ifAcxAnswerRead(Tpraid.TPRAID_ACX, type)) ==
          OK) {
        CMEM.stat.acboffItminfFlg |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      err_no = OK;
    }
    err_no = await rcAcrAcbLineoffChk(err_no, 0);
    if (err_no != OK) {
      String log = "_rcAcrAcb_AnswerRead: err_no[${err_no}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return (err_no); /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  ///  関連tprxソース: rc_acracb.c - rcCcinPrice_Set_Ecs
  static void rcCcinPriceSetEcs(CinReadEcs cinInfoEcs) {
    int ccin_price = 0;

    if (RcKyccin.acbMem.ccin_stop_flg == 1) {
      //入金額の更新停止
      return;
    }
    AcMem CMEM = SystemFunc.readAcMem();

    ccin_price += cinInfoEcs.cindata.bill10000 * 10000;
    ccin_price += cinInfoEcs.cindata.bill5000 * 5000;
    ccin_price += cinInfoEcs.cindata.bill2000 * 2000;
    ccin_price += cinInfoEcs.cindata.bill1000 * 1000;
    ccin_price += cinInfoEcs.cindata.coin500 * 500;
    ccin_price += cinInfoEcs.cindata.coin100 * 100;
    ccin_price += cinInfoEcs.cindata.coin50 * 50;
    ccin_price += cinInfoEcs.cindata.coin10 * 10;
    ccin_price += cinInfoEcs.cindata.coin5 * 5;
    ccin_price += cinInfoEcs.cindata.coin1 * 1;
    CMEM.acbData.ccinPrice = ccin_price;
    AcbInfo.cindata.bill10000 = cinInfoEcs.cindata.bill10000;
    AcbInfo.cindata.bill5000 = cinInfoEcs.cindata.bill5000;
    AcbInfo.cindata.bill2000 = cinInfoEcs.cindata.bill2000;
    AcbInfo.cindata.bill1000 = cinInfoEcs.cindata.bill1000;
    AcbInfo.cindata.coin500 = cinInfoEcs.cindata.coin500;
    AcbInfo.cindata.coin100 = cinInfoEcs.cindata.coin100;
    AcbInfo.cindata.coin50 = cinInfoEcs.cindata.coin50;
    AcbInfo.cindata.coin10 = cinInfoEcs.cindata.coin10;
    AcbInfo.cindata.coin5 = cinInfoEcs.cindata.coin5;
    AcbInfo.cindata.coin1 = cinInfoEcs.cindata.coin1;
  }

  ///  関連tprxソース: rc_acracb.c - rcCcinPrice_Set
  static void rcCcinPriceSet(CinInfo cinInfo) {
    int ccin_price = 0;

    if (RcKyccin.acbMem.ccin_stop_flg == 1) { //入金額の更新停止
      return;
    }
    AcMem CMEM = SystemFunc.readAcMem();

    ccin_price += cinInfo.cindata.bill10000 * 10000;
    ccin_price += cinInfo.cindata.bill5000 * 5000;
    ccin_price += cinInfo.cindata.bill2000 * 2000;
    ccin_price += cinInfo.cindata.bill1000 * 1000;
    ccin_price += cinInfo.cindata.coin500 * 500;
    ccin_price += cinInfo.cindata.coin100 * 100;
    ccin_price += cinInfo.cindata.coin50 * 50;
    ccin_price += cinInfo.cindata.coin10 * 10;
    ccin_price += cinInfo.cindata.coin5 * 5;
    ccin_price += cinInfo.cindata.coin1 * 1;
    CMEM.acbData.ccinPrice = ccin_price;
    AcbInfo.cindata.bill10000 = cinInfo.cindata.bill10000;
    AcbInfo.cindata.bill5000 = cinInfo.cindata.bill5000;
    AcbInfo.cindata.bill2000 = cinInfo.cindata.bill2000;
    AcbInfo.cindata.bill1000 = cinInfo.cindata.bill1000;
    AcbInfo.cindata.coin500 = cinInfo.cindata.coin500;
    AcbInfo.cindata.coin100 = cinInfo.cindata.coin100;
    AcbInfo.cindata.coin50 = cinInfo.cindata.coin50;
    AcbInfo.cindata.coin10 = cinInfo.cindata.coin10;
    AcbInfo.cindata.coin5 = cinInfo.cindata.coin5;
    AcbInfo.cindata.coin1 = cinInfo.cindata.coin1;
  }

  ///  関連tprxソース: rc_acracb.c - rcCcinPrice_Set_Fal2
  static void rcCcinPriceSetFal2(StateFal2 stateFal2) {
    int ccin_price = 0;
    String log = "";
    RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();
    AcMem CMEM = SystemFunc.readAcMem();
    AcbMem acbMem = SystemFunc.readAcbMem();

    if ((tsBuf.acx.initFlg != 0) && (stateFal2.count.amount == 0)) {
      log = "rcCcinPriceSetFal2: Init Processing[${tsBuf.acx.initFlg}] ccin_price[${CMEM.acbData.ccinPrice}] not 0 set\n";
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);
      return;
    }
    if (acbMem.ccin_stop_flg == 1) { //入金額の更新停止
      return;
    }

    ccin_price = stateFal2.count.amount;
    CMEM.acbData.ccinPrice = ccin_price;

    AcbInfo.cindata.bill10000 = stateFal2.count.bill10000;
    AcbInfo.cindata.bill5000  = stateFal2.count.bill5000;
    AcbInfo.cindata.bill2000  = stateFal2.count.bill2000;
    AcbInfo.cindata.bill1000  = stateFal2.count.bill1000;
    AcbInfo.cindata.coin500   = stateFal2.count.coin500;
    AcbInfo.cindata.coin100   = stateFal2.count.coin100;
    AcbInfo.cindata.coin50    = stateFal2.count.coin50;
    AcbInfo.cindata.coin10    = stateFal2.count.coin10;
    AcbInfo.cindata.coin5     = stateFal2.count.coin5;
    AcbInfo.cindata.coin1     = stateFal2.count.coin1;
  }

  ///  関連tprxソース: rc_acracb.c - rcSst_State80_ReadDtl
  static Future<int> rcSstState80ReadDtl(StateSst1 stateSst1) async {
    int errNo = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      stateSst1 = StateSst1();
      return 0;
    }
    if ((await rcCheckAcrAcbON(1) != CoinChanger.ACR_COINBILL) ||
        ((AcxCom.ifAcbSelect() & CoinChanger.SST1) == 0)) {
      return 0;
    }

    rcAcxStateRead(80);
    if (await rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }
    for (int i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
      await RcIfEvent.rcWaitSave();
      if (tsBuf.acx.stat != 0) {
        errNo = await RcAcracb.rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
        tsBuf.acx.stat = 0;
        break;
      }
      if (tsBuf.acx.order == AcxProcNo.SST_STATE80_GET.no) {
        stateSst1 = StateSst1.copy(tsBuf.acx.stateSst1);
        errNo = Typ.OK;
        rcResetAcrOdr();
        break;
      } else {
        errNo = await rcAcrAcbResultOrderChk("rcSstState80ReadDtl");
        if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
          break;
        }
      }
      await Future.delayed(
          const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
    }
    if (errNo != Typ.OK) {
      rcResetAcrOdr();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcSstState80ReadDtl: errNo[$errNo]");
    }
    return errNo;
  }

  ///  関連tprxソース: rc_acracb.c - rcAcx_State_Read
  static Future<void> rcAcxStateRead(int number) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await RcAcracb.rcCheckAcrAcbNotAct() != 0) {
      return;
    }
    await RcExt.rcCinReadGetWait("rcAcxStateRead");

    int kind = AcxCom.ifAcbSelect();
    if ((kind & CoinChanger.ACB_200_X) != 0) {
      tsBuf.acx.order = AcxProcNo.ACB_STATE80.no;
    } else if ((kind & CoinChanger.ECS_X) != 0) {
      tsBuf.acx.order = AcxProcNo.ECS_STATE_READ.no;
    } else if ((kind & CoinChanger.SST1) != 0) {
      switch (number) {
        case 1:
          tsBuf.acx.order = AcxProcNo.SST_STATE01.no;
          break;
        case 80:
          tsBuf.acx.order = AcxProcNo.SST_STATE80.no;
          break;
        default:
          break;
      }
    }
    await RcAcx.rcAcxMain();
  }

  /// 機能：釣銭機設定変更機能
  /// 引数：char read_get_flg	:動作フラグ
  /// ：char *data_gp		:データグループ
  /// ：char *data		:データバッファのポインタ
  /// 戻値：エラー番号
  ///  関連tprxソース: rc_acracb.c - rcEcs_RAS_Setting_Dtl
  static Future<int> rcEcsRASSettingDtl(
      int readGetFlg, List<int> dataGp, List<String> data) async {
    int errNo = 0;
    String log = '';
    int i = 0;
    String callFunc = 'rcEcsRASSettingDtl';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await RcSysChk.rcCheckOutSider()) {
      return 0;
    }

    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) == 0) {
      return 0;
    }

    if (readGetFlg != 0) {
      log = "$callFunc:Set data_gp[${dataGp[0]}][${dataGp[1]}]\n";
    } else {
      log = "$callFunc:Read data_gp[${dataGp[0]}][${dataGp[1]}]\n";
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    errNo = await rcEcsRASSettingRead(
        readGetFlg, dataGp, data); /* OK or MSG_ACRLINEOFF */

    if (await RcAcracb.rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }

    if (errNo == OK) {
      log = "$callFunc: ResultGet\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      for (i = 0; i < RcAcrAcbDef.ECS_OPESET_CNT; i++) {
//			rc_WaitSaveTch();
        await RcIfEvent.rcWaitSave();

        if (tsBuf.acx.stat != 0) {
          errNo = await RcAcracb.rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }

        if (tsBuf.acx.order == AcxProcNo.ECS_RAS_SETTING_GET.no) {
          if (readGetFlg != 0) {
            errNo = await RcAcracb.rcAcrAcbResultGet(tsBuf.acx.devAck);
            if (errNo == IfAcxDef.MSG_ACRACT ||
                errNo == IfAcxDef.MSG_CHARGING) {
              errNo = OK;
            }
          } else {
            errNo = EcsVerr.ifEcsSettingReadGetExpansion(
                Tpraid.TPRAID_ACX, tsBuf.acx.devAck, data);
          }
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk(callFunc);
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }

        await Future.delayed(
            const Duration(milliseconds: RcAcrAcbDef.ECS_OPESET_WAIT));
      }
    }

    if (errNo != OK) {
      RcAcracb.rcResetAcrOdr();
      log = "$callFunc: err_no[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }

    return errNo;
  }

  /// 機能：釣銭機設定読込処理
  /// 引数：
  /// 戻値：エラー番号
  /// 関連tprxソース: rc_acracb.c - rcEcs_RAS_Setting_Read
  static Future<int> rcEcsRASSettingRead(int readGetFlg, List<int> dataGp,
      List<String> data) async {
    int errNo = 0;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    String callFunc = '';

    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */

    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      if (readGetFlg != 0) { //RAS設定する
        tsBuf.acx.order = AcxProcNo.ECS_RAS_SETTING_SET.no;
        errNo = await EcsOpes.ifEcsOpeSetExpansion(
            Tpraid.TPRAID_ACX, dataGp.cast<String>(), data);
      } else { //RAS設定を読み込む
        tsBuf.acx.order = AcxProcNo.ECS_RAS_SETTING_READ.no;
        errNo =
        await EcsVerr.ifEcsSettingReadExpansion(Tpraid.TPRAID_ACX, dataGp);
      }

      await RcAcx.rcAcxMain();

      if (errNo == OK) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        RcAcracb.rcResetAcrOdr();
      }
    } else {
      errNo = OK;
    }

    errNo = await RcAcracb.rcAcrAcbLineoffChk(errNo, 1);
    if (errNo != OK) {
      log = "$callFunc: err_no[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo; /* OK or MSG_ACRLINEOFF */
  }

  /// 回収時紙幣搬送先設定 : COINBILLのみ
  /// 関連tprxソース: rc_acracb.c - rcEcs_OpeSetGp2Dtl
  static Future<int> rcEcsOpeSetGp2Dtl(int positnFlg) async {
    int errNo = 0;
    String log = '';
    int i = 0;
    String callFunc = 'rcEcsOpeSetGp2Dtl';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return FALSE;
    }

    if (await RcAcracb.rcCheckAcrAcbON(1) != CoinChanger.ACR_COINBILL ||
        (AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
      return 0;
    }

    log = "$callFunc($positnFlg)\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    errNo = await rcEcsOpeSetGp2(positnFlg); /* OK or MSG_ACRLINEOFF */

    if (await RcAcracb.rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }

    if (errNo == OK) {
      log = "$callFunc: ResultGet\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      for (i = 0; i < RcAcrAcbDef.ECS_OPESET_CNT; i++) {
        await RcIfEvent.rcWaitSave();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_RESULT_GET.no) {
          errNo = await rcAcrAcbResultGet(tsBuf.acx.devAck);
          if (errNo == DlgConfirmMsgKind.MSG_ACRACT.dlgId ||
              errNo == DlgConfirmMsgKind.MSG_CHARGING.dlgId) {
            errNo = OK;
          }
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk(callFunc);
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        await Future.delayed(
            const Duration(milliseconds: RcAcrAcbDef.ECS_OPESET_WAIT));
      }
    }

    if (errNo != OK) {
      rcResetAcrOdr();
      log = "$callFunc: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo;
  }

  /// 関連tprxソース: rc_acracb.c - rcEcs_OpeSetGp2
  static Future<int> rcEcsOpeSetGp2(int positnFlg) async {
    int errNo;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcEcsOpeSetGp2';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return FALSE;
    }

    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */
    if (await rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
      tsBuf.acx.order = AcxProcNo.ECS_OPE_SET.no;
      if (positnFlg == 1) {
        //出金口に設定
        errNo = await AcxSsw.ifAcxSswSet(Tpraid.TPRAID_ACX, 0xf2);
      } else {
        //スペック設定に戻す
        errNo = await AcxSsw.ifAcxSswSet(Tpraid.TPRAID_ACX, 2);
      }
      if (errNo == OK) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        RcAcracb.rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      errNo = OK;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 1);
    if (errNo != OK) {
      log = "$callFunc: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo; /* OK or MSG_ACRLINEOFF */
  }

  /// 機能：釣銭機の硬貨をオーバーフロー庫へ収納できるか判定（あふれ検知）
  ///       以下を比較
  ///       OVERFLOW_STOCK_MAX:収納BOX容量枚数
  ///       move_cnt:回収しようとしている枚数(回収方法により異なる)
  ///                回収方法によっては、あらかじめOverFlow.move_cntを作成すること
  ///       オーバーフロー庫内金額(理論値)
  /// 引数： pick_type 回収方法
  /// 戻値： エラー番号
  /// 関連tprxソース: rc_acracb.c - rcAcrAcb_Auto_OverFlow_MoveMaxOverChk
  static Future<int> rcAcrAcbAutoOverFlowMoveMaxOverChk(int pickType) async {
    String log = '';
    int i = 0;
    int errNo = 0;
    List<int> moveCnt =
        List.generate(CoinBillKindList.CB_KIND_MAX.id, (_) => 0);
    int moveTtlCnt = 0;
    int stockTtlCnt = 0;
    String callFunc = 'rcAcrAcbAutoOverFlowMoveMaxOverChk';
    AcMem cMem = SystemFunc.readAcMem();

    errNo = await rcAcrAcbAutoOverFlowPriceRead(); //ファイル読込
    if (errNo != 0) {
      if (errNo == DlgConfirmMsgKind.MSG_OVERFLOW_TXT_NOTFOUND.dlgId) {
        //ファイルがない=オーバーフロー庫は空と扱う
        log = "$callFunc : MSG_OVERFLOW_TXT_NOTFOUND -> stock=0";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        errNo = 0;
        AcbMem().overflow_data = OverFlowData();
        AcbMem().overflow_data_no =
            await Counter.competitionGetPrintNo(await RcSysChk.getTid());
      } else {
        log = "$callFunc : errNo[$errNo] return";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return errNo;
      }
    }

    errNo = await RcAcracb.rcChkAcrAcbChkStock(0);
    if (errNo != 0) {
      log = "$callFunc : StockGet NG errNo[$errNo]";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      return errNo;
    }

    for (i = CoinBillKindList.CB_KIND_00500.id;
        i < CoinBillKindList.CB_KIND_MAX.id;
        i++) {
      moveCnt[i] = 0;
      CoinBillKindList id = CoinBillKindList.getDefine(i);
      switch (id) {
        case CoinBillKindList.CB_KIND_00500:
          if (pickType == OverFlowMoveType.OVERFLOW_TYPE_ALL.type) {
            moveCnt[i] = cMem.coinData.holder.coin500;
          } else {
            moveCnt[i] = RcKyAcxOverflowMove.overFlow.moveCnt.coin500;
          }
          break;
        case CoinBillKindList.CB_KIND_00100:
          if (pickType == OverFlowMoveType.OVERFLOW_TYPE_ALL.type) {
            moveCnt[i] = cMem.coinData.holder.coin100;
          } else {
            moveCnt[i] = RcKyAcxOverflowMove.overFlow.moveCnt.coin100;
          }
          break;
        case CoinBillKindList.CB_KIND_00050:
          if (pickType == OverFlowMoveType.OVERFLOW_TYPE_ALL.type) {
            moveCnt[i] = cMem.coinData.holder.coin50;
          } else {
            moveCnt[i] = RcKyAcxOverflowMove.overFlow.moveCnt.coin50;
          }
          break;
        case CoinBillKindList.CB_KIND_00010:
          if (pickType == OverFlowMoveType.OVERFLOW_TYPE_ALL.type) {
            moveCnt[i] = cMem.coinData.holder.coin10;
          } else {
            moveCnt[i] = RcKyAcxOverflowMove.overFlow.moveCnt.coin10;
          }
          break;
        case CoinBillKindList.CB_KIND_00005:
          if (pickType == OverFlowMoveType.OVERFLOW_TYPE_ALL.type) {
            moveCnt[i] = cMem.coinData.holder.coin5;
          } else {
            moveCnt[i] = RcKyAcxOverflowMove.overFlow.moveCnt.coin5;
          }
          break;
        case CoinBillKindList.CB_KIND_00001:
          if (pickType == OverFlowMoveType.OVERFLOW_TYPE_ALL.type) {
            moveCnt[i] = cMem.coinData.holder.coin1;
          } else {
            moveCnt[i] = RcKyAcxOverflowMove.overFlow.moveCnt.coin1;
          }
          break;
        default:
          break;
      }
      //stockTtlCnt += overflow_data.stock_count[i];
      stockTtlCnt += AcbMem().overflow_data.stock_count[i];
      moveTtlCnt += moveCnt[i];

      //オーバーフロー庫枚数＋移動枚数がオーバーフロー庫容量を越える
      if ((stockTtlCnt + moveTtlCnt) > OVERFLOW_STOCK_MAX) {
        errNo = DlgConfirmMsgKind.MSG_OVERFLOW_BOX_FULL.dlgId; //オーバーフロー庫あふれ
      }
    }

    //オーバーフロー庫情報ログ
    log = sprintf("%s(%i) : Box[%i]=[%3i, %3i, %3i, %3i, %3i, %3i]", [
      callFunc,
      pickType,
      stockTtlCnt,
      AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00500.id],
      AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00100.id],
      AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00050.id],
      AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00010.id],
      AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00005.id],
      AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00001.id]
    ]);
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    //移動枚数情報ログ
    log = sprintf("%s(%i) : Mov[%i]=[%3i, %3i, %3i, %3i, %3i, %3i]", [
      callFunc,
      pickType,
      moveTtlCnt,
      moveCnt[CoinBillKindList.CB_KIND_00500.id],
      moveCnt[CoinBillKindList.CB_KIND_00100.id],
      moveCnt[CoinBillKindList.CB_KIND_00050.id],
      moveCnt[CoinBillKindList.CB_KIND_00010.id],
      moveCnt[CoinBillKindList.CB_KIND_00005.id],
      moveCnt[CoinBillKindList.CB_KIND_00001.id]
    ]);
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    if (errNo != 0) {
      log =
          "$callFunc : ($stockTtlCnt + $moveTtlCnt) > $OVERFLOW_STOCK_MAX Max Over? errNo[$errNo]";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
    }
    return errNo;
  }

  /// acx_overpick_res.txtを読込、履歴からオーバーフロー庫内金額（理論値）を計算
  /// 関連tprxソース: rc_acracb.c - rcAcrAcb_Auto_OverFlow_PriceRead
  static Future<int> rcAcrAcbAutoOverFlowPriceRead() async {
    String log = '';
    String tmpBuf = '';
    File? fp;
    int ptr = 0;
    String ptr2 = '';
    int errNo = 0;
    String dateTime = '';
    int type = 0;
    int calcPrice = 0;
    int sumPrice0 = 0; //type=0の回収金
    int sumPrice1 = 0; //tyoe=1の回収金(理論値)
    int calcLineCnt = 0;
    int logLineCnt = 0; //ログ出力カウント
    List<int> lineCnt =
        List.generate(OverFlowLine.OVERFLOW_LINE_MAX.line, (_) => 0);
    List<int> calcCount =
        List.generate(CoinBillKindList.CB_KIND_MAX.id, (_) => 0);
    List<int> sumCount =
        List.generate(CoinBillKindList.CB_KIND_MAX.id, (_) => 0);
    int i = 0;
    String callFunc = 'rcAcrAcbAutoOverFlowPriceRead';

    if (AcbMem().overflow_data_no ==
        await Counter.competitionGetPrintNo(await RcSysChk.getTid())) {
      log =
          "$callFunc : Read Finished print_no[${AcbMem().overflow_data_no}] skip\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return 0;
    }

    fp = TprxPlatform.getFile(CoinChanger.ACX_OVERFLOW_MOV_PATH);

    if (!fp.existsSync()) {
      log = "$callFunc : fopen(${CoinChanger.ACX_OVERFLOW_MOV_PATH}) NG\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);

      AcbMem().overflow_data = OverFlowData();
      AcbMem().overflow_data_no = 0;

      return DlgConfirmMsgKind.MSG_OVERFLOW_TXT_NOTFOUND.dlgId;
    }

    while (fp.readAsLinesSync().isNotEmpty) {
      if (logLineCnt > 0 && (logLineCnt % 20 != 0)) {
        //ログスレッド化によるログ出力調整
        await Future.delayed(const Duration(milliseconds: 5000));
      }

      calcLineCnt++;
      if (tmpBuf.contains(CoinChanger.ACX_OVERFLOW_LINE_LABEL)) {
        lineCnt[OverFlowLine.OVERFLOW_LINE_ASTER.line] = calcLineCnt;
        continue;
      } else if (tmpBuf.contains(CoinChanger.ACX_OVERFLOW_TIME_LABEL)) {
        lineCnt[OverFlowLine.OVERFLOW_LINE_TIME.line] = calcLineCnt;
        ptr = tmpBuf.indexOf(CoinChanger.ACX_OVERFLOW_TIME_LABEL);
        ptr += CoinChanger.ACX_OVERFLOW_TIME_LABEL.length;
        ptr2 = ptr.toString().split(SEP_STR)[0];
        dateTime = ptr2;
        continue;
      } else if (tmpBuf.contains(CoinChanger.ACX_OVERFLOW_TYPE_LABEL)) {
        //type 0:実際の回収 1:理論値の回収
        lineCnt[OverFlowLine.OVERFLOW_LINE_TYPE.line] = calcLineCnt;
        ptr = tmpBuf.indexOf(CoinChanger.ACX_OVERFLOW_TYPE_LABEL);
        ptr += CoinChanger.ACX_OVERFLOW_TYPE_LABEL.length;
        type = ptr;
        continue;
      } else if (tmpBuf.contains(CoinChanger.ACX_OVERFLOW_CNT_LABEL)) {
        lineCnt[OverFlowLine.OVERFLOW_LINE_COUNT.line] = calcLineCnt;
        ptr = tmpBuf.indexOf(CoinChanger.ACX_OVERFLOW_CNT_LABEL);
        ptr += CoinChanger.ACX_OVERFLOW_CNT_LABEL.length;
        ptr2 = ptr.toString().split(",")[0];
        i = CoinBillKindList.CB_KIND_10000.id;
        calcCount[i] = int.tryParse(ptr2) ?? 0;

        for (i = 1; i < ptr.toString().split(",").length; i++) {
          ptr2 = ptr.toString().split(",")[i];

          if (ptr2.isNotEmpty) {
            if (i == CoinBillKindList.CB_KIND_MAX.id) {
              log = "$callFunc : i[$i] count over\n";
              TprLog()
                  .logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
              logLineCnt++;
              break;
            }
            calcCount[i] = int.tryParse(ptr2) ?? 0;
          }
        }

        for (i = CoinBillKindList.CB_KIND_10000.id;
            i < CoinBillKindList.CB_KIND_MAX.id;
            i++) {
          sumCount[i] += calcCount[i];
        }

        continue;
      } else if (tmpBuf.contains(CoinChanger.ACX_OVERFLOW_PRC_LABEL)) {
        //price 回収金額
        lineCnt[OverFlowLine.OVERFLOW_LINE_PRICE.line] = calcLineCnt;
        ptr = tmpBuf.indexOf(CoinChanger.ACX_OVERFLOW_PRC_LABEL);
        ptr += CoinChanger.ACX_OVERFLOW_PRC_LABEL.length;
        calcPrice = ptr;
        if (type == 1) {
          sumPrice1 += calcPrice;
        } else {
          sumPrice0 += calcPrice;
        }

        log = sprintf(
            "TEXT : time[%3i]=[%s] type[%3i]=[%i] count[%3i]=[%2i][%2i][%2i][%2i][%2i][%2i][%2i][%2i][%2i][%2i] price[%3i]=[%5ld]\n",
            [
              lineCnt[OverFlowLine.OVERFLOW_LINE_TIME.line],
              dateTime,
              lineCnt[OverFlowLine.OVERFLOW_LINE_TYPE.line],
              type,
              lineCnt[OverFlowLine.OVERFLOW_LINE_COUNT.line],
              calcCount[CoinBillKindList.CB_KIND_10000.id],
              calcCount[CoinBillKindList.CB_KIND_05000.id],
              calcCount[CoinBillKindList.CB_KIND_02000.id],
              calcCount[CoinBillKindList.CB_KIND_01000.id],
              calcCount[CoinBillKindList.CB_KIND_00500.id],
              calcCount[CoinBillKindList.CB_KIND_00100.id],
              calcCount[CoinBillKindList.CB_KIND_00050.id],
              calcCount[CoinBillKindList.CB_KIND_00010.id],
              calcCount[CoinBillKindList.CB_KIND_00005.id],
              calcCount[CoinBillKindList.CB_KIND_00001.id],
              lineCnt[OverFlowLine.OVERFLOW_LINE_PRICE.line],
              calcPrice
            ]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        logLineCnt++;
        continue;
      } else {
        log = "$callFunc : line[$calcLineCnt][$tmpBuf] default case\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
        logLineCnt++;
        continue;
      }
    }

    if (logLineCnt > 0 && logLineCnt % 20 != 0) {
      //ログスレッド化によるログ出力調整
      await Future.delayed(const Duration(milliseconds: 5000));
    }

    //OverFlowDataのセット
    AcbMem().overflow_data_no =
        await Counter.competitionGetPrintNo(await RcSysChk.getTid());
    AcbMem().overflow_data.type = type;
    AcbMem().overflow_data.stock_count = sumCount;
    AcbMem().overflow_data.stock_price = (sumPrice0 + sumPrice1);

    log = sprintf(
        "%s : SUM_DATA type[%i] count[%i][%i][%i][%i][%i][%i][%i][%i][%i][%i] price[%ld]\n",
        [
          callFunc,
          AcbMem().overflow_data.type,
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_10000.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_05000.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_02000.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_01000.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00500.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00100.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00050.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00010.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00005.id],
          AcbMem().overflow_data.stock_count[CoinBillKindList.CB_KIND_00001.id],
          AcbMem().overflow_data.stock_price
        ]);
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    return errNo;
    ;
  }

  /// 関連tprxソース: rc_acracb.c - rcAcrAcb_PickUp
  static Future<int> rcAcrAcbPickUp(PickData pickData) async {
    /* after call rcAcrAcb_ResultGet() */
    int errNo = 0;
    int type = 0;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcAcrAcbPickUp';
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return FALSE;
    }

    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */
    type = await rcCheckAcrAcbON(1);

    if (type != 0) {
      rcAcrAcbChgOutDataSet(AcxProcNo.ACX_PICKUP.no, 0, null, pickData);
      tsBuf.acx.order = AcxProcNo.ACX_PICKUP.no;
      errNo = await AcxPick.ifAcxPickup(Tpraid.TPRAID_ACX, type, pickData);
      if (errNo == OK) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      log = "$callFunc: rcCheck_AcrAcb_ON -> 0";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      errNo = OK;
    }

    errNo = await rcAcrAcbLineoffChk(errNo, 0);

    if (errNo != OK) {
      log = "$callFunc: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }

  /// 関連tprxソース: rc_acracb.c - rcSst_StockFlgClearDtl
  static Future<int> rcSstStockFlgClearDtl(int flg) async {
    int errNo = 0;
    String log = '';
    int i = 0;
    String callFunc = 'rcSstStockFlgClearDtl';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return FALSE;
    }

    errNo = await rcSstStockFlgClear(flg); /* OK or MSG_ACRLINEOFF */

    if (await RcAcracb.rcCheckAcrAcbON(1) == 0) {
      return DlgConfirmMsgKind.MSG_ACROFF.dlgId;
    }

    if (errNo == OK) {
      log = "$callFunc: ResultGet\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      for (i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
        await RcIfEvent.rcWaitSave();
        if (tsBuf.acx.stat != 0) {
          errNo = await rcAcrAcbLineoffChk(tsBuf.acx.stat, 0);
          tsBuf.acx.stat = 0;
          break;
        }
        if (tsBuf.acx.order == AcxProcNo.ACX_RESULT_GET.no) {
          errNo = await RcAcracb.rcAcrAcbResultGet(tsBuf.acx.devAck);
          break;
        } else {
          errNo = await rcAcrAcbResultOrderChk(callFunc);
          if (errNo != DlgConfirmMsgKind.MSG_ACX_TELEGRAGHERR.dlgId) {
            break;
          }
        }
        await Future.delayed(
            const Duration(milliseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
      }
    }

    if (errNo != OK) {
      RcAcracb.rcResetAcrOdr();
      log = "$callFunc: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
    return errNo;
  }

  /// 関連tprxソース: rc_acracb.c - rcSst_StockFlgClear
  static Future<int> rcSstStockFlgClear(int flg) async {
    int errNo = 0;
    int type = 0;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcSstStockFlgClear';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await rcCheckAcrAcbNotAct() != 0) {
      return FALSE;
    }

    cMem.stat.acrMode &= ~RcRegs.GET_MODE; /* Reset Answer Get Mode */
    type = await rcCheckAcrAcbON(1);

    if (type != 0) {
      tsBuf.acx.order = AcxProcNo.ACX_ANS_READ.no;
      errNo = await Sst1FClr.ifSst1FlgClear(Tpraid.TPRAID_ACX, flg);

      if (errNo == OK) {
        cMem.stat.acrMode |= RcRegs.GET_MODE;
      } else {
        rcResetAcrOdr();
      }
      await RcAcx.rcAcxMain();
    } else {
      log = "$callFunc: rcCheck_AcrAcb_ON -> 0";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      errNo = OK;
    }
    errNo = await rcAcrAcbLineoffChk(errNo, 0);
    if (errNo != OK) {
      log = "$callFunc: errNo[$errNo]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }

    return errNo; /* OK or MSG_ACRLINEOFF or MSG_ACRERROR */
  }
}

/// オーバーフロー庫各種情報(精査や移動)
/// 関連tprxソース: rc_acracb.c - OverFlow_Info
class OverFlowInfo {
  int reCalcPrice = 0; //精査金額合計
  CBillKind reCalcCnt = CBillKind(); //精査金種毎枚数
  int movePrc = 0; //オーバーフロー庫移動金額
  CBillKind moveCnt = CBillKind(); //オーバーフロー庫移動金種毎枚数
  List<int> spaceCount = List.generate(CoinBillKindList.CB_KIND_MAX.id, (_) => 0); //オーバーフロー庫内金種毎枚数(空き作成回収計算用)
  List<int> reCalcTtl = List.generate(CoinBillKindList.CB_KIND_MAX.id, (_) => 0); //金種毎精査された総枚数(オーバーフロー庫から釣銭機へ戻された枚数)
  List<int> moveTtl = List.generate(CoinBillKindList.CB_KIND_MAX.id, (_) => 0); //精査時に空き作成のためにオーバーフロー庫へ移動された金種毎総枚数
  int fullFlg = 0; //フルが発生(フル表示)
}

/// 関連tprxソース: rc_acracb.h - OverFlow_Move_Type
enum OverFlowMoveType {
  OVERFLOW_TYPE_MOVE(0), //ニアフル基準値-空き確保設定値の移動
  OVERFLOW_TYPE_ALL(1), //全回収
  OVERFLOW_TYPE_RESERV(2); //残置回収

  final int type;
  const OverFlowMoveType(this.type);
}

/// 関連tprxソース: rc_acracb.h - OverFlow_Line
enum OverFlowLine {
  OVERFLOW_LINE_ASTER(0),
  OVERFLOW_LINE_TIME(1),
  OVERFLOW_LINE_TYPE(2),
  OVERFLOW_LINE_COUNT(3),
  OVERFLOW_LINE_PRICE(4),
  OVERFLOW_LINE_MAX(5);

  final int line;
  const OverFlowLine(this.line);
}

/// 関連tprxソース: rc_acracb.h - CashRecycle_Type
enum CashRecycleType {
  CASH_RECYCLE_OUT_TYPE(0), //出金
  CASH_RECYCLE_IN_TYPE(1), //戻し入れ入金
  CASH_RECYCLE_CNCL_TYPE(2), //入金取消
  CASH_RECYCLE_PICK_TYPE(3), //回収
  CASH_RECYCLE_OVER_RETURN_TYPE(4), //超過分返金
  CASH_RECYCLE_END_TYPE(99); //閉じる

  final int type;
  const CashRecycleType(this.type);
}