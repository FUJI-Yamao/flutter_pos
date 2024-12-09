/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */


import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_background_design.dart';
import '../../../component/w_trainingModeText.dart';
import '../component/w_stripe.dart';
import '../controller/c_registerbody_controller.dart';
import '../controller/c_registerheader_controller.dart';
import 'registerheader.dart';

/// ベースページ
abstract class RegisterBasePage extends StatelessWidget {

  Widget createHeader(BuildContext context)
  {
    return Container(
      child: RegisterHeader(),
    );
  }

  Widget createBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterHeadController());
    Get.put(RegisterBodyController());
    return Scaffold(
        body: Stack(
        children: [
          Obx(() => Container(
            color: getBackgroundColor(),
            child: CustomPaint(
              size: Size.infinite,
              painter: SpriteDesignMode(),
            ),
          )),
          // ストライプを入れた場合
          StripedBackground(
            color: Color.fromRGBO(244, 196, 175, 1), // ストライプの色を指定します
            stripeWidth: 10, // ストライプの幅を指定します
            spacing: 2, // ストライプ間のスペースを指定します
            angle: 135, // ストライプの角度を指定します（度数法で指定）
          ),

          Column(
             mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              createHeader(context),
              createBody(context),
              // Expanded(child:createBody(context), )
            ],
          ),
          TrainingModeText(),
        ],
      ),

      // Column(
          //   // mainAxisAlignment: MainAxisAlignment.start,
          //   // mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     createHeader(context),
          //     createBody(context),
          //     // Expanded(child:createBody(context), )
          //   ],
          // ),
    );
  }

  /// 背景カラー
  Color getBackgroundColor() {
    final RegisterBodyController regBodyCtrl = Get.find();
    return regBodyCtrl.refundFlag.value
        ? BaseColor.refundBackColor
        : BaseColor.backColor;
  }

}