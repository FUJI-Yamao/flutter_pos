/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/number_util.dart';
import '../../../../regs/checker/rcky_cin.dart';
import '../../../component/w_inputbox.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/component/w_register_tenkey.dart';

/// 釣機入金画面のコントローラ
class ChangeCoinInInputController extends GetxController {
  /// コンストラクタ
  ChangeCoinInInputController()
      : inputBoxKey = GlobalKey<InputBoxWidgetState>();

  /// 入力boxの状態を管理するためのGlobalKey
  final GlobalKey<InputBoxWidgetState> inputBoxKey;

  /// 釣銭機に入金した金額
  var receivePrc = 0.obs;

  /// 最終入金額
  var coinInPrc = 0.obs;

  /// おつり
  var change = 0.obs;

  /// 表示中の入金額（実際に入金される金額）
  var currentCoinInPrc = 0.obs;

  /// 編集した入金額（実際に入金したい金額）
  var inputCoinInPrc = 0.obs;

  /// テンキー表示フラグ
  var showRegisterTenkey = false.obs;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = true.obs;

  /// 入金額桁数
  static const int coinInPrcNumLength = 7;

  /// タップした入力boxから文字列取得処理
  String getNowStr() {
    InputBoxWidgetState? state = inputBoxKey.currentState;
    return state?.inputStr ?? "";
  }

  /// 一文字削除処理
  void _deleteOneChar() {
    String value = getNowStr();
    if (value.isEmpty) return;

    inputBoxKey.currentState?.onDeleteOne();
  }

  /// Cをタップされた場合のクリア関数
  void _clearString() {
    inputBoxKey.currentState?.onDeleteAll();
  }

  /// 金額欄入力範囲
  /// value   範囲チェック文字列
  bool isValueInRange(String value) {
    if (value.isEmpty) {
      return false;
    }
    int intValue = int.tryParse(value) ?? 0;
    return intValue <= receivePrc.value;
  }

  /// 入金額の入力処理.
  /// key   キー種別
  void _handleOtherKeys(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;

    // 0開始の数値は入力させないため処理中断
    if ((currentValue.isEmpty || currentValue == "0") &&
        (keyValue == "0" || keyValue == "00")) {
      return;
    }

    if (!_isValidNumberInput(currentValue, keyValue, coinInPrcNumLength)) {
      _showErrorMessage("入力上限額は9,999,999円までです");
      return;
    }

    String newValue = currentValue + keyValue;
    if (isValueInRange(newValue)) {
      currentValue += keyValue;
      inputBoxKey.currentState?.onChangeStr(currentValue);
    } else {
      _showErrorMessage("入金額がお預かり金額を超えています");
      return;
    }
  }

  /// キータイプに応じた入力処理
  /// key   キー種別
  Future<void> inputKeyType(KeyType key) async {
    if(!showRegisterTenkey.value){
      return;
    }
    switch (key) {
      case KeyType.delete:
        _deleteOneChar();
        break;
      case KeyType.check:
        _decideButtonPressed();
        break;
      case KeyType.clear:
        _clearString();
        break;
      default:
        // タップ直後は文字入力時に古い内容をクリアする
        if (isFirstInput.value) {
          // 0開始の値は設定できないため処理中断
          if (key.name == '0' || key.name == '00') {
            return;
          }
          // 一文字でも入力したらクリアしないようにフラグ削除
          isFirstInput.value = false;
          _clearString();
        }
        _handleOtherKeys(key);
        break;
    }
  }

  /// 一文字削除処理
  /// isNotFrcSelect   金種別登録しないか否か
  void _deleteOneCharForFrcSelect(bool isNotFrcSelect) {
    String value = getNowStr();
    if (value.isEmpty) return;

    inputBoxKey.currentState?.onDeleteOne();

    if (isNotFrcSelect) {
      receivePrc.value = int.tryParse(getNowStr()) ?? 0;
    }
  }

  /// Cをタップされた場合のクリア関数
  /// isNotFrcSelect   金種別登録しないか否か
  void _clearStringForFrcSelect(bool isNotFrcSelect) {
    inputBoxKey.currentState?.onDeleteAll();

    if (isNotFrcSelect) {
      receivePrc.value = 0;
    }
  }

  /// 入金額の入力処理.
  /// key   キー種別
  /// isNotFrcSelect   金種別登録しないか否か
  void _handleOtherKeysForFrcSelect(KeyType key, bool isNotFrcSelect) {
    String currentValue = getNowStr();
    String keyValue = key.name;

    // 0開始の数値は入力させないため処理中断
    if ((currentValue.isEmpty || currentValue == "0") &&
        (keyValue == "0" || keyValue == "00")) {
      return;
    }

    if (!_isValidNumberInput(currentValue, keyValue, coinInPrcNumLength)) {
      _showErrorMessage("入力上限額は9,999,999円までです");
      return;
    }

    String newValue = currentValue + keyValue;

    if (isNotFrcSelect) {
      currentValue += keyValue;
      inputBoxKey.currentState?.onChangeStr(currentValue);

      receivePrc.value = int.tryParse(currentValue) ?? 0;
      return;
    }

    if (isValueInRange(newValue)) {
      currentValue += keyValue;
      inputBoxKey.currentState?.onChangeStr(currentValue);
    } else {
      _showErrorMessage("入金額がお預かり金額を超えています");
      return;
    }
  }

  /// キータイプに応じた入力処理
  /// key   キー種別
  /// isNotFrcSelect   金種別登録しないか否か
  Future<void> inputKeyTypeForFrcSelect(KeyType key, bool isNotFrcSelect) async {
    if(!showRegisterTenkey.value){
      return;
    }
    switch (key) {
      case KeyType.delete:
        _deleteOneCharForFrcSelect(isNotFrcSelect);
        break;
      case KeyType.check:
        _decideButtonPressed();
        break;
      case KeyType.clear:
        _clearStringForFrcSelect(isNotFrcSelect);
        break;
      default:
        // タップ直後は文字入力時に古い内容をクリアする
        if (isFirstInput.value) {
          // 0開始の値は設定できないため処理中断
          if (key.name == '0' || key.name == '00') {
            return;
          }
          // 一文字でも入力したらクリアしないようにフラグ削除
          isFirstInput.value = false;
          _clearStringForFrcSelect(isNotFrcSelect);
        }
        _handleOtherKeysForFrcSelect(key, isNotFrcSelect);
        break;
    }
  }

  /// 番号入力条件
  /// currentValue  現在の入力内容
  /// keyValue      キー入力された内容
  /// maxLength     最大入力桁数
  bool _isValidNumberInput(
      String currentValue, String keyValue, int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) return false;

    if ((currentValue.isEmpty || currentValue == "0") &&
        (keyValue == "0" || keyValue == "00")) {
      return false;
    }
    return true;
  }

  /// エラーダイアログ表示処理（引数：メッセージ）
  void _showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );
  }

  /// 更新フォーカス.
  void updateFocus() {
    showRegisterTenkey.value = true;
    inputBoxKey.currentState?.setCursorOn();
  }

  /// 入力ボックスがタップされた時の処理.
  /// テンキーを表示する、フォーカスをon
  void onInputBoxTap() {
    updateFocus();
    showRegisterTenkey.value = true;
    // タップ直後は文字入力時に古い内容をクリアする
    isFirstInput.value = true;
    inputBoxKey.currentState?.setCursorOn();
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor() {
    inputBoxKey.currentState?.setCursorOff();
  }

  /// テンキーの「決定」ボタンで入金完了の処理
  void _decideButtonPressed() {
    _closeCurrentCursor();
    showRegisterTenkey.value = false;
    String? input = inputBoxKey.currentState!.inputStr;
    inputCoinInPrc.value =
        int.tryParse(input.replaceAll(',', '').replaceAll('¥', '')) ?? 0;
    currentCoinInPrc.value = inputCoinInPrc.value;
  }

  /// お預かり金額を設定する
  void setReceivedProc(int amount) {
    receivePrc.value = amount;
    if ((inputCoinInPrc.value == 0) && (showRegisterTenkey.value == false)) {
      currentCoinInPrc.value = amount;
      inputBoxKey.currentState!.onChangeStr(NumberFormatUtil.formatAmount(amount));
    }
  }
}
