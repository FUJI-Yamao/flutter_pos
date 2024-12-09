/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'nttd_precaJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Nttd_precaJsonFile extends ConfigJsonFile {
  static final Nttd_precaJsonFile _instance = Nttd_precaJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "nttd_preca.json";

  Nttd_precaJsonFile(){
    setPath(_confPath, _fileName);
  }
  Nttd_precaJsonFile._internal();

  factory Nttd_precaJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Nttd_precaJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Nttd_precaJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Nttd_precaJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        arcs = _$ArcsFromJson(jsonD['arcs']);
      } catch(e) {
        arcs = _$ArcsFromJson({});
        ret = false;
      }
      try {
        normal = _$NormalFromJson(jsonD['normal']);
      } catch(e) {
        normal = _$NormalFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Arcs arcs = _Arcs(
    url                                : "",
    schemeid                           : 0,
    mbr_add_code                       : 0,
    debug_zan                          : 0,
  );

  _Normal normal = _Normal(
    url                                : "",
    schemeid                           : 0,
    mbr_add_code                       : 0,
    debug_zan                          : 0,
  );
}

@JsonSerializable()
class _Arcs {
  factory _Arcs.fromJson(Map<String, dynamic> json) => _$ArcsFromJson(json);
  Map<String, dynamic> toJson() => _$ArcsToJson(this);

  _Arcs({
    required this.url,
    required this.schemeid,
    required this.mbr_add_code,
    required this.debug_zan,
  });

  @JsonKey(defaultValue: "10.207.5.230:3100/gaihan/servlet/online?")
  String url;
  @JsonKey(defaultValue: 70101)
  int    schemeid;
  @JsonKey(defaultValue: 6101)
  int    mbr_add_code;
  @JsonKey(defaultValue: 10000)
  int    debug_zan;
}

@JsonSerializable()
class _Normal {
  factory _Normal.fromJson(Map<String, dynamic> json) => _$NormalFromJson(json);
  Map<String, dynamic> toJson() => _$NormalToJson(this);

  _Normal({
    required this.url,
    required this.schemeid,
    required this.mbr_add_code,
    required this.debug_zan,
  });

  @JsonKey(defaultValue: ":3100/gaihan/servlet/online?")
  String url;
  @JsonKey(defaultValue: 0)
  int    schemeid;
  @JsonKey(defaultValue: 0)
  int    mbr_add_code;
  @JsonKey(defaultValue: 10000)
  int    debug_zan;
}

