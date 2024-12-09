/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'recogkey_emerJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Recogkey_emerJsonFile extends ConfigJsonFile {
  static final Recogkey_emerJsonFile _instance = Recogkey_emerJsonFile._internal();

  final String _confPath = "conf/func/";
  final String _fileName = "recogkey_emer.json";

  Recogkey_emerJsonFile(){
    setPath(_confPath, _fileName);
  }
  Recogkey_emerJsonFile._internal();

  factory Recogkey_emerJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Recogkey_emerJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Recogkey_emerJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Recogkey_emerJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        DATE = _$DDATEFromJson(jsonD['DATE']);
      } catch(e) {
        DATE = _$DDATEFromJson({});
        ret = false;
      }
      try {
        TIME = _$TTIMEFromJson(jsonD['TIME']);
      } catch(e) {
        TIME = _$TTIMEFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _DDATE DATE = _DDATE(
    date                               : "",
  );

  _TTIME TIME = _TTIME(
    time                               : "",
  );
}

@JsonSerializable()
class _DDATE {
  factory _DDATE.fromJson(Map<String, dynamic> json) => _$DDATEFromJson(json);
  Map<String, dynamic> toJson() => _$DDATEToJson(this);

  _DDATE({
    required this.date,
  });

  @JsonKey(defaultValue: "")
  String date;
}

@JsonSerializable()
class _TTIME {
  factory _TTIME.fromJson(Map<String, dynamic> json) => _$TTIMEFromJson(json);
  Map<String, dynamic> toJson() => _$TTIMEToJson(this);

  _TTIME({
    required this.time,
  });

  @JsonKey(defaultValue: "")
  String time;
}

