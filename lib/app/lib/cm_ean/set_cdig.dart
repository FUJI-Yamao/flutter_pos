/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// Common Functions for Check Digit
// チェックデジット設定用共通関数
// 関連tprxソース:set_cdig.c

import './cdigt.dart';

class SetCdig {
  /// チェックディジット算出
  /// 引数: EANコード(BCD)
  /// 戻り値:チェックディジット設定済みEANコード
  /// 関連tprxソース:set_cdig.c - cm_set_cdigit()
  static String cmSetCdigit(String ean0) {
    List<String> ean = ean0.split("");
    ean[12] = Cdigt.cmCdigit(ean0).toString();
    return ean.join("");
  }

  /// チェックディジット算出（可変長）
  /// 引数:[ean] EANコード(BCD)
  /// 引数:[digit] EANコード長
  /// 戻り値:チェックディジット設定済みEANコード
  /// 関連tprxソース:set_cdig.c - cm_set_cdigit_variable()
  static String cmSetCdigitVariable(String ean0, int digit) {
    List<String> ean = ean0.split("");
    ean[12] = Cdigt.cmCdigit(ean0).toString();
    ean[digit - 1] = Cdigt.cmCdigitVariable(ean0, digit).toString();
    return ean.join("");
  }

  /// モジュラス10特のチェックディジット設定
  /// （カード番号の15～16桁の位置にモジュラス10特のチェックディジットを設定し、チェックディジット設定済みカード番号を返却する）
  /// 引数: カード番号
  /// 戻り値:チェックディジット設定済みカード番号
  /// 関連tprxソース:set_cdig.c - cm_set_modulas10sp()
  static String cmSetModulas10sp(String ean0) {
    List<String> ean = ean0.split("");
    /* チェックデジット1設定 */
    ean[14] = Cdigt.cmMkcdModulas10sp1(ean0).toString();
    /* チェックデジット2設定 */
    ean[15] = Cdigt.cmMkcdModulas10sp2(ean0).toString();
    return ean.join("");
  }
}
