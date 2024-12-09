/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../language/l_languagedbcall.dart';
import '../controller/c_full_self_register_controller.dart';

///商品明細欄の構築
class SumArea extends StatelessWidget {

  const SumArea({super.key, required this.controller});
  final FullSelfRegisterController controller;

  /// 最新の商品明細欄の高さ
  static const double newItemHeight = 88.0;
  /// 商品明細欄の高さ
  static const double oldItemHeight = 64.0;

  /// 合計金額欄の商品点数、ポイントという文字の横領域
  static const double sumAreaTitlesWidth = (22 * 4) + (16 * 2) + 40;
  /// 合計金額欄の商品点数、ポイントという文字の縦領域
  static const double sumAreaTitlesHeight = 22.0 + 26.0;
  /// 合計金額欄の商品点数、ポイントという文字の余白の領域
  static const double sumAreaTitlesSpace = 0;
  /// 合計金額欄の商品点数、ポイントの領域(+4は調整分)
  static const double sumAreaTotalQtyAndPointWidth = (16 * 6) + sumAreaTotalQtyAndPointAdjustment;
  /// 合計金額欄の商品点数、ポイントの領域の調整分
  static const double sumAreaTotalQtyAndPointAdjustment = 4;
  /// 合計金額欄の商品点数、ポイントの単位の横領域
  static const double sumAreaUnitsWidth = 24 * 1;
  /// 合計金額欄の商品点数、ポイントの単位の縦領域
  static const double sumAreaUnitsHeight = 24.0 + 24.0;
  /// 合計金額欄の商品点数、ポイントの単位の余白の領域
  static const double sumAreaUnitsSpace = 8;
  /// 合計金額欄のボーダー
  static const double sumAreaBorder = 4.0;

  /// 合計金額欄の"合計"という文字の左余白
  //　元々のサイズ88 - ポイントの割合4 - 金額の割合16 + 合計の右余白を削った分32
  static const double totalAmountTitleLeftSpace =
      (88 - sumAreaTotalQtyAndPointAdjustment - totalAmountAdjustment) + 32;
  /// 合計金額欄の"合計"という文字の領域
  static const double totalAmountTitleWidth = 26 * 2;
  /// 合計金額欄の"合計"という文字の右余白
  static const double totalAmountTitleRightSpace = 16;
  /// 合計金額欄の単位の領域
  static const double totalAmountUnit = 52 * 1;
  /// 合計金額欄の合計金額の領域(+16は調整分)
  static const double totalAmountWidth = (32 * 11) + totalAmountAdjustment;
  /// 合計金額欄の合計金額と単位の領域の調整分
  static const double totalAmountAdjustment = 16;
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      width: double.infinity,
      height: 132.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: controller.refundFlag.value
              ? BaseColor.customerPageDiscountTextColor
              : BaseColor.customerPageSumAreaBackGroundColor,
          width: sumAreaBorder,
        ),
        color: controller.refundFlag.value
            ? BaseColor.registDiscountBackColor
            : BaseColor.customerPageSumAreaBackGroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40.0 - sumAreaBorder),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            /*
              商品点数（(22px * 4文字 + 16(32/2)px * 2) + 余白40px）
              　→数値の桁数を減らし、その分の領域を商品点数に持たせた
              + 数値(16(32/2)px * 6文字 + 調整分)
              + 単位（24px + 1文字 + 余白8px）
              調整分
                →文字数の領域分の割合に+してwindows起動時の画面サイズでも文字がscaledownしないようにした
             */
            flex: ((sumAreaTitlesWidth + sumAreaTitlesSpace)
                + sumAreaTotalQtyAndPointWidth
                + (sumAreaUnitsWidth + sumAreaUnitsSpace)).toInt(),
            child: Row(
              children: [
                // 合計金額欄の商品点数、ポイントという文字
                _sumAreaTitles(controller),
                // 合計金額欄の商品点数、ポイント
                Expanded(
                  child: _sumAreaNumbers(controller),
                ),
                // 合計金額欄の商品点数、ポイントの単位
                _sumAreaUnits(controller),
              ],
            ),
          ),
          // 余白
          Expanded(
            /*
              元々のサイズ88 - ポイントの調整分4 - 金額の調整分16 + 合計の右余白を削った分32
              + 合計という文字52
              + 合計の右余白16
            */
            flex: (totalAmountTitleLeftSpace
                + totalAmountTitleWidth
                + totalAmountTitleRightSpace).toInt(),
            // 合計金額欄の"合計"という文字
            child: _totalAmountTitle(),
          ),
          // 合計金額欄の合計金額と単位
          Expanded(
            // 文字数の領域分の割合に+してwindows起動時の画面サイズでも文字がscaledownしないようにした
            // ￥の52px + (32(64/2)px*最大11文字 + 調整分)
            flex: (totalAmountUnit
                + totalAmountWidth).toInt(),
            child: _totalAmountNumberAndUnit(controller),
          ),
        ],
      ),
    ),);
  }

  /// 合計金額欄の商品点数、ポイントという文字
  Widget _sumAreaTitles(FullSelfRegisterController controller) {
    return Padding(
      padding: const EdgeInsets.only(right: sumAreaTitlesSpace),
      child: Column(
        children: [
          SizedBox(
            // 22px * 4文字 + 16(32/2)px * 2 + 40
            width: sumAreaTitlesWidth,
            // 元の領域 + 上余白 - 上ボーダー4.0
            height: sumAreaTitlesHeight - sumAreaBorder,
            child: Obx(() => FittedBox(
              alignment: Alignment.bottomLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                'l_full_self_qty'.trns,
                maxLines: 1,
                style: TextStyle(
                  color: controller.refundFlag.value
                      ? BaseColor.customerPageDiscountTextColor
                      : BaseColor.customerPageSumAndNewPurchaseTextColor,
                  fontSize: BaseFont.font22px,
                ),
              ),
            ),),
          ),
          SizedBox(
            // 22px * 4文字 + 16(32/2)px * 2 + 40
            width: sumAreaTitlesWidth,
            // 元の領域 + 上余白
            height: sumAreaTitlesHeight,
            child: Obx(() {
              if (controller.flgPoint.value) {
                return FittedBox(
                  alignment: Alignment.bottomLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'l_full_self_point'.trns,
                    maxLines: 1,
                    style: TextStyle(
                      color: controller.refundFlag.value
                          ? BaseColor.customerPageBaseTextColor
                          : BaseColor.customerPageSumAndNewPurchaseTextColor,
                      fontSize: BaseFont.font22px,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }

  /// 合計金額欄の商品点数、ポイント
  Widget _sumAreaNumbers(FullSelfRegisterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 上余白 - 上ボーダー4.0
        const SizedBox(height: 16.0 - sumAreaBorder,),
        SizedBox(
          height: 32.0,
          child: Obx(() {
            if (controller.totalQty.value.isNotEmpty) {
              return FittedBox(
                alignment: Alignment.bottomRight,
                fit: BoxFit.scaleDown,
                child: Text(
                  controller.totalQty.value,
                  maxLines: 1,
                  style: TextStyle(
                    color: controller.refundFlag.value
                        ? BaseColor.customerPageDiscountTextColor
                        : BaseColor.customerPageSumAndNewPurchaseTextColor,
                    fontSize: BaseFont.font32px,
                    fontFamily: BaseFont.familyNumber,
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
        ),
        const SizedBox(height: 16.0,),
        SizedBox(
          height: 32.0,
          child: Obx(() {
            if (controller.flgPoint.value) {
              return FittedBox(
                alignment: Alignment.bottomRight,
                fit: BoxFit.scaleDown,
                child: Text(
                  controller.point.value,
                  maxLines: 1,
                  style: TextStyle(
                    color: controller.refundFlag.value
                        ? BaseColor.customerPageBaseTextColor
                        : BaseColor.customerPageSumAndNewPurchaseTextColor,
                    fontSize: BaseFont.font32px,
                    fontFamily: BaseFont.familyNumber,
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
        ),
      ],
    );
  }

  /// 合計金額欄の商品点数、ポイントの単位
  Widget _sumAreaUnits(FullSelfRegisterController controller) {
    return Column(
      children: [
        Container(
          // 24px * 1文字
          width: sumAreaUnitsWidth,
          // 元の領域 + 上余白 - 上ボーダー4.0
          height: sumAreaUnitsHeight - sumAreaBorder,
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(left: sumAreaUnitsSpace),
          child: Obx(() => FittedBox(
            alignment: Alignment.bottomRight,
            fit: BoxFit.scaleDown,
            child: Text(
              'l_full_self_unit'.trns,
              maxLines: 1,
              style: TextStyle(
                color: controller.refundFlag.value
                    ? BaseColor.customerPageDiscountTextColor
                    : BaseColor.customerPageSumAndNewPurchaseTextColor,
                fontSize: BaseFont.font24px,
              ),
            ),
          ),),
        ),
        Obx(() {
          if (controller.flgPoint.value) {
            return Container(
              // 24px * 1文字
              width: sumAreaUnitsWidth,
              // 元の領域 + 上余白
              height: sumAreaUnitsHeight,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(left: sumAreaUnitsSpace),
              child: FittedBox(
                alignment: Alignment.bottomRight,
                fit: BoxFit.scaleDown,
                child: Text(
                  'P',
                  maxLines: 1,
                  style: TextStyle(
                    color: controller.refundFlag.value
                        ? BaseColor.customerPageBaseTextColor
                        : BaseColor.customerPageSumAndNewPurchaseTextColor,
                    fontSize: BaseFont.font24px,
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },),
      ],
    );
  }

  /// 合計金額欄の"合計"という文字
  Widget _totalAmountTitle() {
    return Container(
      // 26px * 2文字
      width: totalAmountTitleWidth,
      // デザイン案はright余白48だが調整した
      // 下余白 - 下ボーダー4.0
      margin: const EdgeInsets.only(right: 16.0, bottom: 16.0 - sumAreaBorder,),
      alignment: Alignment.bottomRight,
      child: Obx(() => FittedBox(
        alignment: Alignment.bottomRight,
        fit: BoxFit.scaleDown,
        child: Text(
          'l_full_self_sum'.trns,
          maxLines: 1,
          style: TextStyle(
            color: controller.refundFlag.value
                ? BaseColor.customerPageDiscountTextColor
                : BaseColor.customerPageSumAndNewPurchaseTextColor,
            fontSize: BaseFont.font26px,
          ),
        ),
      ),),
    );
  }

  /// 合計金額欄の合計金額と単位
  Widget _totalAmountNumberAndUnit(FullSelfRegisterController controller) {
    return Obx(() {
      if (controller.totalAmount.value.isNotEmpty) {
        return Container(
          height: 64.0,
          // 下余白 - 下ボーダー4.0
          margin: const EdgeInsets.only(bottom: 16.0 - sumAreaBorder,),
          child: FittedBox(
            alignment: Alignment.bottomRight,
            fit: BoxFit.scaleDown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '￥',
                  style: TextStyle(
                    color: controller.refundFlag.value
                        ? BaseColor.customerPageDiscountTextColor
                        : BaseColor.customerPageSumAndNewPurchaseTextColor,
                    fontSize: BaseFont.font52px,
                  ),
                ),
                Text(
                  controller.totalAmount.value,
                  style: TextStyle(
                    color: controller.refundFlag.value
                        ? BaseColor.customerPageDiscountTextColor
                        : BaseColor.customerPageSumAndNewPurchaseTextColor,
                    fontSize: BaseFont.font64px,
                    fontFamily: BaseFont.familyNumber,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}