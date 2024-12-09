/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../lib/cm_sys/cm_cksys.dart';
import '../../regs/inc/rc_mem.dart';
import '../../common/cmn_sysfunc.dart';

class RcDishCalc{
  ///  関連tprxソース: rcdishcalc.c - rcCheck_Dish_Mode
  static Future<bool> rcCheckDishMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    int decide = cMem.stat.dishMode;
    return((await cmDishcalcSystem()) && (decide > 0));
  }

  ///  関連tprxソース: rcdishcalc.c - cm_dishcalc_system
  static Future<bool> cmDishcalcSystem() async {
    return( await CmCksys.cmDishCalcsystem() == 1);
  }
}