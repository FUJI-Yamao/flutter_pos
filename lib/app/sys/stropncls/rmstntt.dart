/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sprintf/sprintf.dart';

import '../../drv/printer/drv_print_isolate.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../inc/lib/cm_str_molding_define.dart';
import '../../inc/lib/mm_reptlib_def.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/apllib/apllib_strutf.dart';
import '../../lib/apllib/mm_reptlib_def.dart';
import '../../lib/if_th/if_th_creadsts.dart';
import '../../lib/if_th/if_th_alloc.dart';
import '../../lib/if_th/if_th_ccut.dart';
import '../../lib/if_th/if_th_feed.dart';
import '../../lib/if_th/if_th_prnstr.dart';
import '../../lib/pr_sp/cm_str_molding.dart';
import '../../regs/inc/rc_crdt.dart';
import '../../regs/inc/rc_if.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/test/test_page2/test_page_contorller/test_page_controller.dart';
import '../word/aa/l_rmstopncls.dart';
import 'rmstcls.dart';
import 'rmstcom.dart';
import '../../common/environment.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/mm_reptlib.dart';
import '../../lib/apllib/TmnDaily_Trn.dart';
import '../../lib/cm_ej/cm_ejlib.dart';

/// 関連tprxソース:rmstntt.c
class Rmstntt {
  static int ut1Prn = 0;
  static int printNum = 0;
  static int printConf = 0;
  static int cMsgFlg = 0;
  static int msgFlg = 0;
  static int statusCnt = 0;
  static int printTimer = -1;
  static late File? fp;
  static late File? fpEj;
  static int printFlg = 0;
  static int nttdataCnt = 0;
  static int printCnt = 0;
  static late File? fpEjNtt;

  static UtDailyInf utInfo = UtDailyInf();

  // ベスカ関連
  static int vescaPrn = 0;

  // static	VESCA_DTL *vesca_stcls = NULL;
  // static	char      *vesca_posi = NULL;
  static int vescaLineMax = 0;
  static File? fpVescaReport;

  /// 関連tprxソース: rmstntt.c - CloseUt1_Result_Chk
  static Future<({int err, int brand, int rst, String msg})>
      closeUt1ResultChk() async {
    String errMsg = '';
    if (ut1Prn == 3) {
      await MmReptlib.countUp();
    }

    if ((TmnDailyTrn.utSaleInfo.resultCode != 0) &&
        (TmnDailyTrn.utSaleInfo.result != 0)) {
      if ((TmnDailyTrn.utSaleInfo.resultCodeExtended != 0) &&
          TmnDailyTrn.utSaleInfo.centerResultCode.isNotEmpty) {
        String centerResultCode =
            TmnDailyTrn.utSaleInfo.centerResultCode.length > 5
                ? TmnDailyTrn.utSaleInfo.centerResultCode.substring(0, 5)
                : TmnDailyTrn.utSaleInfo.centerResultCode;

        errMsg = sprintf("(%s-%s-%s)", [
          TmnDailyTrn.utSaleInfo.resultCode.toString().padLeft(3, '0'),
          TmnDailyTrn.utSaleInfo.resultCodeExtended.toString().padLeft(9, '0'),
          centerResultCode
        ]);
      } else if (TmnDailyTrn.utSaleInfo.resultCodeExtended != 0) {
        errMsg = sprintf("(%s-%s)", [
          TmnDailyTrn.utSaleInfo.resultCode.toString().padLeft(3, '0'),
          TmnDailyTrn.utSaleInfo.resultCodeExtended.toString().padLeft(9, '0'),
        ]);
      } else {
        errMsg = TmnDailyTrn.utSaleInfo.resultCode.toString().padLeft(3, '0');
      }
    }
    return (
      err: utInfo.err,
      brand: utInfo.brand,
      rst: TmnDailyTrn.utSaleInfo.result,
      msg: errMsg
    );
  }

  /// brand  0:QP 1:iD 2:Edy
  /// 関連tprxソース:rmstntt.c - ExecProcCloseUt1
  static Future<int> execProcCloseUt1(int brand) async {
    String filePath = "";
    int prnFlg = 1;

    Rmstcom.rmstTimerRemove();
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "Start[$brand]!");

    if (Rmstcom.nttTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(Rmstcom.nttTimer);
      Rmstcom.nttTimer = -1;
    }

    ut1Prn = 1;
    utInfo = UtDailyInf();
    utInfo.brand = brand;

    printNum = 0;
    printConf = 0;
    statusCnt = 0;
    fp = null;
    fpEj = null;

    if ((utInfo.brand == 1)) {
      filePath = "${EnvironmentData().sysHomeDir}/log/tmn/Re_iD.txt";
    } else if ((utInfo.brand == 2)) {
      filePath = "${EnvironmentData().sysHomeDir}/log/tmn/Re_Edy.txt";
    } else {
      filePath = "${EnvironmentData().sysHomeDir}/log/tmn/Re_QP.txt";
    }

    if (!TprxPlatform.getFile(filePath).existsSync()) {
      TprLog()
          .logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "No obscure deal");
      prnFlg = 0;
    }
    String path = join(
        EnvironmentData().sysHomeDir, CmEj.EJ_WORK_DIR, AplLib.EJ_TMN_PRN_FILE);
    final File tempFile = TprxPlatform.getFile(path);
    if (tempFile.existsSync()) {
      tempFile.deleteSync();
    }

    TmnDailyTrn.utSaleInfo = UtInfo();
    TmnDailyTrn.utSaleInfo.result = 0;
    utInfo.err =
        await TmnDailyTrn.utDailyMainProc(Tpraid.TPRAID_STR, utInfo.brand, 1);
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "Daily Get[${TmnDailyTrn.utSaleInfo.result}][${TmnDailyTrn.utSaleInfo.resultCode}][${TmnDailyTrn.utSaleInfo.resultCodeExtended}][${TmnDailyTrn.utSaleInfo.centerResultCode}] Err[${utInfo.err}]");
    if (prnFlg == 0) {
      await Rmstcls.execPrintUt1End();
      return 1;
    }

    try {
      fp = TprxPlatform.getFile(path);
      if (!tempFile.existsSync() || tempFile.readAsBytesSync().isEmpty) {
        TprLog().logAdd(
            Tpraid.TPRAID_STR, LogLevelDefine.error, "print file make error!");
        await Rmstcls.execPrintUt1End();
        return 0;
      }
    } on FileSystemException catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "[${basename(tempFile.path)}] open error!");
      await Rmstcls.execPrintUt1End();
      return 0;
    }
    ut1Prn = 2;
    MmReptlib().fontOpen(Tpraid.TPRAID_STR);

    printTimer = -1;
    printTimer = Fb2Gtk.gtkTimeoutAdd(50, closeNTTExecGoPrintBefore, 0);

    return 0;
  }

  /// 印刷実行前処理
  /// 関連tprxソース:rmstntt.c - CloseNTT_Exec_Go_PrintBefore
  static int closeNTTExecGoPrintBefore() {
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "CloseNTT_Exec_Go_PrintBefore\n");

    if (printTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(printTimer);
      printTimer = -1;
    }
    printTimer = Fb2Gtk.gtkTimeoutAdd(50, closeNTTExecGoPrint, 0);

    return 0;
  }

  /// 印刷実行処理
  /// 関連tprxソース:rmstntt.c - CloseNTT_Exec_Go_Print
  static Future<int> closeNTTExecGoPrint() async {
    int result;
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        "CloseNTT_Exec_Go_PrintBefore\n");

    if (printTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(printTimer);
      printTimer = -1;
    }
    if ((result = await closeNTTPrnGo()) != 0) {
      rmstnttCloseVescaMemFree("closeNTTExecGoPrint");

      printConf = 0;
      closeNTTConfAfterErr(DlgConfirmMsgKind.MSG_SYSERR.dlgId, 1);
      return -1;
    }
    return 0;
  }

  /// 印刷前処理
  /// 関連tprxソース:rmstntt.c - CloseNTT_prn_Go
  static Future<int> closeNTTPrnGo() async {
    int result;
    TprLog()
        .logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "CloseNTT_prn_Go\n");

    result = await MmReptlib().mmReptlibInit();
    if (result == Typ.NG) {
      return result;
    }

    if (printTimer != -1) {
      return -1;
    }

    printTimer = Fb2Gtk.gtkTimeoutAdd(3, closeNTTPrnRead, 0);

    return 0;
  }

  /// 印刷前ステータス取得処理
  /// 関連tprxソース:rmstntt.c - CloseNTT_prn_Read
  static Future<int> closeNTTPrnRead() async {
    int ret;

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "CloseNTT_prn_Read\n");

    if (printTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(printTimer);
      printTimer = -1;
    }

    DlgConfirmMsgKind define =
        DlgConfirmMsgKind.getDefine(MmReptlib.mmReptPrintError);
    switch (define) {
      case DlgConfirmMsgKind.MSG_SETCASETTE: // Head Open Error
      case DlgConfirmMsgKind.MSG_PAPEREND: // Paper End Error
        closeNTTConfAfterErr(MmReptlib.mmReptPrintError, 1);
        cMsgFlg = 1;
        printConf = 3;
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnPrnerr, 0);
        return (-1);
      case DlgConfirmMsgKind.MSG_NONE: // case 0:の書き換え
        break;
      default:
        printTimer = Fb2Gtk.gtkTimeoutAdd(3, closeNTTPrnRead, 0);
    }

    ret = await closeNTTPrnStatusRead();
    if (ret != 0) {
      closeNTTConfAfterErr(ret, 1);
      cMsgFlg = 1;
      printConf = 3;
      printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnPrnerr, 0);
      return (-1);
    }
    printTimer = Fb2Gtk.gtkTimeoutAdd(3, closeNTTStatusGet, 0);
    return 0;
  }

  /// プリンタステータスリード
  /// 関連tprxソース:rmstntt.c - CloseNTT_prn_Status_Read
  static Future<int> closeNTTPrnStatusRead() async {
    int ret;

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "CloseNTT_prn_Status_Read\n");

    MmReptlib.mmReptPrintError -= 1; // ステータスリードでアンサー
    //１回必要
    ret = await IfThCReadSts.ifThCReadStatus(Tpraid.TPRAID_STR);

    if (ret != 0) {
      return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
    }
    return 0;
  }

  /// エラー表示処理（確認）
  /// 関連tprxソース:rmstntt.c - CloseNTT_ConfAfterErr
  static int closeNTTConfAfterErr(int errCode, int userCode) {
    tprDlgParam_t param = tprDlgParam_t();

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "CloseNTT_ConfAfterErr\n");

    TprDlg.tprLibDlgClear('closeNTTConfAfterErr');
    // TODO:10122 グラフィクス処理（gtk_*）
    // gtk_grab_add( wincls );
    MmReptlib.mmReptPrintError = errCode;

    // memset(&param, 0x0, sizeof(tprDlgParam_t));
    param.erCode = errCode;
    param.dialogPtn = DlgPattern.TPRDLG_PT4.dlgPtnId;
    param.title = " ";
    param.userCode = userCode;

    cMsgFlg = 1;
    msgFlg = Typ.ON;

    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: errCode,
           ),
    );

    return 0;
  }

  /// プリンタエラー取得後処理
  /// 関連tprxソース:rmstntt.c - CloseNTT_prn_prnerr
  static void closeNTTPrnPrnerr() {
    if (printTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(printTimer);
      printTimer = -1;
    }

    switch (MmReptlib.mmReptPrintError) {
      case 0:
        if (vescaPrn == 1) {
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
              "closeNTTPrnPrnerr : vescaPrn[$vescaPrn]\n");
        }
        break;
      default:
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnPrnerr, 0);
        break;
    }
    return;
  }

  /// プリンタステータス取得処理
  /// 関連tprxソース:rmstntt.c - CloseNTT_Status_Get
  static int closeNTTStatusGet() {
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "CloseNTT_Status_Get\n");

    if (printTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(printTimer);
      printTimer = -1;
    }

    // TODO:10133 プリンタステータスチェック ステータスチェック未実装のため、ステータスチェックOKとして処理を飛ばす.
    MmReptlib.mmReptPrintError = 0;

    switch (MmReptlib.mmReptPrintError) {
      case -3:
      case -2:
      case -1:
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTStatusGet, 0);
        break;
      case 0:
        printTimer = Fb2Gtk.gtkTimeoutAdd(3, closeNTTPrnRead1, 0);
        break;
      default:
        closeNTTConfAfterErr(MmReptlib.mmReptPrintError, 1);
        cMsgFlg = 1;
        printConf = 3;
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnPrnerr, 0);
        return (-1);
    }
    return 0;
  }

  /// 関連tprxソース:rmstntt.c - CloseNTT_prn_Read1
  static Future<int> closeNTTPrnRead1() async {
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "CloseNTT_prn_Read1\n");

    if (printTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(printTimer);
      printTimer = -1;
    }
    switch (printConf) {
      case 1:
        break;
      case 2:
        closeNTTExecEndPrint();
        return 0;
      case 3: // エラー.
        if (printTimer != -1) {
          closeNTTConfAfterErr(DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId, 5);
          closeNTTExecEndPrint();
          return -1;
        }
        printTimer = Fb2Gtk.gtkTimeoutAdd(50, closeNTTPrnRead1, 0);
        return 0;
      default:
        break;
    }

    if (printTimer != -1) {
      await MmReptlib.mmReptlibFillPrint(Typ.OFF, ' ', MmReptLibDef.MMREPTFS24);

      await MmReptlib.mmReptlibEndprint2();
      closeNTTConfAfterErr(DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId, 5);
      closeNTTExecEndPrint();
      return (-1);
    }

    printTimer = Fb2Gtk.gtkTimeoutAdd(3, closeNTTPrnPrint, 0);
    return 0;
  }

  /// レシート印字終了処理
  /// 関連tprxソース:rmstntt.c - CloseNTT_Exec_End_Print
  static int closeNTTExecEndPrint() {
    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "closeNTTExecEndPrint");

    MmReptlib.mmReptlibEnd(); /* この関数は後日メニューで呼ぶ */

    MmReptlib.fontClose(Tpraid.TPRAID_STR);

    printConf = 0;
    printNum = 0;
    msgFlg = Typ.OFF;

    Rmstcom.nttExecFlg = 0;
    Rmstcom.vescaExecFlg = 0;

    if (ut1Prn != 0) {
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, Rmstcls.execPrintUt1End);
    } else if (vescaPrn != 0) {
      rmstnttCloseVescaMemFree("closeNTTExecEndPrint");
      vescaPrn = 0;
      Rmstcom.rmstTimerAdd(
          Rmstcom.NEXT_GO_TIME, Rmstcls.rmstclsExecprintVescaEnd);
    } else {
      Rmstcom.rmstTimerAdd(Rmstcom.NEXT_GO_TIME, Rmstcls.execPrintUt1End);
    }

    return 0;
  }

  /// 印刷メイン処理
  /// 関連tprxソース: rmstntt.c - CloseNTT_prn_Print
  static Future<int> closeNTTPrnPrint() async {
    int rtn = 0;
    File fileName;
    String data = "";
    String cnt = "";
    String msgBuf = "";
    /*--------------------------------------------------------------------------*/
    if (printTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(printTimer);
      printTimer = -1;
    }

    switch (printConf) {
      case 1:
        break;
      case 2:
        //（空行）
        await MmReptlib.mmReptlibFillPrint(
            Typ.OFF, ' ', MmReptLibDef.MMREPTFS24);
        await MmReptlib.mmReptlibEndprint2();
        closeNTTExecEndPrint();
        return 0;
      case 3:
        if (printTimer != -1) {
          //（空行）
          await MmReptlib.mmReptlibFillPrint(
              Typ.OFF, ' ', MmReptLibDef.MMREPTFS24);
          await MmReptlib.mmReptlibEndprint2();
          closeNTTConfAfterErr(DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId, 6);
          closeNTTExecEndPrint();
          return -1;
        }
        printTimer = Fb2Gtk.gtkTimeoutAdd(50, closeNTTPrnPrint, 0);
        return 0;
      default:
        break;
    }
    DlgConfirmMsgKind define =
        DlgConfirmMsgKind.getDefine(MmReptlib.mmReptPrintError);
    switch (define) {
      case DlgConfirmMsgKind.MSG_SETCASETTE:
      case DlgConfirmMsgKind.MSG_PAPEREND: // Paper End Error
        closeNTTConfAfterErr(MmReptlib.mmReptPrintError, 1);
        cMsgFlg = 1;
        printConf = 3;
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnPrnerr, 0);
        return -1;
      case DlgConfirmMsgKind.MSG_NONE: // case 0:の書き換え
        break;
      default:
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnPrint, 0);
        return 0;
    }
    switch (printNum) {
      case 0: // ヘッダ
        MmReptlib.reptDat.batReport.batch_report_no =
            ReptNumber.MMREPT132.index; //現在売価
        MmReptlib.reptDat.batchFlg = 9; //設定
        MmReptlib.reptDat.kind = 0;
        MmReptlib.reptDat.reptFlg = 4;

        MmReptlib.reptDat.batReport.batch_flg = MmReptlib.reptDat.batchFlg - 1;
        MmReptlib.reptDat.batReport.batch_flg2 = MmReptlib.reptDat.reptFlg;

        if (ut1Prn == 2) {
          ut1Prn = 3;
        }

        if (vescaPrn != 0) {
          rtn = await IfThAlloc.ifThAllocArea(Tpraid.TPRAID_REPT, 30);
          if (rtn != 0) {
            // 各、エラー時は、通常のヘッダ印字処理を動かす
            rtn = await MmReptlib.mmReptlibHeadprint2(MmReptLibDef.MMREPTFS24);
          } else {
            // memset(msg_buf, 0x0, sizeof(msg_buf));
            msgBuf = LRmstopncls.CLS_VESCA_CUTOFF_HERE.val;
            await rmstnttMsgLinePrint(msgBuf);

            rtn = await IfThFeed.ifThFeed(Tpraid.TPRAID_REPT, 120);
            if (rtn != 0) {
              rtn =
                  await MmReptlib.mmReptlibHeadprint2(MmReptLibDef.MMREPTFS24);
            } else {
              rtn = await IfThCCut.ifThCCut(
                  Tpraid.TPRAID_REPT, InterfaceDefine.IF_TH_NOLOGO);
              if (rtn != 0) {
                rtn = await MmReptlib.mmReptlibHeadprint2(
                    MmReptLibDef.MMREPTFS24);
              } else {
                rtn = await IfThAlloc.ifThAllocArea(Tpraid.TPRAID_REPT, 120);
                if (rtn != 0) {
                  rtn = await MmReptlib.mmReptlibHeadprint2(
                      MmReptLibDef.MMREPTFS24);
                }
              }
            }
          }
        } else {
          //レシートヘッダ部のみ
          rtn = await MmReptlib.mmReptlibHeadprint2(MmReptLibDef.MMREPTFS24);
        }

        if ((ut1Prn != 0) || (vescaPrn != 0)) {
          printNum++;
          nttdataCnt = 0;
          printCnt = 0;
          printFlg = 0;
          break;
        }

        await EnvironmentData().tprLibGetEnv();
        fileName =
            File("${EnvironmentData().sysHomeDir}/log/Credit/Ntt/nttfile.inf");

        nttdataCnt = 0;

        if (!await fileName.exists()) {
          //＊＊＊＊＊ 取引未完了 ＊＊＊＊＊
          data = LRmstopncls.NTT_HEAD_1.val;

          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(
                Tpraid.TPRAID_STR, LogLevelDefine.error, "printString 1\n");
          }

          //該当データなし
          data = " ${LRmstopncls.NTT_NODATE.val}";
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(
                Tpraid.TPRAID_STR, LogLevelDefine.error, "printString 2\n");
          }

          //（空行）
          await MmReptlib.mmReptlibFillPrint(
              Typ.OFF, ' ', MmReptLibDef.MMREPTFS24);

          //＊＊＊＊ カウンタ不一致 ＊＊＊＊
          data = LRmstopncls.NTT_HEAD_2.val;

          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(
                Tpraid.TPRAID_STR, LogLevelDefine.error, "printString 3\n");
          }

          //該当データなし
          data = LRmstopncls.NTT_NODATE.val;

          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(
                Tpraid.TPRAID_STR, LogLevelDefine.error, "printString 4\n");
          }
          printNum = 3;
        } else {
          printNum++;

          cnt = fileName.readAsStringSync();
          nttdataCnt = int.parse(cnt);

          // TODO:00012 平野　fseekの動作について要確認（いったんコメント化）
          // fseek(fp, 0L, SEEK_SET);//ファイルの先頭から
          // fseek(fp, 4L, SEEK_SET);//ファイルの先頭から+4

          //＊＊＊＊＊ 取引未完了 ＊＊＊＊＊
          data = LRmstopncls.NTT_HEAD_1.val;

          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(
                Tpraid.TPRAID_STR, LogLevelDefine.error, "printString 1\n");
          }
        }
        printCnt = 0;
        printFlg = 0;
        break;
      case 1: // 印刷条件
        // 印字処理
        if (ut1Prn != 0) {
          await closeUt1PrintMain();
          printNum = 3;
          break;
        }

        if (vescaPrn != 0) {
          rmstnttCloseVescaPrintMain();
          printNum = 3;
          break;
        }

        rtn = await closeNTTPrint();
        if (rtn != 0) {
          printNum++;
          printFlg = 0;
          printCnt = 0;
          // TODO:00012 平野　fseekの動作について要確認（いったんコメント化）
          // fseek(fp, 0L, SEEK_SET);//ファイルの先頭から
          // fseek(fp, 4L, SEEK_SET);//ファイルの先頭から+4

          //（空行）
          await MmReptlib.mmReptlibFillPrint(
              Typ.OFF, ' ', MmReptLibDef.MMREPTFS24);

          //＊＊＊＊ カウンタ不一致 ＊＊＊＊
          data = LRmstopncls.NTT_HEAD_2.val;

          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(
                Tpraid.TPRAID_STR, LogLevelDefine.error, "printString 8\n");
          }
        }
        break;
      case 2: // 印刷条件
        //印字処理
        rtn = await closeNTTPrint2();
        if (rtn != 0) {
          printNum++;
          printNum++;
          // memo: fpファイルポインタを使用していないが念のためコメント化
          // if ( fp ){
          //   fclose( fp );
          //   fp = NULL;
          // }
        }
        break;
      case 3: // 印字終了
        //（空行）
        await MmReptlib.mmReptlibFillPrint(
            Typ.OFF, ' ', MmReptLibDef.MMREPTFS24);

        await MmReptlib.mmReptlibEndprint2();
        printNum++;
        break;
      case 4:
        // if((await MmReptlib.mmReptlibPortGet() & RcIf.XPRN_ERR) != 0){
        //   printNum++;
        //   if(await closeNTTPrnStatusRead() != 0){
        //     closeNTTConfAfterErr(DlgConfirmMsgKind.MSG_PRINTERR.dlgId, 1);
        //     closeNTTExecEndPrint();
        //     return -1;
        //   }
        // }else if((!((await MmReptlib.mmReptlibPortGet() & RcIf.XPRN_SLCT) != 0))
        //     || (MmReptlib.mmReptSlctFlg == 1)){
        //   MmReptlib.mmReptSlctFlg = 1;
        //   await  Future.delayed(const Duration(microseconds: 10000));
        //   if((await MmReptlib.mmReptlibPortGet() & RcIf.XPRN_BSY) != 0){ // need printer firm > V1.2
        //     closeNTTExecEndPrint();
        //     return 0;
        //   }
        // }
        // if(++MmReptlib.mmRptCount > MmReptLibDef.PRINT_CNT_MAX){
        //   TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal,
        //       "closeNTTPrnPrint() Counter Over!!\n");
        //   closeNTTExecEndPrint();
        //   return 0;
        // }
        // TODO:10133 プリンタステータスチェック 飛ばす.
        return closeNTTExecEndPrint();
        break;
      default:
        statusCnt = -1;
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnCutAfter, 0);
        return 0;
    }
    printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnPrint, 0);
    return 0;
  }

  /// レポートカット後処理
  /// 関連tprxソース: rmstntt.c - CloseNTT_prn_CutAfter
  static Future<int> closeNTTPrnCutAfter() async {
    int ret;

    TprLog().logAdd(
        Tpraid.TPRAID_STR, LogLevelDefine.normal, "CloseNTT_prn_CutAfter\n");

    if (printTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(printTimer);
      printTimer = -1;
    }
    switch (printConf) {
      case 1:
        break;
      case 2:
        //（空行）
        await MmReptlib.mmReptlibFillPrint(0, ' ', MmReptLibDef.MMREPTFS24);
        await MmReptlib.mmReptlibEndprint2();
        closeNTTExecEndPrint();
        return (0);
      case 3:
        if (printTimer != -1) {
          //（空行）
          await MmReptlib.mmReptlibFillPrint(0, ' ', MmReptLibDef.MMREPTFS24);
          await MmReptlib.mmReptlibEndprint2();
          closeNTTConfAfterErr(DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId, 6);
          closeNTTExecEndPrint();
          return (-1);
        }
        printTimer = Fb2Gtk.gtkTimeoutAdd(50, closeNTTPrnPrint, 0);
        return (0);
      default:
        break;
    }
    DlgConfirmMsgKind define =
        DlgConfirmMsgKind.getDefine(MmReptlib.mmReptPrintError);
    switch (define) {
      case DlgConfirmMsgKind.MSG_SETCASETTE: // Head Open Error
      case DlgConfirmMsgKind.MSG_PAPEREND: // Paper End Error
        statusCnt++;
        if (statusCnt > 10) {
          closeNTTConfAfterErr(MmReptlib.mmReptPrintError, 1);
          closeNTTExecEndPrint();
          return -1;
        }
        sleep(Duration(microseconds: 300000)); // usleep(300000);
        break;
      case DlgConfirmMsgKind.MSG_NONE: // case 0:の書き換え
        printNum = 0;
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnPrint, 0);
        return 0;
      default:
        printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnCutAfter, 0);
        return 0;
    }
    ret = await closeNTTPrnStatusRead();
    if (ret != 0) {
      closeNTTConfAfterErr(ret, 1);
      closeNTTExecEndPrint();
      return -1;
    }
    printTimer = Fb2Gtk.gtkTimeoutAdd(10, closeNTTPrnCutAfter, 0);
    return 0;
  }

  /// 関連tprxソース: rmstntt.c - rmstntt_msg_line_print
  static Future<void> rmstnttMsgLinePrint(String str) async {
    String pb2;
    String log;
    TImgDataAddAns ans = TImgDataAddAns();

    CmStrMolding.cmImgDataAdd(Tpraid.TPRAID_STR, str, CmStrMolding.RCPTWIDTH,
        CmStrMolding.RCPTWIDTH, 0, DataPosiCenterTyps.DATA_SPC.id, ans);
    pb2 = ans.line[0];
    if (rmstnttVescaChkNoprintFputs(pb2) == 0) {
      if (await MmReptlib.printString(1, pb2, MmReptLibDef.MMREPTFS24) != 0) {
        log = "rmstnttMsgLinePrint : Print[$pb2] Error!";
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
      }
    }
    return;
  }

  /// 関連tprxソース: rmstntt.c - CloseUt1_print_main
  static Future<void> closeUt1PrintMain() async {
    int lineNum = 0;

    // 別関数でFileインスタンスを生成しているため、一応追加
    if (fp == null || !fp!.existsSync()) {
      String fileName = fp != null ? basename(fp!.path) : "";
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "closeUt1PrintMain :fine not found $fileName");
      return;
    }

    for (String line in fp!.readAsLinesSync()) {
      lineNum++;
      if (await MmReptlib.printString(Typ.OFF, line, MmReptLibDef.MMREPTFS24) !=
          0) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "closeUt1PrintMain :line[$lineNum] Print Error!");
      }
    }
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 関数:　rmstnttCloseVescaPrintMain()
  /// 機能: ベスカ決済端末の日計明細の印字処理
  /// 引数: なし
  /// 戻値: なし
  /// 関連tprxソース: rmstntt.c - rmstntt_close_vesca_print_main
  static void rmstnttCloseVescaPrintMain() {
    return;
  }

  // TODO:00012 平野　日計対応：定義のみ追加,中身の実装の必要あり
  /// 関連tprxソース: rmstntt.c - CloseNTT_print
  static Future<int> closeNTTPrint() async {
    return (await closeNTTPrintMain(0));
  }

  /// 関連tprxソース: rmstntt.c - CloseNTT_print_main
  static Future<int> closeNTTPrintMain(int flg) async {
    MmReptT mmReptDat = MmReptT();
    String data = "";
    String wData = "";
    String wData2 = "";
    String wData3 = "";
    NttAspInf nttasp = NttAspInf();
    int fncRtn = 0;
    File? wkFp;
    int nttAspOffset = 0;
    int lineSize = 32;

    if (flg == 1) {
      if (fpEjNtt != null) {
        wkFp = fpEjNtt;
      } else if (fpEj != null) {
        wkFp = fpEj;
      } else {
        return (-1);
      }
      if (printCnt == 0) {
        //＊＊＊＊＊ 取引未完了 ＊＊＊＊＊
        data = LRmstopncls.NTT_HEAD_1.val;
        MmReptlib.printStringEj(wkFp!, data);
        if (fp != null) {
          nttAspOffset = 4;
        } else {
          //該当データなし
          data = " ${LRmstopncls.NTT_NODATE.val}";
          MmReptlib.printStringEj(wkFp!, data);
          return (-1);
        }
      }
    }

    if (nttasp.parse(fp!.readAsBytesSync(), nttAspOffset)) {
      printCnt++;
      if (nttasp.tranFlg[0] == '1') {
        //１回目 取引未完了レコード
        printFlg = 1;

        //端末送信日時
        wData = LRmstopncls.NTT_SEND_DATE.val;
        data = " $wData";
        wData2 = sprintf("%c%c/%c%c %c%c:%c%c:%c%c", [
          nttasp.sendDate[0],
          nttasp.sendDate[1],
          nttasp.sendDate[2],
          nttasp.sendDate[3],
          nttasp.sendDate[4],
          nttasp.sendDate[5],
          nttasp.sendDate[6],
          nttasp.sendDate[7],
          nttasp.sendDate[8],
          nttasp.sendDate[9]
        ]);
        // 半角18文字の文字列幅となるよう空白埋め
        data.padRight(
            18 - (AplLibStrUtf.aplLibEntCnt(data) - data.length), " ");
        data += wData2;
        // 半角32文字の文字列幅となるよう空白埋め
        data += "".padRight(lineSize - (AplLibStrUtf.aplLibEntCnt(data)), " ");
        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 5\n");
          }
        }

        //伝票番号
        wData = LRmstopncls.NTT_ASP_CRDTNO.val;
        data = " $wData";
        // 半角26文字の文字列幅となるよう空白埋め
        data.padRight(
            26 - (AplLibStrUtf.aplLibEntCnt(data) - data.length), " ");
        data += nttasp.aspCrdtNo;
        // 半角32文字の文字列幅となるよう空白埋め
        data += "".padRight(lineSize - (AplLibStrUtf.aplLibEntCnt(data)), " ");
        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 6\n");
          }
        }

        //金額
        wData = LRmstopncls.NTT_PAY_PRI.val;
        data = " $wData";
        wData2 = nttasp.payPri.toString();
        wData3 = wData2;
        data.padRight(
            32 -
                AplLibStrUtf.aplLibEntCnt(wData3) -
                (AplLibStrUtf.aplLibEntCnt(data) - data.length),
            " ");
        data += wData3;
        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 7\n");
          }
        }

        if (flg != 0) {
          MmReptlib.fillPrintEj(wkFp!, '-');
        } else {
          await MmReptlib.mmReptlibFillPrint(
              Typ.OFF, '-', MmReptLibDef.MMREPTFS24);
        }
      }
    } else {
      /* data end */
      fncRtn = -1; /* go to Next */
      if (printFlg == 0) {
        //該当データなし
        data = " ${LRmstopncls.NTT_NODATE.val}";

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 18\n");
          }
        }
      }
      return fncRtn;
    }
    if (printCnt >= nttdataCnt) {
      fncRtn = -1; /* go to Next */
      if (printFlg == 0) {
        //該当データなし
        data = " ${LRmstopncls.NTT_NODATE.val}";

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 18\n");
          }
        }
      }
    }
    return fncRtn;
  }

  /// 関連tprxソース: rmstntt.c - CloseNTT_print2
  static Future<int> closeNTTPrint2() async {
    return await closeNTTPrint2Main(0);
  }

  /// 関数: カウンター不一致内容部セット
  /// 引数: int flg  0:印字　1：EJ
  /// 戻値:
  /// 関連tprxソース: rmstntt.c -  CloseNTT_print2_main
  static Future<int> closeNTTPrint2Main(int flg) async {
    MmReptT mmReptDat = MmReptT();
    String data = '';
    String wData = '';
    String wData2 = '';
    String wData3 = '';
    NttAspInf nttAsp = NttAspInf();
    int nttAspOffset = 0;
    int fncRtn = 0;
    File? wkFp;
    // 1行あたりの半角文字数
    int lineSize = 32;
    // 合計文字幅
    int widthCnt = 0;

    if (flg == 1) {
      if (fpEjNtt != null) {
        wkFp = fpEjNtt;
      } else if (fpEj != null) {
        wkFp = fpEj;
      } else {
        return -1;
      }

      if (printCnt == 0) {
        MmReptlib.fillPrintEj(wkFp!, '');
        data = LRmstopncls.NTT_HEAD_2.val;
        MmReptlib.printStringEj(wkFp, data);
        if (fp != null) {
          nttAspOffset = 4;
        } else {
          //該当データなし
          // TODO:00013 三浦 この空白は必要？
          data = " ${LRmstopncls.NTT_NODATE.val}";
          MmReptlib.printStringEj(wkFp, data);
          //（空行）
          MmReptlib.fillPrintEj(wkFp, ' ');
          return -1;
        }
      }
    }

    if (nttAsp.parse(fp!.readAsBytesSync(), nttAspOffset)) {
      printCnt++;
      if (nttAsp.judgment[0] == '1') {
        //２回目 カウンタ不一致レコード
        printFlg = 1;

        //取扱日・時刻
        wData = LRmstopncls.NTT_ASP_RDTTM.val;
        data = " $wData";
        wData2 = sprintf("%s%s/%s%s/%s%s %s%s:%s%s:%s%s", [
          nttAsp.aspRdttm[0],
          nttAsp.aspRdttm[1],
          nttAsp.aspRdttm[2],
          nttAsp.aspRdttm[3],
          nttAsp.aspRdttm[4],
          nttAsp.aspRdttm[5],
          nttAsp.aspRdttm[6],
          nttAsp.aspRdttm[7],
          nttAsp.aspRdttm[8],
          nttAsp.aspRdttm[9],
          nttAsp.aspRdttm[10],
          nttAsp.aspRdttm[11]
        ]);
        // 半角15文字の文字列幅となるよう空白埋め
        data.padRight(
            15 - (AplLibStrUtf.aplLibEntCnt(data) - data.length), " ");
        data += wData2;
        // 半角32文字の文字列幅となるよう空白埋め
        data += "".padRight(lineSize - (AplLibStrUtf.aplLibEntCnt(data)), " ");

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 9\n");
          }
        }

        //処理通番
        wData = LRmstopncls.NTT_STO_NO.val;
        data = " $wData";
        // 半角25文字の文字列幅となるよう空白埋め
        data.padRight(
            25 - (AplLibStrUtf.aplLibEntCnt(data) - data.length), " ");
        data += nttAsp.stoNo;
        // 半角32文字の文字列幅となるよう空白埋め
        data += "".padRight(lineSize - (AplLibStrUtf.aplLibEntCnt(data)), " ");

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 10\n");
          }
        }

        //伝票番号
        wData = LRmstopncls.NTT_ASP_CRDTNO.val;
        data = " $wData";
        // 半角27文字の文字列幅となるよう空白埋め
        data.padRight(
            27 - (AplLibStrUtf.aplLibEntCnt(data) - data.length), " ");
        data += nttAsp.aspCrdtNo;
        // 半角32文字の文字列幅となるよう空白埋め
        data += "".padRight(lineSize - (AplLibStrUtf.aplLibEntCnt(data)), " ");

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 11\n");
          }
        }

        //取扱区分
        wData = LRmstopncls.NTT_PAY_DIV.val;
        data += nttAsp.payDiv;
        // 半角30文字の文字列幅となるよう空白埋め
        data.padRight(
            30 - (AplLibStrUtf.aplLibEntCnt(data) - data.length), " ");
        data += nttAsp.payDiv;
        // 半角32文字の文字列幅となるよう空白埋め
        data += "".padRight(lineSize - (AplLibStrUtf.aplLibEntCnt(data)), " ");

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 12\n");
          }
        }

        //承認番号
        wData = LRmstopncls.NTT_ASP_RECNO.val;
        data = " $wData";
        // 半角26文字の文字列幅となるよう空白埋め
        data.padRight(
            26 - (AplLibStrUtf.aplLibEntCnt(data) - data.length), " ");
        data += nttAsp.aspRecNo;
        // 半角32文字の文字列幅となるよう空白埋め
        data += "".padRight(lineSize - (AplLibStrUtf.aplLibEntCnt(data)), " ");

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 13\n");
          }
        }

        //会員番号
        wData = '';
        wData2 = '';
        wData3 = '';
        wData = LRmstopncls.NTT_MBR_NO.val;
        data = " $wData";
        wData2 = nttAsp.mbrNo;
        //スペース削除
        wData3 = wData2.replaceAll(RegExp(r'\s'), '');
        widthCnt = AplLibStrUtf.aplLibEntCnt(wData3);
        // 半角18文字未満の場合
        if (widthCnt < 18) {
          // 半角32文字の文字列幅かつwData3が右端となるよう空白埋め
          data += wData3.padLeft(
              lineSize -
                  (widthCnt - wData3.length) -
                  AplLibStrUtf.aplLibEntCnt(data),
              " ");
        } else {
          if (flg != 0) {
            MmReptlib.printStringEj(wkFp!, data);
          } else {
            if (await MmReptlib.printString(
                    Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
                0) {
              TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                  "mm_reptlib_printstring 14\n");
            }
          }

          // 半角32文字の文字列幅かつwData3が右端となるよう空白埋め
          data = wData3.padLeft(lineSize - (widthCnt - wData3.length), " ");
        }
        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 15\n");
          }
        }

        //金額
        wData = '';
        wData2 = '';
        wData3 = '';
        wData = LRmstopncls.NTT_PAY_PRI.val;
        data = " $wData";
        wData2 = nttAsp.payPri;
        wData3 = sprintf("%i", [int.tryParse(wData2) ?? 0]);
        // 半角32文字の文字列幅かつwData3が右端となるよう空白埋め
        widthCnt = AplLibStrUtf.aplLibEntCnt(wData3);
        data += wData3.padLeft(
            lineSize -
                (widthCnt - wData3.length) -
                AplLibStrUtf.aplLibEntCnt(data),
            " ");

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 16\n");
          }
        }

        if (flg != 0) {
          MmReptlib.fillPrintEj(wkFp!, '-');
        } else {
          await MmReptlib.mmReptlibFillPrint(
              Typ.OFF, '-', MmReptLibDef.MMREPTFS24);
        }
      }
    } else {
      /* data end */
      fncRtn = -1; /* go to Next */
      if (printFlg == 0) {
        //該当データなし
        data = " ${LRmstopncls.NTT_NODATE.val}";

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 18\n");
          }
        }
      }
      printFlg = 0;
      return fncRtn;
    }

    if (printCnt >= nttdataCnt) {
      fncRtn = -1; /* go to Next */
      if (printFlg == 0) {
        //該当データなし
        data = " ${LRmstopncls.NTT_NODATE.val}";

        if (flg != 0) {
          MmReptlib.printStringEj(wkFp!, data);
        } else {
          if (await MmReptlib.printString(
                  Typ.OFF, data, MmReptLibDef.MMREPTFS24) !=
              0) {
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
                "mm_reptlib_printstring 18\n");
          }
        }
      }
    }
    return fncRtn;
  }

  /// 関連tprxソース: rmstntt.c -  rmstntt_vesca_chk_noprint
  static int rmstnttVescaChkNoprint() {
    if (!Rmstcom.rmstChkSkipCloseReceipt()) {
      return 0;
    }
    return 1;
  }

  /// 関数：rmstntt_close_vesca_mem_free(void)
  /// 機能：ベスカ決済端末の日計明細印字用に確保したメモリの開放処理
  /// 引数：呼出先の関数名
  /// 戻値：なし
  /// 関連tprxソース: rmstntt.c -  rmstntt_close_vesca_mem_free
  static void rmstnttCloseVescaMemFree(String callFunc) {
    /// TODO:10121 QUICPay、iD 202404実装対象外
    // char log[128];

    // snprintf(log, sizeof(log), "%s : call_func <%s>\n", __FUNCTION__, callFunc);
    // TprLibLogWrite(TPRAID_STR, TPRLOG_NORMAL, 0, log);

    // if (vesca_prn == 1)
    // {
    //   free(vesca_stcls);
    //   free(vesca_posi);
    //   vesca_stcls = NULL;
    //   vesca_posi = NULL;

    //   snprintf(log, sizeof(log), "%s : vesca mem free!!\n", __FUNCTION__);
    //   TprLibLogWrite(TPRAID_STR, TPRLOG_NORMAL, 0, log);
    // }
  }

  /// 関連tprxソース: rmstntt.c -  rmstntt_vesca_chk_noprint_fputs
  static int rmstnttVescaChkNoprintFputs(String pb2) {
    String buf;

    if (rmstnttVescaChkNoprint() == 0) {
      return 0;
    }
    if (fpVescaReport != null) {
      buf = pb2;
      buf += "\n";
      MmReptlib.printStringEj(fpVescaReport!, buf);
    } else {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error, "fp_vesca_report ERROR");
    }
    return 1;
  }
}

/* Ut1 関連 */

/// 関連tprxソース:rmstntt.c
class UtDailyInf {
  int err = 0;
  int brand = 0;
/* 0:QP 1:iD */
}
