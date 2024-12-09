/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../common/number_util.dart';
import '../../../inc/apl/fnc_code.dart';
import '../../../regs/checker/rckycpick.dart';
import '../../../regs/inc/rc_mem.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_inputbox.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import '../subtotal/component/w_register_tenkey.dart';
import 'controller/c_charge_collect_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_pos/app/ui/page/common/component/w_dicisionbutton.dart';

/// 動作概要
/// つり機回収のページ
class ChargeCollectScreen extends CommonBasePage {
  final FuncKey funcKey;
  ChargeCollectScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
    required this.funcKey,
  }) : super(buildActionsCallback: (context) {
    String className = 'ChargeCollectScreen';
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
    return ChargeCollectWidget(
      title: super.title,
      backgroundColor: backgroundColor,
      funcKey: funcKey,
    );
  }
}

/// つり機回収のウィジェット
class ChargeCollectWidget extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final FuncKey funcKey;
  const ChargeCollectWidget({super.key, required this.title, required this.backgroundColor, required this.funcKey});

  @override
  ChargeCollectState createState() => ChargeCollectState();
}

/// つり機回収の状態管理
class ChargeCollectState extends State<ChargeCollectWidget> {
  @override
  void initState() {
    super.initState();
      AcMem cMem = SystemFunc.readAcMem();
      cMem.stat.fncCode = widget.funcKey.keyId;
  }

  /// 共通のスタイル
  final EdgeInsetsGeometry padding = const EdgeInsets.all(8);
  final horizontalSpace = const SizedBox(width: 8);
  final verticalSpace = const SizedBox(height: 8);
  final verticalSpaceHalf = const SizedBox(height: 4);

  /// コントローラ
  ChargeCollectController controller = Get.put(ChargeCollectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          height: 32.h,
          child: Center(
            child: Obx(() => Text(
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font18px,
                fontFamily: BaseFont.familyDefault,
              ),
              controller.progress.value.value,
            )),
          ),
        ),
      ),
      body: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column( // 画面左部
              children: [
                Row( // 回収金額、カセット内金額
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row( // 回収金額
                      children: [
                        SizedBox(
                          width: 120.w,
                          height: 40.h,
                          child: Container(
                            color: BaseColor.changeCoinReferTitleColor,
                            child: const Center(
                              child: Text(
                                '回収金額',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: BaseColor.someTextPopupArea,
                                  fontSize: BaseFont.font18px,
                                  fontFamily: BaseFont.familyDefault,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200.w,
                          height: 40.h,
                          child: Container(
                            color: BaseColor.baseColor,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Obx(() => Text(
                                  NumberFormatUtil.formatAmount(controller.collectPrice.value),
                                  style: const TextStyle(
                                    fontSize: BaseFont.font28px,
                                    color: BaseColor.someTextPopupArea,
                                    fontFamily: BaseFont.familyNumber,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    horizontalSpace,
                    Row( // カセット内金額
                      children: [
                        SizedBox(
                          width: 120.w,
                          height: 40.h,
                          child: Container(
                            color: BaseColor.changeCoinReferTitleColor,
                            child: const Center(
                              child: Text(
                                'カセット内\n金額',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: BaseColor.someTextPopupArea,
                                  fontSize: BaseFont.font18px,
                                  fontFamily: BaseFont.familyDefault,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200.w,
                          height: 40.h,
                          child: Container(
                            color: BaseColor.baseColor,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Obx(() => Text(
                                  NumberFormatUtil.formatAmount(controller.cassettePrice.value),
                                  style: const TextStyle(
                                    fontSize: BaseFont.font28px,
                                    color: BaseColor.someTextPopupArea,
                                    fontFamily: BaseFont.familyNumber,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Obx(() => Column( // 紙幣、貨幣毎の回収内容
                  children: [
                    for (int index = 0; index < controller.collects.length; index++)... {
                      verticalSpaceHalf,
                      (() {
                        if (index != 0) {
                          return  _collectArea(
                            index: index,
                            collect: controller.collects[index],
                          );
                        }

                        return Column(
                          children: [
                            Container(
                              width: 648.w,
                              color: Colors.white,
                              padding: padding,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded( // 回収前
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        const Text(
                                          '回収前',
                                          style: TextStyle(
                                            fontSize: BaseFont.font14px,
                                            fontFamily: BaseFont.familyDefault,
                                            color: BaseColor.baseColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  horizontalSpace,
                                  Expanded( // 回収後
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                '回収枚数',
                                                style: TextStyle(
                                                  fontSize: BaseFont.font14px,
                                                  fontFamily: BaseFont.familyDefault,
                                                  color: BaseColor.baseColor,
                                                ),
                                              ),
                                              Container(),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '回収後',
                                                style: TextStyle(
                                                  fontSize: BaseFont.font14px,
                                                  fontFamily: BaseFont.familyDefault,
                                                  color: BaseColor.baseColor,
                                                ),
                                              ),
                                            ]
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _collectArea(
                              index: index,
                              collect: controller.collects[index],
                            )
                          ],
                        );
                      })(),
                    },
                  ],
                )),
              ],
            ),
            Column( // 画面右部
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column( // 回収方法選択ボタン、テンキー
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 280.w,
                      height: 40.h,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '回収方法',
                          style: TextStyle(
                            fontSize: BaseFont.font18px,
                            fontFamily: BaseFont.familyDefault,
                          ),
                        ),
                      ),
                    ),
                    Row( // すべて/残置
                      children: [
                        Obx(() => Row( // すべて
                          children: [
                            SizedBox(
                              width: 136.w,
                              height: 56.h,
                              child: SoundElevatedButton(
                                onPressed: () async => (controller.progress.value == CollectProgress.doing) ? await controller.onSelectCollectType(CollectType.all, widget.title) : null,
                                callFunc: CollectType.all.value,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (controller.selectedCollectType.value == CollectType.all) ? BaseColor.receiptButtonColor : BaseColor.scanButtonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: (controller.progress.value == CollectProgress.doing) ? 3 : 0,
                                  splashFactory: (controller.progress.value == CollectProgress.doing) ? InkRipple.splashFactory : NoSplash.splashFactory,
                                  foregroundColor: (controller.progress.value == CollectProgress.doing) ? BaseColor.backColor : BaseColor.scanButtonColor,
                                  shadowColor: BaseColor.scanBtnShadowColor,
                                  padding: const EdgeInsets.all(24.0),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        CollectType.all.value,
                                        style: TextStyle(
                                          fontSize: BaseFont.font22px,
                                          color: (controller.selectedCollectType.value == CollectType.all) ? BaseColor.backColor : BaseColor.someTextPopupArea,
                                          fontFamily: BaseFont.familyDefault,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        )),
                        horizontalSpace,
                        Obx(() => Row( // 残置
                          children: [
                            SizedBox(
                              width: 136.w,
                              height: 56.h,
                              child: SoundElevatedButton(
                                onPressed: () async => (controller.progress.value == CollectProgress.doing) ? await controller.onSelectCollectType(CollectType.remaining, widget.title) : null,
                                callFunc: CollectType.remaining.value,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:  (controller.selectedCollectType.value == CollectType.remaining) ? BaseColor.receiptButtonColor : BaseColor.scanButtonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: (controller.progress.value == CollectProgress.doing) ? 3 : 0,
                                  splashFactory: (controller.progress.value == CollectProgress.doing) ? InkRipple.splashFactory : NoSplash.splashFactory,
                                  foregroundColor: (controller.progress.value == CollectProgress.doing) ? BaseColor.backColor : BaseColor.scanButtonColor,
                                  shadowColor: BaseColor.scanBtnShadowColor,
                                  padding: const EdgeInsets.all(24.0),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        CollectType.remaining.value,
                                        style: TextStyle(
                                          fontSize: BaseFont.font22px,
                                          color: (controller.selectedCollectType.value == CollectType.remaining) ? BaseColor.backColor : BaseColor.someTextPopupArea,
                                          fontFamily: BaseFont.familyDefault,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    verticalSpaceHalf,
                    Obx(() => (() { // その他
                      if (controller.selectedCollectType.value.isOtherValues()) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 280.w,
                              height: 56.h,
                              child: SoundElevatedButton(
                                onPressed: () async => (controller.progress.value == CollectProgress.doing) ? await controller.onSelectCollectType(CollectType.others, widget.title) : null,
                                callFunc: CollectType.others.value,
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: BaseColor.scanButtonColor,
                                    width: 2,
                                  ),
                                  padding: EdgeInsets.zero,
                                  elevation: (controller.progress.value == CollectProgress.doing) ? 3 : 0,
                                  splashFactory: (controller.progress.value == CollectProgress.doing) ? InkRipple.splashFactory : NoSplash.splashFactory,
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [widget.backgroundColor, BaseColor.scanButtonColor],
                                      stops: const [0.85, 0.15],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Center(
                                          child: Text(
                                            style: const TextStyle(
                                              fontSize: BaseFont.font22px,
                                              color: BaseColor.scanButtonColor,
                                              fontFamily: BaseFont.familyDefault,
                                            ),
                                            '${CollectType.others.value}: ${controller.selectedCollectType.value.value}',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40.w,
                                          height: 56.h,
                                          child: SvgPicture.asset(
                                            'assets/images/icon_open_2.svg',
                                            width: 30.w,
                                            height: 30.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          SizedBox(
                            width: 280.w,
                            height: 56.h,
                            child: SoundElevatedButton(
                              onPressed: () async => (controller.progress.value == CollectProgress.doing) ? await controller.onSelectCollectType(CollectType.others, widget.title) : null,
                              callFunc: CollectType.others.value,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BaseColor.scanButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: (controller.progress.value == CollectProgress.doing) ? 3 : 0,
                                splashFactory: (controller.progress.value == CollectProgress.doing) ? InkRipple.splashFactory : NoSplash.splashFactory,
                                foregroundColor: (controller.progress.value == CollectProgress.doing) ? BaseColor.backColor : BaseColor.scanButtonColor,
                                shadowColor: BaseColor.scanBtnShadowColor,
                                padding: const EdgeInsets.all(24.0),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text(
                                      style: const TextStyle(
                                        fontSize: BaseFont.font22px,
                                        color: BaseColor.someTextPopupArea,
                                        fontFamily: BaseFont.familyDefault,
                                      ),
                                      CollectType.others.value,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/icon_open_2.svg',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ],
                      );
                    })()),
                    verticalSpaceHalf,
                    Obx(() => (() { // テンキー
                      if (controller.progress.value == CollectProgress.doing) {
                        return RegisterTenkey(
                          onKeyTap: (key) => controller.onTapTenKey(key),
                        );
                      }

                      return Container();
                    })()),
                  ],
                ),
                Obx(() => (() { // 確定ボタン
                  if (controller.progress.value == CollectProgress.doing) {
                    return DecisionButton(
                      oncallback: () async {
                            controller.isDecision = true;
                            if (controller.selectedCollectType.value == CollectType.others) {
                              await controller.onSelectCollectType(CollectType.others, widget.title);
                            }
                            await controller.onConfirm();
                            controller.isDecision == false;
                          },
                          maxWidth: 200.0.w,
                      maxHeight: 64.0.h,
                      isdecision: true,
                    );
                  }

                  return Container();
                })()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 回収枚数入力エリアのウィジェット
  Widget _collectArea({
    required int index,
    required Collect collect,
  }) {
    return Container(
      width: 648.w,
      color: Colors.white,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded( // 回収前
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        collect.bill.icon,
                        width: 32.w,
                        height: 32.h,
                      ),
                      horizontalSpace,
                      Row(
                        children: [
                          Text(
                            collect.bill.price.toString(),
                            style: const TextStyle(
                              fontSize: BaseFont.font22px,
                              fontFamily: BaseFont.familyNumber,
                            ),
                          ),
                          horizontalSpace,
                          const Text(
                            '円',
                            style: TextStyle(
                              fontSize: BaseFont.font18px,
                              fontFamily: BaseFont.familyDefault,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${collect.collectsBefore}',
                        style: const TextStyle(
                          fontSize: BaseFont.font22px,
                          fontFamily: BaseFont.familyNumber,
                        ),
                      ),
                      horizontalSpace,
                      const Text(
                        '枚',
                        style: TextStyle(
                          fontSize: BaseFont.font18px,
                          fontFamily: BaseFont.familyDefault,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          horizontalSpace,
          Expanded( // 回収後
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row( // 回収枚数
                  children: [
                    (() {
                      if (controller.progress.value == CollectProgress.doing) {
                        return InputBoxWidget(
                          key: collect.inputKey,
                          width: 120.w,
                          height: 38.h,
                          fontSize: BaseFont.font22px,
                          textAlign: TextAlign.right,
                          padding: EdgeInsets.only(right: 8.w),
                          unfocusedColor: BaseColor.someTextPopupArea,
                          cursorColor: BaseColor.baseColor,
                          unfocusedBorder: BaseColor.inputFieldColor,
                          focusedBorder: BaseColor.accentsColor,
                          focusedColor: BaseColor.inputBaseColor,
                          borderRadius: 4,
                          blurRadius: 6,
                          funcBoxTap: () => controller.onTapInputCollects(index),
                          onComplete: () {},
                          iniShowCursor: (index == 0),
                          initStr: ChargeCollectController.defaultCollects,
                          mode: InputBoxMode.defaultMode,
                        );
                      }

                      return SizedBox(
                        width: 120.w,
                        height: 38.h,
                        child:  Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${collect.collects}',
                            style: const TextStyle(
                              fontSize: BaseFont.font22px,
                              fontFamily: BaseFont.familyNumber,
                            ),
                          ),
                        ),
                      );
                    })(),
                    horizontalSpace,
                    const Text(
                      '枚',
                      style: TextStyle(
                        fontSize: BaseFont.font18px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                    horizontalSpace,
                    SvgPicture.asset(
                      'assets/images/icon_arrow.svg',
                      width: 24.w,
                      height: 24.h,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${collect.collectsAfter}',
                      style: const TextStyle(
                        fontSize: BaseFont.font22px,
                        fontFamily: BaseFont.familyNumber,
                      ),
                    ),
                    horizontalSpace,
                    const Text(
                      '枚',
                      style: TextStyle(
                        fontSize: BaseFont.font18px,
                        fontFamily: BaseFont.familyDefault,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

