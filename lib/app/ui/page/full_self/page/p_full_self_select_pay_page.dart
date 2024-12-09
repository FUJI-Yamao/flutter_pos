/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/cmn_sysfunc.dart';
import '../../../../if/if_drv_control.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/sys/tpr_aid.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_auto_staffpw.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../../regs/checker/rcsyschk.dart';
import '../../../../regs/qcConnect/qcConnect.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/hidden_button.dart';
import '../../../component/w_trainingModeText.dart';
import '../../../controller/c_drv_controller.dart';
import '../../../language/l_languagedbcall.dart';
import '../../../socket/model/customer_socket_model.dart';
import '../../../socket/server/semiself_socket_server.dart';
import '../component/w_full_self_amount_row.dart';
import '../component/w_full_self_back_button.dart';
import '../component/w_full_self_footer.dart';
import '../component/w_full_self_payment_button.dart';
import '../component/w_full_self_select_pay_footer_upper.dart';
import '../component/w_full_self_topbar.dart';
import '../controller/c_full_self_register_controller.dart';
import '../controller/c_full_self_select_pay_controller.dart';
import '../controller/c_full_self_start_controller.dart';
import '../enum/e_full_self_kind.dart';
import 'p_full_self_cashpay_page.dart';

/// フルセルフの支払い方法選択画面（セミセルフのスタートページ）
class FullSelfSelectPayPage extends StatelessWidget with RegisterDeviceEvent {
  FullSelfSelectPayPage({
    super.key,
    this.isFromAdjustment = false,
  }) {
    registrationEvent();
    Get.lazyPut(() => FullSelfRegisterController());
  }

  //訓練モード判定
  final bool isTrainingMode = RcSysChk.rcTROpeModeChk();

  //商品登録のコントローラ
  final FullSelfRegisterController controller = Get.find();

  //支払い方法選択のコントローラ
  final FullSelfSelectPayController selectPayCtrl =
      Get.put(FullSelfSelectPayController());

  //フルセルフスタートページコントローラ
  final FullSelfStartController startCtrl = Get.find();

  //精算機モードの場合
  final bool isFromAdjustment;

  static Timer? timer;

  late RxTaskStatBuf tsBuf;
  late RxCommonBuf pCom;

  Future<void> _onTimer(Timer timer) async {
    controller.totalAmount.value =
        RegsMem().tTtllog.t100001.stlTaxInAmt.toString();
    if ((tsBuf.qcConnect.MyStatus.qcStatus ==
            SemiSelfSocketServer.msgStatusPaying) ||
        (tsBuf.qcConnect.MyStatus.qcStatus ==
            SemiSelfSocketServer.msgStatusPrePay)) {
      selectPayCtrl.isQcUse.value = true;
    } else {
      selectPayCtrl.isQcUse.value = false;
    }
    await QcConnect.dbSavedCheck();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
        onInit: () {
          RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
          RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);

          if (xRetS.isInvalid() || xRetC.isInvalid()) {
            return;
          }
          tsBuf = xRetS.object;
          pCom = xRetC.object;

          // 精算機通信サーバー起動
          Future(() async {
            if (pCom.iniMacInfo.select_self.kpi_hs_mode == 2) {
              await QcConnect.qcConnectMain();
              selectPayCtrl.isQcUse.value = false;
              timer =
                  Timer.periodic(const Duration(milliseconds: 1000), _onTimer);
            }
          });
        },
        dispose: () {
          Future(() async {
            if (pCom.iniMacInfo.select_self.kpi_hs_mode == 2) {
              if (timer != null) {
                timer!.cancel();
                timer = null;
              }

              /// 従業員クローズ
              AutoStaffInfo autoStaffInfo =
                  AutoStaffInfo(compCd: 0, streCd: 0, macNo: 0, staffCd: "");
              FullSelfStartController startcontroller =
                  Get.put(FullSelfStartController(autoStaffInfo));
              AplLibAutoStaffPw.closeStaff(startcontroller.autoStaffInfo);
            }
          });
        },
        child: Scaffold(
            body: Stack(
          children: [
            // タイトルバー
            Obx(
              () => FullSelfTopGreyBar(
                  title: 'l_full_self_select_payment_method'.trns),
            ),
            // 中身の要素
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 76.0, bottom: 16.0, left: 32.0, right: 32.0),
                    child: Column(
                      children: [
                        //お支払い金額コンテナー
                        Obx(
                          () => FullSelfAmountBlackContainer(
                            height: 80.0,
                            children: [
                              SizedBox(
                                height: 64.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 256.0,
                                      child: FittedBox(
                                        alignment: Alignment.bottomLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'l_full_self_total_amount'.trns,
                                          style: const TextStyle(
                                            color: BaseColor.someTextPopupArea,
                                            fontSize: BaseFont.font24px,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FullSelfAmountRow(
                                      label: '',
                                      value:
                                          '¥ ${controller.totalAmount.value}',
                                      isTotal: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // 支払い方法選択ボタン
                        Expanded(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //セミセルフ精算機モードの場合
                                if (!isFromAdjustment) FullSelfBackButton(),
                                Expanded(
                                  child: Obx(() {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: 150.w,
                                        right: 20.w,
                                      ),
                                      child: GridView.builder(
                                        itemCount:
                                            selectPayCtrl.isShowIDQuicPay.value
                                                ? selectPayCtrl
                                                    .fullSelfeMoneyList.length
                                                : selectPayCtrl
                                                    .fullSelfPaymentMethods
                                                    .length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 7 / 4,
                                        ),
                                        itemBuilder: (context, index) {
                                          var button = selectPayCtrl
                                                  .isShowIDQuicPay.value
                                              ? selectPayCtrl
                                                  .fullSelfeMoneyList[index]
                                              : selectPayCtrl
                                                      .fullSelfPaymentMethods[
                                                  index];
                                          return FullSelfPaymentButton(
                                            presetData: button,
                                            onPressed: () {
                                              selectPayCtrl
                                                  .paymentButtonAction(button);
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        // カメラ画像とボタン
                        FullSelfFooter(
                          fullSelfKind: isFromAdjustment
                              ? DisplayingFooterFullSelfKind.semiSelf
                              : DisplayingFooterFullSelfKind.selectPayment,
                          // フルセルフの支払方法選択画面の上側のボタン
                          upperRow: const SelectPayFooterUpperButtons(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //精算機モードの場合
            if (isFromAdjustment)
              Obx(() {
                if (selectPayCtrl.isQcUse.value == false) {
                  return Stack(
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.8),
                        child: Center(
                          child: Container(
                            width: 400,
                            height: 200,
                            color: Colors.lightBlue,
                            child: const Center(
                              child: Text(
                                '待機中',
                                style: TextStyle(
                                  color: BaseColor.someTextPopupArea,
                                  fontSize: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //訓練モードの時表示する半透明テキスト
                      if (isTrainingMode) TrainingModeText(),
                      // 隠しボタンメンテナンス操作
                      HiddenButton(
                        onTap: () => startCtrl.semiSelftoMaintenance(),
                        alignment: Alignment.topLeft,
                      ),
                      // 隠しボタンメインメニューへ
                      HiddenButton(
                        onTap: () => startCtrl.semiSelftoMainManu(),
                        alignment: Alignment.topRight,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
          ],
        )));
  }

  /// キーコントローラ取得
  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);

    //現金の支払い
    keyCon.funcMap[FuncKey.KY_CASH] = () async {
      Get.to(() => FullSelfCashPayPage(
            title: "l_full_self_cash_payment",
          ));
    };

    // 電子マネー
    keyCon.funcMap[FuncKey.KY_PAY_LIST1] = () async {
      selectPayCtrl.isShowIDQuicPay.value = true;
    };
    return keyCon;
  }

  ///スキャンコントローラ取得
  @override
  Function(RxInputBuf)? getScanCtrl() {
    return (data) {
      IfDrvControl()
          .mkeyIsolateCtrl
          .dispatch
          ?.rcDKeyByKeyId(data.funcCode, data.devInf.barData);
    };
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.subtotal;
  }
}

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Function dispose;
  final Widget child;

  const StatefulWrapper(
      {super.key,
      required this.onInit,
      required this.dispose,
      required this.child});

  @override
  StatefulWrapperState createState() => StatefulWrapperState();
}

class StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
