/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/sys/tpr_log.dart';
import '../inc/sys/tpr_def_asc.dart';
import '../inc/sys/tpr_type.dart';
import '../inc/sys/tpr_ipc.dart';
import '../inc/sys/tpr_dlg.dart';
import '../inc/sys/tpr_mid.dart';
import '../drv/upsPlus/drv_upsPlus_isolate.dart';
import 'if_drv_control.dart';

/// UpsPlus アプリ側のインターフェース
/// mainIsolateとupsPlusIsolateとのやり取りを管理する.
class IfUpsPlusIsolate{
  /// UpsPlusのIsolateのport.
  late SendPort _upsPlusIsolatePort;
  /// ドライバの情報
  int taskId = 0;

  /// UpsPlusのIsolateをスタートする.
  Future<void> startUpsPlusIsolate(String absolutePath, int tid) async {
    // 受信ポート.
    var receivePort = ReceivePort();
    taskId = tid;
    await Isolate.spawn( DrvUpsPlusIsolate.drvUpsPlusIsolateStart,
        DeviceIsolateInitData(receivePort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            SystemFunc.readRxCommonBuf(), SystemFunc.readRxTaskStat()));
    // 初めにportが返ってくるので、portをセットする.
    _upsPlusIsolatePort  = await receivePort.first as SendPort;
    debugPrint("upsPlus Isolate port set." );
    receivePort.close();
    TprLog().logAdd(
        taskId, LogLevelDefine.normal, "upsPlus Isolate port set.");

  }

  /// shutdownコマンド要求
  /// int mode : 0:reboot / 0以外:halt
  Future<void> upsShutdown(int mode) async {
    _upsPlusIsolatePort?.send(NotifyFromApp(NotifyTypeFromMIsolate.shutdownRequest, mode));
  }

}

