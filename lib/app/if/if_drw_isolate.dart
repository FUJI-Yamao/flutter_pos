/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:isolate';

import 'package:flutter/cupertino.dart';

import 'if_drv_control.dart';
import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/sys/tpr_log.dart';
import '../drv/drw/drv_drw_isolate.dart';

/// ドロア　アプリ側のインターフェース
/// mainIsolateとdrwIsolateとのやり取りを管理する.
class IfDrwIsolate{
  /// ドロアのIsolateのport.
  SendPort? _drwIsolatePort;
  late ReceivePort _inputReceivePort;

  /// ドライバの情報
  int taskId = 0;

  /// ドロアのIsolateをスタートする.
  Future<void> startDrwIsolate(String absolutePath, int tid) async {
    ReceivePort receivePort = ReceivePort();
    taskId = tid;

    await Isolate.spawn( DrvDrwIsolate.drvDrwIsolateStart,
        DeviceIsolateInitData(receivePort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            SystemFunc.readRxCommonBuf(), SystemFunc.readRxTaskStat()));
    // 初めにportが返ってくるので、portをセットする.
    _drwIsolatePort  = await receivePort.first as SendPort;
    receivePort.close();
    TprLog().logAdd(taskId, LogLevelDefine.normal, "drw Isolate port set.");
    sendTaskStatus();
  }

  /// ドロアのステータスを親タスクに展開する。
  void sendTaskStatus() {
    debugPrint("sendTaskStatus実行");

    _inputReceivePort =  ReceivePort();
    if (_drwIsolatePort == null) {
      TprLog().logAdd(taskId, LogLevelDefine.error, "drw Isolate port not set.");
      return;
    }
    _drwIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.receiveStart,
            null, returnPort: _inputReceivePort.sendPort));

    _inputReceivePort.listen((notify) async {
      final notifyFromDev = notify as NotifyFromSIsolate;
      switch (notifyFromDev.notifyType) {
        case NotifyTypeFromSIsolate.uploadShareMemory:
          var payload = notifyFromDev.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(
              null, payload.index, payload.buf, payload.attention, "DRW ");
          break;
        default:
          break;
      }
    });
  }

  /// ドロアを開く
  void openDrw() {
    if (_drwIsolatePort != null) {
      _drwIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.drwOpen, 1));
    }
  }

  /// ドロアを閉じる（デバッグ用）
  void closeDrw() {
    if (_drwIsolatePort != null) {
      _drwIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.drwClose, 1));
    }
  }

  /// Isolateに対して、停止のメッセージ を送る
  Future<void> sendStop() async {
    // _drwIsolatePortがnullの時にコールされたら、無視する
    if (_drwIsolatePort == null) return;

    _drwIsolatePort?.send(NotifyFromApp(NotifyTypeFromMIsolate.stop, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfDrwIsolate sendStop");
  }

  /// Isolateに対して、再開のメッセージ を送る
  Future<void> sendRestart() async {
    // _drwIsolatePortがnullの時にコールされたら、無視する
    if (_drwIsolatePort == null) return;

    _drwIsolatePort?.send(NotifyFromApp(NotifyTypeFromMIsolate.restart, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfDrwIsolate sendRestart");
  }

  /// デバドラ側で保持している共有メモリを更新させる。
  void updateShareMemory(SystemFuncPayload payload) {
    if (_drwIsolatePort != null) {
      _drwIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory, payload));
    }
  }
}
