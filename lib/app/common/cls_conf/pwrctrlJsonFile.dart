/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'pwrctrlJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class PwrctrlJsonFile extends ConfigJsonFile {
  static final PwrctrlJsonFile _instance = PwrctrlJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "pwrctrl.json";

  PwrctrlJsonFile(){
    setPath(_confPath, _fileName);
  }
  PwrctrlJsonFile._internal();

  factory PwrctrlJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$PwrctrlJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$PwrctrlJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$PwrctrlJsonFileToJson(this));
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
    port                               : "",
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.port,
  });

  @JsonKey(defaultValue: "com1")
  String port;
}

