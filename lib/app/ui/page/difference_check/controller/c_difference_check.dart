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
import '../../subtotal/component/w_register_tenkey.dart';
import '../model/m_changemodels.dart';
import '../../../../inc/lib/if_acx.dart';
import 'c_diff_scroll_controller.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';

// I/F
import '../../../../regs/checker/rc_clxos_drwcheck.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../../clxos/calc_api_result_data.dart';

///　差異チェック　コントローラー
class DifferenceCheckStateController extends GetxController {
  late CalcResultDrwchkWithRawJson retData;
  late CalcResultDrwchk result;

  // 釣機在高 合計
  var stockStat = 0.obs;

  // ドロア在高
  var drawerSum = 0.obs;

  // 現金以外在高
  var nonCashHoldings = 0.obs;

  // 理論現金在高
  var cashTheoryStack = 0.obs;

  // 理論現金以外在高
  var nonCashtheoryStack = 0.obs;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = true.obs;

  // ドロアの入力ボックスの数
  int drawerInputBoxNumber = 10;

  // 釣り機情報（収納庫）リスト作成
  List<ChangeData> storageChangeData = List.generate(
      10,
      (index) => ChangeData(
            billCoinType: BillCoinType.coin,
            amount: 0, //値(10000円等)
            value: 0, //枚数
          )).obs;

  // 現金以外表　リスト作成
  List<NonCashData> nonCashList = List.generate(
      35,
      (index) => NonCashData(
            title: "",
            value: 0,
          )).obs;

  // ドロアー在高用リスト 作成
  List<ChangeData> drawerCurrentValueList = List.generate(
      10,
      (index) => ChangeData(
            billCoinType:
                cashType[index] >= 1000 ? BillCoinType.bill : BillCoinType.coin,
            amount: cashType[index],
            value: 0,
          )).obs;

  // 内訳表示用リスト作成
  List<BreakDownData> breakDownTableData = List.generate(
      6,
      (index) => BreakDownData(
          header: "",
          cashStockData: 0,
          accountStockData: 0,
          giftCardStockData: 0,
          rowSum: 0)).obs;

  //紙幣の数の種類の定義
  final int billCoinCount = CoinBillKindList.CB_KIND_MAX.id;

  Future<void> updateChangeData() async {
    RegsMem mem = RegsMem();

    //釣機情報
    List<int> cashCount = [
      mem.tTtllog.t100600Sts.bfreStockSht10000,
      mem.tTtllog.t100600Sts.bfreStockSht5000,
      mem.tTtllog.t100600Sts.bfreStockSht2000,
      mem.tTtllog.t100600Sts.bfreStockSht1000,
      mem.tTtllog.t100600Sts.bfreStockSht500,
      mem.tTtllog.t100600Sts.bfreStockSht100,
      mem.tTtllog.t100600Sts.bfreStockSht50,
      mem.tTtllog.t100600Sts.bfreStockSht10,
      mem.tTtllog.t100600Sts.bfreStockSht5,
      mem.tTtllog.t100600Sts.bfreStockSht1,
    ];

    // 現金在高表作成
    await setStorageChangeData(cashCount);
  }

  /// 釣り機情報を取得する
  Future<void> getChangeData() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    retData = await RcClxosDrawerCheck.rcDrawerCheck(pCom);
    result = retData.result;

    RegsMem mem = RegsMem();

    //釣機情報
    List<int> cashCount = [
      mem.tTtllog.t100600Sts.bfreStockSht10000,
      mem.tTtllog.t100600Sts.bfreStockSht5000,
      mem.tTtllog.t100600Sts.bfreStockSht2000,
      mem.tTtllog.t100600Sts.bfreStockSht1000,
      mem.tTtllog.t100600Sts.bfreStockSht500,
      mem.tTtllog.t100600Sts.bfreStockSht100,
      mem.tTtllog.t100600Sts.bfreStockSht50,
      mem.tTtllog.t100600Sts.bfreStockSht10,
      mem.tTtllog.t100600Sts.bfreStockSht5,
      mem.tTtllog.t100600Sts.bfreStockSht1,
    ];

    // 現金在高表作成
    await setStorageChangeData(cashCount);

    // 内訳用
    List<PaychkData>? paychkDataList = result.paychkDataList;

    // 現金、会計、品券でまとめる
    //会計データ
    List<PaychkData> accountingList = [];
    //品券データ
    List<PaychkData> giftCertificateList = [];

    // 内訳パース
    if (paychkDataList != null) {
      for (int i = 0; i < paychkDataList.length; i++) {
        PaychkData paychkData = PaychkData(
            groupID: paychkDataList[i].groupID,
            code: paychkDataList[i].code,
            name: paychkDataList[i].name,
            order: paychkDataList[i].order,
            theoryAmt: paychkDataList[i].theoryAmt,
            loanAmt: paychkDataList[i].loanAmt,
            inAmt: paychkDataList[i].inAmt,
            outAmt: paychkDataList[i].outAmt,
            pickAmt: paychkDataList[i].pickAmt);

        if (paychkData.code == cashCode) {
          cashTheoryStack.value = paychkData.theoryAmt!; // 理論現金在高
        }

        //会計コードだったら会計として保存する
        if (accountingCodeCheck(paychkData.code!)) {
          accountingList.add(paychkData);
        }

        //品券コードだったら品券として保存する
        if (giftCertificateCodeCheck(paychkData.code!)) {
          giftCertificateList.add(paychkData);
        }
      }
    }

    // 現金以外表作成
    if (paychkDataList != null) {
      await setNonCashData(accountingList, giftCertificateList);
    }

    // 現金
    CashChaChkAmtData? cashInfoDataList = result.cashInfoData;
    // 会計
    CashChaChkAmtData? chaInfoDataList = result.chaInfoData;
    // 品券
    CashChaChkAmtData? chkInfoDataList = result.chkInfoData;

    if (cashInfoDataList != null &&
        chaInfoDataList != null &&
        chkInfoDataList != null) {
      // 内訳表作成
      await setbreakDownTableData(
          cashInfoDataList, chaInfoDataList, chkInfoDataList);
    }
  }

  //釣り機在高表
  Future<void> setStorageChangeData(List<int> list) async {
    int sum = 0;

    for (int i = 0; i < storageChangeData.length; i++) {
      storageChangeData[i].amount = cashType[i];
      storageChangeData[i].value = list[i];
      storageChangeData[i].billCoinType =
          cashType[i] >= 1000 ? BillCoinType.bill : BillCoinType.coin;

      //合計算出
      sum += storageChangeData[i].amount * storageChangeData[i].value;
    }
    //釣機在高
    stockStat.value = sum;
  }

  //会計コードチェック
  bool accountingCodeCheck(int code) {
    bool result = false;
    for (int i = 0; i < accountingCode.length; i++) {
      if (code == accountingCode[i]) {
        result = true;
      }
    }
    return result;
  }

  // 品券コードチェック
  bool giftCertificateCodeCheck(int code) {
    bool result = false;
    for (int i = 0; i < giftCertificateCode.length; i++) {
      if (code == giftCertificateCode[i]) {
        result = true;
      }
    }
    return result;
  }

  ///内訳を表示ボタン押下時の表
  Future<void> setbreakDownTableData(
    CashChaChkAmtData cashInfoDataList, //現金
    CashChaChkAmtData chaInfoDataList, //会計
    CashChaChkAmtData chkInfoDataList, //品券
  ) async {
    // 現金の合計のリスト
    List<int> cashListSum = [
      cashInfoDataList.loanAmt!,
      cashInfoDataList.inAmt!,
      cashInfoDataList.outAmt!,
      cashInfoDataList.pickAmt!,
      cashInfoDataList.otherAmt!,
      cashInfoDataList.totalAmt!,
    ];

    // 会計の合計のリスト
    List<int> accountingListSum = [
      chaInfoDataList.loanAmt!,
      chaInfoDataList.inAmt!,
      chaInfoDataList.outAmt!,
      chaInfoDataList.pickAmt!,
      chaInfoDataList.otherAmt!,
      chaInfoDataList.totalAmt!,
    ];

    // // 品券の合計のリスト
    List<int> giftCertificateListSum = [
      chkInfoDataList.loanAmt!,
      chkInfoDataList.inAmt!,
      chkInfoDataList.outAmt!,
      chkInfoDataList.pickAmt!,
      chkInfoDataList.otherAmt!,
      chkInfoDataList.totalAmt!,
    ];

    //内訳表
    for (int i = 0; i < breakDownTableData.length; i++) {
      // -1 しているのは合計用
      breakDownTableData[i].header = breakDownHeader[i];
      breakDownTableData[i].cashStockData = cashListSum[i]; //現金
      breakDownTableData[i].accountStockData = accountingListSum[i]; //会計
      breakDownTableData[i].giftCardStockData = giftCertificateListSum[i]; //品券
      breakDownTableData[i].rowSum = breakDownTableData[i].cashStockData +
          breakDownTableData[i].accountStockData +
          breakDownTableData[i].giftCardStockData;
    }

    // 理論現金以外在高
    nonCashtheoryStack.value =
        chaInfoDataList.totalAmt! + chkInfoDataList.totalAmt!;
  }

  /// 現金以外を表示の表
  Future<void> setNonCashData(List<PaychkData> accountingList,
      List<PaychkData> giftCertificateList) async {
    int nonCashDatasum = 0;

    // 会計 1-30
    for (int i = 0; i < accountingList.length; i++) {
      //タイトル
      if (accountingList[i].name != null) {
        nonCashList[i].title = accountingList[i].name!;
      } else {
        nonCashList[i].title = "会計${i + 1}";
      }
      //値
      if (accountingList[i].theoryAmt != null) {
        nonCashList[i].value = accountingList[i].theoryAmt!;
      } else {
        nonCashList[i].value = 0;
      }
      int nonCashValue = nonCashList[i].value;

      //合計に値を足す
      nonCashDatasum += nonCashValue;
    }
    // 品券 1-5
    for (int j = 0; j < giftCertificateList.length; j++) {
      //タイトル
      if (giftCertificateList[j].name != null) {
        nonCashList[j + 30].title = giftCertificateList[j].name!;
      } else {
        nonCashList[j + 30].title = "品券${j + 1}";
      }

      //値
      if (giftCertificateList[j].theoryAmt != null) {
        nonCashList[j + 30].value = giftCertificateList[j].theoryAmt!;
      } else {
        nonCashList[j + 30].value = 0;
      }

      int nonCashValue = nonCashList[j].value;

      //合計に値を足す
      nonCashDatasum += nonCashValue;
    }

    //合計を代入
    nonCashHoldings.value = nonCashDatasum;
  }

  ///ドロア在高のデータ保存 合計値算出
  ///ドロア在高　各入力値 [inputValue]
  void setChangeData(int inputValue) {
    if (inputBoxPosition < drawerInputBoxNumber) {
      drawerCurrentValueList[inputBoxPosition].value = inputValue;
    } else {
      nonCashList[inputBoxPosition - drawerInputBoxNumber].value = inputValue;
    }
    updateDrawerSum();
  }

  void updateDrawerSum() {
    //ドロア在高合計算出
    int currentValue = 0;
    for (int i = 0; i < drawerCurrentValueList.length; i++) {
      currentValue +=
          drawerCurrentValueList[i].amount * drawerCurrentValueList[i].value;
    }
    drawerSum.value = currentValue;

    //現金以外在高算出
    int nonCashCurrentValue = 0;
    for (int i = 0; i < nonCashList.length; i++) {
      nonCashCurrentValue += nonCashList[i].value;
    }
    nonCashHoldings.value = nonCashCurrentValue;
  }

  ///各入力boxの状態を管理ためのGlobalKeyリスト
  ///0-9 ドロア用 10-45 現金以外用
  final List<GlobalKey<InputBoxWidgetState>> inputBoxKeyList =
      List.generate(45, (index) => GlobalKey<InputBoxWidgetState>());

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
        drawerCurrentValueList[inputBoxPosition].value = 0;
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
        drawerCurrentValueList[inputBoxPosition].value = 0;
      } else {
        nonCashList[inputBoxPosition - drawerInputBoxNumber].value = 0;
      }
    } else {
      if (inputBoxPosition < drawerInputBoxNumber) {
        drawerCurrentValueList[inputBoxPosition].value = int.parse(value);
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
      drawerCurrentValueList[inputBoxPosition].value = 0;
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

  /// エラーダイアログ表示処理（引数：メッセージ）
  void showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );
  }

  // スクロール用

  final DiffScrollController scrollController = DiffScrollController();

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

  /// 任意の位置までスクロールする関数
  void scrollToPosition(double position) {
    scrollController.animateTo(
      position,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
