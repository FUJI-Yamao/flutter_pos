/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/inc/sys/tpr_dlg.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:flutter_pos/app/ui/page/change_coin_connection/p_change_coin_connection_page.dart';
import 'package:flutter_pos/app/ui/page/common/component/w_msgdialog.dart';
import 'package:get/get.dart';

import '../../../../regs/checker/rckycpwr.dart';

/// 釣銭機ON/OFF画面のコントローラ
class ChangeCoinConnectionController extends GetxController {

  /// 接続している場合の表示メッセージ
  static const String connectMsg = '接続しています';

  /// 接続していない場合の表示メッセージ
  static const String noConnectMsg = '接続していません';

  /// 現在の釣機の状態
  var statusType = ChangeType.all.obs;  

  /// つり札機ON
  var changeBillOn = true.obs;

  /// つり札機OFF
  var changeBillOff = false.obs;

  /// つり銭機ON
  var changeCoinOn = true.obs;

  /// つり銭機OFF
  var changeCoinOff = false.obs;

  /// つり札機表示メッセージ
  var changeBillMessage = connectMsg.obs;

  /// つり銭機表示メッセージ
  var changeCoinMessage = connectMsg.obs;

  /// コモンコントローラー
  final CommonController commonctrl = Get.find();
  
  @override
  void onInit() {
    super.onInit();
    statusType.value = CommonController.changeStatusType;
    // 釣機ON/OFF画面の値を取得
    switch (statusType.value) {
    case ChangeType.coinOff:
      _setChangeBtnStatus(true, false);
      break;
    case ChangeType.billOff:
      _setChangeBtnStatus(false, true);
      break;
    case ChangeType.none:
      _setChangeBtnStatus(false, false);
      break;
    case ChangeType.all:
      _setChangeBtnStatus(true, true);
      break;
   }
  }

  /// 釣札機、釣銭機のボタン状態を設定する
  void _setChangeBtnStatus(bool billOn, bool coinOn) {
    changeBillOn.value = billOn;
    changeBillOff.value = !changeBillOn.value;
    changeCoinOn.value = coinOn;
    changeCoinOff.value = !changeCoinOn.value;
    changeBillMessage.value = billOn ? connectMsg : noConnectMsg;
    changeCoinMessage.value = coinOn ? connectMsg : noConnectMsg;
  }

  /// 処理概要：釣機ON/OFFボタン押下時ダイアログ表示処理
  /// パラメータ：釣機ON/OFFの値、ON（true）またはOFF（false）、釣札機（0）または釣銭機（1）
  /// 戻り値：なし
  void pushChangeButton(bool change, bool onOrOff, int changeBill) {
    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_EXECCONF.dlgId,
        leftBtnFnc: () {
          Get.back();
        },
        leftBtnTxt: "いいえ",
        rightBtnFnc: () async {
          Get.back();
          int errNo = Cpwr.setChangeStatus(changeBill, onOrOff ? 1 : 0);
          if(errNo != 0) {
            // エラーが発生した場合、エラーダイアログを表示
            MsgDialog.show(
              MsgDialog.singleButtonDlgId(
                type: MsgDialogType.error,
                dialogId: errNo,
              ),
            );
          } else {
            if (changeBill == 0) {
              // 釣札機
              if (onOrOff == true) {
                // 釣札機ON
                changeBillOnSwitch(change);
              } else {
                // 釣札機OFF
                changeBillOffSwitch(change);
              }
            } else {
              // 釣銭機
              if (onOrOff == true) {
                // 釣銭機ON
                changeCoinOnSwitch(change);
              } else {
                // 釣銭機OFF
                changeCoinOffSwitch(change);
              }
            }
          checkChangeType();
          }
        },
        rightBtnTxt: "はい",
      ),
    );
  }

  /// 処理概要：つり札機ONボタン押下時のON/OFF切り替え処理
  /// パラメータ：つり札機ON/OFFの値
  /// 戻り値：なし
  void changeBillOnSwitch(bool change) {
    changeBillOn.value = !change;
    changeBillOff.value = !changeBillOn.value;
    changeBillMessage.value = change ? noConnectMsg : connectMsg;
  }

  /// 処理概要：つり札機OFFボタン押下時のON/OFF切り替え処理
  /// パラメータ：つり札機ON/OFFの値
  /// 戻り値：なし
  void changeBillOffSwitch(bool change) {
    changeBillOn.value = change;
    changeBillOff.value = !changeBillOn.value;
    changeBillMessage.value = change ? connectMsg : noConnectMsg;
  }

  /// 処理概要：つり銭機ONボタン押下時のON/OFF切り替え処理
  /// パラメータ：つり札機ON/OFFの値
  /// 戻り値：なし
  void changeCoinOnSwitch(bool change) {
    changeCoinOn.value = !change;
    changeCoinOff.value = !changeCoinOn.value;
    changeCoinMessage.value = change ? noConnectMsg : connectMsg;
  }

  /// 処理概要：つり銭機OFFボタン押下時のON/OFF切り替え処理
  /// パラメータ：つり札機ON/OFFの値
  /// 戻り値：なし
  void changeCoinOffSwitch(bool change) {
    changeCoinOn.value = change;
    changeCoinOff.value = !changeCoinOn.value;
    changeCoinMessage.value = change ? connectMsg : noConnectMsg;
  }

  /// つり機ON/OFFのタイプ確認
  /// パラメータ：なし
  /// 戻り値：なし
  void checkChangeType() {
    if (changeBillOn.value && changeCoinOn.value) {
      // 両機ON
      statusType.value = ChangeType.all;
      CommonController.changeStatusType = statusType.value;
      commonctrl.removeDisplayStatus();
      debugPrint('両機ON:${statusType.value}');
    } else if (changeBillOn.value && !(changeCoinOn.value)) {
      // 釣札機のみON
      statusType.value = ChangeType.coinOff;
      CommonController.changeStatusType = statusType.value;
      commonctrl.removeDisplayStatus();
      commonctrl.addStatus(StatusType.coinOff);
      debugPrint('釣札機のみON:${statusType.value}');
    } else if (!(changeBillOn.value) && changeCoinOn.value) {
      // 釣銭機のみON
      statusType.value = ChangeType.billOff;
      CommonController.changeStatusType = statusType.value;
      commonctrl.removeDisplayStatus();
      commonctrl.addStatus(StatusType.billOff);
      debugPrint('釣銭機のみON:${statusType.value}');
    } else {
      // 両機OFF
      statusType.value = ChangeType.none;
      CommonController.changeStatusType = statusType.value;
      commonctrl.removeDisplayStatus();
      commonctrl.addStatus(StatusType.notChange);
      debugPrint('両機OFF:${statusType.value}');
    }
  }
}
