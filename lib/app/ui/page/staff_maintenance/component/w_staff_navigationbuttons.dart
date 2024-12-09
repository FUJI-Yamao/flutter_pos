/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colorfont/c_basecolor.dart';
///スクロールボタン
class NavigtionButtons extends StatelessWidget {
  ///左ボタンが押された時のコールバック関数
  final VoidCallback onLeftPressed;
  ///右ボタンが押された時のコールバック関数
  final VoidCallback onRightPressed;
  ///左ボタンが使用可能かどうか
  final bool canGoLeft;
  ///右ボタンが使用可能かどうか
  final bool canGoRight;

  const NavigtionButtons({
    super.key, required this.onLeftPressed, required this.onRightPressed,required this.canGoLeft,required this.canGoRight,
  });

  @override
  Widget build(BuildContext context) {
    ///有効状態と無効状態の背景色
    const activeBackgroundColor = BaseColor.scanButtonColor;
    final inactiveBackgroundColor = BaseColor.scanButtonColor.withOpacity(0.3);
    ///有効状態と無効状態のボーダーの色
    const activeSideColor = BorderSide(color: BaseColor.someTextPopupArea);
    final inactiveSideColor = BorderSide(color: BaseColor.someTextPopupArea.withOpacity(0.3));
    ///ボタン状態に基づいてアイコンの色を設定
    final iconColorLeft = BaseColor.someTextPopupArea.withOpacity(canGoLeft ? 1.0 : 0.3);
    final iconColorRight = BaseColor.someTextPopupArea.withOpacity(canGoRight ? 1.0 : 0.3);
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///左ボタン
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: canGoLeft
                  ?activeBackgroundColor
                  :inactiveBackgroundColor,
              side: canGoLeft ? activeSideColor : inactiveSideColor,
              fixedSize:  Size(72.w, 48.h),
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.h),
                  bottomLeft: Radius.circular(8.h),
                ),
              ),
            ),
            onPressed: canGoLeft ? onLeftPressed : null,
            child: CustomPaint(
              size:  Size(24.w, 24.h),
              painter: LeftTrianglePainter(
                color: iconColorLeft,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          ///右ボタン
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: canGoLeft
                  ?activeBackgroundColor
                  :inactiveBackgroundColor,
              side: canGoRight ? activeSideColor : inactiveSideColor,
              fixedSize: Size(72.w, 48.h),
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.h),
                  bottomRight: Radius.circular(8.h),
                ),
              ),
            ),
            onPressed:canGoRight ? onRightPressed : null,
            child: CustomPaint(
              size: Size(24.w, 24.w),
              painter: RightTrianglePainter(
                color: iconColorRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///ボタンの左側三角
class LeftTrianglePainter extends CustomPainter {
  final Color color;

  LeftTrianglePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0,size.height / 2.h)
      ..lineTo(size.width,size.height)
      ..close();

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(LeftTrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
///ボタンの右側三角
class RightTrianglePainter extends CustomPainter {
  final Color color;
  RightTrianglePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width,size.height / 2.h)
      ..lineTo(0,size.height)
      ..close();

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(RightTrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}