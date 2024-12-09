/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcmg_dsp.dart';

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/rc_suica.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_lib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../tprlib/TprLibHdd.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_edy.dart';
import 'rc_ext.dart';
import 'rc_ifevent.dart';
import 'rc_itm_dsp.dart';
import 'rc_mbr_com.dart';
import 'rc_obr.dart';
import 'rc_point_infinity.dart';
import 'rc_qrinf.dart';
import 'rc_set.dart';
import 'rc_stl_dsp.dart';
import 'rc_suica_com.dart';
import 'rccrdtdsp.dart';
import 'rcdepoinplu.dart';
import 'rcfncchk.dart';
import 'rcid_com.dart';
import 'rcky_cha.dart';
import 'rcky_plu.dart';
import 'rckyclscncl.dart';
import 'rckytcoupon.dart';
import 'rcquicpay_com.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'rcut_com.dart';

///  関連tprxソース: rcky_clr.c
class RckyClr {

  ///  関連tprxソース: rcqc_dsp.c - qc_clear_status
  int qcClearStatus = 0;
  ///  関連tprxソース: rcqr_com.c.c - qr_txt_status
  static QrTxtStatus qrTxtStatus = QrTxtStatus.QR_TXT_STATUS_INIT;

  ///  関連tprxソース: tprx\src\regs\checker\Regs.c
  static SubttlInfo subttl = SubttlInfo();
  static SubttlInfo dualSubttl = SubttlInfo();

  ///  関連tprxソース: rcky_clr.c - rcKyClr
  static Future<void> rcKyClr() async {
    int ret;
    int flg;
    int edyErrFlg = 0;
    int suicaTimeFlg;
    int qcModeChk = 0;
    String log = "";

    const String callFunction = "rcKyClr";
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcKyClr() rxMemRead error\n");
      return ;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 行番号：509-523

    if((cMem.ent.errNo != DlgConfirmMsgKind.MSG_CASTDAT.dlgId)
        && (atSing.startDspFlg == 0)
        && (!(cMem.stat.s2prRjpSts != 0))){
      flg = 0;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // 行番号：531-635

    // TODO:00012 平野 UI系処理。バックエンドとして実装必要か要確認
    //  // 決済完了後、クリアキーで登録画面に戻るようにする
    // rcReturnDsp_Stl_To_Regs();
    //
    // rcClearPopDisplay();
    // rcClear_halfwindow();

    // TODO:10121 QUICPay、iD 202404実装対象外
    // #if COLORFIP
    // ColorFipPopdown();
    // #endif
    // rcReset_KyStatus();
    // rcChk_Komeri_TranMode();
    // rcChk_InOutMode();
    // rcChk_TcktIssuMode();
    // rcChk_MbrTelMode();
    // rcChk_TcouponMode ();
    // if (cm_prod_itf14_barcode_system())
    //   rcChk_ProdBarMode();
    // rcClear_Dual_RegChk_Flg();
    // #if TW
    // rcChk_CompcdMode();
    // #endif
    // rcChk_CalcTendMode();
    // rcClear_Segment();
    // rcClear_Buffer();
    // rcChk_SPVTMode();
    await rcChkMultiQPMode();
    await rcChkMultiiDMode();
    // TODO:10121 QUICPay、iD 202404実装対象外
    // rcChk_MultiPiTaPaMode();
    // rcChk_MultiSuicaMode();
    // rcProcEntryCrdtErr();
    // rcProcEntryPrecaErr();
    // rcChk_SuicaMode();
    // rcChk_CashBack_PointEntry_Mode();
    // TODO:00012 平野 UI系処理。rcClear_Displayの実装要否を確認したい。
    if(CompileFlag.SAPPORO){
      // if ((! rcmbrTelListClrKeyFnc()) && (! rcCheck_Sapporo_Pana_Mode()))
      //   rcClear_Display();
    }else{
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if (! rcmbrTelListClrKeyFnc())
      // rcClear_Display();
    }
    // rcClear_SptendInfo();

    if(await RcSysChk.rcSGChkSelfGateSystem()){
      // TODO:10121 QUICPay、iD 202404実装対象外
      // 対象行：703-813
    }else{
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if(RcFncChk.rcQCCheckCrdtMode()){
      //   rcSGChk_CreditMode();
      // }else{
      //   rcChk_CreditMode();
      // }
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // rcChk_EdyMode();

    if(!((await RcSysChk.rcChkMultiSuicaSystem() != 0)
        && (await RcFncChk.rcCheckSuicaMode())
        && (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_RETRY1.value))){
      // TODO:10121 QUICPay、iD 202404実装対象外
//       if (rcChk_Desktop_Cashier())
//       {
//         if (CMEM->ent.err_no == MSG_CAUTION_CUSTOMER_USE_NOW)
//         { // 「前客の精算が終了するまで・・・」メッセージを、クリアキーで消された場合に、タイマーを止めたい為
// //			if(TS_BUF->cash.rwcrky_flg == 1)
// //			{ // リライト読込キー押下フラグのクリア
// //				TS_BUF->cash.rwcrky_flg = 0;
// //			}
//           rcSpoolIn_Clear_Conf();
//         }
//       }
      await RcExt.rcClearErrStat(callFunction);
    }
    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(edy_err_flg == 1) {
    //   edy_err_flg = 0;
    //   rcEdyDsp_After_SetErr();
    //   return;
    // }
    // ret = rcChk_DocMem_Check(0);
    if(CompileFlag.SELF_GATE){
      // TODO:10121 QUICPay、iD 202404実装対象外
      // if ((ret) && (rcSG_Chk_SelfGate_System()))
      // {
      //   if (!(rcCheck_TrDate_Mode()))
      //   {
      //     rcSG_SignP_SignBlink(RED_COLOR);
      //   }
      // }
      // rcSG_ClearMem();
    }
    if(CompileFlag.DISC_BARCODE || CompileFlag.BOOK_BARCODE || CompileFlag.CLOTHES_BARCODE){
      rcClearIntBookFlag();
    }
    // TODO:10121 QUICPay、iD 202404実装対象外
    // <2004.07.08> mn
    // #if CN_NSC
    // rcChk_NscMode();
    // #endif
    // #if SAPPORO
    // rcSapporo_Pana_Disp_End();
    // #endif
    if(CompileFlag.REWRITE_CARD){
      // TODO:10121 QUICPay、iD 202404実装対象外
      // rcMcp200_Disp_End();
      // if((rcChk_Ht2980_System()) && (rcCheck_Ht2980_Mode())){
      //   rcHt2980_Clr_Proc();
      //   rcHt2980_Disp_End();
      // }
    }
    // TODO:10121 QUICPay、iD 202404実装対象外
    // rcAbs_V31_Disp_End();
    // TODO:10121 QUICPay、iD 202404実装対象外
//     #if STATION_PRINTER
// //     if((rcKy_Self() != KY_CHECKER) &&  ( TS_BUF->stpr.PrnFlg == 1 ) && ( TS_BUF->stpr.ErrCode >= 1 ) && ( C_BUF->db_trm.rcpt_bar_prn0 == 1 ))
//     if(((rcKy_Self() != KY_CHECKER) || (rcCheck_QCJC_System())) &&  ( TS_BUF->stpr.PrnFlg == 1 ) && ( TS_BUF->stpr.ErrCode >= 1 ) && ( C_BUF->db_trm.rcpt_bar_prn0 == 1 ))
//     {
//     rc_stprErr( );
//     }
// //     #endif
//     rcMark_KyDisplay(1);
    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行：891-938
    // rc_Assort_PrcChg_flgClr();
    // TODO:10121 QUICPay、iD 202404実装対象外
    // 対象行：940-1017
  }

  ///  関連tprxソース: rcky_clr.c - rcClear_PopDisplay
  // TODO:00008 宮家 中身の実装予定　
  static void rcClearPopDisplay() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
  }

  ///  関連tprxソース: rcky_clr.c - rcReset_KyStatus
  static Future<void> rcResetKyStatus() async {
    AcMem cMem = SystemFunc.readAcMem();

    RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
    if (RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
      RcRegs.kyStS1(cMem.keyStat, FuncKey.KY_CLR.keyId); /* Set Clear Key */
    }
    if ((RcSysChk.rcCheckTECOperation() != 0) ||
        (await RcFncChk.rcCheckPriceMagazine()) ||
        (await RcmgDsp.rcChkMgNonPluDsp(0) != 0)) {
      RcRegs.kyStR1(cMem.keyStat, FuncKey.KY_MG.keyId); /* Reset MG Key */
      RcRegs.kyStR1(cMem.keyStat, FuncKey.KY_MDL.keyId); /* Reset MDL Key */
      RcRegs.kyStR1(cMem.keyStat, FuncKey.KY_LRG.keyId); /* Reset LRG Key */
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_VOID.keyId); /* Reset Void Key */
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_PCHG.keyId); /* Reset Price Change Key */
      if (RcSysChk.rcsyschkAyahaSystem()) {
        // Reset 特価品（売価変更とほぼ同一)
        RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_SPECIAL_PRICE.keyId);
      }
    }
    // #if OPELVL_CNCL
    // cMem.stat.opelvl_flg = 0;
    // #endif
  }

  ///  関連tprxソース: rcky_clr.c - rcChk_MultiQPMode()
  static Future<void> rcChkMultiQPMode() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    if((await RcSysChk.rcChkMultiQPSystem() != 0) && (await RcFncChk.rcCheckQPMode())){
      if((await CmCksys.cmUt1QUICPaySystem() != 0) && (atSing.utAlermFlg == 1)){
        await RcutCom.rcUTAlarmAlarmPrint();
      }else if((await CmCksys.cmMultiVegaSystem() != 0) && (atSing.utAlermFlg == 1)){
        await RcutCom.rcUTAlarmAlarmPrint();
      }else{
        atSing.spvtData = SpvtData();
        atSing.spvtData.fncCode = cMem.stat.fncCode;
        RcQuicPayCom.rcMultiQPEndProc();
      }
    }
  }

  ///  関連tprxソース: rcky_clr.c - rcChk_MultiDPMode()
  static Future<void> rcChkMultiiDMode() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    if((await RcSysChk.rcChkMultiiDSystem() != 0) && (await RcFncChk.rcCheckiDMode())){
      if((await CmCksys.cmUt1IDSystem() != 0) && (atSing.utAlermFlg == 1)){
        await RcutCom.rcUTAlarmAlarmPrint();
      }else if((await CmCksys.cmMultiVegaSystem() != 0) && (atSing.utAlermFlg == 1)){
        await RcutCom.rcUTAlarmAlarmPrint();
      }else{
        atSing.spvtData = SpvtData();
        atSing.spvtData.fncCode = cMem.stat.fncCode;
        RcidCom.rcMultiiDEndProc();
      }
    }
  }

  ///  関連tprxソース: rcky_clr.c - rcClear_intBook_flag
  static void rcClearIntBookFlag(){
  RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
  if (xRet.isInvalid()) {
  TprLog().logAdd(0, LogLevelDefine.error, "rcKyClr() rxMemRead error\n");
  return ;
  }
  RxTaskStatBuf tsBuf = xRet.object;

  tsBuf.chk.intBook_flag = 0;
  }

  /// クーポン情報を削除する
  /// 引数:ファンクションキーNo
  ///  関連tprxソース: rcky_clr.c - rcChk_WScoupon_BarInfo_Clear
  static Future<void> rcChkWScouponBarInfoClear(FuncKey fncCd) async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    switch (fncCd) {
      case FuncKey.KY_CLR:  // クリアキー
        cMem.wsCpnUse = WsCpnUse();
        break;
      case FuncKey.KY_MBRCLR:  // 会員取消
        // 加算ポイント、倍率ポイントクーポン情報を削除
        await RcPointInfinity.rcPointInfinityCpnInfoDelete(4, -1);
        await RcPointInfinity.rcPointInfinityCpnInfoDelete(5, -1);
        break;
      case FuncKey.KY_STLDSCCNCL:  // 小計値下取消
        // 値引、割引クーポン情報を削除
        await RcPointInfinity.rcPointInfinityCpnInfoDelete(2, -1);
        await RcPointInfinity.rcPointInfinityCpnInfoDelete(3, -1);
        break;
      case FuncKey.KY_CNCL:
        // 全てのクーポン情報を削除
        cMem.wsCpnUse = WsCpnUse();
        mem.prnrBuf.wsCpnUse = RxMemPrnWsCpnUse();
        break;
      default:
        break;
    }
  }

  ///  関連tprxソース: rcky_clr.c - rcChk_MultiDPMode()
  /// #if SELF_GATEで囲まれているため名前だけ実装
  static void rcSGChk_CreditMode() {}

  ///  関連tprxソース: rcky_clr.c - rcChk_CreditMode()
  static Future<void> rcChk_CreditMode() async {

    AcMem cMem = SystemFunc.readAcMem();
    if ((await CmCksys.cmCrdtSystem()) != 0) {
      if (RcFncChk.rcQCCheckStaffDspMode() || RcFncChk.rcQCCheckPassWardDspMode() || RcFncChk.rcQCCheckCallDspMode()) {
        return;
      }

      RcSet.rcClearCreditErrCode();
      if (Dummy.rcCheckSPVTMode() || Dummy.rcCheckSPVTVoidMode()) {
        return;
      }

    
      if ((RcFncChk.rcChkErr() != 0) && (cMem.stat.scrType == RcRegs.LCD_104Inch)) {
        RcCrdtDsp.rcCrdtGtkGrabAdd();
      }
      if ((cMem.working.crdtReg.stat & 0x4000) !=0 ) {
        /* 与信タイムアウト？   */
        if (cMem.working.crdtReg.step == KyCrdtInStep.INPUT_END.cd) {
          /* クレジット入力完了？ */
          if (((await CmCksys.cmNttaspSystem()) != 0) && ((cMem.working.crdtReg.stat & 0x0004) != 0)) {
            /* カウンタ判定:不一致？*/
            RcIfEvent.rxChkTimerRemove(); /* キー入力禁止         */
            cMem.stat.fncCode = cMem.working.crdtReg.crdtKey;
            RcSet.rcReMovScrMode();
            RcCrdtDsp.rcCrdtReDsp();
            await RckyCha.rcChargeAmount1();
          }
        }
        return;
      }
    }
  }

  ///  関連tprxソース: rcky_clr.c - rcChk_DocMem_Check()
  Future<int> rcChkDocMemCheck(bool autoFlg) async {

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    RxTaskStatBuf tsBuf = xRet.object;
    int result = 0;

    if (await RcSysChk.rcChkDesktopCashier()) {
      return rckyClrChkDocmem(autoFlg);
    }

    if (cMem.ent.docMemStat == '1') {
      cMem.ent.docMemStat = '2';
      result = TprLib.tprLibMemCheck(Tpraid.TPRAID_CHK);
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '2') {
      cMem.ent.docMemStat = '3';
      result = RcEdy.rcEdySetDateTimeTestFlag();
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '3') {
      cMem.ent.docMemStat = '4';
      result = RcSysChk.rcHistErrCheck();
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '4') {
      cMem.ent.docMemStat = '5';
      result = TprLibHdd.tprLibHddCheck(Tpraid.TPRAID_CHK);
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '5') {
      cMem.ent.docMemStat = '6';
      result = Dummy.rcSuicaIcChk();
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '6') {
      cMem.ent.docMemStat = '7';
      result = Dummy.tprLibUpsCheck(Tpraid.TPRAID_CHK);
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '7') {
      cMem.ent.docMemStat = '8';
      result = Dummy.tprLibSSDDiskSizeCheck(Tpraid.TPRAID_CHK);
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '8') {
      cMem.ent.docMemStat = '9';
      result = Dummy.tprLibSSDCheck(Tpraid.TPRAID_CHK);
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '9') {
      cMem.ent.docMemStat = '10';
      result = Dummy.tprLibUsbcamExist(Tpraid.TPRAID_CHK, 1);
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }
    if (cMem.ent.docMemStat == '10') {
      cMem.ent.docMemStat = '11';
      result = Dummy.rcAcrAcbRegStartProc();
      if (result != 0) {
        await RcSet.rcErrStatSet2("rcChkDocMemCheck");
        return result;
      }
    }

    if (result == 0) {
      // RegStart時のステップの処理(docMemStat)が完了したのでフラグクリア
      if ((await RcSysChk.rcKySelf()) != RcRegs.KY_CHECKER) {
        Dummy.rcRegStartCashierFlagClr("rcChkDocMemCheck");
      }
    }

    if (result == 0) {
      cMem.ent.docMemStat = '0';
      if (tsBuf.chk.errstat_flag == 1) {
        result = Dummy.rcQCJC1ClkCheck();
      }
      if (result != 0) {
        return result;
      }
    }

    if (result == 0) {
      if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
        if (tsBuf.chk.errstat_flag == 1) {
          Dummy.rcSGAfterErrorProc();
        }
      }
    }

    if (result == 0) {
      if (Dummy.rcCheckEvoidDirectCall()) {
        cMem.ent.docMemStat = '0';
        if (tsBuf.chk.errstat_flag == 1) {
          tsBuf.chk.errstat_flag = 0;
          Dummy.rcCallFuncKey();
        }
      } else {
        cMem.ent.docMemStat = '0';
        tsBuf.chk.errstat_flag = 0;
      }
    }

    if (autoFlg) {
      if (result == 0) {
        if ((await RcSysChk.rcQCChkQcashierSystem()) &&
            RcFncChk.rcQCCheckStartDspMode() &&
            qcClearStatus == 0 &&
            qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_READ) {
          Dummy.rcQCMovieStart();
          RcObr.rcScanEnable();
          Dummy.rcQCSignPCtrlProc();
          Dummy.rcQCChkChangeStock();
        }
      }

      Dummy.rcAutoChkAfterDocMemChk(result);
      await RcKyPlu.rcAnyTimeCinStartProc(); // 常時入金
    }

    return result;
  }

  ///  関連tprxソース: rcky_clr.c - rcChk_Komeri_TranMode
  static Future<void> rcChkKomeriTranMode() async {
    if (await CmCksys.cmHc1KomeriSystem()!= 0) {
      if (RcFncChk.rcChkErr() != 0) {
        AcMem cMem = SystemFunc.readAcMem();
        if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHA3.keyId])) RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHA3.keyId);
        if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHK2.keyId])) RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHK2.keyId);
        if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHK1.keyId])) RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CHK1.keyId);
      }
    }
  }

  ///  関連tprxソース: rcky_clr.c - rcChk_InOutMode
  static void rcChkInOutMode() {
    if (Dummy.rcCheckInOutKey()){
        AcMem cMem = SystemFunc.readAcMem();
      RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId);
      }
  }

  ///  関連tprxソース: rcky_clr.c -rcChk_TcktIssuMode
  static void rcChkTcktIssuMode() {
    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_TCKTISSU.keyId]) != 0) {
      RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId);
    }
  }

  /// 関連tprxソース: rcky_clr.c -rcChk_MbrTelMode
  static Future <void> rcChkMbrTelMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    if ((await RcMbrCom.rcmbrChkStat() != 0) && RcSysChk.rcCheckMbrTelMode()) {
      if (RcFncChk.rcChkTenOn() || RcFncChk.rcChkErr() != 0 || Dummy.rcmbrGetTelLstScrn()) {
        RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId);
        if (Dummy.rcCheckOffMode()) {
          if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_MBR.keyId])) RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_MBR.keyId); /* Reset MBR_TEL Refer Mode */
          if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId])) RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_TEL.keyId); /* Reset TEL Refer Mode */
        }
      } else {
        if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_MBR.keyId])) RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_MBR.keyId); /* Reset MBR_TEL Refer Mode */
        if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_TEL.keyId])) RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_TEL.keyId); /* Reset TEL Refer Mode */
      }
    }
  }

  ///  関連tprxソース: rcky_clr.c rcChk_TcouponMode
  static void rcChkTcouponMode() {
    AcMem cMem = SystemFunc.readAcMem();
    if (RcKyTcoupon.rcCheckTcouponMode()) {
      if (!(RcFncChk.rcChkTenOn() || RcFncChk.rcChkErr() != 0)) {
        RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_TPOINT_CPN.keyId);
      }
    }
    return;
  }

  ///  関連tprxソース: rcky_clr.c rcChk_ProdBarMode
  static void rcChkProdBarMode() {
    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_BARIN.keyId])) {
      RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_BARIN.keyId);
    }
  }

  ///  関連tprxソース: rcky_clr.c rcChk_CalcTendMode
  static Future <void> rcChkCalcTendMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (((RcFncChk.rcChkErrNon() != 0) && (!RcFncChk.rcChkTenOn()) &&
            (RcSysChk.rcCheckCalcTend()) && (Dummy.rcChkPostReg())) ||
        ((RcFncChk.rcChkErrNon() != 0) && (RcSysChk.rcCheckCalcTend()) && (Dummy.rcChkPostReg()) &&
            (Dummy.rcCheckOffMode()) && (Dummy.offModeChkChecker() == false))) {
      await RcSet.cashStatReset2("rcChkCalcTendMode");
      Dummy.cmMov(cMem.postReg, cMem.postRegsv);
      RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_CALC.keyId);
      RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0 + RcRegs.MACRO1 + RcRegs.MACRO2 + RcRegs.MACRO3);
      RcRegs.kyStS3(cMem.keyStat, FncCode.KY_FNAL.keyId);
      RcStlDsp.rcStlReTtlLcd(0);
      Dummy.rcStlDspPost(PostCtrl.PT_TOTAL);
    }
  }

  ///  関連tprxソース: rcky_clr.c rcChk_SPVTMode
  static Future <void> rcChkSPVTMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    if (await RcSysChk.rcChkSPVTSystem() && Dummy.rcCheckCrdtMode()) {
      if(cMem.working.crdtReg.multiFlg.startsWith('ox')){
        if (int.parse(cMem.working.crdtReg.multiFlg, radix: 16) & 0x80 != 0) {
          if ((cMem.working.crdtReg.cardcrewErr[0] == 'S') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'N') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'C') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'P') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'E') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'K') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'G')) {
            if (cMem.working.crdtReg.cardcrewErr.substring(0, 3) == 'G30') {
              Dummy.rcSPVTApproveDsp();}
            else {
              Dummy.rcSPVTAuthoriEnd(Typ.NG);}
        } else {
          Dummy.rcSPVTAuthoriEnd(Typ.BUZ);}
      } else {
        atSing.spvtData.fncCode = cMem.stat.fncCode;
        Dummy.rcSPVTEndProc();
      }
        }
        else{        
        if (int.parse(cMem.working.crdtReg.multiFlg, radix: 10) & 0x80 != 0) {
          if ((cMem.working.crdtReg.cardcrewErr[0] == 'S') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'N') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'C') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'P') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'E') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'K') ||
              (cMem.working.crdtReg.cardcrewErr[0] == 'G')) {
            if (cMem.working.crdtReg.cardcrewErr.substring(0, 3) == 'G30') {
              Dummy.rcSPVTApproveDsp();}
            else {
              Dummy.rcSPVTAuthoriEnd(Typ.NG);}
        } else {
          Dummy.rcSPVTAuthoriEnd(Typ.BUZ);}
      } else {
        atSing.spvtData.fncCode = cMem.stat.fncCode;
        Dummy.rcSPVTEndProc();
      }
        }
    }
  }

  ///  関連tprxソース: rcky_clr.c rcChk_MultiPiTaPaMode
  static Future <void> rcChkMultiPiTaPaMode() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    if (await RcSysChk.rcChkMultiPiTaPaSystem() != 0 && await RcFncChk.rcCheckPiTaPaMode()) {
      atSing.spvtData = SpvtData();
      atSing.spvtData.fncCode = cMem.stat.fncCode;
      Dummy.rcMultiPiTaPaEndProc();
    }
  }

  /// 関連tprxソース: rcky_clr.c rcChk_MultiSuicaMode
  static Future <void> rcChkMultiSuicaMode() async {
    int fncCd;
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcKyClr() rxMemRead error\n");
      return ;
    }
      RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcChkMultiSuicaSystem() != 0 && await RcFncChk.rcCheckSuicaMode() && tsBuf.multi.step != FclStepNo.FCL_STEP_TRAN_RETRY1.value) {
      fncCd = atSing.spvtData.fncCode;
      atSing.spvtData = SpvtData();
      if (tsBuf.multi.fclData.skind == FclService.FCL_NIMOCA) {
        atSing.spvtData.fncCode = fncCd;
        Dummy.rcMultiNimocaReadEnd();
      } else {
        atSing.spvtData.fncCode = cMem.stat.fncCode;
        Dummy.rcMultiSuicaEndProc();
      }

      if (await RcSysChk.rcSysChkHappySmile()) {
        await Rc28StlInfo.rcFselfSubttlRedisp();
      }
    }
  }

  /// 関連tprxソース: rcky_clr.c rcChk_SuicaMode
  static Future <void> rcChkSuicaMode() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = RegsMem();
    if ((await RcSysChk.rcChkSuicaSystem()) && atSing.suicaData.page == SuicaPage.SUICA_RETCH.id && mem.tmpbuf.multiTimeout != 0) {
      RcSet.rcClearEntry();
      RcItmDsp.rcEntryOutPut();
      RcRegs.kyStR0(cMem.keyStat, FncCode.KY_ENT.keyId);
      await RcExt.rcClearErrStat("rcChkSuicaMode");
      await RcExt.rxChkModeSet("rcChkSuicaMode");
    }
  }

  ///  関連tprxソース: rcClear_SptendInfo
  static Future <void> rcClearSptendInfo() async {
    AcMem cMem = SystemFunc.readAcMem();
    if ((await RcSysChk.rcChkSptendInfo()) && await RcFncChk.rcCheckStlMode()) {
      if (!RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {   /* sprit tendering */
        Dummy.rcSptendInfoQuit(subttl);
        if (FbInit.subinitMainSingleSpecialChk() == true)
          Dummy.rcSptendInfoQuit(dualSubttl);
      }
    }
  }

  ///  関連tprxソース: rcChk_EdyMode
  static Future <void> rcChkEdyMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        TprLog().logAdd(0, LogLevelDefine.error, "rcKyClr() rxMemRead error\n");
        return ;
      }
      RxTaskStatBuf tsBuf = xRet.object;
    if ((await RcSysChk.rcChkEdySystem()) && (await RcFncChk.rcCheckEdyMode())) {
      if ((tsBuf.jpo.ctr & EDY_DEV_ERROR) != 0) {
        Dummy.rcEdyKyBreak();
      }
    } else if ((RcSysChk.rcChkMultiEdySystem() != 0) && (await RcFncChk.rcCheckEdyMode())) {
      atSing.spvtData = SpvtData();
      atSing.spvtData.fncCode = cMem.stat.fncCode;
      Dummy.rcMultiEdyEndProc();
    }
  }

  // TODO:定義のみ追加
  ///  関連tprxソース: rccrdtdsp.c - rcky_clr_chk_docmem
  static int rckyClrChkDocmem(bool autoFlg) {
    return Typ.OK;
  }

  /// 表示画面を消去する
  ///  関連tprxソース: rcky_clr.c - rcClear_Display
  static void rcClearDisplay() {
    // TODO:10122 グラフィックス処理
  }

  /// バッファ変数をクリアする
  ///  関連tprxソース: rcky_clr.c - rcClear_Buffer
  static Future<void> rcClearBuffer() async {
    if (!( (await RcSysChk.rcSGChkSelfGateSystem())
        && (RcFncChk.rcNewSGCheckEdyBalMode() ||
            RcFncChk.rcNewSGCheckEdyAllMode()) )) {
      RcSet.rcClearEntry();
    }
    if ((await RcSysChk.rcChkZHQsystem())
        && (await RcSysChk.rcChkShopAndGoSystem())
        && (RcFncChk.rcChkErr() != 0)
        && (await RcFncChk.rcCheckRegAssistPChgMode())) {
      // クリアしたくない
      return;
    }
    await RcSet.rcClearMul();
    await RcSet.rcClearDataReg();
    RcSet.rcClearPluReg();
    if (CompileFlag.FRESH_BARCODE) {
      RcSet.rcClearFreshBar();
    }
    if (CompileFlag.DISC_BARCODE) {
      RcSet.rcClearDscBar();
    }
    if (CompileFlag.BOOK_BARCODE) {
      RcSet.rcClearBookBar();
    }
    if (CompileFlag.CLOTHES_BARCODE) {
      RcSet.rcClearClothesBar();
    }
    if (CompileFlag.DEPARTMENT_STORE) {
      // TODO:10155 顧客情報（仕向け対象外）
      /*
      rcClear_PriceTagBar();
      rcClear_GiftBar();
      rcClear_DeptFreshBar();
       */
    }
    RcSet.rcClearMagazineBar();
    RcSet.rcClearItfBar();
    if (CompileFlag.SALELMT_BAR) {
      RcSet.rcClearSalLmtBar() ;
    }
    RcSet.rcClearGs1Bar();
    await RcSet.rcClearCardForgetBar();
    await RcSet.rcClearBenefitBar();
    RcSet.rcClearRedPriceTagBar();
    RcSet.rcClearGoodsNumBar();
    RcSysChk.rcClearRcptBar();
    RcSet.rcClearFuncKeyBar();
    RcSet.rcClearAyahaGiftPointBar();
    RcSet.rcClearWsUsedItemInfo();
    Rcdepoinplu.rcClearDepoInPluBar();
    RcSet.rcClearProdBar2St();
    RcSet.rcClearPublicBar3Expdate();
    RcSet.rcClearDivdata();

    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    if (atSing.autolevel != 0) {
      atSing.autolevel = 0;
      atSing.autonumber = 0;
      atSing.autoCall = 0;
      atSing.autotimer1 = 0;
      atSing.autotimer2 = 0;
      atSing.autotimer3 = 0;
      atSing.autotimerCnt = 0;
      atSing.autoMbrFlg = 0;
    }
    atSing.depoBrtInFlg = 0;             /* 瓶返却フラグ */
    cMem.stat.updDsp = 0;
    if (((await CmCksys.cmSPVTSystem() != 0) ||
        (await CmCksys.cmFclEdySystem() != 0) ||
        (await CmCksys.cmFclQUICPaySystem() != 0))
        && (atSing.spvtData.anyCd != 0)) {
      atSing.spvtData.anyCd = List.filled(atSing.spvtData.anyCd.length, 0);
    }
    RckyClsCncl.rcItmClsCnclFlgClr(-1);
  }
}