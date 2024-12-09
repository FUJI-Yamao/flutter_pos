/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_pos/app/lib/if_th/if_th_init.dart';
import 'package:flutter_pos/app/lib/if_th/if_th_csndlogo.dart';

import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../drv/printer/drv_print_isolate.dart';
import '../drv/printer/ubuntu/drv_printer_def.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/sys/tpr_did.dart';
import '../inc/sys/tpr_ipc.dart';
import '../inc/sys/tpr_log.dart';
import '../sys/regs/rmmain.dart';
import '../ui/page/common/component/w_msgdialog.dart';
import '../if/common/interface_define.dart';
import 'if_drv_control.dart';

/// プリンタ アプリ側のインターフェース
/// mainIsolateとprintIsolateとのやり取りを管理する.
class IfPrintIsolate {

  static const PRINT_DRIVER_WAIT_TIME = 10000;     // 10sec
  static const PRINT_DRIVER_DELAY = 100;           // 100ms
  static const PRINT_DRIVER_WAIT = PRINT_DRIVER_WAIT_TIME / PRINT_DRIVER_DELAY;     // 10sec / 100ms

  /// プリンタのIsolateのport.
  SendPort? _outputPort;
  late ReceivePort _inputPort;

    /// タスクID
  int taskId = 0;

  /// プリンタのIsolateをスタートする.
  Future<void> startPrintIsolate(String absolutePath, int tid) async {
    _inputPort = ReceivePort();
    taskId = tid;

    await Isolate.spawn(DrvPrintIsolate.drvPrintIsolateStart,
        DeviceIsolateInitData(_inputPort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            SystemFunc.readRxCommonBuf(), SystemFunc.readRxTaskStat()));

    _outputPort = await _inputPort.first as SendPort;
    _inputPort.close();

    TprLog()
        .logAdd(0, LogLevelDefine.normal, "printer Isolate port set.");
    driverStart();
    checkAndLoadReceiptLogo(taskId, absolutePath);
    await IfThInit.ifThInit(0);
  }

  /// デバイス動作開始
  void driverStart() {
    _inputPort = ReceivePort();
    Rmmain rmMain = Rmmain();

    _inputPort.listen((notify) async {
      final notifyFromDev = notify as NotifyFromSIsolate;
      switch (notifyFromDev.notifyType) {
        case NotifyTypeFromSIsolate.printStatus:
          var tprMsg = notifyFromDev.option as TprMsg;
          tprMsg.devack2.src = Tpraid.TPRAID_PRN;
          int ret = await rmMain.devAckReceiptMain(tprMsg.devack2);
          if (ret != 0) {
            debugPrint("プリンタ 通知エラー (rmMain.devAckReceiptMain):${tprMsg.devack2.data.join("")}");
          }
          break;
        case NotifyTypeFromSIsolate.uploadShareMemory:
          var payload = notifyFromDev.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(
              null, payload.index, payload.buf, payload.attention, "PRINTER");
          break;
        default:
          break;
      }
    });

    _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.driverStart, null,
        returnPort: _inputPort.sendPort));
  }

  /// プリンタへのメッセージデータ送信
  Future<void> printReceiptData(PrintOutputInfo info) async {
    _outputPort?.send(NotifyFromApp(
        NotifyTypeFromMIsolate.printCommand, info, returnPort: _inputPort.sendPort));
  }

  /// プリンタへのメッセージデータ送信
  Future<void> printReceiptData2(TprMsgDevReq2 data, {bool syncFlag = false}) async {
    if (syncFlag) {
      RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_PRN_STAT);
      if (xRetC.isInvalid()) {
        return ;
      }
      RxPrnStat stat = xRetC.object;
      stat.Ctrl.ctrl = false;
      await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_PRN_STAT, stat, RxMemAttn.MAIN_TASK, "");
    }

    _outputPort?.send(NotifyFromApp(
        NotifyTypeFromMIsolate.commandSend, data, returnPort: _inputPort.sendPort));

    if (!syncFlag) {
      return ;
    }
    for( int i=0; i<PRINT_DRIVER_WAIT ;i++) {
      RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_PRN_STAT);
      if (xRetC.isInvalid()) {
        TprLog().logAdd(taskId, LogLevelDefine.error,
            "printReceiptData2 rxMemRead RXMEM_PRN_STAT error!!");
        return ;
      }
      RxPrnStat prnStat = xRetC.object;
      if( prnStat.Ctrl.ctrl ) {
        break;
      }
      await Future.delayed(const Duration(milliseconds: PRINT_DRIVER_DELAY));
    }
  }

  /// レシートが正しく設定されているかチェックする.
  Future<void> checkReceiptSetting() async {
    if (IfDrvControl.isWithoutDeviceMode()) {
      return;
    }

    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.checkReceiptSetting, null, returnPort: _inputPort.sendPort));
    var response = await _inputPort.first;
    final notifyFromDev = response as NotifyFromSIsolate;
    _inputPort.close();
    if(notifyFromDev.notifyType == NotifyTypeFromSIsolate.receiptSettingError){
      // レシートセットエラー.
      showReceiptSettingErrorDialog();
    }
  }

  /// レシートが正しく設定されていなかった場合に表示するダイアログ.
  static void showReceiptSettingErrorDialog(){
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: "レシートが正しくセットされているか確認してください")
    );
  }

  /// Isolateに対して、停止のメッセージ を送る
  Future<void> sendStop() async {
    // _outputPortがnullの時にコールされたら、無視する
    if (_outputPort == null) return;

    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.stop, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfPrintIsolate sendStop");
  }

  /// Isolateに対して、再開のメッセージ を送る
  Future<void> sendRestart() async {
    // _outputPortがnullの時にコールされたら、無視する
    if (_outputPort == null) return;

    _outputPort?.send(NotifyFromApp(NotifyTypeFromMIsolate.restart, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfPrintIsolate sendRestart");
  }

  /// デバドラ側で保持している共有メモリを更新させる。
  void updateShareMemory(SystemFuncPayload payload) async {
    if (_outputPort != null) {
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory,
          payload, returnPort: _inputPort.sendPort));
    }
  }

  /// レシートのデフォルトロゴが使用可能状態にあるか確認し、無ければassetsからロードする（共通）
  static Future<void> checkAndLoadReceiptLogo(int tid, String appPath) async {
    String rctPath = appPath + DrvPrnDef.RCT_PATH;
    String cmLogoPath = appPath + DrvPrnDef.CMLOGO_PATH;
    File file = File("$rctPath${DrvPrnDef.DEFAULT_LOGO}");

    if (!Directory(rctPath).existsSync()) {
      Directory(rctPath).createSync(recursive: true);
    }
    if (!Directory(cmLogoPath).existsSync()) {
      Directory(cmLogoPath).createSync(recursive: true);
    }
    if (file.existsSync()) {
      return;
    }
    var imgFile = await rootBundle.load(DrvPrnDef.ASSETS_LOGO);
    var imgBuffer = imgFile.buffer;
    await file.writeAsBytes(imgBuffer.asUint8List(
        imgFile.offsetInBytes,imgFile.lengthInBytes));
    // デフォルトロゴの登録
    IfThCSndlogo.ifThCSendLogoType(tid, 1, DrvPrnDef.DEFAULT_LOGO_PATH, TprDidDef.TPRDIDRECEIPT3);
  }
}
