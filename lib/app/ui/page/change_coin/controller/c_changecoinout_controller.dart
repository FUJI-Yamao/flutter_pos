/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:get/get.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../component/w_inputbox.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/component/w_register_tenkey.dart';

enum ConnectInfo {
  noConnect(0), // 未接続
  coin(1),      // 釣銭機接続
  bill(2);      // 釣銭釣札機接続

  final int code;

  const ConnectInfo(this.code);
}
/// 釣機払出画面のコントローラ
class ChangeCoinOutInputController extends GetxController {
  /// コンストラクタ
  ChangeCoinOutInputController()
      : inputBoxKey = GlobalKey<InputBoxWidgetState>();

  /// 釣銭機のみの場合の桁数
  static int amountDigit3 = 3;
  /// 金額指定放出フォーマット 0:5桁 1:6桁
  static int amountDigit5 = 5;
  static int amountDigit6 = 6;

  /// 入力boxの状態を管理するためのGlobalKey
  final GlobalKey<InputBoxWidgetState> inputBoxKey;

  /// 払出金額
  var coinOutPrc = 0.obs;

  /// 編集中の現在払出額
  var currentCoinOutPrc = 0.obs;

  /// テンキー表示フラグ
  var showRegisterTenkey = true.obs;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = true.obs;

  /// 払出金額桁数
  var coinOutNumLength = 0.obs;

  /// 払出金額の最大値
  String maxOutNumber = '';

  @override
  void onInit() async {
    super.onInit();

    int connectInfo = await CmCksys.cmCnctInfoChk();
    // todo Windows上で0(未接続)が返るため、確認用に以下を変更して実行
    //connectInfo = ConnectInfo.bill.code;
    connectInfo = ConnectInfo.coin.code;

    // 釣銭機のみ
    if (connectInfo == ConnectInfo.coin.code) {
      coinOutNumLength.value = amountDigit3;
    }
    // 釣銭釣札機
    else if (connectInfo == ConnectInfo.bill.code) {
      coinOutNumLength.value = _getCoinOutDigit();
      // todo Windows上で5が設定されるため、確認用に以下を変更して実行
      coinOutNumLength.value = amountDigit6;
    }
    // 接続なし
    else {
      coinOutNumLength.value = 0;
    }

    maxOutNumber = '';
    for (int i = 0; i < coinOutNumLength.value; i++) {
      maxOutNumber += '9';
    }
  }

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
    return intValue >= -99999999 && intValue <= 99999999;
  }

  /// 払出金額の入力処理.
  /// key   キー種別
  void _handleOtherKeys(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;

    // 0開始の数値は入力させないため処理中断
    if ((currentValue.isEmpty || currentValue == "0") &&
        (keyValue == "0" || keyValue == "00")) {
      return;
    }

    if (!_isValidNumberInput(currentValue, keyValue, coinOutNumLength.value)) {
      if (maxOutNumber.isNotEmpty) {
        _showErrorMessage('入力上限額は$maxOutNumberです');
      }
      else {
        _showErrorMessage('釣銭機は接続されていません');
      }
      return;
    }

    if (currentValue.isEmpty && key == KeyType.doubleZero) return;

    if (currentValue == '0' && key != KeyType.doubleZero) {
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
    currentCoinOutPrc.value =
        int.tryParse(input.replaceAll(',', '').replaceAll('¥', '')) ?? 0;
  }

  /// 釣銭釣札機の場合の払出金額の桁数を取得する
  int _getCoinOutDigit() {
    RxMemRet cRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (cRet.result != RxMem.RXMEM_OK) {
      debugPrint("rxMemRead error");
      return 0;
    }
    var pComBuf = cRet.object;

    // 金額指定放出フォーマット 0:5桁 1:6桁
    if (pComBuf.iniMacInfo.acx_flg.acb50_ssw24_0 == 1) {
      return amountDigit6;
    }
    return amountDigit5;
  }
}
