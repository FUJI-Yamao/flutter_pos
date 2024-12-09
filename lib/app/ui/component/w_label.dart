/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// ラベル/ボタン用Widget

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// ラベル/ボタン用Widget
class LabelBtnWidget extends StatelessWidget {
  const LabelBtnWidget({
    super.key,
    required this.setting,
  });

  final setting;

  @override
  Widget build(BuildContext context) {
    int maxFontNum = 12;
    return Obx(
      () => Stack(children: [
        Container(
          margin: setting.value.margin,
          alignment: setting.value.alignment,
          padding: setting.value.padding,
          height: ScreenUtil().setHeight(setting.value.height),
          width: ScreenUtil().setWidth(setting.value.width),
          decoration: BoxDecoration(
            color: setting.value.backcolor, // .withOpacity(0.3)
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: setting.value.shadowcolor,
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(2, 3),
              ),
            ],
            border: Border.all(
              color: setting.value.bordercolor,
              width: ScreenUtil().setWidth(2.0),
            ),
          ),
          child: Text(
            setting.value.text,
            maxLines: setting.value.text.length <= maxFontNum ? 1 : 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: setting.value.textcolor,
              fontSize: setting.value.fontsize,
              height: 1 + (6 / setting.value.fontsize),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: SoundInkWell(
              onTap: () {
                setting.value.isSelectedKey = true;
                setting.value.onTap?.call();
              },
              callFunc: runtimeType.toString(),
              child: null,
            ),
          ),
        )
      ]),

      // ),
    );
  }
}
