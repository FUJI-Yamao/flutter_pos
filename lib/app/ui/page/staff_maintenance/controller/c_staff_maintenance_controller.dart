/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/component/w_inputbox.dart';
import 'package:flutter_pos/app/ui/page/subtotal/component/w_register_tenkey.dart';
import 'package:get/get.dart';

import '../../common/component/w_msgdialog.dart';
import '../../subtotal/controller/c_subtotal_controller.dart';

///メンテナンス画面のコントローラ
class StaffMaintenanceController extends GetxController {
  ///コンストラクタ
  StaffMaintenanceController() : inputBoxKey = GlobalKey<InputBoxWidgetState>();

  ///入力boxの状態を管理ためのGlobalKey
  final GlobalKey<InputBoxWidgetState> inputBoxKey;

  ///テンキー表示フラグ
  var showRegisterTenkey = false.obs;

  ///合計金額桁数
  static const int staffMaintenanceNumLength = 7;

  ///合計マックス金額
  static const int staffMaintenanceAmountMax = 99999999;

  SubtotalController subtotalCtrl = Get.find();

  /// 合計額
  var currentTotalAmount = 0.obs;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = true.obs;


  ///　タップした入力boxから文字列取得処理
  String getNowStr() {
    InputBoxWidgetState? state = inputBoxKey.currentState;
    return state?.inputStr ?? "";
  }

  /// 一文字削除処理.
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
  bool isValueInRange(String value) {
    if (value.isEmpty) {
      return false;
    }
    int intValue = int.tryParse(value) ?? 0;
    return (intValue >= -staffMaintenanceAmountMax) &&
        (intValue <= staffMaintenanceAmountMax);
  }

  ///金額入力処理.
  void _handleOtherKeys(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;

    // 0開始の数値は入力させないため処理中断
    if ((currentValue.isEmpty || currentValue == KeyType.zero.name) &&
        (keyValue == KeyType.zero.name ||
            keyValue == KeyType.doubleZero.name)) {
      return;
    }

    if (!_isValidNumberInput(
        currentValue, keyValue, staffMaintenanceNumLength)) {
      _showErrorMessage("入力上限額は9,999,999円までです");
      return;
    }
    if (currentValue.isEmpty && key == KeyType.doubleZero) return;

    if (currentValue == KeyType.zero.name && key != KeyType.doubleZero) {
      currentValue = "";
    }
    String newValue = currentValue + keyValue;
    if (isValueInRange(newValue)) {
      currentValue += keyValue;
      inputBoxKey.currentState?.onChangeStr(currentValue);
    } else {
      return;
    }
  }

  ///キータイプに応じた入力処理.
  Future<void> inputKeyType(KeyType key) async {
    if (!showRegisterTenkey.value) {
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
          // 一文字でも入力したらクリアしないようにフラグ削除
          isFirstInput.value = false;
          _clearString();
        }
        _handleOtherKeys(key);
        break;
    }
  }

  /// 番号入力条件
  bool _isValidNumberInput(
      String currentValue, String keyValue, int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) return false;

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
    isFirstInput.value = true;
    inputBoxKey.currentState?.setCursorOn();
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor() {
    inputBoxKey.currentState?.setCursorOff();
  }

  ///テンキーの「決定」ボタン
  void _decideButtonPressed() {
    _closeCurrentCursor();
    showRegisterTenkey.value = false;
  }
}