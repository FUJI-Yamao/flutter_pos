/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../enum/e_presetcd.dart';
import '../controller/c_backtoregister_button_controller.dart';
import '../controller/c_coupons_controller.dart';

/// 支払方法ボタン
class PaymentMethodItem extends StatelessWidget {
  PresetInfo presetData;

  ///ボタンのアイコン
  final String iconPath;

  ///品券ボタンコントローラー
  final CouponsController couponCtrl = Get.find();

  ///戻るボタンコントローラー
  final BackRegisterButtonController backButtonCtrl = Get.find();

  ///コンストラクタ
  PaymentMethodItem({
    super.key,
    required this.presetData,
    required this.iconPath,
  });



  @override
  Widget build(BuildContext context) {
    final iconWidget = iconPath.isNotEmpty
        ? iconPath.endsWith('.svg')
            ? SvgPicture.asset(
                iconPath,
                width: 42,
                height: 42,
              )
            : Image.asset(
                iconPath,
                width: 62,

              )
        : null;
    ///　ボタンカラー
    final buttonColor = PresetCd.getBtnColor(presetData.presetColor);
    ///　ボタン枠線色
    final borderColor =
        presetData.presetColor == PresetCd.transColorCd ? BaseColor.baseColor : buttonColor;

    return InkWell(
      child: Container(
        width: 112.w,
        height: 112.h,
        decoration: BoxDecoration(
          color: BaseColor.someTextPopupArea,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: borderColor, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: BaseColor.dropShadowColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: BaseColor.transparentColor,
          child: SoundInkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              TchKeyDispatch.rcDTchByKeyId(presetData.kyCd, presetData);
            },
            callFunc: '${runtimeType.toString()} presetData.kyName ${presetData.kyName}',
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 8.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                if (iconWidget != null) iconWidget,
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    presetData.kyName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: BaseFont.font18px,
                      fontFamily: BaseFont.familySub,
                      color: BaseColor.baseColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
