/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import 'rc_atct.dart';
import 'rc_gtktimer.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcky_qctckt.c
class RckyQctckt {
  /// 関連tprxソース: rcky_qctckt.c - err_no_bkup
  static int errNoBkup = 0;
  //実装は必要だがARKS対応では除外
  ///  関連tprxソース:rcky_qctckt.c - rcQC_Data_Update()
  static int rcQCDataUpdate(TendType eTendType) {
    return 0;
  }

  ///  関連tprxソース: rcky_qctckt.c - rcDivAdj_NumReset()
  static void rcDivAdjNumReset() {
    for (int i = 0; i < RegsMem().tTtllog.getItemLogCount(); i++) {
      RegsMem().tItemLog[i].t10000Sts.sepaFlg = 0;
    }
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:rcky_qctckt.c - rcDivAdj_ForceNumSet()
  static void rcDivAdjForceNumSet() {}

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rcky_qctckt.c - rcKy_QCTckt()
  static void rcKyQCTckt() {
    return;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース:rcky_qctckt.c - rcDispDivAdjEntry
  static void rcDispDivAdjEntry(int dispType) {}

  /// お会計券と同じような内部動作をするキーかどうかチェック
  /// 戻り値: true=同じ動作  false=違う動作
  ///  関連tprxソース: rcky_qctckt.c - rcCheckQcTcktLikeKey
  static bool rcCheckQcTcktLikeKey() {
    AcMem cMem = SystemFunc.readAcMem();
    if ((cMem.stat.fncCode == FuncKey.KY_QC_TCKT.keyId) ||
        (rcCheckQcSelectGrpKey(cMem.stat.fncCode))) {
      return true;
    }
    return false;
  }

  /// QC指定キー(1-3)かチェック
  /// 戻り値: true=指定キー  false=指定キーでない
  ///  関連tprxソース: rcky_qctckt.c - rcCheck_QcSelectGrpKey
  static bool rcCheckQcSelectGrpKey(int fncCd) {
    if ((fncCd == FuncKey.KY_QCSELECT.keyId) ||
        (fncCd == FuncKey.KY_QCSELECT2.keyId) ||
        (fncCd == FuncKey.KY_QCSELECT3.keyId)) {
      return true;
    }
    return false;
  }

  // TODO: 定義のみ作成
  /// 関連tprxソース: rcky_qctckt.c - rc_NoCrdtDsc_Err
  static void rcNoCrdtDscErr(){
    return;
  }

  // TODO: 松岡 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcky_qctckt.c - rcPrg_Ky_QCTckt
  static Future<int> rcPrgKyQCTckt() async {
    return 0;
  }
}
