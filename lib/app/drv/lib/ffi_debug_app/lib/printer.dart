/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:io' show Platform;

import 'ffi/windows/winffi_printer.dart';

String ptrTest(String strPut) {
  strPut += ">>> Printer\n";

  // レシートロゴ
  String logoPath = "assets\\images\\receipt.bmp";

  // レシートレイアウト
  String textData =
'''\x1b|400uF\x1b|N  店No.000000001      ﾚｼﾞNo:000001
\x1b|N  2023年 1月12日(木曜日)  14時32分
\x1b|N  000999999寺岡        ﾚｼｰﾄNo:0001
\x1b|400uF\x1b|N   綾鷹                       \\131
\x1b|N   ほうじ茶                   \\128
\x1b|N  --------------------------------
\x1b|N   小計                       \\259
\x1b|N   お買上点数                  2点
\x1b|N  --------------------------------
\x1b|N\x1b|bC\x1b|2C 合計        \\259
\x1b|N\x1b|bC  現計                        \\259
\x1b|N  お預り                      \\300
\x1b|N  お釣り                       \\41
\x1b|600uF''';

  // MEMO: 参照既存ソース
  // rp_print.c > rp_Print_BarLine
  // ⇒ 26桁のバーコードを作成
  // jan_inf.h > Code128_inf > Org_Code
  // ⇒ ASC EAN26をセット（Original 2 barcode = ASC EAN13 * 2）
  // 固定でCODE128(CODE-Cタイプ)出力（仮）
  String bcData = "12220113000100000000100017";

  if (Platform.isMacOS) {
    // something...
  }
  else if (Platform.isWindows) {
    var ffiPtr = WinFFIPrinter();
    int res = -1;

    // イベント受付開始
    res = ffiPtr.openPtrEvent(
        "..\\Windows\\dist\\Win32\\Release\\PtrRcv.exe".toNativeUtf8());
    debugPrint("openPtrEvent: $res");
    strPut += "openPtrEvent: $res\n";

    debugPrint("Incomming...");

    bool isCoverOpen = false;
    bool isPaperEmpty = false;
    while (true) {
      ffiPtr.inqStatCover();  // プリンタカバー開閉状態問合せ
      ffiPtr.inqStatPaper();  // レシート用紙有無状態問合せ
      if (0 < ffiPtr.getPtrCntRef()) {  // プリンタイベント受信
        int coverStat = ffiPtr.getStatCover();   // プリンタカバー開閉状態取得
        int paperStat = ffiPtr.getStatPaper();   // レシート用紙有無状態取得
        //debugPrint("coverStat: $coverStat");
        //debugPrint("paperStat: $paperStat");
        //strPut += "coverStat: $coverStat\n";
        //strPut += "paperStat: $paperStat\n";

        switch (coverStat) {
          case 1:   // カバー閉の場合
            isCoverOpen = false;
            break;
          case 0:   // カバー開の場合
            // エラー画面表示
          default:  // -1
            isCoverOpen = true;
            break;
        }

        switch (paperStat) {
          case 1:   // レシート用紙有りの場合
            isPaperEmpty = false;
            break;
          case 0:   // レシート用紙無しの場合
            // エラー画面表示
          default:  // -1
            isPaperEmpty = true;
            break;
        }

        ffiPtr.releasePtr();

        // カバー閉・レシート有りの場合（デバッグ用: 5回転59.8%の確率でbreak）⇒ ソケット通信でラグがあるのでもっと低い。I/F経由なので1%くらい？
        if (!isCoverOpen && !isPaperEmpty) {
          break;
        }
      }
    }

    // レシートロゴ登録（PtrRcv.exeが起動中はいつでも登録可）← 登録してからレシート出力
    res = ffiPtr.regLogo(logoPath.toNativeUtf8());
    debugPrint("regLogo: $res");
    strPut += "regLogo: $res\n";

    // レシート出力
    res = ffiPtr.outRec(textData.toNativeUtf16(), bcData.toNativeUtf16());
    debugPrint("outRec: $res");
    strPut += "outRec: $res\n";

    // イベント受付終了
    res = ffiPtr.closePtrEvent();
    debugPrint("closePtrEvent: $res");
    strPut += "closePtrEvent: $res\n";
  }
  else if (Platform.isLinux) {
    // something...
  }
  else if (Platform.isAndroid) {
    // something...
  }
  else {
    // something...
  }

  return strPut;
}