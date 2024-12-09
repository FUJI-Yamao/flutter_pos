/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'ecs_fwJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Ecs_fwJsonFile extends ConfigJsonFile {
  static final Ecs_fwJsonFile _instance = Ecs_fwJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "ecs_fw.json";

  Ecs_fwJsonFile(){
    setPath(_confPath, _fileName);
  }
  Ecs_fwJsonFile._internal();

  factory Ecs_fwJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Ecs_fwJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Ecs_fwJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Ecs_fwJsonFileToJson(this));
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
    type                               : 0,
    ver_ctrl                           : 0,
    ver_coin                           : 0,
    ver_bill                           : 0,
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.type,
    required this.ver_ctrl,
    required this.ver_coin,
    required this.ver_bill,
  });

  @JsonKey(defaultValue: 0)
  int    type;
  @JsonKey(defaultValue: 0)
  int    ver_ctrl;
  @JsonKey(defaultValue: 0)
  int    ver_coin;
  @JsonKey(defaultValue: 0)
  int    ver_bill;
}

