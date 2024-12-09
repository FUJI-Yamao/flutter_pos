/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'devreadJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class DevreadJsonFile extends ConfigJsonFile {
  static final DevreadJsonFile _instance = DevreadJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "devread.json";

  DevreadJsonFile(){
    setPath(_confPath, _fileName);
  }
  DevreadJsonFile._internal();

  factory DevreadJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$DevreadJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$DevreadJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$DevreadJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        device = _$DeviceFromJson(jsonD['device']);
      } catch(e) {
        device = _$DeviceFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Device device = _Device(
    read_date                          : "",
  );
}

@JsonSerializable()
class _Device {
  factory _Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  _Device({
    required this.read_date,
  });

  @JsonKey(defaultValue: "2017/08")
  String read_date;
}

