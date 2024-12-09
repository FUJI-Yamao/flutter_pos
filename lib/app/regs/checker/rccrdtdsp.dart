/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import 'rc_crdt_fnc.dart';
import 'rc_ifevent.dart';
import 'rcfncchk.dart';
import 'rcnttcrdt.dart';
import '../../fb/fb2gtk.dart';
import '../../fb/fb_lib.dart';
import '../../fb/fb_style.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/L_rccrdt.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_ext.dart';
import 'rc_itm_dsp.dart';
import 'rc_masr.dart';
import 'rc_qc_dsp.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rc_touch_key.dart';
import 'rcky_rfdopr.dart';
import 'rckycref.dart';
import 'rcqc_com.dart';
import 'rcsyschk.dart';

class RcCrdtDsp{

  ///  関連tprxソース: rccrdtdsp.c - entry
  static Object? entry;

  ///  関連tprxソース: rccrdtdsp.c - rcCrdt_ReDsp
  static void rcCrdtReDsp(){
    // TODO:00012 平野 クレジット宣言：UI
    return;
  }

  // TODO:定義のみ追加
  ///  関連tprxソース: rccrdtdsp.c - rcCrdt_GtkGrabAdd
  static void rcCrdtGtkGrabAdd() {
    return;
  }

  /// クレジット問い合わせ表示
  /// 関連tprxソース: rccrdtdsp.c - rcCrdt_InquDisp
  static Future<void> rcCrdtInquDisp() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ;
    }
    RxCommonBuf cBuf = xRet.object;

    if((await RcSysChk.rcKySelf() != 0) && (!await RcSysChk.rcCheckQCJCSystem())){
      if((!(await CmCksys.cmNttaspSystem() != 0)) && ((cMem.working.crdtReg.stat & 0x0001) != 0)){
        return;
      }
    }
    RcIfEvent.rxChkTimerRemove(); /* キー入力禁止 */
    if ((await RcFncChk.rcCheckCrdtVoidSMode()) ||
        (await RcFncChk.rcCheckCrdtVoidIMode()) ||
        (await RcFncChk.rcCheckCrdtVoidAMode())) {
      if(await RcNttCrdt.rcChkNttCrdtAutoCan()){
        // TODO:クレジット訂正：エラーダイアログ表示
        // rcCrdtVoid_DialogErr(MSG_PLEASE_WAITING, 2, NULL);
      } else if ((await RcSysChk.rcChkVegaProcess()) &&
          (await RcCrdtFnc.rcCheckCrdtVoidMcdProc())) {
        /* VEGA3000接続でレシート呼出の訂正でカード問合せ中の場合 */
        // TODO:クレジット訂正：エラーダイアログ表示
        // rcCrdtVoid_DialogErr(MSG_CRDT_VEGA_CARD, 2, NULL);
      } else {
        // TODO:クレジット訂正：エラーダイアログ表示
        // rcCrdtVoid_DialogErr(MSG_INQUIRE, 2, NULL);
      }
      // ＦＩＰに問合せ画面を表示する
      // TODO:クレジット訂正：UI処理
      // rcDisp_Inq_Fip(1);
      return;
    }
    if(await RcSysChk.rcQCChkQcashierSystem() ) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcQC_Movie_Stop();
      // rcQC_Sound_Stop();
    }
    if(await RcNttCrdt.rcChkNttCrdtAutoCan()){
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcErrNoBz(MSG_PLEASE_WAITING);
    } else if (await RcSysChk.rcChkVegaProcess()) {
      //VEGA接続の場合、状況に応じてメッセージを変える
      if ((cMem.working.crdtReg.step == (KyCrdtInStep.INPUT_1ST.cd + 1)) ||
          (cMem.working.crdtReg.step == (KyCrdtInStep.RECEIT_NO.cd + 1)) ||
          ((int.parse(cMem.working.crdtReg.cdno[0]) == 0x00) &&
              (int.parse(cMem.working.crdtReg.cdno[0]) == 0x00))) {
        /* 端末でカードを読ませてください */
        // TODO:00012 平野 クレジット宣言：端末カード読込指示ダイアログ表示
        // rcErrNoBz(MSG_CRDT_VEGA_CARD);
      }else if((cBuf.dbTrm.crdtSignlessMaxLimit != 0)//サインレス上限金額の設定あり
          &&
          (await RcCrdtFnc.rcGetCrdtPayAmount() >=
              cBuf.dbTrm.crdtSignlessMaxLimit) && //サインレス上限金額以上のクレジット支払い
          (await RcCrdtFnc.rcChkCrdtCancel())) //クレジットの訂正ではない
      {
        /* 問い合わせ中・・・クレジット端末で暗証番号を... */
        // TODO:00012 平野 クレジット宣言：暗証番号入力指示ダイアログ表示
        // rcErrNoBz(MSG_INQUIRE_CRDT_PIN);
      }else{
        // TODO:00012 平野 クレジット宣言：問い合わせ中ダイアログ表示
        // rcErrNoBz(MSG_INQUIRE);
      }
    }else{
      // TODO:00012 平野 クレジット宣言：問い合わせ中ダイアログ表示
      // rcErrNoBz(MSG_INQUIRE);
    }
    // ＦＩＰに問合せ画面を表示する
    // TODO:10166 クレジット決済 20241004実装対象外
    // rcDisp_Inq_Fip(1);
  }

  // TODO:定義のみ追加
  ///  関連tprxソース: rccrdtdsp.c - rcCrdt_GtkDestroy
  static void rcCrdtGtkDestroy(Object? window) {
    return;
  }

  ///  関連tprxソース: rccrdtdsp.c - rcCrdt_StepDisp
  static Future<void> rcCrdtStepDisp() async {
    if(((await RcSysChk.rcKySelf()) == RcRegs.KY_CHECKER) && (! await RcSysChk.rcCheckQCJCSystem())) {
      return;
    }

    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.crdtReg.step++;

    RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
    await RcSet.rcClearDataReg();
    RcSet.rcClearEntry();

    if (   (await RcFncChk.rcCheckCrdtVoidSMode()) 
        || (await RcFncChk.rcCheckCrdtVoidIMode())
        || (await RcFncChk.rcCheckCrdtVoidAMode())
        || (RckyRfdopr.rcRfdOprCheckAllRefundMode())
        || (RckyRfdopr.rcRfdOprCheckRcptVoidMode())) {
      return;
    }

    KyCrdtInStep tmpStep = KyCrdtInStep.getDefine(cMem.working.crdtReg.step);
    switch (tmpStep) {
       case KyCrdtInStep.CARD_KIND : await rcPleaseKindDisp();  break;
       case KyCrdtInStep.PLES_CARD : await rcPleaseCdnoDisp(); break;
       case KyCrdtInStep.GOOD_THRU : await rcPleaseDateDisp(); break;
       case KyCrdtInStep.RECEIT_NO : await rcPleaseRpnoDisp(); break;
       case KyCrdtInStep.PAY_A_WAY : await rcInPayAWayDisp(); break;
       case KyCrdtInStep.DIV_BEGIN : await rcInPayBeginDisp(); break;
       case KyCrdtInStep.PAY_DIVID : await rcInPayDividDisp(); break;
       case KyCrdtInStep.BONUS_TWO : await rcInBonusTwoDisp(); break;
       case KyCrdtInStep.BNS_BEGIN : await rcInPayBeginDisp(); break;
       case KyCrdtInStep.BONUSUSE1 : await rcInBonusUse1Disp(); break;
       case KyCrdtInStep.BONUS_CNT : await rcInBonusCntDisp(); break;
       case KyCrdtInStep.BONUSUSE2 : await rcInBonusUse2Disp(); break;
       case KyCrdtInStep.PAY_KYCHA :
       case KyCrdtInStep.OFF_KYCHA : await rcPleaseKyChaDisp(); break;
       case KyCrdtInStep.RECOGN_NO : await rcPleaseRenoDisp(); break;
       default        :                                   break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcPlease_KindDisp
  static Future<void> rcPleaseKindDisp() async {

    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    if(RcCrdt.CHK_DEVICE_MCD() && !(await RcSysChk.rcChkCapSCafisSystem())) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcPleaseKindDisp : AT_SING->inputbuf.dev = [${atSing.inputbuf.dev}]\n");
          return;
    }

    if(!(await RcSysChk.rcQCChkQcashierSystem())) {
      if((RcSysChk.rcCheckCrdtStat()) && (cMem.stat.scrType == RcRegs.LCD_104Inch)) {
        rcCrdtGtkDestroy(null);
      }
    }

    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR :
        if(await RcSysChk.rcChkQuickSelfSystem()) {

          cMem.stat.scrType = RcRegs.LCD_104Inch;
          RcSgDsp.rcSGDualReadCreditWindow();

        } else if ( await RcSysChk.rcQCChkQcashierSystem() ) {

          cMem.stat.scrType = RcRegs.LCD_104Inch;
          await RcSet.rcQCCrdtDspScrMode();

          if( RcFncChk.rcQCCheckCrdtDspMode() ){

            /* 自走式磁気リーダチェック */
            RcQcDsp.rcQCPayDsp();
            RcQcDsp.rcQCSlctDspDestroy();

            if( RcFncChk.rcCheckMasrSystem() ) {

              RcInfoMemLists rcInfoMem = RcInfoMemLists();
              RegsMem mem = SystemFunc.readRegsMem();
              if ( (rcInfoMem.rcRecog.recogSm19NishimutaSystem != 0)	/* ニシムタ様 */
                && (! (await RcCrdtFnc.rcChkCrdtCancel()))            /* 訂正系操作ではない */
                && (mem.tTtllog.t100700.mbrInput == 2)		            /* 磁気読込 */
                && (mem.tTtllog.t100700Sts.mbrTyp == NsmtMbrType.NSMT_PONTAJCB.value)/* ニシムタPontaJCBカード */
                && ((await CmCksys.cmDummyCrdtSystem()) == 0)         /* ダミクレではない */
                && (cMem.jis2TmpBuf.isNotEmpty))	{		                /* 一度読みをしている */
              } else {                                                /* 一度読みの時はここで自走式リーダを動かさない */
                RcMasr.rcSetMasrInfoClr();
                RcMasr.rcMasrStartSet();
              }
            }
          }
        } else {

          rc104InchKindDisp();
          rcCrdtScrModeSet();

          if (await RcSysChk.rcSysChkHappySmile()) {
            if ((await RcFncChk.rcsyschkHappysmileTranSelectSystem()) != 0) {
              Rc28StlInfo.colorFipWindowDestroy();
              cMem.stat.scrMode = RcRegs.RG_QC_CRDT;
              RcQcDsp.rcQCPayDsp();

              if (RcFncChk.rcCheckMasrSystem()) {
                RcItmDsp.rcHalfMsgDestroy(0);
                Rc28StlInfo.ColorFipPopdown();
                RcMasr.rcCheckMasrNormalSet("rcPleaseKindDisp", MasrOrderCk.READ_START);
              }
            }
          }
        }
        break;
      case RcRegs.KY_SINGLE   :
        rcCrdtInImageDsp();
        if (cMem.stat.scrType == RcRegs.LCD_104Inch) {
          rc104InchKindDisp();
        }
        break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcCrdt_ScrModeSet
  static Future<void> rcCrdtScrModeSet() async {
    if(RcSysChk.rcCheckCrdtStat()) {
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    RxTaskStatBuf tsBUF = xRet.object;
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    
      switch(await RcSysChk.rcKySelf())
      {
        case RcRegs.KY_DUALCSHR : 
            tsBUF.cash.int_ban_flg = 1;
        case RcRegs.DESKTOPTYPE : 
            RcSet.rcCrdtScrMode();
            break;

        case RcRegs.KY_SINGLE   :
            if( (iBuf.devInf.devId == TprDidDef.TPRDIDMECKEY1)
             || (iBuf.devInf.devId == TprDidDef.TPRDIDTOUKEY1) ) {
              RcSet.rcCrdtSubScrMode();
            } else {
              RcSet.rcCrdtScrMode();
            }
            break;
        case RcRegs.KY_CHECKER  :
            if (await RcSysChk.rcCheckQCJCSystem()) {
              RcSet.rcCrdtScrMode();
            }
            break;
      }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcPlease_CdnoDisp
  static Future<void> rcPleaseCdnoDisp() async {
    if(RcCrdt.CHK_DEVICE_MCD()) {
      return;
    }

    if(await RcSysChk.rcChkVegaProcess()) {
      return;
    }

    if (await RcSysChk.rcsyschkKasumiEMVSystem()) {
      return;
    }

    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR : 
        rc104InchCdnoDisp();
        break;

      case  RcRegs.KY_SINGLE   : 
        AcMem cMem = SystemFunc.readAcMem();
        if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
          rc104InchCdnoDisp();
        }
        break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcPlease_DateDisp
  static Future<void> rcPleaseDateDisp() async {
    if(RcCrdt.CHK_DEVICE_MCD()) {
      return;
    }

    if(await RcSysChk.rcChkVegaProcess()) {
      return;
    }

    if (await RcSysChk.rcsyschkKasumiEMVSystem()) {
      return;
    }

    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR :
        rc104InchDateDisp();
        break;
      case RcRegs.KY_SINGLE   :
        AcMem cMem = SystemFunc.readAcMem();
        if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
          rc104InchDateDisp();
        }
        break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcPlease_RpnoDisp
  static Future<void> rcPleaseRpnoDisp() async {
    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR :
        rc104InchRpnoDisp();
        break;
      case RcRegs.KY_SINGLE   :
        AcMem cMem = SystemFunc.readAcMem();
        if(cMem.stat.scrType ==  RcRegs.LCD_104Inch) {
          rc104InchRpnoDisp();
        }
        break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcInPay_BeginDisp
  static Future<void> rcInPayBeginDisp() async {
    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR :
        rc104InchBeginDsp();
        break;
      case RcRegs.KY_SINGLE   :
      AcMem cMem = SystemFunc.readAcMem();
      if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
        rc104InchBeginDsp();
      }
      break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcInPay_DividDisp
  static Future<void> rcInPayDividDisp() async {
      switch(await RcSysChk.rcKySelf())
      {
        case RcRegs.DESKTOPTYPE :
        case RcRegs.KY_CHECKER  :
        case RcRegs.KY_DUALCSHR :
          rc104InchDividDsp();
          break;
        case RcRegs.KY_SINGLE   :
          AcMem cMem = SystemFunc.readAcMem();
          if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
            rc104InchDividDsp();
          }
        break;
      }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcInBonus_TwoDisp
  static Future<void> rcInBonusTwoDisp() async {
      switch(await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE :
        case RcRegs.KY_CHECKER  :
        case RcRegs.KY_DUALCSHR :
          rc104InchInBo2Dsp();
          break;

        case RcRegs.KY_SINGLE   :
          AcMem cMem = SystemFunc.readAcMem();
            if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
            rc104InchInBo2Dsp();
          }
          break;
      }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcInBonusUse1Disp
  static Future<void> rcInBonusUse1Disp() async {
    switch(await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE :
        case RcRegs.KY_CHECKER  :
        case RcRegs.KY_DUALCSHR :
          rc104InchUse1Disp();
          break;
        case RcRegs.KY_SINGLE   :
          AcMem cMem = SystemFunc.readAcMem();
          if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
            rc104InchUse1Disp();
          }
          break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcInBonus_CntDisp
  static Future<void> rcInBonusCntDisp() async {

    if((await CmCksys.cmNttaspSystem()) == 0) {

      switch(await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE :
        case RcRegs.KY_CHECKER  :
        case RcRegs.KY_DUALCSHR :
          rc104InchCntDisp();
          break;
        case RcRegs.KY_SINGLE   :
          AcMem cMem = SystemFunc.readAcMem();
          if( cMem.stat.scrType == RcRegs.LCD_104Inch ) {
            rc104InchCntDisp();
          }
          break;
        default:
          break;
      }
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcInBonusUse2Disp
  static Future<void> rcInBonusUse2Disp() async {
    
      if(RcCrdtFnc.rcSpecBonusMthInput()) {

        switch(await RcSysChk.rcKySelf()) {
          case RcRegs.DESKTOPTYPE :
          case RcRegs.KY_CHECKER  :
          case RcRegs.KY_DUALCSHR :
            rc104InchUse2Disp();
            break;
          case RcRegs.KY_SINGLE   :
            AcMem cMem = SystemFunc.readAcMem();
            if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
              rc104InchUse2Disp();
            }
            break;
        }
      }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcPleaseKyChaDisp
  static Future<void> rcPleaseKyChaDisp() async {
    switch(await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE :
        case RcRegs.KY_CHECKER  :
        case RcRegs.KY_DUALCSHR :
        rc104InchKChaDisp();
        break;
        case RcRegs.KY_SINGLE   :
        AcMem cMem = SystemFunc.readAcMem();
        if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
          rc104InchKChaDisp();
        }
        break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcPlease_RenoDisp
  static Future<void> rcPleaseRenoDisp() async {

    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR :
        rc104InchRenoDisp();
        break;
      case RcRegs.KY_SINGLE   :
        AcMem cMem = SystemFunc.readAcMem();
        if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
          rc104InchRenoDisp();
        }
                          break;
    }
  }

  ///  関連tprxソース: rccrdtdsp.c - rcInPay_a_WayDisp
  static Future<void> rcInPayAWayDisp() async {

    AcMem cMem = SystemFunc.readAcMem();

    if(await RcSysChk.rcSGChkSelfGateSystem()) {
      if(await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
        if(RcSgDsp.selfMem.sg_chk_staff_call == 1) {

          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "SELF-GATE:rcInPayAWayDisp() StaffCall Reset\n");
          TprDlg.tprLibDlgClear("rcInPayAWayDisp");
          RcExt.rcClearErrStat("rcInPayAWayDisp");
          RcSgDsp.selfMem.call_btn = 0;
          RcSgDsp.selfMem.sg_chk_staff_call = 0;
        }
      }

      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "SELF-GATE:rcInPayAWayDisp()\n");
      if(cMem.working.refData.crdtTbl.lump != 0) {         /* 一括払いが設定されているか */
        cMem.working.crdtReg.crdtTbl.lump = 1;
      } else {
        await RcExt.rcErr("rcInPayAWayDisp", DlgConfirmMsgKind.MSG_NOTUSECARD.dlgId);
        return;
      }

      cMem.working.crdtReg.step = KyCrdtInStep.INPUT_END.cd;

      rcPleaseKyChaDisp();
      return;
    }

    if(await RcSysChk.rcQCChkQcashierSystem()) {
      if(! RcFncChk.rcQCCheckCrdtMode() ){
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "ScrMode Err[{cMem.stat.scrMode}]\n");  
        return;
      }

      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "QCashier:rcInPayAWayDisp()\n");

      if(cMem.working.refData.crdtTbl.lump != 0) {         /* 一括払いが設定されているか */
        cMem.working.crdtReg.crdtTbl.lump = 1;
      } else {
        await RcExt.rcErr("rcInPayAWayDisp", DlgConfirmMsgKind.MSG_NOTUSECARD.dlgId);
        return;
      }
      cMem.working.crdtReg.step = KyCrdtInStep.INPUT_END.cd;

      rcPleaseKyChaDisp();
      return;
    }

    /* マルイ様特注 一括を自動選択して支払方法選択画面をなくす仕様 */
    if((await CmCksys.cmSm3MaruiSystem()) != 0) {
      /* 一括を使用できないカードなら支払方法選択画面に移行 */
      if(cMem.working.refData.crdtTbl.lump != 0) {
        await TchKeyDispatch.rcPre104CrdtProc(RcCrdt.LUMP);
        return;
      }
    }

    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  :
      case RcRegs.KY_DUALCSHR : 
        rc104InchAWayDisp();
        break;
      case RcRegs.KY_SINGLE   :
        AcMem cMem = SystemFunc.readAcMem();
        if(cMem.stat.scrType == RcRegs.LCD_104Inch) {
          rc104InchAWayDisp();
        }
        break;
    }

    if (await RcSysChk.rcSysChkHappySmile()) {

      RcQcDsp.rcQC_WAON_ReadErrDisp();

      if (QCashierIni().typ_max > 1) {

        if ((await RcFncChk.rcsyschkHappysmileTranSelectSystem()) != 0) {

          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcInPayAWayDisp : <happy smile>QCPayDsp.back_btn ctrl\n");

          if (RcQcDsp.qcPayDsp.back_btn != null) {
            Fb2Gtk.gtkWidgetSetSensitive(RcQcDsp.qcPayDsp.back_btn, false);
            Fb2Gtk.gtkWidgetHide(RcQcDsp.qcPayDsp.back_btn);
          }

          if (RcQcDsp.qcPayDsp.backbtn_pixmap != null) {
            Fb2Gtk.gtkWidgetHide(RcQcDsp.qcPayDsp.backbtn_pixmap);
          }
        }
      }

      if (RcFncChk.rcCheckMasrSystem()) {
        RcMasr.rcMasrChkEnd();
        RcQcCom.rcQCLedCom( QcLedNo.QC_LED_CRDT.index
                          , QcLedColor.QC_LED_OFF_COLOR.index
                          , QcLedDisp.QC_LED_DISP_OFF.index, 0, 0, 0);
      }
    }
  }

  /// 関連tprxソース: rccrdtdsp.c - rcCrdt_Detail
static Future<void> rcCrdtDetail() async {

  String selBtn =  "select Payment Type Crdt";
  String buf = "";
  AcMem cMem = SystemFunc.readAcMem();

	if(cMem.working.crdtReg.crdtTbl.lump != 0) {
		buf = LRccrdt.KEY_LUMP;
		selBtn +=  " [lump] ";
	} else if(cMem.working.crdtReg.crdtTbl.twice != 0) {
		buf = LRccrdt.KEY_TWICE;
    selBtn += " [twice] ";
	} else if(cMem.working.crdtReg.crdtTbl.divide != 0) {
    buf = LRccrdt.KEY_DIVID;
    selBtn += " [divide] ";
    
		if(cMem.working.crdtReg.crdtTbl.divide3 != 0) {
      buf += LRccrdt.KEY_3TIMES;
      selBtn += " [3] ";
		} else if(cMem.working.crdtReg.crdtTbl.divide5 != 0) {
      buf += LRccrdt.KEY_5TIMES;
      selBtn += " [5] ";
		} else if(cMem.working.crdtReg.crdtTbl.divide6 != 0) {
      buf += LRccrdt.KEY_6TIMES;
      selBtn += " [6] ";
		} else if(cMem.working.crdtReg.crdtTbl.divide10 != 0) {
      buf += LRccrdt.KEY10TIMES;
      selBtn += " [10] ";
		}	else if(cMem.working.crdtReg.crdtTbl.divide12 != 0) {
      buf += LRccrdt.KEY12TIMES;
      selBtn += " [12] ";
		}	else if(cMem.working.crdtReg.crdtTbl.divide15 != 0) {
      buf += LRccrdt.KEY15TIMES;
      selBtn += " [15] ";
		} else if(cMem.working.crdtReg.crdtTbl.divide18 != 0) {
      buf += LRccrdt.KEY18TIMES;
      selBtn += " [18] ";
		} else if(cMem.working.crdtReg.crdtTbl.divide20 != 0) {
      buf += LRccrdt.KEY20TIMES;
      selBtn += " [20] ";
		} else if(cMem.working.crdtReg.crdtTbl.divide24 != 0) {
      buf += LRccrdt.KEY24TIMES;
      selBtn += " [24] ";
		} else if(cMem.working.crdtReg.crdtTbl.divide30 != 0) {
      buf += LRccrdt.KEY30TIMES;
      selBtn += " [30] ";
		} else if(cMem.working.crdtReg.crdtTbl.divide36 != 0) {
      buf += LRccrdt.KEY36TIMES;
      selBtn += " [36] ";
		}
	} else if(cMem.working.crdtReg.crdtTbl.bonus_lump != 0) {
    buf = LRccrdt.KEY_BONUS_LUMP;
    selBtn += " [bonus lump] ";
	} else if(cMem.working.crdtReg.crdtTbl.bonus_twice != 0) {
    buf = LRccrdt.KEY_BONUS_TWICE;
    selBtn += " [bonus twice] ";
	} else if(cMem.working.crdtReg.crdtTbl.bonus_use != 0) {
    buf = LRccrdt.KEY_BONUS_USE;
    selBtn += " [bonus use] ";
	} else if(cMem.working.crdtReg.crdtTbl.ribo != 0) {
    buf = LRccrdt.KEY_RIBO;
    selBtn += " [ribo] ";
	}
  
  Fb2Gtk.gtkRoundEntrySetText(RcCrdtDsp.entry, buf);
  FbStyle.chgStyle(
        RcCrdtDsp.entry,
        Color_Select[FbColorGroup.BlackGray.index],
        Color_Select[FbColorGroup.White.index],
        Color_Select[FbColorGroup.White.index],
        RcKyCRef.KANJI24);
  Fb2Gtk.gtkWidgetShowAll(RcCrdtDsp.entry);

  TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, selBtn);

}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchKindDisp
  static void rc104InchKindDisp() {}

  // TODO:定義のみ追加
  /// 画面に"クレジット取引中"を表示
  /// 関連tprxソース: rccrdtdsp.c - rcCrdtIn_ImageDsp
  static void rcCrdtInImageDsp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchCdnoDisp
  static void rc104InchCdnoDisp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchDateDisp
  static void rc104InchDateDisp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchRpnoDisp
  static void rc104InchRpnoDisp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchBeginDsp
  static void rc104InchBeginDsp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchDividDsp
  static void rc104InchDividDsp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchInBo2Dsp
  static void rc104InchInBo2Dsp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchUse1Disp
  static void rc104InchUse1Disp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchCnt_Disp
  static void rc104InchCntDisp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchUse2Disp
  static void rc104InchUse2Disp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchKChaDisp
  static void rc104InchKChaDisp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchRenoDisp
  static void rc104InchRenoDisp() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rccrdtdsp.c - rc104InchAWayDisp
  static void rc104InchAWayDisp() {}
}

