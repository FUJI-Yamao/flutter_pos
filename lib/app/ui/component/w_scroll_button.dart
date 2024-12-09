/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colorfont/c_basecolor.dart';
import 'c_scroll_button_and_bar_controller.dart';
import 'w_sound_buttons.dart';

/// スクロールボタン（△と▽のボタン）
class ScrollButton extends StatelessWidget {
  const ScrollButton({
    super.key,
    required this.pageHeight,
    required this.scrollButtonAndBarController,
  });

  /// 1ページ分の高さ（ボタン押下時の移動量）
  final double pageHeight;
  /// スクロールボタンのコントローラー
  final ScrollButtonAndBarController scrollButtonAndBarController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0 * 2 + 4.0,   // △ボタンの高さ＝80で、▽ボタンもあるので2倍する
      width: 72.0,
      decoration: const BoxDecoration(
        color: BaseColor.baseColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
        ),
      ),
      child: Column(
        children: [
          // △ボタンの表示
          SizedBox(
            height: 80.0,
            width: 72.0,
            child: Material(
              color: BaseColor.batchReportOutputPageScrollButton,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
              ),
              child: SoundInkWell(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                ),
                onTap: () {
                  // スクロールボタン△押下時のスクロール
                  scrollButtonAndBarController.scrollUp(pageHeight: pageHeight);
                },
                callFunc: runtimeType.toString(),
                child: Center(
                  child: SvgPicture.asset(
                    width: 30.0,
                    height: 18.0,
                    'assets/images/up.svg',
                  ),
                ),
              ),
            ),
          ),
          // △と▽の間の余白
          Container(
            height: 4.0,
            color: BaseColor.batchReportOutputPageBackgroundColor,
          ),
          // ▽ボタンの表示
          SizedBox(
            height: 80.0,
            width: 72.0,
            child: Material(
              color: BaseColor.batchReportOutputPageScrollButton,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
              ),
              child: SoundInkWell(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                ),
                onTap: () {
                  // スクロールボタン▽押下時のスクロール
                  scrollButtonAndBarController.scrollDown(pageHeight: pageHeight);
                },
                callFunc: runtimeType.toString(),
                child: Center(
                  child: SvgPicture.asset(
                    width: 30.0,
                    height: 18.0,
                    'assets/images/down.svg',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}