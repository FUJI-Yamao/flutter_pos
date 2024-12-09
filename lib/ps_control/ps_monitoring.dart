/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import '../app/common/cls_conf/mac_infoJsonFile.dart';
import '../app/common/cmn_sysfunc.dart';
import '../app/common/environment.dart';
import '../app/if/if_drv_control.dart';
import '../app/inc/apl/rxmem_define.dart';
import '../app/inc/sys/tpr_log.dart';
import '../app/lib/cm_sys/cm_cksys.dart';
import '../app/ui/enum/e_screen_kind.dart';

/// プロセスステータス
enum PosPsState {
  /// 停止
  stop,
  /// 実行中
  run,
}

/// メイン画面以外のプロセス監視
class PosPsMonitoring {
  /// 監視プロセスから受け取るport
  static late ReceivePort _rcvPort;
  /// 監視プロセスへ送るport.
  static SendPort? _outputPort;

  /// 客側画面など別画面アプリの起動と監視を開始する(別Isolate)
  /// mainIsolateから呼び出す.
  static Future<void> startIsolate(RootIsolateToken rootIsolateToken) async {
    _rcvPort = ReceivePort();

    _rcvPort.listen((notify) async {
      final notifyFromDev = notify as NotifyFromSIsolate;
      switch (notifyFromDev.notifyType) {
        case NotifyTypeFromSIsolate.sendPort:
          _outputPort = notifyFromDev.option as SendPort;
          break;
        default:
          break;
      }
      // MEMO: PosProcessMonitoringIsolateからの通知を受信する.
    });
    await Isolate.spawn(PosProcessMonitoringIsolate().customerRun,
        DeviceIsolateInitData(_rcvPort.sendPort, TprLog().logPort!, 0 , AppPath().path, EnvironmentData(),
      SystemFunc.readRxCommonBuf(),null,null,null,rootIsolateToken ));
  }

  /// 監視プロセスへ命令を出す.
  static Future<void> sendPosProcess(dynamic cmd) async {
    // MEMO: プロセスの停止命令や再起動命令を送る.
    _outputPort?.send(cmd);
  }
  /// デバドラ側で保持している共有メモリを更新させる。
  static void updateShareMemory(SystemFuncPayload payload) async {
    if (_outputPort != null) {
      _outputPort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory,
          payload, returnPort: _rcvPort.sendPort));
    }
  }
}

///　プロセス監視
class PosProcessMonitoringIsolate {
  /// exeのパスを取得する
  static String get exePath {

    if (Platform.isWindows) {
      return path.join(
          EnvironmentData().sysHomeDir,
          'apl',
          'flutter_pos.exe');
    } else if (Platform.isLinux) {
         return path.join(
          EnvironmentData().sysHomeDir,
          'apl',
          'flutter_pos');
    }
    return "";
  }

  /// マシン環境設定ファイル
  late Mac_infoJsonFile _macInfoJsonFile;

  /// プロセスのステータスマップ
  final Map<ScreenKind, PosPsState> _stateMap = {};

  /// このアプリの画面種別
  late ScreenKind _thisScreenKind;

  /// 客表画面起動処理
  Future<void> customerRun(DeviceIsolateInitData initData) async {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    SendPort parentSendPort = initData.appPort;
    parentSendPort
        .send(NotifyFromSIsolate(NotifyTypeFromSIsolate.sendPort, sendPort));

    BackgroundIsolateBinaryMessenger.ensureInitialized(initData.token!);
    // ログ設定.
    TprLog().setIsolateName("psMonitoring", initData.appEnv.screenKind);
    TprLog().logPort = initData.logPort;
    TprLog().sendWaitListLog();
     // アプリパスを取得.
    AppPath().path = initData.appPath;
    // ホームパス（環境変数）を取得.
    EnvironmentData().sysHomeDir = initData.appEnv.sysHomeDir;
    _thisScreenKind = initData.appEnv.screenKind;

    // 使用する共有メモリをセットアップする
    await setupShareMemory(initData);

    if (exePath.isEmpty) {
      TprLog().logAdd(
          Tpraid.TPRAID_NONE, LogLevelDefine.normal, "実行体のパスが設定されていません");
      return;
    }
    _macInfoJsonFile = initData.pCom!.iniMacInfo;

    receivePort.listen((notify) {
      // mainIsolateからの通知を受け取る.
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(parentSendPort, payload.index, payload.buf,
              RxMemAttn.SLAVE, "ProcessMonitoring");
          break;
        default:
      }
    });

    _runCustomer();
  }

  /// 客表画面を起動する
  Future<void> _runCustomer() async {
    if (_macInfoJsonFile.internal_flg.colordsp_cnct != 0) {
      // カラー客表を起動する
      ScreenKind kind = ScreenKind.customer;
      if (_macInfoJsonFile.internal_flg.colordsp_size == 0) {
        // 7インチ
        if (_thisScreenKind == ScreenKind.register) {
          kind = ScreenKind.customer_7_1;
        } else if (_thisScreenKind == ScreenKind.register2) {
          kind = ScreenKind.customer_7_2;
        }
      }
      // 後続の処理をブロックしないため非同期で呼び出し.
      runExe(kind);
    }
  }

  /// exeを実行する.exeが異常終了した場合には再度実行する.
  /// この関数はexeの監視のため終了しない、非同期で呼びだすこと.
  Future<void> runExe(ScreenKind kind) async {
    try {
      String path = exePath;
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "flutter_pos.exe ${kind.name} 客表画面を起動します。");
      // exeが終了したタイミングで返り値が返ってくる.
      var result = await Process.run(path, [kind.commandParameterName]);
      _stateMap[kind] = PosPsState.run;
      // 客表画面が異常終了したら再起動のループ
      while (result.exitCode <= 0) {
        _stateMap[kind] = PosPsState.stop;
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
            "flutter_pos.exe ${kind.name} 終了しました。再起動します。");

        // すぐに起動するのではなく、少し間をあける.
        await Future.delayed(const Duration(milliseconds: 100));
        result = await Process.run(path, [kind.commandParameterName]);
        _stateMap[kind] = PosPsState.run;
      }
    } catch (e, s) {
      _stateMap[kind] = PosPsState.stop;
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "${kind.name} 起動エラー $e $s");
    }
  }

  /// 使用する共有メモリをセットアップする
  static Future<void> setupShareMemory(DeviceIsolateInitData initData) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemWrite(
        null, RxMemIndex.RXMEM_COMMON, initData.pCom!, RxMemAttn.MASTER);
  }
}
