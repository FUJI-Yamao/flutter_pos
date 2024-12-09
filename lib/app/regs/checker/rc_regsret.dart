/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfdopr.dart';
import 'package:flutter_pos/app/regs/checker/rcspeeza_com.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';

/// 関連tprxソース:rc_regsret.c
class RcRegsret {
  static bool regsret_flg = false;

  /// 関連tprxソース:rc_regsret.c - rc_regsret_flgSet
  static Future<void> rcRegsretFlgSet() async {
    if (await rcRegsretUseChk()) {
      regsret_flg = true;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "regs return flag set");
    }
    return;

  }

  /// 関連tprxソース:rc_regsret.c - rc_regsret_usechk
  static Future<bool> rcRegsretUseChk() async {
    if (RckyRfdopr.rcRfdOprCheckOperateRefundMode()) {
      return false; // 返品操作中は結果ダイアログを表示するため自動的に登録画面に戻らない
    }
    if (await RcSysChk.rcQRChkPrintSystem()
        && (RcSpeezaCom.rcChkQcTerminalReturnTime() == 0) ) {
      if (!await RcSysChk.rcChkFselfSystem()) {
        return false; // レシートＱＲ使用の場合は、SpeezaIni優先
      }
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    return ( cBuf.dbTrm.regsDispRetTime != 0
        ||  (await RcSysChk.rcQRChkPrintSystem() && RcSpeezaCom.rcChkQcTerminalReturnTime() != 0)
        ||  await RcFncChk.rcCheckHc1InOutMode() );
  }

  /// 関連tprxソース:rc_regsret.c - rc_regsret_TimerRemove
  static Future<int> rcRegsRetTimerRemove(int clrFlg) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "regs return timer Remove[${rcTimerListVal(RC_TIMER_LISTS.RC_GTK_REGSRET_TIMER)}]");
    rcTimerListRemove(RC_TIMER_LISTS.RC_GTK_REGSRET_TIMER);
    if (clrFlg != 0) {
      rcRegsRetFlgInit();
    }
    return Typ.OK;
  }

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース:rc_regsret.c - rc_regsret_flgInit
  static void rcRegsRetFlgInit() {
  }

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース:rc_regsret.c - rc_TimerList_Val
  static int	rcTimerListVal(RC_TIMER_LISTS num) {
    return 0;
  }

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース:rc_regsret.c - rc_TimerList_Remove
  static void	rcTimerListRemove(RC_TIMER_LISTS num) {
  }
}