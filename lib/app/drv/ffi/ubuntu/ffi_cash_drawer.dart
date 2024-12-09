/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:ffi/ffi.dart';

import '../../drw/tprdrv_drw.dart';
import '../ffi_access_test.dart';
import '../library.dart';
import '../../../inc/apl/rxmem_define.dart';

class FFICashDrawer {

  // WITHOUT_DEVICE=ture時のデバッグ用条件
  int drwStat  = 0x00;
  int drwStat2 = 0x00;

  /// ドロア―　ポートオープン
  ///
  /// 引数:[filePath] ファイルディスクリプタのパス
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 異常終了
  int drwPortOpen(Pointer<Utf8> filePath, Pointer<Int> fds) {
    //外部関数（インターフェース）
    late int ret;
    if (!isWithoutDevice() && !isWithoutDrawer()) {
      final int Function(
          Pointer<Utf8> pathName,
          Pointer<Int>
              fds) interface = drwDylib
          .lookup<NativeFunction<Int16 Function(Pointer<Utf8>, Pointer<Int>)>>(
              "DrwPortOpen")
          .asFunction();

      //APIコール
      ret = interface(filePath, fds);
    } else {
      debugPrint("ドロア ポートオープン " +
          "FFICashDrawer.drwPortOpen() -- interface() WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret;
  }

  /// ドロア―　ポートクローズ
  ///
  /// 引数:[fds]　ファイルディスクリプタの番号
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 異常終了
  int drwPortClose(int fds) {
    //外部関数（インターフェース）
    late int ret;
    if (!isWithoutDevice() && !isWithoutDrawer()) {
      final int Function(int fds) interface = drwDylib
          .lookup<NativeFunction<Int16 Function(Int)>>("DrwPortClose")
          .asFunction();

      //APIコール
      ret = interface(fds);
    } else {
      debugPrint("ドロア ポートクローズ　" +
          "FFICashDrawer.drwPortClose() -- interface() WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret;
  }

  /// ドロア―　開コマンド
  ///
  /// 引数：[fds]　ファイルディスクリプタの番号
  ///
  /// 戻り値： 0 : 正常終了
  ///
  ///       -1 : 異常終了
  int drwOpenCmd(int fds) {
    //外部関数（インターフェース）
    late int ret;
    if (!isWithoutDevice() && !isWithoutDrawer()) {
      final int Function(int fds) interface = drwDylib
          .lookup<NativeFunction<Int16 Function(Int)>>("DrwOpenCmd")
          .asFunction();

      //APIコール
      ret = interface(fds);
    } else {
      drwStat = 0x20;
      debugPrint("ドロア 開指令 " +
          "FFICashDrawer.drwOpenCmd() -- interface() WITHOUT_DEVICE実行");
      ret = 0; // 正常終了
    }

    return ret;
  }

  /// ドロア―　閉コマンド
  ///
  /// 引数：なし
  ///
  /// 戻り値：なし
  ///
  /// ※WITHOUT_DEVICE=trueで実行時用のコマンド。ドロア閉状態を作る。
  void drwCloseCmd() {
    if (!isWithoutDevice() && !isWithoutDrawer()) {
      // 実機では手操作でドロアを閉じる。自動で閉じたりはしない。
    } else {
      drwStat = 0x00;
      debugPrint("ドロア 閉指令 " +
          "FFICashDrawer.drwCloseCmd() -- interface() WITHOUT_DEVICE実行");
    }
  }

  /// ドロア―　ステータス取得
  ///
  /// 引数:[status1]　ドロア1のアプリ側認識開閉状態
  ///
  /// 　　 [status2]　ドロア2のアプリ側認識開閉状態
  ///
  /// 戻り値： RxTaskStatDrw
  ///
  /// 　　　　　result = 0 : 正常終了、 -1 : 異常終了
  ///
  ///         drwStat  : ドロア1の開閉状態（0x00:閉、0x20:開）
  ///
  ///         drwStat2 : ドロア2の開閉状態（0x00:閉、0x20:開）
  RxTaskStatDrw drwStatusCheck(int status1, int status2) {
    //外部関数（インターフェース）
    RxTaskStatDrw ret = RxTaskStatDrw();
    if (!isWithoutDevice() && !isWithoutDrawer()) {
      Pointer<Int8> newstatus1 = malloc.allocate<Int8>(1);
      Pointer<Int8> newstatus2 = malloc.allocate<Int8>(1);
      try {
        final int Function(int status1, int status2, Pointer<Int8> newstatus1,
                Pointer<Int8> newstatus2) interface =
            drwDylib
                .lookup<
                    NativeFunction<
                        Int16 Function(Int, Int, Pointer<Int8>,
                            Pointer<Int8>)>>("DrwStatusCheck")
                .asFunction();

        //APIコール
        newstatus1.value = 0;
        newstatus2.value = 0;
        ret.result = interface(status1, status2, newstatus1, newstatus2);
        ret.drwStat = newstatus1.value;
        ret.drwStat2 = newstatus2.value;
      } catch (e) {
        // DRW_STAT,DRW_STAT2の更新が主な目的のため、例外発生時は更新せずに続行する
      } finally {
        calloc.free(newstatus1);
        calloc.free(newstatus2);
      }
    } else {
      // debugPrint("ドロア ステータス取得:" + drwStat.toString() +
      //     " FFICashDrawer.drwStatusCheck() -- interface() WITHOUT_DEVICE実行");
      ret.result = TprDrvDrw.DRW_OK_I;
      ret.drwStat = drwStat;
      ret.drwStat2 = drwStat2;
    }

    return ret;
  }
}
