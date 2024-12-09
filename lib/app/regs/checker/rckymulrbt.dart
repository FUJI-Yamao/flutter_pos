/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';

import '../../inc/apl/rxregmem_define.dart';

/// 関連tprxソース: rckymulrbt.c
class RckyMulRbt{
  /// 関連tprxソース: rckymulrbt.c - rcChk_MulRbtInput
  static bool rcChkMulRbtInput(int chk) {
    return (RcFncChk.rcCheckRegistration() | (chk != 0)) &&
        RegsMem().tTtllog.t100001Sts.itemlogCnt == 0 &&
        RegsMem().tTtllog.t100700Sts.mulrbtPrnAmt != 0 &&
        RegsMem().tTtllog.t100700Sts.mulrbtPnt != 0;
  }
}
