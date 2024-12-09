/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import '../../../../component/w_ignore_scrollbar.dart';
import '../../../../component/w_sound_buttons.dart';
import '../../../../enum/e_presetcd.dart';
import '../../../register/pixel/c_pixel.dart';
import '../../template/basepage/maintainbase.dart';
import '../controller/c_preset_color_selection_controller.dart';
import 'w_maintenance_scroll_button.dart';
import 'w_maintenance_scroll_controller.dart';
import 'w_preset_color_select_radio_button.dart';

/// プリセットカラー用選択肢.
class PresetColorSelectValue {
  final int selectId;
  final String name;

  PresetColorSelectValue({required this.name, required this.selectId});
}

/// プリセットカラー用選択ページ
class PresetColorSelectionPage extends MaintainBasePage {
  /// コンストラクタ
  PresetColorSelectionPage({
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    required this.settingName,
    required this.itemList,
    required this.initSelectedId,
    required this.oncallback,
  }) {
    // 選択用コントローラー
    sController = Get.put(PresetColorSelectionController(
      itemList,
      initSelectedId,
    ));
  }

  /// 設定する項目名
  final String settingName;

  /// 選択肢のリスト
  final List<PresetColorSelectValue> itemList;

  /// 画面表示時に選択されている選択肢(SelectValueのselectedId).
  final int initSelectedId;

  /// ボタン押下時の処理
  final Function oncallback;

  /// 選択用コントローラー
  late final PresetColorSelectionController sController;

  /// スクロールバーのコントローラー
  final MaintenanceScrollController maintenanceScrollController =
  MaintenanceScrollController();

  /// スクロールボタン表示のフラグ（trueで表示）
  final Rx<bool> isTriangle = false.obs;

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        /// リストタイトルの表示
        _valueListTitle(),
        /// リスト表示とスクロールボタン表示
        _valueListWithScrollButton(),
      ],
    );
  }

  /// リストタイトルの表示
  Widget _valueListTitle() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: 21,
        bottom: 21,
      ),
      child: Text(
        settingName,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 28, color: Colors.white),
      ),
    );
  }

  /// リスト表示とスクロールボタン表示
  Widget _valueListWithScrollButton() {
    return Expanded(
      child: LayoutBuilder(builder: (buildContext, boxConstraints) {
        debugPrint('$boxConstraints');
        return Stack(
          children: [
            // リスト表示
            _valueList(),
            // スクロールボタンの表示
            Obx(() => (isTriangle.value)
                ? Positioned(
                    left: 0,
                    bottom: 20,
                    child: MaintenanceScrollButton(
                      maintenanceScrollController,
                      pageHeight: boxConstraints.maxHeight,
                    ),
                  )
                : Container()),
          ],
        );
      }),
    );
  }

  /// リスト表示
  Widget _valueList() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: IgnoreScrollbar(
        scrollController: maintenanceScrollController,
        child: _createListView(),
      ),
    );
  }

  /// ListView作成
  Widget _createListView() {
    // ListView.builderの後に、処理が走るようにする
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // maxScrollExtentが0より大きい時にスクロールボタンを表示する
      isTriangle.value =
          maintenanceScrollController.position.maxScrollExtent > 0;
    });
    String callFunc = '_createListView';
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: maintenanceScrollController,
      itemCount: itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return Obx(() => _oneItemView(callFunc, index),);
      },
    );
  }

  /// ListViewの内１行を表示
  Widget _oneItemView(String callFunc, int index) {
    return Row(
      children: [
        // 余白
        const SizedBox(width: 120.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Stack(
            children: [
              Row(
                children: [
                  // 余白
                  const SizedBox(width: 8.0),
                  // ラジオボタン
                  PresetColorSelectRadioButton(isSelected: sController.selectedIndex.value == index,),
                  // 余白
                  const SizedBox(width: 32.0),
                  // 色付き選択肢
                  Container(
                    height: 50.0,
                    width: 696.0,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      color: PresetCd.getBtnColor(itemList[index].selectId),
                      borderRadius: BorderRadius.circular(BasePixel.pix05),
                      border: Border.all(
                        color: sController.selectedIndex.value == index
                            ? BaseColor.baseColor
                            : PresetCd.getBtnColor(itemList[index].selectId),
                        width: 3,
                      ),
                    ),
                    child: Text(
                      itemList[index].name,
                      style: const TextStyle(
                        fontSize: BaseFont.font24px,
                        color: BaseColor.baseColor,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: Material(
                  type: MaterialType.button,
                  color: Colors.transparent,
                  child: SoundInkWell(
                    onTap: () {
                      // selectedIndexの書き換え
                      sController.changeSelectedId(index);
                    },
                    callFunc: callFunc,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 100.0),
      ],
    );
  }

  /// body下のフッターUI.
  @override
  Widget? footer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
      // キャンセルボタン、決定ボタンの配置
      child: _selectValueFooter(),
    );
  }

  /// キャンセルボタン、決定ボタンの配置
  Widget _selectValueFooter() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        cancelDecideButton(
          onCancel: () {
            Get.back(result: 'x');
          },
          onDecide: () {
            oncallback(itemList[sController.selectedIndex.value]);
            Get.back(result: true);
          },
        ),
        const SizedBox(
          width: 116.0,
        ),
      ],
    );
  }
}
