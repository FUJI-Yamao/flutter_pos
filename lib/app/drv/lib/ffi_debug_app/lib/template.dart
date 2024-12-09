/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:io' show Platform;

import 'ffi/ffi_access_test.dart';

String test(String strPut, int arg) {
  // インスタンス生成
  var ffiTest = FFIAccessTest();

  // intの引数と戻り値
  int atx = ffiTest.getLibVar(arg);
  debugPrint("ExecuteTest: $atx");
  strPut += "ExecuteTest: $atx\n";

  // コールバック
  atx = ffiTest.getCallback(arg);
  debugPrint("GetCallBack: $atx");
  strPut += "GetCallBack: $atx\n";

  if (Platform.isMacOS) {
    // something...
  }
  else if (Platform.isWindows) {
    // something...
  }
  else if (Platform.isLinux) {
    // something...
  }
  else if (Platform.isAndroid) {
    // zlibバージョン情報取得
    //disp = ffia.zlibVersion();
  }
  else {
    // something...
  }

  return strPut;
}