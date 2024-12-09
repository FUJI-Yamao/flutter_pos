/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl.dart';

import '../../common/cmn_sysfunc.dart';

///  関連tprxソース: rctbafc1.c
class RcTbafc1 {
  ///  関連tprxソース: rctbafc1.c - rcCustLayAdd
  ///  custh_cdの値から客層客数と客層売上金額をセット
  static void rcCustLayAdd() {
    int amt;
    RegsMem regsMem = RegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.dscShareFlg == 0) {
      /* Discount Share ? */
      amt = regsMem.tTtllog.t100001.netslAmt;
    } else {
      amt = regsMem.tTtllog.t100001.grsslAmt;
    }

    if (regsMem.tTtllog.t100500.custhCd != 0) {
      regsMem.tTtllog.t100500.lyCust = 1;
      regsMem.tTtllog.t100500.lySaleAmt = amt;
    }
  }

  ///  関連tprxソース: rctbafc1.c - rcInvSumTaxCal_Main
  static void rcInvSumTaxCalMain(String callFunc) {}

  ///  関連tprxソース: rctbafc1.c - rcNoteDeptTax
  static int rcNoteDeptTax(int taxcd, TTtlLog ttl) {
    int tax = 0;

    if (RcStl.rcNotDeptTaxCalCheck()) {
      switch (taxcd) {
        case 1:
          tax = ttl.t100300[0].taxAmt;
          break;
        case 2:
          tax = ttl.t100300[1].taxAmt;
          break;
        case 3:
          tax = ttl.t100300[2].taxAmt;
          break;
        case 4:
          tax = ttl.t100300[3].taxAmt;
          break;
        case 5:
          tax = ttl.t100300[4].taxAmt;
          break;
        case 6:
          tax = ttl.t100300[5].taxAmt;
          break;
        case 7:
          tax = ttl.t100300[6].taxAmt;
          break;
        case 8:
          tax = ttl.t100300[7].taxAmt;
          break;
        default:
          break;
      }
    }

    return (tax);
  }
}
