/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

import '../colorfont/c_basecolor.dart';

/// スクロールバー（操作不可）
class IgnoreScrollbar extends StatelessWidget {
  const IgnoreScrollbar({
    super.key,
    this.thumbColor = BaseColor.scrollbarThumbColor,
    this.trackColor = BaseColor.scrollbartrackColor,
    this.thickness = 8.0,
    this.radius = 0.0,
    required this.scrollController,
    required this.child,
  });

  /// つまみの色
  final Color thumbColor;
  /// トラックエリアの色
  final Color trackColor;
  /// スクロールバーの太さ
  final double thickness;
  /// スクロールバーの角丸
  final double radius;

  /// スクロールコントローラー
  final ScrollController scrollController;
  /// 子Widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(thumbColor),  // つまみの色
        trackColor: MaterialStateProperty.all(trackColor),  // トラックエリアの色
        trackBorderColor: MaterialStateProperty.all(BaseColor.transparent), //トラックエリアのボーダーの色
        thumbVisibility: MaterialStateProperty.all(true),   // つまみを常に表示
        trackVisibility: MaterialStateProperty.all(true),   // トラックエリアを常に表示
        thickness: MaterialStateProperty.all(thickness),    // スクロールバーの太さ
        radius: Radius.circular(radius),                    // スクロールバーの角丸
        interactive: false,                                 // つまみやトラックエリアのタップに反応させない
      ),
      child: Scrollbar(
        controller: scrollController,
        child: child,
      ),
    );
  }
}