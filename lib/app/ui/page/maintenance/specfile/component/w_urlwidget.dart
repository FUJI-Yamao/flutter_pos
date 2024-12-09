/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../component/w_sound_buttons.dart';
import '../controller/c_keyboard_controller.dart';
import 'w_tenkey.dart';

/// キーボードWidget
class UrlWidget extends StatelessWidget {
  UrlWidget({
    super.key,
    required this.controller,
    this.dispTab = false,
  });

  final KeyboardController controller;
  bool dispTab;
  static const double keySpace = 7;

  Widget build(BuildContext context) {
    KeyboardController c = controller;
    String firLinStr = 'CLR';
    String firstLine = '/-ー;:,.';
    String shif = 'Shift';
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              for (int i = 1; i <= 10; i++) ...{
                i == 1
                    ? KeyBordFirGraWidget(
                        content: TextContent(firLinStr),
                        isRed: i == 1 ? true : false,
                        isBlack: i == 2 || i == 3 ? true : false,
                        isBlue: false,
                        isDouble: false,
                        isSpace: false,
                        blueLine: false,
                        redLine: false,
                        topSide: true,
                        rightSide: (i % 10 == 0) ? true : false,
                        oncallback: () => c.clearString(),
                      )
                    : i == 2 || i == 3
                        ? KeyBordFirGraWidget(
                            content: TextContent(''),
                            isRed: false,
                            isBlack: true,
                            isBlue: false,
                            isDouble: false,
                            isSpace: false,
                            blueLine: false,
                            redLine: false,
                            topSide: true,
                            rightSide: (i % 10 == 0) ? true : false,
                            oncallback: () => c.addString(''),
                          )
                        : KeyBordFirGraWidget(
                            content: TextContent(firstLine[i - 4]),
                            isRed: false,
                            isBlack: false,
                            isBlue: false,
                            isDouble: false,
                            isSpace: false,
                            blueLine: false,
                            redLine: false,
                            topSide: true,
                            rightSide: (i % 10 == 0) ? true : false,
                            oncallback: () => c.addString(firstLine[i - 4]),
                          ),
                const SizedBox(width: keySpace),
              }
            ],
          ),
          const SizedBox(height: keySpace),
          Obx(
            () => Flex(
              direction: Axis.horizontal,
              children: [
                for (int i = 1; i <= 10; i++) ...{
                  KeyBordSecGraWidget(
                    symbol: c.symbols[i - 1],
                    topSide: false,
                    rightSide: (i % 10 == 0) ? true : false,
                    oncallback: () => c.addString(c.symbols[i - 1]),
                  ),
                  const SizedBox(width: keySpace)
                }
              ],
            ),
          ),
          const SizedBox(height: keySpace),
          Flex(
            direction: Axis.horizontal,
            children: [
              for (int i = 1; i <= 10; i++) ...{
                KeyBordFirGraWidget(
                  content: i == 10
                      ? TextContent(0.toString())
                      : TextContent(i.toString()),
                  isRed: false,
                  isBlack: false,
                  isBlue: false,
                  isDouble: false,
                  isSpace: false,
                  blueLine: false,
                  redLine: false,
                  topSide: false,
                  rightSide: (i % 10 == 0) ? true : false,
                  oncallback: () => i == 10
                      ? c.addString(0.toString())
                      : c.addString(i.toString()),
                ),
                const SizedBox(width: keySpace),
              }
            ],
          ),
          const SizedBox(height: keySpace),
          Obx(
            () => Flex(
              direction: Axis.horizontal,
              children: [
                for (int i = 1; i <= 10; i++) ...{
                  KeyBordFirGraWidget(
                    content: TextContent(c.keyBordStr1.value[i - 1]),
                    isRed: false,
                    isBlack: false,
                    isBlue: false,
                    isDouble: false,
                    isSpace: false,
                    blueLine: false,
                    redLine: false,
                    topSide: false,
                    rightSide: (i % 10 == 0) ? true : false,
                    oncallback: () => c.addString(c.keyBordStr1.value[i - 1]),
                  ),
                  const SizedBox(width: keySpace),
                }
              ],
            ),
          ),
          const SizedBox(height: keySpace),
          Obx(
            () => Flex(
              direction: Axis.horizontal,
              children: [
                for (int i = 1; i <= 10; i++) ...{
                  KeyBordFirGraWidget(
                    content: i != 10
                        ? TextContent(c.keyBordStr2.value[i - 1])
                        : IconContent(Icons.backspace),
                    isRed: false,
                    isBlack: false,
                    isBlue: false,
                    isDouble: false,
                    isSpace: false,
                    blueLine: false,
                    redLine: i != 10 ? false : true,
                    topSide: false,
                    rightSide: (i % 10 == 0) ? true : false,
                    oncallback: () => i != 10
                        ? c.addString(c.keyBordStr2.value[i - 1])
                        : c.deleteOneChar(),
                  ),
                  const SizedBox(width: keySpace),
                }
              ],
            ),
          ),
          const SizedBox(height: keySpace),
          Obx(
            () => Flex(
              direction: Axis.horizontal,
              children: [
                for (int i = 1; i <= 9; i++) ...{
                  KeyBordFirGraWidget(
                    content: i == 1
                        ? TextContent('')
                        : i == 9
                            ? TextContent(shif)
                            : TextContent(c.keyBordStr3.value[i - 2]),
                    isRed: false,
                    isBlack: i == 1 ? true : false,
                    isBlue: false,
                    isDouble: i == 9 ? true : false,
                    isSpace: false,
                    blueLine: i == 9 ? true : false,
                    redLine: false,
                    topSide: false,
                    rightSide: (i % 9 == 0) ? true : false,
                    oncallback: () => i == 1
                        ? {}
                        : i == 9
                            ? c.toggleShift()
                            : c.addString(c.keyBordStr3.value[i - 2]),
                  ),
                  const SizedBox(width: keySpace),
                }
              ],
            ),
          ),
          const SizedBox(height: keySpace),
          Flex(
            direction: Axis.horizontal,
            children: [
              KeyBordFirGraWidget(
                disptab: dispTab,
                content: TextContent('|←'),
                isRed: false,
                isBlack: false,
                isBlue: false,
                isDouble: false,
                isSpace: false,
                blueLine: true,
                redLine: false,
                topSide: false,
                rightSide: false,
                oncallback: () =>
                    c.inputBox.currentState?.setCursorPositionFirst(),
              ),
              const SizedBox(width: keySpace),
              KeyBordFirGraWidget(
                disptab: dispTab,
                content: TextContent('→|'),
                isRed: false,
                isBlack: false,
                isBlue: false,
                isDouble: false,
                isSpace: false,
                blueLine: true,
                redLine: false,
                topSide: false,
                rightSide: false,
                oncallback: () =>
                    c.inputBox.currentState?.setCursorPositionLast(),
              ),
              const SizedBox(width: keySpace),
              KeyBordFirGraWidget(
                disptab: dispTab,
                content: TextContent('←'),
                isRed: false,
                isBlack: false,
                isBlue: false,
                isDouble: false,
                isSpace: false,
                blueLine: true,
                redLine: false,
                topSide: false,
                rightSide: false,
                oncallback: () =>
                    c.inputBox.currentState?.setCursorPositionLeft(),
              ),
              const SizedBox(width: keySpace),
              KeyBordFirGraWidget(
                disptab: dispTab,
                content: TextContent('→'),
                isRed: false,
                isBlack: false,
                isBlue: false,
                isDouble: false,
                isSpace: false,
                blueLine: true,
                redLine: false,
                topSide: false,
                rightSide: false,
                oncallback: () =>
                    c.inputBox.currentState?.setCursorPositionRight(),
              ),
              const SizedBox(width: keySpace),
              KeyBordFirGraWidget(
                disptab: dispTab,
                content: TextContent('Space'),
                isRed: false,
                isBlack: false,
                isBlue: false,
                isDouble: false,
                isSpace: true,
                blueLine: false,
                redLine: false,
                topSide: false,
                rightSide: false,
                oncallback: () => c.addString(' '),
              ),
              const SizedBox(width: keySpace),
              KeyBordFirGraWidget(
                disptab: dispTab,
                content: TextContent('Enter'),
                isRed: false,
                isBlack: false,
                isBlue: true,
                isDouble: true,
                isSpace: false,
                blueLine: false,
                redLine: false,
                topSide: false,
                rightSide: true,
                oncallback: () => c.enterKey(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 数値用のWidget KeyBord2
class KeyBordFirGraWidget extends StatelessWidget {
  const KeyBordFirGraWidget({
    super.key,
    this.disptab = false,
    required this.content,
    required this.topSide,
    required this.rightSide,
    required this.oncallback,
    required this.isRed,
    required this.isBlack,
    required this.isBlue,
    required this.isDouble,
    required this.isSpace,
    required this.blueLine,
    required this.redLine,
    this.isSpecialButton = false,
  });

  final bool disptab;
  final Content content;
  final bool topSide;
  final bool rightSide;
  final Function oncallback;
  final bool isSpecialButton;
  final bool isRed;
  final bool isBlack;
  final bool isBlue;
  final bool isDouble;
  final bool isSpace;
  final bool blueLine;
  final bool redLine;

  Widget build(BuildContext context) {
    final color = isSpecialButton
        ? BaseColor.maintainTenkeyAccent
        : BaseColor.maintainTenkey;

    return Material(
        type: MaterialType.button,
        color: isRed
            ? BaseColor.maintainTenkeyAccent
            : isBlack
                ? BaseColor.maintainTenkeyNull
                : isBlue
                    ? BaseColor.maintainTitleBG
                    : color,
        borderRadius: BorderRadius.circular(5),
        child: SoundInkWell(
          onTap: () => oncallback(),
          callFunc: runtimeType.toString(),
          child: Container(
            alignment: Alignment.center,
            height: 55.h,
            width: disptab
                ? 125.w
                : isSpace
                    ? 381.w
                    : isDouble
                        ? 186.w
                        : 90.w,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: content is TextContent
                      ? Text(
                          (content as TextContent).text,
                          style: const TextStyle(
                              fontSize: 27,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )
                      : Icon(
                          (content as IconContent).iconData,
                          color: Colors.white,
                          size: 26,
                        ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: blueLine || isBlue
                          ? BaseColor.maintainTitleBG
                          : redLine || isRed
                              ? BaseColor.maintainTenkeyAccent
                              : isBlack
                                  ? BaseColor.maintainTenkeyNull
                                  : color,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    width: disptab
                        ? 125.w
                        : isSpace
                            ? 381.w
                            : isDouble
                                ? 186.w
                                : 90.w,
                    height: 4,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class KeyBordSecGraWidget extends StatelessWidget {
  const KeyBordSecGraWidget({
    required this.symbol,
    this.disptab = false,
    required this.topSide,
    required this.rightSide,
    required this.oncallback,
    this.isSpecialButton = false,
  });

  final String symbol;
  final bool disptab;
  final bool topSide;
  final bool rightSide;
  final Function oncallback;
  final bool isSpecialButton;

  @override
  Widget build(BuildContext context) {
    List<String> symbols = symbol.split("");
    String mainSymbol = symbols[0];
    String secondSymbol = symbols[1];
    final color = isSpecialButton
        ? BaseColor.maintainTenkeyAccent
        : BaseColor.maintainTenkey;
    return Material(
        type: MaterialType.button,
        color: color,
        borderRadius: BorderRadius.circular(5),
        child: SoundInkWell(
          onTap: () => oncallback(),
          callFunc: runtimeType.toString(),
          child: Container(
            alignment: Alignment.center,
            height: 55.h,
            width: disptab ? 130.w : 90.w,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                const SizedBox(width: 20),
                Container(
                  alignment: const Alignment(-1.0, -0.5),
                  child: Text(mainSymbol,
                      style: const TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 20),
                Container(
                  alignment: const Alignment(1.0, 0.5),
                  child: Text(secondSymbol,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                  //child:
                ),
              ],
            ),
          ),
        ));
  }
}
