/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../common/basepage/common_base.dart';
import 'controller/c_change_coin_connection_controller.dart';

/// 釣機ON/OFFタイプ
enum ChangeType {
  // 両機OFF
  none,

  // 釣銭OFF
  coinOff,

  // 釣札OFF
  billOff,

  // 両機ON
  all
}

/// 釣機ON/OFFの許可
enum ChangePermission {
  // 釣機ON/OFF不可能
  changeUnable,

  // 釣機ON/OFF可能
  changeAble
}

/// 釣銭機、釣札機のON/OFF状態
enum ChangeOnOff {
  /// off状態
  off,

  /// on状態
  on
}

/// 釣機の設定可否状態
/// 0:釣銭機のみONOFF可、1:釣札機のみONOFF可、2:両機ONOFF可
enum ChangeStatusType { coin, bill, all }

/// つり機接続のページ
class ChangeCoinConnectionPage extends CommonBasePage {
  ChangeCoinConnectionPage({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.changeConnectBackColor,
  }) : super(buildActionsCallback: (context) {
          String className = 'ChangeCoinConnectionPage';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                isProcessing = false;
                Get.back();
              },
              callFunc: '$className とじる',
              child: Row(
                children: <Widget>[
                  const Icon(Icons.close,
                      color: BaseColor.someTextPopupArea, size: 40),
                  SizedBox(
                    width: 19.w,
                  ),
                  const Text('とじる',
                      style: TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px,
                          fontFamily: BaseFont.familyDefault)),
                ],
              ),
            ),
          ];
        });

  /// 釣機ON/OFFキー動作中またはつり機接続画面表示中
  static bool isProcessing = false;

  @override
  Widget buildBody(BuildContext context) {
    return ChangeCoinConnectionWidget(backgroundColor: backgroundColor);
  }
}

class ChangeCoinConnectionWidget extends StatefulWidget {
  final Color backgroundColor;

  const ChangeCoinConnectionWidget({super.key, required this.backgroundColor});

  @override
  ChangeCoinConnectionState createState() => ChangeCoinConnectionState();
}

class ChangeCoinConnectionState extends State<ChangeCoinConnectionWidget> {
  final changeCoinConnectionCtrl = Get.put(ChangeCoinConnectionController());
  late String msg = 'つり銭機、つり札機の接続のON/OFFを切り替えます'; // メッセージ内容

  /// 不透明度0.4
  static const double opacityVal = 0.4;

  /// 状態変更設定
  /// 0:釣銭機のみONOFF可、1:釣札機のみONOFF可、2:両機ONOFF可
  ChangeStatusType statusType = ChangeStatusType.all;

  @override
  void initState() {
    super.initState();
  }

  /// 処理概要：選択済みキーフレーム作成処理
  /// パラメータ：キー番号
  /// 戻り値：ファンクションキーフレーム
  BoxDecoration _getAnimatedOpacitydecoration(change, changeBill) {
    // changeBill=true:釣札機、changeBill=false:釣銭機
    if (changeBill) {
      if (statusType == ChangeStatusType.coin) {
        return BoxDecoration(
          border: Border.all(
            color: BaseColor.transparentColor,
          ),
        );
      } else {
        if (change) {
          return BoxDecoration(
            color: BaseColor.accentsColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: BaseColor.someTextPopupArea,
            ),
          );
        }
        return BoxDecoration(
          border: Border.all(
            color: BaseColor.transparentColor,
          ),
        );
      }
    } else {
      if (statusType == ChangeStatusType.bill) {
        return BoxDecoration(
          border: Border.all(
            color: BaseColor.transparentColor,
          ),
        );
      } else {
        if (change) {
          return BoxDecoration(
            color: BaseColor.accentsColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: BaseColor.someTextPopupArea,
            ),
          );
        }
        return BoxDecoration(
          border: Border.all(
            color: BaseColor.transparentColor,
          ),
        );
      }
    }
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
          Positioned(
            left: 220,
            top: 100,
            right: 184,
            bottom: 216,
            child: Container(
              width: 620,
              height: 280,
              color: BaseColor.someTextPopupArea,
            ),
          ),
          Positioned(
              left: 220,
              top: 171,
              right: 184,
              child: Row(
                children: [
                  Obx(
                    () => SizedBox(
                      height: 280,
                      width: 300,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/icon_bill_large.svg',
                            width: 70,
                            height: 50,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "つり札機",
                            style: TextStyle(
                              fontSize: BaseFont.font18px,
                              color: BaseColor.changeCoinIconFontColor,
                              fontFamily: BaseFont.familySub,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: 200.w,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: BaseColor.accentsColor
                                  .withOpacity(opacityVal),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(children: [
                              Positioned(
                                left: 4,
                                top: 4,
                                bottom: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    if (statusType == ChangeStatusType.bill ||
                                        statusType == ChangeStatusType.all) {
                                      if (changeCoinConnectionCtrl
                                                  .statusType.value ==
                                              ChangeType.none ||
                                          changeCoinConnectionCtrl
                                                  .statusType.value ==
                                              ChangeType.billOff) {
                                        changeCoinConnectionCtrl
                                            .pushChangeButton(
                                                changeCoinConnectionCtrl
                                                    .changeBillOn.value,
                                                true,
                                                0);
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 96.w,
                                    height: 48.h,
                                    alignment: Alignment.center,
                                    decoration: _getAnimatedOpacitydecoration(
                                        changeCoinConnectionCtrl
                                            .changeBillOn.value,
                                        true),
                                    child: Text(
                                      'ON',
                                      style: TextStyle(
                                        color: BaseColor.someTextPopupArea,
                                        fontSize: BaseFont.font18px,
                                        fontFamily: (changeCoinConnectionCtrl
                                                .changeBillOn.value)
                                            ? BaseFont.familySub
                                            : BaseFont.familyDefault,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 4,
                                top: 4,
                                bottom: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    if (statusType == ChangeStatusType.bill ||
                                        statusType == ChangeStatusType.all) {
                                      if (changeCoinConnectionCtrl
                                                  .statusType.value ==
                                              ChangeType.all ||
                                          changeCoinConnectionCtrl
                                                  .statusType.value ==
                                              ChangeType.coinOff) {
                                        changeCoinConnectionCtrl
                                            .pushChangeButton(
                                                changeCoinConnectionCtrl
                                                    .changeBillOff.value,
                                                false,
                                                0);
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 96.w,
                                    height: 48.h,
                                    alignment: Alignment.center,
                                    decoration: _getAnimatedOpacitydecoration(
                                        changeCoinConnectionCtrl
                                            .changeBillOff.value,
                                        true),
                                    child: Text(
                                      'OFF',
                                      style: TextStyle(
                                        color: BaseColor.someTextPopupArea,
                                        fontSize: BaseFont.font18px,
                                        fontFamily: (changeCoinConnectionCtrl
                                                .changeBillOff.value)
                                            ? BaseFont.familySub
                                            : BaseFont.familyDefault,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            changeCoinConnectionCtrl.changeBillMessage.value,
                            style: const TextStyle(
                              fontSize: BaseFont.font14px,
                              color: BaseColor.accentsColor,
                              fontFamily: BaseFont.familyDefault,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: 280,
                      width: 300,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/icon_coin_large.svg',
                            width: 70,
                            height: 50,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "つり銭機",
                            style: TextStyle(
                              fontSize: BaseFont.font18px,
                              color: BaseColor.changeCoinIconFontColor,
                              fontFamily: BaseFont.familySub,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: 200.w,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: BaseColor.accentsColor
                                  .withOpacity(opacityVal),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(children: [
                              Positioned(
                                left: 4,
                                top: 4,
                                bottom: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    if (statusType == ChangeStatusType.coin ||
                                        statusType == ChangeStatusType.all) {
                                      if (changeCoinConnectionCtrl
                                                  .statusType.value ==
                                              ChangeType.none ||
                                          changeCoinConnectionCtrl
                                                  .statusType.value ==
                                              ChangeType.coinOff) {
                                        changeCoinConnectionCtrl
                                            .pushChangeButton(
                                                changeCoinConnectionCtrl
                                                    .changeCoinOn.value,
                                                true,
                                                1);
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 96.w,
                                    height: 48.h,
                                    alignment: Alignment.center,
                                    decoration: _getAnimatedOpacitydecoration(
                                        changeCoinConnectionCtrl
                                            .changeCoinOn.value,
                                        false),
                                    child: Text(
                                      'ON',
                                      style: TextStyle(
                                        color: BaseColor.someTextPopupArea,
                                        fontSize: BaseFont.font18px,
                                        fontFamily: (changeCoinConnectionCtrl
                                                .changeCoinOn.value)
                                            ? BaseFont.familySub
                                            : BaseFont.familyDefault,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 4,
                                top: 4,
                                bottom: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    if (statusType == ChangeStatusType.coin ||
                                        statusType == ChangeStatusType.all) {
                                      if (changeCoinConnectionCtrl
                                                  .statusType.value ==
                                              ChangeType.all ||
                                          changeCoinConnectionCtrl
                                                  .statusType.value ==
                                              ChangeType.billOff) {
                                        changeCoinConnectionCtrl
                                            .pushChangeButton(
                                                changeCoinConnectionCtrl
                                                    .changeCoinOff.value,
                                                false,
                                                1);
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 96.w,
                                    height: 48.h,
                                    alignment: Alignment.center,
                                    decoration: _getAnimatedOpacitydecoration(
                                        changeCoinConnectionCtrl
                                            .changeCoinOff.value,
                                        false),
                                    child: Text(
                                      'OFF',
                                      style: TextStyle(
                                        color: BaseColor.someTextPopupArea,
                                        fontSize: BaseFont.font18px,
                                        fontFamily: (changeCoinConnectionCtrl
                                                .changeCoinOff.value)
                                            ? BaseFont.familySub
                                            : BaseFont.familyDefault,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            changeCoinConnectionCtrl.changeCoinMessage.value,
                            style: const TextStyle(
                              fontSize: BaseFont.font14px,
                              color: BaseColor.accentsColor,
                              fontFamily: BaseFont.familyDefault,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
