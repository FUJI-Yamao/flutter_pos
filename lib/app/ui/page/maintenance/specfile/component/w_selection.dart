/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../component/w_ignore_scrollbar.dart';
import '../../../../component/w_sound_buttons.dart';
import '../../../register/pixel/c_pixel.dart';
import '../../template/basepage/maintainbase.dart';
import '../controller/c_selection_controller.dart';
import 'w_maintenance_scroll_button.dart';
import 'w_maintenance_scroll_controller.dart';

/// スペックファイル用選択肢.
class SelectValue {
  final dynamic selectId;
  final String name;

  SelectValue({required this.name, required this.selectId});

  @override
  String toString() {
    return 'SelectValue(name:$name,selectId:$selectId)';
  }
}

/// スペックファイル用選択ページ
class SelectionPage extends MaintainBasePage {
  /// コンストラクタ
  SelectionPage({
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    required this.settingName,
    required this.itemList,
    required this.initSelectedId,
    required this.oncallback,
  }) {
    // 選択用コントローラー
    sController = Get.put(SelectionController(itemList, initSelectedId));
  }

  final String settingName;

  final List<SelectValue> itemList;

  /// 画面表示時に選択されている選択肢(SelectValueのselectedId).
  final dynamic initSelectedId;
  final Function oncallback;

  List get lblTxtsettings => itemList;

  /// 選択用コントローラー
  late final SelectionController sController;

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
        return Obx(() => Padding(
          padding: const EdgeInsets.only(
            left: 100.0,
            right: 100.0,
            top: 10.0,
            bottom: 10.0,
          ),
          child: Material(
              type: MaterialType.button,
              color: sController.containerColors[index],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BasePixel.pix05),
                  side: BorderSide(
                      color: sController.containerLineColors[index], width: 3)),
              child: SoundInkWell(
                onTap: () {
                  sController.switchColors(index);
                },
                callFunc: callFunc,
                child: Container(
                    height: 50,
                    width: 800,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(itemList[index].name,
                        style: const TextStyle(
                          fontSize: 24,
                          color: BaseColor.baseColor,
                        )),
                  ),
                ),
              ),
            ));
      },
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
        cancelDecideButton(onCancel: () {
          Get.back(result: 'x');
        }, onDecide: () {
          oncallback(itemList[sController.selectedIndex.value]);
          Get.back(result: true);
        }),
        const SizedBox(
          width: 116.0,
        ),
      ],
    );
  }
}
