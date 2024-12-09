/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/page/search_registration/enum/e_registration_input_enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../colorfont/c_basecolor.dart';
import '../../component/w_sound_buttons.dart';
import '../common/basepage/common_base.dart';
import '../../controller/c_drv_controller.dart';
import 'controller/c_registration_scan_ctrl.dart';


/// 検索登録スキャン画面
class RegistrationScanPageWidget extends CommonBasePage with RegisterDeviceEvent{

  ///コンストラクタ
  RegistrationScanPageWidget({super.key, required super.title, required super.funcKey}){

    /// registrationEventを呼び出す
    registrationEvent();
  }

  ///コントローラー(仮)
  RegistrationScanController registScanCtrl = Get.put(RegistrationScanController());

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
        children: [
          Container(
              color: BaseColor.someTextPopupArea,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'レシートのバーコードを読み込んでください',
                      style: TextStyle(
                          fontSize: BaseFont.font28px, color: BaseColor.baseColor),
                    ),
                    SizedBox(
                      height: 88.h,
                    ),
                    SvgPicture.asset(
                      'assets/images/illust_scanning.svg',
                      width: 480.w,
                      height: 276.h,
                    ),
                    SizedBox(
                      height: 88.h,
                    ),
                    SizedBox(
                        width: 344.w,
                        height: 80.h,
                        child: SoundElevatedButton(
                          onPressed: () {
                            List<RegistrationInputFieldLabel> labels =
                            registScanCtrl.commonLabels;
                            Get.toNamed('/registrationinputpage',arguments: [title,labels,funcKey]);
                          },
                          callFunc: runtimeType.toString(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BaseColor.scanButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            shadowColor: BaseColor.scanBtnShadowColor,
                            elevation: 3,
                          ),
                          child: const Text(
                            'スキャンできない場合',
                            style: TextStyle(
                              fontSize: BaseFont.font22px,
                              color: BaseColor.someTextPopupArea,
                            ),
                          ),
                        ))
                  ],
                ),
              ))
        ]);
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.receiptVoid;
  }
}
