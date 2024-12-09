/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../inc/sys/tpr_dlg.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_btn.dart';
import '../../component/w_inputbox.dart';
import '../../menu/register/enum/e_register_page.dart';
import '../common/component/w_msgdialog.dart';
import '../maintenance/specfile/component/w_tenkey.dart';
import '../maintenance/specfile/model/m_specfile.dart';
import '../maintenance/template/basepage/maintainbase.dart';
import 'controller/c_passwordinput_controller.dart';

/// パスワード入力画面
/// テンキーダイアログ
class PassWordInputDialog extends MaintainBasePage {
  /// コンストラクタ
  PassWordInputDialog({
    super.key,
    required super.title,
    required this.settingName,
    required this.setting,
    required this.initValue,
  }) : super(currentBreadcrumb: '');

  /// 設定項目名
  final String settingName;


  /// 数値入力設定（最小値、最大値）
  final NumInputSetting setting;

  /// 初期値
  final String initValue;

  /// 入力ボックスのグローバルキー
  final inputBox = GlobalKey<InputBoxWidgetState>();

  /// パスワードを定数化する
  static const passkey = "3752";

  /// ヘッダーを返す
  @override
  Widget? header(BuildContext context) {
    return null;
  }

  /// 文字クリア関数
  void clearString() {
    inputBox.currentState?.onDeleteAll();
  }

  @override
  Widget body(BuildContext context) {
    ///コントローラー
    PassWordTenkeyController c = Get.put(PassWordTenkeyController(inputBox, setting.minValue, setting.maxValue));
    return Container(
      color: BaseColor.maintainBaseColor,
      padding: EdgeInsets.only(right: 120.w, left: 120.w),
      child: Flex(
        direction: Axis.vertical,
        children: [
          SizedBox(
            height: 21.h,
          ),

          ///設定項目名
          Container(
            alignment: Alignment.center,
            child: Text(
              settingName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: BaseFont.font28px,
                  color: BaseColor.someTextPopupArea),
            ),
          ),
          SizedBox(
            height: 29.h,
          ),

          ///入力ボックスとテンキーWidgetの配置
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              InputBoxWidget(
                key: inputBox,
                width: 350.w,
                height: 50.h,
                fontSize: BaseFont.font24px,
                textAlign: TextAlign.left,
                initStr: initValue,
                mode: InputBoxMode.password,
              ),
              TenkeyWidget(
                  controller: c,
                  dispTab: false
              ),
            ],
          ),
          SizedBox(
            height: 50.h,
          ),

          /// 決定ボタン
          decidePassKeyButton(onDecide: () {
            String inputValue = c.getNowStr();
            if (inputValue == passkey) {
              _onButtonPressed(context);
            } else {

              Get.dialog(
                MsgDialog.singleButtonDlgId(
                  type: MsgDialogType.error,
                  dialogId:DlgConfirmMsgKind.MSG_PWDDIFFER.dlgId,
                ),
                barrierDismissible: false,
              ).then((_) {
                clearString();
              });
            }
          })
        ],
      ),
    );
  }

  /// 決定ボタンが押されたときに呼び出されるメソッド
  void _onButtonPressed(BuildContext context) {
    // メンテナンスTOP画面へ遷移（端末情報画面とパスワード入力画面はスタックから消す）
    Get.offNamedUntil(RegisterPage.maintenanceTop.routeName, ModalRoute.withName(RegisterPage.mainMenu.routeName));
  }
}

/// 決定ボタンの配置
Widget decidePassKeyButton({
  required Function onDecide,
  String decideStr = "",
}) {
  return Flex(
    direction: Axis.horizontal,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GradientBorderButton(
        width: 209.w,
        height: 80.h,
        text: decideStr.isEmpty ? '決定' : decideStr,
        onTap: onDecide,
      )
    ],
  );
}