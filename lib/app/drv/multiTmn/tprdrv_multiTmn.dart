/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:io';
import "dart:isolate";

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../if/if_drv_control.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/tmncat.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_lib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../ui/enum/e_screen_kind.dart';
import '../ffi/library.dart';
import '../ffi/ubuntu/ffi_multiTmn.dart';
import 'tprdrv_rc_multi_tmn.dart';

/// multi TMNプロセスを起動するときのデータ
class TmnThreadData {
  SendPort logPort;
  int taskId;
  ScreenKind screenKind;
  TmnThreadData(this.logPort, this.taskId, this.screenKind);
}

/// デバイスドライバ制御_multiTmn
///  関連ソース:src\regs\multi_tmn\rc_multi_tmn.c
class TprDrvMultiTmn {
  /// 戻り値
  static const MULTITMN_OK_I = 0;
  static const MULTITMN_NG_I = -1;
  static const MULTITMN_OK_B = true;
  static const MULTITMN_NG_B = false;

  static TprDID myDid = 0; /* My Device ID	*/
  static TprTID myTid = 0; /* drw driver task id	*/

  /// プロセス名
  static TprLog myLog = TprLog();

  int MULTI_IDOL_WAIT = (100); // 0.1秒 100ms

  String _multiTmnProcess = '/pj/tprx/apl/multiTmn';
  String _multiTmnShName = '/pj/tprx/apl/multiTmn.sh';

  ///---------------------------------------------------------------------------
  /// 初期化関数
  /// 引数:[tid] タスクID
  /// 戻り値： 0 = Normal End
  ///         -1 = Error
  Future<int> multiTmnInit(int taskId, SendPort parentSendPort, ScreenKind screenKind) async {
    /// タスクIDを取得する
    myTid = taskId;

    /// Device IDをセットする
    myDid = TprDidDef.TPRTIDFCL;

    myLog.setIsolateName("tmn", screenKind);
    
    /// 制御タスクメイン処理を起動する
    try {
      if ((Platform.isLinux) || (isLinuxDebugByWin())) {
        // Linux処理
        TprDrvRcMultiTmn multiTmn = TprDrvRcMultiTmn();

        if(multiTmn.ffiMultiTmn.tmnApiInit(_multiTmnShName) == tmncat.OPOS_SUCCESS) {
          myLog.logAdd(myTid, LogLevelDefine.warning, "proc start");

          await Isolate.spawn(multiTmnProcessStart, TmnThreadData(myLog.logPort!, myTid, screenKind));
          await Isolate.spawn(multiTmn.multiTmnMain, MultiTmnMainData(
                                                                parentSendPort, myLog.logPort!,
                                                                myTid, SystemFunc.readRxTaskStat(), screenKind));
        } else {
            debugPrint("multiTmnMain tmnApiInit() failed.");
        }
      } else if (Platform.isWindows) {
        debugPrint("multiTmn multiTmnInit (Windows:処理無し)");
        // 送信ポート未使用を通知
        parentSendPort.send(null);
      }
    } catch (e) {
      myLog.logAdd(
          myTid, LogLevelDefine.error, "multiTmn multiTmnInit err: ${e.toString()}");
      return MULTITMN_NG_I;
    }

    return MULTITMN_OK_I;
  }

  /// システムタスクへ、準備完了or未完了を送信する
  /// 引数:[isInit] multiTmnInit()の正常終了有無（true:Normal End  false:Error）
  /// 戻り値: なし
  void sendReady(bool isInit) {
    if (Platform.isLinux) {
      if (isInit) {
        /* Notify ready status to system task */
        TprLib().tprReady(TprDrvMultiTmn.myDid, TprDrvMultiTmn.myTid);
        myLog.logAdd(TprDrvMultiTmn.myTid, LogLevelDefine.warning, "Call TprReady()");
       } else {
         /* Notify not ready status to system task */
        TprLib().tprNoReady(TprDrvMultiTmn.myDid, TprDrvMultiTmn.myTid);
        myLog.logAdd(TprDrvMultiTmn.myTid, LogLevelDefine.normal, "Call TprNoReady(). Exit...");
      }

    } else if (Platform.isWindows) {
      debugPrint("tmn sendReady (Windows:処理無し)");
    }
  }

  /// multi TMNプロセス起動
  Future<void> multiTmnProcessStart(TmnThreadData inputData) async {
     int tid = inputData.taskId;
     final mLog = TprLog();
     
     mLog.setIsolateName("tmn", inputData.screenKind);
     mLog.logPort = inputData.logPort;
     mLog.sendWaitListLog();

     String log = "";
     if (File(_multiTmnProcess).existsSync()) {
       log = "multiTmn process start [" + _multiTmnProcess + "]";
       mLog.logAdd(tid, LogLevelDefine.warning, log);
       ProcessResult procResult = await Process.run(_multiTmnProcess, []);
       mLog.logAdd(tid, LogLevelDefine.warning, "multiTmn process stop");
     } else {
       log = "File does not exist [" + _multiTmnProcess + "]";
       mLog.logAdd(tid, LogLevelDefine.warning, log);
     }
  }
}
