/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'tprtsJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class TprtsJsonFile extends ConfigJsonFile {
  static final TprtsJsonFile _instance = TprtsJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "tprts.json";

  TprtsJsonFile(){
    setPath(_confPath, _fileName);
  }
  TprtsJsonFile._internal();

  factory TprtsJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$TprtsJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$TprtsJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$TprtsJsonFileToJson(this));
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
  });

  @JsonKey(defaultValue: 0)
  int    priority;
  @JsonKey(defaultValue: 0)
  int    drw_number;
  @JsonKey(defaultValue: 10)
  int    drw_on_time;
  @JsonKey(defaultValue: 50)
  int    drw_off_time;
}

