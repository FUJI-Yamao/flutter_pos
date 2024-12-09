/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

import '../colorfont/c_basecolor.dart';

/// タブ切り替えボタンのグレーのボーダー
mixin TabControlGreyBorder {

  /// タブ切り替えボタンのグレーのボーダー
  Border border({
    required int idx,
    required int tabSelectedIndex,
  }) {
    if (tabSelectedIndex == idx) {
      /*
      　選択状態のボーダーの考え方
      　　・非選択状態にボーダーが追加されたため、
      　　　選択状態には幅2だけを付与し、ボーダー本体は存在させない
       */
      return const Border(
        bottom: BorderSide(
          width: 2.0,
          style: BorderStyle.none,
        ),
      );
    } else {
      /*
      　非選択状態のボーダーの考え方
      　　・下のボーダーは常に表示される
      　　・0番目の要素以外すべてに左側のボーダーを引く
      　　・選択状態の一つ手前（左側）のタブにだけ右側のボーダーを引く
      　　　→選択状態と非選択状態のボーダーを引く
       */
      return Border(
        bottom: BorderSide(
          color: BaseColor.edgeBtnColor.withOpacity(0.2),
          width: 2.0,
        ),
        left: (idx > 0)
            ? BorderSide(
          color: BaseColor.edgeBtnColor.withOpacity(0.2),
          width: 2.0,
        )
            : const BorderSide(
          width: 2.0,
          style: BorderStyle.none,
        ),
        right: (idx == tabSelectedIndex - 1)
            ? BorderSide(
          color: BaseColor.edgeBtnColor.withOpacity(0.2),
          width: 2.0,
        )
            : const BorderSide(
          width: 2.0,
          style: BorderStyle.none,
        ),
      );
    }
  }
}