/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import '../../inc/apl/fnc_code.dart';

import '../../ui/page/difference_check/p_difference_check.dart';

class RckyDifCheck {
  /// 釣機参照画面を開く
  /// 関連tprxソース: rckycref.c
  static void openDifCheckPage(String title, FuncKey key) {
    Get.to(() => DifferenceCheckPage(title: title, funcKey: key));
  }
}
