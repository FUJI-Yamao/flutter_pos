/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/regs/checker/rc_taxfree_svr.dart';
import 'package:flutter_pos/app/regs/checker/rcinoutdsp.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/inc/rc_mem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../common/number_util.dart';
import '../../../inc/apl/fnc_code.dart';
import '../../../inc/apl/rxmemprn.dart';
import '../../../regs/acx/rc_acx.dart';
import '../../../regs/checker/rc_ext.dart';
import '../../../regs/checker/rcky_cin.dart';
import '../../../regs/checker/rcsyschk.dart';
import '../../../sys/sale_com_mm/rept_ejconf.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_inputbox.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import '../common/component/w_dicisionbutton.dart';
import '../subtotal/component/w_register_tenkey.dart';
import 'controller/c_changecoinin_controller.dart';

/// 動作概要
/// 起動方法： Get.to(() => ChangeCoinInScreen(title: title)); など
/// 処理結果：確定処理後、入金額とおつりは以下から取得する
///   入金額  changeCoinInCtrl.coinInPrc.value
///   おつり  changeCoinInCtrl.change.value

/// 入力ボックスの種別
enum CoinInInputBoxType {
  edit, // 編集可能エディットボックス
  label // 文字表示のみ
}

/// 釣機入金のページ
class ChangeCoinInScreen extends CommonBasePage {
  final FuncKey funcKey;

  ChangeCoinInScreen({
    super.key,
    required this.funcKey,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'ChangeCoinInScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                // todo 釣銭機業務画面から呼ばれている想定なので、処理内容は要確認
                Future(() async {
                  RckyCin.isCancel = true;
                  await Future.delayed(const Duration(seconds: 1));
                  await RckyCin.cancelCharger();
                  Get.back();
                });
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
    return ChangeCoinInWidget(
      funcKey: funcKey,
      backgroundColor: backgroundColor,
    );
  }
}

class ChangeCoinInWidget extends StatefulWidget {
  final Color backgroundColor;
  final FuncKey funcKey;

  const ChangeCoinInWidget({super.key, required this.backgroundColor, required this.funcKey});

  @override
  ChangeCoinInState createState() => ChangeCoinInState();
}

class ChangeCoinInState extends State<ChangeCoinInWidget> {
  ChangeCoinInInputController changeCoinInCtrl = Get.put(ChangeCoinInInputController());

  Timer? timer;

  @override
  void initState() {
    super.initState();
    // ページオープンと同時に入金処理開始
    Future(() async {
      timer = Timer.periodic(const Duration(milliseconds: 100), _onTimer);
      AcMem cMem = SystemFunc.readAcMem();
      cMem.stat.fncCode = widget.funcKey.keyId;
      await RckyCin.rcKyCin();
    });
  }

  void _onTimer(Timer timer) async {
    if (widget.funcKey == FuncKey.KY_CHGCIN) {
      changeCoinInCtrl.setReceivedProc(RckyCin.cinAmount);
    }
  }

  @override
  void dispose() {
    RckyCin.rckyCinClose();
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    super.dispose();
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
              widget.funcKey == FuncKey.KY_CHGCIN ? 'お金をつり銭機に入れてください。 \n投入金額の一部を入金する場合は入金額を入力してから「入金する」を押してください。' : '入金したい金額を入力してください。',
              textAlign: TextAlign.center,
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
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 76.h,
                  ),
                  Container(
                    color: BaseColor.someTextPopupArea,
                    width: 416.w,
                    height: 72.h,
                    child: buildListRow(
                      leftText: '入金',
                      rightText: NumberFormatUtil.formatAmount(
                        changeCoinInCtrl.currentCoinInPrc.value),
                      boxType: CoinInInputBoxType.edit,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    color: BaseColor.someTextPopupArea,
                    width: 416.w,
                    height: 72.h,
                    child: buildListRow(
                      leftText: 'お預かり',
                      rightText: NumberFormatUtil.formatAmount(
                          changeCoinInCtrl.receivePrc.value),
                      boxType: CoinInInputBoxType.label,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    color: BaseColor.someTextPopupArea,
                    width: 416.w,
                    height: 72.h,
                    child: buildListRow(
                      leftText: 'おつり',
                      rightText: NumberFormatUtil.formatAmount(
                          widget.funcKey == FuncKey.KY_CHGCIN ? changeCoinInCtrl.receivePrc.value - changeCoinInCtrl.currentCoinInPrc.value : 0
                      ),
                      boxType: CoinInInputBoxType.label,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // todo 現状区分は不要とのことなので非表示＆詳細未実装
          false
              ? Positioned(
                  top: 50.h,
                  right: 36,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 268.w,
                        height: 26.h,
                        child: const Text(
                          '区分',
                          style: TextStyle(
                            color: BaseColor.baseColor,
                            fontSize: BaseFont.font18px,
                            fontFamily: BaseFont.familyDefault,
                          ),
                        ),
                      ),
                      // todo 表示位置確認用なので正式なWidgetに修正要
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 268.w,
                          height: 56.h,
                          color: BaseColor.someTextPopupArea,
                          child: const Text(
                            '1. エラー貨幣の戻し入れ   >',
                            style: TextStyle(
                              color: BaseColor.baseColor,
                              fontSize: BaseFont.font18px,
                              fontFamily: BaseFont.familyDefault,
                            ),
                          ))
                    ],
                  ),
                )
              : Container(),

          //入金完了の確定ボタン
          Obx(() {
            if (changeCoinInCtrl.currentCoinInPrc > 0 &&
                !changeCoinInCtrl.showRegisterTenkey.value) {
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

          // テンキー
          Obx(() {
            if (changeCoinInCtrl.showRegisterTenkey.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: RegisterTenkey(
                  onKeyTap: (key) {
                    widget.funcKey == FuncKey.KY_CHGCIN ? changeCoinInCtrl.inputKeyType(key) : changeCoinInCtrl.inputKeyTypeForFrcSelect(key, RckyCin.isNotFrcSelect());
                  },
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

  /// 各行を作成する
  /// leftText  左ラベルテキスト
  /// rightText 右ラベルテキスト
  /// boxType   入力ボックスのタイプ
  Widget buildListRow(
      {String leftText = '',
       String rightText = '',
        CoinInInputBoxType boxType = CoinInInputBoxType.edit}) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 22),
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
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          boxType == CoinInInputBoxType.edit
              ? InputBoxWidget(
                  initStr: rightText,
                  key: changeCoinInCtrl.inputBoxKey,
                  width: 144.w,
                  height: 56.h,
                  fontSize: BaseFont.font22px,
                  textAlign: TextAlign.right,
                  padding: const EdgeInsets.only(right: 16),
                  cursorColor: BaseColor.baseColor,
                  unfocusedBorder: BaseColor.inputFieldColor,
                  focusedBorder: BaseColor.accentsColor,
                  focusedColor: BaseColor.inputBaseColor,
                  borderRadius: 4,
                  blurRadius: 6,
                  funcBoxTap: () {
                    changeCoinInCtrl.onInputBoxTap();
                  },
                  iniShowCursor: false,
                  mode: InputBoxMode.payNumber,
                )
              : Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  width: 144.w,
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
    );
  }

  /// 確定キー押下時処理
  void _decideCinAmount() {
    changeCoinInCtrl.coinInPrc.value = changeCoinInCtrl.currentCoinInPrc.value;
    changeCoinInCtrl.change.value = changeCoinInCtrl.receivePrc.value - changeCoinInCtrl.coinInPrc.value;
    debugPrint("_decideCinAmount　釣機入金：入金額=${changeCoinInCtrl.coinInPrc.value.toString()},おつり=${changeCoinInCtrl.change.value.toString()}");
    RckyCin.isDecideCinAmount = true;
    int step = 0;
    int type = 0;
    int errNo = 0;
    AcMem CMEM = SystemFunc.readAcMem();
    Future(() async {
      // 読み込み処理の終了
      errNo = await RckyCin.rcEndCin();
      if (errNo != 0) {
        CMEM.ent.errNo = errNo;
        await ReptEjConf.rcErr("_decideCinAmount", errNo);
        RckyCin.isDecideCinAmount = false;
        return;
      }
      await Future.delayed(const Duration(milliseconds: 500));
      // KY_CHGCIN処理
      await Rcinoutdsp.rcInoutDrawOpen(0);
      (errNo, step) = await RckyCin.rcEndDifferentCin(type, step, changeCoinInCtrl.change.value);
      if (errNo != 0) {
        CMEM.ent.errNo = errNo;
        await ReptEjConf.rcErr("_decideCinAmount", errNo);
        RckyCin.isDecideCinAmount = false;
        return;
      }
      TprLog().logAdd(0, LogLevelDefine.normal, "rcEndDifferentCin($step)\n");
      if (step == 0) {
        return;	     //入出金画面消去に進まない
      } else {
        Get.back();  //入出金画面消去へ進む（実績上げ処理を行っているので）
      }
    });
  }
}
