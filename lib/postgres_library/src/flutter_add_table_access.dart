/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'db_manipulation_ps.dart';
/*
このファイルでは以下のテーブルに対するアクセスクラスを記述する
Flutter環境への移行に伴い追加したテーブル
Add_1 多言語ラベル管理マスタ  languages_mstクラス
 */

//region c_ej_log_01  実績ジャーナルデータログ01
/// Add_1 多言語ラベル管理マスタ  languages_mstクラス
class LanguagesMstColumns extends TableColumns{
  String? multilingual_key;
  int? country_division;
  String? label_name;
  String? ins_datetime;
  String? upd_datetime;
  String? upd_user;

  @override
  String _getTableName() => "languages_mst";

  @override
  String? _getKeyCondition() => 'multilingual_key = ? AND country_division = ?';

  @override
  List _getKeyValue() {
    List rn = [];
    rn.add(multilingual_key);
    rn.add(country_division);
    return rn;
  }

  @override
  List<TableColumns> _toTableList(List<Map<String, dynamic>> maps) {
    return  List.generate(maps.length, (i) {
      LanguagesMstColumns rn = LanguagesMstColumns();
      rn.multilingual_key = maps[i]['multilingual_key'];
      rn.country_division = maps[i]['country_division'];
      rn.label_name = maps[i]['label_name'];
      rn.ins_datetime = maps[i]['ins_datetime'];
      rn.upd_datetime = maps[i]['upd_datetime'];
      rn.upd_user = maps[i]['upd_user'];
      return rn;
    });
  }

  @override
  TableColumns _toTable(List<Map<String, dynamic>> maps) {
    LanguagesMstColumns rn = LanguagesMstColumns();
    rn.multilingual_key = maps[0]['multilingual_key'];
    rn.country_division = maps[0]['country_division'];
    rn.label_name = maps[0]['label_name'];
    rn.ins_datetime = maps[0]['ins_datetime'];
    rn.upd_datetime = maps[0]['upd_datetime'];
    rn.upd_user = maps[0]['upd_user'];
    return rn;
  }

  /// DB用のMapに変換
  @override
  Map<String, dynamic> _toMap() {
    return {
      LanguagesMstField.multilingual_key : this.multilingual_key,
      LanguagesMstField.country_division : this.country_division,
      LanguagesMstField.label_name : this.label_name,
      LanguagesMstField.ins_datetime : this.ins_datetime,
      LanguagesMstField.upd_datetime : this.upd_datetime,
      LanguagesMstField.upd_user : this.upd_user,
    };
  }
}

/// Add_1 多言語ラベル管理マスタ  languages_mstのフィールド名設定用クラス
class LanguagesMstField {
  static const multilingual_key = "multilingual_key";
  static const country_division = "country_division";
  static const label_name = "label_name";
  static const ins_datetime = "ins_datetime";
  static const upd_datetime = "upd_datetime";
  static const upd_user = "upd_user";
}
//endregion