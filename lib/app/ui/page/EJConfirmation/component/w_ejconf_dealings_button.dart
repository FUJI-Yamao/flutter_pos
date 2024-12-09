/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///前の　次の　取引をボタン構築
class DealingButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onPressed;
  final double opacity;

  const DealingButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed,
      this.opacity = 1.0});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: 144.w,
        child: SoundElevatedButton(
          onPressed: onPressed,
          callFunc: runtimeType.toString(),
          style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.newBaseColor,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              SizedBox(height: 5.h),
              Text(
                text,
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontFamily: BaseFont.familyDefault,
                  fontSize: BaseFont.font18px,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
