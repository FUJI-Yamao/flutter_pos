/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../../component/w_inputbox.dart';

///記録確認画面入力関連enum
/// 入力boxのラベル
enum EJconfInputFieldLabel {
  ///営業日
  businessDay('日付',InputBoxMode.calendar,EJconfInputFieldType.date),

  ///時間1
  timeZoneOne('時間',InputBoxMode.timeNumber,EJconfInputFieldType.time),

  ///時間2
  timeZoneTwo('時間',InputBoxMode.timeNumber,EJconfInputFieldType.time),

  ///レジ番号
  registerNum('レジ番号',InputBoxMode.defaultMode,EJconfInputFieldType.registerNum),

  ///レシート番号
  receiptNum('レシート番号',InputBoxMode.defaultMode,EJconfInputFieldType.receiptNum),

  ///キーワードを指定
  keyWord('キーワードを指定',InputBoxMode.defaultMode,EJconfInputFieldType.word);

  ///関連付けられた文字列
  final String labelText;

  ///関連付けられた入力ボックスモード
  final InputBoxMode mode;

  ///関連付けられた入力フィールドタイプ
  final EJconfInputFieldType EjconfieldType;

  ///コンストラクタ
  const EJconfInputFieldLabel(this.labelText,this.mode,this.EjconfieldType);
}

/// 入力boxのタイプ
enum EJconfInputFieldType {
  ///なし
  none,

  ///営業日.
  date,

  ///レジ番号
  registerNum,

  ///レシート番号
  receiptNum,

  ///時間
  time,

  ///キーワードを指定
  word,
}