/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/w_inputbox.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_keypresed_controller.dart';

///JANコードと売価変更の入力エリア
class MKeyPressWidget extends StatelessWidget {
  ///入力されたメカキー値
  final String keyValue;

  ///決定ボタン押された処理
  final VoidCallback onConfirm;

  ///手入力モード
  final MKInputMode currentMode;

  ///コントローラ
  final keyPressCtrl = Get.find<KeyPressController>();

  MKeyPressWidget(
      {super.key,
      required this.keyValue,
      required this.onConfirm,
      required this.currentMode});

  final funcKeyInputKey = GlobalKey<InputBoxWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 10),
      child: Container(
        width: 520.w,
        padding: EdgeInsets.only(
          right: 10.w,
        ),
        height: 50.h,
        color: currentMode == MKInputMode.priceChange
            ? Colors.lightBlue[800]
            : Colors.lightBlue[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            switch (currentMode) {
              MKInputMode.normal => Text(
                  keyValue,
                  style: const TextStyle(
                    fontSize: BaseFont.font18px,
                    color: BaseColor.baseColor,
                  ),
                ),
              MKInputMode.waitingSecond => keyValue.isEmpty
                  ? const Text(
                      '2段バーコード入力待ち',
                      style: TextStyle(
                        fontSize: BaseFont.font24px,
                        color: BaseColor.baseColor,
                      ),
                    )
                  : Text(
                      keyValue,
                      style: const TextStyle(
                        fontSize: BaseFont.font18px,
                        color: BaseColor.baseColor,
                      ),
                    ),
              MKInputMode.priceChange => keyValue.isEmpty
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(
                            '売価変更',
                            style: TextStyle(
                              fontSize: BaseFont.font18px,
                              color: BaseColor.someTextPopupArea,
                            ),
                          ),
                          SizedBox(width: 60.0),
                          Text(
                            '商品をスキャンまたはプリセットをタッチ',
                            style: TextStyle(
                              fontSize: BaseFont.font18px,
                              color: BaseColor.someTextPopupArea,
                            ),
                          ),
                        ])
                  : Text(
                      keyValue,
                      style: const TextStyle(
                        fontSize: BaseFont.font18px,
                        color: BaseColor.someTextPopupArea,
                      ),
                    ),
            },
            if (currentMode != MKInputMode.waitingSecond &&
                    currentMode != MKInputMode.priceChange ||
                keyValue.isNotEmpty)
              SoundElevatedButton(
                onPressed: onConfirm,
                callFunc: runtimeType.toString(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColor.someTextPopupArea,
                ),
                child: const Text(
                  '決定',
                  style: TextStyle(
                    fontSize: BaseFont.font14px,
                    color: BaseColor.baseColor,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
