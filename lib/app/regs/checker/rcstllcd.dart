/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/regs/checker/rc28addparts.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_key_qcselect.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl_cal.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_qctckt.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28itmdsp.dart';
import 'rc28stlinfo.dart';
import 'rc_28dsp.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rc_tab.dart';
import 'rcky_regassist.dart';
import 'rcky_sprit.dart';
import 'regs.dart';
import 'regs_preset_def.dart';

// rcstllcd.h - #define	FRAME_DISP_FLG		0	// すべて表示
// rcstllcd.h - #define	FRAME_ALL_CLEAR_FLG	1	// すべて削除
// rcstllcd.h - #define	FRAME_STL_CLEAR_FLG	2	// 小計のみ削除
const int FRAME_DISP_FLG = 0;
const int FRAME_ALL_CLEAR_FLG = 1;
const int FRAME_STL_CLEAR_FLG = 2;

// rcstllcd.h - #define ITEM_1PAGE_MAX		     7
const int ITEM_1PAGE_MAX = 7;
// rcstllcd.h - #define ITEM28_1PAGE_MAX        10	// 明細表示部の表示段数の最大値
const int ITEM28_1PAGE_MAX = 10;

///  関連tprxソース: rcstllcd.h
class RcStlLcd {
  static const FSTLLCD_CONTINUE = 0x0000;
  static const FSTLLCD_RESET_ITEMINDEX = 0x0001;
  static const FSTLLCD_NOCHGRESET_ITEMINDEX = 0x0002;
  static const FSTLLCD_NOT_LCDINIT = 0x0003;

  static TabInfo tabInfo = TabInfo();

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// Subtotal Display Function
  /// 引数:[wCtrl] アイテムインデックス
  /// 引数:[pSubTtl] サブタイトルデータ
  ///  関連tprxソース: rcstllcd.c - rcStlLcd
  static void rcStlLcd(int wCtrl, SubttlInfo pSubttl) {}

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcspj_dsp.c - rcSPJ_EndRcpt_Disp
  static void rcSPJEndRcptDisp(int type) {
    return;
  }

  ///  関連tprxソース: rcstllcd.c - rcDualStlDisp_ChgErea
  static Future<void> rcDualStlDispChgErea() async {
    if (await RcSysChk.rcCheckQCJCSystem()) {
      return;
    }

    if (await RcSysChk.rcChkDesktopCashier()) {
      return;
    }

    // TODO:00013 三浦 後回し 簡単だけど量が多い
    // rcStlLcd_ScrMode();
    if (RegsMem().tTtllog.t100001Sts.itemlogCnt == 0) {
      RcStlCal.rcStlInitilaizeBuf();
    }
    rcStlLcdDualCashier();
    rcDualCshrLcdCom();
  }

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_DualCashier
  static void rcStlLcdDualCashier() {
    // TODO:00013 三浦 後回し (重め)
    // rcStlLcd(FSTLLCD_RESET_ITEMINDEX, &Subttl);
    if (RcFncChk.rcDualHalfCondition()) {
      // TODO:00013 三浦 定義のみ実装されている
      RcItmDsp.rcDualConfDestroy();
      // TODO:00013 三浦 後回し
      // rc_Dualhalf_Default();
    }
  }

  /// LCD Display Process for KY_DUALCSHR
  ///  関連tprxソース: rcstllcd.c - rcDualCshr_LcdCom
  static void rcDualCshrLcdCom() {
    // TODO:00013 三浦 後回し
    // rcDualCshr_28LcdCom();
    return;
  }

  /// Dual Cashier Subtotal Screen Function
  /// Foramt : bool rcStlLcd_ScrMode_DualCashier (void);
  /// Input  : void
  /// Output : bool result Result to already set ScrMode for dual cashier subtotal screen
  /// 関連tprxソース: rcstllcd.c - rcStlLcd_ScrMode_DualCashier
  static Future<bool> rcStlLcdScrModeDualCashier() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.stat.scrMode) {
      case RcRegs.RG_INOUT:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_INOUT:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_INOUT:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_INOUT:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_BADD:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_BADD:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_BADD:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_BADD:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_TKISSU:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_TKISSU:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_TKISSU:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_TKISSU:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_EJCONF:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_EJCONF:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_EJCONF:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_EJCONF:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.OD_EJCONF:
        cMem.stat.scrMode = RcRegs.OD_STL;
        return false;
      case RcRegs.IV_EJCONF:
        cMem.stat.scrMode = RcRegs.IV_STL;
        return false;
      case RcRegs.PD_EJCONF:
        cMem.stat.scrMode = RcRegs.PD_STL;
        return false;
      case RcRegs.RG_EVOID:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_EVOID:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_EVOID:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_EVOID:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_EREF:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_EREF:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_EREF:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_EREF:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_EREFS:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_EREFS:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_EREFS:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_EREFS:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_EREFI:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_EREFI:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_EREFI:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_EREFI:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_ESVOID:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_ESVOID:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_ESVOID:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_ESVOID:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_ESVOIDS:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_ESVOIDS:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_ESVOIDS:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_ESVOIDS:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_ESVOIDI:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_ESVOIDI:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_ESVOIDI:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_ESVOIDI:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_ERCTFM:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_ERCTFM:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_ERCTFM:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_ERCTFM:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_CRDTVOID:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_CRDTVOID:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_CRDTVOID:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_CRDTVOID:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_CRDTVOIDS:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_CRDTVOIDI:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_CRDTVOIDI:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_CRDTVOIDI:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_CRDTVOIDI:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_PRECAVOID:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_PRECAVOID:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_PRECAVOID:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_PRECAVOID:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_PRECAVOIDS:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_PRECAVOIDS:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_PRECAVOIDS:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_PRECAVOIDS:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_PRECAVOIDI:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_PRECAVOIDI:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_PRECAVOIDI:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_PRECAVOIDI:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;

      // コンパイルスイッチ FB2GTK 定義なしの為コメントアウト
      // case RcRegs.RG_DUALSCNMBR :  cMem.stat.scrMode = RcRegs.RG_STL; return false;
      // case RcRegs.VD_DUALSCNMBR :  cMem.stat.scrMode = RcRegs.VD_STL; return false;
      // case RcRegs.TR_DUALSCNMBR :  cMem.stat.scrMode = RcRegs.TR_STL; return false;
      // case RcRegs.SR_DUALSCNMBR :  cMem.stat.scrMode = RcRegs.SR_STL; return false;
/* TWNO_S2PR */
//   #if TW
//   case RG_TWNOSET :  cMem.stat.scrMode = RcRegs.RG_STL; return false;
//   case VD_TWNOSET :  cMem.stat.scrMode = RcRegs.VD_STL; return false;
//   case TR_TWNOSET :  cMem.stat.scrMode = RcRegs.TR_STL; return false;
//   case SR_TWNOSET :  cMem.stat.scrMode = RcRegs.SR_STL; return false;
//   case RG_TWNOSR :   cMem.stat.scrMode = RcRegs.RG_STL; return false;
//   case VD_TWNOSR :   cMem.stat.scrMode = RcRegs.VD_STL; return false;
//   case TR_TWNOSR :   cMem.stat.scrMode = RcRegs.TR_STL; return false;
//   case SR_TWNOSR :   cMem.stat.scrMode = RcRegs.SR_STL; return false;
// /* 04.May.06 */
//   case RG_TWNOREF :  cMem.stat.scrMode = RcRegs.RG_STL; return false;
//   case VD_TWNOREF :  cMem.stat.scrMode = RcRegs.VD_STL; return false;
//   case TR_TWNOREF :  cMem.stat.scrMode = RcRegs.TR_STL; return false;
//   case SR_TWNOREF :  cMem.stat.scrMode = RcRegs.SR_STL; return false;
//   #endif
      case RcRegs.RG_RFM:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_RFM:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_RFM:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_RFM:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_CPWR:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_CPWR:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_CPWR:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_CPWR:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_STLDSCCNCL:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_STLDSCCNCL:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_STLDSCCNCL:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_STLDSCCNCL:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_GODUTCH:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_GODUTCH:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_GODUTCH:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_GODUTCH:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_RBTCNCL:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_RBTCNCL:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_RBTCNCL:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_RBTCNCL:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_PLUSCNCL:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_PLUSCNCL:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_PLUSCNCL:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_PLUSCNCL:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_MANUALMM:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_MANUALMM:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_MANUALMM:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_MANUALMM:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_MONEYCONF:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_MONEYCONF:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_MONEYCONF:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_MONEYCONF:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      // #if DEPARTMENT_STORE
      // case RG_ITMINF : cMem.stat.scrMode = RcRegs.RG_STL; return false;
      // case VD_ITMINF : cMem.stat.scrMode = RcRegs.VD_STL; return false;
      // case TR_ITMINF : cMem.stat.scrMode = RcRegs.TR_STL; return false;
      // case SR_ITMINF : cMem.stat.scrMode = RcRegs.SR_STL; return false;
      // case RG_TTLINF : cMem.stat.scrMode = RcRegs.RG_STL; return false;
      // case VD_TTLINF : cMem.stat.scrMode = RcRegs.VD_STL; return false;
      // case TR_TTLINF : cMem.stat.scrMode = RcRegs.TR_STL; return false;
      // case SR_TTLINF : cMem.stat.scrMode = RcRegs.SR_STL; return false;
      // #endif
      case RcRegs.RG_CHGLOAN:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_CHGLOAN:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_CHGLOAN:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_CHGLOAN:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_CHGPTN:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_CHGPTN:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_CHGPTN:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_CHGPTN:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_CHGINOUT:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_CHGINOUT:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_CHGINOUT:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_CHGINOUT:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_MDA_CRDT_DSP:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_MDA_CRDT_DSP:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_MDA_CRDT_DSP:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_MDA_CRDT_DSP:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_SRCH_REG_DSP:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_SRCH_REG_DSP:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_SRCH_REG_DSP:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_SRCH_REG_DSP:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_WIZ_RENT_DSP:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_WIZ_RENT_DSP:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_WIZ_RENT_DSP:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_WIZ_RENT_DSP:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_QR_RPR:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_QR_RPR:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_QR_RPR:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_QR_RPR:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_ACCOUNT_OFFSET_DSP:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_ACCOUNT_OFFSET_DSP:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_ACCOUNT_OFFSET_DSP:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_ACCOUNT_OFFSET_DSP:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_DELIV_SVC_DSP:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_DELIV_SVC_DSP:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_DELIV_SVC_DSP:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_DELIV_SVC_DSP:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_DELIV_SVCS_DSP:
        cMem.stat.scrMode = RcRegs.RG_STL;
        return false;
      case RcRegs.VD_DELIV_SVCS_DSP:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_DELIV_SVCS_DSP:
        cMem.stat.scrMode = RcRegs.TR_STL;
        return false;
      case RcRegs.SR_DELIV_SVCS_DSP:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;
      case RcRegs.RG_UNREAD_CASH_AMT_DSP:
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          cMem.stat.scrMode = RcRegs.RG_QC_MENTE;
          return false;
        } else {
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        }
      case RcRegs.VD_UNREAD_CASH_AMT_DSP:
        cMem.stat.scrMode = RcRegs.VD_STL;
        return false;
      case RcRegs.TR_UNREAD_CASH_AMT_DSP:
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          cMem.stat.scrMode = RcRegs.TR_QC_MENTE;
          return false;
        } else {
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        }
      case RcRegs.SR_UNREAD_CASH_AMT_DSP:
        cMem.stat.scrMode = RcRegs.SR_STL;
        return false;

      default:
        break;
    }
    return true;
  }

  /// Title  : SUB TOTAL 1PAGE ALL ITEM LCD DISPLAY
  /// Format : void rcStlLcd_Items (void);
  /// Input  : void
  /// Output : void
  /// 関連tprxソース: rcstllcd.c - rcStlLcd_Items
  static void rcStlLcdItems(SubttlInfo? pSubttl) {
    // if(rcCheck_ESVoidS_Mode() && rcCheck_CashVoid_Dsp()) {
    // return;
    // }
    // TODO:00013 三浦 必要？
    // rcStlLcd_28Items(pSubttl);
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// セルフゲートデュアルディスプレイかつサブタイトル画面かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcstllcd.c - rcSG_Dual_SubttlDsp_Chk
  static Future<bool> rcSGDualSubttlDspChk() async {
    // if (! await RcSysChk.rcSGChkSelfGateSystem()) {
    //   return false;
    // }
    // if ( ((CmCksys.cmFbDualSystem() == 2) || ((await RcSysChk.rcChk2800System())
    //     && (await RcSysChk.rcNewSGChkNewSelfGateSystem()))) &&
    //     ((DualDsp.subttl_dsp_flg == 1) ||			/*	Cash or Credit Only	*/
    //         (DualDsp.subttl_dsp_flg == 2) ||			/*	Cash of Select		*/
    //         (DualDsp.subttl_dsp_flg == 3) ||			/*	Credit of Select	*/
    //         (DualDsp.subttl_dsp_flg == 4) ||			/*	Edy of Select	*/
    //         (DualDsp.subttl_dsp_flg == 5) ||			/*	Suica of Select	*/
    //         (DualDsp.subttl_dsp_flg == 6) ||			/*	VISATouch of Select	*/
    //         (rcChk_SpritTranEnd()       ) ||                 /*      Other of Select         */
    //         (SelfRWReadDsp.RW_Read_disp == 1) ||     /*  RW Read Display */
    //         (MbrScnDsp2.mbrscn_disp == 1) ||         /*  Mbr Card Scan Display */
    //         (SelfRWReadDsp2.RW_Read_disp == 1)) ) {
    //   /*  RW Read Display */
    //   return true;
    // }
    // else if ((await RcSysChk.rcChkQuickSelfSystem()) &&
    //     ((DualDsp.subttl_dsp_flg == 1) ||			/*	Cash or Credit Only	*/
    //         (DualDsp.subttl_dsp_flg == 2) ||			/*	Cash of Select		*/
    //         (DualDsp.subttl_dsp_flg == 3) ||			/*	Credit of Select	*/
    //         (DualDsp.subttl_dsp_flg == 4) ||			/*	Edy of Select	*/
    //         (DualDsp.subttl_dsp_flg == 5) ||			/*	Suica of Select	*/
    //         (DualDsp.subttl_dsp_flg == 6) ||			/*	VISATouch of Select	*/
    //         (rcChk_SpritTranEnd()       ) ||                 /*      Other of Select         */
    //         (SelfRWReadDsp.RW_Read_disp == 1) ||     /*  RW Read Display */
    //         (MbrScnDsp2.mbrscn_disp == 1) ||         /*  Mbr Card Scan Display */
    //         (SelfRWReadDsp2.RW_Read_disp == 1)) ) {
    //   /*  RW Read Display */
    //   return true;
    // }
    return false;
  }

  // 非操作画面でのダイアログ表示を関数化したもの
  ///  関連tprxソース: rcstllcd.c - rcDrawMsgOtherDisp
  static Future<void> rcDrawMsgOtherDisp(int imgCode, String msg) async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    if (await RcSysChk.rcKySelf() != RcRegs.KY_SINGLE) {
      return;
    }

    cMem.scrData.msgLcd = "";

    if (imgCode != 0) {
      EucAdj adf = AplLibImgRead.aplLibImgRead(int.parse(cMem.scrData.msgLcd));
    } else if (msg != "") {
      cMem.scrData.msgLcd = msg;
    }

    if (FbInit.subinitMainSingleSpecialChk()) {
      cMem.stat.dualTSingle = cBuf.devId;
      if (cMem.stat.dualTSingle == 1) {
        RcItmDsp.DualTSingleDlg(cMem.scrData.msgLcd, 0);
      } else {
        RcItmDsp.DualTSingleDlg(cMem.scrData.msgLcd, 1);
      }
    }
  }

  /// 関連tprxソース: rcstllcd.c - rcStlLcdQuit
  static Future<void> rcStlLcdQuit(SubttlInfo pSubttl) async {

    TprTID tid = await RcSysChk.getTid();

    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    if (pSubttl.window == null) {
      TprLog().logAdd(
          tid, LogLevelDefine.normal, "rcetlLcdQuit window NULL");
    }

    Dummy.rcModeFrameDisp( FRAME_STL_CLEAR_FLG );
    RckyRegassist.rcRegAssistRprDispDestroy();
    await RcSet.rcItmLcdScrMode();
    RcItmDsp.rcDualConfDestroy();

    if (await RcSysChk.rcChkSptendInfo()) {
      Dummy.rcSptendInfoQuit(pSubttl);
      if (await FbInit.subinitMainSingleSpecialChk()) {
        Dummy.rcSptendInfoQuit(pSubttl);
      }
    }

    Dummy.rcKyExtKeyQuit(pSubttl);
    Dummy.rcCustMsgStlDestroy(pSubttl);
    Dummy.rcMbrInfoIconDisp(0, pSubttl, 1);

    if ( (await RcSysChk.rcChkQuickSelfSystem()) && (pSubttl.window != null) ) {
      //小計画面が消されるので拡張ボタンも消す(widget存在チェックのためNULLにしたい)
      if (pSubttl.stlExtPresetBtn != null) {
        Fb2Gtk.gtkWidgetDestroy(pSubttl.stlExtPresetBtn);
        pSubttl.stlExtPresetBtn = null;
      }
      Fb2Gtk.gtkWidgetDestroy(pSubttl.window);
      pSubttl.window = null;
      pSubttl.pixQty = null;  /* 買上点数再表示の為 */
    } else {
      //小計画面が消されるので拡張ボタンも消す(widget存在チェックのためNULLにしたい)
      if (pSubttl.stlExtPresetBtn != null) {
        Fb2Gtk.gtkWidgetDestroy(pSubttl.stlExtPresetBtn);
        pSubttl.stlExtPresetBtn = null;
      }
      if (pSubttl.window != null) {
        Fb2Gtk.gtkWidgetDestroy(pSubttl.window);
        pSubttl.window = null;
        pSubttl.pixQty = null;  /* 買上点数再表示の為 */
      }
    }

    pSubttl.mbrParts = MbrDispData();
    pSubttl.tranInfo = null;
    pSubttl.offlineInfo = null;
    Rc28dsp.rcTabCounterDataSet(tabInfo.dspTab);
    // 会員購買レベルアイコンなどの描画
    Dummy.rcMbrInfoIconDisp(0, null, 0);

    for(var num = 0; num < ITEM28_1PAGE_MAX; num++ )
    {
      pSubttl.ItemInfo2[num].ItmNum       = null;
      pSubttl.ItemInfo2[num].ItmNumFixed  = null;
      pSubttl.ItemInfo2[num].itmButton    = null;
      pSubttl.ItemInfo2[num].itmBtnFixed  = null;
      pSubttl.ItemInfo2[num].itmBtnFixed2 = null;
    }
    RcKyQcSelect.rcClearStlPopUpQcSelect();
    RckyQctckt.rcDispDivAdjEntry( Typ.ON );	// 分割精算表示
    Rc28AddParts.rc28GuidanceDestroy( pSubttl );

    Dummy.rckyChgstatusDestroySubttl(); //共通小計プリセットの釣機状態ラベルを削除
  }

  /// Subtotal Display Function (Total portion)
  /// 引数:[wCtrl] アイテムインデックス
  /// 引数:[pSubTtl] サブタイトルデータ
  /// 関連tprxソース: rcstllcd.c - rcStlLcd_Totalizers
  static Future<void> rcStlLcdTotalizers(int wCtrl, SubttlInfo pSubTtl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    if (CompileFlag.REWRITE_CARD) {
      if ((RcSgDsp.selfRWReadDsp.rwReadDisp == 1) ||
          (RcSgDsp.selfRWReadDsp2.rwReadDisp == 1)) {
        return;
      }
    }
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (RegsPresetDef.RM3800_DSP != 0) {    // RM-5900の場合
      if (cBuf.vtclRm5900RegsOnFlg) {
        return;
      }
    }
    if ((await RcSysChk.rcChkSmartSelfSystem()) &&
        (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {    // HappySelf<フル>
      AtSingl atSing = SystemFunc.readAtSingl();
      if (atSing.verifoneChargeHappySelf == 1) {
        return;
      }
    }

    if (!(await RcFncChk.rcCheckVoidComDispMode())) {
      if (pSubTtl != RegsDef.dualSubttl) {
        rcStlLcdScreen();
      }
      if (await RcSysChk.rcChkVFHDSelfSystem()) {    /* 15.6インチフルセルフ */
        return;	/* ScrModeを変更したいだけ */
      }
      if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
        rcStlLcdRest(pSubTtl);
      }
      await rcStlLcdSusReg(pSubTtl);
      await rcStlLcdRevReg(pSubTtl);
      await rcStlLcdMbrPrn(pSubTtl);
      if (CompileFlag.DEPARTMENT_STORE) {
        rcStlLcdOMC(pSubTtl);
      } else {
        await rcStlLcdCarry(pSubTtl);
      }
      rcStlLcdCardForgot(pSubTtl);
      await rcStlLcdMMReg(pSubTtl);
      await rcStlLcdHomeDlv(pSubTtl);
      Rc28StlInfo.rc28StlLcdSuicaTrans(pSubTtl);
    }
    await rcStlLcdCashInt(pSubTtl);

    /* SubTotal Amount Title And Price & Tax & Subtotal Disc & Service */
    await rcStlLcdTotal(pSubTtl);

    if (await RcFncChk.rcCheckVoidComMainDispMode()) {
      // 検索訂正, 検索返品では非表示
      // TODO:10122 グラフィクス処理（gtk_*）
      /*
      gtk_widget_hide(pSubTtl->Menubar.online_btn);
      gtk_widget_hide(pSubTtl->Menubar.pix_online);
      gtk_widget_hide(pSubTtl->menuButton);
      gtk_widget_hide(pSubTtl->Menubar.PixMenu);
       */
      await rcStlLcdRevReg(pSubTtl);
      await rcStlLcdMbrPrn(pSubTtl);
      if (await RcFncChk.rcCheckESVoidSMode()) {
        rcStlLcdESVoidAllCancel(pSubTtl);
        await rcStlLcdESVoidDscChange(pSubTtl);
      }
    }

    AcMem cMem = SystemFunc.readAcMem();
    /* Total Tend Amount Title And Price */
    if ((cBuf.dbTrm.exceptOthcashRecalc != 0) &&
        RcRegs.kyStC4(cMem.keyStat[FncCode.KY_FNAL.keyId]) &&
        (cMem.stat.fncCode == FuncKey.KY_CASH.keyId)) {
      /* post tendering? */
      rcStlLcdTend(TendData.TD_PTDATA.index, pSubTtl);
    } else {
      rcStlLcdTend(TendData.TD_STDATA.index, pSubTtl);
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if (!(await RcFncChk.rcCheckESVoidSMode()) &&
        !(await RcFncChk.rcCheckESVoidIMode()) &&
        !(await RcFncChk.rcCheckESVoidCMode())) {
      if (CompileFlag.SELF_GATE && (await rcSGDualSubttlDspChk())) {
        rcStlLcdTendChange(TendChange.TDC_SPDATA.index, pSubTtl);
      } else {
        /* Tend Change Amount Title And Price or Entry Tend Change */
        if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
          rcStlLcdEntry(EntryPart.ET_CLEAR.index, pSubTtl);
        } else {
          if (wCtrl == FSTLLCD_RESET_ITEMINDEX) {
            rcStlLcdEntry(EntryPart.ET_CLEAR.index, pSubTtl);
          } else {
            rcStlLcdTendChange(TendChange.TDC_SPDATA.index, pSubTtl);
          }
        }
      }
    }

    /* Change Amount Title And Price */
    if (wCtrl == FSTLLCD_RESET_ITEMINDEX) {
      rcStlLcdChange(ChangePart.CT_CLEAR.index, pSubTtl);
    } else if (wCtrl == FSTLLCD_NOCHGRESET_ITEMINDEX) {
      rcStlLcdChange(ChangePart.CT_CLEAR.index, pSubTtl);
    } else if ((await RcFncChk.rcCheckESVoidSMode()) ||
        (await RcFncChk.rcCheckESVoidIMode())) {
      rcStlLcdChange(ChangePart.CT_CLEAR.index, pSubTtl);
    } else {
      rcStlLcdChange(ChangePart.CT_CHANGE.index, pSubTtl);
    }

    /* Quantity Title And Price */
    if (CompileFlag.SELF_GATE && (await rcSGDualSubttlDspChk())) {
      rcSGSubttlFrameArea();
      if (((cBuf.dbTrm.selfSlctKeyCd == 1) && (await CmCksys.cmCrdtSystem() != 0)) ||
          ((cBuf.dbTrm.selfSlctKeyCd == 3) && (await CmCksys.cmCrdtSystem() != 0) && (await RcSysChk.rcChkEdySystem())) ||
          ((cBuf.dbTrm.selfSlctKeyCd == 0) && RcSysChk.rcSGCheckOtherPay()) ||
          ((cBuf.dbTrm.selfSlctKeyCd == 4) && (await RcSysChk.rcChkEdySystem()))) {
        if (RcSgDsp.subDsp.subDisp == SUB_CASH_ORDER.SUB_CASHSTART_IN.index) {
          rcSGRetenBtnDisp();
        }
      }
    }
    await rcStlLcdQuantity(pSubTtl);

    // 会員情報の表示
    Rc28dsp.rcMbrInfoIconDisp(0, pSubTtl, 0);
    // 会員サブ情報の表示
    Rc28dsp.rcDispMbrSubInfo(pSubTtl, MascotStatusList.MASCOT_ACT_STATUS.index, 0);

    /* 通番訂正 差額返金対応 */
    Rc28dsp.rc28CreatePartsRcptBtn(pSubTtl);
    if (FbInit.subinitMainSingleSpecialChk()) {
      Rc28dsp.rc28CreatePartsRcptBtn(RegsDef.dualSubttl);
    }
  }

  /// Subtotal Screen Function
  /// 関連tprxソース: rcstllcd.c - rcStlLcd_Screen
  static void rcStlLcdScreen() {}

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  /// Subtotal Dual Display Function
  /// 引数:サブタイトル部のデータ
  /// 関連tprxソース: rcstllcd.c - rcStlLcd_Rest
  static void rcStlLcdRest(SubttlInfo pSubttl) {}

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_SusReg
  static Future<void> rcStlLcdSusReg(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rc28StlLcdSusReg(pSubttl);
  }

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_RevReg
  static Future<void> rcStlLcdRevReg(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        return;
      }
    }
    Rc28StlInfo.rc28StlLcdSusReg(pSubttl);
  }

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_MbrPrn
  static Future<void> rcStlLcdMbrPrn(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        return;
      }
    }
    Rc28StlInfo.rc28StlLcdSusReg(pSubttl);
  }

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_OMC
  static Future<void> rcStlLcdOMC(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rc28StlLcdOMC(pSubttl);
  }

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_Carry
  static Future<void> rcStlLcdCarry(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rc28StlLcdCarry(pSubttl);
  }

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_CardForgot
  static void rcStlLcdCardForgot(SubttlInfo pSubttl) {}

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_MMReg
  static Future<void> rcStlLcdMMReg(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rc28StlLcdMMReg(pSubttl);
  }

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_HomeDlv
  static Future<void> rcStlLcdHomeDlv(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rc28StlLcdHomeDlv(pSubttl);
  }

  /// Sub Total Casher Int
  /// 引数:サブタイトル部のデータ
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_CashInt
  static Future<void> rcStlLcdCashInt(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) {
      AcMem cMem = SystemFunc.readAcMem();
      if (cMem.stat.cashintFlag != 0) {
        cMem.stat.cashintFlag = 0;
      }
    }
  }

  /// Subtotal Display Function (Total part)
  /// 引数:サブタイトル部のデータ
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_Total
  static Future<void> rcStlLcdTotal(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rcStlLcd28Total(pSubttl);
  }

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_ESVoid_AllCancel
  static void rcStlLcdESVoidAllCancel(SubttlInfo pSubttl) {}

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_ESVoid_DscChange
  static Future<void> rcStlLcdESVoidDscChange(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rc28StlLcdESVoidDscChange(pSubttl);
  }

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  /// Subtotal Display Function (Tend part)
  /// 引数:[wTndCtrl] Tend Control
  /// 引数:[pSubttl] サブタイトル部のデータ
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_Tend
  static void rcStlLcdTend(int wTndCtrl, SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  /// Subtotal Display Function (TendChange part)
  /// 引数:[wTchgCtrl] Tend-Change Control
  /// 引数:[pSubttl] サブタイトル部のデータ
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_TendChange
  static void rcStlLcdTendChange(int wTchgCtrl, SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  /// Subtotal Display Function (Entry part)
  /// 引数:[wEntCtrl] Entry Control
  /// 引数:[pSubttl] サブタイトル部のデータ
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_Entry
  static void rcStlLcdEntry(int wEntCtrl, SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  /// Subtotal Display Function (Change part)
  /// 引数:[wChgCtrl] Change Control
  /// 引数:[pSubttl] サブタイトル部のデータ
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_Change
  static void rcStlLcdChange(int wChgCtrl, SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  /// Subtotal Display Funciton (SpritTend Cancel)
  /// 引数:[imgCd] Image No
  /// 引数:[pSubttl] サブタイトル部のデータ
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_Sprit_Cncl
  static void rcStlLcdSpritCncl(int imgCd, SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  ///  関連tprxソース: rcstllcd.c - rcSG_Subttl_Frame_Area
  static void rcSGSubttlFrameArea() {}

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  ///  関連tprxソース: rcstllcd.c - rcSG_Reten_Btn_Disp
  static void rcSGRetenBtnDisp() {}

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_Quantity
  static Future<void> rcStlLcdQuantity(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rc28StlLcdQuantity(pSubttl);
  }

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_SetPage
  static bool rcStlLcdSetPage(int page) {
    return false;
  }

  ///  関連tprxソース: rcstllcd.c - rcStlLcd_MbrInfo
  static Future<void> rcStlLcdMbrInfo(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    Rc28StlInfo.rcDspMbrMk28StlLCD(pSubttl);
  }

  /// Sub Total Person
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_Person
  static Future<void> rcStlLcdPerson(SubttlInfo pSubttl) async {
    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }
    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        return;
      }
    }
    Rc28ItmDsp.rcPersonMark28Lcd(pSubttl);
  }

  /// 関連tprxソース: rcstllcd.c - rcSG_Dual_Crdt_SubttlDsp_Chk
  static Future<bool> rcSGDualCrdtSubttlDspChk() async {
    if (!await RcSysChk.rcSGChkSelfGateSystem()){ return false; }

    if ((await RcSysChk.rcSGChkSelfGateSystem() == false || (await RcSysChk.rcChk2800System() && await RcSysChk.rcNewSGChkNewSelfGateSystem())) &&
        (RcFncChk.rcSGCheckSlctMode() ||
            RcFncChk.rcSGCheckCrdtReadMode() ||
            Dummy.rcSGCheckEndCrdtMode() ||
            Dummy.rcSGCheckUseCrdtMode())) {
      return true;
    } else if (await RcSysChk.rcChkQuickSelfSystem() == true &&
        (RcFncChk.rcSGCheckSlctMode() ||
            RcFncChk.rcSGCheckCrdtReadMode() ||
            Dummy.rcSGCheckEndCrdtMode() ||
            Dummy.rcSGCheckUseCrdtMode())) {
      return true;
    }

    return false;
  }

  /// Subtotal Display Function (Entry part)
  /// 戻り値: result Result to already set ScrMode for subtotal screen
  ///  関連tprxソース: rcstllcd.c - rcStlLcd_ScrMode
  static Future <bool> rcStlLcdScrMode() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (!await RcFncChk.rcCheckStlMode()){
      switch (cMem.stat.scrMode) {
        case RcRegs.RG_ITM:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_ITM:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_ITM:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_ITM:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.OD_ITM:
          cMem.stat.scrMode = RcRegs.OD_STL;
          return false;
        case RcRegs.IV_ITM:
          cMem.stat.scrMode = RcRegs.IV_STL;
          return false;
        case RcRegs.PD_ITM:
          cMem.stat.scrMode = RcRegs.PD_STL;
          return false;
        case RcRegs.RG_TELST:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_TELST:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_TELST:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_TELST:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_CRDT:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_CRDT:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_CRDT:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_CRDT:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_EREFS:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_EREFS:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_EREFS:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_EREFS:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_ESVOIDS:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_ESVOIDS:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_ESVOIDS:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_ESVOIDS:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_CRDTVOIDS:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_CRDTVOIDS:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_CRDTVOIDS:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_CRDTVOIDS:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_PRECAVOIDS:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_PRECAVOIDS:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_PRECAVOIDS:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_PRECAVOIDS:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_SG_INST:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_INST:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_ITEM:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_ITEM:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_OPE:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_OPE:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_LIST:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_LIST:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_PRE:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_PRE:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_MNT:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_MNT:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_END:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_END:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_MBRSCN:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_MBRSCN:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_SLCT:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_SLCT:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_BALSLCT:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_BALSLCT:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_CHK:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_CHK:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_NEWSG_EXP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_NEWSG_EXP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_EDY_BAL:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_EDY_BAL:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_EDY_BALAF:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_EDY_BALAF:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_EDYTCH:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_EDYTCH:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_NPW:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_NPW:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_SUICA_CHK:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_SUICA_CHK:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_SUICA_CHKAF:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_SUICA_CHKAF:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_SUICA_TCH:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_SUICA_TCH:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_MCP200_DSP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_MCP200_DSP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_DMC_SLCT:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_DMC_SLCT:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_BAG_INP_DSP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_BAG_INP_DSP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_NEWSG_STRBTN:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_NEWSG_STRBTN:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_BAG_SCAN_DSP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_BAG_SCAN_DSP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_STLDSCCNCL:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_STLDSCCNCL:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_STLDSCCNCL:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_STLDSCCNCL:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_GODUTCH:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_GODUTCH:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_GODUTCH:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_GODUTCH:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_RBTCNCL:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_RBTCNCL:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_RBTCNCL:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_RBTCNCL:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_PLUSCNCL:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_PLUSCNCL:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_PLUSCNCL:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_PLUSCNCL:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_MONEYCONF:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_MONEYCONF:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_MONEYCONF:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_MONEYCONF:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_ACCOUNT_OFFSET_DSP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_ACCOUNT_OFFSET_DSP:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_ACCOUNT_OFFSET_DSP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_ACCOUNT_OFFSET_DSP:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_DELIV_SVCS_DSP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.VD_DELIV_SVCS_DSP:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.TR_DELIV_SVCS_DSP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.SR_DELIV_SVCS_DSP:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_CREDIT_SIGN_ERR_DSP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_CREDIT_SIGN_ERR_DSP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.VD_CREDIT_SIGN_ERR_DSP:
          cMem.stat.scrMode = RcRegs.VD_STL;
          return false;
        case RcRegs.SR_CREDIT_SIGN_ERR_DSP:
          cMem.stat.scrMode = RcRegs.SR_STL;
          return false;
        case RcRegs.RG_SG_AGECHECK_SELECT_DSP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_AGECHECK_SELECT_DSP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;
        case RcRegs.RG_SG_AGECHECK_DEVICE_DSP:
          cMem.stat.scrMode = RcRegs.RG_STL;
          return false;
        case RcRegs.TR_SG_AGECHECK_DEVICE_DSP:
          cMem.stat.scrMode = RcRegs.TR_STL;
          return false;

        default:
          break;
        }
      return true;
    }
    return false;
  }
}

/// 表示タイプ
///  関連tprxソース: rcstllcd.h - ENTRY_DISP_TYPE
enum EntryDispType {
  ENT_R,
  ENT_L,
  ENT_R_SEP,
  ENT_R_ZERO_PAD,
  ENT_L_ZERO_PAD,
  ENT_DATE_YYYYMMDD,
  ENT_R_ALL_DIGIT
}

/// 共通簡易入力で使用する構造体
///  関連tprxソース: rcstllcd.h - CommonLimitedInput
class CommonLimitedInput {
  // GtkWidget	*window;	// NULL以外が入っていると簡易入力動作が可能
  // GtkWidget	*window2;	// タワー用の画面
  // GtkWidget	*entryDisp;	// rcComLtdSetEntryNum()用  対象のウィジェットをセット
  Function? keyFunc;	// 値数した時に動作させる関数
  Function? obrFunc;	// スキャンした時に動作させる関数
  Function? inpFunc;	// 入力キー(PLUキー)を押下した時に動作させる関数
  Function? tchFunc;	// タッチ入力した時に動作させる関数
  Function? mcdFunc;	// カード入力した時に動作させる関数
  int keyEvent = 0; // キー入力イベント処理  0:非動作 1:動作
  int obrEvent = 0; // スキャン入力イベント処理  0:非動作 1:動作
  int tchEvent = 0; // タッチ入力イベント処理  0:非動作 1:動作
  int mcdEvent = 0; // カード入力イベント処理  0:非動作 1:動作
  int entryDispType = 0; // 入力値の表現タイプをENTRY_DISP_TYPEからセット
  int entryDispMax = 0; // ENTRY_DISP_TYPEが [ENT_R_SEP] の時に使用  表示桁数を制限
  int entrySpaceRAdj = 0; // エントリー表示が右寄せの場合に位置調整のための半角スペース埋め  0以外の数値分半角スペースを付加
  int entryMax = 0; // 入力桁数の最大値
  int entryCnt = 0; // 現在の入力桁数
  int minusFlag = 0; // マイナス状態をセット
  String entryBuf = ""; //[COMLTD_MAX_DIGIT+1];		// 値数データ
  String entryDispDef = "";  //[COMLTD_MAX_DIGIT*2+2];	// rcComLtdSetEntryNum()用  クリアした時に表示されるデフォルトの数値文字列
}

/// プリセットキーのデータ
///  関連tprxソース: rcstllcd.h - CommonLimitedInput
class PresetInfo {
  /// Preset Group Code
  int presetGrpCd = 0;
  /// Preset Code
  int presetCd = 0;
  /// Preset No
  int presetNo = 0;
  /// Preset_Color
  int presetColor = 0;
  /// Function Code
  int kyCd = 0;
  /// PLU Code
  String kyPluCd = '';
  /// Small Class Code
  int kySmlclsCd = 0;
  /// Preset Key Size
  int kySizeFlg = 0;
  /// Preset Key Status
  int kyStatus = 0;
  /// Preset Key Name
  String kyName = '';
  int num = 0;
  int imgNum = 0;
  String imgName = '';
  // RM-3800追加
  /// 従業員番号
  int rm59StaffCd = 0;
  int rm59Qty = 0;
  PresetInfo({
      this.presetGrpCd = 0,
      this.presetCd = 0,
      this.presetNo = 0,
      this.presetColor = 0,
      this.kyCd = 0,
      this.kyPluCd = '',
      this.kySmlclsCd = 0,
      this.kySizeFlg = 0,
      this.kyStatus = 0,
      this.kyName = '',
      this.num = 0,
      this.imgNum = 0,
      this.imgName = '',
      this.rm59StaffCd = 0,
      this.rm59Qty = 0
  });

  factory PresetInfo.fromMap(Map<String, dynamic> map) {
    return PresetInfo(
      presetGrpCd: int.tryParse(map['preset_grp_cd']?.toString() ?? '') ?? 0,
      presetCd: int.tryParse(map['preset_cd']?.toString() ?? '') ?? 0,
      presetNo: int.tryParse(map['preset_no']?.toString() ?? '') ?? 0,
      presetColor: int.tryParse(map['presetcolor']?.toString() ?? '') ?? 0,
      kyCd: int.tryParse(map['ky_cd']?.toString() ?? '') ?? 0,
      kyPluCd: map['ky_plu_cd'] ?? '',
      kySmlclsCd: int.tryParse(map['ky_smlcls_cd']?.toString() ?? '') ?? 0,
      kySizeFlg: int.tryParse(map['ky_size_flg']?.toString() ?? '') ?? 0,
      kyStatus: int.tryParse(map['ky_status']?.toString() ?? '') ?? 0,
      kyName: map['ky_name'] ?? '',
      num: int.tryParse(map['num']?.toString() ?? '') ?? 0,
      imgNum: int.tryParse(map['img_num']?.toString() ?? '') ?? 0,
      imgName: map['img_name'] ?? '',
      rm59StaffCd: int.tryParse(map['rm59_staff_cd']?.toString() ?? '') ?? 0,
      rm59Qty: int.tryParse(map['rm59_qty']?.toString() ?? '') ?? 0,
    );
  }
}

/// サブタイトル部のデータ
///  関連tprxソース: rcstllcd.h - Subttl_Info
class SubttlInfo{
  //GtkWidget *window;
  Object? window;
  // GtkWidget *stlExtPreset_Btn;
  Object? stlExtPresetBtn;
  // GtkWidget *pix_qty;
  Object? pixQty;
  // GtkWidget *tran_info;
  Object? tranInfo;
  // 	GtkWidget *offline_info;
  Object? offlineInfo;
  // MbrDispData	MbrParts;
  MbrDispData mbrParts = MbrDispData();
  // Subttl_Item_Info ItemInfo[ITEM_1PAGE_MAX];
  // Subttl_Item_Info ItemInfo2[ITEM28_1PAGE_MAX];
  List<SubttlItemInfo> ItemInfo = List.generate(ITEM_1PAGE_MAX, (index) => SubttlItemInfo());
  List<SubttlItemInfo> ItemInfo2 = List.generate(ITEM28_1PAGE_MAX, (index) => SubttlItemInfo());
  SubttlSptendInfo sptendInfo = SubttlSptendInfo();
}

/// 関連tprxソース: rcstllcd.h - Subttl_Item_Info
class SubttlItemInfo {
  // GtkWidget *itmButton;         /* LCD Item Button Widget */
  // GtkWidget *itmButton2;        /* LCD Item Button2 Widget */
  // GtkWidget *itmBtnFixed;       /* LCD Item ButtonFixed Widget */
  // GtkWidget *itmBtnFixed2;      /* LCD Item ButtonFixed2 Widget */
  // GtkWidget *ItmNum;            /* LCD Item Number Widget */
  // GtkWidget *ItmNumFixed;       /* LCD Item NumberFixed Widget */
  Object? itmButton;
  Object? itmButton2;
  Object? itmBtnFixed;
  Object? itmBtnFixed2;
  Object? ItmNum;
  Object? ItmNumFixed;
}

/// 顧客画面に表示されるアイテムのデータ
///  関連tprxソース: rcstllcd.h - MbrDispData
class MbrDispData {
  // TODO:10122 グラフィクス処理（gtk_*）
  /*
  GtkWidget *zoom_btn;
  GtkWidget *sub_frame;	// 小計画面にのみ存在する顧客情報のエリア
  GtkWidget *sub_label;	// 小計画面にのみ存在する顧客情報のラベル
  GtkWidget *zoomout_btn;	// 顧客情報の詳細表示時の縮小ボタン
  GtkWidget *zoom_frame;	// 顧客情報の詳細表示時のエリア
  GtkWidget *zoom_label;	// 顧客情報の詳細表示時のラベル
  GtkWidget *zoom_window;	// 顧客情報の詳細表示時の透明な入力通過window
  GtkWidget *info_frame;
  GtkWidget *info_label;
  GtkWidget *info_icon[MBRIFNO_ICON_MAX];		// 顧客情報詳細部に表示されるアイコン
  GtkWidget *info_icon_base[MBRIFNO_ICON_MAX];	// 上記の下地部分(黒枠部に相当)
  GtkWidget *info_alloc_data[MBRIFNO_ALLOC_MAX];	// 上記の個別ラベル用データ
  GtkWidget *mk_entry;
  GtkWidget *mk_fix;
  GtkWidget *mascot_chara;	// 企業別のマスコットキャラクター表示
  GtkWidget *sub_icon[MBRIFNO_SUB_ICON_MAX];	// 小計画面にのみ存在する顧客情報に表示されるアイコン
  GtkWidget *sub_icon_base[MBRIFNO_SUB_ICON_MAX];	// 上記の下地部分(黒枠部に相当)
  GtkWidget *sub_alloc_data[MBRIFNO_ALLOC_MAX];	// 上記の個別ラベル用データ
  GtkWidget *sub_parts[MBRIFNO_SUB_PARTS_MAX];	// 小計画面にのみ存在する顧客情報上のパーツ
  #if !(RM3800_DSP)
  GtkWidget *rm59_mbr_info_pix;			// RM-3800 新UIの顧客情報の下地画像
  #endif
   */
}

/// スプリット選択情報
///  関連tprxソース: rcstllcd.h - Sptend_Info_Select
class SptendInfoSelect {
  //GtkWidget *selBtn;    /* LCD Sptend Info select button Widget */
  //GtkWidget *selFrm[4]; /* LCD Sptend Info select Frame Widget */
}

/// Sptend Info
///  関連tprxソース: rcstllcd.h - Subttl_Sptend_Info
class SubttlSptendInfo {
  Object? sptendinfoFixed;        /* LCD Sptend InfoFixed Widget */
  /*
  GtkWidget	*sptendinfoWall;         /* LCD Sptend InfoFixed Widget */
  SptendParts	TendParts[SPTEND_PAGE_MAX_LINE];
  GtkWidget	*TendPageUpBtn;		// 前頁ボタン
  GtkWidget	*TendPageDownBtn;	// 次頁ボタン
  GtkWidget	*sptend_TtlAmt;		// 合計金額
  GtkWidget	*sptend_Split_TtlAmt;	// 支払合計
  GtkWidget	*sptend_RestAmt;
  Sptend_Info_Select	sptendinfo_select[SPTEND_PAGE_MAX_LINE];   // スプリット選択
   */
}

/// Tend Data
///  関連tprxソース: rcstllcd.h
enum TendData {
  TD_SPDATA,  /* Sprit    Tend Data */
  TD_PTDATA,  /* Post     Tend Data */
  TD_STDATA,  /* SubTotal Tend Data */
}

/// Tend Change part
///  関連tprxソース: rcstllcd.h
enum TendChange {
  TDC_SPDATA, /* Sprit Tend Data */
  TDC_PTDATA, /* Post Tend Data */
  TDC_DSCDATA, /* Subtotal Discount */
  TDC_PDSCDATA, /* Subtotal Percnet Discount */
  TDC_PLUSDATA, /* Subtotal Percnet Plus */
  TDC_MRATEDATA, /* Magnification Rate Change Data */
  TDC_STAFFDATA, /* 従業員名表示 */
}

/// Entry part
///  関連tprxソース: rcstllcd.h
enum EntryPart {
  ET_CLEAR,
  ET_ENTRY, /* Entry data */
  ET_MULTI, /* Entry Mul  */
  ET_TEL, /* Entry Tel  */
  ET_COMP, /* Entry COMP */
  ET_BARIN, /* Entry BARCDINPUT */
  ET_TCPN, /* Entry Tcoupon */
  ET_ITMQTY, /* Entry ItemQty */
}

/// Change part
///  関連tprxソース: rcstllcd.h
enum ChangePart {
  CT_CLEAR,
  CT_CHANGE, /* Change */
  CT_SHORT, /* Tend   */
  CT_PTCHG, /* Post Tend Change */
  CT_DSCPDSC, /* Discount/Per Disc */
  CT_INOUT, /* InOut Change */
}

///  関連tprxソース: rcstllcd.h - MASCOT_STATUS_LIST
enum MascotStatusList {
  MASCOT_ACT_STATUS,
  MASCOT_THANKS_STATUS,
}

/// Extension Subtotal Preset Key
///  関連tprxソース: rcstllcd.h - EXTKY_TYPE
enum ExtkyType {
  EXTKY_NON(-1),		//拡張プリセット非表示
  EXTKY_STL(0),		//小計拡張プリセット
  EXTKY_REG_ASSIST(1),	//商品登録補助プリセット(機能補助プリセット)
  EXTKY_ASSIST(2),		//登録補助プリセット
  EXTKY_PAYMENT(3);		//決済プリセット

  final int id;
  const ExtkyType(this.id);
}
