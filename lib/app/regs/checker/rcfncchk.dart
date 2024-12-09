/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';

import 'package:flutter_pos/app/regs/checker/rckyprecavoid.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/common/interface_define.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/mm_reptlib_def.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/apllib_other.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/apllib/sio_chk.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../regs/inc/rc_regs.dart';
import '../../regs/inc/rc_mem.dart';
import '../../regs/checker/rc_elog.dart';
import '../../regs/checker/rcsyschk.dart';
import '../common/rxkoptcmncom.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mbr.dart';
import 'rc_28dsp.dart';
import 'rc_crdt_fnc.dart';
import 'rc_flrda.dart';
import 'rc_ifevent.dart';
import 'rc_ifprint.dart';
import 'rc_inout.dart';
import 'rc_mbr_com.dart';
import 'rc_mbrrealsvr_fresta.dart';
import 'rc_qc_dsp.dart';
import 'rc_qrinf.dart';
import 'rc_sgdsp.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rc_suica_com.dart';
import 'rcitmchk.dart';
import 'rckycpwr.dart';
import 'rckycrdtvoid.dart';
import 'rcmbrbuyadd.dart';
import 'rcinoutdsp.dart';
import 'rc_suica_com.dart';
import 'rcky_rfdopr.dart';
import 'rcky_sus.dart';
import 'rckycpwr.dart';
import 'rckycrdtvoid.dart';
import 'rckyprecavoid.dart';
import 'rcmbrbuyadd.dart';
import 'rcmbrflrd.dart';
import 'rcmbrkytcktmain.dart';
import 'rcmbrpcom.dart';
import 'rcqr_com.dart';
import 'rcsg_com.dart';

class RcFncChk {
  ///  関連tprxソース: rcfncchk.c - rcCheck_ESVoidS_Mode
  static Future<bool> rcCheckESVoidSMode() async
  {
    AcMem cMem = SystemFunc.readAcMem();
    EsVoid esVoid = SystemFunc.readEsVoid();
    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return( ( cMem.stat.scrMode == RcRegs.RG_ESVOIDS ) ||         /* RG STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.VD_ESVOIDS ) ||         /* VD STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.TR_ESVOIDS ) ||         /* TR STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.SR_ESVOIDS )   );       /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (esVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
          return( ( cMem.stat.scrMode == RcRegs.RG_ESVOIDS ) ||       /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_ESVOIDS ) ||       /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_ESVOIDS ) ||       /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_ESVOIDS )   );     /* SR STL Mode ? 10.4LCD */
        }
        else {
          return( (cMem.stat.subScrMode == RcRegs.RG_ESVOIDS ) ||    /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_ESVOIDS ) ||    /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_ESVOIDS ) ||    /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_ESVOIDS )   );  /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  /// 検索返品中かチェックする（Subtotal Display）
  /// 戻り値: false:返品中でない  true:返品中
  ///  関連tprxソース: rcfncchk.c - rcCheck_ERefS_Mode
  static Future<bool> rcCheckERefSMode() async
  {
    AcMem cMem = SystemFunc.readAcMem();
    ERef eRef = SystemFunc.readEref();

    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
      return( (cMem.stat.scrMode == RcRegs.RG_EREFS ) ||         /* RG STL Mode ? 10.4LCD */
          (cMem.stat.scrMode == RcRegs.VD_EREFS ) ||         /* VD STL Mode ? 10.4LCD */
          (cMem.stat.scrMode == RcRegs.TR_EREFS ) ||         /* TR STL Mode ? 10.4LCD */
          (cMem.stat.scrMode == RcRegs.SR_EREFS ) );         /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (eRef.nowDisplay == RcElog.EREF_LCDDISP) {
        return( (cMem.stat.scrMode == RcRegs.RG_EREFS ) ||      /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_EREFS ) ||      /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_EREFS ) ||      /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_EREFS ) );      /* SR STL Mode ? 10.4LCD */
        }
        else {
        return( (cMem.stat.subScrMode == RcRegs.RG_EREFS ) ||    /* RG STL Mode ?  5.7LCD */
            (cMem.stat.subScrMode == RcRegs.VD_EREFS ) ||    /* VD STL Mode ?  5.7LCD */
            (cMem.stat.subScrMode == RcRegs.TR_EREFS ) ||    /* TR STL Mode ?  5.7LCD */
            (cMem.stat.subScrMode == RcRegs.SR_EREFS ) );    /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  static bool rcCheckTelListMode() {
    return false;
  }

  /// テンキー入力中かチェックする
  /// 戻り値: true=入力中  false=入力中でない
  /// 関連tprxソース: rcfncchk.c - rcChk_Ten_On
  static bool rcChkTenOn() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.ent.tencnt != 0);
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  static int rcfncchkCheckerUpdctrlFlg() {
    return 0;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ERefI_Mode
  static Future<bool> rcCheckERefIMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    ERef eRef = SystemFunc.readEref();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_EREFI) || /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_EREFI) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_EREFI) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_EREFI));  /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (eRef.nowDisplay == RcElog.EREF_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_EREFI) || /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_EREFI) || /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_EREFI) || /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_EREFI));  /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_EREFI) || /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_EREFI) || /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_EREFI) || /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_EREFI));  /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ESVoidI_Mode
  static Future<bool> rcCheckESVoidIMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    EsVoid esVoid = SystemFunc.readEsVoid();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CASHIER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_ESVOIDI) /* RG STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.VD_ESVOIDI)  /* VD STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.TR_ESVOIDI)  /* TR STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_ESVOIDI));  /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (esVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_ESVOIDI) /* RG STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.VD_ESVOIDI)  /* VD STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.TR_ESVOIDI)  /* TR STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.SR_ESVOIDI));  /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_ESVOIDI) /* RG STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.VD_ESVOIDI)  /* VD STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.TR_ESVOIDI)  /* TR STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.SR_ESVOIDI));  /* SR STL Mode ? 5.7LCD */
        }
    }
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_ReservMode
  static bool rcCheckReservMode() {
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_Stl_Mode
  static Future<bool> rcCheckStlMode() async {
    if (Rc28dsp.rc28dspCheckInfoSlct()) {
      return false;
    }

    final result = await RcSysChk.rcKySelf();
    switch (result) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_SINGLE:
      case RcRegs.KY_DUALCSHR:
        AcMem cMem = SystemFunc.readAcMem();
        return (cMem.stat.scrMode == RcRegs.RG_STL
            || cMem.stat.scrMode == RcRegs.VD_STL
            || cMem.stat.scrMode == RcRegs.TR_STL
            || cMem.stat.scrMode == RcRegs.SR_STL
            || cMem.stat.scrMode == RcRegs.OD_STL
            || cMem.stat.scrMode == RcRegs.IV_STL
            || cMem.stat.scrMode == RcRegs.PD_STL
            || cMem.stat.scrMode == RcRegs.IN_STL
            || cMem.stat.scrMode == RcRegs.OU_STL);
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_SItm_Mode
  static bool rcCheckSItmMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.stat.subScrMode == RcRegs.RG_SITM
        || cMem.stat.subScrMode == RcRegs.VD_SITM
        || cMem.stat.subScrMode == RcRegs.TR_SITM
        || cMem.stat.subScrMode == RcRegs.SR_SITM
        || cMem.stat.subScrMode == RcRegs.OD_SITM
        || cMem.stat.subScrMode == RcRegs.IV_SITM
        || cMem.stat.subScrMode == RcRegs.PD_SITM);
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_Preca_Charge
  static bool rcCheckPrecaCharge() {
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcChk_MultiChargeItem
  static int rcChkMultiChargeItem(int smlclsCd) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return -1;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.outSmlclsNum10 == 0) {
      return -1;
    }
    if (cBuf.dbTrm.outSmlclsNum10 == smlclsCd) {
      return FclService.FCL_SUIC.value;
    }
    return -1;
  }

  ///  関連tprxソース: rcfncchk.c - rcChk_RegMultiChargeItem
  static Future<int> rcChkRegMultiChargeItem(int kind, int flg) async {
    int p, q;
    q = 0;
    if (RegsMem().tTtllog.t100001Sts.itemlogCnt > 0) {
      for (p = 0; p < RegsMem().tTtllog.t100001Sts.itemlogCnt; p++) {
        if ((!await CalcMMSTMSchDBRd.rcStlItemBitCheck(p)) &&
            (!CalcMMSTMSchDBRd.rcManualStampCodeCheck(p)) &&
            (!RcStl.rcChkItmRBufCatalina(p)) &&
            (!RcStl.rcChkItmRBufNotePlu(p)) &&
            (!CalcMMSTMSchDBRd.rcStlPlusItemBitCheck(p))) {
          if ((RegsMem().tItemLog[p].t10000.realQty >= 1) &&
              (RegsMem().tItemLog[p].t10002.corrQty == 0) &&
              (RegsMem().tItemLog[p].t10002.voidQty == 0) &&
              (RegsMem().tItemLog[p].t10002.scrvoidQty == 0)) {
            if (rcChkMultiChargeItem(RegsMem().tItemLog[p].t10000.smlclsCd) == kind) {
              if (flg == 1) {   /* Check ChargeItem */
                q++;
              }
            } else {
              if (flg == 0) {   /* Check OtherItem */
                q++;
              }
            }
          }
        }
      }
    }
    return (q);
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcfncchk.c - rcChk_RegYumecaChargeItem
  static int rcChkRegYumecaChargeItem(int flg) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcfncchk.c - rcfncchk_cct_charge_system
  static bool rcfncchkCctChargeSystem() {
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_PrecaVoidI_Mode
  static Future<bool> rcCheckPrecaVoidIMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    PrecaVoid precaVoid = PrecaVoid();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CASHIER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_PRECAVOIDI) /* RG STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.VD_PRECAVOIDI)  /* VD STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.TR_PRECAVOIDI)  /* TR STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_PRECAVOIDI));  /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (precaVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_PRECAVOIDI) /* RG STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.VD_PRECAVOIDI)  /* VD STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.TR_PRECAVOIDI)  /* TR STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.SR_PRECAVOIDI));  /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_PRECAVOIDI) /* RG STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.VD_PRECAVOIDI)  /* VD STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.TR_PRECAVOIDI)  /* TR STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.SR_PRECAVOIDI));  /* SR STL Mode ? 5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcKy_Status
  static int rcKyStatus(var buf, int macro) {
    //void *buf, long macro
    AcMem cMem = SystemFunc.readAcMem();
    Onetime oneTime = Onetime();

    if ((macro & RcRegs.MACRO0) != 0) {
      buf = rcKyStL0(buf, RcFncChkDef.macro0List);
    }
    if ((macro & RcRegs.MACRO1) != 0) {
      buf = rcKyStL1(buf, RcFncChkDef.macro1List);
    }
    if ((macro & RcRegs.MACRO2) != 0) {
      buf = rcKyStL2(buf, RcFncChkDef.macro2List);
    }
    if ((macro & RcRegs.MACRO3) != 0) {
      buf = rcKyStL3(buf, RcFncChkDef.macro3List);
    }
    buf = rcKyStL4(buf, RcFncChkDef.macro4List);

    int maxFKey = FuncKey.MAX_FKEY.keyId;
    for (int i = 0; i <= maxFKey; i++) {
      if (((cMem.keyStat[i]) & (buf[i])) != 0) {
        if (oneTime.logSkip != 1) {
          String hex1 = cMem.keyStat[i].toRadixString(16);
          String hex2 = buf[i].toRadixString(16);

          TprLog().logAdd(
              Tpraid.TPRAID_CHK, LogLevelDefine.normal,
              "rcKyStatus : KEY [{$i}]");
          TprLog().logAdd(
              Tpraid.TPRAID_CHK, LogLevelDefine.normal,
              "rcKyStatus : key_stat [{$hex1}]");
          TprLog().logAdd(
              Tpraid.TPRAID_CHK, LogLevelDefine.normal,
              "rcKyStatus : macro_list [{$hex2}]");
        }
        return i;
      }
    }
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcfncchk.c - rcChk_SaleAmtZero
  static int rcChkSaleAmtZero() { //void *buf, long macro
    return 0;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ChgCin_Mode
  static bool rcCheckChgCinMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return( (cMem.stat.scrMode == RcRegs.RG_CCIN) ||        /* RG ChgCin Mode ? */
        (cMem.stat.scrMode == RcRegs.VD_CCIN) ||        /* VD ChgCin Mode ? */
        (cMem.stat.scrMode == RcRegs.TR_CCIN) ||        /* TR ChgCin Mode ? */
        (cMem.stat.scrMode == RcRegs.SR_CCIN) );        /* SR ChgCin Mode ? */
  }

  ///  関連tprxソース: rcfncchk.c - rcChk_CCINOperation
  static Future<bool> rcChkCCINOperation() async {
    int i = 0;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      if (cBuf.dbStaffopen.chkr_status != 1) {
        return (true);
      }
    }
    else {
      if (cBuf.dbStaffopen.cshr_status != 1) {
        return (true);
      }
    }

    AcMem cMem = SystemFunc.readAcMem();
    if ((cMem.kfncCdCnt > 0) && (RcRegs.kFncCd != null)) {
      for (i = 0; i < cMem.kfncCdCnt; i++) {
        if (RcRegs.kFncCd![i] == FuncKey.KY_AUTO_DECCIN.keyId) {
          return (false);
        }
      }
    }

    return (true);
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_ChgErr_Mode
  static bool rcCheckChgErrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.acbData.acbErrorDisp == 1);
  }

  ///  関連tprxソース: rcfncchk.c - rcChk_Err
  static int rcChkErr() {
    AcMem cMem = SystemFunc.readAcMem();
    return cMem.ent.errStat != 0 ? 1 : 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcfncchk.c - rcOpeTime
  static void rcOpeTime(int flg) {
    return;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcfncchk_rcpt_acracb_check
  static bool rcFncchkRcptAcracbCheck() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcQC_Check_RPtsMbr_YesNo_Mode
  static bool rcQCCheckRPtsMbrYesNoMode() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcQC_Check_RPtsMbr_Read_Mode
  static bool rcQCCheckRPtsMbrReadMode() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcQC_Check_Rpoint_Pay_Conf_Dsp_Mode
  static bool rcQCCheckRpointPayConfDspMode() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_ValueCard_Mode
  static bool rcCheckValueCardMode() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_ValueCard_MI_Mode
  static bool rcCheckValueCardMIMode() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_Repica_Mode
  static bool rcCheckRepicaMode() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_Ajs_Emoney_Mode
  static bool rcCheckAjsEmoneyMode() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_Cogca_Mode
  static bool rcCheckCogcaMode() {
    return false;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_Repica_TC_Mode
  static bool rcCheckRepicaTCMode() {
    return false;
  }

  /// 端末カード読込画面が表示されているかチェックする
  /// 戻り値: true=表示中  false=非表示
  ///  関連tprxソース: rcfncchk.c - rcCheck_Cat_CardRead_Mode
  static Future<bool> rcCheckCatCardReadMode() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_SINGLE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_CAT_CARDREAD_DSP) ||  /* RG Cat CardRead Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_CAT_CARDREAD_DSP) ||  /* VD Cat CardRead Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_CAT_CARDREAD_DSP) ||  /* TR Cat CardRead Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_CAT_CARDREAD_DSP));  /* SR Cat CardRead Mode ? 10.4LCD */
      default:
        break;
    }
    return false;
  }

  /// 関数：rcCheck_PassportInfo_Mode
  /// 機能：旅券情報入力画面モードをチェックする
  /// 引数：なし
  /// 戻値：0:画面を表示していない　1:画面表示している
  /// 関連tprxソース: rcfncchk.c - rcCheck_PassportInfo_Mode
  static int rcCheckPassportInfoMode() {
    AcMem cMem = SystemFunc.readAcMem();
    int res = 0;
    if ((cMem.stat.scrMode == RcRegs.RG_PASSPORTINFO_DSP) ||
        (cMem.stat.scrMode == RcRegs.TR_PASSPORTINFO_DSP)) {
      res = 1;
    }
    return res;
  }

  // TODO:00007 梶原 中身の実装予定　
  ///  関連tprxソース: rcfncchk.c - rcChk_RwcRead_Mode
  static bool rcChkRwcReadMode() {
    return true;
    // return(
    //     #if SAPPORO
    // ((rcChk_Sapporo_Pana_System() || rcChk_Jkl_Pana_System() || cm_RainbowCard_system() || cm_PanaMember_system() || cm_MoriyaMember_system()) && rcCheck_Sapporo_Pana_Mode()) ||
    // #endif
    // (rcChk_Mcp200_System() && rcCheck_Mcp200_Mode()) || (rcCheck_Ht2980_Mode()) ||
    // (rcChk_AbsV31_System() && rcCheck_Abs_V31_Mode())
    // );
  }

  /// キーステータスをリセットする（Bit0）
  /// 引数:[buf] Local Key Flag Buffer
  /// 引数:[pwList] Macro Key List
  /// 戻り値: Reset Key Status List (Bit0 only)
  /// 関連tprxソース: rcfncchk.c - rcKy_St_L0
  static List<int> rcKyStL0(List<int> buf, List<int> pwList) {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    bool notResetFlg = false;
    int chkCode = 0;
    var res = buf;

    if ((RcSysChk.rcsyschkUniteRegTerm()) &&
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_NOTAX.keyId]) &&
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PCHG.keyId]) &&
        ((cMem.stat.fncCode == FuncKey.KY_PLU.keyId)
            || (atSing.inputbuf.dev == DevIn.D_OBR)
        )
    ) {
      notResetFlg = true;
      chkCode = pwList[0];
    }

    int i = 0;
    while (i < pwList.length) {
      if (RcSysChk.rcsyschkUniteRegTerm()) {
        if (notResetFlg && (chkCode == FuncKey.KY_NOTAX.keyId)) {
          /* 非課税キーをクリアしない */
        } else {
          RcRegs.kyStR0(buf, pwList[i]);
          if (i < pwList.length - 1) {
            chkCode = pwList[i + 1];
          }
        }
      } else {
        RcRegs.kyStR0(buf, pwList[i]);
      }
      i++;
    }
    return res;
  }

  /// キーステータスをリセットする（Bit1）
  /// 引数:[buf] Local Key Flag Buffer
  /// 引数:[pwList] Macro Key List
  /// 戻り値: Reset Key Status List (Bit1 only)
  /// 関連tprxソース: rcfncchk.c - rcKy_St_L1
  static List<int> rcKyStL1(List<int> buf, List<int> pwList) {
    var res = buf;
    int i = 0;
    while (i < pwList.length) {
      RcRegs.kyStR1(buf, pwList[i]);
      i++;
    }
    return res;
  }

  /// キーステータスをリセットする（Bit2）
  /// 引数:[buf] Local Key Flag Buffer
  /// 引数:[pwList] Macro Key List
  /// 戻り値: Reset Key Status List (Bit2 only)
  /// 関連tprxソース: rcfncchk.c - rcKy_St_L2
  static List<int> rcKyStL2(List<int> buf, List<int> pwList) {
    var res = buf;
    int i = 0;
    while (i < pwList.length) {
      RcRegs.kyStR2(buf, pwList[i]);
      i++;
    }
    return res;
  }

  /// キーステータスをリセットする（Bit3）
  /// 引数:[buf] Local Key Flag Buffer
  /// 引数:[pwList] Macro Key List
  /// 戻り値: Reset Key Status List (Bit3 only)
  /// 関連tprxソース: rcfncchk.c - rcKy_St_L3
  static List<int> rcKyStL3(List<int> buf, List<int> pwList) {
    var res = buf;
    int i = 0;
    while (i < pwList.length) {
      RcRegs.kyStR3(buf, pwList[i]);
      i++;
    }
    return res;
  }

  /// キーステータスをリセットする（Bit4）
  /// 引数:[buf] Local Key Flag Buffer
  /// 引数:[pwList] Macro Key List
  /// 戻り値: Reset Key Status List (Bit4 only)
  /// 関連tprxソース: rcfncchk.c - rcKy_St_L4
  static List<int> rcKyStL4(List<int> buf, List<int> pwList) {
    var res = buf;
    int i = 0;
    while (i < pwList.length) {
      RcRegs.kyStR4(buf, pwList[i]);
      i++;
    }
    return res;
  }

  // TODO:00008 宮家 中身の実装予定　
  ///  関連tprxソース: rcfncchk.c - rcQC_Check_QP_Mode
  static bool rcQCCheckQPMode() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return true;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_Registration
  static bool rcCheckRegistration() {
    AcMem cMem = SystemFunc.readAcMem();
    return ( !( !RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])
        && RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]) ) );
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_NetReservMode
  static bool rcCheckNetReservMode() {
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_Edy_Mode
  static Future<bool> rcCheckEdyMode() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_EDY) ||   /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_EDY) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_EDY) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_EDY) );      /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_EDY) ||  /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_EDY) ||    /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_EDY) ||    /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_EDY)); /* SR STL Mode ? 10.4LCD */
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.subScrMode == RcRegs.RG_EDY) ||  /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_EDY) ||  /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_EDY) ||  /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_EDY));   /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcHappySelf_ChkTb1System
  static Future<bool> rcHappySelfChkTb1System() async {
    /*
    if (await RcSysChk.rcChkHappySelfQCashier()) {
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((await CmCksys.cmHappySelfAllSystem() !=0) &&
        ((cBuf.iniMacInfo.select_self.self_mode == 1) || (cBuf.iniMacInfo.select_self.qc_mode == 1)) &&
        (await CmCksys.cmNimocaPointSystem()!= 0) &&
        (await CmCksys.cmTb1System() != 0)) {
      return true;
    }
    return false;
     */
    return true;
  }

  ///  関連tprxソース: rcfncchk.c - rc_Check_Masr_System
  static bool rcCheckMasrSystem() {
    return ((CmCksys.cmMasrSystem() != 0) && (SioChk.sioCheck(Sio.SIO_MASR) == Typ.YES));
  }

  ///  関連tprxソース: rcfncchk.c - rcSG_Check_MbrScn_Mode_2
  static bool rcSGCheckMbrScnMode2() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.stat.scrMode == RcRegs.RG_SG_MBRSCN_2) ||
        (cMem.stat.scrMode == RcRegs.TR_SG_MBRSCN_2);
  }
  
  ///  関連tprxソース: rcfncchk.c - rcSG_Check_MbrInput_Mode
  static bool rcSGCheckMbrInputMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.stat.scrMode == RcRegs.RG_SG_MBRINPUT) ||
          (cMem.stat.scrMode == RcRegs.TR_SG_MBRINPUT);
  }

  ///  関連tprxソース: rcfncchk.c - rcChk_Before_MulKy
  static Future<bool> rcChkBeforeMulKy() async {
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        return ((SgMulDsp().mul_disp == 0) &&
            ((RcSysChk.rcCheckTECOperation() == 1) ||
                (RcSysChk.rcCheckTECOperation() == 2)));
      }
    }
    return ((RcSysChk.rcCheckTECOperation() == 1) || (RcSysChk.rcCheckTECOperation() == 2));
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcGet_EmployeeCard_FncCode
  static int rcGetEmployeeCardFncCode() {
    return 0;
  }

  ///  関連tprxソース: rcfncchk.c - rcQC_Check_MenteDsp_Mode
  static bool rcQCCheckMenteDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_MENTE)
        || (cMem.stat.scrMode == RcRegs.TR_QC_MENTE));
  }

  ///  関連tprxソース: rcfncchk.c - rcQC_Check_StartDsp_Mode
  static bool rcQCCheckStartDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_START)
        || (cMem.stat.scrMode == RcRegs.TR_QC_START));
  }

  /// 現使用締めキーがdポイント利用キーか判定する
  /// 関連tprxソース: rcfncchk.c - rcChk_dPointUseKey
  /// 引数　　：なし
  /// 戻り値　：true:dポイント利用キー、false:dポイント利用キーではない

  static bool rcChkDPointUseKey() {
    int fncCd;
    fncCd = rcGetdPointUseKey();

    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.fncCode == fncCd) {
      return true;
    } else {
      return false;
    }
  }

  /// dポイント利用キーに指定されている締めキーを返す
  /// 関連tprxソース: rcfncchk.c - rc_GetdPointUseKey
  /// 引数　　：なし
  /// 戻り値　：dポイント利用キー
  static int rcGetdPointUseKey() {
    int fncCd;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      if (xRet.isInvalid()) {
        TprLog().logAdd(
            0, LogLevelDefine.error, "rcGetdPointUseKey() rxMemRead error\n");
        return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
      }
    }
    RxCommonBuf pCom = xRet.object;

    fncCd = 0;
    if (RcSysChk.rcChkDPointSystem()) {
      if ((pCom.dbTrm.dpntUse >= 1) &&
          (pCom.dbTrm.dpntUse <= 10)) { // ｄポイント用会計 品券キー
        fncCd = pCom.dbTrm.dpntUse - 1;
        fncCd += FuncKey.KY_CHA1.keyId;
      } else if ((pCom.dbTrm.dpntUse >= 11) && (pCom.dbTrm.dpntUse <= 15)) {
        fncCd = pCom.dbTrm.dpntUse - 11;
        fncCd += FuncKey.KY_CHK1.keyId;
      } else if ((pCom.dbTrm.dpntUse >= 16) && (pCom.dbTrm.dpntUse <= 35)) {
        fncCd = pCom.dbTrm.dpntUse - 16;
        fncCd += FuncKey.KY_CHA11.keyId;
      }
    }
    return fncCd;
  }

  /// 多慶屋様特注 未読現金設定をチェックする
  /// 関連tprxソース: rcfncchk.c - rcsyschk_unread_cash_chk
  /// 引数   : なし
  /// 戻り値 : true :未読現金設定である, false :未読現金設定でない
  static Future<bool> rcsyschkUnreadCashChk(int fncCd) async {
    AcMem cMem = SystemFunc.readAcMem();
    KopttranBuff koptTran = KopttranBuff();
    if (!RcSysChk.rcChkKYCHA(fncCd)) { //会計キー／品券キー でない
      return false;
    }

    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);

    if ((koptTran.crdtEnbleFlg == 0) //掛売登録＝しない
        && (koptTran.nochgFlg == 0) //釣り銭支払＝あり
        && (koptTran.unreadCashTyp == 1)) { //未読現金＝使用する
      return true;
    }
    return false;
  }

  /// 多慶屋様特注 キャンペーン値引き設定をチェックする
  /// 関連tprxソース: rcfncchk.c - rcsyschk_campaign_set_chk
  ///  引数  : なし
  ///  戻り値 : true:キャンペーン値引き設定である, false :キャンペーン値引き設定でない
  static Future<bool> rcsyschkCampaignSetChk(int fncCd) async {
    AcMem cMem = SystemFunc.readAcMem();
    KopttranBuff koptTran = KopttranBuff();
    if (!RcSysChk.rcChkKYCHA(fncCd)) { //会計キー／品券キー でない
      return false;
    }

    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);

    if ((koptTran.splitEnbleFlg == 1) //小計額未満の登録＝有効
        && (koptTran.frcEntryFlg == 0) //預り金額の置数強制＝しない
        && (koptTran.mulFlg == 0) //乗算登録＝禁止
        && (koptTran.crdtEnbleFlg == 0) //掛売登録＝しない
        && (koptTran.chkAmt == 0) //券面金額＝0
        && (koptTran.campaignDscntOpe == 1)) { //割引操作＝１
      return true;
    }
    return false;
  }

  /// 関数：rcChk_AcrAcb_AfterReg_CinStart
  /// 機能：対面セルフ入金動作設定チェック
  /// 関連tprxソース: rcfncchk.c - rcChk_AcrAcb_AfterReg_CinStart
  static Future<bool> rcChkAcrAcbAfterRegCinStart() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (CompileFlag.COLORFIP &&
        ((await RcSysChk.rcChkFselfMain()) ||
        // RM-3800
        ((cBuf.vtclRm5900Flg) &&
        // 釣銭釣札機
        (await RcSysChk.rcChkAcrAcbSystem(1) != 0)))) {
      if ((cBuf.dbTrm.timePrcTyp == 0) || (cBuf.dbTrm.timePrcTyp == 2)) {
        return true;
      } else {
        if (await rcCheckAcrAcbStlMode(atSing.acracbStartFlg) == 1) {
          /* HappySelf仕様[対面セルフ]入金動作「小計後」が可能かチェック */
          return true;
        }
        return false;
      }
    } else {
      return false;
    }
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_Itm_Mode
  static Future<bool> rcCheckItmMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_SINGLE :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_ITM) /* RG ITM Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.VD_ITM) /* VD ITM Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.TR_ITM) /* TR ITM Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_ITM) /* SR ITM Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.OD_ITM) /* OD ITM Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.IV_ITM) /* IV ITM Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.PD_ITM)); /* PD ITM Mode ? 10.4LCD */
    }
    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcfncchk.c - rcCheck_PCT_Connect
  static bool rcCheckPCTConnect() {
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcQC_Check_CrdtUse_Mode
  static bool rcQCCheckCrdtUseMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.bkScrMode == RcRegs.RG_QC_CRDTEND)
        || (cMem.stat.bkScrMode == RcRegs.TR_QC_CRDTEND));
  }

  /// 検索訂正か一括訂正, 通番訂正, プリカ訂正(ZHQ時)の画面であるかチェックする
  /// 関連tprxソース: rcfncchk.c - rcCheck_E_ES_Void_Mode
  /// 引数：なし
  /// 戻値：true:検索訂正か一括訂正か通番訂正かプリカ訂正(ZHQ時)  false:それら画面ではない
  static Future<bool> rcCheckEESVoidMode() async {
    if ((await RcFncChk.rcCheckESVoidSMode())
        || (await rcCheckEVoidMode())
        || (await RcFncChk.rcCheckESVoidIMode())
        || ((await RcSysChk.rcChkZHQsystem())
            && ((await rcCheckPrecaVoidSMode()) ||
                (await RcFncChk.rcCheckPrecaVoidIMode())))
        || (RckyRfdopr.rcRfdOprCheckRcptVoidMode())) { // 通番訂正モードではない
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_EVoid_Mode
  static Future<bool> rcCheckEVoidMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    EVoid eVoid = EVoid();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CASHIER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_EVOID) /* RG STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.VD_EVOID) /* VD STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.TR_EVOID) /* TR STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.SR_EVOID) /* SR STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.CL_EVOID)); /* CL STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (eVoid.nowDisplay == RcElog.EVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_EVOID) /* RG STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.VD_EVOID) /* VD STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.TR_EVOID) /* TR STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.SR_EVOID) /* SR STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.CL_EVOID)); /* CL STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_EVOID) /* RG STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.VD_EVOID) /* VD STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.TR_EVOID) /* TR STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.SR_EVOID) /* SR STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.CL_EVOID)); /* CL STL Mode ? 5.7LCD */
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_PrecaVoidS_Mode
  static Future<bool> rcCheckPrecaVoidSMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    PrecaVoid precaVoid = PrecaVoid();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CASHIER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_PRECAVOIDS) /* RG STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.VD_PRECAVOIDS) /* VD STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.TR_PRECAVOIDS) /* TR STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.SR_PRECAVOIDS)); /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (precaVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_PRECAVOIDS) /* RG STL Mode ? 10.4LCD */
               || (cMem.stat.scrMode == RcRegs.VD_PRECAVOIDS) /* VD STL Mode ? 10.4LCD */
               || (cMem.stat.scrMode == RcRegs.TR_PRECAVOIDS) /* TR STL Mode ? 10.4LCD */
               || (cMem.stat.scrMode == RcRegs.SR_PRECAVOIDS)); /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_PRECAVOIDS) /* RG STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.VD_PRECAVOIDS) /* VD STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.TR_PRECAVOIDS) /* TR STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.SR_PRECAVOIDS)); /* SR STL Mode ? 5.7LCD */
        }
    }
    return false;
  }

  /// 小計画面がクレジット訂正かチェックする（CreditVoid Display）
  /// 関連tprxソース: rcfncchk.c - rcCheck_CrdtVoid_Mode
  /// 引数：なし
  /// 戻値：true:クレジット訂正  false:クレジット訂正でない
  static Future<bool> rcCheckCrdtVoidMode() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CASHIER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_PRECAVOIDS) /* RG STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.VD_PRECAVOIDS) /* VD STL Mode ? 10.4LCD */
             || (cMem.stat.scrMode == RcRegs.TR_PRECAVOIDS) /* TR STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_PRECAVOIDS));  /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (RcKyCrdtVoid.crdtVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_PRECAVOIDS) /* RG STL Mode ? 10.4LCD */
               || (cMem.stat.scrMode == RcRegs.VD_PRECAVOIDS) /* VD STL Mode ? 10.4LCD */
               || (cMem.stat.scrMode == RcRegs.TR_PRECAVOIDS) /* TR STL Mode ? 10.4LCD */
               || (cMem.stat.scrMode == RcRegs.SR_PRECAVOIDS)); /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_PRECAVOIDS) /* RG STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.VD_PRECAVOIDS) /* VD STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.TR_PRECAVOIDS) /* TR STL Mode ? 5.7LCD */
               || (cMem.stat.subScrMode == RcRegs.SR_PRECAVOIDS)); /* SR STL Mode ? 5.7LCD */
        }
    }
    return false;
  }

  /// 小計画面がクレジット訂正かチェックする（CrdtVoid Subtotal Display）
  /// 関連tprxソース: rcfncchk.c - rcCheck_CrdtVoidS_Mode
  /// 引数：なし
  /// 戻値：true:クレジット訂正  false:クレジット訂正でない
  static Future<bool> rcCheckCrdtVoidSMode() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CASHIER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_CRDTVOIDS) /* RG STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.VD_CRDTVOIDS)  /* VD STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.TR_CRDTVOIDS)  /* TR STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_CRDTVOIDS));  /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (RcKyCrdtVoid.crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_CRDTVOIDS) /* RG STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.VD_CRDTVOIDS)  /* VD STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.TR_CRDTVOIDS)  /* TR STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.SR_CRDTVOIDS));  /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_CRDTVOIDS) /* RG STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.VD_CRDTVOIDS)  /* VD STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.TR_CRDTVOIDS)  /* TR STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.SR_CRDTVOIDS));  /* SR STL Mode ? 5.7LCD */
        }
    }
    return false;
  }

  /// 小計画面がクレジット訂正かチェックする（CrdtVoid SubItem Display）
  /// 関連tprxソース: rcfncchk.c - rcCheck_CrdtVoidI_Mode
  /// 引数：なし
  /// 戻値：true:クレジット訂正  false:クレジット訂正でない
  static Future<bool> rcCheckCrdtVoidIMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    CrdtVoid crdtVoid = CrdtVoid();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CASHIER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode ==
            RcRegs.RG_CRDTVOIDI) /* RG STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode ==
                RcRegs.VD_CRDTVOIDI) /* VD STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode ==
                RcRegs.TR_CRDTVOIDI) /* TR STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_CRDTVOIDI));
      /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_CRDTVOIDI) /* RG STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.VD_CRDTVOIDI) /* VD STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.TR_CRDTVOIDI) /* TR STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.SR_CRDTVOIDI)); /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_CRDTVOIDI) /* RG STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.VD_CRDTVOIDI) /* VD STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.TR_CRDTVOIDI) /* TR STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.SR_CRDTVOIDI)); /* SR STL Mode ? 5.7LCD */
        }
    }
    return false;
  }

  /// 小計画面がクレジット訂正かチェックする（CrdtVoid Approve Display）
  /// 関連tprxソース: rcfncchk.c - rcCheck_CrdtVoidA_Mode
  /// 引数：なし
  /// 戻値：true:クレジット訂正  false:クレジット訂正でない
  static Future<bool> rcCheckCrdtVoidAMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    CrdtVoid crdtVoid = CrdtVoid();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CASHIER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_CRDTVOIDA) /* RG STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.VD_CRDTVOIDA)  /* VD STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.TR_CRDTVOIDA)  /* TR STL Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_CRDTVOIDA));  /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_CRDTVOIDA) /* RG STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.VD_CRDTVOIDA)  /* VD STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.TR_CRDTVOIDA)  /* TR STL Mode ? 10.4LCD */
              || (cMem.stat.scrMode == RcRegs.SR_CRDTVOIDA));  /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_CRDTVOIDA) /* RG STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.VD_CRDTVOIDA)  /* VD STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.TR_CRDTVOIDA)  /* TR STL Mode ? 5.7LCD */
              || (cMem.stat.subScrMode == RcRegs.SR_CRDTVOIDA));  /* SR STL Mode ? 5.7LCD */
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_BkESVoid_Mode
  static Future<bool> rcCheckBkESVoidMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ((await RcSuicaCom.rcNimocaRdVoidData()) && (cMem.stat.fncCode == FuncKey.KY_ESVOID.keyId));
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_BkEVoid_Mode
  static Future<bool> rcCheckBkEVoidMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ((await RcSuicaCom.rcNimocaRdVoidData()) && (cMem.stat.fncCode == FuncKey.KY_EVOID.keyId));
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_BkCrdtVoid_Mode
  static Future<bool> rcCheckBkCrdtVoidMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ((await RcSuicaCom.rcNimocaRdVoidData()) && (cMem.stat.fncCode == FuncKey.KY_CRDTVOID.keyId));
  }

  /// プリカポイントに設定された会計キーを獲得する
  /// 関連tprxソース: rcfncchk.c - rcChk_PrecaPointUseKey
  /// 引数：なし
  /// 戻値：true:設定された会計キーあり  false:設定された会計キーなし
  static Future<bool> rcChkPrecaPointUseKey() async {
    int fncCd;
    AcMem cMem = SystemFunc.readAcMem();

    fncCd = await rcGetPrecaPointFncCode();

    if (cMem.stat.fncCode == fncCd) {
      return true;
    } else {
      return false;
    }
  }

  ///　プリカポイントに設定された会計キーを獲得する
  /// 関連tprxソース: rcfncchk.c - rcGet_PrecaPoint_FncCode
  /// 引数：なし
  /// 戻値：return 会計キー
  static Future<int> rcGetPrecaPointFncCode() async {
    int i;
    KopttranBuff koptTran = KopttranBuff();

    int kyCha1 = FuncKey.KY_CHA1.keyId;
    int kyCha10 = FuncKey.KY_CHA10.keyId;
    int kyCha11 = FuncKey.KY_CHA11.keyId;
    int kyCha30 = FuncKey.KY_CHA30.keyId;
    for (i = kyCha1; i <= kyCha10; i++) {
      //memset( &KOPTTRAN, 0x0, sizeof(kopttran_buff) );
      await RcFlrda.rcReadKopttran(i, koptTran);

      if ((koptTran.crdtEnbleFlg == 0) // 掛売登録「しない」
          && (!(RcMbrPcom.rcmbrGetManualRbtKeyCd() == i))) { // 手動割戻か
        if (koptTran.crdtTyp == 39) {
          return i;
        }
      }
    }

    for (i = kyCha11; i <= kyCha30; i++) {
      //memset( &KOPTTRAN, 0x0, sizeof(kopttran_buff) );
      await RcFlrda.rcReadKopttran(i, koptTran);

      if ((koptTran.crdtEnbleFlg == 0) // 掛売登録「しない」
          && (!(RcMbrPcom.rcmbrGetManualRbtKeyCd() == i))) { // 手動割戻か
        if (koptTran.crdtTyp == 39) {
          return i;
        }
      }
    }

    return 0;
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_ItemDsp_Mode
  static bool rcQCCheckItemDspMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_QC_ITEM)
        || (cMem.stat.scrMode == RcRegs.TR_QC_ITEM));
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_ID_Mode_All
  /// 機能：QCashier iDモードのまとまり
  /// 引数：なし
  /// 戻値：結果
  static Future<bool> rcQCCheckIDModeAll() async {
    return (await rcQCCheckIDMode()
        || await rcQCCheckIDEndMode());
  }

  // 関連tprxソース: rcfncchk.c - rcQC_Check_ID_Mode
  /// 機能：QCashier ID決済画面かをチェック
  /// 引数：なし
  /// 戻値：結果
  static Future<bool> rcQCCheckIDMode() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // AcMem cMem = SystemFunc.readAcMem();
    // final result = await RcSysChk.rcKySelf();
    // switch (result) {
    //   case RcRegs.DESKTOPTYPE:
    //   case RcRegs.KY_SINGLE:
    //   case RcRegs.KY_CHECKER:
    //   case RcRegs.KY_DUALCSHR:
    //     return ( cMem.stat.scrMode == RcRegs.RG_QC_ID_DSP
    //           || cMem.stat.scrMode == RcRegs.TR_QC_ID_DSP );
    //   default:
    //     break;
    // }
    // return false;
    return true;
  }

  // 関連tprxソース: rcfncchk.c - rcQC_Check_ID_End_Mode
  /// 機能：QCashier ID支払画面かをチェック
  /// 引数：なし
  /// 戻値：結果
  static Future<bool> rcQCCheckIDEndMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    final result = await RcSysChk.rcKySelf();
    switch (result) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_SINGLE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return (cMem.stat.scrMode == RcRegs.RG_QC_ID_END_DSP
            || cMem.stat.scrMode == RcRegs.TR_QC_ID_END_DSP);
      default:
        break;
    }
    return false;
  }

  /// 乗算使用時、「商品」「置数」「X」の順番になる仕様チェック
  /// 関連tprxソース: rcfncchk.c - rcfncchk_Special_MulUse
  /// 引数：なし
  /// 戻値： true:対象仕様, false:対象仕様ではない
  static Future<bool> rcfncchkSpecialMulUse() async {
    if (((await CmCksys.cmMarutoSystem() != 0) // マルト様
        && (RcSysChk.rcCheckTECOperation() == 4))
        || (await CmCksys.cmSm3MaruiSystem() != 0) // マルイ様
        || (RcSysChk.rcCheckEtcOperation()) // カネスエ様
        || (RcSysChk.rcChkSpecialMultiOpe())) // 特殊乗算オペレーション
        {
      return true;
    }
    return false;
  }

  /// QC側で取引レシートを発行するかどうかを判定する
  /// 関連tprxソース: rcfncchk.c - rcfncchk_alltran_qc_conduct
  /// 引数：なし
  /// 戻値： 1:発行する, 0:発行しない
  /// ※参照先で戻り値intを使用しているため、boolに変換はしない
  static Future<int> rcfncchkAlltranQCConduct() async {
    int result = 0;
    RegsMem regsMem = RegsMem();

    if (await RcSysChk.rcQRChkPrintSystem()) {
      if (await RcSysChk.rcsyschkAlltranUpdateQCSide()) {
        result = 1;
      } else {
        if(await RcSysChk.rcsyschkQcNimocaSystem()){ // ニモカポイントをQCashier側で付加する為
          if(regsMem.tTtllog.t100700.mbrInput == MbrInputType.mbrKeyInput.index){
            result = 1;
          }
        }
      }
    }
    return result;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_Suica_Mode
  static Future<bool> rcCheckSuicaMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_SUICA) ||         /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_SUICA) ||         /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_SUICA) ||         /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_SUICA));         /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_SUICA) ||      /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_SUICA) ||      /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_SUICA) ||      /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_SUICA));      /* SR STL Mode ? 10.4LCD */
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_SUICA) ||   /* RG STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.VD_SUICA) ||   /* VD STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.TR_SUICA) ||   /* TR STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.SR_SUICA));   /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_QP_Mode
  static Future<bool> rcCheckQPMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_QP) ||         /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_QP) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_QP) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_QP));         /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_QP) ||      /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_QP) || /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_QP) || /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_QP)); /* SR STL Mode ? 10.4LCD */
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_QP) ||   /* RG STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.VD_QP) || /* VD STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.TR_QP) || /* TR STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.SR_QP)); /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_iD_Mode
  static Future<bool> rcCheckiDMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_ID) ||         /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_ID) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_ID) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_ID));         /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_ID) ||      /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_ID) || /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_ID) || /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_ID)); /* SR STL Mode ? 10.4LCD */
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_ID) ||   /* RG STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.VD_ID) || /* VD STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.TR_ID) || /* TR STL Mode ?  5.7LCD */
              (cMem.stat.scrMode == RcRegs.SR_ID)); /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_PiTaPa_Mode
  static Future<bool> rcCheckPiTaPaMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_SINGLE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_PITAPA) || /* RG PiTaPa Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_PITAPA) || /* VD PiTaPa Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_PITAPA) || /* TR PiTaPa Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_PITAPA));
    /* SR PiTaPa Mode ? 10.4LCD */
    }
    return false;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// QUICPAY(ﾏﾙﾁ端末)決済の前に楽天ポイント通信を行うかチェック
  /// 関連tprxソース: rcfncchk.c - rcCheck_RPointPay_Before_MultiQP
  /// 引数：int uPts: 利用ポイント数
  /// 戻値： true:対象仕様, false:対象仕様ではない、未条件などで 行わない
  static bool rcCheckRPointPayBeforeMultiQP(int uPts) {
    return false;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// iD(ﾏﾙﾁ端末)決済の前に楽天ポイント通信を行うかチェック
  /// 関連tprxソース: rcfncchk.c - rcCheck_RPointPay_Before_MultiiD
  /// 引数：int uPts: 利用ポイント数
  /// 戻値： true:対象仕様, false:対象仕様ではない、未条件などで 行わない
  static bool rcCheckRPointPayBeforeMultiiD(int uPts) {
    return false;
  }

  /// 証書印字タイプをチェック
  /// 関連tprxソース: rcfncchk.c - rcfncchk_cert_print_chk
  /// 引数：int p
  /// 戻値： 0:印字しない、1:保証書印字、2:販売証明書印字
  static int rcfncchkCertPrintChk(int p) {
    int ret = 0;

    if (RegsMem().tItemLog[p].t10000Sts.certificateTyp == 1) {
      // 証書タイプ：保証書
      ret = 1;
    } else if (RegsMem().tItemLog[p].t10000Sts.certificateTyp == 2) {
      // 証書タイプ：販売証明書
      ret = 2;
    }
    return ret;
  }

  /// セルフ締めキー「*」の設定値を受け取って該当する会計、品券キーを返す
  /// 関連tprxソース: rcfncchk.c - rcChk_SelfKey_FncCd
  /// 引数：trm_value:ターミナルの設定値
  /// 戻値：fnc_code: 該当する会計、品券キー, 間違った設定値の場合は -1
  static int rcChkSelfKeyFncCd(int trmValue) {
    int fncCode = -1;
    int i;

    /* rxkind_cha_list[] = { 会計1~30, 品券1~5, -1 } */
    for (i = 0; Rxkoptcmncom.rxkindChaList[i] != -1; i++) {
      if (trmValue == i) {
        fncCode = Rxkoptcmncom.rxkindChaList[i];
        break;
      }
    }
    return fncCode;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_RfmMode
  static Future<bool> rcCheckRfmMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_RFM) ||
            (cMem.stat.scrMode == RcRegs.VD_RFM) ||
            (cMem.stat.scrMode == RcRegs.TR_RFM) ||
            (cMem.stat.scrMode == RcRegs.SR_RFM));
      case RcRegs.KY_SINGLE:
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_RFM) ||
              (cMem.stat.scrMode == RcRegs.VD_RFM) ||
              (cMem.stat.scrMode == RcRegs.TR_RFM) ||
              (cMem.stat.scrMode == RcRegs.SR_RFM));
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.subScrMode == RcRegs.RG_RFM) ||
              (cMem.stat.subScrMode == RcRegs.VD_RFM) ||
              (cMem.stat.subScrMode == RcRegs.TR_RFM) ||
              (cMem.stat.subScrMode == RcRegs.SR_RFM));
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Mbr_Input
  static bool rcCheckMbrInput() {
    return (RegsMem().tTtllog.t100700Sts.msMbrSys != 0);
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_ERef_Mode
  static Future<bool> rcCheckERefMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    ERef eRef = SystemFunc.readEref();

    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return( (cMem.stat.scrMode == RcRegs.RG_EREF ) ||         /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_EREF) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_EREF) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_EREF ) );         /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (eRef.nowDisplay == RcElog.EREF_LCDDISP) {
          return( (cMem.stat.scrMode == RcRegs.RG_EREF ) ||      /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_EREF ) ||      /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_EREF ) ||      /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_EREF ) );      /* SR STL Mode ? 10.4LCD */
        }
        else {
          return( (cMem.stat.subScrMode == RcRegs.RG_EREF ) ||    /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_EREF ) ||    /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_EREF ) ||    /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_EREF ) );    /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ERefR_Mode
  static Future<bool> rcCheckERefRMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    ERef eRef = SystemFunc.readEref();

    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return( (cMem.stat.scrMode == RcRegs.RG_EREFR ) ||         /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_EREFR ) ||         /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_EREFR ) ||         /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_EREFR ) );         /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (eRef.nowDisplay == RcElog.EREF_LCDDISP) {
          return( (cMem.stat.scrMode == RcRegs.RG_EREFR ) ||      /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_EREFR ) ||      /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_EREFR ) ||      /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_EREFR ) );      /* SR STL Mode ? 10.4LCD */
        }
        else {
          return( (cMem.stat.subScrMode == RcRegs.RG_EREFR ) ||    /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_EREFR ) ||    /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_EREFR ) ||    /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_EREFR ) );    /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ESVoid_Mode
  static Future<bool> rcCheckESVoidMode() async
  {
    AcMem cMem = SystemFunc.readAcMem();
    EsVoid esVoid = SystemFunc.readEsVoid();
    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return( ( cMem.stat.scrMode == RcRegs.RG_ESVOID ) ||         /* RG STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.VD_ESVOID ) ||         /* VD STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.TR_ESVOID ) ||         /* TR STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.SR_ESVOID )   );       /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (esVoid.nowDisplay == RcElog.ESVOID_LCDDISP) {
          return( ( cMem.stat.scrMode == RcRegs.RG_ESVOID ) ||       /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_ESVOID ) ||       /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_ESVOID ) ||       /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_ESVOID )   );     /* SR STL Mode ? 10.4LCD */
        }
        else {
          return( (cMem.stat.subScrMode == RcRegs.RG_ESVOID ) ||    /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_ESVOID ) ||    /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_ESVOID ) ||    /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_ESVOID )   );  /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ESVoidV_Mode()
  static Future<bool> rcCheckESVoidVMode() async
  {
    AcMem cMem = SystemFunc.readAcMem();
    EsVoid esVoid = SystemFunc.readEsVoid();
    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return( ( cMem.stat.scrMode == RcRegs.RG_ESVOIDV ) ||         /* RG STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.VD_ESVOIDV ) ||         /* VD STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.TR_ESVOIDV ) ||         /* TR STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.SR_ESVOIDV )   );       /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (esVoid.nowDisplay == RcElog.EREF_LCDDISP) {
          return( ( cMem.stat.scrMode == RcRegs.RG_ESVOIDV ) ||       /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_ESVOIDV ) ||       /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_ESVOIDV ) ||       /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_ESVOIDV )   );     /* SR STL Mode ? 10.4LCD */
        }
        else {
          return( (cMem.stat.subScrMode == RcRegs.RG_ESVOIDV ) ||    /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_ESVOIDV ) ||    /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_ESVOIDV ) ||    /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_ESVOIDV )   );  /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ESVoidC_Mode
  static Future<bool> rcCheckESVoidCMode() async
  {
    AcMem cMem = SystemFunc.readAcMem();
    EsVoid esVoid = SystemFunc.readEsVoid();
    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return( ( cMem.stat.scrMode == RcRegs.RG_ESVOIDC ) ||         /* RG STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.VD_ESVOIDC ) ||         /* VD STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.TR_ESVOIDC ) ||         /* TR STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.SR_ESVOIDC )   );       /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (esVoid.nowDisplay == RcElog.EREF_LCDDISP) {
          return( ( cMem.stat.scrMode == RcRegs.RG_ESVOIDC ) ||       /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_ESVOIDC ) ||       /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_ESVOIDC ) ||       /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_ESVOIDC )   );     /* SR STL Mode ? 10.4LCD */
        }
        else {
          return( (cMem.stat.subScrMode == RcRegs.RG_ESVOIDC ) ||    /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_ESVOIDC ) ||    /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_ESVOIDC ) ||    /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_ESVOIDC )   );  /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ERctfm_Mode
  static Future<bool> rcCheckERctfmMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    Erctfm erctfm = Erctfm();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_ERCTFM) || /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_ERCTFM) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_ERCTFM) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_ERCTFM)); /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (erctfm.nowDisplay == RcElog.ERCTFM_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_ERCTFM) || /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_ERCTFM) || /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_ERCTFM) || /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_ERCTFM)); /* SR STL Mode ? 10.4LCD */
        }
        else {
          return ((cMem.stat.subScrMode == RcRegs.RG_ERCTFM) || /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_ERCTFM) || /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_ERCTFM) || /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_ERCTFM)); /* SR STL Mode ?  5.7LCD */
        }
    }
    return (false);
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_ESVoidSD_Mode
  static Future<bool> rcCheckESVoidSDMode() async
  {
    AcMem cMem = SystemFunc.readAcMem();
    EsVoid esVoid = SystemFunc.readEsVoid();
    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return( ( cMem.stat.scrMode == RcRegs.RG_ESVOIDSD ) ||         /* RG STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.VD_ESVOIDSD ) ||         /* VD STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.TR_ESVOIDSD ) ||         /* TR STL Mode ? 10.4LCD */
            ( cMem.stat.scrMode == RcRegs.SR_ESVOIDSD )   );       /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (esVoid.nowDisplay == RcElog.EREF_LCDDISP) {
          return( ( cMem.stat.scrMode == RcRegs.RG_ESVOIDSD ) ||       /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_ESVOIDSD ) ||       /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_ESVOIDSD ) ||       /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_ESVOIDSD )   );     /* SR STL Mode ? 10.4LCD */
        }
        else {
          return( (cMem.stat.subScrMode == RcRegs.RG_ESVOIDSD ) ||    /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_ESVOIDSD ) ||    /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_ESVOIDSD ) ||    /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_ESVOIDSD )   );  /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  /// 画面がプリセットモードかチェックする
  /// 関連tprxソース: rcfncchk.c - rcSG_Check_Pre_Mode
  /// 戻値： true:対象画面, false:対象画面ではない
  static bool rcSGCheckPreMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SG_PRE)
        || (cMem.stat.scrMode == RcRegs.RG_SG_PRE));
  }

  /// 画面がメンテナンスモードかチェックする
  /// 関連tprxソース: rcfncchk.c - rcSG_Check_Mnt_Mode
  /// 戻値： true:対象画面, false:対象画面ではない
  static bool rcSGCheckMntMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SG_MNT)
        || (cMem.stat.scrMode == RcRegs.RG_SG_MNT));
  }

  /// 画面が会員スキャンモードかチェックする
  /// 関連tprxソース: rcfncchk.c - rcSG_Check_MbrScn_Mode
  /// 戻値： true:対象画面, false:対象画面ではない
  static bool rcSGCheckMbrScnMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SG_MBRSCN)
        || (cMem.stat.scrMode == RcRegs.TR_SG_MBRSCN));
  }

  /// 会員カードリード画面かチェックする
  /// 関連tprxソース: rcfncchk.c - rcCheck_QC_Mbr_N_ReadDsp_Mode
  /// 戻値： true:対象画面, false:対象画面ではない
  static bool rcCheckQCMbrNReadDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_MBR_N_READ)
        || (cMem.stat.scrMode == RcRegs.TR_QC_MBR_N_READ));
  }

  /// Verifoneでポストペイ決済の当日分通番訂正を許可するかチェックする
  /// 関連tprxソース: rcfncchk.c - rcfncchk_vesca_emoney_ref_system
  /// 戻値： true:許可する, false:許可しない
  static bool rcfncchkVescaEmoneyRefSystem() {
    /*  //tprx_v1 では無効
    if (RcSysChk.rcsyschkVescaSystem()) {
      if (RcSysChk.rcsyschkSm54FeelSystem()) {
        return true;
      }
    }
     */
    return false;
  }

  /// 画面が追加買上モードかチェックする
  /// 関連tprxソース: rcfncchk.c - rcCheck_BuyAdd_Mode
  /// 戻値： true:対象画面, false:対象画面ではない
  static Future<bool> rcCheckBuyAddMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return( (cMem.stat.scrMode == RcRegs.RG_BADD) ||         /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_BADD) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_BADD) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_BADD) );         /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (RcMbrBuyAdd.buyAdd.display == RcMbrBuyAdd.LCDISP1 ||
            RcMbrBuyAdd.buyAdd.display == RcMbrBuyAdd.LCDISP2 ||
            RcMbrBuyAdd.buyAdd.display == RcMbrBuyAdd.LCDISP3 ||
            RcMbrBuyAdd.buyAdd.display == RcMbrBuyAdd.LCDISP4) {
          return ( (cMem.stat.scrMode == RcRegs.RG_BADD) ||      /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_BADD) ||      /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_BADD) ||      /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_BADD) );      /* SR STL Mode ? 10.4LCD */
        } else {
          return ( (cMem.stat.subScrMode == RcRegs.RG_BADD) ||   /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_BADD) ||   /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_BADD) ||   /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_BADD) );   /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  /// dポイント修正画面かチェックする
  /// 関連tprxソース: rcfncchk.c - rcCheck_dPtsMdfy_Mode
  /// 戻値： true:対象画面, false:対象画面ではない
  static Future<bool> rcCheckDPtsMdfyMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return ((cMem.stat.scrMode == RcRegs.RG_DPTS_MODIFY_DSP)
            || (cMem.stat.scrMode == RcRegs.TR_DPTS_MODIFY_DSP));
    }
    return false;
  }

  /// 宅配発行キー画面モード小計画面チェック
  /// 関連tprxソース: rcfncchk.c - rcCheck_DelivSvcSdsp_Mode
  /// 戻値： 0:宅配発行キーの画面を表示していない　1:宅配発行キーの画面表示している
  static Future<bool> rcCheckDelivSvcSdspMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
      case RcRegs.KY_SINGLE :
        return((cMem.stat.scrMode == RcRegs.RG_DELIV_SVCS_DSP)	/* 登録 宅配発行キー小計画面か? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.VD_DELIV_SVCS_DSP)	/* 訂正 宅配発行キー小計画面か? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.TR_DELIV_SVCS_DSP)	/* 訓練 宅配発行キー小計画面か? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_DELIV_SVCS_DSP));	/* 廃棄 宅配発行キー小計画面か? 10.4LCD */
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Hc1_InOut_Mode
  static Future<bool> rcCheckHc1InOutMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.IN_STL) || /* IN STL Mode ? */
        (cMem.stat.scrMode == RcRegs.OU_STL) || /* OU STL Mode ? */
        (cMem.stat.scrMode == RcRegs.CL_EVOID)); /* CL VOID Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_VoidCom_MainDisp_Mode
  static Future<bool> rcCheckVoidComMainDispMode() async {
    return ((await rcCheckERefSMode()) ||
        (await rcCheckCrdtVoidSMode()) ||
        (await rcCheckPrecaVoidSMode()) ||
        (await rcCheckESVoidSMode()) ||
        (await rcCheckDelivSvcSdspMode()) ||
        ((await rcCheckHc1InOutMode()) &&
            (!await RcSysChk.rcCLOpeModeChk())));
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_VoidCom_SubDisp_Mode
  static Future<bool> rcCheckVoidComSubDispMode() async {
    return ((await rcCheckERefIMode()) ||
        (await rcCheckCrdtVoidIMode()) ||
        (await rcCheckPrecaVoidIMode()) ||
        (await rcCheckESVoidIMode()) ||
        (await rcCheckESVoidVMode()) ||
        (await rcCheckESVoidSDMode()) ||
        (await rcCheckESVoidCMode()) ||
        (await rcCheckERefRMode()));
  }

  /// QCashier ハウスプリカ残高照会画面が表示されているか判定する
  /// 戻値: true=表示中　 false=表示していない
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_EMny_PrecaDsp_Mode
  static bool rcQCCheckEMnyPrecaDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return( (cMem.stat.scrMode == RcRegs.RG_QC_EMNY_PRECA_DSP) || (cMem.stat.scrMode == RcRegs.TR_QC_EMNY_PRECA_DSP) );
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_EMny_SlctDsp_Mode
  static bool rcQCCheckEMnySlctDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_EMNY_SLCT) || (cMem.stat.scrMode == RcRegs.TR_QC_EMNY_SLCT));
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_VoidCom_Disp_Mode
  static Future<bool> rcCheckVoidComDispMode() async {
    return((await rcCheckVoidComMainDispMode()) || (await rcCheckVoidComSubDispMode()));
  }

  /// 釣銭額１万円以上でエラーとするかチェックする
  /// 関連tprxソース: rcfncchk.c - rcCheck_chg10000Flg
  /// 戻値: true:エラーとする false:エラーとしない
  static Future<bool> rcCheckChg10000Flg() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcCheckChg10000Flg() rxMemRead error\n");
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    switch (pCom.dbTrm.chgAmt10000Flg) { // 釣銭額１万円以上での締め操作
      case 1: // 禁止
        return true;
      case 2:
        if ((await RcSysChk.rcChkFselfMain())
            || (await RcSysChk.rcQCChkQcashierSystem())) {
          return false; // セルフの場合、有効
        } else {
          return true; // セルフ以外、禁止
        }
      case 0: // 有効
      default:
        return false;
    }
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_EMny_EdyDsp_Mode
  static bool rcQCCheckEMnyEdyDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_EMNY_EDY) || (cMem.stat.scrMode == RcRegs.TR_QC_EMNY_EDY));
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_EMny_EdyEnd_Mode
  static bool rcQCCheckEMnyEdyEndMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return( (cMem.stat.scrMode == RcRegs.RG_QC_EMNY_EDYEND) || (cMem.stat.scrMode == RcRegs.TR_QC_EMNY_EDYEND) );
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_EMny_Edy_Mode
  static bool rcQCCheckEMnyEdyMode() {
    return ((rcQCCheckEMnyEdyDspMode()) || (rcQCCheckEMnyEdyEndMode()));
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_SuicaTch_Mode
  static bool rcQCCheckSuicaTchMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return((cMem.stat.scrMode == RcRegs.RG_QC_SUICA_TCH)      /* RG QC Edy Use Mode ? */
        || (cMem.stat.scrMode == RcRegs.TR_QC_SUICA_TCH));    /* TR QC Edy Use Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_SuicaChk_Mode
  static bool rcQCCheckSuicaChkMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return((cMem.stat.scrMode == RcRegs.RG_QC_SUICA_CHK)      /* RG QC Edy Use Mode ? */
        || (cMem.stat.scrMode == RcRegs.TR_QC_SUICA_CHK));    /* TR QC Edy Use Mode ? */
  }

  /// 通番訂正の再売上中かをチェック
  /// 関連tprxソース: rcfncchk.c - rcCheck_rcptvoid_load_org_tran
  /// 戻値: true:通番訂正の再売上中 false:通番訂正の再売上中ではない
  static bool rcCheckRcptvoidLoadOrgTran() {
    if ((rcCheckRegistration()) && (RegsMem().tmpbuf.rcptvoidFlg != 0)) {
      return true;
    }
    return false;
  }

  static List<int> printErr = [DlgConfirmMsgKind.MSG_SETCASETTE.dlgId,
    DlgConfirmMsgKind.MSG_SETPAPER.dlgId,
    DlgConfirmMsgKind.MSG_CUTTERERR.dlgId,
    DlgConfirmMsgKind.MSG_CUTTERERR2.dlgId,
    DlgConfirmMsgKind.MSG_PRINTERERR.dlgId,
    DlgConfirmMsgKind.MSG_PAPEREND.dlgId,
    DlgConfirmMsgKind.MSG_PAPER_NEAREND.dlgId,
    0];

  /// rcChk_RPrinter(）にプリンタエラー追加変更の際に、print_err[]も更新して下さい
  /// 関連tprxソース: rcfncchk.c - rcChk_RPrinter
  static Future<int> rcChkRPrinter() async {
    int errNo = OK;
    int prtType = await CmCksys.cmPrinterType();

    if ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)
        || (await RcSysChk.rcCheckQCJCSystem())) {
      AcMem cMem = SystemFunc.readAcMem();
      if ((await RcIfPrint.rcPortGet()) & RcIf.XPRN_ERR != 0) {
        errNo = await RcIfPrint.rcStatusRead();
        if (errNo == InterfaceDefine.IF_TH_POK) {
          RcIfPrint.rcStatusGet();
        }
        else {
          cMem.stat.prnStatus = RcRegs.PRN_ERROR;
        }
        if (cMem.stat.prnStatus & InterfaceDefine.IF_TH_PRNERR_HOPN != 0) {
          errNo = DlgConfirmMsgKind.MSG_SETCASETTE.dlgId;
        } else if (cMem.stat.prnStatus & InterfaceDefine.IF_TH_PRNERR_PEND != 0) {
          errNo = DlgConfirmMsgKind.MSG_SETPAPER.dlgId;
        } else if (cMem.stat.prnStatus & InterfaceDefine.IF_TH_PRNERR_CUTERR != 0) {
          errNo = DlgConfirmMsgKind.MSG_CUTTERERR2.dlgId;
        } else if (cMem.stat.prnStatus & RcRegs.PRN_ERROR != 0) {
          errNo = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
        }
      } else {
        await RcIfEvent.rcRctNearEndProc();
        RegsMem mem = SystemFunc.readRegsMem();
        if ((prtType == CmSys.TPRTIM)
            && (await RcSysChk.rcChkReciptNearEnd() != 0)
            && ((mem.prnrBuf.type == PrnterControlTypeIdx.TYPE_RCPT.index)
                || (mem.prnrBuf.type == PrnterControlTypeIdx.TYPE_RPR.index)
                || (mem.prnrBuf.type == PrnterControlTypeIdx.TYPE_RFM1.index)
                || (mem.prnrBuf.type == PrnterControlTypeIdx.TYPE_RFM2.index))
            && !(await RcSysChk.rcSGChkSelfGateSystem())
            && !(await RcSysChk.rcQCChkQcashierSystem())
            && !RcSysChk.rcCheckCrdtStat()) {
          errNo = DlgConfirmMsgKind.MSG_PAPER_NEAREND.dlgId;
        }
      }
    }
    return errNo;
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_Crdt_Mode
  static bool rcQCCheckCrdtMode() {
    return ((rcQCCheckCrdtDspMode())
        || (rcQCCheckCrdtUseMode())
        || (rcQCCheckCrdtEndMode()));
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_CrdtDsp_Mode
  static bool rcQCCheckCrdtDspMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return (((cMem.stat.scrMode == RcRegs.RG_QC_CRDT))
        || ((cMem.stat.scrMode == RcRegs.TR_QC_CRDT)));
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_CrdtEnd_Mode
  static bool rcQCCheckCrdtEndMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return (((cMem.stat.scrMode == RcRegs.RG_QC_CRDTEND))
        || ((cMem.stat.scrMode == RcRegs.TR_QC_CRDTEND)));
  }

  // TODO:00014 日向 checker関数実装のため、定義のみ追加
  /// スプリットキーモードかチェック
  /// 戻り値: true=上記モード  false=上記モードでない
  /// 関連tprxソース: rcfncchk.c - rcCheck_SpritMode
  static bool rcCheckSpritMode(){
    /*
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SPRIT_DSP) ||
        (cMem.stat.scrMode == RcRegs.VD_SPRIT_DSP) ||
        (cMem.stat.scrMode == RcRegs.TR_SPRIT_DSP) ||
        (cMem.stat.scrMode == RcRegs.SR_SPRIT_DSP) ||
        (cMem.stat.scrMode == RcRegs.OD_SPRIT_DSP) ||
        (cMem.stat.scrMode == RcRegs.IV_SPRIT_DSP) ||
        (cMem.stat.scrMode == RcRegs.PD_SPRIT_DSP));
     */
    return false;
  }
  // TODO:00014 日向 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_CogcaPoint_Mode
  static bool rcQCCheckCogcaPointMode(){
    return false;
  }

  /// System Error Check
  /// Foramt : short rcChk_Fnc_Brch (void);
  /// Input  : void
  /// Output : short Error number
  /// 関連tprxソース: rcfncchk.c - rcChk_Fnc_Brch
  static Future<int> rcChkFncBrch() async {
    int errNo = 0;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    errNo = OK;

    if (!CompileFlag.CN && !CompileFlag.TW && !CompileFlag.EX) {
      if ((errNo == OK) && (cMem.stat.clkStatus != 0 & RcRegs.ERR_1TIME)) {
        errNo = rcChkUpdErr();
      }
    }

    if ((errNo == OK) && (cMem.stat.clkStatus != 0 & RcRegs.VDTR_CTRL)) {
      errNo = await rcChkModeCtrl();
    }

    if ((errNo == OK) && (cMem.stat.clkStatus != 0 & RcRegs.ERR_1TIME)) {
      if (cBuf.dbTrm.tranrceiptBarflgEqualJan != 0) {
        if (await RckySus.rcCheckSuspend() == 0) {
          errNo = rcChkSuspendStat();
        }

        if (errNo == OK) {
          errNo = await RcFncChk.rcChkRPrinter();
        }
      } else {
        errNo = await RcFncChk.rcChkRPrinter();
      }
    }
    if (errNo == OK && await rcChkDrw() != 0) {
      errNo = DlgConfirmMsgKind.MSG_DRAWER.dlgId;
    }
    if ((errNo == OK) &&
        (cMem.stat.msgDspStatus != 0 & RcRegs.MSDSP_CustTrmChg)) {
      errNo = await rcChkSrvNoChg();
      cMem.stat.msgDspStatus &= ~RcRegs.MSDSP_CustTrmChg; /* 登録開始時メッセージ表示OFF */
    }

    if (errNo == OK
        && (cMem.stat.tomoifLibCheck !=
            0 & RcRegs.FILCHECK_TomoLib_Reg) /* 各取引開始時 チェックON? */
        && await CmCksys.cmTomoIFSystem() != 0 /* 友の会仕様 */
        && RcSysChk.rcRGOpeModeChk()) {
      /* 登録モード */
      if ((await RcSysChk.rcChkFselfMain() && await RcSysChk.rcKySelf() ==
          RcRegs.KY_CHECKER) /* 対面セルフでチェッカー側（キャッシャー側でチェックする） */
//		||  (rcChk_Shop_and_Go_System() || rcQC_Chk_Qcashier_System() || rcSG_Chk_SelfGate_System())	/* Shop&Go/精算機/フルセルフ */
          || (rcQCCheckStaffDspMode() || rcQCCheckPassWardDspMode())) {
        /* 従業員/パスワード画面 */
        /* 何もしない */
      } else {
        /* チェック実行 */
        log = sprintf("rcChk_Fnc_Brch() AplLib_Chk_tomoIFLibFile:%i\n", [await AplLibOther.aplLibChkTomoIFLibFile()]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

        /* 通信用ライブラリのチェック */
        if (await AplLibOther.aplLibChkTomoIFLibFile() == 1) {
          /* テスト用ライブラリを利用中 */
          errNo = DlgConfirmMsgKind.MSG_TOMOIF_TESTMODE.dlgId; // 友の会通信は試験モードです
        }
        cMem.stat.tomoifLibCheck &=
        ~RcRegs.FILCHECK_TomoLib_Reg; /* 各取引開始時 チェックOFF */
      }
    }

    cMem.stat.clkStatus &= ~RcRegs.VDTR_CTRL; /* Error VD&TR Status OFF  */
    cMem.stat.clkStatus &= ~RcRegs.ERR_1TIME; /* Error 1Time Status OFF  */
    return errNo;
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_Upd_Err
  static int rcChkUpdErr() {
    return OK;
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_Upd_Err
  static Future<int> rcChkModeCtrl() async {
    int checkFlg = 0;
    checkFlg = 0;
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) {
      checkFlg = 1;
    } else {
      if (await RcSysChk.rcChkDesktopCashier()) {
        checkFlg = 1;
      }
    }

    /* プリペイド仕様の先入金取引の元取引の仮締呼出動作時には警告表示しない */
    if (await RcSysChk.rcChkPrecaTyp() != 0) {
      if(RegsMem().tmpbuf.autoCallReceiptNo != 0 && RegsMem().tmpbuf.autoCallMacNo != 0 && RegsMem().tTtllog.t100003.outMdlclsAmt != 0) {
        /* チャージ商品(額)が登録されていたら元取引の仮締呼出時の動作と判断する */
        checkFlg = 0;
      } else if (atSing.limitAmount != 0 && !await RcSysChk.rcQRChkPrintSystem()) {
        //先入金取引で通常レジの場合
        checkFlg = 0;
      }
    }

    /* 従業員精算処理中の連続処理の途中では警告表示しない */
    if (RcInOut.inOutClose.closePickFlg == 1) {
      checkFlg = 0;
    }

    if (checkFlg == 1) {
      if (RcSysChk.rcVDOpeModeChk() == true && cBuf.dbTrm.wrngMvoidFlg != 0) {
        return DlgConfirmMsgKind.MSG_VDMODE.dlgId;
      }

      if (RcSysChk.rcTROpeModeChk() == true && !rcSGCheckCheckMode() &&
          cBuf.dbTrm.wrngMtriningFlg != 0) {
        return DlgConfirmMsgKind.MSG_TRMODE.dlgId;
      }

      if ((RcSysChk.rcTROpeModeChk() == true) && !rcSGCheckCheckMode() && await RcSysChk.rcSGChkSelfGateSystem()) {
        return DlgConfirmMsgKind.MSG_TRMODE.dlgId;
      }

      if (cBuf.dbTrm.wrngMscrapFlg != 0) {
        if (RcSysChk.rcSROpeModeChk() == true) {
          return DlgConfirmMsgKind.MSG_SRMODE.dlgId;
        }

        if (RcSysChk.rcODOpeModeChk() == true) {
          return DlgConfirmMsgKind.MSG_ODMODE.dlgId;
        }

        if (RcSysChk.rcIVOpeModeChk() == true) {
          return DlgConfirmMsgKind.MSG_IVMODE.dlgId;
        }

        if (RcSysChk.rcPDOpeModeChk() == true) {
          return DlgConfirmMsgKind.MSG_PDMODE.dlgId;
        }
      }
    }
    return OK;
  }

  /// 関連tprxソース: rcfncchk.c - rcSG_Check_Check_Mode
  static bool rcSGCheckCheckMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return cMem.stat.scrMode == RcRegs.RG_SG_CHK || /* RG Check Mode ? */
        cMem.stat.scrMode == RcRegs.TR_SG_CHK; /* TR Check Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_Suspend_Stat
  static int rcChkSuspendStat() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.fncCode == FuncKey.KY_SUS.keyId) {
      return OK;
    } else {
      return DlgConfirmMsgKind.MSG_TEXT124.dlgId;
    }
  }

  /// Check Device
  /// 関連tprxソース: rcfncchk.c - rcChk_Drw
  static Future<int> rcChkDrw() async {
    int result = 0;
    result = OK;
//   if(rcKy_Self() != KY_CHECKER)
    if (await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER ||
        await RcSysChk.rcCheckQCJCSystem()) {
      if (await rcChkErrDrwOpen() == false) {
        result = OK;
      } else {
        result = NG;
      }
    }
    return result;
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_Err_Drw_Open
  static Future<bool> rcChkErrDrwOpen() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (RcSysChk.rcSROpeModeChk() || RcSysChk.rcODOpeModeChk() ||
        RcSysChk.rcIVOpeModeChk() || RcSysChk.rcPDOpeModeChk()) {
      return false;
    } else if (cMem.stat.fncCode == FuncKey.KY_OFF.keyId) {
      return rcChkErrDrwOpenOff() &&
          (await RcIfPrint.rcPortGet() & RcIf.XPRN_PE) != 0;
    } else {
      return rcChkErrDrwOpenReg() &&
          (await RcIfPrint.rcPortGet() & RcIf.XPRN_PE) != 0;
    }
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_Err_Drw_Open_Reg
  static bool rcChkErrDrwOpenReg() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return cBuf.dbTrm.drwOpenFlg == 0 || cBuf.dbTrm.drwOpenFlg == 2;
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_Err_Drw_Open_Off
  static bool rcChkErrDrwOpenOff() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return cBuf.dbTrm.drwOpenFlg == 2 || cBuf.dbTrm.drwOpenFlg == 3;
  }

  /// 顧客ターミナルのサービス期間番号が変更されたかチェックする
  /// 戻り値: OK=変更されていない  MSG_CUSTTRM_CHG=変更された
  /// 関連tprxソース: rcfncchk.c - rc_ChkSrvNoChg
  static Future<int> rcChkSrvNoChg() async {
    int nowSrvNo = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((await RcMbrCom.rcmbrChkStat() != 0 & RcMbr.RCMBR_STAT_FSP)
        && (cBuf.dbTrm.srvnoChgDsp == 1)) {
      nowSrvNo = RcMbrFlrd.rcRdcusttrmFLSmpluStldscTyp();
      if (cBuf.dbTrm.smpluStldscTyp != nowSrvNo) {
        return DlgConfirmMsgKind.MSG_CUSTTRM_CHG.dlgId;
      }
    }

    return OK;
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_StaffDsp_Mode
  static bool rcQCCheckStaffDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return cMem.stat.scrMode == RcRegs.RG_QC_STAFF || cMem.stat.scrMode == RcRegs.TR_QC_STAFF;
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_PassWardDsp_Mode
  static bool rcQCCheckPassWardDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return cMem.stat.scrMode == RcRegs.RG_QC_PASWD || cMem.stat.scrMode == RcRegs.TR_QC_PASWD;
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_CashInt
  static Future<bool> rcChkCashInt() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.cashintFlag != 0) || await RcSysChk.rcCheckQCJCSystem());
  }

  /// Check Have a Dual Half PopUp
  /// 関連tprxソース: rcfncchk.c - rcDualHalf_Condition
  static bool rcDualHalfCondition() {
    AcMem cMem = SystemFunc.readAcMem();
    return !RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]) &&
        !RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PRC.keyId]) &&
        !RcRegs.kyStC4(cMem.keyStat[FncCode.KY_FNAL.keyId]) &&
        !RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_CALC.keyId]);
  }

  /// Reset Key Status
  /// 関連tprxソース: rcfncchk.c - rcKy_Reset_Stat
  static List<int> rcKyResetStat(List<int> buf, int macro) {
    if (macro & RcRegs.MACRO0 != 0) {
      buf = RcFncChk.rcKyStL0(buf, RcFncChkDef.macro0List);
    }
    if (macro & RcRegs.MACRO1 != 0) {
      buf = RcFncChk.rcKyStL1(buf, RcFncChkDef.macro1List);
    }
    if (macro & RcRegs.MACRO2 != 0) {
      buf = RcFncChk.rcKyStL2(buf, RcFncChkDef.macro2List);
    }
    if (macro & RcRegs.MACRO3 != 0) {
      buf = RcFncChk.rcKyStL3(buf, RcFncChkDef.macro3List);
    }
    return buf;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_ManualMixMode
  static bool rcCheckManualMixMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_MANUALMM) ||
        (cMem.stat.scrMode == RcRegs.VD_MANUALMM) ||
        (cMem.stat.scrMode == RcRegs.TR_MANUALMM) ||
        (cMem.stat.scrMode == RcRegs.SR_MANUALMM));
  }

  /// 機能：言語切替の画面モードをチェックする
  /// 戻値：0:画面を表示していない　1:画面表示している
  /// 関連tprxソース: rcfncchk.c - rcCheck_LangChg_Dsp_Mode
  /// TODO:00015 江原 定義のみ先行追加
  static bool rcCheckLangChgDspMode() {
    return true;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_ChgLoan_Mode
  static Future<bool> rcCheckChgLoanMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
      case RcRegs.KY_SINGLE :
        return ((cMem.stat.scrMode == RcRegs.RG_CHGLOAN) || /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_CHGLOAN) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_CHGLOAN) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_CHGLOAN));
    /* SR STL Mode ? 10.4LCD */
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_ChgPtn_Coop_Mode
  static Future<bool> rcCheckChgPtnCoopMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
      case RcRegs.KY_SINGLE :
        return ((cMem.stat.scrMode == RcRegs.RG_CHGPTN_COOP_DSP) || /* RG CHGPTN Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_CHGPTN_COOP_DSP) || /* VD CHGPTN Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_CHGPTN_COOP_DSP) || /* TR CHGPTN Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_CHGPTN_COOP_DSP));
    /* SR CHGPTN Mode ? 10.4LCD */
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_BkScrReservMode
  static Future<bool> rcCheckBkScrReservMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.bkScrMode == RcRegs.RG_RESERV_DSP) ||
            (cMem.stat.bkScrMode == RcRegs.VD_RESERV_DSP) ||
            (cMem.stat.bkScrMode == RcRegs.TR_RESERV_DSP) ||
            (cMem.stat.bkScrMode == RcRegs.SR_RESERV_DSP));
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.bkScrMode == RcRegs.RG_RESERV_DSP) ||
              (cMem.stat.bkScrMode == RcRegs.VD_RESERV_DSP) ||
              (cMem.stat.bkScrMode == RcRegs.TR_RESERV_DSP) ||
              (cMem.stat.bkScrMode == RcRegs.SR_RESERV_DSP));
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.bkSubScrMode == RcRegs.RG_RESERV_DSP) ||
              (cMem.stat.bkSubScrMode == RcRegs.VD_RESERV_DSP) ||
              (cMem.stat.bkSubScrMode == RcRegs.TR_RESERV_DSP) ||
              (cMem.stat.bkSubScrMode == RcRegs.SR_RESERV_DSP));
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_fself_pay_mode
  static Future<bool> rcChkFselfPayMode() async {
    if (await RcSysChk.rcChkFselfMain()) {
      if (rcCheckChgCinMode()) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_BkAdvanceIn_Mode
  static Future<bool> rcCheckBkAdvanceInMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.bkScrMode == RcRegs.RG_ADVANCE_IN_DSP) ||
            (cMem.stat.bkScrMode == RcRegs.VD_ADVANCE_IN_DSP) ||
            (cMem.stat.bkScrMode == RcRegs.TR_ADVANCE_IN_DSP) ||
            (cMem.stat.bkScrMode == RcRegs.SR_ADVANCE_IN_DSP));
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.bkScrMode == RcRegs.RG_ADVANCE_IN_DSP) ||
              (cMem.stat.bkScrMode == RcRegs.VD_ADVANCE_IN_DSP) ||
              (cMem.stat.bkScrMode == RcRegs.TR_ADVANCE_IN_DSP) ||
              (cMem.stat.bkScrMode == RcRegs.SR_ADVANCE_IN_DSP));
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.bkSubScrMode == RcRegs.RG_ADVANCE_IN_DSP) ||
              (cMem.stat.bkSubScrMode == RcRegs.VD_ADVANCE_IN_DSP) ||
              (cMem.stat.bkSubScrMode == RcRegs.TR_ADVANCE_IN_DSP) ||
              (cMem.stat.bkSubScrMode == RcRegs.SR_ADVANCE_IN_DSP));
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_AdvanceIn_Mode
  static Future<bool> rcCheckAdvanceInMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_ADVANCE_IN_DSP) ||
            (cMem.stat.scrMode == RcRegs.VD_ADVANCE_IN_DSP) ||
            (cMem.stat.scrMode == RcRegs.TR_ADVANCE_IN_DSP) ||
            (cMem.stat.scrMode == RcRegs.SR_ADVANCE_IN_DSP));
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_ADVANCE_IN_DSP) ||
              (cMem.stat.scrMode == RcRegs.VD_ADVANCE_IN_DSP) ||
              (cMem.stat.scrMode == RcRegs.TR_ADVANCE_IN_DSP) ||
              (cMem.stat.scrMode == RcRegs.SR_ADVANCE_IN_DSP));
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.subScrMode == RcRegs.RG_ADVANCE_IN_DSP) ||
              (cMem.stat.subScrMode == RcRegs.VD_ADVANCE_IN_DSP) ||
              (cMem.stat.subScrMode == RcRegs.TR_ADVANCE_IN_DSP) ||
              (cMem.stat.subScrMode == RcRegs.SR_ADVANCE_IN_DSP));
        }
    }
    return false;
  }

  /// アプリ側ダイアログが表示されているかチェックする
  /// 戻り値: 0=未表示  1=表示中
  /// 関連tprxソース: rcfncchk.c - rcAplDlgCheck
  static int rcAplDlgCheck() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.apldlgPtn != 0) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rcfncchk.c - rcSQRC_Check_StaffDsp_Mode
  static bool rcSQRCCheckStaffDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SQRC_STAFF) ||
        (cMem.stat.scrMode == RcRegs.TR_SQRC_STAFF));
  }

  /// 関連tprxソース: rcfncchk.c - rcSQRC_Check_PassWordDsp_Mode
  static bool rcSQRCCheckPassWordDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SQRC_PASWD) ||
        (cMem.stat.scrMode == RcRegs.TR_SQRC_PASWD));
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_SpBarRead_Mode
  static Future<bool> rcCheckSpBarReadMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
      case RcRegs.KY_SINGLE :
        return ((cMem.stat.scrMode == RcRegs.RG_FRESTA_SPBAR_DSP) || /* 登録 特殊ﾊﾞｰｺｰﾄﾞ読取画面 */
            (cMem.stat.scrMode == RcRegs.TR_FRESTA_SPBAR_DSP));  /* 訓練 特殊ﾊﾞｰｺｰﾄﾞ読取画面 */
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_BkSpBarRead_Mode
  static Future<int> rcCheckBkSpBarReadMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
      case RcRegs.KY_SINGLE :
        if ((cMem.stat.bkScrMode == RcRegs.RG_FRESTA_SPBAR_DSP) || /* 登録 特殊ﾊﾞｰｺｰﾄﾞ読取画面 */
            (cMem.stat.bkScrMode == RcRegs.TR_FRESTA_SPBAR_DSP)) /* 訓練 特殊ﾊﾞｰｺｰﾄﾞ読取画面 */ {
          return 1;
        }
    }
    return 0;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Crdt_Mode
  static Future<bool> rcCheckCrdtMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_CRDT) || /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_CRDT) || /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_CRDT) || /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_CRDT));
    /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_CRDT) || /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_CRDT) || /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_CRDT) || /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_CRDT)); /* SR STL Mode ? 10.4LCD */
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.subScrMode == RcRegs.RG_CRDT) || /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_CRDT) || /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_CRDT) || /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_CRDT)); /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Barcode_Pay_QR_Mode
  static Future<bool> rcCheckBarcodePayQRMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_SINGLE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_BCDPAY_QR_DSP) || /* RG Barcode Pay QR Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_BCDPAY_QR_DSP) || /* VD Barcode Pay QR Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_BCDPAY_QR_DSP) || /* TR Barcode Pay QR Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_BCDPAY_QR_DSP));  /* SR Barcode Pay QR Mode ? 10.4LCD */
      default :
        break;
    }
    return false;
  }

  /// キャッシュリサイクルモードかチェック
  /// 戻り値: true=上記モード  false=上記モードでない
  /// 関連tprxソース: rcfncchk.c - rcCheck_CashRecycle_Mode
  static Future<bool> rcCheckCashRecycleMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
      case RcRegs.KY_SINGLE :
        return ((cMem.stat.scrMode == RcRegs.RG_CASHRECYCLE) ||
            (cMem.stat.scrMode == RcRegs.VD_CASHRECYCLE) ||
            (cMem.stat.scrMode == RcRegs.TR_CASHRECYCLE) ||
            (cMem.stat.scrMode == RcRegs.SR_CASHRECYCLE));
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_CPWR_Mode
  static Future<bool> rcCheckCPWRMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_CPWR) || /* RG CPWR Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_CPWR) || /* VD CPWR Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_CPWR) || /* TR CPWR Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_CPWR));
    /* SR CPWR Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE :
        if (Cpwr.now_display == CpwrDispData.CPWR_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_CPWR) || /* RG CPWR Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_CPWR) || /* VD CPWR Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_CPWR) || /* TR CPWR Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_CPWR)); /* SR CPWR Mode ? 10.4LCD */
        }
        else {
          return ((cMem.stat.subScrMode == RcRegs.RG_CPWR) || /* RG CPWR Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_CPWR) || /* VD CPWR Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_CPWR) || /* TR CPWR Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_CPWR)); /* SR CPWR Mode ?  5.7LCD */
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcChk_fself_otherpay_mode
  static Future<bool> rcChkFselfOtherpayMode() async {
    int modeChk = 0;

    if (await RcSysChk.rcChkFselfMain()) {
      if ((await rcCheckCrdtMode())
          || (await rcCheckQPMode())
          || (await rcCheckiDMode())
          || (await rcCheckPiTaPaMode())
          || (await rcCheckBarcodePayQRMode())
          || (await rcCheckSuicaMode())) {
        modeChk = 1;
      }

      if (modeChk == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_ChgInOut_Mode
  static Future<bool> rcCheckChgInOutMode() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return ((cMem.stat.scrMode == RcRegs.RG_CHGINOUT) ||  /* RG ChgInOut Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_CHGINOUT) ||  /* VD ChgInOut Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_CHGINOUT) ||  /* TR ChgInOut Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_CHGINOUT));  /* SR ChgInOut Mode ? 10.4LCD */
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_InOut_Mode
  static Future<bool> rcCheckInOutMode() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_INOUT) ||  /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_INOUT) ||  /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_INOUT) ||  /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_INOUT));  /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (Rcinoutdsp.inOut.nowDisplay == RcInOut.LDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_INOUT) ||  /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_INOUT) ||  /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_INOUT) ||  /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_INOUT));  /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_INOUT) || /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_INOUT) || /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_INOUT) || /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_INOUT) ); /* SR STL Mode ?  5.7LCD */
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_ChgRef_Mode
  static bool rcCheckChgRefMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_CREF) || /* RG ChgRef Mode ? */
        (cMem.stat.scrMode == RcRegs.VD_CREF) || /* VD ChgRef Mode ? */
        (cMem.stat.scrMode == RcRegs.TR_CREF) || /* TR ChgRef Mode ? */
        (cMem.stat.scrMode == RcRegs.SR_CREF)); /* SR ChgRef Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_AccountOffsetMode
  static Future<bool> rcCheckAccountOffsetMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return ((cMem.stat.scrMode == RcRegs.RG_ACCOUNT_OFFSET_DSP) ||
            (cMem.stat.scrMode == RcRegs.TR_ACCOUNT_OFFSET_DSP));
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Acb_StopDsp
  static Future<bool> rcCheckAcbStopDsp() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcCheckAcbStopDsp(): rxMemRead error");
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (!(await RcSysChk.rcChk2800System())) {
      /* Web2800 以下の機種はNG */
      // RM-3800 以外
      if (!pCom.vtclRm5900RegsOnFlg) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcCheck_Acb_StopDsp() not 2800 return");
        return false;
      }
    }
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      /* QCはNG  */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheck_Acb_StopDsp() Qcashier return");
      return false;
    }
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      /* セルフ系のレジはNG */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheck_Acb_StopDsp() Self return");
      return false;
    }
    if (AplLibAuto.strCls(await RcSysChk.getTid()) != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheck_Acb_StopDsp() Auto Store Close return");
      return false;
    }
    if ((pCom.dbTrm.disableUseAcxLess10000 != 0) && /*　釣銭機指定枚数停止仕様 */
        ((await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) ||
            (await RcSysChk.rcKySelf() == RcRegs.DESKTOPTYPE)) && /* １人制,卓上機 */
        (pCom.dbTrm.acsNDisp == 2)) {
      /* ニアエンド表示エラー仕様 */
      if ((pCom.dbTrm.frcClkFlg != 0) && /* 簡易従業員*/
          (pCom.dbTrm.autochkroffAftersendupdateTime > 0)) {
        /* 「実績上げ後、自動クローズ」が有効 (0=しない) */
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcCheck_Acb_StopDsp() trminal2 return");
        return false;
      } else {
        if (RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin != 0) {
          /* 入金確定 する */
          if (RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 3 ||
              RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 4) {
            if (!await rcChkCCINOperation()) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "rcCheck_Acb_StopDsp() staff return");
              return false;
            } else {
              return true;
            }
          } else {
            return true;
          }
        }
      }
    }
    return false;
  }

  /// todo 動作未確認
  /// 関連tprxソース: rcfncchk.c - rcCheck_ScanWtCheck
  static bool rcCheckScanWtCheck()
  {
    AcMem cMem = SystemFunc.readAcMem();
    return(RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_WTPRC.keyId]));
  }

  /// 処理概要：キャッシュリサイクル入出金バーコード読込画面モードをチェックする
  /// パラメータ：なし
  /// 戻り値：bool false:画面を表示していない
  ///       bool true:画面表示している
  /// 関連tprxソース: rcfncchk.c - rcCheck_CashRecycle_Read_Mode
  static bool rcCheckCashRecycleReadMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.stat.scrMode == RcRegs.RG_QC_CRINOUT_READ_DSP);
  }

  ///  関連tprxソース: rcfncchk.c - rcCheck_AutoChecker_Mode
  static bool rcCheckAutoCheckerMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_AUTO) ||
        (cMem.stat.scrMode == RcRegs.VD_AUTO) ||
        (cMem.stat.scrMode == RcRegs.TR_AUTO) ||
        (cMem.stat.scrMode == RcRegs.SR_AUTO) ||
        (cMem.stat.scrMode == RcRegs.OD_AUTO) ||
        (cMem.stat.scrMode == RcRegs.IV_AUTO) ||
        (cMem.stat.scrMode == RcRegs.PD_AUTO));
  }
  
  ///  関連tprxソース: rcfncchk.c - rcCheck_Acb_StopDspMode
  static Future<bool> rcCheckAcbStopDspMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return (cMem.stat.scrMode == RcRegs.RG_ACB_STOP_DSP) ||
            (cMem.stat.scrMode == RcRegs.VD_ACB_STOP_DSP) ||
            (cMem.stat.scrMode == RcRegs.TR_ACB_STOP_DSP) ||
            (cMem.stat.scrMode == RcRegs.SR_ACB_STOP_DSP);
    }
    return (false);
  }

  /// 会員スキャン画面かチェックする
  /// 戻り値: true=当該画面  false=当該画面でない
  ///  関連tprxソース: rcfncchk.c - rcCheck_Acb_StopDspMode
  static bool rcCheckScnMbrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.stat.scrMode == RcRegs.RG_SCNMBR) ||
          (cMem.stat.scrMode == RcRegs.VD_SCNMBR) ||
          (cMem.stat.scrMode == RcRegs.TR_SCNMBR) ||
          (cMem.stat.scrMode == RcRegs.SR_SCNMBR);
  }

  /// スキャン中かチェックする
  /// 戻り値: true=スキャン中  false=スキャン中でない
  /// 関連tprxソース: rcfncchk.c - rcCheck_ScanCheck
  static bool rcCheckScanCheck() {
    AcMem cMem = SystemFunc.readAcMem();

    return RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PRC.keyId]);
  }

  /// 現在入力されたキー以外に登録中ステータスになっている物があるかチェック
  /// 戻り値: 0=登録なし  0以外=登録中
  /// 関連tprxソース: rcfncchk.c - rcCheck_OtherRegistration
  static Future<int> rcCheckOtherRegistration() async {
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if ((await CmCksys.cmDs2GodaiSystem() != 0)    /* ゴダイ様特注 */
        && (mem.tTtllog.t100002.quotationFlg != 0)    /* 見積宣言中 */
        && (cMem.stat.fncCode != FuncKey.KY_QUOTATION.keyId))    /* 見積宣言 */
    {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_QUOTATION");
      return FuncKey.KY_QUOTATION.keyId;
    }
    if ((mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index)    /* 会員売価中 */
        && (cMem.stat.fncCode != FuncKey.KY_MPRC.keyId))    /* 会員売価 */
    {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_MPRC");
      return FuncKey.KY_MPRC.keyId;
    }
    if ((mem.tTtllog.t100700.mbrInput != 0)    /* 会員呼出中 */
        && (cMem.stat.fncCode != FuncKey.KY_MBRCLR.keyId))    /* 会員取消 */
    {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_MBR");
      return FuncKey.KY_MBR.keyId;
    }
    if ((mem.tTtllog.t109000Sts.taxfreeFlg != 0)    /* 免税宣言中 */
       && (cMem.stat.fncCode != FuncKey.KY_TAXFREE_IN.keyId))    /* 免税宣言 */
    {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_TAXFREE_IN");
      return FuncKey.KY_TAXFREE_IN.keyId;
    }
    if ((mem.tTtllog.t100700Sts.outsideRbt != 0)    /* 割戻対象外中 */	// rcCheck_DeclarationStatusから吸収
        && (cMem.stat.fncCode != FuncKey.KY_OUTRBT.keyId))    /* 割戻対象外 */
    {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_OUTRBT");
      return FuncKey.KY_OUTRBT.keyId;
    }
    if ((mem.tTtllog.t100002Sts.revenueExclusionflg != 0)    /* 印紙除外中 */	// rcCheck_DeclarationStatusから吸収
        && (cMem.stat.fncCode != FuncKey.KY_REVENUE.keyId))    /* 印紙除外 */
    {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_REVENUE");
      return FuncKey.KY_REVENUE.keyId;
    }
    if ((await CmCksys.cmWsSystem() != 0)    /* WS様特注 */
      && mem.tTtllog.t100014.agencyCd.isNotEmpty    /* 代理店選択中 */
      && (cMem.stat.fncCode != FuncKey.KY_AGENCY.keyId))    /* 代理店 */
    {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_AGENCY");
      return FuncKey.KY_AGENCY.keyId;
    }
    if (RcSysChk.rcChkdPointRead() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_DPOINT_MINPUT");
      return FuncKey.KY_DPOINT_MINPUT.keyId;
    }
    if ((RcSysChk.rcsyschkRpointSystem() != 0)
        && Rxmbrcom.rxmbrcomChkRpointRead(mem)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_RPOINT_MINPUT");
      return FuncKey.KY_RPOINT_MINPUT.keyId;    // 楽天ﾎﾟｲﾝﾄ手入力
    }
    if (RcSysChk.rcsyschkTomoIFSystem() && (Rxmbrcom.rxmbrcomChkTomoRead(mem))) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCheckOtherRegistration(): KY_TOMOCARD_READ");
      return FuncKey.KY_TOMOCARD_READ.keyId;    // 友の会カード読込
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCheckOtherRegistration(): ITEM COUNT[${mem.tTtllog.t100001Sts.itemlogCnt}]");
    return mem.tTtllog.t100001Sts.itemlogCnt;    /* 登録中商品数 */
  }

  /// 売価変更を値引き扱いにするかチェック
  /// 戻り値: true=値引扱いする  false=値引扱いしない
  /// 関連tprxソース: rcfncchk.c - rcCheckPriceChangeDisc
  static bool rcCheckPriceChangeDisc() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((cBuf.dbTrm.uPrcchgDscFlg == 1) || (cBuf.dbTrm.uPrcchgDscFlg == 2)) {
      return true;
    }
    return false;
  }

  /// 購買履歴画面モードかチェックする
  /// 戻り値: true=上記モード  false=上記モードでない
  /// 関連tprxソース: rcfncchk.c - rcCheck_BuyHistMode
  static Future<bool> rcCheckBuyHistMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return ((cMem.stat.scrMode ==
            RcRegs.RG_BUYHIST_DSP) /* RG 購買履歴画面 Mode ? 10.4LCD */
            || (cMem.stat.scrMode ==
                RcRegs.VD_BUYHIST_DSP) /* VD 購買履歴画面 Mode ? 10.4LCD */
            || (cMem.stat.scrMode ==
                RcRegs.TR_BUYHIST_DSP) /* TR 購買履歴画面 Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_BUYHIST_DSP));
    /* SR 購買履歴画面 Mode ? 10.4LCD */
      default:
        break;
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcSG_Check_End_Mode_Chk
  static bool rcSGCheckEndModeChk() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_SG_END) ||      /* RG End Mode ? */
        (cMem.stat.scrMode == RcRegs.TR_SG_END));      /* TR End Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcSG_Check_Slct_Mode
  static bool rcSGCheckSlctMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_SG_SLCT) ||      /* RG SG Select Mode ? */
        (cMem.stat.scrMode == RcRegs.TR_SG_SLCT));      /* TR SG Select Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcSG_Check_CrdtRead_Mode
  static bool rcSGCheckCrdtReadMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_SG_CRDTRD) ||     /* RG SG Crdt Scan Mode ? */
        (cMem.stat.scrMode == RcRegs.TR_SG_CRDTRD));     /* TR SG Crdt Scany Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcSG_Check_Inst_Mode
  static bool rcSGCheckInstMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_SG_INST) ||     /* RG Instruction Mode ? */
        (cMem.stat.scrMode == RcRegs.TR_SG_INST));     /* TR Instruction Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcNewSG_Check_Explain_Mode
  static bool rcNewSGCheckExplainMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_NEWSG_EXP) ||       /* RG Explain Mode ? */
        (cMem.stat.scrMode == RcRegs.TR_NEWSG_EXP));       /* TR Explain Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcSG_Check_Str_Mode
  static bool rcSGCheckStrMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_SG_STR) ||      /* RG Starting Mode ? */
        (cMem.stat.scrMode == RcRegs.TR_SG_STR));      /* TR Starting Mode ? */
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_SlctDsp_Mode
  static bool rcQCCheckSlctDspMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_QC_SLCT) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_SLCT));
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_CashDsp_Mode
  static bool rcQCCheckCashDspMode() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.stat.scrMode == RcRegs.RG_QC_CASH) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_CASH));
  }

  /// AcMemクラスに格納するエラー状態が「正常終了」かチェックする
  /// 戻り値: true=正常終了  false=エラー終了
  /// 関連tprxソース: rcfncchk.c - rcChk_Err_Non
  static bool rcChkErrNon() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.ent.errStat == 0);
  }

  /// 関連tprxソース: rcfncchk.c - rcfncchk_sag_sm5_itoku_Rpoint_check
  static Future <int> rcfncchkSagSm5ItokuRpointCheck() async {
    int result = 0;

    result = 0;
    if (RcSysChk.rcsyschk2800VFHDSystem() != 0) {
      // 縦型のみ
      if (await RcSysChk.rcChkShopAndGoSystem() &&
          RcSysChk.rcsyschkRpointSystem() != 0 &&
          RcSysChk.rcsyschkSm5ItokuSystem() != 0 &&
          (RcQcDsp.qCashierIni.shop_and_go_mbr_card_dsp == 2)) {
        result = 1;
      }
    }

    return result;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Sapporo_Pana_Mode
  static Future<bool> rcCheckSapporoPanaMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return (cMem.stat.scrMode == RcRegs.RG_SPD) || /* RG SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_SPD) || /* VD SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_SPD) || /* TR SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_SPD); /* SR SPD Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return (cMem.stat.scrMode == RcRegs.RG_SPD) || /* RG SPD Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_SPD) || /* VD SPD Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_SPD) || /* TR SPD Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_SPD); /* SR SPD Mode ? 10.4LCD */
        } else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return (cMem.stat.subScrMode == RcRegs.RG_SPD) || /* RG SPD Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_SPD) || /* VD SPD Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_SPD) || /* TR SPD Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_SPD); /* SR SPD Mode ?  5.7LCD */
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_TrDate_Mode
  static Future<bool> rcCheckTrDateMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return (cMem.stat.scrMode == RcRegs.RG_TRANING_DATE_DSP) ||
            (cMem.stat.scrMode == RcRegs.VD_TRANING_DATE_DSP) ||
            (cMem.stat.scrMode == RcRegs.TR_TRANING_DATE_DSP) ||
            (cMem.stat.scrMode == RcRegs.SR_TRANING_DATE_DSP);
      case RcRegs.KY_SINGLE:
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return (cMem.stat.scrMode == RcRegs.RG_TRANING_DATE_DSP) ||
              (cMem.stat.scrMode == RcRegs.VD_TRANING_DATE_DSP) ||
              (cMem.stat.scrMode == RcRegs.TR_TRANING_DATE_DSP) ||
              (cMem.stat.scrMode == RcRegs.SR_TRANING_DATE_DSP);
        } else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return (cMem.stat.subScrMode == RcRegs.RG_TRANING_DATE_DSP) ||
              (cMem.stat.subScrMode == RcRegs.VD_TRANING_DATE_DSP) ||
              (cMem.stat.subScrMode == RcRegs.TR_TRANING_DATE_DSP) ||
              (cMem.stat.subScrMode == RcRegs.SR_TRANING_DATE_DSP);
        }
    }
    return false;
  }

  /// HappySelfの対面仕様時に支払い選択画面を表示するかチェックする
  /// 戻り値: 0=表示しない  1=表示する
  /// 関連tprxソース: rcfncchk.c - rcsyschk_happysmile_tran_select_system
  static Future<int> rcsyschkHappysmileTranSelectSystem() async {
    if (await RcSysChk.rcSysChkHappySmile()) {
      if (RcCrdtFnc.payPrice() < 0) {
        return 0;
      }

      if (rcfncchkCctChargeSystem()) {
        // チャージ商品登録中<Verifone>
        return 0;
      }
    }
    return 1;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Ht2980_Mode
  static Future<bool> rcCheckHt2980Mode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return (cMem.stat.scrMode == RcRegs.RG_HT) || /* RG SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_HT) || /* VD SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_HT) || /* TR SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_HT); /* SR SPD Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        return (cMem.stat.scrMode == RcRegs.RG_HT) || /* RG SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_HT) || /* VD SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_HT) || /* TR SPD Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_HT); /* SR SPD Mode ? 10.4LCD */
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_PMov_Mode
  static Future<bool> rcCheckPMovMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return (cMem.stat.scrMode == RcRegs.RG_POINTMOV) || /* RG Point Move Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_POINTMOV) || /* VD Point Move Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_POINTMOV) || /* TR Point Move Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_POINTMOV); /* SR Point Move Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return (cMem.stat.scrMode == RcRegs.RG_POINTMOV) || /* RG Point Move Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_POINTMOV) || /* VD Point Move Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_POINTMOV) || /* TR Point Move Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_POINTMOV); /* SR Point Move Mode ? 10.4LCD */
        } else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return (cMem.stat.subScrMode == RcRegs.RG_POINTMOV) ||
              (cMem.stat.subScrMode == RcRegs.VD_POINTMOV) ||
              (cMem.stat.subScrMode == RcRegs.TR_POINTMOV) ||
              (cMem.stat.subScrMode == RcRegs.SR_POINTMOV);
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_PbchgMode
  static Future<bool> rcCheckPbchgMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return (cMem.stat.scrMode == RcRegs.RG_PBCHG_DSP) ||
            (cMem.stat.scrMode == RcRegs.VD_PBCHG_DSP) ||
            (cMem.stat.scrMode == RcRegs.TR_PBCHG_DSP) ||
            (cMem.stat.scrMode == RcRegs.SR_PBCHG_DSP);
    }
    return false;
  }

  // 関連tprxソース: rcfncchk.c - rcQC_Check_CallDsp_Mode
  static bool rcQCCheckCallDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_CALL) ||
            (cMem.stat.scrMode == RcRegs.TR_QC_CALL));
  }

  // TODO:中身未実装
  // 関連tprxソース: rcfncchk.c - rcCheck_SPVT_Mode
  static bool rcCheck_SPVT_Mode() {
    return false;
  }

  static bool rcCheck_SPVT_VoidMode() {
    return false;
  }

  /// 特定DS2仕様向け 会員番号入力モードかチェック
  /// 戻り値: true=上記モード  false=上記モードでない
  /// 関連tprxソース: rcfncchk.c - rcCheck_MemberCardMode
  static bool rcCheckMemberCardMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_MCARD_DSP) ||
        (cMem.stat.scrMode == RcRegs.VD_MCARD_DSP) ||
        (cMem.stat.scrMode == RcRegs.TR_MCARD_DSP) ||
        (cMem.stat.scrMode == RcRegs.SR_MCARD_DSP));
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_Coin_NonAcr
  static Future<bool> rcQCCheckCoinNonAcr() async {
    if (CompileFlag.SELF_GATE) {
      return ((await RcSysChk.rcSGChkSelfGateSystem()) &&
          (RcSgCom.rcNewSGChkNonAcr())) ||
          ((await RcSysChk.rcQCChkQcashierSystem()) && (rcQCCoinNoCheck()));
    } else {
      return ((await RcSysChk.rcQCChkQcashierSystem()) && (rcQCCoinNoCheck()));
    }
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Coin_NoCheck
  static bool rcQCCoinNoCheck() {
    return ((rcQCCheckEdyMode()) || (rcQCCheckCrdtMode()));
  }

  // TODO:10158 商品券支払い 定義のみ追加
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_Edy_Mode
  static bool rcQCCheckEdyMode() {
    return false;
  }

  /// 現在入力されたキー以外に登録中ステータスになっている物があるかチェック
  /// 戻り値: true=登録中  false=登録なし
  /// 関連tprxソース: rcfncchk.c - rcCheck_ChgItmMode
  static Future<bool> rcCheckChgItmMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_CHGITM) ||
            (cMem.stat.scrMode == RcRegs.VD_CHGITM) ||
            (cMem.stat.scrMode == RcRegs.TR_CHGITM) ||
            (cMem.stat.scrMode == RcRegs.SR_CHGITM));
      case RcRegs.KY_SINGLE :
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_CHGITM) ||
              (cMem.stat.scrMode == RcRegs.VD_CHGITM) ||
              (cMem.stat.scrMode == RcRegs.TR_CHGITM) ||
              (cMem.stat.scrMode == RcRegs.SR_CHGITM));
        } else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.subScrMode == RcRegs.RG_CHGITM) ||
              (cMem.stat.subScrMode == RcRegs.VD_CHGITM) ||
              (cMem.stat.subScrMode == RcRegs.TR_CHGITM) ||
              (cMem.stat.subScrMode == RcRegs.SR_CHGITM));
        }
    }
    return false;
  }

  /// 指定変更画面モードのチェック
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcCheck_ChgSelectItemsMode
  static Future<bool> rcCheckChgSelectItemsMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE :
        return ((cMem.stat.scrMode == RcRegs.RG_CHGSELECTITEMS) ||
            (cMem.stat.scrMode == RcRegs.VD_CHGSELECTITEMS) ||
            (cMem.stat.scrMode == RcRegs.TR_CHGSELECTITEMS) ||
            (cMem.stat.scrMode == RcRegs.SR_CHGSELECTITEMS));
      default:
        break;
    }
    return false;
  }

  /// QCashier ハウスプリカ残高照会終了画面が表示されているかチェックする
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_EMny_PrecaEnd_Mode
  static bool rcQCCheckEMnyPrecaEndMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_EMNY_PRECAEND_DSP) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_EMNY_PRECAEND_DSP));
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_SusDsp_OverFlow_Type
  static bool rcQCCheckSusDspOverFlowType() {
    return (RcQcDsp.qcSusdspOverflowScreen == 1);
  }

  /// 精算機会員カード読取仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcfncchk.c - rcfncchk_Qcashier_Member_Read_System
  static Future<bool> rcChkQcashierMemberReadSystem() async {
    if (await RcMbrrealsvrFresta.rcChkQCashierRPointMbrRead()) {
      return true;
    }
    return false;
  }

  /// 精算機での会員カード読取画面かチェックする
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcfncchk_Check_Qcashier_Member_Read_Entry_Mode
  static Future<bool> rcChkQcashierMemberReadEntryMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        if ((cMem.stat.scrMode == RcRegs.RG_QCASHIER_MEMBER_READ_ENTRY_DSP) ||
            (cMem.stat.scrMode == RcRegs.TR_QCASHIER_MEMBER_READ_ENTRY_DSP)) {
          return true;
        }
        break;
      default:
        break;
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_TcktIssu_Mode
  static Future<bool> rcCheckTcktIssuMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_TKISSU) ||      /* RG STL Mode ? 10.4LCD */
                (cMem.stat.scrMode == RcRegs.VD_TKISSU) ||      /* VD STL Mode ? 10.4LCD */
                (cMem.stat.scrMode == RcRegs.TR_TKISSU) ||      /* TR STL Mode ? 10.4LCD */
                (cMem.stat.scrMode == RcRegs.SR_TKISSU));      /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if ((RcMbrKyTcktMain.tkIssu.display == RcMbrKyTcktMain.LCDCUSTINP) ||
            (RcMbrKyTcktMain.tkIssu.display == RcMbrKyTcktMain.LCDTKISSSU)) {
          return ((cMem.stat.scrMode == RcRegs.RG_TKISSU) ||    /* RG STL Mode ? 10.4LCD */
                  (cMem.stat.scrMode == RcRegs.VD_TKISSU) ||    /* VD STL Mode ? 10.4LCD */
                  (cMem.stat.scrMode == RcRegs.TR_TKISSU) ||    /* TR STL Mode ? 10.4LCD */
                  (cMem.stat.scrMode == RcRegs.SR_TKISSU));    /* SR STL Mode ? 10.4LCD */
        } else {
          return ((cMem.stat.subScrMode == RcRegs.RG_TKISSU) || /* RG STL Mode ?  5.7LCD */
                  (cMem.stat.subScrMode == RcRegs.VD_TKISSU) || /* VD STL Mode ?  5.7LCD */
                  (cMem.stat.subScrMode == RcRegs.TR_TKISSU) || /* TR STL Mode ?  5.7LCD */
                  (cMem.stat.subScrMode == RcRegs.SR_TKISSU) ); /* SR STL Mode ?  5.7LCD */
        }
      default:
        break;
    }

    return false;
  }

  /// ポイント書込済を残す仕様かチェック
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcfncchk.c - rcChk_SpzRwcWritePnt
  static Future<bool> rcChkSpzRwcWritePnt() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if (RcSysChk.rcChkRewriteCheckerCnct()
        && (await CmCksys.cmReceiptQrSystem() != 0)
        && (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index) ) {
      if (await RcSysChk.rcCheckSpeezaRewriteCnct() == 5) {
        // Pana Code
        return true;
      }
    }
    return false;
  }

  /// 既にカードに書込済みかチェックする
  /// 戻り値: true=書込済  false=未書込
  /// 関連tprxソース: rcfncchk.c - rcChk_SpzRwcAlreadyWrite
  static Future<bool> rcChkSpzRwcAlreadyWrite() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if ((await rcChkSpzRwcWritePnt())
        && (mem.tTtllog.t100700Sts.spzRwcWritePnt != 0)) {
      return true;
    }
    return false;
  }

  /// プリカ訂正画面モードであるかチェックする
  /// 戻り値: true=上記モード  false=上記モードでない
  /// 関連tprxソース: rcfncchk.c - rcCheck_PrecaVoid_Mode
  static Future<bool> rcCheckPrecaVoidMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_PRECAVOID) ||  /* RG STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_PRECAVOID) ||      /* VD STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_PRECAVOID) ||      /* TR STL Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_PRECAVOID) );      /* SR STL Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (RcKyPrecaVoid.precaVoid.nowDisplay == RcElog.PRECAVOID_LCDDISP) {
          return ((cMem.stat.scrMode == RcRegs.RG_PRECAVOID) ||  /* RG STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_PRECAVOID) ||      /* VD STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_PRECAVOID) ||      /* TR STL Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_PRECAVOID) );      /* SR STL Mode ? 10.4LCD */
        }
        else {
          return ((cMem.stat.subScrMode == RcRegs.RG_PRECAVOID) ||  /* RG STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.VD_PRECAVOID) ||      /* VD STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.TR_PRECAVOID) ||      /* TR STL Mode ?  5.7LCD */
              (cMem.stat.subScrMode == RcRegs.SR_PRECAVOID) );      /* SR STL Mode ?  5.7LCD */
        }
      default:
        break;
    }
    return false;
  }

  /// QCでの会員カード読込画面の画面モードをチェックする
  /// (VEGACoGCa、VEGA磁気、CoGCaIC共用)
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_AnyCustCard_Read_Dsp_Mode
  static bool rcQCCheckAnyCustCardReadDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_ANYCUST_CARDREAD_DSP) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_ANYCUST_CARDREAD_DSP));
  }

  /// [プリペイド仕様 フルセルフ] 他社プリペイドカードが読まれたメッセージを表示中かチェック
  /// 戻り値: true=表示中  false=非表示
  /// 関連tprxソース: rcfncchk.c - rcSG_Check_Preca_NonMbrcard_Mode
  static bool rcSGCheckPrecaNonMbrcardMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SG_PRECA_NONMBR) ||
        (cMem.stat.scrMode == RcRegs.TR_SG_PRECA_NONMBR) );
  }

  /// QCashierプリペイド支払画面が表示されているかチェックする
  /// 戻り値: true=表示中  false=非表示
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_PrePaid_PayDsp_Mode
  static bool rcQCCheckPrePaidPayDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_PREPAID_PAY) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_PREPAID_PAY));
  }

  /// QCashierプリペイド置数支払画面が表示されているかチェックする
  /// 戻り値: true=表示中  false=非表示
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_PrePaid_EntryDsp_Mode
  static bool rcQCCheckPrePaidEntryDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_PREPAID_ENTRY) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_PREPAID_ENTRY));
  }

  /// QCashierプリペイド残高不足確認画面が表示されているかチェックする
  /// 戻り値: true=表示中  false=非表示
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_PrePaid_BalanceShort_Mode
  static bool rcQCCheckPrePaidBalanceShortMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_PREPAID_BALANCESHORT) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_PREPAID_BALANCESHORT));
  }

  /// チャージ商品の選択画面モードをチェックする
  /// 戻り値: true=上記モード  false=上記モードでない
  /// 関連tprxソース: rcfncchk.c - rcfncchk_qc_charge_item_select_scrmode
  static bool rcQCCheckChargeItemSelectScrMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_CHARGE_ITEM_SLECT_DSP) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_CHARGE_ITEM_SLECT_DSP));
  }

  /// QCashierプリペイドカード読取画面が表示されているかチェックする
  /// 戻り値: true=表示中  false=非表示
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_PrePaid_ReadDsp_Mode
  static bool rcQCCheckPrePaidReadDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_PREPAID_READ) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_PREPAID_READ));
  }

  /// プリカポイント読込画面が表示されているかチェックする
  /// 戻り値: true=表示中  false=非表示
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_RepicaPnt_ReadDsp_Mode
  static bool rcQCCheckRepicaPntReadDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_REPICAPNT_READ) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_REPICAPNT_READ));
  }

  /// [後会員仕様] 会員画面が表示されているかチェックする
  /// 戻り値: true=表示中  false=非表示
  /// 関連tprxソース: rcfncchk.c - rcCheck_ArcsMbrDsp_Mode
  static Future<bool> rcCheckArcsMbrDspMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return ((cMem.stat.scrMode == RcRegs.RG_QC_ARCS_MBRDSP) || (cMem.stat.scrMode == RcRegs.TR_QC_ARCS_MBRDSP));
      default:
        return false;
    }
  }

  /// アヤハディオ様向け会員区分を取得する
  /// 引数: サービス分類
  /// 戻り値: 会員区分（アヤハディオ様オリジナルの仕様）
  /// 関連tprxソース: rcfncchk.c - rcfncchk_ayaha_mbr_divi_get
  static int rcGetAyahaMbrDivi(int svsClsCd) {
    int mbrDivi = 0;
    if (RcSysChk.rcsyschkAyahaSystem()) {
      if (svsClsCd > 0) {
        mbrDivi = (svsClsCd / 100000).floor();
      }
    }
    return mbrDivi;
  }

  /// RARAスマホ対応 スマホ読込画面が表示されているかチェックする（12verから移植）
  /// 引数: サービス分類
  /// 戻り値: true=表示  false=非表示
  /// 関連tprxソース: rcfncchk.c - rcCheck_RARA_MbrRead_Mode
  static Future<bool> rcCheckRARAMbrReadMode() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_SINGLE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_RARA_MBRREAD_DSP) ||	/* RG Cat MbrRead Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_RARA_MBRREAD_DSP) ||	/* VD Cat MbrRead Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_RARA_MBRREAD_DSP) ||	/* TR Cat MbrRead Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_RARA_MBRREAD_DSP) );	/* SR Cat MbrRead Mode ? 10.4LCD */
      default:
        break;
    }
    return false;
  }

  /// 支払選択画面支払選択時 後会員仕様（12verから移植）
  /// 引数: サービス分類
  /// 戻り値: true=動作する  false=動作しない
  /// 関連tprxソース: rcfncchk.c - rcCheck_Arcs_Payment_Mbr_Read
  static Future<bool> rcCheckArcsPaymentMbrRead() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((RcQcDsp.qCashierIni.arcsPaymentMbrRead != 0)	// 後会員仕様する
        && (cBuf.dbTrm.trmFiller61 != 0)) {	// 会員カード画面を表示する
      if (await RcSysChk.rcChkArcsSmartSelfOrShopSystem()) {
        /* フルセルフまたはShop&Go仕様 */
        return true;
      }
    }
    return false;
  }

  /// 価格確認詳細表示の画面モードをチェックする
  /// 引数: サービス分類
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcCheck_PrcChkMode
  static Future<bool> rcCheckPrcChkMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return ((cMem.stat.scrMode == RcRegs.RG_PRCCHK_DSP)		/* RG 価格確認詳細表示画面 Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.VD_PRCCHK_DSP)	/* VD 価格確認詳細表示画面 Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.TR_PRCCHK_DSP)	/* TR 価格確認詳細表示画面 Mode ? 10.4LCD */
            || (cMem.stat.scrMode == RcRegs.SR_PRCCHK_DSP) );	/* SR 価格確認詳細表示画面 Mode ? 10.4LCD */
      default:
        break;
    }
    return false;
  }

  /// 会員スキャン画面（デュアルキャッシャー仕様）かチェックする
  /// 引数: サービス分類
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcChkScnMbrMode_DualCshr
  static Future<bool> rcChkScnMbrModeDualCshr() async {
    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      AcMem cMem = SystemFunc.readAcMem();
      return ((cMem.stat.scrMode == RcRegs.RG_DUALSCNMBR) ||
          (cMem.stat.scrMode == RcRegs.VD_DUALSCNMBR) ||
          (cMem.stat.scrMode == RcRegs.TR_DUALSCNMBR) ||
          (cMem.stat.scrMode == RcRegs.SR_DUALSCNMBR) );
    }
    return false;
  }

  /// Edy使用画面モードかチェックする
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcNewSG_Check_EdyBal_Mode
  static bool rcNewSGCheckEdyBalMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SG_EDYBAL)  /* RG SG Edy Use Mode ? */
        || (cMem.stat.scrMode == RcRegs.TR_SG_EDYBAL));  /* TR SG Edy Use Mode ? */
  }

  /// Edy_All使用画面モードかチェックする
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcNewSG_Check_EdyAll_Mode
  static bool rcNewSGCheckEdyAllMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_SG_EDYALL)  /* RG SG Edy Use Mode ? */
        || (cMem.stat.scrMode == RcRegs.TR_SG_EDYALL));  /* TR SG Edy Use Mode ? */
  }

  /// 商品登録時売価０自動売変画面モードかチェックする
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcCheck_RegAssist_PChg_Mode
  static Future<bool> rcCheckRegAssistPChgMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return ((cMem.stat.scrMode == RcRegs.RG_REGASSIST_PCHG_DSP)  /* RG 商品登録時売価０自動売変画面 Mode ? */
            || (cMem.stat.scrMode == RcRegs.VD_REGASSIST_PCHG_DSP)  /* VD 商品登録時売価０自動売変画面 Mode ? */
            || (cMem.stat.scrMode == RcRegs.TR_REGASSIST_PCHG_DSP)  /* TR 商品登録時売価０自動売変画面 Mode ? */
            || (cMem.stat.scrMode == RcRegs.SR_REGASSIST_PCHG_DSP));  /* SR 商品登録時売価０自動売変画面 Mode ? */
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_ChgQtyMode
  static Future<bool> rcCheckChgQtyMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_CHGQTY) ||
            (cMem.stat.scrMode == RcRegs.VD_CHGQTY) ||
            (cMem.stat.scrMode == RcRegs.TR_CHGQTY) ||
            (cMem.stat.scrMode == RcRegs.SR_CHGQTY));
      case RcRegs.KY_SINGLE:
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_CHGQTY) ||
              (cMem.stat.scrMode == RcRegs.VD_CHGQTY) ||
              (cMem.stat.scrMode == RcRegs.TR_CHGQTY) ||
              (cMem.stat.scrMode == RcRegs.SR_CHGQTY));
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.subScrMode == RcRegs.RG_CHGQTY) ||
              (cMem.stat.subScrMode == RcRegs.VD_CHGQTY) ||
              (cMem.stat.subScrMode == RcRegs.TR_CHGQTY) ||
              (cMem.stat.subScrMode == RcRegs.SR_CHGQTY));
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_MoneyConfMode
  static Future<bool> rcCheckMoneyConfMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_MONEYCONF) ||
            (cMem.stat.scrMode == RcRegs.VD_MONEYCONF) ||
            (cMem.stat.scrMode == RcRegs.TR_MONEYCONF) ||
            (cMem.stat.scrMode == RcRegs.SR_MONEYCONF));
      case RcRegs.KY_SINGLE:
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_MONEYCONF) ||
              (cMem.stat.scrMode == RcRegs.VD_MONEYCONF) ||
              (cMem.stat.scrMode == RcRegs.TR_MONEYCONF) ||
              (cMem.stat.scrMode == RcRegs.SR_MONEYCONF));
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.subScrMode == RcRegs.RG_MONEYCONF) ||
              (cMem.stat.subScrMode == RcRegs.VD_MONEYCONF) ||
              (cMem.stat.subScrMode == RcRegs.TR_MONEYCONF) ||
              (cMem.stat.subScrMode == RcRegs.SR_MONEYCONF));
        }
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_RRate_Mode
  static Future<bool> rcCheckRRateMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        return ((cMem.stat.scrMode == RcRegs.RG_TPNTRATE) ||   /* RG Cheque Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.VD_TPNTRATE) ||   /* VD Cheque Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_TPNTRATE) ||   /* TR Cheque Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.SR_TPNTRATE) );   /* SR Cheque Mode ? 10.4LCD */
      case RcRegs.KY_SINGLE:
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          return ((cMem.stat.scrMode == RcRegs.RG_TPNTRATE) ||   /* RG Cheque Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.VD_TPNTRATE) ||   /* VD Cheque Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.TR_TPNTRATE) ||   /* TR Cheque Mode ? 10.4LCD */
              (cMem.stat.scrMode == RcRegs.SR_TPNTRATE));   /* SR Cheque Mode ? 10.4LCD */
        }
        else if (cMem.stat.scrType == RcRegs.LCD_57Inch) {
          return ((cMem.stat.subScrMode == RcRegs.RG_TPNTRATE) ||   /* RG Cheque Mode ? 10.4LCD */
              (cMem.stat.subScrMode == RcRegs.VD_TPNTRATE) ||   /* VD Cheque Mode ? 10.4LCD */
              (cMem.stat.subScrMode == RcRegs.TR_TPNTRATE) ||   /* TR Cheque Mode ? 10.4LCD */
              (cMem.stat.subScrMode == RcRegs.SR_TPNTRATE));   /* SR Cheque Mode ? 10.4LCD */
        }
    }
    return false;
  }

  /// dポイント前取引情報入力画面かチェックする
  /// 戻り値: true=上記画面  false=上記画面でない
  /// 関連tprxソース: rcfncchk.c - rcCheck_dPtsOrgTran_Mode
  static Future<bool> rcCheckDPtsOrgTranMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        return ((cMem.stat.scrMode == RcRegs.RG_DPTS_ORGTRAN_DSP) ||
            (cMem.stat.scrMode == RcRegs.VD_DPTS_ORGTRAN_DSP) ||
            (cMem.stat.scrMode == RcRegs.TR_DPTS_ORGTRAN_DSP));
    }
    return false;
  }

  /// 機能概要：dポイントの前取引情報入力が必要か確認する
  /// 戻り値　：0:入力不要、1:入力必要
  /// 関連tprxソース: rcfncchk.c - rcChk_dPointOrgTran
  static Future<int> rcChkDPointOrgTran() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if ((RcSysChk.rcChkdPointRead() != 0)
        && (rcCheckRegistration())
        && (!await RcSysChk.rcQCChkQcashierSystem())
        && (RcqrCom.qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_READ.id)
        && (!RcFncChk.rcCheckScanCheck())
        && (RcSysChk.rcVDOpeModeChk())
        && (mem.tmpbuf.dPointData.orgTran[0].saleDate) == "") // 1Ver対応で宣言先変更により参照方法変更
    {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_PriceMagazine
  static Future<bool> rcCheckPriceMagazine() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (CompileFlag.SELF_GATE) {
      return ((RcItmChk.rcCheckMagazineBarItem()) &&
          (cBuf.dbTrm.magazineScanTyp == 2) &&
          (!await RcSysChk.rcSGChkSelfGateSystem()) &&
          (cMem.working.pluReg.t10003.uusePrc == 0));
    }
    else {
      return ((await RcSysChk.rcSGChkSelfGateSystem()) &&
          (cBuf.dbTrm.magazineScanTyp == 2) &&
          (cMem.working.pluReg.t10003.uusePrc == 0));
    }
  }

  /// Check Operater Function
  /// 関連tprxソース: rcfncchk.c - rcChk_Operation
  static Future<bool> rcChkOperation(String number) async {
    int max = 0;
    int i = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      if (cBuf.dbStaffopen.chkr_status != 1) {
        return true;
      }
    } else {
      if (cBuf.dbStaffopen.cshr_status != 1) {
        return true;
      }
    }

    max = 0;

    if (cMem.kfncCdCnt > 0 && (RcRegs.kFncCd![i] != null)) {
      for (i = 0; i < cMem.kfncCdCnt; i++) {
        if (RcRegs.kFncCd![i] == cMem.stat.fncCode) {
          /* 無理やり権限OKにするキー */
          if (cMem.stat.fncCode == FuncKey.KY_CHGCIN.keyId
              && !(RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 3
                  || RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 4)) {
            return true;
          }

          if (cMem.stat.fncCode == FuncKey.KY_CNCL.keyId
              && (await RcSysChk.rcSGChkSelfGateSystem()
                  && RcSysChk.rcSGChkAmpmSystem()
                  && !RcFncChk.rcSGCheckMntMode())) {
            return true;
          }

          if (RcSysChk.rcChkKYCHA(cMem.stat.fncCode)
              && (!await RcSysChk.rcQCChkQcashierSystem())
              && (RcSysChk
                  .rcChkQRKoptStatusChange())) { // 呼び戻し中などキーオプションの値を変更している時は会計キーの従業員チェックしないように変更
            return true;
          }

          if (cMem.stat.fncCode == FuncKey.KY_CHGDRW.keyId &&
              cBuf.dbKfnc[FuncKey.KY_CHGDRW.keyId].opt.chgDrw
                  .chgdrwStaffInput == 1) {
            return true;
          }

          return false;
        }
      }
    }

    return true;
  }

  /// 機能 : ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ画面か判定
  /// 引数 : コール先関数名
  /// 戻値 : err_no
  /// 関連tprxソース: rcfncchk.c - rcCheck_Acx_OverFlow_Box_Exist2
  static Future<int> rcCheckAcxOverFlowBoxExist2(String callFunc) async {
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.overflowStat1 != 1) {
      log = "callFunc : overflow_stat[${cBuf.overflowStat1}][${cBuf
          .overflowStat2}] error\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      return DlgConfirmMsgKind.MSG_CONF_OVERFLOW_BOX.dlgId;
    }
    return OK;
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_Nec_Emoney_Use_Mode
  static bool rcQCCheckNecEmoneyUseMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ( (cMem.stat.s2prDspSts == RcRegs.RG_QC_NEC_EMONEY_USE) ||
             (cMem.stat.s2prRjpSts == RcRegs.TR_QC_NEC_EMONEY_USE) );
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_Nec_Emoney_Dsp_Mode
  static bool rcQCCheckNecEmoneyDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ( (cMem.stat.scrMode == RcRegs.RG_QC_NEC_EMONEY) ||
             (cMem.stat.scrMode == RcRegs.TR_QC_NEC_EMONEY) );
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Nec_Emoney_Mode
  static Future<bool> rcCheckNecEmoneyMode() async {
    int kySelf = await RcSysChk.rcKySelf();
    AcMem cMem = SystemFunc.readAcMem();

    switch (kySelf)
    {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_SINGLE   :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR :
        return( (cMem.stat.scrMode == RcRegs.RG_NEC_EMONEY_DSP) ||	/* RG NEC_EMONEY Mode ? 10.4LCD */
          (cMem.stat.scrMode == RcRegs.VD_NEC_EMONEY_DSP) ||	/* VD NEC_EMONEY Mode ? 10.4LCD */
          (cMem.stat.scrMode == RcRegs.SR_NEC_EMONEY_DSP) ||	/* TR NEC_EMONEY Mode ? 10.4LCD */
          (cMem.stat.scrMode == RcRegs.TR_NEC_EMONEY_DSP) );	/* SR NEC_EMONEY Mode ? 10.4LCD */
      default          :	break;
    }

    return (false);
  }

  /// 関連tprxソース: rcfncchk.c - rcCheck_Yumeca_pol_Mode
  static Future<bool> rcCheckYumecaPolMode() async {
    int kySelf = await RcSysChk.rcKySelf();
    AcMem cMem = SystemFunc.readAcMem();
    switch(kySelf) {
            case RcRegs.DESKTOPTYPE :
            case RcRegs.KY_SINGLE   :
            case RcRegs.KY_CHECKER  :
            case RcRegs.KY_DUALCSHR :
                    return( (cMem.stat.scrMode == RcRegs.RG_YUMECA_POL_DSP) ||    /* RG yumeca_pol Mode ? 10.4LCD */
                            (cMem.stat.scrMode == RcRegs.VD_YUMECA_POL_DSP) ||    /* VD yumeca_pol Mode ? 10.4LCD */
                            (cMem.stat.scrMode == RcRegs.SR_YUMECA_POL_DSP) ||    /* TR yumeca_pol Mode ? 10.4LCD */
                            (cMem.stat.scrMode == RcRegs.TR_YUMECA_POL_DSP) );    /* SR yumeca_pol Mode ? 10.4LCD */
            default          :      break;
    }
    return(false);
  }

  /// 機能：バーコード読取画面のモードのチェック
  /// 引数：なし
  /// 戻値：結果
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_BarcodePay_Read_Mode
  static Future<bool> rcQCCheckBarcodePayReadMode() async {
    int kySelf = await RcSysChk.rcKySelf();
    AcMem cMem = SystemFunc.readAcMem();
    switch (kySelf) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_SINGLE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_QC_BCDPAY_READ) || /* RG Barcode Pay Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_QC_BCDPAY_READ));/* TR Barcode Pay Mode ? 10.4LCD */
      default :  break;
    }
    return false;
  }

  /// 機能：バーコード決済(QR)読込画面のモードのチェック
  /// 引数：なし
  /// 戻値：false(0):表示している　true(1):表示していない
  /// 関連tprxソース: rcfncchk.c - rcQC_Check_BarcodePay_QR_Read_Mode
  static Future<bool> rcQCCheckBarcodePayQRReadMode() async {
    int kySelf = await RcSysChk.rcKySelf();
    AcMem cMem = SystemFunc.readAcMem();
    switch (kySelf) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_SINGLE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        return ((cMem.stat.scrMode == RcRegs.RG_QC_BCDPAY_QR_READ) || /* RG Barcode Pay Mode ? 10.4LCD */
            (cMem.stat.scrMode == RcRegs.TR_QC_BCDPAY_QR_READ));/* TR Barcode Pay Mode ? 10.4LCD */
      default :  break;
    }
    return false;
  }

  /// 関連tprxソース: rcfncchk.c - rcQC_Check_EdyDsp_Mode
  static bool rcQCCheckEdyDspMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.stat.scrMode == RcRegs.RG_QC_EDY) ||
        (cMem.stat.scrMode == RcRegs.TR_QC_EDY));
  }
  

  /// 関連tprxソース: rcfncchk.c - rcCheck_QCashier_Mode
  static bool rcCheckQCashierMode() {
    return ((rcQCCheckStartDspMode()) || // Start  Disp Mode ?
        (rcQCCheckSlctDspMode()) || // Select Disp Mode ?
        (rcQCCheckItemDspMode()) || // item   Disp Mode ?
        (rcQCCheckCashDspMode())); // Use Cash Mode ?
  }

  /// 機能：HappySelf仕様[対面セルフ]入金動作「小計後」変更可能かチェック
  /// 引数：cin_mode 釣銭機動作状態 0 動作しない 1 動作する
  /// 戻値：0 しない 1 釣銭機動作扱い 2 タブお預り額表示削除
  /// 関連tprxソース: rcfncchk.c - rcCheck_AcrAcb_StlMode
  static Future<int> rcCheckAcrAcbStlMode(int cinMode) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    /* HappySelf仕様[対面セルフ] */
    if ((await RcSysChk.rcSysChkHappySmile()) &&
        /* 釣銭釣札機動作中 */
        (cinMode == 1) &&
        /* 入金動作変更「する」 */
        (RcQcDsp.qCashierIni.acracbStlmode == 1) &&
        /* 対面セルフ入金動作「小計後」 */
        (cBuf.dbTrm.timePrcTyp == 1)) {
      /* HappySelf仕様[対面セルフ]入金動作する */
      return (1);
    } else if ((await RcSysChk.rcSysChkHappySmile()) &&
        (cinMode == 0) &&
        (RcQcDsp.qCashierIni.acracbStlmode == 1) &&
        (cBuf.dbTrm.timePrcTyp == 1)) {
      /* HappySelf仕様[対面セルフ]入金動作する */
      return (2);
    }
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcfncchk.c -rcQC_Check_dPoint_Mode
  static bool rcQCCheckDPointMode(){
    return true;
  }
  
  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcfncchk.c -rcCheck_Fresta_PayConf_Mode
  static bool rcCheckFrestaPayConfMode(){
    return true;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcfncchk.c -rcChk_fresta_fspPntStmp
  static int rcChkFrestaFspPntStmp(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcfncchk.c -rcfncchk_Fresta_ConfDsp_Chk
  static int rcfncchkFrestaConfDspChk(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcfncchk.c -rcQC_Check_VescaEnd_Mode
  static bool rcQCCheckVescaEndMode(){
    return true;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcfncchk.c -rcQC_Check_Vesca_Mode
  static bool rcQCCheckVescaMode(){
    return true;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcfncchk.c -rcfncchk_qc_not_nimoca_confirm_scrmode
  static int rcfncchkQcNotNimocaConfirmScrmode(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcfncchk.c -rcfncchk_qc_nimoca_yes_no_scrmode
  static int rcfncchkQcNimocaYesNoScrmode(){
    return 0;
  }
}

class RcFncChkDef {
  /// 関連tprxソース: rcfncchk.c - Macro0_List
  static List<int> macro0List = [
    FncCode.KY_ENT.keyId,
    FncCode.KY_REG.keyId,
    FuncKey.KY_STL.keyId,
    FuncKey.KY_MAN.keyId,
    FuncKey.KY_5SEN.keyId,
    FuncKey.KY_SEN.keyId,
    FuncKey.KY_DSC1.keyId,
    FuncKey.KY_DSC2.keyId,
    FuncKey.KY_DSC3.keyId,
    FuncKey.KY_DSC4.keyId,
    FuncKey.KY_DSC5.keyId,
    FuncKey.KY_PM1.keyId,
    FuncKey.KY_PM2.keyId,
    FuncKey.KY_PM3.keyId,
    FuncKey.KY_PM4.keyId,
    FuncKey.KY_PM5.keyId,
    FuncKey.KY_VOID.keyId,
    FuncKey.KY_CNCL.keyId,
    FuncKey.KY_REF.keyId,
    FuncKey.KY_MUL.keyId,
    FuncKey.KY_PRC.keyId,
    FuncKey.KY_BRA.keyId,
    FuncKey.KY_MG.keyId,
    FuncKey.KY_PCHG.keyId,
    FuncKey.KY_MBR.keyId,
    FuncKey.KY_WTTARE1.keyId,
    FuncKey.KY_WTTARE2.keyId,
    FuncKey.KY_WTTARE3.keyId,
    FuncKey.KY_WTTARE4.keyId,
    FuncKey.KY_WTTARE5.keyId,
    FuncKey.KY_WTTARE6.keyId,
    FuncKey.KY_WTTARE7.keyId,
    FuncKey.KY_WTTARE8.keyId,
    FuncKey.KY_WTTARE9.keyId,
    FuncKey.KY_WTTARE10.keyId,
    FuncKey.KY_UPRC.keyId,
    FuncKey.KY_DECIMAL.keyId,
    FuncKey.KY_MBRCLR.keyId,
    FuncKey.KY_BRT.keyId,
    FuncKey.KY_STAMP1.keyId,
    FuncKey.KY_STAMP2.keyId,
    FuncKey.KY_STAMP3.keyId,
    FuncKey.KY_STAMP4.keyId,
    FuncKey.KY_STAMP5.keyId,
    FuncKey.KY_PLUS1.keyId,
    FuncKey.KY_PLUS2.keyId,
    FuncKey.KY_PLUS3.keyId,
    FuncKey.KY_PLUS4.keyId,
    FuncKey.KY_PLUS5.keyId,
    FuncKey.KY_NOTAX.keyId,
    FuncKey.KY_MRATE.keyId,
    FuncKey.KY_MDL.keyId,
    FuncKey.KY_LRG.keyId,
    FuncKey.KY_SPCNCL.keyId,
    FuncKey.KY_WIZSTART.keyId,
    FuncKey.KY_GRATIS.keyId,
    FuncKey.KY_WEIGHT_INP.keyId,
    FuncKey.KY_BC.keyId,
    FuncKey.KY_PRECA_CLR.keyId,
    FuncKey.KY_SPECIAL_PRICE.keyId,
    FuncKey.KY_CHGTAX1.keyId,
    FuncKey.KY_CHGTAX2.keyId,
    FuncKey.KY_CHGTAX3.keyId,
    FuncKey.KY_CHGTAX4.keyId,
    FuncKey.KY_CHGTAX5.keyId,
    0
  ];

  /// 関連tprxソース: rcfncchk.c - Macro1_List
  static List<int> macro1List = [
    FncCode.KY_REG.keyId,
    FncCode.KY_SCAN.keyId,
    FncCode.KY_PSET.keyId,
    FuncKey.KY_STL.keyId,
    FuncKey.KY_CLR.keyId,
    FuncKey.KY_PLU.keyId,
    FuncKey.KY_MG.keyId,
    FuncKey.KY_DRW.keyId,
    FuncKey.KY_CORR.keyId,
    FuncKey.KY_BRT.keyId,
    FuncKey.KY_RMOD.keyId,
    FuncKey.KY_MBR.keyId,
    FuncKey.KY_MEMSRV.keyId,
    FuncKey.KY_CARD.keyId,
    FuncKey.KY_PRSN.keyId,
    FuncKey.KY_BRA.keyId,
    FuncKey.KY_STAMP1.keyId,
    FuncKey.KY_STAMP2.keyId,
    FuncKey.KY_STAMP3.keyId,
    FuncKey.KY_STAMP4.keyId,
    FuncKey.KY_STAMP5.keyId,
    FuncKey.KY_TEL.keyId,
    FuncKey.KY_COMP_CD.keyId,
    FuncKey.KY_MDL.keyId,
    FuncKey.KY_LRG.keyId,
    0
  ];

  /// 関連tprxソース: rcfncchk.c - Macro2_List
  static List<int> macro2List = macro3List;

  /// 関連tprxソース: rcfncchk.c - Macro3_List
  static List<int> macro3List = [
    FncCode.KY_FNAL.keyId,
    FuncKey.KY_CASH.keyId,
    FuncKey.KY_CHA1.keyId,
    FuncKey.KY_CHA2.keyId,
    FuncKey.KY_CHA3.keyId,
    FuncKey.KY_CHA4.keyId,
    FuncKey.KY_CHA5.keyId,
    FuncKey.KY_CHA6.keyId,
    FuncKey.KY_CHA7.keyId,
    FuncKey.KY_CHA8.keyId,
    FuncKey.KY_CHA9.keyId,
    FuncKey.KY_CHA10.keyId,
    FuncKey.KY_CRDT.keyId,
    FuncKey.KY_CHK1.keyId,
    FuncKey.KY_CHK2.keyId,
    FuncKey.KY_CHK3.keyId,
    FuncKey.KY_CHK4.keyId,
    FuncKey.KY_CHK5.keyId,
    FuncKey.KY_DRW.keyId,
    FuncKey.KY_CNCL.keyId,
    FuncKey.KY_MUL.keyId,
    FuncKey.KY_CIN1.keyId,
    FuncKey.KY_CIN2.keyId,
    FuncKey.KY_CIN3.keyId,
    FuncKey.KY_CIN4.keyId,
    FuncKey.KY_CIN5.keyId,
    FuncKey.KY_CIN6.keyId,
    FuncKey.KY_CIN7.keyId,
    FuncKey.KY_CIN8.keyId,
    FuncKey.KY_CIN9.keyId,
    FuncKey.KY_CIN10.keyId,
    FuncKey.KY_CIN11.keyId,
    FuncKey.KY_CIN12.keyId,
    FuncKey.KY_CIN13.keyId,
    FuncKey.KY_CIN14.keyId,
    FuncKey.KY_CIN15.keyId,
    FuncKey.KY_CIN16.keyId,
    FuncKey.KY_OUT1.keyId,
    FuncKey.KY_OUT2.keyId,
    FuncKey.KY_OUT3.keyId,
    FuncKey.KY_OUT4.keyId,
    FuncKey.KY_OUT5.keyId,
    FuncKey.KY_OUT6.keyId,
    FuncKey.KY_OUT7.keyId,
    FuncKey.KY_OUT8.keyId,
    FuncKey.KY_OUT9.keyId,
    FuncKey.KY_OUT10.keyId,
    FuncKey.KY_OUT11.keyId,
    FuncKey.KY_OUT12.keyId,
    FuncKey.KY_OUT13.keyId,
    FuncKey.KY_OUT14.keyId,
    FuncKey.KY_OUT15.keyId,
    FuncKey.KY_OUT16.keyId,
    FuncKey.KY_RPR.keyId,
    FuncKey.KY_LOAN.keyId,
    FuncKey.KY_PICK.keyId,
    FuncKey.KY_RPR.keyId,
    FuncKey.KY_RCTFM.keyId,
    FuncKey.KY_CDCARD1.keyId,
    FuncKey.KY_CDCARD2.keyId,
    FuncKey.KY_PPC.keyId,
    FuncKey.KY_ADDPNT.keyId,
    FuncKey.KY_TCKTISSU.keyId,
    FuncKey.KY_WRTY.keyId,
    FuncKey.KY_SPCNCL.keyId,
    FuncKey.KY_RRATE.keyId,
    FuncKey.KY_CHA11.keyId,
    FuncKey.KY_CHA12.keyId,
    FuncKey.KY_CHA13.keyId,
    FuncKey.KY_CHA14.keyId,
    FuncKey.KY_CHA15.keyId,
    FuncKey.KY_CHA16.keyId,
    FuncKey.KY_CHA17.keyId,
    FuncKey.KY_CHA18.keyId,
    FuncKey.KY_CHA19.keyId,
    FuncKey.KY_CHA20.keyId,
    FuncKey.KY_CHA21.keyId,
    FuncKey.KY_CHA22.keyId,
    FuncKey.KY_CHA23.keyId,
    FuncKey.KY_CHA24.keyId,
    FuncKey.KY_CHA25.keyId,
    FuncKey.KY_CHA26.keyId,
    FuncKey.KY_CHA27.keyId,
    FuncKey.KY_CHA28.keyId,
    FuncKey.KY_CHA29.keyId,
    FuncKey.KY_CHA30.keyId,
    FuncKey.KY_POINT_ADD.keyId,
    FuncKey.KY_RCTFM_RPR.keyId,
    0
  ];

  /// 関連tprxソース: rcfncchk.c - Macro4_List
  static List<int> macro4List = [
    FuncKey.KY_RCTON.keyId,
    FncCode.KY_FNAL.keyId,
    FuncKey.KY_STL.keyId,
    FuncKey.KY_CHGCIN.keyId,
    FuncKey.KY_STAFF.keyId,
    0,
    FuncKey.KY_FLIGHT1.keyId,
    FuncKey.KY_FLIGHT2.keyId,
    FuncKey.KY_FLIGHT3.keyId,
    FuncKey.KY_FLIGHT4.keyId,
    FuncKey.KY_FLIGHT5.keyId,
    FuncKey.KY_FLIGHT6.keyId,
    FuncKey.KY_FLIGHT7.keyId,
    FuncKey.KY_FLIGHT8.keyId,
    FuncKey.KY_FLIGHT9.keyId,
    FuncKey.KY_FLIGHT10.keyId,
    FuncKey.KY_FLIGHT11.keyId,
    FuncKey.KY_FLIGHT12.keyId,
    FuncKey.KY_FLIGHT13.keyId,
    FuncKey.KY_FLIGHT14.keyId,
    FuncKey.KY_FLIGHT15.keyId,
    FuncKey.KY_FLIGHT16.keyId,
    FuncKey.KY_FLIGHT17.keyId,
    FuncKey.KY_FLIGHT18.keyId,
    FuncKey.KY_FLIGHT19.keyId,
    FuncKey.KY_FLIGHT20.keyId,
    FuncKey.KY_FLIGHT21.keyId,
    FuncKey.KY_FLIGHT22.keyId,
    FuncKey.KY_FLIGHT23.keyId,
    FuncKey.KY_FLIGHT24.keyId,
    FuncKey.KY_FLIGHT25.keyId,
    FuncKey.KY_FLIGHT26.keyId,
    FuncKey.KY_FLIGHT27.keyId
  ];
}