/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

/// 関連tprxソース: lib/cm_chg\asctobcd.c
class AscToBcd{
	// Input	:
	// 	  String    asc		ASCII
	//    Uint8List bcd   HEX
	// Change ASCII to BCD
	// 	ASCII  --> BCD
	// 	"123"  --> "0x0123" (List size 2)
  /// 関連tprxソース: lib/cm_chg\asctobcd.c - cm_asctobcd
  static Uint8List cmAscTobcd(String asc) {

    if (asc.isEmpty) {
      return Uint8List(0);
    }

    // 4bit1文字なので、2で割って切り上げ
    int bcdSize = (asc.length / 2).ceil();
    Uint8List result = Uint8List(bcdSize);

    // 逆順にして2文字ずつ取得
    List<String> reversedAsc = asc.split('').reversed.toList();
    for (int i = 0; i < reversedAsc.length; i+=2) {

      int bcd = 0;
      bcd =   int.parse(reversedAsc[i], radix: 16) & 0x0F;
      bcd |= i+1 < reversedAsc.length ? (int.parse(reversedAsc[i + 1], radix: 16) << 4) : 0;

      // 後ろから格納
      result[bcdSize - (i ~/ 2) - 1] = bcd;

    }
    return result;
  }

}
