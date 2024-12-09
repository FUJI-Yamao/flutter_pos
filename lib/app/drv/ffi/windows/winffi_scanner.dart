/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import '../library.dart';

class WinFFIScanner {
  // スキャナオープン
  int openScn(Pointer<Utf8> filePath) {
    // 外部関数（インターフェース）
    final int Function(Pointer<Utf8> filePath) interface = scnDylib
        .lookup<NativeFunction<Int16 Function(Pointer<Utf8>)>>('OpenScn')
        .asFunction();

    // APIコール
    int ret = interface(filePath);

    return ret;   // 0：成功, -1：失敗
  }

  // スキャナクローズ
  int closeScn() {
    // 外部関数（インターフェース）
    final int Function() interface = scnDylib
        .lookup<NativeFunction<Int16 Function()>>('CloseScn')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // スキャナデータ取得
  String getScanData() {
    // 外部関数（インターフェース）
    final Pointer<Utf8> Function() interface = scnDylib
        .lookup<NativeFunction<Pointer<Utf8> Function()>>('GetScanData')
        .asFunction();

    // APIコール
    String ret = interface().toDartString();

    return ret;
  }

  String getScanType() {
    // 外部関数（インターフェース）
    final Pointer<Utf8> Function() interface = scnDylib
        .lookup<NativeFunction<Pointer<Utf8> Function()>>('GetScanType')
        .asFunction();

    // APIコール
    String ret = interface().toDartString();

    return ret;
  }

  String getScanLabel() {
    // 外部関数（インターフェース）
    final Pointer<Utf8> Function() interface = scnDylib
        .lookup<NativeFunction<Pointer<Utf8> Function()>>('GetScanLabel')
        .asFunction();

    // APIコール
    String ret = interface().toDartString();

    return ret;
  }

  // スキャンカウンタ取得
  int getScanCntRef() {
    // 外部関数（インターフェース）
    final int Function() interface = scnDylib
        .lookup<NativeFunction<Int16 Function()>>('GetScanCntRef')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;
  }

  // スキャン待機リセット
  void releaseScan() {
    // 外部関数（インターフェース）
    final void Function() interface = scnDylib
        .lookup<NativeFunction<Void Function()>>('ReleaseScan')
        .asFunction();

    // APIコール
    interface();
  }
}