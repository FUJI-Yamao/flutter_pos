/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../regs/checker/rc_clxos.dart';
import 'model/actual_results_isolate_notify.dart';
import 'model/actual_results_isolate_param.dart';
import 'model/actual_results_notify.dart';

/// 実績集計の処理クラス（Isolate）
class ActualResultsIsolate {
  /// コンストラクタ
  ActualResultsIsolate(ActualResultsIsolateParam actualResultsIsolateParam)
      : _sendPort = actualResultsIsolateParam.sendPort {
    // ログ設定.
    TprLog().setIsolateName("ActualResults", actualResultsIsolateParam.environmentData.screenKind);
    TprLog().logPort = actualResultsIsolateParam.logPort;
    TprLog().sendWaitListLog();

    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate start");

    // main からの通知を受け取る
    _receivePort.listen(_handleResponsesFromMain);

    // mainに初期通知（SendPort交換）
    _init();
  }

  /// main への 送信ポート
  final SendPort _sendPort;
  // main からの 受信ポート
  final _receivePort = ReceivePort();

  /// 中断フラグ
  bool _isAbort = false;
  /// 停止フラグ
  bool _isStop = false;

  /// 企業コード
  late int _compCd;
  /// 店舗コード
  late int _streCd;

  /// Isolateのmain関数
  static Future<void> main(ActualResultsIsolateParam actualResultsIsolateParam) async {
    // アイソレートをルート アイソレートに登録します。
    // https://medium.com/flutter/introducing-background-isolate-channels-7a299609cad8
    BackgroundIsolateBinaryMessenger.ensureInitialized(actualResultsIsolateParam.rootIsolateToken);

    // インスタンス生成
    ActualResultsIsolate actualResultsIsolate = ActualResultsIsolate(actualResultsIsolateParam);

    // 使用する共有メモリをセットアップする
    await actualResultsIsolate.setupShareMemory(actualResultsIsolateParam.rxCommonBuf);

    // 実績集計の処理の処理開始
    await actualResultsIsolate._start();

    /// 実績集計の処理の処理終了
    actualResultsIsolate._end(msgKind: actualResultsIsolate._isAbort ? DlgConfirmMsgKind.MSG_STOP : DlgConfirmMsgKind.MSG_COMPLETE);

    // isolateの終了
    actualResultsIsolate._dispose();
  }

  /// 実績集計の処理の処理開始
  Future<void> _start() async {

    // 実績集計の処理
    while (true) {
      if (_isAbort) {
        // 中断
        break;
      }

      if (_isStop) {
        // 停止中は、5秒待機
        await Future.delayed(const Duration(seconds: 5));
        continue;
      }

      // クラウドPOSの呼出し
      CalcResultActualResults result;
      try {
        if (!RcClxosCommon.validClxos) {
          result = CalcResultActualResults(retSts: 0, errMsg: "", posErrCd: 0, count: 0, remain: 0);
          String tempRetData = '''{"RetSts":0,"ErrMsg":"","PosErrCd":0,"Count":0,"Remain":0}''';
          result = CalcResultActualResults.fromJson(jsonDecode(tempRetData));
        } else {
          result = await CalcApi.actualResult(Tpraid.TPRAID_ACTUAL_RESULTS, _compCd, _streCd);
        }
      } catch (e, s) {
        // システムエラー
        TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.error, "ActualResultsIsolate CalcApi.actualResult error\n$e\n$s");
        // エラー時は、5秒待機
        await Future.delayed(const Duration(seconds: 5));
        continue;
      }

      // クラウドPOSのレスポンスを見て、スリープの時間を変える
      if (result.retSts == 0 && result.count != null) {
        // 正常時
        if (result.count! < 10) {
          // 未集計データがなさそうなので、10秒待機
          await Future.delayed(const Duration(seconds: 10));
        } else {
          // 未集計データがありそうなので、1秒待機
          await Future.delayed(const Duration(seconds: 1));
        }
      } else {
        // レスポンスエラー
        TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.error, "ActualResultsIsolate result error result.retSts=${result.retSts}");
        // エラー時は、5秒待機
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  /// 使用する共有メモリをセットアップする
  Future<void> setupShareMemory(RxCommonBuf rxCommonBuf) async {
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_COMMON);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, rxCommonBuf, RxMemAttn.MASTER);

    // 企業コードと店舗コードの取得（更新）
    _getCompCdAndStreCd();
  }


  /// mainに初期通知（SendPort交換）
  void _init() {
    ActualResultsIsolateNotify actualResultsIsolateNotify = ActualResultsIsolateNotify(
      type: ActualResultsIsolateNotifyType.init,
      object: _receivePort.sendPort,
    );
    _sendPort.send(actualResultsIsolateNotify);

    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate _init");
  }

  /// 実績集計の処理の処理終了
  /// パラメータの両方がnullの場合は、正常終了として扱う
  void _end({
    DlgConfirmMsgKind? msgKind,
    String? errMsg,
  }) {
    ActualResultsIsolateNotifyForEnd isolateNotifyForEnd = ActualResultsIsolateNotifyForEnd(
      msgKind: msgKind,
      errMsg: errMsg,
    );

    ActualResultsIsolateNotify actualResultsIsolateNotify = ActualResultsIsolateNotify(
      type: ActualResultsIsolateNotifyType.end,
      object: isolateNotifyForEnd,
    );

    // main Isolateに対して、処理完了のメッセージを送る
    _sendPort.send(actualResultsIsolateNotify);

    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate _end msgKind=$msgKind errMsg=$errMsg");
  }

  /// isolateの終了
  void _dispose() {
    // main からの 受信ポート を閉じる
    _receivePort.close();

    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate _dispose");
  }

  /// main からの通知を受け取る
  void _handleResponsesFromMain(dynamic message) {
    if (message is ActualResultsNotify) {
      TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate _handleResponsesFromMain [${message.type}]");
      try {
        switch (message.type) {
          case ActualResultsNotifyType.abort:   // 中断
            _abort();
          case ActualResultsNotifyType.stop:    // 停止
            _stop();
          case ActualResultsNotifyType.restart: // 再開
            _restart();
          case ActualResultsNotifyType.updateShareMemory: // 共有メモリ更新
            _updateShareMemory(message.object);
        }
      } catch (e, s) {
        // 不正な通知
        TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.error, "$e\n$s");
      }
    } else {
      // 不正な通知
      TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.error, "ActualResultsIsolate _handleResponsesFromMain invalid notify [$message]");
    }
  }

  /// 中断処理
  void _abort() {
    _isAbort = true;
    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate _abort");
  }

  /// 停止処理
  void _stop() {
    _isStop = true;
    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate _stop");
  }

  /// 再開処理
  void _restart() {
    _isStop = false;
    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate _restart");
  }

  /// 共有メモリ更新
  void _updateShareMemory(SystemFuncPayload payload) {
    SystemFunc.rxMemWrite(_sendPort, payload.index, payload.buf, RxMemAttn.SLAVE, "ActualResults");
    TprLog().logAdd(Tpraid.TPRAID_ACTUAL_RESULTS, LogLevelDefine.normal, "ActualResultsIsolate _updateShareMemory");

    // 企業コードと店舗コードの取得（更新）
    _getCompCdAndStreCd();
  }

  /// 企業コードと店舗コードの取得（更新）
  void _getCompCdAndStreCd() {
    RxCommonBuf rxCommonBuf = SystemFunc.readRxCommonBuf();
    _compCd = rxCommonBuf.iniMacInfoCrpNoNo;  // 企業番号
    _streCd = rxCommonBuf.iniMacInfoShopNo;   // 店舗番号
  }
}
