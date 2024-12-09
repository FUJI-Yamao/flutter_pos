/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/number_util.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';

import '../controller/c_registerbody_controller.dart';
import 'w_purchasewidget_base.dart';

/// スキャン一覧の1つにエリア
class PurchaseWidget extends PurchaseWidgetBase {
  PurchaseWidget({
    super.key,
    required super.index,
    required super.type,
    required super.length,
  });

  Offset? targetContainerPosition;

  @override
  Widget build(BuildContext context) {
    final RegisterBodyController regBodyCtrl = Get.find();

    ever(bodyctrl.purchaseData, (_) {
      double addheight = PurchaseWidgetBase.discountLineHeight * 2;
      if (bodyctrl.purchaseData.isNotEmpty &&
          bodyctrl.purchaseData.length > index) {
        int length = bodyctrl
            .purchaseData[index].itemLog.itemData.discountList?.length ??
            0;

        /// 割引情報の行の高さを設定
        /// 最小で2行分あり、3行以上ある場合は高さを追加する
        if (length > 2) {
          addheight += (length - 2) * PurchaseWidgetBase.discountLineHeight;
        }
        discountHeight.value = addheight;
      }
    });

    return Obx(() {
      final isDeleted = bodyctrl.purchaseData[index].isDeleted;
      int amount = (itemLog.itemData.price ?? 0) * (itemLog.itemData.qty ?? 0);
      if ((itemLog.itemData.discountList != null) &&
          (itemLog.itemData.discountList!.isNotEmpty)) {
        int discountPrice = 0;
        for (var element in itemLog.itemData.discountList!) {
          discountPrice += element.discountPrice!;
        }
        if (amount > discountPrice) {
          amount -= discountPrice;
        } else {
          amount = 0;
        }
      }

      return Container(

        /// 最終行以外では次の明細の前にマージンを入れる
        margin: index < length - 1
            ? const EdgeInsets.only(bottom: 8)
            : EdgeInsets.zero,
        alignment: Alignment.topLeft,
        height: (isTopPurchase()
            ? PurchaseWidgetBase.discountLastLineBaseHeight
            : PurchaseWidgetBase.discountLineBaseHeight) +
            discountHeight.value,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: PurchaseWidgetBase.numberFlex + PurchaseWidgetBase.dataFlex,
              child: Container(
                decoration: BoxDecoration(
                  color: isDeleted
                      ? BaseColor.scanBtnShadowColor
                      : BaseColor.someTextPopupArea,
                ),
                padding: const EdgeInsets.only(top: 12),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        // No
                        Expanded(
                            flex: PurchaseWidgetBase.numberFlex,
                            child: seqNoWidget()),
                        // 商品名
                        Expanded(
                          flex: PurchaseWidgetBase.dataFlex,
                          child: Container(
                            padding: isTopPurchase()
                                ? const EdgeInsets.only(right: 8, left: 15)
                                : const EdgeInsets.only(right: 20, left: 19),
                            alignment: Alignment.topLeft,
                            child: Text(
                              // data.productName,
                              itemLog.getItemName(),
                              style: TextStyle(
                                fontSize: isTopPurchase()
                                    ? BaseFont.font28px
                                    : BaseFont.font18px,
                                color: regBodyCtrl.refundFlag.value ? BaseColor.attentionColor : BaseColor.baseColor,
                                decoration: isDeleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: isTopPurchase() ? 14 : 10,
                    ),
                    Stack(
                      children: [
                        // 値引き情報を表示する.
                        discountWidgetList(),

                        // 税表示
                        Positioned(
                          left: 0,
                          top: discountHeight.value -
                              PurchaseWidgetBase.discountLineHeight,
                          child: Container(
                            height: 20.h,
                            margin: const EdgeInsets.only(left: 16),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // data.taxInfo,
                              itemLog.getItemTaxStr(),
                              style: TextStyle(
                                  fontSize: BaseFont.font14px,
                                  color: regBodyCtrl.refundFlag.value ? BaseColor.attentionColor : BaseColor.baseColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 数量変更/金額表示
                    Container(
                      height: 48,
                      margin: const EdgeInsets.only(right: 16, left: 16),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          // 数量変更
                          Expanded(
                            flex: 45,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Obx(
                                    () =>
                                    PurchaseNumUpDownWidget(
                                      index: index,
                                      quantity: itemLog.getItemQty(),
                                      oncallbackpull: () =>
                                          bodyctrl
                                              .changePurchaseQuantity(
                                              index, -1),
                                      oncallbackadd: () =>
                                          bodyctrl.changePurchaseQuantity(
                                              index, 1),
                                      isDeleted: isDeleted,
                                      isEditable: bodyctrl
                                          .checkPurchaseQuantityChange(index),
                                    ),
                              ),
                            ),
                          ),
                          // 金額
                          Expanded(
                            flex: 55,
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Obx(() => FittedBox(
                                child: Text(
                                  regBodyCtrl.refundFlag.value
                                      ? NumberFormatUtil.formatAmount(amount * -1)
                                      : NumberFormatUtil.formatAmount(amount
                                  ),
                                  style: TextStyle(
                                    color: regBodyCtrl.refundFlag.value
                                        ? BaseColor.attentionColor
                                        : BaseColor.baseColor,
                                    fontSize: isTopPurchase()
                                        ? BaseFont.font40px
                                        : BaseFont.font28px,
                                    fontFamily: BaseFont.familyNumber,
                                    decoration: isDeleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ボタン（変更「＞」）
            Expanded(
                flex: PurchaseWidgetBase.changeButtonFlex,
                child: PurchaseChangeWidget(
                  idx: index,
                  isDeleted: isDeleted,
                ))
          ],
        ),
      );
    });
  }
}
