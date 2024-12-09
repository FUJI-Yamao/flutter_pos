/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

///  関連tprxソース: rckytcoupon.c
class RcKyTcoupon {
  ///  関連tprxソース: rckytcoupon.c -rcCheck_TcouponMode
  ///  機能概要	: Tポイント仕様時、クーポン受付が可能な状態であるかどうか判定する関数
  ///  パラメータ	: なし
  ///  戻り値	: true: クーポン受付状態である
  ///  　　　　: false: クーポン受付状態でない
  static bool rcCheckTcouponMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TPOINT_CPN.keyId]);
  }
 }