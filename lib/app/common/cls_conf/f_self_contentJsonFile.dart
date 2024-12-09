/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'f_self_contentJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class F_self_contentJsonFile extends ConfigJsonFile {
  static final F_self_contentJsonFile _instance = F_self_contentJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "f_self_content.json";

  F_self_contentJsonFile(){
    setPath(_confPath, _fileName);
  }
  F_self_contentJsonFile._internal();

  factory F_self_contentJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$F_self_contentJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$F_self_contentJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$F_self_contentJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        content_dir = _$Content_dirFromJson(jsonD['content_dir']);
      } catch(e) {
        content_dir = _$Content_dirFromJson({});
        ret = false;
      }
      try {
        content_file = _$Content_fileFromJson(jsonD['content_file']);
      } catch(e) {
        content_file = _$Content_fileFromJson({});
        ret = false;
      }
      try {
        content_time = _$Content_timeFromJson(jsonD['content_time']);
      } catch(e) {
        content_time = _$Content_timeFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Content_dir content_dir = _Content_dir(
    dir                                : "",
  );

  _Content_file content_file = _Content_file(
    content_1_name                     : "",
    content_2_name                     : "",
    content_3_name                     : "",
    content_4_name                     : "",
    content_5_name                     : "",
    content_6_name                     : "",
    content_7_name                     : "",
    content_8_name                     : "",
  );

  _Content_time content_time = _Content_time(
    content_1_time                     : "",
    content_2_time                     : "",
    content_3_time                     : "",
    content_4_time                     : "",
    content_5_time                     : "",
    content_6_time                     : "",
    content_7_time                     : "",
    content_8_time                     : "",
  );
}

@JsonSerializable()
class _Content_dir {
  factory _Content_dir.fromJson(Map<String, dynamic> json) => _$Content_dirFromJson(json);
  Map<String, dynamic> toJson() => _$Content_dirToJson(this);

  _Content_dir({
    required this.dir,
  });

  @JsonKey(defaultValue: "conf/image/movie")
  String dir;
}

@JsonSerializable()
class _Content_file {
  factory _Content_file.fromJson(Map<String, dynamic> json) => _$Content_fileFromJson(json);
  Map<String, dynamic> toJson() => _$Content_fileToJson(this);

  _Content_file({
    required this.content_1_name,
    required this.content_2_name,
    required this.content_3_name,
    required this.content_4_name,
    required this.content_5_name,
    required this.content_6_name,
    required this.content_7_name,
    required this.content_8_name,
  });

  @JsonKey(defaultValue: "")
  String content_1_name;
  @JsonKey(defaultValue: "")
  String content_2_name;
  @JsonKey(defaultValue: "")
  String content_3_name;
  @JsonKey(defaultValue: "")
  String content_4_name;
  @JsonKey(defaultValue: "")
  String content_5_name;
  @JsonKey(defaultValue: "")
  String content_6_name;
  @JsonKey(defaultValue: "")
  String content_7_name;
  @JsonKey(defaultValue: "")
  String content_8_name;
}

@JsonSerializable()
class _Content_time {
  factory _Content_time.fromJson(Map<String, dynamic> json) => _$Content_timeFromJson(json);
  Map<String, dynamic> toJson() => _$Content_timeToJson(this);

  _Content_time({
    required this.content_1_time,
    required this.content_2_time,
    required this.content_3_time,
    required this.content_4_time,
    required this.content_5_time,
    required this.content_6_time,
    required this.content_7_time,
    required this.content_8_time,
  });

  @JsonKey(defaultValue: "")
  String content_1_time;
  @JsonKey(defaultValue: "")
  String content_2_time;
  @JsonKey(defaultValue: "")
  String content_3_time;
  @JsonKey(defaultValue: "")
  String content_4_time;
  @JsonKey(defaultValue: "")
  String content_5_time;
  @JsonKey(defaultValue: "")
  String content_6_time;
  @JsonKey(defaultValue: "")
  String content_7_time;
  @JsonKey(defaultValue: "")
  String content_8_time;
}

