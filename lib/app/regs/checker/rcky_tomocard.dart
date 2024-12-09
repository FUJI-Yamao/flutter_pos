/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../common/rxkoptcmncom.dart';

class RckyTomoCard{
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcKy_tomocard.c - rcKy_TomoCard_Amt
  static void rcKyTomoCardAmt(){
    return;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcKy_tomocard.c - rcKy_TomoCard_Pay
  static int rcKyTomoCardPay(){
    return 0;
  }

  /// :スプリット[友の会]の金額を取得
  /// 戻り値: 金額
  /// 関連tprxソース:rcKy_tomocard.c - rcTomoCard_SpTend_amt
  static int rcTomoCardSpTendAmt() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    int amt = 0;

    // 掛売種別：友の会に設定されたコードを取得
    int fncCode = Rxkoptcmncom.rxChkCHACHKOnlyCrdtTyp(cBuf, SPTEND_STATUS_LISTS.SPTEND_STATUS_TOMOCARD.typeCd);

    if ((fncCode != -1) && (mem.tTtllog.t100001Sts.sptendCnt > 0)) {
      for (int num = 0; num < mem.tTtllog.t100001Sts.sptendCnt; num++) {
        //友の会スプリット利用中
        if (fncCode == mem.tTtllog.t100100[num].sptendCd) {
          amt += mem.tTtllog.t100100[num].sptendData;
        }
      }
    }

    return amt;
  }
}

