/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */



import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/model/m_widgetsetting.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'w_switch_label.dart';
import 'w_switch_btn.dart';

/// ラベル/スイッチボタン　2表示Widget
class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    super.key,
    required this.lblsetting,
    required this.switchsetting,
    required this.axis,
    required this.containsSwitch,
    this.flex = 5,
  });

  final Rx<LblSetting> lblsetting;
  final SwitchSetting switchsetting;
  final Rx<Axis> axis;
  final int flex;
  final bool containsSwitch;

  @override
  Widget build(BuildContext context) {
    int lastFlex = 10 - flex;
    return Container(
      height: 90,
      child:  Flex(
      direction: axis.value,
      children: [
        Expanded(
          flex: flex,
          child: SwitchLabelWidget(
            setting: lblsetting,
            switchSetting: switchsetting,
          ),
        ),
        const SizedBox(
          width: 150,
        ),
        Expanded(
          flex: lastFlex,
          child: SwitchBtnWidget(
            setting: switchsetting,
          ),
        )
      ],

    ),
    );
  }
}
