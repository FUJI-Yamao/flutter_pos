/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'custreal_ajsJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Custreal_ajsJsonFile extends ConfigJsonFile {
  static final Custreal_ajsJsonFile _instance = Custreal_ajsJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "custreal_ajs.json";

  Custreal_ajsJsonFile(){
    setPath(_confPath, _fileName);
  }
  Custreal_ajsJsonFile._internal();

  factory Custreal_ajsJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Custreal_ajsJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Custreal_ajsJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Custreal_ajsJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        https_host = _$Https_hostFromJson(jsonD['https_host']);
      } catch(e) {
        https_host = _$Https_hostFromJson({});
        ret = false;
      }
      try {
        normal = _$NormalFromJson(jsonD['normal']);
      } catch(e) {
        normal = _$NormalFromJson({});
        ret = false;
      }
      try {
        beniya_authcode = _$Beniya_authcodeFromJson(jsonD['beniya_authcode']);
      } catch(e) {
        beniya_authcode = _$Beniya_authcodeFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Https_host https_host = _Https_host(
    url1                               : "",
    url2                               : "",
    timeout                            : 0,
  );

  _Normal normal = _Normal(
    url                                : "",
    url_auto_cancel                    : "",
    timeout                            : 0,
    timeout2                           : 0,
    client_signature                   : 0,
    debug_zan                          : 0,
    debug_bonus                        : 0,
    debug_coupon                       : 0,
    debug_errcode                      : 0,
  );

  _Beniya_authcode beniya_authcode = _Beniya_authcode(
    auth_url                           : "",
    timeout                            : 0,
  );
}

@JsonSerializable()
class _Https_host {
  factory _Https_host.fromJson(Map<String, dynamic> json) => _$Https_hostFromJson(json);
  Map<String, dynamic> toJson() => _$Https_hostToJson(this);

  _Https_host({
    required this.url1,
    required this.url2,
    required this.timeout,
  });

  @JsonKey(defaultValue: "https:")
  String url1;
  @JsonKey(defaultValue: "https:")
  String url2;
  @JsonKey(defaultValue: 3)
  int    timeout;
}

@JsonSerializable()
class _Normal {
  factory _Normal.fromJson(Map<String, dynamic> json) => _$NormalFromJson(json);
  Map<String, dynamic> toJson() => _$NormalToJson(this);

  _Normal({
    required this.url,
    required this.url_auto_cancel,
    required this.timeout,
    required this.timeout2,
    required this.client_signature,
    required this.debug_zan,
    required this.debug_bonus,
    required this.debug_coupon,
    required this.debug_errcode,
  });

  @JsonKey(defaultValue: "0.0.0.0")
  String url;
  @JsonKey(defaultValue: "0.0.0.0")
  String url_auto_cancel;
  @JsonKey(defaultValue: 15)
  int    timeout;
  @JsonKey(defaultValue: 30)
  int    timeout2;
  @JsonKey(defaultValue: 0)
  int    client_signature;
  @JsonKey(defaultValue: 1000)
  int    debug_zan;
  @JsonKey(defaultValue: 0)
  int    debug_bonus;
  @JsonKey(defaultValue: 0)
  int    debug_coupon;
  @JsonKey(defaultValue: 0)
  int    debug_errcode;
}

@JsonSerializable()
class _Beniya_authcode {
  factory _Beniya_authcode.fromJson(Map<String, dynamic> json) => _$Beniya_authcodeFromJson(json);
  Map<String, dynamic> toJson() => _$Beniya_authcodeToJson(this);

  _Beniya_authcode({
    required this.auth_url,
    required this.timeout,
  });

  @JsonKey(defaultValue: "https://")
  String auth_url;
  @JsonKey(defaultValue: 5)
  int    timeout;
}

