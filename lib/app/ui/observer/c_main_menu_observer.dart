/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:get/get.dart';

import '../../common/environment.dart';
import '../enum/e_screen_kind.dart';
import '../socket/client/register2_socket_client.dart';

/// MainMenuのObserver
class MainMenuObserver extends GetObserver {
  MainMenuObserver();

  static const String routeName = '/mainmenu';
  bool isInit = true;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(route.settings.name == routeName) {
        if(previousRoute != null){
          final previousName = previousRoute.settings.name;
        if (previousName != null &&
            previousName.isEmpty) {
          await setLock();
        }
        }
        else if (previousRoute != null &&
            previousRoute.settings.name! == routeName) {
          Register2SocketClient().sendSingleModeUnlockPossibility(false);
        }
      }
    });
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    if (previousRoute == null) {
      return;
    }

    if (previousRoute.settings.name == routeName) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (await DualCashierUtil.check2Person()) {
          Register2SocketClient().sendSingleModeUnlockPossibility(true);
        }
      });
    } else if (route.settings.name == routeName) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (await DualCashierUtil.check2Person()) {
          Register2SocketClient().sendSingleModeUnlockPossibility(false);
        }
      });
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (isInit && await DualCashierUtil.check2Person()) {
        await DualCashierUtil.initDualMode();
      }
      isInit = false;

      if (newRoute!.settings.name == routeName && oldRoute!.settings.name! == '/') {
        if (await DualCashierUtil.check2Person()) {
          Register2SocketClient().sendSingleModeUnlockPossibility(true);
          await setLock();
        }
      }
    });
  }

  /// 操作対象切替時にロックする
  Future<void> setLock() async {
    CommonController commonCtrl = Get.find();
    if (await DualCashierUtil.check2Person()
        && EnvironmentData().screenKind == ScreenKind.register2
        && !commonCtrl.isMainMachine.value) {
      DualCashierUtil.setLockStatus(true, 'キャッシャー動作中');
    }
  }
}
