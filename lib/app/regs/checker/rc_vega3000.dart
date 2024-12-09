/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../drv/vega/drv_vega3000_com.dart';
import '../../if/if_vega_isolate.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemcogca.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/cm_ary/chk_digit.dart';
import '../../lib/cm_ean/chk_mkcd.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_mcd/cmmcdset.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_vega3000/vega3000_com.dart';
import '../../tprlib/TprLibDlg.dart';
import '../inc/L_rccrdt.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_ext.dart';
import 'rc_ifevent.dart';
import 'rc_mbr_com.dart';
import 'rc_obr.dart';
import 'rc_qc_dsp.dart';
import 'rc_reserv.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rcfncchk.dart';
import 'rcitmchk.dart';
import 'rcitmset.dart';
import 'rcky_brand.dart';
import 'rcky_cat_cardread.dart';
import 'rcky_esvoid.dart';
import 'rcmbrbuyadd.dart';
import 'rcmbrkymbr.dart';
import 'rcqr_com.dart';
import 'rcsyschk.dart';

class RcVega3000 {
  static IfVega3000Com ifVega3000 = IfVega3000Com();
  static DrvVega3000Com drvVega3000 = DrvVega3000Com();
  static IfVegaIsolate isolate = IfVegaIsolate();

  /// VEGA端末磁気カード読込停止処理
  /// 引数: キャンセルフラグ（true=キャンセルあり  false=キャンセルなし）
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_Callbackflg_Set
  static Future<void> rcVegaMsReadStop(bool cnclFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xtRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xtRet.object;

    // キャンセルフラグをセットする
    if (tsBuf.vega.vegaOrder != VegaOrder.VEGA_NOT_ORDER.cd) {
      debugPrint("********** RcVega3000.rcVegaMsReadStop($cnclFlg): start");
      if (cnclFlg) {
        cBuf.vega3000Conf.vega3000CancelFlg = 1;
      }
      /*
      debugPrint("********** RcVega3000.rcVegaMsReadStop($cnclFlg): vegaMsReadCancel() start");
      drvVega3000.vegaMsReadCancel(cBuf);
      debugPrint("********** RcVega3000.rcVegaMsReadStop($cnclFlg): vegaMsReadCancel() end");
       */
      debugPrint("********** RcVega3000.rcVegaMsReadStop($cnclFlg): isolate.sendStop() start");
      await isolate.driverStop(cBuf);
      debugPrint("********** RcVega3000.rcVegaMsReadStop($cnclFlg): isolate.sendStop() end");
    }
  }

  /// VEGA端末磁気カード読込開始処理
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_MsRead_ReadStart
  static Future<void> rcVegaMsReadReadStart() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xtRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xtRet.object;
    //AcMem cMem = SystemFunc.readAcMem();

    /* キャンセルフラグをリセットする */
    cBuf.vega3000Conf.vega3000CancelFlg = 0;
    RcKyCatCardRead.rcGtkTimerRemoveCatCardRead();

    // VEGA端末読み取り用の初期設定
    tsBuf.vega.vegaOrder = VegaOrder.VEGA_MS_TX.cd;

    debugPrint('********** 実機調査ログ（会員呼出）1: RcVega3000.rcVegaMsReadReadStart() Isolate スタート');

    // VEGA端末ドライバのIsolateを起動
    await isolate.startIsolate(EnvironmentData.TPRX_HOME, Tpraid.TPRAID_VEGA3000);
    isolate.driverStart(cBuf, tsBuf);

    /*
    cMem.ent.errNo = RcKyCatCardRead.rcGtkTimerAddCatCardRead(100, rcVegaWaitResponse);
    if (cMem.ent.errNo != 0) {
      await RcKyCatCardRead.rcGtkTimerErrCatCardRead();
    }
     */
  }

  /// VEGA端末磁気カード読込開始処理
  /// 戻り値: エラーNo
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_Wait_Response
  static Future<void> rcVegaWaitResponse() async {
    RcKyCatCardRead.rcGtkTimerRemoveCatCardRead();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcVega3000._rcVegaWaitResponse(): rxMemPtr() error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xRetStat.object;
    AcMem cMem = SystemFunc.readAcMem();

    // VEGA端末読み取り前の設定値を退避
    int tmpGcatCnct = RcRegs.rcInfoMem.rcCnct.cnctGcatCnct;
    int tmpEfctNo = cBuf.dbTrm.othcmpMagEfctNo;

    // VEGA端末読み取り用の初期設定
    RcRegs.rcInfoMem.rcCnct.cnctGcatCnct = 19;
    cBuf.dbTrm.othcmpMagEfctNo = 8;

    debugPrint('********** 実機調査ログ（会員呼出）2: RcVega3000Com.rcVegaWaitResponse() tsBuf.vega.vegaOrder=${tsBuf.vega.vegaOrder}');
    switch (tsBuf.vega.vegaOrder) {
      case 3:		//VegaOrder.VEGA_MS_TX.cd: MS送信
        // TODO:10155 顧客呼出 - Isolate移行のため、コメント化
        /*
        cMem.ent.errNo = RcKyCatCardRead.rcGtkTimerAddCatCardRead(100, rcVegaWaitResponse);
        if (cMem.ent.errNo != 0) {
          await RcKyCatCardRead.rcGtkTimerErrCatCardRead();
        }
         */
        break;
      case 4:		//VegaOrder.VEGA_MS_RX.cd: MS受信
        await _rcVegaMsReadDataProc();
        tsBuf.vega.vegaOrder = VegaOrder.VEGA_NOT_ORDER.cd;
        break;
      case 6:		//VegaOrder.VEGA_ERR_END.cd: エラー終了
        await RcKyCatCardRead.rcCatCardReadDspClearReset();
        cMem.ent.errNo = await rcVegaErrChk();
        if (((cBuf.vega3000Conf.vega3000CancelFlg == 1) ||
             ((await CmCksys.cmMarutoSystem() != 0)  /* マルト様の承認キーが有効かチェック */
                 && RcFncChk.rcCheckQCMbrNReadDspMode()))	/* 会員カードリード画面かチェック */
            && (cMem.ent.addMsgBuf == LRccrdt.VEGA_ERROR_D52)) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcVega3000._rcVegaWaitResponse(): VEGA3000 CANCEL rcErr() Skip !");
          /* キャンセルフラグオフ */
          cBuf.vega3000Conf.vega3000CancelFlg = 0;
          cMem.ent.errNo = 0;
          if (RcFncChk.rcQCCheckAnyCustCardReadDspMode())	{
            /* QCashierの端末カード読込画面 */
            RcQcDsp.rcQCAnyCustCardReadBack();   //カード読込画面_戻るボタン押下時の画面遷移
          }
          else {
            if (RcFncChk.rcSGCheckMbrScnMode() || RcFncChk.rcSGCheckPrecaNonMbrcardMode()) {
              if (CompileFlag.ARCS_VEGA) {
                if ((RcSgDsp.arcsVegaChk.arcsMbrPrecaRef == 1)
                    && (RcSgDsp.mbrScnDsp.mbrcardReadtyp == MbrCardReadType.NOT_READ.index)) {
                  /* プリカ残高確認中のスマホ読込画面では会員選択へ戻さない */
                }
                if ((RcSgDsp.arcsVegaChk.arcsMbrPrecaRef == 1)
                    && (RcSgDsp.arcsVegaChk.raraSelectFlg == 2)) {
                  /* VEGA端末からキャンセル応答後「スマホ読込」表示 */
                  RcSgDsp.rcSGRalsBtn3StartFunc(null, 0);  /* 12ver */
                }
                else {
                  RcSgDsp.rcSGMbrScanBackProc();   //会員カード読込画面_戻るボタン押下時のメイン処理
                }
              } else {
                RcSgDsp.rcSGMbrScanBackProc();   //会員カード読込画面_戻るボタン押下時のメイン処理
              }
            }
            else if (RcFncChk.rcCheckQCMbrNReadDspMode()) {
              if (CompileFlag.ARCS_VEGA) {  //12Verから移植
                RcQcDsp.rcQCStrBarkBtnProc();
              } else {
                RcQcDsp.rcQCStrBackBtnFnc(null, null);  //戻るボタン押下時の処理
              }
            }
            else if (RcFncChk.rcQCCheckEMnyPrecaDspMode()) {
              RcQcDsp.rcQCEMnyEndBtnFunc();
            }
            else if (CompileFlag.ARCS_VEGA && RcFncChk.rcCheckQCMbrNReadDspMode()) {
              RcQcDsp.rcQCStrBarkBtnProc();  /* 12ver */
            }
            else if (await RcFncChk.rcCheckArcsMbrDspMode()) {
              RcQcDsp.rcQCArcsPaymentMbrReadDisp();  /* 12ver */
            }
          }
        }
        else {
          if (cMem.ent.errNo != 0) {
            await _rcVegaMsReadErrProc(cMem.ent.errNo);
          }
        }
        /* 排他制御オフ */
        tsBuf.vega.vegaOrder = VegaOrder.VEGA_NOT_ORDER.cd;
        break;
      default:
        break;
    }

    // VEGA端末読み取り前に退避した設定値へ戻す
    RcRegs.rcInfoMem.rcCnct.cnctGcatCnct = tmpGcatCnct;
    cBuf.dbTrm.othcmpMagEfctNo = tmpEfctNo;

    // VEGA端末ドライバのIsolateを停止する
    await rcVegaMsReadStop(false);

    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("RcVega3000.rcVegaWaitResponse()", cMem.ent.errNo);
    }
  }

  /// 磁気カードデータから各種パラメタを抽出する
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_MsRead_DataProc
  static Future<void> _rcVegaMsReadDataProc() async {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcVega3000.rcVegaMsReadDataProc(): rxMemPtr() error");
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcVega3000.rcVegaMsReadDataProc(): start");

    if (((await RcSysChk.rcQCChkQcashierSystem()) &&
        (await RcSysChk.rcChkVegaProcess()))
        || (RcKyCatCardRead.rcCatCardReadDspFlgChk() != 0)
        || RcFncChk.rcSGCheckMbrScnMode()
        || (await RcFncChk.rcChkQcashierMemberReadEntryMode())
        || ((await CmCksys.cmMarutoSystem() != 0) &&
            RcFncChk.rcCheckQCMbrNReadDspMode()) ) {
      await _rcVegaMsReadMemberCallMain(tsBuf.vega.vegaData.cardType);
    }
    else {
      RcSet.rcReMovScrMode();	/* 従業員情報を表示させるため、画面モードを元に戻す */
      if (RcKyCatCardRead.rcCatCardReadDspFlgChk() != 0) {
        RcKyCatCardRead.rcCatCardReadBkScrModeRemove();
      }
      await _rcVegaMsReadMemberCallMain(tsBuf.vega.vegaData.cardType);
      /* ダイアログが既に消えているので再度の画面モード変更は不要 */
    }

    if (await RcFncChk.rcChkQcashierMemberReadEntryMode()) {
      RcQcDsp.rcQCDspQcashierMemberReadEntryEnd();
    }

    // 12Verから移植
    if (CompileFlag.ARCS_VEGA) {
      if ((await RcFncChk.rcCheckESVoidSMode()) || (await RcFncChk.rcCheckESVoidIMode())) {
        //検索訂正の画面を再描画
        if (await RcSysChk.rcChkVegaProcess()) {
          RcKyesVoid.esVoidMbrInputMbrDsp();
        }
      }
    }
  }

  /// 磁気カードデータからカード種類および会員番号を抽出する
  /// 引数: カードタイプ　(D_ICCD1 / D_MCD2)
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_MsRead_MemberCall_Main
  static Future<int> _rcVegaMsReadMemberCallMain(int type) async {
    String callFunc = "RcVega3000.rcVegaMsReadMemberCallMain()";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemPtr() error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xRetStat.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: start");
    if (await RcMbrCom.rcmbrChkStat() == 0) {
      await RcKyCatCardRead.rcCatCardReadDspClearReset();
      return 0;
    }

    if (RcFncChk.rcChkTenOn()
        && ((RcReserv.reserv.cardDspFlg != RcRegs.CAT_CARDREAD_DSP)
            && (!(RcSysChk.rcsyschkSm66FrestaSystem() &&
                (await RcFncChk.rcChkQcashierMemberReadSystem()) &&
                (await RcFncChk.rcChkQcashierMemberReadEntryMode())) )) ) {
      await RcKyCatCardRead.rcCatCardReadDspClearReset();
      await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEMISS.dlgId);
      return 0;
    }
    if ((RcMbrBuyAdd.buyAdd.icDspFlg != RcRegs.CAT_CARDREAD_DSP)
        && (await RcItmChk.rcCheckCshrNotReg())) {
      if (CompileFlag.ARCS_VEGA) {  //12Verから移植
        if (!(await RcFncChk.rcCheckESVoidSMode()) && !(await RcFncChk.rcCheckESVoidIMode())) {
          await RcKyCatCardRead.rcCatCardReadDspClearReset();
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          return 0;
        }
      }
      else {
        await RcKyCatCardRead.rcCatCardReadDspClearReset();
        await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
        return 0;
      }
    }
    // TODO:10155 顧客呼出 - 会員番号読取のため、一時的に値を設定
    if (type == 80) {
      type = MCD.D_MCD2;  //VEGA端末から返されるPosMsParam.card.typeが正常の時、左記の値に変更する
    }
    if (type != MCD.D_MCD2) {
      await RcKyCatCardRead.rcCatCardReadDspClearReset();
      return 0;
    }
    debugPrint("***** $callFunc: type = MCD.D_MCD2");

    String cardNo = "";
    String tmpAcode = "";
    int errNo = 0;
    if (CompileFlag.ARCS_VEGA) {  //12Verから移植
      if (await RcSysChk.rcChkVegaProcess()) {
        // TODO:10155 顧客呼出 - 会員番号読取のため、一時的に値を設定
        int tmpMbrCdLen = cBuf.mbrcdLength;  //会員番号_元の有効桁数を退避する
        cBuf.mbrcdLength = 12;               //会員番号_有効桁数を12桁に設定
        atSing.inputbuf.Acode = tsBuf.vega.vegaData.cardData2.join("");
        (errNo, cardNo) = _rcVegaMsReadArcsMemberNumRead(type, atSing.inputbuf.Acode);
        (errNo, tmpAcode) = await Cmmcdset.cmMcdToMbr(cardNo, atSing.mbrTyp);
        atSing.inputbuf.Acode = tmpAcode;
        if (await CmCksys.cmReceiptQrSystem() != 0) {
          RcqrCom.qrReadMcdAcode = "${cMem.working.crdtReg.jis2}0";
        }
        cBuf.mbrcdLength = tmpMbrCdLen;  //会員番号_有効桁数を元に戻す
      }
    }
    else {
      debugPrint("***** $callFunc: CompileFlag.ARCS_VEGA = false");
      (errNo, cardNo) = _rcVegaMsReadMemberNumRead(type, tsBuf.vega.vegaData.cardData1.join(""));
    }

    int arcsErrNo = 0;
    cMem.ent.errNo = errNo;
    if (cMem.ent.errNo != 0) {
      if (CompileFlag.ARCS_VEGA) {
        arcsErrNo = cMem.ent.errNo;
        await RcKyCatCardRead.rcCatCardReadDspClearReset();
        cMem.ent.errNo = arcsErrNo;
      }
      else {
        await RcKyCatCardRead.rcCatCardReadDspClearReset();
      }
      await RcExt.rcErr(callFunc, cMem.ent.errNo);
      return 0;
    }

    /* ログ出力 */
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: type=[${type}] card_no=[$cardNo] err_no=[${cMem.ent.errNo}]");
    if (CompileFlag.ARCS_VEGA) {
      if (await RcSysChk.rcChkVegaProcess()) {
        cMem.working.janInf.code = atSing.inputbuf.Acode;
      }
      else {
        cMem.working.janInf.code = cardNo;
      }
    }
    else {
      cMem.working.janInf.code = cardNo;
    }
    debugPrint('********** 実機調査ログ（会員呼出）3: RcVega3000._rcVegaMsReadMemberCallMain(type=$type) cardNo=${cMem.working.janInf.code} mbrTyp=${atSing.mbrTyp}');

    if ((await RcMbrCom.rcmbrChkStat() != 0) && (RcMbrBuyAdd.buyAdd.icDspFlg == RcRegs.CAT_CARDREAD_DSP)) {
      await RcKyCatCardRead.rcCatCardReadDspClearReset();
      /* 磁気カードで買上追加の場合 */
      await RcMbrBuyAdd.rcBuyAddMcProc(cardNo);
    }
    else if (RcFncChk.rcCheckScanCheck()
        && (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PRC.keyId]) ||
            (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_MBRINFCNF.keyId]))) ) {
      /* 売価チェック、会員情報確認 */
      await RcKyCatCardRead.rcCatCardReadDspClearReset();
      cMem.ent.errNo = await Rcmbrkymbr.rcMbrMac(MbrInputType.magcardInput, RcMbr.RCMBR_WAIT);
      if (cMem.ent.errNo == 0) {
        Rcmbrkymbr.rcScnMbr();
      } else {
        await RcExt.rcErr(callFunc, cMem.ent.errNo);
      }
    }
    else if (RcReserv.reserv.cardDspFlg == RcRegs.CAT_CARDREAD_DSP) {
      await RcKyCatCardRead.rcCatCardReadDspClearReset();
      RcReserv.reserv.cardDspFlg = 0;
      /* 磁気カードで予約の場合 */
      RcReserv.rcReservNumberInput(cardNo);
      if (RcSysChk.rcChkCogcaICMemberSystem()) {
        RcReserv.reserv.keepCard = RxMemCogcaCard();    /* CoGCaICで読み込んだ場合のデータをクリア */
      }
    }
    else {
      await Rcmbrkymbr.sptendCalcCntSet();
      cMem.ent.errNo = await Rcmbrkymbr.rcMbrMac(MbrInputType.magcardInput, RcMbr.RCMBR_WAIT);
      if (CompileFlag.ARCS_VEGA) {
        if (cMem.ent.errNo != 0) {
          // 会員エラー状態を保持
          arcsErrNo = cMem.ent.errNo;
        }
      }
      await RcKyCatCardRead.rcCatCardReadDspClearReset();
      if (CompileFlag.ARCS_VEGA) {
        // 端末読込画面でエラークリアされるため保持していたエラーを使用
        if (arcsErrNo != 0) {
          cMem.ent.errNo = arcsErrNo;
        }
        if ( ((cMem.stat.scrMode == 16) || (cMem.stat.scrMode == 18))
            && (await RcSysChk.rcSGChkSelfGateSystem())
            && (cMem.ent.errNo == 0) ) {
          if (RcSgDsp.arcsVegaChk.arcsMbrPrecaRef == 1) {
            if (atSing.mbrTyp == Mcd.MCD_RLSCARD) {
              await RcObr.rcScanDisable();
              await RcKyBrand.rcDetectPrecaRef();
            }
            else {
              await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_ARCS_RARA_CARD.dlgId);
              return 0;
            }
          }
          else if ((RcSgDsp.arcsVegaChk.arcsMbrRead == 1)
              && !(await RcFncChk.rcCheckArcsPaymentMbrRead())) {
            if (atSing.mbrTyp == Mcd.MCD_RLSCARD) {
              await RcKyBrand.rcPrgArcsVegaKyWorkIn();
            }
          }
        }
        else if ((await RcSysChk.rcChkShopAndGoSystem())
            && (await RcMbrCom.rcmbrChkStat() != 0)			// 会員システム
            && RcFncChk.rcCheckRegistration()	// 登録中ではない
            && (cMem.ent.errNo == 0) ) {
          if (RcSgDsp.arcsVegaChk.arcsMbrPrecaRef == 1) {
            if (atSing.mbrTyp == Mcd.MCD_RLSCARD) {
              await RcObr.rcScanDisable();
              await RcKyBrand.rcDetectPrecaRef();
            }
            else {
              await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_ARCS_RARA_CARD.dlgId);
              return 0;
            }
          }
          if (RcQcDsp.qCashierIni.shopAndGoMbrChkDsp == QcMbrDspStatus.QC_MBRDSP_STATUS_BEFORE_READ.index) {
            // 会員画面先表示
            if (RcSgDsp.arcsVegaChk.arcsMbrRead == 1) {
              if (atSing.mbrTyp == Mcd.MCD_RLSCARD) {
                await RcKyBrand.rcPrgArcsVegaKyWorkIn();
              }
            }
          }
        }
      }
      if (cMem.ent.errNo == 0) {
        if (!RcFncChk.rcCheckRegistration()) {
          RcItmSet.rcSetInitData(FuncKey.KY_MBR.keyId);
        }
        await RcSet.rcClearKyItem();
        if (await RcSysChk.rcQRChkPrintSystem()) {
          if (CompileFlag.ARCS_VEGA) {
            await RcqrCom.rcQRSystemOthToTxt(QR_ARCS_MBR_JIS2);
          }
          else {
            await RcqrCom.rcQRSystemOthToTxt(FuncKey.KY_STLPPC.keyId);
          }
        }
        return 1;
      }
      else {
        if (CompileFlag.ARCS_VEGA) {
          /* 未登録状態または会員タイプ未登録の場合会員情報をクリア */
          if (!RcFncChk.rcCheckRegistration() || (mem.tTtllog.t100700Sts.mbrTyp == 0)) {
            atSing.mbrTyp = 0;
          }
        }
        await RcExt.rcErr(callFunc, cMem.ent.errNo);
      }
    }

    return 0;
  }

  /// 磁気カード読み取り時エラー処理
  /// 引数: エラーコード
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_MsRead_Err_Proc
  static Future<void> _rcVegaMsReadErrProc(int errNo) async {
    tprDlgParam_t param = tprDlgParam_t();
    AcMem cMem = SystemFunc.readAcMem();

    if (errNo != 0) {
      if (await RcSysChk.rcQCChkQcashierSystem()) {
        RcqrCom.rcQRSystemTxtMemInit();
        await RcExt.rxChkModeReset("RcVega3000._rcVegaMsReadErrProc");
      }
      cMem.ent.errNo = errNo;
      await RcExt.rcErr("RcVega3000._rcVegaMsReadErrProc", cMem.ent.errNo);
      await RcIfEvent.rxChkTimerAdd();
    }
    else {
      param.dialogPtn = DlgPattern.TPRDLG_PT4.dlgPtnId;
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_CHECKER:
          break;
        case RcRegs.KY_DUALCSHR:
          // TODO:10077 コンパイルスイッチ(FB2GTK)
          //param.dualDev = 1;
          break;
        case RcRegs.KY_SINGLE:
          if (cMem.stat.dualTSingle == 1) {
            // TODO:10077 コンパイルスイッチ(FB2GTK)
            //param.dualDsp = 2;
            //param.dualDev = 1;
          }
          break;
        default:
          break;
      }
      TprLibDlg.TprLibDlgSnd(param);
    }
  }

  /// VEGA端末エラー処理
  /// 戻り値: エラーコード
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_ErrChk
  static Future<int> rcVegaErrChk() async {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    RxTaskStatBuf tsBuf = xRetStat.object;
    AcMem cMem = SystemFunc.readAcMem();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "RcVega3000.rcVegaErrChk(): ErrCd[${tsBuf.vega.vegaData.errCode}] Msg1[${tsBuf.vega.vegaData.msg1}] Msg2[${tsBuf.vega.vegaData.msg2}]");

    if (tsBuf.vega.vegaData.errCode[0] == 'D') {
      /* 共通 */
      if (tsBuf.vega.vegaData.errCode.join("").startsWith("D01")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D01;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D02")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D02;
      }
      /* 決済センタ通信 */
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D05")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D05;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D06")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D06_D07;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D07")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D06_D07;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D10")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D10_D11;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D11")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D10_D11;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D20")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D20;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D21")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D21;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D90")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D90;
      }
      /* 決済端末通信 */
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D41")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D41;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D42")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D42;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D43")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D43;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D52")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D52;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D53")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D53;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D54")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D54;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D55")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D55;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D91")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D91;
      }
      /* 端末エラー */
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D97")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D97;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D98")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D98;
      }
      else if (tsBuf.vega.vegaData.errCode.join("").startsWith("D99")) {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D99;
      }
      else {
        cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_DXX;
      }
      return DlgConfirmMsgKind.MSG_CRDT_VEGA_ERROR.dlgId;
    }
    return 0;
  }

  /// 磁気カード会員番号確認
  /// 引数:[cardType] カードタイプ　(D_ICCD1 / D_MCD2)
  /// 引数:[inpData] カード情報
  /// 戻り値:[int] エラーNo
  /// 戻り値:[String] カードNo
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_MsRead_MemberNumRead
  static (int, String) _rcVegaMsReadMemberNumRead(int cardType, String inpData) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (0, "");
    }
    RxCommonBuf cBuf = xRet.object;

    int codeLen = 0;
    if (RcSysChk.rcChkSm8TaiyoSystem() != 0) {
      codeLen = 13;
    }
    else if (RcSysChk.rcChkCustrealFrestaSystem()) {
      codeLen = CmMbrSys.cmMbrcdLen();
    }
    else {
      codeLen = CmMbrSys.cmMagcdLen();
    }

    String cardNo = "".padLeft(codeLen, "0");
    int errNo = 0;
    int mbrcdShortage = 0;

    if (cardType == MCD.D_MCD2) {
      /* 磁気カード */
      mbrcdShortage = CmMbrSys.cmMagcdLen() - cBuf.dbTrm.othcmpMagEfctNo;
      if ((mbrcdShortage > 0) && (cBuf.dbTrm.othcmpMagEfctNo != 0)) {
        /* 他社磁気カードNo.有効桁数 */
        /* 先頭0埋めして、後ろに有効桁数分をセットする */
        cardNo = inpData.substring(0, cBuf.dbTrm.othcmpMagEfctNo).padLeft(codeLen, "0");
      }
      else {
        cardNo = inpData.substring(0, CmMbrSys.cmMagcdLen()).padLeft(codeLen, "0");
      }
    }
    else {
      errNo = DlgConfirmMsgKind.MSG_CARD_NOTUSE2.dlgId;
    }

    if ((errNo == 0) && (cardNo != "".padLeft(codeLen, "0"))) {
      errNo = DlgConfirmMsgKind.MSG_DATATYPEERR.dlgId;
    }
    if ((errNo == 0) && !ChkDigit.cmChkDigit(cardNo, codeLen)) {
      errNo = DlgConfirmMsgKind.MSG_DATATYPEERR.dlgId;
    }
    if ((errNo == 0) && !ChkMkcd.cmChkMkCdigitVariable(cardNo, 0, codeLen)) {
      errNo = DlgConfirmMsgKind.MSG_CARDNOCDERR.dlgId;
    }

    return (errNo, cardNo);
  }

  /// アークス磁気カード会員番号確認（12Verから移植）
  /// 引数:[cardType] カードタイプ　(D_ICCD1 / D_MCD2)
  /// 引数:[inpData] カード情報
  /// 戻り値:[int] エラーNo
  /// 戻り値:[String] カードNo
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_MsRead_ArcsMemberNumRead
  static (int, String) _rcVegaMsReadArcsMemberNumRead(int cardType, String inpData) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (0, "");
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();

    int magLen = CmMbrSys.cmMagcdLen();
    String cardNo = "".padLeft(magLen, "0");
    int errFlg = 0;
    int mbrcdShortage = 0;
    int startPos = 0;
    int arcsMagcdLen = 0;

    if (CompileFlag.ARCS_VEGA) {
      cardNo = "".padLeft(128, "0");
    }

    if (cardType == MCD.D_MCD2)	{
      /* 磁気カード */
      mbrcdShortage = magLen - cBuf.dbTrm.othcmpMagEfctNo;
      if ((mbrcdShortage > 0) && (cBuf.dbTrm.othcmpMagEfctNo != 0) ) {
        /* 他社磁気カードNo.有効桁数 */
        /* 先頭0埋めして、後ろに有効桁数分をセットする */
        cardNo = "${cardNo.substring(0, mbrcdShortage)}${inpData.substring(0, cBuf.dbTrm.othcmpMagEfctNo)}";
      }
      else {
        _rcVegaMsReadArcsMemberDataSet();
        if (atSing.mbrTyp == Mcd.MCD_RLSCARD) {
          startPos = 11;
          arcsMagcdLen = 12;
          cardNo = "${cardNo.substring(0, mbrcdShortage)}${inpData.substring(startPos, startPos+arcsMagcdLen)}${cardNo.substring(mbrcdShortage+startPos+arcsMagcdLen)}";
        }
        else if ((atSing.mbrTyp == Mcd.MCD_RLSCRDT)
            || (atSing.mbrTyp == Mcd.MCD_RLSVISA)
            || (atSing.mbrTyp == Mcd.MCD_RLSJACCS) ) {
          startPos = 20;
          arcsMagcdLen = 12;
          cardNo = "${cardNo.substring(0, mbrcdShortage)}${inpData.substring(startPos, startPos+arcsMagcdLen)}${cardNo.substring(mbrcdShortage+startPos+arcsMagcdLen)}";
        }
        else if (atSing.mbrTyp == Mcd.MCD_RLSSTAFF) {
          startPos = 16;
          arcsMagcdLen = 7;
          mbrcdShortage = 5;
          cardNo = "${cardNo.substring(0, mbrcdShortage)}${inpData.substring(startPos, startPos+arcsMagcdLen)}";
        }
      }
    }
    else {
      errFlg = DlgConfirmMsgKind.MSG_CARD_NOTUSE2.dlgId;
    }

    if ((errFlg != 0)
        && (cardNo != "".padLeft(arcsMagcdLen, "0"))) {
      errFlg = DlgConfirmMsgKind.MSG_DATATYPEERR.dlgId;
    }
    if ((errFlg != 0) && !ChkDigit.cmChkDigit(cardNo, magLen)) {
      errFlg = DlgConfirmMsgKind.MSG_DATATYPEERR.dlgId;
    }
    if ((errFlg != 0)
        && !ChkMkcd.cmChkMkCdigitVariable(cardNo, 0, arcsMagcdLen)) {
      errFlg = DlgConfirmMsgKind.MSG_CARDNOCDERR.dlgId;
    }

    return (errFlg, cardNo);
  }

  /// アークスカードを判断し、メンバータイプをセットする（12Verから移植）
  /// 関連tprxソース: rc_vega3000.c - rc_Vega_MsRead_ArcsMemberDataSet
  static void _rcVegaMsReadArcsMemberDataSet() {
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xtRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xtRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    String mbrCd = "";
    String cardData1 = tsBuf.vega.vegaData.cardData1.join("");
    String cardData2 = tsBuf.vega.vegaData.cardData2.join("");

    if ((cardData1.substring(7, 7+Mcd.MCD_RLSCARDCD.length) == Mcd.MCD_RLSCARDCD)
      && (cardData2.substring(7, 7+Mcd.MCD_RLSCARDCD.length) == Mcd.MCD_RLSCARDCD)) {
      //現金専用RARA・RATAハウス・RARAプリカカード
      atSing.mbrTyp = Mcd.MCD_RLSCARD;
      mbrCd = cardData2.substring(11, 23);  //12桁
      // todo クレ宣言　暫定対応7　jis2にStringを代入させるため、fillerに格納
      // cMem.working.crdtReg.jis2 = "Z60000${Mcd.MCD_RLSCARDCD}${mbrCd}000000${tsBuf.vega.vegaData.cardData2[29]}00000000000000                         ";
      cMem.working.crdtReg.jis2?.mbrNo = "";
      cMem.working.crdtReg.jis2?.cdKind = "";
      cMem.working.crdtReg.jis2?.insLim = "";
      cMem.working.crdtReg.jis2?.filler = "Z60000${Mcd.MCD_RLSCARDCD}${mbrCd}000000${tsBuf.vega.vegaData.cardData2[29]}00000000000000                         ";
      cMem.working.crdtReg.jis2flg = 1;
    }
    else if ((tsBuf.vega.vegaData.cardData1[1] == "a")
      && (cardData1.substring(7, 7+Mcd.MCD_RLSCRDTCD.length) == Mcd.MCD_RLSCRDTCD)
      && (cardData2.substring(15, 15+Mcd.MCD_RLSCRDTCD2.length) == Mcd.MCD_RLSCRDTCD2) ) {
      //RARAJCBクレジットカード
      atSing.mbrTyp = Mcd.MCD_RLSCRDT;
      mbrCd = cardData2.substring(20, 32);  //12桁
      // todo クレ宣言　暫定対応7　jis2にStringを代入させるため、fillerに格納
      // cMem.working.crdtReg.jis2 = "a90000${Mcd.MCD_RLSCRDTCD}300000000000000000000000000000000${Mcd.MCD_RLSCRDTCD2}${mbrCd}00000000";
      cMem.working.crdtReg.jis2?.mbrNo = "";
      cMem.working.crdtReg.jis2?.cdKind = "";
      cMem.working.crdtReg.jis2?.insLim = "";
      cMem.working.crdtReg.jis2?.filler = "a90000${Mcd.MCD_RLSCRDTCD}300000000000000000000000000000000${Mcd.MCD_RLSCRDTCD2}${mbrCd}00000000";
      cMem.working.crdtReg.jis2flg = 1;
    }
    else if ((tsBuf.vega.vegaData.cardData1[1] == "a")
      && (cardData1.substring(7, 7+Mcd.MCD_RLSVISACD.length) == Mcd.MCD_RLSVISACD)
      && (cardData2.substring(15, 15+Mcd.MCD_RLSVISACD2.length) == Mcd.MCD_RLSVISACD2) ) {
      //RARAVISAクレジットカード
      atSing.mbrTyp = Mcd.MCD_RLSVISA;
      mbrCd = cardData2.substring(20, 32);  //12桁
      // todo クレ宣言　暫定対応7　jis2にStringを代入させるため、fillerに格納
      // cMem.working.crdtReg.jis2 = "a90000${Mcd.MCD_RLSVISACD}400000000000000000000000000000000${Mcd.MCD_RLSVISACD2}${mbrCd}00000000";
      cMem.working.crdtReg.jis2?.mbrNo = "";
      cMem.working.crdtReg.jis2?.cdKind = "";
      cMem.working.crdtReg.jis2?.insLim = "";
      cMem.working.crdtReg.jis2?.filler = "a90000${Mcd.MCD_RLSVISACD}400000000000000000000000000000000${Mcd.MCD_RLSVISACD2}${mbrCd}00000000";
      cMem.working.crdtReg.jis2flg = 1;
    }
    else if ((tsBuf.vega.vegaData.cardData1[1] == "s")
      && (cardData1.substring(7, 7+Mcd.MCD_RLSJACCSCD.length) == Mcd.MCD_RLSJACCSCD)
      && (cardData2.substring(15, 15+Mcd.MCD_RLSJACCSCD2.length) == Mcd.MCD_RLSJACCSCD2) ) {
      //RARAJACCSクレジットカード
      atSing.mbrTyp = Mcd.MCD_RLSJACCS;
      mbrCd = cardData2.substring(20, 32);  //12桁
      // todo クレ宣言　暫定対応7　jis2にStringを代入させるため、fillerに格納
      // cMem.working.crdtReg.jis2 = "s50000${Mcd.MCD_RLSJACCSCD}500000000000000000000000000000000${Mcd.MCD_RLSJACCSCD2}${mbrCd}00000000";
      cMem.working.crdtReg.jis2?.mbrNo = "";
      cMem.working.crdtReg.jis2?.cdKind = "";
      cMem.working.crdtReg.jis2?.insLim = "";
      cMem.working.crdtReg.jis2?.filler = "s50000${Mcd.MCD_RLSJACCSCD}500000000000000000000000000000000${Mcd.MCD_RLSJACCSCD2}${mbrCd}00000000";
      cMem.working.crdtReg.jis2flg = 1;
    }
    else if ((tsBuf.vega.vegaData.cardData1[2] == "9")
      && (cardData1.substring(7, 7+Mcd.MCD_RLSSTAFFCD.length) == Mcd.MCD_RLSSTAFFCD)
      && (tsBuf.vega.vegaData.cardData2[2] == "9")
      && (cardData2.substring(7, 7+Mcd.MCD_RLSSTAFFCD.length) == Mcd.MCD_RLSSTAFFCD) ) {
      //社員カード
      atSing.mbrTyp = Mcd.MCD_RLSSTAFF;
      mbrCd = cardData2.substring(12, 27);  //15桁
      // todo クレ宣言　暫定対応7　jis2にStringを代入させるため、fillerに格納
      // cMem.working.crdtReg.jis2 = "Z90000${Mcd.MCD_RLSSTAFFCD}0${mbrCd}000000000000000000000000000000000000000000";
      cMem.working.crdtReg.jis2?.mbrNo = "";
      cMem.working.crdtReg.jis2?.cdKind = "";
      cMem.working.crdtReg.jis2?.insLim = "";
      cMem.working.crdtReg.jis2?.filler = "Z90000${Mcd.MCD_RLSSTAFFCD}0${mbrCd}000000000000000000000000000000000000000000";
      cMem.working.crdtReg.jis2flg = 1;
    }
    else {
      atSing.mbrTyp = Mcd.MCD_RLSOTHER;
    }
  }
}