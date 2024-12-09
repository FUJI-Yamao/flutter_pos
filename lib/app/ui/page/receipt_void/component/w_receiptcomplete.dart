/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_pos/app/ui/page/common/basepage/common_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/component/w_dicisionbutton.dart';
import '../controller/c_receiptcomplete_ctrl.dart';

///通番訂正完了と返金金額　レシート再発行のページ
class ReceiptCompletePage extends CommonBasePage {
  /// コントローラー
  final completeCtrl = Get.put(ReceiptCompleteController());

  /// コンストラクタ
  ReceiptCompletePage({super.key, required this.title})
      : super(
          title: title,
          buildActionsCallback: (context) => [],
        );

  /// アクションボタンの生成
  List<Widget> buildAction(BuildContext context) {
    return [];
  }

  ///テキストスタイル
  final receiptTextStyle = const TextStyle(
    fontSize: BaseFont.font24px,
    color: BaseColor.baseColor,
    fontFamily: BaseFont.familyDefault,
  );

  ///　画面タイトル
  final String title;

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Container(
              width: 1.sw,
              color: BaseColor.someTextPopupArea,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.125.sh,
                    left: 0.24.sw,
                    child: SizedBox(
                      width: 536.w,
                      height: 56.h,
                      child: Row(
                        children: [
                          ///返金ラベル
                          Container(
                            width: 160.w,
                            height: 56.h,
                            color: BaseColor.baseColor,
                            child: Center(
                              child: Text(
                                "返金",
                                style: receiptTextStyle.copyWith(
                                  color: BaseColor.someTextPopupArea,
                                  fontSize: BaseFont.font22px,
                                ),
                              ),
                            ),
                          ),
                          //返金金額
                          Container(
                            width: 376.w,
                            color: BaseColor.receiptBottomColor,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 40.w),
                                child: Obx(
                                  () => Text(
                                    "¥${completeCtrl.refund}",
                                    style: const TextStyle(
                                      fontFamily: BaseFont.familyNumber,
                                      fontSize: BaseFont.font28px,
                                      color: BaseColor.baseColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///完了と再発行ボタン
                  Positioned(
                    top: 0.25.sh,
                    left: 0.24.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("取引を通番訂正しました", style: receiptTextStyle),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "「完了」を選択すると処理を終了します",
                          style: receiptTextStyle,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SoundElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BaseColor.someTextPopupArea,
                                fixedSize: Size(210.w, 80.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: const BorderSide(
                                      color: BaseColor.edgeBtnTenkeyColor),
                                ),
                                shadowColor: BaseColor.dropShadowColor,
                                elevation: 3,
                              ),
                              callFunc: runtimeType.toString(),
                              onPressed: () {},
                              child: Text(
                                "レシート再発行",
                                style: receiptTextStyle.copyWith(
                                    fontSize: BaseFont.font22px),
                              ),
                            ),
                            SizedBox(width: 136.w),
                            DecisionButton(
                              oncallback: completeCtrl.onCompletedButtonPressed,
                              text: '完了',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 再売り上げボタン
          Container(
            width: double.infinity,
            height: 200.h,
            color: BaseColor.receiptBottomColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Text("元の取り引きを呼び出して操作をし直す", style: receiptTextStyle),
                SizedBox(height: 32.h),
                SizedBox(
                  width: 200.w,
                  height: 80.h,
                  child: SoundElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BaseColor.receiptButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      shadowColor: BaseColor.dropShadowColor,
                      elevation: 3,
                    ),
                    callFunc: runtimeType.toString(),
                    onPressed: completeCtrl.onResaleButtonPressed,
                    child: Text(
                      "再売り上げ",
                      style: receiptTextStyle.copyWith(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font22px),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
