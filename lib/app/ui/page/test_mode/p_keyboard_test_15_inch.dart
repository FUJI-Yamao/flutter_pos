/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

///　１５インチＬＣＤ表示ページ
class KeyboardTestPage15InchWidget extends StatefulWidget {
  const KeyboardTestPage15InchWidget({super.key});

  @override
  State<KeyboardTestPage15InchWidget> createState() =>
      _KeyboardTestPage15InchWidgetState();
}

class _KeyboardTestPage15InchWidgetState
    extends State<KeyboardTestPage15InchWidget> {
  List<Widget> containers = <Widget>[];
  List<Color> containersColor = <Color>[];
  static const double _minWidth = 63.0;
  static const double _minHeight = 63.0;
  static const double _margin = 1.0;

  _KeyboardTestPage15InchWidgetState();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    double screenWidth = size.width - padding.left - padding.right - 1;
    // 「-1」をしないと、horizontalCount分並べたときに、途中で折り返される
    double screenHeight = size.height - padding.top - padding.bottom;
    int horizontalCount = (screenWidth / _minWidth).round();
    double containerWidth = screenWidth / horizontalCount; //
    int verticalCount = (screenHeight / _minHeight).round();
    double containerHeight = screenHeight / verticalCount;

    if (containers.isEmpty == true) {
      int i = 0;
      for (i = 0; i < 600; i++) {
        containersColor.add(const Color(0xff89a08a));
      }
    }

    return Scaffold(
        body: Wrap(
      children: [
        for (int i = 0; i < horizontalCount * verticalCount; i++) ...[
          Container(
            width: containerWidth - (_margin * 2),
            height: containerHeight - (_margin * 2),
            margin: const EdgeInsets.all(_margin),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return containersColor[i];
                      // Defer to the widget's default.
                    },
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xff465d57);
                      }
                      return null;
                    },
                  ),
                ),
                onPressed: () => {
                      if (i == 0 || i == horizontalCount * verticalCount - 1) {
                        Get.back()
                      } else if (containersColor[i] == const Color(0xffd6cfc2)) {
                        containersColor[i] = const Color(0xff89a08a)
                      } else {
                        containersColor[i] = const Color(0xffd6cfc2)
                      }
                    },
                child: (i == 0 || i == horizontalCount * verticalCount - 1)
                    ? Text(('終了').toString())
                    : Text(('').toString())),
          )
        ],
      ],
    ));
  }
}
