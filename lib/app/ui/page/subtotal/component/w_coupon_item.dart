/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/page/subtotal/controller/c_coupons_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basefont.dart';
import '../../../component/w_ignore_scrollbar.dart';

/// 品券の構築
class CouponItem extends StatelessWidget {
  final String title;
  final String amount;
  final String count;

  const CouponItem({
    super.key,
    required this.title,
    required this.amount,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.button,
        color: BaseColor.transparentColor,
        child: Container(
          width: 432.w,
          height: 48,
          decoration: BoxDecoration(
            color: BaseColor.someTextPopupArea,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: BaseColor.edgeBtnTenkeyColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 165.w,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: BaseFont.familyDefault,
                      fontSize: BaseFont.font18px,
                      color: BaseColor.baseColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 75.w,
                  child: Text(
                    count,
                    style: const TextStyle(
                      fontFamily: BaseFont.familyNumber,
                      fontSize: BaseFont.font18px,
                      color: BaseColor.baseColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 158.w,
                  child: Text(
                    amount,
                    style: const TextStyle(
                      fontFamily: BaseFont.familyNumber,
                      fontSize: BaseFont.font22px,
                      color: BaseColor.baseColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CouponWidget extends StatefulWidget {
  /// コンストラクタ
  const CouponWidget({super.key});

  @override
  State<CouponWidget> createState() => CouponWidgetState();
}

class CouponWidgetState extends State<CouponWidget> {
  final CouponsController couponCtrl = Get.find();

  /// グローバルキー
  final GlobalKey _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      height: 152,
      child: Obx(
        () => Visibility(
          visible: couponCtrl.showCouponList.value,
          child: IgnoreScrollbar(
            scrollController: couponCtrl.purchaseScrollController,
            child: Obx(
              () {
                Widget listView = ListView.separated(
                  controller: couponCtrl.purchaseScrollController,
                  key: _listKey,
                  itemCount: couponCtrl.coupons.length,
                  itemBuilder: (context, index) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        var renderObj =
                            _listKey.currentContext?.findRenderObject();
                        // RenderObjectを取得できない場合は処理終了
                        if (renderObj == null) {
                          return;
                        }

                        // スクロール一回分の高さを取得
                        final RenderBox renderBox = renderObj as RenderBox;
                        couponCtrl.scrollHeight.value = renderBox.size.height;

                        // リスト表示後のボタン状態を設定
                        couponCtrl.setButtonState();
                      });
                    });

                    return CouponItem(
                      title: couponCtrl.coupons[index]['title'] ?? '',
                      amount: couponCtrl.coupons[index]['amount'] ?? '',
                      count: couponCtrl.coupons[index]['count'] ?? '',
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(height: 4);
                  },
                );

                return Scrollbar(
                    controller: couponCtrl.purchaseScrollController,
                    child: listView);
              },
            ),
          ),
        ),
      ),
    );
  }
}