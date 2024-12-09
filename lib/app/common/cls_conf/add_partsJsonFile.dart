/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'add_partsJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Add_partsJsonFile extends ConfigJsonFile {
  static final Add_partsJsonFile _instance = Add_partsJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "add_parts.json";

  Add_partsJsonFile(){
    setPath(_confPath, _fileName);
  }
  Add_partsJsonFile._internal();

  factory Add_partsJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Add_partsJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Add_partsJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Add_partsJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        Guidance = _$GGuidanceFromJson(jsonD['Guidance']);
      } catch(e) {
        Guidance = _$GGuidanceFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _GGuidance Guidance = _GGuidance(
    MsgBoxColor                        : 0,
    StatBoxColor                       : 0,
    DispType                           : 0,
  );
}

@JsonSerializable()
class _GGuidance {
  factory _GGuidance.fromJson(Map<String, dynamic> json) => _$GGuidanceFromJson(json);
  Map<String, dynamic> toJson() => _$GGuidanceToJson(this);

  _GGuidance({
    required this.MsgBoxColor,
    required this.StatBoxColor,
    required this.DispType,
  });

  @JsonKey(defaultValue: 15)
  int    MsgBoxColor;
  @JsonKey(defaultValue: 15)
  int    StatBoxColor;
  @JsonKey(defaultValue: 0)
  int    DispType;
}

