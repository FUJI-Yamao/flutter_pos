/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/number_util.dart';
import 'package:flutter_pos/app/ui/component/w_inputbox.dart';
import 'package:flutter_pos/app/ui/page/subtotal/component/w_register_tenkey.dart';
import 'package:get/get.dart';
import '../../../../common/date_util.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../common/component/w_msgdialog.dart';
import '../enum/e_EJconf_enum.dart';

///記録確認入力コントローラ
class EJconfInputController extends GetxController {
  ///各入力boxの状態を管理ためのGlobalKeyリスト
  final List<GlobalKey<InputBoxWidgetState>> ejconfinputBoxList;

  final List<EJconfInputFieldLabel> labels;

  ///コンストラクタ
  EJconfInputController({
    required this.ejconfinputBoxList,
    required this.labels,
  });

  ///テンキー表示フラグ
  var showRegisterTenkey = false.obs;

  /// 「決定」ボタン表示フラグ
 // var showDecisionButton = false.obs;

  /// 編集している入力boxの位置. 0始まり
  int inputBoxPosition = 0;

  /// 現在の入力フィールドタイプ.
  EJconfInputFieldType currentFieldType = EJconfInputFieldType.none;

  ///レジ番号桁数
  static const int registerNumLength = 6;

  ///レシート番号桁数
  static const int receiptNumLength = 4;

  ///日付の有効ステータス
  var isCurrentDateValid = true.obs;

  ///日付の初期値
  static const String initDateStr = '00000000';
  ///時間の初期値
  static const String initTimeStr = '0000';
  ///レシート番号の初期値
  static const String initReceiptNumStr = '0000';
  ///レジ番号の初期値
  static const String initRegisterNumStr = '000000';

  ///　タップした入力boxから文字列取得処理
  String getNowStr() {
    if (inputBoxPosition < 0 || inputBoxPosition >= ejconfinputBoxList.length) {
      return "";
    }
    InputBoxWidgetState? state =
        ejconfinputBoxList[inputBoxPosition].currentState;
    return state?.inputStr ?? "";
  }

  ///初期データ共通のTextStyle
  static TextStyle commonInitStrTextStyle() {
    return TextStyle(
      fontSize: BaseFont.font28px,
      fontFamily: BaseFont.familyDefault,
      color: BaseColor.baseColor.withOpacity(0.5),
    );
  }

  /// 一文字削除処理.
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
    ejconfinputBoxList[inputBoxPosition].currentState?.onDeleteOne();
  }

  /// Cをタップされた場合のクリア関数
  void _clearString() {
    ejconfinputBoxList[inputBoxPosition].currentState?.onDeleteAll();
  }

  ///キータイプに応じた入力処理.
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

  ///フィールドタイプに基づいた入力処理.
  void _handleOtherKeys(KeyType key) {
    switch (currentFieldType) {
      case EJconfInputFieldType.date:
        _handleDateInput(key);
        break;
      case EJconfInputFieldType.registerNum:
        _handleRegisterNumInput(key);
        break;
      case EJconfInputFieldType.receiptNum:
        _handleReceiptNumInput(key);
        break;
      case EJconfInputFieldType.time:
        _handleTimeInput(key);
        break;
      case EJconfInputFieldType.word:
        break;
      default:
        break;
    }
  }

  /// 更新フォーカス.
  void updateFocus(int focusedIndex) {
    if (inputBoxPosition >= 0 && inputBoxPosition < ejconfinputBoxList.length) {
      ejconfinputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
    showRegisterTenkey.value = true;
    inputBoxPosition = focusedIndex;
    currentFieldType = labels[focusedIndex].EjconfieldType;
    ejconfinputBoxList[inputBoxPosition].currentState?.setCursorOn();
    ejconfinputBoxList[focusedIndex].currentState?.toggleUseInitStrTextStyle();
  }

  /// 入力ボックスがタップされた時の処理.
  void onInputBoxTap(int focusedIndex) {
    if (currentFieldType == EJconfInputFieldType.date) {
      final currentDateStr = getNowStr();
      if (!checkAndShowDateValidity(currentDateStr)) {
        return;
      }
    }
    updateFocus(focusedIndex);
    _setInputBoxEmpty();
    showRegisterTenkey.value = true;
    //showDecisionButton.value = false;
    ejconfinputBoxList[focusedIndex].currentState?.setCursorOn();
    ejconfinputBoxList[focusedIndex].currentState?.toggleUseInitStrTextStyle();
  }

  /// 入力ボックスの値が初期値の場合、値を空にする
  ///   例えば初期状態から'00:00'を設定した場合は初期値'0000'とは
  ///   異なっているので空にしない。
  void _setInputBoxEmpty() {
    String targetInitStr = '';
    final currentStr = getNowStr();

    switch (currentFieldType) {
      case EJconfInputFieldType.date:
        targetInitStr = initDateStr;
        break;
      case EJconfInputFieldType.time:
        targetInitStr = initTimeStr;
        break;
      case EJconfInputFieldType.receiptNum:
        targetInitStr = initReceiptNumStr;
        break;
      case EJconfInputFieldType.registerNum:
        targetInitStr = initRegisterNumStr;
        break;
      default:
        return;
    }

    /// 初期値の場合は値を空にする
    if (currentStr.compareTo(targetInitStr) == 0) {
      _clearString();
    }
  }

  /// 日付フォーマット処理
  String _formatDate(String dateStr) {
    if (dateStr.length >= 4) {
      String year = dateStr.substring(0, 4);
      String month = '';
      String day = '';

      if (dateStr.length > 4) {
        int monthLength = dateStr.length >= 6 ? 2 : dateStr.length - 4;
        month = dateStr.substring(4, 4 + monthLength);
      }
      if (dateStr.length > 6) {
        day = dateStr.substring(6);
      }
      return year +
          (month.isNotEmpty ? "/$month" : "") +
          (day.isNotEmpty ? "/$day" : "");
    } else {
      return dateStr;
    }
  }

  ///テンキー入力の日付が正確の日付かどうか
  bool isValidDate(String dateStr) {
    String formattedDate = _formatDate(dateStr);

    try {
      final date = DateTime.tryParse(formattedDate.replaceAll('/', '-'));
      if (date == null) return false;

      final inputParts = formattedDate.split('/');
      final inputYear = int.parse(inputParts[0]);
      final inputMonth = int.parse(inputParts[1]);
      final inputDay = int.parse(inputParts[2]);

      bool isValid = date.year == inputYear &&
          date.month == inputMonth &&
          date.day == inputDay;

      return isValid;
    } catch (e) {
      debugPrint('解析日付エラー： $e');
      return false;
    }
  }

  ///日付チェックの関数、９９日以内かと正確の日付なのか
  bool checkAndShowDateValidity(String dateStr) {
    final currentDate = getNowStr();
    String formatDate = _formatDate(currentDate);
    if (!isValidDate(currentDate)) {
      isCurrentDateValid.value = isValidDate(formatDate) &&
          DateUtil.isDateWithinRange(formatDate, DateUtil.daysIn99);

      if (!isCurrentDateValid.value) {
        _showErrorMessage("正しい日付を入力してください");
        return false;
      }
    }

    if (!DateUtil.isDateWithinRange(formatDate, DateUtil.daysIn99)) {
      _showErrorMessage("99日以内の日付を入力してください");

      return false;
    }
    return true;
  }

  /// 日付入力処理.
  void _handleDateInput(KeyType key) {
    String currentValue = getNowStr();
    if (currentValue.length >= 8) return;
    if (key == KeyType.zero || key == KeyType.doubleZero) {
      if (currentValue.isEmpty) return;
    }
    currentValue += key.name;
    ejconfinputBoxList[inputBoxPosition]
        .currentState
        ?.onChangeStr(currentValue);

    if (currentValue.length == 10) {
      checkAndShowDateValidity(currentValue);
    }
  }

  ///　レジ番号入力処理.
  void _handleRegisterNumInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (!_isValidNumberInput(currentValue, keyValue, registerNumLength)) {
      _showErrorMessage("レジ番号は6桁の数字でなければなりません。");
      return;
    }
    ejconfinputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  ///　レシート番号入力処理.
  void _handleReceiptNumInput(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (!_isValidNumberInput(currentValue, keyValue, receiptNumLength)) {
      /// 仮のメッセージ内容
      _showErrorMessage("レシート番号は4桁の数字でなければなりません。");
      return;
    }
    ejconfinputBoxList[inputBoxPosition].currentState?.onAddStr(keyValue);
  }

  ///　時間入力処理.
  void _handleTimeInput(KeyType key) {
    String currentValue =
        ejconfinputBoxList[inputBoxPosition].currentState?.inputStr ?? '';
    String keyValue = key.name;

    if (keyValue.isNotEmpty &&
        currentValue.replaceAll(RegExp(r'\D'), '').length < 4) {
      currentValue += keyValue;
    }

    String formatted =
        NumberFormatUtil.formatTime(currentValue.replaceAll(RegExp(r'\D'), ''));

    ejconfinputBoxList[inputBoxPosition].currentState?.onChangeStr(formatted);
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor() {
    if (inputBoxPosition >= 0 && inputBoxPosition < ejconfinputBoxList.length) {
      ejconfinputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
  }

  /// 全ての入力欄が入力したかどうかのチェック処理
  bool allInput() {
    for (var inputBoxStateKey in ejconfinputBoxList) {
      var inputStr = inputBoxStateKey.currentState?.inputStr ?? "";
      if (inputStr.isEmpty) {
        return false;
      }
    }
    return true;
  }

  /// エラーダイアログ表示処理
  void _showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );
  }

  /// 番号入力条件
  bool _isValidNumberInput(
      String currentValue, String keyValue, int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) return false;

    if ((currentValue.isEmpty || currentValue == "0") &&
        (keyValue == "0" || keyValue == "00")) {
      return false;
    }
    return true;
  }

  ///「決定」ボタンでカーソル移動 とテンキー入力の日付チェック
  void _decideButtonPressed() {
    if (currentFieldType == EJconfInputFieldType.date) {
      final currentDateStr = getNowStr();
      if (!checkAndShowDateValidity(currentDateStr)) {
        return;
      }
    }
    int pos = inputBoxPosition;
    if (pos < ejconfinputBoxList.length - 1) {
      pos++;
      updateFocus(pos);
      _setInputBoxEmpty();
    } else {
      if (allInput()) {
        showRegisterTenkey.value = false;
       // showDecisionButton.value = true;
        _closeCurrentCursor();
        return;
      } else {
        _closeCurrentCursor();
        showRegisterTenkey.value = false;
      }
      return;
    }
  }

  /// カレンダー画面「決定する」ボタン処理
  void moveFocusToNextInputBox() {
    int pos = inputBoxPosition;
    if (pos < ejconfinputBoxList.length - 1) {
      updateFocus(pos + 1);
      _setInputBoxEmpty();
    }
  }
}
