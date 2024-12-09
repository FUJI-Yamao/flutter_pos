/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../component/w_inputbox.dart';
import '../../common/component/w_msgdialog.dart';
import '../../difference_check/model/m_changemodels.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'c_sales_collection_scroll_controller.dart';

// I/F
import '../../../../regs/checker/rc_clxos_drwcheck.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../../clxos/calc_api_result_data.dart';

/// 売り上げ回収画面のコントローラー
class SalesCollectionStateController extends GetxController {
  late CalcResultDrwchkWithRawJson retData;
  late CalcResultDrwchk result;

  // 現金以外在高　合計
  var nonCashHoldings = 0.obs;
  // ドロア在高の合計
  var drawerSum = 0.obs;

  // 現金のの入力ボックスの数
  int drawerInputBoxNumber = 10;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = true.obs;

  // 現金以外表　リスト作成
  List<NonCashData> nonCashList = List.generate(
      35,
      (index) => NonCashData(
            title: "",
            value: 0,
          )).obs;

  // ドロア在高用リスト 作成
  List<ChangeData> valueList = List.generate(
      10,
      (index) => ChangeData(
            billCoinType:
                cashType[index] >= 1000 ? BillCoinType.bill : BillCoinType.coin,
            amount: cashType[index],
            value: 0,
          )).obs;

  ///各入力boxの状態を管理ためのGlobalKeyリスト
  final List<GlobalKey<InputBoxWidgetState>> inputBoxKeyList =
      List.generate(45, (index) => GlobalKey<InputBoxWidgetState>());

  //紙幣の数の種類の定義
  final int billCoinCount = CoinBillKindList.CB_KIND_MAX.id;

  /// 釣り機情報を取得する
  Future<void> getChangeData(
      List<NonCashData> nonCash, List<ChangeData> cashData, setState) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    nonCashList = nonCash;
    valueList = cashData;
    for (int i = 0; i < cashData.length; i++) {
      inputBoxKeyList[i].currentState?.inputStr = cashData[i].value.toString();
    }

    for (int i = 0; i < nonCashList.length; i++) {
      inputBoxKeyList[i + drawerInputBoxNumber].currentState?.inputStr =
          nonCashList[i].value.toString();
    }
    updateDrawerSum();

    // メモリ保存データより会計の名称データを取る
    for (int i = 0; i < accountingCode.length; i++) {
      String keyName = pCom.dbKfnc[accountingCode[i]].fncName;
      nonCashList[i].title = keyName;
    }

    // メモリ保存データより品券の名称データを取る
    for (int i = 0; i < giftCertificateCode.length; i++) {
      String keyName = pCom.dbKfnc[giftCertificateCode[i]].fncName;
      nonCashList[i + 30].title = keyName;
    }
  }

  ///データ保存 合計値算出
  void setChangeData(int inputValue) {
    if (inputBoxPosition < drawerInputBoxNumber) {
      valueList[inputBoxPosition].value = inputValue;
    } else {
      nonCashList[inputBoxPosition - drawerInputBoxNumber].value = inputValue;
    }
    updateDrawerSum();
  }

  void updateDrawerSum() {
    //ドロア在高合計算出
    int currentValue = 0;
    for (int i = 0; i < valueList.length; i++) {
      currentValue += valueList[i].amount * valueList[i].value;
    }
    drawerSum.value = currentValue;

    //現金以外在高算出
    int nonCashCurrentValue = 0;
    for (int i = 0; i < nonCashList.length; i++) {
      nonCashCurrentValue += nonCashList[i].value;
    }
    nonCashHoldings.value = nonCashCurrentValue;
  }

  /// テンキー表示フラグ
  var showRegisterTenkey = false.obs;

  /// 編集している入力boxの位置. 0始まり
  int inputBoxPosition = 0;

  /// タップした入力boxに該当するデータから文字列取得処理
  String getNowStr() {
    InputBoxWidgetState? state = inputBoxKeyList[inputBoxPosition].currentState;
    String result = state?.inputStr ?? ""; //nullだったら""にする
    result = result.replaceAll(',', '').replaceAll('¥', '');
    return result;
  }

  /// 一文字削除処理
  void deleteOneChar() {
    String value = getNowStr();
    if (value.isEmpty) {
      if (inputBoxPosition < drawerInputBoxNumber) {
        valueList[inputBoxPosition].value = 0;
      } else {
        nonCashList[inputBoxPosition - drawerInputBoxNumber].value = 0;
      }
      updateDrawerSum();
      return;
    }

    inputBoxKeyList[inputBoxPosition].currentState?.onDeleteOne();
    // valueを最新に更新
    value = getNowStr();

    if (value.isEmpty) {
      if (inputBoxPosition < drawerInputBoxNumber) {
        valueList[inputBoxPosition].value = 0;
      } else {
        nonCashList[inputBoxPosition - drawerInputBoxNumber].value = 0;
      }
    } else {
      if (inputBoxPosition < drawerInputBoxNumber) {
        valueList[inputBoxPosition].value = int.parse(value);
      } else {
        nonCashList[inputBoxPosition - drawerInputBoxNumber].value =
            int.parse(value);
      }
    }

    updateDrawerSum();
  }

  /// Cをタップされた場合のクリア関数
  void clearString() {
    inputBoxKeyList[inputBoxPosition].currentState?.onDeleteAll();
    if (inputBoxPosition < drawerInputBoxNumber) {
      // 値クリアで保存データ削除
      valueList[inputBoxPosition].value = 0;
    } else {
      nonCashList[inputBoxPosition - drawerInputBoxNumber].value = 0;
    }
    //ドロア在高合計算出
    updateDrawerSum();
  }

  /// 枚数欄入力範囲　1-9999
  /// value   範囲チェック文字列
  bool isValueInRange(String value) {
    // 入力制限 1-9999
    int intValue = int.tryParse(value) ?? 0;
    return (0 <= intValue && intValue < 10000);
  }

  /// 金額欄入力範囲　1-9999999
  /// value   範囲チェック文字列
  bool isValueInCoinRange(String value) {
    // 入力制限 1-9999999
    int intValue = int.tryParse(value) ?? 0;
    return (0 <= intValue && intValue < 100000000);
  }

  /// 入金額の入力処理.
  /// key   キー種別
  void handleOtherKeys(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;

    // 0開始の数値は入力させないため処理中断
    if ((currentValue.isEmpty || currentValue == "0") &&
        (keyValue == "0" || keyValue == "00")) {
      return;
    }

    String newValue = currentValue + keyValue;
    if (inputBoxPosition < drawerInputBoxNumber) {
      if (isValueInRange(newValue)) {
        currentValue += keyValue;
        inputBoxKeyList[inputBoxPosition]
            .currentState
            ?.onChangeStr(currentValue);
        setChangeData(int.parse(currentValue));
      } else {
        showErrorMessage("入力可能な範囲を超えています 0 ～ 9999");
        return;
      }
    } else {
      if (isValueInCoinRange(newValue)) {
        currentValue += keyValue;
        inputBoxKeyList[inputBoxPosition]
            .currentState
            ?.onChangeStr(currentValue);
        setChangeData(int.parse(currentValue));
      } else {
        showErrorMessage("入力可能な範囲を超えています ￥0 ～ ￥99,999,999");
        return;
      }
    }
  }

  /// エラーダイアログ表示処理（引数：メッセージ）
  void showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );
  }

  /// テンキーのキータイプに応じた入力処理
  /// key   キー種別
  Future<void> inputKeyType(KeyType key) async {
    if (!showRegisterTenkey.value) {
      return;
    }
    switch (key) {
      case KeyType.delete:
        deleteOneChar(); //１つ削除処理
        break;
      case KeyType.check:
        decideButtonPressed(inputBoxPosition); //決定ボタン押下
        break;
      case KeyType.clear:
        clearString(); //クリアボタン押下
        break;
      default:
        if (isFirstInput.value) {
          // 0開始の値は設定できないため処理中断
          if (key.name == '0' || key.name == '00') {
            return;
          }
          isFirstInput.value = false;
          clearString();
        }
        handleOtherKeys(key);
        break;
    }
  }

  /// 更新フォーカス.
  void updateFocus(int inputFocus) {
    showRegisterTenkey.value = true;
    //全部調べて、押されたものでない場合は、フォーカスをなくす
    for (int i = 0; i < inputBoxKeyList.length; i++) {
      if (i != inputFocus) {
        inputBoxKeyList[i].currentState?.setCursorOff();
      } else {
        inputBoxPosition = inputFocus;
        inputBoxKeyList[inputFocus].currentState?.setCursorOn();
      }
    }

    inputBoxKeyList[inputBoxPosition].currentState?.setCursorOn();
  }

  /// 入力ボックスがタップされた時の処理.
  /// テンキーを表示する、フォーカスをon
  void onInputBoxTap(int inputBoxPosition) {
    updateFocus(inputBoxPosition); //入力フォーカスを選んだものにする
    showRegisterTenkey.value = true; //テンキーを表示する
    isFirstInput.value = true; // 初回タップ判定
    inputBoxKeyList[inputBoxPosition].currentState?.setCursorOn(); //フォーカスを当てる
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor(int inputBoxPosition) {
    inputBoxKeyList[inputBoxPosition].currentState?.setCursorOff();
  }

  /// テンキーの「決定」ボタンで入金完了の処理
  void decideButtonPressed(int inputBoxPosition) {
    _closeCurrentCursor(inputBoxPosition); //現在のカーソル非表示
    showRegisterTenkey.value = false; //テンキー表示用の判定をfalseにする
  }

  // スクロール用
  final salesCollectionScrollController scrollController =
      salesCollectionScrollController();

  double upOpacity = 0.5;
  double downOpacity = 1.0;

  void updateUpScrollBtnOpacity(setState) {
    if (scrollController.position.pixels == 0) {
      setState(() {
        upOpacity = 0.5;
      });
    } else {
      setState(() {
        upOpacity = 1.0;
      });
    }
  }

  void updateDownScrollBtnOpacity(setState) {
    if (scrollController.position.pixels == 540.0) {
      setState(() {
        downOpacity = 0.5;
      });
    } else {
      setState(() {
        downOpacity = 1.0;
      });
    }
  }

  // 任意の位置までスクロールする関数
  void scrollToPosition(double position) {
    scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
