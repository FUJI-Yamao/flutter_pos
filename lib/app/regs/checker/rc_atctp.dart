/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc28stlinfo.dart';
import 'package:flutter_pos/app/regs/checker/rc_fself.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_mbr_com.dart';
import 'package:flutter_pos/app/regs/checker/rc_qc_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_regsret.dart';
import 'package:flutter_pos/app/regs/checker/rc_taxfree_svr.dart';
import 'package:flutter_pos/app/regs/checker/rccatalina.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_esvoid.dart';
import 'package:flutter_pos/app/regs/checker/rcky_pre_rctfm.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfdopr.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfm.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rpr.dart';
import 'package:flutter_pos/app/regs/checker/rcky_taxfreein.dart';
import 'package:flutter_pos/app/regs/checker/rckycash.dart';
import 'package:flutter_pos/app/regs/checker/rcmbrrealsvr.dart';
import 'package:flutter_pos/app/regs/checker/rcmbrsrvmsc.dart';
import 'package:flutter_pos/app/regs/checker/rcqr_com.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/checker/rctbafc1.dart';
import '../../common/date_util.dart';
import '../../if/common/interface_define.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/t_item_log.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../common/rx_log_calc.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/L_rc_qcdsp.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_atct.dart';

class RcAtctp {
  ///  関連tprxソース: rc_atctp.c - rcATCT_Print
  static Future<int> rcATCTPrint(TendType eTendType) async {
    int errNo;
/*
#if TW_2S_PRINTER
    int s2prPrintCnt = 0;
#endif
*/
/*
#if CUSTREALSVR
*/
    int custUpdateFlg = 0;
/*
#endif
*/
    int realAmt = 0;
    int printSkipFlg;
    int gpLimitFlg; // 領収書限度額判断
    int i;
    List<String> tmpPosName =
        List.filled(TItemLog().t10000.posName.length, ""); /* pos name */

    errNo = 0;

    AtSingl atSing = SystemFunc.readAtSingl();
    printSkipFlg = atSing.printSkipFlg;
    if (printSkipFlg != 1) {
      if (await RcSysChk.rcChkReceiptIssueClerkSide()) {
        /* 画面＆ガイダンス音声に「レシート」の文言を使用しない為 */
        printSkipFlg = 1;
      }
    }

    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    RegsMem regsMem = SystemFunc.readRegsMem();

    if (cBuf.shopAndGoAplDlQrPrintNormal == 1) {
      if (await RcSysChk.rcChkShopAndGoMode() != 0) {
        //処理なし;
      } else if (await RcSysChk.rcChkSmartSelfSystem() &&
          !await RcSysChk.rcChkHappySelfQCashier() &&
          !await RcSysChk.rcSysChkHappySmile()) {
        if (cBuf.shopAndGoQrPrintChkItmCntFs <= regsMem.tTtllog.t100001.qty) {
          regsMem.prnrBuf.sagAplDlQrPrnFlg = 1;
        } else {
          regsMem.prnrBuf.sagAplDlQrPrnFlg = 0;
        }
      } else {
        if (cBuf.shopAndGoQrPrintChkItmCntSs <= regsMem.tTtllog.t100001.qty) {
          regsMem.prnrBuf.sagAplDlQrPrnFlg = 1;
        } else {
          regsMem.prnrBuf.sagAplDlQrPrnFlg = 0;
        }
      }
    }

    if (await RckyTaxFreeIn.rcTaxFreeChkTaxFreeIn() != 0) {
      if ((regsMem.tTtllog.t109000Sts.taxfreeRecordFlg != 0) &&
          (regsMem.prnrBuf.passportData.purchaseDay.isEmpty)) {
        regsMem.prnrBuf.passportData.purchaseDay = List.filled(8 + 1, "");

        if (regsMem.tHeader.endtime!.isEmpty) {
          var (int error, String date) = await DateUtil.dateTimeChange(null,
              DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM,
              DateTimeFormatKind.FT_YYYYMMDD,
              DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
            regsMem.prnrBuf.passportData.purchaseDay = date.split('');
        } else {
          String endTimeTmp = "";
          endTimeTmp = regsMem.tHeader.endtime!.substring(0, 5);
          endTimeTmp += regsMem.tHeader.endtime!.substring(4, 7);
          endTimeTmp += regsMem.tHeader.endtime!.substring(7, 10);

          regsMem.prnrBuf.passportData.purchaseDay = endTimeTmp.split("");
        }
      }
      if (await RcSysChk.rcsyschkTaxfreeServerSystem() == 0) {
        RcTaxFreeSvr.rcTaxfreeSvrDataClr();
      }
    } else {
      RcTaxFreeSvr.rcTaxfreeClr(); //念の為クリアする
    }
/*
#if RESERV_SYSTEM
*/
    if (RcFncChk.rcCheckReservMode()) {
      if (await RcSysChk.rcCheckWizAdjUpdate()) {
        return (0);
      }
    }
/*
#endif
*/
    if (await RcSysChk.rcCheckWizAdjUpdate()) {
      return (0);
    }
    switch (eTendType) {
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
/*
#if CATALINA_SYSTEM
*/
        if (((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
                (await RcSysChk.rcCheckQCJCSystem())) &&
            (RcCatalina.cmCatalinaSystem(1))) {
          RcCatalina.rcCatalinaAllSend2(1);
        }
/*
#endif
*/
        await RcRegsret.rcRegsretFlgSet();
/*
#if CUSTREALSVR
*/
        if (RcSysChk.rcChkCustrealsvrSystem() != 0 ||
            RcSysChk.rcChkCustrealNecSystem(0) != 0) {
          Rcmbrrealsvr.custRealSvrSetPromCd(regsMem.tTtllog);
          if ((await RcFncChk.rcCheckESVoidSMode()) ||
              (await RcFncChk.rcCheckESVoidIMode())) {
            custUpdateFlg = regsMem.tTtllog.t100700.realCustsrvFlg;
            regsMem.tTtllog.t100700.realCustsrvFlg =
                (RcKyesVoid.rcESVoidVoidUpChk() | custUpdateFlg);
          }
        }
/*
#endif
*/
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (xRet.isInvalid()) {
          return -1;
        }
        RxTaskStatBuf tBuf = xRet.object;
        RxTaskStatDrw drw = await SystemFunc.statDrwGet(tBuf);

        drw.prnStatus &= ~RcRegs.PRN_ERROR;

        while (true) {
          if (await RckyRpr.rcCheckAutoRpr(0) != 0) {
            break;
          }
          if (await RckyCash.ContinueRprChk() != 0) {
            break;
          }

          AcMem cMem = SystemFunc.readAcMem();
          if (cMem.stat.prnStatus & InterfaceDefine.IF_TH_PRNERR_HOPN != 0) {
            drw.prnStatus |= RcRegs.PRN_ERROR;
            errNo = DlgConfirmMsgKind.MSG_SETCASETTE as int;
            return (errNo);
          } else if (cMem.stat.prnStatus & InterfaceDefine.IF_TH_PRNERR_PEND !=
              0) {
            drw.prnStatus |= RcRegs.PRN_ERROR;
            errNo = DlgConfirmMsgKind.MSG_SETPAPER as int;
            return (errNo);
          } else if (cMem.stat.prnStatus &
                  InterfaceDefine.IF_TH_PRNERR_CUTERR !=
              0) {
            drw.prnStatus |= RcRegs.PRN_ERROR;
            errNo = DlgConfirmMsgKind.MSG_CUTTERERR2 as int;
            return (errNo);
          } else if (cMem.stat.prnStatus & RcRegs.PRN_ERROR != 0) {
            drw.prnStatus |= RcRegs.PRN_ERROR;
            errNo = DlgConfirmMsgKind.MSG_PRINTERERR as int;
            return (errNo);
          }
          break;
        }
        //AutoRpr_Skip:

        // 手動返品時はプリンタータイプを変更する
        if (RckyRfdopr.rcRfdOprCheckManualRefundMode() == true) {
          regsMem.tHeader.prn_typ =
              PrnterControlTypeIdx.TYPE_MANUAL_REFUND.index;
        }

        if (cBuf.dbTrm.detailrfmOverRevenue != 0) {
          gpLimitFlg = Rxkoptcmncom.rxChkKoptCmnRctfmGpCheck(cBuf);

          if (gpLimitFlg == KEY_RFM_LIMIT_LIST.KEY_RFM_LIMIT_ALL as int) {
            /* 税込合計金額 */
            realAmt = regsMem.tTtllog.t100001.saleAmt +
                (regsMem.tTtllog.t100003.outMdlclsAmt +
                    RcTbafc1.rcNoteDeptTax(
                        cBuf.dbTrm.outMdlclsOuttaxNo, regsMem.tTtllog) +
                    RcTbafc1.rcNoteDeptTax(
                        cBuf.dbTrm.outMdlclsIntaxNo, regsMem.tTtllog));
          } else if (gpLimitFlg ==
              KEY_RFM_LIMIT_LIST.KEY_RFM_LIMIT_TAX_OFF as int) {
            /* 税抜合計金額 */
            realAmt = regsMem.tTtllog.t100001.saleAmt +
                (regsMem.tTtllog.t100003.outMdlclsAmt +
                    RcTbafc1.rcNoteDeptTax(
                        cBuf.dbTrm.outMdlclsOuttaxNo, regsMem.tTtllog) +
                    RcTbafc1.rcNoteDeptTax(
                        cBuf.dbTrm.outMdlclsIntaxNo, regsMem.tTtllog)) -
                (RxLogCalc.rxCalcExTaxAmt(regsMem) +
                    RxLogCalc.rxCalcInTaxAmt(regsMem));
          }

          if ((realAmt >
                  cBuf.dbTrm.receiptGp1Limit) /* 印紙税申告納付領収書1の課税限度額より大きい */
              &&
              (cBuf.dbTrm.issueNotePrn == 2) /* 領収書発行追加印字：明細結合印字 */
              &&
              (atSing.preRctfmFlg == 0)) {
            /* 明細付領収書発行：しない */
            atSing.preRctfmFlg = 1; /* 明細付領収書発行：する　に変更 */
          }
        }

        if ((await RcSysChk.rcQCChkQcashierSystem()) &&
            (await RcSysChk.rcChkShopAndGoSystem()) &&
            (QCashierIni().shopAndGoExpensiveMarkPrn == 1)) {
          for (i = 0; i < /*ITEM_MAX*/ 200; i++) {
            // 高額商品の際のマーク印字追加
            if (regsMem.tItemLog[i].t10003.uusePrc >
                QCashierIni().shopAndGoLimit1) {
              tmpPosName = regsMem.tItemLog[i].t10000.posName.split("");
              regsMem.tItemLog[i].t10000.posName = "";
              regsMem.tItemLog[i].t10000.posName =
                  "${LRcQcdsp.QC_SAG_EXPENSIVE_MARK}$tmpPosName";
            }
          }
        }

        // 領収書宣言時は領収書印字データをセットする
        if (await RckyPreRctfm.rcChkPreRctfmPrint() == true) {
          RckyRfm.rcSetPrintDataRfmAuto();
          RckyPreRctfm.rcSetPreRctfmPrintFlg();
        } else {
          RckyPreRctfm.rcSetPreRctfmFlg(RC_FLG_TYPE.RC_FLG_OFF);
        }
/*
#if TW_2S_PRINTER
    if(rcCheck_S2Print() == true) {
      if(s2prPrintCnt == 1) {

#if TW
        if(((rcCheck_ESVoidS_Mode()) || (rcCheck_ESVoidI_Mode()))
        &&(tw_esvoid_err_no != OK )) {
          errNo = tw_esvoid_err_no;
          tw_esvoid_err_no = OK;
        }
        else
#endif
        {
          ((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->tckt_only = 1;
          errNo = rc_Send_Print();
        }
        s2prPrintCnt = 0;
      }
      else {
        TS_BUF->s2pr.PageCnt = 0;
        TS_BUF->s2pr.AllPageCnt = 0;
        TS_BUF->s2pr.PaperChgPageCnt = 0;
        TS_BUF->s2pr.StepCnt = 0;
        rc_Send_S2Print();
        s2prPrintCnt = 1;
      }
    } else {
      ((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->tckt_only = 0;
      errNo = rc_Send_Print();
    }
#else
*/
/*
#if STATION_PRINTER
    if(( cBuf.dbTrm.trm_filler8 == 2 ) && /* 伝票プリンタ */
    ( RC_INFO_MEM->RC_CNCT.CNCT_STPR_CNCT != 0 ) && /* 伝票プリンタ */
    ( regsMem.tHeader.prn_typ == PrnterControlTypeIdx.TYPE_RCPT.index ) && /* レシート */
    (( cMem.stat.opeMode == RcRegs.RG )|| /* 登録 */
    ( cMem.stat.opeMode == RcRegs.TR ))){ /* 訓練 */
    ((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->ErrCode = OK;
    ((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->StepCnt = 0;
    cMem.stat.rjpMode = RC_INFO_MEM->RC_CNCT.CNCT_RCT_ONOFF;
    }
    else{
#endif
*/
        /* 退店端末用QRコードレシート印字チェック */
        if (await CmCksys.cmLeaveQrSystem(0) != 0) {
          /* 退店端末QRコード作成 */
          RcqrCom.rcQRSystemLeaveToTxt();
        }

        if (await rcAtctpChargeRctCtrl() != 0) {
          atSing.chargeRceiptCtrl = 0;
          errNo = RcIfEvent.rcSendPrint();
          if (RcRegs.rcInfoMem.rcRecog.recogVescaSystem != 0) {
            if (errNo == 0) {
              if (atSing.chargeRceiptCtrl == 1) {
                sleep(const Duration(milliseconds: 2));
                errNo = RcIfEvent.rcSendPrint();
              }
            }
          }
        } else {
          errNo = RcIfEvent.rcSendPrint();
        }
/*
#if MP1_PRINT
*/
        RcIfEvent.rcSendMP1Print();
/*
#endif
*/
/*
#if STATION_PRINTER
    }
#endif
*/
/*
    #endif
*/

/*
#if STATION_PRINTER
    TS_BUF->stpr.PageCnt = 0;
    TS_BUF->stpr.PrnFlg = 1;
    TS_BUF->stpr.LoopFlg = 0;
    TS_BUF->stpr.FeedFlg = 0;
    rc_Send_StPrint();
#endif
*/
/*
#if CUSTREALSVR
*/
        if (RcSysChk.rcChkCustrealsvrSystem() != 0 ||
            RcSysChk.rcChkCustrealNecSystem(0) != 0) {
          if ((await RcFncChk.rcCheckESVoidSMode()) ||
              (await RcFncChk.rcCheckESVoidIMode())) {
            regsMem.tTtllog.t100700.realCustsrvFlg = custUpdateFlg;
          }
        }
/*
#endif
*/
        break;
      default:
        break;
    }

    if ((await RcMbrCom.rcmbrChkStat() != 0) &&
        (RcMbrCom.rcmbrChkCust() != 0)) {
      Rcmbrsrvmsc.rcmbrSrvFanfare();
    }

    if (await RcSysChk.rcChkAcrAcbCinLcd()) {
      if (RcSysChk.rcChkChangeAfterReceipt()) {
        RcqrCom.rcQcLeDAllOff(QcLedNo.QC_LED_ALL.index);
      }
    }

    if (await RcSysChk.rcChkFselfSystem()) {
      if (RcSysChk.rcChkChangeAfterReceipt()) {
        if (regsMem.tTtllog.t100001.chgAmt != 0) {
          if (printSkipFlg != 1) {
            if (errNo == 0) {
              if (Rc28StlInfo.colorFipChk() == 1) {
                RcfSelf.rcfSelfTranFinishCreate(0);
              }
            }
          } else {
            if (atSing.fselfThankyouFlg == 2) {
              if (errNo == 0) {
                if (Rc28StlInfo.colorFipChk() == 1) {
                  RcfSelf.rcfSelfTranFinishCreate(2);
                }
              }
            }
          }
        }
      }
    }
/*
#if COLORFIP
*/
/*
#endif
*/

    return (errNo);
  }

  ///  関連tprxソース: rc_atctp.c - rc_atctp_charge_rct_ctrl
  static Future<int> rcAtctpChargeRctCtrl() async {
    int result;

    result = 0;
    RxCommonBuf cBuf = SystemFunc.readRxCmn();

    if (RcSysChk.rcsyschkVescaSystem()) {
      if (await Rxkoptcmncom.rxkoptcmncomChargeReceiptCtrl(cBuf) != 0) {
        if (await RcSysChk.rcSysChkHappySmile()) {
          // 処理なし
        } else {
          if (await RcSysChk.rcQCChkQcashierSystem()) {
            // 現状はQCashierのみ対応する
            AtSingl atSing = SystemFunc.readAtSingl();
            if (atSing.verifoneSelftopCharge == 1) {
              // 単独チャージは即時印字したい
              // 処理なし
            } else {
              if (RcqrCom.qcVescaAlarmFlg == 2) {
                // アラームレシートは即時印字したい
                // 処理なし
              } else {
                result = 1;
              }
            }
          }
        }
      }
    }

    return (result);
  }
}
