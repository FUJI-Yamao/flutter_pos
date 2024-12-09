/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/rxregmem_define.dart';
import '/app/inc/sys/tpr_log.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';

/// 指定訂正ボタンの処理.
class KeyVoid {
  final int _seqNo;
  KeyVoid(this._seqNo);

  /// 指定訂正ボタンが押されたときの処理.
  void rcKyVoid() {
    // 画面訂正.
    rcKySrcVoid();
  }

  /// 関連tprxソース:rcKy_VoidScr
  void rcKySrcVoid() {
    var itemLog = RegsMem().tItemLog[_seqNo - 1];
    if (itemLog == null) {
      // MEMO:指定された番号のデータがない.
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "SCRVOID[$_seqNo] is null");
      return;
    }
    if (itemLog.t10000Sts.corrFlg) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "SCRVOID[$_seqNo] is already corr");
      return;
    }

    itemLog.t10002.scrvoidFlg = !itemLog.t10002.scrvoidFlg;
    if (itemLog.t10002.scrvoidFlg) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "SCRVOID[$_seqNo]${itemLog.t10000.pluCd1_1}");
    } else {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "NOT SCRVOID[$_seqNo]${itemLog.t10000.pluCd1_1}");
    }

    // 再計算.
    StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
  }
}
