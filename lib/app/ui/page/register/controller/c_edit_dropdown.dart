/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';


/// 文字入力&ドロップダウンWidget[EditAndDropdownWidget]コントローラー
class EditAndDropDownController extends GetxController {
  /// [initKey]:ドロップダウンの初期選択key.
  EditAndDropDownController(int? initKey){
    selectedKey.value = initKey;
  }

  /// 入力欄にフォーカスが当たっているかどうか.
  final  Rx<bool> focus = false.obs ;

  /// 入力文字.
  /// テンキーなどから文字を入力する場合、
  /// この変数に値を入れる.
  final Rx<String> editValue = "".obs;

  /// 選択中のID. nullの時は未選択.
  final selectedKey = Rxn<int>();

  /// 入力欄のフォーカスをONにする.
  void focusOn(){
    focus.value = true;
  }
  /// 入力欄のフォーカスをOFFにする.
  void focusOff(){
    focus.value = false;
  }

  /// 入力されている内容や、選択をOFFにする.
  void reset(){
    editValue.value = "";
    selectedKey.value = null;
  }
}
