/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import '../library.dart';

class WinFFIMkey {
  // キーフック開始
  void openMkey() {
    // 外部関数（インターフェース）
    final void Function() interface = mkeyDylib
        .lookup<NativeFunction<Void Function()>>('OpenMkey')
        .asFunction();

    // APIコール
    interface();
  }

  // キーフック終了
  void closeMkey() {
    // 外部関数（インターフェース）
    final void Function() interface = mkeyDylib
        .lookup<NativeFunction<Void Function()>>('CloseMkey')
        .asFunction();

    // APIコール
    interface();
  }

  // キー取得
  String getKey() {
    // 外部関数（インターフェース）
    final Pointer<Utf8> Function() interface = mkeyDylib
        .lookup<NativeFunction<Pointer<Utf8> Function()>>('GetKey')
        .asFunction();

    // APIコール
    String ret = interface().toDartString();

    return ret;
  }

  // ストローク状態取得
  int getStrokeStat() {
    // 外部関数（インターフェース）
    final int Function() interface = mkeyDylib
        .lookup<NativeFunction<Int16 Function()>>('GetStrokeStat')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 1：押す, 0：離す
  }
}