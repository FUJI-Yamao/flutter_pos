/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../sys/tpr_def.dart';

/// 関連tprxソース: \inc\lib\acx_log_lib.h
class AcxLogLib {
  // 各機種
  static const KIND_RT300 = 10;

  // ログ関連
  static const WORKDIR = "/log/";
  static const LOGFILE = "%s%02d%02d%02d%02d%02d.txt"; // ????YYMMDDHHMM.txt
  static const LOGFILE_RT300 = "%s_%04d%02d%02d%02d%02d.log"; // ????_YYMMDDHHMM.log
  static const LOGFILE_RT300_NG = "NG_"; // [NG_]途中で取得中止になった場合、ログファイル名先頭に付ける
  // #if ACX_LOG_SPEEDUP
  static const OPENERROR = 3;
  static const WRITEERROR = 7;

  // #endif

  // #if ACX_LOG_SPEEDUP
  // ECS関連
  static const ECS_TRADE_START = "\x01\x00\x00\x01\x02\x00\x00";
  static const ECS_TRADE_DATA_START = 0x1001200; // 取引ログデータ開始アドレス
  static const ECS_TRADE_DATA_END = 0x1001400; // 取引ログデータ終了アドレス
  static const ECS_LOGMAX_TRADE = 512; // 取引ログバイト数
  static const ECS_POINT_START = "\x01\x00\x00\x05\x06\x00\x00"; // 開始ポインタアドレス
  static const ECS_POINT_SIZE = "\x00\x02";
  static const ECS_START_SIZE = "\x07\x0F";
  static const LOGREADSIZE_ECS = 127;
  static const LOGFILE_ECS_TRADE = "%04d%02d%02d%02d%02dCoinlog02.bin";
  static const LOGFILE_ECS_MOVEMENT = "%04d%02d%02d%02d%02dCoinlog04.bin";
  static const ECS_LOGMAX_6000 = 504004;
  static const ECS_LOGMAX_2000 = 168004;
  static const ECS_LINE_SIZE = 84;
  static const ECS_DATA_MOVEMENT_START = 0x1005604; // 動作履歴ログ開始アドレス
  static const ECS_DATA_MOVEMENT_END = 0x10806c4; // 動作履歴ログ終了アドレス
  static const CHGADDR_ECS_S = "\x00\x00\x00\x00\x00\x00\x00";

  // #endif

// RT300関連
  static const MAX_LOGNUM = 84;
  static const MAX_LOGSIZE = 67;
}
//--------------------------------------------------------------------------
// Enum
//--------------------------------------------------------------------------

//-----  テストモード：釣銭機ログ取得処理関連 -----*/
/// 関連tprxソース: acx_log_lib.h - msg_code
enum MsgCode {
  TMODE18_NORMAL,
  TMODE18_ACT,
  TMODE18_OPENERROR,
  TMODE18_CHANGERERROR,
  TMODE18_CHANGEROFFLINE,
  TMODE18_ERROR,
  TMODE18_WRITEERROR,
  TMODE18_ERROREND,
  TMODE18_ABORTED,
  TMODE18_MESSAGEMAX
}

//-----  閉設処理：釣銭機ログ取得処理関連 -----
/// 関連tprxソース: acx_log_lib.h - changer_error
enum ChangerError {
  EXECPROC6_NORMAL,
  EXECPROC6_OPENERROR,
  EXECPROC6_CHANGERERROR,
  EXECPROC6_CHANGEROFFLINE,
  EXECPROC6_ERROR,
  EXECPROC6_WRITEERROR,
  EXECPROC6_FILEDELLERROR,
  EXECPROC6_SIOSETERROR,
  EXECPROC6_MESSAGEMAX
}

//--------------------------------------------------------------------------
// Struct
//--------------------------------------------------------------------------
/// 関連tprxソース: acx_log_lib.h - APLLIB_LOGDATA
class AplLibLogData {
  int changerKind = 0;
  List<String> logFilepath = List.generate(TprDef.TPRMAXPATHLEN, (_) => "");
  int changerFlg = 0;
  int writeSize = 0;
  int writeFlg = 0; // 0:write 1:not write
  int writeByte = 0; // 現在のログ書き込み終了サイズ
  int modeFlg = 0; // 0:テストモード 1.閉設処理
}

/// 関連tprxソース: acx_log_lib.h - RT300_LOGDATA
class Rt300LogData {
  int logNum = 0; // ログ番号
  int indexNum = 0; // 現在のインデックス番号
  int indexMaxNum = 0; // 最終インデックス番号
  int indexFirst = 0; // 0:インデックス[0000] 1.それ以外*/
  List<int> indexMaxData = List.generate(2, (_) => 0); // 最終インデックス上位二桁
  int messageFlg = 0; // 取得中ログのメッセージ出力フラグ
  List<int> allSizeData = List.generate(4, (_) => 0); // ログヘッダー部にある全データサイズ合算値一時保存配列
  List<int> logLengthData = List.generate(2, (_) => 0); // 一レスポンスのデータサイズ一時保存配列
  int logLength = 0; // 一レスポンスのデータサイズ(指定ログヘッダー以外)
  List<String> filename = List.generate(TprDef.TPRMAXPATHLEN, (_) => "");
}

  // #if ACX_LOG_SPEEDUP
  // LOGDATA_ECS LogDataEcs;
  // #endif
