/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_pos/app/ui/page/full_self/controller/c_full_self_register_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'component/w_staff_maintenance_bodyleft.dart';
import '../../../regs/checker/rc_key_cash4demo.dart';
import '../../component/w_sound_buttons.dart';
import 'component/w_staff_maintenance_bodyright.dart';
import 'controller/c_staff_maintenance_controller.dart';
///従業員メンテナンス画面
class StaffMaintenancePage extends StatelessWidget {
  ///メンテナンス画面のコントローラ
  final staffMaintenanceController = Get.put(StaffMaintenanceController());

  ///フルセルフの商品登録画面のコントローラー
  // todo: フルセルフ実装時に put 場所の見直しをする
  final fullSelfRegisterController = Get.put(FullSelfRegisterController());

  ///呼び出しクラス名
  String className = 'StaffMaintenancePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BaseColor.GrdBdrButtonEndColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'メンテナンス',
              style: TextStyle(
                  fontFamily: BaseFont.familyDefault,
                  fontSize: BaseFont.font20px,
                  color: BaseColor.someTextPopupArea),
            ),
            Container(
              width: 288.w,
              height: 40.h,
              alignment: Alignment.center,
              padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                border:
                Border.all(color: BaseColor.someTextPopupArea, width: 1.w),
              ),
              child: const Text(
                '登録中',
                style: TextStyle(
                    fontFamily: BaseFont.familyDefault,
                    fontSize: BaseFont.font20px,
                    color: BaseColor.someTextPopupArea),
              ),
            ),
            Row(
              children: <Widget>[
                SoundTextButton(
                  onPressed: () {
                    RcKeyCashDemo.isCancel = true;
                    Get.back();
                  },
                  callFunc: className,
                  child: Row(
                    children: <Widget>[
                       Icon(Icons.close,
                          color: BaseColor.someTextPopupArea, size: 45.h),
                       SizedBox(
                        width: 19.w,
                      ),
                      Text('とじる'.trns,
                          style: const TextStyle(
                              fontFamily: BaseFont.familyDefault,
                              fontSize: BaseFont.font18px,
                              color: BaseColor.someTextPopupArea)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: BaseColor.maintainBaseColor,
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: FunctionButtonsGrid(),
            ),
            Expanded(
              flex: 1,
              child: AmountQtyArea(
                staffMaintenanceController: staffMaintenanceController,
                fullSelfRegisterController: fullSelfRegisterController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
