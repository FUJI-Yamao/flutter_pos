/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';

class RckyCash {
  /// 関連tprxソース: rckycash.c - ContinueRprChk
  static Future<int> ContinueRprChk() async {
    if (!(await CmCksys.cmPrinterContinueSystem() == 0)) {
      return 0;
    }
    if ((await RcSysChk.rcSGChkSelfGateSystem()) ||
        (await RcSysChk.rcQCChkQcashierSystem())) {
      return 0;
    }
    if (RcSysChk.rcCheckEsVoidProc()) {
      return 0;
    }
    return 1;
  }
}
