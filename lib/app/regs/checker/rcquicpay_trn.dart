/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'package:flutter_pos/app/regs/checker/rc_crdt_fnc.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rc_multi.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import 'liblary.dart';

/// 関連tprxソース: rcquicpay_trn.c
class RcQuicPayTrn{
  /// 関連tprxソース: rcquicpay_trn.c - rcATCT_Make_MultiQPTrans
  static Future<void> rcATCTMakeMultiQPTrans(TendType eTendType) async {
    KopttranBuff koptTranBuff = KopttranBuff();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if(xRetC.isInvalid()){
      return;
    }
    RxCommonBuf cBuf = xRetC.object;
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;

    if(!RcSysChk.rcChkKYCHA(cMem.stat.fncCode)){
      return;
    }

    RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTranBuff);

    if((koptTranBuff.crdtEnbleFlg == 1) && (koptTranBuff.crdtTyp == 19)){
      if((await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_FAP_USE.index)
          || (await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_UT_USE.index)
          || (await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_VEGA_USE.index)){
        RegsMem().tTtllog.calcData.crdtCnt1 = 1;
        RegsMem().tTtllog.calcData.crdtAmt1 = RcCrdtFnc.payPrice();
        RegsMem().tTtllog.t100010.invoiceNo = tsBuf.multi.fclData.rcvData.cardId;

        RegsMem().tCrdtLog[0].t400000Sts.crdtNo = 0;
        RegsMem().tCrdtLog[0].t400000.dataStat = 0;
        RegsMem().tCrdtLog[0].t400000.dataDiv = 9;
        RegsMem().tCrdtLog[0].t400000Sts.ttlLvl = 1;
        RegsMem().tCrdtLog[0].t400000.tranDiv = 10;
        if(await CmCksys.cmNttaspSystem() != 0){
          RegsMem().tCrdtLog[0].t400000.tranCd = 0;
        }else{
          RegsMem().tCrdtLog[0].t400000.tranCd  = 1;
        }
        RegsMem().tCrdtLog[0].t400000Sts.demand1stYyMm  = 0;
        RegsMem().tCrdtLog[0].t400000.divideCnt = 1;
        RegsMem().tCrdtLog[0].t400000.streJoinNo = CmAry.setStringZero(16);
        RegsMem().tCrdtLog[0].t400000.mbrCd = CmAry.setStringZero(17);
        if(tsBuf.multi.fclData.rcvData.dateTime != ''){
          RegsMem().tCrdtLog[0].t400000Sts.saleYyMmDd = int.parse(tsBuf.multi.fclData.rcvData.dateTime);
        }
        RegsMem().tCrdtLog[0].t400000Sts.salePrice = 0;
        RegsMem().tCrdtLog[0].t400000Sts.taxPostage = 0;
        RegsMem().tCrdtLog[0].t400000.saleAmt
        = (RcCrdtFnc.payPrice() + RegsMem().tCrdtLog[0].t400000Sts.taxPostage);
        RegsMem().tCrdtLog[0].t400000.recognNo = CmAry.setStringZero(8);
        RegsMem().tCrdtLog[0].t400000.goodThru = 0;
        RegsMem().tCrdtLog[0].t400000Sts.filler = CmAry.setStringZero(7);
        RegsMem().tCrdtLog[0].t400000Sts.bonusMonthSign = 1;
        RegsMem().tCrdtLog[0].t400000.bonusCnt = 0;
        RegsMem().tCrdtLog[0].t400000.bonusAmt = 0;
        RegsMem().tCrdtLog[0].t400000Sts.bonus1stYyMm = 0;
        if((await CmCksys.cmNttaspSystem() != 0)
            && (await RcSysChk.rcChkMultiQPSystem() == MultiQPTerminal.QP_UT_USE.index)) {
          RegsMem().tCrdtLog[0].t400000.posRecognNo = cBuf.ini_multi.QP_tid;
        }else{
          RegsMem().tCrdtLog[0].t400000.posRecognNo = CmAry.setStringZero(14);
        }
        RegsMem().tCrdtLog[0].t400000.posReceiptNo = tsBuf.multi.fclData.rcvData.slipNo;
        RegsMem().tCrdtLog[0].t400000Sts.itemCd = 0;
        RegsMem().tCrdtLog[0].t400000.space = 3;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt1 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt1 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt2 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt2 = 0;
        RegsMem().tCrdtLog[0].t400000.chaCnt3 = 0;
        RegsMem().tCrdtLog[0].t400000.chaAmt3 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt4 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt4 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt5 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt5 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt6 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt6 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt7 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt7 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt8 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt8 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt9 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt9 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaCnt10 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.chaAmt10 = 0;
        RegsMem().tCrdtLog[0].t400000Sts.cnclReason = 0;
        RegsMem().tCrdtLog[0].t400000Sts.sellSts = 0;
        RegsMem().tCrdtLog[0].t400000Sts.sellKind = 0;
        RegsMem().tCrdtLog[0].t400000Sts.saleKind = 0;
        RegsMem().tCrdtLog[0].t400000Sts.seqInqNo = tsBuf.multi.fclData.rcvData.icNo.toString();
        RegsMem().tCrdtLog[0].t400000Sts.mngPosNo = CmAry.setStringZero(21);
        RegsMem().tCrdtLog[0].t400000Sts.seqPosNo = CmAry.setStringZero(21);
        RegsMem().tCrdtLog[0].t400000.tenantCd = 0;
        RegsMem().tCrdtLog[0].t400000Sts.divCom = 0;
        RegsMem().tCrdtLog[0].t400000Sts.judgCd = 0;
        RegsMem().tCrdtLog[0].t400000.blackCheck = 0;
        RegsMem().tCrdtLog[0].t400000.cardCompCd = CmAry.setStringZero(12);
        RegsMem().tCrdtLog[0].t400000.changeChkNo = CmAry.setStringZero(11);
        RegsMem().tCrdtLog[0].t400000.cnclSlipNo = CmAry.setStringZero(12);
        RegsMem().tCrdtLog[0].t400000Sts.sign = 0;
        RegsMem().tCrdtLog[0].t400000.cardStreCd = 0;
        RegsMem().tCrdtLog[0].t400000Sts.reqCode = CmAry.setStringZero(5);
        RegsMem().tCrdtLog[0].t400000Sts.cardJis1 = CmAry.setStringZero(101);
        RegsMem().tCrdtLog[0].t400000Sts.cardJis2 = CmAry.setStringZero(102);
        RegsMem().tCrdtLog[0].t400000Sts.handleDiv = CmAry.setStringZero(4);
        RegsMem().tCrdtLog[0].t400000.payAWay = Liblary.setStringData('', 101);
        RegsMem().tCrdtLog[0].t400000.personCd = 0;
        RegsMem().tCrdtLog[0].t400000.crdtCnt = 1;
        RegsMem().tTtllog.t100001Sts.crdtlogCnt = 1;
      }
    }
  }
}

