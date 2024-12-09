/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


/// ラベル/ボタン用Widget

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../model/m_widgetsetting.dart';
import 'w_sound_buttons.dart';

/// スイッチのラベル部分のWidget
class SwitchLabelWidget extends StatelessWidget {
  const SwitchLabelWidget({
    super.key,
    required this.setting, required this.switchSetting,
  });
  final Rx<LblSetting> setting;
  final SwitchSetting switchSetting;

  @override
  Widget build(BuildContext context) {
    int maxFontNum = 12;
    return Obx(
          () =>
      SoundInkWell(
        onTap: () {
          setting.value.isSelectedKey = true;
          setting.value.onTap?.call();
        },
        callFunc: runtimeType.toString(),
        child: Container(
          margin: setting.value.margin,
          alignment: setting.value.alignment,
          padding: setting.value.padding,
          height: ScreenUtil().setHeight(setting.value.height),
          width: ScreenUtil().setWidth(setting.value.width),
          decoration: BoxDecoration(
            color: setting.value.backcolor, // .withOpacity(0.3)
            borderRadius: BorderRadius.circular(7),
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
          child: Obx(() =>Text(
            '${setting.value.text} : ${switchSetting.switched.value}',
            maxLines: setting.value.text.length <= maxFontNum ? 1 : 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: setting.value.textcolor,
              fontSize: setting.value.fontsize,
              fontWeight: FontWeight.w400,
              height: 1 + (6 / setting.value.fontsize),
            ),
          ),),
        ),
      ),
    );
  }
}
