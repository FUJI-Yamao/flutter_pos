/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';

///  関連tprxソース: rckyselpluadj.c
class RcKySelpluadj {
  /// 個別精算中かチェックする
  /// 戻り値: true=上記状態  false=上記状態でない
  /// 関連tprxソース: rckyselpluadj.c - rcky_SelPluAdj_SelctMode
  static Future<bool> rckySelPluAdjSelctMode() async {
    RegsMem mem = SystemFunc.readRegsMem();
    return ((await CmCksys.cmSelpluadjSystem() != 0) &&
      (mem.tmpbuf.selpluadjFlg != 0));
  }
}