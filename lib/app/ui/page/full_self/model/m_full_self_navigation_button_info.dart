/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

import '../enum/e_full_self_footer_lower_button.dart';

/// ボタン情報
class FullSelfNavigationButtonInfo {
  /// ボタンの名称
  final String buttonName;
  /// ボタンの識別子
  final FullSelfFooterLowerButtonsKind id;
  /// ボタンのアイコン
  final IconData iconKind;
  /// ボタン押下時の動作
  final GestureTapCallback onTapCallback;
  /// ボタンの表示非表示の真偽値
  bool isVisible;

  FullSelfNavigationButtonInfo({
    required this.buttonName,
    required this.id,
    required this.iconKind,
    required this.onTapCallback,
    required this.isVisible,
  });
}