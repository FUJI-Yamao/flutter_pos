/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/number_util.dart';
import '../../../../inc/sys/tpr_aid.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../../regs/checker/rc_touch_key.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../common/basepage/common_base.dart';
import '../../../controller/c_drv_controller.dart';
import '../controller/c_payment_cardtouch.dart';

///端末にカードを読ませるアニメーションページ
class PaymentCardTouchScreen extends CommonBasePage with RegisterDeviceEvent {
  /// 支払額
  final int payPrc;
  /// キャンセルを押したときの処理
  final Function? onCancelPressed;

  /// コントローラー
  final PaymentCardTouchController con = Get.put(PaymentCardTouchController());


  PaymentCardTouchScreen({
    super.key,
    required super.title,
    required this.payPrc,
    required String msg,
     this.onCancelPressed,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'PaymentCardTouchScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () async {
                 await onCancelPressed?.call();
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
        }) {
    registrationEvent();
    con.msg.value = msg;
  }

  @override
  Widget buildBody(BuildContext context) {
    return PaymentCardTouchWidget(
      backgroundColor: backgroundColor,
      payPrc: payPrc,
    );
  }

  @override
  IfDrvPage getTag() {
    // TODO: implement getTag
    return IfDrvPage.subtotalPaymentCardTouch;
  }

  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    return keyCon;
  }
}

class PaymentCardTouchWidget extends StatefulWidget {
  /// 支払う金額
  final int payPrc;

  final Color backgroundColor;
  PaymentCardTouchController con =  Get.find();
 

  PaymentCardTouchWidget(
      {super.key,
      required this.payPrc,
      required this.backgroundColor});

  @override
  PaymentCardTouchState createState() => PaymentCardTouchState();
}

class PaymentCardTouchState extends State<PaymentCardTouchWidget> {
  String currentPaymentMethod = '';

  @override
  void initState() {
    super.initState();
    _simulateGetPaymentBackend();
  }

  void _simulateGetPaymentBackend() async {
    setState(() {
      currentPaymentMethod = 'ut1';
    });
  }

  @override
  Widget build(BuildContext context) {
    String animationPath;
    switch (currentPaymentMethod) {
      case 'verifone':
        animationPath = 'assets/images/verifone_touch.webp';
        break;
      case 'ut1':
        animationPath = 'assets/images/ut1_touch 1.webp';
        break;
      default:
        animationPath = '';
    }

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(122.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() =>
                  Container(
                    height: 96.h,
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                         text: widget.con.msg2.isNotEmpty
                               ? "${widget.con.msg.value}\n${widget.con.msg2}"
                               : widget.con.msg.value,
                         style: TextStyle(
                           color: widget.con.color.value,
                           fontSize: BaseFont.font22px,
                           fontFamily: BaseFont.familyDefault,
                         ),
                      ),
                    ),
                  ),
                ),
                currentPaymentMethod == 'verifone'
                ? RichText(
                  text: const TextSpan(
                    text: 'キャンセルする際は、端末の赤(✕)ボタンを押してください',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: BaseColor.baseColor,
                      fontSize: BaseFont.font18px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                )
                : Container(),
              ],
            ),
          ),
        ),
      ),
      body: Column(children: [
        SizedBox(height: 34.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '合計',
              style: TextStyle(
                fontSize: BaseFont.font22px,
                color: BaseColor.baseColor,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
            SizedBox(
              width: 200.w,
            ),
            Text(
              NumberFormatUtil.formatAmount(widget.payPrc),
              style: const TextStyle(
                  fontSize: BaseFont.font44px,
                  color: BaseColor.baseColor,
                  fontFamily: BaseFont.familyNumber),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: 400.w,
          height: 1.h,
          color: BaseColor.loginTabTextColor,
        ),
        SizedBox(height: 10.h),
        if (currentPaymentMethod.isNotEmpty)
          Center(
            child: Image.asset(
              animationPath,
              width: 840.w,
              height: 440.h,
            ),
          )
      ]),
    );
  }
}
