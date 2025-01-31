﻿/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'scan_plus_1JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Scan_plus_1JsonFile extends ConfigJsonFile {
  static final Scan_plus_1JsonFile _instance = Scan_plus_1JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "scan_plus_1.json";

  Scan_plus_1JsonFile(){
    setPath(_confPath, _fileName);
  }
  Scan_plus_1JsonFile._internal();

  factory Scan_plus_1JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Scan_plus_1JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Scan_plus_1JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Scan_plus_1JsonFileToJson(this));
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
    port_type                          : "",
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
    required this.port_type,
  });

  @JsonKey(defaultValue: "com3")
  String port;
  @JsonKey(defaultValue: 9600)
  int    baudrate;
  @JsonKey(defaultValue: 7)
  int    databit;
  @JsonKey(defaultValue: 1)
  int    startbit;
  @JsonKey(defaultValue: 2)
  int    stopbit;
  @JsonKey(defaultValue: "odd")
  String parity;
  @JsonKey(defaultValue: 1)
  int    id;
  @JsonKey(defaultValue: "com")
  String port_type;
}

