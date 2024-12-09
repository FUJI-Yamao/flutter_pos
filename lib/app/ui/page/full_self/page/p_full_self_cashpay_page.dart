/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../regs/checker/rc_key_cash4demo.dart';
import '../../../../regs/checker/rc_sound.dart';
import '../../../../regs/checker/rcsyschk.dart';
import '../../../../regs/qcConnect/qcConnect.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../component/w_trainingModeText.dart';
import '../../../language/l_languagedbcall.dart';
import '../../common/component/w_dicisionbutton.dart';
import '../component/w_full_self_amount_row.dart';
import '../component/w_full_self_topbar.dart';
import '../controller/c_full_self_pay_complete_controller.dart';
import '../controller/c_full_self_register_controller.dart';


class FullSelfCashPayPage extends StatefulWidget {
  final String title;

  //訓練モード判定
  final bool isTrainingMode = RcSysChk.rcTROpeModeChk();

  // キャンセルを押したときの処理
  final Function? onCancelPressed;
  FullSelfCashPayPage({super.key, required this.title, this.onCancelPressed,});

  @override
  FullSelfCashPayPageState createState() => FullSelfCashPayPageState();
}

class FullSelfCashPayPageState extends State<FullSelfCashPayPage> {

  FullSelfCashPayPageState();

  Timer? timer;

  @override
  void initState() {
    super.initState();

    // ガイダンス音声番号から音声を出力
    RcSound.playFromSoundNum(
      soundNum: SoundDef.guidanceFullSelfPayNumber,
      isLoop: true
    );
    Future(() async {
      if (!await RcSysChk.rcSGChkSelfGateSystem()) {
        selfCtrl.totalAmount.value = RegsMem().tTtllog.t100001.stlTaxInAmt.toString();
        selfCtrl.changeReceivedAmount.value = 0;
        selfCtrl.receiveAmount.value = 0;
        selfCtrl.updateAmounts();
        RcKeyCashDemo.rcKeyCash4Demo(requestParaPay: QcConnect.calcRequestParaPay);
      } else {
        RcKeyCashDemo.rcKeyCash4Demo();
      }
    });
  }

  //フルセルフ商品登録のコントローラ
  final FullSelfRegisterController selfCtrl =
  Get.find<FullSelfRegisterController>();

    // 支払い完了時のコントローラ
  final FullSelfPayCompleteController completeCtrl =
      Get.put(FullSelfPayCompleteController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Obx(() =>
                FullSelfTopGreyBar(
                    title: completeCtrl.complete.value
                        ? "l_full_self_finish_cash_payment".trns
                        : widget.title.trns
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FullSelfAmountBlackContainer(
                height: 220.0,
                children: [
                  SizedBox(
                    height: 64.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() => SizedBox(
                          width: 256.0,
                          child: FittedBox(
                            alignment: Alignment.bottomLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'l_full_self_total_amount'.trns,
                              style: const TextStyle(
                                color: BaseColor.someTextPopupArea,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),),
                        Obx(
                              () =>
                              FullSelfAmountRow(
                                label: '',
                                value: '¥ ${selfCtrl.totalAmount.value}',
                                isTotal: true,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 64.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 256.0,
                          child: Obx(() => FittedBox(
                            alignment: Alignment.bottomLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'l_full_self_tendered'.trns,
                              style: const TextStyle(
                                color: BaseColor.someTextPopupArea,
                                fontSize: 24,
                              ),
                            ),
                          ),),
                        ),
                        Obx(
                                () =>
                                FullSelfAmountRow(
                                  label: '',
                                  value: '¥ ${selfCtrl.changeReceivedAmount.value}',
                                  isTotal: true,
                                )),
                      ],
                    ),
                  ),
                  Obx(
                        () =>
                        SizedBox(
                          height: 64.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 256.0,
                                child: FittedBox(
                                  alignment: Alignment.bottomLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    selfCtrl.isChangeMode.value
                                        ? 'l_full_self_change'.trns
                                        : 'l_full_self_amount_due'.trns,
                                    style: const TextStyle(
                                      color: BaseColor.someTextPopupArea,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                      () =>
                                      FullSelfAmountRow(
                                        label: '',
                                        value: selfCtrl.isChangeMode.value
                                            ? '¥ ${selfCtrl.change.value}'
                                            : '¥ ${selfCtrl.notEnough.value}',
                                        isTotal: true,
                                      )),
                            ],
                          ),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Obx(
                        () =>
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                              getGuideText().trns,
                              style: const TextStyle(
                                color: BaseColor.baseColor,
                                fontSize: 24,
                              ),
                            ),),
                            const SizedBox(height: 20),
                            if (selfCtrl.isChangeMode.value && !completeCtrl.complete.value)
                              DecisionButton(
                                text: 'l_full_self_confirm'.trns,
                                maxHeight:160.h,
                                maxWidth: 400.w,
                                oncallback: _decideCinAmount,
                              ),
                          ],
                        ),
                  ),
                ),
              ),
               const SizedBox(height: 20),
            ],
          ),
          //右上のキャンセルボタン
          Obx(() =>Visibility(
            visible: !completeCtrl.complete.value,
            child: 
            Positioned(
              right: 5.w,
              top: 5.h,
              child: SoundTextButton(
                onPressed: () {
                  RcKeyCashDemo.isCancel  = true;
                  Get.back();
                },
                callFunc: runtimeType.toString(),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.close,
                        color: BaseColor.someTextPopupArea, size: 45),
                    SizedBox(
                      width: 10.w,
                    ),
                    Obx(() => Text(
                      'l_full_self_back'.trns,
                      style: const TextStyle(
                          color: BaseColor.someTextPopupArea,
                          fontSize: BaseFont.font18px),
                    ),),
                  ],
              )),
            ))
          ),
          //訓練モードの時表示する半透明テキスト
          if (widget.isTrainingMode) TrainingModeText(),
        ],
      ),
    );
  }

  void _decideCinAmount() {
    RcKeyCashDemo.fullSelfUpdateInCoin();
    RcKeyCashDemo.isDecideCinAmount = true;
  }

  /// 操作ガイダンスのテキストを取得する
  String getGuideText(){
    if(completeCtrl.complete.value){
      return 'l_full_self_thank_you';
    }
    if(selfCtrl.isChangeMode.value){
      return 'l_full_self_press_button';
    }
    return 'l_full_self_insert_cash';
  }
}
