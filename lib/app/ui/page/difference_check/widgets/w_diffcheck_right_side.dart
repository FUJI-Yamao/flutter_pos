/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/number_util.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../common/component/w_dicisionbutton.dart';
import '../controller/c_difference_check.dart';
import 'w_diffcheck_common.dart';

/// 差異チェックの過不足在高合計等の右側の表示
class DiffarenceCheckRightSideWigit {
  /// 差異チェックの過不足在高合計等の右側の表示
  Widget drawDiffarenceCheckRightSideWigit(
    DifferenceCheckStateController differenceCheckReferCtrl,
    setState,
    Type runtimeType,
    FuncKey funcKey,
    printFunc,
    int conditionsValue,
    String upperLabel,
    String upperValue,
    String downLabel,
    String downValue,
    DiffCheckCommon diffCheckCommon,
  ) {
    return Container(
      width: diffCheckCommon.rightSideWidth,
      height: diffCheckCommon.bodyHeight - diffCheckCommon.appearBtnAreaHeight,
      padding: const EdgeInsets.only(right: 32),
      child: SizedBox(
          width: diffCheckCommon.rightSideWidth,
          height:
              diffCheckCommon.bodyHeight - diffCheckCommon.appearBtnAreaHeight,
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            // 釣り機枚数更新
            SizedBox(
              width: diffCheckCommon.btnWidth,
              height: diffCheckCommon.btnHeight,
              child: Container(
                decoration: const BoxDecoration(
                  color: BaseColor.otherButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                width: diffCheckCommon.btnWidth,
                height: diffCheckCommon.btnHeight,
                child: Material(
                  color: BaseColor.transparent,
                  child: SoundInkWell(
                    onTap: () {
                      // 釣り機データ再取得
                      Future(() async {
                        await differenceCheckReferCtrl.updateChangeData();
                        setState(() {});
                      });
                    },
                    callFunc: runtimeType.toString(),
                    child: const Center(
                      child: Text(
                        '釣り機枚数更新',
                        style: TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px,
                          fontFamily: BaseFont.familyDefault,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            //過不足在高合計
            Column(
              children: [
                diffCheckCommon.drawValueDisplay(
                  topText: "過不足在高合計",
                  downText: NumberFormatUtil.formatAmount(conditionsValue),
                  emergency: (conditionsValue == 0 ? false : true),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            diffCheckCommon.drawValueDisplay(
                topText: upperLabel, downText: upperValue, emergency: false),
            SizedBox(
              height: 8.h,
            ),
            diffCheckCommon.drawValueDisplay(
                topText: downLabel, downText: downValue, emergency: false),
            SizedBox(
              height: 8.h,
            ),
            //理論在高の内訳を表示ボタン
            Container(
              decoration: const BoxDecoration(
                color: BaseColor.otherButtonColor,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              width: diffCheckCommon.labelWigitWidth,
              height: diffCheckCommon.breakdownBtnHeight,
              child: Material(
                color: BaseColor.transparent,
                child: SoundInkWell(
                  onTap: () {
                    setState(() {
                      diffCheckCommon.breakdownBool.value = true;
                      debugPrint(
                          "diffCheckCommon.breakdownBool.value: ${diffCheckCommon.breakdownBool.value}");
                    });
                  },
                  callFunc: runtimeType.toString(),
                  child: const Center(
                    child: Text(
                      '理論在高の内訳を表示',
                      style: TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font18px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              width: diffCheckCommon.btnWidth,
              height: diffCheckCommon.btnHeight,
              //売り上げ回収ボタン
              child: SizedBox(
                width: diffCheckCommon.btnWidth,
                height: diffCheckCommon.btnHeight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: BaseColor.otherButtonColor,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  width: diffCheckCommon.btnWidth,
                  height: diffCheckCommon.btnHeight,
                  child: Material(
                    color: BaseColor.transparent,
                    child: SoundInkWell(
                      onTap: () {
                        setState(() {
                          diffCheckCommon.salesCollectionBool.value = true;
                        });
                      },
                      callFunc: runtimeType.toString(),
                      child: const Center(
                        child: Text(
                          '売上回収',
                          style: TextStyle(
                            color: BaseColor.someTextPopupArea,
                            fontSize: BaseFont.font18px,
                            fontFamily: BaseFont.familyDefault,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            // 印字する
            // BUG 1010 印字するボタン押下時の処理　現在は何もしないでもとに戻る
            DecisionButton(
              oncallback: () async {
                printFunc();
              },
              text: '印字する',
              isdecision: true,
            ),
            SizedBox(
              height: 32.h,
            )
          ])),
    );
  }
}
