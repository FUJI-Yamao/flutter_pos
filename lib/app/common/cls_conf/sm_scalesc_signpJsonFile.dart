/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'sm_scalesc_signpJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Sm_scalesc_signpJsonFile extends ConfigJsonFile {
  static final Sm_scalesc_signpJsonFile _instance = Sm_scalesc_signpJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "sm_scalesc_signp.json";

  Sm_scalesc_signpJsonFile(){
    setPath(_confPath, _fileName);
  }
  Sm_scalesc_signpJsonFile._internal();

  factory Sm_scalesc_signpJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Sm_scalesc_signpJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Sm_scalesc_signpJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Sm_scalesc_signpJsonFileToJson(this));
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
    required this.baudrate,
    required this.databit,
    required this.startbit,
    required this.stopbit,
    required this.parity,
    required this.id,
  });

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
  @JsonKey(defaultValue: 2)
  int    id;
}

