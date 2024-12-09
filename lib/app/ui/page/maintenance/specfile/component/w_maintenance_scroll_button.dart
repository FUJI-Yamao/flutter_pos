/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../component/w_sound_buttons.dart';
import 'w_maintenance_scroll_controller.dart';

/// スクロールボタン（△と▽のボタン）
class MaintenanceScrollButton extends StatelessWidget {
  /// コンストラクタ
  const MaintenanceScrollButton(this.maintenanceScrollController, {required this.pageHeight, super.key});

  /// スクロールバーのコントローラー
  final MaintenanceScrollController maintenanceScrollController;
  // 1ページ分の高さ
  final double pageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.0 * 2,   // △ボタンの高さ＝95で、▽ボタンもあるので2倍する
      width: 100.0,
      decoration: const BoxDecoration(
        color: BaseColor.maintainButtonAreaBG,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
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
                color: BaseColor.maintainButtonAreaBG,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
                child: SoundInkWell(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                  ),
                  onTap: () {
                    // スクロールボタン△押下時のスクロール
                    maintenanceScrollController.scrollUp(pageHeight: pageHeight);
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
            height: 1,
            width: 100,
            color: BaseColor.someTextPopupArea.withOpacity(0.5),
          ),
          // ▽ボタンの表示
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Material(
                color: BaseColor.maintainButtonAreaBG,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
                child: SoundInkWell(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                  onTap: () {
                    // スクロールボタン▽押下時のスクロール
                    maintenanceScrollController.scrollDown(pageHeight: pageHeight);
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
