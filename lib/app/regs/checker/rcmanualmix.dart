/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../inc/rp_print.dart';

class RcManualMix {
  /// 手動ミックスマッチ状態をチェックする
  /// 戻り値: 0:手動ミックスマッチではない  3:手動ミックスマッチ
  /// 関連tprxソース: rcmanualmix.c - rcManualMix_length()
  static int rcManualMixLength() {
    if (RpPrint.mem.tmpbuf.manualMixcd != 0) {
      return 3;
    }
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcmanualmix.c - rcClear_ManualMix_Code
  static void rcClearManualMixCode(){}

  // 実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcmanualmix.c - rc_Assort_ManualMix_Chk
  static bool rcAssortManualMixChk() {
    return false;
  }

  /// 関連tprxソース: rcmanualmix.c - rcChk_Assort_MmItm
  static Future<bool> rcChkAssortMmItm(int p) async {
    bool ret = false;

    if (await RcSysChk.rcChkAssortSystem()) {
      RegsMem mem = SystemFunc.readRegsMem();
      if ((mem.tmpbuf.assort[p].flg != 0) &&
          (mem.tItemLog[p].t10800Sts.bdlTyp == 1)) {
        ret = true;
      }
    }
    return (ret);
  }
}