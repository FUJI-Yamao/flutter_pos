/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../inc/sys/tpr_dlg.dart';
import '../../../../../colorfont/c_basecolor.dart';
import '../../../../../colorfont/c_basefont.dart';
import '../../../../../component/w_sound_buttons.dart';
import '../../../../common/component/w_msgdialog.dart';

/// マルチ端末機能設定ページ共通UI
abstract class FclSetupBasePage extends StatelessWidget {
  /// コンストラクタ
  const FclSetupBasePage({
    super.key,
    required this.title,
    required this.message,
    this.attentionMessage = "",
    required this.performed,
  });

  /// 画面タイトル
  final String title;

  /// 表示メッセージ
  final String message;

  /// 注記メッセージ
  final String attentionMessage;

  /// 実行時処理
  final VoidCallback? performed;

  /// backボタンを押したときの処理.
  void onBack() {
    // 前画面に戻る
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 80.w,
        leading: SoundElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: BaseColor.someTextPopupArea,
            backgroundColor: BaseColor.maintainButtonAreaBG,
            padding: EdgeInsets.zero,
            minimumSize: Size(80.w, 50.h),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),
          callFunc: '${runtimeType.toString()} $title',
          onPressed: () {
            onBack();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 50,
          ),
        ),
        backgroundColor: BaseColor.maintainTitleBG,
        title: Text(
          title,
          style: const TextStyle(
            color: BaseColor.someTextPopupArea,
            fontSize: BaseFont.font24px,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCustomText(message, BaseColor.baseColor),
                        buildCustomText(attentionMessage,
                            BaseColor.customerPageDiscountTextColor),
                      ]),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: buildCustomElevatedButton(
                        '実行',
                        () {
                          performed?.call();
                        },
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
            height: 80,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildContent(context),
                Container(
                  alignment: Alignment.centerRight,
                  child: buildCustomElevatedButton(
                    '終了',
                    () {
                      onBack();
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      backgroundColor: BaseColor.loginBackColor,
    );
  }

  /// テキストWidget
  Widget buildCustomText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: BaseFont.font28px,
        height: 1.5,
        color: color,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  /// ボタンWidget
  Widget buildCustomElevatedButton(
      String buttonText, VoidCallback onPressedCallback) {
    Color buttonColor = BaseColor.otherButtonColor;
    String callFunc = 'buildCustomElevatedButton';

    return SizedBox(
      height: 80.h,
      width: 200.w,
      child: SoundElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: const BorderSide(
              color: BaseColor.edgeBtnTenkeyColor,
              width: 1,
            ),
          ),
          backgroundColor: buttonColor,
          foregroundColor: BaseColor.someTextPopupArea,
          elevation: 2,
        ),
        onPressed: () {
          onPressedCallback(); // 既存のコールバックを呼び出し
        },
        callFunc: '$callFunc $buttonText',
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context);
}
