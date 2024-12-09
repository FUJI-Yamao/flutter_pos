/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../regs/checker/rcsyschk.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../component/w_trainingModeText.dart';
import '../../../language/l_languagedbcall.dart';
import '../component/w_full_self_amount_row.dart';
import '../component/w_full_self_topbar.dart';
import '../controller/c_full_self_pay_complete_controller.dart';
import '../controller/c_full_self_register_controller.dart';

/// フルセルフのIDとQuicpPay共有支払い画面
class FullSelfIDQuicpPayPage extends StatelessWidget {
  final String title;

  //訓練モード判定
  final  bool isTrainingMode = RcSysChk.rcTROpeModeChk();

  // キャンセルを押したときの処理
  final Function? onCancelPressed;

  FullSelfIDQuicpPayPage(
      {super.key, required this.title, this.onCancelPressed});

  //フルセルフ商品登録のコントローラ
  final FullSelfRegisterController selfCtrl =
      Get.find<FullSelfRegisterController>();

  // 支払い完了時のコントローラ
  final FullSelfPayCompleteController completeCtrl =
      Get.put(FullSelfPayCompleteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Obx(()=>FullSelfTopGreyBar(
              title: completeCtrl.complete.value ? "$title完了しました" :title)
              ),
            const SizedBox(
              height: 20,
            ),
            FullSelfAmountBlackContainer(
              height: 80,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        'l_full_self_total_amount'.trns,
                        style: const TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Obx(
                      () => FullSelfAmountRow(
                        label: 'l_full_self_sum'.trns,
                        value: '¥ ${selfCtrl.totalAmount.value}',
                        isTotal: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 100),
            Center(
              child: Column(
                children: [
                  Obx(() => Text(
                    completeCtrl.complete.value ?
                    'l_full_self_thank_you'.trns
                    :'l_full_self_tap_card'.trns,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 5, 7, 8),
                      fontSize: 32,
                    ),
                  ),
                  )
                ],
              ),
            ),
          ],
        ),
        //右上のキャンセルボタン.支払い完了時は非表示
        Obx(() =>Visibility(
          visible: !completeCtrl.complete.value,
          child: Positioned(
          right: 5.w,
          top: 5.h,
          child: SoundTextButton(
            onPressed: () {
              if (onCancelPressed != null) {
                onCancelPressed!();
              } else {
                Get.back();
              }
            },
            callFunc: runtimeType.toString(),
            child: Row(
              children: <Widget>[
                const Icon(Icons.close,
                    color: BaseColor.someTextPopupArea, size: 45),
                SizedBox(
                  width: 10.w,
                ),
                Obx(() => Text(
                  'l_full_self_back'.trns,
                  style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font18px),
                ),),
              ],
            ),
          )),
        )),
        //訓練モードの時表示する半透明テキスト
        if(isTrainingMode) TrainingModeText(),
      ],
    ),);
  }
}
