/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'hwinfo_cnctJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Hwinfo_cnctJsonFile extends ConfigJsonFile {
  static final Hwinfo_cnctJsonFile _instance = Hwinfo_cnctJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "hwinfo_cnct.json";

  Hwinfo_cnctJsonFile(){
    setPath(_confPath, _fileName);
  }
  Hwinfo_cnctJsonFile._internal();

  factory Hwinfo_cnctJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Hwinfo_cnctJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Hwinfo_cnctJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Hwinfo_cnctJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        comm = _$CommFromJson(jsonD['comm']);
      } catch(e) {
        comm = _$CommFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Comm comm = _Comm(
    head                               : "",
    host                               : "",
    url                                : "",
    time_out                           : 0,
    portal_user                        : "",
    portal_pass                        : "",
    dns1                               : "",
    dns2                               : "",
    max_data_len                       : 0,
  );
}

@JsonSerializable()
class _Comm {
  factory _Comm.fromJson(Map<String, dynamic> json) => _$CommFromJson(json);
  Map<String, dynamic> toJson() => _$CommToJson(this);

  _Comm({
    required this.head,
    required this.host,
    required this.url,
    required this.time_out,
    required this.portal_user,
    required this.portal_pass,
    required this.dns1,
    required this.dns2,
    required this.max_data_len,
  });

  @JsonKey(defaultValue: "http://")
  String head;
  @JsonKey(defaultValue: "iot.975194.jp")
  String host;
  @JsonKey(defaultValue: "/api/v1/info")
  String url;
  @JsonKey(defaultValue: 180)
  int    time_out;
  @JsonKey(defaultValue: "use-token-auth")
  String portal_user;
  @JsonKey(defaultValue: "Teraoka0893")
  String portal_pass;
  @JsonKey(defaultValue: "8.8.8.8")
  String dns1;
  @JsonKey(defaultValue: "8.8.4.4")
  String dns2;
  @JsonKey(defaultValue: 0)
  int    max_data_len;
}

