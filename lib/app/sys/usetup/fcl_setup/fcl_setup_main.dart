/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../fb/fb2gtk.dart';
import '../../../inc/sys/tpr_dlg.dart';

class FclSetupMain{
  static int utTimer = -1;

  /// 関連tprxソース: fcl_setup_main.c - UtTimerInit
  static void utTimerInit(){
    utTimer = -1;
  }

  /// 関連tprxソース: fcl_setup_main.c - UtTimerAdd
  static int utTimerAdd(int timer, Function func){
    if(utTimer != -1){
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }
    utTimer = Fb2Gtk.gtkTimeoutAdd(timer, func, 0);
    return 0;
  }

  /// 関連tprxソース: fcl_setup_main.c - UtTimerRemove
  static void utTimerRemove(){
    if(utTimer != -1){
      Fb2Gtk.gtkTimeoutRemove(utTimer);
      utTimerInit();
    }
  }
}