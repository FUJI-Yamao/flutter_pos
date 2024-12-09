/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_divider.dart';
import '../../../component/w_ignore_scrollbar.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../menu/register/m_maintenance.dart';
import '../specfile/component/w_maintenance_scroll_button.dart';
import '../specfile/component/w_maintenance_scroll_controller.dart';
import '../template/basepage/maintainbase.dart';
import 'controller/c_maintenance_menu_controller.dart';

/// メンテナンスのメニュー画面
class MaintenanceMenuPage extends MaintainBasePage {
  /// コンストラクタ
  MaintenanceMenuPage({
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    super.isVisibleMaintenanceFinishButton = true,
    required this.menuList,
  });

  /// メニューリスト
  final List<MaintenanceMenuItem> menuList;

  /// スクロールバーのコントローラー
  final MaintenanceScrollController maintenanceScrollController = MaintenanceScrollController();

  /// スクロールボタン表示のフラグ（trueで表示）
  final Rx<bool> isTriangle = false.obs;

  @override
  Widget body(BuildContext context) {
    Get.put(MaintenanceMenuController());
    return LayoutBuilder(builder: (buildContext, boxConstraints) {
      return Stack(
        children: [
          // リスト表示
          _valueList(),
          // スクロールボタンの表示
          Obx(() => (isTriangle.value)
              ? Positioned(
                left: 0,
                bottom: 100.0 + 80.0,   // 設定画面と同じ位置にする
                child: MaintenanceScrollButton(
                  maintenanceScrollController,
                  pageHeight: boxConstraints.maxHeight,
                ),
              )
              : Container()
          ),
        ],
      );
    });
  }

  /// リスト表示
  Widget _valueList() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 30.0,
        bottom: 30.0,
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
      isTriangle.value = maintenanceScrollController.position.maxScrollExtent > 0;
    });
    return ListView.builder(
      controller: maintenanceScrollController,
      itemCount: menuList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(
          left: 116.0,
          right: 116.0,
        ),
        child: Column(
          children: [
            _createListItem(index),
            const ListDivider(),
          ],
        ),
      ),
    );
  }

  /// ListViewのitem作成
  Widget _createListItem(int index) {
    bool isDisable = (menuList[index].goToPage == null);
    String callFunc = '_createListItem';
    return Stack(
      children: [
        SizedBox(
          height: 28.0 + 24.0 + 28.0,   // 文字（24.0）に上下余白（28.0）を足した高さにする
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  menuList[index].pageInfo.menuItemName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: BaseFont.font24px,
                    fontFamily: BaseFont.familyDefault,
                    color: (isDisable) ? BaseColor.dividerColor : BaseColor.someTextPopupArea,
                    height: 1.2,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: BaseFont.font24px,
                color: (isDisable) ? BaseColor.dividerColor : BaseColor.someTextPopupArea,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: SoundInkWell(
              onTap: (isDisable) ? null : () {
                menuList[index].goToPage!(breadcrumb);
              },
              callFunc: '$callFunc ${menuList[index].pageInfo.menuItemName}',
            ),
          ),
        ),
      ],
    );
  }
}
