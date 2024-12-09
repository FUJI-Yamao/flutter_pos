/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/sys/tpr_dlg.dart';
import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/regs/checker/rc28stlinfo.dart';
import 'package:flutter_pos/app/regs/checker/rc_28dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_crdt_fnc.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rckycrdtvoid.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/inc/rc_mem.dart';

import '../../inc/apl/compflag.dart';
import 'rc_set.dart';
import 'rcky_clr.dart';

/// 関連tprxソース: rc_mcd.c
class RcMcd {
  /// 関連tprxソース: rc_mcd.c - rcRalseMcd_crdt_reg_Clr()
  static Future<void> rcRalseMcdCrdtRegClr() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "ARCS Member System crdt_reg Buffer Clear");
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.crdtReg = CrdtReg();
    AtSingl atSingl = SystemFunc.readAtSingl();
    atSingl.mbrTyp = 0;
    return ;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_mcd.c - rcMcd_MbrWaitChk()
  static int rcMcdMbrWaitChk () {
    return 0;
  }

  /// VEGA接続のクレジット通信時のエラー処理後に、クレジット宣言状態をクリアする
  /// 関連tprxソース: rc_mcd.c - rcCardCrew_Vega_Error
  /// 引数: int errNo エラーコード
  /// 戻値: なし
  static Future<void> rcCardCrewVegaError(int errNo) async {
    if (!await RcSysChk.rcQCChkQcashierSystem()) {
      await RcCrdtFnc.rcCrdtCancel();
    }
    if (CompileFlag.COLORFIP) {
      if (await RcSysChk.rcChkFselfSystem()) {
        await Rc28StlInfo.rcFselfSubttlRedisp();
      }
    }
    if (errNo != 0) {
      await rcCardCrewError(errNo);
    }
  }

  /// 関連tprxソース: rc_mcd.c - rcCardCrew_Error
  static Future<void> rcCardCrewError(int errNo) async {
    if (await RcCrdtFnc.rcCheckCrdtVoidMcdProc()) {
      // TODO:00012 平野 クレジット宣言：UI
      RckyClr.rcClearPopDisplay();
      if (errNo == DlgConfirmMsgKind.MSG_SYSERR.dlgId) {
        await RcKyCrdtVoid.rcCrdtVoidDialogErr(errNo, 1, '');
      } else {
        await RcKyCrdtVoid.rcCrdtVoidDialogErr(
            DlgConfirmMsgKind.MSG_NOTACTION.dlgId, 1, '');
      }
      await RcIfEvent.rxChkTimerAdd();
    } else {
      AcMem cMem = SystemFunc.readAcMem();
      cMem.working.crdtReg.companyCd = 0;
      // TODO:00012 平野 クレジット宣言：UI
      RckyClr.rcClearPopDisplay();
      RcSet.rcClearErrStat2('rcCardCrewError');
      cMem.ent.errNo = errNo;
      RcExt.rcErr('rcCardCrewError', cMem.ent.errNo);
      await RcIfEvent.rxChkTimerAdd();
    }
  }
}