/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
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
import '../drv/multiTmn/drv_multiTmn_isolate.dart';
import 'if_drv_control.dart';

/// multiTmn　アプリ側のインターフェース
/// mainIsolateとmultiTmnIsolateとのやり取りを管理する.
class IfMultiTmnIsolate{
  /// multiTmnのIsolateのport.
  SendPort? _multiTmnIsolatePort;
  late ReceivePort _inputReceivePort;
  /// ドライバの情報
  RxTaskStatBuf _taskStat = RxTaskStatBuf();
  int taskId = 0;

  /// multiTmnのIsolateをスタートする.
  Future<void> startMultiTmnIsolate(String absolutePath, int tid) async {
    ReceivePort receivePort = ReceivePort();
    taskId = tid;
    await Isolate.spawn( DrvMultiTmnIsolate.drvMultiTmnIsolateStart,
        DeviceIsolateInitData(receivePort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            SystemFunc.readRxCommonBuf(), SystemFunc.readRxTaskStat()));
    // 初めにportが返ってくるので、portをセットする.
    _multiTmnIsolatePort  = await receivePort.first as SendPort?;
    debugPrint("multiTmn Isolate port set." );
    receivePort.close();
    TprLog().logAdd(
        taskId, LogLevelDefine.normal, "multiTmn Isolate port set.");
    sendTaskStatus();
  }

  /// 親タスクに展開する。
  void sendTaskStatus() {
    _inputReceivePort =  ReceivePort();
    if (_multiTmnIsolatePort == null) {
      TprLog().logAdd(taskId, LogLevelDefine.error, "multiTmn Isolate port not set.");
      return;
    }
    _multiTmnIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.receiveStart,
            null, returnPort: _inputReceivePort.sendPort));

    _inputReceivePort.listen((notify) async {
      final notifyFromDev = notify as NotifyFromSIsolate;
      switch (notifyFromDev.notifyType) {
        case NotifyTypeFromSIsolate.uploadShareMemory:
          var payload = notifyFromDev.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(
              null, payload.index, payload.buf, payload.attention, "multiTmn ");
          break;
        default:
          break;
      }
    });
  }

  /// Isolateに対して、停止のメッセージ を送る
  Future<void> sendStop() async {
    // _multiTmnIsolatePortがnullの時にコールされたら、無視する
    if (_multiTmnIsolatePort == null) return;

    _multiTmnIsolatePort?.send(NotifyFromApp(NotifyTypeFromMIsolate.stop, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfMultiTmnIsolate sendStop");
  }

  /// Isolateに対して、再開のメッセージ を送る
  Future<void> sendRestart() async {
    // _multiTmnIsolatePortがnullの時にコールされたら、無視する
    if (_multiTmnIsolatePort == null) return;

    _multiTmnIsolatePort?.send(NotifyFromApp(NotifyTypeFromMIsolate.restart, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfMultiTmnIsolate sendRestart");
  }

  /// デバドラ側で保持している共有メモリを更新させる。
  void updateShareMemory(SystemFuncPayload payload) async {
    if (_multiTmnIsolatePort != null) {
      _multiTmnIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory,
              payload, returnPort: _inputReceivePort.sendPort));
    }
  }


}

