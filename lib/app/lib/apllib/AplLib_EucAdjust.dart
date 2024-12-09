/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:AplLib_EucAdjust.c
//  このファイルは上記ヘッダーファイルを元にdart化したものです。


import '../../inc/lib/apllib.dart';

class AplLibEucAdjust {

  /// 関連tprxソース:AplLib_EucAdjust.c - AplLib_EucCnt()
  static Future<int> aplLibEucCnt(String pEucChar) async {
    List<String> p = pEucChar.split("");
    int i = 0, cnt = 0;

    for (i = 0; i < pEucChar.length; ) {
      if (p[i] == "\x8e") {
        cnt ++;
        i += 2;
      } else if (p[i] == "\x8f") {
        cnt += 2;
        i += 3;
      } else if ((p[i].codeUnitAt(0) >= 0x20) &&
                 (p[i].codeUnitAt(0) <= 0x7e)) {
        cnt ++;
        i ++;
      } else {
        cnt += 2;
        i += 2;
      }
    }
    return cnt;
  }


  /// 関連tprxソース:AplLib_EucAdjust.c - AplLib_EucAdjust()
  static Future<EucAdj> aplLibEucAdjust(String pEucChar, int EucSize,int Cnt) async {
    List<String> p = pEucChar.split("");
    EucAdj adj = EucAdj();
    int cp_byte = 0;
    int count = 0;

    for (cp_byte = 0; (cp_byte < EucSize) && (count < Cnt); ) {
      if (p[cp_byte] == "\x8e") { /* euc_kana ? */
        if (p[cp_byte + 1] == "\"x00") {
          break;
        }
        count ++;
        cp_byte += 2;
      } else if (p[cp_byte] == "\"x8f") {
        if ((p[cp_byte + 1] == "\"x00") || (p[cp_byte + 2] == "\"x00")) {
          break;
        }
        if (((cp_byte + 2) < EucSize) && ((count + 1) < Cnt)) {
          cp_byte += 3;
          count += 2;
        } else {
          break;
        }
      } else if ((p[cp_byte].codeUnitAt(0) >= 0x20) && (p[cp_byte].codeUnitAt(0) <= 0x7e)) { /* ascii ? */
        count ++;
        cp_byte ++;
      } else { /* normal kanji ? */
        if (p[cp_byte + 1] == "\x00") {
          break;
        }
        if (((cp_byte + 1) < EucSize) && ((count + 1) < Cnt)) {
          cp_byte += 2;
          count += 2;
        } else {
          break;
        }
      }
    }
    p[cp_byte] = "\x00";
    adj.byte = cp_byte;
    adj.count = count;
    return (adj);
  }

  /// 関連tprxソース:AplLib_EucAdjust.c - AplLib_EucAdjust()
  static Future<EucAdj> aplLibEucAdjustSize(String pEucChar, int EucSize, int Size) async {
    List<String> p = pEucChar.split("");
    EucAdj adj = EucAdj();
    int cp_byte = 0;
    int count = 0;

    for(cp_byte = 0; (cp_byte < EucSize) && (cp_byte < Size);) {
      if (p[cp_byte] == "\x8e") { /* euc_kana ? */
        if (p[cp_byte+1] == "\x00") {
          break;
        }
        if (((cp_byte + 1) < EucSize) && ((cp_byte + 1) < Size)) {
          count ++;
          cp_byte += 2;
        } else {
          break;
        }
      }
      if (p[cp_byte] == "\x8f") {
        if ((p[cp_byte + 1] == "\x00") || (p[cp_byte + 2] == "\x00")) {
          break;
        }
        if (((cp_byte + 2) < EucSize) && ((cp_byte + 2) < Size)) {
          cp_byte += 3;
          count += 2;
        } else {
          break;
        }
      } else if ((p[cp_byte].codeUnitAt(0) >= 0x20) && (p[cp_byte].codeUnitAt(0) <= 0x7e)) { /* ascii ? */
        count ++;
        cp_byte ++;
      } else { /* normal kanji ? */
        if (p[cp_byte + 1] == "\x00") {
          break;
        }
        if (((cp_byte + 1) < EucSize) && ((cp_byte + 1) < Size)) {
          cp_byte += 2;
          count += 2;
        } else {
          break;
        }
      }
    }
    p[cp_byte] = "\x00";
    adj.byte = cp_byte;
    adj.count = count;
    return (adj);
  }

  /// 関連tprxソース:AplLib_EucAdjust.c - AplLib_EucByteAdj()
  static Future<int> aplLibEucByteAdj(String pEucChar, int count) async {
    int i = 0, cnt = 0;

    if (count == 0) {
      return 0;
    }
    List<String> p = pEucChar.split("");
    for (i = 0; i < pEucChar.length; ) {
      if (p[i] == "\x8f") {
        cnt++;
        i+=3;
      } else if ((p[i].codeUnitAt(0) >= 0x20) && (p[i].codeUnitAt(0) <= 0x7e)) {
        cnt++;
        i++;
      } else {
        cnt++;
        i+=2;
      }
      if (cnt == count) {
        return( i );
      }
    }
    return cnt;
  }

  /// 関連tprxソース:AplLib_EucAdjust.c - AplLib_EucCntAdj()
  static Future<int> aplLibEucCntAdj(String pEucChar, int count) async  {
    int i = 0, cnt = 0, cnt1 = 0;

    if (count == 0) {
      return 0;
    }
    List<String>p = pEucChar.split("");
    for(i = 0; i < pEucChar.length; ) {
      if (p[i] == "\x8e") {
        cnt++;
        cnt1++;
        i+=2;
      } else if (p[i] == "\x8f") {
        cnt+=2;
        cnt1++;
        i+=3;
      } else if ((p[i].codeUnitAt(0) >= 0x20) && (p[i].codeUnitAt(0) <= 0x7e)) {
        cnt1++;
        cnt++;
        i++;
      } else {
        cnt1++;
        cnt+=2;
        i+=2;
      }
      if (cnt1 == count) {
        return( cnt );
      }
    }
    return -1;
 }

/// 関連tprxソース:AplLib_EucAdjust.c - main()
// 元コードで無効にされている。念のためdart化して残しておく。
// #if 0
// static Future<int> mainA(int argc, String argv) async {
//   String euc = "";
//   EucAdj len = EucAdj();
//   int size = 0;
//
//   len.byte = 0;
//   len.count = 0;
//   euc = "あいうえお";
//   len = await aplLibEucAdjust(euc, euc.length, 7);
//
//   print("あいう:[${euc}] len:${len.byte},${len.count}\n");
//
//   euc = "aあいうえお";
//   len = await aplLibEucAdjust(euc, euc.length, 8);
//   print("aあいう:[${euc}] len:${len.byte},${len.count}\n");
//
//   euc = "aｱｲｳあいう";
//   len = await aplLibEucAdjust(euc, euc.length, 8);
//   print("[${euc}]:[${len.byte}][${len.count}]\n");
//
//   euc = "あいうえお";
//   len = await aplLibEucAdjustSize(euc,euc. length, 9);
//   print("1:[${euc}] len:${len.byte},${len.count}\n");
//
//   euc = "aあいうえお";
//   len = await aplLibEucAdjustSize(euc, euc.length, 10);
//   print("2:[${euc}] len:${len.byte},${len.count}\n");
//
//   euc = "aあいうえお";
//   len = await aplLibEucAdjustSize(euc, euc.length, 8);
//   print("3:[${euc}] len:${len.byte},${len.count}\n");
//
//   euc = "ｱｲｳ ｱｲｳ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc, size, 8);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc ="ｱｲｳ ｱｲｳ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc, size, 9);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = "ｱｲｳ ｱｲｳ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc, size, 10);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = "ｱｲｳ ｱｲｳ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc, size, 11);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//
//   euc = "あ ｱ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = " あ ｱ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = "ｱあ ｱ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = " ｱ ｱ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//
//   euc = "あ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = "あ ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = "ｱ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = "ｱ ";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   euc = " ab";
//   size = euc.length;
//   len = await aplLibEucAdjustSize(euc,size,4);
//   print("4:[${euc}] len:${len.byte},${len.count}\n");
//   return 0;
// }
// #endif
}