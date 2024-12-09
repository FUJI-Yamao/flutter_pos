/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colorfont/c_basecolor.dart';
import '../page/register/pixel/c_pixel.dart';

///共通用移動ボタン
class MoveButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MoveButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(1, 1),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: BasePixel.pix05),
          height: 128.h,
          width: 112.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                BaseColor.confirmBtnFrom,
                BaseColor.confirmBtnTo,
              ],
            ),
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: BaseColor.dropShadowColor.withOpacity(0.35),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(3, 0),
              ),
            ],
          ),
          child:  Flex(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            direction: Axis.vertical,
            children: [
              const Icon(
                Icons.arrow_forward,
                size: 48,
                color: BaseColor.someTextPopupArea,
              ),
              Text(
               text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: BaseFont.font18px,
                    color: BaseColor.someTextPopupArea,
                    fontFamily: BaseFont.familyDefault,
                    height: 1.3,
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: SoundInkWell(
              onTap: onTap,
              callFunc: runtimeType.toString(),
              child: null,
            ),
          ),
        ),
      ]),
    );
  }
}
