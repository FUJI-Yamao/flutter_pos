/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/sys/tpr_dlg.dart';
import 'package:flutter_pos/app/regs/checker/rcspvt_trm.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_fcl.dart';
import '../../inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:flutter_pos/app/lib/apllib/file_cpy.dart';
import 'package:flutter_pos/app/lib/apllib/ut_msg_lib.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_multi.dart';
import 'rcfncchk.dart';
import 'rcid_com.dart';
import 'rcky_rfdopr.dart';
import 'rcquicpay_com.dart';

///  関連tprxソース: rcut_com.c
class RcutCom {

  static const int _ok= 0;

/*----------------------------------------------------------------------*
 *                        Program
 *----------------------------------------------------------------------*/

  /// 関連tprxソース: rcut_com.c - rcChk_Ut_Stat
  static int rcChkUtStat(int opeBrand) {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  /// 関連tprxソース: rcut_com.c - rcSet_Ut_SeqNo
  static Future<String> rcSetUtSeqNo() async {
    String buf;
    int printNo;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcSetUtSeqNo() rxMemRead error\n");
      return "";
    }
    RxCommonBuf cBuf = xRet.object;
    // yyyy-mm-ddから月と日付を取得
    String month = cBuf.dbOpenClose.sale_date?.substring(5, 7) ?? "".padLeft(2,"0");
    String day = cBuf.dbOpenClose.sale_date?.substring(8, 10) ?? "".padLeft(2,"0");
    buf = month+day;
    // 0埋め4桁.
    buf = buf.toString().padLeft(4,'0');

    CompetitionIniRet ret = await CompetitionIni.competitionIniGetPrintNo(Tpraid.TPRAID_PRN);
    printNo =  ret.value;
    // 0埋め4桁.
    String printSNo = printNo.toString().padLeft(4,'0');
    buf = '$buf${printSNo}0';

    return buf;
  }

  /// 関連tprxソース: rcut_com.c - rcSet_Ut_ErrCode
  static Future<int> rcSetUtErrCode(int stat, int opeBrand) async {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcSetUtErrCode() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    atSingl.saveAcbTotalPrice = 0;

    int errNo = 0;
    String log = "";
    String seqNo = "";
    switch (tsBuf.multi.errCd) {
      case Fcl.FCL_NORMAL   :
        errNo = _ok;
        break;
      case Fcl.FCL_SENDERR  :
        errNo = DlgConfirmMsgKind.MSG_TELEGRAGHERR.dlgId;
        break;
      case Fcl.FCL_OFFLINE  :
        errNo = DlgConfirmMsgKind.MSG_OFFLINE.dlgId;
        break;
      case Fcl.FCL_TIMEOUT  :
        errNo = DlgConfirmMsgKind.MSG_TIMEOVER.dlgId;
        break;
      case Fcl.FCL_RETRYERR :
        errNo = DlgConfirmMsgKind.MSG_RETRYERR.dlgId;
        break;
      case Fcl.FCL_BUSY     :
        errNo = DlgConfirmMsgKind.MSG_ACTIONERR.dlgId;
        break;
      case Fcl.FCL_SYSERR   :
        errNo = DlgConfirmMsgKind.MSG_SYSERR.dlgId;
        break;
      case Fcl.FCL_CODEERR  :
        errNo = DlgConfirmMsgKind.MSG_RECEIVEER.dlgId;
        break;
      case Fcl.FCL_RESERR   :
      case Fcl.FCL_OCXERR   :
        errNo = UtMsgLib.SetUtResErr(Tpraid.TPRAID_SYST, stat, opeBrand);
        break;
      default           :
        errNo =  DlgConfirmMsgKind.MSG_SYSERR.dlgId;
        break;
    }
    if (errNo != _ok) {
      if (stat == FclProcNo.FCL_T_START.index) {
        log = sprintf("UT[Common] reduce_act -> multi.err_cd [%d]\n", [tsBuf.multi.errCd]);
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, log);

        if ((opeBrand != MultiUseBrand.EDY_OPERATION.index)
            && (opeBrand != MultiUseBrand.NIMOCA_OPERATION.index)) {
          if ((tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_BEFORE.value)
              || (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_TOUCH.value)) {
            switch (tsBuf.multi.errCd) {
              case Fcl.FCL_SYSERR :
              case Fcl.FCL_RESERR :
              case Fcl.FCL_OCXERR :
                log = sprintf("UT[Common] alarm_act3 -> multi.order [%d] , multi.step [%d]\n",
                  [tsBuf.multi.order, tsBuf.multi.step]);
                TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal, log);
                if ((await CmCksys.cmYunaitoHdSystem() == 0)
                    && ((RckyRfdopr.rcRfdOprCheckAllRefundMode())
                        || (RckyRfdopr.rcRfdOprCheckRcptVoidMode()))) {
                  mem.tTtllog.t100001Sts.voidMacNo = 0;
                  mem.tTtllog.t100001Sts.voidReceiptNo = 0;
                  mem.tTtllog.t100001Sts.voidPrintNo = 0;
                  mem.tHeader.void_serial_no = String.fromCharCode(0x00);
                  mem.tHeader.void_sale_date = String.fromCharCode(0x00);
                  mem.tHeader.void_kind = 0;

                }
                if ((tsBuf.multi.flg & 0x20) != 0) {
                  atSingl.utAlermFlg = 1;   /* アラームレシート */
                  await RcSpvtTrn.rcSPVTAlarmTran(0, opeBrand);
                  seqNo = tsBuf.multi.fclData.sndData.printNo.toString().padLeft(9, '0');
                  seqNo += "\n";
                  switch (MultiUseBrand.getDefine(opeBrand)) {
                    case MultiUseBrand.QP_OPERATION :
                      FileCpy.rxUTFileWrite(Tpraid.TPRAID_SYST, seqNo, 0, 0);
                      break;
                    case MultiUseBrand.ID_OPERATION :
                      FileCpy.rxUTFileWrite(Tpraid.TPRAID_SYST, seqNo, 1, 0);
                      break;
                    default           :
                      break;
                  }
                }
                else {
                  RcSpvtTrn.rcSPVTAlarmTran(1, opeBrand);
                }
                break;
              default :
                break;
            }
          }
        }
      }
      else if(stat == FclProcNo.FCL_I_START.index) {
        log = sprintf("UT[Common] stat_check -> multi.err_cd [%d]\n", [tsBuf.multi.errCd]);
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, log);
      }
      else {
        log = sprintf("UT[Common] other_case -> multi.err_cd [%d]\n", [tsBuf.multi.errCd]);
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, log);
      }
    }
    return errNo;
  }

   /// 関連tprxソース: rcut_com.c - rcUT_Alarm_AlarmPrint
  static Future<void> rcUTAlarmAlarmPrint() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    //  アラームレシートは実装対象外
    // 終了処理のみ呼びだす.
    await rcUTAlarmPrintEnd();
  }

  /// 関連tprxソース: rcut_com.c - rcUT_Alarm_Print_End
  static Future<void> rcUTAlarmPrintEnd() async {
    TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal, "rcUTAlarmPrintEnd");

    AtSingl atSingl = SystemFunc.readAtSingl();
    atSingl.spvtData.tranEnd = 0;

    if(await RcFncChk.rcCheckQPMode()){
      await RcQuicPayCom.rcMultiQPEndProc();
    }else if(await RcFncChk.rcCheckiDMode()){
      await RcidCom.rcMultiiDEndProc();
    }

  }

}
