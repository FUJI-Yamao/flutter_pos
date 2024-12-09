/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_assort.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_void.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/t_item_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_set.dart';
import 'rcsyschk.dart';

class RcItmSet {
  /// Set ITMRBUF Datas
  /// 関連tprxソース: rcitmset.c - rcSet_Istl_Pm
  static Future<void> rcSetIstlPm() async {
    RegsMem mem = SystemFunc.readRegsMem();
    int itmCnt = mem.tTtllog.t100001Sts.itemlogCnt;

    rcClrItemRbuf(mem, itmCnt);
    rcMovSeqNo(mem, itmCnt);
    rcSetStlDscFlag(mem, itmCnt);
    rcMovStlDscAmt(mem, itmCnt);
    rcMovStlDscPer(mem, itmCnt);
    await rcSetCpnBarCd(mem, itmCnt);
    await rcSetSCouponData(mem, itmCnt);
    await rcSetChkrItemData(mem, itmCnt);
    await RcSet.rcIncItmCnt();
  }

  /// 関連tprxソース: rcitmset.c - rcClr_Item_Rbuf
  static void rcClrItemRbuf(RegsMem mem, int itmCnt) {
    mem.tItemLog[itmCnt] = TItemLog();
    mem.tmpbuf.assort[itmCnt] = RxMemAssort();
    mem.tmpbuf.voidbp[itmCnt] = RxMemVoid();
    mem.bdlSch[itmCnt].removeRange(BdlKind.bdlNormal.index, BdlKind.bdlMbr.index);
    mem.stmSch[itmCnt].clear();
  }

  /// 関連tprxソース: rcitmset.c - rcMov_Seq_No
  static void rcMovSeqNo(RegsMem mem, int itmCnt) {
    mem.tItemLog[itmCnt].seqNo = itmCnt + 1;
  }

  /// 関連tprxソース: rcitmset.c - rcMov_StlDscAmt
  static void rcMovStlDscAmt(RegsMem mem, int itmCnt) {
    AcMem cMem = SystemFunc.readAcMem();
    int dscAmt = cMem.working.dataReg.kDsc0;
    if ((RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC1.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC2.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC3.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC4.keyId])) ||
        (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC5.keyId]))) {
      mem.tItemLog[itmCnt].t50100.stldscAmt = dscAmt;
    }
  }

  /// 関連tprxソース: rcitmset.c - rcMov_StlDscPer
  static void rcMovStlDscPer(RegsMem mem, int itmCnt) {
    AcMem cMem = SystemFunc.readAcMem();
    mem.tItemLog[itmCnt].t50100.stlPdscPer = (cMem.working.dataReg.kPm1_0 ~/ 100);
  }

  /// 関連tprxソース: rcitmset.c - rcSet_StlDscFlag
  static void rcSetStlDscFlag(RegsMem mem, int itmCnt) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    FuncKey fncCode = FuncKey.KY_NONE;
    AcMem cMem = SystemFunc.readAcMem();

    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC1.keyId])) {
      fncCode = FuncKey.KY_DSC1;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC2.keyId])) {
      fncCode = FuncKey.KY_DSC2;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC3.keyId])) {
      fncCode = FuncKey.KY_DSC3;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC4.keyId])) {
      fncCode = FuncKey.KY_DSC4;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC5.keyId])) {
      fncCode = FuncKey.KY_DSC5;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM1.keyId])) {
      fncCode = FuncKey.KY_PM1;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM2.keyId])) {
      fncCode = FuncKey.KY_PM2;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM3.keyId])) {
      fncCode = FuncKey.KY_PM3;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM4.keyId])) {
      fncCode = FuncKey.KY_PM4;
    } else if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM5.keyId])) {
      fncCode = FuncKey.KY_PM5;
    }

    switch (fncCode) {
      case FuncKey.KY_DSC1:
      case FuncKey.KY_DSC2:
      case FuncKey.KY_DSC3:
      case FuncKey.KY_DSC4:
      case FuncKey.KY_DSC5:
        mem.tItemLog[itmCnt].t50100.stldscCd = fncCode.keyId;
        mem.tItemLog[itmCnt].t50100.trendsTyp =
            Rxkoptcmncom.rxChkKoptDscTrendsTyp(cBuf, fncCode.keyId);
        mem.tItemLog[itmCnt].t10003.recMthdFlg = 0x05;
        break;
      case FuncKey.KY_PM1:
      case FuncKey.KY_PM2:
      case FuncKey.KY_PM3:
      case FuncKey.KY_PM4:
      case FuncKey.KY_PM5:
        mem.tItemLog[itmCnt].t50100.stldscCd = fncCode.keyId;
        mem.tItemLog[itmCnt].t50100.trendsTyp =
            Rxkoptcmncom.rxChkKoptDscTrendsTyp(cBuf, fncCode.keyId);
        mem.tItemLog[itmCnt].t10003.recMthdFlg = 0x06;
        break;
      default:
        break;
    }
  }

  /// 関連tprxソース: rcitmset.c - rcSet_cpn_bar_cd
  static Future<void> rcSetCpnBarCd(RegsMem mem, int itmCnt) async {
    AcMem cMem = SystemFunc.readAcMem();

    if (RcSysChk.rcChkTpointSystem() != 0) {
      mem.tItemLog[itmCnt].t10800.ichiCd2 = cMem.working.dataReg.cpnBarCd;
      cMem.working.dataReg.cpnBarCd = "";
      return;
    }
    if (((await CmCksys.cmRainbowCardSystem() != 0) &&
        (int.parse(cMem.working.dataReg.cpnBarCd[0]) >= 0) &&
        (int.parse(cMem.working.dataReg.cpnBarCd[0]) >= 9)) ||
        ((await CmCksys.cmDcmpointSystem() != 0) &&
            (cMem.ticketBar.ticketBarFlg == 2))) {
      mem.tItemLog[itmCnt].t10800.ichiCd2 = cMem.working.dataReg.cpnBarCd;
      cMem.working.dataReg.cpnBarCd = "";
    }
  }

  /// 関連tprxソース: rcitmset.c - rcSet_S_Coupon_Data
  static Future<void> rcSetSCouponData(RegsMem mem, int itmCnt) async {
    AcMem cMem = SystemFunc.readAcMem();

    if (await CmCksys.cmSpecialCouponSystem() != 0) {
      mem.tItemLog[itmCnt].t10000Sts.promCd =
          cMem.working.pluReg.t10000Sts.promCd;
      mem.tItemLog[itmCnt].t10000Sts.promCd1 =
          cMem.working.pluReg.t10000Sts.promCd1;
      mem.tItemLog[itmCnt].t10000Sts.promCd2 =
          cMem.working.pluReg.t10000Sts.promCd2;
      mem.tItemLog[itmCnt].t10000Sts.promCd3 =
          cMem.working.pluReg.t10000Sts.promCd3;
      cMem.working.pluReg.t10000Sts.promCd = 0;
      cMem.working.pluReg.t10000Sts.promCd1 = 0;
      cMem.working.pluReg.t10000Sts.promCd2 = 0;
      cMem.working.pluReg.t10000Sts.promCd3 = 0;
    }
  }

  /// 二人制チェッカー側での登録アイテムの判断用にフラグをセットする
  /// 関連tprxソース: rcitmset.c - rcSet_ChkrItemData
  static Future<void> rcSetChkrItemData(RegsMem mem, int itmCnt) async {
    if (!(await RcSysChk.rcCheckQCJCSystem())) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
        mem.tItemLog[itmCnt].t10000Sts.opeFlg = 1;
      }
    }
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// Set ITMRBUF Init Datas
  /// 引数: キーファンクション
  /// 関連tprxソース: rcitmset.c - rcSet_Init_Data
  static int rcSetInitData(int typ) {
    return 0;
  }
}