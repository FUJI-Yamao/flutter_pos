/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/ui/colorfont/c_basefont.dart';

/// モード表示
class ModeMessageWidget extends StatelessWidget {
  ///コンストラクタ
  const ModeMessageWidget({
    super.key,
    this.title = '',
    this.message = '',
    this.backColor = BaseColor.someTextPopupArea,
    this.edgeColor = BaseColor.someTextPopupArea,
  });

  /// タイトル
  final String title;
  /// メッセージ
  final String message;
  /// 背景色
  final Color backColor;
  /// 縁の色
  final Color edgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: edgeColor,
        ),
        color: backColor,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(5),
            right: Radius.circular(5)
        ),
      ),
      width: 530.w,
      height: 56.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: 80,
            child: Container(
              height: 28,
              width: 80,
              decoration: const BoxDecoration(
                color: BaseColor.maintainButtonAreaBG,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3)
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: BaseFont.font14px,
                    color: BaseColor.someTextPopupArea,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: BaseFont.font14px,
                color: BaseColor.baseColor,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
