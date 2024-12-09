/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'movie_infoJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Movie_infoJsonFile extends ConfigJsonFile {
  static final Movie_infoJsonFile _instance = Movie_infoJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "movie_info.json";

  Movie_infoJsonFile(){
    setPath(_confPath, _fileName);
  }
  Movie_infoJsonFile._internal();

  factory Movie_infoJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Movie_infoJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Movie_infoJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Movie_infoJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        common = _$CommonFromJson(jsonD['common']);
      } catch(e) {
        common = _$CommonFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Common common = _Common(
    position_x                         : 0,
    position_y                         : 0,
    width_size                         : 0,
    height_size                        : 0,
    restart_info                       : 0,
    explain_info                       : 0,
    update_info                        : 0,
  );
}

@JsonSerializable()
class _Common {
  factory _Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);
  Map<String, dynamic> toJson() => _$CommonToJson(this);

  _Common({
    required this.position_x,
    required this.position_y,
    required this.width_size,
    required this.height_size,
    required this.restart_info,
    required this.explain_info,
    required this.update_info,
  });

  @JsonKey(defaultValue: 27)
  int    position_x;
  @JsonKey(defaultValue: 113)
  int    position_y;
  @JsonKey(defaultValue: 576)
  int    width_size;
  @JsonKey(defaultValue: 432)
  int    height_size;
  @JsonKey(defaultValue: 0)
  int    restart_info;
  @JsonKey(defaultValue: 0)
  int    explain_info;
  @JsonKey(defaultValue: 0)
  int    update_info;
}

