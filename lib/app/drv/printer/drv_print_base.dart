/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';

/// プリンタの操作クラスのベース.
abstract class DrvPrintBase {
  /// プリンタイベントをオープンする関数
  bool printOpen();
  Future<void> startPrinter({bool isWaitSetting = true,SendPort? notifySendPort});

  /// レシートロゴを登録する関数
  bool logoRegister(int index, String logo);

  /// レシートを出力する関数
  bool receiptOutput(String text, String barcode, String message);

  /// プリンタイベントをクローズする関数
  void printClose();
}
