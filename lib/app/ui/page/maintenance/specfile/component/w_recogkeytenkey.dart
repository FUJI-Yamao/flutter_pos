/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import '../../../../component/w_sound_buttons.dart';
import '../controller/c_tenkey_recog_controller.dart';
import '../model/m_specfile.dart';

/// テンキーWidget
class RecogkeyTenkeyWidget extends StatelessWidget {
  RecogkeyTenkeyWidget({
    super.key,
    required this.controller,
  });

  final TenkeyRecogController controller;
  static const double keySpace = 8;

  final List<List<String>> _keys = [
    ['7', '8', '9', 'F'],
    ['4', '5', '6', 'E'],
    ['1', '2', '3', 'D'],
    ['0', 'A', 'B', 'C'],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: BaseColor.maintainTenkeyBG,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: _keys.map((row) {
          return Column(children: [
            Row(
              children: row.map((key) {
                bool isSpecialButton = RegExp(r'[A-F]').hasMatch(key);
                return Row(children: [
                  AlphabetNumberWidget(
                    text: key,
                    topSide: _keys.indexOf(row) == 0 ? true : false,
                    rightSide: row.indexOf(key) == 3 ? true : false,
                    isSpecialButton: isSpecialButton,
                    oncallback: () => controller.pushInputKey(key),
                  ),
                  if (row.indexOf(key) != 3) const SizedBox(width: keySpace),
                ]);
              }).toList(),
            ),
            if (_keys.indexOf(row) != 3) const SizedBox(height: keySpace),
          ]);
        }).toList(),
      ),
    );
  }
}

/// 数値用のWidget
class AlphabetNumberWidget extends StatelessWidget {
  const AlphabetNumberWidget({
    super.key,
    required this.text,
    required this.topSide,
    required this.rightSide,
    required this.oncallback,
    this.isSpecialButton = false,
  });

  final String text;
  final bool topSide;
  final bool rightSide;
  final Function oncallback;
  final bool isSpecialButton;

  Widget build(BuildContext context) {
    final color =
        isSpecialButton ? BaseColor.maintainTitleBG : BaseColor.maintainTenkey;

    return Material(
        type: MaterialType.button,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: SoundInkWell(
          onTap: () => oncallback(),
          callFunc: runtimeType.toString(),
          child: Container(
            alignment: Alignment.center,
            height: 95.h,
            width: 100.w,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: BaseFont.font30px,
                color: BaseColor.maintainTenkeyText,
                fontWeight: FontWeight.bold,
                fontFamily: BaseFont.familyNumber,
              ),
            ),
          ),
        ));
  }
}
