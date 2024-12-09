/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/if/if_drv_control.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/apl/rxmem_define.dart';

/// デバイスドライバ制御（サンプル）
///
///  関連tprxソース:
class DrvSample {
  /// 戻り値
  static const OK_I = 0;
  static const NG_I = -1;
  static const OK_B = true;
  static const NG_B = false;

  /// デバイスID、タスクID
  TprDID myDid = 0;
  TprTID myTid = 0;
  int iDrvno = 0;

  SendPort? _parentSendPort;

  /// 中断フラグ
  static bool _isAbort = false;
  /// 停止フラグ
  static bool _isStop = false;

  Timer? timerFunc;

  /// 初期化関数
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///      -1 = Error
  ///
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループまでの初期化処理とします。
  bool drv_init(SendPort parentSendPort, int tid) {
    /// タスクIDを取得する
    myTid = tid;
    iDrvno = (myTid >> bitShift_Tid) & 0x000000FF;
    _parentSendPort = parentSendPort;

    // TODO:ドライバ固有の初期化処理を追加して下さい。

    return OK_B;
  }

  /// ドライバ動作開始処理
  ///
  /// 引数：なし
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース:既存コードのドライバのmain処理のwhileループに到達する場所に設置して下さい。
  void drv_start() {
    // TODO:タイマーの周期は仮値で1000msとしています。適切な値に修正して下さい。
    timerFunc = Timer.periodic(Duration(milliseconds: 1000), (timer) => {_onTimer(timer)});
  }

  /// メイン処理
  ///
  /// 引数　：timer
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループ内の処理とします。
  ///
  /// 　⇒　回しっぱなしにするとプロセスが開放されないため、1処理毎にプロセスを開放する。
  Future<void> _onTimer(Timer timer) async {
    // TODO:下記はIsolate間通信確認用に実装しているコードです。疎通確認後は削除して、適切に実装して下さい。
    if (_isAbort) {
      // 中断
      timerFunc!.cancel();
      timerFunc = null;
      return;
    }
    if (_isStop) {
      return;
    }
    if (_parentSendPort != null) {
      debugPrint("");
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        return;
      }
      RxTaskStatBuf pCom = xRet.object;
      SystemFunc.rxMemWrite(
          _parentSendPort, RxMemIndex.RXMEM_STAT, pCom, RxMemAttn.MASTER, "SAMPLE");
    }
  }

  /// 中断処理
  void abort() {
    _isAbort = true;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvPrintIsolate _abort");
  }

  /// 停止処理
  void stop() {
    _isStop = true;
    timerFunc!.cancel();
    timerFunc = null;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvPrintIsolate _stop");
  }

  /// 再開処理
  void restart() {
    _isStop = false;
    if (timerFunc == null) {
      timerFunc = Timer.periodic(Duration(milliseconds: 1000), (timer) => {_onTimer(timer)});
    }
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvPrintIsolate _restart");
  }
}