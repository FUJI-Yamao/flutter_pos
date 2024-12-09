/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_mcd/cmmcdchk.dart';
import '../../lib/cm_mcd/cmmcdset.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_chkr.dart';
import 'rc_ext.dart';
import 'rc_mbr_com.dart';
import 'rc_necrealsvr.dart';
import 'rc_set.dart';
import 'rc_stl.dart';
import 'rcfncchk.dart';
import 'rcmbrcmsrv.dart';
import 'rcmbrflrd.dart';
import 'rcmbrkymbr.dart';
import 'rcmbrrealsvr.dart';
import 'rcmcard_dsp.dart';
import 'rcsyschk.dart';

/// 関連tprxソース: rcmbrbuyadd.c
class RcMbrBuyAdd {
  static const SLDISP1 = 1;
  static const SLDISP2 = 2;
  static const SLDISP3 = 3;
  static const LCDISP1 = 4;
  static const LCDISP2 = 5;
  static const LCDISP3 = 6;
  static const LCDISP4 = 7;
  static const POINT_CNT_MAX = 5;
  static const POINT_CNT_MAX_UID = 6;

  static BuyAddInfo buyAdd = BuyAddInfo();
  static int rewriteSelect = 0;
  static int printErrContinue = 0;
  static int frestaBarcodeFlg = 0;			// フレスタ様情報表示フラグ
  static String rcardJis2 = "";
  static String rcardAcode = "";
  static int birthCnt = 0;
  static int nimocaPointRslt = 0;
  static int nimocaBuyRslt = 0;
  static int rwcFlg = 0;	/* Rewrite card management flg
					                   0:処理なし / Not management
					                   1:リライトカード挿入処理中/Rewrite card insert management
					                   2:リライトカード挿入処理終了/End rewrite card insert management
					                   3:リライトカード書込処理中 /Rerite card write management
				                   */
  static int buyaddExeFlg = 0;
  static int memberRdFlg = 0;
  static int backupPosNo = 0;/* アヤハディオ様ポイント加算対応 */
  static int backupCustomerEntTyp = 0;  /* アヤハディオ様ポイント加算対応 */

  /// 買上追加LCD画面判定チェック
  /// 戻り値: 0=LCDでない  1=10.4 LCD  2=5.7 LCD
  /// 関連tprxソース: rcmbrbuyadd.c - rcmbrChkBuyAddMode
  static Future<int> rcmbrChkBuyAddMode() async {
    if (!(await RcFncChk.rcCheckBuyAddMode())) {
      return 0;
    } else {
      if (buyAdd.display == LCDISP1 ||
          buyAdd.display == LCDISP2 ||
          buyAdd.display == LCDISP3 ) {
        return 1;
      }
      return 2;
    }
  }

  /// 再書き込み仕様かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_McProc
  static Future<bool> rcChkRewriteSystem() async {
    if (await RcSysChk.rcChkFelicaSystem()) {
      return true;
    }
    if (CompileFlag.MC_SYSTEM) {
      if (RcSysChk.rcChkMcSystem()) {
        return true;
      }
    }
    if (CompileFlag.SAPPORO) {
      if ((await RcSysChk.rcChkSapporoPanaSystem())
          || (await RcSysChk.rcChkJklPanaSystem())
          || (await CmCksys.cmRainbowCardSystem() != 0)
          || (await CmCksys.cmPanaMemberSystem() != 0)
          || (await CmCksys.cmMoriyaMemberSystem() != 0)) {
        return true;
      }
    }
    if ((await RcSysChk.rcChkMcp200System())
        && ((await CmCksys.cmDcmpointSystem() == 0) || (rewriteSelect != 0)) ) {
      return true;
    }
    if (await RcSysChk.rcChkAbsV31System()) {
      return true;
    }
    if (CompileFlag.REWRITE_CARD) {
      if (CompileFlag.IWAI && CompileFlag.VISMAC) {
        if ((await RcSysChk.rcChkTRCSystem()) || (await RcSysChk.rcChkORCSystem()) || (await RcSysChk.rcChkVMCSystem())) {
          return true;
        }
      }
      else if (CompileFlag.IWAI) {
        if ((await RcSysChk.rcChkTRCSystem()) || (await RcSysChk.rcChkORCSystem())) {
          return true;
        }
      }
      else if (CompileFlag.VISMAC) {
        if ((await RcSysChk.rcChkTRCSystem()) || (await RcSysChk.rcChkVMCSystem())) {
          return true;
        }
      }
      else {
        if (await RcSysChk.rcChkTRCSystem()) {
          return true;
        }
      }
    }
    return false;
  }

  /// 指定画面かチェックする
  /// 戻り値: エラーNo（0=エラーなし）
  /// 関連tprxソース: rcmbrbuyadd.c - rcChk_BuyAdd_Obr
  static int rcChkBuyAddObr() {
    if (RcFncChk.rcChkTenOn()) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((buyAdd.display != LCDISP1) && (buyAdd.display != SLDISP1)
        && (buyAdd.display != LCDISP2) && (buyAdd.display != SLDISP2)  /* 2006/20/08 T.Habara */
        && (buyAdd.display != LCDISP3) && (buyAdd.display != SLDISP3)  /* 2003/04/01 Y.Katayama */
        && (buyAdd.display != LCDISP4) ) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    return Typ.OK;
  }

  /// 磁気カードイベント処理
  /// 引数: カードNo
  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_McProc
  static Future<void> rcBuyAddMcProc(String cardNo) async {
    if (((await rcChkRewriteSystem()) && (RcSysChk.rcChkCustrealUIDSystem() == 0)) ||
        (await RcSysChk.rcChkEdyNoMbrSystem())) {
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    cMem.ent.errNo = rcChkBuyAddObr();
    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("RcMbrBuyAdd.rcBuyAddMcProc()", cMem.ent.errNo);
      mem.tTtllog.t100700Sts.nombrmsgNo = 0;
    }
    else {
      if (buyAdd.posNo == 3)	{		/* 磁気カード番号 */
        int tmpNum = 0;
        if (await RcSysChk.rcChkNW7System()) {
          // TODO:00002 佐野 - この関数自体の必要性を検討中の為、いったん保留
          //Asctobcd.cmAsctobcd(cMem.ent.entry[5], cardNo, 5, 10);
        }
        else if (cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) {
          tmpNum = (13/2).floor() + (13%2);
          // TODO:00002 佐野 - この関数自体の必要性を検討中の為、いったん保留
          //Asctobcd.cmAsctobcd(cMem.ent.entry[10-tmpNum], cardNo, tmpNum, 13);
        }
        else {
          tmpNum = (CmMbrSys.cmMagcdLen()/2).floor() + (CmMbrSys.cmMagcdLen()%2);
          // TODO:00002 佐野 - この関数自体の必要性を検討中の為、いったん保留
          //Asctobcd.cmAsctobcd(cMem.ent.entry[10-tmpNum], cardNo, tmpNum, CmMbrSys.cmMagcdLen());
        }
        await rcBuyAddDspEntry();
        await rcInputFunc();
        buyAdd.mbrInput = 2;
        if (await RcSysChk.rcCheckWatariCardSystem()) {
          buyAdd.cardDataJis2 = mem.tmpbuf.rcarddata.jis2;
        }
      }
      else {
        mem.tTtllog.t100700Sts.nombrmsgNo = 0;
      }
    }
    RcSet.rcClearEntry();
  }

  /// 磁気カードイベント処理（メイン）
  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAddDsp_Entry
  static Future<void> rcBuyAddDspEntry() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();

    if ((RcFncChk.rcChkErr() != 0)
        && (cMem.ent.errNo == DlgConfirmMsgKind.MSG_OPEERR.dlgId)) {
      return;
    }
    if (printErrContinue != 0) {
      return;
    }
    if (rcChkBuyAddStampDisp()) {
      return;
    }
    
    if ((cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) && (buyAdd.display == LCDISP1)) {
      if ((iBuf.funcCode == FuncKey.KY_0.keyId)
          || (iBuf.funcCode == FuncKey.KY_1)
          || (iBuf.funcCode == FuncKey.KY_2)
          || (iBuf.funcCode == FuncKey.KY_3)
          || (iBuf.funcCode == FuncKey.KY_4)
          || (iBuf.funcCode == FuncKey.KY_5)
          || (iBuf.funcCode == FuncKey.KY_6)
          || (iBuf.funcCode == FuncKey.KY_7)
          || (iBuf.funcCode == FuncKey.KY_8)
          || (iBuf.funcCode == FuncKey.KY_9)
          || (iBuf.funcCode == FuncKey.KY_00)
          || (iBuf.funcCode == FuncKey.KY_000)) {
        cMem.ent.entry = Uint8List(10);
        cMem.working.dataReg.kEnt1 = 0;
        cMem.ent.tencnt = 0;
        return;
      }
    }

    int mbrTyp = 0;
    if (CompileFlag.ARCS_MBR) {
      if (RcSysChk.rcChkRalseCardSystem()
          && ((cBuf.dbTrm.ralsePointInputFnc != 0) || (buyAdd.posNo == 3))
          && (buyAdd.display == LCDISP1)
          && (atSing.inputbuf.dev != MCD.D_MCD2)) {
        if (iBuf.funcCode != FuncKey.KY_CLR.keyId) {
          RcSet.rcClearEntry();
          return;
        }
      }
      if (CompileFlag.CUSTREALSVR) {
        if ((await RcSysChk.rcChkCustrealNecSystem(0))
            && (atSing.inputbuf.dev == MCD.D_MCD2)) {
          if (RcSysChk.rcChkRalseCardSystem()) {
            mbrTyp = await Cmmcdchk.cmMcdTypeChk(rcardAcode);
            if ((mbrTyp != Mcd.MCD_RLSSTAFF) && (mbrTyp != Mcd.MCD_RLSOTHER)) {
              RcNecRealSvr.necCustRealOffLineClr();
              cBuf.custOffline = 0;
            }
          }
        }
      }
    }

    if ((await RcSysChk.rcChkSapporoRealSystem())
        && (buyAdd.posNo == 2)
        && (buyAdd.display == LCDISP1)
        && (atSing.inputbuf.dev != MCD.D_OBR)) {
      if (iBuf.funcCode != FuncKey.KY_CLR.keyId) {
        RcSet.rcClearEntry();
        return;
      }
    }

    if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
      if ((iBuf.funcCode == FuncKey.KY_CLR.keyId)
          && (cMem.ent.errNo == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId)) {
        if (buyAdd.display == LCDISP2) {
          byQuitFunc();
          return;
        }
        await rcClrCustDataBuyadd();
      }
    }

    String callFunc = "RcMbrBuyAdd.rcBuyAddDspEntry()";
    if ((await CmCksys.cmNimocaPointSystem() != 0)
        && (buyAdd.subFncCode == FuncKey.KY_NIMOCAREF)) {
      if ((iBuf.funcCode == FuncKey.KY_CLR.keyId)
          && (cMem.ent.errNo == DlgConfirmMsgKind.MSG_NIMOCA_FAIL.dlgId)) {
        TprDlg.tprLibDlgClear(callFunc);
        RcSet.rcClearErrStat2(callFunc);
        await RcExt.rxChkModeReset(callFunc);
        await rcBuyAddTrcEnd();
        rcQuitFunc();
        return;
      }
    }

    if ((await CmCksys.cmIchiyamaMartSystem() != 0)
        && (buyAdd.posNo <= 3)
        && (buyAdd.display == LCDISP1)
        && ((atSing.inputbuf.dev != MCD.D_MCD2) && (atSing.inputbuf.dev != MCD.D_MCD1)) ) {
      if (iBuf.funcCode != FuncKey.KY_CLR.keyId) {
        RcSet.rcClearEntry();
        return;
      }
    }

    int formatNo = 0;
    int tencntMax = 0;
    for (int idx = 0; idx < RxMem.DB_INSTRE_MAX; idx++) {
      if (cBuf.dbInstre[idx].format_typ == 3) { /* バーコードタイプが顧客 */
        formatNo = cBuf.dbInstre[idx].format_no;
        break;
      }
    }
    if (formatNo == 10) {
      tencntMax = 5;
    }
    else if (formatNo == 11) {
      tencntMax = 6;
    }
    else {
      tencntMax = (CmMbrSys.cmMbrcdLen() - 3);
    }
    if ((await CmCksys.cmDcmpointSystem() != 0)
        || (await CmCksys.cmIchiyamaMartSystem() != 0)) {
      tencntMax = CmMbrSys.cmMagcdLen();
    }

    CmEditCtrl fCtrl = CmEditCtrl();
    fCtrl.SeparatorEdit = 0;
    String sBuf = "";

    switch (buyAdd.posNo) {
      case 5:
      case 6:
      case 7:
      case 8:
        if (CompileFlag.DECIMAL_POINT) {
          // TODO:10155 顧客呼出 実装対象外
          //rcDsp_SetCNCtl(&fCtrl);
        }
        if (await checkExec()) {
          return;
        }
        if (await rcChkRewriteSystem()) {
          if ((rwcFlg == 1) || (rwcFlg == 3)) {
            RcSet.rcClearEntry();
            return;
          }
        }
        if (RcSysChk.rcChkCustrealFrestaSystem()) {
          // TODO:10155 顧客呼出 実装対象外
          /*
          if (buyAdd.display == LCDISP2) {
            if (frestaBarcodeFlg == 0) {
              if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
                rcBuyAdd_FrestaBar_GetDataClr();	// カード忘れバーコード情報クリア
                fCtrl.SeparatorEdit = 2;
                buyAdd.entryText6 = " ".padLeft(11);
                CmNedit.cmEditBcdUtf(fCtrl,buyAdd.entryText6, sizeof(buyAdd.entryText6), 10, cMem.ent.entry, sizeof(cMem.ent.entry), 8, &bytes);
                *cm_BOA(buyAdd.entryText6) = 0x00;
                fCtrl.SeparatorEdit = 0;
                buyAdd.entryText8P = " ".padLeft(15);
                CmNedit.cmEditBcdUtf(fCtrl,buyAdd.entryText8P, sizeof(buyAdd.entryText8P), 14, cMem.ent.entry, sizeof(cMem.ent.entry), POINT_CNT_MAX, &bytes);
                *cm_BOA(buyAdd.entryText8P) = 0x00;
                Fb2Gtk.gtkRoundEntrySetText(GTK_ROUND_ENTRY(buyAdd.entry2), buyAdd.entryText6);
                Fb2Gtk.gtkRoundEntrySetText(GTK_ROUND_ENTRY(buyAdd.entry4), buyAdd.entryText8P[4]);
              }
              else {
                RcSet.rcClearEntry();
              }
              return;
            }
          }
           */
        }
        break;
      default:
        break;
    }

    int tencntLmt = 0;
    String pData = "";
    for (int i=0; i<cMem.ent.entry.length; i++) {
      pData += cMem.ent.entry.toString();
    }
    switch (buyAdd.posNo) {
      case 0:  /* 呼出番号 */
        if (await CmCksys.cmDcmpointSystem() != 0) {
          if (((cBuf.dbTrm.memBcdTyp == 1) && (cMem.ent.tencnt > tencntMax))
              || ((cBuf.dbTrm.memBcdTyp != 1) && (cMem.ent.tencnt > CmMbrSys.cmMbrcdLen()))) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
            return;
          }
          buyAdd.entryText1 = " ".padLeft(CmMbrSys.cmMbrcdLen());
          buyAdd.entryText1 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText1.length, CmMbrSys.cmMbrcdLen(), pData, cMem.ent.entry.length, CmMbrSys.cmMbrcdLen(), 0).$3;
          if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
            buyAdd.entryText1 = " ".padLeft(CmMbrSys.cmMbrcdLen());
          }
        }
        else if (await CmCksys.cmSm36SanprazaSystem() != 0) {
          if (cMem.ent.tencnt > tencntMax) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
            return;
          }
          buyAdd.entryText1 = " ".padLeft(CmMbrSys.cmMbrcdLen());
          buyAdd.entryText1 += CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText1.length, CmMbrSys.cmMbrcdLen(), pData, cMem.ent.entry.length, CmMbrSys.cmMbrcdLen(), 0).$3;
          if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
            buyAdd.entryText1 = " ".padLeft(CmMbrSys.cmMbrcdLen());
          }
        }
        else {
          if (((cBuf.dbTrm.memBcdTyp == 1) && (cMem.ent.tencnt > tencntMax))
              || ((cBuf.dbTrm.memBcdTyp != 1) && (cMem.ent.tencnt > (CmMbrSys.cmMbrcdLen() - 3)))) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
            return;
          }
          buyAdd.entryText1 = " ".padLeft(CmMbrSys.cmMbrcdLen() - 3);
          buyAdd.entryText1 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText1.length, CmMbrSys.cmMbrcdLen()-3, pData, cMem.ent.entry.length, CmMbrSys.cmMbrcdLen()-3, 0).$3;
          if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
            buyAdd.entryText1 = " ".padLeft(CmMbrSys.cmMbrcdLen() - 3);
          }
        }
        if (buyAdd.display == LCDISP1) {
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry1), buyAdd.entryText1);
        }
        if (CompileFlag.ARCS_MBR) {
          if (RcSysChk.rcChkRalseCardSystem()) {
            rcardJis2 = "";
          }
        }
        break;
      case 1: /* 電話番号 */
        sBuf = cMem.ent.entry[9].toRadixString(16).padLeft(2, "0");
        buyAdd.entryText2 += sBuf[1];
        if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
          buyAdd.entryText2 = "";
        }
        if (buyAdd.entryText2.length > 11) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
          buyAdd.entryText2 = "";
          return;
        }
        if (buyAdd.display == LCDISP1)	{
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry2), buyAdd.entryText2);
        }
        break;
      case 2: /* 会員番号 */
        if (cMem.ent.tencnt > CmMbrSys.cmMbrcdLen()) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
          return;
        }
        buyAdd.entryText3 = " ".padLeft(CmMbrSys.cmMbrcdLen());
        buyAdd.entryText3 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText3.length, CmMbrSys.cmMbrcdLen(), pData, cMem.ent.entry.length, CmMbrSys.cmMbrcdLen(), 0).$3;
        if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
          buyAdd.entryText3 = " ".padLeft(CmMbrSys.cmMbrcdLen());
        }
        if (buyAdd.display == LCDISP1) {
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry3), buyAdd.entryText3);
        }
        if (CompileFlag.ARCS_MBR) {
          if (RcSysChk.rcChkRalseCardSystem()) {
            rcardJis2 = "";
          }
        }
        break;
      case 3: /* 磁気カード */
        if (cMem.ent.tencnt > CmMbrSys.cmMagcdLen()) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
          return;
        }
        buyAdd.entryText4 = " ".padLeft(CmMbrSys.cmMagcdLen());
        if (await RcSysChk.rcChkNW7System()) {
          buyAdd.entryText12 = " ".padLeft(11);
          buyAdd.entryText12 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText12.length, 10, pData, 10, 10, 0).$3;
          if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
            buyAdd.entryText12 = " ".padLeft(11);
          }
          if (buyAdd.display == LCDISP1)	{
            // TODO:10122 グラフィクス処理（gtk_*）
            //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry4), buyAdd.entryText12);
          }
        }
        else if(cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) {
          buyAdd.entryText4 = " ".padLeft(17);
          buyAdd.entryText4 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText4.length, 13, pData, cMem.ent.entry.length, 13, 0).$3;
          if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
            buyAdd.entryText4 = " ".padLeft(17);
          }
          if (buyAdd.display == LCDISP1)  {
            // TODO:10122 グラフィクス処理（gtk_*）
            //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry4), buyAdd.entryText4);
          }
        }
        else {
          buyAdd.entryText4 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText4.length, CmMbrSys.cmMbrcdLen(), pData, cMem.ent.entry.length, CmMbrSys.cmMbrcdLen(), 0).$3;
          if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
            buyAdd.entryText4 = " ".padLeft(CmMbrSys.cmMagcdLen());
          }
          if (buyAdd.display == LCDISP1)	{
            // TODO:10122 グラフィクス処理（gtk_*）
            //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry4), buyAdd.entryText4);
          }
          if (CompileFlag.ARCS_MBR) {
            if (RcSysChk.rcChkRalseCardSystem()) {
              rcardJis2 = rcardAcode.substring(1);
            }
          }
        }
        break;
      case 5: /* 税込買上金額 */
        if (cMem.ent.tencnt > 8) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
          return;
        }
        fCtrl.SeparatorEdit = 2;
        buyAdd.entryText6 = " ".padLeft(11);
        buyAdd.entryText6 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText6.length, 10, pData, cMem.ent.entry.length, 8, 0).$3;
        if (buyAdd.display == LCDISP2) {
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry2), buyAdd.entryText6);
        }
        break;
      case 6: /* 税抜買上金額 */
        if (cMem.ent.tencnt > 8) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
          return;
        }
        fCtrl.SeparatorEdit = 2;
        buyAdd.entryText7 = " ".padLeft(11);
        buyAdd.entryText7 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText7.length, 10, pData, cMem.ent.entry.length, 8, 0).$3;
        if (buyAdd.display == LCDISP2) {
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry3), buyAdd.entryText7);
        }
        break;
      case 7: /* 対象額 */
        if (await rcBuyAddChkPointInp()) {
          if (CompileFlag.SAPPORO) {
            if (await RcSysChk.rcChkSapporoPanaSystem()) {
              if (cMem.ent.tencnt > 4) {
                await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
                return;
              }
            }
            else if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
              if (cMem.ent.tencnt > POINT_CNT_MAX_UID) {
                await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
                return;
              }
            }
            else {
              if (cMem.ent.tencnt > POINT_CNT_MAX) {
                await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
                return;
              }
            }
          }
          else {
            if (cMem.ent.tencnt > POINT_CNT_MAX) {
              await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
              return;
            }
          }
          buyAdd.entryText8P = " ".padLeft(15);
          if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
            buyAdd.entryText8P = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText8P.length, 14, pData, cMem.ent.entry.length, POINT_CNT_MAX_UID, 0).$3;
          }
          else {
            buyAdd.entryText8P = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText8P.length, 14, pData, cMem.ent.entry.length, POINT_CNT_MAX, 0).$3;
          }
          // 入力ボタンチェックフラグ
          if (cMem.ent.tencnt > 0) {
            if (RcSysChk.rcChkCustrealFrestaSystem()) {
              buyAdd.inputNumFlg = 0;
            }
            else {
              buyAdd.inputNumFlg = 1;
            }
          }
          else {
            buyAdd.inputNumFlg = 0;
          }
          if (buyAdd.display == LCDISP2) {
            // TODO:10122 グラフィクス処理（gtk_*）
            //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry4), &buyAdd.entryText8P[4]);
          }
        }
        else if (cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) {
          if (cMem.ent.tencnt > POINT_CNT_MAX) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
            return;
          }
          buyAdd.entryText8P = " ".padLeft(15);
          if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
            buyAdd.entryText8P = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText8P.length, 14, pData, cMem.ent.entry.length, POINT_CNT_MAX_UID, 0).$3;
          }
          else {
            buyAdd.entryText8P = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText8P.length, 14, pData, cMem.ent.entry.length, POINT_CNT_MAX, 0).$3;
          }
          if (buyAdd.display == LCDISP2) {
            // TODO:10122 グラフィクス処理（gtk_*）
            //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry4), &buyAdd.entryText8P[4]);
          }
        }
        else {
          if (cMem.ent.tencnt > 8) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
            return;
          }
          fCtrl.SeparatorEdit = 2;
          buyAdd.entryText8 = " ".padLeft(11);
          buyAdd.entryText8 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText8.length, 10, pData, cMem.ent.entry.length, 8, 0).$3;
          if (buyAdd.display == LCDISP2) {
            if (!((await CmCksys.cmSpecialCouponSystem() != 0)
                && ((await CmCksys.cmPharmacySystem() != 0) ||
                    (await CmCksys.cmPalcoopCardForgotCheck() != 0))
                && (cMem.working.janInf.type == JANInfConsts.JANtypeCardforget1.value))) {
              // TODO:10122 グラフィクス処理（gtk_*）
              //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry4), buyAdd.entryText8);
            }
          }
          prctopoint(1);
        }
        break;
      case 8: /* 複数売価期間対象額 */
        tencntLmt = 8;
        if (await RcSysChk.rcChkFelicaSystem()) {
          tencntLmt = 6;
        }
        if (cMem.ent.tencnt > tencntLmt) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
          return;
        }
        fCtrl.SeparatorEdit = 2;
        buyAdd.entryText9 = " ".padLeft(11);
        buyAdd.entryText9 = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryText9.length, 10, pData, cMem.ent.entry.length, 8, 0).$3;
        if (buyAdd.display == LCDISP2)	{
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry5), buyAdd.entryText9);
        }
        break;
      case 9: /* 従業員番号 */
        if (iBuf.funcCode == FuncKey.KY_00) {
          sBuf = cMem.ent.entry[9].toRadixString(16).padLeft(2, "0");
          buyAdd.entryText10 += sBuf;
        }
        else if (iBuf.funcCode == FuncKey.KY_000) {
          sBuf = cMem.ent.entry[9].toRadixString(16).padLeft(3, "0");
          buyAdd.entryText10 += sBuf;
        }
        else {
          sBuf = cMem.ent.entry[9].toRadixString(16).padLeft(2, "0");
          buyAdd.entryText10 += sBuf[1];
        }
        if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
          buyAdd.entryText10 = "";
        }
        if (buyAdd.entryText10.length > 6) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
          buyAdd.entryText10 = "";
          return;
        }
        if (buyAdd.display == LCDISP3) {
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry1), buyAdd.entryText10);
        }
        break;
      case 10: /* パスワード */
        sBuf = cMem.ent.entry[9].toRadixString(16).padLeft(2, "0");
        buyAdd.entryText11 += sBuf[1];
        buyAdd.pass += "*";
        if (iBuf.funcCode == FuncKey.KY_CLR.keyId)	{
          buyAdd.entryText11 = "";
          buyAdd.pass = "";
        }
        if (buyAdd.entryText11.length > 8) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
          buyAdd.entryText11 = "";
          buyAdd.pass = "";
          return;
        }
        if (buyAdd.display == LCDISP3) {
          // TODO:10122 グラフィクス処理（gtk_*）
          //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry2), buyAdd.pass);
        }
        break;
      case 11: /* 誕生日 */
        if (CompileFlag.CUSTBIRTHSERCH) {
          if (RcSysChk.rcChkCustrealsvrSystem()) {
            sBuf = cMem.ent.entry[9].toRadixString(16).padLeft(2, "0");
            if (birthCnt >= 2) {
              buyAdd.entryText13 = buyAdd.entryText13.substring(0, birthCnt) + sBuf[1] + buyAdd.entryText13.substring(birthCnt+2);
            }
            else {
              buyAdd.entryText13 = buyAdd.entryText13.substring(0, birthCnt-1) + sBuf[1] + buyAdd.entryText13.substring(birthCnt+1);
            }
            birthCnt++;
            if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
              buyAdd.entryText13 = "00-00";
              birthCnt = 0;
            }
            if (birthCnt > 4) {
              await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
              buyAdd.entryText13 = "00-00";
              birthCnt = 0;
              return;
            }
            if (buyAdd.display == LCDISP1) {
              // TODO:10122 グラフィクス処理（gtk_*）
              //gtk_round_entry_set_text(GTK_ROUND_ENTRY(buyAdd.entry6), buyAdd.entryText13);
            }
          }
          break;
        }
      case 12: /* FSPレベル変更用パスワード */
        if ((iBuf.funcCode == FuncKey.KY_0)
            || (iBuf.funcCode == FuncKey.KY_1)
            || (iBuf.funcCode == FuncKey.KY_2)
            || (iBuf.funcCode == FuncKey.KY_3)
            || (iBuf.funcCode == FuncKey.KY_4)
            || (iBuf.funcCode == FuncKey.KY_5)
            || (iBuf.funcCode == FuncKey.KY_6)
            || (iBuf.funcCode == FuncKey.KY_7)
            || (iBuf.funcCode == FuncKey.KY_8)
            || (iBuf.funcCode == FuncKey.KY_9)) {
          if (buyAdd.pass.length > 7) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
            return;
          }
          buyAdd.pass += "*";
          rcBuyAddFspPasswordDisp(2);
        }
        if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
          buyAdd.pass = "";
          rcBuyAddFspPasswordDisp(2);
        }
        break;
      case 14: /* Edy番号 */
        buyAdd.entryTextEdyNo = " ".padLeft(CmMbrSys.cmMbrcdLen());
        buyAdd.entryTextEdyNo = CmNedit().cmEditBcdUtf(fCtrl, [], buyAdd.entryTextEdyNo.length, CmMbrSys.cmMbrcdLen(), pData, cMem.ent.entry.length, CmMbrSys.cmMbrcdLen(), 0).$3;
        if (iBuf.funcCode == FuncKey.KY_CLR.keyId) {
          buyAdd.entryTextEdyNo = " ".padLeft(CmMbrSys.cmMbrcdLen());
        }
        break;
      /* アヤハディオ様ポイント加算対応 */
      case 15: /* ポイント加算画面 */
        if (RcSysChk.rcsyschkAyahaSystem() && (buyAdd.fncCode == FuncKey.KY_POINT_ADD.keyId)) {/* アヤハディオ様ポイント加算対応 */
          rcLcdPointAddEntry();
        }
        break;
      default:
        break;
    }
  }

  /// 入力処理
  /// 関連tprxソース: rcmbrbuyadd.c - rcInputFunc
  static Future<void> rcInputFunc() async {
    String callFunc = "RcMbrBuyAdd.rcInputFunc()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, callFunc);

    if (!(await RcSysChk.rcChkZHQsystem())
        && (await CmCksys.cmIchiyamaMartSystem() == 0)
        && !RcSysChk.rcsyschkSm66FrestaSystem()
        && (await CmCksys.cmDs2GodaiSystem() == 0) ) {
      if (await CmCksys.cmSm36SanprazaSystem() == 0) {
        if (RcMbrCom.rcmbrGetMbrBarFlg() == 0) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_BARFMTERR.dlgId);
          return;
        }
      }
    }
    if (CompileFlag.CUSTREALSVR) {
      memberRdFlg = 0;
    }
    /* clear */
    buyAdd.cust = CCustMst();
    buyAdd.enq = SCustTtlTbl();
    buyAdd.enqParent = SCustTtlTbl();
    buyAdd.otherFlg = 0;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemPtr() error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xRetStat.object;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();
    int errNo = 0;
    int iret = 0;
    String custCd = "";
    String inputCd = "";
    String birthDay = "";
    CCustMst dummyParent = CCustMst();

    switch (buyAdd.posNo) {
      case 0: /* call number */
        backupCustomerEntTyp = buyAdd.posNo;/* アヤハディオ様ポイント加算対応 */
        if (!inputCheck(buyAdd.posNo, buyAdd.entryText1)) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
          return;
        }
        if (CompileFlag.ARCS_MBR) {
          if (RcSysChk.rcChkRalseCardSystem() &&(cMem.ent.tencnt < 9)) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId);
            return;
          }
        }
        if (await CmCksys.cmIchiyamaMartSystem() != 0) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
          return;
        }
        buyAdd.entryText1 = buyAdd.entryText1.replaceAll(" ", "0");
        inputCd = inputCd.padLeft(CmMbrSys.cmMbrcdLen()-buyAdd.entryText1.length, "0");
        inputCd += buyAdd.entryText1;
        if (RcMbrCom.rcChkOtherCo1()) {
          errNo = RcMbrCom.rcChkMagcdDigit(inputCd);
          if (errNo != 0) {
            await RcExt.rcErr(callFunc, errNo);
            return;
          }
        }
        custCd = (await RcMbrCom.rcmbrMakeMbrCode(inputCd)).$2;
        if (CompileFlag.ARCS_MBR) {
          if (RcSysChk.rcChkRalseCardSystem()) {
            atSing.mbrTyp = Mcd.MCD_RLSCARD;
          }
        }
        if (RcSysChk.rcChkMbrRCPdscSystem()) {
          if (RcMbrCom.rcChkMemberRCpdsc(custCd) || RcMbrCom.rcChkMemberStaffpdsc(custCd)) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId);
            return;
          }
        }
        RcMbrFlrd.cust = buyAdd.cust;
        RcMbrFlrd.enq = buyAdd.enq;
        RcMbrFlrd.custParent = dummyParent;
        RcMbrFlrd.enqParent = buyAdd.enqParent;
        RcMbrFlrd.svs = buyAdd.svs;
        iret = await RcMbrFlrd.referCust(custCd, "", "", buyAdd.mbrInput, RcMbr.RCMBR_WAIT);
        if (iret != Typ.NORMAL) {
          if (CompileFlag.ARCS_MBR) {
            if (RcSysChk.rcChkRalseCardSystem()) {
              if (custCd[2] == '1') {
                iret = DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
              }
            }
          }
          if (iret == DlgConfirmMsgKind.MSG_OTHERMBR.dlgId) {
            await rcOtherFunc(buyAdd.posNo, custCd);
          }
          else {
            await RcExt.rcErr(callFunc, iret);
          }
          mem.tTtllog.t100700Sts.nombrmsgNo = 0;
          return;
        }
        mem.tTtllog.t100700Sts.nombrmsgNo = 0;
        iret = rcBuyAddAyahaMbrDiviChk();
        if (iret != 0) {
          await RcExt.rcErr(callFunc, iret);
          return;
        }
        if (await RcSysChk.rcChkOneToOnePromSystem()) {
          await rcBuyAddSetOneToOneData();
        }
        buyAdd.mbrInput = 3;
        break;
      case 1: /* telephone number */
        backupCustomerEntTyp = buyAdd.posNo;/* アヤハディオ様ポイント加算対応 */
        if (!inputCheck(buyAdd.posNo, buyAdd.entryText2))	{
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
          return;
        }
        if (cBuf.dbTrm.memUseTyp == 1) {	/* other member */
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId);
          return;
        }
        if (RcSysChk.rcChkCustrealPointartistSystem() != 0) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
           return;
        }
        inputCd = buyAdd.entryText2;
        if (CompileFlag.CUSTBIRTHSERCH) {
          if (RcSysChk.rcChkCustrealsvrSystem()) {
            birthCnt = 0;
            rcPressBtn(5);
            return;
          }
        }
        RcMbrFlrd.cust = buyAdd.cust;
        RcMbrFlrd.enq = buyAdd.enq;
        RcMbrFlrd.custParent = dummyParent;
        RcMbrFlrd.enqParent = buyAdd.enqParent;
        RcMbrFlrd.svs = buyAdd.svs;
        iret = await RcMbrFlrd.referCust("", inputCd, "", buyAdd.mbrInput, RcMbr.RCMBR_WAIT);
        if (iret != Typ.NORMAL) {
          if (iret != RcMbr.RCMBR_TEL_LIST) {
            mem.tTtllog.t100700Sts.nombrmsgNo = 0;
            await RcExt.rcErr(callFunc, iret);
            return;
          }
          return;
        }
        mem.tTtllog.t100700Sts.nombrmsgNo = 0;
        iret = rcBuyAddAyahaMbrDiviChk();
        if (iret != 0) {
          await RcExt.rcErr(callFunc, iret);
          return;
        }
        if (await RcSysChk.rcChkOneToOnePromSystem()) {
          await rcBuyAddSetOneToOneData();
        }
        buyAdd.mbrInput = 4;
        break;
      case 2: /* customer number(barcode) */
        backupCustomerEntTyp = buyAdd.posNo;/* アヤハディオ様ポイント加算対応 */
        if (!inputCheck(buyAdd.posNo, buyAdd.entryText3))	{
          buyAdd.rcptInfo = BuyAddRcptInfo();
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
          return;
        }
        buyAdd.entryText3 = buyAdd.entryText3.replaceAll(" ", "0");
        RcSysChk.rcClearJanInf();
        if (cBuf.dbTrm.nw7mbrBarcode2 != 0) {
          cMem.working.janInf.code = "".padLeft(CmMbrSys.cmMbrcdLen(), "0");
          cMem.working.janInf.code = cMem.working.janInf.code.substring(0, 5) + buyAdd.entryText3.substring(3, 11) + cMem.working.janInf.code.substring(13);
        }
        else {
          cMem.working.janInf.code = buyAdd.entryText3;
        }
        if (await CmCksys.cmZHQSystem() == 0) {
          // 入力した番号が、有効かをチェックする
          if (!(await RcMcardDsp.rcMemberChkMbrCardMst(cMem.working.janInf.code))) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_CARD_NOTUSE.dlgId);  // このカードは使用できません
            return;
          }
        }
        if (!(await RcSysChk.rcChkEdyNoMbrSystem())
            && (await CmCksys.cmSm36SanprazaSystem() == 0)) {
          if ( (!((await RcSysChk.rcChkNW7System()) ||
                (cBuf.dbTrm.nw7mbrBarcode2 != 0)) )
              || ((await RcSysChk.rcChkNW7System()) &&
                (cMem.working.janInf.code != 62)) ) {
            if (!(await RcMbrCom.rcmbrChkMbrCode())) {
              await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_BARFMTERR.dlgId);
              return;
            }
            else if (CompileFlag.ARCS_MBR) {
              if (RcSysChk.rcChkRalseCardSystem()
                  && (buyAdd.display == LCDISP1)
                  && (atSing.inputbuf.dev == MCD.D_OBR) ) {
                await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_PLUERROR.dlgId);
                return;
              }
            }
          }
        }
        if (RcMbrCom.rcChkOtherCo1()) {
          errNo = RcMbrCom.rcChkMagcdDigit(cMem.working.janInf.code[CmMbrSys.cmMbrcdLen() - 1 - CmMbrSys.cmMbrcdLen()]);
          if (errNo != 0) {
            await RcExt.rcErr(callFunc, errNo);
            return;
          }
        }
        if (RcSysChk.rcChkMbrRCPdscSystem()) {
          if (RcMbrCom.rcChkMemberRCpdsc(cMem.working.janInf.code)
              || RcMbrCom.rcChkMemberStaffpdsc(cMem.working.janInf.code)) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId);
            return;
          }
        }
        if (CompileFlag.ARCS_MBR) {
          if (RcSysChk.rcChkRalseCardSystem()) {
            atSing.mbrTyp = Mcd.MCD_RLSCARD;
          }
        }
        RcMbrFlrd.cust = buyAdd.cust;
        RcMbrFlrd.enq = buyAdd.enq;
        RcMbrFlrd.custParent = dummyParent;
        RcMbrFlrd.enqParent = buyAdd.enqParent;
        RcMbrFlrd.svs = buyAdd.svs;
        iret = await RcMbrFlrd.referCust(cMem.working.janInf.code, "", "", buyAdd.mbrInput, RcMbr.RCMBR_WAIT);
        if (iret != Typ.NORMAL) {
          if (CompileFlag.ARCS_MBR) {
            if (RcSysChk.rcChkRalseCardSystem()) {
              if (cMem.working.janInf.code[2] == "1") {
                iret = DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
              }
            }
          }
          if (iret == DlgConfirmMsgKind.MSG_OTHERMBR.dlgId) {
            await rcOtherFunc(buyAdd.posNo, cMem.working.janInf.code);
          }
          else {
            buyAdd.rcptInfo = BuyAddRcptInfo();
            await RcExt.rcErr(callFunc, iret);
          }
          mem.tTtllog.t100700Sts.nombrmsgNo = 0;
          return;
        }
        mem.tTtllog.t100700Sts.nombrmsgNo = 0;
        if (CompileFlag.ARCS_MBR) {
          if (atSing.mbrTyp == Mcd.MCD_RLSSTAFF) {
            buyAdd.rcptInfo = BuyAddRcptInfo();
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId);
            return;
          }
          else if ((atSing.mbrTyp == Mcd.MCD_RLSOTHER) && (await CmMbrSys.cmNewARCSSystem() != 0)) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId);
            return;
          }
        }
        iret = rcBuyAddAyahaMbrDiviChk();
        if (iret != 0) {
          await RcExt.rcErr(callFunc, iret);
          return;
        }
        if (await RcSysChk.rcChkOneToOnePromSystem()) {
          await rcBuyAddSetOneToOneData();
        }
        buyAdd.mbrInput = 5;
        break;
      case 3: /* card number */
        backupCustomerEntTyp = buyAdd.posNo;/* アヤハディオ様ポイント加算対応 */
        if (await RcSysChk.rcChkNW7System()) {
          if (!inputCheck(buyAdd.posNo, buyAdd.entryText12)) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
            return;
          }
          buyAdd.entryText12 = buyAdd.entryText12.replaceAll(" ", "0");
          if (CompileFlag.ARCS_MBR) {
            (iret, custCd) = await Cmmcdset.cmMcdToMbr(buyAdd.entryText12, atSing.mbrTyp);
          }
          else {
            (iret, custCd) = await Cmmcdset.cmMcdToMbr(buyAdd.entryText12);
          }
          if (iret != Typ.OK) {
            await RcExt.rcErr(callFunc, iret);
            return;
          }
        }
        else {
          if (!inputCheck(buyAdd.posNo, buyAdd.entryText4)) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
            return;
          }
          buyAdd.entryText4 = buyAdd.entryText4.replaceAll(" ", "0");
          if (RcSysChk.rcChkCustrealPointartistSystem() != 0) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
            return;
          }
          if (RcSysChk.rcChkCustrealFrestaSystem()) {
            custCd = buyAdd.entryText4;
          }
          else {
            if (CompileFlag.ARCS_MBR) {
              (iret, custCd) = await Cmmcdset.cmMcdToMbr(buyAdd.entryText4, atSing.mbrTyp);
            }
            else {
              (iret, custCd) = await Cmmcdset.cmMcdToMbr(buyAdd.entryText4);
            }
            if (iret != Typ.OK) {
              await RcExt.rcErr(callFunc, iret);
              return;
            }
          }
        }
        if (RcSysChk.rcChkMbrRCPdscSystem()) {
          if (RcMbrCom.rcChkMemberRCpdsc(custCd) || RcMbrCom.rcChkMemberStaffpdsc(custCd)) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId);
            return;
          }
        }
        if (CompileFlag.SAPPORO) {
          if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
            if (custCd.isNotEmpty && (int.tryParse(custCd)! < 100000)) {
              await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
              return;
            }
            tsBuf.rwc.rainbowPanaData.spterm = 0;
            errNo = 0;
            buyAdd.mbrInput = MbrInputType.magcardInput.index;
            iret = await RcMbrFlrd.rcmbrReadCust(custCd, "", "", buyAdd.mbrInput, RcMbr.RCMBR_WAIT);
            if (RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
              RcRegs.kyStR1(cMem.keyStat, FncCode.KY_REG.keyId);
            }
            buyAdd.cust = cMem.custData.cust;
            buyAdd.enq = cMem.custData.enq!;
            buyAdd.svs = cMem.custData.svsCls;
            buyAdd.enqParent = cMem.custData.enqParent;
            if (mem.tTtllog.t100700.otherStoreMbr == 1) {
              if (cBuf.dbTrm.othSaleAdd == 1 ) {
                errNo = DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
              }
              else {
                await rcOtherFunc(buyAdd.posNo, custCd);
              }
            }
            else {
              if (iret == Typ.OK) {
                await RcMbrCmSrv.rcmbrComCustDataSet();
              }
              else {
                errNo = iret;
              }
            }
            mem.tTtllog.t100700Sts.nombrmsgNo = 0;
            if (errNo != 0) {
              await RcExt.rcErr(callFunc, errNo);
              return;
            }
            buyAdd.mbrInput = 5;
            if (tsBuf.custreal2.data.uid.rec.card_stop_flg == -1) {
              await rcBuyAddUIDErrProc();
              return;
            }
            if ((tsBuf.custreal2.stat != 0)
                || (tsBuf.custreal2.data.uid.rec.card_stop_flg != 0)
                || (tsBuf.custreal2.data.uid.rec.card_stat_flg != 0)
                || (tsBuf.custreal2.data.uid.rec.parent_card_no[0] != '\0')) {
              if (tsBuf.custreal2.stat == 0) {
                buyAdd.posNo = 5;
              }
              if (buyAdd.display == LCDISP1) {
                /* 10.4買上追加処理画面 */
                // TODO:10122 グラフィクス処理（gtk_*）
                /*
                rcLcd_Buyadd();
                gtk_widget_destroy(buyAdd.window_cst);
                 */
              }
              await rcBuyAddUIDErrProc();
              return;
            }
            break;
          }
        }
        RcMbrFlrd.cust = buyAdd.cust;
        RcMbrFlrd.enq = buyAdd.enq;
        RcMbrFlrd.custParent = dummyParent;
        RcMbrFlrd.enqParent = buyAdd.enqParent;
        RcMbrFlrd.svs = buyAdd.svs;
        iret = await RcMbrFlrd.referCust(custCd, "", "", buyAdd.mbrInput, RcMbr.RCMBR_WAIT);
        if (iret != Typ.NORMAL) {
          if (CompileFlag.ARCS_MBR) {
            if (RcSysChk.rcChkRalseCardSystem() ) {
              if (custCd[2] == '1') {
                iret = DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
              }
            }
          }
          if (iret == DlgConfirmMsgKind.MSG_OTHERMBR.dlgId) {
            if (await RcSysChk.rcCheckWatariCardSystem()) {
              if (RcMbrCom.rcChkWatariHouseCard(0)) {
                if ((cBuf.dbTrm.memUseTyp == 2) && (cBuf.dbTrm.othSaleAdd == 0)) {
                  buyAdd.watariCustCd = custCd;
                  Rcmbrkymbr.rcWatariOtherMbrDialog(DlgConfirmMsgKind.MSG_WATARI_MBRNOLIST.dlgId);
                  return;
                }
              }
            }
            await rcOtherFunc(buyAdd.posNo, custCd);
          }
          else {
            await RcExt.rcErr(callFunc, iret);
          }
          mem.tTtllog.t100700Sts.nombrmsgNo = 0;
          return;
        }
        mem.tTtllog.t100700Sts.nombrmsgNo = 0;
        iret = rcBuyAddAyahaMbrDiviChk();
        if (iret != 0) {
          await RcExt.rcErr(callFunc, iret);
          return;
        }
        if (CompileFlag.ARCS_MBR) {
          if (atSing.mbrTyp == Mcd.MCD_RLSSTAFF) {
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId);
            return;
          }
          else if ((atSing.mbrTyp == Mcd.MCD_RLSOTHER) && (await CmMbrSys.cmNewARCSSystem() != 0)) {
            buyAdd.rcptInfo = BuyAddRcptInfo();
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId);
            return;
          }
        }
        if (await RcSysChk.rcChkOneToOnePromSystem()) {
          await rcBuyAddSetOneToOneData();
        }
        buyAdd.mbrInput = 6;
        break;
      case 11: /* telephone number */
        if (!inputCheck(buyAdd.posNo, buyAdd.entryText13)) {
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
          return;
        }
        if (cBuf.dbTrm.memUseTyp == 1)	{	/* other member */
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId);
          return;
        }
        inputCd = buyAdd.entryText2;
        birthDay = buyAdd.entryText13.substring(0, 2) + buyAdd.entryText13.substring(3, 5);
        RcMbrFlrd.cust = buyAdd.cust;
        RcMbrFlrd.enq = buyAdd.enq;
        RcMbrFlrd.custParent = dummyParent;
        RcMbrFlrd.enqParent = buyAdd.enqParent;
        RcMbrFlrd.svs = buyAdd.svs;
        iret = await RcMbrFlrd.referCust("", inputCd, birthDay, buyAdd.mbrInput, RcMbr.RCMBR_WAIT);
        if (iret != Typ.NORMAL) {
          if (iret == RcMbr.RCMBR_TEL_LIST) {
            return;
          }
          else {
            await RcExt.rcErr(callFunc, iret);
            mem.tTtllog.t100700Sts.nombrmsgNo = 0;
            return;
          }
        }
        mem.tTtllog.t100700Sts.nombrmsgNo = 0;
        iret = rcBuyAddAyahaMbrDiviChk();
        if (iret != 0) {
          await RcExt.rcErr(callFunc, iret);
          return;
        }
        buyAdd.mbrInput = 4;
        break;
      case 14: /* EdyNo */
        if (!inputCheck(buyAdd.posNo, buyAdd.entryTextEdyNo))	{
          buyAdd.rcptInfo = BuyAddRcptInfo();
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
          return;
        }
        buyAdd.entryTextEdyNo = buyAdd.entryTextEdyNo.replaceAll(" ", "0");
        RcSysChk.rcClearJanInf();
        cMem.working.janInf.code = buyAdd.entryTextEdyNo;
        RcMbrFlrd.cust = buyAdd.cust;
        RcMbrFlrd.enq = buyAdd.enq;
        RcMbrFlrd.custParent = dummyParent;
        RcMbrFlrd.enqParent = buyAdd.enqParent;
        RcMbrFlrd.svs = buyAdd.svs;
        iret = await RcMbrFlrd.referCust(cMem.working.janInf.code, "", "", buyAdd.mbrInput, RcMbr.RCMBR_WAIT);
        if (iret != Typ.NORMAL) {
          if (iret == DlgConfirmMsgKind.MSG_OTHERMBR.dlgId) {
            await rcOtherFunc(buyAdd.posNo, cMem.working.janInf.code);
          }
          else {
            buyAdd.rcptInfo = BuyAddRcptInfo();
            await RcExt.rcErr(callFunc, iret);
          }
          mem.tTtllog.t100700Sts.nombrmsgNo = 0;
          return;
        }
        mem.tTtllog.t100700Sts.nombrmsgNo = 0;
        if ((iret = rcBuyAddAyahaMbrDiviChk()) != 0) {
          await RcExt.rcErr(callFunc, iret);
          return;
        }
        buyAdd.mbrInput = 2;
        break;
      default:
        break;
    }

    if (cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3) {
      if (RcSysChk.rcTROpeModeChk() || (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_TRAINING)) {
        memberRdFlg = 1;
      }
      else {
        if ((mem.tTtllog.t100700.realCustsrvFlg == 1) || (cBuf.custOffline == 2)) {
          Rcmbrrealsvr.custRealSvrOffLDlg(rcBuyAddCustRealSvrOffLDlgClr2);
          return;
        }
      }
    }
    buyAdd.posNo = 5;

    if (CompileFlag.CUSTREALSVR) {
      if (RcSysChk.rcChkCustrealsvrSystem()
          || (await RcSysChk.rcChkCustrealNecSystem(0))) {
        if (mem.tTtllog.t100700.realCustsrvFlg == 2) {
          if (cBuf.custOffline != 2) {
            memberRdFlg = 1;
          }
        }
      }
    }
    if (buyAdd.display == LCDISP1) {
      /* 10.4買上追加処理画面 */
      // TODO:10122 グラフィクス処理（gtk_*）
      /*
      rcLcd_Buyadd();
      gtk_widget_destroy(buyAdd.window_cst);
       */
    }
    if (await rcChkChgFspLvl()) {
      buyAdd.orgFspLvl = buyAdd.enqParent.s_data2;
    }
    if (RcSysChk.rcsyschkAyahaSystem() && (buyAdd.fncCode == FuncKey.KY_POINT_ADD.keyId)) {
      await byManualInputFunc();
    }
  }

  /// One To One仕様時の前回累計データをセットする
  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_Set_OneToOneData
  static Future<void> rcBuyAddSetOneToOneData() async {
    RegsMem mem = SystemFunc.readRegsMem();
    List<Map<String, int>> buyAcctData = [
      { "code": mem.custTtlTbl.acct_cd_1, "pnt": mem.custTtlTbl.acct_totalpnt_1 },
      { "code": mem.custTtlTbl.acct_cd_2, "pnt": mem.custTtlTbl.acct_totalpnt_2 },
      { "code": mem.custTtlTbl.acct_cd_3, "pnt": mem.custTtlTbl.acct_totalpnt_3 },
      { "code": mem.custTtlTbl.acct_cd_4, "pnt": mem.custTtlTbl.acct_totalpnt_4 },
      { "code": mem.custTtlTbl.acct_cd_5, "pnt": mem.custTtlTbl.acct_totalpnt_5 },
      { "code": -1, "pnt": -1 }
    ];
    List<Map<String, dynamic>> buyCustMonthData = [
      { "cnt": mem.custTtlTbl.month_visit_cnt_1, "data": mem.custTtlTbl.month_visit_date_1, "amt": mem.custTtlTbl.month_amt_1 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_2, "data": mem.custTtlTbl.month_visit_date_2, "amt": mem.custTtlTbl.month_amt_2 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_3, "data": mem.custTtlTbl.month_visit_date_3, "amt": mem.custTtlTbl.month_amt_3 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_4, "data": mem.custTtlTbl.month_visit_date_4, "amt": mem.custTtlTbl.month_amt_4 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_5, "data": mem.custTtlTbl.month_visit_date_5, "amt": mem.custTtlTbl.month_amt_5 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_6, "data": mem.custTtlTbl.month_visit_date_6, "amt": mem.custTtlTbl.month_amt_6 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_7, "data": mem.custTtlTbl.month_visit_date_7, "amt": mem.custTtlTbl.month_amt_7 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_8, "data": mem.custTtlTbl.month_visit_date_8, "amt": mem.custTtlTbl.month_amt_8 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_9, "data": mem.custTtlTbl.month_visit_date_9, "amt": mem.custTtlTbl.month_amt_9 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_10, "data": mem.custTtlTbl.month_visit_date_10, "amt": mem.custTtlTbl.month_amt_10 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_11, "data": mem.custTtlTbl.month_visit_date_11, "amt": mem.custTtlTbl.month_amt_11 },
      { "cnt": mem.custTtlTbl.month_visit_cnt_12, "data": mem.custTtlTbl.month_visit_date_12, "amt": mem.custTtlTbl.month_amt_12 },
      { "cnt": -1, "data": "", "amt": -1 }
    ];

    for (int num = 0; buyAcctData[num]["code"] != -1; num++) {
      if (buyAcctData[num]["code"] == AcctFixCodeList.ACCT_CODE_TODAY_PNT.value) {
        buyAdd.enqParent.n_data2 = buyAcctData[num]["pnt"]!;  // 前回累計ポイント
        break;
      }
    }
    String nowDate = (await DateUtil.dateTimeChange(null, DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM, DateTimeFormatKind.FT_YYYYMMDD, DateTimeFormatWay.DATE_TIME_FORMAT_ZERO)).$2;
    int ret = 0;
    DateTime nowTm;
    DateTime visitTm;
    DateTime monthTm;
    (ret, nowTm) = await DateUtil.datetimeGettm(nowDate, DateTimeChangeType.DATE_TIME_CHANGE);
    if (ret != 0) {
      return;
    }
    (ret, visitTm) = await DateUtil.datetimeGettm(mem.custTtlTbl.last_visit_date, DateTimeChangeType.DATE_TIME_CHANGE);
    if (ret != 0) {
      return;
    }
    if (nowTm.month == visitTm.month) {
      // 最終来店日が現在システム月と同一時の処理
      (ret, monthTm) = await DateUtil.datetimeGettm(buyCustMonthData[nowTm.month-1]["date"], DateTimeChangeType.DATE_TIME_CHANGE);
      if (ret == 0) {
        if (nowTm.month == monthTm.month) {
          buyAdd.enq.n_data1 = buyCustMonthData[nowTm.month-1]["amt"];  // 前回購買金額
        }
      }
    }
  }

  /// 当クラス変数buyAddをクリアする
  /// 戻り値: true=表示あり  false=表示なし
  /// 関連tprxソース: rcmbrbuyadd.c -  rcClrCustData_Buyadd
  static Future<void> rcClrCustDataBuyadd() async {
    if ((buyAdd.mbrInput != 0)
        && (!((await CmCksys.cmNimocaPointSystem() != 0) &&
            ((nimocaPointRslt == 0) && (nimocaBuyRslt == 0)))) ) {
      RcStl.rcClrTtlRBufMbr(ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_ALL);
    }
    buyAdd.cust = CCustMst();
    buyAdd.enq = SCustTtlTbl();
    buyAdd.enqParent = SCustTtlTbl();
    buyAdd.svs = PPromschMst();
    buyAdd.mbrInput = 0;
    buyAdd.otherFlg = 0;
    // TODO:10155 顧客呼出 実装対象外
    /*
    if (CompileFlag.MC_SYSTEM) {
      if (RcSysChk.rcChkMcSystem() && (buyAdd.mbrInput == 13)) {
        buyAdd.panaData = PanaData();
      }
    }
    if (CompileFlag.SAPPORO) {
      if (CmCksys.cmMatugenSystem() != 0) {
        buyAdd.mgnPanaData = PanaMatsugenData();
      }
      else if (await RcSysChk.rcChkJklPanaSystem()) {
        buyAdd.jklPanaData = PanaJklData();
      }
    }
     */
  }

  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_TrcEnd
  static Future<void> rcBuyAddTrcEnd() async {
    if (CompileFlag.REWRITE_CARD) {
      if (rwcFlg == 1) {
        rwcFlg = 0;
      }
      if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
        if (buyaddExeFlg == 0) {
          rcClrCustDataBuyadd();
        }
        if(rwcFlg == 3) {
          rwcFlg = 0;
        }
      }
      buyaddExeFlg == 0;
      if (await RcSysChk.rcChkFelicaSystem()) {
        AtSingl atSing = SystemFunc.readAtSingl();
        atSing.felica_tbl.buyadd_flg = "";
      }
    }
  }

  /// 関連tprxソース: rcmbrbuyadd.c - CheckExec
  static Future<bool> checkExec() async {
    // TODO:10096 デバドラ連携 プリンタ（rxmem.c - STAT_print_get()）
    /*
    if (((RX_TASKSTAT_PRN *)STAT_print_get(TS_BUF))->ErrCode == -1) {  /* プリンタ動作中  */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcMbrBuyAdd.checkExec(): printer busy");
      return true;
    }
     */
    if (buyaddExeFlg != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcMbrBuyAdd.checkExec(): buyadd_exec_flg up");
      return true;
    }
    else {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcMbrBuyAdd.checkExec(): buyadd_exec_flg down");
      return false;
    }
  }

  /// 買上追加画面 ポイント入力方式のチェック
  /// 戻り値: true=設定あり  false=設定無し
  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_ChkPointInp
  static Future<bool> rcBuyAddChkPointInp() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (Rxkoptcmncom.rxChkKoptAddPntAddTyp(cBuf) == 1) {	// ポイントセットタイプ
      return true;
    }
    if (CompileFlag.MC_SYSTEM) {
      // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
      /*
      if (RcSysChk.rcChkMcSystem() && (cBuf.dbMcSpec.teleFlg != 1)) {
        return true;
      }
       */
    }
    if (CompileFlag.SAPPORO) {
      if ((await RcSysChk.rcChkSapporoPanaSystem())
          || (await RcSysChk.rcChkJklPanaSystem())
          || (await CmCksys.cmMoriyaMemberSystem() != 0)
          || (CmCksys.cmMatugenSystem() == 0)) {
        return true;
      }
    }
    if (await RcSysChk.rcChkSapporoRealSystem()) {
      return true;
    }
    if (await CmCksys.cmIchiyamaMartSystem() != 0) {
      return true;
    }

    return false;
  }

  /// 入力値チェック
  /// 引数:[pos] Position No
  /// 引数:[cd] 入力値
  /// 戻り値: true=OK  false=NG
  /// 関連tprxソース: rcmbrbuyadd.c - InputCheck
  static bool inputCheck(int pos, String cd) {
    int i = 0;
    bool icc = false;

    if (pos == 1) {  //電話番号
      for (i = 0; i < cd.length; i++) {
        if ((cd[i] != " ") && (cd[i].codeUnitAt(0) != 0)) {
          icc = true;
          break;
        }
      }
      if (CompileFlag.CUSTBIRTHSERCH) {
        if (RcSysChk.rcChkCustrealsvrSystem()) {
          if ((i == 0) && !icc) {
            icc = true;
          }
          else if (cd.length <= 3) {
            icc = false;
          }
        }
      }
    }
    else if (CompileFlag.CUSTBIRTHSERCH && (pos == 11)) {
      for (i = 0; i < cd.length; i++) {
        if ((cd[i] != ' ') && (cd[i].codeUnitAt(0) != 0)) {
          icc = true;
          break;
        }
      }
    }
    else {
      for (i = 0; i < cd.length; i++) {
        if ((cd[i] != " ") && (cd[i] != "0") && (cd[i].codeUnitAt(0) != 0)) {
          icc = true;
          break;
        }
      }
    }
    return icc;
  }

  /// 関連tprxソース: rcmbrbuyadd.c - rcChk_ChgFspLvl
  static Future<bool> rcChkChgFspLvl() async {
    if (!(await RcSysChk.rcChkFspRewriteSystem())) {
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    if (cBuf.dbTrm.memAnyprcStet == 0) {
      return false;
    }
    if (await RcSysChk.rcChkFelicaSystem()) {
      return true;
    }

    return false;
  }

  /// [アヤハディオ様仕様] 会員区分で、買上追加が実行可能かチェックする
  /// 戻り値: 0=可能  0以外=不可(エラーNo)
  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_ayaha_mbr_divi_chk
  static int rcBuyAddAyahaMbrDiviChk() {
    int mbrDivi = 0;

    if (RcSysChk.rcsyschkAyahaSystem()) {
      if (buyAdd.svs.item_cd!.isNotEmpty
          && (int.tryParse(buyAdd.svs.item_cd!) != null)) {
        mbrDivi = RcFncChk.rcGetAyahaMbrDivi(int.parse(buyAdd.svs.item_cd!));
        if ((mbrDivi == 7) || (mbrDivi == 8)) {
          return DlgConfirmMsgKind.MSG_CARD_NOTUSE2.dlgId;
        }
      }
    }
    return 0;
  }

  /// [アヤハディオ様仕様] 元レシート情報入力ウィンドウ呼び出し
  /// 戻り値: 0=可能  0以外=不可(エラーNo)
  /// 関連tprxソース: rcmbrbuyadd.c - byManualInputFunc
  static Future<void> byManualInputFunc() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcMbrBuyAdd.byManualInputFunc()");
    backupPosNo = buyAdd.posNo;
    // TODO:10122 グラフィクス処理（gtk_*）
    //rcLcd_Pointadd();
  }

  /// other customer display draw
  /// 引数:[pos] Position No
  /// 引数:[cd] 入力値
  /// 関連tprxソース: rcmbrbuyadd.c - rcOtherFunc
  static Future<void> rcOtherFunc(int pos, String cd) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.othSaleAdd != 0) { /* Other member sale add ? */
      buyAdd.rcptInfo = BuyAddRcptInfo();
      await RcExt.rcErr("RcMbrBuyAdd.rcOtherFunc()", DlgConfirmMsgKind.MSG_OTHERMBR.dlgId);
      return;
    }

    AtSingl atSing = SystemFunc.readAtSingl();
    String cdNw7 = "".padLeft(CmMbrSys.cmMbrcdLen(), "0");

    if (await RcSysChk.rcChkNW7System()) {
      cdNw7 = cdNw7.substring(0, 3) + cd.substring(2, (CmMbrSys.cmMbrcdLen() - 1));
      buyAdd.cust.cust_no = cdNw7;
      atSing.useRwcRw = 2;
      if (cBuf.dbTrm.nw7mbrReal != 0) {
        RcMbrFlrd.rcMbrRealSocket();
      }
    }
    else {
      buyAdd.cust.cust_no = cd;
    }

    if ((await RcSysChk.rcChkTRCSystem())
        || (await RcSysChk.rcChkVMCSystem())
        || (await RcSysChk.rcChkSapporoPanaSystem())
        || (await RcSysChk.rcChkMcp200System())
        || (await RcSysChk.rcChkAbsV31System())) {
      buyAdd.otherFlg = 1;
      return;
    }

    switch (pos) {
      case 0:
        buyAdd.mbrInput = 3;
        break;
      case 1:
        buyAdd.mbrInput = 4;
        break;
      case 2:
        buyAdd.mbrInput = 5;
        break;
      case 3:
        buyAdd.mbrInput = 6;
        break;
      case 11:
        buyAdd.mbrInput = 4;
        break;
      case 14:
        buyAdd.mbrInput = 2;
        break;
      default:
        break;
    }
    buyAdd.otherFlg = 1;
    buyAdd.posNo = 5;

    if (buyAdd.display == LCDISP1)	{
      /* 10.4買上追加処理画面 */
      // TODO:10122 グラフィクス処理（gtk_*）
      /*
      rcLcd_Buyadd();
      gtk_widget_destroy(buyAdd.window_cst);
       */
    }
  }

  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_UID_Err_Proc
  static Future<void> rcBuyAddUIDErrProc() async {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (tsBuf.custreal2.data.uid.rec.card_stop_flg == -1) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      await RcExt.rcErr("RcMbrBuyAdd.rcBuyAddUIDErrProc()", cMem.ent.errNo);
    }
    else if ((tsBuf.custreal2.stat != 0)
        || (tsBuf.custreal2.data.uid.rec.card_stop_flg > 0)
        || (tsBuf.custreal2.data.uid.rec.card_stat_flg != 0)
        || (tsBuf.custreal2.data.uid.rec.parent_card_no != "")) {
      rcUIDDialogConfBefore();
    }
  }

  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_CustRealSvrOffL_DlgClr2
  static Future<void> rcBuyAddCustRealSvrOffLDlgClr2() async {
    String callFunc = "RcMbrBuyAdd.rcBuyAddCustRealSvrOffLDlgClr2()";
    TprDlg.tprLibDlgClear(callFunc);
    await RcExt.rcClearErrStat(callFunc);
    RcChkr.svrOfflineFlg = 0;
    Rcmbrrealsvr.svrOfflineChkFlg = 0;

    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    int fncCd = iBuf.funcCode;
    iBuf.funcCode = FuncKey.KY_CLR.keyId;
    await rcBuyAddDspEntry();
    iBuf.funcCode = fncCd;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// ディスプレイにスタンプ表示されているかチェックする
  /// 戻り値: true=表示あり  false=表示なし
  /// 関連tprxソース: rcmbrbuyadd.c - rcChk_BuyAdd_StampDisp
  static bool rcChkBuyAddStampDisp() {
    //return (buyAdd.windowStamp != null);
    return false;
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// Add point main display quit function
  /// 関連tprxソース: rcmbrbuyadd.c - byQuitFunc
  static void byQuitFunc() {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// customer number input display quit function
  /// 関連tprxソース: rcmbrbuyadd.c - rcQuitFunc
  static void rcQuitFunc() {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// from object amount to point caluculation display
  /// 関連tprxソース: rcmbrbuyadd.c - prctopoint
  static int prctopoint(int dspFlg) {
    return 0;
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加（フロント側）
  /// 指定のボタンにフォーカスをあわせる
  /// 引数: ボタンNo
  /// 関連tprxソース: rcmbrbuyadd.c - rcPressBtn
  static void rcPressBtn(int pos) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加（フロント側）
  /// FSPレベル変更用パスワード入力画面
  /// 引数: 1=表示  2=書き換え  左記以外=消去
  /// 関連tprxソース: rcmbrbuyadd.c - rcBuyAdd_FspPassword_Disp
  static void rcBuyAddFspPasswordDisp(int func) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加（フロント側）
  /// アヤハディオ様用元レシート情報ウィンドウ置数入力処理
  /// 関連tprxソース: rcmbrbuyadd.c - rcLcdPointadd_Entry
  static void rcLcdPointAddEntry() {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加（フロント側）
  /// 関連tprxソース: rcmbrbuyadd.c - rcUID_Dialog_Conf_Before
  static void rcUIDDialogConfBefore() {}
}

/// 関連tprxソース: rc_buyadd.h - BUYADD_STAMP
enum BuyAddStamp {
  BUYADD_STAMP1,
  BUYADD_STAMP2,
  BUYADD_STAMP3,
  BUYADD_STAMP4,
  BUYADD_STAMP5,
  BUYADD_STAMP_MAX
}

/// 関連tprxソース: rc_buyadd.h - Buyadd_rcptInfo
class BuyAddRcptInfo {
  int	readFlg = 0;
  int	mbrInput = 0;
  String mbrCd = "";
  int saleAmt = 0;
  int stlTaxAmt = 0;
  int stlIntaxInAmt = 0;
  int dcauMspur = 0;
  int dcautFsppur = 0;
  int outMdlclsAmt = 0;
}

/// 関連tprxソース: rc_buyadd.h - StampKind
class StampKind {
  int point = 0;
}

/// 関連tprxソース: rc_buyadd.h - Buyadd_Info
class BuyAddInfo {
  bool bAddFlg = false;
  //GtkWidget *window_psw;
  //GtkWidget *window_buy;
  //GtkWidget *window_cst;
  //GtkWidget *TitleBar;
  //GtkWidget *button1;
  //GtkWidget *button2;
  //GtkWidget *button3;
  //GtkWidget *button4;
  //GtkWidget *button5;
  //GtkWidget *button6;
  //GtkWidget *entry1;
  //GtkWidget *entry2;
  //GtkWidget *entry3;
  //GtkWidget *entry4;
  //GtkWidget *entry4P;
  //GtkWidget *entry5;
  //GtkWidget *entry6;
  //GtkWidget *com1;
  //GtkWidget *com2;
  //GtkWidget *com3;
  //GtkWidget *com4;
  //GtkWidget *com5;
  //GtkWidget *com6;
  //GtkWidget *com7;
  //GtkWidget *com8;
  //GtkWidget *com9_1;
  //GtkWidget *com9_2;
  //GtkWidget *ExitBtn;
  //GtkWidget *ExecBtn;
  //GtkWidget *IncBtn;
  //GtkWidget *IntBtn;
  //GtkWidget *EdyNoBtn;
  //GtkWidget *RewrtBtn;
  //GtkWidget *wFixed;
  //GtkWidget *bFixed1;
  //GtkWidget *bFixed2;
  //GtkWidget *Label;
  //GtkWidget *lbl1_1;
  //GtkWidget *lbl1_2;
  //GtkWidget *lbl2;
  //GtkWidget *lblbirth;
  //GtkWidget *window_fsp;
  //GtkWidget *entry_fsp;
  //GtkWidget *ManualIntBtn;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *window_point;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaCancelBtn;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *paddFixed;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaExecBtn;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaIntBtn;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaBuyDayBtn;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaBuyTimeBtn;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaBuyCountBtn;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaBuyAmtBtn;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaBuyDayEnt;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaBuyTimeEnt;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaBuyCountEnt;/* アヤハディオ様ポイント加算対応 */
  //GtkWidget *MaBuyAmtEnt;/* アヤハディオ様ポイント加算対応 */
  int fEnterPosition = 0; /* アヤハディオ様ポイント加算対応 */
  /// 呼出番号（会員入力画面）
  String entryText1 = "";
  /// 電話番号（会員入力画面）
  String entryText2 = "";
  /// 会員番号（会員入力画面）
  String entryText3 = "";
  /// 磁気カード（会員入力画面）
  String entryText4 = "";
  ///
  String entryText5 = "";
  /// 税込買上金額（買上追加画面）
  String entryText6 = "";
  /// 税抜買上金額（買上追加画面）
  String entryText7 = "";
  /// 対象額（買上追加画面）
  String entryText8 = "";
  /// ポイント（買上追加画面）
  String entryText8P = "";
  /// 期間対象額（買上追加画面）
  String entryText9 = "";
  ///
  String entryText10 = "";
  ///
  String entryText11 = "";
  /// 磁気カード（ロンフレ会員入力画面）
  String entryText12 = "";
  /// 誕生月（顧客リアルサーバー時会員入力画面）
  String entryText13 = "";
  /// Edy番号（会員入力画面）
  String entryTextEdyNo = "";
  /// お買上日（ポイント加算画面）- アヤハディオ様ポイント加算対応
  String buyDayEntTxt = "";
  /// お買上日2（ポイント加算画面）- アヤハディオ様ポイント加算対応
  String buyDayEntTxtBuf = "";
  /// お買上時刻（ポイント加算画面）- アヤハディオ様ポイント加算対応
  String buyTimeEntTxt = "";
  /// お買上点数（ポイント加算画面）- アヤハディオ様ポイント加算対応
  int buyCountEntTxt = 0;
  /// お買上金額（ポイント加算画面）- アヤハディオ様ポイント加算対応
  String buyAmtEntTxt = "";
  /// 入力データ格納用（ポイント加算画面）- アヤハディオ様ポイント加算対応
  String putData = "";
  /// 入力中確認フラグ（ポイント加算画面）- アヤハディオ様ポイント加算対応
  int fEnter = 0;
  String pass = "";
  String comText1 = "";
  String comText2 = "";
  String comText3 = "";
  String comText4 = "";
  String comText5 = "";
  String comText7 = "";
  String comText8 = "";
  String comText9_1 = "";
  String comText9_2 = "";
  /// Position number
  ///  0 - Call number btn position         : 呼出番号       （会員入力画面）
  ///  1 - Telephone number btn position    : 電話番号       （会員入力画面）
  ///  2 - Cust numbe btn position          : 会員番号       （会員入力画面）
  ///  3 - Magnetic card btn position       : 磁気カード     （会員入力画面）
  ///  5 - In-tax amount input btn position : 税込買上金額   （買上追加画面）
  ///  6 - Non-tax amount input btn position: 税抜買上金額   （買上追加画面）
  ///  7 - Amount/Point input btn position  : 対象額/ポイント（買上追加画面）
  ///  8 - Term amout  input btn position   : 期間対象額    （買上追加画面）
  ///  9 - パスワード画面
  /// 10 - パスワード画面
  /// 14 - EdyNo btn position               : Edy番号      （会員入力画面）
  /// 15 - 元レシート取引情報入力画面(ポイント加算) //アヤハディオ様ポイント加算対応
  int posNo = 0;
  /// Now display position
  int display = 0;
  /// Function Code
  int fncCode = 0;
  /// Title
  String title = "";
  ///
  String addFlg = "";
  /// DB - 顧客マスタ (c_mbrcard_mst)
  CCustMst cust = CCustMst();
  /// DB - 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  SCustTtlTbl enq = SCustTtlTbl();
  /// DB - 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  SCustTtlTbl enqParent = SCustTtlTbl();
  /// DB - プロモーションスケジュールマスタ (p_promsch_mst)
  PPromschMst svs = PPromschMst();
  ///
  int skTotalBuyRslt = 0;
  int skAnyprcTermMny = 0;
  int skTotalPoint = 0;
  int	mbrFlg = 0;
  String mName = "";
  String mPass = "";
  int mbrInput = 0;
  int otherFlg = 0;
  int rewrtFlg = 0;
  //#if MC_SYSTEM
  //PANA_DATA	panadata; /* Pana Data */
  //#endif
  //#if MC_SYSTEM || SAPPORO
  //GtkWidget	*TcktBtn;
  ///
  int tcktFlg = 0;
  //#endif
  //#if SAPPORO
  /// Jakkulu Pana Data
  //PANA_JKL_DATA	jkl_panadata;
  /// Matsugen Pana Data
  //PANA_MATSUGEN_DATA	mgn_panadata;
  //#endif
  BuyAddRcptInfo rcptInfo = BuyAddRcptInfo();
  int orgFspLvl = 0;
  int lastPosNo = 0;
  Entry lastEnt = Entry();
  String lastKEnt0 = "";
  String lastKEnt1 = "";
  //GtkWidget	*StampBtn1;
  //GtkWidget	*StampBtn2;
  //GtkWidget	*StampBtn3;
  //GtkWidget	*StampBtn4;
  //GtkWidget	*StampBtn5;
  //GtkWidget	*window_stamp;
  //GtkWidget	*stamp_fixed;
  //GtkWidget	*stamp_entry;
  var	stampBtn = List.generate(BuyAddStamp.BUYADD_STAMP_MAX.index,  (_) => StampKind());
  int stampFncCd = 0;
  int stampPoint = 0;
  //GtkWidget *CstRewrtBtn;
  String cardDataJis2 = "";
  String watariCustCd = "";
  int subFncCode = 0;
  /// 入力中のフラグ
  int inputNumFlg = 0;
  /// NIMOCA Card No
  String nimocaNumber = "";
  /// NIMOCA Card Type
  String nimocaCardType = "";
  /// NIMOCA Rct Id
  int nimocaRctId = 0;
  /// NIMOCA Act Cd
  int nimoca_act_cd = 0;
  ///
  String ayahaMbrCd = "";
  //GtkWidget *CogcaIcBtn;          /* CoGCa IC顧客読込ボタン */
  /// CoGCa IC顧客読み画面フラグ
  int icDspFlg = 0;
  //GtkWidget *MsReadBtn;           /* 磁気読込ボタン */
  //GtkWidget *FipMbrReadBtn;       /* 会員読込ボタン */
  /// 会員読込フラグ
  int inputFlg = 0;
  ///
  String nimocaRefDateTime = "";
  String nimocaRefCardKind = "";
  String nimocaRefBusiCd = "";
  String nimocaPrnDateTime = "";
  String nimocaRwId = "";
  int nimocaIcNo = 0;
  /// フレスタ様 カード忘れ取引日時(ポイント付与)
  String frestaDatetime = "";
  /// フレスタ様 照会結果 (任意コード)
  int frestaOpt = 0;
  /// フレスタ様 照会結果 (最終来店日)
  String frestaLstBuyDt = "";
  /// フレスタ様 照会結果 (顧客ランク)
  String frestaCustRank = "";
  /// フレスタ様 照会結果 (生年月日)
  String frestaBirth = "";
  /// フレスタ様 照会結果 (誕生日判定フラグ)
  String frestaBirthFg = "";
  /// フレスタ様 照会結果 (入会店舗コード)
  String frestaEntryStrId = "";
}