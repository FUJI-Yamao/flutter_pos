/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_bdl.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/db/p_promsch_mst.dart';
import '../../inc/sys/tpr_log.dart';

/// 関連tprxソース:rconemmlm.c
class Rconemmlm {

  /// 関連tprxソース:rconemmlm.c - rc_OneMixLimitConfSystem
  static Future<bool> rcOneMixLimitConfSystem(int typChk, int itm, int bdl) async {
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem() &&
          (await RcSysChk.rcCheckOneMixLimitSelf() == 0)) {
        return (false);
      }
    }
    if (typChk < 0) {
      return (pCom.dbTrm.dispBdlQtyLimit1 != 0 ? true:false);
    } else {
      if (itm < 0) {
        return ((pCom.dbTrm.dispBdlQtyLimit1 != 0) &&
            (mem.tBdlLog[bdl].t200000Sts.bdlTyp == 2));
      }
    }
    return ((pCom.dbTrm.dispBdlQtyLimit1 != 0) &&
        (mem.tItemLog[itm].t10000Sts.corrFlg) &&
        (mem.tItemLog[itm].t10000Sts.voidFlg == 0) &&
        (mem.tItemLog[itm].t10002.scrvoidFlg) &&
        (mem.tItemLog[itm].t10800Sts.bdlTyp == 2));
  }

  /// 関連tprxソース:rconemmlm.c - rc_OneMixLimit_bdllogtobdlLimit
  static Future<void> rcOneMixLimitBdlLogToBdlLimit(TbdlLog bdlLog) async {
    String erlog = "";
    int i;
    PpromschMst sch = PpromschMst();
    int saleQty = 0;
    RxMemBdlTaxFreeOrg bdlOrgPrc = RxMemBdlTaxFreeOrg();
    RegsMem mem = SystemFunc.readRegsMem();

    erlog = "rcOneMixLimitBdlLogToBdlLimit set BdlCode ${bdlLog.t200000.bdlCd}";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);

    // rcRead_bdlsch_FL(sch, mem.tHeader.stre_cd, bdlLog.t200000.bdlCd, bdlLog.t200000.bdlPlanCd, -1, bdlOrgPrc);

    for (i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if ((bdlLog.t200000.bdlCd == mem.tItemLog[i].t10800.bdlCd) &&
          (!mem.tItemLog[i].t10002.scrvoidFlg)) {
        saleQty += mem.tItemLog[i].t10000.realQty;
      }
    }

    for (i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if (bdlLog.t200000.bdlCd == mem.tItemLog[i].t10800.bdlCd) {
        mem.tmpbuf.bdlLimit[i].limit = sch.recLimit;
        mem.tmpbuf.bdlLimit[i].bdlPrc = sch.formPrc1;
        mem.tmpbuf.bdlLimit[i].mbdlPrc = sch.custFormPrc1;
        mem.tmpbuf.bdlLimit[i].limitPrc = sch.lowLimit;
        mem.tmpbuf.bdlLimit[i].limitCnt = bdlLog.t200000.bdlFormCnt;
        mem.tmpbuf.bdlLimit[i].bdlCd = bdlLog.t200000.bdlCd;
        mem.tmpbuf.bdlLimit[i].saleQty = saleQty;
        mem.tmpbuf.bdlLimit[i].dspFlg = 1;
      }
    }
  }
}
