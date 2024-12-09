/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/w_divider.dart';
import '../../../../component/w_ignore_scrollbar.dart';
import '../component/w_maintenance_scroll_button.dart';
import '../component/w_siolist.dart';
import '../controller/c_sio_controller.dart';
import '../model/e_speckind.dart';
import 'basepage/p_settingbase.dart';

/// Sio画面ボディー
class SioPageWidget extends SettingBasePage {
  /// コンストラクタ
  SioPageWidget({
    super.key,
    required String title,
    required super.currentBreadcrumb,
  }) : super(SpecKind.recogkey,title:title) {
    controller = Get.put(SioController(title: title, breadcrumb: breadcrumb));
    /// スクロールボタンを常に表示
    isTriangle.value = true;
    /// TOPへボタンを常に表示
    showTopButton.value = true;
  }
  late final SioController controller;

  /// 「メンテナンスを終了」ボタン、もしくは、戻るボタンを押したときの処理
  @override
  Future<bool> onEndMaintenancePage() {
    return controller.onEndMaintenancePage();
  }

  @override
  void onSave() {
    controller.saveChange();
    // TOPへ
    maintenanceScrollController.scrollToTop();
  }

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(builder: (buildContext, boxConstraints) {
      return Stack(
        children: [
          // 設定項目の表示
          _settingValueList(),
          // スクロールボタンの表示
          Obx(() => (isTriangle.value)
              ? Positioned(
                left: 0,
                bottom: 100,
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

  /// 設定項目の表示
  Widget _settingValueList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IgnoreScrollbar(
        scrollController: maintenanceScrollController,
        child: Obx(
          () => ListView.builder(
              controller: maintenanceScrollController,
              itemCount: controller.lstLblTxtsettings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 116.0,
                    right: 116.0,
                  ),
                  child: SizedBox(
                      width: controller.lstLblTxtsettings[index].width,
                      child: Flex(direction: Axis.vertical, children: [
                        SioListWidget(
                          lblsetting:
                          controller.lstLblTxtsettings[index].lblsetting,
                          txtsetting:
                          controller.lstLblTxtsettings[index].txtsetting,
                          btnsetting:
                          controller.lstLblTxtsettings[index].btnsetting,
                          axis: controller.lstLblTxtsettings[index].axis,
                          flex: controller.lstLblTxtsettings[index].flex,
                        ),
                        const ListDivider(),
                      ])),
                );
              }),
        ),
      ),
    );
  }
}
