/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 * mk_cdig.dart - Common Functions for Check Digit
 *   original code : mk_cdig.c
 */

import 'package:flutter_pos/app/inc/lib/ean.dart';

import '../cm_ean/set_cdig.dart';

class MkCdig {
  /// チェックディジットの作成
  /// 引数: EAN code(BCD)文字列
  /// 戻り値: チェックデジット付きEAN code
  /// 関連tprxソース:ean.c - cm_mk_cdigit
  static String cmMkCdigit(String ean) {
    if (ean.substring(12, 13) == '0') {
      /* is check digit zero ? */
      return SetCdig.cmSetCdigit(ean);
    }
    return ean;
  }

  /// チェックディジットの作成（可変長）
  /// 引数:[ean] EAN code(BCD)文字列
  /// 引数:[digit] EAN code長
  /// 戻り値: チェックディジット付きEAN code
  /// 関連tprxソース:ean.c - cm_mk_cdigit_variable
  static String cmMkCdigitVariable(String ean, int digit) {
    if (ean.substring((digit - 1), digit) == '0') {
      /* is check digit zero ? */
      return SetCdig.cmSetCdigitVariable(ean, digit);
    }
    return ean;
  }

  /// 条件付きモジュラス10特のチェックディジット設定
  /// （カード番号の15～16桁の位置が"00"の場合、モジュラス10特のチェックデジットを設定する）
  /// 引数: カード番号
  /// 戻り値: チェックディジット付きEAN code
  /// 関連tprxソース:ean.c - cm_mk_modulas10sp
  static String cmMkModulas10sp(String ean) {
    if (ean[14] != '0' || ean[15] != '0') {
      return ean;
    }
    return SetCdig.cmSetModulas10sp(ean);
  }
}
