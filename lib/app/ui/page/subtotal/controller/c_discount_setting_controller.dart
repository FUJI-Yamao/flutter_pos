/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../../regs/common/rxkoptcmncom.dart';
import '../../../component/w_inputbox.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/component/w_register_tenkey.dart';

/// 割引値／引設定画面のコントローラ
class DiscountSettingInputController extends GetxController {

  /// コンストラクタ
  DiscountSettingInputController()
      : inputBoxKey = GlobalKey<InputBoxWidgetState>();

  /// 入力boxの状態を管理するためのGlobalKey
  final GlobalKey<InputBoxWidgetState> inputBoxKey;


  ///確定するボタンを表示するかどうか
  RxBool enableConfirmButton = false.obs;

  /// テンキー表示フラグ
  var showRegisterTenkey = false.obs;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = false.obs;

  /// 画面上の割引値引の最大桁数
  static int maxDiscountValueLength = 5;

  ///割引率／値引額の画面テキスト
  var discountText = ''.obs;

  /// 割引／値引の数値
  var discountValue = 0.obs;

  ///割引／値引の項目名
  var titleText = ''.obs;

  ///割引／値引の判定フラグ
  var discountTypeFlg = 0.obs;

  /// 割引／値引の桁数
  var discountValueLength = maxDiscountValueLength.obs;

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

  /// 数値の入力処理
  /// key   キー種別
  void _handleOtherKeys(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;

    if(discountTypeFlg.value == 0) {
      discountValueLength.value = 7;
    }else if(discountTypeFlg.value == 1) {
      discountValueLength.value = 2;
    }
      if (!_isValidNumberInput(
          currentValue, keyValue, discountValueLength.value)) {
        _showErrorMessage('最大$discountValueLength桁です');
        return;
      }
    currentValue += keyValue;
    inputBoxKey.currentState?.onChangeStr(currentValue);
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
          if (key.name == KeyType.zero.name || key.name == KeyType.doubleZero.name) {
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

  /// 番号入力条件
  /// currentValue  現在の入力内容
  /// keyValue      キー入力された内容
  /// maxLength     最大入力桁数
  bool _isValidNumberInput(
      String currentValue, String keyValue, int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) {
      return false;
    }
    return true;
  }

  /// エラーダイアログ表示処理
  /// 引数：メッセージ
  void _showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );
  }

  /// 割引／値引を判定する
  /// 引数 [title] タイトル
  /// 引数 [fncCd] ファンクションコード
  void setDiscountItem(String title ,FuncKey fncCd) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }

    RxCommonBuf cBuf = xRet.object;
    if (Rxkoptcmncom.rxChkKeyKindPdsc(cBuf, fncCd.keyId)) {
          discountValue.value =
          Rxkoptcmncom.rxChkKoptPdscPdscPer(cBuf, fncCd.keyId);
          discountText.value = '割引率';
          discountTypeFlg.value = 1;
    } else if (Rxkoptcmncom.rxChkKeyKindDsc(cBuf, fncCd.keyId)) {
          discountValue.value =
          Rxkoptcmncom.rxChkKoptDscDscAmt(cBuf, fncCd.keyId);
          discountText.value = '値引額';
          discountTypeFlg.value = 0;
    }
    titleText.value = title;
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

  /// テンキーの「決定」ボタンで入力完了の処理
  void _decideButtonPressed() {
    _closeCurrentCursor();
    showRegisterTenkey.value = false;
    int value = int.tryParse(inputBoxKey.currentState!.inputStr.replaceAll(',', '').replaceAll('¥','').replaceAll('%','')) ?? 0;
      discountValue.value = value;
  }
}
