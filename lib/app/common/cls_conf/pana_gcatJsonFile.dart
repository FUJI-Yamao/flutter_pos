/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'pana_gcatJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Pana_gcatJsonFile extends ConfigJsonFile {
  static final Pana_gcatJsonFile _instance = Pana_gcatJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "pana_gcat.json";

  Pana_gcatJsonFile(){
    setPath(_confPath, _fileName);
  }
  Pana_gcatJsonFile._internal();

  factory Pana_gcatJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Pana_gcatJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Pana_gcatJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Pana_gcatJsonFileToJson(this));
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
    tmout_nak_send                     : 0,
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
    required this.tmout_nak_send,
  });

  @JsonKey(defaultValue: "com3")
  String port;
  @JsonKey(defaultValue: 2400)
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
  int    tmout_nak_send;
}

