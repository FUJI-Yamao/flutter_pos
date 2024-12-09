/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/sysdate.dart';
import '../inc/rc_mem.dart';

/// 関連tprxソース: rc_setdate.c
class RcSetDate {

  /// 関連tprxソース: rc_setdate.c - rc_Set_Date
  static Future<void> rcSetDate() async {
    if (RcSysChk.rcCheckWiz()) {
      return;
    }
    await rcSetDateBkupClr();

    AcMem cMem = SystemFunc.readAcMem();
    cMem.date = SysDate().cmReadSysdate();
    final formatDate = sprintf("%04i/%02i/%02i %02i:%02i:%02i\n",
                                [
                                  cMem.date!.year,
                                  cMem.date!.month,
                                  cMem.date!.day,
                                  cMem.date!.hour,
                                  cMem.date!.minute,
                                  cMem.date!.second
                                ]);
    RegsMem().tHeader.endtime = formatDate;
    RegsMem().tHeader.sale_date = RxCommonBuf().dbOpenClose.sale_date;
    cMem.bkupNowSaleDatetime = RegsMem().tHeader.endtime;
    cMem.bkupSaleDate = RegsMem().tHeader.sale_date;
  }

  /// 関連tprxソース: rc_setdate.c - rc_Set_Date_Bkup_Clr
  static Future<void> rcSetDateBkupClr() async {
    AcMem cMem = SystemFunc.readAcMem();
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
      "rcSetDateBkupClr");

    cMem.bkupNowSaleDatetime = String.fromCharCode(0x00);
    cMem.bkupSaleDate = String.fromCharCode(0x00);
    return;
  }
}