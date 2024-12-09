/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';

import '../inc/sys/tpr_log.dart';
import '../inc/sys/tpr_type.dart';

/// バーコードを印字するためのクラス.
/// 関連tprxソース:AplLib_BarPrn.c
class BarcodePrint {
  static const int siz128 = 26;

  static const int x128W = 2;
  static const int y128H = 60;

  static const int startC = 105;
  static const int stop128 = 106;

  static const codeSet = [
    "212222",
    "222122",
    "222221",
    "121223",
    "121322",
    /*  0 -  4 */
    "131222",
    "122213",
    "122312",
    "132212",
    "221213",
    "221312",
    "231212",
    "112232",
    "122132",
    "122231",
    /* 10 - 14 */
    "113222",
    "123122",
    "123221",
    "223211",
    "221132",
    "221231",
    "213212",
    "223112",
    "312131",
    "311222",
    /* 20 - 24 */
    "321122",
    "321221",
    "312212",
    "322112",
    "322211",
    "212123",
    "212321",
    "232121",
    "111323",
    "131123",
    /* 30 - 34 */
    "131321",
    "112313",
    "132113",
    "132311",
    "211313",
    "231113",
    "231311",
    "112133",
    "112331",
    "132131",
    /* 40 - 44 */
    "113123",
    "113321",
    "133121",
    "313121",
    "211331",
    "231131",
    "213113",
    "213311",
    "213131",
    "311123",
    /* 50 - 54 */
    "311321",
    "331121",
    "312113",
    "312311",
    "332111",
    "314111",
    "221411",
    "431111",
    "111224",
    "111422",
    /* 60 - 64 */
    "121124",
    "121421",
    "141122",
    "141221",
    "112214",
    "112412",
    "122114",
    "122411",
    "142112",
    "142211",
    /* 70 - 74 */
    "241211",
    "221114",
    "413111",
    "241112",
    "134111",
    "111242",
    "121142",
    "121241",
    "114212",
    "124112",
    /* 80 - 84 */
    "124211",
    "411212",
    "421112",
    "421211",
    "212141",
    "214121",
    "412121",
    "111143",
    "111341",
    "131141",
    /* 90 - 94 */
    "114113",
    "114311",
    "411113",
    "411311",
    "113141",
    "114131",
    "311141",
    "411131",
    "b1a4a2",
    "b1a2a4",
    /* 100 - 104 */
    "b1a2c2",
    "b3c1a1b"
  ];

  static int barcode128c(
      TprMID tid, int wXpos, int wYpos, String createBarcodeNumStr) {
    String barcodeSet = codeSet[startC];
    int checkSum = startC;
    int startX = wXpos;
    debugPrint(createBarcodeNumStr);
    int j = 1;
    for (int i = 0; i < siz128; i += 2) {
      String codeStr = createBarcodeNumStr.substring(i, i + 2);
      int code = int.parse(codeStr);
      checkSum += code * j;
      barcodeSet += codeSet[code];
      j++;
    }

    barcodeSet += codeSet[(checkSum % 103)];
    barcodeSet += codeSet[stop128];

    // trueの時ラインを書き、falseの時はスペースを空ける.
    bool isWriteLine = true;

    // バーコード上部に置く横ラインの縦の長さ.
    int upperLineHeight = x128W * 2;
    // バーコードのyの始まり位置.上部のラインの縦の長さを考慮.
    int barcodePosY = wYpos + upperLineHeight + 10;

    // barcideSetに沿って印字する. 例:212222 なら2bit黒、1bit白 2bit黒
    for (int i = 0; i < (6 + ((siz128 / 2) * 6) + 6 + 7); i++) {
      String one = barcodeSet[i];
      int hexCode =
          one.codeUnitAt(0) - '0'.codeUnitAt(0); // 1だったら1,aだったらa空0までの文字コード差分.

      if (((hexCode + 48) >= 65) && ((hexCode + 48) <= 70)) {
        hexCode -= (65 - 48 - 1); //A~F -> 1~6
      } else if (((hexCode + 48) >= 97) && ((hexCode + 48) <= 102)) {
        hexCode -= (97 - 48 - 1); //a~f -> 1~6
      }
      if (!((hexCode >= 1) && (hexCode <= 4))) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "BarCode128C() error!! -> i[$i]hex_code[$hexCode][$hexCode]wXpos[$wXpos]",
            errId: -1);
        // TODO:00001 日向 returnコード.IF_TH_PERPARAM 定義待ち?
        return (4);
      }

      int lineWidth = x128W * hexCode;
      if (isWriteLine) {
        for (int i = 0; i < lineWidth; i++) {
          debugPrint("■■■■■■■■■■■■");
        }

        // ラインを印字する.
        // MEMO:後でデバドラのif_thと組み合わせ.
        // int result =
        //     if_th_PrintLine(tid, wXpos, barcodePosY, 0, lineWidth, y128H, 0);
        // if (result != IF_TH_POK) {
        //   // 失敗した.
        //   TprLog().logAdd(LogTprMidDefine.none, LogLevelDefine.error,
        //       "BarCode128C() if_th_PrintLine error!!",
        //       errId: -1);
        //   return result;
        // }
      } else {
        for (int i = 0; i < lineWidth; i++) {
          debugPrint("□□□□□□□□□□□□");
        }
      }

      wXpos += lineWidth;
      isWriteLine = !isWriteLine;
    }
    // MEMO:後でデバドラのif_thと組み合わせ.
    // バーコードの上にバーコードと同じ長さの横ラインを引く.
    // int result =
    //     if_th_PrintLine(tid, startX, wYpos, 0, wXpos, upperLineHeight, 0);
    // if (result != IF_TH_POK) {
    //   TprLog().logAdd(LogTprMidDefine.none, LogLevelDefine.error,
    //       "BarCode128C() if_th_PrintLine error!!",
    //       errId: -1);
    //   return result;
    // }

    return 0;
  }
}
