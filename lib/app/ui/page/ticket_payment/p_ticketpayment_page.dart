/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/inc/apl/fnc_code.dart';
import 'package:flutter_pos/app/lib/apllib/image_label_dbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../common/number_util.dart';
import '../../../inc/apl/image.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/apl/rxtbl_buff.dart';
import '../../../lib/cm_chg/ltobcd.dart';
import '../../../regs/checker/rc_flrda.dart';
import '../../../regs/checker/rcky_cha.dart';
import '../../../regs/inc/rc_mem.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_inputbox.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import '../common/component/w_dicisionbutton.dart';
import '../subtotal/component/w_register_tenkey.dart';
import '../subtotal/controller/c_coupons_controller.dart';
import '../subtotal/controller/c_subtotal_controller.dart';
import 'controller/c_ticketpayment_controller.dart';

/// 動作概要
/// 起動方法： Get.to(() => TicketPaymentScreen(funcKey, kyName, title: "商品券でお支払い",)); など
///           共有メモリに以下が設定されていることを前提に動作する
///           pCom.dbKfnc[funcKey].opt.cha.crdtEnbleFlg;  // 掛売登録  0:しない 1:する
//            pCom.dbKfnc[funcKey].opt.cha.frcEntryFlg;   // 預り金額の置数強制  0:しない 1:する 2:確定処理 3:券面のみ
//            pCom.dbKfnc[funcKey].opt.cha.mulFlg;        // 乗算登録  0:禁止 1:有効
//            pCom.dbKfnc[funcKey].opt.cha.chkAmt;        // 券面金額
//            pCom.dbKfnc[funcKey].opt.cha.nochgFlg;      // 釣り銭支払  0:あり 1:なし 2:確認表示 3:使用不可
/// 処理結果：確定処理後、商品券の支払額として以下に加算する
///         subtotalCtrl.receivedAmount

/// 入力ボックスの種別
enum InputBoxType {
  edit, // 編集可能エディットボックス
  label // 文字表示のみ
}

/// 商品券で支払いするページ
class TicketPaymentScreen extends CommonBasePage {
  TicketPaymentScreen(this.funcKey, this.kyName, {
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'TicketPaymentScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                // todo 現金支払画面から呼ばれている想定なので、処理内容は要確認
                Get.back();
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

  final FuncKey funcKey;
  final String kyName;

  @override
  Widget buildBody(BuildContext context) {
    return TicketPaymentWidget(
      backgroundColor: backgroundColor,
      funcKey: funcKey,
      kyName: kyName,
    );
  }
}

class TicketPaymentWidget extends StatefulWidget {
  final Color backgroundColor;
  final FuncKey funcKey;
  final String kyName;

  const TicketPaymentWidget({super.key, required this.backgroundColor, required this.funcKey, required this.kyName});

  @override
  TicketPaymentState createState() => TicketPaymentState();
}

class TicketPaymentState extends State<TicketPaymentWidget> {
  final ticketPayCtrl = Get.put(TicketPaymentInputController());
  SubtotalController subtotalCtrl = Get.find();
  CouponsController couponCtrl = Get.find();
  late String msg = ''; // メッセージ内容

  @override
  void initState() {
    super.initState();

    // 共有メモリの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    ticketPayCtrl.crdtEnbleFlg.value = pCom.dbKfnc[widget.funcKey.keyId].opt.cha.crdtEnbleFlg;
    ticketPayCtrl.frcEntryFlg.value = pCom.dbKfnc[widget.funcKey.keyId].opt.cha.frcEntryFlg;
    ticketPayCtrl.mulFlg.value = pCom.dbKfnc[widget.funcKey.keyId].opt.cha.mulFlg;
    ticketPayCtrl.chkAmt.value = pCom.dbKfnc[widget.funcKey.keyId].opt.cha.chkAmt;
    ticketPayCtrl.nochgFlg.value = pCom.dbKfnc[widget.funcKey.keyId].opt.cha.nochgFlg;

    debugPrint("ticketPayCtrl.crdtEnbleFlg.value=${ticketPayCtrl.crdtEnbleFlg.value.toString()}");
    debugPrint("ticketPayCtrl.frcEntryFlg.value=${ticketPayCtrl.frcEntryFlg.value.toString()}");
    debugPrint("ticketPayCtrl.mulFlg.value=${ticketPayCtrl.mulFlg.value.toString()}");
    debugPrint("ticketPayCtrl.chkAmt.value=${ticketPayCtrl.chkAmt.value.toString()}");
    debugPrint("ticketPayCtrl.nochgFlg.value=${ticketPayCtrl.nochgFlg.value.toString()}");

    ticketPayCtrl.currentTotalAmount.value = ticketPayCtrl.subtotalCtrl.notEnoughAmount.value;

    _judgeScreenMode();
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
            child: Text(
              textAlign: TextAlign.center,
              msg,
              style: const TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 56.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ticketPayCtrl.frcEntryFlg.value == 1
                              ? 113.w
                              : 213.w),
                      child: SizedBox(
                        // 預り金額の置数強制が「する」の場合は左入力ボックスが有効となり、表示サイズを大きくする
                        width:
                        ticketPayCtrl.frcEntryFlg.value == 1 ? 580.w : 480.w,
                        height: 60.h,
                        child: buildAmountRow(
                          ImageDefinitions.IMG_TTL.imageData,
                          rightText: NumberFormatUtil.formatAmount(
                              ticketPayCtrl.currentTotalAmount.value),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Padding(
                      // 預り金額の置数強制が「する」の場合は表示サイズを大きくするため開始位置を左側にずらす
                      padding: EdgeInsets.only(
                          left: ticketPayCtrl.frcEntryFlg.value == 1
                              ? 113.w
                              : 213.w),
                      child: Container(
                        color: BaseColor.someTextPopupArea,
                        width:
                        ticketPayCtrl.frcEntryFlg.value == 1 ? 580.w : 480.w,
                        height: 432.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40.0,
                              ),
                              child: Container(
                                alignment: Alignment.topLeft,
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 34.h),
                                child: const Text(
                                  '商品券',
                                  style: TextStyle(
                                    color: BaseColor.baseColor,
                                    fontSize: BaseFont.font22px,
                                    fontFamily: BaseFont.familyDefault,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 48.h,
                            ),

                            // 金額と枚数の入力ボックス
                            buildTicketRow(
                              ticketPayCtrl.currentTicketValue.value > 0
                                  ? NumberFormatUtil.formatAmount(
                                      ticketPayCtrl.currentTicketValue.value)
                                  : '',
                              centerText:
                                  ticketPayCtrl.currentTicketCount.value > 0
                                      ? ticketPayCtrl.currentTicketCount.value
                                          .toString()
                                      : '',
                              rightText: NumberFormatUtil.formatAmount(
                                  ticketPayCtrl.ticketAmount.value),
                              boxType1: ticketPayCtrl.isLeftBoxEnabled.value
                                  ? InputBoxType.edit
                                  : InputBoxType.label,
                              boxType2: ticketPayCtrl.isRightBoxEnabled.value
                                  ? InputBoxType.edit
                                  : InputBoxType.label,
                              leftFontSize:
                                  ticketPayCtrl.ticketAmountFontSize.value,
                              rightFontSize:
                                  ticketPayCtrl.ticketTotalAmountFontSize.value,
                            ),

                            SizedBox(
                              height: 100.h,
                            ),

                            // 残り金額とお釣り
                            ticketPayCtrl.isAvailablePurchase.value &&
                                ticketPayCtrl.nochgFlg.value == 1
                                ? buildAmountRow(
                                ImageDefinitions.IMG_CHANGE.imageData,
                                rightText: NumberFormatUtil.formatAmount(0),
                                color: BaseColor.ticketPayEnoughColor)
                                : ticketPayCtrl.currentTotalAmount.value -
                                        ticketPayCtrl.ticketAmount.value >
                                    0
                                ? buildAmountRow(
                                    ImageDefinitions.IMG_SHORT.imageData,
                                    rightText: NumberFormatUtil.formatAmount(
                                        (ticketPayCtrl.currentTotalAmount.value -
                                                ticketPayCtrl
                                                    .ticketAmount.value)
                                            .abs()),
                                    color: BaseColor.attentionColor)
                                : buildAmountRow(
                                    ImageDefinitions.IMG_CHANGE.imageData,
                                    rightText: NumberFormatUtil.formatAmount(
                                        (ticketPayCtrl.ticketAmount.value -
                                            ticketPayCtrl.currentTotalAmount.value)
                                            .abs()),
                                    color: BaseColor.ticketPayEnoughColor),

                            // 釣り銭支払なしの場合に購入可能金額を表示
                            ticketPayCtrl.isAvailablePurchase.value &&
                                ticketPayCtrl.nochgFlg.value == 1
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    height: 80.h,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.only(left: 60.w, top: 10.h),
                                    child: Text(
                                      '${NumberFormatUtil.formatAmount(ticketPayCtrl.ticketAmount.value -
                                          ticketPayCtrl.currentTotalAmount.value)}分が購入可能です',
                                      style: const TextStyle(
                                        color: BaseColor.attentionColor,
                                        fontSize: BaseFont.font28px,
                                        fontFamily: BaseFont.familyDefault,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 80.h,
                                    width: double.infinity,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),

          //入金完了の確定ボタン
          Obx(() {
            if (!ticketPayCtrl.showRegisterTenkey.value &&
                (ticketPayCtrl.ticketAmount.value >=
                    ticketPayCtrl.currentTotalAmount.value)) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: DecisionButton(
                  oncallback: () async {
                    // 確定時は使用した商品券の釣り銭支払フラグを設定して釣り銭￥０の判定をさせる
                    subtotalCtrl.nochgFlg.value = ticketPayCtrl.nochgFlg.value;
                    await _ticketPayment(widget.funcKey, true);
                  },
                  text: '確定する',
                  isdecision: true,
                ),
              );
            } else {
              return Container();
            }
          }),

          // テンキー
          Obx(() {
            if (ticketPayCtrl.showRegisterTenkey.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: RegisterTenkey(
                  onKeyTap: (key) {
                    ticketPayCtrl.inputKeyType(
                        key, ticketPayCtrl.currentBoxIndex.value);
                  },
                ),
              );
            } else {
              return Container();
            }
          }),

          // お支払い方法を追加ボタン
          Obx(() {
            if (!ticketPayCtrl.showRegisterTenkey.value &&
                (ticketPayCtrl.ticketAmount.value <
                    ticketPayCtrl.currentTotalAmount.value)) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: DecisionButton(
                  oncallback: () async {
                    await _ticketPayment(widget.funcKey, false);
                  },
                  text: 'お支払い方法を追加',
                  isplus: true,
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  /// 画面の表示パターンを判定
  void _judgeScreenMode() {
    var crdtEnbleFlg = ticketPayCtrl.crdtEnbleFlg.value;
    var frcEntryFlg = ticketPayCtrl.frcEntryFlg.value;
    var mulFlg = ticketPayCtrl.mulFlg.value;
    var chkAmt = ticketPayCtrl.chkAmt.value;

    // パターン１
    // 入力１：あり　入力２：なし　初期値なし
    if (crdtEnbleFlg == 0 && frcEntryFlg == 1 && mulFlg == 0) {
      msg = 'お預かりした商品券の金額を入力して下さい';
    }

    // パターン２
    // 入力１：あり　入力２：あり　初期値なし
    // パターン３
    // 入力１：あり　入力２：あり　初期値あり
    if (crdtEnbleFlg == 0 && frcEntryFlg == 1 && mulFlg == 1 && chkAmt >= 0) {
      msg = 'お預かりした商品券の金額と枚数を入力して下さい';
    }

    // パターン４
    // 入力１：なし　入力２：あり
    if (crdtEnbleFlg == 0 && frcEntryFlg == 3 && mulFlg == 1 && chkAmt > 0) {
      msg = 'お預かりした商品券の枚数を入力して下さい';
    }

    // パターン５
    // 入力１：なし　入力２：なし
    if (crdtEnbleFlg == 0 && frcEntryFlg == 3 && mulFlg == 0 && chkAmt > 0) {
      msg = 'お預かりした商品券の内容を確認して進めてください';
      ticketPayCtrl.isAvailablePurchase.value = true;
    } else if (msg.isEmpty) {
      msg = 'お預かりした商品券の内容を確認して進めてください';
    }

    // 入力状態の初期値を設定
    var workAmount = 0;
    var workTicketCount = 0;
    // 預り金額の置数強制が「券面のみ」かつ乗算登録が「有効」の場合は枚数0とし、
    // それ以外は枚数1とする
    if (frcEntryFlg == 3 && mulFlg == 1) {
      workTicketCount = 0;
    } else {
      workTicketCount = 1;
    }

    // 券面金額が0より大の場合は金額を設定し、それ以外は金額0とする
    if (chkAmt > 0) {
      workAmount = chkAmt;
    } else {
      workAmount = 0;
    }

    // 商品券券面額の入力ボックス有無
    if (frcEntryFlg == 1) {
      ticketPayCtrl.isLeftBoxEnabled.value = true;
      ticketPayCtrl.showRegisterTenkey.value = true;
    }

    // 商品券枚数の入力ボックス有無
    if (mulFlg == 1) {
      ticketPayCtrl.isRightBoxEnabled.value = true;
      ticketPayCtrl.showRegisterTenkey.value = true;
      if (!ticketPayCtrl.isLeftBoxEnabled.value) {
        ticketPayCtrl.currentBoxIndex.value = InputBoxIndex.ticketNumber;
      }
    }

    ticketPayCtrl.setInitialValue(workAmount, workTicketCount);
  }

  /// 商品券の券面額、枚数の行を作成する
  Widget buildTicketRow(String leftText, // 左入力ボックステキスト（ラベルの場合あり）
      {String centerText = '', // 中央入力ボックステキスト（ラベルの場合あり）
      String? rightText, // 右ラベルテキスト
      InputBoxType boxType1 = InputBoxType.edit, // 左入力ボックスのタイプ
      InputBoxType boxType2 = InputBoxType.edit, // 右入力ボックスのタイプ
      double leftFontSize = BaseFont.font44px, // 左入力ボックスのフォントサイズ
      double rightFontSize = BaseFont.font44px, // 右入力ボックスのフォントサイズ
      Color color = BaseColor.baseColor}) {
    // 下線の色
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 72.h,
                    child: Center(
                      child: boxType1 == InputBoxType.edit
                          ? InputBoxWidget(
                              initStr: leftText,
                              key: ticketPayCtrl.inputBoxKey1,
                              width: 168.w,
                              height: 72.h,
                              fontSize: leftFontSize,
                              textAlign: TextAlign.right,
                              padding: const EdgeInsets.only(right: 16),
                              cursorColor: BaseColor.baseColor,
                              unfocusedBorder: BaseColor.inputFieldColor,
                              focusedBorder: BaseColor.accentsColor,
                              focusedColor: BaseColor.inputBaseColor,
                              borderRadius: 4,
                              blurRadius: 6,
                              funcBoxTap: () {
                                ticketPayCtrl
                                    .onInputBoxTap(InputBoxIndex.ticketAmount);
                              },
                              iniShowCursor: true,
                              mode: InputBoxMode.payNumber,
                            )
                          : SizedBox(
                              width: 92.w,
                              height: 72.h,
                              child: Center(
                                child: Text(
                                  leftText,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color:
                                        BaseColor.ticketPayFixedForegroundColor,
                                    fontSize: leftFontSize,
                                    fontFamily: BaseFont.familyNumber,
                                  ),
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  SizedBox(
                    width: 24.w,
                    child: const Text(
                      '×',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: BaseColor.ticketPayFixedForegroundColor,
                        fontSize: BaseFont.font24px,
                        fontFamily: BaseFont.familyNumber,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Center(
                    child: boxType2 == InputBoxType.edit
                        ? InputBoxWidget(
                            initStr: centerText,
                            key: ticketPayCtrl.inputBoxKey2,
                            width: 80.w,
                            height: 72.h,
                            fontSize: BaseFont.font44px,
                            textAlign: TextAlign.right,
                            padding: const EdgeInsets.only(right: 16),
                            cursorColor: BaseColor.baseColor,
                            unfocusedBorder: BaseColor.inputFieldColor,
                            focusedBorder: BaseColor.accentsColor,
                            focusedColor: BaseColor.inputBaseColor,
                            borderRadius: 4,
                            blurRadius: 6,
                            funcBoxTap: () {
                              ticketPayCtrl
                                  .onInputBoxTap(InputBoxIndex.ticketNumber);
                            },
                            iniShowCursor:
                                boxType1 == InputBoxType.label ? true : false,
                            mode: InputBoxMode.defaultMode,
                          )
                        : Container(
                            width: 80.w,
                            height: 72.h,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 16.w),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.end,
                              children: [
                                Text(
                                  centerText,
                                  style: const TextStyle(
                                    color:
                                        BaseColor.ticketPayFixedForegroundColor,
                                    fontSize: BaseFont.font44px,
                                    fontFamily: BaseFont.familyNumber,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  SizedBox(
                    width: 24.w,
                    child: const Text(
                      '＝',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: BaseColor.ticketPayFixedForegroundColor,
                        fontSize: BaseFont.font24px,
                        fontFamily: BaseFont.familyNumber,
                      ),
                    ),
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
          Positioned(
            top: 0.h,
            right: 0.h,
            child: Container(
              alignment: Alignment.centerRight,
              width: 170.w,
              height: 72.h,
              child: Text(
                  rightText ?? NumberFormatUtil.formatAmount(0),
                  style: TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: rightFontSize,
                    fontFamily: BaseFont.familyNumber,
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 合計、残高・お釣りの行を作成する
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

  /// 確定キーまたは支払方法の追加キー押下時処理
  /// funcKey：  FUNCTION KEY CODE
  /// isDecide:  確定キー押下か否か
    Future<void> _ticketPayment(FuncKey funcKey, bool isDecide) async {
      String bcd;

    _commonProcess(isDecide);

    AcMem cMem = SystemFunc.readAcMem();
    KopttranBuff kopttran = KopttranBuff();
    cMem.stat.fncCode = funcKey.keyId;
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttran);

    if (ticketPayCtrl.currentTicketCount.value > 1) { // 品券枚数が2枚以上
      // 品券合計金額をcmLtobcdで文字列に変換
      bcd = Ltobcd.cmLtobcd(
          ticketPayCtrl.currentTicketValue.value, cMem.ent.entry.length);
      cMem.working.dataReg.kMul0 = ticketPayCtrl.currentTicketCount.value;
    } else {
      bcd = Ltobcd.cmLtobcd(
          ticketPayCtrl.ticketAmount.value, cMem.ent.entry.length);
      if ((kopttran.mulFlg == 1) && // 乗算設定が有効
          (ticketPayCtrl.currentTicketCount.value != 1)) { // 品券枚数が1枚ではない
        // 乗算値が空のため、rcATCTProcErrorChk()でエラーを出力する
        cMem.working.dataReg.kMul0 = -1;
      } else {
        cMem.working.dataReg.kMul0 = 0;
      }
    }
    for (int i = 0; i < cMem.ent.entry.length; i++) {
      // 文字列bcdを文字コードに変換して代入
      cMem.ent.entry[i] = bcd.codeUnits[i];
    }
    cMem.ent.tencnt = 0;
    await RckyCha.rcKyCharge();

    // 支払い後の画面遷移はrcATCTDisplayでCALLするためここでは不要
  }

  /// 商品券支払画面終了後の共通処理
  void _commonProcess(bool isDecide) {
    couponCtrl.addCoupon(widget.kyName, ticketPayCtrl.currentTicketValue.value, ticketPayCtrl.currentTicketCount.value);
    couponCtrl.showCouponList.value = true;
    if (isDecide) {
      subtotalCtrl.nochgFlg.value = ticketPayCtrl.nochgFlg.value;
    }
    subtotalCtrl.receivedAmount.value += ticketPayCtrl.ticketAmount.value;
    subtotalCtrl.calculateAmounts();
    debugPrint('商品券支払後receivedAmount=${subtotalCtrl.receivedAmount.value}');
  }
}
