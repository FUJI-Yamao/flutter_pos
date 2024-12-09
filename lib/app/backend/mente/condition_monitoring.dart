/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:isolate';

import '../../common/environment.dart';
import '../../inc/sys/tpr_def.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import 'condition_monitoring_isolate.dart';
import 'model/condition_monitoring_isolate_notify.dart';
import 'model/condition_monitoring_isolate_param.dart';
import 'model/condition_monitoring_notify.dart';


/// 状態監視の処理（シングルトン）
class ConditionMonitoring {
  static final ConditionMonitoring _instance = ConditionMonitoring._internal();
  factory ConditionMonitoring() {
    return _instance;
  }
  ConditionMonitoring._internal();

  /// Tpraid
  final int _tpraid = Tpraid.TPRAID_NONE;

  /// Isolate への 送信ポート
  SendPort? _commands;
  /// Isolate からの 受信ポート
  ReceivePort? _responses;

  /// Isolate の起動確認
  final Completer<void> _isolateReady = Completer.sync();
  /// Isolate の終了確認
  final Completer<void> _isolateAbort = Completer.sync();
  /// Isolate のインスタンス
  Isolate? _isolate;

  /// 状態監視のIsolateを起動
  Future<void> startIsolate() async {
    if (_isolate != null) {
      TprLog().logAdd(_tpraid, LogLevelDefine.error, "ConditionMonitoring executing");
      return;
    }

    try {
      TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoring startIsolate start");

      // 受信ポートを作成
      _responses = ReceivePort();

      // Isolate からの通知を受け取る
      _responses?.listen(_handleResponsesFromIsolate);

      ConditionMonitoringIsolateParam actualResultsIsolateParam = ConditionMonitoringIsolateParam(
        sendPort: _responses!.sendPort,             // main への送信ポート
        logPort: TprLog().logPort!,                 // ログへの送信ポート
        environmentData: EnvironmentData(),         // EnvironmentDataクラス
      );
      _isolate = await Isolate.spawn(ConditionMonitoringIsolate.main, actualResultsIsolateParam);

      TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoring startIsolate end");
    } catch (e, s) {
      TprLog().logAdd(_tpraid, LogLevelDefine.error, "ConditionMonitoring._startIsolate() error\n$e\n$s");
      _end(msgKind: DlgConfirmMsgKind.MSG_SYSERR);  // システムエラー
    }
  }

  /// Isolateに対して、中断のメッセージ を送る
  Future<void> sendAbort() async {
    // _commandsがnullの時にコールされたら、無視する
    if (_commands == null) return;

    await _isolateReady.future;
    ConditionMonitoringNotify actualResultsNotify = ConditionMonitoringNotify(
      type: ConditionMonitoringNotifyType.abort,
    );
    _commands?.send(actualResultsNotify);

    Future.delayed(const Duration(seconds: TprDef.timeoutIsolateAbort), () {
      // _isolateAbort を完了状態にする
      if (!_isolateAbort.isCompleted) {
        _isolateAbort.complete();
        TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoring timeout");
      }
    });

    TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoring sendAbort");
  }

  /// Isolate からの通知を受け取る
  void _handleResponsesFromIsolate(dynamic message) {
    if (message is ConditionMonitoringIsolateNotify) {
      TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoring _handleResponsesFromIsolate [${message.type}]");
      try {
        switch (message.type) {
          case ConditionMonitoringIsolateNotifyType.init:   // 初期通知（SendPort交換）
            _init(message.object);
          case ConditionMonitoringIsolateNotifyType.end:    // 処理終了通知
            ConditionMonitoringIsolateNotifyForEnd isolateNotifyForEnd = message.object as ConditionMonitoringIsolateNotifyForEnd;
            _end(msgKind: isolateNotifyForEnd.msgKind, errMsg: isolateNotifyForEnd.errMsg);
        }
      } catch (e, s) {
        // 不正な通知
        TprLog().logAdd(_tpraid, LogLevelDefine.error, "$e\n$s");
        _end(msgKind: DlgConfirmMsgKind.MSG_SYSERR);  // システムエラー
      }
    } else {
      // 不正な通知
      TprLog().logAdd(_tpraid, LogLevelDefine.error, "ConditionMonitoring _handleResponsesFromIsolate invalid notify [$message]");
      _end(msgKind: DlgConfirmMsgKind.MSG_SYSERR);  // システムエラー
    }
  }

  /// 初期通知（SendPort交換）
  void _init(SendPort sendPort) {
    _commands = sendPort;
    _isolateReady.complete();
    TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoring _init");
  }

  /// 処理終了通知
  Future<void> _end({
    DlgConfirmMsgKind? msgKind,
    String? errMsg,
  }) async {
    // isolateの終了
    _isolate?.kill();
    _isolate = null;

    // Isolate からの 受信ポートを閉じる
    _responses?.close();
    _responses = null;

    // Isolate への 送信ポート を初期化
    _commands = null;

    // _isolateAbort を完了状態にする
    if (!_isolateAbort.isCompleted) {
      _isolateAbort.complete();
    }

    TprLog().logAdd(_tpraid, LogLevelDefine.normal, "ConditionMonitoring _end msgKind=$msgKind errMsg=$errMsg");
  }
}
