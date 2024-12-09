/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import '../../if/if_drv_control.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../ffi/windows/winffi_printer.dart';
import 'drv_print_base.dart';

enum CoverStat {
  open,
  close,
  none;

  static CoverStat getDefine(int index) {
    CoverStat state = CoverStat.values.firstWhere((element) {
      return element.index == index;
    }, orElse: () => CoverStat.none);
    return state;
  }
}

enum PaperStat {
  empty,
  exist,
  none;

  static PaperStat getDefine(int index) {
    PaperStat state = PaperStat.values.firstWhere((element) {
      return element.index == index;
    }, orElse: () => PaperStat.none);
    return state;
  }
}

class WinDrvPrint {
  var ffiPtr = WinFFIPrinter();
  List<TprMsg_t> tprMsgList = List<TprMsg_t>.filled(0, TprMsg(), growable: true);

  // レシートロゴ
  String logoPath = "assets\\images\\receipt.bmp";

  // レシートレイアウト
  String textData = '''
-------------------------------
2023年 1月12日(木曜日)    14時32分
-------------------------------
レシートNo:0142
合計 \\574
お預り  \\600
お釣り  \\28
''';

  // 固定でCODE128出力（仮）
  String bcData = "4902720005074";

  /// プリンタステート
  bool isOpened = false;
  WinDrvPrint();

  /// プリンタイベントをオープンする関数
  @override
  bool printOpen() {
    final Pointer<Utf8> charPointer =
    "lib\\app\\drv\\lib\\Windows\\dist\\Win32\\Release\\PtrRcv.exe"
        .toNativeUtf8();
    int isSuccess = ffiPtr.openPtrEvent(charPointer);
    calloc.free(charPointer);
    if (isSuccess != 0) {
      TprLog().logAdd(
          0, LogLevelDefine.normal, "Windows printer port open failed.");
      isOpened = false;
      return false;
    }
    TprLog()
        .logAdd(0, LogLevelDefine.normal, "Windows printer port open success.");
    isOpened = true;
    return true;
  }

  /// イベント受付スレッド
  /// 正しくレシートがセットされるまでループして待機するときは[isWaitSetting]がtrue.一回だけチェックして抜ける場合はfalse.
  @override
  Future<void> startPrinter({bool isWaitSetting = true,SendPort? notifySendPort}) async {
    bool sendInformation = false; // アプリ側に情報を送ったかどうか.

    /// コマンド送信(問合せ)後、イベントを受け取る
    // 監視ループ
    while (isOpened) {
      ffiPtr.inqStatCover(); // プリンタカバー開閉状態問合せ
      ffiPtr.inqStatPaper(); // レシート用紙有無状態問合せ
      if (0 < ffiPtr.getPtrCntRef()) {
        int coverStatIdx = ffiPtr.getStatCover(); // プリンタカバー開閉状態取得
        int paperStatIdx = ffiPtr.getStatPaper(); // レシート用紙有無状態取得
        TprLog().logAdd(0, LogLevelDefine.normal,
            "Windows printer input cover: $coverStatIdx paper:$paperStatIdx");

        CoverStat coverStat = CoverStat.getDefine(coverStatIdx);
        PaperStat paperStat = PaperStat.getDefine(paperStatIdx);

        // イベントリセット
        ffiPtr.releasePtr();

        // カバー閉・レシート有りの場合（デバッグ用: 5回転59.8%の確率でbreak）⇒ ソケット通信でラグがあるのでもっと低い。I/F経由なので1%くらい？
        if (coverStat == CoverStat.close && paperStat == PaperStat.exist) {
          // メインアプリにレシート出力が可能であることを通知
          break;
        } else if (!sendInformation && notifySendPort != null) {
          sendInformation = true;
          notifySendPort.send(NotifyFromSIsolate(
              NotifyTypeFromSIsolate.receiptSettingError, ""));
          TprLog().logAdd(0, LogLevelDefine.normal,
              "Windows print open error.CoverStat: ${coverStat.name}/ PaperStat:${paperStat.name}");
          if (!isWaitSetting) {
            break;
          }
        }
      }
      await Future.delayed(const Duration(milliseconds: 5));
    }
  }

  /// レシートロゴを登録する関数
  @override
  bool logoRegister(int index, String logo) {
    // レシート出力前にロゴをOPOSに登録
    final Pointer<Utf8> logoPointer = logoPath.toNativeUtf8();
    int res = ffiPtr.regLogo(logoPointer);
    calloc.free(logoPointer);
    if (res == 0) {
      return true;
    }

    return false;
  }

  /// レシートを出力する関数
  @override
  bool receiptOutput(String text, String barcode, String message) {
    final Pointer<Utf16> textPointer = text.toNativeUtf16();
    final Pointer<Utf16> barcodePointer = barcode.toNativeUtf16();
    int res = ffiPtr.outRec(textPointer, barcodePointer);
    calloc.free(textPointer);
    calloc.free(barcodePointer);
    if (res == 0) {
      return true;
    }

    return false;
  }

  /// プリンタイベントをクローズする関数
  @override
  void printClose() {
    // 受信ストップ（プロセス停止）
    int res = ffiPtr.closePtrEvent();
    debugPrint("closePtr : $res");
    isOpened = false;
  }
}
