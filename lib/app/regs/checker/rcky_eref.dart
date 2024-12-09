/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import 'rc_elog.dart';

///  関連tprxソース: rcky_eref.c
class RckyEref {
  static ERef eRef = SystemFunc.readEref();
  static RegsMem eRefVoidMem = SystemFunc.readRegsMem();
  static RegsMem eRefRefMem = SystemFunc.readRegsMem();

  /// Confirm Dialog
  ///  関連tprxソース: rcky_eref.c - ERef_PopUp
  // TODO:00004　小出　定義のみ追加する。
  static void eRefPopUp(int err_no) {
    //DialogErr(err_no, 1);
  }

  ///  関連tprxソース: rcky_eref.c - LoadItemToTotalDisp
  static void loadItemToTotalDisp() {
    RegsMem mem = SystemFunc.readRegsMem();
    eRefVoidMem = mem;
    mem = eRefRefMem;
  }
}