/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../tprlib/TprLibDlg.dart';
import '../inc/rc_basket_server.dart';
import '../inc/rc_custreal2.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_itm_dsp.dart';
import 'rc_key_stf_release.dart';
import 'rc_point_infinity.dart';
import 'rc_qrinf.dart';
import 'rc_reason.dart';
import 'rcfncchk.dart';
import 'rcky_cashvoid.dart';
import 'rcky_clr.dart';
import 'rcqr_com.dart';
import 'rcsp_recal.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

///  関連tprxソース: rckycncl.c
class RcKyCncl {
  static int cnclDlgMode = 0;    //「取消」の確認ダイアログで表示する「ﾒｯｾｰｼﾞｺｰﾄﾞ」を保持する

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rckycncl.c - rcSG_MntEnd_BtnDelete
  static void rcSGMntEndBtnDelete() {
    return ;
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rckycncl.c - rcKyCncl
  static void rcKyCncl() {
    return;
  }

  /// 顧客リアル[PI]仕様 ポイント利用の取消を要求する
  /// 戻り値: エラーコード
  /// 関連tprxソース:rckycncl.c - rc_Cncl_CustReal_Pi_Sprit()
  static Future<int> rcCnclCustRealPiSprit() async {
    int errNo = 0;
    RegsMem mem = SystemFunc.readRegsMem();

    if (mem.tTtllog.t100700.realCustsrvFlg == 0) {
      /* オフラインではない場合 */
      if ((await RcFncChk.rcCheckCrdtVoidIMode()) || /* クレジット訂正中かチェック */
          (await RcFncChk.rcCheckCrdtVoidSMode()) || /* クレジット訂正中かチェック */
          (await RcFncChk.rcCheckESVoidIMode()) || /* 検索訂正中かチェック */
          (await RcFncChk.rcCheckESVoidSMode()) || /* 検索訂正中かチェック */
          (await RcFncChk.rcCheckERefIMode()) || /* 検索返品中かチェック */
          (await RcFncChk.rcCheckERefSMode()) || /* 検索返品中かチェック */
          (await RcFncChk.rcCheckPrecaVoidIMode()) || /* プリカ訂正中かチェック */
          (await RcFncChk.rcCheckPrecaVoidSMode()) || /* プリカ訂正中かチェック */
          RckyCashVoid.rcCheckCashVoidDsp()) {
        /* 金種訂正中かチェック */
        return errNo;
      }
      // ポイント利用している場合
      // ※売上げNoの設定可否で判断
      if (mem.tTtllog.t100760.riyoUriageNo.isNotEmpty) {
        /* ポイント利用の取消を要求する */
        errNo = RcPointInfinity.rcPointInfinityRequest(
            CustReal2Hi.CUSTREAL2_HI_MBR_USE_CNCL.index, 0);
      }
      // ポイント付与している場合
      // ※売上げNoの設定可否で判断
      if (mem.tTtllog.t100760.fuyoUriageNo.isNotEmpty && (errNo == 0)) {
        /* ポイント付与キャンセルを実行 */
        errNo = RcPointInfinity.rcPointInfinityRequest(
            CustReal2Hi.CUSTREAL2_HI_MBR_ADD_CNCL.index, 0);
      }
    }
    return errNo;
  }

  /// "確認ダイアログを利用しない「検索訂正」など" の動作中かをチェック
  /// 戻り値: true=確認ダイアログを利用する  false=認ダイアログを利用しない
  /// 関連tprxソース:rckycncl.c - rcPrg_Ky_Cncl_ModeChk()
  static Future<bool> rcPrgKyCnclModeChk() async {
    // 訂正の小計画面
    if ( ((await RcFncChk.rcCheckERefMode()) ||
        (await RcFncChk.rcCheckERefSMode()) ||
        (await RcFncChk.rcCheckERefIMode()) ||
        (await RcFncChk.rcCheckERefRMode()) )  /* 検索返品 */
        || ((await RcFncChk.rcCheckESVoidMode()) ||
            (await RcFncChk.rcCheckESVoidSMode()) ||
            (await RcFncChk.rcCheckESVoidIMode()) ||
            (await RcFncChk.rcCheckESVoidVMode()) ||
            (await RcFncChk.rcCheckESVoidSDMode()) ||
            (await RcFncChk.rcCheckESVoidCMode()))  /* 検索訂正 */
        || ((await RcFncChk.rcCheckPrecaVoidMode()) ||
            (await RcFncChk.rcCheckPrecaVoidSMode()) ||
            (await RcFncChk.rcCheckPrecaVoidIMode()))  /* プリカ訂正 */
        || ((await RcFncChk.rcCheckCrdtVoidMode()) ||
            (await RcFncChk.rcCheckCrdtVoidSMode()) ||
            (await RcFncChk.rcCheckCrdtVoidIMode()) ||
            (await RcFncChk.rcCheckCrdtVoidAMode()))  /* クレジット訂正 */
    ) {
      return false;
    }
    if (RcspRecal.rcSpRecalGetSpAllCnclFlg() != 0) {
      return false;
    }
    return true;
  }

  /// "取消しますか"文言を、""文言で上書きする
  /// 引数: 画面種類（0=登録画面  0以外=小計画面）
  /// 関連tprxソース:rckycncl.c - rcPrg_Ky_Cncl_ResetLabel
  static Future<void> rcPrgKyCnclResetLabel(int type) async {
    // 確認ダイアログを利用しないモード
    if (!(await rcPrgKyCnclModeChk())) {
      return;  // 上書きなし
    }
    // Happyのフルセルフ状態(フルセルフのメンテナンス中を除く) での操作の場合
    if ((await RcSysChk.rcNewSGChkNewSelfGateSystem())
        && (await RcSysChk.rcChkSmartSelfSystem())
        && !RcFncChk.rcSGCheckMntMode()) {
      return; // 上書きなし
    }
    // フルセルフ での操作の場合
    if (CompileFlag.SELF_GATE) {
      if ((await RcSysChk.rcSGChkSelfGateSystem())
          && !RcFncChk.rcSGCheckMntMode()) {
        return; // 上書きなし
      }
    }
    // QCasher側で操作の場合	// フルセルフのメンテナンス中は QC に切り替わるので、ここでチェック
    if ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)
        && (await RcSysChk.rcQCChkQcashierSystem())) {
      return; // 上書きなし
    }

    // TODO:10122 グラフィックス処理
    /*
    // 登録画面のとき
    if (type == 0) {
      // 商品表示領域に "取消しますか?" は表示しない（空を設定）。
      // rc28Lcd_Price()は共通処理なので、個別の処理はここで行う
      if (Tran.nm_entry) {
        gtk_label_set(GTK_LABEL(Tran.nm_entry), "" );
      }
      // rcOnOffDsp_ItemMode() で再描画されるので、元データをクリアしておく
      cm_clr((char *)&Tran.off_item_name, sizeof(Tran.off_item_name));
      if (FbInit.subinitMainSingleSpecialChk()) {
        if (RegsDef.dualSubttl.stlTendChg) {
          gtk_label_set(GTK_LABEL(RegsDef.dualSubttl.stlTendChg), "");
        }
      }
    }
    // 小計画面のとき
    else {
      // 合計額下の領域に "取消しますか?" は表示しない。（空を設定）
      // rcStlLcd_Sprit_Cncl()は共通処理なので、個別の処理はここで行う
      if (RegsDef.subttl.stlTendChg) {
        if (!RcFncChk.rcCheckSpritMode()) {
          gtk_label_set(GTK_LABEL(RegsDef.subttl.stlTendChg), "");
        }
        else {
          Fb2Gtk.gtkRoundEntrySetText(GTK_ROUND_ENTRY(RegsDef.subttl.stlTendChg), "");
        }
      }
      if (FbInit.subinitMainSingleSpecialChk()) {
        if (RegsDef.dualSubttl.stlTendChg) {
          if (!RcFncChk.rcCheckSpritMode()) {
            gtk_label_set(GTK_LABEL(RegsDef.dualSubttl.stlTendChg), "");
          }
          else {
            Fb2Gtk.gtkRoundEntrySetText(GTK_ROUND_ENTRY(RegsDef.dualSubttl.stlTendChg), "");
          }
        }
      }
    }

    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem() ) {
        // 店員操作画面 ※windowリソースがある場合にのみ実行する
        if ((RcSgDsp.mntDsp.window) && (RcSgDsp.mntDsp.ent_entry)) {
          Fb2Gtk.gtkRoundEntrySetText(GTK_ROUND_ENTRY(RcSgDsp.mntDsp.ent_entry), "");
        }
      }
    }
     */
  }

  ///「取消」キー押下時の確認ダイアログ表示
  /// 引数: エラーNo
  /// 関連tprxソース:rckycncl.c - rcPrg_Ky_Cncl_Confirm
  static Future<void> rcPrgKyCnclConfirm(int code) async {
    String callFunc = "RcKyCncl.rcPrgKyCnclConfirm()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, callFunc);

    // 確認ダイアログを利用しないモード
    if (!(await rcPrgKyCnclModeChk())) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: illegalMode");
      return;
    }
    // Happyのフルセルフ状態(フルセルフのメンテナンス中を除く) での操作の場合
    if ((await RcSysChk.rcNewSGChkNewSelfGateSystem())
        && (await RcSysChk.rcChkSmartSelfSystem())
        && !RcFncChk.rcSGCheckMntMode()) {		/* 店員操作画面 でない */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: HappyFullself");
      return;
    }
    // TODO:10122 グラフィックス処理
    /*
    // HappySelf + 旧メンテ画面 + 登録画面の取消キー押下で表示される画面
    if ((await RcSysChk.rcChkSmartSelfSystem())
        && RcFncChk.rcSGCheckMntMode()
        && (RcSgDsp.mntDsp.cncl_pixmap != NULL)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: HappySelf ItemCancelWindow");
      return;
    }
     */
    // フルセルフ での操作の場合
    if (CompileFlag.SELF_GATE) {
      if ((await RcSysChk.rcSGChkSelfGateSystem())
          && !RcFncChk.rcSGCheckMntMode()) {  /* 店員操作画面 でない */
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: SelfGateFullself");
        return;
      }
    }
    // QCasher側で操作の場合	// フルセルフのメンテナンス中は QC に切り替わるので、ここでチェック
    if ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER)
        && (await RcSysChk.rcQCChkQcashierSystem())) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: CasherSide");
      return;
    }
    cnclDlgMode = code; // 処理対象のコードを保持

    if ((RcSysChk.rcChkReasonSelectSystem())
      && (cnclDlgMode == DlgConfirmMsgKind.MSG_CANCEL_CONF.dlgId)) {  /* 理由選択仕様 & 取引取消 */
      AcMem cMem = SystemFunc.readAcMem();
      if (await RcReason.rcReasonDisplay(cMem.stat.fncCode)) {  /* 理由選択画面表示（取消） */
        if (!RcSysChk.rcChkToySystem()) {
          RcKyStfRelease.rcPrgStfReleaseRestore();
          /* 登録画面下部「従業員権限解除」表示更新 */
          if (await RcFncChk.rcCheckItmMode()) {
            await RcItmDsp.rcDspSusmkLCD();
          }
          else if (await RcFncChk.rcCheckStlMode()) {
            await RcStlLcd.rcStlLcdSusReg(RegsDef.subttl);
          }
          if (FbInit.subinitMainSingleSpecialChk()) {
            await RcStlLcd.rcStlLcdSusReg(RegsDef.dualSubttl);
          }
        }
        return;
      }
    }

    if (RcqrCom.qrTxtStatus == QrTxtStatus.QR_TXT_STATUS_READ.id) {
      /* QR読込中はダイアログ表示させない */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: QR_TXT_STATUS_READ");
      return;
    }

    tprDlgParam_t param = tprDlgParam_t();

    param.erCode = code;
    param.dialogPtn = DlgPattern.TPRDLG_PT1.dlgPtnId;
    param.func1 = rcPrgKyCnclConfirmYesClicked;
    param.msg1 = LTprDlg.BTN_YES;
    param.func2 = rcPrgKyCnclConfirmNoClicked;
    param.msg2 = LTprDlg.BTN_NO;

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_DUALCSHR:
        param.dual_dev = 1;
        TprLibDlg.tprLibDlg2(callFunc, param);
        break;
      case RcRegs.KY_SINGLE:
        TprLibDlg.tprLibDlg2(callFunc, param);
        if (FbInit.subinitMainSingleSpecialChk()) {
          param.dual_dsp = 3;
          TprLibDlg.tprLibDlg2(callFunc, param);
        }
        break;
      default:  // KY_CHECKER/KY_CASHIER/DESKTOPTYPE
        TprLibDlg.tprLibDlg2(callFunc, param);
        break;
    }
  }

  ///「取消」キー押下時の確認ダイアログ表示 -> "はい"押下時処理
  /// 引数: エラーNo
  /// 関連tprxソース:rckycncl.c - rcPrg_Ky_Cncl_Confirm_yes_clicked
  static Future<void> rcPrgKyCnclConfirmYesClicked() async {
    String callFunc = "RcKyCncl.rcPrgKyCnclConfirmYesClicked()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, callFunc);
    TprDlg.tprLibDlgClear(callFunc);

    AcMem cMem = SystemFunc.readAcMem();

    // 「取消」処理を実行する
    if ((cnclDlgMode == DlgConfirmMsgKind.MSG_MBR_CANCEL_CONF.dlgId)
        || (cnclDlgMode == DlgConfirmMsgKind.MSG_STAFF_CANCEL_CONF.dlgId)
        || (cnclDlgMode == DlgConfirmMsgKind.MSG_OTHCARD_CANCEL_CONF.dlgId)
          || (cnclDlgMode == DlgConfirmMsgKind.MSG_RECEIV_CANCEL_CONF.dlgId) ) {
      // 会員取消 or 社員取消 or 他社取消 or 掛売取消
      cMem.stat.fncCode = FuncKey.KY_MBRCLR.keyId;
      // TODO: cMem.stat.fncCodeをフロントに渡して指示するため、rcD_Key()をコメント化
      //rcD_Key();
    }
    else if (cnclDlgMode == DlgConfirmMsgKind.MSG_SP_CANCEL_CONF.dlgId)	{
      // 締め取消
      cMem.stat.fncCode = FuncKey.KY_SPCNCL.keyId;
      // TODO: cMem.stat.fncCodeをフロントに渡して指示するため、rcD_Key()をコメント化
      //rcD_Key();
    }
    else if ((cnclDlgMode == DlgConfirmMsgKind.MSG_CANCEL_CONF.dlgId)
        || (cnclDlgMode == DlgConfirmMsgKind.MSG_TEXT137.dlgId) )	{
      // 取引の取消 or スプリットの取消
      if (cnclDlgMode == DlgConfirmMsgKind.MSG_CANCEL_CONF.dlgId) {
        if (await CmCksys.cmWsSystem() != 0) {
          await RckyClr.rcChkWScouponBarInfoClear(FuncKey.KY_CNCL);
        }
      }
      cMem.stat.fncCode = FuncKey.KY_CNCL.keyId;
      // TODO: cMem.stat.fncCodeをフロントに渡して指示するため、rcD_Key()をコメント化
      //rcD_Key();
    }
    else if ( cnclDlgMode == DlgConfirmMsgKind.MSG_PRECA_CANCEL_CONF.dlgId) {
      cMem.stat.fncCode = FuncKey.KY_PRECA_CLR.keyId;
      // TODO: cMem.stat.fncCodeをフロントに渡して指示するため、rcD_Key()をコメント化
      //rcD_Key();
    }
    else {
      // 対象外
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if ((RcSysChk.rcChkShopAndGoDeskTopSystem())
        && (mem.qcSaGDataSetflg != 0)) {  //卓上機Shop&Go仕様 and Shop&Go商品登録チェック
      // 締め操作後にバスケットサーバーのカートの状態更新（POS端末で取消）
      RcqrCom.rcSaGBasketServerUpload(RcBascketServer.SHOP_A_GO_CART_STS_POS_CANCEL);
      mem.qcSaGDataSetflg = 0;		// 卓上機にてShop&Go商品読込フラグをリセットする。
    }
    cnclDlgMode = 0;	// ダイアログ表示状態クリア
  }

  ///「取消」キー押下時の確認ダイアログ表示 -> "いいえ"押下時処理
  /// 引数: エラーNo
  /// 関連tprxソース:rckycncl.c - rcPrg_Ky_Cncl_Confirm_no_clicked
  static Future<void> rcPrgKyCnclConfirmNoClicked() async {
    String callFunc = "RcKyCncl.rcPrgKyCnclConfirmNoClicked()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, callFunc);
    TprDlg.tprLibDlgClear(callFunc);

    AcMem cMem = SystemFunc.readAcMem();

    // "C"キー押下の処理を実行
    cMem.stat.fncCode = FuncKey.KY_CLR.keyId;
    // TODO: cMem.stat.fncCodeをフロントに渡して指示するため、rcD_Key()をコメント化
    //rcD_Key();
    cnclDlgMode = 0;	// ダイアログ表示状態クリア
  }

  /// TODO:00010 定義のみ追加
  ///  関連tprxソース: rckycncl.c - rcClr_2nd_Cncl_Sprit
  static void rcClr2ndCnclSprit() {}

  /// TODO:00010 定義のみ追加
  ///  関連tprxソース: rckycncl.c - rcEnd_2nd_Cncl_Sprit
  static void rcEnd2ndCnclSprit() {}
}