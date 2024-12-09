/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../model/m_widgetsetting.dart';
import 'w_sound_buttons.dart';

/// スイッチのボタン部分のWidget
class SwitchBtnWidget extends StatelessWidget {
  const SwitchBtnWidget({
    super.key,
    required this.setting,
  });

  final SwitchSetting setting;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: setting.value.containerWidth,
      width: 260,
      height: setting.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: setting.backcolor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Material(
                  type: MaterialType.button,
                  color: getBackColor(setting.isSwitchedOn.value),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(
                          color: getBackBorderColor(setting.isSwitchedOn.value),
                          width: 2)),
                  child: SoundInkWell(
                    onTap: setting.onTap,
                    callFunc: runtimeType.toString(),
                    child: SizedBox(
                      //width : setting.value.conBtnWidth,
                      width: 142,
                      height: setting.height,
                      child: Center(
                        child: Text(
                          setting.onText,
                          style: TextStyle(
                            fontSize: setting.fontsize,
                            fontWeight: FontWeight.w400,
                            color: getTextColor(setting.isSwitchedOn.value),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            Obx(
              () => Material(
                  type: MaterialType.button,
                  color: getBackColor(!setting.isSwitchedOn.value),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(
                          color:
                              getBackBorderColor(!setting.isSwitchedOn.value),
                          width: 2)),
                  child: SoundInkWell(
                    onTap: setting.onTap,
                    callFunc: runtimeType.toString(),
                    child: Container(
                      //width : setting.value.conBtnWidth,
                      width: 142,
                      height: setting.height,
                      child: Center(
                        child: Text(
                          setting.offText,
                          style: TextStyle(
                            fontSize: setting.fontsize,
                            fontWeight: FontWeight.w400,
                            color: getTextColor(!setting.isSwitchedOn.value),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Color getTextColor(bool on) {
    if (on) {
      return setting.pressedFontColor;
    }
    return setting.pressedFontColor.withOpacity(0.4);
  }

  Color getBackBorderColor(bool on) {
    if (on) {
      return setting.pressedBorderColor;
    }
    return setting.backcolor;
  }

  Color getBackColor(bool on) {
    if (on) {
      return setting.boxPressedColor;
    }
    return setting.backcolor;
  }
}
