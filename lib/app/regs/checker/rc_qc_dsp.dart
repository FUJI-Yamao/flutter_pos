/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../ui/menu/register/m_menu.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc28stlinfo.dart';
import 'rc_28dsp.dart';
import 'rc_acracb.dart';
import 'rc_assist_mnt.dart';
import 'rc_cogca.dart';
import 'rc_ext.dart';
import 'rc_gcat.dart';
import 'rc_key_stf_release.dart';
import 'rc_reason.dart';
import 'rc_obr.dart';
import 'rc_repica.dart';
import 'rc_reserv.dart';
import 'rc_sgdsp.dart';
import 'rcfncchk.dart';
import 'rcky_cat_cardread.dart';
import 'rcky_preca_remove.dart';
import 'rcky_sus.dart';
import 'rcky_tomocard.dart';
import 'rckymbre.dart';
import 'rcnewsg_dsp.dart';
import 'rcqc_com.dart';
import 'rcqr_com.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcqc_dsp.c
class RcQcDsp {
  /// QCashier used Ini File Memorys
  /// 関連tprxソース: rcqc_dsp.h - #define
  static const DIR_QCMOVIE = "/conf/image/gif/";
  static const QC_ANYCUSTCARD_MBR_RARA = "qc_led_cust_mbr_rara";

  static const QC_LED_MASR_RED_COLOR = QcLedColor.QC_LED_GREEN_COLOR;
  static const int QC_MOVIE_RETRY	= 100;
  static const int QC_MOVIE_WAIT	= 50000;
  static const int QC_MOVIE_NON_ACT	=	0;
  static const int QC_MOVIE_STOP	=	1;

  static int qcFncCd = 0;
  static int qcashierIniMax = 145;
  static int qcChaPrecaSideFlag = 0;	//プリカ会計キーが押されたLCD画面 1:卓上 3:カラー客表
  static int qc_chachk_last_check = 0;
  static int qc_chachk_spcnt = 0;
  static int qc_chachk_code = 0;
  static int HappyQcType = 0;
  static int aiboxSwingErrChkFlg = 0;	// 空振り検知通知・確認の際、確認ボタン押下時のフラグ
  static int qc_err_staffcall_no_flg = 0;
  static int qc_item_list_no = 0;
  static int mente_before_itemcnt = 0;
  static int qc_sag_item_mente_flg = 0;
  static int psen_movie_timer = 0;
  static int qc_sag_mente_nofile_flg = 0;
  static int qc_sag_regcncl_exec_flg = 0;	/* Shop&Go 取消実行中フラグ */
  static int qc_sag_interrupt_charge_end_flg = 0;	/* Shop&Go 割込みチャージ終了動作フラグ */
  static int qc_sag_item_age_checked_flg = 0;
  static int qc_cha_preca_side_flag = 0;	//プリカ会計キーが押されたLCD画面 1:卓上 3:カラー客表
  static int qc_err_repicapnt_typ = 0;
  static int repicapnt_status = 0;
  static int qc_slct_repicapnt = 0;		// レピカポイントが選択されたかどうか確認する
  static int qc_mente_apbf_status = 0;       /* 0:ON 1:OFF */
  static int qc_nimoca_scrmode = 0;
  static int nimoca_aplchg_wait3 = 0;	// VEGA処理待ち時間
  static int qc_slct_repicamny = 0;		// レピカ電子マネーが選択されたかどうか確認する
  static int vesca_fnc_code = 0;	//Verifone残高不足画面で従業員バーコード読込をするとCMEM->stat.FncCodeがクリアされるので、FncCodeを保持しておくバックアップ用
  static int qc_sag_vesca_lack_end_flg = 0;	//Shop&Go Verifone残高不足全額使い切る動作の終了フラグ
  static int qc_acbdata_before_price = 0;
  static int pay_method_place = 0;		/* 会計方法Xがどこまで表示されたかを示す */
  static int start_skip_flg = 0;
  static int qc_sag_vfhd_mentecall_bfr_stl = 0;	/* Shop&Go縦型21.5インチ 精算画面より前でメンテ画面を呼んだか */
  static int sg_vfhd_mentecall_bfr_stl = 0;	/* 縦型15.6インチフルセルフ 精算画面より前でメンテ画面を呼んだか */
  static int vfhd_fself_sound_off_flg = 0;	/* 15.6インチ対面セルフ 支払い選択画面より支払い方法選択時支払い選択の音声を制御するフラグ */
  static int qc_auto_reprint_diag_flg = 0;	//再発行ダイアログ自動表示フラグ
  static int sg_psen_pop_err_flg = 0;        /* POP表示メッセージの空振り用(0)と困惑用(1)判断 */
  static int aibox_swing_err_chk_flg = 0;	// 空振り検知通知・確認の際、確認ボタン押下時のフラグ
  static int qc_rpointmbr_select_no = 0;		// 精算機での楽天ポイントカード読込画面で持っていないボタン選択判断
  static int qc_rpointread_err_after = 0;	// 楽天ポイントカード照会結果継続不可エラー時の後処理フラグ
  static int qc_rpoint_cashend_flg = 0;	// 楽天ポイントカード照会後の支払い完了フラグ
  static int qc_rpoint_scrmode = 0;			// 精算機での楽天ポイントカード読込仕様で現在のQCスクリーンモード
  static int qc_rpointmbr_qr_txt_status_bk = 0;	// 精算機での楽天ポイントカード読込にて画面描画中のqr_txt_statusバックアップ用
  static int qc_call_scrmode_bk = 0;			// 精算機での楽天ポイントカード確認画面の呼出し元QCスクリーンモードのバックアップ用
  static int qc_rpointmbr_org_fnc_cdbk = 0;		// 精算機での楽天ポイントカード確認画面の呼出し時のファンクションコードバックアップ用
  static int Rpoint_upd_error_flg = 0;
  static int tomonokai_sag_dispSts = 0;
  static int qc_rpoint_pay_conf_statechk_flg = 0;	// 楽天ポイント利用可能チェックフラグ
  static int qc_rpoint_pay_conf_dsp_flg = 0;	// 楽天ポイント利用選択画面表示フラグ
  static int qc_rpoint_pay_conf_yes_flg = 0;	// 楽天ポイント利用選択フラグ
  static int qc_rpoint_pay_conf_dsp_org_fnc_cdbk = 0;	// 楽天ポイント利用選択画面呼出し時のファンクションコードバックアップ用
  static int qc_rpoint_pay_conf_dsp_org_typbk = 0;	// 楽天ポイント利用選択画面呼出し元の引数バックアップ用
  static int qc_rpoint_pay_conf_call_scrmode = 0;	// 楽天ポイント利用確認画面呼出し時のファンクションコードバックアップ用
  static int qc_staffcall_from_sg_flg = 0;	// フルセルフから店員呼出画面を表示する店員呼出をしているフラグ
  static int qc_mnt_man_ent_fnccode = 0;
  static int qc_mnt_man_ent_max_len = 0;
  static int qc_mnt_man_ent_exec_flg = 0;
  static int not_registration_to_mente_flg = 0;
  static int qc_mente_mbr_input_allow_flg = 0;
  static int qc_sag_sm5_cogca_err = 0;
  static int qc_mnt_scanner_status = 0;
  static int qc_sag_rpoint_conf = 0;
  static int qc_sag_rpoint_back = 0;
  static int qc_coupon_movie_start_timer = -1;		/* クーポン受付確認後に動画再生するため */
  static int vfhd_self_item_scrvoid_conf_statechk_flg = 0; // 縦型G3フルセルフ商品取消確認チェックフラグ
  static int qc_mbrread_select_member_card = 0; // 精算機での会員カード確認画面で選択した会員カードの種類
  static int qc_mbrread_select_nocard = 0;  // 精算機での会員カード確認画面で持っていないボタン選択判断
  static int qc_mbrread_call_scrmode_bk = 0;  // 精算機での会員カード確認画面の呼出し元qc_screen_modeのバックアップ用
  static int qc_mbrread_org_fnc_cdbk = 0;  // 精算機での会員カード確認画面の呼出し時のファンクションコードバックアップ用
  static int qc_mbrread_nochg_conf_flg = 0;  // 精算機での会員カード読取時再計算後の残余発生時確認ダイアログ表示フラグ
  static int qc_mbrread_entry2 = 0;   // 精算機での会員カード読取時再計算後の残余発生確認用
  static int qc_mbrread_data2 = 0;   // 精算機での会員カード読取時再計算後の残余発生確認用
  static int qc_mbrread_qr_txt_status_bk = 0; // 精算機での会員カード読取にて画面描画中の qr_txt_status バックアップ用
  static int qc_mbrread_err_after = 0;  // 精算機での会員カード照会結果継続不可エラー時の後処理フラグ
  static int qc_mbrread_cashend_flg = 0;  // 精算機での会員カード照会後の支払い完了フラグ
  static int qc_mbrread_select_payplace = 0; 	// HappySelf対面 小計ボタン押下時確認ダイアログのボタン選択
  static int qcChageLackdspFlg = 0;
  static int qcChageFulldspFlg = 0;
  static int qcEndSusdspFlg = 0;
  static int qcMenteBackChgerrNo = 0;
  static int qcFuncTimer = -1;
  static int qcSusdspOverflowScreen = 0;
  static int qcSoundOffFlg = 0;
  static QC_MBRREADDSP qcMbrReadDsp = QC_MBRREADDSP();
  static QCMbrChkDsp qcMbrChkDsp = QCMbrChkDsp();
  static QCStartDsp qcStrDsp = QCStartDsp();

  static QCCallDsp	qCCallDsp = QCCallDsp();
  static QCPayInfo qCPayInfo = QCPayInfo();

  /// 関連tprxソース: tprx\src\regs\checker\rcqc_dsp.c - QCASHIER_INI	QCashierIni;
  static QCashierIni	qCashierIni = QCashierIni();
  static int qc_suspend_preca_balance = 0;

  /* 割込みチャージ後の残高を元の取引に引き継ぐための変数 */
  static int qc_nishitetu_flg = 0;
  static int qc_susdsp_overflow_screen = 0;
  static int qc_selfdsp_overflow_ctrl_flg = 0;
  static int qc_slct_btn_page = 0;
  static int qc_fullself_suspend_charge_flg = 0;


  static QcPayDsp qcPayDsp = QcPayDsp();

  /* フルセルフ割込みチャージフラグ 0:非対象 1:対象 2:メンテ支払 */
  static int qc_take_money_flg = 0;

  static int qc_charge_item_dsp_flg = 0;
  static QCCallDsp qcCallDsp = QCCallDsp();
  static QCPayInfo qcPayInfo = QCPayInfo();

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Dsp_Destroy()
  static void rcQCDspDestroy () {
    return ;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Chk_Err()
  static int rcQCChkErr () {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Cash_End_Disp2()
  static void rcQCCashEndDisp2 (int typ) {
    return ;
  }

  // TODO:00008 宮家 中身の実装予定
  /// 関連tprxソース: rcqc_dsp.c - rcQC_PayDsp()
  static void rcQCPayDsp() {
    return;
  }

  /// 関連tprxソース: rcqc_dsp.c - rcQC_BackBtn_Func()
  static void rcQCBackBtnFunc() {
    // 支払選択画面まで戻る.
    SetMenu1.navigateToPaymentSelectPage();
    return;
  }

  // TODO:00008 宮家 中身の実装予定
  /// 関連tprxソース: rcqc_dsp.c - rcGet_QP_FncCode()
  static int rcGetQPFncCode() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  // TODO:00004 小出 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcGet_ID_FncCode()
  static int rcGetIDFncCode() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  // TODO:00008 宮家 中身の実装予定
  /// 関連tprxソース: rcqc_dsp.c - rcQC_PayEnd_Disp()
  static int rcQCPayEndDisp() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcqc_dsp_cleate_receipt_select
  static void rcqcDspCleateReceiptSelect(int fncCd){
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c - rcqc_dsp_nimoca_yes_no
  static void rcqcDspNimocaYesNo(int data) {
    return;
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  /// 関連tprxソース:C rcinoutdsp.c - rcQC_Mente_Total_Info_Create
  static void rcQCMenteTotalInfoCreate() {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Check_Change_Info()
  static void rcQCCheckChangeInfo() {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Mente_Main_Btn_End_Disp()
  static void rcQCMenteMainBtnEndDisp(int typ) {
    return;
  }

  // TODO:00014 日向 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Staff_Use_Now_Dsp
  static void rcQCStaffUseNowDsp() {
    return;
  }

  // TODO:00014 日向 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Mente_SpritInfo_Create
  static void rcQCMenteSpritInfoCreate() {
    return;
  }

  /// 関連tprxソース: rcqc_dsp.c - rcQC_Cash_Dsp_PayFish_Pixmap
  /// TODO:00015 江原 定義のみ先行追加
  static void rcQCCashDspPayFishPixmap() {}

  /// 機能：QCashierの「おわり」ボタンを外部参照で呼び出す
  /// 関連tprxソース: rcqc_dsp.c - rcqc_dsp_color_fip_cashbtn
  /// TODO:00010 長田 定義のみ追加
  static void rcQCDspColorFipCashBtn(int status) {
    return;
  }

  /// 関連tprxソース: rcqc_dsp.c - rcQC_CashDsp_Body_Parts
  /// TODO:00010 長田 定義のみ追加
  static void rcQCCashDspBodyParts(int typ) {
    return;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_AllTimer_Remove
  static void	rcQCAllTimerRemove() {
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Cash_Dsp
  static void rcQCCashDsp() {
  }
  

  /// Shop&Goの会員読取画面でプリカ宣言による読取操作でCoGCa1度読みの設定かチェックする
  /// 戻り値: true=上記設定  false=上記設定でない
  /// 関連tprxソース: rcqc_dsp.c - rcQC_SAG_Chk_MbrCard_ReadTyp_IcRead
  static Future<int> rcQCSAGChkMbrCardReadTypIcRead() async {
    if (await RcSysChk.rcChkCogcaSystem() && (qcMbrReadDsp.mbrcard_readtyp == MbrcardRedType.IC_READ) && (QCashierIni().shop_and_go_cogca_read_twice == 0)) {
      return 1; // プリカ宣言操作で1度読み設定が有効
    } else {
      return 0; // 会員読込画面でプリカ宣言操作ではないまたは1度読み設定が無効
    }
  }

  /// 関連tprxソース: rcqc_dsp.c - rcQC_Chk_Change_Stock
  static Future<void> rcQCChkChangeStock() async {
    String log = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
        TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrA() rxMemRead error\n");
        return ;
      }
      RxTaskStatBuf tsBuf = xRet.object;
      RxCommonBuf cBuf = xRet.object;

    if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "__FUNCTION__: AUTO exit\n");
      return;
    }

    if (RcQcDsp.rcQCChkErr() != 0 || (tsBuf.chk.errstat_flag != 0)) {
      log = '__FUNCTION__: Err return[${tsBuf.chk.errstat_flag}]';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return;
    }

    if ((RcQcCom.qc_acracb_flg != 0) && (RcAcracb.rcCheckAcrAcbON(1) != 0)) {
      Dummy.rcAcrAcbStockUpdate(1);

      if (qCashierIni.chg_info == 1) {
        Dummy.rcQCCheckChangeInfo();
        if (cBuf.dbTrm.coopaizuFunc1 != 0) {
          Dummy.rcQCSignPCtrlProc();
          return;
        }
        if (qcChageLackdspFlg == 1 || qcChageFulldspFlg == 1) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, 'QCashier:Start Disp Change Lack Go to SusDsp\n');
          Dummy.rcQCChangeLackProc();
        } else if (qcEndSusdspFlg == 1 && qcMenteBackChgerrNo != 0) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, 'QCashier:Start Disp Changer Err Go to SusDsp\n');
          Dummy.rcQCChangeLackProc();
        } else {
          Dummy.rcQCSignPCtrlProc();
        }
      }
    }
  }

  /// 関連tprxソース: rcqc_dsp.c - rcQC_DateTime_Change
  Future<void> rcQCDateTimeChange(int status) async {
    if ((RcRegs.rcInfoMem.rcRecog.recogICCardSystem != 0)
        || (RcSysChk.rcsyschkVescaSystem())
        || (RcSysChk.rcChkPrecaTyp() != 0)
        || (RcSysChk.rcChkQCMultiSuicaSystem() != 0)) {
      if (RcQcCom.qcInqudispCtrl == 1) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "__FUNCTION__ : No action !! because qcInqudispCtrl = [${RcQcCom
                .qcInqudispCtrl}]\n");
        return; // 処理中です画面を表示中なので、表示の更新をしない
      }
    }

    if (RcSysChk.rcChkMultiVegaSystem() != 0) {
      AtSingl atSing = SystemFunc.readAtSingl();
      if (atSing.multiVegaWaitFlg == 2) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "__FUNCTION__ : No action !! because RcRegs.atSing.multiVegaWaitFlg = [${atSing.multiVegaWaitFlg}]\n");
        return; // 処理中です画面を表示中なので、表示の更新をしない
      }
    }

    if (RcSysChk.rcsyschk2800VFHDSystem() != 0) /* 縦型21.5インチ */ {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "__FUNCTION__ : No action !! because vfhd system \n");
      return; // 表示しないので更新をしない
    }

    if ((RcSysChk.rcChkRPointMbrReadTMCQCashier() !=
        0) /* タカラ様仕様での精算機で楽天ポイントカード読込可能なレジ */
        && ((RcFncChk.rcQCCheckRPtsMbrYesNoMode()) /* 精算機での楽天ポイントカード確認画面 */
            || (RcFncChk
                .rcQCCheckRPtsMbrReadMode()))) /* 精算機での楽天ポイントカード読込画面 */ {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "__FUNCTION__ : No action !! because rpoint mbr read TMC QCashier\n");
      return; // 表示しないので更新をしない
    }

    /* タカラ様仕様での精算機またはフルセルフで楽天ポイント利用画面の時動作しない */
    if (((RcSysChk.rcChkRPointMbrReadTMCQCashier() !=
        0) /* タカラ様仕様での精算機で楽天ポイントカード読込可能なレジ */
        || (await RcSysChk.rcChkRPointSelfSystem())) /* 楽天ポイント仕様のフルセルフレジ */
        &&
        (RcFncChk.rcQCCheckRpointPayConfDspMode())) /* 楽天ポイント利用確認画面 */ {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "__FUNCTION__ : No action !! because rpoint pay conf dsp\n");
      return; // 表示しないので更新をしない
    }

    if (await RcSysChk.rcSysChkHappySmile()) {
      if (RxTaskStatBuf().chk.chk_registration == 1) { // 次客登録中
        if (status == 1) { // ャッシャータスクからの更新指示
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "__FUNCTION__ : No action !! because status = [$status]\n");
          return; // キャッシャータスクからの表示の更新をさせない為
        }
      }

      if (RcNewSgDsp.rcCheckClinicMode() != 0) { //クリニックモード
        // C言語のGUI関連処理なので、Dartで実装される新POSでは破棄
        // if((QCCashDsp.greeting_pixmap != NULL)	//あいさつ文言が表示されている場合
        //     || (QCPayDsp.greeting_pixmap != NULL))
        // {
        //   memset(log, 0x0, sizeof(log));
        //   sprintf(log, "%s : No action !! because greeting_pixmap Not NULL\n", __FUNCTION__);
        //   TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
        //   return;	//あいさつ文言に重なってしまうため時刻表示の更新をさせない
      }
    }

    // C言語のGUI関連処理なので、Dartで実装される新POSでは破棄
    // if(RcQcCom.qc_payrfd_msg == 1) {
    //  && (tColorFipItemInfo.payrfd_window != NULL))
    // snprintf(log, sizeof(log), "%s : No action !! because qc_payrfd_msg = [%d]\n", __FUNCTION__, qc_payrfd_msg);
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    // return;	// 元取引返金額出金のメッセージ表示中なので、表示の更新をしない
    //}

    if (RcSysChk.rcsyschkTomoIFSystem()) {
      if (await RcSysChk.rcSysChkHappySmile()) {
        AtSingl atSing = SystemFunc.readAtSingl();
        if (atSing.tomonokaiReadingflg != 0) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "__FUNCTION__ : No action !! because RcRegs.atSing.tomonokaiReadingflg ON.n");
          return; // 処理中です画面を表示中なので、表示の更新をしない
        }
      }
    }

    if ((RcFncChk.rcCheckReservMode())
        && (RcReserv.reserv.colorfipPopupChk == 1)
        && (status == 1)) {
      /* 予約中の場合は、描画更新行わない */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "__FUNCTION__ : No action !! because Reserv_Mode\n");
      return;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "__FUNCTION__<happy_smile> : qcFuncTimer[$qcFuncTimer], ScrMode[${AcMem().stat.scrMode}]\n");

    if ((await RcFncChk.rcCheckItmMode())
        || (RcFncChk.rcCheckValueCardMode() || RcFncChk.rcCheckValueCardMIMode())
        || (RcFncChk.rcCheckRepicaMode() && ((RcRepica.repica.fncCode == FuncKey.KY_PRECA_REF.keyId) ||
            RcRepica.rcCheckRepicaDepositItem(1) != 0))
        || (RcFncChk.rcCheckPassportInfoMode() != 0)
        || (Rc28dsp.rc28dspCheckInfoSlct())
        || (RcSysChk.rcChkFIPEmoneyStandardSystem() && RcFncChk.rcCheckAjsEmoneyMode())) {
      if (status == 1) { // 再描画したい為
        await Rc28StlInfo.rcFselfSubttlRedisp();
      }
    }
    else if ((RcCogca.rcCogcaDspFlgChk() != 0)
        || (RcKyCatCardRead.rcCatCardReadDspFlgChk() != 0)
        || (RcFncChk.rcCheckCogcaMode())
        || (RcFncChk.rcCheckRepicaMode() || RcFncChk.rcCheckRepicaTCMode())
        || (await RcFncChk.rcCheckCatCardReadMode())) {
      if ((AcMem().stat.bkScrMode != RcRegs.RG_STL) &&
          (AcMem().stat.bkScrMode != RcRegs.TR_STL)) {
        if (status == 1) { // 再描画したい為
          await Rc28StlInfo.rcFselfSubttlRedisp();
        }
      }
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "QCashier: rcQC_DateTime_Change Start qcFuncTimer[$qcFuncTimer], ScrMode[${AcMem().stat.scrMode}]");
    return;

  }

  /// 関連tprxソース: rcqc_dsp.c - rcQC_SusDsp_OverFlow_Type_Set
  static Future<void> rcQCSusDspOverFlowTypeSet(int flg) async {
    //休止画面モードは変更せずに、オーバーフロー自動回収モードをセットし画面モード判定のように使用する
    if (AcxCom.ifAcbSelect() != CoinChanger.ECS_777) { // 富士電機(ECS-777)
      return;
    }

    if (flg == 0) {
      if (qcSusdspOverflowScreen != flg) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "RcQcDsp.rcQCSusDspOverFlowTypeSet() : flg[$flg] clear");
        qcSusdspOverflowScreen = flg;
      }
    } else {
      if (qcChageFulldspFlg == 1) { //ニアフル休止なら
        if (qcSusdspOverflowScreen != flg) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "RcQcDsp.rcQCSusDspOverFlowTypeSet() : flg[$flg] set");
          qcSusdspOverflowScreen = flg;
        }
      }
    }
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 会員リード画面を消去する
  /// 関連tprxソース: rcqc_dsp.c - rcQC_MbrRead_Dsp_Destroy
  static void rcQCMbrReadDspDestroy() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 関連tprxソース: rcqc_dsp.c - rcQC_LangChgFunc
  static void rcQCLangChgFunc() {}

  /// 会員カード読込画面の呼出し元QCスクリーン番号をチェックする
  /// 戻り値: 変数qc_mbrread_call_scrmode_bk
  /// 関連tprxソース: rcqc_dsp.c - rcqc_dsp_Qcashier_Member_Read_ReadErr_CallScrMode_Chk
  static Future<int> rcChkQcashierMemberReadReadErrCallScrMode(String callFunc) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcQcDsp.rcChkQcashierMemberReadReadErrCallScrMode( call_func: $callFunc ) qc_mbrread_call_scrmode_bk[$qc_mbrread_call_scrmode_bk]");
    return qc_mbrread_call_scrmode_bk;
  }

  /// 会員カード読込以降の支払い完了が可能か判断するためのフラグに引数の値をセットし、フラグを更新する
  /// 引数:[callFunc] 呼出元の関数
  /// 引数:[setFlg] 0=保持  1=ファンクションコードを戻す
  /// 関連tprxソース: rcqc_dsp.c - rcqc_dsp_Qcashier_Member_Read_CashEndFlg_Set
  static Future<void> rcQcashierMemberReadCashEndFlgSet(String callFunc, int setFlg) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcQcDsp.rcQcashierMemberReadCashEndFlgSet( call_func: $callFunc ) Set qc_mbrread_cashend_flg[$setFlg]");
    qc_mbrread_cashend_flg = setFlg;
  }

  /// 機能概要     : プリペイドの置数支払画面の置数描画処理
  /// パラメータ   : なし
  /// 戻り値       : なし
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Preca_EntryDsp_Entry
  static void rcQCPrecaEntryDspEntry() {
    // TODO:10164 自動閉設 gtk系の為保留
    // QCPrecaEntryDsp.entry_amt_pixmap = rcQC_Amount_Title_Pixmap(QCPrecaEntryDsp.window, QCPrecaEntryDsp.back_pixmap, QCPrecaEntryDsp.entry_amt_pixmap, QC_LED_BOX_YELLOW, QC_PRECAAMT_ENTRY);
    // if(QCPrecaEntryDsp.entry_amt_pixmap != NULL) {
    // QCPrecaEntryDsp.entry_amt_lbl = rcQC_Dsp_Amount_Lbl(QCPrecaEntryDsp.window, QCPrecaEntryDsp.entry_amt_pixmap, NULL, QC_PRECAAMT_ENTRY);
    // }
    // TODO:10164 自動閉設 UI系の為保留
    // rcQC_Preca_EntryDsp_PayBtn_Pixmap();
  }

  /// 取消理由選択画面で選択された理由番号をセットする
  /// 関連tprxソース: rcqc_dsp.c - rcQC_MenteCnclKyPrg
  static Future<void> rcQCMenteCnclKyPrg(int selBtn) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "RcQcDsp.rcQCMenteCnclKyPrg [$selBtn]");
    await qcMenteCnclYesClicked();
  }

  /// 関連tprxソース: rcqc_dsp.c - qc_mente_cncl_yes_clicked
  static Future<void> qcMenteCnclYesClicked() async {
    String callFunc = "RcQcDsp.qcMenteCnclYesClicked()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, callFunc);

    TprDlg.tprLibDlgClear(callFunc);
    FbInit.fbXgaDispControl(0);

    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (RcSysChk.rcChkReasonSelectSystem()
        && (mem.prnrBuf.reason.reasonStat != 1)
        && (mem.tTtllog.t100001Sts.sptendCnt == 0) ) {
      /* 理由選択仕様 and 理由選択番号が未セット and スプリット・テンド利用回数が0 */
      cMem.stat.fncCode = FuncKey.KY_CNCL.keyId;
      if (await RcReason.rcReasonDisplay(cMem.stat.fncCode)) {
        /* 理由入力 SM7_HOKUSHIN */
        RcKyStfRelease.rcPrgStfReleaseRestore(); /* 権限解除 SM7_HOKUSHIN */
        return;
      }
    }

    if ( (CompileFlag.ARCS_MBR && (await RcSysChk.rcChkNTTDPrecaSystem()))
        || RcSysChk.rcChkTRKPrecaSystem() ) {
      if ((mem.tmpbuf.autoCallReceiptNo != 0) &&
          (mem.tmpbuf.autoCallMacNo != 0)) {
        if (mem.tmpbuf.autoCallReceiptNo != RcqrCom.qrReadReptNo) {
          await RcExt.rcErr(
              callFunc, DlgConfirmMsgKind.MSG_ONLY_SPEEZA_ERR.dlgId);
          return;
        }
      }
    }

    // スプリット中のキャンセルチェック
    if (RcSysChk.rcsyschkTomoIFSystem()) {
      if (RckyTomoCard.rcTomoCardSpTendAmt() > 0) {
        await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INC_BAN_SPTEND_NOT_CNCL.dlgId);  // 取消できない締め操作が含まれるため、この操作はできません
        return;
      }
    }

    int ctrlFlg = 0;
    if ((RcRegs.rcInfoMem.rcRecog.recogVescaSystem != 0)
      && (RcRegs.rcInfoMem.rcCnct.cnctGcatCnct != 18)) {
      // Speezaにverifoneが接続されている場合
      if (await RcGcat.rcGcatVescaSptendCheck() != Typ.OK) {
        await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_JMUPS_NOT_CANCEL.dlgId);  // 取消できない締め操作が含まれるため、この操作はできません
        return;
      }
    }
    else {
      if (RcSysChk.rcsyschkVescaSystem()) {
        if (await RcFncChk.rcChkRegMultiChargeItem(FclService.FCL_SUIC.value, 1) > 0) {
          // チャージ商品登録済み？
          if (await RckySus.rcCheckSuspend() == 0) {
            ctrlFlg = 1;
          }
        }
      }
    }

    // TODO:10122 グラフィック処理
    /*
    RcDetect.rcFncDetect(FuncKey.KY_CNCL.keyId);
    if ( rcQC_Chk_Err_Non() )	{
      RcDetect.rcFncDetect(FuncKey.KY_CNCL.keyId);
      RcQcCom.rcQCSound(QcScreen.QC_SCREEN_MENTE.index, QcSoundTyp.QC_SOUND_TYP2);
      rcQC_Set_KeyImgData(IMG_CNCLEND);
      cm_spc((char *)&QC_MenteDsp.qc_mente_ent, sizeof(QC_MenteDsp.qc_mente_ent));
      cm_mov((char *)&QC_MenteDsp.qc_mente_ent[3], img_buf, strlen(img_buf));
      QC_MenteDsp.qc_mente_ent[35] = 0x00;
      Fb2Gtk.gtkRoundEntrySetText(GTK_ROUND_ENTRY(QC_MenteDsp.ent_entry), QC_MenteDsp.qc_mente_ent);
      gtk_widget_hide(QC_MenteDsp.interrupt_btn);
      if (ctrlFlg == 1) {
        // チャージ商品の登録を取消した
        AtSingl atSing = SystemFunc.readAtSingl();
        atSing.verifoneResumeAct = 1;
      }
      if (RcSysChk.rcsyschkSm66FrestaSystem()
          && (await CmCksys.cmFipEmoneyStandardSystem() != 0) ) {
        qc_marukyu_maruca_charge_flg = 0;
      }
      if ((await RcSysChk.rcChkShopAndGoSystem())
          && (RcSysChk.rcsyschk2800VFHDSystem())) {
        /* 縦型21.5インチ */
        rcQC_SAG_Font_LangChg(QC_LANG_JP);	/* 日本語のフォントに戻す */
      }
      if ((await RcSysChk.rcChkVFHDSelfSystem())
          || (rcsyschk_VFHD_QC_system())) {
        /* 15.6インチフルセルフ and 15.6インチ精算機 */
        rcSG_Font_LangChg(QC_LANG_JP, 0);
      }
    }
     */
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 引数: コールバック対応処理フラグ
  /// 戻り値: 0=正常終了  -1=異常終了
  /// 関連tprxソース: rcqc_dsp.c - rcQC_BackBtn_Func2
  static int rcQCBackBtnFunc2(int callBack) {
    return 0;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// カード読込画面 もどるボタン 画面遷移の動作
  /// 関連tprxソース: rcqc_dsp.c - rcQC_AnyCustCard_Read_Back
  static Future<void> rcQCAnyCustCardReadBack() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier: RcQcDsp.rcQCAnyCustCardReadBack(): start");

    // 読み込んだ会員情報、プリカ宣言状態をクリアする。
    await RckyMbre.rcClr2ndMbrClr();
    await RcKyPrecaRemove.rcClr2ndPrecaClr();

    // 単体プリカチャージの場合はクリアする。
    if (RcQcCom.qc_preca_charge_limit_amt == -1) {
      RcQcCom.qc_preca_charge_limit_amt = 0;
    }

    // 画面遷移処理
    switch (RcQcCom.qc_com_screen) {
      case 104:  //QcScreen.QC_SCREEN_VEGA_COGCA_CARDREAD_WAIT.value
      case 105:  //QcScreen.QC_SCREEN_VEGA_MS_CARDREAD_WAIT.value
      case 106:  //QcScreen.QC_SCREEN_COGCAIC_CARDREAD_WAIT.value
        // カード選択画面へ
        rcQCAnyCustCardReadBackToCardSelect();
        break;
      case 107:  //QcScreen.QC_SCREEN_COGCA_CHARGE_CARDREAD_WAIT.value
      case 3:  //QcScreen.QC_SCREEN_CASH.value
        // スタート画面へ
        rcQCAnyCustCardReadBackToStartScreen();
        break;
      default:
        break;
    }

    return;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// カード読込画面からカード選択画面に戻る
  /// 関連tprxソース: rcqc_dsp.c - rcQC_AnyCustCard_Read_BackTo_CardSelect
  static void rcQCAnyCustCardReadBackToCardSelect() {
    /*
    if (RcQcCom.qc_com_screen == QcScreen.QC_SCREEN_VEGA_COGCA_CARDREAD_WAIT.index) {
      rcQC_AnyCustCard_Read_Dsp_Destroy();
    }
    rcQC_Set_BackScreen();
    rcQC_AnyCustCard_Select_Dsp();	/* 画面作成 */
     */
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// カード読込画面からスタート画面に戻る
  /// 関連tprxソース: rcqc_dsp.c - rcQC_AnyCustCard_Read_BackTo_StartScreen
  static void rcQCAnyCustCardReadBackToStartScreen() {
    /*
    if (RcQcCom.qc_com_screen == QcScreen.QC_SCREEN_VEGA_COGCA_CARDREAD_WAIT.index) {
      rcQC_AnyCustCard_Read_Dsp_Destroy();
    }

    if (RcQcCom.qc_com_screen == QcScreen.QC_SCREEN_CASH.index) {
      //プリカチャージ画面から入金機画面へ移行処理
      if (QCCashDsp.window != null) {
        gtk_widget_destroy(QCCashDsp.window);
        QCCashDsp.window = NULL;
      }
      rcQC_Sound_Stop();
      rcQC_Sound( QC_SCREEN_MENTE, QC_SOUND_TYP2 );
      rcQC_Movie_Stop();
      rcProc_Cncl_ChangeOut(0);
      rcClr_2nd_Cncl();
      rcEnd_2nd_Cncl();
    }

    qc_now_lang_typ = RcQcDsp.QCashierIni.language_typ;
    qr_txt_status = QR_TXT_STATUS_INIT;
    rcQC_StartDsp_ScrMode();
    rcQC_Set_StartScreen();
    rcQC_StrBtn_Show();		/* スタート画面の再描画 */
    if_detect_enable();
    rcQC_DateTime_Change(0);

    if (RcQcDsp.QCashierIni.data[QC_SCREEN_START].sound1 != 0) {
      rcQC_Sound( QC_SCREEN_START, QC_SOUND_TYP1 );
    }
    rcQC_MovieFile_Set(QC_SCREEN_START);
    rcQC_Movie_Start();
    rcQC_SignP_Ctrl_Proc();
     */
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 戻るボタン押下時の処理
  /// 関連tprxソース: rcqc_dsp.c - rcQC_StrBackBtn_Fnc
  static void rcQCStrBackBtnFnc(Object? widget, Object? data) {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_EMny_EndBtn_Func
  static void rcQCEMnyEndBtnFunc() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 精算機での会員カード読取画面の入力制御
  /// 関連tprxソース: rcqc_dsp.c - rcqc_dsp_Qcashier_Member_Read_Entry_End
  static void rcQCDspQcashierMemberReadEntryEnd() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// [12ver:アークス様 Shop&Go仕様] カード読込中「戻る」ボタンでVEGA端末キャンセル後、状態に応じて画面を遷移する
  /// 関連tprxソース: rcqc_dsp.c - rcQC_StrBackBtn_Proc
  static void rcQCStrBarkBtnProc() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// [12ver:後会員仕様] 会員選択画面ボタン
  /// 関連tprxソース: rcqc_dsp.c - rcQC_Arcs_Payment_Mbr_Read_Disp
  static void rcQCArcsPaymentMbrReadDisp() {}

  /// HappySelf対面レジ向け カード読込画面表示
  /// 引数: 変数RcQcCom.qc_com_screen にセットする値
  /// 関連tprxソース: rcqc_dsp.c - rcQC_AnyCustCard_Read_Happy_CustDsp
  static Future<void> rcQCAnyCustCardReadHappyCustDsp(int qcScreenType) async {
    if (CompileFlag.COLORFIP) {
      if (Rc28StlInfo.colorFipChk() != 1) {
        return;
      }
      if (await RcFncChk.rcChkFselfPayMode()) {
        return;
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "QCashier: RcQcDsp.rcQCAnyCustCardReadHappyCustDsp() <happy_smile> : start");

      RcQcCom.qc_com_screen = qcScreenType;

      /* 客側へカード読込画面を表示 */
      Rc28StlInfo.colorFipWindowDestroy();
      rcQCAnyCustCardReadDspProc();	/* 画面作成 */
    }
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側）
  /// カード読込画面の作成・表示
  /// 関連tprxソース: rcqc_dsp.c - rcQC_AnyCustCard_Read_Dsp_Proc
  static void rcQCAnyCustCardReadDspProc() {}

  // TODO:定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_SlctDsp_Destroy
  static void rcQCSlctDspDestroy() {}
  // TODO:定義のみ追加
  /// 関連tprxソース: rcqc_dsp.c - rcQC_WAON_ReadErrDisp
  static void rcQC_WAON_ReadErrDisp() {}

  /// 関連tprxソース: rcqc_dsp.c - rcQC_PSen_Err
  static Future<void> rcQCPSenErr(int dlg_ptn, String err_ptn) async {
    tprDlgParam_t param = tprDlgParam_t();
    int	ret;
    AcMem cMem = SystemFunc.readAcMem();
    SgMem selfMem = SgMem();
    AtSingl atSingl = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ;
    }
    RxCommonBuf cBuf = xRet.object;
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((await RcSysChk.rcQCChkQcashierSystem()) && (RcSysChk.happyQCType == 0)) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcQC_Movie_Stop();
      // rcQC_Sound_Stop();
    }

    // rxMemPtr(RXMEM_COMMON, (void **)&cBuf); いらｎ
    switch(err_ptn) {
    // TODO:10166 クレジット決済 20241004実装対象外
//     case 'O': //バーコード確認
//     sg_psen_pop_err_flg = 1;        //困惑検知用POPメッセージフラグ
//
//     if(dlg_ptn == 0) //自動消去
//         {
//     if (rcsyschk_VFHD_self_system())        /* 15.6 */
//     {
//     rcSG_VFHD_PsenAlert_Proc();
//     }
//     else
//     {
//     memset(&param, 0x00, sizeof(tprDlgParam_t));
//     param.er_code = MSG_BARCODE_CHECK;
//     param.dialog_ptn = TPRDLG_PT7;
//     await RcObr.rcScanDisable();
//     cMem.ent.err_stat = 1; //エラーステータスを立てる
//     ret = TprLibDlg(&param);
//     psen_movie_timer = gtk_timeout_add( cBuf.psensor_disptime, (GtkFunction)rcQC_PSen_Movie_Restart, NULL );
//     }
//     cm_clr((char *)&asst_pc_log[0], sizeof(asst_pc_log));
// //                              strcat(asst_pc_log, ER_MSG_BARCODE_CHECK);
//     rc_Assist_Send(MSG_BARCODE_CHECK);
//     }
//     else
//     {
//     if(dlg_ptn == 2) //店員呼出
//         {
//     if(await RcSysChk.rcNewSGChkNewSelfGateSystem())
//     {
//     selfMem.QC_Staff_Call = 1;
//     }
//     }
//     if(dlg_ptn == 1) //確認
//         {
//     if((await RcSysChk.rcQCChkQcashierSystem()) && (RcSysChk.happyQCType == 0))
//     {
//     qCCallDsp.qc_call_dsp = 1;
//     }
//     }
//     rcErr(MSG_BARCODE_CHECK_OPE);
// //				Psensor_EJ(2);
//     }
//     if(cBuf.psensor_scan_slow_sound)
//     {
//     rcPsen_Voice_Sound_GtkTimerAdd(500, (GtkFunction)rcPsen_Swing_Slow_Voice_Proc);
//     }
//     break;
//     case 'C': //スキャンミス
//     sg_psen_pop_err_flg = 0;        //空振り検知用POPメッセージフラグ
//     aibox_swing_err_chk_flg = 1;	// 空振り検知通知・確認形式の時、確認ボタンを押下した際AIBOXに通知を送るかどうかのフラグ(1で送る)
//
//     if(dlg_ptn == 0)
//     {
//     if (rcsyschk_VFHD_self_system())	/* 15.6 */
//     {
//     rcSG_VFHD_PsenAlert_Proc();
//     }
//     else
//     {
//     memset(&param, 0x00, sizeof(tprDlgParam_t));
//     if ( (await RcSysChk.rcNewSGChkNewSelfGateSystem())
//     &&  ((rcCheck_Stl_Mode())
//     ||   (rcSG_Check_Pre_Mode())) )	/* フルセルフのアイテムリスト、プリセット画面 */
//     {
//     param.er_code = MSG_REGS_AGAIN;
//     }
//     else
//     {
//     param.er_code = MSG_CANT_SCAN;
//     }
//     param.dialog_ptn = TPRDLG_PT7;
//     await RcObr.rcScanDisable();
//     cMem.ent.err_stat = 1;
//     ret = TprLibDlg(&param);
//     psen_movie_timer = gtk_timeout_add( cBuf.psensor_disptime, (GtkFunction)rcQC_PSen_Movie_Restart, NULL );
//     }
//     cm_clr((char *)&asst_pc_log[0], sizeof(asst_pc_log));
//     if ( (await RcSysChk.rcNewSGChkNewSelfGateSystem())
//     &&  ((rcCheck_Stl_Mode())
//     ||   (rcSG_Check_Pre_Mode())) )
//     {
// //					strcat(asst_pc_log, ER_MSG_REGS_AGAIN);
//     rc_Assist_Send(MSG_REGS_AGAIN);
//     }
//     else
//     {
// //					strcat(asst_pc_log, ER_MSG_CANT_SCAN);
//     rc_Assist_Send(MSG_CANT_SCAN);
//     }
// //				Psensor_EJ(0);
//     }
//     else
//     {
//     /* AIBOX(AIBOX 検知プログラム一時停止) */
//     if((cm_aibox_system() == 1) && (aibox_prog_stop_flg == 1))
//     {
//     if_aibox_Send(108);
//     }
//
//     if(dlg_ptn == 2)
//     {
//     if(await RcSysChk.rcNewSGChkNewSelfGateSystem())
//     {
//     selfMem.QC_Staff_Call = 1;
//     }
//     }
//     if(dlg_ptn == 1)
//     {
//     if((await RcSysChk.rcQCChkQcashierSystem()) && (RcSysChk.happyQCType == 0))
//     {
//     qCCallDsp.qc_call_dsp = 1;
//     }
//     }
//     rcErr(MSG_CANT_SCAN_OPE);
//     }
//     if(cBuf.psensor_scan_slow_sound)
//     {
//     rcPsen_Voice_Sound_GtkTimerAdd(500, (GtkFunction)rcPsen_Swing_Slow_Voice_Proc);
//     }
//     break;
      case 'A': //立ち去り
        if (dlg_ptn == 0) {
          // memset(&param, 0x00, sizeof(tprDlgParam_t));
          param.erCode = DlgConfirmMsgKind.MSG_GOAWAY.dlgId;
          param.dialogPtn = DlgPattern.TPRDLG_PT7.dlgPtnId;
          await RcObr.rcScanDisable();
          cMem.ent.errStat = 1;
          TprLibDlg.tprLibDlg2("rcQCPSenErr", param);
          // TODO:10166 クレジット決済 20241004実装対象外
          // psen_movie_timer = Fb2Gtk.gtkTimeoutAdd(cBuf.psensorDisptime, rcQC_PSen_Movie_Restart, 0);
          RcAssistMnt.asstPcLog = "";
          // TODO:10166 クレジット決済 20241004実装対象外
          // RcAssistMnt.rcAssistSend(DlgConfirmMsgKind.MSG_GOAWAY.dlgId);
          if (!(RcFncChk.rcCheckRegistration())) {}
        }
        else {
          if (dlg_ptn == 2) {
            if (await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
              selfMem.QC_Staff_Call = 1;
            }
          }
          if (dlg_ptn == 1) {
            if ((await RcSysChk.rcQCChkQcashierSystem()) &&
                (RcSysChk.happyQCType == 0)) {
              if (await RcSysChk.rcChkVegaProcess()) {
                if (RcFncChk.rcQCCheckPrePaidReadDspMode() ||
                    RcFncChk.rcQCCheckCrdtDspMode()) {
                  if (atSingl.psenErrFlg == 0) {
                    cBuf.vega3000Conf.vega3000CancelFlg = 1;
                    atSingl.psenErrFlg = 1;
                    return;
                  }
                }
                else if (await RcFncChk.rcQCCheckBarcodePayReadMode()) {
                  if (mem.bcdpay.bar.type != 0) {
                    return;
                  }
                }
                else if (await RcFncChk.rcQCCheckBarcodePayQRReadMode()) {
                  if (atSingl.psenErrFlg == 0) {
                    tsBuf.bcdpay.cancel_flg = 1;
                    atSingl.psenErrFlg = 1;
                    return;
                  }
                }
                else if ((RcFncChk.rcQCCheckEdyDspMode()) &&
                    (tsBuf.multi.order != FclProcNo.FCL_NOT_ORDER.index)) {
                  // TODO:10166 クレジット決済 20241004実装対象外
                  // rcMultiEdy_Cancel_Proc();
                }
              }
              else if (RcSysChk.rcsyschkVescaSystem()) {
                if (RcFncChk.rcQCCheckCrdtDspMode()) {
                  if (atSingl.psenErrFlg == 0) {
                    tsBuf.jpo.jmupsAcFlg = 1;
                    atSingl.psenErrFlg = 1;
                    return;
                  }
                }
                else if (await RcFncChk.rcQCCheckBarcodePayReadMode()) {
                  if (mem.bcdpay.bar.type != 0) {
                    return;
                  }
                }
                else if (await RcFncChk.rcQCCheckBarcodePayQRReadMode()) {
                  if (atSingl.psenErrFlg == 0) {
                    tsBuf.bcdpay.cancel_flg = 1;
                    atSingl.psenErrFlg = 1;
                    return;
                  }
                }
                else if ((RcFncChk.rcQCCheckEdyDspMode()) &&
                    (tsBuf.multi.order != FclProcNo.FCL_NOT_ORDER.index)) {
                  // TODO:10166 クレジット決済 20241004実装対象外
                  // rcMultiEdy_Cancel_Proc();
                }
                else if ((RcFncChk.rcQCCheckPrePaidReadDspMode()) &&
                    (await RcSysChk.rcCheckUSBICCardCnct() != 0)) {
                  if (atSingl.inputbuf.dev == DevIn.D_ICCD1) {
                    return;
                  }
                  // TODO:10166 クレジット決済 20241004実装対象外
                  // if_iccard_FindStop();
                  atSingl.psenErrFlg = 1;
                }
              }
              else {
                if ((RcFncChk.rcQCCheckPrePaidReadDspMode()) &&
                    (await RcSysChk.rcCheckUSBICCardCnct() != 0)) {
                  if (atSingl.inputbuf.dev == DevIn.D_ICCD1) {
                    return;
                  }
                  // TODO:10166 クレジット決済 20241004実装対象外
                  // if_iccard_FindStop();
                  atSingl.psenErrFlg = 1;
                }
                else if (await RcFncChk.rcQCCheckBarcodePayReadMode()) {
                  if (mem.bcdpay.bar.type != 0) {
                    return;
                  }
                }
                else if (await RcFncChk.rcQCCheckBarcodePayQRReadMode()) {
                  if (atSingl.psenErrFlg == 0) {
                    tsBuf.bcdpay.cancel_flg = 1;
                    atSingl.psenErrFlg = 1;
                    return;
                  }
                }

                else if ((RcFncChk.rcQCCheckEdyDspMode()) &&
                    (tsBuf.multi.order != FclProcNo.FCL_NOT_ORDER.index)) {
                  // TODO:10166 クレジット決済 20241004実装対象外
                  // rcMultiEdy_Cancel_Proc();
                }
              }
              qCCallDsp.qcCallDsp = 1;
            }
          }
          await RcExt.rcErr("rcQCPSenErr", DlgConfirmMsgKind.MSG_GOAWAY_OPE.dlgId);
          if (!(RcFncChk.rcCheckRegistration())) {}
          if ((await RcSysChk.rcQCChkQcashierSystem()) &&
              (RcSysChk.happyQCType == 0)) {
            if (qCCallDsp.qcCallDsp == 1) {
              qCCallDsp.qcCallDsp = 0;
            }
          }
        }
        if(cBuf.psensorAwaySound != 0) {
          // TODO:10166 クレジット決済 20241004実装対象外
          // rcPsen_Away_Voice_Proc();
        }
        break;
    // TODO:10166 クレジット決済 20241004実装対象外
    // case 'I':
    // if(!(rcCheck_Registration()))
    // {
    // rcErr(MSG_GOAWAY);
    // }
    // break;
      default:
        break;
    }
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c - rcQC_dPoint_EntProc
  static void rcQCDPointEntProc(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcQC_dPoint_Info
  static void rcQCDPointInfo(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcQC_dPointEntDsp_Fnc
  static void rcQCDPointEntDspFnc(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcQC_dPointEnt_Dsp
  static void rcQCDPointEntDsp(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcQC_dPoint_EntProcMain
  static void rcQCDPointEntProcMain(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcQC_Chk_UsePoint_dPointDsp
  static int rcQCChkUsePointDPointDsp(){
    return 0;
  }
  
  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcQC_dPoint_EntDsp_Entry
  static void rcQCDPointEntDspEntry(){}
  
  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_vesca_emnydisp
  static void rcqcDspVescaEmnydisp(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_vesca_suspend_charge_proc
  static void rcqcDspVescaSuspendChargeProc(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_vesca_main_proc
  static void rcqcDspVescaMainProc(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_vesca_rfmbtn_func
  static void rcqcDspVescaRfmbtnFunc(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_vesca_select_proc
  static void rcqcDspVescaSelectProc(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_sptend_vesca_check
  static int rcqcDspSptendVescaCheck(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_not_nimoca_confirm_yes_no_end
  static void rcqcDspNotNimocaConfirmYesNoEnd(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_cleate_nimoca_cancel_yes_no
  static void rcqcDspCleateNimocaCancelYesNo(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_cleate_not_nimoca_confirm_yes_no
  static void rcqcDspCleateNotNimocaConfirmYesNo(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_nimoca_yes_no_end
  static void rcqcDspNimocaYesNoEnd(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcqc_dsp_cleate_nimoca_yes_no
  static void rcqcDspCleateNimocaYesNo(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_dsp.c -rcQC_WAON_ReadErrDisp
  static void rcQCWAONReadErrDisp(){}

}

/// 関連tprxソース: rc_qcdsp.h - QCASHIER_INI
class QCashierIni {
  // short			item_disp;
  // short			logo_typ;
  // short			disp_typ;
  // short			spdsp_use;
  // short			fix_max;
  // short			fix_typ;
  // short			ptn_max;
  // short			ptn_typ;
  // short			sp_typ;
  // short			chara_typ;
  // short			language_typ;
  // short			page_max;
  int typ_max = 0;
  // short			pay_typ1;
  // short			pay_typ2;
  // short			pay_typ3;
  // short			pay_typ4;
  // short			pay_typ5;
  // short			pay_typ6;
  // short			pay_typ7;
  // short			pay_typ8;
  // short			demo_disp_btn;
  // short			rcpt_limit_time;
  // short			next_rcpt_limit;
  // short			auto_susdsp;
  // short			susdsp_time;
  // short			spr_str;
  // short			spr_end;
  // short			sum_str;
  // short			sum_end;
  // short			aut_str;
  // short			aut_end;
  // short			win1_str;
  // short			win1_end;
  // short			win2_str;
  // short			win2_end;
  // short			sp1_str;
  // short			sp1_flg;
  // short			sp2_flg;
  // short			sp3_flg;
  // short			sp4_flg;
  // short			sp5_flg;
  // short			sp6_flg;
  // short			sp7_flg;
  // short			sp8_flg;
  // short			sp9_flg;
  // short			sp10_flg;
  // short			sp11_flg;
  // short			sp12_flg;
  // short			sp13_flg;
  // short			sp14_flg;
  // short			sp15_flg;
  // short			sp16_flg;
  // short			sp17_flg;
  // short			sp18_flg;
  // short			sp1_end;
  // short			sp2_str;
  // short			sp2_end;
  // short			sp3_str;
  // short			sp3_end;
  // short			sp4_str;
  // short			sp4_end;
  // short			sp5_str;
  // short			sp5_end;
  // short			sp6_str;
  // short			sp6_end;
  // short			sp7_str;
  // short			sp7_end;
  // short			sp8_str;
  // short			sp8_end;
  // short			sp9_str;
  // short			sp9_end;
  // short			sp10_str;
  // short			sp10_end;
  // short			sp11_str;
  // short			sp11_end;
  // short			sp12_str;
  // short			sp12_end;
  // short			sp13_str;
  // short			sp13_end;
  // short			sp14_str;
  // short			sp14_end;
  // short			sp15_str;
  // short			sp15_end;
  // short			sp16_str;
  // short			sp16_end;
  // short			sp17_str;
  // short			sp17_end;
  // short			sp18_str;
  // short			sp18_end;
  // short			spr_time1;
  // short			spr_time2;
  // short			sum_time1;
  // short			sum_time2;
  // short			aut_time1;
  // short			aut_time2;
  // short			win_time1;
  // short			win_time2;
  int chg_info = 0;

  // short			chg_5000;
  // short			chg_2000;
  // short			chg_1000;
  // short			chg_500;
  // short			chg_100;
  // short			chg_50;
  // short			chg_10;
  // short			chg_5;
  // short			chg_1;
  // short			chg_info_full_chk;
  // short			chg_signp_full_chk;
  // short			rfm_receipt;
  // short			signp_typ;
  // short			ReadAlertTime;
  // short			AutoReadInterval;
  // short			select_typ;
  // short			select_str_msg;
  // short			InterruptPrint;
  // short			InterruptPay;
  // short			autocash_operation;
  // short			autocash_equaltime;
  // short			autocash_overtime;
  // short			TableReadInterval;
  // short			fip_disp;
  int crdtcard_gettimer = 0;
  // short			crdtcard_warntime;
  // short			UpdGetFtpTimer;
  var data = List.generate(RcQcDsp.qcashierIniMax, (_) => QcashierScrnIni());
  // char			charge_plucd1[13+1];
  // char			charge_plucd2[13+1];
  // char			charge_plucd3[13+1];
  // char			charge_plucd4[13+1];
  // char			charge_plucd5[13+1];
  // char			charge_plucd6[13+1];
  // short			acx_recalc_btn;
  int org_typ_max = 0;
  int lang_chg_max = 0;
  // short			lang_select1;
  // short			lang_select2;
  // short			lang_select3;
  // short			lang_select4;
  // short			lang_select5;
  // short			lang_select6;
  // short			lang_select7;
  // short			lang_select8;
  // short			autocrdt_operation;
  // short			autocrdt_time;
  // short			preca_charge_only;
  // char			preca_charge_plucd1[13+1];
  // char			preca_charge_plucd2[13+1];
  // char			preca_charge_plucd3[13+1];
  // char			preca_charge_plucd4[13+1];
  // char			preca_charge_plucd5[13+1];
  // char			preca_charge_plucd6[13+1];
  // short			cust_card_max;
  // short			cust_card_type1;
  // short			cust_card_type2;
  // short			cust_card_type3;
  // short			cust_card_type4;
  // short			cust_card_type5;
  // short			cust_card_type6;
  // short			select_dsp_ccin;
  // short			cancel_btn_dsp;
  // short			clinic_mode;
  // short			clinic_receipt;
  // short			clinic_greeting;
  // short			clinic_greeting_snd;
  // short			fin_btn_chg;
  // short			startdsp_btn_single;
  // short			startdsp_scan_enable;
  // short			pay_typ9;
  // short			pay_typ10;
  // short			pay_typ11;
  // short			pay_typ12;
  // short			pay_typ13;
  // short			pay_typ14;
  // short			pay_typ15;
  // short			pay_typ16;
  // short			verifone_nfc_crdt;
  // short			back_btn_dsp;
  int noOperationWarning = 0;
  int noOperationSignpaulTime = 0;
  // short			NoOperationVoicesound_time;
  // short			NoOperationSound;
  // short			NoOperationPayWarning;
  int cin_dsp_wait = 0;
  // long			shop_and_go_nonfile_plucd;
  // long			shop_and_go_nonscan_plucd;
  int shopAndGoLimit1 = 0;
  // long			shop_and_go_limit2;
  // long			shop_and_go_limit3;
  // short			shop_and_go_test_srv_flg;
  // long			shop_and_go_companycode;
  // long			shop_and_go_storecode;
  int shopAndGoMbrChkDsp = 0;
  // short			shop_and_go_server_timeout;
  // char			shop_and_go_proxy[46];
  // long			shop_and_go_proxy_port;
  // short			shop_and_go_n_money_btn_dsp;
  // char			shop_and_go_domain[46];
  int shop_and_go_mbr_card_dsp = 0;
  // char			shop_and_go_cr50_domain[46];
  // char			shop_and_go_point_domain[46];
  // short			clinic_auto_stl;
  // #if SS_CR2
  // short			use_nsw_receiptlogo;
  // #endif
  // long			shop_and_go_cr50_plucd;
  int acracbStlmode = 0;
  // char			apbf_regbag_plucd[13+1];
  // short			apbf_dlgdisp_time;
  // char			mybag_plu_point_add[13+1];
  // short			shop_and_go_eatin_dsp;
  // short			video_jpqr_scanner;		// コード決済ガイダンス動画（横客表）（0:ガン型 1:内蔵型）
  int shop_and_go_cogca_read_twice = 0;
  // short			shop_and_go_use_class;
  int shopAndGoExpensiveMarkPrn = 0;
  // short			shop_and_go_regbag_dsp;
  // long			shop_and_go_use_preset_grp_code;
  // short			shop_and_go_mente_nonplu_btn_reference;
  // long			shop_and_go_mbr_auto_cncl_time;
  int chgWarnTimerUse = 0;
  // short			cin_cnl_btn_show;
  // short			regs_use_class;			// 部門登録時の分類キー
  // short			sg_eatin_chk;
  // short			selfmode1_auto_cancel;
  // short			shop_and_go_rcpt_ttlnmbr_bold;  //買上点数の強調印字
  // short                   regbag1_default;
  // short                   regbag2_default;
  // short                   regbag3_default;
  // short			regbag_timing;
  // short			regbag_disp_back_btn;
  // long			point_use_unit;			// ﾎﾟｲﾝﾄ利用単位（点）
  // long			selfmode1_wav_qty;		// フルセルフモード 合計点数 音声読み上げ
  // short			verifone_nfc_repika_crdt; // Verifone端末でNFCレピカを利用
  // short			self_disp_preca_ref;		// プリカ残高照会ボタン表示
  // short			cashin_sound;			// 現金入金時に入金額を読み上げ（0:しない 1:する）
  // short			shop_and_go_apl_dl_qr_print;
  // short			shop_and_go_rcpt_msg_use_no;
  // short			shop_and_go_apl_dl_qr_print_normal;
  // short			shop_and_go_qr_print_chk_itmcnt_fs;
  // short			shop_and_go_qr_print_chk_itmcnt_ss;
  // short			fs_cashless_dsp_change;
  // short			sound_change_flg;			// 未精算時に再生する警告音を変更（0:しない 1:する）
  // short			hs_fs_auto_preset_dsp;
  // short			hs_fs_scanning_guide;
  // short			hs_fs_twice_read_stop;
  // short			age_chk_notice;
  // short			cashless_dsp_return;			// 現金対応ﾚｼﾞ案内画面\n表示時間(秒)
  // short			regbag_screen_scan_input;		// レジ袋登録方法 画面入力/スキャン入力
  // short			g3_pay_btn_blink;	//精算ボタン点滅表示（G3のみ）（0:しない 1:する）
  // short			g3_employee_call_btn;	//店員呼出ボタン表示（G3のみ）(0:しない 1:する)
  // short			g3_pay_slct_btn_ptn;	//会計レイアウト選択（G3のみ）(0:16個表示 1:均等表示)
  // short			video_jpqr_sidescanner;	// コード決済ガイダンス動画（縦客表）（0:内蔵型 1:横付（決済端末あり） 2:横付（決済端末なし））
  // short			mente_itemlist_type;	//メンテナンスの商品一覧10品表示 (0:しない 1:する)
  // short			rg_self_noteplu_perm;	//フルセルフ 金種商品の登録許可 (0:しない 1:する)
  // short			g3_self_itemlist_scrvoid;	//フルセルフ 商品登録画面で画面訂正する(G3縦型のみ) (0:しない 1:直前のみ 2:全て)
  // char			pay_grp_name1[128];	// 会計グループ１の名称
  // char			pay_grp_name2[128];	// 会計グループ２の名称
  // char			pay_grp_name3[128];	// 会計グループ３の名称
  // char			pay_grp_name4[128];	// 会計グループ４の名称
  // char			pay_grp_name5[128];	// 会計グループ５の名称
  // char			pay_grp_name6[128];	// 会計グループ６の名称
  // char			pay_grp_name7[128];	// 会計グループ７の名称
  // char			pay_grp_name8[128];	// 会計グループ８の名称
  // char			pay_grp_name9[128];	// 会計グループ９の名称
  // short			pay_typ1_grp;		// 会計方法１のグループ
  // short			pay_typ2_grp;		// 会計方法２のグループ
  // short			pay_typ3_grp;		// 会計方法３のグループ
  // short			pay_typ4_grp;		// 会計方法４のグループ
  // short			pay_typ5_grp;		// 会計方法５のグループ
  // short			pay_typ6_grp;		// 会計方法６のグループ
  // short			pay_typ7_grp;		// 会計方法７のグループ
  // short			pay_typ8_grp;		// 会計方法８のグループ
  // short			pay_typ9_grp;		// 会計方法９のグループ
  // short			pay_typ10_grp;		// 会計方法１０のグループ
  // short			pay_typ11_grp;		// 会計方法１１のグループ
  // short			pay_typ12_grp;		// 会計方法１２のグループ
  // short			pay_typ13_grp;		// 会計方法１３のグループ
  // short			pay_typ14_grp;		// 会計方法１４のグループ
  // short			pay_typ15_grp;		// 会計方法１５のグループ
  // short			pay_typ16_grp;		// 会計方法１６のグループ
  // char			pay_grp_name1_ex[128];	// 会計グループ１の英語名称
  // char			pay_grp_name2_ex[128];	// 会計グループ２の英語名称
  // char			pay_grp_name3_ex[128];	// 会計グループ３の英語名称
  // char			pay_grp_name4_ex[128];	// 会計グループ４の英語名称
  // char			pay_grp_name5_ex[128];	// 会計グループ５の英語名称
  // char			pay_grp_name6_ex[128];	// 会計グループ６の英語名称
  // char			pay_grp_name7_ex[128];	// 会計グループ７の英語名称
  // char			pay_grp_name8_ex[128];	// 会計グループ８の英語名称
  // char			pay_grp_name9_ex[128];	// 会計グループ９の英語名称
  // short			g3_fs_presetgroup_custom;
  // long			g3_fs_presetgroup_btn1;
  // long			g3_fs_presetgroup_btn2;
  // long			g3_fs_presetgroup_btn3;
  // long			g3_fs_presetgroup_btn4;
  // long			g3_fs_presetgroup_btn5;
  // long			g3_fs_presetgroup_btn6;
  // long			g3_fs_presetgroup_btn7;
  // long			g3_fs_presetgroup_btn8;
  // long			g3_fs_presetgroup_btn[8];
  // short			callBuzzer_sound_change_flg;	// 年齢確認商品の登録時に再生する音声を変更（0:しない 1:する）
  // short 			top_map_display;  			// G3フルセルフでマッピングを画面上部に表示(0:しない 1:する)
  // short			start_payselect_display; // G3フルセルフ登録開始で会計選択画面表示(0:しない 1:する)
  // short			idle_signp_state;	// 待機中サインポール点灯色選択 (0:緑(従来) 1:青 2:赤 3:黄 4:紫 5:水 6:白 7:消灯)
  // short			jpqr_paybtn_image;
  // short			vega_credit_forget_chk;
  // short			cash_only_setting;	// 会計額基準値超過時キャッシュレス決済禁止（0:しない 1:する）
  // long			cash_only_border; // キャッシュレス決済禁止基準額（円）
  int arcsPaymentMbrRead = 0;		// 後会員仕様（12Verから移植）
}

/// 関連tprxソース: rc_qcdsp.h - QCASHIER_SCRN_INI
class QcashierScrnIni {
  // char		title[128];
  // char		msg1[401];
  // char		msg2[401];
  // short		msg1_size;
  // short		msg2_size;
  // short		sound1;
  // short		sound2;
  // short		sound3;
  // short		snd_timer;
  // short		timer1;
  // short		timer2;
  int timer3 = 0;
  // short		dsp_flg1;
  // short		dsp_flg2;
  // short		movie01_ext;
  // short		movie02_ext;
  // short		movie03_ext;
  // short		movie04_ext;
  // char		line_title[128];
  // char		line_title_ex[128];
  // char		line1[128];
  // char		line2[128];
  // char		line3[128];
  // char		line4[128];
  // char		line1_ex[128];
  // char		line2_ex[128];
  // char		line3_ex[128];
  // char		line4_ex[128];
  // short		sound_led1;
  // short		sound_led2;
  // short		sound_led3;
  // GUIDE_MSG       guide_msg[4];
}

/// 関連tprxソース: rc_qcdsp.h - struct QC_MBRCHKDSP
class QCMbrChkDsp {
  /*
  GtkWidget	*window;
  GtkWidget	*fixed;
  GtkWidget	*pixmap;
  GtkWidget	*back_pixmap;
  GtkWidget	*tckt_pixmap;
  GtkWidget	*title_pixmap;
  GtkWidget	*title_lbl;
  GtkWidget	*menu_btn;
  GtkWidget	*lang_btn;
  GtkWidget	*lang_btn1;
  GtkWidget	*lang_btn2;
  GtkWidget	*lang_btn3;
  GtkWidget	*staff_btn;
  GtkWidget	*check_btn;
  GtkWidget	*back_btn;
  GtkWidget	*yes_btn;
  GtkWidget	*no_btn;
  GtkWidget	*lang_pixmap;
  GtkWidget	*lang_pixmap1;
  GtkWidget	*lang_pixmap2;
  GtkWidget	*lang_pixmap3;
  GtkWidget	*staff_pixmap;
  GtkWidget	*check_pixmap;
  GtkWidget	*back_btn_pixmap;
  GtkWidget	*balance_btn;
  GtkWidget	*balance_btn_pix;
  GtkWidget	*body_pixmap;
  GtkWidget	*mbrcogca_btn;
  GtkWidget	*mbrcrdt_btn;
  GtkWidget	*mbrslct1_btn;
  GtkWidget	*mbrslct2_btn;
  GtkWidget	*mbrslct3_btn;
  GtkWidget	*mbrslct4_btn;
  GtkWidget	*mbrslct1_btn_pix;
  GtkWidget	*mbrslct2_btn_pix;
  GtkWidget	*mbrslct3_btn_pix;
  GtkWidget	*mbrslct4_btn_pix;
  GtkWidget	*TR_frame;
  GtkWidget	*training_frame;
  GtkWidget	*title_lbl2;
  GtkWidget	*next_ok_pixmap;
  GtkWidget	*next_ng_pixmap;
  GtkWidget	*footer_pixmap;
  GtkWidget       *body_lbl[4];
  GtkWidget	*title_cashless;
   */
  int mbrslct1Cardtyp = 0;
  int mbrslct2Cardtyp = 0;
  int mbrslct3Cardtyp = 0;
  int mbrslct4Cardtyp = 0;
  int mbrcardReadtyp = 0;
}

/// 関連tprxソース: rc_qcdsp.h - struct  QC_STARTDSP
class QCStartDsp {
  /*
  GtkWidget *window;
  GtkWidget *fixed;
  GtkWidget *pixmap;
  GtkWidget *back_pixmap;
  GtkWidget *tckt_pixmap;
  GtkWidget *title_pixmap;
  GtkWidget *title_lbl;
  GtkWidget *menu_btn;
  GtkWidget *lang_btn;
  GtkWidget *lang_btn1;
  GtkWidget *lang_btn2;
  GtkWidget *lang_btn3;
  GtkWidget *staff_btn;
  GtkWidget *check_btn;
  GtkWidget *kiz_btn;
  GtkWidget *ptn_chg_btn;
  GtkWidget *season_chg_btn;
  GtkWidget *top_message;
  GtkWidget *mmdd_lbl;
  GtkWidget *hhmm_lbl;
  GtkWidget *time_pixmap;
  GtkWidget *lang_pixmap;
  GtkWidget *lang_pixmap1;
  GtkWidget *lang_pixmap2;
  GtkWidget *lang_pixmap3;
  GtkWidget *check_pixmap;
  GtkWidget *kiz_pixmap;
  GtkWidget *balance_btn;
  GtkWidget *balance_btn_pix;
  GtkWidget *chgtran_btn;
  GtkWidget *chgtran_btn_pix;
  GtkWidget *body_pixmap;
  GtkWidget *body_lbl[4];
  GtkWidget *charge_btn;
  GtkWidget *charge_btn_pix;
  GtkWidget *middle_line;
  GtkWidget *middle_word;
  GtkWidget *top_line;
  GtkWidget *top_word;
  GtkWidget *slct1_btn;
  GtkWidget *slct2_btn;
  GtkWidget *slct3_btn;
  GtkWidget *slct4_btn;
  GtkWidget *slct5_btn;
  GtkWidget *slct6_btn;
  GtkWidget *slct7_btn;
  GtkWidget *slct8_btn;
  GtkWidget *slct1_btn_pix;
  GtkWidget *slct2_btn_pix;
  GtkWidget *slct3_btn_pix;
  GtkWidget *slct4_btn_pix;
  GtkWidget *slct5_btn_pix;
  GtkWidget *slct6_btn_pix;
  GtkWidget *slct7_btn_pix;
  GtkWidget *slct8_btn_pix;
  GtkWidget *vesca_charge_guide;
  GtkWidget *preca_charge_btn;
  GtkWidget *preca_charge_btn_pix;
  GtkWidget *preca_charge2_btn;
  GtkWidget *preca_charge2_btn_pix;
  GtkWidget *slct9_btn;
  GtkWidget *slct10_btn;
  GtkWidget *slct11_btn;
  GtkWidget *slct12_btn;
  GtkWidget *slct13_btn;
  GtkWidget *slct14_btn;
  GtkWidget *slct15_btn;
  GtkWidget *slct16_btn;
  GtkWidget *slct9_btn_pix;
  GtkWidget *slct10_btn_pix;
  GtkWidget *slct11_btn_pix;
  GtkWidget *slct12_btn_pix;
  GtkWidget *slct13_btn_pix;
  GtkWidget *slct14_btn_pix;
  GtkWidget *slct15_btn_pix;
  GtkWidget *slct16_btn_pix;
  GtkWidget *back_btn;
  GtkWidget *back_btn_pix;
  GtkWidget *mbrinfo_pixmap;
  GtkWidget *training_frame;
  GtkWidget *half_window;
  GtkWidget *pop_pixmap;
  GtkWidget *preca_balance_title;
  GtkWidget *preca_balance_body;
  GtkWidget *preca_balance_amt;
  GtkWidget *cncl_btn;
  GtkWidget *staff_btn_pix;
  GtkWidget *TR_frame;
  GtkWidget *pop_lbl;
  GtkWidget *mark_pixmap;
  GtkWidget *title_cashless;
   */
  int startDspFlg = 0;
}

/// 関連tprxソース: rc_qcdsp.h - QC_CALLDSP
class QCCallDsp {
  /*
  GtkWidget	*window;
  GtkWidget	*fixed;
  GtkWidget	*pixmap;
  GtkWidget	*back_pixmap;
  GtkWidget	*yes_btn;
  GtkWidget	*no_btn;
  GtkWidget	*back_vfhd_pixmap;
   */
  int qcCallDsp = 0;
}

/// 関連tprxソース: rc_qcdsp.h - QC_PAY_INFO
class QCPayInfo {
  int exeFlg = 0;
  int sndDel = 0;
  int movDel = 0;
  int payDel = 0;
  int backDel = 0;
  int elmnyFlg = 0;
  int autoCnt = 0; //クレジット自動支払カウント
}

/// 関連tprxソース: rc_qcdsp.h - enum QC_SCREEN
enum QcScreen {
  QC_SCREEN_START,
  QC_SCREEN_WELCOM,
  QC_SCREEN_SLCT,
  QC_SCREEN_CASH,
  QC_SCREEN_PAY_CASH,
  QC_SCREEN_PAY_CASH_END,	/* 5 */
  QC_SCREEN_PAY_CASH_END0,
  QC_SCREEN_ITEM,
  QC_SCREEN_PAY_CRDT,
  QC_SCREEN_PAY_CRDT_END,
  QC_SCREEN_THANKYOU,		/* 10 */
  QC_SCREEN_CALL,
  QC_SCREEN_STAFF,
  QC_SCREEN_PASSWARD,
  QC_SCREEN_MENTE,
  QC_SCREEN_ITEM_CNCL,       /* 15 */
  QC_SCREEN_PAY_CRDTWAIT,
  QC_SCREEN_PAY_EDY,         /* 17 */
  QC_SCREEN_PAY_EDY_END,     /* 18 */
  QC_SCREEN_PAY_EDY_WAIT,    /* 19 */
  QC_SCREEN_EMNY_SLCT,       /* 20 */
  QC_SCREEN_EMNY_EDY,        /* 21 */
  QC_SCREEN_EMNY_EDY_END,    /* 22 */
  QC_SCREEN_CASH_RTURN,      /* 23 */
  QC_SCREEN_PAY_SUICA,       /* 24 */
  QC_SCREEN_PAY_SUICA_END,   /* 25 */
  QC_SCREEN_PAY_SUICA_WAIT,  /* 26 */
  QC_SCREEN_EMNY_SUICA,      /* 27 */
  QC_SCREEN_EMNY_SUICA_END,  /* 28 */
  QC_SCREEN_REGBAG,          /* 29 */
  QC_SCREEN_SELECT_CHANGE,   /* 30 */
  QC_SCREEN_CHARGE_ITEM,
  QC_SCREEN_NIMOCA_YESNO,
  QC_SCREEN_SUICA_CHARGE,
  QC_SCREEN_SUICA_CHARGE_START,
  QC_SCREEN_SUICA_CHARGE_YESNO, /* 35 */
  QC_SCREEN_PAYLACK_YESNO,
  QC_SCREEN_RECEIPT_SELECT,
  QC_SCREEN_SUICA_CHARGE_REDY,
  QC_SCREEN_PAY_SPTEND,
  QC_SCREEN_NOT_NIMOCA,		/* 40 */
  QC_SCREEN_TAKE_TCKT,		/* 41 */
  QC_SCREEN_PAY_VESCA_CRDT,
  QC_SCREEN_PAY_VESCA_EDY,
  QC_SCREEN_PAY_VESCA_ID,
  QC_SCREEN_PAY_VESCA_SUICA,
  QC_SCREEN_PAY_VESCA_QUICPAY,  /* 46 */
  QC_SCREEN_PAY_VESCA_WAON,
  QC_SCREEN_PAY_VESCA_NANACO,
  QC_SCREEN_PAY_VESCA_UNIONPAY,
  QC_SCREEN_PAY_VESCA_PRECA,
  QC_SCREEN_CHARGE_VESCA_EDY1,	/* 51 */
  QC_SCREEN_CHARGE_VESCA_EDY2,
  QC_SCREEN_CHARGE_VESCA_EDY3,
  QC_SCREEN_CHARGE_VESCA_SUICA1,
  QC_SCREEN_CHARGE_VESCA_SUICA2,
  QC_SCREEN_CHARGE_VESCA_SUICA3,/* 56 */
  QC_SCREEN_CHARGE_VESCA_WAON1,
  QC_SCREEN_CHARGE_VESCA_WAON2,
  QC_SCREEN_CHARGE_VESCA_WAON3,
  QC_SCREEN_CHARGE_VESCA_NANACO1,
  QC_SCREEN_CHARGE_VESCA_NANACO2,/* 61 */
  QC_SCREEN_CHARGE_VESCA_NANACO3,
  QC_SCREEN_CHARGE_VESCA_PRECA1,
  QC_SCREEN_CHARGE_VESCA_PRECA2,
  QC_SCREEN_CHARGE_VESCA_PRECA3,/* 65 */
  QC_SCREEN_LANG_SLCT,
  QC_SCREEN_STAFF_USE_NOW,
  QC_SCREEN_PRECACHARGE_PAY_END,
  QC_SCREEN_CHARGE_VESCA_END,
  QC_SCREEN_GREETING,	/* 70 */
  QC_SCREEN_MBR_CHK,
  QC_SCREEN_MBR_READ,
  QC_SCREEN_PAY_DPOINT_ENT,
  QC_SCREEN_PAY_DPOINT_WAIT,
  QC_SCREEN_PAY_DPOINT_END,	/* 75 */
  QC_SCREEN_BCDPAY_READ_LINEPAY,
  QC_SCREEN_BCDPAY_QR_ALIPAY,
  QC_SCREEN_BCDPAY_END,
  QC_SCREEN_BCDPAY_BAL_SHORT,
  QC_SCREEN_BCDPAY_QR_LINEPAY,	/* 80 */
  QC_SCREEN_BCDPAY_READ_ALIPAY,
  QC_SCREEN_BCDPAY_QR_WECHATPAY,
  QC_SCREEN_BCDPAY_READ_WECHATPAY,
  QC_SCREEN_BCDPAY_READ_BARCODE_PAY1,
  QC_SCREEN_BCDPAY_READ_CANALPAY,	/* 85 */
  QC_SCREEN_SAG_EATIN_ITEM,
  QC_SCREEN_PAY_PRECA,
  QC_SCREEN_PAY_PRECA_WAIT,
  QC_SCREEN_PAY_PRECA_END,
  QC_SCREEN_PAY_PRECA_ENT,	/* 90 */
  QC_SCREEN_PRECA_BAL_SHORT,
  QC_SCREEN_PAY_COGCAPNT_ENT,
  QC_SCREEN_PAY_COGCAPNT_WAIT,
  QC_SCREEN_PAY_COGCAPNT_END,
  QC_SCREEN_PAY_REPICAPNT_ENT,	/* 95 */
  QC_SCREEN_PAY_REPICAPNT_WAIT,
  QC_SCREEN_PAY_REPICAPNT_END,
  QC_SCREEN_EMPLOYEECARD_PAY_WAIT,
  QC_SCREEN_EMPLOYEECARD_PAY_END,
  QC_SCREEN_PAY_REPICAPNT_READ,	/* 100 */
  QC_SCREEN_SG_MBRSCAN,
  QC_SCREEN_SG_ITEMSCAN,
  QC_SCREEN_ANYCUSTCARD_SELECT,
  QC_SCREEN_VEGA_COGCA_CARDREAD_WAIT,
  QC_SCREEN_VEGA_MS_CARDREAD_WAIT,	/* 105 */
  QC_SCREEN_COGCAIC_CARDREAD_WAIT,
  QC_SCREEN_COGCA_CHARGE_CARDREAD_WAIT,
  QC_SCREEN_PRECACHARGE_ITEM,
  QC_SCREEN_PRECACHARGE_PAY,
  QC_SCREEN_PRECACHARGE_PAY_END_BACKWHITE,	/* 110 */
  QC_SCREEN_PRECA,
  QC_SCREEN_PRECA_END,
  QC_SCREEN_EMNY_PRECA,
  QC_SCREEN_EMNY_PRECA_END,
  QC_SCREEN_PAY_COGCAPNT_WAIT_2,
  QC_SCREEN_PAY_COGCAPNT_END_2,
  QC_SCREEN_PAY_COGCAPNT_ENT_2,
  QC_SCREEN_PASSCODE,		// 118
  QC_SCREEN_ID,
  QC_SCREEN_QP,
  QC_SCREEN_ID_END,
  QC_SCREEN_QP_END,
  QC_SCREEN_PAY_VESCA_CRDT_WAIT,
  QC_SCREEN_PAY_VESCA_CRDT_END,
  QC_SCREEN_RPOINT_MBRCHK_YESNO,	// 125
  QC_SCREEN_RPOINT_MBR_READ,
  QC_SCREEN_PAY_VESCA_PITAPA,
  QC_SCREEN_TOMO_CARDREAD_WAIT,		// カードを読ませてください画面	128
  QC_SCREEN_TOMO_PAY_STAFF,		// 友の会でお支払。店員操作中です画面	129
  QC_SCREEN_TOMO_PAY_WAIT,		// 友の会支払確認		130
  QC_SCREEN_TOMO_PAY_END,		// 友の会支払終了		131
  QC_SCREEN_STDCPN_SLCT,
  QC_SCREEN_STDCPN_READ,
  QC_SCREEN_PAY_RPOINTCONF,		// 楽天ポイント利用確認画面
  QC_SCREEN_BCDPAY_WAIT,
  QC_SCREEN_PAY_VESCA_EDY_RETRY,	// 136
  QC_SCREEN_PAY_VESCA_ID_RETRY,
  QC_SCREEN_PAY_VESCA_SUICA_RETRY,
  QC_SCREEN_PAY_VESCA_QUICPAY_RETRY,
  QC_SCREEN_PAY_VESCA_NANACO_RETRY,
  QC_SCREEN_PAY_VESCA_PITAPA_RETRY,
  QC_SCREEN_PAY_PANA_WAON_RETRY,
  QC_SCREEN_BCDPAY_READ_QUIZ,
  QC_SCREEN_NIMOCA_CANCEL_YESNO	/* 144 */

  /****************************************************************************************
   * SCREEN番号を新規追加する方へ
   * 同ファイルのQCASHIER_INI_MAXも変更してください。
   * /pj/tprx/src/sys/usetup/self/qcashier_setini.h のQCASHIER_INI_MAXも変更してください。
   * 新規追加はこのコメントの上に追加してください。
   ****************************************************************************************/

  // QC_SCREEN_MAX,		/* MAX */
  // QC_SCREEN_PART,
  // QC_SCREEN_VFHD_MENTE		/* 縦型21.5インチ対応 メンテ画面 */
}

/// 関連tprxソース: rc_qcdsp.h - enum QC_LED_NO
enum QcLedNo {
  QC_LED_ALL,
  QC_LED_CRDT,
  QC_LED_COININ,
  QC_LED_BILLIN,
  QC_LED_BILLOUT,
  QC_LED_COINOUT,
  QC_LED_SCAN,
  QC_LED_BILLCOIN_OFF,
  QC_LED_MAX
}

/// 関連tprxソース: rc_qcdsp.h - QC_LED_DISP
enum QcLedDisp {
  QC_LED_DISP_OFF,
  QC_LED_DISP_ON,
  QC_LED_DISP_BRINK,
}

/// 関連tprxソース: rc_qcdsp.h - QC_LED_COLOR
enum QcLedColor {
  QC_LED_OFF_COLOR,
  QC_LED_GREEN_COLOR,
  QC_LED_BLUE_COLOR,
  QC_LED_RED_COLOR,
  QC_LED_SUB1_COLOR,
  QC_LED_SUB2_COLOR,
  QC_LED_SUB3_COLOR,
  QC_LED_WHITE_COLOR,
}

/// 関連tprxソース: rc_qcdsp.h - QC_MBRDSP_STATUS
enum QcMbrDspStatus {
  QC_MBRDSP_STATUS_NON,
  QC_MBRDSP_STATUS_BEFORE_READ,
  QC_MBRDSP_STATUS_AFTER_SCAN,
}

/// 関連tprxソース: rc_qcdsp.h - QC_SOUND_TYP
class QcSoundTyp {
  static int QC_SOUND_TYP1 = 1;
  static int QC_SOUND_TYP2 = 2;
  static int QC_SOUND_TYP3 = 3;
  static int QC_SOUND_TYP91 = 91;
  static int QC_SOUND_TYP92 = 92;
}

/// 関連tprxソース: rc_qcdsp.h - QC_MBRSCAN_STATUS
enum QcMbrScanStatus {
  QC_MBRSCAN_WAIT(0), //会員カード 操作待ち
  QC_MBRSCAN_NOTHAVE(1), //会員カード 持っていない
  QC_MBRSCAN_DONE(2); //会員カード 読み込み済み

  final int id;

  const QcMbrScanStatus(this.id);
}

/// 関連tprxソース: rc_qcdsp.h - QC_LANG
enum QcLang {
  QC_LANG_JP,
  QC_LANG_EX,
  QC_LANG_CHN,
  QC_LANG_KOR,
  QC_LANG_FRA,
  QC_LANG_ITA,
  QC_LANG_DEU,
  QC_LANG_PRT,
}

/// 関連tprxソース: rc_qcdsp.h - QC_PAYDSP
class QcPayDsp {
	Object?	back_btn;
  Object?	backbtn_pixmap;
}

/// 関連tprxソース: rc_qcdsp.h - QC_LANG
enum QC_LANG {
  QC_LANG_JP,
  QC_LANG_EX,
  QC_LANG_CHN,
  QC_LANG_KOR,
  QC_LANG_FRA,
  QC_LANG_ITA,
  QC_LANG_DEU,
  QC_LANG_PRT,
}
