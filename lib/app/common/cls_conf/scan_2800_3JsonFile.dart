/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'scan_2800_3JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Scan_2800_3JsonFile extends ConfigJsonFile {
  static final Scan_2800_3JsonFile _instance = Scan_2800_3JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "scan_2800_3.json";

  Scan_2800_3JsonFile(){
    setPath(_confPath, _fileName);
  }
  Scan_2800_3JsonFile._internal();

  factory Scan_2800_3JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Scan_2800_3JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Scan_2800_3JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Scan_2800_3JsonFileToJson(this));
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

  @JsonKey(defaultValue: "com2")
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
  @JsonKey(defaultValue: 33)
  int    id;
  @JsonKey(defaultValue: "scan")
  String port_type;
}

