/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 * ファイル名 : rcky_hitouch.dart
 * 機能概要   : ハイタッチ(RM-3800用)
 * 関連tprxソース: rcky_hitouch.c
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc_59hitouch.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/inc/rc_mem.dart';

import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';

class RckyHitouch {

  /// 関数：rcKy_WtClr(void)
  /// 機能：「ハイタッチ」キー処理
  /// 引数：なし
  /// 戻値：OK/NG
  ///  関連tprxソース: rcky_hitouch.c - rcKy_HiTouch()
  static Future<int> rcKyHiTouch() async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.errNo = await rcChkKyHiTouch();
    if (cMem.ent.errNo != 0)
    {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcKyHiTouch : err_no[${cMem.ent.errNo}]\n");
      await RcExt.rcErr("rcKyHiTouch()", cMem.ent.errNo);
      return (Typ.NG);
    }
    await rcPrgKyHiTouch();	// ハイタッチ画面
    return (Typ.OK);
  }

  /// 関数：rcChk_Ky_HiTouch(void)
  /// 機能：「ハイタッチ」キーのチェック
  /// 引数：なし
  /// 戻値：
  ///  関連tprxソース: rcky_hitouch.c - rcChk_Ky_HiTouch()
  static Future<int> rcChkKyHiTouch() async {
    // ハイタッチ接続
    if (await CmCksys.cmChkRm5900HiTouchMacNo() == 0)	// RM-3800 ハイタッチ接続仕様が「無効」の場合
    {
      return (DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId);		// このキーは無効です
    }
    return (Typ.OK);
  }

  /// 関数：rcPrg_Ky_HiTouch(void)
  /// 機能：RM-3800の「ハイタッチ」画面
  /// 引数：なし
  /// 戻値：なし
  ///  関連tprxソース: rcky_hitouch.c - rcPrg_Ky_HiTouch()
  static Future<void> rcPrgKyHiTouch() async {
    await Rc59Hitouch.rc59ScaleHitouchChgDisp();
  }
}