/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../inc/rc_mem.dart';

class RckyClsCncl {
  ///  関連tprxソース: rckyclscncl.c - rcItmClsCncl_flgClr
  static void rcItmClsCnclFlgClr(int bksetFlg) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (cBuf.dbTrm.clscnclItemFlg != 0) {
      if (bksetFlg == 1) {
        cMem.stat.bkclsCnclMode = cMem.stat.clsCnclMode;
      }
      else if (bksetFlg == 0) {
        cMem.stat.bkclsCnclMode =0;
      }
      cMem.stat.clsCnclMode = 0;
      mem.tTtllog.t100002Sts.clsCnclFlg = 0;
    }
  }
}