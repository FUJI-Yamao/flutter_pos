/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../db_library/src/db_manipulation.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import 'rcmbr_fsp.dart';
import 'rcmbrfspcalc.dart';
import 'rcmbrfsplevel.dart';

///  関連tprxソース: tprx\src\regs\checker\rcmbrfsptotallog.c
class RcmbrFspTotalLog {
  static AcMem cMem = SystemFunc.readAcMem();

  /// 関連tprxソース: rcmbrfsptotallog.c - rcmbrFspCustDataSet
  static Future<void> rcmbrFspCustDataSet() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    int fspCd = 0;

    if (CmCksys.cmMmSystem() != 0) {
      mem.tTtllog.t100800.fspCd = cBuf.dbTrm.fspCd;
      fspCd = cBuf.regAddFspCd;
    } else {
      fspCd = 1;
    }

    if ((await CmCksys.cmDcmpointSystem() != 0) &&
        (mem.tTtllog.t100700.mbrInput != MbrInputType.mcp200Input.index)) {
      mem.tTtllog.t100700.fspLvl = 5;
    } else {
      mem.tTtllog.t100700.fspLvl =
          RcmbrFspLevel.rcmbrGetFspLevel(cMem.custData.enqParent as SCustTtlTbl, cBuf.dbTrm);
    }

    if (cBuf.dbTrm.memAnyprcStet == AnyprcStet.STAT_ADD.value ||
        cBuf.dbTrm.memAnyprcStet == AnyprcStet.STAT_ADD_SVC.value) {
      if (fspCd != 0) {
        mem.tTtllog.t100700Sts.fspAddPer = RcmbrFspCalc.rcmbrGetFspAddPer(
            cMem.custData.cust as CCustMstColumns, cMem.custData.svsCls as PPromschMst);
      }
    }

    rcmbrFspCustEnqDataSet();
  }

  /// 関連tprxソース: rcmbrfsptotallog.c - rcmbrFspCustEnqDataSet
  static Future<void> rcmbrFspCustEnqDataSet() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if ((await CmCksys.cmDcmpointSystem() != 0) &&
        (mem.tTtllog.t100700.mbrInput != MbrInputType.mcp200Input.index)) {
      mem.tTtllog.t100700.fspLvl = 5;
    } else {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return;
      }
      RxCommonBuf cBuf = xRet.object;
      AcMem cMem = SystemFunc.readAcMem();
      mem.tTtllog.t100700.fspLvl =
          RcmbrFspLevel.rcmbrGetFspLevel(cMem.custData.enqParent as SCustTtlTbl, cBuf.dbTrm);
    }

    /* 前回加算複数売価期間対象額 */
    mem.tTtllog.t100800.lcauFsppur = mem.custTtlTbl.n_data6;
  }
}