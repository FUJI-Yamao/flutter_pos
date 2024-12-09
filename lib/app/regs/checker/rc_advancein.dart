/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_gtkutil.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcmanualmix.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../fb/fb_lib.dart';
import '../../fb/fb_style.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_tkey/if_tkey_mclick.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_28dsp.dart';

/// 関連tprxソース: L_rc_advancein.h
// #define ADVIN_INP   "入力"
// #define ADVIN_RSVNO "予約番号"
// #define ADVIN_MBR   "  会員名："
// #define ADVIN_TEL   "電話番号："
// #define ADVIN_TTL   "合計金額"
// #define ADVIN_READV "前回内金額"
// #define ADVIN_ADV   "内金額"
// #define ADVIN_EXEC  "実行"
// #define ADVIN_END   "終了"
// #define ADV_CCIN_CIN     "釣機入金"
// #define ADV_CCIN_RCIN    "再 入 金"
// #define ADV_CCIN_CNCL    "入金取消"
const String ADVIN_INP = "入力";
const String ADVIN_RSVNO = "予約番号";
const String ADVIN_MBR = "  会員名：";
const String ADVIN_TEL = "電話番号：";
const String ADVIN_TTL = "合計金額";
const String ADVIN_READV = "前回内金額";
const String ADVIN_ADV = "内金額";
const String ADVIN_EXEC = "実行";
const String ADVIN_END = "終了";
const String ADV_CCIN_CIN = "釣機入金";
const String ADV_CCIN_RCIN = "再 入 金";
const String ADV_CCIN_CNCL = "入金取消";

/// 関連tprxソース: rc_advancein.h - ADVANCEIN
class AdvanceIn {
  int execMode = 0;

  /* 0: advance input 1: advance print */
  Object? window;
  Object? winFix;
  Object? title;
  Object? inpBtn;
  Object? rsvnoBtn;
  Object? rsvnoEnt;
  Object? lbl1;
  Object? lbl2;
  Object? ttlBtn;
  Object? ttlEnt;
  Object? oldadvBtn;
  Object? oldadvEnt;
  Object? advBtn;
  Object? advEnt;
  Object? lblChgout;
  Object? execBtn;
  Object? endBtn;
  Object? cinInp;
  Object? cinRinp;
  Object? cinCncl;
  Object? cinAct;
  int inpMode = 0;
}

///  関連tprxソース: rc_advancein.c
class RcAdvanceIn {
  static AdvanceIn advInDsp = AdvanceIn();
  static int advOldScrMode = 0;

  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_Adj()
  static Future<void> rcAdvanceInAdj() async {
    int errorNo = await rcAdvanceInChk();
    if (errorNo == DlgConfirmMsgKind.MSG_NONE.dlgId) {
      rcAdvanceInProg();
    } else {
      await RcExt.rcErr("rcAdvanceInAdj", errorNo);
    }
  }

  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_chk()
  static Future<int> rcAdvanceInChk() async {
    int errorNo = DlgConfirmMsgKind.MSG_NONE.dlgId;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (RcFncChk.rcCheckRegistration()) {
      errorNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if (RcManualMix.rcAssortManualMixChk() || (mem.tmpbuf.manualMixcd != 0)) {
      errorNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        errorNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
      }
    }
    if (!((cMem.stat.opeMode == RcRegs.RG) ||
        (cMem.stat.opeMode == RcRegs.TR))) {
      errorNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }
    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        !await RcSysChk.rcCheckQCJCSystem()) {
      errorNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    return errorNo;
  }

  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_prog()
  static int rcAdvanceInProg() {
    rcAdvanceInModeSet();
    rcAdvanceInDataClear();
    rcAdvanceInDsp();
    return 0;
  }

  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_DataClear()
  static void rcAdvanceInDataClear() {
    advInDsp = AdvanceIn();
    RegsMem mem = SystemFunc.readRegsMem();
    mem.prnrBuf.oldAdvanceMoney = 0;
  }

  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_dsp()
  static void rcAdvanceInDsp() {
    Rc28dsp.rc28MainWindowSizeChange(1);

    IfTkeyMclick.ifTkeyMouseClick();
    if (Fb2Gtk.gtkGrabGetCurrent() != null) {
      Fb2Gtk.gtkGrabRemove(Fb2Gtk.gtkGrabGetCurrent());
    }

    advInDsp.window = Fb2Gtk.gtkWindowNew(0);
    Fb2Gtk.gtkObjectSetData(advInDsp.window, "window", advInDsp.window);
    Fb2Gtk.gtkWindowSetTitle(advInDsp.window, "window");
    Fb2Gtk.gtkWindowSetPosition(advInDsp.window, 0);
    Fb2Gtk.gtkWidgetSetUsize(advInDsp.window, 640, 480);
    Fb2Gtk.gtkContainerBorderWidth(advInDsp.window, 2);
    FbLib.chgColor(
        advInDsp.window,
        Color_Select[FbColorGroup.BlackGray.index],
        Color_Select[FbColorGroup.BlackGray.index],
        Color_Select[FbColorGroup.BlackGray.index]);

    advInDsp.winFix = RcGtkUtil.rcDrawFix(
        advInDsp.window, FbColorGroup.LightGray.index, "win_fix", 999);
    Fb2Gtk.gtkContainerAdd(advInDsp.window, advInDsp.winFix);

    var buf = AplLibImgRead.aplLibImgRead(FuncKey.KY_CIN15.keyId);
    advInDsp.title = Fb2Gtk.gtkTopMenuNewWithSize(
        buf.toString(),
        628,
        40,
        FbColorGroup.White.index,
        FbColorGroup.MediumGray.index,
        FbColorGroup.White.index);
    Fb2Gtk.gtkWidgetRef(advInDsp.title);
    Fb2Gtk.gtkObjectSetDataFull(advInDsp.window, "title", advInDsp.title, 0);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.title, 4, 3);
    Fb2Gtk.gtkWidgetShow(advInDsp.title, "rcAdvanceInDsp");

    advInDsp.inpBtn = RcGtkUtil.rcDrawButton(
        advInDsp.window,
        FbColorGroup.Red.index,
        FbColorGroup.White.index,
        ADVIN_INP,
        "inp_btn",
        1);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.inpBtn, 589, 48);
    Fb2Gtk.gtkSignalConnect(
        advInDsp.inpBtn, "pressed", rcAdvanceInInpFnc, null);

    advInDsp.rsvnoBtn = RcGtkUtil.rcDrawButton(
        advInDsp.window,
        FbColorGroup.SkyBlue.index,
        FbColorGroup.BlackGray.index,
        ADVIN_RSVNO,
        "reserv_btn",
        2);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.rsvnoBtn, 16, 96);
    Fb2Gtk.gtkSignalConnect(
        advInDsp.rsvnoBtn, "pressed", rcAdvanceInSelBtnFnc, 0);

    advInDsp.rsvnoEnt = RcGtkUtil.rcDrawEntry(advInDsp.window,
        FbColorGroup.White.index, FbColorGroup.BlackGray.index, " ", 20, 0);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.rsvnoEnt, 152, 100);

    advInDsp.lbl1 = RcGtkUtil.rcDrawLabel(
        advInDsp.window, FbColorGroup.BlackGray.index, ADVIN_MBR, "lbl1");
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.lbl1, 16, 150);

    advInDsp.lbl2 = RcGtkUtil.rcDrawLabel(
        advInDsp.window, FbColorGroup.BlackGray.index, ADVIN_TEL, "lbl2");
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.lbl2, 16, 175);

    advInDsp.ttlBtn = RcGtkUtil.rcDrawButton(
        advInDsp.window,
        FbColorGroup.SkyBlue.index,
        FbColorGroup.BlackGray.index,
        ADVIN_TTL,
        "ttl_btn",
        2);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.ttlBtn, 16, 204);
    Fb2Gtk.gtkWidgetSetSensitive(advInDsp.ttlBtn, false);
    Fb2Gtk.gtkSignalConnect(
        advInDsp.ttlBtn, "pressed", rcAdvanceInSelBtnFnc, 1);

    advInDsp.ttlEnt = RcGtkUtil.rcDrawEntry(advInDsp.window,
        FbColorGroup.White.index, FbColorGroup.BlackGray.index, " ", 20, 0);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.ttlEnt, 152, 210);

    advInDsp.oldadvBtn = RcGtkUtil.rcDrawButton(
        advInDsp.window,
        FbColorGroup.SkyBlue.index,
        FbColorGroup.BlackGray.index,
        ADVIN_READV,
        "oldadv_btn",
        2);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.oldadvBtn, 16, 252);

    advInDsp.oldadvEnt = RcGtkUtil.rcDrawEntry(advInDsp.window,
        FbColorGroup.White.index, FbColorGroup.BlackGray.index, " ", 20, 0);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.oldadvEnt, 152, 258);

    advInDsp.advBtn = RcGtkUtil.rcDrawButton(
        advInDsp.window,
        FbColorGroup.SkyBlue.index,
        FbColorGroup.BlackGray.index,
        ADVIN_ADV,
        "dadv_btn",
        2);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.advBtn, 16, 300);
    Fb2Gtk.gtkSignalConnect(
        advInDsp.advBtn, "pressed", rcAdvanceInSelBtnFnc, 2);

    advInDsp.advEnt = RcGtkUtil.rcDrawEntry(advInDsp.window,
        FbColorGroup.White.index, FbColorGroup.BlackGray.index, " ", 20, 0);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.advEnt, 152, 306);

    advInDsp.lblChgout = RcGtkUtil.rcDrawLabel(
        advInDsp.window, FbColorGroup.BlackGray.index, " ", "inchgout");
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.lblChgout, 8, 360);
    FbStyle.chgStyle(
        advInDsp.lblChgout,
        Color_Select[FbColorGroup.BlackGray.index],
        Color_Select[FbColorGroup.BlackGray.index],
        Color_Select[FbColorGroup.BlackGray.index],
        KANJI24);
    rcAdvanceINChgOut(0);

    advInDsp.execBtn = RcGtkUtil.rcDrawButton(
        advInDsp.window,
        FbColorGroup.Navy.index,
        FbColorGroup.White.index,
        ADVIN_EXEC,
        "exec_btn",
        1);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.execBtn, 589, 300);
    Fb2Gtk.gtkSignalConnect(
        advInDsp.execBtn, "pressed", rcAdvanceInExecBtn, null);

    advInDsp.endBtn = RcGtkUtil.rcDrawButton(
        advInDsp.window,
        FbColorGroup.Orange.index,
        FbColorGroup.White.index,
        ADVIN_END,
        "end_btn",
        1);
    Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.endBtn, 589, 429);
    Fb2Gtk.gtkSignalConnect(advInDsp.endBtn, "pressed", rcAdvanceInEndBtn, -1);

    if (rcAdvanceInChangeCinMode()) {
      advInDsp.cinInp = RcGtkUtil.rcDrawButton(
          advInDsp.window,
          FbColorGroup.Pink.index,
          FbColorGroup.BlackGray.index,
          ADV_CCIN_CIN,
          "inp",
          2);
      Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.cinInp, 408, 204);
      Fb2Gtk.gtkSignalConnect(
          advInDsp.cinInp, "pressed", rcAdvanceInChangecin, null);
      Fb2Gtk.gtkWidgetSetSensitive(advInDsp.cinInp, false);

      advInDsp.cinRinp = RcGtkUtil.rcDrawButton(
          advInDsp.window,
          FbColorGroup.Pink.index,
          FbColorGroup.BlackGray.index,
          ADV_CCIN_RCIN,
          "inp",
          2);
      Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.cinRinp, 408, 204);
      Fb2Gtk.gtkSignalConnect(
          advInDsp.cinRinp, "pressed", rcAdvanceInReCashIn, null);
      Fb2Gtk.gtkWidgetSetSensitive(advInDsp.cinRinp, false);
      Fb2Gtk.gtkWidgetHide(advInDsp.cinRinp);

      advInDsp.cinCncl = RcGtkUtil.rcDrawButton(
          advInDsp.window,
          FbColorGroup.Orange.index,
          FbColorGroup.BlackGray.index,
          ADV_CCIN_CNCL,
          "cncl",
          2);
      Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.cinCncl, 408, 300);
      Fb2Gtk.gtkSignalConnect(
          advInDsp.cinCncl, "pressed", rcAdvanceInCnclChangeOut, null);
      Fb2Gtk.gtkWidgetSetSensitive(advInDsp.cinCncl, false);

      advInDsp.cinAct = RcGtkUtil.rcDrawLabel(
          advInDsp.window, FbColorGroup.Red.index, " ", "inchgout");
      FbStyle.chgStyle(
          advInDsp.cinAct,
          Color_Select[FbColorGroup.Red.index],
          Color_Select[FbColorGroup.Red.index],
          Color_Select[FbColorGroup.Red.index],
          KANJI24);
      Fb2Gtk.gtkFixedPut(advInDsp.winFix, advInDsp.cinAct, 248, 408);
      Fb2Gtk.gtkWidgetHide(advInDsp.cinAct);
    }
    Fb2Gtk.gtkGrabAdd(advInDsp.window);
    Fb2Gtk.gtkWidgetShow(advInDsp.window, "rcAdvanceInDsp");
    Fb2Gtk.sysCursorOff(advInDsp.window);

    rcAdvanceInDataDsp();

    advInDsp.inpMode = 1;
    rcAdvanceInSelBtn(0);
  }

  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_Mode_Set()
  static Future<void> rcAdvanceInModeSet() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        RcSet.rcAdvanceInScrMode();
        break;
      default:
        break;
    }
    advOldScrMode = cMem.stat.bkScrMode;
  }

  /// 関連tprxソース: rc_advancein.c - rcChk_AdvanceIn()
  static Future<bool> rcChkAdvanceIn() async {
    return ((await CmCksys.cmNetDoAreservSystem() != 0) &&
        (advInDsp.execMode != 0));
  }

  ///  関連tprxソース: rc_advancein.c - rc_AdvanceIn_cinMsgClr
  /// TODO:00010 長田 定義のみ追加
  static int rcAdvanceInCinMsgClr() {
    return 0;
  }

  ///  関連tprxソース: rc_advancein.c - rc_AdvanceIn_Entry
  /// TODO:00010 長田 定義のみ追加
  static void rcAdvanceInEntry() {
    return;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_SelBtn
  static void rcAdvanceInSelBtn(int oldFiled) {}

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIN_ChgOut
  static void rcAdvanceINChgOut(int amt) {}

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_Changecin
  static int rcAdvanceInChangecin() {
    return 0;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_ChangeCin_Mode
  static bool rcAdvanceInChangeCinMode() {
    return true;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_ReCashIn
  static int rcAdvanceInReCashIn() {
    return 0;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_Cncl_ChangeOut
  static int rcAdvanceInCnclChangeOut() {
    return Typ.OK;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_advancein.c - rc_AdvanceIn_datadsp
  static void rcAdvanceInDataDsp() {}

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rc_advancein.c - rc_AdvanceIn_InpFnc
  static int rcAdvanceInInpFnc(Object? widget, Object? data) {
    return 0;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rc_advancein.c - rc_AdvanceIn_SelBtnFnc
  static int rcAdvanceInSelBtnFnc(Object? widget, Object? data) {
    return 0;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rc_advancein.c - rc_AdvanceIn_ExecBtn
  static void rcAdvanceInExecBtn(Object? button, Object? userData) {}

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rc_advancein.c - rc_AdvanceIn_EndBtn
  static void rcAdvanceInEndBtn(Object? button, Object? userData) {}
}
