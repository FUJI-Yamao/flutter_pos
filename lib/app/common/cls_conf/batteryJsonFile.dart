/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'batteryJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class BatteryJsonFile extends ConfigJsonFile {
  static final BatteryJsonFile _instance = BatteryJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "battery.json";

  BatteryJsonFile(){
    setPath(_confPath, _fileName);
  }
  BatteryJsonFile._internal();

  factory BatteryJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$BatteryJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$BatteryJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$BatteryJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        battery = _$BatteryFromJson(jsonD['battery']);
      } catch(e) {
        battery = _$BatteryFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Battery battery = _Battery(
    warning_date                       : "",
  );
}

@JsonSerializable()
class _Battery {
  factory _Battery.fromJson(Map<String, dynamic> json) => _$BatteryFromJson(json);
  Map<String, dynamic> toJson() => _$BatteryToJson(this);

  _Battery({
    required this.warning_date,
  });

  @JsonKey(defaultValue: "0000-00-00")
  String warning_date;
}

