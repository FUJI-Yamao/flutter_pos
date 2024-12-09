/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:io' show Platform;
import "dart:isolate";

import 'ffi/windows/winffi_mkey.dart';

String mkeyTest(String strPut) {
  /// キーID     POSキー   PCキー
  /// 0x00      0          0
  /// 0x01      1          1
  /// 0x02      2          2
  /// 0x03      3          3
  /// 0x04      4          4
  /// 0x05      5          5
  /// 0x06      6          6
  /// 0x07      7          7
  /// 0x08      8          8
  /// 0x09      9          9
  /// 0x0A      00         Dot
  /// 0x0B      小計       RCtrl
  /// 0x0C      現計       Enter
  /// 0x0D      CLEAR     F20
  /// 0x0E      ×          U
  /// 0x0F      PLU        J
  /// 0xFF      なし       Esc（デバッグ用）

  String retCache = ">>> Mkey\n";
  debugPrint(retCache);
  strPut += retCache;
  if (Platform.isMacOS) {
    // something...
  }
  else if (Platform.isWindows) {
    var ffiMkey = WinFFIMkey();

    // キーフック開始
    Isolate.spawn(_startKeyHook, ffiMkey);
    retCache = "openMkey()\n";
    debugPrint(retCache);
    strPut += retCache;

    // 監視ループ
    bool isStroke = true;
    while (true) {
      if (1 == ffiMkey.getStrokeStat() && isStroke) {
        String key = ffiMkey.getKey();
        if ("0xFF" == key) {
          break;
        }
        else {
          debugPrint(key);
          strPut += "$key\n";
        }
        isStroke = false;
      }
      else if (0 == ffiMkey.getStrokeStat()) {
        isStroke = true;
      }
    }

    // キーフック終了
    ffiMkey.closeMkey();
    retCache = "closeMkey()\n";
    debugPrint(retCache);
    strPut += retCache;
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

void _startKeyHook(WinFFIMkey ffiMkey) async {
  ffiMkey.openMkey();
}