/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'dart:ui';

import '../../../common/environment.dart';
import '../../../inc/apl/rxmem_define.dart';

/// 実績集計の処理クラス（Isolate）へのパラメータ
class ActualResultsIsolateParam {
  ActualResultsIsolateParam({
    required this.sendPort,
    required this.logPort,
    required this.environmentData,
    required this.rxCommonBuf,
  }) : rootIsolateToken = RootIsolateToken.instance!;

  /// アイソレートに渡すルート アイソレートのトークン
  final RootIsolateToken rootIsolateToken;
  /// main への送信ポート
  final SendPort sendPort;
  /// ログへの送信ポート
  final SendPort logPort;
  /// EnvironmentDataクラス
  EnvironmentData environmentData;
  /// 共有メモリ
  RxCommonBuf rxCommonBuf;
}
