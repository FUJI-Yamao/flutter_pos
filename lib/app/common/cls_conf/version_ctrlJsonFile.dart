/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'version_ctrlJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Version_ctrlJsonFile extends ConfigJsonFile {
  static final Version_ctrlJsonFile _instance = Version_ctrlJsonFile._internal();

  final String _confPath = "conf/";
  final JsonLanguage _confLang = JsonLanguage.aa;
  final String _fileName = "version_ctrl.json";

  Version_ctrlJsonFile(){
    setPath(_confPath, _fileName, _confLang);
  }
  Version_ctrlJsonFile._internal();

  factory Version_ctrlJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Version_ctrlJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Version_ctrlJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Version_ctrlJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        apl_ver = _$Apl_verFromJson(jsonD['apl_ver']);
      } catch(e) {
        apl_ver = _$Apl_verFromJson({});
        ret = false;
      }
      try {
        sub_ver = _$Sub_verFromJson(jsonD['sub_ver']);
      } catch(e) {
        sub_ver = _$Sub_verFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Apl_ver apl_ver = _Apl_ver(
    max                                : 0,
    ver1                               : "",
  );

  _Sub_ver sub_ver = _Sub_ver(
    max                                : 0,
    ver1                               : "",
  );
}

@JsonSerializable()
class _Apl_ver {
  factory _Apl_ver.fromJson(Map<String, dynamic> json) => _$Apl_verFromJson(json);
  Map<String, dynamic> toJson() => _$Apl_verToJson(this);

  _Apl_ver({
    required this.max,
    required this.ver1,
  });

  @JsonKey(defaultValue: 1)
  int    max;
  @JsonKey(defaultValue: "AA1")
  String ver1;
}

@JsonSerializable()
class _Sub_ver {
  factory _Sub_ver.fromJson(Map<String, dynamic> json) => _$Sub_verFromJson(json);
  Map<String, dynamic> toJson() => _$Sub_verToJson(this);

  _Sub_ver({
    required this.max,
    required this.ver1,
  });

  @JsonKey(defaultValue: 1)
  int    max;
  @JsonKey(defaultValue: "vAA1-1")
  String ver1;
}

