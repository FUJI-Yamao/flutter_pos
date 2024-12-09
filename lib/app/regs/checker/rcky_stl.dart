/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cls_conf/qcashierJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/inc/lib/apllib.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_com.dart';
import '../../tprlib/TprLibDlg.dart';
import '../common/rx_log_calc.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import '../inc/rccatalina_define.dart';
import 'rc28taborder.dart';
import 'rc_28dsp.dart';
import 'rc_59dsp.dart';
import 'rc_acracb.dart';
import 'rc_assist_mnt.dart';
import 'rc_cashless.dart';
import 'rc_ext.dart';
import 'rc_felica.dart';
import 'rc_itm_dsp.dart';
import 'rc_key_extkey.dart';
import 'rc_key_qcselect.dart';
import 'rc_mbr_com.dart';
import 'rc_mbr_realsvr.dart';
import 'rc_mcd.dart';
import 'rc_qc_dsp.dart';
import 'rc_qrinf.dart';
import 'rc_reserv.dart';
import 'rc_set.dart';
import 'rc_signp_ctrl.dart';
import 'rc_usbcam1.dart';
import 'rc_vfhd_fself.dart';
import 'rcabs_v31.dart';
import 'rccatalina.dart';
import 'rccrwp_com.dart';
import 'rcfncchk.dart';
import 'rcitmchk.dart';
import 'rcky_cpnprn.dart';
import 'rcky_mbrprn.dart';
import 'rcky_regassist.dart';
import 'rcky_rfdopr.dart';
import 'rcky_wiz.dart';
import 'rckycashint.dart';
import 'rckyccin.dart';
import 'rckyccin_acb.dart';
import 'rckydisburse.dart';
import 'rckyselpluadj.dart';
import 'rcmbr_Tpointcardchk.dart';
import 'rcmbrkymbr.dart';
import 'rcmbrrecal.dart';
import 'rcopncls.dart';
import 'rcorc_rd.dart';
import 'rcqr_com.dart';
import 'rcsapporo_pana_com.dart';
import 'rcspoolo.dart';
import 'rcstl_Ichiyama_BdlSlct.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'rctrc_rd.dart';
import 'rcvmc_rd.dart';
import 'rxregstr.dart';

class RckyStl{
  static int infFlag = 0;
  static int stlwaitSpoolFlg = 0;
  static int memberConfFlag = 0;
  static int stlwaitClearFlg = 0;
  ///  関連tprxソース: rcky_stl.c - rcKyStl_Error
  static Future<int> rcKyStlError({bool isDual=false}) async {
    int ret = 0;

    // TODO:10147 CMEM->key_stat の実装が完了したら正式対応
    /*
    AcMem cMem = SystemFunc.readAcMem();
    if (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {  /* nessecary Registration */
      // 新POSではMSG_OPEERRではなく、MSG_TWOCNCT_ERR_CALLRESULTを指定する
      return DlgConfirmMsgKind.MSG_TWOCNCT_ERR_CALLRESULT.dlgId;
    }
    */
    // 二人制卓上側処理
    if (isDual) {
      await RcSpoolo.rcSpoolOut();
    }

    // TODO:10147の暫定対応 -->
    // 登録商品がない場合はエラー
    if( RegsMem().lastResultData?.totalDataList?.isEmpty ?? true){
      return DlgConfirmMsgKind.MSG_TWOCNCT_ERR_CALLRESULT.dlgId;
    }
    int itemCount = RegsMem().lastTotalData?.totalQty ?? 0;
    if (itemCount == 0) {
       return DlgConfirmMsgKind.MSG_TWOCNCT_ERR_CALLRESULT.dlgId;
    }
    // <-- TODO:10147暫定対応

    // TODO:00016 佐藤 必要な部分だけ先行実装、それ以外はコメントアウト
    /*
    cm_fil((char *)CMEM->key_chkb, 0xFF, sizeof(CMEM->key_chkb));
    rcKy_St_L0(CMEM->key_chkb, (short *)Stl_List0);
    rcKy_St_L1(CMEM->key_chkb, (short *)Stl_List1);
    rcKy_St_L2(CMEM->key_chkb, (short *)Stl_List2);
    rcKy_St_L3(CMEM->key_chkb, (short *)Stl_List3);
    rcKy_St_L4(CMEM->key_chkb, (short *)Stl_List4);
    #if 0
    if(rcKy_Status(CMEM->key_chkb, MACRO1 + MACRO2))
    return (MSG_OPEERR);                       /* Ope Error */
    #endif
    ret = rcKy_Status(CMEM->key_chkb, MACRO1 + MACRO2);
    if(ret)
    {
    return(rcSet_DlgAddData_KeyStatus_Result(ret));
    }

    if(cm_hc1_komeri_system()) {
    if (rxCalc_Stl_Tax_Amt(MEM) == 0)
    return (MSG_STL_ZERO);
    }

    if ((cm_maruto_system()) &&(rcFncCode_Pm()))	//マルト様特注：小計割引時は小計キー押下後に割引キー押下を強制
        {
    return (MSG_OPEERR);
    }
    if((TaxFree_Chg_Chk()) &&
    ((rcFncCode_Dsc())	||   //値引
    (rcFncCode_Pm())	||   //割引
    (rcFncCode_Plus()))) 	     //割増
        {
    return(MSG_TAXFREE_CHG_ERR);
    }
    */
    return 0;   /* OK */
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcky_stl.c - rcStl_Display
  static void  rcStlDisplay(bool ctrl){
    return;
  }

  ///  関連tprxソース: rcky_stl.c - rc_DisableFlg_Set
  static void  rcDisableFlgSet() async {
    if((RcSysChk.rcCheckTECOperation() != 0)	||
        (RcSysChk.rcCheckEtcOperation())	||
        (await CmCksys.cmSm3MaruiSystem() != 0)	||
        (RcSysChk.rcChkSpecialMultiOpe()))
    {
      AcMem().stat.disableFlag = 1;
    }
  }

  /// 二人制タワー側商品登録中かチェックする
  /// 戻り値  true：登録中／false：未登録
  static bool checkRegistration(){
    if( RegsMem().lastResultData?.totalDataList?.isEmpty ?? true){
      return false;
    }
    return true;
  }

  /// 機能：対面セルフ仕様で買上合計額や入金額を流す処理
  /// 引数：０：買上合計額　１：入金額->確認ボタン　２：入金額->おわりボタン
  /// 戻値：なし
  /// 関連tprxソース: rcky_stl.c - rcky_stl_fself_voice_proc
  /// TODO:00010 長田 定義のみ追加
  static void rckyStlFselfVoiceProc(int status) {
    return;
  }

  /// 関連tprxソース: rcky_stl.c - rcKyStl
  static Future<int> rcKyStl() async {
    int errNo = 0; /* acr error no */
    String erlog = '';
    int itmCnt;
    int listCheck;
    int stlFirstFlg = 0;
    QCashierIni? qCashierIni;
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRetC.object;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((cBuf.dbTrm.frcClkFlg == 2) && (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR)) {
      if (cBuf.dbStaffopen.cshr_status == 0) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_CSHRCLOSE.dlgId;
        await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
        return 0;
      }
    }
    // クーポン発券中はエラーとする
    if ((await CmCksys.cmZHQSystem() != 0) && (RcKyCpnprn.rccpnprnPrintResCheck() == -1)) {
      int e = RcKyCpnprn.rccpnprnPrintResCheck();
      erlog = "rcKyStl: cpn print sts [$e]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, erlog);

      cMem.ent.errNo = DlgConfirmMsgKind.MSG_PRINT_WAITING.dlgId;
      await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
      return 0;
    }
    if ((RcSysChk.rcChkCustrealsvrSystem()) || (await RcSysChk.rcChkCustrealNecSystem(0))) {
      if ((RcMbrRealsvr.custRealSvrWaitChk() != 0) || (RcMcd.rcMcdMbrWaitChk() != 0)) {
        if ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)
            || (await RcSysChk.rcCheckQCJCSystem())) {
          /* cashier ? */
          if (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
            /* end of sales ? */
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_MBRINQUIR.dlgId;
            await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
            return 0;
          }
          else if (RcRegs.rcInfoMem.rcCnct.cnctAcrCnct != 0) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_MBRINQUIR.dlgId;
            await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
            return 0;
          }
        }
      }
    }
    if (await RcSysChk.rcChkDesktopCashier()) {
      await Rxregstr.rxSetClerkNoName();
    }

    if ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) && /* cashier ? */
        (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) && /* end of sales ? */
        (! RckyRfdopr.rcRfdOprCheckOperateRefundMode())) { // 返品操作時ではない
      if (await RcKySelpluadj.rckySelPluAdjSelctMode()) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEBUSYERR.dlgId;
        await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
        return 0;
      }

      RcSet.rcTimerReset(); // 稼働時間の初期化
      RcOpnCls.rcCheckAfterUpdate(); // チェッカー作成実績の処理

      if (Rc28TabOrder.rcTabMoveRegStart(0) !=0) { // タブの移動を行う. 失敗した時は戻る.
        await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
        return 0;
      }

      if (cMem.stat.cashintFlag != 0) {
        if (RcSysChk.rcChkSpoolExist()) {
          if (RcSysChk.rcChkSpoolExist() && await RcSysChk.rcSysChkHappySmile()) {
            stlwaitSpoolFlg = 1;
          }
          if (!await RcSysChk.rcChkDesktopCashier()) {
            cMem.stat.cashintFlag = 0;
            RcKyCashInt.rcKyCashIntWtEj();
          }
        }
      }
      // todo 2人制時は現状rcKyStlを使用していないため、この処理は不要
      //await RcSpoolo.rcSpoolOut();
      if (await RcSysChk.rcChkDesktopCashier()) {
        if (cMem.ent.errNo == 0) {
          RcItmDsp.rcHalfMsgDestroy(0);
        }
      }

      RckyMbrPrn.rcKyMbrPrnCopyCustTrm2PrnrBuf();
      RcMbrCom.rcmbrClearCustMem();
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
          (await RcSysChk.rcChkSptendInfo()) &&
          (await RcFncChk.rcCheckStlMode())) {
        /// TODO:00010 長田　必要な処理か確認
        // rcSptendInfo_Quit(&Subttl);
        if (FbInit.subinitMainSingleSpecialChk()) {
          // rcSptendInfo_Quit(&Dual_Subttl);
        }
      }
      if (cMem.ent.errNo != 0) {
        return 0;
      }
      RcUsbCam1.rcUsbcamStartStop(UsbCamStat.CA_CAM_START.index, 0);

      RckyDisBurse.rcSetChangerItemAcrOFF(-1); /* 特定商品釣銭機無効仕様（コープさっぽろ仕様） */
      if (RcRegs.rcInfoMem.rcCnct.cnctAcrCnct != 0) {
        errNo = await RcAcracb.rcAcrAcbAnswerRead2();
        if (errNo == DlgConfirmMsgKind.MSG_ACROFF.dlgId) {
          errNo = 0;
        }
      }
      if (mem.tmpbuf.wizNonfilePlu == 1) {
        RcKyWiz.rcWizDialogConf();
      }
      RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO3);
      RcRegs.kyStS1(cMem.keyStat, FncCode.KY_REG.keyId);
      stlFirstFlg = 1;
      await RcExt.cashStatSet('rcKyStl');
      RcSet.cashIntStatSet();
      cashClsCnclSet();
      RcSet.rcItmSubLcdScrMode();
      RcSet.rc28DispStatusInit();
      await RcCashless.rcCashlessAllInit(); // キャッシュレス還元全部クリア
      if (await RcMbrCom.rcmbrChkStat() != 0) {
        if (!await RcSysChk.rcChkDesktopCashier()) {
          RcMbrCom.rcmbrClearModeStlDisp();
        }
      }
    }
    else {
      if (!await RcFncChk.rcCheckStlMode()) {
        stlFirstFlg = 1;
      }
    }

    cMem.ent.errNo = await RckyStl.rcKyStlError();

    if (await CmCksys.cmSpecialCouponSystem() != 0) {
      if ((cMem.ent.errNo == 0) && (await RcItmChk.rcCheckBenefitBarItem())) {
        if ((cMem.benefitBar!.couponBarBenefitcd == 7) ||
            (cMem.benefitBar!.couponBarBenefitcd == 8)) {
          /* Item Dsc/Pdsc Barcode Input ? */
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
        }
      }
    }

    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
      return 0;
    }

    if (RcSysChk.rcChkdPointMedicinePosSystem() != 0) {
      if ((TprLibDlg.tprLibDlgCheck2(1) == 0)
          && (memberConfFlag == 0)
          && (RcqrCom.qrTxtStatus == QrTxtStatus.QR_TXT_STATUS_INIT.index)
          && (RcqrCom.qrReadSptendCnt == 0)
          && (!(await RcSysChk.rcChkDesktopCashier()
              && (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER)))
          && (!await RcSysChk.rcQCChkQcashierSystem())) {
        RcKyExtKey.rcKyExtKeyEnd();

        if ((!await RcSysChk.rcSGChkSelfGateSystem())
            && (!await RcSysChk.rcChkShopAndGoSystem())) {
          if (await RcFncChk.rcCheckItmMode()
              && (RcFncChk.rcCheckRegistration())
              && (RcSysChk.rcChkdPointRead() != 0)
              && (RcItmChk.rcChkdPointMedicinePosItemKind(0) != 0)
              && (RcItmChk.rcChkdPointMedicinePosItemKind(1) != 0)) { // 処方せん商品と通常商品が混在
            rcStlMemberConf3();
            return 0;
          }
        }
      }
      memberConfFlag = 0;
    }
    if (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 1) {
      RctrcRd.rcTrcReadMainProc();
    }
    else if (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 2) {
      atSing.useRwcRw = 1;
      RcorcRd.rcOrcReadMainProc();
    }
    if (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 4) {
      atSing.useRwcRw = 1;
      RcCrwpCom.rcCrwpReadMainProc();
    }
    if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
      if (((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)
          || (await RcSysChk.rcCheckQCJCSystem())) &&
          (await RcMbrCom.rcmbrChkStat() != 0) &&
          ((RcMbrCom.rcmbrChkCust()) || (RcSysChk.rcChkMbrprcSystem()))) {
        if ((RcSysChk.rcChkCustrealsvrSystem()) || (await RcSysChk.rcChkCustrealNecSystem(0))) {
          if ((RcMbrRealsvr.custRealSvrWaitChk() != 0) || (RcMcd.rcMcdMbrWaitChk() != 0)) {
            cMem.ent.errNo = 0;
          }
          else {
            if (!((await CmCksys.cmIchiyamaMartSystem() != 0)
                && (RcSysChk.rcCheckCrdtStat()))) {
              if (!RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
                /* not sprit tend ? */
                cMem.ent.errNo = Rcmbrrecal.rcmbrReMbrCal(FuncKey.KY_STL.keyId, RcMbr.RCMBR_NON_WAIT);
              }
              else {
                cMem.ent.errNo = Rcmbrrecal.rcmbrReMbrCal(FuncKey.KY_STL.keyId, RcMbr.RCMBR_WAIT);
              }
            }

            if (cMem.ent.errNo == RcMbr.RCMBR_NON_READ) {
              cMem.ent.errNo = 0;
            }
          }
        }
        else {
          cMem.ent.errNo = Rcmbrrecal.rcmbrReMbrCal(FuncKey.KY_STL.keyId, RcMbr.RCMBR_WAIT);
          if (cMem.ent.errNo != 0) {
            await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
            return 0;
          }
        }
      }
    }
    if (RcSysChk.rcsyschkFselfMbrscan2ndScannerUse() != 0) {
      if (await RcFncChk.rcCheckItmMode()) { //登録モード
        if (RcFncChk.rcCheckRegistration()) { // １品以上登録されている
          if (cMem.fselfMbrscanInquiry == 1) { // 会員カード 問合せ する
            rcStlHappySmileMbrScanMemberInquiry();
            cMem.fselfMbrscanInquiry = 0; // 会員カード 問合せ しない
            if (cMem.ent.errNo != 0) { // 会員呼出でエラーが発生したら、小計画面には進めない
              RcVfhdFself.rcVFHDFselfMbrScanStatusClear(QcMbrScanStatus.QC_MBRSCAN_WAIT.id, 1);
              return 0;
            }
          }
          else if (cMem.fselfMbrscanFlg == QcMbrScanStatus.QC_MBRSCAN_WAIT.id) { //会員カード 操作待ち
            if (tsBuf.chk.chk_registration == 0) { //次客登録中でない
              if (cMem.fselfMbrscanPopupFlg == 0) { // 会員カード未入力ポップアップ 表示しない
                rcStlHappySmileMbrScanNotEntryPopup(); // ポップアップを表示
                cMem.fselfMbrscanPopupFlg = 1; // 会員カード未入力ポップアップ 表示した
                return 0;
              }
              else {
                cMem.fselfMbrscanPopupFlg = 0; // 会員カード未入力ポップアップ 表示しない
              }
            }
          }
        }
      }
    }

    if (await CmCksys.cmCashOnlyKeyOptSystem() != 0) { //「現金支払限定」仕様のキャッシュレス禁止キー押下
      if (mem.prnrBuf.banCashless == 1) {
        qCashierIni!.typ_max = 1; //支払選択画面を表示せず、現金決済のみ
      }
      else {
        qCashierIni!.typ_max = qCashierIni.org_typ_max;
      }
    }

    rcStlMainProc();
    if (TprLibDlg.tprLibDlgNoCheck() == DlgConfirmMsgKind.MSG_CONF_PAYPLACE_SEL.dlgId) {
      //会計場所選択ダイアログを表示する時
      return 0;
    }
    if ((cMem.ent.errNo == 0) &&
        (((!await RcSysChk.rcQCChkQcashierSystem())
            && (!await RcSysChk.rcQRChkPrintSystem())) ||
            RcSysChk.cmRealItmSendSystem()) &&
        ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)
            || (await RcSysChk.rcCheckQCJCSystem())) &&
        (RcCatalina.cmCatalinaSystem(1))) {
      RcCatalina.catalinaDataWrite(RcCatalinaDef.CA_MSG_REGSTART, 0);
      RcCatalina.catalinaDataWrite(RcCatalinaDef.CA_MSG_ITEM, 0);
      RcCatalina.catalinaDataWrite(RcCatalinaDef.CA_MSG_STLTTL, 0);
    }

    if ((cMem.ent.errNo == 0) && (errNo != 0)) {
      cMem.ent.errNo = errNo;
      await RcExt.rcErr("rcKyStl", cMem.ent.errNo); /* only acr error !! */
      return 0;
    }
    else if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
      return 0;
    }
    if (RcRegs.rcInfoMem.rcCnct.cnctRwtCnct == 3) {
      if ((await RcSysChk.rcQCChkQcashierSystem()) && (RcSysChk.rcChkRewriteCheckerCnct())) {
        /* RWを動作させない対応 */
        erlog = "rcKyStl: Vismac Read Skip !!\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);
        atSing.useRwcRw = 0;
        if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
          if ((await RcMbrCom.rcmbrChkStat() != 0) && (RcMbrCom.rcmbrChkCust())) {
            cMem.ent.errNo = Rcmbrrecal.rcmbrReMbrCal(FuncKey.KY_STL.keyId, RcMbr.RCMBR_WAIT);
            if (cMem.ent.errNo != 0) {
              await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
              return (0);
            }
          }
        }
      }
      else if ((RcSysChk.rcChkRewriteCheckerCnct()) &&
          (mem.tTtllog.t100700.mbrInput == MbrInputType.vismacCardInput.index)) {
        /* RWを動作させない対応 */
        erlog = "rcKyStl: Vismac Read Skip !! mbrInput[${mem.tTtllog.t100700.mbrInput}]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);
        atSing.useRwcRw = 1;
        if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
          if ((await RcMbrCom.rcmbrChkStat() != 0) && (RcMbrCom.rcmbrChkCust())) {
            cMem.ent.errNo = Rcmbrrecal.rcmbrReMbrCal(FuncKey.KY_STL.keyId, RcMbr.RCMBR_WAIT);
            if (cMem.ent.errNo != 0) {
              await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
              return (0);
            }
          }
        }
      }
      else {
        listCheck = 0;
        if (RcSysChk.rcChkRewriteCheckerCnct()) {
          for (
          itmCnt = 0; itmCnt < mem.tTtllog.t100001Sts.itemlogCnt; itmCnt++) {
            if (mem.tItemLog[itmCnt].t10000Sts.opeFlg == 2) { // 呼び戻しされた？
              listCheck = 1; // RWを動作させない対応
              break;
            }
          }

          if (listCheck == 0) {
            if (atSing.useRwcRw == -1) {
              erlog = "rcKyStl: useRwcRw[${atSing.useRwcRw}]\n";
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);
              listCheck = 1;
            }
          }
        }

        if (listCheck == 1) {
          erlog = "rcKyStl: Vismac Read Skip !! listCheck[$listCheck]\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);
          atSing.useRwcRw = 0;
          if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
            if ((await RcMbrCom.rcmbrChkStat() != 0) && (RcMbrCom.rcmbrChkCust())) {
              cMem.ent.errNo = Rcmbrrecal.rcmbrReMbrCal(FuncKey.KY_STL.keyId, RcMbr.RCMBR_WAIT);
              if (cMem.ent.errNo != 0) {
                await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
                return (0);
              }
            }
          }
        }
        else {
          atSing.useRwcRw = 1;
          RcVmcRd.rcVmcReadMainProc();
          if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
            if ((await RcMbrCom.rcmbrChkStat() != 0) && (RcMbrCom.rcmbrChkCust())) {
              cMem.ent.errNo = Rcmbrrecal.rcmbrReMbrCal(FuncKey.KY_STL.keyId, RcMbr.RCMBR_WAIT);
              if (cMem.ent.errNo != 0) {
                await RcExt.rcErr("rcKyStl", cMem.ent.errNo);
                return 0;
              }
            }
          }
        }
      }
    }
    if (await RcSysChk.rcChkSapporoPanaSystem() ||
        (await RcSysChk.rcChkJklPanaSystem() && (CmCksys.cmMatugenSystem() == 0))) {
      if ((await RcSysChk.rcQCChkQcashierSystem()) && (RcSysChk.rcChkRewriteCheckerCnct())) {
        erlog = "rcKyStl: Pana[1] Read Skip !!\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);
        atSing.useRwcRw = 0;
      }
      else {
        atSing.useRwcRw = 1;
        RcSapporoPanaCom.rcSapporoPanaReadProc();
      }
    }
    if (await CmCksys.cmRainbowCardSystem() != 0
        || await CmCksys.cmPanaMemberSystem() != 0
        || await CmCksys.cmMoriyaMemberSystem() != 0
        || CmCksys.cmMatugenSystem() != 0) {
      if ((await RcSysChk.rcQCChkQcashierSystem()) && (RcSysChk.rcChkRewriteCheckerCnct())) {
        erlog = "rcKyStl: Pana[2] Read Skip !!\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);
        atSing.useRwcRw = 0;
      }
      else {
        RcSapporoPanaCom.rcSapporoPanaReadProc();
      }
    }
    if (((await RcSysChk.rcChkFelicaSystem()) || (await RcSysChk.rcChkFcfSystem())) &&
        (!RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) && (atSing.felica_tbl.use_sip == 1)) {
      RcFeliCa.rcFeliCaReadProc();
    }
    if (((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)
        || (await RcSysChk.rcCheckQCJCSystem())) &&
        (!await RcSysChk.rcSGChkSelfGateSystem()) &&
        (!await RcSysChk.rcQCChkQcashierSystem()) &&
        (await RcSysChk.rcChkAutoDecisionSystem()) &&
        (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHGCIN.keyId])) &&
        (RxLogCalc.rxCalcStlTaxInAmt(mem) > 0) &&
        (!(await CmCksys.cmReservSystem() != 0 &&
            (!RcFncChk.rcCheckReservMode()) &&
            RcReserv.rcReservItmAdd())) &&
        (cMem.ent.errStat != 1)) {
      //TODO:00004
      //cMem.ent.errNo = await RcAcracb.rcAcrAcbCinReadDtl();
      if (cMem.ent.errNo == IfAcxDef.MSG_ACROK) {
        if ((RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin == 4) &&
            (cMem.acbData.totalPrice == 0)) {
          if (await RcFncChk.rcChkCCINOperation() == true) {
            //TODO:00004
            //await RcKyccin.rcKyChgCin();
          }
        }
        else {
          if (atSing.happySmileStlwaitFlg == 0) {
            //TODO:00004
            //await RcKyccin.rcKyChgCin();
          }
        }
      }
      else {
        if (((AcxCom.ifAcbSelect() & CoinChanger.RT_300_X) != 0) &&
            (RcAcracb.rcChkAcrAcbFullErr(cMem.ent.errNo))) {
          cMem.acbData.acbFullNodisp = 0; //フルエラー非表示制御解除(入金確定開始時はフルであればエラー表示したい)
        }
        if ((RcSysChk.rcsyschkSm66FrestaSystem()) // フレスタ
            && (rcStlExtKyPaymentAutoStlDspChk(stlFirstFlg) != 0)
            && (RckyccinAcb.rcChkChgCinCanDisp())
            && (RcKyExtKey.rcChkKyExtKeyAct() != 0)) { // (とりあえず釣銭機の警告系のエラーであれば)拡張小計プリセットを出しておきたい
          RcKyExtKey.rcKyExtKeyCom(ExtkyType.EXTKY_PAYMENT);
        }
        RcKyccin.ccinErrDialog2("rcKyStl", cMem.ent.errNo, 0);
      }
    }
    // RM-5900の場合、自動で小計押下の場合は釣銭機抑止を解除
    if (cBuf.vtclRm5900RegsOnFlg) {
      cBuf.vtclRm5900RegsStlAcxFlg = 0;
    }
    if (await RcSysChk.rcChkAbsV31System()) {
      if ((await RcSysChk.rcQCChkQcashierSystem()) && (RcSysChk.rcChkRewriteCheckerCnct())) {
        erlog = "rcKyStl: Abs V31 Read Skip !!\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);
        atSing.useRwcRw = 0;
      }
      else {
        RcAbsV31.rcAbsV31ReadProc();
      }
    }
    if ((RcSysChk.rcChkCustrealUIDSystem() != 0) &&
        (tsBuf.custreal2.data.uid.rec.next_rank_name[0] != '\x00') &&
        (mem.tTtllog.t100700.mbrInput != 0) &&
        (tsBuf.custreal2.stat == 0) && (mem.tTtllog.t100001Sts.sptendCnt == 0) &&
        (tsBuf.custreal2.data.uid.rec.next_rank_flg > 0) &&
        (((RxLogCalc.rxCalcStlTaxAmt(mem) != atSing.beforeStlAmt) &&
            (RxLogCalc.rxCalcStlTaxAmt(mem) != 0)) ||
            (RxLogCalc.rxCalcStlTaxAmt(mem) == 0))) {
      mem.tTtllog.t100900.vmcStkhesoacv = 10;
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) && (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) &&
          (RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]))) {
        Rcmbrkymbr.rcwebrealUIDDialogErr(-2, 0, tsBuf.custreal2.data.uid.rec.next_rank_name);
        atSing.beforeStlAmt = RxLogCalc.rxCalcStlTaxAmt(mem);
      }
      else if ((await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) &&
          (RcFncChk.rcCheckRegistration()) &&
          (RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]))) {
        Rcmbrkymbr.rcwebrealUIDDialogErr(-2, 0, tsBuf.custreal2.data.uid.rec.next_rank_name);
        atSing.beforeStlAmt = RxLogCalc.rxCalcStlTaxAmt(mem);
      }
    }
    if (cMem.ent.errNo == 0) {
      if (await RcSysChk.rcCheckItemDetailAuto()) {
        infFlag = 0;
      }
    }
    if ((RcSysChk.rcCheckSignPCtrl()) == 2) {
      RcSignpCtrl.rcSignPCtrlRefund();
    }
    if (((await CmCksys.cmIchiyamaMartSystem() != 0)
        || (await RcSysChk.rcChkBdlMultiSelectSystem()))
        && !(RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
      if (!(cMem.ent.errNo != 0) && (RcFncChk.rcChkErrNon())) {
        RcstlIchiyamaBdlSlct.rcstlIchiyamaBdlslctDispMain();
      }
      else {
        atSing.bdlDspFlg = 1;
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "rcky_stl:rcstl_ichiyam_bdlslct_not disp");
      }
    }
    if ((await CmCksys.cmDs2GodaiSystem() != 0)
        || (await CmCksys.cmWsSystem() != 0)
        || (Rxmbrcom.rxmbrcomPromPurchaseCond() != 0)) {
      rcStlPromotionLogWrite();
    }

    if ((RcSysChk.rcChkMammyMartSystem())
        && (RcSysChk.rcChkTpointSystem() != 0)
        && !(RcMbrCom.rcmbrChkCust())) {
      RcmbrTpointcardChk.rcmbrTpointCardChk();
    }

    if (RcKyQcSelect.rcChkQcSlctExpand() != 0) {  //QC指定を拡大表示するポップアップを表示するかチェック
      RcKyQcSelect.qcSelExpandShow();
    }
    RcAssistMnt.rcAssistSend(24007);
    if (rcStlExtKyPaymentAutoStlDspChk(stlFirstFlg) != 0) { //拡張プリセット表示していない＆拡張プリセット（決済）自動表示設定
      if (!RckyccinAcb.rcChkChgCinCanDisp()) { //入金確定画面表示ができない条件である => 画面が被る可能性があるので拡張プリセットも表示しない
        erlog = "rcKyStl: CanDisp -> ExtKeyAuto Stop\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, erlog);
      }
      else if (RcKyExtKey.rcChkKyExtKeyAct() == 0) {
        erlog = "rcKyStl: rcChk_Ky_ExtKey_Act -> ExtKeyAuto Stop\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, erlog);
      }
      else {
        RckyRegassist.rcGtkTimerRemoveDispKeyAct();
        errNo = RckyRegassist.rcGtkTimerAddDispKeyAct(RcRegs.NORMAL_EVENT, rcStlAutoExtKeyProc(), FuncKey.KY_EXT_PAYMENT.keyId);
        if (errNo != 0) {
          erlog = "rcKyStl: Timer Error !!\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, erlog);
          RckyRegassist.rcGtkTimerRemoveDispKeyAct();
        }
      }
    }

    // RM-3800の場合、小計画面で20g以上の重量を検知したら登録画面に戻る為、重量検知を開始する
    if (cBuf.vtclRm5900RegsOnFlg) {
      Rc59dsp.rc59ScalermWatchStl();
    }

    return 0;
  }

  /// 関連tprxソース: rcky_stl.c - Cash_ClsCncl_Set
  static void cashClsCnclSet() {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    cMem.stat.clsCnclMode = mem.tTtllog.t100002Sts.clsCnclFlg;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcky_stl.c - rcStl_MemberConf3
  static void rcStlMemberConf3() { /* @@@ */
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcky_stl.c - rcStl_HappySmile_MbrScan_Member_Inquiry
  static void	rcStlHappySmileMbrScanMemberInquiry() {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcky_stl.c - rcStl_HappySmile_MbrScan_NotEntry_Popup
  static void	rcStlHappySmileMbrScanNotEntryPopup() {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcky_stl.c - rcStl_Main_Proc
  static void rcStlMainProc() {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcky_stl.c - rcStl_ExtKy_Payment_AutoStlDspChk
  static int rcStlExtKyPaymentAutoStlDspChk(int flg) {
    return 0;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcky_stl.c - rcStl_PromotionLogWrite
  static void rcStlPromotionLogWrite() {
    return ;
  }

  /// TODO:00010 長田 定義のみ追加 引数の調査必要
  /// 関連tprxソース: rcky_stl.c - rcStl_AutoExtKeyProc
  static void rcStlAutoExtKeyProc() {
    return ;
  }

  ///  関連tprxソース: rcky_stl.c - rcChk_OneMix
  static bool rcChkOneMix() {
    RegsMem mem = SystemFunc.readRegsMem();

    for (int i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if (!mem.tItemLog[i].t10002.scrvoidFlg &&
          (mem.tItemLog[i].t10000.realQty != 0) &&
          (mem.tItemLog[i].t10800Sts.bdlTyp == 2)) {
        return true;
      }
    }
    return false;
  }

  /// 関連tprxソース: rcky_stl.c - rcStl_CinDsp_Wait_Chk
  static Future<bool> rcStlCinDspWaitChk() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    //HappySelf<対面セルフ>
    if ((await RcSysChk.rcSysChkHappySmile()) &&
        //次客登録では動作させないため
        (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
        //画面更新設定が0以外
        (QcashierJsonFile().common.cin_dsp_wait != 0) &&
        //更新を止める用の判定フラグが0
        (atSing.happySmileStlwaitFlg == 0) &&
        //happy_smile_stlwait_flgの変更許可
        (atSing.happySmileStlwaitSet == 1) &&
        //登録or小計
        (await RcFncChk.rcCheckItmMode() ||
            await RcFncChk.rcCheckStlMode() ||
            (Rc28dsp.rc28dspCheckInfoSlct()) ||
            (RcFncChk.rcCheckPassportInfoMode() != 0)) &&
        //小計後入金仕様のみ
        (cBuf.dbTrm.timePrcTyp == 1) &&
        //イチヤママートのクーポン利用画面を出すときは無効
        (atSing.fselfOnetimeCouponMode != 1) &&
        // 画面モードを持たない画面を表示していない
        // gtk window系のため、コメントアウト
        // (SystemFunc.readCommonLimitedInput().window == NULL) &&
        //登録or訓練モード
        ((RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) &&
        //次客登録タブからメインタブへの取引移行でない
        (stlwaitSpoolFlg == 0) &&
        //ダイアログ表示中でない
        (TprLibDlg.tprLibDlgCheck() == 0) &&
        //HappySelf<対面セルフ>で会計方法選択画面のボタン押下でない
        (atSing.happySmileCashSelect == 0)) {
      if (RcQcDsp.qCashierIni.cin_dsp_wait == 2) {
        return true;
      } else if (RcQcDsp.qCashierIni.cin_dsp_wait == 1) {
        if (!await RcFncChk.rcChkAcrAcbAfterRegCinStart()) {
          /* 小計後入金仕様として動作しているとき */
          if (!await RcFncChk.rcCheckStlMode()) {
            return true;
          }
        }
      }
    }
    //小計の直接押下のみフラグクリア
    if (RcQcDsp.qCashierIni.cin_dsp_wait == 1 &&
        await RcFncChk.rcCheckStlMode() &&
        atSing.happySmileStlwaitSet == 1) {
      stlwaitClearFlg = 1;
    }
    return false;
  }
}

