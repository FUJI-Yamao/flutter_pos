/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/lib/cm_chg/bcdtol.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc_reserv.dart';
import 'package:flutter_pos/app/regs/checker/rccatalina.dart';
import 'package:flutter_pos/app/regs/checker/rcqr_com.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/common/rx_log_calc.dart';
import 'package:flutter_pos/app/regs/inc/rc_mem.dart';

import '../../common/cmn_sysfunc.dart';

class RckyBc {

  ///  関連tprxソース: rcky_bc.c - rc_Split_Chk_ATCT_Before
  static Future<int> rcSplitChkATCTBefore() async {
    int ldata = 0;
    int inpamt = 0;
    int ret = 0;
    RegsMem regsMem = RegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ret;
    }
    RxCommonBuf pCom = xRet.object;

    int sptendNum = regsMem.tTtllog.t100001Sts.sptendCnt - 1;
    if (sptendNum >= 0) {
      ldata = regsMem.tTtllog.t100100[sptendNum].sptendInAmt;
      inpamt = regsMem.tTtllog.t100100[sptendNum].sptendData;
    }
    else {
      ldata = RxLogCalc.rxCalcStlTaxInAmt(regsMem);
      /// CATALINA_SYSTEM
      if (RcCatalina.cmCatalinaSystem(0)) {
        ldata -= regsMem.tmpbuf.catalinaTtlamt!;
      }
      //
      if (pCom.dbTrm.discBarcode28d != 0) {
        ldata -= regsMem.tmpbuf.beniyaTtlamt!;
      }
      /// RESERV_SYSTEM
      if ( (await CmCksys.cmReservSystem() != 0 || await CmCksys.cmNetDoAreservSystem() != 0)
          && RcReserv.rcReservReceiptCall() ) {
        ldata -= await RcReserv.rcreservReceiptAdvance();
      }
      inpamt = Bcdtol.cmBcdToL(cMem.ent.entry);
    }

    if (inpamt < ldata /* || (ldata <= 0 ) */) {
      ret = 1;
    }
    if (!(await RcSysChk.rcQCChkQcashierSystem())
        && !(await RcSysChk.rcQRChkPrintSystem())
        &&  (regsMem.tTtllog.t100001Sts.qcReadQrReceiptNo != 0)
        &&  (regsMem.tTtllog.t100001Sts.qcReadQrReceiptNo == RcqrCom.qrReadReptNo) ) {
      /* お会計券を通常レジで読み込んだ場合 */
      ret = 2;
    }
    return ret;
  }
}