/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'sm_scale1JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Sm_scale1JsonFile extends ConfigJsonFile {
  static final Sm_scale1JsonFile _instance = Sm_scale1JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "sm_scale1.json";

  Sm_scale1JsonFile(){
    setPath(_confPath, _fileName);
  }
  Sm_scale1JsonFile._internal();

  factory Sm_scale1JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Sm_scale1JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Sm_scale1JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Sm_scale1JsonFileToJson(this));
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
    id                                 : 0,
    interval                           : 0,
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
    required this.id,
    required this.interval,
  });

  @JsonKey(defaultValue: "com1")
  String port;
  @JsonKey(defaultValue: 38400)
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
  @JsonKey(defaultValue: 1)
  int    id;
  @JsonKey(defaultValue: 3)
  int    interval;
}

