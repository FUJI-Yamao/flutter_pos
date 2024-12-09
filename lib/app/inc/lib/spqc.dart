/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///
/// Speaza & QCashier System 関連ファイル
///  関連tprxソース:spqc.h

const int SPQC_LISTEN_MAX = 5;
const String SPQC_IPADR = "spqc";
const String SPQC_PORT = "spqcport";
const String SPQC_PORTTYP = "tcp";
const String SPQC_SUBSVR_IPADR = "spqc_subsvr"; // サブサーバーのホスト名

const int SPQC_SET_PRIO = 19;

const int SPQC_WAITSEC = 1;
const int SPQC_TELEGRAM_MAX = 512;

const int SPQC_CON_TIMEOUT = 3;
const int SPQC_RD_TIMEOUT = 4;
const int SPQC_WR_TIMEOUT = 2;

const String SPQCS_BASE_DIR = "tmp/QRSrv";
const String SPQCC_BASE_DIR = "tmp/QRClt";
const String SPQC_BASE_SUFFIX = "data"; // お会計券を発行して, サーバー(サブ)へ送信出来なかった場合のSUFFIX
const String SPQC_RE_SUFFIX = "re"; // お会計券を中断して, サーバー(サブ)へ送信出来なかった場合のSUFFIX
const String SPQC_SVR_DEL_SUFFIX = "delete"; // マスター (サブ)で精算済にして、サブ (マスター)へ送信出来なかった場合のSUFFIX
const String SPQC_SVR_BACK_SUFFIX = "back"; // マスター (サブ)で未精算にして、サブ (マスター)へ送信出来なかった場合のSUFFIX
const String SPQC_TRAN_SUFFIX = "tran"; // お会計券データを読み込んで、取引終了 (取消含む) した場合のSUFFIX
const String SPQC_LOAD_PLUS_SUFFIX = "loadplus"; // QCashier以外でお会計券を読んだ時にサーバー(サブ)へ送信出来なかった場合のSUFFIX
const String SPQC_RESTORE_PLUS_SUFFIX = "restoreplus"; // QCashier以外でお会計券を中断して, サーバー(サブ)へ送信出来なかった場合のSUFFIX
const String SPQC_FORCED_LOAD_SUFFIX = "forcedload"; // 強制で呼出して, サーバー(サブ)へ送信出来なかった場合のSUFFIX
const String SPQCS_MAKE_DIR = SPQCS_BASE_DIR + "/Make/"; // server: 全お会計の発行したものを保存するディレクトリ
const String SPQCS_LOAD_DIR = SPQCS_BASE_DIR + "/Load/"; // server: 全お会計の読込したものを保存するディレクトリ
const String SPQCS_EDIT_DIR = SPQCS_BASE_DIR + "/Edit/"; // server: 全お会計の編集 (精算済) したものを保存するディレクトリ
const String SPQCS_TRAN_DIR = SPQCS_BASE_DIR + "/Tran/"; // server: 全お会計の取引終了したものを保存するディレクトリ
const String SPQC_CLT_MAKE_DIR = SPQCC_BASE_DIR + "/CltMake/"; // client: 自レジが発行した未精算のお会計券を保存するディレクトリ
const String SPQC_CLT_SEND_DIR = SPQCC_BASE_DIR + "/CltSend/"; // client: 自レジが読込んだ精算済, かつ, 発行レジへ未送信のお会計券を保存するディレクトリ
const String SPQC_CLT_TRAN_DIR = SPQCC_BASE_DIR + "/CltTran/"; // client: 自レジが読込んだ精算済のお会計券を保存するディレクトリ
const String SPQC_CLT_ACTION_DIR = SPQCC_BASE_DIR + "/CltAction/"; // client: QCashier操作で生じたお会計券に関する情報を保存するディレクトリ

const int SPQC_FLG_SIZ = 1;
const int SPQC_OPE_MODE_FLG_SIZ = 6;
const int SPQC_SALE_DATE_SIZ = 8;
const int SPQC_ISSUE_DATE_SIZ = 12;
const int SPQC_MAC_NO_SIZ = 6;
const int SPQC_RECEIPT_NO_SIZ = 4;
const int SPQC_SIZ = (SPQC_FLG_SIZ+SPQC_OPE_MODE_FLG_SIZ+SPQC_SALE_DATE_SIZ+SPQC_ISSUE_DATE_SIZ+SPQC_MAC_NO_SIZ+SPQC_RECEIPT_NO_SIZ);
const int SPQC_ISSUE_DATE_LEN = (SPQC_FLG_SIZ+SPQC_OPE_MODE_FLG_SIZ+SPQC_SALE_DATE_SIZ);
const int SPQC_MAC_NO_LEN = (SPQC_ISSUE_DATE_LEN+SPQC_ISSUE_DATE_SIZ);
const int SPQC_RECEIPT_NO_LEN = (SPQC_MAC_NO_LEN+SPQC_MAC_NO_SIZ);
const int SPQC_DOT_SIZE_PLUS = SPQC_SIZ + 1; // ファイル名称サイズ＋ドットサイズ (拡張子部分をチェックするため)

const int SPQC_SENDFILE_READ = 0; // SpQcFileDataRW()の引数に使用. spqcサーバーでやりとりするファイルの読込
const int SPQC_SENDFILE_WRITE = 1; // 同上. ファイルの保存

//#if SS_CR2
const int SPQC_CR40_MAC_NO_SIZ = 9;
const int SPQC_CR40_RECEIPT_NO_SIZ = 9;
const int SPQC_CR40_SIZ = (SPQC_FLG_SIZ+SPQC_OPE_MODE_FLG_SIZ+SPQC_SALE_DATE_SIZ+SPQC_ISSUE_DATE_SIZ+SPQC_CR40_MAC_NO_SIZ+SPQC_CR40_RECEIPT_NO_SIZ);
const int SPQC_CR40_RECEIPT_NO_LEN = (SPQC_MAC_NO_LEN + SPQC_CR40_MAC_NO_SIZ);
const int SPQC_CR40_DOT_SIZE_PLUS = SPQC_CR40_SIZ + 1; // ファイル名称サイズ＋ドットサイズ (拡張子部分をチェックするため)
//#endif


enum SPQC_TYPS {
  SPQC_TYP1(0),	// お会計券発行ファイル用
  SPQC_TYP2(1),	// お会計券読込済ファイル用 (QCashierのみ)
  SPQC_LOAD_NOT_QC(2),	// お会計券読込済ファイル用, 取引終了ファイル作成 (QCashier以外)
  SPQC_TYP4(3),	// お会計券中断用 (読込済ファイル削除)
  SPQC_TYP5(4),	// お会計券件数問い合わせ
  SPQC_TYP6(5),	// ２台連結２人制キャッシャー問合せ用
  SPQC_TYP7(6),	// Not Use. QR Recipt-read
  SPQC_TYP8(7),	// 精算済に変更の送信タイプ
  SPQC_TYP9(8),	// 未精算に変更の送信タイプ
  SPQC_TYP10(9),	// 取引終了ファイル作成用
  SPQC_TYP11(10),	// お会計券状態確認用
  SPQC_FORCED_LOAD(11),	// お会計券の強制呼出(取引終了ファイルが存在している場合はNG)
  SPQC_RESTORE_NOT_QC(12);	// お会計券読込情報の削除(読込済ファイル, 取引終了ファイル両方) -> お釣りありお会計券の時に使用(QCashier以外)

  final int id;
  const SPQC_TYPS(this.id);
  static int get SPQC_TYP_MAX => SPQC_TYPS.values.last.id + 1;
}

enum SPQC_ISSUE_TYPS {
  SPQC_ISSUE_NORMAL(0),
  SPQC_ISSUE_WIZ(1),
  SPQC_ISSUE_1LINE(2),
  SPQC_ISSUE_TWOCNCT(3);	// ２台連結２人制での発行（実際には発行しない）

  final int id;
  const SPQC_ISSUE_TYPS(this.id);
  static int get SPQC_ISSUE_MAX => SPQC_ISSUE_TYPS.values.last.id + 1;
}

enum SPQC_MNT_STATUS {
  SPQC_NORMAL(0),
  SPQC_OFFLINE(1),
  SPQC_TWOCNCT_CHK(2);

  final int id;
  const SPQC_MNT_STATUS(this.id);
}

enum SPQC_SVR_TYPS {
  SPQC_MSTSVR(0),	// Master
  SPQC_SUBSVR(1);		// Sub

  final int id;
  const SPQC_SVR_TYPS(this.id);
}

// お会計券情報が各ディレクトリ毎に存在した場合, ビットをセットしていく. + お会計券の状態も表す
enum SPQC_TCKT_STATUS_VALUE {
  SPQC_NOT_TCKT(0),	// 存在しない
  SPQC_MAKE_TCKT(1),
  SPQC_LOAD_TCKT(2),
  SPQC_EDIT_TCKT(4),
  SPQC_TRAN_TCKT(8);

  final int id;
  const SPQC_TCKT_STATUS_VALUE(this.id);
}

class TSpQcInf {
  int	typ = 0;
  int	ver = 0;
  int	issue_typ = 0;				/* issue typ: SPQC_ISSUE_TYPS */
  int	ope_mode_flg = 0;				/* 1:RG 2:TR */
  int	svrType = 0;				/* 0:Master 1:Sub */
  String	sale_date = "";	/* YYYYMMDD */
  String	issue_date = "";	/* YYYYMMDDHHMM */
  int	mac_no = 0;
  int	receipt_no = 0;
  int	qty = 0;					/* quantity */
  int	amt = 0;					/* sale amount */
  int	con_mac_no = 0;				/* 接続元のマシン番号 */
  String	spltCd = ""; //[SPTEND_MAX];
  String	spltAmt = ""; // [SPTEND_MAX];
  int	out_cls_qty = 0;				/* 部門外商品点数 */
}

class TSpQcRetInf {
  int	TcktStatus = 0;	// SPQC_TYP11使用時に SPQC_TCKT_STATUS_VALUE の値がセットされる
  int	typ = 0;
  int	ver = 0;
  int	ret = 0;
  int	reg = 0;
  int	all = 0;
  int	tr_reg = 0;
  int	tr_all = 0;
  int	twocnct_reg = 0;	// ２台連結２人制の呼出されていないチェッカー登録数
  int	twocnct_tr_reg = 0;	// ２台連結２人制の呼出されていないチェッカー登録数 (訓練)
  int	con_mac_no = 0;
}

class TSpQcSvrStat {
  String	ipadr = "";  //[TPRMAXPATHLEN];
  String	port = "";   //[TPRMAXPATHLEN];
}

// 会計券情報のファイルに保持するデータの順番
enum SPQCINF_ORDER_DATA {
  SPQCINF_ORDER_VER(0),		// Not use
  SPQCINF_ORDER_QTY(1),		// 個数
  SPQCINF_ORDER_AMT(2),		// 金額
  SPQCINF_ORDER_CON_MAC_NO(3),	// 呼び出しレジ番号
  SPQCINF_ORDER_OUT_CLS_QTY(4),	// 部門外点数
  SPQCINF_ORDER_TENDCD_START(5),		// 以降  スプリット情報
  SPQCINF_ORDER_TENDAMT_START(6);

  final int id;
  const SPQCINF_ORDER_DATA(this.id);
  static int get SPQCINF_ORDER_MAX => SPQCINF_ORDER_DATA.values.last.id + 1;
}

// スピードセルフ用ディレクトリ操作タイプ
enum SPSELF_DIR_PROC_TYPE {
  SPSELF_PROC_MAKEDIR(0),	// 作成
  SPSELF_PROC_INITDIR(1),		// 初期化
  SPSELF_PROC_REQDIR(2),		// Not use リクエスト
  SPSELF_PROC_CLOSEDIR(3),		// Not use 閉設
  SPSELF_PROC_OPENDIR(4);		// 開設

  final int id;
  const SPSELF_DIR_PROC_TYPE(this.id);
  static int get SPSELF_PROC_MAX => SPSELF_DIR_PROC_TYPE.values.last.id + 1;
}

// スピードセルフ用ディレクトリ操作データ
class SpSelfDirProcParam {
  SPSELF_DIR_PROC_TYPE? Type;
  String SaleDate = "";  //[16];	// 営業日
}

const CR40_BASE_DIR       = "/home/web2100/CR/";
const CR40_TRAN_DIR       = CR40_BASE_DIR  + "Tran/";   // server: 全お会計の取引終了したものを保存するディレクトリ
const CR40_TRAN_Send_DIR  = CR40_TRAN_DIR  + "Send/";   // server: 全お会計の取引終了したもので送信済みのものを保存するディレクトリ
const CR40_PRINT_DIR      = CR40_BASE_DIR  + "Prn/";    // server: 印字用の精算データを保存するディレクトリ
const CR40_PRINT_Send_DIR = CR40_PRINT_DIR + "Send/";  // server: 印字用の精算データで送信済みのものを保存するディレクトリ
const CR40_PRINT_Old_DIR  = CR40_PRINT_DIR + "Old/";   // server: 印字用の精算データで印字済みのものを保存するディレクトリ

