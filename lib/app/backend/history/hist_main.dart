/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_stat.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../sys/syst/callbacks.dart';
import 'hist_proc.dart';

/// 関連tprxソース: hist_main.c
class HistMain{
  /// 関連tprxソース: hist_main.h
  /***** Center Server *****/
  static const HIST_CSRV_TNAME = 'hist_csrv';
  static const HIST_CSRV_MST_NAME	= 'centerserver_mst';

  static String TEMP_TBL_FNAME	= '${EnvironmentData().sysHomeDir}/tmp/%s.list';
  static String CREATE_CHK_FNAME	= '${EnvironmentData().sysHomeDir}/tmp/history_create_OK';	// 読み替えファイルの作成判断用

  static const RETRY_FTP_FNAME = '/tmp/history_retry_ftp.txt';	// FTPによる再取得リスト(エラー時に書き込むもの)
  static const RETRY_FTP_EXEC_FNAME	= '/tmp/history_retry_exec.txt';	// FTPによる再取得実行ファイル(上のファイルをリネームして再実行するもの)
  static const RETRY_FTP_TMP_FNAME = '/tmp/history_retry_tmp.txt';	// FTPによる再取得リストから削除指示分を除いた一時ファイル

  static const HIST_SRX_IP = 0;
  static const HIST_SUB_IP = 1;
  static const HIST_INTERVAL = 8;
  static const HIST_MAX_CNT	= 50;
  static const HIST_SLEEP	= 300000;

  static const HIST_NG = 0;
  static const HIST_OK = 1;
  static const HIST_NO_TUPLE = 2;
  static const HIST_DBFILE_NG	= 3;	// 読み替えファイルの作成失敗

  static SendPort? _appSendPort;

  static TprtStat? tprtStat;
  static TprtStat? tprtStatBuf = TprtStat();

  static bool isStop = false;

  /// 関連tprxソース: hist_main.c - main
  static Future<void> histMain(List<dynamic> args) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
        args[2] as RootIsolateToken);
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    SendPort parentSendPort = args[1] as SendPort;
    parentSendPort.send(sendPort);
    // ログ設定.
    TprLog().setIsolateName("histMain", args[0].appEnv.screenKind);
    TprLog().logPort = args[0].logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = args[0].appPath;
    await HistMain.setupShareMemory(args[0]);
    // ホームパス（環境変数）を取得.
    EnvironmentData().sysHomeDir = args[0].appEnv.sysHomeDir;
    DbManipulationPs db = DbManipulationPs();
    await db.openDB();

    receivePort.listen((notify) async {
      if (notify is SendPort) {
        _appSendPort = notify;
      } else if (notify is TprtStat) {
        if (tprtStat == null) {
          tprtStat = notify;
          tprtStatBuf = tprtStat;
        } else {
          tprtStat = notify;
        }
        switch (tprtStat!.mid) {
          case TprMidDef.TPRMID_SYSFAIL:
            HistProc.histFailFlg = 1;
            TprLog().logAdd(args[3], LogLevelDefine.error, "TPRMID_SYSFAIL\n");
            // TprSysFailAck(hist_SysPipe);
            await Future.delayed(
                const Duration(microseconds: HistMain.HIST_SLEEP));
            break;
          case TprMidDef.TPRMID_SYSNOTIFY:
            switch (TprStatDef.TPRTST_GETSTS(tprtStat!.mode)) {
              case TprStatDef.TPRTST_POWEROFF:
                TprLog().logAdd(args[3], LogLevelDefine.normal,
                    "End hist_main process(call PF)\n");
                TprLog().logAdd(args[3], LogLevelDefine.normal, "End\n");
                return;
              case TprStatDef.TPRTST_MENTE:
                TprLog().logAdd(args[3], LogLevelDefine.normal,
                    "TPRMID_SYSNOTIFY->TPRTST_MENTE\n");
                HistProc.histStartFlg = 0;
                HistProc.chPriceStopFlag = 0;
                CmCksys.cmMentModeOn();
                await Future.delayed(
                    const Duration(microseconds: HistMain.HIST_SLEEP));
                break;
              case TprStatDef
                    .TPRTST_STATUS12: // メインメニューの売価変更はTPRTST_STATUS12とTPRTST_STATUS25が実行される
                TprLog().logAdd(args[3], LogLevelDefine.normal,
                    "TPRMID_SYSNOTIFY->TPRTST_CHPRICE(Step:1/2)\n");
                HistProc.histStartFlg = 1;
                HistProc.chPriceStopFlag = 1;
                CmCksys.cmMentModeOn();
                await Future.delayed(
                    const Duration(microseconds: HistMain.HIST_SLEEP));
                break;
              case TprStatDef.TPRTST_STATUS16:
                TprLog().logAdd(args[3], LogLevelDefine.normal,
                    "TPRMID_SYSNOTIFY->TPRTST_USERSETUP\n");
                HistProc.histStartFlg = 0;
                HistProc.chPriceStopFlag = 0;
                CmCksys.cmMentModeOn();
                await Future.delayed(
                    const Duration(microseconds: HistMain.HIST_SLEEP));
                break;
              case TprStatDef.TPRTST_IDLE:
                TprLog().logAdd(args[3], LogLevelDefine.normal,
                    "TPRMID_SYSNOTIFY->TPRTST_IDLE\n");
                HistProc.histStartFlg = 1;
                HistProc.chPriceStopFlag = 0;
                CmCksys.cmMentModeOff();
                await Future.delayed(
                    const Duration(microseconds: HistMain.HIST_SLEEP));
                break;
              default:
                if (TprStatDef.TPRTST_GETSTS(tprtStat!.mode) ==
                        TprStatDef.TPRTST_STATUS25 // メインメニューの売価変更のチェック
                    &&
                    HistProc.chPriceStopFlag == 1) {
                  // TPRTST_STATUS12が事前に実行されている
                  // メインメニューの売価変更が選択された場合
                  TprLog().logAdd(args[3], LogLevelDefine.normal,
                      "TPRMID_SYSNOTIFY->TPRTST_CHPRICE(Step:2/2)\n");
                  HistProc.histStartFlg = 0;
                  CmCksys.cmMentModeOn();
                  await Future.delayed(
                      const Duration(microseconds: HistMain.HIST_SLEEP));
                } else {
                  String modeLog =
                      'TPRMID_SYSNOTIFY->another mode:${tprtStat!.mode}\n';
                  TprLog().logAdd(args[3], LogLevelDefine.normal, modeLog);
                  HistProc.histStartFlg = 1;
                  HistProc.chPriceStopFlag = 0;
                  CmCksys.cmMentModeOff();
                }
                await Future.delayed(
                    const Duration(microseconds: HistMain.HIST_SLEEP));
                break;
            }
            break;
          default:
            TprLog().logAdd(args[3], LogLevelDefine.normal, "another mid\n");
            await Future.delayed(
                const Duration(microseconds: HistMain.HIST_SLEEP));
            break;
        }
      } else {
        isStop = notify as bool;
      }
    });

    HistProc.histMainProc(args[3]);
  }

  // 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, initData.pCom!,  RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf!, RxMemAttn.MASTER);
  }
}

class HistConsole {
  SendPort? comPort;
  static bool stopHistIsolate = false;
  static bool abortHistIsolate = false;
  static TprTID myTid = 0;

  static final HistConsole _instance = HistConsole._internal();
  factory HistConsole() {
    return _instance;
  }
  HistConsole._internal();

  ///  履歴ログIsolateにSYSNOTIFYを送信する処理
  void sendSysNotify(int sts) async {
    if (comPort == null) {
      return;
    }
    comPort!.send(CallBacks.sysNotifySendIsolate(sts));
  }

  ///  履歴ログIsolateに停止フラグを送信する処理
  void sendHistStop() async {
    if (comPort == null) {
      return;
    }
    comPort!.send(stopHist());
  }

  ///  履歴ログIsolateに中断フラグを送信する処理
  void sendHistAbort() async {
    if (comPort == null) {
      return;
    }
    comPort!.send(abortHist());
  }

  ///  履歴ログIsolateに再開フラグを送信する処理
  void sendHistReStart() async {
    if (comPort == null) {
      return;
    }
    comPort!.send(reStartHist());
  }

  /// stopHist()：履歴ログを中断させたい場合、MainIsolateの中で使う
  static bool stopHist() {
    stopHistIsolate = true;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "HistConsole stopHist");
    return stopHistIsolate;
  }

  /// reStartHist()：一度手動で中断させた履歴ログを再開する際、MainIsolateの中で使う
  static bool reStartHist() {
    stopHistIsolate = false;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "HistConsole reStartHist");
    return stopHistIsolate;
  }

  /// abortHist()：一度手動で中断させた履歴ログを再開する際、MainIsolateの中で使う
  static bool abortHist() {
    abortHistIsolate = false;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "HistConsole abortHist");
    return abortHistIsolate;
  }
}