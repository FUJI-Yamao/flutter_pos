/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';

class RcTpoint {
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rc_tpoint.c - rc_Tpoint_Use()
  static int rcTpointUse(){
    int ret = 0;
    return ret;
  }

  /// オフラインフラグなどを参照し、特定処理を行ってよいかチェックする
  /// 引数: 処理種別
  /// 戻り値: true=実行可  false実行不可
  ///  関連tprxソース: rc_tpoint.c - rc_Tpoint_Check_Proc
  static bool rcTpointCheckProc(int type) {
    RegsMem mem = SystemFunc.readRegsMem();

    switch (type) {
      case 1:  // スプリット取消禁止
        if ((mem.tTtllog.t100715.offlineFlg == TpointOfflineFlg.TPOINT_OFFL_CNCL_NG.index)
            && (mem.tTtllog.t100715.usePts > 0)) {
          return true;
        }
        break;
      case 2:  // 還元キャンセル通信を実行するか
        if ((mem.tTtllog.t100715.offlineFlg == TpointOfflineFlg.TPOINT_OFFL_USE_OK.index)
            && (mem.tTtllog.t100715.usePts > 0)) {
          return true;
        }
        break;
      case 3:  // 還元キャンセル通信後、取消が成立したとみなすか
        if (mem.tTtllog.t100715.offlineFlg == TpointOfflineFlg.TPOINT_OFFL_CNCL_RECOV.index) {
          return true;
        }
        break;
      case 4: // 会員取消または会員上書きを行ってよいか
        if (mem.tTtllog.t100715.offlineFlg == TpointOfflineFlg.TPOINT_OFFL_NA.index) {
          return true;
        }
        break;
      default:
        break;
    }
    return false;
  }
}

/// オフラインフラグ
/// 関連tprxソース:C:rc_tpoint.h - TPOINT_OFFLINE_FLG
enum TpointOfflineFlg {
  TPOINT_OFFL_NA,
  TPOINT_OFFL_USE_OK,
  TPOINT_OFFL_USE_RECOV,
  TPOINT_OFFL_USE_NG,
  TPOINT_OFFL_CNCL_OK,
  TPOINT_OFFL_CNCL_RECOV,
  TPOINT_OFFL_CNCL_NG,
}