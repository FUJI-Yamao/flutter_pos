/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'vup_infoJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Vup_infoJsonFile extends ConfigJsonFile {
  static final Vup_infoJsonFile _instance = Vup_infoJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "vup_info.json";

  Vup_infoJsonFile(){
    setPath(_confPath, _fileName);
  }
  Vup_infoJsonFile._internal();

  factory Vup_infoJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Vup_infoJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Vup_infoJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Vup_infoJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        vup_info = _$Vup_infoFromJson(jsonD['vup_info']);
      } catch(e) {
        vup_info = _$Vup_infoFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Vup_info vup_info = _Vup_info(
    vup_exe                            : 0,
    reboot                             : 0,
  );
}

@JsonSerializable()
class _Vup_info {
  factory _Vup_info.fromJson(Map<String, dynamic> json) => _$Vup_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Vup_infoToJson(this);

  _Vup_info({
    required this.vup_exe,
    required this.reboot,
  });

  @JsonKey(defaultValue: 0)
  int    vup_exe;
  @JsonKey(defaultValue: 0)
  int    reboot;
}

