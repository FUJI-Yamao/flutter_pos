/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/cupertino.dart';
import '../../../../component/w_inputbox.dart';
import '../../../common/component/w_msgdialog.dart';
import 'c_key_controller_base.dart';

/// テンキー用コントローラー
class TenkeyController extends KeyControllerBase {
  String strTitle = '';
  bool isIniValChecked = false;
  final GlobalKey<InputBoxWidgetState> inputBox;


  TenkeyController(this.inputBox, this.minValue, this.maxValue);
  final int minValue;
  final int maxValue;

  String getNowStr(){
    InputBoxWidgetState? state = inputBox.currentState;
    return state?.inputStr ?? "";
  }

  /// 入力されている文字列に、[strVal]を追加する.
  /// from,toの範囲内に収まらなくなる場合には追加しない
  @override
  void addString(String strVal) {
    if (int.parse(getNowStr() + strVal) >= minValue &&
        int.parse(getNowStr() + strVal) <= maxValue) {
      inputBox.currentState?.onAddStr(strVal);
    }
  }
  /// 入力されている内容が上限の範囲内か
  @override
  bool checkOverLimit(String strVal){
    int? val = int.tryParse(getNowStr() + strVal);
    if (val != null && val <= maxValue) {
      return true;
    }
    return false;
  }

  /// 入力されている内容が指定の範囲内に収まっているか.
  @override
  bool checkWithInRange(){
    int? val = int.tryParse(getNowStr());
    if (val != null && val >= minValue && val <= maxValue) {
      return true;
    }
    return false;
  }

  // 文字クリア関数
  @override
  void clearString() {
    inputBox.currentState?.onDeleteAll();
  }

  //一文字削除関数
  @override
  void deleteOneChar() {
    inputBox.currentState?.onDeleteOne();
  }

  @override
  void tabKey(bool addCalc) {
    // 何もしない
  }



  @override
  void pushInputKey( dynamic num){
    bool valid = checkOverLimit(num.toString());
    if(!valid){
      MsgDialog.show(
        //todo ダイアログメッセージ確定出来たらdialogKindを追加
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: "$minValueから$maxValueの範囲内の値を入力してください",
        ),
      );

    }else{
      addString(num.toString());
    }
  }
}