/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/page/common/component/w_msgdialog.dart';
import '../../../../../inc/sys/tpr_dlg.dart';
import '../../../../colorfont/c_basecolor.dart';
import '../../../../component/w_inputbox.dart';
import '../../template/basepage/maintainbase.dart';
import '../controller/c_tenkey_recog_controller.dart';
import '../model/m_specfile.dart';
import '/app/ui/page/maintenance/specfile/component/w_recogkeytenkey.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///スペックファイル用テンキーダイアログ（承認キー入力）
class RecogkeyTenkeyDialog extends MaintainBasePage {
  ///コンストラクタ
  RecogkeyTenkeyDialog({
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    required this.settingName,
    required this.setting,
    required this.initValue,
  }) {
    controller = Get.put(
        TenkeyRecogController(inputBox, setting.digitFrom, setting.digitTo));
  }

  ///設定項目（最小値、最大値）
  final StringInputSetting setting;

  ///設定項目名
  final String settingName;

  ///初期値
  final String initValue;

  ///コントローラー
  late final TenkeyRecogController controller;

  ///入力ボックスのグローバルキー
  final inputBox = GlobalKey<InputBoxWidgetState>();

  @override
  Widget body(BuildContext context) {
    return Container(
      color: BaseColor.maintainBaseColor,
      padding: EdgeInsets.only(right: 100.w, left: 100.w),
      child: Flex(
        direction: Axis.vertical,
        children: [
          SizedBox(
            height: 10.h,
          ),

          /// 設定項目名を表示
          Container(
            width: 700.w,
            alignment: Alignment.center,
            child: Text(
              settingName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: BaseFont.font26px,
                  color: BaseColor.someTextPopupArea),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

          ///入力ボックスとテンキーWidgetの配置
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputBoxWidget(
                key: inputBox,
                width: 350.w,
                height: 50.h,
                fontSize: BaseFont.font26px,
                initStr: initValue,
                mode: InputBoxMode.defaultMode,
              ),
              RecogkeyTenkeyWidget(controller: controller),
            ],
          ),
          SizedBox(
            height: 50.h,
          ),

          ///キャンセル・決定ボタン
          cancelDecideButton(onCancel: () {
            Get.back();
          }, onDecide: () async {
            if (!controller.checkWithInRange()) {
              MsgDialog.show(
                MsgDialog.singleButtonDlgId(
                  type: MsgDialogType.error,
                  dialogId: DlgConfirmMsgKind.MSG_PACKOVERERR.dlgId,
                ),
              );

              return;
            } else {
              Get.back(result: controller.getNowStr());
            }
          })
        ],
      ),
    );
  }
}
