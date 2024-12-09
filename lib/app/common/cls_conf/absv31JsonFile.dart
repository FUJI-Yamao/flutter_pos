/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'absv31JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Absv31JsonFile extends ConfigJsonFile {
  static final Absv31JsonFile _instance = Absv31JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "absv31.json";

  Absv31JsonFile(){
    setPath(_confPath, _fileName);
  }
  Absv31JsonFile._internal();

  factory Absv31JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Absv31JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Absv31JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Absv31JsonFileToJson(this));
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
    bill                               : "",
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
    required this.bill,
  });

  @JsonKey(defaultValue: "com1")
  String port;
  @JsonKey(defaultValue: 9600)
  int    baudrate;
  @JsonKey(defaultValue: 8)
  int    databit;
  @JsonKey(defaultValue: 1)
  int    startbit;
  @JsonKey(defaultValue: 1)
  int    stopbit;
  @JsonKey(defaultValue: "even")
  String parity;
  @JsonKey(defaultValue: "no")
  String bill;
}

