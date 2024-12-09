/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'msr_chkJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Msr_chkJsonFile extends ConfigJsonFile {
  static final Msr_chkJsonFile _instance = Msr_chkJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "msr_chk.json";

  Msr_chkJsonFile(){
    setPath(_confPath, _fileName);
  }
  Msr_chkJsonFile._internal();

  factory Msr_chkJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Msr_chkJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Msr_chkJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Msr_chkJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        JIS1 = _$JJIS1FromJson(jsonD['JIS1']);
      } catch(e) {
        JIS1 = _$JJIS1FromJson({});
        ret = false;
      }
      try {
        JIS2 = _$JJIS2FromJson(jsonD['JIS2']);
      } catch(e) {
        JIS2 = _$JJIS2FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _JJIS1 JIS1 = _JJIS1(
    length1                            : 0,
    length2                            : 0,
    length3                            : 0,
    length4                            : 0,
    length5                            : 0,
    max_length                         : 0,
    min_length                         : 0,
  );

  _JJIS2 JIS2 = _JJIS2(
    length1                            : 0,
    length2                            : 0,
    length3                            : 0,
    length4                            : 0,
    length5                            : 0,
    max_length                         : 0,
    min_length                         : 0,
  );
}

@JsonSerializable()
class _JJIS1 {
  factory _JJIS1.fromJson(Map<String, dynamic> json) => _$JJIS1FromJson(json);
  Map<String, dynamic> toJson() => _$JJIS1ToJson(this);

  _JJIS1({
    required this.length1,
    required this.length2,
    required this.length3,
    required this.length4,
    required this.length5,
    required this.max_length,
    required this.min_length,
  });

  @JsonKey(defaultValue: 40)
  int    length1;
  @JsonKey(defaultValue: 32)
  int    length2;
  @JsonKey(defaultValue: 35)
  int    length3;
  @JsonKey(defaultValue: 0)
  int    length4;
  @JsonKey(defaultValue: 0)
  int    length5;
  @JsonKey(defaultValue: 40)
  int    max_length;
  @JsonKey(defaultValue: 30)
  int    min_length;
}

@JsonSerializable()
class _JJIS2 {
  factory _JJIS2.fromJson(Map<String, dynamic> json) => _$JJIS2FromJson(json);
  Map<String, dynamic> toJson() => _$JJIS2ToJson(this);

  _JJIS2({
    required this.length1,
    required this.length2,
    required this.length3,
    required this.length4,
    required this.length5,
    required this.max_length,
    required this.min_length,
  });

  @JsonKey(defaultValue: 72)
  int    length1;
  @JsonKey(defaultValue: 0)
  int    length2;
  @JsonKey(defaultValue: 0)
  int    length3;
  @JsonKey(defaultValue: 0)
  int    length4;
  @JsonKey(defaultValue: 0)
  int    length5;
  @JsonKey(defaultValue: 72)
  int    max_length;
  @JsonKey(defaultValue: 70)
  int    min_length;
}

