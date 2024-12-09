/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../inc/sys/tpr_dlg.dart';
import '../../../../component/w_inputbox.dart';
import '../../../common/component/w_msgdialog.dart';
import 'c_key_controller_base.dart';

/// 承認キー　16進数入力テンキー用コントローラー
class TenkeyRecogController extends KeyControllerBase {

  final GlobalKey<InputBoxWidgetState> inputBox;

  TenkeyRecogController(this.inputBox, this.minValue, this.maxValue);
  final int minValue;
  final int maxValue;


  String getNowStr(){
    InputBoxWidgetState? state = inputBox.currentState;
    return state?.inputStr ?? "";
  }

  /// 承認キーは桁数チェック.
  /// 上限までの入力を許可する.
  @override
  void addString(String strVal) {
    if (checkOverLimit(strVal)) {
      inputBox.currentState?.onAddStr(strVal);
    }
  }
  /// 入力されている内容が上限の範囲内か
  @override
  bool checkOverLimit(String strVal){
    int length = getNowStr().length + strVal.length;
    if (length <= maxValue) {
      return true;
    }
    return false;
  }

  /// 入力されている内容が指定の範囲内に収まっているか.
  @override
  bool checkWithInRange(){
    int val = getNowStr().length;
    if (val != null && val >= minValue && val <= maxValue) {
      return true;
    }
    return false;
  }

  @override
  void pushInputKey( dynamic num){
    bool valid = checkOverLimit(num.toString());
    if(!valid){
      MsgDialog.show(
        //todo ダイアログメッセージ確定出来たらdialogKindを追加
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: "$maxValue桁の値を入力してください",
        ),
      );

    }else{
      addString(num.toString());
    }
  }

  @override
  void clearString() {
    // キーなし
  }

  @override
  void deleteOneChar() {
    // キーなし
  }

  @override
  void tabKey(bool addCalc) {
    // キーなし
  }

}