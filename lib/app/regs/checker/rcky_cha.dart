/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_pos/app/regs/checker/rcky_clr.dart';
import 'package:sprintf/sprintf.dart';

import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/cm_chg/bcdtol.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../regs/inc/rc_mem.dart';
import '../../regs/inc/rc_regs.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../ui/page/subtotal/controller/c_coupons_controller.dart';
import '../../ui/page/subtotal/controller/c_subtotal_controller.dart';
import '../../ui/page/ticket_payment/p_ticketpayment_page.dart';
import '../common/rx_log_calc.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mbr.dart';
import 'liblary.dart';
import 'rc_acracb.dart';
import 'rc_assist_mnt.dart';
import 'rc_atct.dart';
import 'rc_atctd.dart';
import 'rc_clscom.dart';
import 'rc_clxos_payment.dart';
import 'rc_crdt_fnc.dart';
import 'rc_ewdsp.dart';
import 'rc_ext.dart';
import 'rc_flrda.dart';
import 'rc_gcat.dart';
import 'rc_gtktimer.dart';
import 'rc_ifevent.dart';
import 'rc_lastcomm.dart';
import 'rc_mbr_com.dart';
import 'rc_qc_dsp.dart';
import 'rc_qrinf.dart';
import 'rc_repica.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rc_smartplus.dart';
import 'rc_taxfree_svr.dart';
import 'rccrdtdsp.dart';
import 'rcfncchk.dart';
import 'rcid_com.dart';
import 'rcky_cpnprn.dart';
import 'rcky_regassist.dart';
import 'rcky_rfdopr.dart';
import 'rcky_stl.dart';
import 'rckyccin.dart';
import 'rckyccin_acb.dart';
import 'rcnewsg_fnc.dart';
import 'rcqr_com.dart';
import 'rcquicpay_com.dart';
import 'rcspj_dsp.dart';
import 'rcsyschk.dart';

class RckyCha {
  /*----------------------------------------------------------------------*
 * Static memories
 *----------------------------------------------------------------------*/
  static int chageslipchkFncCd = 0;
  static int nochgConfFlg = 0; // つり銭支払が確認表示のとき、表示したか（0:していない 1:した 2:特殊乗算で乗算後）
  static int CustreadExecFlg = 0;
  static int frestaFncType = 0; // フレスタ様 金種商品が手入力かスキャンか
  static int frestaSprtChk = 0; // フレスタ様 スプリットカウントが増えたか
  static int frestaConfDspTyp = 0; // フレスタ様 会計確認画面種類
  static int spjPaydspFlg = 0;
  static int autorprCnt = 0;

  ///  関連tprxソース: rcky_cha.c - rcKyCharge
  static Future<void> rcKyCharge() async {
    // 行番号:1250-1278

    int errNo;
    // TODO:00012 平野 グローバル変数どうしよう?
    int fnal_count = 0; //extern short fnal_count;

    int lEntry; /* entry data */
    int digit;
    String log = "";

    int actChk;
    String tmp = "";
    String section = "";
    String fileName = "";
    String tmpBuf = "";
    int errCd = 0;
    int ctrlFlg = 0;

    RxMemRet xRet1 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    RxMemRet xRet2 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet1.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "rcKyCharge() rxMemRead error\n");
      return;
    }
    if (xRet2.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "rcKyCharge() rxMemRead error\n");
      return;
    }
    RxTaskStatBuf tsBuf = xRet1.object;
    RxCommonBuf pCom = xRet2.object;

    AcMem cMem = SystemFunc.readAcMem();

    // 支払い可能かを事前チェック.
    bool isSuccess = await paymentCheck();
    if(!isSuccess){
      return;
    }


    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
    //   if (tsBuf.cash.int_stat == 1) {
    //     tsBuf.cash.int_stat = 2;
    //   }
    // }

    // TODO:10114 コンパイルスイッチ(RM3800_DSP)
    // RM3800_DSPが0で定義されていたので、この部分はコメントアウトしておく。
    // #if RM3800_DSP
    // // RM-5900仕様で画面モードが小計画面以外の場合、先に小計キーを動作させる。
    // if ( ( rcCheck_Itm_Mode ( ) )
    // && ( C_BUF->vtcl_rm5900_regs_on_flg ) )
    // {
    // rcRead_kopttran( CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN) );
    // if (KOPTTRAN.frc_stlky_flg == 0)    // 小計キーの使用を強制：しない
    //     {
    // rc59_Ky_Change ( );
    // rxChkTimerAdd ( );
    // return;
    // }
    // }
    // #endif

    //行番号：1295-1314
    // RM-5900の場合は、計量エリアをクリアする

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (pCom.vtclRm5900RegsOnFlg == true) {
    //   await Rc59dsp.rc59ScaleRmScaleAreaClear();
    // }
    //
    // // RM-3800 一部支払いの場合、テンキー画面を表示
    // if (pCom.vtclRm5900RegsOnFlg == true) {
    //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //   if ((koptTran.frcEntryFlg == 1)                   // 預り金額の置数強制：する
    //       && (koptTran.crdtEnbleFlg == 1)               // 掛売登録：あり
    //       && (RxLogCalc.rxCalcStlTaxAmt(regsMem) >= 0)  // 残金あり
    //       && (cMem.ent.tencnt == 0)) {                 // 置数なし
    //
    //     // TODO:00012 平野 優先度が低いため以下は実装保留
    //     /*rc59_Soft_Ten_Key_Left ( CMEM->stat.FncCode );	// 左寄せ    */
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    // }

    //行番号：1317-1365
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if ((await RcMbrCom.rcmbrChkStat() != 0)
    //     && (regsMem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index)) {
    //   for (int p = 0; p < regsMem.tTtllog.t100001Sts.itemlogCnt; p++) {
    //     if (RcDepoInPlu.rcChkDepoMbrInPlu(1, p) == TRUE) {
    //       cMem.ent.errNo = DlgConfirmMsgKind.MSG_READ_MBRCARD.dlgId;
    //       await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //       return;
    //     }
    //   }
    // }
    //
    // /* 同一瓶管理番号チェック */
    // if (RcDepoInPlu.rcChkDepoBtlIdChk() == FALSE) {
    //   return;
    // }
    //
    // if (Rcdepoinplu.rcChkDepoBtlItemOnly() != 0) {
    //   cMem.ent.errNo = DlgConfirmMsgKind.MSG_DEPOBTL_CASH_ONLY.dlgId;
    //   await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //   return;
    // }
    //
    // if ((pCom.dbTrm.foreignDepositOpe != 0)
    //     && (cMem.stat.fncCode == FuncKey.KY_CHA10.keyId)) {
    //   if (cMem.ent.tencnt > 4) {
    //     cMem.ent.errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
    //     await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //     return;
    //   }
    //
    //   cMem.working.dataReg.kMul0
    //     = Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length);
    //   cMem.ent.tencnt = 0;
    //   if (cMem.working.dataReg.kMul0 != 0) {
    //     RcRegs.kyStR0(cMem.keyStat, FncCode.KY_ENT.keyId); /* Reset Bit 0 of KY_ENT  */
    //     RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_MUL.keyId); /* Set   Bit 0 of KY_MUL  */
    //     RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); /* Set   Bit 0 of KY_REG  */
    //   }
    // }
    //
    // if (RcKyPbchg.rckyPbchgRecChk() != 0) {
    //   cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
    //   await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //   return;
    // }

    // TODO:10107 コンパイルスイッチ(RF1_SYSTEM)
    // RF1_SYSTEMが0で定義されていたので、この部分はコメントアウトしておく。
    // #if RF1_SYSTEM
    // if (1 == cm_rf1_hs_System ())
    // {
    // // 特定惣菜仕様(RF様仕様)が「あり」の場合
    // if (OK != rc_appendixChkConfYet ())
    // {
    // /* 別添確認済みでない場合 */
    // /* 「別添確認未完了の商品があります」 */
    // CMEM->ent.err_no = MSG_APPENDIX_ERR;
    // rcErr (CMEM->ent.err_no);
    // return;
    // }
    // }
    // #endif	/* #if RF1_SYSTEM */

    //   #if RESERV_SYSTEM
    //   #if 0
    //   if( ( (cm_Reserv_system())
    //   || (cm_netDoAreserv_system()) )
    //   && (rcreserv_ReceiptCall())
    // && (!rcCheck_ReservMode()) )
    // {
    // if( rcCheck_Registration() )
    // {
    // if( rcReserv_ChkReservTbl( MEM->tHeader.reserv_cd, &rd_data ) )
    // {
    // CMEM->ent.err_no = MSG_DELIVERY_FINISH ;
    // rcErr(CMEM->ent.err_no);
    // return;
    // }
    // }
    // }
    // else if( (cm_Reserv_system())
    // && (rcNetreserv_ReceiptCall())
    // && (!rcCheck_NetReservMode()) )
    // {
    // if( rcCheck_Registration() )
    // {
    // CMEM->ent.err_no = rcNetReserv_ChkReservTbl( MEM->tHeader.reserv_cd);
    // if( CMEM->ent.err_no )
    // {
    // rcErr(CMEM->ent.err_no);
    // return;
    // }
    // }
    // }
    // #else
    //行番号：1414-1423
    // TODO:10121 QUICPay、iD 202404実装対象外
    // /* 予約呼出時の締め操作で、予約情報の再確認 */
    // errNo = RcReserv.reservFinishChk(regsMem.tHeader.reserv_cd);
    // if (errNo != 0) {
    //   cMem.ent.errNo = errNo;
    //   await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //   return;
    // }
    //   #endif
    //   #endif

    //行番号：1424-1438
    // TODO:10121 QUICPay、iD 202404実装対象外
    // //   #if RESERV_SYSTEM
    //   if (RcReserv.rcReservItmAddChk()) {
    //     cMem.ent.errNo = await rcErrKyCharge(0);
    //     if (cMem.ent.errNo != 0) {
    // // #if CUSTREALSVR
    //       if ((RcSysChk.rcChkCustrealsvrSystem() != 0)
    //           && (cMem.ent.errNo == DlgConfirmMsgKind.MSG_CUSTOTHUSE.dlgId)) {
    //         RcMbrRealsvr.rcCustRealOthUseMsgDsp();
    //       } else {
    // // #endif
    //         await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //       }
    //       return;
    //     }
    //     RcReserv.rcReserv(regsMem.tHeader.reserv_flg);
    //     return;
    //   }
    // // #endif

    //行番号：1440-1454
    // TODO:10121 QUICPay、iD 202404実装対象外
    // cMem.ent.errNo =RckyAccountReceivable.rcRyuboAccountReceivaleCashChk();
    // if (errNo != 0) {
    //   await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //   return;
    // }
    //
    // if ((RcSysChk.rcChkEdySystem()) && (RcFncChk.rcCheckEdyMode())){ /* Ｅｄｙモード？ */
    //   if (RcRegs.atSing.edysip60.page == EDY_PAGE.EDY_AFTER.id){ /* 終了キー状態？ */
    //     RcEdy.rcEdyKyFinal();
    //   }
    //   cMem.stat.orgCode = 0;
    //   int? page = RcRegs.atSing.edysip60.page;
    //   log = sprintf("Dust Ky_cha() edysip60-page[%d]\n",[page]);
    //   TprLog().logAdd(
    //       Tpraid.TPRAID_CHK, LogLevelDefine.error, log);
    //   return;
    // }

    // TODO:10115 コンパイルスイッチ(PSP_70)
    // PSP_70が0で定義されていたので、この部分はコメントアウトしておく。
    // #if PSP_70
    // if( RC_INFO_MEM->RC_CNCT.CNCT_RWT_CNCT == 7 && rcChk_Psp_KeyOpt())
    // {
    // if((rcVD_OpeModeChk() || (rxCalc_Stl_Tax_Amt(MEM) < 0)) && (C_BUF->db_trm.psp_minus_amt == 0))
    // return;
    // CMEM->ent.err_no = rcErr_KyCharge(0);
    // if(!CMEM->ent.err_no){
    // AT_SING->use_rwc_rw = 1;
    // rcPsp_Read_MainProc();
    // CMEM->ent.err_no = 0;
    // return;
    // }
    // }
    // #endif

    // TODO:00012 平野 優先度が低いため以下は実装保留
    //行番号：1469-1503
    /*
    	/* 紅屋特注 */
	/* JET-A nanaco */
	if (rcVD_OpeModeChk ())
	{
		if ((rcChk_JET_A_Standard_Process ())
		    //&&(cm_nanaco_system ()))
		    && (cm_cct_emoney_system()))
		{
			rcRead_kopttran (CMEM->stat.FncCode, &KOPTTRAN,	sizeof(KOPTTRAN));
			if ((KOPTTRAN.crdt_enble_flg == 1)
			    && ((KOPTTRAN.crdt_typ == 2)
//			        || (KOPTTRAN.crdt_typ == 7)
			        || (KOPTTRAN.crdt_typ == 22)))
			{
				CMEM->ent.err_no = MSG_CANT_USE;
				rcErr(CMEM->ent.err_no);
				return;
			}
		}
	}
	//会計５はJ-Mups決済取引の取消キーとして使用の為、訂正以外のモードで使用不可
	if((cm_sp_department_system()) && (cm_jmups_system()) && (CMEM->stat.FncCode == KY_CHA5))
	{
		cm_clr((char *)&KOPTTRAN, sizeof(kopttran_buff));
		rcRead_kopttran (CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
		if((KOPTTRAN.crdt_enble_flg == 0) &&	// 掛売りしない
		   (KOPTTRAN.crdt_typ == 24)	  &&	// 端末で選択
		   (!rcVD_OpeModeChk()))
		{
			CMEM->ent.err_no = MSG_OPEMERR_VOID;
			rcErr(CMEM->ent.err_no);
			return;
		}

	}
    */

    //行番号：1505-1510
    RcIfEvent.rxTimerRemove();
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (RcClsCom.clsComAcxAutoDecisionStop() != 0) {
    //   await RcIfEvent.rxChkTimerAdd();
    //   return;
    // }

    // TODO:00012 平野 優先度が低いため以下は実装保留
    //行番号：1512-1578
    /*
if(rcChk_Suica_System() && rcChk_Suica_KeyOpt())
   {
     AT_SING->suica_data.suicakey = CMEM->stat.FncCode;
     AT_SING->suica_data.suicadev = I_BUF->DevInf.dev_id;
     CMEM->ent.err_no = rcErr_KyCharge(0);
     if(CMEM->ent.err_no == OK)
        CMEM->ent.err_no = rcATCT_Proc_Error(1);
     rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
     if(CMEM->ent.err_no != OK){
        rcErr(CMEM->ent.err_no);
        rxChkTimerAdd();
        TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "Suica Cha error \n");
        return;
     }
     if(!rcChk_Suica_KeyOptStat()){
        CMEM->ent.err_no = MSG_CHKSETTING;
        rcErr(CMEM->ent.err_no);
        rxChkTimerAdd();
        return;
     }
	if((cm_tb1_system()) && (MEM->tTtllog.t100700.mbr_input != MBRPRC_KEY_INPUT) && (MEM->tTtllog.t100700.mbr_input != NON_INPUT))
	{
		CMEM->ent.err_no = MSG_NOOPEERR;
		rcErr(CMEM->ent.err_no);
		rxChkTimerAdd();
		return;
	}
     if((TS_BUF->suica.Trans_flg == 1) || (TS_BUF->suica.Trans_flg == 2)) {
        CMEM->ent.err_no = MSG_BUSY_FCLDLL;
        rcErr(CMEM->ent.err_no);
        rxChkTimerAdd();
        return;
     }
     if(TS_BUF->suica.order != SUICA_NOT_ORDER){
        CMEM->ent.err_no = MSG_TEXT14;
        rcErr(CMEM->ent.err_no);
        rxChkTimerAdd();
        return;
     }
     if(CMEM->ent.tencnt != 0 && (AT_SING->suica_data.page != SUICA_AFTER) && (!rcVD_OpeModeChk())){
        CMEM->ent.err_no = MSG_OPEMISS;
        rcErr(CMEM->ent.err_no);
        rxChkTimerAdd();
        return;
     }
     if(rxCalc_Stl_Tax_In_Amt(MEM) < 0 && !rcTR_OpeModeChk()){
        CMEM->ent.err_no = MSG_OPEMISS;
        rcErr(CMEM->ent.err_no);
        rxChkTimerAdd();
        return;
     }
     if(!CMEM->ent.err_no && AT_SING->suica_data.page != SUICA_AFTER && TS_BUF->suica.Trans_flg != 2){
           rxChkTimerAdd();
           rcSuica_Read_MainProc();
           CMEM->ent.err_no = 0;
           return;
     }
   }
   else if((rcChk_Suica_System()) && (rxCalc_Suica_Amt(MEM))) {
       rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
       if((KOPTTRAN.crdt_enble_flg == 1) && (KOPTTRAN.crdt_typ != 7)) {
          CMEM->ent.err_no = MSG_OPEMISS;
          rcErr(CMEM->ent.err_no);
          rxChkTimerAdd();
          return;
       }
   }
    */

    //行番号：1580-1598
    lEntry = Bcdtol.cmBcdToL(cMem.ent.entry);
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (rckyChaSplitDisableChk()) {
    //   cMem.ent.errNo = DlgConfirmMsgKind.MSG_HC2_USE_TOGETHER_ERR.dlgId;
    //   await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //   await RcIfEvent.rxChkTimerAdd();
    //   return;
    // } else if ((rckyChaWSEmoneyChk())
    //     && (!((cMem.working.dataReg.kMul0  == 0)
    //         && (RxLogCalc.rxCalcStlTaxAmt(regsMem) > 0)
    //         && ((RxLogCalc.rxCalcStlTaxAmt(regsMem) == lEntry)
    //             || (lEntry == 0))))) {
    //   cMem.ent.errNo = DlgConfirmMsgKind.MSG_CCT_STLAMT_ONLY.dlgId;
    //   await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //   await RcIfEvent.rxChkTimerAdd();
    //   return;
    // }
    //
    // //行番号：1600-1645
    // if (await CmCksys.cmPrecacardMultiUse() != 0) {
    //   // 複数枚プリカ利用での釣りあり会計（お釣り有）は利用不可
    //   // （「預り金額の値数強制」「釣り銭支払」の設定に関係なく）
    //   if ((RcAjsEmoney.rcAjsSptendCheck(
    //       regsMem.tTtllog, MulprecaSptendCountCheckTyp.MULPRECA_SPTEND_PREPAID.keyId,
    //       CntList.sptendMax) >= 2)                  // プリカ２枚以上利用あり
    //       && (RcSysChk.rcQRChkPrintSystem())        //SPEEZA
    //       && (!await RcSysChk.rcQCChkQcashierSystem())) { //qCashierでない
    //     // 今回指定[会計X]の金額を算出
    //     await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //     if (cMem.working.dataReg.kMul0 != 0) {
    //       lEntry = cMem.working.dataReg.kMul0 * (Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length));
    //     } else if (cMem.working.dataReg.kPri0  != 0) {
    //       lEntry = cMem.working.dataReg.kPri0 * (Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length));
    //     } else {
    //       lEntry = Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length);
    //       if (RcFncChk.rcChkBeforeMulKy()
    //           && (koptTran.chkAmt! > 0)
    //           && (lEntry != 0)
    //           && RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) {
    //         lEntry = lEntry * (koptTran.chkAmt!);
    //       }
    //     }
    //     if ((lEntry == 0) && (koptTran.chkAmt! > 0)) {
    //       if ((cMem.working.dataReg.kMul0) != 0) {
    //         lEntry = (cMem.working.dataReg.kMul0)
    //             * (koptTran.chkAmt!);
    //       } else {
    //         lEntry = koptTran.chkAmt!;
    //       }
    //     }
    //
    //     // 釣り有の場合
    //     if ((lEntry - RxLogCalc.rxCalcStlTaxAmt(regsMem)) > 0) {
    //       TprLog().logAdd(
    //           Tpraid.TPRAID_CHK, LogLevelDefine.normal, "rcKyCharge: can not use. chgamt exist.\n");
    //       cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId; // この操作は行えません
    //       await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //       await RcIfEvent.rxChkTimerAdd();
    //       return;
    //     }
    //   }
    // }

    CustreadExecFlg = 0; // 会計キーの直前に顧客読込みするフラグ
    cMem.ent.errNo = await rcErrKyCharge(0);

    //行番号：1647-1672
    // #if 0
    // if(rc_MbrPrc_Set(CMEM->stat.FncCode,1))
    // {
    // rxTimerAdd();
    // return;
    // }
    // #else
    errCd = RcMbrCom.rcMbrPrcSet(cMem.stat.fncCode, 1);
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (errCd != 0) {
    //   if (errCd == DlgConfirmMsgKind.MSG_KANESUE_CANT_PAYMENT.dlgId) {
    //     // キー入力が許可されなかったので、このエラーの場合だけ処理を分ける
    //     // else側の処理はオリジナルなので、そのままにしておく
    //     log = sprintf("rcKyCharge: <kanesue> err_cd [%d]\n", [errCd]);
    //     TprLog().logAdd(
    //         Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);
    //
    //     await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //     await RcIfEvent.rxChkTimerAdd();
    //   } else {
    //     RcIfEvent.rxTimerAdd();
    //   }
    //   return;
    // }
    // #endif

    //行番号：1674-1727
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (RcSysChk.rcChkTRKPrecaSystem()) {
    //   if (rcChkPrecaKeyOpt()) {
    //     if (cMem.ent.errNo == DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId) {
    //       cMem.ent.errNo = OK;
    //       await RcIfEvent.rxChkTimerAdd();
    //       RcTrkPreca.rcKyTRKPrecaIn();
    //       return;
    //     }
    //   }
    // }
    //
    // if (RcSysChk.rcChkRepicaSystem()) {
    //   if (rcChkPrecaKeyOpt()) {
    //     if (cMem.ent.errNo == DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId) {
    //       cMem.ent.errNo = OK;
    //       await RcIfEvent.rxChkTimerAdd();
    //       RcRepica.rcKyRepicaIn();
    //       return;
    //     }
    //   }
    // }
    //
    // if (RcSysChk.rcSysChkHappySmile()
    //     && (RcRegs.atSing.inputbuf.dev == DevIn.D_TCH)
    //     && (RcQcDsp.qcChaPrecaSideFlag == 3)) {
    //   // HappySelfシステムSmileSelf状態で
    //   // カラー客表のプリカ会計キーが押された
    //
    //   if (RcSysChk.rcChkCogcaSystem()) {
    //     if (rcChkPrecaKeyOpt()) {
    //       if (cMem.ent.errNo == DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId) {
    //         cMem.ent.errNo = OK;
    //         await RcIfEvent.rxChkTimerAdd();
    //
    //         await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //         if (koptTran.frcEntryFlg == 1) {
    //           // プリカ会計キーのキーオプションについて、
    //           // 預り金額の置数強制が する に設定されている場合、
    //           // プリカ宣言キー処理内でオペエラーが発生するのを回避する
    //           cMem.ent.tencnt = 0;
    //         }
    //         RcCogca.rcKyCogcaIn();
    //         return;
    //       }
    //     }
    //   }
    // }

    //行番号：1731-1742
    //   #if 0
    //   if(rcChk_Ajs_Emoney_System()) {
    // if(rcChk_Preca_KeyOpt()) {
    // if(CMEM->ent.err_no == MSG_PRECA_IN_ERR) {
    // CMEM->ent.err_no = OK;
    // rxChkTimerAdd();
    // rcKy_Ajs_Emoney_In();
    // return;
    // }
    // }
    // }
    // #endif

    //行番号：1744-1782
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (RcSysChk.rcChkBarcodePaySystem() != 0) {
    //   if ((RcBarcodePay.rcChkBarcodePayKeyOpt(cMem.stat.fncCode)) != 0) {
    //     if (await CmCksys.cmZHQSystem() != 0) {
    //       // TODO:00012 平野 優先度が低いため以下は実装保留
    //       /*
    //         snprintf(filename, sizeof(filename), "%s/conf/barcode_pay.ini", SysHomeDirp);
    // 		    snprintf(section, sizeof(section), "barcodepay");
    // 		    memset(tmp, 0x00, sizeof(tmp));
    // 		    if(TprLibGetIni((uchar *)filename, section, "validFlg", (uchar *)tmp) != 0)
    // 		    {
    // 			    TprLibLogWrite(GetTid(), TPRLOG_ERROR, TPRLOG_ERROR, "barcode_pay validFlg get error\n");
    // 		    }
    // 		    if (atoi(tmp) != 1)
    // 		    {
    // 			    CMEM->ent.err_no = MSG_NOT_EFFECTTIVE_FUNC;
    // 			    AplLib_ImgRead((long)IMG_CANALPAYMENT, tmp_buf, 20);
    // 			    snprintf(CMEM->ent.AddMsgBuf, sizeof(CMEM->ent.AddMsgBuf), "%s", tmp_buf);
    // 			    rcErr(CMEM->ent.err_no);
    // 			    rxChkTimerAdd();
    // 			    return;
    // 		    }
    //       */
    //     }
    //     if (cMem.ent.errNo == DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId) {
    //       cMem.ent.errNo = OK;
    //       await RcIfEvent.rxChkTimerAdd();
    //       RcBarcodePay.rcKyBarcodePayIn();
    //       return;
    //     } else if (RcSysChk.rcSysChkHappySmile()
    //         && (cMem.ent.errNo != 0)) {
    //       RcObr.rcScanEnable();
    //       log = sprintf("rcKyCharge: scanner enable [%d]\n", [cMem.ent.errNo]);
    //       TprLog().logAdd(
    //           Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);
    //     }
    //   }
    // }

    //行番号：1784-1820
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (RcSysChk.rcsyschkRepicaPointSystem()) {
    //   //if (await rcChkRepicaPointKeyOpt()) {
    //     if (cMem.ent.errNo == DlgConfirmMsgKind.MSG_PRECA_IN_ERR.dlgId) {
    //       cMem.ent.errNo = OK;
    //       await RcIfEvent.rxChkTimerAdd();
    //       RcRepica.rcKyRepicaIn();
    //       return;
    //     }
    //   //}
    // }

    // TODO:10121 QUICPay、iD 202404実装対象外
    //   if ((cMem.ent.errNo != 0)
    //       && (!((RcSysChk.rcChkSuicaSystem())
    //           && (rcChkSuicaKeyOpt())
    //           && (RxLogCalc.rxCalcSuicaAmt(regsMem) != 0)))) {
    // //   #if CUSTREALSVR
    //     if ((RcSysChk.rcChkCustrealsvrSystem() != 0)
    //         && (cMem.ent.errNo == DlgConfirmMsgKind.MSG_CUSTOTHUSE.dlgId)) {
    //       RcMbrRealsvr.rcCustRealOthUseMsgDsp();
    //     } else {
    // //   #endif
    //       await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //       await RcIfEvent.rxChkTimerAdd();
    //       return;
    //     }
    //   }
    //   if (await RcFncChk.rcCheckESVoidIMode()) {
    //     rcChargeAmount();
    // //   #if RALSE_MBRSYSTEM
    //     if ((RcSysChk.rcChkRalseCardSystem())
    //         && (Rxmbrcom.rcmbrNotMbrPoiPrnChk())) {
    //       RcMbrPoiCal.rcmbrTodayPoint(1);
    //     }
    // //   #endif
    //     return;
    //   }

    //行番号：1821-1883
    //   #if SIMPLE_STAFF
    pCom.saveStaffCd = int.tryParse(pCom.dbStaffopen.cshr_cd ?? "") ?? 0;
    //   #endif
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (((await CmCksys.cmPFMJRICSystem() != 0) ||
    //     (await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC)))
    //     && (RxLogCalc.rxCalcSuicaAmt(regsMem) != 0)) {
    //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //   if (koptTran.crdtEnbleFlg == 1) {
    //     cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
    //     await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    // }
    //
    // if ((await CmCksys.cmTuoSystem() != 0)
    //     && rcChkTuoKeyOpt()
    //     && (RcRegs.atSing.tuoMcdFlg == 0)
    //     && (regsMem.tTtllog.t100001Sts.sptendCnt == 0)) {
    //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //   digit = (koptTran.digit)! * 10000;
    //   if (digit != 70000) {
    //     if (RxLogCalc.rxCalcStlTaxAmt(regsMem) > digit) {
    //       cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT42.dlgId;
    //     }
    //     if (cMem.ent.errNo != 0) {
    //       await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //       await RcIfEvent.rxChkTimerAdd();
    //       return;
    //     }
    //   }
    //   RcTuo.rcTuoCardDsp();
    //   await RcIfEvent.rxChkTimerAdd();
    //   return;
    // } else if ((await CmCksys.cmTuoSystem() != 0) && (RcRegs.atSing.tuoFlg == 0)) {
    //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //   lEntry = koptTran.chkAmt!;
    //   if (lEntry > 99) {
    //     RcTuo.rcTuomain();
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    // }
    //
    // if ((await CmCksys.cmMediaInfoSystem() != 0)
    //     && (rcChkMediaKeyOpt())
    //     && (RcRegs.atSing.mediaMcdFlg == 0)
    //     && (cMem.stat.fncCode == FuncKey.KY_CHA10.keyId)
    //     && !(RcSysChk.rcChkEdySystem())
    //     && !(RcSysChk.rcChkMultiEdySystem() != 0)) {
    //   rcMedia.media_jis1_chk = 0;
    //   rcMedia.media_jis2_chk = 0;
    //   // memset( media_crdt_cd, 0x00, sizeof(media_crdt_cd) );
    //   // memset( media_limit_yy, 0x00, sizeof(media_limit_yy) );
    //   // memset( media_limit_mm, 0x00, sizeof(media_limit_mm) );
    //   RcMedia.rcMediaCrdtDsp();
    //   await RcIfEvent.rxChkTimerAdd();
    //   return;
    // }

    //行番号：1885-1935
    // TODO:10121 QUICPay、iD 202404実装対象外
    //   #if RESERV_SYSTEM
    //   if (rcCheckReservKeyOpt()) {
    //     RcReserv.rcReserv(RESERV_FLG.RESERV_FLG_RESERV.value); /* 予約   */
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   } else if (rcCheckEstimateKeyOpt()) {
    //     RcReserv.rcReserv(RESERV_FLG.RESERV_FLG_ESTIMATE.value); /* 見積り */
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   } else if (rcCheckReservDeliveryKeyOpt()) {
    //     RcReserv.rcReserv(RESERV_FLG.RESERV_FLG_DELIVERY.value); /* 配達 */
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   } else if (rcCheckReservCreditKeyOpt()) {
    //     RcReserv.rcReserv(RESERV_FLG.RESERV_FLG_CREDIT.value); /* 掛売り */
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    //   #endif
    //
    // if ((pCom.dbTrm.accruedDisp != 0)
    //     && (await RcMbrCom.rcmbrChkStat() != 0)
    //     && (cMem.stat.fncCode == FuncKey.KY_CHA1.keyId))
    //   // TODO:00012 平野 strtol関数の変換まだ
    //   //&& (strtol(MEM->tTtllog.t100100[9].edy_cd, NULL, 10) == 0)){
    //     {
    //   if (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
    //     // スプリット中はエラー
    //     await RcEwdsp.rcErr2('rcKyCharge', DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    //   } else {
    //     Rcprestl.rc_JANagano_Disp();
    //   }
    //   await RcIfEvent.rxChkTimerAdd();
    //   return;
    // }
    //
    // if (RcSysChk.rcChkCOOPSystem()
    //     && (regsMem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index)
    //     && (pCom.dbTrm.autoInputCust != 0)) {
    //   RcKyCardForget.rcProcKyCardFgt();
    // }
    AtSingl atSing = SystemFunc.readAtSingl();
    if (atSing.webrealData.addStat != 2) {
      atSing.webrealData.addStat = 0;
      atSing.webrealData.addErr = 0;
      atSing.webrealData.func = null;
    }

    //行番号：1937-1982
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (RcSysChk.rcChkCustrealWebserSystem()
    //     && (regsMem.tTtllog.t100700.mbrInput == MbrInputType.magcardInput.index)) {
    //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //   if (cMem.working.dataReg.kMul0 != 0) {
    //     lEntry = ((cMem.working.dataReg.kMul0)
    //         * (Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length)));
    //   } else {
    //     lEntry = Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length);
    //   }
    //   if ((lEntry == 0) && (koptTran.chkAmt! > 0)) {
    //     if (cMem.working.dataReg.kMul0 != 0) {
    //       lEntry = (cMem.working.dataReg.kMul0)
    //           * (koptTran.chkAmt!);
    //     } else {
    //       lEntry = (koptTran.chkAmt!);
    //     }
    //   }
    //   if ((cMem.stat.fncCode == RcMbrPcom.rcmbrGetManualRbtKeyCd())
    //       && (RcRegs.atSing.webrealData.step != 3)
    //       && (RcRegs.atSing.webrealData.step != 4)
    //       && (RcRegs.atSing.webrealData.step != 5)
    //       && (RcSysChk.rcVDOpeModeChk())) {
    //     RcRegs.atSing.webrealData.step = 2;
    //     RcRegs.atSing.webrealData.key = cMem.stat.fncCode;
    //     Rcmbrrealsvr2.rcwebrealDsp();
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    //   if ((cMem.stat.fncCode == RcMbrPcom.rcmbrGetManualRbtKeyCd())
    //       && (RcRegs.atSing.webrealData.step != 4)
    //       && (RcRegs.atSing.webrealData.step != 5)
    //       && (RcSysChk.rcTROpeModeChk())) {
    //     cMem.ent.errNo = Rcmbrrealsvr2.CustReal2SvrAdd(0);
    //   }
    //   if (cMem.ent.errNo != OK) {
    //     RcRegs.atSing.webrealData.key = cMem.stat.fncCode;
    //     Rcmbrrealsvr2.rcwebrealDialogErr(cMem.ent.errNo, 1);
    //     TprLog().logAdd(
    //         Tpraid.TPRAID_CHK, LogLevelDefine.normal,
    //         "rcChk_Custreal_Webser_System Add error \n");
    //     return;
    //   }
    //   if (((lEntry >= RxLogCalc.rxCalcStlTaxAmt(regsMem)) || (lEntry == 0))
    //       && (RcRegs.atSing.webrealData.step != 4)) {
    //     RcRegs.atSing.webrealData.addStat = 1;
    //     RcRegs.atSing.webrealData.key = cMem.stat.fncCode;
    // // #if 0
    //       //  CMEM->ent.err_no = CustReal2SvrAdd(1);
    //       //  if(CMEM->ent.err_no != OK){
    //       //    AT_SING->webreal_data.key = CMEM->stat.FncCode;
    //       //    rcwebreal_DialogErr( CMEM->ent.err_no, 2, NULL );
    //       //    TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcChk_Custreal_Webser_System Add error \n");
    //       //    AT_SING->webreal_data.step = 0;
    //       //    return;
    //       //  }
    //       //  AT_SING->webreal_data.step = 0;
    // // #endif
    //     }
    //   }

    //行番号：1984-2001
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if ((Rxkoptcmncom.rxChkKoptCrdtTypeSlip(pCom, cMem.stat.fncCode))
    //     && (pCom.dbTrm.kamadoStldscCha1Func != 0)
    //     && (cMem.stat.fncCode == FuncKey.KY_CHA1.keyId)) {
    //   TprLog().logAdd(
    //       Tpraid.TPRAID_CHK, LogLevelDefine.normal,
    //       "auto stldsc exec msg dsp\n");
    //   rcchaHokunoSlipMsg();
    //   return;
    // }
    //
    // if (RcSysChk.rcsyschkEmployeeCardPaymentSystem()
    //     && RcSysChk.rcSysChkHappySmile()) {
    //   // 社員証決済仕様[売店]有効時、対面セルフの店員側画面で会計20キーの押下を禁止する。
    //   if (cMem.stat.fncCode == RcFncChk.rcGetEmployeeCardFncCode()) {
    //     cMem.ent.errNo = DlgConfirmMsgKind.MSG_PAY_FULLSELF_ONLY.dlgId;
    //     await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    // }

    //行番号：2003-2081
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (!await RcSysChk.rcQCChkQcashierSystem()) {
    //   // Qcashierの場合は、カードを読み込むタイミングが違う為
    //   RxmemBcdpayBcd rxmemBcdpayBcd = RxmemBcdpayBcd();
    //   if ((await CmCksys.cmNimocaPointSystem() != 0)
    //       && (rxmemBcdpayBcd.type == 0)
    //       && ((await CmCksys.cmSuicaSystem() != 0)
    //           &&
    //           (await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC)))) {
    //     await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //     if (cMem.working.dataReg.kMul0 != 0) {
    //       lEntry = (cMem.working.dataReg.kMul0)
    //           * (Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length));
    //     } else {
    //       lEntry = Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length);
    //     }
    //     if ((lEntry == 0) && (koptTran.chkAmt! > 0)) {
    //       if (cMem.working.dataReg.kMul0 != 0) {
    //         lEntry = (cMem.working.dataReg.kMul0)
    //             * (koptTran.chkAmt!);
    //       } else {
    //         lEntry = koptTran.chkAmt!;
    //       }
    //     }
    //
    //     if ((lEntry >= RxLogCalc.rxCalcStlTaxAmt(regsMem)) ||
    //         (lEntry == 0)) { // (lEntry >= MEM->ttlrbuf.stl_tax_amt)
    //       if (await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC)) {
    //         if ((regsMem.tTtllog.t100700.mbrInput
    //             == MbrInputType.mbrprcKeyInput.index) // if((MEM->ttlrbuf.mbr_input == 12)
    //             && (RxLogCalc.rxCalcSuicaAmt(regsMem) == 0) // && (MEM->prnrbuf.suica_amt == 0)
    //             && (RcSysChk.rcCheckCrdtStat())
    //             && (koptTran.crdtEnbleFlg == 1)
    //             && (koptTran.crdtTyp == 26)) {
    //           if (tsBuf.multi.order != FclProcNo.FCL_NOT_ORDER.index) {
    //             cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT14.dlgId;
    //             await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //             await RcIfEvent.rxChkTimerAdd();
    //             return;
    //           }
    //           rcChargeAmount21();
    //           return;
    //         }
    //       } else {
    //         if ((regsMem.tTtllog.t100700.mbrInput
    //             == MbrInputType.mbrprcKeyInput.index) //(MEM->ttlrbuf.mbr_input == 12)
    //             && (regsMem.tmpbuf.nimocaPointOut == 0) //(MEM->nimoca_point_out == 0)
    //             && (RxLogCalc.rxCalcSuicaAmt(regsMem) == 0) //(MEM->prnrbuf.suica_amt == 0)
    //             && (!RcSysChk.rcCheckCrdtStat())) {
    //           if ((tsBuf.suica.transFlg == 1)
    //               || (tsBuf.suica.transFlg == 2)
    //               || ((tsBuf.suica.timeFlg == 1)
    //                   && (await RcSysChk.rcQCChkQcashierSystem()))) {
    //             cMem.ent.errNo = DlgConfirmMsgKind.MSG_BUSY_FCLDLL.dlgId;
    //             await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //             await RcIfEvent.rxChkTimerAdd();
    //             return;
    //           } else if (tsBuf.suica.order != SuicaProcNo.SUICA_NOT_ORDER.index) {
    //             cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT14.dlgId;
    //             await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //             await RcIfEvent.rxChkTimerAdd();
    //             return;
    //           }
    //           rcChargeAmount21();
    //           return;
    //         }
    //       }
    //     }
    //   }
    //   if (CustreadExecFlg != 0) {
    //     log = sprintf("rcKyCharge:no cust read before pay[%d]:[%s](%d)(%d)\n",[
    //       regsMem.tTtllog.t100700.mbrInput,
    //       regsMem.tTtllog.t100700Sts.nimocaNumber,
    //       rxmemBcdpayBcd.type,
    //       RxLogCalc.rxCalcSuicaAmt(regsMem)
    //     ]);
    //     TprLog().logAdd(
    //         Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);
    //     cMem.ent.errNo = DlgConfirmMsgKind.MSG_ALTERNATIVE_PAYMENT.dlgId;
    //     await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    //   //行番号：2082-2140
    // } else {
    //   if (RcQcDsp.qc_chachk_last_check == 1) { // 最後のみ
    //     if ((RcQcDsp.qc_chachk_spcnt == regsMem.tTtllog.t100001Sts.sptendCnt)
    //         && (RcQcDsp.qc_chachk_code == cMem.stat.fncCode)) {
    //       ctrlFlg = 1;
    //     }
    //   }
    //
    //   if (ctrlFlg == 1) {
    //     RcQcDsp.qc_chachk_last_check = 0;
    //     actChk = 0;
    //     if (await RcSysChk.rcsyschkCreditreceiptIssueQcSide()) {
    //       if (!RcFncChk.rcQCCheckMenteDspMode()) {
    //         if (koptTran.crdtEnbleFlg != 1) {
    //           actChk = 1;
    //         }
    //       }
    //     }
    //
    //     if (actChk == 1) {
    //       RcQcDsp.rcqcDspCleateReceiptSelect(FuncKey.KY_CHA1.keyId);
    //       return;
    //     } else {
    //       if (RcSysChk.rcsyschkQcNimocaSystem()) {
    //         if (RcFncChk.rcQCCheckStartDspMode()) {
    //           if (regsMem.tTtllog.t100700.mbrInput
    //               == MbrInputType.mbrprcKeyInput.index) {
    //             if (cMem.working.dataReg.kMul0 != 0) {
    //               lEntry = (cMem.working.dataReg.kMul0)
    //                   * (Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length));
    //             } else {
    //               lEntry = Bcdtol.cmBcdtol(cMem.ent.entry,cMem.ent.entry.length);
    //             }
    //
    //             if ((lEntry >= RxLogCalc.rxCalcStlTaxAmt(regsMem)) || (lEntry == 0)) {
    //               RcQcDsp.rcqcDspNimocaYesNo(3);
    //               return;
    //             }
    //           }
    //         }
    //       }
    //     }
    //   }
    // }
    //行番号：2142-2210
    // #if 0
    // if (rcChk_Tpoint_System())
    // {
    // if (CMEM->stat.FncCode == rcmbr_GetManualRbtKeyCd())
    // {
    // CMEM->ent.err_no = rcrealsvr2_Tpoint_Use(0, (t_ttllog *)&MEM->tTtllog);
    // }
    // if (CMEM->ent.err_no != OK)
    // {
    // rcErr(CMEM->ent.err_no);
    // rxChkTimerAdd();
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "cm_custreal_Tpoint_system Add error \n");
    // return;
    // }
    // }
    // #endif
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (RcCompointentdsp.rcComPointEntDspSkip(cMem.stat.fncCode)) {
    //   /* ポイント利用画面が表示可能な場合 */
    //
    //   /* ポイント利用が可能か判断 */
    //   cMem.ent.errNo =
    //       RcCompointentdsp.rcComPointUseCheck
    //         (Rxmbrcom.rxmbrcomManualRbtKeyPointKind(
    //           cMem.stat.fncCode, pCom));
    //   if (cMem.ent.errNo != 0) {
    //     await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    //
    //   /* ポイント利用画面表示 */
    //   cMem.ent.errNo =
    //       RcCompointentdsp.rcComPointEntDsp
    //         (Rxmbrcom.rxmbrcomManualRbtKeyPointKind(
    //           cMem.stat.fncCode, pCom));
    //   if (cMem.ent.errNo != 0) {
    //     await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //   }
    //   await RcIfEvent.rxChkTimerAdd();
    //   return;
    // }
    //
    // if (RcSysChk.rcChkMammyMartSystem()) {
    //   if (cMem.stat.fncCode == FuncKey.KY_CHA3.keyId) {
    //     /* 品券3 = 社割券 */
    //     if (rcCheckGetStaffNo()) {
    //       return;
    //     }
    //   }
    // }
    //
    // if (RcSysChk.rcChkDPointSystem()
    //     && RcFncChk.rcChkDPointUseKey()
    //     && (RcRegs.atSing.dpointRecrsplitFlg == 0)) {
    //   RcDpoint.rcDPointUse();
    //   return;
    // }
    //
    // if (RcSysChk.rcsyschkTpointAdvancedSystem(1)
    //     && (cMem.stat.fncCode == Rxmbrcom.rxmbrcomChkComPointUseKey(
    //         POINT_TYPE.PNTTYPE_TPOINT, pCom))) {
    //   cMem.ent.errNo = RcTpoint.rcTpointUse();
    //   if (cMem.ent.errNo != 0) {
    //     await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //     await RcIfEvent.rxChkTimerAdd();
    //     return;
    //   }
    // }

    //行番号：2212-2249
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if ((RcSysChk.rcsyschkTomoIFSystem())
    //     && (cMem.stat.fncCode // 友の会に設定されたキー押下
    //         == Rxkoptcmncom.rxChkCHACHKOnlyCrdtTyp(
    //             pCom, SPTEND_STATUS_LISTS.SPTEND_STATUS_TOMOCARD.typeCd))) {
    //   if (!await RcSysChk.rcQCChkQcashierSystem()) { // QCashier状態でない
    //     TprLog().logAdd(
    //         Tpraid.TPRAID_CHK, LogLevelDefine.normal,
    //         "rcKyCharge [Tomo] non QC");
    //     // 呼び戻しの時は、会計キー処理を実行する
    //     if (RcqrCom.qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_INIT.index) {
    //
    //     } else {
    //       // 友の会利用画面を表示
    //       RckyTomoCard.rcKyTomoCardAmt();
    //       await RcIfEvent.rxChkTimerAdd();
    //       return;
    //     }
    //   } else { // Qcashierで動作中 or フルセルフのメンテ画面
    //     TprLog().logAdd(
    //         Tpraid.TPRAID_CHK, LogLevelDefine.normal,
    //         "rcKyCharge [Tomo] QC or Mnt");
    //     if (RcFncChk.rcQCCheckMenteDspMode()) { //メンテナンス画面で　友の会会計キー操作
    //       cMem.ent.errNo =
    //           RckyTomoCard.rcKyTomoCardPay(); // 支払通信を実行 (メンテナンス  全額 or 一部額)
    //       if (cMem.ent.errNo != 0) {
    //         await RcEwdsp.rcErr2('rcKyCharge', cMem.ent.errNo);
    //       }
    //       await RcIfEvent.rxChkTimerAdd();
    //       return;
    //     }
    //     // 会計キー処理を実行
    //   }
    //   TprLog().logAdd(
    //       Tpraid.TPRAID_CHK, LogLevelDefine.normal,
    //       "rcKyCharge [Tomo] go KyCharge");
    // }

    //行番号：2252-2340
    // TODO:10033 コンパイルスイッチ(TW)
    // TWが0で定義されていたので、この部分はコメントアウトしておく。
    //   #if TW & 0
    //   if(rxCalc_Stl_Tax_In_Amt(MEM) < 0)
    // rcTWNoRef((void *)rcChargeAmount);
    // else
    // #endif
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (RcFncChk.rcChkErr() == 0) { /* ダイアログ表示中でない */
    //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //   if (RcSysChk.rcChkKYCHA(cMem.stat.fncCode)) { //会計キー？／品券キー？
    //     if (!Rcinoutdsp.rc28LcdUnReadCashDispShowingChk()) { // 未読現金入金画面が表示中で無い
    //       if (RcFncChk.rcsyschkUnreadCashChk(
    //           cMem.stat.fncCode)) { //未読現金設定？
    //         if (koptTran.frcStlkyFlg == 1) { //小計キー強制なら押されたかチェック
    //           if (!RcFncChk.rcCheckStlMode()) {
    //             log = sprintf("rcKyCharge: KOPTTRAN.frc_stlky_flg[%d]\n",
    //                 [koptTran.frcStlkyFlg]);
    //             TprLog().logAdd(
    //                 Tpraid.TPRAID_CHK, LogLevelDefine.error, log);
    //             await RcEwdsp.rcErr2(
    //                 'rcKyCharge', DlgConfirmMsgKind.MSG_SUBTTLFCE.dlgId);
    //             await RcIfEvent.rxChkTimerAdd();
    //             return;
    //           }
    //         }
    //         Rcinoutdsp.rc28LcdUnReadCashDisp(); //未読現金入力
    //         await RcIfEvent.rxChkTimerAdd();
    //         return;
    //       }
    //     } else {
    //       Rcinoutdsp.rc28LcdUnReadCashDispFlgOff();
    //     }
    //   }
    // }
    //
    // if (RcFncChk.rcChkErr() == 0) {
    //   /* ダイアログ表示中でない */
    //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    //   if (RcSysChk.rcChkKYCHA(cMem.stat.fncCode)) { //会計キー？／品券キー？
    //     if (RcFncChk.rcsyschkCampaignSetChk(
    //         cMem.stat.fncCode)) { //キャンペーン値引き設定？
    //       if(koptTran.frcStlkyFlg == 1){ //小計キー強制なら押されたかチェック
    //         if (!RcFncChk.rcCheckStlMode()) {
    //           log = sprintf("rcKyCharge: koptTran.frcStlkyFlg[%d]\n"
    //                         ,[koptTran.frcStlkyFlg]);
    //           TprLog().logAdd(
    //               Tpraid.TPRAID_CHK, LogLevelDefine.error, log);
    //           await RcEwdsp.rcErr2(
    //               'rcKyCharge', DlgConfirmMsgKind.MSG_SUBTTLFCE.dlgId);
    //           await RcIfEvent.rxChkTimerAdd();
    //           return;
    //         }
    //       }
    //       rckyCampaignDiscount(); //キャンペーン値引き処理
    //       await RcIfEvent.rxChkTimerAdd();
    //       return;
    //     }
    //   }
    // }
    //
    // if(await CmCksys.cmSm66FrestaSystem() != 0){
    //   await RcIfEvent.rxChkTimerAdd();
    //   if(RcAtct.rcATCTFrestaDivideDispProc() == false){
    //     // 終了を選択or金額入力表示or選択後エラー
    //     return;
    //   }
    //   rcChargeAmount0();
    //   return;
    // }
    await rcChargeAmount();

    // TODO:10121 QUICPay、iD 202404実装対象外
    // //#if RALSE_MBRSYSTEM
    //   if(RcSysChk.rcChkRalseCardSystem() && Rxmbrcom.rcmbrNotMbrPoiPrnChk()){
    //     if(!await RcFncChk.rcCheckERefSMode()){
    //       RcMbrPoiCal.rcmbrTodayPoint(1);
    //     }
    //   }
    // //#endif

    //#if SIMPLE_2STAFF & 0
    if ((pCom.dbTrm.frcClkFlg == 2) &&
        (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR)) {
      fnal_count++;
    }
    //#endif
    return;
  }

/*----------------------------------------------------------------------*
 * Charge amount
 *----------------------------------------------------------------------*/
  static int acrErrNo = 0;
  static int printErr = 0;
  static int updateErr = 0;
  static int prnendCnt = 0;

  // TODO:10116 コンパイルスイッチ(STATION_PRINTER)
  // TODO:10117 コンパイルスイッチ(TW_2S_PRINTER)
  // STATION_PRINTER、TW_2S_PRINTERが0で定義されていたので、この部分はコメントアウトしておく。
  // #if (STATION_PRINTER || TW_2S_PRINTER)
  // int   stprend_cnt;
  // #endif
  static int popWarn = 0;
  static int lEntry = 0;
  static TendType? eTendType;

  /* ternder type */

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount0()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static void rcChargeAmount0() {
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static Future<void> rcChargeAmount() async {
    //行番号：4030-4063
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcChargeAmount() rxMemRead error\n");
      return;
    }
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    KopttranBuff koptTran = KopttranBuff();
    KopttranBuff koptTran2 = KopttranBuff();
    RcCnctLists rcCnctLists = RcCnctLists();
    RcRecogLists rcRecogLists = RcRecogLists();
    RegsMem regsMem = RegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    int errNo;
    String log = "";
    int catRegOpe;
    int catVoidOpe;
    int vescaCnct;
    int num;
    int edyChkFlag;
    int vescaKoptChk;

    acrErrNo = OK;
    printErr = OK;
    updateErr = OK;
    prnendCnt = 0;
    // TODO:10116 コンパイルスイッチ(STATION_PRINTER)
    // TODO:10117 コンパイルスイッチ(TW_2S_PRINTER)
    // STATION_PRINTER、TW_2S_PRINTERが0で定義されていたので、この部分はコメントアウトしておく。
    // #if (STATION_PRINTER || TW_2S_PRINTER)
    //   stprend_cnt = 0;
    // #endif
    popWarn = 0;
    errNo = OK;
    vescaKoptChk = 0;
    //  #if DEBIT_CREDIT
    catRegOpe = 0;
    catVoidOpe = 0;
    if (RcSysChk.rcsyschkVescaSystem()) {
      vescaCnct = 1;
    } else {
      vescaCnct = 0;
    }
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);

    //行番号：4065-4229
    if ((koptTran.crdtEnbleFlg != 0) && (vescaCnct == 0)) {
      switch (koptTran.crdtTyp) {
        case 0:
        /* クレジット */
        case 1:
        /* デビット   */
        case 4:
        /* Smartplus  */
        //#if !CN_NSC
        case 5:
        /* iD         */
        //#endif
        case 9:
        /* QUICPay    */
        case 10:
        /* PiTaPa     */
        case 17:
          /* 銀聯       */
          catRegOpe = 1;
          break;
        case 2:
          /* Edy        */
          if ((await CmCksys.cmCctConnectSystem() != 0) &&
              (await CmCksys.cmCctEmoneySystem() != 0) &&
              ((RcSysChk.rcChkJETBProcess()) ||
                  (RcSysChk.rcChkJETAStandardProcess()) ||
                  (RcSysChk.rcChkINFOXProcess())) &&
              (!(await RcSysChk.rcChkEdySystem())) &&
              (!(RcSysChk.rcChkMultiEdySystem() != 0)) &&
              (!(await RcSysChk.rcChkEdyNoMbrSystem()))) {
            catRegOpe = 1;
          }
          break;
        case 6:
          /* ﾌﾟﾘﾍﾟｰﾄﾞ */
          if ((await CmCksys.cmYumecaSystem() != 0) &&
              (RcSysChk.rcChkYtrmProcess())) {
            catRegOpe = 1;
          }
          break;
        case 7:
          /* 交通系     */
          if (RcSysChk.rcChkSuicaCATSystem() || (await RcSysChk.rcChkSuicaSystem())) {
            catRegOpe = 1;
          } else {
            if (await CmCksys.cmCctEmoneySystem() != 0) {
              if ((RcSysChk.rcChkJETBProcess()) ||
                  (RcSysChk.rcChkINFOXProcess()) ||
                  (RcSysChk.rcsyschkShopcraidProcess()) ||
                  (RcSysChk.rcChkCATS701Process()) ||
                  (RcSysChk.rcChkJETAStandardProcess())) {
                catRegOpe = 1;
              } else {
                if (rcCnctLists.cnctGcatCnct != 0) {
                  if (await CmCksys.cmYamatoSystem() != 0) {
                    /* ヤマト電子マネー端末を利用しない場合、 交通系はエラーとする */
                    sprintf(log,
                        "rcChargeAmount: kopttran.crdtTyp[${koptTran.crdtTyp}]\n");
                    TprLog()
                        .logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, log);
                    await RcExt.rcErr('rcChargeAmount', DlgConfirmMsgKind.MSG_TEXT11.dlgId);
                    await RcIfEvent.rxChkTimerAdd();
                    return;
                  }
                }
              }
            }
          }
          break;
        case 21:
        /* WAON       */
        case 22:
          /* nanaco     */
          if ((await CmCksys.cmCctConnectSystem() != 0) &&
              (await CmCksys.cmCctEmoneySystem() != 0) &&
              ((RcSysChk.rcChkJETBProcess()) ||
                  (RcSysChk.rcChkINFOXProcess()))) {
            /* CCT基本連動仕様を優先 */
            catRegOpe = 1;
          } else if (!(await CmCksys.cmYamatoSystem() != 0)) {
            /* CCT端末でのWAON決済・nanaco決済は、まだ案件が無いので、ヤマト電子マネー端末を優先にしておく */
            catRegOpe = 1;
          }
          break;
        case 24:
          /* 端末で選択   */
          if (!(await CmCksys.cmJmupsSystem() != 0)) {
            //”端末で選択”は、J-Mupsを優先
            if ((await CmCksys.cmTecInfoxJetSSystem() != 0) ||
                ((await CmCksys.cmCctConnectSystem() != 0) &&
                    (RcSysChk
                        .rcChkJETBProcess())) // JET-B端末のクレ銀3面対応のため、JET-B設定の場合はOKとする
                ||
                (RcSysChk.rcsyschkPctConnectSystem())) {
              catRegOpe = 1;
            }
          }
          break;
        case 28:
          /* CCTポイント決済 */
          break;
        case 31:
          /* コード支払い */
          if ((await CmCksys.cmCctConnectSystem() != 0) &&
              (await CmCksys.cmCctCodepaySystem() != 0) &&
              (RcSysChk.rcChkJETBProcess()) &&
              (!await RcSysChk.rcChkOnepaySystem())) {
            catRegOpe = 1;
          } else if (rcRecogLists.recogSteraTerminalSystem != 0) {
            if ((RcSysChk.rcChkINFOXProcess()) &&
                (await CmCksys.cmCctConnectSystem() != 0) &&
                (!await RcSysChk.rcChkOnepaySystem())) {
              catRegOpe = 1;
            }
          }
          break;
        case 34:
          /* JPQR決済 */
          if (RcSysChk.rcsyschkPctConnectSystem()) {
            catRegOpe = 1;
          }
          break;
        case 36:
          /* NFC Payment */
          if ((await CmCksys.cmCctConnectSystem() != 0) &&
              (await CmCksys.cmCctEmoneySystem() != 0) &&
              ((rcCnctLists.cnctGcatCnct == 20) ||
                  (rcCnctLists.cnctGcatCnct == 24))) {
            /* CAFIS Arch */
            catRegOpe = 1;
          } else if (RcSysChk.rcChkJETBProcess()) {
            /* JET-B */
            catRegOpe = 1;
          } else {
            if (rcCnctLists.cnctGcatCnct == 4) {
              catRegOpe = 1;
            }
          }
          break;
        case 38:
          /* クレ銀3面  */
          if (rcRecogLists.recogSteraTerminalSystem != 0) {
            catRegOpe = 1;
          }
          break;
        case 44:
          /* ギフトカード  */
          if (RcSysChk.rcsyschkPctConnectSystem()) {
            catRegOpe = 1;
          }
          break;
        default:
          break;
      }
      //行番号：4230-4254
    } else {
      if (vescaCnct == 1) {
        // ベスカ接続仕様
        if (koptTran.crdtEnbleFlg != 0) {
          switch (koptTran.crdtTyp) {
            case 0: // クレジット
            case 2: // Edy
            //#if !CN_NSC
            case 5: // iD
            //#endif
            case 7: // 交通系
            case 9: // QUICPay
            case 21: // WAON
            case 22: // nanaco
              catRegOpe = 1;
              break;
            default:
              break;
          }
        }
      }
    }

    //行番号：4256-4304
    //#if SMARTPLUS
    if ((RcSysChk.rcChkSmartplusSystem()) &&
        ((koptTran.crdtTyp == 0) || (koptTran.crdtTyp == 4))) {
      catVoidOpe = 1;
    }
    //#endif

    if ((RcSysChk.rcChkJETAStandardProcess()) /* JET-A接続 */
        &&
        ((koptTran.crdtTyp == 0) /* クレジット */
            ||
            (koptTran.crdtTyp == 5) /* iD */
            ||
            (koptTran.crdtTyp == 9) /* QUICPay */
            ||
            ((koptTran.crdtTyp == 7) &&
                (await CmCksys.cmCctEmoneySystem() !=
                    0)))) /* 交通系IC（Suica）でかつ、CCT電子マネー決済仕様 */ {
      catVoidOpe = 1;
    }

    if ((RcSysChk.rcChkINFOXProcess()) &&
        (rcRecogLists.recogYomocasystem != 0) &&
        ((koptTran.crdtTyp == 0) || (koptTran.crdtTyp == 5))) {
      catVoidOpe = 1;
    }

    if (((RcSysChk.rcChkSuicaCATSystem()) || (await RcSysChk.rcChkSuicaSystem())) &&
        (koptTran.crdtTyp == 7)) {
      catVoidOpe = 1;
      if ((RcSysChk.rcChkCATS701Process()) ||
          (RcSysChk.rcChkINFOXProcess()) ||
          (RcSysChk.rcsyschkShopcraidProcess())) {
        catVoidOpe = 0; /* JET-B以外は、交通系ICの訂正連動をさせない */
      }
    }

    if (RcSysChk.rcChkFWTProcess()) {
      if (RcSysChk.rcTROpeModeChk()) {
        catRegOpe = 0;
      }
    }

    if ((await CmCksys.cmYumecaSystem() != 0) &&
        (RcSysChk.rcChkYtrmProcess()) &&
        ((koptTran.crdtTyp == 0) || (koptTran.crdtTyp == 6))) {
      catVoidOpe = 1;
    }

    if ((await CmCksys.cmZHQSystem() != 0) &&
        (RcSysChk.rcChkINFOXProcess()) &&
        (catRegOpe == 1)) {
      catVoidOpe = 1;
    }

    //行番号：4306-4393
    if ((RcSysChk.rcChkGCATConnect()) ||
        (RcSysChk.rcChkSGTConnect()) ||
        (RcSysChk.rcChkJETAProcess()) ||
        (RcSysChk.rcChkJETAStandardProcess()) ||
        (RcSysChk.rcChkJETBProcess()) ||
        (RcSysChk.rcChkINFOXProcess())
        //#if SMARTPLUS
        ||
        (RcSysChk.rcChkSmartplusSystem())
        //#endif
        ||
        (RcSysChk.rcChkCATS701Process()) ||
        (RcSysChk.rcChkCT3100Process()) ||
        (RcSysChk.rcChkIP3100Process()) ||
        (RcSysChk.rcChkFWTProcess()) ||
        (RcSysChk.rcsyschkShopcraidProcess()) ||
        (await RcSysChk.rcsyschkGMOVEGASystem()) ||
        (RcSysChk.rcChkYtrmProcess()) ||
        (RcSysChk.rcsyschkPctConnectSystem())) {
      if ((RcSysChk.rcSROpeModeChk()) &&
          (RcSysChk.rcCheckKyIntIn(true)) &&
          (catRegOpe == 1)) {
        // アークス様仕様ではRALSE_CREDITが有効化する。
        //#if RALSE_CREDIT
        if ((!RcSysChk.rcVDOpeModeChk()) ||
            ((RcSysChk.rcVDOpeModeChk()) &&
                (RcSysChk.rcChkRalseCardSystem()))) {
          //#else
          //       if((!RcSysChk.rcVDOpeModeChk())
          //           || ((RcSysChk.rcVDOpeModeChk()) && (catVoidOpe == 1))) {
          //#endif
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // DEPARTMENT_STOREが0で定義されていたので、この部分はコメントアウトしておく。
          //#if DEPARTMENT_STORE
          //         if(! rc_Check_Marine5_Simizuya()) {
          //           Ky_St_S4(CMEM->key_stat[KY_STL]);
          //         }
          //#else
          // アークス様仕様ではRALSE_CREDITが有効化するが、否定のためコメントアウトする
          //#if !RALSE_CREDIT
          //         if(koptTran.frcStlkyFlg == 1){ /* 市場要望：小計キー強制をチェックして欲しい */
          //           if(!RcFncChk.rcCheckESVoidIMode()){
          //             if(!RcFncChk.rcCheckStlMode()){
          //               sprintf(log, "rcChargeAmount: koptTran.frcStlkyFlg[${koptTran.frcStlkyFlg}]\n");
          //               TprLog().logAdd(
          //                   Tpraid.TPRAID_CHK, LogLevelDefine.error, log);
          //               await RcEwdsp.rcErr2(
          //                   'rcChargeAmount', (DlgConfirmMsgKind.MSG_SUBTTLFCE) as int);
          //               await RcIfEvent.rxChkTimerAdd();
          //               return;
          //             }
          //           }
          //           RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_STL as int);
          //         }else{
          //           RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_STL as int);
          //         }
          //#endif
          if (await RcFncChk.rcChkAcrAcbAfterRegCinStart() &&
              await RcFncChk.rcCheckItmMode() &&
              (cMem.acbData.totalPrice != 0)) {
            await RcExt.rcErr('rcChargeAmount',
                DlgConfirmMsgKind.MSG_SUBTTLFCE_CHANGER_CANCEL.dlgId);
            await RcIfEvent.rxChkTimerAdd();
            return;
          }
          RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_STL.keyId); /* Set Calc. SubTotal */
          //#endif
          lEntry = Bcdtol.cmBcdToL(cMem.ent.entry);
          // lEntryをcmLtobcdで文字列に変換
          String bcd =  Ltobcd.cmLtobcd(lEntry, cMem.ent.entry.length);
          cMem.ent.tencnt = Liblary.cmChkZero0(bcd, cMem.ent.entry.length);

          int digit = koptTran.digit;
          if ((cMem.working.dataReg.kMul0 == 0) &&
              (((lEntry == 0) && (koptTran.chkAmt == 0)) ||
                  ((lEntry != 0) && (cMem.ent.tencnt <= digit)))) {
            if (!await RcFncChk.rcCheckESVoidIMode()) {
              if (!await RcFncChk.rcCheckStlMode()) {
                // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
                // DEPARTMENT_STOREが0で定義されていたので、この部分はコメントアウトしておく。
                //#if DEPARTMENT_STORE
                //               if(! rc_Check_Marine5_Simizuya()) {
                //#if SELF_GATE && SMARTPLUS
                //                 if( !((rcSG_Chk_SelfGate_System()) && (rcChk_Smartplus_System()) &&
                //                       ((KOPTTRAN.crdt_typ ==  4) || (KOPTTRAN.crdt_typ ==  7)) && (rcChk_CrdtReceipt(0) != TRUE)) )
                //#endif
                //                   rcStl_Display(FALSE);
                //  }
                //#else
                //#if SELF_GATE && SMARTPLUS
                if (!((await RcSysChk.rcSGChkSelfGateSystem()) &&
                    (RcSysChk.rcChkSmartplusSystem()) &&
                    ((koptTran.crdtTyp == 4) || ((koptTran.crdtTyp == 7))) &&
                    (await RcMbrCom.rcChkCrdtReceipt(0) != true))) {
                  //#endif
                  RckyStl.rcStlDisplay(false);
                  //#endif
                }
              }
            }
          }
          //行番号：4395-4449
          cMem.ent.errNo = 0;
          if ((koptTran.crdtEnbleFlg != 0) &&
              (koptTran.crdtTyp == 7) &&
              (! (await RcSysChk.rcChkSuicaSystem()))) {
            if ((!RcSysChk.rcChkSuicaCATSystem()) &&
                (!RcSysChk.rcChkJETAStandardProcess())) {
              /* JET-S端末Aタイプ接続でない */
              cMem.ent.errNo = DlgConfirmMsgKind
                  .MSG_TEXT5.dlgId; /* 承認キー未設定（Ｓｕｉｃａ決済[ＣＡＴ接続]） */
            } else if (RxLogCalc.rxCalcStlTaxAmt(regsMem) > 99999) {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
            } else if ((RxLogCalc.rxCalcStlTaxAmt(regsMem) > lEntry) &&
                (RcFncChk.rcChkTenOn())) {
              if (!RcSysChk.rcChkFWTProcess()) {
                if (RcSysChk.rcsyschkShopcraidProcess()) {
                  if (await RcMbrCom.rcChkSuicaReceipt() != -1) {
                    cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
                  } else {
                    cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOLACKERR.dlgId;
                  }
                } else {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOLACKERR.dlgId;
                }
              } else {
                if (await RcMbrCom.rcChkSuicaReceipt() != -1) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_ACTIONERR.dlgId;
                }
              }
            } else if ((await RcMbrCom.rcChkSuicaReceipt() != -1) &&
                (!RcSysChk.rcChkJETAStandardProcess())) {
              /* JET-S端末Aタイプ接続でない */
              if (RcSysChk.rcsyschkShopcraidProcess()) {
                cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
              } else {
                cMem.ent.errNo = DlgConfirmMsgKind.MSG_ACTIONERR.dlgId;
              }
            } else if (RcSysChk.rcChkCATS701Process()) {
              if (await RcMbrCom.rcChkCrdtReceipt(0)) {
                cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
              }
            }
          }
          //行番号：4450-4603
          //#if SMARTPLUS
          if ((RcSysChk.rcChkSmartplusSystem()) &&
              ((RxLogCalc.rxCalcStlTaxAmt(regsMem) <= 1) || (lEntry == 1))) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT21.dlgId;
          }
          //#endif
          if ((koptTran.crdtEnbleFlg != 0) &&
              (koptTran.crdtTyp == 2) &&
              (await CmCksys.cmCctEmoneySystem() != 0) &&
              (await CmCksys.cmCctConnectSystem() != 0) &&
              (RcSysChk.rcChkJETBProcess()) &&
              (RxLogCalc.rxCalcStlTaxAmt(regsMem) > 99999)) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT21.dlgId;
          }
          if ((koptTran.crdtEnbleFlg != 0) &&
              ((koptTran.crdtTyp == 2) ||
                  (koptTran.crdtTyp == 7) ||
                  (koptTran.crdtTyp == 21)) &&
              (await CmCksys.cmCctEmoneySystem() != 0) &&
              (await CmCksys.cmCctConnectSystem() != 0) &&
              (regsMem.tTtllog.t100001Sts.sptendCnt > 8)) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
          }
          if (!(cMem.ent.errNo != 0)) {
            cMem.ent.errNo = await RcAtct.rcAtctProcError2(1);
          }

          int kopDigit = koptTran.digit;
          if (!(cMem.ent.errNo != 0)) {
            // アークス様仕様ではRALSE_CREDITが有効化する。
            //#if RALSE_CREDIT
            if (((RxLogCalc.rxCalcStlTaxAmt(regsMem) > 0) ||
                    ((!RcSysChk.rcVDOpeModeChk()) &&
                        (RcSysChk.rcChkRalseCardSystem()) &&
                        (regsMem.tTtllog.t100003.refundAmt != 0) &&
                        (RxLogCalc.rxCalcStlTaxAmt(regsMem) < 0))) &&
                (regsMem.tTtllog.t100700.mbrInput !=
                    MbrInputType.mbrprcKeyInput.index) &&
                (((RcSysChk.rcChkRalseCardSystem()) &&
                        (RxLogCalc.rxCalcStlTaxAmt(regsMem) >= lEntry)) ||
                    (RxLogCalc.rxCalcStlTaxAmt(regsMem) == lEntry) ||
                    (lEntry == 0))) {
              //#else
              //             if((rxCalc_Stl_Tax_Amt(MEM) > 0) && ((MEM->tTtllog.t100700.mbr_input != MBRPRC_KEY_INPUT) || (cm_nimoca_point_system()) || (rcChk_WS_System())) && ((rxCalc_Stl_Tax_Amt(MEM) >= lEntry) || (lEntry == 0)))
              //#endif
              if ((RcSysChk.rcChkJETAStandardProcess()) &&
                  ((koptTran.crdtTyp == 0) ||
                      (koptTran.crdtTyp == 2) ||
                      (koptTran.crdtTyp == 5) ||
                      (koptTran.crdtTyp == 9) ||
                      (koptTran.crdtTyp == 7) ||
                      (koptTran.crdtTyp == 22))) {
                if (RcMbrCom.rcChkCatCrdtReceipt(0)) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
                } else {
                  RcGcat.rcGCatProc();
                  return;
                }
              } else if ((RcSysChk.rcChkINFOXProcess()) &&
                  (RcSysChk.rcsyschkInfoxCreditdetailSendSystem()) &&
                  (koptTran.crdtTyp == 0) &&
                  (RcMbrCom.rcChkCatCrdtReceipt(0))) {
                cMem.ent.errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
              } else if (((RcSysChk.rcChkINFOXProcess()) &&
                      (rcRecogLists.recogYomocasystem != 0)) &&
                  ((koptTran.crdtTyp == 0) || (koptTran.crdtTyp == 5))) {
                if (RcMbrCom.rcChkCatCrdtReceipt(0)) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
                } else {
                  RcGcat.rcGCatProc();
                  return;
                }
              } else if (RcSysChk.rcChkCATS701Process()) {
                if (RcMbrCom.rcChkCatCrdtReceipt(0)) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
                } else {
                  RcGcat.rcGCatProc();
                  return;
                }
              } else if (RcSysChk.rcChkYtrmProcess()) {
                if (RcMbrCom.rcChkCatCrdtReceipt(0)) {
                  cMem.ent.errNo =
                      DlgConfirmMsgKind.MSG_JMUPS_ONETIME_ONLY.dlgId;
                } else {
                  RcGcat.rcGCatProc();
                  return;
                }
              } else if ((RcSysChk.rcsyschkShopcraidProcess()) ||
                  (await RcSysChk.rcsyschkGMOVEGASystem())) {
                if (RcMbrCom.rcChkCatCrdtReceipt(0)) {
                  cMem.ent.errNo =
                      DlgConfirmMsgKind.MSG_JMUPS_ONETIME_ONLY.dlgId;
                } else {
                  RcGcat.rcGCatProc();
                  return;
                }
              } else if (((RcSysChk.rcChkINFOXProcess()) &&
                      (await CmCksys.cmZHQSystem() != 0)) &&
                  (koptTran.crdtEnbleFlg != 0) &&
                  ((koptTran.crdtTyp == 0) ||
                      (koptTran.crdtTyp == 2) ||
                      (koptTran.crdtTyp == 5) ||
                      (koptTran.crdtTyp == 7) ||
                      (koptTran.crdtTyp == 9) ||
                      (koptTran.crdtTyp == 17) ||
                      (koptTran.crdtTyp == 21) ||
                      (koptTran.crdtTyp == 22))) {
                if (RcMbrCom.rcChkCatCrdtReceipt(0)) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_MSTCCT_ALREADY.dlgId;
                } else if ((RcSysChk.rcVDOpeModeChk()) &&
                    (koptTran.crdtTyp != 0)) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_MSTCCT_CANTVOID.dlgId;
                } else if (!((cMem.working.dataReg.kMul0 == 0) &&
                    (RxLogCalc.rxCalcStlTaxAmt(regsMem) > 0) &&
                    ((RxLogCalc.rxCalcStlTaxAmt(regsMem) == lEntry) ||
                        (lEntry == 0)))) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
                } else {
                  RcGcat.rcGCatProc();
                  return;
                }
              } else if ((RcSysChk.rcChkINFOXProcess()) &&
                  (rcRecogLists.recogSteraTerminalSystem != 0)) {
                if (RcMbrCom.rcChkCatCrdtReceipt(0)) {
                  cMem.ent.errNo =
                      DlgConfirmMsgKind.MSG_JMUPS_ONETIME_ONLY.dlgId;
                } else if ((RcSysChk.rcsyschkRpointSystem() != 0) &&
                    (Rxmbrcom.rxmbrcomChkRpointRead(regsMem)) &&
                    ((RcSysChk.rcRGOpeModeChk()) ||
                        (RcSysChk.rcTROpeModeChk())) &&
                    (!(RckyRfdopr.rcRfdOprCheckRcptVoidMode())) &&
                    (regsMem.tTtllog.t100790.offlineFlg == 0) &&
                    (regsMem.tTtllog.t100790Sts.commEndFlg == 0) &&
                    (regsMem.tTtllog.t100790.usePoint > 0)) {
                  // 呼出元決済処理をセット
                  atSing.rpointUpdPayKind = 9;

                  // iD読込待ち画面表示前に、楽天ポイント利用通信を行う
                  RcLastcomm.rcLastCommAfterInquMainProc(
                      RX_LASTCOMM_PAYKIND.LCOM_RPOINT, 1);
                  return;
                } else {
                  RcGcat.rcGCatProc();
                  return;
                }
                //行番号：4604-4626
                //#if SMARTPLUS
              } else if ((RcSysChk.rcChkSmartplusSystem()) &&
                  ((koptTran.crdtTyp == 0) || (koptTran.crdtTyp == 4))) {
                if (await RcMbrCom.rcChkCrdtReceipt(0)) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
                } else {
                  RcSmartPlus.rcSmartplus_Inq_Proc();
                  return;
                }
              } else if (await RcSysChk.rcChkFSCaAutoPoint()) {
                if (await RcMbrCom.rcChkCrdtReceipt(0)) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
                } else {
                  RcGcat.rcGCatProc();
                  return;
                }
              } else {
                //#endif
                //行番号：4627-4656
                //#if RALSE_CREDIT
                //#if ARCS_MBR
                if (((await RcMbrCom.rcChkCrdtReceipt(0)) ||
                        (RcMbrCom.rcChkCha9Receipt() != -1) ||
                        (await RcMbrCom.rcChkIDReceipt() != -1) ||
                        (await RcMbrCom.rcChkPrepaidReceipt() != -1) ||
                        (await RcMbrCom.rcChkQUICPayReceipt() != -1)) &&
                    ((!await RcFncChk.rcCheckESVoidIMode()) &&
                        (!await RcFncChk.rcCheckESVoidSMode()))) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
                } else if ((await CmCksys.cmQUICPaySystem() != 0) &&
                    (koptTran.crdtTyp == 9)) {
                  if (RcSysChk.rcVDOpeModeChk()) {
                    cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
                  } else {
                    if (regsMem.tTtllog.t100003.refundAmt != 0) {
                      cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
                    } else {
                      RcGcat.rcGCatProc();
                      return;
                    }
                  }
                }
                //#else
                //                       if((rcChk_CrdtReceipt(0) == TRUE) && ((!rcCheck_ESVoidI_Mode()) && (!rcCheck_ESVoidS_Mode()))) {
                //                         CMEM->ent.err_no = MSG_CREDT_ONCE;
                //                       }
                //#endif
                else if ((!RcSysChk.rcChkRalseCardSystem()) ||
                    ((RcSysChk.rcChkRalseCardSystem()) &&
                        (regsMem.tTtllog.t100700Sts.mbrTyp != 0) &&
                        ((regsMem.tmpbuf.rcarddata.typ == Mcd.MCD_RLSCRDT) ||
                            (regsMem.tmpbuf.rcarddata.typ ==
                                Mcd.MCD_RLSOTHER)))) {
                  //#endif
                  //行番号：4657-4694
                  if ((await RcSysChk.rcChkSuicaSystem()) &&
                      (koptTran.crdtTyp == 7)) {
                    await rcChargeAmount1();
                    return;
                  } else if (RcSysChk.rcsyschkPctConnectSystem()) {
                    if (RcFncChk.rcCheckPCTConnect()) {
                      RcGcat.rcGCatProc();
                      return;
                    } else {
                      await rcChargeAmount1();
                      return;
                    }
                  } else {
                    if ((await rckyChaCctStlAmtOnlyChk(1)) &&
                        (RcMbrCom.rcChkCatCrdtReceipt(0))) {
                      cMem.ent.errNo =
                          DlgConfirmMsgKind.MSG_MSTCCT_ALREADY.dlgId;
                    } else if ((await rckyChaCctStlAmtOnlyChk(0)) &&
                        (!((cMem.working.dataReg.kMul0 == 0) &&
                            (RxLogCalc.rxCalcStlTaxAmt(regsMem) > 0) &&
                            ((RxLogCalc.rxCalcStlTaxAmt(regsMem) == lEntry) ||
                                (lEntry == 0))))) {
                      cMem.ent.errNo =
                          DlgConfirmMsgKind.MSG_CCT_STLAMT_ONLY.dlgId;
                    } else {
                      RcGcat.rcGCatProc();
                      return;
                    }
                  }
                  //行番号：4696-4756
                  //#if RALSE_CREDIT
                } else {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_NSC_CR_READ.dlgId;
                }
                //#endif
                //#if SMARTPLUS
              }
              //#endif
            } else if ((regsMem.tTtllog.t100700.mbrInput ==
                    MbrInputType.mbrKeyInput.index) ||
                ((RcSysChk.rcChkMbrprcSystem()) &&
                    (regsMem.tTtllog.t100700.mbrInput ==
                        MbrInputType.nonInput.index))) {
              //#if RALSE_MBRSYSTEM
              if (RcSysChk.rcChkRalseCardSystem()) {
                if (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSCRDT, regsMem)) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CALL_RLSMBR.dlgId;
                } else {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CALL_RLSSTAFF.dlgId;
                }
              } else {
                //#endif
                if ((!(await CmCksys.cmNimocaPointSystem() != 0)) &&
                    (!RcSysChk.rcChkWSSystem())) {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_CALL_MBR.dlgId;
                }
                //#if RALSE_MBRSYSTEM
              }
              //#endif
            } else if (RxLogCalc.rxCalcStlTaxAmt(regsMem) < 0) {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOMINUSERR.dlgId;
            } else if (lEntry < RxLogCalc.rxCalcStlTaxAmt(regsMem)) {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOLACKERR.dlgId;
            } else if (lEntry > RxLogCalc.rxCalcStlTaxAmt(regsMem)) {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_NOOVERKEEP.dlgId;
            } else {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
            }
          } else {
            if (cMem.ent.tencnt > kopDigit) {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
            }
            //#if 0
            //   /* セット済みの err_no が、 全てMSG_OPEERR へ上書きされてしまうのでコメントアウト */
            //           else {
            //           CMEM->ent.err_no = MSG_OPEERR;
            //           }
            //#endif
          }
          if (cMem.ent.errNo != 0) {
            await RcExt.rcErr('rcChargeAmount', cMem.ent.errNo);
            await RcIfEvent.rxChkTimerAdd();
            return;
          }
        }
      }

      //行番号：4757-4795
      if (RcSysChk.rcsyschkPctConnectSystem()) {
        if (koptTran.crdtTyp == 43) {
          // WAONPOINT
          if ((RcFncChk.rcCheckPCTConnect()) &&
              (await RcAcracb.rcCheckAcrAcbON(0) != 0)) {
            // 釣銭機接続している場合は通信実施
            RcGcat.rcGCatProc();
            return;
          }
        } else if (koptTran.crdtTyp == 45) {
          // ｲｵｸﾚお買い物券
          if (RcFncChk.rcCheckPCTConnect()) {
            RcGcat.rcGCatProc();
            return;
          }
        } else if (koptTran.crdtTyp == 0) {
          if ((cMem.stat.fncCode == FuncKey.KY_CHA1.keyId) ||
              (cMem.stat.fncCode == FuncKey.KY_CHA2.keyId) ||
              (cMem.stat.fncCode == FuncKey.KY_CHA3.keyId) ||
              (cMem.stat.fncCode == FuncKey.KY_CHA4.keyId) ||
              (cMem.stat.fncCode == FuncKey.KY_CHA5.keyId)) {
            if ((RcFncChk.rcCheckPCTConnect()) &&
                (await RcAcracb.rcCheckAcrAcbON(0) != 0)) {
              RcGcat.rcGCatProc();
              return;
            }
          }
        }
      }
    }
    //#endif ←　当関数冒頭の#if DEBIT_CREDITと対

    //行番号：4797-4849
    //#if ARCS_MBR
    if (cMem.stat.fncCode == FuncKey.KY_CHA9.keyId) {
      if (((await RcMbrCom.rcChkCrdtReceipt(0)) ||
              (RcMbrCom.rcChkCha9Receipt() != -1) ||
              (await RcMbrCom.rcChkIDReceipt() != -1) ||
              (await RcMbrCom.rcChkPrepaidReceipt() != -1) ||
              (await RcMbrCom.rcChkQUICPayReceipt() != -1)) &&
          ((!await RcFncChk.rcCheckESVoidIMode()) &&
              (!await RcFncChk.rcCheckESVoidSMode()))) {
        await RcExt.rcErr('rcChargeAmount', DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId);
        await RcIfEvent.rxChkTimerAdd();
        return;
      }
    }
    //#endif

    if (await CmCksys.cmCrdtSystem() != 0) {
      /* クレジット仕様    */
      if (RcSysChk.rcCheckCrdtStat()) {
        /* クレ宣言入力中？  */
        RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_STL.keyId); /* Set Calc. SubTotal */
        // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
        // MC_SYSTEMが0で定義されていたので、この部分はコメントアウトしておく。
        //#if MC_SYSTEM
        //       if(rcChk_Mc_System()) {
        //         mcReDsp_Bon_Mth();
        //         rcReMov_ScrMode();
        //         rcCrdt_ReDsp();
        //       }
        //       else
        //#endif
        if ((cMem.working.crdtReg.stat & 0x0020) != 0) {
          /* 同会計キー待ち？  */
          if (!RcFncChk.rcQCCheckCrdtUseMode()) {
            RcSet.rcReMovScrMode();
            RcCrdtDsp.rcCrdtReDsp();
          }
          //#if !MC_SYSTEM
          else if (await rcChkOffCrdtAllow()) {
            await RcCrdtFnc.rcCrdtCancel();
          }
          //#endif
          else {
            cMem.working.crdtReg.crdtKey = cMem.stat.fncCode;
            // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
            // DEPARTMENT_STOREが0で定義されていたので、この部分はコメントアウトしておく。
            //if DEPARTMENT_STORE
            //           if((rcChk_Crdt_User() == NAKAGO_CRDT) && ((CMEM->working.crdt_reg.multi_flg & 0x08) || (CMEM->working.crdt_reg.multi_flg & 0x20) || (rc_Check_Marine5_Simizuya()))) {
            //             rcCardCrew_NotInq_Prg();
            //             rcClearKy_Item();
            //             rcClearEntry();
            //             rcClearData_Reg();
            //             Ky_St_S4(CMEM->key_stat[KY_CRDTIN]);
            //             CMEM->stat.FncCode = CMEM->working.crdt_reg.crdtkey;
            //             CMEM->working.crdt_reg.step = INPUT_END;
            //             rcReMov_ScrMode();
            //             rcCrdt_ReDsp();
            //           }
            //            else {
            //  #endif
            //行番号：4850-4911
            if (await RcSysChk.rcCheckEntryCrdtMode()) {
              RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
              RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
              cMem.working.crdtReg.step = KyCrdtInStep.INPUT_1ST.cd;
              RcSet.rcReMovScrMode();
              RcCrdtDsp.rcCrdtReDsp();
            } else {
              if (CompileFlag.ARCS_MBR) {
                if ((await CmMbrSys.cmNewARCSSystem() != 0) &&
                    (await RcCrdtFnc.rcSignChkEveryOneSystem(
                        await RcCrdtFnc.rcGetCrdtPayAmount(), 10, 1)) &&
                    (pCom.dbTrm.crdtSignlessMaxLimit > 0)) {
                  rcchaCrdtSignDialog();
                  return;
                }
              }
              // TODO:10121 QUICPay、iD 202404実装対象外
              // 楽天ポイント取引、かつ、楽天ポイント利用がある場合、
              // 決済通信より先に、ポイント登録通信を行う
              // if((rcsyschk_Rpoint_System())
              //     && (rxmbrcom_ChkRpointRead(MEM))
              //     && ((rcRG_OpeModeChk()) || (rcTR_OpeModeChk()))
              //     && (!(rcRfdOprCheckRcptVoidMode()))
              //     && (MEM->tTtllog.t100790.offline_flg == 0)
              //     && (MEM->tTtllog.t100790Sts.comm_end_flg == 0)
              //     && (MEM->tTtllog.t100790.use_point > 0))
              // {
              //   // 呼出元決済処理をセット
              //   AT_SING->rpoint_upd_pay_kind = 1;
              //
              //   rcLastComm_AfterInquMainProc(LCOM_RPOINT, 1);
              //   return;
              //   }
              errNo = RcCrdtFnc.rcCrdtInquProg(); /* 与信問い合わせ */
              if (errNo != OK) {
                RckyClr.rcClearPopDisplay();
                RcExt.rcClearErrStat('rcChargeAmount');
                cMem.ent.errNo = errNo;
                await RcExt.rcErr('rcChargeAmount', cMem.ent.errNo);
                await RcIfEvent.rxChkTimerAdd(); /* キー入力許可   */
              } else {
                if (await RcSysChk.rcSysChkHappySmile()) {
                  // TODO:10166 クレジット 20241004実装対象外
                  // rcQC_Crdt_Btn_Disable();
                }
              }
              return;
            }
          }
        }
      }
    }
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(rcChk_Edy_KeyOpt()) {
    //   if(rcChk_EdyNoMbr_System() && MEM->tTtllog.t100700.mbr_input == NON_INPUT) {
    //     rcCha_Conf_Edy();
    //   }
    //   else {
    //     rcChaEdy();
    //   }
    //   return;
    // }
    //
    // #if MC_SYSTEM
    // if(rcChk_Mc_System()) {
    // if(rcChk_Mc_KeyOpt()) {
    // if(AT_SING->mc_tbl.k_amount == KY_MCRDT) {
    // rcPana_CrdtInq_Proc(eTendType);
    // return;
    // }
    // }
    // }
    // #endif
    // if(rcChk_SPVT_KeyOpt()) {
    // if(! rcCheck_SPVT_Mode()) {
    // memset(&AT_SING->spvt_data, 0, sizeof(AT_SING->spvt_data));
    // AT_SING->spvt_data.Fnc_Code = CMEM->stat.FncCode;
    // rxTimerAdd();
    // if(rcVD_OpeModeChk())
    // rcSPVT_VoidDisp();
    // else
    // rcSPVT_MainProc();
    // }
    // return;
    // }
    //
    // if(rcChk_MultiEdy_KeyOpt())
    // {
    // if(! rcCheck_Edy_Mode())
    // {
    // // Edyカード読込待ち画面表示前に楽天ポイント通信を行うかチェック
    // if ((rcCheck_RPointPay_Before_MultiEdy(MEM->tTtllog.t100790.use_point))
    // && (rxmbrcom_ChkRpointRead(MEM))
    // && ((rcRG_OpeModeChk()) || (rcTR_OpeModeChk()))
    // && (!(rcRfdOprCheckRcptVoidMode()))
    // && (MEM->tTtllog.t100790.offline_flg == 0)
    // && (MEM->tTtllog.t100790Sts.comm_end_flg == 0)
    // && (MEM->tTtllog.t100790.use_point > 0))
    // {
    // sprintf(log,"%s : goto RPointUpdate\n", __FUNCTION__);
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    //
    // // 呼出元決済処理をセット
    // AT_SING->rpoint_upd_pay_kind = 5;
    //
    // // Edyカード読込待ち画面表示前に、楽天ポイント利用通信を行う
    // rcLastComm_AfterInquMainProc(LCOM_RPOINT, 1);
    //
    // return;
    // }
    // else
    // {
    // sprintf(log,"%s : goto MultiEdy MainProc\n", __FUNCTION__);
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    //
    // memset(&AT_SING->spvt_data, 0, sizeof(AT_SING->spvt_data));
    // AT_SING->spvt_data.Fnc_Code = CMEM->stat.FncCode;
    // rxTimerAdd();
    // rcMultiEdy_MainProc(CMEM->stat.FncCode);
    // }
    // }
    // return;
    // }

    if (await rcChkMultiQPKeyOpt()) {
      if (!(await RcFncChk.rcCheckQPMode())) {
        if ((RcFncChk.rcCheckRPointPayBeforeMultiQP(
                regsMem.tTtllog.t100790.usePoint)) &&
            (Rxmbrcom.rxmbrcomChkRpointRead(regsMem)) &&
            ((RcSysChk.rcRGOpeModeChk()) || (RcSysChk.rcTROpeModeChk())) &&
            (!(RckyRfdopr.rcRfdOprCheckRcptVoidMode())) &&
            (regsMem.tTtllog.t100790.offlineFlg == 0) &&
            (regsMem.tTtllog.t100790Sts.commEndFlg == 0) &&
            (regsMem.tTtllog.t100790.usePoint > 0)) {
          // TODO:10121 QUICPay、iD 202404実装対象外
          // sprintf(log,"%s : goto RPointUpdate\n", __FUNCTION__);
          // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
          //
          // // 呼出元決済処理をセット
          // AT_SING->rpoint_upd_pay_kind = 7;
          //
          // // QUICPAY読込待ち画面表示前に、楽天ポイント利用通信を行う
          // rcLastComm_AfterInquMainProc(LCOM_RPOINT, 1);
          //
          // return;
        } else {
          TprLog().logAdd(0, LogLevelDefine.normal,
              "rcChargeAmount() : goto MultiQP MainProc\n");
          atSing.spvtData.fncCode = cMem.stat.fncCode;
          RcIfEvent.rxTimerAdd();
          await RcQuicPayCom.rcMultiQPMainProc(cMem.stat.fncCode);
        }
      }
      return;
    }

    if (await rcChkMultiiDKeyOpt()) {
      if (!(await RcFncChk.rcCheckiDMode())) {
        if ((RcFncChk.rcCheckRPointPayBeforeMultiiD(
                regsMem.tTtllog.t100790.usePoint)) &&
            (Rxmbrcom.rxmbrcomChkRpointRead(regsMem)) &&
            ((RcSysChk.rcRGOpeModeChk()) || (RcSysChk.rcTROpeModeChk())) &&
            (!(RckyRfdopr.rcRfdOprCheckRcptVoidMode())) &&
            (regsMem.tTtllog.t100790.offlineFlg == 0) &&
            (regsMem.tTtllog.t100790Sts.commEndFlg == 0) &&
            (regsMem.tTtllog.t100790.usePoint > 0)) {
          // TODO:10121 QUICPay、iD 202404実装対象外
          // sprintf(log,"%s : goto RPointUpdate\n", __FUNCTION__);
          // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
          //
          // // 呼出元決済処理をセット
          // AT_SING->rpoint_upd_pay_kind = 8;
          //
          // // QUICPAY読込待ち画面表示前に、楽天ポイント利用通信を行う
          // rcLastComm_AfterInquMainProc(LCOM_RPOINT, 1);
          //
          // return;
        } else {
          TprLog().logAdd(0, LogLevelDefine.normal,
              "rcChargeAmount() : goto MultiiD MainProc\n");
          atSing.spvtData.fncCode = cMem.stat.fncCode;
          RcIfEvent.rxTimerAdd();
          await RcidCom.rcMultiiDMainProc(cMem.stat.fncCode);
        }
      }
      return;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行は5057-5881まで

    await rcChargeAmount1();
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1()
  static Future<void> rcChargeAmount1() async {
    int errNo;
    int acxRetryFlg = 0;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcChargeAmount1() rxMemRead error\n");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    AcMem cMem = SystemFunc.readAcMem();
    KopttranBuff koptTran = KopttranBuff();
    RegsMem regsMem = RegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    //#if 0 // JPQRの場合、会計キーの頭で小計自動を実行する必要がある
    //   kopttran_buff KOPTTRAN;
    //
    //   // RM-5900仕様で画面モードが小計画面以外の場合、先に小計キーを動作させる。
    //   if ( ( rcCheck_Itm_Mode ( ) )
    //   && ( C_BUF->vtcl_rm5900_regs_on_flg ) )
    //   {
    //   rcRead_kopttran( CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN) );
    //   if (KOPTTRAN.frc_stlky_flg == 0)    // 小計キーの使用を強制：しない
    //       {
    //   rc59_Ky_Change ( );
    //   rxChkTimerAdd ( );
    //   return;
    //   }
    //   }
    //#endif

    // プリカ支払を先に実施する
    if ((RcSysChk.rcsyschkRepicaPointSystem()) &&
        (regsMem.tmpbuf.workInType == 1) &&
        (await RcFncChk.rcChkPrecaPointUseKey())) {
      if ((cMem.stat.fncCode == await RcFncChk.rcGetPrecaPointFncCode()) &&
          (RcqrCom.qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_READ.index) &&
          (atSing.entryRepicaPntInquFlag == 0) &&
          (!(await RcCrdtFnc.rcChkSptendRepicapntEnbleFlg() != 0))) {
        await RcIfEvent.rxChkTimerAdd();
        RcRepica.rcKyRepicaPointSales(
            REPICA_BIZ_TYPE.REPICA_POINT_SUBT.repicaBizTypeCd);
        return;
      }
    }

    // 後通信処理が有効な場合、後通信処理のチェック、及び、実施
    if (await RcSysChk.rcsyschkLastCommSystem()) {
      // 後通信処理のチェック、及び、実施
      if (await RcLastcomm.rcLastCommMainProc(0) != 0) {
        return;
      }
    }

    // 釣銭機入金確定終了処理 (ATCT_Proc_Error(1)でのチェックも行う)
    errNo = await RcClsCom.clsComAcxAutoDecisionFnalProc(acrErrNo, acxRetryFlg);
    if (errNo != 0) {
      if (await RckyRegassist.rcCheckRegAssistPaymentAct(errNo)) {
        RckyRegassist.rcRegAssistPaymentDisp();
        errNo = OK;
      } else {
        await RcExt.rcErr('rcChargeAmount1', errNo);
      }
      await RcIfEvent.rxChkTimerAdd();
      return;
    }
    frestaSprtChk = 1;
    eTendType = await RcAtct.rcATCTProc(); // to Common function
    if (RcAtct.rcATCTChkTendType(eTendType!)) {
      RcTaxFreeSvr.rcTaxfreeNoGet();
    }

    if ((await CmCksys.cmIchiyamaMartSystem() != 0) &&
        (!await RcSysChk.rcQCChkQcashierSystem()) &&
        (pCom.custOffline == 2)) {
      switch (eTendType) {
        case TendType.TEND_TYPE_TEND_AMOUNT:
        case TendType.TEND_TYPE_NO_ENTRY_DATA:
          regsMem.tTtllog.t100002.custCd = 0;
          if (regsMem.tTtllog.t100701.dtiqTtlsrv > 0) {
            regsMem.tTtllog.t100700.tpntTtlsrv +=
                regsMem.tTtllog.t100701.duptTtlrv;
            regsMem.tTtllog.t100701.duptTtlrv = 0;
            regsMem.tTtllog.t100701.dtipTtlsrv = 0;
            regsMem.tTtllog.t100701.dtiqTtlsrv = 0;
          }
          break;
        default:
          break;
      }
    }

    RcAssistMnt.rcAssistSend(24013);
    if (eTendType!.value < 0) {
      /* error in AT/CT ? */
      if (acxRetryFlg == 1) {
        //入金確定の監視処理へ戻す
        AcbInfo.fnalRestartFlg = 1;
        RcAcracb.rcGtkTimerRemoveAcb();
        RcAcracb.rcGtkTimerAddAcb(100, RckyccinAcb.rcAutoDecision());
      }

      /* 特定乗算仕様：エラーの場合はスプリット情報を元に戻すためフラグをセット */
      if (await RcFncChk.rcfncchkSpecialMulUse()) {
        atSing.mulErrFlg = 1;
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
            "rcChageAmount1: rcfncchk_Special_MulUse Err Return!!\n");
      }
      await RcIfEvent.rxChkTimerAdd();
      return;
    }

    rcKyChaNochgCconfFlgSet(0);

    if ((await CmCksys.cmZHQSystem() != 0) &&
        ((eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA) ||
            (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) &&
        ((RcSysChk.rcRGOpeModeChk()) || (RcSysChk.rcTROpeModeChk())) &&
        (!await RcSysChk.rcQCChkQcashierSystem()) &&
        (regsMem.tTtllog.t100001Sts.cpnErrDlgFlg == 0) &&
        (atSing.zhqCpnErrFlg == 0) &&
        (RcKyCpnprn.rccpnprnPrintResCheck() == 1)) {
      rcChargeAmount1CpnNGMsg(TendType.TEND_TYPE_ERROR);
    } else {
      await rcChargeAmount1Sub();
    }
    return;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_Sub
  static Future<void> rcChargeAmount1Sub() async {
    await rcChargeAmount1_1Sub();
    return;
  }

/*
  /// 関連tprxソース: rcky_cha.c - rcChargeAmount1_Sub()
  static Future<void> rcChargeAmount1Sub() async {
    int qrTxtPrint = 0;
    int statusChk;
    String log = "";
    int? entry, data;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcChargeAmount1Sub() rxMemRead error\n");
      return;
    }

    AtSingl? atSingl;
    AcMem cMem = SystemFunc.readAcMem();
    KopttranBuff koptTran = KopttranBuff();
    RegsMem regsMem = RegsMem();
    TTtlLog ttlLog = TTtlLog();

    // 後通信処理済みの場合、確認画面はスキップ
    if (await RcLastcomm.rcLastCommChkCommEnd()) {
      rcChargeAmount1_1();
      return;
    }

    // TODO:00012 平野 QUICPay,iD機能の実装を優先するため実装スキップ
    // memo: 行番号6039

    // 友の会での売上の場合
    // if ((rcsyschk_tomoIF_system())
    //     &&  (CMEM->stat.FncCode == rxChk_CHACHK_OnlyCrdtTyp(C_BUF,SPTEND_STATUS_TOMOCARD)))
    // {	// rcChargeAmount1_1_Sub()の処理は対応しない   -> 精算機選択画面の利用はしない
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcChargeAmount1_Sub [Tomo] go rcChargeAmount1_1");
    // rcChargeAmount1_1();
    // return;
    // }
    //
    // if ((rcsyschk_Tpoint_System())
    // && (CMEM->stat.FncCode == rxmbrcom_ChkComPointUseKey(PNTTYPE_TPOINT, C_BUF)))
    // {
    // snprintf(log, sizeof(log), "%s: [T-Point] go to rcChargeAmount1_1()", __FUNCTION__);
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    // rcChargeAmount1_1();
    // return;
    // }

    if ((await RcSysChk.rcQRChkPrintSystem()) &&
        !(await RcSysChk.rcQCChkQcashierSystem()) &&
        (!await RcSysChk.rcChkCashierQRPrint()) &&
        ((RcSysChk.rcRGOpeModeChk()) || (RcSysChk.rcTROpeModeChk()))) {
      qrTxtPrint = 1;
      await RcFlrda.rcReadKopttran(cMem.stat.fncCode as int, koptTran);
      statusChk = await RcFncChk.rcfncchkAlltranQCConduct();

      if (statusChk == 0) {
        if (koptTran.crdtEnbleFlg != 0) {
          qrTxtPrint = 0;
        }

        if (koptTran.nochgFlg == 1) {
          qrTxtPrint = 0;
        }
      } else {
        if (((koptTran.crdtEnbleFlg != 0) // 掛け売りの場合は許可しない
                ||
                (RcSpeezaCom.rcChkChaTranSpeezaUpd() ==
                    1)) // 小計額以上の会計・品券キー入力時に取引送信しない
            ||
            ((RcSysChk.rcChkCustrealPointTactixSystem() !=
                    0) //PointTactix仕様のポイント割戻キーで締めた場合、取引送信しない
                &&
                (RcMbrPcom.rcmbrGetManualRbtKeyCd() ==
                    ttlLog
                        .t100100[ttlLog.t100001Sts.sptendCnt - 1]!.sptendCd))) {
          qrTxtPrint = 0;
          statusChk = 0;
        }
      }

      RcNoChgDsp.rcChgGetSptendData(entry!, data!);

      if ((statusChk != 0) // QCashierへ誘導する
          &&
          (koptTran.nochgFlg == 2) // つり銭支払が確認表示
          &&
          (koptTran.tranUpdateFlg == 0) // 現金加算
          &&
          (koptTran.stlOverFlg != 2) // 小計額を超える登録が確認表示でない
          &&
          (data != 0) // スプリット残額が0円でない
          &&
          (rcKyChaNochgConfFlgGet() == 0)) {
        // まだ確認表示していない
        rcKyChaNochgCconfFlgSet(1);

        if ((RcSysChk.rcChkSpecialMultiOpe()) // 特殊乗算オペレーション
            &&
            ((cMem.keyStat[FuncKey.KY_MUL as int] = RcRegs.kyStR0(cMem.keyStat[FuncKey.KY_MUL as int])) != 0)) {
          rcKyChaNochgCconfFlgSet(2);
        }

        if (!((entry == data) // rcChgAmtMakeDsp()を参照
            ||
            (data <= 0) ||
            (entry == 0))) {
          RcNoChgDsp.rcChgAmtMakeDsp();
          return;
        }
      }

      if (qrTxtPrint != QrTxtStatus.QR_TXT_STATUS_INIT) {
        qrTxtPrint = 0;
      }

      if ((RcFncChk.rcChkTenOn()) || (rcKyChaNochgConfFlgGet() == 2)) {
        // 特殊乗算のとき、乗算後に値数フラグが落ちてしまうため
        switch (eTendType) {
          case TendType.TEND_TYPE_TEND_AMOUNT:
          case TendType.TEND_TYPE_POST_TEND_END:
            if (statusChk == 1) {
              // 掛け売り取引以外の全ての取引をQCashierへ誘導する
              RcIbCal0.rcStlItemCustCalc();
            } else {
              if (await RcSysChk.rcSysChkHappySmile()) {
                // HappySelfの場合は、スマイルセルフで精算を終わらせたい為
                if (RcKyQcSelect.rcChkChoiceQcSlct() != true) {
                  qrTxtPrint = 0;
                } else {
                  RcIbCal0.rcStlItemCustCalc();
                }
              } else {
                if (ttlLog.t100001.chgAmt == 0) {
                  qrTxtPrint = 0;
                } else {
                  RcIbCal0.rcStlItemCustCalc();
                }
              }
            }
            break;
          case TendType.TEND_TYPE_NO_ENTRY_DATA:
          case TendType.TEND_TYPE_SPRIT_TEND:
            qrTxtPrint = 0;
            break;
          default:
            break;
        }
      } else {
        qrTxtPrint = 0;
      }

      if (qrTxtPrint == 1) {
        RcqrCom.qrTxtPrintFlg = 1;
        qrTxtPrint = 0;
        if ((regsMem.tHeader.ope_mode_flg != OpeModeFlagList.OPE_MODE_REG) &&
            (regsMem.tHeader.ope_mode_flg !=
                OpeModeFlagList.OPE_MODE_TRAINING)) {
          RcIfEvent.rxChkModeReset2("rcChargeAmount1Sub");
          return;
        }
        if (koptTran.stlOverFlg == 2) {
          RcqrCom.qrTxtPrintFlg = 2;
        }

        if ((CmCksys.cmIchiyamaMartSystem() != 0) &&
            !(await RcSysChk.rcQCChkQcashierSystem())) {
          if ((ttlLog.t100001.periodDscAmt != 0) &&
              !(RckyCashVoid.rcCheckCashVoidDsp())) {
            if ((RcqrCom.qrTxtPrintFlg == 1) &&
                (RcKyQcSelect.rcChkChoiceQcSlct() != true)) {
              RcqrCom.qrTxtPrintFlg = 2;
            }
          }
        }
        // QC指定仕様で選択画面を表示する仕様をチェック (確認画面表示の場合は確認画面にQC指定キー表示)
        if ((RcqrCom.qrTxtPrintFlg != 2) &&
            (RcKyQcSelect.rcChkChoiceQcSlct() == true)) {
          RcqrCom.qrTxtPrintFlg = 0;
          if ((CmCksys.cmZHQSystem() != 0) &&
              ((eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA) ||
                  (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) &&
              ((RcSysChk.rcRGOpeModeChk()) || (RcSysChk.rcTROpeModeChk())) &&
              (!await RcSysChk.rcQCChkQcashierSystem()) &&
              (ttlLog.t100001Sts.cpnErrDlgFlg == 0) &&
              (atSingl!.zhqCpnErrFlg == 0) &&
              (RcKyCpnprn.rccpnprnPrintResCheck() == 1)) {
            rcChargeAmount1CpnNGMsg(eTendType!);
          } else {
            RcKyQcSelect.rcDispChoiceQcSlct(eTendType!); // 画面表示
          }
          return; // 選択画面表示のため戻る
        } else {
          // TODO:00012 平野 優先度が低いため以下は実装保留
          // オーシャンシステム様向け 押下キーが動作可能かチェック。
          // if (rcChk_Ocean_BtnInvalid (CMEM->stat.FncCode))
          // {
          //   // 金額確認画面を表示する場合
          //   if (qr_txt_print_flg == 2)      /* 小計額を越える登録:確認表示 */
          //   {
          //     ;       // 金額確認画面で抑止する
          //   }
          //   else
          //   {
          //     // 釣りありお会計券を登録機で印字する場合は、動作を抑止
          //     sprintf (log, "rcChargeAmount1_Sub()  rcChk_Ocean_BtnInvalid()!\n");
          //     TprLibLogWrite (GetTid(), TPRLOG_ERROR, -1, log);
          //
          //     qr_txt_print_flg = 0;      // (rcKy_QCTckt はおこなわない)
          //     CMEM->ent.err_no = MSG_INVALID_CUSTCODEEXIST;
          //     rcErr(CMEM->ent.err_no);
          //     rxChkTimerAdd();
          //     return;
          //   }
          // }
        }
      }
    }

    // TODO:10033 コンパイルスイッチ(TW)
    // TWが0で設定されているため、コメントアウト
    //#if TW
    //   if(!rcCheck_ESVoidI_Mode()) {
    //   if(MEM->tTtllog.t100003.refund_qty > 0) {
    //   rcTWNoRef((void *)rcChargeAmount1_1);
    //   return;
    //   }
    //   }
    //#endif

    // TODO:10119 コンパイルスイッチ(CN)
    // CNが0で設定されているため、コメントアウト
    //#if CN
    //   if(rcChk_Cheque_KeyOpt()) {
    //   rcChequeInp((void *)rcChargeAmount1_1);    /* 小切手番号入力 */
    //   return ;
    //   }
    //#endif
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode as int, koptTran);
    //#if 0
    //@@@V15
    //     if(/*(cm_fb_dual_system() == 2) &&*/ (((C_BUF->db_trm.non_change_over_amt) && (KOPTTRAN.chk_amt != 0)) ||
    //     ((C_BUF->db_trm.original_card_ope) && (AT_SING->limit_flg) && CMEM->custdata.enq.prom_ticket_no7 != 0 && CMEM->custdata.enq.prom_ticket_no8 != 0 &&
    //     (((CMEM->custdata.enq.anyprc_term_mny + rxCalc_Stl_Tax_Amt(MEM)) > CMEM->custdata.enq.prom_ticket_no7) ||
    //     (rxCalc_Stl_Tax_Amt(MEM) > CMEM->custdata.enq.prom_ticket_no8)))))
    //#endif

    CCustDataLog cCustDataLog = CCustDataLog();
    if ((pCom.dbTrm.nonChangeOverAmt != 0) && (koptTran.chkAmt != 0)) {
      if (atSingl!.chaReturnFlg != 0) {
        if (!await RcFncChk.rcCheckStlMode()) {
          RckyStl.rcStlDisplay(false);
        }
        rcClrSpritNochg();
        return;
      }
    } else if ((pCom.dbTrm.originalCardOpe != 0) &&
        (atSingl!.limitFlg != 0) &&
        (koptTran.crdtEnbleFlg == 1)) {
      if (RcSysChk.rcVDOpeModeChk()) {
        ttlLog.t100012Sts?.hycardTtlamt =
            cCustDataLog.n_data6 - RxLogCalc.rxCalcStlTaxAmt(regsMem);
      } else {
        ttlLog.t100012Sts?.hycardTtlamt =
            cCustDataLog.n_data6 + RxLogCalc.rxCalcStlTaxAmt(regsMem);
      }
      ttlLog.t100012Sts?.outsideRbtprnflg = 1;
    } else if ((pCom.dbTrm.originalCardOpe != 0) &&
        (atSingl!.limitFlg != 0) &&
        (koptTran.crdtEnbleFlg == 0)) {
      ttlLog.t100012Sts?.hycardTtlamt = cCustDataLog.n_data6;
    }

    //#if SELF_GATE
    if ((RcSysChk.rcSGCheckRfmPrnSystem()) && (koptTran.crdtEnbleFlg == 0)) {
      if ((eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA) ||
          (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) {
        rcSG_RfmPrint_Msg();
      } else {
        rcChargeAmount1_1Sub();
      }
    } else if ((rcSG_Check_RfmPrn_System()) &&
        (koptTran.crdtEnbleFlg == 1) &&
        (pCom.dbTrm.joyposCreditChakey != 0) &&
        !(rcChk_SelfCrdt_System()) &&
        (rcChk_SelfKey_FncCd(pCom.dbTrm.selfCrdtKeyCd) == cMem.stat.fncCode)) {
      if ((eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA) ||
          (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) {
        rcSG_RfmPrint_Msg();
      } else {
        rcChargeAmount1_1Sub();
      }
    } else
    //#endif
    if (rcChk_Prom_Alert()) {
      if ((eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA) ||
          (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) {
        rcProm_Alert_Msg(KY_CHA1);
      } else {
        rcChargeAmount1_1Sub();
      }
    } else {
      rcChargeAmount1_1Sub();
    }
    return;
  }
  */

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_CpnNGMsg
  static void rcChargeAmount1CpnNGMsg(TendType eTendType) {
    return;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_1_Sub()
  static Future<void> rcChargeAmount1_1Sub() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    await rcChargeAmount1_1();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_1()
  static Future<void> rcChargeAmount1_1() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // ポイント系の処理.

    await rcChargeAmount1_1_0();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_1_0()
  static Future<void> rcChargeAmount1_1_0() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // Dポイントやレピカポイントなどの処理
    await rcChargeAmount1_1_1();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_1_1()
  static Future<void> rcChargeAmount1_1_1() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    // TODO:10121 QUICPay、iD 202404実装対象外

    if ((!await RcFncChk.rcCheckESVoidIMode()) &&
        (!await RcFncChk.rcCheckESVoidSMode())) {
      if (!RcAtct.rcATCTChkTendType(eTendType!)) {
        if (CompileFlag.IWAI) {
          // TODO:10158 商品券支払い 実装対象外
          // if ((rcChk_ORC_System()) && (AT_SING.use_rwc_rw == 1))
          // rcOrc_Disable_Proc();
        }

        await RcAtct.rcATCTEnd(eTendType!, cMem.stat.fncCode);
        cMem.stat.eventMode = 0;
        await RcIfEvent.rxChkTimerAdd();
        // TODO:10158 商品券支払い 実装対象外
        // // キャッシュレス還元仕様処理
        // if (rc_cashless_proc_step()) {
        //   rc_cashless_proc();
        // }

        // if (rcChk_vesca_center_connect(VERIFONE_CENCNT_2)) {
        //   if (!((TprLibDlgCheck()) || (rcChk_Err()))) {
        //   /* 一部支払時 */
        //   if ((tsBuf.jpo.vesca_currentservice == 2) // Edy
        //     ||
        //     (tsBuf.jpo.vesca_currentservice == 4) // 交通系
        //     ||
        //     (tsBuf.jpo.vesca_currentservice == 7) // waon
        //     ||
        //     (tsBuf.jpo.vesca_currentservice == 8) // nanaco
        //   ) {
        //     if ((rcCheck_QCJC_Cashier()) ||
        //       (rcQC_Chk_Qcashier_System()) ||
        //       ((rcChk_SmartSelf_System()) && (!rcsyschk_happy_smile()))) {
        //     /* QC画面 */
        //     ;
        //     } else {
        //     rcErrNoBz(MSG_VESCA_SETTLE_SPRIT);
        //     }
        //   }
        //   }
        // }
        // if (rcsyschk_vesca_system()) {
        //   /* 端末決済完了後、クリア */
        //   tsBuf.jpo.vesca_currentservice = 0;
        // }
        //

        return;
      }
    }

    // TODO:10158 商品券支払い 実装対象外
    //    if(MEM->tTtllog.t100900Sts.rwc_write_flg == 1)
    // MEM->tTtllog.t100900Sts.rwc_write_flg = 0;

    if (CompileFlag.DEPARTMENT_STORE) {
      // TODO:10158 商品券支払い 実装対象外
      //  if( ( cm_DepartmentStore_system()  ) &&
      //           ( MEM->tTtllog.calcData.card_1time_amt || MEM->tmpbuf.ope_mode_flg_bak )    ) {
      //     switch (eTendType) {
      //        case TEND_TYPE_NO_ENTRY_DATA:
      //        case TEND_TYPE_TEND_AMOUNT:
      //        case TEND_TYPE_POST_TEND_END:
      //           rc_dual_conf_destroy();
      //        default:
      //           break;
      //     }
      //  }
    }
    // 返品操作時は結果ダイアログを表示
    if (RcAtct.rcATCTChkTendType(eTendType!)) {
      // TODO:10158 商品券支払い 実装対象外
      // rcRfdOprDispResultDlg();
    }

// TODO:10158 商品券支払い 実装対象外
//     if(cm_UT_cnct_system() && (CMEM->stat.FncCode == KY_CHA2)) {
//      rcUt_SlipSend_MainProc();
//      return;
//    }

//    if( rcChk_ChargeSlip_System()  /*&& (C_BUF->db_trm.mag_card_typ == OTHER_CO3)*/ ) {
//       rc_ChargeSlipReSet_ScrpImgNo();
//    }

// //   if( (rcChk_ChargeSlip_System() && rcChkMember_ChargeSlipCard() && MEM->prnrbuf.charge_slip_flg == 1))
// //   if( (rcChk_ChargeSlip_System() && rcChkMember_ChargeSlipCard() && (MEM->prnrbuf.charge_slip_flg != 2)))
//    if( rcChk_ChargeSlip_System() && rcChkMember_ChargeSlipCard() && OrderOutPutFlg ) {
//                                                       /* charge_slip_flg = 0 は rcChkMember_ChargeSlipCard()で行なう */
//       rc_ChargeSlipSend_MainProc();
//       return;
//    }

// 	if ( (rcChk_Shop_and_Go_DeskTop_System())	// 卓上機にてShop&Go仕様
// 		&& (MEM->qc_SaG_Data_Set_flg) )			// Shop&Go商品登録チェック
// 	{
// 		// 締め操作後にバスケットサーバーのカートの状態更新（支払い完了）
// 		ret = rc_SaG_BasketServer_Upload( SHOP_A_GO_CART_STS_POS_PAY );
// 		rc_SaG_CR50_SNDApiFixedSalse_Set_CartID();
// 		if( ret == OK )
// 		{
// 			rc_SaG_CR50_SNDApiFixedSales_Get();
// 			memset(log, 0x00, sizeof(log));
// 			sprintf(log, "rc_SaG_CR50_SNDApiFixedSales_Get() executed.");
// 			TprLibLogWrite( GetTid(), TPRLOG_NORMAL, 0, log);
// 		}
// 		else
// 		{
// 			TS_BUF->basket_server.rcv_api_fixed_sales.result = -1;
// 			memset(log, 0x00, sizeof(log));
// 			sprintf(log, "rc_SaG_CR50_SNDApiFixedSales_Get() not executed. rc_SaG_BasketServer_Upload() ret = [%d]", ret);
// 			TprLibLogWrite( GetTid(), TPRLOG_ERROR, -1, log);
// 		}
// 		MEM->qc_SaG_Data_Set_flg = 0;		// 卓上機にてShop&Go商品読込フラグをリセットする。
// 	}

    await rcChargeAmount1_2_0();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_2_0()
  static Future<void> rcChargeAmount1_2_0() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // Cソースではタイマー処理で1ms後実行.Flutterでは非同期で実行する
    rcChargeAmount1_2();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_2()
  static Future<void> rcChargeAmount1_2() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    await rcChargeAmount1_2Sub();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount1_2_sub()
  static Future<void> rcChargeAmount1_2Sub() async {
    //print_err = rcATCT_Print(eTendType);
    // usbカメラなどのストップ処理
    // TODO:10121 QUICPay、iD 202404実装対象外
    rcChargeAmount5();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount5()
  static Future<void> rcChargeAmount5() async {
    int webRealFlg = 0;
    RcGtkTimer.rcGtkTimerRemove();
    // TODO:10158 商品券支払い 実装対象外
    // #if FELICA_SMT
    // if(! rcChk_Felica_System()) {
    // #endif
    // #if CUSTREALSVR
    // if ((rcChk_Custrealsvr_System()
    // || rcChk_Custreal_Nec_System(0)
    // || rcChk_Custreal_UID_System()
    // || rcChk_Custreal_OP_System()
    // || (AT_SING->webreal_data.add_stat == 2)
    // || (rcChk_Custreal_Pointartist_System())
    // || (rcChk_Custreal_PointTactix_System()))
    // && custreal_mbr_update == 1)
    // {
    // custreal_mbr_update = 0;
    // }
    // else if (cm_nimoca_point_system()
    // && custreal_mbr_update == 1)
    // {
    // custreal_mbr_update = 0;
    // }
    // else if ((rcChk_Tpoint_System())
    // && (custreal_mbr_update == 1))
    // {
    // custreal_mbr_update = 0;
    // }
    // else
    // #endif
    // {
    // if ((rcChk_Custreal_Webser_System())
    // && (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT)
    // && (AT_SING->webreal_data.add_stat == 1))
    // {
    // webreal_flg = 1;
    // AT_SING->webreal_data.func = (void*)rcChargeAmount5_1;
    // AT_SING->webreal_data.add_err = 0;
    // }
    await RcClsCom.clsComMbrUpdate(eTendType!);
    //   if ((webreal_flg)
    //   && (AT_SING->webreal_data.add_err))
    //   {
    //   return;
    //   }
    //   }
    //   #if FELICA_SMT
    // }
    // #endif

    await rcChargeAmount5_1();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount5_1()
  static Future<void> rcChargeAmount5_1() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    rcChargeAmount5_2();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount5_2()
  static Future<void> rcChargeAmount5_2() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    rcChargeAmount2();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount2()
  static Future<void> rcChargeAmount2() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcChargeAmount2() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if DEBIT_CREDIT & RALSE_CREDIT
    // kopttran_buff KOPTTRAN;
    // #endif
    RcGtkTimer.rcGtkTimerRemove();

    // TODO:10158 商品券支払い 実装対象外
    // if(rcQC_Check_Coin_NonAcr()){
    //   CMEM->ent.err_no = rcGtkTimerAdd(NORMAL_EVENT, (GtkFunction)rcChargeAmount5_3);
    // CMEM->stat.EventMode = 0;
    // if(CMEM->ent.err_no) {
    // rcErr(CMEM->ent.err_no);
    // rxChkModeReset();
    // }
    // return;
    // }
    //
    // #if DEBIT_CREDIT & RALSE_CREDIT
    // rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    // if((!((KOPTTRAN.crdt_enble_flg ) &&
    // (rcChk_RalseCard_System()) &&
    // (rcChk_JET_B_Process()   )))
    // ||((rcCheck_ESVoidS_Mode()) ||
    // (rcCheck_ESVoidI_Mode())     )
    // ) {
    // #endif

    if (!await RcFncChk.rcQCCheckCoinNonAcr()) {
      if (!((cBuf.dbTrm.disableStampCha9key != 0) &&
          (cMem.stat.fncCode == FuncKey.KY_CHA9.keyId))) {
        RcClsCom.clsComAcxResult(acrErrNo);
      }
    }

    // #if DEBIT_CREDIT & RALSE_CREDIT
    // }
    // #endif

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行：8119-8157

    rcChargeAmount5_3();
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount5_3()
  static Future<void> rcChargeAmount5_3() async {
    int result = 0;
    int errorCtrlFlg = 0;
    int popTimer = 0;

    RcGtkTimer.rcGtkTimerRemove();

    if (await RcSysChk.rcQCChkQcashierSystem()) {
    } else if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
      if (!await RcSysChk.rcChk2800System()) {
        rcChargeAmount5_4();
        return;
      }
    } else {
      if (!RcSysChk.rcChkChangeAfterReceipt()) {
        rcChargeAmount5_4();
        return;
      }
    }
    AcMem cMem = SystemFunc.readAcMem();
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    RegsMem regsMem = RegsMem();
    QCashierIni? qCashierIni;

    if ((regsMem.tTtllog.t100001.chgAmt != 0) &&
        (await RcAcracb.rcCheckAcrAcbON(1) != 0)) {
      result = RckyccinAcb.rcChkPopWindowChgOutWarn(0);
      if ((result != 0) ||
          (acrErrNo != 0) ||
          ((CmCksys.cmAcxErrGuiSystem() != 0) // エラー復旧ガイダンスを使用
              &&
              (RcFncChk.rcCheckChgErrMode())) // エラー復旧ガイダンスを表示中
          ||
          ((await RcSysChk.rcQCChkQcashierSystem()) // QCashier仕様且つ、エラー中
              &&
              (RcQcDsp.rcQCChkErr() != 0)) ||
          (RcFncChk.rcChkErr() != 0)) {
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          cBuf.kymenuUpFlg = 2;
          cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(
              qCashierIni!.data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 *
                  1000,
              rcChargeAmount5_3);
          popTimer = await RcAcracb.rcAcrAcbPopTimerCalc(result);
          cMem.ent.errNo =
              RcGtkTimer.rcGtkTimerAdd(popTimer, rcChargeAmount5_3);
        } else if ((await RcSysChk.rcChk2800System()) &&
            (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {
          SgSubDsp().subDisp = SUB_CASH_ORDER.SUB_CASHSTARTING.index;
          RcSpjDsp.rcSPJEndRcptDisp(1);
          if (spjPaydspFlg == 0) {
            RcNewSgFnc.rcNewSGComTimerGifDsp();
          }
          spjPaydspFlg = 1;
          cBuf.kymenuUpFlg = 2;
          cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(1000, rcChargeAmount5_3);
        } else {
          if (RcSysChk.rcChkChangeAfterReceipt()) {
            if (acrErrNo != 0) {
              cBuf.kymenuUpFlg = 0;
              errorCtrlFlg = 1;
            } else {
              cBuf.kymenuUpFlg = 2;
              if (await RcSysChk.rcChkFselfMain()) {
                if (qCashierIni!.chgWarnTimerUse == 1) {
                  if (qCashierIni
                          .data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 ==
                      0) {
                    qCashierIni
                        .data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 = 2;
                  } else if (qCashierIni
                          .data[QcScreen.QC_SCREEN_PAY_CASH_END.index].timer3 >
                      10) {
                    qCashierIni.data[QcScreen.QC_SCREEN_PAY_CASH_END.index]
                        .timer3 = 10;
                  }
                  cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(
                      qCashierIni.data[QcScreen.QC_SCREEN_PAY_CASH_END.index]
                              .timer3 *
                          200,
                      rcChargeAmount5_3);
                } else {
                  cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(
                      100, rcChargeAmount5_3); // 再度、チューニング
                }
              } else {
                cMem.ent.errNo =
                    RcGtkTimer.rcGtkTimerAdd(1000, rcChargeAmount5_3);
              }
            }
          }
        }

        if (errorCtrlFlg == 0) {
          if (cMem.ent.errNo != 0) {
            await RcExt.rcErr("", cMem.ent.errNo);
            await RcExt.rxChkModeReset("");
            cBuf.kymenuUpFlg = 0;
          } else if (acrErrNo != 0) {
            cMem.ent.errNo = acrErrNo;
            RcKyccin.ccinErrDialog2("", cMem.ent.errNo, 0);
            await RcExt.rxChkModeReset("");
            cBuf.kymenuUpFlg = 0;
            acrErrNo = 0;
          }

          return;
        }
      }

      // プリンタへの送信処理はクラウドPOSに置き換わるのでコメントアウト.
      // if (await RcSysChk.rcQCChkQcashierSystem()) {
      //   cMem.stat.fncCode = RcQcDsp.qcFncCd;
      //   regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_RCPT.index;
      //   printErr = await RcAtctp.rcATCTPrint(eTendType);
      //   RcFncChk.rcOpeTime(OpeTimeFlgs.OPETIME_END.index);
      //   RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
      //   RcQcDsp.rcQCCashEndDisp2(1);
      // } else if ((await RcSysChk.rcChk2800System()) &&
      //     (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {
      //   RcNewSgFnc.rcNewSGDspGtkTimerRemove();
      //   RcsgDev.rcSGSndGtkTimerRemove();
      //   regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_RCPT.index;
      //   printErr = await RcAtctp.rcATCTPrint(eTendType);
      //   RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
      //   RcSpjDsp.rcSPJEndRcptDisp(0);
      //   spjPaydspFlg = 0;
      // } else {
      //   if (RcSysChk.rcChkChangeAfterReceipt()) {
      //     regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_RCPT.index;
      //     printErr = await RcAtctp.rcATCTPrint(eTendType);
      //     RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
      //
      //     if (await RcSysChk.rcChkFselfMain()) {
      //       RcSet.cashStatReset2("");
      //     }
      //   }
      //
      //   if (errorCtrlFlg == 1) {
      //     await RcExt.rcErr("", acrErrNo!);
      //     await RcExt.rxChkModeReset("");
      //   }
      // }

      cBuf.kymenuUpFlg = 0;
      autorprCnt = 0;
      //売価変更でお釣り無しQRがお釣りありに変更された場合の為、40002も送信
      RcAssistMnt.rcPayInfoMsgSend(1, 40002, 0);
      RcAssistMnt.rcPayInfoMsgSend(1, 40004, 0);

      // 実績上げはクラウドPOSになるのでコメントアウト
      // // cMem.ent.errNo =
      //      RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT * 4, rcChargeAmount5_4);
    } else {
      await rcChargeAmount5_4();
    }
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount5_4()
  static Future<void> rcChargeAmount5_4() async {
    AcMem cMem = SystemFunc.readAcMem();
    RcGtkTimer.rcGtkTimerRemove();
    String callFunc = 'rcChargeAmount5_4';

// TODO:10121 QUICPay、iD 202404実装対象外
/*
#if MBR_SPEC
    FNC (ATCT_FinalI) ();
#endif
*/

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "RcKeyCash rxMemRead error");

      await RcExt.rxChkModeReset("rcChargeAmount5_4");
      return;
    }
    RxCommonBuf pCom = xRet.object;
    CalcResultPay retData = await RcClxosPayment.payment(pCom);

      if (0 != retData.retSts) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "RcKeyCha ${retData.errMsg}");
        // ここに来る前にエラーでとまるはずなので、ここではダイアログなし.
        // エラーダイアログを表示.
        // Get.dialog(
        //   MsgDialog(
        //     type:MsgDialogType.error,
        //     message: retData.errMsg ?? "エラー",
        //   ),
        //   barrierDismissible: false,
        // );
      } else {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(Tpraid.TPRAID_CASH, retData.digitalReceipt, callFunc, bkEnable : true);
      }

    // TODO:10127 QUICPay、iD UI結合 UI用のデータをリセット.
    // TODO:10138 再発行、領収書対応 の為コメントアウト
    // RegisterBodyController bodyCtrl = Get.find();
    // bodyCtrl.delTabList();

    // TODO:10138 再発行、領収書対応 の為
    // スプリット対応：締め状態によって画面遷移先を判別する
    // 全商品返品操作扱い：締め状態とする。
    int refundFlag = retData.totalData?.refundFlag ?? 0;
    TendType? refTendType;
    if (refundFlag == 1) {
      refTendType = TendType.TEND_TYPE_TEND_AMOUNT;
    } else {
      refTendType = eTendType;
    }

    RcAtctD.rcATCTDisplay(refTendType!);
    await RcAtct.rcATCTEnd(refTendType!, cMem.stat.fncCode);

/* TWNO_S2PR */
// TODO:10121 QUICPay、iD 202404実装対象外
/*
#if TW
#if TW_2S_PRINTER
    if (rcCheck_S2Print () == TRUE) {
      cMem.ent.errNo = rcGtkTimerAdd(NORMAL_EVENT, (GtkFunction)rcChargeAmount6);
    }
    else
#endif
    {
      updateErr = rcATCT_Update(eTendType);
      if(cMem.ent.warnNo != 0) {
        pop_warn = 1;
        rcWarn(cMem.ent.warnNo);
        cMem.ent.errNo = rcGtkTimerAdd(WARN_EVENT, (GtkFunction)rcChargeAmount6);
      }
      else {
        cMem.ent.errNo = rcGtkTimerAdd(NORMAL_EVENT, (GtkFunction)rcChargeAmount6);
      }
    }
#else
*/

    if (await RcSysChk.rcCheckWizAdjUpdate() == true) {
      // updateErr = await RcAtct.rcATCTUpdate(eTendType);
      // RcqrCom.qrReadSptendCnt = 0;
    } else if ((await RcSysChk.rcQCChkQcashierSystem()) ||
        (await rckyChaNormalRegSrchRegChk() == 1)) {
      // if (RcqrCom.qrReadSptendCnt > 0) {
      //   if ((RcqrCom.qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_INIT.index) &&
      //       (await CmCksys.cmMarutoSystem() != 0) &&
      //       (regsMem.tTtllog.t100001.chgAmt != 0)) {
      //     regsMem.tTtllog.calcData.cardDepositAmt = 1;
      //   }
      //   updateErr = RckyQctckt.rcQCDataUpdate(eTendType);
      // }
      // updateErr = await RcAtct.rcATCTUpdate(eTendType);
    } else if (RcqrCom.qrReadSptendCnt !=
        RegsMem().tTtllog.t100001Sts.sptendCnt) {
      updateErr = await RcAtct.rcATCTUpdate(eTendType!);
      if (await RcSysChk.rcCheckWizAdjUpdate() == true) {
        RcqrCom.qrReadSptendCnt = 0;
      }
      // } else if ((RcSysChk.rcChkEntryPrecaTyp() != 0) &&
      //     (Rxcalccom.rxCheckPrepaidSptend(regsMem, cBuf) != 0) &&
      //     (RcqrCom.qrReadSptendCnt == regsMem.tTtllog.t100001Sts.sptendCnt) &&
      //     (regsMem.tTtllog.t100001.chgAmt != 0)) //@@@ 15ver_merge
      // {
      //   /* プリペイドの置数スプリットがあってお釣りありの場合 */
      //   updateErr = await RcAtct.rcATCTUpdate(eTendType);
      // } else if ((await RcSysChk.rcQRChkPrintSystem()) &&
      //     (RcqrCom.qrReadSptendCnt == regsMem.tTtllog.t100001Sts.sptendCnt) &&
      //     (!await RcSysChk.rcChkCashierQRPrint())) {
      //   updateErr = await RcAtct.rcATCTUpdate(eTendType);
    }
    RcqrCom.qrReadSptendCnt = 0;

    if (cMem.ent.warnNo != 0) {
      popWarn = 1;
      RcEwdsp.rcWarn(cMem.ent.warnNo);
      // TODO:00012 平野  [暫定対応]rcGtkTimerAddが仮実装のためそのままCALL
      await rcChargeAmount6();
      // cMem.ent.errNo =
      //     RcGtkTimer.rcGtkTimerAdd(RcRegs.WARN_EVENT, rcChargeAmount6);
    } else {
      // TODO:00012 平野  [暫定対応]rcGtkTimerAddが仮実装のためそのままCALL
      await rcChargeAmount6();
      // cMem.ent.errNo =
      //     RcGtkTimer.rcGtkTimerAdd(RcRegs.NORMAL_EVENT, rcChargeAmount6);
    }
// TODO:10121 QUICPay、iD 202404実装対象外
/*
#endif (#if !TW)
*/
    // if (cMem.ent.errNo != 0) {
    //   if (popWarn == 1) {
    //     RcEwdsp.rcWarnPopDownLcd2("");
    //   }
    //   await RcExt.rcErr("", cMem.ent.errNo);
    //   await RcExt.rxChkModeReset("");
    // }
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount6()
  static Future<void> rcChargeAmount6() async {
    int warnNoChk;

    RcGtkTimer.rcGtkTimerRemove();

    AcMem cMem = SystemFunc.readAcMem();

    if (popWarn == 1) {
      warnNoChk = TprLibDlg.tprLibDlgNoCheck();

      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "rcChargeAmount6 : warnNoChk[$warnNoChk] ent.warn_no[${cMem.ent.warnNo}]");

      if (cMem.ent.warnNo == warnNoChk) {
        // エラーダイアログ表示を消去してしまう為、表示指示したWarn表示と、実際に表示されているWarn表示が同じ場合のみに動作させるようにする
        RcEwdsp.rcWarnPopDownLcd2("");
      }
    }
    popWarn = 0;

    RegsMem regsMem = RegsMem();

    if ((RcSysChk.rcsyschkRepicaPointSystem()) &&
        (regsMem.tmpbuf.workInType == 1) &&
        (regsMem.prnrBuf.repicaPntErr.repicaTargetPrice != 0) &&
        (regsMem.prnrBuf.repicaPntErr.repicaErrFlg == 1) &&
        (regsMem.prnrBuf.repicaPntErr.cardType == "M")) {
      await RcExt.rcErr("", DlgConfirmMsgKind.MSG_PLEASE_POINTCORRECT.dlgId);
    }
    await rcChargeAmount7();

    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("", cMem.ent.errNo);
      await RcExt.rxChkModeReset("");
    }
    return;
  }

  // TODO:00005 田中 rcChargeAmount6実装のため、定義のみ追加
  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount8()
  static Future<void> rcChargeAmount7() async {
    await rcChargeAmount8();
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount9()
  static Future<void> rcChargeAmount8() async {
    await rcChargeAmount9();
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount9()
  static Future<void> rcChargeAmount9() async {
    AcMem cMem = SystemFunc.readAcMem();
    await RcAtct.rcATCTEnd(eTendType!, cMem.stat.fncCode);
    await rcChargeAmount9_1();
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount9_1()
  static Future<void> rcChargeAmount9_1() async {
    // キー処理のリセット.
    await RcExt.rxChkModeReset("rcChargeAmount9_1");
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 関連tprxソース:C:rcky_cha.c - rcErr_KyCharge()
  /// 引数：chk_ctrl_flg : 0以外で特定のチェック処理を除外する
  /// 戻値：0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  static Future<int> rcErrKyCharge(int chkCtrlFlg) async {
    int msgNo;
    int errNo;
    int ret;
    KopttranBuff koptTran = KopttranBuff();
    int execFlg;
    String log;

    AcMem cMem = SystemFunc.readAcMem();

    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if DEPARTMENT_STORE
    // if(rcChk_Department_System() && (rcChk_Crdt_User() == NAKAGO_CRDT)) {
    // if(rcCheck_Crdt_Stat()) {
    // if(rcChk_Crdt_KeyOpt()) {
    // if(CMEM->stat.Depart_Flg & 0x01) {
    // if(CMEM->stat.FncCode != KY_CHA1)
    // return(MSG_INPUTERR);
    // } else {
    // if(CMEM->stat.FncCode != KY_CHA2)
    // return(MSG_INPUTERR);
    // }
    // }
    // }
    // }
    // #endif

    //#if IWAI
    //   if ((rcChk_ORC_System() || rcChk_IWAI_Real_System()) && (CMEM->stat.FncCode == KY_CHA4)) {
    //     if (rcmbr_PChkSelMbr() == NG) return(MSG_OPEERR);
    //   }
    //#endif
    //   if(rcChk_ManualRbtCashKey())
    //   {
    //     if(rcmbr_PChkSelMbr() == NG) return(MSG_RBTKEY_MBR_CALL);
    //   }

    // switch( rxmbrcom_ManualRbtKey_PointKind(CMEM->stat.FncCode, C_BUF) ){
    //   case PNTTYPE_RPOINT:	/* 楽天ポイント利用会計/品券キー */
    //     if( (rcsyschk_Rpoint_System())
    //         && (rxmbrcom_ChkRpointRead(MEM) == 0) )
    //     {
    //       /* 会員読み取りなし */
    //       return(MSG_READ_RPNT);
    //     }
    //     break;
    //   case PNTTYPE_TPOINT:
    //     if ((rcsyschk_Tpoint_System())
    //         && (rxmbrcom_ChkTpointRead(MEM) == 0))
    //     {
    //       return(MSG_RBTKEY_MBR_CALL);
    //     }
    //     break;
    //   default:
    //     break;
    // }

    // if(rcCheck_ERefI_Mode())
    //   return( 0 );
    // if(rcCheck_ESVoidI_Mode())
    //   return( 0 );
    // if(rcCheck_CrdtVoidI_Mode())
    //   return( 0 );
    // if(rcCheck_PrecaVoidI_Mode())
    //   return( 0 );
    // #if RESERV_SYSTEM
    // if( rcCheck_ReservMode() )
    // return( 0 );
    // #endif
    // //   if(rcKy_Self() == KY_CHECKER)
    // if((rcKy_Self() == KY_CHECKER) && (! rcCheck_QCJC_System()))
    // return(MSG_DO_DESKTOPSIDE);
    Liblary.cmFil(cMem.keyChkb, 0xFF, cMem.keyChkb.length);

    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if MC_SYSTEM
    // Ky_St_R4(CMEM->key_chkb[KY_MCFEE]);
    // #endif
    // #if DEPARTMENT_STORE
    // Ky_St_R4(CMEM->key_chkb[KY_WORKIN]);
    // #endif
    if (chkCtrlFlg != 0) {
      RcRegs.kyStR4(cMem.keyChkb, FuncKey.KY_SCRVOID.keyId);
    }
    RcAtct.rcAtctKyStR(cMem.keyChkb);
    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if 0
    // if(rcKy_Status(CMEM->key_chkb, MACRO1 + MACRO2))
    // return(MSG_OPEERR);   /* Ope Error */
    // #endif
    ret = RcFncChk.rcKyStatus(cMem.keyChkb, (RcRegs.MACRO1 + RcRegs.MACRO2));
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(ret)
    // {
    //   return(rcSet_DlgAddData_KeyStatus_Result(ret));
    // }
    // if(cm_hc1_komeri_system()) {
    //   if(Ky_St_C0(CMEM->key_stat[KY_MAN]))
    //     return (MSG_CARDOPEERR);
    // }
    // if(Ky_St_C3(CMEM->key_stat[KY_FNAL]))   /* end of registration ? */
    //   return(MSG_OPEERR);   /* Ope Error */
    // if( (err_no = rcChk_SaleAmtZero()) != OK )
    // {
    //   return ( err_no );
    // }
    //
    // if(rcChk_Tuo_KeyOpt()) {
    //   if(rcVD_OpeModeChk())
    //     return(MSG_OPEMISS);
    //   if(MEM->tTtllog.t100001Sts.sptend_cnt != 0)
    //     return(MSG_OPEMISS);
    //   if(rcChk_Ten_On())
    //     return(MSG_OPEMISS);
    //   if(MEM->tTtllog.t100001Sts.sptend_cnt != 0)
    //     return(MSG_OPEMISS);
    //   if(rxCalc_Stl_Tax_Amt(MEM) == 0)
    //     return(MSG_OPEMISS);
    // }
    //
    // if( (cm_Media_Info_system()) && !(rcChk_Media_KeyOpt()) && (CMEM->stat.FncCode == KY_CHA10) ) {
    //   return(MSG_OPEMISS);
    // }
    //
    // if(chk_ctrl_flg == 0){
    //   if(rcCheck_ChgCin_Mode()){
    //     err_no = rcCheck_AcbFnal();
    //     if(err_no != OK)
    //       return(err_no);
    //   }
    // }
    //
    // if( rcChk_Assort_System() && CMEM->assort.flg ) {
    //   return (MSG_OPEERR);
    // }
    //
    // if ((cm_ZHQ_system())
    //     && (rccpnprn_printResCheck() == -1))
    // {
    //   return (MSG_PRINT_WAITING);
    // }
    //
    // if(chk_ctrl_flg == 0){
    //   if ((( rcKy_Self() != KY_CHECKER ) || (rcCheck_QCJC_System())) &&
    //       ( rcmbrChkStat()            ) &&
    //       ( rcmbrChkCust()            )    ) {
    //   //         MsgNo = rcmbrReMbrCal(KY_CHA1);
    //     MsgNo = rcmbrReMbrCal(CMEM->stat.FncCode, RCMBR_WAIT);
    //     if (MsgNo != OK) return(MsgNo);
    //   }
    // }

    if (await CmCksys.cmCrdtSystem() != 0) {
      /* クレジット仕様    */
      // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
      // MC_SYSTEMが0で定義されていたので、この部分はコメントアウトしておく。
      // #if MC_SYSTEM
      // if(C_BUF->db_mcspec.tele_flg != 2){
      //   if(rcChk_Crdt_KeyOpt() && (AT_SING->mc_tbl.k_amount != KY_MCRDT)) {
      // #else
      if (rcChkCrdtKeyOpt()) {
        // #endif
        // TODO:10121 QUICPay、iD 202404実装対象外
        // if(rcCheck_Crdt_Stat()) {                       /* クレ宣言入力中？  */
        //   if(CMEM->working.crdt_reg.step != INPUT_END) /* クレ宣言入力完了？*/
        //     return(MSG_OPEERR);
        //   else {
        //     err_no = rcChk_RPrinter();
        //     if(err_no != OK)
        //       return(err_no);
        //   }
        //   if(CMEM->working.crdt_reg.stat & 0x0020) {   /* 同会計キー待ち？  */
        //     if(CMEM->stat.FncCode != CMEM->working.crdt_reg.crdtkey)
        //       return(MSG_SAMECRDTKEYIN);
        //   }
        //   if((CMEM->working.crdt_reg.stat & 0x0020) && (CMEM->working.crdt_reg.stat & 0x0010)) /* 伝票クレジットキー待ち？ */
        //     return(MSG_INPUTERR);
        //   if(rcSG_Chk_SelfGate_System() || rcQC_Chk_Qcashier_System()) {
        //     if((rcChk_Crdt_User() == KANSUP_CRDT) && (CMEM->working.crdt_reg.stat & 0x1000))  /* 通信PCオフライン？ */
        //       return(MSG_INPUTERR);
        //   }
        //   if(rcChk_CAPS_CAFIS_System()) {
        //     for(i=0; i < sizeof(CMEM->working.crdt_reg.cdno); i++) {
        //       if( (CMEM->working.crdt_reg.cdno[i] > 0x39) ||
        //           (CMEM->working.crdt_reg.cdno[i] < 0x30)    )
        //         return(MSG_CARDNOCDERR);
        //     }
        //   }
        // }
        // else
        //   return(MSG_INPUTERR);
      } else {
        //#if !MC_SYSTEM
        if ((!(await CmCksys.cmNttaspSystem() != 0)) &&
            (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT)) {
          // TODO:10121 QUICPay、iD 202404実装対象外
          // if(rcChk_OffCrdt_KeyOpt()) {
          //   if(rcCheck_Crdt_Stat()) {                       /* クレ宣言入力中？  */
          //     if(CMEM->working.crdt_reg.step != OFF_KYCHA) /* クレ宣言入力完了？(オフライン) */
          //       return(MSG_CANNOTCRDTKEY);
          //     else {
          //       err_no = rcChk_RPrinter();
          //       if(err_no != OK)
          //         return(err_no);
          //     }
          //     if(CMEM->working.crdt_reg.stat & 0x0020) {   /* 同会計キー待ち？  */
          //       if(CMEM->stat.FncCode != CMEM->working.crdt_reg.crdtkey)
          //         return(MSG_SAMECRDTKEYIN);
          //     }
          //   }
          // }
          // else {
          //   if(rcCheck_Crdt_Stat())                         /* クレ宣言入力中？  */
          //     return(MSG_CANNOTCRDTKEY);
          // }
        } else if ((!(await CmCksys.cmNttaspSystem() != 0)) &&
            (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
          // TODO:10121 QUICPay、iD 202404実装対象外
          //   if(rcChk_HoldCrdt_KeyOpt()) {
          //     if(rcCheck_Crdt_Stat()) {                       /* クレ宣言入力中？  */
          //       if(CMEM->working.crdt_reg.step != INPUT_END) /* クレ宣言入力完了？*/
          //         return(MSG_OPEERR);
          //       else {
          //         err_no = rcChk_RPrinter();
          //         if(err_no != OK)
          //           return(err_no);
          //       }
          //       if(! ((CMEM->working.crdt_reg.stat & 0x0020) && (CMEM->working.crdt_reg.stat & 0x0010))) /* 伝票クレジットキー待ち？ */
          //         return(MSG_INPUTERR);
          //     }
          //     else
          //       return(MSG_INPUTERR);
          //   }
          //   else {
          //#if SELF_GATE
          //     if((rcSG_Chk_SelfGate_System()) || ((rcNewSG_Chk_NewSelfGate_System()) || (rcChk_Quick_Self_System()))) {
          //   if(rcChk_OffCrdt_KeyOpt()) {
          //   if(rcCheck_Crdt_Stat()) {                      /* クレ宣言入力中？  */
          //   if(!(CMEM->working.crdt_reg.stat & 0x1000)) /* オフクレジットキー待ち？ */
          //   return(MSG_INPUTERR);
          //   }
          //   }
          //   else {
          //   if(rcCheck_Crdt_Stat())                        /* クレ宣言入力中？  */
          //   return(MSG_CANNOTCRDTKEY);
          //   }
          //   }
          //   else {
          //#endif
          //   if(rcQC_Chk_Qcashier_System()){
          //   if(rcChk_OffCrdt_KeyOpt()) {
          //   if(rcCheck_Crdt_Stat()) {                      /* クレ宣言入力中？  */
          //   if(!(CMEM->working.crdt_reg.stat & 0x1000)) /* オフクレジットキー待ち？ */
          //   return(MSG_INPUTERR);
          //   }
          //   }
          //   else {
          //   if(rcCheck_Crdt_Stat())                        /* クレ宣言入力中？  */
          //   return(MSG_CANNOTCRDTKEY);
          //   }
          //   }
          //   else if(rcCheck_Crdt_Stat())                         /* クレ宣言入力中？  */
          //   return(MSG_CANNOTCRDTKEY);
          //#if SELF_GATE
          //   }
          //#endif
          //   }
        } else {
          //#endif
          // TODO:10121 QUICPay、iD 202404実装対象外
          // if(rcCheck_Crdt_Stat())                           /* クレ宣言入力中？  */
          //   return(MSG_CANNOTCRDTKEY);
          //#if !MC_SYSTEM
        }
        //#endif
      }
      //#if MC_SYSTEM
      //     }
      //#endif
      // TODO:10121 QUICPay、iD 202404実装対象外
      //   if(rcChk_Crdt_KeyOpt()) {
      //     err_no = rcATCT_Proc_Error(1);
      //     if(err_no)
      //       return(err_no);
      //   }
      //
      //   #if !MC_SYSTEM
      //   if((! cm_nttasp_system()) && (rcChk_Crdt_User() == KANSUP_CRDT)) {
      // if(rcChk_HoldCrdt_KeyOpt()) {
      // err_no = rcATCT_Proc_Error(1);
      // if(err_no)
      // return(err_no);
      // }
      // }
      // if((! cm_nttasp_system()) && (rcChk_Crdt_User() == KASUMI_CRDT)) {
      // if(rcChk_OffCrdt_KeyOpt()) {
      // err_no = rcATCT_Proc_Error(1);
      // if(err_no)
      // return(err_no);
      // }
      // }
      // #endif
      // if((rcCheckEntryCrdtMode() == TRUE)	||
      // (rcCheckEntryCrdtSystem()))
      // {   /* 置数クレジット宣言仕様 */
      // if(rcGetCrdtPayAmount() != 0) {     /* クレジット預かり済み？ */
      // if(rcChk_CrdtReJect_KeyOpt()) {
      // err_no = MSG_CREDT_ONCE;
      // return(err_no);
      // }
      // }
      // }
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    //     if(rcChk_Edy_KeyOpt()) {
    //       err_no = rcATCT_Proc_Error(1);
    //       if(err_no)
    //         return(err_no);
    //       if(TRAN1_AMT <= 0)
    //         return(MSG_OPEMISS);
    //       if(! (rcRG_OpeModeChk() || rcTR_OpeModeChk()))
    //         return(MSG_OPEMISS);
    //       if( C_BUF->edy_seterr_flg != 0 )
    //         return(MSG_CANNOT_PAY_EDY);
    //       if(! (C_BUF->db_trm.felica_wr_another_card)) { /* 別カード書込み仕様時はチェックなし */
    //         if(rcFeliCa_Fcl_MbrType_Chk() == 2)     /* SP/VT 会員呼出し済み */
    //           return(MSG_NOOPEERR);
    //       }
    //     }
    //     if(rcChk_Edy_KeyOpt2()) {
    //       if( RC_INFO_MEM->RC_CNCT.CNCT_CARD_CNCT == 0 )
    //         return(MSG_CANNOT_PAY_EDY);
    //     }
    //
    //     #if MC_SYSTEM
    //     if(rcChk_Mc_System() && rcChk_Crdt_KeyOpt()) {
    //     err_no = rcATCT_Proc_Error(1);
    //     if(err_no)
    //     return(err_no);
    //     }
    //     #endif
    //     #if CN_NSC
    //     if(rcChk_NSC_System()) {
    //     err_no = rcATCT_Proc_Error(1);
    //     if(err_no)
    //     return(err_no);
    //     }
    //     #endif
    //
    //     #if SIMPLE_2STAFF
    // //   if((C_BUF->db_trm.frc_clk_flg == 2) && (rcKy_Self() == KY_DUALCSHR))
    //     if((C_BUF->db_trm.frc_clk_flg == 2) && (rcKy_Self() == KY_DUALCSHR) && (! rcCheck_QCJC_FrcClk_System()))
    //     {
    //     if(C_BUF->db_staffopen.cshr_status == 0)
    //     {
    //     return MSG_CSHRCLOSE;
    //     }
    //     if(C_BUF->db_staffopen.chkr_status == 0)
    //     {
    //     return MSG_CHKRCLOSE;
    //     }
    //     }
    //     #endif
    //
    // //   if((rcKy_Self() != KY_CHECKER     ) &&
    //     if(((rcKy_Self() != KY_CHECKER) || (rcCheck_QCJC_System())) &&
    //     (C_BUF->db_trm.seikatsuclub_ope) &&
    //     (CMEM->stat.FncCode == KY_CHA1 ) )
    //     {
    //     if(MEM->tTtllog.t100700.mbr_input == NON_INPUT)
    //     {
    //     return MSG_CALL_UNION;
    //     }
    //     else
    //     {
    //     if(MEM->tTtllog.t100700Sts.ctrbution_typ == 0)
    //     {
    //     return MSG_CASH_UNION;
    //     }
    //     }
    //     }
    //     if(C_BUF->db_trm.original_card_ope && AT_SING->limit_flg == 0 && rcChk_Crdt_KeyOpt())
    //     return MSG_CARDKINDERR;
    //
    //     if(rcChk_Suica_KeyOpt()) {
    //     if(rxCalc_Stl_Tax_Amt(MEM) > 99999)
    //     return(MSG_TEXT21);
    //     if((MEM->tTtllog.t100001Sts.sptend_cnt != 0) && (rcChk_MultiSuica_item()))
    //     return(MSG_OPEMISS);
    //     if(rxCalc_Stl_Tax_Amt(MEM) == 0)
    //     return(MSG_TEXT21);
    //     if(MEM->tmpbuf.multi_timeout == 2)
    //     {
    //     if (rcQC_Chk_Qcashier_System())
    //     {
    //     return(MSG_TEXT99); // 処理未了が発生しました。処理未了の処理を行ってください
    //     }
    //     else
    //     {
    //     return(MSG_OPEMISS);
    //     }
    //     }
    //     if(MEM->tTtllog.t100001Sts.sptend_cnt > 8)
    //     return(MSG_OPEMISS);
    //     }
    //
    //     if(rcChk_SPVT_KeyOpt()) {
    //     err_no = rcATCT_Proc_Error(1);
    //     if(err_no)
    //     return(err_no);
    //     if(PAY_PRICE <= 0)
    //     return(MSG_OPEMISS);
    //     if(rcChk_Ten_On())
    //     return(MSG_OPEMISS);
    //     if(! (C_BUF->db_trm.felica_wr_another_card)) { /* 別カード書込み仕様時はチェックなし */
    //     if(rcFeliCa_Fcl_MbrType_Chk() == 1)     /* Edy 会員呼出し済み */
    //     return(MSG_NOOPEERR);
    //     }
    //     }
    //
    //     if(rcChk_MultiEdy_KeyOpt()) {
    //     err_no = rcATCT_Proc_Error(1);
    //     if(err_no)
    //     return(err_no);
    //     if(rcVD_OpeModeChk())
    //     return(MSG_OPEMISS);
    //     if(PAY_PRICE <= 0)
    //     return(MSG_OPEMISS);
    //     if (rcChk_MultiEdy_System() == EDY_VEGA_USE)
    //     {
    //     if (C_BUF->edy_seterr_flg == 3)
    //     {
    //     TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, "C_BUF->edy_seterr_flg == 3 !!\n");
    //     return (MSG_CANNOT_PAY_EDY);
    //     }
    //     else if ( PAY_PRICE >= 1000000L )
    //     {
    //     return (MSG_TEXT21);
    //     }
    //     else if ( (PAY_PRICE > 50000L) && rcTR_OpeModeChk() )
    //     {     // OCXがコマンドパラメータエラーを返す為
    //     return (MSG_TEXT21);
    //     }
    //     else if ( !rcky_cha_edy_receipt_check() )
    //     {
    //     if (rcChk_Sptend_crdt_enble_flg())
    //     {
    //     if ( !rcCheck_ESVoidI_Mode() && !rcCheck_ESVoidS_Mode() )
    //     {
    //     return (MSG_HC2_USE_TOGETHER_ERR);
    //     }
    //     }
    //     }
    //     }
    //     }
    //
    //     if (rcChk_MultiEdy_System() == EDY_VEGA_USE)
    //     {
    //     if (C_BUF->edy_seterr_flg == 3)
    //     {
    //     err_no = rcATCT_Proc_Error(1);
    //     if (err_no)
    //     {
    //     return (err_no);
    //     }
    //
    //     rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    //     if (    (KOPTTRAN.crdt_enble_flg ==  1)
    //     || (KOPTTRAN.crdt_typ       != 18) )
    //     {
    //     TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, "C_BUF->edy_seterr_flg == 3 !!\n");
    //     return (MSG_CANNOT_PAY_EDY);
    //     }
    //     }
    //
    //     if (rcky_cha_edy_receipt_check())
    //     {
    //     rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    //     if (    (KOPTTRAN.crdt_enble_flg ==  1)
    //     && (KOPTTRAN.crdt_typ       != 18) )
    //     {
    //     if ( !rcCheck_ESVoidI_Mode() && !rcCheck_ESVoidS_Mode() )
    //     {
    //     return (MSG_HC2_USE_TOGETHER_ERR);
    //     }
    //     }
    //     }
    //     }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 下記if文のrcChk_MultiSuica_KeyOpt と　rcChk_MultiSuica_KeyOptは対象外のためスキップ
    // if((rcChk_MultiQP_KeyOpt()) || (rcChk_MultiiD_KeyOpt()) || (rcChk_MultiPiTaPa_KeyOpt()) || (rcChk_MultiSuica_KeyOpt())) {
    if ((await rcChkMultiQPKeyOpt()) || (await rcChkMultiiDKeyOpt())) {
      //#if ARCS_MBR
      if (await RcSysChk.rcChkNTTDPrecaSystem()) {
        // TODO:10121 QUICPay、iD 202404実装対象外
        // if(rcCheck_Preca_Deposit_Item()) {
        //   return(MSG_CHARGE_INVALID);
        // }
        // if(((rcChk_CrdtReceipt(0) == TRUE)  ||
        //     (rcChk_Cha9Receipt()  !=   -1)  ||
        //     (rcChk_iDReceipt()    !=   -1)  ||
        //     (rcChk_PrepaidReceipt() != -1)  ||
        //     (rcChk_QUICPayReceipt() != -1)) &&
        //     ((! rcCheck_ESVoidI_Mode()) && (! rcCheck_ESVoidS_Mode()))) {
        //   return(MSG_CREDT_ONCE);
        // }
      } else
      //#endif
      if (await RcSysChk.rcChkTRKPrecaSystem()) {
        // TODO:10121 QUICPay、iD 202404実装対象外
        // if(rcCheck_TRK_Preca_Deposit_Item(1)) {
        //   return(MSG_CHARGE_INVALID);
        // }
        // /* プリペイド取引チェック */
        // if( rcChk_Sptend_preca_enble_flg() &&
        //     ((! rcCheck_ESVoidI_Mode()) && (! rcCheck_ESVoidS_Mode()))) {
        //   return(MSG_PRECA_TOGETHER_ERR);
        // }
      }
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(rcChk_Repica_System()) {
      //   if(rcCheck_Repica_Deposit_Item(1)) {
      //     return(MSG_CHARGE_INVALID);
      //   }
      //   /* プリペイド取引チェック */
      //   if( rcChk_Sptend_preca_enble_flg() &&
      //       ((! rcCheck_ESVoidI_Mode()) && (! rcCheck_ESVoidS_Mode()))) {
      //     return(MSG_PRECA_TOGETHER_ERR);
      //   }
      // }
      //
      // if(rcChk_Cogca_System()) {
      //   if(rcCheck_Cogca_Deposit_Item(1)) {
      //     return(MSG_CHARGE_INVALID);
      //   }
      //   /* プリペイド取引チェック */
      //   if( rcChk_Sptend_preca_enble_flg() &&
      //       ((! rcCheck_ESVoidI_Mode()) && (! rcCheck_ESVoidS_Mode()))) {
      //     return(MSG_PRECA_TOGETHER_ERR);
      //   }
      // }
      //
      // if(rcChk_ValueCard_System())
      // {
      //   if(rcCheck_ValueCard_Deposit_Item(1))
      //   {
      //     return(MSG_CHARGE_INVALID);
      //   }
      //   /* プリペイド取引チェック */
      //   if( rcChk_Sptend_preca_enble_flg() &&
      //       ((! rcCheck_ESVoidI_Mode()) && (! rcCheck_ESVoidS_Mode())))
      //   {
      //     return(MSG_PRECA_TOGETHER_ERR);
      //   }
      // }
      //
      // if(rcChk_Ajs_Emoney_System())
      // {
      //   if(rcCheck_Ajs_Emoney_Deposit_Item(1))
      //   {
      //     return(MSG_CHARGE_INVALID);
      //   }
      //   if( rcChk_Sptend_preca_enble_flg() &&
      //       ((! rcCheck_ESVoidI_Mode()) && (! rcCheck_ESVoidS_Mode())))
      //   {
      //     return(MSG_PRECA_TOGETHER_ERR);
      //   }
      // }

      if (await RcSysChk.rcChkBarcodePaySystem() != 0) {
        // TODO:10121 QUICPay、iD 202404実装対象外
        // if(rcChk_Barcode_Pay_Deposit_Item(1))
        // {
        //   return(MSG_CHARGE_INVALID);
        // }
        // /* プリペイド取引チェック */
        // if( rcChk_Sptend_preca_enble_flg() &&
        //     ((! rcCheck_ESVoidI_Mode()) && (! rcCheck_ESVoidS_Mode())))
        // {
        //   return(MSG_HC2_USE_TOGETHER_ERR);
        // }
      }

      // TODO:10121 QUICPay、iD 202404実装対象外
      // if (rcChk_MultiVega_System())
      // {
      //   if (    (rcChk_Sptend_crdt_enble_flg())
      //       && ( !rcCheck_ESVoidI_Mode() && !rcCheck_ESVoidS_Mode() ) )
      //   {
      //     return (MSG_HC2_USE_TOGETHER_ERR);
      //   }
      // }

      errNo = await RcAtct.rcAtctProcError2(1);
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(err_no)
      //   return(err_no);
      // if(rcVD_OpeModeChk() && (!rcChk_MultiSuica_KeyOpt()))
      //   return(MSG_OPEMISS);
      // if((PAY_PRICE <= 0) && (!rcChk_MultiSuica_KeyOpt()))
      //   return(MSG_OPEMISS);
      // if(rcChk_Ten_On() && (!(rcChk_MultiSuica_KeyOpt() && rcVD_OpeModeChk())))
      //   return(MSG_OPEMISS);

      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(rcChk_MultiSuica_KeyOpt()) {
      //   if(MEM->tmpbuf.multi_timeout == 2)
      //   {
      //     if(rcQC_Chk_Qcashier_System())
      //     {
      //       return(MSG_TEXT99);
      //     }
      //     else
      //     {
      //       return(MSG_OPEMISS);
      //     }
      //   }
      //   if(rxCalc_Stl_Tax_Amt(MEM) > 99999)
      //     return(MSG_TEXT21);
      //   if((MEM->tTtllog.t100001Sts.sptend_cnt != 0)
      //       && (rcChk_MultiSuica_item())
      //       && (rcChk_MultiSuica_System() != SUICA_VEGA_USE))
      //     return(MSG_OPEMISS);
      //   if(MEM->tTtllog.t100001Sts.sptend_cnt > 8)
      //     return(MSG_OPEMISS);
      //   if(rxCalc_Stl_Tax_Amt(MEM) <= 0)
      //     return(MSG_TEXT21);
      // }
      errNo = await rcCheckRalseLimit();
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(err_no)
      //   return(err_no);
    }

    //実装は必要だがARKS対応では除外
    // if((cm_PFM_JR_IC_Charge_system() || cm_Suica_Charge_system()) && MEM->tmpbuf.multi_timeout == 1) {
    //   if(!rcChk_ChargeSuica_KeyOpt())
    //     return(MSG_OPEMISS);
    // }
    if (rcChkChargeSuicaKeyOpt()) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(rcVD_OpeModeChk()) {
      //   if(!((MEM->tmpbuf.multi_timeout == 1) || ((cm_PFM_JR_IC_Charge_system() || cm_Suica_Charge_system()) && rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 0)))
      //     return(MSG_OPEMISS);
      // }
      // else {
      //   if(MEM->tmpbuf.multi_timeout != 1)
      //     return(MSG_OPEMISS);
      // }
    } else {
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if((cm_PFM_JR_IC_Charge_system() || cm_Suica_Charge_system()) && (rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 0))
      //   return(MSG_OPEMISS);
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    //     if (rcChargeAmount1_ChcNoCnctCatKeyOpt(CMEM->stat.FncCode))
    //     {
    //       return(MSG_OPEMISS);
    //     }
    //     #if PW410_SYSTEM
    //     if(rcChk_AbsPrepaid_KeyOpt()) {
    //     err_no = rcATCT_Proc_Error(1);
    //     if(err_no)
    //     return(err_no);
    // //      if(! rcRG_OpeModeChk())
    //     if(! (rcRG_OpeModeChk() || rcTR_OpeModeChk()))
    // //         return(MSG_OPEMISS);
    //     return(MSG_INVALIDKEY);
    //     if(PAY_PRICE <= 0)
    //     return(MSG_OPEMISS);
    //     if(PAY_PRICE > 999999)
    //     return(MSG_OPEMISS);
    // //      if(rcChk_Ten_On())
    // //         return(MSG_OPEMISS);
    //     }
    //     #endif
    //
    //     if(rcChk_Custreal_Webser_System()) {
    //     err_no = rcATCT_Proc_Error(1);
    //     if(err_no)
    //     return(err_no);
    //     if((CMEM->stat.FncCode == rcmbr_GetManualRbtKeyCd()) && (MEM->tTtllog.t100701.dupt_ttlrv != 0))
    //     return(MSG_OPEMISS);
    //     }
    //
    //     if((rcChk_Crdt_User() == KASUMI_CRDT) && ((CMEM->stat.FncCode == KY_CHA7) || (CMEM->stat.FncCode == KY_CHA9))) {
    //     err_no = rcCheck_OutMdlTran_Detail(CMEM->stat.FncCode);
    //     if(err_no)
    //     return(err_no);
    //     }
    //
    //     /* 2007/04/26 >>> */
    //     if( C_BUF->db_trm.nontax_cha10 )
    //     {
    //     if( CMEM->stat.FncCode == KY_CHA10 )
    //     {
    //     if( ( rcChk_Ten_On( )              ) ||
    //     ( MEM->tTtllog.t100001Sts.sptend_cnt != 0 ) )
    //     {
    //     return( MSG_OPEERR );
    //     }
    //     else if(( rxCalc_In_Tax_Amt(MEM) == 0 ) ||
    //     ( rcSR_OpeModeChk( )           ))
    //     {
    //     return( MSG_INVALIDKEY );
    //     }
    //     }
    //     }
    //     /* <<< 2007/04/26 */
    //     else if(cm_tax_free_system())        /* 免税機能 */
    //     {
    //     if(rcChk_TaxFree_KeyOpt(CMEM->stat.FncCode))
    //     {
    //     if(( rcChk_Ten_On( ) ) ||
    //     ( MEM->tTtllog.t100001Sts.sptend_cnt != 0 ) )
    //     {
    //     return( MSG_OPEERR );
    //     }
    //     else if((( rxCalc_In_Tax_Amt(MEM) == 0 ) &&
    //     ( rxCalc_Ex_Tax_Amt(MEM) == 0 )) ||
    //     ( rcSR_OpeModeChk( ) ))
    //     {
    //     return( MSG_INVALIDKEY );
    //     }
    //     }
    //     }
    //
    //     if( rcChargeStop() )
    //     {
    //     return(MSG_INVALIDKEY);
    //     }
    //
    //     #if CUSTREALSVR
    //     if( rcChk_Custrealsvr_System() || rcChk_Custreal_Nec_System(0) ) {
    //     if ((CustRealSvr_WaitChk()) || (rcMcd_MbrWaitChk())) {
    //     return( MSG_MBRINQUIR );
    //     }
    //     }
    //     #endif
    //     if( rcChk_Assort_System() && CMEM->assort.flg ) {
    //     return (MSG_OPEERR);
    //     }
    //
    //     if( (C_BUF->db_trm.disable_split_qc_ticket) && (MEM->prnrbuf.speeza_qr_print_flg == 1) && (cm_Receipt_QR_system()) ) {
    //     return (MSG_QR_NOTUSE_SPLIT);
    //     }
    //
    //     if( cm_UT_cnct_system() ) {
    //     err_no = rcATCT_Proc_Error(1);
    //     if( err_no )
    //     return(err_no);
    //
    //     if( CMEM->stat.FncCode == KY_CHA2 ){
    //     if( ( rcChk_Ten_On( )              ) ||
    //     ( MEM->tTtllog.t100001Sts.sptend_cnt != 0 ) ){
    //     return( MSG_OPEMISS );
    //     }
    //     }
    //     }
    //
    //     if(cm_sp_department_system() && (CMEM->stat.FncCode == KY_CHA3)) {
    //     err_no = rcATCT_Proc_Error(1);
    //     if(err_no)
    //     return(err_no);
    //     }

    //#if ARCS_MBR
    if (await RcSysChk.rcChkNTTDPrecaSystem()) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(rcCheck_Preca_Deposit_Item())
      //   return (MSG_CHARGE_INVALID);
      // if(rcChk_Preca_KeyOpt()) {
      //   if(! rcCheck_Mbr_Input() )
      //     return ( MSG_CALL_RLSMBR );
      //   if( MEM->tmpbuf.work_in_type == 1 )
      //     err_no = rcATCT_Proc_Error(1);
      //   else
      //     err_no = MSG_PLS_SLCT_BIZ_TYPE;
      //   if( err_no )
      //     return ( err_no );
      //   else {
      //     if(((rcChk_CrdtReceipt(0) == TRUE) ||
      //         (rcChk_Cha9Receipt()    != -1) ||
      //         (rcChk_iDReceipt() != -1)      ||
      //         (rcChk_PrepaidReceipt() != -1) ||
      //         (rcChk_QUICPayReceipt() != -1)   ) &&
      //         ((! rcCheck_ESVoidI_Mode()) && (! rcCheck_ESVoidS_Mode())))
      //       return( MSG_CREDT_ONCE );
      //   }
      // }
    } else
    //#endif
    if (await RcSysChk.rcChkTRKPrecaSystem()) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(rcCheck_TRK_Preca_Deposit_Item(1))
      //   return (MSG_CHARGE_INVALID);
      // if(rcChk_Preca_KeyOpt()) {
      //   if( MEM->tmpbuf.work_in_type == 1 )
      //     err_no = rcATCT_Proc_Error(1);
      //   else if(rcChk_Sptend_crdt_enble_flg())
      //     err_no = MSG_PREPAID_INVALID;
      //   else
      //     err_no = MSG_PRECA_IN_ERR;
      //   if( err_no )
      //     return ( err_no );
      // }
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(rcChk_Repica_System()) {
    //   rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    // if(rcCheck_Repica_Deposit_Item(1))
    // return (MSG_CHARGE_INVALID);
    // if(rcChk_Preca_KeyOpt()) {
    // if( MEM->tmpbuf.work_in_type == 1 )
    // err_no = rcATCT_Proc_Error(1);
    // else if(rcChk_Sptend_crdt_enble_flg())
    // err_no = MSG_PREPAID_INVALID;
    // else
    // err_no = MSG_PRECA_IN_ERR;
    // if( err_no )
    // return ( err_no );
    // }
    // else if ( ( KOPTTRAN.crdt_enble_flg == 1)
    // &&( rcChk_Sptend_crdt_enble_flg()))
    // {
    // /* すでにレピカ支払あれば、掛売あり取引は不可 */
    // return(MSG_PRECA_TOGETHER_ERR);
    // }
    // }
    //
    // if(rcChk_Cogca_System()) {
    // rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    // if(rcCheck_Cogca_Deposit_Item(1))
    // return (MSG_CHARGE_INVALID);
    // if(rcChk_Preca_KeyOpt()) {
    // if( MEM->tmpbuf.work_in_type == 1 )
    // err_no = rcATCT_Proc_Error(1);
    // else if((KOPTTRAN.frc_stlky_flg) &&
    // #if SELF_GATE
    // (! rcSG_Chk_SelfGate_System()) &&
    // #endif
    // (! rcQC_Chk_Qcashier_System()) &&
    // #if !MC_SYSTEM
    // (! rcCheck_Crdt_Mode())   &&
    // #endif
    // (! rcCheck_ChgCin_Mode()) &&
    // (! rcCheck_SpritMode())   &&
    // (! rcCheck_Stl_Mode())    &&
    // (! rcCheck_Wiz()) ) {
    // err_no = MSG_SUBTTLFCE;
    // }
    // else if(rcChk_Sptend_crdt_enble_flg())
    // err_no = MSG_PREPAID_INVALID;
    // else
    // err_no = MSG_PRECA_IN_ERR;
    // if( err_no )
    // return ( err_no );
    // }
    // else if((KOPTTRAN.crdt_enble_flg == 1) && rcChk_Sptend_preca_enble_flg())
    // {	/* すでにCoGCa支払あれば、掛売あり取引は不可 */
    // return(MSG_PRECA_TOGETHER_ERR);
    // }
    // }
    //
    // if(rcChk_ValueCard_System())
    // {
    // rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    // if(rcCheck_ValueCard_Deposit_Item(1))
    // {
    // return (MSG_CHARGE_INVALID);
    // }
    // if(rcChk_Preca_KeyOpt())
    // {
    // if( MEM->tmpbuf.work_in_type == 1 )
    // {
    // err_no = rcATCT_Proc_Error(1);
    // }
    // else if((KOPTTRAN.frc_stlky_flg) &&
    // #if SELF_GATE
    // (! rcSG_Chk_SelfGate_System()) &&
    // #endif
    // (! rcQC_Chk_Qcashier_System()) &&
    // #if !MC_SYSTEM
    // (! rcCheck_Crdt_Mode())   &&
    // #endif
    // (! rcCheck_ChgCin_Mode()) &&
    // (! rcCheck_SpritMode())   &&
    // (! rcCheck_Stl_Mode())    &&
    // (! rcCheck_Wiz()) )
    // {
    // err_no = MSG_SUBTTLFCE;
    // }
    // else if(rcChk_Sptend_crdt_enble_flg())
    // {
    // err_no = MSG_PREPAID_INVALID;
    // }
    // else
    // {
    // err_no = MSG_PRECA_IN_ERR;
    // }
    // if( err_no )
    // {
    // return ( err_no );
    // }
    // }
    // else if ((KOPTTRAN.crdt_enble_flg == 1) && rcChk_Sptend_preca_enble_flg())
    // {	/* すでにバリューカード支払あれば、掛売あり取引は不可 */
    // return (MSG_PRECA_TOGETHER_ERR);
    // }
    // }
    //
    // if(rcChk_Ytrm_System())
    // {
    // err_no = rcATCT_Proc_Error(1);
    // if(err_no)
    // {
    // return(err_no);
    // }
    // else
    // {
    // if((rcChk_CrdtReceipt(0) == TRUE)
    // && ((! rcCheck_ESVoidI_Mode())
    // && (! rcCheck_ESVoidS_Mode())))
    // {
    // return(MSG_JMUPS_ONETIME_ONLY);
    // }
    // }
    // }
    //
    // if(rcChk_Ajs_Emoney_System())
    // {
    // rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    // if(rcCheck_Ajs_Emoney_Deposit_Item(1))
    // {
    // return (MSG_CHARGE_INVALID);
    // }
    // if(rcChk_Preca_KeyOpt())
    // {
    // if( MEM->tmpbuf.work_in_type == 1 )
    // {
    // err_no = rcATCT_Proc_Error(1);
    // }
    // else if((KOPTTRAN.frc_stlky_flg) &&
    // #if SELF_GATE
    // (! rcSG_Chk_SelfGate_System()) &&
    // #endif
    // (! rcQC_Chk_Qcashier_System()) &&
    // #if !MC_SYSTEM
    // (! rcCheck_Crdt_Mode())   &&
    // #endif
    // (! rcCheck_ChgCin_Mode()) &&
    // (! rcCheck_SpritMode())   &&
    // (! rcCheck_Stl_Mode())    &&
    // (! rcCheck_Wiz()) )
    // {
    // err_no = MSG_SUBTTLFCE;
    // }
    // else if(rcChk_Sptend_crdt_enble_flg())
    // {
    // err_no = MSG_PREPAID_INVALID;
    // }
    // else
    // {
    // if ((cm_ds2_godai_system())
    // && (rcmbrChkCust()))
    // err_no = MSG_PRECA_IN_ERR_RETRY;
    // else
    // err_no = MSG_PRECA_IN_ERR;
    // }
    // if( err_no )
    // {
    // return ( err_no );
    // }
    // }
    // }

    if (await RcSysChk.rcChkBarcodePaySystem() != 0) {
      await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);

      // TODO:10121 QUICPay、iD 202404実装対象外
      //   if(rcChk_Barcode_Pay_Deposit_Item(1))
      //   {
      //     return (MSG_CHARGE_INVALID);
      //   }
      //   if(rcChk_Barcode_Pay_KeyOpt(CMEM->stat.FncCode))
      //   {
      //     err_no = 0;
      //     if(MEM->bcdpay.bar.type)
      //     {	/* スキャン済 */
      //       err_no = rcATCT_Proc_Error(1);
      //     }
      //     else if((KOPTTRAN.frc_stlky_flg) &&
      //         #if SELF_GATE
      //     (! rcSG_Chk_SelfGate_System()) &&
      // #endif
      // (! rcQC_Chk_Qcashier_System()) &&
      // #if !MC_SYSTEM
      // (! rcCheck_Crdt_Mode())   &&
      // #endif
      // (! rcCheck_ChgCin_Mode()) &&
      // (! rcCheck_SpritMode())   &&
      // (! rcCheck_Stl_Mode())    &&
      // (! rcCheck_Wiz()) )
      // {
      // err_no = MSG_SUBTTLFCE;
      // }
      // else if(rcChk_Sptend_crdt_enble_flg())
      // {
      // err_no = MSG_HC2_USE_TOGETHER_ERR;
      // }
      // else
      // {
      // exec_flg = 0;
      // if ((! rcQC_Chk_Qcashier_System()) && (! rcHappySelf_ChkTb1System())) // Qcashier、HappySelfフルセルフ・QCモードはカードチェック処理なし
      //     { // Qcashierの場合はカードを読むタイミングが違うため
      // if ((cm_nimoca_point_system())
      // && ((cm_Suica_system()) || (rcChk_MultiVega_PayMethod(FCL_SUIC))))
      // {
      // if(rcChk_MultiVega_PayMethod(FCL_SUIC))
      // {
      // if ((MEM->tTtllog.t100700.mbr_input == 12)
      // && (rxCalc_Suica_Amt(MEM) == 0)
      // && !(rcCheck_Crdt_Stat())
      // && !((KOPTTRAN.crdt_enble_flg == 1) && (KOPTTRAN.crdt_typ == 26)))
      // {
      // if(TS_BUF->multi.order != FCL_NOT_ORDER)
      // {
      // exec_flg = 0;
      // }
      // else
      // {
      // exec_flg = 1;
      // CustreadExecFlg = 1;
      // }
      // }
      // }
      // else
      // {
      // if((MEM->tTtllog.t100700.mbr_input == 12) && (MEM->tmpbuf.nimoca_point_out == 0) && (rxCalc_Suica_Amt(MEM) == 0) && (!rcCheck_Crdt_Stat())) {
      // if ((TS_BUF->suica.Trans_flg == 1)
      // || (TS_BUF->suica.Trans_flg == 2)
      // || ((TS_BUF->suica.Time_flg == 1)
      // && (!(rcQC_Chk_Qcashier_System()))))
      // {
      // exec_flg = 0;
      // }
      // else if(TS_BUF->suica.order != SUICA_NOT_ORDER)
      // {
      // exec_flg = 0;
      // }
      // else
      // {
      // exec_flg = 1;
      // CustreadExecFlg = 1;
      // }
      // }
      // }
      // }
      // }
      // if (exec_flg == 0)
      // err_no = MSG_PRECA_IN_ERR;
      //
      // snprintf (log, sizeof(log), "%s : to cust read[%d]:[%s](%d) \n", __FUNCTION__, MEM->tTtllog.t100700.mbr_input, MEM->tTtllog.t100700Sts.nimoca_number, CustreadExecFlg);
      // TprLibLogWrite (GetTid (), TPRLOG_NORMAL, 0, log);
      //
      // }
      // if( err_no )
      // {
      // /* エラー時にバーコード情報を消去 */
      // memset(&MEM->bcdpay.bar, 0x00, sizeof(MEM->bcdpay.bar));
      // return ( err_no );
      // }
      // }
      // if (rcChk_Sptend_Barcode_Pay_enble_flg())
      // {
      // return(MSG_HC2_USE_TOGETHER_ERR);
      // }
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    //     if(rcChk_Yamato_KeyOpt()) {
    // /* 掛売の種類：Edy / Suica / WAON / nanaco をチェックしているので、左記ブランドを単独で取扱う場合は、ここより前でチェックするようにして下さい！ */
    //       err_no = rcATCT_Proc_Error(1);
    //       if(err_no)
    //         return(err_no);
    //     }
    //
    //     if(rcChk_Jmups_KeyOpt()) {
    //       err_no = rcATCT_Proc_Error(1);
    //       if(err_no)
    //         return(err_no);
    //     }
    //
    //     if((rxChkKopt_CrdtType_Slip(C_BUF, CMEM->stat.FncCode)) && (C_BUF->db_trm.kamado_stldsc_cha1_func) && (CMEM->stat.FncCode == KY_CHA1)){
    //       err_no = rcATCT_Proc_Error(1);
    //       if(err_no)
    //         return(err_no);
    //
    //       TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "auto stldsc err(sptend)\n");
    //       if( ( MEM->tTtllog.t100001Sts.sptend_cnt != 0 ) ){
    //         return( MSG_OPEMISS );
    //       }
    //     }
    //
    //     if(rcChk_ChargeSlip_KeyOpt()){
    //       err_no = rcATCT_Proc_Error(1);
    //       if(err_no)
    //         return err_no;
    //
    //       if(!(rcTR_OpeModeChk() || rcRG_OpeModeChk() || rcVD_OpeModeChk()))
    //         return MSG_OPEMISS;	/* この操作は行えません */
    //
    //       if(! rcCheck_Mbr_Input() )	/* 顧客を読んでいない */
    //         return MSG_READ_MBRCARD;	/* 会員カードを読ませて下さい */
    //
    //       if( MEM->prnrbuf.charge_slip_flg == 0 )	/* 売掛会員ではない */
    //         return MSG_READ_MBRCARD;	/* 会員カードを読ませて下さい */
    //
    //       if( (cm_Reserv_system() || cm_netDoAreserv_system()) && rcreserv_ReceiptCall() && !rcCheck_ReservMode() ){	/* 予約 */
    // //          if( strlen(MEM->tmpbuf.tTtllog.t100001.reserv_no) ) {	/* 予約を呼び出した */
    //         if( MEM->tTtllog.t600000.advance_money != 0 ) {	/* 呼び出した予約が内金あり */
    //           return MSG_OPEMISS;
    //         }
    //       }
    //
    //       if( rcChkMember_ChargeSlipCard() == FALSE )
    //         return MSG_READ_MBRCARD;	/* 会員カードを読ませて下さい */
    //
    //       if( ( rcChk_Ten_On( )              ) ||	/* 置数中*/
    //           ( MEM->tTtllog.t100001Sts.sptend_cnt != 0 ) ){	/* スプリットは１回か？ */
    //         return MSG_OPEMISS;	/* この操作は行えません */
    //       }
    //     }
    //
    //     if(cm_nimoca_point_system() && (MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT)) {
    //       err_no = rcATCT_Proc_Error(1);
    //       if(err_no)
    //         return(err_no);
    //       else if(TS_BUF->suica.order != SUICA_NOT_ORDER) {
    //         if((TS_BUF->suica.Trans_flg == 1) || (TS_BUF->suica.Trans_flg == 2))
    //           return (MSG_BUSY_FCLDLL);
    //         else
    //           return (MSG_TEXT14);
    //       }
    //     }
    //
    //     if (rcChk_Tpoint_System())
    //     {
    //       err_no = rcATCT_Proc_Error(1);
    //       if (err_no)
    //       {
    //         return(err_no);
    //       }
    //       #if 0
    //       if ((CMEM->stat.FncCode == rcmbr_GetManualRbtKeyCd()) && (MEM->tTtllog.t100701.dupt_ttlrv != 0))
    //     {
    //     return(MSG_OPEMISS);
    //     }
    //     #endif
    //     }
    //
    //     if(rc_TaxFree_Chk_TaxFreeIn())	/* 免税宣言中 */
    //     {
    //     if( (rcCheck_reserv_KeyOpt())	      /* 予約・見積りは使用不可 */
    //     || (rcCheck_estimate_KeyOpt())
    //     || (rcCheck_reserv_delivery_KeyOpt())
    //     || (rcCheck_reserv_credit_KeyOpt()) )
    //     {
    //     return (MSG_INVALIDKEY);
    //     }
    //     }
    //
    //     if (cm_ds2_godai_system())	/* ゴダイ様特注 */
    //     {
    //     if (MEM->tTtllog.t100002.quotation_flg)
    //     {
    //     if (OK != rcKyQuotation_CheckPayKey(CMEM->stat.FncCode))	/* 見積宣言時は売掛伝票、予約(見積り)のみ有効 */
    //     {
    //     return (MSG_QUO_PAYKEY_ERR);
    //     }
    //     }
    //     else
    //     {
    //     rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    //     if (   (KOPTTRAN.crdt_enble_flg)
    //     && (   (KOPTTRAN.crdt_typ == SPTEND_STATUS_URIKAKE) )		/* 売掛伝票 */
    //     || (KOPTTRAN.crdt_typ == SPTEND_STATUS_RESERV_ESTIMATE) )	/* 予約(見積り) */
    //     {
    //     return (MSG_NOQUO_URIKAKE_ERR);		/* このキーは見積宣言時のみ利用できます。 */
    //     }
    //     if (   (cm_Reserv_system() == GODAI_RESERV)		/* 締めキー「予約(見積り)」のみ予約承認キー無しで動かす */
    //     && (KOPTTRAN.crdt_enble_flg)
    //     && (   (KOPTTRAN.crdt_typ == SPTEND_STATUS_RESERV)			/* 予約 */
    //     || (KOPTTRAN.crdt_typ == SPTEND_STATUS_RESERV_CREDIT)		/* 予約(掛売り) */
    //     || (KOPTTRAN.crdt_typ == SPTEND_STATUS_RESERV_DELIVERY) ) )	/* 予約(配達) */
    //     {
    //     return (MSG_CANNOT_KEY_SET);
    //     }
    //     }
    //     }
    //
    //     if(cm_Barcode_Pay_Charge_system())
    //     {
    //     if(rcChk_Barcode_Pay_Deposit_Item(1))
    //     {
    //     return (MSG_CHARGE_INVALID);
    //     }
    //     }
    //
    //     if((rcChk_dPoint_System())
    //     && (rcChk_dPointUseKey())
    //     && (AT_SING->dpoint_recrsplit_flg == 0))
    //     {
    //     err_no = rcATCT_Proc_Error(1);
    //     if(err_no)
    //     {
    //     return(err_no);
    //     }
    //     }
    //
    //     if( rcsyschk_repica_point_system() )
    //     {
    //     rcRead_kopttran( CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN) );
    //
    //     if( rcCheck_Repica_Deposit_Item(1) )
    //     {
    //     return( MSG_CHARGE_INVALID );		// チャージ取引は出来ません
    //     }
    //
    //     if( rcChk_RepicaPoint_KeyOpt() )
    //     {
    //     if( MEM->tmpbuf.work_in_type == 1 )
    //     {
    //     err_no = rcATCT_Proc_Error( 1 );
    //     }
    //     else
    //     {
    //     err_no = MSG_PRECA_IN_ERR;
    //     }
    //
    //     if( err_no )
    //     {
    //     return( err_no );
    //     }
    //     }
    //     else if( ( KOPTTRAN.crdt_enble_flg == 0 )
    //     &&( KOPTTRAN.crdt_typ == 39 ) )
    //     {	/* 既にプリカポイント支払がある場合は取引不可 */
    //     return( MSG_CCT_USEPNT_AGAIN );
    //     }
    //     }
    //
    // switch( rxmbrcom_ManualRbtKey_PointKind(CMEM->stat.FncCode, C_BUF) )
    //     {
    //   case PNTTYPE_RPOINT:	/* 楽天ポイント利用会計/品券キー */
    //     if( rcsyschk_Rpoint_System() )
    //     {
    //       err_no = rcATCT_Proc_Error(1);
    //       if( err_no )
    //       {
    //         return( err_no );
    //       }
    //     }
    //     break;
    //   case PNTTYPE_TPOINT:
    //     if (rcsyschk_Tpoint_System())
    //     {
    //       err_no = rcATCT_Proc_Error(1);
    //       if (err_no)
    //       {
    //         return(err_no);
    //       }
    //     }
    //   default:
    //     break;
    // }
    //
    // // VEGA交通系の処理未了発生時は、特定会計キーでしか決済不可
    // if((rcChk_MultiVega_PayMethod(FCL_SUIC))
    //     && (MEM->tmpbuf.multi_timeout == 2)
    //     && (MEM->mltsuica_alarm_payprc != 0))
    // {
    //   // 交通系用処理未了対応キー以外なら決済不可
    //   rcRead_kopttran(CMEM->stat.FncCode, &KOPTTRAN, sizeof(KOPTTRAN));
    // if(!((KOPTTRAN.crdt_enble_flg == 0) && (KOPTTRAN.crdt_typ == 26)))      // 交通系用処理未了対応キー
    //     {
    // return(MSG_TEXT99);
    // }
    // }
    //
    // if( rcsyschk_pct_connect_system() )
    // {	// pct接続時
    // err_no = rcCheck_PCT_KeyOpt();
    // if( err_no )
    // {
    // return( err_no );
    // }
    // }

    return 0;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_Crdt_KeyOpt
  static bool rcChkCrdtKeyOpt() {
    KopttranBuff koptTran = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();

    RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    return ((koptTran.crdtEnbleFlg == 1) && /* 掛売許可？      */
        (koptTran.crdtTyp == 0)); /* クレジットで使用？*/
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_MultiQP_KeyOpt
  static Future<bool> rcChkMultiQPKeyOpt() async {
    KopttranBuff koptTran = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcChkMultiQPSystem() != 0) {
      //cm_clr((char *)&KOPTTRAN, sizeof(kopttran_buff));
      await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
      return ((koptTran.crdtEnbleFlg == 1) &&
          (koptTran.crdtTyp == 19) &&
          (koptTran.frcEntryFlg == 0) &&
          (koptTran.chkAmt == 0));
    } else {
      return false;
    }
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_MultiiD_KeyOpt
  static Future<bool> rcChkMultiiDKeyOpt() async {
    KopttranBuff koptTran = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcChkMultiiDSystem() != 0) {
      //cm_clr((char *)&KOPTTRAN, sizeof(kopttran_buff));
      await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
      return ((koptTran.crdtEnbleFlg == 1) &&
          (koptTran.crdtTyp == 20) &&
          (koptTran.frcEntryFlg == 0) &&
          (koptTran.chkAmt == 0));
    } else {
      return false;
    }
  }

  /// 関連tprxソース:C:rcky_cha.c - rcCheck_Ralse_Limit
  static Future<int> rcCheckRalseLimit() async {
    KopttranBuff koptTran = KopttranBuff();
    int limitAmt = 0;
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if (RcSysChk.rcChkRalseCardSystem()) {
      //cm_clr((char *)&KOPTTRAN, sizeof(kopttran_buff));
      await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
      limitAmt = koptTran.digit * 10000;
      if (koptTran.crdtEnbleFlg == 1) {
        switch (koptTran.crdtTyp) {
          case 19:
          /* QUICPay */
          case 20:
          /* iD      */
            if (RcCrdtFnc.payPrice() > limitAmt) {
              TprLog().logAdd(
                  Tpraid.TPRAID_CHK,
                  LogLevelDefine.error,
                  "Limit Over !! payAmt[${RcCrdtFnc.payPrice()}]"
                      " limitAmt[{$limitAmt}}]\n");
              errNo = DlgConfirmMsgKind.MSG_CRDT_LIMIT.dlgId;
            }
          default:
            break;
        }
      }
    }
    return errNo;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rcky_cha.c - rcChk_ChargeSuica_KeyOpt
  static bool rcChkChargeSuicaKeyOpt() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_Psp_KeyOpt()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcChkPspKeyOpt() {
    return true;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_Preca_KeyOpt()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcChkPrecaKeyOpt() {
    return true;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_Suica_KeyOpt()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcChkSuicaKeyOpt() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcCheck_reserv_KeyOpt()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcCheckReservKeyOpt() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_ChargeSlip_KeyOpt_Comodi()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcChkChargeSlipKeyOptComodi() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rccha_Hokuno_slip_Msg()
  ////実装は必要だがARKS対応では除外
  static void rcchaHokunoSlipMsg() {
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcky_cha_splitDisableChk()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /*
 * 関数名    ：rcky_cha_splitDisableChk
 * WS様向け会計キーの組み合わせチェック併用できない会計キーの組み合わせの時1を返す
 */
  static bool rckyChaSplitDisableChk() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcky_cha_WSEmoneyChk()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rckyChaWSEmoneyChk() {
    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// プリカポイントのキーオプション設定が正しいか判定する。
  /// 関連tprxソース:C:rcky_cha.c - rcChk_RepicaPoint_KeyOpt
  /// 引数   : なし
  /// 戻り値 : true :キーオプション設定が正しい, false :キーオプション設定が正しくない
  static Future<bool> rcChkRepicaPointKeyOpt() async {
    int tmpbuf = 0;
    int ret = 0;

    AcMem cMem = SystemFunc.readAcMem();
    KopttranBuff koptTran = KopttranBuff();

    if (RcSysChk.rcsyschkRepicaPointSystem()) {
      if (cMem.qrChgKoptFlg == 1) {
        tmpbuf = cMem.qrChgKoptFlg;
        cMem.qrChgKoptFlg = 0;
      }
      //CmAry.cmClr('0',size);
      await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
      if (tmpbuf != 0) {
        cMem.qrChgKoptFlg = tmpbuf;
      }
      if ((koptTran.crdtEnbleFlg == 0) && (koptTran.crdtTyp == 39)) {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_Tuo_KeyOpt()
  //実装は必要だがARKS対応では除外
  static bool rcChkTuoKeyOpt() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_Media_KeyOp()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcChkMediaKeyOpt() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcCheck_estimate_KeyOpt()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcCheckEstimateKeyOpt() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcCheck_reserv_delivery_KeyOpt()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcCheckReservDeliveryKeyOpt() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcCheck_reserv_credit_KeyOpt()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static bool rcCheckReservCreditKeyOpt() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChargeAmount21()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static void rcChargeAmount21() {
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c - rcky_cha_vesca_keyopt_check()
  static int rckyChaVescaKeyoptCheck(){
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 従業員番号入力画面表示（マミーマート様向け仕様）
  /// 関連tprxソース:C:rcky_cha.c - rcCheck_Get_StaffNo()
  /// 引数   : なし
  /// 戻り値 : true :表示する, false :表示しない
  static bool rcCheckGetStaffNo() {
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcky_Campaign_discount()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static void rckyCampaignDiscount() {
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcky_cha_cctStlAmtOnlyChk
  static Future<bool> rckyChaCctStlAmtOnlyChk(int typ) async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "rckyChaCctStlAmtOnlyChk() rxMemRead error\n");
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    KopttranBuff koptTran = KopttranBuff();

    // TODO:00012 平野 cm_clrの使用方法について確認してから実装する。
    //cm_clr((char *)&KOPTTRAN, sizeof(kopttran_buff));
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);

    if ((RcSysChk.rcChkINFOXProcess()) ||
        (RcSysChk.rcChkJETBProcess()) ||
        (RcSysChk.rcChkJETAStandardProcess()) ||
        (RcSysChk.rcsyschkVescaSystem())) {
      if ((await CmCksys.cmZHQSystem() != 0) ||
          ((pCom.dbTrm.cctStlamtOnly != 0) && (typ == 0)) ||
          ((pCom.dbTrm.cctOnceOnly != 0) && (typ == 1))) {
        if ((koptTran.crdtEnbleFlg == 1) // 掛売許可
            &&
            ((koptTran.crdtTyp == 0) // クレジット
                ||
                (koptTran.crdtTyp == 1) // デビッド
                ||
                (koptTran.crdtTyp == 2) // Edy
                ||
                (koptTran.crdtTyp == 5) // iD
                ||
                ((koptTran.crdtTyp == 6) // プリペイド
                    &&
                    (RcSysChk.rcsyschkVescaSystem())) ||
                (koptTran.crdtTyp == 7) // 交通系
                ||
                (koptTran.crdtTyp == 9) // QUICPay
                ||
                ((koptTran.crdtTyp == 10) // PiTaPa
                    &&
                    (RcSysChk.rcChkINFOXProcess())) ||
                (koptTran.crdtTyp == 17) // 銀聯
                ||
                (koptTran.crdtTyp == 21) // WAON
                ||
                (koptTran.crdtTyp == 22) // nanaco
                ||
                (koptTran.crdtTyp == 31) // コード支払(JET-B)(=Alipay)
                ||
                (koptTran.crdtTyp == 36) // NFC
                ||
                (koptTran.crdtTyp == 37) // レピカ
                ||
                (koptTran.crdtTyp ==
                    SPTEND_STATUS_LISTS.SPTEND_STATUS_COCONA.typeCd))) {
          // cocona
          return true;
        }
      }
    }
    return false;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcChk_OffCrdt_Allow
  static Future<bool> rcChkOffCrdtAllow() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (await CmCksys.cmNttaspSystem() != 0) {
      if ((RcSysChk.rcChkCrdtUser()) == Datas.KASUMI_CRDT) {
        if (cMem.working.crdtReg.step == KyCrdtInStep.OFF_KYCHA.cd) {
          return true;
        }
      } else if ((RcSysChk.rcChkCrdtUser()) == Datas.KANSUP_CRDT) {
        //#if SELF_GATE
        if ((await RcSysChk.rcSGChkSelfGateSystem()) ||
            (await RcSysChk.rcNewSGChkNewSelfGateSystem()) ||
            (await RcSysChk.rcChkQuickSelfSystem()) ||
            (await RcSysChk.rcQCChkQcashierSystem())) {
          if ((cMem.working.crdtReg.stat & 0x1000) != 0) {
            return true;
          }
        }
        //#endif
      }
    }
    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rcky_cha.c - rccha_CrdtSignDialog
  static void rcchaCrdtSignDialog() {
    return;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcKyCha_nochg_conf_flg_set(short flg)
  static void rcKyChaNochgCconfFlgSet(int flg) {
    nochgConfFlg = flg;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcKyCha_nochg_conf_flg_get
  static int rcKyChaNochgConfFlgGet() {
    return nochgConfFlg;
  }

  /// 関連tprxソース:C:rcky_cha.c - rcClr_Sprit_Nochg
  static Future<void> rcClrSpritNochg() async {
    AcMem cMem = SystemFunc.readAcMem();

    lEntry = Bcdtol.cmBcdToL(cMem.ent.entry);

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        await rcNoChgAmtMakeLcd();
        break;
      case RcRegs.KY_SINGLE:
        AtSingl atSing = SystemFunc.readAtSingl();
        atSing.startDspFlg = 1;
        await rcNoChgAmtMakeLcd();
        break;
    }
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rcky_cha.c - rcNoChgAmtMakeLcd
  static Future<int> rcNoChgAmtMakeLcd() async {
    tprDlgParam_t param = tprDlgParam_t();
    CmEditCtrl fCtrl = CmEditCtrl();
    String log = "";

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcNoChgAmtMakeLcd() rxMemRead error\n");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    RxDevInf rxDevInf = RxDevInf();

    sprintf(log, "rcNoChgAmtMakeLcd");
    TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);

    //memset(&param, 0, sizeof(tprDlgParam_t));
    //cm_clr((char *)&fCtrl, sizeof(fCtrl));
    fCtrl.SeparatorEdit = 1; /* 桁区切り有り	*/

    param.msgBuf = 0x00;
    param.erCode = DlgConfirmMsgKind.MSG_OVERCHANGE.dlgId;
    if (pCom.dbTrm.originalCardOpe != 0) {
      param.erCode = DlgConfirmMsgKind.MSG_HLIMITERR.dlgId;
    }
    param.userCode = 0;

    if (((rxDevInf.devId != TprDidDef.TPRDIDTOUKEY1) &&
        (rxDevInf.devId != TprDidDef.TPRDIDMECKEY1)) ||
        (await RcSysChk.rcKySelf() == RcRegs.DESKTOPTYPE) ||
        (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) ||
        ((await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) &&
            (CmCksys.cmFbDualSystem() == 2))) {
      param.dialogPtn = DlgPattern.TPRDLG_PT2.dlgPtnId;
      /**********************************************************/
      param.func1 = subNoProcStopClicked;
      param.msg1 = LTprDlg.BTN_YES;
      param.title = LTprDlg.BTN_CONF;
      /**********************************************************/
    }
    // TODO:00012 平野 実装の必要があるか要確認
    // TprLibDlg(&param);

    // TODO:10077 コンパイルスイッチ(FB2GTK)
    // dual_dspは現状無効なので、コメントアウトする
    // if(FbInit.subinitMainSingleSpecialChk()){
    //   param.dual_dsp = 3;
    //   TprLibDlg(&param);
    // }

    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rcky_cha.c - subNoProcStop_clicked
  static void subNoProcStopClicked() {}

  /// 登録機でも精算機でもない通常レジで小計額以上の品券のお会計券を検索登録した取引かどうかをチェック
  /// 関連tprxソース:C:rcky_cha.c - rcky_cha_NormalReg_SrchReg_Chk()
  static Future<int> rckyChaNormalRegSrchRegChk() async {
    if ((!await RcSysChk.rcQCChkQcashierSystem()) // QCでない
        &&
        (!await RcSysChk.rcQRChkPrintSystem()) // 登録機でない
        &&
        (RcqrCom.qrReadSptendCnt ==
            RegsMem()
                .tTtllog
                .t100001Sts
                .sptendCnt) // スプリット段数が一致->釣無or釣有品券のはず？
        &&
        (RcQrinf.qrSrcregFlg == 2) // 検索登録
        &&
        (RegsMem().tTtllog.t100001Sts.qcReadQrMacNo != 0) // お会計券を読み込んだ実績？
    ) {
      return (1);
    }
    return (0);
  }

  ///　支払い可能かをclxosを利用して事前チェックする
  static Future<bool> paymentCheck() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "paymentCheck() rxMemRead error\n");
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    // 残額を支払う.
    int chaPayAmount = RegsMem().tTtllog.calcData.stlTaxAmt;
    int sptendIndex = RegsMem().tTtllog.t100001Sts.sptendCnt;
    try {
      // チェック用にデータを変更する.(確認完了後戻す)
      RegsMem().tTtllog.t100001Sts.sptendCnt++;
      RegsMem().tTtllog.t100100[sptendIndex].sptendCd = cMem.stat.fncCode;
      RegsMem().tTtllog.t100100[sptendIndex].sptendData = chaPayAmount;
      RegsMem().tTtllog.t100100[sptendIndex].sptendSht =
          cMem.working.dataReg.kMul0;
      if (cMem.working.dataReg.kMul0 > 1) {
        // 品券枚数が２枚以上の場合に券面額を設定する
        RegsMem().tTtllog.t100100[sptendIndex].sptendFaceAmt =
            Bcdtol.cmBcdToL(cMem.ent.entry) ~/ cMem.working.dataReg.kMul0;
      }

      CalcResultPay retDataCheck =
      await RcClxosPayment.payment(pCom, isCheck: true);
      int err = retDataCheck.getErrId();
      if (err > 0) {

        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
            "RcKeyCha payment check err ${retDataCheck.posErrCd} ${retDataCheck.retSts} ${retDataCheck.errMsg}");
        await RcExt.rcErr("paymentCheck()", err);
        return false;
      }
      return true;
    } finally {
      // チェック用に変更したデータを戻す.
      RegsMem().tTtllog.t100001Sts.sptendCnt--;
      RegsMem().tTtllog.t100100[sptendIndex] = T100100();
    }
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcky_cha.c - rcChargeChkStoreRegBarcode
  static void rcChargeChkStoreRegBarcode() {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rcky_cha.c - rcChk_Settlterm_Keybtn
  static int rcChkSettltermKeybtn() {
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c - rcChk_Edy_KeyOpt
  static bool rcChkEdyKeyOpt(){
    return false;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c - rcChk_MultiEdy_KeyOpt
  static bool rcChkMultiEdyKeyOpt() {
    return false;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c  -rcCha_Conf_Edy()
  static void rcChaConfEdy(){
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c  -rccha_ayaha_ChageSlipChkDsp()
  static void rcChaAyahaChageSlipChkDsp(){
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c  -rcChaEdy()
  static void rcChaEdy(){
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c  -rcCha_Conf_Edy_No()
  static void rcChaConfEdyNo(){
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c  -rcCha_Conf_Edy_Yes()
  static void rcChaConfEdyYes(){
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c -rcKyCha_Fresta_ConfDsp_Stop
  static int rcKyChaFrestaConfDspStop() {
    return 0;
  }  

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c -rcKyCha_Fresta_ConfDsp_Next
  static int rcKyChaFrestaConfDspNext() {
    return 0;
  }  

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rcky_cha.c -rcky_cha_vesca_init_memory
  static void rckyChaVesca_initMemory() {}  

  /// 商品券の画面遷移処理
  static Future<void> changeScreenGiftCertificate(FuncKey funcKey, String kyName) async {
    // 共有メモリの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    var crdtEnbleFlg = pCom.dbKfnc[funcKey.keyId].opt.cha.crdtEnbleFlg;
    var frcEntryFlg = pCom.dbKfnc[funcKey.keyId].opt.cha.frcEntryFlg;
    var mulFlg = pCom.dbKfnc[funcKey.keyId].opt.cha.mulFlg;
    var chkAmt = pCom.dbKfnc[funcKey.keyId].opt.cha.chkAmt;

    if (crdtEnbleFlg == 0 && frcEntryFlg == 0 && mulFlg == 0 && chkAmt == 0) {
      // 画面パターン6(一発締め)の処理
      SubtotalController subtotalCtrl = Get.find();

      // 「商品券でお支払い」画面を出さずに支払完了画面を出す処理のため、予め小計の値を設定する。
      int workTicketAmount = subtotalCtrl.notEnoughAmount.value;
      int workCurrentTicketCount = 1; // UI側の乗算で使用するので固定で１を設定
      int workCurrentTicketValue =
          subtotalCtrl.notEnoughAmount.value;

      subtotalCtrl.receivedAmount.value += workTicketAmount;
      subtotalCtrl.calculateAmounts();

      debugPrint('商品券支払後receivedAmount=${subtotalCtrl.receivedAmount.value}');
      await ticketPayment(funcKey, workTicketAmount, workCurrentTicketCount,
          workCurrentTicketValue, kyName);
    } else {
      // 画面パターン1-5の処理
      Get.to(() => TicketPaymentScreen(funcKey, kyName, title: "商品券でお支払い"));
    }
  }

  /// 商品券 画面パターン６用の支払い処理
  static Future<void> ticketPayment(FuncKey funcKey, int ticketAmount,
      int currentTicketCount, int currentTicketValue, String kyName) async {
    commonProcess(funcKey, currentTicketCount, currentTicketValue,kyName);

    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.fncCode = funcKey.keyId;

    // 品券合計金額をcmLtobcdで文字列に変換
    String bcd = Ltobcd.cmLtobcd(ticketAmount, cMem.ent.entry.length);
    for (int i = 0; i < cMem.ent.entry.length; i++) {
      // 文字列bcdを文字コードに変換して代入
      cMem.ent.entry[i] = bcd.codeUnits[i];
    }
    cMem.ent.tencnt = 0;
    cMem.working.dataReg.kMul0 = 0;
    await RckyCha.rcKyCharge();
    // 支払い後の画面遷移はrcATCTDisplayでCALLするためここでは不要
  }

  /// 商品券支払終了後の画面表示用共通処理
  static void commonProcess(FuncKey funcKey, int currentTicketCount,
      int currentTicketValue, String kyName) {
    CouponsController couponCtrl = Get.find();
    couponCtrl.addCoupon(kyName, currentTicketValue, currentTicketCount);
    couponCtrl.showCouponList.value = true;
  }

//実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_HoldCrdt_KeyOpt
     static int rcmbrChkStat() {
      return 0;
    }

//実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_Yamato_KeyOpt
  static int rcChkYamatoKeyOpt() {
    return 0;
  }

//実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_ChargeSlip_KeyOpt
  static bool rcChkHoldCrdtKeyOpt() {
    return false;
  }

//実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_Edy_KeyOpt2
  static int rcChkEdyKeyOpt2() {
    return 0;
  }

  //実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_MultiSuica_item
  static int rcChkMultiSuicaItem() {
    return 0;
  }

//実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_SPVT_KeyOpt
  static int rcChkSPVTKeyOpt() {
    return 0;
  }

  //実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_MultiPiTaPa_KeyOpt
  static int rcChkMultiPiTaPaKeyOpt() {
    return 0;
  }

  //実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_MultiSuica_KeyOpt
  static int rcChkMultiSuicaKeyOpt() {
    return 0;
  }

//実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_AbsPrepaid_KeyOpt
    static int rcChkAbsPrepaidKeyOpt() {
      return 0;
    }

  //実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_cha.c - rcChk_TaxFree_KeyOpt
    static int rcChkTaxFreeKeyOpt() {
      return 0;
    }
}
