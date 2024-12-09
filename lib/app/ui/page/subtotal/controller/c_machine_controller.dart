/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:get/get.dart';

///マシンコントローラー
class MachineController extends GetxController {

  ///精算機リスト
  final machines = [
    {'title': '1', 'status':  '待機中'.trns, 'nearstatus': 'ニアエンド'},
    {'title': '2', 'status': '使用中'.trns,'nearstatus': 'ニアエンド'},
    {'title': '3', 'status': '休止中'.trns,'nearstatus': 'ニアエンド'},
    {'title': '4', 'status': 'l_reg_qcstatus_nearend'.trns,'nearstate': 'l_reg_qcstatus_nearend'.trns,},
  ].obs;
}