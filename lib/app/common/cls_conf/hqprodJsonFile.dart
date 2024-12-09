/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'hqprodJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class HqprodJsonFile extends ConfigJsonFile {
  static final HqprodJsonFile _instance = HqprodJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "hqprod.json";

  HqprodJsonFile(){
    setPath(_confPath, _fileName);
  }
  HqprodJsonFile._internal();

  factory HqprodJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$HqprodJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$HqprodJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$HqprodJsonFileToJson(this));
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
        counter = _$CounterFromJson(jsonD['counter']);
      } catch(e) {
        counter = _$CounterFromJson({});
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

  _Counter counter = _Counter(
    hqhist_cd_down                     : 0,
    hqhist_cd_up                       : 0,
    hqtmp_mst_cd_up                    : 0,
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
class _Counter {
  factory _Counter.fromJson(Map<String, dynamic> json) => _$CounterFromJson(json);
  Map<String, dynamic> toJson() => _$CounterToJson(this);

  _Counter({
    required this.hqhist_cd_down,
    required this.hqhist_cd_up,
    required this.hqtmp_mst_cd_up,
  });

  @JsonKey(defaultValue: 0)
  int    hqhist_cd_down;
  @JsonKey(defaultValue: 0)
  int    hqhist_cd_up;
  @JsonKey(defaultValue: 0)
  int    hqtmp_mst_cd_up;
}

