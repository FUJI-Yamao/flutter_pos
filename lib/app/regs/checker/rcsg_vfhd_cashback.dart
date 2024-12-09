/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */



import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../lib/cm_sys/cm_cksys.dart';

///  関連tprxソース: rcsg_vfhd_cashback.c
class RcgVfhdCashBack {

  static int cashBackFlg = 0;

  /// 処理概要：オオゼキ様向け、キャッシュバックモードチェック
  /// パラメータ：なし
  /// 戻り値：false キャッシュバックモードではない
  ///        true キャッシュバックモード
  ///  関連tprxソース: rcsg_vfhd_cashback.c - rcSG_VFHD_Check_CashBack_Mode
  static Future<bool> rcSgVFHDCheckCashBackMode() async {
    if ((await CmCksys.cmSm74OzekiSystem() != 0) &&
        (await RcSysChk.rcChkVFHDSelfSystem()) &&
        (rcSGVFHDCashBackGetFlg() == 1) ) {
      return true;
    }
    return false;
  }

  /// 処理概要：ｷｬｯｼｭﾊﾞｯｸ状態ﾌﾗｸﾞ値を返す
  /// パラメータ：なし
  /// 戻り値： 0:ｷｬｯｼｭﾊﾞｯｸ状態ではない
  ///        1:ｷｬｯｼｭﾊﾞｯｸ状態
  ///  関連tprxソース: rcsg_vfhd_cashback.c - rcSG_VFHD_CashBack_GetFlg
  static int rcSGVFHDCashBackGetFlg() {
    int flgResult = 0;
    switch (cashBackFlg) {
      case 0:
        break;
      case 1:
        flgResult = cashBackFlg;
        break;
      default:
        break;
    }
    return flgResult;
  }

}