/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../fb/fb_lib.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemreason.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/dy_sel.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/apllib/apllib_strutf.dart';
import '../inc/L_rc_reason.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_28dsp.dart';
import 'rc_ext.dart';
import 'rc_gtktimer.dart';
import 'rc_ifevent.dart';
import 'rc_itm_dsp.dart';
import 'rc_mbr_com.dart';
import 'rc_multi.dart';
import 'rc_qc_dsp.dart';
import 'rc_qrinf.dart';
import 'rcfncchk.dart';
import 'rcky_clr.dart';
import 'rckyccin.dart';
import 'rckycncl.dart';
import 'rckypchg.dart';
import 'rcqc_com.dart';
import 'rcqr_com.dart';
import 'rcsyschk.dart';

class RcReason {
  /// 関連tprxソース: rc_reason.h
  static const REASON_KIND_DEF = 0;
  static const REASON_KIND_REF = 6;  /* 返品理由 */
  static const REASON_KIND_CNCL = 7;  /* 取消理由 */
  static const REASON_KIND_VOID = 8;  /* 訂正理由 */
  static const REASON_KIND_PCHG = 47;  /* 売価変更理由 */
  static const REASON_KIND_DRW = 48;  /* 両替理由 */

  static Reason reason = Reason();

  /// 理由選択画面を表示するかチェックする
  /// 引数: ファンクションコード
  /// 戻り値: true=表示  false=非表示
  /// 関連tprxソース:rc_reason.c - rcReasonDisplay, rcReasonDisplay2
  static Future<bool> rcReasonDisplay(int fncCode) async {
    if (RcSysChk.rcChkReasonSelectSystem()) {
      RegsMem mem = SystemFunc.readRegsMem();
      if (mem.prnrBuf.reason.stat == 0) {
        /* 理由選択プログラム未動作 */
        if (await _rcChkReasonDisplay(fncCode)) {
          return true;
        }
      }
      else {
        if (mem.prnrBuf.reason.reasonStat == -1) {
          /* -1:理由入力無し */
          await RckyClr.rcKyClr();
          return false;
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "RcReason.rcReasonDisplay(): ${mem.prnrBuf.reason.name}");
      }
    }
    return false;
  }

  /// 理由選択画面の表示条件チェック
  /// 引数: ファンクションコード
  /// 戻り値: true=表示可能  false=表示不可
  /// 関連tprxソース:rc_reason.c - rcChk_ReasonDisplay
  static Future<bool> _rcChkReasonDisplay(int fncCode) async {
    if (!RcSysChk.rcChkReasonSelectSystem()) {
      /* 理由選択仕様承認キー */
      return false;
    }
    if (_rcReasonCheckKeyOption(fncCode) == 0) {
      /* キーオプションチェック */
      return false;
    }
    if (!RcSysChk.rcRGOpeModeChk()
        && !RcSysChk.rcTROpeModeChk()
        && !RcSysChk.rcVDOpeModeChk()) {
      /*「登録モード、訓練モード、訂正モード」以外 */
      return false;
    }
    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_VOID.keyId])) {
      /* 指定訂正 */
      return false;
    }
    if (RcqrCom.qrTxtStatus == QrTxtStatus.QR_TXT_STATUS_READ.index) {
      /* QR読込中 */
      return false;
    }
    if ((await RcSysChk.rcChkShopAndGoSystem())
        && (await RcMbrCom.rcmbrChkStat() != 0)
        && (RcQcDsp.qCashierIni.shopAndGoMbrChkDsp == QcMbrDspStatus.QC_MBRDSP_STATUS_BEFORE_READ.index)
        && RcFncChk.rcQCCheckStartDspMode()) {
      /* Shop&Go仕様 and 会員システム and 会員画面先表示 and スタート画面 */
      /* 会員読込後、買い物客操作で取消を行う場合は表示しない */
      return false;
    }
    if (RcSysChk.rcChkMultiEdySystem() == MultiEdyTerminal.EDY_VEGA_USE.index) {
      if (RcQcCom.qc_alarm_flag != 0) {
        return false;
      }
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if (RcGtkTimer.rcGtkTimerAdd(10, _rcPrgReasonDisplay) == Typ.OK) {
      await RcExt.rxChkModeSet("RcReason._rcChkReasonDisplay()");
      mem.prnrBuf.reason = RxMemReason();
      reason = Reason();
      reason.fncCodeSave = fncCode;  /* 理由を選択するファンクションキー */
      return true;
    }
    return false;
  }

  ///「理由選択画面の表示」キーオプションチェック
  /// 引数: ファンクションコード
  /// 戻り値: 1=オプションあり  false=オプションなし
  /// 関連tprxソース:rc_reason.c - rcReason_CheckKeyOption
  static int _rcReasonCheckKeyOption(int fncCode) {
    if (RcSysChk.rcChkReasonSelectSystem()) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      RxCommonBuf cBuf = xRet.object;

      /* 理由選択承認キー確認 */
      if (fncCode == FuncKey.KY_PCHG.keyId) {
        /* 売価変更 */
        if (RcSysChk.rcCheckTECOperation() != 0) {
          /* 値引-後のみ */
          return cBuf.dbKfnc[fncCode].opt.pchg.reasonSelectDisp;
        }
      }
      else if (fncCode == FuncKey.KY_RFDOPR.keyId) {
        /* 返品ﾓｰﾄﾞ */
        return cBuf.dbKfnc[fncCode].opt.refOpr.reasonSelectDisp;
      }
      else if (fncCode == FuncKey.KY_RCPT_VOID.keyId) {
        /* 通番訂正 */
        return cBuf.dbKfnc[fncCode].opt.rcptvoid.reasonSelectDisp;
      }
      else if (fncCode == FuncKey.KY_DRW.keyId) {
        /* 両替 */
        return cBuf.dbKfnc[fncCode].opt.drw.reasonSelectDisp;
      }
      else if (fncCode == FuncKey.KY_CNCL.keyId) {
        /* 取消 */
        return cBuf.dbKfnc[fncCode].opt.cncl.reasonSelectDisp;
      }
    }
    return 0;
  }

  /// 理由選択仕様のメインプログラム
  /// 関連tprxソース:rc_reason.c - rcPrg_ReasonDisplay
  static Future<void> _rcPrgReasonDisplay() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    RcGtkTimer.rcGtkTimerRemove();
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcReason._rcPrgReasonDisplay(): start");

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    mem.prnrBuf.reason.stat = 1;

    if (FbInit.subinitMainSingleSpecialChk()) {
      cMem.stat.dualTSingle = cBuf.devId;
    }
    else {
      cMem.stat.dualTSingle = 0;
    }
    if (cMem.stat.fncCode != FuncKey.KY_CHG_SELECT_ITEMS.keyId) {
      /* 指定変更中にはお金を出さない */
      await RcKyccin.rcOthConnectAcrAcbStop();
    }
    _rcInitDySelreason();	/* 種別コード、タイトル名称などセット */

    if (cMem.stat.fncCode != FuncKey.KY_CHG_SELECT_ITEMS.keyId) {
      if (FbInit.subinitMainSingleSpecialChk()) {
        cMem.scrData.msgLcd = "${reason.titleName}";
        if (cMem.stat.dualTSingle == 1) {
          RcItmDsp.DualTSingleDlg(cMem.scrData.msgLcd, 0);
        }
        else {
          RcItmDsp.DualTSingleDlg(cMem.scrData.msgLcd, 1);
        }
      }
    }
    _rcDySelreason();	/* 理由画面表示 */

    await _rcReasonEnd();

    mem.prnrBuf.reason.stat = 0;
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcReason._rcPrgReasonDisplay(): end");
  }

  /// 種別コード、タイトル名称などをセット
  /// 関連tprxソース:rc_reason.c - rcInit_dy_selreason
  static void _rcInitDySelreason() {
    int imgNo = 0;
    if (reason.fncCodeSave == FuncKey.KY_DRW.keyId) {
      /* 両替はイメージを利用 */
      imgNo = ImageDefinitions.IMG_DRW;
    }
    else {
      imgNo = reason.fncCodeSave;
    }

    FuncKey fncCode = FuncKey.getKeyDefine(reason.fncCodeSave);
    switch (fncCode) {
      case FuncKey.KY_RFDOPR:  /* 返品ﾓｰﾄﾞ */
        reason.kindCode = REASON_KIND_REF;
        break;
      case FuncKey.KY_CNCL:  /* 取消 */
        reason.kindCode = REASON_KIND_CNCL;
        break;
      case FuncKey.KY_RCPT_VOID:  /* 通番訂正 */
        reason.kindCode = REASON_KIND_VOID;
        break;
      case FuncKey.KY_PCHG:  /* 売価変更 */
        reason.kindCode = REASON_KIND_PCHG;
        break;
      case FuncKey.KY_DRW:  /* 両替 */
        reason.kindCode = REASON_KIND_DRW;
        break;
      default:
        reason.kindCode = REASON_KIND_DEF;
        break;
    }

    String imgBuf = "";
    AplLibImgRead.aplLibImgRead(imgNo, imgBuf, 16);
    reason.titleName = "$imgBuf${LRcReason.REASON_TITLE}";

    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.errStat = 1;
  }

  /// 理由選択画面を表示
  /// 関連tprxソース:rc_reason.c - rc_dy_selreason
  static void _rcDySelreason() {
    Rc28dsp.rc28MainWindowSizeChange(1);

    AcMem cMem = SystemFunc.readAcMem();
    ReasonSelStruct	reasonSel = ReasonSelStruct();  // 選択関数に対する引数構造体

    reasonSel.kindCode	= reason.kindCode;  // 理由選択の区分コード
    reasonSel.titleBackColor = FbColorGroup.Purple.index;  // タイトルの背景色
    reasonSel.dualMode	= cMem.stat.dualTSingle;  // 一人制の時の操作画面
    reasonSel.titleName	= reason.titleName;  // タイトル
    reasonSel.guidanceName	= LRcReason.REASON_GUIDANCE;  // ガイダンス

    // 選択画面描画
    // TODO:10122 グラフィクス処理（gtk_*）
    /*
    RegsMem mem = SystemFunc.readRegsMem();
    mem.prnrBuf.reason.reasonStat = dy_selreason(await RcSysChk.getTid(), &reasonSel); // 非選択で-1を返す, 選択で 0を返す.
    if (mem.prnrBuf.reason.reasonStat != -1) {  /* 理由を選択した場合 */
      /* 理由選択確認フラグ */
      mem.prnrBuf.reason.reasonStat = 1;
      mem.prnrBuf.reason.reasonMst = reasonSel.reasonMst;
      mem.prnrBuf.reason.reasonMst.name = AplLibStrUtf.aplLibEucAdjust(mem.prnrBuf.reason.reasonMst.name!, 101, 100).$2;
      /* 理由コード */
      mem.prnrBuf.reason.reasonCd = mem.prnrBuf.reason.reasonMst.div_cd!;
      /* 種別コード */
      mem.prnrBuf.reason.kindCd = mem.prnrBuf.reason.reasonMst.kind_cd!;
      /* 理由区分名称 */
      mem.prnrBuf.reason.name = mem.prnrBuf.reason.reasonMst.name!;
    }
     */
  }

  /// 理由選択した後の処理
  /// 関連tprxソース:rc_reason.c - rcReason_End
  static Future<void> _rcReasonEnd() async {
    await RcIfEvent.rxChkModeSaveReset(); /* イベント情報を削除してリセット */
    Rc28dsp.rc28MainWindowSizeChange(0);

    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.fncCode != FuncKey.KY_CHG_SELECT_ITEMS.keyId) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) {
        if (FbInit.subinitMainSingleSpecialChk()) {
          RcItmDsp.dualTSingleDlgClear();
        }
        RcItmDsp.dualTSingleCshrTendChgClr();
      }
    }
    cMem.ent.errStat = 0;

    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.prnrBuf.reason.reasonStat == (-1)) {
      /* 理由入力がなかった場合 */
      switch (cMem.stat.fncCode) {
        case 59:  /* FuncKey.KY_CNCL.keyId: 取消 */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "RcReason._rcReasonEnd(): EXECUTE rcPrg_Ky_Cncl_Confirm_no_clicked()");
          await RcKyCncl.rcPrgKyCnclConfirmNoClicked();
          break;
        case 367:  /* FuncKey.KY_RFDOPR.keyId: 返品ﾓｰﾄﾞ */
        case 451:  /* FuncKey.KY_RCPT_VOID.keyId: 通番訂正 */
        case 153:  /* FuncKey.KY_PCHG.keyId: 売価変更 */
        case 463:  /* FuncKey.KY_CHG_SELECT_ITEMS.keyId: 指定変更（売価変更） */
        case 51:  /* FuncKey.KY_DRW.keyId: 両替 */
          break;
        default:
          break;
      }
    }
    else {
      /* 理由入力があった場合 */
      switch (cMem.stat.fncCode) {
        case 367:  /* FuncKey.KY_RFDOPR.keyId: 返品ﾓｰﾄﾞ */
        case 451:  /* FuncKey.KY_RCPT_VOID.keyId: 通番訂正 */
        case 51:  /* FuncKey.KY_DRW.keyId: 両替 */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "RcReason._rcReasonEnd(): EXECUTE rcD_Key() cMem.stat.fncCode[${cMem.stat.fncCode}]");
          // TODO: cMem.stat.fncCodeをフロントに渡して指示するため、rcD_Key()をコメント化
          //rcD_Key();
          break;
        case 153:  /* FuncKey.KY_PCHG.keyId: 売価変更 */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "RcReason._rcReasonEnd(): EXECUTE rcKyPrcChg");
          RcKyPrcChg.rcKyPrcChg();
          break;
        case 59:  /* FuncKey.KY_CNCL.keyId: 取消 */
          if (await RcSysChk.rcQCChkQcashierSystem()) {
            //rcQC_MenteCnclKyPrg(0);
          }
          else {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "RcReason._rcReasonEnd(): EXECUTE rcPrgKyCnclConfirmYesClicked()");
            await RcKyCncl.rcPrgKyCnclConfirmYesClicked();
          }
          break;
        case 463:  /* FuncKey.KY_CHG_SELECT_ITEMS.keyId: 指定変更（売価変更） */
          if (reason.fncCodeSave == FuncKey.KY_PCHG.keyId) {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "RcReason._rcReasonEnd(): EXECUTE rcChgSelectItemsPchgFncMain()");
            //rcChgSelectItems_PchgFnc_Main();
          }
          break;
        default:
          break;
      }
    }

  }

  /// 関数 : rcReason_SetData2
  /// 機能 : 理由実績セット、選択した理由情報のクリア
  /// 引数 : p: アイテムカウント(アイテムログ実績のみ使用)
  //// 戻値 : なし
  /// 関連tprxソース:rc_reason.c - rcReason_SetData2（rcReason_SetData）
  static Future<void> rcReasonSetData({int p = -1}) async {
    if (!RcSysChk.rcChkReasonSelectSystem())			/* 理由選択承認キー確認 */
    {
      return;
    }

    if (_rcReasonCheckKeyOption(reason.fncCodeSave) == 0)	/* キーオプション確認 */
    {
      return;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.prnrBuf.reason.reasonCd == 0)			/* 理由が選択されていない */
    {
      return;
    }

    if (reason.fncCodeSave == FuncKey.KY_PCHG.keyId)			/* 売価変更 */
    {
      if (p == -1)
      {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcReason_SetData2 p == -1 return !!");
        return;
      }
      mem.tItemLog[p].t10400.itemPrcChgReasonCd = mem.prnrBuf.reason.reasonCd;
      mem.tItemLog[p].t10400.itemPrcChgReasonName = mem.prnrBuf.reason.name;
    }
    else if ((reason.fncCodeSave == FuncKey.KY_RFDOPR.keyId)		/* 返品ﾓｰﾄﾞ */
      || (reason.fncCodeSave == FuncKey.KY_RCPT_VOID.keyId)	/* 通番訂正 */
      || (reason.fncCodeSave == FuncKey.KY_DRW.keyId)		/* 両替 */
      || (reason.fncCodeSave == FuncKey.KY_CNCL.keyId) )		/* 取消 */
    {
      mem.tTtllog.t100003.reasonKindCd = mem.prnrBuf.reason.kindCd;
      mem.tTtllog.t100003.reasonCd = mem.prnrBuf.reason.reasonCd;
      mem.tTtllog.t100003.reasonName = mem.tTtllog.t100003.reasonName;
    }
    mem.prnrBuf.reason = RxMemReason();    /* 実績セット後、理由選択内容をクリア */
  }
}

///  関連tprxソース: rc_reason.c - struct REASON
class Reason {
  int fncCodeSave = 0;  // キー押下情報保持
  int kindCode = 0;  // 区分コード
  String titleName = "";  // 理由選択タイトル
}