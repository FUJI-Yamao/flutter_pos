/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_sound_scroll_controller.dart';

/// スクロールボタン（△と▽のボタン）
class SoundSettingScrollButton extends StatelessWidget {
  const SoundSettingScrollButton({
    super.key,
    required this.pageHeight,
    required this.soundScrollController,
  });

  /// 1ページ分の高さ（ボタン押下時の移動量）
  final double pageHeight;
  /// スクロールボタンのコントローラー
  final SoundScrollController soundScrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.0 * 2,   // △ボタンの高さ＝95で、▽ボタンもあるので2倍する
      width: 100.0,
      decoration: const BoxDecoration(
        color: BaseColor.baseColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          // △ボタンの表示
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Material(
                color: BaseColor.baseColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20.0),
                ),
                child: SoundInkWell(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20.0),
                  ),
                  onTap: () {
                    // スクロールボタン△押下時のスクロール
                    soundScrollController.scrollUp(pageHeight: pageHeight);
                  },
                  callFunc: runtimeType.toString(),
                  child: Center(
                    child: Image.asset(
                      width: 40.0,
                      height: 40.0,
                      'assets/images/triangle.png',
                      color: BaseColor.someTextPopupArea.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // △と▽の間のボーダーの表示
          Container(
            height: 1.0,
            width: 100.0,
            color: BaseColor.someTextPopupArea.withOpacity(0.5),
          ),
          // ▽ボタンの表示
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Material(
                color: BaseColor.baseColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                ),
                child: SoundInkWell(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                  ),
                  onTap: () {
                    // スクロールボタン▽押下時のスクロール
                    soundScrollController.scrollDown(pageHeight: pageHeight);
                  },
                  callFunc: runtimeType.toString(),
                  child: Transform.rotate(
                    angle: 180 * pi / 180,
                    child: Center(
                      child: Image.asset(
                        width: 40.0,
                        height: 40.0,
                        'assets/images/triangle.png',
                        color: BaseColor.someTextPopupArea.withOpacity(0.5),
                      ),
                    ),
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