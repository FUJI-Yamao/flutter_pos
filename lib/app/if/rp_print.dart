/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../postgres_library/src/pos_log_table_access.dart';
import '../inc/sys/tpr_type.dart';
import '../common/date_util.dart';
import 'barcode_print.dart';

/// 関連tprxソース:rp_print.c
class RegsPrint {
  static const printStr = 30; // string1 Area
  static const maxBufLine = 40; // 一回で印字する最大行数
  static const vfFont1 = 24; // 全角文字ドット数
  static const MAX_BUF_LINE = 40; // 一回で印字する最大行数
  static const MAX_Y_DOT = MAX_BUF_LINE * printStr; // string1 Area

  static const fd_8_16_e = 0;
  static const fd16_16_e = 0;
  static const fd12_24_e = 0;
  static const fd24_24_e = 0;
  static const fd12_48_e = 0;
  static const fd24_48_e = 0;
  static const fd48_48_e = 0;
  static const fd16_16_j = 0;
  static const fd32_16_j = 0;
  static const fd24_24_j = 0;
  static const fd48_24_j = 0;
  static const fd24_48_j = 0;
  static const fd48_48_j = 0;
  static const fd48_48_j2 = 0;
  static const fd48_48_j3 = 0;

  // プリントしたライン.
  int printLine = 0;
  final TprMID _tid;
  RegsPrint(this._tid);

  int rpPrintLogo(int logNo) {
    // if_th_LogoPrint(_tid, int logNo)

    debugPrint("ロゴNo:${logNo.toString()}");
    return 0;
  }

  int rpPrintHeaderLine(String printStr) {
    // 特定の文字列をレシートに表示する.
    int iAFontId = fd12_24_e;
    int iKFontId = fd24_24_j;
    //if_th_PrintString(
    //    LogTprMidDefine.prn, 0, 24, wAttr, iAFontId, iKFontId, printStr);
    debugPrint(printStr);
    return 0;
  }

  String getBarLineCode(CEjLogColumns printData) {
    String code = "";
    // 電子ジャーナルのデータから取得できる情報を26桁の文字列に直す.
    {
      code = "00"; // 2文字.後で管理バーコードへ置き換え.
      code += DateFormat('yyyyMMdd')
          .format(DateFormat(DateUtil.formatDate).parse(printData.sale_date!))
          .substring(2); // 6文字. 年の100の位以上はカット.
      code += printData.receipt_no.toString().padLeft(4, '0');
      code += "000"; // 3文字.
      code += printData.mac_no.toString().padLeft(6, '0');
      code += printData.print_no.toString().padLeft(4, '0');
      code += '0'; // 26文字目.後でチェックデジットへ置き換え.
    }

    // cm_mk_rcpt_bar 最初の2文字を取引レシート管理バーコードのフラグ2桁で置き換える.
    //MEMO:仮に12
    code = code.replaceRange(0, 2, "12");
    // cm_cdigit_variable 最後の0をチェックdegitで置き換える.
    code = code.replaceRange(25, null, getCheckDigitStr(code, 26));
    return code;
  }

  /// 関連tprxソース:rp_Print_BarLine
  int rpPrintBarLine(CEjLogColumns printData) {
    String code = getBarLineCode(printData);
    //最後に

    // bufferのチェック.
    // if (printLine + 4 >= maxBufLine) {
    //   // bufferをリフレッシュ.
    // }
    // printLine += 4;
    //int posY = (printLine - 5) * printStr + vfFont1;

    int barcodeLine = 4;
    printLine += barcodeLine; // バーコード分のラインを確保.
    int posY = (printLine - barcodeLine) * printStr + vfFont1;
    // AplLib_BarCodePrn2 -> barcode128c
    // バーコードの印字処理.
    BarcodePrint.barcode128c(_tid, 0, posY, code);

    // バーコードの数字の表示をするなら表示.
    // if( print == 1 )
    // {
    //   rp_Print_Line( BI.Code );
    // }

    return 0;
  }

  /// チェックdegitを計算する.
  ///
  /// 関連tprxソース:cm_cdigit_variable
  String getCheckDigitStr(String str, int length) {
    //MEMO: 数値だけならもっと簡単に書けると思うが、英字が入ってくることはあるんだろうか...

    int total = 0;
    int p = 0;

    bool isStart = length % 2 == 0;
    for (int i = length ~/ 2; i > 0; i--) {
      if (isStart) {
        total += (str.codeUnitAt(p) - '0'.codeUnitAt(0)) * 1;
        p++;
      }

      total += (str.codeUnitAt(p) - '0'.codeUnitAt(0)) * 3;
      p++;
      isStart = true;
    }
    int cd = total % 10;
    if (cd != 0) {
      cd = 10 - cd;
    }

    return String.fromCharCode(cd + '0'.codeUnitAt(0));
  }

  /// 関連tprxソース:rp_nsw_format.c rp_Nsw_FmtFontsize();
  static String getNswFormat(int horizon, int vertical,
      {int nowFontSize = 0x00}) {
    horizon = max(0, min(8, horizon));
    vertical = max(0, min(8, vertical));

    /* コマンドは0x00～0x07で指定する */
    horizon--;
    vertical--;
    /* フォントサイズ変数の更新 */
    int fontSize = nowFontSize;
    if (horizon >= 0) {
      // horizonは上位4ビット.一旦0にリセットして入れる.
      fontSize &= 0x0F;
      fontSize |= (horizon << 4);
    }
    if (vertical >= 0) {
      // horizonは下位4ビット.一旦0にリセットして入れる
      fontSize &= 0xF0;
      fontSize |= vertical;
    }
    List<int> charset = [0x1d, 0x21, fontSize];
    return String.fromCharCodes(charset);
  }
}
