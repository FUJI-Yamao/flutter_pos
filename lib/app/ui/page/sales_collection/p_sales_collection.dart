/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
*/

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// テンキー
import '../subtotal/component/w_register_tenkey.dart';

// w.h とかやってるやつ
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../common/number_util.dart';

import '../common/component/w_msgdialog.dart';
import '../../../inc/lib/if_acx.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import '../../../inc/apl/fnc_code.dart';

//ウィジット
// 差異チェックのウィジット
import '../difference_check/model/m_changemodels.dart';
import '../difference_check/widgets/w_diffcheck_common.dart';

//売り上げ回収のウィジット
import 'widgets/w_sales_rightside.dart';
import 'widgets/w_sales_tables.dart';

//コントローラー
import 'controller/c_sales_collection.dart';

/// 動作概要
/// 起動方法： Get.to(() => SalesCollectionPage(title: title,FuncKey: funcKey)); など

// BUG 1022現在(未実装)
// 印字ボタン機能

/// 売り上げ回収のページ
// ignore: must_be_immutable
class SalesCollectionPage extends CommonBasePage {
  List<NonCashData> nonCash;
  List<ChangeData> cashData;

  SalesCollectionPage({
    super.key,
    required this.cashData,
    required this.nonCash,
    required super.funcKey,
    super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
          String className = 'SalesCollectionScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                Get.back();
              },
              callFunc: className,
              child: Row(
                children: <Widget>[
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
    return SalesCollectionWidget(
      funcKey: funcKey,
      backgroundColor: backgroundColor,
      nonCash: nonCash,
      cashData: cashData,
    );
  }
}

class SalesCollectionWidget extends StatefulWidget {
  final Color backgroundColor;
  final FuncKey funcKey;
  final List<NonCashData> nonCash;
  final List<ChangeData> cashData;

  const SalesCollectionWidget({
    super.key,
    required this.backgroundColor,
    required this.funcKey,
    required this.nonCash,
    required this.cashData,
  });

  @override
  // ignore: no_logic_in_create_state
  SalesCollectionState createState() => SalesCollectionState(
      funcKey: funcKey, nonCash: nonCash, cashData: cashData);
}

class SalesCollectionState extends State<SalesCollectionWidget> {
  late FuncKey funcKey;
  late final SalesCollectionStateController selesCollectionReferCtrl;
  DiffCheckCommon diffCheckCommon = DiffCheckCommon();
  SalesTable salesTable = SalesTable();
  SalesRightSide salesRightSide = SalesRightSide();
  List<NonCashData> nonCash;
  List<ChangeData> cashData;

  SalesCollectionState({
    required this.funcKey,
    required this.nonCash,
    required this.cashData,
  });

  bool cashBtnBool = true;

  CoinData coinData = CoinData();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    selesCollectionReferCtrl = SalesCollectionStateController();

    Get.put(selesCollectionReferCtrl);

    Future(() async {
      await selesCollectionReferCtrl.getChangeData(nonCash, cashData, setState);
    });

    //スクロールバーの監視
    selesCollectionReferCtrl.scrollController.addListener(() {
      selesCollectionReferCtrl.updateUpScrollBtnOpacity(setState);
      selesCollectionReferCtrl.updateDownScrollBtnOpacity(setState);
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
              Column(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    height: diffCheckCommon.appearBtnAreaHeight,
                    width: diffCheckCommon.wholeWidth,
                    child: Column(children: <Widget>[
                      //現金以外を表示ボタン
                      if (cashBtnBool)
                        //現金画面の上部ボタン表示
                        Container(
                          margin: EdgeInsets.only(
                              left: (diffCheckCommon.leftSideWidth -
                                  diffCheckCommon.appearBtnAreaWidth),
                              top: 6,
                              bottom: 6),
                          decoration: const BoxDecoration(
                            color: BaseColor.otherButtonColor,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          width: diffCheckCommon.appearBtnAreaWidth,
                          height: diffCheckCommon.appearBtnHeight,
                          child: Material(
                            color: BaseColor.transparent,
                            child: SoundInkWell(
                                onTap: () {
                                  selesCollectionReferCtrl
                                      .showRegisterTenkey.value = false;
                                  setState(() {
                                    cashBtnBool = false;
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
                                )),
                          ),
                        )
                      else
                        //現金以外画面の上部ボタン表示
                        Container(
                          margin:
                              const EdgeInsets.only(left: 4, top: 6, bottom: 6),
                          decoration: const BoxDecoration(
                            color: BaseColor.otherButtonColor,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          width: diffCheckCommon.appearBtnAreaWidth,
                          height: diffCheckCommon.appearBtnHeight,
                          child: Material(
                            color: BaseColor.transparent,
                            child: SoundInkWell(
                              onTap: () {
                                setState(() {
                                  cashBtnBool = true;
                                });
                              },
                              callFunc: runtimeType.toString(),
                              child: Center(
                                child: Row(
                                  children: [
                                    Container(
                                        height: diffCheckCommon.appearBtnHeight,
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
                                      width:
                                          diffCheckCommon.appearBtnAreaWidth -
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

                //表と右側の表示
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
                                    if (cashBtnBool)
                                      SizedBox(
                                          height: diffCheckCommon.bodyHeight -
                                              diffCheckCommon
                                                  .appearBtnAreaHeight,
                                          child: Row(children: [
                                            Obx(
                                              () => salesTable.salesTable(
                                                changeData: cashData,
                                                titleLeftText: 'ドロア在高',
                                                titleRightText:
                                                    selesCollectionReferCtrl
                                                        .drawerSum.value,
                                                billCoinCount: (10),
                                                drawerKeyList:
                                                    selesCollectionReferCtrl
                                                        .inputBoxKeyList,
                                                selesCollectionReferCtrl:
                                                    selesCollectionReferCtrl,
                                                diffCheckCommon:
                                                    diffCheckCommon,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            SizedBox(
                                              width: 320.w,
                                            )
                                          ]))
                                    else
                                      SizedBox(
                                          height: diffCheckCommon.bodyHeight -
                                              diffCheckCommon
                                                  .appearBtnAreaHeight,
                                          child: Column(
                                            children: [
                                              // 現金以外を表示テーブル
                                              Obx(() =>
                                                  salesTable.salesNonCashTable(
                                                    selesCollectionReferCtrl
                                                        .nonCashHoldings.value,
                                                    selesCollectionReferCtrl
                                                        .nonCashList,
                                                    selesCollectionReferCtrl
                                                        .scrollController,
                                                    selesCollectionReferCtrl
                                                        .inputBoxKeyList,
                                                    selesCollectionReferCtrl,
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
                                                              selesCollectionReferCtrl
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
                                                              () => selesCollectionReferCtrl
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
                                                              selesCollectionReferCtrl
                                                                  .downOpacity,
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 12),
                                                            child: diffCheckCommon.scrollButton(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                () => selesCollectionReferCtrl
                                                                    .scrollController
                                                                    .scrollDown(
                                                                        pageHeight: selesCollectionReferCtrl
                                                                            .scrollController
                                                                            .position
                                                                            .maxScrollExtent)),
                                                          ),
                                                        ),
                                                      ]))
                                            ],
                                          ))
                                  ]))),
                      //右の表示
                      Obx(() =>
                          //テンキーフラグの確認
                          selesCollectionReferCtrl.showRegisterTenkey.value
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
                                          diffCheckCommon.appearBtnAreaHeight -
                                          diffCheckCommon.tenkeyHeight -
                                          diffCheckCommon.bottomMargin),
                                  child: RegisterTenkey(
                                    onKeyTap: (key) {
                                      selesCollectionReferCtrl
                                          .inputKeyType(key);
                                    },
                                  ),
                                )
                              : cashBtnBool
                                  // 現金画面の際の右側表示
                                  ? SizedBox(
                                      height: diffCheckCommon.bodyHeight -
                                          diffCheckCommon.appearBtnAreaHeight,
                                      width: diffCheckCommon.rightSideWidth,
                                      child: salesRightSide.salesRightSide(
                                        selesCollectionReferCtrl,
                                        //確定
                                        () => {MsgDialog.showNotImplDialog()},
                                        "合計",
                                        NumberFormatUtil.formatAmount(
                                            selesCollectionReferCtrl
                                                .drawerSum.value),
                                        diffCheckCommon,
                                      ),
                                    )
                                  // 現金以外画面の際の右側表示
                                  : SizedBox(
                                      height: diffCheckCommon.bodyHeight -
                                          diffCheckCommon.appearBtnAreaHeight,
                                      width: diffCheckCommon.rightSideWidth,
                                      child: salesRightSide.salesRightSide(
                                        selesCollectionReferCtrl,
                                        //確定
                                        () => {MsgDialog.showNotImplDialog()},
                                        "合計",
                                        NumberFormatUtil.formatAmount(
                                            selesCollectionReferCtrl
                                                .nonCashHoldings.value),
                                        diffCheckCommon,
                                      ),
                                    ))
                    ]))
              ])
            ]));
  }
}
