/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

/// クレジット取引の支払方法
class CreditPaymentMethod {
  /// 支払方法の種別(支払方法を判別するユニークな値)
  int paymentType = 0;

  /// 支払方法の表示名
  String paymentMethodName = '';

  /// 支払方法の詳細１の見出し
  String paymentDetailTopic1 = '';

  /// 支払方法の詳細１の内容
  String paymentDetailContent1 = '';

  /// 支払方法の詳細２の見出し
  String paymentDetailTopic2 = '';

  /// 支払方法の詳細２の内容
  String paymentDetailContent2 = '';

  /// 支払方法選択時の処理の引数
  int orgCode = 0;

  /// コンストラクタ
  CreditPaymentMethod({
    required this.paymentMethodName,
    required this.paymentType,
    this.paymentDetailTopic1 = '',
    this.paymentDetailContent1 = '',
    this.paymentDetailTopic2 = '',
    this.paymentDetailContent2 = '',
    this.orgCode = 0,
  });
}
