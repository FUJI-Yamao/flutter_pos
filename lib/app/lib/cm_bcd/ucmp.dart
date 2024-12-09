/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class Ucmp {
  /// Compare BCD data
  /// 引数:[dst] top of destination BCD buffer
  /// 引数:[src] top of source BCD buffer
  /// 引数:[size] size of BCD buffer (bytes)
  /// 戻値: 0=「dst = src」 1=「dst < src」 -1=「dst > src」
  /// 関連tprxソース: ucmp.c - cm_ucmp
  static int cmUcmp(String dst, String src, int size) {
    int	result = 0;

    int lmt = size;
    if ((size > dst.length) || (size > src.length)) {
      if (dst.length < src.length) {
        lmt = dst.length;
      } else {
        lmt = src.length;
      }
    }
    for (int i=0; i<lmt; i++) {
      if (dst.codeUnitAt(i) < src.codeUnitAt(i)) {
        result = 1;
        break;
      } else if (dst.codeUnitAt(i) > src.codeUnitAt(i)) {
        result = -1;
        break;
      }
    }

    return result;
  }
}
