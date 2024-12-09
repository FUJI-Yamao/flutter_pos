/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../component/w_inputbox.dart';

///記録確認画面入力関連enum
/// 入力boxのラベル
enum OpenCloseInputFieldLabel {

  ///従業員コード
  codeNum('従業員コード',InputBoxMode.defaultMode,OpenCloseInputFieldType.codeNumber),

  ///パスワード
  password('パスワード',InputBoxMode.defaultMode,OpenCloseInputFieldType.passwordNumber);



  ///関連付けられた文字列
  final String labelText;

  ///関連付けられた入力ボックスモード
  final InputBoxMode mode;

  ///関連付けられた入力フィールドタイプ
  final OpenCloseInputFieldType OpenCloseieldType;

  ///コンストラクタ
  const OpenCloseInputFieldLabel(this.labelText,this.mode,this.OpenCloseieldType);
}

/// 入力boxのタイプ
enum OpenCloseInputFieldType {


  ///従業員コード
  codeNumber,

  ///パスワード
  passwordNumber,

}