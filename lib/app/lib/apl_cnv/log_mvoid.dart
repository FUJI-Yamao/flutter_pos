/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/rxregmem_define.dart';

///  関連tprxソース:log_mvoid.c
class LogMVoid {

  /// ログ定義データ（tTtllog.calcData, tItemLog.calcData）の符号を正負変換する
  /// 引数:[mem] 共有メモリクラス"RegsMem"
  /// 関連tprxソース: log_mvoid.c - calcData_logmvoid
  static void calcDataLogMVoid(RegsMem mem) {
    for (int i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      mem.tItemLog[i].calcData.nomiPrc *=
      -1; // 利用乗算売値  uuse_prc * item_ttl_qty
      mem.tItemLog[i].calcData.uuseMulPrc *=
      -1; // 通常乗算売値  u_prc * item_ttl_qty
      mem.tItemLog[i].calcData.exInTaxAmt *= -1; // 単品理論税 (単品理論外税 + 内税)
      mem.tItemLog[i].calcData.clsMultdscAmt *= -1; // 複数売価一括値下額
    }
    mem.tTtllog.calcData.stlTaxOutAmt *= -1;
    mem.tTtllog.calcData.stlTaxAmt *= -1;
    mem.tTtllog.calcData.simpleTtlAmt *= -1;
    mem.tTtllog.calcData.btlSaleAmt *= -1;
    mem.tTtllog.calcData.stldscBaseAmt *= -1;
    mem.tTtllog.calcData.stldscRestAmt *= -1;
    mem.tTtllog.calcData.stlIntaxInAmt *= -1;
    mem.tTtllog.calcData.crdtCnt1 *= -1;
    mem.tTtllog.calcData.crdtAmt1 *= -1;
    mem.tTtllog.calcData.crdtCnt2 *= -1;
    mem.tTtllog.calcData.crdtAmt2 *= -1;
    mem.tTtllog.calcData.noTaxQty *= -1;
    mem.tTtllog.calcData.noTaxAmt *= -1;
    mem.tTtllog.calcData.exTaxblQty *= -1;
    mem.tTtllog.calcData.exTaxbl *= -1;
    mem.tTtllog.calcData.exTaxItemAmt *= -1;
    mem.tTtllog.calcData.inTaxblQty *= -1;
    mem.tTtllog.calcData.inTaxbl *= -1;
    mem.tTtllog.calcData.inTaxItemAmt *= -1;
    mem.tTtllog.calcData.dscpdscQty *= -1;
    mem.tTtllog.calcData.dscpdscAmt *= -1;
    mem.tTtllog.calcData.stldscpdscCnt *= -1;
    mem.tTtllog.calcData.stldscpdscAmt *= -1;
    mem.tTtllog.calcData.stldscAmt *= -1;
    mem.tTtllog.calcData.stldscAmt1 *= -1;
    mem.tTtllog.calcData.stldscAmt2 *= -1;
    mem.tTtllog.calcData.stldscAmt3 *= -1;
    mem.tTtllog.calcData.stldscAmt4 *= -1;
    mem.tTtllog.calcData.stldscAmt5 *= -1;
    mem.tTtllog.calcData.stlpdscCnt *= -1;
    mem.tTtllog.calcData.stlpdscAmt *= -1;
    mem.tTtllog.calcData.stlpdscCnt1 *= -1;
    mem.tTtllog.calcData.stlpdscAmt1 *= -1;
    mem.tTtllog.calcData.stlpdscCnt2 *= -1;
    mem.tTtllog.calcData.stlpdscAmt2 *= -1;
    mem.tTtllog.calcData.stlpdscCnt3 *= -1;
    mem.tTtllog.calcData.stlpdscAmt3 *= -1;
    mem.tTtllog.calcData.stlpdscCnt4 *= -1;
    mem.tTtllog.calcData.stlpdscAmt4 *= -1;
    mem.tTtllog.calcData.stlpdscCnt5 *= -1;
    mem.tTtllog.calcData.stlpdscAmt5 *= -1;
    mem.tTtllog.calcData.bdlDscAmt *= -1;
    mem.tTtllog.calcData.stmDscAmt *= -1;
    mem.tTtllog.calcData.dsalTtlpur *= -1;
    mem.tTtllog.calcData.dwotTtlpur *= -1;
    mem.tTtllog.calcData.nsalTtlpur *= -1;
    mem.tTtllog.calcData.nsaqTtlpur *= -1;
    mem.tTtllog.calcData.tpptTtlsrv *= -1;
    mem.tTtllog.calcData.lpptTtlsrv *= -1;
    mem.tTtllog.calcData.duppTtlrv *= -1;
    mem.tTtllog.calcData.nextTtlsrv *= -1;
    mem.tTtllog.calcData.dqtyFsppur *= -1;
    mem.tTtllog.calcData.damtFsppur *= -1;
    mem.tTtllog.calcData.dperFsppdsc *= -1;
    mem.tTtllog.calcData.dqtyFsppdsc *= -1;
    mem.tTtllog.calcData.dpurFsppdsc *= -1;
    mem.tTtllog.calcData.daddFsppnt *= -1;
    mem.tTtllog.calcData.dtdqMulcls *= -1;
    mem.tTtllog.calcData.dtdqMulcls *= -1;
    mem.tTtllog.calcData.ddsqMulcls *= -1;
    mem.tTtllog.calcData.ddsaMulcls *= -1;
    mem.tTtllog.calcData.dpdqMulcls *= -1;
    mem.tTtllog.calcData.dpdaMulcls *= -1;
    mem.tTtllog.calcData.dsdqMulcls *= -1;
    mem.tTtllog.calcData.dsdaMulcls *= -1;
    mem.tTtllog.calcData.dspqMulcls *= -1;
  }
}
