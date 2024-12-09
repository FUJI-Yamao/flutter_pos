/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/db/c_ttllog.dart';

/// 関連tprxソース: rc_inout.h
class RcInOut {
  static const SDISP1 = 1;
  static const SDISP2 = 2;
  static const SDISP3 = 3;
  static const LDISP = 4;

  static const TTLLOG_ACKPICK_FLAG = 1;
  static const TTLLOG_LOAN_FLAG = 2;
  static const TTLLOG_IN_FLAG = 3;
  static const TTLLOG_OUT_FLAG = 4;
  static const TTLLOG_PICK_FLAG = 5;
  static const TTLLOG_DRAWCHK_FLAG = 6;

  static InOutCloseData inOutClose = InOutCloseData();

  static const int CPick_Length = 7;	//桁数(5)+枚(2)
  static const int INOUT_ENTBTN_CNT = 11;	//1234567890C
  static const int INOUT_ENTBTN2_CNT = 12;	//1234567890C[00]
  static const int DRAWCHK_EXEBTN_CNT = 11;
  static const int DIVIDE_SHEET_CNT = 10;	//１金種に対する区分件数(区分設定の1～9と0:その他扱い)
//static const int INOUT_BTN_MAX	((DRAWCHK_DIF_MAX > INOUT_DIF_MAX)? DRAWCHK_DIF_MAX : INOUT_DIF_MAX)
  static int DRAWCHK_STOCK_DSP_X_MAX = (InoutPayType.INOUT_PAY_TYPE_MAX + 2); //ラベル、現金、会計、品券、合計
  static int DRAWCHK_STOCK_DSP_Y_MAX = (DrawchkStockKind.DRAWCHK_STOCK_MAX + 2); //ラベル、釣準備、入金、支払、売上回収、その他、合計

  static int INOUT_DIF_CASH = (InoutDisp.INOUT_Y1 + 1);
  static int INOUT_DIF_NONCASH = (InoutDisp.INOUT_DIF_MAX - INOUT_DIF_CASH);
}

/*---------------------------------------------------------------------------*
 *  Display IN/OUT DIFFER Datas
 *---------------------------------------------------------------------------*/
/// 関連tprxソース: rc_inout.h - INOUT_DISP
class InoutDisp {
  static const int INOUT_Y10000  = 0;
  static const int INOUT_Y5000   = 1;
  static const int INOUT_Y2000   = 2;
  static const int INOUT_Y1000   = 3;
  static const int INOUT_Y500    = 4;
  static const int INOUT_Y100    = 5;
  static const int INOUT_Y50     = 6;
  static const int INOUT_Y10     = 7;
  static const int INOUT_Y5      = 8;
  static const int INOUT_Y1      = 9;
  static const int INOUT_CHA1    = 10;
  static const int INOUT_CHA2    = 11;
  static const int INOUT_CHA3    = 12;
  static const int INOUT_CHA4    = 13;
  static const int INOUT_CHA5    = 14;
  static const int INOUT_CHA6    = 15;
  static const int INOUT_CHA7    = 16;
  static const int INOUT_CHA8    = 17;
  static const int INOUT_CHA9    = 18;
  static const int INOUT_CHA10   = 19;
//static const int  INOUT_NEXT   = **;
  static const int INOUT_CHA11   = 20;
  static const int INOUT_CHA12   = 21;
  static const int INOUT_CHA13   = 22;
  static const int INOUT_CHA14   = 23;
  static const int INOUT_CHA15   = 24;
  static const int INOUT_CHA16   = 25;
  static const int INOUT_CHA17   = 26;
  static const int INOUT_CHA18   = 27;
  static const int INOUT_CHA19   = 28;
  static const int INOUT_CHA20   = 29;
  static const int INOUT_CHA21   = 30;
  static const int INOUT_CHA22   = 31;
  static const int INOUT_CHA23   = 32;
  static const int INOUT_CHA24   = 33;
  static const int INOUT_CHA25   = 34;
  static const int INOUT_CHA26   = 35;
  static const int INOUT_CHA27   = 36;
  static const int INOUT_CHA28   = 37;
  static const int INOUT_CHA29   = 38;
  static const int INOUT_CHA30   = 39;
  static const int INOUT_CHK1    = 40;
  static const int INOUT_CHK2    = 41;
  static const int INOUT_CHK3    = 42;
  static const int INOUT_CHK4    = 43;
  static const int INOUT_CHK5    = 44;
//static const int INOUT_NEXT2   = **,
  static const int INOUT_DIF_MAX = 45;
}

//差異チェック新画面
/// 関連tprxソース: rc_inout.h - DRAWCHK_DISP
class DrawchkDisp {
  static const int DRAWCHK_Y10000     = 0;
  static const int DRAWCHK_Y5000      = 1;
  static const int DRAWCHK_Y2000      = 2;
  static const int DRAWCHK_Y1000      = 3;
  static const int DRAWCHK_NEXT_LINE1 = 4;	//改行
  static const int DRAWCHK_Y500       = 5;
  static const int DRAWCHK_Y100       = 6;
  static const int DRAWCHK_Y50        = 7;
  static const int DRAWCHK_Y10        = 8;
  static const int DRAWCHK_Y5         = 9;
  static const int DRAWCHK_Y1         = 10;
  static const int DRAWCHK_NEXT_PAGE1 = 11;	//次頁
  static const int DRAWCHK_CHA1       = 12;
  static const int DRAWCHK_CHA2       = 13;
  static const int DRAWCHK_CHA3       = 14;
  static const int DRAWCHK_CHA4       = 15;
  static const int DRAWCHK_CHA5       = 16;
  static const int DRAWCHK_CHA6       = 17;
  static const int DRAWCHK_CHA7       = 18;
  static const int DRAWCHK_CHA8       = 19;
  static const int DRAWCHK_CHA9       = 20;
  static const int DRAWCHK_CHA10      = 21;
  static const int DRAWCHK_NEXT_LINE2 = 22;	//改行
  static const int DRAWCHK_CHA11      = 23;
  static const int DRAWCHK_CHA12      = 24;
  static const int DRAWCHK_CHA13      = 25;
  static const int DRAWCHK_CHA14      = 26;
  static const int DRAWCHK_CHA15      = 27;
  static const int DRAWCHK_CHA16      = 28;
  static const int DRAWCHK_CHA17      = 29;
  static const int DRAWCHK_CHA18      = 30;
  static const int DRAWCHK_CHA19      = 31;
  static const int DRAWCHK_CHA20      = 32;
  static const int DRAWCHK_NEXT_LINE3 = 33;	//改行
  static const int DRAWCHK_CHA21      = 34;
  static const int DRAWCHK_CHA22      = 35;
  static const int DRAWCHK_CHA23      = 36;
  static const int DRAWCHK_CHA24      = 37;
  static const int DRAWCHK_CHA25      = 38;
  static const int DRAWCHK_CHA26      = 39;
  static const int DRAWCHK_CHA27      = 40;
  static const int DRAWCHK_CHA28      = 41;
  static const int DRAWCHK_CHA29      = 42;
  static const int DRAWCHK_CHA30      = 43;
  static const int DRAWCHK_NEXT_LINE4 = 44;	//改行
  static const int DRAWCHK_CHK1       = 45;
  static const int DRAWCHK_CHK2       = 46;
  static const int DRAWCHK_CHK3       = 47;
  static const int DRAWCHK_CHK4       = 48;
  static const int DRAWCHK_CHK5       = 49;
  static const int DRAWCHK_NEXT_PAGE3 = 50;	//次頁
  static const int DRAWCHK_DIF_MAX    = 51;
}

/// 関連tprxソース: rc_inout.h - INOUT_CASH_TYPE
class Inout_Cash_Type {
  static const int INOUT_CASH_ALL = 0;
  static const int INOUT_CASH_BILL = 1;
  static const int INOUT_CASH_COIN = 2;
}

/// 関連tprxソース: rc_inout.h - INOUT_PAY_TYPE
class InoutPayType {
  static const int INOUT_TYPE_CASH    = 0;
  static const int INOUT_TYPE_CHA     = 1;
  static const int INOUT_TYPE_CHK     = 2;
  static const int INOUT_PAY_TYPE_MAX = 3;
}

/// 関連tprxソース: rc_inout.h - DRAWCHK_STOCK_KIND
class DrawchkStockKind {
  static const int DRAWCHK_STOCK_LOAN = 0;
  static const int DRAWCHK_STOCK_CIN  = 1;
  static const int DRAWCHK_STOCK_OUT  = 2;
  static const int DRAWCHK_STOCK_PICK = 3;
  static const int DRAWCHK_STOCK_OTH  = 4;
  static const int DRAWCHK_STOCK_MAX  = 5;
}

/// 関連tprxソース: rc_inout.h - INOUT_ENTKY_USE_TYPE
class InoutEntkyUseType {
  static const int INOUT_ENTKY_TYPE_1 = 0;	//横並び１列
  static const int INOUT_ENTKY_TYPE_2 = 1;		//横並び２列
  static const int INOUT_ENTKY_TYPE_3 = 2;		//テンキータイプ
}

//多慶屋様 未読現金
/// 関連tprxソース: rc_inout.h - INOUT_UNREAD_DISP
class InoutUnreadDisp {
  static const int INOUT_YY10000    = 0;
  static const int INOUT_YY5000     = 1;
  static const int INOUT_YY2000     = 2;
  static const int INOUT_YY1000     = 3;
  static const int INOUT_YY500      = 4;
  static const int INOUT_YY100      = 5;
  static const int INOUT_YY50       = 6;
  static const int INOUT_YY10       = 7;
  static const int INOUT_YY5        = 8;
  static const int INOUT_YY1        = 9;
  static const int INOUT_UNREAD_MAX = 10;
}


/// 関連tprxソース: rc_inout.h - InOut_Close_Data
class InOutCloseData{
  List<T100200>	drawChk = List.generate(AmtKind.amtMax.index,(_) => T100200());	//差異チェック時の在高
  List<T100210>	divData = List.generate(AmtKind.amtMax.index, (_) => T100210());	//区分入力の在高
  int	closePickFlg = 0;	//従業員精算 0:しない 1:する
  int	pickSelectFlg = 0;	//回収反映選択画面を経由 0:していない 1:している
  int	updateFlg = 0;	//従業員精算実績作成フラグ(正常処理以外での実績作成判定のため)
  int	drawChkSkip = 0;	//差異チェックを「次へ」で進んだ
  int	devId = 0;
}
//差異チェック->売上回収->釣機回収とデータを引き継いだまま連続処理させるので初期化タイミングに注意
/// 関連tprxソース: rc_inout.h - struct InOutDivide
class InOutDivide {
  int kind_cd = 0;
  int div_cd = 0;
  String name = ""; //[sizeof(((c_divide_mst *)NULL)->name)];
  int face_value = 0;	//券面額
  int Count = 0;		//入力枚数or入力金額
}

/// 関連tprxソース: rc_inout.h - struct InOutKind
class InOutKind {
  int position = 0;
  int subxpt = 0;
  int subypt = 0;
  // GtkWidget	*InOutBtn;
  // GtkWidget	*InOutEntry;
  // GtkWidget	*InOutEntry2;
  // GtkWidget	*AcrEntry;
  List<int> EntryText = List<int>.generate(RcInOut.CPick_Length * 4 + 1, (index) => 0);
  int Count = 0;
  int Amount = 0;
  //GtkWidget	*DrawChkBtn;
  int DrawChkData = 0;
  int minus_flg = 0;
  List<InOutDivide> DivData = List<InOutDivide>.generate(RcInOut.DIVIDE_SHEET_CNT, (index) => InOutDivide());  //現外区分データ(区分1～9, 0:その他)
}

/// 関連tprxソース: rc_inout.h - struct InOutSave
class InOutSave {
  int Count = 0;
  int Amount = 0;
  int AcrData = 0;
  List<InOutDivide> DivData = List<InOutDivide>.generate(RcInOut.DIVIDE_SHEET_CNT, (index) => InOutDivide()); //現外区分データ(区分1～9, 0:その他)
}

/// 関連tprxソース: rc_inout.h - struct Price_Data
class PriceData {
  int DrwAmt_Cash = 0;   //理論現金在高
  int DrwAmt_Cha = 0;    //理論会計在高
  int DrwAmt_Chk = 0;    //理論品券在高
  int DrwAmt_Total = 0;  //理論在高合計
  int Total_Cash = 0;    //現金在高
  int Total_Cha = 0;     //会計在高
  int Total_Chk = 0;     //品券在高
  int TotalPrice = 0;    //在高合計
  int AcrPrice = 0;      //釣機合計
  int Diff_Cash = 0;     //現金過不足
  int Diff_Cha = 0;      //会計過不足
  int Diff_Chk = 0;      //品券過不足
  int Diff_Total = 0;    //過不足合計
  int Loan_Cash = 0;     //釣準備(現金)
  int Loan_Cha = 0;      //釣準備(会計)
  int Loan_Chk = 0;      //釣準備(品券)
  int Loan_Total = 0;    //釣準備(合計)
  int Cin_Cash = 0;      //入金(現金)
  int Cin_Cha = 0;       //入金(会計)
  int Cin_Chk = 0;       //入金(品券)
  int Cin_Total = 0;     //入金(合計)
  int Out_Cash = 0;      //支払(現金)
  int Out_Cha = 0;       //支払(会計)
  int Out_Chk = 0;       //支払(品券)
  int Out_Total = 0;     //支払(合計)
  int Pick_Cash = 0;     //売上回収(現金)
  int Pick_Cha = 0;      //売上回収(会計)
  int Pick_Chk = 0;      //売上回収(品券)
  int Pick_Total = 0;    //売上回収(合計)
  int Oth_Cash = 0;      //その他(現金)
  int Oth_Cha = 0;       //その他(会計)
  int Oth_Chk = 0;       //その他(品券)
  int Oth_Total = 0;     //その他(合計)
}

/// 関連tprxソース: rc_inout.h - struct Disp_Data
class DispData {
  // GtkWidget	*window = GtkWidget();
  // GtkWidget	*TitleBar;
  // GtkWidget	*ExitBtn;
  // GtkWidget	*ExecBtn;
  // GtkWidget	*IntBtn;
  // GtkWidget	*RefreshBtn;
  // GtkWidget	*MinusBtn;
  // GtkWidget	*NextPageBtn;
  // GtkWidget	*wFixed;
  // GtkWidget	*PickBtn;
  // GtkWidget	*PrntBtn;
  // GtkWidget	*DrwMsg;			//ドロア合計
  // GtkWidget	*DrwPrice;
  // GtkWidget	*AcrMsg;			//釣機合計
  // GtkWidget	*AcrPrice;
  // GtkWidget	*TtlMsg;			//在高合計
  // GtkWidget	*TtlPrice;
  // GtkWidget	*DrwAmtMsg;			//理論在高合計
  // GtkWidget	*DrwAmtPrice;
  // GtkWidget	*DiffMsg;			//過不足合計
  // GtkWidget	*DiffPrice;
  // GtkWidget	*AcrShtBox;			//釣銭機枚数表示エリア
  // GtkWidget	*AcrShtTitle;			//釣銭機枚数タイトル
  // GtkWidget	*AcrShtLabel[CB_KIND_MAX];	//釣銭機枚数ラベル
  // GtkWidget	*AcrTtlBox;			//釣銭機合計表示エリア
  // //	GtkWidget	*AcrTtlTitle;			//釣銭機合計タイトル
  // //	GtkWidget	*AcrTtlPrice;			//釣銭機合計金額
  // GtkWidget	*DrwTtlBox;			//ドロア合計表示エリア
  // //	GtkWidget	*DrwTtlTitle;			//ドロア合計タイトル
  // //	GtkWidget	*DrwTtlPrice;			//ドロア合計金額
  // GtkWidget	*StockBox;			//在高内訳表示エリア
  // #if 0
  // GtkWidget	*StockTitle;			//在高内訳タイトル
  // GtkWidget	*StockLoan;			//釣準備在高
  // GtkWidget	*StockCin;			//入金在高
  // GtkWidget	*StockOut;			//支払在高
  // GtkWidget	*StockPick;			//売上回収在高
  // GtkWidget	*StockOth;			//その他在高
  // #endif
  // GtkWidget	*StockLabel[DRAWCHK_STOCK_DSP_X_MAX][DRAWCHK_STOCK_DSP_Y_MAX];	//在高内訳ラベル
  // GtkWidget	*MenteCinHalfWin;		//入金画面(半透明ウインドウ)
  // GtkWidget	*MenteCinWin;			//入金画面
  // GtkWidget	*MenteCnclBtn;			//中止ボタン
  // GtkWidget	*MenteCinPrice;			//入金額
  // GtkWidget	*MenteCinStatus;		//釣銭機状態
  // GtkWidget	*MenteCinGuide;			//ガイダンス
  // GtkWidget	*LoanDataTxt1A;			//本日		(釣準備実績データ)
  // GtkWidget	*LoanDataTxt1B;			//n		(釣準備実績データ)
  // GtkWidget	*LoanDataTxt1C;			//回目		(釣準備実績データ)
  // GtkWidget	*LoanDataTxt2;			//釣準備合計	(釣準備実績データ)
  // GtkWidget	*LoanDataTxt3;			//???円		(釣準備実績データ)
  // GtkWidget	*ChgCinBtn;
  // GtkWidget	*ChgStockBtn;
  // GtkWidget	*StatusEntry;
  // GtkWidget	*ent_btn[INOUT_ENTBTN_CNT];	// テンキーボタン 1234567890C
  // GtkWidget	*DrawChk_ExeBtn[DRAWCHK_EXEBTN_CNT];	// 1列分のボタン数
  // GtkWidget	*wNextBtn;
  // GtkWidget	*btn_div;
  // GtkWidget	*ent_div;
  // GtkWidget	*ChgCinCnclBtn;
  // GtkWidget	*ChgCinStatEntry;
  // GtkWidget	*ClosePickBtn;	//従業員精算処理
  // GtkWidget	*DivSheetEntry[DIVIDE_SHEET_CNT];	//区分入力画面券枚数入力エリア
  // GtkWidget	*DivTotalPrice;	//区分入力画面合計額エリア
  // GtkWidget	*exec_div;
  // GtkWidget	*exit_div;
}


/// 関連tprxソース: rc_inout.h - InOut_Info
class InOutInfo {
  DispData	Disp = DispData();
  PriceData Pdata = PriceData();	//Disp_Dataに使用する金額データ
  List<InOutKind> InOutBtn = List<InOutKind>.generate(InoutDisp.INOUT_DIF_MAX, (index) => InOutKind());
  List<InOutSave> SaveData = List<InOutSave>.generate(InoutDisp.INOUT_DIF_MAX, (index) => InOutSave());
  int fncCode = 0;
  int sumLoanCnt = 0;	//累計釣準備回数
  int sumLoanAmt = 0;	//累計釣準備金額
  int stockBtnOff = 0;	//釣機在高ボタン使用不可フラグ
  int	nowPosition = 0;	//メイン画面でのフォーカス位置
  int	subPosition = 0;	//サブ画面でのフォーカス位置
  int	nowDisplay = 0;
  String title = "";
  int	drwchkPickDisplay = 0;
  int chgCinLoanFlg = 0;   /* 1:ChgCinLoan 2:ChgStockLoan */
  int cash = 0;
  int exeFlg = 0;
  int drwOpen = 0;
  int inoutPageNo = 0;
  int dispType = 0;
  int divCd = 0;  //選択された理由区分コード
  String divName = "";	//選択された理由区分名称
  int noEntStart = 0;  //1:置数なし開始 2:置数なし開始->置数された
  int tendEntStart = 0;	 //1:お預りエントリ(INOUT_Y5000)選択した
  int notuseCnt = 0;	//現外キーの書換不可キー数
  int divideCnt = 0;	//現外キーの区分マスタ数
}

/// 関連tprxソース: rc_inout.h - INOUT_DISP_TYPE
class Inout_Disp_Type {
  static const int INOUT_DISP_NOMAL      = 0;
  static const int INOUT_DISP_NEW_NOMAL  = 1;
  static const int INOUT_DISP_NEW_IN     = 2;
  static const int INOUT_DISP_NEW_CHGIN  = 3;
  static const int INOUT_DISP_NEW_OUT    = 4;
  static const int INOUT_DISP_NEW_CHGOUT = 5;
  static const int INOUT_DISP_CASHBACK   = 6;
}

/// 関連tprxソース: rc_inout.h - DRAWCHK_PICK_STEP
class DrawchkPickStep {
  static const int DRAWCHK_PICKSTEP_NON      = 0;
  static const int DRAWCHK_PICKSTEP_SELECT   = 1; //回収選択表示中
  static const int DRAWCHK_PICKSTEP_CALLPICK = 2; //回収選択実行->回収
}

/// 関連tprxソース: rc_inout.h - AcrStockData_Stuct
class AcrStockDataStuct {
  int holder_cnt = 0;
  int overflow_cnt = 0;
  int drawdata_cnt = 0;
  int overflow_box_cnt = 0;
  List<int> img_buf = List<int>.generate(32, (index) => 0);
}
