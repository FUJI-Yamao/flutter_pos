/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

/// スクロールバーのコントローラー
class MaintenanceScrollController extends ScrollController {

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
}
