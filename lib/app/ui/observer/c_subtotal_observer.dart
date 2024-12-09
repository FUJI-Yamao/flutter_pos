/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/c_common_controller.dart';

/// SubtotalのObserver
class SubtotalObserver extends GetObserver {
  SubtotalObserver();

  static const String routeName = '/subtotal';

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (route.settings.name == routeName) {
        CommonController commonCtrl = Get.find();
        commonCtrl.onSubtotalRoute.value = true;
      }
    });
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (route.settings.name == routeName) {
        CommonController commonCtrl = Get.find();
        commonCtrl.onSubtotalRoute.value = false;
      }
    });
  }
}
