/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../inc/sys/tpr_dlg.dart';

/// 状態監視のIsolateからmainへの通知の種類
enum ConditionMonitoringIsolateNotifyType {
  init,         // 初期通知（SendPort交換）
  end,          // 処理終了通知
}

/// 状態監視のIsolateからmainへの通知
class ConditionMonitoringIsolateNotify {
  ConditionMonitoringIsolateNotify({
    required this.type,
    this.object,
  });

  final ConditionMonitoringIsolateNotifyType type;
  final dynamic object;
}

/// 状態監視のIsolateからmainへの終了通知の詳細
class ConditionMonitoringIsolateNotifyForEnd {
  ConditionMonitoringIsolateNotifyForEnd({
    this.msgKind,
    this.errMsg,
  });

  /// アプリケーションID定義
  final DlgConfirmMsgKind? msgKind;
  /// クラウドPOSのエラーメッセージ
  final String? errMsg;
}
