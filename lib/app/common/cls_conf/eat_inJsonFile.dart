/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'eat_inJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Eat_inJsonFile extends ConfigJsonFile {
  static final Eat_inJsonFile _instance = Eat_inJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "eat_in.json";

  Eat_inJsonFile(){
    setPath(_confPath, _fileName);
  }
  Eat_inJsonFile._internal();

  factory Eat_inJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Eat_inJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Eat_inJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Eat_inJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
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

  _Counter counter = _Counter(
    start                              : 0,
    end                                : 0,
  );
}

@JsonSerializable()
class _Counter {
  factory _Counter.fromJson(Map<String, dynamic> json) => _$CounterFromJson(json);
  Map<String, dynamic> toJson() => _$CounterToJson(this);

  _Counter({
    required this.start,
    required this.end,
  });

  @JsonKey(defaultValue: 1)
  int    start;
  @JsonKey(defaultValue: 999)
  int    end;
}

