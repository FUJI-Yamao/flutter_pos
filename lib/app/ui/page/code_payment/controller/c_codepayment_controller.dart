/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../component/w_inputbox.dart';
import '../../subtotal/controller/c_subtotal_controller.dart';

///バーコード支払い画面のコントローラ
class CodePaymentInputController extends GetxController {
  ///コンストラクタ
  CodePaymentInputController() : inputBoxKey = GlobalKey<InputBoxWidgetState>();

  ///入力boxの状態を管理ためのGlobalKey
  final GlobalKey<InputBoxWidgetState> inputBoxKey;

  SubtotalController subtotalCtrl = Get.find();

  /// 合計額
  var currentTotalAmount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    currentTotalAmount.value = subtotalCtrl.notEnoughAmount.value;
  }
}
