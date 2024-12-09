/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'package:ffi/ffi.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import '../library.dart';
import 'package:flutter/material.dart';

class WinFFIMkey {

  static String preDt = "2023-01-01 00:00:00.000000";  // debug用

  // キーフック開始
  Future<void> openMkey() async {
    if (!isWithoutDevice()) {
      // 外部関数（インターフェース）
      final void Function() interface = mkeyDylib
          .lookup<NativeFunction<Void Function()>>('OpenMkey')
          .asFunction();

      // APIコール
      interface();
    } else {
      debugPrint("メカキー ポートオープン " +
          "WinFFIMkey.openMkey() -- interface() WITHOUT_DEVICE実行");
    }
  }

  // キーフック終了
  void closeMkey() {
    if (!isWithoutDevice()) {
      // 外部関数（インターフェース）
      final void Function() interface = mkeyDylib
          .lookup<NativeFunction<Void Function()>>('CloseMkey')
          .asFunction();

      // APIコール
      interface();
    } else {
      debugPrint("メカキー ポートクローズ " +
          "WinFFIMkey.closeMkey() -- interface() WITHOUT_DEVICE実行");
    }
  }

  // キー取得
  String getKey() {
    String ret = "";
    if (!isWithoutDevice()) {
      // 外部関数（インターフェース）
      final Pointer<Utf8> Function() interface = mkeyDylib
          .lookup<NativeFunction<Pointer<Utf8> Function()>>('GetKey')
          .asFunction();

      // APIコール
      ret = interface().toDartString();
    } else {
      // 最終的にはソフトキー画面などからキー入力するようにしたい。
      // とりあえずの方法ですが、確認したいキーコードをkeyCodeにセットして、実行（リロード）して下さい。
      // キー入力の間隔はintervalで調整できます。雑な方法ですみません。
      String keyCode = "";// "0x0B":小計、"0x0C":現計
      final interval = 3;  // (sec)
      DateTime dt = DateTime.now();
      final dt0 = DateTime.parse(preDt);
      if (dt.difference(dt0).inSeconds > interval) {
        ret = keyCode;
        preDt = dt.toString();
      } else {
        ret = "";
      }
      if (ret != "") {
        debugPrint("メカキー キー入力：" + ret + " -- interface() WITHOUT_DEVICE実行");
      }
    }

    return ret;
  }

  // ストローク状態取得
  int getStrokeStat() {
    int ret = -1;
    if (!isWithoutDevice()) {
      // 外部関数（インターフェース）
      final int Function() interface = mkeyDylib
          .lookup<NativeFunction<Int16 Function()>>('GetStrokeStat')
          .asFunction();

      // APIコール
      ret = interface();
    } else {
      ret = 0;
    }

    return ret; // 1：押す, 0：離す
  }
}
