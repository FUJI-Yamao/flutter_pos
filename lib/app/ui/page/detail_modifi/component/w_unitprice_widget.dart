/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../register/controller/c_register_change.dart';
import '../../../../common/number_util.dart';
import '../../register/controller/c_registerbody_controller.dart';

/// 単価タイトル／単金行の構築Widget
class UnitPriceRowWidget extends StatelessWidget {
  final RegisterChangeController rchgCtrl = Get.find();
  final RegisterBodyController bodyCtrl = Get.find();

  final int purchaseDataIndex;

  UnitPriceRowWidget({
    super.key, required this.purchaseDataIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(48, 16, 580, 0),
      child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: [
            const Text('単価',
                style: TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familyDefault)),
            Text(
              NumberFormatUtil.formatAmount(bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.price!) ?? '',
              // itemPrice,
              style: const TextStyle(
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyNumber,
              ),
            ),
          ]),
    );
  }
}
