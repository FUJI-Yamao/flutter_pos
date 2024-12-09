/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_log.dart';
import '../ffi/windows/winffi_scanner.dart';

/// スキャンタイプ
/// case SCAN_SDT_UPCA:     sType = "UPCA";
/// case SCAN_SDT_UPCE:     sType = "UPCE";
/// case SCAN_SDT_JAN8:     sType = "JAN8";
///	case SCAN_SDT_EAN8:     sType = "EAN8";
///	case SCAN_SDT_JAN13:    sType = "JAN13";
///	case SCAN_SDT_EAN13:    sType = "EAN13";
///	case SCAN_SDT_TF:       sType = "TF";
/// case SCAN_SDT_ITF:      sType = "ITF";
///	case SCAN_SDT_Codabar:  sType = "Codabar";
///	case SCAN_SDT_Code39:   sType = "Code39";
///	case SCAN_SDT_Code93:   sType = "Code93";
///	case SCAN_SDT_Code128:  sType = "Code128";
///	case SCAN_SDT_UPCA_S:   sType = "UPCA_S";
///	case SCAN_SDT_UPCE_S:   sType = "UPCE_S";
///	case SCAN_SDT_UPCD1:    sType = "UPCD1";
///	case SCAN_SDT_UPCD2:    sType = "UPCD2";
///	case SCAN_SDT_UPCD3:    sType = "UPCD3";
///	case SCAN_SDT_UPCD4:    sType = "UPCD4";
///	case SCAN_SDT_UPCD5:    sType = "UPCD5";
///	case SCAN_SDT_EAN8_S:   sType = "EAN8_S";
///	case SCAN_SDT_EAN13_S:  sType = "EAN13_S";
///	case SCAN_SDT_EAN128:   sType = "EAN128";
///	case SCAN_SDT_OCRA:     sType = "OCRA";
///	case SCAN_SDT_OCRB:     sType = "OCRB";
///	case SCAN_SDT_PDF417:   sType = "PDF417";
///	case SCAN_SDT_MAXICODE: sType = "MAXICODE";
///	case SCAN_SDT_OTHER:    sType = "OTHER";
///	case SCAN_SDT_UNKNOWN:  sType = "UNKNOWN";

/// テスト受信形式（ほうじ茶の場合）
/// ScanData,ScanType,ScanLabel
/// F4901085176146,JAN13,4901085176146

/// テストで以下3つをランダムに5回受信するように設定済み
/// const ScanInfo sInfoList[] =
/// {
///   {"F4902102130356", "JAN13", "4902102130356"},	// 綾鷹
///   {"F4901085176146", "JAN13", "4901085176146"},	// ほうじ茶
///   {"F4902888256233", "JAN13", "4902888256233"},	// ダース
/// };

enum ScnData { scanData, scanType, scanLabel }

class WinDrvScan {
  var ffiScn = WinFFIScanner();
  SendPort parentSendPort;

  /// スキャナステート
  bool isOpened = false;
  WinDrvScan(this.parentSendPort);

  /// スキャナをオープンする関数
  bool scanOpen() {
    final Pointer<Utf8> pathPointer =
        "lib\\app\\drv\\lib\\Windows\\dist\\x64\\Release\\ScanRcv.exe"
            .toNativeUtf8();
    int isSuccess = ffiScn.openScn(pathPointer);
    calloc.free(pathPointer);
    if (isSuccess != 0) {
      TprLog().logAdd(
          0, LogLevelDefine.normal, "Windows scanner port open failed.");
      isOpened = false;
      return false;
    }
    TprLog()
        .logAdd(0, LogLevelDefine.normal, "Windows scanner port open success.");
    isOpened = true;
    return true;
  }

  /// イベント受付スレッド
  Future<void> startScanner() async {
    /// scanOpenから2秒ごとに5回受信
    // 監視ループ
    // スキャンカウンタ開始で有効
    while (isOpened) {
      if (0 < ffiScn.getScanCntRef()) {
        String scanData = ffiScn.getScanData();
        String scanType = ffiScn.getScanType();
        String scanLabel = ffiScn.getScanLabel();
        TprLog().logAdd(0, LogLevelDefine.normal,
            "Windows scanner input data: $scanData type:$scanType label:$scanLabel");
        if (scanType == "JAN13") {
          // PLUコード.アプリ側へ送信.
          RxInputBuf inp = RxInputBuf();
          inp.ctrl.ctrl = true;
          inp.devInf.devId = 1;
          inp.funcCode = FuncKey.KY_PLU.keyId;
          // 入力をそのままPLUコードとする.
          inp.devInf.barData = scanLabel;
          parentSendPort.send(NotifyFromSIsolate(
              NotifyTypeFromSIsolate.scanData, inp)); // メインアプリのスレッドにinput情報を送信.
        }

        // スキャンリセット
        ffiScn.releaseScan();
      }
      await Future.delayed(const Duration(milliseconds: 5));
    }
  }

  /// スキャナをクローズする関数
  void scanClose() {
    // 受信ストップ（プロセス停止）
    int atx = ffiScn.closeScn();
    debugPrint("closeScn : $atx");
    isOpened = false;
  }
}
