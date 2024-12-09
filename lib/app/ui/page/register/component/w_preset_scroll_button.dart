/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../colorfont/c_basecolor.dart';
import '../controller/c_presetscroll_controller.dart';

/// プリセット選択画面スクロールボタン
class PresetScrollButton extends StatelessWidget {
  const PresetScrollButton({
    super.key,
    required this.presetScrollCtrl,
    required this.scrollWidth,
  });

  /// スクロールの幅
  final double scrollWidth;

  /// スクロールバーのコントローラー
  final PresetScrollController presetScrollCtrl;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      presetScrollCtrl.updateOpacity();
    });
    return SizedBox(
      height: 80.h,
      width: 150.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Opacity(
              opacity: presetScrollCtrl.leftOpacity.value,
              child: Container(
                width: 72.w,
                height: 80.h,
                decoration: const BoxDecoration(
                  color: BaseColor.otherButtonColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                ),
                child: Material(
                  color: BaseColor.transparent,
                  child: SoundInkWell(
                    onTap: () {
                      // スクロールボタン△押下時のスクロール
                      presetScrollCtrl.scrollLeft(pageWidth: scrollWidth);
                    },
                    callFunc: runtimeType.toString(),
                    child: Center(
                      child: Transform.rotate(
                        angle: -90 * pi / 180,
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
          ),
          SizedBox(width: 4.w),
          // ▽ボタンの表示
          Obx(
            () => Opacity(
              opacity: presetScrollCtrl.rightOpacity.value,
              child: Container(
                decoration: const BoxDecoration(
                  color: BaseColor.otherButtonColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                width: 72.w,
                height: 80.h,
                child: Material(
                  color: BaseColor.transparent,
                  child: SoundInkWell(
                    onTap: () {
                      // スクロールボタン▽押下時のスクロール
                      presetScrollCtrl.scrollRight(pageWidth: scrollWidth);
                    },
                    callFunc: runtimeType.toString(),
                    child: Center(
                      child: Transform.rotate(
                        angle: -90 * pi / 180,
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
          ),
        ],
      ),
    );
  }
}
