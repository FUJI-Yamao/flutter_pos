/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:collection/collection.dart';

///
/// 関連tprxソース: apllib.h - QUICK_SETUP_TYPE_NO
enum QuickSetupTypeNo{
  QUICK_SETUP_TYPE_NONE (0),
  QUICK_SETUP_TYPE_9191(1),
  QUICK_SETUP_TYPE_9192(2),
  QUICK_SETUP_TYPE_9193(3),
  QUICK_SETUP_TYPE_9194(4),
  QUICK_SETUP_TYPE_9195(5),
  QUICK_SETUP_TYPE_9196(6),
  QUICK_SETUP_TYPE_9197(7),
  QUICK_SETUP_TYPE_9198(8),
  QUICK_SETUP_TYPE_9199(9),
  QUICK_SETUP_TYPE_9190 (90),
  QUICK_SETUP_TYPE_RSV_CUSTREAL (96),
  QUICK_SETUP_TYPE_HC1 (97),
  QUICK_SETUP_TYPE_NEW (98),
  QUICK_SETUP_TYPE_RSV_TAX (99),
  QUICK_SETUP_NG1 ( -1),
  QUICK_SETUP_NG2 (-2),
  QUICK_SETUP_NG ( -3);

  final int no;
  const QuickSetupTypeNo(this.no);

}

class BAR_inf {
  String Code = "";
  int    flag = 0;
}

/// 関連tprxソース:apllib.h -UT_INFO
class UtInfo {
  int result = 0;
  int seqNo = 0;
  int resultCode = 0;
  int resultCodeExtended = 0;
  String centerResultCode = '';
}

/// 関連tprxソース: apllib.h - TMN_EJ_TYP
enum TMN_EJ_TYP {
	TMN_OBS_DEAL_QP,	/* QP不明取引 */
	TMN_DAILY_QP,		/* QP日計処理 */ 
	TMN_OBS_DEAL_iD,	/* iD不明取引 */
	TMN_DAILY_iD,		/* iD日計処理 */ 
  TMN_OBS_DEAL_Edy,       /* Edy不明取引 */
  TMN_DAILY_Edy,          /* Edy日計処理 */
}


// TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
///  関連tprxソース: apllib.h - USBCAM_STAT
enum UsbCamStat{
  CK_CAM_STOP,
  CK_CAM_START,
  CA_CAM_STOP,
  CA_CAM_START,
  QC_CAM_STOP,
  QC_CAM_START,
  SP_CAM_START
}

///関連tprxソース:apllib.h - OpeTimeFlgs構造体
enum OpeTimeFlgs {
  OPETIME_START,
  OPETIME_END,
  OPETIME_CNCL,
  OPETIME_STOP_START,
  OPETIME_STOP_END,
  OPETIME_OFFMODE_START,
  OPETIME_OFFMODE_END,
  OPETIME_CSHR_OPN
}

/// 関連tprxソース:apllib.h
class AplLib {
  static const UPD_DIRNM = "%s/tmp/upd";
  static const UPD_OLDDIRNM = "%s/tmp/upd/old";
  static const RXFILE_OK = 0;
  static const RXFILE_NG = -1;

  // ----- sysini.c AplLib_version.c
  static const VERUP_HIST_FILE = "/tmp/verup_history.txt";
  static const VERUP_HIST_FILE_CP = "/log/verup_history.txt";

  static const AFTER_VUP_FREQ_FILE = "/tmp/after_vup_freq.txt";

  static const FILELIST = "filelist.txt";
  static const NOCHECK = "nocheck.txt";

  static const UPD_NMINIT = 'upd';
  static const VOIDEJ_MEM_HEADNAME = "voidej_";
  static const VOIDEJ_MEM_FNAME = '$VOIDEJ_MEM_HEADNAME%06ld%04ld%04ld';
  static const VOIDEJ_MEM_FULLNAME = '$UPD_DIRNM/$VOIDEJ_MEM_FNAME';

  static const TAXFREE_INI = "taxfree.ini";
  static const TAXFREE_CHK_TIME = 200;
  static const URL_BUF_SIZE = 512;
  static const TAXFREE_DIR = "/tmp/taxfree/";
  static const TAXFREE_LOG_DIR = "/tmp/taxfree/log/";
  static const TAXFREE_ERR_DIR = "/tmp/taxfree/err/";
  static const TAXFREE_OLD_DIR = "/tmp/taxfree/old/";
  static const TAXFREE_OLD_ERR_DIR = "/tmp/taxfree/err/old/";
  static const TAXFREE_DIR_TMP = "/tmp/taxfree/tmp/";
  static const TAXFREE_REREKI = "Rireki_";
  static const TAXFREE_REREKI_CNCL = "CNCL";
  static const TAXFREE_REREKI_REGS = "REGS";
  static const TAXFREE_REREKI_CHECK = "CHECK";
  static const TAXFREE_TMP_FILE = "tmp_body.dat";
  static const BOUNDARY_TXT = "AabbZ";
  static const BOUNDARY_END_TXT = "---AabbZ--";
  static const TAXFREE_SND_HEADER = "taxfree_";
  static const TAXFREE_RIREKI_HEADER = "Rireki_";
  static const TAXFREE_LIQUOR_HEADER = "Liquor_Rireki_";
  static const TAXFREE_SND_HEADER_DEMO = "DEMO_taxfree_";
  static const TAXFREE_RIREKI_HEADER_DEMO = "DEMO_Rireki_";
  static const TAXFREE_LIQUOR_HEADER_DEMO = "DEMO_Liquor_Rireki_";
  static const TAXFREE_RIREKI_FILE = "Rireki.tsv";
  static const TAXFREE_LIQUOR_FILE = "Liquor_Rireki.csv";
  static const APL_D_CR = 0x0D;
  static const APL_D_LF = 0x0A;
  static const TAXFREE_BKUP_ERR_FILE_H = "Taxfree_err_";
  static const TAXFREE_BKUP_FILE_H = "Taxfree_";
  static const TAXFREE_BKUP_PASSWORD = "teraoka3752";
  static const GETTYPE_NOTSEND = 0;
  static const GETTYPE_ERR = 1;
  static const SERVER_BUSINESS = 0;
  static const SERVER_DEMO = 1;
  static const HC7_QR_SEPARATE = "~";

  //メッセージ関連
  static const DIALOG_DIR = "tmp/DiaLog";
  static const DIALOG_FILE = "DiaLog_";
  static const DIALOG_EX_FILE = "DiaLog_EX_";
  static const LOYTGT_FILE = "Loytgt_";

  static const MST_READ_EJ_NAME = "mst_read_ej.txt";
  static const MST_READ_ERR_NAME = "mst_read_err.txt";
  static const EJ_LENGTH = 54;
  static const EJ_TMN_PRN_FILE = "tmn_prn.txt";

  static const EJ_CLOSE_TXT = "ej_close.txt";
  static const EJ_OPEN_TXT = "ej_open.txt";
  static const EJDATA_TXT = "ejdata.txt";

  // 自動開閉設LIBの戻り値
  static const AUTOLIB_ERROR = -100;
  static const AUTOLIB_SUCCESS = 0;

  static const AUTO_MSG_ERR	= "0,ERR%i";		//エラー送信
  static const AUTO_MSG_ERRCLR = "0,ERRCLR";		//エラー解除
  static const AUTO_MSG_COMP = "0,ERR";

  static const SPEC_BKUP_TAR_NG_TXT_DATE_NONE	= "%s/tmp/spec_bkup/work/spec_bkup_tar_ng.txt";

  static const INI_GET = 0;
  static const INI_SET = 1;

  //compress_lib.c
  static const RECAL_TRAN_DIR =	"/web21ftp/backup/";

  static const RXFTP_GET = 1;
  static const RXFTP_PUT = 2;
  static const RXFTP_DEL = 3;
  static const RXFTP_PUT3 = 4;
  static const RXFTP_DEL3 = 5;
  static const RXFTP_GET3 = 6;
  static const RXFTP_MGET = 7;
  static const RXFTP_MGET3 = 8;
  static const RXFTP_MPUT3 = 9;
  static const RXFTP_SIZE = 10;
  static const RXFTP_MDEL = 11;
  static const RXFTP_NLIST = 12;
  static const RXFTP_TMP_FILE = "/tmp/ftp_tmp.txt";
  static const RXFTP_LOG_FILE = "/tmp/FTPLOG.txt";

  static const RXFTP_EXIST = 1;
  static const RXFTP_NOTEXIST = 2;
  static const RXFTP_OK	= 0;
  static const RXFTP_NG	= -1;
  static const RXFTP_TOUT	= -2;
  static const RXFTP_NONE = -3;
  static const RXFTP_FINISH = 0;
  static const RXFTP_START = 1;
  static const RXFTP_KILL = 2;
  static const RXFTP_END = 3;
  static const RXFTP_ERREND = 4;
  static const RXFTP_WAITING = 5;

  static const HQCONNECT_BKUP_DIRNAME = '/hqftp/backup/';	// バックアップディレクトリ

// 各上位接続でのバックアップファイル名接尾詞
  static const BKUP_ADD_NAME_NETDOA_CLS = "_netDoA_cls";
  static const BKUP_ADD_NAME_NETDOA_EJ = "_netDoA_ej";
  static const BKUP_ADD_NAME_TS_LGYOUMU = "_TS_lgyoumu";
  static const BKUP_ADD_NAME_CSS_GYOUMU = "_CSS_gyoumu";

  static const TAXFREE_CHG_INI = "taxfree_chg.ini";

  static const UPD_ERR_LOG_NAME	= "/home/postgres/upd_err.log";
  static const UPDERRLOG_CREATE_DATA	= "%04d-%02d-%02d %02d:%02d:%02d\t%d\t%d\t%s\n";
  static const UPD_ERLOG_MV_FNAME	= "%s/log/Upd_erlog_history%06ld%04d%02d%02d%02d%02d%02d";

  static const MM_REPT72_DIFF_FNAME = "%s/tmp/mm_rept72_differ.list";
  static const USBCAM_DIR	= "/ext/usbcam/";

  static const GUI_PAGE_ECS777 = 20; //個定値 フォーマット変更があった場合変更する可能性あり
  static const GUI_PAGE_MAX	= GUI_PAGE_ECS777;	//上記の中の最大値を指定（配列の用意数に関係）

  static AcxErrGUIData acxErrData = AcxErrGUIData();

  static const SALE_CHK_DD = 0;
  static const SALE_CHK_RDLY = 1;
  static const SALE_CHK_ALL	= 1;
}

/// 関連tprxソース:apllib.h -EucAdj
class EucAdj {
  int byte = 0;
  int count = 0;
}

class CtrlAdj {
  String pChar = '';
  int res = 0;
}

// 自動開閉設の実行状態
/// 関連tprxソース: apllib.h - AUTORUN
enum AutoRun{
  AUTORUN_NON(0), // なし(手動)
  AUTORUN_STROPN(1), // 自動開店処理
  AUTORUN_STRCLS2(2); // 自動閉店処理(一括精算)

  final int val;

  const AutoRun(this.val);

  /// keyIdから対応するDateTimeFormatKindを取得する.
  static AutoRun getDefine(int val) {
    AutoRun? define =
    AutoRun.values.firstWhereOrNull((a) => a.val == val);
    define ??= AutoRun.AUTORUN_NON; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

// 自動開閉設の動作モード
// 追加した場合は、AplLib_LogWrite()にも追加すること
/// 関連tprxソース: apllib.h - AUTOMODE
enum AutoMode {
  AUTOMODE_NON(0), // なし(手動)

  // 開店動作
  AUTOMODE_STROPN(1), // 開設処理
  AUTOMODE_STAFFOPEN(2), // 従業員オープン
  AUTOMODE_STROPN_QCMENTE(3), // QCashierメンテナンス
  AUTOMODE_KY_LOAN(4), // 釣準備
  AUTOMODE_KY_LOAN_DATA(5), // 釣準備実績自動作成（フレスタ様)
  AUTOMODE_KY_CHGREF(6), // 釣機参照
  AUTOMODE_STROPN_QCMNTRET(7), // QCashierメンテナンスから戻る
  AUTOMODE_KY_2PERSON(8), // 簡易従業員　２人制キー
  AUTOMODE_2PERSON_CHKROPEN(9), // 簡易従業員　チェッカーオープン

  // 閉店動作
  AUTOMODE_PASSWORD(101), // 精算業務(パスワード)
  AUTOMODE_ACXDRWCHK(102), // 釣機の在高チェック
  AUTOMODE_RECALC(103), // 釣機再精査
  AUTOMODE_BATREPO(104), // 予約レポート出力
  AUTOMODE_STRCLS_QCMENTE(105), // QCashierメンテナンス
  AUTOMODE_STAFF2CLOSE(106), // 簡易従業員２人制クローズ
  AUTOMODE_KY_OVERFLOW_MENTE(107), // ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ
  AUTOMODE_KY_DRWCHK(108), // 差異チェック
  AUTOMODE_KY_PICK(109), // 売上回収
  AUTOMODE_CM_CHGOUT(110), //キャッシュマネジメント出金
  AUTOMODE_CM_CHGIN(111), //キャッシュマネジメント入金
  AUTOMODE_KY_CHGPICK(112), // 釣機回収
  AUTOMODE_STAFFCLOSE(113), // 従業員クローズ
  AUTOMODE_PBCHGUTIL(114), // 収納業務
  AUTOMODE_SALEINFO_SEND(115), // 売上情報送信
  AUTOMODE_BATREPO2(116), // (未使用)予約レポート出力２
//	AUTOMODE_BATREPO3,			// 閉設前の予約レポート出力
  AUTOMODE_STRCLS(117), // 閉設処理
  AUTOMODE_END(118); // 終了

  final int val;

  const AutoMode(this.val);

  /// keyIdから対応するDateTimeFormatKindを取得する.
  static AutoMode getDefine(int val) {
    AutoMode? define =
    AutoMode.values.firstWhereOrNull((a) => a.val == val);
    define ??= AutoMode.AUTOMODE_NON; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

/// 関連tprxソース: apllib.h - AUTOSTEP
enum AutoStep {
  // 閉店動作(キャッシュマネジメント)
  AUTOSTEP_NONE(0),
  AUTOSTEP_ACXINFO(10), //info of acx
  AUTOSTEP_STRCLS_START(101), // 自動精算開始
  AUTOSTEP_RECALC(102), // 釣機再精査
  AUTOSTEP_STAFFOPEN(103), // 従業員オープン
  AUTOSTEP_DRWCHK(104), // 差異チェック
  AUTOSTEP_PICK(105), // 売上回収
  AUTOSTEP_RECYCLE_CHGOUT(106), // キャッシュリサイクル出金
  AUTOSTEP_RECYCLE_CHGIN(107), // キャッシュリサイクル入金
  AUTOSTEP_CHGPICK(108), // 釣機回収
  AUTOSTEP_STAFFCLS(109), // 従業員クローズ
  AUTOSTEP_PGCHGUITIL(110), // 収納業務(未使用)
  AUTOSTEP_SALEINFO_SEND(111), // 売上情報送信
  AUTOSTEP_BATREPO(112), // 約レポート出力
  AUTOSTEP_STRCLS(113), // 閉設処理
  AUTOSTEP_OVERFLOW_MENTE(114);	// ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ

  final int val;
  const AutoStep(this.val);

  /// keyIdから対応するDateTimeFormatKindを取得する.
  static AutoStep getDefine(int val) {
    AutoStep? define =
    AutoStep.values.firstWhereOrNull((a) => a.val == val);
    define ??= AutoStep.AUTOSTEP_NONE; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

/// 関連tprxソース: apllib.h - APLLIB_HISTLOG_RESULT_FILE_TYP
enum AplLibHistlogResultTyp {
	APLLIB_HISTLOG_RES_ERR_CHECK,	// 登録制限ファイルの存在確認(警告レベル低の場合は制限ファイルを削除)
	APLLIB_HISTLOG_RES_FILE_CREATE,		// 登録制限ファイル, または, 共有メモリ更新ファイル作成
	APLLIB_HISTLOG_RES_FILE_DELETE;		// 上記のどちらか削除
}

/// 自動開閉設の電子ジャーナル
/// 関連tprxソース: apllib.h - AUTOLIB_EJ
enum AutoLibEj {
  AUTOLIB_EJ_ERROR(-1),  // エラー
  AUTOLIB_EJ_STOP(0),  // 中止
  AUTOLIB_EJ_START(1),  // 開始
  AUTOLIB_EJ_END(2),  // 終了
  AUTOLIB_EJ_STEP_START(3),  //Step処理開始
  AUTOLIB_EJ_SKIP(4),  // skip
  AUTOLIB_EJ_OK(5),  // 正常終了
  AUTOLIB_EJ_NG(6),  // 異常終了
  AUTOLIB_EJ_FORCE_TRY(7),  // 強制閉設チェック
  AUTOLIB_EJ_FORCE_CANT(8),  // 強制閉設不可
  AUTOLIB_EJ_FORCE_CNCL(9),  // 強制閉設中止
  AUTOLIB_EJ_FORCE_START(10);  // 強制閉設開始
  final int value;

  const AutoLibEj(this.value);
}

/// 自動開閉設メッセージ
/// 関連tprxソース: apllib.h - #define AUTO_MSG_*
class AutoMsg {
  static const AUTO_MSG_START = "0,START";  //ステップ処理開始
  static const AUTO_MSG_END = "0,END";  //ステップ処理終了
  static const AUTO_MSG_SKIP = "0,SKIP";  //ステップ処理スキップ
  static const AUTO_MSG_SKIP2 = "1,SKIP";  //ステップ処理スキップ
  static const AUTO_MSG_OPERAT = "0,OPERA";  //操作要求
  static const AUTO_MSG_CNCL = "0,CNCL";  //自動化中止
  static const AUTO_MSG_NG = "%i,NG";  //ステップ処理NG
  static const AUTO_MSG_STEP = "0,STEP";  //処理中ステップ送信
  static const AUTO_MSG_ERR = "0,ERR%d";  //エラー送信
  static const AUTO_MSG_SENDREQ = "0,SENDREQ";  //入出金指示再送信要求
  static const AUTO_MSG_ERRCLR = "0,ERRCLR";  //エラー解除
  static const AUTO_MSG_CONF = "0,CONF";  //設定確認
  static const AUTO_MSG_RECAL = "0,RECAL";  //実績再集計要求
  static const AUTO_MSG_COMP = "0,ERR";
}

/// 関連tprxソース: apllib.h - SPECBACKUP_DATA_CHANGE
class SpecBackupDataChange {
  int chgFlg = 0;
  int compCd = 0;
  int streCd = 0;
  int macNo = 0;
  String orgTblName = '';
}

/// 関連tprxソース: apllib.h - UPD_ERR_CHK_NUM
enum UpdErrChkNum {
	UPD_ERR_CHK_STARTUP,
	UPD_ERR_CHK_PROMPT,
	UPD_ERR_CHK_EXAMINE,
	UPD_ERR_CHK_ACCOUNT,
	UPD_ERR_CHK_BATREP,
	UPD_ERR_CHK_STRCLS,
	UPD_ERR_CHK_MENTE,
	UPD_ERR_CHK_CSHCLS,
	UPD_ERR_CHK_CHKCLS,
	UPD_ERR_CHK_12,
	UPD_ERR_CHK_1,
	UPD_ERR_CHK_EJCONF,
	UPD_ERR_CHK_EVOID,
	UPD_ERR_CHK_EREF,
	UPD_ERR_CHK_ESVOID,
	UPD_ERR_CHK_CRDTVOID,
	UPD_ERR_CHK_PRECAVOID,
	UPD_ERR_CHK_VERUP,
	UPD_ERR_CHK_INIT,
	UPD_ERR_CHK_SYSTEM,
	UPD_ERR_CHK_DELIVSVC,
	UPD_ERR_CHK_USETUP,
	UPD_ERR_CHK_MAX
}

enum APL_MATCH_PROC_TYPE
{
	PROCESS_MATCH,	// 一致しているのを対象
	PROCESS_UNMATCH,	// 一致していないのを対象
}

enum SCAN_DIR_RESULT
{
	SCAN_DIR_OK ,	// 該当ファイルがあった場合の戻値
	SCAN_DIR_CONTINUE,	// 継続処理する場合の戻値
	SCAN_DIR_BREAK,		// 終了処理する場合の戻値
	SCAN_DIR_ERROR		// 終了処理する場合の戻値(実行失敗:戻値を-1で返す)
}

enum APLLIB_PASTCOMP_ORDER
{
	APLLIB_PASTCOMP_FILE_REQ,	// ファイルリクエストからの呼出
	APLLIB_PASTCOMP_FILE_GET,	// 取引検索時の操作からの呼出
	APLLIB_PASTCOMP_FILE_INIT,	// ファイル初期化からの呼出
	APLLIB_PASTCOMP_FILE_DEL	// 開設からの呼出
}
/// 関連tprxソース: apllib.h - PARTITION_TYPE
enum PartitionType {
  PART_TYPE_NONE(-1),
  PART_TYPE_NORMAL(0),
  PART_TYPE_YEAR_MONTH(1);

  final int type;

  const PartitionType(this.type);

  static PartitionType getDefine(int type) {
    PartitionType? define =
    PartitionType.values.firstWhereOrNull((a) => a.type == type);
    define ??= PartitionType.PART_TYPE_NONE; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

/// 関連tprxソース: apllib.h - USBMEM_VALUES
enum UsbMemValues {
  USBMEM_NG(-5),
  USBMEM_NOTFND_MEMOK(-4),
  USBMEM_FND_MEMNG(-3),
  USBMEM_NOT_USBSETTING(-2),
  USBMEM_NOT_ST(-1),
  USBMEM_NOTSPT_WEBTYP(0),
  USBMEM_SPT_WEBTYP1(1),
  USBMEM_SPT_WEBTYP2(2),
  USBMEM_SPT_WEBTYP3(3),
  USBMEM_SPT_WEBTYP4(4),
  USBMEM_OK(5);

  final int value;

  const UsbMemValues(this.value);

  static UsbMemValues getDefine(int value) {
    UsbMemValues? define =
        UsbMemValues.values.firstWhereOrNull((a) => a.value == value);
    define ??= UsbMemValues.USBMEM_NG; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

/// 関連tprxソース: apllib.h - SCAN_DIR_RESULT
enum ScanDirResult {
  SCAN_DIR_OK(0), // 該当ファイルがあった場合の戻値
  SCAN_DIR_CONTINUE(1), // 継続処理する場合の戻値
  SCAN_DIR_BREAK(2), // 終了処理する場合の戻値
  SCAN_DIR_ERROR(3); // 終了処理する場合の戻値(実行失敗:戻値を-1で返す)

  final int value;

  const ScanDirResult(this.value);
}

//ページ毎エラーガイダンス情報
/// 関連tprxソース: apllib.h - AcxErrGUI_Page
class AcxErrGUIPage {
  String errDispName = "";
  String errTextName = "";
  String errText = "";
}

/// 関連tprxソース: apllib.h - AcxErrGUI_Data
class AcxErrGUIData {
  String errCode = "";
  String errTitle = "";
  String unit = "";
  String unitLabel = "";
  List<AcxErrGUIPage?> disp = List<AcxErrGUIPage?>.filled(AplLib.GUI_PAGE_MAX, null);
}