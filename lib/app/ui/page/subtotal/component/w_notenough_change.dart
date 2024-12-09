/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/apl/image.dart';
import 'package:flutter_pos/app/lib/apllib/image_label_dbcall.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/page/register/controller/c_registerbody_controller.dart';
import 'package:get/get.dart';
import '../../../../common/number_util.dart';
import '../controller/c_subtotal_controller.dart';

///不足エリアとおつりエリアの構築　暫定
class NotEnoughChangeWidget extends StatelessWidget {
  /// コンストラクタ
  NotEnoughChangeWidget({super.key});

  ///コントローラ
  final SubtotalController subtotalCtrl = Get.find();
  final RegisterBodyController regBodyCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      // エリアを押されたら不足エリアとおつりエリアが切り替え
      () => Container(
          margin: const EdgeInsets.only(left: 8),
          height: 72,
          decoration: BoxDecoration(
            border: Border.all(
              color: subtotalCtrl.isChange.value
                  ? subtotalCtrl.changeBorderColor
                  : subtotalCtrl.notEnoughBorderColor,
              width: 2,
            ),
            color: subtotalCtrl.isChange.value
                ? subtotalCtrl.changeBackgroundColor
                : subtotalCtrl.notEnoughBackgroundColor,
          ),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 11),
                  child: Text(
                    subtotalCtrl.isChange.value
                        ? ImageDefinitions.IMG_CHANGE.imageData
                        : ImageDefinitions.IMG_SHORT.imageData,
                    style: TextStyle(
                      fontSize: BaseFont.font22px,
                      fontFamily: BaseFont.familyDefault,
                      color: subtotalCtrl.isChange.value
                          ? subtotalCtrl.changeTextColor
                          : subtotalCtrl.notEnoughTextColor,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      subtotalCtrl.isChange.value
                          ? NumberFormatUtil.formatAmount(
                              subtotalCtrl.changeAmount.value)
                          : NumberFormatUtil.formatAmount(
                              subtotalCtrl.notEnoughAmount.value),
                      style: TextStyle(
                        fontSize: BaseFont.font44px,
                        fontFamily: BaseFont.familyNumber,
                        color: subtotalCtrl.isChange.value
                            ? subtotalCtrl.changeTextColor
                            : subtotalCtrl.notEnoughTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
