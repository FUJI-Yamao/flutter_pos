/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../regs/checker/rc_chgitm_dsp.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../component/w_edit_dropdown.dart';
import 'c_edit_dropdown.dart';
import 'c_registerbody_controller.dart';

/// 商品登録:変更タイプ
enum RegisterChangeType {
  none,

  ///　値引き.
  dsc,

  /// 割引.
  pdsc,

  /// 売価変更.
  chgPrc,
}

/// 商品登録:変更画面コントローラー
class RegisterChangeController extends GetxController {
  RegisterBodyController bodyCtrl = Get.find();

  /// 売価変更.
  final Rx<String> editChgPrc = ''.obs;

  /// 入力中のWidgetのtype
  final Rx<RegisterChangeType> inputEdit = RegisterChangeType.none.obs;

  // 割引
  final Map<int, String> discountValues = {
    0: '10',
    1: '20',
    2: '30',
    3: '40',
    4: '50'
  };

  // 値引き
  final Map<int, String> reductionValues = {
    0: '10',
    1: '20',
    2: '30',
    3: '40',
    4: '50'
  };

  //todo:削除予定 数量
  final afterQuantity = 0.obs;
  int beforeQuantity = 0;

  //テンキーを示す
  final showKeyboard = false.obs;

  // 変更画面上部表示使用変数
  int productIndex = 0;
  String productCode = '';
  String productName = '';

  /// 変更ボタン押下の際の値セット
  void initDataSet(int idx) {
    RegisterBodyController bodyctrl = Get.find();
    inputEdit.value = RegisterChangeType.none;
    // 単価
    bodyctrl.changePurchaseShow.value = true;
    editChgPrc.value = '';
    // 数量

    afterQuantity.value = bodyctrl.purchaseData[idx].itemLog.getItemQty();
    beforeQuantity = bodyctrl.purchaseData[idx].itemLog.getItemQty();

    productIndex = idx;
    productCode = bodyctrl.purchaseData[idx].itemLog.t10000.pluCd1_1;
    productName = bodyctrl.purchaseData[idx].itemLog.getItemName();
  }

  /// 処理概要：変更画面で確定した際のList反映用関数
  /// パラメータ：なし
  /// 戻り値：なし
  Future<void> changeListData() async {
    bodyCtrl.changeListData(productIndex);
  }

  // 割引/値引　金額
  int discountValue(String discount, int price, int quantity) {
    double discountDouble;
    discountDouble =
        price * quantity * double.parse(discount.replaceAll('%', '')) / 100;

    return discountDouble.floor();
  }

// 文字結合（変更画面　売価変更）
  void inputStr(KeyType key) {
    switch (inputEdit.value) {
      case RegisterChangeType.dsc:
        EditAndDropDownController controller =
            Get.find(tag: EditAndDropdownId.purchaseDsc.name);
        _joinKeyType(key, controller.editValue);
      case RegisterChangeType.pdsc:
        EditAndDropDownController controller =
            Get.find(tag: EditAndDropdownId.purchasePDsc.name);
        _joinKeyType(key, controller.editValue);
      case RegisterChangeType.chgPrc:
        _joinKeyType(key, editChgPrc);
      default:
    }
  }

// 文字結合（変更画面　売価変更）
  void _joinKeyType(KeyType key, Rx<String> editStr) {
    switch (key) {
      case KeyType.delete:
        if (editStr.value.isNotEmpty) {
          editStr.value = editStr.value.substring(0, editStr.value.length - 1);
        }
        break;
      case KeyType.check:
        showKeyboard.value = !showKeyboard.value;
        break;
      case KeyType.clear:
        editStr.value = '';
        break;
      default:
        if (editStr.value.isEmpty &&
            (key == KeyType.zero || key == KeyType.doubleZero)) {
          return;
        }
        editStr.value += key.name;
        break;
    }
  }

  /// 処理概要：商品の数量を更新する
  /// パラメータ：int purchaseIndex：明細データ配列のインデックス
  ///         ：int quantity：変更数量
  ///         ：bool isTenKeyInput：true テンキー経由での更新
  ///                             false ＋ーボタン経由での更新
  /// 戻り値：なし
  void updateQuantity(int purchaseIndex, int quantity, bool isTenKeyInput) {
    if (isTenKeyInput) {
      // テンキーによる更新
      bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.qty = quantity;
    } else {
      // ＋、ーボタンによる更新
      bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.qty =
          bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.qty! + quantity;
    }

    if (bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.qty! > 999) {
      bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.qty = 999;
    }
    if (bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.qty! < 1) {
      bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.qty = 1;
    }
  }

  /// 処理概要：売価変更値を更新する
  ///　　　　 ：売価変更値が0の場合は、変更不可のため売価変更は行わない。
  /// パラメータ：int purchaseIndex：明細データ配列のインデックス
  ///         ：int priceChangeValue：売価変更値
  /// 戻り値：bool true：更新済み
  ///　          false：更新なし
  bool updateSellingPrice(int purchaseIndex, int priceChangeValue) {
    if (priceChangeValue == 0) {
      return false;
    }
    bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.prcChgVal =
        priceChangeValue;
    return true;
  }

  /// 処理概要：値引き／割引き値を更新する
  ///         discountTypeが1、2の場合は更新処理を実施、それ以外の場合は実施しない。
  /// パラメータ：int purchaseIndex：明細データ配列のインデックス
  ///         ：int discountType：値引き／割引き種別
  ///         　　　　　　　　　　　　dsc：1.単品値引き
  ///         　　　　　　　　　　　　pdsc：2.単品割引
  ///         ：int discountValue：値引き／割引き値
  /// 戻り値：bool true：更新済み
  ///　          false：更新なし
  bool updateDiscountValue(
      int purchaseIndex, int discountType, int discountValue, int keyCode) {
    return bodyCtrl.updateDiscountValue(purchaseIndex, discountType, discountValue, keyCode);
  }

  /// 処理概要：rTypeを更新する
  ///         rTypeが1の場合は更新処理を実施、それ以外の場合は実施しない。
  /// パラメータ：int purchaseIndex：明細データ配列のインデックス
  ///         ：int rType：1（取り消し）
  /// 戻り値：bool true：更新済み
  ///　          false：更新なし
  bool updateRtype(int purchaseIndex, int rType) {
    if (rType == 1) {
      bodyCtrl.purchaseData[purchaseIndex].itemLog.itemData.type = rType;
      bodyCtrl.purchaseData[purchaseIndex].isDeleted = true;
      bodyCtrl.purchaseData.refresh();
      return true;
    }
    return false;
  }
}
