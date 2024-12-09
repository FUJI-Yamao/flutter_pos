/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/number_util.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../regs/checker/rcky_dsc.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../common/basepage/common_base.dart';
import '../../common/component/w_dicisionbutton.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../component/w_register_tenkey.dart';
import '../controller/c_discount_setting_controller.dart';
import '../controller/c_subtotal_controller.dart';

///値引割引設定ページ
class DiscountSettingPage extends CommonBasePage {

  /// コンストラクタ
  /// 引数 [title] ページタイトル
  /// 引数 [funcKey] ファンクションキー
  /// 引数 [backgroundColor] 背景色
  DiscountSettingPage({
    super.key,
    required super.title,
    required FuncKey funcKey,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) {
    this.funcKey = funcKey;
    DiscountSettingInputController discountSettingCtrl =
        Get.put(DiscountSettingInputController());
    discountSettingCtrl.setDiscountItem(title, funcKey);
  }



  @override
  Widget buildBody(BuildContext context) {
    return DiscountSettingWidget(
      backgroundColor: backgroundColor,
      fncCd:funcKey.keyId,
    );
  }
}

///値引割引設定画面widget
class DiscountSettingWidget extends StatefulWidget {
  /// 背景色
  final Color backgroundColor;
  final int fncCd ;
  ///コンストラクタ
  const DiscountSettingWidget({super.key, required this.backgroundColor,required this.fncCd});

  @override
  DiscountSettingState createState() => DiscountSettingState();
}

class DiscountSettingState extends State<DiscountSettingWidget> {
  DiscountSettingInputController discountSettingCtrl = Get.find();
  SubtotalController subtotalCtrl = Get.find();
  final RegisterBodyController regBodyCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: Center(
            child: Text(
              '${discountSettingCtrl.discountText.value}を決定し、確定するボタンを押してください',
              style: const TextStyle(
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.h,
                  ),
                  // 入力フォーム
                  Obx(() {
                    if (discountSettingCtrl.discountTypeFlg.value == 1) {
                      return Container(
                        color: BaseColor.someTextPopupArea,
                        width: 450.w,
                        height: 108.h,
                        child: buildInputRow(
                          leftText: discountSettingCtrl.discountText.value,
                          rightText: NumberFormatUtil.formatPercent(
                              discountSettingCtrl.discountValue.value),
                        ),
                      );
                    } else {
                      return Container(
                        color: BaseColor.someTextPopupArea,
                        width: 450.w,
                        height: 108.h,
                        child: buildInputRow(
                          leftText: discountSettingCtrl.discountText.value,
                          rightText:
                          RegsMem().refundFlag
                              ? NumberFormatUtil.formatAmount(
                              discountSettingCtrl.discountValue.value)
                              : NumberFormatUtil.formatMinusAmount(
                              discountSettingCtrl.discountValue.value)
                          ,
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),

          // 確定ボタン
          Obx(() {
            if (!discountSettingCtrl.showRegisterTenkey.value &&
                (discountSettingCtrl.discountValue.value != 0)) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: DecisionButton(
                  oncallback: () async {
                    await RckyDsc.addStlDscAndDsp(widget.fncCd, discountSettingCtrl.discountValue.value);
                  },
                  text: '確定する',
                  isdecision: true,
                ),
              );
            } else {
              return Container();
            }
          }),

          // テンキー
          Obx(() {
            if (discountSettingCtrl.showRegisterTenkey.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: RegisterTenkey(
                  onKeyTap: (key) {
                    discountSettingCtrl.inputKeyType(key);
                  },
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  /// 入力行を作成する
  /// leftText  左ラベルテキスト
  /// rightText 右ラベルテキスト
  Widget buildInputRow({String leftText = '', String rightText = ''}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              leftText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          InputBoxWidget(
            initStr: rightText,
            iniShowCursor: false,
            key: discountSettingCtrl.inputBoxKey,
            width: 280.w,
            height: 56.h,
            fontSize: BaseFont.font22px,
            textAlign: TextAlign.right,
            padding: const EdgeInsets.only(right: 32),
            cursorColor: BaseColor.baseColor,
            unfocusedBorder: BaseColor.inputFieldColor,
            focusedBorder: BaseColor.accentsColor,
            focusedColor: BaseColor.inputBaseColor,
            borderRadius: 4,
            blurRadius: 6,
            funcBoxTap: () {
              discountSettingCtrl.onInputBoxTap();
            },
            mode: discountSettingCtrl.discountTypeFlg.value == 1
                ? InputBoxMode.percentNumber
                : (RegsMem().refundFlag
                ? InputBoxMode.payNumber
            :InputBoxMode.minusPayNumber
            )),
        ],
      ),
    );
  }
}
