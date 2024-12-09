/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../backend/update/mupd_c.dart';

/// ヘッダー部コントローラー
class RegisterHeadController extends GetxController {
  // オンラインアイコン切替
  RxBool isTsServerOnline = true.obs;

  // メッセージ数管理
  final numberOfMsg = 3.obs;    // 確認用に3にしておく
  // 日時
  final now_time = ''.obs;
  // 日時
  final now_date = ''.obs;
  // ストライプ
  final stripe = false.obs;

  // オンライン切替
  void setTsServerStatus(bool isOnline) {
    isTsServerOnline.value = isOnline;
  }

  // メッセージを見る
  void showMessage(){
    numberOfMsg.value = 0;
    // メッセージを見たら、見たメッセージ分カウントを減らすようにする
    Get.defaultDialog(title: 'メッセージを見た分だけ数値を減らす処理');

  }

  // お気に入りを開く？
  void callFavorite(){
    // お気に入りを開く？
    Get.defaultDialog(title: 'お気に入りのプルダウンメニュー？');

  }

  // 日時
  void _onTimer(Timer timer) {
    var new_now = DateFormat('yyyy/MM/dd HH:mm').format(DateTime.now());
    var new_datetime= new_now.split(' ');
    // 1：月～7：日　enumが0～6のため[-1]
    int weekday = DateTime.now().weekday - 1;

    now_date.value = '${new_datetime[0]}(${WeekDays.values[weekday].dayofweek})';

    now_time.value = ' ${new_datetime[1]}';

  }

  @override
  void onInit() {
    super.onInit();

    /// 実績上げのステータス通知のコールバック登録
    MupdCConsole().registerStatusCallback(setTsServerStatus);
  }

  @override
  void onReady() {
    super.onReady();

    // タイマーセット
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  @override
  void onClose() {
    super.onClose();

    /// 実績上げのステータス通知のコールバック登録
    MupdCConsole().removeStatusCallback();
  }

}

// 曜日
enum WeekDays {
  Monday(dayofweek: "月"),
  Tuesday(dayofweek: "火"),
  Wednesday(dayofweek: "水"),
  Thursday(dayofweek: "木"),
  Friday(dayofweek: "金"),
  Saturday(dayofweek: "土"),
  Sunday(dayofweek: "日");

  const WeekDays({required this.dayofweek});

  final String dayofweek;
}
