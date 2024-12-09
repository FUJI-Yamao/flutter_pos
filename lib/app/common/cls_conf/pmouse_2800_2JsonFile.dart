/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'pmouse_2800_2JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Pmouse_2800_2JsonFile extends ConfigJsonFile {
  static final Pmouse_2800_2JsonFile _instance = Pmouse_2800_2JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "pmouse_2800_2.json";

  Pmouse_2800_2JsonFile(){
    setPath(_confPath, _fileName);
  }
  Pmouse_2800_2JsonFile._internal();

  factory Pmouse_2800_2JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Pmouse_2800_2JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Pmouse_2800_2JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Pmouse_2800_2JsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        settings = _$SettingsFromJson(jsonD['settings']);
      } catch(e) {
        settings = _$SettingsFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Settings settings = _Settings(
    dmcno                              : 0,
    reso_x                             : 0,
    reso_y                             : 0,
    x1                                 : 0,
    y1                                 : 0,
    x2                                 : 0,
    y2                                 : 0,
    x3                                 : 0,
    y3                                 : 0,
    x4                                 : 0,
    y4                                 : 0,
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.dmcno,
    required this.reso_x,
    required this.reso_y,
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    required this.x3,
    required this.y3,
    required this.x4,
    required this.y4,
  });

  @JsonKey(defaultValue: 1)
  int    dmcno;
  @JsonKey(defaultValue: 1024)
  int    reso_x;
  @JsonKey(defaultValue: 768)
  int    reso_y;
  @JsonKey(defaultValue: 991)
  int    x1;
  @JsonKey(defaultValue: 985)
  int    y1;
  @JsonKey(defaultValue: 990)
  int    x2;
  @JsonKey(defaultValue: 39)
  int    y2;
  @JsonKey(defaultValue: 55)
  int    x3;
  @JsonKey(defaultValue: 980)
  int    y3;
  @JsonKey(defaultValue: 57)
  int    x4;
  @JsonKey(defaultValue: 42)
  int    y4;
}

