/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/regs/checker/rcky_sus.dart';
import 'package:flutter_pos/app/regs/checker/rcky_tab.dart';
import 'package:flutter_pos/app/regs/checker/rckydisburse.dart';
import 'package:flutter_pos/app/regs/checker/rckymenu.dart';
import 'package:flutter_pos/app/regs/checker/rckyselpluadj.dart';
import 'package:flutter_pos/app/regs/checker/rcmbrrealsvr.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/cm_sys/cm_cktwr.dart';
import '../../lib/cm_sys/cm_stf.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_mcd.dart';
import 'rcfncchk.dart';
import 'rcsyschk.dart';

class Rcky2Person {
  static List<int> staffList0 = [FncCode.KY_ENT.keyId, FncCode.KY_REG.keyId, 0];
  static List<int> staffList1 = [FncCode.KY_SCAN.keyId, FncCode.KY_PSET.keyId, 0];
  static List<int> staffList2 = [0];
  static List<int> staffList3=  [FncCode.KY_FNAL.keyId, 0];
  static List<int> staffList4 = [0];

  /// todo 動作未確認
  /// 関連tprxソース:rcky_2person.c - rc_person_state_check()
  static Future<int> rcPersonStateCheck() async
  {
    int errNo = Typ.OK;

    if(await CmStf.cmPersonChk() == 1)   /* one person */
    {
    // #if 0
    //   if (!(rcChk_ZHQ_system()))
    //   {
    //     if(C_BUF->db_staffopen.cshr_status == 0)   /* close */
    //   {
    //     TprLibLogWrite(GetTid(), TPRLOG_ERROR, 0, "rcKy2Person cshr close");
    //     err_no = MSG_OPEERR;
    //   }
    // }
    // #endif
    }
    else if(await CmStf.cmPersonChk() == 2) /* two person */
    {
    // #if 0
    // if (!(rcChk_ZHQ_system()))
    // {
    //   if((C_BUF->db_staffopen.cshr_status == 0) &&       /* cashier close */
    //   (C_BUF->db_staffopen.chkr_status == 0))         /* checker close */
    //   {
    //     TprLibLogWrite(GetTid(), TPRLOG_ERROR, 0, "rcKy2Person cshr and chkr close");
    //     err_no = MSG_OPEERR;
    //   }
    // }
    // #endif
    }
    return errNo;
  }

  /// 関連tprxソース:rcky_2person.c - rcChk_Ky_2Person()
  /// todo 動作未確認で呼び出しメソッドも中身未作成含む
  ///      戻り値が-1の場合は共有メモリ参照時のisInvalidケースのため、
  ///      呼び出し側で適切な表示メッセージを指定すること
  static Future<int> rcChkKy2Person() async {
    //short *p;
    int errNo;

    if(await CmCksys.cmChk2PersonSystem() != 2)
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person frcClkFlg != 2");

      return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }

//#ifdef FB2GTK
//     if (await CmCksys.cmChkKasumi2Person() != 0)
//     {
//       if(await RcSysChk.rcCheckRegDual())
//       {
//         TprLog().logAdd(
//             Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person rcCheckRegDual() error");
//         return DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
//       }
//
//       if(await RcSysChk.rcSGChkSelfGateSystem()) {
//         TprLog().logAdd(
//             Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person rcSGChkSelfGateSystem()");
//         return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
//       }
//     }
// #endif

    if(rc2StfSystem() == 0)   /* Not Simple 2 Staff System */
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person Not Simple 2 Staff System");
      return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]))
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person reg staff not change");
      if(await CmCksys.cmChkKasumi2Person() != 0) {
        return DlgConfirmMsgKind.MSG_REGSTFNOTCHG2.dlgId;
      } else {
        return DlgConfirmMsgKind.MSG_REGSTFNOTCHG.dlgId;
      }
    }

    if(! RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person tran staff not change");
      if (await CmCksys.cmChkKasumi2Person() != 0) {
        return DlgConfirmMsgKind.MSG_TRANSTFNOTCHG2.dlgId;
      } else {
        return DlgConfirmMsgKind.MSG_TRANSTFNOTCHG.dlgId;
      }
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return -1;
    }
    RxCommonBuf cBuf = xRet.object;

    RxMemRet xRetTsBuf = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetTsBuf.isInvalid()) {
      return -1;
    }
    RxTaskStatBuf tsBuf = xRetTsBuf.object;

    if(cBuf.dbTrm.chkPasswordClkOpen != 0)
    {
      switch(await RcSysChk.rcKySelf())
      {
        case RcRegs.KY_DUALCSHR:
          if((!RcFncChk.rcCheckRegistration())
              && (tsBuf.chk.stat != 0))
          {
            return DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
          }
          break;
        case RcRegs.KY_CHECKER:
          if((! RcFncChk.rcCheckRegistration())
              && (tsBuf.chk.stat != 0))
          {
            return DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
          }
          if(tsBuf.cash.staff_pw & 0x01 != 0) //従業員入力中
          {
            return DlgConfirmMsgKind.MSG_DESKTOP_USING_ERR.dlgId;
          }
          break;
        default:
          break;
      }
    }

    if(tsBuf.cash.stat != 0)
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person cash.stat");
      if (await CmCksys.cmChkKasumi2Person() != 0) {
        return DlgConfirmMsgKind.MSG_TRANSTFNOTCHG2.dlgId;
      } else {
        return DlgConfirmMsgKind.MSG_TRANSTFNOTCHG.dlgId;
      }
    }
    // todo cash.comltd_flgは実装されていないので要追加
    //else if(tsBuf.cash.comltd_flg) {
    //   TprLibLogWrite(GetTid(), TPRLOG_ERROR, 0, "rcKy2Person cash.comltd_flg");
    //   return DlgConfirmMsgKind.MSG_TRANSTFNOTCHG.dlgId;
    //}

    if(await CmStf.cmPersonChk() == 2) /* two person */
    {
      if(tsBuf.cash.err_stat != 0)
      {
        TprLog().logAdd(
            Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person cash.err_stat Error");
        if (await CmCksys.cmChkKasumi2Person() != 0) {
          return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        } else {
          return DlgConfirmMsgKind.MSG_WAIT.dlgId;
        }
      }
    }

    switch(await RcSysChk.rcKySelf())
    {
      case RcRegs.KY_DUALCSHR:
        if(tsBuf.chk.staff_pw & 0x01 != 0)  //従業員入力中
        {
          return DlgConfirmMsgKind.MSG_TOWER_USING_ERR.dlgId;
        }
        break;
      case RcRegs.KY_CHECKER:
        if(tsBuf.cash.staff_pw & 0x01 != 0) //従業員入力中
        {
          return DlgConfirmMsgKind.MSG_DESKTOP_USING_ERR.dlgId;
        }
        break;
    }

    if(RcSysChk.rcChkSpoolExist())
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person Spool Exist Error");
      return DlgConfirmMsgKind.MSG_CLEAROFF.dlgId;
    }
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xFF);
    for (int i = 0; i < staffList0.length; i++) {
      if (staffList0[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, staffList0[i]);
    }
    for (int i = 0; i < staffList1.length; i++) {
      if (staffList1[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, staffList1[i]);
    }
    for (int i = 0; i < staffList2.length; i++) {
      if (staffList2[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, staffList2[i]);
    }
    for (int i = 0; i < staffList3.length; i++) {
      if (staffList3[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, staffList3[i]);
    }
    for (int i = 0; i < staffList4.length; i++) {
      if (staffList4[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, staffList4[i]);
    }
    if(RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0)
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person key err");
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if((await RckySus.rcCheckSuspend() != 0) || (await RckySus.rcCheckChkrSus() != 0) || (await RckySus.rcCheckCashSus() != 0))
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person suspend error");
      return DlgConfirmMsgKind.MSG_SUSERROR.dlgId;
    }
    if((RckyTab.rcCheckChkrTab() != 0) || (RckyTab.rcCheckCashTab() != 0))
    {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person TabData error");
       return DlgConfirmMsgKind.MSG_TABERROR_EXPLAIN.dlgId;
    }

    // todo SelfStaffDspは未実装
    // if((RcFncChk.rcChkTenOn()) && (SelfStaffDsp.staff_disp != 1) )
    // {
    //   TprLog().logAdd(
    //       Tpraid.TPRAID_CHK, LogLevelDefine.error, "rcChkKy2Person ten on error");
    //   return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    // }

    errNo = Typ.OK;

    // #if MC_SYSTEM || SAPPORO
    if ((errNo == Typ.OK) && (tsBuf.rwc.order != 0  )) { rcErLog2p(20); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;}
    // #endif
    if ((errNo == Typ.OK) && (RcSysChk.rcCheckCalcTend()    )) { rcErLog2p(2); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    if ((errNo == Typ.OK) && (rcCheckError() != 0           )) { rcErLog2p(3); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    if ((errNo == Typ.OK) && (RcFncChk.rcCheckScanCheck()   )) { rcErLog2p(5); errNo = DlgConfirmMsgKind.MSG_PLUCHECK_EXPLAIN.dlgId; }
    if ((errNo == Typ.OK) && (RcFncChk.rcCheckScanWtCheck() )) { rcErLog2p(30); errNo = DlgConfirmMsgKind.MSG_WTPLUCHECK_EXPLAIN.dlgId; }
    // #if SELF_GATE
    if( (cBuf.dbTrm.ticketOpeWithoutQs != 0) && !(await RcSysChk.rcSGChkSelfGateSystem()) ) {
    // #endif
      if ((errNo == Typ.OK) && (!RckyMenu.rcCheckPsWdKyMenu())) { rcErLog2p(4); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    }
    else {
      if ((errNo == Typ.OK) && (!RcSysChk.rcCheckRegFnal())) { rcErLog2p(4); errNo = DlgConfirmMsgKind.MSG_REGERROR_EXPLAIN.dlgId; }
    }
//    if ((err_no == OK) && (rcChk_Spool_Exist()   )) { rcERLOG_2p(6); err_no = MSG_CLEAROFF;   }
//    if ((err_no == OK) && (!rcCheck_Suspend()    )) { rcERLOG_2p(7); err_no = MSG_SUSERROR_EXPLAIN;   }
//    if ((err_no == OK) && (!rcCheck_Chkr_Sus()   )) { rcERLOG_2p(8); err_no = MSG_SUSERROR_EXPLAIN;   }
//    if ((err_no == OK) && (!rcCheck_Cash_Sus()   )) { rcERLOG_2p(9); err_no = MSG_SUSERROR_EXPLAIN;   }
//    if ((err_no == OK) && (rcCheck_RegDual()     )) { rcERLOG_2p(10); err_no = MSG_OPEBUSYERR; }
    if ((errNo == Typ.OK) && (await RckyMenu.rcCheckDualCshrIn() )) { rcErLog2p(11); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    if ((errNo == Typ.OK) && (await RcSysChk.rcCheckChkrEndDual() != 0)) { rcErLog2p(12); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    if ((errNo == Typ.OK) && (RcSysChk.rcCheckEsVoidProc())) { rcErLog2p(19); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    if ((errNo == Typ.OK) && (await RckyDisBurse.rcCheckKYDisBurse())) {rcErLog2p(21); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
//    if ((err_no == OK) && (!rcCheck_Chkr_Tab()   )) { rcERLOG_2p(24); err_no = MSG_TABERROR_EXPLAIN; }
//    if ((err_no == OK) && (!rcCheck_Cash_Tab()   )) { rcERLOG_2p(25); err_no = MSG_TABERROR_EXPLAIN; }
    if((errNo == Typ.OK) && (await RcKySelpluadj.rckySelPluAdjSelctMode())) { rcErLog2p(27); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    //#if CUSTREALSVR
    if( (RcSysChk.rcChkCustrealsvrSystem() || await RcSysChk.rcChkCustrealNecSystem(0)) && (errNo == Typ.OK) ) {
      if ((await Rcmbrrealsvr.custRealSvrWaitChk()) || (RcMcd.rcMcdMbrWaitChk() != 0)) {
        errNo = DlgConfirmMsgKind.MSG_MBRINQUIR.dlgId;
      }
      else if( cBuf.custOffline == 1 ) {
        errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
      }
    }
    //#endif
    if ((errNo == Typ.OK) && (tsBuf.multi.order != 0      )) { rcErLog2p(23); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    if ((errNo == Typ.OK) && (tsBuf.suica.order != 0      )) { rcErLog2p(26); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }
    if((errNo == Typ.OK) && (RcSysChk.rcCheckWizAdjSystem())) {
//         if(stat == 1) {  /* Check Only */
//             return(OK);
//         }
//	 else {
    if((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) && ((tsBuf.chk.fnc_code == FuncKey.KY_MENU.keyId) || (tsBuf.chk.fnc_code == FuncKey.KY_CMOD.keyId) || (tsBuf.chk.fnc_code == FuncKey.KY_STAFF_REPT.keyId))) {
      rcErLog2p(28);
      errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
    }
    else if((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) && ((tsBuf.cash.fnc_code == FuncKey.KY_MENU.keyId) || (tsBuf.cash.fnc_code == FuncKey.KY_CMOD.keyId) || (tsBuf.cash.fnc_code == FuncKey.KY_STAFF_REPT.keyId))) {
      rcErLog2p(29);
      errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
    }
//         }
    }
    if ((errNo == Typ.OK) && (await RcSysChk.rcCheckQCJCSystem()) && (tsBuf.cash.qcjc_j_stat == 1)) { rcErLog2p(32); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }

    /* this line is always last check,if this line is ok then cashier is die */
//    if ((err_no == OK) && (rcCheck_CashEnd()     )) { rcERLOG_2p(13); err_no = MSG_OPEBUSYERR; }
    if ((errNo == Typ.OK) && (cBuf.kymenuUpFlg == 2)) { rcErLog2p(22); errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId; }

    if(errNo != Typ.OK){
      return(errNo);
    }

    errNo = await rcPersonStateCheck();

    return errNo;
  }

  /// todo 動作未確認
  /// 関連tprxソース:rcky_2person.c - rcERLOG_2p()
  static void rcErLog2p(int num)
  {
    String buf;

    switch(num) {
      case 1: buf = 'rcCheckClerk() error';
      case 2: buf = 'rcCheckCalcTend() error';
      case 3:
        AcMem cMem = SystemFunc.readAcMem();
        RxMemRet xRetTsBuf = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (xRetTsBuf.isInvalid()) {
          buf = 'rcCheckError() RXMEM_STAT get error';
          break;
        }
        RxTaskStatBuf tsBuf = xRetTsBuf.object;
        buf = 'rcCheckError() error[${cMem.ent.errStat.toString()}][${tsBuf.chk.err_stat.toString()}]';
      case 4: buf = 'rcCheckRegFnal() error';
      case 5: buf = 'rcCheckScanCheck() error';
      case 6: buf = 'rcChkSpoolExist() error';
      case 7: buf = 'rcCheckSuspend() error';
      case 8: buf = 'rcCheckChkrSus() error';
      case 9: buf = 'rcCheckCashSus() error';
      case 10: buf = 'rcCheckRegDual() error';
      case 11: buf = 'rcCheckDualCshrIn() error';
      case 12: buf = 'rcCheckChkrEndDual() error';
      case 13:
        RxMemRet xRetTsBuf = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (xRetTsBuf.isInvalid()) {
          buf = 'rcCheckError() RXMEM_STAT get error';
          break;
        }
        RxTaskStatBuf tsBuf = xRetTsBuf.object;
        buf = 'rcCheckCashEnd() error[${tsBuf.cash.stat.toString()}][${tsBuf.cash.err_stat.toString()}]';
      case 14: buf = 'rcCheckChkrEnd() error';
      case 15:
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if (xRet.isInvalid()) {
          buf = 'RXMEM_COMMON get error';
          break;
        }
        RxCommonBuf cBuf = xRet.object;
        buf = 'cBuf.dbTrm.frcClkFlg[${cBuf.dbTrm.frcClkFlg.toString()}] error';
      case 16: buf = 'rcCheckCheckerErr() error';
      case 17: buf = 'rcCheckDualCshrIn() error';
      case 18: buf = 'FB2GTK DUALCASHIER END WAIT error';
      case 19: buf = 'ESVOID END WAIT error';
      case 20: buf = 'RWC ORDER error';
      case 21: buf = 'DISBURSE error';
      case 22: buf = 'ACX END WAIT error';
      case 23: buf = 'MULTI ORDER error';
      case 24: buf = 'rcCheckChkrTab() error';
      case 25: buf = 'rcCheckCashTab() error';
      case 26: buf = 'SUICA ORDER error';
      case 27: buf = 'Sel Plu Adj Selecting error';
      case 28: buf = 'WizAdj[KY_CHECKER] error';
      case 29: buf = 'WizAdj[KY_DUALCSHR] error';
      case 30: buf = 'rcCheckScanWtCheck() error';
      default: buf = 'default call invalid parameter';
    }
    TprLog().logAdd(
        Tpraid.TPRAID_CHK, LogLevelDefine.normal, buf);
  }

  /// todo 動作未確認
  /// 関連tprxソース:rcky_2person.c - rcCheck_Error()
  static int rcCheckError()
  {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetTsBuf = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetTsBuf.isInvalid()) {
      return -1;
    }
    RxTaskStatBuf tsBuf = xRetTsBuf.object;

    if ((cMem.ent.errStat != 0) || (tsBuf.chk.err_stat != 0)) {
      /* Now is Error ?  */
      return 1;
    } else {
      return 0;
    }
  }


  /// todo 動作未確認
  /// 関連tprxソース:rcky_2person.c - rc_2stf_system()
  static int rc2StfSystem() {
    if(CmCktWr.cm_chk_tower() == CmSys.TPR_TYPE_TOWER)
    {
      return 1;
    }
    return 0;
  }
}