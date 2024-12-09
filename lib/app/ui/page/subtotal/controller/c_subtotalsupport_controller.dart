/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/regs.dart';
import 'package:get/get.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../enum/e_presetcd.dart';

/// 小計サポート欄コントローラー
class SubtotalSupportController extends GetxController {
  /// サポートボタンテキスト
  var supportButtons = <PresetInfo>[].obs;

  ///初期化処理
  @override
  void onInit() {
    super.onInit();
    loadSupportData();
  }

  ///小計サポート欄プリセットデータを取得
  void loadSupportData() async {
    List<PresetInfo> allPresets = await RegistInitData.getPresetData();
    var filteredPresets = allPresets
        .where((item) => item.presetCd == PresetCd.subtotalSupport.value && item.kyCd != 0)
        .toList();
    supportButtons.assignAll(filteredPresets);
  }
}
