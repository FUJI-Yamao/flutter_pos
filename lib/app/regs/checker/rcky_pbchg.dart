/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';

/// 関連tprxソース: rcky_pbchg.c
class RckyPbchg {
  /// 関連tprxソース: rcky_pbchg.c - rcPbchgFeeRecCheck
  static bool rcPbchgFeeRecCheck(int p) {
    if (p < 0) {
      return false;
    }
    RegsMem mem = SystemFunc.readRegsMem();
    return (mem.tItemLog[p].t10003.recMthdFlg ==
        REC_MTHD_FLG_LIST.PBCHG_FEE1_REC.typeCd); // STAMP ?
  }
}
