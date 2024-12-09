/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';

import 'tprdrv_drw.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/apl/rxmem_define.dart';

///  関連tprxソース:rmmain.c
///  ドロアを制御するためのクラス.
class DrvDrwIsolate {

  /// ドロアIsolate.
  static Future<void> drvDrwIsolateStart(DeviceIsolateInitData initData) async {
    SendPort _parentSendPort = initData.appPort;

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    TprDrvDrw tprDrvDrw = TprDrvDrw();

    _parentSendPort.send(sendPort);
    // ログ設定.
    TprLog().setIsolateName("Drawer", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = initData.appPath;
    // 使用する共有メモリをセットアップする
    await setupShareMemory(initData);

    bool isInit = false;
    // *********************************
    // receivePort.listen
    // ドロアのイベントが発生するごとに呼ばれる。
    // *********************************
    receivePort.listen((notify) async {
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.receiveStart:
        // ドロア初期設定.ログが出るようにログを受け取ってから行う.
          _parentSendPort = notify.returnPort!;
          final result = await tprDrvDrw.drw_init(initData.taskId, _parentSendPort);
          isInit = (result == TprDrvDrw.DRW_OK_I);
          tprDrvDrw.sendReady(isInit);
          break;
        case NotifyTypeFromMIsolate.drwOpen:
          if (!isInit) {
            return;
          }
          tprDrvDrw.drw_open(notify.option as int);
          break;
        case NotifyTypeFromMIsolate.drwClose:
          if (!isInit) {
            return;
          }
          tprDrvDrw.drw_close();
          break;
        case NotifyTypeFromMIsolate.abort:   // 中断
          tprDrvDrw.abort();
          break;
        case NotifyTypeFromMIsolate.stop:    // 停止
          tprDrvDrw.stop();
          break;
        case NotifyTypeFromMIsolate.restart: // 再開
          tprDrvDrw.restart();
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(_parentSendPort, payload.index, payload.buf, RxMemAttn.SLAVE, "DRW ");
          break;
        case NotifyTypeFromMIsolate.drwPortClose:
          if (!isInit) {
            return;
          }
          tprDrvDrw.drwPortClose();
          break;
        default:
          break;
      }
    });
  }

  // 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, initData.pCom!,  RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT  , initData.tsBuf!, RxMemAttn.MASTER);
  }
}
