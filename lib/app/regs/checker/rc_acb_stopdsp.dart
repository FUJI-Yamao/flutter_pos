/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../tprlib/TprLibDlg.dart';
import '../inc/L_rc_acb_stopdsp.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';


class RcAcbStopDsp {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_acb_stopdsp.c - rc_acb_stopdsp_Draw
  static int rcAcbStopdspDraw() {
    return 0;
  }

  
  /// 関連tprxソース: rc_acb_stopdsp.c - rcLcd_StopDsp_MsgDisp
/*---------------------------------------------------------------------------------------*
 * 10.4 inch not main display is message display
 *---------------------------------------------------------------------------------------*/
static Future<void>	rcLcdStopDspMsgDisp() async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.scrData.msgLcd = LRcAcbStopDsp.ACB_STOPDSP_SUBMSG;
    if (FbInit.subinitMainSingleSpecialChk()) {
      if (cMem.stat.dualTSingle == 1) {
        RcItmDsp.dualTSingleDlgHW(cMem.scrData.msgLcd, 0, 0);
      } else {
        RcItmDsp.dualTSingleDlgHW(cMem.scrData.msgLcd, 1, 0);
      }
    } else {
      RcItmDsp.rcLcdPrice();
      await RcItmDsp.rcQtyClr();
    }
  }


}