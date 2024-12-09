/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:isolate';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'if_drv_control.dart';
import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/sys/tpr_log.dart';
import '../drv/sample/drv_sample_isolate.dart';

/// アプリ側のインターフェース（サンプル）
/// mainIsolateとデバドラ側Isolateとのやり取りを管理する.
class IfSampleIsolate{
  /// デバイスのIsolateのport.
  SendPort? _outputPort;
  late ReceivePort _inputPort;
  int taskId = 0;

  /// デバイスのIsolateをスタートする
  Future<void> startIsolate(String absolutePath, int tid) async {
    debugPrint("IfSampleIsolate　startSampleIsolate実行");
    ReceivePort receivePort = ReceivePort();
    taskId = tid;

    await Isolate.spawn(DrvSampleIsolate.drvIsolateStart,
        DeviceIsolateInitData(receivePort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            SystemFunc.readRxCommonBuf(), SystemFunc.readRxTaskStat()));
    _outputPort = await receivePort.first as SendPort;
    receivePort.close();
    TprLog().logAdd(taskId, LogLevelDefine.normal, "SAMPLE Isolate port set.");
    driverStart();
  }

  /// デバイス動作開始
  void driverStart() {
    debugPrint("IfSampleIsolate　driverStart実行");  // 疎通確認が出来たら消して下さい。
    _inputPort = ReceivePort();

    _inputPort.listen((notify) async {
      final notifyFromDev = notify as NotifyFromSIsolate;
      switch (notifyFromDev.notifyType) {
        case NotifyTypeFromSIsolate.uploadShareMemory:
          var payload = notifyFromDev.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(
              null, payload.index, payload.buf, payload.attention, "SAMPLE");
          break;
        default:
          break;
      }
    });

    if (_outputPort != null) {
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.driverStart, null, returnPort: _inputPort.sendPort));
    } else {
      TprLog().logAdd(taskId, LogLevelDefine.error, "SAMPLE Isolate port not set.");
    }
  }

  /// Isolateに対して、停止のメッセージ を送る
  Future<void> sendStop() async {
    // _outputPortがnullの時にコールされたら、無視する
    if (_outputPort == null) return;

    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.stop, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfSampleIsolate sendStop");
  }

  /// Isolateに対して、再開のメッセージ を送る
  Future<void> sendRestart() async {
    // _outputPortがnullの時にコールされたら、無視する
    if (_outputPort == null) return;

    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.restart, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfSampleIsolate sendRestart");
  }

  /// デバドラ側で保持している共有メモリを更新させる。
   void updateShareMemory(SystemFuncPayload payload) async {
    if (_outputPort != null) {
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory,
          payload, returnPort: _inputPort.sendPort));
    }
  }
}