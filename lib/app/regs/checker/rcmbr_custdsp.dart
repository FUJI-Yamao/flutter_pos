/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_buy_hist.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mbr.dart';

class RcMbrCustDsp {
  /// 声かけ画面の表示チェック
  /// 戻り値: true=表示中  false=未表示
  /// 関連tprxソース: rcmbr_custdsp.c - rcmbr_Chk_custbmp()
  static Future<bool> rcMbrChkCustBmp() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index) {
      return false;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcMbrCustDsp.rcMbrChkCustBmp(): rxMemRead error");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.attendantMbrRead == 0) {
      return false;
    }
    if ((cBuf.dbTrm.attendantMbrRead == 2)	// ターミナルの声かけ画面表示設定が「特定会員」のとき
      && !(await rcMbrCustDspSpecificMbr()))	// 特定会員か
    {
      return false;
    }
    if (await CmCksys.cmWebType() != CmSys.WEBTYPE_WEB2800) {
      return false;
    }
    if ((mem.tTtllog.t100700.realCustsrvFlg == 1) || (cBuf.custOffline == 2)) {
      return false;
    }
    if (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcVDOpeModeChk() ||
        RcSysChk.rcTROpeModeChk())) {
      return false;
    }
    if (RcFncChk.rcCheckScanCheck()) {
      return false;
    }
    if ((await RcSysChk.rcQCChkQcashierSystem()) ||
        (await RcSysChk.rcSGChkSelfGateSystem())) {
      return false;
    }

    return true;
  }

  /// 特定会員のチェック
  /// 戻り値: true=特定会員  false=特定会員でない
  /// 関連tprxソース: rcmbr_custdsp.c - rcmbr_custdsp_specific_mbr()
  static Future<bool> rcMbrCustDspSpecificMbr() async {
    if (await CmCksys.cmDs2GodaiSystem() != 0) {
      if ((await RckyBuyHist.calcRankHist(1) == 5)	// Sランク会員
          || (await RckyBuyHist.calcRankHist(1) == 4))	// Aランク会員
      {
        return true;
      }
    }
    return false;
  }
}