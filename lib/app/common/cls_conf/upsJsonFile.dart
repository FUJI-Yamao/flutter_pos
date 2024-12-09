/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'upsJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class UpsJsonFile extends ConfigJsonFile {
  static final UpsJsonFile _instance = UpsJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "ups.json";

  UpsJsonFile(){
    setPath(_confPath, _fileName);
  }
  UpsJsonFile._internal();

  factory UpsJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$UpsJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$UpsJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$UpsJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        ups = _$UpsFromJson(jsonD['ups']);
      } catch(e) {
        ups = _$UpsFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Ups ups = _Ups(
    port                               : "",
    basetimer                          : 0,
    emgtimer                           : 0,
    emgcnt                             : 0,
  );
}

@JsonSerializable()
class _Ups {
  factory _Ups.fromJson(Map<String, dynamic> json) => _$UpsFromJson(json);
  Map<String, dynamic> toJson() => _$UpsToJson(this);

  _Ups({
    required this.port,
    required this.basetimer,
    required this.emgtimer,
    required this.emgcnt,
  });

  @JsonKey(defaultValue: "/dev/cua0")
  String port;
  @JsonKey(defaultValue: 5000)
  int    basetimer;
  @JsonKey(defaultValue: 1000)
  int    emgtimer;
  @JsonKey(defaultValue: 10)
  int    emgcnt;
}

