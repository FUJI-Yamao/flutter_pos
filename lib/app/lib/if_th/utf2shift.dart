/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:utf2shift.c
//  このファイルは上記Cソースファイルを元にdart化したものです。

// ************************************************************************
// File:      utf2shift.c
// Contents:  utf2shift()
// ************************************************************************

import "dart:async";
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/lib/if_th/sjis_code.dart';
import 'package:flutter_pos/app/lib/if_th/utf8_code.dart';

class Utf2Shift {
  static const S_SIZE = 1024;

  // ///  関連tprxソース:utf2shift.c - utf2shift()
  static String utf2shift(String inStr) {
    return (utf2shiftChg2(inStr, 0));
  }

  ///  関連tprxソース:utf2shift.c - utf2shift_chg()
  static String utf2shiftChg(String inStr, int flg) {
    return (utf2shiftChg2(inStr, flg));
  }

  // int utf2shift_chg2(char *in, char *out, int tofullsize, int flg, int bufsiz)
  // 参考サイト　UCS->UTF変換　http://nomenclator.la.coocan.jp/unicode/ucs_utf.htm
  //           UTF8コード表　https://seiai.ed.jp/sys/text/java/utf8table.html
  // flutterのString型の文字コートはUTFではなくUCSが使われているようです。
  // なので、それをUTFに一旦変換してからUTFテーブルで突合し、そのインデックスを元に
  // SJISテーブルからSJISコードを取得します。
  ///  関連tprxソース:utf2shift.c - utf2shift_chg2()
  static String utf2shiftChg2(String inStr, int flg) {
    int size = 0;
    String cnv_chr = "";
    String in_str = "";
    String out_str = "";
    List<String> tmp = List<String>.generate(2, (index) => "");
    List<String> Dummy = ["\x81", "\x40", "\x00"];
    int pos = 0;
    int cnvChr = 0;

    in_str = inStr;
    out_str = "";

    while(in_str != "") {
      cnv_chr = in_str.substring(0, 1);
      var cnvChrList = cnv_chr.codeUnits.toList();
      size = cnvChrList.length;   // UCS型でのデータサイズ

      if (size == 1) {
        cnvChr = cnvChrList[0];   // UCS2
      } else {
        cnvChr = (cnvChrList[0] * 0x10000) + cnvChrList[1];   // UCS4
      }

      if (cnvChr < 0x80) {
        if (size == 1) {
          out_str += cnv_chr;
        } else {
          out_str += Dummy.join("");
        }
      } else {
        if (0 > (pos = getUtfTableIndex(cnvChr, size))) {
          break;
        }
        tmp[0] = SjisCode.table[pos][0];
        tmp[1] = SjisCode.table[pos][1];
        int tmp1_Int = tmp[1].codeUnitAt(0);

        if (flg == 1) {
          if ((tmp[0] == "\x87") && ((tmp1_Int >= 0x54) && (tmp1_Int <= 0x5d))) {
            /* ローマ数字 1~10 */
            tmp[0] = "\xF0";
            tmp[1] = latin1.decode([tmp1_Int - 0x14]);
          } else if ((tmp[0] == "\xee") && ((tmp1_Int >= 0xef) && (tmp1_Int <= 0xf8))) {
            /*  */
            tmp[0] = "\xF0";
            tmp[1] = latin1.decode([tmp1_Int - 0xA5]);
          } else if ((tmp[0] == "\x87") && ((tmp1_Int >= 0x40) && (tmp1_Int <= 0x49))) {
            /* 丸囲み数字 1~10 */
            tmp[0] = "\xF0";
            tmp[1] = latin1.decode([tmp1_Int + 0x2B]);
          } else if ((tmp[0] == "\x87") && (tmp1_Int == "\x8a")) {
            /* (株) */
            tmp[0] = "\xF0";
            tmp[1] = "\x7C";
          } else if ((tmp[0] == "\x87") && (tmp1_Int == "\x8c")) {
            /* (代) */
            tmp[0] = "\xF0";
            tmp[1] = "\x7B";
          } else if ((tmp[0] == "\x84") && ((tmp1_Int >= 0xbf) && (tmp1_Int <= 0xd9))) {
            tmp[0] = "\x84";
            tmp[1] = "\xde";	/* space */
          } else if ((tmp[0] == "\x85") && ((tmp1_Int >= 0x40) && (tmp1_Int <= 0x7d))) {
            tmp[0] = "\x84";
            tmp[1] = "\xde";	/* space */
          } else if ((tmp[0] == "\x87") && ((tmp1_Int >= 0x40) && (tmp1_Int <= 0x9e))) {
            tmp[0] = "\x84";
            tmp[1] = "\xde";	/* space */
          }
        }
        out_str += tmp[0];
        if ((tmp[1] != "\x00") && (tmp[1] != "") && (tmp[1] != null)) {
          out_str += tmp[1];
        }
      }
      in_str = in_str. substring(size); // ポインタ
    }
    return out_str;
  }

  /// UCSコードを元に、UTFテーブルのインデックス値を返却する。
  ///
  /// 機能　UCSコードのint値からUTFコードを算出する。UTFコードにてUTFテーブルを検索し、
  ///
  ///      インデックスを返す。
  ///
  /// 引数　ucsCode：UCSコード（int値)
  ///
  ///      size　　：UCSコードのバイト数（1:1byte(UCS-2に相当)、2:2byte(UCS-4に相当)
  ///
  /// 戻り値　	UTFテーブル（utf_code.dart）のインデックス値
  ///
  /// 関連tprxソース: utf2shift.c  C言語標準関数　bsearch相当の動作をdartの仕様を踏まえ新規作成
  static int getUtfTableIndex(int ucsCode, int size) {
    List<String> utf  = List<String>.filled(5, "\x00");
    if (size == 1) {
      // UCS2⇒UTF8
      if ((0x0000 <= ucsCode) && (ucsCode <= 0x007F)) {
        return 0;
      } else if ((0x0080 <= ucsCode) && (ucsCode <= 0x07FF)) {
        utf[0] = latin1.decode([0xC0 | ((ucsCode & 0x0008C0) >> 6)]);
        utf[1] = latin1.decode([0x80 | ((ucsCode & 0x00003F) >> 0)]);
      } else if ((0x0800 <= ucsCode) && (ucsCode <= 0xFFFF)) {
        utf[0] = latin1.decode([0xE0 | ((ucsCode & 0x00F000) >> 12)]);
        utf[1] = latin1.decode([0x80 | ((ucsCode & 0x000FC0) >>  6)]);
        utf[2] = latin1.decode([0x80 | ((ucsCode & 0x00003F) >>  0)]);
      } else if ((0x10000 <= ucsCode) && (ucsCode <= 0x1FFFFF)) {
        utf[0] = latin1.decode([0xF0 | ((ucsCode & 0x1C0000) >> 18)]);
        utf[1] = latin1.decode([0x80 | ((ucsCode & 0x03F000) >> 12)]);
        utf[2] = latin1.decode([0x80 | ((ucsCode & 0x000FC0) >>  6)]);
        utf[3] = latin1.decode([0x80 | ((ucsCode & 0x00003F) >>  0)]);
      }
    } else if (size == 2) {
      // UCS4⇒UTF16
      int ucsCode40 = (((ucsCode & 0x03FF0000) >>  6) | ((ucsCode & 0x000003FF) >>  0)) + 0x10000;
      utf[0] = latin1.decode([0xF0 | ((ucsCode40 & 0x001C0000) >> 18)]);
      utf[1] = latin1.decode([0x80 | ((ucsCode40 & 0x0003F000) >> 12)]);
      utf[2] = latin1.decode([0x80 | ((ucsCode40 & 0x00000FC0) >> 6)]);
      utf[3] = latin1.decode([0x80 | ((ucsCode40 & 0x0000003F) >> 0)]);
    }
    // UTFテーブル内を検索し、インデックス値を返す。
    return Utf8Code.table.indexWhere((element) =>
      ((element[0] == utf[0]) && (element[1] == utf[1]) && (element[2] == utf[2])));
  }

  // 動作確認用
  // SJISの文字列を直接WriteStringでファイル出力すると文字化けが発生するため、
  // List<int>に変換してWriteAsBytesSyncでファイル出力する。
  static void textOutput(String sjisText) {
    List<int> str = List<int>.generate(sjisText.length, (index) => sjisText.codeUnitAt(index));
    final File file = File(EnvironmentData.TPRX_HOME + "/debug/sjisReceipt.txt");
    file.writeAsBytesSync(str, mode: FileMode.append);
  }
}
