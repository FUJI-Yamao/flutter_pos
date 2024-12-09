/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'package:flutter/cupertino.dart';

import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/acbJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_ipc.dart';
import 'tprdrv_changer.dart';

///  関連tprxソース:rmmain.c
///  釣銭機を制御するためのクラス.
class DrvChangerIsolate {
  /// 釣銭機Isolate.
  static bool isInit = false;
  static Future<void> drvChangerIsolateStart(DeviceIsolateInitData initData) async {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    SendPort parentSendPort = initData.appPort;
    // ログ設定.
    TprLog().setIsolateName("Changer", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = initData.appPath;

    // 使用する共有メモリをセットアップする
    await setupShareMemory(initData);

    TprDrvChanger changerReceive = TprDrvChanger();
    // 釣銭機初期設定.ログが出るようにログを受け取ってから行う.
    final result = await changerReceive.changer_init(initData.taskId);
    isInit = (result == TprDrvChanger.CHANGER_OK_I);
    if(isInit) {
        parentSendPort.send(sendPort);
    } else {
        parentSendPort.send(null);
    }
    changerReceive.sendReady(isInit);
    // *********************************
    // receivePort.listen
    // 釣銭機のイベントが発生するごとに呼ばれる。
    // *********************************
    receivePort.listen((notify) async {
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.changerRequest:
          if (!isInit) {
            return;
          }
          changerReceive.changerRequest(notify.msg as TprMsgDevReq2_t, notify.returnPort as SendPort);
          debugPrint("changerRequest() asynchronous");
          break;
        case NotifyTypeFromMIsolate.changerReceive:
          if (!isInit) {
            return;
          }
          changerReceive.changerDataReceive(notify.returnPort as SendPort);
          debugPrint("changerDataReceive() asynchronous");
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(parentSendPort, payload.index, payload.buf, RxMemAttn.SLAVE, "CHANGER");
          break;
        default:
          debugPrint("notifyData.notifyType error");
          break;
      }
    });
  }

  // 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, initData.pCom!,  RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf!, RxMemAttn.MASTER);
  }
}
