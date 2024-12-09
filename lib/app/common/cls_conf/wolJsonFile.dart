/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'wolJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class WolJsonFile extends ConfigJsonFile {
  static final WolJsonFile _instance = WolJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "wol.json";

  WolJsonFile(){
    setPath(_confPath, _fileName);
  }
  WolJsonFile._internal();

  factory WolJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$WolJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$WolJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$WolJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        system = _$SystemFromJson(jsonD['system']);
      } catch(e) {
        system = _$SystemFromJson({});
        ret = false;
      }
      try {
        mm_system = _$Mm_systemFromJson(jsonD['mm_system']);
      } catch(e) {
        mm_system = _$Mm_systemFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _System system = _System(
    wol_settime                        : "",
    wol_time                           : "",
    reboot                             : 0,
  );

  _Mm_system mm_system = _Mm_system(
    wolDelay                           : 0,
  );
}

@JsonSerializable()
class _System {
  factory _System.fromJson(Map<String, dynamic> json) => _$SystemFromJson(json);
  Map<String, dynamic> toJson() => _$SystemToJson(this);

  _System({
    required this.wol_settime,
    required this.wol_time,
    required this.reboot,
  });

  @JsonKey(defaultValue: "0000")
  String wol_settime;
  @JsonKey(defaultValue: "0000-00-00 00:00:00")
  String wol_time;
  @JsonKey(defaultValue: 0)
  int    reboot;
}

@JsonSerializable()
class _Mm_system {
  factory _Mm_system.fromJson(Map<String, dynamic> json) => _$Mm_systemFromJson(json);
  Map<String, dynamic> toJson() => _$Mm_systemToJson(this);

  _Mm_system({
    required this.wolDelay,
  });

  @JsonKey(defaultValue: 40)
  int    wolDelay;
}

