/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../colorfont/c_basecolor.dart';
import '../../../../../component/w_btn.dart';
import '../../../../../language/l_languagedbcall.dart';
import '../../../template/basepage/maintainbase.dart';
import '../../component/w_maintenance_scroll_controller.dart';
import '../../model/e_speckind.dart';

/// スペックファイル共通部分
/// フッターのTOP,保存ボタンを表示する.
abstract class SettingBasePage extends MaintainBasePage {
  /// コンストラクタ
  SettingBasePage(this.specfile,{
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    super.isVisibleMaintenanceFinishButton = true,
  });

  ///スペックファイル
  final SpecKind specfile;

  /// スクロールボタン表示のフラグ（trueで表示）
  final Rx<bool> isTriangle = false.obs;

  /// TOPへボタン表示のフラグ（trueで表示）
  final Rx<bool> showTopButton = false.obs;

  /// スクロールバーのコントローラー
  final MaintenanceScrollController maintenanceScrollController =
      MaintenanceScrollController();

  /// 保存ボタンを押したときの処理.
  void onSave();

  /// body下のフッターUI.
  @override
  Widget? footer(BuildContext context) {
    return Container(
      /// TOPへボタン、保存ボタンの配置
      child: _specFileFooter(),
    );
  }

  /// TOPへボタン、保存ボタンの配置
  Widget _specFileFooter() {
    return Container(
      height: 80.h,
      width: 1024.w,
      decoration: BoxDecoration(
        color: BaseColor.maintainButtonAreaBG,
        boxShadow: [
          BoxShadow(
            color: BaseColor.maintainButtonAreaBG.withOpacity(0.5), //色
            spreadRadius: 20,
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.end,
        direction: Axis.horizontal,
        children: [
          /// TOPへボタンの表示
          Obx(
            () => showTopButton.value
                ? BorderButton(
                    width: 210.w,
                    height: 50,
                    text: 'l_cmn_top'.trns,
                    onTap: () {
                      /// TOPへ
                      maintenanceScrollController.scrollToTop();
                    },
                  )
                : SizedBox(
                    width: 210.w,
                  ),
          ),
          SizedBox(
            width: 20.w,
          ),
          GradientBorderButton(
            width: 210.w,
            height: 50.h,
            text: 'l_cmn_save'.trns,
            onTap: () {
              onSave();
            },
          ),
          SizedBox(
            width: 120.w,
          ),
        ],
      ),
    );
  }
}
