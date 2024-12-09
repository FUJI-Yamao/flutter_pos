/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 画面種別
enum ScreenKind {
  register('register'),         // 登録機
  register2('register2'),       // タワー
  customer('customer'),         // XGA客表
  customer_7_1('customer_7_1'), // 7inch客表（タワー型の登録機側）
  customer_7_2('customer_7_2'); // 7inch客表（タワー型の精算機側）

  const ScreenKind(this.commandParameterName);

  /// 起動パラメータで指定される文字列
  final String commandParameterName;
}
