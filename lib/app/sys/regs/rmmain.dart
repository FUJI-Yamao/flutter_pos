/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/inc/apl/compflag.dart';


import '../../drv/scan/drv_scan_com.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_did.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/cm_sys/cm_stf.dart';
import '../../lib/cm_jan/prod_jan.dart';
import '../../lib/cm_jan/set_jinf.dart';
import '../../lib/cm_ean/cdigt.dart';
import '../../common/cls_conf/custreal_ajsJsonFile.dart';
import '../../common/cmn_sysfunc.dart';


class Code128_inf {
  int     bar2type = 0;          // 二段バーコードフラグ
  String  Org_Code = "";         // [ASC_EAN_26];     /* Original 2 barcode */
  int     digit = 0;                                  /* Enable digit */
  String  Code1 = "";            // [ASC_EAN_13];     /* JAN code 1 (ASCII) */
  String  Code2 = "";            // [ASC_EAN_13];     /* JAN code 2 (ASCII) */
  String  Org_Code_SalLmt = "";  // [ASC_CODE128_28]; /* Original 2 barcode */
  String  SalLmtDay = "";        // [8];              /* Sale Limit Day       */
  String	Org_Code_Prod = "";    // [ASC_EAN_26];	    // 20桁生産者バーコード
}

class DevNotifyScannerRet {
  int result = 0;
  RxInputBuf inp = RxInputBuf();
}


class Rmmain {
  static const TRUE  = 1;
  static const FALSE = 0;

  static int SysMenuStatus_Save = 0;
  static int SysMenuStatus_Save2 = 0;	//SysMenuStatus -> SysMenuStatus_Save(FenceOver) -> SysMenuStatus_Save2(CashRecycle)
  static int fence_over_status_cnt = 0;
  static int fence_over_event_typ_chk = 0;
  static int fence_over_event_typ_cash = 0;
  static int cash_recycle_status_cnt = 0;
  static int cash_recycle_event_typ_chk = 0;
  static int cash_recycle_event_typ_cash = 0;

  static RxInputBuf cloneBuf(RxInputBuf inp) {
    RxInputBuf inp0 = RxInputBuf();
    inp0.ctrl.ctrl     = inp.ctrl.ctrl;
    inp0.ctrl.filter     = inp.ctrl.filter;
    inp0.devInf.devId   = inp.devInf.devId;
    inp0.devInf.stat   = inp.devInf.stat;
    inp0.devInf.data   = inp.devInf.data;
    inp0.devInf.filler   = inp.devInf.filler;
    inp0.devInf.adonCd   = inp.devInf.adonCd;
    inp0.devInf.itfAmt   = inp.devInf.itfAmt;
    inp0.devInf.salelmt   = inp.devInf.salelmt;
    inp0.devInf.barCdLen   = inp.devInf.barCdLen;
    inp0.devInf.barData   = inp.devInf.barData;
    inp0.devInf.bcdSeqNo   = inp.devInf.bcdSeqNo;
    inp0.hardKey    = inp.hardKey;
    inp0.mecData    = inp.mecData;
    inp0.funcCode   = inp.funcCode;
    inp0.smlclsCd   = inp.smlclsCd;
    inp0.appGrpCd   = inp.appGrpCd;
    inp0.inst       = inp.inst;
    inp0.rxMemIndex = inp.rxMemIndex;
    return inp0;
  }


  /// 関数名　　：regHappyInputCashierChk
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 戻り値:0：Checker、：1：Cashier
  ///
  /// 機能概要　：HappySelf次客登録中、Cashierに振り分けるイベントをチェック
  ///
  /// 関連tprxソース: rmmain.c - Reg_HappyInputCashierChk()
  static int regHappyInputCashierChk(TprMsgDevNotify_t? notify) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "regHappyInputCashierChk (RX_TASKSTAT_BUF) error !!\n");
      return (0);
    }
    if (notify == null) {
      return (0);
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if (tsBuf.chk.tab_active == 1) {
      if ((notify.tid == TprDidDef.TPRDIDSCANNER2) && // スキャナ2かつコード決済入力待ち
          ((tsBuf.bcdpay.scan_flg == 1) || (tsBuf.repica.scan_flg == 1))) {
        return (1);
      }
    }
    return (0);
  }

  /// 関数:	簡易従業員のキャッシャーへの入力データか判断
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[pCom] 共有メモリ
  ///
  /// 戻値:	上記ならTRUE. それ以外ならFALSE
  ///
  /// 関連tprxソース: rmmain.c - ChkInputToSimpleCashier()
  static Future<int> chkInputToSimpleCashier(TprMsgDevNotify_t notify, RxCommonBuf pCom) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);

    if ((await CmStf.cmPersonChk() == 2) && (pCom.iniSys_tower)) {
      return	TRUE;
    }
    if((await CmStf.cmPersonChk() == 2) && (await CmCksys.cmDesktopCashierSystem() == 1)) {
      if (xRet.isInvalid()) {
        TprLog().logAdd(0, LogLevelDefine.error,
            "chkInputToSimpleCashier(RX_TASKSTAT_BUF) error !!\n");
        return  TRUE;
      }
      RxTaskStatBuf tsBuf = xRet.object;
      if ((tsBuf.chk.tab_active == 1) &&
          (regHappyInputCashierChk(notify) == 0)) {
        return  FALSE;
      }
      else {
        return  TRUE;
      }
    }
    return	FALSE;
  }

  /// 関数:	キャッシャーへの入力データか判断
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[pCom] 共有メモリ
  ///
  /// 戻値:	上記ならTRUE. それ以外ならFALSE
  ///
  /// 関連tprxソース: rmmain.c - ChkInputToCashier()
  static Future<int> chkInputToCashier(TprMsgDevNotify_t? notify, RxCommonBuf pCom) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);

    if(((pCom.dbStaffopen.chkr_status == 1) && (pCom.iniSys_tower == true))) {
      return	TRUE;
    }
    if((pCom.dbStaffopen.chkr_status == 1) && (await CmCksys.cmDesktopCashierSystem() != 0)) {
      if (xRet.isInvalid()) {
        TprLog().logAdd(0, LogLevelDefine.error,
            "chkInputToCashier(RX_TASKSTAT_BUF) error !!\n");
        return	TRUE;
      }
      RxTaskStatBuf tsBuf = xRet.object;
      if((tsBuf.chk.tab_active == 1) && (regHappyInputCashierChk(notify) == 0)) {
        return	FALSE;
      } else {
        return	TRUE;
      }
    }
    return	FALSE;
  }
  /*
  /**********************************************************************
      関数：int rmMain(void)
      機能：登録モード選択時のメイン関数
      引数：なし
      戻値：0:終了
  ***********************************************************************/
  int rmMain(void)
  {
    RX_INPUT_BUF	inp_buf;
    int		i;
    int		num;
    RX_TASKSTAT_BUF *TS_BUF;

  #ifdef FB2GTK
    RX_COMMON_BUF	*pCom;

    rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  #else
  #if SIMPLE_2STAFF  /* 2004.01.13 */
    RX_COMMON_BUF	*pCom;

    rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  #endif
  #endif
    rxMemPtr(RXMEM_STAT, (void **)&TS_BUF);
  #if SIMPLE_2STAFF  /* 2004.01.13 */
    /*if(pCom->db_trm.frc_clk_flg == 2)*/
    if(cmChk2PersonSystem() == 2) /* 2011/02/09 */
    {
      cmPersonSet(2);	/* 2011/02/09 */
      if((pCom->db_staffopen.chkr_status == 0) && (pCom->db_staffopen.cshr_status == 0)) {
        cmPersonSet(1);
      }
      /* >>> 2011/02/09 */
      else if((pCom->db_staffopen.chkr_status == 0) && (pCom->db_staffopen.cshr_status == 1)) {
        cmPersonSet(1);
      }/* 2011/02/09 <<< */

      if(cmDesktopCashierSystem())
      {
        if( !AplLib_Auto_StrCls(0) )
        {
          cmPersonSet(2);
        }
      }
    }
  #endif
    memset( &TS_BUF->qcconnect, 0x00, sizeof(TS_BUF->qcconnect) );
    // QCashier用
    for( num = 0; num < QCCONNECT_MAX; num++ )
    {
      TS_BUF->qcconnect.ConStatus[num].QcStatus = 0; //初期値をセット
      TS_BUF->qcconnect.ConStatus[num].CautionStatus = 0; //初期値をセット
    }

    TS_BUF->qcconnect.MyStatus.OpeMode  = pCom->ini_macinfo.mode;

    for(i=0;i<RETRY_COUNT_MAX;i++) {
      if (rxMemDataChk(RXMEM_PROCINST) == RXMEM_DATA_OFF) {
        memset(&inp_buf, 0, sizeof(inp_buf));
        inp_buf.Ctrl.ctrl = 1;
        inp_buf.inst = RX_REGSINST_START;
        rxMemWrite(RXMEM_PROCINST, &inp_buf);
        rxQueueWrite(RXQUEUE_PROCINST);
        break;
      }
      usleep(SLEEP_TIME); /* 10ms */
    }
    if(i>=RETRY_COUNT_MAX){
      TprLibLogWrite(0, TPRLOG_ERROR, 0, "rmmain regs start retry over");
    }

  #if SIMPLE_2STAFF  /* 2004.01.13 */
    /*if((pCom->db_trm.frc_clk_flg == 2) && (cm_person_chk() == 2))*/
    if((cmChk2PersonSystem() == 2) && (cm_person_chk() == 2))	/* 2011/02/09 */
    { /* two person */
  //		TprLibLogWrite(0, TPRLOG_NORMAL, 0, "rmmain simple 2staff 2person start");
      for(i=0;i<RETRY_COUNT_MAX;i++) {
        if(rxMemDataChk(RXMEM_PROCINST) == RXMEM_DATA_OFF) {
  //				TprLibLogWrite(0, TPRLOG_NORMAL, 0, "rmmain simple 2staff rxmemDataChk() ON");
          memset(&inp_buf, 0x0, sizeof(inp_buf));
          inp_buf.Ctrl.ctrl = 1;
          inp_buf.inst = RX_SIMPLE2STF_START;
          if(rxMemWrite(RXMEM_PROCINST, &inp_buf) == RXMEM_OK) {
  //			 		TprLibLogWrite(0, TPRLOG_NORMAL, 0, "rmmain simple 2staff rxmemDataChk() OK");
            rxQueueWrite(RXQUEUE_PROCINST);
            break;
          }
        }
        usleep(SLEEP_TIME); /* 10ms */
  //			printf("i = %d\n", i);
      }
      if(i>=RETRY_COUNT_MAX){
        TprLibLogWrite(0, TPRLOG_ERROR, 0, "rmmain simple 2staff retry over");
      }
    }
  #endif

  /* 2002/11/22 */
    for(i=0;i<RETRY_COUNT_MAX;i++)
    {
      if (rxMemDataChk(RXMEM_CHK_INP) == RXMEM_DATA_OFF) {
  #ifdef FB2GTK
        fb_bfreset_pid();
  #endif
        memset(&inp_buf, 0, sizeof(inp_buf));
        inp_buf.Ctrl.ctrl = 1;
        inp_buf.inst = RX_REGSINST_START;
        rxMemWrite(RXMEM_CHK_INP, &inp_buf);
        rxQueueWrite(RXQUEUE_CHK);
        break;
      }
      usleep(SLEEP_TIME); /* 10ms */
    }
    if(i>=RETRY_COUNT_MAX){
      TprLibLogWrite(0, TPRLOG_ERROR, 0, "rmmain checker start retry over");
    }
  /* 2002/11/22 */
  #ifdef FB2GTK
    if(   ((pCom->db_staffopen.chkr_status == 1) && (cm_chk_tower() == TPR_TYPE_TOWER))
       || ((pCom->db_staffopen.chkr_status == 1) && (cmDesktopCashierSystem())) )
    {
      TprLibLogWrite(0, TPRLOG_NORMAL, 0, "rmmain fb cashier start 1");
      for(i=0;i<RETRY_COUNT_MAX;i++)
      {
        if (rxMemDataChk(RXMEM_CASH_INP) == RXMEM_DATA_OFF) {
          memset(&inp_buf, 0, sizeof(inp_buf));
          inp_buf.Ctrl.ctrl = 1;
          inp_buf.inst = RX_REGSINST_START;
          rxMemWrite(RXMEM_CASH_INP, &inp_buf);
          rxQueueWrite(RXQUEUE_CASH);
          break;
        }
        usleep(SLEEP_TIME); /* 10ms */
      }
      if(i>=RETRY_COUNT_MAX){
        TprLibLogWrite(0, TPRLOG_ERROR, 0, "rmmain fb cashier 1 retry over");
      }
    }
  #if SIMPLE_2STAFF
    /*else if((pCom->db_trm.frc_clk_flg == 2) && (cm_person_chk() == 2))*/
    else if( (cmChk2PersonSystem() == 2) && (cm_person_chk() == 2) ) /* 2011/02/09 */
    { /* two person */
      TprLibLogWrite(0, TPRLOG_NORMAL, 0, "rmmain fb cashier start 2");
      for(i=0;i<RETRY_COUNT_MAX;i++)
      {
        if (rxMemDataChk(RXMEM_CASH_INP) == RXMEM_DATA_OFF) {
          memset(&inp_buf, 0, sizeof(inp_buf));
          inp_buf.Ctrl.ctrl = 1;
          inp_buf.inst = RX_REGSINST_START;
          rxMemWrite(RXMEM_CASH_INP, &inp_buf);
          rxQueueWrite(RXQUEUE_CASH);
          break;
        }
        usleep(SLEEP_TIME); /* 10ms */
      }
      if(i>=RETRY_COUNT_MAX){
        TprLibLogWrite(0, TPRLOG_ERROR, 0, "rmmain fb cashier 2 retry over");
      }
    }
  #endif
  #endif
  #if 0
    RX_INPUT_BUF	inp_buf;    /* チェッカー受渡し */
    RX_COMMON_BUF	*pCom;

    rxMemPtr(RXMEM_COMMON, (void **)&pCom);

  #if _RMMAIN_C_DEBUG_
    log_printf("登録メイン関数呼び出し -> ");
  #endif

      /* チェッカー起動 */
    if (rxMemDataChk(RXMEM_CHK_INP) == RXMEM_DATA_OFF) {
      memset(&inp_buf, 0, sizeof(inp_buf));
      inp_buf.Ctrl.ctrl = 1;
      inp_buf.inst = RX_REGSINST_START;
      rxMemWrite(RXMEM_CHK_INP, &inp_buf);

  #if _RMMAIN_C_DEBUG_
      log_printf("チェッカー起動通知 -> ");
  #endif

      rxQueueWrite(RXQUEUE_CHK);
    }

      /* チェッカー起動 */
    if (pCom->db_staffopen.chkr_status == 1) { /* 01/01/31 F.Saitoh '=1'->'==1' */
      if (rxMemDataChk(RXMEM_CASH_INP) == RXMEM_DATA_OFF) {
        memset(&inp_buf, 0, sizeof(inp_buf));
        inp_buf.Ctrl.ctrl = 1;
        inp_buf.inst = RX_REGSINST_START;
        rxMemWrite(RXMEM_CASH_INP, &inp_buf);

  #if _RMMAIN_C_DEBUG_
        log_printf("キャッシャー起動通知 -> ");
  #endif

        rxQueueWrite(RXQUEUE_CASH);
      }
    }

  #if _RMMAIN_C_DEBUG_
    log_printf("登録メイン関数終了\n");
  #endif
  #endif
    return 0;
  }


  /**********************************************************************
      関数：int rmMainEventMain(ucahr *p)
      機能：登録モードイベントメイン関数
      引数：uchar *p デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  int rmMainEventMain(unsigned char *p)
  {
    tprmsgdevnotify_t *notify;
    char	erlog[128];

    notify = (tprmsgdevnotify_t *)p;

  #if _RMMAIN_C_DEBUG_
    event_print(p);
  #endif

    memset(erlog, 0x0, sizeof(erlog));
      /* イベント種類別に振り分け */
    switch (notify->mid) {
      case TPRMID_DEVACK:
        snprintf(erlog, sizeof(erlog), "%s TPRMID_DEVACK tid[%lx]\n",
          __FUNCTION__, ((tprmsgdevack_t *)p)->tid);
        DevAckMain((tprmsgdevack_t *)p);
        break;
      case TPRMID_DEVNOTIFY:
        snprintf(erlog, sizeof(erlog), "%s TPRMID_DEVNOTIFY tid[%lx]\n",
          __FUNCTION__, ((tprmsgdevack_t *)p)->tid);
        DevNotifyMain((tprmsgdevack_t *)p);
        break;
      case TPRMID_APLNOTIFY:
        snprintf(erlog, sizeof(erlog), "%s TPRMID_APLNOTIFY errnum[%x]\n",
          __FUNCTION__, ((tprapl_t *)p)->errnum);
        AplNotifyMain((tprapl_t *)p);
        break;
      case TPRMID_APLACK:
        snprintf(erlog, sizeof(erlog), "%s TPRMID_APLACK result[%x]\n",
          __FUNCTION__, ((tprmsgdevack2_t *)p)->result);
        AplAckMain((tprmsgdevack2_t *)p);
        break;
      default:
        snprintf(erlog, sizeof(erlog), "%s default mid[%lx]\n",
          __FUNCTION__, notify->mid);
        break;
    }
    TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);

    return 0;
  }


  /**********************************************************************
      関数：int DevNotifyMain(tprmsgdevnotify_t *notify)
      機能：デバイス非同期イベントメイン関数
      引数：tprmsgdevnotify_t *notify デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevNotifyMain(tprmsgdevnotify_t *notify)
  {
  #if SIMPLE_2STAFF
    RX_COMMON_BUF	*pCom;

    rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  #endif
          if (! ((notify->tid == TPRDIDTOKYURW1) ||
                 (notify->tid == TPRDIDTOKYURW2) ||
                 (notify->tid == TPRDIDTOKYURW3) ||
                 (notify->tid == TPRDIDTOKYURW4) ||
                 (notify->tid == TPRDIDTOKYURW5) ||
                 (notify->tid == TPRDIDTOKYURW6) ||
                 (notify->tid == TPRDIDORC1) ||
                 (notify->tid == TPRDIDORC2) ||
                 (notify->tid == TPRDIDORC3) ||
                 (notify->tid == TPRDIDORC4) ||
                 (notify->tid == TPRDIDORC5) ||
                 (notify->tid == TPRDIDORC6) ||
           (notify->tid == TPRDIDCALLSW1) ||
           (notify->tid == TPRDIDCALLSW2) ||
           (notify->tid == TPRDIDCALLSW3) ||
           (notify->tid == TPRDIDCALLSW4) ||
           (notify->tid == TPRDIDCALLSW5) ||
           (notify->tid == TPRDIDCALLSW6) ||
           (notify->tid == TPRDIDDETECT1) ||
           (notify->tid == TPRDIDDETECT2) ||
           (notify->tid == TPRDIDDETECT3) ||
           (notify->tid == TPRDIDDETECT4) ||
           (notify->tid == TPRDIDDETECT5) ||
           (notify->tid == TPRDIDDETECT6) ||
                 (notify->tid == TPRDIDVISMAC1)  ||
                 (notify->tid == TPRDIDVISMAC2)  ||
                 (notify->tid == TPRDIDVISMAC3)  ||
                 (notify->tid == TPRDIDVISMAC4)  ||
                 (notify->tid == TPRDIDVISMAC5)  ||
                 (notify->tid == TPRDIDVISMAC6)  ||
                 (notify->tid == TPRDIDEDY1) ||
                 (notify->tid == TPRDIDEDY2) ||
                 (notify->tid == TPRDIDEDY3) ||
                 (notify->tid == TPRDIDEDY4) ||
                 (notify->tid == TPRDIDEDY5) ||
                 (notify->tid == TPRDIDEDY6) ||
                 (notify->tid == TPRDIDCRWP1) ||
                 (notify->tid == TPRDIDCRWP2) ||
                 (notify->tid == TPRDIDCRWP3) ||
                 (notify->tid == TPRDIDCRWP4) ||
                 (notify->tid == TPRDIDCRWP5) ||
                 (notify->tid == TPRDIDCRWP6) ||
                 (notify->tid == TPRDIDPANA1) ||
                 (notify->tid == TPRDIDPANA2) ||
                 (notify->tid == TPRDIDPANA3) ||
                 (notify->tid == TPRDIDPANA4) ||
                 (notify->tid == TPRDIDPANA5) ||
                 (notify->tid == TPRDIDPANA6) ||
                 (notify->tid == TPRDIDPW1) ||
                 (notify->tid == TPRDIDPW2) ||
                 (notify->tid == TPRDIDPW3) ||
                 (notify->tid == TPRDIDPW4) ||
                 (notify->tid == TPRDIDPW5) ||
                 (notify->tid == TPRDIDPW6) ||
  // <2004.07.15> mn
                 (notify->tid == TPRDIDCCR1) ||
                 (notify->tid == TPRDIDCCR2) ||
                 (notify->tid == TPRDIDCCR3) ||
                 (notify->tid == TPRDIDCCR4) ||
                 (notify->tid == TPRDIDCCR5) ||
                 (notify->tid == TPRDIDCCR6) ||
                 (notify->tid == TPRDIDSUICA1) ||
                 (notify->tid == TPRDIDSUICA2) ||
                 (notify->tid == TPRDIDSUICA3) ||
                 (notify->tid == TPRDIDSUICA4) ||
                 (notify->tid == TPRDIDSUICA5) ||
                 (notify->tid == TPRDIDSUICA6) ||
                 (notify->tid == TPRDIDCHANGER1) ||
                 (notify->tid == TPRDIDCHANGER2) ||
                 (notify->tid == TPRDIDCHANGER3) ||
                 (notify->tid == TPRDIDCHANGER4) ||
                 (notify->tid == TPRDIDCHANGER5) ||
                 (notify->tid == TPRDIDCHANGER6) ||
                 (notify->tid == TPRDIDMECKEY4)  ||
                 (notify->tid == TPRDIDMECKEY6)  ||
                 (notify->tid == TPRDIDMASR3)  ||
                 (notify->tid == TPRDIDFCL1) ||
                 (notify->tid == TPRDIDFCL2) ||
                 (notify->tid == TPRDIDFCL3) ||
                 (notify->tid == TPRDIDFCL4) ||
                 (notify->tid == TPRDIDFCL5) ||
                 (notify->tid == TPRDIDFCL6) ||
           (notify->tid == TPRDIDICCARD1) ||
           (notify->tid == TPRDIDICCARD2) ||
           (notify->tid == TPRDIDICCARD3) ||
           (notify->tid == TPRDIDICCARD4) ||
           (notify->tid == TPRDIDICCARD5) ||
           (notify->tid == TPRDIDICCARD6) ||
           (notify->tid == TPRDIDPSENSOR1) ||
           (notify->tid == TPRDIDPSENSOR2) ||
           (notify->tid == TPRDIDPSENSOR3) ||
           (notify->tid == TPRDIDPSENSOR4) ||
           (notify->tid == TPRDIDPSENSOR5) ||
           (notify->tid == TPRDIDPSENSOR6) ||
                 (notify->tid == TPRDIDAPBF1)    ||
           (notify->tid == TPRDIDSCALERM1) ||
           (notify->tid == TPRDIDSCALERM2) ||
           (notify->tid == TPRDIDSCALERM3) ||
           (notify->tid == TPRDIDSCALERM4) ||
           (notify->tid == TPRDIDSCALERM5) ||
           (notify->tid == TPRDIDSCALERM6) ||
                 (notify->tid == TPRDIDEXC1)     ||
                 (notify->tid == TPRDIDHITOUCH1) ||
           (notify->tid == TPRDIDAMI1))    ||
                 (notify->tid == TPRDIDSCALE_SKS1) ||
                 (notify->tid == TPRDIDSCALE_SKS2) ||
                 (notify->tid == TPRDIDSCALE_SKS3) ||
                 (notify->tid == TPRDIDSCALE_SKS4) ||
                 (notify->tid == TPRDIDSCALE_SKS5) ||
                 (notify->tid == TPRDIDSCALE_SKS6) )

  // -----
          {
      /* コマンドIDチェック */
      if (notify->data[0] != 0x01) {
        return 0;
      }
          }
  #if SIMPLE_2STAFF
    /*if((pCom->db_trm.frc_clk_flg == 2) && (pCom->stf2.twoperson_key_flag != 0))*/
    if((cmChk2PersonSystem() == 2) && (pCom->stf2.twoperson_key_flag != 0)) /* 2011/02/09 */
    {
      return 0;
    }
  #endif
    switch(notify->tid) {
      case TPRDIDMECKEY1:
      case TPRDIDMECKEY2:
      case TPRDIDMECKEY3:
      case TPRDIDMECKEY4:
      case TPRDIDMECKEY5:
      case TPRDIDMECKEY6:
        DevNotifyMechaKeyMain(notify);
        break;

      case TPRDIDTOUKEY1:
      case TPRDIDTOUKEY2:
      case TPRDIDTOUKEY3:
      case TPRDIDTOUKEY4:
      case TPRDIDTOUKEY5:
      case TPRDIDTOUKEY6:
        DevNotifyTouchKeyMain(notify);
        break;

      case TPRDIDSPEAKER1:
      case TPRDIDSPEAKER2:
      case TPRDIDSPEAKER3:
      case TPRDIDSPEAKER4:
      case TPRDIDSPEAKER5:
      case TPRDIDSPEAKER6:
        break;

      case TPRDIDFIP1:
      case TPRDIDFIP2:
      case TPRDIDFIP3:
      case TPRDIDFIP4:
      case TPRDIDFIP5:
      case TPRDIDFIP6:
        break;

      case TPRDIDLCDDSP1:
      case TPRDIDLCDDSP2:
      case TPRDIDLCDDSP3:
      case TPRDIDLCDDSP4:
      case TPRDIDLCDDSP5:
      case TPRDIDLCDDSP6:
        break;

      case TPRDIDSCANNER1:
      case TPRDIDSCANNER2:
      case TPRDIDSCANNER3:
      case TPRDIDSCANNER4:
      case TPRDIDSCANNER5:
      case TPRDIDSCANNER6:
        devNotifyScannerMain(notify);
        break;

      case TPRDIDWDSCAN1:
      case TPRDIDWDSCAN2:
      case TPRDIDWDSCAN3:
      case TPRDIDWDSCAN4:
      case TPRDIDWDSCAN5:
      case TPRDIDWDSCAN6:
        devNotifyScannerMain(notify);
        break;

      case TPRDIDCHANGER1:
      case TPRDIDCHANGER2:
      case TPRDIDCHANGER3:
      case TPRDIDCHANGER4:
      case TPRDIDCHANGER5:
      case TPRDIDCHANGER6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDCOMUSB1:
      case TPRDIDCOMUSB2:
      case TPRDIDCOMUSB3:
      case TPRDIDCOMUSB4:
      case TPRDIDCOMUSB5:
      case TPRDIDCOMUSB6:
        break;

      case TPRDIDRECEIPT1:
      case TPRDIDRECEIPT2:
      case TPRDIDRECEIPT3:
      case TPRDIDRECEIPT4:
      case TPRDIDRECEIPT5:
      case TPRDIDRECEIPT6:
        break;

      case TPRDIDTOKYURW1:
      case TPRDIDTOKYURW2:
      case TPRDIDTOKYURW3:
      case TPRDIDTOKYURW4:
      case TPRDIDTOKYURW5:
      case TPRDIDTOKYURW6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDDEBIT1:
      case TPRDIDDEBIT2:
      case TPRDIDDEBIT3:
      case TPRDIDDEBIT4:
      case TPRDIDDEBIT5:
      case TPRDIDDEBIT6:
        break;

      case TPRDIDGLORYCARD1:
      case TPRDIDGLORYCARD2:
      case TPRDIDGLORYCARD3:
      case TPRDIDGLORYCARD4:
      case TPRDIDGLORYCARD5:
      case TPRDIDGLORYCARD6:
        break;

      case TPRDIDVISMAC1:
      case TPRDIDVISMAC2:
      case TPRDIDVISMAC3:
      case TPRDIDVISMAC4:
      case TPRDIDVISMAC5:
      case TPRDIDVISMAC6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDPRSP1:
      case TPRDIDPRSP2:
      case TPRDIDPRSP3:
      case TPRDIDPRSP4:
      case TPRDIDPRSP5:
      case TPRDIDPRSP6:
        break;

      case TPRDIDMGC1JIS1:
      case TPRDIDMGC2JIS1:
      case TPRDIDMGC3JIS1:
      case TPRDIDMGC4JIS1:
      case TPRDIDMGC5JIS1:
      case TPRDIDMGC6JIS1:
        DevNotifyMagCard_JIS(notify);
        break;

      case TPRDIDMGC1JIS2:
      case TPRDIDMGC2JIS2:
      case TPRDIDMGC3JIS2:
      case TPRDIDMGC4JIS2:
      case TPRDIDMGC5JIS2:
      case TPRDIDMGC6JIS2:
        DevNotifyMagCard_JIS(notify);
        break;

      case TPRDIDGCAT1:
      case TPRDIDGCAT2:
      case TPRDIDGCAT3:
      case TPRDIDGCAT4:
      case TPRDIDGCAT5:
      case TPRDIDGCAT6:
        break;

      case TPRDIDPRT1:
      case TPRDIDPRT2:
      case TPRDIDPRT3:
      case TPRDIDPRT4:
      case TPRDIDPRT5:
      case TPRDIDPRT6:
        break;

      case TPRDIDLCDBRT1:
      case TPRDIDLCDBRT2:
      case TPRDIDLCDBRT3:
      case TPRDIDLCDBRT4:
      case TPRDIDLCDBRT5:
      case TPRDIDLCDBRT6:
        break;

      case TPRDIDSCALE1:
      case TPRDIDSCALE2:
      case TPRDIDSCALE3:
      case TPRDIDSCALE4:
      case TPRDIDSCALE5:
      case TPRDIDSCALE6:
        break;

      case TPRDIDORC1:
      case TPRDIDORC2:
      case TPRDIDORC3:
      case TPRDIDORC4:
      case TPRDIDORC5:
      case TPRDIDORC6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDSGSCALE1:
      case TPRDIDSGSCALE2:
      case TPRDIDSGSCALE3:
      case TPRDIDSGSCALE4:
      case TPRDIDSGSCALE5:
      case TPRDIDSGSCALE6:
        break;

      case TPRDIDCALLSW1:
      case TPRDIDCALLSW2:
      case TPRDIDCALLSW3:
      case TPRDIDCALLSW4:
      case TPRDIDCALLSW5:
      case TPRDIDCALLSW6:
        DevNotifySG_Dev(notify);
        break;

      case TPRDIDDETECT1:
      case TPRDIDDETECT2:
      case TPRDIDDETECT3:
      case TPRDIDDETECT4:
      case TPRDIDDETECT5:
      case TPRDIDDETECT6:
        DevNotifySG_Dev(notify);
        break;

      case TPRDIDEDY1:
      case TPRDIDEDY2:
      case TPRDIDEDY3:
      case TPRDIDEDY4:
      case TPRDIDEDY5:
      case TPRDIDEDY6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDCRWP1:
      case TPRDIDCRWP2:
      case TPRDIDCRWP3:
      case TPRDIDCRWP4:
      case TPRDIDCRWP5:
      case TPRDIDCRWP6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDPANA1:
      case TPRDIDPANA2:
      case TPRDIDPANA3:
      case TPRDIDPANA4:
      case TPRDIDPANA5:
      case TPRDIDPANA6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDPW1:
      case TPRDIDPW2:
      case TPRDIDPW3:
      case TPRDIDPW4:
      case TPRDIDPW5:
      case TPRDIDPW6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

  // <2004.07.15> mn
      case TPRDIDCCR1:
      case TPRDIDCCR2:
      case TPRDIDCCR3:
      case TPRDIDCCR4:
      case TPRDIDCCR5:
      case TPRDIDCCR6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;
  // ------

      case TPRDIDSUICA1:
      case TPRDIDSUICA2:
      case TPRDIDSUICA3:
      case TPRDIDSUICA4:
      case TPRDIDSUICA5:
      case TPRDIDSUICA6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDSMTPLUS1:
      case TPRDIDSMTPLUS2:
      case TPRDIDSMTPLUS3:
      case TPRDIDSMTPLUS4:
      case TPRDIDSMTPLUS5:
      case TPRDIDSMTPLUS6:
        break;

      case TPRDIDMCP1:
      case TPRDIDMCP2:
      case TPRDIDMCP3:
      case TPRDIDMCP4:
      case TPRDIDMCP5:
      case TPRDIDMCP6:
        break;

      case TPRDIDFCL1:
      case TPRDIDFCL2:
      case TPRDIDFCL3:
      case TPRDIDFCL4:
      case TPRDIDFCL5:
      case TPRDIDFCL6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDABSV311:
      case TPRDIDABSV312:
      case TPRDIDABSV313:
      case TPRDIDABSV314:
      case TPRDIDABSV315:
      case TPRDIDABSV316:
        break;

      case TPRDIDYAMATO1:
      case TPRDIDYAMATO2:
      case TPRDIDYAMATO3:
      case TPRDIDYAMATO4:
      case TPRDIDYAMATO5:
      case TPRDIDYAMATO6:
        break;

      case TPRDIDCCT1:
      case TPRDIDCCT2:
      case TPRDIDCCT3:
      case TPRDIDCCT4:
      case TPRDIDCCT5:
      case TPRDIDCCT6:
        break;

      case TPRDIDMASR3:
        DevNotifyMASR_JIS((tprmsgdevack2_t *)notify);
        break;

      case TPRDIDJMUPS1:
      case TPRDIDJMUPS2:
      case TPRDIDJMUPS3:
      case TPRDIDJMUPS4:
      case TPRDIDJMUPS5:
      case TPRDIDJMUPS6:
        break;

                  case TPRDIDSQRC1:
                  case TPRDIDSQRC2:
                  case TPRDIDSQRC3:
                  case TPRDIDSQRC4:
                  case TPRDIDSQRC5:
                  case TPRDIDSQRC6:
                          break;

      case TPRDIDICCARD1:
      case TPRDIDICCARD2:
      case TPRDIDICCARD3:
      case TPRDIDICCARD4:
      case TPRDIDICCARD5:
      case TPRDIDICCARD6:
        DevNotifyICCard(notify);
        break;

      case TPRDIDPSENSOR1:
      case TPRDIDPSENSOR2:
      case TPRDIDPSENSOR3:
      case TPRDIDPSENSOR4:
      case TPRDIDPSENSOR5:
      case TPRDIDPSENSOR6:
        DevNotifySG_Dev(notify);
        break;

      case TPRDIDAPBF1:
        DevNotifySG_Dev(notify);
        break;

      case TPRDIDSCALERM1:
      case TPRDIDSCALERM2:
      case TPRDIDSCALERM3:
      case TPRDIDSCALERM4:
      case TPRDIDSCALERM5:
      case TPRDIDSCALERM6:
        DevNotifyScalermMain(notify);
        break;

                  case TPRDIDEXC1:
                          DevNotifySG_Dev(notify);
                          break;

                  case TPRDIDHITOUCH1:
                  case TPRDIDHITOUCH2:
                  case TPRDIDHITOUCH3:
                  case TPRDIDHITOUCH4:
                  case TPRDIDHITOUCH5:
                  case TPRDIDHITOUCH6:
        //DevNotifyScalermMain(notify);
        //DevNotifyHiTouchMain(notify);
        // sysMainGetEvent()でデータを受信
                          break;

                  case TPRDIDAMI1:
                  case TPRDIDAMI2:
                  case TPRDIDAMI3:
                  case TPRDIDAMI4:
                  case TPRDIDAMI5:
                  case TPRDIDAMI6:
                          devNotifyScannerMain(notify);
                          break;

      case TPRDIDSCALE_SKS1:
      case TPRDIDSCALE_SKS2:
      case TPRDIDSCALE_SKS3:
      case TPRDIDSCALE_SKS4:
      case TPRDIDSCALE_SKS5:
      case TPRDIDSCALE_SKS6:
        DevNotifyDataSend((tprmsgdevack2_t *)notify);
        break;
      default:
        break;
    }

    return 0;
  }

  /**********************************************************************
    Store Open/Close Main & Event
  ***********************************************************************/
  static int MenuStat;
  static void rmStoreOpenCloseMain(int inst)
  {
    RX_INPUT_BUF    inp_buf;
    RX_COMMON_BUF   *pCom;
    int             i;

    rxMemPtr(RXMEM_COMMON, (void **)&pCom);

    for(i=0; i<20; i++) {
      if(rxMemDataChk(RXMEM_PROCINST) == RXMEM_DATA_OFF) {
  #ifdef FB2GTK
        fb_bfreset_pid();
  #endif
        memset(&inp_buf, 0x0, sizeof(inp_buf));
        inp_buf.Ctrl.ctrl = 1;
        inp_buf.inst = inst;
        rxMemWrite(RXMEM_PROCINST, &inp_buf);
        rxQueueWrite(RXQUEUE_PROCINST);
        break;
      }
  //		printf("i = %d\n", i);
      usleep(100000);  /* 100ms */
    }
  }

  extern int rmStoreCloseMain(void)
  {
    MenuStat = SysMenuStatus;
    SysMenuStatus = TPRTST_STATUS17;
    rmStoreOpenCloseMain(RX_STRCLS_START);
    return 0;
  }

  extern int rmStoreOpenMain(int not_maindsp_flg)
  {
    int i;
    RX_TASKSTAT_BUF   *pStat;

    rxMemPtr(RXMEM_STAT, (void **)&pStat);

    pStat->stropn.stat = 0;
    SysMenuStatus = TPRTST_INIT;
    rmStoreOpenCloseMain(RX_STROPN_START);
    rmDbReadMain_Sub();
    for(i = 0; i < 15; i++) {
      if(pStat->stropn.stat != 0)
        break;
      sleep(1);
    }
    return 0;
  }

  static int rmStoreOpenCloseEventMain(unsigned char *p)
  {
    tprmsgdevnotify_t       *notify;
    tprmsgdevack2_t         *ack;
    tprapl_t		*apl;
    RX_INPUT_BUF            inp;
    char			confp[MAXPATHLEN];
    RX_TASKSTAT_BUF		*pStat;
    RX_COMMON_BUF           *pCom;
    char			tmpbuf[128];

    rxMemPtr(RXMEM_STAT, (void **)&pStat);
    rxMemPtr(RXMEM_COMMON, (void **)&pCom);

    if(pCom->rmst_info.rmst_freq == 2){
      TprLibLogWrite(0, TPRLOG_NORMAL, 0, "SYST:Event to Freq" );
      return( another_status(p, RXMEM_ANOTHER2, RXQUEUE_ANOTHER2) );
    }

    notify = (tprmsgdevnotify_t *)p;
    ack    = (tprmsgdevack2_t *)p;
    apl    = (tprapl_t *)p;

    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;

    switch(notify->mid) {
      case TPRMID_APLNOTIFY:
        switch((apl->errnum & RXSYS_MSG_MASK)) {
                                  case RXSYS_MSG_OPNST_ST:
                                          SysNotifySend( TPRTST_IDLE );
                                          SysMenuStatus = TPRTST_INIT;
                                          return 0;
          case RXSYS_MSG_OPNST:
            SysNotifySend( TPRTST_MENTE );
            SysMenuStatus = TPRTST_INIT;
            return 0;
          case RXSYS_MSG_OPNEND:
            memset(confp, 0x0, sizeof(confp));
            sprintf(confp, "%s/conf", SysHomeDirp );
            SysNotifySend( TPRTST_IDLE );
            ChgMacInfoIni( "0" );
            sysMainMenu( confp );
            pStat->stropn.stat = 1;
                  pCom->rmst_info.rmst_freq = 0;		//念のため

            if((cm_DrugStore_system()) && (pCom->db_trm.frc_clk_flg) && (!TprLibDlgCheck())){
                memset(tmpbuf, 0x00, sizeof(tmpbuf));
                if(competition_ini( 0, COMPETITION_INI_SALE_DATE, COMPETITION_INI_GETSYS, tmpbuf, sizeof(tmpbuf) ) == COMPETITION_INI_OK){
                if(strcmp(tmpbuf,"0000-00-00")){
                  usleep(500000);
                  TprLibLogWrite(0, TPRLOG_NORMAL, 0, "SYST:auto_to_1click call" );
                  maincb_1_clicked(0,0);
                }
              }
            }
            return 0;
          case RXSYS_MSG_CLSST:
            SysNotifySend( TPRTST_MENTE );
            SysMenuStatus = TPRTST_STATUS17;
            return 0;
          case RXSYS_MSG_CLSEND:
            SysNotifySend( MenuStat );
            return 0;
          case RXSYS_MSG_PWOFF:
            pwoffmain_1_clicked((GtkButton *)NULL, (gpointer)"shutdown");
            return 0;
          case RXSYS_MSG_PWRE:
            pwoffmain_1_clicked((GtkButton *)NULL, (gpointer)"reboot");
            return 0;
          case RXSYS_MSG_SYST_RESTART:
            pwoffmain_1_clicked((GtkButton *)NULL, (gpointer)"restart");
            return 0;
        }
        break;
      case TPRMID_DEVNOTIFY:
        if((notify->tid == TPRDIDMECKEY1) ||
           (notify->tid == TPRDIDMECKEY2) ) {
          inp.DevInf.dev_id = TPRTIDMASK(notify->tid);
          inp.hard_key = rmCharDataToInt(&notify->data[1]);
          inp.fnc_code = rmMecDataToFncCode(notify);
  //				memcpy(inp.DevInf.data, rmMecDataToPluCode(notify), 13);
          memcpy(inp.DevInf.data, p, sizeof(tprmsgdevnotify_t));
          inp.smlcls_cd = rmMecDataToSmlclsCode(notify);
          if(rxMemWrite(RXMEM_STROPNCLS, &inp) == RXMEM_OK)
            rxQueueWrite(RXQUEUE_STROPNCLS);
        }else if((notify->tid == TPRDIDSCANNER1) ||
                 (notify->tid == TPRDIDSCANNER2) ){
          inp.DevInf.dev_id = TPRTIDMASK(notify->tid);
          memcpy(inp.DevInf.data, p, sizeof(tprmsgdevnotify_t));
          if(rxMemWrite(RXMEM_STROPNCLS, &inp) == RXMEM_OK)
            rxQueueWrite(RXQUEUE_STROPNCLS);
        }
        break;
      case TPRMID_DEVACK:
        if((ack->tid == TPRDIDRECEIPT3) ||
           (ack->tid == TPRDIDRECEIPT4) ||
           (ack->tid == TPRDIDRECEIPT5) ||
           (ack->tid == TPRDIDRECEIPT6) ||
           (ack->tid == TPRDIDSCPU1) ||
           (ack->tid == TPRDIDSCPU2) ||
           (ack->tid == TPRDIDEDY3)  ||
           (ack->tid == TPRDIDSMTPLUS3) ||
           (ack->tid == TPRDIDCHANGER3) ||
           (ack->tid == TPRDIDSUICA3) ||
           (ack->tid == TPRDIDFCL3) ||
           (ack->tid == TPRDIDJMUPS3) ||
           (ack->tid == TPRDIDCCT3) ||
           (ack->tid == TPRDIDMST1) ||
           (ack->tid == TPRDIDGCAT3) ){
          inp.DevInf.dev_id = TPRTIDMASK(ack->tid);
          memcpy(inp.DevInf.data, ack, sizeof(tprmsgdevack2_t));
                            if(rxMemWrite(RXMEM_STROPNCLS, &inp) == RXMEM_OK)
                                    rxQueueWrite(RXQUEUE_STROPNCLS);
        }
                          break;
    }
    return 0;
  }

  extern int rmStoreOpenEventMain(unsigned char *p)
  {
    rmStoreOpenCloseEventMain(p);
    return 0;
  }

  extern int rmStoreCloseEventMain(unsigned char *p)
  {
    rmStoreOpenCloseEventMain(p);
    return 0;
  }

  /**********************************************************************
    Another Event(Main is apllib/rxsend.c)
  ***********************************************************************/
  extern int another1_status(uchar *p)
  {
    RX_COMMON_BUF	*pCom;

    if(rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK) {
      return( 1 );
    }
    if(pCom->another_layer == 1)
      return( another_status(p, RXMEM_ANOTHER1, RXQUEUE_ANOTHER1) );
    else if(pCom->another_layer == 2)
      return( another_status(p, RXMEM_ANOTHER2, RXQUEUE_ANOTHER2) );
    else
      return( 1 );
  }

  extern int another2_status(uchar *p, int mem, int queue)
  {
    RX_COMMON_BUF	*pCom;

    if(rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK) {
      return( 1 );
    }
    if(pCom->another_layer == 2)
      return( another_status(p, RXMEM_ANOTHER2, RXQUEUE_ANOTHER2) );
    return( 1 );
  }

  #if FB_FENCE_OVER || CASH_RECYCLE
  static int SysMenuStatus_Save;
  static int SysMenuStatus_Save2;	//SysMenuStatus -> SysMenuStatus_Save(FenceOver) -> SysMenuStatus_Save2(CashRecycle)
  static int fence_over_status_cnt = 0;
  static int fence_over_event_typ_chk = 0;
  static int fence_over_event_typ_cash = 0;
  static int cash_recycle_status_cnt = 0;
  static int cash_recycle_event_typ_chk = 0;
  static int cash_recycle_event_typ_cash = 0;
  #if FB_FENCE_OVER
  extern void fence_over_set_syst(int tid);
  #endif
  #if CASH_RECYCLE
  extern void cash_recycle_set_syst(int tid);
  #endif
  //static int AplAckMain(tprmsgdevack2_t *ack)
  int AplAckMain(tprmsgdevack2_t *ack)
  {
    char		erlog[128];
    RX_INPUT_BUF	inp;
    RX_COMMON_BUF	*pCom;
    RX_TASKSTAT_BUF	*pStat;

    memset(&inp, 0, sizeof(inp));
    switch(ack->result) {
      case RXSYS_MSG_FENCE_OVER_END:
        switch(ack->tid) {
          case TPRAID_CHK:
          case TPRAID_CASH:
            sprintf(erlog, "AplAckMain call MSG_FENCE_OVER_END[%ld]\n", ack->tid);
            break;
          default:
            sprintf(erlog, "AplAckMain call MSG_FENCE_OVER_END[%d]<=[%d] [%ld]\n",
              SysMenuStatus, SysMenuStatus_Save, ack->tid);
            break;
        }
        TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);
        inp.Ctrl.ctrl = 1;
        inp.inst = RX_FENCE_OVER_STOP;
        inp.fnc_code = ack->io;			/* fb_subinit */
        switch(ack->tid) {
          case TPRAID_QCJC_C_MNTPRN:
          case TPRAID_CHK:
            fence_over_event_typ_chk--;
            if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
              rxQueueWrite(RXQUEUE_CHK);
            }
            break;
          case TPRAID_CASH:
            fence_over_event_typ_cash--;
            if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
              if(rxQueueWrite(RXQUEUE_CASH) == RXQUEUE_OK)
                printf("cashier write ok!!\n");
            }
            break;
          default:
            fence_over_status_cnt--;
            if(fence_over_status_cnt == 0)
              SysMenuStatus = SysMenuStatus_Save;
            break;
        }
        /* 2010/04/23 >>> */
        if( rxMemPtr(RXMEM_STAT, (void **)&pStat) != RXMEM_OK ){
          TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, -1, "AplNotifyMani rxMemPtr STAT error!!\n" );
        }
        else {
          pStat->fence_over_stop = 0;
          TprLibLogWrite( TPRAID_SYST, TPRLOG_NORMAL, 1, "[RXSYS_MSG_FENCE_OVER_END]pStat->fence_over_stop = 0 \n" );
        }
        /* <<< 2010/04/23 */
        break;
      case RXSYS_MSG_FENCE_OVER_START:
        TprLibLogWrite(0, TPRLOG_NORMAL, 0, "AplNotifyMani call MSG_FENCE_OVER_START\n");
        fence_over_set_syst(ack->tid);
        break;
  #if CASH_RECYCLE
      case RXSYS_MSG_CASH_RECYCLE_END:
        switch(ack->tid) {
          case TPRAID_CHK:
          case TPRAID_CASH:
            sprintf(erlog, "AplAckMain call MSG_CASH_RECYCLE_END[%ld]\n", ack->tid);
            break;
          default:
            sprintf(erlog, "AplAckMain call MSG_CASH_RECYCLE_END[%d]<=[%d] [%ld]\n",
              SysMenuStatus, SysMenuStatus_Save, ack->tid);
            break;
        }
        TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);
        inp.Ctrl.ctrl = 1;
        inp.inst = RX_CASH_RECYCLE_STOP;
        inp.fnc_code = ack->io;			/* fb_subinit */
        switch(ack->tid) {
          case TPRAID_CHK:
            cash_recycle_event_typ_chk--;
            if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
              rxQueueWrite(RXQUEUE_CHK);
            }
            break;
          case TPRAID_CASH:
            cash_recycle_event_typ_cash--;
            if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
              if(rxQueueWrite(RXQUEUE_CASH) == RXQUEUE_OK)
                printf("cashier write ok!!\n");
            }
            break;
          default:
            cash_recycle_status_cnt--;
            if(cash_recycle_status_cnt == 0){
              if(fence_over_status_cnt == 0){
                sprintf(erlog, "AplAckMain call MSG_CASH_RECYCLE_END1[%d]<=[%d] [%ld]\n",
                  SysMenuStatus, SysMenuStatus_Save, ack->tid);
                TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);
                SysMenuStatus = SysMenuStatus_Save;
              }
              else{
                sprintf(erlog, "AplAckMain call MSG_CASH_RECYCLE_END2[%d]<=[%d] [%ld]\n",
                  SysMenuStatus, SysMenuStatus_Save2, ack->tid);
                TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);
                SysMenuStatus = SysMenuStatus_Save2;
              }
            }
            else{
              sprintf(erlog, "AplAckMain call MSG_CASH_RECYCLE_END cnt[%d] [%ld]\n",
                fence_over_status_cnt, ack->tid);
              TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);
            }
            break;
        }
        if( rxMemPtr(RXMEM_STAT, (void **)&pStat) != RXMEM_OK ){
          TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, -1, "AplNotifyMani rxMemPtr STAT error!!\n" );
        }
        else {
          pStat->fence_over_stop = 0;
          TprLibLogWrite( TPRAID_SYST, TPRLOG_NORMAL, 1, "[RXSYS_MSG_CASH_RECYCLE_END]pStat->fence_over_stop = 0 \n" );
        }
        break;
      case RXSYS_MSG_CASH_RECYCLE_START:
        TprLibLogWrite(0, TPRLOG_NORMAL, 0, "AplNotifyMain call MSG_CASH_RECYCLE_START\n");
        cash_recycle_set_syst(ack->tid);
        break;
  #endif

      case TPRDEVRESULTOK:
      case TPRDEVRESULTWERR:
      case TPRDEVRESULTOFFLINE:
      case TPRDEVRESULTEERR:
      case TPRDEVRESULTTIMEOUT:
        memset( &inp, 0x0, sizeof(inp) );
        inp.Ctrl.ctrl = 1;
        inp.DevInf.dev_id = TPRTIDMASK(ack->tid);
        memcpy( inp.DevInf.data, ack, sizeof(tprmsgdevack2_t) );
        inp.inst = RX_ANOTHER2_STOP;
        if( rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK ){
          TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, -1, "AplNotifyMani rxMemPtr COMMON error!!\n" );
          return -1;
        }
        snprintf(erlog, sizeof(erlog), "%s result[%x] layer[%d] tid[%x]\n",
          __FUNCTION__, ack->result, pCom->another_layer, ack->tid);
        TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);
        if( pCom->another_layer == 0 ){
          if(( chkInputToCashier(NULL, pCom) == TRUE ) && (ack->tid != TPRAID_QCJC_C_MNTPRN) && (ack->tid != TPRAID_QCJC_C_PRN)) {	/* Cashier */
            if(rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK){
              if(rxQueueWrite(RXQUEUE_CASH) != RXMEM_OK )
                TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, 0, "AplNotifyMani RXQUEUE_CASH SEND RXQUEUE NG\n" );
            }
            else{
              TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, 0, "AplNotifyMani RXQUEUE_CASH SEND RXMEM NG\n" );
            }
          }
          else{		/* Checker */
            if(rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK){
              if( rxQueueWrite(RXQUEUE_CHK) != RXMEM_OK ){
                TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, 0, "AplNotifyMani RXQUEUE_CHK SEND RXQUEUE NG\n" );
              }
            }
            else{
              TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, 0, "AplNotifyMani RXMEM_CHK_INP SEND RXMEM NG\n" );
            }
          }
        }
        else{
          return 1;
        }

        break;
      case	RXSYS_MSG_AUTOSTRCLS_START:
        if( rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK ){
          memset(erlog, 0x00, sizeof(erlog));
          snprintf(erlog, sizeof(erlog), AUTO_MSG_NG, 0);
          AplLib_CMAuto_File_Delete(1,TPRAID_SYST);
          mentecall_strcls_res_send(TPRAID_SYST, AUTOSTEP_STRCLS_START, erlog);
          TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, -1, "auto strcls start NG[rxMemPtr COMMON error]!" );
          break;
        }
        memset( &inp, 0x0, sizeof(inp) );
        inp.Ctrl.ctrl = 1;
        inp.inst = RX_AUTO_STRCLS_START;
        if((chkInputToCashier(NULL, pCom) == TRUE )	||
           (cmDesktopCashierSystem())		||
           (cm_HappySelf_All_system()))

        {	/* Cashier */
          if(rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK){
            if(rxQueueWrite(RXQUEUE_CASH) != RXMEM_OK )
              TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, 0, "AplNotifyMani RXQUEUE_CASH SEND RXQUEUE NG\n" );
          }
          else
            TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, 0, "AplNotifyMani RXQUEUE_CASH SEND RXMEM NG\n" );
        }
  //			else{		/* Checker */
          if(rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK){
            if( rxQueueWrite(RXQUEUE_CHK) != RXMEM_OK )
              TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, 0, "AplNotifyMani RXQUEUE_CHK SEND RXQUEUE NG\n" );
          }
          else
            TprLibLogWrite( TPRAID_SYST, TPRLOG_ERROR, 0, "AplNotifyMani RXMEM_CHK_INP SEND RXMEM NG\n" );
  //			}
        break;
      default: /* 2006/07/14 */
        return 1;
    }
    return 0;
  }
  #endif

  #if FB_FENCE_OVER
  extern void fence_over_set_syst(int tid)
  {
    char	erlog[128];

    sprintf(erlog, "call fence_over_set_syst[%d]\n", tid);
    TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);

    switch(tid) {
      case TPRAID_CASH: fence_over_event_typ_cash++; break;
      case TPRAID_QCJC_C_MNTPRN:
      case TPRAID_CHK: fence_over_event_typ_chk++; break;
      default:
        fence_over_status_cnt++;
        if(fence_over_status_cnt == 1) {
          SysMenuStatus_Save = SysMenuStatus;
          SysNotifySend( TPRTST_STATUS25 );
        }
        break;
    }
  }

  extern int fence_over_status(uchar *p)
  {
  //	if((fence_over_event_typ_chk == 0) && (fence_over_event_typ_cash == 0))
      another_status(p, RXMEM_FENCE_OVER, RXQUEUE_FENCE_OVER);
  //	else
  //		rmMainEventMain(p);
    return 1;
  }
  #endif

  extern int acxreal_status(uchar *p)
  {
    another_status(p, RXMEM_ACXREAL, RXQUEUE_ACXREAL);
    return 1;
  }

  #if CASH_RECYCLE
  extern void cash_recycle_set_syst(int tid)
  {
    char	erlog[128];

    sprintf(erlog, "call cash_recycle_set_syst[%d]\n", tid);
    TprLibLogWrite(0, TPRLOG_NORMAL, 0, erlog);

    switch(tid) {
      case TPRAID_CASH: cash_recycle_event_typ_cash++; break;
      case TPRAID_CHK: cash_recycle_event_typ_chk++; break;
      default:
        cash_recycle_status_cnt++;
        if(cash_recycle_status_cnt == 1) {
          if(fence_over_status_cnt == 0){
            SysMenuStatus_Save = SysMenuStatus;
          }
          else{
            SysMenuStatus_Save2 = SysMenuStatus;
          }
          SysNotifySend( TPRTST_CASH_RECYCLE );
        }
        break;
    }
  }

  extern int cash_recycle_status(uchar *p)
  {
    another_status(p, RXMEM_CASH_RECYCLE, RXQUEUE_CASH_RECYCLE);
    return 1;
  }
  #endif

  extern int suicatime_status(uchar *p)
  {
    another_status(p, RXMEM_SUICA_STAT, RXQUEUE_SUICA);
    return 1;
  }

  extern int multi_status(uchar *p)
  {
    another_status(p, RXMEM_MULTI_STAT, RXQUEUE_MULTI);
    return 1;
  }

  extern int masr_status(uchar *p)
  {
    another_status(p, RXMEM_MASR_STAT, RXQUEUE_MASR);
    return 1;
  }

  extern void mm_another_reptdsp_watch(void);
  static int another_status(uchar *p, int mem, int queue)
  {
    tprmsgdevnotify_t	*notify;
    tprmsgdevack2_t		*ack;
    tprapl_t		*apl;
    RX_INPUT_BUF		inp;
    RX_COMMON_BUF	*pCom;
    RX_PRN_STAT  stat;
    RX_TASKSTAT_BUF	*TS_BUF;
  //	int			i;
  //	char			erlog[128];
    int				ret;
    tprDlgParam_t   param;

    notify = (tprmsgdevnotify_t *)p;
    ack    = (tprmsgdevack2_t *)p;
    apl    = (tprapl_t *)p;

    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;
    inp.DevInf.dev_id = TPRTIDMASK(notify->tid);
    rxMemPtr(RXMEM_STAT, (void **)&TS_BUF);
    switch(notify->mid) {
      case TPRMID_APLACK:
        ret = AplAckMain((tprmsgdevack2_t *)p);
        /* 2006/07/14 >>> */
        if( ret ) {
          inp.DevInf.dev_id = TPRTIDMASK(ack->tid);
          memcpy(inp.DevInf.data, ack, sizeof(tprmsgdevack2_t));
          if(rxMemWrite(mem, &inp) == RXMEM_OK)
            rxQueueWrite(queue);
        }
        /* <<< 2006/07/14 */
        break;
      case TPRMID_APLNOTIFY:
        rxMemPtr(RXMEM_COMMON, (void **)&pCom);
        switch(apl->errnum & RXSYS_MSG_MASK) {
          case RXSYS_MSG_FINIT:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_FINIT");
            pCom->another_layer = 1;
            inp.inst = RX_ANOTHER2_STOP;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
  //					mentemain_idle();
            return 0;
          case RXSYS_MSG_MENTE:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_MENTE");
            pCom->another_layer = 1;
            inp.inst = RX_ANOTHER2_STOP;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
  //					mentemain_idle();
            return 0;
          case RXSYS_MSG_USETUP:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_USETUP");
            pCom->another_layer = 1;
            inp.inst = RX_ANOTHER2_STOP;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
  //					usetupmain_idle();
            return 0;
          case RXSYS_MSG_PMOD:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call PMOD");
            pCom->another_layer = 1;
            inp.inst = RX_ANOTHER2_STOP;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
  //					pmodmain_idle();
            return 0;
          case RXSYS_MSG_FREQS:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_FREQS");
  //					usetupmain_req();
            SysNotifySend( TPRTST_MENTE );
            SysMenuStatus = TPRTST_STATUS09;
            return 0;
          case RXSYS_MSG_DATA_SHIFT:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_DATA_SHIFT");
            pCom->another_layer = 1;
            inp.inst = RX_DATA_SHIFT_STOP;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
            return 0;
          case RXSYS_MSG_FREQE:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_FREQE");
            pCom->another_layer = 1;
  //					usetupmain_idle();
            SysNotifySend( TPRTST_STATUS09 );
            inp.inst = RX_ANOTHER2_STOP;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
  //					mm_sale_sts_rtn( 0 );
  //					mm_another_reptdsp_watch();
            return 0;
          case RXSYS_MSG_SPEC:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_SPEC");
            pCom->another_layer = 1;
            inp.inst = RX_ANOTHER21_STOP;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
  //					specmain_idle();
            return 0;
          case RXSYS_MSG_SPEC_SPECIAL:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_SPEC_SPECIAL");
            pCom->another_layer = 1;
            inp.inst = RX_ANOTHER2_SPEC_SPECIAL;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
            return 0;
          case RXSYS_MSG_USETUP_CALL:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_USETUP_CALL");
            SysNotifySend( TPRTST_STATUS16 );
            return 0;
          case RXSYS_MSG_MENTE_CALL:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_MENTE_CALL");
            SysNotifySend( TPRTST_MENTE );
            return 0;
          case RXSYS_MSG_SALE_CALL:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_SALE_CALL");
            SysNotifySend( TPRTST_STATUS09 );
            return 0;
          case RXSYS_MSG_MENU:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_MENU");
            if (pCom->batch_rpt_flag == 1)
            {
              TprLibLogWrite(0, TPRLOG_NORMAL, 0, "(pCom->batch_rpt_flag == 1) [START]");
  //						CommonMemory_Read2();
  //						rmStoreCloseMain();
  //						pCom->batch_rpt_flag = 0;

  #ifdef FB2GTK
              pCom->another_layer = 0;
              SysNotifySend( TPRTST_IDLE );
              CommonMemory_Read2();
              pCom->batch_rpt_flag = 0;
              rmStoreCloseMain();
  #else
              msg_timer = -1;
              menuwait_dsp( );
              msg_timer = gtk_timeout_add(100, (GtkFunction) StoreCloseCall, 0 );
  #endif
              TprLibLogWrite(0, TPRLOG_NORMAL, 0, "(pCom->batch_rpt_flag == 1) [END]");
            }
            else
            {
              TprLibLogWrite(0, TPRLOG_NORMAL, 0, "<MSG_MENU> NORMAL_END [START]");
              pCom->another_layer = 0;
              TprLibLogWrite(0, TPRLOG_NORMAL, 0, "<MSG_MENU> SysNotifySend(TPRTST_IDLE)");
              SysNotifySend( TPRTST_IDLE );
              TprLibLogWrite(0, TPRLOG_NORMAL, 0, "<MSG_MENU> mainmenu_redisplay(0)");
              mainmenu_redisplay(0);
              TS_BUF->acx.acxreal_flg = 0;    /* 釣銭機リアル問い合わせ 開始 */

              TprLibLogWrite(0, TPRLOG_NORMAL, 0, "<MSG_MENU> cm_bkupd_play_mode_get()");
              if( cm_bkupd_play_mode_get() == 2 ){
                bp_dlg_flg = 1;
                memset(&param, 0x0, sizeof(tprDlgParam_t));
                param.dialog_ptn = TPRDLG_PT2;
                param.er_code    = MSG_QUICK7_COMPLETE;
                param.func1      = (void *)bkupd_play_DlgClear;
                param.msg1       = BTN_CONF;
                param.user_code  = 1;
                TprLibDlg( &param );
              }
              TprLibLogWrite(0, TPRLOG_NORMAL, 0, "<MSG_MENU> bkupd_play_mode_set(0)");
              if( bkupd_play_mode_set( "0" ) )
                TprLibLogWrite( 0, TPRLOG_ERROR, 0, "bkupd_play_mode_set error\n" );

  #if FB_FENCE_OVER /* 2010/04/23 */
              TS_BUF->fence_over_stop = 0;
              TprLibLogWrite( TPRAID_SYST, TPRLOG_NORMAL, 1, "[RXSYS_MSG_MENU]pStat->fence_over_stop = 0 \n" );
  #endif
              TprLibLogWrite(0, TPRLOG_NORMAL, 0, "<MSG_MENU> NORMAL_END [END]");
              /* 自動開閉設仕様 */
              if( AplLib_Auto_StrCls(0)                  ){
                switch( AplLib_AutoGetAutoMode( 0 ) ) {
                  case (AUTOMODE_RECALC+1):	/* 釣機再精査から次へ */
                  case (AUTOMODE_BATREPO+1):	/* 予約レポート出力から次へ */
                  case (AUTOMODE_BATREPO2+1):	/* 予約レポート出力２から次へ */
  #if FB_FENCE_OVER
                  case (AUTOMODE_PBCHGUTIL+1):	/* 収納業務 */
  #endif
                    auto_strcls_judg( );
                    break;
                  default:
                    break;
                }
              }
            }
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_MENU end!!");
            return 0;
          case RXSYS_MSG_REBOOT:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_REBOOT");
            SysMenuStatus = TPRTST_POWEROFF;
            pwoffmain_1_clicked(NULL, "reboot");
            return 0;
          case RXSYS_MSG_REBOOT1:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_REBOOT1");
  #ifdef FB2GTK
            SysMenuStatus = TPRTST_POWEROFF;
            pwoffmain_1_clicked(NULL, "reboot");
  #else
            shutdownStart( 1 );
  #endif
            return 0;
          case RXSYS_MSG_PWOFF:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_PWOFF");
            SysMenuStatus = TPRTST_POWEROFF;
            pwoffmain_1_clicked(NULL, "shutdown");
            return 0;
          case RXSYS_MSG_CUSTCLRS:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_CUSTCLRS");
            SysNotifySend( TPRTST_MENTE );
            SysMenuStatus = TPRTST_STATUS09;
            return 0;
          case RXSYS_MSG_CUSTCLRE:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_CUSTCLRE");
            pCom->another_layer = 1;
            SysNotifySend( TPRTST_STATUS09 );
            inp.inst = RX_ANOTHER2_STOP;
            if(rxMemWrite(RXMEM_ANOTHER1, &inp) == RXMEM_OK)
              rxQueueWrite(RXQUEUE_ANOTHER1);
  //					mm_sale_sts_rtn( 0 );
  //					mm_another_reptdsp_watch();
            return 0;
          case RXSYS_MSG_READFLAG:
            TprLibLogWrite(0, TPRLOG_NORMAL, 0, "call MSG_READFLAG");
            recog_readflag_clear();
            rcPrt_ReadFlagData();
            rcSetMemberMemoryToSysini();
            rcSetMemoryToSysini();
            rmIniReadMain();
            qcjc_system(0);	// QCJC
            return 0;
        }
        break;
      case TPRMID_DEVNOTIFY:
        if(notify->mid == TPRMID_DEVNOTIFY) {
          if((notify->tid == TPRDIDMECKEY1) ||
             (notify->tid == TPRDIDMECKEY2) ) {
            inp.hard_key = rmCharDataToInt(&notify->data[1]);
            inp.fnc_code = rmMecDataToFncCode(notify);
            inp.smlcls_cd = rmMecDataToSmlclsCode(notify);
          }
        }
        memcpy(inp.DevInf.data, p, sizeof(tprmsgdevnotify_t));
        if(rxMemWrite(mem, &inp) == RXMEM_OK)
          rxQueueWrite(queue);
        break;
      case TPRMID_DEVACK:
        if(( ack->tid == TPRDIDSTPR3 ) && ( ack->src == TPRAID_STPR )){
          memset(&stat, 0, sizeof(stat));
          stat.Ctrl.ctrl = 1;
          stat.DevInf.dev_id = TPRTIDMASK(ack->tid);
          memcpy(stat.DevInf.data, ack, sizeof(tprmsgdevack2_t));
          memcpy(stat.DevInf.data, ack, sizeof(tprmsgdevack2_t));
          if (rxMemWrite(RXMEM_STPR_STAT, &stat) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_STPR_STAT);
          }
          break;
        }
        else if(( ack->tid == TPRDIDS2PR3 ) && ( ack->src == TPRAID_S2PR )){
          memset(&stat, 0, sizeof(stat));
          stat.Ctrl.ctrl = 1;
          stat.DevInf.dev_id = TPRTIDMASK(ack->tid);
          memcpy(stat.DevInf.data, ack, sizeof(tprmsgdevack2_t));
          memcpy(stat.DevInf.data, ack, sizeof(tprmsgdevack2_t));
          if (rxMemWrite(RXMEM_S2PR_STAT, &stat) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_S2PR_STAT);
          }
          break;
        }
      default:
        inp.DevInf.dev_id = TPRTIDMASK(ack->tid);
        memcpy(inp.DevInf.data, ack, sizeof(tprmsgdevack2_t));
        if(rxMemWrite(mem, &inp) == RXMEM_OK)
          rxQueueWrite(queue);
        break;
    }
    return 0;
  }

  /**********************************************************************
    Retotal Main & Event
  ***********************************************************************/
  #if 0
  extern int retotal_clicked(void)
  {
    RX_INPUT_BUF    inp_buf;
    RX_COMMON_BUF   *pCom;

    rxMemPtr(RXMEM_COMMON, (void **)&pCom);

    if(rxMemDataChk(RXMEM_PROCINST) == RXMEM_DATA_OFF) {
      memset(&inp_buf, 0x0, sizeof(inp_buf));
      inp_buf.Ctrl.ctrl = 1;
      inp_buf.inst = RX_RETOTAL_START;
      rxMemWrite(RXMEM_PROCINST, &inp_buf);
      rxQueueWrite(RXQUEUE_PROCINST);
    }
    return 0;
  }

  extern int retotal_status( uchar *p )
  {
    tprmsgdevnotify_t       *notify;
    tprapl_t		*apl;
    RX_INPUT_BUF            inp;

    notify = (tprmsgdevnotify_t *)p;
    apl    = (tprapl_t *)p;

    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;
    inp.DevInf.dev_id = TPRTIDMASK(notify->tid);

    if(notify->mid == TPRMID_DEVNOTIFY) {
      if((notify->tid == TPRDIDMECKEY1) ||
         (notify->tid == TPRDIDMECKEY2) ) {
        inp.hard_key = rmCharDataToInt(&notify->data[1]);
        inp.fnc_code = rmMecDataToFncCode(notify);
        memcpy(inp.DevInf.data, rmMecDataToPluCode(notify), 13);
        inp.smlcls_cd = rmMecDataToSmlclsCode(notify);
        if(rxMemWrite(RXMEM_RETOTAL_INP, &inp) == RXMEM_OK)
          rxQueueWrite(RXQUEUE_RETOTAL);
      }
    }
    else if(notify->mid == TPRMID_APLNOTIFY) {
      if ((apl->errnum & RXSYS_MSG_MASK) == RXSYS_MSG_REGSEND) {
        mentemain_idle();
        return 0;
      }
    }
    return 0;
  }
  #endif
  /**********************************************************************
      関数：int DevNotifyMechaKeyMain(tprmsgdevnotify_t *notify)
      機能：メカキー非同期入力イベントメイン関数
      引数：tprmsgdevnotify_t *notify デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevNotifyMechaKeyMain(tprmsgdevnotify_t *notify)
  {
    RX_INPUT_BUF inp;
    RX_COMMON_BUF	*pCom;
    char	tmpbuf[10];
    int	dev_id, mkey4;
    RX_TASKSTAT_BUF *TS_BUF;

    if(cmDesktopCashierSystem())
    {
      rxMemPtr(RXMEM_STAT, (void **)&TS_BUF);
      if(TS_BUF->chk.regs_start_flg != 1)
      {
        TprLibLogWrite( TPRAID_SYST, 0, 1, "DevNotifyMechaKeyMain:return(TS_BUF->chk.regs_start_flg != 1)\n" );
        return 0;
      }
    }

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;
    inp.DevInf.dev_id = TPRTIDMASK(notify->tid);
    mkey4 = 0;

    switch(notify->tid) {
      case TPRDIDMECKEY1:
      case TPRDIDMECKEY2:
        inp.hard_key = rmCharDataToInt(&notify->data[1]);
        inp.fnc_code = rmMecDataToFncCode(notify);
        memcpy(inp.DevInf.data, rmMecDataToPluCode(notify), 13);
        inp.smlcls_cd = rmMecDataToSmlclsCode(notify);
                  break;
      case TPRDIDMECKEY4:
        mkey4 = 1;
        memset(tmpbuf, 0x0, sizeof(tmpbuf));
        strncpy(tmpbuf, &notify->data[1], 6);
        inp.fnc_code = atol(tmpbuf);
        memset(tmpbuf, 0x0, sizeof(tmpbuf));
        strncpy(tmpbuf, &notify->data[7], 1);
        if(atoi(tmpbuf) == 1){
          inp.DevInf.dev_id = TPRDIDMECKEY1;
        }
        else{
          inp.DevInf.dev_id = TPRDIDMECKEY2;
        }
        notify->tid = inp.DevInf.dev_id;
        break;
      default:
        break;
    }

    /* 登録タスクへ情報を渡す */
    if (inp.fnc_code != 0) {
      rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  #if SIMPLE_2STAFF  /* 2004.01.13 */
      /*if(pCom->db_trm.frc_clk_flg == 2)*/
      if(cmChk2PersonSystem() == 2) /* 2011/02/09 */
      {
        if ( (chkInputToSimpleCashier(notify, pCom) == TRUE) && (notify->tid == TPRDIDMECKEY1)) {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash)){
            if(mkey4 == 1)
              notify->tid = TPRDIDMECKEY4;
            memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
          }
  #endif
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        } else {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
            memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
      } else
  #endif
      {
        if(   (chkInputToCashier(notify, pCom) == TRUE)
           && (notify->tid == TPRDIDMECKEY1)) { /* 01/01/31 F.Saitoh '2'->'1' */
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash))
            memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        }
        else{
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
            memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
      }
    }
    else if (notify->tid == TPRDIDMECKEY6) {
      rxMemPtr(RXMEM_COMMON, (void **)&pCom);
      if(pCom->ini_macinfo.keyb == 0)
        return 0;
  #if FB_FENCE_OVER || CASH_RECYCLE
      if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
        return 0;
  #endif
      memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #if SIMPLE_2STAFF
      if(pCom->db_trm.frc_clk_flg == 2) {
        if( chkInputToSimpleCashier(notify, pCom) == TRUE ) {
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        } else {
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
      } else
  #endif
      {
        if ( chkInputToCashier(notify, pCom) == TRUE ) {
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        }
        else {
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
      }
    }

    return 0;
  }


  /**********************************************************************
      関数：int DevNotifyTouchKeyMain(tprmsgdevnotify_t *notify)
      機能：タッチキー非同期入力イベントメイン関数
      引数：tprmsgdevnotify_t *notify デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevNotifyTouchKeyMain(tprmsgdevnotify_t *notify)
  {
    RX_INPUT_BUF	inp;
    RX_COMMON_BUF	*pCom;

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;

    inp.DevInf.dev_id = TPRTIDMASK(notify->tid);
    inp.hard_key = rmCharDataToInt(&notify->data[1]);
    inp.fnc_code = rmTouDataToFncCode(notify);

          if(inp.fnc_code == 139 ) { /* for SIMPLE_STAFF added by N.Kobayashi */
      inp.smlcls_cd = rmTouDataToSmlclsCode(notify);
    }

    /* 登録タスクへ情報を渡す */
  //	if (inp.fnc_code != 0) {
      rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  #if SIMPLE_2STAFF  /* 2004.01.13 */
      /*if(pCom->db_trm.frc_clk_flg == 2)*/
      if(cmChk2PersonSystem() == 2) /* 2011/02/09 */
      {
        if( chkInputToSimpleCashier(notify, pCom) == TRUE ) {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash))
            memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        }
        else
        {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
            memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
      } else
  #endif
      {
        if ( chkInputToCashier(notify, pCom) == TRUE ) {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash))
            memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        } else {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
            memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
      }
  //	}

    return 0;
  }


  /* For Device Notify Send Function */
  static
  int DevNotifyDataSend(tprmsgdevack2_t *notify)
  {
    RX_INPUT_BUF inp;

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;
    inp.DevInf.dev_id = TPRTIDMASK(notify->tid);
    inp.hard_key = 1000;
    memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevack_t));

    /* 入力情報を登録タスクへ渡す */
    switch (notify->src) {
                  case TPRAID_ACX:
        if (rxMemWrite(RXMEM_ACX_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_ACX);
        }
        break;
                  case TPRAID_RWC:
        if (rxMemWrite(RXMEM_RWC_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_RWC);
        }
        break;
                  case TPRAID_MULTI:
        if (rxMemWrite(RXMEM_MULTI_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_MULTI);
        }
        break;
      default :
        break;
    }
    return 0;
  }


  /**********************************************************************
      関数：int DevNotifyMagCard_JIS(tprmsgdevnotify_t *notify)
      機能：搭載型磁気カード非同期入力イベントメイン関数
      引数：tprmsgdevnotify_t *notify デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevNotifyMagCard_JIS(tprmsgdevnotify_t *notify)
  {
    RX_INPUT_BUF	inp;
    RX_COMMON_BUF	*pCom;

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;
    inp.DevInf.dev_id = TPRTIDMASK(notify->tid);

    memcpy(inp.DevInf.data, &notify->data[1], 72);

    /* 入力情報を登録タスクへ渡す */
    rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  //	if_bz();	/* 2002.10.01 deleted */
    switch(notify->tid) {
      case TPRDIDMGC1JIS1:
      case TPRDIDMGC1JIS2:
  #if SIMPLE_2STAFF  /* 2004.01.13 */
        /*if(pCom->db_trm.frc_clk_flg == 2)*/
        if(cmChk2PersonSystem() == 2) /* 2011/02/09 */
        {
          if( chkInputToSimpleCashier(notify, pCom) == TRUE ) {
            TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDMGC1 JIS1/2 input. (cashier)\n" );
  #if FB_FENCE_OVER || CASH_RECYCLE
            if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash))
              memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
            if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
              rxQueueWrite(RXQUEUE_CASH);
            }
            break;
          } else {
            TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDMGC1 JIS1/2 input.(checker)\n" );
  #if FB_FENCE_OVER || CASH_RECYCLE
            if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
              memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
            if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
              rxQueueWrite(RXQUEUE_CHK);
            }
            break;
          }
        } else
  #endif
        {
          if ( chkInputToCashier(notify, pCom) == TRUE ) {
            TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDMGC1 JIS1/2 input.\n" );
  #if FB_FENCE_OVER || CASH_RECYCLE
            if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash))
              memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
            if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
              rxQueueWrite(RXQUEUE_CASH);
            }
            break;
          }
        }
      case TPRDIDMGC2JIS1:
      case TPRDIDMGC2JIS2:
        TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDMGC2 JIS1/2 input.\n" );
  #if FB_FENCE_OVER || CASH_RECYCLE
        if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
          memcpy(inp.DevInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
        if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_CHK);
        }
        break;
      default:
        break;
    }

    switch(notify->tid) {
      case TPRDIDMGC1JIS1:
      case TPRDIDMGC1JIS2:
        if_bz();
        break;
      case TPRDIDMGC2JIS1:
      case TPRDIDMGC2JIS2:
        if_bz_cshr();
        break;
      default:
        break;
    }

    return 0;
  }

   */

  /// キャッシャーへの入力データか判断
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()
  Future<List<RxInputBuf>> devNotifyScannerMain (TprMsgDevNotify_t notify) async {
    List<RxInputBuf> inpList = <RxInputBuf>[];
    RxInputBuf inp = RxInputBuf();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetC.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "devNotifyScannerMain rxMemRead COMMON error!!\n");
      return inpList;
    }
    if (xRetS.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "devNotifyScannerMain rxMemRead STAT error!!\n");
      return inpList;
    }
    RxCommonBuf pCom = xRetC.object;
    RxTaskStatBuf tsBuf = xRetS.object;
    Code128_inf C128i = Code128_inf();
    int i;
    int ticket_flag = 0;
    int desktopCashierSystem = 0;

    if((notify.tid == TprDidDef.TPRDIDAMI1) ||
        (notify.tid == TprDidDef.TPRDIDAMI2)) {
      notify.tid = TprDidDef.TPRDIDSCANNER2;
    }

    /* 入力情報作成 */
    inp.ctrl.ctrl = true;
    inp.devInf.devId = (notify.tid);
    inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);

    desktopCashierSystem = await CmCksys.cmDesktopCashierSystem();
    if (desktopCashierSystem != 0) {
      if (tsBuf.chk.regs_start_flg != 1) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "devNotifyScannerMain:return(TS_BUF->chk.regs_start_flg != 1)\n");
        return inpList;
      }
    }

    if (await CmCksys.cmShopAndGoSystem() != 0) {
      if((notify.data[ScanCom.SCAN_OFFSET_LABEL_ID + 0] == 's')
          && (notify.data[ScanCom.SCAN_OFFSET_LABEL_ID + 1] == 'g')
          && (notify.data[ScanCom.SCAN_OFFSET_LABEL_ID + 2] == 'q')
          && (notify.data[ScanCom.SCAN_OFFSET_LABEL_ID + 3] == 'r')) {
        ticket_flag = 1;
      }
    }

    if(await CmCksys.cmRepicaSystem() != 0) {
      //REPICA.scan_flg = FALSE;
    }
    //
    /* スキャナーデータの添付 */
    switch (notify.data[ScanCom.SCAN_OFFSET_LABEL_ID]) {
      case ScanCom.SCAN_UPCA_CODE:   // 'A'
        await devNotifyScannerUpca(notify, inp);
        break;
      case ScanCom.SCAN_UPCE_CODE:   // 'E'
        await devNotifyScannerUpce(notify, inp);
        break;
      case ScanCom.SCAN_EAN13_CODE:   // 'F'
        await devNotifyScannerEan(notify, inp);
        break;
      case ScanCom.SCAN_CODE128_CODE:   // 'K'
        await devNotifyScannerCode128(notify, inp, C128i, pCom, tsBuf);
        break;
      case ScanCom.SCAN_NW7_CODE:   // 'N'
        await devNotifyScannerNw7(notify, inp, pCom);
        break;
      case ScanCom.SCAN_ITF_CODE:   // 'I'
        await devNotifyScannerItf(notify, inp);
        break;
      case ScanCom.SCAN_CODE39_CODE:   // 'M'
        await devNotifyScannerCode39(notify, inp);
        break;
      case ScanCom.SCAN_GS1_1_CODE:   // 'R'
        await devNotifyScannerGs1(notify, inp);
        break;
      case ScanCom.SCAN_QR_CODE:   // 'Q'
        await devNotifyScannerQr(notify, inp);
        break;
      case ScanCom.SCAN_PASSPORT_CODE:   // 'P'
        await devNotifyScannerPassport(notify, inp);
        break;
      default:
        if(ticket_flag == 1) {/* Shop&Go（利用券(引換券)）である場合 */
          /* 全文字列を格納する */
          devNotifyScannerShopAndGo(notify, inp);
          break;
        } else {
          return inpList;
        }
    }

    if ((await CmCksys.cmWsSystem() != 0) && (notify.data[1] == 'N')) {
      // ワールドスポーツ様のNW7バーコードは補完しない
      ;
    } else {
      // TODO:何をしたいのかよくわからない。ゴミデータをクリアしたいだけ？
      // cm_plu_set_zero(inp.devInf.data);
    }

    /* 入力情報を登録タスクへ渡す */
    for (i = C128i.bar2type; i >= 0; i--) {
      inp.devInf.bcdSeqNo = 0;
      if (C128i.bar2type == 1) {
        inp.devInf.bcdSeqNo = C128i.bar2type + 1 - i;
      }
      if((C128i.bar2type == 1) && (i == 0)) {
        sleep(const Duration(microseconds: 300000));  // usleep(300000);
        inp.devInf.data = C128i.Code2;
      }
      switch(notify.tid) {
        case TprDidDef.TPRDIDSCANNER1:
          if ((CompileFlag.SIMPLE_2STAFF) &&
              (await CmCksys.cmChk2PersonSystem() == 2)) {
            if (await chkInputToSimpleCashier(notify, pCom) == TRUE) {
              if (CompileFlag.FB_FENCE_OVER || CompileFlag.CASH_RECYCLE) {
                if ((fence_over_event_typ_cash != 0) ||
                    (cash_recycle_event_typ_cash != 0)) {
                  inp.devInf.data = notify.data.join("");
                }
              }
              inp.rxMemIndex = RxMemIndex.RXMEM_CASH_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
            } else {
              if (CompileFlag.FB_FENCE_OVER || CompileFlag.CASH_RECYCLE) {
                if ((fence_over_event_typ_chk != 0) ||
                    (cash_recycle_event_typ_chk != 0)) {
                  inp.devInf.data = notify.data.join("");
                }
              }
              inp.rxMemIndex = RxMemIndex.RXMEM_CHK_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
            }
            break;
          } else {
            if (await chkInputToCashier(notify, pCom) == TRUE) {
              if (CompileFlag.FB_FENCE_OVER || CompileFlag.CASH_RECYCLE) {
                if ((fence_over_event_typ_cash != 0) ||
                    (cash_recycle_event_typ_cash != 0)) {
                  inp.devInf.data = notify.data.join("");
                }
              }
              inp.rxMemIndex = RxMemIndex.RXMEM_CHK_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
              break;
            }
          }

          if ((CompileFlag.FB_FENCE_OVER) ||
              (CompileFlag.CASH_RECYCLE )) {
            if ((fence_over_event_typ_chk != 0) ||
                (cash_recycle_event_typ_chk != 0)) {
              inp.devInf.data = notify.data.join("");
            }
            if ((CmCksys.cmChkVerticalFHDSystem() != 0) // 縦型
                && (await  CmCksys.cmHappySelfSystem() != 0) // HappySelf
                && (await chkInputToCashier(notify, pCom) == TRUE) // キャッシャーへの入力？
                && (fence_over_event_typ_cash != 0)) { // fenceoverがキャッシャー側でカウント
              inp.devInf.data = notify.data.join("");
            }
          }
          if (await CmCksys.cmDesktopCashierSystem() != 0) {
            if (await chkInputToCashier(notify, pCom) == TRUE) {
              inp.rxMemIndex = RxMemIndex.RXMEM_CASH_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
            } else if ((CompileFlag.SIMPLE_2STAFF) &&
                (await CmCksys.cmChk2PersonSystem() == 2) &&
                (await chkInputToSimpleCashier(notify, pCom) == TRUE)) {
              inp.rxMemIndex = RxMemIndex.RXMEM_CASH_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
            } else {
              inp.rxMemIndex = RxMemIndex.RXMEM_CHK_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
            }
          } else {
            inp.rxMemIndex = RxMemIndex.RXMEM_CHK_INP;
            inp = setBuf(inp, inp.devInf.data);
            inpList.add(cloneBuf(inp));
          }
          break;
        case TprDidDef.TPRDIDSCANNER2:
          if ((CompileFlag.FB_FENCE_OVER) ||
              (CompileFlag.CASH_RECYCLE )) {
            if ((fence_over_event_typ_chk != 0) ||
                (cash_recycle_event_typ_chk != 0)) {
              inp.devInf.data = notify.data.join("");
            }
            if ((CmCksys.cmChkVerticalFHDSystem() != 0) // 縦型
                && (await  CmCksys.cmHappySelfSystem() != 0) // HappySelf
                && (await chkInputToCashier(notify, pCom) == TRUE) // キャッシャーへの入力？
                && (fence_over_event_typ_cash != 0)) { // fenceoverがキャッシャー側でカウント
              inp.devInf.data = notify.data.join("");
            }
          }
          if (await CmCksys.cmDesktopCashierSystem() != 0) {
            if (await chkInputToCashier(notify, pCom) == TRUE) {
              inp.rxMemIndex = RxMemIndex.RXMEM_CASH_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
            } else if ((CompileFlag.SIMPLE_2STAFF) &&
                (await CmCksys.cmChk2PersonSystem() == 2) &&
                (await chkInputToSimpleCashier(notify, pCom) == TRUE)) {
              inp.rxMemIndex = RxMemIndex.RXMEM_CASH_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
            } else {
              inp.rxMemIndex = RxMemIndex.RXMEM_CHK_INP;
              inp = setBuf(inp, inp.devInf.data);
              inpList.add(cloneBuf(inp));
            }
          } else {
            inp.rxMemIndex = RxMemIndex.RXMEM_CHK_INP;
            inp = setBuf(inp, inp.devInf.data);
            inpList.add(cloneBuf(inp));
          }
          break;
        default:
          break;
      }
    }
    return inpList;
  }

  /// UPCAコード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、UPCAコードに関する部分を分割
  Future<void> devNotifyScannerUpca (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    inp.devInf.data = bardata.substring(
        ScanCom.SCAN_OFFSET_DATA,
        ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_UPCA_DATA_SIZE);
  }

  /// UPCEコード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、UPCEコードに関する部分を分割
  Future<void> devNotifyScannerUpce (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    inp.devInf.data = bardata.substring(
        ScanCom.SCAN_OFFSET_DATA,
        ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_UPCE_DATA_SIZE);
  }

  /// EANコード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、EAN/JANコードに関する部分を分割
  Future<void> devNotifyScannerEan (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    if (notify.data[ScanCom.SCAN_OFFSET_LABEL_ID2] == ScanCom.SCAN_EAN8_CODE) {   // 'F'
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA2,
          ScanCom.SCAN_OFFSET_DATA2 + ScanCom.SCAN_EAN8_DATA_SIZE);
    } else {
      if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_EAN_ADDON_DATA_SIZE) {
        inp.devInf.data = bardata.substring(
            ScanCom.SCAN_OFFSET_DATA,
            ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE);
        inp.devInf.adonCd = bardata.substring(
            ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE,
            ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN_ADDON_DATA_SIZE);
      } else {
        inp.devInf.data = bardata.substring(
            ScanCom.SCAN_OFFSET_DATA,
            ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE);
      }
    }
  }

  /// CODE128コード解析処理
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 引数:[C128i] CODE128で、二段バーコードになる場合のバッファ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、CODE128コードに関する部分を分割
  Future<void> devNotifyScannerCode128(
      TprMsgDevNotify_t notify,  RxInputBuf inp, Code128_inf C128i,
      RxCommonBuf pCom, RxTaskStatBuf tsBuf) async {

    String bardata = notify.data.join("");
    String wait1 = "31313131313131313131313131313131313131313131";
    String buff = "";
    int cd = 0;
    int result = 0;

    if (CompileFlag.SALELMT_BAR) {
      inp.devInf.salelmt = "\x00";
    }
    inp.devInf.barData = "\x00";

    if (((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE8) &&
        (CompileFlag.SS_CR2)) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_CODE128_DATA_SIZE8);
    } else if((await CmCksys.cmBarcodePaysystem() != 0) &&
        (tsBuf.bcdpay.scan_flg != 0) &&
        (await regScannerInputCashierChk(notify, pCom) == 0)) {
      /* バーコード決済で読取モード時、CODE128すべて通す */
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_LABEL);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + inp.devInf.barCdLen);
    } else if ((await CmCksys.cmRepicaStdCodeSystem() != 0) &&
        (tsBuf.repica.scan_flg != 0) &&
        (await regScannerInputCashierChk(notify, pCom) == 0)) {
      /* バーコード決済で読取モード時、CODE128すべて通す */
      inp.devInf.barCdLen = notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR;
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + inp.devInf.barCdLen);
    } else if((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE20) {
      inp.devInf.data = "";
      buff = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      if ((await CmCksys.cmFipMemberBarcodeSystem() != 0) &&
          (await checkFipMemberBarcode(bardata.substring(2)) != 0)) {
        inp.devInf.barCdLen = notify.datalen - ScanCom.SCAN_HEADER_CR;
        inp.devInf.data = bardata.substring(
            ScanCom.SCAN_OFFSET_LABEL_ID,
            ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);
      } else if ((await CmCksys.cmFipEmoneyStandardSystem() != 0) &&
          (await checkFipStandardBarcode(bardata.substring(2)) != 0)) {
        inp.devInf.barCdLen = notify.datalen - ScanCom.SCAN_HEADER_CR;
        inp.devInf.data = bardata.substring(
            ScanCom.SCAN_OFFSET_LABEL_ID,
            ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);
      } else if (ProdJan.cmChkProdbarLen20(buff) > 1) {
        inp.devInf.data = bardata.substring(
            ScanCom.SCAN_OFFSET_DATA,
            ScanCom.SCAN_OFFSET_DATA + notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      } else {
        C128i.digit = notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR;
        C128i.Org_Code = bardata.substring(
            ScanCom.SCAN_OFFSET_DATA,
            ScanCom.SCAN_OFFSET_DATA + C128i.digit);
        cd = Cdigt.cmW3Modulas10(C128i.Org_Code.substring(0,
            notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR), wait1,
            notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
        result = SetJinf.cmMkDscCode(C128i);
        if ((cd != (C128i.Org_Code.codeUnitAt(notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR) - 0x30)) || (result == NG)) {
          inp.devInf.data = "1234567890123";
        } else {
          C128i.bar2type = 1;
          inp.devInf.data = C128i.Code1.substring(0, ScanCom.SCAN_CODE128_INSTR_SIZE13);
        }
      }
    } else if((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE22) {
      C128i.Org_Code = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      cd = Cdigt.cmW3Modulas10(C128i.Org_Code.substring(0,
          notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR), wait1,
          notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      C128i.digit = notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR;
      result = SetJinf.cmMkDscCode2(C128i);
      if((cd != (C128i.Org_Code.codeUnitAt(notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR) - 0x30)) || (result == NG)) {
        inp.devInf.data = "1234567890123";
      } else {
        C128i.bar2type = 1;
        inp.devInf.data = C128i.Code1.substring(0, ScanCom.SCAN_CODE128_INSTR_SIZE13);
      }
    } else if((await CmCksys.cmSm52PaletteSystem() != 0) //パレッテ様仕様
        && ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE24) //２４桁値下バーコード
        && (await checkPaletteBarcode(bardata.substring(2))) != 0) {
      //パレット様の２４桁のバーコードの頭に９２が固定になっているかチェック
      C128i.Org_Code = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      cd = Cdigt.cmW3Modulas10(C128i.Org_Code.substring(0,
          notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR), wait1,
          notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      C128i.digit = notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR;
      result = SetJinf.cmMkDscCode3(C128i); //Code128から２段値引バーコード作成
      if ((cd != (C128i.Org_Code.codeUnitAt(notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR) - 0x30)) || (result == NG)) {
        inp.devInf.data = "1234567890123";
      } else {
        C128i.bar2type = 1;
        inp.devInf.data = C128i.Code1.substring(0, ScanCom.SCAN_CODE128_INSTR_SIZE13);
      }
    } else if (((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE24) &&
        (CompileFlag.RESERV_SYSTEM)) {
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);
    } else if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE26) {
      String chk = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA + 21,
          ScanCom.SCAN_OFFSET_DATA + 21 + 4); // print_noのチェック用(タック仕様は0のため)
      if ((pCom.dbTrm.tacFunc != 0) && (int.parse(chk) == 0)) {
        // タック様仕様: 26桁販売期限バーコード
        C128i.Org_Code_SalLmt = bardata.substring(
            ScanCom.SCAN_OFFSET_DATA,
            ScanCom.SCAN_OFFSET_DATA + notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
        cd = Cdigt.cmW3Modulas10(C128i.Org_Code_SalLmt.substring(0,
            notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR), wait1,
            notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
        C128i.digit = notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR;
        result = SetJinf.cmMkSallmtdscCodeLength26(C128i);
        if((cd != (C128i.Org_Code_SalLmt.codeUnitAt(notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR) - 0x30)) || (result == NG)) {
          inp.devInf.data = "1234567890123";
        } else {
          C128i.bar2type = 1;
          inp.devInf.data = C128i.Code1.substring(0, ScanCom.SCAN_CODE128_INSTR_SIZE13);
          inp.devInf.salelmt = "\x30";
          inp.devInf.salelmt += bardata.substring(
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_CODE128_INSTR_SIZE13,
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_CODE128_INSTR_SIZE13 + 6);
          inp.devInf.salelmt += bardata.substring(
              ScanCom.SCAN_OFFSET_DATA + 25,
              ScanCom.SCAN_OFFSET_DATA + 25 + 1);
        }
      } else {
        inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
        inp.devInf.data = bardata.substring(
            ScanCom.SCAN_OFFSET_LABEL_ID,
            ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);
      }
      // // #if 0
      // C128i.Org_Code = bardata.substring(ScanCom.SCAN_OFFSET_DATA, ScanCom.SCAN_OFFSET_DATA + notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      // cd = Cdigt.cmCdigitVariable(C128i.Org_Code, notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      // if(cd != (C128i.Org_Code.codeUnitAt(notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR) - 0x30)) {
      //   inp.devInf.data = "1234567890123";
      // } else {
      //   C128i.bar2type = 1;
      //   inp.devInf.data = bardata.substring(ScanCom.SCAN_OFFSET_DATA, ScanCom.SCAN_OFFSET_DATA + 13);
      //   C128i.Code2 = bardata.substring(ScanCom.SCAN_OFFSET_DATA + 13, ScanCom.SCAN_OFFSET_DATA + 13 + 13);
      //   SetCdig.cmSetCdigit(C128i.Code2);
      // }
      // // #endif
    } else if (((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE28) &&
        (CompileFlag.SALELMT_BAR)) {
      C128i.Org_Code_SalLmt = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      cd = Cdigt.cmW3Modulas10(C128i.Org_Code_SalLmt.substring(0,
          notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR), wait1,
          notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      C128i.digit = notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR;
      result = SetJinf.cmMkSallmtdscCode(C128i);
      if ((cd != (C128i.Org_Code_SalLmt.codeUnitAt(notify.datalen - ScanCom.SCAN_HEADER_LABEL_CD_CR) - 0x30)) || (result == NG)) {
        inp.devInf.data = "1234567890123";
      } else {
        C128i.bar2type = 1;
        inp.devInf.data = C128i.Code1.substring(0, ScanCom.SCAN_CODE128_INSTR_SIZE13);
        if(pCom.dbTrm.discBarcode28d != 0) {
          inp.devInf.barData = bardata.substring(
              ScanCom.SCAN_OFFSET_DATA,
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_CODE128_DATA_SIZE28);
        } else {
          if( notify.data[ScanCom.SCAN_OFFSET_DATA + 19] != '0') {
            inp.devInf.salelmt = "\x30";
          }else {
            inp.devInf.salelmt = "\x00";
          }
          inp.devInf.salelmt += bardata.substring(
              ScanCom.SCAN_OFFSET_DATA + 20,
              ScanCom.SCAN_OFFSET_DATA + 20 + 7);
        }
      }
    } else if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE30) {
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen); //'K'含み
    } else if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE_PBCHG) {
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen); //'K'含み
    } else if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE18) {
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_LABEL);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + inp.devInf.barCdLen); // CR含み
    } else if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE16) {
      /* Z-Member Card or 楽天ポイントカード */
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen); //'K'含み
    } else if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE32) {
      /* Z-FreshZFSP */
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + inp.devInf.barCdLen);
    } else if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE22) {
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA,
          ScanCom.SCAN_OFFSET_DATA + inp.devInf.barCdLen);
    } else if ((notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) == ScanCom.SCAN_CODE128_DATA_SIZE19) {
      // トイザらス会員カード
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen); //'K'含み
    }
  }

  /// NW7コード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、NW7コードに関する部分を分割
  Future<void> devNotifyScannerNw7 (
      TprMsgDevNotify_t notify,  RxInputBuf inp, RxCommonBuf pCom) async {

    String bardata = notify.data.join("");

    if ((await CmCksys.cmDpointSystem() != 0)
        && (notify.datalen == ScanCom.SCAN_NW7_DATA_SIZE18 + ScanCom.SCAN_HEADER_CR)
        && (((notify.data[2] == 'd') && (notify.data[18] == 'd'))
            || ((notify.data[2] == 'D') && (notify.data[18] == 'D')))) {
      inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
      inp.devInf.data =  bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_NW7_DATA_SIZE18);
    } else if ((CmCksys.cmCustrealTpointSystem() != 0)
        && (23 <= notify.datalen) && (notify.datalen <= 35)) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + notify.datalen - ScanCom.SCAN_HEADER_CR);
    } else if((pCom.dbTrm.loasonNw7mbr != 0) &&
        (notify.datalen == ScanCom.SCAN_NW7_DATA_SIZE15 +
            ScanCom.SCAN_HEADER_LABEL_START_STOP_CR)) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA2,
          ScanCom.SCAN_OFFSET_DATA2 + ScanCom.SCAN_NW7_DATA_SIZE15);
    } else if(await CmCksys.cmUTCnctSystem() != 0) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_NW7_DATA_SIZE15);
    } else if (await CmCksys.cmNW7StaffSystem() != 0) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_NW7_DATA_SIZE8);
    }
    // // #if 0
    // else if (await CmCksys.cmNW7StaffSystem() != 0) {
    //   inp.devInf.data = bardata.substring(
    //   ScanCom.SCAN_OFFSET_LABEL_ID,
    //   ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_NW7_DATA_SIZE7);
    // }
    // // #endif
    else if((pCom.dbTrm.crdtUserNo == 1) &&
        (notify.datalen == ScanCom.SCAN_NW7_DATA_SIZE13 +
            ScanCom.SCAN_HEADER_LABEL_START_STOP_CR) &&
        (notify.data[2] == 'a') && (notify.data[16] == 'a')) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + 1)
          + bardata.substring(
              ScanCom.SCAN_OFFSET_DATA2,
              ScanCom.SCAN_OFFSET_DATA2 + ScanCom.SCAN_NW7_DATA_SIZE13);
    } else if ((await CmCksys.cmWsSystem() != 0)
        && (notify.datalen == ScanCom.SCAN_NW7_DATA_SIZE18 + ScanCom.SCAN_HEADER)
        && (notify.data[2] == 'a') && (notify.data[17] == 'a')) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_NW7_DATA_SIZE18);  // CR付き
    } else if ((await CmCksys.cmRepicaSystem() != 0) &&
        (notify.datalen == ScanCom.SCAN_NW7_DATA_SIZE20 + ScanCom.SCAN_HEADER_CR)) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_NW7_DATA_SIZE20);
      // 不具合対応:rcD_Obr()で読込んだバーコードがレピカ仕様であることを特定するためにフラグを立てます。
      ///REPICA.scan_flg = TRUE;
    } else if(((await CmCksys.cmRepicaSystem() != 0) ||
        (await CmCksys.cmRpointSystem() != 0)) &&
        (notify.datalen == ScanCom.SCAN_NW7_DATA_SIZE19 + ScanCom.SCAN_HEADER_CR)) {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_NW7_DATA_SIZE19);
      if (await CmCksys.cmRepicaSystem() != 0) {
        // 不具合対応:rcD_Obr()で読込んだバーコードがレピカ仕様であることを特定するためにフラグを立てます。
        ///REPICA.scan_flg = TRUE;
      }
    } else if (await CmCksys.cmCssEhimedensanSystem() != 0) {
      String mbrbuf = "";
      String mcdbuf = "";

      // NW7の会員コード13桁 を インストア付きの顧客コードに変換
      mcdbuf = bardata.substring(
          ScanCom.SCAN_OFFSET_DATA2 + ScanCom.SCAN_OFFSET_NW7_MCD,
          ScanCom.SCAN_OFFSET_DATA2 + ScanCom.SCAN_OFFSET_NW7_MCD + ScanCom.SCAN_NW7_MCD_SIZE);
      // TODO:変換API実装要（いったん仮実装）
      //cm_mcd_to_mbr(mbrbuf, mcdbuf);
      mbrbuf = "00000" + mcdbuf;
      inp.devInf.data = mbrbuf.substring(0, ScanCom.SCAN_NW7_DATA_SIZE13);
    } else {
      inp.devInf.data = bardata.substring(
          ScanCom.SCAN_OFFSET_LABEL_ID,
          ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_NW7_DATA_SIZE13);
    }
  }

  /// ITFコード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、ITFコードに関する部分を分割
  Future<void> devNotifyScannerItf (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    switch(notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) {
      case ScanCom.SCAN_ITF14_DATA_SIZE:
        if(CmCksys.cmIKEASystem() != 0){
          inp.devInf.data = bardata.substring(
              ScanCom.SCAN_OFFSET_DATA,
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN8_DATA_SIZE);
        } else {
          inp.devInf.data = bardata.substring(
              ScanCom.SCAN_OFFSET_DATA,
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE);
          inp.devInf.itfAmt = bardata.substring(
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE,
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE + 1);
        }
        break;
      case ScanCom.SCAN_ITF16_DATA_SIZE:
        inp.devInf.data = bardata.substring(
            ScanCom.SCAN_OFFSET_DATA,
            ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE);
        inp.devInf.itfAmt = bardata.substring(
            ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE,
            ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_DATA_SIZE + 3);
        break;
      case ScanCom.SCAN_ITF18_DATA_SIZE:
        if (!CompileFlag.ITF18_BARCODE) {
          inp.devInf.data = bardata.substring(
              ScanCom.SCAN_OFFSET_DATA,
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_NOCD_DATA_SIZE);
          inp.devInf.itfAmt = bardata.substring(
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_NOCD_DATA_SIZE,
              ScanCom.SCAN_OFFSET_DATA + ScanCom.SCAN_EAN13_NOCD_DATA_SIZE + ScanCom.SCAN_ITF6_DATA_SIZE);
        }
        break;
      default:
        break;
    }
  }

  /// CODE39コード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、CODE39コードに関する部分を分割
  Future<void> devNotifyScannerCode39 (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    switch(notify.datalen - ScanCom.SCAN_HEADER_LABEL_CR) {
      case ScanCom.SCAN_CODE39_DATA_SIZE8:
        if (CmCksys.cmIKEASystem() != 0) {
          inp.devInf.barCdLen = ScanCom.SCAN_CODE39_DATA_SIZE8;
          inp.devInf.data = bardata.substring(
              ScanCom.SCAN_OFFSET_DATA,
              ScanCom.SCAN_OFFSET_DATA + inp.devInf.barCdLen);
        }
        break;
      case ScanCom.SCAN_CODE39_DATA_SIZE19: /* 会員バーコード */
        if (CmCksys.cmIKEASystem() != 0) {
          inp.devInf.barCdLen = ScanCom.SCAN_CODE39_DATA_SIZE19;
          inp.devInf.data = bardata.substring(
              ScanCom.SCAN_OFFSET_DATA,
              ScanCom.SCAN_OFFSET_DATA + inp.devInf.barCdLen);
        }
        break;
      case ScanCom.SCAN_CODE39_DATA_SIZE23: /* 水道料金バーコード */
        if (await CmCksys.cmPublicBarcodePay2System() != 0) {
          inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
          inp.devInf.data = bardata.substring(
              ScanCom.SCAN_OFFSET_LABEL_ID,
              ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);	// Mを含む
        }
        break;
      default:
        break;
    }
  }

  /// GS1コード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、GS1コードに関する部分を分割
  Future<void> devNotifyScannerGs1 (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER_CR);
    inp.devInf.data = bardata.substring(
        ScanCom.SCAN_OFFSET_LABEL_ID,
        ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);
  }

  /// QRコード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、QRコードに関する部分を分割
  Future<void> devNotifyScannerQr (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER);
    inp.devInf.data = bardata.substring(
        ScanCom.SCAN_OFFSET_LABEL_ID,
        ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);
  }

  /// パスポートコード解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、パスポートコードに関する部分を分割
  Future<void> devNotifyScannerPassport (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER);
    inp.devInf.data = bardata.substring(
        ScanCom.SCAN_OFFSET_LABEL_ID,
        ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);
  }

  /// QRコード（Shop＆GO仕様）解析
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - DevNotifyScannerMain()の中で、Shop&GO仕様のQRコードに関する部分を分割
  Future<void> devNotifyScannerShopAndGo (
      TprMsgDevNotify_t notify,  RxInputBuf inp) async {

    String bardata = notify.data.join("");
    inp.devInf.barCdLen = (notify.datalen - ScanCom.SCAN_HEADER);
    inp.devInf.data = bardata.substring(
        ScanCom.SCAN_OFFSET_LABEL_ID,
        ScanCom.SCAN_OFFSET_LABEL_ID + inp.devInf.barCdLen);
  }

  /// 受信入力バッファセット
  ///
  /// 引数:[inp] バックエンドへの受け渡しデータ
  ///
  /// 引数:[bardata] 受信バーコード生データ
  ///
  /// 戻値:	受信入力バッファ
  ///
  /// 関連tprxソース: rmmain.c - なし
  static RxInputBuf setBuf(RxInputBuf inp, String bardata) {
    if (bardata != "") {
      inp.ctrl.ctrl = true;
      inp.devInf.devId = 1;
      inp.funcCode = FuncKey.KY_PLU.keyId;
      // 入力をそのままPLUコードとする.
      inp.devInf.barData = bardata;
    }
    return inp;
  }
  /*

  /**********************************************************************
      関数：int DevNotifySG_Dev(tprmsgdevnotify_t *notify)
      機能：店員呼出ＳＷ／人検センサー非同期入力イベントメイン関数
      引数：tprmsgdevnotify_t *notify デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevNotifySG_Dev(tprmsgdevnotify_t *notify)
  {
    RX_INPUT_BUF	inp;
    RX_COMMON_BUF	*pCom;

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;
    inp.devInf.dev_id = TPRTIDMASK(notify->tid);
    memcpy(inp.devInf.data, notify->data, notify->length);
    /* 登録タスクへ情報を渡す */
    rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  //	if ((cm_self_system() == 1) && (pCom->db_trm.selfgate_system == 1)) {
      if (((cm_self_system() == 1) && (pCom->ini_macinfo.self_mode == 1)                                      ) ||
          ((cm_quick_self_system() == 1) && (cm_quick_chg_system() == 0) && (pCom->ini_macinfo.self_mode == 0)) ||
          ((cm_quick_self_system() == 1) && (cm_quick_chg_system() == 1) && (pCom->ini_macinfo.self_mode == 1)) ||
          ( cm_QCashier_Mode()                                                                         ) ) {
      if (cm_QCashierJC_system()) {
        if (cm_QCJC_regs_check()) {
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        }
        else {
          return(0);
        }
      }
  #if SMART_SELF
      else if (cm_HappySelf_All_system()) {
        if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_CASH);
        }
      }
  #endif
      else {
        if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_CHK);
        }
      }
    }
    else if(cm_custsw_cnct_system(1)){	/*客側会計スイッチ接続*/
      switch(notify->tid) {
        case TPRDIDDETECT1:
        case TPRDIDDETECT2:
        case TPRDIDDETECT3:
        case TPRDIDDETECT4:
        case TPRDIDDETECT5:
        case TPRDIDDETECT6:
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
            return 0;
  #endif
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK)
            rxQueueWrite(RXQUEUE_CHK);
  #if 0
          if(cmChk2PersonSystem() == 2)
          {
            if( chkInputToSimpleCashier(pCom) == TRUE ) {
              TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDDETECT input. (cashier)\n" );
              if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK)
                rxQueueWrite(RXQUEUE_CASH);
            } else {
              TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDDETECT input.(checker)\n" );
              if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK)
                rxQueueWrite(RXQUEUE_CHK);
            }
          }
          else{
            if ( chkInputToCashier(pCom) == TRUE ) {
              TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDDETECT input. (cashier)\n" );
              if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK)
                rxQueueWrite(RXQUEUE_CASH);
            }
            else{
              TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDDETECT input.(checker)\n" );
              if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK)
                rxQueueWrite(RXQUEUE_CHK);
            }
          }
  #endif
          break;
      }
    }

    return 0;
  }

  /**********************************************************************
      関数：int DevNotifyICCard(tprmsgdevnotify_t *notify)
      機能：USB接続ICカード非同期入力イベントメイン関数
      引数：tprmsgdevnotify_t *notify デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevNotifyICCard(tprmsgdevnotify_t *notify)
  {
    RX_INPUT_BUF	inp;
    RX_COMMON_BUF	*pCom;

    if(notify->data[0] == 0x00)
    {	/* カードなし通知は読み捨てる */
      return 0;
    }

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;
    inp.devInf.dev_id = TPRTIDMASK(notify->tid);

    /* ドライバエラー情報を保存(ちょろ読み、USB接続断エラー) */
    inp.devInf.stat = notify->result;

    memcpy(inp.devInf.data, &notify->data[0], 44);

    /* 入力情報を登録タスクへ渡す */
    rxMemPtr(RXMEM_COMMON, (void **)&pCom);
    switch(notify->tid) {
      case TPRDIDICCARD1:
        TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDICCARD1 input.\n" );
        /* セルフシステム仕様・セルフモード */
        /* クイックセルフ仕様・切り替え仕様・セルフモード */
        /* QCashierモード */
        if (((cm_self_system() == 1) && (pCom->ini_macinfo.self_mode == 1)                                      ) ||

        ((cm_quick_self_system() == 1) && (cm_quick_chg_system() == 0) && (pCom->ini_macinfo.self_mode == 0)) ||
        ((cm_quick_self_system() == 1) && (cm_quick_chg_system() == 1) && (pCom->ini_macinfo.self_mode == 1)) ||
        ( cm_QCashier_Mode()                                                                         ) )
        {
          if (cm_QCashierJC_system())
          {	/* QCashierJC仕様 */
            if(pCom->ini_macinfo.mode == ScanCom.SCAN_HEADER_LABEL_CR && pCom->qcjc_voidmode_flg == 0)
            {	/* 精算機側で訂正モード中 */
              if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK)
              {
                rxQueueWrite(RXQUEUE_CASH);
              }
            }
            else
            {
              if( (pCom->ini_macinfo.mode != ScanCom.SCAN_HEADER_LABEL_CR)
                && (pCom->ini_macinfo.iccard_cnct == 2) )
              {
                if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK)
                {
                  rxQueueWrite(RXQUEUE_CASH);
                }
              }
              else
              {
                /* デバイスIDを偽装 */
                TprLibLogWrite( TPRAID_SYST, 0, 1, "TPRDIDICCARD2 input.\n" );
                inp.devInf.dev_id = TPRDIDICCARD2;
                if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK)
                {
                  rxQueueWrite(RXQUEUE_CHK);
                }
              }
            }
          }
  #if SMART_SELF
          else if(cm_HappySelf_All_system())
          {
            /* HappySelfのQC,フルセルフの場合、キャッシャーへ返す */
            if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK)
            {
              rxQueueWrite(RXQUEUE_CASH);
            }
          }
  #endif
          else
          {	/* QC */
            if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK)
            {
              rxQueueWrite(RXQUEUE_CHK);
            }
          }
        }
        else if(cmChk2PersonSystem() == 2)
        {
          if( chkInputToSimpleCashier(notify, pCom) == TRUE )
          {
            if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK)
            {
              rxQueueWrite(RXQUEUE_CASH);
            }
          }
          else
          {
            if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK)
            {
              rxQueueWrite(RXQUEUE_CHK);
            }
          }
        }
        else
        {
          if ( chkInputToCashier(notify, pCom) == TRUE )
          {
            if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK)
            {
              rxQueueWrite(RXQUEUE_CASH);
            }
          }
          else
          {
            if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK)
            {
              rxQueueWrite(RXQUEUE_CHK);
            }
          }
        }
        break;
      case TPRDIDICCARD2:
        break;
      default:
        break;
    }

    switch(notify->tid) {
      case TPRDIDICCARD1:
      case TPRDIDICCARD2:
        /* syst側で音は出さない */
        break;
      default:
        break;
    }

    return 0;
  }

  /**********************************************************************
      関数：int DevNotifyScalermMain(tprmsgdevnotify_t *notify)
    機能：RM-5900 秤(A/D)非同期入力イベントメイン関数
      引数：tprmsgdevnotify_t *notify デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevNotifyScalermMain(tprmsgdevnotify_t *notify)
  {
    RX_INPUT_BUF	inp;
    RX_COMMON_BUF	*pCom;

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;

    inp.devInf.dev_id = TPRTIDMASK(notify->tid);
    inp.devInf.stat = notify->result;
  #if 0
    if( notify->length >= sizeof(tprmsgdevreq2_t) )
    {
      memcpy(inp.devInf.data, &notify->data[0], sizeof(tprmsgdevreq2_t));
    }
    else
  #endif
    {
      memcpy(inp.devInf.data, &notify->data[0], notify->length);
    }

    /* 登録タスクへ情報を渡す */
  //	if (inp.fnc_code != 0) {
      rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  #if SIMPLE_2STAFF  /* 2004.01.13 */
      /*if(pCom->db_trm.frc_clk_flg == 2)*/
      if(cmChk2PersonSystem() == 2) /* 2011/02/09 */
      {
        //if( chkInputToSimpleCashier(pCom) == TRUE ) {
        if( chkInputToSimpleCashier(notify, pCom) == TRUE ) {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash))
            memcpy(inp.devInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        }
        else
        {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
            memcpy(inp.devInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
      } else
  #endif
      {
        //if ( chkInputToCashier(pCom) == TRUE ) {
        if ( chkInputToCashier(notify, pCom) == TRUE ) {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash))
            memcpy(inp.devInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        } else {
  #if FB_FENCE_OVER || CASH_RECYCLE
          if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
            memcpy(inp.devInf.data, notify, sizeof(tprmsgdevnotify_t));
  #endif
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
      }
  //	}

    return 0;
  }

  /**********************************************************************
      関数：int DevNotifyHiTouchMain(tprmsgdevnotify_t *notify)
    機能：RM-5900 Hi-touch 非同期入力イベントメイン関数
      引数：tprmsgdevnotify_t *notify デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  int DevNotifyHiTouchMain(tprmsgdevnotify_t *notify)
  {
    RX_INPUT_BUF	inp;
    RX_COMMON_BUF	*pCom;

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;

    inp.devInf.dev_id = TPRTIDMASK(notify->tid);
    inp.devInf.stat = notify->result;
  #if 0
    if( notify->length >= sizeof(tprmsgdevreq2_t) )
    {
      memcpy(inp.devInf.data, &notify->data[0], sizeof(tprmsgdevreq2_t));
    }
    else
  #endif
    {
      memcpy(inp.devInf.data, &notify->data[0], notify->length);
    }

    /* ハイタッチ受信へ情報を渡す */
    rxMemPtr(RXMEM_COMMON, (void **)&pCom);
    if (rxMemWrite(RXMEM_HI_TOUCH, &inp) == RXMEM_OK) {
      rxQueueWrite(RXQUEUE_HI_TOUCH);
    }

    return 0;
  }

  /**********************************************************************
      関数：int DevAckMain(tprmsgdevack_t *ack)
      機能：デバイスACKイベントメイン関数
      引数：tprmsgdevack_t *ack デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevAckMain(tprmsgdevack_t *ack)
  {
    switch(ack->tid) {

      case TPRDIDMECKEY1:
      case TPRDIDMECKEY2:
      case TPRDIDMECKEY3:
      case TPRDIDMECKEY4:
      case TPRDIDMECKEY5:
      case TPRDIDMECKEY6:
        break;

      case TPRDIDTOUKEY1:
      case TPRDIDTOUKEY2:
      case TPRDIDTOUKEY3:
      case TPRDIDTOUKEY4:
      case TPRDIDTOUKEY5:
      case TPRDIDTOUKEY6:
        break;

      case TPRDIDSPEAKER1:
      case TPRDIDSPEAKER2:
      case TPRDIDSPEAKER3:
      case TPRDIDSPEAKER4:
      case TPRDIDSPEAKER5:
      case TPRDIDSPEAKER6:
        break;

      case TPRDIDFIP1:
      case TPRDIDFIP2:
      case TPRDIDFIP3:
      case TPRDIDFIP4:
      case TPRDIDFIP5:
      case TPRDIDFIP6:
        break;

      case TPRDIDLCDDSP1:
      case TPRDIDLCDDSP2:
      case TPRDIDLCDDSP3:
      case TPRDIDLCDDSP4:
      case TPRDIDLCDDSP5:
      case TPRDIDLCDDSP6:
        DevAckLcdDspMain(ack);
        break;

      case TPRDIDSCANNER1:
      case TPRDIDSCANNER2:
      case TPRDIDSCANNER3:
      case TPRDIDSCANNER4:
      case TPRDIDSCANNER5:
      case TPRDIDSCANNER6:
        break;

      case TPRDIDWDSCAN1:
      case TPRDIDWDSCAN2:
      case TPRDIDWDSCAN3:
      case TPRDIDWDSCAN4:
      case TPRDIDWDSCAN5:
      case TPRDIDWDSCAN6:
        break;

      case TPRDIDCHANGER1:
      case TPRDIDCHANGER2:
      case TPRDIDCHANGER3:
      case TPRDIDCHANGER4:
      case TPRDIDCHANGER5:
      case TPRDIDCHANGER6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDCOMUSB1:
      case TPRDIDCOMUSB2:
      case TPRDIDCOMUSB3:
      case TPRDIDCOMUSB4:
      case TPRDIDCOMUSB5:
      case TPRDIDCOMUSB6:
        break;

      case TPRDIDRECEIPT1:
      case TPRDIDRECEIPT2:
        break;
      case TPRDIDRECEIPT3:
      case TPRDIDRECEIPT4:
      case TPRDIDRECEIPT5:
      case TPRDIDRECEIPT6:
        DevAckReceiptMain((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDTOKYURW1:
      case TPRDIDTOKYURW2:
      case TPRDIDTOKYURW3:
      case TPRDIDTOKYURW4:
      case TPRDIDTOKYURW5:
      case TPRDIDTOKYURW6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDDEBIT1:
      case TPRDIDDEBIT2:
      case TPRDIDDEBIT3:
      case TPRDIDDEBIT4:
      case TPRDIDDEBIT5:
      case TPRDIDDEBIT6:
        break;

      case TPRDIDGLORYCARD1:
      case TPRDIDGLORYCARD2:
      case TPRDIDGLORYCARD3:
      case TPRDIDGLORYCARD4:
      case TPRDIDGLORYCARD5:
      case TPRDIDGLORYCARD6:
        break;

      case TPRDIDVISMAC1:
      case TPRDIDVISMAC2:
      case TPRDIDVISMAC3:
      case TPRDIDVISMAC4:
      case TPRDIDVISMAC5:
      case TPRDIDVISMAC6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDPRSP1:
      case TPRDIDPRSP2:
      case TPRDIDPRSP3:
      case TPRDIDPRSP4:
      case TPRDIDPRSP5:
      case TPRDIDPRSP6:
        break;

      case TPRDIDMGC1JIS1:
      case TPRDIDMGC2JIS1:
      case TPRDIDMGC3JIS1:
      case TPRDIDMGC4JIS1:
      case TPRDIDMGC5JIS1:
      case TPRDIDMGC6JIS1:
        break;

      case TPRDIDMGC1JIS2:
      case TPRDIDMGC2JIS2:
      case TPRDIDMGC3JIS2:
      case TPRDIDMGC4JIS2:
      case TPRDIDMGC5JIS2:
      case TPRDIDMGC6JIS2:
        break;

      case TPRDIDGCAT1:
      case TPRDIDGCAT2:
      case TPRDIDGCAT3:
      case TPRDIDGCAT4:
      case TPRDIDGCAT5:
      case TPRDIDGCAT6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDPRT1:
      case TPRDIDPRT2:
      case TPRDIDPRT3:
      case TPRDIDPRT4:
      case TPRDIDPRT5:
      case TPRDIDPRT6:
        break;

      case TPRDIDLCDBRT1:
      case TPRDIDLCDBRT2:
      case TPRDIDLCDBRT3:
      case TPRDIDLCDBRT4:
      case TPRDIDLCDBRT5:
      case TPRDIDLCDBRT6:
        break;

      case TPRDIDSCALE1:
      case TPRDIDSCALE2:
      case TPRDIDSCALE3:
      case TPRDIDSCALE4:
      case TPRDIDSCALE5:
      case TPRDIDSCALE6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDORC1:
      case TPRDIDORC2:
      case TPRDIDORC3:
      case TPRDIDORC4:
      case TPRDIDORC5:
      case TPRDIDORC6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDSGSCALE1:
      case TPRDIDSGSCALE2:
      case TPRDIDSGSCALE3:
      case TPRDIDSGSCALE4:
      case TPRDIDSGSCALE5:
      case TPRDIDSGSCALE6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDCALLSW1:
      case TPRDIDCALLSW2:
      case TPRDIDCALLSW3:
      case TPRDIDCALLSW4:
      case TPRDIDCALLSW5:
      case TPRDIDCALLSW6:
        break;

      case TPRDIDDETECT1:
      case TPRDIDDETECT2:
      case TPRDIDDETECT3:
      case TPRDIDDETECT4:
      case TPRDIDDETECT5:
      case TPRDIDDETECT6:
        break;

      case TPRDIDEDY1:
      case TPRDIDEDY2:
      case TPRDIDEDY3:
      case TPRDIDEDY4:
      case TPRDIDEDY5:
      case TPRDIDEDY6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDCRWP1:
      case TPRDIDCRWP2:
      case TPRDIDCRWP3:
      case TPRDIDCRWP4:
      case TPRDIDCRWP5:
      case TPRDIDCRWP6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDSTPR1:
      case TPRDIDSTPR2:
        break;
      case TPRDIDSTPR3:
        DevAckReceiptMain((tprmsgdevack2_t *)ack);
        break;
      case TPRDIDSTPR4:
      case TPRDIDSTPR5:
      case TPRDIDSTPR6:
        break;

      case TPRDIDPANA1:
      case TPRDIDPANA2:
      case TPRDIDPANA3:
      case TPRDIDPANA4:
      case TPRDIDPANA5:
      case TPRDIDPANA6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDPW1:
      case TPRDIDPW2:
      case TPRDIDPW3:
      case TPRDIDPW4:
      case TPRDIDPW5:
      case TPRDIDPW6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

  // <2004.07.15> mn
      case TPRDIDCCR1:
      case TPRDIDCCR2:
      case TPRDIDCCR3:
      case TPRDIDCCR4:
      case TPRDIDCCR5:
      case TPRDIDCCR6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;
  // -----

      case TPRDIDDISH1:
      case TPRDIDDISH2:
      case TPRDIDDISH3:
      case TPRDIDDISH4:
      case TPRDIDDISH5:
      case TPRDIDDISH6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDRFID1:
      case TPRDIDRFID2:
      case TPRDIDRFID3:
      case TPRDIDRFID4:
      case TPRDIDRFID5:
      case TPRDIDRFID6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDSUICA1:
      case TPRDIDSUICA2:
      case TPRDIDSUICA3:
      case TPRDIDSUICA4:
      case TPRDIDSUICA5:
      case TPRDIDSUICA6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDSMTPLUS1:
      case TPRDIDSMTPLUS2:
      case TPRDIDSMTPLUS3:
      case TPRDIDSMTPLUS4:
      case TPRDIDSMTPLUS5:
      case TPRDIDSMTPLUS6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDDISHT1:
      case TPRDIDDISHT2:
      case TPRDIDDISHT3:
      case TPRDIDDISHT4:
      case TPRDIDDISHT5:
      case TPRDIDDISHT6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      /* 音声合成装置'AR-STTS-01'											*/
      case TPRDIDARSTTS1:
      case TPRDIDARSTTS2:
        break;
      case TPRDIDARSTTS3:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;
      case TPRDIDARSTTS4:
      case TPRDIDARSTTS5:
      case TPRDIDARSTTS6:
        break;

      case TPRDIDMCP1:
      case TPRDIDMCP2:
      case TPRDIDMCP3:
      case TPRDIDMCP4:
      case TPRDIDMCP5:
      case TPRDIDMCP6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDFCL1:
      case TPRDIDFCL2:
      case TPRDIDFCL3:
      case TPRDIDFCL4:
      case TPRDIDFCL5:
      case TPRDIDFCL6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDGP1:
      case TPRDIDGP2:
      case TPRDIDGP3:
      case TPRDIDGP4:
      case TPRDIDGP5:
      case TPRDIDGP6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDABSV311:
      case TPRDIDABSV312:
      case TPRDIDABSV313:
      case TPRDIDABSV314:
      case TPRDIDABSV315:
      case TPRDIDABSV316:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDYAMATO1:
      case TPRDIDYAMATO2:
      case TPRDIDYAMATO3:
      case TPRDIDYAMATO4:
      case TPRDIDYAMATO5:
      case TPRDIDYAMATO6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDCCT1:
      case TPRDIDCCT2:
      case TPRDIDCCT3:
      case TPRDIDCCT4:
      case TPRDIDCCT5:
      case TPRDIDCCT6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDJMUPS1:
      case TPRDIDJMUPS2:
      case TPRDIDJMUPS3:
      case TPRDIDJMUPS4:
      case TPRDIDJMUPS5:
      case TPRDIDJMUPS6:
        DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

                  case TPRDIDSQRC1:
                  case TPRDIDSQRC2:
                  case TPRDIDSQRC3:
                  case TPRDIDSQRC4:
                  case TPRDIDSQRC5:
                  case TPRDIDSQRC6:
                          DevAckDataSend((tprmsgdevack2_t *)ack);
                          break;

      case TPRDIDICCARD1:
      case TPRDIDICCARD2:
      case TPRDIDICCARD3:
      case TPRDIDICCARD4:
      case TPRDIDICCARD5:
      case TPRDIDICCARD6:
        break;

      case TPRDIDPSENSOR1:
      case TPRDIDPSENSOR2:
      case TPRDIDPSENSOR3:
      case TPRDIDPSENSOR4:
      case TPRDIDPSENSOR5:
      case TPRDIDPSENSOR6:
        break;

      case TPRDIDMST1:
      case TPRDIDMST2:
      case TPRDIDMST3:
      case TPRDIDMST4:
      case TPRDIDMST5:
      case TPRDIDMST6:
                          DevAckDataSend((tprmsgdevack2_t *)ack);
        break;

      case TPRDIDAPBF1:
        break;

                  case TPRDIDEXC1:
                          break;

      case TPRDIDHITOUCH1:
        break;

      case TPRDIDAMI1:
        break;

      default:
        break;
    }

    return 0;
  }


  /**********************************************************************
      関数：int DevAckLcdDspMain(tprmsgdevack_t *ack)
      機能：LCDディスプレイACKイベントメイン関数
      引数：tprmsgdevack_t *ack デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevAckLcdDspMain(tprmsgdevack_t *ack)
  {
    char	log[512];

    if ((ack->data[1] == 0x00) && (ack->data[2] == 0x00)) {
      return 0;
    }

    memset(log, 0x00, sizeof(log));
    sprintf(log, "Devack error: tid[%04ld] cmd[%02x] data[%02x%02x]\n",
                 ack->tid,
                 ack->data[0],
                 ack->data[3],
                 ack->data[2]);
    TprLibLogWrite( 0, -1, 0, log );

    return 0;
  }

*/
  /// 関数：setBuf2(var inputData, TprMsgDevAck2_t ack, int flg)
  /// 機能：TprMsgDevAck2_tのデータをRxInputBufに設定する関数
  /// 引数：var inputData　入力情報 or 印字ステータス
  ///     ：tprmsgdevack2_t ack デバイスからの受け取りデータ
  ///     : int flg 入力情報 or 印字ステータス
  /// 戻値：0:終了
  /// 関連tprxソース: rmmain.c - DevAckReceiptMain()
  static int setBuf2(var inputData, TprMsgDevAck2_t ack, int flg) {
    if (flg == 0) { // RxInputBufにTprMsgDevAck2_tを設定
      var inp = inputData as RxInputBuf;
      inp.ctrl.ctrl = true;
      inp.devInf.devId = ack.tid;
      inp.devInf.data = ack.mid.toString();
      inp.devInf.data += ack.length.toString();
      inp.devInf.data += ack.tid.toString();
      inp.devInf.data += ack.src.toString();
      inp.devInf.data += ack.io.toString();
      inp.devInf.data += ack.result.toString();
      inp.devInf.data += ack.datalen.toString();
      inp.devInf.data += ack.data.join("");
    } else if (flg == 1){ // RxPrnStatにTprMsgDevAck2_tを設定
      var stat = inputData as RxPrnStat;
      stat.Ctrl.ctrl = true;
      stat.DevInf.devId = ack.tid;
      stat.DevInf.data = ack.mid.toString();
      stat.DevInf.data += ack.length.toString();
      stat.DevInf.data += ack.tid.toString();
      stat.DevInf.data += ack.src.toString();
      stat.DevInf.data += ack.io.toString();
      stat.DevInf.data += ack.result.toString();
      stat.DevInf.data += ack.datalen.toString();
      stat.DevInf.data += ack.data.join("");
    } else {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "setBuf2 invalid flg [$flg]");
      return -1;
    }
    return 0;
  }

  /// 関数：int DevAckReceiptMain(tprmsgdevack2_t *ack)
  /// 機能：レシートプリンタACKイベントメイン関数
  /// 引数：tprmsgdevack2_t *ack デバイスからの受け取りデータのポインタ
  /// 戻値：0:終了
  /// 関連tprxソース: rmmain.c - DevAckReceiptMain()
  Future<int> devAckReceiptMain(TprMsgDevAck2_t ack) async {
    RxInputBuf inp = RxInputBuf();
    RxPrnStat stat = RxPrnStat();

  // TODO:コンパイルSW
  // #if FB_FENCE_OVER
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "devNotifyScannerMain rxMemRead COMMON error!!");
      return -1;
    }
    RxCommonBuf pCom = xRetC.object;
  // #endif
    String erlog = "";

    switch (ack.src) {
      case 1:		/* Dummy by K.Makino */
      case Tpraid.TPRAID_CHK:
        setBuf2(inp, ack, 0);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_CASH_INP, inp, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          // rxQueueWrite(RXQUEUE_CHK);
        }
        break ;
      case Tpraid.TPRAID_CASH:
        setBuf2(inp, ack, 0);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_CASH_INP, inp, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite(RXQUEUE_CASH);
        }
        break ;
      case Tpraid.TPRAID_PRN:
        RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_PRN_STAT);
        if (xRetC.isInvalid()) {
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
              "devNotifyScannerMain rxMemRead RXMEM_PRN_STAT error!!");
          return -1;
        }
        stat = xRetC.object;

        if( ack.result == 0 ) {
          stat.DevInf.stat = 0;
        } else {
          try {
            if(stat.DevInf.stat == 0) {
              int value = int.parse(ack.data[3]);
              stat.DevInf.stat = value;
            }
          } catch (e){
          }
        }
        setBuf2(stat, ack, 1);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_PRN_STAT, stat, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite(RXQUEUE_PRN_STAT);
        }
        break;
      case Tpraid.TPRAID_QCJC_C_PRN:
        setBuf2(stat, ack, 1);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_QCJC_C_PRN_STAT, stat, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite(RXQUEUE_QCJC_C_PRN_STAT);
        }
        break;
      case Tpraid.TPRAID_KITCHEN1_PRN:
        setBuf2(stat, ack, 1);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_KITCHEN1_PRN_STAT, stat, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite (RXQUEUE_KITCHEN1_PRN_STAT);
        }
        break;
      case Tpraid.TPRAID_KITCHEN2_PRN:
        setBuf2(stat, ack, 1);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_KITCHEN2_PRN_STAT, stat, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite (RXQUEUE_KITCHEN2_PRN_STAT);
        }
        break;
      case Tpraid.TPRAID_STPR:
        setBuf2(stat, ack, 1);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STPR_STAT, stat, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite(RXQUEUE_STPR_STAT);
        }
        break;
      case Tpraid.TPRAID_S2PR:
        setBuf2(stat, ack, 1);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_S2PR_STAT, stat, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite(RXQUEUE_S2PR_STAT);
        }
        break;
  // TODO:コンパイルSW
  // #if FB_FENCE_OVER
      case Tpraid.TPRAID_FENCE_OVER:
        setBuf2(inp, ack, 0);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_FENCE_OVER, inp, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite(RXQUEUE_FENCE_OVER);
        }
        break;
      case Tpraid.TPRAID_QCJC_C_MNTPRN:
        setBuf2(inp, ack, 0);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_CHK_INP, inp, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite(RXQUEUE_CHK);
        }
        break;
      case Tpraid.TPRAID_MNTSPL:
        erlog = "DevAckReceiptMain SPL io[${ack.io}] src[${ack.src}] tid[${ack.tid}]";
        TprLog().logAdd(0, LogLevelDefine.error, erlog);
        setBuf2(inp, ack, 0);
        if(( await chkInputToCashier(null, pCom) == TRUE ) && (ack.tid != Tpraid.TPRAID_QCJC_C_MNTPRN) && (ack.tid != Tpraid.TPRAID_QCJC_C_PRN)) {	/* Cashier */
           xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_CASH_INP, inp, RxMemAttn.MAIN_TASK, "");
           if (xRetC.result == RxMem.RXMEM_OK) {
            //rxQueueWrite(RXQUEUE_CASH);
            }
        }
        else{		/* Checker */
           xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_CHK_INP, inp, RxMemAttn.MAIN_TASK, "");
           if (xRetC.result == RxMem.RXMEM_OK) {
            //rxQueueWrite(RXQUEUE_CHK);
          }
        }
        break;
  //#endif
  // TODO:コンパイルSW
  //#if CASH_RECYCLE
      case Tpraid.TPRAID_CASH_RECYCLE:
        setBuf2(inp, ack, 0);
        xRetC = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_CASH_RECYCLE, inp, RxMemAttn.MAIN_TASK, "");
        if (xRetC.result == RxMem.RXMEM_OK) {
          //rxQueueWrite(RXQUEUE_CASH_RECYCLE);
        }
        break;
  //#endif
      default :
        break;
    }

    return 0;
  }

/*
  /**********************************************************************
      関数：int DevAckDataSend(tprmsgdevack2_t *ack)
      機能：デバイスACKデータ送信関数(その他共通)
      引数：tprmsgdevack2_t *ack デバイスからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int DevAckDataSend(tprmsgdevack2_t *ack)
  {
    RX_INPUT_BUF inp;

  #if FB_FENCE_OVER
    RX_COMMON_BUF	*pCom;
  #endif

  #if FB_FENCE_OVER
    if(rxMemPtr(RXMEM_COMMON, (void **)&pCom) == RXMEM_NG) {
      TprLibLogWrite( 0, TPRLOG_ERROR, 0, "DevAckDataSend:rxMemPtr(RXMEM_COMMON) error\n" );
      return -1;
    }
  #endif

    /* 入力情報作成 */
    memset(&inp, 0, sizeof(inp));
    inp.Ctrl.ctrl = 1;
    inp.devInf.dev_id = TPRTIDMASK(ack->tid);
    memcpy(inp.devInf.data, ack, sizeof(tprmsgdevack_t));

    /* 入力情報を登録タスクへ渡す */
    switch (ack->src) {
      case 1:		/* Dummy by K.Makino */
      case TPRAID_CHK:
        if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_CHK);
        }
        break;
      case TPRAID_CASH:
        if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_CASH);
        }
        break;
                  case TPRAID_ACX:
        if (rxMemWrite(RXMEM_ACX_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_ACX);
        }
        break;
                  case TPRAID_JPO:
                          if (rxMemWrite(RXMEM_JPO_STAT, &inp) == RXMEM_OK) {
                                  rxQueueWrite(RXQUEUE_JPO);
                          }
                          break;
      case TPRAID_SCL:
        if (rxMemWrite(RXMEM_SCL_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_SCL);
        }
        break;
                  case TPRAID_RWC:
        if (rxMemWrite(RXMEM_RWC_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_RWC);
        }
        break;
      case TPRAID_SGSCL1:
        if (rxMemWrite(RXMEM_SGSCL1_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_SGSCL1);
        }
        break;
      case TPRAID_SGSCL2:
        if (rxMemWrite(RXMEM_SGSCL2_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_SGSCL2);
        }
        break;
      case TPRAID_SUICA:
        if (rxMemWrite(RXMEM_SUICA_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_SUICA);
        }
        break;
  #if FB_FENCE_OVER
      case TPRAID_FENCE_OVER:
        if (rxMemWrite(RXMEM_FENCE_OVER, &inp) == RXMEM_OK)
          rxQueueWrite(RXQUEUE_FENCE_OVER);
        break;
  #endif
  #if CASH_RECYCLE
      case TPRAID_CASH_RECYCLE:
        if (rxMemWrite(RXMEM_CASH_RECYCLE, &inp) == RXMEM_OK)
          rxQueueWrite(RXQUEUE_CASH_RECYCLE);
        break;
  #endif
                  case TPRAID_MULTI:
        if (rxMemWrite(RXMEM_MULTI_STAT, &inp) == RXMEM_OK) {
          rxQueueWrite(RXQUEUE_MULTI);
        }
        break;

  #if FB_FENCE_OVER
      case TPRAID_CHPRICE :
        if ( chkInputToCashier(NULL, pCom) == TRUE ) {	/* Cashier ? */
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        }
        else{		/* Checker */
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }

        break;
  #endif
                  case TPRAID_SQRC:
                          if (rxMemWrite(RXMEM_SQRC, &inp) == RXMEM_OK) {
                                  rxQueueWrite(RXQUEUE_SQRC);
                          }
                          break;

  #if FB_FENCE_OVER
      // 登録 メンテナンス画面で　[釣機再精査]acx_recalc へキュー通知
      case TPRAID_REPT:
        if ( chkInputToCashier(NULL, pCom) == TRUE ) {	/* Cashier ? */
          if (rxMemWrite(RXMEM_CASH_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CASH);
          }
        }
        else{		/* Checker */
          if (rxMemWrite(RXMEM_CHK_INP, &inp) == RXMEM_OK) {
            rxQueueWrite(RXQUEUE_CHK);
          }
        }
        break;
  #endif

      default :
        break;
    }

    return 0;
  }


  /**********************************************************************
      関数：int AplNotifyMain(tprapl_t *apl)
      機能：アプリケーション非同期イベントメイン関数
      引数：tprapl_t *p アプリからの受け取りデータのポインタ
      戻値：0:終了
  ***********************************************************************/
  static
  int AplNotifyMain(tprapl_t *apl)
  {
    RX_COMMON_BUF   *pCom;
    int	opncls_mode = 0;
    char    tmp[TEMP_BUF_SIZ];
    char    fname[TEMP_BUF_SIZ];
    char    aplini[TPRMAXPATHLEN];
    char    buf[4];
    short   ret;
    int     dualdisp_chk;
    int     vfhd_fself_chk;
    RX_TASKSTAT_BUF	*TS_BUF;
    short	cnt;

    vfhd_fself_chk = 0;

    if(rxMemPtr(RXMEM_COMMON, (void **)&pCom) == RXMEM_NG) {
          TprLibLogWrite( 0, TPRLOG_ERROR, 0, "AplNotifyMain:rxMemPtr(RXMEM_COMMON) error\n" );
          return( -1 );
    }
    /* 登録モード終了判定*/
    if ((apl->errnum & RXSYS_MSG_MASK) == RXSYS_MSG_REGSEND) {

  #if _RMMAIN_C_DEBUG_
      log_printf("チェッカータスクから終了通知受け取り\n");
  #endif

      TprLibLogWrite(0,TPRLOG_NORMAL,0,"REGS END => TPRTST_IDLE");
      SysNotifySend( TPRTST_IDLE );

      ChgMacInfoIni("0");

      if(AplLib_Auto_StrCls(0))
      {
        sleep(1);
        if((rxMemPtr(RXMEM_STAT, (void **)&TS_BUF) == RXMEM_OK)	&&
           (TS_BUF->chk.regs_start_flg))
        {
          TprLibLogWrite(0,TPRLOG_ERROR, -1, "REGS END WAIT");
          for(cnt = 0; cnt <= 30; cnt ++)
          {
            if(!TS_BUF->chk.regs_start_flg)
            {
              TprLibLogWrite(0,TPRLOG_NORMAL, 1, "REGS END OK");
              break;
            }
            sleep(1);
          }
          if(TS_BUF->chk.regs_start_flg)
          {
            TprLibLogWrite(0,TPRLOG_NORMAL, 1, "REGS NOT END: FORCE");
          }
        }
      }

      if(cm_self_system())	/*自動精算終了時self_modeを戻す為 */
        rmIniReadMain();
  #if SIMPLE_2STAFF /* 04.01.20 */
      if(pCom->db_trm.frc_clk_flg == 2)
        mainmenu_redisplay(0);
  #endif
      /* 自動開閉設仕様：自動閉店 */
      if( AplLib_Auto_StrCls(0) ){
        RegEnd_AutoStrCls_Judg();
  //			auto_strcls_judg( ); /* 次の自動閉店処理へ */
      }
      return 0;
    }

    /* オープンクローズ移行判定 */
    if ((((apl->errnum & RXSYS_MSG_MASK) == RXSYS_MSG_OPNCLS)
     || ((apl->errnum & RXSYS_MSG_MASK) == RXSYS_MSG_OPNCLS_2))){
  #if _RMMAIN_C_DEBUG_
      log_printf("チェッカータスクからオープンクローズ移行通知受け取り\n");
  #endif
      SysNotifySend( TPRTST_STATUS02 );
      ChgMacInfoIni("2");
  //		ChgMacInfoIni("0");        /* 2001/06/21 T.Sangu */
      if((apl->errnum & RXSYS_MSG_MASK) == RXSYS_MSG_OPNCLS_2)
      {
        opncls_mode =1;
      }
      TprLibLogWrite(0,-1,opncls_mode,"SYS:open-close main calln\n");
      opncls_main(opncls_mode);
      return 0;
    }

  #if SMART_SELF
    if ((apl->errnum & RXSYS_MSG_MASK) == RXSYS_MSG_REGS_RESTART) {
  #if _RMMAIN_C_DEBUG_
      log_printf("チェッカータスクから登録再移行通知受け取り\n");
  #endif
      TprLibLogWrite(0, TPRLOG_NORMAL, 0, "SYS : Regs Restart\n");
  //		rmIniReadMain();
      CommonMemory_Read2();
      if (cm_HappySelf_All_system())
      {
        pCom->only_optwin_disp_flg = 0;
        if (pCom->add_tpanel_connect == 1)
        {
          if ((cmChkVerticalFHDSystem())	/* 縦型21.5インチ */
           && (cm_chk_vtcl_FHD_fself_system ()))	/* 縦型15.6インチ対面 */
          {
            vfhd_fself_chk = 1;
          }
          dualdisp_chk = 1;
          memset(aplini, 0x0, sizeof(aplini));
          memset(buf, 0x0, sizeof(buf));
          snprintf(aplini, sizeof(aplini), "%s/conf/qcashier.json", (uchar *)getenv("TPRX_HOME"));
          ret = TprLibGetIni(aplini, "common", "hs_dualdisp_chk", buf);
          if (ret == 0)
            dualdisp_chk = atoi(buf);

          // G3対面はタイミングを変更
          if ((dualdisp_chk == 0)
           && (vfhd_fself_chk == 0))	/* 15.6インチ対面機種の時は以下のif文のチェックを必ず行わせたい */
          {
            if ((pCom->ini_macinfo.self_mode == 1) || (pCom->ini_macinfo.qc_mode == 1))
            {
              memset(tmp, 0x0, sizeof(tmp));
              memset(fname, 0x0, sizeof(fname));
              snprintf(fname, sizeof(fname), "%s/conf/image/hs_staffside_dsp.png", getenv("TPRX_HOME"));
              snprintf(tmp, sizeof(tmp), "%s/apl/fb_stimg %d 0 0 1024 768 0 0 0 %s", getenv("TPRX_HOME"), 0, fname);
              system(tmp);
              pCom->only_optwin_disp_flg = 1;
            }
          }
        }
      }
      if (pCom->ini_macinfo.mode == 4)
      {
        SysNotifySend(TPRTST_STATUS04);
        ChgMacInfoIni("4");
      }
      else
      {
        SysNotifySend(TPRTST_STATUS01);
        ChgMacInfoIni("1");
      }

      // 処理が早過ぎて？登録画面が消えなくなる場合がある為、0.4秒の安全マージンをとる
      usleep(400000);
      rmMain();
      if (vfhd_fself_chk == 1)	/* 15.6インチ対面機種の時は以下のif文のチェックを必ず行わせたい */
      {
        if ((pCom->ini_macinfo.self_mode == 1) || (pCom->ini_macinfo.qc_mode == 1))
        {
          memset(tmp, 0x0, sizeof(tmp));
          memset(fname, 0x0, sizeof(fname));
          snprintf(fname, sizeof(fname), "%s/conf/image/hs_staffside_dsp.png", getenv("TPRX_HOME"));
          snprintf(tmp, sizeof(tmp), "%s/apl/fb_stimg %d 0 0 1024 768 0 0 0 %s", getenv("TPRX_HOME"), 0, fname);
          system(tmp);
          pCom->only_optwin_disp_flg = 1;
        }
      }
      return 0;
    }
  #endif

    return 0;
  }


  /**********************************************************************
      関数：int ChgMacInfoIni(char *str)
      機能：モードフラグ書き換え(mac_info.ini の mode)
      引数：char *str書き換える文字列のポインタ
      戻値：0:終了
  ***********************************************************************/
  int ChgMacInfoIni(char *str)
  {
    char	filename[256];
    RX_COMMON_BUF	*pCom;
    char	log[256];

    /* ファイル書き換え */
    memset(filename, 0, sizeof(filename));
    strcpy(filename, SysHomeDirp);
    strcat(filename, "/conf/mac_info.ini");
    if(TprLibSetIni(filename, "internal_flg", "mode", str)) {
          snprintf( log, sizeof(log), "ChgMacInfoIni:TprLibSetIni[%s][internal_flg][mode] error\n", filename );
          TprLibLogWrite( 0, TPRLOG_ERROR, 0, log );
          return( -1 );
    }


    /* 共通メモリ書き換え */
    if(rxMemPtr(RXMEM_COMMON, (void **)&pCom) == RXMEM_NG) {
          TprLibLogWrite( 0, TPRLOG_ERROR, 0, "ChgMacInfoIni:rxMemPtr(RXMEM_COMMON) error\n" );
          return( -1 );
    }
    pCom->ini_macinfo.mode = atoi(str);

    return 0;
  }

  static int CommonMemory_Read2(void)
  {
     int result;

     result = rmIniReadMain();
     if(result == 0)
        result = rmDbReadMain2(0);
     return result;
  }

  #ifndef FB2GTK
  static void StoreCloseCall(void)
  {
    RX_COMMON_BUF	*pCom;
    rxMemPtr(RXMEM_COMMON, (void **)&pCom);

    if (msg_timer != -1)
    {
      gtk_timeout_remove(msg_timer);
      msg_timer = -1;
    }

    pCom->another_layer = 0;
    SysNotifySend( TPRTST_IDLE );
    CommonMemory_Read2();
    rmStoreCloseMain();
    pCom->batch_rpt_flag = 0;
    return;
  }
  #endif

  static void bkupd_play_DlgClear(void)
  {
    bp_dlg_flg = 0;
    TprLibDlgClear();
  }
  */



  /*
  /**********************************************************************
      関数：short   masr_date_separate
      機能：自走式磁気カードイベント分解関数
      引数：tprmsgdevack2_t *ack デバイスからの受け取りデータのポインタ
          　RX_INPUT_BUF *inp1　　JIS1データ
          　RX_INPUT_BUF *inp2　　JIS2データ
      戻値：0:データ無し  1:JIS1のみ  2:JIS2のみ   3:JIS1+JIS2
  ***********************************************************************/
  static short   masr_date_separate(TPRTID tid, tprmsgdevack2_t *ack2,  tprmsgdevnotify_t *notify1, tprmsgdevnotify_t *notify2)
  {
          t_MasrReadData  tMasrReadData;
          int             ret;
          char            erlog[128];

          memset(&tMasrReadData, 0x0, sizeof(t_MasrReadData));
          ret = if_masr_read_separate(tid, &ack2->data[MASR_READ_RES_MINSIZ], ack2->datalen - MASR_READ_RES_MINSIZ,&tMasrReadData);
          if(ret != MASR_RES_NORMAL) {
                  snprintf(erlog, sizeof(erlog), "%s if_masr_read_separate() Error[%d]\n", __FUNCTION__, ret);
                  TprLibLogWrite(tid,TPRLOG_ERROR, -1, erlog);
                  return(0);
          }

          ret = 0;
          if(tMasrReadData.ISO_Track2Len > 0){
                  if (cnct_mem_get_type(tid, CNCT_MASR_CNCT, CNCT_GETMEM_JC_J) != 0)
                          notify1->tid = TPRDIDMGC1JIS1;
                  else
                          notify1->tid = TPRDIDMGC2JIS1;
      notify1->mid = ack2->mid;
      notify1->length = sizeof(tprmsgdevnotify_t) - sizeof(tprcommon_t) - sizeof(notify1->data) + tMasrReadData.ISO_Track2Len;
      notify1->io = TPRDEVIN;
      notify1->result = ack2->result;
      memset(notify1->data, 0x00, sizeof(notify1->data));
      memcpy(notify1->data, tMasrReadData.ISO_Track2, tMasrReadData.ISO_Track2Len);
      notify1->datalen = tMasrReadData.ISO_Track2Len;
                  snprintf(erlog, sizeof(erlog), "%s : Get JIS1\n", __FUNCTION__);
                  TprLibLogWrite(tid,TPRLOG_NORMAL, 0, erlog);
                  ret = 1;
          }

          if(tMasrReadData.JIS2_TrackLen > 0){
                  if (cnct_mem_get_type(tid, CNCT_MASR_CNCT, CNCT_GETMEM_JC_J) != 0)
                          notify2->tid = TPRDIDMGC1JIS2;
                  else
                          notify2->tid = TPRDIDMGC2JIS2;
      notify2->mid = ack2->mid;
      notify2->length = sizeof(tprmsgdevnotify_t) - sizeof(tprcommon_t) - sizeof(notify2->data) + tMasrReadData.JIS2_TrackLen;
      notify2->io = TPRDEVIN;
      notify2->result = ack2->result;
      memset(notify2->data, 0x00, sizeof(notify2->data));
      memcpy(notify2->data, tMasrReadData.JIS2_Track, tMasrReadData.JIS2_TrackLen);
      notify2->datalen = tMasrReadData.JIS2_TrackLen;
                  snprintf(erlog, sizeof(erlog), "%s : Get JIS2\n", __FUNCTION__);
                  TprLibLogWrite(tid,TPRLOG_NORMAL, 0, erlog);
                  ret = (ret == 1)? 3:2;
          }

          return(ret);
  }


  static int DevNotifyMASR_JIS(tprmsgdevack2_t *ack2)
  {
    tprmsgdevnotify_t	notify1;
    tprmsgdevnotify_t	notify2;
    int	ret;

    TprLibLogWrite(0,TPRLOG_NORMAL, 0, "DevNotifyMASR_JIS :send data");
    memset(&notify1, 0x00, sizeof(notify1));
    memset(&notify2, 0x00, sizeof(notify2));
    ret = masr_date_separate(0, ack2, &notify1, &notify2);
    if((ret == 2) || (ret == 3)){
      DevNotifyMagCard_JIS(&notify2);
      ret = (ret== 3)? 1:0;
    }
    if(ret == 1)
      DevNotifyMagCard_JIS(&notify1);

    return(0);
  }

  static	void RegEnd_AutoStrCls_Judg(void)
  {
    if(AplLib_CMAuto_MsgSend_Chk(0)){
      if(AplLib_AutoGetAutoMode(0) == AUTOMODE_PASSWORD){
        if(Upd_Read_Rest(0) == 0)
  //				AplLib_AmtInfo_Cal(TPRAID_SYST);
          ;
        else{
          auto_strcls_update_chk();
          return;
        }
      }
    }
    auto_strcls_judg( ); /* 次の自動閉店処理へ */
  }
  */

  /// 関数名　　：checkFipMemberBarcode
  ///
  /// 機能概要　：読込んだバーコードがFIP会員バーコードかチェック
  ///
  ///          ：※rcAjs_Emoney_Approval()処理を参考に作成
  ///
  /// パラメータ：barcode_no：CODE128_20桁バーコードデータ
  ///
  /// 戻り値　　：0：FIP会員バーコードではない
  ///
  /// 　　　　　：1：FIP会員バーコード
  ///
  /// 関連tprxソース: rmmain.c  Check_Fip_Member_Barcode()
  static	Future<int>	checkFipMemberBarcode(String barcode_no) async {

    Custreal_ajsJsonFile custreal_ajs = Custreal_ajsJsonFile();
    await custreal_ajs.load();
    int buf = custreal_ajs.normal.client_signature;

    if (await CmCksys.cmDs2GodaiSystem() != 0) {
      if (barcode_no.substring(0, 4) == "0052") {
        return (1);
      } else if (buf > 0) {
        if (barcode_no.substring(0, 7) == buf.toString()) {
          return (1);
        }
      }
      // #if 0
      //     if (await CmCksys().cm_sm13_chuoichiba_system()) {
      //       //中央市場
      //      if (barcode_no.substring(0, 7) == "7130351") {
      //         return(1);
      //       }
      //     }	else if (await CmCksys().cm_sm15_beniya_system()) {
      //       //紅屋商事
      //      if (barcode_no.substring(0, 7) == "7130361") {
      //         return(1);
      //       }
      //     }	else if (await CmCksys().cm_sm32_maruai_system())	{
      //      //マルアイ
      //      if (barcode_no.substring(0, 7) == "7130375") {
      //         return(1);
      //       }
      //     }
      // #endif
    }
    return (0);
  }

  /// 関数名　　：checkFipStandardBarcode
  ///
  /// 機能概要　：読込んだバーコードがFIP電子マネー(標準)バーコードかチェック
  ///
  ///          ：※rcAjs_Emoney_Approval()処理を参考に作成
  ///
  /// パラメータ：barcode_no：CODE128_20桁バーコードデータ
  ///
  /// 戻り値　　：0：FIP電子マネー(標準)バーコードではない
  ///
  /// 　　　　　：1：FIP電子マネー(標準)バーコード
  ///
  /// 関連tprxソース: rmmain.c  Check_Fip_Standard_Barcode()
  static	Future<int>	checkFipStandardBarcode(String barcode_no) async {
    String	comp_cd = "";

    if (await CmCksys.cmFipEmoneyStandardSystem() == 0) {
      // FIP電子マネー(標準)仕様ではない
      return (0);
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "checkFipStandardBarcode:rxMemPtr(RXMEM_COMMON) error\n");
      return (0);
    }
    RxCommonBuf pCom = xRet.object;

    // キーオプション「プリカ宣言」の「加盟社コード」を参照し、読ませたカードと比較
    comp_cd = pCom.dbKfnc[FuncKey.KY_PRECA_IN.index].opt.precaIn.memberCompanyCd.toString();
    if (barcode_no.substring(0, 7) == comp_cd) {
      return (1);
    }
    return(0);
  }

  /// 関数名　　：regScannerInputCashierChk
  ///
  /// 機能概要　：キャッシャー入力の許可／不許可を判定
  ///
  /// 引数:[notify] デバイスからの受け取りデータ
  ///
  /// 戻り値　　：0：キャッシャー入力不許可、：1：キャッシャー入力許可
  ///
  /// 関連tprxソース: rmmain.c  Reg_ScannerInputCashierChk()
  static Future<int> regScannerInputCashierChk(
      TprMsgDevNotify_t notify, RxCommonBuf pCom) async {

    // JC*** は使用しない
    // if (cm_QCashierJC_system())
    // {
    // TprLibLogWrite(0, TPRLOG_ERROR, 0, "regScannerInputCashierChk INPUT CHK QCJC system");
    // return(0);
    // }

    switch(notify.tid) {
      case TprDidDef.TPRDIDSCANNER1:
        if ((await CmCksys.cmChk2PersonSystem() == 2) &&
            (CompileFlag.SIMPLE_2STAFF == true)) {
          if(await CmStf.cmPersonChk() == 2) {
            if (await chkInputToSimpleCashier(notify, pCom) == TRUE) {
              TprLog().logAdd(0, LogLevelDefine.error,
                  "regScannerInputCashierChk INPUT CHK (0) 1");
              return(0);
            } else {
              TprLog().logAdd(0, LogLevelDefine.error,
                  "regScannerInputCashierChk INPUT CHK (1) 2");
              return(1);
            }
          } else {
            TprLog().logAdd(0, LogLevelDefine.error,
                "regScannerInputCashierChk INPUT CHK (0) 3");
            return(0);
          }
        } else {
          if (pCom.dbStaffopen.chkr_status == 1) {
            if (await chkInputToCashier(notify, pCom) == TRUE) {
              TprLog().logAdd(0, LogLevelDefine.error,
                  "regScannerInputCashierChk INPUT CHK (0) 4");
              return (0);
            } else {
              TprLog().logAdd(0, LogLevelDefine.error,
                  "regScannerInputCashierChk INPUT CHK (1) 5");
              return (1);
            }
          } else {
            TprLog().logAdd(0, LogLevelDefine.error,
                "regScannerInputCashierChk INPUT CHK (0) 6");
            return (0);
          }
        }
        break;
      case TprDidDef.TPRDIDSCANNER2:
        if (await CmCksys.cmDesktopCashierSystem() != 0) {
          if (await chkInputToCashier(notify, pCom) == TRUE ) {
            TprLog().logAdd(0, LogLevelDefine.error,
                "regScannerInputCashierChk INPUT CHK (0) 7");
            return(0);
          } else if((await CmCksys.cmChk2PersonSystem() == 2) &&
              (await chkInputToSimpleCashier(notify, pCom) == TRUE) &&
              (CompileFlag.SIMPLE_2STAFF == true)) {
            TprLog().logAdd(0, LogLevelDefine.error,
                "regScannerInputCashierChk INPUT CHK (0) 8");
            return(0);
          } else {
            String erLog = "regScannerInputCashierChk INPUT CHK (?) 9 " +
                "[${pCom.dbStaffopen.chkr_status}][${await CmStf.cmPersonChk()}]\n";
            TprLog().logAdd(0, LogLevelDefine.normal, erLog);
            if((pCom.dbStaffopen.chkr_status == 1) || (await CmStf.cmPersonChk() == 2)) {
              return(1);
            } else {
              return(0);
            }
          }
        } else {
          if((pCom.dbStaffopen.chkr_status  == 1) || (await CmStf.cmPersonChk() == 2)) {
            TprLog().logAdd(0, LogLevelDefine.error,
                "regScannerInputCashierChk INPUT CHK (1) 9");
            return(1);
          } else {
            TprLog().logAdd(0, LogLevelDefine.error,
                "regScannerInputCashierChk INPUT CHK (0) 10");
            return(0);
          }
        }
        break;
      default:
        break;
    }
    TprLog().logAdd(0, LogLevelDefine.error,
        "regScannerInputCashierChk INPUT CHK NG");
    return(0);
  }

  /// 関数名　　：checkPaletteBarcode
  ///
  /// 機能概要　：パレット様の２４桁のバーコードの頭に
  ///
  ///         ：９２が固定になっているかチェック
  ///
  /// パラメータ：barcode_no：CODE128_24桁バーコードデータ
  ///
  /// 戻り値 　：0：パレット様の２４桁のバーコードの頭に９２が固定ではない
  ///
  ///         ：1：パレット様の２４桁のバーコードの頭に９２が固定
  ///
  /// 関連tprxソース: rmmain.c  Check_Palette_Barcode()
  static Future<int> checkPaletteBarcode(String barcode_no) async {
    if (await CmCksys.cmSm52PaletteSystem() != 0)	{  /* 特定SM52仕様の承認キーが有効かチェック */
      if (barcode_no.substring(0, 2) == "92") { /* パレット様の２４桁のバーコードの頭に９２が固定か */
        return(1);
      }
    }
    return(0);
  }
/*
  extern	int	FenceOver_Status_Chk(void)
  {
  #if FB_FENCE_OVER || CASH_RECYCLE
    if((fence_over_event_typ_cash) || (cash_recycle_event_typ_cash))
    {
      return 1;
    }
    if((fence_over_event_typ_chk) || (cash_recycle_event_typ_chk))
    {
      return 1;
    }
  #endif
    return 0;
  }

   */

}
