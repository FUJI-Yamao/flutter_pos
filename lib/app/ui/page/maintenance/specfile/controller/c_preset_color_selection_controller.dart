/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../component/w_preset_color_selection.dart';

/// プリセットカラー選択用コントローラー
class PresetColorSelectionController extends GetxController{

  PresetColorSelectionController(List<PresetColorSelectValue> itemList, int initSelectedId) {
    selectedIndex.value = getInitSelectedIndex(itemList, initSelectedId);
  }

  /// 選択された項目のインデクス変数
  RxInt selectedIndex = RxInt(-1);

  /// 最初に選択されている値のindexを取得する
  int getInitSelectedIndex(List<PresetColorSelectValue> itemList, int initSelectedId) {
    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].selectId == initSelectedId) {
        return i;
      }
    }
    return -1;
  }

  /// selectedIndexの書き換え
  void changeSelectedId(int index) {
    selectedIndex.value = index;
  }
}