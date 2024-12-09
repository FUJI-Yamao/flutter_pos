/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';

///商品詳細のアイテムコンテナー（青と白色）
class ProductInfoContainer extends StatelessWidget {
  final List<Map<String, dynamic>> productDetails;
  final double itemHeight;

  ProductInfoContainer({
    required this.productDetails,
    this.itemHeight = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: itemHeight * 4 + 70,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (productDetails.isNotEmpty)
              Container(
                width: 950.w,
                height: 75.h,
                color: BaseColor.accentsColor,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: productDetails[0]['name'] != ''
                    ? Row(
                        children: [
                          Text(
                            productDetails[0]['name'],
                            style: const TextStyle(
                              color: BaseColor.someTextPopupArea,
                              fontSize: 36,
                              fontFamily: BaseFont.familyDefault,
                            ),
                          ),
                          Spacer(),
                          if (productDetails[0]['quantity'] != '')
                            Text(
                              '${productDetails[0]['quantity']} 点',
                              style: const TextStyle(
                                color: BaseColor.someTextPopupArea,
                                fontSize: 36,
                                fontFamily: BaseFont.familyDefault,
                              ),
                            ),
                          SizedBox(
                            width: 100.w,
                          ),
                          if (productDetails[0]['price'] != '')
                            Text(
                              '¥${(productDetails[0]['quantity'] as int) * (productDetails[0]['price'] as int)}',
                              style: const TextStyle(
                                color: BaseColor.someTextPopupArea,
                                fontSize: 36,
                                fontFamily: BaseFont.familyDefault,
                              ),
                            ),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
            ...productDetails.asMap().entries.skip(1).map((entry) {
              int index = entry.key;
              var detail = entry.value;
              return Container(
                width: 950.w,
                height: itemHeight,
                color: index % 2 == 0
                    ? BaseColor.someTextPopupArea
                    : BaseColor.newBaseColor,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: detail['name'] != ''
                    ? Row(
                        children: [
                          Text(
                            detail['name'],
                            style: const TextStyle(
                              color: BaseColor.baseColor,
                              fontSize: 24,
                              fontFamily: BaseFont.familySub,
                            ),
                          ),
                          Spacer(),
                          if (productDetails[0]['quantity'] != '')
                            Text(
                              '${detail['quantity']}点',
                              style: const TextStyle(
                                color: BaseColor.baseColor,
                                fontSize: 24,
                                fontFamily: BaseFont.familySub,
                              ),
                            ),
                          SizedBox(
                            width: 125.w,
                          ),
                          if (productDetails[0]['price'] != '')
                            Text(
                              '¥${(detail['quantity'] as int) * (detail['price'] as int)}',
                              style: const TextStyle(
                                color: BaseColor.baseColor,
                                fontSize: 24,
                                fontFamily: BaseFont.familySub,
                              ),
                            ),
                        ],
                      )
                    : SizedBox.shrink(),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
