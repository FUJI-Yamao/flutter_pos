/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_28dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracbdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_advancein.dart';
import 'package:flutter_pos/app/regs/checker/rc_assist_mnt.dart';
import 'package:flutter_pos/app/regs/checker/rc_auto.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_changer.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_obr.dart';
import 'package:flutter_pos/app/regs/checker/rc_recno.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rc_sgdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcdetect.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcinoutdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcky_clr.dart';
import 'package:flutter_pos/app/regs/checker/rcky_plu.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rpr.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/checker/rcsg_com.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../fb/fb_lib.dart';
import '../../fb/fb_style.dart';
import '../../inc/apl/image.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../acx/rc_acx.dart';
import '../inc/L_rckycref.dart';
import '../../lib/if_tkey/if_tkey_mclick.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'liblary.dart';

enum CRefEntry {
  CREF_HOLDER_TOTAL,
  CREF_HOLDER_Y10000,
  CREF_HOLDER_Y5000,
  CREF_HOLDER_Y2000,
  CREF_HOLDER_Y1000,
  CREF_HOLDER_Y500,
  CREF_HOLDER_Y100,
  CREF_HOLDER_Y50,
  CREF_HOLDER_Y10,
  CREF_HOLDER_Y5,
  CREF_HOLDER_Y1,
  CREF_OVERFL_TOTAL,
  CREF_OVERFL_Y10000,
  CREF_OVERFL_Y5000,
  CREF_OVERFL_Y2000,
  CREF_OVERFL_Y1000,
  CREF_OVERFL_Y500,
  CREF_OVERFL_Y100,
  CREF_OVERFL_Y50,
  CREF_OVERFL_Y10,
  CREF_OVERFL_Y5,
  CREF_OVERFL_Y1,
  CREF_ENTRY_MAX,
}

enum CrefNowDisp {
  CREF_DSP_NON,
  CREF_DSP_COIN,
  CREF_DSP_BILL,
  CREF_DSP_COIN_BOX,
}

enum CrefDispType {
  CREF_DSPTYP_NON, //表示なし
  CREF_DSPTYP_SHEET, //枚数、状態表示
  CREF_DSPTYP_PRICE, //金額
  CREF_DSPTYP_OFF, //未接続
  CREF_DSPTYP_OTHER, //特殊（在高不確定等）
}

///  関連tprxソース: rckycref.c
class RcKyCRef {
  static int printAct = Typ.OFF;   /* 印字中フラグ  OFF:印字無し ON:印字中 */
  static int chgDrwSystem = 0;
  static Object? winCRefAcb;
  static Object? winDualCRefAcb;
  static AdvanceIn advInDsp = AdvanceIn();

  static int KANJI16 = 16;
  static int KANJI24 = 24;
  static int KANJI32 = 32;
  static int KANJINO = 0;

  static String CREF_END = '終了';
  static String CREF_BILL = '紙幣';
  static String CREF_COIN = '硬貨';
  static String CREF_BOX = '金庫';
  static String CREF_BOX_TB1 = '棒金';
  static String CREF_CHG = '筒';
  static String CREF_CHG_TB1 = '収納';
  static String CREF_PRINT = '印字';
  static String CREF_YEN = '円';
  static String CREF_SHEET = '%s枚';
  static String CREF_FULL = ' 満 ';
  static String CREF_EMPTY = ' 空 ';
  static String CREF_FEW = ' 少 ';
  static String CREF_SPC = '    ';
  static String CREF_FULL2 = '満';
  static String CREF_EMPTY2 = '空';
  static String CREF_FEW2 = '少';
  static String CREF_SPC2 = '  ';
  static String CREF_STOCK = '釣機在高不確定';
  static String CREF_ACR_BOX_TTL = '硬貨金庫合計額';
  static String CREF_ACRACB_BOX_TTL = '金庫合計金額';
  static String CREF_NON_CNCT = '未接続';

  static String CHANGE_STATUS_EMPTY = '釣切れ';
  static String CHANGE_STATUS_NEAREND = '釣不足';
  static String CHANGE_STATUS_NEARFULL = '釣過剰';

  static Object? winDualCrefAcb;

  static get cbill_data => null;

  ///  関連tprxソース: rckycref.c - rcKyChgRef
  static Future<void> rcKyChgRef() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        Rcinoutdsp.rcSGKeyImageTextMake(FuncKey.KY_CHGREF.keyId);
        if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
          await ReptEjConf.rcErr("rcKyChgRef", DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          /* 自動開閉設動作中 */
          if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
            RcAuto.rcAutoStrOpnClsFuncErrStop(
                DlgConfirmMsgKind.MSG_OPEERR.dlgId); /* エラー発生の為、自動化中止 */
          }
          return;
        }
      }
    }

    cMem.ent.errNo = await rcChkKeyChgRef();
    if (cMem.ent.errNo == Typ.OK) {
      cMem.ent.errNo = await rcChkChgRefAcrAcb();
      if (cMem.ent.errNo == Typ.OK) {
        await RcExt.cashStatSet("rcKyChgRef");
        if (CompileFlag.SELF_GATE) {
          switch (await RcSysChk.rcKySelf()) {
            case RcRegs.DESKTOPTYPE:
            case RcRegs.KY_DUALCSHR:
            case RcRegs.KY_CHECKER:
            case RcRegs.KY_SINGLE:
              await RcSet.rcChgRefScrMode();
              break;
          }
        }
        await rcPrcKeyChgRef();
      } else {
        await RcKyccin.ccinErrDialog2("rcKyChgRef", cMem.ent.errNo, 0);
        /* 自動開閉設動作中 */
        if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
          await RcAuto.rcAutoStrOpnClsFuncErrStop(
              cMem.ent.errNo); /* エラー発生の為、自動化中止 */
        }
        return;
      }
    } else {
      await rcEndKeyChgRef();
    }
  }

  ///  関連tprxソース: rckycref.c - rcChk_Key_ChgRef
  static Future<int> rcChkKeyChgRef() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcAcracb.rcCheckAcrAcbON(1) == 0) {  /* Not ACRorACB System ? */
      return RcAcracb.rcCheckAcrAcbOFFType(0);
    }
    if (RcSysChk.rcChkTRDrwAcxNotUse()) {
      return DlgConfirmMsgKind
          .MSG_TR_ACX_NOTUSE.dlgId; //練習モードでの釣銭機「禁止」に設定されています
    }
    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        (!await RcSysChk.rcCheckQCJCSystem())) {
      return DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId;
    }
    Liblary.cmFil(cMem.keyChkb, 0xFF, cMem.keyChkb.length);
    if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO1 + RcRegs.MACRO3) != 0) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if (RcDetect.rcChkFinalProcessing()) {
      return DlgConfirmMsgKind.MSG_WAIT.dlgId;
    }
    errNo = await RcAcracb.rcAcrAcbAnswerReadDtl();
    if (errNo != Typ.OK) {
      return errNo;
    }
    return Typ.OK;
  }

  ///  関連tprxソース: rckycref.c - rcChk_ChgRef_AcrAcb
  static Future<int> rcChkChgRefAcrAcb() async {
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) {
      errNo = await RcAcracb.rcAcrAcbAnswerReadDtl();
      if ((errNo == DlgConfirmMsgKind.MSG_CHARGING.dlgId) ||
          (errNo == DlgConfirmMsgKind.MSG_ACB_CINSTATUS.dlgId) ||
          (errNo == DlgConfirmMsgKind.MSG_ACB_STOPSTATUS.dlgId)) {
        errNo = DlgConfirmMsgKind.MSG_ACRACT.dlgId;
      }
    } else {
      errNo = await RcAcracb.rcAcrAcbAnswerRead2();
    }
    return errNo;
  }

  ///  関連tprxソース: rckycref.c - rcPrc_Key_ChgRef
  static Future<void> rcPrcKeyChgRef() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();

    chgDrwSystem = await CmCksys.cmAcxChgdrwSystem();
    cMem.ent.errNo = await RcAcracb.rcChkAcrAcbChkStock(0);  // 収納庫枚数リード
    if (cMem.ent.errNo != Typ.OK) {
      errNo = await RcAcracb.rcAcrAcbAnswerReadDtl();
      if ((errNo == DlgConfirmMsgKind.MSG_CHARGING.dlgId) ||
          (errNo == DlgConfirmMsgKind.MSG_ACB_CINSTATUS.dlgId) ||
          (errNo == DlgConfirmMsgKind.MSG_ACB_STOPSTATUS.dlgId)) {
        errNo = DlgConfirmMsgKind.MSG_ACRACT.dlgId;
      }
      if (errNo != Typ.OK) {
        cMem.ent.errNo = errNo; //状態チェックでのerr_noの方が状況が詳しいため
      }
      await rcEndKeyChgRef();
      return;
    } else {
      if (await RcSysChk.rcChkAcrAcbSystem(1) == CoinChanger.ACR_COINONLY) {
        await rcDispKeyChgRef();
      } else if (await RcSysChk.rcChkAcrAcbSystem(1) == CoinChanger.ACR_COINBILL) {
        if (CompileFlag.SELF_GATE) {
          if (await RcSysChk.rcSGChkSelfGateSystem()) {
            RcAssistMnt.rcAssistSend(39014);
          }
        }
        await rcDispKeyChgRef();
      } else {
        await rcEndKeyChgRef();
      }
    }
    if (cMem.coinData.coinslot == 1) {
      await ReptEjConf.rcErr("rcPrcKeyChgRef", DlgConfirmMsgKind.MSG_ACRERROR.dlgId);
      /* 自動開閉設動作中 */
      if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
        if (await RcFncChk.rcCheckItmMode() ||
            await RcFncChk.rcCheckStlMode()) {
          await RcAuto.rcAutoStrOpnClsFuncErrStop(
              DlgConfirmMsgKind.MSG_ACRERROR.dlgId); /* エラー発生の為、自動化中止 */
        }
      }
    }
  }

  ///  関連tprxソース: rckycref.c - rcChgRefDsp_Entry
  static Future<void> rcChgRefDspEntry() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "rcChgRefDsp_Entry");
    switch (atSing.inputbuf.dev) {
      case DevIn.D_KEY:
        if (cMem.stat.fncCode == FuncKey.KY_CLR.keyId) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcD_Key start:${cMem.stat.fncCode}");
          RckyClr.rcClearPopDisplay();
          await RcExt.rcClearErrStat("rcChgRefDspEntry");
        }
        break;
      default:
        break;
    }
  }

  ///  関連tprxソース: rckycref.c - printFnc
  //static int printFnc(GtkWidget *widget, gpointer data)
  static Future<int> printFnc() async {
    int errNo = 0;
    String callFunc = 'printFnc';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return 0;
    }
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    RxCommonBuf cBuf = xRetC.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    if (printAct == Typ.ON) {
      return 0;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        RcSgCom.mngPcLog += LRckyCRef.CREF_PRINT;
        RcSgCom.rcSGManageLogButton();
        RcSgCom.rcSGManageLogSend(SgDsp.REG_LOG);
        RcAssistMnt.rcAssistSend(23070);
      }
    }
    printAct = Typ.ON;
    cMem.ent.errNo = await RcFncChk.rcChkRPrinter();
    if (cMem.ent.errNo == Typ.OK) {
      await RcRecno.rcSetRctJnlNo();
      await RcSetDate.rcSetDate();

      mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_CHGREF.index;
      await RcAcracb.rcAcrAcbMemorySet(tsBuf.acx.coinStock);
      atSing.rctChkCnt = 0;
      await RcExt.rxChkModeSet("printFnc");
      CalcResultChanger retData = await RcClxosChanger.changerRef(cBuf);
      cMem.ent.errNo = retData.retSts!;
      if (0 != cMem.ent.errNo) {
        await ReptEjConf.rcErr("printFnc", cMem.ent.errNo);
        cMem.ent.errNo = Typ.OK;
      } else {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
      }
      printAct = Typ.OFF;
    } else {
      await ReptEjConf.rcErr("printFnc", cMem.ent.errNo);
      printAct = Typ.OFF;
    }
    return 0;
  }

  ///  関連tprxソース: rckycref.c - destFnc
  static Future<void> destFnc() async {
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        Rcinoutdsp.rcSGExitLogTextMake();
        RcAssistMnt.rcAssistSend(39001);
        if (winCRefAcb != null) {
          Fb2Gtk.gtkWidgetDestroy(winCRefAcb);
          winCRefAcb = null;
        }
        await RcObr.rcScanEnable();
        return;
      }
    }
    if (winCRefAcb != null) {
      Fb2Gtk.gtkWidgetDestroy(winCRefAcb);
      winCRefAcb = null;
    }
    if (FbInit.subinitMainSingleSpecialChk()) {
      if (winDualCRefAcb != null) {
        Fb2Gtk.gtkWidgetDestroy(winDualCRefAcb);
        winDualCRefAcb = null;
      }
    }
    Rc28dsp.rc28MainWindowSizeChange(0);
  }

  ///  関連tprxソース: rckycref.c - endFnc
  //static int endFnc(GtkWidget *widget, gpointer data)
  static Future<int> endFnc(Object? widget, Object? data) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "ChgRef endFnc");
    if (printAct == Typ.ON) {
      return 0;
    }
    RcSet.rcClearEntry();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        destFnc();
        break;
      default:
        break;
    }
    await rcEndKeyChgRef();
    return 0;
  }

  ///  関連tprxソース: rckycref.c - rcDisp_Key_ChgRef
  static Future<void> rcDispKeyChgRef() async {
    await rcDispKeyChgRefProc2(1);
  }

  ///  関連tprxソース: rckycref.c - rcDisp_Key_ChgRef_Proc2
  static Future<void> rcDispKeyChgRefProc2(int disableFlg) async {
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        if (await rcDispKyChgRef(0) == -1) {
          await rcEndKeyChgRef();
          return;
        }
        if (disableFlg == 1) {
          await RcObr.rcScanDisable();
        }
        return;
      }
    }
    // 初期化
    winCRefAcb = null;
    winDualCRefAcb = null;

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        if (await rcDispKyChgRef(0) == -1) {
          await rcEndKeyChgRef();
        }
        break;
      case RcRegs.KY_SINGLE:
        if (await rcDispKyChgRef(0) == -1) {
          await rcEndKeyChgRef();
          return;
        }
        if (await rcDispKyChgRef(1) == -1) {
          await rcEndKeyChgRef();
          return;
        }
        break;
    }
  }

  ///  関連tprxソース: rckycref.c - rcAcrAcb_Sheet
  static int rcAcrAcbSheet(int sheet, CBillKind kind) {
    switch (sheet) {
      case 10000:
        return kind.bill10000;
      case 5000:
        return kind.bill5000;
      case 2000:
        return kind.bill2000;
      case 1000:
        return kind.bill1000;
      case 500:
        return kind.coin500;
      case 100:
        return kind.coin100;
      case 50:
        return kind.coin50;
      case 10:
        return kind.coin10;
      case 5:
        return kind.coin5;
      case 1:
        return kind.coin1;
    }
    return -1;
  }

  ///  関連tprxソース: rckycref.c - rcAcrAcb_Total_Price
  static int rcAcrAcbTotalPrice(CBillKind kind) {
    int cBillTotal =
        (kind.bill10000 * 10000) +
        (kind.bill5000 * 5000) +
        (kind.bill2000 * 2000) +
        (kind.bill1000 * 1000) +
        (kind.coin500 * 500) +
        (kind.coin100 * 100) +
        (kind.coin50 * 50) +
        (kind.coin10 * 10) +
        (kind.coin5 * 5) +
        kind.coin1;
    return cBillTotal;
  }

  ///  関連tprxソース: rckycref.c - rcEnd_Key_ChgRef
  static Future<void> rcEndKeyChgRef() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.ent.errNo != Typ.OK) {
      await ReptEjConf.rcErr("rcEndKeyChgRef", cMem.ent.errNo);
      /* 自動開閉設動作中 */
      if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
        RcAuto.rcAutoStrOpnClsFuncErrStop(cMem.ent.errNo);  /* エラー発生の為、自動化中止 */
      }
    }
    if (RcFncChk.rcCheckChgRefMode()) {
      switch(await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_CHECKER:
        case RcRegs.KY_DUALCSHR:
        case RcRegs.KY_SINGLE:
          RcSet.rcReMovScrMode();
          break;
      }
    }
    if (RcSysChk.rcCheckRegFnal()) {
      RcSet.cashStatReset2("rcEndKeyChgRef");
    }
    // 自動開閉設仕様：次へ
    if ((AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid())  == AutoRun.AUTORUN_STROPN.val) &&
        (AplLibAuto.aplLibAutoGetAutoMode(await RcSysChk.getTid()) == AutoMode.AUTOMODE_KY_CHGREF.val)) {
      await RcAuto.rcAutoStrOpnClsNextJudg();
    } else {
      if (await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) {
        await RcKyPlu.rcAnyTimeCinStartProc();
      }
    }
  }

  ///  関連tprxソース: rckycref.c - ChgRefMode_Err_Clear
  static void chgRefModeErrClear() {
    Fb2Gtk.gtkGrabAdd(winCRefAcb);
    if (FbInit.subinitMainSingleSpecialChk()) {
      Fb2Gtk.gtkGrabAdd(winDualCRefAcb);
    }
  }

  ///  関連tprxソース: rckycref.c - rcEnd_Ky_ChgRef
  static Future<void> rcEndKyChgRef() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "ChgRef Print End");
    await RcExt.rxChkModeReset("rcEndKyChgRef");
    printAct = Typ.OFF;
  //#if SS_CR2
  //  if( rcChk_CR2_NSW_Data_System() )
  //  {
  //    MEM->prnrbuf.cr2_read_kubun = 0;
  //  }
  //#endif
  }

  ///  関連tprxソース: rckycref.c - rcDisp_KyChgRef
  static Future<int> rcDispKyChgRef(int dualDsp) async {
    return 0;

    String __FUNCTION__ = 'rcDispKyChgRef';
    String image = '';
    int xFix = 0, yFix = 0;
    int xSiz = 0, ySiz = 0, x2Siz = 0;
    int displayTyp = 0;
    int entData = 0;
    int mColor = 0, eColor = 0;
    int coinBillKind = 0;
    int mark = 0;
    int percentage = 0;
    CmEditCtrl fCtrl = CmEditCtrl();
    CBillKind cbillData = CBillKind();

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "rcDispKyChgRef() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    Rc28dsp.rc28MainWindowSizeChange(1);

    // fCtrl.SeparatorEdit = 2;
    // IfTkeyMclick.ifTkeyMouseClick();
    // Fb2Gtk.gtkGrabRemove(Fb2Gtk.gtkGrabGetCurrent());
    //
    // if (dualDsp != 0) {
    //   winDualCrefAcb = advInDsp.window;
    //   advInDsp.window = Fb2Gtk.gtkWindowNewTyp(0, 1);
    // } else {
    //   advInDsp.window = Fb2Gtk.gtkWindowNew(0);
    // }
    // Fb2Gtk.gtkObjectSetData(
    //     advInDsp.window, "advInDsp.window", advInDsp.window);
    // Fb2Gtk.gtkWidgetSetUsize(advInDsp.window, 640, 480);
    // Fb2Gtk.gtkWindowSetPosition(advInDsp.window, 0);
    // Fb2Gtk.gtkContainerBorderWidth(advInDsp.window, 2);
    //
    // Object? fixed1 = Fb2Gtk.gtkFixedNew();
    // Fb2Gtk.gtkWidgetRef(fixed1);
    // Fb2Gtk.gtkObjectSetDataFull(advInDsp.window, "fixed1", fixed1, 0);
    // Fb2Gtk.gtkWidgetSetUsize(fixed1, 640, 480);
    // Fb2Gtk.gtkContainerAdd(advInDsp.window, fixed1);
    // FbLib.chgColor(
    //     fixed1,
    //     Color_Select[FbColorGroup.MediumGray.index],
    //     Color_Select[FbColorGroup.MediumGray.index],
    //     Color_Select[FbColorGroup.MediumGray.index]);
    //
    // EucAdj buf = AplLibImgRead.aplLibImgRead(FuncKey.KY_CHGREF.keyId);
    // advInDsp.title = Fb2Gtk.gtkTopMenuNewWithSize(
    //     buf.toString(),
    //     628,
    //     40,
    //     FbColorGroup.White.index,
    //     FbColorGroup.MediumGray.index,
    //     FbColorGroup.White.index);
    // Fb2Gtk.gtkWidgetRef(advInDsp.title);
    // Fb2Gtk.gtkObjectSetDataFull(advInDsp.window, "title", advInDsp.title, 0);
    // Fb2Gtk.gtkFixedPut(fixed1, advInDsp.title, 4, 3);
    //
    // Object? print = Fb2Gtk.gtkRoundButtonNewWithLabel(CREF_PRINT);
    // Fb2Gtk.gtkRoundButtonSetColor(fixed1, FbColorGroup.TurquoiseBlue.index);
    // Fb2Gtk.gtkRegsbuttonSetColorLabel(print, FbColorGroup.BlackGray.index);
    // Fb2Gtk.gtkWidgetRef(print);
    // Fb2Gtk.gtkObjectSetDataFull(advInDsp.window, "print", print, 0);
    // Fb2Gtk.gtkWidgetSetUsize(print, 640, 480);
    // Fb2Gtk.gtkFixedPut(fixed1, print, 4, 3);
    // Fb2Gtk.gtkSignalConnectObject(print, "pressed", printFnc, advInDsp.window);
    //
    // Object? end = Fb2Gtk.gtkRoundButtonNewWithLabel(CREF_END);
    // Fb2Gtk.gtkRoundButtonSetColor(end, FbColorGroup.Orange.index);
    // Fb2Gtk.gtkRegsbuttonSetColorLabel(end, FbColorGroup.White.index);
    // Fb2Gtk.gtkWidgetRef(end);
    // Fb2Gtk.gtkObjectSetDataFull(advInDsp.window, "end", end, 0);
    // Fb2Gtk.gtkWidgetSetUsize(end, 640, 480);
    // Fb2Gtk.gtkFixedPut(fixed1, end, 4, 3);
    // Fb2Gtk.gtkSignalConnectObject(end, "pressed", endFnc, advInDsp.window);

    for (int i = 0; i < CRefEntry.CREF_ENTRY_MAX.index; i++) {
      // if (i <= CRefEntry.CREF_HOLDER_Y1.index) {
      //   //CREF_HOLDER_Y1まで収納庫。以降回収庫（金庫）
      //   xSiz = RcAcrAcbDsp.CREF_ENTRY1_X;
      //   xFix = RcAcrAcbDsp.CREF_ENTRY1_F_X;
      //   yFix = RcAcrAcbDsp.CREF_ENTRY_F_Y +
      //       ((RcAcrAcbDsp.CREF_ENTRY_Y + RcAcrAcbDsp.CREF_FIL) * i);
      //   cbillData = cMem.coinData.holder;
      // } else {
      //   xSiz = RcAcrAcbDsp.CREF_ENTRY2_X;
      //   xFix = RcAcrAcbDsp.CREF_ENTRY2_F_X;
      //   yFix = (RcAcrAcbDsp.CREF_ENTRY_F_Y +
      //           ((RcAcrAcbDsp.CREF_ENTRY_Y + RcAcrAcbDsp.CREF_FIL) *
      //               (i - (CRefEntry.CREF_HOLDER_Y1.index + 1))))
      //       .floor(); //12個目に列変更
      //   if (i <= CRefEntry.CREF_OVERFL_Y1000.index) {
      //     //CREF_OVERFL_Y1000までカセット。以降棒金
      //     cbillData = cMem.coinData.overflow;
      //   } else {
      //     cbillData = cMem.coinData.drawData;
      //   }
      // }
      displayTyp = CrefDispType.CREF_DSPTYP_NON.index;
      mColor = FbColorGroup.White.index;
      eColor = FbColorGroup.Navy.index;
      switch (CRefEntry.values[i]) {
        case CRefEntry.CREF_HOLDER_TOTAL: //釣機合計
          AplLibImgRead.aplLibImgRead(
              ImageDefinitions.IMG_ACRACB_CHG_TTL); //筒合計金額 (廃止)
          AplLibImgRead.aplLibImgRead(
              ImageDefinitions.IMG_CBILL_HOLDER_TTL_PRC); //収納合計金額
          entData = rcAcrAcbTotalPrice(cMem.coinData.holder);
          displayTyp = CrefDispType.CREF_DSPTYP_PRICE.index;
          mColor = FbColorGroup.White.index;
          eColor = FbColorGroup.Purple.index;
          break;
        case CRefEntry.CREF_HOLDER_Y10000:
          coinBillKind = CoinBillKindList.CB_KIND_10000.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y10000);
          entData = rcAcrAcbSheet(10000, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) != CoinChanger.ACR_COINBILL) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y5000:
          coinBillKind = CoinBillKindList.CB_KIND_05000.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y5000);
          entData = rcAcrAcbSheet(5000, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) != CoinChanger.ACR_COINBILL) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y2000:
          coinBillKind = CoinBillKindList.CB_KIND_02000.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y2000);
          entData = rcAcrAcbSheet(2000, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) != CoinChanger.ACR_COINBILL) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y1000:
          coinBillKind = CoinBillKindList.CB_KIND_01000.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y1000);
          entData = rcAcrAcbSheet(1000, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) != CoinChanger.ACR_COINBILL) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y500:
          coinBillKind = CoinBillKindList.CB_KIND_00500.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y500);
          entData = rcAcrAcbSheet(500, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) == 0) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y100:
          coinBillKind = CoinBillKindList.CB_KIND_00100.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y100);
          entData = rcAcrAcbSheet(100, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) == 0) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y50:
          coinBillKind = CoinBillKindList.CB_KIND_00050.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y50);
          entData = rcAcrAcbSheet(50, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) == 0) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y10:
          coinBillKind = CoinBillKindList.CB_KIND_00010.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y10);
          entData = rcAcrAcbSheet(10, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) == 0) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y5:
          coinBillKind = CoinBillKindList.CB_KIND_00005.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y5);
          entData = rcAcrAcbSheet(5, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) == 0) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_HOLDER_Y1:
          coinBillKind = CoinBillKindList.CB_KIND_00001.index;
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y1);
          entData = rcAcrAcbSheet(1, cbillData);
          mark = tsBuf.acx.holderStatus.kindFlg[coinBillKind].index;
          percentage = tsBuf.acx.holderStatus.percentage[coinBillKind];
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) == 0) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_OVERFL_TOTAL: //金庫合計金額
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_ACRACB_STK_TTL);
          entData = rcAcrAcbTotalPrice(cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbTotalPrice(cMem.coinData.drawData); //棒金ドロア
          }
          displayTyp = CrefDispType.CREF_DSPTYP_PRICE.index;
          mColor = FbColorGroup.White.index;
          eColor = FbColorGroup.Purple.index;
          break;
        case CRefEntry.CREF_OVERFL_Y10000:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y10000);
          entData = rcAcrAcbSheet(10000, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(10000, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(CRefEntry.values[i], cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) != CoinChanger.ACR_COINBILL) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_OVERFL_Y5000:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y5000);
          entData = rcAcrAcbSheet(5000, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(5000, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(CRefEntry.values[i], cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) != CoinChanger.ACR_COINBILL) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_OVERFL_Y2000:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y2000);
          entData = rcAcrAcbSheet(2000, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(2000, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(CRefEntry.values[i], cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) != CoinChanger.ACR_COINBILL) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_OVERFL_Y1000:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y1000);
          entData = rcAcrAcbSheet(1000, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(1000, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(CRefEntry.values[i], cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          if (await RcSysChk.rcChkAcrAcbSystem(1) != CoinChanger.ACR_COINBILL) {
            displayTyp = CrefDispType.CREF_DSPTYP_OFF.index;
          }
          break;
        case CRefEntry.CREF_OVERFL_Y500:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y500);
          entData = rcAcrAcbSheet(500, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(500, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(CRefEntry.values[i], cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          break;
        case CRefEntry.CREF_OVERFL_Y100:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y100);
          entData = rcAcrAcbSheet(100, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(100, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(CRefEntry.values[i], cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          break;
        case CRefEntry.CREF_OVERFL_Y50:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y50);
          entData = rcAcrAcbSheet(50, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(50, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(CRefEntry.values[i], cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          break;
        case CRefEntry.CREF_OVERFL_Y10:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y10);
          entData = rcAcrAcbSheet(10, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(10, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(CRefEntry.values[i], cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          break;
        case CRefEntry.CREF_OVERFL_Y5:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y5);
          entData = rcAcrAcbSheet(5, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(5, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(i as CRefEntry, cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          break;
        case CRefEntry.CREF_OVERFL_Y1:
          AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_Y1);
          entData = rcAcrAcbSheet(1, cMem.coinData.overflow); //オーバーフロー
          if (chgDrwSystem == 1) {
            entData += rcAcrAcbSheet(1, cMem.coinData.drawData); //棒金ドロア
          }
          mark = rcChkKyChgRefOverFlStatus(i as CRefEntry, cbillData);
          displayTyp = CrefDispType.CREF_DSPTYP_SHEET.index;
          break;
        default:
          break;
      }

      if (displayTyp == CrefDispType.CREF_DSPTYP_NON.index) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "$__FUNCTION__ : ENTRY[$i] NONDISP\n");
        continue;
      }
      //
      // Object? tCrefEnt = Fb2Gtk.gtkRoundEntryNew();
      // Fb2Gtk.gtkWidgetRef(tCrefEnt);
      // Fb2Gtk.gtkObjectSetDataFull(advInDsp.window, 'ent$i', tCrefEnt, 0);
      // Fb2Gtk.gtkWidgetSetUsize(tCrefEnt, xSiz, RcAcrAcbDsp.CREF_ENTRY_Y);
      // FbStyle.chgStyle(tCrefEnt, Color_Select[mColor], Color_Select[eColor],
      //     Color_Select[eColor], KANJI16);
      // Fb2Gtk.gtkRoundEntrySetEditable(tCrefEnt, false);
      // Fb2Gtk.gtkRoundEntrySetBgcolor(tCrefEnt, FbColorGroup.MediumGray.index);
      // Fb2Gtk.gtkFixedPut(fixed1, tCrefEnt, xFix, yFix);
      // Fb2Gtk.gtkRoundEntrySetText(tCrefEnt, image);

    //   mColor = FbColorGroup.Lime.index;
    //   eColor = FbColorGroup.BlackGray.index;
    //   if (displayTyp == CrefDispType.CREF_DSPTYP_SHEET.index) {
    //     List<int> pBuf = [];
    //     int bytes = 0;
    //     (int, int) ret = CmNedit()
    //         .cmEditUnitPriceUtf(fCtrl, pBuf, pBuf.length, 9, entData, bytes);
    //     pBuf[ret.$2] = 0;
    //     for (int data in pBuf) {
    //       image += data.toString();
    //     }
    //     image += '枚';
    //     if (i <= CRefEntry.CREF_HOLDER_Y1.index) {
    //       //CREF_HOLDER_Y1まで収納庫。以降回収庫（金庫）
    //       xFix = RcAcrAcbDsp.CREF_SHEET1_F_X;
    //       xSiz = RcAcrAcbDsp.CREF_SHEET1_X;
    //     } else {
    //       xFix = RcAcrAcbDsp.CREF_SHEET2_F_X;
    //       xSiz = RcAcrAcbDsp.CREF_SHEET2_X;
    //     }
    //     yFix = RcAcrAcbDsp.CREF_SHEET_F_Y;
    //     ySiz = RcAcrAcbDsp.CREF_SHEET_Y;
    //   } else if (displayTyp == CrefDispType.CREF_DSPTYP_PRICE.index) {
    //     List<int> pBuf = [];
    //     int bytes = 0;
    //     (int, int) ret = CmNedit()
    //         .cmEditUnitPriceUtf(fCtrl, pBuf, pBuf.length, 10, entData, bytes);
    //     pBuf[ret.$2] = 0;
    //     for (int data in pBuf) {
    //       image += data.toString();
    //     }
    //     image += RcKyCRef.CREF_YEN;
    //     if (i <= CRefEntry.CREF_HOLDER_Y1.index) {
    //       //CREF_HOLDER_Y1まで収納庫。以降回収庫（金庫）
    //       xFix = RcAcrAcbDsp.CREF_PRICE1_F_X;
    //       xSiz = RcAcrAcbDsp.CREF_PRICE1_X;
    //     } else {
    //       xFix = RcAcrAcbDsp.CREF_PRICE2_F_X;
    //       xSiz = RcAcrAcbDsp.CREF_PRICE2_X;
    //     }
    //     yFix = RcAcrAcbDsp.CREF_PRICE_F_Y;
    //     ySiz = RcAcrAcbDsp.CREF_PRICE_Y;
    //   } else {
    //     //CREF_DSPTYP_OFF
    //     mColor = FbColorGroup.BlackGray.index;
    //     eColor = FbColorGroup.LightGray.index;
    //     image = RcKyCRef.CREF_NON_CNCT;
    //     if (i <= CRefEntry.CREF_HOLDER_Y1.index) {
    //       //CREF_HOLDER_Y1まで収納庫。以降回収庫（金庫）
    //       xFix = RcAcrAcbDsp.CREF_OFF1_F_X;
    //       xSiz = RcAcrAcbDsp.CREF_OFF1_X;
    //     } else {
    //       xFix = RcAcrAcbDsp.CREF_OFF2_F_X;
    //       xSiz = RcAcrAcbDsp.CREF_OFF2_X;
    //     }
    //     yFix = RcAcrAcbDsp.CREF_OFF_F_Y;
    //     ySiz = RcAcrAcbDsp.CREF_OFF_Y;
    //   }
    //
    //   Object? tCrefSht = Fb2Gtk.gtkRoundEntryNew();
    //   Fb2Gtk.gtkWidgetRef(tCrefSht);
    //   Fb2Gtk.gtkObjectSetDataFull(advInDsp.window, 'sht$i', tCrefSht, 0);
    //   Fb2Gtk.gtkWidgetSetUsize(tCrefSht, xSiz, ySiz);
    //   FbStyle.chgStyle(tCrefSht, Color_Select[mColor], Color_Select[eColor],
    //       Color_Select[eColor], KANJI16);
    //   Fb2Gtk.gtkRoundEntrySetEditable(tCrefSht, false);
    //   Fb2Gtk.gtkRoundEntrySetBgcolor(tCrefSht, FbColorGroup.MediumGray.index);
    //   Fb2Gtk.gtkFixedPut(tCrefEnt, tCrefSht, xFix, yFix);
    //   Fb2Gtk.gtkRoundEntrySetText(tCrefSht, image);
    //
    //   if (displayTyp == CrefDispType.CREF_DSPTYP_SHEET.index) {
    //     if (i <= CRefEntry.CREF_HOLDER_Y1.index) {
    //       //CREF_HOLDER_Y1まで収納庫。以降回収庫（金庫）
    //       xSiz = RcAcrAcbDsp.CREF_STATUS1_X;
    //       xFix = RcAcrAcbDsp.CREF_STATUS1_F_X;
    //     } else {
    //       xSiz = RcAcrAcbDsp.CREF_STATUS2_X;
    //       xFix = RcAcrAcbDsp.CREF_STATUS2_F_X;
    //     }
    //     yFix = RcAcrAcbDsp.CREF_STATUS_F_Y;
    //
    //     if (mark == HolderFlagList.HOLDER_EMPTY.index) {
    //       image = RcKyCRef.CREF_EMPTY2;
    //       mColor = FbColorGroup.TrueRed.index;
    //     } else if (mark == HolderFlagList.HOLDER_NON.index) {
    //       image = RcKyCRef.CREF_EMPTY2;
    //       mColor = FbColorGroup.MediumGray.index;
    //     } else {
    //       image = RcKyCRef.CREF_SPC;
    //     }
    //     Object? tCrefSts = Fb2Gtk.gtkRoundEntryNew();
    //     Fb2Gtk.gtkWidgetRef(tCrefSts);
    //     String key = "sts$i";
    //     Fb2Gtk.gtkObjectSetDataFull(advInDsp.window, key, tCrefSts, 0);
    //     Fb2Gtk.gtkWidgetSetUsize(tCrefSts, xSiz, RcAcrAcbDsp.CREF_STATUS_Y);
    //     FbStyle.chgStyle(
    //         tCrefSts,
    //         Color_Select[mColor],
    //         Color_Select[FbColorGroup.LightGray.index],
    //         Color_Select[FbColorGroup.LightGray.index],
    //         KANJI16);
    //     Fb2Gtk.gtkRoundEntrySetEditable(tCrefSts, false);
    //     Fb2Gtk.gtkRoundEntrySetBgcolor(tCrefSts, FbColorGroup.MediumGray.index);
    //     Fb2Gtk.gtkFixedPut(tCrefEnt, tCrefSts, xFix, yFix);
    //     Fb2Gtk.gtkMiscSetAlignment(tCrefSts, 0.5, 0.5);
    //     Fb2Gtk.gtkRoundEntrySetText(tCrefSts, image);
    //
    //     //割合を棒グラフで表示
    //     if ((i <= CRefEntry.CREF_HOLDER_Y1.index) &&
    //         (mark != HolderFlagList.HOLDER_EMPTY.index) &&
    //         (mark != HolderFlagList.HOLDER_NON.index)) {
    //       //CREF_HOLDER_Y1まで
    //
    //       x2Siz = ((percentage * xSiz) / 100).floor();
    //       if (x2Siz > (xSiz - 3)) {
    //         //entryサイズよりはみでるので微調整
    //         x2Siz = (xSiz - 3);
    //       } else if ((percentage != 0) && (x2Siz < 5)) {
    //         //空でない場合の最小バーサイズを確保
    //         x2Siz = 5;
    //       }
    //       ySiz = RcAcrAcbDsp.CREF_STATUS_Y - 3;
    //       if (mark == HolderFlagList.HOLDER_NEAR_END.index) {
    //         //ニアエンド
    //         eColor = FbColorGroup.TrueRed.index;
    //       } else if ((mark == HolderFlagList.HOLDER_FULL.index) ||
    //           (mark == HolderFlagList.HOLDER_NEAR_FULL.index)) {
    //         //フル or ニアフル
    //         eColor = FbColorGroup.LightYellow.index;
    //       } else {
    //         //適量
    //         eColor = FbColorGroup.Green.index;
    //       }
    //       Object? barDisp = Fb2Gtk.gtkLabelLineNew(
    //           " ", FbColorGroup.White.index, eColor, eColor, 0, 16);
    //       Fb2Gtk.gtkWidgetSetUsize(barDisp, x2Siz, ySiz);
    //       Fb2Gtk.gtkFixedPut(tCrefSts, barDisp, 0, 0);
    //     }
    //   }
    }
    //
    // /* 釣機在高不確定ラベル */
    // Object? stockState = Fb2Gtk.gtkLabelNew(RcKyCRef.CREF_STOCK);
    // FbStyle.chgStyle(
    //     stockState,
    //     Color_Select[FbColorGroup.Red.index],
    //     Color_Select[FbColorGroup.FB_ColorMax.index],
    //     Color_Select[FbColorGroup.FB_ColorMax.index],
    //     KANJI24);
    // Fb2Gtk.gtkWidgetSetUsize(
    //     stockState, RcAcrAcbDsp.CREF_STOCK_X, RcAcrAcbDsp.CREF_STOCK_Y);
    // Fb2Gtk.gtkFixedPut(advInDsp.title, stockState, RcAcrAcbDsp.CREF_STOCK_F_X,
    //     RcAcrAcbDsp.CREF_STOCK_F_Y);
    // Fb2Gtk.gtkMiscSetAlignment(stockState, 0, 0.5);
    //
    // Fb2Gtk.gtkGrabAdd(advInDsp.window);
    // Fb2Gtk.gtkWidgetShowAll(advInDsp.window);
    // if (RcAcracb.rcChkChgStockState() == 0) {
    //   Fb2Gtk.gtkWidgetHide(stockState);
    // }
    //
    // Fb2Gtk.sysCursorOff(advInDsp.window);
    // if (dualDsp != 0) {
    //   Object? dualTmpWin = advInDsp.window;
    //   advInDsp.window = winDualCrefAcb;
    //   winDualCrefAcb = dualTmpWin;
    // }
    return 0;
  }

  ///  関連tprxソース: rckycref.c - rcChk_KyChgRef_OverFlStatus
  static int rcChkKyChgRefOverFlStatus(CRefEntry kind, CBillKind data) {
    int chkData = 0;
    int mark = 0;

    switch (kind) {
      case CRefEntry.CREF_OVERFL_Y10000:
        chkData = data.bill10000;
        break;
      case CRefEntry.CREF_OVERFL_Y5000:
        chkData = data.bill5000;
        break;
      case CRefEntry.CREF_OVERFL_Y2000:
        chkData = data.bill2000;
        break;
      case CRefEntry.CREF_OVERFL_Y1000:
        chkData = data.bill1000;
        break;
      case CRefEntry.CREF_OVERFL_Y500:
        chkData = data.coin500;
        break;
      case CRefEntry.CREF_OVERFL_Y100:
        chkData = data.coin100;
        break;
      case CRefEntry.CREF_OVERFL_Y50:
        chkData = data.coin50;
        break;
      case CRefEntry.CREF_OVERFL_Y10:
        chkData = data.coin10;
        break;
      case CRefEntry.CREF_OVERFL_Y5:
        chkData = data.coin5;
        break;
      case CRefEntry.CREF_OVERFL_Y1:
        chkData = data.coin1;
        break;
      default:
        break;
    }

    if (chkData == 0) {
      mark = HolderFlagList.HOLDER_NON.index;
    } else {
      mark = HolderFlagList.HOLDER_NORMAL.index;
    }
    return mark;
  }

  static CoinData getCoinData() {
    AcMem cMem = SystemFunc.readAcMem();
    return cMem.coinData;
  }

  static void rckyRefClose() {
  }

  /// 釣銭機に入金したお金を吐き出させる。
  static Future<int> cancelCharger() async {
    int changerRet = 0;
    // AcMem cMem = SystemFunc.readAcMem();
    // ChangeCoinInInputController changeCoinInCtrl = Get.find();
    // debugPrint("cancel");
    // if (changeCoinInCtrl.receivePrc.value != 0) {
    //   // 入金額が0で無ければ返金
    //   await RcAcracb.rcAcrAcbCinEnd();
    // }
    // changeCoinInCtrl.receivePrc.value = 0;
    // changeCoinInCtrl.coinInPrc.value = 0;
    // changeCoinInCtrl.currentCoinInPrc.value = 0;
    // changeCoinInCtrl.change.value = 0;
    // await RcExt.rxChkModeReset("cancelCharger");
    // cMem.stat.fncCode = 0;
    return changerRet;
  }
}
