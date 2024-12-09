/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/fnc_code.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_28dsp.dart';
import 'rc_tab.dart';
import 'rcfncchk.dart';
import 'regs.dart';

class RcKyTab {
  static TabInfo tabInfo = TabInfo();
  static TabSaveData tab1Data = TabSaveData();
  static TabSaveData tab2Data = TabSaveData();
  static TabSaveData tab3Data = TabSaveData();

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcky_tab.c - rcCounterData_Change
  static void rcCounterDataChange() {
    return ;
  }

  /// 取引開始状態にするものが商品無し状態で取り消された場合(会員->会員取消など)、
  /// その前にタブの移動を行うと情報が残るため、それら情報と表示をクリアする
  /// （例: 会員->タブ移動->会員取消 など）
  /// 関連tprxソース:rcky_tab.c - rcTab_ClearDisp
  static Future<void> rcTabClearDisp() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]) ) {
      rcCounterDataChange();
      if (await RcFncChk.rcCheckStlMode()) {
        Rc28dsp.rcTabCounterStlDataSet(tabInfo.dspTab, RegsDef.subttl);
        Rc28dsp.rcTabDataStlDisplay(tabInfo.dspTab, RegsDef.subttl, TabDef.DATA_DSP);
      } else {
        Rc28dsp.rcTabCounterDataSet(tabInfo.dspTab);
        Rc28dsp.rcTabDataDisplay(tabInfo.dspTab);
      }
      if (FbInit.subinitMainSingleSpecialChk()) {
        Rc28dsp.rcTabDataStlDisplay(tabInfo.dspTab, RegsDef.dualSubttl, TabDef.DATA_DSP);
      }
    }

  }
}