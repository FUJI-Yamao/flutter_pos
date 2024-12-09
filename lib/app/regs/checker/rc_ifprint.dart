/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/apllib/qr2txt.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_th/if_drw_copen.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

class RcIfPrint{
  static bool DRWER_OPEN = true;
  static bool DRWER_CLOSE = false;
  static int getMode = 0;

  /// 関連tprxソース:C:rc_ifprint.c - rc_drwopen
  static Future<void> rcDrwopen() async {
    if(await RcSysChk.rcCheckQCJCCashier()){
      return;
    }
    if(rcCheckDrwopen() == DRWER_OPEN){
      IfDrwCOpen.ifDrwCOpen(Tpraid.TPRAID_NONE, 0);
    }
  }

  /// 関連tprxソース:C:rc_ifprint.c - rcCheck_drwopen
  static bool rcCheckDrwopen(){
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcCheckDrwopen() rxMemRead error\n");
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if(RcSysChk.rcTROpeModeChk()){
      /* 訓練モード */
      if(pCom.dbTrm.traningDrawAcxFlg == 0){
        /* ドロア開けない */
        return DRWER_CLOSE;
      }else{
        /* ドロア開ける */
        return DRWER_OPEN;
      }
    }else{
      /* ドロア開ける */
      return DRWER_OPEN;
    }
  }

  /// 関連tprxソース:rc_ifprint.c - rc_port_get
  static Future<int> rcPortGet() async {
    RxMemRet xRetCmn = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetCmn.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRetCmn.object;

    int result = 0;
    int result1 = 0;
    int result2 = 0;
    if (await CmCksys.cmCheckAfterWeb2300() == 1) {
      RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRetStat.isInvalid()) {
        return 0;
      }
      RxTaskStatBuf tsBuf = xRetStat.object;
      result = (await SystemFunc.statDrwGet(tsBuf)).drwStat;
      if ((RcRegs.rcInfoMem.rcRecog.recogKitchenPrint != RecogValue.RECOG_NO)
          || (RcRegs.rcInfoMem.rcRecog.recogKitchenPrintRecipt != RecogValue.RECOG_NO)) {
        if (pCom.kitchen_prn1_run != 0) {
          result1 = tsBuf.kitchen1Drw.drwStat;
        }
        if (pCom.kitchen_prn2_run != 0) {
          result2 = tsBuf.kitchen2Drw.drwStat;
        }
        return (result | result1 | result2);
      } else {
        return result;
      }
    }

    // TODO:10129 - Linux デバイスドライバ（inb, ioperm）
    /*
    if (ioperm(RcIf.BASEPORT, 2, 1)) {
      return RcIf.XPRN_ERR;
    }
    result = inb(RcIf.BASEPORT+1);
    if (ioperm(RcIf.BASEPORT, 2, 0)) {
      return RcIf.XPRN_ERR;
    }
     */

    return result;
  }

  /// 関連tprxソース:rc_ifprint.c - rc_status_read
  static Future<int> rcStatusRead() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    int webType = await CmCksys.cmWebType();
    AcMem cMem = SystemFunc.readAcMem();

    if ((cMem.stat.fncCode != FuncKey.KY_RPR.keyId)
        && (cMem.stat.fncCode != FuncKey.KY_RCT.keyId)
        && (cMem.stat.fncCode != FuncKey.KY_WRTY.keyId)
        && (cMem.stat.fncCode != FuncKey.KY_DETAIL.keyId)
        && (cMem.stat.fncCode != FuncKey.KY_RCTFM.keyId)) {
      if ((cMem.stat.fncCode == FuncKey.KY_DRW.keyId)
          && ((webType == CmSys.WEBTYPE_WEB2300)
              || (webType == CmSys.WEBTYPE_WEB2350)
              || (webType == CmSys.WEBTYPE_WEB2500)) ) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rc_status_read Web2300 only check KY_DRW");
      } else {
        if ((pCom.dbTrm.selectPrinterFlg == 2)
            || (cMem.stat.rjpMode == 1)){
          getMode = 0;
          return OK;
        }
      }
    }

    if ((await rcPortGet() & RcIf.XPRN_ERR) != 0) {
      getMode = 1;
    } else {
      getMode = 0;
      return OK;
    }
    int iAnswer = 0;
    // TODO:10019 パイプ通信
    /*
    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      iAnswer = if_th_cReadStatus(Tpraid.TPRAID_CASH);
    } else {
      iAnswer = if_th_cReadStatus(Tpraid.TPRAID_CHK);
    }
     */

    return iAnswer;
  }

  /// 関連tprxソース:rc_ifprint.c - rc_status_get
  static int rcStatusGet() {
    // TODO:10019 パイプ通信
    return 0;
  }
}