/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../menu/register/m_menu.dart';
import '../enum/e_registration_input_enum.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../../../component/w_inputbox.dart';
import '../../../../inc/apl/fnc_code.dart';
import 'c_registration_scan_ctrl.dart';

///通番訂正入力コントローラ
class RegistrationInputController extends GetxController {
  ///コンストラクタ
  RegistrationInputController({
    required List<RegistrationInputFieldLabel> labels});

  bool lblAddFlg = false;    //入力項目追加フラグ

  final RegistrationScanController registScanCtrl = Get.find();

  /// テンキー表示フラグ
  var showRegisterTenkey = true.obs;

  ///「決定」ボタン表示フラグ
  var showDecisionButton = false.obs;

  /// 編集している入力boxの位置. 0始まり
  int inputBoxPosition = 0;

  /// 現在の入力フィールドタイプ.
  InputFieldType currentFieldType = InputFieldType.none;

  /// レジ番号桁数
  static const int registerNumLength = 6;

  /// レシート番号桁数
  static const int registrationNumLength = 4;

  /// 各ラベルの状態を管理ためのG入力フィールドラベル.
  var labels = <RegistrationInputFieldLabel>[].obs;

  /// 各入力boxの状態を管理ためのGlobalKeyリスト
  var inputBoxList = <GlobalKey<InputBoxWidgetState>>[].obs;

  /// 画面のタイトル
  late String title;

  /// バーコードスキャンで取得した値を保持するリスト
  List<String> initValues = [];

  /// タップした入力boxから文字列取得処理
  String getNowStr() {
    if (inputBoxPosition < 0 || inputBoxPosition >= inputBoxList.length) {
      return "";
    }
    InputBoxWidgetState? state = inputBoxList[inputBoxPosition].currentState;
    return state?.inputStr ?? "";
  }

  /// 一文字削除処理
  void _deleteOneChar() {
    String value = getNowStr();
    if (value.isEmpty) {
      if (0 < inputBoxPosition) {
        updateFocus(inputBoxPosition - 1);
        if (getNowStr().isNotEmpty) {
          _deleteOneChar();
        }
      }
      return;
    }
    inputBoxList[inputBoxPosition].currentState?.onDeleteOne();
  }

  /// Cをタップされた場合のクリア関数
  void _clearString() {
    inputBoxList[inputBoxPosition].currentState?.onDeleteAll();
  }

  /// キータイプに応じた入力処理
  void inputKeyType(KeyType key) {
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
        _handleOtherKeys(key);
        break;
    }
  }

  /// 入力画面の追加項目を生成する
  void quickPayProcessExcute() {
    initLabels(labels);
    showDecisionButton.value = allInput();
  }

  /// ラベル初期化
  void initLabels(List<RegistrationInputFieldLabel> initalLabels) {
    labels.assignAll(initalLabels);
    updateInputBoxList();
  }

  /// ラベル追加
  void addlabels(RegistrationInputFieldLabel label) {
    labels.add(label);
    updateInputBoxList();
  }

  /// InputBoxList更新し、既存の入力ボックスの状態を保持する
  void updateInputBoxList() {
    var newInputBoxList = <GlobalKey<InputBoxWidgetState>>[];
    for (var i = 0; i < labels.length; i++) {
      if (i < inputBoxList.length) {
        newInputBoxList.add(inputBoxList[i]);
      } else {
        newInputBoxList.add(GlobalKey<InputBoxWidgetState>());
      }
    }
    inputBoxList.value = newInputBoxList;
  }

  /// フィールドタイプに基づいた入力処理.
  void _handleOtherKeys(KeyType key) {
    switch (currentFieldType) {
      case InputFieldType.registerNum:
        _handleRegisterNumInput(key);
        break;
      case InputFieldType.receiptNum:
        _handleReceiptNumInput(key);
      default:
        break;
    }
  }

  /// 更新フォーカス.
  void updateFocus(int focusedIndex) {
    if (inputBoxPosition >= 0 && inputBoxPosition < inputBoxList.length) {
      inputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
    inputBoxPosition = focusedIndex;
    currentFieldType = labels[focusedIndex].fieldType;
    inputBoxList[inputBoxPosition].currentState?.setCursorOn();
  }

  /// 入力ボックスがタップされた時の処理.
  void onInputBoxTap(int focusedIndex) {
    updateFocus(focusedIndex);
    showRegisterTenkey.value = true;
    showDecisionButton.value = false;
    inputBoxList[focusedIndex].currentState?.setCursorOn();
  }

  /// レジ番号入力処理.
  void _handleRegisterNumInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (!_isValidNumberInput(currentValue, keyValue, registerNumLength)) {
      _showErrorMessage("6桁以下の数字を入力してください。");
      return;
    }
    inputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  /// レシート番号入力処理.
  void _handleReceiptNumInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (!_isValidNumberInput(currentValue, keyValue, registrationNumLength)) {
      /// 仮のメッセージ内容
      _showErrorMessage("4桁以下の数字を入力してください。");
      return;
    }
    inputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor() {
    if (inputBoxPosition >= 0 && inputBoxPosition < inputBoxList.length) {
      inputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
  }

  /// 全ての入力欄が入力したかどうかのチェック処理
  bool allInput() {
    for (var inputBoxStateKey in inputBoxList) {
      var inputStr = inputBoxStateKey.currentState?.inputStr ?? "";
      if (inputStr.isEmpty) {
        return false;
      }
    }
    return true;
  }

  /// エラーダイアログ表示処理
  /// 引数:エラーメッセージ
  void _showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );

  }

  /// 番号入力条件
  bool _isValidNumberInput(String currentValue, String keyValue,
      int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) {
      return false;
    }
    return true;
  }

  ///「決定」ボタンでカーソル移動
  void _decideButtonPressed() {
    int pos = inputBoxPosition;
    if (pos < inputBoxList.length - 1) {
      pos++;
      updateFocus(pos);
    } else {
      if (allInput()) {
        showRegisterTenkey.value = false;
        showDecisionButton.value = true;
        _closeCurrentCursor();
        return;
      } else {
        _closeCurrentCursor();
        showRegisterTenkey.value = false;
      }
      return;
    }
  }

  ///「実行」ボタン押下する処理（仮）
  Future<void> onDecisionButtonPressed(FuncKey funcKey) async {
    ///TODO バックエンドに受け渡す処理を入れること
    SetMenu1.navigateToRegisterPage();
  }
}
