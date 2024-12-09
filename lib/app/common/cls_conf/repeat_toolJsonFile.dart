/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'repeat_toolJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Repeat_toolJsonFile extends ConfigJsonFile {
  static final Repeat_toolJsonFile _instance = Repeat_toolJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "repeat_tool.json";

  Repeat_toolJsonFile(){
    setPath(_confPath, _fileName);
  }
  Repeat_toolJsonFile._internal();

  factory Repeat_toolJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Repeat_toolJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Repeat_toolJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Repeat_toolJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        settings = _$SettingsFromJson(jsonD['settings']);
      } catch(e) {
        settings = _$SettingsFromJson({});
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

  _Settings settings = _Settings(
    tool_onoff                         : 0,
    rec_btn                            : 0,
    play_btn                           : 0,
    turningtimes                       : 0,
  );

  _Counter counter = _Counter(
    times                              : 0,
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.tool_onoff,
    required this.rec_btn,
    required this.play_btn,
    required this.turningtimes,
  });

  @JsonKey(defaultValue: 0)
  int    tool_onoff;
  @JsonKey(defaultValue: 16)
  int    rec_btn;
  @JsonKey(defaultValue: 30)
  int    play_btn;
  @JsonKey(defaultValue: 0)
  int    turningtimes;
}

@JsonSerializable()
class _Counter {
  factory _Counter.fromJson(Map<String, dynamic> json) => _$CounterFromJson(json);
  Map<String, dynamic> toJson() => _$CounterToJson(this);

  _Counter({
    required this.times,
  });

  @JsonKey(defaultValue: 0)
  int    times;
}

