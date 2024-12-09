/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import 'tprdrv_multiTmn.dart';

///  関連ソース:src\regs\multi_tmn\rc_multi_tmn.c
///  MultiTmnを制御するためのクラス.
class DrvMultiTmnIsolate {
  /// MultiTmnIsolate.
  static SendPort? _multiTmnMainPort;

  static Future<void> drvMultiTmnIsolateStart(DeviceIsolateInitData initData) async {
    SendPort _parentSendPort = initData.appPort;
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    TprTID myTid = initData.taskId;

    TprDrvMultiTmn multiTmnReceive = TprDrvMultiTmn();

    // ログ設定.
    TprLog().setIsolateName("MultiTmn", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = initData.appPath;
    // 使用する共有メモリをセットアップする
    await setupShareMemory(initData);

    final result = await TprDrvMultiTmn().multiTmnInit(myTid, _parentSendPort, initData.appEnv.screenKind);
    bool isInit = (result == TprDrvMultiTmn.MULTITMN_OK_I);
    multiTmnReceive.sendReady(isInit);

    // アプリからの通知を受け取る.
    receivePort.listen((notify) {
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.receiveStart:
          debugPrint("DrvMultiTmnIsolate receiveStart receive. ");
          _multiTmnMainPort = notifyData.returnPort!;
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          if (_multiTmnMainPort != null) {
            _multiTmnMainPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory,
                           payload, returnPort: sendPort));
          }
          SystemFunc.rxMemWrite(_parentSendPort, payload.index, payload.buf, RxMemAttn.SLAVE, "MultiTMN");
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
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf!, RxMemAttn.MASTER);
  }

}
