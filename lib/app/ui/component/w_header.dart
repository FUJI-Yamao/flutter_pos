/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
/// ラベル/テキストWidgetを使ったヘッダーWidget

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/app/ui/model/m_widgetsetting.dart';
import 'w_label.dart';

/// ヘッダー用Widget
class HeaderTitleWidget extends StatelessWidget {
  const HeaderTitleWidget({
    super.key,
    required this.headersetting,
  });
  final headersetting;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 2.w, right: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: headersetting.value.isBtnShow ? 944.w : 1010.w,
            height: 55.h,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              left: 1.w,
            ),
            padding: EdgeInsets.only(left: 10),
            // タイトル
            child: Row(
              children: [
                Container(
                  // height: 200,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(5)),
                  child: Obx(
                    () => Text(
                      headersetting.value.title,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.white),
                    ),
                  ),
                ),
                // 注釈
                Expanded(
                  child: Center(
                    child: Text(
                      headersetting.value.comment,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (headersetting.value.isBtnShow)
            LabelBtnWidget(
              setting: BtnSetting(
                backcolor: headersetting.value.btnSetting.value.backcolor,
                bordercolor: headersetting.value.btnSetting.value.bordercolor,
                shadowcolor: headersetting.value.btnSetting.value.shadowcolor,
                textcolor: headersetting.value.btnSetting.value.textcolor,
                text: headersetting.value.btnSetting.value.text,
                onTap: headersetting.value.btnSetting.value.onTap,
              ).obs,
            ),
        ],
      ),
    );
  }
}
