/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/inc/rc_mem.dart';

import 'package:sprintf/sprintf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_regs.dart';
import 'rc_ext.dart';
import 'rcstllcd.dart';
import 'rc_qrinf.dart';
import 'rcky_clr.dart';

// TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
///  関連tprxソース: rc_ifevent.c
class RcIfEvent {
  static int rctNearendStatus = 0;

  /* 強制閉設関連 */
  static int forceClsDlgFlg = 0;

  ///  関連tprxソース: rc_ifevent.c - rx_ifsave
  static Future<void> rxIfSave(RxInputBuf buf, int flag) async {
    String log = "";
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();

    if (RcMem.IFWAIT_MAX > ifSave.count) {
      log =
          "rx_ifsave start [${ifSave.count}] : dev[${buf.devInf.devId}], fnc_code[${buf.funcCode}] flag[$flag]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      ifSave.buf[ifSave.count] = buf;
      ifSave.intFlag[ifSave.count] = flag;
      ifSave.count++;
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.normal, "rx_ifsave end\n");
    } else {
      log =
          "rx_ifsave Overflow [${ifSave.count}] : dev[${buf.devInf.devId}], fnc_code[${buf.funcCode}] flag[$flag]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
    }

    /* 呼び戻し中は入力情報が変なタイミングでloadされないよう削除 */
    if ((await RcSysChk.rcQRChkPrintSystem()) &&
        ((RckyClr.qrTxtStatus == QrTxtStatus.QR_TXT_STATUS_READ) ||
            (RckyClr.qrTxtStatus == QrTxtStatus.QR_TXT_STATUS_CHK))) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rx_ifsave Now Read Reset\n");
      ifSave = IfWaitSave();
    }
    return;
  }

  ///  関連tprxソース: rc_ifevent.c - rxChkTimerRemove
  static int rxChkTimerRemove() {
    return 0;
  }

  ///  関連tprxソース: rc_ifevent.c - rxChkTimerAdd
  static Future<int> rxChkTimerAdd() async {
    await RcExt.rxChkModeReset("rxChkTimerAdd");

    return 0;
  }

  ///  関連tprxソース: rc_ifevent.c - rxTimerAdd
  static void rxTimerAdd() {
    // if (rc_TimerList_Run(RC_EVENT_LOOP_TIMER) == 1 ) {
    //   return;
    // }
    //
    // if (rcCheck_Stl_Mode()) {
    //   rc_TimerList_Add(RC_TIMER_LISTS.RC_EVENT_LOOP_TIMER, EVENT_TIMER, (GtkFunction)eventChkStl, 0 );
    // } else {
    //   rc_TimerList_Add(RC_TIMER_LISTS.RC_EVENT_LOOP_TIMER, EVENT_TIMER, (GtkFunction)eventChk, 0 );
    // }
    return;
  }

  ///  関連tprxソース: rc_ifevent.c - rxChkModeSet2
  static Future<void> rxChkModeSet2(String callFunc) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rxChkModeSet2( call_func : $callFunc )");
    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.dspEventMode = 100;
  }

  ///  関連tprxソース: rc_ifevent.c - rxChkModeReset2
  static Future<void> rxChkModeReset2(String callFunc) async {
    DateTime dt = DateTime.now();
    String log = "";  // [256];

    AcMem cMem = SystemFunc.readAcMem();

    if(cMem.stat.dspEventMode != 0) {
      log = "rxChkModeReset2( call_func : ${callFunc} )  ${dt.hour}:${dt.minute}:${dt.second}.${dt.millisecond}";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      cMem.stat.dspEventMode = 0;
    }
  }

  ///  **********************************************************************
  ///      関数：rc_ifevent_rxTimer_ReAdd(void)
  ///      機能：対面セルフ仕様で、イベントタイマーを再起動させる
  ///      （登録操作中、ごく稀にイベントタイマーの動作が止まる現象があり、SWでの再起動が必要だった為、この処理でSWを回避させる）
  ///      引数：なし
  ///      戻値：なし
  ///   ***********************************************************************/
  ///  関連tprxソース: rc_ifevent.c - rc_ifevent_rxTimer_ReAdd
  static void rcIfeventRxTimerReAdd(){
    // char   log[128];
    //
    // if (rcChk_fself_Main())
    // {
    //   if (IF_SAVE->count > 0)
    //   {
    //     if (CMEM->stat.DspEventMode == 0)
    //     {
    //       snprintf(log, sizeof(log), "%s : IF_SAVE count = [%d] timer = [%d]\n", __FUNCTION__, IF_SAVE->count, rc_TimerList_Val(RC_EVENT_LOOP_TIMER));
    //       TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    //
    //       if ((rcCheck_Itm_Mode()) || (rcCheck_Stl_Mode()))
    //       {
    //         if ( rc_TimerList_Run(RC_EVENT_LOOP_TIMER) == 1 )
    //         {
    //           memset((char *)IF_SAVE, 0, sizeof(IF_SAVE));
    //           rxTimerRemove();
    //           rxTimerAdd();
    //
    //           snprintf(log, sizeof(log), "%s : exec !!\n", __FUNCTION__);
    //           TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    //         }
    //       }
    //     }
    //   }
    // }
  }

  ///  関連tprxソース: rc_ifevent.c - rc_Send_Int
  static int rcSendInt(RxInputBuf buf){
    return 0;
  }

  ///  関連tprxソース: rc_ifevent.c - rc_Send_Update
  static int rcSendUpdate() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_ifevent.c - rxTimerRemove()
  static void rxTimerRemove(){
    return;
  }
  /// 関連tprxソース: rc_ifevent.c - rcChk_Set_Date()
  static Future<void> rcChkSetDate() async {
    String log = "";
    AcMem cMem = SystemFunc.readAcMem();
    if (RegsMem().tHeader.endtime == cMem.bkupNowSaleDatetime) {
      log = "rcChk_Set_Date compare error now_sale_datetime[${RegsMem().tHeader.endtime}]"
            "bkup_now_sale_datetime[${cMem.bkupSaleDate}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      if (cMem.bkupNowSaleDatetime == String.fromCharCode(0x00)) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChk_Set_Date bkup_now_sale_datetime = NULL. Not load!!");
      }
      else {
        RegsMem().tHeader.endtime = cMem.bkupNowSaleDatetime;
      }
    }
    if (RegsMem().tHeader.sale_date == cMem.bkupSaleDate) {
      log = "rcChk_Set_Date compare error now_sale_datetime[${RegsMem().tHeader.sale_date}]"
            "bkup_now_sale_datetime[${cMem.bkupSaleDate}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      if (cMem.bkupSaleDate == String.fromCharCode(0x00)) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcChk_Set_Date bkup_sale_date = NULL. Not load!!");
      }
      else {
        RegsMem().tHeader.sale_date = cMem.bkupSaleDate;
      }
    }
    await RcSetDate.rcSetDateBkupClr();
    return;
  }

  // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  /// 関連tprxソース: rc_ifevent.c - rc_Send_MP1Print()
  static int rcSendMP1Print(){
    return 0;
  }

  // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  /// 関連tprxソース: rc_ifevent.c - rc_Send_Print()
  static int rcSendPrint() {
    return 0;
  }

  // イベント情報を削除してリセット
  /// 関連tprxソース: rc_ifevent.c - rxChkModeSaveReset()
  static Future<void> rxChkModeSaveReset() async {
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();
    if (ifSave.count > 0) {
      ifSave = IfWaitSave();
    }
    await rxChkModeReset2("rxChkModeSaveReset");
  }

  /// 関連tprxソース: rc_ifevent.c - rc_WaitSave()
  static Future<void> rcWaitSave() async {
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    RxMemRet ret;
    int flag = 0;

    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      // キューの読み込みが可能か判断していただけのため、
      // キュー廃止に伴いコメントアウト
      // if (rxQueueRead(RXQUEUE_CASH, RXQUEUE_NOWAIT) ==
      //     RXQUEUE_OK) {
      ret = SystemFunc.rxMemRead(RxMemIndex.RXMEM_CASH_INP);
      if (ret.result == RxMem.RXMEM_NG) {
        ret = SystemFunc.rxMemRead(RxMemIndex.RXMEM_CHK_CASH);
        if (ret.result == RxMem.RXMEM_OK) {
          flag = 1;
        } else {
          TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.error,
              "WaitSave:Abnormaly rxMemRead !!!!!\n");
          return;
        }
      }
      iBuf = ret.object;
      TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.normal,
          "WaitSave : rx_ifsave start");
      await rxIfSave(iBuf, flag);
    } else {
      // キューの読み込みが可能か判断していただけのため、
      // キュー廃止に伴いコメントアウト
      // if (rxQueueRead(RXQUEUE_CASH, RXQUEUE_NOWAIT) ==
      //     RXQUEUE_OK) {
      ret = SystemFunc.rxMemRead(RxMemIndex.RXMEM_CHK_INP);
      iBuf = ret.object;
      TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.normal,
          "WaitSave : rx_ifsave start");
      await rxIfSave(iBuf, 0);
    }
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_ifevent.c - rcRct_NearEnd_Proc()
  static Future<void> rcRctNearEndProc() async {
    /*
    char  *get_msg;
    int   nearend_status_chk = 0;

    if (await RcSysChk.RcSysChk.rcChkReciptNearEnd() != 0) {
      TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcRct_NearEnd_Proc cnt = 200!\n");
      if ( rcCheck_QCJC_Checker() ) {
        nearend_status_chk = C_BUF->printer_near_end_JC_C;
      } else if( rcKy_Self() != KY_CHECKER ) {
        nearend_status_chk = C_BUF->printer_near_end;
      }
      if (rct_nearend_status != nearend_status_chk) {
        rct_nearend_status = nearend_status_chk;
        if (rcQC_Chk_Qcashier_System()) {
          rcQC_DateTime_Change(0);
          rcQC_SignP_Ctrl_Proc();
        } else if( rcSG_Chk_SelfGate_System() ) {
          if (ItmDsp.window == NULL) {
            rcSPJ_DateTime_Disp(0);
          } else {
            rcSPJ_DateTime_Disp(1);
          }
          if (rcSG_Check_End_Mode()) {
            rcSG_SignP_SignBlink(GREEN_COLOR);
          } else {
            rcSG_SignP_SignOn(GREEN_COLOR);
          }
          if (rcChk_Recipt_NearEnd()) {
            if ((get_msg = TprLibMsgGet(MSG_PAPER_NEAREND)) != NULL) {
              strcat( asst_pc_log, get_msg );
            }
            rc_Assist_Send(MSG_PAPER_NEAREND);
          } else {
            rc_Assist_Send(24048);
          }
        }
      }
    }
     */
  }

  /// 関連tprxソース: rc_ifevent.c - ForceStrCls_Dlg_Show()
  static int forceStrClsDlgShow() {
    return forceClsDlgFlg;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_ifevent.c - chk_display_time_offline
  static void chkDisplayTimeOffline() {
  }

  // TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rc_ifevent.c - stl_display_time_offline
  static void stlDisplayTimeOffline(SubttlInfo pSubttl){
    return;
  }
}