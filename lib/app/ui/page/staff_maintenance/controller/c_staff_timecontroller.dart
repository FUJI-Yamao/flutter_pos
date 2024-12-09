/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:get/get.dart';

///システム日付のコントローラー
class TimeController extends GetxController {
  ///現在時刻
  var currentTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _updateTime();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  ///現在時刻の更新
  void _updateTime() {
    final now = DateTime.now();
    final weekdays = ['日', '月', '火', '水', '木', '金', '土',];
    currentTime.value =
    '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString()
        .padLeft(2, '0')}'
        '(${weekdays[now.weekday % 7]})\n'
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(
        2, '0')}';
  }
}