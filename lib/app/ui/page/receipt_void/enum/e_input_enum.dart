/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../component/w_inputbox.dart';

///通番訂正画面入力関連enum

/// 入力boxのラベル
enum ReceiptVoidInputFieldLabel {
  ///営業日
  businessDay('営業日', InputBoxMode.calendar, InputFieldType.date),

  ///レジ番号
  registerNum('レジ番号', InputBoxMode.defaultMode, InputFieldType.registerNum),

  ///レシート番号
  receiptNum('レシート番号', InputBoxMode.defaultMode, InputFieldType.receiptNum),

  ///合計金額
  totalAmount('合計金額', InputBoxMode.formatNumber, InputFieldType.amount),

  ///伝票番号
  slipNum('伝票番号', InputBoxMode.defaultMode, InputFieldType.slipNum),

  ///カード番号
  cardNum('カード番号', InputBoxMode.defaultMode, InputFieldType.cardNum);

  ///関連付けられた文字列
  final String label;

  ///関連付けられた入力ボックスモード
  final InputBoxMode mode;

  ///関連付けられた入力フィールドタイプ
  final InputFieldType fieldType;

  ///コンストラクタ
  const ReceiptVoidInputFieldLabel(this.label, this.mode, this.fieldType);
}

/// 入力boxのタイプ
enum InputFieldType {
  ///なし
  none,

  ///営業日.
  date,

  ///レジ番号
  registerNum,

  ///レシート番号
  receiptNum,

  ///合計金額.
  amount,

  ///伝票番号.
  slipNum,

  ///カード番号.
  cardNum,
}

/// 支払方法
enum PaymentType {
  /// 現金
  cash,

  ///　クイックペイ
  quicPay,

  ///　ハウスクレジット
  creditCard,
}
