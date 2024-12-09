/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_pos/app/regs/checker/rckyrmod.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/page/price_check/controller/c_price_check_controller.dart';
import 'package:flutter_pos/app/ui/page/subtotal/basepage/p_loginaccount_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/environment.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../lib/apllib/apllib_staffpw.dart';
import '../../../../regs/checker/rckymenu.dart';
import '../../../../regs/inc/rc_mem.dart';
import '../../../../regs/inc/rc_regs.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../enum/e_screen_kind.dart';
import '../../../menu/register/enum/e_register_page.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/controller/c_payment_controller.dart';
import '../controller/c_registerbody_controller.dart';
import '../controller/c_registerheader_controller.dart';

/// ヘッダー呼び出し
class RegisterHeader extends StatelessWidget {
  /// コンストラクタ
  RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ///　コントローラー
    RegisterHeadController ctrl = Get.find();
    return Container(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            // メインメニュー
            Container(
              child: RegisterHeaderContainer(
                width: 192.w,
                height: 40.h,
                widget: MainMenu(
                  text: _getOpeModeTitle(),
                ),
                //color: Colors.indigo,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            // ファンクションボタン
            Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: BaseColor.dropShadowColor,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: RegisterHeaderContainer(
                  width: 88.w,
                  height: 48.h,
                  leftradius: true,
                  rightradius: true,
                  widget: const MenuFunctionWidget(),
                ),
              ),
            ),
            SizedBox(
              width: 4.w,
            ),

            Container(
              width: 436.w,
              height: 48.h,
              decoration: const BoxDecoration(
                  color: BaseColor.someTextPopupArea,
                  boxShadow: [
                    BoxShadow(
                      color: BaseColor.dropShadowColor,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 15.w),
                  //インターネット
                  Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: const OnlineWidget(),
                  ),
                  SizedBox(width: 24.w),

                  // メッセージ
                  Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      child: RegisterHeaderContainer(
                        width: 50.w,
                        height: 50.h,
                        leftradius: true,
                        rightradius: true,
                        widget: const MessageWidget(),
                      ),
                    ),
                  ),

                  SizedBox(width: 24.w),
                  //アラーム鈴アイコン配置
                  Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                        child: RegisterHeaderContainer(
                      width: 48.w,
                      height: 48.h,
                      widget: const AlarmWidget(),
                    )),
                  ),
                  SizedBox(width: 24.w),
                  //担当
                  Container(
                      child: RegisterHeaderContainer(
                    width: 60.w,
                    height: 60.h,
                    widget: const PersonWidget(),
                  )),
                  SizedBox(width: 18.w),

                  // 日時
                  Container(
                    child: RegisterHeaderContainer(
                      width: 120.w,
                      height: 50.h,
                      widget: Container(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                    () => Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    ctrl.now_date.value,
                                    style: const TextStyle(
                                        fontSize: BaseFont.font16px,
                                        color: BaseColor.baseColor,
                                        fontFamily: BaseFont.familyDefault),
                                  ),
                                ),
                              ),
                              Obx(() => Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  ctrl.now_time.value,
                                  style: const TextStyle(
                                      fontSize: BaseFont.font16px,
                                      color: BaseColor.baseColor,
                                      fontFamily: BaseFont.familyDefault),
                                ),
                              )),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            // お気に入り
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: BaseColor.dropShadowColor,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: RegisterHeaderContainer(
                width: 88.w,
                height: 48.h,
                leftradius: true,
                rightradius: true,
                widget: const FavoriteWidget(),
              ),
            ),
          ],
        ));
  }

  /// オペレーションモードの表示文言.
  String _getOpeModeTitle() {
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.opeMode) {
      case RcRegs.RG:
        return '登録/会計';
      case RcRegs.TR:
        return '訓練';
      default:
        return '登録/会計';
    }
  }
}

/// ヘッダー部の各部品の枠
class RegisterHeaderContainer extends StatelessWidget {
  ///コンストラクタ
  const RegisterHeaderContainer({
    super.key,
    required this.width,
    required this.height,
    required this.widget,
    this.rightradius = false,
    this.leftradius = false,
    this.color = BaseColor.someTextPopupArea,
    this.borderwidth = 1,
  });

  ///横幅
  final double width;

  ///高さ
  final double height;

  ///色
  final Color color;

  ///ウィジェット
  final Widget widget;

  ///右角丸
  final bool rightradius;

  ///左角丸
  final bool leftradius;

  ///枠線幅
  final double borderwidth;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.button,
        color: color,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(leftradius ? 10 : 0),
            bottomRight: Radius.circular(rightradius ? 10 : 0)),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(leftradius ? 10 : 0),
              bottomRight: Radius.circular(rightradius ? 10 : 0),
            ),
          ),
          child: widget,
        ));
  }
}

/// メインメニュー
class MainMenu extends StatelessWidget {
  ///コンストラクタ
  const MainMenu({
    super.key,
    required this.text,
  });

  ///タイトルテキスト
  final String text;

  @override
  Widget build(BuildContext context) {
    final RegisterBodyController regBodyCtrl = Get.find();
    return Stack(children: [
        Obx(() => Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
          decoration: regBodyCtrl.refundFlag.value
              ? _buildRefundModeDecoration()
              : _buildNormalDecoration(),
          child: Obx(() {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: regBodyCtrl.refundFlag.value
                      ? SvgPicture.asset(
                        'assets/images/icon_main_returned.svg',
                        width: 72,
                        height: 72,
                      ) : const SizedBox.shrink(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    regBodyCtrl.refundFlag.value ? '返品' : text,
                    style: const TextStyle(
                        fontSize: BaseFont.font18px,
                        color: BaseColor.someTextPopupArea,
                        fontFamily: BaseFont.familyDefault),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }),
        ),
        ),

      ///登録画面から　登録/会計ボタンを押してメインメニューへ戻ったら　従業員クローズをする
      Positioned.fill(
        child: Material(
          color: BaseColor.transparent,
          child: SoundInkWell(
            onTap: () async {
              String currentRoute = Get.currentRoute;
              int errNo = 0;
              if (currentRoute == RegisterPage.register.routeName ||
                  currentRoute == RegisterPage.tranining.routeName) {
                /// 価格確認モードの場合はエラー
                if (regBodyCtrl.prcChkMode.value) {
                  PriceCheckController priceCheckCtrl = Get.find();
                  priceCheckCtrl.showOperationErrorDialog();
                  return;
                }

                // 別タブに取引データがあるか
                if (regBodyCtrl.transactionManagement.count > 1) {
                  errNo = DlgConfirmMsgKind.MSG_REGERROR_EXPLAIN.dlgId;
                } else {
                  errNo = await RckyMenu.rcCheckKyMenu(1);
                }

                if (errNo != 0) {
                  MsgDialog.show(
                    MsgDialog.singleButtonDlgId(
                      type: MsgDialogType.error,
                      dialogId: errNo,
                    )
                  );
                } else {
                  if (regBodyCtrl.refundFlag.value) {
                    // 返品モードのクリア
                    regBodyCtrl.clearRefundflag();
                  }

                  if (await DualCashierUtil.check2Person() && await DualCashierUtil.is2Person()) {
                    await DualCashierUtil.key2Person(isAuto: true);
                    return;
                  }
                  else {
                    await AplLibStaffPw.callCloseStaffAPI(
                        checkerFlag: EnvironmentData().screenKind == ScreenKind.register2 ? 1 : 0);
                  }

                  Get.until(ModalRoute.withName(RegisterPage.mainMenu.routeName));
                }
              } else {
                // タイマーが動いていたら止める
                Get.find<PaymentController>().cancelTimer();
                
                // スプリット支払い時は登録画面に画面遷移させない。
                errNo = await RcKyRmod.rcKyRmod();
                if (errNo != 0) {
                  // rcKyRmod()でrcErrをCALLしてるのでここでは何もしない
                }else{
                  if (await DualCashierUtil.is2Person() && await DualCashierUtil.check2Person()) {
                    DualCashierUtil.key2Person(isAuto: true);
                    return;
                  }
                  Get.back();
                }
              }
            },
            child: null,
            callFunc: '${runtimeType.toString()} text $text',
          ),
        ),
      )
    ]);
  }

  BoxDecoration _buildRefundModeDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          BaseColor.confirmBtnFrom,
          BaseColor.confirmBtnTo,
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: BaseColor.dropShadowColor,
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(3, 3),
        ),
      ],
    );
  }

  BoxDecoration _buildNormalDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(2),
        topLeft: Radius.circular(2),
      ),
      color: BaseColor.accentsColor,
    );
  }

  /// 価格確認モードの場合は価格確認モードを終了する
  void _endPriceCheckMode() {
    try {
      RegisterBodyController bodyCtrl = Get.find();
      if (bodyCtrl.prcChkMode.value) {
        PriceCheckController priceCheckCtrl = Get.find();
        priceCheckCtrl.endPrcChkStatus();
      }
    }
    catch(_) {}
  }
}

/// オンライン処理切替
class OnlineWidget extends StatelessWidget {
  ///コンストラクタ
  const OnlineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ///コントローラー
    RegisterHeadController ctrl = Get.find();

    return Obx(() => Icon(
      ctrl.isTsServerOnline.value ? Icons.wifi : Icons.wifi_off,
      color: ctrl.isTsServerOnline.value ? BaseColor.iconNormalColor : BaseColor.iconEmphasizeColor,
    ));
  }
}

/// メッセージ確認画面表示
class MessageWidget extends StatelessWidget {
  ///コンストラクタ
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ///コントローラー
    RegisterHeadController ctrl = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SoundInkWell(
          onTap: () => ctrl.showMessage(),
          callFunc: runtimeType.toString(),
          child: Column(
            children: [
              const Icon(
                Icons.chat,
                color: BaseColor.loginTabTextColor,
              ),
              Text(
                '未読${ctrl.numberOfMsg.value}',
                style: const TextStyle(
                    fontSize: BaseFont.font14px,
                    color: BaseColor.attentionColor,
                    fontFamily: BaseFont.familyDefault),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// アラーム確認画面表示
class AlarmWidget extends StatelessWidget {
  ///コンストラクタ
  const AlarmWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ///コントローラー
    RegisterHeadController ctrl = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SoundInkWell(
          onTap: () => ctrl.showMessage(),
          callFunc: runtimeType.toString(),
          child: Column(
            children: [
              const Icon(
                Icons.notifications,
                color: BaseColor.loginTabTextColor,
              ),
              Text(
                '未読${ctrl.numberOfMsg.value}',
                style: const TextStyle(
                    fontSize: BaseFont.font14px,
                    color: BaseColor.attentionColor,
                    fontFamily: BaseFont.familyDefault),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// アラーム確認画面表示
class PersonWidget extends StatelessWidget {
  ///コンストラクタ
  const PersonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SoundInkWell(
          //onTap: () => ctrl.showMessage(),
          onTap: () {},
          callFunc: runtimeType.toString(),
          child: const Column(
            children: [
              Icon(
                Icons.person,
                color: BaseColor.baseColor,
              ),
              Text(
                '寺岡花子',
                style: TextStyle(
                    fontSize: BaseFont.font14px,
                    color: BaseColor.loginTabTextColor,
                    fontFamily: BaseFont.familyDefault),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// お気に入り？
class FavoriteWidget extends StatelessWidget {
  ///コンストラクタ
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SoundInkWell(
      onTap: () {
        // 小計画面の場合
        if (Get.currentRoute == '/subtotal') {
          // タイマーが動いていたら止める
          try {
            Get.find<PaymentController>().cancelTimer();
          } catch(_) {}
        }

        Get.to(() => LoginAccountPage(
              title: '業務',
            ));
      },
      callFunc: '${runtimeType.toString()} 業務',
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.star,
            color: BaseColor.loginTabTextColor,
          ),
          Text(
            '業務',
            style: TextStyle(
                fontSize: BaseFont.font14px,
                color: BaseColor.baseColor,
                fontFamily: BaseFont.familyDefault),
          ),
        ],
      ),
    );
  }
}

/// ファンクションボタン
class MenuFunctionWidget extends StatelessWidget {
  ///コンストラクタ
  const MenuFunctionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SoundIconButton(
      ///戻るボタンがないため、仮の戻るボタン
      onPressed: () {
        // 小計画面の場合
        if (Get.currentRoute == '/subtotal') {
          // タイマーが動いていたら止める
          Get.find<PaymentController>().cancelTimer();
        }

        Get.to(() => LoginAccountPage(
              title: '業務',
            ));
      },
      callFunc: '${runtimeType.toString()} 業務',
      // ctrl.callFavorite(),
      icon: const Icon(
        Icons.menu,
        color: BaseColor.loginTabTextColor,
      ),
      iconSize: 20,
    );
  }
}
