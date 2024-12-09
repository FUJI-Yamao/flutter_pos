/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sprintf/sprintf.dart';

import '../../../clxos/calc_api_data.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/TmnEj_Make.dart';
import '../../lib/apllib/apllib_hqconnect.dart';
import '../../lib/apllib/apllib_other.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/apllib/sio_chk.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_th/if_th_csnddata.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/store_close/controller/c_store_close_page.dart';
import '../../ui/page/test/p_tmp_store_close_ut1.dart';
import '../../ui/page/test/test_page2/test_page_contorller/test_page_controller.dart';
import '../word/aa/l_rmstclsfcl.dart';
import '../../ui/page/register/controller/c_transaction_management.dart';
import '../word/aa/l_rmstopncls.dart';
import 'rmstclsfcl.dart';
import 'rmstcom.dart';
import 'rmstntt.dart';

///  関連tprxソース: rmstcls.c - enum STCLS_STAT
enum StclsStat {
  STCLS_IDLE,
  STCLS_MSGWAIT,
  STCLS_PROC1,
  STCLS_PROC2,
  STCLS_PROC3,
  STCLS_PROCCD,
  STCLS_PROC4,
  STCLS_PROC5,
  STCLS_PROC6,
  STCLS_PROCEXIT,
  STCLS_PRINT,
  STCLS_OPT1,
  STCLS_OPT2,
  STCLS_PROCNTT,
  STCLS_PROCNSC,
  STCLS_OPT3,
  STCLS_OPT4,      /* Suica */
  STCLS_OPT5,      /* Fcl */
  STCLS_OPT6,      /* OCX */
  STCLS_OPT7,      /* QP(FAP) */
  STCLS_OPT8,      /* Edy(FAP) */
  STCLS_OPT9,      /* iD(FAP) */
  STCLS_OPT10,     /* JET-A iD*/
  STCLS_OPT11,     /* JET-A QP*/
  STCLS_OPT12,     /* JET-A Crdt*/
  STCLS_OPT13,     /* QP(UT1)*/
  STCLS_OPT14,     /* iD(UT1)*/
  STCLS_OPT15,     /* J-Mups */
  STCLS_OPT15_2,   /* J-Mups(売上報告) */
  STCLS_OPT16,     /* Suica(FRM)*/
  STCLS_OPT17,     /* PiTaPa(FRM)*/
  STCLS_OPT18,     /* FRM*/
  STCLS_OPT19,     /* MST */
  STCLS_OPT20,     /* JET-A nanaco */
  STCLS_OPT21,     /* JET-A Edy */
  STCLS_OPT22,     /* JET-A 交通系IC */
  STCLS_OPT26,     /* dポイント バッチ連携処理 */
  STCLS_OPT27,     /* Edy(VEGA) */
  STCLS_OPT28,     /* JET-B CT-5100 */
  STCLS_PROC_STERA_CRDT,	// Stera クレジット合計データ取得
  STCLS_PROC_STERA_NFC,	// Stera クレジット合計データ取得
  STCLS_PROC_STERA_ID,	// Stera iD合計データ取得
  STCLS_PROC_STERA_IC,	// Stera 交通系IC合計データ取得
  STCLS_MAIL_SENDER,     	/* 電子メール */
  STCLS_NET_RECEIPT,		/* 電子レシート */
  STRCLS_STAT_MAX,
}
/// 閉設プロセスの状況.
enum CloseEndStatus{
  NONE,
  GOING,
  NORMAL_END, // 通常
  ABNORMAL, // 異常
  CANCEL,

}
class Rmstcls {
  static StclsStat fStat = StclsStat.STCLS_IDLE;
  static List<String> printDataQP = List.filled(3, '');
  static List<String> printDataID = List.filled(3, '');
  static List<String> printDataEdy = List.filled(3, '');
  static int opt7Flg = 0;
  static CloseEndStatus opt7Status = CloseEndStatus.NONE;

  // TODO:10131 日計UI 突貫対応(UIを正式対応する際に正式対応する) 日計処理自体が終わることを確認するフラグ
  static bool opt7End = false;

  static int opt9Flg = 0;
  static CloseEndStatus opt9Status = CloseEndStatus.NONE;

  // TODO:10131 日計UI 突貫対応(UIを正式対応する際に正式対応する) 日計処理自体が終わることを確認するフラグ
  static bool opt9End = false;

  static int retryCnt = 0;

  static int opt13Flg = 0;
  static int opt14Flg = 0;
  static int opt15Flg = 0;

  /* JMUPS, Verifone日計処理 */
  static int opt15Flg2 = 0;

  /* JMUPS, Verifone売上送信 */
  static int jmupsRes = 0;

  /* JMUPS, Verifoneレスポンスタイプ */
  static int opt16Flg = 0;
  static int opt17Flg = 0;
  static int opt18Flg = 0;
  static int opt19Flg = 0;
  static int opt27Flg = 0;

  /* VEGA Edy */

  static int reCalSend = 0;

  /* 閉設ステータス */
  static int fCloseFlg = 0;
  static int STAT_24H = 0;
  static String eventPass = '';
  static String skipPass = '';
  static int btnAct = 0;
  static int actBtnFlg = 0; //実行ボタン押下フラグ

  static const CLSSTAT_BACKEND = 0x01;
  static const CLSSTAT_SEND = 0x02;
  static const CLSSTAT_BACKUP = 0x04;
  static const CLSSTAT_VACCUM = 0x08;
  static const SHUTDOWN = 1;

  static ProcStat procStat = ProcStat();

  ///  関連tprxソース: rmstcls.c - rmStoreCloseDrawMain()
  static int rmStoreCloseDrawMain() {
    fStat = StclsStat.STCLS_IDLE;
    opt7Flg = 0;
    opt7Status = CloseEndStatus.NONE;
    opt9Flg = 0;
    opt9Status = CloseEndStatus.NONE;
    retryCnt = 0;

    opt13Flg = 0;
    opt14Flg = 0;
    opt15Flg = 0; /* JMUPS, Verifone日計処理 */
    opt15Flg2 = 0; /* JMUPS, Verifone売上送信 */
    jmupsRes = 0; /* JMUPS, Verifoneレスポンスタイプ */
    opt16Flg = 0;
    opt17Flg = 0;
    opt18Flg = 0;
    opt19Flg = 0;
    opt27Flg = 0;

    printDataQP = List.filled(3, '');
    printDataID = List.filled(3, '');
    printDataEdy = List.filled(3, '');
    return 0;
  }

  ///  関連tprxソース: rmstcls.c - multi_vega_enable()
  static Future<int> multiVegaEnable(FclService bland) async {
    if ((await CmCksys.cmMultiVegaTid(Tpraid.TPRAID_STR, bland) !=
        bland.value)) {
      return 0;
    }
    return 1;
  }

  ///  QP日計処理
  ///  関連tprxソース: rmstcls.c - ExecProcOpt7()
  static Future<int> execProcOpt7() async {
    Rmstcom.rmstTimerRemove();

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "execProcOpt7:QP Daily Start");

    _setOptStatus(0, CloseEndStatus.GOING);

    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.ITEM_FAP_QP_TXT.val, 4);
    if ((await CmCksys.cmUt1QUICPaySystem()) != 0 ||
        await multiVegaEnable(FclService.FCL_QP) != 0) {
      fStat = StclsStat.STCLS_OPT13;
      await Rmstntt.execProcCloseUt1(0);
      return 0;
    }

    fStat = StclsStat.STCLS_OPT7;

    // gtk_entry_set_text(GTK_ENTRY(entrystopt7),ENTRY_TXT_GOING );
    Rmstclsfcl().stclsFclInfo.sKind = FclService.FCL_QP;
    Rmstclsfcl().stclsFclProc();
    return 0;
  }

  ///  iD日計処理
  ///  関連tprxソース: rmstcls.c - ExecProcOpt9()
  static Future<int> execProcOpt9() async {
    Rmstcom.rmstTimerRemove();

    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "ExecProcOpt9:iD Daily Start");
    _setOptStatus(1, CloseEndStatus.GOING);
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.ITEM_FAP_ID_TXT1.val, 4);
    if ((await CmCksys.cmUt1IDSystem()) != 0 ||
        await multiVegaEnable(FclService.FCL_ID) != 0) {
      fStat = StclsStat.STCLS_OPT14;
      await Rmstntt.execProcCloseUt1(1);
      return 0;
    }

    fStat = StclsStat.STCLS_OPT7;
    // TODO:10131 日計UI 処理中の表示.

    // gtk_entry_set_text(GTK_ENTRY(entrystopt7),ENTRY_TXT_GOING );
    Rmstclsfcl().stclsFclInfo.sKind = FclService.FCL_ID;
    Rmstclsfcl().stclsFclProc();
    return 0;
  }

  static int execProcOpt7End() {
    String cmdName;
    String msg;
    String msg2;

    Rmstcom.rmstTimerRemove();
    Rmstcom.ejData = CharData();
    Rmstcom.ejData.str1 = LRmstopncls.PROC_EDY_RSLT.val;
    Rmstcom.ejData.posi1 = 6;

    if (Rmstclsfcl().stclsFclInfo.dailyRes == 1) {
      /* 正常終了 */
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "ExecProcOpt7End:FCL QP Daily OK");
      // gtk_entry_set_text(GTK_ENTRY(entrystopt7), ENTRY_NORMAL);
      Rmstcom.ejData.str1 = LRmstopncls.ENTRY_NORMAL.val;
      //Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
      execProc2EndNextProc();

      return 0;
    } else {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "ExecProcOpt7End:FCL QP Daily NG");
      Rmstcom.ejData.str2 = LRmstopncls.ENTRY_ABNORMAL.val;
      //Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
      // Rmstclsfcl.stclsFclGetCmdMsg( &cmd_name[0], sizeof(cmd_name),stcls_fcl_info.order );
      // Rmstclsfcl.stclsFclGetMsg(msg);
      // Rmstcom.rmstEjTxtMakeNew2(cmdName, 6);
      // Rmstcom.rmstEjTxtMakeNew2(msg, 6);
      // sprintf( print_data_qp[0], "  %s", cmd_name );
      // sprintf( print_data_qp[1], "  %s", msg );
      // sprintf(msg2, "%s\n%s", cmd_name, msg );
      // rmstMsgDisp3(TPRDLG_PT11,ExecProcOpt5Retry, BTN_RETRY, ExecProcOpt5Skip, BTN_FORCE, FCL_QP_TITLE, 0, msg2);
    }

    return 0;
  }

  static int execProcOpt9End() {
    String cmdName;
    String msg;
    String msg2;

    Rmstcom.rmstTimerRemove();
    Rmstcom.ejData = CharData();
    Rmstcom.ejData.str1 = LRmstopncls.PROC_EDY_RSLT.val;
    Rmstcom.ejData.posi1 = 6;

    if (Rmstclsfcl().stclsFclInfo.dailyRes == 1) {
      /* 正常終了 */
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "ExecProcOpt7End:FCL iD Daily OK");
      // gtk_entry_set_text(GTK_ENTRY(entrystopt7), ENTRY_NORMAL);
      Rmstcom.ejData.str1 = LRmstopncls.ENTRY_NORMAL.val;
      //Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
      execProc2EndNextProc();
      return 0;
    } else {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "ExecProcOpt7End:FCL iD Daily NG");
      Rmstcom.ejData.str2 = LRmstopncls.ENTRY_ABNORMAL.val;
      //Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
      // Rmstclsfcl.stclsFclGetCmdMsg( &cmd_name[0], sizeof(cmd_name),stcls_fcl_info.order );
      // Rmstclsfcl.stclsFclGetMsg(msg);
      // Rmstcom.rmstEjTxtMakeNew2(cmdName, 6);
      // Rmstcom.rmstEjTxtMakeNew2(msg, 6);
      // sprintf( print_data_qp[0], "  %s", cmd_name );
      // sprintf( print_data_qp[1], "  %s", msg );
      // sprintf(msg2, "%s\n%s", cmd_name, msg );
      // rmstMsgDisp3(TPRDLG_PT11,ExecProcOpt5Retry, BTN_RETRY, ExecProcOpt5Skip, BTN_FORCE, FCL_QP_TITLE, 0, msg2);
    }

    return 0;
  }

  ///  関連tprxソース: rmstcls.c - ExecProc2EndNextProc()
  static Future<int> execProc2EndNextProc() async {
    Rmstcom.rmstTimerRemove();

    if (((await CmCksys.cmFclQUICPaySystem() != 0) &&
        (SioChk.sioCheck(Sio.SIO_FCL) == Typ.YES)) && (opt7Flg == 0)) {
      opt7Flg = 1;
      retryCnt = 0;
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProcOpt7);
      return 0;
    }

    if (((await CmCksys.cmFclIDSystem() != 0) &&
        (SioChk.sioCheck(Sio.SIO_FCL) == Typ.YES)) && (opt9Flg == 0)) {
      opt9Flg = 1;
      retryCnt = 0;
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProcOpt9);
      return 0;
    }

    // 残りの部分はまだ未実装、理由は：
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  ///  関連tprxソース: rmstcls.c - ExecPrintUt1End()
  ///  関数：int ExecPrintNTTEnd(void)
  ///  機能：NTTクレジット印字終了処理
  ///  引数：なし
  ///  戻値：0:終了
  static Future<int> execPrintUt1End() async {
    String msg = '';
    String title = '';

    // Rmstcom.rmstTimerRemove();
    // Rmstcom.ejData = CharData();
    // Rmstcom.ejData.str1 = LRmstopncls.PROC_EDY_RSLT.val
    // Rmstcom.ejData.posi1 = 6;
    var result = await Rmstntt.closeUt1ResultChk();

    if (result.brand == 0) {
      /* QP */
      if (result.msg.isNotEmpty) {
        printDataQP[0] = "   ".substring(0, 3);
        printDataQP[0] += result.msg.substring(0, result.msg.length);
      }
      title = LRmstopncls.FCL_QP_TITLE.val;
    }
    else if (result.brand == 2) {
      /* Edy */
      if (result.msg.isNotEmpty) {
        printDataEdy[0] = "   ".substring(0, 3);
        printDataEdy[0] += result.msg.substring(0, result.msg.length);
      }
      title = LRmstopncls.VEGA_EDY_TITLE.val;
    }
    else {
      /* iD */
      if (result.msg.isNotEmpty) {
        printDataID[0] = "   ".substring(0, 3);
        printDataID[0] += result.msg.substring(0, result.msg.length);
      }
      title = LRmstopncls.FCL_ID_TITLE1.val;
    }

    if (result.err == 0) {
      // Rmstcom.ejData.str2 = LRmstopncls.ENTRY_NORMAL;
      // Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execBeforeProc2);

      _setOptStatus(result.brand, CloseEndStatus.NORMAL_END);
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
          "ExecPrintUt1End Normal End");
      return 0;
    }
    else {
      if (result.rst == 1) {
        _setOptStatus(result.brand, CloseEndStatus.ABNORMAL);

        // Rmstcom.ejData.str2 = ;
      }
      else {
        _setOptStatus(result.brand, CloseEndStatus.CANCEL);

        // Rmstcom.ejData.str2 = LRmstopncls.CANCEL;
      }
      // Rmstcom.rmstEjTxtMakeNew(Rmstcom.ejData);
    }
    //msg = "${result.msg}\n";
    //Rmstcom.rmstMsgNum = err;

    if (Rmstcls.storecloseflg == true) {
      StoreClosePageController ctrl = Get.find();
      if (ctrl.isTaskCanceled) {
        return 0;
      }
      await TmnEjMake.ut1ErrDialog(
          result.err,
          MsgDialogType.error,
          LTprDlg.BTN_RETRY,
          LTprDlg.BTN_FORCE,
          result.msg);
      if (TmnEjMake.buttonConfirm == false) {
        await execProcOpt5Skip();
      }
    } else {
      TmnEjMake.utMsgDisp(
          result.err,
          MsgDialogType.error,
          execProcOpt5Retry,
          LTprDlg.BTN_RETRY,
          execProcOpt5Skip,
          LTprDlg.BTN_FORCE,
          result.msg);
    }

    return 0;
  }

  /// 関数：rmstcls_execprint_vesca_end(void)
  /// 機能：ベスカ決済端末の日計明細の印字終了処理
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース: rmstcls.c -  rmstcls_execprint_vesca_end
  static int rmstclsExecprintVescaEnd() {
    /// TODO:10121 QUICPay、iD 202404実装対象外
    // char  log[128];

    // rmstTimerRemove();

    // snprintf(log, sizeof(log), "%s : start\n", __FUNCTION__);
    // TprLibLogWrite(TPRAID_STR, TPRLOG_NORMAL, 0, log);

    // ntt_print_flg = 0;
    // ExecProc2EndNextProc();

    return 0;
  }

  /// ステータスをセットする.
  static Future<void> _setOptStatus(int brand, CloseEndStatus status) async {
    if (brand == 0) {
      opt7Status = status;
    } else if (brand == 1) {
      opt9Status = status;
    }
  }

  /// 関連tprxソース: rmstcls.c - ExecBefore_Proc2
  static Future<int> execBeforeProc2() async {

    Rmstcom.rmstTimerRemove();
    if (((await CmCksys.cmUt1QUICPaySystem() != 0) ||
        (await multiVegaEnable(FclService.FCL_QP) != 0)) &&
        (opt13Flg == 0)) {
      fStat = StclsStat.STCLS_OPT13;
      opt13Flg = 1;
      retryCnt = 0;
      // gtk_entry_set_text(GTK_ENTRY(entrystopt7), ENTRY_TXT_GOING);
      if (!storecloseflg) {
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProcOpt7);
      }
    } else if ((await multiVegaEnable(FclService.FCL_EDY) != 0) &&
        (opt27Flg == 0)) {
      fStat = StclsStat.STCLS_OPT27;
      opt27Flg = 1;
      retryCnt = 0;
      // gtk_entry_set_text(GTK_ENTRY(entrystopt8), ENTRY_TXT_GOING);
      if (opt13Flg == 1) {
        // TODO:00013 三浦
        // Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProcSleep8);
      } else {
        // TODO:00013 三浦
        // Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProcOpt8);
      }
    } else if (((await CmCksys.cmUt1IDSystem() != 0) ||
        (await multiVegaEnable(FclService.FCL_ID) != 0)) &&
        (opt14Flg == 0)) {
      fStat = StclsStat.STCLS_OPT14;
      opt14Flg = 1;
      retryCnt = 0;
      // gtk_entry_set_text(GTK_ENTRY(entrystopt9), ENTRY_TXT_GOING);
      if ((opt13Flg == 1) ||
          ((await CmCksys.cmMultiVegaSystem() != 0) && (opt27Flg == 1))) {
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProcSleep);
      } else {
        Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProcOpt9);
      }
    } else {
      /* 閉店処理２へ */
      fStat = StclsStat.STCLS_PROC2;
      // gtk_entry_set_text(GTK_ENTRY(entrystcls2), ENTRY_TXT_GOING);
      // TODO:00013 三浦
      // Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProc2);
    }

    return 0;
  }

  /// Format : int ExecProcOpt5Skip(void)
  /// Title  : Skip ExecProcOpt5
  /// Input  : void
  /// Output : 0
  /// 関連tprxソース: rmstcls.c - ExecProcOpt5Skip
  static Future<int> execProcOpt5Skip() async {
    String log = '';
    String callFunc = 'execProcOpt5Skip';
    StclsFclInfo stclsFclInfo = StclsFclInfo();

    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear(callFunc);

    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.FORCE_CLOSE.val, 20);

    switch (fStat) {
      case StclsStat.STCLS_OPT5:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(SPVT) !");
        // gtk_entry_set_text(GTK_ENTRY(entrystopt5), ENTRY_ABNORMAL);
        break;
      case StclsStat.STCLS_OPT7:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(QP) !");
        opt7Status = CloseEndStatus.ABNORMAL;
        opt7End = true;
        break;
      case StclsStat.STCLS_OPT8:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(Edy) !");
        // gtk_entry_set_text(GTK_ENTRY(entrystopt8), ENTRY_ABNORMAL);
        if ((stclsFclInfo.rest == FclsDailyResult.DAILY_OK.value) ||
            (stclsFclInfo.rest == FclsDailyResult.FSAVEERROR.value)) {
          // TODO:00013 三浦 Edyは実装しない
          // stclsFclInfo.rest = fcl_edy_filemake();
        }
        // TODO:00013 三浦
        //ExecProcOpt8DateMake();
        break;
      case StclsStat.STCLS_OPT9:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(iD) !");
        opt9Status = CloseEndStatus.ABNORMAL;
        opt9End = true;
        break;
      case StclsStat.STCLS_OPT13:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(QP) !");
        opt7End = true;
        await execBeforeProc2();
        return 0;
      case StclsStat.STCLS_OPT14:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(iD) !");
        opt9End = true;
        await execBeforeProc2();
        return 0;
      case StclsStat.STCLS_OPT16:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(Suica) !");
        // gtk_entry_set_text(GTK_ENTRY(entrystopt16), ENTRY_ABNORMAL);
        // TODO:00013 三浦
        // rmPfm_ArmObs_cnt();
        // ExecProcOpt16DateMake();
        break;
      case StclsStat.STCLS_OPT17:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(PiTaPa) !");
        // gtk_entry_set_text(GTK_ENTRY(entrystopt17), ENTRY_ABNORMAL);
        break;
      case StclsStat.STCLS_OPT18:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(PFM) !");
        // gtk_entry_set_text(GTK_ENTRY(entrystopt18), ENTRY_ABNORMAL);
        break;
      case StclsStat.STCLS_OPT27:
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
            "ProcOpt5Skip : Force End(Edy) !");
        await execBeforeProc2();
        return 0;
      default:
        log = sprintf(
            "fStat error [%i][%i]\n", [fStat, stclsFclInfo.sKind.value]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        break;
    }

    fStat = StclsStat.STCLS_PROC3;
    await execProc2EndNextProc();

    return 0;
  }

  /// Title  : Retry ExecProcOpt5
  /// Input  : void
  /// Output : 0
  /// 関連tprxソース: rmstcls.c - ExecProcOpt5Retry
  static Future<int> execProcOpt5Retry() async {
    String log = '';
    String callFunc = 'execProcOpt5Retry';
    StclsFclInfo stclsFclInfo = StclsFclInfo();

    Rmstcom.rmstTimerRemove();
    Rmstcom.rmstMsgClear(callFunc);

    retryCnt++;
    Rmstcom.rmstEjTxtMakeNew2(LRmstopncls.PROC5_RETRY.val, 20);

    switch (fStat) {
      case StclsStat.STCLS_OPT5:
        log = sprintf("ProcOpt5Retry:SPVT[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // TODO:00013 三浦 QP、iD日計対応対象外
        // Rmstcom.rmstTimerAdd(1000, ExecProcOpt5);
        return 0;
      case StclsStat.STCLS_OPT7:
        log = sprintf("ProcOpt5Retry:QP[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        Rmstcom.rmstTimerAdd(1000, execProcOpt7);
        return 0;
      case StclsStat.STCLS_OPT8:
        log = sprintf("ProcOpt5Retry:Edy[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // TODO:00013 三浦 QP、iD日計対応対象外
        // Rmstcom.rmstTimerAdd(1000, execProcOpt8);
        return 0;
      case StclsStat.STCLS_OPT9:
        log = sprintf("ProcOpt5Retry:iD[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        Rmstcom.rmstTimerAdd(1000, execProcOpt9);
        return 0;
      case StclsStat.STCLS_OPT13:
        log = sprintf("ProcOpt5Retry:QP[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // gtk_entry_set_text(GTK_ENTRY(entrystopt7),ENTRY_TXT_GOING );
        Rmstcom.rmstTimerAdd(1000, execProcOpt7);
        return 0;
      case StclsStat.STCLS_OPT14:
        log = sprintf("ProcOpt5Retry:iD[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // gtk_entry_set_text(GTK_ENTRY(entrystopt9),ENTRY_TXT_GOING );
        Rmstcom.rmstTimerAdd(1000, execProcOpt9);
        return 0;
      case StclsStat.STCLS_OPT16:
        log = sprintf("ProcOpt5Retry:Suica Daily[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // gtk_entry_set_text(GTK_ENTRY(entrystopt16), ENTRY_DONE );
        // TODO:00013 三浦 QP、iD日計対応対象外
        // rmstTimerAdd2(NEXT_GO_TIME, (GtkFunction)ExecProcOptProc, (gpointer)0);
        return 0;
      case StclsStat.STCLS_OPT17:
        log = sprintf("ProcOpt5Retry:PiTaPa Daily[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // gtk_entry_set_text(GTK_ENTRY(entrystopt17), ENTRY_DONE );
        // TODO:00013 三浦 QP、iD日計対応対象外
        // rmstTimerAdd2(NEXT_GO_TIME, (GtkFunction)ExecProcOptProc,  (gpointer)1);
        return 0;
      case StclsStat.STCLS_OPT18:
        log = sprintf("ProcOpt5Retry:PFM Daily[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // gtk_entry_set_text(GTK_ENTRY(entrystopt18),ENTRY_TXT_GOING );
        // TODO:00013 三浦 QP、iD日計対応対象外
        // rmstTimerAdd2(NEXT_GO_TIME, (GtkFunction)ExecProcOptProc,  (gpointer)2);
        return 0;
      case StclsStat.STCLS_OPT27:
        log = sprintf("ProcOpt5Retry:EDY[%i]", [retryCnt]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        // gtk_entry_set_text(GTK_ENTRY(entrystopt8),ENTRY_TXT_GOING );
        // TODO:00013 三浦 QP、iD日計対応対象外
        // Rmstcom.rmstTimerAdd(1000, execProcOpt8);
        return 0;
      default:
        log = sprintf(
            "fStat error [%i][%i]\n", [fStat.index, stclsFclInfo.sKind.value]);
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        break;
    }

    fStat = StclsStat.STCLS_PROC3;
    await execProc2EndNextProc();

    return 0;
  }

  // 閉設画面か
  static bool storecloseflg = false;

  /// 関連tprxソース: rmstcls.c - ExecProcSleep
  static Future<int> execProcSleep() async {
    String tmpBuf = '';
    int waitSec = 10;
    String callFunc = 'execProcSleep';

    Rmstcom.rmstTimerRemove();

    // TODO:00013 三浦
    late Mac_infoJsonFile macInfoJson;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      macInfoJson = Mac_infoJsonFile();
      await macInfoJson.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      macInfoJson = pCom.iniMacInfo;
    }
    JsonRet jsonRet = await macInfoJson.getValueWithName("other", "ut1_wait");
    if (jsonRet.result == true) {
      waitSec = int.tryParse(tmpBuf) ?? 0;
    }

    if (waitSec > 0) {
      tmpBuf = sprintf("%s : UT1 iD Wait[%i]", [callFunc, waitSec]);
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, tmpBuf);
      await Future.delayed(Duration(seconds: waitSec));
    }

    if (!storecloseflg) {
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProcOpt9);
    }

    return 0;
  }

  /// 機能：ポップアップのいいえボタン処理
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstcls.c - NoBtnProc
  static Future<int> noBtnProc() async {
    Rmstcom.rmstTimerRemove();
    String callFunc = 'noBtnProc';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (fStat == StclsStat.STCLS_IDLE) {
      STAT_24H = 0;
    }

    if (CmCksys.cmMmType() == CmSys.MacM1 && fStat != StclsStat.STCLS_IDLE) {
      fStat = StclsStat.STCLS_PROC2;
    }

    if (CmCksys.cmMmType() != CmSys.MacERR) {
      execProcDbClose();
    }

//中断時再集計実績バックアップデータを削除
    if (reCalSend & 0x10 != 0) {
      await reCalTranDel(0);
      reCalSend = 0;
    }

    Rmstcom.rmstMsgClear(callFunc);
    if (chkAutoCls() != 0) {
      // TODO:10152 履歴ログ chkAutoCls()が0を返すので通らない 実装後回し
      // Stop_Wind_Show_Again();
      pCom.qsAtFlg = 0;
    }
    // gtk_grab_add( winstcls );

    // TODO:10152 履歴ログ 実装不要？
    // if (AutoRunTime_Label_End != NULL) {
    //   gtk_widget_show(AutoRunTime_Label_End);
    // }

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "No Bottun Proc end !");
    return 0;
  }

  /// 機能：データベース開放処理
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstcls.c - ExecProcDbClose
  static int execProcDbClose() {
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "ExecProcDbClose Start!!");
    // if(rm_srx_con != NULL) {
    // db_PQfinish(TPRAID_STR, rm_srx_con);
    // rm_srx_con = NULL;
    // }
    // if(rm_sub_con != NULL) {
    // db_PQfinish(TPRAID_STR, rm_sub_con);
    // rm_sub_con = NULL;
    // }
    // if(rm_tpr_con != NULL) {
    // db_PQfinish(TPRAID_STR, rm_tpr_con);
    // rm_tpr_con = NULL;
    // }
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "ExecProcDbClose End!!");
    return 0;
  }

  /// 実績再集計バックアップファイル削除
  /// 0:自レジ本日営業日バックアップデータを削除
  /// 関連tprxソース: rmstcls.c - RecalTran_Del
  static Future<void> reCalTranDel(int typ) async {
    String fName = '';
    String lDate = '';
    String buf = '';
    String bkDir = '';
    Directory dir;
    String name = '';
    String cmd = '';
    String log = '';
    int ret = 0;
    String callFunc = 'reCalTranDel';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "RecalTran_Del : Get RXMEM_COMMON Error!!");
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (CmCksys.cmMmType() == CmSys.MacMOnly ||
        CmCksys.cmMmType() == CmSys.MacERR) {
      return;
    }

    if (typ == 0) {
      //本日営業日データ削除
      fName = sprintf("%sTran_%09i_%09i_%06i_%s*", [
        AplLib.RECAL_TRAN_DIR,
        cBuf.dbRegCtrl.compCd,
        cBuf.dbRegCtrl.streCd,
        cBuf.dbRegCtrl.macNo,
        Rmstcom.saleDate
      ]);
      cmd = "rm -f $fName";
      AplLibOther.systemCmdChk(Tpraid.TPRAID_STR, cmd);
      reCalTranFtpExec(AplLib.RXFTP_MDEL, null);
      log = "$callFunc: Delete Today Local[$fName]";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
      return;
    }

//前回営業日から2日前のデータを削除
    bkDir = sprintf(
        "Tran_%09i_%09i_", [cBuf.dbRegCtrl.compCd, cBuf.dbRegCtrl.streCd]);
    CompetitionIniRet ciret = await CompetitionIni.competitionIniGet(
        Tpraid.TPRAID_STR,
        CompetitionIniLists.COMPETITION_INI_LAST_SALE_DATE,
        CompetitionIniType.COMPETITION_INI_GETSYS);
    lDate = ciret.value;

    if (lDate.compareTo("0000-00-00") == 0) {
      //初回閉設の場合はデータ削除しない
      return;
    }

    dir = TprxPlatform.getDirectory(AplLib.RECAL_TRAN_DIR);

    if (!dir.existsSync()) {
      log = "$callFunc: opendir Error[${AplLib.RECAL_TRAN_DIR}]";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
      return;
    }

    var (int error, String bKbuf) = await DateUtil.dateTimeChange(
        lDate,
        DateTimeChangeType.DATE_TIME_CHANGE,
        DateTimeFormatKind.FT_YYYYMMDD,
        DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
    buf = bKbuf;

    // TODO:10152 履歴ログ 重めなので一旦後回し
    // datetime_datecalc(buf, ldate, -1);
    log = "$callFunc: delete data before [$lDate]";
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);

    List<FileSystemEntity> lists = dir.listSync();
    for (var list in lists) {
      name = list.path;
      // TODO:10152 履歴ログ 条件式確認
      if (name.substring(0, 5).compareTo("Tran_") == 0 &&
          name.substring(0, lDate.length).compareTo(lDate) != 0) {
        cmd = "rm -rf ${AplLib.RECAL_TRAN_DIR}$name*";
        ret = AplLibOther.systemCmdChk(Tpraid.TPRAID_STR, cmd);
        log = "$callFunc: Delete [${AplLib.RECAL_TRAN_DIR}$name]";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
      }
    }
  }

  //M、BSへ自レジ実績再集計バックアップの送信or削除
  /// 関連tprxソース: rmstcls.c - RecalTran_FtpExec
  static int reCalTranFtpExec(int typ, int? result) {
    int idx = 0;
    int ret = 0;
    String fName = '';
    String mfName = '';
    int start = 0;
    int end = 0;
    String cmd = '';
    String iniFile = '';
    String host = '';
    String log = '';
    String server = '';
    String ftpTyp = '';
    int existChk = 0;
    int resFlg = Rmstcom.RMST_OK;
    String callFunc = 'reCalTranFtpExec';
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "RecalTran_FtpExec : Get RXMEM_COMMON Error!!");
      return Rmstcom.RMST_NG;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (CmCksys.cmMmType() == CmSys.MacMOnly ||
        CmCksys.cmMmType() == CmSys.MacERR) {
      return Rmstcom.RMST_OK;
    }

    if (typ == AplLib.RXFTP_MPUT3) {
      ftpTyp = "${ftpTyp}MPUT";
    } else {
      existChk = 1;
      ftpTyp = "${ftpTyp}MDEL";
    }

    iniFile = "${IfThCSenddata.SysHomeDirp}/conf/sys_param.ini";
    start = 0;
    end = 2;
    if (CmCksys.cmMmType() == CmSys.MacM1) { //BSレジへ送信
      start = 1;
    } else if (CmCksys.cmMmType() == CmSys.MacM2) { //Mレジへ送信
      end = 1;
    }

    fName = sprintf("%s/Tran_%09i_%09i_%06i_%s.zip", [
      AplLib.RECAL_TRAN_DIR,
      cBuf.dbRegCtrl.compCd,
      cBuf.dbRegCtrl.streCd,
      cBuf.dbRegCtrl.macNo,
      Rmstcom.saleDate
    ]);
    mfName = "$fName*";
    for (idx = start; idx < end; idx ++) {
      if (idx == 0) { //Mレジへ送信
        server = "master";
        // TODO:10152 履歴ログ 重めなので一旦後回し
        // ret = rxFtpOpen(ini_file, "master", host, RECAL_TRAN_DIR, RECAL_TRAN_DIR, 0, NULL, NULL, cmd, NULL);
        ret = AplLib.RXFTP_OK;
      } else {
        server = "submaster";
        // TODO:10152 履歴ログ 重めなので一旦後回し
        // ret = rxFtpOpen(ini_file, "subserver", host, RECAL_TRAN_DIR, RECAL_TRAN_DIR, 0, "web2100", "web2100", cmd, NULL);
        ret = AplLib.RXFTP_OK;
      }

      if (ret != AplLib.RXFTP_OK) {
        resFlg = Rmstcom.RMST_NG;
        log = "$callFunc: $server Ftp Open Error";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
      } else {
        if (existChk != 0) {
          // TODO:10152 履歴ログ 重めなので一旦後回し
          // ret = rxFtpExec(fname, cmd, 30, 2, RXFTP_SIZE);
          if (ret < 0) {
            resFlg = Rmstcom.RMST_NG;
            log = "$callFunc: $server Ftp size Error";
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
          }
          if (ret <= 0) { //zipファイル存在しないまたは取得エラー
            // TODO:10152 履歴ログ 重めなので一旦後回し
            // rxFtpClose(NULL);
            continue;
          }
        }
        // TODO:10152 履歴ログ 重めなので一旦後回し
        // ret = rxFtpExec(mfname, cmd, 30, 2, typ);
        if (ret != AplLib.RXFTP_OK) {
          resFlg = Rmstcom.RMST_NG;
          log = "$callFunc: $server Ftp $ftpTyp Error";
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
        } else {
          log = "$callFunc: $server Ftp $ftpTyp OK";
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
        }
        // TODO:10152 履歴ログ 重めなので一旦後回し
        // rxFtpClose(NULL);
      }

      if (ret != AplLib.RXFTP_OK && result != null) {
        if (idx == 0) {
          result |= 0x04; //      0x04:Mへの送信エラー
        } else {
          result |= 0x08; //      0x08:BSへの送信エラー
        }
      }
    }
    return resFlg;
  }

  /// 関連tprxソース: rmstcls.c - ChkAutoCls
  static int chkAutoCls() {
    return 0;
  }


  /// 機能：HQASP仕様時、ASPへの履歴ログ送受信の完了待ち
  /// ：CSS/TAURUS仕様時、上位とBSへのファイル送信完了待ち
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstcls.c - HQASP_hqhist_wait
  static Future<int> clsHqaspHqhistWait() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf pStat = xRet.object;

    Rmstcom.rmstTimerRemove();

    if (await AplLibHqConnect.aplLibHqConnectHqHistRecvCheckSystem(
        Tpraid.TPRAID_STR) != 0) {
      if (pStat.hqhist.hqHistEnd == 0 || pStat.hqhist.running == 1) {
        /* hqhistタスク未完了 */
        Rmstcom.rmstTimerAdd(150, clsHqaspHqhistWait);
        return 0;
      }
    }

    // 取得が終了したので送信を開始する　
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "HQASP_hqhist_wait End.\n");
    Rmstcom.rmstTimerAdd(100, rmstClsSvCdHqSendWait);

    return 0;
  }

  /// 機能:	上位への実績送信を行う. hqftpタスクへ送信要求をする
  /// 戻値:	HQHIST_OK: 成功  HQHIST_NG: 失敗  HQHIST_RETRY: リトライしてみる
  /// 関連tprxソース: rmstcls.c - rmstclssvcd_Hq_Send_Wait
  static Future<int> rmstClsSvCdHqSendWait() async {
    String log = '';
    String tempBuf = '';
    int val = 0;
    String callFunc = '';

    Rmstcom.rmstTimerRemove();

    if (await AplLibHqConnect.aplLibHqConnectHqftpSendCheckSystem(
        Tpraid.TPRAID_STR) != 0) {
      log = "$callFunc : hq send start ";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);

      if (await CmCksys.cmNetDoASystem() != 0) {
        AplLibHqConnect.aplLibHqConnectHqftpRequestStart(
            Tpraid.TPRAID_STR, HqftpRequestTyp.HQFTP_REQ_DAY.type,
            null); // netDoAだけ日中ファイルも送信
      }

      AplLibHqConnect.aplLibHqConnectHqftpRequestStart(
          Tpraid.TPRAID_STR, HqftpRequestTyp.HQFTP_REQ_CLS.type,
          null); // 閉設ファイルの送信

      log = "$callFunc : hq send end ";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);
    }

    // 送信終了
    Rmstcom.rmstMsgClear(callFunc); // 本部送信中のダイアログをクリアする
    Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, execProc4);

    return 0;
  }

  /// 関数：int ExecProc4(void)
  /// 機能：閉店処理４(DBファイル整理)
  /// 引数：なし
  /// 戻値：0:終了
  /// 関連tprxソース: rmstcls.c - ExecProc4
  static Future<int> execProc4() async {
    String data = '';
    String fileName = '';
    String fileNameSpecBkupNg = '';
    int specBkupFtpRet = 0;
    int specBkupTarRet = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    Rmstcom.rmstTimerRemove();

    // TODO:10152 履歴ログ 保留
    // ExecProcCounter();	/* counter.ini更新 */

    if (CmCksys.cmMmType() == CmSys.MacM1 ||
        CmCksys.cmMmType() == CmSys.MacM2 ||
        CmCksys.cmMmType() == CmSys.MacMOnly) {
      execProcDbClose();

      // TODO:10152 履歴ログ 商品マスタ更新処理保留
      // if (db_LocalStart(TPRAID_STR) == CLS_OK) {
      //   ExecProc4PluUpdate();
      //   if (CmCksys.cmMmType() == CmSys.MacM1)
      //     ExecProcPluWeightUpdate(0);
      // } else {
      //   TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
      //       "ExecProc4 :UPD PLU db Start Error");
      // }
    }

    if (await CmCksys.cm24hourSystem() != 0 && pCom.dbTrm.systRestart == 1) {
      /* 24時間仕様 途中清算 Vacuumをskip */
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.normal, "ExecProc4 : Skip Vacuum ");
      if (await CmCksys.cmWsSystem() != 0) {
        // gtk_entry_set_text(GTK_ENTRY(entrystcls5), ENTRY_TXT_SKIP); /* 画面上は「スキップ」 */
      } else {
        // gtk_entry_set_text(GTK_ENTRY(entrystcls5), ENTRY_TXT_OK); /* 画面上は「OK」 */
      }
    } else {
      // TODO:10152 履歴ログ 保留
      // SSD_DeviceAllRead( TPRAID_STR );

      /* データベース整理 */
      // TODO:10152 履歴ログ 保留
      // procStat.stExecProc4Sub = ExecProc4Sub();
      if (procStat.stExecProc4Sub == Rmstcom.RMST_OK) {
        fCloseFlg |= CLSSTAT_VACCUM;
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.normal, "ExecProc4 : OK");
        // gtk_entry_set_text(GTK_ENTRY(entrystcls5), ENTRY_TXT_OK);
        // TODO:10152 履歴ログ 保留
        // rmStoreCloseDBAnsSet(0);
      } else {
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.error, "ExecProc4 : NG");
        // gtk_entry_set_text(GTK_ENTRY(entrystcls5), ENTRY_TXT_NG);
        // TODO:10152 履歴ログ 保留
        // rmStoreCloseDBAnsSet(1);
      }
    }

    /* SPEC_BKUP 圧縮失敗 */
// TODO:10152 履歴ログ 閉店処理系保留
//   memset (filename, 0x00, sizeof (filename));
//   snprintf (filename, sizeof (filename), "%s/tmp/spec_bkup/work/tmp", SysHomeDirp);
//   memset (filename_spec_bkup_ng, 0x00, sizeof (filename_spec_bkup_ng));
//   snprintf (filename_spec_bkup_ng, sizeof (filename_spec_bkup_ng)-1, SPEC_BKUP_TAR_NG_TXT_DATE_NONE, SysHomeDirp);
//
//   spec_bkup_ftp_ret = access(filename, F_OK);	/* SPEC_BKUPのFTPに失敗すると残っているファイル */
//   spec_bkup_tar_ret = access(filename_spec_bkup_ng, F_OK); /* SPEC_BKUPの圧縮に失敗すると作成されるファイル */
//   if (spec_bkup_tar_ret == 0)
//   {
//   // ファイルが存在するときのみＮＧを出力する
//   memset (data, 0x00, sizeof (data));
//   sprintf (data, "%s%s", SPACE4, SPEC_BKUP_MAKE_NG_TXT);
//
//   rmstEjTxtMake (data, REG_CLOSE);
//   } else {/* 圧縮成功 */
//   /* SPEC_BKUP FTP送信失敗 */
//   if (spec_bkup_ftp_ret == 0)
//   {
//   // ファイルが存在するときのみＮＧを出力する
//   memset (data, 0x00, sizeof (data));
//   sprintf (data, "%s%s", SPACE4, PROC9_TXT);
//
//   rmstEjTxtMake (data, REG_CLOSE);
//
//   }
//   }
//   if (spec_bkup_ftp_ret == 0 || spec_bkup_tar_ret == 0)
//   {
//   memset (filename, 0x00, sizeof (filename));
//   snprintf (filename, sizeof(filename), "%s%s", SysHomeDirp, SPEC_BKUP_ALL_DIR);
//   SpecBackUp_lib_File_Delete(TPRAID_STR, filename, 1);
//   }
//
//   /* ＵＳＢバックアップ */
//   if( rmstcls_usb_bkup ) {
//   gtk_entry_set_text(GTK_ENTRY(entrystcls11), ENTRY_TXT_GOING);
// //	    rmstTimerAdd(NEXT_GO_TIME, (GtkFunction)ExecProcUsbBackUp);
//   rmstTimerAdd(NEXT_GO_TIME, (GtkFunction)ExecProcUsbBackUp_Chk);
//   }
//   else {
//   /* 閉店処理６へ */
//   if(logg_flg > 0){
//   fStat = STCLS_PROC6;
//   gtk_entry_set_text(GTK_ENTRY(entrystcls6), ENTRY_TXT_GOING);
//   rmstTimerAdd(NEXT_GO_TIME, (GtkFunction)ExecProc6);
//   }
//   /* 閉店処理終了処理へ */
//   else{
//   fStat = STCLS_PROCEXIT;
//   gtk_entry_set_text(GTK_ENTRY(entrystcls6), ENTRY_TXT_GOING);
//   rmstTimerAdd(NEXT_GO_TIME, (GtkFunction)ExecProcExit);
//   }
//   }

    return 0;
  }

  /// 関連tprxソース: rmstcls.c - LogSaveProc
  static Future<bool> logDeleteProc() async {
    const String tmnLogFileDir = "log/tmn/log";

    String logFolderPath = join(EnvironmentData().sysHomeDir, 'log');
    final directory = Directory(logFolderPath);
    String logFolderPathtmn = join(EnvironmentData().sysHomeDir, tmnLogFileDir);
    final directorytmn = Directory(logFolderPathtmn);

    bool errStat = true;
    int failureCount = 0;

    // tprx/log/の下のファイル削除
    try {
      if (directory.existsSync()) {
        // ディレクトリ内のすべてのファイルとサブディレクトリを取得
        final entities = directory.listSync();

        for (var entity in entities) {
          // ファイルシステムエンティティがファイルの場合のみ削除
          if (entity is File) {
            // ファイルを削除する
            failureCount += await _deleteFileWithRetry(entity);
          }
        }
      } else {
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.error, "ディレクトリが存在しません $logFolderPath");
      }
    } catch (e, s) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, "File Deletion Error: $logFolderPath \n$e \n$s");
      errStat = false;
    }

    // tmn/log/の下のファイル削除
    if (Platform.isWindows) {
      // Windowsでは何もしない
    } else if (Platform.isLinux) {
      try {
        if (directorytmn.existsSync()) {
          // ディレクトリ内のすべてのファイルとサブディレクトリを取得
          final entities = directorytmn.listSync();

          for (var entity in entities) {
            if (entity is File) {
              // ファイルを削除する
              failureCount += await _deleteFileWithRetry(entity);
            }
          }
        } else {
          TprLog().logAdd(
              Tpraid.TPRAID_STR, LogLevelDefine.error, "ディレクトリが存在しません $logFolderPathtmn");
        }
      } catch (e, s) {
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.error, "File Deletion Error: $logFolderPathtmn \n$e \n$s");
        errStat = false;
      }
    }

    // トランザクションデータの削除
    List<FileSystemEntity> entities = TransactionManagement.getAllFiles();
    for (var entity in entities) {
      if (entity is File) {
        // ファイルを削除する
        failureCount += await _deleteFileWithRetry(entity);
      }
    }

    if (failureCount != 0) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, "logDeleteProc: Cannot Delete File count=$failureCount");
    }
    return errStat;
  }

  /// ファイルが存在していれば削除する
  static Future<int> _deleteFile(File file) async {
    int ret = 0;
    try {
      if (file.existsSync()) {
        ret = await _deleteFileWithRetry(file);
      }
    } catch (e) {
      debugPrint("File Exists Error: ${file.path} \n$e");
      ret = 1;
    }
    return ret;
  }

  /// ファイルを削除する
  static Future<int> _deleteFileWithRetry(File file) async {
    int ret = 0;
    const int maxRetries = 3;

    // ファイルシステムエンティティがファイルの場合のみ削除
    for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
      try {
        // ファイルを削除
        file.deleteSync();
        debugPrint("${file.path} ファイルを削除しました");
        // 削除成功
        break;
      } catch (e) {
        if (retryCount < maxRetries - 1) {
          debugPrint("${file.path} Delete Retry");
          // 0.5秒待機
          await Future.delayed(const Duration(milliseconds: 500));
        } else {
          debugPrint("File Deletion Error: ${file.path} \n$e");
          ret = 1;  // 削除失敗
        }
      }
    }

    return ret;
  }

  /// 関連tprxソース: rmstcls.c - ExecProc3Sub
  static Future<bool> execProc3Sub() async {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    final DateTime date = DateTime.now();
    int wlogDate = pCom.dbTrm.tranDelDate;
    if (wlogDate <= 0) wlogDate = 62;
    var deldate = date.subtract(Duration(days: wlogDate));
    String formatteddeldate = DateFormat('yyyyMMdd').format(deldate);

    // 期限超過ファイルの削除
    var ret = await execProc3DelBkup(formatteddeldate);

    if(ret == false){
      return false;
    }
    return true;
  }

  /// 関連tprxソース: rmstcls.c - ExecProc3DelBkup
  static Future<bool> execProc3DelBkup(String deldate) async {
    var ret = true;

    String log = 'execProc3DelBkup: deldate[$deldate]';
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, log);

    for (int idx = 0; idx < BkUpFNames.BKUP_FNAME_MAX.index; idx++) {
      if (idx == BkUpFNames.BKUP_FNAME_RECAL.index) continue;
      var result = await execProc3MakeName();
      ret = await execProc3DelFile(deldate, result);
    }

    if(ret == false){
      return false;
    }
    return true;
  }

  /// 関連tprxソース: rmstcls.c - ExecProc3MakeName
  static Future<String> execProc3MakeName() async {
    String str = join(EnvironmentData().sysHomeDir, 'tran_backup');

    return str;
  }

  /// 関連tprxソース: rmstcls.c - ExecProc3DelFile
  static Future<bool> execProc3DelFile(String deldate, String path) async {
    Directory directory = Directory(path);

    try {
      if (directory.existsSync()) {
        int max = BkUpDbs.BKUP_DB_MMEJLOG.value;

        var entities = directory.listSync();
        for (var entity in entities) {
          // ファイル名を取得
          String name = entity.uri.pathSegments.last;
          for (int idx = 0; idx < max; idx++) {
            if (name.startsWith(BkUpDbs.values[idx].tableName)) {
              // テーブル名の長さを取得
              int len = BkUpDbs.values[idx].tableName.length;

              // 日付部分を取得
              String datePart = name.substring(len, len + 8);
              if (datePart.compareTo(deldate) < 0) {
                String delName = join(path, name);
                try {
                  // ファイルを削除
                  File(delName).deleteSync();
                  debugPrint("$delName 期限超過ファイルを削除しました");
                } catch (e) {
                  debugPrint("File Deletion Error: $delName \n$e");
                  return false;
                }
              }
            }
          }
        }
      } else {
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.error, "ディレクトリが存在しません $path");
        return false;
      }
    } catch (e, s) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, "File Deletion Error: $path \n$e \n$s");
      return false;
    }
    return true;
  }

}

/* HWアラート通知用 ステータスチェック */
/// 関連tprxソース: rmstcls.c - PROC_STAT
class ProcStat {
  int stExecProc4Sub = 0; // ５．ファイルの整理処理
  int stNgCnt = 0; // ６．USBバックアップ処理(NGカウント数)
}
