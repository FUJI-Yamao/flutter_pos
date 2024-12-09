/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../component/w_inputbox.dart';
import '../model/m_changemodels.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../../common/number_util.dart';
import 'w_diffcheck_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 差異チェックで使用する表
class DiffCheckTables {
  /// 釣銭在高用
  /// [leftText]  左ラベルテキスト
  /// [rightText] 右ラベルテキスト
  Widget changeTable(
      {required List<ChangeData> changeData,
      required String leftText,
      required String rightText,
      required int billCoinCount,
      required DiffCheckCommon diffCheckCommon}) {
    return Stack(
      children: [
        SizedBox(
          width: diffCheckCommon.tableRowWidth,
          child: Column(
            children: [
              buildTitleRow(
                leftText: leftText,
                rightText: rightText,
                diffCheckCommon: diffCheckCommon,
              ),
              for (int i = 0; i < billCoinCount; i++)
                buildDataRow(
                  billCoinType: changeData[i].billCoinType,
                  leftText: changeData[i].amount.toString(),
                  centerText: changeData[i].value.toString(),
                  diffCheckCommon: diffCheckCommon,
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// 内訳を表示する表
  Widget makeBreakDownTable(
      List<BreakDownData> breakDownData, DiffCheckCommon diffCheckCommon) {
    return SizedBox(
      width: diffCheckCommon.breakDownTableWidth,
      height: diffCheckCommon.breakDownTableHeight,
      child: Table(
        children: [
          //Table header
          TableRow(
            decoration: const BoxDecoration(
              color: BaseColor.someTextPopupArea,
            ),
            children: [
              Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: BaseColor.baseColor,
                  ),
                  alignment: Alignment.center,
                  height: diffCheckCommon.tableRowHeight,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Text(
                      '',
                      style: TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: BaseColor.baseColor,
                  ),
                  alignment: Alignment.center,
                  height: diffCheckCommon.tableRowHeight,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      '現金在高',
                      style: TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: BaseColor.baseColor,
                  ),
                  alignment: Alignment.center,
                  height: diffCheckCommon.tableRowHeight,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Text(
                      '会計在高',
                      style: TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: BaseColor.baseColor,
                  ),
                  alignment: Alignment.center,
                  height: diffCheckCommon.tableRowHeight,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Text(
                      '品券在高',
                      style: TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: BaseColor.changeCoinReferTitleColor,
                ),
                alignment: Alignment.center,
                height: diffCheckCommon.tableRowHeight,
                child: const Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: Text(
                    '合計',
                    style: TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font20px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //データ部分
          for (int i = 0; i < breakDownData.length - 1; i++)
            TableRow(
              decoration: const BoxDecoration(
                color: BaseColor.someTextPopupArea,
              ),
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    height: diffCheckCommon.tableRowHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        breakDownData[i].header,
                        style: const TextStyle(
                          color: BaseColor.baseColor,
                          fontSize: BaseFont.font20px,
                          fontFamily: BaseFont.familyDefault,
                        ),
                      ),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  height: diffCheckCommon.tableRowHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      NumberFormatUtil.formatAmount(
                          breakDownData[i].cashStockData),
                      style: const TextStyle(
                        color: BaseColor.baseColor,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: diffCheckCommon.tableRowHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      NumberFormatUtil.formatAmount(
                          breakDownData[i].accountStockData),
                      style: const TextStyle(
                        color: BaseColor.baseColor,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: diffCheckCommon.tableRowHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      NumberFormatUtil.formatAmount(
                          breakDownData[i].giftCardStockData),
                      style: const TextStyle(
                        color: BaseColor.baseColor,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: BaseColor.baseColor,
                  ),
                  alignment: Alignment.centerRight,
                  height: diffCheckCommon.tableRowHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      NumberFormatUtil.formatAmount(breakDownData[i].rowSum),
                      style: const TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          //合計
          TableRow(
            children: [
              Container(
                  decoration: const BoxDecoration(
                    color: BaseColor.changeCoinReferTitleColor,
                  ),
                  alignment: Alignment.centerLeft,
                  height: diffCheckCommon.tableRowHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      breakDownData.last.header,
                      style: const TextStyle(
                        color: BaseColor.someTextPopupArea,
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  )),
              Container(
                decoration: const BoxDecoration(
                  color: BaseColor.baseColor,
                ),
                alignment: Alignment.centerRight,
                height: diffCheckCommon.tableRowHeight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    NumberFormatUtil.formatAmount(
                            breakDownData.last.cashStockData)
                        .toString(),
                    style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font20px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: BaseColor.baseColor,
                ),
                alignment: Alignment.centerRight,
                height: diffCheckCommon.tableRowHeight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    NumberFormatUtil.formatAmount(
                        breakDownData.last.accountStockData),
                    style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font20px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: BaseColor.baseColor,
                ),
                alignment: Alignment.centerRight,
                height: diffCheckCommon.tableRowHeight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    NumberFormatUtil.formatAmount(
                        breakDownData.last.giftCardStockData),
                    style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font20px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: BaseColor.baseColor,
                ),
                alignment: Alignment.centerRight,
                height: diffCheckCommon.tableRowHeight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    NumberFormatUtil.formatAmount(breakDownData.last.rowSum),
                    style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font20px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// 釣銭機の各データ行を作成する
  /// [leftText]    左ラベルテキスト
  /// [centerText]  中央ラベルテキスト
  Widget buildDataRow({
    required BillCoinType billCoinType,
    required String leftText,
    required String centerText,
    required DiffCheckCommon diffCheckCommon,
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
                        fontSize: BaseFont.font20px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      width: diffCheckCommon.tableValueAriaWidth,
                      child: Text(
                        centerText,
                        style: const TextStyle(
                          color: BaseColor.baseColor,
                          fontSize: BaseFont.font22px,
                          fontFamily: BaseFont.familyNumber,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: diffCheckCommon.tableUnitAriaWidth,
                      child: const Text(
                        textAlign: TextAlign.left,
                        '枚',
                        style: TextStyle(
                          color: BaseColor.baseColor,
                          fontSize: BaseFont.font20px,
                          fontFamily: BaseFont.familyDefault,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 各タイトルを作成する
  /// [leftText]  左ラベルテキスト
  /// [rightText] 右ラベルテキスト
  Widget buildTitleRow(
      {required String leftText,
      required String rightText,
      required DiffCheckCommon diffCheckCommon}) {
    return Container(
      color: BaseColor.changeCoinReferTitleColor,
      width: diffCheckCommon.tableRowWidth,
      height: diffCheckCommon.tableHeaderHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: diffCheckCommon.tableHeaderLabelWidth,
            color: BaseColor.changeCoinReferTitleColor,
            alignment: Alignment.center,
            child: Text(
              leftText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font16px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          Container(
            color: BaseColor.baseColor,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 32),
            width: diffCheckCommon.tableHeaderBodyWidth,
            child: Text(
              textAlign: TextAlign.right,
              rightText,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font28px,
                fontFamily: BaseFont.familyNumber,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 現金以外を表示ボタン押下時に表示されるのデータ作成用
  /// [leftText]  左ラベルテキスト
  /// [rightText] 右ラベルテキスト
  Widget nonCashTableTitleRow(
    String leftText,
    String rightText,
    DiffCheckCommon diffCheckCommon,
  ) {
    double rightAreaWidth =
        (diffCheckCommon.tableAreaWidth - diffCheckCommon.tableHeaderLabelWidth)
            .w;

    return Container(
      color: BaseColor.changeCoinReferTitleColor,
      width: diffCheckCommon.tableAreaWidth,
      height: diffCheckCommon.tableHeaderHeight,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: diffCheckCommon.tableHeaderLabelWidth,
            color: BaseColor.changeCoinReferTitleColor,
            alignment: Alignment.center,
            child: Text(
              leftText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font16px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          Container(
            color: BaseColor.baseColor,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 32),
            width: rightAreaWidth,
            child: Text(
              textAlign: TextAlign.right,
              rightText,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font28px,
                fontFamily: BaseFont.familyNumber,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 現金以外表示　表
  Widget nonCashTable({
    required int nonCashSum,
    required List<NonCashData> dataList,
    scrollController,
    List<GlobalKey<InputBoxWidgetState>>? keyList,
    differenceCheckReferCtrl,
    diffCheckCommon,
  }) {
    return SizedBox(
      width: diffCheckCommon.tableAreaWidth,
      height: diffCheckCommon.nonCashTableWholeHeight,
      child: Column(children: [
        SizedBox(
          height: diffCheckCommon.tableHeaderHeight,
          child: nonCashTableTitleRow(
            '現金外在高',
            NumberFormatUtil.formatAmount(nonCashSum).toString(),
            diffCheckCommon,
          ),
        ),

        // スクロールするように
        SizedBox(
            width: diffCheckCommon.tableAreaWidth,
            height: diffCheckCommon.nonCashTableWholeHeight -
                diffCheckCommon.tableHeaderHeight,
            child: Scrollbar(
                thumbVisibility: true,
                controller: scrollController,
                child: ListView(controller: scrollController, children: [
                  for (int i = 0; i < dataList.length; i++)
                    // 2回に１回実施(横並び用)
                    if (i % 2 == 0)
                      if (i + 1 < dataList.length)
                        Row(children: [
                          nonCashTableData(
                            leftText: dataList[i].title,
                            rightText: NumberFormatUtil.formatAmount(
                                dataList[i].value),
                            keyList: keyList,
                            differenceCheckReferCtrl: differenceCheckReferCtrl,
                            index: i +
                                differenceCheckReferCtrl.drawerInputBoxNumber,
                            diffCheckCommon: diffCheckCommon,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          nonCashTableData(
                            leftText: dataList[i + 1].title,
                            rightText: NumberFormatUtil.formatAmount(
                                dataList[i + 1].value),
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
                            index: i +
                                differenceCheckReferCtrl.drawerInputBoxNumber,
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
                ])))
      ]),
    );
  }

  ///現金以外を表示用　表のデータ作成
  Widget nonCashTableData({
    required String leftText,
    required String rightText,
    List<GlobalKey<InputBoxWidgetState>>? keyList,
    differenceCheckReferCtrl,
    index,
    required DiffCheckCommon diffCheckCommon,
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

  /// ドロア在高用
  /// [ChangeData] 表示データ
  /// [titleLeftText]  左ラベルテキスト
  /// [titleRightText] 右ラベルテキスト
  /// [billCoinCount] 　金額の種類(基本的には10)
  Widget drawerTable({
    required List<ChangeData> drawerCurrentValue,
    required String titleLeftText,
    required int titleRightText,
    required int billCoinCount,
    drawerKeyList,
    differenceCheckReferCtrl,
    diffCheckCommon,
  }) {
    return Stack(
      children: [
        SizedBox(
          width: diffCheckCommon.tableRowWidth,
          child: Column(
            children: [
              buildTitleRow(
                leftText: titleLeftText,
                rightText:
                    NumberFormatUtil.formatAmount(titleRightText).toString(),
                diffCheckCommon: diffCheckCommon,
              ),
              for (int i = 0; i < billCoinCount; i++)
                buildDrawerRow(
                  index: i,
                  billCoinType: drawerCurrentValue[i].billCoinType,
                  leftText: drawerCurrentValue[i].amount.toString(),
                  displayText: drawerCurrentValue[i].value.toString(),
                  keyList: drawerKeyList,
                  differenceCheckReferCtrl: differenceCheckReferCtrl,
                  diffCheckCommon: diffCheckCommon,
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// ドロア在高用　表データ作成
  /// [leftText]    左ラベルテキスト
  /// [displayText]  表示データ
  Widget buildDrawerRow(
      {required int index,
      required BillCoinType billCoinType,
      String leftText = '',
      String displayText = '',
      List<GlobalKey<InputBoxWidgetState>>? keyList,
      differenceCheckReferCtrl,
      diffCheckCommon}) {
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
                      differenceCheckReferCtrl.onInputBoxTap(index);
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
}
