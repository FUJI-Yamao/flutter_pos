/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../main.dart';
import '../../common/date_util.dart';
import '../../common/environment.dart';
import '../../if/if_drv_control.dart';
import '../../ui/enum/e_screen_kind.dart';
import 'tpr_type.dart';

export 'tpr_aid.dart';
// ログ出力時にimportするファイルが多いと大変なので、このファイル一つで済むようにexportしておく.
export 'tpr_log_define.dart';

/// 出力するログの情報クラス.
class LogData {
  TprMID tid;
  String contextStr;
  String addFileName;

  LogData(this.tid, this.contextStr, {this.addFileName = ""});
}

enum LogIsolateDefine {
  logDir, // ログIsolateからログ出力用Portを送る.
  log,
}

class LogIsolateData {
  LogIsolateDefine notifyType;
  dynamic option;
  LogIsolateData(this.notifyType, this.option);
}

/// ログ出力処理クラス
/// 関連tprxソース:TprLibLogWriteAdd
class TprLog {
  /// 出力するIsolate名
  String outputIsolateName = "";
  /// ログ出力待ちリスト.
  final List<LogData> _logWriteWaitList = <LogData>[];
  /// ログを出力するhomeディレクトリ.
  final String _tprLogFileDir = "log/";

  /// ログを送信するログIsolateのポート.
  SendPort? logPort;

  static final TprLog _instance = TprLog._internal();
  factory TprLog() {
    return _instance;
  }
  TprLog._internal();


  /// ログをIsolateへ送信して出力させる.
   void logAdd(TprMID tid, int level, String logStr,
      {int errId = 0, String addFileName = ""}) {
    // 書き込み内容.先頭に日付時間を付与する.
    DateTime now = DateTime.now();
    String micro = now.millisecond.toString().padLeft(3, '0') + now.microsecond.toString().padLeft(3, '0');
    String dateDetail = "${DateUtil.getString(now,DateUtil.formatForLogDetail)}.${micro.substring(0,5)}";
    String logContext =
        "${TprLogIsolate.getTidStr(tid)} $dateDetail logLevel=$level errId=$errId $logStr\n";
    if (outputIsolateName.isNotEmpty) {
      if(addFileName.isNotEmpty){
        addFileName+=".";
      }
      addFileName += outputIsolateName;
    }
    LogData data = LogData(tid, logContext, addFileName: addFileName);
    if (logPort == null) {
      // まだLogPortを受け取れてないのでlogIsolateに送れない.待機列に追加しておく.
      _logAddToWaitList(data);
    } else {
      // ログのIsolateに送る.
      logPort?.send(LogIsolateData(LogIsolateDefine.log, data));
    }
  }
  /// ログ出力用のディレクトリを取得する.
  /// main appから呼び出す.
  /// ※main以外のIsolateではgetApplicationDocumentsDirectoryが使えない.
  Future<String> getOutputDirectory() async {
    String path = TprxPlatform.getPlatformPath(join(EnvironmentData().env["TPRX_HOME"]!, _tprLogFileDir));
    return path;
  }
  /// logPortが定義される前に出力要求が来たログをIsolateに送る.
  void sendWaitListLog() {
    if (logPort == null) {
      return;
    }
    for (var data in _logWriteWaitList) {
      logPort!.send(LogIsolateData(LogIsolateDefine.log, data));
    }
    _logWriteWaitList.clear();
  }
  /// ログファイルに出力する為の待機リストに追加する関数.
  /// 非同期的にログ出力を行う.
  void _logAddToWaitList(LogData data) {
    _logWriteWaitList.add(data);
  }

  /// IsolateName設定処理
  void setIsolateName(String add, ScreenKind screenKind) {
    outputIsolateName = "${screenKind.commandParameterName}.$add";
  }
}
/// ログ出力を行うIsolate
/// ファイル出力によってmainスレッドがブロックされるのを防ぐため、別にIsolateを立てている.
class TprLogIsolate{
 /// 出力先ディレクトリ
  String _outputDir = "";

  /// ログ出力待ちリスト.
  final List<LogData> _logWriteWaitList = <LogData>[];
  /// デバッグ用にコンソールにも出力ログを表示する.
  final bool _isOutputDebugPrint = true;

/// ログ出力Isolate
  void logOutputIsolate(List<dynamic> args) {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    SendPort parentSendPort = args[0] as SendPort;
    _outputDir = args[1] as String;

    receivePort.listen((notify) {
      final notifyData = notify as LogIsolateData;
      switch (notifyData.notifyType) {
        case LogIsolateDefine.log:
          _logAddToWaitList(notifyData.option as LogData);
          break;
        default:
      }
    });
    parentSendPort
        .send(sendPort);
    // 出力ループ.
    _logWriteToFile();
  }

  /// LogIsolateに送られてきたログをファイルに出力する.
  Future<void> _logWriteToFile() async {
    while (true) {
      try {
        if (_outputDir.isEmpty || _logWriteWaitList.isEmpty) {
          await Future.delayed(const Duration(milliseconds: 10));
          continue;
        }
        LogData log = _logWriteWaitList.removeAt(0);
        String tidFolderName = getTidStr(log.tid);
        if (log.addFileName.isNotEmpty) {
          // ファイル名の追加指定有り.
          tidFolderName += ".${log.addFileName}";
        }

        String path = join(_outputDir, tidFolderName);

        final file = await File(path).create(recursive: true);
        await file.writeAsString(log.contextStr,
            mode: FileMode.writeOnlyAppend);
        if (_isOutputDebugPrint) {
          debugPrint("LogFile output ${log.addFileName}:${log.contextStr}");
        }
      } catch (e, s) {
        // ファイル入出力などでエラー. ファイルに出力できないのでdebugLogに出しておく.
        // Isolateが停止しないようにエラーは投げない.
        debugPrint("LogOutputError $s $e");
        await Future.delayed(const Duration(milliseconds: 10));
      }
    }
  }

  /// ログファイルに出力する為の待機リストに追加する関数.
  /// 非同期的にログ出力を行う.
  void _logAddToWaitList(LogData data) {
    _logWriteWaitList.add(data);
  }

  /// tidを16進数で8桁にした文字列を取得する.
  static String getTidStr(TprMID tid) {
    String tidFolderName = tid.toRadixString(16).padLeft(8, '0');
    return tidFolderName;
  }

}
