/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ui';

import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../ui/page/device/p_device_loading_page.dart';
import '../common/rxmbrcom.dart';
import '../inc/L_rc_preca.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_apldlg.dart';
import 'rc_ext.dart';
import 'rc_fself.dart';
import 'rc_gcat.dart';
import 'rc_masr.dart';
import 'rc_obr.dart';
import 'rc_qc_dsp.dart';
import 'rc_reserv.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rc_tpoint.dart';
import 'rc_vega3000.dart';
import 'rcfncchk.dart';
import 'rcitmchk.dart';
import 'rcky_esvoid.dart';
import 'rcmbrbuyadd.dart';
import 'rcmbrkytcktmain.dart';
import 'rcqc_com.dart';
import 'rcsyschk.dart';

class RcKyCatCardRead {
  static List<int> scnList4 = [ FuncKey.KY_PRC.keyId, FuncKey.KY_MBRINFCNF.keyId ];  // 12Verから移植

  static int catTimer = 0;
  static int smileCashDspFlg = 0;
  static int oldBkScreenMode = 0;

  /// 端末読込キー押下時呼びだし画面を開く.
  static void openDeviceLoadingPage(String title) {
    Get.to(() => DeviceLoadingScreen(title: title));
  }

  /// 会員読込キーメイン
  ///  関連tprxソース: rcky_cat_cardread.c - rcKy_CAT_CardRead
  static Future<void> rcKyCatCardRead() async {
    AcMem cMem = SystemFunc.readAcMem();

    // TODO:10155 顧客呼出 - VEGA端末との連携のため、暫定値をセットする
    // VEGA端末読み取り前の設定値を退避
    int tmpGcatCnct = RcRegs.rcInfoMem.rcCnct.cnctGcatCnct;
    // VEGA端末読み取り用の初期設定
    RcRegs.rcInfoMem.rcCnct.cnctGcatCnct = 19;

    /* キーチェック */
    cMem.ent.errNo = await rcChkCatCardRead(0);
    if (cMem.ent.errNo != 0) {
      await rcCatCardReadErr(cMem.ent.errNo);
    }
    else {
      if (CompileFlag.ARCS_VEGA) {
        // 12Verから移植
        if ((RcFncChk.rcAplDlgCheck() != 0)
            && (RcSgDsp.arcsVegaChk.raraSelectFlg == 1)) {
          /* 磁気読込画面時、会員選択ダイアログを消去する */
          await rcRARAMbrReadDspClr();
        }
      }
      if ((await RcSysChk.rcChkVegaProcess())
          /* && (RcSysChk.rcsyschkSm66FrestaSystem()) */) {
        /* 1VerのVEGA端末磁気カード会員読込はフレスタ様のみ有効 */
        /* 12Verにおいては、VEGA端末磁気カード会員読込は共通仕様 */
        rcGtkTimerInitCatCardRead();
        if (RcFncChk.rcSGCheckMbrScnMode()
            || (await RcFncChk.rcChkQcashierMemberReadEntryMode())) {
          await rcCatCardReadStart();  /* カード読み取り開始 */
        }
        else if (CompileFlag.ARCS_VEGA
            && (await RcSysChk.rcChkSmartSelfSystem())
            && (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {
          // 12Verから移植
          await rcCatCardReadStart();  /* カード読み取り開始 */
        }
        else {
          await rcCatCardReadDsp();  /* カード読み取り画面表示 */
        }
      }
      else {
        if (RcSysChk.rcChkVescaTpointSystem()) {
          //Vesca T-Point仕様
          rcGtkTimerInitCatCardRead();
          if ((await RcSysChk.rcChkVFHDSelfSystem())
              && RcFncChk.rcSGCheckMbrScnMode()) {
            RcGcat.rcGcatVescaCheckCardInfo(1);
          }
          else if ((await RcSysChk.rcChkShopAndGoMode() != 0)
              && RcFncChk.rcCheckQCMbrNReadDspMode()) {
            RcGcat.rcGcatVescaCheckCardInfo(1);
          }
          else {
            await rcCatCardReadDsp();  /* カード読み取り画面表示 */
          }
        }
        else {
          //Vesca T-Point仕様以外
          if (RcSysChk.rcsyschkVescaSystem()) {
            rcGtkTimerInitCatCardRead();
            await rcCatCardReadDsp();  /* カード読み取り画面表示 */
          }
        }
      }
    }

    // TODO:10155 顧客呼出 - VEGA端末との連携のため、暫定値をセットする
    // VEGA端末読み取り前の設定値に戻す
    RcRegs.rcInfoMem.rcCnct.cnctGcatCnct = tmpGcatCnct;
  }

  /// 会員読込キー押下チェック
  /// 引数: 0=標準のキー押下時のチェック  0以外=キー押下前の動作可能かのチェック
  /// 戻り値: エラーNo
  ///  関連tprxソース: rcky_cat_cardread.c - rcChk_Cat_CardRead
  static Future<int> rcChkCatCardRead(int chkCtrlFlg) async {
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    if (!(await RcSysChk.rcChkCatCardReadSystem())) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if ((errNo == 0)
        && ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
            !(await RcSysChk.rcCheckQCJCSystem())) ) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if ((errNo == 0)
        && RcFncChk.rcCheckScanCheck()
        && !RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PRC.keyId])
        && !RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_MBRINFCNF.keyId])) {
      /* スキャン待ち中か？（売価チェック、会員情報確認は除く） */
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && RcSysChk.rcCheckKyIntIn(true)) {
      errNo = DlgConfirmMsgKind.MSG_OPEINTERERR.dlgId;
    }
    if ((errNo == 0) && RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MUL.keyId]))	{
      /* CHECK_MULTI */
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && RcRegs.kyStC0(cMem.keyStat[FncCode.KY_REG.keyId])) {
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if ((errNo == 0) && RcFncChk.rcChkTenOn()) {
      /* 手入力 */
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    if (CompileFlag.ARCS_VEGA) {  //12Verから移植
      if (!(await RcFncChk.rcCheckESVoidSMode())) {    //12Verから移植
        if ((errNo == 0) && RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
          /* スプリット中は宣言禁止 */
          errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
        }
      }
    }
    if ((errNo == 0) && RcSysChk.rcChkRepicaVerifoneReadSystemForApl()) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if (RcSysChk.rcsyschkTpointSystem()) {
      if ((errNo == 0)
          && (await RcItmChk.rcCheckCshrNotReg())
          && (!( (await RcFncChk.rcCheckESVoidMode())
              || (await RcFncChk.rcCheckESVoidSMode())
              || (await RcFncChk.rcCheckESVoidIMode())
              || (await RcFncChk.rcCheckESVoidVMode())
              || (await RcFncChk.rcCheckESVoidSDMode())
              || (await RcFncChk.rcCheckESVoidCMode())
              || (await RcFncChk.rcCheckPrecaVoidMode())) ) ) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
      if ((errNo == 0) && RcFncChk.rcCheckScanCheck()) {
        errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
      }
      if ((errNo == 0)
          && (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) ) {
        errNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
      }
      if ((errNo == 0)
          && (RcFncChk.rcCheckRcptvoidLoadOrgTran())
          && (Rxmbrcom.rcChkTpointRead(mem))) {
        errNo = DlgConfirmMsgKind.MSG_RCPTVOID_FORBIDDEN.dlgId;
      }
      if ((errNo == 0)
          && RcFncChk.rcCheckRegistration()
          && (Rxmbrcom.rcChkTpointRead(mem))
          && (!RcTpoint.rcTpointCheckProc(4))) {
        errNo = DlgConfirmMsgKind.MSG_TPTCOM_NOTPRF.dlgId;
      }
    }
    if (!RcSysChk.rcChkVescaTpointSystem()) {
      if (RcSysChk.rcsyschkVescaSystem()) {
        if ((errNo == 0)
            && RcFncChk.rcCheckRegistration()
            && (mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index)) {
          errNo = DlgConfirmMsgKind.MSG_MBRINPUT.dlgId;
        }
        if ((await RcItmChk.rcCheckCshrNotReg())
            && (!( (await RcFncChk.rcCheckESVoidMode())
                || (await RcFncChk.rcCheckESVoidSMode())
                || (await RcFncChk.rcCheckESVoidIMode())
                || (await RcFncChk.rcCheckESVoidVMode())
                || (await RcFncChk.rcCheckESVoidSDMode())
                || (await RcFncChk.rcCheckESVoidCMode())
                || (await RcFncChk.rcCheckPrecaVoidMode())) ) ) {
          errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        }
      }
    }

    if (errNo == 0) {  //12Verから移植
      if (CompileFlag.ARCS_VEGA) {
        if (RcFncChk.rcCheckScanCheck()) {
          scnList4.forEach((p) {
            RcRegs.kyStR4(cMem.keyChkb, p);
          });
        }
      }
    }

    if (errNo == 0) {
      cMem.keyChkb = List.filled(FuncKey.keyMax+1, 0xff);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_CLR.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FncCode.KY_REG.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_RMOD.keyId);
      if ((await RcFncChk.rcCheckStlMode())
          || (await RcFncChk.rcCheckCatCardReadMode())) {
        RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_STL.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FncCode.KY_FNAL.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK1.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK2.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK3.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK4.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK5.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CASH.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA1.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA2.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA3.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA4.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA5.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA6.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA7.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA8.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA9.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA10.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA11.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA12.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA13.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA14.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA15.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA16.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA17.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA18.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA19.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA20.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA21.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA22.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA23.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA24.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA25.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA26.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA27.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA28.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA29.keyId);
        RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA30.keyId);
      }
      if (cMem.stat.fncCode == FuncKey.KY_CAT_CARDREAD.keyId) {
        RcRegs.kyStR4(cMem.keyChkb, FuncKey.KY_PRC.keyId);
        RcRegs.kyStR4(cMem.keyChkb, FuncKey.KY_MBRINFCNF.keyId);
      }
      if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    if (CompileFlag.ARCS_VEGA) {  //12Verから移植
      if (await RcFncChk.rcCheckCrdtMode()) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    return errNo;
  }

  /// エラー処理
  /// 引数: エラーNo
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_Err
  static Future<void> rcCatCardReadErr(int errNo) async {
    AcMem cMem = SystemFunc.readAcMem();
    if (errNo != 0) {
      cMem.ent.errNo = errNo;
      await RcExt.rcErr("RcKyCatCardRead.rcCatCardReadErr()", errNo);
    }
  }

  /// カード読込画面表示
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_Dsp
  static Future<void> rcCatCardReadDsp() async {
    DlgParamMem dspDlg = DlgParamMem();
    String titleName = "";
    String crbtnName = "";
    int manuInput = 0;

    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    if (RcSysChk.rcsyschkTomoIFSystem()
        && ((cMem.stat.fncCode == FuncKey.KY_TOMOCARD_READ.keyId) ||
            (cMem.stat.fncCode == FuncKey.KY_TOMOCARD_INQ.keyId))) {
      // カード読み込み or カード照会
      if (await RcSysChk.rcSysChkHappySmile()) {
        atSing.tomonokaiReadingflg = 1;  // 読み込み中フラグオン
      }
      AplLibImgRead.aplLibImgRead(cMem.stat.fncCode, titleName, 32);
    }
    else {
      AplLibImgRead.aplLibImgRead(FuncKey.KY_CAT_CARDREAD.keyId, titleName, 16);
    }

    dspDlg.dialogPtn = 1;
    dspDlg.titlInfo.title = titleName;
    dspDlg.titlInfo.titleColor = "YB";  //YB: Yellow = const Color(0xffffcc66).value;
    dspDlg.titlInfo.charColor	= "BG";  //BG: Black Gray = const Color(0xff333333).value;

    AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_ALL_CANCEL, crbtnName, 4);
    dspDlg.confInfo[0].func	= rcCatCancelBtnFnc;
    dspDlg.confInfo[0].msg	= LTprDlg.BTN_CANCEL;
    dspDlg.confInfo[0].btnColor	= "RE";  //RE: Red = const Color(0xffff3300).value;
    dspDlg.confInfo[0].charColor = "WH";  //WH: White = const Color(0xffffffff).value;

    if (RcSysChk.rcChkVescaTpointSystem()) {
      // Tポイント仕様時は設定なしで使用する
      manuInput = 1;
    }

    // 設定を追加したら開放する
    // Tポイント仕様では設定なしで使用する
    if (manuInput != 0) {
      // TODO:10155 顧客呼出_実装対象外
      /*
      if (RcMbrBuyAdd.buyAdd.icDspFlg != RcRegs.CAT_CARDREAD_DSP) {
        // 買上追加ではない時、カード番号マニュアル手入力あり
        dspDlg.confInfo[1].func       = (void*)rcky_cat_cardread_manualstep;
        dspDlg.confInfo[1].msg        = (uchar *)TPOINT_VESCA_INPUT;
        dspDlg.confInfo[1].btnColor  = const Color(0xff6699cc).value;  //TB: Turquoise Blue
        dspDlg.confInfo[1].charColor = const Color(0xffffffff).value;  //WH: White
      }
       */
    }
    dspDlg.mesgInfo[0].msg = LRcPreca.CARDREAD_MSG_READGUIDE;

    if (rcCatCardReadDspFlgChk() != 0) {
      dspDlg.opsFlg = 1;	/* タワー機で「只今処理中」メッセージを表示して、既に出ているメッセージを上書きするのを防ぐため */
    }
    RcApldlg.rcAplDlg(dspDlg);

    if (!(await RcFncChk.rcCheckCatCardReadMode())) {
      if (rcCatCardReadDspFlgChk() != 0) {
        rcCatCardReadBkScrModeKeep();
      }
      await RcSet.rcCatCardReadScrMode();
    }

    if ((RcSysChk.rcChkVescaTpointSystem())
        && ((cMem.stat.fncCode != FuncKey.KY_TOMOCARD_READ.keyId) &&
            (cMem.stat.fncCode != FuncKey.KY_TOMOCARD_INQ.keyId))) {
      RcGcat.rcGcatVescaCheckCardInfo(1);
    }
    else if (RcSysChk.rcsyschkVescaSystem()) {
      if (RcSysChk.rcsyschkTomoIFSystem()
          && ((cMem.stat.fncCode == FuncKey.KY_TOMOCARD_READ.keyId) ||
              (cMem.stat.fncCode == FuncKey.KY_TOMOCARD_INQ.keyId))) {
        /* 客側画面にカード読込待ち画面を表示する。 */
        if (await RcSysChk.rcSysChkHappySmile()) {
          await RcQcDsp.rcQCAnyCustCardReadHappyCustDsp(QcScreen.QC_SCREEN_TOMO_CARDREAD_WAIT.index);
        }
      }
      RcGcat.rcGcatVescaCheckCardInfo(0);
    }
    else {
      if (CompileFlag.COLORFIP) {
        if (await RcSysChk.rcSysChkHappySmile()) {
          if ((await RcFncChk.rcsyschkHappysmileTranSelectSystem() != 0)	// 支払い選択画面を表示する仕様
            && (cMem.stat.happySmileScrmode == RcRegs.RG_QC_CASH)) {	// 入金画面の場合
            smileCashDspFlg = 1;
          }
          /* 客側画面にカード読込待ち画面を表示する。 */
          if (await RcSysChk.rcChkVegaProcess()) {
            await RcQcDsp.rcQCAnyCustCardReadHappyCustDsp(QcScreen.QC_SCREEN_VEGA_MS_CARDREAD_WAIT.index);
          }
        }
      }
      /* カード読み取り開始 */
      await rcCatCardReadStart();
    }
  }

  /// 端末磁気カード読込開始
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_Start
  static Future<void> rcCatCardReadStart() async {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcKyCatCardRead.rcCatCardReadStart(): rxMemPtr() error");
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    if ( ( (await RcSysChk.rcChkVegaProcess()) &&
            ((await RcFncChk.rcCheckCatCardReadMode()) ||
            (rcCatCardReadDspFlgChk() != 0) ||
            (await RcFncChk.rcChkQcashierMemberReadEntryMode()) ||
            RcFncChk.rcSGCheckMbrScnMode()) )
        || (CompileFlag.ARCS_VEGA &&
            (await RcSysChk.rcChkSmartSelfSystem()) &&
            (await RcSysChk.rcNewSGChkNewSelfGateSystem()))  //12Verから移植
    ) {
      /* VEGA3000が処理中の場合は読込開始しない */
      if (tsBuf.vega.vegaOrder != VegaOrder.VEGA_NOT_ORDER.cd) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcKyCatCardRead.rcCatCardReadStart() for VEGA3000 STOP VEGA3000 Processing");
        await rcCatCardReadDspClearReset();
        tsBuf.vega.vegaOrder = VegaOrder.VEGA_NOT_ORDER.cd;
        return;
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcKyCatCardRead.rcCatCardReadStart() for VEGA3000");
      await RcVega3000.rcVegaMsReadReadStart();
    }
  }

  /// 中止ボタン処理
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_Cancel_btn_fnc
  static Future<void> rcCatCancelBtnFnc() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcKyCatCardRead.rcCatCancelBtnFnc()");
    rcCatCardReadStop();
  }

  /// 端末磁気カード読込終了
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_Stop
  static Future<void> rcCatCardReadStop() async {
    if ((await RcSysChk.rcChkVegaProcess()) /* && RcSysChk.rcsyschkSm66FrestaSystem() */) {
      /* 1VerのVEGA端末磁気カード会員読込は、フレスタ様のみ有効 */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcKyCatCardRead.rcCatCardReadStop() for VEGA3000");
      await RcVega3000.rcVegaMsReadStop(false);
    }
    else {
      if (RcSysChk.rcsyschkVescaSystem()) {
        // TODO:10155 顧客呼出_実装対象外
        /*
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcKyCatCardRead.rcCatCardReadStop(): start<Verifone>");
        if (tsBuf.jpo.order != GCAT_NOT_ORDER) {
          if (tsBuf.jpo.jmups_ac_flg == 0) {
            tsBuf.jpo.jmups_ac_flg = 1;
          }
          else {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcKyCatCardRead.rcCatCardReadStop(): order[${tsBuf.jpo.order}] jmups_ac_flg[${tsBuf.jpo.jmups_ac_flg}]");
          }
        }
       */
      }
    }
  }

  /// カード読込画面表示フラグのチェック
  /// 戻り値: 0=表示中ではない  1=表示中
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_DspFlg_Chk
  static int rcCatCardReadDspFlgChk() {
    if (RcMbrBuyAdd.buyAdd.icDspFlg == RcRegs.CAT_CARDREAD_DSP) {
      /* 買上追加 */
      return 1;
    }
    if (RcReserv.reserv.cardDspFlg == RcRegs.CAT_CARDREAD_DSP) {
      /* 予約 */
      return 1;
    }
    if (RcMbrKyTcktMain.tkIssu.icdspFlg == RcRegs.CAT_CARDREAD_DSP) {
      /* チケット発行 */
      return 1;
    }
    return 0;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// カード読込画面クリア
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_DspClear
  static void rcCatCardReadDspClear() {}

  /// RARAスマホ対応 会員読込画面クリア（12verから移植）
  ///  関連tprxソース: rcky_cat_cardread.c - rcRARA_MbrRead_DspClr
  static Future<void> rcRARAMbrReadDspClr() async {
    String callFunc = "RcKyCatCardRead.rcRARAMbrReadDspClr()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, callFunc);

    RcSgDsp.arcsVegaChk.raraSelectFlg = 0;
    TprDlg.tprLibDlgClear(callFunc);
    RcApldlg.rcAplDlgClear();

    if (await RcFncChk.rcCheckRARAMbrReadMode()) {
      RcSet.rcReMovScrMode();
      if (rcRARAMbrReadDspFlgChk()) {
        /* 買上追加、予約画面終了後の画面遷移を正常に行うため */
        rcCatCardReadBkScrModeRemove();
      }
    }

    if (CompileFlag.COLORFIP) {
      if (await RcSysChk.rcSysChkHappySmile()) {
        if (smileCashDspFlg != 0) {
          // 入金画面からカード読込をした場合は入金画面に戻す。
          /* "&tColorFipItemInfo"を使用して画面描画しているため、メモリクリアする */
          Rc28StlInfo.colorFipWindowDestroy();
          smileCashDspFlg = 0;
          RcQcDsp.rcQCDspDestroy();
          RcQcDsp.rcQCCashDsp();
        }
        else {
          // TODO:10155 顧客呼出 - 端末読込画面から遷移する画面が可変となるため、コメント化
          //await Rc28StlInfo.rcFselfSubttlRedisp();  //小計画面に戻る
        }
        /* HappySelf[対面]仕様 小計画面で入金額0円の場合、スマホ読込解除後表示するため動作ストップ処理 */
        if (await RcFncChk.rcCheckStlMode()) {
          RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
          if (xRetStat.isInvalid()) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemPtr() error");
            return;
          }
          RxTaskStatBuf tsBuf = xRetStat.object;
          String path = "${EnvironmentData().env['TPRX_HOME']!}${RcQcDsp.DIR_QCMOVIE}${RcQcDsp.QC_ANYCUSTCARD_MBR_RARA}.avi";
          if (tsBuf.chk.color_fip_movie_path == path) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: $path");
            await RcfSelf.rcFselfMovieStop();
          }
        }
        /* 2ndスキャナ無効 */
        await RcObr.rcHappy2ndScannerDisable();
      }
    }
  }

  /// 会員読込画面表示フラグのチェック（12verから移植）
  /// 戻り値: true=表示中  false=非表示
  ///  関連tprxソース: rcky_cat_cardread.c - rc_RARA_MbrRead_DspFlg_Chk();
  static bool rcRARAMbrReadDspFlgChk() {
    /* 買上追加 */
    if (RcMbrBuyAdd.buyAdd.icDspFlg == RcRegs.RARA_MBRREAD_DSP) {
      return true;
    }
    /* 予約 */
    if (RcReserv.reserv.cardDspFlg == RcRegs.RARA_MBRREAD_DSP) {
      return true;
    }
    return false;
  }

  /// カード読み取り状態のリセット
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_DspClear_Reset
  static Future<void> rcCatCardReadDspClearReset() async {
    String callFunc = "RcKyCatCardRead.rcCatCardReadDspClearReset()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: Start");

    rcCatCardReadDspClear();
    if (CompileFlag.COLORFIP) {
      if (await RcSysChk.rcSysChkHappySmile()) {
        if (smileCashDspFlg != 0) { // 入金画面からカード読込をした場合は入金画面に戻す。
          smileCashDspFlg = 0;
          RcQcDsp.rcQCDspDestroy();
          RcQcDsp.rcQCCashDsp();
        }
        else {
          // TODO:10155 顧客呼出 - 端末読込画面から遷移する画面が可変となるため、コメント化
          //await Rc28StlInfo.rcFselfSubttlRedisp();  //小計画面に戻る
        }
      }
    }
    RcMbrBuyAdd.buyAdd.icDspFlg = 0;
    RcReserv.reserv.cardDspFlg = 0;
    RcKyesVoid.esVoid.carddspFlg = 0;
    RcMbrKyTcktMain.tkIssu.icdspFlg = 0;

    AcMem cMem = SystemFunc.readAcMem();
    RcRegs.kyStR0(cMem.keyStat, FncCode.KY_ENT.keyId);
    RcRegs.kyStR0(cMem.keyStat, FncCode.KY_REG.keyId);

    if (RcFncChk.rcCheckMasrSystem()) {
      if (RcSysChk.rcChkCustrealFrestaSystem()) {    // フレスタ仕様
        // 通常およびHappy対面モードは基本的に常に
        // 自走式リーダーは有効状態でいる為停止処理は行わない
        if ((await RcSysChk.rcChkVFHDSelfSystem())	/* 15.6インチフルセルフ */
            || (await RcSysChk.rcChkVFHDQCSystem())) {	/* 15.6インチ精算機 */
          await RcMasr.rcCheckMasrNormalSet(callFunc, MasrOrderCk.CNCL_START);
          RcQcCom.rcQCLedCom(QcLedNo.QC_LED_CRDT.index,
              QcLedColor.QC_LED_OFF_COLOR.index,
              QcLedDisp.QC_LED_DISP_OFF.index, 0, 0, 0);
        }
      }
      else {
        await RcMasr.rcCheckMasrNormalSet(callFunc, MasrOrderCk.CNCL_START);
        RcQcCom.rcQCLedCom(QcLedNo.QC_LED_CRDT.index,
            QcLedColor.QC_LED_OFF_COLOR.index,
            QcLedDisp.QC_LED_DISP_OFF.index, 0, 0, 0);
      }
    }
  }

  /// 前画面のBkScrModeを保持する
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_BkScrMode_Keep
  static void rcCatCardReadBkScrModeKeep() {
    AcMem cMem = SystemFunc.readAcMem();
    oldBkScreenMode = cMem.stat.bkScrMode;
  }

  /// 保持していた前画面のBkScrModeを戻す
  ///  関連tprxソース: rcky_cat_cardread.c - rc_Cat_CardRead_BkScrMode_Remove
  static void rcCatCardReadBkScrModeRemove() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.bkScrMode = oldBkScreenMode;
  }

  /// タイマー初期化処理
  ///  関連tprxソース: rcky_cat_cardread.c - rcGtkTimerInit_cat_cardread
  static void rcGtkTimerInitCatCardRead() {
    catTimer = -1;
  }

  /// タイマー開始処理
  /// 引数:[timer] タイマー(ms)
  /// 引数:[func] 実行関数名
  ///  関連tprxソース: rcky_cat_cardread.c - rcGtkTimerAdd_cat_cardread
  static int rcGtkTimerAddCatCardRead(int timer, Function func) {
    if (catTimer != -1) {
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }
    catTimer = Fb2Gtk.gtkTimeoutAdd(timer, func, 0);
    return Typ.OK;
  }

  /// タイマー終了処理
  ///  関連tprxソース: rcky_cat_cardread.c - rcGtkTimerRemove_cat_cardread
  static void rcGtkTimerRemoveCatCardRead() {
    if (catTimer != -1) {
      Fb2Gtk.gtkTimeoutRemove(catTimer);
      rcGtkTimerInitCatCardRead();
    }
  }

  /// タイマーエラー時の処理
  ///  関連tprxソース: rcky_cat_cardread.c - rcGtkTimerErr_cat_cardread
  static Future<void> rcGtkTimerErrCatCardRead() async {
    String callFunc = "RcKyCatCardRead.rcGtkTimerErrCatCardread()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, callFunc);

    rcGtkTimerRemoveCatCardRead();
    TprDlg.tprLibDlgClear(callFunc);
    RcApldlg.rcAplDlgClear();

    AcMem cMem = SystemFunc.readAcMem();
    await RcExt.rcErr(callFunc, cMem.ent.errNo);
    await RcExt.rxChkModeReset(callFunc);

    IfWaitSave ifSave = SystemFunc.readIfWaitSave();
    if (ifSave.count != 0) {
      ifSave = IfWaitSave();
    }
  }
}
