/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class ChkDigit {
  /// 関連tprxソース: chk_digit.c - cm_chk_digit()
  static bool cmChkDigit(String? dst, int len) {
    if (dst == null || dst.isEmpty) {
      return false;
    }
    var tgt = dst.substring(0, len);
    return int.tryParse(tgt) != null;
  }
}