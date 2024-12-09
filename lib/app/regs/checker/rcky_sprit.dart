/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/compflag.dart';
import 'rc_sgdsp.dart';
import 'rcsyschk.dart';

class RckySprit {
  ///  関連tprxソース: rcky_sprit.c - rcChk_SpritTranEnd
  static Future<bool> rcChkSpritTranEnd() async {
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        if (RcSgDsp.dualDsp.subttl_dsp_flg == 5) {
          return true;
        }
      }
    }
    return false;
  }
}