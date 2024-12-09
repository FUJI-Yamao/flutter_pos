/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';

import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_ary/chk_spc.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/receipt_void/p_receipt_scan.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_clxos_payment.dart';
import 'rc_elog.dart';
import 'rc_ext.dart';
import 'rc_ifevent.dart';
import 'rc_itm_dsp.dart';
import 'rc_key_stf_release.dart';
import 'rc_recno.dart';
import 'rc_set.dart';
import 'rc_setdate.dart';
import 'rc_stl.dart';
import 'rcfncchk.dart';
import 'rcky_clr.dart';
import 'rcky_rfm.dart';
import 'rcky_rpr.dart';
import 'rcky_taxfreein.dart';
import 'rcmbrflrd.dart';
import 'rcschrec.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcky_erctfm.h - ERCTFM_SUBTOTAL_INFO
class ErctfmSubtotalInfo {
  int receiptNo = 0;    // レシートNo.
  int printNo = 0;      // ジャーナルNo.
  int stlDscBfrAmt = 0; // 小計
  int qty = 0;          // 買上点数
  int taxBlOutAmt = 0;  // 外税対象額
  int taxOutAmt = 0;    // 外税額
  int taxBlInAmt = 0;   // 内税対象額
  int taxInAmt = 0;     // 内税額
  int taxInItemAmt = 0; // 理論内税額
  int exTaxBl = 0;      // 保税対象額
  int inTaxBl = 0;      // 免税対象額
  int noTaxAmt = 0;     // 内貨対象額
}

///  関連tprxソース: rcky_erctfm.c
class RckyErctfm {
/*----------------------------------------------------------------------*
 * Values
 *----------------------------------------------------------------------*/
  static Erctfm eRctfm = Erctfm();
  static RegsMem wkMem = RegsMem();
  static RegsMem erfmSaveMem = RegsMem();
  static ErctfmSubtotalInfo erctfmStlInf = ErctfmSubtotalInfo();
  static int bkScrMode = 0;
  static int erctfmReceiptNo = 0;
  static int erctfmPrintNo = 0;
  static bool erctfmReprint = false; // 再発行状態

/*----------------------------------------------------------------------*
 * Constant Values
 *----------------------------------------------------------------------*/
  static List<int> erfmList0 = [FncCode.KY_ENT.keyId, FncCode.KY_REG.keyId, 0];
  static List<int> erfmList1 = [0];
  static List<int> erfmList2 = [0];
  static List<int> erfmList3 = [0];
  static List<int> erfmList4 = [0];

  static EjConf ejConf = EjConf();

/*----------------------------------------------------------------------*
 * Display Program
 *----------------------------------------------------------------------*/
  /// 機能    ：検索領収書のスキャン画面を開く
  /// 引数    ：String title
  ///        ：FuncKey funcKey
  /// 関連tprxソース: rcky_erctfm.c - rcERctfmDsp_Entry
  static void openReceiptScanPage(String title, FuncKey funcKey) {
    Get.to(() => ReceiptScanPageWidget(title: title, funcKey: funcKey));
  }

  /// 関連tprxソース: rcky_erctfm.c - rcKyERctfm
  static Future<void> rcKyERctfm() async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxCommonBuf pCom = SystemFunc.readRxCommonBuf();
    erctfmStlInf = ErctfmSubtotalInfo();

    cMem.ent.errNo = await rcCheckKyERctfm();
    if (cMem.ent.errNo == Typ.OK) {
      if (FbInit.subinitMainSingleSpecialChk() == true) {
        if (ejConf.nowDisplay == 0) {
          cMem.stat.dualTSingle = pCom.devId;
        }
      }
      else {
        cMem.stat.dualTSingle = 0;
      }
      erfmSaveMem = mem;
      rcKyERctfmMain();
    }
    else {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: cMem.ent.errNo,
        ),
      );
      RcSet.rcClearEntry();
      RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
    }
    return;
  }

  /// 関連tprxソース: rcky_erctfm.c - rcCheck_Ky_ERctfm
  static Future<int> rcCheckKyERctfm() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (DlgConfirmMsgKind.MSG_NOTUSE_RFM1.dlgId);
    }
    RxCommonBuf pCom = xRet.object;

    cMem.stat.opeMode = RcRegs.RG;
    if ((!RcSysChk.rcRGOpeModeChk()) && (!RcSysChk.rcTROpeModeChk())) {
      return (DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId);
    }

    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        (!await RcSysChk.rcCheckQCJCSystem())) {
      return (DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId);
    }

    // TODO:暫定的に無効化する
    // TODO:この機能に入る前にどこかでkyStS3しているはずだが見つからず
    // TODO:判明次第有効化すること
    // if (!RcRegs.kyStC3(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
    //   return (DlgConfirmMsgKind.MSG_REGSTART_ERROR.dlgId);
    // }

    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    List<int> p = []; int i;
    p = erfmList0; i = 0; while (p[0 + i] != 0) { RcRegs.kyStR0(cMem.keyChkb, i); i++; }
    p = erfmList1; i = 0; while (p[0 + i] != 0) { RcRegs.kyStR1(cMem.keyChkb, i); i++; }
    p = erfmList2; i = 0; while (p[0 + i] != 0) { RcRegs.kyStR2(cMem.keyChkb, i); i++; }
    p = erfmList3; i = 0; while (p[0 + i] != 0) { RcRegs.kyStR3(cMem.keyChkb, i); i++; }
    p = erfmList4; i = 0; while (p[0 + i] != 0) { RcRegs.kyStR4(cMem.keyChkb, i); i++; }
    if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
      return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    }

    if ((pCom.dbTrm.issueNotePrn == 5) || (pCom.dbTrm.issueNotePrn == 6)) {
      //　領収書付レシートの為
      if (pCom.dbTrm.selfRfmDispFlg != 0) {
        return (DlgConfirmMsgKind.MSG_NOTUSE_RFM2.dlgId);
      }
      else {
        return (DlgConfirmMsgKind.MSG_NOTUSE_RFM1.dlgId);
      }
    }

    return (Typ.OK);
  }

/*----------------------------------------------------------------------*
 * Main Program
 *----------------------------------------------------------------------*/
  /// 関連tprxソース: rcky_erctfm.c - rcKy_ERctfm
  static Future<int> rcKyERctfmMain() async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSingl = SystemFunc.readAtSingl();

    if (ejConf.nowDisplay == 0) {
      if ((!await RcFncChk.rcCheckStlMode()) &&
          (!RcFncChk.rcCheckSItmMode()) &&
          (await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE))
      {
        if (!ChkSpc.cmChkSpc(cMem.scrData.subibuf, cMem.scrData.subibuf.length)) {
          await RcItmDsp.rcDspEntLCD();
          await RcItmDsp.rcQtyClr();
        }
      }
    }

    await RcExt.cashStatSet("rcKyERctfmMain");

    if (RcSysChk.rcsyschkVescaSystem()) {
      mem.prnrBuf.vescaReceiptCnt = 0;
      mem.prnrBuf.vescaDtlRowId = 0;
      mem.prnrBuf.vescaDtl1RowId = 0;
      mem.prnrBuf.vescaDtl2RowId = 0;
      mem.prnrBuf.vescaDtl3RowId = 0;
      mem.prnrBuf.checkVescaReceiptEnd = 0;
      mem.prnrBuf.vescaQcSign = 0;
      mem.prnrBuf.vescaDtl = List.filled(vescaDataMax, VescaDtl());
    }

    atSingl.fselfInoutChk = 1; // 常時入金仕様時、このタイミングで釣銭機をIN状態にさせない為

    // スキャン画面表示
    openReceiptScanPage("検索領収書", FuncKey.KY_ERCTFM);
    return (Typ.OK);
  }

  /// 関連tprxソース: rcky_erctfm.c - ERctfm_Start
  static Future<int?> erctfmStart() async {
    int? errNo = Typ.OK;
    String tsSql = "";
    String localSql = "";
    String date = "";
    Map<String, dynamic>? tsSubValues = {};
    Map<String, dynamic>? subValues = {};
    Result lRes;

    (tsSql, localSql) = RcSchRec.rcSchDBMkSql(
        FuncKey.KY_ERCTFM,
        date,
        eRctfm.macNo,
        eRctfm.recNo,
        0,
        eRctfm.date,
        eRctfm.amt);

    lRes = await RcSchRec.rcVoidDbPQexec(tsSql, tsSubValues, localSql, subValues);
    if (lRes.isEmpty) {
      return (DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId);
    }
    if (lRes.affectedRows == 0) {
      await RcSchRec.rcSchDbClose();
      return (DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId);
    }

    // 免税仕様の場合、MEMの情報から免税宣言フラグを復元する
    if (await RckyRpr.rcCheckTaxFreeDecRcpt() != 0) {
      RckyTaxFreeIn.rcTaxFreeRestoreTaxFreeFlg();
    }

    if (await RcSysChk.rcChkOneToOnePromSystem()) {
      RcMbrFlrd.rcmbrReadStpCdPrintData();
    }

    if (await CmCksys.cmStaffReleaseSystem() != 0) {
      RcKyStfRelease.rcPrgStfReleaseResave();
    }

    errNo = await erctfmSend();
    if (errNo != 0){
      return errNo;
    }
    return (0);
  }

  /// 関連tprxソース: rcky_erctfm.c - ERctfm_Send
  static Future<int?> erctfmSend() async {
    int errNo = Typ.OK;
    int errNo2;
    String callFunc = 'erctfmSend';

    RegsMem saveMem = RegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    RxCommonBuf pCom = SystemFunc.readRxCommonBuf();

    await RcExt.cashStatSet("erctfmSend");
    errNo = await RcFncChk.rcChkRPrinter();

    if (errNo != 0) {
      await RcSchRec.rcSchDbClose();
      return (errNo);
    }
    else {
      cMem.stat.fncCode = FuncKey.KY_ERCTFM.keyId;
      cMem.scrData.price = mem.tTtllog.t100001Sts.amount;

      mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_ERCTFM.index;

      mem.tHeader.receipt_no =
      await Counter.competitionGetRcptNo(await RcSysChk.getTid());
      if (mem.tHeader.receipt_no <= 0) {
        mem.tHeader.receipt_no = 9999;
      }
      mem.tHeader.print_no =
      await Counter.competitionGetPrintNo(await RcSysChk.getTid());
      mem.tHeader.mac_no =
          (await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value;

      if (mem.tHeader.serial_no != null) {
        mem.tHeader.void_serial_no = mem.tHeader.serial_no!;
      }
      mem.tHeader.void_kind = 3;
      if (mem.tHeader.sale_date != null) {
        mem.tHeader.void_sale_date = mem.tHeader.sale_date!;
      }

      atSingl.rctChkCnt = 0;
      await RcExt.rxChkModeSet("erctfmSend");
      await RcSetDate.rcSetDate();
      errNo = Typ.OK;
      errNo2 = Typ.OK;

      CalcResultSearchReceipt retData = await RcClxosPayment.searchReceipt(pCom);
      if (0 != retData.retSts) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "erctfmSend ${retData.errMsg}");
        if (retData.posErrCd != null) {
          return retData.posErrCd;
        } else {
          return DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId;
        }
      } else {
        //　印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(Tpraid.TPRAID_CASH, retData.digitalReceipt, callFunc);
      }

      if (CompileFlag.DEPARTMENT_STORE) {
        saveMem = mem;

        RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); // Total receipt clear
        mem.tHeader.receipt_no = await Counter.competitionGetRcptNo(await RcSysChk.getTid()) - 1;
        mem.tHeader.print_no = await Counter.competitionGetPrintNo(await RcSysChk.getTid());
        mem.tTtllog.calcData.damtFsppur = mem.tTtllog.t100001Sts.amount;
        await RcSetDate.rcSetDate();
      } else {
        RckyRfm.rcRfmDataSet();
      }
      errNo2 = RcIfEvent.rcSendUpdate();
      if (CompileFlag.DEPARTMENT_STORE) {
        mem = saveMem;
      } else {
        RckyRfm.rcRfmDataBkSet();
      }

      await RcRecno.rcIncRctJnlNo(false);
    }

    return (Typ.OK);
  }

  /// 機能    ：領収書印字終了
  /// 引数    ：int erCode
  /// 関連tprxソース: rcky_erctfm.c - rcERctfm_End
  static Future<void> rcERctfmEnd(int errNo) async {
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcESvoid_End:cash Action");

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    // TODO:暫定対応---------------------
    // rcLoopProc()が解決したら削除して実装し直す(#1789)
    await RcExt.rxChkModeReset("rcERctfmEnd");
    // ---------------------TODO:暫定対応

    if (errNo == Typ.OK) {
      if (cMem.stat.dspEventMode != 0) {
        return;
      }
    }
    else {
      await RcExt.rxChkModeReset("rcERctfmEnd");
    }

    if (errNo != Typ.OK) {
      if (errNo > 0) {
        mem.tTtllog.t100001Sts.receiptNo = 0;
     }
    }

    mem.tTtllog.t100001Sts.receiptNo = 0;

    RckyClr.rcResetKyStatus();

    RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_STL.keyId);

    await RcSchRec.rcSchDbClose();

    if (errNo == Typ.OK) {
      eRctfm.nowSelectDisplay = 0;
    }
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); // Total receipt clear

    return;
  }
}