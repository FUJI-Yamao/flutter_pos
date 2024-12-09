/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../fb/fb2gtk.dart';
import '../../fb/fb_lib.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';
import 'rcsyschk.dart';

class RcTimer{
  static List<int> rcTimer = List<int>.generate(RC_TIMER_LISTS.RC_TIMER_MAX.id, (index) => 0);	// タイマー値. ゼロクリア

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 引数のタイマー値が動作しているか返す.
  /// 関連tprxソース: rc_timer.c - rc_TimerList_Run(RC_TIMER_LISTS num)
  /// 引数: RC_TIMER_LISTS num
  /// 戻り値: true: 動作中、 false: 終了
  static bool rcTimerListRun(RC_TIMER_LISTS num) {
    String erlog = "";

    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 引数のタイマー管理番号(num)において, 関数(timer_func)を一定時間後(interval)に起動させる.
  /// 関連tprxソース: rc_timer.c - rc_TimerList_Add
  ///        (RC_TIMER_LISTS num, int interval, void *timer_func, gpointer data)
  /// 引数: num: タイマー管理番号
  ///      timer_func: タイマー起動させる関数(基本的には引数としてgpointerを持つ関数となる)
  ///      interval: 単位はミリ秒
  ///      data: timer_funcに渡す引数
  /// 戻り値: メッセージ番号
  static int rcTimerListAdd
      (RC_TIMER_LISTS num, int interval,void timer_func, void data){
    return 0;
  }

  ///	関数: rc_TimerList_Remove()
  ///	機能: 引数のタイマー管理番号で動作したタイムアウト動作を開放(停止)させる. これを行わない場合, 繰り返し動作する.
  ///	      rc_TimerList_Add() での引数の管理番号と, 本関数の管理番号は同一でないと停止しない
  ///	引数: num: タイマー管理番号
  /// 関連tprxソース: rc_timer.c - rc_TimerList_Remove
  static Future<void> rcTimerListRemove(int num) async {
    String erlog = '';

    if ((num < 0) || (num >= RC_TIMER_LISTS.RC_TIMER_MAX.id)) {
      erlog = "rcTimerListRemove abnormal num[$num]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, erlog);
      return;
    }

    if ((rcTimer[num] > 0) && (rcTimer[num] <= FbLibDef.TIMER_MAX)) {
      Fb2Gtk.gtkTimeoutRemove(rcTimer[num]);
    }
    else if (rcTimer[num] != 0) {
      erlog = "rcTimerListRemove abnormal value[$num][${rcTimer[num]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, erlog);
    }
    rcTimer[num] = 0;
  }
}