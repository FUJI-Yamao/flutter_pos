/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
typedef IfReturnCode = int;

///  関連tprxソース:if_th.h
class InterfaceDefine {

  static const DEBUG_IF_TH   = false;
  static const DEBUG_UT      = false;
  static const PERFORMANCE00 = false;
  static const PERFORMANCE99 = false;
  static const UNIT_TEST     = false;

  //  return code
  static const IfReturnCode IF_TH_POK = 0; //  Normal end
  static const IfReturnCode IF_TH_PERPARAM = 1; //  Parameter error
  static const IfReturnCode IF_TH_PERWRITE = 2; //  Write error
  static const IfReturnCode IF_TH_PERALLOC = 3; //  Memory allocate error
  static const IfReturnCode IF_TH_PERREAD = 4; //  Read error
  static const IfReturnCode IF_TH_PERBUSY = 5; //  Drivertask busy
  static const IfReturnCode IF_TH_PERXYSTART =
      6; //  X or Y start position error
  static const IfReturnCode IF_TH_PERCNVSJIS =
      7; //  Character code conversion error
  static const IfReturnCode IF_TH_PERGETBITMAP = 8; //  Error on VF_GetBitmap2
  static const IfReturnCode IF_TH_PERXRANGE = 9; //  X range over error
  static const IfReturnCode IF_TH_PERYRANGE = 10; //  Y range over error
  static const IfReturnCode IF_TH_PERROTATE = 11; //  Error on VF_RotatedBitmap
  static const IfReturnCode IF_TH_PERFOPEN = 12; //  File open error
  static const IfReturnCode IF_TH_OTHERERR =
      99; //  その他エラー(上記エラーのどのエラーでもないが、エラー状態にしたかった為作成)

//  Parameters
  //  For if_th_cCut()
  static const IF_TH_NOLOGO = 0; //  Cut without Logo printing
  static const IF_TH_LOGO1 = 1; //  Cut with Logo#1 printing
  static const IF_TH_LOGO2 = 2; //  Cut with Logo#2 printing
  static const IF_TH_LOGO3 = 3; //  Cut with Logo#3 printing
  static const IF_TH_LOGO4 = 4; //  Cut with Logo#4 printing
  static const IF_TH_NOLOGO2 = 5; //  Cut without Logo printing - 2

  static const IF_TH_FULLCUT    = 0; // "FullCut"：フルカット、or LastCut
  static const IF_TH_PARTIALCUT = 1; // "PartialCut"：パーシャルカット（一部残し）
  static const IF_TH_NOTCUT     = 2; // "NotCut"：なにもしない

  //  For if_th_cSendData()
  static const IF_TH_PRINTBYCMD = 0; //  Start printing by command
  static const IF_TH_PRINTBYSIZ = 1; //  Start printing by reaching a size

  //  For if_th_PreReceipt()
  static const IF_TH_RECEIPT = 0; //  Select receipt printing
  static const IF_TH_REPORT = 1; //  Select report printing
  static const IF_TH_PRT_SHOP = 0x01; //  Need to print shop name
  static const IF_TH_PRT_RCTNO = 0x02; //  Need to print receipt No.
  static const IF_TH_PRT_TMSG = 0x04; //  Need to print trailer msg.
  static const IF_TH_PRT_UNDATED = 0x08; //  登録レシートで年月日の値が入っていない印字
  static const IF_TH_PRT_SHOP2_ONLY = 0x10; //  レシート店名番号２だけ印字
  static const IF_TH_PRT_SHOP1_ONLY = 0x20; //  レシート店名番号１のみ印字
  static const IF_TH_PRT_SHOP_OLIGINAL = 0x40; //  レシート店名位置にオリジナルメッセージ

  //  For if_th_GridString()
  static const IF_TH_FW12 = 0; //  Select 12x24 font
  static const IF_TH_FW8 = 1; //  Select 8x16 font

  //  For if_th_cPrintStatus()
  static const IF_TH_PRNSTS_PARAM = 0x01; //  Print parameter settings
  static const IF_TH_PRNSTS_VER = 0x02; //  Print controller's version
  static const IF_TH_PRNSTS_DIPSW = 0x04; //  Print DIPSW setting
  static const IF_TH_PRNSTS_MEMTST = 0x08; //  Print result of memory test
  static const IF_TH_PRNSTS_LOGO = 0x10; //  Print status of logo memory
  static const IF_TH_PRNSTS_LOG = 0x20; //  Print printing distance

  //  Printing object attributes
  static const IF_TH_PRNATTR_NO_OPTION = 0x00; //  No Option
  static const IF_TH_PRNATTR_NONCLEAR = 0x01; //  Don't clear before putting object
  static const IF_TH_PRNATTR_REVERSE = 0x02; //  Make object reverse
  static const IF_TH_PRNATTR_ROTATE90 = 0x04; //  Rotate 90 degree
  static const IF_TH_PRNATTR_ROTATE180 = 0x08; //  Rotate 180 degree
  static const IF_TH_PRNATTR_ROTATE270 = 0x0C; //  Rotate 270 degree
  static const IF_TH_PRNATTR_BITMAP = 0x10; //  BITMAP print buffer
  static const IF_TH_PRNATTR_LINESP0 = 0x20;  // Line spacing 0

  //  Printing object position
  static const IF_TH_PRNPOSI_LEFT = 0; //  left
  static const IF_TH_PRNPOSI_CENTER = 1; //  center
  static const IF_TH_PRNPOSI_RIGHT = 2; //  right

  //  Kind of line
  //  For if_th_PrintLine(), if_th_PrintRectangle()
  static const IF_TH_LINE_SOLID  = 0; //  Solid line
  static const IF_TH_LINE_DOTTED = 1; //  Dotted line(black 2 dots - white 2 dots)
  static const IF_TH_LINE_BREAK  = 2; //  Break line(bleck 5 dots - white 3 dots)

  static const IF_TH_LINE_X_OFFSET = 40;

  //  For if_th_FlushBuf()
  static const IF_TH_FLUSHALL = 0; //  Flush all data on buffer

  static const IF_TH_BITMAP_MAXRAST = 80; // Maximum raster size in byte
  static const IF_TH_BITMAP_MAXLINE = 3200; // Maximum line number
  static const IF_TH_BITMAP_FILE_LEN = 128; // Bitmap file Name length

//  Error bit definitions
  //  Printer error definition in status byte
  static const IF_TH_PRNERR_RESET = 0x01; //  Reset
  static const IF_TH_PRNERR_PEND = 0x02; //  Paper end
  static const IF_TH_PRNERR_HOPN = 0x04; //  Head open
  static const IF_TH_PRNERR_CUTERR = 0x08; //  Cutter error
  static const IF_TH_PRNERR_DRWOPN = 0x10; //  Drawer open
  static const IF_TH_PRNERR_NEND = 0x20; //  Near end
  static const IF_TH_PRNERR_NO_ANSWER = 0x80; //  printer no answer

  static const IF_TH_DRW_OPEN = 0; //  Drawer is open
  static const IF_TH_DRW_CLOSE = 1; //  Drawer is close

  static const IF_TH_CMD_SEPA = 0x1f; //  Command Separator

  static const TPRT_FTOK_PATHNAME = "tmp/print_shm1";
  static const TPRT2_FTOK_PATHNAME = "tmp/print_shm2";
  static const TPRT3_FTOK_PATHNAME = "tmp/print_shm3";
  static const TPRT4_FTOK_PATHNAME = "tmp/print_shm4";

  static const IF_TH_ORG_STR_NUM = 4; //  オリジナルメッセージ個数
  static const IF_TH_TGT_MSG_STEP_NUM = 5; // ターゲットメッセージ段数
  static const IF_TH_TGT_MSG_PLAN_NUM = 3; // ターゲットメッセージ企画数
  static const IF_TH_MSG_TYPE = 3; // 印字するメッセージタイプの最大数
  static const IF_TH_MSG_STEP = 5; // メッセージ段数

  static const USHRT_MAX = 65535;
}

/// 関連tprxソース: if_th.h - IF_TH_PARAM
class IfThParam{
  int paraNum = 0; /* Parameter number	*/
  /* Parameter value	*/
  late int wData = 0;
  late List<String> bData = ["",""];
}

/// 関連tprxソース: if_th.h - IF_TH_HEAD
class IfThHead{
  int	HeadMsgTyp = 0;		          // HEADMSG_LISTの値
  int	HeadMsgPrnFlg = 0;		      // 0:印字  1:ヘッダーメッセージを印字しない
  int	CustFlg = 0;		            // 0:通常売上  1:会員売上
  int	iMacNo = 0;			            // クレジット控えなどに利用
  int	iReceiptNo = 0;		          /* Receipt number	*/
  int	iJournalNo = 0;		          /* Journal number	*/
  int iChkrCode = 0;		          /* Checker number	*/
  String	szChkrName = "";		    /* Checker name		*/
  int iCshrCode = 0;		          /* Casher number	*/
  String	szCshrName = "";		    /* Casher name		*/
  /* ヘッダー部に印字したいオリジナル文言（レシート店名番号1を代用して印字) */
  List<List<String>> orgStr = List.generate(InterfaceDefine.IF_TH_ORG_STR_NUM,
          (_) => List.generate((32*4+1),(_) => ""));
  // ヘッダー部に印字したい顧客別ターゲットメッセージ
  // memo:元の宣言（char	TgtMsg[IF_TH_TGT_MSG_PLAN_NUM][IF_TH_TGT_MSG_STEP_NUM][sizeof(((c_loytgt_mst *)NULL)->message1)];）
  // memo:[sizeof(((c_loytgt_mst *)NULL)->message1)]はmessage1の最大値25を設定
  List<List<String>> tgtMsg = List.generate(InterfaceDefine.IF_TH_TGT_MSG_PLAN_NUM,
          (_) => List.generate(InterfaceDefine.IF_TH_TGT_MSG_STEP_NUM, (_) => ''));

  String	EjDataTxt = "";	        // 電子ジャーナルテキストに日時等を書き込む場合にファイル名を指定する
  String	Title = "";		          //タイトル
  int	T_iAFontId = 0;		          //タイトル英数フォント
  int	T_iKFontId = 0;		          //タイトルカタフォント
}

// レシートヘッダーの値(メッセージに使用)
///  関連tprxソース:if_th.h - typedef	enum HEADMSG_LIST
enum HeadMsgList{
  HEADMSG_NORMAL(0),	// 通常
  HEADMSG_MBR_TCKT(1),	// サービスチケット
  HEADMSG_INOUT(2);	// 入出金(inout_flg != 0)

  final int id;
  const HeadMsgList(this.id);
}

// #if 0
// /* move from euc2shift.c >>> */
// typedef struct {
// int euc_1;
// int euc_2;
// int sjis_1;
// int sjis_2;
// } Special_Char;
//
// #define CODE3_SPECIAL_MAX       106
// extern Special_Char CodeSet3_Special[CODE3_SPECIAL_MAX];
// /* <<< move from euc2shift.c */
// #endif

/* bitmapfile header */
///  関連tprxソース:if_th.h - typedef struct IF_TH_BITMAPFILEHEADER
class IfThBitmapFileHeader {
  /* unsigned short bfType; */
  String bfType   = "";
  int bfSize      = 0;
  int bfReserved1 = 0;
  int bfReserved2 = 0;
  int bfOffBits   = 0;
}

/* bitmapfile infomation (windows)*/
///  関連tprxソース:if_th.h - typedef struct IF_TH_BITMAPINFOHEADER
class IfThBitmapInfoHeader {
  int biSize         = 0;
  int biWidth        = 0;
  int biHeight       = 0;
  int biPlanes       = 0;
  int biBitCount     = 0;
  int biCompression  = 0;
  int biSizeImage    = 0;
  int biXPixPerMeter = 0;
  int biYPixPerMeter = 0;
  int biClrUsed      = 0;
  int iClrImporant   = 0;
}

///  関連tprxソース:if_th.h - typedef struct IF_TH_RGBQUAD
class IfThRGBQuad {
  int rgbBlue     = 0;
  int rgbGreen    = 0;
  int rgbRed      = 0;
  int rgbReserved = 0;
}

///  関連tprxソース:if_th.h - typedef struct IF_TH_BITMAP_BUF
class IfThBitmapBuf {
  String ptBmpFileName = "";
  // unsigned char	bitmap[IF_TH_BITMAP_MAXLINE][IF_TH_BITMAP_MAXRAST];	// Bitmap data area
  String bitmap = "";  //
}

// ビットマップデータを格納する構造体
///  関連tprxソース:if_th.h - typedef struct AllocBmpStruct
class AllocBmpStruct {
  IfThRGBQuad color1 = IfThRGBQuad();
  IfThRGBQuad color2 = IfThRGBQuad();
  IfThBitmapFileHeader fileHdr = IfThBitmapFileHeader();
  IfThBitmapInfoHeader InfoHdr = IfThBitmapInfoHeader();
  IfThBitmapBuf buf = IfThBitmapBuf();
}

// ヘッダーの日付とマシン番号, 従業員やレシート番号印字用パラメータ
///  関連tprxソース:if_th.h - typedef struct HeaderPrintParam
class HeaderPrintParam {
  IfThHead ptIfThHead = IfThHead();
  int		kind = 0;
  int		print = 0;
  DateTime tm = new DateTime.now();
  late DateTime? ptDateParam;
  int		iAFontId = 0;
  int		iKFontId = 0;
}

// メッセージマスタ内容の印字用パラメータ
///  関連tprxソース:if_th.h - typedef struct MsgMstPrintParam
class MsgMstPrintParam {
  int iAFontId  = 0;
  int iKFontId  = 0;
  int custFlg   = 0;	// 0:通常売上  1:会員売上
  String ptlKey = "";
}
