/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


/// スペックファイル. 入力種別定義.
enum SpecFileEditKind {
  /// 表示のみ
  none,

  /// 数字入力
  numInput,

  /// 分割ありの数字入力
  combinedNumInput,

  /// 16進数入力
  hexInput,

  /// 文字列入力
  stringInput,

  /// 選択リスト
  selection,

  /// ipアドレス入力
  ipAddressInput,

  /// プリセット色
  presetColor,

  /// プリセットグループコード
  presetGroupCode,

  /// PLUコード
  PLUCode,
}

/// スペックファイル.１行に表示する内容.
class SpecFileDispRow {

  /// Key
  final String key;

  /// 項目名
  final String title;

  /// 説明
  final String description;

  /// 入力種別
  final SpecFileEditKind editKind;

  /// dispKindに応じた設定内容
  final dynamic setting;

  /// 表示条件.定義なしで常に表示.
  /// trueで表示可能
  final Function? displayableFunc;

  /// 設定条件.定義なしで常に設定可能
  /// (bool configurable,String reason)を返す
  /// configurableがtrueで編集可能.
  final Function? configurableFunc;


  /// コンストラクタ
  const SpecFileDispRow({
    String? key,
    required this.title,
    required this.description,
    required this.editKind,
    required this.setting,
    this.displayableFunc,
    this.configurableFunc,
  }) : key = key ?? '';  // keyが指定されていない時は、空文字を設定する
}

///　数字入力設定クラス.
class NumInputSetting {
  /// 最小値.
  final int minValue;
  /// 最大値.
  final int maxValue;
  const NumInputSetting(this.minValue, this.maxValue);
}
///　文字列入力設定クラス.
class StringInputSetting {
  /// 最小文字数.
  final int digitFrom;
  /// 最大文字数.
  final int digitTo;

  const StringInputSetting(this.digitFrom, this.digitTo);
}

/// 選択画面の選択肢.
class SelectionSetting {
  /// 表示する値
  final String dispValue;
  /// 設定ファイルに保存する値.
  final dynamic settingValue;
  /// 選択肢の表示条件.
  /// trueもしくは関数を定義しない場合は表示される
  final Function? displayableFunc;

  const SelectionSetting(this.dispValue, this.settingValue,
      {this.displayableFunc});
}

///　IPアドレス入力設定クラス.
class IpAddressInputSetting {
  /// 最小値.
  final List<int> minValue;
  /// 最大値.
  final List<int> maxValue;
  const IpAddressInputSetting({this.minValue = const [0,0,0,0],this.maxValue = const [255,255,255,255]});
}

// 設定値
class SettingData {

  // 変更前
  final dynamic before;
  // 変更後
  dynamic after;

  /// コンストラクタ
  SettingData({
    required this.before,
    required this.after,
  });
}