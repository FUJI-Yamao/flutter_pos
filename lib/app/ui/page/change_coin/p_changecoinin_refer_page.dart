/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_com.dart';
import 'package:flutter_pos/app/regs/checker/rckycref.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../common/number_util.dart';
import '../../../inc/lib/if_acx.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import 'controller/c_changecoinrefer_controller.dart';
import 'model/m_changemodels.dart';

/// 動作概要
/// 起動方法： Get.to(() => ChangeCoinReferScreen(title: title)); など
/// 処理結果： 起動して現在の釣機情報を表示するのみとなる。印字ボタンは未対応。

/// 釣機参照のページ
class ChangeCoinReferScreen extends CommonBasePage {
  ChangeCoinReferScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'ChangeCoinReferScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                // todo 釣銭機業務画面から呼ばれている想定なので、処理内容は要確認
                Get.back();
              },
              callFunc: className,
              child: Row(
                children: <Widget>[
                  const Icon(Icons.close,
                      color: BaseColor.someTextPopupArea, size: 45),
                  SizedBox(
                    width: 19.w,
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
    return ChangeCoinReferWidget(
      backgroundColor: backgroundColor,
    );
  }
}

class ChangeCoinReferWidget extends StatefulWidget {
  final Color backgroundColor;

  ChangeCoinReferWidget({super.key, required this.backgroundColor});

  @override
  ChangeCoinReferState createState() => ChangeCoinReferState();
}

class ChangeCoinReferState extends State<ChangeCoinReferWidget> {
  ChangeCoinReferController changeCoinReferCtrl = 
      Get.put(ChangeCoinReferController());
  CoinData coinData = CoinData();

  /// 状態種別と表示文字列
  final Map<HolderFlagList, String> statusDescriptions = {
    HolderFlagList.HOLDER_NON:       '空',
    HolderFlagList.HOLDER_EMPTY:     '補充してください',
    HolderFlagList.HOLDER_NEAR_END:  'ニアエンド',
    HolderFlagList.HOLDER_NORMAL:    '',
    HolderFlagList.HOLDER_NEAR_FULL: '',
    HolderFlagList.HOLDER_NEAR_FULL_BFR_ALERT: '',
    HolderFlagList.HOLDER_FULL:      '回収してください',
  };

  Timer? timer;

  @override
  void initState() {
    super.initState();
    // ページオープンと同時に在高確認処理開始
    Future(() async {
      await RcKyCRef.rcKyChgRef();
      await changeCoinReferCtrl.getChangeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: Center(
            child: Obx(() => Text(
              textAlign: TextAlign.center,
                (changeCoinReferCtrl.stockStat.value == 1 ?
                    'つり機在高が不確定です。つり機再精査を行ってください。': ""),
              style: TextStyle(
                color: BaseColor.attentionColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            )),
          ),
        ),
      ),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() => buildChangeData(
                changeData: changeCoinReferCtrl.storageChangeData,
                leftText: '収納庫',
                rightText: NumberFormatUtil.formatAmount(
                    changeCoinReferCtrl.storageSumAmount.value),
              )),
              Obx(() => buildChangeData(
                changeData: changeCoinReferCtrl.safeChangeData,
                leftText: '金庫',
                rightText: NumberFormatUtil.formatAmount(
                    changeCoinReferCtrl.safeSumAmount.value),
              )),
            ],
          ),
          Positioned(
            top: 16,
            right: 32,
            child: Container(
              decoration: const BoxDecoration(
                color: BaseColor.otherButtonColor,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              width: 104.w,
              height: 56.h,
              child: Material(
                color: BaseColor.transparent,
                child: SoundInkWell(
                  onTap: () {
                    // todo 第二フェーズで対応
                    debugPrint('釣り機参照画面：印字ボタン押下');
                    Future(() async {
                     await RcKyCRef.printFnc();
                    });
                  },
                  callFunc: runtimeType.toString(),
                  child: const Center(
                    child: Text(
                      '印字',
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
        ],
      ),
    );
  }

  /// 各タイトルを作成する
  /// [leftText]  左ラベルテキスト
  /// [rightText] 右ラベルテキスト
  Widget buildTitleRow({String leftText = '', String rightText = ''}) {
    return Container(
      color: BaseColor.changeCoinReferTitleColor,
      width: 424.w,
      height: 48.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120.w,
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
            width: 303.93.w,
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

  /// 各データ行を作成する
  /// [leftText]    左ラベルテキスト
  /// [centerText]  中央ラベルテキスト
  /// [rightText]   右ラベルテキスト
  /// [ratio]       在高割合
  /// [color]       状態表示の文字色
  /// [barColor]    枠線、インジケーターの色
  /// [isBarExist]  枠線が必要かどうか
  Widget buildDataRow(
      {required BillCoinType billCoinType,
      String leftText = '',
      String centerText = '',
      String rightText = '',
      int ratio = 0,
      Color color = BaseColor.transparentColor,
      Color barColor = BaseColor.transparentColor,
      bool isBarExist = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        width: 424.w,
        height: 56.7.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isBarExist ? barColor : BaseColor.transparentColor,
            width: 3,
          ),
          color: BaseColor.someTextPopupArea,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 56.w,
                height: 56.h,
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
                width: 90.w,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      leftText,
                      style: const TextStyle(
                        fontSize: BaseFont.font22px,
                        fontFamily: BaseFont.familyDefault,//.familyNumber,
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
                padding: const EdgeInsets.only(right: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      width: 76.w,
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
                      width: 18.w,
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
              SizedBox(
                width: 118.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 21.h,
                      alignment: Alignment.center,
                      child: Text(
                        rightText,
                        style: TextStyle(
                          color: color,
                          fontSize: BaseFont.font14px,
                          fontFamily: BaseFont.familyDefault,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 118.w,
                      height: 25.h,
                      child: LinearPercentIndicator(
                        alignment: MainAxisAlignment.center,
                        lineHeight: 16,
                        percent: ratio / 100,
                        progressColor: barColor,
                        barRadius: const Radius.circular(10),
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

  /// 各行を作成する
  /// [leftText]  左ラベルテキスト
  /// [rightText] 右ラベルテキスト
  Widget buildChangeData(
      {required List<ChangeData> changeData,
      String leftText = '',
      String rightText = ''}) {
    return Stack(
      children: [
        SizedBox(
          width: 428.w,
          child: Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Column(
              children: [
                buildTitleRow(
                  leftText: leftText,
                  rightText: rightText,
                ),
                for (int i = 0; i < ChangeCoinReferController().billCoinCount; i++)
                  buildDataRow(
                    billCoinType: changeData[i].billCoinType,
                    leftText: changeData[i].amount.toString(),
                    centerText: changeData[i].count.toString(),
                    rightText:
                    statusDescriptions[changeData[i].kindFlg] ?? '',
                    ratio: changeData[i].percentage,
                    color: changeData[i].color,
                    barColor: changeData[i].barColor,
                    isBarExist:
                       (changeData[i].kindFlg == HolderFlagList.HOLDER_EMPTY)
                    || (changeData[i].kindFlg == HolderFlagList.HOLDER_FULL) ,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
