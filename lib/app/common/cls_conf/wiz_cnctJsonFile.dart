/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'wiz_cnctJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Wiz_cnctJsonFile extends ConfigJsonFile {
  static final Wiz_cnctJsonFile _instance = Wiz_cnctJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "wiz_cnct.json";

  Wiz_cnctJsonFile(){
    setPath(_confPath, _fileName);
  }
  Wiz_cnctJsonFile._internal();

  factory Wiz_cnctJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Wiz_cnctJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Wiz_cnctJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Wiz_cnctJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        wiz_cnct = _$Wiz_cnctFromJson(jsonD['wiz_cnct']);
      } catch(e) {
        wiz_cnct = _$Wiz_cnctFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Wiz_cnct wiz_cnct = _Wiz_cnct(
    wiz1                               : 0,
    wiz2                               : 0,
    wiz3                               : 0,
    wiz4                               : 0,
    wiz5                               : 0,
    wiz6                               : 0,
    wiz7                               : 0,
    wiz8                               : 0,
    wiz9                               : 0,
    wiz10                              : 0,
  );
}

@JsonSerializable()
class _Wiz_cnct {
  factory _Wiz_cnct.fromJson(Map<String, dynamic> json) => _$Wiz_cnctFromJson(json);
  Map<String, dynamic> toJson() => _$Wiz_cnctToJson(this);

  _Wiz_cnct({
    required this.wiz1,
    required this.wiz2,
    required this.wiz3,
    required this.wiz4,
    required this.wiz5,
    required this.wiz6,
    required this.wiz7,
    required this.wiz8,
    required this.wiz9,
    required this.wiz10,
  });

  @JsonKey(defaultValue: 0)
  int    wiz1;
  @JsonKey(defaultValue: 0)
  int    wiz2;
  @JsonKey(defaultValue: 0)
  int    wiz3;
  @JsonKey(defaultValue: 0)
  int    wiz4;
  @JsonKey(defaultValue: 0)
  int    wiz5;
  @JsonKey(defaultValue: 0)
  int    wiz6;
  @JsonKey(defaultValue: 0)
  int    wiz7;
  @JsonKey(defaultValue: 0)
  int    wiz8;
  @JsonKey(defaultValue: 0)
  int    wiz9;
  @JsonKey(defaultValue: 0)
  int    wiz10;
}

