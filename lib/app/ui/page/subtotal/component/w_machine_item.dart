/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../lib/apllib/apllib_auto_staffpw.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../socket/model/customer_socket_model.dart';
import '../../../socket/server/semiself_socket_server.dart';
import '../../full_self/controller/c_full_self_start_controller.dart';
import '../../full_self/page/p_full_self_select_pay_page.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../../register/model/m_registermodels.dart';
import '../controller/c_payment_controller.dart';

///小計画面 精算機選択widget
class MachineSection extends StatelessWidget {
  final RegisterBodyController bodyctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 536.w,
          height: 32.h,
          color: BaseColor.baseColor,
          child: const Center(
            child: Text(
              '精算機の選択',
              style: TextStyle(
                fontSize: BaseFont.font18px,
                color: BaseColor.someTextPopupArea,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
        Container(
          width: 536.w,
          height: 190.h,
          color: BaseColor.someTextPopupArea,
          child: Padding(
              padding: const EdgeInsets.only(right: 26, top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int i = 0; i <= 2; i++)
                    Padding(
                      padding: EdgeInsets.only(right: i == 0 ? 0 : 8.w),
                      child: Obx(
                        () => MachineItem(
                          no: i,
                          title: bodyctrl.payMachineStatus[i].title,
                          idx: bodyctrl.payMachineStatus[i].idx,
                          nearstate: bodyctrl.payMachineStatus[i].nearstate,
                          state: bodyctrl.payMachineStatus[i].state,
                          uuid: 1111,
                          function: bodyctrl.payMachineStatus[i].function,
                        ),
                      ),
                    ),
                ],
              )),
        ),
      ],
    );
  }
}

///小計画面 精算機アイテム
class MachineItem extends StatelessWidget {
  ///精算機番号
  final int no;

  ///精算機インデックス
  final RxInt idx;

  ///　タイトル
  final RxString title;

  ///　ステータス
  final RxString state;

  ///精算機ニアエンド
  final RxString nearstate;

  /// ボタンを押したときのリアクション
  final Function function;

  final int uuid;

  ///　コンストラクタ
  const MachineItem({
    super.key,
    required this.no,
    required this.idx,
    required this.title,
    required this.state,
    required this.nearstate,
    required this.uuid,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      ///コンテナカラー
      Color containerColor = BaseColor.attentionColor;
      Color borderColor = BaseColor.attentionColor;

      ///テキストカラー
      Color textColor = BaseColor.someTextPopupArea;
      double opacity = 1.0;

      //動的コンテナー、テキストの色を設定
      if (idx == PaymentStatus.pause.idx || idx == PaymentStatus.use.idx) {
        textColor = BaseColor.attentionColor;
        containerColor = BaseColor.registDiscountBackColor;
        opacity = 0.4;
      } else if (idx == PaymentStatus.standby.idx) {
        textColor = BaseColor.someTextPopupArea;
        containerColor = BaseColor.accentsColor;
        borderColor = BaseColor.transparent;
      }


      return Obx(() => Opacity(
        opacity: opacity,
        child: Container(
          width: 112.w,
          height: 112.h,
          child: Stack(
            children: [
              Opacity(
                opacity: opacity,
                child: Container(
                  decoration: BoxDecoration(
                    color: BaseColor.newBaseColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: BaseColor.accentsColor.withOpacity(0.8), width: 1.w),
                    boxShadow: [
                      BoxShadow(
                        color: BaseColor.dropShadowColor.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Container(
                    alignment: Alignment.center,
                    width: 80.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      border: Border.all(color: borderColor, width: 1.w),
                    ),
                    child: Text(
                      state.value,
                      style: TextStyle(
                        color: textColor,
                        fontSize: BaseFont.font14px,
                        fontFamily: BaseFont.familySub,
                      ),
                    ),
                  ),
                ),
              ),
              if (idx != PaymentStatus.standby.idx)
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 32.h),
                    child: Container(
                      alignment: Alignment.center,
                      width: 80.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: BaseColor.baseColor,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Text(
                        nearstate.value,
                        style: TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font14px,
                          fontFamily: BaseFont.familyDefault,
                        ),
                      ),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: opacity,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Text(
                      title.value,
                      style: const TextStyle(
                        fontSize: BaseFont.font34px,
                        fontFamily: BaseFont.familySub,
                        color: BaseColor.baseColor,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: BaseColor.transparent,
                  child: SoundInkWell(
                    onTap: () {
                      if (state.value == PayStatusInfo.standby.status) {
                        function(no + 1);
                      }
                    },
                    child: null,
                    callFunc: runtimeType.toString(),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    });
  }
}
