/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/t_item_log.dart';

class RcKyPbchg {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rckypbchg.c - rcky_Pbchg_RecChk
  static Future<int> rckyPbchgRecChk() async {
    int recCnt = 0;
    int i;

    if(await rcChkPbchgSystem()){
      for(i=0; i<RegsMem().tTtllog.t100001Sts.itemlogCnt; i++){
        if(rcPbchgRecCheck(i)){
          recCnt++;
        }
      }
    }

    return recCnt;
  }

  ///関連tprxソース:rckypbchg.c - rcChk_Pbchg_System
  static Future<bool> rcChkPbchgSystem() async {
    return ((await CmCksys.cmPbchgSystem() != 0)
        && ((RcSysChk.rcTROpeModeChk()) || (RcSysChk.rcRGOpeModeChk())));
  }

  ///関連tprxソース:rckypbchg.c - rcPbchgRecCheck
  static bool rcPbchgRecCheck(int p){
    if(p<0){
      return false;
    }
    return(RegsMem().tItemLog[p].t10003.recMthdFlg
        == REC_MTHD_FLG_LIST.PBCHG_REC.typeCd);    /* STAMP ?  */
  }

  ///関連tprxソース:rckypbchg.c - rcky_Pbchg_TtlAmt
  static Future<int> rcKyPbChgTtlAmt() async {
    int ttl = 0;
    int i = 0;

    if (await rcChkPbchgSystem()) {
      for (i = 0; i < RegsMem().tTtllog.t100001Sts.itemlogCnt; i++) {
        if (RegsMem().tItemLog[i].t10003.recMthdFlg ==
                REC_MTHD_FLG_LIST.PBCHG_REC.typeCd &&
            RegsMem().tItemLog[i].t10000.realQty != 0 &&
            RegsMem().tItemLog[i].t10002.scrvoidFlg == 0) {
          ttl += RegsMem().tItemLog[i].t10000.actNomiInPrc;
        }
      }
    }

    return ttl;
  }
}