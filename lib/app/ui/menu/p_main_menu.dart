/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../inc/sys/tpr_log.dart';
import '../../sys/syst/sys_stdn.dart';
import '../colorfont/c_basecolor.dart';
import '../colorfont/c_basefont.dart';
import '../component/w_ignore_scrollbar.dart';
import '../component/w_sound_buttons.dart';
import '../menu/controller/c_main_menu.dart';
import '../page/terminal/p_terminal_info.dart';

/// メインメニュー
class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: MainMenuPageController(),
        builder: (controller) => Row(
          children: [
            // メインボタン
            Expanded(
              flex: 8,
              child: LayoutBuilder(
                builder: (buildContext, boxConstraints) {
                  // 幅240.0のボタンが水平方向に何個置けるか求める
                  const double standardWidth = 240.0;
                  int horizontalCount = (boxConstraints.maxWidth / standardWidth).floor();
                  return Container(
                    color: BaseColor.newMainMenuBackColor,
                    child: IgnoreScrollbar(
                      scrollController: controller.scrollController,
                      child: ListView(
                        controller: controller.scrollController,
                        children: [
                          Obx(() => Column(
                            children: [
                              for (int i = 0; i < controller.menuList.length; i++) ...{
                                // グループ名
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(top: 30.0, bottom: 20.0, left: 16.0, right: 16.0),
                                  decoration: const BoxDecoration(color: BaseColor.newMainMenuBackColor),
                                  child: Text(
                                    controller.menuList[i].title,
                                    style: const TextStyle(
                                      color: BaseColor.newMainMenuBlackColor,
                                      fontSize: BaseFont.font20px,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // グループ内のボタンを配置
                                for (int j = 0; j < controller.menuList[i].list.length; j += horizontalCount) ...{
                                  Container(
                                    // 最後の行の下余白は0にする。それ以外は20.0の余白を設ける
                                    padding: EdgeInsets.only(bottom: ((controller.menuList[i].list.length - j) > horizontalCount) ? 20.0 : 0.0),
                                    child: Row(
                                      children: [
                                        for (int k = 0; k < horizontalCount; k++) ...{
                                          if (j + k < controller.menuList[i].list.length)
                                          // ボタン
                                            Expanded(
                                              child: _mainButton(i, j + k, controller),
                                            ),
                                          if (j + k >= controller.menuList[i].list.length)
                                          // 空のボタン
                                            Expanded(child: Container()),
                                          if (k < horizontalCount - 1)
                                            const SizedBox(width: 20),
                                        }
                                      ],
                                    ),
                                  ),
                                }
                              }
                            ],
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // サブボタン
            Expanded(
              flex: 1,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: 1.0,
                    color: BaseColor.newMainMenuBackColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // スクロールボタン上
                        Obx(() => (controller.isScrollable.value)
                            ? _scrollButton(
                              Icons.arrow_drop_up,
                              () => controller.scrollController.scrollUp(pageHeight: constraints.maxHeight),
                            )
                            : Container(),
                        ),
                        const SizedBox(height: 10),
                        // スクロールボタン下
                        Obx(() => (controller.isScrollable.value)
                            ? _scrollButton(
                              Icons.arrow_drop_down,
                              () => controller.scrollController.scrollDown(pageHeight: constraints.maxHeight),
                            )
                            : Container(),
                        ),
                        const SizedBox(height: 170),
                        // 端末情報
                        _subButton(Icons.settings, '端末情報', () => Get.to(TerminalInfoPage())),
                        const SizedBox(height: 10),
                        // 電源OFF
                        _subButton(Icons.power_settings_new_outlined, '電源OFF',
                              () {
                                // 同じログを複数箇所に出力する関数
                                SysStdn.outputLogs('pressed powerOFF button From ${runtimeType.toString()}');
                                SysStdn.showShutdownConfirmationDialog();
                              }
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// メインボタン
  Widget _mainButton(int i, int j, MainMenuPageController controller) {
    String callFunc = '_mainButton';
    return (j < controller.menuList[i].list.length) ? Stack(
      children: [
        Container(
          height: 180.0,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            gradient: (i == 0) ? const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [BaseColor.newMainMenuBlack45Color, BaseColor.newMainMenuBlackColor],
            ) : null,
            color: (i == 0) ? null : BaseColor.newMainMenuWhiteColor,
            border: Border.all(color: BaseColor.newMainMenuIconColor, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.menuList[i].list[j].icon,
                color: (i == 0) ? BaseColor.newMainMenuWhiteColor : BaseColor.newMainMenuIconColor,
                size: 70,
              ),
              const SizedBox(height: 15),
              Text(
                controller.menuList[i].list[j].title,
                style: TextStyle(
                  color: (i == 0) ? BaseColor.newMainMenuWhiteColor : BaseColor.newMainMenuBlack87Color,
                  fontSize: BaseFont.font20px,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                controller.menuList[i].list[j].subtitle,
                style: TextStyle(
                  color: (i == 0) ? BaseColor.newMainMenuWhiteColor : BaseColor.newMainMenuBlack87Color,
                  fontSize: BaseFont.font13px,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: SoundInkWell(
              borderRadius: BorderRadius.circular(5.0),
              onTap: () => controller.menuButtonClick(i, j),
              callFunc: '${runtimeType.toString()} $callFunc ${controller.menuList[i].list[j].title}',
            ),
          ),
        ),
      ],
    ) : const SizedBox();
  }

  /// サブボタン（端末情報や電源OFF）
  Widget _subButton(IconData icon, String text, VoidCallback onPressed) {
    String callFunc = '_subButton';
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: BaseColor.maintainTenkey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: BaseColor.newMainMenuBlackColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
                color: BaseColor.newMainMenuWhiteColor,
              ),
              const SizedBox(height: 4.0),
              Text(
                text,
                style: const TextStyle(
                  fontSize: BaseFont.font13px,
                  color: BaseColor.newMainMenuWhiteColor,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: SoundInkWell(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              onTap: onPressed,
              callFunc: '${runtimeType.toString()} $callFunc',
            ),
          ),
        ),
      ],
    );
  }

  /// スクロールボタン
  Widget _scrollButton(IconData icon, VoidCallback onPressed) {
    String callFunc = '_scrollButton';
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: BaseColor.maintainBaseColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 70,
                color: BaseColor.newMainMenuWhiteColor,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: SoundInkWell(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              onTap: onPressed,
              callFunc: '${runtimeType.toString()} $callFunc',
            ),
          ),
        ),
      ],
    );
  }
}
