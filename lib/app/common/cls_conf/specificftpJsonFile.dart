/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'specificftpJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class SpecificftpJsonFile extends ConfigJsonFile {
  static final SpecificftpJsonFile _instance = SpecificftpJsonFile._internal();

  final String _confPath = "conf/";
  final JsonLanguage _confLang = JsonLanguage.aa;
  final String _fileName = "specificftp.json";

  SpecificftpJsonFile(){
    setPath(_confPath, _fileName, _confLang);
  }
  SpecificftpJsonFile._internal();

  factory SpecificftpJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$SpecificftpJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$SpecificftpJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$SpecificftpJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        ja_system = _$Ja_systemFromJson(jsonD['ja_system']);
      } catch(e) {
        ja_system = _$Ja_systemFromJson({});
        ret = false;
      }
      try {
        producer = _$ProducerFromJson(jsonD['producer']);
      } catch(e) {
        producer = _$ProducerFromJson({});
        ret = false;
      }
      try {
        items = _$ItemsFromJson(jsonD['items']);
      } catch(e) {
        items = _$ItemsFromJson({});
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
      try {
        item2 = _$Item2FromJson(jsonD['item2']);
      } catch(e) {
        item2 = _$Item2FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Ja_system ja_system = _Ja_system(
    jano                               : 0,
    clientno                           : 0,
    sendcnt                            : 0,
    senditemcnt                        : 0,
  );

  _Producer producer = _Producer(
    cdlen                              : 0,
    startcd                            : 0,
    endcd                              : 0,
    endcd2                             : 0,
  );

  _Items items = _Items(
    startcd                            : 0,
    endcd                              : 0,
    instre_flg                         : "",
    endcd2                             : 0,
  );

  _Csv_dly csv_dly = _Csv_dly(
    dly_nouchoku                       : 0,
    dlynouchoku_week                   : 0,
    dlynouchoku_day                    : 0,
    dly_urihdr                         : 0,
    dlyurihdr_week                     : 0,
    dlyurihdr_day                      : 0,
    dly_urimei                         : 0,
    dlyurimei_week                     : 0,
    dlyurimei_day                      : 0,
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
    backup_day                         : "",
    select_dsp                         : 0,
  );

  _Item2 item2 = _Item2(
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
}

@JsonSerializable()
class _Ja_system {
  factory _Ja_system.fromJson(Map<String, dynamic> json) => _$Ja_systemFromJson(json);
  Map<String, dynamic> toJson() => _$Ja_systemToJson(this);

  _Ja_system({
    required this.jano,
    required this.clientno,
    required this.sendcnt,
    required this.senditemcnt,
  });

  @JsonKey(defaultValue: 1)
  int    jano;
  @JsonKey(defaultValue: 1)
  int    clientno;
  @JsonKey(defaultValue: 0)
  int    sendcnt;
  @JsonKey(defaultValue: 0)
  int    senditemcnt;
}

@JsonSerializable()
class _Producer {
  factory _Producer.fromJson(Map<String, dynamic> json) => _$ProducerFromJson(json);
  Map<String, dynamic> toJson() => _$ProducerToJson(this);

  _Producer({
    required this.cdlen,
    required this.startcd,
    required this.endcd,
    required this.endcd2,
  });

  @JsonKey(defaultValue: 0)
  int    cdlen;
  @JsonKey(defaultValue: 1)
  int    startcd;
  @JsonKey(defaultValue: 999)
  int    endcd;
  @JsonKey(defaultValue: 99999)
  int    endcd2;
}

@JsonSerializable()
class _Items {
  factory _Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);

  _Items({
    required this.startcd,
    required this.endcd,
    required this.instre_flg,
    required this.endcd2,
  });

  @JsonKey(defaultValue: 1)
  int    startcd;
  @JsonKey(defaultValue: 999)
  int    endcd;
  @JsonKey(defaultValue: "00")
  String instre_flg;
  @JsonKey(defaultValue: 99999)
  int    endcd2;
}

@JsonSerializable()
class _Csv_dly {
  factory _Csv_dly.fromJson(Map<String, dynamic> json) => _$Csv_dlyFromJson(json);
  Map<String, dynamic> toJson() => _$Csv_dlyToJson(this);

  _Csv_dly({
    required this.dly_nouchoku,
    required this.dlynouchoku_week,
    required this.dlynouchoku_day,
    required this.dly_urihdr,
    required this.dlyurihdr_week,
    required this.dlyurihdr_day,
    required this.dly_urimei,
    required this.dlyurimei_week,
    required this.dlyurimei_day,
  });

  @JsonKey(defaultValue: 0)
  int    dly_nouchoku;
  @JsonKey(defaultValue: 0)
  int    dlynouchoku_week;
  @JsonKey(defaultValue: 1)
  int    dlynouchoku_day;
  @JsonKey(defaultValue: 0)
  int    dly_urihdr;
  @JsonKey(defaultValue: 0)
  int    dlyurihdr_week;
  @JsonKey(defaultValue: 1)
  int    dlyurihdr_day;
  @JsonKey(defaultValue: 0)
  int    dly_urimei;
  @JsonKey(defaultValue: 0)
  int    dlyurimei_week;
  @JsonKey(defaultValue: 1)
  int    dlyurimei_day;
}

@JsonSerializable()
class _Max_item {
  factory _Max_item.fromJson(Map<String, dynamic> json) => _$Max_itemFromJson(json);
  Map<String, dynamic> toJson() => _$Max_itemToJson(this);

  _Max_item({
    required this.total_item,
  });

  @JsonKey(defaultValue: 3)
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
  @JsonKey(defaultValue: "農直品")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "NOUCHOKU")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_nouchoku")
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
    required this.backup_day,
    required this.select_dsp,
  });

  @JsonKey(defaultValue: 0)
  int    onoff;
  @JsonKey(defaultValue: 1)
  int    page;
  @JsonKey(defaultValue: 2)
  int    position;
  @JsonKey(defaultValue: "売上伝票")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "URIHDR")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_urihdr")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

@JsonSerializable()
class _Item2 {
  factory _Item2.fromJson(Map<String, dynamic> json) => _$Item2FromJson(json);
  Map<String, dynamic> toJson() => _$Item2ToJson(this);

  _Item2({
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
  @JsonKey(defaultValue: 3)
  int    position;
  @JsonKey(defaultValue: "売上明細")
  String table1;
  @JsonKey(defaultValue: 1)
  int    total;
  @JsonKey(defaultValue: "URIMEI")
  String t_exe1;
  @JsonKey(defaultValue: "csv_dly")
  String section;
  @JsonKey(defaultValue: "dly_urimei")
  String keyword;
  @JsonKey(defaultValue: "0000-00-00")
  String backup_day;
  @JsonKey(defaultValue: 0)
  int    select_dsp;
}

