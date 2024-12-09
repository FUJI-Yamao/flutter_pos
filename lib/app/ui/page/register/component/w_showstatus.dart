/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/ui/colorfont/c_basefont.dart';

/// 登録画面ステータス表示
class ShowStatusWidget extends StatelessWidget {
  ///コンストラクタ
  const ShowStatusWidget({
    super.key,
    required this.status,
  });

  ///ステータス
  final List status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 12.h,
        left: 8.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              StatusWidget(title: status[0]),
              SizedBox(
                width: 8.w,
              ),
              StatusWidget(title: status[1]),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              StatusWidget(title: status[2]),
              SizedBox(
                width: 8.w,
              ),
              StatusWidget(title: status[3]),
            ],
          )
        ],
      ),
    );
  }
}

/// ステータス表示BOX
class StatusWidget extends StatelessWidget {
  ///コンストラクタ
  const StatusWidget({super.key, required this.title});

  ///タイトル
  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      height: 24,
      decoration: BoxDecoration(
        color: BaseColor.baseColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: BaseFont.font14px,
            color: BaseColor.someTextPopupArea,
            fontFamily: BaseFont.familySub),
      ),
    );
  }
}
