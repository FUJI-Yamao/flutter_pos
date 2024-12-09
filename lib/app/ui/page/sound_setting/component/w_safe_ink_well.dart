/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

import '../../../../inc/sys/tpr_log.dart';

/// 連打対策のInkWell
class SafeInkWell extends StatefulWidget {
  const SafeInkWell({super.key, required this.borderRadius, required this.onTap});

  final BorderRadius borderRadius;
  final GestureTapCallback onTap;

  @override
  State<StatefulWidget> createState() => SafeInkWellState();
}

class SafeInkWellState extends State<SafeInkWell> {
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: widget.borderRadius,
      onTap: _isDisabled ? null : _onTap,
    );
  }

  void _onTap() {
    // ボタンを無効にする
    setState(() {
      _isDisabled = true;
    });

    // 300ミリ秒後にボタンを有効にする
    Future.delayed(const Duration(milliseconds: 300), () async {
      setState(() {
        _isDisabled = false;
      });
    });

    TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal, "Tap button");

    // onTap時の処理を実行する
    widget.onTap();
  }
}
