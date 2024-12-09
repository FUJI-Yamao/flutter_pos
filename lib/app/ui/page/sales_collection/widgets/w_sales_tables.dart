/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../difference_check/model/m_changemodels.dart';
import '../../difference_check/widgets/w_diffcheck_common.dart';

/// 売上回収画面の表
class SalesTable {
  /// 売上回収画面の表
  Widget salesTable({
    required List<ChangeData> changeData,
    required String titleLeftText,
    required int titleRightText,
    required int billCoinCount,
    drawerKeyList,
    selesCollectionReferCtrl,
    required DiffCheckCommon diffCheckCommon,
  }) {
    return Stack(
      children: [
        SizedBox(
          width: diffCheckCommon.tableRowWidth,
          child: Column(
            children: [
              SizedBox(
                width: diffCheckCommon.tableRowWidth,
                height: diffCheckCommon.tableHeaderHeight,
              ),
              for (int i = 0; i < billCoinCount; i++)
                buildDrawerRow(
                  index: i,
                  billCoinType: changeData[i].billCoinType,
                  leftText: changeData[i].amount.toString(),
                  displayText: changeData[i].value.toString(),
                  keyList: drawerKeyList,
                  selesCollectionReferCtrl: selesCollectionReferCtrl,
                  diffCheckCommon: diffCheckCommon,
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// 売り上げ回収　表データ作成
  Widget buildDrawerRow({
    required int index,
    required BillCoinType billCoinType,
    String leftText = '',
    String displayText = '',
    List<GlobalKey<InputBoxWidgetState>>? keyList,
    selesCollectionReferCtrl,
    diffCheckCommon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        width: diffCheckCommon.tableRowWidth,
        height: diffCheckCommon.tableRowHeight,
        decoration: const BoxDecoration(
          color: BaseColor.someTextPopupArea,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: diffCheckCommon.tableIconAriaWidth,
                height: diffCheckCommon.tableRowHeight,
                alignment: Alignment.center,
                child: Center(
                  child: billCoinType == BillCoinType.bill
                      ? SvgPicture.asset(
                          'assets/images/icon_bill_large.svg',
                          width: 32,
                          height: 32,
                        )
                      : SvgPicture.asset(
                          'assets/images/icon_coin_large.svg',
                          width: 32,
                          height: 32,
                        ),
                ),
              ),
              Container(
                width: diffCheckCommon.tableLabelAriaWidth,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      leftText,
                      style: const TextStyle(
                        fontSize: BaseFont.font22px,
                        fontFamily: BaseFont.familyDefault, //.familyNumber,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      '円',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: BaseColor.changeCoinBillCoinColor,
                        fontSize: BaseFont.font18px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  width: diffCheckCommon.tableInputAriaWidth,
                  child: InputBoxWidget(
                    initStr: displayText,
                    key: keyList![index],
                    width: diffCheckCommon.tableInputAriaWidth,
                    height: diffCheckCommon.tableInputAriaHeight,
                    fontSize: BaseFont.font22px,
                    textAlign: TextAlign.right,
                    padding: const EdgeInsets.only(right: 4),
                    cursorColor: BaseColor.baseColor,
                    unfocusedBorder: BaseColor.inputFieldColor,
                    focusedBorder: BaseColor.accentsColor,
                    focusedColor: BaseColor.inputBaseColor,
                    borderRadius: 4,
                    blurRadius: 6,
                    funcBoxTap: () {
                      selesCollectionReferCtrl.onInputBoxTap(index);
                    },
                    iniShowCursor: false,
                    mode: InputBoxMode.defaultMode,
                  )),
              Container(
                alignment: Alignment.centerLeft,
                width: diffCheckCommon.tableUnitAriaWidth,
                child: const Text(
                  textAlign: TextAlign.left,
                  '枚',
                  style: TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///現金以外表
  Widget salesNonCashTable(
    int nonCashSum,
    List<NonCashData> dataList,
    scrollController,
    List<GlobalKey<InputBoxWidgetState>>? keyList,
    differenceCheckReferCtrl,
    diffCheckCommon,
  ) {
    return SizedBox(
      width: diffCheckCommon.tableAreaWidth,
      height: diffCheckCommon.nonCashTableWholeHeight,
      child: Column(children: [
        SizedBox(
          width: diffCheckCommon.tableAreaWidth,
          height: diffCheckCommon.tableHeaderHeight,
        ),
        // スクロールするように
        SizedBox(
          width: diffCheckCommon.tableAreaWidth,
          height: diffCheckCommon.nonCashTableWholeHeight -
              diffCheckCommon.tableHeaderHeight,
          child: Scrollbar(
            thumbVisibility: true,
            controller: scrollController,
            child: ListView(
              controller: scrollController,
              children: [
                for (int i = 0; i < dataList.length; i++)
                  // 2回に１回実施(横並び用)
                  if (i % 2 == 0)
                    if (i + 1 < dataList.length)
                      Row(children: [
                        nonCashTableData(
                          leftText: dataList[i].title,
                          rightText: dataList[i].value.toString(),
                          keyList: keyList,
                          differenceCheckReferCtrl: differenceCheckReferCtrl,
                          index:
                              i + differenceCheckReferCtrl.drawerInputBoxNumber,
                          diffCheckCommon: diffCheckCommon,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        nonCashTableData(
                          leftText: dataList[i + 1].title,
                          rightText: dataList[i + 1].value.toString(),
                          keyList: keyList,
                          differenceCheckReferCtrl: differenceCheckReferCtrl,
                          index: i +
                              1 +
                              differenceCheckReferCtrl.drawerInputBoxNumber,
                          diffCheckCommon: diffCheckCommon,
                        ),
                      ])
                    else
                      //端数発生するので調整
                      Row(children: [
                        nonCashTableData(
                          leftText: dataList[i].title,
                          rightText: dataList[i].value.toString(),
                          keyList: keyList,
                          differenceCheckReferCtrl: differenceCheckReferCtrl,
                          index:
                              i + differenceCheckReferCtrl.drawerInputBoxNumber,
                          diffCheckCommon: diffCheckCommon,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: diffCheckCommon.nonCashTableRowHeight,
                          width: diffCheckCommon.nonCashTableRowWidth,
                          color: BaseColor.someTextPopupArea,
                        ),
                      ])
              ],
            ),
          ),
        )
      ]),
    );
  }

  ///現金以外の表のテーブルデータ作成
  Widget nonCashTableData({
    String leftText = '',
    String rightText = '',
    List<GlobalKey<InputBoxWidgetState>>? keyList,
    differenceCheckReferCtrl,
    index,
    diffCheckCommon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        width: diffCheckCommon.nonCashTableRowWidth,
        height: diffCheckCommon.nonCashTableRowHeight,
        decoration: const BoxDecoration(
          color: BaseColor.someTextPopupArea,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 会計 品券
            Container(
                width: diffCheckCommon.nonCashTableRowLeftAreaWidth,
                height: diffCheckCommon.nonCashTableRowHeight - 4, //padding分
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    SizedBox(
                        width:
                            diffCheckCommon.nonCashTableRowLeftAreaWidth - 20.w,
                        child: Text(leftText,
                            style: const TextStyle(
                              fontSize: BaseFont.font18px,
                              fontFamily:
                                  BaseFont.familyDefault, //.familyNumber,
                            ))),
                  ],
                )),
            Container(
                alignment: Alignment.centerRight,
                width: diffCheckCommon.nonCashTableInputAriaWidth,
                child: InputBoxWidget(
                  initStr: rightText,
                  key: keyList![index],
                  width: diffCheckCommon.nonCashTableInputAriaWidth,
                  height: diffCheckCommon.tableInputAriaHeight,
                  fontSize: BaseFont.font22px,
                  textAlign: TextAlign.right,
                  padding: const EdgeInsets.only(right: 4),
                  cursorColor: BaseColor.baseColor,
                  unfocusedBorder: BaseColor.inputFieldColor,
                  focusedBorder: BaseColor.accentsColor,
                  focusedColor: BaseColor.inputBaseColor,
                  borderRadius: 4,
                  blurRadius: 6,
                  funcBoxTap: () {
                    differenceCheckReferCtrl.onInputBoxTap(index);
                  },
                  iniShowCursor: false,
                  mode: InputBoxMode.payNumber,
                )),
            SizedBox(width: diffCheckCommon.tableUnitAriaWidth)
          ],
        ),
      ),
    );
  }
}
