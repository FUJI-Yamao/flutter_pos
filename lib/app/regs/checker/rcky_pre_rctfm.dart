/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcqr_com.dart';
import 'rcsyschk.dart';

class RckyPreRctfm {
  /// 関連tprxソース:rcky_pre_rctfm.c - rcSetPreRctfmFlg
  /// 宣言状態フラグの切替
  static Future<void> rcSetPreRctfmFlg(RC_FLG_TYPE setType) async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    RegsMem regsMem = SystemFunc.readRegsMem();
    int preRctfmFlgBkup;

    if (setType == RC_FLG_TYPE.RC_FLG_SWITCH) {
      if (atSingl.preRctfmFlg == 1) {
        atSingl.preRctfmFlg = 0;
      }
      else {
        atSingl.preRctfmFlg = 1;
      }
    }
    else if (setType == RC_FLG_TYPE.RC_FLG_OFF) {
      regsMem.tTtllog.t100001Sts.preRctfmFlg = 0;
      preRctfmFlgBkup = atSingl.preRctfmFlg;
      atSingl.preRctfmFlg = 0;

      // QCashierで先入金取引を行った際【領収書あり】を選択したら、
      // プリカ引去取引にも領収書発行指示を引き継ぐ
      if ( ((await RcSysChk.rcChkCogcaSystem()) || RcSysChk.rcChkRepicaSystem())
          ||  RcSysChk.rcChkValueCardSystem()
          ||  (await RcSysChk.rcChkAjsEmoneySystem())
              &&  await RcSysChk.rcQCChkQcashierSystem() ) {
        if (regsMem.tmpbuf.autoCallReceiptNo != 0 && regsMem.tmpbuf.autoCallMacNo != 0) {
          if (regsMem.tmpbuf.autoCallReceiptNo != RcqrCom.qrReadReptNo) {
            atSingl.preRctfmFlg = preRctfmFlgBkup;
          }
        }
      }
    }
  }
  /// 印字前に実際に領収書を発行して良いかチェック  (宣言は, 基本的にどの状態でも可能なため)
  /// TRUE: 領収書付印字する  FALSE: しない
  /// 関連tprxソース: rcky_pre_rctfm.c - rc_TaxFree_Chk_TaxFreeIn
  static Future<bool> rcChkPreRctfmPrint() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem regsMem = SystemFunc.readRegsMem();

    if ((atSing.preRctfmFlg == 0) // フラグチェック
        || (regsMem.tHeader.prn_typ != PrnterControlTypeIdx.TYPE_RCPT.index) // 通常レシートのみ
//        || (rcChkRfmAmount() != 0) // 金額チェック
//        || (rcChkRfmSystem() != 0) // 承認キーなどチェック
        || (await RcFncChk.rcCheckVoidComDispMode()) // 各訂正モード状態はNG
        || (regsMem.tTtllog.t100002Sts.warikanFlg != 0)) // 複数印字タイプは未対応
    {
      return false;
    }
    return true;
  }

// 明細付領収書にするためのフラグセット
  static void rcSetPreRctfmPrintFlg() {
    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tTtllog.t100001Sts.preRctfmFlg = 1;
  }
}