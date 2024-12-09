/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../colorfont/c_basecolor.dart';
import '../component/hidden_button.dart';
import '../controller/c_register_start_controller.dart';


/// 起動画面(画像表示)
class RegisterStartPage extends StatelessWidget {
  const RegisterStartPage({this.isBoot = true, super.key});

  /// 起動時フラグ
  final bool isBoot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: RegisterStartController(isBoot),
        builder: (controller) => Stack(
          children: [
            Container(
              color: BaseColor.newMainMenuWhiteColor,
              child: SvgPicture.asset(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fitWidth,
                'assets/images/splash_logo.svg',
              ),
            ),
            // 隠しボタン
            Visibility(
              visible: !isBoot,
              child: HiddenButton(
                onTap: () => controller.toMainManu(),
                alignment: Alignment.topRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
