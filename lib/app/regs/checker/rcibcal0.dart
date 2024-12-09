/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_stl.dart';
import 'package:flutter_pos/app/regs/checker/rcibcal2.dart';

import '../../inc/apl/rxregmem_define.dart';

class RcIbCal0{

  /// 関連tprxソース: rcibcal0.c - rcStlItemCustCalc
  static void rcStlItemCustCalc(){
    int p; /* index to ITMRBUF */

    //cm_clr((char *) OT->atCustTbl,  sizeof(OT->atCustTbl));   /* Cust Table Init */

    for(p=0; p<RegsMem().tTtllog.t100001Sts.itemlogCnt; p++){
      rcItemCustCalc(p);
    }

    for(p=0; p<RegsMem().tTtllog.t100001Sts.itemlogCnt; p++){
      if(!RcStl.rcChkItmRBufScrVoid(p)){ /* not ScreenVoid Item ? */
        RcIbCal2.rcStlItemCustCalc2(p);         /* Item Cust Set */
      }
    }
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcibcal0.c - rcItemCustCalc(long p)
  static void rcItemCustCalc(int p){
    return;
  }





}