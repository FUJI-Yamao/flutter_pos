/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../inc/apl/fnc_code.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../common/component/w_dicisionbutton.dart';
import '../../common/component/w_toggle_switch.dart';
import '../../sales_collection/p_sales_collection.dart';
import '../controller/c_difference_check.dart';
import '../model/m_changemodels.dart';
import 'w_diffcheck_common.dart';

/// 売上回収画面へのデータ移行画面
class DiffToSales {
// toggleBool
  var cashAllBanknotes = true.obs;
  var cash10000yen = true.obs;
  var cashAllCoins = true.obs;
  var cashCompleteCollection = true.obs;

  var drawerAllBanknotes = true.obs;
  var drawer10000yen = true.obs;
  var drawerAllCoins = true.obs;
  var drawerCompleteCollection = true.obs;

  ToggleSwitch toggleSwitch = ToggleSwitch();

  int billKindCount = 4; //紙幣の種類の数 10000 5000 2000 1000

  ///売上回収に遷移するためのデータ移行画面
  Widget transitionToSalesPage(
      DifferenceCheckStateController differenceCheckReferCtrl,
      setState,
      Type runtimeType,
      FuncKey funcKey,
      DiffCheckCommon diffCheckCommon) {
    return SizedBox(
        width: diffCheckCommon.wholeWidth,
        height: diffCheckCommon.bodyHeight,
        child: SizedBox(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: diffCheckCommon.toSalesMessageAreaHeight,
            width: diffCheckCommon.wholeWidth,
            alignment: Alignment.center,
            color: BaseColor.someTextPopupArea,
            child: const Text(
              "売上回収に引き継ぐデータを選択してください",
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: diffCheckCommon.toSalesTableTopMargin,
                  left: diffCheckCommon.toSalesLeftMargin,
                  right: diffCheckCommon.toSalesRightMargin),
              height: diffCheckCommon.toSalesTableHeight,
              width: diffCheckCommon.toSalesTableWidth,
              child: Column(children: [
                // 表
                SizedBox(
                    height: diffCheckCommon.toSalesTableHeight,
                    child: Table(
                      children: [
                        TableRow(
                            decoration: const BoxDecoration(
                              color: BaseColor.someTextPopupArea,
                            ),
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: diffCheckCommon.toSalestableRowHeight,
                                child: const Text(""),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: diffCheckCommon.toSalestableRowHeight,
                                child: const Text(
                                  "釣り機",
                                  style: TextStyle(
                                    color: BaseColor.baseColor,
                                    fontSize: BaseFont.font18px,
                                    fontFamily: BaseFont.familyDefault,
                                  ),
                                ),
                              ), //釣り機用 デザイン要確認
                              Container(
                                alignment: Alignment.center,
                                height: diffCheckCommon.toSalestableRowHeight,
                                child: const Text(
                                  "ドロア",
                                  style: TextStyle(
                                    color: BaseColor.baseColor,
                                    fontSize: BaseFont.font18px,
                                    fontFamily: BaseFont.familyDefault,
                                  ),
                                ),
                              ),
                            ]),
                        TableRow(
                            decoration: const BoxDecoration(
                              color: BaseColor.someTextPopupArea,
                            ),
                            children: [
                              SizedBox(
                                  width:
                                      diffCheckCommon.toSalesRowCellAreaWidth,
                                  height: diffCheckCommon.toSalestableRowHeight,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: diffCheckCommon
                                              .toSalesSvgAreaWidth,
                                          alignment: Alignment.centerRight,
                                          child: SvgPicture.asset(
                                            'assets/images/icon_bill_large.svg',
                                            width: 32,
                                            height: 32,
                                          )),
                                      SizedBox(
                                        width: 28.w,
                                      ),
                                      const Text(
                                        "紙幣すべて",
                                        style: TextStyle(
                                          color: BaseColor.baseColor,
                                          fontSize: BaseFont.font18px,
                                          fontFamily: BaseFont.familyDefault,
                                        ),
                                      ),
                                    ],
                                  )), //ヘッダ
                              Container(
                                  padding: EdgeInsets.only(
                                      top: diffCheckCommon
                                          .toSalesToggleUpDownMargin,
                                      bottom: diffCheckCommon
                                          .toSalesToggleUpDownMargin,
                                      left: diffCheckCommon
                                          .toSalesToggleSideMargin,
                                      right: diffCheckCommon
                                          .toSalesToggleSideMargin),
                                  height: diffCheckCommon.toSalestableRowHeight,
                                  width: 232,
                                  child: toggleSwitch.toggleSwitch(
                                    cashAllBanknotes,
                                    setState,
                                    '反映する',
                                    '反映しない',
                                  )),
                              Container(
                                padding: EdgeInsets.only(
                                    top: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    bottom: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    left:
                                        diffCheckCommon.toSalesToggleSideMargin,
                                    right: diffCheckCommon
                                        .toSalesToggleSideMargin),
                                height: diffCheckCommon.toSalestableRowHeight,
                                child: toggleSwitch.toggleSwitch(
                                  drawerAllBanknotes,
                                  setState,
                                  '反映する',
                                  '反映しない',
                                ),
                              ),
                            ]),
                        TableRow(
                            decoration: const BoxDecoration(
                              color: BaseColor.someTextPopupArea,
                            ),
                            children: [
                              SizedBox(
                                  height: diffCheckCommon.toSalestableRowHeight,
                                  width:
                                      diffCheckCommon.toSalesRowCellAreaWidth,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: diffCheckCommon
                                              .toSalesSvgAreaWidth,
                                          alignment: Alignment.centerRight,
                                          child: SvgPicture.asset(
                                            'assets/images/icon_bill_10000.svg',
                                            width: 32,
                                            height: 32,
                                          )),
                                      SizedBox(
                                        width: 28.w,
                                      ),
                                      const Text(
                                        "万券",
                                        style: TextStyle(
                                          color: BaseColor.baseColor,
                                          fontSize: BaseFont.font18px,
                                          fontFamily: BaseFont.familyDefault,
                                        ),
                                      ),
                                    ],
                                  )), //ヘッダ
                              // Container(), //釣り機用 デザイン要確認
                              Container(
                                padding: EdgeInsets.only(
                                    top: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    bottom: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    left:
                                        diffCheckCommon.toSalesToggleSideMargin,
                                    right: diffCheckCommon
                                        .toSalesToggleSideMargin),
                                height: diffCheckCommon.toSalestableRowHeight,
                                child: toggleSwitch.toggleSwitch(
                                  cash10000yen,
                                  setState,
                                  '反映する',
                                  '反映しない',
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    bottom: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    left:
                                        diffCheckCommon.toSalesToggleSideMargin,
                                    right: diffCheckCommon
                                        .toSalesToggleSideMargin),
                                height: diffCheckCommon.toSalestableRowHeight,
                                child: toggleSwitch.toggleSwitch(
                                  drawer10000yen,
                                  setState,
                                  '反映する',
                                  '反映しない',
                                ),
                              ),
                            ]),
                        TableRow(
                            decoration: const BoxDecoration(
                              color: BaseColor.someTextPopupArea,
                            ),
                            children: [
                              SizedBox(
                                  height: diffCheckCommon.toSalestableRowHeight,
                                  width:
                                      diffCheckCommon.toSalesRowCellAreaWidth,
                                  child: Row(children: [
                                    Container(
                                        width:
                                            diffCheckCommon.toSalesSvgAreaWidth,
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                          'assets/images/icon_coin_large.svg',
                                          width: 32,
                                          height: 32,
                                        )),
                                    SizedBox(
                                      width: 28.w,
                                    ),
                                    const Text(
                                      "硬貨すべて",
                                      style: TextStyle(
                                        color: BaseColor.baseColor,
                                        fontSize: BaseFont.font18px,
                                        fontFamily: BaseFont.familyDefault,
                                      ),
                                    ),
                                  ])), //ヘッダ
                              Container(
                                padding: EdgeInsets.only(
                                    top: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    bottom: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    left:
                                        diffCheckCommon.toSalesToggleSideMargin,
                                    right: diffCheckCommon
                                        .toSalesToggleSideMargin),
                                height: diffCheckCommon.toSalestableRowHeight,
                                child: toggleSwitch.toggleSwitch(
                                  cashAllCoins,
                                  setState,
                                  '反映する',
                                  '反映しない',
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    bottom: diffCheckCommon
                                        .toSalesToggleUpDownMargin,
                                    left:
                                        diffCheckCommon.toSalesToggleSideMargin,
                                    right: diffCheckCommon
                                        .toSalesToggleSideMargin),
                                height: diffCheckCommon.toSalestableRowHeight,
                                child: toggleSwitch.toggleSwitch(
                                  drawerAllCoins,
                                  setState,
                                  '反映する',
                                  '反映しない',
                                ),
                              ),
                            ]),
                        TableRow(
                            decoration: const BoxDecoration(
                              color: BaseColor.someTextPopupArea,
                            ),
                            children: [
                              SizedBox(
                                  height: diffCheckCommon.toSalestableRowHeight,
                                  width:
                                      diffCheckCommon.toSalesRowCellAreaWidth,
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            diffCheckCommon.toSalesSvgAreaWidth,
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                          'assets/images/icon_bill_coin.svg',
                                          width: 32,
                                          height: 32,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 28.w,
                                      ),
                                      const Text(
                                        "全回収",
                                        style: TextStyle(
                                          color: BaseColor.baseColor,
                                          fontSize: BaseFont.font18px,
                                          fontFamily: BaseFont.familyDefault,
                                        ),
                                      ),
                                    ],
                                  )), //ヘッダ
                              // Container(), //釣り機用 デザイン要確認
                              Container(
                                  padding: EdgeInsets.only(
                                      top: diffCheckCommon
                                          .toSalesToggleUpDownMargin,
                                      bottom: diffCheckCommon
                                          .toSalesToggleUpDownMargin,
                                      left: diffCheckCommon
                                          .toSalesToggleSideMargin,
                                      right: diffCheckCommon
                                          .toSalesToggleSideMargin),
                                  height: diffCheckCommon.toSalestableRowHeight,
                                  child: toggleSwitch.toggleSwitch(
                                    cashCompleteCollection,
                                    setState,
                                    '反映する',
                                    '反映しない',
                                  )),
                              Container(
                                  padding: EdgeInsets.only(
                                      top: diffCheckCommon
                                          .toSalesToggleUpDownMargin,
                                      bottom: diffCheckCommon
                                          .toSalesToggleUpDownMargin,
                                      left: diffCheckCommon
                                          .toSalesToggleSideMargin,
                                      right: diffCheckCommon
                                          .toSalesToggleSideMargin),
                                  height: diffCheckCommon.toSalestableRowHeight,
                                  child: toggleSwitch.toggleSwitch(
                                    drawerCompleteCollection,
                                    setState,
                                    '反映する',
                                    '反映しない',
                                  )),
                            ])
                      ],
                    )),
              ])),
          Container(
              padding: EdgeInsets.only(
                  left: diffCheckCommon.toSalesBtnAreaMargin,
                  right: diffCheckCommon.toSalesBtnAreaMargin),
              height: diffCheckCommon.toSalesBtnAreaHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: BaseColor.otherButtonColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    width: diffCheckCommon.appearBtnAreaWidth,
                    height: diffCheckCommon.appearBtnAreaHeight,
                    child: Material(
                      color: BaseColor.transparent,
                      child: SoundInkWell(
                          onTap: () {
                            setState(() {
                              diffCheckCommon.salesCollectionBool.value = false;
                            });
                            Future(() async {});
                          },
                          callFunc: runtimeType.toString(),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icon_back_arrow_white.svg',
                                  width: 32,
                                  height: 32,
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
                  SizedBox(
                    width: diffCheckCommon.wholeWidth -
                        diffCheckCommon.appearBtnAreaWidth -
                        diffCheckCommon.toSalesBtnWidth -
                        (diffCheckCommon.toSalesBtnAreaMargin * 2),
                  ),
                  SizedBox(
                      height: diffCheckCommon.toSalesBtnHeight,
                      width: diffCheckCommon.toSalesBtnWidth,
                      child: DecisionButton(
                        oncallback: () async {
                          // 1つPOPしてから遷移する
                          // BUG データ受け渡し方法の検討
                          Future(() async {
                            List<NonCashData> nonCash = List.generate(
                                35,
                                (index) => NonCashData(
                                      title: "",
                                      value: 0,
                                    )).obs;

                            // 在高用リスト 作成
                            List<ChangeData> valueList = List.generate(
                                10,
                                (index) => ChangeData(
                                      billCoinType: cashType[index] >= 1000
                                          ? BillCoinType.bill
                                          : BillCoinType.coin,
                                      amount: cashType[index],
                                      value: 0,
                                    )).obs;

                            // データ引継ぎ
                            bool nonCashBool = false;

                            List<bool> cashBool = List.filled(10, false);
                            List<bool> drawerBool = List.filled(10, false);

                            //万券 釣銭機
                            if (cash10000yen.value) {
                              cashBool[0] = true;
                            }

                            //紙幣 釣銭機
                            if (cashAllBanknotes.value) {
                              for (int i = 0; i < billKindCount; i++) {
                                cashBool[i] = true;
                              }
                            }

                            //硬貨 釣銭機
                            if (cashAllCoins.value) {
                              for (int i = billKindCount;
                                  i < cashBool.length;
                                  i++) {
                                cashBool[i] = true;
                              }
                            }

                            //全部 釣銭機
                            if (cashCompleteCollection.value) {
                              for (int i = 0; i < cashBool.length; i++) {
                                cashBool[i] = true;
                              }
                            }

                            //万券 ドロア
                            if (drawer10000yen.value) {
                              drawerBool[0] = true;
                            }

                            //紙幣 ドロア
                            if (drawerAllBanknotes.value) {
                              for (int i = 0; i < billKindCount; i++) {
                                drawerBool[i] = true;
                              }
                            }

                            //硬貨 ドロア
                            if (drawerAllCoins.value) {
                              for (int i = billKindCount;
                                  i < drawerBool.length;
                                  i++) {
                                drawerBool[i] = true;
                              }
                            }

                            //全部 ドロア
                            if (drawerCompleteCollection.value) {
                              for (int i = 0; i < drawerBool.length; i++) {
                                drawerBool[i] = true;
                              }
                              // ドロアー全回収時は現金以外も引継ぎ
                              nonCashBool = true;
                            }

                            // 現金以外
                            if (nonCashBool) {
                              nonCash = differenceCheckReferCtrl.nonCashList;
                            }

                            for (int i = 0; i < valueList.length; i++) {
                              if (cashBool[i] && drawerBool[i]) {
                                ChangeData data = ChangeData(
                                  billCoinType: differenceCheckReferCtrl
                                      .storageChangeData[i].billCoinType,
                                  amount: differenceCheckReferCtrl
                                      .storageChangeData[i].amount,
                                  value: differenceCheckReferCtrl
                                          .storageChangeData[i].value +
                                      differenceCheckReferCtrl
                                          .drawerCurrentValueList[i].value,
                                );
                                valueList[i] = data;
                              } else if (cashBool[i]) {
                                valueList[i] = differenceCheckReferCtrl
                                    .storageChangeData[i];
                              } else if (drawerBool[i]) {
                                valueList[i] = differenceCheckReferCtrl
                                    .drawerCurrentValueList[i];
                              }
                            }

                            await Get.off(() => SalesCollectionPage(
                                  title: '売上回収',
                                  funcKey: funcKey,
                                  nonCash: nonCash,
                                  cashData: valueList,
                                ));
                          });
                        },
                        text: '確定する',
                        isdecision: true,
                      )),
                ],
              ))
        ])));
  }
}
