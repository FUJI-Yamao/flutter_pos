/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/ui/language/l_languagedbcall.dart';
import '/app/ui/model/m_widgetsetting.dart';

/// テストページ2用コントローラー
class TestPage2Controller extends GetxController {
  // テスト用可変ラベルデータ
  // 多言語key
  // switch on:オン off:オフ
  // change 0:存在する  1:存在しない  2:不明

  // ボタンセット用
  final btnSwitchSetting = BtnSetting().obs;
  final btnChangeSetting = BtnSetting().obs;

  // 多言語Key格納用
  String strMKeySwitch = 'v_switch_'; // 多言語key検索用初期値
  String strMKeyChange = 'v_change_'; // 多言語key検索用初期値

  // 切替用配列
  List<LanguagesData> lstSwitch = [];
  List<LanguagesData> lstChange = [];

  // 配列の位置の保存用 初期値は状況で決める（ここでは0）
  final intSwitchR = Rx<int>(0);
  final intChangeR = Rx<int>(0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // 対象の多言語keyを取得
    lstSwitch = LanguagesMstDbCall().getMultipleKey(strMKeySwitch);
    lstChange = LanguagesMstDbCall().getMultipleKey(strMKeyChange);

    // ボタンセッティングの設定
    btnSwitchSetting.update((val) {
      val?.text = lstSwitch[intSwitchR.value].multilingual_key;
      val?.backcolor = Colors.teal.shade600;
      val?.bordercolor = Colors.teal.shade300;
      val?.shadowcolor = Colors.teal.shade900;
      // val?.textcolor = Colors.black;
      val?.onTap = () => LanguagesMstDbCall().tapChange(intSwitchR, lstSwitch, btnSwitchSetting);
    });
    // ボタンセッティングの設定
    btnChangeSetting.update((val) {
      val?.text = lstChange[intChangeR.value].multilingual_key;
      val?.backcolor = Colors.orange.shade600;
      val?.bordercolor = Colors.orange.shade300;
      val?.shadowcolor = Colors.orange.shade900;
      val?.textcolor = Colors.black;
      val?.width = 100;
      val?.onTap = () => LanguagesMstDbCall().tapChange(intChangeR, lstChange, btnChangeSetting);
    });
  }
}
