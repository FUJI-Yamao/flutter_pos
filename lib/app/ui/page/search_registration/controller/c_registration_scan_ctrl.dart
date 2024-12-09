/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import '../enum/e_registration_input_enum.dart';

///検索登録スキャン画面コントローラー
class RegistrationScanController extends GetxController {

  /// 共通のラベル
  final List<RegistrationInputFieldLabel> commonLabels = [
    RegistrationInputFieldLabel.registerNum,
    RegistrationInputFieldLabel.receiptNum,
  ];

  ///todo スキャン後処理を入れること
  /// スキャン後処理
  void onScanCompleted(String scanResult) {

    return;
  }

}
