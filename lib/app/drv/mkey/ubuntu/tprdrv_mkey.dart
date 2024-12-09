/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/if/if_drv_control.dart';
import 'package:get/get.dart';

import 'tprdrv_mkey_cmnmem.dart';
import 'tprdrv_mkey_msr.dart';
import 'tprdrv_mkey_tbl.dart';
import '../../ffi/ubuntu/ffi_mechanicalKey.dart';
import '../../common/com_rpt_tool.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../common/environment.dart';
import '../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../common/cls_conf/sysJsonFile.dart';
import '../../../common/cls_conf/repeat_toolJsonFile.dart';
import '../../../common/cls_conf/mkey_2800_1JsonFile.dart';
import '../../../common/cls_conf/mkey_2800_2JsonFile.dart';
import '../../../lib/apllib/brainfile.dart';
import '../../../lib/cm_sys/cm_cksys.dart';
import '../../../lib/apllib/recog.dart';
import '../../../inc/lib/cm_sys.dart';
import '../../../inc/lib/rs232c.dart';
import '../../../inc/sys/tpr_did.dart';
import '../../../inc/sys/tpr_lib.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../inc/sys/tpr_type.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/apl/rx_mbr_ata_chk.dart';
import '../../../fb/fb_lib.dart';

/// デバイスドライバ制御（メカキー）
///
///  関連tprxソース:\drv\mkey_2800\tprdrv_mkey_2800.c
class TprDrvMkey {
  /// 定数
  static const KEYFILEPATH_1 = "/dev/web2800/usbmkey0";
  static const KEYFILEPATH_2 = "/dev/web2800/usbmkey1";
  static const READ_ERR_WAIT = 50000;
  static const PRESS_CHATTERING_TIME = 0.070;
  static const MSR_INTERVAL = 40; //tprdrv_msr_2800.h

  /// 戻り値
  static const OK_I = 0;
  static const NG_I = -1;
  static const OK_B = true;
  static const NG_B = false;

  /// デバイスID、タスクID
  TprDID myDid = 0;
  TprTID myTid = 0;
  int iDrvno = 0;

  /// 変数
  String myIni = ""; //char[256]
  String keyFilePath = "";
  int savePortNm = PlusDrvChk.PLUS_MKEY_D;
  int keyId = 0;
  int keyType = 0;
  int rptToolFlg = 0;
  int recBtn = 0;
  int playBtn = 0;
  int webType = 0;
  int web28Type = 0;
  int deviceFlg = 5;
  bool browserFlg = false;
  int browserKey = -1;
  int msrCount = 0;
  DateTime pressTime = DateTime.now();
  DateTime keepPressTime = DateTime.now();
  int dataCount = 0;
  int keepKey = 0;
  List<List<String>> tbl =
  List.generate(MkeyTbl().KEYTABLE_MAX, (_) => List.generate(7, (_) => ""));
  late SysJsonFile sysIni;
  FbMem fbMem = FbMem();
  MkeyRet mkeyret = MkeyRet();
  String mecData = "";

  /// 中断フラグ
  static bool _isAbort = false;
  /// 停止フラグ
  static bool _isStop = false;

  Timer? timerFunc;

  static final TprDrvMkey _cache = TprDrvMkey._internal();
  factory TprDrvMkey() {
    return _cache;
  }
  TprDrvMkey._internal();

  SendPort? _parentSendPort;

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
    if (_isAbort) {
      // 中断
      timerFunc!.cancel();
      timerFunc = null;
      return;
    }
    if (_isStop) {
      return;
    }
    await startKeyHook();
  }

  /// 初期化関数
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値：true = Normal End
  ///
  ///      false = Error
  ///
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループまでの初期化処理とします。
  Future<bool> drv_init(SendPort parentSendPort, int tid) async {
    myTid = tid;
    iDrvno = (myTid >> bitShift_Tid) & 0x000000FF;
    _parentSendPort = parentSendPort;

    TprLog().logAdd(myTid, LogLevelDefine.normal, "MKey init start.");

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return NG_B;
    }
    RxCommonBuf pCom = xRet.object;
    sysIni = pCom.iniSys;

    Recog().recog_type_on(); /* QCJC */

    bool flgIniChk1 = await _mkeyIniFileGet();
    if (!flgIniChk1) {
      TprLog().logAdd(
          myTid, LogLevelDefine.normal, "MKey init Failed: mkey_inifile_get()");
      return NG_B;
    }

    bool flgIniChk2 = await _mkeyMyIniGet();
    if (!flgIniChk2) {
      TprLog().logAdd(
          myTid, LogLevelDefine.normal, "MKey init Failed: mkey_myini_get()");
      return NG_B;
    }

    bool flgIniChk3 = await _keyTypeDetermine();
    if (!flgIniChk3) {
      TprLog().logAdd(
          myTid, LogLevelDefine.normal, "MKey init Failed: keytype_determine()");
      return NG_B;
    }

    await _rptToolIniFileGet();

    TprLog().logAdd(myTid, LogLevelDefine.normal, "MKey init Success");

    return OK_B;
  }

  /// ドライバ動作開始処理
  ///
  /// 引数：なし
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース:基本的に既存コードのドライバのmain処理のwhileループの開始処理とします。
  Future<void> drv_start() async {
    bool isSuccess = false;
    final isInit2 = mkeyPortOpen();
    if (!isInit2) {
      return;
    }
    isSuccess = true;
    await sendReady(isSuccess);

    timerFunc = Timer.periodic(Duration(milliseconds: 10), (timer) => {_onTimer(timer)});
  }

  /// 設定ファイルを読み取り、ポートNoを取得する（sys.ini）
  ///
  /// 引数: なし
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - mkey_inifile_get()
  Future<bool> _mkeyIniFileGet() async {

    String type = CmCksys.cmWebTypeGet(sysIni);

    final mkeySect = await sysIni.getValueWithName(
        type, "drivers${iDrvno.toString().padLeft(2, '0')}");

    /* get drivers section in sys.ini */
    if (!mkeySect.result) {
      TprLog().logAdd(myTid, LogLevelDefine.error,
          "Drivers section in sys.ini getting Error: ${mkeySect.cause.name}");
      return NG_B;
    }

    /* get drivers ini (ini file name) */
    final iniName = await sysIni.getValueWithName(mkeySect.value, "inifile");
    if (!iniName.result) {
      TprLog().logAdd(myTid, LogLevelDefine.error,
          "Mkey ini file getting Error: ${iniName.cause.name}");
      return NG_B;
    }
    if (!iniName.value.contains(mkeySect.value)) {
      TprLog().logAdd(myTid, LogLevelDefine.error,
          "Mkey ini file name err(${mkeySect.value}.ini)");
      return NG_B;
    }
    myIni = "${mkeySect.value}.json";

    /* get drivers ini (tower type) */
    final isTower = await sysIni.getValueWithName(mkeySect.value, "tower");
    if (!isTower.result) {
      TprLog().logAdd(myTid, LogLevelDefine.error,
          "Mkey ini file tower-type getting Error: ${isTower.cause.name}");
      return NG_B;
    }
    savePortNm = isTower.value + PlusDrvChk.PLUS_MKEY_D;

    return OK_B;
  }

  /// 設定ファイルを読み取り、パラメータをチェックする（mkey.ini）
  ///
  /// 引数: なし
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - mkey_Init(), mkey_port_open()
  Future<bool> _mkeyMyIniGet() async {
    switch (myIni) {
      case "mkey_2800_1.json":
        Mkey_2800_1JsonFile mkey_1Ini = Mkey_2800_1JsonFile();
        await mkey_1Ini.load();
        keyId = mkey_1Ini.settings.id;
        deviceFlg = mkey_1Ini.settings.connect;
        MsrInfo().compCnt = mkey_1Ini.settings.comp_cnt;
        break;
      case "mkey_2800_2.json":
        Mkey_2800_2JsonFile mkey_2Ini = Mkey_2800_2JsonFile();
        await mkey_2Ini.load();
        keyId = mkey_2Ini.settings.id;
        deviceFlg = mkey_2Ini.settings.connect;
        MsrInfo().compCnt = mkey_2Ini.settings.comp_cnt;
        break;
      default:
        TprLog().logAdd(myTid, LogLevelDefine.error, "Mkey ini file not found");
        return false;
    }

    /* Get Device File Path */
    switch (deviceFlg) {
      case 5:
        keyFilePath = KEYFILEPATH_1;
        break;
      case 6:
        keyFilePath = KEYFILEPATH_2;
        break;
      default:
        TprLog().logAdd(myTid, LogLevelDefine.error,
            "param error in my.ini (connect): $deviceFlg");
        return NG_B;
    }

    return OK_B;
  }

  /// 設定ファイルを読み取り、キータイプを設定する（mac_info.ini）
  ///
  /// 引数: なし
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - keytype_determine()
  Future<bool> _keyTypeDetermine() async {
    int macKeyType = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return NG_B;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macIni = pCom.iniMacInfo;
    switch (keyId) {
      case 1:
      case 3:
        myDid = TprDidDef.TPRDIDMECKEY1;
        MsrInfo().myDid = [TprDidDef.TPRDIDMGC1JIS1, TprDidDef.TPRDIDMGC1JIS2];
        MsrInfo().device = Rs232cDev.RS232C_MSR2800D;
        macKeyType = macIni.system.keytype_desk;
        TprLog().logAdd(myTid, LogLevelDefine.normal, "DID:TPRDIDMECKEY1");
        break;
      case 2:
        myDid = TprDidDef.TPRDIDMECKEY2;
        MsrInfo().myDid = [TprDidDef.TPRDIDMGC2JIS1, TprDidDef.TPRDIDMGC2JIS2];
        MsrInfo().device = Rs232cDev.RS232C_MSR2800T;
        macKeyType = macIni.system.keytype_tower;
        TprLog().logAdd(myTid, LogLevelDefine.normal, "DID:TPRDIDMECKEY2");
        break;
      default:
        TprLog().logAdd(
            myTid, LogLevelDefine.error, "Mechanical key id err in my.ini");
        return NG_B;
    }

    String erLog = "";
    webType = await CmCksys.cmWebType();
    web28Type = CmCksys.cmWeb2800Type(sysIni);
    switch (macKeyType) {
      case 0:
        switch (webType) {
          case CmSys.WEBTYPE_WEB2800:
            if ((keyId == 1) || (keyId == 3)) {
              // Desktop
              if ((web28Type == CmSys.WEB28TYPE_I) ||
                  (web28Type == CmSys.WEB28TYPE_IP) ||
                  (web28Type == CmSys.WEB28TYPE_I3)) {
                keyType = 2;
                tbl = MkeyTbl().MkeyTbl68;
                erLog = "Web2800i mkey68 DesktopKey";
              } else if (web28Type == CmSys.WEB28TYPE_PR3) {
                keyType = 4;
                tbl = MkeyTbl().MkeyTbl30;
                erLog = "Prime3 mkey30 DesktopKey";
                break;
              } else {
                if (TprxPlatform.getFile(CmSys.TYPE52KEY_D).existsSync()) {
                  keyType = 5;
                  tbl = MkeyTbl().MkeyTbl52;
                  erLog = "Web2800a mkey52 DesktopKey";
                } else if (TprxPlatform.getFile(CmSys.TYPE52KEY_D).existsSync()) {
                  keyType = 6;
                  tbl = MkeyTbl().MkeyTbl35;
                  erLog = "Web3800a mkey35 DesktopKey";
                } else {
                  if ((web28Type == CmSys.WEB28TYPE_IM) ||
                      (web28Type == CmSys.WEB28TYPE_A3)) {
                    keyType = 1;
                    tbl = MkeyTbl().MkeyTbl84;
                    erLog = "Web2800a mkey84 DesktopKey";
                  } else {
                    if((web28Type == CmSys.WEB28TYPE_G3) &&(CmCksys.cmTRK05System() == 1)) {
                      keyType = 1;
                      tbl = MkeyTbl().MkeyTbl84;
                      erLog = "Web2800a mkey84 DesktopKey";
                    } else {
                      keyType = 2;
                      tbl = MkeyTbl().MkeyTbl68;
                      erLog = "Web2800a mkey68 DesktopKey";
                    }
                  }
                }
              }
            } else if (keyId == 2) {
              // Tower
              if (TprxPlatform.getFile(CmSys.TYPE52KEY_T).existsSync()) {
                keyType = 5;
                tbl = MkeyTbl().MkeyTbl52;
                erLog = "Web2800 mkey52 TowerKey";
              } else {
                keyType = 2;
                tbl = MkeyTbl().MkeyTbl68;
                erLog = "Web2800 mkey68 TowerKey";
              }
            }
            break;
          case CmSys.WEBTYPE_WEB2350:
            if ((keyId == 1) || (keyId == 3)) {
              // Desktop
              keyType = 3;
              tbl = MkeyTbl().MkeyTbl56_2350;
              erLog = "Web2350 mkey56 DesktopKey";
            } else if (keyId == 2) {
              // Tower
              keyType = 4;
              tbl = MkeyTbl().MkeyTbl30_2350;
              erLog = "Web2350 mkey30 TowerKey";
            }
            break;
          case CmSys.WEBTYPE_WEB2500:
            if ((keyId == 1) || (keyId == 3)) {
              // Desktop
              keyType = 3;
              tbl = MkeyTbl().MkeyTbl56;
              erLog = "Web2500 mkey56 DesktopKey";
            } else if (keyId == 2) {
              // Tower
              keyType = 4;
              tbl = MkeyTbl().MkeyTbl30;
              erLog = "Web2500 mkey30 TowerKey";
            }
            break;
          case CmSys.WEBTYPE_WEBPLUS2:
            keyType = 4;
            tbl = MkeyTbl().MkeyTbl30;
            erLog = "Specified Default mkey30 DesktopKey";
            break;
          default:
            if ((keyId == 1) || (keyId == 3)) {
              // Desktop
              keyType = 1;
              tbl = MkeyTbl().MkeyTbl84;
              erLog = "Specified Default mkey84 Key";
            } else if (keyId == 2) {
              // Tower
              keyType = 2;
              tbl = MkeyTbl().MkeyTbl68;
              erLog = "Specified Default mkey68 Key";
            }
            break;
        }
        break;
      case 1:
        keyType = 1;
        tbl = MkeyTbl().MkeyTbl84;
        erLog = "Specified Default mkey84 Key";
        break;
      case 2:
        keyType = 2;
        tbl = MkeyTbl().MkeyTbl68;
        erLog = "Specified Default mkey68 Key";
        break;
      case 3:
        keyType = 3;
        tbl = MkeyTbl().MkeyTbl56;
        erLog = "Specified Default mkey56 Key";
        break;
      case 4:
        keyType = 4;
        tbl = MkeyTbl().MkeyTbl30;
        erLog = "Specified Default mkey30 Key";
        break;
      case 5:
        keyType = 5;
        tbl = MkeyTbl().MkeyTbl52;
        erLog = "Specified Default mkey52 Key";
        break;
      case 6:
        keyType = 6;
        tbl = MkeyTbl().MkeyTbl35;
        erLog = "Specified Default mkey35 Key";
        break;
      default:
        keyType = 1;
        tbl = MkeyTbl().MkeyTbl84;
        erLog = "Specified Default mkey84 Key";
        break;
    }
    TprLog().logAdd(myTid, LogLevelDefine.normal, erLog);

    return OK_B;
  }

  /// 設定ファイルを読み取り、パラメータをチェックする関数（repeat_tool.ini）
  ///
  /// 引数: なし
  ///
  /// 戻り値: なし
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - rptTool_inifile_get()
  Future<void> _rptToolIniFileGet() async {
    Repeat_toolJsonFile rptIni = Repeat_toolJsonFile();
    await rptIni.load();

    rptToolFlg = rptIni.settings.tool_onoff;
    if (rptToolFlg == 1) {
      recBtn = rptIni.settings.rec_btn;
      playBtn = rptIni.settings.play_btn;
    }
  }

  /// ポート接続を行う
  ///
  /// 引数: なし
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - mkey_port_open()
  bool mkeyPortOpen() {
    mkeyret = FFIMechanicalKey.mechanicalKeyPortOpen(keyFilePath);
    if (mkeyret.result != 0) {
      TprLog().logAdd(0, LogLevelDefine.normal,
          "Linux MKey init Failed: mechanicalKeyPortOpen()");
      return NG_B;
    }

    return OK_B;
  }

  /// システムタスクへ、準備完了or未完了を送信する
  ///
  /// 引数: [isInit] drw_init()の正常終了有無（true:Normal End  false:Error）
  ///
  /// 戻り値: なし
  ///
  ///  関連tprxソース:tprdrv_drw_2800.c - main()
  Future<void> sendReady(bool isInit) async {
    int status = 0;

    /// TODO: readFbMem()の引数は暫定（現状、fbMemを初期化するのみ）
    fbMem = SystemFunc.readFbMem(null);

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

    fbMem.drv_stat.removeAt(savePortNm);
    fbMem.drv_stat.insert(savePortNm, PlusDrvStat.PLUS_STS_MNG_SET_OK);
    fbMem.rpt_rec = 0;
    fbMem.rpt_play = 0;

    /// TODO: writeFbMem()の引数は暫定（現状、0を返すのみ）
    SystemFunc.writeFbMem(null, fbMem);
  }

  /// キーコードを取得し、FuncKeyに変換してメインアプリへ渡す関数
  ///
  /// 引数：なし
  ///
  /// 戻り値: なし
  ///
  /// ※メイン側Isolateへの送信ポートはクラス変数の_parentSendPortを使用する。
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - main(), mkey_SysWrite()
  Future<void> startKeyHook() async {
    // if (!_mkeyReopen()) {
    //   TprLog().logAdd(0, LogLevelDefine.normal, "main roop mkey_reopen error");
    //   sleep(const Duration(microseconds: READ_ERR_WAIT));
    //   return;
    // }
    //key キーコードが返ってくる.
    mecData = "";
    mkeyret =
        FFIMechanicalKey.mechanicalKeyEventRcv(mkeyret.fds, keyFilePath);
    int key = mkeyret.result;
    if (key == 0) {
      return;
    }
    int ret = await _getFuncKeyFromNumLinux(key);
    TprLog().logAdd(myTid, LogLevelDefine.normal,
        "Linux MKey Push input:$key");

    if ((ret != NG_I) && (mecData != "") && (mecData != "\x00\x00")) {
      RxInputBuf inp = RxInputBuf();
      inp.ctrl.ctrl = true;
      inp.devInf.devId = 1;
      inp.mecData = mecData;
      _parentSendPort?.send(NotifyFromSIsolate(
          NotifyTypeFromSIsolate.mechaKeyCommand,
          inp)); // メインアプリのスレッドにinput情報を送信.
    }
  }

  /// メカキーと再接続する
  ///
  /// 引数：なし
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = error
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - mkey_reopen()
  bool _mkeyReopen() {
    /// TODO: readFbMem()の引数は暫定（現状、fbMemを初期化するのみ）
    fbMem = SystemFunc.readFbMem(null);

    if ((savePortNm != PlusDrvChk.PLUS_MKEY_D) &&
        (savePortNm != PlusDrvChk.PLUS_MKEY_T)) {
      TprLog().logAdd(myTid, LogLevelDefine.error,
          "mkey_reopen SavePortNm Illegal[$savePortNm]");
      return NG_B;
    }
    if ((fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN) ||
        (fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_REOPEN2) ||
        (fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_CLOSE)) {
      TprLog().logAdd(myTid, LogLevelDefine.normal,
          "mkey_reopen[$savePortNm][${fbMem.drv_stat[savePortNm]}]");
      if (fbMem.drv_stat[savePortNm] == PlusDrvStat.PLUS_STS_COM_REQ_CLOSE) {
        TprLog().logAdd(myTid, LogLevelDefine.normal, "mkey_reopen return 0");
        fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MSG_SET_CLOSE;
        return OK_B;
      }
      if (!mkeyPortOpen()) {
        if (fbMem.drv_stat[savePortNm] ==
            PlusDrvStat.PLUS_STS_COM_REQ_REOPEN2) {
          fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MNG_REOPEN2_NG;
        } else {
          fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MNG_REOPEN_NG;
        }
        TprLog().logAdd(myTid, LogLevelDefine.normal, "mkey_reopen reopen error");
        return NG_B;
      }
      TprLog().logAdd(myTid, LogLevelDefine.normal, "mkey_reopen ok");
      fbMem.drv_stat[savePortNm] = PlusDrvStat.PLUS_STS_MNG_SET_OK;
    }
    TprLog().logAdd(myTid, LogLevelDefine.normal, "MKey reopen end");
    return OK_B;
  }

  /// キーコードからメカキーに変換する
  ///
  /// 引数：[code] キーコード
  ///
  /// 戻り値：メカキーコード（変換に失敗した場合、-1）
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - main()
  Future<int> _getFuncKeyFromNumLinux(int code) async {

    TprLog().logAdd(myTid, LogLevelDefine.normal, "Key Code:$code");
    if ((code == 54) || (code == 39)) {
      // RIGHTSHIFT or SEMICOLON
      if (webType != CmSys.WEBTYPE_WEB2350) {
        MsrInfo().msrFlg = true;
      }
    }

    if ((rptToolFlg == 1) && !MsrInfo().msrFlg) {
      if (code == recBtn) {
        if (fbMem.rpt_play == 1) {
          return (NG_I);
        }
        if (fbMem.rpt_rec == 0) {
          TprLog().logAdd(myTid, LogLevelDefine.normal, "rpt_rec_push:on");
          ComRptTool.rptToolRecStart();
        } else {
          TprLog().logAdd(myTid, LogLevelDefine.normal, "rpt_rec_push:off");
          ComRptTool.rptToolRecStop();
        }
        fbMem.rpt_rec = (fbMem.rpt_rec == 1) ? 0 : 1;
      } else if (code == playBtn) {
        if (fbMem.rpt_rec == 1) {
          return (NG_I);
        }
        if (fbMem.rpt_play == 0) {
          TprLog().logAdd(myTid, LogLevelDefine.normal, "rpt_play_push:on");
          ComRptTool.rptToolPlayStart();
        } else {
          TprLog().logAdd(myTid, LogLevelDefine.normal, "rpt_play_push:off");
        }
        fbMem.rpt_play = (fbMem.rpt_play == 1) ? 0 : 1;
      }

      /// TODO: writeFbMem()の引数は暫定（現状、0を返すのみ）
      SystemFunc.writeFbMem(null, fbMem);
      return (NG_I);
    }

    if (MsrInfo().msrFlg) {
      await TprDrvMkeyMsr().msrFromDevice(code);
      msrCount++;
      if (msrCount > MSR_INTERVAL) {
        TprLog().logAdd(
            myTid, LogLevelDefine.error, "Over MSR_INTERVAL: Reset msr_flag");
        msrCount = 0;
        dataCount = 0;
        MsrInfo().msrFlg = false;
      }
    } else {
      await _mkeyFromDevice(code);
    }

    return OK_I;
  }

  /// メカキーデータ受信処理
  ///
  /// 引数:[code] 取得したキーコード
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - mkey_FromDevice()
  Future<int> _mkeyFromDevice(int code) async {
    int keyId = -1;
    double timeDiff = 0.0;
    String fileName = "${EnvironmentData().sysHomeDir}/tmp/digi/TMCNCL.TXT";

    if (fbMem.kbd_stop > 0) {
      TprLog().logAdd(myTid, LogLevelDefine.normal,
          "kbd_stop[${fbMem.kbd_stop}][${fbMem.FBvnc}][${MkeyData().mkey[0].padLeft(2, '0')}${MkeyData().mkey[1].padLeft(2, '0')}]");
      RecogRetData resultData = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_BRAIN_SYSTEM, RecogTypes.RECOG_GETMEM);
      if ((resultData.result == RecogValue.RECOG_OK0893) ||
          (resultData.result == RecogValue.RECOG_YES)) {
        if (fbMem.FBvnc > 0) {
          if (!TprxPlatform.getFile(fileName).existsSync()) {
            TprLog().logAdd(myTid, LogLevelDefine.normal,
                "mkey_FromDevice() file open error: $fileName");
          } else {
          }
          BrainFile.brainFileMake(sysIni, myTid, BrainFile.BRAIN_CANCEL);
        }
      }
    }

    if (_mkeyKeyCodeEdit(code)) {
      pressTime = DateTime.now();
      timeDiff = pressTime.difference(keepPressTime).inMilliseconds / 1000;

      if ((0 < timeDiff) &&
          (timeDiff < PRESS_CHATTERING_TIME) &&
          (code == keepKey)) {
        TprLog().logAdd(myTid, LogLevelDefine.error,
            "chattering error interval [${timeDiff.toStringAsFixed(3)} sec] key[$code]");
      } else {
        mecData = MkeyData().mkey;
        if ((rptToolFlg == 1) && (fbMem.rpt_rec == 1)) {
          String tmpLst = "";
          ComRptTool.comRptOpeRec(myDid, code, 0, tmpLst);
        }
        keepKey = code;
        keepPressTime = pressTime;
      }
    } else {
      TprLog().logAdd(myTid, LogLevelDefine.error, "mkey_KeyCodeEdit() NG");
    }

    return keyId;
  }

  /// キーコード変換処理
  ///
  /// 引数:[keycode] 取得したキーコード
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  ///  関連tprxソース:tprdrv_mkey_2800.c - mkey_KeyCodeEdit()
  bool _mkeyKeyCodeEdit(int keycode) {
    if ((keycode < 0) || (keycode > MkeyTbl().KEYTABLE_MAX)) {
      return NG_B;
    }
    MkeyData().start_key = tbl[keycode][0];
    MkeyData().end_key = tbl[keycode][1];
    MkeyData().mkey = tbl[keycode][2];

    return OK_B;
  }

  /// 中断処理
  void abort() {
    _isAbort = true;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvMKeyIsolate _abort");
  }

  /// 停止処理
  void stop() {
    _isStop = true;
    timerFunc!.cancel();
    timerFunc = null;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvMKeyIsolate _stop");
  }

  /// 再開処理
  void restart() {
    _isStop = false;
    if (timerFunc == null) {
      timerFunc = Timer.periodic(Duration(milliseconds: 10), (timer) => {_onTimer(timer)});
    }
    TprLog().logAdd(myTid, LogLevelDefine.normal, "DrvMKeyIsolate _restart");
  }

  /// メカキーを模擬入力する。
  ///
  /// 引数:[keyCode] メカキーのキーコード
  ///
  /// 戻り値: なし
  void keyCodeLoopbackIn(int keyCode) {
    FFIMechanicalKey.testKey = keyCode;
  }
}
