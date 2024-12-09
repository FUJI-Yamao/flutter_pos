/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../inc/apl/fnc_code.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../language/l_languagedbcall.dart';
import '../controller/c_full_self_register_controller.dart';

/// フルセルフの登録画面のフッター上側にあるバーコードがない商品ボタン、会計するボタン
class RegisterFooterUpperButtons extends StatelessWidget {
  const RegisterFooterUpperButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FullSelfRegisterController>(
        builder: (controller) {
        return Row(
          children: [
            const SizedBox(width: 8.0,),
            Expanded(
              // TODO: テスト用のボタン（Expanded(child: Container(),)が元の形）削除予定。
              child: kDebugMode
                    ? ElevatedButton(
                      onPressed: () => controller.funcTestButtonPushed(),
                      child: Text('(テスト用)商品仮登録'),
                    )
                  : Container(),
            ),
            const SizedBox(width: 8.0,),
            Expanded(
              // TODO: 7月末の検定において非表示。
              child: Visibility(
                visible: false,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Stack(
                  children: [
                    Container(
                      height: 56.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: BaseColor.fullSelfRegisterPageNoBarcodeButton,
                      ),
                      child: Center(
                        child: Obx(() => Text(
                          'l_full_self_no_barcode'.trns,
                          style: const TextStyle(
                            color: BaseColor.customerPageBaseTextColor,
                            fontSize: BaseFont.font18px,
                          ),
                        ),),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: SoundInkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          // バーコードがない商品ボタンを押したときの処理
                          onTap: () => controller.funcNoBarcodeItem(),
                          callFunc: runtimeType.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0,),
            Expanded(
              child: Visibility(
                    visible: controller.merchandiseDataList.isNotEmpty,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Stack(
                      children: [
                        Container(
                          height: 56.0,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: BaseColor.fullSelfRegisterPageToCheckButton,
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(child: Container(),),
                                Obx(() => Text(
                                  'l_full_self_to_payment'.trns,
                                  style: const TextStyle(
                                    color: BaseColor.someTextPopupArea,
                                    fontSize: BaseFont.font18px,
                                  ),
                                ),),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: BaseColor.someTextPopupArea,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: SoundInkWell(
                              borderRadius: BorderRadius.circular(8.0),
                              onTap: (){
                                // 小計キー押下.
                                TchKeyDispatch.rcDTchByFuncKey(
                                  FuncKey.KY_STL, null);
                              },
                              callFunc: runtimeType.toString(),
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
    );
  }
}