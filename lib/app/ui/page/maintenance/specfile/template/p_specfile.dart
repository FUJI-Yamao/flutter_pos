/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/w_divider.dart';
import '../../../../component/w_ignore_scrollbar.dart';
import '../../../../component/w_list_item.dart';
import '../../../../component/w_switch.dart';
import '../component/w_maintenance_scroll_button.dart';
import '../component/w_preset_color_list_item.dart';
import '../component/w_preset_grp_cd_list_item.dart';
import '../controller/c_spec_json_controller.dart';
import '../controller/c_spec_net_controller.dart';
import '../controller/c_specfile_controller.dart';
import '../model/e_speckind.dart';
import '../model/m_specfile.dart';
import '../model/m_widgetsetting.dart';
import 'basepage/p_settingbase.dart';

/// 共通スペックファイルボディー
class SpecfilePageWidget extends SettingBasePage {
  ///コンストラクタ
  SpecfilePageWidget(SpecKind specfile, {
    Key? key,
    required String title,
    required super.currentBreadcrumb,
  }) : super(specfile, key: key, title: title) {
    if (SpecKind.network == specfile) {
      specCtrl = Get.put(SpecfileNetController(title: title, breadcrumb: breadcrumb), tag: specfile.name);
    } else {
      specCtrl = Get.put(SpecfileJsonController(specfile, title: title, breadcrumb: breadcrumb), tag: specfile.name);
    }
  }

  /// スペックファイルコントローラー
  late final SpecfileControllerBase specCtrl;

  /// 「メンテナンスを終了」ボタン、もしくは、戻るボタンを押したときの処理
  @override
  Future<bool> onEndMaintenancePage() async {
    return specCtrl.onEndMaintenancePage();
  }

  @override
  void onSave() {
    specCtrl.saveChange();
    // TOPへ
    maintenanceScrollController.scrollToTop();
  }

  @override
  Widget body(BuildContext context) {
    // 画面サイズを取得して、項目の表示を「横並び」or「縦並び」に切り替える
    chgScreen(MediaQuery.of(context).size.width);

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

  /// 画面サイズを取得して、項目の表示を「横並び」or「縦並び」に切り替える
  void chgScreen(double width) {
    // TODO:縦画面対応（幅775を基準にしている）
    // 画面の幅が775以下の場合は、縦並びにする
    final Axis axis = width <= 775 ? Axis.vertical : Axis.horizontal;
    for (var element in specCtrl.lstLblTxtsettings) {
      element.axis.value = axis;
    }
  }

  /// 設定項目の表示
  Widget _settingValueList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IgnoreScrollbar(
        scrollController: maintenanceScrollController,
        child: Obx(() {
          // ListView.builderの後に、処理が走るようにする
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // maxScrollExtentが0より大きい時にスクロールボタンとTOPへボタンを表示する
            bool isVisible = maintenanceScrollController.position.maxScrollExtent > 0;
            isTriangle.value = isVisible;
            showTopButton.value = isVisible;
          });
          return ListView.builder(
            controller: maintenanceScrollController,
            itemCount: specCtrl.lstLblTxtsettings.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(
                left: 116.0,
                right: 116.0,
              ),
              child: SizedBox(
                width: specCtrl.lstLblTxtsettings[index].width,
                child: Flex(direction: Axis.vertical, children: [
                  // 画面に表示される設定項目の取得
                  displaySettingValue(index),
                  const ListDivider(),
                ]),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// 画面に表示される設定項目の取得
  Widget displaySettingValue(int index) {
    if (specCtrl.lstLblTxtsettings[index].containsSwitch) {
      return SwitchWidget(
        lblsetting: specCtrl
            .lstLblTxtsettings[index].lblsetting,
        switchsetting: specCtrl
            .lstLblTxtsettings[index].switchsetting,
        axis: specCtrl.lstLblTxtsettings[index].axis,
        flex: specCtrl.lstLblTxtsettings[index].flex,
        containsSwitch: specCtrl
            .lstLblTxtsettings[index].containsSwitch,
      );
    } else {
      if (specCtrl.dispRowData[index].editKind == SpecFileEditKind.presetGroupCode
          && specCtrl.lstLblTxtsettings[index].txtsetting is Rx<SpecFileTxtSetting2>) {
        return PresetGroupCodeListItem(
          lblsetting: specCtrl
              .lstLblTxtsettings[index].lblsetting,
          txtsetting: specCtrl
              .lstLblTxtsettings[index].txtsetting,
          btnsetting: specCtrl
              .lstLblTxtsettings[index].btnsetting,
          flex: 5,
        );
      } else if (specCtrl.dispRowData[index].editKind == SpecFileEditKind.presetColor) {
        return PresetColorListItem(
          lblsetting: specCtrl
              .lstLblTxtsettings[index].lblsetting,
          txtsetting: specCtrl
              .lstLblTxtsettings[index].txtsetting,
          btnsetting: specCtrl
              .lstLblTxtsettings[index].btnsetting,
          flex: 5,
        );
      } else {
        return ListItem(
          lblsetting: specCtrl
              .lstLblTxtsettings[index].lblsetting,
          txtsetting: specCtrl
              .lstLblTxtsettings[index].txtsetting,
          btnsetting: specCtrl
              .lstLblTxtsettings[index].btnsetting,
          axis: specCtrl.lstLblTxtsettings[index].axis,
          flex: 5,
          containsSwitch: specCtrl
              .lstLblTxtsettings[index].containsSwitch,
        );
      }
    }
  }

}
