/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';

///フルセルフトップの灰色バー
class FullSelfTopGreyBar extends StatelessWidget {
  final String title;

  const FullSelfTopGreyBar({super.key, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      color: BaseColor.baseColor.withOpacity(0.7),
      child: Text(
        title,
        style: const TextStyle(
          color: BaseColor.someTextPopupArea,
          fontSize: BaseFont.font24px,
          fontFamily: BaseFont.familyDefault,
        ),
      ),
    );
  }
}

///商品点数や合計金額表示する黒色のcontainer
class FullSelfAmountBlackContainer extends StatelessWidget {
  final double height;
  final List<Widget> children;

  const FullSelfAmountBlackContainer({super.key,
    required this.height,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 950.w,
      decoration: BoxDecoration(
        color: BaseColor.maintainButtonAreaBG,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
