/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'w_purchase_scroll_controller.dart';
import 'package:get/get.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../../regs/checker/regs.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../enum/e_presetcd.dart';
import '../component/w_plubuttonarea.dart';

/// PLUエリアコントローラー
class PluAreaController extends GetxController {
  /// スクロールコントローラー
  final PurchaseScrollController purchaseScrollCtrl =
      PurchaseScrollController();

  /// スクロール状態
  final purchaseScrollON = true.obs;

  /// PLU用タブ数
  static int pluTabMaxCnt = 7;

  /// PLUTab開始位置
  final pluTabStart = 0.obs;

  /// PLU終了位置
  final pluTabEnd = (pluTabMaxCnt - 1).obs;

  /// PLUタブ選択位置
  /// 0始まり.
  final pluTabPosition = 0.obs;

  // 切替表示ありなし
  bool pluTabSwitching = false;

  /// PLUタブタイトル（サンプル）
  /// PresetInfo
  List pluTabBtnData = [].obs;

  /// PLU切替ボタンIDX
  int pluTabSwitchNumber = 99;

  /// Pluボタン数
  int pluBtnCnt = 2;

  /// pluボタンデータ
  late final pluBtnData = [].obs;

  /// 一回スクロールする高さ
  final scrollHeight = 482.0.obs;

  ///プリセット選択画面プリセットデータ
  var pluBtnPresetData = <PresetInfo>[].obs;

  /// タブ切替
  void changeTab(int tabIdx) {
    pluTabPosition.value = tabIdx;
    // Pluボタンデータ切替
    chgPluBtnData(tabIdx);
  }

  ///初期化処理
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chgPluBtnData(0);
    loadPluBtnPresetData();
  }

  ///コントローラー準備完了時に呼ばれる
  @override
  Future<void> onReady() async {
    super.onReady();
    purchaseScrollCtrl.updateOpacity();
  }

  // 切替タブボタン
  void switchTab() {
    int maxCnt = pluTabMaxCnt;
    if (pluTabBtnData.length > pluTabStart.value + maxCnt) {
      pluTabStart.value += maxCnt;
      int result = pluTabBtnData.length - pluTabStart.value;
      if (result > maxCnt) {
        pluTabEnd.value = pluTabStart.value + maxCnt;
      } else {
        pluTabEnd.value = pluTabBtnData.length;
      }
    } else {
      pluTabStart.value = 0;
      pluTabEnd.value = maxCnt;
    }
    pluTabPosition.value = pluTabStart.value;
    pluTabPosition.refresh();
    chgPluBtnData(pluTabPosition.value);
  }

  ///　画像付きボタンの作成
  Widget buildChild(List listItems, int index) {
    List<PresetInfo> lstItems = [];
    bool blnExists = true;
    int intIndex = 0;

    for (int i = 0; i < pluBtnCnt; i++) {
      intIndex = index * pluBtnCnt + i;
      // 2列目にデータがあるかの判定用（１列目は必ずtrue）
      blnExists = intIndex < listItems.length;
      if (!blnExists) {
        continue;
      }
      // サンプルデータセット
      lstItems.add(listItems[intIndex]);
    }

    return Row(
      children: [
        // 2列にする
        for (int i = 0; i < pluBtnCnt && i < lstItems.length; i++)
          PluWidget(
            visible: true,
            dispData: lstItems[i],
          ),
      ],
    );
  }

  /// PLUボタンデータセット
  /// tabIdxは0始まり
  Future<void> chgPluBtnData(tabIdx) async {
    pluBtnData.clear();
    pluTabBtnData.clear();
    // 0始まり.
    var pluList = await RegistInitData.presetImgReadDB();
    List<int> targetPresetCds =
        PresetCd.productPresets.map((e) => e.value).toList();
    var filteredList = pluList
        .where((item) => targetPresetCds.contains(item.presetCd))
        .toList();
    filteredList.sort((a, b) => a.presetCd.compareTo(b.presetCd));

    Map<int, List<PresetInfo>> pluBtnDataByPresetCd = {};

    for (var item in filteredList) {
      if (item.presetNo == 0) {
        pluTabBtnData.add(item);
      } else if (item.kyCd != 0) {
        pluBtnDataByPresetCd[item.presetCd] ??= [];
        pluBtnDataByPresetCd[item.presetCd]!.add(item);
      }
    }
    for (var key in pluBtnDataByPresetCd.keys) {
      pluBtnDataByPresetCd[key]!
          .sort((a, b) => a.presetNo.compareTo(b.presetNo));
    }
    if (pluTabBtnData.isNotEmpty) {
      var tabItem = pluTabBtnData[tabIdx % pluTabBtnData.length];
      pluBtnData.addAll(pluBtnDataByPresetCd[tabItem.presetCd] ?? []);
    }

    purchaseScrollON.value = pluBtnData.length > 7;
    // 切替ボタンの表示有無
    if (pluTabBtnData.length > pluTabMaxCnt) {
      pluTabSwitching = true;
      pluTabEnd.value = pluTabMaxCnt - 1;
    } else {
      pluTabSwitching = false;
      pluTabEnd.value = pluTabBtnData.length;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      purchaseScrollCtrl.updateOpacity();
    });
  }

  /// 全部のPluボタンプリセットデータ取得処理
  void loadPluBtnPresetData() async {
    List<PresetInfo> allPresets = await RegistInitData.getPresetImgData();
    List<int> productPresetValues =
        PresetCd.productPresets.map((preset) => preset.value).toList();

    var filteredPresets = allPresets.where((item) {
      return productPresetValues.contains(item.presetCd) &&
          item.presetNo != 0 &&
          item.kyCd != 0;
    }).toList();
    pluBtnPresetData.assignAll(filteredPresets);
  }
}
