/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///検索踏力画面入力関連enum
/// 入力boxのラベル
enum RegistrationInputFieldLabel {

  ///レジ番号
  registerNum('レジ番号', InputFieldType.registerNum),

  ///レシート番号
  receiptNum('レシート番号', InputFieldType.receiptNum);

  ///関連付けられた文字列
  final String label;

  ///関連付けられた入力フィールドタイプ
  final InputFieldType fieldType;

  ///コンストラクタ
  const RegistrationInputFieldLabel(this.label, this.fieldType);
}

/// 入力boxのタイプ
enum InputFieldType {
  ///なし
  none,

  ///レジ番号
  registerNum,

  ///レシート番号
  receiptNum,

}

