/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

/// 端末設定情報ダウンロードのコントローラ
class FclSetupDownloadController extends GetxController {
  static const initStatusMessage = '※よろしければ「実行」ボタンをタッチしてください。';
  final Rx<String> execStatus = initStatusMessage.obs;
}