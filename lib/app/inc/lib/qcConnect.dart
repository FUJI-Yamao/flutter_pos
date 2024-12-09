/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///
/// qcConnect 関連ファイル
///  関連tprxソース:qcConnect.h


//---------------------------------------------------------------------------------
//	Values
//---------------------------------------------------------------------------------
const String QCSELECT_SOCK_NAME = "qcselect_port";		// checkerプロセスとqcSelectServerプロセス間でのソケット通信ポート名称
const String QCSELECT_SOCK_PROTOCOL = "tcp"; 		// プロトコル
const int    QCSELECT_PORT_DEFAULT = 9772; 		// ポート番号取得失敗時のデフォルト値

const String QCCONNECT_SOCK_NAME = "qcconnect_port"; // qcConnectプロセスとqcConnectServerプロセス間でのソケット通信ポート名称
const String QCCONNECT_SOCK_PROTOCOL = "tcp"; 		// プロトコル
const int    QCCONNECT_PORT_DEFAULT = 9774; 		// ポート番号取得失敗時のデフォルト値

const String QCCONNECT_SQL = "SQLQCCONNECT_"; // qcConnectServerとのやり取りのための識別子
const int QCCONNECT_MACNO_SIZE = 6;		// 送信データのマシン番号サイズ
const int QCCONNECT_CON_INTERVAL = 1;		// 送受信間隔
const int QCCONNECT_LOG_INTERVAL = 10;		// ログ書込間隔  (大体QCCON_INTERVAL * QCCON_LOG_INTERVAL の秒数で書き込む)
const int QCCONNECT_ERR_INTERVAL = 2;		// qcConnectが接続エラー時に再接続するまでの時間
const int QCCONNECT_CON_SIZE = 32;		// 送受信データサイズ

const String QCSELECT_PREFIX = "QCSLCT_"; // 接頭辞
const String QCSELECT_SUFFIX = "Select"; // 接尾辞
const String QCSELECT_SUFFIX_RUNNING = "Running"; // 接尾辞 (実行中のデータ)

const String QCSELECT_FILE_LEN_MACNO = QCSELECT_PREFIX + "YYYYMMDDHHMMSS"; 	// QC指定情報のMacNoセット場所把握のため
const String QCSELECT_FILE_LEN_RECNO = QCSELECT_PREFIX + "YYYYMMDDHHMMSSCCCCCC"; // QC指定情報のRecNoセット場所把握のため
const String QCSELECT_FILE_LEN_OPE = QCSELECT_PREFIX + "YYYYMMDDHHMMSSCCCCCCRRRR"; // QC指定情報のOpeModeセット場所把握のため
const String QCSELECT_FILE_LEN_PRNNO = QCSELECT_PREFIX + "YYYYMMDDHHMMSSCCCCCCRRRRMM"; // QC指定情報のPrnNoセット場所把握のため

const int QCSELECT_CON_TIMEOUT = 3;		// connectのタイムアウト時間(sec)
const int QCSELECT_WRITE_TIMEOUT = 3;		// writeのタイムアウト時間(sec)
const int QCSELECT_READ_TIMEOUT = 3;		// readのタイムアウト時間(sec)
const int QCSELECT_LASTREAD_TIMEOUT = 7;	// 接続確認のためのreadのタイムアウト時間(sec)

const int QC_INTRP_CON_TIMEOUT = 3;		// connectのタイムアウト時間(sec)
const int QC_INTRP_WRITE_TIMEOUT = 3;		// writeのタイムアウト時間(sec)
const int QC_INTRP_ACT_STOP_WAIT = 30;		// readのタイムアウト時間(sec)
const int QC_INTRP_READ_TIMEOUT = QC_INTRP_ACT_STOP_WAIT + QC_INTRP_CON_TIMEOUT + QC_INTRP_WRITE_TIMEOUT;	// readのタイムアウト時間(sec)

// QC状態（Speezaで表示する時に使用）
///  関連tprxソース:qcConnect.h  enum QCSTATUS_TYPE
enum QcStatusType
{
  QCSTATUS_MENU(0),	// 登録画面以外
  QCSTATUS_WAIT(1),		// 登録画面でQCashierスタート画面
  QCSTATUS_READ(2),		// 登録画面でQC指定情報読込中 (画面上には表さない)
  QCSTATUS_ACTIVE(3),	// 登録画面でQCashierスタート画面以外
  QCSTATUS_OPE_OVER(4),	// 登録開始からの警告時間オーバー (画面上はQCSTATUS_ACTIVEと同じ)
  QCSTATUS_CALL(5),		// 店員呼出中 (メンテナンスを除く)
  QCSTATUS_OFFLINE(6),	// 接続不可
  QCSTATUS_ANOTHERACTIVE(7),	// 登録画面で他のレジが専有中
  QCSTATUS_ANOTHER_OVER(8),	// 他のレジが専有中時に登録開始からの警告時間オーバー  (画面上はQCSTATUS_ANOTHERACTIVEと同じ)
  QCSTATUS_MENTE(9),		// メンテナンス画面
  QCSTATUS_CREATE_MAX(10),	// 登録画面で送信数最大状態
  QCSTATUS_CREATE_OVER(11),	// 送信数最大状態時に登録開始からの警告時間オーバー  (画面上はQCSTATUS_CREATE_MAXと同じ)
  QCSTATUS_PAUSE(11),		// 休止画面
  QCSTATUS_PRECA_SHT(12),	// プリペイド残高不足画面
  QCSTATUS_PRECA_CHG(13),	// プリペイドチャージ画面
  QCSTATUS_COINFULL_RECOVER(14);	// 釣銭機フル自動解除中 (フル硬貨をオーバーフロー庫へ退避し自動復旧)

  final int id;
  const QcStatusType(this.id);
  static int get QCSTATUS_TYPE_MAX => QcStatusType.values.last.id + 1;
}

///  関連tprxソース:qcConnect.h  enum TOUCH_PRESET_TYPE
enum TouchPresetType
{
  REG_PRESET_TYPE(0),	// 登録プリセット
  STL_PRESET_TYPE(1),	// 小計プリセット
  EXT_PRESET_TYPE(2),	// 拡張小計プリセット
  COM_PRESET_TYPE(3),	// 共通(登録)プリセット
  COM_STL_PRESET_TYPE(4),	// 共通(小計)プリセット
  CHOICE_PRESET_TYPE(5),	// お釣り選択モード
  MAX_PRESET_TYPE(6),	// 最大値
  EXPAND_PRESET_TYPE(7);	// QC指定拡大表示モード

  final int id;
  const TouchPresetType(this.id);
}

///  関連tprxソース:qcConnect.h  enum AUTOREAD_FILE_CREATE_STATUS
enum AutoreadFileCreateStatus
{
  AUTOREAD_CREATE(0),	// QC指定情報作成OK
  AUTOREAD_DISP_MENU(1),	// QCashierの画面表示がメニュー
  AUTOREAD_DISP_MAINTE(2),	// QCashierの画面表示がメンテナンス
  AUTOREAD_DISP_CALL(3),	// QCashierの画面表示が店員呼び出し
  AUTOREAD_DISP_PAUSE(4),	// QCashierの画面表示が休止
  AUTOREAD_ANOTHER_USE(5),	// 他のレジが専有中
  AUTOREAD_TRAN_MAX(6),	// 受付数が最大値に達している
  AUTOREAD_MODE_DIFF(7),	// Speeza, QCashierのオペモードが違う
  AUTOREAD_DATE_DIFF(8),	// Speeza, QCashierの営業日が違う
//#if SS_CR2
  AUTOREAD_NON_FILE(9),	// CR4.0のレシートファイルがない
  AUTOREAD_FILE_BROKEN(10);	// CR4.0のレシートファイルが壊れている
//#endif

  final int id;
  const AutoreadFileCreateStatus(this.id);
}

// 未精算一覧による中断の戻り値
///  関連tprxソース:qcConnect.h  enum QC_INTERRUPT_RESULT_STATUS
enum QcInterruptResultStatus
{
  QC_INTRP_RESULT_OK(0),		// 中断出来た
  QC_INTRP_RESULT_ALREADY(1),	// 既に取引完了していた (中断も呼出も出来無い)
  QC_INTRP_RESULT_ERR_TIME_OUT(2),	// 中断処理のタイムアウトエラー
  QC_INTRP_RESULT_ERR_ACB(3),	// 釣銭機への入金があった, もしくは, 釣銭機エラーが発生した状態
  QC_INTRP_RESULT_ERR_CAN_NOT(4),	// QCashierでの操作により中断出来無い状態になっていた
  QC_INTRP_RESULT_ERR_CALL_DISP(5),	// 店員呼出画面やメンテナンス画面だった
  QC_INTRP_RESULT_ERR_PTS_COMM(6),	// ポイント通信済みの為、中断ができない
  QC_INTRP_RESULT_NOTHING(7);	// 電源断などして情報が無くなった

  final int id;
  const QcInterruptResultStatus(this.id);
}

// 未精算一覧による中断の各種状態, 及び, チェッカーが中断処理時にセットする状態
///  関連tprxソース:qcConnect.h  enum QC_INTERRUPT_PROCCESS_MODE
enum QcInterruptProccessMode
{
  QC_INTRP_MODE_NORMAL(0),	// 通常動作
  QC_INTRP_MODE_LOCK(1),		// 自動読込がストップする状態 (この値以上は全てストップしている)
  QC_INTRP_MODE_EXEC(2),		// 中断処理実行状態
  QC_INTRP_MODE_ACB_ERR(3),		// 釣銭機への入金があった, もしくは, 釣銭機エラーが発生した状態
  QC_INTRP_MODE_CAN_NOT(4),		// QCashierでの操作により中断出来無い状態になっていた
  QC_INTRP_MODE_CALL_DISP(5),	// 店員呼出画面やメンテナンス画面だった
  QC_INTRP_MODE_PTS_COMM(6);		// ポイント通信済み状態

  final int id;
  const QcInterruptProccessMode(this.id);
}

// qcSelectServerへのソケット通信した時の動作タイプ
///  関連tprxソース:qcConnect.h  enum QC_SELECT_SVR_PROC_TYPE
enum QcSelectSvrProcType
{
  QC_SELECT_SVR_PROC_CREATE(0),	// QC指定による自動読込ファイルの作成(to QC)
  QC_SELECT_SVR_PROC_INTRP(1),	// 未精算一覧による中断(to QC)
  QC_SELECT_SVR_PROC_TRAN(2),	// 取引完了による未精算ファイルの削除(to Sp)
  QC_SELECT_SVR_PROC_ACT_REBOOT(3),	// QCashier操作: 再起動情報の送信(to Sp)
  QC_SELECT_SVR_PROC_ACT_INTRP(4);	// QCashier操作: 中断情報の送信(to Sp)

  final int id;
  const QcSelectSvrProcType(this.id);
}

// QCashierの注意状態
///  関連tprxソース:qcConnect.h  enum QC_CAUTION_STATUS
enum QcCautionStatus
{
  QC_CAUTION_NORMAL(0),	// 通常
  QC_CAUTION_PRN_END(1),	// プリンターニアエンド
  QC_CAUTION_ACX_END(2),	// 釣銭機ニアエンド
  QC_CAUTION_ACX_FULL(3),	// 釣銭機ニアフル
  QC_CAUTION_ACX_ERR(4);	// 釣銭機エラー

  final int id;
  const QcCautionStatus(this.id);
  static int get QC_CAUTION_MAX => QcCautionStatus.values.last.id + 1;
}

// qcSelectServerへの送受信データ
///  関連tprxソース:qcConnect.h  struct CreateQcSelectInfo
class CreateQcSelectInfo
{
  int	Status = 0;		// 結果格納: AUTOREAD_FILE_CREATE_STATUS or QC_INTERRUPT_RESULT_STATUSがセット (ProcTypeによって異なる)
  int	ProcType = 0;	// QC_SELECT_SRV_PROC_TYPEがセット
  int	OpeMode = 0;	// QC指定情報作成のための mac_info.ini(mode)
  int	RecNo = 0;		// QC指定情報作成のための receipt_no
  int	MacNo = 0;		// QC指定情報作成のための mac_no
  String SaleDate = ""; // QC指定情報作成のための sale_date
  String SaleTime = ""; // QC指定情報作成のための now_sale_datetime
  int	autocall_receipt_no = 0;	//連続取引のレシート番号
  int	autocall_mac_no = 0;	//連続取引のマシン番号
  int	PrnNo = 0;		// QC指定情報作成のための print_no
}

// qcConnectServerからの受信データ
///  関連tprxソース:qcConnect.h  struct QcConnectSockReadInfo
class QcConnectSockReadInfo
{
  String	qcStatus = "";	// QCashierレジの状態: QCSTATUS_TYPEをセット
  String	cautionStatus = "";	// プリンター, 釣銭釣札機の警告状態: QC_CAUTION_STATUSをセット
  int	custWait = 0;	// QC指定による待ち客数
  int	opeMode = 0;	// 登録画面でのmac_info.ini(mode)
//#if ARCS_MBR
  int	autocall_receipt_no = 0;	// 連続取引のレシート番号
  int	autocall_mac_no = 0;	// 連続取引のマシン番号
  int	acbdata = 0;		// 釣機状態（入金額など）
//#endif
}

// QC指定で送信した後のQCashierの取引情報
///  関連tprxソース:qcConnect.h  enum QCSLCT_ACT_TYPE
enum QcslctActType
{
  QCSLCT_ACT_NORMAL(0),	// 通常
  QCSLCT_ACT_INTRP(1),	// 手動中断した
  QCSLCT_ACT_REBOOT(2);	// 再起動した

  final int id;
  const QcslctActType(this.id);
}

// #if SS_CR2
const String CR40_PREFIX = "CR"; 	// 接頭辞
const String CR40_SUFFIX_MD5 = "md5"; 	// 接尾辞

const String CR40_FILE_LEN_MACNO = QCSELECT_PREFIX + "YYYYMMDDHHMMSS"; 	// QC指定情報のMacNoセット場所把握のため
const String CR40_FILE_LEN_RECNO = QCSELECT_PREFIX + "YYYYMMDDHHMMSSCCCCCCCCC"; // QC指定情報のRecNoセット場所把握のため
const String CR40_FILE_LEN_OPE   = QCSELECT_PREFIX + "YYYYMMDDHHMMSSCCCCCCCCCRRRRRRRRR"; // QC指定情報のOpeModeセット場所把握のため
//#endif

