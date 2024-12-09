/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:get/get.dart';

/// RegisterのObserver
class RegisterObserver extends GetObserver {
  RegisterObserver();

  static const String routeName1 = '/register';
  static const String routeName2 = '/tranining';

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (route.settings.name == routeName1 || route.settings.name == routeName2) {
        CommonController commonCtrl = Get.find();
        commonCtrl.onRegisterRoute.value = true;
      }
    });
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (route.settings.name == routeName1 || route.settings.name == routeName2) {
        CommonController commonCtrl = Get.find();
        commonCtrl.onRegisterRoute.value = false;
      }
    });
  }
}
