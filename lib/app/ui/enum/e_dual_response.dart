/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 2人制応答結果
enum DualResponse {
  success,        // 正常終了
  changeFailed,   // 2人制切り替え失敗
  requestFailed;  // リクエストのパラメータ不正などで受け付け失敗

  const DualResponse();
}
