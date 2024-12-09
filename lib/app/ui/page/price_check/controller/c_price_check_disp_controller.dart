/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/ui/page/price_check/controller/w_item_scroll_controller.dart';
import 'package:get/get.dart';
import 'c_price_check_controller.dart';

/// 価格確認画面の表示用コントローラ
class PriceCheckDispController extends GetxController {
  /// コンストラクタ
  PriceCheckDispController();
  /// スクロールコントローラー
  final ItemScrollController itemScrollCtrl =
  ItemScrollController();

  /// 印字ボタン表示フラグ
  var printBtnViewFlg = true.obs;
  /// スクロールボタン表示フラグ
  var scrollBtnViewFlg = true.obs;
  /// 価格確認画面の表示状態
  var isPrcChkView = false.obs;

  @override
  void onInit() {
    super.onInit();

    // ミックスマッチ情報がない場合はスクロールボタンを表示しない
    PriceCheckController priceCheckCtrl = Get.find();
    if (priceCheckCtrl.mixMatchData.value.validConditionNumber == 0) {
      scrollBtnViewFlg.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    itemScrollCtrl.dispose();
  }
}
