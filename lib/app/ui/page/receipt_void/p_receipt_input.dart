/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_inputbox.dart';
import 'package:flutter_pos/app/ui/page/receipt_void/component/w_receiptcomplete.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../common/basepage/common_base.dart';
import '../common/component/w_dicisionbutton.dart';
import '../common/component/w_msgdialog.dart';
import '../subtotal/component/w_register_tenkey.dart';
import 'controller/c_receiptInput_ctrl.dart';
import 'controller/c_receipt_scan_ctrl.dart';
import 'enum/e_input_enum.dart';
import '../../../inc/sys/tpr_log.dart';

/// 通番訂正/検索領収書入力画面、実行画面
class ReceiptInputPageWidget extends CommonBasePage {
  ///　コンストラクタ
  ReceiptInputPageWidget({
    super.key,
  }) {
    List<dynamic> arg = Get.arguments;
    inputCtrl = Get.put(ReceiptInputController(labels: []));
    // inputBoxList = List.generate(
    //     labels.length, (index) => GlobalKey<InputBoxWidgetState>());
    // inputCtrl = Get.put(
    //     ReceiptInputController(inputBoxList: inputBoxList, labels: labels));
    inputCtrl.initLabels(arg[1]);
    inputCtrl.title = arg[0];
    title = arg[0];
    funcKey = arg[2];
    // バーコードスキャン対応追加
    inputCtrl.initValues = List.filled(_leftColumnsCount, '');
    if(arg.length > 3){
      inputCtrl.initValues = arg[3];
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'inputCtrl.initValues:${inputCtrl.initValues}');
      inputCtrl.showDecisionButton.value = true;
      inputCtrl.showRegisterTenkey.value = false;
    }
  }

  /// 画面左側の入力欄の数(4つ)
  static const _leftColumnsCount = 4;

  // ReceiptInputPageWidget({
  //   super.key,
  //   required this.title,
  //   required this.labels,
  // }) {
  //   inputBoxList = List.generate(
  //       labels.length, (index) => GlobalKey<InputBoxWidgetState>());
  //   inputCtrl = Get.put(
  //       ReceiptInputController(inputBoxList: inputBoxList, labels: labels));
  // }

  final ReceiptScanController scanCtrl = Get.find();


  /// 入力フィールドラベル
  // final List<ReceiptVoidInputFieldLabel> labels;

  /// コントローラー
  late final ReceiptInputController inputCtrl;

  /// 入力boxのGlobalKeyのリスト
  // late final List<GlobalKey<InputBoxWidgetState>> inputBoxList;

  /// 各入力widgetの作成
  Widget _receiptListWidget(ReceiptVoidInputFieldLabel labelEnum, int index, String initStringValue) {
    /// ラベルの取得
    String label = labelEnum.label;

    /// 入力ボックスモードの取得
    InputBoxMode mode = labelEnum.mode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 296.w,
          height: 32.h,
          alignment: Alignment.centerLeft,
          color: BaseColor.baseColor,
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: BaseFont.font16px,
                fontFamily: BaseFont.familyDefault,
                color: BaseColor.someTextPopupArea),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          alignment: Alignment.centerLeft,
          child: InputBoxWidget(
            key: inputCtrl.inputBoxList[index],
            width: 296.w,
            height: 56.h,
            fontSize: BaseFont.font28px,
            textAlign: TextAlign.right,
            padding: EdgeInsets.only(right: 32.w),
            cursorColor: BaseColor.baseColor,
            unfocusedBorder: BaseColor.inputFieldColor,
            focusedBorder: BaseColor.accentsColor,
            focusedColor: BaseColor.inputBaseColor,
            borderRadius: 4,
            blurRadius: 6,
            funcBoxTap: () {
              inputCtrl.onInputBoxTap(index);
            },
            iniShowCursor: false,
            //営業日だけカレンダーのアイコンを表示する
            mode: mode,
            calendarTitle: title,
            initStr: initStringValue,
            onComplete: (){
              inputCtrl.moveFocusToNextInputBox();
            }
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(() {
      //2列表示するかを判断
      bool isTwoColumns = inputCtrl.labels.length > _leftColumnsCount;
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(56.w, 88.h, 344, 112.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: List.generate(
                      inputCtrl.labels.length > _leftColumnsCount ? _leftColumnsCount : inputCtrl.labels.length,
                      (index) {
                        ReceiptVoidInputFieldLabel labelKey =
                            inputCtrl.labels.elementAt(index);
                        return Column(
                          children: [
                            _receiptListWidget(labelKey, index, inputCtrl.initValues[index]),
                            if (index != inputCtrl.labels.length - 1 &&
                                index != 3)
                              const SizedBox(
                                height: 40,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                if (isTwoColumns)
                  const SizedBox(
                    width: 32,
                  ),
                Expanded(
                  child: Column(
                    children: List.generate(
                      inputCtrl.labels.length - _leftColumnsCount,
                      (index) {
                        int actualIndex = index + _leftColumnsCount;
                        ReceiptVoidInputFieldLabel labelKey =
                            inputCtrl.labels.elementAt(actualIndex);
                        return Column(
                          children: [
                            _receiptListWidget(labelKey, actualIndex,""),
                            if (actualIndex != inputCtrl.labels.length - 1)
                              const SizedBox(
                                height: 40,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///テンキー
          Obx(
            () {
              if (inputCtrl.showRegisterTenkey.value) {
                return Positioned(
                  right: 0.04.sw,
                  bottom: 0.04.sh,
                  child: RegisterTenkey(onKeyTap: (key) {
                    inputCtrl.inputKeyType(key);
                  }),
                );
              } else {
                return Container();
              }
            },
          ),

          ///実行ボタン
          Obx(
            () {
              if (inputCtrl.showDecisionButton.value) {
                return Positioned(
                  right: 0.04.sw,
                  bottom: 0.04.sh,
                  child: DecisionButton(
                    oncallback: () async {
                    await inputCtrl.onDecisionButtonPressed(funcKey);
                    },
                    text: '実行',
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      );
    });
  }
}
