/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 二人制状態
enum DualStatus {
  none,
  sendRequest,
  replyRequest,
  dual,
  sendEndRequest,
  replyEndRequest,
  sendCancel,
  replyCancel;

  const DualStatus();
}
