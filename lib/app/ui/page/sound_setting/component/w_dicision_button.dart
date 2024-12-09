/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';

/// 決定ボタン
class SoundSelectionDecisionButton extends StatelessWidget {
  const SoundSelectionDecisionButton(
      {super.key,
        this.onTap,
        this.text = '決定',
        this.maxWidth = 200.0,
        this.maxHeight = 80.0});

  final void Function()? onTap;
  final String text;
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
        minimumSize: MaterialStateProperty.all(Size(maxWidth, maxHeight)),
      ),
      onPressed: onTap,
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              BaseColor.confirmBtnFrom,
              BaseColor.confirmBtnTo,
            ],
          ),
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(
              color: BaseColor.dropShadowColor,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: BaseColor.someTextPopupArea,
              fontSize: BaseFont.font22px,
              fontFamily: BaseFont.familySub,
            ),
          ),
        ),
      ),
    );
  }
}
