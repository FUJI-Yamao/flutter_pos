/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import '../colorfont/c_basecolor.dart';

/// リストがscroll可能かどうかを表すグラデーション.
class ScrollGradation extends StatelessWidget {
  const ScrollGradation({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: true, // リストのscrollやボタン処理を阻害しないように、イベントを無効にする.
        child: Container(
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  BaseColor.registerScrollFrom.withOpacity(0.3), //始まりの色
                  BaseColor.registerScrollTo.withOpacity(0.3), //終わりの色
                ],
              ),
            )));
  }
}
