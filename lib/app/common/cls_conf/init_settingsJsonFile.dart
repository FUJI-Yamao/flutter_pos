/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'init_settingsJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Init_settingsJsonFile extends ConfigJsonFile {
  static final Init_settingsJsonFile _instance = Init_settingsJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "init_settings.json";

  Init_settingsJsonFile(){
    setPath(_confPath, _fileName);
  }
  Init_settingsJsonFile._internal();

  factory Init_settingsJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Init_settingsJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Init_settingsJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Init_settingsJsonFileToJson(this));
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
    language                           : "",
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.language,
  });

  @JsonKey(defaultValue: "jp")
  String language;
}

