/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

/// 分割払いの支払回数
class CreditInstallmentNumber {
  /// 分割回数
  int installmentNumber = 0;
  /// 分割回数の支払区分
  int installmentPaymentCode = 0;

  /// コンストラクタ
  CreditInstallmentNumber({
    required this.installmentNumber,
    required this.installmentPaymentCode,
  });
}
