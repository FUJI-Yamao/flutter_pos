/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../library.dart';

class MkeyRet {
  int result = 0; // ドライバ実行結果（取得キー）
  int fds = 0; // ファイルポインタ
}

class FFIMechanicalKey {

  static int testKey = 0;
  static String preDt = "2023-01-01 00:00:00.000000";  // debug用

  /// メカキー　ポートオープン
  ///
  /// 引数:[filePath] ファイルディスクリプタのパス
  ///
  /// 戻り値：MkeyRet
  ///
  ///         .result = 0  : Normal End
  ///
  ///         .result = -1 : Error End
  ///
  ///         .fds : ファイルディスクリプタの番号
  static MkeyRet mechanicalKeyPortOpen(String keyFilePath) {
    Pointer<Int> fds = malloc.allocate<Int>(4);
    final Pointer<Utf8> pathPointer = keyFilePath.toNativeUtf8();
    MkeyRet ret = MkeyRet();

    try {
      if (!isWithoutDevice()) {
        //外部関数（インターフェース）
        final int Function(Pointer<Utf8> filePath, Pointer<Int> fds) interface =
            mkeyDylib
                .lookup<
                    NativeFunction<
                        Int16 Function(Pointer<Utf8>,
                            Pointer<Int>)>>("MechanicalKeyPortOpen")
                .asFunction();

        //APIコール
        ret.result = interface(pathPointer, fds);
        ret.fds = fds.value;
      } else {
        debugPrint("メカキー ポートオープン " +
            "FFIMechanicalKey.mechanicalKeyPortOpen() -- interface() WITHOUT_DEVICE実行");
        ret.result = 0; // 正常終了
        ret.fds = 123456789;
      }
    } catch (e) {
      ret.result = -1; // 異常終了
      ret.fds = 0;
    } finally {
      calloc.free(fds);
      calloc.free(pathPointer);
    }

    return ret;
  }

  /// メカキー　ポートクローズ
  ///
  /// 引数:[fds] ファイルディスクリプタ
  ///
  /// 戻り値：0（成功）
  int mechanicalKeyPortClose(int fds) {
    late int ret;
    if (!isWithoutDevice()) {
      //外部関数（インターフェース）
      final int Function(int fds) interface = mkeyDylib
          .lookup<NativeFunction<Int16 Function(Int)>>("MechanicalKeyPortClose")
          .asFunction();

      //APIコール
      ret = interface(fds);
    } else {
      debugPrint("メカキー ポートクローズ " +
          "FFIMechanicalKey.MechanicalKeyPortClose() -- interface() WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret;
  }

  /// メカキー　データ受信処理
  ///
  /// 引数:[fds] ファイルディスクリプタ
  ///
  /// 　　:[filePath] ファイルディスクリプタのパス
  ///
  /// 戻り値：MkeyRet
  ///
  ///         .result：受信したキーコード
  ///
  ///         .fds：ファイルディスクリプタの番号（リオープンした場合に変化する場合有り）
  static MkeyRet mechanicalKeyEventRcv(int fds, String keyFilePath) {
    MkeyRet ret = MkeyRet();

    if (!isWithoutDevice()) {
      final Pointer<Utf8> pathPointer = keyFilePath.toNativeUtf8();
      Pointer<Int> fdsPointer = malloc.allocate<Int>(4);
      try {
        fdsPointer.value = fds;

        //外部関数（インターフェース）
        final int Function(Pointer<Int> fds, Pointer<Utf8> filePath) interface =
            mkeyDylib
                .lookup<
                    NativeFunction<
                        Int16 Function(Pointer<Int>,
                            Pointer<Utf8>)>>("MechanicalKeyEventRcv")
                .asFunction();

        //APIコール
        ret.result = interface(fdsPointer, pathPointer);
        if (testKey != 0) {
          ret.result = testKey;
          testKey = 0;
        }
        ret.fds = fdsPointer.value;
      } catch (e) {
        ret.result = -1; // 異常終了
      } finally {
        calloc.free(pathPointer);
        calloc.free(fdsPointer);
      }
    } else {
      // 確認したいキーコードをkeyCodeにセットして、実行（リロード）して下さい。
      // キー入力の間隔はintervalで調整できます。
      // また、アイソレート通信でtestKeyをアプリ側から送信可能としました。
      // 　⇒IfDrvControl().mkeyIsolateCtrl.keyCodeLoopbackIn(keycode);
      int keyCode = 0x00; // 97(0x61):小計、28(0x1C):現計
      final interval = 3; // (sec)
      if (testKey != 0) {
        ret.result = testKey;
        testKey = 0;
      } else {
        DateTime dt = DateTime.now();
        final dt0 = DateTime.parse(preDt);
        if (dt.difference(dt0).inSeconds > interval) {
          ret.result = keyCode;
        } else {
          ret.result = 0;
          return ret;
        }
        preDt = dt.toString();
      }
      ret.fds = fds;
      if (ret.result != 0) {
        debugPrint("メカキー キー入力：0x" +
            ret.result.toRadixString(16).padLeft(2, '0') +
            " -- interface() WITHOUT_DEVICE実行");
      }
    }

    return ret;
  }
}
