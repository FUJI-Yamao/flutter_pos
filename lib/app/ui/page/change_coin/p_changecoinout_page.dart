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
import '../../../inc/sys/tpr_log.dart';
import '../../../regs/checker/rcinoutdsp.dart';
import '../../../regs/checker/rcky_out.dart';
import '../../../regs/inc/rc_mem.dart';
import '../../../sys/sale_com_mm/rept_ejconf.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_inputbox.dart';
import '../../component/w_sound_buttons.dart';
import '../../language/l_languagedbcall.dart';
import '../common/basepage/common_base.dart';
import '../common/component/w_dicisionbutton.dart';
import '../subtotal/component/w_register_tenkey.dart';
import 'controller/c_changecoinout_controller.dart';

/// 動作概要
/// 起動方法：Get.to(() => ChangeCoinOutScreen(title: title));　など
/// 処理結果：確定処理後、払出額は以下から取得する
///   払出額  changeCoinOutCtrl.coinOutPrc.value

/// 入力ボックスの種別
enum CoinOutInputBoxType {
  edit, // 編集可能エディットボックス
  label // 文字表示のみ
}

/// 釣機払出のページ
class ChangeCoinOutScreen extends CommonBasePage {
  final FuncKey funcKey;

  ChangeCoinOutScreen({
    super.key,
    required this.funcKey,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
    String className = 'ChangeCoinOutScreen';
          return <Widget>[
            SoundTextButton(
              onPressed: () {
                // todo 釣銭機業務画面から呼ばれている想定なので、処理内容は要確認
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

  @override
  Widget buildBody(BuildContext context) {
    return ChangeCoinOutWidget(
      funcKey: funcKey,
      backgroundColor: backgroundColor,
    );
  }
}

class ChangeCoinOutWidget extends StatefulWidget {
  final Color backgroundColor;
  final FuncKey funcKey;

  const ChangeCoinOutWidget({super.key, required this.backgroundColor, required this.funcKey});

  @override
  ChangeCoinOutState createState() => ChangeCoinOutState();
}

class ChangeCoinOutState extends State<ChangeCoinOutWidget> {
  ChangeCoinOutInputController changeCoinOutCtrl = Get.put(ChangeCoinOutInputController());

  @override
  void initState() {
    super.initState();
    Future(() async {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.stat.fncCode = widget.funcKey.keyId;
      await RckyOut.rcKyOut();
    });
  }

  @override
  void dispose() {
    RckyOut.rckyOutClose();
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
          child: const Center(
            child: Text(
              textAlign: TextAlign.center,
              'つり銭機から払い出す金額を入力して「確定する」を押してください',
              style: TextStyle(
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
                      leftText: '払い出し',
                      rightText: NumberFormatUtil.formatAmount(
                          changeCoinOutCtrl.currentCoinOutPrc.value),
                      boxType: CoinOutInputBoxType.edit,
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
            if (changeCoinOutCtrl.currentCoinOutPrc > 0 &&
                !changeCoinOutCtrl.showRegisterTenkey.value) {
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
            if (changeCoinOutCtrl.showRegisterTenkey.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: RegisterTenkey(
                  onKeyTap: (key) {
                    changeCoinOutCtrl.inputKeyType(key);
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
        CoinOutInputBoxType boxType = CoinOutInputBoxType.edit}) {
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
          boxType == CoinOutInputBoxType.edit
              ? InputBoxWidget(
                  initStr: rightText,
                  key: changeCoinOutCtrl.inputBoxKey,
                  width: 144.w,
                  height: 56.h,
                  fontSize: BaseFont.font22px,
                  textAlign: TextAlign.right,
                  padding: const EdgeInsets.only(right: 32),
                  cursorColor: BaseColor.baseColor,
                  unfocusedBorder: BaseColor.inputFieldColor,
                  focusedBorder: BaseColor.accentsColor,
                  focusedColor: BaseColor.inputBaseColor,
                  borderRadius: 4,
                  blurRadius: 6,
                  funcBoxTap: () {
                    changeCoinOutCtrl.onInputBoxTap();
                  },
                  iniShowCursor: true,
                  mode: InputBoxMode.payNumber,
                )
              : Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 32),
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
    changeCoinOutCtrl.coinOutPrc.value = changeCoinOutCtrl.currentCoinOutPrc.value;
    debugPrint("釣機払出：払出額=${changeCoinOutCtrl.coinOutPrc.value.toString()}");
    int step = 0;
    int type = 0;
    int errNo = 0;
    AcMem CMEM = SystemFunc.readAcMem();
    Future(() async {
      // KY_CHGOUT処理
      Rcinoutdsp.rcInoutDrawOpen(0);
      (errNo, step) = await RckyOut.rcEndDifferentOut(type, step, changeCoinOutCtrl.coinOutPrc.value);
      if (errNo != 0) {
        CMEM.ent.errNo = errNo;
        await ReptEjConf.rcErr("_decideCinAmount", errNo);
      }
      TprLog().logAdd(0, LogLevelDefine.normal, "rcEnd_DifferentOut($step)\n");
      if (step == 0) {
        return; //入出金画面消去に進まない
      } else {
        Get.back();  //入出金画面消去へ進む（実績上げ処理を行っているので）
      }
    });
  }
}
