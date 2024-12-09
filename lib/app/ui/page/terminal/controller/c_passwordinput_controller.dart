/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../component/w_inputbox.dart';
import '../../maintenance/specfile/controller/c_key_controller_base.dart';

/// テンキー用コントローラー
class PassWordTenkeyController extends KeyControllerBase {
  /// テンキーのタイトルを表す文字列
  String strTitle = '';
  /// 初期値がチェックされているかどうかを示すフラグ
  bool isIniValChecked = true;
  /// 入力ボックスウィジェットのグローバルキー
  final GlobalKey<InputBoxWidgetState> inputBox;


  PassWordTenkeyController(this.inputBox, this.minValue, this.maxValue);
  /// テンキーコントローラーの最小許容値
  final int minValue;
  /// テンキーコントローラーの最大許容値
  final int maxValue;

  /// 現在の入力文字列を取得する
  String getNowStr(){
    InputBoxWidgetState? state = inputBox.currentState;
    return state?.inputStr ?? "";
  }

  /// 入力されている文字列に[strVal]を追加する
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
    int? val = int.parse(getNowStr() + strVal);
    if (val <= maxValue) {
      return true;
    }
    return false;
  }

  /// 入力されている内容が指定の範囲内に収まっているか
  @override
  bool checkWithInRange(){
    int? val = int.tryParse(getNowStr());
    if (val != null && val >= minValue && val <= maxValue) {
      return true;
    }
    return false;
  }

  /// 文字クリア関数
  @override
  void clearString() {
    inputBox.currentState?.onDeleteAll();
  }

  /// 一文字削除関数
  @override
  void deleteOneChar() {
    inputBox.currentState?.onDeleteOne();
  }

  @override
  void tabKey(bool addCalc) {
    // 何もしない
  }

  /// 入力された数値を処理し、上限の範囲内であれば文字列に追加する
  @override
  void pushInputKey(dynamic num){
    bool valid = checkOverLimit(num.toString());
    if(!valid){
      clearString();
    }else{
      addString(num.toString());
    }
  }
}