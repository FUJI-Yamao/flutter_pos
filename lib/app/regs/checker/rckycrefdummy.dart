/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../ui/page/change_coin/p_changecoinin_refer_page.dart';

///  関連tprxソース: rckycref.c
///    // TODO:00001 日向  競合を防ぐために一時的にdummyで作成
class RckyCrefDummy {
 
  /// 釣機参照画面を開く
  /// 関連tprxソース: rckycref.c
  static void openCrefPage(String title) {
      Get.to(() => ChangeCoinReferScreen(title: title));
  }

}