/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';

class PromotionItem extends StatelessWidget {
  final String title;
  final bool isTriangle;
  final double width;
  final double height;
  final BoxDecoration decoration;
  final VoidCallback onPressed;

  PromotionItem({
    required this.title,
    this.isTriangle = false,
    required this.width,
    required this.height,
    required this.decoration,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: decoration,
        width: 180,
        height: 56,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: BaseColor.baseColor,
            fontSize: BaseFont.font18px,
            fontFamily: BaseFont.familySub,
          ),
          //  textAlign: TextAlign.center,
        ),
      ),
      Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: SoundInkWell(
            onTap: () => onPressed(),
            child: null,
            callFunc: '${runtimeType.toString()} title $title',
          ),
        ),
      )
    ]);
  }
}
