/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import '../inc/rcrctfil.dart';

/// 関連tprxソース: rcky_sus.c
class RckySus{
  /// 関連tprxソース: rcky_sus.c - rcCheck_Suspend
  static Future<int> rcCheckSuspend() async {
  int errNo = 0;
  AcMem cMem = SystemFunc.readAcMem();

  switch(await RcSysChk.rcKySelf()) {
  case RcRegs.KY_CHECKER  :
    errNo = await RcRctFil.rcChkRctFile(RegsMem(), cMem, RcRctFil.RCRCT_CHECK);
  break;
  case RcRegs.DESKTOPTYPE :
  case RcRegs.KY_SINGLE   :
  case RcRegs.KY_DUALCSHR :
    errNo = await RcRctFil.rcCashRctFile(RegsMem(), cMem, RcRctFil.RCRCT_CHECK);
  break;
  }
  return errNo;
  }

  /// todo 動作未確認
  /// 関連tprxソース: rcky_sus.c - rcCheck_Chkr_Sus
  static Future<int> rcCheckChkrSus() async
  {
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();

    errNo = await RcRctFil.rcChkRctFile(RegsMem(), cMem, RcRctFil.RCRCT_CHECK);
    return(errNo);
  }

  /// todo 動作未確認
  /// 関連tprxソース: rcky_sus.c - rcCheck_Cash_Sus
  static Future<int> rcCheckCashSus() async
  {
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();

    errNo = await RcRctFil.rcCashRctFile(RegsMem(), cMem, RcRctFil.RCRCT_CHECK);
    return(errNo);
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rcky_sus.c - rcKySus()
  static void rcKySus() {
    return;
  }
}
