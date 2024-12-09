/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_clxos_payment.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_receipt.dart';
import 'package:flutter_pos/app/regs/checker/rc_ewdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_key_pbchg.dart';
import 'package:flutter_pos/app/regs/checker/rc_recno.dart';
import 'package:flutter_pos/app/regs/checker/rc_rfmdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcinoutdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcky_collectkey.dart';
import 'package:flutter_pos/app/regs/checker/rcky_regassist.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfdopr.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rpr.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../../postgres_library/src/pos_log_table_access.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../fb/fb_init.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rx_log_calc.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'liblary.dart';
import 'rcsyschk.dart';

class RckyRfm {
  // 領収書ボタン押下フラグ
  static int rfmBtnFlg = 0;

  /// Prototype definitions
  static int rNo = 0;
  static int jNo = 0;

  static int RprFlg = 0;	// 領収書再発行フラグ

  static int rfmSepaFlg = 0;

  static int saveReceiptNo = 0;
  static int savRctFlg = 0;

  static int qcPrnBufTypBak = 0;
  static int qcPrintNoBak = 0;

  /// Constatnt Value
  static List<int> rfmList0 = [FncCode.KY_ENT.keyId, FncCode.KY_REG.keyId, 0];

  static List<int> rfmList1 = [0];

  static List<int> rfmList2 = [0];

  static List<int> rfmList3 = [0];

  static List<int> rfmList4 = [0];

  static RegsMem saveMEM = RegsMem();

  static int receiptNo = 0;

  // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  /// 関連tprxソース: rcky_rfm.c - rcChk_Rfm_Warikan_Amt
  static int rcChkRfmWarikanAmt(int i) {
    int amt = 0;
    int ttlTax = 0;

/*
    amt = rcChk_Rfm_Warikan_Amt2( i, &ttl_tax );
*/
    return (amt);
  }

  /// 領収書印字に必要なデータをセット
  /// 関連tprxソース: rcky_rfm.c - rcSetPrintData_Rfm_Auto
  static void rcSetPrintDataRfmAuto() {
/*
#if DEPARTMENT_STORE

    int comAmt = 0;
    int totalTax = 0;
#endif
*/
    int i;
    int amt = 0;
    int exceptAmt;

    /* 領収書対象外金額 */
    exceptAmt = 0;
    exceptAmt = rcProcRfmAutoSetAmount(0);

    //免税額セット
    rcSetPrintDataRfmTaxFree();

    RegsMem regsMem = SystemFunc.readRegsMem();
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    AcMem cMem = SystemFunc.readAcMem();
/*
#if DEPARTMENT_STORE
    comAmt = TTtlLog().getSubTtlTaxInAmt() - exceptAmt;
    regsMem.prnrBuf.miketuFlg = 0;
    regsMem.tTtllog.calcData.crdtAmt1 = regsMem.tTtllog.calcData.crdtAmt1;
    regsMem.prnrBuf.nextFspLvl = regsMem.tTtllog.t100700Sts.nextFspLvl;
    regsMem.prnrBuf.card1timeAmt = regsMem.tTtllog.calcData.card1timeAmt;

    if ((regsMem.tTtllog.t100700Sts.nextFspLvl != 0) ||
        (regsMem.tTtllog.calcData.card1timeAmt % 1000 == 841)) {
      regsMem.tTtllog.t100001Sts.amount = cMem.scrData.price =
          TTtlLog().getSubTtlTaxInAmt() - regsMem.tTtllog.calcData.crdtAmt1 -
              regsMem.tTtllog.t100200[AmtKind.amtCha9.index].amt -
              regsMem.tTtllog.t100200[AmtKind.amtCha10.index].amt; /*現金額*/
      /* 内金なし予約承り計上*/
      if ((TTtlLog().getSubTtlTaxInAmt() == regsMem.tTtllog.t100002.custCd) &&
          ((regsMem.tTtllog.calcData.card1timeAmt == 101) ||
              (regsMem.tTtllog.calcData.card1timeAmt == 301) ||
              (regsMem.tTtllog.calcData.card1timeAmt == 401))) {
        totalTax =
            RxLogCalc.rxCalcExTaxAmt(regsMem) + regsMem.tTtllog.t100900.totalHesoamt +
                regsMem.tTtllog.t100900.lastHesoamt;
        regsMem.prnrBuf.ttlTax = totalTax;
        regsMem.prnrBuf.inTax = regsMem.tTtllog.t100900.lastHesoamt;
      }
    }
    if (regsMem.tTtllog.t100001Sts.amount == comAmt) {
      regsMem.prnrBuf.miketuFlg = 1;
    }
#endif
*/
    if ((cBuf.dbTrm.qcDivadjRfmPrc != 0) &&
        (regsMem.tTtllog.t100002Sts.warikanFlg > 0)) {
      for (i = 0; i < regsMem.tTtllog.t100002Sts.warikanFlg; i++) {
        amt = rcChkRfmWarikanAmt(i);
      }
    }
  }

  /// 関連tprxソース: rcky_rfm.c - rcProc_Rfm_Auto_Set_Amount
  // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  static int rcProcRfmAutoSetAmount(int typ) {
    return (0);
  }

  ///免税関連のデータをセット
  /// 関連tprxソース: rcky_rfm.c - rcSetPrintData_Rfm_Taxfree
  static void rcSetPrintDataRfmTaxFree() {
    RxCommonBuf cBuf = SystemFunc.readRxCmn();
    RegsMem regsMem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (cBuf.dbTrm.nontaxCha10 != 0) {
      regsMem.tTtllog.t100001Sts.amount -=
          regsMem.tTtllog.t100200[AmtKind.amtCha10.index].amt;
      cMem.scrData.price = regsMem.tTtllog.t100001Sts.amount;
      if (regsMem.tTtllog.t100200[AmtKind.amtCha10.index].amt != 0) {
        regsMem.prnrBuf.ttlTax = 0;
        regsMem.prnrBuf.inTax = 0;
      }
    }
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcky_rfm.c - rcQC_Rfm_Data_Set
  static void rcQCRfmDataSet() {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcky_rfm.c - rcChk_Rfm_Rcpt_Print
  static bool rcChkRfmRcptPrint() {
    return false;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcky_rfm.c - rcSetPrintData_Rfm_Taxfree
  static void rcSetPrintDataRfmTaxfree() {
    return;
  }

  /// 関連tprxソース: rcky_rfm.c - rcKyRfm2
  static Future<void> rcKyRfm2(int rprFlg) async {
    // #if RESERV_SYSTEM
    String ttlAmt = '';
    int bkpwnCtrlTime = 0;
    // #endif
    int pbChgTtlAmt = 0;
    String sEntry = '';
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcKyRfm2';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    rNo = 0;
    jNo = 0;

    RprFlg = rprFlg; // 領収書再発行フラグ

    // #if SELF_GATE
    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      if (RprFlg == 1) {
        Rcinoutdsp.rcSGKeyImageTextMake(FuncKey.KY_RCTFM_RPR.keyId);
      } else {
        Rcinoutdsp.rcSGKeyImageTextMake(FuncKey.KY_RCTFM.keyId);
      }
    }
    // #endif

    rNo = cBuf.bkTHeader.receipt_no;
    jNo = cBuf.bkTHeader.print_no;
    RegsMem().prnrBuf.rfmPrintNo = jNo;
    rfmSepaFlg = 0;

    if (RcFncChk.rcChkTenOn()) {
      /* Entry Data Input ?    */
      cMem.ent.errNo = await rcKyRfmManu();
    } else {
      if (await CmCksys.cmReservSystem() != 0) {
        if (cBuf.dbTrm.pwcntrlTime == 2) {
          /* 置数のみ可 */
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        } else if (cBuf.bkTmpBuf.reservTyp == RcRegs.RESERV_SET &&
            cBuf.bkTtlLog.t600000.advanceMoney != 0) {
          /* 予約時の領収証で内金額の領収証発行 */
          if (cBuf.bkTtlLog.t600000.advanceMoney >=
              cBuf.bkTtlLog.t100001.saleAmt) {
            cMem.ent.errNo = await rcKyRfmAuto();
          } else {
            ttlAmt = sprintf("%i", [cBuf.bkTtlLog.t600000.advanceMoney]);
            cMem.ent.tencnt = ttlAmt.length;
            // TODO:00013 三浦 要確認
            sEntry = Ltobcd.cmLtobcd(
                cBuf.bkTtlLog.t600000.advanceMoney, cMem.ent.entry.length);
            for (int i = 0; i < sEntry.length; i++) {
              cMem.ent.entry[i] = int.tryParse(sEntry.substring(i, i + 1)) ?? 0;
            }
            bkpwnCtrlTime = cBuf.dbTrm.pwcntrlTime;
            cBuf.dbTrm.pwcntrlTime = 0;
            cMem.ent.errNo = await rcKyRfmManu();
            cBuf.dbTrm.pwcntrlTime = bkpwnCtrlTime;
          }
        } else if (cBuf.bkTmpBuf.reservTyp == RcRegs.RESERV_CALL &&
            cBuf.bkTtlLog.t600000.advanceMoney != 0) {
          /* 予約受渡し時の領収証は、内金額を除いた金額の領収書発行 */
          if (cBuf.bkTtlLog.t100100[0].sptendChgAmt < 0) {
            pbChgTtlAmt = await RcKyPbchg.rcKyPbChgTtlAmt() + rcNoDetailItemAmt(null);
            if (cBuf.bkTtlLog.t100100[0].sptendChgAmt.abs() > pbChgTtlAmt) {
              ttlAmt = sprintf("%i",
                  [cBuf.bkTtlLog.t100100[0].sptendChgAmt - pbChgTtlAmt]);
              cMem.ent.tencnt = ttlAmt.length;
              // TODO:00013 三浦 要確認
              sEntry = Ltobcd.cmLtobcd(
                  cBuf.bkTtlLog.t100100[0].sptendChgAmt - pbChgTtlAmt,
                  cMem.ent.entry.length);
              for (int i = 0; i < sEntry.length; i++) {
                cMem.ent.entry[i] =
                    int.tryParse(sEntry.substring(i, i + 1)) ?? 0;
              }
              bkpwnCtrlTime = cBuf.dbTrm.pwcntrlTime;
              cBuf.dbTrm.pwcntrlTime = 0;
              cMem.ent.errNo = await rcKyRfmManu();
              cBuf.dbTrm.pwcntrlTime = bkpwnCtrlTime;
            } else {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
            }
          } else {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
          }
        } else if (cBuf.bkTmpBuf.reservTyp != RcRegs.RESERV_CALL &&
            cBuf.bkTmpBuf.reservTyp != RcRegs.RESERV_NON) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        } else {
          cMem.ent.errNo = await rcKyRfmAuto();
        }
      } else {
        cMem.ent.errNo = await rcKyRfmAuto();
      }
    }

    cBuf.bkTHeader.receipt_no = rNo;
    cBuf.bkTHeader.print_no = jNo;
    RegsMem().prnrBuf.rfmPrintNo = 0;

    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr(callFunc, cMem.ent.errNo);
    }
  }

  /// 関連tprxソース: rcky_rfm.c - rcKy_Rfm_Auto
  static Future<int> rcKyRfmAuto() async {
  int errNo = await rcChkKyRfmAuto(0);

  if(errNo == 0) {
    errNo = await rcProcRfmAuto();
  }

  return errNo;
  }

  /// chk_ctrl_flg : 0以外で特定のチェック処理を除外する
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  /// 関連tprxソース: rcky_rfm.c - rcChk_Ky_Rfm_Auto
  static Future<int> rcChkKyRfmAuto(int chkCtrlFlg) async {
    int p = 0;
    // #if DEPARTMENT_STORE
    // long  cash_amt;
    // #endif
    int pbChgTtlAmt = 0;
    int ret = 0;
    String log = '';
    int exceptAmt = 0;
    String callFunc = 'rcChkKyRfmAuto';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    int i = 0;

    // 操作モードチェック
    ret = await rcChkRfmMode();
    if (ret != 0) {
      return ret;
    }

    if (WindowDispStatus.WINDOW_DISP_SHOW.value != await RckyRegassist.rcRegAssistRprDispDispStatusChk()) {
      log = sprintf("%s() receipt_no[%i] save_receipt_no[%i]", [callFunc, cBuf.bkTHeader.receipt_no, saveReceiptNo]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }

    if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
      if (RprFlg == 1) { // 領収書再発行
        return DlgConfirmMsgKind.MSG_RCTFM_RPR_ERR.dlgId;
      }
      return DlgConfirmMsgKind.MSG_REGERROR.dlgId;
    }

    pbChgTtlAmt = await RcKyPbchg.rcKyPbChgTtlAmt();
    exceptAmt = rcNoDetailItemAmt(null);

    if (cBuf.bkGetSubTtlTaxInAmt() - pbChgTtlAmt - exceptAmt == 0) {
      if (RprFlg == 1) { // 領収書再発行
        return DlgConfirmMsgKind.MSG_RCTFM_RPR_ERR.dlgId;
      }
      return DlgConfirmMsgKind.MSG_RFM_NOT_PRINT_TRAN.dlgId;
    }

    if ((cBuf.bkTHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_REG ||
        cBuf.bkTHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_TRAINING ||
        cBuf.bkTHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID) &&
        cBuf.bkGetSubTtlTaxInAmt() < 0) {
      if (RprFlg == 1) { // 領収書再発行
        return DlgConfirmMsgKind.MSG_RCTFM_RPR_ERR.dlgId;
      }
      return DlgConfirmMsgKind.MSG_RFM_NOT_PRINT_TRAN.dlgId;
    }

    //   #if DEPARTMENT_STORE
    //   /*未決現金金額0円,取消, 解約*/
    //   cash_amt = rxCalc_Stl_Tax_In_Amt(MEM) - MEM->tTtllog.calcData.crdt_amt1 - MEM->tTtllog.t100200[AMT_CHA9].amt - MEM->tTtllog.t100200[AMT_CHA10].amt;
    // if(((MEM->tTtllog.t100700Sts.next_fsp_lvl != 0) || (MEM->tTtllog.calcData.card_1time_amt % 1000 == 841))&&
    // (cash_amt <= 0 || MEM->tTtllog.calcData.card_1time_amt/1000 == 2 || MEM->tTtllog.calcData.card_1time_amt/1000 == 4))
    // return (MSG_OPEMISS);
    //   #endif

    // TODO:00013 三浦 動作確認
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xFF);
    for (i = 0; i < rfmList0.length; i++) {
      if (rfmList0[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList0[i]);
    }

    for (i = 0; i < rfmList1.length; i++) {
      if (rfmList1[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList1[i]);
    }

    for (i = 0; i < rfmList2.length; i++) {
      if (rfmList2[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList2[i]);
    }

    for (i = 0; i < rfmList3.length; i++) {
      if (rfmList3[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList3[i]);
    }

    for (i = 0; i < rfmList4.length; i++) {
      if (rfmList4[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList4[i]);
    }

    // #if 0
    // if(rcKy_Status(CMEM->key_chkb, MACRO3))
    // return(MSG_OPEERR);
    // #endif

    ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret);
    }

    // ターミナル設定チェック
    ret = rcChkRfmTrm();
    if (ret != 0) {
      return ret;
    }

    if (cBuf.dbTrm.issueNotePrn == 5 || cBuf.dbTrm.issueNotePrn == 6) {
      /*　領収書付レシートの為　*/
      if (cBuf.dbTrm.selfRfmDispFlg != 0) {
        return DlgConfirmMsgKind.MSG_NOTUSE_RFM2.dlgId;
      } else {
        return DlgConfirmMsgKind.MSG_NOTUSE_RFM1.dlgId;
      }
    }

    if (((await RcSysChk.rcQCChkQcashierSystem() &&
        cBuf.bkTtlLog.t100001Sts.qcRfmRcptFlg == 1) ||
        (RcSysChk.rcSGCheckRfmPrnSystem() &&
            cBuf.bkTtlLog.t100001Sts.qcRfmRcptFlg == 1)) &&
        cBuf.dbTrm.rfmCounterFunc == 0) {
      /*　明細付領収書発行済みの為　*/
      if (cBuf.dbTrm.selfRfmDispFlg != 0) {
        return DlgConfirmMsgKind.MSG_QC_NOTUSE_RFM2.dlgId;
      } else {
        return DlgConfirmMsgKind.MSG_QC_NOTUSE_RFM1.dlgId;
      }
    }

    if (RprFlg == 0) {
      // 領収書
      if (cBuf.dbTrm.rfmOnlyIssue != 0 // 締め操作後、領収書発行1枚だけ可能
          //&& (MEM->tHeader.receipt_no == save_receipt_no) )
          && rcChkRfmRprPrint()) {
        cMem.ent.addMsgBuf = '';
        AplLibImgRead.aplLibImgRead(FuncKey.KY_RCTFM.keyId);
        return DlgConfirmMsgKind.MSG_RCTFM_ERR.dlgId;
      }
      savRctFlg = 1;
    }

    // 承認キーなどのチェック
    ret = await rcChkRfmSystem();
    if (ret != 0) {
      return ret;
    }

    if (RprFlg == 1) {
      // 領収書再発行
      // if(RegsMem().tHeader.receipt_no != saveReceiptNo)
      if (!rcChkRfmRprPrint()) {
        return DlgConfirmMsgKind.MSG_RCTFM_RPR_ERR.dlgId;
      }
    }

    return Typ.OK;
  }

  /// 関連tprxソース: rcky_rfm.c - rcProc_Rfm_Auto
  static Future<int> rcProcRfmAuto() async {
    int errNo = Typ.OK;
    int errNo2 = 0;
//	short i;
    TTtlLog ttlLogSave = TTtlLog();
    CHeaderLogColumns headerSave = CHeaderLogColumns();
    String callFunc = 'rcProcRfmAuto';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();

    // #if DEPARTMENT_STORE
    // t_ttllog   *Savettllog;
    // c_bdllog   *Savebdllog;
    // c_stmlog   *Savestmlog;
    // long       com_amt;
    // long       total_tax;
    // #endif

    await RcExt.cashStatSet(callFunc);
//	err_no = rcChk_RPrinter();
    errNo = await RcFncChk.rcChkFncBrch();
    if (errNo != 0) {
      savRctFlg = 0;
      await rcEndKyRfm2(errNo);
      return errNo;
    } else {
      // MEM->tHeaderを確保
      headerSave = cBuf.bkTHeader;

      if (cBuf.dbTrm.qcDivadjRfmPrc != 0 &&
          cBuf.bkTtlLog.t100002Sts.warikanFlg > 0) {
        // TODO:00013 三浦 if文必要？
        // if(ttlLogSave) {
        ttlLogSave = cBuf.bkTtlLog;
        // }
      }

      RckyRfm.rcSetPrintDataRfmAuto();

      if (RprFlg == 1) {
        RcItmDsp.rcMultiTotalDisp(ImageDefinitions.IMG_RCTFM_RPR);
      } else {
        RcItmDsp.rcMultiTotalDisp(ImageDefinitions.IMG_RCTFMISSUE);
      }

      // #if COLORFIP
      // if(RprFlg == 1)
      // {
      // ColorFipPopup( KY_RCTFM_RPR );
      // }
      // else
      // {
      // ColorFipPopup( KY_RCTFM );
      // }
      // #endif

      if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
        await RcStlLcd.rcDualStlDispChgErea();
      }

//		rcRfm_Read_rcpt_no((uchar *)getenv("TPRX_HOME"));
      if (RprFlg == 1) {
        cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_RFM_RPR.index;
      } else {
        cBuf.bkTHeader.prn_typ = PrnterControlTypeIdx.TYPE_RFM2.index;
      }

      if (rNo == 0) {
        cBuf.bkTHeader.receipt_no =
            await Counter.competitionGetRcptNo(await RcSysChk.getTid());
      }

      cBuf.bkTHeader.print_no =
          await Counter.competitionGetPrintNo(await RcSysChk.getTid());

      if (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RFM2.index) {
        // 元取引情報をc_header_logへ設定
        rcRfmHeaderVoidInfoSet(headerSave);
      }

      atSing.rctChkCnt = 0;
      await RcExt.rxChkModeSet(callFunc);
      await RcSetDate.rcSetDate();
      errNo = Typ.OK;
      errNo2 = Typ.OK;

      if (!await RcSysChk.rcCheckWizAdjUpdate()) {
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

        CalcResultPay retData = await RcClxosRpr.receipt(cBuf);

        if (0 != retData.retSts) {
          TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.error,
              "RcKeyCash ${retData.errMsg}");
          // TODO:00013 三浦 返り値問題ないか？
          return Typ.NG;
        } else {
          // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
          await IfTh.printReceipt(Tpraid.TPRAID_CASH, retData.digitalReceipt, callFunc);
        }
      }

      // #if DEPARTMENT_STORE
      // if(! rcRefMode_chk_mem()) {
      // Savettllog = (t_ttllog*)malloc( sizeof(MEM->tTtllog) );
      // if( Savettllog ) {
      // memcpy( Savettllog,&MEM->tTtllog, sizeof(MEM->tTtllog) );
      // }
      //
      // Savebdllog = (t_bdllog*)malloc( sizeof(MEM->tBdllog) );
      // if( Savebdllog ) {
      // memcpy( Savebdllog,&MEM->tBdllog, sizeof(MEM->tBdllog) );
      // }
      //
      //
      // Savestmlog = (t_stmlog*)malloc( sizeof(MEM->tStmlog) );
      // if( Savestmlog ) {
      // memcpy( Savestmlog,&MEM->tStmlog, sizeof(MEM->tStmlog) );
      // }
      //
      // rcClr_TtlRBuf(NCLR_TTLRBUF_ALL);     /* Total reicept clear */
      // if(R_no == 0L)
      // MEM->tHeader.receipt_no  = competition_get_rcptno(GetTid());
      // MEM->tHeader.print_no    = competition_get_printno(GetTid());
      // MEM->tTtllog.calcData.damt_fsppur = MEM->tTtllog.t100001Sts.amount;
      // rc_Set_Date();
      // }
      // #else

      rcRfmDataSet();

      // #endif

      // TODO:00013 三浦 定義のみの関数実装する？
      errNo2 = RcIfEvent.rcSendUpdate();

      // #if !DEPARTMENT_STORE
      rcRfmDataBkSet();
      // #endif

      await RcRecno.rcIncRctJnlNo(false); // クラウドPOSで管理
      await rcRfmDivAdjWriteRcptNo();

      if (errNo != Typ.OK || errNo2 != Typ.OK) {
        await RcExt.rcEndKyRfm();
        await RcExt.rxChkModeReset(callFunc);
      }

      // #if DEPARTMENT_STORE
      // if(! rcRefMode_chk_mem()) {
      // if( Savettllog ) {
      // memcpy( &MEM->tTtllog, Savettllog,sizeof(MEM->tTtllog) );
      // free(Savettllog);
      // }
      //
      // if( Savebdllog ) {
      // memcpy( &MEM->tBdllog, Savebdllog,sizeof(MEM->tBdllog) );
      // free(Savebdllog);
      // }
      //
      // if( Savestmlog ) {
      // memcpy( &MEM->tStmlog, Savestmlog,sizeof(MEM->tStmlog) );
      // free(Savestmlog);
      // }
      // }
      // #endif

      if (cBuf.dbTrm.qcDivadjRfmPrc != 0 &&
          cBuf.bkTtlLog.t100002Sts.warikanFlg > 0) {
        // TODO:00013 三浦 if文必要？
        // if(ttlLogSave) {
        cBuf.bkTtlLog = ttlLogSave;
        // TODO:00013 三浦 malloc使わないからいらないような気がする
        // free(ttllog_save);
        // }
      }

      if (RprFlg == 1) {
        RckyRpr.rcWaitResponce(FuncKey.KY_RCTFM_RPR.keyId);
      } else {
        RckyRpr.rcWaitResponce(FuncKey.KY_RCTFM.keyId);
      }
    }
    return 0;
  }

  /// 関連tprxソース: rcky_rfm.c - rcKy_Rfm_Manu
  static Future<int> rcKyRfmManu() async {
    int errNo = await rcChkKyRfmManu(0);

    if (errNo == 0) {
      errNo = await rcProcRfmManu();
    }

    return errNo;
  }

  /// chk_ctrl_flg : 0以外で特定のチェック処理を除外する
  /// 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  /// 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  /// 関連tprxソース: rcky_rfm.c - rcChk_Ky_Rfm_Manu
  static Future<int> rcChkKyRfmManu(int chkCtrlFlg) async {
    int p = 0;
    int ret = 0;
    int i = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (!RcSysChk.rcRGOpeModeChk() && !RcSysChk.rcTROpeModeChk()) {
      return DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }

//	if(rcKy_Self() == KY_CHECKER)
    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER &&
        !await RcSysChk.rcCheckQCJCSystem()) {
      return DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId;
    }

    if (RprFlg == 1) {
      // 領収書再発行
      return DlgConfirmMsgKind.MSG_RCTFM_RPR_ERR.dlgId;
    }

    if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
      return DlgConfirmMsgKind.MSG_REGERROR.dlgId;
    }

    if (cMem.ent.tencnt > 8) {
      return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
    }

    // #if DEPARTMENT_STORE
    // if( cm_DepartmentStore_system() )
    // return(MSG_OPEERR);
    // #endif

    if (await CmCksys.cmHc1KomeriSystem() != 0) {
      return DlgConfirmMsgKind.MSG_NOOPEERR.dlgId;
    }

    // TODO:00013 三浦 動作確認
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xFF);
    for (i = 0; i < rfmList0.length; i++) {
      if (rfmList0[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList0[i]);
    }

    for (i = 0; i < rfmList1.length; i++) {
      if (rfmList1[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList1[i]);
    }

    for (i = 0; i < rfmList2.length; i++) {
      if (rfmList2[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList2[i]);
    }

    for (i = 0; i < rfmList3.length; i++) {
      if (rfmList3[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList3[i]);
    }

    for (i = 0; i < rfmList4.length; i++) {
      if (rfmList4[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfmList4[i]);
    }

    // #if 0
    // if(rcKy_Status(CMEM->key_chkb, MACRO3))
    // return(MSG_OPEERR);
    // #endif

    ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret);
    }

    if (cBuf.dbTrm.pwcntrlTime == 1) {
      /* 置数禁止 */
      return DlgConfirmMsgKind.MSG_KEY_INPUTKY_ERR.dlgId;
    }

    return Typ.OK;
  }

  /// 関連tprxソース: rcky_rfm.c - rcProc_Rfm_Manu
  static Future<int> rcProcRfmManu() async {
    int errNo = Typ.OK;
//	short err_no2;
//	char entry[4];
    String callFunc = 'rcProcRfmManu';
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await RcSysChk.rcQRChkPrintSystem()) {
      qcPrnBufTypBak = 0;
      qcPrintNoBak = 0;
      if (cBuf.bkTHeader.prn_typ ==
              PrnterControlTypeIdx.TYPE_QC_TCKT.index ||
          cBuf.bkTHeader.prn_typ ==
              PrnterControlTypeIdx.TYPE_QC_TCKT_RPR.index) {
        qcPrnBufTypBak = cBuf.bkTHeader.prn_typ;
      }
      qcPrintNoBak = cBuf.bkTHeader.print_no;
    }

    await RcExt.cashStatSet(callFunc);
//	err_no = rcChk_RPrinter();
    errNo = await RcFncChk.rcChkFncBrch();
    if (errNo != 0) {
      savRctFlg = 0;
      await rcEndKyRfm2(errNo);
      return errNo;
    } else {
      atSing.fselfInoutChk = 1; /* 常時入金仕様時、このタイミングで釣銭機をIN状態にさせない為 */
      if (await RcSysChk.rcCheckPrimeStat() == RcRegs.PRIMETOWER) {
        if (atSing.inputbuf.no == DevIn.KEY1) {
          return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
        }
      }

      if (FbInit.subinitMainSingleSpecialChk() == true) {
        cMem.stat.dualTSingle = cBuf.devId;
      } else {
        cMem.stat.dualTSingle = 0;
      }

      rfmSepaFlg = 1;
      await RcRfmDsp.rcRfmDsp();
    }
    return 0;
  }

  /// 関連tprxソース: rcky_rfm.c - rcEnd_Ky_Rfm2
  static Future<void> rcEndKyRfm2(int errNo) async {
    String callFunc = 'rcEndKyRfm2';
    AcMem cMem = SystemFunc.readAcMem();

    if (rfmSepaFlg != 0) {
      RcRfmDsp.rfmManuExit();
      rfmSepaFlg = 0;
    }

    if (errNo != DlgConfirmMsgKind.MSG_PAPER_NEAREND.dlgId &&
        errNo != DlgConfirmMsgKind.MSG_TRMODE.dlgId &&
        errNo != DlgConfirmMsgKind.MSG_TEXT124.dlgId &&
        errNo != DlgConfirmMsgKind.MSG_CUSTTRM_CHG.dlgId) {
      RcSet.rcErr1timeSet();
    }

    await RcSet.cashStatReset2(callFunc);

    if (await RcSysChk.rcCheckQCJCChecker()) {
      await RcSet.rcClearDualChkReg();
    }

    RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);

    if (RprFlg == 1) {
      RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_RCTFM_RPR.keyId); /* Reset Bit 0 of KY_RCTFM_RPR? */
    } else {
      RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_RCTFM.keyId); /* Reset Bit 0 of KY_RCTFM? */
    }

    if (savRctFlg != 0) {
      // TODO:10096 デバドラ連携 プリンタ
      //   if(STAT_print_get(TS_BUF)->ErrCode == OK ){
      // saveReceiptNo = RegsMem().tHeader.receipt_no;
      // }
      savRctFlg = 0;
    }

    if (await RcSysChk.rcQRChkPrintSystem() && qcPrnBufTypBak != 0) {
      RegsMem().tHeader.prn_typ = qcPrnBufTypBak;
      RegsMem().tHeader.print_no = qcPrintNoBak;
      qcPrnBufTypBak = 0;
      qcPrintNoBak = 0;
    }
  }

  /// 関連tprxソース: rcky_rfm.c - rc_NoDetail_Item_Amt
  static int rcNoDetailItemAmt(int? cnt) {
    int ttl = 0;
    int i = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cnt != null) {
      cnt = 0;
    }

    for (i = 0; i < cBuf.bkTtlLog.t100001Sts.itemlogCnt; i++) {
      if (cBuf.bkTItemLog[i].t10000.realQty == 0 ||
          cBuf.bkTItemLog[i].t10002.scrvoidFlg) {
        continue;
      }

      if (cBuf.bkTItemLog[i].t10000Sts.detailNoprnFlg != 0) {
        ttl += cBuf.bkTItemLog[i].t10000.actNomiInPrc;
        if (cnt != null) {
          cnt += cBuf.bkTItemLog[i].t10000.realQty;
        }
      }
    }

    return ttl;
  }

  /// 関連tprxソース: rcky_rfm.c - rcChkRfmMode
  // モードチェック関数
  static Future<int> rcChkRfmMode() async {
    if (RcSysChk.rcVDOpeModeChk()) {
      return DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }
//	if(rcKy_Self() == KY_CHECKER)
    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER &&
        !await RcSysChk.rcCheckQCJCSystem()) {
      return DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId;
    }
    return 0;
  }

  // ターミナル設定チェック関数
  /// 関連tprxソース: rcky_rfm.c - rcChkRfmTrm
  static int rcChkRfmTrm() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.pwcntrlTime == 2) {
      /* 置数のみ可 */
      return DlgConfirmMsgKind.MSG_RCTFM_MAN_ONLY.dlgId;
    }
    return 0;
  }

  /// 関連tprxソース: rcky_rfm.c - rcChk_Rfm_Rpr_Print
  static bool rcChkRfmRprPrint() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.bkTHeader.receipt_no == saveReceiptNo) {
      return true;
    }

    return false;
  }

  // 承認キーなどのチェック関数
  /// 関連tprxソース: rcky_rfm.c - rcChkRfmSystem
  static Future<int> rcChkRfmSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_QC_TCKT.index ||
        cBuf.bkTHeader.prn_typ ==
            PrnterControlTypeIdx.TYPE_QC_TCKT_RPR.index) {
      if (RprFlg == 1) {
        // 領収書再発行
        return DlgConfirmMsgKind.MSG_RCTFM_RPR_ERR.dlgId;
      }
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    // くろがねや仕様 : 売掛は領収証発行しない
    if (await CmCksys.cmHc2KuroganeyaSystem(await RcSysChk.getTid()) == 1) {
      if (cBuf.bkTtlLog.t100200[AmtKind.amtCha3.index].amt != 0) {
        return DlgConfirmMsgKind.MSG_RFM_NOT_PRINT_TRAN.dlgId;
      }
    }

    /* 標準対応 領収書印字抑止 */
    if (rcChkReceiptPrintCheck() == 1) {
      return DlgConfirmMsgKind.MSG_RFM_NOT_PRINT_TRAN.dlgId;
    }

    return 0;
  }

  /// 標準対応 領収書印字抑止
  /// 機能：会計、品券キー領収書印字可否チェック
  /// 引数：なし
  /// 戻値：印字する: 0  印字しない: 1
  /// 関連tprxソース: rcky_rfm.c - rcChkRfmSystem
  static int rcChkReceiptPrintCheck() {
    int fncCd = 0;
    int i = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_ERCTFM.index) {
      /* 検索領収書 */
      for (i = 0; i < cBuf.bkPrnrBuf.chequeSptendCnt; i++) {
        fncCd = cBuf.bkTtlLog.t100100[i].sptendCd;
        if (Rxkoptcmncom.rxChkKoptCmnRctfmPrintCheck(cBuf, fncCd) == false) {
          return 1;
        }
      }
    } else {
      /* 領収書印字 */
      for (i = 0; i < cBuf.bkTtlLog.t100001Sts.sptendCnt; i++) {
        fncCd = cBuf.bkTtlLog.t100100[i].sptendCd;
        if (Rxkoptcmncom.rxChkKoptCmnRctfmPrintCheck(cBuf, fncCd) == false) {
          return 1;
        }
      }
    }
    return 0;
  }

  /// 機能：領収書実績へ元取引情報を設定する
  /// 引数：pSrcParam 元取引情報
  /// 戻値：なし
  /// 備考：領収書の発行制限用
  /// 関連tprxソース: rcky_rfm.c - rcRfm_HeaderVoidInfoSet
  static void rcRfmHeaderVoidInfoSet(var pSrcParam) {
    String? serialNo = '';
    String? tmpBuf = '';
    CHeaderLogColumns pSrcHeader = CHeaderLogColumns();

    pSrcHeader = pSrcParam;

    pSrcHeader.sale_date ??= '0000-00-00';

    tmpBuf = pSrcHeader.sale_date?.substring(0, 4);
    tmpBuf = '$tmpBuf${pSrcHeader.sale_date!.substring(5, 7)}';
    tmpBuf = '$tmpBuf${pSrcHeader.sale_date!.substring(8, 10)}';
    serialNo = sprintf("%s%09i%09i%09i%04i%04i", [
      tmpBuf,
      pSrcHeader.comp_cd,
      pSrcHeader.stre_cd,
      pSrcHeader.mac_no,
      pSrcHeader.receipt_no,
      pSrcHeader.print_no
    ]);

    RegsMem().tHeader.void_serial_no = serialNo;
    RegsMem().tHeader.void_kind = 3;
    //memcpy(MEM->tHeader.void_sale_date, header_save.sale_date, sizeof(MEM->tHeader.void_sale_date));
    RegsMem().tHeader.void_sale_date = pSrcHeader.sale_date!;
  }

  /// 関連tprxソース: rcky_rfm.c - rcRfm_Data_Set
  static void rcRfmDataSet() {
//	char	log[128];
    int realAmt = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    // TODO:00013 三浦 初期化しているだけ？
    saveMEM = RegsMem();
    // if(saveMEM){
    // free(Save_MEM);
    // Save_MEM = NULL;
    // }
    // Save_MEM = (REGSMEM*)malloc( sizeof(REGSMEM) );

    // if( Save_MEM ) {
    //   memcpy(Save_MEM, MEM, sizeof(REGSMEM));
    // }else {
    //   TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, "rcRfm_Data_Set : malloc Error");
    // }

//   #if 0
// //@@@V15
//   MEM->tTtllog.calcData.mscrap_cnt = MEM->prnrbuf.rcp_cnt;
//   MEM->tTtllog.calcData.mscrap_amt = MEM->prnrbuf.rcp_amt;
//   #endif

    if (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RFM1.index) {
      cBuf.bkTtlLog.t100001.receiptGpSht = 0;
      cBuf.bkTtlLog.t100001.receiptGpAmt = 0;
    }

    if (cBuf.bkTHeader.prn_typ == PrnterControlTypeIdx.TYPE_RFM1.index) {
      //real_amt = MEM->tTtllog.calcData.mscrap_amt - MEM->prnrbuf.in_tax;
      realAmt = cBuf.bkTtlLog.t100001Sts.amount;
      if (Rxkoptcmncom.rxChkKoptCmnRctfmGpCheck(cBuf) ==
          KEY_RFM_LIMIT_LIST.KEY_RFM_LIMIT_TAX_OFF.value) {
        realAmt -= cBuf.bkPrnrBuf.ttlTax;
      }
      rcSetReceiptQpTran(realAmt, 1); // 領収書実績セット
    }
    RegsMem().tHeader.tran_flg = 0;
    RegsMem().tHeader.sub_tran_flg = 0;

    RegsMem().tTtllog.t120000.cashlressBfAmt = 0; // キャッシュレス還元適用前額クリア

//   #if 0	//@@@V15	あとで修正. for ope_mode
//   if(rcRG_OpeModeChk())
//   {
//   MEM->tHeader.ope_mode_flg = 61;
//   MEM->tTtllog.t100800.mny_re_amt = MEM->tTtllog.t100001Sts.receipt_no;
//
//   }
//   else if(rcVD_OpeModeChk()){
//   MEM->tHeader.ope_mode_flg = 63;
//   #if 0
// //@@@V15
//   MEM->tTtllog.calcData.mscrap_cnt = -labs(MEM->prnrbuf.rcp_cnt);
//   MEM->tTtllog.calcData.mscrap_amt = -labs(MEM->prnrbuf.rcp_amt);
//   #endif
//   }
//   else if(rcTR_OpeModeChk())
//   MEM->tHeader.ope_mode_flg = 62;
//   else{
//   snprintf(log, sizeof(log), "%s : mode Error[%d]\n", __FUNCTION__, CMEM->stat.OpeMode);
//   TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, log);
//   MEM->tHeader.ope_mode_flg = 62;
//   MEM->tTtllog.calcData.mscrap_cnt = 0;
//   MEM->tTtllog.calcData.mscrap_amt = 0;
//   }
//   #endif	//@@@V15
  }

  /// 関連tprxソース: rcky_rfm.c - rcSet_Receipt_gp_Tran
  static void rcSetReceiptQpTran(int realAmt, int sign) {
    int gpAmt = 0;
    int gpRank = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (RcSysChk.rcRGOpeModeChk() && RcSysChk.rcTROpeModeChk()) {
      return; // 実績なし
    } else if (RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
      return; // 実績なし
    }

    if (realAmt > cBuf.dbTrm.receiptGp5Limit) {
      gpAmt = cBuf.dbTrm.receiptGp6Tax;
      gpRank = 5;
    } else if (realAmt > cBuf.dbTrm.receiptGp4Limit) {
      gpAmt = cBuf.dbTrm.receiptGp5Tax;
      gpRank = 4;
    } else if (realAmt > cBuf.dbTrm.receiptGp3Limit) {
      gpAmt = cBuf.dbTrm.receiptGp4Tax;
      gpRank = 3;
    } else if (realAmt > cBuf.dbTrm.receiptGp2Limit) {
      gpAmt = cBuf.dbTrm.receiptGp3Tax;
      gpRank = 2;
    } else if (realAmt > cBuf.dbTrm.receiptGp1Limit) {
      gpAmt = cBuf.dbTrm.receiptGp2Tax;
      gpRank = 1;
    } else {
      gpAmt = cBuf.dbTrm.receiptGp1Tax;
      gpRank = 0;
    }

    RegsMem().tTtllog.t100001.receiptGpSht = 1 * sign;
    RegsMem().tTtllog.t100001.receiptGpAmt = gpAmt * sign;
    RegsMem().tTtllog.t100001.receiptGpRank = gpRank;
  }

  /// 関連tprxソース: rcky_rfm.c - rcRfm_Data_BkSet
  // TODO:00013 三浦 構造体にデータがあるかどうかの確認関数 後回し
  static void rcRfmDataBkSet() {
    // if(saveMEM){
    // memcpy( MEM, Save_MEM, sizeof(REGSMEM) );
    // free(Save_MEM);
    // Save_MEM = NULL;
    // return;
    // }
    // else {TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, "rcRfm_Data_BkSet : No Save Data");
    // }
    return;
  }

  /// 関連tprxソース: rcky_rfm.c - rcRfm_DivAdj_Write_rcpt_no
  static Future<void> rcRfmDivAdjWriteRcptNo() async {
    int i = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    await EnvironmentData().tprLibGetEnv();
    String tprPath = EnvironmentData().sysHomeDir;

    if (cBuf.dbTrm.qcDivadjRfmPrc != 0 &&
        cBuf.bkTtlLog.t100002Sts.warikanFlg > 0) {
      for (i = 0; i < cBuf.bkTtlLog.t100002Sts.warikanFlg; i++) {
        if (rcChkRfmWarikanAmt(i) != 0) {
          await rcRfmWriteRcptNo(tprPath);
        }
      }
    } else {
      await rcRfmWriteRcptNo(tprPath);
    }
  }

  /// 関連tprxソース: rcky_rfm.c - rcRfm_Write_rcpt_no
  static Future<void> rcRfmWriteRcptNo(String path) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.bkTHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_TRAINING) {
      /* 訓練モード */
      return;
    }

    if (receiptNo >= 9999) {
      receiptNo = 1;
    } else {
      receiptNo++;
    }

    await CompetitionIni.competitionIniSet(
        await RcSysChk.getTid(), CompetitionIniLists.COMPETITION_INI_RECEIPT_NO,
        CompetitionIniType.COMPETITION_INI_SETSYS, receiptNo.toString());
  }
}
