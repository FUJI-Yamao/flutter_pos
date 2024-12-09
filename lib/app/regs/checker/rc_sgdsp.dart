/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/if_signp.dart';

class RcSgDsp {
  /// 関連tprxソース:rc_sgdsp.h
  static const regLog = 0;
  static const quickIniMax = 45;
  static const ALL_COLOR = SignpColor.SIGNP_ALL;
  static const GREEN_COLOR = SignpColor.SIGNP_GREEN;
  static const RED_COLOR = SignpColor.SIGNP_RED;
  static const YELLOW_COLOR = SignpColor.SIGNP_YELLOW;
  static const GREEN_RED_COLOR = SignpColor.SIGNP_GREEN_RED;
  static const GREEN_YELLOW_COLOR = SignpColor.SIGNP_GREEN_YELLOW;
  static const YELLOW_RED_COLOR = SignpColor.SIGNP_YELLOW_RED;

  static const DCT_TIMER = 300000;
  static const REG_LOG = 0;
  static const ALART_LOG = 1;
  static const JDG_YES = 0;
  static const JDG_NO = 1;
  static const JDG_CONF = 2;
  static const JDG_CONTINUE = 3;
  static const JDG_INTERRUPT = 4;
  static const BZ_TIMER = 3000;
  static const SCL_ERR_TIMER = 30000;
  static const MODE_SELECT = 0;
  static const MODE_NOSELECT = 1;
  static const MANUAL_WRITE = 0;
  static const AUTO_WRITE = 1;

  static SgMem selfMem = SgMem();
  static SgMntDsp mntDsp = SgMntDsp();
  static SgRwRdDsp selfRWReadDsp = SgRwRdDsp();
  static SgRwRdDsp selfRWReadDsp2 = SgRwRdDsp();
  static SgSubDsp subDsp = SgSubDsp();
  static SgDualDsp dualDsp = SgDualDsp();
  static SgMbrScnDsp mbrScnDsp = SgMbrScnDsp();
  static SgMbrScnDsp2 mbrScnDsp2 = SgMbrScnDsp2();
  static SgMbrChkDsp mbrChkDsp = SgMbrChkDsp();
  static SgDptsMbrChkDsp dPtsMbrChkDsp = SgDptsMbrChkDsp();
  static SgRptsMbrChkDsp rPtsMbrChkDsp = SgRptsMbrChkDsp();
  static SgTomoMbrChkDsp tomoMbrChkDsp = SgTomoMbrChkDsp();
  static SgArcsVega arcsVegaChk = SgArcsVega();

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 関連tprxソース:rcsg_dsp.c - rcSG_DispWindow_Type
  static void rcSGDispWindowType() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 会員確認画面を表示する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_Disp_MemberCheckWindow
  static void rcSGDispMemberCheckWindow() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 会員確認画面を消去する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_MemberCheckWindow_Destroy
  static void rcSGMemberCheckWindowDestroy() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 会員スキャン画面を表示する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_Disp_MemberScanWindow
  static void rcSGDispMemberScanWindow() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 会員スキャン画面を消去する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_MemberScanWindow_Destroy
  static void rcSGMemberScanWindowDestroy() {}

  //実装は必要だがARKS対応では除外
  /// dポイント用会員カード確認画面を消去する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_dPointMemberCheckWindow_Destroy
  static void rcSGdPointMemberCheckWindowDestroy() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 楽天ポイント用会員カード確認画面を消去する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_RPointMemberCheckWindow_Destroy
  static void rcSGRPointMemberCheckWindowDestroy() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 指示画面を表示する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_Disp_InstructionWindow
  static void rcSGDispInstructionWindow() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 一覧画面を表示する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_Disp_ListWindow
  static void rcSGDispListWindow() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 一覧画面を消去する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_ListWindow_Destroy
  static void rcSGListWindowDestroy() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// プリセット画面を消去する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_PresetWindow_Destroy
  static void rcSGPresetWindowDestroy() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 戻るボタンを消去する
  /// 関連tprxソース:rcsg_dsp.c - rcSG_BackBtn_Destroy
  static void rcSGBackBtnDestroy() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 関連tprxソース:rcsg_dsp.c - rcSG_No_Act_Timer
  static void rcSGNoActTimer() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 関連tprxソース:rcsg_dsp.c - rcSG_Stl_EdyBtn_Timer
  static void rcSGStlEdyBtnTimer() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（サウンド関連）
  /// 関連tprxソース:rcsg_dsp.c - rcSG_SlctSound_Proc
  static void rcSGSlctSoundProc() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（サウンド関連）
  /// 関連tprxソース:rcsg_dsp.c - rcSG_BarSncSound_Proc
  static void rcSGBarSncSoundProc() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント関連）
  /// 会員カード読取画面での「戻る」ボタン押下時のメイン処理
  /// 関連tprxソース:rcsg_dsp.c - rcSG_MbrScanBack_Proc
  static void rcSGMbrScanBackProc() {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// [12ver:アークス様] スマホ読込画面処理
  /// 引数:[widget] コントローラーオブジェクト
  /// 引数:[data] 0=会員選択画面  1=商品登録画面
  /// 関連tprxソース:rcsg_dsp.c - rcSG_RalsBtn3_StartFunc
  static void rcSGRalsBtn3StartFunc(Object? widget, int data) {}

  // TODO:定義のみ追加
  /// 関連tprxソース:rcsg_dsp.c - rcSG_Dual_ReadCreditWindow
  static void rcSGDualReadCreditWindow() {}
}

// TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
/// 関連tprxソース:rc_sgdsp.h - enum SUB_CASH_ORDER
enum SUB_CASH_ORDER {
  SUB_NOTHING,
  SUB_READY,
  SUB_CASHSTART_IN,
  SUB_CASHSTART_LACK,
  SUB_CASHSTART_OK,
  SUB_CASHSTARTING,
  SUB_CASHEND,
  SUB_CASH_SELECT,
  SUB_CASHSTART_CRDT,
  SUB_CASHSTART_CARD,
  SUB_CRDT_RECOGN_NO,
  SUB_CASHRWRD,
  SUB_RWRD_NOW,
  SUB_RWRD_ERR
}

/// 関連tprxソース:rc_sgdsp.h - #define
class SgDsp {
  static const int REG_LOG = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_SUBDSP
class SgSubDsp {
  List<int> slcdCashDsp = List.filled(69, 0);
  List<int> slcdCashCom = List.filled(49, 0);
  List<int> slcdCashEnd = List.filled(77, 0);
  int subDisp = 0;
  int subdspErr = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_MNTDSP
class SgMntDsp {
  String sgMntent = "";  //[101];
  String sgMntprc = "";  //[47];
  int mntDsp = 0;
  int reWgtFlg = 0;
  int startbtnDsp = 0;
  int passWdFlg = 0;
  int sgCnclkyFlg = 0;
  int sgVoidkyFlg = 0;
  int sgCashkyFlg = 0;
  int pageNum = 0;
  int	sgDcmlFlg = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_MEM
class SgMem {
  int Staff_Call = 0;
  int bz_timer_end = 0;
  String sound_num = "";
  int mbr_call = 0;
  int exp_disp = 0;
  int bfr_sound = 0;
  int RW_mbr_input = 0;
  int minus_flg = 0;
  int auto_pdsc_flg = 0;
  int sg_catalina_flg = 0;
  int list_wav_flg = 0;
  int pre_wav_flg = 0;
  int nearend_empty_no = 0;
  int notzerochk_flg = 0;
  int preset_dsp = 0;
  int large_flg = 0;
  int p_weight = 0;
  int sg_sclerr_no = 0;
  int rfm_chk_flg = 0;
  int cash_cnclpass_flg = 0;
//#ifdef FB2GTK
  int select_type = 0;
  int item_type = 0;
  int cash_flg = 0;
  int call_btn = 0;
  int split_flg = 0;
  int prn_flg = 0;
  int cncl_flg = 0;
  int sg_edy_cancel_flg = 0;
  int sg_password_flg = 0;
  int sg_err_no_2nd = 0;
  int sg_edy_cancel_dlg = 0;
  int sg_trng_lbl = 0;
  int sg_edy_err_stat = 0;
  int sg_chk_staff_call = 0;
  int sg_one_mm_lm = 0;
  int sg_one_mm_bdl_itmno = 0;
  int modeselect_scan = 0;
  int qs_startdsp_scan = 0;
//#endif
  int nonbar_btn_start = 0;
  int sg_startbtn_push = 0;
  int qc_read_mem = 0;
  int happy_qc_func = 0;
  int QC_Staff_Call = 0;
  int staff_bar_read = 0; //従業員バーコードリードフラグ
  int sg_bag_set_flg = 0;
  int wgt_ten_chk = 0;
  int no_cash_dsp_flg = 0;
  int large_mnt_reg = 0;
  int sg_bag_scan_dsp_flg = 0;
  int sg_bag_dsp_flg = 0;
}

/// 関連tprxソース:rc_sgdsp.h - SG_DUALDSP
class DualDsp {
// GtkWidget *window;
// GtkWidget *fixed;
// GtkWidget *dual_pixmap;
  static int subttl_dsp_flg = 0;
  static int prnbtn_fnc_flg = 0;
  static int cncl_fnc_flg = 0;
  static int chgprc_dsp_flg = 0;
  static int dualdsp_err = 0;
  static int slct_btn_flg = 0;
  static int back_end_flg = 0;
  static int crdt_cncl_btn_flg = 0;
  static int recin_act_flg = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_RWRDDSP, struct SG_RWRDDSP2
class SgRwRdDsp {
  /*
  GtkWidget *window;
  GtkWidget *fixed;
  GtkWidget *pixmap;
  GtkWidget *back_btn;
  GtkWidget *back_fixed;
  GtkWidget *back_lbl;
  GtkWidget *mode_lbl;
  GtkWidget *callbtn;
  GtkWidget *sg_noncardbtn;
  GtkWidget *sg_readbtn;
   */
  int rwReadDisp = 0;
  int rwReadErr = 0;
  int rwCustFlg = 0;
  int rwErrFlg = 0;
  int rwErrCode = 0;
  int rwReadBtn = 0;
  int rwDlgDisp = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_MBRSCNDSP
class SgMbrScnDsp {
  /*
  GtkWidget *window;
  GtkWidget *fixed;
  GtkWidget *pixmap;
  GtkWidget *mnt_btn;
  GtkWidget *mode_lbl;
  GtkWidget *nocard_btn;
  GtkWidget *stf_btn;
   */
  int mbrscnDisp = 0;
  /*
  GtkWidget *edy_b_img;
  GtkWidget *edy_b_bal;
  GtkWidget *nocard_pix;
  GtkWidget *spj_list_pixmap;
  GtkWidget *spj_body_pixmap;
  GtkWidget *spj_body_label_L1;
  GtkWidget *spj_body_label_L2;
  GtkWidget *spj_body_label_M1;
  GtkWidget *spj_body_label_M2;
  GtkWidget *spj_body_label_M3;
  GtkWidget *spj_guide_pix;
  GtkWidget *spj_date_lbl;
  GtkWidget *spj_time_lbl;
  GtkWidget *spj_time_pix;
  GtkWidget *spj_call_pixmap;
  GtkWidget *lang_btn;
  GtkWidget *lang_btn1;
  GtkWidget *lang_btn2;
  GtkWidget *lang_btn3;
  GtkWidget *lang_pixmap;
  GtkWidget *lang_pixmap1;
  GtkWidget *lang_pixmap2;
  GtkWidget *lang_pixmap3;
   */
  int	mbrcardReadtyp = 0;
  int	bluechipReadtyp = 0;
  /*
  GtkWidget *training_frame;
  GtkWidget *standard_stepbar_pixmap;
   */
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_MBRSCNDSP2
class SgMbrScnDsp2 {
  //GtkWidget *window;
  //GtkWidget *fixed;
  //GtkWidget *pixmap;
  //GtkWidget *mnt_btn;
  //GtkWidget *mode_lbl;
  //GtkWidget *nocard_btn;
  //GtkWidget *call_btn;
  //GtkWidget *back_btn;
  //GtkWidget *back_fixed;
  //GtkWidget *back_lbl;
  int mbrscnDisp = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_MBRCHKDSP
class SgMbrChkDsp {
  /*
  GtkWidget *window;
  GtkWidget *fixed;
  GtkWidget *pixmap;
  GtkWidget *yes_btn;
  GtkWidget *yesfixed;
  GtkWidget *yes_lbl;
  GtkWidget *no_btn;
  GtkWidget *nofixed;
  GtkWidget *no_lbl;
  GtkWidget *cust_slct_btn[6];
  GtkWidget *mode_lbl;
  GtkWidget *stf_btn;
  GtkWidget *spj_yes_pixmap;
  GtkWidget *spj_no_pixmap;
  GtkWidget *spj_cust_slct_pixmap[6];
  GtkWidget *spj_body_pixmap;
  GtkWidget *spj_body_label_L1;
  GtkWidget *spj_body_label_M1;
  GtkWidget *spj_body_label_M2;
  GtkWidget *spj_body_label_M3;
  GtkWidget *spj_guide_pix;
  GtkWidget *spj_date_lbl;
  GtkWidget *spj_time_lbl;
  GtkWidget *spj_time_pix;
  GtkWidget *spj_call_pixmap;
  GtkWidget *lang_btn;
  GtkWidget *lang_btn1;
  GtkWidget *lang_btn2;
  GtkWidget *lang_btn3;
  GtkWidget *lang_pixmap;
  GtkWidget *lang_pixmap1;
  GtkWidget *lang_pixmap2;
  GtkWidget *lang_pixmap3;
  GtkWidget *cust_slct_lbl[3];
  GtkWidget *preca_ref_btn;
  GtkWidget *preca_ref_fixed;
  GtkWidget *preca_ref_lbl;
  GtkWidget *spj_preca_ref_pixmap;
  GtkWidget *training_frame;
  GtkWidget *nimoca_btn;
  GtkWidget *spj_nimoca_pixmap;
  GtkWidget *bal_btn;		// 友の会
  GtkWidget *bal_pixmap;	// 友の会
  GtkWidget *rpoint_mbr_btn;
  GtkWidget *spj_rpoint_mbr_pixmap;
  GtkWidget *standard_stepbar_pixmap;
   */
  int mbrchkDisp = 0;
  int mbrcardReadtyp = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_DPTSMBRCHKDSP
class SgDptsMbrChkDsp {
  /*
  GtkWidget	*window;
  GtkWidget	*fixed;
  GtkWidget	*pixmap;
  GtkWidget	*slct_btn[3];
  GtkWidget	*slct_btn_fixed[3];
  GtkWidget	*slct_btn_lbl[3];
  GtkWidget	*slct_btn_pixmap[3];
  GtkWidget	*cust_slct_btn[3];
  GtkWidget	*mode_lbl;
  GtkWidget	*stf_btn;
  GtkWidget	*spj_yes_pixmap;
  GtkWidget	*spj_no_pixmap;
  GtkWidget	*spj_slct_pixmap[3];
  GtkWidget	*spj_body_pixmap;
  GtkWidget	*spj_body_label_L1;
  GtkWidget	*spj_body_label_M1;
  GtkWidget	*spj_body_label_M2;
  GtkWidget	*spj_date_lbl;
  GtkWidget	*spj_time_lbl;
  GtkWidget	*spj_time_pix;
  GtkWidget	*spj_call_pixmap;
  GtkWidget	*lang_btn;
  GtkWidget	*lang_btn1;
  GtkWidget	*lang_btn2;
  GtkWidget	*lang_btn3;
  GtkWidget	*lang_pixmap;
  GtkWidget	*lang_pixmap1;
  GtkWidget	*lang_pixmap2;
  GtkWidget	*lang_pixmap3;
  GtkWidget	*cust_slct_lbl[3];
   */
  int mbrchkDisp = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_RPTSMBRCHKDSP
class SgRptsMbrChkDsp {
  /*
  GtkWidget	*window;
  GtkWidget	*fixed;
  GtkWidget	*pixmap;
  GtkWidget	*slct_btn[3];
  GtkWidget	*slct_btn_fixed[3];
  GtkWidget	*slct_btn_lbl[3];
  GtkWidget	*slct_btn_pixmap[3];
  GtkWidget	*cust_slct_btn[3];
  GtkWidget	*mode_lbl;
  GtkWidget	*stf_btn;
  GtkWidget	*spj_yes_pixmap;
  GtkWidget	*spj_no_pixmap;
  GtkWidget	*spj_slct_pixmap[3];
  GtkWidget	*spj_body_pixmap;
  GtkWidget	*spj_body_label_L1;
  GtkWidget	*spj_body_label_M1;
  GtkWidget	*spj_body_label_M2;
  GtkWidget	*spj_date_lbl;
  GtkWidget	*spj_time_lbl;
  GtkWidget	*spj_time_pix;
  GtkWidget	*spj_call_pixmap;
  GtkWidget	*lang_btn;
  GtkWidget	*lang_btn1;
  GtkWidget	*lang_btn2;
  GtkWidget	*lang_btn3;
  GtkWidget	*lang_pixmap;
  GtkWidget	*lang_pixmap1;
  GtkWidget	*lang_pixmap2;
  GtkWidget	*lang_pixmap3;
  GtkWidget	*cust_slct_lbl[3];
  GtkWidget	*training_frame;		/* 15.6インチ用 */
   */
  int mbrchkDisp = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct SG_TOMOMBRCHKDSP
class SgTomoMbrChkDsp {
  /*
  GtkWidget	*window;
  GtkWidget	*fixed;
  GtkWidget	*pixmap;
  GtkWidget	*slct_btn[3];
  GtkWidget	*slct_btn_fixed[3];
  GtkWidget	*slct_btn_lbl[3];
  GtkWidget	*slct_btn_pixmap[3];
  GtkWidget	*cust_slct_btn[3];
  GtkWidget	*mode_lbl;
  GtkWidget	*stf_btn;
  GtkWidget 	*balance_btn;
  GtkWidget	*spj_yes_pixmap;
  GtkWidget	*spj_no_pixmap;
  GtkWidget	*spj_slct_pixmap[3];
  GtkWidget	*spj_body_pixmap;
  GtkWidget	*spj_body_label_L1;
  GtkWidget	*spj_body_label_M1;
  GtkWidget	*spj_body_label_M2;
  GtkWidget	*spj_date_lbl;
  GtkWidget	*spj_time_lbl;
  GtkWidget	*spj_time_pix;
  GtkWidget	*spj_call_pixmap;
  GtkWidget	*balance_btn_pix;
  GtkWidget	*lang_btn;
  GtkWidget	*lang_btn1;
  GtkWidget	*lang_btn2;
  GtkWidget	*lang_btn3;
  GtkWidget	*lang_pixmap;
  GtkWidget	*lang_pixmap1;
  GtkWidget	*lang_pixmap2;
  GtkWidget	*lang_pixmap3;
  GtkWidget	*cust_slct_lbl[3];
  GtkWidget	*training_frame;		/* 15.6インチ用 */
   */
  int mbrchkDisp = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct NEWSG_EXPDSP
class NewSGExpDsp {
  /*
  GtkWidget *window;
  GtkWidget *fixed;
  GtkWidget *pixmap;
  GtkWidget *skip_btn;
  GtkWidget *pre_btn;
  GtkWidget *stf_btn;
  GtkWidget *mnt_btn;
  GtkWidget *mode_lbl;
  GtkWidget *large_btn;
  GtkWidget *pre_btn_pix;
   */
  int dspCnt = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct QUICK_INI
class QuickIni {
  String msg1 = "";
  String msg2 = "";
  int msg1Size = 0;
  int msg2Size = 0;
  int sound = 0;
  int sndTimer = 0;
  int edyTimer = 0;
  int dspTimer = 0;
  int cnclTimer = 0;
  int dspCntMax = 0;
  int cntTimer = 0;
  int sound2 = 0;
  int sound3 = 0;
}

/// 関連tprxソース:rc_sgdsp.h - struct QUICK_SG_INI
class QuickSgIni {
  int itemLines = 0;
  int scanSkip = 0;
  int pageMax = 0;
  String resetName = "";
  String refbtnName = "";
  int updateChkRetryCnt = 0;
  int updateChkRetryTime = 0;
  List<QuickIni> data = List.generate(RcSgDsp.quickIniMax, (_) => QuickIni());
}

/// 関連tprxソース:rc_sgdsp.h - SG_DUALDSP
class SgDualDsp {
// GtkWidget *window;
// GtkWidget *fixed;
// GtkWidget *dual_pixmap;
  int subttl_dsp_flg = 0;
  int prnbtn_fnc_flg = 0;
  int cncl_fnc_flg = 0;
  int chgprc_dsp_flg = 0;
  int dualdsp_err = 0;
  int slct_btn_flg = 0;
  int back_end_flg = 0;
  int crdt_cncl_btn_flg = 0;
  int recin_act_flg = 0;
}

/// 関連tprxソース:rc_sgdsp.h - SelfRWReadDsp2
class SelfRWReadDsp2 {
  // GtkWidget *window;
  // GtkWidget *fixed;
  // GtkWidget *pixmap;
  // GtkWidget *back_btn;
  // GtkWidget *back_fixed;
  // GtkWidget *back_lbl;
  // GtkWidget *mode_lbl;
  // GtkWidget *call_btn;
  // GtkWidget *sg_noncardbtn;
  // GtkWidget *sg_readbtn;
  static int RW_Read_disp = 0;
  static int RW_Read_err = 0;
  static int RW_Cust_flg = 0;
  static int RW_Err_flg = 0;
  static int RW_Err_code = 0;
  static int RW_Read_btn = 0;
  static int RW_Dlg_disp = 0;
}

/// 関連tprxソース:rc_sgdsp.h - StartDsp
class StartDsp {
  // GtkWidget *window;
  // GtkWidget *fixed;
  // GtkWidget *pixmap_s;
  // GtkWidget *start_btn;
  // GtkWidget *menu_btn;
  int sg_start = 0;
  int sg_restart = 0;
  int start_sound = 0;
  int crdt_start = 0;
}

/// 関連tprxソース:rc_sgdsp.h - enum MBRCARD_READTYPE
enum MbrCardReadType {
  NOT_READ,
  IC_READ,
  MS_READ,
  DPOINT_READ,
  RPOINT_READ,
  OTB_READ,
  TMOBILE_READ,
  OBR_READ,
  TOMO_READ,
  MCARD_READ,
}

/// ARCS_VEGA用パラメタ（12ver）
/// 関連tprxソース:rc_sgdsp.h - SG_ARCS_VEGA
class SgArcsVega {
  int arcsMbrRead = 0;
  int arcsPrecaIn = 0;
  int arcsMbrPrecaRef = 0;
  int arcsPrecaCardErr = 0;
  int arcsBtnCount = 0;
  int arcsMbrclrFlg = 0;
  int arcsHouseFlg = 0;
  int arcsHouseBakcBtnFlg = 0;
  int raraSelectFlg = 0;	// RARAスマホ会員選択分岐画面
  int selfRaraMbr = 0;	// フルセルフにて会員選択or商品登録からのスマホ読込画面判別
}

/// 関連tprxソース:rc_sgdsp.h - SG_MULDSP
class SgMulDsp {
// GtkWidget *window;
// GtkWidget *fixed1;
// GtkWidget *fixed2;
// GtkWidget *pbtnfixed;
// GtkWidget *ent1_btn;
// GtkWidget *ent2_btn;
// GtkWidget *ent3_btn;
// GtkWidget *ent4_btn;
// GtkWidget *ent5_btn;
// GtkWidget *ent6_btn;
// GtkWidget *ent7_btn;
// GtkWidget *ent8_btn;
// GtkWidget *ent9_btn;
// GtkWidget *ent0_btn;
// GtkWidget *ent00_btn;
// GtkWidget *qty_com;
// GtkWidget *qty_entry;
// GtkWidget *plu_label;
// GtkWidget *comment;
// GtkWidget *clr_btn;
// GtkWidget *plu_btn;
// GtkWidget *cncl_btn;
// GtkWidget *itmfixed;
// GtkWidget *namefixed;
// GtkWidget *prcfixed;
// GtkWidget *mulfixed;
// GtkWidget *nm_entry;
// GtkWidget *prc_entry;
// GtkWidget *dsc_entry;
// GtkWidget *mul_frame;
// GtkWidget *brgn_fixed;
// GtkWidget *mmsm_fixed;
// GtkWidget *brgn_frame;
// GtkWidget *mmsm_frame;
// GtkWidget *dsc_btn;
// GtkWidget *dsc2_btn;
// GtkWidget *dsc3_btn;
// GtkWidget *dsc4_btn;
// GtkWidget *dsc5_btn;
// GtkWidget *pdsc_btn;
// GtkWidget *pdsc2_btn;
// GtkWidget *pdsc3_btn;
// GtkWidget *pdsc4_btn;
// GtkWidget *pdsc5_btn;
// GtkWidget *xpm_backnum;
// GtkWidget *xpm_num1;
// GtkWidget *xpm_num2;
// GtkWidget *xpm_num3;
// GtkWidget *num_back1;
// GtkWidget *num_back2;
// #ifdef FB2GTK
// GtkWidget *stf_btn;
// GtkWidget *pixmap;
// GtkWidget *quit_pix;
// #endif
// GtkWidget *spj_itmmul_pix;
// GtkWidget *spj_preinp_pix;
// GtkWidget *spj_quit_pix;
// GtkWidget *spj_staff_pix;
// GtkWidget *spj_body_label_L1;
// GtkWidget *spj_body_label_L2;
// GtkWidget *spj_mulclr_label1;
// GtkWidget *spj_mulclr_label2;
// GtkWidget *spj_prc_img;
// GtkWidget *spj_qty_img;
// GtkWidget *spj_date_lbl;
// GtkWidget *spj_time_lbl;
// GtkWidget *spj_time_pix;
// GtkWidget *spj_cust_pixmap;
// GtkWidget *spj_cust_label;
  String name = ""; // Name & Entry Display Area [sizeof(((t_itemlog *)NULL)->t10000.pos_name)]
  String price = ""; // Price Display Area [53]
  String discount = ""; // Discount Display Area [77]
  String quantity = ""; // Quantity Display Area  [13]
  String pchg_ent = ""; // [101]
  String pchg_prc = ""; // [47]
  int mul_disp = 0;
  int pre_add_flg = 0;
  int prc_chg_flg = 0;
  int dsc_pdsc_flg = 0;
  int entry_num1 = 0;
  int entry_num2 = 0;
  int entry_num3 = 0;
  int pre_dsp_flg = 0;
// GtkWidget *lang_btn;
// GtkWidget *lang_btn1;
// GtkWidget *lang_btn2;
// GtkWidget *lang_btn3;
// GtkWidget *lang_pixmap;
// GtkWidget *lang_pixmap1;
// GtkWidget *lang_pixmap2;
// GtkWidget *lang_pixmap3;
// GtkWidget *plu_btn_pix;
// GtkWidget *clr_btn_pix;
// GtkWidget *spj_dscimg_pix;
// GtkWidget *dsc_lbl;
// GtkWidget *ky_btn_pix[10];
// GtkWidget *training_frame;
// GtkWidget *standard_stepbar_pixmap;
}
