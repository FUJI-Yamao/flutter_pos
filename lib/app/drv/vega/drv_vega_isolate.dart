/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/if/if_vega_isolate.dart';

import '../../common/environment.dart';
import '../../common/cmn_sysfunc.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import 'drv_vega.dart';

/// VEGAデバイスを制御するためのクラス.
class DrvVegaIsolate {

  DrvVega drvVega = DrvVega();

  /// VEGAデバイス Isolate.
  static Future<void> drvIsolateStart(DeviceIsolateInitData initData) async {
    SendPort _parentSendPort = initData.appPort;
    DrvVegaIsolate isolate = DrvVegaIsolate();

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    _parentSendPort.send(sendPort);
    // ログ設定.
    TprLog().setIsolateName("VEGA", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = initData.appPath;
    // ホームパス（環境変数）を取得.
    EnvironmentData().sysHomeDir = initData.appEnv.sysHomeDir;
    // 使用する共有メモリをセットアップする
    await setupShareMemory(initData);

    // アプリからの通知を受け取る.
    receivePort.listen((notify) async {
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.driverStart:  //開始
          isolate.driverStart(notify.returnPort!, initData.taskId);
          break;
        case NotifyTypeFromMIsolate.stop:    // 停止
          isolate.driverStop();
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:  //共有クラス更新
          var payload = notify.option as SystemFuncPayload;
          await SystemFunc.rxMemWrite(notify.returnPort!,
              payload.index, payload.buf, RxMemAttn.SLAVE, "VEGA");
          if (payload.index == RxMemIndex.RXMEM_COMMON) {
            debugPrint("********** DrvVegaIsolate: vega3000CancelFlg = ${payload.buf.vega3000Conf.vega3000CancelFlg}");
          }
          break;
        default:
          break;
      }
    });

    // 初期化（必要に応じて実装。特になければ、ここでは不要）
  }

  /// 初期化＆デバイス動作処理
  Future<void> driverStart(SendPort parentSendPort, int tid) async {
    debugPrint("********** DrvVegaIsolate.driverStart(): start");
    drvVega.drv_init(parentSendPort, tid);
    drvVega.drv_start();
    debugPrint("********** DrvVegaIsolate.driverStart(): end");
  }

  /// デバイス停止処理
  void driverStop() {
    debugPrint("********** DrvVegaIsolate.driverStop(): start");
    drvVega.stop();
    debugPrint("********** DrvVegaIsolate.driverStop(): end");
  }

  // 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    debugPrint("********** DrvVegaIsolate.setupShareMemory(): start");
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, initData.pCom!,  RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf!, RxMemAttn.MASTER);
    debugPrint("********** DrvVegaIsolate.setupShareMemory(): end");
  }
}
