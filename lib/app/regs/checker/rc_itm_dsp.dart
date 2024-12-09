/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/fb/fb_init.dart';
import 'package:flutter_pos/app/inc/sys/tpr_type.dart';
import 'package:flutter_pos/app/regs/checker/rc28addparts.dart';
import 'package:flutter_pos/app/regs/checker/rc28itmdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_key_cash.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl_cal.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/AplLib_EucAdjust.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/apllib/apllib_strutf.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../common/rxmbrcom.dart';
import '../inc/L_rckyedyno.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28addparts.dart';
import 'rc28itmdsp.dart';
import 'rc28stlinfo.dart';
import 'rc_28dsp.dart';
import 'rc_key_cash.dart';
import 'rc_mbr_com.dart';
import 'rc_qc_dsp.dart';
import 'rc_rfmdsp.dart';
import 'rc_set.dart';
import 'rc_signp_ctrl.dart';
import 'rcqr_com.dart';
import 'rc_stl_cal.dart';
import 'rcfncchk.dart';
import 'rcky_mul.dart';
import 'rcqr_com.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';
import 'regs_preset_def.dart';

class RcItmDsp {

  // static AtSingl atSingl = AtSingl();
  // static SubttlInfo subttl = SubttlInfo();
  // static TranInfo Tran = TranInfo();
  // static int	qc_sound_off_flg = 0;

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcitmdsp.c - rcFip_Proc_Start
  static void rcFipProcStart(int saveFlg) {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcitmdsp.c - rcHalfMsg_Destroy
  static void rcHalfMsgDestroy(int stat) {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcitmdsp.c - rc_dual_conf_destroy
  static void rcDualConfDestroy() {
    return;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  static void rcEntryOutPut() {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rcitmdsp.c - rc_dual_conf
  static void rcDualConf(String text) {
    return;
  }

  ///関連tprxソース: rcitmdsp.c - rcMulti_TotalDisp
  static Future<void> rcMultiTotalDisp(int imgNo) async {
    AcMem cMem = SystemFunc.readAcMem();
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    //#if SELF_GATE
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      return;
    }
    //#endif
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }
    if ((await RcFncChk.rcCheckStlMode()) || (RcFncChk.rcCheckSItmMode())) {
      // TODO:00013 三浦 後回し（重め）
      //rcItem_Screen();
    }
    // AplLibImgRead.aplLibImgRead(imgNo, cMem.scrData.msg_lcd, 16);
    EucAdj adj = AplLibImgRead.aplLibImgRead(imgNo);

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        rcLcdTotal();
        rcMultiFip(RcRegs.FIP_NO1);
        break;
      case RcRegs.KY_CHECKER:
        rcLcdTotal();
        rcMultiFip(RcRegs.FIP_NO2);
        break;
      case RcRegs.KY_SINGLE:
        rcLcdTotal();
        rcMultiFip(RcRegs.FIP_NO1);
        rcMultiFip(RcRegs.FIP_NO2);
        break;
    }
  }

  /// Item Total Display Process
  ///関連tprxソース: rcitmdsp.c - rcLcdTotal
  static Future<void> rcLcdTotal() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    // TODO:00013 三浦 後回し（重め）
    // rc28LcdTotal();
    return;
  }

  /// FIP Cncl Key Buffer Set and Display Process
  ///関連tprxソース: rcitmdsp.c - rcMulti_Fip
  static void rcMultiFip(int fipNo) {
    // TODO:00013 三浦 後回し（重め）
    // rcMulti_Fip_DualDsktop(fip_no, 0);
  }

  /// LCD Item Entry Buffer Set and Display Process
  ///関連tprxソース: rcitmdsp.c - rcDspEnt_LCD
  static Future<void> rcDspEntLCD() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    // TODO:00013 三浦 実装必要？
    // rcDspEnt_28LCD();
    return;
  }

  ///関連tprxソース: rcitmdsp.c - rcQty_Clr
  static Future<void> rcQtyClr() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28ItmDsp.rcQty28Clr();
    return;
  }

  ///関連tprxソース: rcitmdsp.c - DualT_Single_DlgClear
  static void dualTSingleDlgClear(){
    String log = '';

  // GtkWidget系なのでコメントアウト
  // if((DualT_Single_Dlg_MainW != NULL)	||
  // (DualT_Single_Dlg_HBKW != NULL))
  // {
  // memset(log, 0x00, sizeof(log));
  // snprintf(log, sizeof(log), "DualT_Single_Dlg Destroy[%p][%p]", DualT_Single_Dlg_HBKW, DualT_Single_Dlg_MainW);
  // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 1, log);
  // }
  // if(DualT_Single_Dlg_MainW != NULL)
  // gtk_widget_destroy(DualT_Single_Dlg_MainW);
  // if(DualT_Single_Dlg_HBKW != NULL)
  // gtk_widget_destroy(DualT_Single_Dlg_HBKW);
  //
  // DualT_Single_Dlg_MainW = NULL;
  // DualT_Single_Dlg_HBKW = NULL;
    return;
  }

  /// LCD Item Quantity Buffer Set and Display Process
  ///関連tprxソース: rcitmdsp.c - rcDspQty_LCD
  static Future<void> rcDspQtyLCD() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    // TODO:00013 三浦 必要？
    // rcDspQty_28LCD();
    return;
  }

  /// Set and Display Process LCD Total Amount Buffer
  /// 関連tprxソース: rcitmdsp.c - rcDspTtlPrc_LCD
  static Future<void> rcDspTtlPrcLCD(int operationChk) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    // TODO:00013 三浦 必要？
    // rcDspTtlPrc_28LCD(operation_chk, 0, NULL, 0);
    return;
  }

  /// 関連tprxソース: rcitmdsp.c - rcDspSusmk_LCD
  static Future<void> rcDspSusmkLCD() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      return;
    }

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }

    // TODO:00013 三浦 必要？
    // rcDspSusmk_28LCD();
    return;
  }

  /// 関連tprxソース: rcitmdsp.c - rcDspMMmk_LCD
  static void rcDspMMmkLCD() {
    rcDspMixmkLCD(-1);
  }

  /// 関連tprxソース: rcitmdsp.c - rcDspMixmk_LCD
  static void rcDspMixmkLCD(int p) {
    // TODO:00013 三浦 必要？
   // rcDspMixmk_28LCD(p);
    return;
  }

  /// LCD/FIP Key Image Display Process
  /// 関連tprxソース: rcitmdsp.c - rcLcd_Price
  static Future<void> rcLcdPrice() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }

    // TODO:00013 三浦 必要？
    // rc28Lcd_Price();
    return;
  }

  /// 関連tprxソース: rcitmdsp.c - preset_Item_Dsp
  static Future<void> presetItemDsp() async {
    if (CompileFlag.BDL_PER) {
      AcMem cMem = SystemFunc.readAcMem();
      if (await RckyMul.rcChkKyMulBusyIchiyama(cMem.working.dataReg.kMul1)) {
        return;
      }
    }
    if ((await RegistInitData.presetItemBaseChk()) ||
        (await RcFncChk.rcCheckItmMode()) ) {
      RcStlCal.dualTSingleItmrbpClear();
      AtSingl atSing = SystemFunc.readAtSingl();
      RcStlLcd.rcStlLcdSetPage(atSing.tStlLcdItem.pageMax);
      await Rc28StlInfo.rcStlLcd28SetDispStatus(atSing.tStlLcdItem.itemMax);
      RcStlLcd.rcStlLcdItems(RegsDef.tran.itemSubTtl);
      // 会員購買レベルアイコンなどの描画
      Rc28dsp.rcMbrInfoIconDisp(0, null, 0);
    }
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 関連tprxソース: rcitmdsp.c - DualT_Single_CshrTendChgClr
  static void dualTSingleCshrTendChgClr() {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 会員呼出時のFIP表示
  /// 関連tprxソース: rcitmdsp.c - rcmbrDsp_FIP
  static void rcmbrDspFIP(int fipNo) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 関連tprxソース: rcitmdsp.c - rcFipCnclKey
  static void rcFipCnclKey(int fipNo) {}

  /// 関連tprxソース: rcitmdsp.c - rcMark_KyDisplay
  static Future<void> rcMarkKyDisplay(int dspFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (CompileFlag.IC_CONNECT) {
      if (!((cBuf.dbTrm.dispRefOpeWord != 0) ||
          (await CmCksys.cmJremMultiSystem() != 0))) {
        return;
      }
    } else {
      if (cBuf.dbTrm.dispRefOpeWord == 0) {
        return;
      }
    }
    if ((await RcFncChk.rcCheckESVoidMode()) ||
        (await RcFncChk.rcCheckESVoidSMode()) ||
        (await RcFncChk.rcCheckESVoidIMode()) ||
        (await RcFncChk.rcCheckESVoidVMode()) ||
        (await RcFncChk.rcCheckESVoidSDMode()) ||
        (await RcFncChk.rcCheckESVoidCMode())) {
      return;
    }
    if ((await RcFncChk.rcCheckERefMode()) ||
        (await RcFncChk.rcCheckERefSMode()) ||
        (await RcFncChk.rcCheckERefIMode()) ||
        (await RcFncChk.rcCheckERefSMode())) {
      return;
    }
    if (await RcSysChk.rcCheckOutSider()) {  /* for wiz */
      return;
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
        if (FbInit.subinitMainSingleSpecialChk()) {
          await RcStlLcd.rcStlLcdSusReg(RegsDef.dualSubttl);
          await RcStlLcd.rcStlLcdMMReg(RegsDef.dualSubttl);
          Rc28StlInfo.rc28StlLcdHomeDlv(RegsDef.dualSubttl);
          Rc28StlInfo.rc28StlLcdCarry(RegsDef.dualSubttl);
          Rc28StlInfo.rc28StlLcdSuicaTrans(RegsDef.dualSubttl);
        }
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        await rcDspSusmkLCD();
        if (dspFlg == 1) {
          rcDspMMmkLCD();
        }
        if (await RcFncChk.rcCheckStlMode()) {
          await RcStlLcd.rcStlLcdSusReg(RegsDef.subttl);
          await RcStlLcd.rcStlLcdMMReg(RegsDef.subttl);
          Rc28StlInfo.rc28StlLcdHomeDlv(RegsDef.subttl);
          Rc28StlInfo.rc28StlLcdCarry(RegsDef.subttl);
          Rc28StlInfo.rc28StlLcdSuicaTrans(RegsDef.subttl);
        }
        break;
      default:
        break;
    }
  }

  /// 関連tprxソース: rcitmdsp.c - rcmbrDsp_LCD
  static void rcmbrDspLCD() {
    Rc28ItmDsp.rcmbrDsp28Lcd();
  }

  /// 関連tprxソース: rcitmdsp.c - rcEdit_MbrName
  static Future<void> rcEditMbrName() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    String mbrName = Rxmbrcom.rcmbrGetMbrFullName(mem);
    EucAdj adj = EucAdj();

    cMem.scrData.nameLcd = "";
    if (cBuf.dbTrm.seikatsuclubOpe != 0) {
      adj = await AplLibEucAdjust.aplLibEucAdjustSize(mbrName, mbrName.length, 18);
      if (adj.count < 17) {
        int tmpInt = 0;
        String tmpStr = "";
        (tmpInt, tmpStr) = AplLibStrUtf.aplLibEucCopy(mem.tTtllog.t100011.errcd, (18-adj.count-1));
        mbrName += " $tmpStr";
      }
    }

    bool result = mbrName.isNotEmpty;
    if (result) {
      result = mem.tTtllog.t100700.mbrNameKanji1.contains(" ");
    }
    if (result) {
      cMem.scrData.nameLcd = mbrName;
    } else {
      if (CompileFlag.POINT_CARD) {
        result = ((cBuf.dbTrm.otherStoreMbrDsp == 1) &&
            (mem.tTtllog.t100700.otherStoreMbr == 1) &&
            (mem.tTtllog.t100700.mbrInput != MbrInputType.pcardmngKeyInput) &&
            (mem.tTtllog.t100700.mbrInput != MbrInputType.pcarduseKeyInput));
      } else {
        result = ((cBuf.dbTrm.otherStoreMbrDsp == 1) &&
            (mem.tTtllog.t100700.otherStoreMbr == 1));
      }
      if (result) {
        if (await RcSysChk.rcChkEdyNoMbrSystem()) {
          cMem.scrData.nameLcd = LRckyEdyNo.EDYNO_UNREGIMBR;
        } else {
          adj = AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_OTHER_MEMBER);
          //adj = AplLib_ImgRead((long)IMG_OTHER_MEMBER, mbr_name, 18);
          cMem.scrData.nameLcd = mbrName;
        }
      } else {
        cMem.scrData.nameLcd = mem.tTtllog.t100011.errcd;
      }
    }
    if (cBuf.dbTrm.mbrNameDsp == 1) {
      cMem.scrData.nameLcd = "";
    }
  }

  /// 関連tprxソース: rcitmdsp.c - rcMbr_Display
  static Future<void> rcMbrDisplay() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        if (RcFncChk.rcSGCheckMntMode()) {
          await rcEditMbrName();
          rcmbrDspLCD();             /* 顧客名 & ポイント表示(10.4LCD) */
        }
        return;
      }
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if ((mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput) ||
        ((await CmCksys.cmNimocaPointSystem() != 0) &&
            (mem.tTtllog.t100700.mbrInput == MbrInputType.nimocaInput))) { /* 会員売価キーのときはマークだけを表示するように */
      await rcDspMbrmkLCD();
      return;
    }

    await rcEditMbrName();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        rcmbrDspLCD();  /* 顧客名 & ポイント表示(10.4LCD) */
        break;
      default:
        break;
    }
  }

  /// 関連tprxソース: rcitmdsp.c - rcDspClrmk_LCD
  static Future<void> rcDspClrmkLCD() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        return;
      }
    }
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }
    Rc28ItmDsp.rcDspClrmk28Lcd();
  }

  ///関連tprxソース: rcitmdsp.c - rcInOut_TotalDisp()
  static Future<void> rcInOutTotalDisp(int img_no) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    dualTSingleCshrDspClr();
    if((await RcFncChk.rcCheckStlMode()) || (await RcFncChk .rcCheckSItmMode())) {
      // rcItem_Screen(); 登録画面に戻る
    }
    //AcMem CMEM = SystemFunc.readAcMem();
    AplLibImgRead.aplLibImgRead(img_no); //, CMEM.scrData.msgLcd, INOUT_DIF_IMG_MAX);
    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER  : rcLcdTotal();
        break;
      case RcRegs.KY_DUALCSHR :
        if (await RcSysChk.rcCheckQCJCSystem())
        {
          rcLcdTotal();
        }
        else
        {
          if (await RcSysChk.rcChkDesktopCashier())
          {
            rcLcdTotal();
          }
          else
          {
            await RcStlLcd.rcDualStlDispChgErea();	// 登録画面から小計画面へ戻す処理
          }
        }
        break;
      case RcRegs.KY_SINGLE   : rcLcdTotal();
        // TODO:
        // rcTabCounter_DataSet(Tab_Info.dsp_tab);
        // rcTabData_Display(Tab_Info.dsp_tab);
        // rcTabCounter_StlDataSet(Tab_Info.dsp_tab, &Dual_Subttl);
        // rcTabData_StlDisplay(Tab_Info.dsp_tab, &Dual_Subttl, DATA_DSP);
        // if (rcmbrChkStat()) {
        //   rcmbrClearModeDisp();
        // }
        break;
      default:
        break;
    }
  }

  /// タワータイプ1人制キャッシャー機の表示をクリアする
  /// 関連tprxソース: rcitmdsp.c - DualT_Single_CshrDspClr()
  static Future<void> dualTSingleCshrDspClr() async {
    if (CompileFlag.SELF_S_STAFF || CompileFlag.SELF_GATE) {
      if(await RcSysChk.rcSGChkSelfGateSystem()) {
        return;
      }
    }
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }

    if(await RcFncChk.rcCheckCashRecycleMode()) {
      return;
    }

    if(FbInit.subinitMainSingleSpecialChk()) {
      // DualT_Single_Itmrbp_Clear();
      // //		rcStlItemCalc_Main(STLCALC_INC_MBRRBT);
      // rcStlLcd_Totalizers(FSTLLCD_RESET_ITEMINDEX, &Dual_Subttl);
      // rcStlLcd_SetPage(AT_SING->tStlLcdItem.PageMax);
      // rcStlLcd_28SetDispStatus(AT_SING->tStlLcdItem.ItemMax);
      // rcStlLcd_Items(&Dual_Subttl);
      // rcStlLcd_MbrInfo(&Dual_Subttl);
      // rcStlLcd_RevReg(&Dual_Subttl);
      // if( C_BUF->db_trm.rwt_prn_mbrfile != 0 ) {
      //   rcStlLcd_Person(&Dual_Subttl);
      // }
      // if (CompileFlag.RESERV_SYSTEM) {
      //   rc_ReservInfoDspClr(&Dual_Subttl);
      // }
    }
    if (CompileFlag.PRESET_ITEM) {
      //preset_Item_Dsp();
    }
  }

  /// LCD/FIP Item Screen Mode Display
  /// 関連tprxソース: rcitmdsp.c - rcItem_Screen
  static Future<void> rcItemScreen() async {
    TprTID tid = await RcSysChk.getTid();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    if (await RcSysChk.rcCheckOutSider()) {
      return;
    } else if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    } else if (! Dummy.rcCheckScnMbrMode()) {
      switch(await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE :
        case RcRegs.KY_CHECKER  :
        case RcRegs.KY_DUALCSHR :
          if (await RcSet.rcItmLcdScrMode()) {
            return;
          }
          break;
        case RcRegs.KY_SINGLE   :
          if(await RcSet.rcItmLcdScrMode()) {
            return;
          }
          break;
      }
    }

    AtSingl atSing = SystemFunc.readAtSingl();
    if (atSing.happyDisplayCalcPostGuidance != 0) {
      atSing.happyDisplayCalcPostGuidance = 0;
      TprLog().logAdd(tid, LogLevelDefine.normal, "rcItem_Screen : happyDisplayCalcPostGuidance [${atSing.happyDisplayCalcPostGuidance}]");
    }

    Dummy.rcRegsretTimerRemove(1);
    Dummy.rcReverseBtnProc();
    Dummy.rcPresetBtnFirst();

    switch(await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE :
        RcStlLcd.rcStlLcdQuit(RegsDef.subttl);
        RcRfmDsp.rcItemDispLCD();
        Dummy.chkDisplayTimeOffline();
        Dummy.rcItemDispFIP(FIP_NO1);
        break;

      case RcRegs.KY_CHECKER  :
        RcStlLcd.rcStlLcdQuit(RegsDef.subttl);
        RcRfmDsp.rcItemDispLCD();
        Dummy.chkDisplayTimeOffline();
        Dummy.rcItemDispFIP(FIP_NO2);
        break;

      case RcRegs.KY_SINGLE   :
        RcStlLcd.rcStlLcdQuit(RegsDef.subttl);
        RcRfmDsp.rcItemDispLCD();
        Dummy.chkDisplayTimeOffline();
        Dummy.rcItemDispFIP(FIP_BOTH);
        break;

      case RcRegs.KY_DUALCSHR :
        RcStlLcd.rcStlLcdQuit(RegsDef.subttl);
        RcRfmDsp.rcItemDispLCD();
        Dummy.chkDisplayTimeOffline();
        if (await RcSysChk.rcChkDesktopCashier()) {
          Dummy.rcItemDispFIP(FIP_NO1);
        }
        break;

      default:
        break;
    }

    // RM-3800の場合、レシートON/OFF状態を表示している
    if (cBuf.vtclRm5900RegsOnFlg) {
      Dummy.rc59RctOnOffDsp(null);
      if (CmCksys.cmChkRm5900FloatingSystem() != 0) {
        Dummy.rc59FloatingPresetRefresh();
      }
    }

    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    RxTaskStatBuf pStat = xtRet.object;

    // 顧客情報欄表示処理
    if (((
        ((await RcMbrCom.rcmbrChkStat() != 0) && (RcMbrCom.rcmbrChkCust() != 0))
          || (mem.tTtllog.t100700Sts.outsideRbt != 0)
          || (mem.tTtllog.t100700Sts.mbrprcFlg != 0)
          || ((await CmCksys.cmSpecialCouponSystem() != 0) && (mem.tTtllog.t100001Sts.cardForgotFlg != 0))
          || ((RcSysChk.rcsyschkRpointSystem() != 0) && (Rxmbrcom.rxmbrcomChkRpointRead(mem)))
          || ((RcSysChk.rcsyschkTpointSystem()) && (Dummy.rxmbrcomChkTpointRead(mem))))
         && (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])))
        || (pStat.suica.transFlg != 0)
        || (Dummy.rcMultiSuicaMarkChk())) {

      Dummy.rcDspMbrmkLCD();

    } else {
      if ((await RcMbrCom.rcmbrChkStat() != 0) && (await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE)) {
        RegsDef.tran.itemMark = "";
    		Dummy.rc28MbrClearDisp(RegsDef.tran.mbrParts);
    		Dummy.rcCustMsgDsp(0, null);
    		Dummy.rcMbrInfoIconDisp(0, null, 1);
      } else {
        Dummy.rcmbrClearModeDisp();
      }
    }

    if (await (RcSysChk.rcKySelf()) == RcRegs.KY_DUALCSHR) {
      rcDspSusmkLCD();
      rcDspMMmkLCD();
    }
    if (mem.tmpbuf.manualMixcd != 0) {
      Dummy.rcDspManualMMCntLCD(1);
    }
    if (((await CmCksys.cmRainbowCardSystem()) != 0) && (cMem.stat.disburseFlg != 0)) {
      Dummy.rckyDisburseConf();
    } else if (Dummy.rckySelPluAdjSelctMode()) {
      Dummy.rckySelpluadjConf();
    }

    cMem.stat.clkStatus &= ~RcIf.OPEN_DRW;              /* Drawer Open Flag OFF  */
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_STL.keyId);  /* clear Calc. SubTotal */

    /* 通番訂正 現金支払い開始ボタンを削除 */
    Dummy.rc28dspRcptBtnDestroy(RegsDef.subttl);

    if ( ((RcSysChk.rcCheckSignPCtrl()) == 2) && (await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ) {
      RcSignpCtrl.rcSignPCtrlRefund();
    }

    if (( ! RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId])) && (RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId]))) {
      if (await RcSysChk.rcChkAcrAcbCinLcd()) {
        RcqrCom.rcQcLeDAllOff(QcLedNo.QC_LED_ALL.index);
      }
    }

    Dummy.rcModeFrameDisp( FRAME_DISP_FLG );

    if (atSing.happySmileStlwaitFlg != 0) {
      atSing.happySmileStlwaitFlg = 0;
      TprLog().logAdd(tid, LogLevelDefine.normal, "rcItem_Screen : happySmileStlwaitFlg set[0]");

      Rc28AddParts.rc28GuidanceMsgBoxTextSet();

      RcQcDsp.qcSoundOffFlg = 0;
      Rc28StlInfo.colorFipWindowDestroy();
      if (ReptEjConf.rcCheckRegistration()) {
        Rc28StlInfo.colorFipWindowCreate(null, 1);
      } else {
        Rc28StlInfo.colorFipWindowCreate(null, 0);
      }
    }

    if (atSing.paygrpTwice != 0) {
      atSing.paygrpTwice = 0;  // ドリルダウン情報を初期化 登録画面戻り時
      TprLog().logAdd(tid, LogLevelDefine.normal, "rcItem_Screen : paygrp_twice set[0]");
    }

    if (Dummy.rcCheckScanDlg()) {
      Dummy.rcScanLayEnable();
    }
  }

  /// 関連tprxソース: rcitmdsp.c - rc_Dualhalf_Default
  /// TODO:00010 長田 定義のみ追加
  static void rcDualhalfDefault() {
    return;
  }

  // TODO:00016 佐藤 定義のみ追加
  ///関連tprxソース: rcitmdsp.c - DualT_Single_Dlg_HW()
  static void dualTSingleDlgHW(String msg, int devId, int hwFlg) {}

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  ///関連tprxソース: rcitmdsp.c - DualT_Single_Dlg
  static void DualTSingleDlg(String msg, int devId) {
    return;
  }

  // TODO:00016 佐藤 定義のみ追加
  ///関連tprxソース: rcitmdsp.c - rc_CustMsgDsp
  static void rcCustMsgDsp(int flg, SubttlInfo subTtl) {
  }

  // TODO:00016 佐藤 定義のみ追加
  ///関連tprxソース: rcitmdsp.c - rc_CustMsg_StlDestroy
  static void rcCustMsgStlDestroy(SubttlInfo subttl) {
  }
  ///関連tprxソース: rcitmdsp.c - rcDspManualMMCnt_LCD()
  static void rcDspManualMMCntLCD(int dspflg) {
    Rc28ItmDsp.rcDspManualMMCnt28LCD(dspflg);
    return;
  }
  
  ///関連tprxソース: rcitmdsp.c - rcDspMbrmk_LCD()
  static Future<void> rcDspMbrmkLCD() async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    // TODO:00013 三浦 必要？
    // rcDspMbrmk_28LCD();
    return;
  }

  // TODO:00016 佐藤 定義のみ追加
  ///関連tprxソース: rcitmdsp.c - rcItem_Disp_FIP
  static void rcItemDispFIP(String fipNo) {
  }

  ///関連tprxソース: rcitmdsp.c - DualT_Single_DlgChake
  static int dualTSingleDlgChake() {
    // if (DualT_Single_Dlg_MainW != null) {
    //   return 1;
    // } else {
    //   return 0;
    // }
    return 0;
  }

  ///関連tprxソース: rcitmdsp.c - rcQC_EntDsp_Entry
  static Future<void> rcQCEntDspEntry() async {
    int cnt = 0;
    int digit = 0;
    String buf = '';
    CmEditCtrl fCtrl = CmEditCtrl();
    int bytes = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if (!RcFncChk.rcQCCheckPassWardDspMode() &&
        !RcFncChk.rcQCCheckMenteDspMode() &&
        !RcFncChk.rcQCCheckPrePaidEntryDspMode() &&
        (!(await RcSysChk.rcChkShopAndGoSystem() &&
            RcFncChk.rcQCCheckItemDspMode())) &&
        !RcFncChk.rcQCCheckMenteDspMode()) {
      return;
    }

    fCtrl.SeparatorEdit = 2;
    cMem.scrData.entry = cMem.ent.entry;

    if (RcFncChk.rcQCCheckPassWardDspMode()) {
      digit = cMem.ent.tencnt;
      for (cnt = 0; cnt < digit; cnt++) {
        buf = "$buf*";
      }

      // TODO:10164 自動閉設 UI系の為保留
      // cm_spc((char *)&QC_PassWdDsp.qc_passent, sizeof(QC_PassWdDsp.qc_passent));
      // cm_mov((char *)&QC_PassWdDsp.qc_passent[3], (char *)SG_PASSWORD, strlen(SG_PASSWORD));
      // cm_mov((char *)&QC_PassWdDsp.qc_passent[35-digit], (char *)buf, strlen(buf));
      // QC_PassWdDsp.qc_passent[35] = 0x00;
      // gtk_round_entry_set_text(GTK_ROUND_ENTRY(QC_PassWdDsp.ent_entry), QC_PassWdDsp.qc_passent);
    } else if (RcFncChk.rcQCCheckMenteDspMode()) {
      buf = '';
      digit = cMem.ent.tencnt;
      if (cMem.ent.tencnt > 16) {
        fCtrl.SeparatorEdit = 0;
      }

      // TODO:10164 自動閉設 UI系の為保留
      // cm_spc((char *)&QC_MenteDsp.qc_mente_ent, sizeof(QC_MenteDsp.qc_mente_ent));
      // cm_Edit_Bcd_utf(fCtrl, QC_MenteDsp.qc_mente_ent, sizeof(QC_MenteDsp.qc_mente_ent), 40, (uchar *)cMem.ent.entry, sizeof(cMem.ent.entry), 20, &bytes);
      // QC_MenteDsp.qc_mente_ent[bytes] = 0x00;
      // gtk_round_entry_set_text(GTK_ROUND_ENTRY(QC_MenteDsp.ent_entry), QC_MenteDsp.qc_mente_ent);
    } else if (await RcSysChk.rcChkShopAndGoSystem() &&
        RcFncChk.rcQCCheckItemDspMode()) {
      buf = '';
      digit = cMem.ent.tencnt;
      if (cMem.ent.tencnt > 16) {
        fCtrl.SeparatorEdit = 0;
      }

      // TODO:10164 自動閉設 UI系の為保留
      // cm_spc((char *)&QCItemDsp.qc_item_mente_ent, sizeof(QCItemDsp.qc_item_mente_ent));
      // cm_Edit_Bcd(fCtrl, (char *)&QCItemDsp.qc_item_mente_ent[39], sizeof(QCItemDsp.qc_item_mente_ent),
      // cMem.ent.entry, sizeof(cMem.ent.entry), 20);
      // QCItemDsp.qc_item_mente_ent[40] = 0x00;
      // rcQC_SAG_Item_Mente_Info( QC_SAG_ITEM_MENTE_INFO_ENTRY );
    } else if (RcFncChk.rcQCCheckPrePaidEntryDspMode()) {
      RcQcDsp.rcQCPrecaEntryDspEntry();
    }

    cMem.scrData.entry = List.generate(10, (_) => 0);
  }
}