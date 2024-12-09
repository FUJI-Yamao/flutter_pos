/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colorfont/c_basecolor.dart';

/// お客様側の起動画面(ロゴ表示)
class CustomerStartPage extends StatelessWidget {
  const CustomerStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: BaseColor.newMainMenuWhiteColor,
        child: SvgPicture.asset(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fitWidth,
          'assets/images/splash_logo.svg',
        ),
      ),
    );
  }
}
