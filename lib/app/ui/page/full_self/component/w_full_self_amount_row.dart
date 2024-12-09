/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';

//お支払い金額欄の構築
class FullSelfAmountRow extends StatelessWidget {
  final String label;
  final String value;

  final bool isTotal;

  const FullSelfAmountRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isTotal) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: 24,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Text(
              value,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: 48,
                fontFamily: BaseFont.familyNumber,
              ),
            ),
          ]);
    } else {
      return Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: BaseColor.someTextPopupArea,
              fontSize: 22,
              fontFamily: BaseFont.familyDefault,
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Text(
            value,
            style: const TextStyle(
              color: BaseColor.someTextPopupArea,
              fontSize: 22,
              fontFamily: BaseFont.familyNumber,
            ),
          ),
        ],
      );
    }
  }
}
