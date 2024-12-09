/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../enum/e_presetcd.dart';

///支払方法選択のボックス（電子マネー、商品券用）
class PaymentBox extends StatelessWidget {
  ///ボタンのタイトルテキスト
  final String title;

  ///ボタンのアイコン
  final String iconPath;

  ///ボタンを押下する処理
  final VoidCallback onTap;

  /// プリセットカラー
  final int presetColor;

  const PaymentBox({
    super.key,
    required this.title,
    required this.onTap,
    required this.presetColor,
    this.iconPath = '',
  });

  @override
  Widget build(BuildContext context) {
    ///ボタンカラー
    final buttonColor = PresetCd.getBtnColor(presetColor);
    ///ボタン枠線色
    final borderColor = presetColor == PresetCd.transColorCd ? BaseColor.baseColor : buttonColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200.w,
        height: 200.h,
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
          onTap: onTap,
          callFunc: '${runtimeType.toString()} title $title',
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
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: BaseFont.font28px,
                    fontFamily: BaseFont.familyDefault,
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
