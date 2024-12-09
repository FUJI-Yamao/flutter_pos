/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_rfmdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcsyschk.dart';

/// 関連tprxソース: rc_utcnctwork.c
class RcUtcnctWork{
/*----------------------------------------------------------------------*
 * Values
 *----------------------------------------------------------------------*/
  static Object? TRANNO_window; //GtkWidget	*TRANNO_window = NULL;
  static Object? TRANNO_ent; //GtkWidget	*TRANNO_ent = NULL;
  static int inpLen = 0;
  static int inpLenMax = 0;
  static int rcUtcnctWorkDlgFlg = 0;
  static int inpKind = 0;
  static int mode = 0; // 0:代引画面 1:取消・返品
  static int oldBkScrMode = 0;
  static int utcnctFncCodeOrg = 0;
  static int kyTextFlg = 0; // 0:文字入力非表示 1:文字入力表示
  static int len2 = 0; // 0:文字入力非表示 1:文字入力表示
  static String slipNoBuf = ""; // [INPMAX+1]
  static String utcnctName = ""; // [40+1]
  static String utcnctSaleDate = ""; // [INPMAX+1]

  /// 関連tprxソース: rcky_yao_detail.c - rc_utcnctwork_Code_Draw
  static void rcUtcnctWorkCodeDraw() {
    int len;
    // 描画処理なので移植しない
    // String cd = ""; // [INPMAX+4];

    if (kyTextFlg != 0) {
      return;
    }

    if (inpLen > inpLenMax) {
      rcUtcnctWorkErr(DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
    }

    len = slipNoBuf.length;
    if (len > inpLenMax) {
      len = inpLenMax;
    }

    if (mode == 0) {
      // 描画処理なので移植しない
      // snprintf(
      //     cd, sizeof(cd), UTCNCT_FORMAT_COD, &slip_no_buf[0], &slip_no_buf[4], &
      //     slip_no_buf[8]);
    } else {
      // 描画処理なので移植しない
      // snprintf(
      //     cd, sizeof(cd), UTCNCT_FORMAT_TRAN, &slip_no_buf[0], slip_no_buf[2],
      //     &slip_no_buf[3], &slip_no_buf[9]);
    }

    if (TRANNO_ent != null) {
      // 描画処理なので移植しない
      // gtk_round_entry_set_text(GTK_ROUND_ENTRY(TRANNO_ent), cd);
    }

    return;
  }

  /// 関連tprxソース: rcky_yao_detail.c - rc_utcnctworkBtn_Draw
  static	void	rcUtcnctWorkBtnDraw(){
    // 描画処理なので移植しない
  }

  /// 関連tprxソース: rcky_yao_detail.c - rc_utcnctwork_Draw
  static Future<void> rcUtcnctworkDraw(int kind) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcUtcnctworkDraw() OrgReceipt start");

    if (!(await CmCksys.cmUTCnctSystem() != 0)) {
      return;
    }
    AcMem cMem = SystemFunc.readAcMem();

    if (FbInit.subinitMainSingleSpecialChk()) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "PLU rxMemRead error");
        return;
      }
      RxCommonBuf cBuf = xRet.object;
      cMem.stat.dualTSingle = cBuf.devId;
    } else {
      cMem.stat.dualTSingle = 0;
    }

    await RcExt.cashStatSet("rcUtcnctworkDraw");

    await rcUtcnctWorkModeSet();

    mode = kind;
    kyTextFlg = 0;

    rcUtcnctWorkInit();

    if (mode == 0) {
      inpLenMax = 12;
    } else {
      inpLenMax = 13;
    }

    TRANNO_ent = null;
    utcnctFncCodeOrg = cMem.stat.fncCode;

    rcUtcnctWorkDlgFlg = 0;

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
        if (FbInit.subinitMainSingleSpecialChk()) {
          await RcRfmDsp.rcLcdMsgDisp();
          rcUtcnctWorkBtnDraw();
        } else {
          RxInputBuf iBuf = SystemFunc.readRxInputBuf();
          if ((iBuf.devInf.devId == TprDidDef.TPRDIDTOUKEY1) ||
              (iBuf.devInf.devId == TprDidDef.TPRDIDMECKEY1)) {
            await RcRfmDsp.rcLcdMsgDisp();
          } else {
            rcUtcnctWorkBtnDraw();
          }
        }
        break;
      default:
        rcUtcnctWorkBtnDraw();
        break;
    }
    rcUtcnctWorkCodeDraw();

    return;
  }

  /// 関連tprxソース: rcky_yao_detail.c - rc_utcnctworkMode_Set
  static Future<void> rcUtcnctWorkModeSet() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE :
      case RcRegs.DESKTOPTYPE :
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR :
        oldBkScrMode = cMem.stat.bkScrMode;
        RcSet.rcUTcnctWorkScrMode();
        break;
    }
    return;
  }

  /// 関連tprxソース: rcky_yao_detail.c - rc_utcnctworkMode_Reset
  static Future<void> rcUtcnctWorkModeReset() async {
    AcMem cMem = SystemFunc.readAcMem();

    cMem.stat.scrType = 0;
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE :
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER :
      case RcRegs.KY_DUALCSHR:
        cMem.stat.scrMode = cMem.stat.bkScrMode;
        cMem.stat.bkScrMode = oldBkScrMode;
        break;
    }
    return;
  }

  /// 関連tprxソース: rcky_yao_detail.c - rc_utcnctworkInit
  static void rcUtcnctWorkInit() {
    if (kyTextFlg != 0) {
      return;
    }

    slipNoBuf = "";
    if (mode == 0) {
      slipNoBuf = "000000000000";
    } else {
      slipNoBuf = "0000000000000";
    }

    inpLen = 0;

    return;
  }

  /// 関連tprxソース: rcky_yao_detail.c - rc_utcnctwork_Err
  static void rcUtcnctWorkErr(int errNo) {
    rcUtcnctWorkDlgFlg = 1;
    rcUtcnctWorkInit();
    rcUtcnctWorkCodeDraw();
    RcExt.rcErr("rcUtcnctWorkErr", errNo);

    return;
  }
}