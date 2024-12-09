/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/cnct.dart';
import '../inc/rc_mem.dart';
import 'rxregmem.dart';
import '../inc/rc_regs.dart';
import '../../inc/apl/rxregmem_define.dart';
import 'rc_itm_dsp.dart';

/// 関連tprxソース: rckydisburse.c
class RckyDisBurse {

  /// 関連tprxソース: rckydisburse.c - rcCheck_KY_DISBURSE
  static Future<bool> rcCheckKYDisBurse() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ( await CmCksys.cmRainbowCardSystem() != 0
            && cMem.stat.disburseFlg != 0);
  }

  /// rcSet_ChangerItemAcrOFF()でＯＦＦにしたフラグを
  //         ＯＮに戻す。
  /// 関連tprxソース: rckydisburse.c - rcSet_ChangerItemAcrON
  static Future<void> rcSetChangerItemAcrON() async {
    AcMem cMem = SystemFunc.readAcMem();
    if( ( await CmCksys.cmRainbowCardSystem() != 0)
        && cMem.stat.changerFlg != 0){
      cMem.stat.changerFlg = 0;
      int tid = await RcSysChk.getTid();
      Cnct.cnctMemSet(tid, CnctLists.CNCT_ACR_ONOFF, 0);
      RxRegMem.rcCnctMemSet(tid,CnctLists.CNCT_ACR_ONOFF.index);
      TprLog().logAdd(tid, LogLevelDefine.normal, "Not Changer Item acr_onoff ON!!");
    }

  }

  /*-------------------------------------------------------------------------*
 *  関数: rcSet_ChangerItemAcrOFF()
 *        出納商品かつ釣銭機動作しない商品のとき
 *        自動釣銭機ＯＮ／ＯＦＦフラグをＯＦＦにする。
 *  引数: long brgn_cd1    PLUﾏｽﾀの特売ｺｰﾄﾞ1
 *                         -1の場合アイテムログからbrgn_cd1を取得する。
 *  戻値: なし
 *-------------------------------------------------------------------------*/
  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rckydisburse.c - rcSet_ChangerItemAcrOFF
  static void rcSetChangerItemAcrOFF(int brgn_cd1) {
    return;
  }

  /// 関連tprxソース: rckydisburse.c - rcky_disburse_conf
  static void rckyDisburseConf() {
    RegsMem mem = SystemFunc.readRegsMem();
    RcItmDsp.rcDualConfDestroy();
    String msg = '${RcRegs.HALF_MSG_DISBURSE} ${mem.tTtllog.t101000[0].promDscCd}';
    RcItmDsp.rcDualConf(RcRegs.HALF_MSG_DISBURSE);
    return;
  }
}