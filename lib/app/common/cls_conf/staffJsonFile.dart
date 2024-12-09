/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'staffJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class StaffJsonFile extends ConfigJsonFile {
  static final StaffJsonFile _instance = StaffJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "staff.json";

  StaffJsonFile(){
    setPath(_confPath, _fileName);
  }
  StaffJsonFile._internal();

  factory StaffJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$StaffJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$StaffJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$StaffJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        simple_2staff = _$Simple_2staffFromJson(jsonD['simple_2staff']);
      } catch(e) {
        simple_2staff = _$Simple_2staffFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Simple_2staff simple_2staff = _Simple_2staff(
    person                             : 0,
  );
}

@JsonSerializable()
class _Simple_2staff {
  factory _Simple_2staff.fromJson(Map<String, dynamic> json) => _$Simple_2staffFromJson(json);
  Map<String, dynamic> toJson() => _$Simple_2staffToJson(this);

  _Simple_2staff({
    required this.person,
  });

  @JsonKey(defaultValue: 1)
  int    person;
}

