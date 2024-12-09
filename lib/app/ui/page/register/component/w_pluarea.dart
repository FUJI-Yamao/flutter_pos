/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/c_registerpluare_controller.dart';
import 'w_plubuttonarea.dart';
import 'w_plutabarea.dart';

/// PLUタブ/PLUボタンエリア
class PluArea extends StatelessWidget {
  /// コンストラクタ
  const PluArea({super.key});

  @override
  Widget build(BuildContext context) {
    ///　コントローラ
    Get.put(PluAreaController());
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8.h, right: 10.w),
          height: 574.h,
          width: 528.w,
          child:  const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PluButtonArea(),
              PluTabArea(),
            ],
          ),
        ),
      ],
    );
  }
}
