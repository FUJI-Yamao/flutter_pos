/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/inc/apl/rxtbl_buff.dart';
import 'package:flutter_pos/app/regs/checker/rc_lastcomm.dart';
import 'package:flutter_pos/app/regs/common/rxkoptcmncom.dart';

///  関連tprxソース: rxcalccom.c
class Rxcalccom{
  /// 機能概要     : プリペイドのスプリットがあるか
  /// パラメータ   : REGSMEM *pRct = 実績メモリポインタ
  /// 	         : RX_COMMON_BUF *pCom = 設定メモリポインタ
  /// 戻り値      : プリペイドキーあればキーコードを返す
  /// 関連tprxソース: rxcalccom.c - rxCheckPrepaidSptend()
  static int rxCheckPrepaidSptend(RegsMem pRct, RxCommonBuf pCom){
    if(pRct.tTtllog.t100001Sts.sptendCnt == 0){
      return 0;
    }

    for(int num = 0; num < pRct.tTtllog.t100001Sts.sptendCnt; num++ ){

      if(pRct.tTtllog.t100100[num] == null) {
        break;
      }

      if((Rxkoptcmncom.rxChkKeyKindCHA(pCom, pRct.tTtllog.t100100[num]!.sptendCd) == true)		// 会計キーか
      && (Rxkoptcmncom.rxChkKoptChaCrdtEnble(pCom, pRct.tTtllog.t100100[num]!.sptendCd) == 1)	// crdt_enble_flgのチェック
      && ((Rxkoptcmncom.rxChkKoptChaCrdtTyp(pCom, pRct.tTtllog.t100100[num]!.sptendCd) == 6)  // crdt_typのチェック
      || (Rxkoptcmncom.rxChkKoptChaCrdtTyp(pCom, pRct.tTtllog.t100100[num]!.sptendCd) == 37)
      || (Rxkoptcmncom.rxChkKoptChaCrdtTyp(pCom, pRct.tTtllog.t100100[num]!.sptendCd) == SPTEND_STATUS_LISTS.SPTEND_STATUS_COCONA.typeCd)
      || (Rxkoptcmncom.rxChkKoptChaCrdtTyp(pCom, pRct.tTtllog.t100100[num]!.sptendCd) == 41))	/* 掛売の種類がﾌﾟﾘﾍﾟｰﾄﾞ2かチェック */
      ){
        return pRct.tTtllog.t100100[num]!.sptendCd;
      }
    }
    return 0;
  }
}
