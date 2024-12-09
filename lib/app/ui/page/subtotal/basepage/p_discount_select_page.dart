/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/page/subtotal/component/w_payment_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../inc/sys/tpr_aid.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../../regs/checker/rcky_cha.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../controller/c_drv_controller.dart';
import '../../common/basepage/common_base.dart';
import '../controller/c_discount_select_controller.dart';

///割引選択ページ
class DiscountSelectPage extends CommonBasePage with RegisterDeviceEvent {
  ///コンストラクタ
  DiscountSelectPage({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) {
    registrationEvent();
  }

  @override
  Widget buildBody(BuildContext context) {
    return DiscountSelectWidget(
      backgroundColor: backgroundColor,
    );
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.subtotalElectronicMoney;
  }

  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    keyCon.funcCha = () async {
      await RckyCha.rcKyCharge();
    };
    return keyCon;
  }
}

///商品券選択画面widget
class DiscountSelectWidget extends StatefulWidget {
  /// 背景色
  final Color backgroundColor;

  ///コンストラクタ
  const DiscountSelectWidget({super.key, required this.backgroundColor});

  @override
  DiscountSelectState createState() => DiscountSelectState();
}

class DiscountSelectState extends State<DiscountSelectWidget> {
  @override
  Widget build(BuildContext context) {
    /// コントローラー
    final promotionCtrl = Get.put(DiscountSelectController());
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: const Center(
            child: Text(
              '値引や割引の方法を選択してください',
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          ///TODO 金額表示用の行のため、仕様が固まるまでは空文字を表示
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '',
                      style: TextStyle(
                        color: BaseColor.baseColor,
                        fontSize: BaseFont.font18px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                    SizedBox(
                      height: 66.w,
                      width: 66.w,
                    ),
                   const Text(
                      '',
                      style: TextStyle(
                          color: BaseColor.baseColor,
                          fontSize: BaseFont.font28px,
                          fontFamily: BaseFont.familyNumber),
                    ),
                  ],
                ),
          ),
          Expanded(
            child: Obx(() => GridView.builder(
                  padding:const EdgeInsets.only(
                    left: 88,
                    right: 88,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: promotionCtrl.discounts.length,
                  itemBuilder: (context, index) {
                    var discountSelect = promotionCtrl.discounts[index];
                    return PaymentBox(
                      iconPath: 'assets/images/${discountSelect.imgName}',
                      title: discountSelect.kyName,
                      onTap: () {
                        TchKeyDispatch.rcDTchByKeyId(
                            discountSelect.kyCd, discountSelect);
                      },
                      presetColor: discountSelect.presetColor,
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
