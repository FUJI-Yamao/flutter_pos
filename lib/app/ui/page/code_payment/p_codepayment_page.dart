/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/number_util.dart';
import '../../../inc/apl/image.dart';
import '../../../regs/checker/rc_key_cash4demo.dart';
import '../../../lib/apllib/image_label_dbcall.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import 'controller/c_codepayment_controller.dart';

///バーコードで支払いするページ
class CodePaymentScreen extends CommonBasePage {
  CodePaymentScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
          String className = 'CodePaymentScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                RcKeyCashDemo.isCancel = true;
                Get.back();
              },
              callFunc: className,
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

  @override
  Widget buildBody(BuildContext context) {
    return CodePaymentWidget(
      backgroundColor: backgroundColor,
    );
  }
}

class CodePaymentWidget extends StatefulWidget {
  final Color backgroundColor;

  const CodePaymentWidget({super.key, required this.backgroundColor});

  @override
  CodePaymenthState createState() => CodePaymenthState();
}

class CodePaymenthState extends State<CodePaymentWidget> {
  String currentPaymentMethod = '';
  final codePayCtrl = Get.put(CodePaymentInputController());

  ///合計金額の行の構築Widget
  Widget buildAmountRow(String leftText,
      {String? rightText,
      Widget? rightWidget,
      Color color = BaseColor.baseColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: TextStyle(
                fontSize: BaseFont.font22px,
                color: color,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
            if (rightWidget != null)
              rightWidget
            else
              Padding(
                padding: EdgeInsets.only(right: 32.w),
                child: Text(
                  rightText ?? '',
                  style: TextStyle(
                      fontSize: BaseFont.font44px,
                      color: color,
                      fontFamily: BaseFont.familyNumber),
                ),
              ),
          ],
        ),
        if (rightWidget == null) ...[
          SizedBox(
            height: 15.h,
          ),
          Container(
            width: 400.w,
            height: 1.h,
            color: color,
          ),
        ]
      ]),
    );
  }

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
              'スマホのバーコードをスキャンしてください',
              textAlign: TextAlign.center,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 56.h),
            Padding(
              padding: EdgeInsets.only(left: 272.w),
              child: Container(
                  width: 480.w,
                  height: 65.h,
                  color: BaseColor.transparent,

                  ///合計金額
                  child: Obx(
                    () => buildAmountRow(
                      ImageDefinitions.IMG_TTL.imageData,
                      rightText: NumberFormatUtil.formatAmount(
                          codePayCtrl.currentTotalAmount.value),
                    ),
                  )),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.only(left: 92.w),
              child: Image.asset(
                "assets/images/barcode_scanning.webp",
                width: 840.w,
                height: 440.h,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
