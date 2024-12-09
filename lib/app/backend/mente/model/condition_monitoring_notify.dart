/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 状態監視のmainからIsolateへの通知の種類
enum ConditionMonitoringNotifyType {
  abort,              // 中断
}

/// 状態監視のmainからIsolateへの通知
class ConditionMonitoringNotify {
  ConditionMonitoringNotify({
    required this.type,
    this.object,
  });

  final ConditionMonitoringNotifyType type;
  final dynamic object;
}