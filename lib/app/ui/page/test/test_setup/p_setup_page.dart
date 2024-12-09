/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../common/component/w_msgdialog.dart';
import '../../maintenance/specfile/component/w_tenkeydialog.dart';
import '../../maintenance/specfile/controller/c_tenkey_controller.dart';
import '../../maintenance/specfile/model/m_specfile.dart';
import '../../terminal/p_passwordinput.dart';


/// 端末セットアップ通信page
class SetupInputDialog extends TenkeyDialog {
  /// コンストラクタ
  SetupInputDialog({
    Key? key,
  }) : super(
    key: key,
    title: '端末セットアップ通信',
    currentBreadcrumb: '',
    settingName: '12桁のTIDを入力してください',
    setting: const NumInputSetting(0, 999999999999),
    initValue:  '',
    oncallback:  () {},
  );

  @override
  Widget cancelDecideButton(
      {required Function onCancel,
        required Function onDecide,
        String cancelStr = "",
        String decideStr = ""}) {
    return   decidePassKeyButton(onDecide: () {
      TenkeyController c = Get.find();
      String inputValue = c.getNowStr();
      if (inputValue.length == 12) {
        // dialogKind: DlgConfirmMsgKind.MSG_PWDDIFFER,
        MsgDialog.show(MsgDialog.twoButtonDlgId(
          type: MsgDialogType.info,
          dialogId: DlgConfirmMsgKind.MSG_EXECCONF.dlgId,
          rightBtnFnc:() {
            //TODO: セットアップ画面の実行関数を行う
          } ,
        ));

      } else {
        MsgDialog.show(MsgDialog.singleButtonMsg(
          //dialogKind: DlgConfirmMsgKind.MSG_PWDDIFFER,
          type: MsgDialogType.error,
          message:"入力値エラー,12桁入力してください",

        ));
      }
    });
  }

}

