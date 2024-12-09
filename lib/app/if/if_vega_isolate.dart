/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:isolate';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../ui/page/device/controller/c_device_loading_controller.dart';
import '../drv/vega/drv_vega_isolate.dart';
import '../regs/checker/rc_vega3000.dart';
import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/sys/tpr_log.dart';
import '../drv/sample/drv_sample_isolate.dart';
import 'if_drv_control.dart';

/// アプリ側のインターフェース
/// mainIsolateとvegaIsolateとのやり取りを管理する.
class IfVegaIsolate {
  /// 稼働アイソレート
  late Isolate _isolate;
  /// VEGAデバイスのIsolateのport.
  SendPort? _outputPort;
  late ReceivePort _inputPort;
  int taskId = 0;

  /// VEGAデバイスのIsolateをスタートする
  Future<void> startIsolate(String absolutePath, int tid) async {
    debugPrint("********** IfVegaIsolate　startIsolate実行");
    ReceivePort receivePort = ReceivePort();
    taskId = tid;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xRetStat.isInvalid()) {
      TprLog().logAdd(taskId, LogLevelDefine.error,
          "IfVegaIsolate.startIsolate(): rxMemPtr() error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xRetStat.object;

    _isolate = await Isolate.spawn(DrvVegaIsolate.drvIsolateStart,
        DeviceIsolateInitData(receivePort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            cBuf, tsBuf));
    _outputPort = await receivePort.first as SendPort;
    receivePort.close();
    TprLog().logAdd(taskId, LogLevelDefine.normal, "VEGA Isolate port set.");
  }

  /// デバイス動作開始
  void driverStart(RxCommonBuf cBuf, RxTaskStatBuf tsBuf) {
    _inputPort = ReceivePort();

    debugPrint("********** IfVegaIsolate.driverStart(): start | inputPort = $_inputPort");
    _inputPort.listen((notify) async {
      final notifyFromDev = notify as NotifyFromSIsolate;
      switch (notifyFromDev.notifyType) {
        case NotifyTypeFromSIsolate.uploadShareMemory:
          var payload = notifyFromDev.option as SystemFuncPayload;
          await SystemFunc.rxMemWrite(
              null, payload.index, payload.buf, payload.attention, "VEGA");
          debugPrint(
              "********** IfVegaIsolate.driverStart(): vegaOrder = ${payload.buf.vega.vegaOrder}");
          debugPrint(
              "********** IfVegaIsolate.driverStart(): type = ${payload.buf.vega.vegaData.type}");
          debugPrint(
              "********** IfVegaIsolate.driverStart(): errCode = ${payload.buf.vega.vegaData.errCode}");
          debugPrint(
              "********** IfVegaIsolate.driverStart(): cardData1 = ${payload.buf.vega.vegaData.cardData1}");
          debugPrint(
              "********** IfVegaIsolate.driverStart(): cardData2 = ${payload.buf.vega.vegaData.cardData2}");
          // 取得したカード情報より、会員呼出を開始する
          await DeviceLoadingController().outputMemberParam();
          break;
        default:
          break;
      }
    });

    if (_outputPort != null) {
      SystemFuncPayload optCmn = SystemFuncPayload();
      optCmn.index = RxMemIndex.RXMEM_COMMON;
      optCmn.buf = cBuf;
      optCmn.attention = RxMemAttn.SLAVE;
      SystemFuncPayload optStat = SystemFuncPayload();
      optStat.index = RxMemIndex.RXMEM_STAT;
      optStat.buf = tsBuf;
      optStat.attention = RxMemAttn.SLAVE;
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory, optCmn, returnPort: _inputPort.sendPort));
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory, optStat, returnPort: _inputPort.sendPort));
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.driverStart, null, returnPort: _inputPort.sendPort));
    } else {
      TprLog().logAdd(taskId, LogLevelDefine.error, "VEGA Isolate port not set.");
    }
  }

  /// Isolateに対して、停止のメッセージ を送る
  Future<void> driverStop(RxCommonBuf cBuf) async {
    debugPrint("********** IfVegaIsolate.driverStop(): start | outputPort = $_outputPort");
    // _outputPortがnullの時にコールされたら、無視する
    if (_outputPort == null) {
      return;
    }

    SystemFuncPayload optCmn = SystemFuncPayload();
    optCmn.index = RxMemIndex.RXMEM_COMMON;
    optCmn.buf = cBuf;
    optCmn.attention = RxMemAttn.SLAVE;
    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory, optCmn, returnPort: _inputPort.sendPort));
    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.stop, null));

    _outputPort = null;
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfVegaIsolate send Stop");
  }

  /// デバドラ側で保持している共有メモリ（RxTaskStatBuf）を更新させる。
  void updateShareMemory(SystemFuncPayload? payload) async {
    if (_outputPort != null) {
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory,
          payload, returnPort: _inputPort.sendPort));
    }
  }
}