/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

class Bcdtoa{
	// Input	: 
	// 	  String bcd		BCD
  //     int size		  size of BCD
	// Output	:
  //    String asc		ASCII
  // BCD        --> ASCII
  // 0x0123 (2) --> "00123" (5 bytes)
  /// 関連tprxソース: bcdtoa.c - cm_bcdtoa
  static String cmBcdToA(Uint8List bcd, int size){

    String result = ''.padLeft(size, '0');
    if (bcd.isEmpty) {
      return result;
    }

    for (var digit in bcd.toList()) {
      result += (digit >> 4).toRadixString(16);
      result += (digit & 0x0F).toRadixString(16);
    }

    return result.substring(result.length - size);
  }
  
}