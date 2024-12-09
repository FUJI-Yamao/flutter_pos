/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

/// 隠しボタン
class HiddenButton extends StatefulWidget {
  const HiddenButton({
    super.key,
    required this.onTap,
    required this.alignment,
  });

  /// ボタン押下時の処理
  final Function() onTap;
  /// ボタンの位置（右上の場合は、Alignment.topRight）
  final AlignmentGeometry alignment;

  @override
  HiddenButtonState createState() => HiddenButtonState();
}

class HiddenButtonState extends State<HiddenButton> {
  /// 隠しボタンをタップした回数
  int hiddenButtonClickCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pressingJudgment(widget.onTap),
      child: Align(
        alignment: widget.alignment,
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.transparent,
        ),
      ),
    );
  }

  /// ボタン押下の判定
  void _pressingJudgment(Function() onTap) {
    // 最初のタップから5秒経過すると、カウントをリセットする
    if (hiddenButtonClickCount == 0) {
      Future.delayed(const Duration(seconds: 5), () async {
        hiddenButtonClickCount = 0;
      });
    }

    // 押下回数のインクリメント
    hiddenButtonClickCount++;

    // 3回タップすると、ボタン押下されたとして、onTap関数をコールする
    if (hiddenButtonClickCount >= 3) {
      hiddenButtonClickCount = 0;
      onTap();
    }
  }
}
