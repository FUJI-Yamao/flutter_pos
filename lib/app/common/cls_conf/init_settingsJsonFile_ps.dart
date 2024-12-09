/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'init_settingsJsonFile_ps.g.dart';

@JsonSerializable(explicitToJson:true)
class Init_settingsJsonFile_ps extends ConfigJsonFile {
  static final Init_settingsJsonFile_ps _instance = Init_settingsJsonFile_ps._internal();

  final String _confPath = "conf/";
  final String _fileName = "init_settings.json";

  Init_settingsJsonFile_ps(){
    setPath(_confPath, _fileName);
  }
  Init_settingsJsonFile_ps._internal();

  factory Init_settingsJsonFile_ps.fromJson(Map<String, dynamic> json_T) =>
      _$Init_settingsJsonFile_psFromJson(json_T);

  Map<String, dynamic> toJson() => _$Init_settingsJsonFile_psToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Init_settingsJsonFile_psToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = false;
    try {
      settings_ps = _$Init_settingsJsonFile_psFromJson(jsonDecode(jsonR)).settings_ps;
      ret = true;
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Settings_ps settings_ps = _Settings_ps(
    language                           : "",
  );
}

@JsonSerializable()
class _Settings_ps {
  factory _Settings_ps.fromJson(Map<String, dynamic> json) => _$Settings_psFromJson(json);
  Map<String, dynamic> toJson() => _$Settings_psToJson(this);

  _Settings_ps({
    required this.language,
  });

  String language                           = "";
}

