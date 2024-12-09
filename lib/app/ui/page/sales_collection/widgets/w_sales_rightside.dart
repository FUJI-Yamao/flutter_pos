/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/component/w_dicisionbutton.dart';
import '../../difference_check/widgets/w_diffcheck_common.dart';
import '../controller/c_sales_collection.dart';

/// 売上回収画面の右側の表示
class SalesRightSide {
  /// 売上回収画面の右側の表示
  Widget salesRightSide(
    SalesCollectionStateController selesCollectionReferCtrl,
    printFunc,
    String topText,
    String downText,
    DiffCheckCommon diffCheckCommon,
  ) {
    return SizedBox(
        width: diffCheckCommon.rightSideWidth,
        height:
            diffCheckCommon.bodyHeight - diffCheckCommon.appearBtnAreaHeight,
        child: Container(
          width: diffCheckCommon.rightSideWidth,
          height:
              diffCheckCommon.bodyHeight - diffCheckCommon.appearBtnAreaHeight,
          padding: const EdgeInsets.only(top: 32, right: 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(
                width: diffCheckCommon.labelWigitWidth,
                height: diffCheckCommon.labelWholeHeight,
                child: diffCheckCommon.drawValueDisplay(
                    topText: topText, downText: downText)),
            SizedBox(
              height: diffCheckCommon.bodyHeight -
                  diffCheckCommon.appearBtnAreaHeight -
                  diffCheckCommon.labelWholeHeight -
                  82.h - //ボタンの大きさ
                  64.h, //下の余白分
              width: diffCheckCommon.rightSideWidth,
            ),
            //BUG 売上回収印字部分未実装
            DecisionButton(
              oncallback: () async {
                printFunc();
              },
              text: '確定する',
              isdecision: true,
            ),
          ]),
        ));
  }
}
