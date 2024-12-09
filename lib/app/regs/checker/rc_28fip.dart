/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_28dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_tab.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

///  関連tprxソース: rc_28fip.c
class Rc28fip {
  //　定義のみ追加
  static String fipData1 = '';
  static String fipData2 = '';
  static String fipData3 = '';


  ///  関連tprxソース: rc_28fip.c - rc28Fip_DispNum_Clr
  static int rc28FipDispNumClr(int allFlg)
  {
    int	tabNum = 0;
    int bkupFipNo = 0;
    AcMem cMem = SystemFunc.readAcMem();

    FuncKey fncCd = FuncKey.getKeyDefine(cMem.stat.fncCode);
    switch(fncCd){
      case FuncKey.KY_CNCL : break;
      case FuncKey.KY_TAB1 : break;
      case FuncKey.KY_TAB2 : break;
      case FuncKey.KY_TAB3 : return(bkupFipNo);
      default : break;
    }
    TabInfo tabInfo =  TabInfo();
    FipInfo fipInfo = FipInfo();
    tabInfo.tabStep = 0;
    if(allFlg == 1){
      for(tabNum = 0; tabNum < TabNum.MaxTab.num; tabNum++){
        fipInfo.fipTData[tabNum].fipNo = 0;
      }
      fipInfo.lastDspFipNo = 0;
    }else{
      tabNum = Rc28dsp.rcChkUseMemTabNum(tabInfo);
      bkupFipNo = fipInfo.fipTData[tabNum].fipNo;
      fipInfo.fipTData[tabNum].fipNo = 0;
    }
    return(bkupFipNo);
  }

  ///  関連tprxソース: rc_28fip.c - rc28Fip_TabDataFlush
  static Future<void> rc28FipTabDataFlush(int fipNo, int tabNum) async {
    /* 仮締タブデータFIP表示 */
    int fipCnctCnt;

    Dummy.rc28FipSetTabData(tabNum);

    if (Dummy.rcChk2800AllFipSameDisp()) {
      /* 全表示同一仕様 */
      fipCnctCnt = Dummy.rcChk2800SubFipCnct();
      switch (fipCnctCnt) {
        case FIP_CNCT3:
          Dummy.fipFlush(RcRegs.FIP_NO3, fipData1, fipData2, fipData3);
          break;
        case FIP_CNCT2:
          Dummy.fipFlush(RcRegs.FIP_NO2, fipData1, fipData2, fipData3);
          break;
        case FIP_CNCT1:
          Dummy.fipFlush(RcRegs.FIP_NO1, fipData1, fipData2, fipData3);
          break;
        default:
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rc28FipTabDataFlush() Abnormaly fipCnctCnt");
          break;
      }
    } else {
      Dummy.fipFlush(fipNo, fipData1, fipData2, fipData3);
    }
  }
}
