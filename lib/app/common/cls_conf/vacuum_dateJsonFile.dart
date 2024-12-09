/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'vacuum_dateJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Vacuum_dateJsonFile extends ConfigJsonFile {
  static final Vacuum_dateJsonFile _instance = Vacuum_dateJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "vacuum_date.json";

  Vacuum_dateJsonFile(){
    setPath(_confPath, _fileName);
  }
  Vacuum_dateJsonFile._internal();

  factory Vacuum_dateJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Vacuum_dateJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Vacuum_dateJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Vacuum_dateJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        db = _$DbFromJson(jsonD['db']);
      } catch(e) {
        db = _$DbFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Db db = _Db(
    vacuum_date                        : "",
  );
}

@JsonSerializable()
class _Db {
  factory _Db.fromJson(Map<String, dynamic> json) => _$DbFromJson(json);
  Map<String, dynamic> toJson() => _$DbToJson(this);

  _Db({
    required this.vacuum_date,
  });

  @JsonKey(defaultValue: "2018/07/01")
  String vacuum_date;
}

