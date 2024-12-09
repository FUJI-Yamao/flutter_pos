/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/lib/apllib/image_label_dbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/number_util.dart';
import '../../../inc/apl/image.dart';
import '../../../regs/checker/rc_crdt_fnc.dart';
import '../../../regs/checker/rc_touch_key.dart';
import '../../../regs/inc/rc_crdt.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import '../common/component/p_common_message_page.dart';
import '../common/component/w_dicisionbutton.dart';
import '../subtotal/controller/c_subtotal_controller.dart';
import 'component/w_credit_payment_method_item.dart';
import 'controller/c_credit_declaration_controller.dart';

/// 動作概要： クレジットカードによる支払処理を行う
/// 起動方法： Get.to(() => CreditDeclarationPage(title: title)); など
/// 処理結果：

/// クレジット取引のページ
class CreditDeclarationPage extends CommonBasePage {
  CreditDeclarationPage({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
          String className = 'CreditDeclarationPage';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                Get.to(() => CommonMessagePage(
                    title: "クレジット取引中止",
                    message1: 'クレジット取引が中止されました。',
                    message2: 'とじるボタンを押して画面を閉じてください。',
                    closeFunc: () async {
                      CreditPaymentController creditDeclarationCtrl =
                          Get.find();
                      if (creditDeclarationCtrl.creditProcessState.value ==
                          CreditProcessState.readCard) {
                        // todo クレ宣言バックエンド3
                        //  カード読み込み中の中止の場合に呼ぶバックエンド処理を記載
                        // todo クレ宣言　暫定対応8　クレジット実行体が実装されたらコメント部分を解除し、rcCrdtCancel()を削除
                        // await RcCardCrew.rcCardCrewInquCard();
                        await RcCrdtFnc.rcCrdtCancel();
                      } else {
                        // todo クレ宣言バックエンド4
                        // 中止の場合に呼ぶバックエンド処理があれば記載
                        await TchKeyDispatch.rcPre104CrdtProc(RcCrdt.KEY_BREAK1);
                        // todo クレ宣言　暫定対応8　クレジット実行体が実装されたら以下削除
                        // クレジット宣言状態をクリアする
                        await RcCrdtFnc.rcCrdtCancel();
                      }
                      Get.back(); // CommonMessagePageを閉じる
                      Get.back(); // CreditDeclarationPageを閉じる
                    }));
              },
              callFunc: '$className ${'l_cmn_cancel'.trns}',
              child: Row(
                children: <Widget>[
                  const Icon(Icons.close,
                      color: BaseColor.someTextPopupArea, size: 45),
                  SizedBox(
                    width: 19.w,
                  ),
                  Text('l_cmn_cancel'.trns,
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
    return CreditDeclarationWidget(
      backgroundColor: backgroundColor,
    );
  }
}

class CreditDeclarationWidget extends StatefulWidget {
  final Color backgroundColor;

  const CreditDeclarationWidget({super.key, required this.backgroundColor});

  @override
  CreditDeclarationState createState() => CreditDeclarationState();
}

class CreditDeclarationState extends State<CreditDeclarationWidget> {
  CreditPaymentController creditDeclarationCtrl =
      Get.find();
  SubtotalController subtotalCtrl = Get.find();

  /// 戻るボタンのラベル
  static const String returnBtnLabel = '支払い方法選択のやり直し';

  /// 戻るボタンの最大幅
  static const double maxWidth = 200.0;

  /// 戻るボタンの最大高さ
  static const double maxHeight = 80.0;

  @override
  void initState() {
    super.initState();
    creditDeclarationCtrl.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: Center(
            child: Obx(
              () => Text(
                textAlign: TextAlign.center,
                creditDeclarationCtrl.appBarMessage.value,
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 56.h),
                  Center(
                    child: SizedBox(
                      width: 400.w,
                      height: 75.h,
                      child: buildAmountRow(
                        ImageDefinitions.IMG_TTL.imageData,
                        rightText: NumberFormatUtil.formatAmount(
                            subtotalCtrl.totalAmount.value),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 46.h,
                  ),
                  Center(
                      child: buildRow2ColumnType(
                    leftText: 'カード会社',
                    rightText: creditDeclarationCtrl.creditProcessState.value !=
                            CreditProcessState.readCard
                        ? creditDeclarationCtrl.creditName.value
                        : '',
                    backColor: BaseColor.someTextPopupArea,
                  )),
                  const SizedBox(
                    height: 4,
                  ),
                  Center(
                      child: buildRow2ColumnType(
                    leftText: '会員番号',
                    rightText: creditDeclarationCtrl.creditProcessState.value !=
                            CreditProcessState.readCard
                        ? creditDeclarationCtrl.cardNumber.value
                        : '',
                    backColor: BaseColor.someTextPopupArea,
                  )),
                  const SizedBox(
                    height: 4,
                  ),
                  Center(
                      child: buildRow2ColumnType(
                    leftText: '有効期限',
                    rightText: creditDeclarationCtrl.creditProcessState.value !=
                            CreditProcessState.readCard
                        ? creditDeclarationCtrl.expiration.value
                        : '',
                    backColor: BaseColor.someTextPopupArea,
                  )),
                  const SizedBox(
                    height: 35,
                  ),
                  creditDeclarationCtrl.creditProcessState.value ==
                          CreditProcessState.selectPayment
                      ? const Center(
                          child: Text(
                          '支払い方法',
                          style: TextStyle(
                            color: BaseColor.baseColor,
                            fontSize: BaseFont.font22px,
                            fontFamily: BaseFont.familyDefault,
                          ),
                        ))
                      : const SizedBox.shrink(),
                  creditDeclarationCtrl.creditProcessState.value ==
                              CreditProcessState.confirmPayment &&
                          creditDeclarationCtrl.performBtnView.value
                      ? Column(
                          children: [
                            Center(
                                child: buildRow2ColumnType(
                              leftText: '支払い方法',
                              rightText:
                                  creditDeclarationCtrl.paymentMethod.value,
                            )),
                            const SizedBox(
                              height: 4,
                            ),
                            Center(
                                child: buildRow2ColumnType(
                              leftText: creditDeclarationCtrl
                                  .paymentDetailTopic1.value,
                              rightText: creditDeclarationCtrl
                                  .paymentDetailContent1.value,
                            )),
                            const SizedBox(
                              height: 4,
                            ),
                            Center(
                                child: buildRow2ColumnType(
                              leftText: creditDeclarationCtrl
                                  .paymentDetailTopic2.value,
                              rightText: creditDeclarationCtrl
                                  .paymentDetailContent2.value,
                            )),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            creditDeclarationCtrl.creditProcessState.value ==
                    CreditProcessState.selectPayment
                ? Positioned(
                    bottom: 40,
                    left: 36,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 1000.w,
                        height: 192,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  for (int i = 0; i <= creditDeclarationCtrl.listFirstStageNum.value; i++) ...{
                                    CreditPaymentMethodItem(
                                        creditPaymentMethod:
                                            creditDeclarationCtrl
                                                .paymentList[i]),
                                    i == creditDeclarationCtrl.listFirstStageNum.value
                                        ? const SizedBox.shrink()
                                        : const SizedBox(width: 16)
                                  }
                                ],
                              ),
                              creditDeclarationCtrl.paymentList.length > CreditPaymentController.maxHorizontal
                                  ? Row(
                                      children: [
                                        for (int i = CreditPaymentController.maxHorizontal;
                                        i <= creditDeclarationCtrl.listSecondStageNum.value ; i++) ...{
                                          CreditPaymentMethodItem(
                                              creditPaymentMethod:
                                                  creditDeclarationCtrl
                                                      .paymentList[i]),
                                          i == creditDeclarationCtrl.paymentList.length
                                              ? const SizedBox.shrink()
                                              : const SizedBox(width: 16)
                                        }
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              creditDeclarationCtrl.paymentList.length > CreditPaymentController.maxHorizontal * 2
                                  ? Row(
                                children: [
                                  for (int i = CreditPaymentController.maxHorizontal * 2;
                                  i <= creditDeclarationCtrl.paymentList.length - 1 ; i++) ...{
                                    CreditPaymentMethodItem(
                                        creditPaymentMethod:
                                        creditDeclarationCtrl
                                            .paymentList[i]),
                                    i == creditDeclarationCtrl.paymentList.length
                                        ? const SizedBox.shrink()
                                        : const SizedBox(width: 16)
                                  }
                                ],
                              )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            creditDeclarationCtrl.creditProcessState.value ==
                        CreditProcessState.confirmPayment &&
                    creditDeclarationCtrl.performBtnView.value
                ? Positioned(
                    bottom: 32,
                    right: 36,
                    child: DecisionButton(
                      oncallback: () async {
                        debugPrint('push 実行');
                        // todo クレ宣言バックエンド5：クレジット実行体が完成したらDecisionButton()内の★コメントを有効化する

                        // ボタン押下後に非表示にしないと連打できてしまうため非表示化
                        // ★creditDeclarationCtrl.performBtnView.value = false;

                        // クレジット支払いを行うバックエンド処理を呼び出す
                        // ★await RckyCha.rcKyCharge();
                        // バックエンド処理終了後、小計画面に戻るなら以下を実行

                        // todo フロント・バックエンド結合後：以下呼出を削除
                        // 処理に時間がかかっているように見せるために1秒ウェイトをかける
                        // await Future.delayed(const Duration(seconds: 1));

                        // ★Get.back();
                      },
                      text: '未作成', // ★(’確定する’に修正する)
                      isdecision: true,
                    ),
                  )
                : const SizedBox.shrink(),
            creditDeclarationCtrl.creditProcessState.value ==
                        CreditProcessState.confirmPayment &&
                    creditDeclarationCtrl.performBtnView.value
                ? Positioned(
                    left: 36.w,
                    bottom: 32.h,
                    child: SoundElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder()),
                        minimumSize: MaterialStateProperty.all(
                            const Size(maxWidth, maxHeight)),
                      ),
                      onPressed: () async {
                        // 支払方法選択のやり直し処理
                        await TchKeyDispatch.rcPre104CrdtProc(RcCrdt.KEY_PAYPREV);
                        creditDeclarationCtrl.setCreditPaymentStatus(
                            CreditProcessState.selectPayment);
                      },
                      callFunc:
                          '${runtimeType.toString()} text $returnBtnLabel',
                      child: Ink(
                        decoration: BoxDecoration(
                          color: BaseColor.someTextPopupArea,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: BaseColor.edgeBtnColor, width: 1.0.w),
                          boxShadow: const [
                            BoxShadow(
                              color: BaseColor.dropShadowColor,
                              spreadRadius: 3,
                              blurRadius: 0,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///確定ボタンとプラスボタンのアイコン配置
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: SvgPicture.asset(
                                  'assets/images/icon_back_credit.svg',
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: const Text(
                                  returnBtnLabel,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: BaseColor.baseColor,
                                      fontSize: BaseFont.font16px,
                                      fontFamily: BaseFont.familySub),
                                  maxLines: 2,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  /// ２列で表示する行を作成する
  /// leftText  左ラベルテキスト
  /// rightText 右ラベルテキスト
  /// backColor 右ラベルの背景色
  Widget buildRow2ColumnType(
      {String leftText = '',
      String rightText = '',
      Color backColor = BaseColor.transparentColor}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: SizedBox(
        width: 370,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                leftText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font18px,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
            ),
            SizedBox(
              width: 24.w,
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              color: backColor,
              alignment: Alignment.centerRight,
              width: 256.w,
              height: 40,
              child: Text(
                textAlign: TextAlign.right,
                rightText,
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyNumber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 合計額の行を作成する
  Widget buildAmountRow(String leftText,
      {String? rightText, Color color = BaseColor.baseColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                leftText,
                style: TextStyle(
                  fontSize: BaseFont.font22px,
                  color: color,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
              Text(
                rightText ?? '',
                style: TextStyle(
                    fontSize: BaseFont.font44px,
                    color: color,
                    fontFamily: BaseFont.familyNumber),
              ),
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          Container(
            width: double.infinity,
            height: 1.h,
            color: color,
          ),
        ],
      ),
    );
  }
}
