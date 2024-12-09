/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:io' show Platform;

import 'ffi/windows/winffi_scanner.dart';

enum ScnData {
  scanData,
  scanType,
  scanLabel
}

String scnTest(String strPut) {
  strPut += ">>> Scanner\n";
  if (Platform.isMacOS) {
    // something...
  }
  else if (Platform.isWindows) {
    var ffiScn = WinFFIScanner();

    // スキャナオープン
    int atx = ffiScn.openScn(
        "..\\Windows\\dist\\x64\\Release\\ScanRcv.exe".toNativeUtf8());
    debugPrint("openScn: $atx");
    strPut += "openScn: $atx\n";

    debugPrint("Incomming...");

    /// TODO: スレッド化させる（フラグで割込み終了）
    int i = 0;
    while (true) {
      // スキャンカウンタ開始で有効
      if (0 < ffiScn.getScanCntRef()) {
        String scanData = ffiScn.getScanData();
        String scanType = ffiScn.getScanType();
        String scanLabel = ffiScn.getScanLabel();
        debugPrint("Data: $scanData,$scanType,$scanLabel");
        strPut += "Data: $scanData,$scanType,$scanLabel\n";

        ffiScn.releaseScan();
        i++;

        // 5回受信後に抜ける
        if (5 == i) {
          break;
        }
      }
    }

    // スキャナクローズ
    atx = ffiScn.closeScn();
    debugPrint("closeScn: $atx");
    strPut += "closeScn: $atx\n";
  }
  else if (Platform.isLinux) {
    // something...
  }
  else if (Platform.isAndroid) {
    // something...
  }
  else {
    // something...
  }

  return strPut;
}