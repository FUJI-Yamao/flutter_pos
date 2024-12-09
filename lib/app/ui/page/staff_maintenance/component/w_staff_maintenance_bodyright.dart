/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/number_util.dart';
import '../../full_self/controller/c_full_self_register_controller.dart';
import '../controller/c_staff_maintenance_controller.dart';

/// メンテナス画面商品点数・概算合計表示エリア
class AmountQtyArea extends StatelessWidget {
  ///メンテナンス画面のコントローラ
  final StaffMaintenanceController staffMaintenanceController =
  Get.find<StaffMaintenanceController>();

  ///フルセルフの商品登録画面のコントローラー
  final FullSelfRegisterController fullSelfRegisterController =
  Get.find<FullSelfRegisterController>();

  AmountQtyArea(
      {super.key,
        required StaffMaintenanceController staffMaintenanceController,
        required FullSelfRegisterController fullSelfRegisterController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
          EdgeInsets.only(top: 24.h, right: 10.w, left: 10.w, bottom: 10.h),
          width: 268.w,
          height: 132.h,
          color: BaseColor.baseColor,
          padding: EdgeInsets.all(16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRow('商品点数', '0 点'),
              SizedBox(height: 35.h),
              _buildRow(
                  '合計',
                  NumberFormatUtil.formatAmount(
                      staffMaintenanceController.currentTotalAmount.value)),
            ],
          ),
        ),
        ///TODO: テンキー現行実装不要
        // Padding(
        //   padding: EdgeInsets.only(top: 18.h),
        //   child: Container(
        //     width: 280.w,
        //     height: 500.w,
        //     color: BaseColor.maintainBaseColor,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         InputBoxWidget(
        //           key: staffMaintenanceController.inputBoxKey,
        //           width: 270.w,
        //           height: 50.h,
        //           fontSize: BaseFont.font22px,
        //           textAlign: TextAlign.right,
        //           padding: EdgeInsets.only(right: 32.w),
        //           cursorColor: BaseColor.baseColor,
        //           unfocusedBorder: BaseColor.accentsColor,
        //           focusedColor: BaseColor.inputBaseColor,
        //           borderRadius: 4,
        //           funcBoxTap: () {
        //             staffMaintenanceController.onInputBoxTap();
        //           },
        //           iniShowCursor: true,
        //           mode: InputBoxMode.payNumber,
        //         ),
        //         SizedBox(height: 10.h),
        //         Obx(() {
        //           return staffMaintenanceController.showRegisterTenkey.value
        //               ? RegisterTenkey(
        //               onKeyTap: staffMaintenanceController.inputKeyType)
        //               : Container();
        //         }),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

/// 商品点数と合計エリア
  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(label,
            style: const TextStyle(
                fontFamily: BaseFont.familyDefault,
                fontSize: BaseFont.font18px,
                color: BaseColor.someTextPopupArea)),
        value.endsWith('点')
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value.replaceAll('点', ''),
              style: const TextStyle(
                  fontFamily: BaseFont.familyNumber,
                  fontSize: BaseFont.font28px,
                  color: BaseColor.someTextPopupArea),
            ),
            const Text(
              '点',
              style: TextStyle(
                  fontFamily: BaseFont.familyDefault,
                  fontSize: BaseFont.font18px,
                  color: BaseColor.someTextPopupArea),
            ),
          ],

        )
            : Text(
          value,
          style: const TextStyle(
              fontFamily: BaseFont.familyNumber,
              fontSize: BaseFont.font28px,
              color: BaseColor.someTextPopupArea),
        ),
      ],
    );
  }
}
