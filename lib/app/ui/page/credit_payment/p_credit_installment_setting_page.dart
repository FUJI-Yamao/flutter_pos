/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../regs/checker/rc_touch_key.dart';
import '../../../regs/inc/rc_crdt.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import 'component/w_credit_installment_number_item.dart';
import 'controller/c_credit_declaration_controller.dart';

/// 動作概要： クレジットカードによる支払の分割回数を設定する
/// 起動方法： Get.to(() => CreditInstallmentSettingPage(creditPaymentCtrl, title: title)); など
/// 処理結果：

/// クレジット取引の分割回数設定ページ
class CreditInstallmentSettingPage extends CommonBasePage {
  CreditInstallmentSettingPage(
    this.creditPaymentCtrl, {
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
          String className = 'CreditInstallmentSettingPage';
          return <Widget>[
            SoundTextButton(
              onPressed: () async {
                await TchKeyDispatch.rcPre104CrdtProc(RcCrdt.KEY_PAYPREV);
                Get.back();
              },
              callFunc: '$className ${'l_cmn_cancel'.trns}',
              child: Row(
                children: <Widget>[
                  const Icon(Icons.close,
                      color: BaseColor.someTextPopupArea, size: 45),
                  SizedBox(
                    width: 19.w,
                  ),
                  Text('l_cmn_cancel'.trns,
                      style: const TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px)),
                ],
              ),
            ),
          ];
        });

  final CreditPaymentController creditPaymentCtrl;

  @override
  Widget buildBody(BuildContext context) {
    return CreditInstallmentSettingWidget(
      backgroundColor: backgroundColor,
      creditPaymentCtrl: creditPaymentCtrl,
    );
  }
}

class CreditInstallmentSettingWidget extends StatefulWidget {
  final Color backgroundColor;
  final CreditPaymentController creditPaymentCtrl;

  const CreditInstallmentSettingWidget(
      {super.key,
      required this.backgroundColor,
      required this.creditPaymentCtrl});

  @override
  CreditInstallmentSettingState createState() =>
      CreditInstallmentSettingState();
}

class CreditInstallmentSettingState
    extends State<CreditInstallmentSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: const Center(
            child: Text(
              textAlign: TextAlign.center,
              '分割回数を選択してください',
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 36,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: 1000.w,
                height: 192,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          for (int i = 0;
                              i <=
                                  widget.creditPaymentCtrl.insListFirstStageNum
                                      .value;
                              i++) ...{
                            CreditInstallmentNumberItem(
                                creditInstallmentNumber: widget
                                    .creditPaymentCtrl.installmentList[i]),
                            i ==
                                    widget.creditPaymentCtrl
                                        .insListFirstStageNum.value
                                ? const SizedBox.shrink()
                                : const SizedBox(width: 16)
                          }
                        ],
                      ),
                      widget.creditPaymentCtrl.installmentList.length >
                              CreditPaymentController.maxHorizontal
                          ? Row(
                              children: [
                                for (int i =
                                        CreditPaymentController.maxHorizontal;
                                    i <=
                                        widget.creditPaymentCtrl
                                            .insListSecondStageNum.value;
                                    i++) ...{
                                  CreditInstallmentNumberItem(
                                      creditInstallmentNumber: widget
                                          .creditPaymentCtrl
                                          .installmentList[i]),
                                  i ==
                                          widget.creditPaymentCtrl
                                              .installmentList.length
                                      ? const SizedBox.shrink()
                                      : const SizedBox(width: 16)
                                }
                              ],
                            )
                          : const SizedBox.shrink(),
                      widget.creditPaymentCtrl.installmentList.length >
                              CreditPaymentController.maxHorizontal * 2
                          ? Row(
                              children: [
                                for (int i =
                                        CreditPaymentController.maxHorizontal *
                                            2;
                                    i <=
                                        widget.creditPaymentCtrl.installmentList
                                                .length -
                                            1;
                                    i++) ...{
                                  CreditInstallmentNumberItem(
                                      creditInstallmentNumber: widget
                                          .creditPaymentCtrl
                                          .installmentList[i]),
                                  i ==
                                          widget.creditPaymentCtrl
                                              .installmentList.length
                                      ? const SizedBox.shrink()
                                      : const SizedBox(width: 16)
                                }
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
