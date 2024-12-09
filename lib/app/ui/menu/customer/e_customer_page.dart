/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// お客様画面
enum CustomerPage {
  logo('/logo'),            // ロゴ
  register('/register'),    // 客表（登録）
  payment('/payment');      // 客表（小計）

  const CustomerPage(this.routeName);

  /// ルーティング名称
  final String routeName;
}
