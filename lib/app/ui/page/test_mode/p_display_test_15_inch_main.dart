/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

///　１５インチＬＣＤ表示（main）ページ
class DisplayTestPage15InchMainWidget extends StatefulWidget {
  const DisplayTestPage15InchMainWidget({super.key});

  @override
  State<DisplayTestPage15InchMainWidget> createState() =>
      _DisplayTestPage15InchMainWidgetState();
}

class _DisplayTestPage15InchMainWidgetState
    extends State<DisplayTestPage15InchMainWidget> {
  int index = 0;

  ///　画面表示テスト用のカラーセットリスト
  List<dynamic> colorList = [
    const Color(0xffFF0000),
    const Color(0xff0000FF),
    const Color(0xff00FF00),
    const Color(0xff00FFFF),
    const Color(0xffFF00FF),
    const Color(0xffFFFFFF),
    const Color(0xff000000),

    /// グラデーション　
    const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff000000), Color(0xffFFFFFF)],
      tileMode: TileMode.repeated,
    ),
    const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xffFFFFFF), Color(0xff000000)],
      tileMode: TileMode.repeated,
    ),
    const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xff000000), Color(0xffFFFFFF)],
      tileMode: TileMode.repeated,
    ),
    const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xffFFFFFF), Color(0xff000000)],
      tileMode: TileMode.repeated,
    ),
  ];

  _DisplayTestPage15InchMainWidgetState();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), changeContainer);
  }

  void changeContainer() {
    if (mounted) {
      index++;
      index = index % colorList.length;

      setState(() {});
      Timer(const Duration(seconds: 2), changeContainer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          decoration: BoxDecoration(
            color: (colorList[index] is Color) ? colorList[index] : null,
            gradient: (colorList[index] is LinearGradient) ? colorList[index] : null,
          ),
        ),
      ),
    );
  }
}
