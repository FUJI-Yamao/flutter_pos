/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:io';
import "dart:isolate";

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/acbJsonFile.dart';
import '../../common/cls_conf/acb20JsonFile.dart';
import '../../common/cls_conf/acb50JsonFile.dart';
import '../../common/cls_conf/acrJsonFile.dart';
import '../../common/cls_conf/fal2JsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/apllib/cnct.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_lib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../ffi/library.dart';
import '../ffi/ubuntu/ffi_changer.dart';
import '../../lib/if_acx/acx_com.dart';

class ChangerDataReceive {
    FFIChanger ffiChanger = FFIChanger();
    SendPort returnPort;
    TprMsgDevNotify2_t? msg = TprMsgDevNotify2_t();
    ChangerDataReceive(this.ffiChanger, this.returnPort, {this.msg});
}

/// デバイスドライバ制御_釣銭機
///  関連tprxソース:\drv\changer\tprdrv_changer.c
class TprDrvChanger {

  /// 戻り値
  static const CHANGER_OK_I = 0;
  static const CHANGER_NG_I = -1;
  static const CHANGER_OK_B = true;
  static const CHANGER_NG_B = false;

  /// パス
  static const PIPEDIO = "/var/tmp/PipeDIO";
  static const UPSFILE = "/dev/shm/ups/ups_stat";

  static const CHANGERFILEPATH_4 = "/dev/ttyS";

  /// JSONキー
  static const KEYWORD      = "settings";
  static const SET_PORT     = "port";
  static const SET_BAUDRATE = "baudrate";
  static const SET_DATABIT  = "databit";
  static const SET_STARTBIT = "startbit";
  static const SET_STOPBIT  = "stopbit";
  static const SET_PARITY   = "parity";
  static const SET_BILL     = "bill";

  /// 変数
  TprDID myDid = 0; /* My Device ID	*/
  TprTID myTid = 0; /* drw driver task id	*/

  String changerFilePath = "";

  late RxCommonBuf pCom;
  int acr_cnct = 0;       // 自動釣銭釣札機接続
  /// 通信設定
  int tty_fds = 0;
  int acx_enq_interval = 3;
  int acx_enq_cnt = 30 * 60 ~/ 3;
  int tty_baudrate = 0;  /* TTY baudrate */
  int tty_databit = 0;  /* TTY databit */
  int tty_startbit = 0;  /* TTY startbit */
  int tty_stopbit = 0;  /* TTY stopbit */
  int tty_parity = 0;  /* TTY parity */
  late ConfigJsonFile jsonFile;

  late SysJsonFile sysIni;
  late Mac_infoJsonFile macIni;
  AcbJsonFile acbIni = AcbJsonFile();

  late RxTaskStatBuf taskStat;

  ///---------------------------------------------------------------------------
  /// 初期化関数
  ///  関連tprxソース:tprdrv_changer.c - changer_init()
  /// 引数:[tid] タスクID
  /// 戻り値：0 = Normal End
  ///      -1 = Error
  ///---------------------------------------------------------------------------
  Future<int> changer_init(int tid) async {
    /// タスクIDを取得する
    myTid = tid;

    /// Device IDをセットする
    myDid = TprDidDef.TPRDIDCHANGER3;

    /// 設定ファイルからデータを取得する。
    try {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if(xRet.isInvalid()){
        TprLog().logAdd(myTid, LogLevelDefine.error, "rxMemRead(RXMEM_COMMON) error");
        return CHANGER_NG_I;
      }
      pCom = xRet.object;

      /// 設定ファイルを読み取る
      sysIni = pCom.iniSys;
      macIni = pCom.iniMacInfo;

      /// 設定ファイルのパラメータをチェック
      if( await _loadIniCheck() != CHANGER_OK_B) {
        return CHANGER_NG_I;
      }

    } catch (e) {
      TprLog().logAdd(myTid, LogLevelDefine.error, "Changer inifile open error");
      return CHANGER_NG_I;
    }

    /// ポートオープン、パイプオープンを行う
    try {
      if ((Platform.isLinux) || (isLinuxDebugByWin())) {
        // Linux処理
        if(acr_cnct == 2) {
          if (!changerPortOpen()) {
            TprLog().logAdd(myTid, LogLevelDefine.error, "Changer port open error");
            return CHANGER_NG_I;
          }
          debugPrint("changer PortOpen saccess");
        } else {
          debugPrint("changer PortOpen(処理無し)");
          return CHANGER_NG_I;
        }
      } else if (Platform.isWindows) {
        debugPrint("changer PortOpen (Windows:処理無し)");
      }
    } catch (e) {
      TprLog().logAdd(
          myTid, LogLevelDefine.error, "Changer port open err: ${e.toString()}");
      return CHANGER_NG_I;
    }

    return CHANGER_OK_I;
  }

  ///---------------------------------------------------------------------------
  /// 設定ファイルのパラメータをチェックする関数
  ///  関連tprxソース:tprdrv_changer.c - changer_init()
  /// 引数: なし
  /// 戻り値：true = Normal End
  ///       false = Error
  ///---------------------------------------------------------------------------
  Future<bool> _loadIniCheck() async {

    // 共有メモリ
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(myTid, LogLevelDefine.error, "rxMemRead(RXMEM_STAT) error");
      return CHANGER_NG_B;
    }
    taskStat = xRet.object;

    // 自動釣銭釣札機接続
    acr_cnct = macIni.internal_flg.acr_cnct;
    debugPrint("changer acr_cnct = " + acr_cnct.toString());
    if( acr_cnct == 2 ) {
      /* port select*/

      /* get mac info ini (acx_enq_interval) */
      acx_enq_interval = macIni.acx_timer.acx_enq_interval;
      debugPrint("changer acx_enq_interval = " + acx_enq_interval.toString());

      /* get mac info ini (acx_enq_timeout) */
      acx_enq_cnt = macIni.acx_timer.acx_enq_timeout * 60 ~/ acx_enq_interval;
      debugPrint("changer acx_enq_cnt  = " + acx_enq_cnt.toString());

      // 通信設定
      if(_getSelectJson(taskStat.acx.jsonFileName)) {
        String tmpStr = '';
        await jsonFile.load();

        JsonRet jsonRet = await jsonFile.getValueWithName(KEYWORD, SET_PORT);
        if (jsonRet.result) {
          tmpStr = jsonRet.value;
          String type = CmCksys.cmWebTypeGet(sysIni);
          int portCorrectValue = -1;
          if(type == CmSys.BOOT_WEB2800_DESKTOP) {
            portCorrectValue = 3;
          }
          int port = int.parse(tmpStr.substring(3)) + portCorrectValue;
          changerFilePath = CHANGERFILEPATH_4 + port.toString();
          debugPrint("changer changerFilePath = " + changerFilePath);
        }
      /* Get baudrate */
        jsonRet = await jsonFile.getValueWithName(KEYWORD, SET_BAUDRATE);
        if (jsonRet.result) {
          tty_baudrate = jsonRet.value;
          debugPrint("changer tty_baudrate = " + tty_baudrate.toString());
        }

      /* Get databit */
        jsonRet = await jsonFile.getValueWithName(KEYWORD, SET_DATABIT);
        if (jsonRet.result) {
          tty_databit = jsonRet.value;
          debugPrint("changer tty_databit = " + tty_databit.toString());
        }

      /* Get startbit */
        jsonRet = await jsonFile.getValueWithName(KEYWORD, SET_STARTBIT);
        if (jsonRet.result) {
          tty_startbit = jsonRet.value;
          debugPrint("changer tty_startbit = " + tty_startbit.toString());
        }

      /* Get stopbit */
        jsonRet = await jsonFile.getValueWithName(KEYWORD, SET_STOPBIT);
        if (jsonRet.result) {
          tty_stopbit = jsonRet.value;
          debugPrint("changer tty_stopbit = " + tty_stopbit.toString());
        }

      /* Get parity from my parent's ini file */
        jsonRet = await jsonFile.getValueWithName(KEYWORD, SET_PARITY);
        if (jsonRet.result) {
          final parity = jsonRet.value;
          switch (parity) {
            case "even":
              tty_parity = 1;
              break;
            case "odd":
              tty_parity = 2;
              break;
            case "none":
              tty_parity = 0;
            default:
              TprLog().logAdd(myTid, LogLevelDefine.error, "Unknown parity");
              return CHANGER_NG_B;
          }
          debugPrint("changer tty_parity = " + tty_parity.toString());
        }
      } else {
        TprLog().logAdd(myTid, LogLevelDefine.error, "Unknown json file");
        return CHANGER_NG_B;
      }
    }
    return CHANGER_OK_B;
  }
  /// ファイル名から、指定のJsonファイルクラスを設定する
  /// 引数:[fileName] Jsonファイル名
  /// 戻り値: true=正常終了  false=異常終了
  /// ファイル名から、指定のJsonファイルクラスを設定する
  /// 引数:[fileName] Jsonファイル名
  /// 戻り値: true=正常終了  false=異常終了
  bool _getSelectJson(String fileName) {
    switch (fileName) {
      case 'acb.json':  //釣銭釣札機
        jsonFile = AcbJsonFile();
        break;
      case 'acb20.json':  //ACR-40+RAD-S1 or ACB-20
        jsonFile = Acb20JsonFile();
        break;
      case 'acb50.json':  //釣銭釣札機(ACB-50)
        jsonFile = Acb50JsonFile();
        break;
      case 'acr.json':  //自動釣銭機
        jsonFile = AcrJsonFile();
        break;
      case 'fal2.json':  //釣銭釣札機(FAL2)
        jsonFile = Fal2JsonFile();
        break;
      default:
        return false;
    }

    return true;
  }

  ///---------------------------------------------------------------------------
  /// システムタスクへ、準備完了or未完了を送信する
  ///  関連tprxソース:tprdrv_changer.c - main()
  /// 引数:[isInit] drw_init()の正常終了有無（true:Normal End  false:Error）
  /// 戻り値: なし
  ///---------------------------------------------------------------------------
  void sendReady(bool isInit) {
    if ((Platform.isLinux) || (isLinuxDebugByWin())) {
      var ffiChanger = FFIChanger();
      if (isInit) {
        /* Notify ready status to system task */
        TprLib().tprReady(myDid, myTid);
        TprLog().logAdd(myTid, LogLevelDefine.warning, "Call TprReady()");
      } else {
        /* Notify not ready status to system task */
        TprLib().tprNoReady(myDid, myTid);
        TprLog()
            .logAdd(myTid, LogLevelDefine.normal, "Call TprNoReady(). Exit...");
      }

      _changerPortInit(isInit);
    } else if (Platform.isWindows) {
      debugPrint("drw sendReady (Windows:処理無し)");
    }
  }

  ///---------------------------------------------------------------------------
  /// 釣銭機tty設定を更新する
  ///  関連tprxソース:tprdrv_changerrd(wd).c - changerrd_initport()
  /// 引数: [isInit] changer_init()の正常終了有無（true:Normal End  false:Error）
  /// 戻り値: なし
  ///---------------------------------------------------------------------------
  void _changerPortInit(bool isInit) {
    TprLog().logAdd(myTid, LogLevelDefine.warning, "initialize changer tty");
    if (isInit != true) {
      TprLog().logAdd(myTid, LogLevelDefine.warning, "initialize changer tty error");
    }else {
      if ((Platform.isLinux) || (isLinuxDebugByWin())) {
        final ret = FFIChanger()
            .changerPortInit(tty_fds, tty_baudrate, tty_databit, tty_stopbit, tty_parity);
        if (ret != CHANGER_OK_I) {
          TprLog()
              .logAdd(myTid, LogLevelDefine.warning, "drw status check error");
        }
      } else if (Platform.isWindows) {
        debugPrint("_changerPortInit (Windows:処理無し)");
      }
    }
    TprLog().logAdd(myTid, LogLevelDefine.warning, "initialize changer tty end");
  }

  ///---------------------------------------------------------------------------
  /// 釣銭機ttyに対する要求コマンドを送信する
  ///  関連tprxソース:tprdrv_changerrd[wd].c - ()
  /// 引数: [送信データ] 格納ポインタ、サイズ
  /// 引数: [受信データ] 格納ポインタ、サイズ
  /// 戻り値: なし
  ///---------------------------------------------------------------------------
  void changerRequest(TprMsgDevReq2_t msg, SendPort returnPort) {
      String buffer = "";
      int i;
      TprLog().logAdd(myTid, LogLevelDefine.warning, "changer request command");
      if ((Platform.isLinux) || (isLinuxDebugByWin())) {
        final ffiChanger = FFIChanger();
        Isolate.spawn(changerSendThread, ChangerDataReceive(ffiChanger, returnPort, msg:msg));
      } else if (Platform.isWindows) {
        debugPrint("changerRequest (Windows:処理無し)");
      }
  }

  ///---------------------------------------------------------------------------
  /// 釣銭機からデータを受信する
  ///  関連tprxソース:tprdrv_changerrd[wd].c - ()
  /// 引数: [送信データ] 格納ポインタ、サイズ
  /// 引数: [受信データ] 格納ポインタ、サイズ
  /// 戻り値: なし
  ///---------------------------------------------------------------------------
  void changerDataReceive(SendPort returnPort) {
      // データ受信
      if ((Platform.isLinux) || (isLinuxDebugByWin())) {
        final ffiChanger = FFIChanger();
        Isolate.spawn(changerReceiveThread, ChangerDataReceive(ffiChanger, returnPort));
      } else if (Platform.isWindows) {
        debugPrint("changerDataReceive (Windows:処理無し)");
      }
  }

  ///---------------------------------------------------------------------------
  /// ポート接続を行う
  ///  関連tprxソース:changer.c - ()
  /// 引数: なし
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  ///---------------------------------------------------------------------------
  bool changerPortOpen() {
    int selectType = AcxCom.ifAcbSelect();
    changerffiRet ret = FFIChanger()
        .changerPortOpen(changerFilePath, selectType);
    if (ret.result != 0) {
      TprLog().logAdd(0, LogLevelDefine.normal,
          "Linux MKey init Failed: changerPortOpen()");
      return CHANGER_NG_B;
    }
    tty_fds = ret.fds;

    return CHANGER_OK_B;
  }

  ///---------------------------------------------------------------------------
  /// 釣銭機にデータを送信スレッド
  ///  関連tprxソース:changer.c - ()
  /// 引数: FFIChangerインスタンス
  ///---------------------------------------------------------------------------
  void changerSendThread(ChangerDataReceive dataReceive) async {
      TprMsgDevNotify2_t ret = TprMsgDevNotify2_t();
      ret.result = dataReceive.ffiChanger
                                     .changerDataSend(tty_fds, dataReceive.msg as TprMsgDevReq2_t);
      if (ret.result != CHANGER_OK_I) {
          TprLog().logAdd(myTid, LogLevelDefine.warning, "changer send error");
      }
      debugPrint("changerSendThread  returnPort!.send");
      dataReceive.returnPort!.send(ChangerDataReceiveResult(ret));
  }

  ///---------------------------------------------------------------------------
  /// 釣銭機からデータ受信スレッド
  ///  関連tprxソース:changer.c - ()
  /// 引数: FFIChangerインスタンス
  ///---------------------------------------------------------------------------
  void changerReceiveThread(ChangerDataReceive dataReceive) async {
      TprMsgDevNotify2_t ret = TprMsgDevNotify2_t();
      int i;
      changerffiReceiveResult msg = dataReceive.ffiChanger
                                     .changerDataReceive(tty_fds, acx_enq_interval, acx_enq_cnt);
      ret.mid     = msg.msg.mid;
      ret.tid     = msg.msg.tid;
      ret.src     = msg.msg.src;
      ret.io      = msg.msg.io;
      ret.result  = msg.msg.result;
      if (msg.result != CHANGER_OK_I) {
          ret.datalen = 0;
          for(i=0; i<ret.data.length; i++) {
              ret.data[i] = '\0';
          }
          TprLog().logAdd(myTid, LogLevelDefine.warning, "changer receive error");
      } else {
          ret.datalen = msg.msg.datalen;
          for( i=0; i<ret.datalen; i++) {
              ret.data[i] = msg.msg.data[i];
          }
          debugPrint("changerReceiveThread  "
              "io(${msg.msg.io}) result(${msg.msg.result}) "
              "datalen(${msg.msg.datalen}) data(${msg.msg.data.join()})");
      }
      dataReceive.returnPort!.send(ChangerDataReceiveResult(ret));
  }
}
