/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_full_self_select_pay_controller.dart';

/// フルセルフの支払方法選択画面の上側のボタン
class SelectPayFooterUpperButtons extends StatelessWidget{
  const SelectPayFooterUpperButtons({super.key});

  @override
  Widget build(BuildContext context) {
    FullSelfSelectPayController controller = Get.find<FullSelfSelectPayController>();
    return SizedBox(
      height: 56.0,
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              '領収書をご希望の場合はチェックを入れてください',
              style: TextStyle(
                color: BaseColor.fullSelfRegisterPageToCheckButton,
                fontSize: BaseFont.font18px,
              ),
            ),
            const Icon(
              Icons.navigate_next,
              color: BaseColor.fullSelfRegisterPageToCheckButton,
            ),
            Stack(
              children: [
                Container(
                  height: 56.0,
                  width: 56.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: BaseColor.edgeBtnColor),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Obx(() {
                    if (controller.isChecked.value) {
                      return const Icon(
                        Icons.check,
                        size: 32.0, // デフォルトは14.0
                      );
                    } else {
                      return Container();
                    }
                  },),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: SoundInkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () => controller.changeCheckedFlg(),
                      callFunc: runtimeType.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } 
}