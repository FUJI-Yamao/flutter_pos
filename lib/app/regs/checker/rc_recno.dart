/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/apllib/apllib_logcmn.dart';
import 'package:flutter_pos/app/regs/checker/rc_key_cash.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/checker/rxregstr.dart';

import '../../common/cls_conf/counterJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../lib/apllib/competition_ini.dart';
import '../inc/rc_mem.dart';

/// 関連tprxソース:rc_recno.c
class RcRecno{
  /// Date setting Reciept & Journal No buffer Set & Increment Program
  /// 関連tprxソース:rc_recno.c - rc_Set_RctJnlNo
  static Future<void> rcSetRctJnlNo() async {
    if (RcSysChk.rcCheckWiz()) {
      return;
    }

    RcSet.rcSetStTFlag(0);
    RcSet.rcSetTimerData();

    if(await RcSysChk.rcQCChkQcashierSystem() || await RcSysChk.rcSGChkSelfGateSystem()){
      RcSet.rcAttendEndDataSet();	// アテンド時間セット
      AcMem cMem = SystemFunc.readAcMem();
      cMem.attendTimeData = AttendTimeData();
      RegsMem().tTtllog.t1000.attendTime = (cMem.attendTimeData.time) * 10; // 1sec->100msec

    }else{
      RegsMem().tTtllog.t1000.attendTime = RegsMem().tTtllog.t1000.scanTime
          + RegsMem().tTtllog.t1000.kyinTime
          + RegsMem().tTtllog.t1000.chkoutTime
          + RegsMem().tTtllog.t1000.chkrScanTime
          + RegsMem().tTtllog.t1000.chkrKyinTime
          + RegsMem().tTtllog.t1000.chkrChkoutTime;
    }

    Rxregstr.rxSetClerkNoName();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    CounterJsonFile counterJson = pCom.iniCounter;

    if(RegsMem().tTtllog.calcData.suspendFlg == 1){
      AplLibLogCmn.aplLibLogCmnHeaderSet(await RcSysChk.getTid(), RegsMem().tHeader.receipt_no);
    }else{
      AplLibLogCmn.aplLibLogCmnHeaderSet(await RcSysChk.getTid(), 0);
    }
  }

  /// 関連tprxソース:rc_recno.c - rc_Inc_RctJnlNo
  static Future<int> rcIncRctJnlNo(bool rctjnl) async {
    bool errChk = false;
    bool errChk2 = false;
    int errNo = 0;
    int errNo2 = 0;
    int	rcptNo = 0;
    int	printNo = 0;

    if(rctjnl) {
      rcptNo = (await CompetitionIni.competitionIniGetRcptNo(await RcSysChk.getTid())).value;
      if (rcptNo >= 9999) {
        rcptNo = 1;
      } else {
        rcptNo++;
      }

      // rcptNoの値をDBにセットする
      errChk = (await CompetitionIni.competitionIniSetRcptNo((await RcSysChk.getTid()),
          rcptNo)).isSuccess;
      if(errChk == false) {
        TprLog().logAdd((await RcSysChk.getTid()), LogLevelDefine.error,
            "rcIncRctJnlNo() rcptNo SetDB error", errId: -1);
        errNo = DlgConfirmMsgKind.MSG_WRITEERR.dlgId;
      }
    }
    else {
      errNo = Typ.NORMAL;
    }

    printNo = (await CompetitionIni.competitionIniGetPrintNo(await RcSysChk.getTid())).value;
    if (printNo >= 9999) {
      printNo = 1;
    } else {
      printNo++;
    }

    // printNoの値をDBにセットする
    errChk2 = (await CompetitionIni.competitionIniSetPrintNo((await RcSysChk.getTid()),
        printNo)).isSuccess;
    if(errChk2 == false) {
      TprLog().logAdd((await RcSysChk.getTid()), LogLevelDefine.error,
          "rcIncRctJnlNo() printNo SetDB error", errId: -1);
      errNo2 = DlgConfirmMsgKind.MSG_WRITEERR.dlgId;
    }

    if((errNo == Typ.NORMAL) && (errNo2 != Typ.NORMAL)) {
      errNo = errNo2;
    }

    return errNo;
  }

}