/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/page/difference_check/widgets/w_diffcheck_common.dart';
import 'package:flutter_pos/app/ui/page/difference_check/widgets/w_diffcheck_tables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_difference_check.dart';

/// 差異チェック：内訳を表示ボタン押下時の表示
class DiffCheckBreakdownTable {
  /// 内訳表ボタン押下時の表示
  Widget drawBreakdownTable(
      DifferenceCheckStateController differenceCheckReferCtrl,
      setState,
      Type runtimeType,
      DiffCheckCommon diffCheckCommon,
      DiffCheckTables diffCheckTables) {
    return SizedBox(
        width: diffCheckCommon.wholeWidth,
        height: diffCheckCommon.bodyHeight,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 内訳表
          Container(
            margin: EdgeInsets.only(
                left: diffCheckCommon.breakDownLeftMargin,
                right: diffCheckCommon.breakDownRightMargin,
                top: diffCheckCommon.breakDownTableTopMargin),
            alignment: Alignment.topCenter,
            child: diffCheckTables.makeBreakDownTable(
                differenceCheckReferCtrl.breakDownTableData, diffCheckCommon),
          ),

          Container(
              margin: EdgeInsets.only(
                  left: diffCheckCommon.breakDownLeftMargin,
                  top: diffCheckCommon.breakDownBtnTopMargin),
              alignment: Alignment.centerLeft,
              width: diffCheckCommon.breakDownBtnWidth,
              height: diffCheckCommon.breakDownBtnHeight,
              decoration: const BoxDecoration(
                color: BaseColor.otherButtonColor,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: BaseColor.otherButtonColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    width: diffCheckCommon.breakDownBtnWidth,
                    height: diffCheckCommon.breakDownBtnHeight,
                    child: Material(
                      color: BaseColor.transparent,
                      child: SoundInkWell(
                          onTap: () {
                            setState(() {
                              diffCheckCommon.breakdownBool.value = false;
                            });
                            Future(() async {});
                          },
                          callFunc: runtimeType.toString(),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icon_back_arrow_white.svg',
                                  width: diffCheckCommon.breakDownBtnSvgWidth,
                                  height: diffCheckCommon.breakDownBtnSvgHeight,
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                const Text(
                                  '前の画面に戻る',
                                  style: TextStyle(
                                    color: BaseColor.someTextPopupArea,
                                    fontSize: BaseFont.font18px,
                                    fontFamily: BaseFont.familyDefault,
                                  ),
                                ),
                              ])),
                    ),
                  ),
                ],
              ))
        ]));
  }
}
