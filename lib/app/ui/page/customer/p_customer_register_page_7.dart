/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/number_util.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../language/l_languagedbcall.dart';
import 'controller/c_customer_register_controller.dart';

/// 客表（登録）画面
class CustomerRegisterPage7 extends StatelessWidget {
  /// コンストラクタ
  const CustomerRegisterPage7({super.key});

  /// 最新の商品明細欄の高さ
  static const double newItemHeight = 120.0;
  /// 商品明細欄の高さ
  static const double oldItemHeight = 64.0;

  /// 合計金額欄の商品点数、ポイントという文字の横領域
  static const double sumAreaTitlesWidth = (18 * 4) + (14 * 2) + 32;
  /// 合計金額欄の商品点数、ポイントという文字の縦領域
  static const double sumAreaTitlesHeight = 18.0 + 26.0;
  /// 合計金額欄の商品点数、ポイントという文字の余白の領域
  static const double sumAreaTitlesSpace = 0;
  /// 合計金額欄の商品点数、ポイントの領域(+4は調整分)
  static const double sumAreaTotalQtyAndPointWidth = (14 * 6) + sumAreaTotalQtyAndPointAdjustment;
  /// 合計金額欄の商品点数、ポイントの領域の調整分
  static const double sumAreaTotalQtyAndPointAdjustment = 4;
  /// 合計金額欄の商品点数、ポイントの単位の横領域
  static const double sumAreaUnitsWidth = 18 * 1;
  /// 合計金額欄の商品点数、ポイントの単位の縦領域
  static const double sumAreaUnitsHeight = 18.0 + 26.0;
  /// 合計金額欄の商品点数、ポイントの単位の余白の領域
  static const double sumAreaUnitsSpace = 8;
  /// 合計金額欄のボーダー
  static const double sumAreaBorder = 4.0;

  /// 合計金額欄の"合計"という文字の左余白
  //　元々のサイズ74 - ポイントの調整分4 - 金額の調整分12 + 合計の右余白を削った分16
  static const double totalAmountTitleLeftSpace =
      (74 - sumAreaTotalQtyAndPointAdjustment - totalAmountAdjustment) + 16;
  /// 合計金額欄の"合計"という文字の領域
  static const double totalAmountTitleWidth = 22 * 2;
  /// 合計金額欄の"合計"という文字の右余白
  static const double totalAmountTitleRightSpace = 16;
  /// 合計金額欄の単位の領域
  static const double totalAmountUnit = 40 * 1;
  /// 合計金額欄の合計金額の領域(+16は調整分)
  static const double totalAmountWidth = (24 * 11) + totalAmountAdjustment;
  /// 合計金額欄の合計金額と単位の領域の調整分
  static const double totalAmountAdjustment = 12;

  /// 商品明細の商品名の領域(+10は調整分)
  static const double merchandiseNameWidth = (24 * 13) + 10;
  /// 商品明細の商品点数の領域(+4は調整分)
  static const double merchandiseQtyWidth = (16 * 4) + 4;
  /// 最新の商品明細の商品点数の単位の横領域
  static const double newMerchandiseQtyUnitWidth = 32 * 1;
  /// 最新の商品明細の商品点数の単位の縦領域
  /// 最新の商品明細の高さ - 内側に設けた縦余白の合計
  static const double newMerchandiseQtyUnitHeight = newItemHeight - 48.0;
  /// 最新以外の商品明細の商品点数の単位の横領域
  static const double oldMerchandiseQtyUnitWidth = 24 * 1;
  /// 最新以外の商品明細の商品点数の単位の縦領域
  /// 最新以外の商品明細の高さ - 内側に設けた縦余白の合計
  static const double oldMerchandiseQtyUnitHeight = oldItemHeight - 16.0;
  /// 商品明細の商品点数の単位の余白の領域
  static const double merchandiseUnitSpace = 8;
  /// 商品明細の"値下済"の文字の領域
  static const double merchandiseDiscountWidth = 24 * 3;
  /// 商品明細の"値下済"と金額の間の余白
  static const double discountAndPriceSpace = 14;
  /// 商品明細の金額の領域(+8は調整分)
  static const double merchandisePriceWidth = (16 * 9) + 8;

  @override
  Widget build(BuildContext context) {
    CustomerRegisterController controller = Get.put(CustomerRegisterController());
    return Scaffold(
      body: Container(
        color: BaseColor.customerPageBackGroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            children: [
              // 合計金額欄
              sumArea(controller),
              const SizedBox(height: 16.0,),
              // 商品明細一覧
              allItems(controller),
            ],
          ),
        ),
      ),
    );
  }

  /// 合計金額欄
  Widget sumArea(CustomerRegisterController controller) {
    return Obx(() => Container(
      width: double.infinity,
      height: 120.0,
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
      padding: const EdgeInsets.only(
        left: 24.0 - sumAreaBorder,
        right: 32.0 - sumAreaBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            /*
              商品点数（18px * 4文字 + 余白32px）
              + 数値(14(28/2)px*8文字 + 調整分)
              + 単位（18px + 1文字 + 余白8px）
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
              元々のサイズ74 - ポイントの調整分4 - 金額の調整分12 + 合計の右余白を削った分16
              + 合計という文字44
              + 合計の右余白16
            */
            flex: (totalAmountTitleLeftSpace
                + totalAmountTitleWidth
                + totalAmountTitleRightSpace).toInt(),
            // 合計金額欄の"合計"という文字
            child: _totalAmountTitle(controller),
          ),
          // 合計金額欄の合計金額と単位
          Expanded(
            // 文字数の領域分の割合に+してwindows起動時の画面サイズでも文字がscaledownしないようにした
            // ￥の40px + (24(48/2)px*最大11文字 + 調整分)
            flex: (totalAmountUnit
                + totalAmountWidth).toInt(),
            child: _totalAmountNumberAndUnit(controller),
          ),
        ],
      ),
    ),);
  }

  /// 合計金額欄の商品点数、ポイントという文字
  Widget _sumAreaTitles(CustomerRegisterController controller) {
    return Padding(
      padding: const EdgeInsets.only(right: sumAreaTitlesSpace),
      child: Column(
        children: [
          SizedBox(
            // 18px * 4文字 + 32
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
                  fontSize: BaseFont.font18px,
                ),
              ),
            ),),
          ),
          SizedBox(
            // 18px * 4文字 + 32
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
                      fontSize: BaseFont.font18px,
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
  Widget _sumAreaNumbers(CustomerRegisterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 上余白 - 上ボーダー4.0
        const SizedBox(height: 16.0 - sumAreaBorder,),
        SizedBox(
          height: 28.0,
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
                    fontSize: BaseFont.font28px,
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
          height: 28.0,
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
                    fontSize: BaseFont.font28px,
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
  Widget _sumAreaUnits(CustomerRegisterController controller) {
    return Column(
      children: [
        Container(
          // 18px * 1文字
          width: sumAreaUnitsWidth,
          // 元の領域 + 上余白 - 上ボーダー4.0
          height: sumAreaUnitsHeight - sumAreaBorder,
          margin: const EdgeInsets.only(left: sumAreaUnitsSpace),
          alignment: Alignment.bottomCenter,
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
                fontSize: BaseFont.font18px,
              ),
            ),
          ),),
        ),
        Obx(() {
          if (controller.flgPoint.value) {
            return Container(
              // 18px * 1文字
              width: sumAreaUnitsWidth,
              // 元の領域 + 上余白
              height: sumAreaUnitsHeight,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(left: sumAreaUnitsSpace),
              child: Text(
                'P',
                maxLines: 1,
                style: TextStyle(
                  color: controller.refundFlag.value
                      ? BaseColor.customerPageBaseTextColor
                      : BaseColor.customerPageSumAndNewPurchaseTextColor,
                  fontSize: BaseFont.font18px,
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }

  /// 合計金額欄の"合計"という文字
  Widget _totalAmountTitle(CustomerRegisterController controller) {
    return Container(
      // 22px * 2文字
      width: totalAmountTitleWidth,
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
            fontSize: BaseFont.font22px,
          ),
        ),
      ),),
    );
  }

  /// 合計金額欄の合計金額と単位
  Widget _totalAmountNumberAndUnit(CustomerRegisterController controller) {
    return Obx(() {
      if (controller.totalAmount.value.isNotEmpty) {
        return Container(
          height: 48.0,
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
                    fontSize: BaseFont.font40px,
                  ),
                ),
                Text(
                  controller.totalAmount.value,
                  style: TextStyle(
                    color: controller.refundFlag.value
                        ? BaseColor.customerPageDiscountTextColor
                        : BaseColor.customerPageSumAndNewPurchaseTextColor,
                    fontSize: BaseFont.font48px,
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

  /// 商品明細一覧
  Widget allItems(CustomerRegisterController controller) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // oldItemMaxCountの数を計算する
          int oldItemMaxCount = controller.calcOldItemMaxCount(constraints.maxHeight, newItemHeight, oldItemHeight);
          return Column(
            children: [
              GetBuilder<CustomerRegisterController>(
                builder: (controller) {
                  // 最新の商品明細で表示される値引の数を取得する
                  int discountCount = controller.getDisplayedNewItemDiscountCount();
                  // 値引きありならoldItemMaxCountからdiscountCountを減らした数だけoldItemを表示
                  int oldItemRowCount = oldItemMaxCount - discountCount;
                  return Column(
                    children: [
                      // 最新の商品明細
                      newItem(controller, discountCount),
                      for (int oldItemRow = 1; oldItemRow <= oldItemRowCount; oldItemRow++) ... {
                        // 商品明細
                        oldItem(controller, oldItemRow, discountCount),
                      },
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  /// 最新の商品明細
  Widget newItem(CustomerRegisterController controller, int discountCount) {
    return Stack(
      children: [
        newItemWholeDesign(
          controller: controller,
          discountCount: discountCount,
          newItemColumn: Column(
            children: [
              // 最新の商品明細
              Container(
                // newItemHeight - 上下の枠(12*2)
                height: 96.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: controller.refundFlag.value
                    ? BaseColor.customerPageRefundOddsPurchaseColor
                    : BaseColor.customerPageNewPurchaseBackGroundColor,
                child: controller.merchandiseDataList.isNotEmpty
                    ? newItemDetail(controller)
                    : Container(),
              ),
              // 最新の商品明細の値引き情報
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: controller.refundFlag.value
                      ? BaseColor.customerPageRefundOddsPurchaseColor
                      : BaseColor.customerPageDiscountBackGroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: newItemDiscount(controller, discountCount),
              ),
            ],
          ),
        ),
        // 取り消しがあったかどうかを判定
        if (controller.merchandiseDataList.isNotEmpty && controller.judgeCancel(0)) ... {
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: BaseColor.customerPageCancelBackGroundColor.withOpacity(0.8),
              ),
              child: Center(
                child: Obx(() => Text(
                  'l_full_self_cancelled'.trns,
                  style: const TextStyle(
                    color: BaseColor.customerPageDiscountTextColor,
                    fontSize: BaseFont.font24px,
                  ),
                ),),
              ),
            ),
          ),
        }
      ],
    );
  }

  /// 最新の商品明細の全体の見た目
  Widget newItemWholeDesign({
    required CustomerRegisterController controller,
    required int discountCount,
    required Widget newItemColumn,
  }) {
    if (controller.refundFlag.value) {
      return Container(
        // 最新の商品明細 + 値引きの数
        height: newItemHeight + (oldItemHeight * discountCount),
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: BaseColor.customerPageDiscountTextColor,
          ),
          borderRadius: BorderRadius.circular(4.0),
          color: BaseColor.customerPageRefundOddsPurchaseColor,
        ),
        child: newItemColumn,
      );
    } else {
      return Container(
        // 最新の商品明細 + 値引きの数
        height: newItemHeight + (oldItemHeight * discountCount),
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: BaseColor.customerPageNewPurchaseBackGroundColor,
        ),
        child: newItemColumn,
      );
    }
  }

  /// 最新の商品明細の詳細
  Widget newItemDetail(CustomerRegisterController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 最新の商品明細の商品名
          Expanded(
            // 34px * 9文字だが、商品明細一覧に合わせ24px * 13文字 + 調整分
            flex: merchandiseNameWidth.toInt(),
            child: _newItemMerchandiseName(controller),
          ),
          // ・・・と最新商品明細の点数の先頭との差
          const SizedBox(width: 10.0),
          // 最新の商品明細の商品点数
          Expanded(
            // (16px*4文字 + 調整分) + 余白8px + 32px*1文字
            // 文字数の領域分の割合に+してwindows起動時の画面サイズでも文字がscaledownしないようにした
            flex: (merchandiseQtyWidth
                + merchandiseUnitSpace
                + newMerchandiseQtyUnitWidth).toInt(),
            child: _newItemMerchandiseQty(controller),
          ),
          const SizedBox(width: 10.0),
          // 最新の商品明細の金額
          Expanded(
            // 商品明細一覧に合わせ、
            // 値下済72px + 余白14px + (数値16px*9文字 + 調整分)
            flex: (merchandiseDiscountWidth
                + discountAndPriceSpace
                + merchandisePriceWidth).toInt(),
            child: _newItemMerchandisePrice(controller),
          ),
        ],
      ),
    );
  }

  /// 最新の商品明細の商品名
  Widget _newItemMerchandiseName(CustomerRegisterController controller) {
    return SizedBox(
      height: 34.0,
      child: Text(
        controller.merchandiseDataList[0].name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: controller.refundFlag.value
              ? BaseColor.customerPageDiscountTextColor
              : BaseColor.customerPageSumAndNewPurchaseTextColor,
          fontSize: BaseFont.font34px,
        ),
      ),
    );
  }

  /// 最新の商品明細の商品点数
  Widget _newItemMerchandiseQty(CustomerRegisterController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            height: 32.0,
            child: FittedBox(
              alignment: Alignment.bottomRight,
              fit: BoxFit.scaleDown,
              child: Text(
                controller.formatNumber(controller.merchandiseDataList[0].qty),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: controller.refundFlag.value
                      ? BaseColor.customerPageDiscountTextColor
                      : BaseColor.customerPageSumAndNewPurchaseTextColor,
                  fontSize: BaseFont.font32px,
                  fontFamily: BaseFont.familyNumber,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: newMerchandiseQtyUnitWidth,
          height: newMerchandiseQtyUnitHeight,
          margin: const EdgeInsets.only(left: merchandiseUnitSpace),
          child: Obx(() => FittedBox(
            alignment: Alignment.bottomRight,
            fit: BoxFit.scaleDown,
            child: Text(
              'l_full_self_unit'.trns,
              style: TextStyle(
                color: controller.refundFlag.value
                    ? BaseColor.customerPageDiscountTextColor
                    : BaseColor.customerPageSumAndNewPurchaseTextColor,
                fontSize: BaseFont.font32px,
              ),
            ),
          ),),
        ),
      ],
    );
  }

  /// 最新の商品明細の金額
  Widget _newItemMerchandisePrice(CustomerRegisterController controller) {
    return SizedBox(
      height: 48.0,
      child: FittedBox(
        alignment: Alignment.bottomRight,
        fit: BoxFit.scaleDown,
        child: Text(
          // 商品の金額をフォーマットされた文字列に変換する
          controller.getStrMerchandisePrice(itemRow: 0),
          style: TextStyle(
            color: controller.refundFlag.value
                ? BaseColor.customerPageDiscountTextColor
                : BaseColor.customerPageSumAndNewPurchaseTextColor,
            fontSize: BaseFont.font48px,
            fontFamily: BaseFont.familyNumber,
          ),
        ),
      ),
    );
  }

  /// 最新の商品明細の値引き
  Widget newItemDiscount(CustomerRegisterController controller, int discountCount) {
    return Column(
      children: [
        for (int i = 0; i < discountCount; i++)... {
          SizedBox(
            height: oldItemHeight,
            child: Row(
              children: [
                Expanded(
                  /*
                    商品明細一覧に合わせ、
                    24px * 13文字 + 調整分
                    　→実際の文字数は48px左に余白を設けていることから11文字
                   */
                  flex: merchandiseNameWidth.toInt(),
                  child: Container(
                    // 24px * 2文字
                    padding: const EdgeInsets.only(left: 48.0),
                    child: Text(
                      // 最新の商品明細の値引情報を取得する
                      controller.getModelDiscountData(i).discountName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: BaseColor.customerPageDiscountTextColor,
                        fontSize: BaseFont.font24px,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  // 最新の商品明細に合わせ、
                  // (16px*4文字 + 調整分) + 余白8px + 32px*1文字
                  flex: (merchandiseQtyWidth
                      + merchandiseUnitSpace
                      + newMerchandiseQtyUnitWidth).toInt(),
                  child: Container(),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  // 商品明細一覧に合わせ、
                  // 値下済72px + 余白14px + (数値16px*9文字 + 調整分)
                  flex: (merchandiseDiscountWidth
                      + discountAndPriceSpace
                      + merchandisePriceWidth).toInt(),
                  child: SizedBox(
                      height: 32.0,
                      // 値引タイプが特売でなく会員でないか、を判定
                      child: (controller.judgeDiscountType(i))
                          ? FittedBox(
                        alignment: Alignment.bottomRight,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          // 値引き額を計算する
                          NumberFormatUtil.formatAmount((controller.getDisplayedDiscountPrice(i))),
                          style: const TextStyle(
                            color: BaseColor.customerPageDiscountTextColor,
                            fontSize: BaseFont.font32px,
                            fontFamily: BaseFont.familyNumber,
                          ),
                        ),
                      )
                          : Container()
                  ),
                ),
              ],
            ),
          ),
        }
      ],
    );
  }

  /// 商品明細
  Widget oldItem(CustomerRegisterController controller, int oldItemRow, int discountCount) {
    return Stack(
      children: [
        Container(
            height: oldItemHeight,
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            // 商品明細の背景色
            color: oldItemColor(controller, oldItemRow, discountCount),
            // oldItemRowをmerchandiseDataListのindexとして扱う
            child: controller.merchandiseDataList.length > oldItemRow
                ? oldItemDetail(controller, oldItemRow)
                : Container()
        ),
        // oldItemRowをmerchandiseDataListのindexとして扱う
        // 取り消しがあったかどうかを判定
        if (controller.merchandiseDataList.length > oldItemRow && controller.judgeCancel(oldItemRow)) ... {
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: BaseColor.customerPageCancelBackGroundColor.withOpacity(0.7),
              ),
              child: Center(
                child: Obx(() => Text(
                  'l_full_self_cancelled'.trns,
                  style: const TextStyle(
                    color: BaseColor.customerPageDiscountTextColor,
                    fontSize: BaseFont.font24px,
                  ),
                ),),
              ),
            ),
          ),
        },
      ],
    );
  }

  /// 商品明細の背景色
  // 商品明細の背景を奇数と偶数で塗り分けている
  Color oldItemColor(CustomerRegisterController controller, int oldItemRow, int discountCount) {
    // 商品明細欄全体として何行目かを求める
    // +1は商品明細欄全体の行を1スタートにしたいため
    int currentRow = oldItemRow + discountCount + 1;
    if (currentRow % 2 == 0) {
      // 偶数行目
      return BaseColor.customerPageEvensPurchaseColor;
    } else {
      // 奇数行目
      if (controller.refundFlag.value) {
        // 返品時
        return BaseColor.customerPageRefundOddsPurchaseColor;
      } else {
        // 通常時
        return BaseColor.customerPageOddsPurchaseColor;
      }
    }
  }

  /// 商品明細の詳細
  Widget oldItemDetail(CustomerRegisterController controller, int oldItemRow) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 商品明細の商品名
          Expanded(
            // 24px * 13文字 + 調整分
            // 文字数の領域分の割合に+してwindows起動時の画面サイズでも13文字表示できるようにした
            flex: merchandiseNameWidth.toInt(),
            child: _oldItemMerchandiseName(controller, oldItemRow),
          ),
          // ・・・と最新商品明細の点数の先頭との差
          const SizedBox(width: 10.0,),
          // 商品明細の商品点数
          Expanded(
            // 最新の商品明細に合わせ、
            // (16px*4文字 + 調整分) + 余白8px + 32px*1文字
            flex: (merchandiseQtyWidth
                + merchandiseUnitSpace
                + newMerchandiseQtyUnitWidth).toInt(),
            child: _oldItemMerchandiseQty(controller, oldItemRow),
          ),
          const SizedBox(width: 10.0,),
          // 商品明細の値下済の文字と金額
          Expanded(
            // 値下済72px + 余白14px + (数値16px*9文字 + 調整分)
            // 文字数の領域分の割合に+してwindows起動時の画面サイズでも文字がscaledownしないようにした
            flex: (merchandiseDiscountWidth
                + discountAndPriceSpace
                + merchandisePriceWidth).toInt(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 商品明細の値下済
                _oldItemMerchandiseDiscount(controller, oldItemRow),
                // デザインは30だがマイナス分の16減らした
                const SizedBox(width: discountAndPriceSpace,),
                // 商品明細の金額
                _oldItemMerchandisePrice(controller, oldItemRow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 商品明細の商品名
  Widget _oldItemMerchandiseName(CustomerRegisterController controller, int oldItemRow) {
    return Text(
      controller.merchandiseDataList[oldItemRow].name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: controller.refundFlag.value
            ? BaseColor.customerPageDiscountTextColor
            : BaseColor.customerPageBaseTextColor,
        fontSize: BaseFont.font24px,
      ),
    );
  }

  /// 商品明細の商品点数
  Widget _oldItemMerchandiseQty(CustomerRegisterController controller, int oldItemRow) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            height: 24.0,
            child: FittedBox(
              alignment: Alignment.bottomRight,
              fit: BoxFit.scaleDown,
              child: Text(
                controller.formatNumber(controller.merchandiseDataList[oldItemRow].qty),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: controller.refundFlag.value
                      ? BaseColor.customerPageDiscountTextColor
                      : BaseColor.customerPageBaseTextColor,
                  fontSize: BaseFont.font24px,
                  fontFamily: BaseFont.familyNumber,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: oldMerchandiseQtyUnitWidth,
          height: oldMerchandiseQtyUnitHeight,
          margin: const EdgeInsets.only(left: merchandiseUnitSpace),
          child: Obx(() => FittedBox(
            alignment: Alignment.bottomRight,
            fit: BoxFit.scaleDown,
            child: Text(
              'l_full_self_unit'.trns,
              style: TextStyle(
                color: controller.refundFlag.value
                    ? BaseColor.customerPageDiscountTextColor
                    : BaseColor.customerPageBaseTextColor,
                fontSize: BaseFont.font24px,
              ),
            ),
          ),),
        ),
      ],
    );
  }

  /// 商品明細の"値下済"の文字
  Widget _oldItemMerchandiseDiscount(CustomerRegisterController controller, int oldItemRow) {
    return SizedBox(
        width: merchandiseDiscountWidth,
        child: controller.merchandiseDataList[oldItemRow].discountList.isNotEmpty
            ? Obx(() => FittedBox(
                alignment: Alignment.bottomCenter,
                fit: BoxFit.scaleDown,
                child: Text(
                  'l_full_self_discount'.trns,
                  style: const TextStyle(
                    color: BaseColor.customerPageDiscountTextColor,
                    fontSize: BaseFont.font24px,
                  ),
                ),
              ),)
            : Container()
    );
  }

  /// 商品明細の金額
  Widget _oldItemMerchandisePrice(CustomerRegisterController controller, int oldItemRow) {
    return Expanded(
      child: SizedBox(
        height: 32.0,
        child: FittedBox(
          alignment: Alignment.bottomRight,
          fit: BoxFit.scaleDown,
          child: Text(
            // 商品の金額をフォーマットされた文字列に変換する
            controller.getStrMerchandisePrice(itemRow: oldItemRow),
            style: TextStyle(
              color: controller.refundFlag.value
                  ? BaseColor.customerPageDiscountTextColor
                  : BaseColor.customerPageBaseTextColor,
              fontSize: BaseFont.font32px,
              fontFamily: BaseFont.familyNumber,
            ),
          ),
        ),
      ),
    );
  }

}