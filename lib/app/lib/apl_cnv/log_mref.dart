/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/apl_cnv.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'log_inf.dart';
import 'log_mvoid.dart';


///  関連tprxソース:log_mref.c
class LogMRef {
  /// 計算用
  static RegsMem tMem = RegsMem();

  /// 関連tprxソース:log_mref.c - header_logmref()
  static bool headerLogMRef(TprMID tid) {
    return true;
  }

  // TODO:10123 ログデータチェック (log_inf.c)
  /// 関連tprxソース:log_mref.c - data_logmref()
  static bool dataLogMRef(TprMID tid) {
    return true;
  }

  // TODO:10123 ログデータチェック (log_inf.c)
  /// 関連tprxソース:log_mref.c - data_logmref()
  static bool statusLogMRef(TprMID tid) {
    return true;
  }

  /// 常駐メモ未読フラグセット
  /// 関連tprxソース:log_mref.c - rc_logmref()
  static bool rcLogMRef(TprMID tid, RegsMem mem) {
    tMem = mem;
    if (!headerLogMRef(tid)) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "rcLogMref: header_logmref error");
      return false;
    }
    if (!dataLogMRef(tid)) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "rcLogMref: data_logmref error");
      return false;
    }
    if (!statusLogMRef(tid)) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "rcLogMref: status_logmref error");
      return false;
    }
    // TODO:10123 ログデータチェック (log_inf.c実装後、下記関数のコメントを有効にする)
    //LogMVoid.calcDataLogMVoid(tMem);
    mem = tMem;

    return true;
  }
}
