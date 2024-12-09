/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/number_util.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';

/// プリカ残高照会ダイアログの内容
class DialogContentPrecaRef extends StatelessWidget {
  final int price;

  DialogContentPrecaRef({
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'プリカ残高',
                style: TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
              Text(
                NumberFormatUtil.formatAmount(price),
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font44px,
                  fontFamily: BaseFont.familyNumber,
                ),
              ),
            ],
          ),
          const Divider(
            color: BaseColor.edgeBtnColor,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
