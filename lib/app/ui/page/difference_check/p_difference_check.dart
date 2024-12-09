/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/number_util.dart';
import '../../../inc/lib/if_acx.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import '../../../inc/apl/fnc_code.dart';

//ウィジット
import '../subtotal/component/w_register_tenkey.dart';
import '../common/component/w_msgdialog.dart';
import 'widgets/w_diffcheck_breakdown.dart';
import 'widgets/w_diffcheck_right_side.dart';
import 'widgets/w_diffcheck_tables.dart';
import 'widgets/w_diffcheck_common.dart';
import 'widgets/w_diffcheck_to_sales.dart';

//コントローラー
import 'controller/c_difference_check.dart';

/// 動作概要
/// 起動方法： Get.to(() => DifferenceCheckPage(title: title,FuncKey: funcKey)); など
/// 処理結果： 起動して差異チェックを実施結果を送信？。印字ボタンは未対応。

// 1022現在 制限事項
/*
 ・印字ボタン
*/

/// 差異チェックのページ
// ignore: must_be_immutable
class DifferenceCheckPage extends CommonBasePage {
  DifferenceCheckPage({
    super.key,
    required super.funcKey,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
          String className = 'DifferenceCheckScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                Get.back();
              },
              callFunc: className,
              child: Row(
                children: [
                  const Icon(Icons.close,
                      color: BaseColor.someTextPopupArea, size: 45),
                  const SizedBox(
                    width: 19,
                  ),
                  Text('l_cmn_close'.trns,
                      style: const TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px)),
                ],
              ),
            ),
          ];
        });

  @override
  Widget buildBody(BuildContext context) {
    return DifferenceCheckWidget(
      funcKey: funcKey,
      backgroundColor: backgroundColor,
    );
  }
}

class DifferenceCheckWidget extends StatefulWidget {
  final Color backgroundColor;
  final FuncKey funcKey;

  const DifferenceCheckWidget(
      {super.key, required this.backgroundColor, required this.funcKey});

  @override
  // ignore: no_logic_in_create_state
  DifferenceCheckState createState() => DifferenceCheckState(funcKey: funcKey);
}

class DifferenceCheckState extends State<DifferenceCheckWidget> {
  late FuncKey funcKey;
  late final DifferenceCheckStateController differenceCheckReferCtrl;

  DifferenceCheckState({required this.funcKey});

  DiffCheckCommon diffCheckCommon = DiffCheckCommon();
  DiffToSales diffToSales = DiffToSales();
  DiffCheckTables diffCheckTables = DiffCheckTables();
  DiffCheckBreakdownTable diffCheckBreakdownTable = DiffCheckBreakdownTable();
  DiffarenceCheckRightSideWigit diffarenceCheckRightSideWigit =
      DiffarenceCheckRightSideWigit();

  CoinData coinData = CoinData();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // ページオープンと同時に在高確認処理開始

    // 再読み込み用に初期値に戻す
    diffCheckCommon.cashBtnBool.value = true;
    diffCheckCommon.salesCollectionBool.value = false;
    diffCheckCommon.breakdownBool.value = false;
    // コントローラー
    differenceCheckReferCtrl = DifferenceCheckStateController();

    Get.put(differenceCheckReferCtrl);

    Future(() async {
      await differenceCheckReferCtrl.getChangeData();
    });

    //スクロールバーの監視
    differenceCheckReferCtrl.scrollController.addListener(() {
      differenceCheckReferCtrl.updateUpScrollBtnOpacity(setState);
      differenceCheckReferCtrl.updateDownScrollBtnOpacity(setState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Stack(
            //body 全体
            children: [
              //売り上げ回収ボタン押下されていたら
              if (diffCheckCommon.salesCollectionBool.value)
                //売上回収
                diffToSales.transitionToSalesPage(differenceCheckReferCtrl,
                    setState, runtimeType, funcKey, diffCheckCommon)
              //内訳ボタン押下されていたら
              else if (diffCheckCommon.breakdownBool.value)
                //内訳
                diffCheckBreakdownTable.drawBreakdownTable(
                    differenceCheckReferCtrl,
                    setState,
                    runtimeType,
                    diffCheckCommon,
                    diffCheckTables)
              //それ以外
              else
                Column(children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      height: diffCheckCommon.appearBtnAreaHeight,
                      width: diffCheckCommon.wholeWidth,
                      child: Column(children: [
                        //現金以外を表示ボタン
                        if (diffCheckCommon.cashBtnBool.value)
                          //現金画面の上部ボタン表示
                          Container(
                            margin: EdgeInsets.only(
                                left: (diffCheckCommon.leftSideWidth -
                                    diffCheckCommon.appearBtnAreaWidth),
                                top: 6,
                                bottom: 6),
                            decoration: const BoxDecoration(
                              color: BaseColor.otherButtonColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                            ),
                            width: diffCheckCommon.appearBtnAreaWidth,
                            height: diffCheckCommon.appearBtnHeight,
                            child: Material(
                              color: BaseColor.transparent,
                              child: SoundInkWell(
                                onTap: () {
                                  differenceCheckReferCtrl
                                      .showRegisterTenkey.value = false;
                                  setState(() {
                                    diffCheckCommon.cashBtnBool.value = false;
                                  });
                                },
                                callFunc: runtimeType.toString(),
                                child: Row(
                                  children: [
                                    Container(
                                      height: diffCheckCommon.appearBtnHeight,
                                      width:
                                          diffCheckCommon.appearBtnAreaWidth -
                                              diffCheckCommon.appearBtnSvgWidth,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '現金以外を表示',
                                        style: TextStyle(
                                          color: BaseColor.someTextPopupArea,
                                          fontSize: BaseFont.font18px,
                                          fontFamily: BaseFont.familyDefault,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: diffCheckCommon.appearBtnHeight,
                                        width:
                                            diffCheckCommon.appearBtnSvgWidth,
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          'assets/images/icon_arrow_triangle.svg',
                                          width: 32.w,
                                          height: 32.h,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          //現金以外画面の上部ボタン表示
                          Container(
                            margin: const EdgeInsets.only(
                                left: 4, top: 6, bottom: 6),
                            decoration: const BoxDecoration(
                              color: BaseColor.otherButtonColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                            ),
                            width: diffCheckCommon.appearBtnAreaWidth,
                            height: diffCheckCommon.appearBtnHeight,
                            child: Material(
                              color: BaseColor.transparent,
                              child: SoundInkWell(
                                onTap: () {
                                  setState(() {
                                    diffCheckCommon.cashBtnBool.value = true;
                                  });
                                },
                                callFunc: runtimeType.toString(),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Container(
                                          height:
                                              diffCheckCommon.appearBtnHeight,
                                          width:
                                              diffCheckCommon.appearBtnSvgWidth,
                                          alignment: Alignment.center,
                                          child: Transform.rotate(
                                              angle: 180 * pi / 180,
                                              child: SvgPicture.asset(
                                                'assets/images/icon_arrow_triangle.svg',
                                                width: 32.w,
                                                height: 32.h,
                                              ))),
                                      Container(
                                        height: diffCheckCommon.appearBtnHeight,
                                        width: diffCheckCommon
                                                .appearBtnAreaWidth -
                                            diffCheckCommon.appearBtnSvgWidth,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          '現金在高を表示',
                                          style: TextStyle(
                                            color: BaseColor.someTextPopupArea,
                                            fontSize: BaseFont.font18px,
                                            fontFamily: BaseFont.familyDefault,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ])),

                  //表と右側の表示&ボタン
                  SizedBox(
                      height: diffCheckCommon.bodyHeight -
                          diffCheckCommon.appearBtnAreaHeight,
                      width: diffCheckCommon.wholeWidth,
                      child: Row(children: [
                        //左側の表示
                        SizedBox(
                            width: diffCheckCommon.leftSideWidth,
                            child: Container(
                                width: diffCheckCommon.tableAreaWidth,
                                height: diffCheckCommon.bodyHeight -
                                    diffCheckCommon.appearBtnAreaHeight,
                                margin: const EdgeInsets.only(left: 4),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (diffCheckCommon.cashBtnBool.value)
                                        SizedBox(
                                            height: diffCheckCommon.bodyHeight -
                                                diffCheckCommon
                                                    .appearBtnAreaHeight,
                                            child: Row(children: [
                                              Obx(() => diffCheckTables.changeTable(
                                                  changeData:
                                                      differenceCheckReferCtrl
                                                          .storageChangeData,
                                                  leftText: '釣機在高',
                                                  rightText: NumberFormatUtil
                                                      .formatAmount(
                                                          differenceCheckReferCtrl
                                                              .stockStat.value),
                                                  billCoinCount: (10),
                                                  diffCheckCommon:
                                                      diffCheckCommon)),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Obx(
                                                () =>
                                                    diffCheckTables.drawerTable(
                                                  drawerCurrentValue:
                                                      differenceCheckReferCtrl
                                                          .drawerCurrentValueList,
                                                  titleLeftText: 'ドロア在高',
                                                  titleRightText:
                                                      differenceCheckReferCtrl
                                                          .drawerSum.value,
                                                  billCoinCount: (10),
                                                  drawerKeyList:
                                                      differenceCheckReferCtrl
                                                          .inputBoxKeyList,
                                                  differenceCheckReferCtrl:
                                                      differenceCheckReferCtrl,
                                                  diffCheckCommon:
                                                      diffCheckCommon,
                                                ),
                                              ),
                                            ]))
                                      else
                                        SizedBox(
                                            height: diffCheckCommon.bodyHeight -
                                                diffCheckCommon
                                                    .appearBtnAreaHeight,
                                            child: Column(
                                              children: [
                                                // 現金以外を表示テーブル
                                                Obx(() => diffCheckTables
                                                        .nonCashTable(
                                                      nonCashSum:
                                                          differenceCheckReferCtrl
                                                              .nonCashHoldings
                                                              .value,
                                                      dataList:
                                                          differenceCheckReferCtrl
                                                              .nonCashList,
                                                      scrollController:
                                                          differenceCheckReferCtrl
                                                              .scrollController,
                                                      keyList:
                                                          differenceCheckReferCtrl
                                                              .inputBoxKeyList,
                                                      differenceCheckReferCtrl:
                                                          differenceCheckReferCtrl,
                                                      diffCheckCommon:
                                                          diffCheckCommon,
                                                    )),
                                                //スクロールボタン
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8),
                                                  width: diffCheckCommon
                                                      .tableAreaWidth,
                                                  height: diffCheckCommon
                                                      .scrollBtnHeight,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // スクロールボタン上
                                                        Opacity(
                                                          opacity:
                                                              differenceCheckReferCtrl
                                                                  .upOpacity,
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 12),
                                                            child: diffCheckCommon
                                                                .scrollButton(
                                                              Icons
                                                                  .arrow_drop_up,
                                                              () => differenceCheckReferCtrl
                                                                  .scrollController
                                                                  .scrollUp(
                                                                      pageHeight:
                                                                          diffCheckCommon
                                                                              .labelWholeHeight),
                                                            ),
                                                          ),
                                                        ),
                                                        // スクロールボタン下
                                                        Opacity(
                                                          opacity:
                                                              differenceCheckReferCtrl
                                                                  .downOpacity,
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 12),
                                                            child: diffCheckCommon.scrollButton(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                () => differenceCheckReferCtrl
                                                                    .scrollController
                                                                    .scrollDown(
                                                                        pageHeight: differenceCheckReferCtrl
                                                                            .scrollController
                                                                            .position
                                                                            .maxScrollExtent)),
                                                          ),
                                                        ),
                                                      ]),
                                                )
                                              ],
                                            ))
                                    ]))),
                        //右の表示
                        Obx(() =>
                            //テンキーフラグの確認
                            differenceCheckReferCtrl.showRegisterTenkey.value
                                ? Container(
                                    // テンキー
                                    width: diffCheckCommon.tenkeyWidth,
                                    height: diffCheckCommon.tenkeyHeight,
                                    // これで位置調整してる
                                    margin: EdgeInsets.only(
                                        left: diffCheckCommon.rightSideWidth -
                                            diffCheckCommon.tenkeyWidth -
                                            diffCheckCommon.rightMargin,
                                        top: diffCheckCommon.bodyHeight -
                                            diffCheckCommon
                                                .appearBtnAreaHeight -
                                            diffCheckCommon.tenkeyHeight -
                                            diffCheckCommon.bottomMargin),
                                    child: RegisterTenkey(
                                      onKeyTap: (key) {
                                        differenceCheckReferCtrl
                                            .inputKeyType(key);
                                      },
                                    ),
                                  )
                                : diffCheckCommon.cashBtnBool.value
                                    ? diffarenceCheckRightSideWigit
                                        .drawDiffarenceCheckRightSideWigit(
                                        differenceCheckReferCtrl,
                                        setState,
                                        runtimeType,
                                        funcKey,
                                        // BUG 印字機能未実装
                                        //印字ボタン
                                        () => {MsgDialog.showNotImplDialog()},
                                        //過不足在高合計 = (ドロア在高 + 釣り機在高) - 理論在高の合計
                                        (differenceCheckReferCtrl
                                                    .drawerSum.value +
                                                differenceCheckReferCtrl
                                                    .stockStat.value) -
                                            differenceCheckReferCtrl
                                                .cashTheoryStack.value,
                                        //現金在高
                                        "現金在高",
                                        NumberFormatUtil.formatAmount(
                                            differenceCheckReferCtrl
                                                    .stockStat.value +
                                                differenceCheckReferCtrl
                                                    .drawerSum.value),
                                        //理論現金在高
                                        "理論現金在高",
                                        NumberFormatUtil.formatAmount(
                                            differenceCheckReferCtrl
                                                .cashTheoryStack.value),
                                        diffCheckCommon,
                                      )
                                    : diffarenceCheckRightSideWigit
                                        .drawDiffarenceCheckRightSideWigit(
                                        differenceCheckReferCtrl,
                                        setState,
                                        runtimeType,
                                        funcKey,
                                        // BUG 印字機能未実装
                                        //印字ボタン
                                        () => {MsgDialog.showNotImplDialog()},
                                        //過不足在高合計 = 現金以外在高 - 理論現金以外在高の合計
                                        differenceCheckReferCtrl
                                                .nonCashHoldings.value -
                                            differenceCheckReferCtrl
                                                .nonCashtheoryStack.value,
                                        //現金以外在高
                                        "現金以外在高",
                                        NumberFormatUtil.formatAmount(
                                            differenceCheckReferCtrl
                                                .nonCashHoldings.value),
                                        //理論現金在高
                                        "理論現金以外在高",
                                        NumberFormatUtil.formatAmount(
                                            differenceCheckReferCtrl
                                                .nonCashtheoryStack.value),
                                        diffCheckCommon,
                                      )),
                      ]))
                ])
            ]));
  }
}
