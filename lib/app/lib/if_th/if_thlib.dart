/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:io';

/// 関連tprxソース:if_thlib.h
class IfThLib{
  static const int 	MAXRAST =	80;		/* Maximum raster size in byte	*/
  static const int 	MAXLINE = 3200;		/* Maximum line number		*/
  static const int  LINEBUFSIZ = 260;		/* Maximum line size of inifile */
  static const int 	SPCHAR = 0;		/* Dot space between characters */
  static const int 	CMLOGO_MAXLINE = 1020;		/* Maximum line number		*/
  static const int 	ALLOC_MAXLINE	= 1600;		// ALLOC Type Max Line
  static const int 	ALLOC_MAXLINE80	= 2400;		// ALLOC Type Max Line

  /* Internal definition of if_th function(s) */
  static const int IF_TH_X_8 = 8 + SPCHAR;	/* Next X position of 8x16 font */
  static const int IF_TH_X_12 = 12 + SPCHAR;	/* Next X position of 12x24 font */
  static const int IF_TH_Y_8 =20;	/* Next Y position of 8x16 font */
  static const int IF_TH_Y_12 = 30;	/* Next Y position of 12x24 font */
  static const int IF_TH_OFFY_8	= 4;	/* Offset Y position of 8x16 font */
  static const int IF_TH_OFFY_12 = 6;	/* Offset Y position of 12x24 font */

  static const int IF_TH_BUFLEN	= 256;	/* Buffer size */
  static const int IF_TH_LINECHAR12	= 32;  /* Maximum number of ANK character */
  /*  in 12x24 dots character unit   */
  static const int IF_TH_DEFRECWID = 464;	/* Default receipt width in dots */
  static const int IF_TH_PRNRECWID = 432;	/* receipt width in dots */

  static const int IF_TH_DEFRECWID80 = 576;	/* 80mm Default receipt width in dots */
  static const int IF_TH_PRNRECWID80 = 576;	/* 80mm receipt width in dots */

  static const String	TMPPRTFILE = "tmp/thprndat";	/* Temporary printer data file	*/
  static const String	MAC_INFO_INI = "conf/mac_info.ini";
  static const String	COUNTER_INI	= "conf/counter.ini";
  static const String	CM_BMP_PATH	= "bmp/cmlogo/";
  static const String	REGS_CM_BMP_PATH = "tmp/regs/cmlogo/";

  /* print type */
  static const int IF_TH_TYPE_NONE = -1;				/* 印字タイプなし */
  static const int IF_TH_TYPE_BMP	= 0;				/* 印字タイプ：ビットマップ */
  static const int IF_TH_TYPE_CHAR = 1;				/* 印字タイプ：文字列 */
  static const int IF_TH_TYPE_CMD	= 2;				/* 印字タイプ：コマンド */

  /* size */
  static const int IF_TH_W_PRN_NUM = 100;				/* work  print limit number */
  static const int IF_TH_PRN_ORDER_NUM = 100;				/* print order limit number */
  static const int IF_TH_CMDSIZE = 4096;			/* コマンドバッファのサイズ */
}

// typedef	struct {	/* Buffer structure for thermal printer	*/
// int	crast;		/* Current raster(= bytes/line) size	*/
// int	ctopline;	/* Current top position(line) 		*/
// int	cbtmline;	/* Current bottom position(line)	*/
// int	x_offset;	/* X offset(left side) in dots		*/
// unsigned char	bitmap[MAXLINE][MAXRAST];	/* Bitmap data area */
//
// char			prn_mode;					/* if_th_AllocArea2() 印字モード 0:ビットマップ 1:文字列 */
//
// int 			prn_char_len;				/* 文字列データのデータ長(bytes) */
// unsigned char	prn_char[MAXLINE*MAXRAST];	/* 印字用の文字列データ（コマンド込み） */
//
// int 			prn_cmd_len;				/* コマンドデータ長(bytes) */
// unsigned char	prn_cmd[MAXLINE*MAXRAST];	/* 印字用のコマンドデータ */
//
// int				y_pos;						/* 編集位置(縦) */
//
// int				w_cnt;						/* 同一行の編集データ数 */
// TH_PRN_DATA		w_prn_data[IF_TH_W_PRN_NUM]; /* 同一行の編集データ */
//
// char			edit_type;					/* 編集タイプ 0:Bitmap 1:Character 1:Command */
// int				prn_cnt;					/* 印字順序数 */
// TH_PRN_ORDER	prn_order[IF_TH_PRN_ORDER_NUM];	/* 印字順序 */
//
// int				rct_lf_plus;				/* 行間のｄｏｔ数 for Web2300, WebPrimePlus */
//
// FILE		*OutPutFilePointer;		// 出力ファイル名
// short		OutPutFileStop;			// 出力中断フラグ
//
// } TH_PRN_BUF;

/// 関連tprxソース:if_thlib.c - 構造体TH_PRN_DATA
 class ThPrnData{
   int xPos = 0;					/* 開始桁 */
   int cmdLen = 0;				/* コマンド長 */
   String	cmd = '';		/* コマンド（フォント等） */
   String data = '';		/* 文字列データ */
 }

/// 関連tprxソース:if_thlib.c - 構造体TH_PRN_ORDER
class ThPrnOrder{
  String prnType = '';				/* 印字タイプ 0:BMP 1:CHAR */
  String addr = '';					/* 印字データの先頭アドレス */
  int prnSize = 0;				/* 印字データサイズ */
}

/// Buffer structure for thermal printer
/// 関連tprxソース:if_thlib.h - 構造体TH_PRN_BUF
//  未使用の変数はコメントアウト。必要あればコメント解除して実装する
class ThPrnBuf{
  double	cRast = 0;		/* Current raster(= bytes/line) size	*/
  int	cTopLine = 0;	/* Current top position(line) 		*/
  int	cBtmLine = 0;	/* Current bottom position(line)	*/
  int	xOffset = 0;	/* X offset(left side) in dots		*/
  // List<List<String>> bitmap = List.generate(IfThLib.MAXLINE,
  //         (_) => List.generate(
  //             IfThLib.MAXRAST, (_) => ""));

  String prnMode = "";		/* if_th_AllocArea2() 印字モード 0:ビットマップ 1:文字列 */
  int prnCharLen = 0;				/* 文字列データのデータ長(bytes) */
  List<String> prnChar = List.filled(IfThLib.MAXLINE * IfThLib.MAXRAST, "");	/* 印字用の文字列データ（コマンド込み） */

  int prnCmdLen = 0;				/* コマンドデータ長(bytes) */
  List<String> prnCmd = List.filled(IfThLib.MAXLINE * IfThLib.MAXRAST, "");	/* 印字用のコマンドデータ */

  int yPos = 0; /* 編集位置(縦) */

  int wCnt = 0; /* 同一行の編集データ数 */
  List<ThPrnData>	wPrnData = List.generate(IfThLib.IF_TH_PRN_ORDER_NUM, (_) => ThPrnData()); /* 同一行の編集データ */
  //
  String editType = '';					/* 編集タイプ 0:Bitmap 1:Character 1:Command */
  int	prnCnt = 0;					/* 印字順序数 */
  List<ThPrnOrder> prnOrder = List.generate(IfThLib.IF_TH_PRN_ORDER_NUM, (_) => ThPrnOrder());	/* 印字順序 */
  //
  int	rctLfPlus = 0;				/* 行間のｄｏｔ数 for Web2300, WebPrimePlus */

 late File?	outPutFilePointer;		// 出力ファイル名
  // short		OutPutFileStop;			// 出力中断フラグ

}
