/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../../regs/inc/rc_crdt.dart';
import '../../../colorfont/c_basefont.dart';
import '../controller/c_credit_declaration_controller.dart';
import '../model/m_creditpaymentmethodmodels.dart';
import '../p_credit_installment_setting_page.dart';

/// クレジット支払方法ボタン
class CreditPaymentMethodItem extends StatelessWidget {
  /// クレジット取引の支払方法
  final CreditPaymentMethod creditPaymentMethod;
  /// クレジット宣言画面のコントローラ
  final CreditPaymentController creditDeclarationCtrl = Get.find();

  ///コンストラクタ
  CreditPaymentMethodItem({
    super.key,
    required this.creditPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 144.w,
        height: 56.h,
        child: SoundElevatedButton(
          onPressed: () async {
            // 選択した支払方法の情報を保持する
            debugPrint('${creditPaymentMethod.paymentMethodName} pushed');
            // 支払方法の種別
            creditDeclarationCtrl.selectPaymentType.value = creditPaymentMethod.paymentType;
            // 支払方法の名称
            creditDeclarationCtrl.paymentMethod.value = creditPaymentMethod.paymentMethodName;
            // 支払方法詳細１の見出し
            creditDeclarationCtrl.paymentDetailTopic1.value = creditPaymentMethod.paymentDetailTopic1;
            // 支払方法詳細１の内容
            creditDeclarationCtrl.paymentDetailContent1.value = creditPaymentMethod.paymentDetailContent1;
            // 支払方法詳細２の見出し
            creditDeclarationCtrl.paymentDetailTopic2.value = creditPaymentMethod.paymentDetailTopic2;
            // 支払方法詳細２の内容
            creditDeclarationCtrl.paymentDetailContent2.value = creditPaymentMethod.paymentDetailContent2;
            // 支払方法選択時の処理を呼び出し
            await TchKeyDispatch.rcPre104CrdtProc(creditPaymentMethod.orgCode);
            // 分割払いの場合
            if (creditPaymentMethod.orgCode == RcCrdt.DIVIDE) {
              // 支払回数リストの取得

              creditDeclarationCtrl.setInstallmentNumbers(creditDeclarationCtrl.getInstallmentList(creditPaymentMethod.orgCode));
              // 選択回数の設定画面
              Get.to(() => CreditInstallmentSettingPage(creditDeclarationCtrl, title: "分割回数設定"));
              return;
            }
            // クレジット宣言画面の状態
            creditDeclarationCtrl.setCreditPaymentStatus(CreditProcessState.confirmPayment);
          },
          callFunc: '${runtimeType.toString()} creditPaymentMethod.paymentMethodName ${creditPaymentMethod.paymentMethodName}',
          style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.scanButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            shadowColor: BaseColor.scanBtnShadowColor,
            elevation: 3,
          ),
          child: Text(
            creditPaymentMethod.paymentMethodName,
            style: const TextStyle(
              fontSize: BaseFont.font18px,
              color: BaseColor.someTextPopupArea,
            ),
          ),
        ));
  }
}
