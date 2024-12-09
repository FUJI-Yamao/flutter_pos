/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'webapi_keyJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Webapi_keyJsonFile extends ConfigJsonFile {
  static final Webapi_keyJsonFile _instance = Webapi_keyJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "webapi_key.json";

  Webapi_keyJsonFile(){
    setPath(_confPath, _fileName);
  }
  Webapi_keyJsonFile._internal();

  factory Webapi_keyJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Webapi_keyJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Webapi_keyJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Webapi_keyJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        APIKEY = _$AAPIKEYFromJson(jsonD['APIKEY']);
      } catch(e) {
        APIKEY = _$AAPIKEYFromJson({});
        ret = false;
      }
      try {
        STRETOKEN = _$SSTRETOKENFromJson(jsonD['STRETOKEN']);
      } catch(e) {
        STRETOKEN = _$SSTRETOKENFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _AAPIKEY APIKEY = _AAPIKEY(
    Value                              : "",
  );

  _SSTRETOKEN STRETOKEN = _SSTRETOKEN(
    Value                              : "",
  );
}

@JsonSerializable()
class _AAPIKEY {
  factory _AAPIKEY.fromJson(Map<String, dynamic> json) => _$AAPIKEYFromJson(json);
  Map<String, dynamic> toJson() => _$AAPIKEYToJson(this);

  _AAPIKEY({
    required this.Value,
  });

  @JsonKey(defaultValue: "web-api")
  String Value;
}

@JsonSerializable()
class _SSTRETOKEN {
  factory _SSTRETOKEN.fromJson(Map<String, dynamic> json) => _$SSTRETOKENFromJson(json);
  Map<String, dynamic> toJson() => _$SSTRETOKENToJson(this);

  _SSTRETOKEN({
    required this.Value,
  });

  @JsonKey(defaultValue: "stre-token")
  String Value;
}

