/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/ean.dart';

class SetZero {
  /// 指定文字列の頭文字を"0"で埋める（文字長：13文字）
  /// 引数:[plu] 文字列
  /// 戻り値:[String] 編集後文字列
  ///  関連tprxソース: cm_stf.c - cm_plu_set_zero()
  static String cmPluSetZero(String plu) {
    return plu.padLeft(Ean.ASC_EAN_13, "0");
  }
}