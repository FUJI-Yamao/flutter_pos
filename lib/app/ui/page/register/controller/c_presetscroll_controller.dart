/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// スクロールバーのコントローラー（横）
class PresetScrollController extends PageController {
  /// 左へボタンの透明度
  var leftOpacity = 1.0.obs;

  /// 右へボタンの透明度
  var rightOpacity = 1.0.obs;

  /// コンストラクタ
  PresetScrollController() {
    addListener(updateOpacity);
    updateOpacity();
  }

  /// 左側のスクロールボタン押下時のスクロール
  void scrollLeft({required double pageWidth}) {
    // 指定した位置へスクロール
    _scrollToPage(page: (page ?? 0).toInt() - 1);
  }

  /// 右側のスクロールボタン押下時のスクロール
  void scrollRight({required double pageWidth}) {
    // 指定した位置へスクロール
    _scrollToPage(page: (page ?? 0).toInt() + 1);
  }

  /// 指定した位置へスクロール
  void _scrollToPage({required int page}) {
    animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  ///ボタンの透明度を更新する
  void updateOpacity() {
    if (!hasClients) return;
    leftOpacity.value = page! > 0 ? 1.0 : 0.5;
    rightOpacity.value =
        page! < position.maxScrollExtent / position.viewportDimension
            ? 1.0
            : 0.5;
  }

  ///削除処理
  @override
  void dispose() {
    removeListener(updateOpacity);
    super.dispose();
  }
}
