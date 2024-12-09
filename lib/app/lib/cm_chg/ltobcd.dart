/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// Common functions for changing
/// 関連tprxソース: ltobcd.c
class Ltobcd {
	/// Input: int hex	long integer value >= 0
	///		     int size	size of BCD buffer (bytes)
	/// Output: void
	/// Change long integer to BCD
	///	long --> BCD (size bytes)
	///	0x00000123 --> ...[00][01][23]
  /// 関連tprxソース: ltobcd.c - cm_ltobcd
  static String cmLtobcd(int hex, int size){
    String work = "";
    String bcd = "";

    for(int i = size; i > 0; i--){
      int mod = hex % 100; /// 下から二桁取得
      int digit1 = mod % 10; /// 一の位
      int digit2 = (mod - digit1) ~/ 10; /// 十の位

      /// intをStringに変換
      work += String.fromCharCode((digit2 * 16) + digit1);
      hex = hex ~/ 100; /// 下から二桁を削除
    }

    for(; size > 0; size--){
      bcd += work[size - 1];
    }
    return bcd;
  }

	/// Input: int hex, long integer valeu >= 0
	///		     int size	size of BCD buffer (bytes)
  /// 関連tprxソース: ltobcd.c - cm_lltobcd
  static String cmLltobcd (int hex, int size)
  {
    return cmLtobcd(hex, size);
  }
}