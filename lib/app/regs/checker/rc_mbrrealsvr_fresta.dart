/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/rxregmem_define.dart';
import 'rcsyschk.dart';

class RcMbrrealsvrFresta {
  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_mbrrealsvr_fresta.c - rcrealsvr_Fresta_FlWt()
  static int rcrealsvrFrestaFlWt(int tranTyp) {
    return 0;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_mbrrealsvr_fresta.c - rcrealsvr_FrestaFGTckt_UseFlRd()
  static int rcrealsvrFrestaFGTcktUseFlRd() {
    return 0;
  }

  /// [フレスタ様仕様] 精算機で会員カード読取が可能かチェックする
  /// 戻り値: true=読取可能  false=読取不可能
  /// 関連tprxソース: rc_mbrrealsvr_fresta.c - rc_mbrrealsvr_fresta_QCashier_RPointMbr_Read_Check
  static Future<bool> rcChkQCashierRPointMbrRead() async {
    if ((RcSysChk.rcsyschkRpointSystem() != 0) &&
        RcSysChk.rcChkCustrealFrestaSystem()) {
      if ((await RcSysChk.rcChkHappySelfQCashier()) ||
          (await RcSysChk.rcQCChkQcashierSystem())) {
        return true;
      }
    }
    return false;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// フレスタ顧客情報が出来なかった場合のオフラインメッセージ表示
  /// 関連tprxソース: rc_mbrrealsvr_fresta.c - rcrealsvr_Fresta_OfflineMessage
  static void offlineMessage() {}
}