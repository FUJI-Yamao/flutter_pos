/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../language/l_languagedbcall.dart';
import '../controller/c_full_self_footer_lower_buttons_controller.dart';
import '../enum/e_full_self_kind.dart';
import '../model/m_full_self_navigation_button_info.dart';

/// フルセルフ画面のフッターの下部にあるボタン
class FullSelfFooterLowerButtons extends StatelessWidget{
  const FullSelfFooterLowerButtons({
    super.key,
    required this.fullSelfKind,
  });

  /// フルセルフの画面の種類
  final DisplayingFooterFullSelfKind fullSelfKind;

  @override
  Widget build(BuildContext context) {
    // フルセルフ画面のフッターの下部にあるボタンのコントローラー
    FullSelfFooterLowerButtonsController controller = Get.put(FullSelfFooterLowerButtonsController());

    /// ボタン情報のリスト
    List<FullSelfNavigationButtonInfo> buttonInfoList = controller.getButtonInfo(fullSelfKind);
    return Row(
      children: [
        for (int i = 0; i < buttonInfoList.length; i++)
          Expanded(
            // TODO: 7月末の検定において非表示の項目がある。最終的には全て表示？
            child: Visibility(
              visible: buttonInfoList[i].isVisible,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: Stack(
                children: [
                  Container(
                    height: 72.0,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: BaseColor.edgeBtnColor,),
                      color: BaseColor.someTextPopupArea,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          buttonInfoList[i].iconKind,
                          color: BaseColor.edgeBtnColor,
                        ),
                        Container(
                          height: 28,
                          alignment: Alignment.center,
                          child: Obx(() => AutoSizeText(
                            buttonInfoList[i].buttonName.trns,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: BaseFont.font14px,
                              height: 1.2,
                            ),
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SoundInkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            buttonInfoList[i].onTapCallback();
                          },
                          callFunc: runtimeType.toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}