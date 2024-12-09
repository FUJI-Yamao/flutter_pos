/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:isolate';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/sys/tpr_def.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import 'actual_results_isolate.dart';
import 'model/actual_results_isolate_notify.dart';
import 'model/actual_results_isolate_param.dart';
import 'model/actual_results_notify.dart';

/// 実績集計の処理（シングルトン）
class ActualResults {
  static final ActualResults _instance = ActualResults._internal();
  factory ActualResults() {
    return _instance;
  }
  ActualResults._internal();

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

  /// 実績集計のIsolateを起動
  Future<void> startIsolate() async {
    if (_isolate != null) {
      TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.error, "ActualResults executing");
      return;
    }

    try {
      TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults startIsolate start");

      // 受信ポートを作成
      _responses = ReceivePort();

      // Isolate からの通知を受け取る
      _responses?.listen(_handleResponsesFromIsolate);

      ActualResultsIsolateParam actualResultsIsolateParam = ActualResultsIsolateParam(
        sendPort: _responses!.sendPort,             // main への送信ポート
        logPort: TprLog().logPort!,                 // ログへの送信ポート
        environmentData: EnvironmentData(),         // EnvironmentDataクラス
        rxCommonBuf: SystemFunc.readRxCommonBuf(),  // 共有メモリ
      );
      _isolate = await Isolate.spawn(ActualResultsIsolate.main, actualResultsIsolateParam);

      TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults startIsolate end");
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.error, "ActualResults._startIsolate() error\n$e\n$s");
      _end(msgKind: DlgConfirmMsgKind.MSG_SYSERR);  // システムエラー
    }
  }

  /// Isolateに対して、中断のメッセージ を送る
  Future<void> sendAbort() async {
    // _commandsがnullの時にコールされたら、無視する
    if (_commands == null) return;

    await _isolateReady.future;
    ActualResultsNotify actualResultsNotify = ActualResultsNotify(
      type: ActualResultsNotifyType.abort,
    );
    _commands?.send(actualResultsNotify);

    Future.delayed(const Duration(seconds: TprDef.timeoutIsolateAbort), () {
      // _isolateAbort を完了状態にする
      if (!_isolateAbort.isCompleted) {
        _isolateAbort.complete();
        TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults timeout");
      }
    });

    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults sendAbort");

    return _isolateAbort.future;
  }

  /// Isolateに対して、停止のメッセージ を送る
  Future<void> sendStop() async {
    // _commandsがnullの時にコールされたら、無視する
    if (_commands == null) return;

    await _isolateReady.future;
    ActualResultsNotify actualResultsNotify = ActualResultsNotify(
      type: ActualResultsNotifyType.stop,
    );
    _commands?.send(actualResultsNotify);
    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults sendStop");
  }

  /// Isolateに対して、再開のメッセージ を送る
  Future<void> sendRestart() async {
    // _commandsがnullの時にコールされたら、無視する
    if (_commands == null) return;

    await _isolateReady.future;
    ActualResultsNotify actualResultsNotify = ActualResultsNotify(
      type: ActualResultsNotifyType.restart,
    );
    _commands?.send(actualResultsNotify);
    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults sendRestart");
  }

  /// デバドラ側で保持している共有メモリを更新させる。
  Future<void> sendUpdateShareMemory(SystemFuncPayload payload) async {
    // _commandsがnullの時にコールされたら、無視する
    if (_commands == null) return;

    await _isolateReady.future;
    ActualResultsNotify actualResultsNotify = ActualResultsNotify(
      type: ActualResultsNotifyType.updateShareMemory,
      object: payload,
    );
    _commands?.send(actualResultsNotify);
    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults sendUpdateShareMemory");
  }

  /// Isolate からの通知を受け取る
  void _handleResponsesFromIsolate(dynamic message) {
    if (message is ActualResultsIsolateNotify) {
      TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults _handleResponsesFromIsolate [${message.type}]");
      try {
        switch (message.type) {
          case ActualResultsIsolateNotifyType.init:   // 初期通知（SendPort交換）
            _init(message.object);
          case ActualResultsIsolateNotifyType.end:    // 処理終了通知
            ActualResultsIsolateNotifyForEnd isolateNotifyForEnd = message.object as ActualResultsIsolateNotifyForEnd;
            _end(msgKind: isolateNotifyForEnd.msgKind, errMsg: isolateNotifyForEnd.errMsg);
        }
      } catch (e, s) {
        // 不正な通知
        TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.error, "$e\n$s");
        _end(msgKind: DlgConfirmMsgKind.MSG_SYSERR);  // システムエラー
      }
    } else {
      // 不正な通知
      TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.error, "ActualResults _handleResponsesFromIsolate invalid notify [$message]");
      _end(msgKind: DlgConfirmMsgKind.MSG_SYSERR);  // システムエラー
    }
  }

  /// 初期通知（SendPort交換）
  void _init(SendPort sendPort) {
    _commands = sendPort;
    _isolateReady.complete();
    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults _init");
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

    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResults _end msgKind=$msgKind errMsg=$errMsg");
  }
}
