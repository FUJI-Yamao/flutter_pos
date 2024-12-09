/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 価格種別
enum PriceType {
  nowPrice,           // 適用売価
  price,              // 一般通常売価
  bargainPrice,       // 一般特売売価
  bargainMemberPrice, // 会員特売売価
}
/// 価格確認データ
class PriceCheckData {
  static const nowPriceItemName = '適用売価';
  static const priceItemName = '一般通常売価';
  static const bargainPriceItemName = '一般特売売価';
  static const bargainMemberPriceItemName = '会員特売売価';

  /// 価格種別
  PriceType priceType = PriceType.nowPrice;
  /// 価格種別名
  String priceTypeName = '';
  /// 価格
  int price = 0;
  /// 分類値下げ表示名
  String discountName = '';
  /// 分類値下げ額
  int discountPrice = 0;

  PriceCheckData({
    required this.priceType,
    required this.price,
  }) {
    List<String> typeName = <String>[nowPriceItemName, priceItemName, bargainPriceItemName, bargainMemberPriceItemName];
    priceTypeName = typeName[priceType.index];
  }

  /// 分類値下げ額を設定する
  void setDiscountValue(String discountName, int discountPrice) {
    if (priceType != PriceType.nowPrice) {
      return;
    }

    this.discountName = discountName;
    this.discountPrice = discountPrice;
  }
}