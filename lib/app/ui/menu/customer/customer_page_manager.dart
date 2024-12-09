/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../common/environment.dart';
import '../../enum/e_screen_kind.dart';
import '../../page/customer/p_customer_register_page.dart';
import '../../page/customer/p_customer_register_page_7.dart';
import '../../page/p_customer_start_page.dart';
import 'e_customer_page.dart';

/// お客様画面の管理
class CustomerPageManager {

  /// お客様画面のルーティング
  static List<GetPage<dynamic>> pages() {
    // getPagesに設定するための変数
    List<GetPage<dynamic>> list = [];

    // 画面種別を見て、ルーティング情報を変える
    switch (EnvironmentData().screenKind) {
      case ScreenKind.customer:
        _createXgaPages(list);      // XGA客表のルーティング
      case ScreenKind.customer_7_1 || ScreenKind.customer_7_2:
        _create7inchPages(list);    // 7inch客表のルーティング
      default:
        throw AssertionError();
    }

    return list;
  }

  /// XGA客表のルーティング
  static void _createXgaPages(List<GetPage<dynamic>> list) {
    // ロゴ
    list.add(GetPage(name: CustomerPage.logo.routeName, page: () => const CustomerStartPage()));
    // 客表（登録）
    list.add(GetPage(name: CustomerPage.register.routeName, page: () => const CustomerRegisterPage()));
  }

  /// 7inch客表のルーティング
  static void _create7inchPages(List<GetPage<dynamic>> list) {
    // ロゴ
    list.add(GetPage(name: CustomerPage.logo.routeName, page: () => const CustomerStartPage()));
    // 客表（登録）
    list.add(GetPage(name: CustomerPage.register.routeName, page: () => const CustomerRegisterPage7()));
  }

}
