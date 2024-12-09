/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/apllib/recog.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'competition_ini.dart';

///  関連tprxソース: mentecall.c
class MenteCall{
  static const SQLSTRCLS = "SQLSTRCLS=";

  /*----------------------------------------------------------------------*
 * Definition datas
 *----------------------------------------------------------------------*/
  static const MEMWRITE_RETRY_CNT	= 25;
  static const MEMWRITE_RETRY_WAIT = 200000;

  ///  関連tprxソース: mentecall.c - mentecall_strcls_res_send
  static Future<int> mentecallStrclsResSend(
      TprMID tid, int resNo, String sql) async {
    RxMntclt inpBuf = RxMntclt();
    int i = 0;
    int result = 0;
    String saleDate = '';
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    String log = '';
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetS.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRetC.object;
    RecogValue ret = (await Recog().recogGet(
        tid, RecogLists.RECOG_ASSIST_MONITOR, RecogTypes.RECOG_GETSYS))
        .result;

    if (ret == RecogValue.RECOG_NO) {
      return 0;
    }

    if (sql == AplLib.AUTO_MSG_ERRCLR) {
      if (pCom.auto_errstat == 0) {
        return 0;
      }
      pCom.auto_errstat = 0;
    } else if (sql == AplLib.AUTO_MSG_COMP) {
      pCom.auto_errstat = 1;
    } else {
      pCom.auto_errstat = 0;
    }

    String callFunc = 'mentecallStrclsResSend';
    log = sprintf("%s() start[%i][%s]", [callFunc, resNo, sql]);
    TprLog().logAdd(tid, LogLevelDefine.normal, log);
    result = -1;

    inpBuf.err_no = 7;
    CompetitionIniRet iniRet = await CompetitionIni.competitionIniGet(
        tid,
        CompetitionIniLists.COMPETITION_INI_SALE_DATE,
        CompetitionIniType.COMPETITION_INI_GETSYS);
    saleDate = iniRet.value;
    if (resNo != AutoStep.AUTOSTEP_STRCLS_START.val) {
      if (saleDate == "0000-00-00") {
        CompetitionIniRet iniRet2 = await CompetitionIni.competitionIniGet(
            tid,
            CompetitionIniLists.COMPETITION_INI_LAST_SALE_DATE,
            CompetitionIniType.COMPETITION_INI_GETSYS);
        saleDate = iniRet2.value;
      }
    }
    if (saleDate.isEmpty) {
      TprLog().logAdd(tid, LogLevelDefine.error, "sale_date get error\n");
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }

    inpBuf.sql = sprintf("%sRES%02i:%s,%06i,%s", [
      SQLSTRCLS,
      resNo,
      saleDate,
      await CompetitionIni.competitionIniGetRcptNo(tid),
      sql
    ]);
    tsBuf.mente.err_no = -1;
    for (i = 0; i < MEMWRITE_RETRY_CNT; i++) {
      RxMemRet xRetM = SystemFunc.rxMemRead(RxMemIndex.RXMEM_MNTCLT);
      if (xRetM.isInvalid()) {
        return 0;
      }
      //if (rxMemDataChk(RXMEM_MNTCLT) == RXMEM_DATA_OFF) {
      if (xRetM.result == RxMem.RXMEM_OK) {
        //if (rxQueueWrite(RXQUEUE_MNTCLT) == RXQUEUE_OK) {
        result = 0;
        break;
        //}
      }
      //}
      //usleep(MEMWRITE_RETRY_WAIT);
    }
    if (result == -1) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, "mentecall_strcls_res_send() error!!");
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    } else {
      for (i = 0; i < 30; i++) {
        if (tsBuf.mente.err_no != -1) {
          result = tsBuf.mente.err_no;
          break;
        }
        //sleep(1);
      }
      if (i == 30) {
        TprLog().logAdd(tid, LogLevelDefine.normal,
            "mentecall_strcls_res_send() send timeout error!!");
        return DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId;
      }
    }
    TprLog()
        .logAdd(tid, LogLevelDefine.normal, "mentecall_strcls_res_send() end");
    return result;
  }
}
