/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/lib/apllib/image_label_dbcall.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_pos/app/ui/page/common/component/w_dicisionbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../common/number_util.dart';
import '../../../if/if_drv_control.dart';
import '../../../if/if_scan_isolate.dart';
import '../../../inc/apl/fnc_code.dart';
import '../../../inc/apl/image.dart';
import '../../../inc/sys/tpr_aid.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../regs/acx/rc_acx.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../regs/checker/rc_key.dart';
import '../../../regs/checker/rc_key_cash4demo.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_inputbox.dart';
import '../../component/w_sound_buttons.dart';
import '../../controller/c_drv_controller.dart';
import '../common/basepage/common_base.dart';
import '../subtotal/component/w_register_tenkey.dart';
import '../subtotal/controller/c_coupons_controller.dart';
import 'controller/c_cashpayment_controller.dart';

///現金で支払いするページ
class CashPaymentScreen extends CommonBasePage {
  CashPaymentScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'CashPaymentScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: (){
                RcKeyCashDemo.isCancel  = true;
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
    return CashPaymentWidget(
      backgroundColor: backgroundColor,
    );
  }

}

class CashPaymentWidget extends StatefulWidget {
  final Color backgroundColor;

  CashPaymentWidget({super.key, required this.backgroundColor});

  @override
  CashPaymenthState createState() => CashPaymenthState();
}

class CashPaymenthState extends State<CashPaymentWidget> with RegisterDeviceEvent {
  String currentPaymentMethod = '';
  final cashPayCtrl = Get.put(CashPaymentInputController());
  final CouponsController couponCtrl = Get.find();

  @override
  void initState() {
    super.initState();
    registrationEvent();
    Future(() async {
      currentPaymentMethod = 'noChangeMachine';
      if ((await RcKeyCashDemo.rcKeyCash4Demo()).$1) {
        int listAddValue = cashPayCtrl.subtotalCtrl.changeReceivedAmount.value;
        couponCtrl.addCoupon('現金', listAddValue, 1);
        couponCtrl.showCouponList.value = true;
      } else {
        RcKeyCashDemo.updateInCoin(cashPayCtrl.subtotalCtrl);
      }
      // RcAcx.rcAcxMainIsolate();
      cashPayCtrl.subtotalCtrl.calculateAmounts();
      cashPayCtrl.isHandyDecision.value =
      cashPayCtrl.subtotalCtrl.currentPaymentMethod.value == 'noChangeMachine';
    });
  }

  ///合計金額、お預かり金額、残りお釣りの行の構築Widget
  Widget buildAmountRow(String leftText,
      {String? rightText,
      Widget? rightWidget,
      Color color = BaseColor.baseColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: TextStyle(
                fontSize: BaseFont.font22px,
                color: color,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
            if (rightWidget != null)
              rightWidget
            else
              Padding(padding: EdgeInsets.only(right: 32.w),
                child: Text(
                  rightText ?? '',
                  style: TextStyle(
                      fontSize: BaseFont.font44px,
                      color: color,
                      fontFamily: BaseFont.familyNumber),
                ),
              ),
          ],
        ),
        if (rightWidget == null) ...[
          SizedBox(
            height: 15.h,
          ),
          Container(
            width: 400.w,
            height: 1.h,
            color: color,
          ),
        ]
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 現計のキーオプションの預り金額の置数強制  0:しない 1:する 2:確定処理 3:券面のみ
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: Center(
            child: Obx(() {
              String appbarText;
              switch (cashPayCtrl.subtotalCtrl.currentPaymentMethod.value) {
                ///手入力で現金支払いの場合
                case 'noChangeMachine':
                  appbarText = 'お預かり金額を入力してください';
                  break;

                ///釣銭機と繋がっている場合
                case 'haveChangeMachine':
                  appbarText = 'お預かり金額を釣銭機に入れてください';
                  break;

                ///入金完了の場合
                case 'paymentComplete':
                  appbarText = 'お預かり金額を確認し、「確定ボタン」を押してください';
                  break;
                default:
                  appbarText = '';
              }
              return Text(
                textAlign: TextAlign.center,
                appbarText,
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                ),
              );
            }),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(children: [
            SizedBox(height: 56.h),
            Padding(
              padding: EdgeInsets.only(left: 228.w),
              child: Container(
                  width: 480.w,
                  height: 65.h,
                  color: BaseColor.transparent,

                  ///合計金額
                  child: Obx(
                    () => buildAmountRow(
                      ImageDefinitions.IMG_TTL.imageData,
                      rightText: NumberFormatUtil.formatAmount(
                          cashPayCtrl.currentTotalAmount.value),
                    ),
                  )),
            ),
            SizedBox(
              height: 36.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 228.w),
              child: Container(
                width: 480.w,
                height: 280.h,
                color: BaseColor.someTextPopupArea,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///お預かり金額
                    Obx(() {
                      if (cashPayCtrl.subtotalCtrl.currentPaymentMethod.value ==
                          'noChangeMachine') {
                        return buildAmountRow(
                          ImageDefinitions.IMG_CASH.imageData,
                          rightWidget: InputBoxWidget(
                            key: cashPayCtrl.inputBoxKey,
                            width: 280.w,
                            height: 72.h,
                            fontSize: BaseFont.font44px,
                            textAlign: TextAlign.right,
                            padding: EdgeInsets.only(right: 32.w),
                            cursorColor: BaseColor.baseColor,
                            unfocusedBorder: BaseColor.inputFieldColor,
                            focusedBorder: BaseColor.accentsColor,
                            focusedColor: BaseColor.inputBaseColor,
                            borderRadius: 4,
                            blurRadius: 6,
                            funcBoxTap: () {
                              cashPayCtrl.onInputBoxTap();
                            },
                            iniShowCursor: true,
                            mode: InputBoxMode.payNumber,
                          ),
                        );
                      } else if (cashPayCtrl.subtotalCtrl.currentPaymentMethod.value ==
                          'haveChangeMachine') {
                        return buildAmountRow(
                            ImageDefinitions.IMG_CASH.imageData,
                            rightText: NumberFormatUtil.formatAmount(
                                cashPayCtrl.subtotalCtrl.changeReceivedAmount.value));
                      } else {
                        if (cashPayCtrl.isHandyDecision.value) {
                          return buildAmountRow(
                            ImageDefinitions.IMG_CASH.imageData,
                            rightText: NumberFormatUtil.formatAmount(
                                cashPayCtrl.cashAmount.value),
                          );
                        } else {
                          return buildAmountRow(
                            ImageDefinitions.IMG_CASH.imageData,
                            rightText: NumberFormatUtil.formatAmount(
                                cashPayCtrl.subtotalCtrl.changeReceivedAmount.value),
                          );
                        }
                      }
                    }),
                    SizedBox(
                      height: 90.h,
                    ),

                    ///残り金額とお釣り
                    Obx(() {
                      int workChange = 0;
                      Color workColor = BaseColor.accentsColor;
                      String workImgData = ImageDefinitions.IMG_CHANGE.imageData;
                      if (cashPayCtrl.subtotalCtrl.currentPaymentMethod.value == 'haveChangeMachine') {
                        if (cashPayCtrl.subtotalCtrl.changeReceivedAmount.value >=
                            cashPayCtrl.currentTotalAmount.value) {
                          workChange = cashPayCtrl.subtotalCtrl.changeReceivedAmount.value -
                              cashPayCtrl.currentTotalAmount.value;
                        }
                        else {
                          workChange = cashPayCtrl.currentTotalAmount.value -
                              cashPayCtrl.subtotalCtrl.changeReceivedAmount.value;
                          workColor = BaseColor.attentionColor;
                          workImgData = ImageDefinitions.IMG_SHORT.imageData;
                        }
                      }
                      else if (cashPayCtrl.subtotalCtrl.currentPaymentMethod.value == 'noChangeMachine') {
                        if (cashPayCtrl.cashAmount.value >= cashPayCtrl.currentTotalAmount.value) {
                          workChange = cashPayCtrl.cashAmount.value - cashPayCtrl.currentTotalAmount.value;
                        }
                        else {
                          workChange = cashPayCtrl.currentTotalAmount.value - cashPayCtrl.cashAmount.value;
                          workColor = BaseColor.attentionColor;
                          workImgData = ImageDefinitions.IMG_SHORT.imageData;
                        }
                      }
                      else {
                        if (cashPayCtrl.isHandyDecision.value) {
                          workChange =
                              cashPayCtrl.cashAmount.value -
                                  cashPayCtrl.currentTotalAmount.value;
                        }
                        else {
                          workChange =
                              cashPayCtrl.subtotalCtrl.changeReceivedAmount.value -
                                  cashPayCtrl.currentTotalAmount.value;
                        }
                      }
                      return buildAmountRow(
                          workImgData,
                          rightText: NumberFormatUtil.formatAmount(workChange),
                          color: workColor);
                    }),
                  ],
                ),
              ),
            ),
          ]),
          
          ///手入力に切替ボタン配置
         Obx(() {
            if ((cashPayCtrl.subtotalCtrl.currentPaymentMethod.value == 'haveChangeMachine') &&
                (pCom.dbKfnc[FuncKey.KY_CASH.keyId].opt.cash.frcEntryFlg != 2)) {
              return  Positioned(
               left: 32.w,
               bottom: 32.h,
               child: DecisionButton(
                 oncallback: () {
                   cashPayCtrl.subtotalCtrl.updatePaymentMethod('noChangeMachine');
                 },
                 text: '手入力に切替',
                 useGradient: false,
               ),
             );
           } else {
             return Container();
           }
         }),

          ///入金完了の確定ボタン
          Obx(() {
            if (_isShowPaymentCompleteButton()) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: DecisionButton(
                  oncallback: _decideCinAmount,
                  text: '確定する',
                  isdecision: true,
                ),
              );
            } else {
              return Container();
            }
          }),
          
          ///テンキー表示する
          Obx(() {
            if (cashPayCtrl.showRegisterTenkey.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: RegisterTenkey(
                  onKeyTap: (key) {
                    cashPayCtrl.inputKeyType(key);
                  },
                ),
              );
            } else {
              return Container();
            }
          }),

          ///残額がある場合のお支払い方法追加のボタン配置(今は不要？）
          ///テンキー表示するときボタンは消えます
          Obx(() {
            if (_isShowAddPaymentButton()) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: DecisionButton(
                  oncallback:() {
                    _addPayment();
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

  /// 確定ボタン表示判定
  bool _isShowPaymentCompleteButton() {
    return (
      cashPayCtrl.showConfirButton.value || 
      cashPayCtrl.subtotalCtrl.currentPaymentMethod.value == 'paymentComplete'
    ) && !cashPayCtrl.operationFinish.value;
  }

  /// お支払い方法の追加ボタン表示判定
  bool _isShowAddPaymentButton() {
    return (
      cashPayCtrl.showPlusButton.value && 
      !cashPayCtrl.showRegisterTenkey.value || 
      (
        cashPayCtrl.subtotalCtrl.currentPaymentMethod.value == 'haveChangeMachine' && 
        cashPayCtrl.currentTotalAmount.value > cashPayCtrl.subtotalCtrl.changeReceivedAmount.value
      )
    ) && !cashPayCtrl.operationFinish.value;
  }

  /// 確定ボタン押下時処理
  void _decideCinAmount() {
    cashPayCtrl.operationFinish.value = true;
    if (cashPayCtrl.subtotalCtrl.currentPaymentMethod.value == 'noChangeMachine') {
      RcKeyCashDemo.inputHandy = cashPayCtrl.cashAmount.value;
    }
    RcKeyCashDemo.updateInCoin(cashPayCtrl.subtotalCtrl);

    //RcAcx.isDecideCinAmount = true;
    RcKeyCashDemo.isDecideCinAmount = true;
  }

  /// 支払方法追加ボタン押下処理
  void _addPayment() {
    // 確定時と同じ処理
    _decideCinAmount();
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.cashPayment;
  }

  @override
  KeyDispatch? getKeyCtrl() {
    // テンキーと同じ処理を行うため、テンキーのウィジェットクラスから取得する
    KeyDispatch keyCon = RegisterTenkeyState.getTenKeyCtrl(cashPayCtrl.inputKeyType);
    keyCon.funcMap[FuncKey.KY_CASH] = () async {
      if (_isShowAddPaymentButton()) {
        // お支払い方法の追加ボタン押下時処理
        _addPayment();
      } else if (_isShowPaymentCompleteButton()) {
        // 確定ボタン押下時処理
        _decideCinAmount();
      }
    };

    return keyCon;
  }

  @override
   Function(RxInputBuf)? getScanCtrl() {
    // スキャンの処理が既にあるなら引き継ぐ.
    if (IfDrvControl().scanMap.isEmpty) {
      // 登録されていない
      return null;
    }
    return IfScanIsolate().funcScan;
  }

}
