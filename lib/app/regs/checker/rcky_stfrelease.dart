/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';

class RckyStfRelease {
  /// 従業員入力待ちかどうかチェック
  /// 戻り値: true=入力待ち  false=入力待ちでない
  ///  関連tprxソース: rcky_stfrelease.c - rcChkStfReleasee
  static Future<bool> rcChkStfRelease() async {
    if (await CmCksys.cmStaffReleaseSystem() != 0) {
      RegsMem mem = SystemFunc.readRegsMem();
      if (mem.prnrBuf.stfRelease.fncCode == FuncKey.KY_STAFF_RELEASE.keyId) {
        return true;
      }
    }

    return false;
  }
}