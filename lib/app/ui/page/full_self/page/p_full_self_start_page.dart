/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../regs/checker/rcsyschk.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/hidden_button.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../component/w_trainingModeText.dart';
import '../../../language/l_languagedbcall.dart';
import '../../../socket/model/customer_socket_model.dart';
import '../component/w_full_self_footer.dart';
import '../controller/c_full_self_start_controller.dart';
import '../enum/e_full_self_kind.dart';

/// フルセルフのスタート画面
class FullSelfStartPage extends StatelessWidget {
  FullSelfStartPage(AutoStaffInfo autoStaffInfo, {super.key})
      : controller = Get.put(FullSelfStartController(autoStaffInfo));

  /// フルセルフのスタート画面のコントローラー
  final FullSelfStartController controller;

  //訓練モード判定
  final bool isTrainingMode = RcSysChk.rcTROpeModeChk();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: BaseColor.customerPageBackGroundColor,
            child: Column(
              children: [
                // タイトルバー
                Container(
                  height: 112.0,
                  width: double.infinity,
                  color: BaseColor.fullSelfStartPageUpperTitleBar,
                  child: Center(
                    child: Obx(() => Text(
                      'l_full_self_checkout_title'.trns,
                      style: const TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font40px,
                      ),
                    ),),
                  ),
                ),
                // タイトルバー
                Container(
                  height: 56.0,
                  width: double.infinity,
                  color: BaseColor.baseColor.withOpacity(0.7),
                  child: Center(
                    child: Obx(() => Text(
                      'l_full_self_start_guidance'.trns,
                      style: const TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font24px,
                      ),
                    ),),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        // タイトルバーとお買いものスタートボタンの間の余白
                        const SizedBox(height: 80.0),
                        // お買いものスタートボタン
                        Stack(
                          children: [
                            Container(
                              height: 240.0,
                              width: 360.0,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: BaseColor.edgeBtnColor,),
                                color: BaseColor.someTextPopupArea,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.play_arrow,
                                    size: 120.0,
                                    color: BaseColor.edgeBtnColor,
                                  ),
                                  const SizedBox(height: 24.0,),
                                  Obx(() => Text(
                                    'l_full_self_start'.trns,
                                    style: const TextStyle(
                                      fontSize: BaseFont.font24px,
                                    ),
                                  ),),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: SoundInkWell(
                                  borderRadius: BorderRadius.circular(8.0),
                                  onTap: () {
                                    controller.toRegister();
                                  },
                                  callFunc: runtimeType.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        // カメラ画像とボタン
                        const FullSelfFooter(
                          fullSelfKind: DisplayingFooterFullSelfKind.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 隠しボタン
          HiddenButton(
            onTap: () => controller.toMaintenance(),
            alignment: Alignment.topLeft,
          ),
          // 隠しボタン
          HiddenButton(
            onTap: () => controller.toMainManu(),
            alignment: Alignment.topRight,
          ),
          //訓練モードの時表示する半透明テキスト
          if (isTrainingMode) TrainingModeText(),
        ],
      )
    );
  }
}