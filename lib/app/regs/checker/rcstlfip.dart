/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcsg_com.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcstfip.c
class RcStFip {

  ///  関連tprxソース: rcstfip.c - rcFIP_Reverse_Tran
  static void rcFIPReverseTran(String fipNo, int proc) {
    // TODO:00008 宮家 中身の実装予定　
    return;
  }

  ///  関連tprxソース: rcstfip.c - rcFIP_Start_Scroll
  static void rcFIPStartScroll(String fipNo, int imgNo1, int imgNo2) {
    // TODO:00008 宮家 中身の実装予定　
    return;
  }

  ///  関連tprxソース: rcstfip.c - rcStlFip
  static void rcStlFip(int fipNo) {
    /// TODO:00010 長田 定義のみ追加
    return;
    /*
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }
    rcDspFipFStlScrn(fipNo);
    */
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rcstfip.c - rcDsp_FipF_Stlscrn
  static void rcDspFipFStlScrn(int fipNo) {}
}
