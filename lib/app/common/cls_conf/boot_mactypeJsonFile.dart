/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'boot_mactypeJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Boot_mactypeJsonFile extends ConfigJsonFile {
  static final Boot_mactypeJsonFile _instance = Boot_mactypeJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "boot_mactype.json";

  Boot_mactypeJsonFile(){
    setPath(_confPath, _fileName);
  }
  Boot_mactypeJsonFile._internal();

  factory Boot_mactypeJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Boot_mactypeJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Boot_mactypeJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Boot_mactypeJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        type = _$TypeFromJson(jsonD['type']);
      } catch(e) {
        type = _$TypeFromJson({});
        ret = false;
      }
      try {
        counter = _$CounterFromJson(jsonD['counter']);
      } catch(e) {
        counter = _$CounterFromJson({});
        ret = false;
      }
      try {
        debug_counter = _$Debug_counterFromJson(jsonD['debug_counter']);
      } catch(e) {
        debug_counter = _$Debug_counterFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Type type = _Type(
    tower                              : "",
  );

  _Counter counter = _Counter(
    max                                : 0,
    cnt                                : 0,
  );

  _Debug_counter debug_counter = _Debug_counter(
    max                                : 0,
    cnt                                : 0,
  );
}

@JsonSerializable()
class _Type {
  factory _Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
  Map<String, dynamic> toJson() => _$TypeToJson(this);

  _Type({
    required this.tower,
  });

  @JsonKey(defaultValue: "no")
  String tower;
}

@JsonSerializable()
class _Counter {
  factory _Counter.fromJson(Map<String, dynamic> json) => _$CounterFromJson(json);
  Map<String, dynamic> toJson() => _$CounterToJson(this);

  _Counter({
    required this.max,
    required this.cnt,
  });

  @JsonKey(defaultValue: 3)
  int    max;
  @JsonKey(defaultValue: 3)
  int    cnt;
}

@JsonSerializable()
class _Debug_counter {
  factory _Debug_counter.fromJson(Map<String, dynamic> json) => _$Debug_counterFromJson(json);
  Map<String, dynamic> toJson() => _$Debug_counterToJson(this);

  _Debug_counter({
    required this.max,
    required this.cnt,
  });

  @JsonKey(defaultValue: 3)
  int    max;
  @JsonKey(defaultValue: 3)
  int    cnt;
}

