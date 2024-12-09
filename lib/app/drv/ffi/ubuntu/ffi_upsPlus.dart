import 'package:ffi/ffi.dart';
import 'dart:ffi';
import 'dart:ffi' as ffi;
import '../library.dart';

class FFIUpsPlus {
  /// デバイスオープン
  /// 引数:なし
  /// 戻り値： 0 : 正常終了／ -1 : 異常終了
  int upsPlusOpen() {
      int ret = -1;
      try {
        // 外部関数（インターフェース）
        final int Function() interface = upsPlusDylib
            .lookup<NativeFunction<Int16 Function()>>('UpsPlusOpen')
            .asFunction();

        // APIコール
        ret = interface();
      } catch (e) {
        ret = -1; // 異常終了
      } finally {
      }
      return ret;   // 0：成功, -1：失敗
  }

  /// デバイスクローズ
  /// 引数:なし
  /// 戻り値： 0 : 正常終了／ -1 : 異常終了
  int upsPlusClose() {
      int ret = -1;
      try {
        // 外部関数（インターフェース）
        final int Function() interface = upsPlusDylib
            .lookup<NativeFunction<Int16 Function()>>('UpsPlusClose')
            .asFunction();

        // APIコール
        ret = interface();
      } catch (e) {
        ret = -1; // 異常終了
      } finally {
      }
      return ret;   // 0：成功, -1：失敗
  }

  /// shutdownコマンド要求
  /// 引数:[mode] 0:reboot / 0以外:halt
  /// 戻り値： 0 : 正常終了／ -1 : 異常終了
  int upsPlusShutdown(int mode) {
    // 外部関数（インターフェース）
    final int Function(int mode) interface = upsPlusDylib
        .lookup<NativeFunction<Int16 Function(Int16)>>('UpsPlusShutdown')
        .asFunction();

    // APIコール
    int ret = interface(mode);

    return ret;   // 0：成功, -1：失敗
  }

}
