/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'valuecardJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class ValuecardJsonFile extends ConfigJsonFile {
  static final ValuecardJsonFile _instance = ValuecardJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "valuecard.json";

  ValuecardJsonFile(){
    setPath(_confPath, _fileName);
  }
  ValuecardJsonFile._internal();

  factory ValuecardJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$ValuecardJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$ValuecardJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$ValuecardJsonFileToJson(this));
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
    cnct_type                          : "",
    Auth_Token                         : "",
    Auth_key                           : "",
    seqno                              : 0,
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
    required this.cnct_type,
    required this.Auth_Token,
    required this.Auth_key,
    required this.seqno,
  });

  @JsonKey(defaultValue: "")
  String url;
  @JsonKey(defaultValue: "")
  String url_auto_cancel;
  @JsonKey(defaultValue: 5)
  int    timeout;
  @JsonKey(defaultValue: 0)
  int    client_signature;
  @JsonKey(defaultValue: 1000)
  int    debug_zan;
  @JsonKey(defaultValue: 0)
  int    debug_bonus;
  @JsonKey(defaultValue: 0)
  int    debug_coupon;
  @JsonKey(defaultValue: "DLL")
  String cnct_type;
  @JsonKey(defaultValue: "")
  String Auth_Token;
  @JsonKey(defaultValue: "")
  String Auth_key;
  @JsonKey(defaultValue: 0)
  int    seqno;
}

