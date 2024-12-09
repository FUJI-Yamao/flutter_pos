/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

/// メンテナンス用のボタン情報
class MaintenanceButtonInfo {
  /// ボタンの名称
  final String buttonName;
  /// ボタン押下時の動作
  final GestureTapCallback onTapCallback;

  MaintenanceButtonInfo({
    required this.buttonName,
    required this.onTapCallback,
  });
}