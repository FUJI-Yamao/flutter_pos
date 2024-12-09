/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// ラベル/ボタン用Widget

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/app/ui/language/l_languagedbcall.dart';

/// ラベル/ボタン用Widget
class LabelBtnTrnsWidget extends StatelessWidget {
  const LabelBtnTrnsWidget({
    super.key,
    required this.setting,
  });

  final setting;

  Widget build(BuildContext context) {
    return Obx(
      () =>
          // Visibility(
          //   child:
          InkWell(
        onTap: () {
          setting.value.isSelectedKey = true;
          setting.value.onTap?.call();
        },
        splashColor: Colors.pink,
        child: Container(
          margin: setting.value.margin,
          alignment: setting.value.alignment,
          padding: setting.value.padding,
          // EdgeInsets.all(1),
          height: ScreenUtil().setHeight(setting.value.height),
          width: ScreenUtil().setWidth(setting.value.width),
          decoration: BoxDecoration(
            color: setting.value.backcolor, // .withOpacity(0.3)
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: setting.value.shadowcolor,
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(2, 3),
              ),
            ],
            border: Border.all(
              color: setting.value.bordercolor,
              width: ScreenUtil().setWidth(2.0),
            ),
          ),
          child: Text(
            '${setting.value.text}'.trns,
            style: TextStyle(
                color: setting.value.textcolor,
                fontSize: ScreenUtil().setSp(setting.value.fontsize)),
          ),
        ),
      ),
      // ),
    );
  }
}
