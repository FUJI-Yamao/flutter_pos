/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'tprtss2JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Tprtss2JsonFile extends ConfigJsonFile {
  static final Tprtss2JsonFile _instance = Tprtss2JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "tprtss2.json";

  Tprtss2JsonFile(){
    setPath(_confPath, _fileName);
  }
  Tprtss2JsonFile._internal();

  factory Tprtss2JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Tprtss2JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Tprtss2JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Tprtss2JsonFileToJson(this));
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
    priority                           : 0,
    drw_number                         : 0,
    drw_on_time                        : 0,
    drw_off_time                       : 0,
    prime_plus_flag                    : 0,
    mode_bit6                          : 0,
    mode_bit7                          : 0,
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.priority,
    required this.drw_number,
    required this.drw_on_time,
    required this.drw_off_time,
    required this.prime_plus_flag,
    required this.mode_bit6,
    required this.mode_bit7,
  });

  @JsonKey(defaultValue: 0)
  int    priority;
  @JsonKey(defaultValue: 0)
  int    drw_number;
  @JsonKey(defaultValue: 10)
  int    drw_on_time;
  @JsonKey(defaultValue: 50)
  int    drw_off_time;
  @JsonKey(defaultValue: 0)
  int    prime_plus_flag;
  @JsonKey(defaultValue: 0)
  int    mode_bit6;
  @JsonKey(defaultValue: 1)
  int    mode_bit7;
}

