﻿/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'apbf_1JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Apbf_1JsonFile extends ConfigJsonFile {
  static final Apbf_1JsonFile _instance = Apbf_1JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "apbf_1.json";

  Apbf_1JsonFile(){
    setPath(_confPath, _fileName);
  }
  Apbf_1JsonFile._internal();

  factory Apbf_1JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Apbf_1JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Apbf_1JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Apbf_1JsonFileToJson(this));
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
    baudrate                           : 0,
    databit                            : 0,
    startbit                           : 0,
    stopbit                            : 0,
    parity                             : "",
    id                                 : 0,
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.port,
    required this.baudrate,
    required this.databit,
    required this.startbit,
    required this.stopbit,
    required this.parity,
    required this.id,
  });

  @JsonKey(defaultValue: "com1")
  String port;
  @JsonKey(defaultValue: 57600)
  int    baudrate;
  @JsonKey(defaultValue: 8)
  int    databit;
  @JsonKey(defaultValue: 1)
  int    startbit;
  @JsonKey(defaultValue: 1)
  int    stopbit;
  @JsonKey(defaultValue: "none")
  String parity;
  @JsonKey(defaultValue: 1)
  int    id;
}
