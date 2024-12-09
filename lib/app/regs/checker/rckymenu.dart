/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../regs/checker/rc_set.dart';
import '../../regs/checker/rcsyschk.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/cm_chg/ltobcd.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

/// 関連tprxソース: rckymenu.c
class RckyMenu {
  /// 関連tprxソース: rckymenu.c - rcCheck_Ky_Menu
  static Future<int> rcCheckKyMenu(int stat) async {
    int errNo = OK;

    // 共有メモリ取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
    }
    RxCommonBuf cBuf = xRet.object;

    // TODO:00016 佐藤 必要な部分だけ先行実装、それ以外はコメントアウト
    /*
    #if SAPPORO
    if ((err_no == OK) && (TS_BUF->rwc.order     )) { rcERLOG(20); err_no = MSG_OPEBUSYERR;}
    if ((err_no == OK) && (RC_INFO_MEM->RC_CNCT.CNCT_RWT_CNCT == 1) && (TS_BUF->rwc.stat)) { rcERLOG(30); err_no = MSG_OPEBUSYERR;}
    #endif
    if ((err_no == OK) && (rcCheck_Clerk()       )) { rcERLOG(1); err_no = MSG_OPEERR;     }
    if ((err_no == OK) && (rcCheck_Calc_Tend()   )) { rcERLOG(2); err_no = MSG_OPEBUSYERR; }
    if ((err_no == OK) && (rcCheck_Error()       )) { rcERLOG(3); err_no = MSG_TOWER_USING_ERR; }
    if ((err_no == OK)
    && ((Ky_St_C0(CMEM->key_stat[KY_PCHG]))
    || (Ky_St_C4(CMEM->key_stat[KY_PCHG]))))
    { // 売価変更
    rcERLOG(37);
    err_no = MSG_OPEBUSYERR;
    }
    if ((err_no == OK) && (rcCheck_ScanCheck()   )) { rcERLOG(5); err_no = MSG_PLUCHECK_EXPLAIN; }
    if ((err_no == OK) && (rcCheck_ScanWtCheck() )) { rcERLOG(31); err_no = MSG_WTPLUCHECK_EXPLAIN; }
    */
    if (CompileFlag.SELF_GATE) {
      if ((cBuf.dbTrm.ticketOpeWithoutQs != 0) && !(await RcSysChk.rcSGChkSelfGateSystem())) {
        if ((errNo == OK) && (!rcCheckPsWdKyMenu())) {
          await rcErLog(4);
          errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
        }
      } else {
        if ((errNo == OK) && (!RcSysChk.rcCheckRegFnal())) {
          await rcErLog(4);
          errNo = DlgConfirmMsgKind.MSG_REGERROR_EXPLAIN.dlgId;
        }
      }
    } else {
      if (cBuf.dbTrm.ticketOpeWithoutQs != 0) {
        if ((errNo == OK) && (!rcCheckPsWdKyMenu())) {
          await rcErLog(4);
          errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
        }
      } else {
        if ((errNo == OK) && (!RcSysChk.rcCheckRegFnal())) {
          await rcErLog(4);
          errNo = DlgConfirmMsgKind.MSG_REGERROR_EXPLAIN.dlgId;
        }
      }
    }

    // TODO:00016 佐藤 必要な部分だけ先行実装、それ以外はコメントアウト
    /*
    if ((err_no == OK) && (rcChk_Spool_Exist()   )) { rcERLOG(6); err_no = MSG_CLEAROFF;   }
    if ((err_no == OK) && (!rcCheck_Suspend()    )) { rcERLOG(7); err_no = MSG_SUSERROR_EXPLAIN;   }
    if ((err_no == OK) && (!rcCheck_Chkr_Sus()   )) { rcERLOG(8); err_no = MSG_SUSERROR_EXPLAIN;   }
    if ((err_no == OK) && (!rcCheck_Cash_Sus()   )) { rcERLOG(9); err_no = MSG_SUSERROR_EXPLAIN;   }
    if ((err_no == OK) && (rcCheck_RegDual()     )) { rcERLOG(10); err_no = MSG_TOWER_USING_ERR; }
    if ((err_no == OK) && (rcCheck_DualCshr_In() )) { rcERLOG(11); err_no = MSG_OPEBUSYERR; }
    if ((err_no == OK) && (rcCheck_ChkrEnd_Dual())) { rcERLOG(12); err_no = MSG_TOWER_USING_ERR; }
    if ((err_no == OK) && (rcCheck_Esvoid_Proc())) { rcERLOG(19); err_no = MSG_OPEBUSYERR; }
    if ((err_no == OK) && (rcCheck_KY_DISBURSE())) {rcERLOG(21); err_no = MSG_OPEBUSYERR; }
    if ((err_no == OK) && (!rcCheck_Chkr_Tab()   )) { rcERLOG(24); err_no = MSG_TABERROR_EXPLAIN; }
    if ((err_no == OK) && (!rcCheck_Cash_Tab()   )) { rcERLOG(25); err_no = MSG_TABERROR_EXPLAIN; }
    if((err_no == OK) && (rcky_SelPluAdj_SelctMode())) { rcERLOG(27); err_no = MSG_OPEBUSYERR; }
    #if CUSTREALSVR
    if( (rcChk_Custrealsvr_System() || rcChk_Custreal_Nec_System(0))&& (err_no == OK) ) {
    if ((CustRealSvr_WaitChk()) || (rcMcd_MbrWaitChk())) {
    err_no = MSG_MBRINQUIR;
    }
    else if( C_BUF->cust_offline == 1 ) {
    err_no = MSG_OPEBUSYERR;
    }
    }
    #endif
//  if ((err_no == OK) && (TS_BUF->multi.order      )) { rcERLOG(23); err_no = MSG_OPEBUSYERR; }
//  if(cm_PFM_PiTaPa_system() || cm_PFM_JR_IC_system()) {
//     if ((err_no == OK) && (TS_BUF->multi.order      ) && (TS_BUF->multi.flg & 0x40)) { rcERLOG(23); err_no = MSG_OPEBUSYERR; }
//  }
//  else {
    if(abs(RC_INFO_MEM->RC_CNCT.CNCT_MULTI_CNCT) != 4) {
    if ((err_no == OK) && (TS_BUF->multi.order      )) { rcERLOG(23); err_no = MSG_OPEBUSYERR; }
    }

    if ((err_no == OK) && (TS_BUF->suica.order      )) { rcERLOG(26); err_no = MSG_OPEBUSYERR; }
    if((err_no == OK) && (rc_Check_WizAdj_System())) {
    if(stat == 1) {  /* Check Only */
    return(OK);
    }
    else {
//        if((rcKy_Self() == KY_CHECKER) && ((TS_BUF->chk.fnc_code == KY_MENU) || (TS_BUF->chk.fnc_code == KY_CMOD))) {
    if((rcKy_Self() == KY_CHECKER) && (! rcCheck_QCJC_System()) && ((TS_BUF->chk.fnc_code == KY_MENU) || (TS_BUF->chk.fnc_code == KY_CMOD) || (TS_BUF->chk.fnc_code == KY_STAFF_REPT))) {
    rcERLOG(28);
    err_no = MSG_OPEBUSYERR;
    }
    else if((rcKy_Self() == KY_DUALCSHR) && ((TS_BUF->cash.fnc_code == KY_MENU) || (TS_BUF->cash.fnc_code == KY_CMOD) || (TS_BUF->cash.fnc_code == KY_STAFF_REPT))) {
    rcERLOG(29);
    err_no = MSG_OPEBUSYERR;
    }
    }
    }
    if ((err_no == OK) && (rcCheck_QCJC_System()) && (TS_BUF->cash.qcjc_j_stat == 1)) { rcERLOG(32); err_no = MSG_OPEBUSYERR; }
    if ((err_no == OK) && (TS_BUF->cash.regstart_chkflg == 1)) { rcERLOG(34); err_no = MSG_OPEBUSYERR; }
    if ((err_no == OK) && (TS_BUF->chk.errstat_flag == 1)) { rcERLOG(35); err_no = MSG_OPEBUSYERR; }
    if (   (err_no == OK)
    && (TS_BUF->cash.comltd_flg == 1))
    {
    rcERLOG(36);
    err_no = MSG_OPEBUSYERR;
    }

    if(stat == 1) {  /* Check Only */
    return(err_no);
    }

    // ======================
    //   終了シグナルを通知
    // ======================
    /* this line is always last check,if this line is ok then cashier is die */
    if ((err_no == OK) && (rcCheck_CashEnd()     )) { rcERLOG(13); err_no = MSG_DESKTOP_USING_ERR; }
    if ((err_no == OK) && (C_BUF->kymenu_up_flg == 2)) { rcERLOG(22); err_no = MSG_OPEBUSYERR; }
    */
    return errNo;
  }

  /// 関連tprxソース: rckymenu.c - rcERLOG
  static Future<void> rcErLog(int num) async {

    String buf = "";
    switch (num) {
      // TODO:00016 佐藤 必要な部分だけ先行実装、それ以外はコメントアウト
      /*
      case 1: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_Clerk() error"); break;
      case 2: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_Calc_Tend() error"); break;
      case 3:
        sprintf(buf, "rcCheck_Error() error[%d][%d]", CMEM->ent.err_stat, TS_BUF->chk.err_stat);
        TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, buf);
        break;
       */
      case 4:
        buf = "rcCheck_RegFnal() error";
        break;
      // TODO:00016 佐藤 必要な部分だけ先行実装、それ以外はコメントアウト
      /*
      case 5: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_ScanCheck() error"); break;
      case 6: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcChk_Spool_Exist() error"); break;
      case 7: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_Suspend() error"); break;
      case 8: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_Chkr_Sus() error"); break;
      case 9: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_Cash_Sus() error"); break;
      case 10: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_RegDual() error"); break;
      case 11: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_DualCshr_In() error"); break;
      case 12: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_ChkrEnd_Dual() error"); break;
      case 13: sprintf(buf, "rcCheck_CashEnd() error[%d][%d][%d]", TS_BUF->cash.stat, TS_BUF->cash.err_stat, TS_BUF->cash.staff_pw);
      TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, buf);
      break;
      case 14: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_ChkrEnd() error"); break;
      case 15: sprintf(buf, "C_BUF->db_trm.frc_clk_flg[%d] error", C_BUF->db_trm.frc_clk_flg);
      TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, buf);
      break;
      case 16: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_CheckerErr() error"); break;
      case 17: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_DualCshrIn() error"); break;
      case 18: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "FB2GTK DUALCASHIER END WAIT error"); break;
      case 19: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "ESVOID END WAIT error"); break;
      case 20: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "RWC ORDER error"); break;
      case 21: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "DISBURSE error"); break;
      case 22: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "ACX END WAIT error"); break;
      case 23: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "MULTI ORDER error"); break;
      case 24: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_Chkr_Tab() error"); break;
      case 25: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_Cash_Tab() error"); break;
      case 26: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "SUICA ORDER error"); break;
      case 27: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "Sel Plu Adj Selecting error"); break;
      case 28: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "WizAdj[KY_CHECKER] error"); break;
      case 29: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "WizAdj[KY_DUALCSHR] error"); break;
      case 30: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "RWC STAT error"); break;
      case 31: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCheck_ScanWtCheck() error"); break;
      case 32: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "TS_BUF->cash.qcjc_j_stat error"); break;
      case 33: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "AT_SING->limit_amount exist error"); break;
      case 34: sprintf(buf, "TS_BUF->cash.regstart_chkflg error doc_mem_stat[%d]", CMEM->ent.doc_mem_stat);
      TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, buf);
      break;
      case 35: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "TS_BUF->chk.errstat_flag error"); break;
      case 36: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "TS_BUF->cash.comltd_flg error"); break;
      case 37: TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rckymenu_status[KY_PCHG] error"); break;
       */
      default:
        buf = "default call invalid parameter";
        break;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, buf);
  }

  /// 関連tprxソース: rckymenu.c - rcCheck_Pswd_Ky_Menu
  static bool rcCheckPsWdKyMenu() {
    String passNo = "";

    // 共有メモリ取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (cBuf.edySeterrFlg == 1) {
      cBuf.edySeterrFlg = 2;
      RcSet.rcClearEntry();
      return false;
    }

    if (cBuf.dbTrm.offmodePasswd == 0) {
      Ltobcd.cmLtobcd(9999, passNo.length);
    } else {
      Ltobcd.cmLtobcd(cBuf.dbTrm.offmodePasswd, passNo.length);
    }

    if ((cMem.ent.entry[0] == 0x00) && (cMem.ent.entry[1] == 0x00) &&
        (cMem.ent.entry[2] == 0x00) && (cMem.ent.entry[3] == 0x00) &&
        (cMem.ent.entry[4] == 0x00) && (cMem.ent.entry[5] == 0x00) &&
        (cMem.ent.entry[6] == 0x00) && (cMem.ent.entry[7] == 0x00) &&
        (cMem.ent.entry[8].toString() == passNo[0]) && (cMem.ent.entry[9].toString() == passNo[1]))	{
      RcSet.rcClearEntry();
      return false;
    } else {
      return true;
    }
  }

  /// todo 動作未確認
  /// 関連tprxソース: rckymenu.c - rcCheck_DualCshr_In
  static Future<bool> rcCheckDualCshrIn() async
  {
    RxMemRet xRetTsBuf = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetTsBuf.isInvalid()) {
      return false;
    }
    RxTaskStatBuf tsBuf = xRetTsBuf.object;

    return((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) && (tsBuf.cash.menukey_flg == 1));
  }

}
