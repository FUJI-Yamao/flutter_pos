/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/cm_bcd.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../../lib/cm_bcd/ucmp.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/receipt_void/controller/c_receiptInput_ctrl.dart';
import '../inc/L_rckycrdtvoid.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'liblary.dart';
import 'rc_acracb.dart';
import 'rc_atct.dart';
import 'rc_barcode_pay.dart';
import 'rc_crdt_fnc.dart';
import 'rc_dpoint.dart';
import 'rc_elog.dart';
import 'rc_ewdsp.dart';
import 'rc_ext.dart';
import 'rc_gtktimer.dart';
import 'rc_ifevent.dart';
import 'rc_ifprint.dart';
import 'rc_key_stf.dart';
import 'rc_mbr_com.dart';
import 'rc_multi.dart';
import 'rc_set.dart';
import 'rc_setdate.dart';
import 'rc_stl_cal.dart';
import 'rc_suica_com.dart';
import 'rc_voidupdate.dart';
import 'rccardcrew.dart';
import 'rcfcl_com.dart';
import 'rcfncchk.dart';
import 'rcid_com.dart';
import 'rcky_cashvoid.dart';
import 'rcky_evoid.dart';
import 'rcky_mbrprn.dart';
import 'rcky_rfdopr.dart';
import 'rcky_rpr.dart';
import 'rcky_taxfreein.dart';
import 'rcopncls.dart';
import 'rcpana_inq.dart';
import 'rcquicpay_com.dart';
import 'rcschrec.dart';
import 'rcsyschk.dart';
import 'rctbafc1.dart';
import 'regs.dart';
import 'rxregstr.dart';

class RcKyCrdtVoid {
  /// メモリ初期化フラグ
  static bool crdtMemClrFlg = false;

  /// 問い合わせフラグ
  static bool crdtVoidActFlg = false;
  static bool openType = false;
  static RegsMem crdtVoidMem = RegsMem();
  static RegsMem crdtVoidSaveMem = RegsMem();
  static RegsMem crdtVoidWork = RegsMem();
  static RegsMem crdtVoidUpdateSaveMem = RegsMem();
  static CrdtVoid crdtVoid = CrdtVoid();
  static CmEditCtrl fCtrl = CmEditCtrl();
  static CCustMst cust = CCustMst();
  static SCustTtlTbl enq = SCustTtlTbl();
  static VoidUpdateParam voidParam = VoidUpdateParam(); //訂正操作で使用する値を格納
  static int custrealMbrUpdate = 0;
  static int voidMbrPnt = 0;
  static int voidMbrTckt = 0;
  static int voidRprFlg = 0;
  static int voidTaxFree = 0;
  static int mbrFlg = 0;
  static int custAddFlg = 0;
  static int dPointFlg = 0;
  static int rePrnFlg = 0;
  static int prChkTimer = -1;
  static String ut1Msg = '';
  static String crdtVoidIpAddr = "";

  /// 【dart置き換え時追加】c_status_logのstatus_dataから取得するものを格納
  static int ttlLvl = 0;
  static String payAWay = '';
  static String seqInqNo = '0';
  static int posReceiptNoByCDataLog = 0;
  static String streJoinNoByCDataLog = '0';
  static String mbrCdByCDataLog = '0';
  static int bonusMonthSignByCStatusLog = 0;
  static String recognNo = '0';
  static String personCd = '0';

  /// 返品モードでクレジット訂正関数を使用するためのメモリ初期化関数
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoidClearMem
  static void rcCrdtVoidClearMem() {
    RcSet.rcClearCrdtReg();
    crdtMemClrFlg = false;
    crdtVoidSaveMem = RegsMem();
    crdtVoid = CrdtVoid();
  }

  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_ActFlg_Reset
  static void rcCrdtVoidActFlgReset() {
    crdtMemClrFlg = false;
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.ent.errNo != 0) {
      cMem.ent.errNo = 0;
    }
  }

  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_PostPay_End
  static Future<void> rcCrdtVoidPostPayEnd() async {
    crdtVoidClear();
    await RcIfEvent.rxChkTimerAdd();

    // RegsMem regsMem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    // if ( await RcSysChk.rcChkSPVTSystem() && regsMem.tCrdtLog[0].t400000.space == 5) {
    if (await RcSysChk.rcChkSPVTSystem() &&
        cMem.working.crdtReg.icCardType == 5) {
      await rcCrdtVoidExecFunc();
    } else {
      await rcCrdtVoidPostPayExecFnc();
    }
    return;
  }

  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_TSVoidUpDate
  static Future<void> rcCrdtVoidTSVoidUpDate(int opeModeFlg) async {
    if (RcVoidUpdate.rcCheckVoidResultMyself()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcCrdtVoid_TSVoidUpDate: Skip");
      return;
    }

    // TODO:00002 佐野 - db_SrLogin()の対応が必要
    /*
    if ((ts_voidcon = db_SrLogin(GetTid( ), DB_ERRLOG)) != NULL) {
      String date = crdtVoid.date.substring(6, 8);
      String sql = "select MAX(receipt_no) as receipt_no, MAX(print_no) as print_no, MAX(void_receipt_no) as void_receipt_no, MAX(void_print_no) as void_print_no from c_ttllog$date where mac_no='${crdtVoidMem.tHeader.mac_no}'";
      int receiptNo = 0;
      int printNo = 0;
      int voidReceiptNo = 0;
      int voidPrintNo = 0;
      DbManipulationPs db = DbManipulationPs();
      Result lres = await db.dbCon.execute(sql);
      if (lres.isNotEmpty) {
        if (lres.affectedRows != 0) {
          Map<String, dynamic> data = lres.first.toColumnMap();
          receiptNo = int.parse(data["receipt_no"]) ?? 0;
          printNo = int.parse(data["print_no"]) ?? 0;
          voidReceiptNo = int.parse(data["void_receipt_no"]) ?? 0;
          voidPrintNo = int.parse(data["void_print_no"]) ?? 0;
        }
        if (receiptNo < voidReceiptNo) {
          receiptNo = voidReceiptNo;
        }
        if (print_no < void_print_no) {
          printNo = voidPrintNo;
        }
        receiptNo++;
        printNo++;
        if (receiptNo > 999999) {
          receiptNo = 1;
        }
        if (printNo > 999999) {
          printNo = 1;
        }
        sql = "INSERT INTO c_ttllog$date (tran_flg,stre_cd,mac_no,receipt_no,print_no,chkr_no,chkr_name,cshr_no,cshr_name,now_sale_datetime,sale_date,ope_mode_flg,void_mac_no,void_receipt_no,void_print_no,esvoid_flg) values (0,'${crdtVoidMem.tHeader.stre_cd}','${crdtVoidMem.tHeader.mac_no}','${crdtVoidMem.tHeader.receipt_no}','${crdtVoidMem.tHeader.print_no}','${crdtVoidMem.tHeader.chkr_no}','${crdtVoidMem.tTtllog.t1000.chkrName}','${crdtVoidMem.tHeader.cshr_no}','${crdtVoidMem.tTtllog.t1000.cshrName}','now','${crdtVoidMem.tHeader.sale_date}','$opeModeFlg','${crdtVoidMem.tHeader.mac_no}','$receiptNo','$printNo',1)";
        lres = await db.dbCon.execute(sql);
      }
    }
     */
  }

  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_Update
  static Future<int> rcCrdtVoidUpdate() async {
    RegsMem mem = SystemFunc.readRegsMem();
    crdtVoidUpdateSaveMem = mem;

    mem.prnrBuf.crdtVoid.macNo = mem.tHeader.mac_no;
    mem.prnrBuf.crdtVoid.receiptNo = mem.tHeader.receipt_no;
    mem.prnrBuf.crdtVoid.printNo = mem.tHeader.print_no;
    mem.prnrBuf.crdtVoid.voidMacNo = mem.tTtllog.t100001Sts.voidMacNo;
    mem.prnrBuf.crdtVoid.voidReceiptNo = mem.tTtllog.t100001Sts.voidReceiptNo;
    mem.prnrBuf.crdtVoid.voidPrintNo = mem.tTtllog.t100001Sts.voidPrintNo;

    voidParam = await RcVoidUpdate.rcCallBlockVoidResultMyself(voidParam);
    custrealMbrUpdate = 0;

    return await RcVoidUpdate.rcvoidLogUpdate(
        FuncKey.KY_CRDTVOID.keyId, crdtVoidIpAddr, custrealMbrUpdate);
  }

  ///  関連tprxソース: rckycrdtvoid.c - CrdtVoid_PopUp
  // TODO:00004　小出　定義のみ追加する。
  static void crdtVoidPopUp(int err_no) {
    //rcCrdtVoid_DialogErr(err_no, 1, NULL);
  }

  /// 問い合わせフラグを初期化し、クレジット訂正ダイアログを閉じる
  ///  関連tprxソース: rckycrdtvoid.c - CrdtVoid_Clear
  static Future<void> crdtVoidClear() async {
    crdtVoidActFlg = false;
    await rcCrdtVoidDialogClear();
  }

  /// 元伝票番号、カード番号の入力を行わない仕様
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_Chk_Easy
  static bool rcCrdtVoidChkEasy() {
    if (RcSysChk.rcChkDepartmentSystem() &&
        RcSysChk.rcChkCrdtUser() != RcCrdt.NAKAGO_CRDT) {
      return true;
    }
    return false;
  }

  /// ダイアログパラメタを設定する
  /// 引数:[type] 未使用
  /// 引数:[errCode] エラーコード
  /// 引数:[userCode] 会員コード
  /// 引数:[func1] Function 1
  /// 引数:[msg1] Message 1
  /// 引数:[func2] Function 2
  /// 引数:[msg2] Message 2
  /// 引数:[dspMsg] ディスプレイメッセージ
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_DialogConf
  static Future<void> rcCrdtVoidDialogConf(
      int type,
      int errCode,
      int userCode,
      Function? func1,
      String msg1,
      Function? func2,
      String msg2,
      String dspMsg) async {
    BackUpDlg param = BackUpDlg();
    String msgBuf = "";

    param.er_code = errCode;
    param.dialog_ptn = DlgPattern.TPRDLG_PT1.dlgPtnId;
    param.func1 = func1;
    param.msg1 = msg1;
    if (func2 != null) {
      param.func2 = func2;
      param.msg2 = msg2 ?? "";
    }
    param.title = LRckyCrdtVoid.CRDTVOID_CONF;
    param.user_code = userCode;
    if (dspMsg != null) {
      param.user_code = 0;
      msgBuf = dspMsg;
    }
    param.user_code_2 = msgBuf;

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        TprLibDlg.TprLibDlgGetDlgParam(param);
        break;
      case RcRegs.KY_SINGLE:
        if (crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
          AcMem cMem = SystemFunc.readAcMem();
          if (cMem.stat.dualTSingle == 1) {
            param.dual_dsp = 2;
          }
          TprLibDlg.TprLibDlgGetDlgParam(param);
        }
        break;
    }
  }

  /// ダイアログパラメタを設定する（終了時）
  /// 引数:[errCode] エラーコード
  /// 引数:[userCode] 会員コード
  /// 引数:[func1] Function 1
  /// 引数:[msg1] Message 1
  /// 引数:[func2] Function 2
  /// 引数:[msg2] Message 2
  /// 引数:[freeWord] メッセージ
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_DialogConf_CustAdd3
  static Future<int> rcCrdtVoidDialogConfCustAdd3(int errCode, int userCode,
      Function? func1, String msg1, String freeWord) async {
    BackUpDlg param = BackUpDlg();
    String frWord = "";

    param.er_code = errCode;
    param.dialog_ptn = DlgPattern.TPRDLG_PT2.dlgPtnId;
    param.func1 = func1;
    param.msg1 = msg1;
    param.title = LRckyCrdtVoid.CRDTVOID_CONF;
    param.user_code = userCode;

    frWord = freeWord;

    param.user_code_4 = frWord;

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        TprLibDlg.TprLibDlgGetDlgParam(param);
        break;
      case RcRegs.KY_SINGLE:
        if (crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
          AcMem cMem = SystemFunc.readAcMem();
          if (cMem.stat.dualTSingle == 1) {
            param.dual_dsp = 2;
          }
          TprLibDlg.TprLibDlgGetDlgParam(param);
        }
        break;
      default:
        break;
    }
    return 0;
  }

  /// クレジット訂正ダイアログを閉じる
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_DialogClear
  static Future<void> rcCrdtVoidDialogClear() async {
    String funcName = "rcCrdtVoidDialogClear";
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        TprLibDlg.tprLibDlgClear2(funcName);
        // TODO:10122 グラフィクス処理（gtk_*）
        if (await RcFncChk.rcCheckCrdtVoidMode()) {
          //gtk_grab_add(CrdtVoid.window);
        } else if ((await RcFncChk.rcCheckCrdtVoidSMode()) ||
            (await RcFncChk.rcCheckCrdtVoidIMode())) {
          //gtk_grab_add(Subttl.window);
        } else if (await RcFncChk.rcCheckCrdtVoidAMode()) {
          //gtk_grab_add(CrdtVoid.awin);
        }
        break;
      case RcRegs.KY_CASHIER:
        if (crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
          TprLibDlg.tprLibDlgClear2(funcName);
          // TODO:10122 グラフィクス処理（gtk_*）
          if (await RcFncChk.rcCheckCrdtVoidMode()) {
            //gtk_grab_add(CrdtVoid.window);
          } else if ((await RcFncChk.rcCheckCrdtVoidSMode()) ||
              (await RcFncChk.rcCheckCrdtVoidIMode())) {
            //gtk_grab_add(Subttl.window);
          } else if (await RcFncChk.rcCheckCrdtVoidAMode()) {
            //gtk_grab_add(CrdtVoid.awin);
          }
        }
        break;
      default:
        break;
    }
    if (crdtVoid.dialog == 2) {
      crdtVoid.dialog = 0;
    } else {
      crdtVoid.errNo = 0;
    }
  }

  // TODO:00002 佐野 - rcCrdtVoidEnd()実装の為、定義のみ追加
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_Rpr
  static Future<int> rcCrdtVoidRpr() async {
    /*
    if (crdtVoid.regsprnFlg == 0) {
      return 0;
    }
    rcCrdtVoidTimerRemove();

    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.dspEventMode != 0) {
      RcGtkTimer.rcGtkTimerAdd(50, rcCrdtVoidRpr);
      return 0;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    int updErrFlg = mem.prnrBuf.crdtvoidUpderrFlg;
    crdtVoidWork = mem;
    mem = crdtVoidMem;
    rePrnFlg = 1;
    mem.prnrBuf.crdtvoidUpderrFlg = updErrFlg;

    if (await CmCksys.cmHc2KuroganeyaSystem(await RcSysChk.getTid()) == 1) {	/* 延長保証条件 */
      rcExtGuaranteeJanSet_atct();
    }
    crdtVoid.regsprnFlg = false;

    int errNo = await RcFncChk.rcChkRPrinter();
    if (errNo != OK) {
      rcCrdtVoidDialogClear();
      await rcCrdtVoidDialogErr(errNo, 1, null);
      crdtVoid.regsprnFlg = true;
      return -1;
    } else {
      AtSingl atSing = SystemFunc.readAtSingl();
      atSing.rctChkCnt = 0;
      await RcExt.rxChkModeSet("rcCrdtVoidRpr");
      mem.prnrBuf.receiptNo = 10000;
      voidRprFlg = 1;
      errNo = rc_Send_Print();
      if (errNo != OK) {
        mem.prnrBuf.receiptNo = 0;
        voidRprFlg = 0;
        rcCrdtVoidDialogClear();
        await rcCrdtVoidDialogErr(errNo, 1, null);
        rxChkModeReset();
        crdtVoid.regsprnFlg = true;
      } else {
        RckyRpr.rcWaitResponce(FuncKey.KY_CRDTVOID.keyId);
      }
    }
    mem = crdtVoidWork;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    int taxFreeCnt = 0;
    if ((RckyTaxFreeIn.rcTaxFreeChkTaxFreeInSystem() != 0)
        && (voidTaxFree == 1)) {
      rcTaxFree_Restore_TaxFreeFlg();
      if (cm_taxfree_by_kind_system()) {
        taxFreeCnt = rxChkKoptCmn_TaxFreeIn_TaxFreeRcptNum(cBuf);
      } else {
        taxFreeCnt = rxChkKoptCmn_StlBtn_TaxFreeRcptNum(cBuf);
      }
      for (int cnt=0; cnt < taxFreeCnt; cnt++) {
        mem.prnrBuf.taxfreePrnSelect[cnt] = 1;
      }
    }
     */
    return 0;
  }

  // TODO:00002 佐野 - rcCrdtVoidEnd()実装の為、定義のみ追加
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoidS_CloseKeyEnd
  static Future<void> rcCrdtVoidSCloseKeyEnd() async {
    /*
    if (crdtVoid.regsprnFlg == 0) {
      return;
    }
    rcCrdtVoidTimerRemove();

    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.dspEventMode != 0) {
      RcGtkTimer.rcGtkTimerAdd(50, rcCrdtVoidSCloseKeyEnd);
      return;
    }
    rcCrdtVoidDialogClear();

    RegsMem mem = SystemFunc.readRegsMem();
    if ((await CmCksys.cmIchiyamaMartSystem() != 0)
        && (mem.tTtllog.t100001.periodDscAmt != 0) ){
      rcBC_Before(mem.tTtllog.t100001.periodDscAmt);
    } else {
      rcCrdtVoidS_CloseKeyEnd2(null, null);
    }
     */
  }

  /// クレジット訂正ダイアログを閉じる（終了時）
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_DialogClear_CustAdd3
  static Future<void> rcCrdtVoidDialogClearCustAdd3() async {
    await rcCrdtVoidDialogClear();
    RcSet.rcClearCreditErrCode();
    // TODO:10122 グラフィクス処理（gtk_*）
    if (crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
      //gtk_grab_add(Subttl.window);
    }
    crdtVoid.dialog = 0;
    if (crdtVoidActFlg) {
      fCtrl.SignEdit = 1;
      if (CompileFlag.DECIMAL_POINT) {
        // TODO:10125 通番訂正 202404実装対象外
        //rcDsp_SetCNCtl(&fCtrl);
      } else {
        fCtrl.CurrencyEdit = 2;
        fCtrl.SeparatorEdit = 2;
      }
      rcCrdtVoidDialogConf(
          1,
          DlgConfirmMsgKind.MSG_ARE_YOU_READY.dlgId,
          1,
          rcCrdtVoidSCloseKeyEnd,
          LTprDlg.BTN_YES,
          rcCrdtVoidRpr,
          LRckyCrdtVoid.CRDTVOID_BTN_REPRN,
          '');
      RcIfEvent.rxChkModeReset2("rcCrdtVoidDialogClearCustAdd3");
    }
  }

  /// 訂正処理
  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_ExecFnc
  /// 戻値: 0=OK  -1=NG
  static Future<int> rcCrdtVoidExecFunc() async {
    int opeMode = 0;
    debugPrint('payvoid調査ログ:rcCrdtVoidExecFunc スタート地点');

    // 全返品モード関数へ移行
    if (RckyRfdopr.rcRfdOprCheckAllRefundMode() ||
        RckyRfdopr.rcRfdOprCheckRcptVoidMode()) {
      debugPrint(
          'payvoid調査ログ:rcCrdtVoidExecFunc rcRfdOprAllRefundCreditEnd(0)');
      await RckyRfdopr.rcRfdOprAllRefundCreditEnd(0);
      return 0;
    }

    // TODO:10125 通番訂正 202404実装対象外
    // > rcCrdtVoidInquStart() と rcCrdtVoid_PostPay_End() で呼び出されてますが、
    //   前者は「TUO仕様のみ」、 後者は「SPVT(Smartplus/Visa Touch取引)仕様のみ」のため、
    //   4月向けでは rcCrdtVoid_ExecFnc() が使われないとの判断で、以降の処理は未構築

    return 0;
  }

  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_MbrActChk
  static Future<bool> rcCrdtVoidMbrActChk() async {
    bool ret = false;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.voidCust == 1) {
      if (CompileFlag.SAPPORO) {
        if ((await CmCksys.cmChkRwcCust() == 0) ||
            (await RcSysChk.rcChkJklPanaSystem() &&
                (CmCksys.cmMatugenSystem() == 1))) {
          ret = true;
        }
      } else {
        if (await CmCksys.cmChkRwcCust() == 0) {
          ret = true;
        }
      }
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if ((await RcSuicaCom.rcNimocaRdVoidData()) &&
        (mem.tTtllog.t100700Sts.voidIccnclMsgFlg != 0)) {
      ret = false;
    }
    // 全日食様だけは顧客実績はクリアする
    if (await CmCksys.cmZHQSystem() == 1) {
      if (mem.tTtllog.t100003.voidFlg == 7) {
        ret = false;
      }
    }

    return ret;
  }

  /// タイマー初期化関数（Add関数実装時、初期化処理を行う）
  /// 戻値: 0固定
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoidTimerRemove
  static int rcCrdtVoidTimerRemove() {
    //RcVoidUpdate.rcVoidProcTimerRemove();  //rc_voidupdate.c 参照
    return 0;
  }

  ///「登録、訂正、訓練、廃棄」モードの場合、画面を SubItem に変更する（Single機のみ）
  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoidSDisplay_Entry
  static Future<void> rcCrdtVoidSDisplayEntry() async {
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        break;
      case RcRegs.KY_SINGLE:
        if (crdtVoid.nowDisplay != RcElog.CRDTVOID_LCDDISP) {
          if (await RcFncChk.rcCheckCrdtVoidSMode()) {
            RcSet.rcCrdtVoidISubScrMode();
          }
        }
        break;
      default:
        break;
    }
  }

  /// 訂正用実績データ編集処理
  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoidEditTranDate
  /// 引数:[opeModeFlg] 操作モード
  /// 引数:[crdtVoidMem] "RegsMem"クラス（コンパイルSW"MC_SYSTEM"専用）
  /// 引数:[crdtVoidWork] "RegsMem"クラス（コンパイルSW"IC_CONNECT"専用）
  /// 引数:[slipNo] 販売員コード（コンパイルSW"MC_SYSTEM"専用）
  static Future<void> rcCrdtVoidEditTranDate(int opeModeFlg,
      RegsMem crdtVoidMem, RegsMem crdtVoidWork, int slipNo) async {
    RxMemRet xRetCmn = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetCmn.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRetCmn.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    mem.tHeader.tran_flg = 0;
    mem.tHeader.ope_mode_flg = opeModeFlg;
    mem.tHeader.sub_tran_flg = 0;
    if (CompileFlag.ARCS_MBR) {
      if (!((await CmCksys.cmNttdPrecaSystem() != 0)
          // && (mem.tCrdtLog[0].t400000.space == 53))) {
          &&
          (cMem.working.crdtReg.icCardType == 53))) {
        mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt -=
            mem.tTtllog.t100900.todayChgamt;
      }
    } else {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt -=
          mem.tTtllog.t100900.todayChgamt;
    }
    // if (mem.tCrdtLog[0].t400000.space > 0) {
    if (cMem.working.crdtReg.icCardType > 0) {
      mem.tTtllog.calcData.mvoidCrdtCnt = 1;
      mem.tTtllog.calcData.mvoidCrdtAmt = await RcCrdtFnc.rcGetCrdtPayAmount();
      mem.tTtllog.calcData.mtriningCrdtAmt =
          -mem.tTtllog.calcData.mtriningCrdtAmt;
    }
    if (RcSysChk.rcChkTtlMulPDscSystem()) {
      mem.prnrBuf.iTmpDscDiffAmt = 0;
    }
    for (int i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if (!(await rcCrdtVoidMbrActChk())) {
        mem.tItemLog[i].t11100.rbtPurAmt = 0;
        if (await RcSysChk.rcChkSapporoRealSystem()) {
          mem.tItemLog[i].t10000Sts.exchgIssueObjFlg = 0;
        }
        mem.tItemLog[i].t11100.mulRbtPurAmt = 0;
        mem.tItemLog[i].t50200?.rbtInputAmt = 0;
        mem.tItemLog[i].t11100.divPpoint = 0;
      }
      if (RcSysChk.rcChkTtlMulPDscSystem()) {
        mem.prnrBuf.iTmpDscDiffAmt +=
            (mem.tItemLog[i].t10300.exchgPnt + mem.tItemLog[i].t10300.exchgQty);
      }
    }
    if ((RckyRfdopr.rfdSaveData?.creditType == 0) &&
        (RckyRfdopr.rfdSaveData?.fncCode == FuncKey.KY_RCPT_VOID.keyId)) {
      // クレジット以外の実績データ編集
      rcCrdtVoidEditTranDateExceptCrdt();
      return;
    }

    int crdtUser = RcSysChk.rcChkCrdtUser();

    // クレジット詳細実績セット
    if ((await CmCksys.cmCrdtSystem() != 0) && /* クレジット仕様？  */
        (await CmCksys.cmNttaspSystem() == 0) && /* NTT以外？         */
        (await CmCksys.cmMcSystem() == 0) &&
        (crdtUser == Datas.KANSUP_CRDT)) /* 関西スーパー？ */ {
      if (mem.tTtllog.t100010.orgRegNo > 0) {
        mem.tTtllog.calcData.cardRetCashCnt = mem.tTtllog.t100010.orgRegNo;
        mem.tTtllog.t100010.orgRegNo = 0;
      }
      if (mem.tTtllog.t100010.orgReceiptNo > 0) {
        mem.tTtllog.calcData.cardRetCashAmt = mem.tTtllog.t100010.orgReceiptNo;
        mem.tTtllog.t100010.orgReceiptNo = 0;
      }
      if (mem.tTtllog.calcData.card1timeCnt > 0) {
        mem.tTtllog.calcData.cardRetCashCnt = mem.tTtllog.calcData.card1timeCnt;
        mem.tTtllog.calcData.card1timeCnt = 0;
      }
      if (mem.tTtllog.calcData.card1timeAmt > 0) {
        mem.tTtllog.calcData.cardRetCashAmt = mem.tTtllog.calcData.card1timeAmt;
        mem.tTtllog.calcData.card1timeAmt = 0;
      }
    }

    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    int recognNo = 0;

    if (CompileFlag.MC_SYSTEM && RcSysChk.rcChkMcSystem()) {
      //TODO:10108 コンパイルスイッチ(MC_SYSTEM)
    } else {
      if (CompileFlag.ARCS_MBR &&
          ((await CmCksys.cmNttdPrecaSystem() != 0)
              // && (mem.tCrdtLog[0].t400000.space == 53))) {
              &&
              (cMem.working.crdtReg.icCardType == 53))) {
        mem.tTtllog.calcData.mvoidCrdtCnt = 0;
        mem.tTtllog.calcData.mvoidCrdtAmt = 0;
        mem.tTtllog.calcData.mtriningCrdtAmt = 0;
        mem.tCrdtLog[0].t400000.tranCd = 4;
        mem.tCrdtLog[0].t400000Sts.saleYyMmDd =
            int.parse(tsBuf.nttdPreca.rxData.pcTime.substring(2));
        mem.tCrdtLog[0].t400000.posRecognNo = tsBuf.nttdPreca.rxData.termId;
        mem.tCrdtLog[0].t400000Sts.taxPostage = tsBuf.nttdPreca.txData.cstax;
        mem.tCrdtLog[0].t400000.saleAmt = tsBuf.nttdPreca.rxData.money;
        mem.tCrdtLog[0].t400000.posReceiptNo = tsBuf.nttdPreca.rxData.dnpCd;
        mem.tCrdtLog[0].t400000Sts.chaCnt1 =
            int.parse(tsBuf.nttdPreca.rxData.valDate);
        mem.tCrdtLog[0].t400000Sts.chaAmt1 = tsBuf.nttdPreca.rxData.zan;
        if (tsBuf.nttdPreca.txData.goods1 > 0) {
          mem.tCrdtLog[0].t400000.changeChkNo =
              tsBuf.nttdPreca.txData.goods1.toString();
        } else {
          mem.tCrdtLog[0].t400000.changeChkNo = CmAry.setStringZero(11);
        }
      } else {
        if (await CmCksys.cmNttaspSystem() != 0) {
          mem.tCrdtLog[0].t400000.tranCd = 1;
          mem.tCrdtLog[0].t400000Sts.reqCode = cMem.working.crdtReg.reqCode;
          mem.tCrdtLog[0].t400000.recognNo = cMem.working.crdtReg.reno.toString();
          RcCrdt.nSet = cMem.working.crdtReg.nttRcv;
          mem.tCrdtLog[0].t400000Sts.chaAmt7 =
              int.parse(RcCrdt.nttf.inf[RcCrdt.nttf.cnt - 1].stoNo);
        } else {
          if (await RcSysChk.rcChkCapSCafisSystem()) {
            RcCrdt.capsReq = RcCrdt.getCapsS(cMem.working.crdtReg.crdtReq.data);
            RcCrdt.capsRcv = RcCrdt.getCapsE(cMem.working.crdtReg.crdtRcv.data);
            mem.tCrdtLog[0].t400000.payAWay =
                RcCrdt.capsReq.detail.substring(0, 60);
            mem.tCrdtLog[0].t400000.tenantCd =
                int.parse(RcCrdt.capsRcv.aprvNum);
            recognNo = int.tryParse(RcCrdt.capsReq.aprvType) ?? 0;
          } else if (await CmCksys.cmCapsPqvicSystem() != 0) {
            RcCrdt.pqvicReq =
                RcCrdt.getCapsPqvicOuthoriTx(cMem.working.crdtReg.crdtReq.data);
            RcCrdt.pqvicRcv =
                RcCrdt.getCapsPqvicOuthoriRx(cMem.working.crdtReg.crdtRcv.data);
            mem.tCrdtLog[0].t400000.posRecognNo =
                RcCrdt.pqvicReq.dutyDataOuthori.macId;
            // mem.tCrdtLog[0].t400000.payAWay = "${mem.tCrdtLog[0].t400000.payAWay.padRight(50, " ")}${RcCrdt.pqvicRcv.dutyDataOuthori.admitNumber}${mem.tCrdtLog[0].t400000.payAWay.substring(50+RcCrdt.pqvicReq.dutyDataOuthori.admitNumber.length)}";
            mem.tCrdtLog[0].t400000.payAWay =
                "${payAWay.padRight(50, " ")}${RcCrdt.pqvicRcv.dutyDataOuthori.admitNumber}${payAWay.substring(50 + RcCrdt.pqvicReq.dutyDataOuthori.admitNumber.length)}";
            mem.tCrdtLog[0].t400000Sts.saleYyMmDd = int.parse(
                RcCrdt.pqvicReq.dutyDataOuthori.tranDatetime.substring(0, 6));
            mem.tCrdtLog[0].t400000Sts.divCom = int.parse(
                RcCrdt.pqvicReq.dutyDataOuthori.tranDatetime.substring(6));
            recognNo =
                int.tryParse(RcCrdt.pqvicReq.dutyDataOuthori.consType) ?? 0;
          } else if (await RcSysChk.rcChkCapsCafisStandardSystem()) {
            if (await CmCksys.cmCapsCardnetSystem() != 0) {
              RcCrdt.capsCardnetRcv =
                  RcCrdt.getCapsCardnetData(cMem.working.crdtReg.crdtRcv.data);
              mem.tCrdtLog[0].t400000.payAWay = Liblary.setStringData(' ', 60);
              mem.tCrdtLog[0].t400000Sts.filler = RcCrdt.capsCardnetRcv.sto;
              mem.tCrdtLog[0].t400000.recognNo =
                  RcCrdt.capsCardnetRcv.admitNumber;
              recognNo = int.tryParse(
                      RcCrdt.capsCardnetRcv.domUse.substring(28, 34)) ??
                  0;
              if (recognNo != 0) {
                recognNo = 1;
              }
            } else {
              RcCrdt.capsCafisReq =
                  RcCrdt.getCapsCafisS(cMem.working.crdtReg.crdtReq.data);
              RcCrdt.capsCafisRcv =
                  RcCrdt.getCapsCafisE(cMem.working.crdtReg.crdtRcv.data);
              mem.tCrdtLog[0].t400000.payAWay =
                  RcCrdt.capsCafisReq.detail.substring(0, 60);
              mem.tCrdtLog[0].t400000Sts.filler =
                  RcCrdt.capsCafisRcv.cafisProcNo;
              mem.tCrdtLog[0].t400000.tenantCd =
                  int.parse(RcCrdt.capsCafisRcv.admitNumber);
              recognNo = int.tryParse(RcCrdt.capsCafisReq.admitType) ?? 0;
            }
          } else {
            RcCrdt.cReq =
                RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
            RcCrdt.cRcv =
                RcCrdt.getCardCrewRcvCom(cMem.working.crdtReg.crdtRcv.data);
            if (CompileFlag.DEPARTMENT_STORE) {
              // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
              /*
              if (!RcSysChk.rcCheckMarine5Simizuya()) {  //RcSysChk.rcCheckMarine5Simizuya()未定義
                mem.tCrdtLog[0].t400000.payAWay = RcCrdt.cReq.payDetail.substring(0, 60);
              }
              */
            } else {
              mem.tCrdtLog[0].t400000.payAWay =
                  RcCrdt.cReq.payDetail.substring(0, 60);
            }
            mem.tCrdtLog[0].t400000.recognNo =
                RcCrdt.cRcv.admitNumber.substring(1, 2);
            recognNo = int.tryParse(RcCrdt.cReq.admitKind) ?? 0;
            if (await RcSysChk.rcChkVegaProcess()) {
              // VEGA3000接続の場合、応答電文の値を参照し端末番号をセットする
              RcCrdt.cRcvVega = RcCrdt.getCardCrewRcvComVega(
                  cMem.working.crdtReg.crdtRcv.data);
              mem.tCrdtLog[0].t400000.posRecognNo =
                  RcCrdt.cRcvVega.rcvAdd.terminalId.substring(0, 5);
              mem.tCrdtLog[0].t400000.cardStreCd = int.tryParse(
                      RcCrdt.cRcvVega.rcvAdd.terminalId.substring(0, 5)) ??
                  0;
            } else {
              // 訂正時は端末IDを再セットする
              await RcCardCrew.rcCardCrewMakeTermID();
              mem.tCrdtLog[0].t400000.posRecognNo = RcCrdt.cReq.macId;
            }
          }
          if (CompileFlag.DEPARTMENT_STORE) {
            // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
            /*
            if (crdtUser == Datas.NAKAGO_CRDT) {
              if ((cMem.working.crdtReg.stat & 0x1000) == 1) {
                mem.tCrdtLog[0].t400000Sts.sign = 1;
                if (mem.tCrdtLog[0].t400000.blackCheck) {
                  mem.tCrdtLog[0].t400000.recognNo = Bcdtol.cmBcdtol(cMem.working.crdtReg.reno, cMem.working.crdtReg.reno.length);
                  //Bcdtol.cmBcdtol(String, int)未定義
                }
              }
            }
            */
          }
          if (await CmCksys.cmTuoSystem() == 1) {
            mem.tCrdtLog[0].t400000.payAWay = cMem.working.crdtReg.rcompanyNm;
          }
          mem.tCrdtLog[0].t400000.blackCheck = recognNo;
          mem.tCrdtLog[0].t400000.tranCd = 4;
          mem.tCrdtLog[0].t400000Sts.sellSts = cMem.working.crdtReg.stat;
          if (crdtUser == Datas.KASUMI_CRDT) {
            if ((cMem.working.crdtReg.stat & 0x1000) == 1) {
              mem.tCrdtLog[0].t400000Sts.sign = 1;
            } else {
              mem.tCrdtLog[0].t400000Sts.sign = 0;
            }
          } else if (crdtUser == Datas.KANSUP_CRDT) {
            if ((cMem.working.crdtReg.stat & 0x1000) == 1) {
              mem.tCrdtLog[0].t400000.recognNo = CmAry.setStringZero(8);
              mem.tCrdtLog[0].t400000.blackCheck = 1;
            }
          }
        }
        // if ((mem.tCrdtLog[0].t400000Sts.ttlLvl & 0x01) == 1) {
        if ((ttlLvl & 0x01) == 1) {
          //クレジット訂正時は必ずサインを頂くので、サインレスのフラグをリセット
          // mem.tCrdtLog[0].t400000Sts.ttlLvl &= ~0x01;
          mem.tCrdtLog[0].t400000Sts.ttlLvl = ttlLvl & ~0x01;
        }
        mem.tCrdtLog[0].t400000Sts.crdtNo =
            (await CompetitionIni.competitionIniGet(
                    await RcSysChk.getTid(),
                    CompetitionIniLists.COMPETITION_INI_CREDIT_NO,
                    CompetitionIniType.COMPETITION_INI_GETMEM))
                .value;
        mem.tCrdtLog[0].t400000.dataStat = 0;
        if (await RcSysChk.rcChkSPVTSystem()) {
          // if (mem.tCrdtLog[0].t400000.space == 5) {  // Smartplus/Visa Touch取引
          if (cMem.working.crdtReg.icCardType == 5) {
            // Smartplus/Visa Touch取引
            crdtVoid.tranType = 0;
            // mem.tCrdtLog[0].t400000Sts.mngPosNo = mem.tCrdtLog[0].t400000Sts.seqInqNo.toString();
            mem.tCrdtLog[0].t400000Sts.mngPosNo = seqInqNo;
            mem.tCrdtLog[0].t400000Sts.seqInqNo = '';
            mem.tCrdtLog[0].t400000Sts.seqInqNo = CmAry.setStringZero(21);
            if (tsBuf.multi.fclData.rcvData.slipNo != 0) {
              mem.tCrdtLog[0].t400000Sts.seqInqNo =
                  tsBuf.multi.fclData.rcvData.slipNo.toString();
            } else {
              if (mem.tHeader.ope_mode_flg ==
                  OpeModeFlagList.OPE_MODE_TRAINING) {
                mem.tCrdtLog[0].t400000Sts.seqInqNo =
                    Liblary.setStringData('9', 8);
              }
            }
          }
        }
        if (CompileFlag.IC_CONNECT) {
          //TODO:10111 コンパイルスイッチ(IC_CONNECT)
        }
        if (CompileFlag.ARCS_MBR &&
            (await CmCksys.cmNttdPrecaSystem() == 1)
            // && (mem.tCrdtLog[0].t400000.space == 53)) {
            &&
            (cMem.working.crdtReg.icCardType == 53)) {
          mem.tCrdtLog[0].t400000.cnclSlipNo =
              tsBuf.nttdPreca.rxData.rednpCd.toString().padLeft(5, "0");
        } else {
          if (await CmCksys.cmCapsPqvicSystem() == 1) {
            mem.tCrdtLog[0].t400000.cnclSlipNo =
                mem.tHeader.receipt_no.toString().padLeft(5, "0");
          } else {
            mem.tCrdtLog[0].t400000.cnclSlipNo =
                posReceiptNoByCDataLog.toString().padLeft(5, "0");
            // = mem.tCrdtLog[0].t400000.posReceiptNo.toString().padLeft(5, "0");
          }
        }
        int posReceiptNo = (await CompetitionIni.competitionIniGet(
                await RcSysChk.getTid(),
                CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO,
                CompetitionIniType.COMPETITION_INI_GETMEM))
            .value;
        if ((await CmCksys.cmNttaspSystem() == 0) &&
            (await CmCksys.cmMcSystem() == 0) &&
            (crdtUser == Datas.KASUMI_CRDT)) {
          // カスミクレジットの場合、伝票番号の採番は１０単位とする
          posReceiptNo -= 10;
          if (posReceiptNo <= 0) {
            // １０単位の採番の為、最大値が算出出来ないので要求電文の伝票番号をセットする
            posReceiptNo = int.tryParse(RcCrdt.cReq.regCreditNumber) ?? 0;
          }
        } else {
          posReceiptNo--;
          if (posReceiptNo == 0) {
            posReceiptNo = 99999;
            if ((await CmCksys.cmNttaspSystem() == 0) &&
                (await CmCksys.cmMcSystem() == 0) &&
                (crdtUser == Datas.KANSUP_CRDT)) {
              // 関西スーパークレジットの場合、伝票番号は１～８９９９９とする
              posReceiptNo = 89999;
            }
          }
          if (await RcSysChk.rcChkVegaProcess()) {
            // VEGA3000接続の場合、応答電文の値を参照し伝票番号をセットする
            posReceiptNo = int.tryParse(RcCrdt.cRcv.regCreditNumber) ?? 0;
          }
        }
        if (CompileFlag.DEPARTMENT_STORE) {
          if (crdtUser == Datas.NAKAGO_CRDT) {
            mem.tCrdtLog[0].t400000.posReceiptNo =
                (await CompetitionIni.competitionIniGetRcptNo(
                        await RcSysChk.getTid()))
                    .value;
          } else {
            mem.tCrdtLog[0].t400000.posReceiptNo = posReceiptNo;
          }
        } else {
          if ((CompileFlag.IC_CONNECT) &&
              (await CmCksys.cmJremMultiSystem() == 1) &&
              ((cMem.working.crdtReg.icCardType == 2) ||
                  (cMem.working.crdtReg.icCardType == 50) ||
                  (cMem.working.crdtReg.icCardType == 51))) {
            // && ((mem.tCrdtLog[0].t400000.space == 2)
            //     || (mem.tCrdtLog[0].t400000.space == 50)
            //     || (mem.tCrdtLog[0].t400000.space == 51))) {
            //TODO:10111 コンパイルスイッチ(IC_CONNECT)
            // WAON/Suica/iD取引
            //mem.tCrdtLog[0].t400000.posReceiptNo = crdtVoidWork.icc_data.pos_receipt_no;  //RegsMemクラスにicc_dataなし
          } else {
            mem.tCrdtLog[0].t400000.posReceiptNo = posReceiptNo;
          }
        }
        if (pCom.dbTrm.magCardTyp == Mcd.OTHER_CO3) {
          voidMbrPnt = mem.tTtllog.t100701.dtipTtlsrv;
          voidMbrTckt = mem.tTtllog.t100701.dtiqTtlsrv;
        }
        if (await RcSysChk.rcChkVegaProcess()) {
          // VEGA3000接続の場合、カード情報を再セットする
          // ※別カードの場合、クレジットサーバー側でエラーとなるはずだがログ調査用にセットする
          mem.tCrdtLog[0].t400000.mbrCd = RcCrdt.cRcv.memberCode; //カード番号
          mem.tCrdtLog[0].t400000.cardCompCd =
              RcCrdt.cRcv.idMark[0] + RcCrdt.cRcv.cardcompCode; //カード会社コード
          mem.tCrdtLog[0].t400000.goodThru =
              int.tryParse(RcCrdt.cRcv.validTerm) ?? 0;
          mem.tCrdtLog[0].t400000Sts.cardJis1 =
              RcCrdt.cRcvVega.rcvAdd.icMsType[0];
          if (mem.tCrdtLog[0].t400000Sts.cardJis1[0] == '2') {
            //IC取引の場合
            mem.tCrdtLog[0].t400000Sts.cardJis1 += '@';
            mem.tCrdtLog[0].t400000Sts.cardJis1 +=
                RcCrdt.cRcvVega.rcvCom.cassState[0];
            mem.tCrdtLog[0].t400000Sts.cardJis1 += '@';
            mem.tCrdtLog[0].t400000Sts.cardJis1 +=
                RcCrdt.cRcvVega.rcvAdd.comfirmedPin[0]; //PIN入力
            mem.tCrdtLog[0].t400000Sts.cardJis1 += '@';
            mem.tCrdtLog[0].t400000Sts.cardJis1 += RcCrdt.cRcvVega.rcvAdd.aid;
            mem.tCrdtLog[0].t400000Sts.cardJis2 +=
                await RcPanaInq.rcPanaIncRcvdataCnv(RcCrdt
                    .cRcvVega.rcvAdd.brandName); //アプリケーションラベル（SJIS→EUCに変換）
          }
        }
      }
    }

    // クレジット以外の実績データ編集
    await rcCrdtVoidEditTranDateExceptCrdt();
  }

  /// クレジット以外の実績データ編集関数
  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoidEditTranDateExceptCrdt
  static Future<void> rcCrdtVoidEditTranDateExceptCrdt() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    mem.tTtllog.t100600.acr1Sht = 0;
    mem.tTtllog.t100600.acr5Sht = 0;
    mem.tTtllog.t100600.acr10Sht = 0;
    mem.tTtllog.t100600.acr50Sht = 0;
    mem.tTtllog.t100600.acr100Sht = 0;
    mem.tTtllog.t100600.acr500Sht = 0;
    mem.tTtllog.t100600.acb1000Sht = 0;
    mem.tTtllog.t100600.acb2000Sht = 0;
    mem.tTtllog.t100600.acb5000Sht = 0;
    mem.tTtllog.t100600.acb10000Sht = 0;
    mem.tTtllog.t100600.acr1PolSht = 0;
    mem.tTtllog.t100600.acr5PolSht = 0;
    mem.tTtllog.t100600.acr10PolSht = 0;
    mem.tTtllog.t100600.acr50PolSht = 0;
    mem.tTtllog.t100600.acr100PolSht = 0;
    mem.tTtllog.t100600.acr500PolSht = 0;
    mem.tTtllog.t100600.acrOthPolSht = 0;
    mem.tTtllog.t100600.acb1000PolSht = 0;
    mem.tTtllog.t100600.acb2000PolSht = 0;
    mem.tTtllog.t100600.acb5000PolSht = 0;
    mem.tTtllog.t100600.acb10000PolSht = 0;
    mem.tTtllog.t100600.acbFillPolSht = 0;
    mem.tTtllog.t100600.acbRejectCnt = 0;
    mem.tTtllog.t100600.stockDatetime = "";
    mem.tTtllog.calcData.refundLogFlg = 0;
    if (!(await rcCrdtVoidMbrActChk()) &&
        !(CompileFlag.MC_SYSTEM && RcSysChk.rcChkMcSystem())) {
      if (CompileFlag.IC_CONNECT && (await CmCksys.cmJremMultiSystem() == 1)) {
        // if (mem.tCrdtLog[0].t400000.space != 51) {
        if (cMem.working.crdtReg.icCardType != 51) {
          mem.tTtllog.t100700.dpntTtlsrv = 0;
          mem.tTtllog.t100700.tpntTtlsrv = 0;
        }
      } else {
        mem.tTtllog.t100700.dpntTtlsrv = 0;
        mem.tTtllog.t100700.tpntTtlsrv = 0;
      }
      mem.tTtllog.t100700.mbrVcnt = 0;
      mem.tTtllog.t100700.lastTtlpur = 0;
      mem.tTtllog.calcData.dsalTtlpur = 0;
      mem.tTtllog.calcData.dwotTtlpur = 0;
      mem.tTtllog.t100700.dwitTtlpur = 0;
      mem.tTtllog.calcData.nsalTtlpur = 0;
      mem.tTtllog.calcData.nsaqTtlpur = 0;
      mem.tTtllog.t100700.termTtlpur = 0;
      mem.tTtllog.t100700.dcauMspur = 0;
      mem.tTtllog.t100700.dexpMspur = 0;
      mem.tTtllog.calcData.tpptTtlsrv = 0;
      mem.tTtllog.t100700.lpntTtlsrv = 0;
      mem.tTtllog.calcData.lpptTtlsrv = 0;
      mem.tTtllog.calcData.duppTtlrv = 0;
      mem.tTtllog.t100701.duptTtlrv = 0;
      mem.tTtllog.calcData.nextTtlsrv = 0;
      mem.tTtllog.t100701.dtiqTtlsrv = 0;
      mem.tTtllog.t100701.dtipTtlsrv = 0;
      mem.tTtllog.t100702.dtuqTtlsrv = 0;
      mem.tTtllog.t100702.dtupTtlsrv = 0;
      mem.tTtllog.t100700.dcutTtlsrv = 0;
      mem.tTtllog.t100800.dcauFsppur = 0;
      if ((mem.tTtllog.t100701.rebateFlg ==
              TtlBufRebateList.TTLBUF_REBATE_MANU.index) ||
          (mem.tTtllog.t100701.rebateFlg ==
              TtlBufRebateList.TTLBUF_REBATE_AUTO_DSC.index) ||
          (mem.tTtllog.t100701.rebateFlg ==
              TtlBufRebateList.TTLBUF_REBATE_AUTO.index)) {
        mem.tTtllog.t100701.dmpTtlsrv = 0;
        mem.tTtllog.t100701.dmqTtlsrv = 0;
        mem.tTtllog.t100701.rebateFlg =
            TtlBufRebateList.TTLBUF_REBATE_NOT.index;
      }
      if (!CompileFlag.DEPARTMENT_STORE) {
        mem.tTtllog.t100800.dexpFsppur = 0;
        mem.tTtllog.t100800.lcauFsppur = 0;
      }
      mem.tTtllog.t100800.tcauFsppur = 0;
      mem.tTtllog.t101100.dsltAddpnt = 0;
      mem.tTtllog.t101100.dslgAddpnt = 0;
      mem.tTtllog.t101100.dsptAddpnt = 0;
      mem.tTtllog.t101100.dpurAddpnt = 0;
      mem.tTtllog.t101100.dptqAddpnt = 0;
      mem.tTtllog.t101100.dpurAddmul = 0;
      mem.tTtllog.calcData.dctrbPoint = 0;
      mem.tTtllog.calcData.tctrbPoint = 0;
      mem.tTtllog.t100700.endSaleDate = "";
      if (!CompileFlag.DEPARTMENT_STORE) {
        mem.tTtllog.t100900.vmcStkacv = 0;
      }
      mem.tTtllog.t100900.vmcStkhesoacv = 0;
      mem.tTtllog.calcData.mbrDiscAmt = 0;
      mem.tTtllog.t100900Sts.rwTyp = 0;
      mem.tTtllog.t100900.vmcChgtcktCnt = 0;
      mem.tTtllog.t100900.vmcChgAmt = 0;
      mem.tTtllog.t100900.todayChgamt = 0;
      mem.tTtllog.t100900.totalChgamt = 0;
      if (!RcSysChk.rcChkIntaxDscSystem()) {
        mem.tTtllog.t100900.lastChgamt = 0;
        mem.tTtllog.t100900.lastHesoamt = 0;
      }
      mem.tTtllog.t100900.vmcChgCnt = 0;
      mem.tTtllog.t100900.vmcHesotcktCnt = 0;
      mem.tTtllog.t100900.vmcHesoAmt = 0;
      mem.tTtllog.t100900.todayHesoamt = 0;
      mem.tTtllog.t100900.totalHesoamt = 0;
      mem.tTtllog.t100900.vmcHesoCnt = 0;
      mem.tTtllog.calcData.mnyTtl = 0;
      mem.tTtllog.calcData.mnyTodayAmt = 0;
      mem.tTtllog.t100002Sts.purchaseTcktCnt = 0;
      mem.tTtllog.t100002Sts.prizeTcktCnt = 0;
      mem.tTtllog.calcData.mnyTcktAmt1 = 0;
      mem.tTtllog.calcData.mnyTcktAmt2 = 0;
      mem.tTtllog.calcData.mnyTcktAmt3 = 0;
      mem.tTtllog.calcData.stampCustTyp1 = 0;
      mem.tTtllog.calcData.stampPointTyp1 = 0;
      mem.tTtllog.calcData.stampCustTyp2 = 0;
      mem.tTtllog.calcData.stampPointTyp2 = 0;
      mem.tTtllog.calcData.stampCustTyp3 = 0;
      mem.tTtllog.calcData.stampPointTyp3 = 0;
      mem.tTtllog.calcData.stampCustTyp4 = 0;
      mem.tTtllog.calcData.stampPointTyp4 = 0;
      mem.tTtllog.calcData.stampCustTyp5 = 0;
      mem.tTtllog.calcData.stampPointTyp5 = 0;
      mem.tTtllog.t100001Sts.stampCnt = 0;
      mem.tTtllog.calcData.stampShopPnt = 0;
      mem.tTtllog.t100700.divMspur = 0;
      mem.tTtllog.t100700.divPpoint = 0;
      mem.tTtllog.t100701.tcktIssueAmt = 0;
      if (RcSysChk.rcChkCustrealPointartistSystem() == 1) {
        for (int i = 0; i < CntList.promMax; i++) {
          mem.tTtllog.t101000[i].promTicketNo = 0;
        }
      }
      if (await CmCksys.cmIchiyamaMartSystem() == 1) {
        mem.tHeader.cust_no = "";
        mem.tTtllog.t100700.magMbrCd = "";
        mem.tTtllog.t100700.mbrInput = MbrInputType.nonInput.index;
        mem.tTtllog.t100700.mbrNameKanji1 = "";
        mem.tTtllog.t100011.errcd = "";
        mem.tTtllog.t100002.custCd = 0;
      }
      if (RcSysChk.rcsyschkAyahaSystem()) {
        mem.tTtllog.t100700.bonusPnt = 0; // TBD-AYAHA-V1StdCust
      }
    }

    if (CompileFlag.DEPARTMENT_STORE) {
      if (mem.tTtllog.t100900.vmcStkacv == 1) {
        mem.tTtllog.t100002Sts.revenueExclusionflg = 1;
      }
      if (mem.tTtllog.calcData.card1timeAmt != 0) {
        mem.tTtllog.calcData.card1timeAmt += 2000; //=WK_KIND_CNCL
      }
    }
    if (await CmCksys.cmSpDepartmentSystem() == 1) {
      if ((mem.tTtllog.t101000[7].promDscPrc == 2103) ||
          (mem.tTtllog.t101000[7].promDscPrc == 2106) ||
          (mem.tTtllog.t101000[7].promDscPrc == 2201)) {
        String tmp = "${"${pCom.dbOpenClose.sale_date}".substring(5, 7)}"
            "${"${pCom.dbOpenClose.sale_date}".substring(8, 10)}"
            "${"${mem.tHeader.mac_no % 1000}".padLeft(3, "0")}"
            "0${"${mem.tHeader.receipt_no % 10000}".padLeft(4, "0")}";
        mem.tTtllog.t101000[7].promDscCd = int.tryParse(tmp) ?? 0;
      }
      mem.tTtllog.t101000[7].promDscPrc += 1000;
    }
    if (await CmCksys.cmEdySystem() == 1) {
      RckyEVoid.eVoidEdyToCashChg();
    }
    if (await CmCksys.cmYamatoSystem() == 1) {
      await RckyEVoid.eVoidYamatoToCashChg(FuncKey.KY_CRDTVOID);
    }

    // 品券実績を現金扱いにする
    if (RcSysChk.rcCheckCrdtVoidGiftToCash() ||
        RckyRfdopr.rcRfdOprCheckAllRefundMode()) {
      RcAtct.rcConvertGiftToCash();
    }
    if ((RcSysChk.rcChkdPointRead() == 1) &&
        !RckyRfdopr.rcRfdOprCheckRcptVoidMode()) {
      dPointFlg = 1;
      // dポイントカード番号を保存し、dポイント関連情報をクリア
      mem.prnrBuf.dPointCardNo = "${mem.tTtllog.t100770.dpntCd1}"
          "{mem.tTtllog.t100770.dpntCd2}";
      await RcDpoint.rcDPointDataClr(0, mem.tTtllog);
    }
  }

  /// 電子マネー訂正処理
  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_PostPay_EditTranDate
  /// 引数:[opeModeFlg] 操作モード
  static Future<void> rcCrdtVoidPostPayEditTranData(int opeModeFlg) async {
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_CRDTVOID.index;
    mem.tTtllog.t100700Sts.custOfflineFlg = mem.tTtllog.t100700.realCustsrvFlg;
    mbrFlg = 0;
    custAddFlg = 0;
    await RcSetDate.rcSetDate();

    if (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index) {
      mbrFlg = 1;
    }

    mem.tHeader.tran_flg = 0;
    mem.tHeader.ope_mode_flg = opeModeFlg;
    mem.tTtllog.t100001Sts.voidMacNo = mem.tHeader.mac_no;
    mem.tTtllog.t100001Sts.voidReceiptNo = mem.tHeader.receipt_no;
    mem.tTtllog.t100001Sts.voidPrintNo = mem.tHeader.print_no;
    mem.tHeader.mac_no =
        (await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid()))
            .value;
    mem.tHeader.receipt_no =
        (await CompetitionIni.competitionIniGetRcptNo(await RcSysChk.getTid()))
            .value;
    mem.tHeader.print_no =
        (await CompetitionIni.competitionIniGetPrintNo(await RcSysChk.getTid()))
            .value;

    if (CompileFlag.ARCS_MBR) {
      if (!((await CmCksys.cmNttdPrecaSystem() == 1)
          // && (mem.tCrdtLog[0].t400000.space == 53))) {
          &&
          (cMem.working.crdtReg.icCardType == 53))) {
        mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt -=
            mem.tTtllog.t100900.todayChgamt;
      }
    } else {
      mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt -=
          mem.tTtllog.t100900.todayChgamt;
    }

    mem.tTtllog.calcData.mvoidCrdtCnt = 1;
    mem.tTtllog.calcData.mvoidCrdtAmt = await RcCrdtFnc.rcGetCrdtPayAmount();
    mem.tTtllog.calcData.mtriningCrdtAmt =
        -mem.tTtllog.calcData.mtriningCrdtAmt;

    if (RcSysChk.rcChkTtlMulPDscSystem()) {
      mem.prnrBuf.iTmpDscDiffAmt = 0;
    }

    for (int i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if (!(await rcCrdtVoidMbrActChk())) {
        mem.tItemLog[i].t11100.rbtPurAmt = 0;
        if (await RcSysChk.rcChkSapporoRealSystem()) {
          mem.tItemLog[i].t10000Sts.exchgIssueObjFlg = 0;
        }
        mem.tItemLog[i].t11100.mulRbtPurAmt = 0;
        mem.tItemLog[i].t11100.divPpoint = 0;
        mem.tItemLog[i].t50200?.rbtInputAmt = 0;
      }
      if (RcSysChk.rcChkTtlMulPDscSystem()) {
        mem.prnrBuf.iTmpDscDiffAmt +=
            (mem.tItemLog[i].t10300.exchgPnt + mem.tItemLog[i].t10300.exchgQty);
      }
    }

    if (await CmCksys.cmNttaspSystem() == 1) {
      mem.tCrdtLog[0].t400000.tranCd = 1;
    } else {
      mem.tCrdtLog[0].t400000.tranCd = 4;
    }

    // クレジット訂正時は必ずサインを頂くので、サインレスのフラグをリセット
    // if ((mem.tCrdtLog[0].t400000Sts.ttlLvl & 0x01) == 1) {
    if ((ttlLvl & 0x01) == 1) {
      // mem.tCrdtLog[0].t400000Sts.ttlLvl &= ~0x01;
      mem.tCrdtLog[0].t400000Sts.ttlLvl = ttlLvl & ~0x01;
    }

    if (await CmCksys.cmCapsPqvicSystem() == 1) {
      mem.tCrdtLog[0].t400000.cnclSlipNo =
          mem.tHeader.receipt_no.toString().padLeft(5, "0");
    } else {
      mem.tCrdtLog[0].t400000.cnclSlipNo =
          posReceiptNoByCDataLog.toString().padLeft(5, "0");
      // = mem.tCrdtLog[0].t400000.posReceiptNo.toString().padLeft(5, "0");
    }

    if ((await RcSysChk.rcChkMultiQPSystem() > 0) ||
        (await RcSysChk.rcChkMultiiDSystem() > 0) ||
        (await RcSysChk.rcChkMultiPiTaPaSystem() > 0)) {
      RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRetStat.isInvalid()) {
        return;
      }
      RxTaskStatBuf tsBuf = xRetStat.object;
      // switch (mem.tCrdtLog[0].t400000.space) {
      switch (cMem.working.crdtReg.icCardType) {
        case 2: //iD
          if (tsBuf.multi.fclData.rcvData.slipNo != 0) {
            mem.tCrdtLog[0].t400000.posReceiptNo =
                tsBuf.multi.fclData.rcvData.slipNo;
          } else {
            mem.tCrdtLog[0].t400000.posReceiptNo = 0;
          }
          if (tsBuf.multi.fclData.rcvData.icNo != 0) {
            mem.tCrdtLog[0].t400000Sts.seqInqNo =
                tsBuf.multi.fclData.rcvData.icNo.toString();
          } else {
            mem.tCrdtLog[0].t400000Sts.seqInqNo = CmAry.setStringZero(21);
          }
          if (tsBuf.multi.fclData.rcvData.recognNo != 0) {
            mem.tCrdtLog[0].t400000.recognNo =
                tsBuf.multi.fclData.rcvData.recognNo.toString();
          }
          break;
        case 3: //QUICPay
          if (tsBuf.multi.fclData.rcvData.slipNo != 0) {
            mem.tCrdtLog[0].t400000.posReceiptNo =
                tsBuf.multi.fclData.rcvData.slipNo;
          } else {
            mem.tCrdtLog[0].t400000.posReceiptNo = 0;
          }
          if (tsBuf.multi.fclData.rcvData.icNo != 0) {
            mem.tCrdtLog[0].t400000Sts.seqInqNo =
                tsBuf.multi.fclData.rcvData.icNo.toString();
          } else {
            mem.tCrdtLog[0].t400000Sts.seqInqNo = CmAry.setStringZero(21);
          }
          break;
        case 6: //PiTaPa
          if (tsBuf.multi.fclData.rcvData.slipNo != 0) {
            mem.tCrdtLog[0].t400000.posReceiptNo =
                tsBuf.multi.fclData.rcvData.slipNo;
          } else {
            mem.tCrdtLog[0].t400000.posReceiptNo = 0;
          }
          if (tsBuf.multi.fclData.rcvData.icNo != 0) {
            mem.tCrdtLog[0].t400000Sts.seqInqNo =
                tsBuf.multi.fclData.rcvData.icNo.toString();
          } else {
            mem.tCrdtLog[0].t400000Sts.seqInqNo = CmAry.setStringZero(21);
          }
          mem.tCrdtLog[0].t400000.posRecognNo =
              tsBuf.multi.fclData.rcvData.rwId;
          mem.tCrdtLog[0].t400000.recognNo =
              tsBuf.multi.fclData.rcvData.recognNo.toString();
          mem.tCrdtLog[0].t400000Sts.bonusMonthSign =
              int.parse(tsBuf.multi.fclData.rcvData.signRes);
          mem.tCrdtLog[0].t400000Sts.seqPosNo =
              tsBuf.multi.fclData.sndData.printNo.toString();
          mem.tCrdtLog[0].t400000Sts.cardJis1 =
              tsBuf.multi.fclData.rcvData.dateTime;
          mem.tTtllog.t100010.invoiceNo = tsBuf.multi.fclData.rcvData.cardId;
          break;
        default:
          break;
      }
    }
    mem.tTtllog.t100600.acr1Sht = 0;
    mem.tTtllog.t100600.acr5Sht = 0;
    mem.tTtllog.t100600.acr10Sht = 0;
    mem.tTtllog.t100600.acr50Sht = 0;
    mem.tTtllog.t100600.acr100Sht = 0;
    mem.tTtllog.t100600.acr500Sht = 0;
    mem.tTtllog.t100600.acb1000Sht = 0;
    mem.tTtllog.t100600.acb2000Sht = 0;
    mem.tTtllog.t100600.acb5000Sht = 0;
    mem.tTtllog.t100600.acb10000Sht = 0;
    mem.tTtllog.t100600.acr1PolSht = 0;
    mem.tTtllog.t100600.acr5PolSht = 0;
    mem.tTtllog.t100600.acr10PolSht = 0;
    mem.tTtllog.t100600.acr50PolSht = 0;
    mem.tTtllog.t100600.acr100PolSht = 0;
    mem.tTtllog.t100600.acr500PolSht = 0;
    mem.tTtllog.t100600.acrOthPolSht = 0;
    mem.tTtllog.t100600.acb1000PolSht = 0;
    mem.tTtllog.t100600.acb2000PolSht = 0;
    mem.tTtllog.t100600.acb5000PolSht = 0;
    mem.tTtllog.t100600.acb10000PolSht = 0;
    mem.tTtllog.t100600.acbFillPolSht = 0;
    mem.tTtllog.t100600.acbRejectCnt = 0;
    mem.tTtllog.t100600.stockDatetime = "";
    mem.tTtllog.calcData.refundLogFlg = 0;

    if (!(await rcCrdtVoidMbrActChk())) {
      mem.tTtllog.t100700.dpntTtlsrv = 0;
      mem.tTtllog.t100700.tpntTtlsrv = 0;
      mem.tTtllog.t100700.mbrVcnt = 0;
      mem.tTtllog.t100700.lastTtlpur = 0;
      mem.tTtllog.calcData.dsalTtlpur = 0;
      mem.tTtllog.calcData.dwotTtlpur = 0;
      mem.tTtllog.t100700.dwitTtlpur = 0;
      mem.tTtllog.calcData.nsalTtlpur = 0;
      mem.tTtllog.calcData.nsaqTtlpur = 0;
      mem.tTtllog.t100700.termTtlpur = 0;
      mem.tTtllog.t100700.dcauMspur = 0;
      mem.tTtllog.t100700.dexpMspur = 0;
      mem.tTtllog.calcData.tpptTtlsrv = 0;
      mem.tTtllog.t100700.lpntTtlsrv = 0;
      mem.tTtllog.calcData.lpptTtlsrv = 0;
      mem.tTtllog.calcData.duppTtlrv = 0;
      mem.tTtllog.t100701.duptTtlrv = 0;
      mem.tTtllog.calcData.nextTtlsrv = 0;
      mem.tTtllog.t100701.dtiqTtlsrv = 0;
      mem.tTtllog.t100701.dtipTtlsrv = 0;
      mem.tTtllog.t100702.dtuqTtlsrv = 0;
      mem.tTtllog.t100702.dtupTtlsrv = 0;
      mem.tTtllog.t100700.dcutTtlsrv = 0;
      if ((mem.tTtllog.t100701.rebateFlg ==
              TtlBufRebateList.TTLBUF_REBATE_MANU.index) ||
          (mem.tTtllog.t100701.rebateFlg ==
              TtlBufRebateList.TTLBUF_REBATE_AUTO_DSC.index) ||
          (mem.tTtllog.t100701.rebateFlg ==
              TtlBufRebateList.TTLBUF_REBATE_AUTO.index)) {
        mem.tTtllog.t100701.dmpTtlsrv = 0;
        mem.tTtllog.t100701.dmqTtlsrv = 0;
        mem.tTtllog.t100701.rebateFlg =
            TtlBufRebateList.TTLBUF_REBATE_NOT.index;
      }
      mem.tTtllog.t100800.dcauFsppur = 0;
      mem.tTtllog.t100800.dexpFsppur = 0;
      mem.tTtllog.t100800.lcauFsppur = 0;
      mem.tTtllog.t100800.tcauFsppur = 0;
      mem.tTtllog.t101100.dsltAddpnt = 0;
      mem.tTtllog.t101100.dslgAddpnt = 0;
      mem.tTtllog.t101100.dsptAddpnt = 0;
      mem.tTtllog.t101100.dpurAddpnt = 0;
      mem.tTtllog.t101100.dptqAddpnt = 0;
      mem.tTtllog.t101100.dpurAddmul = 0;
      mem.tTtllog.calcData.dctrbPoint = 0;
      mem.tTtllog.calcData.tctrbPoint = 0;
      mem.tTtllog.t100700.endSaleDate = "";
      mem.tTtllog.t100900.vmcStkacv = 0;
      mem.tTtllog.t100900.vmcStkhesoacv = 0;
      mem.tTtllog.calcData.mbrDiscAmt = 0;
      mem.tTtllog.t100900Sts.rwTyp = 0;
      mem.tTtllog.t100900.vmcChgtcktCnt = 0;
      mem.tTtllog.t100900.vmcChgAmt = 0;
      mem.tTtllog.t100900.todayChgamt = 0;
      mem.tTtllog.t100900.totalChgamt = 0;
      mem.tTtllog.t100900.lastChgamt = 0;
      mem.tTtllog.t100900.vmcChgCnt = 0;
      mem.tTtllog.t100900.vmcHesotcktCnt = 0;
      mem.tTtllog.t100900.vmcHesoAmt = 0;
      mem.tTtllog.t100900.todayHesoamt = 0;
      mem.tTtllog.t100900.totalHesoamt = 0;
      mem.tTtllog.t100900.lastHesoamt = 0;
      mem.tTtllog.t100900.vmcHesoCnt = 0;
      mem.tTtllog.calcData.mnyTtl = 0;
      mem.tTtllog.calcData.mnyTodayAmt = 0;
      mem.tTtllog.t100002Sts.purchaseTcktCnt = 0;
      mem.tTtllog.t100002Sts.prizeTcktCnt = 0;
      mem.tTtllog.calcData.mnyTcktAmt1 = 0;
      mem.tTtllog.calcData.mnyTcktAmt2 = 0;
      mem.tTtllog.calcData.mnyTcktAmt3 = 0;
      mem.tTtllog.calcData.stampCustTyp1 = 0;
      mem.tTtllog.calcData.stampPointTyp1 = 0;
      mem.tTtllog.calcData.stampCustTyp2 = 0;
      mem.tTtllog.calcData.stampPointTyp2 = 0;
      mem.tTtllog.calcData.stampCustTyp3 = 0;
      mem.tTtllog.calcData.stampPointTyp3 = 0;
      mem.tTtllog.calcData.stampCustTyp4 = 0;
      mem.tTtllog.calcData.stampPointTyp4 = 0;
      mem.tTtllog.calcData.stampCustTyp5 = 0;
      mem.tTtllog.calcData.stampPointTyp5 = 0;
      mem.tTtllog.t100001Sts.stampCnt = 0;
      mem.tTtllog.calcData.stampShopPnt = 0;
      mem.tTtllog.t100700.divMspur = 0;
      mem.tTtllog.t100700.divPpoint = 0;
      mem.tTtllog.t100701.tcktIssueAmt = 0;
      if (RcSysChk.rcChkCustrealPointartistSystem() == 1) {
        for (int i = 0; i < CntList.promMax; i++) {
          mem.tTtllog.t101000[i].promTicketNo = 0;
        }
      }
      if (await CmCksys.cmIchiyamaMartSystem() == 1) {
        mem.tHeader.cust_no = "";
        mem.tTtllog.t100700.magMbrCd = "";
        mem.tTtllog.t100700.mbrInput = MbrInputType.nonInput.index;
        mem.tTtllog.t100700.mbrNameKanji1 = "";
        mem.tTtllog.t100011.errcd = "";
        mem.tTtllog.t100002.custCd = 0;
      }
      if (RcSysChk.rcsyschkAyahaSystem()) {
        mem.tTtllog.t100700.bonusPnt = 0; // TBD-AYAHA-V1StdCust
      }
    }

    if (await CmCksys.cmSpDepartmentSystem() == 1) {
      if ((mem.tTtllog.t101000[7].promDscPrc == 2103) ||
          (mem.tTtllog.t101000[7].promDscPrc == 2106) ||
          (mem.tTtllog.t101000[7].promDscPrc == 2201)) {
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if (xRet.isInvalid()) {
          return;
        }
        RxCommonBuf pCom = xRet.object;
        String buf = "${pCom.dbOpenClose.sale_date!.substring(5, 7)}"
            "${pCom.dbOpenClose.sale_date!.substring(8, 10)}"
            "${"${mem.tHeader.mac_no % 1000}".padLeft(3, "0")}0"
            "${"${mem.tHeader.receipt_no % 10000}".padLeft(4, "0")}";
        mem.tTtllog.t101000[7].promDscCd = int.parse(buf);
      }
      mem.tTtllog.t101000[7].promDscPrc += 1000;
    }

    if ((await CmCksys.cmEdySystem() == 1) ||
        (await CmCksys.cmFclEdySystem() == 1)) {
      RckyEVoid.eVoidEdyToCashChg();
    }
    if (await CmCksys.cmYamatoSystem() == 1) {
      RckyEVoid.eVoidYamatoToCashChg(FuncKey.KY_CRDTVOID);
    }

    // 品券実績を現金扱いにする
    if (RcSysChk.rcCheckCrdtVoidGiftToCash() ||
        RckyRfdopr.rcRfdOprCheckAllRefundMode()) {
      RcAtct.rcConvertGiftToCash();
    }
  }

  /// クレジット訂正電文送信開始処理
  /// 引数:[fncCode] 呼出元キーコード
  /// 戻値:実行結果（ほとんどは意味を持たない）
  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoidInquStart
  static Future<int> rcCrdtVoidInquStart(int fncCode) async {
    int errNo = OK;
    int multiCnctTyp = RcRegs.rcInfoMem.rcCnct.cnctMultiCnct!;
    AcMem cMem = SystemFunc.readAcMem();

    if (CompileFlag.MC_SYSTEM && RcSysChk.rcChkMcSystem()) {
      // TODO:10125 通番訂正 202404実装対象外
      /*
       crdtVoidActFlg = true;
       RcPanaVic.rcPana_VoidInq_Proc();
        */
    } else {
      RegsMem mem = SystemFunc.readRegsMem();
      if (CompileFlag.ARCS_MBR) {
        // プリカ
        if ((await RcSysChk.rcChkNTTDPrecaSystem()) &&
            (cMem.working.crdtReg.icCardType == 53)) {
          // && (mem.tCrdtLog[0].t400000.space == 53)) {
          // TODO:10125 通番訂正 202404実装対象外
          /*
          mem.tmpbuf.workInType = 1;
          if (RcPreca.rcPrecaVoid()) {
            crdtVoidActFlg = true;
          }
          return errNo;
           */
        }
      }
      if (cMem.working.crdtReg.icCardType != 0) {  //キャッシュ以外
        errNo = await rcCrdtVoidSetWorkingData();
      }

      // TODO:00002 佐野 通番訂正Debug ログ追加
      debugPrint(
          "********** RcSysChk.rcChkMultiQPSystem():${await RcSysChk.rcChkMultiQPSystem()}");
      debugPrint(
          "********** RcSysChk.rcChkMultiiDSystem():${await RcSysChk.rcChkMultiiDSystem()}");
      debugPrint(
          "********** cMem.working.crdtReg.icCardType:${cMem.working.crdtReg.icCardType}");
      debugPrint("********** multiCnctTyp:$multiCnctTyp");
      AtSingl atSing = SystemFunc.readAtSingl();
      debugPrint(
          "********** RcKyCrdtVoid.crdtVoid.recNo:${RcKyCrdtVoid.crdtVoid.recNo}");
      debugPrint(
          "********** RcKyCrdtVoid.crdtVoid.slipNo:${RcKyCrdtVoid.crdtVoid.slipNo}");
      debugPrint("********** atSing.spvtData.icNo:${atSing.spvtData.icNo}");
      debugPrint("********** atSing.spvtData.slipNo:${atSing.spvtData.slipNo}");

      if (CompileFlag.DEPARTMENT_STORE) {
        // TODO:10125 通番訂正 202404実装対象外
        /*
        if (RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT) {
          if (cMem.working.crdtReg.stat & 0x1000 != 0) {
            mem.tCrdtLog[0].t400000Sts.sign = 1;
          }
          if ((cMem.working.crdtReg.multiFlg.codeUnitAt(0) & 0x08 != 0)
              || (cMem.working.crdtReg.multiFlg.codeUnitAt(0) & 0x40 != 0)
              || (mem.tCrdtLog[0].t400000Sts.sign == 1)) {
            cMem.working.crdtReg.multiFlg =
                String.fromCharCode(cMem.working.crdtReg.multiFlg.codeUnitAt(0) & ~0x40);
            RcCardCrew.rcCardCrewNotInqPrg();
            await crdtVoidClear();
            await RcIfEvent.rxChkTimerAdd();
            await rcCrdtVoidExecFunc();
            crdtVoidActFlg = true;
          } else {
            errNo = RcCrdtFnc.rcCrdtInquProg();
            if (errNo != 0) {
              rcCrdtVoidDialogClear();
            } else {
              crdtVoidActFlg = true;
            }
          }
        } else {
          errNo = RcCrdtFnc.rcCrdtInquProg();
          if (errNo != 0) {
            rcCrdtVoidDialogClear();
          } else {
            crdtVoidActFlg = true;
          }
        }
         */
      } else {
        if (await CmCksys.cmTuoSystem() != 0) {
          cMem.working.crdtReg.multiFlg = String.fromCharCode(
              cMem.working.crdtReg.multiFlg.codeUnitAt(0) & ~0x40);
          await crdtVoidClear();
          await RcIfEvent.rxChkTimerAdd();
          await rcCrdtVoidExecFunc();
          crdtVoidActFlg = true;
        } else if (CompileFlag.IC_CONNECT &&
            ((await CmCksys.cmJremMultiSystem() != 0) &&
                ((cMem.working.crdtReg.icCardType == 2) ||
                    (cMem.working.crdtReg.icCardType == 50) ||
                    (cMem.working.crdtReg.icCardType == 51)))) {
          // TODO:10125 通番訂正 202404実装対象外
          /*
          // WAON/Suica/iD取引
          crdtVoidActFlg = true;
          // WAON:現金チャージ/現金チャージ取消
          if ((mem.tCrdtLog[0].t400000Sts.chaCnt4 == 4)
              || (mem.tCrdtLog[0].t400000Sts.chaCnt4 == 5)) {
            cMem.stat.fncCode = FuncKey.KY_BRND_CIN.keyId;
          } else {
            cMem.stat.fncCode = FuncKey.KY_BRND_CHA.keyId;
          }
          RckyIc.rcICCCrdtVoid();
           */
        } else if ((await RcSysChk.rcChkSPVTSystem()) &&
            (cMem.working.crdtReg.icCardType == 5)) {
          // TODO:10125 通番訂正 202404実装対象外
          /*
          switch (multiCnctTyp) {
            case 1:  // FCL
              errNo = RcFclCom.rcChkFclStat();
              break;
            default:
              break;
          }
          if (errNo == OK) {
            crdtVoidActFlg = true;
            AtSingl atSing = SystemFunc.readAtSingl();
            atSing.spvtData.fncCode = FuncKey.KY_CRDTVOID.keyId;
            RcSpvtCom.rcSPVTMainProc();
          }
           */
        } else if ((await RcSysChk.rcChkMultiQPSystem() != 0) &&
            (cMem.working.crdtReg.icCardType == 3)) {    //QUICPay
          switch (multiCnctTyp) {
            case 2: // FAP
              errNo = RcFclCom.rcChkFclStat();
              break;
            case 3: // UT
            case 6: // VEGA
              errNo = RckyRfdopr.rcChkUtStat(MultiUseBrand.QP_OPERATION.index);
              if ((errNo == DlgConfirmMsgKind.MSG_TID_NOGOOD1.dlgId) ||
                  (errNo == DlgConfirmMsgKind.MSG_TID_NOGOOD2.dlgId)) {
                ut1Msg = await RcEwdsp.rcMakeUt1Msg(errNo);
                errNo = DlgConfirmMsgKind.MSG_TID_NOGOOD1.dlgId;
              }
              break;
            default:
              break;
          }
          if (errNo == OK) {
            crdtVoidActFlg = true;
            if (await CmCksys.cmYunaitoHdSystem() != 0) {
              await RcQuicPayCom.rcMultiQPMainProc(fncCode);
            } else {
              debugPrint("********** RcQuicPayCom.rcMultiQPMainProc() Start");
              await RcQuicPayCom.rcMultiQPMainProc(FuncKey.KY_CRDTVOID.keyId);
            }
          }
        } else if ((await RcSysChk.rcChkMultiiDSystem() != 0) &&
            (cMem.working.crdtReg.icCardType == 2)) {    //iD
          switch (multiCnctTyp) {
            case 2: // FAP
              errNo = RcFclCom.rcChkFclStat();
              break;
            case 3: // UT
            case 6: // VEGA
              errNo = RckyRfdopr.rcChkUtStat(MultiUseBrand.ID_OPERATION.index);
              if ((errNo == DlgConfirmMsgKind.MSG_TID_NOGOOD1.dlgId) ||
                  (errNo == DlgConfirmMsgKind.MSG_TID_NOGOOD2.dlgId)) {
                ut1Msg = await RcEwdsp.rcMakeUt1Msg(errNo);
                errNo = DlgConfirmMsgKind.MSG_TID_NOGOOD1.dlgId;
              }
              break;
            default:
              break;
          }
          if (errNo == OK) {
            crdtVoidActFlg = true;
            if (await CmCksys.cmYunaitoHdSystem() != 0) {
              await RcidCom.rcMultiiDMainProc(fncCode);
            } else {
              debugPrint("********** RcidCom.rcMultiiDMainProc() Start");
              await RcidCom.rcMultiiDMainProc(FuncKey.KY_CRDTVOID.keyId);
            }
          }
        } else if ((await RcSysChk.rcChkMultiPiTaPaSystem() != 0) &&
            (cMem.working.crdtReg.icCardType == 6)) {
          // TODO:10125 通番訂正 202404実装対象外
          /*
          switch (multiCnctTyp) {
            case 4:  // PFM
              errNo = RcPfmCom.rcChkPfmStat(MultiUseBrand.PITAPA_OPERATION.index);
              break;
            default:
              break;
          }
          if (errNo == OK) {
            crdtVoidActFlg = true;
            RcPitapaCom.rcMultiPiTaPa_MainProc(fncCode);
          }
           */
        } else if (RcSysChk.rcChkWSSystem() && RcSysChk.rcChkJETBProcess()) {
          // TODO:10125 通番訂正 202404実装対象外
          /*
          crdtVoidActFlg = true;
          RcGcat.rcGCatProc();
           */
        } else if (cMem.working.crdtReg.icCardType == 52) {    //ハウスクレジット
          // TODO:00002 佐野 - ハウスクレジット決済時の支払処理を行う関数を呼び出す
        } else if (cMem.working.crdtReg.icCardType != 0) {    //VEGA
          // TODO:00002 佐野 - VEGA決済時の支払処理を行う関数を呼び出す
        } else {  //キャッシュ
          if (errNo == 0) {
            crdtVoidActFlg = true;
            mem.tTtllog.t100001Sts.itemlogCnt = 1;
            bool retBol = await RckyCashVoid.rcKeyVoidDemo();
            crdtVoidActFlg = false;
            if (retBol) {
              // 通番訂正・完了画面に遷移.
              ReceiptInputController con = Get.find();
              con.navigateToReceiptCompletePage();
            } else {
              await rcCrdtVoidDialogClear();
            }
          }
          /*
          errNo = RcCrdtFnc.rcCrdtInquProg(); /* 与信問い合わせ */
          if (errNo > 0) {
            await rcCrdtVoidDialogClear();
          } else {
            crdtVoidActFlg = true;
          }
           */
        }
      }
    }

    if (fncCode != FuncKey.KY_CRDTVOID.keyId) {
      crdtVoidActFlg = false;
    }

    return errNo;
  }

  /// クレジットN0.と伝票番号のチェック
  /// 戻り値はエラーメッセージ番号、伝票番号
  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoidCrdtNoCheck
  static Future<(int, int)> rcCrdtVoidCrdtNoCheck(
      int posReceiptNo, int? crdtNo, int crdtNoSize, int slipNo) async {
    int tranType = 0;
    String mbrCd = '';
    int authoriFlg = 0;
    String mbrcdBuf = '';
    CrdtMAanal cardTmp;
    int cardcrewBuf = 0;
    String hcardNo = '';
    AcMem cMem = SystemFunc.readAcMem();

    // tranType = RegsMem().tCrdtLog[0].t400000.space;
    tranType = cMem.working.crdtReg.icCardType;
    if ((await CmCksys.cmNttaspSystem() != 0) &&
        (RcSysChk.rcChkRalseCardSystem())) {
      if (tranType == 52) {
        /* ハウスカード */
        // mbrCd = RegsMem().tCrdtLog[0].t400000.streJoinNo;
        mbrCd = streJoinNoByCDataLog;
      } else {
        // mbrCd = RegsMem().tCrdtLog[0].t400000.mbrCd;
        mbrCd = mbrCdByCDataLog;
      }
    } else {
      // mbrCd = RegsMem().tCrdtLog[0].t400000.mbrCd;
      mbrCd = mbrCdByCDataLog;
    }

    // posReceiptNo = RegsMem().tCrdtLog[0].t400000.posReceiptNo;
    posReceiptNo = posReceiptNoByCDataLog;
    if (await RcSysChk.rcChkSPVTSystem()) {
      // authoriFlg = RegsMem().tCrdtLog[0].t400000Sts.bonusMonthSign;
      authoriFlg = bonusMonthSignByCStatusLog;
      if (authoriFlg != 1) {
        cMem.working.crdtReg.spvtAuthori = 99;
      }
    }

    if ((RcRegs.rcInfoMem.rcRecog.recogRepicaSystem != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogCogcaSystem != 0)) {
      if (tranType == 53) {
        return (DlgConfirmMsgKind.MSG_PREPAID_INVALID.dlgId, posReceiptNo);
      }
    }

    if (RcRegs.rcInfoMem.rcRecog.recogValuecardSystem != 0) {
      if (tranType == 55) {
        return (DlgConfirmMsgKind.MSG_PREPAID_INVALID.dlgId, posReceiptNo);
      }
    }

    if (RcRegs.rcInfoMem.rcRecog.recogAjsEmoneySystem != 0) {
      if (tranType == 56) {
        return (DlgConfirmMsgKind.MSG_PREPAID_INVALID.dlgId, posReceiptNo);
      }
    }

    if (await CmCksys.cmBarcodePaysystem() != 0) {
      if (await RcBarcodePay.rcChkBarcodePayActualTranType(tranType) != 0) {
        return (DlgConfirmMsgKind.MSG_PREPAID_INVALID.dlgId, posReceiptNo);
      }
    }

    // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE) 常にfalseであるため、コメントアウト
    // if(DEPARTMENT_STORE) {
    //   if (!rcCrdtVoid_Chk_Easy()){
    // }

    if (crdtNo == null) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "CardNo is not enter");
      return (DlgConfirmMsgKind.MSG_CRDTNO_NOTAGREE.dlgId, posReceiptNo);
    }

    if (await CmCksys.cmTuoSystem() == 0) {
      if ((await CmCksys.cmNttaspSystem() == 0) &&
          (await CmCksys.cmMcSystem() == 0)) {
        // TODO:10111 コンパイルスイッチ(IC_CONNECT) 常にfalseであるため、コメントアウト
        //#if IC_CONNECT
        /* WAON/Suica/iD取引の場合、カード番号はチェックしない */
        // if( (tran_type == 2)
        // || (tran_type == 50)
        // || (tran_type == 51) )
        // {
        // /* 伝票番号の参照フィールドが異なるので再セット */
        // *pos_receipt_no = atol(MEM->tCrdtlog[0].t400000Sts.seq_inq_no);
        // }
        // else
        //#endif

        /* P-QVIC仕様のとき、カード番号のチェックが不可能なため、JIS1,JIS2データを比較する */
        if (await CmCksys.cmCapsPqvicSystem() != 0) {
          if (mbrCd.isNotEmpty) {
            mbrcdBuf = mbrCd;
            int index = mbrcdBuf.indexOf(' ');
            mbrcdBuf = mbrcdBuf.substring(0, index);
          }

          if (cMem.working.crdtReg.jis2 != null) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "JIS2 is entered.");
            cardTmp = cMem.working.crdtReg.jis2!;
            if (!cardTmp.mbrNo.contains(mbrcdBuf)) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "JIS2 dose not agree with DB.");
              return (
                DlgConfirmMsgKind.MSG_CRDTNO_NOTAGREE.dlgId,
                posReceiptNo
              );
            }
          } else if (cMem.working.crdtReg.jis1 != null) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "JIS1 is entered.");
            cardTmp = cMem.working.crdtReg.jis1!;
            if (!cardTmp.mbrNo.contains(mbrcdBuf)) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "JIS1 dose not agree with DB.");
              return (
                DlgConfirmMsgKind.MSG_CRDTNO_NOTAGREE.dlgId,
                posReceiptNo
              );
            }
          }
        } else if ((await RcSysChk.rcChkVegaProcess()) && (tranType == 1)) {
          /* VEGA3000接続でクレジット取引の場合、カード番号チェックはできない */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcCrdtVoidCrdtNoCheck() : CrdtNo. NoCheck!");
        } else if ((tranType != 2) &&
            (tranType != 3) &&
            (tranType != 5) &&
            (tranType != 6)) {
          /* Smartplus/Visa Touch , QUICPay , iD , PiTaPa取引の場合、カード番号はチェックしない */
          cardcrewBuf = crdtNo;
          if (Liblary.cmUcmp(
                  cardcrewBuf.toString().codeUnits, mbrCd.codeUnits) !=
              CmBcd.EQ) {
            return (DlgConfirmMsgKind.MSG_CRDTNO_NOTAGREE.dlgId, posReceiptNo);
          }
        }
      }
    } else {
      if (cMem.working.crdtReg.cardDiv == '') {
        if ((await CmCksys.cmNttaspSystem() != 0) &&
            (RcSysChk.rcChkRalseCardSystem())) {
          /* ハウスカード */
          if (tranType == 52) {
            hcardNo = mbrCd;
            if (Liblary.cmUcmp(
                    crdtNo.toString().codeUnits, hcardNo.codeUnits) !=
                CmBcd.EQ) {
              return (
                DlgConfirmMsgKind.MSG_CRDTNO_NOTAGREE.dlgId,
                posReceiptNo
              );
            }
          } else {
            /* QUICPay , iD , PiTaPa取引の場合、カード番号はチェックしない */
            if ((tranType != 2) && (tranType != 3) && (tranType != 6)) {
              if (Liblary.cmUcmp(
                      crdtNo.toString().codeUnits, mbrCd.codeUnits) !=
                  CmBcd.EQ) {
                return (
                  DlgConfirmMsgKind.MSG_CRDTNO_NOTAGREE.dlgId,
                  posReceiptNo
                );
              }
            }
          }
        } else {
          /* QUICPay , iD , PiTaPa取引の場合、カード番号はチェックしない */
          if ((tranType != 2) && (tranType != 3) && (tranType != 6)) {
            if (Liblary.cmUcmp(crdtNo.toString().codeUnits, mbrCd.codeUnits) !=
                CmBcd.EQ) {
              return (
                DlgConfirmMsgKind.MSG_CRDTNO_NOTAGREE.dlgId,
                posReceiptNo
              );
            }
          }
        }
      }
    }

    if (await CmCksys.cmCapsPqvicSystem() == 0) {
      if (slipNo != posReceiptNo) {
        return (DlgConfirmMsgKind.MSG_SLIPNO_NOTAGREE.dlgId, posReceiptNo);
      }
    }
    return (Typ.OK, posReceiptNo);
  }

  /// SQL文をサーバーに送信し、結果を返す
  /// 引数:[tsSql] TSサーバー向けSQL文
  /// 引数:[localSql] ローカル向けSQL文
  /// 戻値: 送信結果（null=データなし  null以外=データあり）
  /// 関連tprxソース: rckycrdtvoid.c - CrdtVoid_db_PQexec
  static Future<Result?> crdtVoidDbPQexec(String tsSql, String localSql) async {
    Result localRes;
    DbManipulationPs db = DbManipulationPs();

    try {
      if (!openType) {
        localRes = await db.dbCon.execute(localSql);
      } else {
        if (RegsDef.chkrTsCon == null) {
          localRes = await db.dbCon.execute(localSql); // offline
        } else {
          localRes = await db.dbCon.execute(tsSql);
        }
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      debugPrint('crdtVoidDbPQexec:!openType判定箇所にてエラーNo.8');
      await rcCrdtVoidDialogErr(DlgConfirmMsgKind.MSG_READERR.dlgId, 1, '');
      return null;
    }
    return localRes;
  }

  ///
  /// 引数:[cBuf] 共有クラス"RxCommonBuf"
  /// 戻値: 送信結果（null=データなし  null以外=データあり）
  /// 関連tprxソース: rckycrdtvoid.c - DB_Open2
  static Future<int> dbOpen2(RxCommonBuf cBuf) async {
    Result? localRes;
    DbManipulationPs db = DbManipulationPs();
    int aid = await RcSysChk.getTid();
    int orgMacNo = 0;
    String sql = "";
    int setOwnerFlg = 0;

    openType = true;
    if (CmCksys.cmMmType() != CmSys.MacERR) {
      orgMacNo = crdtVoid.macNo;
      sql = "select org_mac_no from regopt_mst where mac_no='$orgMacNo';";
      localRes = await db.dbCon.execute(sql);
      if (localRes.isNotEmpty) {
        if (localRes.affectedRows == 1) {
          Map<String, dynamic> data = localRes.first.toColumnMap();
          if (data["org_mac_no"] != null) {
            TprLog().logAdd(aid, LogLevelDefine.normal,
                "regopt_mst exist[${data["org_mac_no"]}]");
          }
        }
      }
      sql =
          "select set_owner_flg from c_regctrl_mst where stre_cd='${cBuf.dbRegCtrl.streCd}' and mac_no='$orgMacNo';";
      localRes = await db.dbCon.execute(sql);
      if (localRes.affectedRows == 1) {
        Map<String, dynamic> data = localRes.first.toColumnMap();
        setOwnerFlg = int.parse(data["set_owner_flg"]) ?? 0;
        if (cBuf.dbRegCtrl.setOwnerFlg != setOwnerFlg) {
          TprLog().logAdd(aid, LogLevelDefine.normal, "Segment Login");
          sql =
              "select a.ip_addr from macaddr_mst a, c_regctrl_mst b where a.mac_no=b.mac_no and b.set_owner_flg = '$setOwnerFlg' and (a.mac_typ = '100' or a.mac_typ = '103');";
          localRes = await db.dbCon.execute(sql);
          if (localRes.affectedRows == 1) {
            // TODO:00002 佐野 - db_WebLogin()の対応が必要
            //RegsDef.chkrTsCon = db_WebLogin(aid, DB_ERRLOG, db_PQgetvalue(aid, local_res, 0, 0));
            if (RegsDef.chkrTsCon == null) {
              return -1;
            }
            return 0;
          }
        }
        RegsDef.chkrTsCon = null;
        return -1;
      }
    }
    if (cBuf.offline != 0) {
      RegsDef.chkrTsCon = null;
      return -1;
    }
    // TODO:00002 佐野 - db_SrLogin()の対応が必要
    //RegsDef.chkrTsCon = db_SrLogin(aid, DB_ERRLOG);
    if (RegsDef.chkrTsCon == null) {
      cBuf.offline = 1;
      return -1;
    }
    return 0;
  }

  /// データ読取処理
  /// 引数:クレジット決済フラグ（0=クレジット以外  1=クレジット）
  /// 戻値:実行結果（ほとんどは意味を持たない）
  /// 関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_Start
  static Future<int> rcCrdtVoidStart(int crdtFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    rcCrdtVoidTimerRemove();
    crdtVoidActFlg = false;
    if ((crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) &&
        (RegsDef.chkrTsCon == null)) {
      await rcCrdtVoidDialogClear();
    }

    //レジNoチェック
    if (((cBuf.dbTrm.userCd15 & 512) == 0) &&
        ((await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid()))
                .value !=
            crdtVoid.macNo)) {
      debugPrint('rcCrdtVoidStart:cBuf.dbTrm.userCd15 & 512判定箇所にてエラーNo.1');
      await rcCrdtVoidDialogErr(
          DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId, 1, '');
      return -1;
    }

    if (CompileFlag.DEPARTMENT_STORE) {
      // TODO:10125 通番訂正 202404実装対象外
      /*
      /* 中合仕様ではユーザーコードを立てないと前日分も不可 */
      if (rcChk_Department_System()) {
        if ((!(cBuf.dbTrm.user_cd15 & 512)) && (cm_ucmp(CrdtVoid.date, CrdtVoid.chk_date, sizeof(CrdtVoid.date)) != EQ)) {
          rcCrdtVoid_DialogErr(MSG_NONEXISTDATA, 1, NULL);
          DB_Close();
          return( -1 );
        }
       */
    }

    if ((await CmCksys.cmTuoSystem() != 0) &&
        (Ucmp.cmUcmp(crdtVoid.date, crdtVoid.chkDate, crdtVoid.date.length) !=
            0)) {
      debugPrint(
          'rcCrdtVoidStart:await CmCksys.cmTuoSystem() != 0判定箇所にてエラーNo.2');
      await rcCrdtVoidDialogErr(
          DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId, 1, '');
      return -1;
    }

    // 顧客ロック仕様対応
    // TODO:10125 通番訂正 202404実装対象外
    // > sys.json.default の設定により rcmbrchk_custreal_netdoa_CustInfoLock() が
    //   0 固定となるため、コメント化
    /*
    if (rcmbrchk_custreal_netdoa_CustInfoLock()) {
      // 顧客ロック状態であった場合には、ロック状態を解除する。
      rcmbr_NetDoA_CustUnLockProc( &CrdtVoid.netdoa_CustInfoLock );
    }
     */

    if (await RckyTaxFreeIn.rcTaxFreeChkTaxFreeInSystem() != 0) {
      voidTaxFree = 0;
    }

    // 営業日、レジNo、レシートNoのチェック
    int errCd = RcVoidUpdate.rcVoidupdateCheckReadDate(crdtVoid.date);
    if ((errCd != 0) || crdtVoid.date.isEmpty) {
      await rcCrdtVoidDialogErr(errCd, 1, '');
      return -1;
    }
    String date =
        crdtVoid.date.substring(crdtVoid.date.length - 2, crdtVoid.date.length);
    String tsSql = "";
    String localSql = "";
    (tsSql, localSql) = RcSchRec.rcSchDBMkSql(FuncKey.KY_CRDTVOID, date,
        crdtVoid.macNo, crdtVoid.recNo, 0, crdtVoid.date, 0);
    Result? lres = await crdtVoidDbPQexec(tsSql, localSql);
    if (lres == null) {
      return -1;
    }
    if (lres.affectedRows == 0) {
      if (await dbOpen2(cBuf) == -1) {
        debugPrint('rcCrdtVoidStart:await dbOpen2(cBuf) == -1判定箇所にてエラーNo.3');
        await rcCrdtVoidDialogErr(
            DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId, 1, '');
        return -1;
      } else {
        lres = await crdtVoidDbPQexec(tsSql, localSql);
        if (lres == null) {
          return -1;
        }
        if (lres.affectedRows == 0) {
          debugPrint('rcCrdtVoidStart:lres.affectedRows == 0判定箇所にてエラーNo.4');
          await rcCrdtVoidDialogErr(
              DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId, 1, '');
          return -1;
        }
      }
    } else {
      //入力営業日が現時刻より1週以上前かチェック
      var dtNow = DateTime.now();
      var dtTgt = DateTime.parse(crdtVoid.date);
      if (dtNow.difference(dtTgt).inDays >= 7) {
        debugPrint('rcCrdtVoidStart:lres.affectedRows == 0判定箇所にてエラーNo.4-2');
        await rcCrdtVoidDialogErr(
            DlgConfirmMsgKind.MSG_REFOPR_OVER_DATE.dlgId, 1, '');
        return -1;
      }
    }

    // 会員印字初期設定
    await RckyMbrPrn.rcKyMbrPrnStartSaveCustTrm();

    // c_header_log のシリアルNoが存在しているかチェック
    int result = await RcSchRec.rcCheckVoidRec(crdtVoid.serialNo, null);
    if (result != 0) {
      await rcCrdtVoidDialogClear();
      await rcCrdtVoidDialogErr(result, 1, '');
      RegsMem mem = SystemFunc.readRegsMem();
      mem = RegsMem();
      crdtVoid.serialNo = "";
      RcSchRec.rcSchDbClose();
      return -1;
    }
    String searchBuf = "WHERE serial_no='${crdtVoid.serialNo}'";
    // TODO:00002 佐野 通番訂正_駆動ログに従い経路はコメントアウト化
    /*
    if ((cBuf.dbTrm.journalnoPrn == 0) && (cBuf.dbTrm.recieptnoPrn == 1)) {
      searchBuf = "WHERE serial_no='${crdtVoid.serialNo}' AND receipt_no='${crdtVoid.printNo}' AND print_no='${crdtVoid.recNo}' AND ope_mode_flg='${crdtVoid.opeModeFlg}'";
    } else {
      searchBuf = "WHERE serial_no='${crdtVoid.serialNo}' AND receipt_no='${crdtVoid.recNo}' AND print_no='${crdtVoid.printNo}' AND ope_mode_flg='${crdtVoid.opeModeFlg}'";
    }
    */
    tsSql = "SELECT * FROM c_header_log_$date $searchBuf";
    localSql = "SELECT * FROM c_header_log $searchBuf";
    lres = await crdtVoidDbPQexec(tsSql, localSql);
    if (lres == null) {
      return -1;
    }
    if (lres.affectedRows == 0) {
      debugPrint('rcCrdtVoidStart:lres.affectedRows == 0判定箇所にてエラーNo.5');
      await rcCrdtVoidDialogErr(
          DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId, 1, '');
      return -1;
    }

    if (crdtFlg == 1) {    //クレジット決済
      // c_header_log と c_data_log のシリアルNoが整合しているかチェック
      tsSql =
      "SELECT * FROM c_header_log_$date header INNER JOIN (SELECT serial_no, c_data4, n_data12 FROM c_data_log_$date WHERE func_cd='400000' ORDER BY serial_no DESC) AS data ON header.serial_no = data.serial_no";
      localSql =
      "SELECT * FROM c_header_log header INNER JOIN (SELECT serial_no, c_data4, n_data12 FROM c_data_log WHERE func_cd='400000' ORDER BY serial_no DESC) AS data ON header.serial_no = data.serial_no";
      lres = await crdtVoidDbPQexec(tsSql, localSql);
      if (lres == null) {
        return -1;
      }
      if (lres.affectedRows == 0) {
        debugPrint('rcCrdtVoidStart:lres.affectedRows == 0判定箇所にてエラーNo.6');
        await rcCrdtVoidDialogErr(
            DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId, 1, '');
        return -1;
      }

      // 使用されたカードの種類を取得する
      Map<String, dynamic> data = lres.first.toColumnMap();
      String chkBuf = data["n_data12"];

      // 訂正レコードの有無チェック
      if (await CmCksys.cmCapsPqvicSystem() != 0) {
        searchBuf =
        "WHERE header.ope_mode_flg='${OpeModeFlagList.OPE_MODE_VOID}' AND header.mac_no='${crdtVoid.macNo}' AND data.c_data4='${"${crdtVoid.recNo}".padLeft(11, "0")}'";
      } else {
        searchBuf =
        "WHERE header.ope_mode_flg='${OpeModeFlagList.OPE_MODE_VOID}' AND header.mac_no='${crdtVoid.macNo}' AND data.c_data4='${"${crdtVoid.recNo}".padLeft(11, "0")}' AND data.n_data12='$chkBuf'";
      }
      tsSql += " $searchBuf";
      localSql += " $searchBuf";
      lres = await crdtVoidDbPQexec(tsSql, localSql);
      if (lres == null) {
        return -1;
      }
      if (lres.affectedRows > 0) {
        debugPrint('rcCrdtVoidStart:lres.affectedRows > 0判定箇所にてエラーNo.9');
        await rcCrdtVoidDialogErr(DlgConfirmMsgKind.MSG_CORRDATA.dlgId, 1, '');
        if (RegsDef.chkrTsCon == null) {
          TprLog()
              .logAdd(await RcSysChk.getTid(), LogLevelDefine.error, localSql);
        } else {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, tsSql);
        }
        return -1;
      }
    } else {    //キャッシュ決済時
      // 訂正レコードの有無チェック
      // TODO:00002 佐野 - SQL条件に mac_no を追加するか検討（クラウドPOS側の対応後）
      tsSql =
      "SELECT * FROM c_void_log_01_$date WHERE void_serial_no='${crdtVoid.serialNo}'";
      localSql =
      "SELECT * FROM c_void_log_01 WHERE void_serial_no='${crdtVoid.serialNo}'";
      lres = await crdtVoidDbPQexec(tsSql, localSql);
      if (lres == null) {
        return -1;
      }
      if (lres.affectedRows > 0) {
        debugPrint('rcCrdtVoidStart:lres.affectedRows > 0判定箇所にてエラーNo.9');
        await rcCrdtVoidDialogErr(
            DlgConfirmMsgKind.MSG_CORRDATA.dlgId, 1, '');
        return -1;
      }
    }

    return 0;
  }

  /// 終了後の動作処理
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_PostPay_ExecFnc
  static Future<int> rcCrdtVoidPostPayExecFnc() async {
    debugPrint('payvoid調査ログ:rcCrdtVoidPostPayExecFnc スタート地点');
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    // TODO:00002 佐野 通番訂正（payvoid()を通すため、refundModeを"レシート入力"に固定）
    RckyRfdopr.rfdSaveData?.refundMode = RefundModeList.RFDOPR_MODE_RECEIPT;
    if (RckyRfdopr.rcRfdOprCheckAllRefundMode() ||
        RckyRfdopr.rcRfdOprCheckRcptVoidMode()) {
      debugPrint(
          'payvoid調査ログ:rcCrdtVoidPostPayExecFnc rcRfdOprAllRefundCreditEnd(1)');
      /* 全返品モード関数へ移行 */
      await RckyRfdopr.rcRfdOprAllRefundCreditEnd(1);
      // 通番訂正・完了画面に遷移.
      ReceiptInputController con = Get.find();
      con.navigateToReceiptCompletePage();
      return (0);
    }

    rcCrdtVoidTimerRemove();
    if (crdtVoid.dialog != 0) {
      RcGtkTimer.rcGtkTimerAdd(50, rcCrdtVoidPostPayExecFnc);
      return (0);
    }

    crdtVoidActFlg = true;
    await rcCrdtVoidSDisplayEntry();
    if (crdtVoid.nowDisplay == RcElog.CRDTVOID_LCDDISP) {
      RcSet.rcCrdtVoidIScrMode();
    }

    rePrnFlg = 0;
    RegsMem mem = SystemFunc.readRegsMem();
    crdtVoidWork = mem;
    mem = crdtVoidMem;
    int opeModeFlg = 0;
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.opeMode) {
      case RcRegs.TR:
        opeModeFlg = 0x02;
        break;
      case RcRegs.VD:
        opeModeFlg = 0x03;
        break;
      default:
        await rcCrdtVoidDialogClear();
        debugPrint(
            'rcCrdtVoidPostPayExecFnc:switch (cMem.stat.opeMode)判定箇所にてエラーNo.10');
        await rcCrdtVoidDialogErr(DlgConfirmMsgKind.MSG_OPEERR.dlgId, 1, '');
        mem = RegsMem();
        return -1;
    }

    DateTime memDate = DateTime.parse("2001-01-01 00:00:00");
    DateTime cBufDate = DateTime.parse("2001-01-01 00:00:00");
    if (crdtVoidMem.tHeader.sale_date != null) {
      memDate = DateTime.parse(crdtVoidMem.tHeader.sale_date!);
    }
    if (cBuf.dbOpenClose.sale_date != null) {
      cBufDate = DateTime.parse(cBuf.dbOpenClose.sale_date!);
    }
    if ((memDate.compareTo(cBufDate) > 0) && (CmCksys.cmMmSystem == 0)) {
      await rcCrdtVoidTSVoidUpDate(opeModeFlg);
    }
    await rcCrdtVoidPostPayEditTranData(opeModeFlg);

    // 通番訂正・完了画面に遷移.
    ReceiptInputController con = Get.find();
    con.navigateToReceiptCompletePage();

    fCtrl = CmEditCtrl();
    fCtrl.SignEdit = 1;
    if (CompileFlag.DECIMAL_POINT) {
      // TODO:10125 通番訂正 202404実装対象外
      //rcDsp_SetCNCtl(&fCtrl);
    } else {
      fCtrl.CurrencyEdit = 2;
      fCtrl.SeparatorEdit = 2;
    }
    // 実行中ダイアログ.
    //    await rcCrdtVoidDialogErr(DlgConfirmMsgKind.MSG_ACTION.dlgId, 2, '');
    crdtVoidMem = mem;
    RcSet.rcClearCrdtReg();
    if ((CompileFlag.SAPPORO) &&
        ((mem.tTtllog.t100700.mbrInput == 14) &&
            (cBuf.dbTrm.voidCust == 1) &&
            (await RcSysChk.rcChkJklPanaSystem()) &&
            (CmCksys.cmMatugenSystem() != 0))) {
      // TODO:10125 通番訂正 202404実装対象外
      //RcGtkTimer.rcGtkTimerAdd(50, rcCrdtVoidRWCStart);
    } else {
      //RcGtkTimer.rcGtkTimerAdd(100, rcCrdtVoidVoidPrn);
      await rcCrdtVoidVoidPrn();
    }
    return 0;
  }

  /// 終了後の動作処理
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_VoidPrn
  static Future<void> rcCrdtVoidVoidPrn() async {
    RxMemRet xRetCmn = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetCmn.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetCmn.object;

    rcCrdtVoidTimerRemove();

    bool qcStatus = false; // false=QCではない  true=QC
    if (CompileFlag.ARCS_MBR) {
      if (((RcRegs.rcInfoMem.rcRecog.recogQcashierSystem != 0) ||
              (RcRegs.rcInfoMem.rcRecog.recogHappyselfSystem != 0)) &&
          (await RcSysChk.rcChk2800System())) {
        qcStatus = true;
      }
    }

    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    int errStat = 0;
    if ((cBuf.dbTrm.userCd22 & 16384) != 0) {
      if (await RcAcracb.rcCheckAcrAcbON(0) != 0) {
        cMem.ent.errNo = await RcAcracb.rcAcrAcbVoidChgOut(
            mem.tTtllog.t100001.stlTaxInAmt - mem.tTtllog.calcData.stlTaxAmt);
        if (cMem.ent.errNo == OK) {
          cMem.ent.errNo = await RcAcracb.rcPrgAcrAcbModeOffResultGet();
        }
        if (cMem.ent.errNo != OK) {
          await rcCrdtVoidDialogClear();
          await rcCrdtVoidDialogErr(cMem.ent.errNo, 1, '');
          errStat = 1;
        }
      }
    } else if (RcSysChk.rcCheckCrdtVoidGiftToCash() ||
        (qcStatus &&
            (await CmCksys.cmNttdPrecaSystem() != 0) &&
            (cMem.working.crdtReg.icCardType == 53))) {
      // && (mem.tCrdtLog[0].t400000.space == 53))) {
      int chgAmt = 0;
      if (qcStatus &&
          (await CmCksys.cmNttdPrecaSystem() != 0) &&
          (cMem.working.crdtReg.icCardType == 53)) {
        // && (mem.tCrdtLog[0].t400000.space == 53)) {
        if (mem.tTtllog.t100900.todayChgamt > 0) {
          chgAmt = mem.tTtllog.t100900.todayChgamt; // チャージ額
          if (mem.tTtllog.t100001Sts.chrgFlg == 1) {
            // 釣銭チャージなら
            if ((cBuf.dbTrm.userCd36 & 512) != 0) {
              chgAmt +=
                  mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt; // 理論現金
            } else {
              chgAmt += (mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt -
                      mem.tTtllog.t100900.todayChgamt)
                  .abs(); // 理論現金 - 釣銭チャージ額
            }
          }
        } else {
          chgAmt = mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt;
        }
      } else {
        chgAmt = mem.tTtllog.t100200[AmtKind.amtCash.index].amt;
      }
      // ドロアオープン、釣銭機からの払出を行う
      if (await RcAcracb.rcCheckAcrAcbON(0) != 0) {
        // TODO:10125 通番訂正 202404実装対象外
        /*
        cMem.ent.errNo = await RcAcracb.rcAcrAcbVoidChgOut(chgAmt);
        if (cMem.ent.errNo == OK) {
          cMem.ent.errNo = rcPrg_AcrAcb_ModeOffResultGet();
        }
        if (cMem.ent.errNo != OK) {
          rcCrdtVoidDialogClear();
          await rcCrdtVoidDialogErr(cMem.ent.errNo, 1, null);
          errStat = 1;
        } else {
          await RcAcracb.rcAcrAcbStockUpdate(0);
        }
         */
      } else {
        await RcIfPrint.rcDrwopen();
        cMem.stat.clkStatus |= RcIf.OPEN_DRW;
        (await SystemFunc.statDrwGet(tsBuf)).prnStatus |= RcIf.OPEN_DRW;
      }
    }

    if (CompileFlag.ARCS_MBR) {
      await RcIfPrint.rcDrwopen();
      cMem.stat.clkStatus |= RcIf.OPEN_DRW;
      (await SystemFunc.statDrwGet(tsBuf)).prnStatus |= RcIf.OPEN_DRW;
    }

    if (await RcSuicaCom.rcNimocaRdVoidData() &&
        (mem.tTtllog.t100700Sts.voidIccnclMsgFlg != 1)) {
      // TODO:10125 通番訂正 202404実装対象外
      /*
      rcNimocaPntCrdtVoid(crdtVoid.nimoca);
      custrealMbrUpdate = 1;
       */
    } else if (CompileFlag.CUSTREALSVR &&
        ((await CmMbrSys.cmCustrealsvrSystem()) ||
            (await CmCksys.cmCustrealPointartistSystem() != 0) ||
            (await CmMbrSys.cmCustrealNecSystem(0) != 0) ||
            (await RcSysChk.rcChkUnisysMember(
                    int.parse(mem.tHeader.cust_no!)) !=
                0) ||
            (CmCksys.cmCustrealRPointSystem() != 0))) {
      if ((await RcMbrCom.rcmbrChkStat() != 0) &&
          (RcMbrCom.rcmbrChkCust() != 0)) {
        //TODO:10125 通番訂正 202404実装対象外
        /*
        if ((await rcCrdtVoidMbrActChk()) &&
            (await RcVoidUpdate.voidCustRealSrvUpdChk())) {
          if (await CmCksys.cmPointartistConect() == CmSys.PARTIST_SOCKET) {
            if (Rcmbrrealsvr2.custRealPointArtistFlRd(
                1, mem.tHeader.cust_no!, cust, enq, 1) != 0) {
              mem.tTtllog.t100700.realCustsrvFlg = 1;
            }
            mem.tTtllog.t100700Sts.d1DcauMspur = 0;
            for (int p = 0; p < mem.tTtllog.t100001Sts.itemlogCnt; p++) {
              mem.tTtllog.t100700Sts.d1DcauMspur +=
                  rcmbr_PItmSet_rbtpuramt(p, 1);
            }
            //値セット
          } else if (await CmCksys.cmCustrealUniSystem() != 0) {
            // 顧客情報をサーバーに問い合わせて、現在のポイントと累計購入金額を取得する
            if ((ret = rcCustreal_Uni_FlRd(1, MEM->ttlrbuf.mbr_cd, &cust, &enq, 1) != NORMAL) ){
              MEM->ttlrbuf.point_srv_no = 1;
            }
            MEM->ttlrbuf.lpnt_ttlsrv = enq.total_point;
            MEM->ttlrbuf.last_ttlpur = atol(enq.total_buy_rslt);
            MEM->ttlrbuf.tpnt_ttlsrv = MEM->ttlrbuf.lpnt_ttlsrv - MEM->ttlrbuf.dpnt_ttlsrv
             + (MEM->ttlrbuf.dupt_ttlrv + MEM->ttlrbuf.dcut_ttlsrv);
            if (MEM->ttlrbuf.tpnt_ttlsrv < 0) {
              MEM->ttlrbuf.tpnt_ttlsrv = 0;
            }
            MEM->ttlrbuf.term_ttlpur = MEM->ttlrbuf.last_ttlpur - MEM->ttlrbuf.dsal_ttlpur;
            if (MEM->ttlrbuf.term_ttlpur < 0) {
              MEM->ttlrbuf.term_ttlpur = 0;
            }
          } else if (CmCksys.cmCustrealRPointSystem() != 0) {
            if (crdtVoid.rpoint.pointSrvFlg != 0) {
              MEM->ttlrbuf.point_srv_no = 1;
            }
            MEM->ttlrbuf.lpnt_ttlsrv = CrdtVoid.rpoint.total_point;
            MEM->ttlrbuf.lppt_ttlsrv = CrdtVoid.rpoint.possible_point;
            MEM->ttlrbuf.tpnt_ttlsrv = MEM->ttlrbuf.lpnt_ttlsrv - MEM->ttlrbuf.dpnt_ttlsrv;
            MEM->ttlrbuf.tppt_ttlsrv = MEM->ttlrbuf.lppt_ttlsrv;
          }
          memcpy(&TtlLog, &MEM->ttlrbuf, sizeof(TtlLog));
          TtlLog.mac_no = competition_get_macno(GetTid());
          TtlLog.receipt_no = competition_get_rcptno(GetTid());
          TtlLog.print_no = competition_get_printno(GetTid());
          TtlLog.point_srv_no = 2;
          wts_con = chkr_ts_con;
          if ( cm_pointartist_conect() == PARTIST_SOCKET ) {
            cust_offline_flg = MEM->ttlrbuf.point_srv_no;
            if ( MEM->ttlrbuf.point_srv_no == 0 ) {
              rcmbrCustlogUpdate(&TtlLog, null); /* Update c_cust_log */
            } else {
              TtlLog.point_srv_no = MEM->ttlrbuf.point_srv_no;
            }
            MEM->prnrbuf.cust_offline_flg = cust_offline_flg;
          } else if(cm_custreal_uni_system()) {
            /* readオンラインなら顧客情報を更新 */
            cust_offline_flg = MEM->ttlrbuf.point_srv_no;
            if ( MEM->ttlrbuf.point_srv_no == 0 ) {
              rcmbrCustlogUpdate( &TtlLog, null );
            } else {
              TtlLog.point_srv_no = MEM->ttlrbuf.point_srv_no;
            }
            if ( (cust_offline_flg == 1) || (TtlLog.point_srv_no == 1) ) {
              /* readオフラインまたはwriteオフラインなら顧客情報を印字しない */
              MEM->prnrbuf.cust_offline_flg = 1;
            }
          } else if(cm_custreal_Rpoint_system()) {
            rcmbrCustlogUpdate(&TtlLog, null);
            memcpy(MEM->ttlrbuf.last_chg_payout, TtlLog.last_chg_payout, sizeof(MEM->ttlrbuf.last_chg_payout));
            MEM->prnrbuf.cust_offline_flg = MEM->ttlrbuf.point_srv_no;
          } else {
            rcmbrCustlogUpdate(&TtlLog, null); /* Update c_cust_log */
            MEM->prnrbuf.cust_offline_flg = MEM->ttlrbuf.point_srv_no;
          }
          chkr_ts_con = wts_con;
          MEM->ttlrbuf.point_srv_no = TtlLog.point_srv_no;
          // 顧客ロック情報をクリアする
          memset( &CrdtVoid.netdoa_CustInfoLock, 0x00, sizeof( NETDOA_CUSTINFOLOCK ));
          if (( cm_pointartist_conect() == PARTIST_SOCKET )
              || (cm_custreal_uni_system())
              || (cm_custreal_Rpoint_system())) {
            cm_clr((char *)&CRDTVOID_MEM, sizeof(REGSMEM));
            memcpy(&CRDTVOID_MEM, MEM, sizeof(REGSMEM));
          }
        }
         */
      }
      custrealMbrUpdate = 1;
    } else if (CmCksys.cmJbrainSystem() != 0) {
      // TODO:10125 通番訂正 202404実装対象外
      //rcJbrainAllSend(FuncKey.KY_CRDTVOID.keyId);
    }

    if (await CmCksys.cmHc2KuroganeyaSystem(await RcSysChk.getTid()) == 1) {
      // TODO:10125 通番訂正 202404実装対象外
      /*
      // 延長保証条件
      rcExtGuaranteeJanSet_atct();
       */
    }

    if (CompileFlag.TAX_2019) {
      await RcAtct.CalCrditamt(); // クレジット, ポイント値引, 現金のタイプをセット
      RcStlCal.rcstlcalSetTtl3Data(await RcSysChk.getTid());
    }
    if (CompileFlag.INVOICE_SYSTEM) {
      RcTbafc1.rcInvSumTaxCalMain("rcCrdtVoidVoidPrn");
      crdtVoidMem.tax = mem.tax;
    }

    crdtVoid.regsprnFlg = false;
    mem.prnrBuf.crdtvoidUpderrFlg = 0;
    int errNo = await rcCrdtVoidUpdate();
    if (errNo != OK) {
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        errNo = DlgConfirmMsgKind.MSG_UPDATEWRITEERR_CALL.dlgId;
      } else {
        errNo = DlgConfirmMsgKind.MSG_UPDATEWRITEERR_GO_HELP.dlgId;
      }
      mem.prnrBuf.crdtvoidUpderrFlg = 1;
      await rcCrdtVoidDialogClear();
      await rcCrdtVoidDialogErr(errNo, 1, '');
      errStat = 1;
    } else {
      errNo = await RcFncChk.rcChkRPrinter();
      if (errNo != OK) {
        await rcCrdtVoidDialogErr(errNo, 1, '');
        errStat = 1;
      } else {
        AtSingl atSing = SystemFunc.readAtSingl();
        atSing.rctChkCnt = 0;
        await RcExt.rxChkModeSet("rcCrdtVoidVoidPrn");
        if (!(await RcSysChk.rcChkEdySystem()) && RcSysChk.rcChkFlightSystem()) {
          // TODO:10056 ImageTableRead
          /*
          AplLibImgRead.aplLibImgRead(int.parse(mem.tTtllog.t100100[0].edyCd), mem.prnrBuf.flightName, 16);
           */
        }
        errNo = RcIfEvent.rcSendPrint();
        if (errNo != OK) {
          await rcCrdtVoidDialogClear();
          await rcCrdtVoidDialogErr(errNo, 1, '');
          errStat = 1;
        } else {
          RckyRpr.rcWaitResponce(FuncKey.KY_CRDTVOID.keyId);
          errStat = 1; //rcLoopProc()構築済みの場合、削除する
        }
      }
    }
    if (errStat == 1) {
      await rcCrdtVoidEnd(-1);
    }
  }

  /// 終了後の動作処理
  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_End
  static Future<void> rcCrdtVoidEnd(int errNo) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    String msgBuf = "";
    int savePrintType = 0;
    int saveReceiptNo = 0;
    int saveVoidPrintNo = 0;

    if (errNo > 0) {
      await rcCrdtVoidDialogClear();
      await rcCrdtVoidDialogErr(errNo, 1, '');
    } else if (mbrFlg != 0) {
      if (!(await rcCrdtVoidMbrActChk())) {
        if (CompileFlag.MC_SYSTEM) {
          // TODO:10125 通番訂正 202404実装対象外
          /*
          if (rcChk_Mc_System() && (MEM->crdtlog.cha_amt8 > 0)) { /* ->入金済額発生 */
            rcCrdtVoid_DialogClear();
            rcCrdtVoid_DialogErr(MSG_SETTLED, 1, NULL);
            custadd_flg = 1;
            errNo = MSG_SETTLED;
          }
          else if (rcChk_Mc_System()&& (rwc_msg != 0)) {         /* ->ポイント強制 */
            rcCrdtVoid_DialogClear();
            rcCrdtVoid_DialogErr(rwc_msg, 1, NULL);
            custadd_flg = 1;
            errNo = rwc_msg;
          }
           */
        }
        if ((cBuf.dbTrm.voidCust != 2) &&
            !((CmCksys.cmCustrealRPointSystem() != 0) &&
                (mem.prnrBuf.rpointVoidCnclFlg != 0))) {
          if ((await RcSuicaCom.rcNimocaRdVoidData()) &&
              (cBuf.dbTrm.voidCust == 0)) {
            await rcCrdtVoidDialogClear();
            debugPrint(
                'rcCrdtVoidEnd:await RcSuicaCom.rcNimocaRdVoidData()判定箇所にてエラーNo.11');
            await rcCrdtVoidDialogErr(
                DlgConfirmMsgKind.MSG_TEXT209.dlgId, 1, '');
            custAddFlg = 1;
            errNo = DlgConfirmMsgKind.MSG_TEXT209.dlgId;
          } else {
            if (dPointFlg != 0) {
              await rcCrdtVoidDialogClear();
              debugPrint('rcCrdtVoidEnd:dPointFlg != 0判定箇所にてエラーNo.12');
              await rcCrdtVoidDialogErr(
                  DlgConfirmMsgKind.MSG_CUSTADD_DPOINTMODIFY.dlgId, 1, '');
              custAddFlg = 1;
              errNo = DlgConfirmMsgKind.MSG_CUSTADD_DPOINTMODIFY.dlgId;
            } else {
              await rcCrdtVoidDialogClear();
              debugPrint('rcCrdtVoidEnd:dPointFlg != 0判定箇所にてエラーNo.13');
              await rcCrdtVoidDialogErr(
                  DlgConfirmMsgKind.MSG_CUSTADD.dlgId, 1, '');
              custAddFlg = 1;
              errNo = DlgConfirmMsgKind.MSG_CUSTADD.dlgId;
            }
          }
        } else if (dPointFlg != 0) {
          await rcCrdtVoidDialogClear();
          debugPrint('rcCrdtVoidEnd:else if (dPointFlg != 0)判定箇所にてエラーNo.14');
          await rcCrdtVoidDialogErr(
              DlgConfirmMsgKind.MSG_ACT_DPOINTMODIFY.dlgId, 1, '');
          errNo = DlgConfirmMsgKind.MSG_ACT_DPOINTMODIFY.dlgId;
        }
      } else {
        /* 一括訂正時、顧客実績を訂正「する」 */
        if (cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) {
          if (voidMbrTckt != 0) {
            /* お買物券あり */
            msgBuf = "１.お買い物券 $voidMbrTckt枚回収\n２.$voidMbrPntポイント減算";
            await rcCrdtVoidDialogClear();
            await rcCrdtVoidDialogConfCustAdd3(
                DlgConfirmMsgKind.MSG_CUSTADD7.dlgId,
                0,
                rcCrdtVoidDialogClearCustAdd3,
                LRckyCrdtVoid.CRDTVOID_CONF,
                msgBuf);
            custAddFlg = 1;
            errNo = DlgConfirmMsgKind.MSG_CUSTADD7.dlgId;
          }
        } else if (dPointFlg != 0) {
          await rcCrdtVoidDialogClear();
          debugPrint('rcCrdtVoidEnd:else if (dPointFlg != 0)判定箇所にてエラーNo.15');
          await rcCrdtVoidDialogErr(
              DlgConfirmMsgKind.MSG_ACT_DPOINTMODIFY.dlgId, 1, '');
          custAddFlg = 1;
          errNo = DlgConfirmMsgKind.MSG_ACT_DPOINTMODIFY.dlgId;
        }
      }
    } else if (dPointFlg != 0) {
      await rcCrdtVoidDialogClear();
      debugPrint('rcCrdtVoidEnd:else if (dPointFlg != 0)判定箇所にてエラーNo.16');
      await rcCrdtVoidDialogErr(
          DlgConfirmMsgKind.MSG_ACT_DPOINTMODIFY.dlgId, 1, '');
      custAddFlg = 1;
      errNo = DlgConfirmMsgKind.MSG_ACT_DPOINTMODIFY.dlgId;
    }

    if (voidRprFlg == 1) {
      RckyRpr.rcRprDataSet();
      savePrintType = mem.prnrBuf.type;
      mem.prnrBuf.type = PrnterControlTypeIdx.TYPE_RPR.index;
      saveReceiptNo = mem.tHeader.receipt_no;
      saveVoidPrintNo = mem.tTtllog.t100001Sts.voidPrintNo;
      mem.tHeader.receipt_no = mem.tTtllog.t100001Sts.voidReceiptNo;
      mem.tTtllog.t100001Sts.voidPrintNo = mem.tHeader.print_no;
      // TODO:10125 通番訂正（クラウドPOSへ置き換えできるか要確認）
      //rc_Send_Update();
      RckyRpr.rcRprDataBkSet(0);
      mem.prnrBuf.type = savePrintType;
      mem.tHeader.receipt_no = saveReceiptNo;
      mem.tTtllog.t100001Sts.voidPrintNo = saveVoidPrintNo;
    }
    RcIfEvent.rxChkModeReset2("rcCrdtVoidEnd");
    mem.prnrBuf.receiptNo = 0;

    // 訂正用免税フラグのリセット
    voidTaxFree = 0;

    voidRprFlg = 0;
    crdtVoid.regsprnFlg = true;
    if (mem.prnrBuf.crdtvoidUpderrFlg != 1) {
      await Rxregstr.rxSetMacShpNo();
    }
    RcCrdtFnc.rcResetEntryCrdtData();

    if (rePrnFlg == 0) {
      if (mem.prnrBuf.crdtvoidUpderrFlg != 1) {
        // TODO:10125 通番訂正（クラウドPOSへ置き換えできるか要確認）
        //rc_Inc_RctJnlNo(1);
      }
    } else {
      return;
    }
    if (RcVoidUpdate.rcCheckVoidResultMyself()) {
      if (CompileFlag.SIMPLE_STAFF) {
        if (await RcKyStf.rcChkForceStaff() != 0) {
          RcOpnCls.rcCshrClose(0);
        }
      }
    }
    if (errNo == OK) {
      rcCrdtVoidMsgChg();
    }
    return;
  }

  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_MsgChg
  static Future<void> rcCrdtVoidMsgChg() async {
    if (prChkTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(prChkTimer);
      prChkTimer = -1;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.dspEventMode != 0) {
      prChkTimer = Fb2Gtk.gtkTimeoutAdd(50, rcCrdtVoidMsgChg, 0);
      return;
    }
    if (crdtVoid.dialog == 1) {
      return;
    }

    await rcCrdtVoidDialogClear();
    fCtrl.SignEdit = 1;
    if (CompileFlag.DECIMAL_POINT) {
      // TODO:10125 通番訂正 202404実装対象外
      //rcDsp_SetCNCtl(&fCtrl);
    } else {
      fCtrl.CurrencyEdit = 2;
      fCtrl.SeparatorEdit = 2;
    }

    rcCrdtVoidDialogConf(
        1,
        DlgConfirmMsgKind.MSG_ARE_YOU_READY.dlgId,
        1,
        rcCrdtVoidSCloseKeyEnd,
        LTprDlg.BTN_YES,
        rcCrdtVoidRpr,
        LRckyCrdtVoid.CRDTVOID_BTN_REPRN,
        '');
  }

  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_Set_WorkingData
  static Future<int> rcCrdtVoidSetWorkingData() async {
    String goodThru = '0'; //"n_data7"
    String log;
    int errNo = OK;

    AcMem cMem = SystemFunc.readAcMem();
    // TODO:00007 梶原 mem関係はここでDBアクセスしてc_data_logから取得した値をセットするよう修正する！
    // 必要なのはdata_div,good_thru,tran_div,space,seqInqNo
    String dataDiv = '0'; // "n_data6"
    int tranDiv = 0; // "n_data3"
    int space = 0; // "n_data12"
    DbManipulationPs db = DbManipulationPs();
    String sql =
        "SELECT n_data3,n_data6,n_data7,n_data12,c_data5,n_data11,c_data7,c_data1,c_data2,n_data18 FROM c_data_log WHERE serial_no=@serialNo AND func_cd='400000'";
    Map<String, dynamic>? subValues = {
      "serialNo": RcKyCrdtVoid.crdtVoid.serialNo
    };
    Result results =
        await db.dbCon.execute(Sql.named(sql), parameters: subValues);
    Map<String, dynamic> data;
    if (results.isEmpty) {
      debugPrint('rcCrdtVoidSetWorkingData:c_data_logデータ取得エラーNo.7');
      errNo = NG;
    } else {
      for (var result in results) {
        data = result.toColumnMap();
        tranDiv = (double.tryParse(data["n_data3"]) ?? 0).toInt();
        dataDiv = data["n_data6"] ?? '0';
        goodThru = ((double.tryParse(data["n_data7"]) ?? 0).toInt())
            .toString()
            .padLeft(4, '0');
        space = (double.tryParse(data["n_data12"]) ?? 0).toInt();
        payAWay = data["c_data5"] ?? '0';
        posReceiptNoByCDataLog =
            (double.tryParse(data["n_data11"]) ?? 0).toInt();
        streJoinNoByCDataLog = data["c_data7"] ?? '0';
        mbrCdByCDataLog = data["c_data1"] ?? '0';
        recognNo = data["c_data2"] ?? '0';
        personCd = data["n_data18"] ?? '0';
        break;
      }
    }

    // c_status_logの値を取得し設定している
    String sql2 =
        "SELECT trim((regexp_split_to_array(status_data,'\\t'))[2]) AS ttl_lvl,trim((regexp_split_to_array(status_data,'\\t'))[33]) AS seq_inq_no,trim((regexp_split_to_array(status_data,'\\t'))[8]) AS bonus_month_sign FROM c_status_log WHERE serial_no = @serialNo AND func_cd = @funcCd;";
    Map<String, dynamic>? subValues2 = {
      "serialNo": RcKyCrdtVoid.crdtVoid.serialNo,
      "funcCd": 400000
    };
    Result results2 =
        await db.dbCon.execute(Sql.named(sql2), parameters: subValues2);
    Map<String, dynamic> data2;
    if (results2.isEmpty) {
      debugPrint('rcCrdtVoidSetWorkingData:c_status_logデータ取得エラーNo.17');
      errNo = NG;
    } else {
      for (var result2 in results2) {
        data2 = result2.toColumnMap();
        ttlLvl = (double.tryParse(data2["ttl_lvl"]) ?? 0).toInt();
        seqInqNo = data2["seq_inq_no"] ?? '';
        bonusMonthSignByCStatusLog =
            (double.tryParse(data2["bonus_month_sign"]) ?? 0).toInt();
        break;
      }
    }

    RegsMem mem = RegsMem();
    // cMem.working.crdtReg.cdno = mem.crdtlog.data_div ?? '0';
    cMem.working.crdtReg.cdno = dataDiv;
    if (cMem.working.crdtReg.cardDiv == '0') {
      cMem.working.crdtReg.cardDiv = '3';
    }
    // goodThru = '';
    //
    // goodThru = (mem.crdtlog.good_thru ?? '').toString().padLeft(4,'0');

    cMem.working.crdtReg.date = goodThru;  //有効期限
    // TODO:00007 梶原 この関数自体の必要性を検討中の為、いったん保留
    // Asctobcd.cmAsctobcd(cMem.working.crdtReg.date,goodThru,1,1);//引数後半２つ適当

    // TODO:00007 梶原 駆動ログに従い経路はコメントアウト化
    // if( (! rx_arcs_nttasp_system(MEM->ttlrbuf.mbr_typ, MEM->work_in_type))
    if (true) {
      // cMem.working.crdtReg.payDiv = mem.crdtlog.tran_div ?? 0;
      cMem.working.crdtReg.payDiv = tranDiv;  //支払区分
      // cMem.working.crdtReg.icCardType = int.parse(mem.crdtlog.space ?? '0');
      cMem.working.crdtReg.icCardType = space;  //決済区分
      // TODO:00007 梶原 駆動ログに従い経路はコメントアウト化
      // if((rcChk_Crdt_User() == KASUMI_CRDT) && (CMEM->working.crdt_reg.stat & 0x0400)) {     /* �ޥ˥奢�������桩 */
      // if(cm_Tuo_system())
      //   if((rcChk_SPVT_System()) && (CMEM->working.crdt_reg.ic_card_type == 5)) {
      //     else if((rcChk_MultiQP_System()) && (CMEM->working.crdt_reg.ic_card_type == 3)) {
      //     else if((rcChk_MultiiD_System()) && (CMEM->working.crdt_reg.ic_card_type == 2)) {
      AtSingl atSing = SystemFunc.readAtSingl();
      atSing.spvtData = SpvtData();
      switch (cMem.working.crdtReg.icCardType) {
        case 2: //iD
          atSing.spvtData.icNo = posReceiptNoByCDataLog.toString();  //伝票番号
          break;
        case 3: //QUICPay
          atSing.spvtData.icNo = seqInqNo;  //IC通番
          atSing.spvtData.slipNo = posReceiptNoByCDataLog.toString();  //伝票番号
          break;
        default:
          break;
      }

      // 伝票番号エラーチェック追加（決済区分がキャッシュ以外）
      if (RcKyCrdtVoid.crdtVoid.slipNo != posReceiptNoByCDataLog) {
        //伝票番号が入力値と合わないエラー
        //     MSG_REFOPR_NOT_FOUND_VOID(10272), // 取引が存在しないか、訂正出来ない実績です
        errNo = DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId;
      }
      // カード番号エラーチェック追加（決済区分がハウスクレジット時のみ）
      if (RcKyCrdtVoid.crdtVoid.cardNo != int.parse(streJoinNoByCDataLog)) {
        //カード番号が入力値と合わないエラー
        //     MSG_REFOPR_NOT_FOUND_VOID(10272), // 取引が存在しないか、訂正出来ない実績です
        errNo = DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND_VOID.dlgId;
      }
    }
    return errNo;
  }

  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_DialogErr
  static Future<int> rcCrdtVoidDialogErr(
      int erCode, int userCode, String Msg) async {
    // return 0;//エラー対策
    tprDlgParam_t param;
    String msgBuf = '';
    param = tprDlgParam_t();

    if (rcCrdtVoidNimocaActFlgChk() != 0) {
      //  TODO:00007 梶原 通番訂正トレースで通らない場所
      // rcCrdtVoid_NimocaActFlgClr();
      // rcCrdtVoid_NimocaErrSet();
    }

    param.erCode = erCode;
    if (userCode == 1) {
      param.dialogPtn = DlgPattern.TPRDLG_PT4.dlgPtnId;
    } else {
      param.dialogPtn = DlgPattern.TPRDLG_PT10.dlgPtnId;
    }

    if (userCode == 1) {
      param.title = LRckyCrdtVoid.CRDTVOID_ERR;
    } else {
      param.title = LRckyCrdtVoid.CRDTVOID_CONF;
    }
    param.userCode = userCode;
    if (Msg.isNotEmpty) {
      //  TODO:00007 梶原 通番訂正トレースで通らない場所
      // param.user_code = 0;
      // strncpy(MsgBuf, Msg, (sizeof(MsgBuf)-1));
      param.user_code_2 = Msg;
    } else {
      if (erCode == DlgConfirmMsgKind.MSG_TID_NOGOOD1.dlgId) {
        param.user_code_4 = ut1Msg;
      } else {
        RcEwdsp.rcNttSetErrCode(param);
      }
    }

    // if(rcChk_VEGA_Process())
    if (false) {
      //  TODO:00007 梶原 通番訂正トレースで通らない部分
      //else if ( rcsyschk_kasumi_EMV_system())
    } else if (false) {
      //  TODO:00007 梶原 通番訂正トレースで通らない部分
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      case RcRegs.KY_SINGLE:
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: erCode,
            footerMessage: "${param.user_code_2}\n${param.user_code_4}",
          ),
        );

        break;
    }

    if (userCode == 1) {
      //  TODO:00007 梶原 通番訂正トレースで通らないが実装しておく
      crdtVoid.dialog = 1;
      crdtVoid.errNo = erCode;
    } else if (userCode == 2) {
      crdtVoid.dialog = 2;
    }

    ut1Msg = '';
    return 0;
  }

  ///  関連tprxソース: rckycrdtvoid.c - rcCrdtVoid_NimocaActFlgChk
  static int rcCrdtVoidNimocaActFlgChk() {
    return crdtVoid.nimoca.actflg ?? 0;
  }
}
