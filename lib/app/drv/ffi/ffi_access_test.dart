/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;

typedef Handler = Int16 Function(Pointer<NativeFunction<HCallback>>, Int16 arg);
typedef CallFunc = int Function(Pointer<NativeFunction<HCallback>>, int arg);
typedef HCallback = Int16 Function(Pointer<Void>, Int16);

class FFIAccessTest {
  // test.c > ExecuteTest のインターフェースからAPIの戻り値を取得
  int getLibVar(int arg) {
    // 外部関数（インターフェース）
    final int Function(int arg) interface = testDylib
        .lookup<NativeFunction<Int16 Function(Int16)>>('ExecuteTest')
        .asFunction();

    // 関数コール
    int ret = interface(arg);  // arg+1返却

    return ret;
  }

  static int callback(Pointer<Void> ptr, int arg) {
    debugPrint("In Callback : $arg");
    return arg + 1;
  }

  int getCallback(int arg) {
    // 外部関数（インターフェース）
    final CallFunc interface = testDylib
        .lookup<NativeFunction<Handler>>('GetCallback')
        .asFunction();

    // 関数コール
    int ret = interface(Pointer.fromFunction<HCallback>(callback, 0), arg);

    return ret;
  }

  // zlibバージョン情報取得（Androidの場合）
  String getzlibVersion() {
    final z = DynamicLibrary.open('libz.so');
    final zlibVersionPointer = z.lookup<NativeFunction<Pointer<Utf8> Function()>>('zlibVersion');
    final zlibVersion = zlibVersionPointer.asFunction<Pointer<Utf8> Function()>();
    final res = zlibVersion().toDartString();
    return res;
  }
}

ffi.DynamicLibrary? _testDylib;
ffi.DynamicLibrary get testDylib {
  if (_testDylib != null) {
    return _testDylib!;
  }

  // 共有ライブラリの遅延読込み
  try {
    if (Platform.isWindows) {
      // 共有ライブラリ読込み
      _testDylib = ffi.DynamicLibrary.open(path.join(
          Directory.current.path,
          '..',
          'lib',
          'Windows',
          'dist',
          'test.dll'));
    }
    else if (Platform.isLinux) {
      _testDylib = ffi.DynamicLibrary.open(path.join(
          Directory.current.path,
          'test_library',
          'libtest.so.1.0.0'));
    }
    else if (Platform.isAndroid) {
      // AndroidPhone内のディレクトリに格納しておく
      _testDylib = ffi.DynamicLibrary.open(path.join(
          'data',
          'data',
          'jp.co.fsi.ffi_debug_app',
          'files',
          'libtest.so'));
    }
    else {
      _testDylib = ffi.DynamicLibrary.process();
    }
  } catch (err) {
    // エラー画面表示
  }

  return _testDylib!;
}