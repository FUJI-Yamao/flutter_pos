/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/lib/cm_sys.dart';
import 'package:flutter_pos/app/inc/lib/mm_reptlib_def.dart';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:flutter_pos/app/lib/apllib/recog.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../common/cls_conf/sysJsonFile.dart';
import '../../../common/cls_conf/tprtfJsonFile.dart';
import '../../../common/cls_conf/tprtimJsonFile.dart';
import '../../../common/cls_conf/tprtim_counterJsonFile.dart';
import '../../../common/cls_conf/tprtrpJsonFile.dart';
import '../../../common/cls_conf/tprtsJsonFile.dart';
import '../../../common/cls_conf/tprtss2JsonFile.dart';
import '../../../common/cls_conf/tprtssJsonFile.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../fb/fb_lib.dart';
import '../../../if/if_drv_control.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/tpr_lib.dart';
import '../../ffi/library.dart';
import '../../ffi/ubuntu/ffi_printer.dart';
import './drv_printer_def.dart';
import '../../../if/common/interface_define.dart';
import '../../../inc/sys/tpr_did.dart';
import '../../../inc/sys/tpr_ipc.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../inc/sys/tpr_mid.dart';
import '../../../inc/sys/tpr_stat.dart';
import '../../../inc/sys/tpr_type.dart';

///
/// 関連tprxソース:tprdrv_tprtim.c
///
class AnalysisRet {
  int result = -1;
  int retValPos = 0;
  int retValSiz = 0;
  List<String> retVal = [];
}

/// デバイスドライバ制御_プリンタ
/// メイン
class DrvPrinter {
  /// 共通変数
  static TprDID myDid = 0;
  static TprTID myTid = 0;
  static int iDrvNo = 0;
  static int hMyPipe = -1;
  static int hSysPipe = -1;
  static int hPrnComPipe = -1;
  static int hTprtDrv = -1;
  static int taskOrder = 0;
  static int devOrder = 0;
  static int shmId = 0;
  static int semId = 0;
  static int rctTbCut = 0;
  static int densityVal = 1;
  static int drwMData = DrvPrnDef.DRW_DEF_NUM; //dorower Pin Appointment Data
  static int drwT1Data = DrvPrnDef.DRW_DEF_T1; // ドロア On  Time Data
  static int drwT2Data = DrvPrnDef.DRW_DEF_T2; // ドロア OFF Time Data
  static int receiptWide = 0; // Receipt wide
  static List<String> pDataSave = [];
  static int dataSaveSiz = 0;
  static List<int> version = [0, 0, 0, 0, 0, 0, 0];
  static int versionFlg = 0;
  static String modelId = "";
  static int modelIdFlg = 0;
  static List<int> statusVal = [0, 0, 0, 0];
  static int statusErr = 0;
  static int logoPrintChk = 0;
  static int startFlg = 0;
  static int savePortNm = 0;
  static int allocCnt = 0;
  static int freeCnt = 0;
  static int hC1System = 0;
  static int cutErrFlg = 0;
  static int openFlg = 0;
  static int prnOpenFlg = 0;
  static int usbFlg = 0;
  static int initFlg = 0;
  static int rpdFlg = 0;
  static int wFlg = 0;
  static int shareFlg = 0;
  static int retryFlg = 0;
  static int shareJ = 0;
  static int shareC = 0;
  static int hwResetCnt = 0;
  static int hwResetFlg = 0;
  static int hwResetLog = 0;
  static int baseCount = 0; // ニアエンド発生時点のカウント
  static int currCount = 0; // 現在のカウント
  static int prevCount = 0; // １つ前のカウント
  static int countOffset = 0; // カウント巻き戻り対応オフセット
  static int noteCount = 0; // ニアエンド通知カウント
  static int checkFail = 0; // ニアエンド確定カウンタ
  static int isSetBase = 0; // baseCountがセットされているかフラグ	0:no set  1:set
  static int prnOpen = 0; // プリンタ開けフラグ			0:none    1:done
  static int forceDisp = 0; // ニアエンド通知実行フラグ		0:no      1:yes
  static int detectNearEnd = 0; // ニアエンドを検知しているかフラグ	0:none    1:done
  static int specTerm = 0; // nearEndNote読み取り先		0:spec    1:term
  static int nearEndCheck = 0;
  static int noteLen = 0; // nearend_note設定値
  static String sCounterIni = ""; // tprtim_counter.ini file name
  static int rm59Flg = 0; // RM-5900タイプ
  static int tprtMaxFail = 0;
  static String sHomePath = ""; // TPRXホームパス
  static TprLog myLog = TprLog();
  static int paperEndNotifyFlg = 0; // ペーパーエンド通知フラグ

  SendPort _parentSendPort;

  /// 中断フラグ
  static bool _isAbort = false;
  /// 停止フラグ
  static bool _isStop = false;

  Timer? timerFunc;

  DrvPrinter(this._parentSendPort);

  // 共有ライブラリアクセスクラス
  var ffiPtr = FFIPrinter();
  TprMsg_t printMsg = TprMsg();

  RxCommonBuf pCom = RxCommonBuf();
  RxTaskStatBuf tStat = RxTaskStatBuf();
  FbMem fbMem = FbMem();

  late SysJsonFile sysIni;
  late Mac_infoJsonFile macInfo;
  Tprtim_counterJsonFile counter = Tprtim_counterJsonFile();
  TprtfJsonFile tprtimIni = TprtfJsonFile();
  TprtimJsonFile tprtim2Ini = TprtimJsonFile();
  TprtrpJsonFile tprtim3Ini = TprtrpJsonFile();
  TprtsJsonFile tprtim4Ini = TprtsJsonFile();
  TprtssJsonFile tprtim5Ini = TprtssJsonFile();
  Tprtss2JsonFile tprtim6Ini = Tprtss2JsonFile();
  static AsciiCodec ascii = const AsciiCodec();
  List<TprMsg_t> tprMsgList =
      List<TprMsg_t>.filled(0, TprMsg(), growable: true);

  /// 初期化関数
  /// 引数:[tid] タスクID
  /// 戻り値：0 = Normal End
  ///      -1 = Error
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループまでの初期化処理とします。
  Future<int> printerStart(
      SendPort parentSendPort, int taskId, String homePath, int order) async {
    int ret = DrvPrnDef.PRN_NG;
    _parentSendPort = parentSendPort;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      myLog.logAdd(myTid, LogLevelDefine.error, "Task stat get error");
      return DrvPrnDef.PRN_NG;
    }
    tStat = xRet.object;

    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      myLog.logAdd(myTid, LogLevelDefine.error, "common get error");
      return DrvPrnDef.PRN_NG;
    }
    pCom = xRet.object;
    sysIni = pCom.iniSys;
    macInfo = pCom.iniMacInfo;

    fbMem = SystemFunc.readFbMem(null);

    ret = await drvMain(taskId, homePath, order);
    if (ret != DrvPrnDef.PRN_OK) {
      return DrvPrnDef.PRN_NG;
    }

    // タイマ起動 送受信処理をタイマ処理で行う。
    timerFunc = Timer.periodic(
        const Duration(milliseconds: 100), (timer) => _onTimer(timer));

    return DrvPrnDef.PRN_OK;
  }

  /// メイン関数
  /// 引数　：timer
  /// 戻り値：なし
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループ内の処理とします。
  /// 　⇒　回しっぱなしにするとプロセスが開放されないため、1処理毎にプロセスを開放する。
  Future<void> _onTimer(Timer timer) async {
    if (_isAbort) {
      // 中断
      timerFunc!.cancel();
      timerFunc = null;
      return;
    }
    if (_isStop) {
      return;
    }
    do {
      if ((await printerRcv())) {
        // コマンド送信はアイドル中にのみ行う。
        await printerSnd();
        break;
      }
    } while (true);
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "Loop out");
    }
  }

  /// プリンタからデータを受け取る.
  /// データが返ってくるまで停止する.(内部でループしている)
  /// 戻り値：false = 受信アイドル、またはエラー
  ///        true = データ受信中
  /// 関連tprxソース: drv_scan_init_plus.c - main()のうち、受信処理を抽出
  Future<bool> printerRcv() async {
    String errLog = "";
    PrintRet readRet = PrintRet();
    int readSiz = 0;
    int i;

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssMainLoop() start");
    }
    if ((hwResetFlg != 0) && (hwResetCnt < DrvPrnDef.HW_RESET_MAX)) {
      if (await tprtssCmdCreateData(
              CMD_ENUM.TPRTS_CMD_HW_RESET, 0, 0, 0, "", 1) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(
            myTid, LogLevelDefine.error, "tprtssMainLoop() CMD_HW_RESET error");
      } else {
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssMainLoop() CMD_HW_RESET exec reset_cnt:$hwResetCnt");
        }
        hwResetFlg = 0;
        hwResetCnt++;
        versionFlg = 0;
      }
    } else {
      if (hwResetLog == 0 && (hwResetCnt >= DrvPrnDef.HW_RESET_MAX)) {
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssMainLoop() CMD_HW_RESET not recovery");
        }
        tprtssEjTxt(DrvPrnDef.HW_ERROR, 0);
        hwResetLog = 1;
      }
    }

    tprtssReopen();
    if (hTprtDrv < 0) {
      myLog.logAdd(myTid, LogLevelDefine.error, "tprtssMainLoop() not open!!");
      return true;
    }
    await tprtssStartChk(0);

    readRet = ffiPtr.printerReadDevice(DrvPrnDef.READ_BUF_SIZ);
    if (0 <= readRet.result) {
      readSiz = readRet.readSize;
      if (readSiz > 0) {
        for (i = 0; i < readSiz; i++) {
          errLog += int.parse(readRet.readData[i]).toRadixString(16); //
        }
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssMainLoop() Found trash data : $errLog");
        }
      }
    }
    return true;
  }

  /// 関連tprxソース: drv_scan_init_plus.c - main()のうち、コマンド受付処理を抽出
  Future<void> printerSnd() async {
    if (tprMsgList.isNotEmpty) {
      await drvPrintMidCheck(tprMsgList[0]);
      tprMsgList.removeAt(0);
    }
  }

  /// メイン関数
  /// 引数:[taskId] タスクID
  /// 		[homePath] TPRXホームパス
  /// 		[order] タスクオーダー（プリンターの種類）
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - main()のうち、コマンド受付処理を抽出
  Future<int> drvMain(int taskId, String homePath, int order) async {
    bool ret = true;
    String mainFncName = "tprtss";

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "$mainFncName start");
    }
    myTid = taskId;
    sHomePath = homePath;
    devOrder = taskOrder = order;

    Recog().recog_type_on(); // QCJC

    // RM-5900タイプ判定
    if (CmCksys.cmRm5900System() == 1) {
      rm59Flg = 1;
    }

    devOrder = taskOrder;
    switch (devOrder) {
      case DrvPrnDef.DESK_PRINTER:
        CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_J);
        shareJ = shareFlg = ret.value;
        shareC = 0;
        break;
      case DrvPrnDef.QCJC_PRINTER:
        CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_C);
        shareJ = shareFlg = 0;
        shareC = ret.value;
        break;
      case DrvPrnDef.COUPON_PRINTER:
        CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_J);
        shareJ = ret.value;
        CompetitionIniRet ret2 = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_C);
        shareC = ret2.value;
        if (shareJ == 0 && shareC == 0) {
          shareFlg = 0;
        } else {
          shareFlg = 1;
        }
        break;
      default:
        shareFlg = 0;
        break;
    }

    ret = await tprtssInit(sHomePath);
    if (((ret == false) && (devOrder != DrvPrnDef.COUPON_PRINTER)) ||
        ((shareJ != 0 || shareC != 0) &&
            (devOrder == DrvPrnDef.COUPON_PRINTER))) {
      fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_NOT_ACT;
      TprLib().tprNoReady(myDid, myTid);
      myLog.logAdd(
          myTid, LogLevelDefine.error, "$mainFncName TprNoReady exit!!");
      return DrvPrnDef.PRN_NG;
    } else {
      fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MNG_SET_OK;
    }

    if (hwResetFlg != 0) {
      for (hwResetCnt = 0; hwResetCnt < 3; hwResetCnt++) {
        if (await tprtssCmdCreateData(
                CMD_ENUM.TPRTS_CMD_HW_RESET, 0, 0, 0, "", 0) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(
              myTid, LogLevelDefine.error, "main() CMD_HW_RESET error");
        } else {
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal,
                "main() CMD_HW_RESET exec reset_cnt:$hwResetCnt");
            hwResetFlg = 0;
          }
        }

        sleep(const Duration(seconds: 1));

        if (tprtssOpen() == DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error, "main() tprtss_open error");
          continue;
        }
        if (hTprtDrv < 0) {
          myLog.logAdd(myTid, LogLevelDefine.error, "main() not open!!");
          continue;
        }
        await tprtssStartChk(0);
        if (hwResetFlg != 0) {
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal,
                "main() CMD_HW_RESET recovery cnt:$hwResetCnt");
          }
          tprtssEjTxt(DrvPrnDef.HW_RECOVER, hwResetCnt + 1);
          break;
        }
      }
      if (hwResetFlg != 0) {
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(
              myTid, LogLevelDefine.normal, "main() CMD_HW_RESET not recovery");
        }
        tprtssEjTxt(DrvPrnDef.HW_ERROR, 0);
        hwResetLog = 1;
      }
    }
    TprLib().tprReady(myDid, myTid);
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "$mainFncName TprReady");
    }

    if (!(!ret && (devOrder == DrvPrnDef.COUPON_PRINTER))) {
      await tprtssStatus();
    }

    /* TODO:共有メモリ更新 */
    if (devOrder == DrvPrnDef.COUPON_PRINTER) {
      if (!ret) {
        retryFlg = 1;
        pCom.kitchen_prn1_run = 2;
      } else {
        pCom.kitchen_prn1_run = 1;
      }
    } else {
      if (shareFlg == 1) {
        pCom.kitchen_prn1_run = 1;
      }
    }

    if (((rpdFlg == DrvPrnDef.RPCONNECT2) ||
            (rpdFlg == DrvPrnDef.RPCONNECT3)) &&
        (nearEndCheck == 1)) {
      tprtssGetStatus(1);
      tprtssMCounter(148);
    }

    return DrvPrnDef.PRN_OK;
  }

  /// アプリからの送信データを選別する
  /// 引数:[msg] アプリからの送信データ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_main_roop()のうち、コマンド受付処理を抽出
  Future<int> drvPrintMidCheck(TprMsg msg) async {
    int pState = DrvPrnDef.TPRT_PSTAT_RCV;
    int result = 0;

    // Check message kind
    switch (msg.devreq2.mid) {
      case TprMidDef.TPRMID_DEVREQ: // Request from APL
        if ((devOrder == DrvPrnDef.COUPON_PRINTER) && retryFlg == 1) {
          break;
        }
        if (await tprtssStartChk(1) == DrvPrnDef.PRN_NG) {
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(
                myTid, LogLevelDefine.normal, "Get Kind STATUS(Start Only)");
          }
          await tprtssStatus();
          if (statusErr != DrvPrnDef.PRN_OK) {
            tprtssReply(result, statusVal.join(""), msg, 1);
            break;
          }
        }
        await tprtssDevAck(pState, msg);
        if (cutErrFlg == 1) {
          if (await tprtssInitCmd(1, densityVal, 1) == DrvPrnDef.PRN_OK) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssMainLoop() cuterr init error");
          }
          cutErrFlg = 0;
          sleep(const Duration(microseconds: 500000));
        }
        break;
      case TprMidDef.TPRMID_SYSNOTIFY: // sysnotify
        if (msg.sysnotify.mode != TprStatDef.TPRTST_POWEROFF) {
          break; // Not power-off
        }
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssMainLoop() SYSNOTIFY:TPRTST_POWEROFF [$allocCnt][$freeCnt]");
        }
        break;
      // tprtss_close();
      // TprSysNotifyAck( hSysPipe, myDid, myTid );

      case TprMidDef.TPRMID_SYSFAIL: // System fail
        switch (pState) {
          // process state
          case DrvPrnDef.TPRT_PSTAT_RCV: // receiving state
            // TprSysFailAck( hSysPipe );    // ack for SYS
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssMainLoop() SYSFAIL PSTAT_RCV!!");
            }
            pState = DrvPrnDef.TPRT_PSTAT_SYSFAIL;
            break;
          case DrvPrnDef.TPRT_PSTAT_SYSFAIL: // SYSFAIL state
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssMainLoop() SYSFAIL PSTAT_SYSFAIL!!");
            }
            break;
          default:
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssMainLoop() SYSFAIL Unknown Switch pState[$pState]");
            }
            break;
        }
        break;
      default:
        break;
    }
    return DrvPrnDef.PRN_OK;
  }

  /// プリンタステータス別に処理を実行する
  /// 引数:[pState] プリンタステータス（1:INIT  2:Receive  999:Error）[in]
  ///     [readbuf] 受信データ（プリンタ状態）[in]
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_DevAck
//  Future<void> tprtssDevAck(int pState, String readBuf) async {
  Future<void> tprtssDevAck(int pState, TprMsg_t msg) async {
    int result = 0;
    String filepath = "";
    TprtssCmdMsg tprtssMsg = TprtssCmdMsg(); /* printer message */
//     TprMsg_t tprMsg = TprMsg();
//     TprMsgDevReq2_t tprmsgReq2 = TprMsgDevReq2();
//
//
//     TprIpcCalc.Set_TprMsg(readBuf, tprMsg, 0);
//     TprIpcCalc.Set_TprMsgDevReq2(readBuf, tprmsgReq2, 0);

    if (usbFlg == 1) {
      usbFlg = 0;
    }
    switch (pState) {
      case DrvPrnDef.TPRT_PSTAT_RCV: // receiving statue
        if (shareFlg != 0) {
          switch (msg.devreq2.src) {
            case Tpraid.TPRAID_PRN:
              taskOrder = DrvPrnDef.DESK_PRINTER;
              receiptWide = DrvPrnDef.SII_LTPF247_RECIPT_WIDE;
              wFlg = 1;
              break;
            case Tpraid.TPRAID_QCJC_C_PRN:
              taskOrder = DrvPrnDef.DESK_PRINTER;
              receiptWide = DrvPrnDef.SII_LTPF247_RECIPT_WIDE;
              wFlg = 2;
              break;
            case Tpraid.TPRAID_KITCHEN1_PRN:
              taskOrder = DrvPrnDef.COUPON_PRINTER;
              receiptWide = DrvPrnDef.SII_LTPF347_RECIPT_WIDE;
              wFlg = 3;
              break;
            default:
              taskOrder = DrvPrnDef.DESK_PRINTER;
              receiptWide = DrvPrnDef.SII_LTPF247_RECIPT_WIDE;
              wFlg = 1;
              break;
          }
          tprtssCheckSwDip();
          await tprtssInitCmd(1, densityVal, 0);
        }
        setTprtssCmdMsg(msg.devreq2, tprtssMsg);
        switch (tprtssMsg.kind) {
          case DrvPrnDef.TPRT_KIND_CMD: // printer command
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssDevAck() KIND_CMD [${tprtssMsg.cmd}]");
            }
            result = await tprtssCmd(tprtssMsg);
            if ((result != DrvPrnDef.PRN_OK) &&
                (statusErr == DrvPrnDef.PRN_OK)) {
              await tprtssSetStatus(DrvPrnDef.PRN_NG, 0, 2, 0);
            }
            if (statusErr != DrvPrnDef.PRN_OK) {
              tprtssReply(statusErr, statusVal.join(""), msg, 1);
            }
            if (msg.devreq2.result == 0) {
              tprtssConf(result, msg.devreq2);
            }
            break;
          case DrvPrnDef.TPRT_KIND_ECMD: // printer command with data transfer
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssDevAck() KIND_CMD [${tprtssMsg.cmd}]");
            }
            if ((result = await tprtssCmd(tprtssMsg)) != DrvPrnDef.PRN_OK) {
              myLog.logAdd(myTid, LogLevelDefine.error,
                  "tprtssDevAck() KIND_ECMD tprtssCmd error");
              if (tprtssMsg.cmd == "B") {
                filepath = tprtssMsg.param.sublist(tprtssMsg.length - 1).join();
                /*
								remove(filepath);
								 */
              } else {
                tprtssShmCtrl(0, 0, tprtssMsg.param);
              }
            } else {
              if ((tprtssMsg.cmd == "B") || (tprtssMsg.cmd == "W")) {
                filepath = tprtssMsg.param.sublist(tprtssMsg.length - 1).join();
              }
              switch (tprtssMsg.cmd) {
                case "K":
                  result = DrvPrnDef.PRN_OK;
                  break;
                case "W":
                  result = await tprtssDownload(filepath);
                  break;
                default:
                  result = await tprtssData(filepath, tprtssMsg.param[0],
                      tprtssMsg.cmd, tprtssMsg.printData.split(""));
                  if (tprtssMsg.cmd == "B") {
                    /*
										remove(filepath);
										 */
                  } else {
                    if (result != DrvPrnDef.PRN_OK) {
                      tprtssShmCtrl(0, 0, tprtssMsg.param);
                    }
                  }
                  break;
              }
            }
            if ((result == DrvPrnDef.PRN_NG) &&
                (statusErr == DrvPrnDef.PRN_OK)) {
              await tprtssSetStatus(DrvPrnDef.PRN_NG, 0, 2, 0);
            }
            if (statusErr != DrvPrnDef.PRN_OK) {
              tprtssReply(statusErr, statusVal.join(""), msg, 1);
            }
            if (msg.devreq2.result == 0) {
              tprtssConf(result, msg.devreq2);
            }
            break;
          case DrvPrnDef.TPRT_KIND_STATUS:
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(
                  myTid, LogLevelDefine.normal, "tprtssDevAck() KIND_STATUS");
            }
            result = await tprtssStatus();
            tprtssReply(result, statusVal.join(""), msg, 0); // reply
            break;
          case DrvPrnDef.TPRT_KIND_PORTINIT: // parallel port initialize
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(
                  myTid, LogLevelDefine.normal, "tprtssDevAck() KIND_PORTINIT");
            }
            tprtssConf(DrvPrnDef.TPRT_RTN_PINIT, msg.devreq2); // confirm
            break;
          case DrvPrnDef.TPRT_KIND_PARASTATUS: // get status
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssDevAck() KIND_PARASTATUS");
            }
            result = await tprtssStatus();
            if (result != DrvPrnDef.PRN_OK) {
              result = DrvPrnDef.PRN_OK;
              tprtssReply(result, statusVal.join(""), msg, 0);
            } else {
              statusVal[0] = 0x98;
              result = DrvPrnDef.PRN_OK;
              tprtssReply(result, statusVal.join(""), msg, 2);
            }
            break;
          case DrvPrnDef.TPRT_KIND_FLAGSTATUS: // get flag status
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssDevAck() KIND_FLAGSTATUS");
            }
            break;
          default:
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssDevAck() Unknown Switch kind [${tprtssMsg.kind}]");
            }
            break;
        }
        break;
      case DrvPrnDef.TPRT_PSTAT_SYSFAIL:
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(
              myTid, LogLevelDefine.normal, "tprtssDevAck() PSTAT_SYSFAIL");
        }
        break;
      default:
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssDevAck() Unknown Switch pState in DEVREQ [$pState]");
        }
        break;
    }
  }

  /// スタートフラグチェック処理
  /// 引数:[flg] デバイスシーケンスNo
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_start_chk
  Future<int> tprtssStartChk(int flg) async {
    if (flg == 0) {
      await tprtssStatus();
    }
    if (startFlg == 0) {
      if (flg != 0) {
        await tprtssStatus();
      }
      wFlg = 0;
      if (await tprtssCheckSwDip() == DrvPrnDef.PRN_NG) {
        return DrvPrnDef.PRN_NG;
      }
      if (await tprtssInitCmd(1, densityVal, 0) == DrvPrnDef.PRN_NG) {
        return DrvPrnDef.PRN_NG;
      }
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(
            myTid, LogLevelDefine.normal, "tprtssStartChk() StartFlg ON");
      }
      startFlg = 1;
    }
    return DrvPrnDef.PRN_OK;
  }

  /// プリンタコマンドを生成しプリンタに送信
  /// 引数:[typ] コマンドタイプ
  ///     [xSiz] X軸サイズ
  ///     [ySiz] Y軸サイズ
  ///     [no] X位置
  ///     [data] 受信データ（プリンタ状態）[in]	//uchar *
  ///     [dataLen] 受信データ長
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_cmd_create_data
  Future<int> tprtssCmdCreateData(CMD_ENUM typ, int xSiz, int ySiz, int no,
      String data, int dataLen) async {
    String cmd = "";
    int len = 0;
    int resFlag = 0;

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(0, LogLevelDefine.normal,
          "tprtssCmdCreateData[$typ][$xSiz][$ySiz][$no][$dataLen]");
    }
    switch (typ) {
      case CMD_ENUM.TPRTS_CMD_RESET:
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "@"; // 0x40
        resFlag = 1;
        break;
      case CMD_ENUM.TPRTS_CMD_CSPC0:
        cmd = DrvPrnDef.CMD_ESC;
        cmd += " "; // 0x20
        cmd += "\x00";
        break;
      case CMD_ENUM.TPRTS_CMD_LSPC6:
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "3"; // 0x33
        cmd += "\x36";
        break;
      case CMD_ENUM.TPRTS_CMD_SJIS:
        cmd = DrvPrnDef.CMD_FS;
        cmd += "C"; // 0x43
        cmd += "\x01";
        break;
      case CMD_ENUM.TPRTS_CMD_NOTRES:
        cmd = DrvPrnDef.CMD_DC2;
        cmd += "e"; // 0x65
        cmd += latin1.decode([(xSiz & 0xff)]);
        break;
      case CMD_ENUM.TPRTS_CMD_LMSB:
        cmd = DrvPrnDef.CMD_DC2;
        cmd += "="; // 0x3d
        cmd += "\x01";
        break;
      case CMD_ENUM.TPRTS_CMD_CHAR_REG:
        return tprtssCmdCreateDataCharReg(xSiz, data, dataLen);
      case CMD_ENUM.TPRTS_CMD_CHAR_PRINT: // stamp select */
        cmd = DrvPrnDef.CMD_DC2;
        cmd += "L"; // 0x4c
        cmd += "\x00";
        break;
      case CMD_ENUM.TPRTS_CMD_CUT:
        cmd = DrvPrnDef.CMD_GS;
        cmd += "V"; // 0x56
        cmd += "\x01"; // partial
        resFlag = 1;
        break;
      case CMD_ENUM.TPRTS_CMD_FULLCUT:
        cmd = DrvPrnDef.CMD_GS;
        cmd += "V"; // 0x56
        cmd += "\x00"; // full
        resFlag = 1;
        break;
      case CMD_ENUM.TPRTS_CMD_PALSE:
        cmd = DrvPrnDef.CMD_ESC;
        cmd = "p"; // 0x70
        cmd += latin1.decode([xSiz]);
        cmd += latin1.decode([ySiz]);
        cmd += latin1.decode([no]);
        break;
      case CMD_ENUM.TPRTS_CMD_NVBIT_PRINT:
        if (ySiz != 0) {
          cmd = DrvPrnDef.CMD_GS;
          cmd += "(";
          cmd += "L";
          cmd += "\x07";
          cmd += "\x00";
          cmd += "\x30"; //"48"
          cmd += "\x46"; //"70"
          cmd += latin1.decode([(31 + no)]);
          cmd += latin1.decode([(31 + no)]);
          cmd += "\x01";
          cmd += "\x01";
          cmd += latin1.decode([xSiz]);
        } else {
          cmd = DrvPrnDef.CMD_GS;
          cmd += "(";
          cmd += "L";
          cmd += "\x06";
          cmd += "\x00";
          cmd += "\x30"; //"48"
          cmd += "\x45"; //"69"
          cmd += latin1.decode([(31 + no)]);
          cmd += latin1.decode([(31 + no)]);
          cmd += "\x01";
          cmd += "\x01";
        }
        break;
      case CMD_ENUM.TPRTS_CMD_FEED: // ok
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "J"; // 0x4a
        cmd += latin1.decode([xSiz]);
        break;
      case CMD_ENUM.TPRTS_CMD_BFEED:
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "j";
        cmd += latin1.decode([xSiz]);
        break;
      case CMD_ENUM.TPRTS_CMD_DENSITY:
        cmd = DrvPrnDef.CMD_DC2;
        cmd += "\x7e"; // '~'?
        if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
          cmd += latin1.decode([DrvPrnDef.TPRTSS_DENSITY_80]);
        } else {
          if ((rpdFlg == DrvPrnDef.RPCONNECT) ||
              (rpdFlg == DrvPrnDef.RPCONNECT4)) {
            if (xSiz < DrvPrnDef.TPRTSS_DENSITY_RPD_0) {
              xSiz = DrvPrnDef.TPRTSS_DENSITY_RPD_0;
            }
            if (xSiz > DrvPrnDef.TPRTSS_DENSITY_RPD_3) {
              xSiz = DrvPrnDef.TPRTSS_DENSITY_RPD_3;
            }
          } else {
            if (xSiz < DrvPrnDef.TPRTSS_DENSITY_0) {
              xSiz = DrvPrnDef.TPRTSS_DENSITY_0;
            }
            if (xSiz > DrvPrnDef.TPRTSS_DENSITY_3) {
              xSiz = DrvPrnDef.TPRTSS_DENSITY_3;
            }
          }
          cmd += latin1.decode([xSiz]);
        }
        break;
      case CMD_ENUM.TPRTS_CMD_ERR_THROW:
        cmd = DrvPrnDef.CMD_GS;
        cmd += "a"; // 0x61
        if (xSiz == 1) {
          cmd += "\x1f";
        } else {
          cmd += "\x00";
        }
        break;
      case CMD_ENUM.TPRTS_CMD_BMP:
        return tprtssCmdCreateDataBmp(xSiz, data, dataLen);
      case CMD_ENUM.TPRTS_CMD_BARCODE:
        return tprtssCmdCreateDataBarcode(xSiz, ySiz, data, dataLen);
      case CMD_ENUM.TPRTS_CMD_LINE:
        return tprtssCmdCreateDataLine(xSiz, ySiz, no, data, dataLen);
      case CMD_ENUM.TPRTS_CMD_INTERNATIONAL:
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "R";
        cmd += latin1.decode([xSiz]);
        break;
      case CMD_ENUM.TPRTS_CMD_CODETABLE:
        cmd += DrvPrnDef.CMD_ESC;
        cmd += "t";
        cmd += latin1.decode([xSiz]);
        break;
      case CMD_ENUM.TPRTS_CMD_FONT:
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "M";
        cmd += latin1.decode([xSiz]);
        break;
      case CMD_ENUM.TPRTS_CMD_KANJI:
        cmd = DrvPrnDef.CMD_FS;
        cmd += "!";
        cmd += "\x01";
        break;
      case CMD_ENUM.TPRTS_CMD_DLBMP_PRINT:
        cmd = DrvPrnDef.CMD_GS;
        cmd += "/";
        cmd += "\x00";
        break;
      case CMD_ENUM.TPRTS_CMD_LOGO_CENTERING:
        cmd = DrvPrnDef.CMD_GS;
        cmd += "L";
        cmd += "\x14";
        cmd += "\x00";
        break;
      case CMD_ENUM.TPRTS_CMD_CENTERING_CANCEL:
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "a";
        cmd += "\x00";
        break;
      case CMD_ENUM.TPRTS_CMD_HW_RESET:
        cmd = DrvPrnDef.CMD_DC2;
        cmd += "@";
        break;
      case CMD_ENUM.TPRTS_CMD_MARGIN_RESET:
        cmd = DrvPrnDef.CMD_GS;
        cmd += "L"; // 左マージン初期化
        cmd += "\x00";
        cmd += "\x00";
        break;
      default:
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData not support type[$typ]");
        return DrvPrnDef.PRN_NG;
    }
    if (cmd.isNotEmpty) {
      if (DrvPrnDef.DISP_BUFF) {
        dispBuff("tprtss_write 11", cmd, cmd.length);
      }
      if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
        len = cmd.length;
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData tprtss_write error[$typ] [$len][$resFlag]");
        return DrvPrnDef.PRN_NG;
      }
      if ((typ == CMD_ENUM.TPRTS_CMD_RESET) ||
          (typ == CMD_ENUM.TPRTS_CMD_HW_RESET)) {
        sleep(const Duration(microseconds: DrvPrnDef.TPRTSS_RESET_WAITTIME));
      }
    }

    return DrvPrnDef.PRN_OK;
  }

  /// 初期化処理
  /// 引数:[pHomePath] TPRXホームパス
  /// 戻り値：true = Normal End
  ///       false = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_init
  Future<bool> tprtssInit(String pHomePath) async {
    String sDevName = "";
    String sTmpBuf = "";
    String bootp = "";
    int typeRet = 0;
    int ret = 0;

    myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssInit() start");

    iDrvNo = (myTid >> bitShift_Tid) & 0x000000FF;
    switch (taskOrder) {
      case DrvPrnDef.DESK_PRINTER:
        savePortNm = PlusDrvChk.PLUS_TPRTF;
        myDid = TprDidDef.TPRDIDRECEIPT3;
        break;
      case DrvPrnDef.QCJC_PRINTER:
        savePortNm = PlusDrvChk.PLUS_TPRTF2;
        myDid = TprDidDef.TPRDIDRECEIPT4;
        break;
      case DrvPrnDef.COUPON_PRINTER:
        savePortNm = PlusDrvChk.PLUS_CPNPRN;
        myDid = TprDidDef.TPRDIDRECEIPT5;
        break;
      default:
        break;
    }
    rctTbCut = 0;

    sDevName = "drivers$iDrvNo";

    // CAPM/IFM or RP-D10
    rpdFlg = 0;
    switch (taskOrder) {
      case DrvPrnDef.DESK_PRINTER:
        if (CmCksys.cmTprtrpdFileChk() != false) {
          typeRet = await CmCksys().cmRPType(CmSys.TPRTRP_DESK);

          if (typeRet == 1) {
            rpdFlg = DrvPrnDef.RPCONNECT;
            myLog.logAdd(myTid, LogLevelDefine.normal, "Desktop RP-D10 detect");
          } else if (typeRet == 2) {
            rpdFlg = DrvPrnDef.RPCONNECT2;
            myLog.logAdd(myTid, LogLevelDefine.normal, "Desktop RP-E11 detect");
          } else if (typeRet == 3) {
            rpdFlg = DrvPrnDef.RPCONNECT3;
            myLog.logAdd(myTid, LogLevelDefine.normal, "Desktop PT06 detect");
          } else {
            myLog.logAdd(
                myTid, LogLevelDefine.normal, "Desktop Unknown RP Type");
          }
        } else {
          myLog.logAdd(myTid, LogLevelDefine.normal, "Desktop CAPM detect");
          rpdFlg = 0;
        }
        break;
      case DrvPrnDef.QCJC_PRINTER:
        if (CmCksys.cmTprtrpd2FileChk() != false) {
          typeRet = await CmCksys().cmRPType(CmSys.TPRTRP_TOWER);
          if (typeRet == 1) {
            rpdFlg = DrvPrnDef.RPCONNECT;
            myLog.logAdd(myTid, LogLevelDefine.normal, "Tower RP-D10 detect");
          } else if (typeRet == 2) {
            rpdFlg = DrvPrnDef.RPCONNECT2;
            myLog.logAdd(myTid, LogLevelDefine.normal, "Tower RP-E11 detect");
          } else {
            myLog.logAdd(myTid, LogLevelDefine.normal, "Tower Unknown RP Type");
          }
        } else {
          myLog.logAdd(myTid, LogLevelDefine.normal, "Tower CAPM detect");
          rpdFlg = 0;
        }
        break;
      case DrvPrnDef.COUPON_PRINTER:
        rpdFlg = DrvPrnDef.RPCONNECT;
        myLog.logAdd(myTid, LogLevelDefine.normal, "Coupon Printer RP-D10");
        break;
      default:
        break;
    }

    sTmpBuf = await tprtssIniFileGet();
    if (sTmpBuf.isEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssInit() TprLibGetIni($bootp, $sDevName) error");
      return false;
    }

    hC1System = 0;
    if (RecogValue.RECOG_NO !=
        (await Recog().recogGet(
                myTid, RecogLists.RECOG_HC1_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result) {
      hC1System = 1;
    }

    drwMData = DrvPrnDef.DRW_DEF_NUM;
    drwT1Data = DrvPrnDef.DRW_DEF_T1;
    drwT2Data = DrvPrnDef.DRW_DEF_T2;

    // sys.iniから自タスクの設定ファイル名を取得
    ret = await tprtssMyIniGet(sTmpBuf);
    if (ret != 0) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInit() TprLibGetIni error");
    }
    switch (taskOrder) {
      case DrvPrnDef.DESK_PRINTER:
        CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_RCT_DNS,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_J);
        densityVal = ret.value;

        CompetitionIniRet ret2 = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_J);
        rctTbCut = ret2.value;
        receiptWide = DrvPrnDef.SII_LTPF247_RECIPT_WIDE;
        break;
      case DrvPrnDef.QCJC_PRINTER:
        CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_RCT_DNS,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_C);
        densityVal = ret.value;
        CompetitionIniRet ret2 = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_C);
        rctTbCut = ret2.value;
        receiptWide = DrvPrnDef.SII_LTPF247_RECIPT_WIDE;
        break;
      case DrvPrnDef.COUPON_PRINTER: // TBD
        CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_RCT_DNS,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_J);
        densityVal = ret.value;
        CompetitionIniRet ret2 = await CompetitionIni.competitionIniGet(
            myTid,
            CompetitionIniLists.COMPETITION_INI_RCT_TB_CUT,
            CompetitionIniType.COMPETITION_INI_GETSYS_JC_J);
        rctTbCut = ret2.value;
        receiptWide = DrvPrnDef.SII_LTPF347_RECIPT_WIDE;
        break;
      default:
        break;
    }

    // RP-E11 or PT06
    if ((rpdFlg == DrvPrnDef.RPCONNECT2) ||
        (rpdFlg == DrvPrnDef.RPCONNECT3) ||
        (rpdFlg == DrvPrnDef.RPCONNECT4) ||
        (modelId == "\x25")) {
      noteCount = 0;
      checkFail = 0;

      noteLen = macInfo.printer.nearend_note;
      if (noteLen == 0) {
        // iniの設定が０の場合、ターミナルの設定を使う
        noteLen = pCom.dbTrm.nearendNote;
        specTerm = 1;
      }
      noteCount = noteLen * 10 * 8 ~/ 100;
      if (((noteLen * 10 * 8) % 100).toInt() > 0) {
        noteCount++;
      }

      await counter.load();
      tprtMaxFail = macInfo.printer.nearend_count;

      checkFail = counter.tran.nearend_check_fail;

      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssInit() [RP-E11] read checkFail from ini [${checkFail & 0x03}/$tprtMaxFail]");
      }
    }

    switch (taskOrder) {
      case DrvPrnDef.DESK_PRINTER:
        sTmpBuf = "$pHomePath/${InterfaceDefine.TPRT_FTOK_PATHNAME}";
        break;
      case DrvPrnDef.QCJC_PRINTER:
        sTmpBuf = "$pHomePath/${InterfaceDefine.TPRT2_FTOK_PATHNAME}";
        break;
      case DrvPrnDef.COUPON_PRINTER: // TBD
        sTmpBuf = "$pHomePath/${InterfaceDefine.TPRT3_FTOK_PATHNAME}";
        break;
      default:
        break;
    }

    if (tprtssOpen() == DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInit() tprtss_open error");
      return false;
    }

    wFlg = 0;
    if (await tprtssCheckSwDip() == DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInit() tprtss_check_swdip error");
    } else {
      if (await tprtssInitCmd(1, densityVal, 1) == DrvPrnDef.PRN_OK) {
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssInit() tprtss_init_cmd StartFlg ON!!");
        }
        startFlg = 1;
      }
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssInit() end");
    }
    return true;
  }

  /// プリンタへの初期設定
  /// 引数:[densityFlg] 印字密度設定フラグ
  ///     [densityVal] 印字密度設定値
  ///     [resetFlg] プリンタリセットフラグ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_init_cmd
  Future<int> tprtssInitCmd(
      int densityFlg, int densityVal, int resetFlg) async {
    int val;

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssInitCmd() [$densityFlg][$densityVal][$resetFlg]");
    }
    if (resetFlg == 1) {
      if (await tprtssReset() == DrvPrnDef.PRN_NG) {
        myLog.logAdd(
            myTid, LogLevelDefine.error, "tprtssInitCmd() tprtssReset error");
        return DrvPrnDef.PRN_NG;
      }
    }
    if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_CSPC0, 0, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInitCmd() CMD_CSPC0 error");
      return DrvPrnDef.PRN_NG;
    }
    if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_LSPC6, 0, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInitCmd() CMD_LSPC6 error");
      return DrvPrnDef.PRN_NG;
    }
    if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_SJIS, 0, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInitCmd() CMD_SJIS error");
      return DrvPrnDef.PRN_NG;
    }
    if (await tprtssCmdCreateData(
            CMD_ENUM.TPRTS_CMD_INTERNATIONAL, 8, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssInitCmd() CMD_INTERNATIONAL error");
      return DrvPrnDef.PRN_NG;
    }
    if ((rpdFlg == DrvPrnDef.RPCONNECT) ||
        (rpdFlg == DrvPrnDef.RPCONNECT2) ||
        (rpdFlg == DrvPrnDef.RPCONNECT3)) {
      if (await tprtssCmdCreateData(
              CMD_ENUM.TPRTS_CMD_CODETABLE, 1, 0, 0, "", 0) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(
            myTid, LogLevelDefine.error, "tprtssInitCmd() CMD_CODETABLE error");
        return DrvPrnDef.PRN_NG;
      }
    } else {
      if (await tprtssCmdCreateData(
              CMD_ENUM.TPRTS_CMD_CODETABLE, 0xfe, 0, 0, "", 0) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(
            myTid, LogLevelDefine.error, "tprtssInitCmd() CMD_CODETABLE error");
        return DrvPrnDef.PRN_NG;
      }
    }
    if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_FONT, 1, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInitCmd() CMD_FONT error");
      return DrvPrnDef.PRN_NG;
    }
    if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_KANJI, 1, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInitCmd() CMD_KANJI error");
      return DrvPrnDef.PRN_NG;
    }
    if (densityFlg > 0) {
      if (rpdFlg == DrvPrnDef.RPCONNECT) {
        switch (densityVal) {
          case 0:
            val = DrvPrnDef.TPRTSS_DENSITY_RPD_0;
            break;
          case 1:
            val = DrvPrnDef.TPRTSS_DENSITY_RPD_1;
            break;
          case 2:
            val = DrvPrnDef.TPRTSS_DENSITY_RPD_2;
            break;
          case 3:
            val = DrvPrnDef.TPRTSS_DENSITY_RPD_3;
            break;
          default:
            val = DrvPrnDef.TPRTSS_DENSITY_RPD_1;
            break;
        }
      } else {
        switch (densityVal) {
          case 0:
            val = DrvPrnDef.TPRTSS_DENSITY_0;
            break;
          case 1:
            val = DrvPrnDef.TPRTSS_DENSITY_1;
            break;
          case 2:
            val = DrvPrnDef.TPRTSS_DENSITY_2;
            break;
          case 3:
            val = DrvPrnDef.TPRTSS_DENSITY_3;
            break;
          default:
            val = DrvPrnDef.TPRTSS_DENSITY_1;
            break;
        }
      }
      densityVal = densityVal;
      if (await tprtssCmdCreateData(
              CMD_ENUM.TPRTS_CMD_DENSITY, val, 0, 0, "", 0) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssInitCmd() CMD_DENSITY[$val] error");
        return DrvPrnDef.PRN_NG;
      }
    }
    if (await tprtssCmdCreateData(
            CMD_ENUM.TPRTS_CMD_ERR_THROW, 1, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssInitCmd() CMD_ERR_THROW error");
      return DrvPrnDef.PRN_NG;
    }

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssInitCmd() end");
    }
    if (resetFlg == 1) {
      if (initFlg == 1) {
        initFlg = 1;
      }
    }

    return DrvPrnDef.PRN_OK;
  }

  /// コマンド毎に印字処理を振り分け
  /// 引数:[tprtssMsg] プリンタ状態　[in]
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_cmd
  Future<int> tprtssCmd(TprtssCmdMsg tprtssMsg) async {
    String data = "";
    String tmpData = "";
    int logoFlg = 0;
    int cutType = 0;
    int rctCutType = 0;

    statusErr = DrvPrnDef.PRN_OK;

    /* TODO:共有メモリ */
    switch (taskOrder) {
      case DrvPrnDef.DESK_PRINTER:
        rctCutType = pCom.iniMacInfo.printer.rct_cut_type;
        break;
      case DrvPrnDef.QCJC_PRINTER:
        //rctCutType = combuf.ini_macinfo_JC_C.rctCutType;
        break;
      case DrvPrnDef.COUPON_PRINTER:
        rctCutType = 0;
        break;
      default:
        break;
    }

    switch (tprtssMsg.cmd) {
      case "T": // Cut Command
        if (await tprtssPrintGo() == DrvPrnDef.PRN_NG) {
          myLog.logAdd(
              myTid, LogLevelDefine.error, "tprtssCmd() T tprtssPrintGo error");
          return DrvPrnDef.PRN_NG;
        }
        if (await tprtssCutPrint(
                tprtssMsg.param[0].codeUnitAt(0), 0, 1, rctCutType) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() T tprtssCutPrint[${tprtssMsg.param[0]}] error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "F": // Drw Kick Command
        if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_PALSE, drwMData,
                drwT1Data, drwT2Data, "", 0) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() F CMD_PALSE[$drwMData][$drwT1Data][$drwT2Data] error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "S": // Print Go
        if (await tprtssPrintGo() == DrvPrnDef.PRN_NG) {
          myLog.logAdd(
              myTid, LogLevelDefine.error, "tprtssCmd() S tprtssPrintGo error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "L": // Logo Data Print
        tmpData = tprtssMsg.param[0];
        if (tmpData.length > 3) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() L size0[${tmpData.length}][${tprtssMsg.param[0]}] error");
          return DrvPrnDef.PRN_NG;
        }
        data = tmpData;
        tmpData = tprtssMsg.param[1];
        if (tmpData.length > 3) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() L size0[${tmpData.length}][${tprtssMsg.param[1]}] error");
          return DrvPrnDef.PRN_NG;
        }
        data += tmpData;
        if (tprtssDataSave(4, data.split(""), data.length) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() L tprtssDataSave[${data.length}] error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "C": // Cut After Rogo Print
        if (await tprtssPrintGo() == DrvPrnDef.PRN_NG) {
          myLog.logAdd(
              myTid, LogLevelDefine.error, "tprtssCmd() C tprtssPrintGo error");
          return DrvPrnDef.PRN_NG;
        }
        logoFlg = 1;
        if (rctTbCut == 1) {
          if (rctCutType == 0) {
            rctCutType = 1;
            /* TODO:共有メモリ更新 */
            switch (taskOrder) {
              case DrvPrnDef.DESK_PRINTER:
                pCom.iniMacInfo.printer.rct_cut_type = 1;
                break;
              case DrvPrnDef.QCJC_PRINTER:
                //combuf.ini_macinfo_JC_C.rctCutType = 1;
                break;
              case DrvPrnDef.COUPON_PRINTER:
                pCom.iniMacInfo.printer.rct_cut_type = 0;
                break;
              default:
                break;
            }
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(
                  myTid, LogLevelDefine.normal, "Change rctCutType 0 -> 1");
            }
          }
          logoFlg = -1;
        }
        if ((devOrder == DrvPrnDef.DESK_PRINTER) && shareJ != 0) {
          logoFlg = -1;
        }
        if ((devOrder == DrvPrnDef.QCJC_PRINTER) && shareC != 0) {
          logoFlg = -1;
        }
        if (await tprtssCutPrint(tprtssMsg.param[0].codeUnitAt(0),
                tprtssMsg.param[1].codeUnitAt(0), logoFlg, rctCutType) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() C tprtssCutPrint[${tprtssMsg.param[0]}][${tprtssMsg.param[1]}] error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "M": // cut
        if (await tprtssPrintGo() == DrvPrnDef.PRN_NG) {
          myLog.logAdd(
              myTid, LogLevelDefine.error, "tprtssCmd() M tprtssPrintGo error");
          return DrvPrnDef.PRN_NG;
        }
        logoFlg = tprtssMsg.param[0].codeUnitAt(0);
        cutType = tprtssMsg.param[1].codeUnitAt(0);
        if (rctTbCut == 1) {
          if (cutType != 2) {
            cutType = 1;
          }
          if (logoFlg != 0) {
            logoFlg = -1;
          }
        }
        if ((devOrder == DrvPrnDef.DESK_PRINTER) && shareJ == 1) {
          logoFlg = -1;
        }
        if ((devOrder == DrvPrnDef.QCJC_PRINTER) && shareC == 1) {
          logoFlg = -1;
        }
        if (await tprtssCutPrint(tprtssMsg.param[0].codeUnitAt(0),
                tprtssMsg.param[2].codeUnitAt(0), logoFlg, cutType) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() M tprtssCutPrint[${tprtssMsg.param[0]}][${tprtssMsg.param[1]}][${tprtssMsg.param[2]}] error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "R": // Printer Reset Command
        if (await tprtssCmdCreateData(
                CMD_ENUM.TPRTS_CMD_RESET, 0, 0, 0, "", 0) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(
              myTid, LogLevelDefine.error, "tprtssCmd() R CMD_RESET error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "P": // Palameter Send Command
        if (await tprtssInitCmd(1, tprtssMsg.param[1].codeUnitAt(0), 0) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() P tprtssInitCmd[${tprtssMsg.param[1]}] error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "O": // Logo Print(Add BFEED)
        if (await tprtssLogoPrint(tprtssMsg.param[0].codeUnitAt(0), 0) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmd() O tprtssLogoPrint error");
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "A":
      case "X":
        break;
      case "B": // Logo Data DownLoad
      case "Z": // Printer Status Print Command
      default: // Another Command
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssCmd() another command [${tprtssMsg.cmd}]!!");
        }
        break;
    }

    return DrvPrnDef.PRN_OK;
  }

  /// システム管理タスクに処理結果通知
  /// 引数:[result] データ受信結果
  ///     [tprMsg] プリンタ状態
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_conf
  int tprtssConf(int result, TprMsgDevReq2_t devRec) {
    TprMsg_t tprMsgAck = TprMsg_t(); // write buffer
    int length = 0; // messsage length
    String errLog = "";

    if (DrvPrnDef.TPRTS_DEBUG) {
      errLog = "tprtssConf start result:$result";
      myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
    }
    if (result == DrvPrnDef.TPRT_RTN_PINIT) {
      tprMsgAck.devack2.data[0] = devRec.dataStr[0]; // set data category
      length += 1;
    } else {
      tprMsgAck.devack2.data[0] = devRec.dataStr[0]; // set data category
      tprMsgAck.devack2.data[1] = devRec.dataStr[2]; // set command
      length += 2;
    }

    // set result
    switch (result) {
      case DrvPrnDef.PRN_OK: // OK
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTOK;
        break;
      case DrvPrnDef.PRN_NG: // NG
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTWERR;
        break;
      case DrvPrnDef.TPRT_RTN_POFF: // OFFLINE
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTOFFLINE;
        break;
      case DrvPrnDef.TPRT_RTN_PERR: // PRINTER ERROR
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTWERR;
        break;
      case DrvPrnDef.TPRT_RTN_PINIT: // PARALLEL PORT INITIALIZE
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTOK;
        break;
      default:
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTOK;
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(
              myTid, LogLevelDefine.normal, "tprtssConf Unknown Switch");
        }
        break;
    }
    length += 4; // + sizeof result (int)
    tprMsgAck.devack2.io = devRec.io; // Set io kind
    length += 4; // + sizeof io (int)
    tprMsgAck.devack2.src = devRec.src; // Set src
    length += 4; // Set size of src (int)
    tprMsgAck.devack2.tid = devRec.tid; // Set device id
    length += 4; // + sizeof tid (int)
    length += 4; // + sizeof dataLen (int)
    tprMsgAck.devack2.length = length;
    length += 4; // + sizeof length (int)
    tprMsgAck.devack2.mid = TprMidDef.TPRMID_DEVACK; // Set message id
    length += 4; // sizeof mid (int)

    _parentSendPort.send(
        NotifyFromSIsolate(NotifyTypeFromSIsolate.printStatus, tprMsgAck));

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssConf end");
    }
    return DrvPrnDef.PRN_OK;
  }

  /// ファイルパスがあればロゴの登録、なければセマフォのデータを取得へ
  /// 引数:[filepath] ファイルパス
  ///     [logoNo] ロゴNo
  ///     [cmd] コマンド
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_data
  Future<int> tprtssData(
      String filepath, String logoNo, String cmd, List<String> data) async {
    int flg;

    if (filepath.isEmpty) {
      switch (cmd) {
        // コマンド種別
        case "A":
          flg = 1;
          break;
        case "X":
          flg = 2;
          break;
        case "B":
        default:
          flg = 0;
          break;
      }
      return tprtssShmCtrl(1, flg, data);
    }

    if (await tprtssRecordLogo(filepath, logoNo) == DrvPrnDef.PRN_NG) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssData tprtssRecordLogo error[$filepath][$logoNo]");
      return DrvPrnDef.PRN_NG;
    }
    return DrvPrnDef.PRN_OK;
  }

  /// 共有メモリに格納されている印字データをデータバッファにコピー
  /// 引数:[flg] コマンドNo
  ///     [shmData] コマンドデータ
  ///     [stSize] コマンドデータ長
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_data_save
  int tprtssDataSave(int flg, List<String> shmData, int stSize) {
    String errLog = "";
    List<String> siz =
        List.generate(DrvPrnDef.DATA_SAVE_SIZ_MAX, (_) => "0x00");
    int i = 0;
    int a = 20;

    for (i = 0; i < DrvPrnDef.DATA_SAVE_SIZ_MAX; i++) {
      siz[i] = ((stSize >> a) & 0x000000F).toRadixString(16);
      a -= 4;
    }

    if (DrvPrnDef.TPRTS_DEBUG) {
      errLog = "tprtssDataSave start[$flg][$stSize]!!";
      myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
    }

    if (pDataSave.isEmpty) {
      pDataSave.clear();
    }

    pDataSave.add(latin1.decode([DrvPrnDef.DATA_SAVE_1 & 0xff]));
    pDataSave.add(latin1.decode([flg & 0xff]));
    pDataSave.add(latin1.decode([DrvPrnDef.DATA_SAVE_2 & 0xff]));
    pDataSave += siz;
    pDataSave.add(latin1.decode([DrvPrnDef.DATA_SAVE_3 & 0xff]));
    pDataSave += shmData;

    dataSaveSiz += shmData.length;

    if (DrvPrnDef.TPRTS_DEBUG) {
      errLog = "tprtssDataSave end[$flg][$stSize]!!";
      myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
    }

    return DrvPrnDef.PRN_OK;
  }

  /// データバッファに格納したデータからコマンドを抽出して各印字処理へ振り分ける
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_print_go
  Future<int> tprtssPrintGo() async {
//	int		r = DrvPrnDef.PRN_OK;
    int pos = 0;
    int typ = 0;
    int dSize = 0;
    int no = 0;
    int xSiz = 0;
    int siz = 0;
    int resFlag = 0;
    String errLog = "";
    String tmpBuf = "";

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssPrintGo() start");
    }
    if (pDataSave.isEmpty) {
      if (DrvPrnDef.TPRTS_DEBUG) {
        errLog = "tprtssPrintGo() Data is NULL!!!!!!!!!!!!!!!!!!!!!!!";
        myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
      }
      dataSaveSiz = 0;
      return DrvPrnDef.PRN_OK;
    }

    outerLoop:
    while (true) {
      await tprtssStatus();
      if (statusErr != DrvPrnDef.PRN_OK) {
        errLog = "tprtssPrintGo() status Error!!";
        break outerLoop;
      }
      // if (dataSaveSiz <=
      //     (DrvPrnDef.DATA_SAVE_CTRL_MAX + 1 + DrvPrnDef.DATA_SAVE_SIZ_MAX)) {
      //   errLog = "tprtssPrintGo() size error[$dataSaveSiz]!!";
      //   break outerLoop;
      // }

      pos = 0;
      while (true) {
        if (pDataSave[pos++].codeUnitAt(0) != DrvPrnDef.DATA_SAVE_1) {
          errLog =
              "tprtssPrintGo() data 1 error[${pDataSave[pos - 1]}][${pos - 1}]!!";
          break outerLoop;
        }
        typ = pDataSave[pos++].codeUnitAt(0) & 0xFF;
        if (pDataSave[pos++].codeUnitAt(0) != DrvPrnDef.DATA_SAVE_2) {
          errLog =
              "tprtssPrintGo() data 2 error[${pDataSave[pos - 1]}][${pos - 1}] typ[$typ]!!";
          break outerLoop;
        }
        tmpBuf = "0x";
        tmpBuf += pDataSave.sublist(pos, pos + 6).join("");

        siz = int.parse(tmpBuf);
        pos += DrvPrnDef.DATA_SAVE_SIZ_MAX;
        if (pDataSave[pos++].codeUnitAt(0) != DrvPrnDef.DATA_SAVE_3) {
          errLog =
              "tprtssPrintGo() data 3 error[${pDataSave[pos - 1]}][${pos - 1}][$typ][$siz]!!";
          break outerLoop;
        }
        switch (typ) {
          case 1: // charactor
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssPrintGo() character data getting[$siz]");
            }
            if (DrvPrnDef.DISP_BUFF) {
              dispBuff("tprtss_write 12", pDataSave[pos], siz);
            }
            if (await tprtssWrite(
                    pDataSave.sublist(pos, pos + siz).join(""), siz, resFlag) ==
                DrvPrnDef.PRN_NG) {
              errLog =
                  "tprtssPrintGo() character data write error[$pos][$siz][$resFlag]!!";
              break outerLoop;
            }
            break;
          case 2: // command
            if (await tprtssSpecialCmd(
                    (pDataSave.sublist(pos, pos + siz)).join(""), siz) ==
                DrvPrnDef.PRN_NG) {
              errLog = "tprtssPrintGo() tprtssSpecialCmd error[$pos][$siz]!!";
              break outerLoop;
            }
            break;
          case 4:
            if (DrvPrnDef.TPRTS_DEBUG) {
              errLog = "tprtssPrintGo() logo print[$siz]";
              myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
            }
            no = int.parse(pDataSave[pos]);
            xSiz = int.parse(pDataSave[pos + 3]);

            if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_FEED,
                    DrvPrnDef.TPRTS_LOGO_FEED, 0, 0, "", 0) ==
                DrvPrnDef.PRN_NG) {
              errLog = "tprtssPrintGo() tprtssCmdCreate FEED error!!";
              break outerLoop;
            }
            if (no == 1) {
              if (await tprtssCmdCreateData(
                      CMD_ENUM.TPRTS_CMD_NVBIT_PRINT, xSiz, 0, no, "", 0) ==
                  DrvPrnDef.PRN_NG) {
                errLog =
                    "tprtssPrintGo() tprtssCmdCreate NVBIT error[$xSiz][$no]!!";
                break outerLoop;
              }
            } else if (no == 2) {
              if (await tprtssCmdCreateData(
                      CMD_ENUM.TPRTS_CMD_DLBMP_PRINT, xSiz, 0, no, "", 0) ==
                  DrvPrnDef.PRN_NG) {
                errLog =
                    "tprtssPrintGo() tprtssCmdCreate DLBMP error[$xSiz][$no]!!";
                break outerLoop;
              }
            }
            break;
          default: // bitmap
            dSize = tprtssLineCheck(siz);
            if (DrvPrnDef.TPRTS_DEBUG) {
              errLog = "tprtssPrintGo() image data getting[$dSize][$siz]";
              myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
            }
            if (await tprtssCmdCreateData(
                    CMD_ENUM.TPRTS_CMD_LMSB, 0, 0, 0, "", 0) ==
                DrvPrnDef.PRN_NG) {
              errLog = "tprtssPrintGo() tprtssCmdCreate LMSB error!!";
              break outerLoop;
            }
            if (await tprtssCmdCreateData(
                    CMD_ENUM.TPRTS_CMD_BMP, dSize, 0, 0, pDataSave[pos], siz) ==
                DrvPrnDef.PRN_NG) {
              errLog = "tprtssPrintGo() tprtssCmdCreate BMP error[$pos]!!";
              break outerLoop;
            }
            break;
        }
        pos += siz;
        if ((pos + 1) >= dataSaveSiz) {
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssPrintGo() OK!!");
          }
          break outerLoop;
        }
        if ((pos + 1) > dataSaveSiz) {
          errLog = "tprtssPrintGo() size over error[$dataSaveSiz][$pos]!!";
          break outerLoop;
        }
        if ((dataSaveSiz - (pos + 1)) <=
            (DrvPrnDef.DATA_SAVE_CTRL_MAX + 1 + DrvPrnDef.DATA_SAVE_SIZ_MAX)) {
          errLog = "tprtssPrintGo() size error[$dataSaveSiz][$pos]!!";
          break outerLoop;
        }
      }
    }
    // TODO:#if RF1_SYSTEM
    // pCom.vtclRm5900BarcodeFeedFlg = 0;

    pDataSave.clear();
    dataSaveSiz = 0;

    if (errLog.isNotEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }

    return DrvPrnDef.PRN_OK;
  }

  /// 格納した受信データをプリントする（印字後にカット）
  /// 引数:[no] コマンドNo
  ///     [xPos] X位置
  ///     [logoFlg] ロゴ印字フラグ
  ///     [cutTyp] カットタイプ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_CutPrint
  Future<int> tprtssCutPrint(int no, int xPos, int logoFlg, int cutTyp) async {
    int siz = 0;
    CMD_ENUM cmd = CMD_ENUM.TPRTS_CMD_RESET;
    int bFeed = DrvPrnDef.TPRTS_CUTAFT_BFEED; // 16

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssCutPrint() [$no][$xPos][$logoFlg][$rctTbCut]");
    }
    switch (cutTyp) {
      case 0:
        cmd = CMD_ENUM.TPRTS_CMD_CUT;
        break;
      case 1:
        cmd = CMD_ENUM.TPRTS_CMD_FULLCUT;
        break;
      default:
        cmd = CMD_ENUM.TPRTS_CMD_CUT;
        break;
    }

    if (logoFlg == -1) {
      siz = (cutTyp == 2)
          ? DrvPrnDef.TPRTS_CUTBFRE_FEED2
          : DrvPrnDef.TPRTS_CUTBFRE_FEED;
      if (cutTyp == 1) {
        if (openFlg == 1 || usbFlg == 1) {
          siz = 200;
        }
      }
      if (await tprtssCmdCreateData(
              CMD_ENUM.TPRTS_CMD_FEED, siz, 0, 0, "", 0) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCutPrint() CMD_FEED CUTBFRE_FEED[$no][$xPos][$logoFlg][$siz]");
        return DrvPrnDef.PRN_NG;
      }
      if (cutTyp != 2) {
        if (await tprtssCmdCreateData(cmd, 0, 0, 0, "", 0) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCutPrint() CMD_CUT[$no][$xPos][$logoFlg]");
          return DrvPrnDef.PRN_NG;
        }
      }
    } else {
      if ((logoFlg != 0) && (rctTbCut == 0)) {
        siz = (cutTyp == 2)
            ? DrvPrnDef.TPRTS_CUTBFRE_FEED2
            : DrvPrnDef.TPRTS_CUTBFRE_FEED;
        if (await tprtssCmdCreateData(
                CMD_ENUM.TPRTS_CMD_FEED, siz, 0, 0, "", 0) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCutPrint() CMD_FEED CUTBFRE_FEED[$no][$xPos][$logoFlg][$siz]");
          return DrvPrnDef.PRN_NG;
        }
      }
      if (cutTyp != 2) {
        if ((logoFlg == 0) || ((logoFlg != 0) && (rctTbCut != 1))) {
          if (await tprtssCmdCreateData(cmd, 0, 0, 0, "", 0) ==
              DrvPrnDef.PRN_NG) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssCutPrint() CMD_CUT[$no][$xPos][$logoFlg]");
            return DrvPrnDef.PRN_NG;
          }
        }
      }
    }

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssCutPrint() ioctl(SII_GET_REPLY) start");
    }
    switch (taskOrder) {
      case DrvPrnDef.DESK_PRINTER:
        tStat.drw.drwStat &= ~PrinterPortStatus.XPRN_BSY;
        tStat.drw.drwStat &= ~PrinterPortStatus.XPRN_SLCT;
        break;
      case DrvPrnDef.QCJC_PRINTER:
        tStat.qcjccDrw.drwStat &= ~PrinterPortStatus.XPRN_BSY;
        tStat.qcjccDrw.drwStat &= ~PrinterPortStatus.XPRN_SLCT;
        break;
      case DrvPrnDef.COUPON_PRINTER: // TBD
        tStat.kitchen1Drw.drwStat &= ~PrinterPortStatus.XPRN_BSY;
        tStat.kitchen1Drw.drwStat &= ~PrinterPortStatus.XPRN_SLCT;
        break;
      default:
        break;
    }
    sleep(const Duration(microseconds: 25000));

    await tprtssStatus();
    if (statusErr != DrvPrnDef.PRN_OK) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCutPrint() tprtssStatus Error[$no][$xPos][$logoFlg]");
      return DrvPrnDef.PRN_NG;
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssCutPrint() ioctl(SII_GET_REPLY) end");
    }
    if ((logoFlg == -1) &&
        ((!((devOrder == DrvPrnDef.DESK_PRINTER) && shareJ != 0)) &&
            (!((devOrder == DrvPrnDef.QCJC_PRINTER) && shareC != 0)))) {
      if ((rpdFlg == DrvPrnDef.RPCONNECT) ||
          (rpdFlg == DrvPrnDef.RPCONNECT2) ||
          (rpdFlg == DrvPrnDef.RPCONNECT3)) {
        bFeed = 56;
      } else {
        bFeed = 72;
      }
      if (cutTyp == 2) {
        bFeed = bFeed ~/ 2;
      }
      if (await tprtssCmdCreateData(
              CMD_ENUM.TPRTS_CMD_BFEED, bFeed, 0, 0, "", 0) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCutPrint() CMD_BFEED [$bFeed][$no][$xPos]");
        return DrvPrnDef.PRN_NG;
      } else {
        if (openFlg == 1) {
          openFlg = 0;
        }
        if (usbFlg == 1) {
          usbFlg = 0;
        }
      }
    } else {
      if (logoFlg > 0) {
        if (rctTbCut != 0) {
          if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_FEED,
                  DrvPrnDef.TPRTS_BARAFTR_FEED, 0, 0, "", 0) ==
              DrvPrnDef.PRN_NG) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssCutPrint() CMD_FEED CUTAFTRLOGO_FEED[$no][$xPos][$logoFlg]");
            return DrvPrnDef.PRN_NG;
          }
        }
        if ((taskOrder != DrvPrnDef.COUPON_PRINTER) &&
            (!(((devOrder == DrvPrnDef.DESK_PRINTER) && shareJ != 0) ||
                ((devOrder == DrvPrnDef.QCJC_PRINTER) && shareC != 0)))) {
          if (await tprtssCmdCreateData(
                  CMD_ENUM.TPRTS_CMD_LOGO_CENTERING, 0, 0, 0, "", 0) ==
              DrvPrnDef.PRN_NG) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssCutPrint() CMD_CENTERING[$no][$xPos][$logoFlg]");
            return DrvPrnDef.PRN_NG;
          }
          if (await tprtssCmdCreateData(
                  CMD_ENUM.TPRTS_CMD_NVBIT_PRINT, xPos, 0, no, "", 0) ==
              DrvPrnDef.PRN_NG) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssCutPrint() CMD_NVBIT_PRINT[$no][$xPos][$logoFlg]");
            return DrvPrnDef.PRN_NG;
          }
          if (await tprtssCmdCreateData(
                  CMD_ENUM.TPRTS_CMD_MARGIN_RESET, 0, 0, 0, "", 0) ==
              DrvPrnDef.PRN_NG) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssCutPrint() CMD_MARGIN_RESET[$no][$xPos][$logoFlg]");
            return DrvPrnDef.PRN_NG;
          }
        }
        if (rctTbCut == 0) {
          if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_FEED,
                  DrvPrnDef.TPRTS_CUTAFTRLOGO_FEED, 0, 0, "", 0) ==
              DrvPrnDef.PRN_NG) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssCutPrint() CMD_FEED CUTAFTRLOG_FEED - 2[$no][$xPos][$logoFlg]");
            return DrvPrnDef.PRN_NG;
          }
        } else {
          if (cutTyp != 2) {
            if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_BFEED,
                    DrvPrnDef.TPRTS_CUTAFT_BFEED, 0, 0, "", 0) ==
                DrvPrnDef.PRN_NG) {
              myLog.logAdd(myTid, LogLevelDefine.error,
                  "tprtssCutPrint() CMD_BFEED[$no][$xPos][$logoFlg]");
              return DrvPrnDef.PRN_NG;
            }
            if (await tprtssCmdCreateData(cmd, 0, 0, 0, "", 0) ==
                DrvPrnDef.PRN_NG) {
              myLog.logAdd(myTid, LogLevelDefine.error,
                  "tprtssCutPrint() CMD_CUT - 2[$no][$xPos][$logoFlg]");
              return DrvPrnDef.PRN_NG;
            }
          }
          if (await tprtssCmdCreateData(CMD_ENUM.TPRTS_CMD_FEED,
                  DrvPrnDef.TPRTS_CUTAFTRLOGO_FEED2, 0, 0, "", 0) ==
              DrvPrnDef.PRN_NG) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssCutPrint() CMD_FEED CUTAFTRLOGO_FEED2[$no][$xPos][$logoFlg]");
            return DrvPrnDef.PRN_NG;
          }
        }
      } else {
        if (await tprtssCmdCreateData(
                CMD_ENUM.TPRTS_CMD_FEED,
                (no == 0)
                    ? DrvPrnDef.TPRTS_CUTAFTR_FEED
                    : DrvPrnDef.TPRTS_CUTAFTR_FEED2,
                0,
                0,
                "",
                0) ==
            DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCutPrint() CMD_FEED[$no][$xPos][$logoFlg]");
          return DrvPrnDef.PRN_NG;
        }
      }
    }

    if (((rpdFlg == DrvPrnDef.RPCONNECT2) ||
            (rpdFlg == DrvPrnDef.RPCONNECT3)) &&
        (nearEndCheck == 1)) {
      sleep(const Duration(microseconds: 50000));

      tprtssGetStatus(1); // プリンタの状態１
      if ((noteCount != 0) && forceDisp == 0) {
        tprtssMCounter(148);
      }
    }

    return DrvPrnDef.PRN_OK;
  }

  /// センタリングと指定されたNVグラフィックスの印字
  /// 引数:[no] コマンドNo
  ///     [xPos] X位置
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_LogoPrint
  Future<int> tprtssLogoPrint(int no, int xPos) async {
    if (await tprtssCmdCreateData(
            CMD_ENUM.TPRTS_CMD_LOGO_CENTERING, 0, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssLogoPrint() CMD_CENTERING[$no][$xPos]");
      return DrvPrnDef.PRN_NG;
    }
    if (await tprtssCmdCreateData(
            CMD_ENUM.TPRTS_CMD_NVBIT_PRINT, xPos, 0, no, "", 0) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssLogoPrint() CMD_NVBIT_PRINT[$no][$xPos]");
      return DrvPrnDef.PRN_NG;
    }

    return DrvPrnDef.PRN_OK;
  }

  /// コマンド毎に処理を分別する
  /// 引数:[data] コマンドデータ
  ///     [dataLen] コマンドデータ長
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_special_cmd
  Future<int> tprtssSpecialCmd(String data, int dataLen) async {
    String errLog = "";
    int iTmp = 0;

    if (data[1].codeUnitAt(0) != InterfaceDefine.IF_TH_CMD_SEPA) {
      errLog = "tprtssSpecialCmd() Unit Sparator not Found!!";
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      errLog = "tprtssSpecialCmd() [${data[0]}";
      myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
    }
    switch (data[0]) {
      case "F":
        iTmp = ((data[3].codeUnitAt(0) & 0xFF) * 256) +
            (data[2].codeUnitAt(0) & 0xFF);
        if (await tprtssCmdCreateData(
                CMD_ENUM.TPRTS_CMD_FEED, iTmp, 0, 0, "", 0) ==
            DrvPrnDef.PRN_NG) {
          errLog = "tprtssSpecialCmd() F error[$iTmp][$dataLen]";
          myLog.logAdd(myTid, LogLevelDefine.error, errLog);
          return DrvPrnDef.PRN_NG;
        }
        break;
      case "B":
        if (await tprtssCmdCreateData(
                CMD_ENUM.TPRTS_CMD_BARCODE, 0, 0, 0, data, dataLen) ==
            DrvPrnDef.PRN_NG) {
          errLog = "tprtssSpecialCmd() B error[$dataLen]";
          myLog.logAdd(myTid, LogLevelDefine.error, errLog);
          return DrvPrnDef.PRN_NG;
        }
        if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
          if (await tprtssCmdCreateData(
                  CMD_ENUM.TPRTS_CMD_CENTERING_CANCEL, 0, 0, 0, "", 0) ==
              DrvPrnDef.PRN_NG) {
            errLog = "tprtssSpecialCmd() MARGIN error[$dataLen]";
            myLog.logAdd(myTid, LogLevelDefine.error, errLog);
            return DrvPrnDef.PRN_NG;
          }
        }
        break;
      case "L":
        if (await tprtssCmdCreateData(
                CMD_ENUM.TPRTS_CMD_LINE, 0, 0, 0, data, dataLen) ==
            DrvPrnDef.PRN_NG) {
          errLog = "tprtssSpecialCmd() L error[$dataLen]";
          myLog.logAdd(myTid, LogLevelDefine.error, errLog);
          return DrvPrnDef.PRN_NG;
        }
        break;
    }

    return DrvPrnDef.PRN_OK;
  }

  /// プリンタステータスを取得する
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_status
  Future<int> tprtssStatus() async {
    int ret = DrvPrnDef.PRN_NG;
    PrintRet printRet = PrintRet();

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssStatus() start");
    }
    statusErr = DrvPrnDef.PRN_OK;
    tprtssReopen();
    if (hTprtDrv < 0) {
      myLog.logAdd(myTid, LogLevelDefine.error, "tprtssStatus() not open");
      ret = DrvPrnDef.PRN_NG;
    } else {
      printRet = ffiPtr.printerGetStatus();
      ret = printRet.result;
      if (ret < 0) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssStatus() aii_api_get_status failed[${printRet.result}]");
        // disable printer status receive
        statusErr = DrvPrnDef.PRN_NG;
        ret = DrvPrnDef.PRN_NG;
      }
    }
    if (versionFlg == 0) {
      await tprtssGetFwVer();
    }
    if (modelIdFlg == 0) {
      await tprtssGetId();
    }

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssStatus() end");
    }
    await tprtssSetStatus(ret, printRet.status, 0, 1);

    return ret;
  }

  /// タスクステータス、共有メモリを設定する
  /// 引数:[r] 呼び出し元処理の結果
  ///     [status] ステータスデータ
  ///     [notInit] デバイスフラグ立ち上げパラメタ
  ///     [type] ニアエンド解消前動作フラグ
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_SetStatus
  Future<void> tprtssSetStatus(int r, int status, int notInit, int type) async {
    String errLog = "";
    int rctCutType = 0;
    int drwStat = 0;
    int logoFlg;

    outerLoop:
    // 元ソースのgoto文の置き換えのためループ処理に変更
    // （ループ処理でしかラベルが使用できないため）
    while (true) {
      /* TODO:共有メモリ */
      switch (taskOrder) {
        case DrvPrnDef.DESK_PRINTER:
          rctCutType = pCom.iniMacInfo.printer.rct_cut_type;
          nearEndCheck = pCom.iniMacInfo.printer.nearend_check;
          break;
        case DrvPrnDef.QCJC_PRINTER:
          //rctCutType = combuf->ini_macinfo_JC_C.rctCutType;
          //nearEndCheck = combuf->ini_macinfo_JC_C.nearEndCheck;
          break;
        case DrvPrnDef.COUPON_PRINTER: // TBD
          rctCutType = 0;
          nearEndCheck = 0;
          break;
        default:
          break;
      }

      statusVal.clear();
      statusVal.add(version[0]);
      statusVal.add(version[1]);
      statusVal.add(0);
      statusVal.add(0);

      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssSetStatus statusVal.length[${statusVal.length}][$statusVal]");
      }

      if (r == DrvPrnDef.PRN_OK) {
        if (DrvPrnDef.TPRTS_DEBUG) {
          if (status < 0) {
            errLog = "[${((status * (-1) ^ 0xFFFFFFFF) + 1).toRadixString(16)}]";
          } else {
            errLog = "[${status.toRadixString(16).padLeft(8, "0")}]";
          }
          myLog.logAdd(myTid, LogLevelDefine.error, "tprtssSetStatus status$errLog");
        }
        if ((status & DrvPrnDef.TPRTSS_STAT_PAPEREND) ==
            DrvPrnDef.TPRTSS_STAT_PAPEREND) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssSetStatus : PAPEREND[${status.toRadixString(16)}]");

          statusVal[2] |= (1 << 1);

          statusErr = DrvPrnDef.PRN_NG;
          logoPrintChk = 1;
          paperEndNotifyFlg = 1;
        }

        if ((status & DrvPrnDef.TPRTSS_STAT_PRTNOPN) ==
            DrvPrnDef.TPRTSS_STAT_PRTNOPN) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssSetStatus : PRTNOPN[${status.toRadixString(16)}]");

          statusVal[2] |= (1 << 2);
          statusErr = DrvPrnDef.PRN_NG;
          logoPrintChk = 1;
          openFlg = 1;
        }

        if ((status & DrvPrnDef.TPRTSS_STAT_CUTERR) ==
            DrvPrnDef.TPRTSS_STAT_CUTERR) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssSetStatus : CUTERR[${status.toRadixString(16)}]");

          statusVal[2] |= (1 << 3);
          statusErr = DrvPrnDef.PRN_NG;
          logoPrintChk = 1;
          cutErrFlg = 1;
          if (initFlg == 1) {
            if (hwResetCnt < DrvPrnDef.HW_RESET_MAX) {
              hwResetFlg = 1;
              hwResetCnt++;
            } else {
              hwResetFlg = 0;
            }
          }
        }
        drwStat = status & DrvPrnDef.TPRTSS_STAT_DRWHIGH;
        if (DrvPrnDef.DISP_BUFF) {
          myLog.logAdd(myTid, LogLevelDefine.normal, "]] rpdFlg $rpdFlg");
        }
        if ((rpdFlg != DrvPrnDef.RPCONNECT) &&
            (rpdFlg != DrvPrnDef.RPCONNECT2) &&
            (rpdFlg != DrvPrnDef.RPCONNECT3) &&
            (rpdFlg != DrvPrnDef.RPCONNECT4)) {
          // CAPM
          if (drwStat == DrvPrnDef.TPRTSS_STAT_DRWHIGH) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "tprtssSetStatus: CAPM DRWHIGH[${status.toRadixString(16)}]");

            statusVal[2] |= (1 << 4);
          } else {}
        } else {
          if (rpdFlg != DrvPrnDef.RPCONNECT4) {
            // SLPはドロワ無し
            // RP-D10
            if (drwStat != DrvPrnDef.TPRTSS_STAT_DRWHIGH) {
              // myLog.logAdd(myTid, LogLevelDefine.error,
              //     "tprtssSetStatus: RP-D10 DRWHIGH[${status.toRadixString(16)}]");

              statusVal[2] |= (1 << 4);
              if (rm59Flg == 1) {
                tStat.drw.drwStat |= PrinterPortStatus.XPRN_PE;
              }
            } else {
              if (rm59Flg == 1) {
                tStat.drw.drwStat &= ~PrinterPortStatus.XPRN_PE;
              }
            }
          }
        }
      } else {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssSetStatus: print possible Err($notInit)");

        statusVal[2] |= (1 << 0);
        statusVal[2] |= (1 << 2);

        statusErr = DrvPrnDef.PRN_NG;
        if (notInit == 2) {
          return;
        }
        logoPrintChk = 1;
      }
      if (statusErr != DrvPrnDef.PRN_OK) {
        prnOpen = 1;
        switch (taskOrder) {
          case DrvPrnDef.DESK_PRINTER:
            tStat.drw.drwStat |= PrinterPortStatus.XPRN_ERR;
            break;
          case DrvPrnDef.QCJC_PRINTER:
            tStat.qcjccDrw.drwStat |= PrinterPortStatus.XPRN_ERR;
            break;
          case DrvPrnDef.COUPON_PRINTER: // TBD
            tStat.kitchen1Drw.drwStat |= PrinterPortStatus.XPRN_ERR;
            break;
          default:
            break;
        }
      } else {
        switch (taskOrder) {
          case DrvPrnDef.DESK_PRINTER:
            tStat.drw.drwStat &= ~PrinterPortStatus.XPRN_ERR;
            break;
          case DrvPrnDef.QCJC_PRINTER:
            tStat.qcjccDrw.drwStat &= ~PrinterPortStatus.XPRN_ERR;
            break;
          case DrvPrnDef.COUPON_PRINTER: // TBD
            tStat.kitchen1Drw.drwStat &= ~PrinterPortStatus.XPRN_ERR;
            break;
          default:
            break;
        }

        if (((rpdFlg == DrvPrnDef.RPCONNECT2) ||
                (rpdFlg == DrvPrnDef.RPCONNECT3) ||
                (rpdFlg == DrvPrnDef.RPCONNECT4)) &&
            (nearEndCheck == 1)) {
          // RP-E11
          if (specTerm == 1) {
            // ターミナルの通知設定の更新チェック
            int nearEndNote = pCom.dbTrm.nearendNote;
            if (noteLen != nearEndNote) {
              noteLen = nearEndNote;
              noteCount = (noteLen * 10 * 8 ~/ 100);
              if ((noteLen * 10 * 8) % 100 != 0) {
                noteCount++;
              }
            }
          }

          if (detectNearEnd == 1) {
            // ニアエンド
            if (((rpdFlg == DrvPrnDef.RPCONNECT2) ||
                    (rpdFlg == DrvPrnDef.RPCONNECT3) ||
                    (rpdFlg == DrvPrnDef.RPCONNECT4)) &&
                (noteCount != 0) &&
                (forceDisp == 0) &&
                (prnOpen == 0)) {
              //！開閉　！通知
              if (isSetBase == 1) {
                // カウントアップ中
                tprtssPrintNearEndInfo(status);
              }
            } else {
              // 開閉 or 通知
              if (isSetBase == 1) {
                // カウントアップ中
                forceDisp = 1;
                isSetBase = 0;
                baseCount = 0;
                currCount = 0;
                prevCount = 0;
                countOffset = 0;
                await counter.load();
                counter.tran.nearend_base = 0;
                counter.tran.nearend_curr = 0;
                counter.tran.nearend_check_fail = 0;
                await counter.save();
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(
                      myTid, LogLevelDefine.normal, "[RP-E11] Clear nearend");
                }
              }
              //errLog = status.toRadixString(16).padLeft(8, "0");
              myLog.logAdd(myTid, LogLevelDefine.error,
                  "tprtssSetStatus: NEAREND[${status.toRadixString(16)}]");

              /* TODO:共有メモリ更新 */
              if (taskOrder == 1) {
                pCom.printer_near_end = 1;
              } else {
                pCom.printer_near_end_JC_C = 1;
              }
              statusVal[2] |= (1 << 5);
            }
          } else {
            // ！ニアエンド
            if (type == 1) {
              if (prnOpen == 1) {
                // プリンタ開閉 -> ニアエンド解消
                if ((checkFail == 0) || (checkFail == 0xff)) {
                  checkFail = 0;
                }
                detectNearEnd = 0;
                isSetBase = 0;
                baseCount = 0;
                currCount = 0;
                prevCount = 0;
                countOffset = 0;
                prnOpen = 0;
                forceDisp = 0;
                await counter.load();
                counter.tran.nearend_base = 0;
                counter.tran.nearend_curr = 0;
                counter.tran.nearend_check_fail = 0;
                await counter.save();

                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssSetStatus [RP-E11] Clear nearend");
                }
              }

              if (forceDisp == 1) {
                // カウントアップ完了後にニアエンド解消
                //errLog = status.toRadixString(16).padLeft(8, "0");
                myLog.logAdd(myTid, LogLevelDefine.error,
                    "tprtssSetStatus : NEAREND[${status.toRadixString(16)}]");

                /* TODO:共有メモリ更新 */
                if (taskOrder == 1) {
                  pCom.printer_near_end = 1;
                } else {
                  pCom.printer_near_end_JC_C = 1;
                }
                statusVal[2] |= (1 << 5);

                // ループ処理を抜ける
                break outerLoop;
              }

              if (isSetBase == 1) {
                // カウントアップ中にニアエンド解消
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "[RP-E11] !! Ignore OK status !!");
                }
                tprtssPrintNearEndInfo(status);
              }
            }

            /* TODO:共有メモリ更新 */
            if (taskOrder == 1) {
              pCom.printer_near_end = 0;
            } else {
              pCom.printer_near_end_JC_C = 0;
            }
          }
        } else {
          // ! RP-E11
          if (((status & DrvPrnDef.TPRTSS_STAT_NEAREND) ==
                  DrvPrnDef.TPRTSS_STAT_NEAREND) &&
              (nearEndCheck == 1)) {
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssSetStatus : NEAREND[${status.toRadixString(16)}]");
            }

            /* TODO:共有メモリ更新 */
            if (taskOrder == 1) {
              pCom.printer_near_end = 1;
            } else {
              pCom.printer_near_end_JC_C = 1;
            }
            statusVal[2] |= (1 << 5);
          } else {
            /* TODO:共有メモリ更新 */
            if (taskOrder == 1) {
              pCom.printer_near_end = 0;
            } else {
              pCom.printer_near_end_JC_C = 0;
            }
          }
        }
      }
      break;
    }
    // outerLoop
    switch (taskOrder) {
      case DrvPrnDef.DESK_PRINTER:
        tStat.drw.drwStat |= PrinterPortStatus.XPRN_BSY;
        tStat.drw.drwStat |= PrinterPortStatus.XPRN_SLCT;
        break;
      case DrvPrnDef.QCJC_PRINTER:
        tStat.qcjccDrw.drwStat |= PrinterPortStatus.XPRN_BSY;
        tStat.qcjccDrw.drwStat |= PrinterPortStatus.XPRN_SLCT;
        break;
      case DrvPrnDef.COUPON_PRINTER: // TBD
        tStat.kitchen1Drw.drwStat |= PrinterPortStatus.XPRN_BSY;
        tStat.kitchen1Drw.drwStat |= PrinterPortStatus.XPRN_SLCT;
        break;
      default:
        break;
    }

    if ((logoPrintChk == 1) &&
        (statusErr == DrvPrnDef.PRN_OK) &&
        (startFlg == 1) &&
        (r == 0) &&
        (notInit == 0)) {
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(
            myTid, LogLevelDefine.normal, "tprtssSetStatus print init");
      }

      dataSaveSiz = 0;
      if (await tprtssReset() == DrvPrnDef.PRN_OK) {
        logoPrintChk = 0;
        if (await tprtssInitCmd(1, densityVal, 1) == DrvPrnDef.PRN_NG) {
          statusErr = DrvPrnDef.PRN_NG;
          logoPrintChk = 1;
        } else {
          logoFlg = 1;
          if (rctTbCut == 1) {
            if (rctCutType == 0) {
              rctCutType = 1;
              /* TODO:共有メモリ更新 */
              switch (taskOrder) {
                case DrvPrnDef.DESK_PRINTER:
                  pCom.iniMacInfo.printer.rct_cut_type = 1;
                  break;
                case DrvPrnDef.QCJC_PRINTER:
                  //combuf->ini_macinfo_JC_C.rctCutType = 1;
                  break;
                case DrvPrnDef.COUPON_PRINTER: // TBD
                  pCom.iniMacInfo.printer.rct_cut_type = 0;
                  break;
                default:
                  break;
              }
              if (DrvPrnDef.TPRTS_DEBUG) {
                myLog.logAdd(
                    myTid, LogLevelDefine.normal, "Change rctCutType 0 -> 1");
              }
            }
            logoFlg = -1;
          }

          if ((devOrder == DrvPrnDef.DESK_PRINTER) && (shareJ == 1)) {
            logoFlg = -1;
          }
          if ((devOrder == DrvPrnDef.QCJC_PRINTER) && (shareC == 1)) {
            logoFlg = -1;
          }

          switch (taskOrder) {
            case DrvPrnDef.DESK_PRINTER:
              tStat.print.init = 0;
              break;
            case DrvPrnDef.QCJC_PRINTER:
              tStat.qcjccPrint.init = 0;
              break;
            case DrvPrnDef.COUPON_PRINTER: // TBD
              tStat.kitchen1Print.init = 0;
              break;
            default:
              break;
          }
          // TODO:ロゴの事前印字はしない
          // if (await tprtssCutPrint(1, 2, logoFlg, rctCutType) ==
          if (await tprtssCutPrint(1, 2, 0, 0) == DrvPrnDef.PRN_NG) {
            statusErr = DrvPrnDef.PRN_NG;
            logoPrintChk = 1;
          }

          switch (taskOrder) {
            case DrvPrnDef.DESK_PRINTER:
              tStat.print.init = 0;
              break;
            case DrvPrnDef.QCJC_PRINTER:
              tStat.qcjccPrint.init = 0;
              break;
            case DrvPrnDef.COUPON_PRINTER: // TBD
              tStat.kitchen1Print.init = 0;
              break;
            default:
              break;
          }
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal,
                "print init cut end[$statusErr][$logoPrintChk]");
          }
        }
      } else {
        statusErr = DrvPrnDef.PRN_NG;
      }
    }
  }

  /// システム管理タスクに処理結果通知
  /// 引数:[result] 呼び出し元処理の結果
  ///     [status] ステータスデータ
  ///     [tprMsg] 応答メッセージ
  ///     [flg] 書き込みバッファタイプ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_reply
  int tprtssReply(int result, String status, TprMsg_t tprMsg, int flg) {
    TprMsg_t tprMsgReq = tprMsg; // reply message
    TprMsg_t tprMsgAck = TprMsg_t(); // write buffer
    int length = 0;
    String errLog = "";

    switch (flg) {
      case 0:
        tprMsgAck.devack2.data[0] = tprMsg.devreq2.dataStr[0]; // deta category
        tprMsgAck.devack2.data[1] = status[0]; // version
        tprMsgAck.devack2.data[2] = status[1]; // version
        tprMsgAck.devack2.data[3] = status[2]; // status
        // tprMsgAck.devack2.data.add(tprMsg.devreq2.dataStr[0]); // deta category
        // tprMsgAck.devack2.data.add(status.substring(0, 3));
        length += 1 + 3;
        break;
      case 1:
        tprMsgAck.devack2.data[0] = String.fromCharCode(3); // deta category
        tprMsgAck.devack2.data[1] = status[0];
        tprMsgAck.devack2.data[2] = status[1];
        tprMsgAck.devack2.data[3] = status[2];
        // tprMsgAck.devack2.data.add(String.fromCharCode(3)); // status category
        // tprMsgAck.devack2.data.add(status.substring(0, 2));
        length += 1 + 3;
        break;
      case 2:
      default:
        tprMsgAck.devack2.data[0] = tprMsg.devreq2.dataStr[0]; // deta category
        tprMsgAck.devack2.data[1] = status[0];
        // tprMsgAck.devack2.data.add(tprMsg.devreq2.dataStr[0]); // deta category
        // tprMsgAck.devack2.data.add(status[0]);
        length += 1 + 1;
        break;
    }
    switch (result) {
      case DrvPrnDef.PRN_OK: // OK
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTOK;
        break;
      case DrvPrnDef.PRN_NG: // NG
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTWERR;
        break;
      case DrvPrnDef.TPRT_RTN_POFF: // OFFLINE
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTOFFLINE;
        break;
      default:
        tprMsgAck.devack2.result = TprDidDef.TPRDEVRESULTOK;
        if (DrvPrnDef.TPRTS_DEBUG) {
          errLog = "tprt reply Unknown Switch";
          myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
        }
        break;
    }
    length += 4; // + sizeof result (int)
    tprMsgAck.devack2.io = tprMsgReq.devreq2.io; // Set io kind
    length += 4; // + sizeof io (int)
    tprMsgAck.devack2.src = tprMsgReq.devreq2.src; // Set src
    length += 4; // Set size of src (int)
    tprMsgAck.devack2.tid = tprMsgReq.devreq2.tid; // Set device id/
    length += 4; // + sizeof tid (int)
    length += 4; // + sizeof dataLen (int)
    tprMsgAck.devack2.length = length;
    length += 4; // + sizeof length (int)
    tprMsgAck.devack2.mid = TprMidDef.TPRMID_DEVACK; // Set message id
    length += 4; // + sizeof mid (int)

    _parentSendPort.send(
        NotifyFromSIsolate(NotifyTypeFromSIsolate.printStatus, tprMsgAck));

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssReply end");
    }

    return DrvPrnDef.PRN_OK;
  }

  /// セマフォのデータを取得する
  /// 引数:[flag] アロケータカウンタ使用フラグ
  ///     [flg] コマンドNo
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_shmctrl
  int tprtssShmCtrl(int flag, int flg, List<String> data) {
    int dSize = 0;
    String erLog = "";

    if (flag == 1) {
      dSize = tprtssLineCheck(data.length);
      if (dSize > 0xffff) {
        erLog = "tprtssShmCtrl size over error[$dSize]";
      } else {
        if (tprtssDataSave(flg, data, data.length) == DrvPrnDef.PRN_NG) {
          erLog = "tprtssShmCtrl tprtss_data_save error";
        }
      }
    }
    if (erLog.isNotEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error, erLog);
      return DrvPrnDef.PRN_NG;
    }
    return DrvPrnDef.PRN_OK;
  }

  /// 出力時の行間サイズチェック
  /// 引数:[lDataSize] 出力するデータサイズ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_LineCheck
  int tprtssLineCheck(int lDataSize) {
    int receiptHigh = 0;

    if (lDataSize <= 0) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssLineCheck() param error[$lDataSize]");
      return DrvPrnDef.PRN_NG;
    }
    // Set Print Wide
    receiptHigh = lDataSize ~/ (receiptWide / 8);

    return receiptHigh;
  }

  /// プリンタのF/Wバージョンを取得する
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_get_fwver
  Future<void> tprtssGetFwVer() async {
    PrintRet ret = PrintRet();
    String pbyCmdBuf = "";
    String errLog = "";

    myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssGetFwVer() start");

    pbyCmdBuf = DrvPrnDef.CMD_GS;
    pbyCmdBuf += "\x49";
    pbyCmdBuf += "\x41"; // Firmware Version(main) exp. 0.19.00

    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("sii_api__write_device 01", pbyCmdBuf, 3);
    }

    ret = ffiPtr.printerWriteDevice(pbyCmdBuf, 3);
    if (ret.result < 0) {
      errLog = "tprtssGetFwVer() sii_api_write_device failed[$ret]";
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return;
    } else {
      if (DrvPrnDef.DISP_BUFF) {
        myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 01");
      }
      if (await tprtssRead(
              READ_RET_ENUM.READ_CHAR,
              READ_ANALYSIS_ENUM.ANALYSIS_VER,
              0,
              0,
              1,
              DrvPrnDef.TPRTSS_READ_WAITTIME,
              DrvPrnDef.TPRTSS_READ_RETRY) ==
          DrvPrnDef.PRN_NG) {
        errLog = "tprtssGetFwVer() tprtssRead failed";
        myLog.logAdd(myTid, LogLevelDefine.error, errLog);
        return;
      } else {
        versionFlg = 1;
      }
    }

    myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssGetFwVer() normal end");
  }

  /// プリンタのModel IDを取得する
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_get_id
  Future<void> tprtssGetId() async {
    PrintRet ret = PrintRet();
    String pbyCmdBuf = "";
    String errLog = "";

    myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssGetId() start");

    pbyCmdBuf = DrvPrnDef.CMD_GS;
    pbyCmdBuf += "\x49";
    pbyCmdBuf += "\x01"; // Model ID

    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("sii_api_write_device 02", pbyCmdBuf, 3);
    }

    ret = ffiPtr.printerWriteDevice(pbyCmdBuf, 3);
    if (ret.result < 0) {
      errLog = "tprtssGetId() sii_api_write_device failed[$ret]";
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return;
    } else {
      if (DrvPrnDef.DISP_BUFF) {
        myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 02");
      }
      if (await tprtssRead(
              READ_RET_ENUM.READ_HEX,
              READ_ANALYSIS_ENUM.ANALYSIS_ID,
              0,
              0,
              1,
              DrvPrnDef.TPRTSS_READ_WAITTIME,
              DrvPrnDef.TPRTSS_READ_RETRY) ==
          DrvPrnDef.PRN_NG) {
        errLog = "tprtssGetId() tprtssRead failed";
        myLog.logAdd(myTid, LogLevelDefine.error, errLog);
        return;
      } else {
        modelIdFlg = 1;
      }
    }

    myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssGetId() normal end");
  }

  /// bmpファイルヘッダーを取得する
  /// 引数:[buf] bmpフファイルデータ
  ///     [hdr] bmpファイルヘッダー
  ///     [bHdr] bmpファイルパラメタヘッダー
  ///     [colorHd1] ヘッダーカラー1
  ///     [colorHd2] ヘッダーカラー2
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_get_bmpfileheader
  int tprtssGetBmpFileHeader(String buf, BitmapFileHdr hdr, BitmapInfoHdr bHdr,
      BitmapRGBquad colorHd1, BitmapRGBquad colorHd2) {
    // 共有ライブラリ内に移動
    return 0;
  }

  /// bmpファイルデータを取得する
  /// 引数:[filename] bmpファイル名
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_get_bmpimage
  PrintRet tprtssGetBmpImage(String filename) {
    // 共有ライブラリ内に移動
    return ffiPtr.printerGetBmpImage(filename);
  }

  /// bmpファイルデータを取得する
  /// 引数:[filename] bmpファイル名
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_get_bmpimage
  PrintRet tprtssGetBmpImageData(int logoNo, String filename, int offBits, int width, int height, int lineByte) {
    // 共有ライブラリ内に移動
    return ffiPtr.printerGetBmpImageData(logoNo, filename, offBits, width, height, lineByte);
  }

  /// bit演算
  /// 引数:[lineBuf] bitデータ [in/out]
  ///     [size] bitデータサイズ
  /// 関連tprxソース: tprdrv_tprtim.c - bit_change
  void bitChange(String lineBuf, int size) {
    // 共有ライブラリ内に移動
  }

  /// グラフィックスデータのプリントバッファへの格納
  /// 引数:[filepath] ファイルパス
  ///     [logoNo] ロゴNo
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_record_logo
  Future<int> tprtssRecordLogo(String filepath, String logoNo) async {
    String errLog = "";
    int ret = DrvPrnDef.PRN_OK;
    int offBits = 0;
    int width = 0;
    int height = 0;
    int lineByte;
    String pbyCmdBuf = "";
    int len;
    int trueHeight, boundaryBit;

    errLog = "tprtssRecordLogo start[$filepath][${logoNo.codeUnitAt(0).toString()}]";
    myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
    errLog = "";

    outerLoop:
    while(true) {
      PrintRet bitMap = tprtssGetBmpImage(filepath);
      if (bitMap.result == DrvPrnDef.PRN_NG) {
        errLog = "tprtssRecordLogo tprtssGetBmpImage error[$ret]";
        break outerLoop;
      }
      offBits = bitMap.offBits;
      width = bitMap.width;
      height = bitMap.height;
      errLog = "tprtssRecordLogo[$offBits][$width][$height]";
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);

      trueHeight = height;
      if (trueHeight % 8 != 0) {
        errLog = "tprtssRecordLogo trueHeight[$trueHeight] Error";
        myLog.logAdd(myTid, LogLevelDefine.error, errLog);
        errLog = "";
        height = trueHeight + 8 - (trueHeight % 8);
      }
      lineByte = width ~/ 8;
      boundaryBit = 0;

      boundaryBit = lineByte % 4;
      if (boundaryBit != 0) {
        lineByte = ((lineByte ~/ 4) + 1) * 4;
      }

      if (lineByte < 1 || 0x7f < lineByte) {
        errLog = "tprtssRecordLogo lineByte too big error[$lineByte]";
        break outerLoop;
      }
      if (height < 1 || 0x7ff < height) {
        errLog = "tprtssRecordLogo height too big error[$height]";
        break outerLoop;
      }

      len = 0;
      if (logoNo.codeUnitAt(0) == 1) {
        pbyCmdBuf = DrvPrnDef.CMD_GS;
        pbyCmdBuf += '(';
        pbyCmdBuf += 'L';
        pbyCmdBuf += latin1.decode([(11 + ((((width % 256) + ((width ~/ 256) * 256) + 7) ~/ 8) * height)) % 256]);
        pbyCmdBuf += latin1.decode([(11 + ((((width % 256) + ((width ~/ 256) * 256) + 7) ~/ 8) * height)) ~/ 256]);
        pbyCmdBuf += "\x30"; // 48;
        pbyCmdBuf += "\x43"; // 67;
        pbyCmdBuf += "\x30"; // 48;
        pbyCmdBuf += "\x20"; // 32;
        pbyCmdBuf += "\x20"; // 32;
        pbyCmdBuf += "\x01"; // 1;
        pbyCmdBuf += latin1.decode([width % 256]);
        pbyCmdBuf += latin1.decode([width ~/ 256]);
        pbyCmdBuf += latin1.decode([height % 256]);
        pbyCmdBuf += latin1.decode([height ~/ 256]);
        pbyCmdBuf += "\x31"; // 49;
        errLog = "tprtssRecordLogo logoNo1 [$lineByte][$height][$trueHeight][${(height ~/ 8) % 0xff}][${(height ~/ 8) ~/ 0xff}][${lineByte % 0xff}][${lineByte ~/ 0xff}][${lineByte * height + 7}]";
      } else if (logoNo.codeUnitAt(0) == 2) {
        pbyCmdBuf = DrvPrnDef.CMD_GS; /* 0x1d */
        pbyCmdBuf += '*'; /* 0x2a */
        pbyCmdBuf += latin1.decode([lineByte]);
        pbyCmdBuf += latin1.decode([height ~/ 8]);
        errLog = "tprtssRecordLogo logoNo2 [$lineByte][${height ~/ 8}][${lineByte * height + 4}]";
      }
      len = pbyCmdBuf.length;
      myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
      errLog = "";

      PrintRet printRet = tprtssGetBmpImageData(logoNo.codeUnitAt(0), filepath, offBits, width, height, lineByte);
      if (printRet.result == DrvPrnDef.PRN_NG) {
        errLog = "tprtssRecordLogo tprtssGetBmpImageData error[$offBits][$width][$height][$lineByte]";
        break outerLoop;
      }

      pbyCmdBuf += latin1.decode(printRet.bitImageData);

      if (DrvPrnDef.DISP_BUFF) {
        dispBuff("tprtss_write 13", pbyCmdBuf, len + printRet.bitDataSize);
      }
      if ((ret = await tprtssWrite(pbyCmdBuf, len + printRet.bitDataSize, 1)) == DrvPrnDef.PRN_NG) {
        errLog = "tprtssRecordLogo tprtss_write error[$ret]";
        break outerLoop;
      }
      break;
    }
    // outerLoop:

    if (errLog.isNotEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }
    errLog = "tprtssRecordLogo  end";
    myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
    return DrvPrnDef.PRN_OK;
  }

  /// ロゴファイルデータを取得する
  /// 引数:[filepath] ファイルパス
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_download
  Future<int> tprtssDownload(String filepath) async {
    String errLog = "";
    String cmd = "";
    int ret = 0;
    // int len = 0;
    int stSize = 0;
    int i = 0;
    // struct stat st;
    // FILE *fp = null;

    errLog = "tprtssDownload() start[$filepath]";
    myLog.logAdd(myTid, LogLevelDefine.normal, errLog);

    await tprtssStatus();
    if (statusErr != DrvPrnDef.PRN_OK) {
      errLog = "tprtssDownload() status Error[$statusErr]";
      /*
			tprtssDownloadEnd(cmd, fp);
			 */
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }
    /*
		if (stat(filepath, &st) < 0) {
			errLog = "tprtssDownload() status Error[$errno]";
			tprtssDownloadEnd(cmd, fp);
			myLog.logAdd(myTid, LogLevelDefine.error, errLog);
			return DrvPrnDef.PRN_NG;
		}
		stSize = st.stSize;
		if (stSize <= 0) {
			errLog = "tprtssDownload() stat size[$st_size]";
			tprtssDownloadEnd(cmd, fp);
			myLog.logAdd(myTid, LogLevelDefine.error, errLog);
			return DrvPrnDef.PRN_NG;
		}
		if ((fp = fopen(filepath, "r")) == null) {
			errLog = "tprtssDownload() fopen error[$errno]";
			tprtssDownloadEnd(cmd, fp);
			myLog.logAdd(myTid, LogLevelDefine.error, errLog);
			return DrvPrnDef.PRN_NG;
		}
		if ((cmd = malloc(stSize)) == null) {
			errLog = "tprtssDownload() malloc($st_size) error[$errno]";
			tprtssDownloadEnd(cmd, fp);
			myLog.logAdd(myTid, LogLevelDefine.error, errLog);
			return DrvPrnDef.PRN_NG;
		}
		 */
    allocCnt++;
    /*
		len = fread(cmd, (size_t)1, stSize, fp);
		if (len < 1) {
			ret = feof(fp);
			if (ret > 0) {
				ret = 0;
			}
			else {
				ret = -1;
			}
			errLog = "tprtssDownload() read len error[$errno]";
			tprtssDownloadEnd(cmd, fp);
			myLog.logAdd(myTid, LogLevelDefine.error, errLog);
			return DrvPrnDef.PRN_NG;
		}
		else {
			errLog = "tprtssDownload() read len[$len]";
			myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
		}
		 */

    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("tprtss_write 14", cmd, stSize);
    }
    if ((ret = await tprtssWrite(cmd, stSize, 0)) == DrvPrnDef.PRN_NG) {
      errLog = "tprtssDownload() write[$stSize] error ret:$ret";
      /*
			tprtssDownloadEnd(cmd, fp);
			 */
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }

    if (DrvPrnDef.DISP_BUFF) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 03");
    }
    if (await tprtssRead(
            READ_RET_ENUM.READ_DOWNLOAD_1,
            READ_ANALYSIS_ENUM.ANALYSIS_DOWNLOAD_1,
            0,
            0,
            1,
            DrvPrnDef.TPRTSS_READ_WAITTIME,
            DrvPrnDef.TPRTSS_READ_RETRY) ==
        DrvPrnDef.PRN_NG) {
      errLog = "tprtssDownload() read 1 error ret";
      /*
			tprtssDownloadEnd(cmd, fp);
			 */
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }
    if (DrvPrnDef.DISP_BUFF) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 04");
    }
    if (await tprtssRead(
            READ_RET_ENUM.READ_DOWNLOAD_2,
            READ_ANALYSIS_ENUM.ANALYSIS_DOWNLOAD_2,
            0,
            0,
            1,
            DrvPrnDef.TPRTSS_READ_WAITTIME,
            DrvPrnDef.TPRTSS_READ_RETRY) ==
        DrvPrnDef.PRN_NG) {
      errLog = "tprtssDownload() read 2 error ret";
      /*
			tprtssDownloadEnd(cmd, fp);
			 */
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }

    errLog = "tprtssDownload() write($stSize) end ret:$ret";
    myLog.logAdd(myTid, LogLevelDefine.normal, errLog);

    sleep(const Duration(seconds: 3));

    tprtssReopen();

    versionFlg = 0;
    for (i = 0; i < DrvPrnDef.TPRTSS_DWNLD_RETRY; i++) {
      if ((fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN) ||
          (fbMem.drv_stat[savePortNm] ==
              PlusDrvStat.PLUS_STS_COM_REQ_REOPEN2)) {
        if (tprtssReopen() == DrvPrnDef.PRN_OK) {
          break;
        }
      }
      sleep(const Duration(microseconds: DrvPrnDef.TPRTSS_DWNLD_WAITTIME));
    }
    versionFlg = 0;

    return DrvPrnDef.PRN_OK;
  }

  /// プリンタの機能設定の確認
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_check_swdip
  Future<int> tprtssCheckSwDip() async {
    PrintRet ret = PrintRet();
    String pbyCmdBuf = "";
    String errLog = "";

    if (DrvPrnDef.TPRTS_DEBUG) {
      errLog = "tprtssCheckSwDip() start";
      myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
    }
    // AutoStatusBack Disable
    if (await tprtssCmdCreateData(
            CMD_ENUM.TPRTS_CMD_ERR_THROW, 0, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      errLog = "tprtssCheckSwDip() TPRTS_CMD_ERR_THROW Disable error";
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }

    pbyCmdBuf = DrvPrnDef.CMD_DC2;
    pbyCmdBuf += "\x6c"; // l
    pbyCmdBuf += "\x00";

    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("sii_api_write_device 03", pbyCmdBuf, 3);
    }

    ret = ffiPtr.printerWriteDevice(pbyCmdBuf, 3);
    if (ret.result < 0) {
      errLog = "tprtssCheckSwDip() write failed[$ret]";
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    } else {
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal, "swdip get cmd write ok");
      }
    }

    if (DrvPrnDef.DISP_BUFF) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 05");
    }
    if (await tprtssRead(
            READ_RET_ENUM.READ_HEX,
            READ_ANALYSIS_ENUM.ANALYSIS_SWDIP,
            0,
            0,
            1,
            DrvPrnDef.TPRTSS_READ_WAITTIME,
            DrvPrnDef.TPRTSS_READ_RETRY) ==
        DrvPrnDef.PRN_NG) {
      errLog = "tprtssCheckSwDip() tprtssRead error";
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }
    // AutoStatusBack Enable
    if (await tprtssCmdCreateData(
            CMD_ENUM.TPRTS_CMD_ERR_THROW, 1, 0, 0, "", 0) ==
        DrvPrnDef.PRN_NG) {
      errLog = "tprtssCheckSwDip() TPRTS_CMD_ERR_THROW Enable error";
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
      return DrvPrnDef.PRN_NG;
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      errLog = "tprtssCheckSwDip() end";
      myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
    }

    return DrvPrnDef.PRN_OK;
  }

  /// プリンタの機能設定の変更
  /// 引数:[swDipNo] SW DIPパラメタNo
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_write_swdip
  Future<int> tprtssWriteSwDip(int swDipNo) async {
    PrintRet ret;
    String ucCmdBuf = "";
    var swDip = <int>[];
    List<String> dip = [];

    if (rpdFlg == DrvPrnDef.RPCONNECT) {
      if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
        dip = DrvPrnDef.SWDIP_INIT_RP80;
      } else {
        dip = DrvPrnDef.SWDIP_INIT_RP;
      }
    } else if (rpdFlg == DrvPrnDef.RPCONNECT2) {
      dip = DrvPrnDef.SWDIP_INIT_RPE;
    } else if (rpdFlg == DrvPrnDef.RPCONNECT3) {
      dip = DrvPrnDef.SWDIP_INIT_PT06;
    } else {
      dip = DrvPrnDef.SWDIP_INIT;
    }

    swDip.add(swDipNo + 1);
    if (wFlg == 0) {
      swDip.add(swDip[0] | 0x80);
    } else {
      swDip.add(swDip[0] | 0x00);
    }

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(
          myTid, LogLevelDefine.normal, "tprtssWriteSwDip() start[$swDipNo]");
    }

    ucCmdBuf = DrvPrnDef.CMD_DC2;
    ucCmdBuf += "\x77"; //w
    ucCmdBuf += latin1.decode([swDip[1]]); //f
    ucCmdBuf += dip[swDipNo]; //f
    ucCmdBuf += "\x01"; //k
    ucCmdBuf += "\x00";

    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("sii_api_write_device 04", ucCmdBuf, 6);
    }
    ret = ffiPtr.printerWriteDevice(ucCmdBuf, 6);
    if (ret.result < 0) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssWriteSwDip() write failed[${ret.result}]");
      return DrvPrnDef.PRN_NG;
    }

    if (DrvPrnDef.DISP_BUFF) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 06");
    }
    if (await tprtssRead(
            READ_RET_ENUM.READ_INIT_CMD,
            READ_ANALYSIS_ENUM.ANALYSIS_NONE,
            0,
            0,
            1,
            DrvPrnDef.TPRTSS_READ_WAITTIME,
            DrvPrnDef.TPRTSS_READ_RETRY) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssWriteSwDip() tprtssRead error");
      return DrvPrnDef.PRN_NG;
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssWriteSwDip() end");
    }

    return DrvPrnDef.PRN_OK;
  }

  /// プリンタへコマンドデータを書き込む
  /// 引数:[cmd] コマンドデータ
  ///     [len] コマンドデータ長
  ///     [resFlg] レスポンスデータ追記フラグ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_write
  Future<int> tprtssWrite(String cmd, int len, int resFlg) async {
    PrintRet ret = PrintRet();
    String pBuf = "";
    int endFlag = 0;
    int iCount = 0;
    int writeSize = 0;
    int start = 0;

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(
          myTid, LogLevelDefine.normal, "tprtssWrite() start[$len][$resFlg]");
    }

    tprtssReopen();

    // デバイスオープンチェック
    if (hTprtDrv < 0) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssWrite() tprtssReopen not open return!!");
      return DrvPrnDef.PRN_NG;
    }

    while (endFlag == 0) {
      if (iCount >= DrvPrnDef.WRITE_CNT_MAX) {
        iCount = 0;
      }
      iCount++;
      len -= ret.writeSize;
      start += ret.writeSize;
      pBuf = "";
      if (len <= DrvPrnDef.WRITE_LEN_MAX) {
        pBuf = cmd.substring(start, start + len);
        writeSize = len;
        if (resFlg > 0) {
          pBuf += DrvPrnDef.CMD_DC2;
          pBuf += "\x71"; // q
          pBuf += latin1.decode([iCount]);
          writeSize += 3;
        }
        endFlag = 1;
      } else {
        pBuf = cmd.substring(start, start + DrvPrnDef.WRITE_LEN_MAX);
        writeSize = DrvPrnDef.WRITE_LEN_MAX;
      }

      if (DrvPrnDef.DISP_BUFF) {
        dispBuff("sii_api_write_device 05", pBuf, pBuf.length);
      }

      // Dart:ffi経由で共有ライブラリにアクセス
      ret = ffiPtr.printerWriteDevice(pBuf, pBuf.length);
      if (ret.result < 0) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssWrite() sii_api_write_device(${pBuf.length}) error[$ret]");
        return DrvPrnDef.PRN_NG;
      }
    }
    if (resFlg == 1) {
      if (DrvPrnDef.DISP_BUFF) {
        myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 07");
      }
      if (await tprtssRead(
              READ_RET_ENUM.READ_REPLY,
              READ_ANALYSIS_ENUM.ANALYSIS_REPLY,
              iCount,
              1,
              1,
              DrvPrnDef.TPRTSS_READ_WAITTIME,
              DrvPrnDef.TPRTSS_READ_RETRY) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssWrite() stprtss_read error[$iCount]");
        return DrvPrnDef.PRN_NG;
      }
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssWrite() end");
    }

    return DrvPrnDef.PRN_OK;
  }

  /// プリンタからのレスポンスを取得する（リトライ回数設定付き）
  /// 引数:[hopeVal] コマンドデータ
  ///     [analysis] 解析するデータ
  ///     [flg] 解析フラグ
  ///     [errSend] エラーログ送信フラグ
  ///     [endLog] ログ終了フラグ
  ///     [wait] スリープタイマ
  ///     [retry] 読み取りリトライ数
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_read
  Future<int> tprtssRead(int hopeVal, READ_ANALYSIS_ENUM analysis, int flg,
      int errSend, int endLog, int wait, int retry) async {
    int i = 0;
    int ret = 0;
    int retVal = DrvPrnDef.PRN_NG;

    for (i = 0; i < retry; i++) {
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(
            myTid, LogLevelDefine.normal, "tprtssRead()  retry count[$i]");
      }
      ret = await tprtssReadGet(hopeVal, analysis, flg, errSend, endLog);
      if (ret == 1) {
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(
              myTid, LogLevelDefine.normal, "tprtssRead() tprtssReadGet OK!!");
        }
        retVal = DrvPrnDef.PRN_OK;
        break;
      } else if (ret < 0) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssRead() tprtssReadGet error[$hopeVal][$analysis][$errSend][$endLog][$wait][$retry]");
        break;
      } else if (1 < ret) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssRead() tprtssReadGet invalid case $ret [$i]");
      } else {
        if (prnOpenFlg == 1) {
          // 応答待ち中、OPENを検知したら、即ＮＧ
          // ※現在該当のフラグが立つことはない
          prnOpenFlg = 0;
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(
                myTid, LogLevelDefine.normal, "tprtssRead() detect prnOpen");
          }
          break;
        }
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssRead() tprtssReadGet retry GO!!!");
      }
      sleep(Duration(microseconds: wait));
    }
    retVal = DrvPrnDef.PRN_OK;
    return retVal;
  }

  /// プリンタからのレスポンスデータを取得
  /// 引数:[hopeVal] コマンドデータ
  ///     [analysis] 解析するデータ
  ///     [flg] 解析フラグ
  ///     [errSend] エラーログ送信フラグ
  ///     [endLog] ログ終了フラグ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_read_get
  Future<int> tprtssReadGet(int hopeVal, READ_ANALYSIS_ENUM analysis, int flag,
      int errSend, int endLog) async {
    String errLog = "";
    String tmpBuf = "";
    List<String> val = [];
    List<String> val3 = [];
    List<String> val2 = [];
    int retVal = DrvPrnDef.PRN_NG;
    PrintRet readRet = PrintRet();
    AnalysisRet anaRet = AnalysisRet();
    int readSiz = 0;
    int siz = 0;
    int ret = 0;
    int retPos = 0;
    int n = 0;
    int m = 0;
    int flg = 0;
    var dip = <String>[];
    int cTmp = 0;
    int i = 0;

    if (isWithoutDevice()) {
      return 1;
    }

    if ((rpdFlg == DrvPrnDef.RPCONNECT3) || (modelId == "\x25")) {
      // PT06 または RP-F(改)
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssReadGet tprtssSiiApiReadDevice[$hopeVal][$rpdFlg][$modelId]");
      }
      readRet = await tprtssSiiApiReadDevice(hopeVal, readSiz);
    } else {
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssReadGet printerReadDevice[$rpdFlg][$modelId]");
      }
      readRet = ffiPtr.printerReadDevice(DrvPrnDef.READ_BUF_SIZ);
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssReadGet sii_api_read_device readRet.result[${readRet.result}]");
    }
    if (readRet.result < 0) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssReadGet sii_api_read_device error[${readRet.result}]");
      return retVal;
    }
    val = readRet.readData;
    readSiz = readRet.readSize;

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssReadGet sii_api_read_device readSiz[$readSiz]");
    }

    anaRet.retVal.clear();
    if (readSiz > 0) {
      siz = readSiz;
      retPos = 0;
      anaRet.retValPos = anaRet.retValSiz = 0;

      outerLoop:
      while (siz > 0) {
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssReadGet ret type1[$siz][${anaRet.retValPos}]");
        }
        val3 = val.sublist(retPos, retPos + siz);

        anaRet =
            await tprtssReadAnalysis(val3, val3.length, DrvPrnDef.READ_BUF_SIZ);
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssReadGet ret type2[$siz][${anaRet.retValPos}]");
        }
        val2 = anaRet.retVal;

        if ((anaRet.result == READ_RET_ENUM.READ_ERR) && (errSend != 0)) {
          errLog =
              "tprtssReadGet ret type3[${anaRet.result}][${anaRet.retValSiz}]";
          for (i = 0; i < val2.length; i++) {
            errLog +=
                "[${int.parse(val2[i]).toRadixString(16).padLeft(2, "0")}]";
          }
          retVal = DrvPrnDef.PRN_NG;
          break outerLoop;
        }
        if (anaRet.result == hopeVal) {
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal,
                "tprtssReadGet [${anaRet.result}][${anaRet.retValSiz}][$hopeVal][$analysis]");
          }
          flg = 1;
          while (true) {
            switch (analysis) {
              case READ_ANALYSIS_ENUM.ANALYSIS_SWDIP:
                if (!((anaRet.result == READ_RET_ENUM.READ_HEX) &&
                    (anaRet.retValSiz == 40))) {
                  if (DrvPrnDef.TPRTS_DEBUG) {
                    myLog.logAdd(myTid, LogLevelDefine.normal,
                        "ANALYSIS_SWDIP Data mismatch [${anaRet.retValSiz} : 40]");
                  }
                  flg = 0;
                }
                break;
              case READ_ANALYSIS_ENUM.ANALYSIS_VER:
                if (!((anaRet.result == READ_RET_ENUM.READ_CHAR) &&
                    (anaRet.retValSiz == 7))) {
                  if (DrvPrnDef.TPRTS_DEBUG) {
                    myLog.logAdd(myTid, LogLevelDefine.normal,
                        "ANALYSIS_VER Data mismatch [${anaRet.retValSiz} : 7]");
                  }
                  flg = 0;
                }
                break;
              case READ_ANALYSIS_ENUM.ANALYSIS_ID:
                if (!((anaRet.result == READ_RET_ENUM.READ_HEX) &&
                    (anaRet.retValSiz == 1))) {
                  if (DrvPrnDef.TPRTS_DEBUG) {
                    myLog.logAdd(myTid, LogLevelDefine.normal,
                        "ANALYSIS_ID Data mismatch [${anaRet.retValSiz} : 1]");
                  }
                  flg = 0;
                }
                break;
              case READ_ANALYSIS_ENUM.ANALYSIS_MCOUNTER:
                if (!((anaRet.result == READ_RET_ENUM.READ_HEX) &&
                    (anaRet.retValSiz == 4))) {
                  if (DrvPrnDef.TPRTS_DEBUG) {
                    myLog.logAdd(myTid, LogLevelDefine.normal,
                        "ANALYSIS_MCOUNTER Data mismatch [${anaRet.retValSiz} : 4]");
                  }
                  flg = 0;
                }
                break;
              case READ_ANALYSIS_ENUM.ANALYSIS_GETSTAT:
                // PT06 または RP-F(改)
                if ((rpdFlg == DrvPrnDef.RPCONNECT3) || (modelId == "\x25")) {
                  if (!((anaRet.result == READ_RET_ENUM.READ_STAT) &&
                      (anaRet.retValSiz == 1))) {
                    if (DrvPrnDef.TPRTS_DEBUG) {
                      myLog.logAdd(myTid, LogLevelDefine.normal,
                          "01 ANALYSIS_GETSTAT Data mismatch [${anaRet.retValSiz} : 2]");
                    }
                    for (i = 0; i < val2.length; i++) {
                      tmpBuf =
                          "[${int.parse(val2[i]).toRadixString(16).padLeft(2, "0")}]";
                    }
                    if (DrvPrnDef.TPRTS_DEBUG) {
                      myLog.logAdd(myTid, LogLevelDefine.normal, tmpBuf);
                    }
                    flg = 0;
                  } else {
                    siz = 0;
                  }
                } else {
                  if (!((anaRet.result == READ_RET_ENUM.READ_HEX) &&
                      (anaRet.retValSiz == 2))) {
                    if (DrvPrnDef.TPRTS_DEBUG) {
                      myLog.logAdd(myTid, LogLevelDefine.normal,
                          "01 ANALYSIS_GETSTAT Data mismatch [${anaRet.retValSiz} : 2]");
                    }
                    flg = 0;
                  } else {
                    if ((int.parse(val2[1]) & 0x0f) != 0x0f) {
                      tmpBuf = (int.parse(val2[1]) & 0x0f)
                          .toRadixString(16)
                          .padLeft(2, "0");
                      if (DrvPrnDef.TPRTS_DEBUG) {
                        myLog.logAdd(myTid, LogLevelDefine.normal,
                            "01 ANALYSIS_GETSTAT Data mismatch [$tmpBuf : 0f]");
                      }
                      flg = 0;
                    } else {
                      siz = 0;
                    }
                  }
                }
                break;
              case READ_ANALYSIS_ENUM.ANALYSIS_REPLY:
                if (!((anaRet.result == READ_RET_ENUM.READ_REPLY) &&
                    (anaRet.retValSiz == 1))) {
                  if (DrvPrnDef.TPRTS_DEBUG) {
                    myLog.logAdd(myTid, LogLevelDefine.normal,
                        "ANALYSIS_REPLY Data mismatch [$anaRet.retValSiz : 1]");
                  }
                  flg = 0;
                } else {
                  if (((int.parse(val2[0])) & 0xff) != (0x80 + flag)) {
                    tmpBuf = "[${(int.parse(val2[0]) & 0xff).toRadixString(16).padLeft(2, "0")}]";
                    tmpBuf += " != ";
                    tmpBuf += "[${(0x80 + flag).toRadixString(16).padLeft(2, "0")}]";
                    if (DrvPrnDef.TPRTS_DEBUG) {
                      myLog.logAdd(myTid, LogLevelDefine.normal,
                          "tprtssReadGet Getting Another Reply$tmpBuf");
                    }
                    flg = 0;
                  }
                }
                break;
              case READ_ANALYSIS_ENUM.ANALYSIS_DOWNLOAD_1:
              case READ_ANALYSIS_ENUM.ANALYSIS_DOWNLOAD_2:
                flg = 1;
                break;
              default:
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssReadGet no care Analysys [$analysis]");
                }
                break;
            }
            break;
          }
          if (flg == 1) {
            while (true) {
              switch (analysis) {
                case READ_ANALYSIS_ENUM.ANALYSIS_SWDIP:
                  if (rpdFlg == DrvPrnDef.RPCONNECT) {
                    m = DrvPrnDef.SWDIP_CHK_MAX_RP;
                    if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
                      dip = DrvPrnDef.SWDIP_INIT_RP80;
                    } else {
                      dip = DrvPrnDef.SWDIP_INIT_RP;
                    }
                  } else if (rpdFlg == DrvPrnDef.RPCONNECT2) {
                    m = DrvPrnDef.SWDIP_CHK_MAX_RP;
                    dip = DrvPrnDef.SWDIP_INIT_RPE;
                  } else if (rpdFlg == DrvPrnDef.RPCONNECT3) {
                    m = DrvPrnDef.SWDIP_CHK_MAX_RP;
                    dip = DrvPrnDef.SWDIP_INIT_PT06;
                  } else if (rpdFlg == DrvPrnDef.RPCONNECT4) {
                    m = DrvPrnDef.SWDIP_CHK_MAX_RP;
                    dip = DrvPrnDef.SWDIP_INIT_SLP;
                  } else {
                    m = DrvPrnDef.SWDIP_CHK_MAX;
                    dip = DrvPrnDef.SWDIP_INIT;
                  }

                  for (n = 0; n < m; n++) {
                    if ((int.parse(val2[n], radix: 16) & 0xff) !=
                        dip.elementAt(n).codeUnitAt(0)) {
                      tmpBuf = "SWDIP[${n + 1}]";
                      tmpBuf +=
                          "Set[0x${(int.parse(val2[n], radix: 16) & 0xff).toRadixString(16)}]";
                      tmpBuf +=
                          "->[0x${dip.elementAt(n).codeUnitAt(0).toRadixString(16)}]";

                      if (DrvPrnDef.TPRTS_DEBUG) {
                        myLog.logAdd(myTid, LogLevelDefine.normal,
                            "tprtssReadGet $tmpBuf");
                      }
                      ret = await tprtssWriteSwDip(n);
                      if (ret != 0) {
                        errLog = "tprtssReadGet tprtss_write_swdip error";
                        retVal = DrvPrnDef.PRN_NG;
                        break outerLoop;
                      }
                    }
                  }
                  break;
                case READ_ANALYSIS_ENUM.ANALYSIS_VER:
                  version.clear();
                  for (i = 0; i < val2.length; i++) {
                    version.add(int.parse(val2[i]));
                  }
                  version[0] = (version[0] - 0x30) & 0xff;
                  version[1] = (((version[2] - 0x30) & 0xff) << 4) +
                      ((version[3] - 0x30) & 0xff);
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssReadGet Get Version[$version]");
                  break;
                case READ_ANALYSIS_ENUM.ANALYSIS_ID:
                  modelId = val2[0];
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssReadGet Get ID[$modelId]");

                  break;
                case READ_ANALYSIS_ENUM.ANALYSIS_MCOUNTER:
                  cTmp = int.parse(val2[0]) +
                      (int.parse(val2[1]) << 8) +
                      (int.parse(val2[2]) << 16) +
                      (int.parse(val2[3]) << 24);

                  if (detectNearEnd == 1) {
                    if (isSetBase == 1) {
                      currCount = cTmp + countOffset;
                    } else {
                      retVal = await tprtssReadCounter(cTmp);
                      if (retVal == DrvPrnDef.PRN_NG) {
                        break outerLoop;
                      }
                    }
                  } else {
                    if ((isSetBase == 1) && (checkFail == 0xff)) {
                      retVal = await tprtssReadCounter(cTmp);
                      if (retVal == DrvPrnDef.PRN_NG) {
                        errLog = "tprtssReadGet tprtss_read_counter";
                        break outerLoop;
                      }
                    } else if (isSetBase == 1) {
                      currCount = cTmp + countOffset;
                    }
                  }

                  if (prevCount != currCount) {
                    await counter.load();
                    counter.tran.nearend_curr = currCount;
                    await counter.save();
                    prevCount = currCount;
                  }
                  break;
                case READ_ANALYSIS_ENUM.ANALYSIS_GETSTAT:
                  if (int.parse(val2[0]) & 0x02 != 0) {
                    // ニアエンド
                    if ((detectNearEnd == 0) &&
                        (isSetBase == 0) &&
                        (nearEndCheck == 1) &&
                        (noteCount != 0) &&
                        (checkFail != 0xff)) {
                      // ニアエンド確定前
                      checkFail++;

                      if (tprtMaxFail <= checkFail) {
                        // ニアエンド確定？
                        detectNearEnd = 1;
                        checkFail = 0xff;

                        myLog.logAdd(myTid, LogLevelDefine.error,
                            "tprtssReadGet nearend count up start");
                      }
                      tmpBuf = latin1.decode([checkFail & 0x03]);
                      tmpBuf += "/";
                      tmpBuf += latin1.decode([tprtMaxFail]);
                      if (DrvPrnDef.TPRTS_DEBUG) {
                        myLog.logAdd(myTid, LogLevelDefine.normal,
                            "tprtssReadGet [RP-E11] Detect nearend [${checkFail & 0x03}/$tprtMaxFail]");
                      }
                      await counter.load();
                      counter.tran.nearend_check_fail = checkFail;
                      await counter.save();
                    } else {
                      detectNearEnd = 1;
                    }
                  } else {
                    // ！ニアエンド
                    if (DrvPrnDef.TPRTS_DEBUG) {
                      myLog.logAdd(
                          myTid, LogLevelDefine.normal, "[RP-E11] Normal");
                    }
                    if ((1 <= checkFail) && (checkFail < tprtMaxFail)) {
                      // ニアエンド確定前にニアエンド解消
                      detectNearEnd = 0;
                      checkFail = 0;

                      await counter.load();
                      counter.tran.nearend_check_fail = 0;
                      await counter.save();

                      if (DrvPrnDef.TPRTS_DEBUG) {
                        myLog.logAdd(myTid, LogLevelDefine.normal,
                            "[RP-E11] checkFail clear");
                      }
                    } else {
                      detectNearEnd = 0;
                    }
                  }
                  break;
                case READ_ANALYSIS_ENUM.ANALYSIS_REPLY:
                  break;
                default:
                  if (DrvPrnDef.TPRTS_DEBUG) {
                    myLog.logAdd(myTid, LogLevelDefine.normal,
                        "tprtssReadGet no care Analysys [$analysis]");
                  }
                  break;
              }
              break;
            }
            retVal = 1;
            if (endLog != 0) {
              if (DrvPrnDef.TPRTS_DEBUG) {
                myLog.logAdd(myTid, LogLevelDefine.normal,
                    "tprtssReadGet return ok [$ret]");
              }
            }
          }
        } else if (statusErr != DrvPrnDef.PRN_OK) {
          errLog = "tprtssReadGet tprtss_read_analysis statusErr Seaching!!";
          retVal = DrvPrnDef.PRN_NG;
          break outerLoop;
        }
        if (anaRet.retValPos == 0) {
          errLog = "tprtssReadGet tprtss_read_analysis retPos2 is 0 error";
          retVal = DrvPrnDef.PRN_NG;
          break outerLoop;
        }
        siz -= anaRet.retValPos;
        retPos += anaRet.retValPos;
      }
    } else {
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssReadGet Size 0 data");
      }
    }

    if (errLog.isNotEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
    }
    if (isWithoutDevice()) {
      retVal = 1;
    }

    return retVal;
  }

  /// プリンタからのレスポンスデータを解析する
  /// 引数:[data] 解析対象データ
  ///     [dataLen] 解析対象データの長さ
  ///     [retValPos] 読み取るデータのインデックス [in/out]
  ///     [retvalSiz] 読み取るデータの長さ [in/out]
  ///     [retVal] 解析したデータ [in/out]
  ///     [retValLen] 解析したデータの長さ
  /// 戻り値：0以上 = Normal End
  ///       -1以下 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_read_analysis
  Future<AnalysisRet> tprtssReadAnalysis(
      List<String> data, int dataLen, int retValLen) async {
    int i = 0;
    int j = 0;
    int siz = 0;
    int flg = 0;
    int lStatus = 0;
    String errLog = "";
    int upside = 0;
    int downside = 0;
    String tmpLog = "";
    AnalysisRet ret = AnalysisRet();

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(
          myTid, LogLevelDefine.normal, "tprtssReadAnalysis Start![$dataLen]");
    }

    ret.result = READ_RET_ENUM.READ_NONE;
    if (data.isEmpty) {
      ret.result = READ_RET_ENUM.READ_SYSERR;
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssReadAnalysis param[$data] error");
      return ret;
    }
    ret.retValPos = ret.retValSiz = siz = 0;
    outerLoop:
    for (i = 0; i < dataLen; i++) {
/*
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssReadAnalysis Data[$i][${int.parse(data[i])}]!");
      int aaa = int.parse(data[i]) & 0xf0;
      int bbb = int.parse(data[i]) & 0xff;
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssReadAnalysis Data[${aaa.toRadixString(16)}][${bbb.toRadixString(16)}]!");
*/
      int aaa = int.parse(data[i]) & 0xf0;
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssReadAnalysis kind[${aaa.toRadixString(16)}]!");
      }

      switch (int.parse(data[i]) & 0xf0) {
        case 0x00:
          if ((int.parse(data[i]) & 0xff) == 0x02) {
            // charactor
            flg = 0;
            for (j = i + 1; j < dataLen; j++) {
              if ((int.parse(data[j]) & 0xff) == 0x00) {
                flg = 1;
                break;
              } else {
                if (siz >= retValLen) {
                  errLog = "tprtssReadAnalysis overflow[$siz][$retValLen]";
                  ret.result = READ_RET_ENUM.READ_ERR;
                  break outerLoop;
                }
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssReadAnalysis data[j][${int.parse(data[j]).toRadixString(16)}]!");
                }
                ret.retVal.add(data[j]);
                siz++;
              }
            }
            if ((flg == 0) || (siz == 0)) {
              errLog = "tprtssReadAnalysis <char> not end[$flg][$siz]";
              ret.result = READ_RET_ENUM.READ_ERR;
              break outerLoop;
            }
            ret.retValPos = j + 1; // next is dataLen - (j + 1)
            ret.retValSiz = siz;
            ret.result = READ_RET_ENUM.READ_CHAR;
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop1");
            }
            break outerLoop;
          } else if ((int.parse(data[i]) & 0xff) == 0x0e) {
            // hex
            flg = 0;
            for (j = i + 1; j < dataLen; j++) {
              if ((int.parse(data[j]) & 0xff) == 0x00) {
                flg = 1;
                break;
              } else if ((int.parse(data[j]) & 0xe0) != 0xe0) {
                tmpLog = (int.parse(data[j]) & 0xff)
                    .toRadixString(16)
                    .padLeft(2, "0");
                errLog =
                    "tprtssReadAnalysis <hex> 0xe? error[$siz] [$j][$tmpLog]";
                ret.result = READ_RET_ENUM.READ_ERR;
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop2");
                }
                break outerLoop;
              }
              if ((j + 1) >= dataLen) {
                errLog =
                    "tprtssReadAnalysis <hex> 0xf? over[$siz] [$j][$dataLen]";
                ret.result = READ_RET_ENUM.READ_ERR;
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop3");
                }
                break outerLoop;
              }
/*
              int ccc = int.parse(data[j]) & 0x0f;
              int ddd = int.parse(data[j + 1]) & 0xff;
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssReadAnalysis Data[${ccc.toRadixString(16)}][${ddd.toRadixString(16)}]!");
*/
              downside = int.parse(data[j]) & 0x0f;
              if ((int.parse(data[j + 1]) & 0xff) == 0x00) {
                upside = 0x0f;
                ret.retVal.add((downside | (upside << 4)).toRadixString(16));
                flg = 1;
                j++;
                siz++;
                break;
              }
              if ((int.parse(data[j + 1]) & 0xf0) != 0xf0) {
                upside = 0x0f;
              } else {
                upside = int.parse(data[j + 1]) & 0x0f;
                j++;
              }
              if (siz >= retValLen) {
                errLog = "%s <hex> overflow[$siz][$retValLen]";
                ret.result = READ_RET_ENUM.READ_ERR;
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop4");
                }
                break outerLoop;
              }
              ret.retVal.add((downside | (upside << 4)).toRadixString(16));
              siz++;
            }
            if ((flg == 0) || (siz == 0)) {
              errLog = "tprtssReadAnalysis <hex> not end[$flg][$siz]";
              ret.result = READ_RET_ENUM.READ_ERR;
              if (DrvPrnDef.TPRTS_DEBUG) {
                myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop5");
              }
              break outerLoop;
            }
            ret.retValPos = j + 1; // next is dataLen - (j + 1)
            ret.retValSiz = siz;
            ret.result = READ_RET_ENUM.READ_HEX;
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop6");
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtssReadAnalysis retVal[${ret.retVal}]!");
            }
            break outerLoop;
          } else if ((int.parse(data[i]) & 0xff) == 0x00) {
            ret.retVal.add(data[i]);
            siz++;
            ret.retValPos = i + 1; // next is dataLen - (i + 1)
            ret.retValSiz = siz;
            ret.result = READ_RET_ENUM.READ_DOWNLOAD_1;
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop7");
            }
            break outerLoop;
          } else {
            tmpLog =
                (int.parse(data[i]) & 0xff).toRadixString(16).padLeft(2, "0");
            errLog = "tprtss_read_analysis first error[$tmpLog]";
            ret.result = READ_RET_ENUM.READ_ERR;
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop8");
            }
            break outerLoop;
          }
        case 0x80:
          ret.retVal.add(data[i]);
          siz++;
          ret.retValPos = i + 1; // next is dataLen - (j + 1)
          ret.retValSiz = siz;
          ret.result = READ_RET_ENUM.READ_REPLY;
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop9");
          }
          break outerLoop;
        case 0xa0:
          // PT06 または RP-F(改)
          if ((rpdFlg == DrvPrnDef.RPCONNECT3) || (modelId == "\x25")) {
            ret.retVal.add((int.parse(data[i]) & 0x0f).toString());
            siz++;
            ret.retValPos = i + 1;
            ret.retValSiz = siz;
            ret.result = READ_RET_ENUM.READ_STAT;
          } else {
            ret.retVal.add((int.parse(data[i]) & 0x0f).toString());
            siz++;
            ret.retVal.add((int.parse(data[i + 1]) & 0x0f).toString());
            siz++;
            ret.retValPos = i + 2;
            ret.retValSiz = siz;
            ret.result = READ_RET_ENUM.READ_HEX;
          }
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop10");
          }
          break outerLoop;
        case 0xb0:
          switch (int.parse(data[i]) & 0xff) {
            case 0xb0:
              ret.result = READ_RET_ENUM.READ_INIT_HW;
              break;
            case 0xb1:
              ret.result = READ_RET_ENUM.READ_INIT_SW;
              break;
            case 0xb2:
              ret.result = READ_RET_ENUM.READ_INIT_CMD;
              break;
            default:
              tmpLog =
                  (int.parse(data[i]) & 0xff).toRadixString(16).padLeft(2, "0");
              errLog = "tprtss_read_analysis initial end abnormal code[%02x]";
              ret.result = READ_RET_ENUM.READ_ERR;
              if (DrvPrnDef.TPRTS_DEBUG) {
                myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop11");
              }
              break outerLoop;
          }
          ret.retValPos = i + 1;
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop12");
          }
          break outerLoop;
        case 0xc0:
          if ((i + 7) >= dataLen) {
            for (j = i; j < dataLen;) {
              tmpLog +=
                  "[${(int.parse(data[j]) & 0xff).toRadixString(16).padLeft(2, "0")}]";
            }
            errLog +=
                "tprtss_read_analysis auto status reply short[$i][$dataLen][$tmpLog]";

            ret.result = READ_RET_ENUM.READ_ERR;
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop13");
            }
            break outerLoop;
          }
          if (((int.parse(data[i + 1]) & 0xf0) == 0xd0) &&
              ((int.parse(data[i + 2]) & 0xf0) == 0xd0) &&
              ((int.parse(data[i + 3]) & 0xf0) == 0xd0) &&
              ((int.parse(data[i + 4]) & 0xf0) == 0xd0) &&
              ((int.parse(data[i + 5]) & 0xf0) == 0xd0) &&
              ((int.parse(data[i + 6]) & 0xf0) == 0xd0) &&
              ((int.parse(data[i + 7]) & 0xf0) == 0xd0)) {
            lStatus = 0;
            if ((int.parse(data[i + 1]) & 0x01) == 0x01) {
              lStatus |= DrvPrnDef.TPRTSS_STAT_PAPEREND;
            }
            if ((int.parse(data[i + 1]) & 0x02) == 0x02) {
              lStatus |= DrvPrnDef.TPRTSS_STAT_NEAREND;
            }
            if ((int.parse(data[i + 1]) & 0x08) == 0x08) {
              lStatus |= DrvPrnDef.TPRTSS_STAT_PRTNOPN;
            }
            if ((int.parse(data[i + 0]) & 0x08) == 0x08) {
              lStatus |= DrvPrnDef.TPRTSS_STAT_CUTERR;
            }
            if ((int.parse(data[i + 3]) & 0x08) == 0x08) {
              lStatus |= DrvPrnDef.TPRTSS_STAT_DRWHIGH;
            }
            if (((int.parse(data[i + 0]) & 0x01) == 0x01) ||
                ((int.parse(data[i + 0]) & 0x02) == 0x02) ||
                ((int.parse(data[i + 0]) & 0x04) == 0x04)) {
              errLog = (int.parse(data[i + 0]) & 0xff)
                  .toRadixString(16)
                  .padLeft(2, "0");
              myLog.logAdd(myTid, LogLevelDefine.error,
                  "tprtss_read_analysis PrintStatus err[$errLog]");

              lStatus |= DrvPrnDef.TPRTSS_STAT_PRTNOPN;
              if ((int.parse(data[i + 0]) & 0x02) == 0x02) {
                hwResetFlg = 0;
              }
            } else {
              if (hwResetCnt != 0) {
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtss_read_analysis CMD_HW_RESET recovery cnt:$hwResetCnt");
                }
                tprtssEjTxt(DrvPrnDef.HW_RECOVER, hwResetCnt);
                hwResetCnt = 0;
              }
            }
            await tprtssSetStatus(DrvPrnDef.PRN_OK, lStatus, 1, 0);
            i += 7;
            if (lStatus != 0) {
              ret.retVal.add("1");
              siz++;
              ret.retValSiz = siz;
            }
          } else {
            tmpLog = (int.parse(data[i + 0]) & 0xff)
                .toRadixString(16)
                .padLeft(2, "0");
            tmpLog += (int.parse(data[i + 1]) & 0xff)
                .toRadixString(16)
                .padLeft(2, "0");
            tmpLog += (int.parse(data[i + 2]) & 0xff)
                .toRadixString(16)
                .padLeft(2, "0");
            tmpLog += (int.parse(data[i + 3]) & 0xff)
                .toRadixString(16)
                .padLeft(2, "0");
            tmpLog += (int.parse(data[i + 4]) & 0xff)
                .toRadixString(16)
                .padLeft(2, "0");
            tmpLog += (int.parse(data[i + 5]) & 0xff)
                .toRadixString(16)
                .padLeft(2, "0");
            tmpLog += (int.parse(data[i + 6]) & 0xff)
                .toRadixString(16)
                .padLeft(2, "0");
            tmpLog += (int.parse(data[i + 7]) & 0xff)
                .toRadixString(16)
                .padLeft(2, "0");
            errLog =
                "tprtss_read_analysis auto status reply data error[$tmpLog]";
            ret.result = READ_RET_ENUM.READ_ERR;
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop14");
            }
            break outerLoop;
          }
          ret.retValPos = i + 1; // next is dataLen - (j + 1)
          ret.result = READ_RET_ENUM.READ_STAT;
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop15");
          }
          break outerLoop;
        case 0x40:
          if ((i + 1) >= dataLen) {
            ret.retValPos = i + 1;

            tmpLog =
                (int.parse(data[i]) & 0xff).toRadixString(16).padLeft(2, "0");
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtss_read_analysis Another Answer1[$tmpLog] !!");
            }
            errLog = "";
            break;
          }
          if (((int.parse(data[0]) & 0xff) == 0x4f) &&
              ((int.parse(data[1]) & 0xff) == 0x4b)) {
            ret.retValPos = i + 2;
            ret.result = READ_RET_ENUM.READ_DOWNLOAD_2;
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal, "outerLoop16");
            }
            break outerLoop;
          } else {
            ret.retValPos = i + 1;
            tmpLog =
                (int.parse(data[i]) & 0xff).toRadixString(16).padLeft(2, "0");
            if (DrvPrnDef.TPRTS_DEBUG) {
              myLog.logAdd(myTid, LogLevelDefine.normal,
                  "tprtss_read_analysis Another Answer2[$tmpLog]!!");
            }
            errLog = "";
          }
          break;
        case 0x20:
        case 0x30:
        case 0x50:
        case 0x60:
        case 0x70:
        case 0x90:
        case 0xd0:
        case 0xe0:
        case 0xf0:
        case 0x10:
          ret.retValPos = i + 1;
          tmpLog =
              (int.parse(data[i]) & 0xff).toRadixString(16).padLeft(2, "0");
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal,
                "tprtss_read_analysis Another Answer3[$tmpLog]!!");
          }
          errLog = "";
          break;
      }
      myLog.logAdd(myTid, LogLevelDefine.error, "loop deflult");
    }
    // outerLoop
    if (errLog.isNotEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);
    }
    return ret;
  }

  /// プリンタと切断
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_close
  void tprtssClose() {
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(
          myTid, LogLevelDefine.normal, "tprtssClose() start[$hTprtDrv]");
    }

    if (hTprtDrv != -1) {
      // Dart:ffi経由で共有ライブラリにアクセス
      // デバイスクローズ
      ffiPtr.printerCloseDevice();
      hTprtDrv = -1;
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssClose() end");
    }
  }

  /// プリンタと接続
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_open
  int tprtssOpen() {
    int i = 0;
    String devPath = "";

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssOpen() start");
    }
    switch (devOrder) {
      case DrvPrnDef.DESK_PRINTER:
        devPath = DrvPrnDef.TPRTSSDRV;
        break;
      case DrvPrnDef.QCJC_PRINTER:
        devPath = DrvPrnDef.TPRTSS2DRV;
        break;
      case DrvPrnDef.COUPON_PRINTER:
        devPath = DrvPrnDef.TPRTCPN;
        break;
      default:
        break;
    }

    tprtssClose();

    for (i = 0; i < DrvPrnDef.TPRTSS_OPEN_RETRY; i++) {
      // Dart:ffi経由で共有ライブラリにアクセス
      // デバイスオープン
      PrintRet isSuccess = ffiPtr.printerOpenDevice(devPath);
      if (isSuccess.result == 0) {
        hTprtDrv = 0;
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(
              0, LogLevelDefine.normal, "Linux printer port open success.");
        }
        break;
      }
      sleep(const Duration(microseconds: DrvPrnDef.TPRTSS_OPEN_WAITTIME));
    }

    if (hTprtDrv == -1) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "Linux printer port open failed.");
      return DrvPrnDef.PRN_NG;
    }
    sleep(const Duration(microseconds: DrvPrnDef.TPRTSS_OPEN_AFTERWAIT));

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(
          myTid, LogLevelDefine.normal, "Linux printer port open success.");
    }

    return DrvPrnDef.PRN_OK;
  }

  /// デバイスリセット
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_reset
  Future<int> tprtssReset() async {
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssReset() start");
    }
    hTprtDrv = -1;
    PrintRet ret = ffiPtr.printerResetDevice();
    if (ret.result < 0) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssReset() sii_api_reset_device error");
      return DrvPrnDef.PRN_NG;
    }
    hTprtDrv = 0;

    if (DrvPrnDef.DISP_BUFF) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 08");
    }
    if (await tprtssRead(
            READ_RET_ENUM.READ_INIT_SW,
            READ_ANALYSIS_ENUM.ANALYSIS_NONE,
            0,
            0,
            1,
            DrvPrnDef.TPRTSS_READ_WAITTIME,
            DrvPrnDef.TPRTSS_READ_RETRY) ==
        DrvPrnDef.PRN_NG) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "tprtssReset() tprtssRead failed");
      return DrvPrnDef.PRN_NG;
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssReset() end");
    }

    return DrvPrnDef.PRN_OK;
  }

  /// プリンタに再接続する
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_reopen
  int tprtssReopen() {
    if ((savePortNm != PlusDrvChk.PLUS_TPRTF) &&
        (savePortNm != PlusDrvChk.PLUS_TPRTF2) &&
        (savePortNm != PlusDrvChk.PLUS_CPNPRN)) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssReopen() savePortNm Illegal[$savePortNm]");
      return DrvPrnDef.PRN_NG;
    }

    if ((fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN) ||
        (fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN2) ||
        (fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_CLOSE)) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssReopen() request[$savePortNm][${fbMem.drv_stat[savePortNm]}]");

      tprtssClose();

      if (fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_CLOSE) {
        fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MSG_SET_CLOSE;
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(
              myTid, LogLevelDefine.normal, "tprtssReopen() set CLOSE");
        }
        if ((devOrder == DrvPrnDef.COUPON_PRINTER) && retryFlg == 1) {
          retryFlg = 1;
        }
        if ((devOrder == DrvPrnDef.COUPON_PRINTER) || shareFlg == 1) {
          /* TODO:共有メモリ更新 */
          pCom.kitchen_prn1_run = 2;
        }
        return DrvPrnDef.PRN_OK;
      }
      if (tprtssOpen() == DrvPrnDef.PRN_NG) {
        myLog.logAdd(
            myTid, LogLevelDefine.error, "tprtssReopen() reopen error");
        return DrvPrnDef.PRN_NG;
      }
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssReopen() ok");
      }
      fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MNG_SET_OK;
      usbFlg = 1;
      if ((devOrder == DrvPrnDef.COUPON_PRINTER) && retryFlg == 1) {
        retryFlg = 0;
      }
      if ((devOrder == DrvPrnDef.COUPON_PRINTER) || shareFlg == 1) {
        /* TODO:共有メモリ更新 */
        pCom.kitchen_prn1_run = 1;
      }
    }

    return DrvPrnDef.PRN_OK;
  }

  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_semop
  // int tprtssSemOp(SemBuf aSops, int aNSops, bool mode) {
  //   // TODO:不要
  //   return 0;
  // }

  /// メンテナンスカウンタの値（紙送り行数）を取得する
  /// 引数:[num] 書き込むコマンドデータ内部に付与するナンバー
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_mcounter
  Future<void> tprtssMCounter(int num) async {
    PrintRet ret = PrintRet();
    String pbyCmdBuf = "";

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssMCounter() start");
    }
    pbyCmdBuf = DrvPrnDef.CMD_GS;
    pbyCmdBuf += "\x67";
    pbyCmdBuf += "\x32";
    pbyCmdBuf += "\x00";
    pbyCmdBuf += latin1.decode([num & 0xFF]);
    pbyCmdBuf += latin1.decode([(num >> 8) & 0xFF]);

    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("sii_api_write_device 06", pbyCmdBuf, 6);
    }

    ret = ffiPtr.printerWriteDevice(pbyCmdBuf, 6);
    if (ret.result < 0) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssMCounter() [RP-E11] sii_api_write_device failed[${ret.result}]");
      return;
    } else {
      if (DrvPrnDef.DISP_BUFF) {
        myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 09");
      }
      if (await tprtssRead(
              READ_RET_ENUM.READ_HEX,
              READ_ANALYSIS_ENUM.ANALYSIS_MCOUNTER,
              0,
              0,
              1,
              DrvPrnDef.TPRTSS_READ_WAITTIME,
              DrvPrnDef.TPRTSS_READ_RETRY) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssMCounter() [RP-E11] tprtssRead failed");
        return;
      }
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssMCounter() normal end");
    }

    return;
  }

  /// プリンタの状態2のステータスを取得する
  /// 引数:[num] 書き込むコマンドデータ内部に付与するナンバー
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_get_status
  Future<void> tprtssGetStatus(int num) async {
    PrintRet ret = PrintRet();
    String pbyCmdBuf = "";

    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal, "tprtssGetStatus() start");
    }

    if ((rpdFlg == DrvPrnDef.RPCONNECT3) || (modelId == "\x25")) {
      // PT06 または RP-F(改)
      pbyCmdBuf = DrvPrnDef.CMD_GS;
      pbyCmdBuf += "\x72";
      pbyCmdBuf += latin1.decode([num & 0xFF]);
    } else {
      pbyCmdBuf = DrvPrnDef.CMD_GS;
      pbyCmdBuf += "\x72";
      pbyCmdBuf += latin1.decode([num & 0xFF]);
      pbyCmdBuf += DrvPrnDef.CMD_DC2;
      pbyCmdBuf += "\x71";
      pbyCmdBuf += "\x0f";
    }

    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("sii_api_write_device 07", pbyCmdBuf, pbyCmdBuf.length);
    }

    ret = ffiPtr.printerWriteDevice(pbyCmdBuf, pbyCmdBuf.length);
    if (ret.result < 0) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssGetStatus() sii_api_write_device failed[${ret.result}]");
      return;
    } else {
      if (DrvPrnDef.DISP_BUFF) {
        myLog.logAdd(myTid, LogLevelDefine.normal, "]] tprtssRead 10");
      }
      if (await tprtssRead(
              READ_RET_ENUM.READ_STAT,
              READ_ANALYSIS_ENUM.ANALYSIS_GETSTAT,
              0,
              0,
              1,
              DrvPrnDef.TPRTSS_READ_WAITTIME,
              DrvPrnDef.TPRTSS_READ_RETRY) ==
          DrvPrnDef.PRN_NG) {
        myLog.logAdd(
            myTid, LogLevelDefine.error, "tprtssGetStatus() tprtssRead failed");
        return;
      }
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(
          myTid, LogLevelDefine.normal, "tprtssGetStatus() normal end");
    }

    return;
  }

  /// ニアエンド（カウンタが設定値に到達した時の）通知
  /// 引数:[status] ステータスデータ
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_print_nearend_info
  Future<void> tprtssPrintNearEndInfo(int status) async {
    int diffCount = 0;

    if (currCount < baseCount) {
      diffCount = ~baseCount + currCount;
    } else {
      diffCount = currCount - baseCount;
    }

    if (diffCount < noteCount) {
      // カウンタ設定値未達
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssPrintNearEndInfo() nearend count${currCount - baseCount}/$noteCount");
      }
      /* TODO:共有メモリ更新 */
      if (taskOrder == 1) {
        pCom.printer_near_end = 0;
      } else {
        pCom.printer_near_end_JC_C = 0;
      }
    } else {
      // カウンタ設定値到達
      forceDisp = 1;
      isSetBase = 0;
      baseCount = 0;
      currCount = 0;
      prevCount = 0;
      countOffset = 0;

      await counter.load();
      counter.tran.nearend_base = 0;
      counter.tran.nearend_curr = 0;
      counter.tran.nearend_check_fail = 0;
      await counter.save();

      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "[RP-E11] set forceDisp by NEAREND ${currCount - baseCount}/$noteCount");
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssPrintNearEndInfo() NEAREND[$status]");
      }

      /* TODO:共有メモリ更新 */
      if (taskOrder == 1) {
        pCom.printer_near_end = 1;
      } else {
        pCom.printer_near_end_JC_C = 1;
      }
      statusVal[2] |= (1 << 5);
    }
  }

  /// 設定ファイルからニアエンドのカウント取得と現在のカウント更新
  /// 引数:[cTmp] 基準となるカウント数
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_read_counter
  Future<int> tprtssReadCounter(int cTmp) async {
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(
          myTid, LogLevelDefine.normal, "[RP-E11] read nearend_base from ini");
    }
    await counter.load();
    baseCount = counter.tran.nearend_base;
    myLog.logAdd(myTid, LogLevelDefine.normal,
        "tprtssReadCounter [RP-E11] read nearend_base from ini $baseCount $cTmp");
    if (baseCount == 0) {
      counter.tran.nearend_base = cTmp;
      await counter.save();
    }

    currCount = cTmp;
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssReadCounter() [RP-E11] read nearend_curr from ini");
    }
    cTmp = counter.tran.nearend_curr;
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssReadCounter() [RP-E11] read nearend_curr from ini $currCount:$cTmp");
    }
    if (currCount < cTmp) {
      // 巻き戻り発生
      countOffset = cTmp - currCount;
      currCount = cTmp;
    }
    isSetBase = 1;

    return DrvPrnDef.PRN_OK;
  }

  /// /boot_ej.txtの更新
  /// 引数:[type] ログ内容（回復 or 失敗）
  ///  　　[cnt] リセットカウンタ
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_ejtxt
  void tprtssEjTxt(int type, int cnt) {
    // Dart:ffi経由で共有ライブラリにアクセス
  }

  /// プリンタからのレスポンス受信
  /// 引数:[hopeVal] コマンドデータ
  ///     [val] プリンタデータ
  ///     [readSiz] プリンタデータの長さ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_sii_api_read_device
  Future<PrintRet> tprtssSiiApiReadDevice(int hopeVal, int readSiz) async {
    int i = 0;
    int loopCount = 0;
    int detectFlg = 0;
//    int readRet = 0;
    int readBuffLen = 0;
    List<String> readBuff = [];
    List<String> val = [];
    String errLog = "";
    PrintRet readRet = PrintRet();

    if (isWithoutDevice()) {
      readRet.result = DrvPrnDef.PRN_OK;
      return readRet;
    }

    outerLoop:
    while (loopCount < 30) {
      loopCount++;
      readRet = ffiPtr.printerReadDevice(DrvPrnDef.READ_BUF_SIZ);
      if (DrvPrnDef.DISP_BUFF) {
        //dispBuff("sii_api_read_device 01", readBuff, readBuffLen);
      }
      if (readRet.result < 0) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssSiiApiReadDevice() sii_api_read_device error[${readRet.result}]");
        readRet.result = DrvPrnDef.PRN_NG;
        return readRet;
      }
      readBuff = readRet.readData;
      readBuffLen = readRet.readSize;
      if (DrvPrnDef.TPRTS_DEBUG) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssSiiApiReadDevice() readBuffLen[$readBuffLen]");
      }
      if ((readBuffLen == 0) && (paperEndNotifyFlg == 1)){
        myLog.logAdd(myTid, LogLevelDefine.normal, "paperEndNotifyFlg ON!!");
        readRet.result = DrvPrnDef.PRN_NG;
        return readRet;
      }

      val += readBuff;
      readSiz += readBuffLen;

      for (i = 0; i < readBuffLen; i++) {
        switch (hopeVal) {
          case READ_RET_ENUM.READ_CHAR: // 文字列
            if (detectFlg == 0) {
              // ヘッダ未発見
              if (int.parse(readBuff[i]) == 0x02) {
                detectFlg = 1;
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssSiiApiReadDevice() READ_CHAR　detect!!!");
                }
              }
            } else {
              if (int.parse(readBuff[i]) == 0x00) {
                detectFlg = 10;
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssSiiApiReadDevice() READ_CHAR detect10!!!");
                }
                break outerLoop;
              }
            }
            break;
          case READ_RET_ENUM.READ_HEX: // HEXコード
            if (detectFlg == 0) {
              // ヘッダ未発見
              if (int.parse(readBuff[i]) == 0x0e) {
                detectFlg = 1;
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssSiiApiReadDevice() READ_HEX　detect!!!");
                }
              }
              if (DrvPrnDef.TPRTS_DEBUG) {
                myLog.logAdd(myTid, LogLevelDefine.normal,
                    "tprtssSiiApiReadDevice() READ_HEX　Not detect!!!");
              }
            } else {
              if (int.parse(readBuff[i]) == 0x00) {
                detectFlg = 10;
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssSiiApiReadDevice() READ_HEX2 detect10!!!");
                }
                break outerLoop;
              }
              if (DrvPrnDef.TPRTS_DEBUG) {
                myLog.logAdd(myTid, LogLevelDefine.normal,
                    "tprtssSiiApiReadDevice() READ_HEX2 Not detect10!!!");
              }
            }
            break;
          case READ_RET_ENUM.READ_REPLY: // 実行応答
            if ((int.parse(readBuff[i]) & 0xF0) == 0xc0) {
              if (((int.parse(readBuff[i]) & 0x0f) != 0) ||
                  ((int.parse(readBuff[i + 1]) & 0x0f) != 0)) {
                if (((int.parse(readBuff[i]) & 0x0f) == 0) ||
                    ((int.parse(readBuff[i + 1]) & 0x0f) == 0x02)) {
                  if (DrvPrnDef.TPRTS_DEBUG) {
                    myLog.logAdd(myTid, LogLevelDefine.normal,
                        "tprtssSiiApiReadDevice() READ_REPLY　Not detect1!!!");
                  }
                  // フラグを立ててブレークしないとリトライ30回×sleep1秒で30秒無応答になる
                  paperEndNotifyFlg = 1;
                  break outerLoop;
                }
                if (DrvPrnDef.TPRTS_DEBUG) {
                  myLog.logAdd(myTid, LogLevelDefine.normal,
                      "tprtssSiiApiReadDevice() READ_REPLY　Not detect2!!!");
                }
                break outerLoop;
              }
            }
            if ((int.parse(readBuff[i]) & 0xF0) == 0x80) {
              detectFlg = 10;
              if (DrvPrnDef.TPRTS_DEBUG) {
                myLog.logAdd(myTid, LogLevelDefine.normal,
                    "tprtssSiiApiReadDevice() READ_REPLY　detect10!!!");
              }
              break outerLoop;
            }
            break;
          case READ_RET_ENUM.READ_STAT: // ステータス応答
            if ((int.parse(readBuff[i]) & 0xF0) == 0xc0) {
              if (((int.parse(readBuff[i]) & 0x0f) != 0) ||
                  ((int.parse(readBuff[i + 1]) & 0x0f) != 0)) {
                if (((int.parse(readBuff[i]) & 0x0f) == 0) ||
                    ((int.parse(readBuff[i + 1]) & 0x0f) == 0x02)) {
                  break;
                }
                break outerLoop;
              }
            }
            if ((rpdFlg == DrvPrnDef.RPCONNECT3) || (modelId == "\x25")) {
              // PT06 または RP-F(改)
              if ((int.parse(readBuff[i]) & 0xF0) == 0xa0) {
                val[0] = readBuff[i];
                readSiz = 1;
                if (DrvPrnDef.DISP_BUFF) {
                  if (DrvPrnDef.TPRTS_DEBUG) {
                    myLog.logAdd(myTid, LogLevelDefine.normal,
                        "tprtssSiiApiReadDevice() Data was available [$hopeVal]");
                  }
                  // int ii = 0;
                  // errLog = "]] ${val.length} : ";
                  // for (ii = 0; ii < val.length; ii++) {
                  //   errLog += "${val[ii]} ";
                  // }
                  // myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
                }
                detectFlg = 10;
                break outerLoop;
              }
            } else {
              if (detectFlg == 0) {
                // ヘッダ未発見
                if ((int.parse(readBuff[i]) & 0xF0) == 0xa0) {
                  detectFlg = 1;
                }
              } else if (detectFlg == 1) {
                if ((int.parse(readBuff[i]) & 0xF0) == 0x80) {
                  if (DrvPrnDef.DISP_BUFF) {
                    int ii = 0;
                    if (DrvPrnDef.TPRTS_DEBUG) {
                      myLog.logAdd(myTid, LogLevelDefine.normal,
                          "tprtssSiiApiReadDevice() Data was available [$hopeVal]");
                    }
                    errLog = "]] ${val.length} : ";
                    for (ii = 0; ii < val.length; ii++) {
                      errLog += val[ii];
                    }
                    myLog.logAdd(myTid, LogLevelDefine.normal, errLog);
                  }
                  detectFlg = 10;
                  break outerLoop;
                }
              }
            }
            break;
          case READ_RET_ENUM.READ_INIT_HW:
            // 電源オン、「ハードウェアリセット」コマンド（DC2 '@'）、シリアル通信での通信ブレークからのイニシャライズ
            if (int.parse(readBuff[i]) == 0xb0) {
              detectFlg = 10;
              break outerLoop;
            }
            break;
          case READ_RET_ENUM.READ_INIT_SW:
            // USBクラスリクエストのリセット、「ダウンロードモードのリセット」コマンド（'@'）からのイニシャライズ
            if (int.parse(readBuff[i]) == 0xb1) {
              detectFlg = 10;
              break outerLoop;
            }
            break;
          case READ_RET_ENUM.READ_INIT_CMD: // 「プリンタの初期化」コマンド（ESC '@'）からのイニシャライズ
            if (int.parse(readBuff[i]) == 0xb2) {
              detectFlg = 10;
              break outerLoop;
            }
            break;
          default:
            detectFlg = 10;
            break outerLoop;
        }
      }

      if (detectFlg == 10) {
        myLog.logAdd(myTid, LogLevelDefine.normal,
            "tprtssSiiApiReadDevice() detectFlg == 10)");
        readRet.result = DrvPrnDef.PRN_OK;
        return readRet;
      }

      sleep(const Duration(microseconds: DrvPrnDef.TPRTSS_READ_WAITTIME));
    }

    if (paperEndNotifyFlg == 1) {
      readRet.result = DrvPrnDef.PRN_NG;
      return readRet;
    }

    if (detectFlg != 10) {
      int ii = 0;

      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssSiiApiReadDevice() Data was not available [$hopeVal]");

      errLog = "]] ${val.length} : ";
      for (ii = 0; ii < val.length; ii++) {
        errLog += val[ii];
      }
      myLog.logAdd(myTid, LogLevelDefine.error, errLog);

      if ((hopeVal == READ_RET_ENUM.READ_STAT) ||
          (hopeVal == READ_RET_ENUM.READ_REPLY)) {
        if (await tprtssReset() == DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssSiiApiReadDevice() tprtss_reset error");
          readRet.result = DrvPrnDef.PRN_NG;
          return readRet;
        } else {
          if (DrvPrnDef.TPRTS_DEBUG) {
            myLog.logAdd(myTid, LogLevelDefine.normal,
                "tprtssSiiApiReadDevice() READ_RET_ENUM.READ_STAT Error! But go OK");
          }
          readRet.result = DrvPrnDef.PRN_OK;
          return readRet;
        }
      }
      readRet.result = DrvPrnDef.PRN_NG;
      return readRet;
    }
    if (DrvPrnDef.TPRTS_DEBUG) {
      myLog.logAdd(myTid, LogLevelDefine.normal,
          "tprtssSiiApiReadDevice() DrvPrnDef.PRN_OK!!!");
    }

    readRet.result = DrvPrnDef.PRN_OK;
    return readRet;
  }

  /// メッセージの標準出力（デバッグ用）
  /// 引数:[header] メッセージ・ヘッダー部
  ///  　　[buff] メッセージ・パラメータ部
  ///  　　[len] メッセージ・パラメータ部長さ
  ///  戻り値:なし
  /// 関連tprxソース: tprdrv_tprtim.c - DispBuff
  void dispBuff(String header, String buff, int len) {
    int i = 0;
    String tmp = "";

    myLog.logAdd(0, LogLevelDefine.normal, "]] $header : ");
    for (i = 0; i < len; i++) {
      tmp += "${buff[i]} ";
    }
    myLog.logAdd(0, LogLevelDefine.normal, tmp);
  }

  /// 設定ファイル（sys.ini）から自タスクの設定ファイルを取得する
  /// 引数: なし
  /// 戻り値 : 設定ファイル名 = Normal End
  ///         空 = Error
  /// 関連tprxソース:新規作成
  Future<String> tprtssIniFileGet() async {
    String bootType = CmCksys.cmWebTypeGet(sysIni);

    final section = await sysIni.getValueWithName(
        bootType, "drivers${iDrvNo.toString().padLeft(2, "0")}");

    // get drivers section in sys.ini
    if (!section.result) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "Drivers section in sys.ini getting Error: ${section.cause.name}");
      return "";
    }

    // get drivers ini (ini file name)
    final iniName = await sysIni.getValueWithName(section.value, "inifile");
    if (!iniName.result) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "Smscls ini file getting Error: ${iniName.cause.name}");
      return "";
    }
    if (!iniName.value.contains(section.value)) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "Smscls ini file name err(${section.value}.ini)");
      return "";
    }

    return "${section.value}.json";
  }

  /// 設定ファイルを読み取り、設定値を格納
  /// 引数: [myIni] : 自タスクの設定ファイル名
  /// 戻り値：0  = Normal End
  ///        -1 = Error
  /// 関連tprxソース:新規作成
  Future<int> tprtssMyIniGet(String myIni) async {
    switch (myIni) {
      case "tprtf.json":
        await tprtimIni.load();
        drwMData = tprtimIni.settings.drw_number;
        drwT1Data = tprtimIni.settings.drw_on_time;
        drwT2Data = tprtimIni.settings.drw_off_time;
        break;
      case "tprtim.json":
        await tprtim2Ini.load();
        drwMData = tprtim2Ini.settings.drw_number;
        drwT1Data = tprtim2Ini.settings.drw_on_time;
        drwT2Data = tprtim2Ini.settings.drw_off_time;
        break;
      case "tprtrp.json":
        await tprtim3Ini.load();
        drwMData = tprtim3Ini.settings.drw_number;
        drwT1Data = tprtim3Ini.settings.drw_on_time;
        drwT2Data = tprtim3Ini.settings.drw_off_time;
        break;
      case "tprts.json":
        await tprtim4Ini.load();
        drwMData = tprtim4Ini.settings.drw_number;
        drwT1Data = tprtim4Ini.settings.drw_on_time;
        drwT2Data = tprtim4Ini.settings.drw_off_time;
        break;
      case "tprtss.json":
        await tprtim5Ini.load();
        drwMData = tprtim5Ini.settings.drw_number;
        drwT1Data = tprtim5Ini.settings.drw_on_time;
        drwT2Data = tprtim5Ini.settings.drw_off_time;
        break;
      case "tprtss2.json":
        await tprtim6Ini.load();
        drwMData = tprtim6Ini.settings.drw_number;
        drwT1Data = tprtim6Ini.settings.drw_on_time;
        drwT2Data = tprtim6Ini.settings.drw_off_time;
        break;
      default:
        myLog.logAdd(myTid, LogLevelDefine.error, "Smscl ini file not found");
        return -1;
    }
    return 0;
  }

  /// 文字フォントの選択コマンドを生成する
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_cmd_create_dataから切り離し
  Future<int> tprtssCmdCreateDataCharReg(
      int xSiz, String data, int dataLen) async {
    int resFlag = 1;
    int replyFlag = 1;
    String cmd = "";
    int len = 0;
    int dataLenTmp = 0;
    int pos = 0;

    if (data.isEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_CHAR_REG data is NULL error[$xSiz]");
      return DrvPrnDef.PRN_NG;
    }
    cmd = DrvPrnDef.CMD_DC2;
    cmd += "M"; // 0x4d/
    cmd += "\x00";
    cmd += latin1.decode([xSiz & 0xff]);
    cmd += latin1.decode([(xSiz >> 8) & 0xff]);
    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("tprtss_write 01", cmd, cmd.length);
    }
    if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_CHAR_REG HEADER write error[$xSiz][${replyFlag - 1}]");
      return DrvPrnDef.PRN_NG;
    }
    pos = 0;
    len = 0;
    dataLenTmp = dataLen;
    while (true) {
      if (dataLenTmp > DrvPrnDef.CMD_MAX) {
        len = DrvPrnDef.CMD_MAX;
      } else {
        len = dataLenTmp;
      }
      // TODO:memcpy(&cmd[0], &data[posi], len);
      cmd = data.substring(pos, pos + len);
      if (DrvPrnDef.DISP_BUFF) {
        dispBuff("tprtss_write 02", cmd, cmd.length);
      }
      if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_CHAR_REG write error[$xSiz][${replyFlag - 1}][$len][$dataLen][$pos]");
        return DrvPrnDef.PRN_NG;
      }
      pos += len;
      dataLenTmp -= len;
      if (dataLenTmp <= 0) {
        break;
      }
    }

    return DrvPrnDef.PRN_OK;
  }

  /// ビットイメージの印字コマンドを生成する
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_cmd_create_dataから切り離し
  Future<int> tprtssCmdCreateDataBmp(int xSiz, String data, int dataLen) async {
    int resFlag = 1;
    String cmd = "";
    int xSizSave = 0;
    int pageModeFlg = 0;
    int cmdDataMax = 0;

    outerLoop: // ng_standartd_mode_chg
    while (true) {
      if (data.isEmpty) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_BMP data NULL error[$xSiz]");
        return DrvPrnDef.PRN_NG;
      }
      xSizSave = 0;
      if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
        cmdDataMax = DrvPrnDef.CMD_DATA_MAX80;
      } else {
        cmdDataMax = DrvPrnDef.CMD_DATA_MAX;
      }

      if ((xSiz / 8) > cmdDataMax) {
        xSizSave = xSiz - (cmdDataMax * 8);
        xSiz = cmdDataMax * 8;
        dataLen = (xSiz * (receiptWide / 8)) as int;
      } else {
        if (xSizSave > 0) {
          xSiz = xSizSave;
          dataLen = (xSiz * (receiptWide / 8)) as int;
          xSizSave = 0;
        }
      }

      if (rpdFlg != DrvPrnDef.RPCONNECT4) {
        // SLPはページモード無し
        // page mode selection
        cmd = DrvPrnDef.CMD_ESC; // 0x1b
        cmd += "L"; // 0x4c
        if (DrvPrnDef.DISP_BUFF) {
          dispBuff("tprtss_write 03", cmd, cmd.length);
        }
        if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmdCreateData PageModeSelect write error[$xSiz][$xSizSave][$dataLen]");
          return DrvPrnDef.PRN_NG;
        }
        // page mode print direction
        cmd = DrvPrnDef.CMD_ESC; // 0x1b
        cmd += "T"; // 0x54
        cmd += "\x00";
        if (DrvPrnDef.DISP_BUFF) {
          dispBuff("tprtss_write 04", cmd, cmd.length);
        }
        if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmdCreateData PageModeDirect error[$xSiz][$xSizSave][$dataLen]");
          break outerLoop; // ng_standartd_mode_chg
        }
        // page mode print area
        cmd = DrvPrnDef.CMD_ESC; // 0x1b
        cmd += "W"; // 0x57
        cmd += "\x00"; // xL
        cmd += "\x00"; // xH
        cmd += "\x00"; // yL
        cmd += "\x00"; // yH

        if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
          cmd += "\x40"; // dxL
          cmd += "\x02"; // dxH(256*1 + 176 = 432)
        } else {
          cmd += "\xb0"; // dxL
          cmd += "\x01"; // dxH(256*1 + 176 = 432)
        }
        cmd += latin1.decode([(dataLen ~/ (receiptWide / 8)) % 256]);
        cmd += latin1.decode([(dataLen / (receiptWide / 8)) ~/ 256]);
        if (DrvPrnDef.DISP_BUFF) {
          dispBuff("tprtss_write 05", cmd, cmd.length);
        }
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_BMP PageModePrintArea error[$xSiz][$xSizSave][$dataLen]");
        if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
          break outerLoop; // ng_standartd_mode_chg
        }

        // page mode absolute position
        cmd = DrvPrnDef.CMD_GS; // 0x1d
        cmd += "\$"; // 0x24
        cmd += "\x00"; // nl
        cmd += "\x00"; // nh
        if (DrvPrnDef.DISP_BUFF) {
          dispBuff("tprtss_write 06", cmd, cmd.length);
        }
        if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmdCreateData CMD_BMP PageModeAbsol error[$xSiz][$xSizSave][$dataLen]");
          break outerLoop; // ng_standartd_mode_chg
        }
      }

      // page mode rasterize bit image
      cmd = DrvPrnDef.CMD_GS; // 0x1d
      cmd += "v"; // 0x76
      cmd += "\x30";
      cmd += "\x00"; // Normal Mode

      if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
        cmd += "\x48"; // xL
      } else {
        cmd += "\x36"; // xL
      }
      cmd += "\x00"; // xH(0*256 + 54)*8 = 432
      cmd += latin1.decode([(dataLen ~/ (receiptWide / 8)) % 256]); // yL
      cmd += latin1.decode([(dataLen / (receiptWide / 8)) ~/ 256]); // yH
      if (DrvPrnDef.DISP_BUFF) {
        dispBuff("tprtss_write 07", cmd, cmd.length);
      }
      if (await tprtssWrite(cmd, cmd.length, 0) == DrvPrnDef.PRN_NG) {
        // No Wait Responce
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_BMP PageMode ImageHeader error[$xSiz][$xSizSave][$dataLen]");
        break outerLoop; // ng_standartd_mode_chg
      }
      if (DrvPrnDef.DISP_BUFF) {
        dispBuff("tprtss_write 08", data, dataLen);
      }
      if (await tprtssWrite(data, dataLen, resFlag) == DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_BMP PageMode ImageData error[$xSiz][$xSizSave][$dataLen]");
        break outerLoop; // ng_standartd_mode_chg
      }
      pageModeFlg = 1;
      break;
    }

    // page mode print & change to standerd mode
    cmd = "\x0c"; // FF
    if (DrvPrnDef.DISP_BUFF) {
      dispBuff("tprtss_write 09", cmd, cmd.length);
    }
    if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_BMP PageModeStandard error[$xSiz][$xSizSave][$dataLen]");
      return DrvPrnDef.PRN_NG;
    }
    if (pageModeFlg == 0) {
      return DrvPrnDef.PRN_OK;
    } else {
      if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_BMP PageModeStandard error[$xSiz][$xSizSave][$dataLen]");
        return DrvPrnDef.PRN_NG;
      }
      return DrvPrnDef.PRN_OK;
    }
  }

  /// 2次元バーコードの印字コマンドを生成する
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_cmd_create_dataから切り離し
  Future<int> tprtssCmdCreateDataBarcode(
      int xSiz, int ySiz, String data, int dataLen) async {
    String cmd = "";
    int i = 0;
    int j = 0;
    int pos = 0;
    int resFlag = 0;
    int noHRI = 0; // HRIを印字? 0:する 1:しない
    int rm59BarcodeFeedFlg = 0;
    int code = 0;

    resFlag = 1;
    if (data.isEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_BARCODE data NULL error[$dataLen]");
      return DrvPrnDef.PRN_NG;
    }
    if (dataLen <= 11) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_BARCODE data_len error[$dataLen]");
      return DrvPrnDef.PRN_NG;
    }
    if ((data[2] == "C") && (data[3] == "L")) {
      data.replaceRange(3, 3, "C");
    }
    if ((data[2] == "C") && (data[3] == "D")) {
      noHRI = 1;
      data.replaceRange(3, 3, "J");
    }
    // TODO:SS_CR2
//    #if SS_CR2
//     if ((data[2] == "C") &&
//         ((data[3] == "C") ||
//             (data[3] == "J") ||
//             (data[3] == "A") ||
//             (data[3] == "E") ||
//             (data[3] == "8") ||
//             (data[3] == "B") ||
//             (data[3] == "N"))) {
//    #else
    if ((data[2] == "C") &&
        ((data[3] == "C") ||
            (data[3] == "J") ||
            (data[3] == "A") ||
            (data[3] == "E") ||
            (data[3] == "8") ||
            (data[3] == "N"))) {
//    #endif
      pos = ((data[9].codeUnitAt(0) & 0xff) * 256) +
          (data[8].codeUnitAt(0) & 0xff); // Barcode length
      if (dataLen != (pos + 10)) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_BARCODE[$data] data_len error[$dataLen][$pos]");
        return DrvPrnDef.PRN_NG;
      }
      if (taskOrder != DrvPrnDef.COUPON_PRINTER) {
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "a"; //位置揃え
        cmd += "\x01"; //中央揃え

        // TODO:#if RF1_SYSTEM
        // rm59BarcodeFeedFlg = pCom.vtclRm5900BarcodeFeedFlg;
        if (false) {
          // RM-3800 バーコード空白印字(0:する)   または
          // RM-3800 バーコード空白印字(1:しない) かつ、
          // バーコード種類がEAN13以外 かつ、EAN8以外の場合はFEEDする
          if ((rm59BarcodeFeedFlg == 0) ||
              ((rm59BarcodeFeedFlg == 1) &&
                  ((data[2] == "C") &&
                      ((data[3] != "J") && (data[3] != "8"))))) {
            cmd += DrvPrnDef.CMD_ESC;
            if (await CmCksys.cmSm66FrestaSystem() == 1) {
              // バーコード上部の行間を狭くする
              cmd += "\x00";
            } else {
              cmd += "J"; // 0x4a
            }
            cmd += "\x18";
          }
        } else {
          cmd += DrvPrnDef.CMD_ESC;
          if (await CmCksys.cmSm66FrestaSystem() == 1) {
            // バーコード上部の行間を狭くする
            cmd += "\x00";
          } else {
            cmd += "J"; // 0x4a
          }
          cmd += "\x18";
        }
        if (DrvPrnDef.DISP_BUFF) {
          dispBuff("tprtss_write 10", cmd, cmd.length);
        }
        if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmdCreateData CMD_BARCODE[$data] FEED error[$dataLen][$pos]");
          return DrvPrnDef.PRN_NG;
        }
      }
      if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
        // Barcode Centering
        cmd = DrvPrnDef.CMD_ESC;
        cmd += "a"; // 0x4a
        cmd += "\x01";
        if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
          myLog.logAdd(myTid, LogLevelDefine.error,
              "tprtssCmdCreateData CMD_BARCODE[$data] CENTERING error[$dataLen][$pos]");
          return DrvPrnDef.PRN_NG;
        }
      }
      if ((pos == 22) || // for Komeri Tckt CODE128 2nd stage
          ((rpdFlg == DrvPrnDef.RPCONNECT3) || (modelId == "\x25"))) {
        //  PT06 or RP-F(改)
        cmd = DrvPrnDef.CMD_GS;
        cmd += "L"; // centering
        // TODO:左マージン入れるとずれるので無効にしている
        //cmd += "\x1E";
        cmd += "\x00";
        cmd += "\x00";
      }
      // TODO:#if SS_CR2
      if (false) {
        if ((data[2] == "C") && (data[3] == "B")) {
          cmd += DrvPrnDef.CMD_DC3;
          cmd += "("; // 0x28
          cmd += "A"; // 0x41
          cmd += "C"; // 0x43
          cmd += "L"; // 0x4c
          // top line x start position
          cmd += latin1.decode([data[4].codeUnitAt(0) & 0xff]);
          cmd += latin1.decode([data[5].codeUnitAt(0) & 0xff]);
          // top line x end position
          cmd += latin1.decode([data[6].codeUnitAt(0) & 0xff]);
          cmd += latin1.decode([data[7].codeUnitAt(0) & 0xff]);
          cmd += "+"; // 0x2b
          cmd += ")";

          cmd += DrvPrnDef.CMD_ESC;
          cmd += "J"; // 0x4a
          cmd += "\x04";
          cmd += DrvPrnDef.CMD_DC3;
          cmd += "-"; // 0x2d
          cmd += DrvPrnDef.CMD_ESC;
          cmd += "J"; // 0x4a
          cmd += "\x08";
        }
      }
      cmd += DrvPrnDef.CMD_GS; // バーコードの高さ
      cmd += "h"; // 0x68
      if ((hC1System == 1) && ((data[2] == "C") && (data[3] == "C"))) {
        cmd += "\x3C";
      } else {
        int crdtUserNo = pCom.dbTrm.crdtUserNo;

        if (crdtUserNo == 1) {
          cmd += "\x3C";
        } else {
          if (await CmCksys.cmSm66FrestaSystem() == 1) {
            cmd += "\x28";
          } else {
            cmd += "\x3C";
          }
        }
      }

      // TODO:#if SS_CR2
      if (false) {
        if ((data[2] == "C") && (data[3] == "B")) {
          cmd += DrvPrnDef.CMD_GS;
          cmd += "H"; // 0x48
          if (hC1System == 1) {
            cmd += "\x00";
          } else {
            cmd += "\x02";
          }
        }
      }
      // HRI文字(可読文字)の為、復活させた
      if ((taskOrder != DrvPrnDef.COUPON_PRINTER) && (noHRI == 0)) {
        if ((data[2] == "C") && (data[3] == "J")) {
          cmd += DrvPrnDef.CMD_GS;
          cmd += "H"; // 0x48(HRI文字の印字位置設定)
          if (hC1System == 1) {
            cmd += "\x00"; // 印字しない
          } else {
            cmd += "\x02"; // バーコードの下
          }
        }
      }

      if ((hC1System == 1) && ((data[2] == "C") && (data[3] == "C"))) {
        cmd += DrvPrnDef.CMD_GS;
        cmd += "H";
        if (pos == 22) {
          cmd += "\x02"; // HRI enable
        } else {
          cmd += "\x00"; // HRI disable
        }
      }

      cmd += DrvPrnDef.CMD_GS;
      cmd += "w"; // 0x77(バーコードの幅)
      if (taskOrder == DrvPrnDef.COUPON_PRINTER) {
        if (pos == 32) {
          cmd += "\x02";
        } else {
          cmd += "\x03";
        }
      } else {
        if ((data[2] == "C") && (data[3] == "J")) {
          cmd += "\x03"; //3 ドット
        } else {
          cmd += "\x02"; //2 ドット
        }
      }

      if ((taskOrder == DrvPrnDef.COUPON_PRINTER) &&
          (data[3] == "C") &&
          (pos == 32)) {
        cmd += DrvPrnDef.CMD_DC2;
        cmd += ":"; // 0x3b
        cmd += "\x00";
      }

      cmd += DrvPrnDef.CMD_GS;
      cmd += "k"; // 0x6b(バーコードの種類)
      switch (data[3]) {
        case "C": // Code 128/
          cmd += "\x49";
          cmd += latin1.decode([(pos ~/ 2) + 2]);
          cmd += "\x69";
          for (i = 0; i < pos; i += 2) {
            code = int.parse(data.substring(10 + i, 10 + i + 2));
            cmd += latin1.decode([code]);
          }
          cmd += "\x6a";
          break;
        case "A": // UPC-A
          cmd += "\x41";
          cmd += latin1.decode([pos]);
          for (i = 0; i < pos; i++) {
            cmd += data[10 + i];
          }
          break;
        case "E": // UPC-E
          cmd += "\x42";
          cmd += latin1.decode([pos]);
          for (i = 0; i < pos; i++) {
            cmd += data[10 + i];
          }
          break;
        case "J": // EAN 13
          cmd += "\x43";
          cmd += latin1.decode([pos]);
          for (i = 0; i < pos; i++) {
            cmd += data[10 + i];
          }
          break;
        // TODO:#if SS_CR2
        // case "B":
        //   cmd += "\x49";
        //   cmd += latin1.decode([(pos ~/ 2) + 2]);
        //   cmd += "\x68";
        //   for (i = 0; i < pos; i += 3) {
        //     // TODO:strncpy(code, (char *) & data[10 + i], 3);
        //     cmd += data.substring(10 + i, (10 + i) + 3);
        //   }
        //   cmd += "\x6a";
        //   break;
        // TODO:#endif
        case "N":
          cmd += "\x47"; // NW7(CODABAR)
          cmd += latin1.decode([pos]); // NW7
          for (i = 0; i < pos; i++) {
            cmd += data[10 + i];
          }
          break;
        case "8": // EAN 8
        default:
          cmd += "\x44";
          cmd += latin1.decode([pos]);
          for (i = 0; i < pos; i++) {
            cmd += data[10 + i];
          }
          break;
      }

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "a"; //位置揃え
      cmd += "\x00"; //左揃え

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "J"; // 0x4a

      // TODO:#if RF1_SYSTEM
      if (false) {
        // RM-3800 バーコード空白印字(1:しない) かつ、
        // バーコード種類がEAN13またはEAN8の場合はFEEDする
        int rm59BarcodeFeedFlg = pCom.vtclRm5900BarcodeFeedFlg;
        if ((rm59BarcodeFeedFlg == 1) &&
            ((data[2] == "C") && ((data[3] == "J") || (data[3] == "8")))) {
          cmd += "\x18";
        } else {
          cmd += "\x05";
        }
      } else {
        cmd += "\x05";
      }

      if ((data[2] == "C") && (data[3] == "J")) {
        cmd += DrvPrnDef.CMD_GS;
        cmd += "H"; // 0x48
        cmd += "\x00";
      }

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "a"; //位置揃え
      cmd += "\x00"; //左揃え

      if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData tprtss write error[$xSiz][$dataLen]");
        return DrvPrnDef.PRN_NG;
      }
    } else if ((data[2] == "q") && (data[3] == "r")) {
      cmd += DrvPrnDef.CMD_ESC;
      cmd += "a"; // 0x4a
      cmd += "\x01";

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "J"; // 0x4a
      cmd += "\x18";

      cmd += DrvPrnDef.CMD_DC2;
      cmd += ";"; // 0x3b
      cmd += "\x04";

      // range check ???????
      cmd += DrvPrnDef.CMD_GS;
      cmd += "p"; // 0x70
      cmd += "\x01"; // QR Code
      cmd += "\x02"; // model 2
      cmd += "M"; // 0x4d(error void level M)
      cmd += "\x00"; // auto version
      // mode 'N':0-9 'A':0-9a-zA-Z ...
      cmd += latin1.decode([data[4].codeUnitAt(0) & 0xff]);
      cmd += latin1.decode([((dataLen - 5) % 256) & 0xff]);
      cmd += latin1.decode([(dataLen - 5) ~/ 256 & 0xff]);
      //TODO:memcpy(&cmd[len], &data[5], dataLen - 5);
      cmd += data.substring(5, dataLen - 5);

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "a"; // 0x4a
      cmd += "\x00";

      if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData tprtss write error[$xSiz][$dataLen]");
        return DrvPrnDef.PRN_NG;
      }
    } else if ((data[2] == "Q") && (data[3] == "R")) {
      xSiz = ((data[5].codeUnitAt(0) & 0xff) * 256) +
          (data[4].codeUnitAt(0) & 0xff); // x position
      ySiz = ((data[7].codeUnitAt(0) & 0xff) * 256) +
          (data[6].codeUnitAt(0) & 0xff); // dot size
      pos = ((data[9].codeUnitAt(0) & 0xff) * 256) +
          (data[8].codeUnitAt(0) & 0xff); // x and y number
      if (dataLen != ((pos * pos) + 10)) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_BARCODE(QR) data_len error[$dataLen][$pos]");
        return DrvPrnDef.PRN_NG;
      }
      cmd += DrvPrnDef.CMD_ESC;
      cmd += "J"; // 0x4a
      cmd += "\x18";

      cmd += DrvPrnDef.CMD_DC3;
      cmd += "("; // 0x28
      cmd += "A"; // 0x41
      cmd += "+"; // 0x2b
      cmd += ")";

      for (i = 0; i < pos; i++) {
        cmd += DrvPrnDef.CMD_DC3;
        cmd += "("; // 0x28
        cmd += "C"; // 0x43
        for (j = 0; j < pos; j++) {
          if (data[10 + (i * pos) + j] == "1") {
            cmd += "L"; // 0x4c
            cmd += latin1.decode([(xSiz + (j * ySiz)) & 0xff]);
            cmd += latin1.decode([((xSiz + (j * ySiz)) >> 8) & 0xff]);
            cmd += latin1.decode([((xSiz + (j * ySiz)) + ySiz) & 0xff]);
            cmd += latin1.decode([(((xSiz + (j * ySiz)) + ySiz) >> 8) & 0xff]);
          }
        }
        cmd += ")";
        cmd += DrvPrnDef.CMD_ESC;
        cmd += "J"; // 0x4a
        cmd += latin1.decode([ySiz]);
      }
      cmd += DrvPrnDef.CMD_DC3;
      cmd += "-"; // 0x2d

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "J"; // 0x4a
      cmd += "\x18";

      if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData tprtss write error[$xSiz][$dataLen]");
        return DrvPrnDef.PRN_NG;
      }
    } else {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_BARCODE not support error[$data]");
      return DrvPrnDef.PRN_NG;
    }
    return DrvPrnDef.PRN_OK;
  }

  /// 2次元バーコードの印字コマンドを生成する
  /// 関連tprxソース: tprdrv_tprtim.c - tprtss_cmd_create_dataから切り離し
  Future<int> tprtssCmdCreateDataLine(
      int xSiz, int ySiz, int no, String data, int dataLen) async {
    int resFlag = 0;
    String cmd = "";
    int xSizSave = 0;
    int pos = 0;
    int line2 = 0;
    int iTmp1 = 0;
    int iTmp2 = 0;
    int lineTyp = 0;
    int feedTyp = 0;
    int i, j;

    if (data.isEmpty) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_LINE data NULL error[$dataLen]");
      return DrvPrnDef.PRN_NG;
    }
    if (dataLen <= 15) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_LINE data_len error[$dataLen]");
      return DrvPrnDef.PRN_NG;
    }
    no = ((data[3].codeUnitAt(0) & 0xff) * 256) +
        (data[2].codeUnitAt(0) & 0xff); // x position
    xSiz = ((data[5].codeUnitAt(0) & 0xff) * 256) +
        (data[4].codeUnitAt(0) & 0xff); // x size
    ySiz = ((data[7].codeUnitAt(0) & 0xff) * 256) +
        (data[6].codeUnitAt(0) & 0xff); // y size
    pos = ((data[9].codeUnitAt(0) & 0xff) * 256) +
        (data[8].codeUnitAt(0) & 0xff); // dot size
    xSizSave = ((data[11].codeUnitAt(0) & 0xff) * 256) +
        (data[10].codeUnitAt(0) & 0xff); // line number
    line2 = ((data[13].codeUnitAt(0) & 0xff) * 256) +
        (data[12].codeUnitAt(0) & 0xff); // separate line size
    lineTyp = data[14].codeUnitAt(0); // line type

    if (lineTyp == 6) {
      iTmp1 = 15;
      iTmp2 = data[iTmp1++].codeUnitAt(0) & 0xff;
      iTmp2 += (data[iTmp1++].codeUnitAt(0) & 0xff) * 256;
      if (iTmp2 > 128) {
        if (DrvPrnDef.TPRTS_DEBUG) {
          myLog.logAdd(myTid, LogLevelDefine.normal,
              "tprtssCmdCreateData tprtss_cmd_create LINE length error[$iTmp2]");
        }
        return DrvPrnDef.PRN_NG;
      }
      // TODO:memcpy(&cmd[len], &data[i_tmp1], i_tmp2);
      cmd += data.substring(iTmp1, iTmp1 + iTmp2);
      iTmp1 += iTmp2;
      cmd += "\x0a";

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "J"; // 0x4a
      cmd += "4";

      cmd += DrvPrnDef.CMD_DC3;
      cmd += "("; // 0x28
      cmd += "A"; // 0x41
      cmd += "C"; // 0x43
      cmd += "+"; // 0x2b
      cmd += "L"; // 0x4c
      cmd += latin1.decode([no & 0xff]);
      cmd += latin1.decode([(no >> 8) & 0xff]);
      cmd += latin1.decode([(no + xSiz) & 0xff]);
      cmd += latin1.decode([((no + xSiz) >> 8) & 0xff]);
      cmd += ")";
      cmd += DrvPrnDef.CMD_ESC;
      cmd += "J"; // 0x4a
      cmd += latin1.decode([pos]);
      cmd += DrvPrnDef.CMD_DC3;
      cmd += "-"; // 0x2d

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "J"; // 0x4a
      cmd += "\x18";
      if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_BMP PageModeStandard error[$xSiz][$xSizSave][$dataLen]");
        return DrvPrnDef.PRN_NG;
      }
      return DrvPrnDef.PRN_OK;
    }

    cmd += DrvPrnDef.CMD_ESC;
    cmd += "J"; // 0x4a
    switch (lineTyp) {
      case 3:
        cmd += "\x04";
        break;
      case 7:
        cmd += "\x06";
        break;
      case 9:
        cmd += "\x06";
        break;
      default:
        cmd += "\x18";
        break;
    }

    if (lineTyp == 9) {
      lineTyp = 0;
      feedTyp = 1;
    } else if (lineTyp == 8) {
      lineTyp = 4;
      feedTyp = 1;
    }

    cmd += DrvPrnDef.CMD_DC3;
    cmd += "("; // 0x28
    cmd += "A"; // 0x41
    cmd += "C"; // 0x43
    cmd += "+"; // 0x2b
    cmd += "L"; // 0x4c
    cmd += latin1.decode([no & 0xff]);
    cmd += latin1.decode([(no >> 8) & 0xff]);
    cmd += latin1.decode([(no + xSiz) & 0xff]);
    cmd += latin1.decode([((no + xSiz) >> 8) & 0xff]);
    cmd += ")";

    cmd += DrvPrnDef.CMD_ESC;
    cmd += "J"; // 0x4a
    cmd += latin1.decode([pos]);

    iTmp1 = 15;
    for (i = 0; i < xSizSave; i++) {
      cmd += DrvPrnDef.CMD_DC3;
      cmd += "("; // 0x28
      cmd += "C"; // 0x43
      cmd += "L"; // 0x4c
      cmd += latin1.decode([no & 0xff]);
      cmd += latin1.decode([(no >> 8) & 0xff]);
      cmd += latin1.decode([(no + pos) & 0xff]);
      cmd += latin1.decode([((no + pos) >> 8) & 0xff]);
      if ((line2 > 0) && ((lineTyp == 1) || (lineTyp == 4))) {
        cmd += "L"; // 0x4c
        cmd += latin1.decode([(no + line2 - pos) & 0xff]);
        cmd += latin1.decode([((no + line2 - pos) >> 8) & 0xff]);
        cmd += latin1.decode([(no + line2) & 0xff]);
        cmd += latin1.decode([((no + line2) >> 8) & 0xff]);
      }
      if ((line2 > 0) && (lineTyp == 7)) {
        for (j = 1; j < (xSiz / line2); j++) {
          cmd += "L"; // 0x4c
          cmd += latin1.decode([(no + line2 * j - pos) & 0xff]);
          cmd += latin1.decode([((no + line2 * j - pos) >> 8) & 0xff]);
          cmd += latin1.decode([(no + line2 * j) & 0xff]);
          cmd += latin1.decode([((no + line2 * j) >> 8) & 0xff]);
        }
      }
      cmd += "L"; // 0x4c
      cmd += latin1.decode([(no + xSiz - pos) & 0xff]);
      cmd += latin1.decode([((no + xSiz - pos) >> 8) & 0xff]);
      cmd += latin1.decode([(no + xSiz) & 0xff]);
      cmd += latin1.decode([((no + xSiz) >> 8) & 0xff]);
      cmd += ")";
      if ((lineTyp == 1) || (lineTyp == 4) || (lineTyp == 5)) {
        cmd += DrvPrnDef.CMD_ESC;
        cmd += "J"; // 0x4a
        cmd += latin1.decode([pos + 2]);
      }

      iTmp2 = data[iTmp1++].codeUnitAt(0) & 0xff;
      iTmp2 += (data[iTmp1++].codeUnitAt(0) & 0xff) * 256;
      if (iTmp2 > 128) {
        myLog.logAdd(myTid, LogLevelDefine.error,
            "tprtssCmdCreateData CMD_LINE length error[$dataLen][$i][$xSizSave][$iTmp1][$iTmp2]");
        return DrvPrnDef.PRN_NG;
      }
      // TODO:memcpy(&cmd[len], &data[i_tmp1], i_tmp2);
      cmd += data.substring(iTmp1, iTmp1 + iTmp2);
      iTmp1 += iTmp2;
      cmd += "\x0a";
      if (((line2 > 0) && ((i % 2) != 0) && (lineTyp == 1)) ||
          ((lineTyp == 7) && (i == 0)) ||
          ((line2 == 0) && (lineTyp == 5) && (i == 0))) {
        cmd += DrvPrnDef.CMD_ESC;
        cmd += "J"; // 0x4a
        cmd += latin1.decode([pos + 2]);

        cmd += DrvPrnDef.CMD_DC3;
        cmd += "("; // 0x28
        cmd += "C"; // 0x43
        cmd += "L"; // 0x4c
        cmd += latin1.decode([no & 0xff]);
        cmd += latin1.decode([(no >> 8) & 0xff]);
        cmd += latin1.decode([(no + xSiz) & 0xff]);
        cmd += latin1.decode([((no + xSiz) >> 8) & 0xff]);
        cmd += ")";

        cmd += DrvPrnDef.CMD_ESC;
        cmd += "J"; // 0x4a
        cmd += latin1.decode([pos]);
      }
    }
    if (lineTyp != 1) {
      cmd += DrvPrnDef.CMD_DC3;
      cmd += "("; // 0x28
      cmd += "C"; // 0x43
      cmd += "L"; // 0x4c
      cmd += latin1.decode([no & 0xff]);
      cmd += latin1.decode([(no >> 8) & 0xff]);
      cmd += latin1.decode([(no + xSiz) & 0xff]);
      cmd += latin1.decode([((no + xSiz) >> 8) & 0xff]);
      cmd += ")";

      cmd += DrvPrnDef.CMD_ESC;
      cmd += "J"; // 0x4a
      cmd += latin1.decode([pos]);
    }
    cmd += DrvPrnDef.CMD_DC3;
    cmd += "-"; // 0x2d

    cmd += DrvPrnDef.CMD_ESC;
    cmd += "J"; // 0x4a
    switch (lineTyp) {
      case 1:
        cmd += "\x24";
        break;
      case 2:
        cmd += "\x04";
        break;
      default:
        if (feedTyp == 1) {
          cmd += "\x06";
        } else {
          cmd += "\x18";
        }
        break;
    }
    if (await tprtssWrite(cmd, cmd.length, resFlag) == DrvPrnDef.PRN_NG) {
      myLog.logAdd(myTid, LogLevelDefine.error,
          "tprtssCmdCreateData CMD_BMP PageModeStandard error[$xSiz][$xSizSave][$dataLen]");
      return DrvPrnDef.PRN_NG;
    }
    return DrvPrnDef.PRN_OK;
  }

  /// メッセージクラス（TprtssCmdMsg）の設定
  /// 引数:[buf] メッセージデータ
  ///  　　[res] メッセージクラス（TprtssCmdMsg）
  /// 関連tprxソース:新規作成
  void setTprtssCmdMsg(TprMsgDevReq2 msg, TprtssCmdMsg res) {
    List<String> temp = msg.dataStr.split("");

    switch (msg.dataStr.length) {
      case 0:
        debugPrint("Parameter error");
        break;
      case 1:
        res.kind = temp[0].codeUnitAt(0);
        break;
      case 2:
        res.kind = temp[0].codeUnitAt(0);
        res.length = temp[1].codeUnitAt(0);
        break;
      case 3:
        res.kind = temp[0].codeUnitAt(0);
        res.length = temp[1].codeUnitAt(0);
        res.cmd = temp[2];
        break;
      default:
        res.kind = temp[0].codeUnitAt(0);
        res.length = temp[1].codeUnitAt(0);
        res.cmd = temp[2];
        res.param = temp.sublist(3);
        break;
    }
    res.printData = msg.payload;
  }

  /// メッセージクラス（TprtssReplyMsg）の設定
  /// 引数:[buf] メッセージデータ
  ///  　　[res] メッセージクラス（TprtssReplyMsg）
  /// 関連tprxソース:新規作成
  void setTprtssReplyMsg(String buf, TprtssReplyMsg res) {
    res.kind = buf[0].codeUnitAt(0);
    res.cmd = buf[1];
  }

  /// メッセージクラス（TprtssECmdMsg）の設定
  /// 引数:[buf] メッセージデータ
  ///  　　[res] メッセージクラス（TprtssECmdMsg）
  /// 関連tprxソース:新規作成
  void setTprtssEcmdMsg(String buf, TprtssECmdMsg res) {
    List<String> temp = buf.split("");

    res.kind = int.parse(temp[0]);
    res.length = int.parse(temp[1]);
    res.cmd = temp[2];
    res.param = temp.sublist(3);
  }

  /// メッセージクラス（TprtssSttsMsg）の設定
  /// 引数:[buf] メッセージデータ
  ///  　　[res] メッセージクラス（TprtssSttsMsg）
  /// 関連tprxソース:新規作成
  void setTprtssSttsMsg(String buf, TprtssSttsMsg res) {
    res.kind = buf[0].codeUnitAt(0);
    res.status = int.parse(buf.substring(1, 3));
  }

  /// 中断処理
  void abort() {
    _isAbort = true;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvPrintIsolate _abort");
  }

  /// 停止処理
  void stop() {
    _isStop = true;
    timerFunc!.cancel();
    timerFunc = null;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvPrintIsolate _stop");
  }

  /// 再開処理
  void restart() {
    _isStop = false;
    timerFunc ??= Timer.periodic(const Duration(milliseconds: 100), (timer) => {_onTimer(timer)});
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvPrintIsolate _restart");
  }
}
