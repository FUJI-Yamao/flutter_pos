/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import '../../../../component/w_inputbox.dart';
import '../../template/basepage/maintainbase.dart';
import '../controller/c_keyboard_controller.dart';
import '../model/m_specfile.dart';
import 'w_urlwidget.dart';

/// スペックファイル用テンキーダイアログ（URL入力）
class UrlDialog extends MaintainBasePage {
  ///コンストラクタ
  UrlDialog({
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    required this.text,
    required this.initValue,
    required this.isShow,
    required this.setting,
  });

  ///テキスト内容
  final String text;

  ///　初期値
  final String initValue;

  ///表示フラグ
  final bool isShow;

  ///入力設定
  late StringInputSetting setting;

  ///入力ボックスのグローバルキー
  final inputBox = GlobalKey<InputBoxWidgetState>();

  @override
  Widget body(BuildContext context) {
    ///コントローラー
    KeyboardController c = Get.put(KeyboardController(inputBox, setting));
    return Scaffold(
      backgroundColor: BaseColor.maintainBaseColor,
      body: Container(
        color: BaseColor.maintainBaseColor,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      width: 700.w,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: BaseFont.font28px,
                              color: BaseColor.someTextPopupArea,
                              letterSpacing: 6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),

            /// 入力ボックスとテンキーを表示
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                InputBoxWidget(
                  key: inputBox,
                  width: 800.w,
                  height: 50.h,
                  fontSize: BaseFont.font24px,
                  textAlign: TextAlign.left,
                  initStr: initValue,
                  mode: InputBoxMode.defaultMode,
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (isShow)
                  SizedBox(
                    width: 800.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_rounded,
                            color: BaseColor.someTextPopupArea),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: const Text(
                            "4桁の数字を３セット入力してください",
                            style: TextStyle(
                                fontSize: BaseFont.font20px,
                                color: BaseColor.someTextPopupArea),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 50.h,
                ),
                UrlWidget(controller: c),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
