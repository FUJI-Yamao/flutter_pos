/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_inputbox.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_pos/app/ui/page/EJConfirmation/enum/e_EJconf_enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/c_ejconf_controller.dart';

///条件を絞り込むのコンテナー構築
class EJconfSearchContainerWidget extends StatelessWidget {
  final String title;
  final List<EJconfInputFieldLabel> labels;
  final EJconfInputController ejconfCtrl;

  EJconfSearchContainerWidget({
    super.key,
    required this.title,
    required this.labels,
  }) : ejconfCtrl = Get.put(EJconfInputController(
          ejconfinputBoxList: List.generate(
              labels.length, (_) => GlobalKey<InputBoxWidgetState>()),
          labels: labels

        ));

  ///ラベルリストから行ウイジェットを生成する
  Widget generateRowWidgets(List<EJconfInputFieldLabel> labelsForRow) {
    List<Widget> rowWidgets = [];
    for (int i = 0; i < labelsForRow.length; i++) {
      var label = labelsForRow[i];

      rowWidgets.add(ejconfListWidget(label, labels.indexOf(label)));

      bool isLastElement = i == labelsForRow.length - 1;
      bool nextIsTimezoneTwo = !isLastElement &&
          labelsForRow[i + 1] == EJconfInputFieldLabel.timeZoneTwo;
      if (!isLastElement && !nextIsTimezoneTwo) {
        rowWidgets.add(SizedBox(width: 48.w));
      }
    }
    return Row(children: rowWidgets);
  }

  ///指定されたラベルに応じて入力フィールドウイジェットを生成する
  Widget ejconfListWidget(EJconfInputFieldLabel labelEnum, int index) {
    GlobalKey<InputBoxWidgetState> key = ejconfCtrl.ejconfinputBoxList[index];

    Widget labelWidget = Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        labelEnum.labelText,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: BaseFont.font16px,
          fontFamily: BaseFont.familyDefault,
          color: BaseColor.baseColor,
        ),
      ),
    );

    ///ラベルタイプに応じて入力ウイジェット作成
    Widget inputWidget;

    switch (labelEnum) {
      case EJconfInputFieldLabel.timeZoneOne:
        inputWidget = _createTimeWidget(key, index, isTimeOne: true);
        break;
      case EJconfInputFieldLabel.timeZoneTwo:
        inputWidget = _createTimeWidget(key, index, isTimeOne: false);
        break;
      case EJconfInputFieldLabel.receiptNum:
        inputWidget = _createReceiptNumWidget(key, index);
        break;
      case EJconfInputFieldLabel.keyWord:
        inputWidget = _createKeyWordWidget();
        break;
      case EJconfInputFieldLabel.registerNum:
        inputWidget = _createRegisterNumWidget(key, index);
        break;
      case EJconfInputFieldLabel.businessDay:
        labelWidget = Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Container(
            width: 288.w,
            height: 32.h,
            color: BaseColor.baseColor,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              labelEnum.labelText,
              style: const TextStyle(
                fontSize: BaseFont.font16px,
                fontFamily: BaseFont.familyDefault,
                color: BaseColor.someTextPopupArea,
              ),
            ),
          ),
        );
        inputWidget = _createDateWidget(key, index);
        break;
      default:
        inputWidget = Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        inputWidget,
      ],
    );
  }

  ///キーワードウイジェットに対応する説明テキストを生成する
  Widget generateKeyWordRow() {
    Widget keyWordWidget = ejconfListWidget(EJconfInputFieldLabel.keyWord,
        labels.indexOf(EJconfInputFieldLabel.keyWord));

    Widget addText = Padding(
      padding: EdgeInsets.only(left: 8.w, top: 16.h),
      child: const Text(
        '入力したキーワードを含む取り引き\n全て表示されます',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: BaseFont.familyDefault,
          color: BaseColor.accentsColor,
          fontSize: BaseFont.font14px,
          height: 1.3,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        keyWordWidget,
        addText,
      ],
    );
  }

  ///日付の入力インプットボックスウィジェット
  Widget _createDateWidget(GlobalKey<InputBoxWidgetState> key, int index) {
    return InputBoxWidget(
        key: key,
        width: 288.w,
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
          ejconfCtrl.onInputBoxTap(index);
        },
        iniShowCursor: false,
        //営業日だけカレンダーのアイコンを表示する
        mode: InputBoxMode.calendar,
        calendarTitle: title,
        initStr: EJconfInputController.initDateStr,
        initStrTextStyle: EJconfInputController.commonInitStrTextStyle(),
        useInitStrTextStyle: true,
        onComplete: () {
          ejconfCtrl.moveFocusToNextInputBox();
        });
  }

  ///時間帯の入力インプットボックスウィジェット
  Widget _createTimeWidget(GlobalKey<InputBoxWidgetState> key, int index,
      {required bool isTimeOne}) {
    Widget timeWidget = InputBoxWidget(
      key: key,
      width: 128.w,
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
        ejconfCtrl.onInputBoxTap(index);
      },
      iniShowCursor: false,
      mode: InputBoxMode.timeNumber,
      initStr: EJconfInputController.initTimeStr,
      initStrTextStyle: EJconfInputController.commonInitStrTextStyle(),
      useInitStrTextStyle: true,
    );

    if (isTimeOne) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          timeWidget,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: const Text(
              '―',
              style: TextStyle(
                fontSize: BaseFont.font14px,
                color: BaseColor.scrollerColor,
              ),
            ),
          ),
        ],
      );
    } else {
      return timeWidget;
    }
  }

  ///レシート番号の入力インプットボックスウィジェット
  Widget _createReceiptNumWidget(
      GlobalKey<InputBoxWidgetState> key, int index) {
    return InputBoxWidget(
      key: key,
      width: 128.w,
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
        ejconfCtrl.onInputBoxTap(index);
      },
      iniShowCursor: false,
      mode: InputBoxMode.defaultMode,
      initStr: EJconfInputController.initReceiptNumStr,
      initStrTextStyle: EJconfInputController.commonInitStrTextStyle(),
      useInitStrTextStyle: true,
    );
  }

  ///キーワードを指定の入力インプットボックスウィジェット
  Widget _createKeyWordWidget() {
    String callFunc = '_createKeyWordWidget';
    return Material(
      elevation: 4.0,
      child: Container(
        width: 288.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: BaseColor.someTextPopupArea,
          border: Border.all(
            color: BaseColor.scrollerColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: const Text(
                'キーワードから検索',
                style: TextStyle(
                  fontSize: BaseFont.font18px,
                  color: BaseColor.baseColor,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
            ),
            SoundIconButton(
              onPressed: () {},
              callFunc: callFunc,
              iconSize: BaseFont.font30px,
              icon: const Icon(
                Icons.navigate_next,
                color: BaseColor.baseColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///レジ番号の入力インプットボックスウィジェット
  Widget _createRegisterNumWidget(
      GlobalKey<InputBoxWidgetState> key, int index) {
    return InputBoxWidget(
      key: key,
      width: 128.w,
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
        ejconfCtrl.onInputBoxTap(index);
      },
      iniShowCursor: false,
      mode: InputBoxMode.defaultMode,
      initStr: EJconfInputController.initRegisterNumStr,
      initStrTextStyle: EJconfInputController.commonInitStrTextStyle(),
      useInitStrTextStyle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        generateRowWidgets([
          EJconfInputFieldLabel.businessDay,
        ]),
        SizedBox(
          height: 42.h,
        ),
        Container(
          width: 602.w,
          height: 32.h,
          alignment: Alignment.centerLeft,
          color: BaseColor.baseColor,
          padding: EdgeInsets.only(left: 16.w),
          child: const Text(
            '条件を絞り込む',
            style: TextStyle(
              fontSize: BaseFont.font16px,
              fontFamily: BaseFont.familyDefault,
              color: BaseColor.someTextPopupArea,
            ),
          ),
        ),
        Container(
          color: BaseColor.someTextPopupArea,
          width: 602.w,
          height: 382.h,
          child: Padding(
            padding: EdgeInsets.only(left: 36.w, top: 25.h),
            child: Column(
              children: [
                generateRowWidgets([
                  EJconfInputFieldLabel.timeZoneOne,
                  EJconfInputFieldLabel.timeZoneTwo,
                  EJconfInputFieldLabel.receiptNum,
                ]),
                SizedBox(height: 32.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    generateKeyWordRow(),
                    SizedBox(width: 48.w),
                    generateRowWidgets([
                      EJconfInputFieldLabel.registerNum,
                    ])
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
