/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/regs/checker/regs_preset_def.dart';

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import 'rcfncchk.dart';
import 'rcky_rfdopr.dart';
import 'rckymbre.dart';
import 'rcstllcd.dart';
import 'regs_preset_def.dart';

class Rc59dsp {
  static int rm59FloationgAddItem	= 0;	// フローティング加算状態  (rm59FloationgAddItem)
  static int rm59FloatingAutoStaffOpen = 0;  // フローティング従業員オープン 1:従業員999999オープン中

  /// 関連tprxソース: rc_59dsp.c - rm59_float_DepoInPlu_staff_cd
  static int rm59FloatDepoInPluStaffCd = 0;        // フローティング仕様時の貸瓶商品従業員コード
  /// 関連tprxソース: rc_59dsp.c - rm59_float_DepoInPlu_btl_id
  static int rm59FloatDepoInPluBtlId   = 0;	        // フローティング仕様時の貸瓶商品管理番号
  static int rm59DepoInPluMbrIn = 0;	// 貸瓶付き管理商品で会員入力で中断の判断

  static int rm59FloatingTimer = -1;	// フローティング件数タイマーハンドル
  static int rm59ScalermStlTimer = -1;	// フローティング件数タイマーハンドル
  static int rm59ScalermStlStaffTimer = -1;	// フローティング件数タイマーハンドル

  /// 関連tprxソース: rc_59dsp.c - rc59_ScaleRM_ScaleAreaClear
  static Future<void> rc59ScaleRmScaleAreaClear() async {
    return;
  }

  /// フローティング仕様　商品加算の状態
  /// 関連tprxソース: rc_59dsp.c - rc59_Floating_AddItem_Set
  static void  rc59FloatingAddItemSet(int AddItem) {
    rm59FloationgAddItem = AddItem;
  }

  /// 関連tprxソース: rc_59dsp.c - intrc59_InputStatusGet
  static intrc59_InputStatusGet() {
    return(Rm59WgtData().input_sts != 0);
  }

  /// 値数画面表示後、他の処理でエラーが発生した場合のエラー表示処理
  /// 関連tprxソース: rc_59dsp.c - rc59_Input_ErrDlgDsp
  static int rc59InputErrDlgDsp(int err_code, String? buff )
  {
    rc59_ScaleDlgDsp(err_code, buff);
    return(0);
  }

  /// 関連tprxソース: rc_59dsp.c - rc59_ScaleDlgDsp
  static void rc59_ScaleDlgDsp(int err_code, String? buff)
  {
    // TODO:10121 QUICPay、iD 202404実装対象外(エラー表示（ダイアログ）。一旦無視する)
    // tprDlgParam_t	param;
    // char		tmpbuf[256];
    // char		amt_flg;
    //
    // if ( ( cm_chk_rm5900_floating_system ( ) )
    // && ( rm59_staff_cd ) )
    // {
    // rm59_save_staff_cd = rm59_staff_cd;	// フローティング従業員保存
    // rm59_staff_cd = 0;	// フローティング従業員クリア
    // }
    //
    // // 金額入力ボタン判定
    // amt_flg = 0;
    // if ( ( err_code == MSG_SCALERM_WGT_20G_LESS )		// 20g未満の警告
    // && ( C_BUF->db_trm.less_20g_warn_enter_amount )	// 金額入力あり
    // && ( RM59_wgt.wgt_plu_flg == 1 )			// 計量商品選択中
    // //&& ( RM59_wgt.prc_inp.dsc_cd == 0 ) 			// 単価の値引が未実施
    // //&& ( RM59_wgt.prc_inp.pdsc_cd == 0 ) 		// 単価の割引が未実施
    // )
    // {
    // amt_flg = 1;
    // }
    //
    // if ( buff )
    // {
    // memset(tmpbuf, 0, sizeof(tmpbuf));
    // memcpy(tmpbuf, buff, strlen(buff));
    // }
    //
    // #if RF1_SYSTEM
    // rcErr_Stat_Set();
    // #endif	/* #if RF1_SYSTEM */
    //
    // memset(&param, 0x00, sizeof(tprDlgParam_t));
    // param.er_code    = err_code;
    // param.dialog_ptn = TPRDLG_PT1;
    // param.func1      =(void *)rc59_ScaleDlgclr;
    // param.msg1       = BTN_YES;
    //
    // // 金額入力ボタン表示
    // if ( amt_flg )
    // {
    // param.func2      =(void *)rc59_Enter_Amount;
    // param.msg2       = BTN_ENTER_AMOUNT;
    // }
    //
    // param.title      = BTN_CONF;
    // if ( buff )
    // {
    // //param.user_code_3    = tmpbuf;
    // param.msg_buf = (void *)tmpbuf;
    // }
    //
    // /* Call confirmation dialog library */
    // TprLibDlg(&param);
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_59dsp.c - rc59_Rct_OnOff_Reset
  static void rc59RctOnOffReset() {
    return;
  }

  ///	関数:	rc59_HalfWindow()
  ///	機能:	RM-5900の場合、画面の横幅が広いので網掛け
  /// 入力:  flag 0:網掛け解除 1:網掛け実施
  /// 関連tprxソース: rc_59dsp.c - rc59_HalfWindow
  static void rc59HalfWindow (int flag) {
    // TODO:00013 三浦 後回し2
    // rc59_HalfWindow_Size ( flag, WSVGA_XSIZ, WSVGA_YSIZ,  BlackGray );
  }

  ///	ソフトテンキーを破棄
  /// 関連tprxソース: rc_59dsp.c - rc59_HalfWindow
  static void rc59SKeyExitFnc() {
    // TODO:00013 三浦 後回し2
    // if(rm59_TenKeyWindow)
    // {
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "RM-5900 : rc59_SKeyExitFnc() ");
    // gtk_widget_destroy ( rm59_TenKeyWindow );
    // rm59_TenKeyWindow = NULL;
    // }
  }

  ///	フローティング仕様の自動従業員状態取得
  /// 戻り値: 0=未オープン  1=オープン中
  /// 関連tprxソース: rc_59dsp.c - rm59_Floating_Auto_Staff_Opne_Get
  static int rm59FloatingAutoStaffOpneGet() {
    int ret = 0;

    if (CmCksys.cmChkRm5900FloatingSystem() != 0) {
      ret = rm59FloatingAutoStaffOpen;
    }
    return (ret);
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rc_59dsp.c - rc59_scalerm_watch_stl
  static void rc59ScalermWatchStl () {
    return ;
  }

  /// TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_59dsp.c - rc59_Rct_OnOff_Dsp
  static void	rc59RctOnOffDsp(SubttlInfo subttl) {
  }

  /// TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc_59dsp.c - rc59_Floating_Preset_Refresh
  static void	rc59FloatingPresetRefresh() {
  }

  /// フローティング仕様の登録画面が表示中かチェックする
  /// 戻り値: 0=表示  1=表示中
  /// 関連tprxソース: rc_59dsp.c - rc59_Chk_Floating_Item_Screen
  static Future<int> rc59ChkFloatingItemScreen() async {
    if (CmCksys.cmChkRm5900FloatingSystem() != 0) {
      if (await RcFncChk.rcCheckItmMode()) {
        return 1;
      }
    }
    return 0;
  }

  /// フローティング仕様時の会員呼出で特定のエラーが発生した場合、会員取消を実行する
  /// 引数: エラーコード
  /// 関連tprxソース: rc_59dsp.c - rc59_floating_use_mbr_clear
  static Future<void> rc59FloatingUseMbrClear(int errNo) async {
    if ((errNo == DlgConfirmMsgKind.MSG_CUSTOTHUSE.dlgId) ||
        (errNo == DlgConfirmMsgKind.MSG_MBR_IS_IN_USE.dlgId)) {
      await RckyMbre.rcClr2ndMbrClr();
    }
  }

  /// フローティング仕様時の入力した会員がフローティングサーバに登録済みかを判定
  /// 引数: 会員コード
  /// 戻り値: エラーコード
  /// 関連tprxソース: rc_59dsp.c - rc59_floating_use_cust_check
  static int rc59FloatingUseCustCheck(String custNo) {
    int ret = 0;

    switch (Dummy.rcFloatingChkUseCust(custNo)) {
      case FlResult.FL_RESULT_SUCCESS: // 会員未登録の為、使用可能
        ret = FlResult.FL_RESULT_SUCCESS.value;
        break;

      case FlResult.FL_RESULT_USE_CUST: // 会員登録済み
        ret = DlgConfirmMsgKind.MSG_MBR_IS_IN_USE.dlgId; // "会員は使用中です。"
        break;

      default: // エラー
        ret = DlgConfirmMsgKind.MSG_FILEREADERR.dlgId; // "DB読込エラー"
        break;
    }
    return ret;
  }

  /// フローティング仕様時の貸瓶付き管理商品バーコードの貸瓶自動加算
  /// 戻り値: 0=顧客未入力  1=顧客入力済み
  /// 関連tprxソース: rc_59dsp.c - rc59_floating_depoinplu_chk
  static int rc59FloatingDepoinpluChk() {
    int ret = 0;
    int flg1 = 0;
    int flg2 = 0;
    int flg3 = 0;

    // フローティング仕様判定
    if (Dummy.rc59FloatingChkPLUSelect()) { // フローティング仕様で手動返品以外
      flg1 = 1;
    }

    // 中身ありデポジットで商品加算時の従業員コード保持済み
    if (rm59FloatDepoInPluStaffCd != 0) {
      flg2 = 1;
    }

    // デポジット管理番号入力済み
    if (rm59FloatDepoInPluBtlId != 0) {
      flg3 = 1;
    }

    // 全条件成立
    if (flg1 == 1 && flg2 == 1 && flg3 == 1) {
      ret = 1;
    }

    return ret;
  }

  /// フローティング仕様時の貸瓶付き管理商品バーコードの貸瓶時の会員入力
  /// 関連tprxソース: rc_59dsp.c - rc59_floating_depoinplu_mbr_input
  static void rc59FloatingDepoinpluMbrInput() {
    // TODO:10155 顧客呼出 実装対象外（RM3800フローティング仕様）
  }

  /// フローティング仕様時の貸瓶付き管理商品情報で管理/顧客の番号入力
  /// 引数: 0=管理番号及び顧客番号未入力  1=管理番号及び顧客番号入力中
  /// 関連tprxソース: rc_59dsp.c - rc59_depoinplu_mbr_input
  static void rc59DepoinpluMbrInput(int mbrInput) {
    rm59DepoInPluMbrIn = mbrInput;
  }

  /// 機能概要     : フローティングの加算情報更新終了
  /// 呼び出し方法 : rc59_floating_watch_timer_end ()
  /// パラメータ   : なし
  /// 戻り値       : 加算処理状態
  /// 関連tprxソース: rc_59dsp.c - rc59_floating_watch_timer_end
  static void rc59FloatingWatchTimerEnd() {
    if (rm59FloatingTimer != -1)
    {
      Fb2Gtk.gtkTimeoutRemove(rm59FloatingTimer);
      rm59FloatingTimer = -1;
    }
  }
}
