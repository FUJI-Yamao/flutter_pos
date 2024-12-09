/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'dart:ui';

import '../../../common/environment.dart';

/// 状態監視の処理クラス（Isolate）へのパラメータ
class ConditionMonitoringIsolateParam {
  ConditionMonitoringIsolateParam({
    required this.sendPort,
    required this.logPort,
    required this.environmentData,
  }) : rootIsolateToken = RootIsolateToken.instance!;

  /// アイソレートに渡すルート アイソレートのトークン
  final RootIsolateToken rootIsolateToken;
  /// main への送信ポート
  final SendPort sendPort;
  /// ログへの送信ポート
  final SendPort logPort;
  /// EnvironmentDataクラス
  EnvironmentData environmentData;
}
