/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/checker/rc_chgitm_dsp.dart';
import '../../../../regs/common/rxkoptcmncom.dart';
import '../../../component/w_inputbox.dart';
import '../../common/component/w_msgdialog.dart';
import '../../register/controller/c_register_change.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../enum/e_purchase_detail_modify_enum.dart';

///明細変更コントローラ
class DetailModifyInputController extends GetxController {
  //　各入力boxの状態を管理ためのGlobalKeyリスト
  final List<GlobalKey<InputBoxWidgetState>> detailModifyInputBoxList;

  //各入力boxの状態を管理ためのGlobalKeyリスト
  RxList<GlobalKey<InputBoxWidgetState>> inputBoxList =
      <GlobalKey<InputBoxWidgetState>>[].obs;

  // 値引き/割引きで数値指定可能な要素のindexが取得できない場合の戻り値
  static const int notExistInputEnableIndex = -1;

  // 編集している入力boxの位置. 0始まり
  int inputBoxPosition = 0;

  //　テンキー表示フラグ
  RxBool showRegisterTenKey = false.obs;

  //確定するボタンを表示するかどうか
  RxBool enableConfirmButton = false.obs;

  //＋ー個数変更ボタン表示するかどうか
  RxBool showPlusMinusButtons = false.obs;

  RxInt quantity = 0.obs;

  /// 選択中の値引き/割引き種別
  DscChangeType currentDiscountType = DscChangeType.dsc;

  /// 選択中のFuncKey
  FuncKey selectedFuncKey = FuncKey.KY_NONE;

  /// 値引き/割引きエリア表示有効フラグ(true: 表示　false:非表示)
  bool discountAreaEnable = false;

  /// 値引き/割引きテンキー入力時のデフォルト値
  List<int> entryDefault = [0, 0, 0];

  /// 値引き/割引きテンキー入力時のキーのデフォルト値
  List<int> entryKeyDefault = [0, 0, 0];

  /// 値引き/割引きinputbox有効フラグ
  List<bool> discountInputBoxEnable = [false, false, false];

  /// 共有メモリ
  late RxCommonBuf pCom;

  ///　金額桁数
  static const int priceNumLength = 6;

  ///　割合桁数
  static const int percentNumLength = 2;

  ///　個数桁数
  static const int quantityNumLength = 2;

  /// 現在の入力フィールドタイプ.
  PurchaseDetailModifyInputFieldType currentFieldType =
      PurchaseDetailModifyInputFieldType.none;

  ///　明細変更画面で使用するラベル
  final List<PurchaseDetailModifyLabel> labels;

  /// 登録画面のアイテムリスト番号
  final int purchaseDataIndex;

  /// 登録画面ボディ部コントローラー
  RegisterBodyController bodyCtrl = Get.find();

  /// 商品登録:変更画面コントローラー
  RegisterChangeController registerChangeCtrl;

  /// 共有メモリキーリスト
  List<List<FuncKey>> keyList = [
    [
      /// NONE配列
    ],
    [
      FuncKey.KY_DSC1,
      FuncKey.KY_DSC2,
      FuncKey.KY_DSC3,
      FuncKey.KY_DSC4,
      FuncKey.KY_DSC5
    ],
    [
      FuncKey.KY_PM1,
      FuncKey.KY_PM2,
      FuncKey.KY_PM3,
      FuncKey.KY_PM4,
      FuncKey.KY_PM5
    ]
  ];

  ///コンストラクタ
  DetailModifyInputController({
    required this.detailModifyInputBoxList,
    required this.labels,
    required this.purchaseDataIndex,
    required this.registerChangeCtrl,
  }) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    pCom = xRet.object;

    initDiscountArea();
  }

  ///キータイプに応じた入力処理.
  Future<void> inputKeyType(KeyType key) async {
    if (!showRegisterTenKey.value) {
      return;
    }
    switch (key) {
      case KeyType.delete:
        deleteButtonPressed();
        break;
      case KeyType.check:
        decideButtonPressed();
        break;
      case KeyType.clear:
        clearButtonPressed();
        break;
      default:
        tenKeyButtonPressed(key);
        break;
    }
  }

  /// 入力ボックスがタップされた時の処理.
  /// 売価変更の入力欄をタップしても、入力フォーカスを移動しない,決定ボタンしか動けない
  void onInputBoxTap(int focusedIndex) {
    updateFocus(focusedIndex);
    showRegisterTenKey.value = true;
    enableConfirmButton.value = false;
    detailModifyInputBoxList[focusedIndex].currentState?.setCursorOn();

    if (currentFieldType != PurchaseDetailModifyInputFieldType.quantity) {
      // 数量以外の入力欄がタップされた場合、数量＋ーボタンは表示に戻す
      showPlusMinusButtons.value = true;
    }
  }

  /// テンキー側で一文字削除ボタン押下した際の処理
  void deleteButtonPressed() {
    String value = getNowStr();
    if (value.isNotEmpty) {
      if (inputBoxPosition >= 0 &&
          inputBoxPosition < detailModifyInputBoxList.length) {
        detailModifyInputBoxList[inputBoxPosition].currentState?.onDeleteOne();
      }
    }
  }

  /// テンキー側で「決定」ボタン押下した際の処理
  void decideButtonPressed() {
    closeCurrentCursor();
    showRegisterTenKey.value = false;
    showPlusMinusButtons.value = true;

    // 数量の更新
    if (currentFieldType == PurchaseDetailModifyInputFieldType.quantity) {
      String qtyStr = getNowStr();
      if (qtyStr.isNotEmpty) {
        registerChangeCtrl.updateQuantity(
            purchaseDataIndex, int.parse(qtyStr), true);
      } else {
        registerChangeCtrl.updateQuantity(purchaseDataIndex, 0, true);
      }
    }

    // 売価変更値の更新
    if (currentFieldType == PurchaseDetailModifyInputFieldType.modification) {
      String prcChgVal = getNowStr();
      if (prcChgVal.isNotEmpty) {
        bool result = registerChangeCtrl.updateSellingPrice(
            purchaseDataIndex, int.parse(prcChgVal));
        if (!result) {
          debugPrint("売価変更値の更新未実施: "
              "index=$purchaseDataIndex, inputBoxPosition=$inputBoxPosition, prcChgVal=$prcChgVal");
        }
      }
    }

    // 値引き/割引き値の更新
    if (currentFieldType == PurchaseDetailModifyInputFieldType.discount) {
      String discountVal = getNowStr();
      discountVal = discountVal.replaceAll('%', '');
      discountVal = discountVal.replaceAll('-¥', '');
      bool result = updateDiscountValue(discountVal, selectedFuncKey.keyId);
      if (!result) {
        debugPrint("値引き/割引値の更新未実施: "
            "index=$purchaseDataIndex, inputBoxPosition=$inputBoxPosition, prcChgVal=$discountVal");
      }
      detailModifyInputBoxList[inputBoxPosition]
          .currentState
          ?.onChangeStr(discountVal);
      detailModifyInputBoxList[PurchaseDetailModifyLabel.discount.index]
          .currentState
          ?.updateDisp();
    }

    // 確定ボタンの表示
    showConfirmButton();
  }

  /// テンキー側でクリアーボタン押下した際の処理
  void clearButtonPressed() {
    if (inputBoxPosition >= 0 &&
        inputBoxPosition < detailModifyInputBoxList.length) {
      detailModifyInputBoxList[inputBoxPosition].currentState?.onDeleteAll();
    }
  }

  ///　テンキー側で数字ボタン押下した際の処理
  void tenKeyButtonPressed(KeyType key) {
    String currentValue = getNowStr();
    String keyValue = key.name;
    if (currentFieldType == PurchaseDetailModifyInputFieldType.quantity) {
      if (currentValue.length > quantityNumLength) {
        return;
      }
    }
    if (currentFieldType == PurchaseDetailModifyInputFieldType.modification) {
      if (currentValue.length > priceNumLength) {
        return;
      }
    }
    if (currentFieldType == PurchaseDetailModifyInputFieldType.discount) {
      /// FuncKeyが選択されている場合はFuncKeyの桁数で判定する
      /// 割引きの場合は最大桁数の指定がないためここでは判定しない
      if ((selectedFuncKey.keyId >= FuncKey.KY_DSC1.keyId) &&
          (selectedFuncKey.keyId <= FuncKey.KY_DSC5.keyId)) {
        int funcKeyDigit = pCom.dbKfnc[selectedFuncKey.keyId].opt.dsc.digit;
        if (!isValidNumberInput(currentValue, keyValue, funcKeyDigit) &&
            (currentFieldType ==
                    PurchaseDetailModifyInputFieldType.modification ||
                (currentFieldType ==
                        PurchaseDetailModifyInputFieldType.discount &&
                    currentDiscountType == DscChangeType.dsc))) {
          MsgDialog.show(
            MsgDialog.singleButtonDlgId(
              type: MsgDialogType.error,
              dialogId: DlgConfirmMsgKind.MSG_INPUTOVER.dlgId,
            ),
          );
          return;
        }
      }

      /// FuncKeyを使用しない場合は100万円まで
      if (!isValidNumberInput(currentValue, keyValue, priceNumLength) &&
          (currentFieldType ==
                  PurchaseDetailModifyInputFieldType.modification ||
              (currentFieldType ==
                      PurchaseDetailModifyInputFieldType.discount &&
                  currentDiscountType == DscChangeType.dsc))) {
        showErrorMessage("入力上限額は100万円までです");
        return;
      }

      /// 割引きはFuncKeyに桁数の上限が設定されていないため二桁固定
      if (!isValidNumberInput(currentValue, keyValue, percentNumLength) &&
          (currentFieldType == PurchaseDetailModifyInputFieldType.discount &&
              currentDiscountType == DscChangeType.pdsc)) {
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_INPUTOVER.dlgId,
          ),
        );
        return;
      }
    }

    String newValue = currentValue + keyValue;
    int changeInt = int.parse(newValue);
    detailModifyInputBoxList[inputBoxPosition]
        .currentState
        ?.onChangeStr(changeInt.toString());
  }

  /// 現在の入力boxのカーソルを非表示.
  void closeCurrentCursor() {
    if (inputBoxPosition >= 0 &&
        inputBoxPosition < detailModifyInputBoxList.length) {
      detailModifyInputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
  }

  /// 更新フォーカス.
  void updateFocus(int focusedIndex) {
    if (inputBoxPosition >= 0 &&
        inputBoxPosition < detailModifyInputBoxList.length) {
      detailModifyInputBoxList[inputBoxPosition].currentState?.setCursorOff();
    }
    showRegisterTenKey.value = true;
    enableConfirmButton.value = false;
    inputBoxPosition = focusedIndex;
    currentFieldType = labels[focusedIndex].purchaseDetailModifyFieldType;
    detailModifyInputBoxList[inputBoxPosition].currentState?.setCursorOn();
    detailModifyInputBoxList[inputBoxPosition]
        .currentState
        ?.toggleUseInitStrTextStyle();
  }

  ///　タップした入力boxからの文字列取得処理
  String getNowStr() {
    if (inputBoxPosition >= 0 &&
        inputBoxPosition < detailModifyInputBoxList.length) {
      InputBoxWidgetState? state =
          detailModifyInputBoxList[inputBoxPosition].currentState;
      return state?.inputStr ?? "";
    } else {
      return "";
    }
  }

  /// 番号入力条件
  bool isValidNumberInput(String currentValue, String keyValue, int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) {
      return false;
    }
    return true;
  }

  /// 金額欄入力範囲
  bool isValueInRange(String value) {
    if (value.isEmpty) {
      return false;
    }
    int intValue = int.tryParse(value) ?? 0;
    return intValue >= -99999999 && intValue <= 99999999;
  }

  /// エラーダイアログ表示処理
  void showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );
  }

  /// 処理概要：値引き/割引き切り替え処理
  /// パラメータ：typeAmount DscChangeType.dsc: 値引き DscChangeType.pdsc:割引き
  /// 戻り値：なし
  void setDiscountType(DscChangeType type) {
    currentDiscountType = type;
  }

  /// 処理概要：値引き/割引き切り替え処理
  /// パラメータ：typeAmount DscChangeType.dsc: 値引き DscChangeType.pdsc:割引き
  /// 戻り値：なし
  void setSelectedFuncKey(FuncKey key) {
    selectedFuncKey = key;
  }

  /// 処理概要：値引き/割引きボタンクリック処理
  /// パラメータ：int keyIndex 選択したキーオプションのインデックス
  /// 戻り値：String returnString 値引き/割引き値の文字列
  void discountButtonPressed(int keyIndex) {
    /// 押されたキーを保存
    selectedFuncKey = keyList[currentDiscountType.index][keyIndex];

    /// inputBoxのフォーカス判定
    if (getDiscountInputBoxEnable()) {
      updateFocus(PurchaseDetailModifyLabel.discount.index);
    } else {
      closeTenkeyPanel();
      closeCurrentCursor();
      enableConfirmButton.value = true;
      detailModifyInputBoxList[PurchaseDetailModifyLabel.discount.index]
          .currentState?.onDeleteAll();
    }

    /// 押下されたボタンの反映
    detailModifyInputBoxList[PurchaseDetailModifyLabel.discount.index]
        .currentState?.onChangeStr(getDiscountVal(selectedFuncKey));

    /// inputBoxの更新
    detailModifyInputBoxList[PurchaseDetailModifyLabel.discount.index]
        .currentState?.updateDisp();
    return;
  }

  /// 処理概要：値引き/割引き切り替え処理
  /// パラメータ：discountStr 値引き額
  /// 戻り値：bool true：更新済み
  ///　          false：更新なし
  void changeDiscountSwitch(DscChangeType dscType) {
    currentDiscountType = dscType;
    selectedFuncKey = FuncKey.KY_NONE;
    detailModifyInputBoxList[PurchaseDetailModifyLabel.discount.index]
        .currentState
        ?.onDeleteAll();
    closeTenkeyPanel();
    closeCurrentCursor();
  }

  /// 処理概要：値引き/割引き更新処理
  /// パラメータ：discountStr 値引き額
  /// 戻り値：bool true：更新済み
  ///　          false：更新なし
  bool updateDiscountValue(String discountStr, int keyCode) {
    if (discountStr.isNotEmpty) {
      if (currentDiscountType == DscChangeType.dsc) {
        String amountStr = discountStr.replaceAll('-¥', '');
        return registerChangeCtrl.updateDiscountValue(
            purchaseDataIndex, 1, int.parse(amountStr), keyCode);
      } else if (currentDiscountType == DscChangeType.pdsc) {
        String percentStr = discountStr.replaceAll('%', '');
        int discountPercent = int.parse(percentStr);
        return registerChangeCtrl.updateDiscountValue(
            purchaseDataIndex, 2, discountPercent, keyCode);
      }
      return false;
    } else {
      debugPrint("updateDiscountValue: discountStr is empty.");
      return false;
    }
  }

  ///確定するボタンを表示する
  void showConfirmButton() {
    // 単価、売価変更値がともに未入力の場合は確定ボタンを表示しない
    if ((bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.prcChgVal ==
            null) &&
        (bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.price ==
            null)) {
      enableConfirmButton.value = false;
      return;
    }

    // 単価が0円、売価変更値が未入力の場合は確定ボタンを表示しない
    if ((bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.prcChgVal ==
            null) &&
        ((bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.price !=
                null) &&
            (bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.price ==
                0))) {
      enableConfirmButton.value = false;
      return;
    }

    // 単価が未入力、売価変更値が0円の場合は確定ボタンを表示しない
    if ((bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.price ==
            null) &&
        ((bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.prcChgVal !=
                null) &&
            (bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData
                    .prcChgVal ==
                0))) {
      enableConfirmButton.value = false;
      return;
    }

    // 単価が0円、売価変更値が0円の場合は確定ボタンを表示しない
    if (((bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.price !=
                null) &&
            (bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.price ==
                0)) &&
        ((bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData.prcChgVal !=
                null) &&
            (bodyCtrl.purchaseData[purchaseDataIndex].itemLog.itemData
                    .prcChgVal ==
                0))) {
      enableConfirmButton.value = false;
      return;
    }
    enableConfirmButton.value = true;
  }

  /// 処理概要：値引き/割引きエリアの初期化処理
  /// 値引き/割引きエリア辞退の表示/非表示と、
  /// inputBoxタップ時の初期値を設定
  /// パラメータ：なし
  /// 戻り値：なし
  void initDiscountArea() {
    /// 表示が可能なキーのうち一番小さいキーの値をデフォルトとして保持
    for (int i = keyList[DscChangeType.dsc.index].length - 1; i > -1; i--) {
      int index = keyList[DscChangeType.dsc.index][i].keyId;
      if (pCom.dbKfnc[index].opt.dsc.itemDscpdscFlg == 0) {
        /// キー表示が一つでも有効の場合は値引き/割引きのエリアを表示する
        discountAreaEnable = true;
        entryDefault[DscChangeType.dsc.index] =
            pCom.dbKfnc[index].opt.dsc.dscAmt;
        entryKeyDefault[DscChangeType.dsc.index] = index;

        /// キーのentryFlgが一つでも有効であればinputBoxの入力を許可する
        if (pCom.dbKfnc[keyList[DscChangeType.dsc.index][i].keyId].opt.dsc
                .entryFlg ==
            0) {
          discountInputBoxEnable[DscChangeType.dsc.index] = true;
        }
      }
      for (int i = keyList[DscChangeType.pdsc.index].length - 1; i > -1; i--) {
        index = keyList[DscChangeType.pdsc.index][i].keyId;
        if (pCom.dbKfnc[index].opt.pdsc.itemDscpdscFlg == 0) {
          discountAreaEnable = true;
          entryDefault[DscChangeType.pdsc.index] =
              pCom.dbKfnc[index].opt.pdsc.pdscPer;
          entryKeyDefault[DscChangeType.pdsc.index] = index;
          if (pCom.dbKfnc[keyList[DscChangeType.pdsc.index][i].keyId].opt.pdsc
                  .entryFlg ==
              0) {
            discountInputBoxEnable[DscChangeType.pdsc.index] = true;
          }
        }
      }
    }
  }

  /// 処理概要：値引き/割引きエリアの表示状態
  /// パラメータ：なし
  /// 戻り値：現在の状態（true:表示　false:非表示）
  bool getDiscountAreaEnable() {
    return discountAreaEnable;
  }

  /// 処理概要：現在の値引き/割引きどちらの処理中かを返す
  /// パラメータ：なし
  /// 戻り値：DiscountType(dsc: 値引き　pdsc:割引き）
  DscChangeType getDiscountType() {
    return currentDiscountType;
  }

  /// 処理概要：値引き/割引きの数値を返す
  /// パラメータ：index :キー番号
  /// 戻り値：値引き額または割引き率
  String getDiscountVal(FuncKey key) {
    if (currentDiscountType == DscChangeType.dsc) {
      return pCom.dbKfnc[key.keyId].opt.dsc.dscAmt.toString();
    } else if (currentDiscountType == DscChangeType.pdsc) {
      return pCom.dbKfnc[key.keyId].opt.pdsc.pdscPer.toString();
    }
    return '';
  }

  /// 処理概要：値引き/割引きinputBox呼び出し処理
  /// パラメータ：なし
  /// 戻り値：なし
  void callDiscountInputBox() {
    if (selectedFuncKey.keyId == FuncKey.KY_NONE.keyId) {
      int index = getDiscountInputEnableIndex();

      if (index == notExistInputEnableIndex) {
        // エラーメッセージ
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_INPUTERR.dlgId,
          ),
        );
        return;
      }
      else {
        // indexを選択したことにする
        discountButtonPressed(index);
      }
    }

    if (getDiscountInputBoxEnable()) {
      updateFocus(PurchaseDetailModifyLabel.discount.index);
    }
  }

  /// 処理概要：テンキーパネル非表示処理
  /// パラメータ：なし
  /// 戻り値：なし
  void closeTenkeyPanel() {
    showRegisterTenKey.value = false;
  }

  /// 処理概要：キー表示文言取得処理
  /// パラメータ：キー番号
  /// 戻り値：キー表示文字列
  String getKeyString(int index) {
    String returnKeyString = '';
    int keyIndex;
    if (currentDiscountType == DscChangeType.pdsc) {
      keyIndex = keyList[currentDiscountType.index][index].keyId;
      returnKeyString = pCom.dbKfnc[keyIndex].opt.pdsc.pdscPer.toString();
      if (returnKeyString == '0' &&
          Rxkoptcmncom.rxChkKoptPdscEntry(pCom, keyIndex) == 0) {
        returnKeyString = pCom.dbKfnc[keyIndex].fncName;
      }
    } else if (currentDiscountType == DscChangeType.dsc) {
      keyIndex = keyList[currentDiscountType.index][index].keyId;
      returnKeyString = pCom.dbKfnc[keyIndex].opt.dsc.dscAmt.toString();
      if (returnKeyString == '0' &&
          Rxkoptcmncom.rxChkKoptDscEntry(pCom, keyIndex) == 0) {
        returnKeyString = pCom.dbKfnc[keyIndex].fncName;
      }
    }
    return returnKeyString;
  }

  /// 処理概要：選択済みキー判定処理
  /// パラメータ：キー番号
  /// 戻り値：true:選択済 false:未選択
  bool getSelectedButton(int index) {
    if (currentDiscountType != DscChangeType.none) {
      FuncKey key = keyList[currentDiscountType.index][index];
      if (selectedFuncKey.keyId == key.keyId) {
        return true;
      }
    }
    return false;
  }

  /// 処理概要：値引き/割引きinputBoxの使用判定処理
  /// パラメータ：なし
  /// 戻り値：true:inputBox使用可能　false:inputBox使用不可
  bool getDiscountInputBoxEnable() {
    /// 登録商品の値引き/割引きが可能か
    if (!bodyCtrl.checkDiscountAvailable(purchaseDataIndex)) {
      return false;
    }

    if (Rxkoptcmncom.rxChkKeyKindDsc(pCom, selectedFuncKey.keyId)) {
      /// 置数変更が無効の場合は入力不可
      if (Rxkoptcmncom.rxChkKoptDscEntry(pCom, selectedFuncKey.keyId) == 1) {
        return false;
      }

      /// 単品値引きが無効の場合は入力不可
      if (pCom.dbKfnc[selectedFuncKey.keyId].opt.dsc.itemDscpdscFlg == 1) {
        return false;
      }
    }

    if (Rxkoptcmncom.rxChkKeyKindPdsc(pCom, selectedFuncKey.keyId)) {
      /// 置数変更が無効の場合は入力不可
      if (Rxkoptcmncom.rxChkKoptPdscEntry(pCom, selectedFuncKey.keyId) == 1) {
        return false;
      }

      /// 単品値引きが無効の場合は入力不可
      if (pCom.dbKfnc[selectedFuncKey.keyId].opt.pdsc.itemDscpdscFlg == 1) {
        return false;
      }
    }
    return true;
  }

  /// 処理概要：値引き/割引きで数値指定可能な要素のindex取得
  /// パラメータ：なし
  /// 戻り値：数値指定可能なindex。指定可能な要素がない場合は-1を返す。
  int getDiscountInputEnableIndex() {
    /// 登録商品の値引き/割引きが可能か
    if (!bodyCtrl.checkDiscountAvailable(purchaseDataIndex)) {
      return notExistInputEnableIndex;
    }

    for (int i = 0; i < keyList.length; i++) {
      int keyId = keyList[currentDiscountType.index][i].keyId;
      if (Rxkoptcmncom.rxChkKeyKindDsc(pCom, keyId)) {
        /// 置数変更が無効の場合は入力不可
        if (Rxkoptcmncom.rxChkKoptDscEntry(pCom, keyId) == 1) {
          continue;
        }

        /// 単品値引きが無効の場合は入力不可
        if (pCom.dbKfnc[keyId].opt.dsc.itemDscpdscFlg == 1) {
          continue;
        }
      }
      if (Rxkoptcmncom.rxChkKeyKindPdsc(pCom, keyId)) {
        /// 置数変更が無効の場合は入力不可
        if (Rxkoptcmncom.rxChkKoptPdscEntry(pCom, keyId) == 1) {
          continue;
        }

        /// 単品値引きが無効の場合は入力不可
        if (pCom.dbKfnc[keyId].opt.pdsc.itemDscpdscFlg == 1) {
          continue;
        }
      }
      return i;
    }
    return notExistInputEnableIndex;
  }
}
