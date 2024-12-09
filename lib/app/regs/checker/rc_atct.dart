/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_inout.dart';
import 'package:flutter_pos/app/regs/checker/rc_qrinf.dart';
import 'package:flutter_pos/app/regs/checker/rcsg_com.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/common/interface_define.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem.dart';
import '../../inc/apl/rxmem_barcode_pay.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_taxfree.dart';
import '../../inc/apl/rxmemnttdpreca.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/db/c_ttllog_sts.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/cnct.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_chg/bcdtol.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rx_log_calc.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'liblary.dart';
import 'rc_acracb.dart';
import 'rc_ajs_emoney.dart';
import 'rc_assist_mnt.dart';
import 'rc_cashless.dart';
import 'rc_crdt_fnc.dart';
import 'rc_ext.dart';
import 'rc_flrda.dart';
import 'rc_ifevent.dart';
import 'rc_ifprint.dart';
import 'rc_key_cash.dart';
import 'rc_key_extkey.dart';
import 'rc_key_pbchg.dart';
import 'rc_key_qcselect.dart';
import 'rc_lastcomm.dart';
import 'rc_mbr_com.dart';
import 'rc_mcd.dart';
import 'rc_order.dart';
import 'rc_recno.dart';
import 'rc_reserv.dart';
import 'rc_set.dart';
import 'rc_setdate.dart';
import 'rc_slip.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rc_taxfree_svr.dart';
import 'rccatalina.dart';
import 'rcfncchk.dart';
import 'rcibcal0.dart';
import 'rcky_cha.dart';
import 'rcky_qctckt.dart';
import 'rcky_regassist.dart';
import 'rcky_rfdopr.dart';
import 'rcky_spbarcode_read.dart';
import 'rcky_stl.dart';
import 'rcky_taxfreein.dart';
import 'rckyccin.dart';
import 'rckydisburse.dart';
import 'rckymulrbt.dart';
import 'rcmanualmix.dart';
import 'rcmbrcmsrv.dart';
import 'rcmbrflrd.dart';
import 'rcmbrkymstp.dart';
import 'rcmbrpoical.dart';
import 'rcqr_com.dart';
import 'rcmbrflwr.dart';
import 'rcspeeza_com.dart';
import 'rcsyschk.dart';
import 'rctbafc1.dart';

class RcAtct {
  static const int passCheckOn = 1;
  static const int passCheckOff = 0;

  static int chgFlg = 0;
  static int howAmtUp = 0;
  static int entryCheck = 0;

  /* クレジット宣言中にオフクレの置数強制チェックをしない為 */

  static int autoSptendCnt = 0;
  static int qcNotepluChangeFlg = 0; // 金種商品の釣りあり実績作成のため

  static int atctCheckPassFlag = 0;

  static int qcDivideFlg = 0; // フルセルフor精算機のメンテナンス画面で支払選択を表示中か
  static int amtdispFlg = 0; // 金額入力画面表示中か

  static const int ok = 0;
  static const int ng = 1;

  // TODO:00012 平野 以下は必要な時に実装する
  //static	ReasonSelStruct	reasonSel = {0};	// 選択関数に対する引数構造体
  static int? fncCodeSave; // キー情報保持
  static int orgChgFlg = 0; // 釣銭支払有無の退避用

  static int frcStlkyFlgChkSkip = 0;

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_atct.c - rcATCT_Ky_St_R
  static Future<void> rcAtctKyStR(List<int> aKy) async {
    AcMem cMem = SystemFunc.readAcMem();

    RcFncChk.rcKyStL0(aKy, atctList0);
    RcFncChk.rcKyStL1(aKy, atctList1);
    RcFncChk.rcKyStL2(aKy, atctList2);
    RcFncChk.rcKyStL3(aKy, atctList3);
    RcFncChk.rcKyStL4(aKy, atctList4);
    if ((await CmCksys.cmCrdtSystem() != 0) &&
        (cMem.working.crdtReg.step == KyCrdtInStep.INPUT_END.cd) &&
        (RcSysChk.rcChkKYCHA(cMem.stat.fncCode))) {
      RcRegs.kyStR0(aKy, FuncKey.KY_CRDTIN.keyId); /* Credit Subtotal Discount % */
      RcRegs.kyStR4(aKy, FuncKey.KY_CRDTIN.keyId);
    }
    if (!CompileFlag.MC_SYSTEM) {
      if ((await CmCksys.cmCrdtSystem() != 0) &&
          (!(await CmCksys.cmNttaspSystem() != 0)) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
          (cMem.working.crdtReg.step == KyCrdtInStep.OFF_KYCHA.cd) &&
          (RcSysChk.rcChkKYCHA(cMem.stat.fncCode))) {
        RcRegs.kyStR0(aKy, FuncKey.KY_CRDTIN.keyId); /* Credit Subtotal Discount % */
        RcRegs.kyStR4(aKy, FuncKey.KY_CRDTIN.keyId);
      }
    }
  }

  ///  関連tprxソース: rc_atct.c - ATCT_List0[]
  static List<int> atctList0 = [
    FncCode.KY_ENT.keyId,
    FncCode.KY_REG.keyId,
    FuncKey.KY_MAN.keyId,
    FuncKey.KY_5SEN.keyId,
    FuncKey.KY_SEN.keyId,
    //#if TW
    //  int KY_5HYAKU,
    //#endif
    FuncKey.KY_MUL.keyId,
    /* CHECK_MULTI */
    FuncKey.KY_CALC.keyId,
    FuncKey.KY_CHGPOST.keyId,
    FuncKey.KY_CULAY1.keyId,
    FuncKey.KY_CULAY2.keyId,
    FuncKey.KY_CULAY3.keyId,
    FuncKey.KY_CULAY4.keyId,
    FuncKey.KY_CULAY5.keyId,
    FuncKey.KY_CULAY6.keyId,
    FuncKey.KY_CULAY7.keyId,
    FuncKey.KY_CULAY8.keyId,
    FuncKey.KY_CULAY9.keyId,
    FuncKey.KY_CULAY10.keyId,
    0,
  ];

  ///  関連tprxソース: rc_atct.c - ATCT_List1[]
  static List<int> atctList1 = [0];

  ///  関連tprxソース: rc_atct.c - ATCT_List2[]
  static List<int> atctList2 = [FncCode.KY_FNAL.keyId, 0];

  ///  関連tprxソース: rc_atct.c - ATCT_List3[]
  static List<int> atctList3 = [FuncKey.KY_CHGPOST.keyId, 0];

  ///  関連tprxソース: rc_atct.c - ATCT_List4[]
  static List<int> atctList4 = [0];

  ///  関連tprxソース: rc_atct.c - rcStl_Calc_Proc
  static Future<void> rcStlCalcProc() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (!RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
      // not sprit tendering ?
      if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
          (RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin != 0) &&
          (!await RcSysChk.rcSGChkSelfGateSystem())) {
        if ((!RcRegs.kyStC4(
            cMem.keyStat[FuncKey.KY_STL.keyId])) // Calc. SubTotal ?
            &&
            (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHGCIN.keyId]))) {
          StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
        } else {
          RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_STL.keyId); // clear Calc. SubTotal
        }
      } else {
        if (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_STL.keyId])) {
          // Calc. SubTotal ?
          StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
        } else {
          RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_STL.keyId); // clear Calc. SubTotal
        }
      }
      await rcATCTMakePostReg();
    }
  }

  ///  関連tprxソース: rc_atct.c - rcATCT_Proc_Error2
  static Future<int> rcAtctProcError2(int type) async {
    int tencntBuf = 0;
    int errNo;
    int orgKMul0 = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if (type != 0) {
      // チェックのみ
      tencntBuf = cMem.ent.tencnt;
      orgKMul0 = cMem.working.dataReg.kMul0;
      entryCheck = 0;
    }
    errNo = await rcATCTProcErrorChk();
    if (type != 0) {
      // チェックのみ
      cMem.ent.tencnt = tencntBuf;
      cMem.working.dataReg.kMul0 = orgKMul0;
    }
    return errNo;
  }

  ///  関連tprxソース: rc_atct.c - rcATCT_Proc_ErrorChk
  static Future<int> rcATCTProcErrorChk() async {
    int lEntry = 0;
    int lData;
    KopttranBuff kopttranBuff = KopttranBuff();
    // if(CompileFlag.IWAI){
    int dmp;
    // }
    int refAmt = 1;
    int errNo;
    int errChkSkip;
    int num;
    String log = "";
    int pntSel;
    int stamp = 0;
    errChkSkip = 0;

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcATCTProcErrorChk() rxMemRead error\n");
      return -1;
    }
    RxCommonBuf cBuf = xRet.object;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if((await RcFncChk.rcCheckERefSMode()) || (await RcFncChk.rcCheckERefIMode())) {
    //   return (0);
    // }
    // if((await RcFncChk.rcCheckESVoidSMode()) || (await RcFncChk.rcCheckESVoidIMode()))
    // {
    //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttranBuff);
    //   if((kopttranBuff.nochgFlg != 0) && (kopttranBuff.tranUpdateFlg == 0)) {
    //     chgFlg = 1;
    //   } else {
    //       chgFlg = 0;
    //   }
    //
    //   if(kopttranBuff.tranUpdateFlg == 1) {
    //     howAmtUp = 1; /* 現金加算 */
    //   } else {
    //     howAmtUp = 0;
    //   }
    //   return( 0 );
    // }
    // if((await RcFncChk.rcCheckCrdtVoidSMode()) || (await RcFncChk.rcCheckCrdtVoidIMode())) {
    //   return( 0 );
    // }
    // if((await RcFncChk.rcCheckPrecaVoidSMode()) || (await RcFncChk.rcCheckPrecaVoidIMode())) {
    //   return( 0 );
    // }

    if (CompileFlag.RESERV_SYSTEM) {
      // if (RcFncChk.rcCheckReservMode())
      // {
      //   await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttranBuff);
      //   if((kopttranBuff.nochgFlg != 0) && (kopttranBuff.tranUpdateFlg == 0)) {
      //     chgFlg = 1;
      //   }
      //   else {
      //     chgFlg = 0;
      //   }
      //   if(kopttranBuff.tranUpdateFlg == 1) {
      //     howAmtUp = 1; /* 現金加算 */
      //   }
      //   else {
      //     howAmtUp = 0;
      //   }
      //   return( 0 );
      // }
      AtSingl atSing = SystemFunc.readAtSingl();
      // 通番訂正 返金ボタンはTRUEで返す
      if ((RcFncChk.rcFncchkRcptAcracbCheck()) &&
          (atSing.rcptCash.pay > 0) &&
          (atSing.rcptCash.status == 2) &&
          (cMem.stat.fncCode == FuncKey.KY_CASH.keyId)) {
        await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttranBuff);
        if ((kopttranBuff.nochgFlg != 0) && (kopttranBuff.tranUpdateFlg == 0)) {
          chgFlg = 1;
        } else {
          chgFlg = 0;
        }
        if (kopttranBuff.tranUpdateFlg == 1) {
          howAmtUp = 1; // 現金加算
        } else {
          howAmtUp = 0;
        }
        return 0;
      }
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    /*クレジット小計割引以外合計額変更する処理があれば別途対応必要*/
    // errNo = await RckyTaxFreeIn.rcTaxFreeGoodChgChk();
    // if(errNo != 0)
    // {
    //   return (errNo);
    // }
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttranBuff);

    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if COLORFIP
    // if(rcChk_fself_system()) {
    // if(CMEM->stat.FncCode == KY_CASH)
    // {
    // if(KOPTTRAN.frc_stlky_flg == 0) {
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "work memory change !! [KOPTTRAN.frc_stlky_flg : 0 -> 1]\n");
    // KOPTTRAN.frc_stlky_flg = 1;
    // }
    //
    // if(C_BUF->db_trm.fself_cash_split)
    // {
    // ;
    // }
    // else
    // {
    // if(KOPTTRAN.split_enble_flg == 1) {
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "work memory change !! [KOPTTRAN.split_enble_flg : 1 -> 0]\n");
    // KOPTTRAN.split_enble_flg = 0;
    // }
    // }
    // }
    // else if(rcChk_KY_CHA(CMEM->stat.FncCode))
    // {
    // if(rcChk_AcrAcb_AfterReg_CinStart()) {
    // if((rcCheck_Itm_Mode()) && (CMEM->acbdata.total_price != 0)) {
    // return(MSG_SUBTTLFCE_CHANGER_CANCEL);
    // }
    // }
    //
    // if (KOPTTRAN.crdt_enble_flg == 1)
    // {
    // if (rcCheck_Itm_Mode())
    // {
    // if (KOPTTRAN.frc_stlky_flg == 0)
    // {
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "work memory change !! [KOPTTRAN.frc_stlky_flg : 0 -> 1]\n");
    // KOPTTRAN.frc_stlky_flg = 1;
    // }
    // }
    // }
    // }
    // }
    // #endif
    // if(rcSR_OpeModeChk() || rcOD_OpeModeChk() || rcIV_OpeModeChk() || rcPD_OpeModeChk())
    // {
    //   if(rcChk_SR_CantAtct(&KOPTTRAN))
    //     return(MSG_OPEMERR);
    // }
    // if(rcCheck_Prime_Stat() == PRIMETOWER)
    // {
    //   if(AT_SING->inputbuf.no == KEY1) {
    //     if(rcChk_Prime_CantAtct(&KOPTTRAN))
    //       return(MSG_INVALIDKEY);
    //   }
    // }
    // #if DEPARTMENT_STORE
    // workflg = 1;
    // if(rcChk_Department_System()){
    // switch(rcWorkin_Chk_WorkTyp(&MEM->tTtllog)){
    // case WK_PLUMVEND:
    // case WK_SUMUP_ORDER:
    // case WK_SUMUP_SCREDIT:
    // case WK_SUMUP_CASHDELIVERY:
    // case WK_CRDITRECEIV:
    // case WK_ADDDEPOSIT:
    // case WK_REMAINDERPAY:
    // case WK_ANNUL_ORDER:
    // case WK_ANNUL_SCREDIT:
    // case WK_ANNUL_CASHDELIVERY:
    // case WK_RET_CRDITRECEIV:
    // workflg = 0;
    // break;
    // }
    // }
    // if(workflg){
    // #endif
    // #if MC_SYSTEM
    // if(! (rcChk_Mc_System() && (MEM->tTtllog.t100700.mbr_input == MCARD_INPUT) && (AT_SING->mc_tbl.k_amount == KY_MCFEE)))
    // {
    // #endif
    // if( (C_BUF->db_trm.disable_recover_fee_svscls1 ) &&
    // (MEM->tTtllog.t100702.join_fee_amt != 0 ) &&
    // (MEM->tTtllog.t100001.qty == 0L         ) &&
    // (MEM->tTtllog.t100001Sts.itemlog_cnt == 0L )   )
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "Item Count Check Skip");
    // else if( rcChk_MulRbtInput(0) )
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "MulRbt Inpit Item Count Check Skip");
    // else if( rcChk_Custreal_OP_System() && MEM->tTtllog.t100700.mbr_input )
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "OP Card Item Count Check Skip");
    // else if (( rcChk_Custreal_PointInfinity_System() )
    // && ( cm_ws_system() )
    // && ( MEM->tTtllog.t100700.mbr_input )
    // && ( MEM->tTtllog.t100760.kaiin_category != MEM->cust_ttltbl.s_data1 ))
    // {
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "PointInfinity_System Item Count Check Skip");
    // }
    // else if( ( cm_ws_system( ) )
    // &&  ( rcmbrChkCust( ) )
    // &&  ( MEM->prnrbuf.wscpnuse.count )
    // &&  ( MEM->prnrbuf.wscpnuse.cpn_pnt_add )
    // &&  ( MEM->tTtllog.t100001.qty == 0L )
    // &&  ( MEM->tTtllog.t100001Sts.itemlog_cnt == 0L ) )
    // {
    // // WS様 ポイント付与クーポンのみ利用時、締め処理可能とする
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "WS Cpn_System Item Count Check Skip");
    // }
    // else if((MEM->tTtllog.t100001.qty == 0L) && (MEM->tTtllog.t100001Sts.itemlog_cnt == 0L))
    // return (MSG_OPEERR);
    // #if MC_SYSTEM
    // }
    // #endif
    // #if DEPARTMENT_STORE
    // }
    // #endif
    //
    // if(cm_PFM_JR_IC_Charge_system() || cm_Suica_Charge_system()) {
    // if(rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 0) {
    // if((CMEM->stat.FncCode != KY_CASH) && (MEM->tmpbuf.multi_timeout == 0) && (!rcVD_OpeModeChk()))
    // return(MSG_OPEMISS);
    // if((!rcChk_KY_CHA(CMEM->stat.FncCode)) && (MEM->tmpbuf.multi_timeout == 1))
    // return(MSG_OPEMISS);
    // if(rcChk_RegMultiChargeItem(FCL_SUIC, 0) > 0)
    // return(MSG_TEXT122);
    // if(rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 1)
    // return(MSG_TEXT122);
    // if(RxLogCalc.rxCalcStlTaxAmt(mem) > 99999)
    // return(MSG_TEXT21);
    // if(RxLogCalc.rxCalcStlTaxAmt(mem) <= 0)
    // return(MSG_TEXT21);
    // dmp = cm_bcdtol((char *)CMEM->ent.entry, sizeof(CMEM->ent.entry));
    // if((rcCheck_chg10000Flg() == 1) && ((dmp - RxLogCalc.rxCalcStlTaxAmt(mem)) > MAX_CHGAMT))
    // return(MSG_MAX_CHANGEAMT_OVER);
    // }
    // }
    // if(rc_Chk_dPoint_MedicinePos_System()) /* @@@ */
    // {
    // if(rcCheck_Registration())
    // {
    // if(rc_Chk_dPoint_MedicinePos_ItemKind(0) && rc_Chk_dPoint_MedicinePos_ItemKind(2))
    // { // 処方せん商品とスタンプが混在
    // return(MSG_CARDOPEERR);
    // }
    // }
    // }
    // pnt_sel = rc_DS2_Point_Sel_Chk();
    // if(pnt_sel)
    // {
    // if(rc_Chk_dPoint_MedicinePos_ItemKind(3))	//通常会員スタンプ
    // stamp |= 0x01;
    //
    // if(rc_Chk_dPoint_MedicinePos_ItemKind(2))	//dポイントスタンプキー
    // stamp |= 0x02;
    //
    // if(stamp)
    // {
    // if(((pnt_sel == 1) && (stamp & 0x02))	||
    // ((pnt_sel == 2) && (stamp & 0x01)))
    // {
    // return(MSG_STAMPKEYUSE);
    // }
    // }
    // }
    //
    //
    // if ((rcChk_Ytrm_Process())
    // && (rcChk_RegYumecaChargeItem(1) > 0))
    // {
    // if (CMEM->stat.FncCode != KY_CASH)
    // {
    // return(MSG_OPEMISS);
    // }
    // if (RxLogCalc.rxCalcStlTaxAmt(mem) > 50000L)
    // {
    // return(MSG_CHARG_OVER_LIMIT);
    // }
    // if (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0)
    // {
    // return(MSG_TEXT21);
    // }
    // if (RxLogCalc.rxCalcStlTaxAmt(mem) % 1000L)
    // {
    // return(MSG_UNIT_1000_CHARGE);
    // }
    // if (C_BUF->db_trm.preca_charge_max_amt > 0L)
    // {
    // if (RxLogCalc.rxCalcStlTaxAmt(mem) > C_BUF->db_trm.preca_charge_max_amt)
    // return(MSG_CHARG_OVER_LIMIT);
    // }
    // dmp = cm_bcdtol((char *)CMEM->ent.entry, sizeof(CMEM->ent.entry));
    // if ((rcCheck_chg10000Flg() == 1) && ((dmp - RxLogCalc.rxCalcStlTaxAmt(mem)) > MAX_CHGAMT))
    // {
    // return(MSG_MAX_CHANGEAMT_OVER);
    // }
    // }
    //
    // if (rcfncchk_cct_charge_system())
    // {
    // if (CMEM->stat.FncCode != KY_CASH)
    // {
    // return(MSG_OPEMISS);
    // }
    //
    // if (rcChk_RegMultiChargeItem(FCL_SUIC, 0) > 0)
    // { // 通常商品が１品以上登録されているか？
    // return(MSG_CANT_MIX_CHARGE);
    // }
    //
    // if (rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 1)
    // { // チャージ商品が２品以上登録されているか？
    // return(MSG_TEXT122);
    // }
    //
    // if (RxLogCalc.rxCalcStlTaxAmt(mem) > 99999)
    // {
    // return(MSG_TEXT21);
    // }
    //
    // if (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0)
    // {
    // return(MSG_TEXT21);
    // }
    //
    // dmp = cm_bcdtol(CMEM->ent.entry, sizeof(CMEM->ent.entry));
    // if ((rcCheck_chg10000Flg() == 1) && ((dmp - RxLogCalc.rxCalcStlTaxAmt(mem)) > MAX_CHGAMT))
    // {
    // return(MSG_MAX_CHANGEAMT_OVER);
    // }
    // }
    //
    // if(rcCheck_KY_INT_in())
    // return (MSG_OPEINTERERR);

    if ((kopttranBuff.nochgFlg != 0) && (kopttranBuff.tranUpdateFlg == 0)) {
      chgFlg = 1;
    } else {
      chgFlg = 0;
    }

    // if (RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
    //   chgFlg = 0;	// 手動返品モードではお釣は発生しない
    // }

    if (kopttranBuff.tranUpdateFlg == 1) {
      howAmtUp = 1; // 現金加算
    } else {
      howAmtUp = 0;
    }

    if (frcStlkyFlgChkSkip == 1) {
      kopttranBuff.frcStlkyFlg = 0;
    }
    frcStlkyFlgChkSkip = 0;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(((KOPTTRAN.frc_stlky_flg)
    //     || ((rcChk_Custreal_PointTactix_System()) && (CMEM->stat.FncCode == rcmbr_GetManualRbtKeyCd()))) &&
    // #if SELF_GATE
    // (! await RcSysChk.rcSGChkSelfGateSystem()) &&
    // #endif
    // (! rcQC_Chk_Qcashier_System()) &&
    // #if !MC_SYSTEM
    // (! rcCheck_Crdt_Mode())   &&
    // #endif
    // (! rcCheck_ChgCin_Mode()) &&		//入金画面が表示されてない
    // (AcbInfo.AutoDecision_Fnal == 0) &&	//入金画面が表示されてない状態が入金確定終了の終了処理によるものでない
    // (! rcCheck_SpritMode())   &&
    // (! rcCheck_Stl_Mode())    &&
    // (! rcCheck_Wiz())    &&
    // (!((KOPTTRAN.crdt_typ == 7) && (KOPTTRAN.crdt_enble_flg == 1) && (rxCalc_Suica_Amt(MEM)))))
    // {
    // if( !rcsyschk_unread_cash_chk(CMEM->stat.FncCode) )        //未読現金設定でない
    //     {
    // return(MSG_SUBTTLFCE);
    // }
    // }

    if (!(cMem.stat.fncCode == FuncKey.KY_CASH.keyId)) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      //  #if BDL_PER
      //  if ( ((cm_ichiyama_mart_system())
      // || (rcChk_sch_multi_select_system()))
      // && !(Ky_St_C2(CMEM->key_stat[KY_FNAL])) )
      // {
      // CMEM->working.data_reg.k_mul_0 = CMEM->working.data_reg.k_mul_0_bak;
      //  //			CMEM->working.data_reg.k_mul_0_bak = 0;
      // CMEM->working.data_reg.k_mul_1 = 0;
      // }
      // #endif
      if (RcFncChk.rcChkTenOn()) {
        if (cMem.working.dataReg.kMul0 != 0) {
          if ((kopttranBuff.frcEntryFlg == 3) &&
              (!(cBuf.dbTrm.kanesueNewopeFunc != 0)) &&
              (!(((await CmCksys.cmMarutoSystem() != 0) &&
                      (RcSysChk.rcCheckTECOperation() == 4)) //マルト様特注
                  ||
                  (await CmCksys.cmSm3MaruiSystem() != 0))) //マルイ様特注
              &&
              (!(RcSysChk.rcChkSpecialMultiOpe()))) {
            return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          }

          // 乗算値が空の場合はエラー
          if(cMem.working.dataReg.kMul0 == -1){
            return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          }

          lEntry =
              cMem.working.dataReg.kMul0 * Bcdtol.cmBcdToL(cMem.ent.entry);
          // 品券合計金額をcmLtobcdで文字列に変換
          String bcd = Ltobcd.cmLtobcd(lEntry, cMem.ent.entry.length);
          for (int i = 0; i < cMem.ent.entry.length; i++) {
            // 文字列bcdを文字コードに変換して代入
            cMem.ent.entry[i] = bcd.codeUnits[i];
          }
          cMem.ent.tencnt = Liblary.cmChkZero0(bcd, cMem.ent.entry.length);
        } else {
          // TODO:10158 商品券支払い 実装対象外
          // if(rcChk_Before_MulKy()) {
          // if(Ky_St_C0(CMEM->key_stat[KY_MUL])) {
          // CMEM->working.data_reg.k_mul_0 = cm_bcdtol((char *)&CMEM->ent.entry[6], sizeof(CMEM->working.data_reg.k_mul_0));
          // if(CMEM->working.data_reg.k_pri_0) {
          // if(KOPTTRAN.frc_entry_flg == 3)
          // return (MSG_TICKETPRC_SET_INPUT_ERR);
          // lEntry = CMEM->working.data_reg.k_mul_0 * CMEM->working.data_reg.k_pri_0;
          // }
          // else {
          // if((KOPTTRAN.frc_entry_flg == 2) && (rcCheck_AcbDec_NotUse()))
          // KOPTTRAN.frc_entry_flg = 0;
          //
          // if((KOPTTRAN.frc_entry_flg != 0) && (KOPTTRAN.crdt_typ == 7) && (KOPTTRAN.crdt_enble_flg == 1))
          // KOPTTRAN.frc_entry_flg = 0;
          //
          // if(KOPTTRAN.frc_entry_flg != 3) {
          // if((KOPTTRAN.frc_entry_flg) && (RxLogCalc.rxCalcStlTaxAmt(mem) >= 0))
          // return( MSG_OPEERR );
          // }
          //
          // if(KOPTTRAN.chk_amt){
          // if(cm_Tuo_system())
          // lEntry = 0;
          // else
          // lEntry = CMEM->working.data_reg.k_mul_0 * (long)KOPTTRAN.chk_amt;
          // }
          // else
          // return (MSG_OPEERR);
          // }
          // cm_ltobcd( (char *)CMEM->ent.entry, lEntry, sizeof(CMEM->ent.entry));
          // CMEM->ent.tencnt = cm_chk_zero0((char *)CMEM->ent.entry, sizeof(CMEM->ent.entry));
          // }
          // else if(KOPTTRAN.frc_entry_flg == 3) {
          // return (MSG_TICKETPRC_SET_INPUT_ERR);
          // }
          // }
          // else
          if (kopttranBuff.frcEntryFlg == 3) {
            return (DlgConfirmMsgKind.MSG_TICKETPRC_SET_INPUT_ERR.dlgId);
          }
        }
      } else {
        // TODO:10121 QUICPay、iD 202404実装対象外
        // if((KOPTTRAN.frc_entry_flg == 2) && (rcCheck_AcbDec_NotUse()))
        //   KOPTTRAN.frc_entry_flg = 0;
        //
        // if((KOPTTRAN.frc_entry_flg != 0) && (KOPTTRAN.crdt_typ == 7) && (KOPTTRAN.crdt_enble_flg == 1))
        //   KOPTTRAN.frc_entry_flg = 0;

        if (await CmCksys.cmCrdtSystem() != 0) {
          // TODO:10121 QUICPay、iD 202404実装対象外
          // #if SELF_GATE
          // if((rcCheck_Crdt_Mode()) || (rcSG_Dual_SubttlDsp_Chk()) || (rcQC_Check_CrdtUse_Mode()))
          // #else
          // if(rcCheck_Crdt_Mode() || rcQC_Check_CrdtUse_Mode())
          // #endif
          // {
          // if((KOPTTRAN.crdt_enble_flg == 0) && (KOPTTRAN.crdt_typ == 8) && (KOPTTRAN.frc_entry_flg != 0))
          //   entry_check = 1;
          // }
          if (entryCheck == 1) {
            kopttranBuff.frcEntryFlg = 0;
          } else {
            entryCheck = 0;
          }
        }

        // TODO:10121 QUICPay、iD 202404実装対象外
        // // if (((cm_ajs_emoney_system()) || (cm_yumeca_pol_system())) && (((MEM->autocall_receipt_no && MEM->autocall_mac_no) || (qr_read_preca_autosales_flg == 1)) || (MEM->ajs_emoney_autocall_flg == 1)))
        // if (((cm_ajs_emoney_system()) ) && (((MEM->tmpbuf.autocall_receipt_no && MEM->tmpbuf.autocall_mac_no) || (qr_read_preca_autosales_flg == 1)) || (MEM->tmpbuf.ajs_emoney_autocall_flg == 1)))
        // {
        //   if (KOPTTRAN.frc_entry_flg == 1)
        //   {
        //     KOPTTRAN.frc_entry_flg = 0; // 置数強制しないに変更する
        //   }
        // }
        //
        // if (rcChk_Repica_System())
        // {
        //   if ( CMEM->stat.FncCode == rcGet_Preca_FncCode() )
        // {
        // if (KOPTTRAN.frc_entry_flg == 1)
        // {	// 置数強制しないに変更する
        // KOPTTRAN.frc_entry_flg = 0;
        // }
        // }
        // }
        //
        // if( rcsyschk_repica_point_system() )
        // {	// レピカポイント
        // if( CMEM->stat.FncCode == rcGet_PrecaPoint_FncCode() )
        // {
        // if( KOPTTRAN.frc_entry_flg == 1 )
        // {	// 置数強制しないに変更する
        // KOPTTRAN.frc_entry_flg = 0;
        // }
        // }
        // }
        //

        // 乗算有効かつ乗算値の設定がない場合はエラー
        if ((kopttranBuff.mulFlg == 1 && cMem.working.dataReg.kMul0 == -1)) {
          return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
        }

        if (kopttranBuff.frcEntryFlg != 3) {
          if ((kopttranBuff.frcEntryFlg != 0) &&
              (RxLogCalc.rxCalcStlTaxAmt(mem) >= 0) &&
              (Bcdtol.cmBcdToL(cMem.ent.entry) == 0)) {
            return (DlgConfirmMsgKind.MSG_PAYMENT_PRICE_NEED.dlgId);
          }
        }

        if (cMem.working.dataReg.kMul0 != 0) {
          if (((kopttranBuff.chkAmt != 0) ||
                (Bcdtol.cmBcdToL(cMem.ent.entry) != 0)) && // 券面額または置数金額が設定されている
              ((cMem.working.dataReg.kMul0 != -1))) { // 乗算値が空設定ではない
            if (await CmCksys.cmTuoSystem() != 0) {
              lEntry = 0;
            } else {
              if (kopttranBuff.chkAmt != 0) {
                // 券面金額が予め設定されている場合は品券枚数×券面金額をlEntryに設定
                lEntry = cMem.working.dataReg.kMul0 * kopttranBuff.chkAmt;
              } else {
                // 品券枚数×置数金額をlEntryに設定
                lEntry = cMem.working.dataReg.kMul0 * Bcdtol.cmBcdToL(cMem.ent.entry);
              }
            }
          } else {
            return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          }
        } else {
          if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) {
            return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
          }
          if (RxLogCalc.rxCalcStlTaxAmt(mem) < 0) {
            lEntry = 0;
          } else {
            if (await CmCksys.cmTuoSystem() != 0) {
              lEntry = 0;
            } else if ((await RcFncChk.rcfncchkAlltranQCConduct() !=
                    0) // QC側でレシート発行する仕様
                &&
                (!(await RcSysChk.rcQCChkQcashierSystem())) &&
                ((RcSysChk.rcRGOpeModeChk()) || (RcSysChk.rcTROpeModeChk())) &&
                (RcSysChk.rcChkKYCHA(cMem.stat.fncCode)) &&
                (kopttranBuff.frcEntryFlg == 0) // 置数強制しない
                &&
                (kopttranBuff.chkAmt == 0) // 券面額0円
                &&
                (RcSpeezaCom.rcChkChaTranSpeezaUpd() == 0)) {
              // 小計額以上の会計・品券キー入力時に取引送信する
              lEntry = await rcATCTldataSet();
            } else {
              if (kopttranBuff.chkAmt != 0) {
                // 券面金額が予め指定されている場合は券面金額をlEntryに設定
                lEntry = kopttranBuff.chkAmt;
              } else {
                // 置数金額をlEntryに設定
                lEntry = Bcdtol.cmBcdToL(cMem.ent.entry);
              }
            }
            if ((kopttranBuff.frcEntryFlg == 3) && (lEntry == 0)) // 券面のみ、券面額0円
            {
              return (DlgConfirmMsgKind.MSG_CHKSETTING.dlgId);
            }
          }
        }
        // lEntryをcmLtobcdで文字列に変換
        String bcd =  Ltobcd.cmLtobcd(lEntry, cMem.ent.entry.length);
        for (int i = 0; i < cMem.ent.entry.length; i++) {
          // 文字列bcdを文字コードに変換して代入
          cMem.ent.entry[i] = bcd.codeUnits[i];
        }
        cMem.ent.tencnt = Liblary.cmChkZero0(bcd, cMem.ent.entry.length);
      }
    }

    if (RcFncChk.rcChkTenOn()) {
      if(CompileFlag.CN){
        if(cMem.ent.tencnt > 10) { /* Put on Over ? */
          return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
        }
      }else{
        if(cMem.ent.tencnt > 8) { /* Put on Over ? */
          return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
        }
      }

      if (RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
        // 超過金額の場合はエラー
        if (Bcdtol.cmBcdToL(cMem.ent.entry) >
            RxLogCalc.rxCalcStlTaxAmt(mem).abs()) {
          return DlgConfirmMsgKind.MSG_NOOVERKEEP.dlgId;
        }
      } else if (rcCheckAddTicket(kopttranBuff)) {
        // お釣りが券面額以上でエラー
        if ((Bcdtol.cmBcdToL(cMem.ent.entry) -
                RxLogCalc.rxCalcStlTaxAmt(mem).abs()) >=
            kopttranBuff.chkAmt) {
          return DlgConfirmMsgKind.MSG_OVERCHANGE.dlgId;
        }
      }
      else
      {
        /* 2007/04/26 >>> */
        if(RxLogCalc.rxCalcStlTaxAmt(mem) < 0)     /* return amount ? */
        {
          if((cBuf.dbTrm.nontaxCha10 != 0 ) &&
              (cMem.stat.fncCode == FuncKey.KY_CHA10.keyId) &&
              (mem.tTtllog.t100001Sts.sptendCnt == 0  ))
          {
            refAmt = -1;
          }
          else if(await CmCksys.cmTaxFreeSystem() != 0){  /* 免税機能 */
          }
          else {
            return(DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
          }
        }
        /* <<< 2007/04/26 */
      }
      lEntry = Bcdtol.cmBcdToL(cMem.ent.entry);
      lEntry *= refAmt; /* 2007/04/26 */
    } else {
      lEntry = 0;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    //     if(input_amt != NULL)
    //     {
    //     *input_amt = lEntry;
    //     }
    //
    //     if(MEM->tTtllog.t100001Sts.sptend_cnt >= (SPTEND_MAX - 1)) { /* over last sprit tendering chance ? */
    //     if(rcChk_Ten_On() && (lEntry < RxLogCalc.rxCalcStlTaxAmt(mem)))  /* entry data ? and shortage data ? */
    //     return(MSG_LASTBUF);
    //     }
    //
    //     if((rcChk_Crdt_CantAtct(&KOPTTRAN)) && (rcmbrChkStat()) && (! rcmbrChkCust())) {
    //     if(rcChk_COOP_System())
    //     return(MSG_COOP_ERR);
    //     else
    //     return(MSG_CALL_MBR);
    //     }
    //
    //     if(C_BUF->db_trm.original_card_ope && (KOPTTRAN.frc_cust_call_flg) && rcmbrChkStat() && (! rcmbrChkCust()) && (! await RcSysChk.rcSGChkSelfGateSystem()))
    //     return(MSG_CALL_MBR);
    //
    //     if((C_BUF->db_trm.disable_mbr_cashkey) && (CMEM->stat.FncCode == KY_CASH) && (rcmbrChkStat()) && (rcmbrChkCust()))
    //     return(MSG_TEXT180);
    //
    //     if(rcmbrChkStat() && ((rcmbrChkCust() && (MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT) && (C_BUF->db_trm.mbrsellkey_ctrl == 0) && (!cm_nimoca_point_system())) ||
    //     (rcChk_Mbrprc_System() && (MEM->tTtllog.t100700.mbr_input == NON_INPUT))))
    //     #if RALSE_MBRSYSTEM
    //     {
    //     if (rcChk_RalseCard_System())
    //     {
    //     if ( rcChk_MemberTyp(MCD_RLSCARD, MEM) )
    //     return(MSG_CALL_RLSMBR);
    //     else
    //     return(MSG_CALL_RLSSTAFF);
    //     }
    //     else
    //     {
    //     #endif
    //     if (rcsyschk_qc_nimoca_system())
    //     {
    //     if ((MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT)
    //     && ((CMEM->stat.OrgFncCode == KY_QC_TCKT)
    //     || (CMEM->stat.OrgFncCode == KY_QCSELECT)
    //     || (CMEM->stat.OrgFncCode == KY_QCSELECT2)
    //     || (CMEM->stat.OrgFncCode == KY_QCSELECT3)))
    //     { // nimoca宣言取引は、QCashierへ送りたい
    //     err_chk_skip = 1;
    //     }
    //     else
    //     {
    //     if ((MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT)
    //     && (CMEM->stat.FncCode != KY_CASH))
    //     { // nimoca宣言取引は、QCashierでポイント付加したい
    //     err_chk_skip = 1;
    //     }
    //     }
    //     }
    //     if (rcChk_WS_System())
    //     {
    //     err_chk_skip = 1;
    //     }
    //
    //     if ( (rcChk_Custreal_Fresta_System())		// フレスタ仕様
    //     && (MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT) )
    //     {
    //     err_chk_skip = 1;
    //     }
    //
    //     if(!((cm_ichiyama_mart_system()) && (MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT)))
    //     {
    //     if (err_chk_skip == 0)
    //     {
    //     return(MSG_CALL_MBR);
    //     }
    //     }
    //     #if RALSE_MBRSYSTEM
    //     }
    //     }
    //     #endif
    //
    //     if(C_BUF->db_trm.coop_yamaguchi_green_stamp)
    //     {/* コープやまぐち仕様 */
    //     if((MEM->tTtllog.t100700.mbr_input == NON_INPUT) && (rcChk_RegCapitalCode_Coop()))
    //     return(MSG_CALL_MBR);
    //     }
    //
    //     if(C_BUF->db_trm.tranrceipt_barflg_equal_jan) {
    //     // Y端末併用対応 掛売のプリペイドはチャージとして扱わない
    //     if((KOPTTRAN.crdt_typ != 6)
    //     || ((cm_yumeca_system())
    //     && (KOPTTRAN.crdt_enble_flg == 1)
    //     && (KOPTTRAN.crdt_typ == 6)))
    //     {
    //     if((rcCheck_OutMdlTran_Detail(CMEM->stat.FncCode)) != OK) {
    //     return(MSG_COUPONERR);
    //     }
    //     else {
    //     if(rcChk_ManualRbtCashKey()) {
    //     if((rcVD_OpeModeChk()) && (C_BUF->db_trm.psp_minus_amt == 0))
    //     return(MSG_OPEMISS);
    //     }
    //     }
    //     }
    //     else {
    //     if((rcVD_OpeModeChk()) && (C_BUF->db_trm.psp_minus_amt == 0)) {
    //     return(MSG_OPEMISS);
    //     }
    //     if((rcCheck_OutMdlTran_Detail(CMEM->stat.FncCode)) == OK) {
    //     return(MSG_COUPONERR);
    //     }
    //     else {
    //     if(rcCheck_NormalItem_Detail() == OK) {    /* チャージ商品以外が登録されている？ */
    //     return(MSG_COUPONERR);
    //     }
    //     }
    //     }
    //     }
    //
    //     #if RALSE_CREDIT
    //     if(!((KOPTTRAN.crdt_enble_flg  ) &&
    //     (rcChk_RalseCard_System() ) &&
    //     (rcChk_JET_B_Process()    )))
    //     #endif
    // //   if((! KOPTTRAN.stl_minus_flg) && (RxLogCalc.rxCalcStlTaxAmt(mem) < 0))
    // //      return(MSG_NOMINUSERR);
    //     if(    (rcRfdOprCheckManualRefundMode() == TRUE)
    //     && (CMEM->stat.FncCode == KY_CASH)
    //     && (cm_ws_system( )) )		/* ワールド・スポーツ様特注仕様かチェック */
    //     {
    //     ;
    //     }
    //     else
    //     {
    //     if((! KOPTTRAN.stl_minus_flg) && (RxLogCalc.rxCalcStlTaxAmt(mem) < 0))
    //     {
    //     return(MSG_NOMINUSERR);
    //     }
    //     }
    //
    //     #if 0
    // //預かり置数強制等の判定より先に小計強制かの判定の方が優先度が高いので上に移動
    //     if((KOPTTRAN.frc_stlky_flg) &&
    //     #if SELF_GATE
    //     (! await RcSysChk.rcSGChkSelfGateSystem()) &&
    //     #endif
    //     (! rcQC_Chk_Qcashier_System()) &&
    //     #if !MC_SYSTEM
    //     (! rcCheck_Crdt_Mode())   &&
    //     #endif
    //     (! rcCheck_ChgCin_Mode()) &&		//入金画面が表示されてない
    //     (AcbInfo.AutoDecision_Fnal == 0) &&	//入金画面が表示されてない状態が入金確定終了の終了処理によるものでない
    //     (! rcCheck_SpritMode())   &&
    //     (! rcCheck_Stl_Mode())    &&
    //     (! rcCheck_Wiz())    &&
    //     (!((KOPTTRAN.crdt_typ == 7) && (KOPTTRAN.crdt_enble_flg == 1) && (rxCalc_Suica_Amt(MEM)))))
    //     return(MSG_SUBTTLFCE);
    //     #endif

    lData = await rcATCTldataSet();

    if (lData > 0) {
      // not return amount and ZERO ?
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if((kopttranBuff.stlOverFlg == 0) &&
      //     ((CompileFlag.SELF_GATE) &&
      //     (!await RcSysChk.rcSGChkSelfGateSystem())) &&
      //     (RxLogCalc.rxCalcStlTaxAmt(mem) < lEntry) &&
      //     (cMem.acbData.totalPrice == 0)) {
      //   if (CompileFlag.IWAI) {
      //     if ((await RcSysChk.rcChkORCSystem() || await RcSysChk.rcChkIWAIRealSystem())
      //         && (cMem.stat.fncCode == FuncKey.KY_CHA4.keyId)) {
      //       return (DlgConfirmMsgKind.MSG_PACKOVERERR.dlgId);
      //     }
      //   }
      //   return (DlgConfirmMsgKind.MSG_NOOVERKEEP.dlgId);
      // }
      //
      //  if (CompileFlag.SELF_GATE) {
      //    if ((await RcSysChk.rcSGChkSelfGateSystem()) && (RcFncChk.rcCheckSpritMode())) {
      //      if ((kopttranBuff.stlOverFlg == 0) && (RxLogCalc.rxCalcStlTaxAmt(mem) < lEntry) &&
      //          (cMem.acbData.totalPrice == 0))
      //        return (DlgConfirmMsgKind.MSG_NOOVERKEEP.dlgId);
      //
      //      if (RcSgCom.rcNewSGChkNonAcr()) {
      //        if ((RxLogCalc.rxCalcStlTaxAmt(mem) < lEntry) &&
      //            (cMem.acbData.totalPrice == 0))
      //          return (DlgConfirmMsgKind.MSG_NOOVERKEEP.dlgId);
      //      }
      //    }
      //  }

      //#if CATALINA_SYSTEM | RESERV_SYSTEM
      if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
        //     if((! KOPTTRAN.split_enble_flg                                ) &&
        //         ((RxLogCalc.rxCalcStlTaxAmt(mem)) > lEntry) &&
        //         (rcChk_Ten_On()                                            ) )
        //       return(MSG_NOLACKERR);
        //     #if SELF_GATE
        //     if( await RcSysChk.rcSGChkSelfGateSystem() ) {
        // if((MntDsp.sg_cashky_flg == 1   ) &&
        // (RxLogCalc.rxCalcStlTaxAmt(mem) > lEntry) &&
        // (rcChk_Ten_On()                   ) )
        // return(MSG_NOLACKERR);
        // }
        // #endif
        // if((cm_PFM_JR_IC_Charge_system() || cm_Suica_Charge_system()) && rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 0) {
        // if(((RxLogCalc.rxCalcStlTaxAmt(mem)) > lEntry) &&
        // (rcChk_Ten_On()                                            ) )
        // return(MSG_NOLACKERR);
        // }
        // if ((RC_INFO_MEM->RC_RECOG.RECOG_YUMECA_SYSTEM)
        // && (rcChk_Ytrm_Process())
        // && (rcChk_RegYumecaChargeItem(1) > 0))
        // {
        // if((RxLogCalc.rxCalcStlTaxAmt(mem)) > lEntry
        // && rcChk_Ten_On())
        // {
        // return(MSG_NOLACKERR);
        // }
        // }
        //
        // if (rcfncchk_cct_charge_system())
        // {
        // if (((RxLogCalc.rxCalcStlTaxAmt(mem)) > lEntry) && (rcChk_Ten_On()))
        // {
        // return(MSG_NOLACKERR);
        // }
        // }
      } else
      //#endif
      if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
        // TODO:10121 QUICPay、iD 202404実装対象外
        //  if((! KOPTTRAN.split_enble_flg                                ) &&
        //      ((RxLogCalc.rxCalcStlTaxAmt(mem)) > lEntry) &&
        //      (rcChk_Ten_On()                                            ) )
        //    return(MSG_NOLACKERR);
        //  #if SELF_GATE
        //  if( await RcSysChk.rcSGChkSelfGateSystem() ) {
        //    if((MntDsp.sg_cashky_flg == 1   ) &&
        //    (RxLogCalc.rxCalcStlTaxAmt(mem) > lEntry) &&
        //    (rcChk_Ten_On()                   ) )
        //    return(MSG_NOLACKERR);
        // }
        //  #endif
      } else {
        // TODO:10121 QUICPay、iD 202404実装対象外
        //#endif
        //     #if SELF_GATE
        //     if( await RcSysChk.rcSGChkSelfGateSystem() ) {
        // if((MntDsp.sg_cashky_flg == 1   ) &&
        // (RxLogCalc.rxCalcStlTaxAmt(mem) > lEntry) &&
        // (rcChk_Ten_On()                   ) )
        // return(MSG_NOLACKERR);
        // }
        // else {
        // if(((! KOPTTRAN.split_enble_flg       ) &&
        // (RxLogCalc.rxCalcStlTaxAmt(mem) > lEntry) &&
        // (rcChk_Ten_On()                   ) )
        // #if DEBIT_CREDIT
        // && (!((KOPTTRAN.crdt_enble_flg) &&
        // (KOPTTRAN.crdt_typ == 7)   ) )
        // #endif
        // )
        // return(MSG_NOLACKERR);
        // }
        // #else
        // if(((! KOPTTRAN.split_enble_flg       ) &&
        // (RxLogCalc.rxCalcStlTaxAmt(mem) > lEntry) &&
        // (rcChk_Ten_On()                   ) )
        // #if DEBIT_CREDIT
        // && (!((KOPTTRAN.crdt_enble_flg) &&
        // (KOPTTRAN.crdt_typ == 7)   ) )
        // #endif
        // )
        // return(MSG_NOLACKERR);
        //
        // if((cm_PFM_JR_IC_Charge_system() || cm_Suica_Charge_system()) && rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 0) {
        // if(((RxLogCalc.rxCalcStlTaxAmt(mem)) > lEntry) &&
        // (rcChk_Ten_On()                                            ) )
        // return(MSG_NOLACKERR);
        // }
        //
        // if (rcfncchk_cct_charge_system())
        // {
        // if (((RxLogCalc.rxCalcStlTaxAmt(mem)) > lEntry) && (rcChk_Ten_On()))
        // {
        // return(MSG_NOLACKERR);
        // }
        // }
        //
        // #endif

        //#if CATALINA_SYSTEM | RESERV_SYSTEM
      }
      //#endif
      // TODO:10121 QUICPay、iD 202404実装対象外
      //   if((rcCheck_AcrAcb_ON(1) == ACR_COINBILL) &&
      //       (rcChk_AcxDecision_System()          ) &&
      //       (rcCheck_ChgCin_Mode()               ) )
      //   {
      //     if(CMEM->acbdata.total_price < AcbInfo.Total_Price){
      //       if((await RcSysChk.rcSGChkSelfGateSystem()) || (! KOPTTRAN.split_enble_flg))
      //         return(MSG_NOLACKERR);
      //       if((cm_PFM_JR_IC_Charge_system() || cm_Suica_Charge_system()) && rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 0)
      //         return(MSG_NOLACKERR);
      //
      //       if (rcfncchk_cct_charge_system())
      //       {
      //         return(MSG_NOLACKERR);
      //       }
      //     }
      //   }
      //
      //   #if MC_SYSTEM
      //   if(rcChk_Mc_System())
      // {
      // if(mcATCT_Chk_McCrdt(&KOPTTRAN, lEntry))
      // return(MSG_OPEMISS);
      // }
      // #endif
      //
      // #if RESERV_SYSTEM
      // if((cm_Reserv_system() || cm_netDoAreserv_system()) &&
      // (rcreserv_ReceiptCall()       ) &&
      // (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0)   )
      // KOPTTRAN.frc_entry_flg = 0;
      // #endif
      // if ((C_BUF->db_trm.disc_barcode_28d)
      // && (mem.tmpbuf.beniyaTtlamt)
      // && (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0))
      // {
      // KOPTTRAN.frc_entry_flg = 0;
      // }
      // if((mem.tmpbuf.notepluTtlamt) &&
      // (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0)   )
      // KOPTTRAN.frc_entry_flg = 0;
      //
      //
      // if((KOPTTRAN.frc_entry_flg == 2) && (rcCheck_AcbDec_NotUse()))
      // KOPTTRAN.frc_entry_flg = 0;
      // if((KOPTTRAN.frc_entry_flg == 2) && (MEM->tmpbuf.rcptvoid_flg > 0) && (rcChk_Ajs_Emoney_System()) && (AjsEmoneyStat.biz_type == AJS_EMONEY_BIZ_DEPOSIT_ITEM) && (rcCheck_Ajs_Emoney_Deposit_Item(1)))
      // KOPTTRAN.frc_entry_flg = 0;
      // #if SELF_GATE
      // if((KOPTTRAN.frc_entry_flg == 1) && (lEntry == 0) && (! rcChk_Ten_On()) && (MntDsp.sg_cashky_flg != 1))
      // return(MSG_PAYMENT_PRICE_NEED);
      // #else
      // if((KOPTTRAN.frc_entry_flg == 1) && (lEntry == 0) && (! rcChk_Ten_On()))
      // return(MSG_PAYMENT_PRICE_NEED);
      // #endif
      // if((KOPTTRAN.frc_entry_flg == 2) && (CMEM->acbdata.total_price == 0) && (rcVD_OpeModeChk()==FALSE))
      // return(MSG_DECCIN_SET_INPUT_ERR);

      //#if IWAI
      dmp = 0;
      for (num = 0; num < CntList.sptendMax; num++) {
        if (mem.tTtllog.t100100[num].sptendCd == FuncKey.KY_CHA4.keyId) {
          dmp = mem.tTtllog.t100200[AmtKind.amtCha4.index].amt;
          break;
        }
      }
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if ((rcChk_ORC_System() || rcChk_IWAI_Real_System()) && (CMEM->stat.FncCode == KY_CHA4)) {
      //   if ((MEM->tTtllog.t100700.lpnt_ttlsrv - dmp) < lEntry) return(MSG_PACKOVERERR);
      // }
      //#endif
      //     if(rcChk_ManualRbtCashKey())
      //     {
      //       if (rcChk_Custreal_PointTactix_System())
      //       {
      //         errNo = rcAtct_Check_PointTactix();
      //         if (errNo)
      //         {
      //           return(errNo);
      //         }
      //       }
      //
      //       if(!((rcChk_Custreal_Webser_System() || rcChk_Custreal_OP_System() || rcChk_Tpoint_System()) && (rcVD_OpeModeChk())))
      //       {
      //         if ((rcmbr_Get_ObjRbtPoint(rcmbr_Get_SvsMthd(C_BUF, MEM))-rcmbr_ManualRbtCashPoint()) < lEntry)
      //         {
      //           if(C_BUF->db_trm.tranrceipt_barflg_equal_jan)
      //             return(MSG_TRC_BALANCE_LACK_ERR);
      //           else if(rcChk_Custreal_Webser_System())
      //             return(MSG_TEXT27);
      //           else if(rcChk_Custreal_OP_System() && (MEM->tTtllog.t100700.real_custsrv_flg == 1))
      //             return(MSG_CUSTREALOP_SRV_ERR);
      //           else if (rcChk_Tpoint_System())
      //           {
      //             return(MSG_ENTPNT_OVER); /* ポイントが足りません */
      //           }
      //           else if (cm_sm3_marui_system())
      //           {
      //             return(MSG_HLIMITERR); /* ポイントが足りません */
      //           }
      //           else
      //             return(MSG_PNTSHORT);
      //         }
      //         else if(rcChk_Custreal_OP_System() && (MEM->tTtllog.t100700.real_custsrv_flg == 1))
      //           return(MSG_CUSTREALOP_SRV_ERR);
      //         else if (rcChk_Tpoint_System())
      //         {
      //           errNo = rcatct_Check_Tpoint();
      //           if (errNo)
      //           {
      //             return(errNo);
      //           }
      //         }
      //       }
      //       /* 04.Sep.09 T.Habara */
      //       if(!((rcChk_Custreal_Webser_System() || rcChk_Custreal_OP_System() || rcChk_Tpoint_System()) && (rcVD_OpeModeChk())))
      //       {
      //         if (lEntry == 0)
      //         {
      //           if ((rcmbr_Get_ObjRbtPoint(rcmbr_Get_SvsMthd(C_BUF, MEM))-rcmbr_ManualRbtCashPoint()) < RxLogCalc.rxCalcStlTaxAmt(mem))
      //           {
      //             if(C_BUF->db_trm.tranrceipt_barflg_equal_jan)
      //               return(MSG_TRC_BALANCE_LACK_ERR);
      //             else if(rcChk_Custreal_Webser_System())
      //               return(MSG_TEXT27);
      //             else if(rcChk_Custreal_OP_System() && (MEM->tTtllog.t100700.real_custsrv_flg == 1))
      //               return(MSG_CUSTREALOP_SRV_ERR);
      //             else if (rcChk_Tpoint_System())
      //             {
      //               return(MSG_ENTPNT_OVER); /* ポイントが足りません */
      //             }
      //             else if (cm_sm3_marui_system())
      //             {
      //               return(MSG_HLIMITERR); /* ポイントが足りません */
      //             }
      //             else
      //               return(MSG_PACKOVERERR);
      //           }
      //           else if(rcChk_Custreal_OP_System() && (MEM->tTtllog.t100700.real_custsrv_flg == 1))
      //             return(MSG_CUSTREALOP_SRV_ERR);
      //           else if (rcChk_Tpoint_System())
      //           {
      //             errNo = rcatct_Check_Tpoint();
      //             if (errNo)
      //             {
      //               return(errNo);
      //             }
      //           }
      //         }
      //       }
      //       if(rcChk_Custreal_OP_System())
      //       {
      //         if(MEM->tTtllog.t100700.real_custsrv_flg == 1)
      //           return(MSG_CUSTREALOP_SRV_ERR);
      //         else if(rxCalc_Suica_Amt(MEM))
      //           return(MSG_OPEMISS);
      //       }
      //       if (rcChk_Tpoint_System())
      //       {
      //         errNo = rcatct_Check_Tpoint();
      //         if (errNo)
      //         {
      //           return(errNo);
      //         }
      //       }
      //       if (rcChk_Toy_System())
      //       {
      //         long	p_amt_ttl = 0;
      //         long	p_pay_ttl = 0;
      //
      //         for (num = 0; num < MEM->tTtllog.t100001Sts.itemlog_cnt; num++)
      //         {
      //           if (rcmbr_Check_PntObjItem(MEM, C_BUF, num))
      //           {
      //             p_amt_ttl += MEM->tItemlog[num].t11100.rbt_pur_amt;
      //   }
      //   }
      //
      //   if (lEntry == 0)
      //   {
      //   p_pay_ttl = RxLogCalc.rxCalcStlTaxAmt(mem) + rcmbr_ManualRbtCashPoint();
      //   }
      //   else
      //   {
      //   p_pay_ttl = lEntry + rcmbr_ManualRbtCashPoint();
      //   }
      //   snprintf(log, sizeof(log), "%s [TOY] Max usable points [%ld], total points tendered [%ld]", __FUNCTION__, p_amt_ttl, p_pay_ttl);
      //   TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
      //   if (p_pay_ttl > p_amt_ttl)
      //   {
      //   return(MSG_PTS_EXCD_PAMT_ERR);
      //   }
      //   }
      //   }
      //
      //   if (( rcChk_Custreal_PointInfinity_System( ) )			/* 顧客リアル[PI]仕様が有効かチェック*/
      //   && ( cm_ws_system( ) )						/* ワールド・スポーツ様特注仕様かチェック */
      //   && ( rcmbrChkStat() & RCMBR_STAT_POINT )			/* ポイント利用 */
      //   && ( CMEM->stat.FncCode == KY_CHA19 ))				/* 会計19固定 */
      //   {
      //   errNo = rc_PointInfinity_CheckPaidPointUseProc( lEntry, 0 );
      //   if ( errNo )
      //   {
      //   return errNo;
      //   }
      //   }
      //
      //
      //
      //   if( !(CMEM->stat.FncCode == KY_CASH)) {
      //   if((! KOPTTRAN.mul_flg) && (CMEM->working.data_reg.k_mul_0))
      //   return(MSG_INPUTERR);
      //   }
      //
      //   if((! KOPTTRAN.crdt_enble_flg) && (CMEM->stat.FncCode == KY_CRDT))
      //   return(MSG_NOCREDITERR);
      //
      //   if(CMEM->ent.tencnt > KOPTTRAN.digit)
      //   return(MSG_INPUTOVER);
      //
      //   if(cm_crdt_system()) {                               /* クレジット仕様   */
      //   if(! ((! cm_nttasp_system()) && (rcChk_Crdt_User() == KANSUP_CRDT) && (CMEM->working.crdt_reg.stat & 0x0020) && (CMEM->working.crdt_reg.stat & 0x0010))) { /* 伝票クレジットキー待ち？  */
      //   if(CMEM->working.crdt_reg.stat & (short)0x0020) { /* 同会計キー待ち？ */
      //   if(CMEM->stat.FncCode != CMEM->working.crdt_reg.crdtkey)
      //   return(MSG_SAMECRDTKEYIN);
      //   }
      //   }
      //   }
    }
    // TODO:10121 QUICPay、iD 202404実装対象外
    //     if(ldata == 0 && rcChk_Ten_On()){
    //       if((KOPTTRAN.frc_entry_flg == 2) && (rcCheck_AcbDec_NotUse()))
    //         KOPTTRAN.frc_entry_flg = 0;
    //       if((KOPTTRAN.frc_entry_flg == 2) && (CMEM->acbdata.total_price == 0))
    //         return(MSG_DECCIN_SET_INPUT_ERR);
    //     }
    //
    //     if(cm_sp_department_system()) {
    //       errNo = rcYao_ChkWorkTyp(CMEM->stat.FncCode, lEntry);
    //       if(errNo)
    //         return(errNo);
    //     }
    //
    //     #if DEPARTMENT_STORE
    //     if(rcChk_Department_System()) {
    //     switch(rcWorkin_Chk_WorkTyp(&MEM->tTtllog)) {
    //     case WK_ORDER:
    //     if(CMEM->stat.FncCode == KY_CHA10) {
    //     return(MSG_INPUTERR);
    //     } else if(CMEM->stat.FncCode == KY_CHA9) {
    //     if(! ((lEntry == 0) && (! rcChk_Ten_On())))
    //     return(MSG_INPUTERR);
    //     if(MEM->tTtllog.t100700.mbr_input)
    //     return(MSG_DEPOSITSHORT);
    //     }
    //     break;
    //     case WK_SCREDIT:
    //     if(CMEM->stat.FncCode == KY_CHA9) {
    //     if(! ((lEntry == 0) && (! rcChk_Ten_On())))
    //     return(MSG_INPUTERR);
    //     } else {
    //     return(MSG_INPUTERR);
    //     }
    //     break;
    //     case WK_CASHDELIVERY:
    //     if(CMEM->stat.FncCode == KY_CHA10) {
    //     return(MSG_INPUTERR);
    //     } else if(CMEM->stat.FncCode == KY_CHA9) {
    //     if(! ((lEntry == 0) && (! rcChk_Ten_On())))
    //     return(MSG_INPUTERR);
    //     } else {
    //     if(! ((lEntry == 0) && (! rcChk_Ten_On()))) {
    //     if(RxLogCalc.rxCalcStlTaxAmt(mem) <= lEntry) {
    //     return(MSG_NOOVERKEEP);
    //     }
    //     } else
    //     return(MSG_INPUTERR);
    //     }
    //     break;
    //     case WK_PLUMVST:
    //     if(CMEM->stat.FncCode == KY_CHA10) {
    //     if(! ((lEntry == 0) && (! rcChk_Ten_On())))
    //     return(MSG_INPUTERR);
    //     } else {
    //     return(MSG_INPUTERR);
    //     }
    //     break;
    //     case WK_SUMUP_ORDER:
    //     case WK_SUMUP_SCREDIT:
    //     case WK_CRDITRECEIV:
    //     case WK_ADDDEPOSIT:
    //     case WK_REMAINDERPAY:
    //     case WK_ANNUL_ORDER:
    //     case WK_ANNUL_SCREDIT:
    //     case WK_ANNUL_CASHDELIVERY:
    //     case WK_RET_CRDITRECEIV:
    //     if((CMEM->stat.FncCode == KY_CHA9) || (CMEM->stat.FncCode == KY_CHA10))
    //     return(MSG_INPUTERR);
    //     break;
    //     case WK_PLUMVEND:
    //     case WK_SUMUP_CASHDELIVERY:
    //     if(CMEM->stat.FncCode == KY_CASH) {
    //     if(! ((lEntry == 0) && (! rcChk_Ten_On())))
    //     return(MSG_INPUTERR);
    //     } else {
    //     return(MSG_INPUTERR);
    //     }
    //     break;
    //     case WK_OTHER:
    //     if(MEM->tTtllog.t100900.vmc_chgtckt_cnt < 0) {
    //     if(! ((rcChk_KY_CHA(CMEM->stat.FncCode)) && (KOPTTRAN.crdt_enble_flg == 1) && (KOPTTRAN.crdt_typ == 0))) {
    //     if((! rcChk_Ten_On()) || (RxLogCalc.rxCalcStlTaxAmt(mem) <= lEntry))
    //     return(MSG_CRDTKEY_INPUT);
    //     }
    //     }
    //     break;
    //     }
    //
    //     if((! rcChk_Ten_On()) || (RxLogCalc.rxCalcStlTaxAmt(mem) <= lEntry)){
    //     if(rcChk_SaleAmtVoid())
    //     return (MSG_PRCERR);
    //     }
    //     }
    //     #endif
    //
    //     #if IWAI
    // //   if (rcChk_ORC_System() && (CMEM->stat.FncCode == KY_CHA4)) { /* 沖ﾘﾗｲﾄ仕様で小計金額が0以下のときは会計4は動作させない */
    //     if (( rcChk_ORC_System() || rcChk_IWAI_Real_System() ) && (CMEM->stat.FncCode == KY_CHA4)) { /* 沖ﾘﾗｲﾄ仕様で小計金額が0以下のときは会計4は動作させない */
    //     if (RxLogCalc.rxCalcStlTaxAmt(mem) <= 0) return(MSG_PACKOVERERR);
    //     }
    //     #endif
    //     if (rcChk_ManualRbtCashKey())
    //     {
    //     if (RxLogCalc.rxCalcStlTaxAmt(mem) < 0 ) return(MSG_NOMINUSERR);
    //     if ((RxLogCalc.rxCalcStlTaxAmt(mem) == 0    ) ||
    //     (RxLogCalc.rxCalcStlTaxAmt(mem) < lEntry)) return(MSG_NOOVERKEEP);
    //     }
    //
    //     #if MC_SYSTEM
    //     if(rcChk_Mc_System() && (! ((MEM->tTtllog.t100700.mbr_input == MCARD_INPUT) && (AT_SING->mc_tbl.k_amount == KY_MCFEE))))
    //     {
    //     dmp = rxCalc_Stl_Tax_In_Amt(MEM);
    //
    //     if((MEM->tTtllog.t100700.mbr_input == MCARD_INPUT) && (AT_SING->mc_tbl.card_mng_fee > 0))
    //     dmp -= AT_SING->mc_tbl.card_mng_fee;
    //
    //     if(dmp == 0)
    //     return(MSG_TRC_TTL_ZERO);
    //     }
    //     #endif
    //
    //     if(C_BUF->db_trm.tranrceipt_barflg_equal_jan) {
    //     if(rcmbrChkStat() & RCMBR_STAT_POINT) {
    //     if((KOPTTRAN.crdt_enble_flg == 0) && (KOPTTRAN.crdt_typ == 6)) {
    //     rcmbr_TodayPoint(1);
    //     if(C_BUF->db_trm.pnt_high_limit) {
    //     if((MEM->tTtllog.t100700.lpnt_ttlsrv + MEM->tTtllog.t100700.dpnt_ttlsrv) > 999999)
    //     return(MSG_CHARG_OVER_LIMIT);
    //     }else{
    //     if((MEM->tTtllog.t100700.lpnt_ttlsrv + MEM->tTtllog.t100700.dpnt_ttlsrv) > 99999)
    //     return(MSG_CHARG_OVER_LIMIT);
    //     }
    //     }
    //     }
    //     }
    //
    //     if( CMEM->stat.FncCode != KY_CHA1 ) {
    //     if((C_BUF->db_trm.cardsheet_prn) && (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT) )
    //     return(MSG_OPEERR);
    //     }
    //
    //     if( CMEM->stat.FncCode == KY_CHA1 ) {
    //     if((C_BUF->db_trm.cardsheet_prn) && (!(MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT)) )
    //     return(MSG_OPEERR);
    //     }
    //
    //     if(rcChk_Custreal_Webser_System() && (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT)) {
    //     dmp = cm_bcdtol((char *)CMEM->ent.entry, sizeof(CMEM->ent.entry));
    //     if((rcCheck_chg10000Flg() == 1) && (chgFlg != 1) && ((dmp -RxLogCalc.rxCalcStlTaxAmt(mem)) > MAX_CHGAMT))
    //     return(MSG_MAX_CHANGEAMT_OVER);
    //     }
    //
    //     if( cm_hc2_Kuroganeya_system(GetTid()) == 1 )
    //     {
    //     short  errNo;
    //     errNo = rcChkKuroganeyaDenomiKind();
    //     if( errNo != 0 )
    //     {
    //     return	errNo;
    //     }
    //     }
    //
    //     if( rcChk_ChargeSlip_System() ){
    //     if ((rcsyschk_ayaha_system())
    //     && (MEM->tTtllog.t100700.mbr_input != NON_INPUT))
    //     {	/* アヤハディオ様の場合は、ここで売掛会員状態セット */
    //     rcmbrReadCust_ChargeMst (MEM->tHeader.cust_no, NULL);
    //     }
    //     if( rcChkMember_ChargeSlipCard() ){	/* 売掛会員の場合 */
    //     if( !(KOPTTRAN.crdt_enble_flg == 1 && KOPTTRAN.crdt_typ == 27 ) ){	/* 掛売:しない 種類:売掛伝票 */
    //     TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, "rcATCT_Proc_Error: Charge cust account error");
    //     return MSG_OPEMISS;	/* この操作は行えません */
    //     }
    //     }
    //     }
    //
    //     if((rcCheck_AcrAcb_ON(1) == ACR_COINBILL)
    //     && (RC_INFO_MEM->RC_CNCT.CNCT_ACB_DECCIN != 0))
    //     {
    //     if((rcCheck_ChgCin_Mode())
    //     || (CMEM->acbdata.total_price != 0)
    //     || (AcbInfo.AutoDecision_Fnal == 1))
    //     {
    //     if((rcChk_KY_CHA(CMEM->stat.FncCode)) && (C_BUF->db_trm.disable_chakey_acx))
    //     {
    //     return (MSG_ACX_DECCIN_KEY_ERR);
    //     }
    //     }
    //     }
    //
    //     if (   (cm_ds2_godai_system())					/* ゴダイ様特注 */
    //     && (MEM->tTtllog.t100002.quotation_flg)			/* 見積宣言時は売掛伝票、予約(見積り)のみ有効 */
    //     && (OK != rcKyQuotation_CheckPayKey(CMEM->stat.FncCode)) )
    //     {
    //     return (MSG_QUO_PAYKEY_ERR);
    //     }
    //
    //     if (rcsyschk_yunaito_hd_system())
    //     {
    //     if (C_BUF->db_trm.crdt_info_order == 1)
    //     {//特定ユーザー用　売掛会員仕様「する」の場合
    //     if ((KOPTTRAN.crdt_enble_flg == 1) && (KOPTTRAN.crdt_typ == 27))
    //     {//掛売登録「する」、掛売の種類「売掛伝票」の場青
    //     if (MEM->tTtllog.t100700.mbr_input != BAR_RECEIV_INPUT)
    //     {//掛売バーコードが読み込まれていない場合
    //     return(MSG_RECEIV_INPUT_ERR);
    //     }
    //     }
    //     }
    //     }

    return 0;
  }

  ///  関連tprxソース: rc_atct.c - rcATCT_ldata_Set
  static Future<int> rcATCTldataSet() async {
    int ldata = 0;
    RegsMem regsmem = SystemFunc.readRegsMem();
    RxCommonBuf cBuf = RxCommonBuf();

    ldata = RxLogCalc.rxCalcStlTaxAmt(regsmem);
    ldata += regsmem.tmpbuf.catalinaTtlamt ?? 0;
    if (cBuf.dbTrm.discBarcode28d != 0) {
      ldata += regsmem.tmpbuf.beniyaTtlamt ?? 0;
    }
    ldata += regsmem.tmpbuf.notepluTtlamt ?? 0;
    if (((await CmCksys.cmReservSystem() != 0) ||
            (await CmCksys.cmNetDoAreservSystem() != 0)) &&
        RcReserv.rcReservReceiptCall() &&
        await RcReserv.rcreservReceiptAdvance() != 0) {
      ldata += await RcReserv.rcreservReceiptAdvance();
    }
    return (ldata);
  }

  ///  関連tprxソース: rc_atct.c - rcATCT_Update
  static Future<int> rcATCTUpdate(TendType eTendType) async {
    int chkFncCd = 0;
    int i = 0;
    int dutyFlg = 0;
    int errNo = Typ.OK;
    List<int> edyCd = List.filled(21, 0);
    int savePreRctfmFlag = 0; // 領収書宣言状態の保持フラグ	0:領収書宣言ではない  1:領収書宣言
    RegsMem mem = SystemFunc.readRegsMem();

    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
        await RcCashless.rcCashlessSpritCncl(); // キャッシュレス還元仕様の還元なしキーステータスをマスク

        // TODO:10121 QUICPay、iD 202404実装対象外
        /*if((cMem.ent.errNo == OK) && (rcCheck_AcrAcb_ON(0))) {
          rcAcrAcb_StockSet();
        }*/
        RcIbCal0.rcStlItemCustCalc();

        // TODO:10121 QUICPay、iD 202404実装対象外
        /*if( !rcChk_Edy_System() && !rcChk_MultiEdy_System() && rcChk_Flight_System() ) {
      for(i=0;i < MEM->tTtllog.t100001Sts.sptend_cnt ;i++)       {
      chk_fnc_cd = MEM->tTtllog.t100100[MEM->tTtllog.t100001Sts.sptend_cnt].sptend_cd;
      if( chk_fnc_cd == 14 && C_BUF->db_trm.flight_system_cash )
      duty_flg = 1;
      if( chk_fnc_cd == 15 && C_BUF->db_trm.flight_system_cha1 )
      duty_flg = 1;
      if( chk_fnc_cd == 16 && C_BUF->db_trm.flight_system_cha2 )
      duty_flg = 1;
      if( chk_fnc_cd == 17 && C_BUF->db_trm.flight_system_cha3 )
      duty_flg = 1;
      }
      if( duty_flg == 0 ) {
      cm_mov(edy_cd, MEM->tTtllog.t100100[MEM->tTtllog.t100001Sts.sptend_cnt].edy_cd, sizeof(MEM->tTtllog.t100100[MEM->tTtllog.t100001Sts.sptend_cnt].edy_cd));
      memset( MEM->tTtllog.t100100[MEM->tTtllog.t100001Sts.sptend_cnt].edy_cd, 0x00, sizeof(MEM->tTtllog.t100100[MEM->tTtllog.t100001Sts.sptend_cnt].edy_cd ));
      }
      }
      #if RESERV_SYSTEM
      if( rcReserv_NotUpdate() )
      MEM->tHeader.prn_typ = TYPE_EJONLYRCPT;
      #endif
      if( rcChkPreRctfmPrint() == TRUE ){
      savePreRctfmFlag = MEM->tTtllog.t100001Sts.pre_rctfm_flg;
      }*/

        if (await RckyTaxFreeIn.rcTaxFreeChkTaxFreeIn() == 0) {
          RcTaxFreeSvr.rcTaxfreeClr();
        } else if (await RcSysChk.rcsyschkTaxfreeServerSystem() != 0) {
          if ((await RcFncChk.rcCheckVoidComDispMode()) || //訂正モード状態は送信しない
              mem.tTtllog.t109000.voucherNumber.isNotEmpty) {
            RcTaxFreeSvr.rcTaxfreeSvrDataClr();
          } else if (mem
              .tTtllog
              .t109000
              .cnceledVoucherNumber
              .isNotEmpty) {
            //元免税伝票番号がセットされた場合は取消送信
            await RcTaxFreeSvr.rcTaxfreeComm(
                TaxfreeOrder.TAXFREE_ORDER_CNCL_SALES.id, null, 0);
          } else {
            await RcTaxFreeSvr.rcTaxfreeComm(
                TaxfreeOrder.TAXFREE_ORDER_ADD_SALES.id, null, 0);
          }
        } else {
          RcTaxFreeSvr.rcTaxfreeSvrDataClr();
        }

        // 実績上げタスクへの送信
        if (RcKyPbchg.rckyPbchgRecChk() != 0) {
          // TODO:10121 QUICPay、iD 202404実装対象外
          //errNo = rc_Send_PbchgUpdate();
        } else {
          // TODO:10121 QUICPay、iD 202404実装対象外
          /*if( savePreRctfmFlag == 1 ){
        if( rxChkKoptCmnPreRctfmPlus(C_BUF) == TRUE ){
        rcSaveRevenueStampData();
        rcClearRevenueStampData();
        }
        }*/
          errNo = RcIfEvent.rcSendUpdate();

          // TODO:10121 QUICPay、iD 202404実装対象外
          /*if( savePreRctfmFlag == 1 ){
      if( rxChkKoptCmnPreRctfmPlus(C_BUF) == TRUE ){
      rcLoadRevenueStampData();
      }
      }*/
        }

        // TODO:10121 QUICPay、iD 202404実装対象外
        /*if(rcChk_WS_System())
      {
      rcFuncbar_CardForgetTbl_WS();	// カード忘れ管理テーブルへの変更
      }


      #if RESERV_SYSTEM
      if((cm_Reserv_system() || cm_netDoAreserv_system()) && rcreserv_ReceiptCall() && (!rcCheck_ReservMode()) ) {
      rcreserv_CallUpdate(0);
      }
      else if( cm_Reserv_system() && rcNetreserv_ReceiptCall() && (!rcCheck_ReservMode()) ) {
      if( rcreserv_NetReservFinishUpdate() != OK )
      errNo = MSG_NETRESERV_WT_ERR;
      }
      #endif
      if( rcky_SelPluAdj_SelctMode() ) {
      rcKySelPluAdj_SelFlgClr();
      }
      if( !rcChk_Edy_System() && !rcChk_MultiEdy_System() && duty_flg == 0 && rcChk_Flight_System() )
      cm_mov(MEM->tTtllog.t100100[MEM->tTtllog.t100001Sts.sptend_cnt].edy_cd, edy_cd, sizeof(MEM->tTtllog.t100100[MEM->tTtllog.t100001Sts.sptend_cnt].edy_cd));

//       printf("call rul_main function \n");
      #if !DEPARTMENT_STORE
      if(rcVD_OpeModeChk() == TRUE) {
      CMEM->ent.warn_no = MSG_CORRECTED;
      }
      #endif
      if(rcSR_OpeModeChk() == TRUE) {
      CMEM->ent.warn_no = MSG_PRD_SCRPIN;
      }
      else if(rcOD_OpeModeChk() == TRUE) {
      CMEM->ent.warn_no = MSG_PRD_ORDRIN;
      }
      else if(rcIV_OpeModeChk() == TRUE) {
      CMEM->ent.warn_no = MSG_PRD_INVTIN;
      }
      else if(rcPD_OpeModeChk() == TRUE) {
      CMEM->ent.warn_no = MSG_PRD_PRDIN;
      }

      #if 0
//@@@V15	旧プロモーション系は後日対応
      if(rcChk_Prom_System() && cm_tb1_system())
      {
      if((MEM->tTtllog.t101000[0].prom_ticket_no > 0) ||
      (MEM->tTtllog.t101000[1].prom_ticket_no > 0) ||
      (MEM->tTtllog.t101000[2].prom_ticket_no > 0) ||
      (MEM->tTtllog.t101000[3].prom_ticket_no > 0) ||
      (MEM->tTtllog.t101000[4].prom_ticket_no > 0) ||
      (MEM->tTtllog.t101000[5].prom_ticket_no > 0) ||
      (MEM->tTtllog.t101000[6].prom_ticket_no > 0) ||
      (MEM->tTtllog.t101000[7].prom_ticket_no > 0) )
      {
      CMEM->ent.warn_no = MSG_TEXT163;
      if(C_BUF->db_trm.rvt_beep)
      {
      if(rcmbr_msc_chk() == 1 || rcmbr_msc_chk() == 3)
      {
      if_music_cshr(MUSIC_FANFARE);
      }
      else
      {
      if_music(MUSIC_FANFARE);
      }
      }
      }
      }
      #endif	//@@@V15

      if(rcChk_Custreal_UID_System() && (CMEM->ent.warn_no) && (((TS_BUF->custreal2.stat) && (CMEM->ent.err_stat)) || (AT_SING->uid_err_stat)))
      CMEM->ent.warn_no = 0;
      else if(cm_nimoca_point_system() && (CMEM->ent.warn_no) && (CMEM->ent.err_stat))
      CMEM->ent.warn_no = 0;*/

        RckyStl.rcDisableFlgSet();
        // TODO:10121 QUICPay、iD 202404実装対象外
        /*if( (errNo == OK) && (savePreRctfmFlag == 1) ){
      rcRfm_Write_rcpt_no(NULL);
      // 領収書宣言での領収書実績作成処理
      if( rxChkKoptCmnPreRctfmPlus(C_BUF) == TRUE ){
      rcRfm_Data_Set();
      rc_Set_Date();
      // 元取引情報をc_header_logへ設定
      rcRfm_HeaderVoidInfoSet( (char *)&MEM->tHeader );
      MEM->tHeader.receipt_no = competition_get_rcptno(GetTid());
      MEM->tHeader.print_no   = competition_get_printno(GetTid()) + 1;	// print_noのみ加算
      if( MEM->tHeader.print_no > 9999 ){
      MEM->tHeader.print_no = 1;
      }
      MEM->tHeader.prn_typ = TYPE_RFM2;
      */
        /* 領収書制限が設定されている場合への対処 */
        /*
      rcRfm_SetSaveReceiptNo( MEM->tHeader.receipt_no );
      rc_Send_Update();
      rcRfm_Data_BkSet();
      rc_Inc_RctJnlNo( 0 );
      }
      }*/
        break;

      case TendType.TEND_TYPE_SPRIT_TEND:
      case TendType.TEND_TYPE_POST_TEND_START:
      case TendType.TEND_TYPE_POST_TEND_END:
      case TendType.TEND_TYPE_CALC_TEND_START:
      case TendType.TEND_TYPE_CALC_TEND_END:
      case TendType.TEND_TYPE_SPOOL_IN:
      default:
        break;
    }
    return errNo;
  }

  ///  関連tprxソース: rc_atct.c - rcATCTMbr_Update
  static Future<void> rcATCTMbrUpdate(TendType eTendType) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcATCTMbrUpdate() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
        if ((cBuf.dbTrm.disableRecoverFeeSvscls1 != 0) &&
            ((mem.tTtllog.t100702.joinFeeAmt != 0) ||
             (mem.tTtllog.t100001Sts.itemlogCnt != 0))) {
          RcMbrFlWr.rcMbrCustLogUpdate(
              mem.tTtllog, mem.prnrBuf); /* Update c_cust_log */
        } else if (RckyMulRbt.rcChkMulRbtInput(1)) {
          RcMbrFlWr.rcMbrCustLogUpdate(
              mem.tTtllog, mem.prnrBuf); /* Update c_cust_log */
        } else if (mem.tTtllog.t100001Sts.itemlogCnt != 0) {
          RcMbrFlWr.rcMbrCustLogUpdate(mem.tTtllog, mem.prnrBuf); /* Update c_cust_log */
          if (CompileFlag.ARCS_MBR) {
            if (await CmMbrSys.cmNewARCSSystem() != 0) {
              if (RcSysChk.rcChkCustrealNecSystem(0) != 0) {
                RcMbrPoiCal.rcStlMbrSrvDsp();
              }
            }
          }
        }
        break;
      case TendType.TEND_TYPE_SPRIT_TEND:
      case TendType.TEND_TYPE_POST_TEND_START:
      case TendType.TEND_TYPE_POST_TEND_END:
      case TendType.TEND_TYPE_CALC_TEND_START:
      case TendType.TEND_TYPE_CALC_TEND_END:
      case TendType.TEND_TYPE_SPOOL_IN:
      default:
        break;
    }
  }

  //実装は必要だがARKS対応では除外
  ///  関連tprxソース: rc_atct.c - rcATCT_Fresta_DivideDisp_Proc
  static bool rcATCTFrestaDivideDispProc() {
    return false;
  }

  ///  関連tprxソース: rc_atct.c - rcATCT_Proc
  static Future<TendType> rcATCTProc() async {
    TendType eTendType = TendType.TEND_TYPE_ERROR; // tender type
    int ret = 0;
    int errNo = 0;
    int notepluChgFlg = 0;
    int drvCd = 0;
    int typ = 0;
    int kindCd = 0;
    String log = "";
    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
      autoSptendCnt = 0;
    }
    int prizeNo = 0;
    int payTyp = 0;

    AcMem cMem = SystemFunc.readAcMem();
    KopttranBuff kopttran = KopttranBuff();
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return TendType.TEND_TYPE_ERROR;
    }
    RxCommonBuf cBuf = xRet.object;

    String funcName = "rcATCTProc";

    ret = await RcIfPrint.rcStatusRead();
    await rcStlCalcProc();
    if (ret == InterfaceDefine.IF_TH_POK) {
      RcIfPrint.rcStatusGet();
    } else {
      cMem.stat.prnStatus = RcRegs.PRN_ERROR;
    }

    // #if CN_NSC
    // if(!((rcChk_NSC_System()) && (rcChk_NSC_KeyOpt()))){
    // #endif
    cMem.ent.errNo = await rcAtctProcError2(0);
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if (await RcSysChk.rcSGChkSelfGateSystem()) {
    //   if (cMem.ent.errNo == ok) {
    //     RcKeyCash.mntDsp.sgCashkyFlg = 0;
    //   }
    // }

    // 後通信後、又は、再計算処理中に発生したエラーは、無視する
    // ※後通信の場合は通信処理の前にチェックしている為
    if ((cMem.ent.errNo != ok) &&
        ((await RcLastcomm.rcLastCommChkCommEnd()) ||
            (rcATCTProcCheckPassFlag()))) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "$funcName(): error change -> OK [${cMem.ent.errNo}]\n");
      cMem.ent.errNo = ok;
    }

    // if ((RcSysChk.rcChkRPointMbrReadTMCQCashier() != 0)	/* タカラ様仕様での精算機で楽天ポイントカード読込可能なレジ */
    //     && (RcFncChk.rcQCCheckRPtsMbrReadMode()))		/* 精算機での楽天ポイントカード読込画面かチェック */
    // {
    //   if (cMem.ent.errNo != ok)
    //   {
    //     /* 該当の画面制御からの再計算中に発生するエラーを置き換える */
    //     TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
    //         "${funcName}:QCashier rcATCT_Proc_Error[before:${cMem.ent.errNo}]\n");
    //     cMem.ent.errNo = DlgConfirmMsgKind.MSG_QC_RPNTREAD_INTERRUPT_AMTERR.dlgId;
    //   }
    // }
    //
    // if ( (await RcFncChk.rcChkQcashierMemberReadSystem())			/* 精算機で会員カード読取可能なレジ */
    // && (await RcFncChk.rcChkQcashierMemberReadEntryMode()) )	/* 精算機での会員カード読取画面かチェック */
    // {
    //   if (cMem.ent.errNo != ok)
    //   {
    //   /* 該当の画面制御からの再計算中に発生するエラーを置き換える */
    //     TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
    //         "${funcName}:QCashier Member Read rcATCT_Proc_Error[before:${cMem.ent.errNo}]\n");
    //     cMem.ent.errNo = DlgConfirmMsgKind.MSG_QCASHIER_INTERRUPT_AMTERR.dlgId;
    //   }
    // }

    if (cMem.ent.errNo != 0) {
      if (await RckyRegassist.rcCheckRegAssistPaymentAct(cMem.ent.errNo)) {
        if (RcSysChk.rcChkWSSystem()) {
          if (cMem.stat.fncCode == FuncKey.KY_CHA6.keyId &&
              cMem.ent.errNo ==
                  DlgConfirmMsgKind.MSG_PAYMENT_PRICE_NEED.dlgId) {
            await RcExt.rcErr(funcName, cMem.ent.errNo);
            return TendType.TEND_TYPE_ERROR;
          }
        }
        RckyRegassist.rcRegAssistPaymentDisp();
        cMem.ent.errNo = 0;
      } else {
        await RcExt.rcErr(funcName, cMem.ent.errNo);
      }
      if (RcSysChk.rcsyschkSm66FrestaSystem() &&
          mem.tTtllog.t100001Sts.fgTtlUse != 0) {
        for (int i = 0; i < mem.tTtllog.t100001Sts.fgTtlUse; i++) {
          mem.tTtllog.t100906[i].useAmt = 0;
          mem.tTtllog.t100906[i].serialNo = "";
        }
      }
      return TendType.TEND_TYPE_ERROR;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行は1464-1965

    if (qcNotepluChangeFlg != 0) {
      if (cMem.ent.tencnt == 0) {
        cMem.ent.tencnt = 1;
      }
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行は1973-2134

    eTendType = await rcATCTMakeSPTendBuf();
    if(eTendType == TendType.TEND_TYPE_ERROR) {
      return eTendType;
    }


    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行は2140-2200

    if (await RcSysChk.rcCheckSegment()) {
      await setTendType(eTendType);
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行は2205-2223

    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
      case TendType.TEND_TYPE_POST_TEND_END:
        // 釣銭釣札機ON & 通番訂正差額設定
        AtSingl atSing = SystemFunc.readAtSingl();
        if (RcFncChk.rcFncchkRcptAcracbCheck()) {
          if ((atSing.rcptCash.status == 1) || (atSing.rcptCash.actChk != 0)) {
            /* 釣銭動作が最後のため、印字用に保持する */
            mem.tTtllog.t100002Sts.rcptCashPay = atSing.rcptCash.pay!;
            mem.tTtllog.t100002Sts.rcptCashStatus =
                atSing.rcptCash.status;
          }
        }

        await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttran);

        if (((CompileFlag.SELF_GATE == true) &&
                (!await RcSysChk.rcSGChkSelfGateSystem())) ||
            (CompileFlag.SELF_GATE == false)) {
          if (!await RcSysChk.rcQCChkQcashierSystem()) {
            if (!RcSysChk.rcSROpeModeChk() &&
                !RcSysChk.rcODOpeModeChk() &&
                !RcSysChk.rcIVOpeModeChk() &&
                !RcSysChk.rcPDOpeModeChk()) {
              if (((CompileFlag.CN == true) &&
                      (!(RxLogCalc.rxCalcStlTaxInAmt(RegsMem()) != 0))) ||
                  (CompileFlag.CN == false)) {
                if ((RckyCha.rcChkEdyKeyOpt()) ||
                    (RckyCha.rcChkMultiEdyKeyOpt())) {
                  cMem.stat.clkStatus |= RcIf.OPEN_DRW;
                } else {
                  if ((await RcAcracb.rcCheckAcrAcbON(1) ==
                          CoinChanger.ACR_COINBILL) &&
                      ((!(atSing.bkupAcrOnoff != 0)) &&
                          (!(atSing.bkupAcbOnoff != 0)))) {
                    if ((kopttran.acbDrwFlg == 1) ||
                        (cMem.acbData.acbDrwFlg == 1) ||
                        ((await CmCksys.cmMarutoSystem() != 0) &&
                            (cMem.acbData.splitPrice == 0) &&
                            (cMem.acbData.totalPrice == 0) &&
                            ((cMem.stat.fncCode == FuncKey.KY_CASH.keyId) ||
                                (mem.tTtllog.t100200[AmtKind.amtCash.index]
                                    .amt !=
                                    0)))) {
                      /* 06.10.20 T.Habara */
                      if ((!await RcFncChk.rcCheckERefIMode()) &&
                          (!await RcFncChk.rcCheckERefSMode()) &&
                          (!await RcFncChk.rcCheckESVoidIMode()) &&
                          (!await RcFncChk.rcCheckESVoidSMode()) &&
                          ((kopttran.stlOverFlg == 2) ||
                              ((await RcSysChk.rcCheckIndividChange()) &&
                                  (cMem.stat.fncCode ==
                                      FuncKey.KY_CASH.keyId)) ||
                              ((kopttran.nochgFlg == 2) &&
                                  (kopttran.tranUpdateFlg == 0)))) {
                        TprLog().logAdd(
                            await RcSysChk.getTid(),
                            LogLevelDefine.normal,
                            "$funcName rc_drwopen() Skip");
                      } else {
                        if (cBuf.dbTrm.seikatsuclubOpe != 0) {
                          if (!rcChkSptendAllcha1key()) {
                            RcIfPrint.rcDrwopen(); /* drawer open */
                            cMem.stat.clkStatus |= RcIf.OPEN_DRW;
                            // TODO:00012 (rxmem.c - STAT_drw_get)
                            // ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= OPEN_DRW;
                          }
                        } else {
// #if DEPARTMENT_STORE
//                   if (rcChk_Department_System()) {
//                     if (rcChk_DrwOpen_Department(&KOPTTRAN))
//                       TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0,
//                           "rcATCT_Proc rc_drwopen() Skip for Department System\n");
//                     else {
//                       if (!((rcCheck_Individ_Change() == TRUE) &&
//                               (rcWorkin_Chk_WorkTyp(&MEM.tTtllog) == WK_ORDER) &&
//                               (cMem.stat.FncCode == KY_CASH ||
//                                   cMem.stat.FncCode == KY_CHK1 ||
//                                   cMem.stat.FncCode == KY_CHK2)))
//                         rc_drwopen(); /* drawer open */
//                       cMem.stat.ClkStatus |= OPEN_DRW;
//                       ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |=
//                           OPEN_DRW;
//                     }
//                   } else {
// #endif
                          if (await RcSysChk.rcCheckWizAdjUpdate()) {
                            TprLog().logAdd(
                                await RcSysChk.getTid(),
                                LogLevelDefine.normal,
                                "$funcName rc_drwopen() Skip for WizAdj_Update\n");
                          } else {
                            if (CompileFlag.ARCS_MBR) {
                              if (await RcAtct.rcATCTDrwopenchk()) {
                                RcIfPrint.rcDrwopen(); /* drawer open */
                                cMem.stat.clkStatus |= RcIf.OPEN_DRW;
                                // TODO:00012 (rxmem.c - STAT_drw_get)
                                // ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= OPEN_DRW;
                              }
                            } else {
                              RcIfPrint.rcDrwopen(); /* drawer open */
                              cMem.stat.clkStatus |= RcIf.OPEN_DRW;
                              // TODO:00012 (rxmem.c - STAT_drw_get)
                              // ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= OPEN_DRW;
                            }
                          }
// #if DEPARTMENT_STORE
//                   }
// #endif
                        }
                      }
                    } else {
                      cMem.stat.clkStatus &= ~RcIf.OPEN_DRW;
                    }
                  } else {
                    /* 06.10.20 T.Habara */
                    if ((!await RcFncChk.rcCheckERefIMode()) &&
                        (!await RcFncChk.rcCheckERefSMode()) &&
                        (!await RcFncChk.rcCheckESVoidIMode()) &&
                        (!await RcFncChk.rcCheckESVoidSMode()) &&
                        ((kopttran.stlOverFlg == 2) ||
                            ((await RcSysChk.rcCheckIndividChange()) &&
                                (cMem.stat.fncCode == FuncKey.KY_CASH.keyId)) ||
                            ((kopttran.nochgFlg == 2) &&
                                (kopttran.tranUpdateFlg == 0)))) {
                      TprLog().logAdd(await RcSysChk.getTid(),
                          LogLevelDefine.normal, "$funcName rc_drwopen() Skip");
                    } else {
                      if (cBuf.dbTrm.seikatsuclubOpe != 0) {
                        if (!rcChkSptendAllcha1key()) {
                          RcIfPrint.rcDrwopen(); /* drawer open */
                          cMem.stat.clkStatus |= RcIf.OPEN_DRW;
                          // TODO:00012 (rxmem.c - STAT_drw_get)
                          // ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= OPEN_DRW;
                        }
                      } else {
// #if DEPARTMENT_STORE
//                 if (rcChk_Department_System()) {
//                   if (rcChk_DrwOpen_Department(&KOPTTRAN))
//                     TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0,
//                         "rcATCT_Proc rc_drwopen() Skip for Department System\n");
//                   else {
//                     if (!((rcCheck_Individ_Change() == TRUE) &&
//                             (rcWorkin_Chk_WorkTyp(&MEM.tTtllog) == WK_ORDER) &&
//                             (cMem.stat.FncCode == KY_CASH ||
//                                 cMem.stat.FncCode == KY_CHK1 ||
//                                 cMem.stat.FncCode == KY_CHK2)))
//                       rc_drwopen(); /* drawer open */
//                     cMem.stat.ClkStatus |= OPEN_DRW;
//                     ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |=
//                         OPEN_DRW;
//                   }
//                 } else {
// #endif
                        if (await RcSysChk.rcCheckWizAdjUpdate()) {
                          TprLog().logAdd(
                              await RcSysChk.getTid(),
                              LogLevelDefine.normal,
                              "$funcName rc_drwopen() Skip for WizAdj_Update\n");
                        } else if ((await RcSysChk.rcQRChkPrintSystem()) &&
                            (RcKeyCash.mntDsp.sgCashkyFlg == 1)) {
                          TprLog().logAdd(
                              await RcSysChk.getTid(),
                              LogLevelDefine.normal,
                              "$funcName rc_drwopen() Skip for rcQR_Chk_Print_System\n");
                        } else {
                          if (CompileFlag.ARCS_MBR) {
                            if (await RcAtct.rcATCTDrwopenchk()) {
                              RcIfPrint.rcDrwopen(); /* drawer open */
                              cMem.stat.clkStatus |= RcIf.OPEN_DRW;
                              // TODO:00012 (rxmem.c - STAT_drw_get)
                              // ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= OPEN_DRW;
                            }
                          } else {
                            RcIfPrint.rcDrwopen(); /* drawer open */
                            cMem.stat.clkStatus |= RcIf.OPEN_DRW;
                            // TODO:00012 (rxmem.c - STAT_drw_get)
                            // ((RX_TASKSTAT_DRW *)STAT_drw_get(TS_BUF))->PrnStatus |= OPEN_DRW;
                          }
                        }
// #if DEPARTMENT_STORE
//                 }
// #endif
                      }
                    }
                  }
                }
              }
            }
          }
        }

        await RcRecno.rcSetRctJnlNo();
        await RcSlip.rcSetSlipNo(); // 伝票番号(業務モード仕様)
        await RcOrder.rcSetOrderNo(); // 発注番号(業務モード仕様)

        if (CompileFlag.MP1_PRINT) {
          await rcATCTMP1FlagReset();
        }
        if (((CompileFlag.PROM == true) && (!RcSysChk.rcChkRecipeSystem())) ||
            (CompileFlag.PROM == false)) {
          for (int i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
            if (i == 0) {
              // 保証書発行番号
              CompetitionIniRet retGuaranteeNo =
                  await CompetitionIni.competitionIniGet(
                      Tpraid.TPRAID_CHK,
                      CompetitionIniLists.COMPETITION_INI_GUARANTEE_NO,
                      CompetitionIniType.COMPETITION_INI_GETSYS);
              mem.tTtllog.t100001Sts.guaranteeNo = retGuaranteeNo.value;
              // 販売証明書発行番号
              CompetitionIniRet retCertificateNo =
                  await CompetitionIni.competitionIniGet(
                      Tpraid.TPRAID_CHK,
                      CompetitionIniLists.COMPETITION_INI_CERTIFICATE_NO,
                      CompetitionIniType.COMPETITION_INI_GETSYS);
              mem.tTtllog.t100001Sts.certificateNo = retCertificateNo.value;
            }
            if ((RcFncChk.rcfncchkCertPrintChk(i) == 1) // 保証書
                && (mem.tItemLog[i].t10002.scrvoidFlg == false)) {
              mem.tTtllog.t100002.guaranteeShtQty +=
                  (mem.tItemLog[i].t10000.itemTtlQty -
                      mem.tItemLog[i].t10002.scrvoidQty);
            } else if ((RcFncChk.rcfncchkCertPrintChk(i) == 2) // 販売証明書
                && (mem.tItemLog[i].t10002.scrvoidFlg == false)) {
              mem.tTtllog.t100002.certificateShtQty +=
                  (mem.tItemLog[i].t10000.itemTtlQty -
                      mem.tItemLog[i].t10002.scrvoidQty);
            }
          }
        } else {
          // TODO:10121 QUICPay、iD 202404実装対象外
          // 通らないケースなのでコメントアウト中
          // rcATCT_RecipeData_Set();
        }

        // TODO:10121 QUICPay、iD 202404実装対象外
        // 対象行は2431-2451

        await RcSetDate.rcSetDate();
        RcSet.rcClearRepeatBuf();
        // TODO:10121 QUICPay、iD 202404実装対象外
        // 拡張小計のUI関連
        // rcKyExtKey_LeftMove();
        break;
      default:
        break;
    }

    await rcATCTMakeTotalBuf(eTendType);
    if (CompileFlag.MBR_SPEC) {
      // FNC(ATCT_Make_MbrSpecBuf)(ptSPTendBuf, eTendType);
    }
    await rcATCTMakeSalesTrans(eTendType);
    mem.tTtllog.t100001Sts.sptendCnt++; // set next split tend count
    int splitPrice = cMem.acbData.splitPrice + cMem.acbData.totalPrice;
    cMem.acbData.splitPrice = splitPrice; // 釣銭機入金額(スプリットデータ:取消時返金額)

    // 置数クレジット/プリペイド 退避していた入金額をクリアする
    atSing.saveAcbTotalPrice = 0;

    qcNotepluChangeFlg = 0;
    rcProcAddTicket(); // 券面のみ金種の枚数加算処理

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行は2474-2536

    if ((await CmCksys.cmIchiyamaMartSystem() != 0) &&
        (rcATCTVoidRefundChkIchiyama())) {
      //  memset(MEM->tHeader.cust_no, 0, sizeof(MEM->tHeader.cust_no));
      //   memset(MEM->tTtllog.t100700.mag_mbr_cd, 0, sizeof(MEM->tTtllog.t100700.mag_mbr_cd));
      mem.tTtllog.t100700.mbrInput = MbrInputType.nonInput.index;
      // memset(MEM->tTtllog.t100700.mbr_name_kanji1, ' ', sizeof(MEM->tTtllog.t100700.mbr_name_kanji1));
      // memset(MEM->tTtllog.t100011.errcd, ' ', sizeof(MEM->tTtllog.t100011.errcd));
    }
    if ((!await RcFncChk.rcCheckERefIMode()) &&
        (!(await RcFncChk.rcCheckERefSMode()))) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      //   if (rcmbrChkStat() & RCMBR_STAT_FSP) {
      //     rcmbrSetFspTotalLog();
      //   }
      //   #if ARCS_MBR
      //   if( cm_NewARCS_system() && rcChk_RalseCard_System() && (MEM->tTtllog.t100700Sts.mbr_typ == MCD_RLSCARD) ) {
      // if( rcNewARCS_ChkHouseCrdtReceipt( &MEM->tTtllog ) )
      // MEM->tTtllog.t100700Sts.mbr_typ = MCD_RLSHOUSE;
      // else if( rcNewARCS_ChkPrepaidReceipt( &MEM->tTtllog ) )
      // MEM->tTtllog.t100700Sts.mbr_typ = MCD_RLSPREPAID;
      // }
      // #endif
      if (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT) != 0) {
        if ((!(await CmCksys.cmIchiyamaMartSystem() != 0) &&
            (rcATCTVoidRefundChkIchiyama()))) {
          // TODO:10121 QUICPay、iD 202404実装対象外
          // 中身が実装され次第、コメントアウトを解除する
          // RcMbrPoiCal.rcmbrTodayPoint(0);
          // RcMbrPttlSet.rcmbrPTtlSet();
        }
      }
      await rcATCTRcptMsgTcKtTotalBuf(eTendType);

      // TODO:10121 QUICPay、iD 202404実装対象外
      // 対象行は2565-2584

      // 最終来店日
      if (!await RcSysChk.rcChkOneToOnePromSystem()) {
        if(mem.custTtlTbl.last_visit_date != null){
          mem.tTtllog.t100700Sts.lastVisitDate =
          mem.custTtlTbl.last_visit_date!;
        }
      }

      // TODO:10121 QUICPay、iD 202404実装対象外
      // #if VISMAC
      // if((MEM->tTtllog.t100700.mbr_input != NON_INPUT) &&
      // (eTendType == TEND_TYPE_NO_ENTRY_DATA || eTendType == TEND_TYPE_TEND_AMOUNT)) {
      // Set_VismacTypeDATA();
      // }
      // #endif
      // if(rcChk_Custreal_OP_System() && (eTendType == TEND_TYPE_NO_ENTRY_DATA || eTendType == TEND_TYPE_TEND_AMOUNT)){
      // if(MEM->tTtllog.t100700.real_custsrv_flg && (rxCalc_Stl_Tax_In_Amt(MEM) == 0))
      // MEM->tTtllog.t100700.real_custsrv_flg = 0;
      // }
      if (((eTendType == TendType.TEND_TYPE_NO_ENTRY_DATA) ||
              (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) &&
          ((!RcFncChk.rcCheckMbrInput()) ||
              (!RcMbrKyMstp.rcChkFrestaFspPntStamp()))) {
        RckySpbarcodeRead.rcSpBarCodeFspPntClr();
      }

      if (!((await CmCksys.cmIchiyamaMartSystem() != 0) &&
          (rcATCTVoidRefundChkIchiyama()))) {
        await RcMbrCmSrv.rcmbrComCashSet(1); // 会員共通データセット
      }

      // TODO:10121 QUICPay、iD 202404実装対象外
      // if((((cm_nimoca_point_system())
      //     && (MEM->tTtllog.t100700.mbr_input == NIMOCA_INPUT))
      //     ||(rcChk_Custreal_Pointartist_System()))
      //     && (MEM->tTtllog.t100003.void_flg == 1))
      // {
      //   rcNimoca_esvoid_DATA();
      // }

      if ((await CmCksys.cmCrdtSystem() != 0) &&
          (await CmCksys.cmMcSystem() == 0)) {
        // TODO:10121 QUICPay、iD 202404実装対象外
        //   #if !MC_SYSTEM
        //   if(rcChk_CAPS_CAFIS_System())
        // rcCAPS_Make_ActualLog(eTendType);
        // else if(cm_CAPS_PQVIC_system())
        // rcCapsPQvic_Make_ActualLog(eTendType);
        // else if(rcChk_CAPS_CAFIS_Standard_System()){
        // if(cm_caps_cardnet_system())
        // rcCAPS_CARDNET_Make_ActualLog(eTendType);
        // else
        // rcCAPS_CAFIS_Make_ActualLog(eTendType);
        // }
        // else
        if (await CmCksys.cmNttaspSystem() == 0) {
          rcCardCrewMakeActualLog(eTendType);
        }
        // TODO:10121 QUICPay、iD 202404実装対象外
        // else
        //   #endif
        // rcATCT_Make_ActualLog(eTendType);
      }
      //   if(rcChk_NW7_System() && (C_BUF->db_trm.nw7mbr_real) &&
      //       (MEM->tTtllog.t100700.mbr_input != NON_INPUT) && (MEM->tTtllog.t100700.real_custsrv_flg == 0)){
      //     if( (MEM->tHeader.ope_mode_flg != OPE_MODE_TRAINING) && (eTendType == TEND_TYPE_NO_ENTRY_DATA || eTendType == TEND_TYPE_TEND_AMOUNT))
      //       rcMbrReal_CashTxt();
      //   }
      //
      //   #if PSP_70
      //   if(rcChk_Psp70Card_System()) {
      // rcATCT_Make_EdyTrans(eTendType);
      // }
      // #endif

      if (CompileFlag.PROM) {
        rcStlItemPromSet(eTendType);
      }
      if (CompileFlag.RALSE_CREDIT) {
        if (RcSysChk.rcChkRalseCardSystem() &&
            mem.tTtllog.t100700Sts.mbrTyp != 0) {
          mem.tTtllog.t100100[0].edyCd = mem.tmpbuf.rcarddata.chkcd;
          if (CompileFlag.ARCS_MBR) {
            if ((await CmCksys.cmUt1QUICPaySystem() != 0) ||
                (await CmCksys.cmUt1IDSystem() != 0)) {
              payTyp = mem.tCrdtLog[0].t400000.space;
            } else {
              payTyp = 0;
            }

            if ((mem.tmpbuf.rcarddata.typ == Mcd.MCD_RLSCRDT) ||
                (mem.tmpbuf.rcarddata.typ == Mcd.MCD_RLSOTHER)) {
              if (mem
                      .tmpbuf
                      .rcarddata
                      .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]
                      .length >=
                  16) {
                mem.tTtllog.t100100[1].edyCd = (mem
                        .tmpbuf
                        .rcarddata
                        .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6])
                    .substring(0, 16);
              }else{
                mem.tTtllog.t100100[1].edyCd = (mem
                    .tmpbuf
                    .rcarddata
                    .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]);
              }
            } else if (mem.tmpbuf.rcarddata.typ == Mcd.MCD_RLSVISA) {
              if ((mem
                          .tmpbuf
                          .rcarddata
                          .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6])
                      .length >=
                  16) {
                mem.tTtllog.t100100[1].edyCd = (mem
                        .tmpbuf
                        .rcarddata
                        .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6])
                    .substring(0, 16);
              }else{
                mem.tTtllog.t100100[1].edyCd = (mem
                    .tmpbuf
                    .rcarddata
                    .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]);
              }
            }

            if ((payTyp != 2) && (payTyp != 3)) {
              /* iD、QUICPay以外を対象とする */
              if ((mem.tmpbuf.rcarddata.typ == Mcd.MCD_RLSCRDT) ||
                  (mem.tmpbuf.rcarddata.typ == Mcd.MCD_RLSOTHER)) {
                if (mem
                        .tmpbuf
                        .rcarddata
                        .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]
                        .length >=
                    16) {
                  mem.tTtllog.t100010.invoiceNo = (mem
                          .tmpbuf
                          .rcarddata
                          .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6])
                      .substring(0, 16);
                }else{
                  mem.tTtllog.t100010.invoiceNo = (mem
                      .tmpbuf
                      .rcarddata
                      .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]);
                }
              } else if (mem.tmpbuf.rcarddata.typ == Mcd.MCD_RLSVISA) {
                if (mem
                        .tmpbuf
                        .rcarddata
                        .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]
                        .length >=
                    16) {
                  mem.tTtllog.t100010.invoiceNo = (mem
                          .tmpbuf
                          .rcarddata
                          .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6])
                      .substring(0, 16);
                }else{
                  mem.tTtllog.t100010.invoiceNo = (mem
                      .tmpbuf
                      .rcarddata
                      .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]);
                }
              }
              if (await CmMbrSys.cmNewARCSSystem() != 0) {
                if ((mem.tTtllog.t100900.todayChgamt != 0) &&
                    (mem.tTtllog.t100700Sts.mbrTyp == Mcd.MCD_RLSCARD)) {
                  mem.tTtllog.t100700Sts.mbrTyp = Mcd.MCD_RLSPREPAID;
                }
                if ((mem.tTtllog.t100700Sts.mbrTyp ==
                        Mcd.MCD_RLSPREPAID) &&
                    (mem.tTtllog.t100700.mbrInput ==
                        MbrInputType.magcardInput.index)) {
                  if (mem
                          .tmpbuf
                          .rcarddata
                          .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]
                          .length >=
                      16) {
                    mem.tTtllog.t100010.invoiceNo = (mem
                            .tmpbuf
                            .rcarddata
                            .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6])
                        .substring(0, 16);
                  }else{
                    mem.tTtllog.t100010.invoiceNo = (mem
                        .tmpbuf
                        .rcarddata
                        .jis2[cBuf.dbTrm.othcmpMagStrtNo - 6]);
                  }
                }
              }
            }
          }
        }

        if (!((await CmCksys.cmCrdtSystem() != 0) &&
            (cMem.working.crdtReg.step == KyCrdtInStep.INPUT_END.cd))) {
          await RcMcd.rcRalseMcdCrdtRegClr();
        }
      }
      // TODO:10121 QUICPay、iD 202404実装対象外
      // 対象行は2703-2711

      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(CompileFlag.ARCS_MBR){
      //   if(await RcSysChk.rcChkNTTDPrecaSystem()){
      //     rcPreca_Make_ActualLog(eTendType);
      //   }
      // }

      // TODO:10121 QUICPay、iD 202404実装対象外
      // 対象行は2718-2741
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(RcSysChk.rcChkBarcodePaySystem() != 0){
      //   rcBarcode_Pay_Make_ActualLog(eTendType);
      // }
      // TODO:10121 QUICPay、iD 202404実装対象外
      // 対象行は2747-2764

      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(await RcSysChk.rcQCChkQcashierSystem()){
      //   switch(eTendType){
      //     case TendType.TEND_TYPE_NO_ENTRY_DATA:
      //     case TendType.TEND_TYPE_TEND_AMOUNT:
      //       rcmbr_fanfare2();
      //       break;
      //     default:
      //       break;
      //   }
      // }else{
      //   rcmbr_fanfare2();
      // }
    }
    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行は2784-2887
    rcATCTZeroTotalBuf();
    // TODO:10121 QUICPay、iD 202404実装対象外 か要確認（一時コメントアウト対応）
    if (await RcSysChk.rcChkSmartSelfSystem()) {
      //if_psensor_reset(GetTid());
    }

    RcManualMix.rcClearManualMixCode();

    if ((await CmCksys.cmCrdtSystem() != 0) &&
        (cMem.working.crdtReg.step == KyCrdtInStep.INPUT_END.cd) &&
        (await RcSysChk.rcCheckEntryCrdtSystem())) {
      RcSet.rcClearCrdtReg();
      RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
    }

    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
        if (!(await RcSysChk.rcQCChkQcashierSystem())) {
          RcFncChk.rcOpeTime(OpeTimeFlgs.OPETIME_END.index);
        }
        RckyQctckt.rcDivAdjForceNumSet();
        rcATCTSetManualRefundData();
        RcTbafc1.rcCustLayAdd(); // 客層実績セット
        RcKyQcSelect.rcCreateTranBkupFile(1); // 取引完了ファイルの作成 (お会計券情報を読み込んだ場合のみ)
        rcSetSpecialUserCount(); // ユーザーごとの連番セット
        rcmbrSetRbtData();
        rcNonMbrSetPtsData();
        rcTpointSetLogData();
        StlItemCalcMain.rcmbrSetStnCardReCal(); // スタンプカード実績の再計算を実行
        RcMbrPoiCal.rcmbrTranOneToOnePromotion(); // One To Oneプロモーション実績のスリム化
        rcSetTranDataEditProc(); // TSなど上位サーバーが参照するために必要な実績を残すためにセット
        StlItemCalcMain.rcstlcalRbtTaxData(
            Tpraid.TPRAID_CHK, RegsMem()); //税の詳細情報
        RcMbrPoiCal.rcmbrTranStpCard(); // スタンプカード実績のスリム化
        RcMbrFlrd.rcmbrReadStpCdPrintData(); // スタンプカードの印字用データのセット
        rcAtctSetLoyDataWS(); // WS用実績セット
        rcATCTMakeFrestaTrans();
        if (CompileFlag.INVOICE_SYSTEM) {
          RcTbafc1.rcInvSumTaxCalMain("$funcName()");
        }

        // TODO:10121 QUICPay、iD 202404実装対象外
        // rcqc_dsp.cの中で判定として使われる。QPiDの実装には不要と判断
        //qc_mente_mbr_input_allow_flg = 0;
        mem.tTtllog.t100001Sts.restmpAmt = 0;

        // TODO:10121 QUICPay、iD 202404実装対象外
        // if(rcQC_Check_MenteDsp_Mode())
        // {
        // //メンテ画面で取引終了した場合はスキャナを止める
        // rcScan_Disable();
        // }
        //
        // if( C_BUF->db_trm.chg_rfm_credit_word )
        // {
        // MEM->tTtllog.t100001Sts.restmp_amt = Cal_Crdit_amt();
        // }
        rcATCTMakeRfmData();
        TprLog().logAdd(
            0,
            LogLevelDefine.normal,
            "$funcName() "
            "stlTaxInAmt[${RxLogCalc.rxCalcStlTaxInAmt(RegsMem())}] "
            "restmpAmt[${mem.tTtllog.t100001Sts.restmpAmt}]\n");

        // TODO:10121 QUICPay、iD 202404実装対象外
        // 対象行は2955-2992

        //伝票番号
        if (RcSysChk.rcsyschkSp1QrReadSystem()) {
          // memcpy(MEM->tTtllog.t100001Sts.sp1_qr_seqno,
          //     AT_SING->sp1_QR_Acode , sizeof(MEM->tTtllog.t100001Sts.sp1_qr_seqno));
          AtSingl atSing = SystemFunc.readAtSingl();
          mem.tTtllog.t100001Sts.sp1QrSeqno = atSing.sp1QRAcode;
        }
        break;
      default:
        break;
    }

    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
        // キャッシュレス還元対応 SPでVerifonで取引した実績をQCで精算した時に、
        // 追加実績(func_cd=120000)の実績が出来上がらない為、ここで実績作成を呼ぶ
        RcCashless.rcCashlessData(mem.tTtllog.t100001Sts.sptendCnt);
        break;
      default:
        break;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行は3016-3032

    return eTendType;
  }

  ///  関連tprxソース: rc_atct.c - rcATCT_Chk_TendType(TendType eTendType)
  static bool rcATCTChkTendType(TendType eTendType) {
    return ((TendType.TEND_TYPE_NO_ENTRY_DATA == eTendType) ||
        (TendType.TEND_TYPE_TEND_AMOUNT == eTendType));
  }

  ///  関連tprxソース: rc_atct.c - rcATCT_Make_PostReg()
  static Future<void> rcATCTMakePostReg() async {
    if (await RcFncChk.rcCheckESVoidIMode() ||
        await RcFncChk.rcCheckESVoidSMode()) {
      return;
    }

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    cMem.postReg.sub_ttl = RxLogCalc.rxCalcStlTaxInAmt(mem);

    //#if CATALINA_SYSTEM
    if (RcCatalina.cmCatalinaSystem(0) &&
        mem.tmpbuf.catalinaTtlamt != null &&
        mem.tmpbuf.catalinaTtlamt != 0) {
      int amt = cMem.postReg.sub_ttl! - mem.tmpbuf.catalinaTtlamt!;
      cMem.postReg.sub_ttl = amt;
    }
    //#if RESERV_SYSTEM
    if ((await CmCksys.cmReservSystem() != 0 ||
            await CmCksys.cmNetDoAreservSystem() != 0) &&
        RcReserv.rcReservReceiptCall()) {
      int amt = cMem.postReg.sub_ttl! - await RcReserv.rcreservReceiptAdvance();
      cMem.postReg.sub_ttl = amt;
    }
    if (mem.tmpbuf.notepluTtlamt != null &&
        mem.tmpbuf.notepluTtlamt != 0) {
      int amt = cMem.postReg.sub_ttl! - mem.tmpbuf.notepluTtlamt!;
      cMem.postReg.sub_ttl = amt;
    }
    if (mem.tmpbuf.notepluTtlamt != null &&
        mem.tmpbuf.beniyaTtlamt != 0) {
      int amt = cMem.postReg.sub_ttl! - mem.tmpbuf.beniyaTtlamt!;
      cMem.postReg.sub_ttl = amt;
    }
  }

  ///  関連tprxソース: rc_atct.c - Set_TendType()
  static Future<void> setTendType(TendType eTendType) async {
    AcMem cMem = SystemFunc.readAcMem();
    final result = await RcSysChk.rcKySelf();
    switch (result) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        cMem.seg1Data.eTendType = eTendType.value;
        break;
      case RcRegs.KY_SINGLE:
        cMem.seg1Data.eTendType = eTendType.value;
        cMem.seg2Data.eTendType = eTendType.value;
        break;
      case RcRegs.KY_CHECKER:
        cMem.seg2Data.eTendType = eTendType.value;
        break;
    }
  }

  /// 関連tprxソース: rc_atct.c - Cal_Crdit_amt()
  static Future<int> CalCrditamt() async {
    KopttranBuff kopttranBuff = KopttranBuff();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    int i;
    int sptendDataAll = 0;

    for (i = 0; i < CntList.sptendMax; i++) {
      mem.tTtllog.t100100Sts[i].sptendPayGpType =
          SPTEND_PRN_KIND.SPTEND_PRN_KIND_NOSET.typeCd; // 初期化
    }

    for (i = 0; i < mem.tTtllog.t100001Sts.sptendCnt + 1; i++) {
      int chkFncCd = 0;
      int sptendData = 0;
      int crdtFlg = 0;
      chkFncCd = mem.tTtllog.t100100[i].sptendCd;
      sptendData = mem.tTtllog.t100100[i].sptendData;

      RcFlrda.ClrKoptTran();
      await RcFlrda.rcReadKopttran(chkFncCd, kopttranBuff);

      // 現金
      if (chkFncCd == FuncKey.KY_CASH.keyId) {
        kopttranBuff.crdtEnbleFlg = 0; // 掛売判定から除きたいため
      }

      // TODO:10121 QUICPay、iD 202404実装対象外
      /* クレジット扱いするキーオプションの設定 */
      // crdt_flg = 0;
      // if((KOPTTRAN.crdt_enble_flg     == 1) &&   /* 掛売許可？         */
      // (KOPTTRAN.crdt_typ           == 0)    ) /* クレジットで使用？ */
      // crdt_flg = 1;
      // if((! cm_nttasp_system()            ) &&   /* NTT以外？          */
      // (rcChk_Crdt_User() == KANSUP_CRDT) &&   /* 関西スーパー？     */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&   /* 掛売許可？         */
      // (KOPTTRAN.crdt_typ           == 8)    ) /* オフクレで使用？   */
      // crdt_flg = 1;
      // if((! cm_nttasp_system()            ) &&   /* NTT以外？          */
      // (KOPTTRAN.crdt_enble_flg     == 0) &&   /* 掛売許可？         */
      // (KOPTTRAN.crdt_typ           == 8)    ) /* オフクレで使用？   */
      // crdt_flg = 1;
      // if((C_BUF->db_trm.cardsheet_prn      ) &&
      // (C_BUF->db_trm.rfm_use_stamp_area ) &&
      // (chk_fnc_cd             == KY_CHA1)   )
      // crdt_flg = 1;
      // #if SMARTPLUS
      // if((rcChk_Smartplus_System()        ) &&   /* Smartplus？        */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&   /* 掛売許可？         */
      // (KOPTTRAN.crdt_typ           == 4)    ) /* Smartplusで使用？  */
      // crdt_flg = 1;
      // #endif
      // if((cm_VisaTouch_system()           ) &&   /* VISA Touch[INFOX]？*/
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ           == 4)    )
      // crdt_flg = 1;

      /* QUICPay？*/
      if ((await CmCksys.cmQUICPaySystem() != 0) &&
          (kopttranBuff.crdtEnbleFlg == 1) &&
          (kopttranBuff.crdtTyp == 9)) {
        crdtFlg = 1;
      }
      /* iD？*/
      if ((await CmCksys.cmIDSystem() != 0) &&
          (kopttranBuff.crdtEnbleFlg == 1) &&
          (kopttranBuff.crdtTyp == 5)) {
        crdtFlg = 1;
      }

      // TODO:10121 QUICPay、iD 202404実装対象外
      // if((cm_PiTaPa_system()              ) &&   /* PiTaPa？           */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ == 10         )    )
      // crdt_flg = 1;
      // if((rcChk_SPVT_System()             ) &&   /* SP/VT？            */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ == 15         )    )
      // crdt_flg = 1;
      // if((cm_GinCard_system()             ) &&   /* 銀聯？             */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ == 17         )    )
      // crdt_flg = 1;
      // if((rcChk_MultiQP_System()          ) &&   /* QUICPay[マルチ]？     */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ == 19         )    )
      // crdt_flg = 1;
      // if((rcChk_MultiiD_System()          ) &&   /* iD[マルチ]？          */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ == 20         )    )
      // crdt_flg = 1;
      // if((cm_jmups_system()               ) &&   /* 端末で選択？ */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ == 24         )    )
      // crdt_flg = 1;
      // if((rcChk_MultiPiTaPa_System()      ) &&   /* PiTaPa[マルチ]？ */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ == 25         )    )
      // crdt_flg = 1;
      // if((cm_cct_connect_system()) && (cm_cct_emoney_system()) && ((rcChk_JET_B_Process()) || (rcChk_INFOX_Process())) &&
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // ((KOPTTRAN.crdt_typ == 5         ) || (KOPTTRAN.crdt_typ == 9         ))  )
      // crdt_flg = 1;
      // if((cm_cct_connect_system()) && ((rcChk_INFOX_Process()) || (rcChk_JET_B_Process())) && /* NFC Payment */
      // (KOPTTRAN.crdt_enble_flg     == 1) &&
      // (KOPTTRAN.crdt_typ == 36         )    )
      // crdt_flg = 1;
      // if( KOPTTRAN.restmp_flg     == 1 ) {	/* 収入印紙発行 しない	*/
      // crdt_flg = 1;
      // }
      //
      // if(   (cm_hc2_Kuroganeya_system(GetTid()) == 1)	// くろがねや仕様
      // && (chk_fnc_cd == SP_KURO_AR_KEY) ){
      // crdt_flg = 1;
      // }

      //       if (RC_INFO_MEM->RC_RECOG.RECOG_VESCA_SYSTEM)
      //       {
      //       if (KOPTTRAN.crdt_enble_flg == 1)
      //       {
      //       if ((KOPTTRAN.crdt_typ     ==  5)
      // //	  		     || (KOPTTRAN.crdt_typ ==  6)
      //       || (KOPTTRAN.crdt_typ ==  9)
      //       || (KOPTTRAN.crdt_typ == 17))
      //       {
      //       crdt_flg = 1;
      //       }

      //	  		if((KOPTTRAN.crdt_typ ==  6)
      //	  		 && !(rcChk_Repica_Verifone_Read_System_for_apl()))	/* rcChk_PrecaTyp()にて判定に変える */
      //       if(KOPTTRAN.crdt_typ ==  6)
      //       {
      //       #if 0
      //       crdt_flg = 1;
      //       #else
      //       // 各種プリカ仕様 + Verifoneの構成が増えてきたので対応しておく
      //       if (rcChk_PrecaTyp() != 0)
      //       { //  収入印紙発行 する
      //           ;
      //       }
      //       else
      //       {
      //       crdt_flg = 1;
      //       }
      //       #endif
      //       }
      //       }
      //       }
      //
      //       if (   (C_BUF->db_trm.disable_stamp_cha9key)
      //       && (chk_fnc_cd == KY_CHA9))
      //       {
      //       crdt_flg = 1;
      //       }
      //
      //       if (   (rxChkKopt_CrdtType_Slip(C_BUF, chk_fnc_cd))
      //       && (C_BUF->db_trm.acctrcpt_except_cha1)
      //       && (chk_fnc_cd == KY_CHA1))
      //       {
      //       crdt_flg = 1;
      //       }

      // 支払種別をセットする
      if (crdtFlg == 1) {
        mem.tTtllog.t100100Sts[i].sptendPayGpType =
            SPTEND_PRN_KIND.SPTEND_PRN_KIND_CRDT.typeCd; // クレジット
      } else if (chkFncCd == FuncKey.KY_CASH.keyId) {
        mem.tTtllog.t100100Sts[i].sptendPayGpType =
            SPTEND_PRN_KIND.SPTEND_PRN_KIND_CASH.typeCd; // 現金
      } else if (Rxkoptcmncom.rxChkKoptCmnChaChkPntDsc(cBuf, chkFncCd) != 0) {
        mem.tTtllog.t100100Sts[i].sptendPayGpType =
            SPTEND_PRN_KIND.SPTEND_PRN_KIND_PNTDSC.typeCd; // ポイント値引
        crdtFlg = 1;
      } else {
        mem.tTtllog.t100100Sts[i].sptendPayGpType =
            SPTEND_PRN_KIND.SPTEND_PRN_KIND_OTHER.typeCd; // その他
      }

      /* クレジット扱い？ */
      if (crdtFlg == 1) {
        sptendDataAll += sptendData;
      }
    }
    return (sptendDataAll);
  }

  /// スプリットデータの作成
  /// 関連tprxソース: rc_atct.c - rcATCT_Make_SPTendBuf
  /// 戻値:	TEND_TYPE_NO_ENTRY_DATA	値数無し締め(最終締め)
  ///    		TEND_TYPE_TEND_AMOUNT	最終締め
  ///       TEND_TYPE_SPRIT_TEND	締め途中(残額あり)
  static Future<TendType> rcATCTMakeSPTendBuf() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcATCTMakeSPTendBuf() rxMemRead error\n");
      return TendType.TEND_TYPE_ERROR;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcbInfo acbInfo = AcbInfo();
    TendType eTendType;
    int unitPrice;
    int exemptTaxAmt = 0;
    int taxFreeAmt = 0;
    int chgManCnt = 0;
    int idx;
    T100100 spltData; // スプリットデータ格納ポインタ
    T100100Sts spltStatus; // スプリットステータス格納ポインタ
    KopttranBuff kopttran = KopttranBuff();
    int mulPrnFlg = -1;
    var JIS1 = List<String>.filled(128, '0');
    int orgFnc = cMem.stat.fncCode;
    String log = "";
    int tmp;

    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttran);
    if ((await RcFncChk.rcCheckESVoidIMode()) ||
        (await RcFncChk.rcCheckESVoidSMode())) {
      return TendType.TEND_TYPE_NO_ENTRY_DATA;
    }

    spltData =
        mem.tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt];
    spltStatus =
        mem.tTtllog.t100100Sts[mem.tTtllog.t100001Sts.sptendCnt];

    spltData.sptendCd = cMem.stat.fncCode;
    spltStatus.sptendPayStatus = kopttran.crdtTyp;
    if (cMem.stat.fncCode == FuncKey.KY_CASH.keyId) {
      if (cMem.acbData.ccinPrice != 0) {
        spltStatus.sptendPayKind =
            SPTEND_KIND_LISTS.SPTEND_KIND_ACX.typeCd; // 釣機現金
      } else {
        if ((RcRegs.rcInfoMem.rcCnct.cnctAcrCnct != 2) // 自動釣銭釣札機接続の設定が「釣銭釣札機」でない
            ||
            (RcRegs.rcInfoMem.rcCnct.cnctAcrOnoff == 1)) {
          // 自動釣機ON/OFFフラグが「OFF」である
          // 手動現金
          spltStatus.sptendPayKind = SPTEND_KIND_LISTS.SPTEND_KIND_CASH.typeCd;
        } else {
          // 釣銭釣札機接続時の手入力現金
          spltStatus.sptendPayKind =
              SPTEND_KIND_LISTS.SPTEND_KIND_ACX_MANUAL.typeCd;
        }
      }
    } else if (kopttran.crdtEnbleFlg != 0) {
      // 掛売あり会計
      spltStatus.sptendPayKind = SPTEND_KIND_LISTS.SPTEND_KIND_CHARGE.typeCd;
    } else {
      // 掛売なし
      spltStatus.sptendPayKind = SPTEND_KIND_LISTS.SPTEND_KIND_NO_CHA.typeCd;
    }

    if (pCom.dbTrm.nontaxCha10 != 0) {
      if (RxLogCalc.rxCalcStlTaxAmt(RegsMem()) < 0) {
        // 返金時、預り内税を会計１０（免税）にセットする
        if ((cMem.stat.fncCode == FuncKey.KY_CHA10.keyId) &&
            (mem.tTtllog.t100001Sts.sptendCnt == 0)) {
          exemptTaxAmt = RxLogCalc.rxCalcInTaxAmt(RegsMem());
        } else if (mem.tTtllog.t100200[AmtKind.amtCha10.index].amt != 0) {
          exemptTaxAmt = 1;
        }
      }
    }
    if (cMem.acbData.ccinPrice != 0) {
      chgManCnt = AcbInfo.cindata.bill10000;
    }

    if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
      rcSPTendInpClr();
    }

    spltStatus.rbtPurFlg = (spltStatus.rbtPurFlg == 0) ? 1 : 0;
    if (!RcFncChk.rcChkTenOn()) {
      /* no entry amount ? */
      spltStatus.sptendFlg = 1;
      if (mem.tTtllog.t100001Sts.sptendCnt == 1) {
        if (exemptTaxAmt != 0) {
          spltData.sptendData = RxLogCalc.rxCalcStlTaxAmt(RegsMem()) -
              RxLogCalc.rxCalcInTaxAmt(RegsMem());
          spltData.sptendInAmt = RxLogCalc.rxCalcStlTaxAmt(RegsMem()) -
              RxLogCalc.rxCalcInTaxAmt(RegsMem());
        } else if (taxFreeAmt != 0) {
          spltData.sptendData = RxLogCalc.rxCalcStlTaxAmt(RegsMem()) -
              (RxLogCalc.rxCalcInTaxAmt(RegsMem()) +
                  RxLogCalc.rxCalcExTaxAmt(RegsMem()));
          spltData.sptendInAmt = RxLogCalc.rxCalcStlTaxAmt(RegsMem()) -
              (RxLogCalc.rxCalcInTaxAmt(RegsMem()) +
                  RxLogCalc.rxCalcExTaxAmt(RegsMem()));
        } else {
          spltData.sptendData = RxLogCalc.rxCalcStlTaxAmt(RegsMem());
          spltData.sptendInAmt = RxLogCalc.rxCalcStlTaxAmt(RegsMem());
        }
      } else {
        spltData.sptendData = RxLogCalc.rxCalcStlTaxAmt(RegsMem());
        spltData.sptendInAmt = RxLogCalc.rxCalcStlTaxAmt(RegsMem());
      }
      spltData.sptendChgAmt = 0;
    } else {
      spltStatus.sptendFlg = 0;
      if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
        if (exemptTaxAmt != 0) {
          spltData.sptendData = exemptTaxAmt;
        } else if (taxFreeAmt != 0) {
          spltData.sptendData = taxFreeAmt;
        } else {
          spltData.sptendData =
              Bcdtol.cmBcdToL(cMem.ent.entry);
        }
      } else {
        spltData.sptendData =
            Bcdtol.cmBcdToL(cMem.ent.entry);
      }
      if (RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
        spltData.sptendData = spltData.sptendData * -1;
      }
      spltData.sptendInAmt = RxLogCalc.rxCalcStlTaxAmt(RegsMem());
      spltData.sptendChgAmt =
          spltData.sptendData - RxLogCalc.rxCalcStlTaxAmt(RegsMem());
      if (qcNotepluChangeFlg != 0) {
        spltData.sptendInAmt = 0;
      }
      if ((await RcFncChk.rcCheckChg10000Flg() == false)
          //#if SELF_GATE
          &&
          (!await RcSysChk.rcSGChkSelfGateSystem())
          //#endif
          &&
          (RckyRfdopr.rcRfdOprCheckManualRefundMode() == false) // 手動返品モード以外
          &&
          (((mem.tTtllog.t100001Sts.sptendCnt == 0) &&
                  (taxFreeAmt == 0)) ||
              (mem.tTtllog.t100001Sts.sptendCnt != 0)) &&
          ((spltData.sptendChgAmt > RcRegs.maxChgAmt) && (chgFlg != 1))) {
        return (await rcErrMaxChgAmt());
      }

      if (cMem.working.dataReg.kMul0 != 0) {
        spltData.sptendSht = cMem.working.dataReg.kMul0;
        unitPrice = Bcdtol.cmBcdToL(cMem.ent.entry);
        spltData.sptendFaceAmt =
            unitPrice ~/ spltData.sptendSht;
      } else {
        spltData.sptendSht = 0;
        spltData.sptendFaceAmt = 0;
      }
      if (CompileFlag.VISMAC) {
        if ((await RcSysChk.rcChkVMCSystem()) &&
            (mem.tTtllog.t100700.mbrInput ==
                MbrInputType.vismacCardInput.index)) {
          rcVmcChgamtCalc();
          spltData.sptendChgAmt = spltData.sptendData -
              RxLogCalc.rxCalcStlTaxAmt(RegsMem()) -
              mem.tTtllog.t100900.todayChgamt;
        }
      }

      if (CompileFlag.ARCS_MBR) {
        if ((await RcSysChk.rcChkNTTDPrecaSystem()) &&
            (mem.tmpbuf.workInType == 1) &&
            (mem.tTtllog.t100001Sts.chrgFlg == 1)) {
          spltData.sptendChgAmt = spltData.sptendData -
              RxLogCalc.rxCalcStlTaxAmt(RegsMem()) -
              mem.tTtllog.t100900.todayChgamt;
        }
      }

      if ((await RcSysChk.rcChkTRKPrecaSystem()) &&
          (mem.tmpbuf.workInType == 1) &&
          (mem.tTtllog.t100001Sts.chrgFlg == 1)) {
        spltData.sptendChgAmt = spltData.sptendData -
            RxLogCalc.rxCalcStlTaxAmt(RegsMem()) -
            mem.tTtllog.t100900.todayChgamt;
      }

      if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
          ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
              (await RcSysChk.rcCheckQCJCSystem()))) {
        if (pCom.dbTrm.acxCashInputManual != 0) {
          spltStatus.sptendInputData = cMem.acbData.ccinAddPrice;
        }
        if ((kopttran.acbDrwFlg == 1) || (cMem.acbData.ccinAddPrice != 0)) {
          cMem.acbData.acbDrwFlg = 1;
        }
      }
    }

    if ((RcSysChk.rcChkMammyMartSystem()) &&
        (spltData.sptendCd == FuncKey.KY_CHK3.keyId)) {
      spltData.mStaffNo = cMem.working.dataReg.cpnBarCd;
    }
    rcATCTMakeCashPostReg(kopttran, spltData.sptendData, cMem.stat.fncCode);
    if (spltData.sptendChgAmt < 0) {
      eTendType = TendType.TEND_TYPE_SPRIT_TEND;
    } else if ((mem.tTtllog.t100001Sts.sptendCnt == 0) &&
        (pCom.dbTrm.nontaxCha10 != 0) &&
        (exemptTaxAmt != 0)) {
      eTendType = TendType.TEND_TYPE_SPRIT_TEND;
    } else if ((mem.tTtllog.t100001Sts.sptendCnt == 0) &&
        (await CmCksys.cmTaxFreeSystem() != 0) &&
        (taxFreeAmt != 0)) {
      eTendType = TendType.TEND_TYPE_SPRIT_TEND;
    } else if (spltStatus.sptendFlg == 0) {
      eTendType = TendType.TEND_TYPE_TEND_AMOUNT;
    } else {
      eTendType = TendType.TEND_TYPE_NO_ENTRY_DATA;
    }

    if ((await rcChkChaReturn(kopttran)) &&
        (spltData.sptendChgAmt >= kopttran.chkAmt)) {
      eTendType = TendType.TEND_TYPE_SPRIT_TEND;
    }

    spltData.manCnt = cMem.working.dataReg.kMan0;
    if ((await CmCksys.cmMarutoSystem() != 0) ||
        ((RcSysChk.rcsyschkSm66FrestaSystem()) &&
            (!RcFncChk.rcCheckRcptvoidLoadOrgTran()))) {
      spltData.manCnt += cMem.working.dataReg.kMan0;
    } else if (RcSysChk.rcsyschkSm66FrestaSystem()) {
      tmp = chgManCnt - mem.tTtllog.t100002Sts.rcptCashMan;
      if (tmp > 0) {
        spltData.manCnt += tmp;
      }
    }
    AtSingl atSing = SystemFunc.readAtSingl();
    // 後通信仕様の場合、スプリット釣銭額をメモリにセット
    if ((await RcSysChk.rcsyschkLastCommSystem()) &&
        ((((await RcSysChk.rcChkEntryPrecaTyp() != 0) &&
                (atSing.entryPrecaAmt != 0))) ||
            ((RcSysChk.rcsyschkRpointSystem() != 0) &&
                ((mem.tTtllog.t100790.usePoint != 0) ||
                    (mem.tTtllog.t100790.todayPoint != 0))))) {
      atSing.combiChgAmt = spltData.sptendChgAmt;
    }

    if (RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
      if (spltData.sptendChgAmt > 0) {
        eTendType = TendType.TEND_TYPE_SPRIT_TEND;
      }
    }

    if (CompileFlag.VISMAC) {
      if ((await RcSysChk.rcChkVMCSystem()) &&
          (mem.tTtllog.t100700.mbrInput ==
              MbrInputType.vismacCardInput.index)) {
        mem.tTtllog.t100900.lastChgamt = mem.custTtlTbl.n_data10;
      }
    }

    if (Rxkoptcmncom.rxChkKoptCmnChaChkPntDsc(pCom, spltData.sptendCd) != 0) {
      rcSm5SetPrivilege(
          mem.tTtllog.t100001Sts.sptendCnt, spltData.sptendData, 1);
    } else {
      rcSm5SetPrivilege(
          mem.tTtllog.t100001Sts.sptendCnt, spltData.sptendData, 0);
    }

    //多慶屋様 未読現金対応 スプリットテンダリングの保存
    idx = mem.tTtllog.t100001Sts.sptendCnt;
    if (await RcFncChk.rcsyschkUnreadCashChk(cMem.stat.fncCode)) {
      //未読現金設定？
      mem.tTtllog.t100100Sts[idx].unread10000Sht = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY10000].Count;
      mem.tTtllog.t100100Sts[idx].unread5000Sht  = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY5000].Count;
      mem.tTtllog.t100100Sts[idx].unread2000Sht  = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY2000].Count;
      mem.tTtllog.t100100Sts[idx].unread1000Sht  = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY1000].Count;
      mem.tTtllog.t100100Sts[idx].unread500Sht   = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY500].Count;
      mem.tTtllog.t100100Sts[idx].unread100Sht   = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY100].Count;
      mem.tTtllog.t100100Sts[idx].unread50Sht    = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY50].Count;
      mem.tTtllog.t100100Sts[idx].unread10Sht    = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY10].Count;
      mem.tTtllog.t100100Sts[idx].unread5Sht     = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY5].Count;
      mem.tTtllog.t100100Sts[idx].unread1Sht     = InOutInfo().InOutBtn[InoutUnreadDisp.INOUT_YY1].Count;
    } else {
      mem.tTtllog.t100100Sts[idx].unread10000Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread5000Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread2000Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread1000Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread500Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread100Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread50Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread10Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread5Sht = 0;
      mem.tTtllog.t100100Sts[idx].unread1Sht = 0;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // スプリット情報に、プリカカード情報を設定する
    // mulPrnFlg = -1;
    // if(await CmCksys.cmPrecacardMultiUse() != 0){
    //   // スプリットのファンクションコードがプリペイド?
    //   if (await RcAjsEmoney.rcAjsSptendFncCheck(orgFnc) != 0)
    //   {
    //     if (!await RcSysChk.rcQCChkQcashierSystem())	// QCashier以外
    //     {
    //       if(RcqrCom.qrTxtStatus == QrTxtStatus.QR_TXT_STATUS_READ.index) // 読み戻し中
    //       {
    //         ;
    //       }
    //       else
    //       {
    //         mulPrnFlg = mem.tTtllog.t100001Sts.sptendCnt;
    //       }
    //     }
    //     else
    //     {
    //       mulPrnFlg = mem.tTtllog.t100001Sts.sptendCnt;
    //     }
    //   }
    //
    //   if (mulPrnFlg != -1)	// カード情報の保存あり
    //   {
    //     // 未設定(=登録機側でプリペイド利用なし)
    //     if (mem.prnrBuf.mulPreCard[mulPrnFlg].jis1 == "") {
    //       // JIS1カード情報を保持
    //       mem.prnrBuf.mulPreCard[mulPrnFlg].jis1 = mem.tmpbuf.ajsEmoneyCard.jis1;
    //       log = "rcATCTMakeSPTendBuf : Save JIS1 to "
    //           "prnrbuf.mulPreCard[${mulPrnFlg}]:[${mem.tmpbuf.ajsEmoneyCard.jis1}]\n";
    //       TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    //     }
    //   }
    // }

    return eTendType;
  }

  /// ReCalc時にエラーが出てもスキップするかチェック
  /// 関連tprxソース: rc_atct.c - rcATCTProcCheckPassFlag
  /// 戻値:	true:スキップする  false: スキップしない
  static bool rcATCTProcCheckPassFlag() {
    if (atctCheckPassFlag == RcRegs.PASS_CHECK_ON) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rc_atct.c - rcATCT_MP1_FlagReset
  static Future<void> rcATCTMP1FlagReset() async {
    if (await RcSysChk.rcChkSapporoRealSystem()) {
      return;
    }

    int cnctMp1Cnct =
        Cnct.cnctMemGet(Tpraid.TPRAID_CHK, CnctLists.CNCT_MP1_CNCT);
    if ((await CmCksys.cmCheckMP1Print() != 0) // 値付けプリンタ接続仕様が有効
        &&
        (cnctMp1Cnct == 0)) {
      // 値付けプリンタが未接続
      RegsMem mem = SystemFunc.readRegsMem();
      for (int i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
        if (mem.tItemLog[i].t10000Sts.exchgIssueObjFlg != 0) {
          // ラベル発行しないのでリセット
          mem.tItemLog[i].t10000Sts.exchgIssueObjFlg = 0;
        }
      }
    }
  }

  /// 関連tprxソース: rc_atct.c - rcATCT_Make_TotalBuf
  static Future<void> rcATCTMakeTotalBuf(TendType eTendType) async {
    KopttranBuff kopttran = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttran);

    if ((await RcFncChk.rcCheckESVoidIMode()) ||
        (await RcFncChk.rcCheckESVoidSMode())) {
      return;
    }

    if (mem
            .tTtllog
            .t100100[mem.tTtllog.t100001Sts.sptendCnt]
            .sptendChgAmt <
        0) {
      mem.tTtllog.calcData.stlTaxAmt = -mem
          .tTtllog
          .t100100[mem.tTtllog.t100001Sts.sptendCnt]
          .sptendChgAmt;
    }

    if (RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
      if (mem
              .tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendChgAmt >
          0) {
        mem.tTtllog.calcData.stlTaxAmt = mem
                .tTtllog
                .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                .sptendChgAmt *
            (-1);
      }
    }

    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_SPRIT_TEND:
        mem.tTtllog.t100001.chgAmt = 0; // change/return amount
        break;
      case TendType.TEND_TYPE_TEND_AMOUNT:
        if (mem
                .tTtllog
                .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                .sptendChgAmt >=
            0) {
          if (!((await rcChkChaReturn(kopttran)) &&
              (mem
                      .tTtllog
                      .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                      .sptendChgAmt >=
                  kopttran.chkAmt))) {
            // change/return amount
            mem.tTtllog.t100001.chgAmt = mem
                .tTtllog
                .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                .sptendChgAmt;
          }
        }
        break;
      default:
        break;
    }

    if ((RckyRfdopr.rcRfdOprCheckManualRefundMode()) &&
        (eTendType == TendType.TEND_TYPE_TEND_AMOUNT)) {
      if (mem
              .tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendChgAmt <=
          0) {
        if (!((await rcChkChaReturn(kopttran)) &&
            (mem
                    .tTtllog
                    .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                    .sptendChgAmt >=
                kopttran.chkAmt))) {
          mem.tTtllog.t100001.chgAmt = mem
              .tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendChgAmt;
        }
      }
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if SS_CR2
    // if (rcChk_CR2_NSW_Data_System())
    // {
    // MEM->prnrbuf.nsw_fmt.nsw_cash_tbl.amt = CMEM->acbdata.total_price;
    // MEM->prnrbuf.nsw_fmt.nsw_change_tbl.amt = MEM->ttlrbuf.chg_amt;
    // }
    // #endif
  }

/*----------------------------------------------------------------------*
 * AT/CT end procedure
 *----------------------------------------------------------------------*/
  // TODO:10121 QUICPay、iD 202404実装対象外 必要なところだけ実装.
  /// 関連tprxソース: rc_atct.c - rcATCT_End
  /// 戻値:	TEND_TYPE_NO_ENTRY_DATA	値数無し締め(最終締め)
  ///    		TEND_TYPE_TEND_AMOUNT	最終締め
  ///       TEND_TYPE_SPRIT_TEND	締め途中(残額あり)
  static Future<void> rcATCTEnd(TendType eTendType, int fncCode) async {
    KopttranBuff koptTran = KopttranBuff();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcATCT_End(): FncCode($fncCode) \n");

    await RcFlrda.rcReadKopttran(fncCode, koptTran);

    RcSet.rcClearWizStaffNo();
    RcSet.rcClearEntry();
    await RcSet.rcClearDataReg();
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    RxMemRet xRetCom = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetCom.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRetCom.object;

    if (atSing.beamReleaseFlg != 0 &&
        eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
      atSing.beamReleaseFlg = 0;
    }
    if (atSing.chaReturnFlg != 0) {
      atSing.chaReturnFlg = 0;
    }
    if (atSing.tuoFlg != 0) {
      atSing.tuoFlg = 0;
    }

    if (mem.tTtllog.t100013Sts.tuoImgNo != 0 &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND)) {
      mem.tTtllog.t100013Sts.tuoImgNo = 0;
      mem.tTtllog.t100013Sts.tuoImgNo1 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo2 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo3 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo4 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo5 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo6 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo7 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo8 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo9 = 0;
      mem.tTtllog.t100013Sts.tuoImgNo10 = 0;
    }

    if (mem.tTtllog.t100013Sts.tuoSignFlg == 1) {
      mem.tTtllog.t100013Sts.tuoSignFlg = 0;
    }
    if (atSing.limitFlg != 0 && (eTendType != TendType.TEND_TYPE_SPRIT_TEND)) {
      atSing.limitFlg = 0;
      mem.tTtllog.t100012Sts.hycardTtlamt = 0;
      mem.tTtllog.t100012Sts.outsideRbtprnflg = 0;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcATCTEnd() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    if (cBuf.revenueExclusion == 1 &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem())) &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND)) {
      mem.tTtllog.t100002Sts.revenueExclusionflg2 = 0;
      if (CompileFlag.DEPARTMENT_STORE) {
        mem.tTtllog.t100900.vmcStkacv = 0;
      } else {
        mem.tTtllog.t100900.thisSvsNo = 0;
      }
    }
    if (mem.tTtllog.t100900.thisSvsNo != 0) {
      mem.tTtllog.t100900.thisSvsNo = 0;
      if (CompileFlag.DEPARTMENT_STORE) {
        mem.tTtllog.t100900.vmcStkacv = 0;
      } else {
        mem.tTtllog.t100900.thisSvsNo = 0;
      }
    }

    if (((RxLogCalc.rxCalcSuicaAmt(mem) != 0) || atSing.suicaData.page == 2) &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND)) {
      atSing.suicaData = SuicaTbl();
    }
    if (mem.prnrBuf.suicaNgPrn == 1) {
      mem.prnrBuf.suicaNgPrn = 0;
    }

    if (mem.tTtllog.t100700Sts.mbrPrcFlg != 0 &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND)) {
      mem.tTtllog.t100700Sts.mbrPrcFlg = 0;
    }
    if (RcSysChk.rcChkCustrealWebserSystem() &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND) &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      atSing.webrealData = WebrealTbl();
      //
      //   memset(&TS_BUF->custreal2, 0,sizeof(TS_BUF->custreal2));
      // cm_clr((char *)&MEM->tTtllog.t100700Sts.webrealsrv_fuyo[0], sizeof(MEM->tTtllog.t100700Sts.webrealsrv_fuyo));
      // cm_clr((char *)&MEM->tTtllog.t100700Sts.webrealsrv_kangen[0], sizeof(MEM->tTtllog.t100700Sts.webrealsrv_kangen));
    }
    if (RcSysChk.rcChkCustrealUIDSystem() != 0 &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND) &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      //   memset(&TS_BUF->rwc.rainbow_panadata, 0, sizeof(TS_BUF->rwc.rainbow_panadata));
      // memset(&TS_BUF->custreal2, 0,sizeof(TS_BUF->custreal2));
      mem.tTtllog.t100900Sts.rwcWriteFlg = 0;
      mem.prnrBuf.cardStopKind = 0;
      atSing.beforeStlAmt = 0;
    }

    //マルト様特注販売許可キー
    if (atSing.marutoAlertflg == 1 &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND)) {
      atSing.marutoAlertflg = 0;
    }
    if (RcSysChk.rcChkCustrealOPSystem() &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND) &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      //memset(&TS_BUF->custreal2, 0,sizeof(TS_BUF->custreal2));
    }
    if ((RcSysChk.rcChkCustrealPointartistSystem() != 0) &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND) &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      //memset(&TS_BUF->custreal2, 0,sizeof(TS_BUF->custreal2));
    }
    // VEGA交通系の処理未了発生時の決済金額をクリア
    if ((await RcSysChk.rcChkMultiVegaPayMethod(FclService.FCL_SUIC)) &&
        mem.tmpbuf.multiTimeout == 2 &&
        mem.mltsuicaAlarmPayprc != 0) {
      mem.mltsuicaAlarmPayprc = 0;
    }

    if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        await RcSysChk.rcChkAcxDecisionSystem()) {
      await RcKyccin.rcEndKeyChgCinDecision2("rcATCTEnd");
    } else {
      await RckyDisBurse.rcSetChangerItemAcrON();
    }

    if (cBuf.dbTrm.rcprateSel == 1 &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND)) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      // rcKyRRate_Cncl_DbRead();
      // cMem.custData.cust.cust_no = '';
      // memset(CMEM->custdata.cust.cust_no, 0, sizeof(CMEM->custdata.cust.cust_no));
    }
    if (await CmCksys.cmMcp200System() != 0 &&
        (eTendType != TendType.TEND_TYPE_SPRIT_TEND)) {
      cMem.ticketBar.ticketBarCnt = 0;
    }
    cMem.regsItemlogCnt = 0;
    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
        RcAssistMnt.rcAssistSend(24021);
        await RcCashless.rcCashlessAllInit(); // キャッシュレス還元のクリア
        // RcRecno.rcIncRctJnlNo(true); //　クラウドPOSで管理.
        await RcSlip.rcIncSlipNo(); //伝票番号(業務モード仕様)
        await RcOrder.rcIncOrderNo(); //発注番号(業務モード仕様)

        // TODO:10121 QUICPay、iD 202404実装対象外 ポイント
        // rcKyRRate_RateCopy(0);
        //     if MC_SYSTEM
        //     if(cm_mc_system()) {
        // rc_Inc_MCSeqNo(0);
        // if(cm_crdt_system()) {
        // if((MEM->tmpbuf.mcarddata.mc_stat & OWNCRDT) || (MEM->tmpbuf.mcarddata.mc_stat & CANOWNCRDT))
        // rcIni_Write_crdt_no();           /* クレジット通番インクリメント */
        // if(CMEM->working.crdt_reg.step == INPUT_END) {
        // rcClearCrdt_Reg();
        // Ky_St_R4(CMEM->key_stat[KY_CRDTIN]);
        // }
        // }
        // }
        // #else
        // if(   ((cm_crdt_system()) && (CMEM->working.crdt_reg.step == INPUT_END))
        // || ((rcCheckEntryCrdtMode() == TRUE) && (MEM->tTtllog.calcData.crdt_amt1 != 0L))
        // || ((rcCheckEntryCrdtSystem()) && (rcGetCrdtPayAmount())) ){
        // rcIni_Write_crdt_no();           /* クレジット通番インクリメント */
        // rcClearCrdt_Reg();
        // #if RALSE_CREDIT
        // rcRalseMcd_crdt_reg_Clr();
        // #endif
        // Ky_St_R0(CMEM->key_stat[KY_CRDTIN]);
        // Ky_St_R4(CMEM->key_stat[KY_CRDTIN]);
        // }
        // #if DEPARTMENT_STORE
        // if((cm_crdt_system()) && (rcChk_Crdt_User() == NAKAGO_CRDT))
        // CMEM->stat.Depart_Flg &= ~0x08;
        // #endif
        // #endif
        // #if IC_CONNECT
        // Ky_St_R4(CMEM->key_stat[KY_BRND_CIN]);
        // #endif
        // if (  (RC_INFO_MEM->RC_RECOG.RECOG_EAT_IN != RECOG_NO)    /* Eat-in system */
        // ||(RC_INFO_MEM->RC_RECOG.RECOG_KITCHEN_PRINT != RECOG_NO) )	/* Kitchen Print system */
        // {
        // rc_Inc_Eat_In_No();
        // }
        //
        // if(rcQC_Chk_Qcashier_System())
        // rcQC_AlarmFlag_Reset();
        //
        // if (rcChk_MultiEdy_System())
        // {
        // qc_alarm_flag = 0;
        // }

        //

        if (CompileFlag.ARCS_MBR) {
          if ((await RcSysChk.rcChkNTTDPrecaSystem())) {
            tsBuf.nttdPreca.rxData = RxMemNttdPrecaRx();
            if (await RcSysChk.rcQRChkPrintSystem()) {
              atSing.mbrCdBkup = '';
              mem.tmpbuf.autoCallReceiptNo = 0;
              mem.tmpbuf.autoCallMacNo = 0;
            }
          }
          if ((await RcSysChk.rcQCChkQcashierSystem())) {
            if (mem.tmpbuf.autoCallReceiptNo == RcqrCom.qrReadReptNo) {
              mem.tmpbuf.autoCallReceiptNo = 0;
              mem.tmpbuf.autoCallMacNo = 0;
            }
          }
        }

        // TODO:10121 QUICPay、iD 202404実装対象外 中略 L6244 ~ L6354

        if (await RcSysChk.rcChkBarcodePaySystem() != 0) {
          mem.bcdpay.bar = RxmemBcdpayBcd();
          mem.bcdpay.rxData = RxmemBcdpayRx();
        }
        if (CompileFlag.SMART_SELF) {
          if (await RcSysChk.rcChkDesktopCashier()) {
            await RcSet.rcSetCheckerUpdctrlFlg(0); // リセット＜精算＞
          }
        }

        if (await CmCksys.cmMultiVegaSystem() != 0) {
          cBuf.edySeterrFlg = 0; // 以後Edy可にする
        }

        atSing.lastEventTime = null;
        _rcATCTCashStatReset();
        await _rcATCTKyReset(fncCode, cMem, mem);
        break;
      case TendType.TEND_TYPE_CALC_TEND_END:
        _rcATCTCashStatReset();
        // TODO:10121 QUICPay、iD 202404実装対象外
        await _rcATCTKyReset(fncCode, cMem, mem);
        break;
      case TendType.TEND_TYPE_POST_TEND_END:
      case TendType.TEND_TYPE_SPOOL_IN:
        await _rcATCTKyReset(fncCode, cMem, mem);
        RcKyExtKey.rcKyExtKeyEnd();
        break;
      case TendType.TEND_TYPE_SPRIT_TEND:
        RcFncChk.rcKyResetStat(cMem.keyStat,
            RcRegs.MACRO0 + RcRegs.MACRO1 + RcRegs.MACRO2 + RcRegs.MACRO3);
        await RcAtct.rcAtctKyStR(cMem.keyStat);
        RcRegs.kyStS1(cMem.keyStat, FncCode.KY_REG.keyId);
        RcRegs.kyStS2(cMem.keyStat, FncCode.KY_FNAL.keyId);
        if ((fncCode >= 0) && (fncCode <= FuncKey.MAX_FKEY.keyId)) {
          RcRegs.kyStS2(cMem.keyStat, fncCode);
        }
        // TODO:00012 平野 [暫定対応] 商品券支払い
        mem.tTtllog.t100001Sts.sptendCnt++;

    // TODO:10158 商品券支払い 実装対象外
//         #if COLORFIP
//         if(rcChk_fself_system()) {
//         if (rcsyschk_happy_smile())
//         {
//         rc_fself_subttl_redisp();
//         }
//         else
//         {
// //                rc_fself_stltend_create(NULL, 1, NULL, 0, 0);
//         if(!rcChk_Settlterm_Keybtn ())//決済端末の操作じゃなければ小計画面表示
//             {
//         rc_fself_stltend_create (NULL, 1, NULL, 0, 0);
//         }
//         else
//         {
//         rc_fself_subttl_redisp ();//決済端末の操作であれば小計画面再描画
//         }
//         }
//         }
//         #endif

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行：6485-6505

      default:
    }

    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcATCT_End()", cMem.ent.errNo);
    } else {
      switch (eTendType) {
        case TendType.TEND_TYPE_NO_ENTRY_DATA:
        case TendType.TEND_TYPE_TEND_AMOUNT:
          if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
              ((koptTran.acbDrwFlg == 0) || cMem.acbData.acbDrwFlg == 0)) {
            RcSet.rcSetStTFlag(0);
          } else {
            if (cBuf.dbTrm.drwOpenFlg == 0 &&
                (await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)) {
              RcSet.rcSetStTFlag(4);
            } else {
              RcSet.rcSetStTFlag(0);
            }

            if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
                ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
                    (await RcSysChk.rcCheckQCJCSystem()))) {
              cMem.acbData.acbDrwFlg = 0;
            }
          }
          // TODO:10121 QUICPay、iD 202404実装対象外
          break;
        // case TEND_TYPE_SPOOL_IN:
        //   rcSet_ST_T_Flag(0);  /* Set Timer Number */
        //   break;
        //
        // case TEND_TYPE_SPRIT_TEND:
        // case TEND_TYPE_POST_TEND_START:
        // case TEND_TYPE_POST_TEND_END:
        // case TEND_TYPE_CALC_TEND_START:
        // case TEND_TYPE_CALC_TEND_END:
        default:
      }

      cMem.ent.errNo = 0;
    }

  }

  /// 関連tprxソース: rc_atct.c - rcATCT_End TEND_TYPE_CALC_TEND_END
  static void _rcATCTCashStatReset() {
    if (!RcSysChk.rcCheckCalcTend()) {
      return;
    }
    // TODO:10121 QUICPay、iD 202404実装対象外
    // Cash_Stat_Reset();
    // cm_mov((char *)&CMEM->post_reg, (char *)&CMEM->post_regsv, sizeof(POST_REG));
    // Ky_St_R0(CMEM->key_stat[KY_CALC]);       /* ポストテンダリング用データ戻す */
    //
    // rcStlLcd_Quantity(&Subttl);
    // if(subinit_Main_single_Special_Chk() == TRUE)
    //   rcStlLcd_Quantity(&Dual_Subttl);
  }

  /// 関連tprxソース: rc_atct.c - rcATCT_End TEND_TYPE_POST_TEND_ENDとTEND_TYPE_SPOOL_IN
  static Future<void> _rcATCTKyReset(
      int fncCode, AcMem cMem, RegsMem mem) async {
    mem.tTtllog.t100700Sts.msMbrSys = 0;
    //        CMEM->post_reg.sum_ttl = 0;
    //        rcErr_1time_Set();
    RcFncChk.rcKyResetStat(cMem.keyStat,
        RcRegs.MACRO0 + RcRegs.MACRO1 + RcRegs.MACRO2 + RcRegs.MACRO3);
    await RcAtct.rcAtctKyStR(cMem.keyStat);
    RcRegs.kyStR4(cMem.keyStat, FncCode.KY_FNAL.keyId);
    RcRegs.kyStS3(cMem.keyStat, FncCode.KY_FNAL.keyId);

    if (fncCode >= 0 && fncCode <= FuncKey.keyMax) {
      RcRegs.kyStS3(cMem.keyStat, fncCode);
    }

    await RcSet.cashStatReset2("rcATCT_End()");

    await RcSet.rcClearDualChkReg();

    mem.workInType = 0;
  }

  /// 関連tprxソース: rc_atct.c - rcATCT_Make_SalesTrans
  static Future<void> rcATCTMakeSalesTrans(TendType eTendType) async {
    int? plCnt; /* sales count pointer */
    int? plAmt; /* sales amount pointer */
    int? plDrw; /* in drawer amount pointer */
    int sales = 0; /* sales data */
    int? plshtCnt;
    int plSptendOutAmt = 0;
    int outOfSales; /* mdlcls out sales data */
    int refAmt = 1; /* 2007/04/26 */
    int minusSales = 0;
    // #if PROM
    // c_prom_mst promdata;
    // char now_datetime[SCH_DTM_SIZE+1];
    // int now_week;
    // #endif
    int refAmtTfree = 1;
    int typ;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    KopttranBuff kopttranBuff = KopttranBuff();
    RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttranBuff);
    int i, subNum = -1;
    int sptendCnt;

    // TODO:10158 商品券支払い 実装対象外
    // String splCnt; /* サブ在高cnt */
    // String splAmt; /* サブ在高Amount */
    // String splDrw; /* サブ在高Drw */
    // String splshtCnt;

    int subFlg = 0;
    int tmp;
    AtSingl atSing = SystemFunc.readAtSingl();
    AcbInfo acbInfo = AcbInfo();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    // TODO:10158 商品券支払い 実装対象外
    // #if DEBIT_CREDIT
    // #if RALSE_CREDIT
    // if ((rcChk_RalseCard_System()) &&
    // ((rcCheck_ESVoidI_Mode()) || (rcCheck_ESVoidS_Mode())))
    // rcATCT_Make_RlsCTran(eTendType);
    // else
    // #endif
    // rcATCT_Make_CTran(eTendType);
    // #endif

    sptendCnt = mem.tTtllog.t100001Sts.sptendCnt;

/* Sales, In Drawer */
    // plshtCnt = NULL;
    // SplCnt = NULL;
    // SplAmt = NULL;
    // SplshtCnt = NULL;
    // SplDrw = NULL;
    typ = RxLogCalc.rcCheckFuncAmtTyp(cMem.stat.fncCode);
    if (typ == -1) {
      plCnt = null; // plCnt = NULL;
      plAmt = null; // plAmt = NULL;
      plDrw = null; // plDrw = NULL;
    } else {
      plCnt = mem.tTtllog.t100200[typ].cnt;
      plAmt = mem.tTtllog.t100200[typ].amt;
      if (cMem.stat.fncCode != FuncKey.KY_CASH.keyId) {
        plshtCnt = mem.tTtllog.t100200[typ].sht;
      }
      if (howAmtUp == 1) {
        /* 現金加算 */
        plDrw = mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt;
      } else {
        plDrw = mem.tTtllog.t100200[typ].drwAmt;
      }

      // TODO:10158 商品券支払い 実装対象外
      // sub_flg = rc_fresta_paymentsub_chk(cMem.stat.fncCode);
      // if(sub_flg)
      // {
      // SplCnt	= &MEM->tTtllog.t100220[sptend_cnt].cnt;
      // SplAmt	= &MEM->tTtllog.t100220[sptend_cnt].amt;
      // if(cMem.stat.fncCode != KY_CASH)
      // {
      // SplshtCnt	= &MEM->tTtllog.t100220[sptend_cnt].sht;
      // }
      // if(howAmtUp == 1)	/* 現金加算 */
      // {
      // SplDrw	= NULL;
      // }
      // else
      // {
      // SplDrw	= &MEM->tTtllog.t100220[sptend_cnt].drw_amt;
      // }
      // }
    }

    /* 2007/04/26 >>> */
    if (cBuf.dbTrm.nontaxCha10 != 0) {
      if (RxLogCalc.rxCalcStlTaxAmt(RegsMem()) < 0) {
        if ((cMem.stat.fncCode == FuncKey.KY_CHA10.keyId) &&
            (mem.tTtllog.t100001Sts.sptendCnt == 0)) {
          refAmt = -1;
        }
      }
    }

    if (plAmt != null) {
      /* Sales Amount */
      if (mem
              .tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendChgAmt >=
          0) {
        if ((await RcAtct.rcChkChaReturn(kopttranBuff) == true) &&
            (mem
                    .tTtllog
                    .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                    .sptendChgAmt >=
                kopttranBuff.chkAmt)) {
          sales = 0; /* sales data */
          mem
              .tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendData = 0;
          atSing.chaReturnFlg = mem.tTtllog.t100001Sts.sptendCnt + 1;
        } else {
          /* 2007/04/26 >>> */
          if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
            if (refAmt == -1) {
              sales = RxLogCalc.rxCalcInTaxAmt(RegsMem()); /* sales data */
            } else if (refAmtTfree == -1) {
              sales = (RxLogCalc.rxCalcInTaxAmt(RegsMem()) +
                  RxLogCalc.rxCalcExTaxAmt(RegsMem())); /* sales data */
            } else {
              sales = mem
                  .tTtllog
                  .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                  .sptendInAmt; /* sales data */
            }
          } else {
            sales = mem
                .tTtllog
                .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                .sptendInAmt; /* sales data */
          }
        }
        if (chgFlg == 1) {
          typ = RxLogCalc.rcCheckFuncAmtTyp(cMem.stat.fncCode);
          if (typ != -1) {
            mem.tTtllog.t100200[typ].residualAmt = mem
                .tTtllog
                .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                .sptendChgAmt;
          }
          if (subFlg != 0) {
            mem.tTtllog.t100220[sptendCnt].residualAmt =
                mem.tTtllog.t100100[sptendCnt].sptendChgAmt;
          }
          mem
              .tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendChgAmt = 0;
        }
      } else /* short */ {
        sales = mem
            .tTtllog
            .t100100[mem.tTtllog.t100001Sts.sptendCnt]
            .sptendData; /* entry data */
      }
      plSptendOutAmt = mem
          .tTtllog
          .t100100[mem.tTtllog.t100001Sts.sptendCnt]
          .sptendOutAmt;
      plSptendOutAmt += mem
          .tTtllog
          .t100100[mem.tTtllog.t100001Sts.sptendCnt]
          .sptendInAmt;
      mem
          .tTtllog
          .t100100[mem.tTtllog.t100001Sts.sptendCnt]
          .sptendOutAmt = plSptendOutAmt;
      typ = RxLogCalc.rcCheckFuncAmtTyp(cMem.stat.fncCode);
      if (typ != -1) {
        mem.tTtllog.t100200[typ].kyCd = cMem.stat.fncCode;
      }
      if (RcSysChk.rcsyschkSm66FrestaSystem()) {
        mem.tTtllog.t100220[sptendCnt].kyCd = cMem.stat.fncCode;
        if (subFlg != 0) {
          mem.tTtllog.t100220[sptendCnt].divCd =
              mem.tTtllog.t100100[sptendCnt].divCd;
        }
      }

      if (RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
        sales = mem
            .tTtllog
            .t100100[mem.tTtllog.t100001Sts.sptendCnt]
            .sptendData; /* sales data */
      }

      outOfSales = 0;
      switch (eTendType) {
        case TendType.TEND_TYPE_NO_ENTRY_DATA:
        case TendType.TEND_TYPE_TEND_AMOUNT:
          if (atSing.chaReturnFlg == 0) {
            if (cBuf.dbTrm.rbtlAddSaleAmt == 0) {
              sales -=
                  (atSing.btlSaleAmt + mem.tTtllog.t100003.btlRetTaxAmt);
            } else {
              sales -= atSing.btlSaleAmt;
            }
          }
          if (plSptendOutAmt != null) {
            plSptendOutAmt -= atSing.btlSaleAmt;
            mem
                .tTtllog
                .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                .sptendOutAmt = plSptendOutAmt;
          }
          break;
        case TendType.TEND_TYPE_SPRIT_TEND:
          if ((atSing.btlSaleAmt != 0) && (plSptendOutAmt != null)) {
            if (sales > (plSptendOutAmt - atSing.btlSaleAmt)) {
              outOfSales = (plSptendOutAmt - sales);
              sales = (plSptendOutAmt - atSing.btlSaleAmt);
              plSptendOutAmt = sales;
              mem
                  .tTtllog
                  .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                  .sptendOutAmt = plSptendOutAmt;
              atSing.btlSaleAmt = outOfSales;
            } else {
              plSptendOutAmt -= atSing.btlSaleAmt;
              mem
                  .tTtllog
                  .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                  .sptendOutAmt = plSptendOutAmt;
            }
          }
          break;
        default:
          break;
      }

      if (((RcSysChk.rcCheckEtcOperation()) ||
              (await CmCksys.cmMarutoSystem() != 0) ||
              (await CmCksys.cmSm3MaruiSystem() != 0) ||
              (RcSysChk.rcChkSpecialMultiOpe())) &&
          (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) &&
          (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
        if (eTendType != TendType.TEND_TYPE_SPRIT_TEND) {
          //品券等押下・置数後の乗算キー使用時は、1品券分実績をマイナスする。（押下した品券を４枚乗算したら５枚の品券実績が作られてしまうため)
          minusSales = Bcdtol.cmBcdToL(cMem.ent.entry);
          minusSales = minusSales ~/ cMem.working.dataReg.kMul0;
        } else {
          if (sales != 0) {
            if (outOfSales != 0) {
              minusSales = Bcdtol.cmBcdToL(cMem.ent.entry);
              minusSales = minusSales ~/ cMem.working.dataReg.kMul0;
            } else {
              minusSales = sales ~/ cMem.working.dataReg.kMul0;
            }
          }
        }
        sales -= minusSales;
      }
      plAmt += sales; /* sales data */
      mem.tTtllog.t100200[typ].amt = plAmt;

      // TODO:10158 商品券支払い 実装対象外
      // if(splAmt != NULL)
      // {
      // *splAmt = sales; /* sales data */
      // }

      mem.tTtllog.t100001.saleAmt += sales; /* sales amount */
      // TODO:10158 商品券支払い 実装対象外
//     #if 0
// //@@@V15
//     if(cm_RainbowCard_system() && ((RC_INFO_MEM->RC_RECOG.RECOG_VISMACSYSTEM == RECOG_NO) && (C_BUF->db_trm.heso_sale_manual_prc))){
//     MEM->tTtllog.t100900.vmc_heso_amt += CMEM->acbdata.ccin_add_price;    /* acb ccin add amount */
//     }
//     #endif
      if ((await RcSysChk.rcSGChkSelfGateSystem()) ||
          (await RcSysChk.rcQCChkQcashierSystem())) {
        if (cBuf.dbTrm.selfSaleprcInclTax != 0) {
          mem.tTtllog.t100001.selfgateAmt +=
              sales; /* SelfGate sales amount */
        } else {
          if (cBuf.dbTrm.dscShareFlg == 0) {
            mem.tTtllog.t100001.selfgateAmt =
                mem.tTtllog.t100001.netslAmt; /* SelfGate sales amount */
          } else {
            mem.tTtllog.t100001.selfgateAmt =
                mem.tTtllog.t100001.grsslAmt; /* SelfGate sales amount */
          }
        }
      }
      // TODO:10158 商品券支払い 実装対象外
      // #if PROM
      // if( rcChk_Prom_System2())	{
      // if( rcChk_Prom_System_MultiStep() )
      // {
      // long	promCode;

      // if( (promCode = rcATCT_GetPromCodeMultiStep(MEM->tTtllog.t100001.sale_amt)) != 0 )
      // {
      // MEM->tTtllog.t101000[7].prom_ticket_no = promCode;
      // rcmbrSetPromData();
      // }
      // }
      // else
      // {
      // rcSchGetDtm(now_datetime, &now_week);
      // if( MEM->tTtllog.t100001.sale_amt >= C_BUF->db_trm.promissue_lowlimit ) {
      // memset(&promdata, 0, sizeof(c_prom_mst));
      // if (rcmbrReadProm(C_BUF->db_trm.promissue_no, &promdata, 0) == NORMAL) {
      // if (! promdata.pri_stop_flg)
      // /* 有効期限のチェック */
      // if ((memcmp(now_datetime, promdata.pri_start_datetime, sizeof(promdata.pri_start_datetime)) >= 0)
      // && (memcmp(now_datetime, promdata.pri_end_datetime, sizeof(promdata.pri_end_datetime)) <= 0)) {
      // if (rcSchWeekChk(now_week, promdata.pri_sun_flg,  promdata.pri_mon_flg,  promdata.pri_tue_flg,
      // promdata.pri_wed_flg,  promdata.pri_thu_flg,  promdata.pri_fri_flg, promdata.pri_sat_flg) == RCSCH_OK) {
      // MEM->tTtllog.t101000[7].prom_ticket_no = C_BUF->db_trm.promissue_no;
      // rcmbrSetPromData();
      // }
      // }
      // }
      // }
      // }
      // }
      // #endif
    }
    if (plCnt != null) {
      /* Sales Count */
      if ((plAmt != null) && (sales != 0)) {
        /* Sales Amount */
        plCnt++;
        mem.tTtllog.t100200[typ].cnt = plCnt;

        if (((RcSysChk.rcCheckEtcOperation()) ||
                (await CmCksys.cmMarutoSystem() != 0) ||
                (await CmCksys.cmSm3MaruiSystem() != 0) ||
                (RcSysChk.rcChkSpecialMultiOpe())) &&
            (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) &&
            (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
          plCnt++; //品券等押下・置数後の乗算キー使用時は、1品券分実績をマイナスする。（押下した品券を４枚乗算したら５枚の品券実績が作られてしまうため)
          mem.tTtllog.t100200[typ].cnt = plCnt;
        }
//     #if 0
// //@@@V15
//     if(cm_RainbowCard_system() && ((RC_INFO_MEM->RC_RECOG.RECOG_VISMACSYSTEM == RECOG_NO) && (C_BUF->db_trm.heso_sale_manual_prc))){
//     if(CMEM->acbdata.ccin_add_price != 0){ /* Sales Amount */
//     MEM->tTtllog.t100900.vmc_hesotckt_cnt ++;    /* acb ccin add count */
//     }
//     }
//     #endif
      }
    }
    if (plDrw != null) {
      if (howAmtUp == 1) {
        /* In  Drawer Amount */
        plDrw += mem
            .tTtllog
            .t100100[mem.tTtllog.t100001Sts.sptendCnt]
            .sptendData;
        mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt = plDrw;

        if (((RcSysChk.rcCheckEtcOperation()) ||
                (await CmCksys.cmMarutoSystem() != 0) ||
                (await CmCksys.cmSm3MaruiSystem() != 0) ||
                (RcSysChk.rcChkSpecialMultiOpe())) &&
            (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) &&
            (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
          plDrw -=
              minusSales; //品券等押下・置数後の乗算キー使用時は、1品券分実績をマイナスする。（押下した品券を４枚乗算したら５枚の品券実績が作られてしまうため)
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt = plDrw;
        }
      } else {
        /* In  Drawer Amount */
        plDrw += mem
            .tTtllog
            .t100100[mem.tTtllog.t100001Sts.sptendCnt]
            .sptendData;
        mem.tTtllog.t100200[typ].drwAmt = plDrw;

        if (((RcSysChk.rcCheckEtcOperation()) ||
                (await CmCksys.cmMarutoSystem() != 0) ||
                (await CmCksys.cmSm3MaruiSystem() != 0) ||
                (RcSysChk.rcChkSpecialMultiOpe())) &&
            (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) &&
            (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
          plDrw -=
              minusSales; //品券等押下・置数後の乗算キー使用時は、1品券分実績をマイナスする。（押下した品券を４枚乗算したら５枚の品券実績が作られてしまうため)
          mem.tTtllog.t100200[typ].drwAmt = plDrw;
        }
      }
    }
    if (plshtCnt != null) {
      /* In  Drawer Amount */
      if ((plAmt != null) && (sales != 0)) {
        /* Sales Amount */
        if (cMem.working.dataReg.kMul0 != 0) {
          plshtCnt += cMem.working.dataReg.kMul0;
          mem.tTtllog.t100200[typ].sht = plshtCnt;
        } else {
          plshtCnt++;
          mem.tTtllog.t100200[typ].sht = plshtCnt;
        }

        if (((RcSysChk.rcCheckEtcOperation()) ||
                (await CmCksys.cmMarutoSystem() != 0) ||
                (await CmCksys.cmSm3MaruiSystem() != 0) ||
                (RcSysChk.rcChkSpecialMultiOpe())) &&
            (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) &&
            (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
          plshtCnt++; //品券等押下・置数後の乗算キー使用時は、1品券分実績をマイナスする。（押下した品券を４枚乗算したら５枚の品券実績が作られてしまうため)
          mem.tTtllog.t100200[typ].sht = plshtCnt;
        }
      }
    }

    // TODO:10158 商品券支払い 実装対象外
    // if((splCnt.isNotEmpty) && (sales != 0))
    // {
    // *splCnt = 1;
    // }
    // if(splDrw.isNotEmpty)
    // {
    // *splDrw = mem.tTtllog.t100100[sptendCnt].sptendData;
    // }
    // if((splshtCnt.isNotEmpty) && (sales != 0))
    // {
    // if(cMem.working.dataReg.kMul0 != 0)
    // (*splshtCnt) = cMem.working.dataReg.kMul0;
    // else
    // *splshtCnt = 1;
    // }

    if (chgFlg == 1) {
      mem.tTtllog.t100001.chgAmt = 0; /* change/return amount */
    }
    if (mem.tTtllog.t100001.chgAmt > 0) /* change/return amount ? */ {
      if (qcNotepluChangeFlg == 0) {
        mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt -=
            mem.tTtllog.t100001.chgAmt;
      }
      /* cash change/return amount */

      if (RcSysChk.rcChkKYCHA(cMem.stat.fncCode)) {
        typ = RxLogCalc.rcCheckFuncAmtTyp(cMem.stat.fncCode);
        if (typ != -1) {
          mem.tTtllog.t100200[typ].chkChgAmt =
              mem.tTtllog.t100001.chgAmt;
        }
        if (subFlg != 0) {
          mem.tTtllog.t100220[sptendCnt].chkChgAmt =
              mem.tTtllog.t100001.chgAmt;
        }
      }
    }

    if (CompileFlag.VISMAC) {
      if ((cBuf.dbTrm.vmcDrwamtMinus != 0) &&
          (await RcSysChk.rcChkVMCSystem())) {
        if (mem.tTtllog.t100900.todayChgamt > 0) {
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt -=
              mem.tTtllog.t100900.todayChgamt;
        }
      }
    }

    if (CompileFlag.ARCS_MBR) {
      if (await RcSysChk.rcChkNTTDPrecaSystem()) {
        if ((mem.tTtllog.t100001Sts.chrgFlg == 1) &&
            (cBuf.dbTrm.precaChargeNotDrwamt != 0)) {
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt -=
              mem.tTtllog.t100900.todayChgamt;
        }
      }
    }

    // TODO:10158 商品券支払い 実装対象外
    // if(rcChk_TRK_Preca_System()) {
    // if( (MEM->tTtllog.t100001Sts.chrg_flg == 1) && (C_BUF->db_trm.preca_charge_not_drwamt) )
    // MEM->tTtllog.t100200[AMT_CASH].drw_amt -= MEM->tTtllog.t100900.today_chgamt;
    // }

    mem.tTtllog.t100001.manSht +=
        cMem.working.dataReg.kMan0; /* 10,000 key count */
    if ((cMem.acbData.ccinPrice != 0) &&
        ((await CmCksys.cmMarutoSystem() != 0) ||
            ((RcSysChk.rcsyschkSm66FrestaSystem() &&
                (!RcFncChk.rcCheckRcptvoidLoadOrgTran()))))) {
      mem.tTtllog.t100001.manSht += AcbInfo.cindata.bill10000;
    } else if (RcSysChk.rcsyschkSm66FrestaSystem()) {
      tmp =
          AcbInfo.cindata.bill10000 - mem.tTtllog.t100002Sts.rcptCashMan;
      if (tmp > 0) {
        mem.tTtllog.t100001.manSht += tmp;
      }
    }

// TODO:10158 商品券支払い 実装対象外
    // if (CompileFlag.MBR_SPEC) {
    // if(rcChk_Mbr())   /* MEMBER system ? */
    // TSTA.purmbrsv = TMS.trad_mspur;   /* purchases under member service */
    // #endif

    // if (  (RC_INFO_MEM->RC_RECOG.RECOG_EAT_IN != RECOG_NO)    /* Eat-in system */
    // ||(RC_INFO_MEM->RC_RECOG.RECOG_KITCHEN_PRINT != RECOG_NO) )	/* Kitchen Print system */
    // {
    // rcATCT_EatIn();
    // }

    // if(rcChk_Edy_System())
    // rcATCT_Make_EdyTrans(eTendType);
    // else {
    // if(rcChk_MultiEdy_System())
    // rcATCT_Make_MultiEdyTrans(eTendType);
    // }

    /* 2007/07/30 >>> */
    if (cBuf.dbTrm.nontaxCha10 != 0) {
      if (mem.tTtllog.t100200[AmtKind.amtCha10.index].amt != 0) {
        mem.tTtllog.calcData.crdtAmt2 =
            mem.tTtllog.t100001.saleAmt -
                mem.tTtllog.t100200[AmtKind.amtCha10.index].amt;
        /* 免税対象額算出：クレジット２　＝　税込み合計　－　会計１０ */
      }
    } else if (await RckyTaxFreeIn.rcTaxFreeChkTaxFreeIn() != 0) {
      // TODO:10158 商品券支払い 実装対象外
      // MEM->tTtllog.t109000.tax_exempt_amt	 = rc_TaxFree_Sum_TaxFreeAmt_each_flg(1);
      // MEM->tTtllog.t109000.tax_exempt_amt_gnrl = rc_TaxFree_Sum_TaxFreeAmt_each_flg(2);
      // MEM->tTtllog.t109000.tax_exempt_cust	 = MEM->tTtllog.t100001.cust;
      // if(rcsyschk_liqr_taxfree_system())
      // MEM->tTtllog.t109000.liqrtax_free_amt = rc_TaxFree_Sum_Liqr_TaxFreeAmt();
      // if(rcsyschk_taxfree_system())
      // {
      // MEM->tTtllog.t109000.corp_code	= TS_BUF->taxfree.corp_code;
      // MEM->tTtllog.t109000.shop_code	= TS_BUF->taxfree.shop_code;
      // snprintf(MEM->tTtllog.t109000.term_code, sizeof(MEM->tTtllog.t109000.term_code), "%s", TS_BUF->taxfree.term_code);
      // }
    } else {
      mem.tTtllog.t109000 = T109000();
    }

    rcAmtKyCdMakeTtlLog();

// TODO:10158 商品券支払い 実装対象外
    // if(rcChk_Suica_System())
    // {
    // rcATCT_Make_SuicaTrans();
    // }
    // else {
    // if(rcChk_MultiSuica_System())
    // {
    // rcATCT_Make_MultiSuicaTrans(eTendType);
    // if(rcChk_MultiVega_PayMethod(FCL_SUIC))
    // {
    // rcATCT_Make_SuicaTrans();
    // }
    // }
    // }

    // if( (cm_Media_Info_system()) && !(rcChk_Edy_System()) && !(rcChk_MultiEdy_System()) )
    // rcATCT_Make_MediaTrans();
  }

  /// 券面のみ金種の枚数加算処理
  /// 関連tprxソース: rc_atct.c - rcProcAddTicket
  static Future<void> rcProcAddTicket() async {
    KopttranBuff koptTran = KopttranBuff();
    RegsMem mem = SystemFunc.readRegsMem();

    if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
      return;
    }

    // 券面のみ金種の枚数加算動作かチェック
    AcMem cMem = SystemFunc.readAcMem();
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
    if (!rcCheckAddTicket(koptTran)) {
      return;
    }

    // TODO:実機確認の結果、以降処理は不要のため実装は保留
/*
    // 操作金種の合算処理
    searchNum = -1;
    spltData	= &MEM->tTtllog.t100100[0];
    spltStatus	= &MEM->tTtllog.t100100Sts[0];
    for( num = 0; num < MEM->tTtllog.t100001Sts.sptend_cnt; num++ )
    {
    if( (spltData + num)->sptend_cd == CMEM->stat.FncCode )
    {
    if( searchNum == -1 )
    {
    searchNum = num;
    }
    else
    {
    long	sht1 = (spltData + num)->sptend_sht;
    long	sht2 = (spltData + searchNum)->sptend_sht;

    if( sht1 == 0 )
    {
    sht1 = 1;
    }
    if( sht2 == 0 )
    {
    sht2 = 1;
    }
    if( (sht1 + sht2) > ADD_TICKET_MAX_SHEET )
    {
    searchNum = num;
    continue;
    }

    if( (spltData + num)->sptend_sht == 0 )
    {
    (spltData + num)->sptend_sht = 1;
    }
    if( (spltData + searchNum)->sptend_sht == 0 )
    {
    (spltData + searchNum)->sptend_sht = 1;
    }
    (spltData + num)->sptend_sht	+= (spltData + searchNum)->sptend_sht;
    (spltData + num)->sptend_data	+= (spltData + searchNum)->sptend_data;
    (spltData + num)->man_cnt		+= (spltData + searchNum)->man_cnt;
    (spltData + num)->sptend_face_amt	= KOPTTRAN.chk_amt;
    rcClearSptendStructData( searchNum );

    searchNum = -2;
    break;
    }
    }
    }
    if( searchNum != -2 )
    {
    return;
    }

    // スプリットを詰める
    tempCount	= 0;
    maxSptendNum	= MEM->tTtllog.t100001Sts.sptend_cnt;
    for( num = 0; num < maxSptendNum; num++ )
    {
    if( (spltData + num)->sptend_cd == 0 )
    {
    for( setNum = num + 1; setNum < maxSptendNum; setNum++ )
    {
    if( (spltData + setNum)->sptend_cd != 0 )
    {
    // スプリット段の移動(setNum の段情報を num に移動)
    rcMoveSptendStructData( num, setNum );
    rcClearSptendStructData( setNum );
    break;
    }
    }
    if( (spltData + num)->sptend_cd == 0 )
    {
    break;
    }
    }
    (spltData + num)->sptend_out_amt	= 0L;
    tempCount++;

    }
    // 再計算処理
    MEM->tTtllog.t100001Sts.sptend_cnt	= tempCount;
    rcSPTendBuf_Edit(0);
    rcStlItemCalc_Main(STLCALC_INC_MBRRBT);
    rcSPTendBuf_Edit(1);
    rcATCTProcCheckPassSet( PASS_CHECK_ON );
    rcSPTend_ReCalc();
    rcATCTProcCheckPassSet( PASS_CHECK_OFF );

    // スプリット履歴の再描画
    if( rcChk_SptendInfo() == TRUE )
    {
    rcSptendInfo_Quit(&Subttl);
    if(subinit_Main_single_Special_Chk() == TRUE)
    {
    rcSptendInfo_Quit(&Dual_Subttl);
    }
    MEM->tTtllog.t100001Sts.sptend_cnt	= 0;

    if( (tempCount - 1) != 0 )
    {
    rcSptendInfo_Draw(&Subttl);
    if(subinit_Main_single_Special_Chk() == TRUE)
    {
    rcSptendInfo_Draw(&Dual_Subttl);
    }
    }

    saveTotalPrice = CMEM->acbdata.total_price;
    for( num = 0; num < tempCount - 1; num++ )
    {
    MEM->tTtllog.t100001Sts.sptend_cnt	= num + 1;
    CMEM->stat.FncCode	= (spltData + num)->sptend_cd;

    CMEM->acbdata.total_price = 0;
    rcStlLcd_Sprit( CT_SHORT, &Subttl );
    rcSptendInfo_Set(&Subttl, SPTEND_MAX);

    if(subinit_Main_single_Special_Chk() == TRUE)
    {
    rcStlLcd_Sprit( CT_SHORT, &Dual_Subttl );
    rcSptendInfo_Set(&Dual_Subttl, SPTEND_MAX);
    }
    }
    CMEM->acbdata.total_price = saveTotalPrice;
    }

    CMEM->stat.FncCode	= (spltData + (tempCount - 1))->sptend_cd;
    MEM->tTtllog.t100001Sts.sptend_cnt	= tempCount;

    return;
 */
  }

  /// 券面のみ金種の枚数加算動作かチェック
  /// 関連tprxソース: rc_atct.c - rcCheckAddTicket
  static bool rcCheckAddTicket(KopttranBuff koptTran) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    AcMem cMem = SystemFunc.readAcMem();
    if (Rxkoptcmncom.rxChkKoptCmnAddTicket(pCom, cMem.stat.fncCode) &&   // 加算動作設定
        (koptTran.chkAmt > 0) &&  // 券面金額あり
        (koptTran.frcEntryFlg == 3)) {   // 置数方法  券面のみ
      return true;
    }
    return false;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 関連tprxソース: rc_atct.c - rcATCTVoidRefundChkIchiyama
  static bool rcATCTVoidRefundChkIchiyama() {
    return true;
  }

  /// 関連tprxソース: rc_atct.c - rcATCT_RcptMsgTckt_TotalBuf
  static Future<void> rcATCTRcptMsgTcKtTotalBuf(TendType eTendType) async {
    if (RcSysChk.rcSysChkP11PrizeSystem()) {
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcATCTRcptMsgTcKtTotalBuf() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
        if ((cBuf.dbTrm.prnSaleTicket != 0) &&
            ((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT1.keyId].msg_cd != 0) ||
             (cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT2.keyId].msg_cd != 0)) &&
            (rcChkRcptMsgSet()) &&
            (cBuf.dbTrm.pctrTcktStore != 0)) {
          if (!(((cBuf.dbTrm.tcktPrnTarget == 1) && (mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index)) ||
              ((cBuf.dbTrm.tcktPrnTarget == 2) && (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index)))) {
            if (cBuf.dbTrm.issueTicketEnOver != 0) {
              if (RxLogCalc.rxCalcStlTaxInAmt(RegsMem()) >= cBuf.dbTrm.pctrTcktStore) {
                mem.tTtllog.t100002Sts.purchaseTcktCnt = 1;     /* 金券本日発券 1 の回数 */
              }
            } else {
              if (await RcSysChk.rcChkPurchaseTicketSystem()) {
                if (RxLogCalc.rxCalcStlTaxInAmt(RegsMem()) >= cBuf.dbTrm.pctrTcktStore) {
                  mem.tTtllog.t100002Sts.purchaseTcktCnt = 1;     /* 金券本日発券 1 の回数 */
                }
              } else {
                int stlTaxInAmt = mem.tTtllog.t100001.stlTaxInAmt;
                int pcTrTcKtStore = cBuf.dbTrm.pctrTcktStore;
                int purchaseTcKtCnt = 0;
                if ((stlTaxInAmt != 0) && (pcTrTcKtStore != 0)) {
                  purchaseTcKtCnt = stlTaxInAmt ~/ pcTrTcKtStore;
                }
                mem.tTtllog.t100002Sts.purchaseTcktCnt = purchaseTcKtCnt;     /* 金券本日発券 1 の回数 */
              }
            }
          }
        }
        break;
      default:
        break;
    }
  }

  /// 関連tprxソース: rc_atct.c - rcChk_RecptMsg_Set
  static bool rcChkRcptMsgSet() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcATCTRcptMsgTcKtTotalBuf() rxMemRead error\n");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return (((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT1.keyId].msg_data_1).isNotEmpty) ||
            ((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT1.keyId].msg_data_2).isNotEmpty) ||
            ((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT1.keyId].msg_data_3).isNotEmpty) ||
            ((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT1.keyId].msg_data_4).isNotEmpty) ||
            ((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT2.keyId].msg_data_1).isNotEmpty) ||
            ((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT2.keyId].msg_data_2).isNotEmpty) ||
            ((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT2.keyId].msg_data_3).isNotEmpty) ||
            ((cBuf.dbRecMsg[DbMsgmstIdx.DB_MSGMST_BUYTCKT2.keyId].msg_data_4).isNotEmpty));
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_atct.c - rcCardCrew_Make_ActualLog
  static void rcCardCrewMakeActualLog(TendType eTendType) {}

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_atct.c - rcStlItemPromSet
  static void rcStlItemPromSet(eTendType) {}

  /// 関連tprxソース: rc_atct.c - rcATCT_Zero_TotalBuf
  static void rcATCTZeroTotalBuf() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcATCTZeroTotalBuf() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (cBuf.dbTrm.notUpdCust0sales != 0) {
      if (RxLogCalc.rxCalcStlTaxAmt(RegsMem()) == 0) {
        rcATCTZeroTotalBufProc();
      }
    }
    if (cBuf.dbTrm.nonAddStoreCustRetBottle != 0) {
      if ((mem.tTtllog.t100003.outMdlclsAmt !=0) &&
          (mem.tTtllog.t100001.netslAmt == 0)) {
        rcATCTZeroTotalBufProc();
      }
    }
    if (CmCksys.cmCoopAIZUSystem() != 0) {
      if (((mem.tTtllog.t100003.refundQty != 0) || (mem.tTtllog.t100003.refundAmt != 0)) ||
          ((mem.tTtllog.t100003.btlRetQty != 0) || (mem.tTtllog.t100003.btlRetAmt != 0))) {
        rcATCTZeroTotalBufProc();
      }
    }
    if (RcSysChk.rcsyschkSm66FrestaSystem()) {
      if (RcAjsEmoney.rcCheckAjsEmoneyDepositItem(1) != 0) {
        rcATCTZeroTotalBufProc();
      }
    }
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_atct.c - rcATCT_Zero_TotalBuf_Proc
  static void rcATCTZeroTotalBufProc() {}

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 手動返品用のデータセット
  /// 関連tprxソース: rc_atct.c - rcATCT_SetManualRefundData
  static void rcATCTSetManualRefundData() {}

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// ユーザーごとの連番セット関数
  /// 関連tprxソース: rc_atct.c - rcSetSpecialUserCount
  static void rcSetSpecialUserCount() {}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 本日割戻達成回数を実績にセットする
  /// 関連tprxソース: rc_atct.c - rcmbr_Set_RbtData
  static void rcmbrSetRbtData() {}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 非会員ポイント印字のデータを作成する
  /// 関連tprxソース: rc_atct.c - rc_NonMbr_SetPtsData
  static void rcNonMbrSetPtsData() {}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// Tポイント実績データを作成する
  /// 関連tprxソース: rc_atct.c - rc_Tpoint_SetLogData
  static void rcTpointSetLogData() {}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 上位サーバーが参照する実績を残す場所. または, 使用しなかった実績を画面訂正化する場所.
  /// 関連tprxソース: rc_atct.c - rcSet_TranDataEditProc
  static void rcSetTranDataEditProc() {}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// WS様向けロイヤリティ実績を格納する関数
  /// 関連tprxソース: rc_atct.c - rcAtct_Set_LoyData_WS
  static void rcAtctSetLoyDataWS() {}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 関連tprxソース: rc_atct.c - rcATCT_Make_FrestaTrans
  static void rcATCTMakeFrestaTrans() {}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 関連tprxソース: rc_atct.c - rcATCT_Make_RfmData
  static void rcATCTMakeRfmData() {}

  /// 関連tprxソース: rc_atct.c - rcChk_Cha_Return
  static Future<bool> rcChkChaReturn(KopttranBuff kopttran) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if ((await RcFncChk.rcCheckESVoidMode()) ||
        (await RcFncChk.rcCheckESVoidIMode()) ||
        (await RcFncChk.rcCheckESVoidVMode()) ||
        (await RcFncChk.rcCheckESVoidCMode()) ||
        (await RcFncChk.rcCheckESVoidSDMode())) {
      return false;
    }
    AtSingl atSing = SystemFunc.readAtSingl();
    if ((pCom.dbTrm.nonChangeOverAmt != 0) &&
        (kopttran.chkAmt > 0) &&
        (kopttran.nochgFlg == 0) &&
        ((RcSysChk.rcChkKYCHA(cMem.stat.fncCode)) &&
            (kopttran.crdtEnbleFlg == 0)) &&
        ((RcSysChk.rcChkKYCHA(cMem.stat.fncCode)) &&
            (kopttran.tranUpdateFlg == 0))) {
      return true;
    } else if ((atSing.limitFlg == 1) &&
        (pCom.dbTrm.originalCardOpe != 0) &&
        (kopttran.crdtEnbleFlg == 1) &&
        (RcSysChk.rcChkKYCHA(cMem.stat.fncCode))) {
      return true;
    } else {
      return false;
    }
  }

  // TODO:00002 佐野 rckycrdtvoid.dart 実装のため、宣言のみ定義
  /// 品券金種を現金に変換し加算する
  ///  関連tprxソース: rc_atct.c - rcConvertGiftToCash()
  static void rcConvertGiftToCash() {}

  /// 関連tprxソース: rc_atct.c - rcATCT_Make_CTran()
  static Future<void> rcATCTMakeCTran(TendType eTendType) async {
    int sales = 0;
    int outOfSales = 0; /* mdlcls out sales data */
    KopttranBuff koptTranBuff = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();

    if (RcSysChk.rcTROpeModeChk() || RcSysChk.rcVDOpeModeChk()) {
      RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTranBuff);
      int? plCAmt = await getPlCAmt(koptTranBuff);
      int? plCCnt = await getPlCCnt(koptTranBuff);

      if (plCAmt != null) {
        /* Sales Amount */
        if (mem
                .tTtllog
                .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                .sptendChgAmt >=
            0) {
          sales = mem
              .tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendInAmt; /* sales data */
        } else {
          /* short */
          sales = mem
              .tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendData; /* entry data */
        }

        switch (eTendType) {
          case TendType.TEND_TYPE_NO_ENTRY_DATA:
          case TendType.TEND_TYPE_TEND_AMOUNT:
            mem
                .tTtllog
                .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                .sptendOutAmt -= atSingl.btlSaleAmt;
            break;
          case TendType.TEND_TYPE_SPRIT_TEND:
            if (atSingl.btlSaleAmt != 0) {
              if (sales >
                  (mem
                          .tTtllog
                          .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                          .sptendOutAmt -
                      atSingl.btlSaleAmt)) {
                outOfSales = (mem
                        .tTtllog
                        .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                        .sptendOutAmt -
                    sales);
                mem
                    .tTtllog
                    .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                    .sptendOutAmt = outOfSales;
                atSingl.btlSaleAmt = outOfSales;
              } else {
                mem
                    .tTtllog
                    .t100100[mem.tTtllog.t100001Sts.sptendCnt]
                    .sptendOutAmt -= atSingl.btlSaleAmt;
              }
            }
            break;
          default:
            break;
        }
        plCAmt += sales; /* sales data */
        setPlCAmt(plCAmt, koptTranBuff);
      }
      if (plCCnt != null) {
        /* Sales Count */
        if ((plCAmt != null) && (sales != 0)) {
          /* Sales Amount */
          plCCnt++;
          setPlCCnt(plCCnt, koptTranBuff);
        }
      }
    }
  }

  /// plCCnt取得関数
  static Future<int?> getPlCCnt(KopttranBuff koptTranBuff) async {
    int plCCnt = 0;
    RegsMem mem = SystemFunc.readRegsMem();

    if ((RcSysChk.rcTROpeModeChk()) && (koptTranBuff.crdtTyp == 0)) {
      if ((RcSysChk.rcTROpeModeChk()) &&
          ((koptTranBuff.crdtTyp == 0) ||
              ((await CmCksys.cmIDSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 5)) ||
              ((RcSysChk.rcChkSmartplusSystem()) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmVisaTouchSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmQUICPaySystem() != 0) &&
                  (koptTranBuff.crdtTyp == 9)) ||
              ((await CmCksys.cmPiTaPaSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 10)) ||
              ((await CmCksys.cmGinCardSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 17)) ||
              ((await CmCksys.cmTuoSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 11)) ||
              ((await CmCksys.cmCctConnectSystem() != 0) &&
                  (await CmCksys.cmCctEmoneySystem() != 0) &&
                  ((RcSysChk.rcChkJETBProcess()) ||
                      (RcSysChk.rcChkINFOXProcess())) &&
                  ((koptTranBuff.crdtTyp == 5) ||
                      (koptTranBuff.crdtTyp == 9))))) {
        plCCnt = mem.tTtllog.calcData.mtriningCrdtCnt;
      } else if ((RcSysChk.rcTROpeModeChk()) &&
          (koptTranBuff.crdtTyp == 8) &&
          (await CmCksys.cmNttaspSystem() == 0) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
        plCCnt = mem.tTtllog.calcData.mtriningCrdtCnt;
      } else if ((RcSysChk.rcTROpeModeChk()) && (koptTranBuff.crdtTyp == 1)) {
        plCCnt = mem.tTtllog.calcData.mtriningCrdtCnt;
      } else if ((RcSysChk.rcVDOpeModeChk()) &&
          ((koptTranBuff.crdtTyp == 0) ||
              ((await CmCksys.cmIDSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 5)) ||
              ((RcSysChk.rcChkSmartplusSystem()) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmVisaTouchSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmQUICPaySystem() != 0) &&
                  (koptTranBuff.crdtTyp == 9)) ||
              ((await CmCksys.cmPiTaPaSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 10)) ||
              ((await CmCksys.cmGinCardSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 17)) ||
              ((await CmCksys.cmTuoSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 11)) ||
              ((await CmCksys.cmCctConnectSystem() != 0) &&
                  (await CmCksys.cmCctEmoneySystem() != 0) &&
                  ((RcSysChk.rcChkJETBProcess()) ||
                      (RcSysChk.rcChkINFOXProcess())) &&
                  ((koptTranBuff.crdtTyp == 5) ||
                      (koptTranBuff.crdtTyp == 9))))) {
        plCCnt = mem.tTtllog.calcData.mvoidCrdtCnt;
      } else if ((RcSysChk.rcVDOpeModeChk()) &&
          (koptTranBuff.crdtTyp == 8) &&
          (await CmCksys.cmNttaspSystem() == 0) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
        plCCnt = mem.tTtllog.calcData.mvoidCrdtCnt;
      } else if ((RcSysChk.rcVDOpeModeChk()) && (koptTranBuff.crdtTyp == 1)) {
        plCCnt = mem.tTtllog.calcData.mvoidDebitCnt;
      } else {
        plCCnt = 0;
      }
    } else {
      plCCnt = 0;
    }
    return plCCnt;
  }

  /// plCCntセット関数
  static Future<void> setPlCCnt(int plCCnt, KopttranBuff koptTranBuff) async {
    RegsMem mem = SystemFunc.readRegsMem();

    if ((RcSysChk.rcTROpeModeChk()) && (koptTranBuff.crdtTyp == 0)) {
      if ((RcSysChk.rcTROpeModeChk()) &&
          ((koptTranBuff.crdtTyp == 0) ||
              ((await CmCksys.cmIDSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 5)) ||
              ((RcSysChk.rcChkSmartplusSystem()) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmVisaTouchSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmQUICPaySystem() != 0) &&
                  (koptTranBuff.crdtTyp == 9)) ||
              ((await CmCksys.cmPiTaPaSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 10)) ||
              ((await CmCksys.cmGinCardSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 17)) ||
              ((await CmCksys.cmTuoSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 11)) ||
              ((await CmCksys.cmCctConnectSystem() != 0) &&
                  (await CmCksys.cmCctEmoneySystem() != 0) &&
                  ((RcSysChk.rcChkJETBProcess()) ||
                      (RcSysChk.rcChkINFOXProcess())) &&
                  ((koptTranBuff.crdtTyp == 5) ||
                      (koptTranBuff.crdtTyp == 9))))) {
        mem.tTtllog.calcData.mtriningCrdtCnt = plCCnt;
      } else if ((RcSysChk.rcTROpeModeChk()) &&
          (koptTranBuff.crdtTyp == 8) &&
          (await CmCksys.cmNttaspSystem() == 0) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
        mem.tTtllog.calcData.mtriningCrdtCnt = plCCnt;
      } else if ((RcSysChk.rcTROpeModeChk()) && (koptTranBuff.crdtTyp == 1)) {
        mem.tTtllog.calcData.mtriningCrdtCnt = plCCnt;
      } else if ((RcSysChk.rcVDOpeModeChk()) &&
          ((koptTranBuff.crdtTyp == 0) ||
              ((await CmCksys.cmIDSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 5)) ||
              ((RcSysChk.rcChkSmartplusSystem()) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmVisaTouchSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmQUICPaySystem() != 0) &&
                  (koptTranBuff.crdtTyp == 9)) ||
              ((await CmCksys.cmPiTaPaSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 10)) ||
              ((await CmCksys.cmGinCardSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 17)) ||
              ((await CmCksys.cmTuoSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 11)) ||
              ((await CmCksys.cmCctConnectSystem() != 0) &&
                  (await CmCksys.cmCctEmoneySystem() != 0) &&
                  ((RcSysChk.rcChkJETBProcess()) ||
                      (RcSysChk.rcChkINFOXProcess())) &&
                  ((koptTranBuff.crdtTyp == 5) ||
                      (koptTranBuff.crdtTyp == 9))))) {
        mem.tTtllog.calcData.mvoidCrdtCnt = plCCnt;
      } else if ((RcSysChk.rcVDOpeModeChk()) &&
          (koptTranBuff.crdtTyp == 8) &&
          (await CmCksys.cmNttaspSystem() == 0) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
        mem.tTtllog.calcData.mvoidCrdtCnt = plCCnt;
      } else if ((RcSysChk.rcVDOpeModeChk()) && (koptTranBuff.crdtTyp == 1)) {
        mem.tTtllog.calcData.mvoidDebitCnt = plCCnt;
      }
    }
  }

  /// plCAmt取得関数
  static Future<int?> getPlCAmt(KopttranBuff koptTranBuff) async {
    int? plCAmt;
    RegsMem mem = SystemFunc.readRegsMem();

    if ((RcSysChk.rcTROpeModeChk()) && (koptTranBuff.crdtTyp == 0)) {
      if ((RcSysChk.rcTROpeModeChk()) &&
          ((koptTranBuff.crdtTyp == 0) ||
              ((await CmCksys.cmIDSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 5)) ||
              ((RcSysChk.rcChkSmartplusSystem()) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmVisaTouchSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmQUICPaySystem() != 0) &&
                  (koptTranBuff.crdtTyp == 9)) ||
              ((await CmCksys.cmPiTaPaSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 10)) ||
              ((await CmCksys.cmGinCardSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 17)) ||
              ((await CmCksys.cmTuoSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 11)) ||
              ((await CmCksys.cmCctConnectSystem() != 0) &&
                  (await CmCksys.cmCctEmoneySystem() != 0) &&
                  ((RcSysChk.rcChkJETBProcess()) ||
                      (RcSysChk.rcChkINFOXProcess())) &&
                  ((koptTranBuff.crdtTyp == 5) ||
                      (koptTranBuff.crdtTyp == 9))))) {
        plCAmt = mem.tTtllog.calcData.mtriningCrdtAmt;
      } else if ((RcSysChk.rcTROpeModeChk()) &&
          (koptTranBuff.crdtTyp == 8) &&
          (await CmCksys.cmNttaspSystem() == 0) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
        plCAmt = mem.tTtllog.calcData.mtriningCrdtAmt;
      } else if ((RcSysChk.rcTROpeModeChk()) && (koptTranBuff.crdtTyp == 1)) {
        plCAmt = mem.tTtllog.calcData.mtriningCrdtAmt;
      } else if ((RcSysChk.rcVDOpeModeChk()) &&
          ((koptTranBuff.crdtTyp == 0) ||
              ((await CmCksys.cmIDSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 5)) ||
              ((RcSysChk.rcChkSmartplusSystem()) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmVisaTouchSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmQUICPaySystem() != 0) &&
                  (koptTranBuff.crdtTyp == 9)) ||
              ((await CmCksys.cmPiTaPaSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 10)) ||
              ((await CmCksys.cmGinCardSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 17)) ||
              ((await CmCksys.cmTuoSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 11)) ||
              ((await CmCksys.cmCctConnectSystem() != 0) &&
                  (await CmCksys.cmCctEmoneySystem() != 0) &&
                  ((RcSysChk.rcChkJETBProcess()) ||
                      (RcSysChk.rcChkINFOXProcess())) &&
                  ((koptTranBuff.crdtTyp == 5) ||
                      (koptTranBuff.crdtTyp == 9))))) {
        plCAmt = mem.tTtllog.calcData.mvoidDebitAmt;
      } else if ((RcSysChk.rcVDOpeModeChk()) &&
          (koptTranBuff.crdtTyp == 8) &&
          (await CmCksys.cmNttaspSystem() == 0) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
        plCAmt = mem.tTtllog.calcData.mvoidDebitAmt;
      } else if ((RcSysChk.rcVDOpeModeChk()) && (koptTranBuff.crdtTyp == 1)) {
        plCAmt = mem.tTtllog.calcData.mvoidDebitAmt;
      } else {
        plCAmt = null;
      }
    } else {
      plCAmt = null;
    }
    return plCAmt;
  }

  /// plCAmtセット関数
  static Future<void> setPlCAmt(int plCAmt, KopttranBuff koptTranBuff) async {
    RegsMem mem = SystemFunc.readRegsMem();

    if ((RcSysChk.rcTROpeModeChk()) && (koptTranBuff.crdtTyp == 0)) {
      if ((RcSysChk.rcTROpeModeChk()) &&
          ((koptTranBuff.crdtTyp == 0) ||
              ((await CmCksys.cmIDSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 5)) ||
              ((RcSysChk.rcChkSmartplusSystem()) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmVisaTouchSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmQUICPaySystem() != 0) &&
                  (koptTranBuff.crdtTyp == 9)) ||
              ((await CmCksys.cmPiTaPaSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 10)) ||
              ((await CmCksys.cmGinCardSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 17)) ||
              ((await CmCksys.cmTuoSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 11)) ||
              ((await CmCksys.cmCctConnectSystem() != 0) &&
                  (await CmCksys.cmCctEmoneySystem() != 0) &&
                  ((RcSysChk.rcChkJETBProcess()) ||
                      (RcSysChk.rcChkINFOXProcess())) &&
                  ((koptTranBuff.crdtTyp == 5) ||
                      (koptTranBuff.crdtTyp == 9))))) {
        mem.tTtllog.calcData.mtriningCrdtAmt = plCAmt;
      } else if ((RcSysChk.rcTROpeModeChk()) &&
          (koptTranBuff.crdtTyp == 8) &&
          (await CmCksys.cmNttaspSystem() == 0) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
        mem.tTtllog.calcData.mtriningCrdtAmt = plCAmt;
      } else if ((RcSysChk.rcTROpeModeChk()) && (koptTranBuff.crdtTyp == 1)) {
        mem.tTtllog.calcData.mtriningCrdtAmt = plCAmt;
      } else if ((RcSysChk.rcVDOpeModeChk()) &&
          ((koptTranBuff.crdtTyp == 0) ||
              ((await CmCksys.cmIDSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 5)) ||
              ((RcSysChk.rcChkSmartplusSystem()) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmVisaTouchSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 4)) ||
              ((await CmCksys.cmQUICPaySystem() != 0) &&
                  (koptTranBuff.crdtTyp == 9)) ||
              ((await CmCksys.cmPiTaPaSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 10)) ||
              ((await CmCksys.cmGinCardSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 17)) ||
              ((await CmCksys.cmTuoSystem() != 0) &&
                  (koptTranBuff.crdtTyp == 11)) ||
              ((await CmCksys.cmCctConnectSystem() != 0) &&
                  (await CmCksys.cmCctEmoneySystem() != 0) &&
                  ((RcSysChk.rcChkJETBProcess()) ||
                      (RcSysChk.rcChkINFOXProcess())) &&
                  ((koptTranBuff.crdtTyp == 5) ||
                      (koptTranBuff.crdtTyp == 9))))) {
        mem.tTtllog.calcData.mvoidCrdtAmt = plCAmt;
      } else if ((RcSysChk.rcVDOpeModeChk()) &&
          (koptTranBuff.crdtTyp == 8) &&
          (await CmCksys.cmNttaspSystem() == 0) &&
          (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT)) {
        mem.tTtllog.calcData.mvoidCrdtAmt = plCAmt;
      } else if ((RcSysChk.rcVDOpeModeChk()) && (koptTranBuff.crdtTyp == 1)) {
        mem.tTtllog.calcData.mvoidDebitAmt = plCAmt;
      }
    }
  }

  /// 関連tprxソース: rc_atct.c - rc_SPTendInp_Clr
  static void rcSPTendInpClr() {
    // #if 0	/* V14->V15 */
    // MEM->tTtllog.t100100Sts[0].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[1].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[2].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[3].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[4].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[5].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[6].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[7].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[8].sptend_input_data  = 0;
    // MEM->tTtllog.t100100Sts[9].sptend_input_data = 0;
    // #else
    RegsMem mem = SystemFunc.readRegsMem();

    for (int i = 0; i < CntList.sptendMax; i++) {
      mem.tTtllog.t100100Sts[i].sptendInputData = 0;
    }
    // #endif /* 0 */	/* V14->V15 */
  }

  /// 関連tprxソース: rc_atct.c - rcErr_MaxChgAmt
  static Future<TendType> rcErrMaxChgAmt() async {
    AcMem cMem = SystemFunc.readAcMem();

    cMem.ent.errNo = DlgConfirmMsgKind.MSG_MAX_CHANGEAMT_OVER.dlgId;
    await RcExt.rcErr("rcErrMaxChgAmt", cMem.ent.errNo);
    return TendType.TEND_TYPE_ERROR;
  }

  /// 関連tprxソース: rc_atct.c - rcVmc_Chgamt_calc
  static void rcVmcChgamtCalc() {
    int lChg = 0;
    int lVchg = 0;
    KopttranBuff kopttran = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();
    RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttran);

    // 以降の処理については、
    // 既存処理より、ビスマック関連の処理は削除という指示があり、
    // 処理部分が#if 0で囲まれているため割愛する。
  }

  /// 関連tprxソース: rc_atct.c - rcATCT_MakeCash_PostReg
  static Future<void> rcATCTMakeCashPostReg(
      KopttranBuff kopttran, int priceData, int fncCode) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcATCTMakeCashPostReg() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    if (CompileFlag.CATALINA_SYSTEM) {
      if ((!await RcFncChk.rcCheckESVoidIMode()) &&
          (RcCatalina.cmCatalinaSystem(0)) &&
          ((mem.tmpbuf.catalinaTtlamt != 0) ||
              (mem.tmpbuf.catalinaTtlqty != 0)) &&
          (mem.tTtllog.t100001Sts.sptendCnt == 0)) {
        return;
      }
    }
    if (CompileFlag.RESERV_SYSTEM) {
      if (((await CmCksys.cmReservSystem() != 0) ||
              (await CmCksys.cmNetDoAreservSystem() != 0)) &&
          (RcReserv.rcReservReceiptCall()) &&
          (await RcReserv.rcreservReceiptAdvance() != 0) &&
          (mem.tTtllog.t100001Sts.sptendCnt == 0)) {
        return;
      }
    }
    if ((!await RcFncChk.rcCheckESVoidIMode()) &&
        ((mem.tmpbuf.notepluTtlamt != 0) ||
            (mem.tmpbuf.notepluTtlqty != 0)) &&
        (mem.tTtllog.t100001Sts.sptendCnt == autoSptendCnt)) {
      return;
    }

    if (cBuf.dbTrm.exceptOthcashRecalc != 0) {
      if (RcSysChk.rcChkKYCHA(fncCode)) {
        if (((RcSysChk.rcChkKYCHA(fncCode)) && (kopttran.crdtEnbleFlg == 1)) ||
            (kopttran.tranUpdateFlg != 1)) {
          cMem.postReg.sub_ttl -= priceData;
        }
      }
    }
  }

  /// 特典利用時の税案分額情報セット
  /// 関連tprxソース: rc_atct.c - rc_sm5_Set_privilege
  static void rcSm5SetPrivilege(int spCnt, int amt, int setFlg) {
    if (RcSysChk.rcsyschkSm5ItokuSystem() != 0) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      // 対象行は13926-14459行
    }
    return;
  }

  /// ReCalc時にエラーが出てもスキップするためのもの
  /// 関連tprxソース: rc_atct.c - rcATCTProcCheckPassSet
  static void rcATCTProcCheckPassSet(int flg) {
    atctCheckPassFlag = flg;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcAmt_Ky_Cd_Make_TtlLog
  static void rcAmtKyCdMakeTtlLog() {
    int loop = 0;
    RegsMem mem = SystemFunc.readRegsMem();

    for (loop = 0; loop < AmtKind.amtMax.index; loop++) {
      mem.tTtllog.t100200[loop].kyCd = 0;
      if ((mem.tTtllog.t100200[loop].cnt != 0) ||
          (mem.tTtllog.t100200[loop].amt != 0) ||
          (mem.tTtllog.t100200[loop].drwAmt != 0) ||
          (mem.tTtllog.t100200[loop].residualAmt != 0)) {
        mem.tTtllog.t100200[loop].kyCd =
            CntList.tAmtKindList[loop].keyCd;
        rcATCTMakeExpSettleNo(
            CntList.tAmtKindList[loop].keyCd); // 決済種番号のセット
      } else {
        mem.tTtllog.t100200[loop] = T100200();
      }
    }
    mem.tTtllog.t100001Sts.amtCnt = AmtKind.amtMax.index;
  }

  /// 関連tprxソース:C rcinoutdsp.c - rcATCT_Make_ExpSettleNo
  static void rcATCTMakeExpSettleNo(int fncCd) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    int typ = RxLogCalc.rcCheckFuncAmtTyp(fncCd);

    if (mem.tTtllog.t100200[typ].expSettleNo == 0) {
      if (fncCd == FuncKey.KY_CASH.keyId) {
        mem.tTtllog.t100200[typ].expSettleNo =
            pCom.dbKfnc[fncCd].opt.cash.expSettleNo;
        mem.tTtllog.t100200[typ].expChgamtSettleNo =
            pCom.dbKfnc[fncCd].opt.cash.expChgamtSettleNo;
        mem.tTtllog.t100200[typ].expSettleTyp =
            pCom.dbKfnc[fncCd].opt.cash.expSettleTyp;
        mem.tTtllog.t100200[typ].expChgamtSettleTyp =
            pCom.dbKfnc[fncCd].opt.cash.expChgamtSettleTyp;
      } else if (RcSysChk.rcChkKYCHA(fncCd)) {
        mem.tTtllog.t100200[typ].expSettleNo =
            pCom.dbKfnc[fncCd].opt.cha.expSettleNo;
        mem.tTtllog.t100200[typ].expChgamtSettleNo =
            pCom.dbKfnc[fncCd].opt.cha.expChgamtSettleNo;
        mem.tTtllog.t100200[typ].expSettleTyp =
            pCom.dbKfnc[fncCd].opt.cha.expSettleTyp;
        mem.tTtllog.t100200[typ].expChgamtSettleTyp =
            pCom.dbKfnc[fncCd].opt.cha.expChgamtSettleTyp;
      }
    }
  }

  /// 関連tprxソース: rc_atct.c - mcATCT_Make_ActualLog
  static void mcATCTMakeActualLog(TendType? eTendType) {
    ///TODO:00014 日向 現計対応のため定義のみ先行追加
    return;
  }
  /// 関連tprxソース: rc_atct.c - rcChk_DrwOpen_Department
  static bool rcChkDrwOpenDepartment(KopttranBuff kopttran) {
    ///TODO:00014 日向 現計対応のため定義のみ先行追加
    return false;
  }
  /// 関連tprxソース: rc_atct.c - rcATCT_Display
  static void rcATCTDisplay(TendType? eTendType) {
    ///TODO:00014 日向 現計対応のため定義のみ先行追加
    return;
  }

  /// 関連tprxソース: rc_atct.c - rcChk_SptendAllcha1key
  static bool rcChkSptendAllcha1key() {
    bool cha1keyflg = true;
    RegsMem mem = SystemFunc.readRegsMem();

    if (mem.tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt].sptendCd !=
        FuncKey.KY_CHA1.keyId) {
      cha1keyflg = false;
    }

    return cha1keyflg;
  }

  /// 関連tprxソース: rc_atct.c - rcATCT_drwopenchk
  static Future<bool> rcATCTDrwopenchk() async {
    KopttranBuff kopttran = KopttranBuff();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcATCTDrwopenchk() rxMemRead error\n");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (CompileFlag.ARCS_MBR) {
      if (await CmMbrSys.cmNewARCSSystem() != 0 &&
          mem.tTtllog.t100001Sts.sptendCnt == 0 &&
          RcSysChk.rcChkKYCHA(mem.tTtllog
              .t100100[mem.tTtllog.t100001Sts.sptendCnt]
              .sptendCd)) {
        await RcFlrda.rcReadKopttran(
            mem.tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt].sptendCd,
            kopttran);
        if (kopttran.crdtEnbleFlg == 1) {
          if ((cBuf.dbTrm.printStoreNoteGlorymulti != 0) &&
              (kopttran.crdtTyp == 19 || kopttran.crdtTyp == 20)) {
            return false;
          } else if (kopttran.crdtTyp == 6) {
            return false;
          } else if (kopttran.crdtTyp == 31) {
            return false;
          } else if (kopttran.crdtTyp == 37) {
            return false;
          } else if (kopttran.crdtTyp == 0 &&
              await RcCrdtFnc.rcSignChkEveryOneSystem(
                  mem.tTtllog.t100100[mem.tTtllog.t100001Sts.sptendCnt]
                      .sptendData,
                  10,
                  0)) {
            return false;
          }
        }
      }
    }
    return true;
  }

  // TODO:00002 佐野 checker関数構築のため、定義のみ
  /// 関連tprxソース: rc_atct.c - rc_NotePlu_SPTend_Set
  static void rcNotePluSPTendSet(int ttlamt, int qty) {}

  // TODO:00002 佐野 checker関数構築のため、定義のみ
  /// 関連tprxソース: rc_atct.c - rc_Catalina_SPTend_Set
  static void rcCatalinaSPTendSet(int ttlamt, int qty) {}
}

///関連tprxソース: rc_atct.h - TEND_TYPE
enum TendType {
  /* tendering type */
  TEND_TYPE_ERROR(-1),
  TEND_TYPE_NO_ENTRY_DATA(0),
  TEND_TYPE_TEND_AMOUNT(1),
  TEND_TYPE_SPRIT_TEND(2),
  TEND_TYPE_POST_TEND_START(3),
  TEND_TYPE_POST_TEND_END(4),
  TEND_TYPE_SPOOL_IN(5),
  TEND_TYPE_RPR(6),
  TEND_TYPE_RFM(7),
  TEND_TYPE_CPL(8),
  TEND_TYPE_CALC_TEND_START(9),
  TEND_TYPE_CALC_TEND_END(10);

  final int value;

  const TendType(this.value);
}
