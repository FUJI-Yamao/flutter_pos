/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工​
 *
 * CONFIDENTIAL/社外秘​
 *
 * 無断開示・無断複製禁止
 */

/// submenu icon component
import 'package:flutter/material.dart';

class RotatingLine extends StatelessWidget {
  final Color color;
  final double size;

  const RotatingLine({
    super.key,
    this.color = Colors.white,
    this.size = 6,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _RotatingLinePainter(color),
    );
  }
}

class _RotatingLinePainter extends CustomPainter {

  final Color color;
  _RotatingLinePainter( this.color);

  @override
  void paint(Canvas canvas,Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0,0);
    path.lineTo(0,6);
    path.lineTo(6,6);
    canvas.drawPath(path, paint);

  }
  @override
  bool shouldRepaint (_RotatingLinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}