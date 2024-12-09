/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../menu/register/enum/e_register_page.dart';
import 'controller/mode_change_controller.dart';

/// モード切替画面
class ModeChangePage extends StatelessWidget {
  const ModeChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    ModeChangeController modeChangeController = Get.put(ModeChangeController());
    // appBarの描画と高さ取得で同じAppBarを2回使用するため、変数に関数コールで代入
    AppBar modeChangeAppBar = buildAppBar();
    return Scaffold(
      appBar: modeChangeAppBar,
      body: Container(
        color: BaseColor.modeChangePageBackgroundColor,
        child: Column(
          children: [
            // 説明文
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              height: 88.0,
              color: BaseColor.modeChangeCommentBackgroundColor,
              child: const Center(
                child: Text(
                  '通常／対面、フルセルフ、精算機に\nモードの切り替えができます。',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: BaseFont.font22px,
                    fontFamily: BaseFont.familyDefault,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            // モードを切り替えるラジオボタンの集合
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      modeChangeRow(modeChangeController, ModeKind.normal),
                      modeChangeRow(modeChangeController, ModeKind.fulSelf),
                      modeChangeRow(modeChangeController, ModeKind.adjustment),
                    ],
                  );
                }),
              ),
            ),
            // appBarの高さ + 説明文の高さ(88.0)
            SizedBox(height: modeChangeAppBar.preferredSize.height + 88.0,),
          ],
        ),
      ),
    );
  }

  /// モードを切り替えるラジオボタン（行全体）
  Widget modeChangeRow(ModeChangeController modeChangeController, ModeKind modeKind) {
    String callFunc = 'modeChangeRow';
    return SizedBox(
      height: 100.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  hoverColor: Colors.transparent,
                  value: modeKind.modeName,
                  // 選択されているモードのIDに応じてモードの名前を返す
                  groupValue: ModeKind.getModeName(modeChangeController.selectedModeID.value),
                  onChanged: (value) => modeChangeController.changeMode(modeKind),
                ),
              ),
              const SizedBox(
                width: 32.0,
              ),
              SizedBox(
                // 10文字分の領域
                width: 220.0,
                child: Text(
                  modeKind.modeName,
                  style: const TextStyle(
                    fontSize: BaseFont.font22px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: SoundInkWell(
              onTap: () => modeChangeController.changeMode(modeKind),
              callFunc: '$callFunc modeKind.modeName ${modeKind.modeName}',
            ),
          ),
        ],
      ),
    );
  }

  /// モード切替のタイトルバー
  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        RegisterPage.modeChange.pageTitleName,
        style: const TextStyle(
          color: BaseColor.someTextPopupArea,
          fontSize: BaseFont.font28px,
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: BaseColor.baseColor.withOpacity(0.7),
      actions: buildActions(),
    );
  }

  /// メニューに戻るボタン
  List<Widget> buildActions() {
    String callFunc = 'buildActions';
    return <Widget>[
      SoundTextButton(
        onPressed: () {
          Get.back();
        },
        callFunc: '$callFunc メニューに戻る',
        child: const Row(
          children: <Widget>[
            Icon(
              Icons.close,
              color: BaseColor.someTextPopupArea,
              size: 45,
            ),
            SizedBox(
              width: 19,
            ),
            Text(
              'メニューに戻る',
              style: TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font18px,
              ),
            ),
          ],
        ),
      ),
    ];
  }

}