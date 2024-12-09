/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'cogcaJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class CogcaJsonFile extends ConfigJsonFile {
  static final CogcaJsonFile _instance = CogcaJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "cogca.json";

  CogcaJsonFile(){
    setPath(_confPath, _fileName);
  }
  CogcaJsonFile._internal();

  factory CogcaJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$CogcaJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$CogcaJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$CogcaJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
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

  _Normal normal = _Normal(
    url                                : "",
    url_auto_cancel                    : "",
    timeout                            : 0,
    client_signature                   : 0,
    debug_zan                          : 0,
    debug_bonus                        : 0,
    debug_coupon                       : 0,
  );
}

@JsonSerializable()
class _Normal {
  factory _Normal.fromJson(Map<String, dynamic> json) => _$NormalFromJson(json);
  Map<String, dynamic> toJson() => _$NormalToJson(this);

  _Normal({
    required this.url,
    required this.url_auto_cancel,
    required this.timeout,
    required this.client_signature,
    required this.debug_zan,
    required this.debug_bonus,
    required this.debug_coupon,
  });

  @JsonKey(defaultValue: "")
  String url;
  @JsonKey(defaultValue: "")
  String url_auto_cancel;
  @JsonKey(defaultValue: 7)
  int    timeout;
  @JsonKey(defaultValue: 0)
  int    client_signature;
  @JsonKey(defaultValue: 1000)
  int    debug_zan;
  @JsonKey(defaultValue: 0)
  int    debug_bonus;
  @JsonKey(defaultValue: 0)
  int    debug_coupon;
}

