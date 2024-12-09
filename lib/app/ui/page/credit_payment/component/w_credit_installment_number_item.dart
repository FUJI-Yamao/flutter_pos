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
import '../../../colorfont/c_basefont.dart';
import '../controller/c_credit_declaration_controller.dart';
import '../model/m_credit_installment_number_models.dart';

/// 分割払い回数ボタン
class CreditInstallmentNumberItem extends StatelessWidget {
  /// 分割払いの支払回数
  final CreditInstallmentNumber creditInstallmentNumber;
  /// クレジット宣言画面のコントローラ
  final CreditPaymentController creditDeclarationCtrl = Get.find();
  /// 回
  static const String numberUnit = '回';

  ///コンストラクタ
  CreditInstallmentNumberItem({
    super.key,
    required this.creditInstallmentNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 144.w,
        height: 56.h,
        child: SoundElevatedButton(
          onPressed: () async {
            debugPrint('TchKeyDispatch.rcPre104CrdtProc call (0x${creditInstallmentNumber.installmentPaymentCode.toRadixString(16)})');
            await TchKeyDispatch.rcPre104CrdtProc(creditInstallmentNumber.installmentPaymentCode);
            // クレジット宣言画面の状態
            creditDeclarationCtrl.setCreditPaymentStatus(CreditProcessState.confirmPayment);
            Get.back();
          },
          callFunc: '${runtimeType.toString()} creditInstallmentNumber.installmentNumber ${creditInstallmentNumber.installmentNumber.toString()}$numberUnit',
          style: ElevatedButton.styleFrom(
            backgroundColor: BaseColor.scanButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            shadowColor: BaseColor.scanBtnShadowColor,
            elevation: 3,
          ),
          child: Text(
            '${creditInstallmentNumber.installmentNumber.toString()}$numberUnit',
            style: const TextStyle(
              fontSize: BaseFont.font18px,
              color: BaseColor.someTextPopupArea,
              fontFamily: BaseFont.familySub,
            ),
          ),
        ));
  }
}
