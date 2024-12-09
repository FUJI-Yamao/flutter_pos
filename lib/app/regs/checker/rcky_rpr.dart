/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_payment.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_receipt.dart';
import 'package:flutter_pos/app/regs/checker/rc_ewdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfm.dart';
import 'package:flutter_pos/app/regs/checker/rcky_taxfreein.dart';
import 'package:flutter_pos/app/regs/checker/rckymulrbt.dart';
import 'package:flutter_pos/app/regs/checker/rcspeeza_com.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'liblary.dart';

class RckyRpr {
  // 再発行ボタン押下フラグ
  static int rprBtnFlg = 0;

  static int autorprCnt = 0;

/// Constatnt Value
  static List<int> rprList0 = [FncCode.KY_REG.keyId, 0];

  static List<int> rprList1 = [0];

  static List<int> rprList2 = [0];

  static List<int> rprList3 = [0];

  static List<int> rprList4 = [0];

  /// 関連tprxソース: rcky_rpr.c - rcCheck_AutoRpr
  static Future<int> rcCheckAutoRpr(int typ) async {
    RxCommonBuf cBuf = SystemFunc.readRxCmn();

    if (!(cBuf.dbTrm.receiptErrAutoRpr == 0)) {
      return (0);
    }
    if ((await RcSysChk.rcSGChkSelfGateSystem()) ||
        (await RcSysChk.rcQCChkQcashierSystem())) {
      return (0);
    }

    RegsMem regsMem = SystemFunc.readRegsMem();
    switch (typ) {
      case 1 :
        if (regsMem.tHeader.prn_typ == PrnterControlTypeIdx.TYPE_EVOID.index) {
          return (2);
        } else {
          return (0);
        }
      default :
        if ((await RcFncChk.rcCheckESVoidMode()) ||
            (await RcFncChk.rcCheckESVoidSMode()) ||
            (await RcFncChk.rcCheckESVoidCMode())) {
          return (0);
        }
        break;
    }

    return (1);
  }

  /// 関連tprxソース: rcky_rpr.c - rcWait_Responce
  static void rcWaitResponce(int code) {
    if (code == FuncKey.KY_VESCA_RPR.keyId) {
      AtSingl atSing = SystemFunc.readAtSingl();
      atSing.backupVescaPrintErr = 0;
    }
    rcLoopProc();
    autorprCnt = 0;
  }

  // TODO:00002 佐野 - rcWaitResponce()実装の為、定義のみ追加
  /// 関連tprxソース: rcky_rpr.c - rcLoop_Proc
  static void rcLoopProc() {}

  // TODO:00002 佐野 - rcCrdtVoidEnd()実装の為、定義のみ追加
  /// 関連tprxソース: rcky_rpr.c - rcRpr_Data_Set
  static void rcRprDataSet() {}

  // TODO:00002 佐野 - rcCrdtVoidEnd()実装の為、定義のみ追加
  /// 関連tprxソース: rcky_rpr.c - rcRpr_Data_BkSet
  static void rcRprDataBkSet(int type) {}

  /// 関連tprxソース: rcky_rpr.c - rcKyRpr
  static Future<void> rcKyRpr() async {
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcKyRpr';
  //   #if TW_2S_PRINTER
  // //    if((C_BUF->tckt_only == 0) && (MEM->tTtllog.t100800.mny_re_amt == 0) && (!cm_SubTckt_system())) {
  //   if(!rcCheck_TWRpr_Itm()){
  //   return;
  //   }
  //   #endif

    if(CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        // TODO:00013 三浦 rcSG_KeyImageText_Make 未実装
        // rcSG_KeyImageText_Make(KY_RPR);
      }
    }

    if((cMem.ent.errNo = await _rcKyRpr()) != Typ.OK) {
      await RcExt.rcErr(callFunc, cMem.ent.errNo);
    }
  }

  /// 関連tprxソース: rcky_rpr.c - rcKy_Rpr
  static Future<int> _rcKyRpr() async {
    int errNo = await rcChkKyRpr(0);
    if(errNo == 0) {
      errNo = await rcProcRpr();
    }
    return errNo;
  }

  /// chkCtrlFlg : 0以外で特定のチェック処理を除外する
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  /// 関連tprxソース: rcky_rpr.c - rcChk_Ky_Rpr
  static Future<int> rcChkKyRpr(int chkCtrlFlg) async {
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    int i = 0;

//    if(rcKy_Self() == KY_CHECKER)
    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        (!await RcSysChk.rcCheckQCJCSystem())) {
      return DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId;
    }

    if (cBuf.dbTrm.ticketOpeWithoutQs != 0) {
      if (rcCheckPsWdKyRpr() != 0) {
        return Typ.OK;
      } else {
        return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    } else {
      if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
        return DlgConfirmMsgKind.MSG_REGERROR.dlgId;
      }
    }

    // #if DEPARTMENT_STORE
    // if( (MEM->tTtllog.t100001Sts.itemlog_cnt == 0) &&
    // !(MEM->tTtllog.calcData.card_1time_amt  )   )
    // #else
    if ((cBuf.dbTrm.disableRecoverFeeSvscls1 != 0) &&
        (cBuf.bkTtlLog.t100702.joinFeeAmt != 0) &&
        (cBuf.bkTtlLog.t100001Sts.itemlogCnt == 0)) {

    } else if (RckyMulRbt.rcChkMulRbtInput(1)) {

    } else if ((await CmCksys.cmNetDoAreservSystem() != 0) &&
        (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_CIN.index)) {
      if ((cBuf.bkTtlLog.t105200.inCd == FuncKey.KY_CIN15.keyId) &&
          (cBuf.bkTtlLog.t105200.inAmt == 0)) {
        return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    } else if (await CmCksys.cmNetDoAreservSystem() != 0 &&
        cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_OUT.index) {
      if (cBuf.bkTtlLog.t105200.inCd == FuncKey.KY_OUT14.keyId &&
          cBuf.bkTtlLog.t105300.outAmt == 0) {
        return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    } else if (cBuf.bkTtlLog.t100001Sts.itemlogCnt == 0) {
      if (!(cBuf.bkTtlLog.calcData.suspendFlg == 2 &&
          await RcSysChk.rcChkMultiSuspendSystem())) {
        return DlgConfirmMsgKind.MSG_NONREG_ERR.dlgId;
      }
    }

    // TODO:00013 三浦 動作確認
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xFF);
    for(i = 0; i < rprList0.length; i++) {
      if(rprList0[i] == 0){
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rprList0[i]);
    }
    for(i = 0; i < rprList1.length; i++) {
      if(rprList1[i] == 0){
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rprList1[i]);
    }
    for(i = 0; i < rprList2.length; i++) {
      if(rprList2[i] == 0){
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rprList2[i]);
    }
    for(i = 0; i < rprList3.length; i++) {
      if(rprList3[i] == 0){
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rprList3[i]);
    }
    for(i = 0; i < rprList4.length; i++) {
      if(rprList4[i] == 0){
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rprList4[i]);
    }

    // #if 0
    // if(rcKy_Status(CMEM->key_chkb, MACRO3))
    // return(MSG_OPEERR);
    // #endif

    ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret);
    }

    if (await RcSysChk.rcQRChkPrintSystem() &&
        cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_SCNCHK.index) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if (RcSysChk.rcsyschkAyahaSystem() &&
        cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_DELIVERY_SERVICE.index) {
      return DlgConfirmMsgKind.MSG_DELIVSVC_REPRNERR.dlgId;
    }

    return Typ.OK;
  }

  /// 関連tprxソース: rcky_rpr.c - rcProc_Rpr
  static Future<int> rcProcRpr() async {
    int errNo = Typ.OK;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    String callFunc = 'rcProcRpr';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    errNo = await RcFncChk.rcChkFncBrch();
    if (errNo == 0) {
      await RcExt.cashStatSet(callFunc);
      cMem.scrData.price = 0;
      atSing.rctChkCnt = 0;
      await RcExt.rxChkModeSet(callFunc);
      if (cBuf.bkPrnrBuf.refList.refListSelNo != 0 &&
          cBuf.bkPrnrBuf.refList.customerReciptSkip != 0) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "ref llist RPR Disp Skip\n");
      } else {
        if (!(cBuf.bkTtlLog.calcData.suspendFlg == 2 && await RcSysChk.rcChkMultiSuspendSystem())) {
          atSing.fselfInoutChk = 1; /* 常時入金仕様時、このタイミングで釣銭機をIN状態にさせない為 */
          RcItmDsp.rcMultiTotalDisp(FuncKey.KY_RPR.keyId);

          // #if COLORFIP
          // ColorFipPopup(KY_RPR);
          // #endif

          if (cBuf.dbTrm.issueNotePrn == 5 || cBuf.dbTrm.issueNotePrn == 6) {
            /*　領収書付レシートの為　*/
            RckyRfm.rcSetPrintDataRfmAuto();
          }

          if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
            await RcStlLcd.rcDualStlDispChgErea();
          }
        }
      }

      if (cBuf.bkTtlLog.calcData.suspendFlg == 2 && await RcSysChk.rcChkMultiSuspendSystem()) {
        cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_RPRSUS.index;
      } else {
        if (cBuf.bkTtlLog.calcData.crdtAmt1 != 0 &&
            cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_CRDTVOID.index) {
          /* クレジット訂正レシート再発行 */
          cBuf.bkTtlLog.t100001Sts.receiptNo = 10000;
        } else if (cBuf.bkTCrdtLog[0].t400000.space == 53 &&
            cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_CRDTVOID.index) {
          /* クレジット訂正(プリカ)レシート再発行 */
          cBuf.bkTtlLog.t100001Sts.receiptNo = 10000;
        } else if (cBuf.bkTCrdtLog[0].t400000.space == 53 &&
            cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_PRECAVOID.index) {
          /* プリカ訂正レシート再発行 */
          cBuf.bkTtlLog.t100001Sts.receiptNo = 10000;
        } else {
          if (await CmCksys.cmReservSystem() != 0 &&
              cBuf.bkTmpBuf.reservTyp != 0 &&
              cBuf.bkTmpBuf.reservTyp != RcRegs.RESERV_CALL) {
            /* 予約呼出以外は、予約の再発行 */
            cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_RPRRESERV.index;
          } else if (await CmCksys.cmNetDoAreservSystem() != 0 &&
              cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_CIN.index &&
              cBuf.bkTtlLog.t105200.inCd == FuncKey.KY_CIN15.keyId &&
              cBuf.bkTtlLog.t105200.inAmt != 0) {
            /* netDoA予約予約時の入金は、内金入金の再発行 */
            cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_RPRRSVCIN.index;
          } else if (await CmCksys.cmNetDoAreservSystem() != 0 &&
              cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_OUT.index &&
              cBuf.bkTtlLog.t105300.outCd == FuncKey.KY_OUT14.keyId &&
              cBuf.bkTtlLog.t105300.outAmt != 0) {
            /* netDoA予約予約時の入金は、内金出勤の再発行 */
            cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_RPRRSVOUT.index;
          } else if ((await RcSysChk.rcQRChkPrintSystem() ||
                  await RcSysChk.rcChkCashierQRPrint()) &&
              (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_QC_TCKT.index ||
                  cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_QC_TCKT_RPR.index ||
                  cBuf.bkPrnrBuf.qcReciptPrn == 1)) {
            cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_QC_TCKT_RPR.index;
            if (cBuf.bkPrnrBuf.qcSelectMsg != 0) {
              cBuf.bkPrnrBuf.specType = RpnterSpecTypeIdx.PRN_SPEC_TYPE_QC_SELECT.id; // QC指定の場合の特殊印字
              cBuf.bkPrnrBuf.qcRprItemPrn = RcSpeezaCom.rcChkQcSelectRprItemPrn();
            }
          } else {
            cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_RPR.index;
          }
        }
      }

      // TODO:00013 三浦 rcSendPrintでない処理で印刷している
      // errNo = RcIfEvent.rcSendPrint();
      if (cBuf.bkLastRequestData == null) {
        // uuidを取得.
        var uuidC = const Uuid();
        // TODO:00001 日向 バージョンは適当.要検討.
        String uuid = uuidC.v4();
        cBuf.bkLastRequestData = CalcRequestParaItem(
            compCd: cBuf.dbRegCtrl.compCd,
            streCd: cBuf.dbRegCtrl.streCd,
            uuid: uuid);
      }

      CalcResultPay retData = await RcClxosRpr.reprint(cBuf);

      if (0 != retData.retSts) {
        TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.error,
            "RcKeyCash ${retData.errMsg}");
        // TODO:00013 三浦 返り値考える
        return Typ.NG;
      } else {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(Tpraid.TPRAID_CASH, retData.digitalReceipt, callFunc);
      }

      if (cBuf.bkTtlLog.calcData.crdtAmt1 != 0 &&
          cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_CRDTVOID.index) {
        /* クレジット訂正の再発行レシートは実績上げしない */
        log = sprintf("crdtvoid -> ky_rpr not update prnrbuf_type [%i]\n", [cBuf.bkTHeader.prn_typ]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else if ((cBuf.bkTCrdtLog[0].t400000.space == 53) &&
          (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_CRDTVOID.index)) {
        /* クレジット訂正(プリカ)の再発行レシートは実績上げしない */
        log = sprintf("crdtvoid preca -> ky_rpr not update prnrbuf_type [%i]\n", [cBuf.bkTHeader.prn_typ]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else if ((cBuf.bkTCrdtLog[0].t400000.space == 53) &&
          (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_PRECAVOID.index)) {
        /* プリカ訂正の再発行レシートは実績上げしない */
        log = sprintf("precavoid -> ky_rpr not update prnrbuf_type [%i]\n", [cBuf.bkTHeader.prn_typ]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else if (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_QC_TCKT_RPR.index) {
        /* お会計券の再発行レシートは実績上げしない */
        log = sprintf("qcticket ky_rpr not update prnrbuf_type [%i]\n", [cBuf.bkTHeader.prn_typ]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else if ((cBuf.bkTtlLog.calcData.suspendFlg == 2) &&
          (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RPRSUS.index) &&
          (await RcSysChk.rcChkMultiSuspendSystem())) {
        /* 複数仮締めレシートは再発行実績上げしない */
        log = sprintf("Multi Suspend recipt ky_rpr not update prnrbuf_type [%i]\n", [cBuf.bkTHeader.prn_typ]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else if (await CmCksys.cmReservSystem() != 0 &&
          (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RPRRESERV.index)) {
        /* 予約の再発行レシートは実績上げない */
        log = sprintf("reserv ky_rpr not update prnrbuf_type [%i]\n", [cBuf.bkTHeader.prn_typ]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else {
        if (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RPR.index) {
          // 再発行
          if (cBuf.bkTtlLog.t100003.voidFlg == 4) {
            // 検索返品の場合は返品ジャーナル番号を保持
            cBuf.bkPrnrBuf.refPrintNo = cBuf.bkTHeader.print_no;
          }
          // TODO:00013 三浦 定義のみの関数実装する？
          rcRprDataSet();
        }
        if (errNo != Typ.OK) {
          // TODO:00013 三浦 定義のみの関数実装する？
          RcIfEvent.rcSendUpdate();
        } else {
          // TODO:00013 三浦 定義のみの関数実装する？
          errNo = RcIfEvent.rcSendUpdate();
        }

        if (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RPR.index) {
          rcRprDataBkSet(0);
        }
      }

      if (errNo != 0) {
        // TODO:00013 三浦 後回し
        // rcEnd_Ky_Rpr();
        await RcExt.rxChkModeReset(callFunc);
      } else {
        if (cBuf.bkTtlLog.calcData.suspendFlg == 2 && (await RcSysChk.rcChkMultiSuspendSystem())) {
          RckyRpr.rcWaitResponce(FuncKey.KY_SUS.keyId);
        } else {
          RckyRpr.rcWaitResponce(FuncKey.KY_RPR.keyId);
        }
      }
      if (await CmCksys.cmNetDoAreservSystem() != 0 &&
          cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RPRRSVCIN.index &&
          cBuf.bkTtlLog.t105200.inCd == FuncKey.KY_CIN15.keyId &&
          cBuf.bkTtlLog.t105200.inAmt != 0) {
        cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_CIN.index;
      } else if (await CmCksys.cmNetDoAreservSystem() != 0 &&
          cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RPRRSVOUT.index &&
          cBuf.bkTtlLog.t105200.inCd == FuncKey.KY_OUT14.keyId &&
          cBuf.bkTtlLog.t105300.outAmt != 0) {
        cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_OUT.index;
      }

      if (await RcSysChk.rcChkChargeSlipSystem() /* && (C_BUF->db_trm.mag_card_typ == OTHER_CO3) */) {
        // TODO:00013 三浦 後回し 簡単
        // rc_ChargeSlipReSet_ScrpImgNo();
      }

//        if( (rcChk_ChargeSlip_System() && rcChkMember_ChargeSlipCard() && MEM->prnrbuf.charge_slip_flg == 1))
//        if( (rcChk_ChargeSlip_System() && rcChkMember_ChargeSlipCard() && MEM->prnrbuf.charge_slip_flg != 2))
      if (await RcSysChk.rcChkChargeSlipSystem() && await RcExt.rcChkMemberChargeSlipCard()) {
        /* charge_slip_flg = 0 は rcChkMember_ChargeSlipCard()で行なう */
        // TODO:00013 三浦 後回し (重め)
        // rc_ChargeSlipSend_MainProc();
      }
    }
    return errNo;
  }

  /// 関連tprxソース: rcky_rpr.c - rcCheck_Pswd_Ky_Rpr
  static int rcCheckPsWdKyRpr() {
    String passNo = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (cBuf.dbTrm.offmodePasswd == 0) {
      // TODO:00013 三浦 バイト数2でいい？
      passNo = Ltobcd.cmLtobcd(9999, 2);
    } else {
      // TODO:00013 三浦 バイト数2でいい？
      passNo = Ltobcd.cmLtobcd(cBuf.dbTrm.offmodePasswd, 2);
    }

    if ((cMem.ent.entry[0] == 0x00) &&
        (cMem.ent.entry[1] == 0x00) &&
        (cMem.ent.entry[2] == 0x00) &&
        (cMem.ent.entry[3] == 0x00) &&
        (cMem.ent.entry[4] == 0x00) &&
        (cMem.ent.entry[5] == 0x00) &&
        (cMem.ent.entry[6] == 0x00) &&
        (cMem.ent.entry[7] == 0x00) &&
        (cMem.ent.entry[8] == int.parse(passNo[0])) &&
        (cMem.ent.entry[9] == int.parse(passNo[1]))) {
      RcSet.rcClearEntry();
      return 1;
    } else {
      return 0;
    }
  }

  /// 機能：免税宣言実績の確認
  /// 引数：なし
  /// 戻値：0:免税実績でない 1:免税実績
  /// 関連tprxソース: rcky_rpr.c - rcCheck_TaxFreeDecRcpt
  static Future<int> rcCheckTaxFreeDecRcpt() async {
    int i;
    RegsMem mem = SystemFunc.readRegsMem();

    if (await RcSysChk.rcsyschkTaxfreeSystem() == 0) {
      return (0);
    }

    for (i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if (RckyTaxFreeIn.rcTaxFreeChkTaxFreeNum(
          mem.tItemLog[i].t10000.taxCd, mem.tItemLog[i].t10000.taxTyp) != 0) {
        return (1);
      }
    }

    return (0);
  }
}
