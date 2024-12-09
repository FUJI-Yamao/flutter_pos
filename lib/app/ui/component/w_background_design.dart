/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';

import '../../inc/apl/rxregmem_define.dart';
import '../colorfont/c_basecolor.dart';

/// 背景に格子の編みかけ
class SpriteDesignMode extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    // 返品モード
    if (RegsMem().refundFlag) {
      _refundMode(canvas, size);
    }
    // 廃棄モード
    // 通常モード
  }

  void _refundMode(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = BaseColor.refunStripeColor
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // 格子の間隔
    const double step = 15.0;

    // 横線
    for (double i = 0; i <= size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // 縦線
    for (double i = 0; i <= size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}