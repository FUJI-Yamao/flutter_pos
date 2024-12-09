/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import '../library.dart';

class WinFFICashDrawer {
  // イベント受付オープン
  int openDrwEvent(Pointer<Utf8> filePath) {
    // 外部関数（インターフェース）
    final int Function(Pointer<Utf8> filePath) interface = drwDylib
        .lookup<NativeFunction<Int16 Function(Pointer<Utf8>)>>('OpenDrwEvent')
        .asFunction();

    // APIコール
    int ret = interface(filePath);

    return ret;   // 0：成功, -1：失敗
  }

  // イベント受付クローズ
  int closeDrwEvent() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('CloseDrwEvent')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // ポートオープン
  int openDrwDIOPort(Pointer<Utf8> filePath) {
    // 外部関数（インターフェース）
    final int Function(Pointer<Utf8> filePath) interface = drwDylib
        .lookup<NativeFunction<Int16 Function(Pointer<Utf8>)>>('OpenDrwDIOPort')
        .asFunction();

    // APIコール
    int ret = interface(filePath);

    return ret;   // 0：成功, -1：失敗
  }

  // ポートクローズ
  int closeDrwDIOPort() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('CloseDrwDIOPort')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // ドロアオープン
  int openDrw() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('OpenDrw')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // ドロア開閉状態問合せ
  int inqDrwOpened() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('InqDrwOpened')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  // ドロア状態取得
  int getDrwStat() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('GetDrwStat')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;   // 0：開, 1：閉, else -1：ステータスエラー（非接続状態）
  }

  // イベントカウンタ取得
  int getDrwCntRef() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('GetDrwCntRef')
        .asFunction();

    // APIコール
    int ret = interface();

    return ret;
  }

  // イベント待機リセット
  void releaseDrw() {
    // 外部関数（インターフェース）
    final void Function() interface = drwDylib
        .lookup<NativeFunction<Void Function()>>('ReleaseDrw')
        .asFunction();

    // APIコール
    interface();
  }
}