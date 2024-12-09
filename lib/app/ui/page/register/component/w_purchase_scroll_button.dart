/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/w_purchase_scroll_controller.dart';

/// スクロールボタン（△と▽のボタン）
class PurchaseScrollButton extends StatelessWidget {
  /// コンストラクタ
  const PurchaseScrollButton({
    super.key,
    required this.purchaseScrollController,
    required this.backgroundColor,
    required this.scrollHeight,
  });

  /// 背景色
  final Color backgroundColor;

  /// スクロールの高さ
  final double scrollHeight;

  /// スクロールバーのコントローラー
  final PurchaseScrollController purchaseScrollController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      purchaseScrollController.updateOpacity();
    });
    return Container(
      height: 62.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // △ボタンの表示
          Obx(
            () => Opacity(
              opacity: purchaseScrollController.upOpacity.value,
              child: Container(
                width: 64.w,
                height: 48.h,
                decoration: const BoxDecoration(
                  color: BaseColor.otherButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Material(
                  color: BaseColor.transparent,
                  child: SoundInkWell(
                    onTap: () {
                      // スクロールボタン△押下時のスクロール
                      purchaseScrollController.scrollUp(
                          pageHeight: scrollHeight);
                    },
                    callFunc: runtimeType.toString(),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/up.svg',
                        width: 30.w,
                        height: 18.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 24.w),
          // ▽ボタンの表示
          Obx(
            () => Opacity(
              opacity: purchaseScrollController.downOpacity.value,
              child: Container(
                decoration: const BoxDecoration(
                  color: BaseColor.otherButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                width: 64.w,
                height: 48.h,
                child: Material(
                  color: BaseColor.transparent,
                  child: SoundInkWell(
                    onTap: () {
                      // スクロールボタン▽押下時のスクロール
                      purchaseScrollController.scrollDown(
                          pageHeight: scrollHeight);
                    },
                    callFunc: runtimeType.toString(),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/down.svg',
                        width: 30.w,
                        height: 18.h,
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
