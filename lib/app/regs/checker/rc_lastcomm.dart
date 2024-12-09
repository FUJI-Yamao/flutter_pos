/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_crdt_fnc.dart';
import 'package:flutter_pos/app/regs/checker/rc_preca.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';

class RcLastcomm{

  /// 最終締め操作か判定し、各種後通信処理を行う
  /// 関連tprxソース: rc_lastcomm.c - rcLastComm_MainProc(short type)
  /// 引数：int type: 呼出元処理判定区分(キーコードを流用)
  ///       0:会計処理、1:品券処理、2:現計処理
  /// 戻値：0: 後通信処理未実施, 1: 後通信処理実施,  -1: エラーにより処理中断
  static Future<int> rcLastCommMainProc(int type) async {
    int result = 0;
    String log = "";

    // 後通信処理ではない場合、なにもしない
    if(!await RcSysChk.rcsyschkLastCommSystem()){
      return 0;
    }
    log = "rcLastCommMainProc[type:${type}] start\n";
    TprLog().logAdd(
        Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);

    // 楽天ポイント取引であれば、ポイント登録通信を行う
    result = rcLastCommSubProc(type, RX_LASTCOMM_PAYKIND.LCOM_RPOINT);
    if(result != 0){
      return result;
    }

    // 置数 + クレジット処理
    result = rcLastCommSubProc(type, RX_LASTCOMM_PAYKIND.LCOM_CRDT);
    if(result != 0){
      return result;
    }

    // 置数 + プリペイド処理
    result = rcLastCommSubProc(type, RX_LASTCOMM_PAYKIND.LCOM_PRECA);
    if(result != 0){
      return result;
    }
    AtSingl atSing = SystemFunc.readAtSingl();
    // 後通信処理が全て終わった際、支払確認ダイアログ表示フラグをクリア
    atSing.payconfdialogChkFlg = 0;

    log = "rcLastCommMainProc[type:${type}] end\n";
    TprLog().logAdd(
        Tpraid.TPRAID_CHK, LogLevelDefine.normal, log);

    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 最終締め操作か判定し、後通信処理を行う
  /// 関連tprxソース: rc_lastcomm.c - rcLastComm_SubProc(short type, RX_LASTCOMM_PAYKIND pay_kind)
  /// 引数：int type: 呼出元処理判定区分(キーコードを流用)
  ///                0:会計処理、1:現計処理
  ///      RX_LASTCOMM_PAYKIND pay_kind: 後通信処理実施対象の決済種別。
  ///      ※決済種別を増やす場合は上記メモリに追加すること。
  /// 戻値：0: 後通信処理未実施, 1: 後通信処理実施,  -1: エラーにより処理中断
  static int rcLastCommSubProc(int type, RX_LASTCOMM_PAYKIND payKind){
    return -1;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_lastcomm.c - rcLastComm_AfterInquMainProc
  static bool rcLastCommAfterInquMainProc(RX_LASTCOMM_PAYKIND payKind, int flg1){
    return false;
  }

  /// 後通信処理が済んでいるか判断する
  /// 関連tprxソース: rc_lastcomm.c - rcLastComm_ChkCommEnd
  /// 引数：なし
  /// 戻値：true: 後通信実施済み, false: 後通信実施なし
  static Future<bool> rcLastCommChkCommEnd() async {

    // 後通信仕様が無効なら、後通信実施なしで返す
    if(await RcSysChk.rcsyschkLastCommSystem()){
      return false;
    }

    if((RcCrdtFnc.rcCheckEntryCrdtInqu())
        && (RcPreca.rcCheckEntryPrecaInqu())
        && ((RcSysChk.rcsyschkRpointSystem() != 0)
            && (RegsMem().tTtllog.t100790Sts.commEndFlg != 0))){
      return true;
    }

    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// [後通信処理向け]チェック対象の決済種別が後通信処理を行える状態かチェックする
  /// 関連tprxソース: rc_lastcomm.c - rcLastComm_ChkStatus
  /// 引数： RX_LASTCOMM_PAYKIND payKind
  /// 戻値：true: 後通信処理を行える状態, false: 後通信処理を行えない状態
  static bool rcLastCommChkStatus(RX_LASTCOMM_PAYKIND payKind){
    return false;
  }
}

///  関連tprxソース: rxmemsptend.h - RX_LASTCOMM_PAYKIND
enum RX_LASTCOMM_PAYKIND{
  LCOM_NON,	    // 0: 使用不可
  LCOM_CRDT,  	// 1: クレジット
  LCOM_PRECA,	  // 2: プリカ
  LCOM_FACEPAY,	// 3: 顔認証決済
  LCOM_DPOINT,	// 4: dポイント
  LCOM_RPOINT,	// 5: 楽天ポイント
  LCOM_MAX    	// X: 最大値
}