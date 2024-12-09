/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'imageJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class ImageJsonFile extends ConfigJsonFile {
  static final ImageJsonFile _instance = ImageJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "image.json";

  ImageJsonFile(){
    setPath(_confPath, _fileName);
  }
  ImageJsonFile._internal();

  factory ImageJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$ImageJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$ImageJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$ImageJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        skin_icon = _$Skin_iconFromJson(jsonD['skin_icon']);
      } catch(e) {
        skin_icon = _$Skin_iconFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Skin_icon skin_icon = _Skin_icon(
    skin                               : "",
    icon                               : "",
  );
}

@JsonSerializable()
class _Skin_icon {
  factory _Skin_icon.fromJson(Map<String, dynamic> json) => _$Skin_iconFromJson(json);
  Map<String, dynamic> toJson() => _$Skin_iconToJson(this);

  _Skin_icon({
    required this.skin,
    required this.icon,
  });

  @JsonKey(defaultValue: "sk1 0")
  String skin;
  @JsonKey(defaultValue: "icon_animal 8")
  String icon;
}

