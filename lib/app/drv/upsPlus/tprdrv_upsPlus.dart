/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
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
import '../../lib/cm_sys/cm_cksys.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_lib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../ffi/library.dart';
import '../ffi/ubuntu/ffi_upsPlus.dart';

// デバイスドライバ制御_UpsPlus
///  関連ソース:\drv\ups_plus\tprdrv_ups.c
class TprDrvUpsPlus {

  /// 戻り値
  static const UPSPLUS_OK_I = 0;
  static const UPSPLUS_NG_I = -1;
  static const UPSPLUS_OK_B = true;
  static const UPSPLUS_NG_B = false;

  /// プロセス名

  /// 変数
  TprDID myDid = 0; /* My Device ID	*/
  TprTID myTid = 0; /* drw driver task id	*/

  late SysJsonFile sysIni;

  late RxTaskStatBuf taskStat;

  ///---------------------------------------------------------------------------
  /// 初期化関数
  /// 引数:[tid] タスクID
  /// 戻り値： 0 = Normal End
  ///         -1 = Error
  Future<int> upsPlusInit(int tid) async {
    /// タスクIDを取得する
    myTid = tid;

    /// Device IDをセットする
    myDid = TprDidDef.TPRDIDCHANGER3;

    /// 設定ファイルからデータを取得する。
    try {

    } catch (e) {
      TprLog().logAdd(myTid, LogLevelDefine.error, "slideSW inifile open error");
      return UPSPLUS_NG_I;
    }

    /// ポートオープン、パイプオープンを行う
    try {
      if (Platform.isLinux || isLinuxDebugByWin()) {
          var ffiUpsPlus = FFIUpsPlus();
          int res = -1;

          // デバイスオープン
          res = ffiUpsPlus.upsPlusOpen();
      } else if (Platform.isWindows) {
        debugPrint("upsPlus PortOpen (Windows:処理無し)");
      }
    } catch (e) {
      TprLog().logAdd(
          myTid, LogLevelDefine.error, "upsPlus port open err: ${e.toString()}");
      return UPSPLUS_NG_I;
    }

    return UPSPLUS_OK_I;
  }

  /// システムタスクへ、準備完了or未完了を送信する
  /// 引数:[isInit] upsPlusInit()の正常終了有無（true:Normal End  false:Error）
  /// 戻り値: なし
  void sendReady(bool isInit) {
    if (Platform.isLinux || isLinuxDebugByWin()) {
      if (isInit) {
        /* Notify ready status to system task */
        TprLib().tprReady(myDid, myTid);
        TprLog().logAdd(myTid, LogLevelDefine.warning, "Call TprReady()");
      } else {
        /* Notify not ready status to system task */
        TprLib().tprNoReady(myDid, myTid);
        TprLog()
            .logAdd(myTid, LogLevelDefine.normal, "Call TprNoReady(). Exit...");
        exit(-1);
      }

    } else if (Platform.isWindows) {
      debugPrint("drw sendReady (Windows:処理無し)");
    }
  }

  /// shutdown要求を送信する
  /// 引数: [mode] 0:reboot / 0以外:halt
  /// 戻り値: なし
  void shutdownRequest(int mode) {
      TprLog().logAdd(myTid, LogLevelDefine.warning, "shutdown Request ");
      if (Platform.isLinux || isLinuxDebugByWin()) {
        final ffiUpsPlus = FFIUpsPlus();
        // Shutdown
        ffiUpsPlus.upsPlusShutdown(mode);
      } else if (Platform.isWindows) {
        debugPrint("changerRequest (Windows:処理無し)");
      }
  }

}
