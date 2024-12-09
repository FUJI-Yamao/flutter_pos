/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../controller/c_registerheader_controller.dart';

/// ストライプ
class StripedBackground extends StatelessWidget {
  final Color color;
  final double stripeWidth;
  final double spacing;
  final double angle;

  StripedBackground({
    required this.color,
    this.stripeWidth = 10.0,
    this.spacing = 10.0,
    this.angle = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    RegisterHeadController c = Get.put(RegisterHeadController());
    return Obx(
          () => c.stripe.value
          ? Container(
        color: Colors.white, // 背景色を指定します（必要に応じて変更してください）
        child: CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: _StripedBackgroundPainter(
              color, stripeWidth, spacing, angle),
        ),
      )
          : Container(),
    );
  }
}

class _StripedBackgroundPainter extends CustomPainter {
  final Color color;
  final double stripeWidth;
  final double spacing;
  final double angle;

  _StripedBackgroundPainter(
      this.color, this.stripeWidth, this.spacing, this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = stripeWidth;

    final double diagonalLength =
    math.sqrt(size.width * size.width + size.height * size.height);
    double x = -diagonalLength * math.sin(math.pi / 180 * angle);

    while (x < size.width * 2) {
      final start = Offset(x, 0);
      final end = Offset(
          x + size.height * math.tan(math.pi / 180 * angle), size.height);
      canvas.drawLine(start, end, paint);
      x += (stripeWidth + spacing) / math.sin(math.pi / 180 * angle);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
