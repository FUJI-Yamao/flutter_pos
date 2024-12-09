/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterruptWidget extends StatelessWidget {
  const InterruptWidget({super.key});
  
  get currentMode => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      margin: const EdgeInsets.only(top: 10, right: 10),
      width: 527.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: BaseColor.registerColorTo,
          width: 4,
        ),
      ),
      child: const Text(
        '割り込み中',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: BaseFont.font24px,
          color: BaseColor.registerColorTo,
      ),
    )
  );
  }
}