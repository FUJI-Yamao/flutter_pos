/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';

import '../../fb/fb_lib.dart';
import 'rcstllcd.dart';

/*-------------------------------------------------------------------
					New Preset
---------------------------------------------------------------------*/
const int PRESET_1PAGE_MAX         = 91;
const int STL_PRESET_1PAGE_MAX     = 12;
const int SUBSTL_PRESET_1PAGE_MAX  =  8;    /* 5.7LCD PRESET */
const int PAGE_START_NO            = 85;
const int PRESET_WIDTH             = 13;
const int PRESET_HEIGHT            =  7;
const int PRESET_PAGE_NUM          =  7;
const int COM_PRESET_1PAGE_MAX     =  7;


/// 関連tprxソース:Regs_Preset.h
class RegsPresetDef {
  static const RM3800_DSP = 0;    // RM-3800のUI 0：新タイプ(登録、小計を別画面)　1：旧タイプ(登録、小計を１画面)
}

///  関連tprxソース: Regs_Preset.h - RM59_WGT_DATA
class Rm59WgtData {
  int scalerm_stop_flg = 0;	// ADからの受信データを破棄する（非計量中） 1:A/Dデータを無視
  int scalerm_clr_dsp = 0;	// 計量エリアの値を空白表示 1:空白表示
  int fip_stop_flg = 0;		// カラー客表の更新停止 1:停止

  // 選択した商品情報
  // CMEM->working.plu_reg.t10000.pos_name
  // CMEM->working.plu_reg.t10003.uuse_prc
  // CMEM->working.plu_reg.t10000.act_nomi_in_prc;
  String pos_name = "";  //[301];		// 商品名
  int uuse_prc = 0;		// 単価(値下前)
  int uuse_prc2 = 0;		// 単価(値引後)
  int taxchg_uuse_prc = 0;	// 税変換後単価(値下前)
  int taxchg_uuse_prc2 = 0;	// 税変換後単価(値引後)
  int act_nomi_in_prc = 0;	// 値段(値下前)
  int act_nomi_in_prc2 = 0;	// 値段(値下後)
  int taxchg_act_nomi_in_prc = 0;	// 税変換後値段(値下前)
  int taxchg_act_nomi_in_prc2 = 0;// 税変換後値段(値下後)
  int act_nomi_in_prc_over = 0;	// 値段オーバー 0:範囲内 1:範囲外

  int scalerm_cnt = 0;		// 秤からの計量情報取得回数

  int zero_flg = 0;		// ZERO表示 0:非表示 1:表示
  int net_flg = 0;		// NET表示  0:非表示 1:表示

  int scalerm_fncsts = 0;		// 秤機能ステータス
  int enter_weight = 0;		// 確定重量
  int enter_prc = 0;		// 値段
  int FncCodebak = 0;		// FncCode 退避
  String entrybak = "";  //[10];		// Entry Data 退避
  int input_sts = 0;		// 入力中ステータス
  int inputbuf_dev = 0;		// 入力デバイス
  //List<int> Acode = List<int>.filled([MCD_CNT+/*GS1_CNT*/56], 0);     /* attend code */
  // 保持
  int Save_Flag = 0;		// 保持フラグ
  int Save_FncCode = 0;		// FncCode 退避
  //char    		Save_entry[10];		// Entry Data 退避


  int item_kind = 0;		// 商品種別
  int item_prc_chg_flg = 0;	// 単品の売価変更フラグ
  int wgt_bar_prc = 0;		// 重量バーコードの単品売価
  int weight_flg = 0;		// 商品種別
  int weight_dsp = 0;		// 点数/重量表示 0:点数 1:重量(計量商品、重量バーコード)
  int volume_dsp = 0;		// 体積表示 1:ml表示
  int bar_format_flg = 0;		// バーコードフォーマット

  int wgt_plu_flg = 0;		// 計量商品選択 0:未選択 1:計量商品選択 2:通常商品選択(フローティング) 3:通常商品選択(フローティング以外)
  int float_plu_add = 0;		// フローティングモード選択 0:未選択 1:商品選択 2:商品加算

  // ■重量入力
  int wgt_inp_flg = 0;		// 重量入力画面 0:非表示 1:表示中
  //RM59_WGT_INP_DATA	wgt_inp = 0;
  int wgt_inp_val = 0;

  // ■単価変更の為に追加した項目
  int prc_inp_flg = 0;		// 単価変更画面 0:非表示 1:表示中
  //RM59_PRC_INP_DATA	prc_inp = 0;		// 単価 値引/割引の入力
  int u_prc_flg = 0;		// 単価変更フラグ
  int			dsc_flg = 0;		// 値引/割引フラグ
  int			dsc_cd = 0;			// 値引キーコード
  int dsc_amt = 0;		// 値引額
  int			pdsc_cd = 0;		// 割引キーコード
  int pdsc_per = 0;		// 割引率

  // ■商品単価
  int pos_prc = 0;		// 商品マスタの一般売価

  // ■特売情報
  int brgn_cd = 0;		// 特売コード
  int brgn_typ = 0;		// 特売タイプ
  int brgn_prc = 0;		// 特売値下後単価
  int brgn_dsc_amt = 0;		// 特売値下後売価

  // ■分類一括
  int cls_svs_cncl = 0;		// 分類一括下の中止	1：中止
  int cls_svs_typ = 0;		// サービスタイプ
  int cls_dsc_val = 0;		// 値引値/割引率
  int cls_dsc_amt = 0;		// 値引額
  int cls_dsc_uprc = 0;		// 値引前の単価

  // ■金額入力の重量算出
  int calc_wgt_flg = 0;
  int calc_wgt = 0;

  // ■金額入力
  int inp_chgprc = 0;		// 金額入力値

  // ■税変換
  int tax_chg_ky_cd = 0;

  // ■税情報
  //TAX_INF			tax_inf = 0;		// 選択した税の情報

  // ■通常商品の点数
  int qty = 0;

  // ■プリセット風袋量（デジタル風袋にプリセット風袋を上書きする）
  int preset_tare_over_write_flg = 0;	// 風袋設定フラグ 0:未動作 1:風袋クリア 2:プリセット風袋量
  int			preset_tare_over_write_tare = 0;	// プリセット風袋量

  // ■体積商品
  int			spec_grav = 0;		// 体積商品の比重
  int			volume = 0;			// 体積商品の体積(ml)

  int			after_add_plu = 0;		// 商品加算状態 0:加算前 1:加算後

  // ■秤からの情報
  // C_BUF->scalerm_weight
  // C_BUF->scalerm_tare
  //char scalerm_weight[16];	// 重量(g)
  //char scalerm_tare[16];	// 風袋(g)
  //char scalerm_volume[16];	// 体積(ml)
  //#if RF1_SYSTEM
  // ■別添
  //char appendix[73];		// 別添
  //#endif	/* #if RF1_SYSTEM */

}

// GtkWidget型は省略
/// 関連tprxソース: Regs_Preset.h - struct Tran_Info
class TranInfo {
  /*
  PresetData	preset;				/* New Preset Data */
  MenubarData	Menubar;
   */
  MbrDispData	mbrParts = MbrDispData();
  /*
  Page_Info PageFixed[PRESET_PAGE_NUM];
  PresetInfo	PInfo[PRESET_1PAGE_MAX];
   */
  String itemCdtn = "";  /* Mul/Disc/Rep Display Area    */
  String itemName = "";  /* Name & Entry Display Area    */
  String itemPrc = "";  /* Price Display Area           */
  String itemQty = "";  /* Quantity Display Area        */
  String itemMark = "";  /* Item Mark Area               */
  String itemTtlPrc = "";  /* Total Price Display Area     */
  String itemTtlMrk = "";  /* Total Mark Display Area      */
  SubttlInfo itemSubTtl = SubttlInfo();
  String itemEntry = "";  /* Entry Display Area           */
  String offItemCdtn = "";
  String offItemName = "";
  String offItemPrc = "";
  String offItemEntry = "";
  String offItemMmEntry = "";
  /*
  Preset_Add_Info ky_chgstatus_info;
  Preset_Add_Info ky_langchgstatus_info;
  ModeFrameParts	modeFrameParts;
   */
  List<String> offMmCnt = List.filled(5, "");
  int rm59PrePageFlg = 0;  // プリセット頁、0:１～４頁 1:５～７頁
  String stlTtlEnt = "";  /* Sub Total Image & Price data */
  String stlTaxent = "";  /* Sub Total Tax Image & Price data */
  String stlTendEnt = "";  /* Sub Total Tend Image & Price data */
  String tendImg = "";  // お預かり、会計、品券	イメージ
  String stlTendChgEnt = "";  /* Sub Total Tend Change Image & Price Data */
  /*
  SP_TDATA	sp_tend[STL_DETAIL_TOTAL_MAX];	// スプリットの表示データ確保
   */
  String stlChgEnt = "";  /* Sub Total Change Image & Price Data */
  String stlQtyEnt = "";  /* Sub Total Qty Image & Piece data */
}

/*----------- New Preset Data -------------*/
/// 関連tprxソース: Regs_Preset.h - typedef struct PresetData
class PresetData {
  // GtkWidget	*note;				/* ノートウィジェット */
  // GtkWidget	*pgfix[PRESET_PAGE_NUM];		/* ページフィックスウィジェット */
  // GtkWidget	*pglabel[PRESET_PAGE_NUM];		/* ページタブラベル */
  int page = 0;					       /* 表示中のページ(0-6) */
  /* プリセットキーデータ */
  int btnmax = 0;					    /* 生成したプリセットボタンの数 */
  int prcFlg = 0;
  //GtkWidget	*button;				/* プリセットボタン */
  FBGroup group = FBGroup();  /* プリセットボタングループ */
  List<PresetInfo> data = List.generate(PRESET_1PAGE_MAX, (index) => PresetInfo()); // /* プリセットデータバッファ */
  List<PresetInfo> comdata = List.generate(COM_PRESET_1PAGE_MAX, (index) => PresetInfo());   /* COMMONプリセットデータバッファ */

  // RM-3800追加
  int rm59_PageChgFlg = 0;    /* プリセットの左右 0:右 1:左 */
  // GtkWidget *rm59_com_pix; /* プリセットボタンの上に乗せる下地画像 */
  // GtkWidget *rm59_com_btn_pix[COM_PRESET_1PAGE_MAX];	/* プリセット画像ボタン */
}