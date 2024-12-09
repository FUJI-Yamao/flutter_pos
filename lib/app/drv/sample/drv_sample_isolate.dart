/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import 'drv_sample.dart';
import '../../common/environment.dart';
import '../../common/cmn_sysfunc.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';

///  サンプルを制御するためのクラス.
class DrvSampleIsolate {

  DrvSample drvSample = DrvSample();

  /// サンプルIsolate.
  static Future<void> drvIsolateStart(DeviceIsolateInitData initData) async {
    debugPrint("DrvSampleIsolate　drvIsolateStart");   // 疎通確認ができたら消して下さい。
    SendPort _parentSendPort = initData.appPort;
    DrvSampleIsolate isolate = DrvSampleIsolate();

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    _parentSendPort.send(sendPort);
    // ログ設定.
    TprLog().setIsolateName("SAMPLE", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = initData.appPath;
    // ホームパス（環境変数）を取得.
    EnvironmentData().sysHomeDir = initData.appEnv.sysHomeDir;
    // 使用する共有メモリをセットアップする
    await setupShareMemory(initData);

    // アプリからの通知を受け取る.
    receivePort.listen((notify) {
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.driverStart:
          isolate.driverStart(notify.returnPort!, initData.taskId);
          break;
        case NotifyTypeFromMIsolate.abort:   // 中断
          isolate.drvSample.abort();
          break;
        case NotifyTypeFromMIsolate.stop:    // 停止
          isolate.drvSample.stop();
          break;
        case NotifyTypeFromMIsolate.restart: // 再開
          isolate.drvSample.restart();
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(notify.returnPort!,
              payload.index, payload.buf, RxMemAttn.SLAVE, "SAMPLE");
          break;
        default:
          break;
      }
    });

    // 初期化（必要に応じて実装。特になければ、ここでは不要）
  }

  ///　初期化＆デバイス動作処理
  Future<void> driverStart(SendPort parentSendPort, int tid) async {
    drvSample.drv_init(parentSendPort, tid);
    drvSample.drv_start();
  }

  // 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, initData.pCom!,  RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf!, RxMemAttn.MASTER);
  }
}
