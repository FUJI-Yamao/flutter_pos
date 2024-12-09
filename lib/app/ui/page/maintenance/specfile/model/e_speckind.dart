/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// スペックファイルの種類
enum SpecKind {
  /// 無効値.
  none,
  /// マシン環境.
  machine,
  /// ネットワーク.
  network,
  /// 動作環境
  operating,
  /// カウンター 
  counter,
  /// 周辺装置
  peripheralDevice,
  /// 承認キー.
  recogkey,
  /// SIO.
  sio,
  /// ACB
  acb,
  /// ECS
  ecs,

  /// Speeza設定
  speeza,
  /// QCashier設定（共通部）
  qCashierCommon,
  /// QCashier設定（動作関連）
  qCashierOperation,
  /// Shop&Go設定
  shopAndGo;
}
