/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../colorfont/c_basecolor.dart';
import '../../template/basepage/maintainbase.dart';
import '../component/w_savechangealertmsgdialog.dart';
import '../controller/c_recogkey_confirm_controller.dart';

/// 承認キー 解放される機能確認画面
class RecogekeyConfirmPageWidget extends MaintainBasePage {
  ///コンストラクタ
  RecogekeyConfirmPageWidget({
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    required int bi,
    required String recogkeySaveDes,
  }) {
    controller = Get.put(RecogkeyConfirmController(
      bi: bi,
      recogkeySaveDes: recogkeySaveDes,
    ));
  }

  ///コントローラー
  late final RecogkeyConfirmController controller;

  /// bodyを構築
  @override
  Widget body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: BaseColor.maintainBaseColor,
      child: Container(
        width: 900.w,
        height: 570.h,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 50.h,
              ),
              child: Text(
                'l_recog_sub'.trns,
                style: const TextStyle(
                  fontSize: BaseFont.font26px,
                  color: BaseColor.someTextPopupArea,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 30.h),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (var data in controller.dispRecogkeyList.value)
                    Text(
                      data,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font24px,
                        height: 1 + (6 / 24),
                      ),
                      textAlign: TextAlign.start,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// body下のフッターUI.
  @override
  Widget? footer(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          bottom: 40.h,
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            cancelDecideButton(
                onCancel: () {
                  Get.back(result: 'x');
                },
                onDecide: () async {
                  bool? result =
                      await Get.dialog<bool>(const SaveChangeAlertMsgDialog(
                    title: '確認',
                    msgList: ['承認データ保存します、よろしいですか？'],
                    buttonText1: 'いいえ',
                    buttonText2: 'はい',
                  ));

                  if (result == true) {
                    controller.recogkeySub.recogkeySubFuncMain();
                    Get.back(result: true);
                  }
                },
                decideStr: "実行"),
            SizedBox(
              width: 50.w,
            ),
          ],
        ));
  }
}
