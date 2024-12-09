#ifndef __INCPLUSPOSCONNECTOR__
#define __INCPLUSPOSCONNECTOR__
#pragma pack(push)
#pragma pack( 1 )

#if defined(__linux__) && !defined(LINUX_VER)
#define LINUX_VER
#endif

#ifdef LINUX_VER
// Windows specific types and defines.
#ifndef VOID
#define VOID void
#endif

typedef char CHAR;
typedef short SHORT;
typedef long LONG;
typedef int INT;
typedef void *HANDLE;

typedef unsigned long long ULONGLONG;
typedef unsigned long ULONG;
typedef ULONG *PULONG;
typedef unsigned short USHORT;
typedef USHORT *PUSHORT;
typedef unsigned char UCHAR;
typedef UCHAR *PUCHAR;
typedef char *PSZ;

#ifndef MAX_PATH
#define MAX_PATH          260
#endif

#ifndef FALSE
#define FALSE               0
#endif
#ifndef TRUE
#define TRUE                1
#endif

#ifndef far
#define far
#endif

#ifndef pascal
#define pascal __stdcall
#endif

#ifndef CALLBACK
#define CALLBACK    __stdcall
#endif
#ifndef WINAPI
#define WINAPI
#endif
#ifndef WINAPIV
#define WINAPIV     __cdecl
#endif
#ifndef PASCAL
#define PASCAL      __stdcall
#endif

typedef unsigned long       DWORD;
typedef int                 BOOL;
typedef unsigned char       BYTE;
typedef unsigned short      WORD;
typedef float               FLOAT;
typedef FLOAT               *PFLOAT;
typedef BOOL far            *LPBOOL;
typedef BYTE far            *LPBYTE;
typedef int far             *LPINT;
typedef WORD far            *LPWORD;
typedef long far            *LPLONG;
typedef DWORD far           *LPDWORD;
typedef void far            *LPVOID;
typedef unsigned int        UINT;
#else
#define WIN32_LEAN_AND_MEAN 
#include <windows.h>
#endif //LINUX_VER
#ifndef TRACE0
#define TRACE0(x) /**/
#endif

/*=====================================================
	PlusPosConnector.h
	Version 1.0	2017-03-31
=====================================================*/
/*-----------------------------------------------------
	HeaderData	共通ヘッダ
-----------------------------------------------------*/
typedef struct	_HeaderData {
	CHAR	BusinessCode		[ 4];	// 業務コード
	char	BusinessSubCode;			// 業務サブコード
	CHAR	ProcessDate			[ 7];	// 処理日付
	CHAR	ProcessTime			[ 7];	// 処理時刻
	CHAR	TerminalID			[14];	// 端末識別番号
	CHAR	SlipNumber			[ 6];	// 端末処理通番
	char	TerminalType;				// 端末識別区分
	CHAR	ExtraA0				[ 9];	// 予備
	CHAR	OperatorCode		[ 6];	// 担当者コード
	CHAR	Memo1				[11];	// メモ１
	CHAR	Memo2				[11];	// メモ２
	char	TestModeFlag;				// TESTモードフラグ
	CHAR	ExtraA1				[11];	// 予備
	char	ProcessingResult;	// 処理結果
	CHAR	ErrorCode			[ 4];	// エラーコード
	CHAR	Message1			[24];	// メッセージ１
	CHAR	Message2			[24];	// メッセージ２
	CHAR	ResponseCode		[ 5];	// レスポンスコード
	char	DllFlag;					// ＤＬＬフラグ
	CHAR	ExtraA2				[11];	// 予備
}	HeaderData;
/*-----------------------------------------------------
	SettleData	決済要求
-----------------------------------------------------*/
typedef struct	_SettleData {
	char	ReversalType;				// 取消指令区分
	char	ProcessType;				// 処理区分
	char	ApprovalType;				// 承認区分
	CHAR	ApprovalNumber		[ 8];	// 承認番号
	char	CardType;					// カード種類
	CHAR	SalesAmount			[ 9];	// 取扱金額
	CHAR	TaxPostage			[ 8];	// 税送料
	CHAR	GoodsCode			[ 8];	// 商品コード
	CHAR	TradingDate			[ 7];	// 取引日
	CHAR	BusinessDate		[ 7];	// 営業日
	CHAR	PIN					[ 5];	// 暗証番号
	CHAR	OriginalSlipNumber	[ 6];	// 元伝票番号
	CHAR	OriginalTradingDate	[ 7];	// 元取引日
}	SettleData;
/*-----------------------------------------------------
	CardData	カードデータ
-----------------------------------------------------*/
typedef struct	_CardData {
	char	Type;			// カード利用区分
	CHAR	CardData1	[38];	// JIS1カード情報
	CHAR	CardData2	[70];	// JIS2カード情報
}	CardData;
/*-----------------------------------------------------
	ICData	ICカード
-----------------------------------------------------*/
typedef struct	_ICData {
	CHAR	AID						[33];	// AID(ApplicationID)
	char	TerminalforICFlag;				// IC対応端末フラグ
	char	MSorICInformationType;			// MS/IC情報取得区分
	char	PANInputMode;					// PAN入力モード
	char	PINInputFunction;				// PIN入力機能
	CHAR	PANSequenceNumber		[ 3];	// PANシーケンスナンバー
	char	EncodeType;						// エンコード種別
	char	OnOffType;						// オン/オフ区分
	char	TipConditionCode;				// チップコンディションコード
	CHAR	BrandType				[ 3];	// ブランド種別
	CHAR	StorageData			   [341];	// 格納データ
	CHAR	StorageDataLength		[ 5];	// 格納データ長
	CHAR	TerminalProcessingTime	[ 7];	// 端末処理時間
	CHAR	TerminalProcessingDate	[ 9];	// 端末処理日付
	char	DealingResult;					// 取引結果
	char	ProcessingLevel;				// 処理レベル
	char	ForcedOnline;					// 強制オンライン
	char	ForcedApproval;					// 強制承認
}	ICData;
/*-----------------------------------------------------
	PaymentData	支払方法
-----------------------------------------------------*/
typedef struct	_PaymentData {
	CHAR	PaymentType			[ 3];	// 支払区分
	CHAR	PaymentStartMonth	[ 3];	// 支払開始月
	CHAR	BonusAmount01		[ 9];	// 初回金額ﾎﾞｰﾅｽ金額(1)／分割金額(1)
	CHAR	BonusAmount02		[ 9];	// ﾎﾞｰﾅｽ金額(2)／分割金額(2)
	CHAR	BonusAmount03		[ 9];	// ﾎﾞｰﾅｽ金額(3)／分割金額(3)
	CHAR	BonusAmount04		[ 9];	// ﾎﾞｰﾅｽ金額(4)／分割金額(4)
	CHAR	BonusAmount05		[ 9];	// ﾎﾞｰﾅｽ金額(5)／分割金額(5)
	CHAR	BonusAmount06		[ 9];	// ﾎﾞｰﾅｽ金額(6)／分割金額(6)
	CHAR	InstallmentNumber	[ 3];	// 分割回数
	CHAR	BonusNumber			[ 3];	// ボーナス回数
	CHAR	BonusMonth01		[ 3];	// ボーナス月(1)
	CHAR	BonusMonth02		[ 3];	// ボーナス月(2)
	CHAR	BonusMonth03		[ 3];	// ボーナス月(3)
	CHAR	BonusMonth04		[ 3];	// ボーナス月(4)
	CHAR	BonusMonth05		[ 3];	// ボーナス月(5)
	CHAR	BonusMonth06		[ 3];	// ボーナス月(6)
}	PaymentData;
/*-----------------------------------------------------
	SettleResponse	決済応答
-----------------------------------------------------*/
typedef struct	_SettleResponse {
	CHAR	ApprovalNumber			[ 8];	// 承認番号
	CHAR	ApprovalDate			[ 7];	// 承認取得日
	CHAR	CenterProcessNumber		[ 7];	// センター処理通番
	char	CenterDistinction;				// センタ識別
	CHAR	AcquirerCompanyCode		[12];	// 仕向会社コード
	CHAR	ExpirationDate			[ 5];	// 有効期限
	CHAR	SwcProcessingDate		[ 5];	// ＳＷセンタ処理月日
	char	OnlineStateFlag;				// オンライン状態フラグ
	CHAR	IcOnlineResponse		[ 3];	// ICｵﾝﾗｲﾝｵｰｿﾘ　ﾚｽﾎﾟﾝｽ
}	SettleResponse;
/*-----------------------------------------------------
	CreditResponse	クレジット応答
-----------------------------------------------------*/
typedef struct	_CreditResponse {
	CHAR	PAN						[20];	// 会員番号
	CHAR	CardCompanyCode			[ 6];	// カード会社コード
	CHAR	CardCompanyName			[11];	// カード会社名
	CHAR	CardCompanyTEL			[16];	// カード会社ＴＥＬ
	CHAR	CompanyCodeforPOS		[ 3];	// POS用会社コード
	char	BusinessConditionsCode;			// 業態コード
	char	TieupType;						// 提携区分
	char	SignlessFlag;					// サインレスフラグ
	CHAR	NegaErrorCode			[ 3];	// ネガ判定結果コード
	CHAR	InquiryInfo01			[31];	// 問い合せ情報１
	CHAR	InquiryInfo02			[31];	// 問い合せ情報２
}	CreditResponse;

/*-----------------------------------------------------
	InquiryResponse	問合せ応答
-----------------------------------------------------*/
typedef struct	_InquiryResponse {
	CHAR	CardCompanyCode				[ 6];	// 発行カード会社コード
	CHAR	CardCompanyName				[11];	// 発行カード会社名
	char	PaymentCheck;						// 支払方法チェック
	CHAR	PaymentCode					[21];	// 支払方法コード
	char	InstallmentCheckFlag;				// 分割支払可能回数チェック
	CHAR	InstallmentNumber			[41];	// 分割支払可能回数
	CHAR	InstallmentFrom				[ 3];	// 分割支払可能回数Ｆｒｏｍ
	CHAR	InstallmentTo				[ 3];	// 分割支払可能回数Ｔｏ
	char	BonusMonthCheckFlag;				// ボーナス支払チェック
	CHAR	BonusMonthSummer01			[ 3];	// 夏ボーナス支払月(1)
	CHAR	BonusMonthSummer02			[ 3];	// 夏ボーナス支払月(2)
	CHAR	BonusMonthWinter01			[ 3];	// 冬ボーナス支払月(1)
	CHAR	BonusMonthWinter02			[ 3];	// 冬ボーナス支払月(2)
	char	BonusPeriodCheckFlag;				// ﾎﾞｰﾅｽ支払期間チェック
	CHAR	BonusPeriodSummerFromDate	[ 5];	// 夏ボーナス利用開始月日
	CHAR	BonusPeriodSummerToDate		[ 5];	// 夏ボーナス利用終了月日
	CHAR	BonusPeriodWinterFromDate	[ 5];	// 冬ボーナス利用開始月日
	CHAR	BonusPeriodWinterToDate		[ 5];	// 冬ボーナス利用終了月日
}	InquiryResponse;
/*-----------------------------------------------------
	ExtInquiryResponse	拡張問合せ応答
-----------------------------------------------------*/
typedef struct	_ExtInquiryResponse {
	CHAR	CreditCompanyPublicCode		[ 6];	// カード会社流開コード
	CHAR	CreditCompanyName			[17];	// クレジット会社名
	CHAR	CreditCompanyReserveCode	[11];	// クレジット会社・（予備）コード
	char	CreditCompanyType;					// クレジット会社区分
	CHAR	IssuerCodeForManualInput	[12];	// 被仕向会社コード
	CHAR	AuthorizationTEL			[16];	// オーソリ先TEL
	CHAR	KID							[ 4];	// ＫＩＤ
	CHAR	BonusMonthSummer03			[ 3];	// 夏ボーナス支払月(3)
	CHAR	BonusMonthSummer04			[ 3];	// 夏ボーナス支払月(4)
	CHAR	BonusMonthSummer05			[ 3];	// 夏ボーナス支払月(5)
	CHAR	BonusMonthSummer06			[ 3];	// 夏ボーナス支払月(6)
	CHAR	BonusMonthWinter03			[ 3];	// 冬ボーナス支払月(3)
	CHAR	BonusMonthWinter04			[ 3];	// 冬ボーナス支払月(4)
	CHAR	BonusMonthWinter05			[ 3];	// 冬ボーナス支払月(5)
	CHAR	BonusMonthWinter06			[ 3];	// 冬ボーナス支払月(6)
	char	PaymentType25Repeat;				// ボーナス金額の繰返し／「２５」
	char	PaymentType34Repeat;				// ボーナス金額の繰返し／「３４」
	CHAR	LimitFirstTimeAmount		[ 9];	// 初回金額／下限値「６３」
	CHAR	LimitUpperNumber22			[ 3];	// ボーナス回数／上限値「２２」
	CHAR	LimitUpperNumber24			[ 3];	// ボーナス回数／上限値「２４」
	CHAR	LimitUpperNumber25			[ 3];	// ボーナス回数／上限値「２５」
	CHAR	LimitUpperNumber33			[ 3];	// ボーナス回数／上限値「３３」
	CHAR	LimitUpperNumber34			[ 3];	// ボーナス回数／上限値「３４」
	char	PaymentStartMonth31;				// 支払開始月／「３１」
	char	PaymentStartMonth32;				// 支払開始月／「３２」
	char	PaymentStartMonth33;				// 支払開始月／「３３」
	char	PaymentStartMonth34;				// 支払開始月／「３４」
	char	PaymentStartMonth61;				// 支払開始月／「６１」
	char	PaymentStartMonth62;				// 支払開始月／「６２」
	char	PaymentStartMonth63;				// 支払開始月／「６３」
	CHAR	LimitCheckPaymentCode01		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０１
	CHAR	LimitCheckUpperAmount01		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０１
	CHAR	LimitCheckLowerAmount01		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０１
	CHAR	LimitCheckPaymentCode02		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０２
	CHAR	LimitCheckUpperAmount02		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０２
	CHAR	LimitCheckLowerAmount02		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０２
	CHAR	LimitCheckPaymentCode03		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０３
	CHAR	LimitCheckUpperAmount03		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０３
	CHAR	LimitCheckLowerAmount03		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０３
	CHAR	LimitCheckPaymentCode04		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０４
	CHAR	LimitCheckUpperAmount04		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０４
	CHAR	LimitCheckLowerAmount04		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０４
	CHAR	LimitCheckPaymentCode05		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０５
	CHAR	LimitCheckUpperAmount05		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０５
	CHAR	LimitCheckLowerAmount05		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０５
	CHAR	LimitCheckPaymentCode06		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０６
	CHAR	LimitCheckUpperAmount06		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０６
	CHAR	LimitCheckLowerAmount06		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０６
	CHAR	LimitCheckPaymentCode07		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０７
	CHAR	LimitCheckUpperAmount07		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０７
	CHAR	LimitCheckLowerAmount07		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０７
	CHAR	LimitCheckPaymentCode08		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０８
	CHAR	LimitCheckUpperAmount08		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０８
	CHAR	LimitCheckLowerAmount08		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０８
	CHAR	LimitCheckPaymentCode09		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分０９
	CHAR	LimitCheckUpperAmount09		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額０９
	CHAR	LimitCheckLowerAmount09		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額０９
	CHAR	LimitCheckPaymentCode10		[ 3];	// 支払方法毎のﾘﾐｯﾄ／支払区分１０
	CHAR	LimitCheckUpperAmount10		[ 9];	// 支払方法毎のﾘﾐｯﾄ／上限金額１０
	CHAR	LimitCheckLowerAmount10		[ 9];	// 支払方法毎のﾘﾐｯﾄ／下限金額１０
}	ExtInquiryResponse;
/*-----------------------------------------------------
	CupData	銀聯カード
-----------------------------------------------------*/
typedef struct	_CupData {
	CHAR	CancelSystemNumber		[ 7];	// 取消／返品　銀聯番号
	CHAR	CancelProcessDate		[13];	// 取消／返品　取引日付
	CHAR	CancelApprovalNumber	[ 7];	// 取消／返品　承認番号
}	CupData;
/*-----------------------------------------------------
	ICPrintInfo	IC印字情報 [POS連動用]
-----------------------------------------------------*/
typedef struct	_ICPrintInfo {
	CHAR	AID						[14];	// AID(ApplicationID)
	CHAR	AplLavel				[33];	// アプリケーションラベル
	CHAR	ATC						[ 6];	// ATC
	CHAR	CardSequenceNumber		[ 3];	// カードシーケンス番号
	char	IcMsType;						// IC/MS識別子
	char	ConfirmedPIN;					// 暗証番号確認済み
	char	SignlessFlag;					// サイン省略
	CHAR	Extra1					[25];	// 予備１
	CHAR	Extra2					[25];	// 予備２
	CHAR	Extra3					[25];	// 予備３
}	ICPrintInfo;

/*-----------------------------------------------------
	Config	接続先設定
-----------------------------------------------------*/
typedef struct	_Config {
	BOOL			SvFlag;				// 内部処理用フラグ：サブサーバの有無フラグ
	BOOL			SwFlag;				// 内部処理用フラグ：サブサーバへ切り替え中フラグ
	CHAR			Address		[16];	// 接続先サーバIP
	CHAR			AddressSub	[16];	// 接続先サブサーバIP
	unsigned int	Port;				// 接続先サーバPort
	unsigned int	PortSub;			// 接続先サブサーバPort
	unsigned int	RecvTimeOut;		// 電文受信待ち時間(sec)
	unsigned int	ConnTimeOut;		// コネクション取得待ち時間(sec)
	int				RetryCount;			// コネクションリトライ回数[*********未使用***************]
	BOOL			LogFlag;			// ログ出力判定フラグ
	CHAR			LogFilePath [128];	// ログ出力先フォルダ：指定無の場合カレントフォルダに出力
	int				LogSaveDate;		// ログ保存日数：0指定の場合無制限
	BOOL			DevFlag;			// 開発用 DLL内部折返しフラグ
	BOOL			TrainingModeFlag;	// トレーニングモードフラグ[POS連動用]
	CHAR			ComNo[24];		// シリアルポート名：Windowsの場合"COM1"等、Linuxの場合"/dev/ttyS1"等[POS連動用]
}	Config;
/*-----------------------------------------------------
	★CreditParam	クレジット[磁気 マニュアル 端末判定 ICカード]
-----------------------------------------------------*/
typedef	struct _CreditParam{
	HeaderData		Header;
	SettleData		Settle;
	PaymentData		Payment;
	SettleResponse	RSettle;
	CreditResponse	RCredit;
	ICPrintInfo		ICPrint;  // POS連動用追加フィールド
}	CreditParam;
/*-----------------------------------------------------
	★InquiryParam	問合せ
-----------------------------------------------------*/
typedef	struct	_InquiryParam{
	HeaderData			Header;
	SettleData			Settle;
	CreditResponse		RCredit;
	InquiryResponse		RInquiry;
	ExtInquiryResponse	RExtInquiry;
}	InquiryParam;

/*-----------------------------------------------------
	★CupParam	銀聯
-----------------------------------------------------*/
typedef	struct	_CupParam{
	HeaderData		Header;
	SettleData		Settle;
	CupData			Cup;
	SettleResponse	RSettle;
	CreditResponse	RCredit;
}	CupParam;

/*-----------------------------------------------------
	★MscParam	MSカード
-----------------------------------------------------*/
typedef	struct	_PosMsParam{
	HeaderData		Header;
	CardData		Card;
}	PosMsParam;

/*-----------------------------------------------------
	★CgcParam	CoGCa
-----------------------------------------------------*/
typedef	struct	_PosCoGCaParam{
	HeaderData		Header;
	CardData		Card;
}	PosCoGCaParam;

/*-----------------------------------------------------
	関数宣言
-----------------------------------------------------*/
#ifdef  __cplusplus
extern "C" {
#endif	/*	__cplusplus	*/

	void WINAPI makePlusPos (Config *Conf);
	// クレジット
	BOOL WINAPI startPlusPosCredit (CreditParam *CParam, InquiryParam *IParam, Config *Conf);
	BOOL WINAPI PlusPosCredit (CreditParam *CParam, Config *Conf);
	BOOL WINAPI PlusPosInquiry (InquiryParam *IParam,	Config *Conf);
	BOOL WINAPI endPlusPosCredit (CreditParam *CParam,	InquiryParam *IParam, Config *Conf);
	// 銀聯
	BOOL WINAPI startPlusPosCup (CupParam *Param, Config *Conf);
	BOOL WINAPI PlusPosCup (CupParam *Param, Config *Conf);
	BOOL WINAPI endPlusPosCup (CupParam *Param, Config *Conf);
	// MSカード
	BOOL WINAPI startPlusPosMsRead (PosMsParam *Param, Config *Conf);
	BOOL WINAPI PlusPosMsRead (PosMsParam *Param, Config *Conf);
	BOOL WINAPI endPlusPosMsRead (PosMsParam *Param, Config *Conf);
	// CoGCa
	BOOL WINAPI startPlusPosCoGCaRead (PosCoGCaParam *Param, Config *Conf);
	BOOL WINAPI PlusPosCoGCaRead (PosCoGCaParam *Param, Config *Conf);
	BOOL WINAPI endPlusPosCoGCaRead (PosCoGCaParam *Param, Config *Conf);


	BOOL WINAPI PlusPosRegisterCancelCallback(BOOL (*C)(void), Config* conf);

#ifdef  __cplusplus
}
#endif
#pragma pack(pop)
#endif /*__INCPLUSPOSCONNECTOR__*/