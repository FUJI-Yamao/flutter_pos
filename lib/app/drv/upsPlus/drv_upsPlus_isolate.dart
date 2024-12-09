/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';

import 'package:flutter/cupertino.dart';

import '../../common/cls_conf/sysJsonFile.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_ipc.dart';
import 'tprdrv_upsPlus.dart';

///  関連tprxソース:tprdrv_ups.c
///  UpsPlusを制御するためのクラス.
class DrvUpsPlusIsolate {
  /// UpsPlusIsolate.
  static Future<void> drvUpsPlusIsolateStart(DeviceIsolateInitData initData) async {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    SendPort parentSendPort = initData.appPort;
    parentSendPort
        .send(sendPort);
    // ログ設定.
    TprLog().setIsolateName("UpsPlus", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = initData.appPath;

    TprDrvUpsPlus upsPlusReceive = TprDrvUpsPlus();
    bool isInit = false;
    // UpsPlus初期設定.ログが出るようにログを受け取ってから行う.
    final result = await upsPlusReceive.upsPlusInit(initData.taskId);
    isInit = (result == TprDrvUpsPlus.UPSPLUS_OK_I);
    upsPlusReceive.sendReady(isInit);
    // *********************************
    // receivePort.listen
    // UpsPlusのイベントが発生するごとに呼ばれる。
    // *********************************
    receivePort.listen((notify) async {
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.shutdownRequest:
          if (!isInit) {
            return;
          }
          upsPlusReceive.shutdownRequest(notify.option as int);
          debugPrint("shutdownRequest() asynchronous");
          break;
        default:
          debugPrint("notifyData.notifyType error");
      }
    });

  }

}
