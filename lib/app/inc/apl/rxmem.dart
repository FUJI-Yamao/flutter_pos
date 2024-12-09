/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:rxmem.h
//  このファイルは上記ヘッダーファイルを元にdart化したものです。

// ************************************************************************
// File Name    : RXMEM.H
// ************************************************************************

import 'package:flutter_pos/app/inc/apl/rxmemcustreal2.dart';

import '../lib/if_acx.dart';
import 'compflag.dart';
import 'fnc_code.dart';
import 'image.dart';

///  関連tprxソース:rxmem.h - ヘッダーファイル内で#defineで定義されていた値とする。
class RxMem {

  // システム定義
  static const CHARCODE_BYTE = 4; // 現在の文字コードにおける, １文字を表現する最大のbyte数

  /* another 1 part */
  static const ANOTHER_MENTE       = "mente";
  static const ANOTHER_USETUP      = "usetup";
  static const ANOTHER_PMOD        = "pmod";
  static const ANOTHER_SALE_COM_MM = "sale_com_mm";
  static const ANOTHER_BATREPO_OUT = "batrepo";
  static const ANOTHER_HIST_GET    = "history_get";

  /* another 2 part */
  static const ANOTHER_TCOUNT      = "tcount";
  static const ANOTHER_FCON        = "fcon";
  static const ANOTHER_FREQ        = "freq";
  static const ANOTHER_REGCTRL     = "pmod_regctrl";
  static const ANOTHER_RETOTAL     = "retotal";
  static const ANOTHER_CUSTENQCLR  = "cust_enq_clr";
  static const ANOTHER_BATREPO     = "pmod_batrepo";


  /**********************************************************************
      最大値定義
   ***********************************************************************/

  /* c_trm_mst:regs_menu_dsp, set_menu_dsp, manage_menu_dsp */
  static const DB_TRM_MENU_MAX = 18;

  static const MS_CONNECT_MAX = 99;

  /**********************************************************************
      最大レコード数定義
   ***********************************************************************/
  static const DB_INSTRE_MAX = 99;		/* インストアマーキング */
  static const DB_TAX_MAX = 10;		/* 税金 */

  static int DB_IMG_MAX = (CompileFlag.FIP_DISP_EX? (
      (FuncKey.keyMax + ImageDefinitions.IMG_MAX) * 2):
      (FuncKey.keyMax + ImageDefinitions.IMG_MAX));

  static const DB_RECMSG_MAX = 31;		/* レシートメッセージ */
  static const DB_FIPMSG_MAX = 10;		/* FIPスクロールメッセージ */
  static const DB_COLORDSP_MAX = 10;		/* カラー客表メッセージ */

  static const PRESET_LCD57_MAX = 8;		/* 5.7インチLCD */
  static const PRESET_MKEY1_MAX = 56;		/* 本体メカキー */
  static const PRESET_MKEY2_MAX = 30;		/* タワーメカキー */
  static const PRESET_MKEY52_MAX = 52;		/* 52Keyタワーメカキー */
  static const PRESET_MKEY35_MAX = 35;		/* 35key本体メカキー */
  static const PRESET_MKEY35P_MAX = 35;		/* 35Pkey本体メカキー */
  static const PRESET_MKEY28i_MAX = 68;		/* Web2800i 本体メカキー */
  static const PRESET_MKEY28iM_MAX = 84;		/* Web2800iM 本体メカキー */
  //static const PRESET_MKEY_MAX = PRESET_MKEY28i_MAX;
  static const PRESET_MKEY_MAX = PRESET_MKEY28iM_MAX;
  static const FTP_MAX = 2;

  static const KEYTYPE_84 = 1;
  static const KEYTYPE_68 = 2;
  static const KEYTYPE_56 = 3;
  static const KEYTYPE_30 = 4;
  static const KEYTYPE_52 = 5;
  static const KEYTYPE_35 = 6;
  static const KEYTYPE_35P = 7;
  static const KEYTYPE_56_23 = 13;
  static const KEYTYPE_30_23 = 14;

  static const TPOINT_TBL = 50000;	/* Tポイント仕様 */


}


  /**********************************************************************
      子タスク指示定義
   ***********************************************************************/
  /// メッセージマスタインデックス
  ///   関連tprxソース:rxmem.h　enum DB_MSGMST_IDX
  enum DbMsgmstIdx {
    DB_MSGMST_RCPTHEADER1(1),		/* レシートヘッダー1 100 */
    DB_MSGMST_RCPTHEADER2(2),		/* レシートヘッダー2 101*/
    DB_MSGMST_RCPTHEADER3(3),		/* レシートヘッダー3 102*/
    DB_MSGMST_RCPTFOOTER1(4),		/* レシートフッター1 200*/
    DB_MSGMST_RCPTFOOTER2(5),		/* レシートフッター2 */
    DB_MSGMST_RCPTFOOTER3(6),		/* レシートフッター3 */
    DB_MSGMST_GRNTHEADER1(7),		/* 保証書ヘッダー1 */
    DB_MSGMST_GRNTHEADER2(8),		/* 保証書ヘッダー2 */
    DB_MSGMST_SVCHEADER1(9),		/* サービスチケットヘッダー1 */
    DB_MSGMST_SVCHEADER2(10),		/* サービスチケットヘッダー2 */
    DB_MSGMST_SVCFOOTER1(11),		/* サービスチケットフッター1 */
    DB_MSGMST_SVCFOOTER2(12),		/* サービスチケットフッター2 */
    DB_MSGMST_BUYTCKT1(13),		/* 買上チケット1 */
    DB_MSGMST_BUYTCKT2(14),		/* 買上チケット2 */
    DB_MSGMST_REWRITECM1(15),		/* リライトカードCM1 */
    DB_MSGMST_REWRITECM2(16),		/* リライトカードCM2 */
    DB_MSGMST_NOTETCKT1(17),		/* 金券チケット1 */
    DB_MSGMST_NOTETCKT2(18),		/* 金券チケット2 */
    DB_MSGMST_CHGTCKT1(19),		/* 釣銭チケット1 */
    DB_MSGMST_CHGTCKT2(20),		/* 釣銭チケット2 */
    DB_MSGMST_HESOTCKT1(21),		/* へそくりチケット1 */
    DB_MSGMST_HESOTCKT2(22),		/* へそくりチケット2 */
    DB_MSGMST_RPRTHEADER(23),		/* レポートヘッダー */
    DB_MSGMST_RSRVFOOTER1(24),		/* 予約レシートフッター1 */
    DB_MSGMST_RSRVFOOTER2(25),		/* 予約レシートフッター2 */
    DB_MSGMST_QCSELECTSTART(26),		/* QC指定専用時のスタートメッセージ */
    DB_MSGMST_CUSTOFFLINE(27),		/* オフライン顧客印字 */
    DB_MSGMST_CUSTLOCK(28),		/* ロック中顧客印字 */
    DB_MSGMST_PORTAL_CONF1(29),		/* ポータル認証印字1 */
    DB_MSGMST_PORTAL_CONF2(30),		/* ポータル認証印字2 */
    DB_MSGMST_PORTAL_CONF3(31),		/* ポータル認証印字3 */
    DB_MSGMST_RFM_ISSUEINFO(32),		/* 領収書発行者情報 */
    DB_MSGMST_QCTICKETFOOTER(33),		/* お会計券フッター */
    DB_MSGMST_QCTICKETCHANGEFOOTER(34),	/* お会計券おつりフッター */
    DB_MSGMST_QCTICKETLOGO(35),		/* お会計券ロゴ */
    DB_MSGMST_SPECIAL1(36),		/* 特注メッセージ印字用1 */
    DB_MSGMST_SPECIAL2(37),		/* 特注メッセージ印字用2 */
    DB_MSGMST_SPECIAL3(38),		/* 特注メッセージ印字用3 */
    DB_MSGMST_SPECIAL4(39),		/* 特注メッセージ印字用4 */
    DB_MSGMST_SPECIAL5(40),		/* 特注メッセージ印字用5 */
    DB_MSGMST_INOUTHEADER(41),		/* 入出金レシートヘッダー */
    DB_MSGMST_CUSTLAY1(42),		/* 客層キー1での印字 */
    DB_MSGMST_CUSTLAY2(43),		/*    〃   2での印字 */
    DB_MSGMST_CUSTLAY3(44),		/*    〃   3での印字 */
    DB_MSGMST_CUSTLAY4(45),		/*    〃   4での印字 */
    DB_MSGMST_CUSTLAY5(46),		/*    〃   5での印字 */
    DB_MSGMST_CUSTLAY6(47),		/*    〃   6での印字 */
    DB_MSGMST_CUSTLAY7(48),		/*    〃   7での印字 */
    DB_MSGMST_CUSTLAY8(49),		/*    〃   8での印字 */
    DB_MSGMST_CUSTLAY9(50),		/*    〃   9での印字 */
    DB_MSGMST_CUSTLAY10(51),		/*    〃   10での印字 */
    DB_MSGMST_COPY_ERR_ATTEND(52),		/* 開設画面でマスタ取得が失敗した時のエラー印字 */
    DB_MSGMST_CERTHEADER(53),		/* 販売証明書ヘッダー */
    DB_MSGMST_TAXFREE_OFFICE(54),		/* 免税所轄税務署 */
    DB_MSGMST_TAXFREE_PLACE(55),		/* 免税納税地 */
    DB_MSGMST_TAXFREE_SELLER(56),		/* 免税販売者氏名 */
    DB_MSGMST_TAXFREE_SELLINGPLACE(57),	/* 免税販売場所在地 */
    DB_MSGMST_CLASS1_MSG(58),		/* 第1類ﾒｯｾｰｼﾞ */
    DB_MSGMST_HORIZONTAL_TCKT_MSG(59),	/* 横型ﾁｹｯﾄﾒｯｾｰｼﾞ */
    DB_MSGMST_SAG_QR_DL_PRINT(60),
    DB_MSGMST_RCPT_MAIL_HEADER(61),	/* レシート電子メール本文ヘッダ */
    DB_MSGMST_RCPT_MAIL_FOOTER(62),	/* レシート電子メール本文フッター */
    DB_MSGMST_TPOINT1(63),		/* Tﾎﾟｲﾝﾄﾒｯｾｰｼﾞ1 */
    DB_MSGMST_TPOINT2(64),		/* Tﾎﾟｲﾝﾄﾒｯｾｰｼﾞ2 */
    DB_MSGMST_TPOINT3(65),		/* Tﾎﾟｲﾝﾄﾒｯｾｰｼﾞ3 */
    DB_MSGMST_TCOUPON(66),		/* Tｸｰﾎﾟﾝﾒｯｾｰｼﾞ */
    DB_MSGMST_TMONEY(67),		/* Tﾏﾈｰﾒｯｾｰｼﾞ */
    DB_MSGMST_MBRSCAN_GUIDE	(68),		/* 	対面客側顧客読取(案内) */
    DB_MSGMST_MBRSCAN_REJECT(69),		/* 	対面客側顧客読取(拒否) */
    DB_MSGMST_MBRSCAN_INPUT	(70);		/* 	対面客側顧客読取(入力) */

    /// 今定義されているFuncKeyの中の最大値+1の値を返す.
    static int get DB_MSGMST_MAX => DbMsgmstIdx.values.last.keyId + 1;
    final int keyId;
    const DbMsgmstIdx(this.keyId);
  }

   ///   関連tprxソース:rxmem.h　enum DB_MSGMST_FIP_IDX
  enum DbMsgmstfipIdx{
    DB_MSGMST_FIP1(0),			/* FIP1 */
    DB_MSGMST_FIP2(1),				/* FIP2 */
    DB_MSGMST_FIP3(2),				/* FIP3 */
    DB_MSGMST_FIP4(3),				/* FIP4 */
    DB_MSGMST_FIP5(4),				/* FIP5 */
    DB_MSGMST_FIP6(5),				/* FIP6 */
    DB_MSGMST_FIP7(6),				/* FIP7 */
    DB_MSGMST_FIP8(7),				/* FIP8 */
    DB_MSGMST_FIP9(8),				/* FIP9 */
    DB_MSGMST_FIP10(9);			/* FIP10 */

    /// 今定義されているFuncKeyの中の最大値+1の値を返す.
    static int get DB_MSGMST_FIP_MAX => DbMsgmstfipIdx.values.last.keyId + 1;
    final int keyId;
    const DbMsgmstfipIdx(this.keyId);
  }

// typedef enum {
// DB_MSGMST_COLORDSP1 = 0,		/* COLORFIP1 */
// DB_MSGMST_COLORDSP2,			/* COLORFIP2 */
// DB_MSGMST_COLORDSP3,			/* COLORFIP3 */
// DB_MSGMST_COLORDSP4,			/* COLORFIP4 */
// DB_MSGMST_COLORDSP5,			/* COLORFIP5 */
// DB_MSGMST_COLORDSP6,			/* COLORFIP6 */
// DB_MSGMST_COLORDSP7,			/* COLORFIP7 */
// DB_MSGMST_COLORDSP8,			/* COLORFIP8 */
// DB_MSGMST_COLORDSP9,			/* COLORFIP9 */
// DB_MSGMST_COLORDSP10,			/* COLORFIP10 */
// DB_MSGMST_COLORDSP_MAX
// } DB_MSGMST_COLORDSP_IDX;
//
// // メッセージ種別リスト
// typedef	enum
// {
// DB_MSGMST_KIND_MSG = 0,			// 印字メッセージ
// DB_MSGMST_KIND_BMP = 1,			// ビットマップ名称
// DB_MSGMST_KIND_URL = 2,			// URL
// DB_MSGMST_KIND_BARCODE = 3,		// バーコード
// DB_MSGMST_KIND_FIP_REST = 4,		// 静止FIP
// DB_MSGMST_KIND_FIP_TIME = 5,		// 時刻FIP
// DB_MSGMST_KIND_FIP_ACT = 6,		// スクロールFIP
// DB_MSGMST_KIND_URL_CUST_PLUS = 7,	// URL+ 会員番号+ パスワード
// DB_MSGMST_KIND_RESERVE_LIST = 8,	// 予約時の対象印字リスト
//
// DB_MSGMST_KIND_COLORDSP_REST = 10,	// 静止(カラー客表)
// DB_MSGMST_KIND_COLORDSP_TIME = 11,	// 時刻(カラー客表)
// DB_MSGMST_KIND_COLORDSP_ACT = 12,	// スクロール(カラー客表)
// DB_MSGMST_KIND_COLORDSP_FLASH = 13,	// 点滅(カラー客表)
// DB_MSGMST_KIND_COLORDSP_PICT = 14,	// 画像(カラー客表)
// DB_MSGMST_KIND_COLORDSP_PICT_REST = 15,	// 画像+メッセージ(カラー客表)
// } DB_MSGMST_KIND_IDX;
//
//
// /**********************************************************************
//     共有メモリ共通定義
//  ***********************************************************************/
//
// /*-----  デバイス情報共通構造体  -----*/
// typedef struct {
// int		dev_id;							/* デバイス番号 */
// int		stat;							/* 状態 */
// char	data[sizeof(tprmsgdevreq2_t)];	/* データ */
// char	filler[1];
// char	adon_cd[5];                     /* adon code */
// char	itf_amt[9];                     /* ITF Barcode */
// #if    SALELMT_BAR
// char	salelmt[8];                     /* Sale Limit Disc Barcode */
// #endif
// int	bar_cd_len;			/* Scannr Input Code Length */
// char	bar_data[28];                   /* Special Disc Barcode(18degit) */
// short	bcd_seq_no;			// バーコード段数
// } RX_DEV_INF;
//
//
// /**********************************************************************
//     イメージデータ構造定義
//  ***********************************************************************/
//
// #define DB_IMG_DATASIZE 300
// #define OLD_DB_IMG_DATASIZE 32
//
// typedef struct {
// long	img_cd[DB_IMG_MAX];
// char	img_data[DB_IMG_MAX][DB_IMG_DATASIZE];
// } RX_IMG;
//
//
// /**********************************************************************
//     Connection data
//  ***********************************************************************/
//
// #define CONNECTDB_MAX	11
//
// typedef struct {
// PGconn	*con;
// int	pid;
// } RX_CONNECTDB;
//
// /**********************************************************************
//     default mechakey data
//  ***********************************************************************/
//
// #define MKEYNUM_MAX	35
//
// typedef struct {
// uchar	hi_kcd;
// uchar	lo_kcd;
// char	num[6];
// } MKEYNUMTBL;
//
// /**********************************************************************
//     simple 2staff data
//  ***********************************************************************/
// #if SIMPLE_2STAFF /* 2004.01.13 */
// typedef struct {
// int	person_flag;		/* 1:one person / 2:two person */
// int	cashier_end;		/* 0:normal / 1:cashier stop */
// int	twoperson_key_flag;
// int	fnc_code;
// int	update_exec;
// } RX_SIMPLE2STF;
// #endif
//
// typedef struct
// {
// short  presetcolor;          /* preset color */
// char   ky_name[600];          /* preset key name */
// } FB_MKEY;
//
// typedef	struct
// {
// FB_MKEY		PreMK_Info[PRESET_MKEY_MAX];
// short  		key_max;	/* キー数　*/
// short		row;		/* 行　*/
// short		line;		/* 列  */
// int		softkeyno[8];
// }MKEY_INFO;
//
// /**********************************************************************
//     マルチ端末（アークス様）
//  ***********************************************************************/
//
// #define	TCCUTS_TID_LEN	13
// typedef struct {
// char	QP_tid[TCCUTS_TID_LEN + 1];
// char	iD_tid[TCCUTS_TID_LEN + 1];
// char    Suica_tid[TCCUTS_TID_LEN + 1];
// char    Edy_tid[TCCUTS_TID_LEN + 1];
// } RX_TCCUTS_INI;
//
// /**********************************************************************
//     抽選仕様
//  ***********************************************************************/
//
// typedef struct {
// long	lottery_assist_amt;		/* 抽選補助点金額	*/
// int	lottery_assist_cnt;		/* 補助回数		*/
// } RX_LOTTERY_INI;
//
/**********************************************************************
    Printer Font File Descripter
 ***********************************************************************/
///  関連tprxソース:rxmem.h　enum PRN_FONT_IDX
enum PrnFontIdx {
  E24_16_1_1(0),
  E24_24_1_1(1),
  E24_24_1_2(2),
  E24_24_2_1(3),
  E24_24_2_2(4),
  E24_48_1_1(5),
  E16_16_1_1(6),
  E16_16_2_2(7),
  E16_24_1_1(8);

  static int get PrnFontIdxMax => PrnFontIdx.values.last.id + 1;
  final int id;
  const PrnFontIdx(this.id);
}

// typedef enum {
// STAFF_INFO_CASHIER = 0,
// STAFF_INFO_CHECKER,
// STAFF_INFO_LOGIN,
// STAFF_INFO_MAX
// } STAFF_INFO_IDX;
//
// typedef struct {
// long long	staff_cd;
// char		name[sizeof(((c_staff_mst *)NULL)->name)];
// short		auth_lvl;
// } STAFF_INFO;
//
// #if 0
// typedef struct {
// pid_t	pid;
// int	handle;
// int	num;
// } tPrnFontInf;
// #define	PRN_FONT_INF_MAX	30
// #endif
//
// /**********************************************************************
//     VEGA3000 端末
//  ***********************************************************************/
// typedef struct {
// /* VEGA3000 接続先設定 */
// int		SvFlag;			// 内部処理用フラグ：サブサーバの有無フラグ
// int		SwFlag;			// 内部処理用フラグ：サブサーバへ切り替え中フラグ
// char		Address[16];		// 接続先サーバIP
// char		AddressSub[16];		// 接続先サブサーバIP
// unsigned int	Port;			// 接続先サーバPort
// unsigned int	PortSub;		// 接続先サブサーバPort
// unsigned int	RecvTimeOut;		// 電文受信待ち時間(sec)
// unsigned int	ConnTimeOut;		// コネクション取得待ち時間(sec)
// int		RetryCount;		// コネクションリトライ回数[*********未使用***************]
// int		LogFlag;		// ログ出力判定フラグ
// char		LogFilePath[128];	// ログ出力先フォルダ：指定無の場合カレントフォルダに出力
// int		LogSaveDate;		// ログ保存日数：0指定の場合無制限
// int		DevFlag;		// 開発用 DLL内部折返しフラグ
// int		TrainingModeFlag;	// トレーニングモードフラグ[POS連動用]
// char		ComNo[24];		// シリアルポート名：Windowsの場合"COM1"等、Linuxの場合"/dev/ttyS1"等[POS連動用]
// /* VEGA3000 接続先設定ここまで */
// short		vega3000_cancel_flg;	/* VEGA3000 キャンセル通知フラグ */
// } RX_VEGA3000_CONF;
//
// typedef struct {
// t_110000	strcls_ttl;
// short		strcls_cnt;
// long		cpick_amt;		//精算時釣機回収金額
// long		cpick_res_amt;		//精算時釣機回収残置金額
// int		pick_sht[10];		//精算時回収枚数（売上回収＋釣機回収）
// } STRCLS_INFO;
//
// typedef struct {
// short	rmst_freq;		//開設自動リクエストフラグ
// short	freq_res;		//　
// short	rmst_freq_retry;	//リクエスト再実行フラグ　
// }FREQ_INFO;
//
//
// #if SMART_SELF_SPEEDUP
// typedef enum
// {
// SMART_SELF_BKUP_BACKGROUND = 0,
// SMART_SELF_BKUP_LIST3,
// SMART_SELF_BKUP_ITEM,
// SMART_SELF_BKUP_TOTAL,
// SMART_SELF_BKUP_MAX,
// } SMART_SELF_BKUP_NUM;
// #endif
//
// /**********************************************************************
//     Lane5000
//  ***********************************************************************/
// typedef struct
// {
// char	amount[20];		// 金額
// char	a_no[10];		// 承認番号
// char	card_co[70];		// カード会社名（日本語の為、x3済み）
// char	card_no[30];		// カード番号
// char	date[20];		// ご利用日
// //	char	exp_date[10];		// 有効期限
// char	merchant_name[80];	// 加盟店名（日本語の為、x3済み）
// char	pay_division[40];	// 支払区分（日本語の為、x3済み）
// char	product_division[10];	// 商品区分
// char	receipt_1[40];		// 控えタイトル１（日本語の為、x3済み）
// char	receipt_2[40];		// 控えタイトル２（日本語の為、x3済み）
// char	receipt_3[40];		// 控えタイトル３（日本語の為、x3済み）
// char	receipt_4[40];		// 控えタイトル４（日本語の為、x3済み）
// char	org_slip_no[10];	// 元伝票番号
// char	slip_no[10];		// 伝票番号
// char	tax[16];		// 税その他
// char	term_no[20];		// 端末番号
// char	title[100];		// クレ：伝票タイトル　交通系：取引種別（日本語の為、x3済み）
// char	total_yen[16];		// 合計金額
// char	trade[50];		// 取引区分名称（日本語の為、x3済み）
// char	sprwid[16];		// SPRWID
// char	uniqueid[20];		// ユニークID
// char	sid[16];		// 決済ID
// char	tran_type[40];		// 取引種別
// char	rem_amount[10];		// 交通系IC利用後残額
// char	b_rem_amount[10];	// 交通系IC利用前残額
// char	merchant_telno[80];	// 加盟店電話番号
// } RX_LANE_INFO;
//
// /**********************************************************************
//     実績上げフラグ
//  ***********************************************************************/
// typedef	enum
// {
// DB_STOP_FLG_RUN = 0,		// 0:実績上げ可能
// DB_STOP_FLG_WAIT,		// 1:実績上げ抑止中
// DB_STOP_FLG_RETOTAL,		// 2:実績上げ：実績再集計
// DB_STOP_FLG_RETOTAL_PAST,	// 3:実績上げ：実績再集計（過去）
//
// } DB_STOP_FLG;
//
// /**********************************************************************
//     共通メモリ定義(RM-3800 フローティング)
//  ***********************************************************************/
// typedef struct {
// long long	FloatingStaffCd;		// フローティング加算従業員
// int		FloatingOpeModeFlg;		// フローティング オペモード
// long		FloatingStlAmt;			// フローティング加算金額
// long		FloatingStlQty;			// フローティング加算点数
// } RX_FLOATING_DAT;
//
// /**********************************************************************
//     共通メモリ定義(共有メモリ)
//  ***********************************************************************/
//
// /* 共通メモリ構造定義 */
// typedef struct {
// RX_CTRL Ctrl;
// c_stre_mst		db_stre;
// c_comp_mst		db_comp;
// trm_list		db_trm;		// ターミナルマスタ
// ctrl_buff		db_ctrl;	// 共通コントロール
// reginfo_buff		db_regctrl;	// レジ情報データ
// keyfnc_buff		db_kfnc[MAX_FKEY+1];	// キーデータ
// c_openclose_mst	db_openclose;
// c_staffopen_mst	db_staffopen;
// c_instre_mst	db_instre[DB_INSTRE_MAX];
// c_tax_mst		db_tax[DB_TAX_MAX];
// trmplan_buff		db_trmplan[TRMPLAN_MAX];	// ターミナル企画番号
// int				img_max;
// RX_IMG			Img;
// RX_COUNTER		ini_counter;
// RX_MACINFO		ini_macinfo;
// RX_SYSPARAM		ini_sysparam;
// #ifndef FB2GTK
// INFO_BTN_COLOR	ini_dspcolor;
// #endif
// SYS				ini_sys;
// SCPU			ini_scpu;
// int				offline;
// int				powerfail;
// char                            int_flag;
// char                            offmode_flag;   /* OFF_MODE */
// int                             recogkey_read_flg;
// RX_CONNECTDB	connectdb_info[CONNECTDB_MAX];
// int				bs_offline;
// int				custrev_offline;	// 顧客(予約)サーバー用
// long            reg_add_fsp_cd;
// long            reg_redu_fsp_cd;
// int		sims_csv_flg[3];
// int		csv_server_flg;
// long long       save_staff_cd;
// int		sg_sclcncl_flg;
// int		sg_scl2stop_flg;
// char   vmc_chg_acv;                        /* Change Achievement Flag      */
// char   vmc_heso_acv;                       /* Hesokuri Achievement Flag    */
// char   vmc_chg_req;                        /* Change Display Flag          */
// char   vmc_heso_req;                       /* Hesokuri Display Flag        */
// int		now_ment_mode;
// int		now_ftp_use;
// int		another_layer;
// int		download_mode;
// MKEYNUMTBL	mkeyNumTbl[MKEYNUM_MAX];
// int		sg_item_reg;
// int		sg_sclchk_flg;
// int		mobile_flag;         /* for Mobile POS */
// char            chkcash_off_flag;
// #if MC_SYSTEM
// c_mcspec_mst	db_mcspec;
// c_mcnega_tbl	db_mcnega;
// //        uchar           seq_pos_no[20];
// //        uchar           seq_onetime_no[20];
// //        uchar           seq_cardcash_no[20];
// //        uchar           seq_nocardcash_no[20];
// //        uchar           seq_cardfee_no[20];
// //        int             mc_stat;
// //        int             mc_kind;
// #endif
// char            offmode_exit_flag;   /* OFF_MODE */
// #ifdef FB2GTK
// short		dual;
// char		scrmsg_flg;
// char		movie_flg;		/* 0:none 1:order */
// char		movie_kind;		/* 0:none 1:execution 2:pause 3:size change 4:stop */
// short		movie_order;	/* movie file No. not 0:select  9999:select all  */
// short		movie_x_offset;	/* movie x offset */
// short		movie_y_offset;	/* movie y offset */
// short		movie_w_size;	/* movie width */
// short		movie_h_size;	/* movie height */
// char		movie_exec;		/* infomation mplayer 0:stop 1:execution */
// char		movie_frame_flg;/* display of frame 0:no 1:yes */
// short           dev_id;
// #endif
// #if SIMPLE_2STAFF  /* 2004.01.13 */
// RX_SIMPLE2STF	stf2;
// #endif
// short		fip_control[3];
// int			batch_rpt_flag;
// short		esvoid_proc_flg;
// #ifdef FB2GTK
// short		fb_memo_errno;
// #endif
// short		quick_flg;		/* quick setup 0:no running 1:running */
// short		quick_proc;		/* process 0:no running 1:running */
// short		quick_btn;		/* quick setup 0:returnbtn 1:nextbtn */
// char		sys_dual[4];	/* sys.ini save dual for quick setup finit */
// char		sys_webjr[4];	/* sys.ini save webjr for quick setup finit */
// char		sys_tower[4];	/* sys.ini save tower for quick setup finit */
// char		sys_webplus[4];	/* sys.ini save dual for quick setup finit */
// char		sys_web2300[4];	/* sys.ini save dual for quick setup finit */
// char            kymenu_up_flg;
// c_report_cnt	db_report_cnt;
// char		outside_rbt_flg;
// char		revenue_exclusion;
// #if NEW_TRANS
// char		db_stop_flg;
// char		mupdS_flg;
// char		mupdC0_flg;
// char		mupdC1_flg;
// char		mupdC2_flg;
// #endif
// //	tPrnFontInf	prnInf[PRN_FONT_INF_MAX];
// RX_SOUNDINI	ini_sound;
// short		mbrcd_len;		/* member code length */
// char		mente_flg;
// int		cust_offline;
// char		update_flg;
// char		upd_err_continue_flg;
// short		voidupdate_flg;
// short		edy_seterr_flg;
// short		edy_exist_flg;
// #if TW
// //	short		tckt_only;		/* サービスチケットのみ印字フラグ（台湾用） */
// #endif
// short		sg_suica_flg;
// short		suica_retry_flg;
// short		suica_cncl_retry_flg;
// short		suica_cncl_mode;
// short		magcd_len;
// int		qs_at_flg;
// short		suica_time_set;
// char		connect_msg[128];
// char		iccard_pass_flg;
// int		qs_report_flg;
// #if DRUG_REVISION
// int		drugrev_control_flg;
// char		drugrev_data[26+1];
// #endif
// #if IC_CONNECT
// RX_ICC		icc;
// #endif
// int		posinfo_flg;
// int             ftp_start;
// int		pbchg_flg;
// int             duty_start;             /*     勤怠開始(コメリ様)  */
// int             login_start;            /*     扱者登録開始(コメリ様) */
// int		sound_num;
// int		sound2_num;
// short		sound_type;		/* 0:aplay 1:new sndlib 2:old sndlib  */
// int             ftp_order[FTP_MAX];
// int             ftp_result[FTP_MAX];
// long            ftp_f_size[FTP_MAX];
// RXMEMMBRREAL	ini_mbrreal;
// long			rcky_displist_preset_grp_cd;	/* 画面一覧で選択したページ番号 */
// char		my_customercard_bar[18+1];
// MKEY_INFO	PreMK;
// short  		signp_ctrl_cnt;
// int		ftp_prepid;
// short		usbcam_stat;	/* usbcam recording stat */
// short		usbcam_dev_stat;	/* usbcam device stat */
// short		sims_mente_copy;	// マルチセグメント仕様でのコピー対応のため  0:動作なし  1:動作中
// short		auto_stropncls_run;	/* 自動開閉設仕様の動作中 0:動作なし 1:開店処理中 2:閉店処理中 */
// RX_TCCUTS_INI	ini_multi;	//　マルチ端末用
// short		qcjc_stat;			/* QCashierJC動作 0:動作なし 1:動作中 */
// short		qcjc_c;
// short		qcjc_c_print;
// RX_COUNTER		ini_counter_JC_C;	/* QCJC カウンター(WebSpeezaC) */
// RX_MACINFO_JC_C	ini_macinfo_JC_C;	/* QCJC 周辺装置(WebSpeezaC)  */
// char			recog_qcjc[RECOG_PAGE_MAX][RECOG_FUNC_MAX];	/* QCJC 承認キー選択 */
// char	cust_tel_prn;		/* 会員の電話番号印字 0:しない 1:する */
// short		qcjc_c_mntprn;
// short		auto_errstat;	/* キャッシュマネジメント自動精算送信エラーMsg送信*/
// short		manul_strcls;	/* 単体キャッシュマネジメント自動精算送信*/
// short           printer_near_end;
// short		side_flag;
// short		qcjc_c_except;
// short           printer_near_end_JC_C;
// long		suica_timeout1;		/* Suica引去り待ちタイムアウト */
// long		suica_timeout2;		/* Suica処理未了タイムアウト */
// int		OptWindowType;	/* 0:800x600   1:800x480 */
// char		add_tpanel_connect;	/* additional touch panel connected */
// short		mkey_d;
// short		mkey_t;
// short		Alarm_flg;
// short		suica_cncl_flg;
// short		suica_lack_flg;
// short		suica_ope_mode;		/* 1:引去 2:取消 3:残額照会 4:ﾁｬｰｼﾞ 5:ﾁｬｰｼﾞ取消 */
// short           qcjc_voidmode_flg;
// long		fsp_cust_last_amt;	/* FSP前月対象額 */
// RX_LOTTERY_INI	ini_lottery;		/* 抽選仕様 */
// short		kitchen_prn1_run;	/* キッチンプリンタ接続仕様 */
// short		kitchen_prn2_run;
// int		kitchen_prn1;		// pid格納
// int		kitchen_prn2;		// pid格納
// short		iccard_dev_stat;	/* 2015/02/02 */
// short		qcjc_frcclk_chg;
// msg_mst_data	db_recmsg[DB_MSGMST_MAX];	// レシート印字用
// msg_mst_data	db_fipmsg[DB_MSGMST_FIP_MAX];	// FIP用
// msg_mst_data	db_colordspmsg[DB_MSGMST_COLORDSP_MAX];	// カラー客表用
// STAFF_INFO	Staff_Info[STAFF_INFO_MAX];
// //	rfm_mst_data	rfmMst[RFM_NO_MAX];
// stropncls_buff	db_stropncls;
// STRCLS_INFO	strcls_info;
// FREQ_INFO	rmst_info;
// short		auto_strcls_errend;	/* 自動閉設のエラー中断フラグ */
// short		auto_strcls_stopchk;	/* 自動精算アシストモニター返答済みフラグ*/
// short		force_stre_cls_flg;	/* 自動強制閉設フラグ
// 							0x01:強制閉設実行中
// 							0x02:アシストモニターからの精算指示
// 							0x04:Checkerメッセージ表示
// 							0x08:Cashierメッセージ表示
// 							0x10:登録メッセージ削除
// 							0x20:登録メッセージ表示指示
// 							0x40:強制閉設実施済み
// 						*/
// short		colordsp_msg_flg;	/* カラー客表のメッセージ表示フラグ */
// int		pbchg_mstrcv;           /* 収納代行マスタダウンロード結果 */
// cashrecycle_buff	db_cashrecycle;	//キャッシュリサイクル
// int		renew_mem_semid;		// 履歴ログを受け, 共有メモリを更新する際のセマフォ識別子
// short		memo_read_flg;		// 常駐メモフラグ
// short		tmemo_read_flg;		// 連絡メモフラグ
// short		Acxinfo_stop;		// 釣銭情報停止フラグ
// short		memodsp_flg;		// 常駐、連絡メモ画面表示中フラグ
// #if SMART_SELF
// short		fullself_dual;		// HappySelf用 FullSelf時に店員側、客側ともに同一の画面を出す場合のフラグ
// short		colordsp_ctrl_flg;	// セルフ切り替え中に、カラー客表の表示を更新させない為の制御フラグ
// short		colordsp_ctrl_flg2;	// 登録以外での客側表示を操作できるようにしたモード中は、カラー客表の表示を更新させない為の制御フラグ
// short		click_ctrl_flg;		// メインメニューにて左上を押下した場合に、3回押下してカラー客表側が操作出来るようにするための回数フラグ
// short		fullself_dual_save;	// HappySelf用 ミラー表示フラグ”fullself_dual”の待避用フラグ
// #if SMART_SELF_SPEEDUP
// char		colordsp_bg_file_name[SMART_SELF_BKUP_MAX][256];	/* HappySelf用の背景画像ファイル名(FBへ通知用) */
// #endif
// #endif
// short		addscan_flg;		/* 3rdスキャナ制御フラグ 0:卓上側として処理 or 1:タワー側として処理 */
// RX_VEGA3000_CONF	vega3000_conf;	/* VEGA3000関連設定値 */
// char		frc_clk_flg_cpy;	/* 【HappySelf】簡易従業員設定値保存用 */
// short		wiz_self_chg;		/* WizSelf切替状態かどうかのフラグ */
// short           termInfodsp_flg;        // 端末情報 表示中フラグ
// short           waveSeldsp_flg;         // 音選択 表示中フラグ
// short		legalInfdsp_flg;	// 法的情報表示中フラグ
// int		recog_clr_status;	/* 承認キークリアキーのステータス */
// short		colordsp_play_flg;	/* カラー客表表示中フラグ */
// int		colordsp_pid;		/* カラー客表プロセスID */
// TPRDID		sound_mouseTid;		// マウスタッチ時のTIDを保持([音の設定]で利用)
// int		chgstatus_st_flg;	/* 釣機状態ラベルの状態フラグ 0:正常 1:釣切れ 2:釣不足 3:釣過剰 */
// int		chgstatus_update_flg;	/* Checker登録画面用 釣機状態ラベル更新フラグ 0:更新しない 1:更新する */
// int		only_optwin_disp_flg;	/* HappySelf フルセルフ／精算機時に客側表示 0:する 1:しない */
// int		task_semid;		/* 排他制御用セマフォ識別子 */
// short		cl_rest_flg;		// キャッシュレス還元仕様フラグ
// int		cl_rest_fnc_cd;		// キャッシュレス還元の自動還元ファンクションコード
// int		dpoint_semid;		/* dポイント用セマフォID */
//
// short		powli_connect;
// short		powli_power_stat;
// short		powli_line_stat;
// long		powli_lost_time;
// short		powli_battery_lvl;
// short		powli_battery_cnd;
// short		powli_limit;
// short		powli_t_count;
// int		psensor_notice_flg;
// int		psensor_swing_notice_flg;
// int		psensor_slow_notice_flg;
// int		psensor_away_notice_flg;
// int		psensor_disptime;
// short		newhappy_flg;
// short		reverse_flg;
// short		overflow_stat1;
// short		overflow_stat2;
// short		dpoint_backup_flg;	/* dポイント バックアップ処理フラグ */
// short		hs_fs_qcmente_mode;	/* HappySelfフルセルフのQCメンテナンス画面かどうか 0:QCメンテ画面でない 1:QCメンテ画面である */
// //	int		ajs_emoney_offline;	/* 電子マネーオフラインフラグ */
// short           shop_and_go_rcpt_ttlnmbr_bold;	/*買上点数の強調印字*/
// short		auto_cancel_act_flg;
// short		vtcl_rm5900_flg;
// short		vtcl_rm5900_regs_on_flg;
// short		vtcl_rm5900_disp_exec_flg;
// short		vtcl_rm5900_regs_scale_flg;
// short		vtcl_rm5900_regs_stl_acx_flg;
// short		vtcl_rm5900_menu_sts;			// RM-3800 メニューステータス
// short		vtcl_rm5900_half_window_button_flg;	// RM-3800 1:網掛け画面の裏ボタン不可
// short		vtcl_rm5900_regs_preset_flg;		// RM-3800 1:登録プリセット
// short		vtcl_rm5900_forced_power_off;		// RM-3800 1:電源OFF強制
// short		vtcl_rm5900_floating_stop;		// フローティング仕様 0:有効 1:無効
// #if RF1_SYSTEM
// short		vtcl_rm5900_barcode_feed_flg;		// RM-3800 1:バーコード空白印字しない
// short		vtcl_rm5900_Sales_Report;		// RM-3800 1:登録時の売上速報
// short		vtcl_rm5900_fenceover_flg;		// RM-3800 1:FENCEOVER2時
// short		vtcl_rm5900_amount_on_hand_flg;		// RM-3800 1:在高入力時
// #endif //if RF1_SYSTEM
// char		scalerm_data[16];
// char		scalerm_count[16];
// char		scalerm_weight[16];
// char		scalerm_tare[16];
// int		scalerm_tare_flag;		/* 0: non	1: OneTouch	2: Digital	3: Preset	*/
// int		scalerm_stat;
// int		scalerm_zero_flag;		/* 0: Not zaro  1: Zero	*/
// int		scalerm_stabilize_flag;		/* 0: Not stabilize  1: Stabilize	*/
// int		scalerm_span_switch_flag;	/* 0: Span switch OFF 1: Span switch ON	*/
// int		scalerm_busy;			/* 0: ok  1: busy */
// int		scalerm_retry_Z;		/* 0: stop  1: exec	*/
// long		shop_and_go_companycode;
// long		shop_and_go_storecode;
// short		shop_and_go_apl_dl_qr_print;
// short		shop_and_go_rcpt_msg_use_no;
// short		shop_and_go_apl_dl_qr_print_normal;
// short		shop_and_go_qr_print_chk_itmcnt_fs;
// short		shop_and_go_qr_print_chk_itmcnt_ss;
// short		dummy_prn;
// short		vtcl_fhd_flg;		/* 縦型21.5インチ 判別フラグ  0:OFF 1:ON */
// short		vfhd_sag_regs_on_flg;	/* 縦型21.5インチShop&Go 登録画面起動フラグ  0:OFF 1:ON */
// short		font_lang;		/* フォント切替用 0:aa, 1:ex, 2:cn, 3:kr */
// short		vfhd_disp_exec_flg;	/* 縦型21.5インチ 描画中フラグ */
// short		vfhd_self_regs_on_flg;	/* 縦型15.6インチフルセルフ 登録画面起動フラグ  0:OFF 1:ON */
// short		vfhd_qc_regs_on_flg;	/* 縦型15.6インチ精算機 登録画面起動フラグ  0:OFF 1:ON */
// short		vtcl_fhd_fself_flg;	/* 縦型15.6インチ対面 判別フラグ  0:OFF 1:ON */
// short		vfhd_hp_fself_regs_on_flg;	/* 縦型15.6インチ対面セルフ 登録画面起動フラグ  0:OFF 1:ON */
// short		vtcl_fhd_fself_optwin_ctrl_flg;	/* 縦型15.6インチ対面 精算機またはフルセルモード切替中の客表描画判別フラグ */
// short		vfhd_half_window_button_flg;	/* 縦型15.6インチ HALFウィンドウのボタン処理を通常POSと同様にするかのフラグ 0:OFF 1:ON */
// int		psensor_swing_cnt_now;		/* 近接センサ空振り回数(現在) */
// int		psensor_swing_cnt;		/* 近接センサ空振り回数(設定) */
// short		psensor_scan_slow_sound;
// short		psensor_away_sound;
// int		rpoint_semid;		/* 楽天ポイント用セマフォID */
// short		apbf_act_flg;
// short		apbf_dlg_flg;
// short		regbag_disp_auto_cnt;
// short		tpanel_ctrl;
// char		FloatingIpAddr[64];		// フローティング先のIPアドレスを保持する
// short		FloatingOfflineFlg;		// フローティング処理用 オフラインフラグ
// RX_FLOATING_DAT	FloatingData;			// フローティング加算従業員情報
// char		hi_touch_IpAddr[64];		// ハイタッチ先のIPアドレスを保持する
// short		hi_touch_rcv;			// ハイタッチのタグ受信dデータを受信タスクに通知
// short		hi_touch_rcv_read_flg;		// ハイタッチ受信タスクでリード送信を実行
// short		hi_touch_rcv_stop_flg;		// ハイタッチ受信タスクで停止送信を実行
// short		err_dlg_21inch_flg;		/*エラーダイアログのサイズを変更  0：しない 1：する*/
// short		specchg_crt_sts;		/* スペックチェンジファイル作成状態（0 : 作成終了(未作成) 1 : 作成中） */
// } RX_COMMON_BUF;
//
//
// /**********************************************************************
//     タスクステータス定義(共有メモリ)
//  ***********************************************************************/
// /*-----  チェッカータスクステータス  -----*/
// typedef struct {
// int             SpoolStat;
// int		cash_pid;
// int             stat;
// char            intkey_flag;         /* intkey flag */
// char            intBook_flag;
// char            errstat_flag;
// #ifdef FB2GTK
// int             reg_flg;             /* Regs Check Flg for Dual */
// int             err_stat;            /* Error Check Flg for Dual */
// int             stat_dual;
// int             selfmove_flg;
// int             selfctrl_flg;
// uchar           SelfGifPath[128];
// short		qc_movie_x_offset;	/* movie x offset */
// short		qc_movie_y_offset;	/* movie y offset */
// short		qc_movie_w_size;	/* movie width */
// short		qc_movie_h_size;	/* movie height */
// int             dlg_msg_chg;
// uchar           dlg_chg_msg[128+10];
// #ifdef FB_EL
// short           ELdual;
// #endif
// #endif
// int             sg_rfm_flg;
// int             fip_stop_flg;
// short           fnc_code;       /* ファンクションコード */
// short		movie_stat;	/* movie playing stat */
// int             sclstop_flg;
// int             sclstop_1time_flg;
// uchar           color_fip_movie_path[128];
// short           color_fip_movie_x;
// short           color_fip_movie_y;
// short           color_fip_movie_w;
// short           color_fip_movie_h;
// short           color_fip_movie_stat;
// int             autodscstl_par;
// int		autodscstl_conf;
// int             qcjc_frcclk_flg;
// short           tab_active;
// short           notice_chk;
// short           chk_registration;
// short           stlkey_retn_function;
// short           colorfip_ctrl_flg;
// long            cin_total_price;
// short           kycash_redy_flg;
// short		ky_qcselect_flg;
// short		regs_start_flg;
// short           memo_set_flg;
// short		next_regs_start_chk;
// int             fip_notuse;
// short		staff_pw;	//簡易従業員入力画面表示 0x01:表示中 0x02:処理中
// }RX_TASKSTAT_CHK;
//
// /*-----  キャッシャータスクステータス  -----*/
// typedef struct {
// int		stat;
// int		err_stat;
// int		inout_flg;
// int		int_stat;
// int             chk_pid;
// #ifdef FB2GTK
// int             menukey_flg;
// int             cmodkey_flg;
// #endif
// short           fnc_code;       /* ファンクションコード */
// int		int_ban_flg;
// int             qcjc_j_stat;
// int		autodscstl_conf;
// short           tab_active;
// short           notice_flg;
// short           notice_msg_cd;
// short           redisp_flg;
// short           autostlky_flg;
// short           content_movie_stop_flg;
// short           regsret_stop_flg;
// short           cinreturn_flg;
// short           kycash_start_flg;
// short		regstart_chkflg;
// short           comltd_flg;	// 簡易入力画面表示フラグ
// short		ky_cash_cha_flg;
// short           self_mnt_ctrl_flg;
// short           memo_set_flg;
// short		vesca_charge_settle;	// Verifoneチャージ対象ブランド
// short		cash_ready_flg;		// 対面セルフキャッシャーの立ち上げ完了をチェックする
// short		staff_pw;	//簡易従業員入力画面表示 0x01:表示中 0x02:処理中
// }RX_TASKSTAT_CASH;
//
/*-----  スプール管理タスクステータス  -----*/
/// 関連tprxソース:rxmem.h RX_TASKSTAT_SPL
class RxTaskStatSpl {
  int SpoolCnt = 0;
  int SpoolCnt_old = 0;
}
//
// /*-----  ドロアタスクステータス -----*/
// typedef struct {
// long		PrnStatus;
// unsigned char drw_stat;
// unsigned char drw_stat2;
// }RX_TASKSTAT_DRW;
//
// /*-----   売価チェック印字データ(MM)  ---*/
// typedef struct {
// short  piece;
// long   price;
// long   cust_price;
// } RX_SCNCHK_MM;
//
// /*-----   顧客チェック印字データ   ---*/
// typedef struct {
// //        char   cust_no[13+1];
// //        char   shot_cust_no[8+1];
// char   cust_no[MBR_CD_MAX+1];
// char   shot_cust_no[MAG_CD_MAX+1];
// char   name[50+1];
// long   total_buy_rslt;
// long   total_point;
// long   anyprc_term_mny;
// short  fsp_lvl;
// } RX_SCNMBR;
//
// /*-----   商品チェック印字データ   ---*/
// typedef struct {
// char   pos_name[sizeof(((c_plu_mst *)NULL)->pos_name)];
// char   plu_cd[13+1];
// long   mdlcls_cd;
// long   smlcls_cd;
// long   pos_prc;
// long   pos_nonplu_prc;
// long   cust_prc;
// long   brgn_cd;
// char   brgn_plan_cd[sizeof(((p_promsch_mst*)NULL)->plan_cd)];
// long   brgn_prc;
// long   brgncust_prc;
// long   point_add;
// long   fsp_cd;
// long   s_price;
// long   a_price;
// long   b_price;
// long   c_price;
// long   d_price;
// long   bdl_cd;
// char   bdl_plan_cd[sizeof(((p_promsch_mst*)NULL)->plan_cd)];
// RX_SCNCHK_MM   mm[5];
// double cost;
// double brgn_cost;
// short  brgn_typ;
// long   dsc_prc;    /* c_stresml_mst */
// short  dsc_flg;    /* c_stresml_mst */
// short  bdl_typ;
// long   av_prc;
// long   cust_av_prc;
// short  avprc_adpt_flg;
// short  avprc_util_flg;
// long   low_limit;
// #if SALELMT_BAR
// short  rec_mthd_flg;
// char   sale_date[32];
// #endif
// short  bar_format_flg;  /* cm_set_jan_inf()の値をセットしている */
// short  rec_mthd_flg2;   /* アヤハディオ様 保証書ボタン対応 */
// short  input_mthd_flg;  /* アヤハディオ様 保証書ボタン対応 */
// short  guarantee_sht;   /* guarantee sheet print *//* アヤハディオ様 保証書ボタン対応 */
// char   wgt_flg;         /* アヤハディオ様 保証書ボタン対応 */
// int    nomi_prc;        /* アヤハディオ様 保証書ボタン対応 */
// long   item_qty;        /* アヤハディオ様 保証書ボタン対応 */
// char   plu_cd1_1[13+1]; /* アヤハディオ様 保証書ボタン対応 */
// char   plu_cd1_2[13+1]; /* アヤハディオ様 保証書ボタン対応 */
// char   plu_cd2_1[13+1]; /* アヤハディオ様 保証書ボタン対応 */
// long   tnycls_cd;       /* アヤハディオ様 保証書ボタン対応 */
// long   lrgcls_cd;       /* アヤハディオ様 保証書ボタン対応 */
// int    ope_mode_flg;    /* アヤハディオ様 保証書ボタン対応 */
// long   prom_cd;         /* アヤハディオ様 保証書ボタン対応 */
// short  prfree_flg;      /* アヤハディオ様 保証書ボタン対応 */
// char   btl_ret1_flg;    /* アヤハディオ様 保証書ボタン対応 */
// short  bar_format_flg2;  /* アヤハディオ様 保証書ボタン対応 *//* c_itemlogの値をセットしている */
// long   Mbr_bdl_cd;
// char   Mbr_bdl_plan_cd[sizeof(((p_promsch_mst*)NULL)->plan_cd)];
// RX_SCNCHK_MM Mbr_mm[5]; /* 会員ミックスマッチ情報 */
// short  Mbr_bdl_typ;
// long   Mbr_av_prc;
// long   Mbr_cust_av_prc;
// short  Mbr_avprc_adpt_flg;
// short  Mbr_avprc_util_flg;
// long   Mbr_low_limit;
// short	certificate_typ;	// 証書タイプ
// short	update_flg;		// 実績更新中フラグ
// } RX_SCNITEM;
//
// /*-----   売価チェック印字データ   ---*/
// typedef struct {
// RX_SCNITEM      ScnItem;
// RX_SCNMBR       ScnMbr;
// } RX_SCNCHK;
//
// /*-----   ポイント加算印字データ   ---*/
// typedef struct {
// short	addpnt_fnccode;		/* アヤハディオ様 ポイント加算対応 */
// } RX_ADDPNTITEM;
//
// /*-----   ポイント加算印字データ   ---*/
// typedef struct {
// RX_ADDPNTITEM	AddpntItem;	/* アヤハディオ様 ポイント加算対応 */
// } RX_ADDPNT;
//
// /*-----  プリンタタスクステータス -----*/
// typedef struct {
// short		StepCnt;
// short		ErrCode;
// #if MC_SYSTEM
// short           MCStat;
// #endif
// short           rpkind;    /* 切断なし印字制御
//                                         0:ヘッダ付き印字
//                                         1:ヘッダなし印字
//                                         2:切断のみ
//                                    */
// RX_SCNCHK       ScnChk;
// RX_ADDPNT	AddPnt;		/* アヤハディオ様 ポイント加算対応 */
// int		sync_get_num;	/* Printer Get Sync Number */
// int		init;
// int             prnrbuf_type;
// #if TW
// short		tckt_only;		/* サービスチケットのみ印字フラグ（台湾用） */
// #endif
// }RX_TASKSTAT_PRN;
//
// /*-----  プリンタ共通タスクステータス -----*/
// typedef struct {
// short		StepCnt;
// short		ErrCode;
//
// int		PrintStart;	/* 印字の可不可 0:不可 1:可	*/
// int		AplPipeReOpen;	/* from APL PIPE 再オープン指示 */
// }RX_TASKSTAT_PRN_COM;
//
// /*-----  ステーションプリンタタスクステータス -----*/
// typedef struct {
// short		StepCnt;
// short		ErrCode;
// short		PageCnt;
// short		PrnFlg;
// short		LoopFlg;
// short		FeedFlg;
// }RX_TASKSTAT_STPR;
//
// /*-----  ツーステーションプリンタタスクステータス -----*/
// typedef struct {
// short		StepCnt;
// short		ErrCode;
// short		PageCnt;
// short		AllPageCnt;
// short		PaperChgPageCnt;
// S2PR_STATE_DATA PrnStatus;    /* TWNO_S2PR */
// }RX_TASKSTAT_S2PRN;
//
// /*----- ローカル実績上げステータス -----*/
// typedef struct {
// long		WaitTime;
// short		ErrCode;
// }RX_TASKSTAT_UPD;
//
// /*----- メイン実績上げステータス -----*/
// typedef struct {
// short		UpCnt;
// short		AllCnt;
// }RX_TASKSTAT_MUPD;

// /*----- JPOタスクステータス -----*/
// typedef struct {
// long            price;
// short           ctr;
// short           order;
// //short           stat;
// int             stat;
// short           err_stat;
// tprmsgdevack2_t devack;
// short           s_cancel;
// char            req_data[1024];
// char            socket_flg;
// short           pay_condition;
// long		cct_suica_use_prc;
// short		cct_suica_any_flg;
// long		jmups_rcpt_no;
// long		jmups_seq_no;
// long		trm_slipno;
// char		err_no[8];
// short		jmups_ac_flg;
// short		currentservice;
// char            comp_cd[16];
// short		vesca_cvm;
// char		vesca_errcd[16];	/* 表示用エラーコード */
// char		vesca_errcd_detail[16];	/* エラーコード詳細 */
// short		vesca_edy_nearfull;	/* Edyニアフル制御用フラグ */
// short		vesca_end_act_chk;
// long		cafis_arch_seqno;
// char            accountnumber[16+1];    // 会員番号
// long            cancel_slip_no;         // 取消・返品用の元伝票番号
// char            t_card_number[16+1];    // Tカード会員番号(9桁または16桁)
// char            selected_media[20];     // 選択されたメディア(FeliCa/JIS2Mag)
// char            data_type[20];          // データタイプ
// char            idm_no[20];             // IDm情報
// long            felica_table_no;        // FeliCa使用の場合にアクセスしたテーブルのレコード番号
// char            block1_value[32+1];     // FeliCa使用の場合に読み込んだブロック１のデータ
// char            block2_value[32+1];     // FeliCa使用の場合に読み込んだブロック２のデータ
// char            block3_value[32+1];     // FeliCa使用の場合に読み込んだブロック３のデータ
// char            block4_value[32+1];     // FeliCa使用の場合に読み込んだブロック４のデータ
// char            block5_value[32+1];     // FeliCa使用の場合に読み込んだブロック５のデータ
// char            block6_value[32+1];     // FeliCa使用の場合に読み込んだブロック６のデータ
// char            block7_value[32+1];     // FeliCa使用の場合に読み込んだブロック７のデータ
// char            block8_value[32+1];     // FeliCa使用の場合に読み込んだブロック８のデータ
// char            jis2_data[69+1];        // JIS2磁気データ
// short           custom_code;            // カスタムコード
// char		cafis_arch_service[8];	// CAFIS Arch業務区分
// short		kid_emoney_kind;
// long		settledamount;		// 決済額
// long		beforebalance;		// 決済前残高
// short		jetbcrdt_corp_cd;		// KID
// short		jetbcrdt_payment_div;		// 支払区分
// short		jetbcrdt_bonus_cnt;		// ボーナス回数
// char		jetbcrdt_bouns_month[20];	// ボーナス月
// long		jetbcrdt_bouns_amt; 		// ボーナス金額
// short		jetbcrdt_start_month;		// 支払開始月
// short		jetbcrdt_division_cnt;		// 分割回数
// long		jetbcrdt_first_amt;		// 初回金額
// char		creditCompanyCode[7+1];			// カード会社コード
// char		creditCompanyName[64+2];		// カード会社名
// char		creditCompanyNameJp[64+2];		// カード会社名（全角）
// char		cardNetwork[32+2];			// カードネットワーク名
// char		lumpSumType[2+1];			// 支払い区分コード：一括
// char		bonusType[2+1];				// 支払い区分コード：ボーナス
// char		bonusComboType[2+1];			// 支払い区分コード：ボ併
// char		installmentType[2+1];			// 支払い区分コード：分割
// char		revolvingType[2+1];			// 支払い区分コード：リボ
// char		minAmountInstalment[8+1];		// 分割払い最低金額
// char		instalmentPlan[64+1];			// 分割回数パターン
// char		minAmountBonus[8+1];			// ボーナス払い最低金額
// char		bonusAvailableMonth[32+1];		// ボーナス払い可能月
// char		creditCompanyTel[15+1];			// 電話番号
// short		wait_next_timeout;			// カードを支払い方法の電文を受信するまでのタイムアウト（秒）
// char		vesca_accountnumber2[20];		// 会員番号
// short		paymentcondition;			// 支払区分
// short		firstmonth;				// 支払開始月
// short		numinstalment;				// 分割回数
// long		firstamount;				// 初回金額
// short		numbonus;				// ボーナス回数
// short		bonusmonth1;				// ボーナス月1
// short		bonusmonth2;				// ボーナス月2
// short		bonusmonth3;				// ボーナス月3
// short		bonusmonth4;				// ボーナス月4
// short		bonusmonth5;				// ボーナス月5
// short		bonusmonth6;				// ボーナス月6
// long		bonusamount1;				// ボーナス金額1
// long		bonusamount2;				// ボーナス金額2
// long		bonusamount3;				// ボーナス金額3
// long		bonusamount4;				// ボーナス金額4
// long		bonusamount5;				// ボーナス金額5
// long		bonusamount6;				// ボーナス金額6
// char		datetime[20+1];				// 取引日時 YY/MM/DD HH:MM:SS
// short		ispaymentdetails;			// 支払情報
// short		param;					// 電文区分（0:通常、1:拡張1、2:拡張2）
// short		felica_id_mark1;			// IDマーク1
// short		felica_id_mark2;			// IDマーク2
// short		felica_id_mark3;			// IDマーク3
// short		felica_id_mark4;			// IDマーク4
// short		felica_id_mark5;			// IDマーク5
// short		felica_id_mark6;			// IDマーク6
// short		felica_id_mark7;			// IDマーク7
// short		felica_id_mark8;			// IDマーク8
// short		vesca_lang;				// Verifone表示言語指定用
// long		balance;				// 残高
// short		vesca_currentservice;			// 電子マネーブランド判定用
// char		vesca_errdetail[16];			// 電子マネーエラーコード詳細判定用
// short		vesca_error_order;			// 電子マネーエラー判定用
// char		vesca_status_cd[4+1];			// Verifone状態通知コード
// short		gmo_timeout;				// VEGA端末 通信強制終了フラグ
// char		cancel_auth_no[20];			// 元取引承認番号
// char		statement_id[20];			// 1件明細ID
// long		subamount_month;			// 当月利用金額合計
// long		subamount_day;				// 本日利用金額合計
// char		qr_brand[2+1];				// QRコード決済ブランド
// short           vesca_waon_retch;                       // WAON再タッチフラグ
// short           vesca_balance_inq;                       // 残高照会時フラグ
// RX_LANE_INFO	lane_info;
// }RX_TASKSTAT_JPO;
//
// /*----- SCLタスクステータス -----*/
// typedef struct {
// short           order;
// short           stat;
// short           err;
// long            weight;
// short           flg;
// tprmsgdevack2_t devack;
// }RX_TASKSTAT_SCL;
//
// /*----- RCRWタスクステータス -----*/
// typedef struct {
// short		order;
// short		stat;
// short           ejct;
// TRC_TR          trctrack;  /* Track data(track1-track3) */
// TRC_DATA        trcdata;   /* Track data(magn/prn data) */
// ORC_WR_IWAI     orcdata;   /* Oki Data                  */
// FSP_TR          fsptrack;  /* Track data(track1-track3) */
// FSP_DATA        fspdata;   /* Track data(magn/prn data) */
// T_VMC_MGNT_P    vmcpdata;  /* vismac apl data           */
// T_VMC_MGNT_T    vmctdata;  /* vismac magnetic data      */
// T_VMC_VSAL_P    vmcvdata;  /* vismac visual data        */
// PSP_RSTAT       crwpstat;  /* Glory Status              */
// CRWP_RWD_DATA   crwpdata;  /* Glory Data                */
// long            crwpprep;  /* Glory non print point     */
// short           cnt;       /* Glory retry count         */
// PANA_DATA       panadata;  /* Pana Data                 */
// #if PSP_70
// PSP70_CARDDATA    psp70_carddata;
// PSP70_APLSTAT     psp70_apldata;
// #endif
// #if SAPPORO
// PANA_SPD_DATA   sapporo_panadata;  /* Sapporo Drug Pana Data */
// PANA_JKL_DATA   jkl_panadata;  /* Jakkulu Drug Pana Data */
// PANA_RAINBOW_DATA rainbow_panadata; /* Rainbow Card Data */
// PANA_MATSUGEN_DATA mgn_panadata;    /* Matstugen Pana Data */
// PANA_MRY_DATA   mry_panadata;      /* Moriya Pana Data */
// #endif
// MCP_DATA        mcp_data;  /* Mcp200 Data */
// MCP_STAT        mcp_stat;  /* Mcp200 Status */
// long            today_point;  /* Card Today Point Data */
// short           use_prepaid;  /* ABS-S31K Use Prepaid */
// HT2980_CARDINFO   ht_cardinfo;   /* HT2980 CardInfo    */
// HT2980_WRITE      ht_write;      /* HT2980 Write       */
// HT2980_WRITE_R    ht_write_data; /* HT2980 WriteResult */
// ABSV31_DATA	absv31_data;	/* ABS_V31 data */
// short		absv31_flg;	/* ABS_V31 flg */
// tprmsgdevack2_t devack;
// }RX_TASKSTAT_RWC;
//
// typedef struct {
// short		stat;
// }RX_TASKSTAT_STROPN;
//
// /*----- SUICAタスクステータス -----*/
// typedef struct {
// long            price;        /* 引去金額   */
// unsigned long   before_price; /* 引去金額   */
// long            after_price;  /* 取引後残額 */
// unsigned long   rest;         /* カード残額 */
// unsigned long   cncl_amt;     /* 取消金額   */
// unsigned long   price2;
// unsigned short  detcnt;       /* 残り一件明細件数 */
// unsigned short  rct_id;       /* 一件明細ID */
// unsigned short  seq_ic;       /* IC取扱通番 */
// unsigned short  sf_log;       /* SFログID */
// unsigned short  act_cd;       /* 活性化事業者コード */
// unsigned char   rct_date[7];  /* 一件明細作成時間 */
// unsigned char   cmd_cd;       /* コマンドコード */
// unsigned char   sub_cd;       /* サブコード */
// short           ctr;
// short           order;
// short           stat;
// char            mode;
// uchar           end_cd;
// short           err_stat;
// short           Trans_flg;
// short           Time_flg;
// char            idi[17];        /* カードIDi */
// char            ng_res[49];
// char            buf[256];
// short           Time_Set;
// MULTI_BUF       multi_buf;    /* 取引/障害ログバッファ */
// short           Alarm_flg;
// short           sub_order;
// char            card_type;
// short           step;
// unsigned long   charge_amt;
// unsigned short  charge_cnt;
// NIMOCA_DATA     nimoca_data;   /* nimoca用バッファ */
// tprmsgdevack2_t devack;
// }RX_TASKSTAT_SUICA;
//
// /*----- SGSCL1タスクステータス -----*/
// typedef struct {
// short		order;
// short		chk_order;
// short		st_order;
// short		re_order;
// short		err;
// short		stat;
// short		start_flg;
// short		rezero_flg;
// short		zerochk_flg;
// long		start_wgt;
// long		save_wgt;
// long		last_wgt;
// long		now_wgt;
// long		chk_wgt;
// long		tare;
// long		incount;
// short		stopcmd_flg;
// short		timeout_flg;
// short           skip_btn_on;
// short		write_order;
// short		write_read_flg;
// tprmsgdevack2_t devack;
// }RX_TASKSTAT_SGSCL1;
//
// /*----- SGSCL2タスクステータス -----*/
// typedef struct {
// short		order;
// short		chk_order;
// short		st_order;
// short		re_order;
// short		err;
// short		stat;
// short		start_flg;
// short		rezero_flg;
// short		zerochk_flg;
// long		start_wgt;
// long		save_wgt;
// long		last_wgt;
// long		now_wgt;
// long		chk_wgt;
// long		tare;
// long		incount;
// short		stopcmd_flg;
// short		timeout_flg;
// short           skip_btn_on;
// short		write_order;
// short		write_read_flg;
// tprmsgdevack2_t devack;
// }RX_TASKSTAT_SGSCL2;
//
// typedef struct {
// int		mupdate_stop;
// int		supdate_stop;
// #if NEW_TRANS
// short		ment_nonstop;
// short		C0_cont;
// short		C1_cont;
// short		C2_cont;
// #endif
// }RX_TASKSTAT_BUPD;
//

 /*----- HQFTPタスクステータス -----*/
/// request_start にセットするリクエストタイプ
/// 関連tprxソース:rxmem.h - HQFTP_REQUEST_TYP
enum HqftpRequestTyp {
  HQFTP_REQ_NOT(0),
  HQFTP_REQ_OPN(1), // 開設送信
  HQFTP_REQ_DAY(2), // 日中送信
  HQFTP_REQ_CLS(3), // 閉設送信(バックアップあり)
  HQFTP_REQ_CLS_CREATE(4), // 閉設作成のみ
  HQFTP_REQ_ODR(5), // 発注送信
  HQFTP_REQ_PAST_CREATE(6), // 再作成
  HQFTP_REQ_RESEND(7), // 再送信
  HQFTP_REQ_MSTSEND(8), // マスタデータ送信
  HQFTP_REQ_CSSMSTCREATE(9), // CSSマスタ作成
  HQFTP_REQ_MANUAL_SEND(10); // 日中ファイルの即時手動送信

  final int type;

  const HqftpRequestTyp(this.type);
}

// typedef	enum
// {
// HQHIST_REQ_NOT = 0,	// 定時での受信動作
// HQHIST_REQ_RECV,	// 他タスクからの受信要求動作
// HQHIST_REQ_CLS,		// 閉設
// HQHIST_REQ_OPN,		// 開設
// HQHIST_REQ_DWN_S,	// 一括ダウンロード(SGYOUMU)
// HQHIST_REQ_DWN_A,	// 一括ダウンロード(AGYOUMU)
// } HQHIST_REQUEST_TYP;
//
// /*----- HQHISTタスクステータス -----*/
// typedef struct {
// int		mode;		// 動作状態  0:正常  1:強制ストップ
// int		running;
// int		request_start;	// HQHIST_REQUEST_TYPの状態
// int		request_result;	// 要求受信結果  0:正常  それ以外:異常
// int		request_count;	// 要求受信件数
// int		hqhist_end;
// int		invalid;	// 一括ダウンロードで使用
// int		countOK;		// SGYOUMU 正常レコード件数
// int		countNG;		// SGYOUMU 異常レコード件数
// int		countC1;		// SGYOUMU 指示件数
// }RX_TASKSTAT_HQHIST;
//
// /*----- 管理ＰＣ送信用タスクステータス -----*/
// typedef struct {
// char		msglog_buf[256];
// }RX_TASKSTAT_MANAGEPC;
//
// /*-----  音声タスクステータス  -----*/
// typedef struct {
// short           ErrCode;
// short           stop;
// }RX_TASKSTAT_SOUND;
//
// #if (MC_SYSTEM || SEGMENT)
// /*-----  Ｍカード仕様 ログ実績加算タスクステータス  -----*/
// typedef struct {
// short           order;
// short           mseg_order;
// short           customercard_order;
// short           customercard_check;
// int             customercard_no;
// short           content_play_flg;
// }RX_TASKSTAT_MCFTP;
// #endif
//
// #if CN_NSC
// /*----- BANKPRGタスクステータス -----*/
// typedef struct {
// short           ctr;
// short           order;
// short           stat;
// short           proc;
// int             bank_pid;
// }RX_TASKSTAT_BANK;
// #endif
//
// /*-----  記録確認タスクステータス  -----*/
// typedef struct {
// short		ejother_flg;
// }RX_TASKSTAT_EJCONF;
//
// /*-----  ＭＰ１タスクステータス  -----*/
// typedef struct {
// short	ErrCode;
// short	MP1_Stat;
// short	Stop;
// char	ErrPlu[200][13];
// }RX_TASKSTAT_MP1;
//
// typedef struct {
// int		updE_flg;
// int		upd_flg;
// int		updS_flg;
// int		updS_C_flg[MS_CONNECT_MAX];
// int		updC0_flg;
// int		updC1_flg;
// int		updC2_flg;
// } RX_TASKSTAT_UPDCON;
//
// /*----- MULTIタスクステータス -----*/
// typedef struct {
// short		auto_flg;
// short		off_flg;
// short		order;
// short		flg;
// short		err_cd;
// ushort		step;
// ushort		step2;
// FCL_DATA	fcl_data;
// NIMOCA_DATA     nimoca_data;   /* nimoca用バッファ */
// tprmsgdevack2_t	devack;
// } RX_TASKSTAT_MULTI;
//
// /*----- ICCタスクステータス -----*/
// typedef struct {
// short		order;
// short		flg;
// long		err_cd;
// char		waon_flg;
// char		suica_flg;
// char		id_flg;
// char		obs_cnt;
// long		result_code_extended;
// } RX_TASKSTAT_ICC;
//
// /*----- Cust Realタスクステータス -----*/
// typedef struct {
// short		auto_flg;
// short		order;
// short		flg;
// short		err_cd;
// tprmsgdevack2_t	devack;
// } RX_TASKSTAT_CUSTREAL;

/*----- MSRタスクステータス -----*/
///   関連tprxソース:rxmem.h　- RX_TASKSTAT_MSR
class RxTaskStatMsr {
  int stat = 0;
  int order = 0;
}

/*----- Cust Real2タスクステータス -----*/
///   関連tprxソース:rxmem.h　RX_TASKSTAT_CUSTREAL2
class RxTaskStatCustreal2 {
  int order = 0;
  int sub = 0;
  int stat = 0;
  RxMemCustReal2Data data = RxMemCustReal2Data();
}

//
// /*----- netDoA Cust Realタスクステータス -----*/
// typedef struct {
// short		order;
// int			Status;
// char		ErrMsg[100];
// } RX_TASKSTAT_NETDOA;
//
// // Qc Connectタスクステータス
// typedef struct {
// long			ConMax;				// 接続数
// RXMEM_QCCONNECT_DATA	MyStatus;			// 自レジ情報格納
// RXMEM_QCCONNECT_DATA	ConStatus[QCCONNECT_MAX];	// 接続レジ情報格納
// } RX_QCCONNECT;
//
// //Movie Send タスクステータス
// typedef struct {
// short           order;
// short		del_flg;
// }RX_TASKSTAT_MOVIESEND;
//
// /*----- NTT DATA Precaタスクステータス -----*/
// typedef struct {
// short			order;
// short			sub;
// short			stat;
// RXMEMNTTDPRECA_TX	tx_data;
// RXMEMNTTDPRECA_RX	rx_data;
// } RX_TASKSTAT_NTTDPRECA;
//
/*----- NEC Cust Realタスクステータス -----*/
/// 関連tprxソース:rxmem.h RX_TASKSTAT_NECCUATREAL
class RxTaskStatNeccuatreal {
  int order = 0;
  int status = 0;
  String errMsg = '';
}
//
// /*----- MASRタスクステータス -----*/
// typedef struct {
// short           order;			/*  ORDER_READ_START  : リード開始
// 						　　ORDER_CNCL_START　：リード終了 */
// short		card_stat;		/*  MASR_RES_CARD_NONE: カードなし
// 						　　MASR_RES_CARD_GATE：ゲートイン
// 						　　MASR_RES_CARD_IN　：カードイン */
// int		err_cd;			/*  エラーコード */
// short		eject_flg;		/*  リード後にリジェクトしない */
// } RX_TASKSTAT_MASR;
//
// /*----- SQRCタスクステータス -----*/
// typedef struct {
// short           order;
// short           stat;
// short           err_flg;
// char            err_msg[256];
// char            filename[128];
// short           result_type;
// short           result_code;
// short           start_type;
// short           timeout;
// tprmsgdevack2_t devack;
// }RX_TASKSTAT_SQRC;
//
// /*----- Teraoka Precaタスクステータス -----*/
// typedef struct {
// short			order;
// short			sub;
// short			stat;
// RXMEMTRKPRECA_TX	tx_data;
// RXMEMTRKPRECA_RX	rx_data;
// } RX_TASKSTAT_TRKPRECA;
//
// /*----- Repicaタスクステータス -----*/
// typedef struct {
// short			order;
// short			sub;
// short			stat;
// int			scan_flg;	/* レピカ(アララ)標準用 CODE128のバーコードが可変桁のため"DevNotifyScannerMain()"で読取モード時に処理するためのフラグ */
// RXMEM_REPICA_TX		tx_data;
// RXMEM_REPICA_RX		rx_data;
// } RX_TASKSTAT_REPICA;
//
// /*----- CoGCaタスクステータス -----*/
// typedef struct {
// short			order;
// short			sub;
// short			stat;
// RXMEM_COGCA_TX		tx_data;
// RXMEM_COGCA_RX		rx_data;
// } RX_TASKSTAT_COGCA;
//
// /*----- バーコード決済タスクステータス -----*/
// typedef struct {
// short	type;	/* 決済タイプ */
// short	order;
// short	cancel_flg;
// short	scan_flg;			/* CODE128のバーコードが可変桁のため"DevNotifyScannerMain()"で読取モード時に処理するためのフラグ */
// short	scan_qcjc_qc_flg;	/* 上記をqcjc時にqc側へ処理するためのフラグ */
// short	stat;
// RXMEM_BCDPAY_TX		tx_data;
// RXMEM_BCDPAY_RX		rx_data;
// } RX_TASKSTAT_BCDPAY;
//
// /*----- VEGA3000タスクステータス -----*/
// /* VEGA3000端末カード情報取得用 */
// typedef struct {
// char	card_type;		/* カードタイプ(D_ICCD1 / D_MCD2) */
// char	type;			/* カード利用区分 */
// char	cardData1[38+1];	/* カード情報１ */
// char	cardData2[70+1];	/* カード情報２ */
// char	errCode[4+1];		/* エラーコード */
// char	msg1[24+1];		/* メッセージ１ */
// char	msg2[24+1];		/* メッセージ２ */
// } RXMEM_VEGA_CARD;
//
// typedef struct {
// short			vega_order;
// RXMEM_VEGA_CARD		vega_data;	/* VEGA3000使用 data buffer */
// } RX_TASKSTAT_VEGA;
//
// /*-----  UPDZIPタスクステータス  -----*/
// typedef struct {
// short           ErrCode;
// short           stop;
// short   stat;
// uchar   UpdFilePath[128];
// uchar   ZipFilePath[128];
// }RX_TASKSTAT_UPDZIP;
//
// /*----- バリューカードタスクステータス -----*/
// typedef struct {
// short			order;
// short			sub;
// short			stat;
// short			bcd_type;
// RXMEM_VALUECARD_TX	tx_data;
// RXMEM_VALUECARD_RX	rx_data;
// } RX_TASKSTAT_VALUECARD;
//
// /*----- AJS 電子マネータスクステータス -----*/
// typedef struct {
// short			order;
// short			sub;
// short			stat;
// long			mac_no;
// RXMEM_AJS_EMONEY_TX	tx_data;
// RXMEM_AJS_EMONEY_RX	rx_data;
// } RX_TASKSTAT_AJS_EMONEY;
//
// /*----- 免税電子化タスクステータス -----*/
// typedef struct
// {
// short	stat;
// short	order;
// short	err_cd;
// char	errmsg[401];
// char	result[10];
// short	timeout;		//通信timeout
// char	pos_code[3+1];		//端末番号
// long    corp_code;		//企業コード
// long	shop_code;		//店舗コード
// char	term_code[14+1];	//端末識別子
// char	tran_info[128];		//登録ファイル情報
// char	voucher_num[TAXFREE_VOUCHER_LEN+1];		//伝票番号
// char	cncl_voucher_num[TAXFREE_VOUCHER_LEN+1];	//取消伝票番号
// TAXFREE_REF_DATA	ref_data;	//サーバーデータ参照した取引情報
// int	server_typ;		//接続先 0:商用　1：デモ
// short	regs_tran_mode;		//登録モード　0：通常　1：訓練
// short	tran_err;		//登録実績チェック　0：正常　1：異常（同じ免税伝票番号の実績が存在）
// }RX_TASKSTAT_TAXFREE;
//
// /*----- Shop&Go WebApiタスクステータス -----*/
// /* Shop&Go WebApi通信用 */
// #define	API_LIST_MAX		10
//
// typedef struct
// {
// char			code[36+1];		/* エラーコード */
// char			message[36+1];		/* エラーメッセージ */
// } RCV_BASKET_API_ERR_LIST;
//
// typedef struct
// {
// char			ID[36+1];		/* 商品判別ID */
// int			scanStatus;		/* 商品種別 */
// int			quantity;		/* 商品購入数量 */
// long			price;			/* 商品単価 */
// char			barcode[28+1];		/* 読み込んだバーコード文字列 */
// char			barcode2[28+1];		/* 読み込んだバーコード文字列 */
// char			notScannedImageURL[1024+1];	/* カゴ抜け画像のURL */
// char			notScannedImageURL2[1024+1];	/* カゴ抜け画像２のURL */
// char			notScannedImageURL3[1024+1];	/* カゴ抜け画像３のURL */
// char			scanTime[19+1];		/* 買物開始時刻 */
// } RCV_BASKET_API_4_2;
//
// typedef struct
// {
// int			trialSmartPhoneFlag;
// } RCV_BASKET_API_4_2_CART_INFO;
//
// typedef struct
// {
// char			url[256];		/* URL */
// } SND_API_4_2;
//
// typedef struct
// {
// int             	result;				/* リザルトステータス */
// char			message[256+1];			/* メッセージ */
// RCV_BASKET_API_ERR_LIST	error_list[API_LIST_MAX];			/* エラーリスト */
// char			startTime[19+1];		/* 買物開始時刻 */
// RCV_BASKET_API_4_2	itemList[ITEM_MAX+1];		/* 商品リスト */
// RCV_BASKET_API_4_2_CART_INFO    cartInfoList[API_LIST_MAX];
// int             	item_max;				/* リザルトステータス */
// long			receipt_no;			/* レシート番号(カゴ抜け画像用) */
// } RCV_API_4_2;
//
// typedef struct
// {
// int             	result;				/* リザルトステータス */
// char			message[256+1];			/* メッセージ */
// RCV_BASKET_API_ERR_LIST	error_list[10];			/* エラーリスト */
// int			cartStatus;			/* カートステータス */
// char			url[256];		/* URL */
// } SND_API_4_7;
//
// typedef struct
// {
// int             	result;				/* リザルトステータス */
// char			message[256+1];			/* メッセージ */
// RCV_BASKET_API_ERR_LIST	error_list[10];			/* エラーリスト */
// int			cartStatus;			/* カートステータス */
// } RCV_API_4_7;
//
// typedef struct
// {
// char			url[256];		/* URL */
// int			cartStatus;			/* カートステータス */
// } SND_API_4_9;
//
// typedef struct
// {
// int             	result;				/* リザルトステータス */
// char			message[256+1];			/* メッセージ */
// RCV_BASKET_API_ERR_LIST	error_list[10];			/* エラーリスト */
// } RCV_API_4_9;
//
// typedef struct
// {
// char				url[256];			/* URL */
// char	            		departmentCode[9];		/* 部門コード */
// } SND_API_6_1;
//
// typedef struct
// {
// int             		result;				/* リザルトステータス	*/
// char				message[256+1];			/* メッセージ		*/
// RCV_BASKET_API_ERR_LIST		error_list[API_LIST_MAX];	/* エラーリスト		*/
// char	            		departmentCode[9];		/* 部門コード		*/
// char				departmentName[36];		/* 部門名		*/
//
// } RCV_API_6_1;
//
// typedef struct
// {
// char				url[256];			/* URL */
// char	            		pluCode[20];			/* PLUコード */
// } SND_API_7_1;
//
// typedef struct
// {
// int             		result;				/* リザルトステータス	*/
// char				message[256+1];			/* メッセージ		*/
// RCV_BASKET_API_ERR_LIST		error_list[API_LIST_MAX];	/* エラーリスト		*/
// char				barcode[20+1];			/* 読み込んだバーコード文字列	*/
// char				barcode2[20+1];			/* 読み込んだバーコード文字列	*/
// char				name[50];			/* 商品名			*/
// long				price;				/* 商品単価			*/
// int				quantity;			/* 重量  or 個数		*/
// int				weightType;			/* 商品種別			*/
// int				unitOfMeasurement;		/* 測定単位			*/
// } RCV_API_7_1;
//
// typedef struct
// {
// char			ID[36+1];		/* 商品判別ID */
// int			scanStatus;		/* 商品種別 */
// int			quantity;		/* 商品購入数量 */
// long			price;			/* 商品単価 */
// char			barcode[20+1];		/* 読み込んだバーコード文字列 */
// char			barcode2[20+1];		/* 読み込んだバーコード文字列 */
// } SND_BASKET_API_8_1;
//
// typedef struct
// {
// char			code[50];		/* 会員コード */
// } SND_MBR_API_8_1;
//
// typedef struct
// {
// long			type;			/* 支払い種別 */
// } SND_PAYTYP_API_8_1;
//
// typedef struct
// {
// char			url[256];			/* URL */
// char			paymentCode[20];		/* 精算機番号		*/
// char			startTime[19+1];		/* 買物開始時刻		*/
// long			companyCode;			/* 企業コード		*/
// char			companyName[50];		/* 企業名称		*/
// long			storeCode;			/* 店舗コード		*/
// char			storeName[50];			/* 店舗名称		*/
// SND_MBR_API_8_1		memberList[1];			/* 会員情報リスト 	*/
// char			subtotalRequestTime[19+1];	/* 小計リクエスト時間	*/
// char			receiptNum[API_LIST_MAX];	/* レシート番号		*/
// char			cartID[36];			/* ショッピングカートID	*/
// SND_PAYTYP_API_8_1	paymentTypeList[API_LIST_MAX];	/* 支払い情報		*/
// SND_BASKET_API_8_1	itemList[ITEM_MAX+1];		/* 商品リスト		*/
// } SND_API_8_1;
//
// typedef struct
// {
// char			code[50];		/* 会員コード	*/
// char			name[36];		/* 会員名	*/
// long			point;			/* 会員保有ポイント	*/
// long			addPoint;		/* 今回獲得ポイント、　追加ポイント	*/
// long			availableAmount;	/* 利用可能額	*/
// char			memberType[36];		/* 会員属性	*/
// } MBR_LIST_API;
//
// typedef struct
// {
// char			name[36];		/* 小計値下名称	*/
// long			discountPrice;		/* 小計値下金額	*/
// } SUBTTL_DISC_LIST;
//
// typedef struct
// {
// char			name[36];		/* 小計値上名称	*/
// long			servicePrice;		/* 小計値上金額	*/
// } SUBTTL_SERVICE_LIST;
//
// typedef struct
// {
// int			type;			/* 税タイプ	*/
// char			code[9+1];		/* 税コード	*/
// char			name[36];		/* 税名称	*/
// int			rate;			/* 税率		*/
// long			taxableAmout;		/* 課税対象額	*/
// long			amount;			/* 税額		*/
// } TAX_LIST_API;
//
// typedef struct
// {
// int			type;			/* 税タイプ	*/
// int			code;			/* 税コード	*/
// char			name[36];		/* 税名称	*/
// int			rate;			/* 税率		*/
// long			taxableAmout;		/* 課税対象額	*/
// long			amount;			/* 税額		*/
// } RCV_ITEM_TAXLIST_API_8_1;
//
// typedef struct
// {
// char		code[50];		/* 施策コード	*/
// char		name[20];		/* 施策名称	*/
// int		establishmentQuantity;	/* 成立個数	*/
// long		discountPrice;		/* 値下金額	*/
// } RCV_ITEM_DSCLIST_API_8_1;
//
// typedef struct
// {
// char		code[50];		/* 施策コード	*/
// char		name[20];		/* 施策名称	*/
// long		servicePrice;		/* 値上金額	*/
// int		establishmentQuantity;	/* 成立個数	*/
// } RCV_ITEM_SRVLIST_API_8_1;
//
// typedef struct
// {
// char				ID[36+1];			/* 商品判別ID			*/
// int				scanStatus;			/* 商品種別			*/
// char				barcode[20+1];			/* 読み込んだバーコード文字列	*/
// char				barcode2[20+1];			/* 読み込んだバーコード文字列	*/
// char				name[50];			/* 商品名			*/
// int				quantity;			/* 重量  or 個数		*/
// int				memberFlag;			/* 会員フラグ			*/
// long				price;				/* 商品単価			*/
// long				calculatedPrice;		/* 施策反映後商品価格		*/
// int				weightType;			/* 商品種別			*/
// char				unitOfMeasurement[5];		/* 測定単位			*/
// int				taxlist_max;			/* 税リストの最大数		*/
// RCV_ITEM_TAXLIST_API_8_1	taxList[API_LIST_MAX];		/* 税リスト			*/
// int				discountlist_max;		/* 小計値下リストの最大数	*/
// RCV_ITEM_DSCLIST_API_8_1	discountList[API_LIST_MAX];	/* かかっている値下施策のリスト	*/
// int				servicelist_max;		/* 値上施策リストの最大数	*/
// RCV_ITEM_SRVLIST_API_8_1	serviceList[API_LIST_MAX];	/* かかっている値上施策のリスト	*/
// } ITEMLIST_API;
//
// typedef struct
// {
// int             		result;					/* リザルトステータス		*/
// char				message[256+1];				/* メッセージ			*/
// RCV_BASKET_API_ERR_LIST		error_list[API_LIST_MAX];		/* エラーリスト			*/
// char				paymentCode[36+1];			/* 精算機番号			*/
// char				startTime[19+1];			/* 買物開始時刻			*/
// int				memberList_max;				/* 会員情報リストの最大数	*/
// MBR_LIST_API			memberList[API_LIST_MAX];		/* 会員情報リスト		*/
// char				subtotalRequestTime[19+1];		/* 小計リクエスト時間		*/
// char				receiptNum[API_LIST_MAX];		/* レシート番号			*/
// char				cartID[36];				/* ショッピングカートID		*/
// long				total;					/* 合計				*/
// long				subtotal;				/* 小計				*/
// int				totalQuantity;				/* 合計点数			*/
// long				totalDiscount;				/* 値下合計			*/
// long				itemTotalDiscount;			/* 商品値下合計			*/
// long				subTotalDiscount;			/* 小計値下合計			*/
// int				discountlist_max;			/* 小計値下リストの最大数	*/
// SUBTTL_DISC_LIST		subTotalDiscountList[API_LIST_MAX];	/* 小計値下リスト		*/
// long				totalService;				/* 値上合計			*/
// long				itemTotalService;			/* 商品値上合計			*/
// long				subTotalService;			/* 小計値上合計			*/
// int				subTotalServicelist_max;		/* 小計値上リストの最大数	*/
// SUBTTL_SERVICE_LIST		subTotalServiceList[API_LIST_MAX];	/* 小計値上合計リスト		*/
// long				taxAmount;				/* 税合計			*/
// int				taxlist_max;				/* 税リストの最大数		*/
// TAX_LIST_API			taxList[API_LIST_MAX];			/* 税リスト			*/
// int				itemList_max;				/* 選択商品リストの最大数	*/
// ITEMLIST_API			itemList[ITEM_MAX+1];			/* 選択商品リスト		*/
// long				totalRoundAmount;			/* 端数処理合計			*/
// } RCV_API_8_1;
//
// typedef struct
// {
// long			type;			/* 支払い種別	*/
// long			paymentCode;		/* 支払いコード	*/
// long			price;			/* 支払い金額	*/
// } SND_PAYTYP_API_9_1;
//
// typedef struct
// {
// char			url[256];				/* URL */
// char			paymentCode[36+1];			/* 精算機番号		*/
// char			startTime[19+1];			/* 買物開始時刻		*/
// MBR_LIST_API		memberList[1];				/* 会員情報リスト	*/
// char			subtotalRequestTime[19+1];		/* 小計リクエスト時間	*/
// char			receiptNum[API_LIST_MAX];		/* レシート番号		*/
// char			cartID[36];				/* ショッピングカートID	*/
// long			total;					/* 合計			*/
// long			subtotal;				/* 小計			*/
// int			totalQuantity;				/* 合計点数		*/
// long			totalDiscount;				/* 値下合計		*/
// long			itemTotalDiscount;			/* 商品値下合計		*/
// long			subTotalDiscount;			/* 小計値下合計		*/
// SUBTTL_DISC_LIST	subTotalDiscountList[API_LIST_MAX];	/* 小計値下リスト	*/
// long			totalService;				/* 値上合計		*/
// long			itemTotalService;			/* 商品値上合計		*/
// long			subTotalService;			/* 小計値上合計		*/
// SUBTTL_SERVICE_LIST	subTotalServiceList[API_LIST_MAX];	/* 小計値上合計リスト	*/
// long			taxAmount;				/* 税合計		*/
// int			taxlist_max;				/* 税リストの最大数	*/
// TAX_LIST_API		taxList[API_LIST_MAX];			/* 税リスト		*/
// ITEMLIST_API		itemList[ITEM_MAX+1];			/* 選択商品リスト	*/
// long			totalRoundAmount;			/* 端数処理合計		*/
// long			changeAmount;				/* お釣り		*/
// int			paymentType_max;			/* 支払い情報の最大数	*/
// SND_PAYTYP_API_9_1	paymentTypeList[API_LIST_MAX];		/* 支払い情報		*/
// int			cancelFlag;				/* キャンセルフラグ	*/
// } SND_API_9_1;
//
// typedef struct
// {
// int             	result;				/* リザルトステータス */
// char			message[256+1];			/* メッセージ */
// RCV_BASKET_API_ERR_LIST	error_list[API_LIST_MAX];	/* エラーリスト */
// char			cartID[36];			/* ショッピングカートID	*/
// } RCV_API_9_1;
//
// typedef struct
// {
// char				url[256];			/* URL */
// char	            		memberInfo[20];			/* PLUコード */
// } SND_API_10_1;
//
// typedef struct
// {
// int             		result;				/* リザルトステータス	*/
// char				message[256+1];			/* メッセージ		*/
// RCV_BASKET_API_ERR_LIST		error_list[API_LIST_MAX];	/* エラーリスト		*/
// char				memberCode[20];			/* 会員コード	*/
// char				name[50];			/* 会員名	*/
// long				point;				/* 会員保有ポイント	*/
// } RCV_API_10_1;
//
// typedef struct
// {
// long			type;				/* 1:特売　2:MM 3:SM 4:分類一括 5:値引 6:割引 7:売価変更値引 など	*/
// char			code[50];			/* 施策コード						*/
// char			name[20];			/* 施策名称						*/
// long			discountPrice;			/* 値下金額						*/
// } SND_API_FIXED_SALES_TOTALDISCOUNTLIST;
//
// typedef struct
// {
// long			type;				/* 0:外税、1:内税、2:非課税				*/
// double			rate;				/* 税率							*/
// long			taxPrice;			/* 税額							*/
// } SND_API_FIXED_SALES_TAXLIST;
//
// typedef struct
// {
// char			paymentName[DB_IMG_DATASIZE+1];	/* 支払い名称:現金、クレジット、品券・会計名称etc	*/
// long			paymentAmount;			/* 支払金額						*/
// } SND_API_FIXED_SALES_PAYMENTLIST;
//
// typedef struct
// {
// long			type;				/* 1:特売　2:MM 3:SM 4:分類一括 5:値引 6:割引 7:売価変更値引 など	*/
// char			code[50];			/* 施策コード						*/
// char			name[150+1];			/* 施策名称						*/
// long			discountPrice;			/* 値下金額						*/
// } SND_API_FIXED_SALES_ITEMDISCOUNTLIST;
//
// typedef struct
// {
// char			ID[36+1];			/* 商品判別ID						*/
// long			scanStatus;			/* 商品状態						*/
// char			barcode[20+1];			/* 読み込んだバーコード文字列				*/
// char			barcode2[20+1];			/* 読み込んだバーコード文字列				*/
// char			name[300+1];			/* 商品名（サイズはpos_nameにあわせる）		*/
// int			quantity;			/* 重量  or 個数					*/
// long			price;				/* 商品単価						*/
// int			itemDiscountList_max;
// SND_API_FIXED_SALES_ITEMDISCOUNTLIST	itemDiscountList[API_LIST_MAX];
// char			scanTime[19+1];			/* 商品スキャン時間					*/
// long			tax;				/* 税額							*/
// int				skip_flg;			/* スキップフラグ 				*/
// char			maintenanceStatus[10];			/* 精算機メンテナンス情報 */
// int				classNumber;			/* 小分類コード */
// } SND_API_FIXED_SALES_ITEMLIST;
//
// typedef struct
// {
// char			url[256];			/* URL */
// char			cartID[256];			/* ショッピングカートID					*/
// long			regiNo;				/* レジNo.						*/
// long			recieptNo;			/* レシートNo.						*/
// char			startTime[19+1];		/* 買い物開始時間					*/
// char			endTime[19+1];			/* レジでの買い物終了時間(レジ清算時間)			*/
// char			regiStartTime[19+1];		/* レジでの清算開始時間					*/
// char			fixedFlag[5+1];			/* "fixed"固定						*/
// long			subTotal;			/* 小計 外税を含まない、内税を含む値引き後の価格	*/
// long			totalInVat;			/* 税込金額						*/
// long			totalExVat;			/* 税抜金額						*/
// long			totalQuantity;			/* 数量合計						*/
// long			totalDiscountPrice;		/* 値引合計						*/
// int			totalDiscountList_max;		/* 値引き情報の最大数					*/
// SND_API_FIXED_SALES_TOTALDISCOUNTLIST	totalDiscountList[API_LIST_MAX];	/* 各種値引情報			*/
// long			totalTax;			/* 税合計						*/
// int			taxlist_max;			/* 税リストの最大数					*/
// SND_API_FIXED_SALES_TAXLIST		taxList[API_LIST_MAX];			/* 税詳細リスト 		*/
// int			paymentType_max;		/* 支払い情報の最大数					*/
// SND_API_FIXED_SALES_PAYMENTLIST		paymentList[API_LIST_MAX];		/* 支払い情報リスト		*/
// long			change;				/* お釣り						*/
// int			itemList_max;			/* 選択商品リストの最大数				*/
// SND_API_FIXED_SALES_ITEMLIST		itemList[ITEM_MAX+1];			/* 商品リスト 			*/
// } SND_API_FIXED_SALES;
//
// typedef struct
// {
// int             	result;				/* リザルトステータス */
// char			message[256+1];			/* メッセージ */
// RCV_BASKET_API_ERR_LIST	error_list[API_LIST_MAX];			/* エラーリスト */
// } RCV_API_FIXED_SALES;
//
// typedef struct
// {
// char			url[256];			/* URL */
// char			cartID[256];			/* ショッピングカートID					*/
// char			file_name[64];		/* ファイル名 */
// } MAKE_API;
//
// typedef struct
// {
// int			order;				/* オーダー */
// char			url[256];			/* URL */
// SND_API_4_2		snd_api_4_2;
// RCV_API_4_2		rcv_api_4_2;
// SND_API_4_7		snd_api_4_7;
// RCV_API_4_7		rcv_api_4_7;
// SND_API_4_9		snd_api_4_9;
// RCV_API_4_9		rcv_api_4_9;
// SND_API_6_1		snd_api_6_1;
// RCV_API_6_1		rcv_api_6_1;
// SND_API_7_1		snd_api_7_1;
// RCV_API_7_1		rcv_api_7_1;
// SND_API_8_1		snd_api_8_1;
// RCV_API_8_1		rcv_api_8_1;
// SND_API_9_1		snd_api_9_1;
// RCV_API_9_1		rcv_api_9_1;
// SND_API_10_1		snd_api_10_1;
// RCV_API_10_1		rcv_api_10_1;
// SND_API_FIXED_SALES	snd_api_fixed_sales;
// RCV_API_FIXED_SALES	rcv_api_fixed_sales;
// MAKE_API		make_api_4_9;
// RCV_API_4_9		make_rcv_api_4_9;
// MAKE_API		make_api_fixed_sales;
// RCV_API_FIXED_SALES	make_rcv_api_fixed_sales;
// int             	test_srv_flg;			/* テストサーバー接続 しない/する */
// char			api_key[44+1];			/* レジ固有番号 */
// char			stre_token[44+1];		/* 通信キー */
// char			reg_ver[15+1];			/* レジバージョン */
// char			submst_ver[15+1];		/* サブマスタ */
// long			companyCode;			/* 企業コード */
// long			storeCode;			/* 店舗コード */
// CURLcode		res;				/* データレスポンス */
// long			res_code;			/* レスポンスコード */
// short			server_timeout;			/* レスポンスコード */
// short			thread_timeout;			/* 実績送信スレッド接続タイムアウト */
// char			proxy[46];			/* Shop&Go Proxyサーバー ホスト名 */
// long			proxy_port;			/* Shop&Go Proxyサーバー ポート番号 */
// } RX_TASKSTAT_BASKET_SERVER;
//
// /*-----  スキャナタスクステータス  -----*/
// typedef struct {
// double		stime;
// short		status;
// short		scan_flg;
// }RX_TASKSTAT_SCAN;
//
// /*-----  スキャナタスクステータス  -----*/
// typedef struct {
// double		ttime;
// short		status;
// }RX_TASKSTAT_TOUCH;
//
// /*----- dポイントタスクステータス -----*/
// typedef struct {
// short			order;
// short			sub;
// short			stat;
// short			tr_mode_flg;
// long			tr_ttl_point;
// RXMEM_DPOINT_TX		tx_data;
// RXMEM_DPOINT_RX		rx_data;
// } RX_TASKSTAT_DPOINT;
//
// /*----- 電子メール送信タスクステータス -----*/
// typedef struct {
// short	status;			/* タスク状態 0:未起動, 1:起動 */
// short	unsent;			/* 未送信データ処理結果 */
// } RX_TASKSTAT_MAIL_SENDER;
//
// /*----- 楽天ポイントタスクステータス -----*/
// typedef	struct {
// short			order;
// short			sub;
// short			stat;
// RXMEM_RPOINT_REQ	req;
// RXMEM_RPOINT_REC	rec;
// } RX_TASKSTAT_RPOINT;
//
// /*----- PCT端末通信タスクステータス -----*/
// typedef struct {
// short				ctr;
// short				order;		// 要求状態
// short				sub;		// 通信区分
// short				stat;		// ステータス
// RXMEM_PCT_TX			tx_data;	// リクエスト
// RXMEM_PCT_RX			rx_data;	// レスポンス
// } RX_TASKSTAT_PCT;
//
// /*----- Tポイントタスクステータス -----*/
// typedef	struct {
// short			order;
// short			sub;
// short			stat;
// RXMEM_TPOINT_REQ	req;
// RXMEM_TPOINT_REC	rec;
// } RX_TASKSTAT_TPOINT;
//
// /*----- 電子レシートタスクステータス -----*/
// typedef struct {
// short	status;			/* タスク状態 0:未起動, 1:起動 */
// short	unsent;			/* 未送信データ処理結果 */
// } RX_TASKSTAT_NET_RECEIPT;
//
// /*----- 友の会IFタスクステータス -----*/
// typedef struct {
//
// // タスク制御用
// short			status;		/* タスク状態 0:未起動, 1:起動 */
// short			order;		// 実行区分 TOMOIF_ORDER_XXX
// short			procID;		// 処理区分 TOMOIF_PROC_XXX
//
// // API入出力用バッファ
// TOMOIF_STATUS		ConSts;		// 通信結果
// TOMOIF_CNF_REQ		CnfReq;		// 残高照会用入力バッファ
// TOMOIF_CNF_ANS		CnfAns;		// 残高照会用出力バッファ
// TOMOIF_USE_REQ		UseReq;		// カード利用入力バッファ
// TOMOIF_USE_ANS		UseAns;		// カード利用出力バッファ
// } RX_TASKSTAT_TOMOIF;
//
// /*----- フレスタ様タスクステータス -----*/
// typedef struct {
// short		order;	// 実行区分
// short		sub;	// 処理区分
// short		stat;	// タスク状態
//
// RXMEMCUSTREAL_FRESTA_DATA	data;	// 通信時の情報
// } RX_TASKSTAT_CUSTREAL_FRESTA;
//
// /*----- EE社 AIBOX通信タスクステータス -----*/
// typedef struct {
// short				code;		// ステータスコード(101～112)
// int				totalQuantiity;	// 合計点数(コード107用)
// int				timestamp;	// UNIX TIME
// uchar				msg;		// ステータスに準じたメッセージ
// int				state;		// AIBOX通信タスクの状態を他タスクに通知する(0:nouse, 1:use, -1:err)
// // ステータス使用タスク → スキャンドライバ, 登録タスク
// } RX_TASKSTAT_AIBOX;
//
// /*----- 特定コスメ1仕様（アイスタイルリテイル）様向けタスクステータス -----*/
// typedef struct {
// short			status;		// タスク状態
// short			order;		// タスク間I/F状態
// short			result;		// 要求実行結果
// ISTYLE_REQUEST_INF	request_inf;	// 要求内容
// ISTYLE_RESPONS_INF	response_inf;	// 要求結果
// } RX_TASKSTAT_COSME_ISTYLE;
//
// /**********************************************************************
//     MENTE CLIENT COMMUNICATION COMMON MEMORY
//  ***********************************************************************/
// #define MNTCLT_IPMAX	21
// #define MNTCLT_TBLMAX	65
// #define	MNTCLT_SQLMAX	6001
// #define	MNTCLT_SVRMAX	2	// Master and Sub
// typedef struct {
// RX_CTRL		Ctrl;		/* ヘッダ情報 */
// short		err_no;
// char		ipadr[MNTCLT_IPMAX];
// char		tbl_name[MNTCLT_TBLMAX];
// char		sql[MNTCLT_SQLMAX];
// int		spqc_offline[MNTCLT_SVRMAX];	// 0: ONLINE 1: OFFLINE
// int		spqc_reg;
// int		spqc_tr_reg;
// int		spqc_all;
// int		spqc_tr_all;
// int		spqc_twocnct_chk;	// ２台連結２人制のチェッカー表示更新用
// int		spqc_twocnct_reg;	// ２台連結２人制の呼出されていない登録数
// int		spqc_twocnct_tr_reg;	// ２台連結２人制の呼出されていない登録数 (訓練)
// int		spqc_use_svr;		// 0: Master 1: Sub  件数確認や問い合わせ先などで優先されるサーバー
// } RX_MNTCLT;
//
// /*-----  タスクステータス  -----*/
// typedef struct {
// RX_CTRL				Ctrl;
// int					syst;
// RX_TASKSTAT_CHK		chk;
// RX_TASKSTAT_CASH	cash;
// RX_TASKSTAT_SPL		spl;
// RX_TASKSTAT_UPD		upd;
// RX_TASKSTAT_PRN		print;
// RX_TASKSTAT_MUPD	mupd;
// int					hist;
// RX_TASKSTAT_DRW		drw;
// RX_TASKSTAT_ACX		acx;
// RX_TASKSTAT_JPO         jpo;
// RX_TASKSTAT_SUICA	suica;
// RX_TASKSTAT_SCL		scl;
// RX_TASKSTAT_RWC		rwc;
// RX_TASKSTAT_STROPN	stropn;
// RX_TASKSTAT_SGSCL1	sgscl1;
// RX_TASKSTAT_SGSCL2	sgscl2;
// RX_TASKSTAT_BUPD	bupd;
// RX_TASKSTAT_HQHIST	hqhist;
// RX_TASKSTAT_MANAGEPC	managepc;
// //	RX_TASKSTAT_PRN		stpr;
// RX_TASKSTAT_STPR		stpr;
// RX_TASKSTAT_SOUND       sound;
// #if (MC_SYSTEM || SEGMENT)
// RX_TASKSTAT_MCFTP       mcftp;
// #endif
// RX_TASKSTAT_S2PRN		s2pr;
// #if CN_NSC
// RX_TASKSTAT_BANK         bankprg;
// #endif
// RX_TASKSTAT_EJCONF		ejconf;
// RX_TASKSTAT_MP1			mp1;
// RX_TASKSTAT_UPDCON	upd_con;
// RX_TASKSTAT_MULTI	multi;
// RX_TASKSTAT_ICC		icc;
// RX_TASKSTAT_CUSTREAL	custreal;
// RX_TASKSTAT_MSR		msr;
// RX_TASKSTAT_CUSTREAL2	custreal2;
// RX_TASKSTAT_NETDOA      custreal_netdoa;
// #if FB_FENCE_OVER
// int					fence_over_stop;
// int					fence_over_ctrl;
// #endif
// int					fence_over_act;		/* 2014.09.09  FENCE_OVERタスク起動中フラグ 0:起動中ではない 1:起動中 */
// RX_MNTCLT		mente;
// RX_QCCONNECT		qcconnect;
// RX_TASKSTAT_MOVIESEND	movsend;
// RX_TASKSTAT_NTTDPRECA	nttd_preca;
// RX_TASKSTAT_NECCUATREAL custreal_nec;
// RX_TASKSTAT_MASR	masr;
// RX_TASKSTAT_PRN		qcjc_c_print;
// RX_TASKSTAT_DRW		qcjc_c_drw;
// RX_TASKSTAT_SQRC        sqrc;
// RX_TASKSTAT_TRKPRECA	trk_preca;
// RX_TASKSTAT_REPICA	repica;
// RX_TASKSTAT_COGCA	cogca;
// int			desktop_chktab_ctrl;
// RX_TASKSTAT_PRN		kitchen1_print;		/* キッチンプリンタ接続仕様 */
// RX_TASKSTAT_DRW		kitchen1_drw;
// RX_TASKSTAT_PRN		kitchen2_print;
// RX_TASKSTAT_DRW		kitchen2_drw;
// RX_TASKSTAT_PRN_COM	print_com;	/* 印字プロセス */
// RX_TASKSTAT_BCDPAY	bcdpay;
// RX_TASKSTAT_VEGA	vega;
// RX_TASKSTAT_BASKET_SERVER	basket_server;
// RX_TASKSTAT_SCAN	scan;
// RX_TASKSTAT_TOUCH	touch;
// RX_TASKSTAT_DPOINT	dpoint;
// RX_TASKSTAT_AJS_EMONEY	ajs_emoney;
// RX_TASKSTAT_TAXFREE	taxfree;
// RX_TASKSTAT_MAIL_SENDER	mail_sender;
// RX_TASKSTAT_PRN		dummy_print;
// RX_TASKSTAT_DRW		dummy_drw;
// RX_TASKSTAT_VALUECARD	valuecard;
// RX_TASKSTAT_RPOINT	rpoint;
// RX_TASKSTAT_PCT		pct;		/* PCT端末通信 */
// RX_TASKSTAT_TPOINT	tpoint;
// RX_TASKSTAT_UPDZIP      updzip;
// RX_TASKSTAT_NET_RECEIPT	net_receipt;		/* 電子レシート仕様 */
// RX_TASKSTAT_TOMOIF      tomoIF;
// RX_TASKSTAT_CUSTREAL_FRESTA	fresta;		/* フレスタ仕様 */
// RX_TASKSTAT_AIBOX	aibox;			/* AIBOX通信 */
// RX_TASKSTAT_COSME_ISTYLE	cosme_istyle;	// 特定コスメ1仕様（アイスタイルリテイル）
// } RX_TASKSTAT_BUF;
//
//
// /**********************************************************************
//     入力情報
//  ***********************************************************************/
//
// typedef struct {
// RX_CTRL		Ctrl;		/* ヘッダ情報 */
// RX_DEV_INF	DevInf;		/* デバイス情報 */
// short		hard_key;	/* ハードキーコード */
// short		fnc_code;	/* ファンクションコード */
// long		smlcls_cd;	/* 小分類コード */
// short		app_grp_cd;	/* アプリケーショングループコード */
// RX_REGSINST		inst;	/* 開始/終了指示(チェッカー/キャッシャー) */
// } RX_INPUT_BUF;
//
//
// /**********************************************************************
//     印字ステータス
//  ***********************************************************************/
//
// typedef struct {
// RX_CTRL		Ctrl;		/* ヘッダ情報 */
// RX_DEV_INF	DevInf;		/* デバイス情報 */
// } RX_PRN_STAT;
//
// /**********************************************************************
//     SOCKET通信用共通メモリ
//  ***********************************************************************/
//
// #define	SOCKET_MAX	2000
// typedef struct {
// RX_CTRL		Ctrl;		  /* ヘッダ情報           */
// short		order;		  /* 1:クレジット要求電文 */
// /* 2:クレジット請求電文 */
// /* 3:会計実績電文       */
// /* 4:クレジット応答電文（受信終了） */
// short		err_no;		  /* エラー情報           */
// char		data[SOCKET_MAX]; /* 電文データ（送受信） */
// char		corr_cd[16];	  /* クレジット訂正用カード番号 */
// } RX_SOCKET;
//
// /**********************************************************************
//     音声タスク通信用共通メモリ
//  ***********************************************************************/
// typedef struct {
// RX_CTRL         Ctrl;
// short   Where;
// short   mode;
// uchar   SoundFilePath[128];
// } RX_SOUND_STAT;
//
// /**********************************************************************
//     updzip通信用共通メモリ
//  ***********************************************************************/
// typedef struct {
// RX_CTRL         Ctrl;
// short   stat;
// uchar   UpdFilePath[128];
// uchar   ZipFilePath[128];
// } RX_UPDZIP_STAT;
//
// /**********************************************************************
//     電子メール送信処理用共有メモリ
//  ***********************************************************************/
// typedef struct {
// RX_CTRL		Ctrl;			/* ヘッダ情報           */
// short		order;			/* 要求内容             */
// short		err_no;			/* エラー情報           */
// char		data[512];		/* 付加情報             */
// } RX_MAIL_SENDER;
//
// typedef enum {
// EMAILSEND_ORDER_IDLE = 0,			// アイドル（内部イベント）
// EMAILSEND_ORDER_EDIT,			// 編集（実績発生）
// EMAILSEND_ORDER_CLOSE_SEND,		// 閉設時の未送データ送信
// EMAILSEND_ORDER_USETUP_SEND,		// ユーザーセットアップからの未送データ送信
// EMAILSEND_ORDER_APSEND,			// リクエスト実行（内部イベント）
// } RX_MAIL_SENDER_EVENT_ORDER;
//
// typedef enum {
// MAIL_UNSNTRES_IDLE = 0,			// アイドル（内部イベント）
// MAIL_UNSNTRES_REQUEST,			// 要求中
// MAIL_UNSNTRES_EXEC,				// 実行中
// MAIL_UNSNTRES_RESULT_NORMAL,			// 処理結果正常（未送なし）
// MAIL_UNSNTRES_RESULT_OFFLINE,		// 処理結果異常（送信失敗）
// MAIL_UNSNTRES_RESULT_ERROR,			// 処理結果異常（送信異常）
// } RX_MAIL_SENDER_UNSENT_RESULT;
//
// /**********************************************************************
//     電子レシート処理用共有メモリ
//  ***********************************************************************/
// typedef struct {
// RX_CTRL		Ctrl;			/* ヘッダ情報           */
// short		order;			/* 要求内容             */
// short		err_no;			/* エラー情報           */
// char		data[512];		/* 付加情報             */
// } RX_NET_RECEIPT;
//
// typedef enum {
// ENRCPT_ORDER_IDLE = 0,			// アイドル（内部イベント）
// ENRCPT_ORDER_EDIT,			// 編集（実績発生）
// ENRCPT_ORDER_CLOSE_SEND,		// 閉設時の未送データ送信
// ENRCPT_ORDER_USETUP_SEND,		// ユーザーセットアップからの未送データ送信
// ENRCPT_ORDER_APSEND,			// リクエスト実行（内部イベント）
// } RX_NET_RECEIPT_EVENT_ORDER;
//
// typedef enum {
// UNSNTRES_IDLE = 0,			// アイドル（内部イベント）
// UNSNTRES_REQUEST,			// 要求中
// UNSNTRES_EXEC,				// 実行中
// UNSNTRES_RESULT_NORMAL,			// 処理結果正常（未送なし）
// UNSNTRES_RESULT_OFFLINE,		// 処理結果異常（送信失敗）
// UNSNTRES_RESULT_ERROR,			// 処理結果異常（送信異常）
// } RX_NET_RECEIPT_UNSENT_RESULT;
//
//
// /**********************************************************************
//     共通メモリ定義
//  ***********************************************************************/
//
// /*-----  共有メモリインデックス  -----*/
// typedef enum {
// RXMEM_COMMON = 0,			/* 全タスク共通メモリ */
// RXMEM_STAT,					/* タスクステータス */
// RXMEM_CHK_INP,				/* チェッカー入力情報 */
// RXMEM_CASH_INP,				/* キャッシャー入力情報 */
// RXMEM_CHK_RCT,				/* チェッカーレシートバッファ */
// RXMEM_CASH_RCT,				/* キャッシャーレシートバッファ */
// RXMEM_UPD_RCT,				/* 実績加算レシートバッファ */
// RXMEM_PRN_RCT,				/* レシート印字レシートバッファ */
// RXMEM_PRN_STAT,				/* 印字ステータスバッファ */
// RXMEM_CHK_CASH,				/* 割込入力情報 */
// RXMEM_ACX_STAT,				/* ACXステータスバッファ */
// RXMEM_JPO_STAT,			        /* JPOステータスバッファ */
// RXMEM_SOCKET,			        /* SOCKET通信用共通メモリ */
// RXMEM_SCL_STAT,				/* SCLステータスバッファ */
// RXMEM_RWC_STAT,				/* RWCステータスバッファ */
// RXMEM_STROPNCLS,			/* 開閉設入力情報 */
// RXMEM_SGSCL1_STAT,			/* セルフゲートSCL1ステータスバッファ */
// RXMEM_SGSCL2_STAT,			/* セルフゲートSCL2ステータスバッファ */
// RXMEM_PROCINST,				/* PROCESS CONTROL 入力情報 */
// RXMEM_ANOTHER1,				/* another1入力情報 */
// RXMEM_ANOTHER2,				/* another2入力情報 */
// RXMEM_PMOD,				/* pmod情報 */
// RXMEM_SALE,				/* sale_com_mm情報 */
// RXMEM_REPT,				/* report情報 */
// RXMEM_STPR_RCT,				/* ステーションプリンタ印字レシートバッファ */
// RXMEM_STPR_STAT,				/* 印字ステータスバッファ */
// RXMEM_MNTCLT,				/* menteclient information */
// RXMEM_SOUND,                /* 音声情報(卓上部) */
// RXMEM_S2PR_RCT,				/* ステーションプリンタ印字レシートバッファ */
// RXMEM_S2PR_STAT,				/* 印字ステータスバッファ */
// RXMEM_BANK_STAT,			/* BANKステータスバッファ */
// RXMEM_NSC_RCT,				/* BANKレシートバッファ */
// #if FB_FENCE_OVER
// RXMEM_FENCE_OVER,			/* FenceOver入力情報 */
// #endif
// RXMEM_SOUND2,               /* 音声情報(タワー部) */
// RXMEM_SUICA_STAT,			/* SUICAステータスバッファ */
// RXMEM_ACXREAL,				/* 釣銭釣札機リアル問い合わせ処理 */
// RXMEM_MP1_RCT,				/* MP1印字レシートバッファ */
// RXMEM_MULTI_STAT,			/* MULTIステータスバッファ */
// RXMEM_CUSTREAL_STAT,			/* 顧客リアルステータスバッファ */
// RXMEM_CUSTREAL_SOCKET,			/* 顧客リアルSOCKET通信用共通メモリ */
// RXMEM_QCCONNECT_STAT,			/* QcConnectステータスバッファ */
// RXMEM_CREDIT_SOCKET,			/* クレジットSOCKET通信用共通メモリ */
// RXMEM_CUSTREAL_NECSOCKET,	        /* NEC SOCKET通信用共通メモリ */
// RXMEM_MASR_STAT,			/* 自走式磁気リーダ */
// RXMEM_CASH_RECYCLE,			/* キャッシュリサイクル */
// RXMEM_QCJC_C_PRN_RCT,			/* レシート印字レシートバッファ */
// RXMEM_QCJC_C_PRN_STAT,			/* 印字ステータスバッファ */
// RXMEM_SQRC,                             /* SQRC Ticket */
// RXMEM_KITCHEN1_PRN_RCT,			/* レシート印字レシートバッファ(Kitchen1) */
// RXMEM_KITCHEN1_PRN_STAT,		/* 印字ステータスバッファ(Kitchen1) */
// RXMEM_KITCHEN2_PRN_RCT,			/* レシート印字レシートバッファ(Kitchen2) */
// RXMEM_KITCHEN2_PRN_STAT,		/* 印字ステータスバッファ(Kitchen2) */
// RXMEM_MAIL_SENDER,			/* 電子メール送信 */
// RXMEM_DUMMY_PRN_RCT,			/* レシート印字レシートバッファ(ダミー) */
// RXMEM_DUMMY_PRN_STAT,			/* 印字ステータスバッファ(ダミー) */
// RXMEM_NET_RECEIPT,			/* 電子レシート処理 */
// RXMEM_HI_TOUCH,				/* ハイタッチ受信 */
// #if FB_FENCE_OVER
// #if RF1_SYSTEM
// RXMEM_FENCE_OVER_2,			/* FenceOver入力情報 フェンスオーバー化対応 */
// #endif //if RF1_SYSTEM
// #endif
// RXMEM_TBLMAX,				/*  */
// } RXMEM_IDX;
//
// /*-----  共有メモリ関数の戻り値  -----*/
// #define RXMEM_OK		0			/* 正常終了 */
// #define RXMEM_NG		-1			/* 異常終了 */
//
// #define RXMEM_DATA_ON	RXMEM_OK	/* データあり */
// #define RXMEM_DATA_OFF	1			/* データなし */
//
// /*-----  プロトタイプ宣言  -----*/
// int rxMemGet(RXMEM_IDX idx);
// int rxMemGetAll(void);
// int rxMemDataChk(RXMEM_IDX idx);
// int rxMemRead(RXMEM_IDX idx, void *buf);
// int rxMemWrite(RXMEM_IDX idx, void *buf);
// int rxMemPtr(RXMEM_IDX idx, void **ptr);
// int rxMemClr(RXMEM_IDX idx);
// int rxMemFree(RXMEM_IDX idx);
// int rxMemDelAll(void);
// RX_TASKSTAT_PRN *STAT_print_get(RX_TASKSTAT_BUF *tsBuf);
// RX_TASKSTAT_PRN *STAT_print_get_did(RX_TASKSTAT_BUF *tsBuf, UINT32 did);
// RX_TASKSTAT_DRW *STAT_drw_get(RX_TASKSTAT_BUF *tsBuf);
// RX_TASKSTAT_DRW *STAT_drw_get_did(RX_TASKSTAT_BUF *tsBuf,UINT32 did);
//
// // オペモードフラグのNo.リスト
// typedef	enum
// {
// OPE_MODE_REG		= 1000,		// 登録モード (旧: 1)
// OPE_MODE_REG_SP_TCKT	= 1100,		// お会計券 (登録モード) (旧: 41, item7)
// OPE_MODE_REG_QC_SPLIT	= 1200,		// QCashierスプリット (登録モード) (旧: 51, item7)
// OPE_MODE_REG_DUMMY	= 1300,		//
// OPE_MODE_TRAINING	= 2000,		// 訓練モード (旧: 2)
// OPE_MODE_TRAINING_SP_TCKT	= 2100,	// お会計券 (訓練モード) (旧: 42, item7)
// OPE_MODE_TRAINING_QC_SPLIT	= 2200,	// QCashierスプリット (登録モード) (旧: 52, item7)
// OPE_MODE_TRAINING_DUMMY		= 2300,	//
// OPE_MODE_VOID		= 3000,		// 訂正モード (旧: 3)
// OPE_MODE_VOID_SP_TCKT	= 3100,		// お会計券 (訓練モード) (旧: 43, item7)
// OPE_MODE_VOID_QC_SPLIT	= 3200,		// QCashierスプリット (登録モード) (旧: 53, item7)
// OPE_MODE_VOID_DUMMY	= 3300,		//
// OPE_MODE_SCRAP		= 4000,		// 廃棄モード (旧: 4)
// OPE_MODE_ORDER		= 5000,		// 発注モード (旧: 17, item7)
// OPE_MODE_STOCKTAKING	= 6000,		// 棚卸モード (旧: 18, item8)
// OPE_MODE_OFFICIAL_RCPT = 6100,	// 61.領収書 (登録モード)
// OPE_MODE_OFFICIAL_RCPT_TR = 6200,	// 62.領収書 (訓練モード)
// OPE_MODE_PRODUCTION	= 7000,		// 生産モード (旧: 24, item9)
// OPE_MODE_STAFF_OPN	= 11000,	// 従業員オープン (旧: 70)
// OPE_MODE_STAFF_CLS	= 12000,	// 従業員クローズ (旧: 11)
// OPE_MODE_FLASH_REPT	= 13000,	// 売上速報 (旧: 15)
// OPE_MODE_CHECK_REPT	= 14000,	// 売上点検 (旧: 7)
// OPE_MODE_FINISH_REPT	= 15000,	// 売上精算 (旧: 8)
// OPE_MODE_LOGIN		= 16000,	// ログイン コメリ仕様 (旧: 30)
// OPE_MODE_SETUP		= 17000,	// 設定 (旧: 9)
// OPE_MODE_PRC_CHANGE	= 18000,	// 売価変更 (旧: 10)
// OPE_MODE_RESERV_REPT	= 19000,	// 予約レポート
// OPE_MODE_USER_SETUP	= 20000,	// ユーザーセットアップ (旧: 13)
// OPE_MODE_STORE_OPN	= 21000,	// 開設 (旧: 12)
// OPE_MODE_STORE_CLS	= 22000,	// 閉設 (旧: 12)
// OPE_MODE_CLOSE_LINE	= 23000,	// 締め精算処理：区切り線として利用し、実績はなし
// OPE_MODE_CNCT_INFO	= 40000,	// 接続情報
// OPE_MODE_RESERV_RG	= 61000,	// 予約モード（登録）（旧：60)
// OPE_MODE_RESERV_TR	= 62000,	// 予約モード（訓練）（旧：60)
// OPE_MODE_MBR_UNLOCK	= 81000,	// 会員情報ロック解除実績
// OPE_MODE_MODE_END	= 82000,	// モード終了 (旧: 85)
// OPE_MODE_MODE_START	= 83000,	// モード開始 (旧: 86)
// OPE_MODE_MENTE		= 99000,	// メンテナンス (旧: 5)
// OPE_MODE_SPEC_SETUP	= 99100,	// スペックファイル設定
// OPE_MODE_INIT		= 99200,	// ファイル初期設定 (旧: 16)
// OPE_MODE_STRCLS_INFO	= 99300,	// 精算情報
//
// /*
// 	OPE_MODE_MENTE,		//  5.メンテナンス
// 	OPE_MODE_CONFIRM,		//  6.ファイル確認
// 	OPE_MODE_CARD_MENTE,		// 14.カード保守
// 	OPE_MODE_WORK_ABSENCE,	// 19.勤怠
// 	OPE_MODE_REG_START,		// 20.通常登録開始
// 	OPE_MODE_SELF_START,		// 21.セルフ登録開始
// 	OPE_MODE_REG_END,		// 22.登録終了
// 	OPE_MODE_DEPOSIT_WD,		// 23.その他入出金
// 	OPE_MODE_RECIEV_AGENT,	// 25.収納代行
//
// 	OPE_MODE_MONEY_CHG,		// 31.両替 (通常)	    〃
// 	OPE_MODE_MONEY_CHG_TR,	// 32.両替 (教育)	    〃
// 	OPE_MODE_PRINCIPAL,		// 33.元金登録 (通常)	    〃
// 	OPE_MODE_PRINCIPAL_TR,	// 34.元金登録 (教育)	    〃
// 	OPE_MODE_PRINCIPAL_VD,	// 35.元金登録 (訂正)	    〃
// 	OPE_MODE_AMOUNT_INV,		// 36.在高登録 (通常)	    〃
// 	OPE_MODE_AMOUNT_INV_TR,	// 37.在高登録 (教育)	    〃
// 	OPE_MODE_AMOUNT_INV_FN,	// 38.在高登録 (精算)	    〃
//
// 	OPE_MODE_SP_TCKT = 41,	// 41.お会計券 (登録モード)
// 	OPE_MODE_SP_TCKT_TR,		// 42.お会計券 (訓練モード)
// 	OPE_MODE_SP_TCKT_VD,		// 43.お会計券 (訂正モード)
//
// 	OPE_MODE_QC_SPLIT_TR,		// 52.QCashierスプリット (訓練モード)
//
// 	OPE_MODE_RESERVE = 60,	// 60.予約
// 	OPE_MODE_OFFICIAL_RCPT_VD,	// 63.領収書 (訂正モード)
//
// 	OPE_MODE_STAFF_OPN = 70,	// 70.従業員オープン
// 	OPE_MODE_REG_OFF,		// 71.休止
//
// 	OPE_MODE_RE_PRINT_RCPT = 81,	// 81.再発行 (登録モード)
// 	OPE_MODE_RE_PRINT_RCPT_TR,	// 82.再発行 (訓練モード)
// 	OPE_MODE_RE_PRINT_RCPT_VD,	// 83.再発行 (訂正モード)
// */
//
//
// } OPE_MODE_FLAG_LIST;
//

// 上位からのコピー動作中の状態
///  関連tprxソース: rxmem.h - COPY_HOST_LOCK_STATUS
enum CopyHostLockStatus {
  COPY_SIMS_LOCK_OFF(0), // テーブルコピー中ではない
  COPY_SIMS_LOCK_ON(1); // テーブルコピー中

  const CopyHostLockStatus(this.value);

  final int value;
 }

//
// typedef struct {
// int CNCT_RCT_ONOFF;
// int CNCT_ACR_ONOFF;
// int CNCT_ACR_CNCT;
// int CNCT_CARD_CNCT;
// int CNCT_ACB_DECCIN;
// int CNCT_RWT_CNCT;
// int CNCT_SCALE_CNCT;
// int CNCT_ACB_SELECT;
// int CNCT_IIS21_CNCT;
// int CNCT_MOBILE_CNCT;
// int CNCT_STPR_CNCT;
// int CNCT_NETWLPR_CNCT;
// int CNCT_POPPY_CNCT;
// int CNCT_TAG_CNCT;
// int CNCT_AUTO_DECCIN;
// int CNCT_S2PR_CNCT;
// int CNCT_PWRCTRL_CNCT;
// int CNCT_CATALINAPR_CNCT;
// int CNCT_DISH_CNCT;
// int CNCT_CUSTREALSVR_CNCT;
// int CNCT_AIVOICE_CNCT;
// int CNCT_GCAT_CNCT;
// int CNCT_SUICA_CNCT;
// int CNCT_MP1_CNCT;
// int CNCT_REALITMSEND_CNCT;
// int CNCT_GRAMX_CNCT;
// int CNCT_RFID_CNCT;
// int CNCT_MSG_FLG;
// int CNCT_MULTI_CNCT;
// int CNCT_JREM_CNCT;
// int CNCT_COLORDSP_CNCT;
// int CNCT_USBCAM_CNCT;
// int CNCT_MASR_CNCT;
// int CNCT_BRAINFL_CNCT;
// int CNCT_CAT_JMUPS_TWIN_CNCT;
// int CNCT_SQRC_CNCT;
// int CNCT_CUSTREAL_PQS_NEW_SEND;
// int CNCT_EFFECT;
// int CNCT_ICCARD_CNCT;		/* 2015/02/02 */
// int CNCT_COLORDSP_SIZE;
// int CNCT_RCPT_CNCT;
// int CNCT_APBF_CNCT;
// int CNCT_HITOUCH_CNCT;
// int CNCT_AMI_CNCT;
// } RC_CNCT_LISTS;
//
// typedef struct {
// int RECOG_MEMBERSYSTEM;
// int RECOG_MEMBERPOINT;
// int RECOG_MEMBERFSP;
// int RECOG_CREDITSYSTEM;
// int RECOG_SPECIAL_RECEIPT;
// int RECOG_DISC_BARCODE;
// int RECOG_IWAISYSTEM;
// int RECOG_SELF_GATE;
// int RECOG_SYS_24HOUR;
// int RECOG_VISMACSYSTEM;
// int RECOG_HQ_ASP;
// int RECOG_JASAITAMA_SYS;
// int RECOG_PROMSYSTEM;
// int RECOG_EDYSYSTEM;
// int RECOG_FRESH_BARCODE;
// int RECOG_SUGI_SYS;
// int RECOG_HESOKURISYSTEM;
// int RECOG_GREENSTAMP_SYS;
// int RECOG_COOPSYSTEM;
// int RECOG_POINTCARDSYSTEM;
// int RECOG_MOBILESYSTEM;
// int RECOG_HQ_OTHER;
// int RECOG_REGCONNECTSYSTEM;
// int RECOG_CLOTHES_BARCODE;
// int RECOG_FJSS;
// int RECOG_MCSYSTEM;
// int RECOG_NETWORK_PRN;
// int RECOG_POPPY_PRINT;
// int RECOG_TAG_PRINT;
// int RECOG_TAURUS;
// int RECOG_NTT_ASP;
// int RECOG_EAT_IN;
// int RECOG_MOBILESYSTEM2;
// int RECOG_MAGAZINE_BARCODE;
// int RECOG_HQ_OTHER_REAL;
// int RECOG_PW410SYSTEM;
// int RECOG_NSC_CREDIT;
// int RECOG_SKIP_2_18;
// int RECOG_HQ_PROD;
// int RECOG_FELICASYSTEM;
// int RECOG_PSP70SYSTEM;
// int RECOG_NTT_BCOM;
// int RECOG_CATALINASYSTEM;
// int RECOG_PRCCHKR;
// int RECOG_DISHCALCSYSTEM;
// int RECOG_ITF_BARCODE;
// int RECOG_CSS_ACT;
// int RECOG_CUST_DETAIL;
// int RECOG_CUSTREALSVR;
// int RECOG_SUICA_CAT;
// int RECOG_YOMOCASYSTEM;
// int RECOG_SMARTPLUSSYSTEM;
// int RECOG_DUTY;
// int RECOG_ECOASYSTEM;
// int RECOG_ICCARDSYSTEM;
// int RECOG_SUB_TICKET;
// int RECOG_QUICPAYSYSTEM;
// int RECOG_IDSYSTEM;
// int RECOG_REVIVAL_RECEIPT;
// int RECOG_QUICK_SELF;
// int RECOG_QUICK_SELF_CHG;
// int RECOG_ASSIST_MONITOR;
// int RECOG_MP1_PRINT;
// int RECOG_REALITMSEND;
// int RECOG_RAINBOWCARD;
// int RECOG_GRAMX;
// int RECOG_MM_ABJ;
// int RECOG_CAT_POINT;
// int RECOG_TAGRDWT;
// int RECOG_DEPARTMENT_STORE;
// int RECOG_EDYNO_MBR;
// int RECOG_FCF_CARD;
// int RECOG_PANAMEMBERSYSTEM;
// int RECOG_LANDISK;
// int RECOG_PITAPASYSTEM;
// int RECOG_TUOCARDSYSTEM;
// int RECOG_SALLMTBAR;
// int RECOG_BUSINESS_MODE;
// int RECOG_MCP200SYSTEM;
// int RECOG_SPVTSYSTEM;
// int RECOG_REMOTESYSTEM;
// int RECOG_ORDER_MODE;
// int RECOG_JREM_MULTISYSTEM;
// int RECOG_MEDIA_INFO;
// int RECOG_GS1_BARCODE;
// int RECOG_ASSORTSYSTEM;
// int RECOG_CENTER_SERVER;
// int RECOG_RESERVSYSTEM;
// int RECOG_DRUG_REV;
// int RECOG_GINCARDSYSTEM;
// int RECOG_FCLQPSYSTEM;
// int RECOG_FCLEDYSYSTEM;
// int RECOG_CAPS_CAFIS;
// int RECOG_FCLIDSYSTEM;
// int RECOG_PTCKTISSUSYSTEM;
// int RECOG_ABS_PREPAID;
// int RECOG_PROD_ITEM_AUTOSET;
// int RECOG_PROD_ITF14_BARCODE;
// int RECOG_SPECIAL_COUPON;
// int RECOG_BLUECHIP_SERVER;
// int RECOG_HITACHI_BLUECHIP;
// int RECOG_HQ_OTHER_CANTEVOLE;
// int RECOG_QCASHIER_SYSTEM;
// int RECOG_RECEIPT_QR_SYSTEM;
// int RECOG_VISATOUCH_INFOX;
// int RECOG_PBCHG_SYSTEM;
// int RECOG_HC1_SYSTEM;
// int RECOG_CAPS_HC1_CAFIS;
// int RECOG_REMOTESERVER;
// int RECOG_MRYCARDSYSTEM;
// int RECOG_SP_DEPARTMENT;
// int RECOG_DECIMALITMSEND;
// int RECOG_WIZ_CNCT;
// int RECOG_ABSV31_RWT;
// int RECOG_PLURALQR_SYSTEM;
// int RECOG_NETDOARESERV;
// int RECOG_SELPLUADJ;
// int RECOG_CUSTREAL_WEBSER;
// int RECOG_WIZ_ABJ;
// int RECOG_CUSTREAL_UID;
// int RECOG_BDLITMSEND;
// int RECOG_CUSTREAL_NETDOA;
// int RECOG_UT_CNCT;
// int RECOG_CAPS_PQVIC;
// int RECOG_YAMATO_SYSTEM;
// int RECOG_CAPS_CAFIS_STANDARD;
// int RECOG_NTTD_PRECA;
// int RECOG_USBCAM_CNCT;
// int RECOG_DRUGSTORE;
// int RECOG_CUSTREAL_NEC;
// int RECOG_CUSTREAL_OP;
// int RECOG_DUMMY_CRDT;
// int RECOG_HC2_SYSTEM;		// くろがねや特注仕様確認
// int RECOG_PRICE_SOUND;
// int RECOG_DUMMY_PRECA;
// int RECOG_MONITORED_SYSTEM;
// int RECOG_JMUPS_SYSTEM;
// int RECOG_UT1QPSYSTEM;
// int RECOG_UT1IDSYSTEM;
// int RECOG_BRAIN_SYSTEM;
// int RECOG_PFMPITAPASYSTEM;
// int RECOG_PFMJRICSYSTEM;
// int RECOG_CHARGESLIP_SYSTEM;
// int RECOG_PFMJRICCHARGESYSTEM;
// int RECOG_ITEMPRC_REDUCTION_COUPON;
// int RECOG_CAT_JNUPS_SYSTEM;
// int RECOG_SQRC_TICKET_SYSTEM;
// int RECOG_CCT_CONNECT_SYSTEM;
// int RECOG_CCT_EMONEY_SYSTEM;
// int RECOG_TEC_INFOX_JET_S_SYSTEM;
// int RECOG_PROD_INSTORE_ZERO_FLG;
// int RECOG_SKIP_9_06;
// int RECOG_SKIP_9_07;
// int RECOG_SKIP_9_08;
// int RECOG_SKIP_9_09;
// int RECOG_SKIP_9_10;
// int RECOG_SKIP_9_11;
// int RECOG_SKIP_9_12;
// int RECOG_SKIP_9_13;
// int RECOG_SKIP_9_14;
// int RECOG_SKIP_9_15;
// int RECOG_SKIP_9_16;
// int RECOG_SKIP_9_17;
// int RECOG_SKIP_9_18;
// int RECOG_FRONT_SELF_SYSTEM;
// int RECOG_TRK_PRECA;
// int RECOG_DESKTOP_CASHIER_SYSTEM;
// int RECOG_NIMOCA_POINT_SYSTEM;
// int RECOG_TB1_SYSTEM;
// int RECOG_REPICA_SYSTEM;
// int RECOG_CUSTREAL_POINTARTIST;
// int RECOG_YUMECA_SYSTEM;
// int RECOG_CUSTREAL_TPOINT;
// int RECOG_MAMMY_SYSTEM;
// int RECOG_KITCHEN_PRINT;
// int RECOG_EFFECT;
// int RECOG_AYAHA_SYSTEM;
// int RECOG_COGCA_SYSTEM;
// int RECOG_BDL_MULTI_SELECT_SYSTEM;      /* ﾐｯｸｽﾏｯﾁ複数選択仕様 */
// int RECOG_SALL_LMTBAR26;
// int RECOG_PURCHASE_TICKET_SYSTEM;	/* 特定売上チケット発券仕様 */
// int RECOG_CUSTREAL_UNI_SYSTEM;
// int RECOG_EJ_ANIMATION_SYSTEM;		/* EJ動画サーバ接続仕様 */
// int RECOG_TAX_FREE_SYSTEM;		/* 免税仕様 */
// int RECOG_VALUECARD_SYSTEM;
// int RECOG_SM4_COMODI_SYSTEM;
// int RECOG_SM5_ITOKU_SYSTEM;		/* 特定SM5仕様 */
// int RECOG_CCT_POINTUSE_SYSTEM;
// int RECOG_ZHQ_SYSTEM;
// int RECOG_RPOINT_SYSTEM;		/* 楽天ポイント仕様 */
// int RECOG_VESCA_SYSTEM;
// int RECOG_AJS_EMONEY_SYSTEM;			/* 電子マネー[AJS]仕様*/
// int RECOG_SM16_TAIYO_TOYOCHO_SYSTEM;	/* 特定SM16仕様[タイヨー(茨城)] */
// int RECOG_INFOX_DETAIL_SEND_SYSTEM;	/* 明細送信[INFOX]仕様 */
// int RECOG_SELF_MEDICATION_SYSTEM;	/* セルフメディケーション仕様 */
// int RECOG_PANAWAONSYSTEM;		/* WAON仕様 [Panasonic] */
// int RECOG_ONEPAYSYSTEM;			/* Onepay仕様 */
// int RECOG_HAPPYSELF_SYSTEM;		/* HappySelf仕様 */
// int RECOG_HAPPYSELF_SMILE_SYSTEM;	/* HappySelf仕様[対面セルフ用] */
// int RECOG_LINEPAY_SYSTEM;			/* LINE Pay仕様 */
// int RECOG_STAFF_RELEASE_SYSTEM;		/* 従業員権限解除 */
// int RECOG_WIZ_BASE_SYSTEM;		/* WIZ-BASE仕様 */
// int RECOG_SHOP_AND_GO_SYSTEM;		/* Shop&Go仕様 */
// int RECOG_DS2_GODAI_SYSTEM;		/* 特定DS2仕様[ゴダイ] */
// int RECOG_TAXFREE_PASSPORTINFO_SYSTEM;	/* 旅券読取内蔵免税仕様 */
// int RECOG_SM20_MAEDA_SYSTEM;		/* 特定SM20仕様[マエダ] */
// int RECOG_SM36_SANPRAZA_SYSTEM;		/* 特定SM36仕様[サンプラザ] */
// int RECOG_SM33_NISHIZAWA_SYSTEM;	/* 特定SM33仕様[ニシザワ] */
// int RECOG_CR50_SYSTEM;			/* CR5.0接続仕様 */
// int RECOG_CASE_CLOTHES_BARCODE_SYSTEM;	/* 特定クラス衣料バーコード仕様 */
// int RECOG_CUSTREAL_DUMMY_SYSTEM;	/* 顧客リアル仕様[ダミーシステム] */
// int RECOG_REASON_SELECT_STD_SYSTEM;	/* 理由選択仕様 */
// int RECOG_BARCODE_PAY1_SYSTEM;		/* JPQR決済仕様 */
// int RECOG_CUSTREAL_PTACTIX;		/* 顧客リアル[PT]仕様 */
// int RECOG_CR3_SHARP_SYSTEM;		/* 特定CR3接続仕様 */
// int RECOG_CCT_CODEPAY_SYSTEM;		/* CCTコード払い決済仕様 */
// int RECOG_WS_SYSTEM;			/* 特定WS仕様 */
// int RECOG_CUSTREAL_POINTINFINITY;	/* 顧客リアル[PI]仕様 */
// int RECOG_TOY_SYSTEM;			/* 特定TOY仕様 */
// int RECOG_CANAL_PAYMENT_SERVICE_SYSTEM;	/* ｺｰﾄﾞ決済[CANALPay]仕様 */
// int RECOG_DISPENSING_PHARMACY_SYSTEM;	/* 特定DP1仕様[アインHD] */
// int RECOG_SM41_BELLEJOIS_SYSTEM;	/* 特定SM41仕様[ベルジョイス] */
// int RECOG_SM42_KANESUE_SYSTEM;  	/* 特定SM42仕様[カネスエ] */
// int RECOG_DPOINT_SYSTEM;		/* dポイント仕様 */
// int RECOG_PUBLIC_BARCODE_PAY_SYSTEM;	/* 特定公共料金仕様[パソナ] */
// int RECOG_TS_INDIV_SETTING_SYSTEM;	/* TS設定個別変更仕様 */
// int RECOG_SM44_JA_TSURUOKA_SYSTEM;  	/* 特定SM44仕様[JA鶴岡] */
// int RECOG_STERA_TERMINAL_SYSTEM;  	/* stera terminal仕様 */
// int RECOG_REPICA_POINT_SYSTEM;		/* レピカポイント仕様 */
// int RECOG_SM45_OCEAN_SYSTEM;		/* 特定SM45仕様[オーシャンシステム] */
// int RECOG_FUJITSU_FIP_CODEPAY_SYSTEM;	// ｺｰﾄﾞ決済[FIP]仕様(Ver12以降)
// int RECOG_TAXFREE_SERVER_SYSTEM;	/*免税電子化仕様 */
// int RECOG_EMPLOYEE_CARD_PAYMENT_SYSTEM;	/* 社員証決済仕様[売店] */
// int RECOG_NET_RECEIPT_SYSTEM;		/* 電子レシート仕様 */
// int RECOG_SM49_ITOCHAIN_SYSTEM;		/* 特定SM49仕様[伊藤ﾁｪｰﾝ] */
// int RECOG_PUBLIC_BARCODE_PAY2_SYSTEM;	/* 特定公共料金2仕様[平泉町役場] */
// int RECOG_MULTI_ONEPAYSYSTEM;		/* Onepay複数ブランド仕様 */
// int RECOG_SM52_PALETTE_SYSTEM;		/* 特定SM52仕様[パレッテ] */
// int RECOG_PUBLIC_BARCODE_PAY3_SYSTEM;	/* 特定公共料金3仕様[石川町役場] */
// int RECOG_SVSCLS2_STLPDSC_SYSTEM;	/* ｻｰﾋﾞｽ分類別割引2仕様 */
// int RECOG_STAFFID1_YMSS_SYSTEM;		/* 特定社員証1仕様 */
// int RECOG_SM55_TAKAYANAGI_SYSTEM;	/*特定SM56仕様[タカヤナギ様] */
// int RECOG_MAIL_SEND_SYSTEM;		/* 電子メール送信仕様 */
// int RECOG_NETSTARS_CODEPAY_SYSTEM;	// ｺｰﾄﾞ決済[NETSTARS]仕様(Ver12以降)
// int RECOG_SM56_KOBEBUSSAN_SYSTEM;  	/* 特定SM56仕様[神戸物産] */
// int RECOG_MULTI_VEGA_SYSTEM;            /* VEGA3000電子ﾏﾈｰ仕様 */
// int RECOG_HYS1_SERIA_SYSTEM;		/* 特定HYS1仕様[セリア] */
// int RECOG_LIQR_TAXFREE_SYSTEM;		/*酒税免税仕様 */
// int RECOG_CUSTREAL_GYOMUCA_SYSTEM;	/* 顧客ﾘｱﾙ[SM56]仕様 */
// int RECOG_SM59_TAKARAMC_SYSTEM;		/* 特定SM59仕様[タカラ・エムシー] */
// int RECOG_DETAIL_NOPRN_SYSTEM;		/* 分類別明細非印字仕様[ファルマ様] */
// int RECOG_SM61_FUJIFILM_SYSTEM;		/* 特定SM61仕様[富士フィルムシステム(ゲオリテール)様] */
// int RECOG_DEPARTMENT2_SYSTEM;		/* 特定百貨店2仕様[さくら野百貨店様] */
// int RECOG_CUSTREAL_CROSSPOINT;		/* 顧客ﾘｱﾙ[CP]仕様(DB V14以降) */
// int RECOG_HC12_JOYFUL_HONDA_SYSTEM;		/* 特定HC12仕様[ジョイフル本田] */
// int RECOG_SM62_MARUICHI_SYSTEM;		/* 特定SM62仕様[マルイチ] */
// int RECOG_SM65_RYUBO_SYSTEM;		/* 特定SM65仕様[リウボウ] */
// int RECOG_TOMOIF_SYSTEM;		/* 友の会仕様 */
// int RECOG_SM66_FRESTA_SYSTEM;		/* 特定SM66仕様[フレスタ] */
// int RECOG_COSME1_ISTYLE_SYSTEM;		/* 特定コスメ1仕様[アイスタイルリテイル様] */
// int RECOG_SM71_SELECTION_SYSTEM;		/* 特定SM71仕様[セレクション] */
// int RECOG_KITCHEN_PRINT_RECIPT;		/* ｷｯﾁﾝﾌﾟﾘﾝﾀﾚｼｰﾄ印字仕様[角田市役所様] */
// int RECOG_MIYAZAKI_CITY_SYSTEM;		/* 宮崎市役所 市民課様 */
// int RECOG_PUBLIC_BARCODE_PAY4_SYSTEM;	/* 特定公共料金4仕様[角田市役所様] */
// int RECOG_SP1_QR_READ_SYSTEM;		/* 特定QR読込1仕様 */
// int RECOG_AIBOX_SYSTEM;			/* AIBOX連携仕様 */
// int RECOG_CASHONLY_KEYOPT_SYSTEM;		/* 現金支払限定仕様 */
// int RECOG_SM74_OZEKI_SYSTEM;		/* 特定SM74仕様[オオゼキ] */
// int RECOG_CARPARKING_QR_SYSTEM;		/* 駐車場QRコード印字仕様[Ｍｉｋ様] */
// int RECOG_OLC_SYSTEM;				/* 特定OLC仕様[オリエンタルランド様] */
// int RECOG_QUIZ_PAYMENT_SYSTEM;		/* ｺｰﾄﾞ決済[QUIZ]仕様 */
// int RECOG_JETS_LANE_SYSTEM;		/* Lane[JET-S]接続仕様 */
// #if RF1_SYSTEM
// int RECOG_RF1_HS_SYSTEM;		// 特定総菜仕様(DB V1以降)[ＲＦ仕様]
// #endif	/* #if RF1_SYSTEM */
// /***************************************************************************************************************/
// /* 先にNotesのWeb2100DBの承認キーDBに添付されているエクセルファイルを変更し、承認キーの位置を確保してください。 */
// /***************************************************************************************************************/
// } RC_RECOG_LISTS;
//
// typedef struct {
// RC_CNCT_LISTS	RC_CNCT;
// RC_RECOG_LISTS	RC_RECOG;
// } RC_INFO_MEM_LISTS;
//
// // tHeaderのvoid_kindフラグ
// typedef	enum
// {
// HEAD_VOID_KIND_NORMAL = 0,
// HEAD_VOID_KIND_VOID = 1,
// HEAD_VOID_KIND_BUYADD = 2,
// } HEAD_VOID_KIND;
//
// #endif

/* end of rxmem.h */
