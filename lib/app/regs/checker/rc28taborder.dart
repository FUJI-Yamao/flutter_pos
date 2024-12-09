/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_log.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_key_tab.dart';
import 'rc_set.dart';
import 'rc_tab.dart';
import 'rcfncchk.dart';
import 'rcsyschk.dart';
import 'rxregstr.dart';

class Rc28TabOrder {
  /// TODO:00010 長田 定義のみ追加
  /// 商品登録時や仮締、会員呼出前にタブを移動するための関数
  /// 引数: 0=通常  0以外=タブキーを使ったときにセット
  /// 戻値: エラーコード（0=OK(タブを移動しない)）
  ///  関連tprxソース: rc28taborder.c - rcTabMoveRegStart
  static int rcTabMoveRegStart(int type) {
    return 0;
  }

  /// 商品登録後、タブ移動できるかチェックする
  /// （金額チェック、分類登録前、売価変更キーで未決定時、タブ移動は行わない）
  /// 戻値: true=移動できる  false=移動できない
  ///  関連tprxソース: rc28taborder.c - rcChkPluTabPlus
  static bool rcChkPluTabPlus() {
    AcMem cMem = SystemFunc.readAcMem();
    return (RcFncChk.rcCheckScanCheck()
        || RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PRC.keyId])
        || RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId])
    );
  }

  /// タブの並びに異常がないかチェック (TRUEで異常な並び)
  /// 戻値: true=異常  false=異常でない
  ///  関連tprxソース: rc28taborder.c - rcChkAbnormalTabOrder
  static Future<bool> rcChkAbnormalTabOrder() async {
    if (!(await RcSysChk.rcChk2800TabOrder())) {
      return false;
    }
    if (await RcSysChk.rcChk2800RegCruising() == CmSys.LEFT_FLOW) {
      if (((RcKyTab.tabInfo.dspTab == TabNum.ThirdTab.num) &&
          (RcKyTab.tab2Data.counter == 0) && (RcKyTab.tab1Data.counter == 0))
          || ((RcKyTab.tabInfo.dspTab != TabNum.firstTab.num) &&
              (RcKyTab.tab3Data.counter == 1) &&
              (RcKyTab.tab1Data.counter == 0))
          || ((RcKyTab.tab3Data.counter == 1) &&
              (RcKyTab.tab2Data.counter == 2))) {
        return false;
      }
    } else {
      if (((RcKyTab.tabInfo.dspTab == TabNum.firstTab.num) &&
          (RcKyTab.tab2Data.counter == 0) && (RcKyTab.tab3Data.counter == 0))
          || ((RcKyTab.tabInfo.dspTab != TabNum.ThirdTab.num) &&
              (RcKyTab.tab1Data.counter == 1) &&
              (RcKyTab.tab3Data.counter == 0))
          || ((RcKyTab.tab1Data.counter == 1) &&
              (RcKyTab.tab2Data.counter == 2))) {
        return false;
      }
    }

    return true;
  }


  /// 手動でのタブ移動時、タブの並びが正常ではない場合の移動先を返す
  /// 戻値: 移動先タブNo
  ///  関連tprxソース: rc28taborder.c - rcTabOrderGet_MoveTab
  static Future<int> rcTabOrderGetMoveTab() async {
    int	nextTab = 0;
    int	dispTabCount = 0;  //dispTabCount=0は、新規に商品登録した時

    // 現在のタブの位置のカウンターを保存する
    if (RcKyTab.tabInfo.dspTab == TabNum.firstTab.num) {
      dispTabCount = RcKyTab.tab1Data.counter;
    } else if (RcKyTab.tabInfo.dspTab == TabNum.SecondTab.num) {
      dispTabCount = RcKyTab.tab2Data.counter;
    } else if (RcKyTab.tabInfo.dspTab == TabNum.ThirdTab.num) {
      dispTabCount = RcKyTab.tab3Data.counter;
    } else {
      dispTabCount = 0;
    }

    switch (RcKyTab.tabInfo.tabCounter) {
      case 0:
      case 1:
        if (await RcSysChk.rcChk2800RegCruising() == CmSys.LEFT_FLOW) {
          nextTab = TabNum.ThirdTab.num;
        } else {
          nextTab = TabNum.firstTab.num;
        }
        break;
      case 2:
        if (dispTabCount == 1) {
          if (await RcSysChk.rcChk2800RegCruising() == CmSys.LEFT_FLOW) {
            nextTab = TabNum.ThirdTab.num;
          } else {
            nextTab = TabNum.firstTab.num;
          }
        } else {
          nextTab = TabNum.SecondTab.num;
        }
        break;
      case 3:
        if (await RcSysChk.rcChk2800RegCruising() == CmSys.LEFT_FLOW) {
          nextTab = TabNum.firstTab.num;
        } else {
          nextTab = TabNum.ThirdTab.num;
        }
        break;
      default:
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "Rc28TabOrder.rcTabMoveRegStart(): Not tab_counter");
        return -1;
    }

    return nextTab;
  }

  /// タブ移動時に要らないキーステータスをリセット
  ///  関連tprxソース: rc28taborder.c - rcReSetKeyStatus
  static void rcResetKeyStatus() {
    AcMem cMem = SystemFunc.readAcMem();
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_MBR.keyId);
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_TEL.keyId);
    RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
  }

  // 現在のデータが取引中の場合にそのデータを保存
  // また、タブデータが異常になる場合に備え、セーフティネットとして使用 (プログラムのメンテナンスが正常なら使われない)
  ///  関連tprxソース: rc28taborder.c - rcTabOrderNowDataSuspend
  Future<int> rcTabOrderNowDataSuspend() async {
    int errNo;
    RegsMem mem = RegsMem();

    if ((mem.tmpbuf.manualMixcd != 0) && (!RcFncChk.rcCheckRegistration())) {
      mem.tmpbuf.manualMixcd = 0;
      Dummy.rcDspManualMMCntLCD(0);
    }
    if (RcFncChk.rcCheckRegistration()) {
      RcSet.rcClearRepeatBuf();
      Rxregstr.rxSetClerkNoName();
      errNo = Dummy.rcPrgKyTabSuspend();
      if (errNo != 0) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcTabOrderNowDataSuspend: Tab Suspend Error!!!!!\n");
        return errNo;
      } else {
        RcSet.rcClearWizStaffNo();
      }
    }

    return Typ.OK;
  }
}
