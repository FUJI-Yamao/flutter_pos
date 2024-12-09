/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:async';

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_pos/app/if/if_drv_control.dart';

import '../ffi/library.dart';
import '../ffi/ubuntu/ffi_cash_drawer.dart';
import '../ffi/windows/winffi_cash_drawer.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/environment.dart';
import '../../common/cmn_sysfunc.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_lib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// デバイスドライバ制御_ドロア
///  関連tprxソース:\drv\drw_2800\tprdrv_drw_2800.c
class TprDrvDrw {
  static const winDrwName = "Web3800Drawer";
  static const winDrwTimeout = 2000;

  /// 戻り値
  static const DRW_OK_I = 0;
  static const DRW_NG_I = -1;
  static const DRW_OK_B = true;
  static const DRW_NG_B = false;

  /// パス
  static const PIPEDIO = "/var/tmp/PipeDIO";
  static const UPSFILE = "/dev/shm/ups/ups_stat";

  /// プロセス名
  static const DRW_28_1 = "drw_2800_1";
  static const DRW_28_2 = "drw_2800_2";

  /// 中断フラグ
  static bool _isAbort = false;
  /// 停止フラグ
  static bool _isStop = false;

  Timer? timerFunc;

  /// 変数
  TprDID myDid = 0; /* My Device ID	*/
  TprTID myTid = 0; /* drw driver task id	*/
  int iDrvno = 0;   /*  */
  late SysJsonFile sysIni;
  FFICashDrawer cashDrw = FFICashDrawer();
  WinFFICashDrawer winCashDrw = WinFFICashDrawer();

  SendPort? _parentSendPort;
  bool _isInit = false;

  /// ドロア処理
  ///
  /// 引数　：timer
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース: tprdrv_drw_2800.c - main()のうち、whileでループしている箇所に相当
  ///
  /// 　⇒　回しっぱなしにするとプロセスが開放されないため、1処理毎にプロセスを開放する。
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
    if(_parentSendPort != null) {
      _drwStatusCheck(_parentSendPort!, _isInit);
    }
  }

  /// 初期化関数
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値：0 = Normal End
  ///
  ///      -1 = Error
  ///
  /// 関連tprxソース:tprdrv_drw_2800.c - drw_init()
  Future<int> drw_init(int tid, SendPort parentSendPort) async {
    /// タスクIDを取得する
    myTid = tid;
    iDrvno = (myTid >> bitShift_Tid) & 0x000000FF;
    _parentSendPort = parentSendPort;

    /// 設定ファイルからデータを取得し、各種判定を行う
    try {
      /// 設定ファイルを読み取る
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if(xRet.isInvalid()){
        return DRW_NG_I;
      }
      RxCommonBuf pCom = xRet.object;
      sysIni = pCom.iniSys;

      /// ドロアタイプのチェック
      bool flgIni = await _loadIniCheck();

      /// Common Memory Check
      bool flgMem = _drwInitCmnMem();
      if (!flgIni || !flgMem) {
        return DRW_NG_I;
      }
    } catch (e) {
      TprLog().logAdd(myTid, LogLevelDefine.error, "DRW inifile open error");
      return DRW_NG_I;
    }

    /// ポートオープン、パイプオープンを行う
    try {
      if (Platform.isLinux || isLinuxDebugByWin()) {
        // Linux処理
        debugPrint("drw PortOpen (Linux:処理無し)");
      } else if (Platform.isWindows) {
        final Pointer<Utf8> pathPointer =
            "C:\\OPOS\\Teraoka\\bin\\trk03_gpio_rw.exe".toNativeUtf8();
        int rt = winCashDrw.openDrwDIOPort(pathPointer);
        calloc.free(pathPointer);
        if (rt != 0) {
          TprLog().logAdd(myTid, LogLevelDefine.error,
              "DRW port open failed(dio port): $rt ");
          return DRW_NG_I;
        }

        /// Open Event task's pipe
        String exePath = path.join(Directory.current.path, 'lib/app/drv', 'lib',
            'Windows', 'dist', 'x64', 'Release', 'DrwRcv.exe');
        final Pointer<Utf8> eventPathPointer = exePath.toNativeUtf8();
        rt = winCashDrw.openDrwEvent(eventPathPointer);
        calloc.free(eventPathPointer);
        if (rt != 0) {
          TprLog().logAdd(
              myTid, LogLevelDefine.error, "DRW event open failed: $rt ");
          return DRW_NG_I;
        }
        TprLog()
            .logAdd(myTid, LogLevelDefine.error, "Windows Drw DIO Port Open");
      }
    } catch (e) {
      TprLog().logAdd(
          myTid, LogLevelDefine.error, "DRW port open err: ${e.toString()}");
      return DRW_NG_I;
    }

    timerFunc = Timer.periodic(Duration(milliseconds: 10), (timer) => {_onTimer(timer)});
    _isInit = DRW_OK_B;
    return DRW_OK_I;
  }

  /// 設定ファイルのパラメータをチェックする関数
  ///
  /// 引数: なし
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  /// 関連tprxソース:tprdrv_drw_2800.c - drw_init()のうち、設定ファイルに関する処理を抽出
  Future<bool> _loadIniCheck() async {
    /* boot type */
    String type = CmCksys.cmWebTypeGet(sysIni);
    switch (type) {
      case CmSys.BOOT_WEB2800_DESKTOP:
        TprLog().logAdd(
            myTid, LogLevelDefine.normal, "Boot type is Web2800_desktop");
        if (CmCksys.cmWeb2800Type(sysIni) == CmSys.WEB28TYPE_PR3) {
          //"/etc/prime3_smhd.ini"あり
          TprLog().logAdd(myTid, LogLevelDefine.error,
              "Boot type is WebPrime3 / Not use drw task");
          return DRW_NG_B;
        }
        break;
      case CmSys.BOOT_WEB2800_TOWER:
        TprLog()
            .logAdd(myTid, LogLevelDefine.normal, "Boot type is Web2800_tower");
        break;
      case CmSys.BOOT_WEB2500_DESKTOP:
        TprLog().logAdd(
            myTid, LogLevelDefine.normal, "Boot type is Web2500_desktop");
        if (!TprxPlatform.getFile(CmCksys.PATH_AAEON).existsSync()) {
          //"/etc/aaeon_smhd.ini"なし
          TprLog().logAdd(myTid, LogLevelDefine.error, "Boot type error");
          return DRW_NG_B;
        }
        break;
      case CmSys.BOOT_WEB2500_TOWER:
        TprLog()
            .logAdd(myTid, LogLevelDefine.normal, "Boot type is Web2500_tower");
        if (!TprxPlatform.getFile(CmCksys.PATH_AAEON).existsSync()) {
          //"/etc/aaeon_smhd.ini"なし
          TprLog().logAdd(myTid, LogLevelDefine.error, "Boot type error");
          return DRW_NG_B;
        }
        break;
      default:
        TprLog().logAdd(myTid, LogLevelDefine.error, "Boot type error");
        return DRW_NG_B;
    }

    /* get drivers section in sys.ini */
    final drwSect = await sysIni.getValueWithName(
        type, "drivers${iDrvno.toString().padLeft(2, '0')}");
    if (!drwSect.result) {
      TprLog().logAdd(myTid, LogLevelDefine.error,
          "Drivers section in sys.ini getting Error: ${drwSect.cause.name}");
      return DRW_NG_B;
    }

    /* get drivers ini (ini file name) */
    final iniName = await sysIni.getValueWithName(drwSect.value, "inifile");
    if (!iniName.result) {
      TprLog().logAdd(myTid, LogLevelDefine.error,
          "Drawer ini file getting Error: ${iniName.cause.name}");
      return DRW_NG_B;
    }
    if (drwSect.value == DRW_28_1) {
      if (!iniName.value.contains(DRW_28_1)) {
        TprLog().logAdd(
            myTid, LogLevelDefine.error, "Ini file name err($DRW_28_1.ini)");
        return DRW_NG_B;
      }
      myDid = TprDidDef.TPRDIDDRW1;
    } else {
      if (!iniName.value.contains(DRW_28_2)) {
        TprLog().logAdd(
            myTid, LogLevelDefine.error, "Ini file name err($DRW_28_2.ini)");
        return DRW_NG_B;
      }
      myDid = TprDidDef.TPRDIDDRW2;
    }

    return DRW_OK_B;
  }

  /// 指定パラメタのインデックスにデータ（ドロアタスクステータス）が存在するかチェックする
  ///
  /// 引数: なし
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  ///  関連tprxソース:tprdrv_drw_2800.c - drw_init()内の「Get Common Memory」に相当する部分
  bool _drwInitCmnMem() {
    try {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        TprLog().logAdd(myTid, LogLevelDefine.error, "rxMemRead error");
        return DRW_NG_B;
      }
      RxTaskStatBuf taskStat = xRet.object;
      int drwStat = taskStat.drw.drwStat;
      int drwStat2 = taskStat.drw.drwStat2;
    } catch (e) {
      /// DrwRxTaskStat.DRW_STAT, DRW_STAT2 がNULLの場合、例外として処理される
      ///（e: type 'Null' is not a subtype of type 'int'）
      TprLog().logAdd(myTid, LogLevelDefine.error, "TaskStat has no data");
      return DRW_NG_B;
    }

    return DRW_OK_B;
  }

  /// システムタスクへ、準備完了or未完了を送信する
  ///
  /// 引数:[isInit] drw_init()の正常終了有無（true:Normal End  false:Error）
  ///
  /// 戻り値: なし
  ///
  ///  関連tprxソース:tprdrv_drw_2800.c - main()
  void sendReady(bool isInit) {
    if (Platform.isLinux || isLinuxDebugByWin()) {
      if (isInit) {
        /* Notify ready status to system task */
        TprLib().tprReady(myDid, myTid);
        TprLog().logAdd(myTid, LogLevelDefine.warning, "Call TprReady()");
      } else {
        /* Notify not ready status to system task */
        TprLib().tprNoReady(myDid, myTid);
        TprLog()
            .logAdd(myTid, LogLevelDefine.normal, "Call TprNoReady(). Exit...");
        exit(-1);
      }
    } else if (Platform.isWindows) {
      debugPrint("drw sendReady (Windows:処理無し)");
    }
  }

  /// UPSファイルのパラメタをチェックし、ドロアタスクステータスを更新する
  ///
  /// 引数: なし
  ///
  /// 戻り値: なし
  ///
  ///  関連tprxソース:tprdrv_drw_2800.c - drw_StatusCheck()
  void _drwStatusCheck(SendPort parentSendPort, bool isInit) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(myTid, LogLevelDefine.error, "rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    RxTaskStatDrw drw = RxTaskStatDrw();

    if (isInit != true) {
      drw.drwStat = -1;
      drw.drwStat2 = -1;
      TprLog().logAdd(myTid, LogLevelDefine.warning, "drw status check error");
    }else {
      if (Platform.isLinux || isLinuxDebugByWin()) {
        RxTaskStatDrw retL = cashDrw.drwStatusCheck(tsBuf.drw.drwStat, tsBuf.drw.drwStat2);
        if (retL.result == DRW_OK_I) {
          drw.drwStat = retL.drwStat;
          drw.drwStat2 = retL.drwStat2;
        } else {
          TprLog().logAdd(myTid, LogLevelDefine.warning, "drw status check error");
        }
      } else if (Platform.isWindows) {
        RxTaskStatDrw retW = winCashDrw.getDrwStat();
        if (retW.result == DRW_OK_I) {
          drw.drwStat = retW.drwStat;
          drw.drwStat2 = retW.drwStat2;
        } else {
          TprLog().logAdd(myTid, LogLevelDefine.warning, "drw status check error");
        }
      }
    }
    if ((tsBuf.drw.drwStat != drw.drwStat) ||
        (tsBuf.drw.drwStat2 != drw.drwStat2)) {
      tsBuf.drw.drwStat = drw.drwStat;
      tsBuf.drw.drwStat2 = drw.drwStat2;
      // ドロアの状態に変化があれば更新
      SystemFunc.rxMemWrite(_parentSendPort,
          RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "DRW ");
    }
  }

  /// ドロアをオープンする関数
  ///
  /// 引数:[fds] ファイルディスクリプタ
  ///
  /// 戻り値: なし
  ///
  /// 関連tprxソース:tprdrv_drw_2800.c - drw_open()
  void drw_open(int fds) {
    if (Platform.isLinux || isLinuxDebugByWin()) {
      cashDrw.drwOpenCmd(fds);
      if (myDid == TprDidDef.TPRDIDDRW2) {
        TprLog().logAdd(myTid, LogLevelDefine.normal, "Linux DRW2 Open");
      } else {
        TprLog().logAdd(myTid, LogLevelDefine.normal, "Linux DRW Open");
      }
    } else if (Platform.isWindows) {
      winCashDrw.openDrw();
      TprLog().logAdd(myTid, LogLevelDefine.normal, "Windows DRW Open");
    }
  }

  /// ドロアをクローズする関数（デバッグ用）
  ///
  /// 引数:なし
  ///
  /// 戻り値: なし
  ///
  /// 関連tprxソース:tprdrv_drw_2800.c - なし
  ///
  /// ※WITHOUT_DEVICEでのデバッグ用にドロア閉の条件を作る。
  void drw_close() {
    if (Platform.isLinux || isLinuxDebugByWin()) {
      cashDrw.drwCloseCmd();
      TprLog().logAdd(myTid, LogLevelDefine.normal, "Linux DRW Close");
    } else if (Platform.isWindows) {
      winCashDrw.closeDrw();
      TprLog().logAdd(myTid, LogLevelDefine.normal, "Windows DRW Close");
    }
  }

  /// ドロワとの通信を切断する関数
  ///
  /// 引数: なし
  ///
  /// 戻り値: なし
  ///
  /// 関連tprxソース:tprdrv_drw_2800.c - なし
  void drwPortClose() {
    if (Platform.isLinux || isLinuxDebugByWin()) {
      // Linux処理（FFICashDrawerにportのclose処理はない）
      debugPrint("drwPortClose実行：Linux処理無し");
    } else if (Platform.isWindows) {
      winCashDrw.closeDrwDIOPort();
      TprLog().logAdd(myTid, LogLevelDefine.error, "Windows DRW DIOPort close");
    }
  }

  /// 中断処理
  void abort() {
    _isAbort = true;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "IfDrwIsolate _abort");
  }

  /// 停止処理
  void stop() {
    _isStop = true;
    timerFunc!.cancel();
    timerFunc = null;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "IfDrwIsolate _stop");
  }

  /// 再開処理
  void restart() {
    _isStop = false;
    if (timerFunc == null) {
      timerFunc = Timer.periodic(Duration(milliseconds: 10), (timer) => {_onTimer(timer)});
    }
    TprLog().logAdd(myTid, LogLevelDefine.normal, "IfDrwIsolate _restart");
  }
}
