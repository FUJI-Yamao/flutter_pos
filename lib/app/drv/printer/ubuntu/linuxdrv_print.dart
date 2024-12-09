/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';

import '../../../inc/sys/tpr_log.dart';
import '../../ffi/ubuntu/ffi_printer.dart';
import '../drv_print_base.dart';

class LinuxDrvPrint {
  var ffiPtr = FFIPrinter();
  // レシートロゴ
  String logoPath = "";
  static const String bmpPath = "/pj/tprx/bmp/";

  /// プリンタイベントをオープンする関数
  @override
  bool printOpen() {
    const String path = "/dev/usb/tprtss";
    PrintRet isSuccess = ffiPtr.printerOpenDevice(path);
    if (isSuccess.result != 0) {
      TprLog().logAdd(0, LogLevelDefine.error, "Linux printer port open failed.");
      return false;
    }
    TprLog().logAdd(0, LogLevelDefine.normal, "Linux printer port open success.");
    return true;
  }

  @override
  Future<void> startPrinter({bool isWaitSetting = true,SendPort? notifySendPort}) async {}

  /// レシートロゴを登録する関数
  @override
  bool logoRegister(int index, String logoPath) {
    if((index == 0) || (logoPath == "")) {
      return false;
    }
    //　ロゴプリンタ.
    //”/pj/tprx/bmp/receipt.bmp”
    PrintRet isSuccess = ffiPtr.printerLogoWrite(index, logoPath);
    if (isSuccess.result == 0) {
      return true;
    }

    return false;
  }

  /// レシートを出力する関数
  @override
  bool receiptOutput(String text, String barcode, String message) {
    //PrintRet isSuccess = ffiPtr.printerWriteDevice(text, barcode, message);
    PrintRet isSuccess = PrintRet();
    isSuccess.result = 0;
    if (isSuccess.result == 0) {
      return true;
    }

    return false;
  }

  /// プリンタイベントをクローズする関数
  @override
  void printClose() {
    // 受信ストップ（プロセス停止）
    ffiPtr.printerCloseDevice();
  }
}
