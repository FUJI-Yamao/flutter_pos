/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/page/maintenance/specfile/component/w_tenkey.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import '../../../../component/w_inputbox.dart';
import '../../template/basepage/maintainbase.dart';
import '../model/m_specfile.dart';
import '/app/ui/page/maintenance/specfile/controller/c_tenkey_controller.dart';
import '../../../common/component/w_msgdialog.dart';

/// スペックファイル用テンキーダイアログ
class TenkeyDialog extends MaintainBasePage {
  ///コンストラクタ
  TenkeyDialog({
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    required this.settingName,
    required this.setting,
    required this.initValue,
    required this.oncallback,
  });

  ///設定項目名
  final String settingName;

  ///数値入力設定（最小値、最大値）
  final NumInputSetting setting;

  ///初期値
  final String initValue;

  ///決定時の処理
  ///コールバック関数
  final Function oncallback;

  ///入力ボックスのグローバルキー
  final inputBox = GlobalKey<InputBoxWidgetState>();


  @override
  Widget body(BuildContext context) {
    ///コントローラー
    TenkeyController c =
        Get.put(TenkeyController(inputBox, setting.minValue, setting.maxValue));
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
                mode: InputBoxMode.defaultMode,
              ),
              TenkeyWidget(controller: c),
            ],
          ),
          SizedBox(
            height: 50.h,
          ),

          /// キャンセル・決定ボタン
          cancelDecideButton(onCancel: () {
            Get.back();
          }, onDecide: () {
            // 入力チェックして、問題があればダイアログを出す.
            bool valid = c.checkWithInRange();
            if (valid) {
              oncallback(c.getNowStr());
              Get.back(result: c.getNowStr());
            } else {
              MsgDialog.show(
                //todo ダイアログメッセージ確定出来たらdialogKindを追加
                MsgDialog.singleButtonMsg(
                  type: MsgDialogType.error,
                  message:"${setting.minValue}から${setting.maxValue}の範囲内の値を入力してください",
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
