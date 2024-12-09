/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../regs/checker/rcky_mg.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../../component/w_sound_buttons.dart';
import '../../common/basepage/common_base.dart';
import '../../common/component/w_dicisionbutton.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../controller/c_keypresed_controller.dart';
import '../controller/c_mglogininput_controller.dart';

/// 分類登録ダイアログマネージャ
/// 小分類登録画面クローズ時の処理
class MGLoginPageManager {
  /// ページを開いているか否か
  static bool _isOpen = false;

  static bool isOpen() => _isOpen;

  /// ページを開く
  static void openPage() {
    _isOpen = true;
    debugPrint(
        "******** MGLoginPageManager.isOpen: ${MGLoginPageManager._isOpen}");
  }

  /// ページをとじる
  static void closePage() {
    _isOpen = false;
    debugPrint(
        "******** MGLoginPageManager.isOpen: ${MGLoginPageManager._isOpen}");
  }
}

///分類登録ダイアログの画面構築
class MGLoginPage extends CommonBasePage {
  ///分類登録のコントローラ
  late final MGLoginInputController mgLogCtrl;

  ///手入力操作のコントローラ
  final keyPressCtrl = Get.find<KeyPressController>();

  //先に金額を入力した場合の表示
  final String? initialPrice;

  //先に分類を入力した場合の表示
  final String? initialMGIndex;

  MGLoginPage({
    super.key,
    this.initialPrice,
    this.initialMGIndex,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : super(buildActionsCallback: (context) {
          String className = '分類登録';
          return [
            SoundTextButton(
              onPressed: () {
                Get.back();
                MGLoginPageManager.closePage();
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
        }) {
    mgLogCtrl = Get.put(MGLoginInputController());
    mgLogCtrl.createClsCodeList(initialPrice, initialMGIndex);
    MGLoginPageManager.openPage();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.receiptBottomColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: Center(
            child: Obx(
              () => Text(
                textAlign: TextAlign.center,
                (mgLogCtrl.showRegisterTenKey.value
                    ? '分類と売価を入力してください'
                    : '内容を確認し、「確定する」を」押してください'),
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 264.w,
            top: 155.h,
            child: Column(children: [
              _buildMgInputWidget('売価', 0, InputBoxMode.payNumber),
              SizedBox(
                height: 48.h,
              ),
              _buildMgInputWidget('分類', 1, InputBoxMode.mgClassCode),
            ]),
          ),
          Obx(() {
            if (mgLogCtrl.showRegisterTenKey.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: RegisterTenkey(
                  onKeyTap: (key) async {
                    await mgLogCtrl.inputKeyType(key);
                  },
                ),
              );
            } else {
              return Container();
            }
          }),

          //選択完了の確定ボタン
          Obx(() {
            if (mgLogCtrl.showConfirmButton.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: DecisionButton(
                  oncallback: () async {
                    await mgLogCtrl.confirmButtonPressed();
                  },
                  text: '確定する',
                  isdecision: true,
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

  /// 売価widgetの作成
  Widget _buildMgInputWidget(String label, int index, InputBoxMode mode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: BaseFont.font18px,
              color: BaseColor.baseColor,
              fontFamily: BaseFont.familyDefault,
            )),
        SizedBox(width: 24.w),
        Container(
          alignment: Alignment.centerLeft,
          child: InputBoxWidget(
            key: index == 1
                ? mgLogCtrl.classificationInputKey
                : mgLogCtrl.mgLoginPriceInputKey,
            width: 336.w,
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
              mgLogCtrl.onInBoxTap(index);
            },
            iniShowCursor: false,
            initStr: '',
            //todo:分類入力欄のフォントサイズとfont familyについて再検討が必要（仕様書に書いてないため）
            // initStrTextStyle: index == 1
            //     ? const TextStyle(
            //         fontSize: BaseFont.font18px,
            //         color: BaseColor.baseColor,
            //         fontFamily: BaseFont.familyDefault)
            //     : const TextStyle(
            //         fontSize: BaseFont.font28px,
            //         color: BaseColor.baseColor,
            //         fontFamily: BaseFont.familyNumber),
            useInitStrTextStyle: false,
            mode: mode,
            onCompleteClass: (ManualSmlCls selectedClass) {
              mgLogCtrl.onClassificationSelected(selectedClass);
            },
          ),
        ),
      ],
    );
  }
}
