/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import 'Windows/windrv_mkey.dart';
import 'ubuntu/tprdrv_mkey.dart';
import '../ffi/library.dart';
import '../../common/environment.dart';
import '../../common/cmn_sysfunc.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';

///  サンプルを制御するためのクラス.
class DrvMKeyIsolate {

  static TprDrvMkey tprDrvMkey = TprDrvMkey();
  static WinDrvMkey winDrvMkey = WinDrvMkey();

  /// サンプルIsolate.
  static Future<void> drvIsolateStart(DeviceIsolateInitData initData) async {

    BackgroundIsolateBinaryMessenger.ensureInitialized(initData.token  as RootIsolateToken);

    SendPort _parentSendPort = initData.appPort;
    DrvMKeyIsolate isolate = DrvMKeyIsolate();

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    _parentSendPort.send(sendPort);
    // ログ設定.
    TprLog().setIsolateName("Mkey", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = initData.appPath;
    // 使用する共有メモリをセットアップする
    await setupShareMemory(initData);

    // ホームパス（環境変数）を取得.
    EnvironmentData().sysHomeDir = initData.appEnv.sysHomeDir;

    // アプリからの通知を受け取る.
    receivePort.listen((notify) {
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.driverStart:
          isolate.driverStart(notify.returnPort!, initData.taskId);
          break;
        case NotifyTypeFromMIsolate.loopbackIn:
          int keyCode = notify.option as int;
          if (Platform.isLinux || isLinuxDebugByWin()) {
            tprDrvMkey.keyCodeLoopbackIn(keyCode);
          }
          break;
        case NotifyTypeFromMIsolate.abort:   // 中断
          tprDrvMkey.abort();
          break;
        case NotifyTypeFromMIsolate.stop:    // 停止
          tprDrvMkey.stop();
          break;
        case NotifyTypeFromMIsolate.restart: // 再開
          tprDrvMkey.restart();
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(notify.returnPort!,
              payload.index, payload.buf, RxMemAttn.SLAVE, "MKEY");
          break;
        default:
          break;
      }
    });
  }

  ///　初期化＆デバイス動作処理
  Future<void> driverStart(SendPort parentSendPort, int tid) async {
    try {
      TprLog().logAdd(tid, LogLevelDefine.normal, "-----Mkey start-----");
      if (Platform.isLinux || isLinuxDebugByWin()) {
        if (!(await tprDrvMkey.drv_init(parentSendPort, tid))) {
          TprLog().logAdd(tid, LogLevelDefine.error, "Mkey drv_init() error");
          return;
        }
        await tprDrvMkey.drv_start();
      } else if (Platform.isWindows) {
        if (!(await winDrvMkey.drv_init(parentSendPort, tid))) {
          TprLog().logAdd(tid, LogLevelDefine.error, "Mkey drv_init() error");
          return;
        }
        winDrvMkey.drv_start();
      }
    } catch (e, s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "Mkey error $e $s");
    }
  }

  // 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_SOUND);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, initData.pCom!,  RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf!, RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_SOUND,  initData.sound!, RxMemAttn.MASTER);
  }
}
