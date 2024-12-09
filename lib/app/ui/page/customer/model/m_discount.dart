/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 値下データ
class ModelDiscountData {
  /// 1:特売 2:MM 3:SM 4:分類一括 5:値引   6:割引  7:売価変更値引 8:会員 など
  int discountType;
  /// 施策名称 固定の名称1:特売 2:まとめ値引 3:セット値引 4:値下5:値引 6:割引 7:売変 8:会員
  String discountName;
  /// 値下金額
  int discountPrice;

  ModelDiscountData({
    required this.discountType,
    required this.discountName,
    required this.discountPrice,
  });
}