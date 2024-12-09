/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_thlib.h
//  このファイルは上記ヘッダーファイルを元にdart化したものです。

// ************************************************************************
// File:           if_thlib.h
//  Contents:	Local definition datas for thermal printer library
// ************************************************************************

import 'dart:io';

///  関連tprxソース:if_thlib.h  #defineによる定義値
class IfThLib {

  static const int IF_TH_PRNBMP_NEW = 1;    /* 0:now 1:new */
  /* APL未対応の為、現在は０とする */

  static const int MAXRAST = 80;            /* Maximum raster size in byte	*/
  static const int MAXLINE = 3200;          /* Maximum line number		*/
  static const int LINEBUFSIZ = 260;        /* Maximum line size of inifile */
  static const int SPCHAR = 0;              /* Dot space between characters */
  static const int CMLOGO_MAXLINE = 1020;   /* Maximum line number		*/
  static const int ALLOC_MAXLINE = 1600;    // ALLOC Type Max Line
  static const int ALLOC_MAXLINE8 = 2400;   // ALLOC Type Max Line

/* Internal definition of if_th function(s) */
  static const int IF_TH_X_8 = 8 + SPCHAR;	 /* Next X position of 8x16 font */
  static const int IF_TH_X_12 = 12 + SPCHAR; /* Next X position of 12x24 font */
  static const int IF_TH_Y_8 = 20;           /* Next Y position of 8x16 font */
  static const int IF_TH_Y_12 = 30;          /* Next Y position of 12x24 font */
  static const int IF_TH_OFFY_8 = 4;         /* Offset Y position of 8x16 font */
  static const int IF_TH_OFFY_12 = 6;        /* Offset Y position of 12x24 font */

  static const int IF_TH_BUFLEN = 256;       /* Buffer size */
  static const int IF_TH_LINECHAR12 = 32;    /* Maximum number of ANK character */
  /*  in 12x24 dots character unit   */
  static const int IF_TH_DEFRECWID = 464;    /* Default receipt width in dots */
  static const int IF_TH_PRNRECWID = 432;    /* receipt width in dots */

  static const int IF_TH_DEFRECWID80 = 576;  /* 80mm Default receipt width in dots */
  static const int IF_TH_PRNRECWID80 = 576;  /* 80mm receipt width in dots */

  static const String TMPPRTFILE = "tmp/thprndat";	/* Temporary printer data file	*/
  static const String MAC_INFO_INI = "conf/mac_info.ini";
  static const String COUNTER_INI = "conf/counter.ini";
  static const String CM_BMP_PATH = "bmp/cmlogo/";
  static const String REGS_CM_BMP_PATH = "tmp/regs/cmlogo/";

/* size */
  static const int  IF_TH_W_PRN_NUM = 100;     /* work  print limit number */
  static const int  IF_TH_PRN_ORDER_NUM = 100; /* print order limit number */
  static const int  IF_TH_CMDSIZE = 4096;      /* コマンドバッファのサイズ */
//static const int  IF_TH_CMDSIZE = 1024;      /* コマンドバッファのサイズ */

/* print type */
  static const int  IF_TH_TYPE_NONE = -1;      /* 印字タイプなし */
  static const int  IF_TH_TYPE_BMP = 0;        /* 印字タイプ：ビットマップ */
  static const int  IF_TH_TYPE_CHAR = 1;       /* 印字タイプ：文字列 */
  static const int  IF_TH_TYPE_CMD = 2;        /* 印字タイプ：コマンド */
  static const int  IF_TH_TYPE_CMD_CHAR = 3;   /* 印字タイプ：コマンド + 文字列 */
  static const int  IF_TH_TYPE_CMD_BY_CHAR = 4;   /* 印字タイプ：コマンドのみ、ただしコマンドAで実行 */
}


///  関連tprxソース:if_thlib.h - typedef struct TH_PRN_DATA
class ThPrnData {
  int     x_pos = 0;		 /* 開始桁 */
  int     cmd_len = 0;	 /* コマンド長 */
  String	cmd = "";		   /* コマンド（フォント等） */
  String	data = "";		 /* 文字列データ */
}

///  関連tprxソース:if_thlib.h - typedef struct TH_PRN_ORDER
class ThPrnOrder {
  int    prn_type = 0;    /* 印字タイプ 0:BMP 1:CHAR */
  String prn_data = "";   /* 印字データ実体 */
  //int    addr = 0;        /* 印字データの先頭アドレス（使わないかも） */
  int    prn_size = 0;    /* 印字データサイズ */
//int    y_pos = 0;       /* BMP Y OFFSET */
}

///  関連tprxソース:if_thlib.h - typedef struct TH_PRN_BUF
class ThPrnBuf {                  /* Buffer structure for thermal printer   */
  int     crast = 0;              /* Current raster(= bytes/line) size  */
  int     ctopline = 0;           /* Current top position(line)         */
  int     cbtmline = 0;           /* Current bottom position(line)  */
  int     x_offset = 0;           /* X offset(left side) in dots        */
  String  bitmap = "";            /* Bitmap data area */

  int     prn_mode = 0;           /* if_th_AllocArea2() 印字モード 0:ビットマップ 1:文字列 */

  int     prn_type = 0;           /* 印字タイプ 0:BMP 1:CHAR */
  int     prn_char_len = 0;       /* 文字列データのデータ長(bytes) */
  String	prn_char = "";          /* 印字用の文字列データ（コマンド込み） */

  int     prn_cmd_len = 0;        /* コマンドデータ長(bytes) */
  String  prn_cmd = "";           /* 印字用のコマンドデータ */

  int     y_pos = 0;              /* 編集位置(縦) */

  int     w_cnt = 0;              /* 同一行の編集データ数 */

  List<ThPrnData> w_prn_data = List<ThPrnData>
      .generate(IfThLib.IF_TH_W_PRN_NUM, (index) => ThPrnData()); /* 同一行の編集データ */

  int     edit_type = IfThLib.IF_TH_TYPE_NONE;   /* 編集タイプ 0:Bitmap 1:Character 1:Command */
  int    	prn_cnt = 0;            /* 印字順序数 */
  // List<ThPrnOrder> prn_order = List<ThPrnOrder>
  //     .generate(IfThLib.IF_TH_PRN_ORDER_NUM, (index) => ThPrnOrder()); /* 印字順序 */

  int     rct_lf_plus = 0;        /* 行間のｄｏｔ数 for Web2300, WebPrimePlus */

  String  OutPutFileName = ""; // 出力ファイル名
  String  OutPutFilePointer = ""; // 出力ファイル名
  int     OutPutFileStop = 0;     // 出力中断フラグ

  /// 内部インスタンス
  /// 機能説明:staticなインスタンスを事前に作成
  static final ThPrnBuf _instance = ThPrnBuf._internal();

  /// 1.Factoryコンストラクタ
  /// 機能説明:staticな内部コンストラクタを返す
  /// (シングルトンパターンの実装のため、この形にしています)
  factory ThPrnBuf() {
    return _instance;
  }

  /// 2.内部で利用する別名コンストラクタ
  /// 機能説明:名前付きコンストラクタとして定義する.中での追加処理はなし.
  /// 補足:設定ファイルから情報を取得して、プロパティに設定するのはopenで行います.
  /// 補足:DBのオープン処理はここでしてはならない(awaitをつけて明示的に呼んでもらわないといけないので)
  ThPrnBuf._internal() {}

}

///  関連tprxソース:if_thlib.h - typedef struct TH_RPN_BMP_BUF
class ThPrnBmpBuf {
  String  ptBmpFileName = "";
  String  bitmap = "";            /* Bitmap data area */
}


