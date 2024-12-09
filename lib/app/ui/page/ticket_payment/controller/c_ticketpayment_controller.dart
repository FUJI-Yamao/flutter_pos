/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/number_util.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../../subtotal/controller/c_subtotal_controller.dart';

/// 入力ボックスのインデックス
enum InputBoxIndex {
  ticketAmount, // 券面額
  ticketNumber, // 枚数
}

/// 商品券支払い画面のコントローラ
class TicketPaymentInputController extends GetxController {
  /// コンストラクタ
  TicketPaymentInputController()
      : inputBoxKey1 = GlobalKey<InputBoxWidgetState>(),
        inputBoxKey2 = GlobalKey<InputBoxWidgetState>();

  /// 入力box1の状態を管理するためのGlobalKey
  final GlobalKey<InputBoxWidgetState> inputBoxKey1;

  /// 入力box2の状態を管理するためのGlobalKey
  final GlobalKey<InputBoxWidgetState> inputBoxKey2;

  /// テンキー表示フラグ
  var showRegisterTenkey = false.obs;

  /// 表示テンキーが対応する入力ボックスのindex(左：InputBoxIndex.left、右：InputBoxIndex.right)
  var currentBoxIndex = InputBoxIndex.ticketAmount.obs;

  /// 購入可能メッセージの表示有無
  var isAvailablePurchase = false.obs;

  /// 商品券総額
  var ticketAmount = 0.obs;

  /// 合計額
  RxInt currentTotalAmount = 0.obs;
  /// 現在の商品券の金額
  RxInt currentTicketValue = 0.obs;
  /// 現在の商品券の枚数
  RxInt currentTicketCount = 0.obs;

  /// 左側の入力ボックスが使用できるかどうか
  var isLeftBoxEnabled = false.obs;
  /// 右側の入力ボックスが使用できるかどうか
  var isRightBoxEnabled = false.obs;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = true.obs;

  /// 券面額桁数
  static const int ticketAmountNumLength = 7;

  /// 券面額最大値
  static const int ticketAmountMaxValue = 9999999;

  /// 商品券枚数桁数
  static const int ticketNumberNumLength = 2;

  /// 商品券枚数最大値
  static const int ticketNumberMaxValue = 99;

  /// 商品券支払金額桁数
  static const int ticketPaymentNumLength = 9;

  /// フォントサイズ判定用金額１
  static const int fontSizeAmount1 = 9999999;
  /// フォントサイズ判定用金額２
  static const int fontSizeAmount2 = 99999;

  SubtotalController subtotalCtrl = Get.find();

  /// 券面額フォントサイズ
  var ticketAmountFontSize = BaseFont.font44px.obs;
  /// 商品券合計金額フォントサイズ
  var ticketTotalAmountFontSize = BaseFont.font44px.obs;

  ///商品券支払用
  RxInt crdtEnbleFlg = 0.obs; // 掛売登録  0:しない 1:する
  RxInt frcEntryFlg = 0.obs;  // 預り金額の置数強制  0:しない 1:する 2:確定処理 3:券面のみ
  RxInt mulFlg = 0.obs;       // 乗算登録  0:禁止 1:有効
  RxInt chkAmt = 0.obs;       // 券面金額
  RxInt nochgFlg = 0.obs;     // 釣り銭支払  0:あり 1:なし 2:確認表示 3:使用不可

  /// タップした入力boxから文字列取得処理
  /// index 入力ボックスのインデックス
  String getNowStr(InputBoxIndex index) {
    InputBoxWidgetState? state = index == InputBoxIndex.ticketAmount
        ? inputBoxKey1.currentState
        : inputBoxKey2.currentState;
    return state?.inputStr ?? "";
  }

  /// 一文字削除処理
  /// index 入力ボックスのインデックス
  void _deleteOneChar(InputBoxIndex index) {
    String value = getNowStr(index);
    if (value.isEmpty) return;

    index == InputBoxIndex.ticketAmount
        ? inputBoxKey1.currentState?.onDeleteOne()
        : inputBoxKey2.currentState?.onDeleteOne();
  }

  /// Cをタップされた場合のクリア関数
  /// index 入力ボックスのインデックス
  void _clearString(InputBoxIndex index) {
    index == InputBoxIndex.ticketAmount
        ? inputBoxKey1.currentState?.onDeleteAll()
        : inputBoxKey2.currentState?.onDeleteAll();
  }

  /// 入力範囲チェック
  /// value 範囲チェック文字列
  /// index 入力ボックスのインデックス
  bool isValueInRange(String value, InputBoxIndex index) {
    if (value.isEmpty) {
      return false;
    }
    int intValue = int.tryParse(value) ?? 0;
    if (index == InputBoxIndex.ticketAmount) {
      return intValue >= 0 && intValue <= ticketAmountMaxValue;
    }
    else {
      return intValue >= 0 && intValue <= ticketNumberMaxValue;
    }
  }

  /// エディットボックスの入力処理.
  /// key   キー種別
  /// index 入力ボックスのインデックス
  void _handleOtherKeys(KeyType key, InputBoxIndex index) {
    String currentValue = getNowStr(index);
    String keyValue = key.name;

    // 0開始の数値は入力させないため処理中断
    if ((currentValue.isEmpty || currentValue == KeyType.zero.name) &&
        (keyValue == KeyType.zero.name || keyValue == KeyType.doubleZero.name)) {
      return;
    }

    if (index == InputBoxIndex.ticketAmount && !_isValidNumberInput(currentValue, keyValue, ticketAmountNumLength)) {
      _showErrorMessage("券面額は${NumberFormatUtil.formatAmount(ticketAmountMaxValue)}以下で設定してください。");
      return;
    }
    else if (index == InputBoxIndex.ticketNumber && !_isValidNumberInput(currentValue, keyValue, ticketNumberNumLength)) {
      _showErrorMessage("枚数は$ticketNumberMaxValue枚以下で設定してください。");
      return;
    }

    String newValue = currentValue + keyValue;
    if (isValueInRange(newValue, index)) {
      currentValue += keyValue;
      if (index == InputBoxIndex.ticketAmount) {
        inputBoxKey1.currentState?.onChangeStr(currentValue);
        _setTicketAmountFontSize(int.parse(currentValue));
      }
      else {
        inputBoxKey2.currentState?.onChangeStr(currentValue);
      }
    } else {
      return;
    }
  }

  /// キータイプに応じた入力処理
  /// key   キー種別
  /// index 入力ボックスのインデックス
  Future<void> inputKeyType(KeyType key, InputBoxIndex index) async {
    if(!showRegisterTenkey.value){
      return;
    }
    switch (key) {
      case KeyType.delete:
        _deleteOneChar(index);
        break;
      case KeyType.check:
        _decideButtonPressed(index);
        break;
      case KeyType.clear:
        _clearString(index);
        break;
      default:
        // タップ直後は文字入力時に古い内容をクリアする
        if (isFirstInput.value) {
          // 0開始の値は設定できないため処理中断
          if (key.name == KeyType.zero.name || key.name == KeyType.doubleZero.name) {
            return;
          }
          // 一文字でも入力したらクリアしないようにフラグ削除
          isFirstInput.value = false;
          _clearString(index);
        }
        _handleOtherKeys(key, index);
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
  /// index 入力ボックスのインデックス
  void updateFocus(InputBoxIndex index) {
    showRegisterTenkey.value = true;
    index == InputBoxIndex.ticketAmount
        ? inputBoxKey1.currentState?.setCursorOn()
        : inputBoxKey2.currentState?.setCursorOn();
  }

  /// 入力ボックスがタップされた時の処理.
  /// テンキーを表示する、フォーカスをon
  /// index 入力ボックスのインデックス
  void onInputBoxTap(InputBoxIndex index) {
    index == InputBoxIndex.ticketAmount
    ? inputBoxKey2.currentState?.setCursorOff()
    : inputBoxKey1.currentState?.setCursorOff();

    updateFocus(index);
    showRegisterTenkey.value = true;
    currentBoxIndex.value = index;
    // タップ直後は文字入力時に古い内容をクリアする
    isFirstInput.value = true;
    index == InputBoxIndex.ticketAmount
        ? inputBoxKey1.currentState?.setCursorOn()
        : inputBoxKey2.currentState?.setCursorOn();
  }

  /// 現在の入力boxのカーソルを非表示.
  /// index 入力ボックスのインデックス
  void _closeCurrentCursor(InputBoxIndex index) {
    index == InputBoxIndex.ticketAmount
        ? inputBoxKey1.currentState?.setCursorOff()
        : inputBoxKey2.currentState?.setCursorOff();
  }

  /// テンキーの「決定」ボタンで入金完了の処理
  /// index 入力ボックスのインデックス
  void _decideButtonPressed(InputBoxIndex index) {
    _closeCurrentCursor(index);
    showRegisterTenkey.value = false;
    ticketAmount.value = getTicketPayAmount();

    if (ticketAmount.value > subtotalCtrl.notEnoughAmount.value) {
      isAvailablePurchase.value = true;
    } else {
      isAvailablePurchase.value = false;
    }
    // 左の入力ボックスで決定時、右の入力ボックスが有効ならフォーカスを移動
    if (index == InputBoxIndex.ticketAmount && isRightBoxEnabled.value) {
      onInputBoxTap(InputBoxIndex.ticketNumber);
    }
    _setTicketTotalAmountFontSize();
  }

  /// 商品券の総額を取得する
  int getTicketPayAmount() {
    String? input1 = isLeftBoxEnabled.value
        ? inputBoxKey1.currentState!.inputStr
        : currentTicketValue.value.toString();
    String? input2 = isRightBoxEnabled.value
        ? inputBoxKey2.currentState!.inputStr
        : currentTicketCount.value.toString();

    currentTicketValue.value = input1.isNotEmpty
        ? int.tryParse(input1.replaceAll(',', '').replaceAll('¥', ''))?? 0
        : 0;

    currentTicketCount.value = input2.isNotEmpty
        ? int.tryParse(input2.replaceAll(',', '').replaceAll('¥', ''))?? 0
        : 0;

    return currentTicketValue.value * currentTicketCount.value;
  }

  /// 商品券の券面額欄のフォントサイズを設定する
  /// amount  券面額
  void _setTicketAmountFontSize(int amount) {
    if (amount > 9999) {
      if (isLeftBoxEnabled.value) {
        ticketAmountFontSize.value = BaseFont.font28px;
      }
      else {
        ticketAmountFontSize.value = BaseFont.font18px;
      }
    }
    else {
      if (isLeftBoxEnabled.value) {
        ticketAmountFontSize.value = BaseFont.font44px;
      }
      else {
        ticketAmountFontSize.value = BaseFont.font28px;
      }
    }
  }

  /// 商品券の合計金額欄のフォントサイズを設定する
  void _setTicketTotalAmountFontSize() {
    if (ticketAmount.value > fontSizeAmount1) {
      ticketTotalAmountFontSize.value = BaseFont.font24px;
    } else if (ticketAmount.value > fontSizeAmount2) {
      ticketTotalAmountFontSize.value = BaseFont.font28px;
    } else {
      ticketTotalAmountFontSize.value = BaseFont.font44px;
    }
  }

  /// 商品券の設定値を初期化する
  /// amount  券面額
  /// number  枚数
  void setInitialValue(int amount, int number) {
    currentTicketValue.value = amount;
    currentTicketCount.value = number;
    ticketAmount.value = currentTicketValue.value * currentTicketCount.value;
    _setTicketAmountFontSize(amount);
    _setTicketTotalAmountFontSize();
  }
}
