/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_ajsemoney.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_tmp.dart';
import '../../inc/apl/rxmemcogca.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxmemsptend.dart';
import '../../inc/apl/rxmemvaluecard.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/db/c_ttllog_sts.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stllcd.dart';
import 'rc_28dsp.dart';
import 'rc_itm_dsp.dart';
import 'rc_key_tab.dart';
import 'rc_lastcomm.dart';
import 'rc_mbr_com.dart';
import 'rc_set.dart';
import 'rc_tab.dart';
import 'rc_trk_preca.dart';
import 'rcfncchk.dart';
import 'rcstlfip.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

/// 関連tprxソース: rcky_preca_remove.c
class RcKyPrecaRemove {
  /// プリカ宣言取消 2nd処理
  /// 関連tprxソース: rcky_preca_remove.c - rcClr_2nd_PRECA_CLR
  static Future<void> rcClr2ndPrecaClr() async {
    _rcClrPrecaData();
    await RcItmDsp.rcDspMbrmkLCD();					/* MEMBER MAKE LCD CLEAR */
    await RcItmDsp.dualTSingleCshrDspClr();

    if (await RcFncChk.rcCheckStlMode()) {
      _rcStlDspPrecaClr();
    }

    AcMem cMem = SystemFunc.readAcMem();
    RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_PRECA_CLR.keyId);  /* Reset Bit 1 of KY_PRECA_CLR	*/

    if ((await RcFncChk.rcCheckOtherRegistration() == 0)  /*「プリカ宣言」以外登録中状態がない */
        && (RcMbrCom.rcmbrChkCust() == 0) ) {
      cMem.postReg = PostReg();
      RcRegs.kyStR1(cMem.keyStat, FncCode.KY_REG.keyId);  /* Reset Bit 1 of KY_REG	*/
    }

    await RcSet.rcClearKyItem();  /* Set Bit 3 of KY_FNAL		*/

    if ((await RcSysChk.rcChk2800System())
        && (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
      RcKyTab.rcCounterDataChange();
      if (await RcFncChk.rcCheckStlMode()) {
        Rc28dsp.rcTabCounterStlDataSet(RcKyTab.tabInfo.dspTab, RegsDef.subttl);
        Rc28dsp.rcTabDataStlDisplay(RcKyTab.tabInfo.dspTab,  RegsDef.subttl, TabDef.DATA_DSP);
      }
      else {
        Rc28dsp.rcTabCounterDataSet(RcKyTab.tabInfo.dspTab);
        Rc28dsp.rcTabDataDisplay(RcKyTab.tabInfo.dspTab);
      }
      if (FbInit.subinitMainSingleSpecialChk()) {
        Rc28dsp.rcTabDataStlDisplay(RcKyTab.tabInfo.dspTab,  RegsDef.dualSubttl, TabDef.DATA_DSP);
      }
    }

    RegsMem mem = SystemFunc.readRegsMem();

    if ((mem.tTtllog.t100001Sts.itemlogCnt == 0)
        && !RcFncChk.rcCheckRegistration()) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
        await RcSet.cashStatReset2("RcKyPrc.rcClr2ndPrecaClr()");
      }
      else if ((CmCksys.cmFbDualSystem() == 2)
          && (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER)) {
        await RcSet.rcClearDualChkReg( );
      }
    }

    AtSingl atSing = SystemFunc.readAtSingl();

    if (await RcSysChk.rcChkEntryPrecaTyp() != 0) {
      if (mem.tTtllog.calcData.suspendFlg == 1) {
        atSing.limitAmount = 0;
        atSing.mbrCdBkup = "";
        mem.tmpbuf.autoCallReceiptNo = 0;
        mem.tmpbuf.autoCallMacNo = 0;
      }
      if ((mem.tmpbuf.autoCallReceiptNo != 0)
          && (mem.tmpbuf.autoCallMacNo == 0)) {
        mem.tmpbuf.autoCallReceiptNo = 0;
      }
    }

    /* プリカ宣言マークを消去するため再表示 */
    RcTrkPreca.rcSusRegEtcRedisp();
  }

  /// プリカ宣言取消 プリカ関連情報の消去
  /// 関連tprxソース: rcky_preca_remove.c - rcClr_PrecaData
  static Future<void> _rcClrPrecaData() async {
    String callFunc = "RcKyPrc._rcClr_PrecaData()";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemPtr() error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    RegsMem mem = SystemFunc.readRegsMem();
    if (await CmCksys.cmCogcaSystem() != 0) {
      mem.tmpbuf.workInType = 0;
      mem.tmpbuf.cogcaCard = RxMemCogcaCard();
      mem.cogcaRxData = RxMemCogcaRx();
      mem.precaBalance = 0;
      mem.precaSptendQcFlg = 0;
      mem.precaCardreadQcFlg = 0;
      if (Rxkoptcmncom.rxChkKoptPrecaInBalancePrintWithNoPrecaPayment(cBuf) == 1) {
        // 印字用バッファクリア
        mem.tTtllog.t100902Sts = T100902Sts();
      }
      mem.tmpbuf.cogcaBrfBal = RxMemCogcaBfrBal();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: CoGCa Data clear");
    }

    if (RcRegs.rcInfoMem.rcRecog.recogRepicaSystem != 0) {
      mem.tmpbuf.workInType = 0;
      mem.tmpbuf.repica.card = RxMemRepicaCard();
      mem.tmpbuf.repica.rxData = RxMemRepicaRx();
      mem.precaBalance = 0;
      mem.precaSptendQcFlg = 0;
      mem.precaCardreadQcFlg = 0;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: Repica Data clear");
    }
    if (RcRegs.rcInfoMem.rcRecog.recogValuecardSystem != 0) {
      mem.tmpbuf.workInType = 0;
      mem.tmpbuf.valueCard.card = RxMemValueCardCard();
      mem.tmpbuf.valueCard.rxData = RxMemValueCardRx();
      mem.precaBalance = 0;
      mem.precaSptendQcFlg = 0;
      mem.precaCardreadQcFlg = 0;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: Valuecard Data clear");
    }
    if (RcSysChk.rcChkFIPEmoneyStandardSystem()) {
      // FIP標準仕様
      mem.tmpbuf.workInType = 0;
      mem.tmpbuf.ajsEmoneyCard = RxMemAjsEmoneyCard();
      mem.tmpbuf.ajsEmoneyRxData = RxMemAjsEmoneyRx();
      mem.precaBalance = 0;
      mem.precaSptendQcFlg = 0;
      mem.precaCardreadQcFlg = 0;
      /* 印字用バッファクリア */
      mem.prnrBuf.ajsEmoneyPrn =AjsEmoneyPrn();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: FIP Data clear");
    }

    // 置数プリカ仕様の場合、一時格納用スプリット情報をクリア
    if (await RcSysChk.rcChkEntryPrecaTyp != 0) {
      mem.tempSptend = List.generate(RX_LASTCOMM_PAYKIND.LCOM_MAX.index, (_) => RxMemTempSptend());
    }
  }

  /// プリカ宣言取消
  /// 関連tprxソース: rcky_preca_remove.c - rcStlDsp_PrecaClr
  static Future<void> _rcStlDspPrecaClr() async {
    int wCtrl = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if ((cMem.stat.scrMode == RcRegs.RG_ITM)
        || (cMem.stat.scrMode == RcRegs.VD_ITM)
        || (cMem.stat.scrMode == RcRegs.TR_ITM)) {
      wCtrl = RcStlLcd.FSTLLCD_RESET_ITEMINDEX;
    }
    else {
      wCtrl = RcStlLcd.FSTLLCD_NOT_LCDINIT;
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        RcStFip.rcStlFip(RcRegs.FIP_NO1);
        RcStlLcd.rcStlLcd(wCtrl, RegsDef.subttl);
        if (await RcSysChk.rcChk2800System()) {
          Rc28StlLcd.rc28StlLcdChange(ChangePart.CT_CLEAR.index, RegsDef.subttl);
        }
        break;
      case RcRegs.KY_CHECKER:
        RcStFip.rcStlFip(RcRegs.FIP_NO2);
        RcStlLcd.rcStlLcd(wCtrl, RegsDef.subttl);
        if (await RcSysChk.rcChk2800System()) {
          Rc28StlLcd.rc28StlLcdChange(ChangePart.CT_CLEAR.index, RegsDef.subttl);
        }
        break;
      case RcRegs.KY_SINGLE:
        RcStFip.rcStlFip(RcRegs.FIP_NO1);
        RcStFip.rcStlFip(RcRegs.FIP_NO2);
        RcStlLcd.rcStlLcd(wCtrl, RegsDef.subttl);
        if (await RcSysChk.rcChk2800System()) {
          Rc28StlLcd.rc28StlLcdChange(ChangePart.CT_CLEAR.index, RegsDef.subttl);
        }
        break;
      default:
        break;
    }
  }
}