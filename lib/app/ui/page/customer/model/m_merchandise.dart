/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'm_discount.dart';

/// 商品データ
class MerchandiseData {
  /// 商品名称
  String name;
  /// 商品単価
  int price;
  /// 値引き
  List<ModelDiscountData> discountList;
  /// 登録点数
  int qty;
  /// 0:通常　1:取消　2:カゴ抜け 3:期限切れ
  int type;

  MerchandiseData({
    required this.name,
    required this.price,
    required this.discountList,
    required this.qty,
    required this.type,
  });
}
