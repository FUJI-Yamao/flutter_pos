/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/sys/stropncls/rmstcls.dart';

import '../../inc/lib/if_fcl.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/sys/tpr_aid.dart';
import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:sprintf/sprintf.dart';
import '../../lib/if_fcl/if_fcl_impl.dart';

import 'package:flutter_pos/app/inc/lib/if_fcl.dart';
import '../word/aa/l_rmstclsfcl.dart';

///  ＦＣＬ端末へのコマンドレスポンス送受信情報
///  関連tprxソース: src\sys\stropncls\rmstclsfcl.h - STCLS_FCL_ORDER
enum StclsFclOrder {
  STCLS_FCL_OD_NONE,					/* アイドル状態 */
  STCLS_FCL_OD_PROC_END,					/* 処理終了 */
  STCLS_FCL_OD_STAT_REQ,					/* 状態要求 */
  STCLS_FCL_OD_STAT_REQ_RES,
  STCLS_FCL_OD_ENCRYPT_REQ2,  		  	 	/* 版数要求２ */
  STCLS_FCL_OD_ENCRYPT_REQ2_RES,
  STCLS_FCL_OD_MUTUAL1,					/* 通信認証１ */
  STCLS_FCL_OD_MUTUAL1_RES,
  STCLS_FCL_OD_MUTUAL1_CHK,				/* 通信認証１乱数チェック */
  STCLS_FCL_OD_MUTUAL2,					/* 通信認証２ */
  STCLS_FCL_OD_MUTUAL2_RES,
  STCLS_FCL_OD_TRAN_END,					/* 取引完了 */
  STCLS_FCL_OD_TRAN_END_RES,
  STCLS_FCL_OD_OPEMODE_CONTROL,				/* 動作モード制御 */
  STCLS_FCL_OD_OPEMODE_CONTROL_RES,
  STCLS_FCL_OD_OPEMODE_CONTROL_MUTUAL,			/* 動作モード制御(認証) */
  STCLS_FCL_OD_OPEMODE_CONTROL_RES_MUTUAL,
  STCLS_FCL_OD_MENTE_PW_CHK,			  	/* 保守用パスワード確認 */
  STCLS_FCL_OD_MENTE_PW_CHK_RES,
  STCLS_FCL_OD_DLL_REQ,					/* ＤＬＬ要求指示 */
  STCLS_FCL_OD_DLL_REQ_RES,
  STCLS_FCL_OD_DLL_REQ_CHK,				/* ＤＬＬ要求指示状況確認 */
  STCLS_FCL_OD_DLL_REQ_CHK_RES,
  STCLS_FCL_OD_MENTE_IN,					/* 保守入 */
  STCLS_FCL_OD_MENTE_IN_RES,
  STCLS_FCL_OD_MENTE_OUT,					/* 保守出 */
  STCLS_FCL_OD_MENTE_OUT_RES,
  STCLS_FCL_OD_DATA_GET_START,				/* 端末データ取得開始*/
  STCLS_FCL_OD_DATA_GET_START_RES,
  STCLS_FCL_OD_DATA_GET,					/* 端末データ取得 */
  STCLS_FCL_OD_DATA_GET_RES,
  STCLS_FCL_OD_DATA_GET_END,				/* 端末データ取得終了 */
  STCLS_FCL_OD_DATA_GET_END_RES,
  STCLS_FCL_OD_OPEMODE_CONTROL_OFF,			/* 動作モード制御(休止) */
  STCLS_FCL_OD_OPEMODE_CONTROL_RES_OFF,
  STCLS_FCL_OD_QP_DAILY_COMM,                             /* QP日計 */
  STCLS_FCL_OD_QP_DAILY_COMM_RES,
  STCLS_FCL_OD_QP_DAILY_COMM_CHK,                         /* QP日計状況確認 */
  STCLS_FCL_OD_QP_DAILY_COMM_CHK_RES,
  STCLS_FCL_OD_EDY_DATA_REQ,                              /* EDY固定データ要求 */
  STCLS_FCL_OD_EDY_DATA_REQ_RES,
  STCLS_FCL_OD_EDY_DAILY_COMM,                            /* Edy締め */
  STCLS_FCL_OD_EDY_DAILY_COMM_RES,
  STCLS_FCL_OD_EDY_DAILY_COMM_CHK,                        /* Edy締め状況確認 */
  STCLS_FCL_OD_EDY_DAILY_COMM_CHK_RES,
  STCLS_FCL_OD_MUL_DAILY,                                 /* マルチサービス日計               */
  STCLS_FCL_OD_MUL_DAILY_RES,
  STCLS_FCL_OD_MUL_DAILY_CHK,                             /* マルチサービス日計状況確認       */
  STCLS_FCL_OD_MUL_DAILY_CHK_RES,
  STCLS_FCL_OD_MUL_DAILY_END,                             /* マルチサービス日計完了           */
  STCLS_FCL_OD_MUL_DAILY_END_RES,
  STCLS_FCL_OD_MUL_NEGAREQ_COMM, 			        /* マルチサービスネガ配信要求       */
  STCLS_FCL_OD_MUL_NEGAREQ_COMM_RES,
  STCLS_FCL_OD_MUL_NEGAREQ_COMM_CHK, 		        /* マルチサービスネガ配信要求指示状況確認  */
  STCLS_FCL_OD_MUL_NEGAREQ_COMM_CHK_RES,
  STCLS_FCL_OD_MUL_KEYREQ_COMM,			        /*  マルチサービス鍵配信要求        */
  STCLS_FCL_OD_MUL_KEYREQ_COMM_RES,
  STCLS_FCL_OD_MUL_KEYREQ_COMM_CHK, 		        /* マルチサービス鍵配信要求指示状況確認  */
  STCLS_FCL_OD_MUL_KEYREQ_COMM_CHK_RES,
  STCLS_FCL_OD_DATE_TIME_SET,                         	/* 日付・時刻設定 */
  STCLS_FCL_OD_DATE_TIME_SET_RES,
}

///  関連tprxソース: src\sys\stropncls\rmstclsfcl.h - FCLS_DAILY_RESULT
enum FclsDailyResult{
  DAILY_NONE(0),
  OFF_LINE(1),
  DBERROR(2),
  MEMERROR(3),
  KOPTERROR(4),
  INIGETERROR(5),
  INISETERROR(6),
  FSAVEERROR(7),
  DAILY_OK(8),
  LOG_OK(9);

  final int value;
  const FclsDailyResult(this.value);
}

///  ＦＣＬ端末送受信処理情報
///  関連tprxソース: src\sys\stropncls\rmstclsfcl.c - STCLS_FCL_INFO_PROC
class StclsFclInfoProc {
  int src = 0;
  int timerCount = 0;  /* タイマーカウント */
  String m2i = '';  /* 通信認証１ M1i   */
  int blockNo = 0;  /* ブロック番号     */
  int ttlBlockSu = 0;  /* 総ブロック数     */
  int ttlByteSu = 0;  /* 総バイト数       */
  int idx = 0;  /* ログカウント     */
}

///  関連tprxソース: src\sys\stropncls\rmstclsfcl.h - STCLS_FCL_INFO
class StclsFclInfo {
  int result = 0;  /* ＦＣＬライブラリ戻り値   */
  dynamic data;  /* データ受け渡しメモリ 端末との通信結果異常の場合 レスポンスをセットする   */
  StclsFclOrder order = StclsFclOrder.STCLS_FCL_OD_NONE;  /* ＦＣＬ通信オーダー       */
  FclService sKind = FclService.FCL_UNIQ;  /* サービス種別             */
  int dKind = 0;  /* データ種別               */
  int boot = 0;  /* 起動方法                 */
  int opportune = 0;  /* データ受信契機           */
  String autoRcvTime = '';  /* 自動ﾃﾞｰﾀ受信ﾀｲﾏ(hhmmss) */
  int dailyRes = 0;
  String edyId = '';
  int ttlCnt = 0;
  int ttlAmt = 0;
  int ttlAlarmCnt = 0;
  int ttlAlarmAmt = 0;
  int printCnt = 0;
  int keyReq = 0;
  int negaReq = 0;
  int rest = 0;
}

class Rmstclsfcl {
  /// グローバル変数
  StclsFclInfo stclsFclInfo = StclsFclInfo();
  int retryCnt = 0;
  int idStep = 0;
  int faulCode = 0;
  StclsFclInfoProc info = StclsFclInfoProc();

  /// シングルトン
  static final Rmstclsfcl _instance = Rmstclsfcl._internal();
  factory Rmstclsfcl() {
    return _instance;
  }

  Rmstclsfcl._internal() {
  }

  ///  ＦＣＬ端末への送受信処理メイン関数
  ///  関連tprxソース: src\sys\stropncls\rmstclsfcl.c - stcls_fcl_proc
  void stclsFclProc(){
    retryCnt = 0;
    idStep = 0;
    faulCode = 0;
    stclsFclInfo.dKind = 61;			/* データ種別：COMPAS端末情報テーブル */
    stclsFclInfo.boot = 0;
    stclsFclInfo.opportune = 0;
    stclsFclInfo.dailyRes = 0;
    stclsFclInfo.keyReq = 0;
    stclsFclInfo.negaReq = 0;
    stclsFclInfo.autoRcvTime = '000000';
    stclsFclInfo.data = null;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(( stcls_fcl_info.s_kind == FCL_EDY ) && ( OpnCls_Flg != RMST_OPEN ) &&
    // ( stcls_fcl_info.rest < FSAVEERROR ))
    // stcls_fcl_info.rest = stcls_fcl_edydailyinfo_set();
    info.src = Tpraid.TPRAID_STR;
    stclsFclInfo.order = StclsFclOrder.STCLS_FCL_OD_STAT_REQ;
    stclsFclInfo.result = Fcl.FCL_NORMAL;

    stclsFclSendCmd();
  }

  void stclsFclSendCmd() {
    stclsFclInfo.data = null;
    bool res = false;
    switch (stclsFclInfo.order) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM:
        res = stclsFclDailyComm();
        break;
      case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_CHK:
        res = stclsFclDailyCommChk();
        break;
      default:
        break;
    }

    if (stclsFclInfo.order == StclsFclOrder.STCLS_FCL_OD_PROC_END || !res) {
      switch (stclsFclInfo.sKind) {
        // TODO:10121 QUICPay、iD 202404実装対象外
        case FclService.FCL_QP:
          Rmstcls.execProcOpt7End();
          break;
        case FclService.FCL_ID:
          Rmstcls.execProcOpt9End();
          break;
        default:
          break;
      }
    }
  }

  ///  QP/iD日計/Edy締め送信
  ///  関連tprxソース: src\sys\stropncls\rmstclsfcl.c - stcls_fcl_daily_comm
  bool stclsFclDailyComm() {
    switch (stclsFclInfo.order) {
      // TODO:10121 QUICPay、iD 202404実装対象外
      case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM:
        if ((stclsFclInfo.result = IfFclImpl.ifFclQpDayTtl(info.src)) == Fcl.FCL_NORMAL) {
          // stcls_fcl_timer_start();
          stclsFclInfo.order = StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_RES;
          return true;
        }
        break;
      default:
        break;
    }
    return false;
  }

  ///  QP/iD日計/Edy締め状況確認送信
  ///  関連tprxソース: src\sys\stropncls\rmstclsfcl.c - stcls_fcl_daily_comm_chk
  bool stclsFclDailyCommChk() {
    switch (stclsFclInfo.order) {
    // TODO:10121 QUICPay、iD 202404実装対象外
      case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_CHK:
        if ((stclsFclInfo.result = IfFclImpl.ifFclQpDayTtlChk(info.src)) == Fcl.FCL_NORMAL) {
          // stcls_fcl_timer_start();
          stclsFclInfo.order = StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_CHK_RES;
          return true;
        }
        break;
      default:
        break;
    }
    return false;
  }


  ///  関連tprxソース: rmstcls.c - stcls_fcl_get_msg
  String fclGetMsg() {
    String log = '';
    String msg = '';
    Fcl1003R r1003 = Fcl1003R();
    Fcl174FR r174F = Fcl174FR();
    Fcl3090R r3090 = Fcl3090R();
    FclETC2R retc2 = FclETC2R();
    FclETC1R retc1 = FclETC1R();
    Fcl1010R r1010 = Fcl1010R();
    Fcl981AR r981A = Fcl981AR();
    Fcl9012R r9012 = Fcl9012R();
    Fcl9013R r9013 = Fcl9013R();
    Fcl9014R r9014 = Fcl9014R();
    FclETC3R retc3 = FclETC3R();
    Fcl9030R r9030 = Fcl9030R();
    Fcl9410R r9410 = Fcl9410R();
    FclB441R rB441 = FclB441R();
    Fcl9452R r9452 = Fcl9452R();
    FclETC5R retc5 = FclETC5R();

    if (stclsFclInfo.result != Fcl.FCL_NORMAL) {
      return fclGetMsgResult(stclsFclInfo.result);
    }
    else {
      switch (stclsFclInfo.order) {
        /* 正常終了 */
        case StclsFclOrder.STCLS_FCL_OD_PROC_END:
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.normal, "stcls: fcl normal end");
          return LRmstclsfcl.STCLS_FCL_NORMAL;
        /* 状態要求レスポンス解析 */
        case StclsFclOrder.STCLS_FCL_OD_STAT_REQ_RES:
          r1003 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r1003.stat72 != 0) {
            return fclGetMsgStat72(r1003.stat72);
          }
          /* 処理中コード */
          if (r1003.code83 != 0) {
            log = sprintf("stcls: fcl code83[%d]", [r1003.code83]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG1;
          }
          /* 故障サービス数 */
          if (faulCode != 0) {
            log = sprintf("stcls: fcl srv_su[%d]", [r1003.srvsu]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return sprintf(LRmstclsfcl.STCLS_FCL_MSG2, [faulCode]);
          }
          break;
        /* 版数要求２ */
        case StclsFclOrder.STCLS_FCL_OD_ENCRYPT_REQ2_RES:
          r174F = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r174F.stat72 != 0) {
            return fclGetMsgStat72(r1003.stat72);
          }
          if (r174F.encrypt == 0) {
            log = sprintf("stcls: fcl encrypt[%d]", [r174F.encrypt]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG3;
          }
          break;
        /* 通信認証１ */
        case StclsFclOrder.STCLS_FCL_OD_MUTUAL1_RES:
          r3090 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r3090.stat72 != 0) {
            return fclGetMsgStat72(r3090.stat72);
          }
          break;
        /* 通信認証１乱数チェック */
        case StclsFclOrder.STCLS_FCL_OD_MUTUAL1_CHK:
          log = "stcls: fcl mutual1 Rh check error";
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
          return LRmstclsfcl.STCLS_FCL_MSG4;
        /* 通信認証１ */
        case StclsFclOrder.STCLS_FCL_OD_MUTUAL2_RES:
          retc2 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (retc2.stat72 != 0) {
            return fclGetMsgStat72(retc2.stat72);
          }
          if (retc2.result != 0) {
            log = sprintf("stcls: fcl result[%d]", [retc2.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG5;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_TRAN_END_RES:         /* 取引完了 */
        case StclsFclOrder.STCLS_FCL_OD_DLL_REQ_RES:          /* ＤＬＬ要求指示 */
        case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY_RES:        /* マルチサービス日計 */
        case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY_END_RES:    /* マルチサービス日計完了 */
        case StclsFclOrder.STCLS_FCL_OD_MUL_NEGAREQ_COMM_RES: /* マルチサービスネガ配信要求 */
        case StclsFclOrder.STCLS_FCL_OD_MUL_KEYREQ_COMM_RES:  /* マルチサービス鍵配信要求 */
          retc1 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (retc1.stat72 != 0) {
            return fclGetMsgStat72(retc1.stat72);
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL_RES: /* 動作モード制御 */
        case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL_RES_MUTUAL: /* 動作モード制御(認証) */
        case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL_RES_OFF:    /* 動作モード制御(休止) */
          r1010 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r1010.stat72 != 0) {
            msg = fclGetMsgStat72(r1010.stat72);
            return msg;
          }
          if (r1010.result == 2) {
            log = sprintf("stcls: fcl result[%d]", [r1010.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG6;
          }
          else if (r1010.result == 9) {
            log = sprintf("stcls: fcl result[%d]", [r1010.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG7;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_MENTE_PW_CHK_RES:    /* 保守用パスワード確認 */
          retc2 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (retc2 .stat72 != 0) {
            return fclGetMsgStat72(retc2 .stat72);
          }
          if (retc2.result != 0) {
            log = sprintf("stcls: fcl result[%d]", [retc2.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG8;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_MENTE_IN_RES:       /* 保守入 */
          retc2 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (retc2 .stat72 != 0) {
            return fclGetMsgStat72(retc2 .stat72);
          }
          if (retc2.result != 0) {
            log = sprintf("stcls: fcl result[%d]", [retc2.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG9;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_MENTE_OUT_RES:       /* 保守出 */
          retc2 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (retc2 .stat72 != 0) {
            return fclGetMsgStat72(retc2 .stat72);
          }
          if (retc2.result != 0) {
            log = sprintf("stcls: fcl result[%d]", [retc2.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG10;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_DLL_REQ_CHK_RES:       /* ＤＬＬ要求指示状況確認 */
          r981A = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r981A .stat72 != 0) {
            return fclGetMsgStat72(r981A .stat72);
          }
          if (r981A.stat == 99) {
            log = sprintf("stcls: fcl stat[%d]", [r981A.stat]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG11;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_DATA_GET_START_RES:       /* 端末データ取得開始 */
          r9012 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r9012.stat72 != 0) {
            return fclGetMsgStat72(r9012 .stat72);
          }
          if (r9012.sarea.spvt?.result == 91) {
            log = sprintf("stcls: fcl result[%d]", [r9012.sarea.spvt?.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG12;
          }
          else if (r9012.sarea.spvt?.result == 99) {
            log = sprintf("stcls: fcl result[%d]", [r9012.sarea.spvt?.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG13;
          }
          if (r9012.sarea.spvt?.ttlBlockSu == 0) {
            log = "stcls: fcl ttl_block_su[0]";
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG14;
          }
          if (r9012.sarea.spvt?.ttlByteSu == 0) {
            log = "stcls: fcl ttl_byte_su[0]";
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG12;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_DATA_GET_RES:       /* 端末データ取得 */
          r9013 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r9013.stat72 != 0) {
            return fclGetMsgStat72(r9013.stat72);
          }
          if (r9013.sarea.spvt?.result == 91) {
            log = sprintf("stcls: fcl result[%d]", [r9013.sarea.spvt?.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG12;
          }
          else if (r9013.sarea.spvt?.result == 99) {
            log = sprintf("stcls: fcl result[%d]", [r9013.sarea.spvt?.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG13;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_DATA_GET_END_RES:       /* 端末データ取得終了 */
          r9014 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r9014.stat72 != 0) {
            return fclGetMsgStat72(r9014.stat72);
          }
          if (r9014.sarea.spvt?.result == 99) {
            log = sprintf("stcls: fcl result[%d]", [r9014.sarea.spvt?.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG13;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_RES:  /* QPセンタ日計処理 */
        case StclsFclOrder.STCLS_FCL_OD_EDY_DAILY_COMM_RES: /* Edy締め */
          retc3 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (retc3.stat72 != 0) {
            return fclGetMsgStat72(retc3.stat72);
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_CHK_RES:  /* QP日計状況確認 */
          rB441 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (rB441.stat72 != 0) {
            return fclGetMsgStat72(rB441.stat72);
          }
          if (rB441.stat != 1) {
            log = sprintf("stcls: fcl stat[%d]", [rB441.stat]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG29;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_EDY_DAILY_COMM_CHK_RES:  /* Edy締め状況確認 */
          r9410 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r9410.stat72 != 0) {
            return fclGetMsgStat72(r9410.stat72);
          }
          if (r9410.stat == 99) {
            log = sprintf("stcls: fcl stat[%d]", [r9410.stat]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG31;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_EDY_DATA_REQ:  /* EDY固定データ要求 */
          r9030 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r9030.stat72 != 0) {
            return fclGetMsgStat72(r9030.stat72);
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY_CHK_RES:  /* マルチサービス日計状況確認 */
          r9452 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (r9452.stat72 != 0) {
            return fclGetMsgStat72(r9452.stat72);
          }
          if (r9452.stat != 10) {
            log = sprintf("stcls: fcl stat[%d]", [r9452.stat]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG29;
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_MUL_NEGAREQ_COMM_CHK_RES: /* マルチサービスネガ配信要求指示状況確認 */
        case StclsFclOrder.STCLS_FCL_OD_MUL_KEYREQ_COMM_RES: /* マルチサービス鍵配信要求指示状況確認 */
          retc5 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (retc5.stat72 != 0) {
            return fclGetMsgStat72(retc5.stat72);
          }
          if (retc5.stat != 10) {
            if (stclsFclInfo.order == StclsFclOrder.STCLS_FCL_OD_MUL_NEGAREQ_COMM_CHK_RES) {
              return LRmstclsfcl.STCLS_FCL_MSG27;
            }
            else {
              log = sprintf("stcls: fcl stat[%d]", [retc5.stat]);
              TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
              return LRmstclsfcl.STCLS_FCL_MSG28;
            }
          }
          break;
        case StclsFclOrder.STCLS_FCL_OD_DATE_TIME_SET_RES: /* 日付・時刻設定 */
          retc2 = stclsFclInfo.data[0];
          /* 受付状況 */
          if (retc2.stat72 != 0) {
            return fclGetMsgStat72(retc2.stat72);
          }
          if (retc2.result != 10) {
            log = sprintf("stcls: fcl stat[%d]", [retc2.result]);
            TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
            return LRmstclsfcl.STCLS_FCL_MSG32;
          }
          break;
        default:
          break;
      }
    }
    /* システム異常 */
    return LRmstclsfcl.STCLS_FCL_MSG25;
  }
  ///  関連tprxソース: rmstcls.c - stcls_fcl_get_msg_result
  ///  機能: レスポンスメッセージ取得
  ///  引数: int result  レスポンス（入力）
  ///  戻値: String msg　メッセージ（出力）
  String fclGetMsgResult(int result) {
    String log = '';
    String msg = '';
    switch (result) {
      case Fcl.FCL_SENDERR:
        /* ※コマンドの送信に失敗しました。 */
        msg = LRmstclsfcl.STCLS_FCL_MSG16;
        log = "stcls: fcl send error";
        break;
      case Fcl.FCL_OFFLINE:
        /* ※端末が接続されていません。確認してください。 */
        msg = LRmstclsfcl.STCLS_FCL_MSG17;
        log = "stcls: fcl offline";
        break;
      case Fcl.FCL_TIMEOUT:
        /* 端末からの応答がありません。確認してください。 */
        msg = LRmstclsfcl.STCLS_FCL_MSG30;
        log = "stcls: fcl timeout";
        break;
      case Fcl.FCL_RETRYERR:
        msg = LRmstclsfcl.STCLS_FCL_MSG18;
        log = "stcls: fcl retry error";
        break;
      case Fcl.FCL_SYSERR:
        msg = LRmstclsfcl.STCLS_FCL_MSG19;
        log = "stcls: fcl system error";
        break;
      case Fcl.FCL_BUSY:
        msg = LRmstclsfcl.STCLS_FCL_MSG20;
        log = "stcls: fcl busy";
        break;
      case Fcl.FCL_CODEERR:
        msg = LRmstclsfcl.STCLS_FCL_MSG21;
        log = "stcls: fcl code error";
        break;
      default:
        /* システム異常 */
        msg = LRmstclsfcl.STCLS_FCL_MSG25;
        log = "stcls: fcl result system error";
        break;
    }
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
    return msg;
  }
  ///  関連tprxソース: rmstcls.c - stcls_fcl_get_msg_stat72
  ///  機能: 受付状況メッセージ取得
  ///  引数: int stat72  受付状況（入力）
  ///  戻値: String msg　メッセージ（出力）
  String fclGetMsgStat72(int stat72) {
    String log = '';
    String msg = '';
    switch (stat72) {
      case 90:            /* 準備未 */
        /* 端末が初期化中です。しばらく待って再度実行してください。 */
        msg = LRmstclsfcl.STCLS_FCL_MSG22;
        break;
      case 91:            /* ＢＵＳＹ */
        /* 端末が処理中です。しばらく待って再度実行してください。 */
        msg = LRmstclsfcl.STCLS_FCL_MSG23;
        break;
      case 99:            /* 故障 */
        /* 端末故障。 */
        msg = LRmstclsfcl.STCLS_FCL_MSG26;
        break;
      case 92:            /* モード不適 */
        msg = LRmstclsfcl.STCLS_FCL_MSG24;
        break;
      case 93:            /* シーケンス異常 */
      case 94:            /* パラメータ異常 */
      default:
        /* システム異常 */
        msg = LRmstclsfcl.STCLS_FCL_MSG25;
        break;
    }
    log = sprintf("stcls: fcl stat[%d]", stat72);
    TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error, log);
    return msg;
  }

  ///  関連tprxソース: rmstcls.c - stcls_fcl_get_cmd_msg
  String fclGetCmdMsg(StclsFclOrder order) {
    String msg = '';
    switch(order) {
      case StclsFclOrder.STCLS_FCL_OD_STAT_REQ:/* 状態要求 */
      case StclsFclOrder.STCLS_FCL_OD_STAT_REQ_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MLTSRVSTATREQ;
        break;
      case StclsFclOrder.STCLS_FCL_OD_ENCRYPT_REQ2:/* 版数要求２ */
      case StclsFclOrder.STCLS_FCL_OD_ENCRYPT_REQ2_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_ENCRYPTREQ2;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUTUAL1:/* 通信認証１ */
      case StclsFclOrder.STCLS_FCL_OD_MUTUAL1_RES:
      case StclsFclOrder.STCLS_FCL_OD_MUTUAL1_CHK:/* 通信認証１乱数チェック */
        msg = LRmstclsfcl.STCLS_FCL_CMD_MUTUAL1;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUTUAL2:/* 通信認証２ */
      case StclsFclOrder.STCLS_FCL_OD_MUTUAL2_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MUTUAL2;
        break;
      case StclsFclOrder.STCLS_FCL_OD_TRAN_END:/* 取引完了 */
      case StclsFclOrder.STCLS_FCL_OD_TRAN_END_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MLTSRVTRANEND;
        break;
      case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL:/* 動作モード制御 */
      case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL_RES:
      case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL_MUTUAL:/* 動作モード制御(認証) */
      case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL_RES_MUTUAL:
      case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL_OFF:/* 動作モード制御(休止) */
      case StclsFclOrder.STCLS_FCL_OD_OPEMODE_CONTROL_RES_OFF:
        msg = LRmstclsfcl.STCLS_FCL_CMD_OPEMODECONTROL;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MENTE_PW_CHK:/* 保守用パスワード確認 */
      case StclsFclOrder.STCLS_FCL_OD_MENTE_PW_CHK_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MAINTENANCEPWCHK;
        break;
      case StclsFclOrder.STCLS_FCL_OD_DLL_REQ:/* ＤＬＬ要求指示 */
      case StclsFclOrder.STCLS_FCL_OD_DLL_REQ_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MLTSRVDLLREQ;
        break;
      case StclsFclOrder.STCLS_FCL_OD_DLL_REQ_CHK:/* ＤＬＬ要求指示状況確認 */
      case StclsFclOrder.STCLS_FCL_OD_DLL_REQ_CHK_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MLTSRVDLLREQCHK;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MENTE_IN:/* 保守入 */
      case StclsFclOrder.STCLS_FCL_OD_MENTE_IN_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MAINTENANCE_IN;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MENTE_OUT:/* 保守出 */
      case StclsFclOrder.STCLS_FCL_OD_MENTE_OUT_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MAINTENANCE_OUT;
        break;
      case StclsFclOrder.STCLS_FCL_OD_DATA_GET_START:/* 端末データ取得開始*/
      case StclsFclOrder.STCLS_FCL_OD_DATA_GET_START_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MLTSRVDATAGETSTART;
        break;
      case StclsFclOrder.STCLS_FCL_OD_DATA_GET:/* 端末データ取得 */
      case StclsFclOrder.STCLS_FCL_OD_DATA_GET_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MLTSRVDATAGET;
        break;
      case StclsFclOrder.STCLS_FCL_OD_DATA_GET_END:/* 端末データ取得終了 */
      case StclsFclOrder.STCLS_FCL_OD_DATA_GET_END_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_MLTSRVDATAGETEND;
        break;
      case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM:/* QP日計 */
      case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_QP_DAILY;
        break;
      case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_CHK:/* QP日計状況確認 */
      case StclsFclOrder.STCLS_FCL_OD_QP_DAILY_COMM_CHK_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_QP_DAILYCHK;
        break;
      case StclsFclOrder.STCLS_FCL_OD_EDY_DATA_REQ:/* EDY固定データ要求 */
      case StclsFclOrder.STCLS_FCL_OD_EDY_DATA_REQ_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_EDY_DATA_REQ;
        break;
      case StclsFclOrder.STCLS_FCL_OD_EDY_DAILY_COMM:/* Edy締め */
      case StclsFclOrder.STCLS_FCL_OD_EDY_DAILY_COMM_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_EDY_DAILY;
        break;
      case StclsFclOrder.STCLS_FCL_OD_EDY_DAILY_COMM_CHK:/* Edy締め状況確認 */
      case StclsFclOrder.STCLS_FCL_OD_EDY_DAILY_COMM_CHK_RES:
        msg = LRmstclsfcl.STCLS_FCL_CMD_EDY_DAILYCHK;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY:/* マルチサービス日計               */
      case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY_RES:
        msg = LRmstclsfcl.STCLS_FCL_MUL_DAILY;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY_CHK:/* マルチサービス日計状況確認       */
      case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY_CHK_RES:
        msg = LRmstclsfcl.STCLS_FCL_MUL_DAILYCHK;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY_END:/* マルチサービス日計完了           */
      case StclsFclOrder.STCLS_FCL_OD_MUL_DAILY_END_RES:
        msg = LRmstclsfcl.STCLS_FCL_MUL_DAILYEND;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUL_NEGAREQ_COMM:/* マルチサービスネガ配信要求       */
      case StclsFclOrder.STCLS_FCL_OD_MUL_NEGAREQ_COMM_RES:
        msg = LRmstclsfcl.STCLS_FCL_MUL_NEGAREQ;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUL_NEGAREQ_COMM_CHK:/* マルチサービスネガ配信要求指示状況確認  */
      case StclsFclOrder.STCLS_FCL_OD_MUL_NEGAREQ_COMM_CHK_RES:
        msg = LRmstclsfcl.STCLS_FCL_MUL_NEGAREQ_CHK;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUL_KEYREQ_COMM:/*  マルチサービス鍵配信要求        */
      case StclsFclOrder.STCLS_FCL_OD_MUL_KEYREQ_COMM_RES:
        msg = LRmstclsfcl.STCLS_FCL_MUL_KEYREQ;
        break;
      case StclsFclOrder.STCLS_FCL_OD_MUL_KEYREQ_COMM_CHK:/* マルチサービス鍵配信要求指示状況確認  */
      case StclsFclOrder.STCLS_FCL_OD_MUL_KEYREQ_COMM_CHK_RES:
        msg = LRmstclsfcl.STCLS_FCL_MUL_KEYREQ_CHK;
        break;
      case StclsFclOrder.STCLS_FCL_OD_DATE_TIME_SET:/* 日付・時刻設定 */
      case StclsFclOrder.STCLS_FCL_OD_DATE_TIME_SET_RES:
        msg = LRmstclsfcl.STCLS_FCL_DATE_SET;
        break;
      default:
        break;
    }
    return msg;
  }
}