/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_full_self_register_controller.dart';

/// フルセルフ支払方法のボタン
class FullSelfPaymentButton extends StatelessWidget {

  //プリセット定義
  final PresetInfo presetData;

  ///ボタンのアイコン
 // final String iconPath;


  ///ボタンを押下する処理
 final VoidCallback? onPressed;

  ///コントローラー
  final FullSelfRegisterController selfCtrl =
      Get.find<FullSelfRegisterController>();


  ///コンストラクタ
  FullSelfPaymentButton({
    super.key,
    //required this.iconPath,
    required this.onPressed,
    required this.presetData,
  });

  @override
  Widget build(BuildContext context) {
    return SoundElevatedButton(
      //todo: 支払い方法押された挙動
        onPressed: () => onPressed?.call(),
        callFunc: '${runtimeType.toString()} presetData.kyName ${presetData.kyName}',
        style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.someTextPopupArea,
            fixedSize: const Size(100, 50),
            elevation: 5,
            shadowColor: BaseColor.scanBtnShadowColor,
            side: BorderSide(color: BaseColor.baseColor, width: 1.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //todo:現状アイコンなし
            // SvgPicture.asset(
            //   iconPath,
            // ),
            // SizedBox(height: 10.h),
            Text(
              presetData.kyName,
              style: const TextStyle(
                fontSize: BaseFont.font22px,
                color: BaseColor.baseColor,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ],
        ));
  }
}
