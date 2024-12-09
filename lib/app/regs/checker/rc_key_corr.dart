/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/rxregmem_define.dart';
import '/app/inc/sys/tpr_log.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';

/// 直前訂正ボタンの処理.
class KeyCorr {
  KeyCorr();

  /// rcky_plu.c rcKyPlu
  void rcKyCorr() {
    rcPrgKyCorr();
  }

  /// 直前に登録した商品の訂正を行う.
  /// 関連tprxソース:rcPrg_Ky_Corr
  void rcPrgKyCorr() {
    int itemCount = RegsMem().tTtllog.t100001Sts.itemlogCnt;
    if (itemCount <= 0) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "CORR[$itemCount] no item list");
      return;
    }
    var itemLog = RegsMem().tItemLog[itemCount - 1];
    if (itemLog == null) {
      // 最後のデータがない.
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "CORR[${itemCount - 1}] is null");
      return;
    }
    if (itemLog.isDeletedItem()) {
      // 既に画面訂正済み.
      return;
    }
    // rcChg_Item_Flag
    // true->falseはナシ.
    itemLog.t10000Sts.corrFlg = true;
    TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
        "CORR[$itemCount]${itemLog.t10000.pluCd1_1}");

    // 再計算.
    StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
  }
}
