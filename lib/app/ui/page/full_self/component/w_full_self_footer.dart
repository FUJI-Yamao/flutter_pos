/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

import '../enum/e_full_self_kind.dart';
import 'w_full_self_camera.dart';
import 'w_full_self_footer_lower_buttons.dart';

/// カメラ画像とボタン
class FullSelfFooter extends StatelessWidget {
  const FullSelfFooter({
    super.key,
    required this.fullSelfKind,
    // デフォルト引数は不可能
    this.upperRow,
  });

  /// フッターが表示されるフルセルフ画面の種類
  final DisplayingFooterFullSelfKind fullSelfKind;
  /// フッター上部に表示するウィジェット
  final Widget? upperRow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // カメラ画像
        // TODO: 7月末の検定において非表示。最終的には常に表示なので削除
        //　GetxControllerで映像を管理
        const Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: FullSelfCamera(),
        ),
        const SizedBox(width: 16.0,),
        // 全てのボタン
        Expanded(
          child: allButtons(),
        ),
      ],
    );
  }

  /// 全てのボタン
  Widget allButtons() {
    return Column(
      children: [
        // 画面側から渡ってきた、footer上部に表示するウィジェット
        upperRow ?? const SizedBox(height: 56.0),
        const SizedBox(height: 16.0,),
        // 下側にある店員呼び出しからボタンまでのボタン
        FullSelfFooterLowerButtons(fullSelfKind: fullSelfKind,),
      ],
    );
  }

}