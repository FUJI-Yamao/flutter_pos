/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';
import 'chg_asc.dart';

/// 関連tprxソース: sup_asc.c
class SupAsc{
	/// Foramt	: void cm_setup_asc ( short opt, char *b_asc, char *b_bcd, int digit);
	/// Input	: short opt	option
	/// 			0: 0x0a-0x0f --> 0x3a(:)-0x3f(?)
	/// 			1: 0x0a-0x0f --> 0x41(A)-0x46(F)
	/// 			2: 0x0a-0x0f --> 0x61(a)-0x66(f)
	/// 			other: same as optin 0
	/// 	  char *b_asc	bottom of ASCII buffer
	/// 	  char *b_bcd	bottom of BCD buffer
	/// 	  int digit	number of digit(NIBBLE) to convert
	/// Output	: void
  /// 
	/// Change BCD to ASCII
	/// 	BCD (digit digits) --> ASCII (digit bytes) with zero check
	/// 	0x0123 (3 digits) --> "123" (3 bytes)
  ///  関連tprxソース: sup_asc.c - cm_setup_asc
  static String cmSetupAsc(int opt, Uint8List bcd, int size) {
    String ret = "";

    for (int digit in bcd) {
      int bcdUpBit = digit >> 4;
      int bcdUnderBit = digit & 0x0F;

      ret = ret + ChgAsc.cmChgAsc(opt, bcdUpBit);
      ret = ret + ChgAsc.cmChgAsc(opt, bcdUnderBit);
    }
    ret = ret.padLeft(size, '0');
    return ret.substring(ret.length - size); 
  }
}