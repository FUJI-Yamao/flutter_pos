/*
* (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
* CONFIDENTIAL/社外秘
* 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';

import '../../../../colorfont/c_basecolor.dart';

/// プリセットカラー用のラジオボタン
class PresetColorSelectRadioButton extends StatelessWidget {
  final bool isSelected;

  const PresetColorSelectRadioButton({
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: BaseColor.someTextPopupArea, width: 4)
            : Border.all(color: BaseColor.radioButtonUnselectedColor, width: 1),
      ),
    );
  }
}