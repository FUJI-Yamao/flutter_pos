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
import 'rc_tab.dart';

/// 関連tprxソース: rcky_tab.c
class RckyTab{
  static TabInfo tabInfo = TabInfo();
  /// todo 動作未確認
  /// 関連tprxソース: rcky_tab.c - rcCheck_Chkr_Tab
  static int rcCheckChkrTab()
  {
    int errNo;
    AcMem cMem = SystemFunc.readAcMem();

    errNo = RcRctFil.rcTabChkRctFile(RegsMem(), cMem, RcRctFil.RCRCT_CHECK);
    return(errNo);
  }

  /// todo 動作未確認
  /// 関連tprxソース: rcky_tab.c - rcCheck_Cash_Tab
  static int rcCheckCashTab()
  {
    int errNo;
    AcMem cMem = SystemFunc.readAcMem();

    errNo = RcRctFil.rcTabCashRctFile(RegsMem(), cMem, RcRctFil.RCRCT_CHECK);
    return(errNo);
  }
}
