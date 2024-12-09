/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../colorfont/c_basecolor.dart';
import '../controller/c_registerbody_controller.dart';
import '../model/m_registermodels.dart';
import '/app/ui/colorfont/c_basefont.dart';

/// 精算機選択widget
class SelectQcashierWidget extends StatelessWidget {
  /// コンストラクタ
  const SelectQcashierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ///コントローラー
    final RegisterBodyController bodyctrl = Get.find();
    return Container(
      width: 364.w,
      height: 56.h,
      margin: EdgeInsets.only(top: 12.h, right: 12.w),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.end,
        direction: Axis.horizontal,
        children: [
          for (int i = 0; i <= 2; i++)
            Padding(
              padding: EdgeInsets.only(left: i == 0 ? 0 : 8.w),
              child: Obx(
                () => Qcashier(
                  no: i,
                  title: bodyctrl.payMachineStatus[i].title,
                  idx: bodyctrl.payMachineStatus[i].idx,
                  nearstate: bodyctrl.payMachineStatus[i].nearstate,
                  state: bodyctrl.payMachineStatus[i].state,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 精算機1枠分のWidget
class Qcashier extends StatelessWidget {
  ///コンストラクタ
  const Qcashier({
    super.key,
    required this.no,
    required this.idx,
    required this.title,
    required this.nearstate,
    required this.state,
  });

  ///精算機番号
  final no;

  ///精算機インデックス
  final RxInt idx;

  ///精算機タイトル
  final RxString title;

  ///精算機ニアエンド
  final RxString nearstate;

  ///精算機ステータス
  final RxString state;

  @override
  Widget build(BuildContext context) {

    return Obx(() {

    /// マシン背景色
    final containerColor = (idx == PaymentStatus.pause.idx ||
            idx == PaymentStatus.use.idx ||
            idx == PaymentStatus.nearend.idx)
        ? BaseColor.dividerColor
        : BaseColor.baseColor; //待機中
    return Container(
      width: 80.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: containerColor,
      ),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.vertical,
        children: [
          Text(
            title.value,
            style: const TextStyle(
                fontSize: BaseFont.font14px,
                color: BaseColor.someTextPopupArea,
                fontFamily: BaseFont.familySub),
          ),
          Container(
            alignment: Alignment.center,
            width: 75.w,
            height: 18.h,
            decoration: const BoxDecoration(
              color: BaseColor.baseColor,
            ),
            child: Text(
              nearstate.value,
              style: const TextStyle(
                  fontSize: BaseFont.font14px,
                  color: BaseColor.someTextPopupArea,
                  fontFamily: BaseFont.familySub),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.5.h),
            alignment: Alignment.center,
            width: 75.w,
            height: 18.h,
            decoration: BoxDecoration(
                color: (idx == PaymentStatus.standby.idx)
                    ? BaseColor.newMainColor
                    : BaseColor.registDiscountBackColor),
            child: Text(
              state.value,
              style: TextStyle(
                  fontSize: BaseFont.font14px,
                  fontFamily: BaseFont.familySub,
                  color: (idx == PaymentStatus.standby.idx)
                      ? BaseColor.accentsColor
                      : BaseColor.attentionColor),
            ),
          ),
        ],
      ),
    );
    });

  }
}
