/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'c_price_check_controller.dart';

/// 価格確認画面のスクロールバーのコントローラー
class ItemScrollController extends ScrollController {
  /// 上へボタンの透明度
  var upOpacity = 0.5.obs;

  /// 下へボタンの透明度
  var downOpacity = 1.0.obs;

  /// スクロールの高さ
  static const double scrollHeight = 260;

  /// コンストラクタ
  ItemScrollController() {
    addListener(updateOpacity);
    updateOpacity();
  }

  /// TOPへ
  void scrollToTop() {
    // 指定した位置へスクロール
    _scrollToPosition(position: 0.0);
  }

  /// スクロールボタン△押下時のスクロール
  void scrollUp({required double pageHeight}) {
    // 指定した位置へスクロール
    _scrollToPosition(position: offset + (pageHeight * -1));
  }

  /// スクロールボタン▽押下時のスクロール
  void scrollDown({required double pageHeight}) {
    // 指定した位置へスクロール
    _scrollToPosition(position: offset + pageHeight);
  }

  /// 指定した位置へスクロール
  void _scrollToPosition({required double position}) {
    animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  ///ボタンの透明度を更新する
  void updateOpacity() {
    if (!hasClients) return;
    upOpacity.value = position.pixels > 0 ? 1.0 : 0.5;
    downOpacity.value = position.pixels < position.maxScrollExtent ? 1.0 : 0.5;
  }

  ///削除処理
  @override
  void dispose() {
    removeListener(updateOpacity);
    super.dispose();
    PriceCheckController priceCheckCtrl = Get.find();
    priceCheckCtrl.isPrcChkView.value = false;
  }
}
