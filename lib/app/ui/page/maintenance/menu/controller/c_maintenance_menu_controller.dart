/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:get/get.dart';

import '../../../../../backend/history/hist_main.dart';
import '../../../../../if/if_drv_control.dart';
import '../../../../../sys/syst/sys_main.dart';


/// メンテナンスのメニュー画面のコントローラー
class MaintenanceMenuController extends GetxController {

  /// メンテナンスTOP画面が表示される時
  @override
  void onInit() {
    super.onInit();

    /// 常駐isolateを停止する
    SysMain.isolateStop();
  }

  /// メンテナンスTOP画面が閉じられる時
  @override
  void onClose() {
    super.onClose();

    /// 常駐isolateを再開する
    SysMain.isolateRestart();
  }
}
