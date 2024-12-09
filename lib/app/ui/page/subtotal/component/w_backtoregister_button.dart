/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_backtoregister_button_controller.dart';
import '/app/ui/colorfont/c_basefont.dart';

/// 登録画面に戻るボタン
class BackRegisterButton extends StatelessWidget {
  BackRegisterButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.borderRadius,
      required this.onTap,
        this.backgroundColor,
      this.isVisible = true});

  final String text;
  final IconData icon;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback onTap;
  final bool isVisible;
  final Color? backgroundColor;

  final backButtonCtrl = Get.put(BackRegisterButtonController());
  @override
  Widget build(BuildContext context) {
    //return Obx(() {
      return Visibility(
        visible: isVisible,
        child: Stack(children: [
          Container(
            width: 96.w,
            height: 128.h,
            decoration: BoxDecoration(
              gradient: backgroundColor == null ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  BaseColor.confirmBtnFrom,
                  BaseColor.confirmBtnTo,
                ],
              ) : null,
              color: backgroundColor,
              borderRadius: borderRadius,
              boxShadow: const [
                BoxShadow(
                  color: BaseColor.dropShadowColor,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Icon(
                      icon,
                      size: 48,
                      color: BaseColor.someTextPopupArea,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h, top: 14.h),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px,
                          fontFamily: BaseFont.familyDefault),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: SoundInkWell(
                onTap: onTap,
                child: null,
                callFunc: runtimeType.toString(),
              ),
            ),
          )
        ]),
      );
   // });
  }
}
