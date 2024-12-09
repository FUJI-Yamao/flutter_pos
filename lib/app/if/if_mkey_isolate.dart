/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'if_sound.dart';
import '../regs/checker/rcdetect.dart';
import 'if_drv_control.dart';
import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../lib/apllib/rm_common.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/sys/tpr_ipc.dart';
import '../inc/sys/tpr_log.dart';
import '../inc/sys/tpr_did.dart';
import '../regs/checker/rc_key.dart';
import '../drv/mkey/drv_mkey_isolate.dart';

/// アプリ側のインターフェース
/// mainIsolateとmkey_Isolateとのやり取りを管理する.
class IfMkeyIsolate{
  /// デバイスのIsolateのport.
  SendPort? _outputPort;
  late ReceivePort _inputPort;

  int taskId = 0;
  int deviceId = 0;
  RmCommon rmCommon = RmCommon();

  /// FunctionKeyが押されたときの処理.
  /// 各画面で必要な処理を登録する.
  KeyDispatch? get dispatch {
    if(IfDrvControl().dispatchMap.isEmpty){
      return null;
    }
    return IfDrvControl().dispatchMap.values.last;
  }
  TprMsgDevNotify_t notifyt = TprMsgDevNotify_t();

  /// デバイスのIsolateをスタートする
  Future<void> startIsolate(String absolutePath, int tid) async {
    debugPrint("IfSampleIsolate　startSampleIsolate実行");
    ReceivePort receivePort = ReceivePort();
    taskId = tid;
    switch(taskId) {
      case (0x00001000):
        notifyt.tid = TprDidDef.TPRDIDMECKEY1;
        break;
      case (0x00002000):
        notifyt.tid = TprDidDef.TPRDIDMECKEY2;
        break;
    }
    deviceId = notifyt.tid;
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    await Isolate.spawn(DrvMKeyIsolate.drvIsolateStart,
        DeviceIsolateInitData(receivePort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            SystemFunc.readRxCommonBuf(),
            SystemFunc.readRxTaskStat(),
            SystemFunc.readRxSoundStat(),
            null,
            rootIsolateToken),
        );
    _outputPort = await receivePort.first as SendPort;
    receivePort.close();
    TprLog().logAdd(taskId, LogLevelDefine.normal, "mechaKey Isolate port set.");
    driverStart();
  }

  /// デバイス動作開始
  /// メカキーの入力を受付状態にする.
  void driverStart() {
    _inputPort = ReceivePort();

    _inputPort.listen((notify) async {
      final notifyFromDev = notify as NotifyFromSIsolate;
      switch (notifyFromDev.notifyType) {
        case NotifyTypeFromSIsolate.mechaKeyCommand:
          var data = notifyFromDev.option as RxInputBuf;
          notifyt.data[1] = data.mecData;
          data.funcCode = rmCommon.rmMecDataToFncCode(notifyt);
          await _mkeySoundBeep();
          RcDetect.rcInputData(data);
          try {
            dispatch?.rcDKeyByKeyId(data.funcCode, null);
          } catch (e) {
            TprLog().logAdd(taskId, LogLevelDefine.normal, "KeyDispatch is Null");
          }
          break;
        case NotifyTypeFromSIsolate.uploadShareMemory:
          var payload = notifyFromDev.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(
              null, payload.index, payload.buf, payload.attention, "MKEY");
          break;
        default:
          break;
      }
    });

    if (_outputPort != null) {
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.driverStart, null, returnPort: _inputPort.sendPort));
    } else {
      TprLog().logAdd(taskId, LogLevelDefine.error, "mechaKey Isolate port not set.");
    }
  }

  /// Isolateに対して、停止のメッセージ を送る
  Future<void> sendStop() async {
    // _outputPortがnullの時にコールされたら、無視する
    if (_outputPort == null) return;

    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.stop, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfMkeyIsolate sendStop");
  }

  /// Isolateに対して、再開のメッセージ を送る
  Future<void> sendRestart() async {
    // _outputPortがnullの時にコールされたら、無視する
    if (_outputPort == null) return;

    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.restart, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfMkeyIsolate sendRestart");
  }

  /// デバドラ側で保持している共有メモリを更新させる。
  void updateShareMemory(SystemFuncPayload payload) async {
    if (_outputPort != null) {
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory,
          payload, returnPort: _inputPort.sendPort));
    }
  }

  /// メカキーを模擬入力する。
  ///
  /// 引数:[keyCode] メカキーのキーコード
  ///
  /// 戻り値: なし
  ///
  /// 使い方例：IfDrvControl().mkeyIsolateCtrl.testKeyCodeInput(testKey);
  void keyCodeLoopbackIn(int keyCode) async {
    if (_outputPort != null) {
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.loopbackIn,
          keyCode, returnPort: _inputPort.sendPort));
    }
  }

  /// ビープ音を発生させる
  ///
  /// 引数: なし
  ///
  /// 戻り値: なし
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - sound_beep()
  Future<void> _mkeySoundBeep() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(taskId, LogLevelDefine.error, "rxMemRead() error");
      return;
    }
    RxTaskStatBuf taskStat = xRet.object;
    if (taskStat.sound.stop > 0) {
      TprLog().logAdd(taskId, LogLevelDefine.normal, "sound_beep stop");
      return;
    }
    if (deviceId == TprDidDef.TPRDIDMECKEY1) {
      IfSound.ifBz();
    } else {
      IfSound.ifBzCshr();
    }
  }
}
