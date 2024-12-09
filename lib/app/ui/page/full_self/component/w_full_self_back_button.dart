/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../regs/checker/rc_sound.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../language/l_languagedbcall.dart';
import '../controller/c_full_self_select_pay_controller.dart';
import '../controller/c_full_self_start_controller.dart';

/// フルセルフ戻るボタン、目次に戻るボタン
class FullSelfBackButton extends StatelessWidget {

  //フルセルフ支払い方法選択コントローラ
  final FullSelfSelectPayController selecPayCtrl = Get.find();

  //フルセルフスタートページコントローラ
  final FullSelfStartController startCtrl = Get.find();

@override
Widget build(BuildContext context) {
  return SoundElevatedButton(
    // iD QuicPay　支払い選択画面は電子マネーがある支払いページに戻る
    //　最初の支払い方法選択画面の場合は商品登録の画面に戻る
    onPressed: () {
      // ガイダンス音声の停止
      RcSound.stop();

      if (selecPayCtrl.isShowIDQuicPay.value) {
        selecPayCtrl.isShowIDQuicPay.value = false;
      } else {
        Get.until((route) => route.settings.name == '/FullSelfRegisterPage');
      }
    },
    callFunc: runtimeType.toString(),
    style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        backgroundColor: BaseColor.scanButtonColor,
        fixedSize: const Size(72, 96),
        elevation: 5,
        shadowColor: BaseColor.scanBtnShadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        )),
    child: Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/icon_back_fullself.svg',
          ),
          SizedBox(height: 10.h),
          Obx(() => FittedBox(
            alignment: Alignment.bottomRight,
            fit: BoxFit.scaleDown,
            child: Text(
              'l_full_self_back'.trns,
              style: const TextStyle(
                fontSize: 18,
                color: BaseColor.someTextPopupArea,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),),
        ],
      ),
    ),
  );
}}
