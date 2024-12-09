/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter_pos/app/inc/lib/if_fcl.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/inc/sys/tpr_dlg.dart';
import 'package:flutter_pos/app/regs/checker/rc_multi.dart';
import 'package:flutter_pos/app/regs/checker/rcspvt_trm.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/cnct.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';

///  関連tprxソース: rcfcl_com.c
class RcFclCom {

  ///  関連tprxソース: rcfcl_com.c - rcClr_Fcl_Mem
  static Future<void> rcClrFclMem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcMultiQPReduceAct() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if(await CmCksys.cmFclEdySystem() != 0){
      // TODO:10121 QUICPay、iD 202404実装対象外
    }else{
      if(Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT)  == 4){

      }else{


        if(tsBuf.multi.flg & 0x02 == 0x02){
          tsBuf.multi = RxTaskstatMulti();
          tsBuf.multi.flg |= 0x02;
        }else{
          tsBuf.multi = RxTaskstatMulti();
        }
      }

    }
    tsBuf.multi.flg |= 0x08;
    return;
  }

  ///  関連tprxソース: rcfcl_com.c - rcChk_Fcl_Stat
  static int rcChkFclStat() {
    // TODO:00008 宮家 中身の実装予定　
    return 0;
  }

  ///  関連tprxソース: rcfcl_com.c - rcChk_Fcl_SeqOver
  static int rcChkFclSeqOver() {
    // TODO:00008 宮家 中身の実装予定　
    return 0;
  }

  ///  関連tprxソース: rcfcl_com.c - extern short rcSet_Fcl_ErrCode(short stat, short ope_brand)
  static Future<int> rcSetFclErrCode(int stat, int opeBrand) async {
    int errNo = 0;
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFclErrCode() rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSingl = SystemFunc.readAtSingl();

    atSingl.spvtData.anyCd[0] = 0;
    switch (tsBuf.multi.errCd) {
      case Fcl.FCL_NORMAL:
        errNo = Typ.OK;
        break;
      case Fcl.FCL_SENDERR:
        errNo = DlgConfirmMsgKind.MSG_TELEGRAGHERR.dlgId;
        break;
      case Fcl.FCL_OFFLINE:
        errNo = DlgConfirmMsgKind.MSG_OFFLINE.dlgId;
        break;
      case Fcl.FCL_TIMEOUT:
        errNo = DlgConfirmMsgKind.MSG_TIMEOVER.dlgId;
        break;
      case Fcl.FCL_RETRYERR:
        errNo = DlgConfirmMsgKind.MSG_RETRYERR.dlgId;
        break;
      case Fcl.FCL_BUSY:
        errNo = DlgConfirmMsgKind.MSG_ACTIONERR.dlgId;
        break;
      case Fcl.FCL_SYSERR:
        errNo = DlgConfirmMsgKind.MSG_SYSERR.dlgId;
        break;
      case Fcl.FCL_CODEERR:
        errNo = DlgConfirmMsgKind.MSG_RECEIVEER.dlgId;
        break;
      case Fcl.FCL_RESERR:
        errNo = await rcSetFclResErr(stat, opeBrand);
        break;
      default:
        errNo = DlgConfirmMsgKind.MSG_SYSERR.dlgId;
        break;
    }
    if (errNo != Typ.OK) {
      if (tsBuf.multi.errCd != Fcl.FCL_RESERR) {
        tsBuf.multi.flg |= 0x02;
      }
      if (stat == FclProcNo.FCL_T_START.index) {
        log = sprintf("FCL[Common] reduce_act -> multi.err_cd [%d]\n",[
          tsBuf.multi.errCd]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);

        if (opeBrand != MultiUseBrand.EDY_OPERATION.index) {
          if (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_AFTER.value
              || tsBuf.multi.step == FclStepNo.FCL_STEP_LOG_GET.value) {
            log = sprintf("FCL[Common] alarm_act2 -> multi.order [%d] , multi.step [%d]\n", [
                            tsBuf.multi.order,
                            tsBuf.multi.step]);
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            RcSpvtTrn.rcSPVTAlarmTran(0, opeBrand);
          }
          else if (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_TOUCH) {
            log = sprintf("FCL[Common] alarm_act1 -> multi.order [%d] , multi.step [%d]\n", [
              tsBuf.multi.order,
              tsBuf.multi.step]);
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
            RcSpvtTrn.rcSPVTAlarmTran(FclStep2No.FCL_STEP2_RETOUCH.index, opeBrand);
          }
        }
      }
      else if (stat == FclProcNo.FCL_I_START.index) {
       log = sprintf("FCL[Common] stat_check -> multi.err_cd [%d]\n", [
                      tsBuf.multi.errCd]);
       TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      }
      else {
        log = sprintf("FCL[Common] other_case -> multi.err_cd [%d]\n", [
          tsBuf.multi.errCd]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      }
    }
    return errNo;
  }

  ///  関連tprxソース: rcfcl_com.c - rcSet_Fcl_ResErr
  static Future<int> rcSetFclResErr(int stat, int opeBrand) async {
    int errNo = 0;

    errNo = await rcSetFclCode81();
    if (errNo == Typ.OK) {
      errNo = await rcSetFclStat72();
    }
    if (errNo == Typ.OK) {
      if (stat == FclProcNo.FCL_I_START.index) {
        errNo = DlgConfirmMsgKind.MSG_NOTACTION.dlgId;
      }
      else {
        if (opeBrand == MultiUseBrand.EDY_OPERATION.index) {
          errNo = rcSetFclStatErrEdy();
        }
        else {
          errNo = await rcSetFclStatErr();
        }
      }
    }
    return errNo;
  }

  ///  関連tprxソース: rcfcl_com.c - rcSet_Fcl_Stat72
  static Future<int> rcSetFclStat72() async {
    int errNo = Typ.OK;
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFclStat72() rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    errNo = Typ.OK;
    switch (tsBuf.multi.fclData.stat72) {
      case 90:
        errNo = DlgConfirmMsgKind.MSG_INITIAL.dlgId;
        break;
      case 91:
      case 92:
        errNo = await rcSetFclCode83();
        break;
      case 93:
        errNo = DlgConfirmMsgKind.MSG_TEXT7.dlgId;
        break;
      case 94:
        errNo = DlgConfirmMsgKind.MSG_TEXT8.dlgId;
        break;
      case 99:
        errNo = DlgConfirmMsgKind.MSG_TEXT30.dlgId;
        break;
    }
    if (errNo != Typ.OK) {
      log = sprintf("FCL[Common] res_err -> multi.fcl_data.stat72 [%d]\n",[
        tsBuf.multi.fclData.stat72
      ]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
    }
    return errNo;
  }

  ///  関連tprxソース: rcfcl_com.c - rcSet_Fcl_Code81
  static Future<int> rcSetFclCode81() async {
    int errNo = Typ.OK;
    int code = 0;
    String log = '';
    String buf = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFclCode81() rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSingl = SystemFunc.readAtSingl();

    if (tsBuf.multi.fclData.srvSu == 0) {
      return errNo;
    }

    errNo = DlgConfirmMsgKind.MSG_TEXT30.dlgId;
    for (int i = 0; i < tsBuf.multi.fclData.srvSu; i++) {
      buf = tsBuf.multi.fclData.code81[0].substring(0,6);  /* 故障コード */
      code = int.parse(buf);
      if (code != 0) {
        atSingl.spvtData.anyCd.add(code);
        log = sprintf("FCL[Common] code81_err -> multi.fcl_data.code81 [%ld]\n",[code]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      }
    }

    switch (code) {
      case 2:
        errNo = DlgConfirmMsgKind.MSG_RW_COM_OFFLINE.dlgId;
        break;
      case 10041:
      case 20041:
        errNo = DlgConfirmMsgKind.MSG_TEXT103.dlgId;
        break;
      case 10070:
      case 20023:
      case 20024:
        errNo = DlgConfirmMsgKind.MSG_TEXT104.dlgId;
        break;
      case 10065:
      case 20021:
      case 20022:
        errNo = DlgConfirmMsgKind.MSG_EDY_PEC2_LOGFULL.dlgId;
        break;
      case 10054:
      case 10064:
      case 10067:
        errNo = DlgConfirmMsgKind.MSG_TEXT105.dlgId;
        break;
    }
    return errNo;
  }

  ///  関連tprxソース: rcfcl_com.c - rcSet_Fcl_Code83
  static Future<int> rcSetFclCode83() async {
    int errNo = 0;
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFclCode83() rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSingl = SystemFunc.readAtSingl();

    errNo = DlgConfirmMsgKind.MSG_TEXT14.dlgId;
    atSingl.spvtData.anyCd[0] = tsBuf.multi.fclData.code83;
    log = sprintf("FCL[Common] code83_err -> multi.fcl_data.code83 [%ld]\n", [
                  tsBuf.multi.fclData.code83]);
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
    return errNo;
  }

  ///  関連tprxソース: rcfcl_com.c - rcSet_Fcl_StatErr
  static Future<int> rcSetFclStatErr() async {
    int errNo = Typ.OK;
    int reasonCd = 0;
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFclStatErr() rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSingl = SystemFunc.readAtSingl();

    switch (tsBuf.multi.fclData.stat) {
      case 25:
        errNo = DlgConfirmMsgKind.MSG_TEXT17.dlgId;
        break;
      case 80:
        errNo = DlgConfirmMsgKind.MSG_TEXT16.dlgId;
        break;
      case 90:
        errNo = DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId;
        break;
    }
    if (errNo != Typ.OK) {
      if (tsBuf.multi.fclData.code84[3] == 'E'
          || tsBuf.multi.fclData.code84[3] == 'G') {
        errNo = DlgConfirmMsgKind.MSG_TEXT107.dlgId;
      }
      else {
        reasonCd = int.parse(tsBuf.multi.fclData.code84[0]);
        switch(reasonCd) {
          case 2310200  :
            errNo = DlgConfirmMsgKind.MSG_OTHER_PAY.dlgId;
            break;
          case 2310300  :
          case 2320100  :
          case 2320200  :
          case 2320300  :
          case 2330100  :
            errNo = DlgConfirmMsgKind.MSG_CREDIT_CONFIRM.dlgId;
            break;
          case 35310200 :
          case 35310300 :
            errNo = DlgConfirmMsgKind.MSG_CARDEER.dlgId;
            break;
          case 35320600 :
            errNo = DlgConfirmMsgKind.MSG_GOODTHRUERR.dlgId;
            break;
          case 35320800 :
          case 35321000 :
            errNo = DlgConfirmMsgKind.MSG_NOTUSECARD.dlgId;
            break;
          case 2400900  :
          case 2401000  :
          case 2401100  :
          case 2401200  :
          case 2402000  :
          case 2402100  :
          case 2402300  :
          case 2402900  :
          case 2404400  :
          case 2404600  :
            errNo = DlgConfirmMsgKind.MSG_TEXT106.dlgId;
            break;
        }
      }
      atSingl.spvtData.anyCd[0] = int.parse(tsBuf.multi.fclData.code84[0]);
      log = sprintf("FCL[Common] res_err -> multi.fcl_data.stat [%d], multi.fcl_data.code84 [%.8s]\n", [
        tsBuf.multi.fclData.stat, tsBuf.multi .fclData.code84[0]
      ]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
    }
    else {
      errNo = DlgConfirmMsgKind.MSG_TEXT20.dlgId;
    }
    return errNo;
  }
  ///  関連tprxソース: rcfcl_com.c - rcSet_Fcl_StatErr_Edy
  static int rcSetFclStatErrEdy() {
    int errNo = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetFclStatErrEdy() rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    switch (tsBuf.multi.fclData.stat) {
      case 21:
      case 25:
        errNo = DlgConfirmMsgKind.MSG_CARD_NOTUSE2.dlgId;
        break;
      case 27:
      case 28:
      case 92:
      case 99:
        errNo = DlgConfirmMsgKind.MSG_TEXT17.dlgId;
        break;
      case 80:
        errNo = DlgConfirmMsgKind.MSG_TEXT16.dlgId;
        break;
      case 90:
        errNo = DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId;
        break;
    }
    return errNo;
  }
}
