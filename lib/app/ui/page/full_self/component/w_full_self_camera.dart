/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';

/// フルセルフ画面のフッターにあるカメラ画像
class FullSelfCamera extends StatelessWidget {
  const FullSelfCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // upperButtons(56) + 余白(16) + lowerButtons(72)
      height: 144.0,
      width: 120.0,
      color: Colors.black87,
      child: const Center(
        child: Text(
          'カメラ画像',
          style: TextStyle(
            color: BaseColor.someTextPopupArea,
            fontSize: BaseFont.font16px,
          ),
        ),
      ),
    );
  }

}