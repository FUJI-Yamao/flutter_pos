/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/ui/enum/e_presetcd.dart';
import 'package:get/get.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../../regs/checker/regs.dart';

///登録画面会計業務などのコントローラー
class LoginAccountController extends GetxController {
  ///選択されているインデックス（初期値は1）
  var selectedIndex = 1.obs;
  ///プリセットデータ
  var presetData = <PresetInfo>[].obs;
  ///タイトルデータ
  var titleData = <String>[].obs;

  ///初期化
  @override
  void onInit() {
    super.onInit();
    loadPresets();
  }

  ///選択されたコンテナを更新する
  void selectContainer(int index) {
    selectedIndex.value = index;
  }

  ///データ読み込んだ後に選択されたコンテナを更新する
  void loadPresets() async {
    var allData = await RegistInitData.presetReadDB();
    var filteredData = allData
        .where((item) =>
            item.presetCd == PresetCd.operationList1.value ||
            item.presetCd == PresetCd.operationList2.value ||
            item.presetCd == PresetCd.operationList3.value ||
            item.presetCd == PresetCd.operationList4.value)
        .toList();
    presetData.assignAll(filteredData);
    updateTitleData();
    selectContainer(1);
  }
  /// タイトル更新
  void updateTitleData() {
    List<PresetCd> presetCdList = [
      PresetCd.operationList1,
      PresetCd.operationList2,
      PresetCd.operationList3,
      PresetCd.operationList4
    ];
    titleData.clear();
    for (var presetCd in presetCdList) {
      var title = presetData
          .where(
              (item) => item.presetNo == 0 && item.presetCd == presetCd.value)
          .map((item) => item.kyName)
          .toList();
      titleData.add(title.first);
    }
  }

  ///プリセットコードに応じたファクションキーリストを返す
  List<PresetInfo> getTextsAndColorsForPresetCd(int containerIndex) {
    PresetCd presetCd = [
      PresetCd.operationList1,
      PresetCd.operationList2,
      PresetCd.operationList3,
      PresetCd.operationList4
    ][containerIndex - 1];
    return presetData
        .where((item) => item.presetCd == presetCd.value && item.kyCd != 0)
        .toList();
  }

}
