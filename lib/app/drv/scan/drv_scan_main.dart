/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './drv_scan_init.dart';
import './drv_scan_rcv.dart';
import './drv_scan_com.dart';
import './drv_scan_midchk.dart';
import './drv_scan_aplreq.dart';
import '../ffi/ubuntu/ffi_scanner.dart';
import '../common/com_drverr.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/apllib/recog.dart';
import '../../fb/fb_lib.dart';
import '../../../app/common/cmn_sysfunc.dart';
import '../../../app/inc/apl/compflag.dart';
import '../../../app/inc/sys/tpr_lib.dart';


class TimeVal {
  int tv_sec = 0;
  int tv_usec = 0;
}

/// 関連tprxソース:drv_scan_main_plus.c
///
class ScanMain {
  /// 定数
  static const CHECK_TIME = 3.000;

  /// 変数
  static TprTID myTid = 0;
  static int savePortNm = 0;
  static int qr_status = 0;
  static ScanCom myCmn = ScanCom();
  static ScanInit myIni = ScanInit();
  static ScanAplReq myReq = ScanAplReq();
  static ScanMidChk myChk = ScanMidChk();
  static ScanRcv myRcv = ScanRcv();
  static TprLog myLog = TprLog();
  static ComDrvErr comDrvErr = ComDrvErr();

  static int tsget = 0;

  /// 戻り値
  static const SCAN_OK_I = 0;
  static const SCAN_NG_I = -1;
  static const SCAN_OK_B = true;
  static const SCAN_NG_B = false;

  //---プロトタイプ向け超簡略化バージョン---------------------------------------
  ScanRet rt = ScanRet();
  SendPort _parentSendPort;
  ScanMain(this._parentSendPort);
  int fds = -1;
  FbMem fbMem = FbMem();
  String scanCommand = "";
  ScanRcv rcv = ScanRcv();
  RxTaskStatBuf tsBuf = RxTaskStatBuf();
  ScanInfo scanInfo = ScanInfo();
  TprMsg ptTprMsg = TprMsg();

  /// 中断フラグ
  static bool _isAbort = false;
  /// 停止フラグ
  static bool _isStop = false;

  Timer? timerFunc;

  // スキャナー送受信処理
  /// 関連tprxソース: drv_scan_init_plus.c - main()のうち、whileでループしている箇所に相当
  /// 　⇒　回しっぱなしにするとプロセスが開放されないため、1処理毎に逃がす
  /// 　　　so層の内部をグローバル変数化する改造をすることで不要となる
  Future<void> _onTimer(Timer timer) async {
    if (_isAbort) {
      // 中断
      timerFunc!.cancel();
      timerFunc = null;
      return;
    }
    if (_isStop) {
      return;
    }
    do {
      if (!(await scannerRcv())) {
        // コマンド送信はアイドル中にのみ行う。
        await scannerSnd();
        break;
      }
    } while(true);
  }

  void scanNotify () {
    String code = rcv.SerialReadBuf;
    if (code.length >= 14) {
      if (code != 0) {
        RxInputBuf inp = RxInputBuf();
        inp.ctrl.ctrl = true;
        inp.devInf.devId = 1;
        inp.funcCode = FuncKey.KY_PLU.keyId;
        // 入力をそのままPLUコードとする.
        inp.devInf.barData = code.substring(1,);
        // メインアプリのIsolateにinput情報を送信.
        _parentSendPort
            .send(NotifyFromSIsolate(NotifyTypeFromSIsolate.scanData, inp));
      }
    }
  }


  /// スキャナからデータを受け取る.
  ///
  /// データが返ってくるまで停止する.(内部でループしている)
  ///
  /// 戻り値：false = 受信アイドル、またはエラー
  ///
  ///        true = データ受信中
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - main()のうち、受信処理を抽出
  Future<bool> scannerRcv() async {
    //_logOutput("Linux scanner input wait...");
    // 停止する.
    // ここがスキャナの値
    int state = 0;
    if (ScanCom.scan_info.serialRW != -1) {
      if (scanInfo.sysFailFlg != 0) {
        return false;
      }
      ScanRet ret = myIni.scanner.scannerDataRcv(fds, ScanCom.keyFilePath);
      fds = ret.fds;
      if (ret.result == 0) {
        if (ret.scanData.length > 0) {
          if (ScanCom.scan_info.keep_scantime == 0) {
            DateTime dt = DateTime.now();
            ScanCom.scan_info.keep_scantime = dt.second.toDouble() +
                (dt.microsecond * 1e-6).toDouble();
            if (tsget != 0) {
              tsBuf.scan.stime = ScanCom.scan_info.keep_scantime;
              tsBuf.scan.scan_flg = 1;
            }
          }
          state = await rcv.drvScanSerialRcv(_parentSendPort, myTid, ret.scanData);
        } else {
        }
      } else {
        myCmn.drvScanResNotify(
            _parentSendPort, myTid, TprDidDef.TPRDEVRESULTRERR, "", 0);
        myCmn.drvScanInitVariable(myTid);
        myLog.logAdd(myTid, LogLevelDefine.error, " serial read error");
        sleep(Duration(microseconds: 10000)); // usleep(10000);
        if (CompileFlag.CENTOS == true) {
          comDrvErr.com_drverr(myTid, savePortNm);
        }
      }
    }

    if (tsBuf.scan.scan_flg == 1) {
      DateTime dt = DateTime.now();
      if ((tsBuf.scan.stime + 1.250) <= (dt.second + (dt.microsecond * 1e-6))) {
        tsBuf.scan.scan_flg = 0;
      }
    }
    if (state == 1) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: drv_scan_init_plus.c - main()のうち、コマンド受付処理を抽出
  Future<void> scannerSnd() async {
    if (ptTprMsg.common.length > 0) {
      await ScanMidChk.drvScanMidCheck(_parentSendPort, myTid, ptTprMsg);
      ptTprMsg.common.length = 0;
      ptTprMsg.data = "";
      ptTprMsg.common.mid = 0;
    }
  }

  /// スキャナ用ログ出力.
  void _logOutput(String context) {
    debugPrint(context);
    TprLog().logAdd(
      0,
      LogLevelDefine.normal,
      context,
    );
  }

  //------------------------------------------------

  //-▼既存POSからDartに移し替えたもの----------------------------------------------

  /// メイン関数
  ///
  /// 引数:[argc] パラメータチェック用
  ///
  /// 引数:[argv(1)] デバイスシーケンスNo  [argv(2)] TPRXホームパス
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - main()のうち、while(1)に入るまでの処理に相当
  Future<int> scannerStart(int taskId) async {
    String buf = "";

    myTid = taskId;
    myLog.logAdd(myTid, LogLevelDefine.normal, "Scanner management task start");

    savePortNm = SCAN_NG_I;

    Recog().recog_type_on(); /* QCJC */
    scanInfo.parentSendPort = _parentSendPort;

    // FBMemGet();
    // rxMemGet(RXMEM_COMMON);

    savePortNm = await myIni.drvScanInit(myTid);
    fds = myIni.fds;

    if ( savePortNm != SCAN_NG_I ) {
      TprLib().tprReady(ScanCom.scan_info.myDid, myTid);
			myLog.logAdd( myTid, LogLevelDefine.normal, " init ok" );
    } else {
      TprLib().tprNoReady(ScanCom.scan_info.myDid, myTid);
			myLog.logAdd( myTid, LogLevelDefine.error, " init error" );
      // FBMemDel(0);
      // rxMemFree(RXMEM_COMMON);
      // exit(TprErrNo.TPRERPARAM);							/* init err notify -> SYS task */
      return (SCAN_NG_I);
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      myLog.logAdd( myTid, LogLevelDefine.error, "Task stat get error" );
      return (SCAN_NG_I);
    }
    tsBuf = xRet.object;
    tsBuf.scan.stime  = (DateTime.now().second +
        ((DateTime.now().microsecond * 1e-6) as double));
    tsget = 1;

    switch (ScanCom.scan_info.cr_send) {
      case 1:
        myCmn.drvScanSerialWrite(_parentSendPort, myTid, "\x0d", 1, 0);
        break;
      case 2:
        if (scanRecogCheck(myTid) == 1) {
          if (myCmn.drvScanSerialWrite(_parentSendPort, myTid,
                  "\x16\x4d\x0d\x42\x45\x50\x42\x45\x50\x30\x21", 11, 0) != 0) {
            myLog.logAdd(myTid, LogLevelDefine.error,
                "Honeywell Beeper Good Read Off\n");
          }
          if (myCmn.drvScanSerialWrite(_parentSendPort, myTid,
                  "\x16\x4d\x0d\x42\x45\x4c\x42\x45\x50\x31\x21", 11, 0) != 0) {
            myLog.logAdd(
                myTid, LogLevelDefine.error, "Honeywell Beep on BEL On\n");
          }
        }
        break;
      default:
        break;
    }

    if (savePortNm == PlusDrvChk.PLUS_SCAN_P) {
      myLog.logAdd(myTid, LogLevelDefine.warning, "SCAN_CMD_PASS_DISABLE");
      buf = String.fromCharCode(0x5A) + String.fromCharCode(0x0D);
      if (myCmn.drvScanSerialWrite(_parentSendPort, myTid, buf, 2, 0) != 0) /* FALSE */ {
        myLog.logAdd(myTid, LogLevelDefine.error, "SCAN_CMD_PASS_DISABLE NG");
      }
    }

    drvScanMainPlusHwDisable(myTid);

    // タイマー起動、送受信処理をタイマー処理で行う。
    timerFunc = Timer.periodic(Duration(milliseconds: 50), (timer) => {_onTimer(timer)});

    return (SCAN_OK_I);
  }

  /// RECOGキーをチェックする
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - scan_recog_check()
  int scanRecogCheck(TprTID myTid) {
    String sTmpBuf = "";
    int tower_flag = 0;
    int qcashier_flag = 0;
    int qcjc_type_flag = 0;

    /* check tower */
    sTmpBuf = myIni.sysIni.type.tower;
    if (sTmpBuf == "") {
			myLog.logAdd( myTid, LogLevelDefine.error, "get error tower from sys.ini" );
      return (SCAN_NG_I);
		}
    if (sTmpBuf == "yes") {
      tower_flag = 1;
    }

    /* check qcashier recog key */
    sTmpBuf = myIni.sysIni.type.qcashier_system;
    if (sTmpBuf == "") {
			myLog.logAdd( myTid, LogLevelDefine.error, "get error qcashier_system from sys.ini" );
      return (SCAN_NG_I);
		}
    if (sTmpBuf == "yes") {
      qcashier_flag = 1;
    }

    /* check qcjc recog key */
    sTmpBuf = myIni.recogkey_data.page6.qcjc_type;
    if (sTmpBuf == "") {
			myLog.logAdd( myTid, LogLevelDefine.error, "get error page6 qcjc_type from recogkey_data.ini" );
      return (SCAN_NG_I);
		}
    qcjc_type_flag = int.parse(sTmpBuf.substring(10, 11));

    if ((tower_flag == 1) &&
        (ScanCom.scan_info.myDid == TprDidDef.TPRDIDSCANNER1) &&
        (qcashier_flag == 1) && (qcjc_type_flag == 1)) {
      return 0;
    }

    /* desktop type; desktop scanner; recog qcashier */
    if ((tower_flag == 0) &&
        (ScanCom.scan_info.myDid == TprDidDef.TPRDIDSCANNER1) &&
        (qcashier_flag == 1)) {
      return 0;
    }

    return 1;
  }

  /// ハードウェア無効化
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値：なし
  ///
  /// 機能概要：一定条件が成立した場合にスキャナーを無効化する
  ///
  /// 関連tprxソース: drv_scan_init_plus.c - drv_scan_main_plus_hw_disable()
  void drvScanMainPlusHwDisable(TprTID myTid) {
    int iTmpBuf = 0;
    int scannerTypFlg = 0;

    /* check spec */
    iTmpBuf = myIni.mac_info.scanner.scan_barcode_payment;
    scannerTypFlg = iTmpBuf;
    if (scannerTypFlg == 0) {
      return;
    }

    if(CmCksys.cmViananoSmhdChk() == 0) {
      myLog.logAdd(myTid,
          LogLevelDefine.error, "not vianano");
			return;
		}

		/* check happyself recog key */
    if (myIni.sysIni.type.happyself_system == "") {
      myLog.logAdd(myTid,
          LogLevelDefine.error, "get error happyself_system from sys.ini");
			return;
		}
    if(myIni.sysIni.type.happyself_system == "yes") {
			return;
		}

    if (myIni.sysIni.type.happyself_smile_system == "") {
      myLog.logAdd(myTid,
          LogLevelDefine.error, "get error happyself_smile_system from sys.ini");
			return;
		}
    if(myIni.sysIni.type.happyself_smile_system == "yes") {
			return;
		}

		/* check qcashier recog key */
    if (myIni.sysIni.type.qcashier_system == "") {
      myLog.logAdd(myTid,
          LogLevelDefine.error, "get error qcashier_system from sys.ini");
			return;
		}
    if(myIni.sysIni.type.qcashier_system == "yes") {
			return;
		}

    if ((scannerTypFlg == 1) &&
        (ScanCom.scan_info.myDid == TprDidDef.TPRDIDSCANNER1)) {
      if (myCmn.drvScanSerialWrite(_parentSendPort, myTid,
          "\x16\x4d\x0d\x54\x52\x47\x4d\x4f\x44\x30\x21", 11, 0) != 0) {
        myLog.logAdd(
            myTid, LogLevelDefine.error, "Honeywell display light off NG\n");
      }
    }

    myLog.logAdd(
        myTid, LogLevelDefine.error, "drvScanMainPlusHwDisable end");
  }

  void drvScanTestBarcodeSet(String barcode) {
    myIni.scanner.testBarcode = barcode;
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
      timerFunc = Timer.periodic(Duration(milliseconds: 50), (timer) => {_onTimer(timer)});
    }
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvPrintIsolate _restart");
  }
}
