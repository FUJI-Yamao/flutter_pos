/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../regs/checker/rckyrmod.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../controller/c_common_controller.dart';
import '../../register/component/w_purchase_scroll_button.dart';
import '../component/w_backtoregister_button.dart';
import '../component/w_notenough_change.dart';
import '../component/w_subtotal_left_toppage.dart';
import '../controller/c_coupons_controller.dart';
import '../controller/c_payment_controller.dart';
import '../controller/c_subtotal_controller.dart';
import '/app/ui/page/subtotal/component/w_coupon_item.dart';

///小計画面左部分
class LeftSection extends StatelessWidget {
  final SubtotalController subtotalCtrl = Get.find();
  final couponCtrl = Get.put(CouponsController());
  final CommonController commonCtrl = Get.find();
  final PaymentController paymentCtrl = Get.find();

  LeftSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubtotalPageAreaWidget(),
            const SizedBox(height: 5),
            if (RegsMem().refundFlag == false)
              NotEnoughChangeWidget(),
            const SizedBox(height: 5),
            const CouponWidget(),
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            height: 62,
            width: double.infinity,
            child: Obx(
              () => Visibility(
                visible: couponCtrl.purchaseScrollON.value,
                child: Align(
                  alignment: Alignment.center,
                  child: PurchaseScrollButton(
                    backgroundColor: BaseColor.topCloseButtonColor,
                    purchaseScrollController:
                        couponCtrl.purchaseScrollController,
                    scrollHeight: couponCtrl.scrollHeight.value,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: BackRegisterButton(
              text: '商品一覧へ\nもどる',
              icon: Icons.arrow_back,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(5)),
              onTap: () async {
                // タイマーが動いていたら止める
                Get.find<PaymentController>().cancelTimer();

                int errNo = 0;
                // スプリット支払い時は登録画面に画面遷移させない。
                errNo = await RcKyRmod.rcKyRmod();
                if (errNo != 0) {
                  // rcKyRmod()でrcErrをCALLしてるのでここでは何もしない
                } else {
                  Get.back();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
