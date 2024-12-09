/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'dart:ui';

import '../common/cmn_sysfunc.dart';
import '../drv/changer/drv_changer_isolate.dart';
import '../regs/checker/rc_key.dart';
import '../ui/controller/c_drv_controller.dart';
import 'if_drw_isolate.dart';
import 'if_mkey_isolate.dart';
import 'if_scan_isolate.dart';
import 'if_print_isolate.dart';
import 'if_upsPlus_isolate.dart';
import 'if_multiTmn_isolate.dart';
import 'if_changer_isolate.dart';
import 'if_sample_isolate.dart';
import '../lib/cm_sys/cm_cksys.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/lib/cm_sys.dart';
import '../inc/sys/tpr_log.dart';
import '../inc/sys/tpr_ipc.dart';
import '../common/environment.dart';
import '../ui/enum/e_screen_kind.dart';

// ****< jsonファイル関係 >****************************
import '../common/cls_conf/acbJsonFile.dart';
import '../common/cls_conf/acb20JsonFile.dart';
import '../common/cls_conf/acb50JsonFile.dart';
import '../common/cls_conf/acrJsonFile.dart';
import '../common/cls_conf/fal2JsonFile.dart';
import '../common/cls_conf/mac_infoJsonFile.dart';
import '../common/cls_conf/mkey_2800_1JsonFile.dart';
import '../common/cls_conf/mkey_2800_2JsonFile.dart';
import '../common/cls_conf/recogkey_dataJsonFile.dart';
import '../common/cls_conf/repeat_toolJsonFile.dart';
import '../common/cls_conf/scan_2800_1JsonFile.dart';
import '../common/cls_conf/scan_2800_2JsonFile.dart';
import '../common/cls_conf/scan_2800_3JsonFile.dart';
import '../common/cls_conf/scan_2800_4JsonFile.dart';
import '../common/cls_conf/scan_2800a3_1JsonFile.dart';
import '../common/cls_conf/scan_2800g3_1JsonFile.dart';
import '../common/cls_conf/scan_2800i3_1JsonFile.dart';
import '../common/cls_conf/scan_2800im_1JsonFile.dart';
import '../common/cls_conf/scan_2800im_2JsonFile.dart';
import '../common/cls_conf/scan_2800ip_1JsonFile.dart';
import '../common/cls_conf/scan_2800ip_2JsonFile.dart';
import '../common/cls_conf/staffJsonFile.dart';
import '../common/cls_conf/sysJsonFile.dart';
import '../common/cls_conf/tprtfJsonFile.dart';
import '../common/cls_conf/tprtimJsonFile.dart';
import '../common/cls_conf/tprtim_counterJsonFile.dart';
import '../common/cls_conf/tprtrpJsonFile.dart';
import '../common/cls_conf/tprtsJsonFile.dart';
import '../common/cls_conf/tprtss2JsonFile.dart';
import '../common/cls_conf/tprtssJsonFile.dart';


/// main以外のIsolate(SubIsolate)からmainIsolateへ送る通知タイプ.
enum NotifyTypeFromSIsolate {
  drwStatus, // ドロアのステータスを取得する.
  mechaKeyCommand, // メカキーの押下情報.
  scanData, // スキャンしたデータ情報.
  scanDataN, // スキャンしたデータ情報.
  receiptSettingError, //　プリンタのレシート設定エラー情報.
  uploadShareMemory, // 共有メモリアップロード
  printStatus,  // プリンタステータス
  sendPort,
}

const int bitShift_Tid = 12;

/// main以外のIsolate(SubIsolate)から送られてくるデータクラス.
class NotifyFromSIsolate {
  NotifyTypeFromSIsolate notifyType;
  dynamic option;
  NotifyFromSIsolate(this.notifyType, this.option);
}

/// アプリ(MainIsolate)からSubIsolateへ送る通知タイプ.
enum NotifyTypeFromMIsolate {
  driverStart,  // ドライバを開始する。
  driverStop,  // ドライバを終了する。
  drwOpen, // ドロアを開ける.
  drwClose, // ドロアを閉じる.（デバッグ用）
  drwStatus, // ドロアのステータスを取得する。
  drwPortClose, // ドロワとの通信を切断する.
  receiveStart, // ドライバの入力情報取得を開始する.(メカキーの入力やスキャンの開始など)
  receiveStop, // ドライバの入力情報取得を終了する.(メカキーの入力やスキャンの終了など)
  receivedata, //
  commandSend,  // ドライバへのコマンドを送信する。
  loopbackIn,   // テストデータ入力
  printCommand, // プリンタへ印字命令を投げる.
  checkReceiptSetting, // レシートの設定状態を確認する.
  changerRequest, //釣銭機にコマンドを送信する.
  changerReceive, //釣銭機からデータを受信する.
  shutdownRequest, //shutdown要求
  abort,             // 中断
  stop,              // 停止
  restart,           // 再開
  updateShareMemory, // 共有メモリ更新
}

/// アプリ(MainIsolate)から送られてくるデータクラス.
class NotifyFromApp {
  NotifyTypeFromMIsolate notifyType;
  dynamic option;
  TprMsgDevReq2_t? msg;
  /// Isolateからの返答が必要な場合に,受信するportをセットする.
  SendPort? returnPort;
  NotifyFromApp(this.notifyType, this.option,{ this.msg, this.returnPort});
}

/// Isolateを起動するときのデータ
class DeviceIsolateInitData {
  SendPort appPort;
  SendPort logPort;
  int taskId;
  String appPath;
  EnvironmentData appEnv;
  RxCommonBuf? pCom;
  RxTaskStatBuf? tsBuf;
  RxSoundStat? sound;
  RxPrnStat? iBuf;
  RootIsolateToken? token;
  DeviceIsolateInitData(this.appPort, this.logPort, this.taskId,
      this.appPath, this.appEnv,
      this.pCom, this.tsBuf,[this.sound, this.iBuf,this.token]);
}

/// プロトタイプ向け.
/// デバイスとの通信やコマンドの管理を行うシングルトンクラス.
class IfDrvControl {

  /// メカキーの処理マップ
  Map<String, KeyDispatch?> dispatchMap = {};
  /// スキャナの処理マップ
  Map<String, Function(RxInputBuf)?> scanMap = {};

  late IfDrwIsolate  drwIsolateCtrl  = IfDrwIsolate();
  late IfMkeyIsolate  mkeyIsolateCtrl  = IfMkeyIsolate();
  late IfScanIsolate  scanIsolateCtrl  = IfScanIsolate();
  late IfScanIsolate  scanIsolateCtrl2  = IfScanIsolate();
  late IfPrintIsolate  printIsolateCtrl = IfPrintIsolate() ;
  late IfUpsPlusIsolate  upsPlusIsolateCtrl = IfUpsPlusIsolate();
  late IfMultiTmnIsolate  multiTmnIsolateCtrl = IfMultiTmnIsolate();
  late IfChangerIsolate  changerIsolateCtrl = IfChangerIsolate() ;
  late IfSampleIsolate sampleIsolateCtrl = IfSampleIsolate();

  static final IfDrvControl _instance = IfDrvControl._internal();
  factory IfDrvControl() {
    return _instance;
  }
  IfDrvControl._internal();

  /// MEMO:テスト用ソース.
  /// デバイスIsolateなしで起動するモード.
  /// VirtualBoxだとデバイス関連ファイルが存在しないため起動しない問題の回避策.
  /// run時の引数に「--dart-define=WITHOUT_DEVICE=true」を追加すると有効化される.
  static bool isWithoutDeviceMode() {
    bool isWithoutDevice =
        const bool.fromEnvironment("WITHOUT_DEVICE", defaultValue: false);
    return isWithoutDevice;
  }

  Future<void> startSubIsolate() async {
    await setBufStatInit();

    await callPreInit();

    /// MEMO:設定ファイル読み取り用
    String absolutePath = EnvironmentData.TPRX_HOME;
    TprLog().logAdd(0, LogLevelDefine.normal, "Device Isolate Start.");
    String type = await getWebType();
    if( EnvironmentData().screenKind == ScreenKind.register ) {
      // ScreenKind.register
      if( type == CmSys.BOOT_WEB2800_TOWER){
        await mkeyIsolateCtrl.startIsolate(absolutePath, (1 << bitShift_Tid));
        await drwIsolateCtrl.startDrwIsolate(absolutePath, (9 << bitShift_Tid));
        await printIsolateCtrl.startPrintIsolate(absolutePath, (25 << bitShift_Tid));
        await upsPlusIsolateCtrl.startUpsPlusIsolate(absolutePath, (24 << bitShift_Tid));
        await multiTmnIsolateCtrl.startMultiTmnIsolate(absolutePath, (26 << bitShift_Tid));
        await changerIsolateCtrl.startChangerIsolate(absolutePath, (27 << bitShift_Tid));
      } else {
        await mkeyIsolateCtrl.startIsolate(absolutePath, (1 << bitShift_Tid));
        await scanIsolateCtrl.startScanIsolate(absolutePath, (3 << bitShift_Tid));
        await drwIsolateCtrl.startDrwIsolate(absolutePath, (5 << bitShift_Tid));
        await printIsolateCtrl.startPrintIsolate(absolutePath, (22 << bitShift_Tid));
        await upsPlusIsolateCtrl.startUpsPlusIsolate(absolutePath, (24 << bitShift_Tid));
        await multiTmnIsolateCtrl.startMultiTmnIsolate(absolutePath, (26 << bitShift_Tid));
        await changerIsolateCtrl.startChangerIsolate(absolutePath, (27 << bitShift_Tid));
      }
    } else {
      // ScreenKind.register2
      if( type == CmSys.BOOT_WEB2800_TOWER){
        await mkeyIsolateCtrl.startIsolate(absolutePath, (2 << bitShift_Tid));
        await scanIsolateCtrl.startScanIsolate(absolutePath, (5 << bitShift_Tid));
        await scanIsolateCtrl2.startScanIsolate(absolutePath, (6 << bitShift_Tid));
      } else {
      }
    }
    //await sampleIsolateCtrl.startIsolate(absolutePath, (99 << bitShift_Tid));  // 新規追加時確認用
  }

  /// WEBの機種タイプを取得する
  Future<String> getWebType() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    String retWebType = CmSys.BOOT_WEB2800_DESKTOP;
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;
      SysJsonFile sysIni = pCom.iniSys;
      retWebType = CmCksys.cmWebTypeGet(sysIni);
    }
    return retWebType;
  }
  /// TODO:暫定処理
  /// ※この処理は既存コードの登録画面での初期化処理にて行われているものの一部である。
  /// 　レジの作りこみが進んだら削除する。
  /// \src\regs\checker\Regs.c　rcErr_StatClear1()
  Future<void> setBufStatInit() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isValid()) {
      RxTaskStatBuf tsBuf = xRet.object;
      tsBuf.chk.chk_registration = 0;
      tsBuf.chk.stlkey_retn_function = 0;
      tsBuf.chk.colorfip_ctrl_flg = 0;
      tsBuf.chk.cin_total_price = 0;
      tsBuf.chk.kycash_redy_flg = 0;
      tsBuf.chk.regs_start_flg = 1;
      await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "DRV CONTROL");
    }
  }

  ///---------------------------------------------------------------------------
  /// ドライバで使用するJSONファイルが存在しないときのため、
  /// ～JonFile.loadでアプリフォルダにJSONファイルを作成しておく。
  /// メンテナンス画面などでJSONファイルの事前ロードをサポートするようになったら不要（削除）
  ///---------------------------------------------------------------------------
  Future<void> callPreInit() async {
    // ******************************
    // 共通使用
    // ******************************
    await SysJsonFile().preMake();
    await Mac_infoJsonFile().preMake();
    // ******************************
    // DrvDrwIsolateで使用
    // ******************************
 // await SysJsonFile().preMake();
    // ******************************
    // DrvMKeyIsolateで使用
    // ******************************
 // await SysJsonFile().preMake();
 // await Mac_infoJsonFile().preMake();
    await Repeat_toolJsonFile().preMake();
    await Mkey_2800_1JsonFile().preMake();
    await Mkey_2800_2JsonFile().preMake();
    // ******************************
    // DrvScanIsolateで使用
    // ******************************
    await Recogkey_dataJsonFile().preMake();
    await Scan_2800_1JsonFile().preMake();
    await Scan_2800_2JsonFile().preMake();
    await Scan_2800ip_1JsonFile().preMake();
    await Scan_2800ip_2JsonFile().preMake();
    await Scan_2800im_1JsonFile().preMake();
    await Scan_2800im_2JsonFile().preMake();
    await Scan_2800a3_1JsonFile().preMake();
    await Scan_2800i3_1JsonFile().preMake();
    await Scan_2800g3_1JsonFile().preMake();
    await Scan_2800_3JsonFile().preMake();
    await Scan_2800_4JsonFile().preMake();
    await StaffJsonFile().preMake();
    // ******************************
    // DrvPrintIsolateで使用
    // ******************************
 // await SysJsonFile().preMake();
 // await Mac_infoJsonFile().preMake();
    await Tprtim_counterJsonFile().preMake();
    await TprtfJsonFile().preMake();
    await TprtimJsonFile().preMake();
    await TprtrpJsonFile().preMake();
    await TprtsJsonFile().preMake();
    await TprtssJsonFile().preMake();
    await Tprtss2JsonFile().preMake();
    // ******************************
    // DrvMultiTmnIsolateで使用
    // ******************************
 // await SysJsonFile().preMake();
    // ******************************
    // DrvChangerIsolateで使用
    // ******************************
 // await SysJsonFile().preMake();
 // await Mac_infoJsonFile().preMake();
    await AcbJsonFile().preMake();
    await Acb20JsonFile().preMake();
    await Acb50JsonFile().preMake();
    await AcrJsonFile().preMake();
    await Fal2JsonFile().preMake();

    // ******************************
    // DrvUpsPlusIsolateで使用
    // ******************************
    // 無し
  }
}
