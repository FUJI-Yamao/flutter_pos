/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/lib/cm_ary/chk_spc.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/rxtbl_buff_keyopt.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/upd_util.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/cm_chg/bcdtol.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import '../inc/rc_if.dart';
import 'rc_acracb.dart';
import 'rc_auto.dart';
import 'rc_clxos_pick.dart';
import 'rc_ewdsp.dart';
import 'rc_ext.dart';
import 'rc_flrda.dart';
import 'rc_ifprint.dart';
import 'rc_inout.dart';
import 'rc_itm_dsp.dart';
import 'rc_recno.dart';
import 'rc_set.dart';
import 'rc_setdate.dart';
import 'rc_stl.dart';
import 'rc_usbcam1.dart';
import 'rcky_cin.dart';
import 'rcky_rpr.dart';
import 'rcfncchk.dart';
import 'rcsyschk.dart';
import 'rcinoutdsp.dart';

///  関連tprxソース: rckypick.c.c
class RcKyPick {
/*----------------------------------------------------------------------*
 * Constant Values
 *----------------------------------------------------------------------*/
  static List<int> lumpPick0 = [
    FncCode.KY_REG.keyId,
    FncCode.KY_ENT.keyId,
    FuncKey.KY_MAN.keyId,
    FuncKey.KY_SEN.keyId,
    FuncKey.KY_5SEN.keyId,
    0
  ];
  static const List<int> lumpPick1 = [0];
  static const List<int> lumpPick2 = [0];
  static const List<int> lumpPick3 = [0];
  static const List<int> lumpPick4 = [0];
  static List<int> diffPick0 = [
    FncCode.KY_REG.keyId,
    FncCode.KY_ENT.keyId,
    FuncKey.KY_PLU.keyId,
    0
  ];
  static const List<int> diffPick1 = [0];
  static const List<int> diffPick2 = [0];
  static const List<int> diffPick3 = [0];
  static const List<int> diffPick4 = [0];

  static KoptinoutBuff koptInOut = KoptinoutBuff();
  static InOutInfo inOut = InOutInfo();
  ///  関連tprxソース: rckypick.c - rcKyPick
  static Future<void> rcKyPick() async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.errNo = await rcCheckKyPick(0);
    RegsMem regsMem = RegsMem();
    if( !(cMem.ent.errNo != 0) ) {
      // 売上回収を行った場合のＵＳＢカメラのスタート
      if (await RcSysChk.rcQCChkQcashierSystem())
      {
        RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
        RcUsbCam1.rcUsbcamStartStop(UsbCamStat.QC_CAM_START.index, 0);
      }

      await RcFlrda.rcReadKoptinout(cMem.stat.fncCode, koptInOut);
      if((koptInOut.frcSelectFlg == 1) ||
         (inOut.drwchkPickDisplay != 0) ) {
         cMem.ent.errNo = await rcKyDifferentPick();
       } else {
         cMem.ent.errNo = await _rcKyLumpPick();
       }
    }
    if(cMem.ent.errNo != 0) {
      await RcExt.rcErr('rcKyPick',cMem.ent.errNo);
      /* 自動開閉設動作中 */
      if( (CmCksys.cmAutoStropnclsSystem() != 0) && (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) ) {
        if( (await RcFncChk.rcCheckItmMode()) || (await RcFncChk.rcCheckStlMode()) ) {
           RcAuto.rcAutoStrOpnClsFuncErrStop(cMem.ent.errNo);  /* エラー発生の為、自動化中止 */
        }
      }
    }
  }

  ///chkCtrlFlg : 0以外で特定のチェック処理を除外する
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  ///  関連tprxソース: rckypick.c - rcCheck_Ky_Pick
  static Future<int> rcCheckKyPick(int chkCtrlFlg) async {
    int ret;

    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) && (!await RcSysChk.rcCheckQCJCSystem())) {
      return (DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId);
    }

    AcMem cMem = SystemFunc.readAcMem();
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    List<int> p = [];
    int i;
    p = lumpPick0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb,i); i++; }
    p = lumpPick1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb,i); i++; }
    p = lumpPick2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb,i); i++; }
    p = lumpPick3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb,i); i++; }
    p = lumpPick4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb,i); i++; }
    p = diffPick0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb,i); i++; }
    p = diffPick1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb,i); i++; }
    p = diffPick2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb,i); i++; }
    p = diffPick3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb,i); i++; }
    p = diffPick4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb,i); i++; }
    ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return (RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret));
    }
    return(Typ.OK);
  }

/*----------------------------------------------------------------------*
 * KY_PICK Lump Management Program
 *----------------------------------------------------------------------*/
  ///  関連tprxソース: rckypick.c - rcKy_LumpPick
  static Future<int> _rcKyLumpPick() async {
    inOut = InOutInfo();

    rcChkLumpPick(0);
    int errNo = await rcPrgLumpPick();
    return(errNo);
  }

  ///chkCtrlFlg : 0以外で特定のチェック処理を除外する
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  ///  関連tprxソース: rckypick.c - rcChk_LumpPick
  static int rcChkLumpPick(int chkCtrlFlg) {
    int ret;
    AcMem cMem = SystemFunc.readAcMem();

    if(! (cMem.ent.tencnt != 0)) { /* Input ? */
       return(DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    }
    if((cMem.ent.tencnt > 8) ||
       (cMem.ent.tencnt > koptInOut.digit)) { /* Put on Over ? */
       return(DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
    }
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    List<int> p = [];
    int i;
    p = lumpPick0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb,i); i++; }
    p = lumpPick1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb,i); i++; }
    p = lumpPick2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb,i); i++; }
    p = lumpPick3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb,i); i++; }
    p = lumpPick4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb,i); i++; }
    ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return (RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret));
    }
    return(Typ.OK);
  }

  ///  関連tprxソース: rckypick.c - rcPrg_LumpPick
  static Future<int> rcPrgLumpPick() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    if(await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) { /* Coin/Bill-Changer ON ?*/
       if(koptInOut.acbDrwFlg != 0) { // 釣銭機使用時のドロア  0:禁止 1:有効
          await RcIfPrint.rcDrwopen(); // Drawer Open !!
          cMem.stat.clkStatus |= RcIf.OPEN_DRW;
          RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
          taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
       }
       else{
          cMem.stat.clkStatus &= ~RcIf.OPEN_DRW;
       }
    }
    else{
       await RcIfPrint.rcDrwopen(); // Drawer Open !!
       cMem.stat.clkStatus |= RcIf.OPEN_DRW;
       RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
       taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
    }
    await RcExt.cashStatSet("rcPrgLumpPick");
    tsBuf.cash.inout_flg = 1;
    await rcPrcLumpPick();
    return(await rcEndLumpPick());
  }

  ///  関連tprxソース: rckypick.c - rcPrc_LumpPick
  static  Future<void> rcPrcLumpPick() async {
    List<int> entry = List.filled(4, 0);
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem regsMem = SystemFunc.readRegsMem();

    rcEditKeyData();
    entry = cMem.ent.entry.sublist(6);

    inOut.Pdata.TotalPrice = regsMem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt;

    cMem.scrData.price = inOut.Pdata.TotalPrice;
    RcSet.rcClearEntry();
  }

  ///  関連tprxソース: rckypick.c - rcEnd_LumpPick
  static Future<int> rcEndLumpPick() async {
    int errNo = Typ.OK;
    int errNo2 = Typ.OK;
    int errStat = 0;
    String callFunc = 'rcEndLumpPick';
    RegsMem regsMem = SystemFunc.readRegsMem();

    AtSingl atSingle = SystemFunc.readAtSingl();

    if(regsMem.tTtllog.t100001.qty != 0) {
       switch(await RcSysChk.rcKySelf()) {
         case RcRegs.DESKTOPTYPE :
         case RcRegs.KY_DUALCSHR :
         case RcRegs.KY_CHECKER  :
         case RcRegs.KY_SINGLE   :
            await RcItmDsp.rcQtyClr();
            break;
         }
    }
    await RckyCin.rcInputTotalDsp();
    await rcUpdateLumpPick();
    errNo = await RcFncChk.rcChkRPrinter();
    if (errNo != Typ.OK) {
        errNo2 = RcIfEvent.rcSendUpdate();
        if(errNo2 == Typ.OK) {
          await RcRecno.rcIncRctJnlNo(true);
        } else {
          await ReptEjConf.rcErr("rcEndLumpPick", errNo);
          errNo = Typ.OK;
        }
        await rcEndKyPick(errNo);
     } else {
        atSingle.rctChkCnt = 0;
        await RcExt.rxChkModeSet("rcEndLumpPick");

        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if (xRet.isInvalid()) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "_rcPrgKyDrawChk rxMemRead error");
          return Typ.NG;
        }
        RxCommonBuf pCom = xRet.object;

        CalcResultPay retData = await RcClxosPick.rcPick(pCom, koptInOut.frcSelectFlg);
        errNo = retData.retSts!;
        if (0 != retData.retSts) {
          await ReptEjConf.rcErr("rcEndLumpPick", errNo);
          errNo = Typ.OK;
          errStat = 1;
        } else {
          // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
          await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
        }
        errNo2 = RcIfEvent.rcSendUpdate();
        if ((errNo != 0) || (errNo2 != 0)) {
          await rcEndKyPick(errNo);
          await RcExt.rxChkModeReset("rcEndLumpPick");
        } else {
          RckyRpr.rcWaitResponce(inOut.fncCode);
        }

     }
     return(errNo);
  }

  ///  関連tprxソース: rckypick.c - rcUpdate_LumpPick
  static Future<void> rcUpdateLumpPick() async {
     await rcUpdateLumpEdit();
     if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
       await RcAcracb.rcAcrAcbStockUpdate(1);
     }
  }

  ///  関連tprxソース: rckypick.c - rcUpdate_LumpEdit
  static Future<void> rcUpdateLumpEdit() async {
    CBillKind cCinSht = CBillKind();
    RegsMem regsMem = SystemFunc.readRegsMem();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;

    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); // Ttl Buffer All Clear
    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_PICK_FLAG; // PICK flag
    regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_PICK.index;

    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
    regsMem.tTtllog.t105100.pickCd = inOut.fncCode;
    regsMem.tTtllog.t105100Sts.chgInoutAmt = inOut.Pdata.TotalPrice;

    await rcUpdateDiffEditPick();

    await Rcinoutdsp.rcInOutLumpAmtSetCmn(1, koptInOut, inOut.Pdata.TotalPrice, 0);

    if (CompileFlag.DEPARTMENT_STORE) {
      if(regsMem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_REG) {
        regsMem.tTtllog.calcData.card1timeAmt = 845;
      } else if(regsMem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) {
        regsMem.tTtllog.calcData.card1timeAmt = 2845;
      }
    }
  }

/*----------------------------------------------------------------------*
 * KY_PICK Different Management Program
 *----------------------------------------------------------------------*/
  ///  関連tprxソース: rckypick.c - rcKy_DifferentPick
  static Future<int> rcKyDifferentPick() async {
    int errNo;

    errNo = await rcChkDifferentPick(0);
    if (errNo == 0) {
      AcMem cMem = SystemFunc.readAcMem();
      if ((!await RcFncChk.rcCheckStlMode()) && (!RcFncChk.rcCheckSItmMode() && (!(await RcSysChk.rcSGChkSelfGateSystem()))) ) {
         if (!ChkSpc.cmChkSpc(cMem.scrData.subibuf, cMem.scrData.subibuf.length)) {
           await RcItmDsp.rcDspQtyLCD();
           await RcItmDsp.rcDspEntLCD();
           await RcItmDsp.rcQtyClr();
         }
      }
      errNo = await rcPrgDifferentPick();
   }
   return(errNo);
}

  ///  関連tprxソース: rckypick.c - rcChk_DifferentPick
  /// chkCctrlFflg : 0以外で特定のチェック処理を除外する
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  static Future<int> rcChkDifferentPick(int chkCctrlFflg) async{
     int ret;
     AcMem cMem = SystemFunc.readAcMem();
     AtSingl atSingle = SystemFunc.readAtSingl();

     if((! RcRegs.kyStC0(cMem.keyStat[cMem.stat.fncCode])) &&
        (RcRegs.kyStC0(cMem.keyStat[FncCode.KY_ENT.keyId]))               ) {
        return(DlgConfirmMsgKind.MSG_OPEERR.dlgId);
     }
     if (await RcSysChk.rcCheckPrimeStat() == RcRegs.PRIMETOWER) {
        if(atSingle.inputbuf.no == DevIn.KEY1) {
          return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
        }
     }
     cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
     List<int> p = [];
     int i;
     p = diffPick0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb,i); i++; }
     p = diffPick1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb,i); i++; }
     p = diffPick2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb,i); i++; }
     p = diffPick3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb,i); i++; }
     p = diffPick4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb,i); i++; }
     ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
     if (ret != 0) {
       return (RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret));
     }
     return(Typ.OK);

  }

  ///  関連tprxソース: rckypick.c - rcPrg_DifferentPick
  static Future<int> rcPrgDifferentPick() async {
    int errNo = Typ.OK;

    await rcStartDifferentPick();
    await Rcinoutdsp.rcInOutDifferentDisp(Inout_Disp_Type.INOUT_DISP_NOMAL);
    return(errNo);
  }

  ///  関連tprxソース: rckypick.c - rcStart_DifferentPick
  static Future<void> rcStartDifferentPick() async {
    int  drwFlg = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return ;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    if(await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) { /* Coin/Bill-Changer ON ?*/
       if(koptInOut.acbDrwFlg != 0) { // 釣銭機使用時のドロア  0:禁止 1:有効
         if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
           drwFlg = 1;
         } else {
           await RcIfPrint.rcDrwopen(); // Drawer Open !!
           cMem.stat.clkStatus |= RcIf.OPEN_DRW;
           RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
           taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
         }
       } else {
         cMem.stat.clkStatus &= ~RcIf.OPEN_DRW;
       }
    } else{
      if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
        drwFlg = 1;
      } else {
         await RcIfPrint.rcDrwopen(); // Drawer Open !!
         cMem.stat.clkStatus |= RcIf.OPEN_DRW;
         RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
         taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
      }
    }
    await RcExt.cashStatSet("rcPrgLumpPick");
    tsBuf.cash.inout_flg = 1;
    rcEditKeyData();
    inOut.drwOpen = drwFlg;

    if (((cMem.keyStat.length) >= inOut.fncCode) && (inOut.fncCode >= 0)) {    /* FORTIFY */
      RcRegs.kyStS0(cMem.keyStat,inOut.fncCode); /* Set Bit 0 of KY_PICK? */
    }
    /* Reset Bit 0 of KY_OUT? */
    RcRegs.kyStS3(cMem.keyStat,FncCode.KY_FNAL.keyId);  /* Set Bit 0 of KY_REG */
  }

  ///  関連tprxソース: rckypick.c - rcEnd_DifferentPick
  static Future<(int, int)> rcEndDifferentPick(int step) async {
    int errNo = Typ.OK;
    int errNo2 = Typ.OK;
    int printFlg = 1;
    String callFunc = 'rcEndDifferentPick';

    step = 0;

    Rcinoutdsp.rcCalDifferentTtl();

    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingle = SystemFunc.readAtSingl();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
    }
    RxCommonBuf cBuf = xRetC.object;

    if((cMem.scrData.price == 0) && (! Rcinoutdsp.rcChkInOutEntryData())) {
      return (DlgConfirmMsgKind.MSG_TRC_TTL_ZERO.dlgId, step);
    }
    if (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) {
      await RckyCin.rcInputTotalDsp();
    }
    if((inOut.fncCode == FuncKey.KY_PICK.keyId) && (AplLibAuto.strCls(await RcSysChk.getTid()) != 0)) {
      printFlg = await AplLibAuto.strOpnClsSetChk(await RcSysChk.getTid(), StrOpnClsCodeList.STRCLS_PICK_PRINT);
    }
    rcUpdateDiffPick();

    step = 1; //これ以降、エラー発生後も入出金画面は消去

    if(printFlg != 0) {
      errNo = await RcFncChk.rcChkRPrinter();
    }
    if (errNo != Typ.OK) {
      errNo2 = rcChkKopttranUpdateDiff();
      if (errNo2 == Typ.OK) {
        await RcRecno.rcIncRctJnlNo(true);
      } else {
        await ReptEjConf.rcErr("rcEndDifferentPick", errNo);
        errNo = Typ.OK;
      }
      rcEndKyPick(errNo);
    } else {
      atSingle.rctChkCnt = 0;
      await RcExt.rxChkModeSet("rcEndDifferentPick");
      if(printFlg != 0) {
        //クラウドPOS
        CalcResultPay retData = await RcClxosPick.rcPick(cBuf,  koptInOut.frcSelectFlg);
        errNo = retData.retSts!;
        if (0 != errNo) {
          await ReptEjConf.rcErr("rcEndDifferentCin", errNo);
          errNo = Typ.OK;
        } else {
          // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
          await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
        }
      }
      errNo2 = rcChkKopttranUpdateDiff();
      if (errNo2 == Typ.OK) {
        await RcRecno.rcIncRctJnlNo(true);
      } else {
        await ReptEjConf.rcErr("rcEndDifferentPick", errNo2);
        errNo = Typ.OK;
      }
      if ((errNo != Typ.OK) || (errNo2 != Typ.OK)) {
        rcEndKyPick(errNo);
        if (errNo == Typ.OK) {
          await RcExt.rxChkModeReset("rcEndDifferentPick");
        }
      } else {
        if(printFlg != 0) {
          atSingle.noPrintFlg = 1;
        }
         RckyRpr.rcWaitResponce(inOut.fncCode);
      }
    }
    return (errNo, step);
  }

  ///  関連tprxソース: rckypick.c - rcUpdate_DiffPick
  static Future<void> rcUpdateDiffPick() async {
    await rcUpdateDiffEdit();
    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      await RcAcracb.rcAcrAcbStockUpdate(1);
    }
  }

  ///  関連tprxソース: rckypick.c - rcUpdate_DiffEdit
  static Future<void> rcUpdateDiffEdit() async {
    RegsMem regsMem = SystemFunc.readRegsMem();

    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); // Ttl Buffer All Clear
    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_PICK_FLAG; // PICK flag
    regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_PICK.index;
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();

    //回収実績(t105100)
    regsMem.tTtllog.t105100.pickCd          = inOut.fncCode;
    regsMem.tTtllog.t105100Sts.chgInoutAmt  = inOut.Pdata.TotalPrice;
    regsMem.tTtllog.t105100Sts.mny10000Sht  = inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count;
    regsMem.tTtllog.t105100Sts.mny5000Sht   = inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count;
    regsMem.tTtllog.t105100Sts.mny2000Sht   = inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count;
    regsMem.tTtllog.t105100Sts.mny1000Sht   = inOut.InOutBtn[InoutDisp.INOUT_Y1000].Count;
    regsMem.tTtllog.t105100Sts.mny500Sht    = inOut.InOutBtn[InoutDisp.INOUT_Y500].Count;
    regsMem.tTtllog.t105100Sts.mny100Sht    = inOut.InOutBtn[InoutDisp.INOUT_Y100].Count;
    regsMem.tTtllog.t105100Sts.mny50Sht     = inOut.InOutBtn[InoutDisp.INOUT_Y50].Count;
    regsMem.tTtllog.t105100Sts.mny10Sht     = inOut.InOutBtn[InoutDisp.INOUT_Y10].Count;
    regsMem.tTtllog.t105100Sts.mny5Sht      = inOut.InOutBtn[InoutDisp.INOUT_Y5].Count;
    regsMem.tTtllog.t105100Sts.mny1Sht      = inOut.InOutBtn[InoutDisp.INOUT_Y1].Count;

    await rcUpdateDiffEditPick();

    regsMem.tTtllog.t105100.sht10000  = regsMem.tTtllog.t105100Sts.mny10000Sht;
    regsMem.tTtllog.t105100.sht5000   = regsMem.tTtllog.t105100Sts.mny5000Sht;
    regsMem.tTtllog.t105100.sht2000   = regsMem.tTtllog.t105100Sts.mny2000Sht;
    regsMem.tTtllog.t105100.sht1000   = regsMem.tTtllog.t105100Sts.mny1000Sht;
    regsMem.tTtllog.t105100.sht500    = regsMem.tTtllog.t105100Sts.mny500Sht;
    regsMem.tTtllog.t105100.sht100    = regsMem.tTtllog.t105100Sts.mny100Sht;
    regsMem.tTtllog.t105100.sht50     = regsMem.tTtllog.t105100Sts.mny50Sht;
    regsMem.tTtllog.t105100.sht10     = regsMem.tTtllog.t105100Sts.mny10Sht;
    regsMem.tTtllog.t105100.sht5      = regsMem.tTtllog.t105100Sts.mny5Sht;
    regsMem.tTtllog.t105100.sht1      = regsMem.tTtllog.t105100Sts.mny1Sht;

    //在高実績
    await Rcinoutdsp.rcInOutDiffAmtSetCmn(1, koptInOut, 0, 0);

    if (CompileFlag.DEPARTMENT_STORE) {
      if(regsMem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_REG) {
         regsMem.tTtllog.calcData.card1timeAmt = 845;
      } else if(regsMem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) {
         regsMem.tTtllog.calcData.card1timeAmt = 2845;
      }
    }
  }

  ///  関連tprxソース: rckypick.c - rcUpdate_DiffEdit_Pick
  static Future<void> rcUpdateDiffEditPick() async {
    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tTtllog.t105100.pickCnt = 1;
    regsMem.tTtllog.t105100.pickAmt = regsMem.tTtllog.t105100Sts.chgInoutAmt;
    if(RcInOut.inOutClose.closePickFlg == 1) {  //従業員精算
      regsMem.tTtllog.t105100.closeFlg = 1;
    }
  }

/*----------------------------------------------------------------------*
 * KY_PICK Management Functions
 *----------------------------------------------------------------------*/
  ///  関連tprxソース: rckypick.c - rcEdit_KeyData
  static void rcEditKeyData()
  {
    int  i;
    List<InOutSave> saveData = List<InOutSave>.generate(InoutDisp.INOUT_DIF_MAX, (index) => InOutSave());
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem regsMem = SystemFunc.readRegsMem();

    if(regsMem.tTtllog.t105100Sts.drwchkPickFlg == 1){
      for(i = 0; i < InoutDisp.INOUT_DIF_MAX; i++)  
      {
        saveData[i].Count = inOut.SaveData[i].Count;
        saveData[i].Amount = inOut.SaveData[i].Amount;
        saveData[i].AcrData = inOut.SaveData[i].AcrData;
      }
    }
    inOut = InOutInfo();
    if(regsMem.tTtllog.t105100Sts.drwchkPickFlg == 1){
      for(i = 0; i < InoutDisp.INOUT_DIF_MAX; i++)
      {
        inOut.SaveData[i].Count = saveData[i].Count;
        inOut.SaveData[i].Amount = saveData[i].Amount;
        inOut.SaveData[i].AcrData = saveData[i].AcrData;
      }
    }
    inOut.fncCode = cMem.stat.fncCode; 
  }

  ///  関連tprxソース: rckypick.c - rcInputTotalDisp
  static Future<void> rcInputTotalDisp() async {
    await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_PICK.keyId);
  }

  ///  関連tprxソース: rckypick.c - rcEnd_Ky_Pick
  static Future<void> rcEndKyPick(int errNo) async {
    tprDlgParam_t param = tprDlgParam_t();
    String    title;

    if((inOut.fncCode == FuncKey.KY_PICK.keyId) && (errNo != 0)){
      await RcExt.rxChkModeSet('rcEndKyPick');
      if( AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0 ) {
        RcAuto.rcAutoChkDlg( await RcSysChk.getTid() , Typ.OFF, errNo );
      }

      return; 
    }
  }

  ///  関連tprxソース: rckypick.c - rcChk_kopttran_Update_Diff
  static int rcChkKopttranUpdateDiff() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return -1;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA1.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha1.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha1.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA2.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha2.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha2.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA3.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha3.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha3.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA4.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha4.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha4.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA5.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha5.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha5.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA6.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha6.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha6.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA7.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha7.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha7.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA8.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha8.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha8.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA9.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha9.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha9.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA10.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha10.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha10.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHK1.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtChk1.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtChk1.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHK2.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtChk2.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtChk2.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHK3.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtChk3.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtChk3.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHK4.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtChk4.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtChk4.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHK5.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtChk5.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtChk5.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA11.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha11.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha11.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA12.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha12.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha12.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA13.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha13.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha13.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA14.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha14.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha14.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA15.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha15.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha15.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA16.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha16.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha16.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA17.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha17.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha17.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA18.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha18.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha18.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA19.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha19.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha19.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA20.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha20.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha20.index].drwAmt = 0;
    }


    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA21.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha21.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha21.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA22.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha22.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha22.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA23.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha23.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha23.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA24.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha24.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha24.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA25.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha25.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha25.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA26.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha26.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha26.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA27.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha27.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha27.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA28.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha28.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha28.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA29.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha29.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha29.index].drwAmt = 0;
    }

    if (Rxkoptcmncom.rxChkKoptChaChkTranUpdate(cBuf, FuncKey.KY_CHA30.keyId) !=
        0) {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt =
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt +
              mem.tTtllog.t100200[AmtKind.amtCha30.index].drwAmt;
      mem.tTtllog.t100200[AmtKind.amtCha30.index].drwAmt = 0;
    }

    return RcIfEvent.rcSendUpdate();
  }
}