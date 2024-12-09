#ifndef __tprlog_h
#define __tprlog_h

/* Log Priority Numbers. */
#define TPRERR_EMERG			0
#define TPRERR_ALERT			1
#define TPRERR_ERR			2
#define TPRERR_WARNING			3
#define TPRERR_NOTICE			4
#define TPRERR_INFO			5
#define TPRERR_DEBUG			6


/* Log Mask Constant */
#define TPRERR_MASK(pri)		(1<<(pri))
#define TPRERR_UPTO(pri)		((1<<((pri)+1))-1)
#define TPRERR_ALL			0xffff
#define TPRERR_NONE			0x0000


/* Log Numbers. */
#define	TPRLOG_ERROR			(-1)
#define	TPRLOG_WARNING			0
#define	TPRLOG_NORMAL			1
#define	TPRLOG_OTHER1			2
#define	TPRLOG_OTHER2			3
#define	TPRLOG_OTHER3			4
#define	TPRLOG_OTHER4			5
#define	TPRLOG_FCALL			TPRLOG_OTHER1
#define	TPRLOG_SQL			TPRLOG_OTHER2
#define	TPRLOG_JPN_DISP			6	// 日本語ログ
#define	TPRLOG_HQFTP			9
#define	TPRLOG_DEBUG			99	// デバッグモードのみ出力　サイズ無制限

/* length of Log area */
#define TPRLOG_ITEMLEN			(32 + 1)
#define TPRLOG_ITEMLEN2			(42 + 1)
#define TPRLOG_ITEMLEN3			(48 + 1)
#define TPRLOG_ITEMLEN4			(64 + 1)

/* Offsets of Log Area  */
#define	TPROFFSET_LOGMASK		0
#define	TPROFFSET_LOGCOUNT		TPROFFSET_LOGMASK + sizeof(int)
#define	TPROFFSET_RDPTR			TPROFFSET_LOGCOUNT + sizeof(int)
#define	TPROFFSET_WRPTR			TPROFFSET_RDPTR + sizeof(char *)
#define	TPROFFSET_STARTPTR		TPROFFSET_WRPTR + sizeof(char *)
#define	TPROFFSET_ENDPTR		TPROFFSET_STARTPTR + sizeof(char *)
#define	TPROFFSET_STARTID		TPROFFSET_ENDPTR + sizeof(char *)
#define	TPROFFSET_ENDID			TPROFFSET_STARTID + sizeof(int)

#define	TPRLOGMAXCOUNT			5
#define	TPRLOGFILE			"log/"

#define	TPRLOG_LANG_NAME		"LANG"		// 日本語用ログセットに使用するログファイル名の追加名称

// 日本語用ログにセットする状態 (引数名: status)
typedef	enum
{
	LOG_STATUS_NORMAL = 0,	// 通常
	LOG_STATUS_WARN,	// 警告
	LOG_STATUS_ERR,		// エラー
} TPRLOG_LANG_STATUS;

// 日本語用ログにセットする表示タイプ (引数名: type  [2進数であること])
typedef	enum
{
	LOG_TYPE_NORMAL	= 0,	// 通常表示
	LOG_TYPE_PASS	= 1,	// パスワード入力後に表示(サービスマン用)
	LOG_TYPE_PARENT	= 2,	// ロググループの親となるもの
	LOG_TYPE_CHILD	= 4,	// ロググループの子となるもの
} TPRLOG_LANG_TYPE;

/*
Structure:	Log Structure
Description:Log Structure includes the Error information.
*/

struct	tprlogcore	{				/* Log Core Structure */
	struct tm	Time ;				/* Start time of Decomposing */
	char		hostname[TPRLOG_ITEMLEN] ;	/* 32 char */
									/* string of Host IF Name */
	char 		clientName[TPRLOG_ITEMLEN] ;	/* 32 char */
									/* String of Client Name */
	TPRTID		tid;				/* Task ID */
} ;
typedef	struct	tprlogcore	tprlogcore_t ;


struct	tprlogerror	{
	struct tm	errorTime ;			/* an Error Occurring Time */
	TPRLOGC		logCode ;			/* Error Log Code Number */
	char		description[TPRLOG_ITEMLEN] ;
									/* string of Error Message */
} ;
typedef	struct	tprlogerror	tprlogerror_t ;

struct	tprlogmente	{
	struct	tm	menteTime ;			/*	Logging Time of Mentenance */
	TPRMENTEC	memtec ;			/*	mentenance Log Code Number */
};
typedef	struct	tprlogce	tprlogce_t;

struct	tprloginfo	{
	int		size;				/*	Size of Log String in NVRAM	*/
	int		logID ;				/*	Log ID	*/
};
typedef	struct	tprloginfo	tprloginfo_t;

#endif
/* End of tprlog.h */
