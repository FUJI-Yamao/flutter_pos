/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../menu/register/enum/e_register_page.dart';

/// 通番訂正完了画面コントローラー(仮コントローラー、遷移図確認後、調整する)
class ReceiptCompleteController extends GetxController {
  ///返金金額
  var refund = 0.obs;

  ///「完了」ボタン画面遷移処理
  void onCompletedButtonPressed() {
    Get.until((route) => route.settings.name == '/LoginAccountPage');
  }

  ///　「再売り上げ」ボタン画面遷移処理
  void onResaleButtonPressed() {
    Get.until((route) => route.settings.name == RegisterPage.register.routeName);
  }

}
