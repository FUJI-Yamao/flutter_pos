/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'hqftpJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class HqftpJsonFile extends ConfigJsonFile {
  static final HqftpJsonFile _instance = HqftpJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "hqftp.json";

  HqftpJsonFile(){
    setPath(_confPath, _fileName);
  }
  HqftpJsonFile._internal();

  factory HqftpJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$HqftpJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$HqftpJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$HqftpJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        cycle = _$CycleFromJson(jsonD['cycle']);
      } catch(e) {
        cycle = _$CycleFromJson({});
        ret = false;
      }
      try {
        specify = _$SpecifyFromJson(jsonD['specify']);
      } catch(e) {
        specify = _$SpecifyFromJson({});
        ret = false;
      }
      try {
        strcls = _$StrclsFromJson(jsonD['strcls']);
      } catch(e) {
        strcls = _$StrclsFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Cycle cycle = _Cycle(
    value                              : 0,
  );

  _Specify specify = _Specify(
    value1                             : "",
    value2                             : "",
    value3                             : "",
    value4                             : "",
    value5                             : "",
    value6                             : "",
    value7                             : "",
    value8                             : "",
    value9                             : "",
    value10                            : "",
    value11                            : "",
    value12                            : "",
  );

  _Strcls strcls = _Strcls(
    il_tl_send                         : 0,
    jnl_send                           : 0,
  );
}

@JsonSerializable()
class _Cycle {
  factory _Cycle.fromJson(Map<String, dynamic> json) => _$CycleFromJson(json);
  Map<String, dynamic> toJson() => _$CycleToJson(this);

  _Cycle({
    required this.value,
  });

  @JsonKey(defaultValue: 9999)
  int    value;
}

@JsonSerializable()
class _Specify {
  factory _Specify.fromJson(Map<String, dynamic> json) => _$SpecifyFromJson(json);
  Map<String, dynamic> toJson() => _$SpecifyToJson(this);

  _Specify({
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.value6,
    required this.value7,
    required this.value8,
    required this.value9,
    required this.value10,
    required this.value11,
    required this.value12,
  });

  @JsonKey(defaultValue: "")
  String value1;
  @JsonKey(defaultValue: "")
  String value2;
  @JsonKey(defaultValue: "")
  String value3;
  @JsonKey(defaultValue: "")
  String value4;
  @JsonKey(defaultValue: "")
  String value5;
  @JsonKey(defaultValue: "")
  String value6;
  @JsonKey(defaultValue: "")
  String value7;
  @JsonKey(defaultValue: "")
  String value8;
  @JsonKey(defaultValue: "")
  String value9;
  @JsonKey(defaultValue: "")
  String value10;
  @JsonKey(defaultValue: "")
  String value11;
  @JsonKey(defaultValue: "")
  String value12;
}

@JsonSerializable()
class _Strcls {
  factory _Strcls.fromJson(Map<String, dynamic> json) => _$StrclsFromJson(json);
  Map<String, dynamic> toJson() => _$StrclsToJson(this);

  _Strcls({
    required this.il_tl_send,
    required this.jnl_send,
  });

  @JsonKey(defaultValue: 0)
  int    il_tl_send;
  @JsonKey(defaultValue: 0)
  int    jnl_send;
}

