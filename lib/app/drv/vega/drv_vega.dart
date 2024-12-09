/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../lib/if_vega3000/vega3000_com.dart';
import '../../regs/checker/rc_vega3000.dart';
import '../../regs/inc/rc_crdt.dart';
import 'drv_vega3000_com.dart';


/// デバイスドライバ制御（サンプル）
///  関連tprxソース:
class DrvVega {
  /// 戻り値
  static const OK_I = 0;
  static const NG_I = -1;
  static const OK_B = true;
  static const NG_B = false;
  /// タイマー間隔
  static const VEGA_IDLE_WAIT = 100000;

  /// デバイスID、タスクID
  TprDID myDid = 0;
  TprTID myTid = 0;
  int iDrvno = 0;

  SendPort? _parentSendPort;

  /// 停止フラグ
  static bool _isStop = false;

  /// VEGAドライバから読み取ったデータ
  static PosMsParam msParam = PosMsParam();
  /// 接続先設定
  static Config config = Config();
  /// 共有クラス（RxCommonBuf）
  static RxCommonBuf pCom = RxCommonBuf();
  /// 共有クラス（RxTaskStatBuf）
  static RxTaskStatBuf tsBuf = RxTaskStatBuf();

  Timer? timerFunc;

  /// 初期化関数
  /// 引数:[tid] タスクID
  /// 戻り値：0 = Normal End
  ///      -1 = Error
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループまでの初期化処理とします。
  Future<bool> drv_init(SendPort parentSendPort, int tid) async {
    /// タスクIDを取得する
    myTid = tid;
    iDrvno = (myTid >> bitShift_Tid) & 0x000000FF;
    _parentSendPort = parentSendPort;

    // TODO:ドライバ固有の初期化処理を追加して下さい。
    msParam = PosMsParam();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xRetStat.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "DrvVega.drv_init(): rxMemPtr() error");
      return NG_B;
    }

    pCom = xRet.object;
    tsBuf = xRetStat.object;

    return OK_B;
  }

  /// ドライバ動作開始処理
  /// 引数：なし
  /// 戻り値：なし
  /// 関連tprxソース:既存コードのドライバのmain処理のwhileループに到達する場所に設置して下さい。
  void drv_start() {
    // TODO:タイマーの周期は仮値で1000msとしています。適切な値に修正して下さい。
    debugPrint("********** DrvVega.drv_start(): start");
    timerFunc = Timer.periodic(
        const Duration(microseconds: VEGA_IDLE_WAIT), (timer)
    {
      _onTimer(timer);
      if (_isStop) {
        //DrvVega3000Com().vegaMsReadCancel();
        //DrvVega3000Com().vegaMsReadStop(msParam);
        timer.cancel();
      };
    });
    debugPrint("********** DrvVega.drv_start(): end");
  }

  /// メイン処理
  /// 引数　：timer
  /// 戻り値：なし
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループ内の処理とします。
  /// 　⇒　回しっぱなしにするとプロセスが開放されないため、1処理毎にプロセスを開放する。
  Future<void> _onTimer(Timer timer) async {
    // TODO:下記はIsolate間通信確認用に実装しているコードです。疎通確認後は削除して、適切に実装して下さい。
    /*
    if (_isStop) {
      DrvVega3000Com.vegaMsReadStop(msParam, pCom.vega3000Conf);
      return;
    }
     */
    if (CompileFlag.CENTOS) {
      if (RcVega3000.drvVega3000.vegaChkEvent(tsBuf)) {
        switch (tsBuf.vega.vegaOrder) {
          case 1:  //VegaOrder.VEGA_COGCA_TX.cd
            RcVega3000.drvVega3000.vegaCogcaMain();
            break;
          case 3:  //VegaOrder.VEGA_MS_TX.cd
            debugPrint("********** DrvVega._onTimer(): vegaOrder(before) = ${tsBuf.vega.vegaOrder}");
            await RcVega3000.drvVega3000.vegaMsMain(pCom, tsBuf, msParam);
            debugPrint("********** DrvVega._onTimer(): vegaOrder(after) = ${tsBuf.vega.vegaOrder}");
            break;
        }
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (xRet.isInvalid()) {
          debugPrint("********** DrvVega._onTimer(): SystemFunc.rxMemWrite() done");
          _isStop = true;
          return;
        }
        tsBuf = xRet.object;
        if ((_parentSendPort != null)
            && (tsBuf.vega.vegaOrder != VegaOrder.VEGA_MS_TX.cd)) {
          await SystemFunc.rxMemWrite(
              _parentSendPort, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "VEGA");
          debugPrint("********** DrvVega._onTimer(): SystemFunc.rxMemWrite() done");
          _isStop = true;
        }
      }
    }
  }

  /// 停止処理
  void stop() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      debugPrint("********** DrvVega.stop(): rxMemPtr() error");
    }
    pCom = xRet.object;
    //RcVega3000.drvVega3000.vegaMsReadCancel(pCom);
    RcVega3000.drvVega3000.vegaMsReadStop(msParam);
    _isStop = true;
    timerFunc!.cancel();
    timerFunc = null;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvPrintIsolate _stop");
  }
}