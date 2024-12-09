/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/lib/apllib/image_label_dbcall.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/number_util.dart';
import '../../../../inc/apl/image.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../socket/client/semiself_socket_client.dart';
import '../../register/component/w_tablistview.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../controller/c_subtotal_controller.dart';

///小計画面左部分上の構築
class SubtotalPageAreaWidget extends StatelessWidget {
  /// コントローラー
  final SubtotalController subtotalCtrl = Get.find();
  final RegisterBodyController regBodyCtrl = Get.find();
  static const int discountRowMax = 3;

  ///コンストラクタ
  SubtotalPageAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SemiSelfSocketClient().totalAmount = subtotalCtrl.totalAmount.value;
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        left: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 取引タブボタン
          SizedBox(
            height: RegsMem().refundFlag ? 36 : 40,
            child:  TabButtonWidget(
                BaseColor.baseColor,
                RegsMem().refundFlag ? BaseColor.refundAreaBackColor : BaseColor.someTextPopupArea
            ),
          ),
          // 小計情報エリア
          Container(
            height: 150.h,
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: RegsMem().refundFlag ? BaseColor.refundAreaBackColor : BaseColor.someTextPopupArea,
              border: RegsMem().refundFlag ? Border.all(color: BaseColor.attentionColor, width: 2) : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左側、点数/割引額表示エリア.
                SizedBox(
                  width: 214.w,
                  height: 128.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Obx(
                          () => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${subtotalCtrl.totalQty.value}',
                                    style: TextStyle(
                                      fontFamily: BaseFont.familyNumber,
                                      fontSize: BaseFont.font28px,
                                      color: RegsMem().refundFlag
                                          ? BaseColor.attentionColor
                                          : BaseColor.baseColor,
                                    ),
                                  ),
                                  Text(
                                    'l_reg_qty'.trns,
                                    style: TextStyle(
                                      fontFamily: BaseFont.familyDefault,
                                      fontSize: BaseFont.font18px,
                                      color: RegsMem().refundFlag
                                          ? BaseColor.attentionColor
                                          : BaseColor.baseColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Container(
                                color: subtotalCtrl.dscItemList.isEmpty
                                    ? BaseColor.someTextPopupArea
                                    : BaseColor.registDiscountBackColor,
                                padding: const EdgeInsets.only(top: 6, bottom: 6),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                      for (int i = 0 ; i< subtotalCtrl.dscItemList.length && i<discountRowMax; i++)
                                        Visibility(
                                          visible: subtotalCtrl
                                              .dscItemList.isNotEmpty,
                                          child: _buildDiscountRow(
                                              subtotalCtrl.dscItemList[i].title,
                                              NumberFormatUtil.formatAmount(
                                                  subtotalCtrl.dscItemList[i].dscValue),
                                            true),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible:
                                          subtotalCtrl.dscItemList.isNotEmpty,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(right: 6, left: 6),
                                        child: const Text(
                                          '>',
                                          style: TextStyle(
                                              fontFamily: BaseFont.familyNumber,
                                              fontSize: BaseFont.font13px,
                                              color: BaseColor.attentionColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ),
                // 右側、金額詳細エリア　[項目名　金額]
                Container(
                  padding: const EdgeInsets.only(top: 6),
                  alignment: Alignment.topRight,
                  width: 232.w,
                  height: 128.h,
                  // コンテンツ位置確定用
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // 小計.
                      Obx(
                        () => _buildSubtotalRow(
                          'l_reg_subtotal'.trns,
                          NumberFormatUtil.formatAmount(
                              subtotalCtrl.subtotal.value),
                        ),
                      ),
                      // 値引き対象額
                      Obx(() => Visibility(
                        visible: subtotalCtrl.subDscAmount.value != 0,
                        child: _buildSubtotalRow(
                          ImageDefinitions.IMG_STLDSCPDSC_AMT.imageData,
                          NumberFormatUtil.formatAmount(subtotalCtrl.subDscAmount.value),
                          true,
                        ),
                      )),
                      Obx(() => Visibility(
                            visible: subtotalCtrl.exTaxAmount.value != 0,
                            child: _buildSubtotalRow(
                              ImageDefinitions.IMG_TAX_AMT.imageData,
                              NumberFormatUtil.formatAmount(
                                  subtotalCtrl.exTaxAmount.value),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          // 合計エリア
          Container(
            height: 72.h,
            decoration: BoxDecoration(
              color: RegsMem().refundFlag ? BaseColor.refundAreaBackColor : BaseColor.baseColor,
              border: RegsMem().refundFlag ? Border.all(color: BaseColor.attentionColor, width: 2) : null,
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 11),
                    child: Text(
                      RegsMem().refundFlag ? ImageDefinitions.IMG_RETURN.imageData : ImageDefinitions.IMG_TTL.imageData,
                      style: TextStyle(
                        fontSize: BaseFont.font22px,
                        color: RegsMem().refundFlag
                            ? BaseColor.attentionColor
                            : BaseColor.someTextPopupArea,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Obx(
                    () => Text(
                        NumberFormatUtil.formatAmount(
                            subtotalCtrl.totalAmount.value),
                        style: TextStyle(
                            fontSize: BaseFont.font44px,
                            color: RegsMem().refundFlag
                                ? BaseColor.attentionColor
                                : BaseColor.someTextPopupArea,
                            fontFamily: BaseFont.familyNumber)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 小計の行（小計額、税額など）を構築
  /// label：項目名
  /// value：値
  /// minus:通常モードでの値の正負
  Widget _buildSubtotalRow(String label, String value, [bool minus = false]) {
    // 返品モードの時は、値の正負を反転させる
    bool minusColor = RegsMem().refundFlag ? !minus : minus;
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 8),
      child: SizedBox(
        width: 232.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // 金額とのフォントサイズの差の分下げる.
              padding: const EdgeInsets.only(
                  top: BaseFont.font22px - BaseFont.font16px),
              alignment: Alignment.bottomLeft,
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: BaseFont.familyDefault,
                  fontSize: BaseFont.font16px,
                  color: minusColor
                      ? BaseColor.attentionColor
                      : BaseColor.baseColor,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: BaseFont.familyNumber,
                  fontSize: BaseFont.font22px,
                  color: minusColor
                      ? BaseColor.attentionColor
                      : BaseColor.baseColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 割引／値引の行（値引額、割引率など）を構築
  /// label：項目名
  /// value：値
  Widget _buildDiscountRow(String label, String value, [bool minus = false]) {
    // 返品モードの時は、値の正負を反転させる
    bool plusColor =  RegsMem().refundFlag ? !minus : minus;
    return Padding(
      padding: const EdgeInsets.only(right: 6, left: 6, bottom: 5),
      child: SizedBox(
        width: 182.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width:90.w,
              alignment: Alignment.bottomLeft,
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: BaseFont.familyDefault,
                    fontSize: BaseFont.font14px,
                    color: plusColor
                        ? BaseColor.attentionColor
                        : BaseColor.baseColor,
                ),
              ),
            ),
            Container(
              width:80.w,
              alignment: Alignment.bottomRight,
              child: Text(
                value,
                style: TextStyle(
                    fontFamily: BaseFont.familyNumber,
                    fontSize: BaseFont.font14px,
                    color: plusColor
                      ? BaseColor.attentionColor
                      : BaseColor.baseColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
