/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_pos/app/ui/page/common/component/w_dicisionbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/w_sound_buttons.dart';
import '../basepage/common_base.dart';

/// メッセージを表示する汎用Widget
/// ２行表示したい場合はmessage1, message2のそれぞれで表示文字列を指定する
/// initFuncは画面起動時の処理を記載する
/// closeFuncはとじるボタン押下時の処理を記載する
/// cancelFuncはキャンセルボタン押下時の処理を記載する
class CommonMessagePage extends CommonBasePage {
  ///　コンストラクタ
  CommonMessagePage({
    this.message1 = '',
    this.message2 = '',
    this.fontSize1 = BaseFont.font32px,
    this.fontSize2 = BaseFont.font32px,
    this.buttonName = 'とじる',
    this.initFunc,
    this.closeFunc,
    this.cancelFunc,
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
          if (initFunc != null) {
            initFunc();
          }
          String className = 'CommonMessagePage';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                if (cancelFunc != null) {
                  cancelFunc();
                } else {
                  Get.back();
                }
              },
              callFunc: '$className ${'l_cmn_cancel'.trns}',
              child: Row(
                children: <Widget>[
                  const Icon(Icons.close,
                      color: BaseColor.someTextPopupArea, size: 45),
                  SizedBox(
                    width: 19.w,
                  ),
                  Text('l_cmn_cancel'.trns,
                      style: const TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px)),
                ],
              ),
            ),
          ];
        });

  /// メッセージ内容1
  final String message1;

  /// メッセージ内容2
  final String message2;

  /// フォントサイズ1
  final double fontSize1;

  /// フォントサイズ2
  final double fontSize2;

  /// 画面起動時の処理
  Function? initFunc;

  /// とじるボタン押下時処理
  Function? closeFunc;

  /// キャンセルボタン押下時処理
  Function? cancelFunc;

  /// ボタンの表示名
  String buttonName;

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: message2.isNotEmpty
                ? Column(
                    children: [
                      Text(
                        message1,
                        style: TextStyle(
                          color: BaseColor.baseColor,
                          fontSize: fontSize1,
                          fontFamily: BaseFont.familyDefault,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        message2,
                        style: TextStyle(
                          color: BaseColor.baseColor,
                          fontSize: fontSize2,
                          fontFamily: BaseFont.familyDefault,
                        ),
                      ),
                    ],
                  )
                : Text(
                    message1,
                    style: TextStyle(
                      color: BaseColor.baseColor,
                      fontSize: fontSize1,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
          ),
          closeFunc != null
              ? DecisionButton(
                  oncallback: () async {
                    if (closeFunc != null) {
                      closeFunc!();
                    }
                  },
                  text: buttonName,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
