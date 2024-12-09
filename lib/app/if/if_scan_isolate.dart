/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:isolate';

import 'package:flutter/cupertino.dart';

import 'if_drv_control.dart';
import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../drv/scan/drv_scan_isolate.dart';
import '../drv/scan/drv_scan_init.dart';
import '../drv/scan/drv_scan_aplreq.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/lib/drv_com.dart';
import '../inc/sys/tpr_log.dart';
import '../inc/sys/tpr_ipc.dart';
import '../../app/sys/regs/rmmain.dart';

/// プリンタ アプリ側のインターフェース
/// mainIsolateとprintIsolateとのやり取りを管理する.
class IfScanIsolate{
  /// スキャナのIsolateのport.
  SendPort? _scanIsolatePort;
  late ReceivePort _inputReceivePort;

  /// スキャンされたものに対して行う処理.
  /// 各画面で必要な処理を登録する.
  Function(RxInputBuf)? get funcScan {
    if(IfDrvControl().scanMap.isEmpty){
      return null;
    }
    return IfDrvControl().scanMap.values.last;
  }


  int taskId = 0;

  /// スキャナのIsolateをスタートする
  /// スキャナの機能もONにする.
  Future<void> startScanIsolate(String absolutePath, int tid) async {
    ReceivePort receivePort = ReceivePort();
    taskId = tid;

    RxMemRet retC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (retC.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = retC.object;

    await Isolate.spawn(DrvScanIsolate.drvScanIsolateStart,
        DeviceIsolateInitData(receivePort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            pCom, SystemFunc.readRxTaskStat()));
    _scanIsolatePort = await receivePort.first as SendPort;
    receivePort.close();
    TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner Isolate port set.");
    scannerOn();
  }

  /// スキャナをONにする.
  void scannerOn() {
    _inputReceivePort =  ReceivePort();
    if (_scanIsolatePort == null) {
      TprLog().logAdd(taskId, LogLevelDefine.error, "scanner Isolate port not set.");
      return;
    }
    _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.receiveStart,
            null, returnPort: _inputReceivePort.sendPort));
    Rmmain rmmain = Rmmain();
    List<RxInputBuf> data;

    _inputReceivePort.listen((notify) async {
      final notifyFromDev = notify as NotifyFromSIsolate;
      switch (notifyFromDev.notifyType) {
        case NotifyTypeFromSIsolate.scanData:
          var tprMsg = notifyFromDev.option as TprMsg;
          data = await rmmain.devNotifyScannerMain(tprMsg.devnotify);
          if (data.length == 1) {
            try {
              await SystemFunc.rxMemWrite(null, data[0].rxMemIndex, data[0], RxMemAttn.MAIN_TASK);
              funcScan?.call(data[0]);
            } catch(e) { }
          } else if (data.length > 1) {
            for (int i = 0; i < data.length; i++) {
              _scanIsolatePort?.send(
                  NotifyFromApp(NotifyTypeFromMIsolate.receivedata,
                      data[i], returnPort: _inputReceivePort.sendPort));
            }
          } else {
            debugPrint("バーコード破棄 (rmmain.devNotifyScannerMain):" + tprMsg.devnotify.data.join(""));
          }
          break;
        case NotifyTypeFromSIsolate.scanDataN:
          // CODE128など、1スキャンで複数バーコードが生成される場合
          var data = notifyFromDev.option as RxInputBuf;
          await SystemFunc.rxMemWrite(null, data.rxMemIndex, data, RxMemAttn.MAIN_TASK);
          funcScan?.call(data);
          break;
        case NotifyTypeFromSIsolate.uploadShareMemory:
          var payload = notifyFromDev.option as SystemFuncPayload;
          await SystemFunc.rxMemWrite(
              null, payload.index, payload.buf, payload.attention, "SCAN");
          break;
          break;
        default:
      }
    });
    TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner on.");
  }

  /// スキャナをOFFにする.
  void scannerOff() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort?.send(NotifyFromApp(NotifyTypeFromMIsolate.receiveStop,
          null, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner off.");
      _inputReceivePort.close();
    }
  }

  /// デバドラ側で保持している共有メモリを更新させる。
  void updateShareMemory(SystemFuncPayload payload) async {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory,
              payload, returnPort: _inputReceivePort.sendPort));
    }
  }

  /// Isolateに対して、停止のメッセージ を送る
  Future<void> sendStop() async {
    // _scanIsolatePortがnullの時にコールされたら、無視する
    if (_scanIsolatePort == null) return;

    _scanIsolatePort?.send(NotifyFromApp(NotifyTypeFromMIsolate.stop, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfScanIsolate sendStop");
  }

  /// Isolateに対して、再開のメッセージ を送る
  Future<void> sendRestart() async {
    // _scanIsolatePortがnullの時にコールされたら、無視する
    if (_scanIsolatePort == null) return;

    _scanIsolatePort?.send(NotifyFromApp(NotifyTypeFromMIsolate.restart, null));
    TprLog().logAdd(taskId, LogLevelDefine.normal, "IfScanIsolate sendRestart");
  }

  /// バーコードを模擬入力する。
  ///
  /// 引数:[barcodeData] バーコード
  ///
  /// 戻り値: なし
  ///
  /// 使い方例：IfDrvControl().scanIsolateCtrl.barcodeLoopbackIn(barcodeData);
  //          barcodeData = "F4902102141109" "\x0D";  // コーラ（改行コード要）
  void barcodeLoopbackIn(String barcodeData) {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.loopbackIn,
          barcodeData, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "barcode test data input");
    }
  }

  /// スキャナーへのコマンド送信（汎用）
  /// 引数:[scpuCmd] SCPUコマンド（enum SCAN_COMMANDから選択）
  /// 引数:[msg] 付随情報
  /// 戻り値：なし
  void scannerSndCmd(String scpuCmd, [String msg = ""]) {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          scpuCmd + msg, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner Apl Request.");
    }
  }

  /// スキャナーへのコマンド送信
  /// 引数:[param] キャラクタ
  /// 戻り値：なし
  void scannerCharset(int param) {
    String msg = "";
    switch(param){
      case 1:   // SCAN_RESCHAR.SCAN_ACK_NAK
        msg = DrvCom.ACK + DrvCom.NAK;
        break;
      case 2:   // SCAN_RESCHAR.SCAN_ACK_NAK_CR
        msg = 'M';
        break;
      case 3:   // SCAN_RESCHAR.SCAN_BEL
        msg = 'H';
        break;
      default:   // SCAN_RESCHAR.SCAN_O_N
        break;
    }
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_CHARSET + msg, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_CHARSET.");
    }
  }

  /// スキャナー有効
  /// 引数：なし
  /// 戻り値：なし
  void scannerEnable() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_ENABLE, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_ENABLE.");
    }
  }

  /// スキャナー無効
  /// 引数：なし
  /// 戻り値：なし
  void scannerDisable() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_DISABLE, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_DISABLE.");
    }
  }

  /// スキャナーDC2送信
  /// 引数：なし
  /// 戻り値：なし
  void scannerSendDc2() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_SEND_DC2, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_SEND_DC2.");
    }
  }

  /// スキャナー有効
  /// 引数：なし
  /// 戻り値：なし
  void scannerCharReq() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_CHARREQ, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_CHARREQ.");
    }
  }

  /// スキャナーハード有効
  /// 引数：なし
  /// 戻り値：なし
  void scannerHwEnable() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_HW_ENABLE, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_HW_ENABLE.");
    }
  }

  /// スキャナーハード無効
  /// 引数：なし
  /// 戻り値：なし
  void scannerHwDisable() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_HW_DISABLE, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_HW_DISABLE.");
    }
  }

  /// スキャナーパス有効
  /// 引数：なし
  /// 戻り値：なし
  void scannerPassEnable() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_PASS_ENABLE, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_PASS_ENABLE.");
    }
  }

  /// スキャナーパス無効
  /// 引数：なし
  /// 戻り値：なし
  void scannerPassDisable() {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_PASS_DISABLE, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_PASS_DISABLE.");
    }
  }

  /// スキャナーコマンド送信
  /// 引数：[msg]　コマンド
  /// 戻り値：なし
  void scannerCmdPsc(String msg) {
    if (_scanIsolatePort != null) {
      _scanIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.commandSend,
          SCAN_COMMAND.SCAN_CMD_PSC + msg, returnPort: _inputReceivePort.sendPort));
      TprLog().logAdd(taskId, LogLevelDefine.normal, "scanner SCAN_CMD_PSC.");
    }
  }
}