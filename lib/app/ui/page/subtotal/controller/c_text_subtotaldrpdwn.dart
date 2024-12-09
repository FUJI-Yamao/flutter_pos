/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../component/w_register_tenkey.dart';

/// 小計画面の変更画面テキストとドロップダウン用コントローラー
class SubtotalTextDropDownController extends GetxController {
  ///ドロップダウンクリック判定
  final discountClick1 = false.obs;
  ///一個目のプルダウンの値
  final subtotalDiscount1 = ''.obs;
  final int disIndex1 = 1;

  final discountClick2 = false.obs;
  final subtotalDiscount2 = ''.obs;
  final int disIndex2 = 2;

  ///テンキー示すかどうか
  final showKeyboard = false.obs;

  /// 選択されているBOX
  final selectedIndex = 0.obs;
 /// プルダウンをロックするかどうか
  final focusDropdown = false.obs;

  /// 割引
  final List<String> discountValues = [
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
    'テンキー入力'
  ];

  /// 文字結合（変更画面　売価変更）
  void joinKeyType(KeyType key) {

    var selectedDiscount = subtotalDiscount2;

    switch (key) {
      case KeyType.delete:
        if (selectedDiscount.value.isNotEmpty) {
          selectedDiscount.value = selectedDiscount.value
              .substring(0, selectedDiscount.value.length - 1);
        }
        break;
      case KeyType.check:
        focusDropdown.value = false;
        showKeyboard.value = !showKeyboard.value;
        selectedDiscount.value = subtotalDiscount2.value;
        break;
      case KeyType.clear:
        selectedDiscount.value = '';
        break;
      default:
          if (selectedDiscount.value.isEmpty &&
              (key == KeyType.zero || key == KeyType.doubleZero)) {
            return;
          }
          selectedDiscount.value += key.name!;
        break;
    }
  }
  ///数字を日本格式
  String numChange(String beforePrice) {
    int afterPrice = int.parse(beforePrice);
    final formatter = NumberFormat("#,###");
    return formatter.format(afterPrice);
  }

  /// ドロップダウン判定
  void selectedWidget(int idx) {
    selectedIndex.value = idx;
    if (idx == disIndex1) {
      discountClick1.value = !discountClick1.value;
      subtotalDiscount1.value = '';
    } else if (idx == disIndex2) {
      discountClick2.value = !discountClick2.value;
      subtotalDiscount2.value = '';
    }
  }
}
