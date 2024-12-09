/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../ui/colorfont/c_basefont.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../enum/e_presetcd.dart';
import '../controller/c_registerpluare_controller.dart';

///カテゴリーエリア
class PluTabArea extends StatelessWidget {
  ///コンストラクタ
  const PluTabArea({super.key});

  @override
  Widget build(BuildContext context) {
    /// コントローラー
    PluAreaController pluTabCtrl = Get.find();

    return Container(
      height: 496.h,
      alignment: Alignment.topLeft,
      child: Obx(
        () => Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = pluTabCtrl.pluTabStart.value;
                i < pluTabCtrl.pluTabEnd.value &&
                    pluTabCtrl.pluTabBtnData.length > i;
                i++)
              PluTab(
                idx: i,
                title: pluTabCtrl.pluTabBtnData[i].kyName,
                color: PresetCd.getBtnColor(pluTabCtrl.pluTabBtnData[i].presetColor),
              ),
            // 切替ボタン
            if (pluTabCtrl.pluTabSwitching)
              PluTab(
                idx: pluTabCtrl.pluTabSwitchNumber,
                title: 'さらに表示',
                isGradient: true,
                textStyle: const TextStyle(
                    fontSize: BaseFont.font18px,
                    color: BaseColor.someTextPopupArea,
                    fontFamily: BaseFont.familyDefault),
              ),
          ],
        ),
      ),
    );
  }
}

///タブキーのウィジェット
class PluTab extends StatelessWidget {
  /// コンストラクタ
  const PluTab({
    super.key,
    required this.idx,
    required this.title,
    this.color = BaseColor.transparent,
    this.isGradient = false,
    this.textStyle,
  });

  ///　インデックス
  final int idx;

  ///　タイトル
  final String title;

  ///　カラー
  final Color color;

  ///　色のグラデーション
  final bool isGradient;

  /// テキストスタイル
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    /// コントローラー
    PluAreaController pluTabCtrl = Get.find();
    return Obx(() {
      bool isSelected = idx == pluTabCtrl.pluTabPosition.value;
      return Container(
        margin: EdgeInsets.only(bottom: 5.h),
        height: 64.h,
        width: isSelected ? 92.w : 84.w,
        child: Stack(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10.w),
                  height: 64.h,
                  width: isSelected ? 92.w - 8.w : 84.w - 8.w,
                  decoration: const BoxDecoration(
                    color: BaseColor.someTextPopupArea,
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: BaseFont.font18px,
                        color: BaseColor.baseColor,
                        fontFamily: BaseFont.familySub,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 64.h,
                  width: 8.w,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                color: BaseColor.transparent,
                child: SoundInkWell(
                  onTap: () => idx == pluTabCtrl.pluTabSwitchNumber
                      ? pluTabCtrl.switchTab()
                      : pluTabCtrl.changeTab(idx),
                  callFunc: runtimeType.toString(),
                  child: null,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
