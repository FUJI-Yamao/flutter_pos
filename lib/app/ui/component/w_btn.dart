/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colorfont/c_basecolor.dart';
import '../colorfont/c_basefont.dart';
import 'w_sound_buttons.dart';

/// テキスト用Widget
class BtnWidget extends StatelessWidget {
  const BtnWidget({
    super.key,
    required this.setting,
  });

  final setting;

  @override
  Widget build(BuildContext context) {
    if (setting == null) {
      return const SizedBox.shrink();
    } else {
      return Obx(
        () => SoundInkWell(
          onTap: setting.value.onTap,
          callFunc: runtimeType.toString(),
          child: SizedBox(
            width: setting.value.width,
            height: setting.value.height,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_forward_ios, size: 25, color: Colors.white),
              ],
            ),
          ),
        ),
      );
    }
  }
}

/// グラデーション、フチありボタン.
class GradientBorderButton extends StatelessWidget {
  /// ボタンの高さ.
  final double height;

  /// ボタンの横幅
  final double width;

  /// ボタンテキスト.
  final String text;

  /// 押したときの処理.
  final Function onTap;

  final Color startColor;
  final Color endColor;
  final Color borderColor;
  final Color textColor;
  final double fontSize;
  final String fontFamily;
  final bool shadow;

  const GradientBorderButton(
      {super.key,
        required this.height,
        required this.width,
        required this.text,
        required this.onTap,
        this.startColor = BaseColor.maintainTitleBG,
        this.endColor = BaseColor.GrdBdrButtonEndColor,
        this.borderColor = BaseColor.someTextPopupArea,
        this.textColor = BaseColor.someTextPopupArea,
        this.fontSize = BaseFont.font24px,
        this.fontFamily = BaseFont.familySub,
        this.shadow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            startColor,
            endColor,
          ],
        ),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: [
          if (shadow)
            BoxShadow(
              color: BaseColor.baseColor.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: SoundElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: () => onTap.call(),
        callFunc: '${runtimeType.toString()} text $text',
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: fontFamily),
        ),
      ),
    );
  }
}

/// 単色、フチありのボタン.
class BorderButton extends StatelessWidget {
  /// ボタンの高さ.
  final double height;

  /// ボタンの横幅
  final double width;

  /// ボタンテキスト.
  final String text;

  /// 押したときの処理.
  final Function onTap;

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double fontSize;
  final bool shadow;

  const BorderButton(
      {super.key,
        required this.height,
        required this.width,
        required this.text,
        required this.onTap,
        this.backgroundColor = BaseColor.maintainButtonAreaBG,
        this.borderColor = BaseColor.someTextPopupArea,
        this.textColor = BaseColor.someTextPopupArea,
        this.fontSize = BaseFont.font24px,
        this.shadow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          boxShadow: [
            if (shadow)
              BoxShadow(
                color: BaseColor.baseColor.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
          ]),
      child: SoundElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        onPressed: () => onTap.call(),
        callFunc: '${runtimeType.toString()} text $text',
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: BaseFont.familySub),
        ),
      ),
    );
  }
}