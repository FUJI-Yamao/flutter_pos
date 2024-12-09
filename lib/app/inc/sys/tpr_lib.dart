/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:io';

import '../../common/cmn_sysfunc.dart';
import 'tpr_def.dart';
import 'tpr_ipc.dart';
import 'tpr_mid.dart';
import 'tpr_type.dart';

/// タスクコントロールテーブル
///  関連tprxソース: \inc\sys\tprtct.h - tprtct
class TprTct {
  String fds = ''; /* pipe write fds */ // 既存はファイルディスクリプタ dart置き換え後はファイルパスに変更
  TprTID tid = 0; /* Task ID */
  TprTID did = 0; /* device ID */
  TprTST taskStat = 0; /* status of the task */
  int pid = 0; /* process id */

  static final TprTct _instance = TprTct._internal();
  factory TprTct() {
    return _instance;
  }
  TprTct._internal();
}

/// タスク情報ブロック
///  関連tprxソース: \inc\sys\tprtib.h - tprtib
class TprTib {
  int sysPi = 0; /* pipe fds of systask */
  List<TprTct> tct = List.generate(TprDef.TPRMAXTCT, (_) => TprTct());

  static final TprTib _instance = TprTib._internal();
  factory TprTib() {
    return _instance;
  }
  TprTib._internal();
}

/// TPRライブラリ
///  関連tprxソース:\lib\tprlib\TprLibGeneric.c,TprLibTimer.c,TprLibMem.c
class TprLib {
  /// TODO: 元ソースのTprReady()の第一、第二引数に指定するファイルディスクリプタは削除する
  /// TODO: DartではIsolate間でのデータ送受信を行い、パイプラインは用いないため
  /// send task initialize finish
  ///  関連tprxソース:TprLibGeneric.c - TprReady()
  /// 引数:[sfds] システムタスクのディスクリプタ
  ///    :[rfds] 受け取るファイルのディスクリプタ
  ///    :[did] デバイスID
  ///    :[tid] タスクID
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  int tprReady(TprTID did, int tid) {
    return _tprComInitRW(did, tid, TprMidDef.TPRMID_READY);
  }

  /// TODO: 元ソースのTprNoReady()の第一、第二引数に指定するファイルディスクリプタは削除する
  /// TODO: DartではIsolate間でのデータ送受信を行い、パイプラインは用いないため
  /// send task initialize abnormal
  ///  関連tprxソース:TprLibGeneric.c - TprNoReady()
  /// 引数:[sfds] システムタスクのディスクリプタ
  ///    :[rfds] 受け取るファイルのディスクリプタ
  ///    :[did] デバイスID
  ///    :[tid] タスクID
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  int tprNoReady(TprTID did, int tid) {
    return _tprComInitRW(did, tid, TprMidDef.TPRMID_NO_READY);
  }

  /// TODO: 元ソースのTprComInitRW()の第一、第二引数に指定するファイルディスクリプタは削除する
  /// TODO: DartではIsolate間でのデータ送受信を行い、パイプラインは用いないため
  /// TprTib.tctテーブルから、送信するファイルディスクリプタを取得する
  ///  関連tprxソース:TprLibGeneric.c - TprComInitRW()
  /// 引数:[sfds] システムタスクのディスクリプタ
  ///    :[rfds] 受け取るファイルのディスクリプタ
  ///    :[did] デバイスID
  ///    :[tid] タスクID
  ///    :[res] リザルトフラグ
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  int _tprComInitRW(TprTID did, int tid, int res) {
    TprtStat_t tStat = TprtStat();
    int len = 0;
    TprMsg_t cMsg = TprMsg();
    String rBuf = "";

    /* set message READY data */
    tStat.mid = res;
    tStat.length = TprIpcSize.tprtStat - TprIpcSize.tprCmn;
    tStat.mode = did;
    tStat.tid = tid;

    /* send(request) READY message */
    /// TODO: write()は現状、0を返すのみ
    if (SystemFunc.write(null, tStat, TprIpcSize.tprtStat) <= 0) {
      return (-1);
    }

    while (true) {
      rBuf = "";

      /// TODO: read()は現状、0を返すのみ
      len = SystemFunc.read(null, cMsg, TprIpcSize.tprCmn);
      if (len != TprIpcSize.tprCmn) {
        return (-1);
      }

      /// TODO: read()は現状、0を返すのみ
      len += SystemFunc.read(null, rBuf[len], cMsg.common.length);
      if (len == TprIpcSize.tprtStat) {
        break;
      }
    }

    return (0);
  }

  /// タイムアウトリクエストを行う
  ///  関連tprxソース:TprLibTimer.c - TprTimReq()
  /// 引数:[tid] デバイスメッセージID
  ///    :[sec] sec       (0-3600)
  ///    :[usec] micro sec (0-900)
  ///    :[timId] timer ID.
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  bool tprTimReq(TprTID tid, int sec, int msec, int timId) {
    int wFds = 0; /* timer task descriptor */
    TprTimReq_t timReq = TprTimReq();

    /* parameter check */
    if ((sec >= 3600) || (msec > 900) || ((msec % 100) > 1)) {
      return false;
    }

    /* set member */
    timReq.mid = TprMidDef.TPRMID_TIMREQ;
    timReq.length = TprIpcSize.tprTimReq - TprIpcSize.tprCmn;
    timReq.sec = sec;
    timReq.msec = msec;
    timReq.timID = timId;
    timReq.drvno = tid >> 12;

    return true;
  }
  // TODO:定義のみ追加
  ///  関連tprxソース: TprLibMem.c - TprLibMemCheck
  static int tprLibMemCheck(TprMID tid) {
    return 1;
  }

}
