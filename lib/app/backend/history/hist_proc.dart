/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:postgres/postgres.dart';

import '../../../db_library/src/db_manipulation.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_lib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_pipe.dart';
import '../../inc/sys/tpr_stat.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/apllib_std_add.dart';
import '../../lib/apllib/timestamp.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/db/db_trigger.dart';
import '../../sys/syst/sys_main.dart';
import 'hist_main.dart';
import 'hist_updb.dart';

/// 関連tprxソース: hist_proc.c
class HistProc {
  static int histMyTid = 0;

  /* Task ID */
  static late File histMyPipe;

  /* My Pipe Discriptor */
  static late File histSysPipe;

  /* Pipe Discriptor for System Task */
  static int histFailFlg = 0;

  /* System Stop Flag */
  static int histStartFlg = 1;
  static int histFirstTime = 0;
  static String histTmpBuf = '';

  /* temporary buffer */
  static const String histNotError = "does not exist";
  static const String histNotError2 = "there is no trigger";

  static String histRetryTime = '';

  static int histCsrv = 0;
  static int chPriceStopFlag = 0; // 売価変更用停止判定フラグ

  static Result? histTprRes;
  static Result? histSrxRes;
  static Result? histSrxResSave;

  static const RETRY_SEPA = "\",\"";
  static const RETRY_SEPA_END = "\"\n";

  // TODO:10152 履歴ログ 必要なければ削除
  static SendPort? _appSendPort;

  static int printTimer = -1;

  static DateTime modifiedTime = DateTime.now();

  /// 関連tprxソース: hist_proc.c - hist_main_proc
  static Future<int> histMainProc(TprMID tid) async {
    histMyTid = tid;

    // setpriority(PRIO_PROCESS, 0, 15);
    histFailFlg = 0;
    histStartFlg = 0;
    histTmpBuf = '';
    chPriceStopFlag = 0;

    /* 2009/09/25 >>> */
    histCsrv = 0;

    histSysPipe = TprxPlatform.getFile(TprPipe.TPRPIPE_SYS);
    if (!histSysPipe.existsSync()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "Can't open TPRPIPE_SYS\n");
      return 0;
    }

    histTmpBuf = '${TprPipe.TPRPIPE_DRV}07';
    histMyPipe = TprxPlatform.getFile(histTmpBuf);
    if (!histMyPipe.existsSync()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "Can't open hist_MyPipe\n");
      TprLib().tprNoReady(tid, histMyTid);
      return 0;
    }

    // my_Initialize();

    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);

    TprLib().tprReady(tid, histMyTid);

    TprLog().logAdd(tid, LogLevelDefine.normal, "Start hist_main process\n");

    HistUpDb.histDBERRTXTDelete(tid); /* 2003.11.10 ADD */
    bool firstHandling = true;

    while (true) {
      // TODO:10152 履歴ログ cソースのselectのタイムアウト処理
      // notifyが届いたら次の処理に移行する.届かない間は8秒待機.
      int count = 0;
      while (count < HistMain.HIST_INTERVAL && !firstHandling) {
        await Future.delayed(const Duration(microseconds: 1000000));

        count += 1;

        if (HistMain.tprtStat != null) {
          if (HistMain.tprtStatBuf != HistMain.tprtStat) {
            HistMain.tprtStatBuf = HistMain.tprtStat;
            break;
          }
        }
      }

      // 初回だけ8秒待機時間はなし
      if (firstHandling) {
        firstHandling = false;
        if (HistMain.tprtStat != null) {
          if (HistMain.tprtStatBuf != HistMain.tprtStat) {
            HistMain.tprtStatBuf = HistMain.tprtStat;
          }
        }
      }

      // 履歴ログ最新情報取得中はバックグラウンドでの取得を停止
      if(HistMain.isStop){
        // 停止中は、5秒待機
        await Future.delayed(const Duration(seconds: 5));
        continue;
      }

      String txtName = '${EnvironmentData().sysHomeDir}/log/dberr.txt';
      File file = TprxPlatform.getFile(txtName);
      if (file.existsSync()) {
        await Future.delayed(const Duration(microseconds: HistMain.HIST_SLEEP));
        continue;
      }
      if (histFailFlg != 0) {
        TprLog().logAdd(
            tid, LogLevelDefine.normal, "default mode but hist_fail_flg\n");
        continue;
      }

      if (histStartFlg != 0 && !HistMain.isStop) {
        if (histCheckCreate(tid) == -1) {
          if (await SysMain.createTempTableLists(tid) != HistMain.HIST_OK) {
            await Future.delayed(
                const Duration(microseconds: HistMain.HIST_SLEEP));
            continue;
          }
        }
        TprLog().logAdd(tid, LogLevelDefine.normal, "hist_start_flg\n");

        await histStart(tid);

        await Future.delayed(const Duration(microseconds: HistMain.HIST_SLEEP));
        continue;
      }

      await Future.delayed(const Duration(microseconds: HistMain.HIST_SLEEP));
    }
  }

  /// sysmain.c のCreateTempTableLists()とほぼ同じ動作
  /// 関連tprxソース: hist_proc.c - hist_CreateTempTableLists
  static int histCreateTempTableLists(int tid) {
    // TODO:10063 DBテーブル構造の取得
    return 1;
  }

  /// 機能:	読み替えファイルを作成しているかチェック
  /// 戻値:	0: 作成   -1: 作成していない
  /// 関連tprxソース: hist_proc.c - hist_Check_Create
  static int histCheckCreate(TprMID tid) {
    File file = TprxPlatform.getFile(HistMain.CREATE_CHK_FNAME);
    if (file.existsSync()) {
      return 0;
    }
    TprLog()
        .logAdd(tid, LogLevelDefine.error, "hist_Check_Create : not create\n");
    return -1;
  }

  /// 関連tprxソース: hist_proc.c - hist_Start
  static Future<void> histStart(TprMID tid) async {
    int tuples = 0;

    if (histCsrv == 0) {
      if (await CmCksys.cmWizCnctSystem() != 0 ||
          await CmCksys.cmWizAbjSystem() != 0) {
        await DbTrigger.dbTriggerCreate(tid);
      }

      histFirstTime++;
    }

    await HistUpDb.histUpTableFromSrx(tid, tuples, HistMain.HIST_MAX_CNT);
    await histRetryFtpProc(tid);
    return;
  }

  /// 関連tprxソース: hist_proc.c - hist_PipeChk
  static Future<int> histPipeChk(TprMID tid) async {
    int ret;
    String modeLog = '';
    final receivePort = ReceivePort();

    // TODO:10152 履歴ログ cソースのselectのタイムアウト処理
    int count = 0;
    while (true) {
      await Future.delayed(const Duration(microseconds: 10));

      count += 1;

      if (HistMain.tprtStat != null) {
        if (HistMain.tprtStatBuf != HistMain.tprtStat) {
          HistMain.tprtStatBuf = HistMain.tprtStat;
          break;
        }
      }
      if (count == 8) {
        break;
      }
    }

    switch (HistMain.tprtStat!.mid) {
      case TprMidDef.TPRMID_SYSFAIL:
        histFailFlg = 1;
        TprLog().logAdd(tid, LogLevelDefine.error, "TPRMID_SYSFAIL2\n");
        // TprSysFailAck(hist_SysPipe);
        return HistMain.HIST_NG;
      case TprMidDef.TPRMID_SYSNOTIFY:
        switch (TprStatDef.TPRTST_GETSTS(HistMain.tprtStat!.mode)) {
          case TprStatDef.TPRTST_POWEROFF:
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "End hist_main process2(call PF)\n");
            TprLog().logAdd(tid, LogLevelDefine.normal, "End2\n");
            return 0;
          case TprStatDef.TPRTST_MENTE:
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "TPRMID_SYSNOTIFY->TPRTST_MENTE2\n");
            histStartFlg = 0;
            CmCksys.cmMentModeOn();
            return HistMain.HIST_NG;
          case TprStatDef
              .TPRTST_STATUS12: // メインメニューの売価変更はTPRTST_STATUS12とTPRTST_STATUS25が実行される
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "TPRMID_SYSNOTIFY->TPRTST_CHPRICE(Step:1/2)\n");
            histStartFlg = 1;
            chPriceStopFlag = 1;
            return HistMain.HIST_OK;
          case TprStatDef.TPRTST_STATUS16:
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "TPRMID_SYSNOTIFY->TPRTST_USERSETUP2\n");
            histStartFlg = 0;
            CmCksys.cmMentModeOn();
            return HistMain.HIST_NG;
          case TprStatDef.TPRTST_IDLE:
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "TPRMID_SYSNOTIFY->TPRTST_IDLE2\n");
            histStartFlg = 1;
            CmCksys.cmMentModeOff();
            return HistMain.HIST_OK;
          default:
            if (TprStatDef.TPRTST_GETSTS(HistMain.tprtStat!.mode) ==
                TprStatDef.TPRTST_STATUS25 // メインメニューの売価変更のチェック
                &&
                chPriceStopFlag == 1) {
              // TPRTST_STATUS12が事前に実行されている
              // メインメニューの売価変更が選択された場合
              TprLog().logAdd(tid, LogLevelDefine.normal,
                  "TPRMID_SYSNOTIFY->TPRTST_CHPRICE(Step:2/2)\n");
              CmCksys.cmMentModeOn();
              return HistMain.HIST_NG;
            } else {
              // memset(mode_log, 0x0, sizeof(mode_log));
              modeLog =
              "TPRMID_SYSNOTIFY->another mode2:${HistMain.tprtStat!.mode}\n";
              TprLog().logAdd(tid, LogLevelDefine.normal, modeLog);
              histStartFlg = 1;
              CmCksys.cmMentModeOff();
            }
            return HistMain.HIST_OK;
        }
        break;
      default:
      // memset(mode_log, 0x0, sizeof(mode_log));
        modeLog = "another mid2:${HistMain.tprtStat!.mid}\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, modeLog);
        return HistMain.HIST_OK;
    }
    TprLog().logAdd(tid, LogLevelDefine.normal, "not readFds ok\n");
    return HistMain.HIST_OK;
  }

  ///	機能:	FTP取得を実行する履歴ログが失敗した場合, 後で再実行をする処理
  ///	30分に1回, 再実行するようにした
  /// 関連tprxソース: hist_proc.c - hist_Retry_Ftp_Proc
  static Future<void> histRetryFtpProc(TprMID tid) async {
    int ret = 0;
    String nowTime = '';
    int difSec = 0;
    String listName = '';
    String execName = '';
    String getBuf = '';
    String tmpBuf = '';
    // struct	stat	statBuf;
    File? fp;
    String log = '';
    CHistlogMstColumns tHistLogMst = CHistlogMstColumns();
    String startPnt = '';
    String endPnt = '';
    String chkSepa = '';
    int num = 0;
    int plus = 0;
    String callFunc = 'histRetryFtpProc';

    if (histRetryTime.isEmpty) {
      var (int error, String date) = await DateUtil.dateTimeChange(
          null,
          DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM,
          DateTimeFormatKind.FT_YYYYMMDD_HHMMSS,
          DateTimeFormatWay.DATE_TIME_FORMAT_ZERO); // 初期値セット
      histRetryTime = date;
      return;
    }

    // 失敗ファイルが無ければ何もしない
    listName = "${EnvironmentData().sysHomeDir}${HistMain.RETRY_FTP_FNAME}";
    File file = TprxPlatform.getFile(listName);
    if (!file.existsSync()) {
      return;
    }

    var (int error, String date) = await DateUtil.dateTimeChange(
        null,
        DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM,
        DateTimeFormatKind.FT_YYYYMMDD_HHMMSS,
        DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
    nowTime = date;
    (ret, difSec) =
    TimeStamp.getDiffSec(histRetryTime, nowTime, difSec); // 現在時刻との比較
    if (ret == -1) {
      log = "$callFunc : diff sec error";
      TprLog().logAdd(tid, LogLevelDefine.error, log);

      var (int error, String date) = await DateUtil.dateTimeChange(
          null,
          DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM,
          DateTimeFormatKind.FT_YYYYMMDD_HHMMSS,
          DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
      histRetryTime = date;
      return;
    }

    if (difSec > 1800) {
      // 30分以上経過
      log = "$callFunc : retry start ";
      TprLog().logAdd(tid, LogLevelDefine.normal, log);

      histRetryTime = nowTime;

      execName =
      "${EnvironmentData().sysHomeDir}${HistMain.RETRY_FTP_EXEC_FNAME}";

      if (AplLibStdAdd.aplLibRename(tid, listName, execName) == true) {
        ret = 1;
      } else {
        ret = 0;
      }

      if (ret != 0) {
        return;
      }

      fp = AplLibStdAdd.aplLibFileOpen(tid, execName, "r");
      if (fp != null) {
        while (true) {
          if (fp
              .readAsStringSync()
              .isEmpty) {
            break;
          }

          // TODO:00013 三浦 動作確認
          endPnt = getBuf.substring(0, 1);
          for (num = 0; num < 9; num++) {
            if (num == 8) {
              chkSepa = RETRY_SEPA_END;
            } else {
              chkSepa = RETRY_SEPA;
            }

            if (num == 0) {
              plus = 0;
            } else {
              plus = RETRY_SEPA.length;
            }

            startPnt = endPnt.substring(plus);
            endPnt = startPnt.indexOf(chkSepa).toString();
            if (endPnt.length - startPnt.length < tmpBuf.length) {
              tmpBuf = startPnt.substring(0, endPnt.length - startPnt.length);

              switch (num) {
                case 0:
                  tHistLogMst.hist_cd = int.tryParse(tmpBuf) ?? 0;
                  break;
                case 1:
                  tHistLogMst.ins_datetime = tmpBuf;
                  break;
                case 2:
                  tHistLogMst.comp_cd = int.tryParse(tmpBuf) ?? 0;
                  break;
                case 3:
                  tHistLogMst.stre_cd = int.tryParse(tmpBuf) ?? 0;
                  break;
                case 4:
                  tHistLogMst.table_name = tmpBuf;
                  break;
                case 5:
                  tHistLogMst.mode = int.tryParse(tmpBuf) ?? 0;
                  break;
                case 6:
                  tHistLogMst.mac_flg = int.tryParse(tmpBuf) ?? 0;
                  break;
                case 7:
                  tHistLogMst.data1 = tmpBuf;
                  break;
                case 8:
                  tHistLogMst.data2 = tmpBuf;
                  break;
                default:
                  break;
              }
            }
          }

          if (tHistLogMst.hist_cd! <= 0 ||
              (int.tryParse(tHistLogMst.table_name!) ?? 0) == 0 ||
              (int.tryParse(tHistLogMst.data1!) ?? 0) == 0 ||
              (int.tryParse(tHistLogMst.data2!) ?? 0) == 0 ||
              (int.tryParse(tHistLogMst.ins_datetime!) ?? 0) == 0) {
            // TODO: 10034 日付管理 - timestamp.c datetime_dayscalc()呼び出し
            // || datetime_dayscalc(tHistLogMst.ins_datetime, nowTime) > 5){
            log =
            "$callFunc : no retry hist_cd[${tHistLogMst
                .hist_cd}] ins_datetime[${tHistLogMst.ins_datetime}]";
            TprLog().logAdd(tid, LogLevelDefine.normal, log);
          } else {
            log = "$callFunc : retry exec hist_cd[${tHistLogMst.hist_cd}] ";
            TprLog().logAdd(tid, LogLevelDefine.normal, log);

            // TODO:10152 履歴ログ ファイルリクエスト？の為後回し
            // hist_FIleRequest( tid, tHistLogMst );
          }
        }
        AplLibStdAdd.aplLibRemove(tid, execName);
      }
    }
  }

  /// 関連tprxソース: hist_proc.c - histlog_get
  static Future<(int, int)> histLogGet(TprMID tid, int pTuples, int limitCnt) async {
    int result = 0;

    result = HistMain.HIST_NG;
    if (histCheckCreate(tid) == -1) {
      if (await SysMain.createTempTableLists(tid) != HistMain.HIST_OK) {
        TprLog().logAdd(tid, LogLevelDefine.error, "histlog_get : error\n");
        return (HistMain.HIST_DBFILE_NG, 0);
      }
    }

    (result, pTuples) = await HistUpDb.histUpTableFromSrx(tid, pTuples, limitCnt);

    return (result, pTuples);
  }
}