/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'jrw_multiJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Jrw_multiJsonFile extends ConfigJsonFile {
  static final Jrw_multiJsonFile _instance = Jrw_multiJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "jrw_multi.json";

  Jrw_multiJsonFile(){
    setPath(_confPath, _fileName);
  }
  Jrw_multiJsonFile._internal();

  factory Jrw_multiJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Jrw_multiJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Jrw_multiJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Jrw_multiJsonFileToJson(this));
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
  });

  @JsonKey(defaultValue: "com1")
  String port;
  @JsonKey(defaultValue: 19200)
  int    baudrate;
  @JsonKey(defaultValue: 8)
  int    databit;
  @JsonKey(defaultValue: 1)
  int    startbit;
  @JsonKey(defaultValue: 1)
  int    stopbit;
  @JsonKey(defaultValue: "none")
  String parity;
}

