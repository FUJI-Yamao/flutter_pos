/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'mkey_2800_2JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Mkey_2800_2JsonFile extends ConfigJsonFile {
  static final Mkey_2800_2JsonFile _instance = Mkey_2800_2JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "mkey_2800_2.json";

  Mkey_2800_2JsonFile(){
    setPath(_confPath, _fileName);
  }
  Mkey_2800_2JsonFile._internal();

  factory Mkey_2800_2JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Mkey_2800_2JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Mkey_2800_2JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Mkey_2800_2JsonFileToJson(this));
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
    id                                 : 0,
    connect                            : 0,
    comp_cnt                           : 0,
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.id,
    required this.connect,
    required this.comp_cnt,
  });

  @JsonKey(defaultValue: 2)
  int    id;
  @JsonKey(defaultValue: 6)
  int    connect;
  @JsonKey(defaultValue: 1)
  int    comp_cnt;
}

