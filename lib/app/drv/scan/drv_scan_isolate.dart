/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';


import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import 'drv_scan_main.dart';
import 'windrv_scan.dart';
import '../ffi/library.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/cls_conf/scan_2800_1JsonFile.dart';
import '../../common/cls_conf/scan_2800_2JsonFile.dart';
import '../../common/cls_conf/scan_2800ip_1JsonFile.dart';
import '../../common/cls_conf/scan_2800ip_2JsonFile.dart';
import '../../common/cls_conf/scan_2800im_1JsonFile.dart';
import '../../common/cls_conf/scan_2800im_2JsonFile.dart';
import '../../common/cls_conf/scan_2800a3_1JsonFile.dart';
import '../../common/cls_conf/scan_2800i3_1JsonFile.dart';
import '../../common/cls_conf/scan_2800g3_1JsonFile.dart';
import '../../common/cls_conf/scan_2800_3JsonFile.dart';
import '../../common/cls_conf/scan_2800_4JsonFile.dart';
import '../../common/cls_conf/recogkey_dataJsonFile.dart';
import '../../common/cls_conf/staffJsonFile.dart';
import '../../common/environment.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../lib/cm_sys/cm_cksys.dart';

///  スキャナを制御するためのクラス.
class DrvScanIsolate {
  late WinDrvScan winScan;
  late var scanner;

  DrvScanIsolate(SendPort parentSendPort) {
    if (Platform.isLinux || isLinuxDebugByWin()) {
      //
    } else if (Platform.isWindows) {
      winScan = WinDrvScan(parentSendPort);
    }
  }

  /// スキャナIsolate.
  static Future<void> drvScanIsolateStart(DeviceIsolateInitData initData) async {
    SendPort parentSendPort = initData.appPort;
    DrvScanIsolate isolate = DrvScanIsolate(parentSendPort);

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    parentSendPort.send(sendPort);
    // ログ設定.
    TprLog().setIsolateName("scanner", initData.appEnv.screenKind);
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
        case NotifyTypeFromMIsolate.receiveStart:
          isolate.startReceive(notify.returnPort!, initData.taskId);
          break;
        case NotifyTypeFromMIsolate.receiveStop:
          isolate.endReceive(notify.returnPort!, initData.taskId);
          break;
        case NotifyTypeFromMIsolate.commandSend:
          isolate.commandSend(notify.returnPort!, initData.taskId, notifyData);
          break;
        case NotifyTypeFromMIsolate.receivedata:
          var inp = notifyData.option as RxInputBuf;
          notify.returnPort!.send(NotifyFromSIsolate(
              NotifyTypeFromSIsolate.scanDataN, inp));
          break;
        case NotifyTypeFromMIsolate.abort:   // 中断
          isolate.scanner.abort();
          break;
        case NotifyTypeFromMIsolate.stop:    // 停止
          isolate.scanner.stop();
          break;
        case NotifyTypeFromMIsolate.restart: // 再開
          isolate.scanner.restart();
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(notify.returnPort!, payload.index, payload.buf, RxMemAttn.SLAVE, "SCAN");
          break;
        case NotifyTypeFromMIsolate.loopbackIn:
          String barcodeData = notifyData.option;
          isolate.scanner.drvScanTestBarcodeSet(barcodeData);
          break;
        default:
          break;
      }
    });
  }

  /// スキャナをONにする.
  Future<void> startReceive(SendPort parentSendPort, int taskId) async {
    try {
      TprLog().logAdd(taskId, LogLevelDefine.normal, "-----scanner start-----", );
      if (Platform.isLinux || isLinuxDebugByWin()) {
        await _startReceiveLinux(parentSendPort, taskId);
      } else if (Platform.isWindows) {
        _startReceiveWindows(parentSendPort, taskId);
      }
    } catch (e, s) {
      TprLog().logAdd(taskId, LogLevelDefine.error, "scanner start error $e $s", );
    }
  }

  /// スキャナをOFFにする.
  Future<void> endReceive(SendPort parentSendPort, int taskId) async {
    try {
      if (Platform.isLinux || isLinuxDebugByWin()) {
        _endReceiveLinux();
      } else if (Platform.isWindows) {
        _endReceiveWindows();
      }
      TprLog().logAdd(taskId, LogLevelDefine.normal, "-----scanner close-----", );
    } catch (e, s) {
      TprLog().logAdd(taskId, LogLevelDefine.error, "scanner close error $e $s", );
    }
  }

  /// スキャナにコマンドを送信する.
  Future<void> commandSend(SendPort parentSendPort, int taskId, NotifyFromApp notifyData) async {
    try {
      if (Platform.isLinux || isLinuxDebugByWin()) {
        _commandSendLinux(parentSendPort, taskId, notifyData);
      } else if (Platform.isWindows) {
        _commandSendWindows(parentSendPort, taskId, notifyData);
      }
      TprLog().logAdd(taskId, LogLevelDefine.normal, "-----scanner commandSend-----", );
    } catch (e, s) {
      TprLog().logAdd(taskId, LogLevelDefine.error, "scanner close error $e $s", );
    }
  }

  /// windows版のスキャナ受信処理.
  Future<void> _startReceiveWindows(SendPort parentSendPort, int taskId) async {
    if (winScan.isOpened) {
      // 既にONになっている.
      TprLog().logAdd(taskId, LogLevelDefine.normal, "Windows scanner port already open.");
      return;
    }

    bool isSuccess = winScan.scanOpen();
    if (!isSuccess) {
      return; //オープンに失敗したので以降の処理は行わない.
    }
    //スキャナ. 中でループしている.
    winScan.startScanner();
  }

  Future<void> _endReceiveWindows() async {
    winScan.scanClose();
  }

  Future<void> _commandSendWindows(SendPort parentSendPort, int taskId, NotifyFromApp notifyData) async {
//    winScan.scanClose();
  }

  /// scannerからの受信処理.Linux版.
  Future<void> _startReceiveLinux(SendPort parentSendPort, int taskId) async {
    scanner = ScanMain(parentSendPort);
    scanner.scannerStart(taskId);
  }

  Future<void> _endReceiveLinux() async {
    //
  }

  /// バーコードを模擬入力する。
  ///
  /// 引数:[keyCode] バーコードデータ
  ///
  /// 戻り値: なし
  void testBarcodeSet(String testBarcode) {
    scanner.drvScanTestBarcodeSet(testBarcode);
  }

  /// scannerからの受信処理.Linux版.
  Future<void> _commandSendLinux(SendPort parentSendPort, int taskId, notify ) async {
    final notifyData = notify as NotifyFromApp;
    scanner.ptTprMsg.data = notifyData.option;
    scanner.ptTprMsg.common.mid = TprMidDef.TPRMID_DEVREQ;
    scanner.ptTprMsg.common.length = scanner.ptTprMsg.data.length;
  }

  // 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, initData.pCom!,  RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf!, RxMemAttn.MASTER);
  }
}
