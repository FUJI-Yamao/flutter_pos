/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../component/w_selection.dart';

/// 選択用コントローラー
class SelectionController extends GetxController{

  //カラー格納用リスト変数
  RxList<Color> containerColors = <Color>[].obs;
  RxList<Color> containerLineColors = <Color>[].obs;
  //選択された項目のインデクス変数
  RxInt selectedIndex = RxInt(-1);
  //スクロールコントローラー
  final ScrollController scrollController = ScrollController();
  SelectionController(List<SelectValue> itemList, dynamic initSelectedId) {
    generateColorList(itemList, initSelectedId);
  }

  //カラーリストを作成する
  void generateColorList(List<SelectValue> itemList, dynamic initSelectedId) {
    containerColors.value = List<Color>.generate(itemList.length, (index) {
      if (itemList[index].selectId == initSelectedId) {
        selectedIndex.value = index;
        return BaseColor.selectInColor;
      } else {
        return Colors.white;
      }
    });
    containerLineColors.value = List<Color>.generate(itemList.length, (index) {
      if (itemList[index].selectId == initSelectedId) {
        selectedIndex.value = index;
        return BaseColor.selectLineColor;
      } else {
        return Colors.white;
      }
    });
  }

  //項目を選択する時に、色と選択されたインデクスを変更する
  void switchColors(int index) {
    int length =  containerColors.length;
    //選択された項目のインデクスを更新する
    selectedIndex.value = index;
    for (int i = 0; i < length; i++) {
      //カラーを更新する
      containerColors[i] = i == index ? BaseColor.selectInColor : Colors.white;
      containerLineColors[i] = i == index ? BaseColor.selectLineColor : Colors.white;
    }
  }
}