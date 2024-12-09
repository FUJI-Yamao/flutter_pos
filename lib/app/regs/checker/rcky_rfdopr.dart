/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_59hitouch.dart';
import 'package:flutter_pos/app/regs/checker/rc_elog.dart';
import 'package:flutter_pos/app/regs/checker/rc_reason.dart';
import 'package:flutter_pos/app/regs/checker/rc_voidupdate.dart';
import 'package:flutter_pos/app/regs/checker/rcky_hitouch.dart';
import 'package:flutter_pos/app/regs/checker/rxregstr.dart';
import 'package:get/get.dart';

import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_dpoint.dart';
import '../../inc/apl/rxmemreason.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/db/c_item_log.dart';
import '../../inc/db/c_itemlog_sts.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/db/c_ttllog_sts.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apl_cnv/log_mref.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/receipt_void/p_receipt_scan.dart';
import '../common/rx_log_calc.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import '../inc/rp_print.dart';
import 'rc_clxos_payment.dart';
import 'rc_mbr_com.dart';
import 'rc_recno.dart';
import 'rc_set.dart';
import 'rc_setdate.dart';
import 'rc_stl.dart';
import 'rcfncchk.dart';
import 'rcitmchk.dart';
import 'rckycrdtvoid.dart';
import 'rcmanualmix.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcky_rfdopr.c
class RckyRfdopr {
  //---------------------------------------------------------------------------------
  //	Values
  //---------------------------------------------------------------------------------
  ///関連tprxソース: rcky_rfdopr.c - RfdOprFuncChk_List0
  static List<int> rfdOprFuncChkList0 = [0];
  ///関連tprxソース: rcky_rfdopr.c - RfdOprFuncChk_List1
  static List<int> rfdOprFuncChkList1 = [0];
  ///関連tprxソース: rcky_rfdopr.c - RfdOprFuncChk_List2
  static List<int> rfdOprFuncChkList2 = [0];
  ///関連tprxソース: rcky_rfdopr.c - RfdOprFuncChk_List3
  static List<int> rfdOprFuncChkList3 = [0];
  ///関連tprxソース: rcky_rfdopr.c - RfdOprFuncChk_List4
  static List<int> rfdOprFuncChkList4 = [0];

  ///画像・入力値の保存バッファ
  static RfdOprSaveStruct rfdSaveData = RfdOprSaveStruct();

  static RxMemReason rfdoprReasonInfo = RxMemReason();	// 理由選択情報  rfdopr_reason_info

  /// 通番訂正画面を開く
  /// 関連tprxソース: rckycref.c
  static Future<void> openReceiptScanPage(String title, FuncKey funcKey) async {
    if (!await RckyRfdopr.rcKyRfdOpr()) {
      return;
    }
    if (RegsMem().tTtllog.getItemLogCount() > 0) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: DlgConfirmMsgKind.MSG_REGSTART_ERROR.dlgId,
          type: MsgDialogType.error,
        ),
      );
    } else {
      Get.to(() => ReceiptScanPageWidget(title: title, funcKey: funcKey));
    }
  }

  // TODO:00008 宮家 仮実装
  ///関連tprxソース: rcky_rfdopr.c - rcChk_Ut_Stat()
  static int rcChkUtStat(int opeBrand) {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加

  /// 取引データを呼び出して返品するモード (全返品) かチェック
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprCheckRcptVoidMode()
  static bool rcRfdOprCheckRcptVoidMode(){
    if(rfdSaveData.refundMode
        == RefundModeList.RFDOPR_MODE_RECEIPT){
      return true;
    }
    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 取引データを呼び出して訂正するモード (通番訂正) かチェック
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprCheckAllRefundMode
  static bool rcRfdOprCheckAllRefundMode(){
    if(rfdSaveData.refundMode
        == RefundModeList.RFDOPR_MODE_RECEIPT_VOID){
      return true;
    }
    return false;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcky_rfdopr.c - rcRfdOprDispResultDlg()
  static int rcRfdOprDispResultDlg() {
    return 0;
  }

  /// 返品操作モードかチェック  主に共通の画面表示部に用いる
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprCheckOperateRefundMode()
  static bool rcRfdOprCheckOperateRefundMode(){
    if(rfdSaveData.refundMode == RefundModeList.RFDOPR_MODE_MANUAL
        || rfdSaveData.refundMode == RefundModeList.RFDOPR_MODE_PLAY
        || rfdSaveData.refundMode == RefundModeList.RFDOPR_MODE_TRAN_CREDIT
        || rfdSaveData.refundMode == RefundModeList.RFDOPR_MODE_TRAN_NORMAL){
      return true;
    }
    return false;
  }

  /// ファンクションキー「通番訂正」「返品操作」押下時の処理（バックエンド）
  /// 関連tprxソース: rcky_rfdopr.c - rcKyRfdOpr
  static Future<bool> rcKyRfdOpr() async {
    AcMem cMem = SystemFunc.readAcMem();

    // 返品操作キーが使用可能かチェックする
    cMem.ent.errNo = await rcChkKyRfdOpr();
    if (cMem.ent.errNo != 0) {
      //エラーあり
      await ReptEjConf.rcErr("rcKyRfdOpr", cMem.ent.errNo);
      return false;
    }

    // 会員印字初期設定
    // rcKyMbrPrn_StartSave_CustTrm  //TODO:12Ver追加。現状保留

    // クレジット訂正関数を使用するため, 関数内の値を初期化
    RcKyCrdtVoid.rcCrdtVoidClearMem();

    // 初期画面を表示する【UI】
    await rcRfdOprDispWindowMain();

    // 実行ボタン押下処理
    if (rcRfdOprChkSkipWindowMain()) {
      if (await rcRfdOprBtnClicked(RfdOprFuncBtnType.RFDOPR_FUNC_RECEIPT_RFD) != 0) {
        return false;
      }
    }
    // 特定ws仕様向け 返品モード(手動返品)変更処理
    if (await rcRfdOprChkManualRfdOnly() != 0)
    {
      if (await rcRfdOprBtnClicked(RfdOprFuncBtnType.RFDOPR_FUNC_MANUAL_RFD) != 0) {
        return false;
      }
    }
    return true;
  }

  /// 返品操作キーを使用できるかチェックする
  /// （除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、
  ///  周辺機へのアクション等時間を要するもの）
  /// 戻り値: 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  /// 関連tprxソース: rcky_rfdopr.c - rcChkKyRfdOpr
  static Future<int> rcChkKyRfdOpr() async {
    AcMem cMem = SystemFunc.readAcMem();

    // 使用前に使用できるキーは 0個
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_SCRVOID.keyId);
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    for (int i = 0; i < rfdOprFuncChkList0.length; i++) {
      if (rfdOprFuncChkList0[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, rfdOprFuncChkList0[i]);
    }
    for (int i = 0; i < rfdOprFuncChkList1.length; i++) {
      if (rfdOprFuncChkList1[i] == 0) {
        break;
      }
      RcRegs.kyStR1(cMem.keyChkb, rfdOprFuncChkList1[i]);
    }
    for (int i = 0; i < rfdOprFuncChkList2.length; i++) {
      if (rfdOprFuncChkList2[i] == 0) {
        break;
      }
      RcRegs.kyStR2(cMem.keyChkb, rfdOprFuncChkList2[i]);
    }
    for (int i = 0; i < rfdOprFuncChkList3.length; i++) {
      if (rfdOprFuncChkList3[i] == 0) {
        break;
      }
      RcRegs.kyStR3(cMem.keyChkb, rfdOprFuncChkList3[i]);
    }
    for (int i = 0; i < rfdOprFuncChkList4.length; i++) {
      if (rfdOprFuncChkList4[i] == 0) {
        break;
      }
      RcRegs.kyStR4(cMem.keyChkb, rfdOprFuncChkList4[i]);
    }
    if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO1 + RcRegs.MACRO3) > 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyRfdOpr: operation Error");
      return DlgConfirmMsgKind.MSG_USE_CLEAR_NEXT.dlgId;
    }

    // 使用不可の仕様チェック 1
    if (RcSysChk.rcChkCrdtUser() != Datas.NORMAL_CRDT) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyRfdOpr: cannot Credit User System");
      return DlgConfirmMsgKind.MSG_CANNOT_KEY_SET.dlgId;
    }
    // 使用不可の仕様チェック 2
    if ((!(await RcSysChk.rcChk2800System()) &&
            (cMem.stat.fncCode != FuncKey.KY_RCPT_VOID.keyId)) ||
        ((await RcSysChk.rcCheckIndividChange()) &&
            (cMem.stat.fncCode != FuncKey.KY_RCPT_VOID.keyId)) ||
        (await CmCksys.cmJremMultiSystem() == 1) ||
        (await CmCksys.cmQCashierMode() == 1) ||
        (await CmCksys.cmCustrealOpSystem() == 1) ||
        (await RcSysChk.rcChkHt2980System()) ||
        (await CmCksys.cmSpDepartmentSystem() == 1)
//   || (RcSysChk.rcChkRalseCardSystem())  // ticket #3831
    ) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyRfdOpr: cannot System");
      return DlgConfirmMsgKind.MSG_CANNOT_KEY_SET.dlgId;
    }

    // 会員を呼んでいる場合（商品は無くても）
    if ((await RcMbrCom.rcmbrChkStat() == 1) &&
        (RpPrint.mem.tTtllog.t100700.mbrInput != MbrInputType.nonInput.index)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyRfdOpr: calling member Error");
      return DlgConfirmMsgKind.MSG_CALL_MBR.dlgId;
    }

    // 商品が１品でも登録している場合、使用不可
    if (RcFncChk.rcCheckRegistration()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyRfdOpr: now registration Error");
      if (rcRfdOprCheckManualRefundMode()) {
        return DlgConfirmMsgKind.MSG_REGERROR_EXPLAIN.dlgId;
      } else {
        return DlgConfirmMsgKind.MSG_REGSTART_ERROR.dlgId;
      }
    }

    // タワータイプのチェッカー側
    if (cMem.stat.fncCode == FuncKey.KY_RCPT_VOID.keyId) {
      // 通番訂正
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
          (!(await RcSysChk.rcCheckQCJCSystem()))) {
        //通常タワーレジ（非QCJC）
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "rcChkKyRfdOpr: cannot checker Error");
        return DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId;
      } else if (RcSysChk.rcSROpeModeChk()) {
        //廃棄モード
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "rcChkKyRfdOpr: RCPT_VOID ope mode Error");
        return DlgConfirmMsgKind.MSG_USE_OPEMODE_RG_TR.dlgId;
      }
    }

    // 登録モードか訓練モード以外の場合、使用不可
    if (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkKyRfdOpr: ope mode Error");
      return DlgConfirmMsgKind.MSG_USE_OPEMODE_RG_TR.dlgId;
    }

    // 手動ミックスマッチ状態時、使用不可
    if (RcManualMix.rcManualMixLength() > 0) {
      return DlgConfirmMsgKind.MSG_REG_END_KEY_USE.dlgId;
    }

    return 0;
  }

  /// 手動返品操作モードかチェック
  /// 戻り値: false:手動返品モード以外  true:手動返品モード
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprCheckManualRefundMode
  static bool rcRfdOprCheckManualRefundMode() {
    if (rfdSaveData.refundMode == RefundModeList.RFDOPR_MODE_MANUAL) {
      return true;
    }
    return false;
  }

  /// 操作選択画面を表示後、選択画面をスキップし元レシート情報入力画面へ進む仕様か？
  /// 戻り値: false:上記仕様でない  true:上記仕様
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOpr_Chk_Skip_WindowMain
  static bool rcRfdOprChkSkipWindowMain() {
    return (rfdSaveData.fncCode == FuncKey.KY_RCPT_VOID.keyId);
  }

  /// 操作選択画面を表示する【UI連携あり】
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprDispWindowMain
  static Future rcRfdOprDispWindowMain() async {
    rcRfdOprInitReptStatus(RefundDispDataFlag.RFDOPR_DISPDATA_RESET);

    AcMem cMem = SystemFunc.readAcMem();
    rfdSaveData.fncCode = cMem.stat.fncCode;

    // 各レジ操作における表示変更【UI】
  }

  /// 関数名       : rcRfdOpr_Chk_ManualRfdOnly
  /// 機能概要     : 手動返品のみ使用するかチェック
  /// 呼び出し方法 : rcRfdOpr_Chk_ManualRfdOnly()
  /// パラメータ   :
  /// 戻り値       : 結果
  ///  関連tprxソース: rcky_rfdopr.c - rcRfdOpr_Chk_ManualRfdOnly
  static Future<int> rcRfdOprChkManualRfdOnly() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (0);
    }
    RxCommonBuf cBuf = xRet.object;

    debugPrint(
        "RcSysChk.rcChkWSSystem():${RcSysChk.rcChkWSSystem()} == true \n"
        "RcSysChk.rcsyschkYunaitoHdSystem():${RcSysChk.rcsyschkYunaitoHdSystem()} != 0 \n"
        "RcSysChk.rcChkToySystem():${RcSysChk.rcChkToySystem()} == true \n"
        "cBuf.dbTrm.useReceiptRefund:${cBuf.dbTrm.useReceiptRefund} == 0 \n"
        "rfdSaveData.fncCode:${rfdSaveData.fncCode} == ${FuncKey.KY_RFDOPR.keyId} \n"
    );
    if (((RcSysChk.rcChkWSSystem())
      || (RcSysChk.rcsyschkYunaitoHdSystem() != 0)
      || (RcSysChk.rcChkToySystem())
      || (cBuf.dbTrm.useReceiptRefund == 0))	// 返品モード「レシート返品」の利用：しない
      &&  (rfdSaveData.fncCode == FuncKey.KY_RFDOPR.keyId))
    {
      return (1);
    }
    return (0);
  }

  /// ボタン押下時の動作処理【UI連携あり】
  /// 引数:[data] 押下したボタンの種類
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprBtnClicked()
  static Future<int> rcRfdOprBtnClicked(RfdOprFuncBtnType data) async {
    int ret = 0;
    String msg = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcRfdOprBtnClicked: SystemFunc.rxMemRead() isInvalid");
      return 1;
    }
    RxCommonBuf cBuf = xRet.object;
    CommonLimitedInput comLtdInp = SystemFunc.readCommonLimitedInput();

    switch (data) {
    // 返品モード選択画面  終了ボタン処理
      case RfdOprFuncBtnType.RFDOPR_FUNC_QUIT:
        msg = "Refund Quit";
      //rcRfdOprEndProc( NULL, (gpointer)1 );
        break;
      case RfdOprFuncBtnType.RFDOPR_FUNC_RECEIPT_RFD:  // レシート返品ボタン
        if (rfdSaveData.fncCode == FuncKey.KY_RCPT_VOID.keyId) {
          // 通番訂正
          msg = "Receipt Void";
          rfdSaveData.refundMode = RefundModeList.RFDOPR_MODE_RECEIPT_VOID;
        } else {
          // 通番訂正以外
          msg = "Receipt Refund";
          if ((cBuf.dbTrm.journalnoPrn == 1) &&
              (cBuf.dbTrm.recieptnoPrn == 1)) { //ジャーナルNo印字なし and レシートNo印字なし
            // ダイアログ表示後クリアキーを有効にするため
            comLtdInp.keyEvent = 1;
            comLtdInp.keyFunc = rcRfDOprAftDlgClrStsRst;
            ret = DlgConfirmMsgKind.MSG_CANNOT_KEY_SET.dlgId;
            break;
          }
          rfdSaveData.refundMode = RefundModeList.RFDOPR_MODE_RECEIPT;
        }
        rcRfdOprInitReptStatus(RefundDispDataFlag.RFDOPR_DISPDATA_SET);
        break;
      case RfdOprFuncBtnType.RFDOPR_FUNC_MANUAL_RFD:  // 手動返品ボタン
        msg = "Manual Refund";
        rfdSaveData.refundMode = RefundModeList.RFDOPR_MODE_MANUAL;
        RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL);	// 前回実績を消去
        Rxregstr.rxSetTranOpeMode();			// オペモードをセット
        //rcRfdOprFuncEnd();			// 画面を再描画

        // RM-3800 ハイタッチ接続仕様の場合はハイタッチ画面を表示
        if ((await CmCksys.cmChkRm5900HiTouchMacNo() != 0)	// ハイタッチ接続
          && (await Rc59Hitouch.rc59ScaleHitouchDispTyp() == 0))		// ハイタッチ接続仕様の画面タイプ 0:プリセット
        {
          await RckyHitouch.rcKyHiTouch();
        }

        if ((RcSysChk.rcChkReasonSelectSystem())		/* 理由選択仕様 */
          && (rfdoprReasonInfo.reasonStat == 1))
        {
          RegsMem().prnrBuf.reason = rfdoprReasonInfo;
          await RcReason.rcReasonSetData();		/* 理由実績セット（手動返品） */
        }
        break;
      default:
        break;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcRfdOprBtnClicked: $msg Clicked [$ret]");
    if (ret != 0) {
      await ReptEjConf.rcErr("rcRfdOprBtnClicked", ret);
    }
    return ret;
  }

  /// 返品モード画面の各値の初期化処理
  /// 引数:[flg] 返品モードでの保存メモリの初期化か初期値セットのフラグ
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprInitReptStatus()
  static Future rcRfdOprInitReptStatus(RefundDispDataFlag flg) async {
    int fncCodeBkup = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcRfdOprInitReptStatus: SystemFunc.rxMemRead() isInvalid");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    CommonLimitedInput comLtdInp = SystemFunc.readCommonLimitedInput();

    if (flg == RefundDispDataFlag.RFDOPR_DISPDATA_SET) {
      // 簡易入力モードの設定値をセット(入力が出来るようになる)
      comLtdInp.keyEvent	= 1;
      comLtdInp.obrEvent	= 1;
      comLtdInp.mcdEvent	= 1;
      // comLtdInp.keyFunc	= rcComLtdDispEntryNum;
      // comLtdInp.obrFunc	= rcRfdOprFuncObr;
      // comLtdInp.inpFunc	= rcRfdOprFuncReptInput;
      // 表示用初期値をセット
      rfdSaveData.selectElm = RfdOprReptStruct();
      rfdSaveData.saleDate.dispType = EntryDispType.ENT_DATE_YYYYMMDD.index;
      rfdSaveData.saleDate.max	= 8;
      var (int error, String date) = await DateUtil.dateTimeChange(null,
          DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE,
          DateTimeFormatKind.FT_YYYYMMDD,
          DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
      rfdSaveData.saleDate.val = date;
      rfdSaveData.macNo.dispType	= EntryDispType.ENT_R.index;
      rfdSaveData.macNo.max = 6;
      rfdSaveData.macNo.val = "${cBuf.iniMacInfo.mac_no}";
      rfdSaveData.recNo.dispType	= EntryDispType.ENT_R.index;
      rfdSaveData.recNo.max = 4;
      rfdSaveData.recNo.val = "1";
      rfdSaveData.saleAmt.dispType	= EntryDispType.ENT_R.index;
      rfdSaveData.saleAmt.max = 7;
      rfdSaveData.saleAmt.val = "0";
      rfdSaveData.slipNo.dispType	= EntryDispType.ENT_R.index;
      rfdSaveData.slipNo.max = 5;
      rfdSaveData.slipNo.val = "0";
      rfdSaveData.crdtNo.dispType = EntryDispType.ENT_R_ALL_DIGIT.index;
      rfdSaveData.crdtNo.max = 16;
      rfdSaveData.crdtNo.val = "0";
    } else if (flg == RefundDispDataFlag.RFDOPR_DISPDATA_RESET) {
      // 簡易入力モードの設定値をセット(入力不可状態)
      comLtdInp.keyEvent = 0;
      comLtdInp.obrEvent = 0;
      comLtdInp.mcdEvent = 0;
      comLtdInp.keyFunc	 = null;
      comLtdInp.obrFunc	 = null;
      //comLtdInp.entryDisp	= null;
      fncCodeBkup = rfdSaveData.fncCode;
      // 表示用データの初期化
      rfdSaveData = RfdOprSaveStruct();
      rfdSaveData.fncCode = fncCodeBkup;
      rfdSaveData.refundMode = RefundModeList.RFDOPR_MODE_SELECT;
      if (await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) {
        cMem.stat.dualTSingle = cBuf.devId;
      } else {
        cMem.stat.dualTSingle = 0;
      }
      if (cMem.stat.dualTSingle == 1) {
        rfdSaveData.windowDispType = 1;
      } else {
        rfdSaveData.windowDispType = 0;
      }

      RcSet.rcClearEntry();
      RcSet.rcClearCrdtReg();
      await RcSet.rcClearErrStat2("rcRfdOprInitReptStatus");
    }
  }

  /// クレジット訂正電文成功後の処理
  /// 引数:[type] 訂正用データ更新フラグ
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprAllRefundCreditEnd()
  static Future<void> rcRfdOprAllRefundCreditEnd(int type) async {
    int opeModeFlg = 0;
    print('payvoid調査ログ:rcRfdOprAllRefundCreditEnd スタート地点');
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    rcRfdOprDestroyApproveWindow();

    // 訂正用データの編集
    if (type == 1) {
      if (!rcRfdOprCheckRcptVoidMode()) {
        await RcKyCrdtVoid.rcCrdtVoidPostPayEditTranData(rfdSaveData.opeMode);
        await RcSetDate.rcSetDate();
        await RcRecno.rcSetRctJnlNo();
        await rcRfdOprTranCreate();
      } else {
        mem.tTtllog.t100003.voidFlg = 1;
        switch (cMem.stat.opeMode) {
          case RcRegs.TR:
            opeModeFlg = OpeModeFlagList.OPE_MODE_TRAINING;
            break;
          default:
            opeModeFlg = OpeModeFlagList.OPE_MODE_VOID; // 通番訂正
            break;
        }
        await RcKyCrdtVoid.rcCrdtVoidPostPayEditTranData(opeModeFlg);
        await RcSetDate.rcSetDate();
        await RcRecno.rcSetRctJnlNo();
      }
    } else if (rfdSaveData.fncCode == FuncKey.KY_RCPT_VOID.keyId) {
      mem.tTtllog.t100003.voidFlg = 1;
      switch (cMem.stat.opeMode) {
        case RcRegs.TR:
          opeModeFlg = OpeModeFlagList.OPE_MODE_TRAINING;
          break;
        default:
          opeModeFlg = OpeModeFlagList.OPE_MODE_VOID; // 通番訂正
          break;
      }
      await RcKyCrdtVoid.rcCrdtVoidEditTranDate(
          opeModeFlg, mem, mem, int.parse(rfdSaveData.slipNo.val));

    }
    //ここで通番訂正のAPIをコールする
    print('payvoid調査ログ:rcRfdOprAllRefundCreditEnd 終了地点');
    print('callSerialNumberCorrectionAPI');
    await callSerialNumberCorrectionAPI();
  }

  /// 承認番号入力画面の消去
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOprDestroyApproveWindow()
  static void rcRfdOprDestroyApproveWindow() {
    //TODO:10122 グラフィクス処理（gtk_*）
    //TODO:00002 佐野 イベント登録関数初期化（CommonLimitedInputメンバでコメント化）
    /*
    CommonLimitedInput comLtdInp = SystemFunc.readCommonLimitedInput();
    comLtdInp.entryDisp	= null;
    comLtdInp.keyFunc	= null;
	  if (await rcQCChkQcashierSystem()) {
		  comLtdInp.tchFunc = null;
	  }
     */
  }

  /// 返品実績を作成する
  /// 関連tprxソース: rcky_rfdopr.c - rcRfdOpr_Tran_Create()
  static Future<void> rcRfdOprTranCreate() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    mem.tTtllog.t100003.refundQty = mem.tTtllog.t100001.qty;
    mem.tTtllog.t100003.refundAmt = mem.tTtllog.t100001.stlTaxInAmt - RxLogCalc.rxCalcExTaxAmt(mem);	// 外税抜
    mem.tTtllog.t100003.refundCnt = 1;
    if (Rxkoptcmncom.rxChkKoptRefOprTranCustNum(pCom) == 0) {
      mem.tTtllog.t100001.cust = 0;
      mem.tTtllog.t100001.peopleCnt	= 0;
    }
    mem.tTtllog.t100700.dpntTtlsrv = 0;
    mem.tTtllog.t100701.dtiqTtlsrv = 0;
    mem.tTtllog.t100701.dtipTtlsrv = 0;

    int p = 0;  //p:promNum
    //i:itemNum
    for (int i=0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if (Rxkoptcmncom.rxChkKoptRefOprTranCustNum(pCom) == 0) {
        mem.tItemLog[i].t10000.lrgclsCust = 0;
        mem.tItemLog[i].t10000.mdlclsCust = 0;
        mem.tItemLog[i].t10000.smlclsCust = 0;
        mem.tItemLog[i].t10000.tnyclsCust = 0;
        mem.tItemLog[i].t10000.pluCust = 0;
        mem.tItemLog[i].t50400?.stampCust = 0;
        mem.tItemLog[i].t10002.sub1LrgCust = 0;
        mem.tItemLog[i].t10002.sub1MdlCust = 0;
        mem.tItemLog[i].t10002.sub1SmlCust = 0;
        mem.tItemLog[i].t10002.sub2LrgCust = 0;
        mem.tItemLog[i].t10002.sub2MdlCust = 0;
        mem.tItemLog[i].t10002.sub2SmlCust = 0;
        mem.tItemLog[i].t10002.discCust = 0;
      }
      if ((mem.tItemLog[i].t10000.lrgclsCd != 0)
          || (mem.tItemLog[i].t10000.mdlclsCd != 0)
          || (mem.tItemLog[i].t10000.smlclsCd != 0)
          || (mem.tItemLog[i].t10000.tnyclsCd != 0)) {
        mem.tItemLog[i].t10002.refundQty = mem.tItemLog[i].t10000.itemTtlQty;
        mem.tItemLog[i].t10002.refundAmt =
            mem.tItemLog[i].t10000.actNomiInPrc;
      } else
      if (RcItmChk.rcCheckNoteItmRec(mem.tItemLog[i].t10003.recMthdFlg)) {
        mem.tItemLog[i].t10002.refundQty = mem.tItemLog[i].t10000.itemTtlQty;
      }
      mem.tItemLog[i].t11300 = List.generate(CntList.acntMax,  (_) => T11300());
      for (p=0; p < mem.tItemLog[i].t10000Sts.loyPromItemCnt; p++) {
        if ((mem.tItemLog[i].t11200[p]?.loyPnt == 0)
            || (RcStl.rcChkItmRBufZFSPPointRec(i))) {
          mem.tItemLog[i].t11200Sts[p]?.prnLoyCnt =
              mem.tItemLog[i].t11200[p]!.loyCnt;
        }
        mem.tItemLog[i].t11200[p]?.loyPnt = 0;
        mem.tItemLog[i].t11200[p]?.loyCnt = 0;
      }
      // スタンプカード条件の段数、ステータスデータをクリア
      mem.tItemLog[i].t10000Sts.stpCondItemCnt = 0;
      mem.tItemLog[i].t11211Sts = List.generate(CntList.othPromMax,  (_) => T11211Sts());
    }
    mem.tTtllog.t106500 = List.generate(CntList.othPromMax,  (_) => T106500());
    mem.tTtllog.t106500Sts = List.generate(CntList.othPromMax,  (_) => T106500Sts());

    for (p = 0; p < mem.tTtllog.t100001Sts.loyPromTtlCnt; p++) {
      if ( mem.tTtllog.t106000Sts[p].schTyp == 0 ) {
        mem.tTtllog.t106000[p].loyCnt = 0;
        mem.tTtllog.t106000[p].totalLoyCnt = 0;
        mem.tTtllog.t106000[p].acntId = 0;
        mem.tTtllog.t106000[p].loyPnt = 0;
      } else {
        mem.tTtllog.t106000[p] = T106000();
      }
    }
    mem.tTtllog.t106000Sts = List.generate(CntList.loyPromTtlMax, (_) =>  T106000Sts());
    mem.tTtllog.t107000 = List.generate(CntList.acntMax,  (_) => T107000());

    // 通番訂正時はスタンプカード実績の減算を行わないためクリア処理を実行
    // スタンプカード段数をクリア
    mem.tTtllog.t100001Sts.stpTtlCnt = 0;
    // トータルログレコードスタンプカードクリア
    mem.tTtllog.t106100 = List.generate(CntList.othPromMax,  (_) => T106100());
    // トータルログステータスレコードスタンプカードクリア
    mem.tTtllog.t106100Sts = List.generate(CntList.othPromMax,  (_) => T106100Sts());

    LogMRef.rcLogMRef(await RcSysChk.getTid(), mem);
  }

  //通番訂正APIのコール(新規作成)
  static Future<void> callSerialNumberCorrectionAPI() async{
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    String callFunc = 'callSerialNumberCorrectionAPI';
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "RcKeyCash rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;
    print('payvoidコール直前ログ');
    CalcResultVoid retData = await RcClxosPayment.payvoid(pCom);
    if (0 != retData.retSts) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
    "RckyRfdopr ${retData.errMsg}");
    return;
    } else {
      // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
      await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
    }
  }

// ジャーナルNo.レシートNo.印字がどちらも「しない」のとき、
// レシート返品ボタン押下時のダイアログを消去したときの動作関数
  ///  関連tprxソース: rcky_rfdopr.c - rcRfDOpr_AftDlgClr_StsRst
  static void rcRfDOprAftDlgClrStsRst() {
    CommonLimitedInput comLtdInp = SystemFunc.readCommonLimitedInput();
    comLtdInp.keyEvent = 0;
    comLtdInp.keyFunc = null;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcky_rfdopr.c - rcRfdOprDlgBtnUse
  static void rcRfdOprDlgBtnUse() {
    return ;
  }
}

// TODO:00012 平野 checker関数実装のため、クラス追加
/// 本操作で使用する画像・入力値の保存バッファ【フロント連携？】
///関連tprxソース: rcky_rfdopr.h - RfdOprSaveStruct
class RfdOprSaveStruct{
  /// 現在の画面モード
  RefundModeList refundMode = RefundModeList.RFDOPR_MODE_SELECT;
  /// 選択中のデータ
  RfdOprReptStruct selectElm = RfdOprReptStruct();
  /// マシン番号
  RfdOprReptStruct macNo = RfdOprReptStruct();
  /// レシート番号
  RfdOprReptStruct recNo = RfdOprReptStruct();
  /// 合計金額
  RfdOprReptStruct saleAmt = RfdOprReptStruct();
  /// 元伝票番号
  RfdOprReptStruct slipNo = RfdOprReptStruct();
  /// 営業日
  RfdOprReptStruct saleDate = RfdOprReptStruct();
  /// カード番号
  RfdOprReptStruct crdtNo = RfdOprReptStruct();
  /// 店舗番号
  RfdOprReptStruct shpNo = RfdOprReptStruct();
  /// 表示タイプ（0:卓上  1:タワー）
  int	windowDispType = 0;
  /// 遷移元となるキー
  int fncCode = 0;
//   GtkWidget			*ReptWindow;	// レシート情報入力画面
//   GtkWidget			*HalfWindow;	// レシート情報入力画面の下の画面
//   GtkWidget			*TenKeyWindow;	// テンキー画面
//   GtkWidget			*TenKeyWindow2;	// テンキー画面
//   GtkWidget			*ReptExplain;	// 説明文
//   GtkWidget			*ReptInputBtn;	// 入力ボタン
//   GtkWidget			*ResultDlgWindow;	// ダイアログ画面
//   GtkWidget			*ResultDlgHalfWindow;	// ダイアログ画面の下の画面
//   GtkWidget			*ResultDlgBtn[RFDOPR_LOCAL_DLG_BTN_NUM];// ボタン
//   GtkWidget			*ApproveWindow;		// 承認番号入力画面
//   GtkWidget			*ApproveHalfWindow;	// 承認番号入力画面の下の画面
//   GtkWidget			*ApproveEntry;		// 承認番号入力エリア
// //	PGconn  			*Con;		// 接続ポインタ
  /// クレジット取引（0:取引なし  1:取引あり）
  int	creditType = 0;
  int precaType = 0;	// 0:プリペイド取引では無い  1:プリペイド取引である
  VoidupDbLoginStatus loginStatus = VoidupDbLoginStatus.VOIDUP_LOGIN_ERROR;	// 接続状況
  int timer = 0;		// この関数内のタイマー
  int opeMode = 0;
  int printCnt = 0;	// プリンタチェックの為の変数
  int printType = 0;	// 〃
  int printErr = 0;	// 〃
  int prnRecNo = 0;	// レシート上にないジャーナル番号
  int crdtAmt = 0;	// クレジット金額
  int precaAmt = 0;	// プリペイド金額
  int refundAmt = 0;	// 返金金額
  String ipAddr = ""; // [64];
  String iCCardNo = ""; // [MBR_CD_MAX + 1];	// ICクレジットカード番号
  int iCCardType = 0;	// 0:ICクレジット取引では無い  1:ICクレジット取引である
  List<int> sptendCd = List.generate(10, (index) => 0); // [10];
  String opeModeBkup = "";	// オペモードバックアップ
  int ssFlg = 0;				// SP+QC実績である
  String ssNowSaleDatetime = ""; // [32];	// SP+QC実績用
  int ssMacNo = 0;			// SP+QC実績用
  int ssRecNo = 0;			// SP+QC実績用
  int transferSales = 0;			// 0:実績振替しない  1:実績振替する
  int pontaVoidFlg = 0;			// Ponta仕様 通番訂正不可フラグ
  int errNo = 0;				// エラー番号バックアップ
  int payCondition = 0;	// 支払区分
//t_LogParam 			tlogParam;      // ログデータ読込用レシート指定構造体
  int gcatAmt = 0;	// 決済端末取引対象金額
  int vescaProc = 0;	// ベスカ端末処理実行フラグ
  int carddspFlg = 0;
//REFUND_MANUAL_INPUT_STEP	minputStep;			// マニュアル手入力ステップ
  int inoutFlg = 0;	// 入出金フラグ
  int dpointStatus = 0;			// dポイント処理ステータス
  RxMemDPointData dpointData = RxMemDPointData();			// dポイント情報
  int dpointInput = 0;			// dポイント入力方法
  int dpointProcType = 0;		// dポイント取引タイプ
  int gcatBusiKnd = 0;		//G-CAT 掛売種類
  int repicapntStatus = 0;		// プリカポイント 0:プリカポイント取引無し 1:プリカポイント取引あり
  int repicapntType = 0;			// プリカポイント 0:プリカポイント無 1:プリカポイントあり
  List<int> addCd = List.generate(4 + 1, (index) => 0); // [4+1];
  int rpointInputtyp = 0;				// 楽天ポイントカード 読込画面での読取方法
  int rpointReadflg = 0;					// 楽天ポイントカード 読込画面での読込済フラグ
  int rpointCnclFlg = 0;				// 楽天ポイントカード 読込画面での読込処理中断フラグ
  int rpointCashrtnUsepointFlg = 0;	// 楽天ポイントカード 通番訂正でのポイント利用分現金返金フラグ
  String rpointCardno = ""; // [17];				// 楽天ポイントカード 読込画面で入力されたカード番号保持用
  String rpointOrgMemberId = ""; // [17];		// 楽天ポイントカード 同一カードとの比較用元取引カード番号保持用
  String rpointOrgOrderCd = ""; // [31];		// 楽天ポイントカード 元取引の取引コード保持用
  int rpointOrgOfflineFlg = 0;			// 楽天ポイントカード 元取引のオフラインフラグ保持用
  int rpointOrgUsePoint = 0;			// 楽天ポイントカード 元取引の利用ポイント保持用
  int rpointOrgNormalPoint = 0;		// 楽天ポイントカード 元取引の付与ポイント保持用
  int rpointOrgCampaignPoint = 0;		// 楽天ポイントカード 元取引のキャンペーンポイント(合計)保持用
//RXMEM_RPOINT_REC	rpointRecvDatabk;				// 楽天ポイントカード 通番訂正時のポイント照会結果のバックアップ用
  int nWsPointDff = 0;	// ワールドスポーツ 返却できなかったポイント数
  int nimocaFlg = 0;	// nimoca取引フラグ 0:nimoca取引ではない 1:nimoca取引である
  int nimocaCnclMsgFlg = 0;	// nimoca読取キャンセルフラグ
  Icpntvoid nimoca = Icpntvoid();		// nimoca取引情報
}

/// ボタンリスト
/// 関連tprxソース: rcky_rfdopr.h - RFDOPR_FUNC_BTN_TYPE
enum RfdOprFuncBtnType {
  RFDOPR_FUNC_QUIT,  // 中止ボタン
  RFDOPR_FUNC_RECEIPT_RFD,  // レシート返品ボタン
  RFDOPR_FUNC_MANUAL_RFD,  // 手動返品ボタン
  RFDOPR_FUNC_RECEIPT_PLAY,  // レシート表示ボタン
  RFDOPR_FUNC_REPT_INPUT,  // レシート情報入力ボタン
  RFDOPR_FUNC_REPT_EXEC,  //     〃      実行ボタン
  RFDOPR_FUNC_REPT_QUIT,  //     〃      中止ボタン
  RFDOPR_FUNC_REPT_SALEDATE,  //     〃      営業日ボタン
  RFDOPR_FUNC_REPT_MACNO,  //     〃      マシン番号ボタン
  RFDOPR_FUNC_REPT_RECNO,  //     〃      レシート番号ボタン
  RFDOPR_FUNC_REPT_SALEAMT,  //     〃      合計金額ボタン
  RFDOPR_FUNC_REPT_SLIPNO,  //     〃      元伝票番号ボタン
  RFDOPR_FUNC_REPT_CRDTNO,  //     〃      カード番号ボタン
  RFDOPR_FUNC_REPT_TEN_KEY,  //     〃      テンキー
  RFDOPR_FUNC_APPROVE_EXEC,  // 承認番号実行ボタン
  RFDOPR_FUNC_APPROVE_END,  //    〃   終了ボタン
  RFDOPR_FUNC_DLG_END,  // 結果ダイアログ完了ボタン
  RFDOPR_FUNC_LOAD_ORG_TRAN,  // 結果ダイアログ 元取引表示ボタン
  RFDOPR_FUNC_REPT_SHPNO,  // レシート情報店舗番号ボタン
}

/// 返品モード時の状態リスト
/// 関連tprxソース: rcky_rfdopr.h - REFUND_OPERRATION_MODE_LIST
enum RefundModeList {
  RFDOPR_MODE_SELECT,  //初期状態
  RFDOPR_MODE_RECEIPT,  //レシート情報入力状態
  RFDOPR_MODE_RECEIPT_VOID,  //レシート情報入力状態(通番訂正時)
  RFDOPR_MODE_MANUAL,  //手動返品状態
  RFDOPR_MODE_PLAY,  //【レシート表示】レシート情報入力状態
  RFDOPR_MODE_TRAN_CREDIT,
  RFDOPR_MODE_TRAN_NORMAL,
  RFDOPR_MODE_END,  //操作完了状態
}

// 返品モードでの保存メモリの初期化か初期値セットのフラグ
/// 関連tprxソース: rcky_rfdopr.h - REFUND_OPERRATION_DISPDATA_FLAG
enum RefundDispDataFlag {
  RFDOPR_DISPDATA_SET,  // 初期値セット
  RFDOPR_DISPDATA_RESET,  // 初期化
  RFDOPR_DISPDATA_REPT_RESET,	 // 初期化(レシート情報)
}

/// 画像・入力値構造体【フロント連携？】
/// 関連tprxソース: rcky_rfdopr.h - RfdOprReptStruct
class RfdOprReptStruct {
  // GtkWidget	*Entry;		// 入力エリア
  // GtkWidget	*Button;	// 選択ボタン
  /// 入力最大桁数
  int  max = 0;
  /// 表示タイプ
  int dispType = 0;
  /// 入力文字列
  // char		Val[COMLTD_MAX_DIGIT * 2];
  String val = "";
}