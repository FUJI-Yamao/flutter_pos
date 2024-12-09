/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../regs/checker/rc_ext.dart';
import '../../../../regs/checker/rcky_dsc.dart';
import '../../../../regs/checker/rcky_rpr.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../../regs/checker/regs.dart';
import '../../../../regs/inc/rc_regs.dart';
import '../../../../regs/spool/rsmain.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../controller/c_common_controller.dart';
import '../../common/component/w_msgdialog.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../../register/controller/c_supportbutton_controller.dart';
import '../component/w_backtoregister_button.dart';
import '../component/w_machine_item.dart';
import '../component/w_payment_method_item.dart';
import '../controller/c_machine_controller.dart';
import '../controller/c_payment_controller.dart';
import '../controller/c_subtotal_controller.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../enum/e_presetcd.dart';
import '../component/w_promotion_item.dart';
import '../controller/c_subtotalsupport_controller.dart';
import 'p_discount_select_page.dart';

/// 小計画面右側セクションウィジェット
class RightSection extends StatelessWidget {
  /// コントローラー
  final paymentCtrl = Get.put(PaymentController());
  final machineCtrl = Get.put(MachineController());
  final supportCtrl = Get.put(SubtotalSupportController());
  final commonCtrl = Get.find<CommonController>();
  final subtotalCtrl = Get.find<SubtotalController>();
  final RegisterBodyController bodyctrl = Get.find();

  // ボタンで共通のBoxDecoration定義
  final boxDecoration = BoxDecoration(
    color: BaseColor.newMainColor,
    borderRadius: BorderRadius.circular(4),
    border: Border.all(color: BaseColor.edgeBtnColor, width: 1.0.w),
    boxShadow: [
      BoxShadow(
        color: BaseColor.dropShadowColor.withOpacity(0.35),
        spreadRadius: 0,
        blurRadius: 3,
        offset: const Offset(0, 3),
      ),
    ],
  );

  ///コンストラクタ
  RightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (paymentCtrl.isPaymentSuccess.value ||
          paymentCtrl.isSentToMachineSuccess.value) {
        return _buildPaymentSuccessScreen();
      } else {
        return _buildRightContent(context);
      }
    });
  }

  ///お会計が完了の画面,領収書発行、レシート再発行ボタン含め
  Widget _buildPaymentSuccessScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      CommonController commonCtrl = Get.find();
      if (await DualCashierUtil.check2Person() &&
          await DualCashierUtil.isDualCashier(commonCtrl.isDualMode.value)) {
        var fileNum = await RsMain.getSpoolCount();
        if (fileNum == 0) {
          commonCtrl.dualModeDataReceived.value = false;
        } else {
          commonCtrl.dualModeDataReceived.value = true;
        }
      }
    });
    return Flex(
      direction: Axis.vertical, 
      children: [
        //精算機に送信しない場合は再発行、領収書アイテムをを表示する
        if (!paymentCtrl.isSentToMachineSuccess.value)
          Padding(
            padding: EdgeInsets.only(right: 12.w, top: 12.w),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              PromotionItem(
                // todo 表示文字列はDBから取得するように修正要
                title: '領収書発行',
                width: 180.w,
                height: 56.h,
                decoration: boxDecoration,
                onPressed: () async {
                  // 2人制時は動作しない
                  if (commonCtrl.rcKySelf.value == RcRegs.KY_DUALCSHR) {
                    return;
                  }
                  // タイマーが動いていたら止める
                  Get.find<PaymentController>().cancelTimer();

                  // TODO:10138 再発行、領収書対応 暫定処理
                  await RcExt.rcKyRfm();
                },
              ),
              SizedBox(width: 4.w),
              PromotionItem(
                // todo 表示文字列はDBから取得するように修正要
                title: 'レシート再発行',
                width: 180.w,
                height: 56.h,
                decoration: boxDecoration,
                onPressed: () async {
                  // 2人制時は動作しない
                  if (commonCtrl.rcKySelf.value == RcRegs.KY_DUALCSHR) {
                    return;
                  }
                  // タイマーが動いていたら止める
                  Get.find<PaymentController>().cancelTimer();

                  // TODO:10138 再発行、領収書対応 暫定処理
                  await RckyRpr.rcKyRpr();
                },
              ),
            ]),
          ),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Container(
                  width: 536.w,
                  color: BaseColor.someTextPopupArea,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 134.h),
                      SvgPicture.asset(
                        'assets/images/icon_done.svg',
                        width: 111.w,
                        height: 111.h,
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      Text(
                        paymentCtrl.isSentToMachineSuccess.value
                            ? '${paymentCtrl.machineName.value}に送信しました'
                            : 'お会計が完了しました',
                        style: const TextStyle(
                          fontFamily: BaseFont.familyDefault,
                          fontSize: BaseFont.font22px,
                          color: BaseColor.accentsColor,
                        ),
                      ),
                      SizedBox(
                        height: 65.h,
                      ),
                      Obx(() => commonCtrl.rcKySelf.value == RcRegs.KY_DUALCSHR &&
                              !commonCtrl.dualModeDataReceived.value
                          ? Container(
                              width: 450.w,
                              height: 100.h,
                              color: BaseColor.newMainColor.withOpacity(0.9),
                              child: const Center(
                                child: Text(
                                  'チェッカーで登録中',
                                  style: TextStyle(
                                    fontFamily: BaseFont.familyDefault,
                                    fontSize: BaseFont.font44px,
                                    color: BaseColor.accentsColor,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink()),
                    ],
                  ),
                ),
              ),
              Obx(() => commonCtrl.rcKySelf.value != RcRegs.KY_DUALCSHR
                  ? Positioned(
                      right: 0,
                      bottom: 8.h,
                      child: BackRegisterButton(
                        text: '商品一覧へ\nもどる',
                        icon: Icons.arrow_forward,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(5)),
                        onTap: () async {
                          // タイマーが動いていたら止める
                          Get.find<PaymentController>().cancelTimer();

                          Get.back();
                        },
                      ),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ]);
  }

  ///右側セクション
  Widget _buildRightContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _buildPromotionSection(),
            _buildPaymentMethodsSection(context),
            SizedBox(height: 12.h),
            //todo: 削除予定 MachineSection(),
            //通常レジでは精算機表示しない
            Obx(() {
              return bodyctrl.isQcashierVisible.value
                  ? MachineSection()
                  : SizedBox.shrink();
            }),
            _buildSubtotalSupport(),
          ],
        ),
      ],
    );
  }

  /// 小計割引一覧
  Widget _buildPromotionSection() {
    return Padding(
            padding: EdgeInsets.only(right: 12.w, top: 12.w),
            child: Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 0),
              child: Obx(() => subtotalCtrl.dspStlButton.value
        ? PromotionItem(
                // todo 表示文字列はDBから取得するように修正要
                title: '小計値引/割引',
                width: 180.w,
                height: 56.h,
                decoration: boxDecoration,
                onPressed: () {
                  // todo titleを渡す処理
                  int errId = RckyDsc.chkAddStlDsc();
                  if (errId != 0) {
                    // 値下げできない場合.
                    MsgDialog.show(
                      MsgDialog.singleButtonDlgId(
                        type: MsgDialogType.error,
                        dialogId: errId,
                      ),
                    );
                    return;
                  }
                  Get.to(() => DiscountSelectPage(
                        title: '小計値引/割引',
                          ));
                    },
                  )
                : SizedBox(
                    width: 180.w,
                    height: 56.h,
                  ),
          ),
        )
        );
  }

  /// 支払方法選択欄
  Widget _buildPaymentMethodsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w),
      child: Container(
        width: 536.w,
        height: bodyctrl.isQcashierVisible.value ? 336.h : 560.h,
        color: BaseColor.someTextPopupArea,
        child: Obx(
          () => Column(
            children: [
              Container(
                width: double.infinity,
                height: 32.h,
                color: BaseColor.baseColor,
                child: Center(
                  child: Text(
                    paymentCtrl.paymentMethodTitle.value,
                    style: const TextStyle(
                      fontSize: BaseFont.font16px,
                      color: BaseColor.someTextPopupArea,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.h, left: 28.w, right: 28.w),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: paymentCtrl.paymentMethods.length,
                    itemBuilder: (context, index) {
                      var method = paymentCtrl.paymentMethods[index];
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: PaymentMethodItem(
                          presetData: method,
                          iconPath: paymentCtrl.icons[method.imgName] ?? '',
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 小計サポート欄
  Widget _buildSubtotalSupport() {
    return Container(
      width: 536.w,
      height: 62.h,
      color: BaseColor.someTextPopupArea,
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.only(left: 8.w, top: 8.w, right: 8.w),
      child: Obx(
        () => Wrap(
          spacing: 8.w,
          children: supportCtrl.supportButtons
              .map((button) =>
                  _buildSupportButton(button))
              .toList(),
        ),
      ),
    );
  }

  /// 小計サポートボタン
  Widget _buildSupportButton(PresetInfo presetInfo) {
    /// ボタンカラー
    final buttonColor = PresetCd.getBtnColor(presetInfo.presetColor);

    ///ボタン枠線色
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
            ),
          ),
        ],
      ),
    );
  }
}
