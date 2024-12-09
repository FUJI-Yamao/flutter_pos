/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:get/get.dart';

import '../../ui/page/change_coin_connection/p_change_coin_connection_page.dart';

///関連tprxソース:rckycpwr.h - CPWR_DISPDATA
enum CpwrDispData {
  CPWR_NONDISP(0),
  CPWR_LCDDISP(1),
  CPWR_SUBDISP(2);

  final int value;
  const CpwrDispData(this.value);
}

///  関連tprxソース: rckycpwr.h - CPWR
class Cpwr {
  static CpwrDispData now_display = CpwrDispData.CPWR_NONDISP;
  
  /// 釣機ON/OFFの状態を取得（引数：なし）
  /// パラメータ：なし
  /// 戻り値：(釣札機状態, 釣銭機状態)
  static (int, int) getChangeStatus() {
    // 釣札機状態 ON=1、OFF=0
    // 釣銭機状態 ON=1、OFF=0
    // 上記の二つを返す
    // TODOバックエンド側で値を取得する処理を追記
    var ret = (0, 0);
    return ret;
  }

  /// 釣機のON/OFFを設定する
  /// パラメータ：釣札機（0）または釣銭機（1）、ON（1）またはOFF（0）、
  /// 戻り値：errorNo
  static int setChangeStatus(int changeKind, int onOrOff) {
    // todo バックエンド処理追加
    // バックエンドと結合時に以下は削除する
    int errorNo = 0;
    // errorNo = 2251;
    // if () { // TODO バックエンド：エラーになる条件式を入れる
    //   // エラーの場合
    //   errorNo = 2251;
    // }
    return errorNo;
  }
}
