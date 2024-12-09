/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../component/w_inputbox.dart';

///記録確認画面入力関連enum
/// 入力boxのラベル
enum PurchaseDetailModifyLabel {

  ///数量
  quantity('数量',InputBoxMode.defaultMode,PurchaseDetailModifyInputFieldType.quantity),

  ///単価
  price('単価',InputBoxMode.defaultMode,PurchaseDetailModifyInputFieldType.price),

  ///単価（金額）
  money('単価（金額）',InputBoxMode.defaultMode,PurchaseDetailModifyInputFieldType.money),

  ///売値変更
  modification('売値変更',InputBoxMode.defaultMode,PurchaseDetailModifyInputFieldType.modification),

  ///引
  discount('引',InputBoxMode.defaultMode,PurchaseDetailModifyInputFieldType.discount),

  ///ポイント倍率
  point('ポイント倍率',InputBoxMode.defaultMode,PurchaseDetailModifyInputFieldType.point),

  ///倍
  magnification('倍',InputBoxMode.defaultMode,PurchaseDetailModifyInputFieldType.magnification),

  ///商品名
  name('商品名',InputBoxMode.defaultMode,PurchaseDetailModifyInputFieldType.name);

  ///関連付けられた文字列
  final String labelText;

  ///関連付けられた入力ボックスモード
  final InputBoxMode mode;

  ///関連付けられた入力フィールドタイプ
  final PurchaseDetailModifyInputFieldType purchaseDetailModifyFieldType;

  ///コンストラクタ
  const PurchaseDetailModifyLabel(
      this.labelText,
      this.mode,
      this.purchaseDetailModifyFieldType
  );
}

/// 入力boxのタイプ
enum PurchaseDetailModifyInputFieldType {
  ///なし
  none,

  ///数量
  quantity,

  ///単価
  price,

  ///単価（金額）
  money,

  ///売値変更
  modification,

  ///引
  discount,

  ///ポイント倍率
  point,

  ///倍
  magnification,

  ///商品名
  name,
}

/// 値引・割引のキーオプションボタン種別
enum DscPdscKeyOptionButtonType {
  // 値引・割引キーオプション１
  keyOptionButton1,
  // 値引・割引キーオプション２
  keyOptionButton2,
  // 値引・割引キーオプション３
  keyOptionButton3,
  // 値引・割引キーオプション４
  keyOptionButton4,
  // 値引・割引キーオプション５
  keyOptionButton5,
}