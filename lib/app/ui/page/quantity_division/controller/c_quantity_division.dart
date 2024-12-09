/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../component/w_inputbox.dart';

///分割数量コントローラ
class QuantityDivisionInputController extends GetxController {

  ///各入力boxの状態を管理ためのGlobalKeyリスト
  final List<GlobalKey<InputBoxWidgetState>> quantityDivisionBoxList;

  final List<String> labels;
  ///コンストラクタ
  QuantityDivisionInputController({
    required this.quantityDivisionBoxList,
    required this.labels,
  });


  ///テンキー表示フラグ
  //var showRegisterTenkey = false.obs;


}