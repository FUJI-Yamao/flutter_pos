/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../../common/number_util.dart';
import '../../register/controller/w_purchase_scroll_controller.dart';

class CouponsController extends GetxController {
  final showCouponList = false.obs;
  PurchaseScrollController purchaseScrollController = PurchaseScrollController();

  // 商品券一覧 scrollが可能な場合はtrue.
  final purchaseScrollON = false.obs;

  /// 非活性ボタンの不透明度
  static const disableBtnOpacity = 0.4;

  /// 活性ボタンの不透明度
  static const enableBtnOpacity = 1.0;

  /// 商品一覧の上スクロールボタン不透明度
  final upOpacity = disableBtnOpacity.obs;

  /// 商品一覧の下スクロールボタン不透明度
  final downOpacity = enableBtnOpacity.obs;

  /// 商品券リストのスクロール量
  final scrollHeight = 0.0.obs;

  /// クーポンリストの生成
  var coupons = <Map<String, String>>[].obs;

  ///コントローラー準備完了時に呼ばれる
  @override
  Future<void> onReady() async {
    super.onReady();
    purchaseScrollController.updateOpacity();
  }
  void clearList() {
    coupons.clear();
  }

  /// クーポンリストに追加
  /// title：  クーポン名
  /// amount： クーポン一枚あたりの金額
  /// count：  クーポン枚数
  void addCoupon(String title, int amount, int count) {
    if (amount <= 0 || count <= 0) {
      return;
    }

    Map<String, String> newCoupon = {
      'title': title,
      'amount': NumberFormatUtil.formatAmount(amount * count),
      'count': title == '現金' ? '' : '$count枚',
    };
    coupons.add(newCoupon);
  }

  /// スクロール位置に応じて上下ボタンの活性・非活性状態を設定する
  void setButtonState() {
    /// 上ボタン
    bool isTop = purchaseScrollController.position.pixels ==
        purchaseScrollController.position.minScrollExtent;

    /// スクロール位置が先頭
    if (isTop) {
      upOpacity.value = disableBtnOpacity;
    }

    /// スクロール位置が先頭以外
    else {
      upOpacity.value = enableBtnOpacity;
    }

    /// 下ボタン
    bool isBottom = purchaseScrollController.position.pixels ==
        purchaseScrollController.position.maxScrollExtent;

    /// スクロール位置が最後
    if (isBottom) {
      downOpacity.value = CouponsController.disableBtnOpacity;
    }

    /// スクロール位置が最後以外
    else {
      downOpacity.value = CouponsController.enableBtnOpacity;
    }

    /// スクロールバー、ボタンの表示要否を設定
    if (upOpacity.value == CouponsController.enableBtnOpacity ||
        downOpacity.value == CouponsController.enableBtnOpacity) {
      purchaseScrollON.value = true;
    } else {
      purchaseScrollON.value = false;
    }
  }

}
