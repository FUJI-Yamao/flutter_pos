/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifprint.dart';
import 'package:flutter_pos/app/regs/checker/rc_lastcomm.dart';
import 'package:flutter_pos/app/regs/checker/rc_reserv.dart';
import 'package:flutter_pos/app/regs/checker/rccatalina.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_cha.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_chg/bcdtol.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

class RcNoChgDsp{
  static late int lEntry;

  /// 関連tprxソース: rcnochgdsp.c - rcChgAmtMakeDsp
  static Future<void> rcChgAmtMakeDsp() async {
    int ldata = 0;
    AcMem cMem = SystemFunc.readAcMem();

  //#if 0
  //   int	sptendNum;
  //
  //   lEntry = cm_bcdtol(CMEM->ent.entry, sizeof(CMEM->ent.entry));
  //
  //    sptendNum = MEM->tTtllog.t100001Sts.sptend_cnt - 1;
  //    if ( sptendNum >= 0 )
  //    {
  //    ldata    = MEM->tTtllog.t100100[sptendNum].sptend_in_amt;
  //    }
  //    else
  //    {
  //    ldata    = rxCalc_Stl_Tax_In_Amt(MEM);
  //#if CATALINA_SYSTEM
  //    if (cm_catalina_system())
  //    ldata -= MEM->tmpbuf.catalina_ttlamt;
  //#endif
  //    if (C_BUF->db_trm.disc_barcode_28d)
  //    {
  //    ldata -= MEM->tmpbuf.beniya_ttlamt;
  //    }
  //    ldata -= MEM->tmpbuf.noteplu_ttlamt;
  //#if RESERV_SYSTEM
  //    if((cm_Reserv_system() || cm_netDoAreserv_system()) && rcreserv_ReceiptCall() ) {
  //    ldata -= rcreserv_ReceiptAdvance();
  //    }
  //#endif
  //    }
  //#else
    rcChgGetSptendData(lEntry, ldata!);
  //#endif
    if((lEntry <= ldata) || (ldata <= 0)){
      if((lEntry == ldata) || (ldata <= 0) || (lEntry == 0)){
        rcChgAmtMakeDspDrwopen();

        // 楽天ポイントのポイント登録通信を実施
        if(RcLastcomm.rcLastCommChkStatus(RX_LASTCOMM_PAYKIND.LCOM_RPOINT)){
          RegsMem().tTtllog.t100001Sts.sptendCnt--;
          RcLastcomm.rcLastCommAfterInquMainProc(RX_LASTCOMM_PAYKIND.LCOM_RPOINT,0);
          return;
        }

        // 置数 + クレジット時の後問合せ
        if(RcLastcomm.rcLastCommChkStatus(RX_LASTCOMM_PAYKIND.LCOM_CRDT)){
          RegsMem().tTtllog.t100001Sts.sptendCnt--;
          RcLastcomm.rcLastCommAfterInquMainProc(RX_LASTCOMM_PAYKIND.LCOM_CRDT,0);
          return;
        }

        // 置数 + プリペイド時の後問合せ
        if(RcLastcomm.rcLastCommChkStatus(RX_LASTCOMM_PAYKIND.LCOM_PRECA)){
          RegsMem().tTtllog.t100001Sts.sptendCnt--;
          RcLastcomm.rcLastCommAfterInquMainProc(RX_LASTCOMM_PAYKIND.LCOM_PRECA,0);
          return;
        }
      }
      if(RcSysChk.rcChkKYCHA(cMem.stat.fncCode)){
        await RckyCha.rcChargeAmount1_1();
      }
      return;
    }

    switch(await RcSysChk.rcKySelf()){
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        rcChgAmtMakeLcd();
        break;
      case RcRegs.KY_SINGLE   :
        AtSingl atSing = SystemFunc.readAtSingl();
        atSing.startDspFlg = 1;
        rcChgAmtMakeLcd();
        break;
    }
  }

  /// 関連tprxソース: rcnochgdsp.c - rcChgAmtMakeDsp_drwopen
  static Future<void> rcChgAmtMakeDspDrwopen() async {
    KopttranBuff koptTran = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();

    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);

    if((!await RcFncChk.rcCheckERefIMode())
        && (!await RcFncChk.rcCheckESVoidIMode())
        && (!await RcFncChk.rcCheckESVoidSMode())
        && (!await RcFncChk.rcCheckERefSMode())){
      if(await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL){
        if((koptTran.acbDrwFlg == 1) || (cMem.acbData.acbDrwFlg == 1)){
          await RcIfPrint.rcDrwopen();
          cMem.stat.clkStatus = (cMem.stat.clkStatus | RcIf.OPEN_DRW);
          // TODO:00012 (rxmem.c - STAT_drw_get)
          // ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= OPEN_DRW;
        }else{
          cMem.stat.clkStatus = (cMem.stat.clkStatus & ~RcIf.OPEN_DRW);
        }
      }else{
        await RcIfPrint.rcDrwopen();
        cMem.stat.clkStatus = (cMem.stat.clkStatus | RcIf.OPEN_DRW);
        // TODO:00012 (rxmem.c - STAT_drw_get)
        // ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= OPEN_DRW;
      }
    }
  }

  /// 引数(lEntry, ldata)に値をセットする
  /// 関連tprxソース: rcnochgdsp.c - rcChgGetSptendData(long *lEntry, long *ldata)
  static Future<void> rcChgGetSptendData(int lEntry, int ldata) async {
    int sptendNum;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem regsMem = RegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcChgGetSptendData() rxMemRead error\n");
      return ;
    }
    RxCommonBuf pCom = xRet.object;
    lEntry = Bcdtol.cmBcdToL(cMem.ent.entry);

    sptendNum = RegsMem().tTtllog.t100001Sts.sptendCnt - 1;
    if(sptendNum >= 0){
      ldata = RegsMem().tTtllog.t100100[sptendNum].sptendInAmt;
    }else{
      ldata = RxLogCalc.rxCalcStlTaxInAmt(regsMem);
    }
  //#if CATALINA_SYSTEM
    if(RcCatalina.cmCatalinaSystem(0)){
      ldata -= regsMem.tmpbuf.catalinaTtlamt!;
    }
  //#endif
    if(pCom.dbTrm.discBarcode28d != 0){
      ldata -= regsMem.tmpbuf.beniyaTtlamt!;
    }
    ldata -= regsMem.tmpbuf.notepluTtlamt!;
  //#if RESERV_SYSTEM
    if(((await CmCksys.cmReservSystem() != 0) || (await CmCksys.cmNetDoAreservSystem() != 0))
        && (RcReserv.rcReservReceiptCall())){
      ldata -= await RcReserv.rcreservReceiptAdvance();
    }
  //#endif
  }

  /// 関連tprxソース: rcnochgdsp.c - rcChgAmtMakeLcd()
  static void rcChgAmtMakeLcd(){
    int calcChgAmt;
    String chgCmt = "";
    String chgAmt = "";
    tprDlgParam_t param;
    CmEditCtrl fCtrl;
    String log = "";
    int bytes;
  }

}