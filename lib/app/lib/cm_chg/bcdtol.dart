/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

/// 関連tprxソース: bcdtol.c
class Bcdtol{
    /// Change BCD to Long
    /// Input	  : Uint8List   bcd		BCD
    /// Output	: long
    /// Change BCD to long integer
    ///	BCD (size bytes) --> long
    ///	0x0123 (2 bytes) --> 0x0000007B
    /// 関連tprxソース: bcdtol.c - cm_bcdtol
    static int cmBcdToL(Uint8List bcd){
      
      int hex = 0;
      int radix = 1;

      var reversedBcd = bcd.reversed.toList();
      for(var data in reversedBcd){
        hex += (data & 0x0F) * radix;
        radix *= 10;
        hex += ((data >> 4)& 0x0F) * radix;
        radix *= 10;
      }

      return (hex);
    }
}