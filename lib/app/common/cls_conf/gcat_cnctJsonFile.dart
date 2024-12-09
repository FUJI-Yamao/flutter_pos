/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'gcat_cnctJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Gcat_cnctJsonFile extends ConfigJsonFile {
  static final Gcat_cnctJsonFile _instance = Gcat_cnctJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "gcat_cnct.json";

  Gcat_cnctJsonFile(){
    setPath(_confPath, _fileName);
  }
  Gcat_cnctJsonFile._internal();

  factory Gcat_cnctJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Gcat_cnctJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Gcat_cnctJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Gcat_cnctJsonFileToJson(this));
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
    text_timer                         : 0,
    respons_timer                      : 0,
    ack_cnt                            : 0,
    text_cnt                           : 0,
    eot_cnt                            : 0,
    nak_cnt                            : 0,
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
    required this.text_timer,
    required this.respons_timer,
    required this.ack_cnt,
    required this.text_cnt,
    required this.eot_cnt,
    required this.nak_cnt,
  });

  @JsonKey(defaultValue: "com1")
  String port;
  @JsonKey(defaultValue: 4800)
  int    baudrate;
  @JsonKey(defaultValue: 8)
  int    databit;
  @JsonKey(defaultValue: 1)
  int    startbit;
  @JsonKey(defaultValue: 1)
  int    stopbit;
  @JsonKey(defaultValue: "none")
  String parity;
  @JsonKey(defaultValue: "no")
  String bill;
  @JsonKey(defaultValue: 5)
  int    text_timer;
  @JsonKey(defaultValue: 12)
  int    respons_timer;
  @JsonKey(defaultValue: 3)
  int    ack_cnt;
  @JsonKey(defaultValue: 59)
  int    text_cnt;
  @JsonKey(defaultValue: 3)
  int    eot_cnt;
  @JsonKey(defaultValue: 3)
  int    nak_cnt;
}

