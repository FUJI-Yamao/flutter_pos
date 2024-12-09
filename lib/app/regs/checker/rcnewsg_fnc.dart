/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/typ.dart';
import 'rc_qc_dsp.dart';
import 'rc_sgdsp.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcnewsg_fnc.c
class RcNewSgFnc {
  // 関連tprxソース: tprx\src\regs\checker\rcnewsg_dsp.c - NewExpDsp
  static NewSGExpDsp newExpDsp = NewSGExpDsp();

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcnewsg_fnc.c - rcNewSG_ComTimer_GifDsp
  static void rcNewSGComTimerGifDsp() {
    return ;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcnewsg_fnc.c - rcNewSGDsp_GtkTimerRemove
  static int rcNewSGDspGtkTimerRemove() {
    return 0;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcnewsg_fnc.c - rcNewSG_ExplainTimer_Proc
  static void rcNewSGExplainTimerProc() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcnewsg_fnc.c - rcNewSG_StlDspTimer_Proc
  static void rcNewSGStlDspTimerProc() {}

  /// Happyフルセルフの商品登録画面か
  /// 引数: 0=Happyフルセルフの商品登録以外の画面  1=Happyフルセルフの商品登録画面
  /// 戻り値: OK=登録操作無時警告「する」かつパラメータ指定の画面  NG=登録操作無時警告「しない」または パラメータ指定の画面以外
  ///  関連tprxソース: rcnewsg_fnc.c - rcSG_HappyItemRegDspState
  static Future <int> rcSGHappyItemRegDspState(int checkdisp) async {
    if (QCashierIni().noOperationWarning == 0) {
      /* 登録画面での登録操作無時警告：しない */
      return Typ.NG;
    }

    switch (checkdisp) {
      case 1: /* Happyフルセルフの商品登録画面 */
        if (!(await RcSysChk.rcChkSmartSelfSystem() &&
            await RcSysChk.rcNewSGChkNewSelfGateSystem() &&
            !await RcSysChk.rcQCChkQcashierSystem() && /* Qcashier状態ではない? */
            !await RcSysChk.rcChkHappySelfQCashier())) /* QC切替ではない? */
        {
          /* Happyフルセルフ以外 */
          return Typ.NG;
        }
        if (newExpDsp.dspCnt != 6) {
          /* 商品登録画面以外 */
          return Typ.NG;
        }
        break;
      default:
        return Typ.NG;
    }

    return Typ.OK;
  }

  ///  関連tprxソース: rcnewsg_fnc.c - rcSG_Set_SelfCtrlFlag
  static Future<void> rcSGSetSelfCtrlFlag() async {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    if (await RcSysChk.rcChk2800System()) {
      tsBuf.chk.selfctrl_flg = 0;
    } else {
      tsBuf.chk.selfctrl_flg = 1;
    }
  }
}