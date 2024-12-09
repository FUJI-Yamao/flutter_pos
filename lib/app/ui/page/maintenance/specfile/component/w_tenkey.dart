/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import '../../../../component/w_sound_buttons.dart';
import '../controller/c_key_controller_base.dart';
import '../../../common/component/w_msgdialog.dart';

/// テンキーWidget
abstract class Content {}

class TextContent extends Content {
  TextContent(this.text);

  final String text;
}

class IconContent extends Content {
  IconContent(this.iconData);

  final IconData iconData;
}

/// テンキーWidget
class TenkeyWidget extends StatelessWidget {
  TenkeyWidget({
    super.key,
    required this.controller,
    this.dispTab = false,
  });

  final KeyControllerBase controller;
  bool dispTab;
  static const double keySpace = 8;

  Widget build(BuildContext context) {
    KeyControllerBase c = controller;
    return Container(
      decoration: BoxDecoration(
          color: BaseColor.maintainTenkeyBG,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Flex(
        direction: Axis.vertical,
        children: [
          for (int j = 0; j <= 2; j++) ...{
            Flex(
              direction: Axis.horizontal,
              children: [
                for (int i = 7 - j * 3; i <= 9 - j * 3; i++) ...{
                  NumberWidget(
                    content: TextContent(i.toString()),
                    topSide: j == 0 ? true : false,
                    rightSide: (i % 3 == 0) ? true : false,
                    oncallback: () => c.pushInputKey(i),
                  ),
                  if (i != 9 - j * 3) const SizedBox(width: keySpace)
                }
              ],
            ),
            if (j != 2) const SizedBox(height: keySpace)
          },
          const SizedBox(height: keySpace),
          Flex(
            direction: Axis.horizontal,
            children: [
              NumberWidget(
                content: TextContent('0'),
                topSide: false,
                rightSide: false,
                oncallback: () => c.pushInputKey(0),
              ),
              const SizedBox(width: keySpace),
              NumberWidget(
                content: IconContent(Icons.backspace),
                topSide: false,
                rightSide: false,
                oncallback: () => c.deleteOneChar(),
              ),
              const SizedBox(width: keySpace),
              NumberWidget(
                content: TextContent('C'),
                topSide: false,
                rightSide: true,
                isSpecialButton: true,
                oncallback: () => c.clearString(),
              ),
            ],
          ),
          if (dispTab) ...{
            SizedBox(
              height: 8.h,
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                NumberWidget(
                  disptab: dispTab,
                  content: TextContent('|←'),
                  topSide: false,
                  rightSide: false,
                  oncallback: () => c.tabKey(false),
                ),
                const SizedBox(width: keySpace),
                NumberWidget(
                  disptab: dispTab,
                  content: TextContent('→|'),
                  topSide: false,
                  rightSide: true,
                  oncallback: () => c.tabKey(true),
                ),
              ],
            ),
          }
        ],
      ),
    );
  }
}

/// 数値用のWidget
class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    this.disptab = false,
    required this.content,
    required this.topSide,
    required this.rightSide,
    required this.oncallback,
    this.isSpecialButton = false,
  });

  final bool disptab;
  final Content content;
  final bool topSide;
  final bool rightSide;
  final Function oncallback;
  final bool isSpecialButton;

  Widget build(BuildContext context) {
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
            child: Stack(children: [
              Container(
                alignment: Alignment.center,
                height: disptab ? 80.h : 95.h,
                // タブキーの大きさ: 通常数字χの横幅×3列 + 数字キーの隙間*2 からタブキーの隙間を１つ引いて、それを2で割ったもの
                width: disptab
                    ? ((100.w * 3 +
                            TenkeyWidget.keySpace * 2 -
                            TenkeyWidget.keySpace) /
                        2)
                    : 100.w,
                child: content is TextContent
                    ? Text(
                        (content as TextContent).text,
                        style: const TextStyle(
                          fontSize: BaseFont.font30px,
                          color: BaseColor.maintainTenkeyText,
                          fontWeight: FontWeight.bold,
                          fontFamily: BaseFont.familyNumber,
                        ),
                      )
                    : Icon(
                        (content as IconContent).iconData,
                        color: BaseColor.maintainTenkeyText,
                        size: 30,
                      ),
              ),
              if (content is IconContent)
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: BaseColor.maintainTenkeyAccent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    width: disptab
                        ? ((100.w * 3 +
                                TenkeyWidget.keySpace * 2 -
                                TenkeyWidget.keySpace) /
                            2)
                        : 100.w,
                    height: 10,
                  ),
                ),
            ])));
  }
}
