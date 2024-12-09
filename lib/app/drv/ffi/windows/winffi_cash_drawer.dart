/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:ffi/ffi.dart';
import 'package:flutter/widgets.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import '../library.dart';
import '../../../inc/apl/rxmem_define.dart';

class WinFFICashDrawer {

  // WITHOUT_DEVICE=ture時のデバッグ用条件
  int drwStat  = 1;   // 閉状態
  int drwStat2 = 1;   // 閉状態

  /// イベント受付オープン
  ///
  /// 引数:[filePath] ファイルディスクリプタのパス
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 失敗
  int openDrwEvent(Pointer<Utf8> filePath) {
    // 外部関数（インターフェース）
    final int Function(Pointer<Utf8> filePath) interface = drwDylib
        .lookup<NativeFunction<Int16 Function(Pointer<Utf8>)>>('OpenDrwEvent')
        .asFunction();

    // APIコール
    late int ret;
    if (!isWithoutDevice()) {
      ret = interface(filePath);
    } else {
      debugPrint(
          "WinFFICashDrawer.openDrwEvent() -- interface(filePath) WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret; // 0：成功, -1：失敗
  }

  /// イベント受付クローズ
  ///
  /// 引数：なし
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 異常終了
  ///
  ///       -2 : 不明なエラー
  int closeDrwEvent() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('CloseDrwEvent')
        .asFunction();

    // APIコール
    late int ret;
    if (!isWithoutDevice()) {
      ret = interface();
    } else {
      debugPrint(
          "WinFFICashDrawer.closeDrwEvent() -- interface() WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret; // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  /// ドロア―　ポートオープン
  ///
  /// 引数:[filePath] ファイルディスクリプタのパス
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 失敗
  int openDrwDIOPort(Pointer<Utf8> filePath) {
    // 外部関数（インターフェース）
    final int Function(Pointer<Utf8> filePath) interface = drwDylib
        .lookup<NativeFunction<Int16 Function(Pointer<Utf8>)>>('OpenDrwDIOPort')
        .asFunction();

    // APIコール
    late int ret;
    if (!isWithoutDevice()) {
      ret = interface(filePath);
    } else {
      debugPrint(
          "WinFFICashDrawer.openDrwDIOPort() -- interface(filePath) WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret; // 0：成功, -1：失敗
  }

  /// ドロア―　ポートクローズ
  ///
  /// 引数:[fds]　ファイルディスクリプタの番号
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 異常終了
  ///
  ///       -2 : 不明なエラー
  int closeDrwDIOPort() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('CloseDrwDIOPort')
        .asFunction();

    // APIコール
    late int ret;
    if (!isWithoutDevice()) {
      ret = interface();
    } else {
      debugPrint(
          "WinFFICashDrawer.closeDrwDIOPort() -- interface() WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret; // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  /// ドロア―　開コマンド
  ///
  /// 引数　；　なし
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 異常終了
  ///
  ///       -2 : 不明なエラー
  int openDrw() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('OpenDrw')
        .asFunction();

    // APIコール
    late int ret;
    if (!isWithoutDevice()) {
      ret = interface();
    } else {
      debugPrint("WinFFICashDrawer.openDrw() -- interface() WITHOUT_DEVICE実行");
      drwStat  = 0; // ドロア開
      drwStat2 = 1; // ドロア開
      ret = drwStat;
    }

    return ret; // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  /// ドロア―　閉コマンド
  ///
  /// 引数：なし
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 異常終了
  ///
  ///       -2 : 不明なエラー
  ///
  /// ※WITHOUT_DEVICE=trueで実行時用のコマンド。ドロア閉状態を作る。
  int closeDrw() {
    // APIコール
    late int ret;
    if (!isWithoutDevice()) {
      // 実機では手操作でドロアを閉じる。自動で閉じたりはしない。
    } else {
      debugPrint("WinFFICashDrawer.closeDrw() -- interface() WITHOUT_DEVICE実行");
      drwStat  = 1; // ドロア閉
      drwStat2 = 1; // ドロア開
      ret = 0;
    }

    return ret; // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  /// ドロア―　開閉状態問合せ
  ///
  /// 引数：なし
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 異常終了
  ///
  ///       -2 : 不明なエラー
  int inqDrwOpened() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('InqDrwOpened')
        .asFunction();

    // APIコール
    late int ret;
    if (!isWithoutDevice()) {
      ret = interface();
    } else {
      debugPrint(
          "WinFFICashDrawer.inqDrwOpened() -- interface() WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret; // 0：正常終了, -1：異常終了, else -2：不明なエラー
  }

  /// ドロア―　ステータス取得
  ///
  /// 引数：なし
  ///
  /// 戻り値： RxTaskStatDrw
  ///
  /// 　　　　　result = 0 : 正常終了、 -1 : 異常終了
  ///
  ///         drwStat  : ドロア1の開閉状態（1:閉、0:開）
  ///
  ///         drwStat2 : ドロア2の開閉状態（1:閉、0:開）（閉固定）
  RxTaskStatDrw getDrwStat() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('GetDrwStat')
        .asFunction();

    // APIコール
    RxTaskStatDrw ret = RxTaskStatDrw();
    if (!isWithoutDevice()) {
      ret.result = 0;
      ret.drwStat  = interface();
      ret.drwStat2 = 1;    // 常時閉
    } else {
      ret.result = 0;
      ret.drwStat  = drwStat;
      ret.drwStat2 = drwStat2;
    }
    return ret; // 0：開, 1：閉, else -1：ステータスエラー（非接続状態）
  }

  // イベントカウンタ取得
  int getDrwCntRef() {
    // 外部関数（インターフェース）
    final int Function() interface = drwDylib
        .lookup<NativeFunction<Int16 Function()>>('GetDrwCntRef')
        .asFunction();

    // APIコール
    late int ret;
    if (!isWithoutDevice()) {
      ret = interface();
    } else {
      debugPrint(
          "WinFFICashDrawer.getDrwCntRef() -- interface() WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret;
  }

  /// イベント待機リセット
  ///
  /// 引数：なし
  ///
  /// 戻り値：なし
  void releaseDrw() {
    // 外部関数（インターフェース）
    final void Function() interface = drwDylib
        .lookup<NativeFunction<Void Function()>>('ReleaseDrw')
        .asFunction();

    // APIコール
    if (!isWithoutDevice()) {
      interface();
    } else {
      debugPrint(
          "WinFFICashDrawer.releaseDrw() -- interface() WITHOUT_DEVICE実行");
    }
  }
}
