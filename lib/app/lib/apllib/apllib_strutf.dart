/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import '../../inc/lib/apllib.dart';

/// 文字列、文字幅関連LIB
/// 関連tprxソース: AplLib_StrUtf.c
class AplLibStrUtf {
  static const codeTab = 0x09; //'\t' code
  static const codeLf = 0x0A; //'\n' code

  /// 入力文字列の文字幅を返す（半角:1、全角:2 で加算）
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucCnt()
  /// 引数:[inStr] 入力文字列
  /// 戻り値:文字列の幅総計
  static int aplLibEntCnt(String inStr) {
    String lead = inStr;
    List<int> buf;
    int size = 0;
    int code = 0;
    int width = 0;

    while (lead.isNotEmpty) {
      buf = utf8.encode(lead);
      size = aplLibEucGetSize(lead);
      switch (size) {
        case 1:
          if ((buf[0] >= 0x20) && (buf[0] < 0x80)) {
            width += 1; /* 半角英数 */
          } else if (buf[0] == codeTab) {
            width += 8;
          }
          break;
        case 2:
          width += 2;
          /* 全角英数 */
          break;
        case 3:
          code = (buf[0] << 16) + (buf[1] << 8) + buf[2];
          if ((code > 0xefbda0) && (code < 0xefbfa0)) {
            width += 1; /* 半角カナ */
          } else {
            width += 2; /* 全角 */
          }
          break;
        case 4:
          width += 2;
          /* 全角 */
          break;
        default:
          return width;
      }
      lead = lead.substring(1);
    }

    return width;
  }

  /// 入力文字列のバイト数と文字数を返す（ただし、最大バイト数と最大文字幅を超えない）
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucAdjust()
  /// 引数:[inStr] 入力文字列
  /// 引数:[maxLen] 最大バイト数
  /// 引数:[maxWidth] 最大文字数
  /// 戻り値:入力文字列のバイト数と文字数、範囲内文字列
  static (EucAdj, String) aplLibEucAdjust(
      String inStr, int maxLen, int maxWidth) {
    EucAdj adj = EucAdj();
    String lead = inStr;
    List<int> buf;
    int size = 0;
    int code = 0;
    int cWidth = 0;
    int len = 0;
    int width = 0;
    String outStr = "";

    while (lead.isNotEmpty) {
      buf = utf8.encode(lead);
      size = aplLibEucGetSize(lead);
      switch (size) {
        case 0:
          adj.byte = len;
          adj.count = width;
          return (adj, inStr);
        case 1:
          if ((buf[0] >= 0x20) && (buf[0] < 0x80)) {
            cWidth = 1; /* 半角英数 */
          }
          break;
        case 2:
          cWidth = 2; /* 全角英数 */
          break;
        case 3:
          code = (buf[0] << 16) + (buf[1] << 8) + buf[2];
          if ((code > 0xefbda0) && (code < 0xefbfa0)) {
            cWidth = 1; /* 半角カナ */
          } else {
            cWidth = 2; /* 全角 */
          }
          break;
        case 4:
          cWidth = 2; /* 全角 */
          break;
      }
      if ((maxLen < (len + size)) || (maxWidth < (width + cWidth))) {
        break;
      } else {
        width += cWidth;
        len += size;
        lead = lead.substring(1);
      }
    }
    adj.byte = len;
    adj.count = width;

    outStr = inStr.substring(0, inStr.length - lead.length);
    return (adj, outStr);
  }

  /// 入力バイト配列のバイト数と文字数を返す（ただし、最大バイト数と最大文字幅を超えない）
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucAdjust()
  /// 引数:[inStr] 入力文字列
  /// 引数:[maxLen] 最大バイト数
  /// 引数:[maxWidth] 最大文字数
  /// 戻り値:入力文字列のバイト数と文字数、範囲内バイト配列
  static (EucAdj, List<int>) aplLibByteArrayEucAdjust(
      List<int> inStr, int maxLen, int maxWidth) {
    EucAdj adj = EucAdj();
    List<int> lead = [...inStr];
    int size = 0;
    int code = 0;
    int cWidth = 0;
    int len = 0;
    int width = 0;
    List<int> outBytes;

    while (lead.isNotEmpty) {
      size = aplLibByteArrayEucGetSize(lead);
      switch (size) {
        case 0:
          adj.byte = len;
          adj.count = width;
          return (adj, inStr);
        case 1:
          if ((lead[0] >= 0x20) && (lead[0] < 0x80)) {
            cWidth = 1; /* 半角英数 */
          }
          break;
        case 2:
          cWidth = 2; /* 全角英数 */
          break;
        case 3:
          code = (lead[0] << 16) + (lead[1] << 8) + lead[2];
          if ((code > 0xefbda0) && (code < 0xefbfa0)) {
            cWidth = 1; /* 半角カナ */
          } else {
            cWidth = 2; /* 全角 */
          }
          break;
        case 4:
          cWidth = 2; /* 全角 */
          break;
      }
      if ((maxLen < (len + size)) || (maxWidth < (width + cWidth))) {
        break;
      } else {
        width += cWidth;
        len += size;
        lead.removeRange(0, size);
      }
    }
    adj.byte = len;
    adj.count = width;

    outBytes = inStr.sublist(0, len);
    return (adj, outBytes);
  }

  /// 先頭１文字のバイト数を返す
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucGetSize()
  /// 引数:[inStr] 入力文字列
  /// 戻り値:先頭1文字のバイト数
  static int aplLibEucGetSize(String inStr) {
    var encode = utf8.encode(inStr);
    return aplLibByteArrayEucGetSize(encode);
  }

  /// 先頭１文字のバイト数を返す
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucGetSize()
  /// 引数:[inStr] 入力文字列
  /// 戻り値:先頭1文字のバイト数
  static int aplLibByteArrayEucGetSize(List<int> inStr) {
    List<int> lead = [...inStr];
    int count = 0;

    if (lead[0] == 0) {
      return 0;
    } else if (lead[0] == 0x1f) {
      // Color: ctrl code
      return 1;
    } else if (lead[0] < 0x80) {
      // ANSI
      if ((lead[0] == codeTab) || (lead[0] == codeLf) || (lead[0] >= 0x20)) {
        return 1;
      } else {
        return 0;
      }
    } else if (lead[0] < 0xC2) {
      // no code
      return 0;
    } else {
      int trail = lead[1];
      if (lead[0] < 0xE0) {
        // 2 byte code
        count = 2;
      } else if (lead[0] < 0xF0) {
        // 3 byte code
        if (((lead[0] == 0xE0) && (trail < 0xA0)) ||
            ((lead[0] == 0xEF) && (trail > 0xBF))) {
          return 0;
        }
        count = 3;
      } else if (lead[0] < 0xF5) {
        // 4 byte code
        if (((lead[0] == 0xF0) && (trail < 0x90)) ||
            ((lead[0] == 0xF4) && (trail > 0x8F))) {
          return (0);
        }
        count = 4;
      } else {
        // no code
        return 0;
      }
    }

    int size = 1;
    for (size = 1; size < count; ++size) {
      if (!apllibUtf8Trail(lead[size])) {
        return 0;
      }
    }

    return size;
  }

  /// 指定のUTF8コードが「2Byte文字」であるかチェックする
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_UtfGetSize()
  /// 引数:[inStr] 入力文字列
  /// 戻り値: true=2Byte文字  false=2Byte文字でない
  static bool apllibUtf8Trail(int code) {
    return ((code >= 0x80) && (code <= 0xBF));
  }

  /// 文字列out_strに文字列in_strの先頭から文字幅str_width分をコピーする
  /// コピーした文字数幅とバイト数の差を返す
  /// 引数   : String inStr        - 入力文字列
  ///          int  str_width      - 文字列幅
  /// 返り値 : int  cDiff          - バイト数 - 文字列幅
  ///          String outStr       - 出力文字列
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucCopy()
  static (int, String) aplLibEucCopy(String inStr, int strWidth) {
    return aplLibEucCopy2(inStr, strWidth, 0);
  }

  /// typ  0:文字幅分コピー　1: 文字数分コピー
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucCopy2()
  static (int, String) aplLibEucCopy2(String inStr, int strWidth, int typ) {
    String outStr = "";
    List<int> buff;
    String lead = inStr;
    int size = 0;
    int copySize = 0;
    int width = 0;
    int cWidth = 0;
    int code;
    int cDiff = 0;
    int cCnt = 0;

    while (lead.isNotEmpty) {
      buff = utf8.encode(lead);
      size = aplLibEucGetSize(lead);

      switch (size) {
        case 0:
          return (0, "");
        case 1:
          if ((0x20 <= buff[0]) && (buff[0] < 0x80)) {
            cWidth = 1; /* 半角英数 */
            cCnt++;
          }
          break;
        case 2:
          cWidth = 2; /* 全角 */
          cCnt++;
          break;
        case 3:
          code = (buff[0] << 16) + (buff[1] << 8) + buff[2];
          if ((0xefbda0 < code) && (code < 0xefbfa0)) {
            cWidth = 1; /* 半角カナ */
            cCnt++;
          } else {
            cWidth = 2; /* 全角 */
            cCnt++;
          }
          break;
        case 4:
          cWidth = 2; /* 全角 */
          cCnt++;
          break;
      }

      if (typ != 0) {
        if (strWidth < cCnt) {
          break;
        }
      } else {
        if (strWidth < (width + cWidth)) {
          break;
        }
        width += cWidth;
      }

      lead = lead.substring(1);
      copySize += size;
    }
    outStr = inStr.substring(0, inStr.length - lead.length);

    cDiff = copySize - width;
    return (cDiff, outStr);
  }

  /// 文字列inStrの先頭から文字列幅countを超える最小の文字列幅とバイト数を返す
  /// 引数   : String inStr  - 入力文字列
  ///          int    count  - 文字幅
  /// 返り値 : UtfAdj adj
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucAdjust_NeedCount()
  static EucAdj aplLibEucAdjustNeedCount(String inStr, int count) {
    EucAdj adj = EucAdj();
    String lead = inStr;
    List<int> buff;
    int size = 0;
    int len = 0;
    int width = 0;
    int code = 0;

    while (lead.isNotEmpty && (width < count)) {
      buff = utf8.encode(lead);
      size = aplLibEucGetSize(lead);

      switch (size) {
        case 0:
          adj.byte = len;
          adj.count = width;

          return adj;
        case 1:
          if ((0x20 <= buff[0]) && (buff[0] < 0x80)) {
            width += 1; /* 半角英数 */
          }
          break;
        case 2:
          width += 2; /* 全角 */
          break;
        case 3:
          code = (buff[0] << 16) + (buff[1] << 8) + buff[2];
          if ((0xefbda0 < code) && (code < 0xefbfa0)) {
            width += 1; /* 半角カナ */
          } else {
            width += 2; /* 全角 */
          }
          break;
        case 4:
          width += 2; /* 全角 */
          break;
      }

      len += size;

      if (count < width) {
        break;
      }

      lead = lead.substring(1);
    }

    adj.byte = len;
    adj.count = width;

    return adj;
  }

  /// 文字列inStrの先頭からバイト数byteを超える最小の文字列幅とバイト数を返す
  /// 引数   : String inStr  - 入力文字列
  ///          int count     - バイト数
  /// 返り値 : UtfAdj adj    -
  /// 関連tprxソース: AplLib_StrUtf.c - AplLib_EucAdjust_NeedByte()
  static EucAdj aplLibEucAdjustNeedByte(String inStr, int byte) {
    EucAdj adj = EucAdj();
    String lead = inStr;
    List<int> buff;
    int size = 0;
    int len = 0;
    int width = 0;
    int code = 0;

    while (lead.isNotEmpty && (len < byte)) {
      buff = utf8.encode(lead);
      size = aplLibEucGetSize(lead);

      switch (size) {
        case 0:
          adj.byte = len;
          adj.count = width;

          return (adj);
        case 1:
          if ((0x20 <= buff[0]) && (buff[0] < 0x80)) {
            width += 1; /* 半角英数 */
          }
          break;
        case 2:
          width += 2; /* 全角 */
          break;
        case 3:
          code = (buff[0] << 16) + (buff[1] << 8) + buff[2];
          if ((0xefbda0 < code) && (code < 0xefbfa0)) {
            width += 1; /* 半角カナ */
          } else {
            width += 2; /* 全角 */
          }
          break;
        case 4:
          width += 2; /* 全角 */
          break;
      }

      len += size;

      if (byte < len) {
        break;
      }

      lead += lead.substring(1);
    }

    adj.byte = len;
    adj.count = width;

    return (adj);
  }
}
