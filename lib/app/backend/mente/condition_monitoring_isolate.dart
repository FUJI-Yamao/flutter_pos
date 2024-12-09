/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:process_run/process_run.dart';

import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import 'model/condition_monitoring_isolate_notify.dart';
import 'model/condition_monitoring_isolate_param.dart';
import 'model/condition_monitoring_notify.dart';

/// 状態監視の処理クラス（Isolate）
class ConditionMonitoringIsolate {
  /// コンストラクタ
  ConditionMonitoringIsolate(ConditionMonitoringIsolateParam actualResultsIsolateParam)
      : _filePath = join(actualResultsIsolateParam.environmentData.sysHomeDir, _fileName),
        _sendPort = actualResultsIsolateParam.sendPort {
    // ログ設定.
    TprLog().setIsolateName("ConditionMonitoring", actualResultsIsolateParam.environmentData.screenKind);
    TprLog().logPort = actualResultsIsolateParam.logPort;
    TprLog().sendWaitListLog();

    TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoringIsolate start");

    // main からの通知を受け取る
    _receivePort.listen(_handleResponsesFromMain);

    // mainに初期通知（SendPort交換）
    _init();
  }

  /// 状態監視ログの出力間隔（分）
  static const int _interval = 10;
  /// 状態監視ログの最大ファイルサイズ(30MB)
  static const int _maxFileSize = 30 * 1024 * 1024;
  /// 出力先のファイル名
  static const String _fileName = 'log/loop_cnct_system_check.txt';

  /// Tpraid
  final int _tpraid = Tpraid.TPRAID_NONE;

  /// 出力先のファイル名（フルパス）
  final String _filePath;
  /// main への 送信ポート
  final SendPort _sendPort;
  /// main からの 受信ポート
  final _receivePort = ReceivePort();

  /// 中断フラグ
  bool _isAbort = false;

  /// Isolateのmain関数
  static Future<void> main(ConditionMonitoringIsolateParam actualResultsIsolateParam) async {
    // アイソレートをルート アイソレートに登録します。
    // https://medium.com/flutter/introducing-background-isolate-channels-7a299609cad8
    BackgroundIsolateBinaryMessenger.ensureInitialized(actualResultsIsolateParam.rootIsolateToken);

    // インスタンス生成
    ConditionMonitoringIsolate actualResultsIsolate = ConditionMonitoringIsolate(actualResultsIsolateParam);

    // 状態監視の処理の処理開始
    await actualResultsIsolate._start();

    /// 状態監視の処理の処理終了
    actualResultsIsolate._end(msgKind: actualResultsIsolate._isAbort ? DlgConfirmMsgKind.MSG_STOP : DlgConfirmMsgKind.MSG_COMPLETE);

    // isolateの終了
    actualResultsIsolate._dispose();
  }

  /// 状態監視の処理の処理開始
  Future<void> _start() async {

    // 初回時は、すぐに状態監視ログを出力させるために、現在日時 - interval を設定する
    DateTime nextTime = DateTime.now().subtract(const Duration(minutes: _interval));
    DateTime nowTime;

    // 状態監視の処理
    while (true) {
      if (_isAbort) {
        // 中断
        break;
      }

      // 10分間隔で状態監視のログを出力する
      nowTime = DateTime.now();
      if (nowTime.isAfter(nextTime)) {

        // 状態監視のログを出力する
        await _outputLog(nowTime);

        // 次の10分後の時間を設定する
        nextTime = nowTime.add(const Duration(minutes: _interval));
      }

      // 10秒待機
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  /// 状態監視のログを出力する
  Future<void> _outputLog(DateTime nowTime) async {
    try {
      // 状態監視のコマンドを実行
      final result = await Shell(verbose: false).run(_getCommand(nowTime));
      if (result.isNotEmpty) {
        File file = File(_filePath);

        // 状態監視ログのファイルサイズ確認
        if (file.existsSync() && file.lengthSync() >= _maxFileSize) {
          // _maxFileSizeを超えていたら、ファイルを削除する。（世代管理はしない）
          file.deleteSync();
        }

        // 状態監視ログの書き込み
        for (int i = 0; i < result.length; i++) {
          file.writeAsStringSync(result[i].stdout, mode: FileMode.append);
        }
      }
    } catch (e, s) {
      TprLog().logAdd(_tpraid, LogLevelDefine.error, "$e\n$s");
    }
  }

  /// 状態監視のコマンド
  String _getCommand(DateTime nowTime) {
    String strCmd;
    if (Platform.isLinux) {
      strCmd = '''
echo [$nowTime]========
echo [free]
free
echo [ps aux]
ps aux
echo [df -i]
df -i
echo [top -b -n 1]
top -b -n 1
''';
    } else if (Platform.isWindows) {
      strCmd = '''
echo [$nowTime]========
echo [tasklist]
tasklist
''';
    } else {
      strCmd = '';
    }

    return strCmd;
  }

  /// mainに初期通知（SendPort交換）
  void _init() {
    ConditionMonitoringIsolateNotify actualResultsIsolateNotify = ConditionMonitoringIsolateNotify(
      type: ConditionMonitoringIsolateNotifyType.init,
      object: _receivePort.sendPort,
    );
    _sendPort.send(actualResultsIsolateNotify);

    TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoringIsolate _init");
  }

  /// 状態監視の処理の処理終了
  /// パラメータの両方がnullの場合は、正常終了として扱う
  void _end({
    DlgConfirmMsgKind? msgKind,
    String? errMsg,
  }) {
    ConditionMonitoringIsolateNotifyForEnd isolateNotifyForEnd = ConditionMonitoringIsolateNotifyForEnd(
      msgKind: msgKind,
      errMsg: errMsg,
    );

    ConditionMonitoringIsolateNotify actualResultsIsolateNotify = ConditionMonitoringIsolateNotify(
      type: ConditionMonitoringIsolateNotifyType.end,
      object: isolateNotifyForEnd,
    );

    // main Isolateに対して、処理完了のメッセージを送る
    _sendPort.send(actualResultsIsolateNotify);

    TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoringIsolate _end msgKind=$msgKind errMsg=$errMsg");
  }

  /// isolateの終了
  void _dispose() {
    // main からの 受信ポート を閉じる
    _receivePort.close();

    TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoringIsolate _dispose");
  }

  /// main からの通知を受け取る
  void _handleResponsesFromMain(dynamic message) {
    if (message is ConditionMonitoringNotify) {
      TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoringIsolate _handleResponsesFromMain [${message.type}]");
      try {
        switch (message.type) {
          case ConditionMonitoringNotifyType.abort:   // 中断
            _abort();
        }
      } catch (e, s) {
        // 不正な通知
        TprLog().logAdd(_tpraid, LogLevelDefine.error, "$e\n$s");
      }
    } else {
      // 不正な通知
      TprLog().logAdd(_tpraid, LogLevelDefine.error, "ConditionMonitoringIsolate _handleResponsesFromMain invalid notify [$message]");
    }
  }

  /// 中断処理
  void _abort() {
    _isAbort = true;
    TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoringIsolate _abort");
  }

}
