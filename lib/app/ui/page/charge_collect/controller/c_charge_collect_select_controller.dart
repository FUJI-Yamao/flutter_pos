/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'c_charge_collect_controller.dart';

/// つり機回収方法選択画面のコントローラ
class ChargeCollectSelectController extends GetxController {
  /// コンストラクタ
  ChargeCollectSelectController();

  /// 回収方法を選択した時のハンドラ
  void onSelectCollectType(CollectType type) {
    Get.back(result: type);
  }
}
