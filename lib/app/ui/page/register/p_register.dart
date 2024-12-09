/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_staffpw.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_pos/app/ui/page/register/component/w_interrupt.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/number_util.dart';
import '../../../if/if_drv_control.dart';
import '../../../inc/apl/fnc_code.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/tpr_aid.dart';
import '../../../regs/checker/rc_key.dart';
import '../../../regs/checker/rc_touch_key.dart';
import '../../../regs/checker/rcky_stl.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../controller/c_drv_controller.dart';
import '../../enum/e_presetcd.dart';
import '../common/component/w_msgdialog.dart';
import '../manual_input/component/w_key_input_widget.dart';
import '../manual_input/controller/c_keypresed_controller.dart';
import '../price_check/controller/c_price_check_controller.dart';
import '../staff_open/enum/e_openclose_enum.dart';
import '../staff_open/w_open_close_page.dart';
import '../subtotal/component/w_backtoregister_button.dart';
import 'basepage/basepage.dart';
import 'component/w_modemessage.dart';
import 'component/w_pluarea.dart';
import 'component/w_pointshow.dart';
import 'component/w_selectpaymachine.dart';
import 'component/w_tablistview.dart';
import 'controller/c_registerbody_controller.dart';
import 'controller/c_registersupport_controller.dart';
import 'controller/c_supportbutton_controller.dart';
import '../../../regs/checker/rcstllcd.dart';

/// レジ登録ボディー
class RegisterPageWidget extends RegisterBasePage {
  ///タイトル
  final String title;

  ///コンストラクタ
  RegisterPageWidget({
    required this.title,
  });

  ///　ボディを構築
  @override
  Widget createBody(BuildContext context) {
    return RegisterBodyWidget(
      title: title,
    );
  }
}

/// ボディー部Widget
class RegisterBodyWidget extends StatelessWidget with RegisterDeviceEvent {
  ///　コンストラクタ
  RegisterBodyWidget({super.key, required this.title}) {
    if (AplLibStaffPw.staffPw.staffData.staffOpen != 0) {
      Future.delayed(Duration.zero, () {
        Get.dialog(
          StaffOpenClosePage(labels: const [
            OpenCloseInputFieldLabel.codeNum,
            OpenCloseInputFieldLabel.password
          ]),
          //　ダイアログ外タップで閉じない
          barrierDismissible: false,
        ).then((success) {
          if (success) {
            // スキャンイベントの競合回避のため、従業員オープンクローズ画面を閉じた後に登録
            registrationEvent();
          } else {
            Get.back();
          }
        });
      });
    } else {
      registrationEvent();
    }
  }
  
  /// ボディコントローラー
  final RegisterBodyController bodyctrl = Get.find();

  /// コモンコントローラー
  final CommonController commonctrl = Get.find();

  //手入力操作のコントローラ
  final KeyPressController keyPressCtrl = Get.put(KeyPressController());

  /// 価格確認コントローラ
  PriceCheckController priceCheckCtrl = Get.put(PriceCheckController());

  ///　タイトル
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 47,
              child: Container(
                padding: const EdgeInsets.only(right: 11),
                alignment: Alignment.topLeft,
                height: double.infinity,
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //  SizedBox(
                    //   height: 74.h,
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),

                    /// ポイント表示エリア
                    Container(
                      padding: const EdgeInsets.only(right: 19),
                      alignment: Alignment.topLeft,
                      child: const PointShowWidget(),
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    ///タブ付き客表エリア
                    Expanded(
                      flex: 90,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: const TableOfCustomersWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 53,
              child: SizedBox(
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildMKPressWidget(),
                          const Expanded(
                            child: PluArea(),
                          ),
                          _buildSubtotalSupport(),
                        ],
                      ),
                    //小計画面へ
                    Positioned(
                      right: 0,
                      bottom: 8.h,
                      child: Stack(children: [
                        BackRegisterButton(
                          text: 'l_reg_subtotal'.trns,
                          icon: Icons.arrow_forward,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(5)),
                          onTap: () => {
                            TchKeyDispatch.rcDTchByFuncKey(
                                FuncKey.KY_STL, null)
                          },
                        ),
                      ]),
                    ),
                    Obx(() => bodyctrl.prcChkMode.value && !keyPressCtrl.isMKInputMode.value
                    ? const Positioned(
                      right: 10,
                      top: 12,
                      child: ModeMessageWidget(
                        title: '価格確認',
                        message: '商品をスキャンまたはプリセットから選択してください',
                        backColor: BaseColor.someTextPopupArea,
                        edgeColor: BaseColor.edgeBtnTenkeyColor,
                      )
                    )
                    : const SizedBox.shrink(),
                    ),
                  ],
                 ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  ///メカキー入力欄
  Widget _buildMKPressWidget() {
    return Obx(() {
      if (keyPressCtrl.currentMode.value == MKInputMode.normal &&
          keyPressCtrl.funcKeyValue.value.isEmpty) {
        return _combineWidget();
      }
      /// todo: 割り込みキーが押下されたら以下のwigetを呼び出して割り込み中状態にする
      /// todo: 2人制かつチェッカーの条件を追加する
      /// return const InterruptWidget();
      ///
      return MKeyPressWidget(
        keyValue: keyPressCtrl.funcKeyValue.value,
        //決定ボタンの処理
        onConfirm: () => keyPressCtrl.handleConfirm(),
        currentMode: keyPressCtrl.currentMode.value,
      );
    });
  }
  
  /// 状態表示と精算機選択を組み合わせる
  Widget _combineWidget() {
    return Row(
        children: [
          _buildStatusWidget(),
          bodyctrl.isQcashierVisible.value
            ? const SelectQcashierWidget()
            : SizedBox(height: 68.h)
        ]
      );
  }
  
  /// 表示する状態タイプの決定
  Widget statusDisplayNum(int statusDisplayNum) {
    switch (statusDisplayNum) {
      // 状態が0個の場合
      case 0:
        break;
      // 状態が1個の場合
      case 1:
        return Row(
          children: [
            statusDisplayWidget(0),
          ],
        );
      // 状態が2個の場合
      case 2:
        return Row(
          children: [
            statusDisplayWidget(0),
            const SizedBox(
              width: 5,
            ),
            statusDisplayWidget(1),
          ],
        );
      // 状態が3個の場合
      case 3:
        return Column(
          children: [
            Row(
              children: [
                statusDisplayWidget(0),
                const SizedBox(
                  width: 5,
                ),
                statusDisplayWidget(1),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                statusDisplayWidget(2)
              ],
            ),
          ],
        );
      // 状態が4個の場合
      case 4:
        return Column(
          children: [
            Row(
              children: [
                statusDisplayWidget(0),
                const SizedBox(
                  width: 5,
                ),
                statusDisplayWidget(1),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                statusDisplayWidget(2),
                const SizedBox(
                  width: 5,
                ),
                statusDisplayWidget(3),
              ],
            ),
          ],
        );
    }
    return const Spacer();
  }

  /// 状態表示widget
  Widget statusDisplayWidget(int statusDisplayNum) {
    return Container(
      color: BaseColor.baseColor,
      width: 80,
      height: 24,
      child: Center(
        child: Text(
          commonctrl.changeDisplay[statusDisplayNum].name,
          style: const TextStyle(
            color: BaseColor.someTextPopupArea,
            fontSize: BaseFont.font14px,
            fontFamily: BaseFont.familyDefault,
          ),
        ),
      ),
    );
  }

  /// 状態表示widget
  Widget _buildStatusWidget() {
    // 釣機ONOFF機能が許可されていない場合は状態表示に釣機の設定を表示しない
    if (!(RegisterBodyController.changePermission.value)) {
      commonctrl.removeDisplayStatus();
    }
    if (commonctrl.changeDisplay.length > 4) {
      commonctrl.changeDisplay.removeLast();
    }
    return Obx(
      () => SizedBox(
        width: 165,
        height: 55,
        child: statusDisplayNum(
          commonctrl.changeDisplay.length
        ),
      ),
    );
  }

  ///登録サポート欄
  Widget _buildSubtotalSupport() {
    final registerCtrl = Get.put(RegisterSupportController());
    return Container(
      width: 552.w,
      height: 62.h,
      color: BaseColor.someTextPopupArea,
      margin: const EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 8.w, top: 8.w, right: 8.w),
      child: Obx(
        () => Wrap(
          spacing: 8.w,
          children: registerCtrl.supportButtons
              .map((button) =>
                  _buildSupportButton(button))
              .toList(),
        ),
      ),
    );
  }

  /// 登録サポートボタン
  Widget _buildSupportButton(PresetInfo presetInfo) {
    /// ボタンカラー
    final buttonColor = PresetCd.getBtnColor(presetInfo.presetColor);
    ///　ボタン枠線色
    final borderColor = presetInfo.presetColor == PresetCd.transColorCd
        ? BaseColor.loginTabTextColor
        : buttonColor;
    return Container(
      width: 96.w,
      height: 56.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: BaseColor.someTextPopupArea,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        border: Border(
            top: BorderSide(color: borderColor, width: 1.0.w),
            left: BorderSide(color: borderColor, width: 1.0.w),
            right: BorderSide(color: borderColor, width: 1.0.w),
            bottom: BorderSide.none),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 8.h,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
          ),
          Center(
            child: SoundTextButton(
              onPressed: () => onSuportButtonPressed(presetInfo.kyCd, presetInfo),
              callFunc: '_buildSupportButton - ${presetInfo.kyName}',
              child: Text(
                presetInfo.kyName,
                style: const TextStyle(
                    fontSize: BaseFont.font18px,
                    color: BaseColor.maintainInputFontColor,
                    fontFamily: BaseFont.familyDefault),
              ),
            )
          ),
        ],
      ),
    );
  }

  /// キーコントローラ取得
  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    keyCon.funcMap[FuncKey.KY_STL] = () async {
      // 価格確認モードではエラーとなる
      if (bodyctrl.prcChkMode.value) {
        priceCheckCtrl.showOperationErrorDialog();
        return;
      }

      int errNo = await RckyStl.rcKyStlError();
      if (errNo != 0) {
        MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: errNo,
        ));
      } else {
        Get.toNamed('/subtotal');
      }
    };

    keyCon.funcMap[FuncKey.KY_PLU] = (pluCd) async {
      if ((keyPressCtrl.currentMode.value == MKInputMode.priceChange) ||
          ((keyPressCtrl.currentMode.value == MKInputMode.waitingSecond) &&
              (keyPressCtrl.twinBarBeforeMode.value ==
                  MKInputMode.priceChange))) {
        /// 売価変更手入力ウィジェットが開いている場合
        await bodyctrl.inputManualChgPrice(
            FuncKey.KY_PLU, keyPressCtrl.funcKeyValue.value, pluCd ?? '');
      } else if ((keyPressCtrl.currentMode.value == MKInputMode.normal) ||
          ((keyPressCtrl.currentMode.value == MKInputMode.waitingSecond) &&
              (keyPressCtrl.twinBarBeforeMode.value == MKInputMode.normal))) {
        /// 手入力操作中は手入力操作の処理に入る
        await bodyctrl.manualRegistration(
            FuncKey.KY_PLU, keyPressCtrl.funcKeyValue.value, pluCd);
        keyPressCtrl.resetKey();
      } else {
        await bodyctrl.selectedPlu(pluCd, 1);
      }
    };

    //クリアキー
    keyCon.funcClr = () async {
      keyPressCtrl.resetKey();
    };

    keyCon.funcNum = (FuncKey key) {
      /// 手入力操作用ウィジェット呼び出し
      debugPrint('funcNum called with key: ${key.name}');

      String keyStr = key.getFuncKeyNumberStr();
      keyPressCtrl.updateKey(keyStr);
    };

    return keyCon;
  }

  ///スキャンコントローラ取得
  @override
  Function(RxInputBuf)? getScanCtrl() {
    return (data) {
      // アドオンコードが含まれている場合は、バーコードデータの末尾に付与する
      String barData = data.devInf.barData;
      if (data.devInf.adonCd.isNotEmpty) {
        barData += data.devInf.adonCd;
      }
      IfDrvControl()
          .mkeyIsolateCtrl
          .dispatch
          ?.rcDKeyByKeyId(data.funcCode, barData);
    };
  }

  ///　タグを取得
  @override
  IfDrvPage getTag() {
    return IfDrvPage.register;
  }
}

///　タブ付き客表を表示
class TableOfCustomersWidget extends StatelessWidget {
  /// コンストラクタ
  const TableOfCustomersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ///　コントローラ
    RegisterBodyController bodyctrl = Get.find();
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // タブ＆点数、金額
        Container(
          height: 92,
            padding: const EdgeInsets.only(right: 19),
            child: Flex(
              direction: Axis.vertical,
              children: [
                // タブ
                Obx(() => TabButtonWidget(
                  BaseColor.someTextPopupArea,
                  bodyctrl.refundFlag.value ? BaseColor.refundAreaBackColor : BaseColor.baseColor,
                ),),

                // 点数、金額
                Expanded(
                  flex: 15,
                  child:
                  Obx(() => Container(
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: bodyctrl.refundFlag.value ? BaseColor.refundAreaBackColor : BaseColor.baseColor,
                      border: bodyctrl.refundFlag.value
                          ? Border.all(color: BaseColor.attentionColor, width: 2)
                          : null,
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Flex(
                            mainAxisAlignment: MainAxisAlignment.end,
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Obx(
                                  () => Text(
                                    '${bodyctrl.totalData.value.getItemCount()}',
                                    style: TextStyle(
                                        color: bodyctrl.refundFlag.value ? BaseColor.attentionColor : BaseColor.someTextPopupArea,
                                        fontSize: BaseFont.font28px),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Obx(
                                () => Text(
                                  'l_reg_qty'.trns,
                                  style: TextStyle(
                                      color: bodyctrl.refundFlag.value
                                          ? BaseColor.attentionColor
                                          : BaseColor.someTextPopupArea,
                                      fontSize: BaseFont.font18px),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: const EdgeInsets.only(right: 64),
                          alignment: Alignment.bottomRight,
                          child: Obx(
                            () => Text(
                                NumberFormatUtil.formatAmount(bodyctrl
                                    .totalData.value.t100001.stlTaxInAmt),
                                style: TextStyle(
                                    color: bodyctrl.refundFlag.value
                                        ? BaseColor.attentionColor
                                        : BaseColor.someTextPopupArea,
                                    fontSize: BaseFont.font28px,
                                    fontFamily: BaseFont.familyNumber)),
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),
                  ),
                ),
              ],
            ),
        ),
        //),

        // 客表
        Expanded(
          flex: 854,
          child: Container(
            alignment: Alignment.topLeft,
            child: const ListPurchaseAnimatedWidget(),
          ),
        ),
      ],
    );
  }
}
