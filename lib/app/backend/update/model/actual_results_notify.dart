/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 実績集計のmainからIsolateへの通知の種類
enum ActualResultsNotifyType {
  abort,              // 中断
  stop,               // 停止
  restart,            // 再開
  updateShareMemory,  // 共有メモリ更新
}

/// 実績集計のmainからIsolateへの通知
class ActualResultsNotify {
  ActualResultsNotify({
    required this.type,
    this.object,
  });

  final ActualResultsNotifyType type;
  final dynamic object;
}