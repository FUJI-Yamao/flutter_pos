/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/drv/printer/ubuntu/drv_printer.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_log.dart';
import '../ffi/library.dart';
import 'ubuntu/linuxdrv_print.dart';
import 'windrv_print.dart';
import '../../../clxos/calc_api_result_data.dart';

/// レシートに印字する内容.
class PrintOutputInfo {
  String logo1 = "";
  String body = "";
  String barcode = "";
  String message = "";
  String logo2 = "";
}

///  プリンタを制御するためのクラス.
class DrvPrintIsolate {
  late var drvPrint;
  bool isOpen = true;

  DrvPrintIsolate(SendPort parentSendPort) {
    if ((Platform.isLinux) || (isLinuxDebugByWin())) {
      //
    } else if (Platform.isWindows) {
      drvPrint = WinDrvPrint();
    } else {
      // TODO:Android　(仮)
      drvPrint = LinuxDrvPrint();
    }
  }

  /// プリンタIsolate.
  static Future<void> drvPrintIsolateStart(DeviceIsolateInitData initData) async {
    SendPort parentSendPort = initData.appPort;
    DrvPrintIsolate printIsolate = DrvPrintIsolate(parentSendPort);

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    parentSendPort.send(sendPort);
    // ログ設定.
    TprLog().setIsolateName("print", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
    // アプリパスを取得.
    AppPath().path = initData.appPath;
    // 使用する共有メモリをセットアップする
    await setupShareMemory(initData);
    // ホームパス（環境変数）を取得.
    EnvironmentData().sysHomeDir = initData.appEnv.sysHomeDir;
    // 電子レシート情報
    CalcResultPay resPay = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);

    // アプリからの通知を受け取る.
    receivePort.listen((notify) {
      if (Platform.isAndroid) {
        // 202212　プロトタイプ向け未対応.
        return;
      }
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.driverStart:
          printIsolate.driverStart(notify.returnPort!, initData.taskId,
              EnvironmentData().sysHomeDir);
          break;
        case NotifyTypeFromMIsolate.printCommand:
          if (!printIsolate.isOpen) {
            printIsolate.drvPrint.printOpen();
          }
          PrintOutputInfo info = notifyData.option as PrintOutputInfo;
          printIsolate._print(info, notify.returnPort);
          break;
        case NotifyTypeFromMIsolate.commandSend:
          if (!printIsolate.isOpen) {
            printIsolate.drvPrint.printOpen();
          }
          TprMsg_t printMsg = TprMsg();
          printMsg.devreq2 = notifyData.option as TprMsgDevReq2;
          printIsolate.drvPrint.tprMsgList.add(printMsg);
          break;
        case NotifyTypeFromMIsolate.checkReceiptSetting:
          if (!printIsolate.isOpen) {
            printIsolate.drvPrint.printOpen();
          }
          printIsolate._checkReceiptSetting(notify.returnPort);
          break;
        case NotifyTypeFromMIsolate.receivedata:
          resPay = notifyData.option as CalcResultPay;
          break;
        case NotifyTypeFromMIsolate.abort:   // 中断
          printIsolate.drvPrint.abort();
          break;
        case NotifyTypeFromMIsolate.stop:    // 停止
          printIsolate.drvPrint.stop();
          break;
        case NotifyTypeFromMIsolate.restart: // 再開
          printIsolate.drvPrint.restart();
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(notify.returnPort!,
              payload.index, payload.buf, RxMemAttn.SLAVE, "PRINTER");
          break;
        default:
          break;
      }
    });
  }

  /// デバイスオープン
  Future<void> driverStart(SendPort parentSendPort, int taskId, String homePath) async {
    try {
      TprLog().logAdd(taskId, LogLevelDefine.normal, "---print start---");
      if (Platform.isLinux || isLinuxDebugByWin()) {
        await _startReceiveLinux(parentSendPort, taskId, homePath);
      } else if (Platform.isWindows) {
        // TODO:Windows開発時に対応
      }
    } catch (e, s) {
      TprLog().logAdd(taskId, LogLevelDefine.error, "print start error $e $s");
    }
  }

  /// デバイスオープン（Linux版）
  Future<void> _startReceiveLinux(SendPort parentSendPort, int taskId, String homePath) async {
    drvPrint = DrvPrinter(parentSendPort);
    drvPrint.printerStart(parentSendPort, taskId, homePath, 1);
  }

  /// レシートを発行する.
  Future<void> _print(PrintOutputInfo info, SendPort? notifySendPort) async {
    try {
      TprLog().logAdd(0, LogLevelDefine.normal, "-----print start-----", );
      if ((Platform.isLinux) || (isLinuxDebugByWin())) {
        await _printLinux(info);
      } else if (Platform.isWindows) {
        await _printWin(info,notifySendPort);
      }
      TprLog().logAdd(0, LogLevelDefine.normal, "-----print end-----", );
    } catch (e, s) {
      TprLog().logAdd(
        0,
        LogLevelDefine.error,
        "print error $e $s",
      );
    }
  }

  /// レシートを発行する(windows版)
  Future<void> _printWin(PrintOutputInfo info,SendPort? notifySendPort) async {
    await drvPrint.startPrinter(notifySendPort: notifySendPort);

    drvPrint.logoRegister(1, "${EnvironmentData().sysHomeDir}/bmp/receipt.bmp");
    drvPrint.receiptOutput(info.body, info.barcode, info.message);
    //winPrint.printClose();
  }

  /// レシートを発行する(linux版)
  Future<void> _printLinux(PrintOutputInfo info) async {
    drvPrint.logoRegister(1, info.logo1);
    drvPrint.logoRegister(2, info.logo2);
    drvPrint.receiptOutput(info.body, info.barcode, info.message);
  }

  /// レシートが正しくセットされているかを確認する
  Future<void> _checkReceiptSetting(SendPort? notifySendPort) async {
    try {
      TprLog().logAdd(0, LogLevelDefine.normal, "-----print receipt setting check start-----", );
      if (Platform.isWindows) {
        await _checkReceiptSettingWindows(notifySendPort);
      } else if (Platform.isLinux) {
      }
    } catch (e, s) {
      TprLog().logAdd(
        0,
        LogLevelDefine.error,
        "print receipt setting check error $e $s",
      );
    }
  }

  /// レシートが正しくセットされているかを確認する(windows版)
  Future<void> _checkReceiptSettingWindows(SendPort? notifySendPort) async {
    await drvPrint.startPrinter(isWaitSetting: false,notifySendPort: notifySendPort);
    //winPrint.printClose();
  }

  // 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, initData.pCom!,  RxMemAttn.MASTER);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf!, RxMemAttn.MASTER);
  }
}
