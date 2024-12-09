/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// テキスト用Widget

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:get/get.dart';

/// テキスト用Widget
class TextBtnWidget extends StatelessWidget {
  const TextBtnWidget({
    super.key,
    required this.setting,
  });

  final setting;

  @override
  Widget build(BuildContext context) {
    if (setting == null) {
      return const SizedBox.shrink();
    } else {
      return Obx(() => SoundInkWell(
            onTap: setting.value.onTap ?? ()=>{},
            callFunc: runtimeType.toString(),
            child: Container(
              alignment: setting.value.alignment,
              height: setting.value.height,
              width: setting.value.width,
              decoration: BoxDecoration(
                  color: setting.value.backcolor,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: setting.value.shadowcolor, //色
                      spreadRadius: 2,
                      offset: Offset(-1, -1),
                    ),
                  ],
                  border:
                      Border.all(color: setting.value.bordercolor, width: 1)),
              child: Text(
                setting.value.text,
                style: TextStyle(
                  color: setting.value.textcolor,
                  fontSize: setting.value.fontsize,
                  letterSpacing: 2,
                ),
              ),
            ),
          ));
    }
  }
}
