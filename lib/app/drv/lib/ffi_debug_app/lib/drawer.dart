/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:io' show Platform;

import 'ffi/windows/winffi_cash_drawer.dart';

enum DrwStat {
  drwOpen,
  drwClose
}

String drwTest(String strPut) {
  strPut += ">>> CashDrawer\n";
  if (Platform.isMacOS) {
    // something...
  }
  else if (Platform.isWindows) {
    var ffiDrw = WinFFICashDrawer();
    int res = -1;

    // DIOポートオープン
    res = ffiDrw.openDrwDIOPort(
        "C:\\OPOS\\Teraoka\\bin\\trk03_gpio_rw.exe".toNativeUtf8());
    debugPrint("openDrwDIOPort: $res");
    strPut += "openDrwDIOPort: $res\n";
    sleep(Duration(seconds: 3));  // プロセス起動インターバル（アプリ初期化時）

    // イベント受付開始
    res = ffiDrw.openDrwEvent(
        "..\\Windows\\dist\\x64\\Release\\DrwRcv.exe".toNativeUtf8());
    debugPrint("openDrwEvent: $res");
    strPut += "openDrwEvent: $res\n";

    debugPrint("Incomming...");

    bool isOpened = false;
    while (true) {
      ffiDrw.inqDrwOpened();  // ドロア開閉状態問合せ
      if (0 < ffiDrw.getDrwCntRef()) {  // ドロアイベント受信
        int drwStatIdx = ffiDrw.getDrwStat();   // ドロア状態取得
        debugPrint("drwStat: $drwStatIdx");
        strPut += "drwStat: $drwStatIdx\n";

        switch (DrwStat.values[drwStatIdx]) {
          case DrwStat.drwOpen:   // ドロア開の場合
            // エラー画面表示
            debugPrint("Drawer is opened.");
            strPut += "Drawer is opened.\n";
            isOpened = true;
            break;
          case DrwStat.drwClose:  // ドロア閉の場合
            res = ffiDrw.openDrw();   // ドロアオープン
            debugPrint("openDrw: $res");
            strPut += "openDrw: $res\n";
            break;
          default:
            break;
        }
        ffiDrw.releaseDrw();

        // ドロア開の場合break
        if (isOpened) {
          break;
        }
      }
    }

    // イベント受付終了
    res = ffiDrw.closeDrwEvent();
    debugPrint("closeDrwEvent: $res");
    strPut += "closeDrwEvent: $res\n";

    // DIOポートクローズ
    res = ffiDrw.closeDrwDIOPort();
    debugPrint("closeDrwDIOPort: $res");
    strPut += "closeDrwDIOPort: $res\n";
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