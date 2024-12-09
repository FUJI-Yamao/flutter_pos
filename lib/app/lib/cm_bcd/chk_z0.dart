/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

class ChkZ0{
  ///関連tprxソース: chk_z0.c - cm_chk_zero0
  static int cmChkZero0(Uint8List dst){
    int digit = dst.length * 2; /* digit(NIBBLE) count */

    for(var one in dst){
      if((one & 0xF0) != 0) break;
      digit--;
      if((one & 0x0F) != 0) break;
      digit--;
    }
    return(digit);
  }
}
