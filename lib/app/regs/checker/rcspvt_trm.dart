/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_fcl.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_multi.dart';
import 'package:flutter_pos/app/regs/checker/rc_recno.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/sys/tpr_log.dart';

///  関連tprxソース: rcspvt_trn.c
class RcSpvtTrn {

  /// 関連tprxソース: rcspvt_trn.c - rcSPVT_AlarmTran()
  static Future<void> rcSPVTAlarmTran(int type, int opeBrand) async {

    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSPVTAlarmTran() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    int err_no;

    if (opeBrand == MultiUseBrand.SUICA_ALMOPERATION.index) {
      mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_ICNML.index;
    }
    else if(opeBrand == MultiUseBrand.SUICA_OBSOPERATION.index) {
      mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_ICABNML.index;
    }
    else {
      mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_SPVT_ALARM.index;
      mem.prnrBuf.spvtAlm = SpvtAlm();
    }

    if ((await CmCksys.cmUt1QUICPaySystem() != 0) || (await CmCksys.cmUt1IDSystem() != 0)
        || (RcSysChk.rcChkMultiVegaSystem() != 0)) {
      if(type == 1) {
        mem.prnrBuf.spvtAlm.almType = 20;
      }
      else {
        mem.prnrBuf.spvtAlm.almType = 10;
      }

      switch (MultiUseBrand.getDefine(opeBrand))
      {
        case MultiUseBrand.SPVT_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 1;
          break;
        case MultiUseBrand.QP_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 2;
          break;
        case MultiUseBrand.ID_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 3;
          break;
        case MultiUseBrand.SUICA_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 6;
          break;
        case MultiUseBrand.SUICA_REFOPERATION :
          mem.prnrBuf.spvtAlm.almType += 7;
          break;
        case MultiUseBrand.SUICA_LACKOPERATION :
          mem.prnrBuf.spvtAlm.almType += 8;
          break;
        case MultiUseBrand.SUICA_ALMOPERATION :
          mem.prnrBuf.spvtAlm.almType += 9;
          break;
        default :
          break;
      }

      if ((await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC))
          && ((opeBrand == MultiUseBrand.SUICA_OPERATION.index) || (opeBrand == MultiUseBrand.SUICA_REFOPERATION.index)
          || (opeBrand == MultiUseBrand.SUICA_LACKOPERATION.index) || (opeBrand == MultiUseBrand.SUICA_ALMOPERATION.index))) {
        if (RcSysChk.rcVDOpeModeChk()) {
          mem.prnrBuf.spvtAlm.pfmOpeMode = 1;
          if (opeBrand == MultiUseBrand.SUICA_OPERATION.index) {
            tsBuf.multi.fclData.sndData.ttlAmt = - tsBuf.multi.fclData.sndData.ttlAmt;
          }
        }
        else {
          mem.prnrBuf.spvtAlm.pfmOpeMode = 0;
        }
      }

      mem.prnrBuf.spvtAlm.tranAmt = tsBuf.multi.fclData.sndData.ttlAmt;
      mem.prnrBuf.spvtAlm.cdNo = ''.padLeft(16,'0');
      mem.prnrBuf.spvtAlm.rcptNo1 = tsBuf.multi.fclData.sndData.printNo.toString().padLeft(9,"0");
      mem.prnrBuf.spvtAlm.rcptNo2 = ''.padLeft(11,'0');
      mem.prnrBuf.spvtAlm.resultCode = tsBuf.multi.fclData.resultCode;
      mem.prnrBuf.spvtAlm.rExtended = tsBuf.multi.fclData.resultCodeExtended;
      mem.prnrBuf.spvtAlm.centerCode = tsBuf.multi.fclData.centerResultCode;
    }
    else if(await CmCksys.cmPFMPiTaPaSystem() != 0 || await CmCksys.cmPFMJRICSystem() != 0) {
      if (type == 1) {
        mem.prnrBuf.spvtAlm.almType = 20;
      }
      else {
        mem.prnrBuf.spvtAlm.almType = 10;
      }

      switch (MultiUseBrand.getDefine(opeBrand))
      {
        case MultiUseBrand.PITAPA_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 4;
          break;
        case MultiUseBrand.PITAPA_REFOPERATION :
          mem.prnrBuf.spvtAlm.almType += 5;
          break;
        case MultiUseBrand.SUICA_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 6;
          break;
        case MultiUseBrand.SUICA_REFOPERATION :
          mem.prnrBuf.spvtAlm.almType += 7;
          break;
        case MultiUseBrand.SUICA_LACKOPERATION :
          mem.prnrBuf.spvtAlm.almType += 8;
          break;
        case MultiUseBrand.SUICA_ALMOPERATION :
          mem.prnrBuf.spvtAlm.almType += 9;
          break;
        case MultiUseBrand.SUICA_OBSOPERATION :
          mem.prnrBuf.spvtAlm.almType += 10;
          break;
        default :
          break;
      }

      if (RcSysChk.rcVDOpeModeChk()) {
        mem.prnrBuf.spvtAlm.pfmOpeMode = 1;
        if (tsBuf.multi.fclData.sndData.payMethod == 50) {
          mem.prnrBuf.spvtAlm.pfmOpeMode = 3;
        }
        if (opeBrand == MultiUseBrand.SUICA_OPERATION.index) {
          tsBuf.multi.fclData.sndData.ttlAmt = - tsBuf.multi.fclData.sndData.ttlAmt;
        }
      }
      else {
        mem.prnrBuf.spvtAlm.pfmOpeMode = 0;
        if (tsBuf.multi.fclData.sndData.payMethod == 50) {
          mem.prnrBuf.spvtAlm.pfmOpeMode = 2;
        }
      }

      if (opeBrand == MultiUseBrand.SUICA_OBSOPERATION.index) {
        if (tsBuf.multi.fclData.sndData.payMethod == 10) {
          mem.prnrBuf.spvtAlm.pfmOpeMode = 0;
        }
        else if (tsBuf.multi.fclData.sndData.payMethod == 20) {
          mem.prnrBuf.spvtAlm.pfmOpeMode = 1;
          mem.prnrBuf.suicaNgAmt = -tsBuf.multi.fclData.sndData.ttlAmt;
        }
        else if (tsBuf.multi.fclData.sndData.payMethod == 50) {
          mem.prnrBuf.spvtAlm.pfmOpeMode = 2;
          if (RcSysChk.rcVDOpeModeChk()) {
            mem.prnrBuf.spvtAlm.pfmOpeMode = 3;
            mem.prnrBuf.suicaNgAmt = -tsBuf.multi.fclData.sndData.ttlAmt;
          }
        }
      }

      mem.prnrBuf.spvtAlm.tranAmt = tsBuf.multi.fclData.sndData.ttlAmt;
      mem.prnrBuf.spvtAlm.cdNo = ''.padLeft(16,'0');
      mem.prnrBuf.spvtAlm.rcptNo1 = tsBuf.multi.fclData.sndData.printNo.toString().padLeft(8,'0');
      mem.prnrBuf.spvtAlm.rcptNo2 = ''.padLeft(11,'0');
      mem.prnrBuf.spvtAlm.resultCode = tsBuf.multi.fclData.resultCode;
      mem.prnrBuf.spvtAlm.rExtended = tsBuf.multi.fclData.resultCodeExtended;
      mem.prnrBuf.spvtAlm.centerCodePfm = tsBuf.multi.fclData.centerResultCodePfm;
    }
    else {
      if (type != FclStep2No.FCL_STEP2_RETOUCH.index) {
        mem.prnrBuf.spvtAlm.almType = 20;
      }
      else {
        mem.prnrBuf.spvtAlm.almType = 10;
      }
      switch (MultiUseBrand.getDefine(opeBrand)) {
        case MultiUseBrand.SPVT_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 1;
          break;
        case MultiUseBrand.QP_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 2;
          break;
        case MultiUseBrand.ID_OPERATION :
          mem.prnrBuf.spvtAlm.almType += 3;
          break;
        default :
          break;
      }
      mem.prnrBuf.spvtAlm.tranAmt = tsBuf.multi.fclData.sndData.ttlAmt;
      mem.prnrBuf.spvtAlm.cdNo = tsBuf.multi.fclData.rcvData.cardId;
      mem.prnrBuf.spvtAlm.rcptNo1 = tsBuf.multi.fclData.sndData.printNo.toString();
      if (tsBuf.multi.fclData.rcvData.slipNo != 0) {
        mem.prnrBuf.spvtAlm.rcptNo2 = tsBuf.multi.fclData.rcvData.slipNo.toString();
      }
    }

    if(mem.tTtllog.calcData.suspendFlg == 0) {
      mem.tHeader.receipt_no = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
    }
    mem.tHeader.print_no = await Counter.competitionGetPrintNo(await RcSysChk.getTid());
    RcSetDate.rcSetDate();
    err_no = RcIfEvent.rcSendUpdate();
    await RcRecno.rcIncRctJnlNo(true);
  }

}
