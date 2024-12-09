/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../fb/fb_init.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmemnttdpreca.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../lib/cm_bcd/chk_z0.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_ej/cm_ejlib.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../lib/cm_sys/cm_stf.dart';
import '../../lib/if_detect/if_detect.dart';
import '../common/rx_log_calc.dart';
import '../inc/L_rc_preca.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_nttd_preca.dart';
import '../inc/rc_regs.dart';
import 'rc_apldlg.dart';
import '../inc/rcrctfil.dart';
import 'rc_crdt_fnc.dart';
import 'rc_ewdsp.dart';
import 'rc_ext.dart';
import 'rc_flrda.dart';
import 'rc_ifevent.dart';
import 'rc_key_cash.dart';
import 'rc_mbr_com.dart';
import 'rc_set.dart';
import 'rccardcrew.dart';
import 'rcfncchk.dart';
import 'rcky_cha.dart';
import 'rcky_qctckt.dart';
import 'rcky_sus.dart';
import 'rckyccin.dart';
import 'rckycrdtvoid.dart';
import 'rcmbrpcom.dart';
import 'rcqc_com.dart';
import 'rcqc_dsp.dart';
import 'rcqr_com.dart';
import 'rcsyschk.dart';

class RcPreca {
  static Preca preca = Preca();
  static int rcGtktimerPreca = -1;

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_preca.c - rcKy_Preca_Deposit()
  static void rcKyPrecaDeposit () {
    return ;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_preca.c - rcCheck_Preca_Deposit_Item()
  static int rcCheckPrecaDepositItem () {
    return 0;
  }

  /// 置数 + プリペイドでの売上, 取消, 返品電文を送信した状態かチェック
  /// 関連tprxソース: rc_preca.c - rcCheckEntryPrecaInqu()
  /// 引数：なし
  /// 戻値：true: 送信した  false: まだ
  static bool rcCheckEntryPrecaInqu(){
    AtSingl atSing = SystemFunc.readAtSingl();
    if(atSing.entryPrecaInquFlag == 1){
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rc_preca.c - rcGet_Preca_FncCode()
  static int rcGetPrecaFncCode() {
    AcMem cMem = SystemFunc.readAcMem();
    int tmpbuf = 0;
    int fncCode;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cMem.qrChgKoptFlg == 1) {
      tmpbuf = cMem.qrChgKoptFlg;
      cMem.qrChgKoptFlg = 0;
    }

    if (Dummy.rcChkRepicaBarScantyp() == 2) {
      /* 選択画面からギフトカード選択済みかチェック */
      fncCode = Dummy.rxChkCHACHKCrdtTyp(cBuf, SPTEND_STATUS_LISTS.SPTEND_STATUS_PREPAID2);
    } else if (Dummy.rcChkRepicaCoconaCard()) {
      /* 掛売登録「する」、掛売の種類「cocona」の会計、品券キーがあるかチェック */
      fncCode = Dummy.rxChkCHACHKCrdtTyp(cBuf, SPTEND_STATUS_LISTS.SPTEND_STATUS_COCONA);
    } else {
      /* 掛売登録「する」、掛売の種類「プリペード」の会計、品券キーがあるかチェック */
      fncCode = Dummy.rxChkCHACHKCrdtTyp(cBuf, SPTEND_STATUS_LISTS.SPTEND_STATUS_PREPAID);
    }
    /* ある場合 */
    if (fncCode != -1) {
      /* 手動割戻の会計、品券キーと被るかチェック */
      if (fncCode != RcMbrPcom.rcmbrGetManualRbtKeyCd()) {
        if (tmpbuf != 0) {
          cMem.qrChgKoptFlg = tmpbuf;
        }
        return fncCode;
      }
    }
    /* 掛売登録「する」、掛売の種類「レピカ」の会計、品券キーがあるかチェック */
    fncCode = Dummy.rxChkCHACHKCrdtTyp(cBuf, SPTEND_STATUS_LISTS.SPTEND_STATUS_REPICA);
    /* ある場合 */
    if (fncCode != -1) {
      /* 手動割戻の会計、品券キーと被るかチェック */
      if (fncCode != RcMbrPcom.rcmbrGetManualRbtKeyCd()) {
        if (tmpbuf != 0) {
          cMem.qrChgKoptFlg = tmpbuf;
        }
        return fncCode;
      }
    }

    if (tmpbuf != 0) {
      cMem.qrChgKoptFlg = tmpbuf;
    }

    return 0;
  }

  /// [KY_PRECA_REF] Management Program
  /// 関連tprxソース: rc_preca.c - rcKy_Preca_Ref()
  static Future<void> rcKyPrecaRef() async {
    String callFunc = "RcPreca.rcKyPrecaRef()";
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemPtr() error");
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    AcMem cMem = SystemFunc.readAcMem();

    cMem.ent.errNo = await rcChkKyPrecaRef();
    if (cMem.ent.errNo == 0) {
      cMem.ent.errNo = await rcChkSptendType();
    }
    if (cMem.ent.errNo == 0) {
      cMem.ent.errNo = await rcChkPrecaStatus();
    }
    if (!(await RcSysChk.rcQCChkQcashierSystem()) && (cMem.ent.errNo == 0)) {
      cMem.ent.errNo = await RcFncChk.rcChkRPrinter();
    }
    if (cMem.ent.errNo != 0) {
        await rcErrProc(cMem.ent.errNo);
        return;
    }
    preca = Preca();
    await RcExt.rxChkModeSet(callFunc);

    rcGtkTimerInitPreca();

    if (cMem.ent.errNo == 0) {
      await RcExt.cashStatSet(callFunc);
      await RcSet.cashIntStatReset();
      tsBuf.nttdPreca.txData = RxMemNttdPrecaTx();
      preca.bizType = PrecaBizType.PRECA_REF.id;
      await rcPrgPrecaRef();
    }
    if (cMem.ent.errNo != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: error");
      await rcErrProc(cMem.ent.errNo);
    }
  }


  /// 関連tprxソース: rc_preca.c - rcPrg_Preca_Ref()
  static Future<void> rcPrgPrecaRef() async {
    String callFunc = "RcPreca.rcPrgPrecaRef()";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemPtr() error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xRetStat.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    rcGtkTimerRemovePreca();
    await rcDspComm(DlgConfirmMsgKind.MSG_INQUIRE.dlgId);

    tsBuf.nttdPreca.txData.trnCd = NttdPrecaSub.NTTD_PRECA_BALANCE.cd;
    CompetitionIniRet compIniRet = await CompetitionIni.competitionIniGet(await RcSysChk.getTid(), CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO, CompetitionIniType.COMPETITION_INI_GETMEM);
    tsBuf.nttdPreca.txData.dnpCd = compIniRet.value;
    await RcCardCrew.rcCardCrewCounterIni();

    tsBuf.nttdPreca.txData.persCd = (int.tryParse(cBuf.dbStaffopen.cshr_cd!) ?? 0) % 10000;
    tsBuf.nttdPreca.txData.cardId = mem.tTtllog.t100700.magMbrCd;
    tsBuf.nttdPreca.txData.money = 0;
    tsBuf.nttdPreca.txData.cstax = 0;
    tsBuf.nttdPreca.txData.goods1 = 0;
    tsBuf.nttdPreca.sub = NttdPrecaSub.NTTD_PRECA_BALANCE.cd;
    tsBuf.nttdPreca.order = NttdPrecaOrder.NTTD_PRECA_TX.index;

    cMem.ent.errNo = rcGtkTimerAddPreca(100, rcWaitResponse);
    if (cMem.ent.errNo != 0) {
      await rcGtkTimerErrPreca();
    }
  }

  /// 引数: エラーNo
  /// 関連tprxソース: rc_preca.c - rcDsp_Comm()
  static Future<void> rcDspComm(int msgNum) async {
    tprDlgParam_t	param = tprDlgParam_t();

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      RcQcCom.rcQCMovieStop();
      RcQcCom.rcQCSoundStop();
    }

    param.erCode = msgNum;
    param.dialogPtn= DlgPattern.TPRDLG_PT8.dlgPtnId;
    TprLibDlg.tprLibDlg2("RcPreca.rcDspComm", param);
    if (FbInit.subinitMainSingleSpecialChk()) {
      param.dual_dsp = 3;
      TprLibDlg.tprLibDlg2("RcPreca.rcDspComm", param);
    }
  }

  /// 戻り値: エラーNo
  /// 関連tprxソース: rc_preca.c - rcChk_Ky_Preca_Ref()
  static Future<int> rcChkKyPrecaRef() async {
    int errNo = 0;

    if (!(await RcSysChk.rcChkNTTDPrecaSystem())) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if ((errNo == 0) && RcFncChk.rcCheckScanCheck()) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && RcSysChk.rcCheckKyIntIn(true)) {
      errNo = DlgConfirmMsgKind.MSG_OPEINTERERR.dlgId;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if ((errNo == 0) && RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId])) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    /* CHECK_MULTI */
    if ((errNo == 0) && RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId])) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.tTtllog.t100001Sts.sptendCnt != 0) {
      errNo = Typ.OK;
    }
    if ((errNo == 0) && RcFncChk.rcChkTenOn()) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    return errNo;
  }

  /// 戻り値: エラーNo
  /// 関連tprxソース: rc_preca.c - rcChk_Sptend_Type()
  static Future<int> rcChkSptendType() async {
    RegsMem mem = SystemFunc.readRegsMem();

    if (!RcFncChk.rcCheckRegistration()) {
      return Typ.OK;
    }
    if (mem.tTtllog.t100001Sts.sptendCnt == 0) {
      return Typ.OK;
    }
    for (int num = 0; num < SPTEND_MAX; num++) {
      if (await rcChkSptendCrdtEnbleFlg(mem.tTtllog.t100100[num].sptendCd)) {
        return DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
      }
    }

    return Typ.OK;
  }

  /// 関連tprxソース: rc_preca.c - rcChk_sptend_crdt_enble_flg()
  static Future<bool> rcChkSptendCrdtEnbleFlg(int sptendCd) async {
    KopttranBuff kopttranBuff = KopttranBuff();

    if (sptendCd == 0) {
      return true;
    }
    await RcFlrda.rcReadKopttran(sptendCd, kopttranBuff);
    if (kopttranBuff.crdtEnbleFlg == 1) {
      return false;
    }

    return true;
  }

  /// 戻り値: エラーNo
  /// 関連tprxソース: rc_preca.c - rcChk_Preca_Status()
  static Future<int> rcChkPrecaStatus() async {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcPreca.rcChkPrecaStatus(): rxMemPtr() error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    if (tsBuf.nttdPreca.stat == NttdPrecaResultRx.NTTD_PRECA_KEY_NG.cd) {
      return DlgConfirmMsgKind.MSG_PRECA_KEY_NG.dlgId;	/* プリカ鍵配信処理を行ってください。 */
    }
    return Typ.OK;
  }

  /// 関連tprxソース: rc_preca.c - rcErr_Proc()
  static Future<void> rcErrProc(int errNo) async {
    tprDlgParam_t param = tprDlgParam_t();

    if (errNo == DlgConfirmMsgKind.MSG_CHECK_HELP_DESK.dlgId) {
      rcEJPrecaUnknown();
    }

    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = "RcPreca.rcErrProc()";
    if (errNo != 0) {
      if (await RcFncChk.rcCheckCrdtVoidMode()) {
        await RcKyCrdtVoid.rcCrdtVoidDialogErr(errNo, 1, "");
      }
      else {
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          RcqrCom.rcQRSystemTxtMemInit();
          await RcExt.rxChkModeReset(callFunc);
        }
        cMem.ent.errNo = errNo;
        await RcExt.rcErr(callFunc, cMem.ent.errNo);
      }
      await RcIfEvent.rxChkTimerAdd();
    }
    else {
      param.dialogPtn = DlgPattern.TPRDLG_PT4.dlgPtnId;
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_CHECKER:
          break;
        case RcRegs.KY_DUALCSHR:
          param.dual_dev = 1;
          break;
        case RcRegs.KY_SINGLE:
          if (cMem.stat.dualTSingle == 1) {
            param.dual_dsp = 2;
            param.dual_dev = 1;
          }
          break;
        default:
          break;
      }
      TprLibDlg.TprLibDlgSnd(param);
    }
    if (await RcFncChk.rcCheckCrdtVoidSMode()) {
      RcKyCrdtVoid.rcCrdtVoidActFlgReset();
    }
  }

  /// 関連tprxソース: rc_preca.c - rcEJ_Preca_Unknown()
  static Future<void> rcEJPrecaUnknown() async {
    String filename = "";
    String erlog = "";
    File fp;
    String staffCdBuf = "";
    String spcBuf = "";

    // ファイル名取得
    filename =
        "${EnvironmentData.TPRX_HOME}${CmEj.EJ_WORK_DIR}${CmEj.EJ_WORK_FILE}";

    // ファイルオープン
    fp = File(filename);
    // ファイルの存在確認
    if (!fp.existsSync()) {
      try {
        // ファイルがなければ作成
        fp.createSync();
      } catch (e) {
        // ファイルが作成できない場合はエラーログを出力
        erlog = "rcEJPrecaUnknown() File($filename) $e\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, erlog);
        return;
      }
    }

    // cMemを確認しオペレーションモードを確認, それによりファイル出力する文字列を変更
    AcMem cMem = SystemFunc.readAcMem();
    switch (cMem.stat.opeMode) {
      case RcRegs.RG:
        fp.writeAsStringSync("1\n", flush: true);
        break;
      case RcRegs.TR:
        fp.writeAsStringSync("2\n", flush: true);
        break;
      case RcRegs.VD:
        fp.writeAsStringSync("3\n", flush: true);
        break;
      default:
        fp.writeAsStringSync("4\n", flush: true);
        break;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    String tmpStaffCd = cBuf.dbStaffopen.cshr_cd ?? "";
    dynamic staffCd = int.tryParse(tmpStaffCd);
    staffCd ??= 0;
    (staffCdBuf, _) =
        await CmStf.apllibStaffCdEdit(await RcSysChk.getTid(), 3, staffCd, 0);
    spcBuf = " " * (11 - await CmStf.apllibStaffCDInputLimit(2));
    erlog = "$spcBuf$staffCdBuf ${cBuf.dbStaffopen.cshr_name}";
    EjLib().cmEjWriteString(fp, writePosi.EJ_LEFT.index, erlog);

    EjLib().cmEjWriteString(fp, writePosi.EJ_LEFT.index, " ");

    EjLib().cmEjWriteString(
        fp, writePosi.EJ_CENTER.index, LRcPreca.PRECA_UNKNOWN_1);

    PrecaBizType bizType = PrecaBizType.values
        .firstWhere((element) => element.id == preca.bizType);
    switch (bizType) {
      case PrecaBizType.PRECA_SALES:
        erlog = "    ${LRcPreca.TTL_PRECA}";
        break;
      case PrecaBizType.PRECA_SALES_VOID:
        erlog = "    ${LRcPreca.TTL_PRECA_VOIID}";
        break;
      case PrecaBizType.PRECA_DEPOSIT_CHANGE:
        erlog = "    ${LRcPreca.TTL_PRECA_CIN}";
        break;
      case PrecaBizType.PRECA_DEPOSIT_CHANGE_VOID:
        erlog = "    ${LRcPreca.TTL_PRECA_CIN_VOID}";
        break;
      case PrecaBizType.PRECA_DEPOSIT_ITEM:
        erlog = "    ${LRcPreca.TTL_PRECA_DEPOSIT}";
        break;
      case PrecaBizType.PRECA_DEPOSIT_ITEM_VOID:
        erlog = "    ${LRcPreca.TTL_PRECA_DEPOSIT_VOID}";
      default:
        break;
    }
    EjLib().cmEjWriteString(fp, writePosi.EJ_LEFT.index, erlog);

    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    erlog = "    ${LRcPreca.PRECA_SLIP_NUM}    ${tsBuf.nttdPreca.txData.dnpCd}";
    EjLib().cmEjWriteString(fp, writePosi.EJ_LEFT.index, erlog);

    if (cMem.stat.opeMode == RcRegs.VD) {
      erlog =
          "    ${LRcPreca.PRECA_SLIP_NUM_ORG}  ${RegsMem().tCrdtLog[0].t400000.posReceiptNo}";
      EjLib().cmEjWriteString(fp, writePosi.EJ_LEFT.index, erlog);
    }

    erlog =
        "    ${LRcPreca.PRECA_AMOUNT}        ${tsBuf.nttdPreca.txData.money}";
    EjLib().cmEjWriteString(fp, writePosi.EJ_LEFT.index, erlog);

    erlog =
        "    ${LRcPreca.PRECA_CARDID}    " "${tsBuf.nttdPreca.txData.cardId}"
            .padLeft(16);
    EjLib().cmEjWriteString(fp, writePosi.EJ_LEFT.index, erlog);

    EjLib().cmEjWriteString(
        fp, writePosi.EJ_CENTER.index, LRcPreca.PRECA_UNKNOWN_2);

    EjLib().cmEjOther();
    EjLib().cmEjCountup();

    return;
  }

  /// 関連tprxソース: rc_preca.c - rcGtkTimerInit_Preca()
  static void rcGtkTimerInitPreca() {
    rcGtktimerPreca = -1;
  }

  /// 戻り値: エラーNo
  /// 関連tprxソース: rc_preca.c - rcGtkTimerAdd_Preca()
  static int rcGtkTimerAddPreca(int timer, Function func) {
    if (rcGtktimerPreca != -1) {
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }
    rcGtktimerPreca = Fb2Gtk.gtkTimeoutAdd(timer, func, 0);
    return Typ.OK;
  }

  /// 関連tprxソース: rc_preca.c - rcGtkTimerRemove_Preca()
  static void rcGtkTimerRemovePreca() {
    if (rcGtktimerPreca != -1) {
      Fb2Gtk.gtkTimeoutRemove(rcGtktimerPreca);
      rcGtkTimerInitPreca();
    }
  }

  /// 関連tprxソース: rc_preca.c - rcGtkTimerErr_Preca()
  static Future<void> rcGtkTimerErrPreca() async {
    String callFunc = "RcPreca.rcGtkTimerErrPreca()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, callFunc);
    rcGtkTimerRemovePreca();
    TprDlg.tprLibDlgClear(callFunc);
    RcApldlg.rcAplDlgClear();
    AcMem cMem = SystemFunc.readAcMem();
    await RcExt.rcErr(callFunc, cMem.ent.errNo);
    await RcExt.rxChkModeReset(callFunc);
    await RcIfEvent.rcWaitSave();
    if (SystemFunc.ifSave.count != 0) {
      SystemFunc.ifSave = IfWaitSave();
    }
  }

  /// 関連tprxソース: rc_preca.c - rcChk_Sus()
  static Future<int> rcChkSus() async {
    if (await RckySus.rcCheckSuspend() == RcRctFil.RCRCT_OK) {
      return Typ.NG;
    }

    if (await RcSysChk.rcChkMultiSuspendSystem()) {
      return Typ.NG;
    }

    if (CompileFlag.ARCS_MBR) {
      if ((await RcMbrCom.rcChkCrdtReceipt(0)) ||
          (RcMbrCom.rcChkCha9Receipt() != -1) ||
          (await RcMbrCom.rcChkIDReceipt() != -1) ||
          (await RcMbrCom.rcChkPrepaidReceipt() != -1) ||
          (await RcMbrCom.rcChkQUICPayReceipt() != -1)) {
        return Typ.NG;
      }
    }

    return Typ.OK;
  }

  /// 関連tprxソース: rc_preca.c - rcWait_Response()
  static Future<void> rcWaitResponse() async {
    rcGtkTimerRemovePreca();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    NttdPrecaOrder order = NttdPrecaOrder.values
        .firstWhere((element) => element.index == tsBuf.nttdPreca.order);
    switch (order) {
      case NttdPrecaOrder.NTTD_PRECA_TX:
        cMem.ent.errNo = rcGtkTimerAddPreca(100, rcWaitResponse);
        if (cMem.ent.errNo != 0) {
          rcGtkTimerErrPreca();
        }
        break;

      case NttdPrecaOrder.NTTD_PRECA_RX:
        // ダイアログのクリア処理
        RcApldlg.rcAplDlgClear();
        if (tsBuf.nttdPreca.rxData.trnCd ==
            NttdPrecaResultRx.NTTD_PRECA_BEFORE_VOID_OK.cd) {
          await RcExt.rcClearErrStat("rcWaitResponse");
          if (await RcSysChk.rcQCChkQcashierSystem()) {
            PrecaBizType bizType = PrecaBizType.values
                .firstWhere((element) => element.id == preca.bizType);
            switch (bizType) {
              case PrecaBizType.PRECA_SALES:
                rcPrgPrecaSales();
                break;
              case PrecaBizType.PRECA_DEPOSIT_CHANGE:
              case PrecaBizType.PRECA_DEPOSIT_ITEM:
                rcPrgPrecaCin();
                break;
              default:
                cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPTERROR_AGAIN.dlgId;
                rcErrProc(cMem.ent.errNo);
                break;
            }
          } else {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPTERROR_AGAIN.dlgId;
            rcErrProc(cMem.ent.errNo);
          }
          break;
        }

        NttdPrecaSub nttdPrecaSub = NttdPrecaSub.values
            .firstWhere((element) => element.cd == tsBuf.nttdPreca.sub);
        switch (nttdPrecaSub) {
          case NttdPrecaSub.NTTD_PRECA_BALANCE:
            preca.zanBefore = tsBuf.nttdPreca.rxData.zanBefore;
            if (preca.bizType == PrecaBizType.PRECA_SALES.id) {
              if (preca.zanBefore == 0) {
                if (await RcSysChk.rcQRChkPrintSystem() &&
                    (tsBuf.qcConnect.ConMax > 0) &&
                    (await rcChkSus() == Typ.OK)) {
                  rcDspConfQRZero();
                } else {
                  cMem.ent.errNo = DlgConfirmMsgKind.MSG_BALANCE_ZERO.dlgId;
                  rcErrProc(cMem.ent.errNo);
                }
              } else if (await RcSysChk.rcQRChkPrintSystem() &&
                  (tsBuf.qcConnect.ConMax > 0) &&
                  (await rcChkSus() == Typ.OK) &&
                  (preca.zanBefore >= RcCrdtFnc.payPrice())) {
                rcDspConfQRSlct();
              } else {
                rcPrgPrecaSales();
              }
            } else if ((cMem.stat.fncCode == FuncKey.KY_QC_TCKT.keyId) ||
                (cMem.stat.fncCode == FuncKey.KY_QCSELECT.keyId) ||
                (cMem.stat.fncCode == FuncKey.KY_QCSELECT2.keyId) ||
                (cMem.stat.fncCode == FuncKey.KY_QCSELECT3.keyId)) {
              if ((preca.zanBefore + RegsMem().tTtllog.calcData.stlIntaxInAmt) >
                  50000) {
                cMem.ent.errNo = DlgConfirmMsgKind.MSG_CHARG_OVER_LIMIT.dlgId;
                rcErrProc(cMem.ent.errNo);
              } else {
                cMem.ent.errNo = await RckyQctckt.rcPrgKyQCTckt();
                if (cMem.ent.errNo != 0) {
                  rcErrProc(cMem.ent.errNo);
                }
              }
            } else {
              rcDspConfBalance();
            }
            break;

          case NttdPrecaSub.NTTD_PRECA_CHARGE:
            if (preca.bizType == PrecaBizType.PRECA_DEPOSIT_CHANGE.id){
              await rcSetChangeAmt();
            }else if (preca.bizType == PrecaBizType.PRECA_DEPOSIT_ITEM.id) {
              rcSetItemAmt();
            }
            await rcDspConfClearATCT();
            break;

          case NttdPrecaSub.NTTD_PRECA_SALES:
            tsBuf.nttdPreca.rxData.zanBefore = preca.zanBefore;
          case NttdPrecaSub.NTTD_PRECA_CHARGE_VOID:
          case NttdPrecaSub.NTTD_PRECA_SALES_VOID:
            await rcAfterSalesVoid();
            break;

          default:
            break;
        }
        break;

      case NttdPrecaOrder.NTTD_PRECA_NOT_ORDER:
        // ダイアログのクリア処理
        RcApldlg.rcAplDlgClear();
        await RcExt.rcClearErrStat("rcWaitResponse");

        if (tsBuf.nttdPreca.sub != NttdPrecaSub.NTTD_PRECA_BALANCE.cd) {
          if (tsBuf.nttdPreca.rxData.errCd[0] != 'U') {
            preca.beforeVoidCnt++;
            if (preca.beforeVoidCnt > 2) {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_CHECK_HELP_DESK.dlgId;
              rcErrProc(cMem.ent.errNo);
              break;
            }
            await rcPrgPrecaBeforeVoid();
            break;
          }
        }

        AtSingl atSing = SystemFunc.readAtSingl();
        if (tsBuf.nttdPreca.rxData.errCd[0] == 'U') {
          atSing.addErrorCd = tsBuf.nttdPreca.rxData.errCd;
        } else {
          atSing.addErrorCd = "";
        }

        if (tsBuf.nttdPreca.txData.trnCd == NttdPrecaSub.NTTD_PRECA_BEFORE_VOID.cd) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_CHECK_HELP_DESK.dlgId;
        } else if (!tsBuf.nttdPreca.rxData.errCd.startsWith("U24")) {
          // over last sprit tendering chance ?
          if (RegsMem().tTtllog.t100001Sts.sptendCnt >= (SPTEND_MAX - 1)) {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_LASTBUF.dlgId;
          } else if (preca.bizType == PrecaBizType.PRECA_SALES.id) {
            preca.lackCardBalance = tsBuf.nttdPreca.rxData.zan;
            if (RcFncChk.rcCheckQCashierMode()) {
              if (RcFncChk.rcQCCheckStartDspMode()) {
                atSing.addErrorCd = "";
                await rcPrgPrecaSalesUseAll();
                return;
              } else if ((RegsMem().tmpbuf.autoCallReceiptNo != 0 &&
                      RegsMem().tmpbuf.autoCallMacNo != 0) &&
                  (RegsMem().tmpbuf.autoCallReceiptNo ==
                      RcqrCom.qrReadReptNo) &&
                  (RegsMem().tmpbuf.autoCallMacNo == RcqrCom.qrReadMacNo) &&
                  !RcFncChk.rcQCCheckStartDspMode()) {
                atSing.addErrorCd = "";
                await rcPrgPrecaSalesUseAll();
                return;
              } else {
                cMem.ent.errNo = DlgConfirmMsgKind.MSG_BALANCE_SHORT.dlgId;
              }
            } else if (await RcSysChk.rcQRChkPrintSystem()) {
              atSing.addErrorCd = "";
              rcDspConfQR();
              return;
            } else {
              rcDspConfLack();
              atSing.addErrorCd = "";
            }
          } else {
            cMem.ent.errNo = DlgConfirmMsgKind.MSG_BALANCE_SHORT.dlgId;
          }
        } else if (!tsBuf.nttdPreca.rxData.errCd.startsWith("U20")) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_PRECA_ERR_U20.dlgId;
        } else if (!tsBuf.nttdPreca.rxData.errCd.startsWith("U21")) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_PRECA_ERR_U21.dlgId;
        } else if (!tsBuf.nttdPreca.rxData.errCd.startsWith("U22")) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_GOODTHRUERR.dlgId;
        } else if (!tsBuf.nttdPreca.rxData.errCd.startsWith("U23")) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_CHARG_OVER_LIMIT.dlgId;
        } else if (!tsBuf.nttdPreca.rxData.errCd.startsWith("U32")) {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_CORR_TRAN_NG.dlgId;
        } else {
          cMem.ent.errNo = DlgConfirmMsgKind.MSG_TEXT12.dlgId;
        }
        rcErrProc(cMem.ent.errNo);
        break;

      default:
        break;
    }
  }

  /// 関連tprxソース: rc_preca.c - rcPrg_Preca_Sales()
  static Future<void> rcPrgPrecaSales() async {
    int nttaspCreditNo;
    String log = "";

    rcGtkTimerRemovePreca();

    log = "rcPrgPrecaSales():";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    // ダイアログのクリア処理
    TprDlg.tprLibDlgClear("rcPrgPrecaSales()");
    RcApldlg.rcAplDlgClear();

    rcDspComm(DlgConfirmMsgKind.MSG_INQUIRE.dlgId);

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    tsBuf.nttdPreca.txData.trnCd = NttdPrecaSub.NTTD_PRECA_SALES.cd;
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        await RcSysChk.getTid(),
        CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    nttaspCreditNo = ret.value;
    tsBuf.nttdPreca.txData.dnpCd = nttaspCreditNo;
    await RcCardCrew.rcCardCrewCounterIni();

    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    int cshrCd = int.parse(cBuf.dbStaffopen.cshr_cd ?? "0");
    tsBuf.nttdPreca.txData.persCd = cshrCd % 10000;

    tsBuf.nttdPreca.txData.cardId =
        RegsMem().tTtllog.t100700.magMbrCd.substring(0, 12) +
            tsBuf.nttdPreca.txData.cardId.substring(12);
    tsBuf.nttdPreca.txData.money = RcCrdtFnc.payPrice();
    tsBuf.nttdPreca.txData.cstax = RxLogCalc.rxCalcInTaxAmt(RegsMem());
    tsBuf.nttdPreca.sub = NttdPrecaSub.NTTD_PRECA_SALES.cd;
    tsBuf.nttdPreca.order = NttdPrecaOrder.NTTD_PRECA_TX.index;

    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.errNo = rcGtkTimerAddPreca(100, rcWaitResponse);
    if (cMem.ent.errNo != 0) {
      rcGtkTimerErrPreca();
    }
  }

  /// 関連tprxソース: rc_preca.c - rcPrg_Preca_Cin()
  static Future<void> rcPrgPrecaCin() async {
    String tmp = "";
    int nttaspCreditNo = 0;
    String log = "rcPrgPrecaCin():";
    AtSingl atSing = SystemFunc.readAtSingl();

    rcGtkTimerRemovePreca();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    if (await RcSysChk.rcChkNTTDPrecaSystem() &&
        (RcFncChk.rcCheckQCashierMode()) &&
        (atSing.qcSelectWinFlg == 1)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "PRECA_DEPOSIT_CHANGE: Charge Btn Push");
      RcQcDsp.rcQCChargeBtnHide();
      atSing.qcSelectWinFlg = 2;
      RcQcCom.rcQCSoundStop();
      await IfDetect.ifDetectDisable();
      await RcExt.rxChkModeSet("rcPrgPrecaCin");
		  RcQcDsp.qcCashDispCntEnd();
    } else {
      // ダイアログのクリア処理
      TprDlg.tprLibDlgClear("rcPrgPrecaCin()");
    }
    rcDspComm(DlgConfirmMsgKind.MSG_INQUIRE.dlgId);

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    tsBuf.nttdPreca.txData.trnCd = NttdPrecaSub.NTTD_PRECA_CHARGE.cd;
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        await RcSysChk.getTid(),
        CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    nttaspCreditNo = ret.value;
    tsBuf.nttdPreca.txData.dnpCd = nttaspCreditNo;
    await RcCardCrew.rcCardCrewCounterIni();

    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    int cshrCd = int.parse(cBuf.dbStaffopen.cshr_cd ?? "0");
    tsBuf.nttdPreca.txData.persCd = cshrCd % 10000;

    tsBuf.nttdPreca.txData.cardId =
        RegsMem().tTtllog.t100700.magMbrCd.substring(0, 12) +
            tsBuf.nttdPreca.txData.cardId.substring(12);
    tsBuf.nttdPreca.txData.cstax = RxLogCalc.rxCalcInTaxAmt(RegsMem());
    if (preca.bizType == PrecaBizType.PRECA_DEPOSIT_ITEM.id) {
      tmp = RegsMem().tItemLog[0].t10000.pluCd1_1;
      tsBuf.nttdPreca.txData.goods1 = int.parse(tmp);
    }
    tsBuf.nttdPreca.sub = NttdPrecaSub.NTTD_PRECA_CHARGE.cd;
    tsBuf.nttdPreca.order = NttdPrecaOrder.NTTD_PRECA_TX.index;

    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.errNo = rcGtkTimerAddPreca(100, rcWaitResponse);
    if (cMem.ent.errNo != 0) {
      rcGtkTimerErrPreca();
    }
  }

  // TODO: 松岡 未実装、フロント処理のため定義のみ追加
  /// 残高が0円の時にダイアログを表示する
  /// 関連tprxソース: rc_preca.c - rcDsp_Conf_QR_Zero()
  static void rcDspConfQRZero() {
  }

  // TODO: 松岡 未実装、フロント処理のため定義のみ追加
  /// プリカ支払い画面の表示
  /// 関連tprxソース: rc_preca.c - rcDsp_Conf_QR_Slct()
  static void rcDspConfQRSlct() {
  }

  // TODO: 松岡 未実装、フロント処理のため定義のみ追加
  /// プリカ残高照会の表示
  /// 関連tprxソース: rc_preca.c - rcDsp_Conf_Balance()
  static void rcDspConfBalance() {
  }

  /// 関連tprxソース: rc_preca.c - rcSet_Change_Amt()
  static Future<void> rcSetChangeAmt() async {
    RegsMem mem = RegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    // 全タスク共通メモリが読み込めない場合はエラー
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcDetectPrecaRef: rxMemRead is invalid.\n");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    mem.tTtllog.t100001Sts.chrgFlg = 1;
    mem.tTtllog.t100900.todayChgamt = tsBuf.nttdPreca.rxData.money;
    mem.tTtllog.t100900.vmcChgCnt = 1;
  }

  /// 関連tprxソース: rc_preca.c - rcSet_Item_Amt()
  static Future<void> rcSetItemAmt() async {
    RegsMem mem = RegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    // 全タスク共通メモリが読み込めない場合はエラー
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcDetectPrecaRef: rxMemRead is invalid.\n");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    mem.tTtllog.t100001Sts.chrgFlg = 0;
    mem.tTtllog.t100900.todayChgamt = tsBuf.nttdPreca.rxData.money;
    mem.tTtllog.t100900.vmcChgCnt = 1;
  }

  /// 関連tprxソース: rc_preca.c - rcDsp_Conf_Clear_ATCT()
  static Future<void> rcDspConfClearATCT() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    String funcName = "rcDspConfClearATCT";
    AcMem cMem = SystemFunc.readAcMem();
    String log =
        "rcDsp_Conf_Clear_ATCT:AT_SING->charge_slip_flg:${atSing.qcSelectWinFlg}";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    rcGtkTimerRemovePreca();

    log = "$funcName:";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    if (!RcFncChk.rcCheckRegistration()) {
      RcSet.cashStatReset2(funcName);
    }
    await RcSet.cashIntStatSet();
    if (await RcSysChk.rcChkNTTDPrecaSystem() &&
        (RcFncChk.rcCheckQCashierMode()) &&
        (atSing.qcSelectWinFlg == 1)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "PRECA_DEPOSIT_CHANGE: Return Btn Push");
      RcQcDsp.rcQCChargeBtnHide();
      atSing.qcSelectWinFlg = 3;
      RcQcCom.rcQCSoundStop();
      cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
      RcKyccin.rcChgCinDspEntry();
      await IfDetect.ifDetectDisable();
      RcExt.rxChkModeSet(funcName);
      RcQcDsp.qcCashDispCntEnd();
    } else if (await RcSysChk.rcChkNTTDPrecaSystem() &&
        (RcFncChk.rcCheckQCashierMode()) &&
        (atSing.qcSelectWinFlg == 2)) {
      atSing.qcSelectWinFlg = 4;
      cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
      RcKyccin.rcChgCinDspEntry();
    } else {
      // ダイアログのクリア処理
      RcApldlg.rcAplDlgClear();
    }
    if (await RcFncChk.rcCheckCrdtVoidSMode()) {
      RcKyCrdtVoid.rcCrdtVoidActFlgReset();
    }

    PrecaBizType bizType = PrecaBizType.values
        .firstWhere((element) => element.id == preca.bizType);
    switch (bizType) {
      case PrecaBizType.PRECA_DEPOSIT_CHANGE:
      case PrecaBizType.PRECA_DEPOSIT_ITEM:
        await RcKeyCash().rcCashAmount();
        return;
      default:
        break;
    }
  }

  /// 関連tprxソース: rc_preca.c - rcAfter_Sales_Void()
  static Future<void> rcAfterSalesVoid() async {
    rcGtkTimerRemovePreca();

    // ダイアログのクリア処理の確認
    RcApldlg.rcAplDlgClear();

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    // 全タスク共通メモリが読み込めない場合はエラー
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcAfterSalesVoid: rxMemRead is invalid.\n");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    RcIfEvent.rcWaitSave();
    if (RcRegs.ifSave.count != 0) {
      RcRegs.ifSave = IfWaitSave();
    }

    if (await RcFncChk.rcCheckCrdtVoidSMode() ||
        await RcFncChk.rcCheckCrdtVoidIMode()) {
      await RcKyCrdtVoid.crdtVoidClear();
      await RcIfEvent.rxChkTimerAdd(); /* キー入力許可     */
      await RcKyCrdtVoid.rcCrdtVoidExecFunc();
    } else if (preca.bizType == PrecaBizType.PRECA_DEPOSIT_CHANGE.id) {
      cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
      await RcKeyCash().rcCashAmount();
    } else {
      String bcd =
          Ltobcd.cmLtobcd(tsBuf.nttdPreca.rxData.money, cMem.ent.entry.length);
      for (int i = 0; i < cMem.ent.entry.length; i++) {
        // 文字列bcdを文字コードに変換して代入
        cMem.ent.entry[i] = bcd.codeUnits[i];
      }
      cMem.ent.tencnt =
          ChkZ0.cmChkZero0(cMem.ent.entry);
      cMem.stat.fncCode = rcGetPrecaFncCode();
      await RckyCha.rcChargeAmount1();
    }

    return;
  }

  /// 関連tprxソース: rc_preca.c - rcPrg_Preca_Before_Void()
  static Future<void> rcPrgPrecaBeforeVoid() async {
    int nttaspCreditNo;

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = RegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    // 全タスク共通メモリが読み込めない場合はエラー
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcAfterSalesVoid: rxMemRead is invalid.\n");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcPrgPrecaBeforeVoid() start\n");

    RcEwdsp.rcErrNoBz(DlgConfirmMsgKind.MSG_PLEASE_WAITING);

    tsBuf.nttdPreca.txData.trnCd = NttdPrecaSub.NTTD_PRECA_BEFORE_VOID.cd;

    if (preca.beforeVoidCnt == 1) {
      tsBuf.nttdPreca.txData.rednpCd = tsBuf.nttdPreca.txData.dnpCd;
    }

    nttaspCreditNo = 0;
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        await RcSysChk.getTid(),
        CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    nttaspCreditNo = ret.value;
    tsBuf.nttdPreca.txData.dnpCd = nttaspCreditNo;
    await RcCardCrew.rcCardCrewCounterIni();

    tsBuf.nttdPreca.txData.cardId =
        mem.tTtllog.t100700.magMbrCd.substring(0, 12) +
            tsBuf.nttdPreca.txData.cardId.substring(12);
    tsBuf.nttdPreca.order = NttdPrecaOrder.NTTD_PRECA_TX.index;

    cMem.ent.errNo = rcGtkTimerAddPreca(100, rcWaitResponse);
    if (cMem.ent.errNo != 0) {
      await rcGtkTimerErrPreca();
    }

    return;
  }

  /// 関連tprxソース: rc_preca.c - rcPrg_Preca_Sales_Use_All()
  static Future<void> rcPrgPrecaSalesUseAll() async {
    int nttaspCreditNo;
    String log = "";
    String callFunc = "RcPreca.rcPrgPrecaSalesUseAll()";
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = RegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    // 全タスク共通メモリが読み込めない場合はエラー
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "$callFunc: rxMemRead is invalid.\n");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    rcGtkTimerRemovePreca();

    log = "$callFunc:";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    TprDlg.tprLibDlgClear(callFunc);
    RcApldlg.rcAplDlgClear();

    rcDspComm(DlgConfirmMsgKind.MSG_INQUIRE.dlgId);

    tsBuf.nttdPreca.txData = RxMemNttdPrecaTx();
    preca.bizType = PrecaBizType.PRECA_SALES.id;

    tsBuf.nttdPreca.txData.trnCd = NttdPrecaSub.NTTD_PRECA_SALES.cd;
    nttaspCreditNo = 0;
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        await RcSysChk.getTid(),
        CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    nttaspCreditNo = ret.value;
    tsBuf.nttdPreca.txData.dnpCd = nttaspCreditNo;
    await RcCardCrew.rcCardCrewCounterIni();

    int cshrCd = int.parse(cBuf.dbStaffopen.cshr_cd ?? "0");
    tsBuf.nttdPreca.txData.persCd = cshrCd % 10000;

    tsBuf.nttdPreca.txData.cardId =
        mem.tTtllog.t100700.magMbrCd.substring(0, 12) +
            tsBuf.nttdPreca.txData.cardId.substring(12);
    tsBuf.nttdPreca.txData.money = preca.lackCardBalance;
    tsBuf.nttdPreca.txData.cstax = RxLogCalc.rxCalcInTaxAmt(mem);
    tsBuf.nttdPreca.sub = NttdPrecaSub.NTTD_PRECA_SALES.cd;
    tsBuf.nttdPreca.order = NttdPrecaOrder.NTTD_PRECA_TX.index;

    cMem.ent.errNo = rcGtkTimerAddPreca(100, rcWaitResponse);
    if (cMem.ent.errNo != 0) {
      rcGtkTimerErrPreca();
    }
  }

  // TODO: 松岡 未実装、フロント処理のため定義のみ追加
  /// プリカ残高不足画面の表示
  /// 関連tprxソース: rc_preca.c - rcDsp_Conf_QR()
  static void rcDspConfQR() {
    return;
  }

  // TODO: 松岡 未実装、フロント処理のため定義のみ追加
  /// プリカ残高が残高不足かつ残高全額を利用する場合の表示
  /// 関連tprxソース: rc_preca.c - rcDsp_Conf_Lack()
  static void rcDspConfLack() {
    return;
  }
}

/// 関連tprxソース: rc_preca.c - PRECA
class Preca {
  int bizType = 0;
  int fncCode = 0;
  int zanBefore = 0;
  int lackCardBalance = 0;
  int beforeVoidCnt = 0;
}

/// 関連tprxソース: rc_preca.c - PRECA_BIZ_TYPE
enum PrecaBizType {
  PRECA_REF(1),
  PRECA_SALES(2),
  PRECA_DEPOSIT_CHANGE(3),
  PRECA_DEPOSIT_ITEM(4),
  PRECA_SALES_VOID(5),
  PRECA_DEPOSIT_CHANGE_VOID(6),
  PRECA_DEPOSIT_ITEM_VOID(7),
  PRECA_BEFORE_VOID(8);

  final int id;
  const PrecaBizType(this.id);
}
