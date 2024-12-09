/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'fjssJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class FjssJsonFile extends ConfigJsonFile {
  static final FjssJsonFile _instance = FjssJsonFile._internal();

  final String _confPath = "conf/";
  final JsonLanguage _confLang = JsonLanguage.aa;
  final String _fileName = "fjss.json";

  FjssJsonFile(){
    setPath(_confPath, _fileName, _confLang);
  }
  FjssJsonFile._internal();

  factory FjssJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$FjssJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$FjssJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$FjssJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        fjss_system = _$Fjss_systemFromJson(jsonD['fjss_system']);
      } catch(e) {
        fjss_system = _$Fjss_systemFromJson({});
        ret = false;
      }
      try {
        csv_dly = _$Csv_dlyFromJson(jsonD['csv_dly']);
      } catch(e) {
        csv_dly = _$Csv_dlyFromJson({});
        ret = false;
      }
      try {
        max_item = _$Max_itemFromJson(jsonD['max_item']);
      } catch(e) {
        max_item = _$Max_itemFromJson({});
        ret = false;
      }
      try {
        page = _$PageFromJson(jsonD['page']);
      } catch(e) {
        page = _$PageFromJson({});
        ret = false;
      }
      try {
        item0 = _$Item0FromJson(jsonD['item0']);
      } catch(e) {
        item0 = _$Item0FromJson({});
        ret = false;
      }
      try {
        item1 = _$Item1FromJson(jsonD['item1']);
      } catch(e) {
        item1 = _$Item1FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Fjss_system fjss_system = _Fjss_system(
    send_start                         : 0,
    sendcnt                            : 0,
    senditemcnt                        : 0,
  );

  _Csv_dly csv_dly = _Csv_dly(
    dly_clothes                        : 0,
    dlyclothes_week                    : 0,
    dlyclothes_day                     : 0,
  );

  _Max_item max_item = _Max_item(
    total_item                         : 0,
  );

  _Page page = _Page(
    total_page                         : 0,
    onoff0                             : 0,
  );

  _Item0 item0 = _Item0(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item1 item1 = _Item1(
    onoff                              : 0,
    page                               : 0,
    position                           : 0,
    table1                             : "",
    total                              : 0,
    t_exe1                             : "",
    section                            : "",
    keyword                            : "",
    keyword2                           : "",
    backup_day                         : "",
    select_dsp                         : 0,
  );
}

@JsonSerializable()
class _Fjss_system {
  factory _Fjss_system.fromJson(Map<String, dynamic> json) => _$Fjss_systemFromJson(json);
  Map<String, dynamic> toJson() => _$Fjss_systemToJson(this);

  _Fjss_system({
    required this.send_start,
    required this.sendcnt,
    required this.senditemcnt,
  });

  @JsonKey(defaultValue: 0)
  int    send_start;
  @JsonKey(defaultValue: 0)
  int    sendcnt;
  @JsonKey(defaultValue: 0)
  int    senditemcnt;
}

@JsonSerializable()
class _Csv_dly {
  factory _Csv_dly.fromJson(Map<String, dynamic> json) => _$Csv_dlyFromJson(json);
  Map<String, dynamic> toJson() => _$Csv_dlyToJson(this);

  _Csv_dly({
    required this.dly_clothes,
    required this.dlyclothes_week,
    required this.dlyclothes_day,
  });

  @JsonKey(defaultValue: 1)
  int    dly_clothes;
  @JsonKey(defaultValue: 0)
  int    dlyclothes_week;
  @JsonKey(defaultValue: 1)
  int    dlyclothes_day;
}

@JsonSerializable()
class _Max_item {
  factory _Max_item.fromJson(Map<String, dynamic> json) => _$Max_itemFromJson(json);
  Map<String, dynamic> toJson() => _$Max_itemToJson(this);

  _Max_item({
    required this.total_item,
  });

  @JsonKey(defaultValue: 2)
  int    total_item;
}

@JsonSerializable()
class _Page {
  factory _Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
  Map<String, dynamic> toJson() => _$PageToJson(this);

  _Page({
    required this.total_page,
    required this.onoff0,
  });

  @JsonKey(defaultValue: 1)
  int    total_page;
  @JsonKey(defaultValue: 0)
  int    onoff0;
}

@JsonSerializable()
class _Item0 {
  factory _Item0.fromJson(Map<String, dynamic> json) => _$Item0FromJson(json);
  Map<String, dynamic> toJson() => _$Item0ToJson(this);

  _Item0({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 1)
  int    position;
  @JsonKey(defaultValue: "衣料商品")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "KEDI")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_clothes")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item1 {
  factory _Item1.fromJson(Map<String, dynamic> json) => _$Item1FromJson(json);
  Map<String, dynamic> toJson() => _$Item1ToJson(this);

  _Item1({
    required this.onoff,
    required this.page,
    required this.position,
    required this.table1,
    required this.total,
    required this.t_exe1,
    required this.section,
    required this.keyword,
    required this.keyword2,
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 13)
  int    position;
  @JsonKey(defaultValue: "電子ｼﾞｬｰﾅﾙ累計")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "c_ejlog")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_ejlog_manual")
  String keyword;
  @JsonKey(defaultValue: "dlyejlog_week")
  String keyword2;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

