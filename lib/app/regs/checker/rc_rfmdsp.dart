/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_28dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_59dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcmbrbuyadd.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/checker/regs.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

/// 関連tprxソース: rc_rfmdsp.c
class RcRfmDsp{
  static int posi = 0;
  static int display = 0;
  static int	totalAmt  = 0;
  static int	outTaxAmt = 0;
  static int	taxAmt    = 0;
  static String	numBuf = '';
  static int	posNo = 0;
  static int	entCalc = 0;
  static String	entryText = '';
  static int	errFlg = 0;
  static int	entCnt = 0;
  static int	stlFlg = 0;
  static int	printFlg = 0;
  static int	setTaxCd = 0;	// 選択した税コード(初期値はターミナル設定)
  static int	winTyp = 0;

  /// Exit event function
  /// 関連tprxソース: rc_rfmdsp.c - rfm_manu_exit
  static Future<void> rfmManuExit() async {
    exitMain();
    RcItmDsp.rcMultiTotalDisp(ImageDefinitions.IMG_RCTFMISSUE);

    //#if SELF_GATE
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_RCTFMISSUE);
      RcItmDsp.rcLcdTotal();
    }
    //#endif

    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      await RcStlLcd.rcDualStlDispChgErea();
    }
  }

  /// 関連tprxソース: rc_rfmdsp.c - exit_main
  static Future<void> exitMain() async {
    posi = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    RcSet.rcClearEntry();
    rcEndKyRfmDsp();

    Rc28dsp.rc28MainWindowSizeChange(0);

    if (cBuf.vtclRm5900RegsOnFlg) {
      Rc59dsp.rc59SKeyExitFnc();
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
        // gtk_widget_destroy(rfm_window);
        await RcSet.rcItmLcdScrMode();
        await RcItmDsp.rcDspEntLCD();
        await RcItmDsp.rcQtyClr();
        break;
      case RcRegs.KY_DUALCSHR:
        // gtk_widget_destroy(rfm_window);
        if (await RcSysChk.rcChkDesktopCashier()) {
          // 対面セルフは登録画面
          await RcSet.rcItmLcdScrMode();
        } else {
          RcStlLcd.rcStlLcdScrModeDualCashier();
        }
        await RcItmDsp.rcDspEntLCD();
        await RcItmDsp.rcQtyClr();
        break;
      case RcRegs.KY_CHECKER:
        if (await RcSysChk.rcCheckQCJCSystem()) {
          // gtk_widget_destroy(rfm_window);
          await RcSet.rcItmLcdScrMode();
          await RcItmDsp.rcDspEntLCD();
          await RcItmDsp.rcQtyClr();
        }
        break;
      case RcRegs.KY_SINGLE:
        if (display == RcMbrBuyAdd.LCDISP2) {
          // gtk_widget_destroy(rfm_window);
          await RcSet.rcItmLcdScrMode();

          if (FbInit.subinitMainSingleSpecialChk() == true) {
            RcItmDsp.dualTSingleDlgClear();
          }

          await RcItmDsp.rcDspEntLCD();
          await RcItmDsp.rcQtyClr();
        } else if (display == RcMbrBuyAdd.SLDISP2) {
          await RcItmDsp.rcDspEntLCD(); /* LCD Display Change */
        }
        break;
    }

    if (await RcSysChk.rcKySelf() == RcRegs.DESKTOPTYPE) {
      cMem.stat.scrMode = cMem.stat.bkScrMode;
      cMem.stat.bkScrMode = 0;
    } else {
      if (display == RcMbrBuyAdd.SLDISP1 || display == RcMbrBuyAdd.SLDISP2) {
        cMem.stat.subScrMode = cMem.stat.bkScrMode;
        cMem.stat.bkScrMode = 0;
      } else {
        cMem.stat.scrMode = cMem.stat.bkScrMode;
        cMem.stat.bkScrMode = 0;
      }
    }
  }

  /// End Rfm dsp
  /// 関連tprxソース: rc_rfmdsp.c - exit_main
  static Future<void> rcEndKyRfmDsp() async {
    String callFunc = 'rcEndKyRfmDsp';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    await RcSet.rcClearDataReg();
    RcSet.rcErr1timeSet();
    await RcSet.cashStatReset2(callFunc);
    RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
    RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_RCTFM.keyId); /* Reset Bit 0 of KY_RCTFM? */
    RcRegs.kyStS3(cMem.keyStat, FncCode.KY_FNAL.keyId); /* Set	Bit 3 of KY_FNAL */
//	if(C_BUF->revenue_exclusion == 1 && (rcKy_Self() != KY_CHECKER)){
    if (cBuf.revenueExclusion == 1 &&
        (await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER ||
            await RcSysChk.rcCheckQCJCSystem())) {
      cBuf.revenueExclusion = 0;
      RegsMem().tTtllog.t100002Sts.revenueExclusionflg2 = 0;
    }
  }

  /// RFM DISPLAY Management Program
  /// 関連tprxソース: rc_rfmdsp.c - rcRfm_Dsp
  static Future<void> rcRfmDsp() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    totalAmt = 0;
    outTaxAmt = 0;
    taxAmt = 0;
    numBuf = '';
    display = 0;
    posi = 0;
    posNo = 0;
    entCalc = 0;
    entryText = '';
    errFlg = 0;
    entCnt = 0;
    stlFlg = 0;
    printFlg = 0;
    setTaxCd = cBuf.dbTrm.manualRfmTaxCd; // 初期値はターミナル設定の値

    if (await RcFncChk.rcCheckStlMode()) {
//		if((rcKy_Self() != KY_DUALCSHR)
//		    || (rcChk_Desktop_Cashier()))
//		{
//			rcStlLcdQuit(&Subttl);
//		}
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE: //rcDspEnt_LCD();
          //rcQty_Clr();
          // TODO:00013 三浦 必要？
          // rcItem_Screen ( );					//登録画面に戻る処理
          // TODO:00013 三浦 必要？
          // gtk_label_set ( GTK_LABEL ( Tran.nm_entry ), " " );	//商品表示欄をクリアする処理
          break;
        case RcRegs.KY_DUALCSHR:
          if (await RcSysChk.rcChkDesktopCashier()) {
            // TODO:00013 三浦 必要？
            // rcItem_Screen ( );					//登録画面に戻る処理
            // TODO:00013 三浦 必要？
            // gtk_label_set ( GTK_LABEL ( Tran.nm_entry ), " " );	//商品表示欄をクリアする処理
          }
          break;
        case RcRegs.KY_CHECKER:
          // TODO:00013 三浦 必要？
          // rcStlLcdQuit ( &Subttl );
          break;
        case RcRegs.KY_SINGLE: //if((I_BUF->DevInf.dev_id == TPRDIDTOUKEY1) ||
          //(I_BUF->DevInf.dev_id == TPRDIDMECKEY1) ) {
          //rcDspEnt_LCD();
          //rcQty_Clr();
          // TODO:00013 三浦 必要？
          // rcItem_Screen ( );
          // TODO:00013 三浦 必要？
          // gtk_label_set ( GTK_LABEL ( Tran.nm_entry ), " " );
          //}
          //else {
          //rcDspEnt_LCD();
          //rcQty_Clr();
          //}
          break;
      }
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        display = RcMbrBuyAdd.LCDISP1;
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "checker DESKTOPTYPE Rfm start");
        // TODO:10138 再発行、領収書対応 UI系なのでコメントアウト
        // rcRfmDsp();
        break;
      case RcRegs.KY_SINGLE:
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "checker KY_SINGLE Rfm start");
        if (FbInit.subinitMainSingleSpecialChk() == true) {
          display = RcMbrBuyAdd.LCDISP2;
          // TODO:10138 再発行、領収書対応 UI系なのでコメントアウト
          // rcRfmDsp();
          await rcLcdMsgDisp();
        }
        break;
      case RcRegs.KY_CHECKER:
        if (await RcSysChk.rcCheckQCJCSystem()) {
          display = RcMbrBuyAdd.LCDISP1;
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "checker KY_CHECKER Rfm start");
          // TODO:10138 再発行、領収書対応 UI系なのでコメントアウト
          // rcRfmDsp();
        }
        break;
    }

    RcSet.rcClearEntry();
    await rcPrgKyRfm();
  }

  /// 10.4 inch not main display is message display
  /// 関連tprxソース: rc_rfmdsp.c - rcLcd_MsgDisp
  static Future<void> rcLcdMsgDisp() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.scrMode == RcRegs.RG_STL ||
        (cMem.stat.scrMode == RcRegs.VD_STL) ||
        (cMem.stat.scrMode == RcRegs.TR_STL) ||
        (cMem.stat.scrMode == RcRegs.SR_STL)) {
      // TODO:00013 三浦 必要？
      // rcStlLcdQuit(&Subttl);
      await rcItemDispLCD();
      await RcSet.rcItmLcdScrMode();
    }
    if (FbInit.subinitMainSingleSpecialChk() == true) {
      cMem.scrData.msgLcd = '';
      cMem.scrData.msgLcd = LRcRfmDsp.RFM_MANEG_MSG.substring(0, 16);

      if (cMem.stat.dualTSingle == 1) {
        // DualT_Single_Dlg((const char *)CMEM->ScrData.msg_lcd, 0);
      } else {
        // DualT_Single_Dlg((const char *)CMEM->ScrData.msg_lcd, 1);
      }
    } else {
      cMem.scrData.msgLcd = '';
      cMem.scrData.msgLcd = LRcRfmDsp.RFM_MANEG_MSG.substring(0, 16);
      await RcItmDsp.rcLcdPrice();
      await RcItmDsp.rcQtyClr();
    }
  }

  /// 関連tprxソース: rc_rfmdsp.c - rcItem_Disp_LCD
  static Future<void> rcItemDispLCD() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcItem_Disp_LCD SELF GATE return !!\n");
      return;
    }

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }

    await RcItmDsp.rcDspEntLCD();
    await RcItmDsp.rcDspQtyLCD();

    if (RcSysChk.rcChkItemDisplayType()) {
      await RcItmDsp.rcDspTtlPrcLCD(RcRegs.OPE_END);
    }

    await RcItmDsp.rcDspSusmkLCD();
    RcItmDsp.rcDspMMmkLCD();

    if (await RegistInitData.presetItemChk()) {
      // TODO:00013 三浦実装必要？
      // RcStlLcd.rcStlLcdItems(&Tran.Item_Subttl);
    }
  }

  /// Mode Rfm Set
  /// 関連tprxソース: rc_rfmdsp.c - rcPrg_Ky_Rfm
  static Future<void> rcPrgKyRfm() async {
    RxInputBuf iBuf = RxInputBuf();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        await RcSet.rcRfmScrMode();
        break;
      case RcRegs.KY_CHECKER:
        if (await RcSysChk.rcCheckQCJCSystem()) {
          await RcSet.rcRfmScrMode();
        }
        break;
      case RcRegs.KY_SINGLE:
        if ((iBuf.devInf.devId == TprDidDef.TPRDIDTOUKEY1) ||
            (iBuf.devInf.devId == TprDidDef.TPRDIDMECKEY1)) {
          await RcSet.rcRfmSubScrMode();
        } else {
          await RcSet.rcRfmScrMode();
        }
        break;
    }
  }
}

/// 関連tprxソース: l_rc_rfmdsp.h
class LRcRfmDsp{
  /// Define Image Data
  static const INTAX_BTN = '税込合計';
  static const OUTTAX_BTN = '税抜金額';
  static const TAX_BTN = '税額';
  static const INPUT_BTN = '入力';
  static const PRINT_BTN = '発行';
  static const EXIT_BTN = '終了';
  static const RFM_MANEG_MSG = '領収書発行処理中';
  static const SELECT_BTN = '税率\n選択';
}
