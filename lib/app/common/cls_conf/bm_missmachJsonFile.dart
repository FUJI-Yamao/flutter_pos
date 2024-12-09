/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'bm_missmachJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Bm_missmachJsonFile extends ConfigJsonFile {
  static final Bm_missmachJsonFile _instance = Bm_missmachJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "bm_missmach.json";

  Bm_missmachJsonFile(){
    setPath(_confPath, _fileName);
  }
  Bm_missmachJsonFile._internal();

  factory Bm_missmachJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Bm_missmachJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Bm_missmachJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Bm_missmachJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        comp = _$CompFromJson(jsonD['comp']);
      } catch(e) {
        comp = _$CompFromJson({});
        ret = false;
      }
      try {
        cd_backup = _$Cd_backupFromJson(jsonD['cd_backup']);
      } catch(e) {
        cd_backup = _$Cd_backupFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Comp comp = _Comp(
    rec_comp                           : "",
  );

  _Cd_backup cd_backup = _Cd_backup(
    ej_backup                          : "",
  );
}

@JsonSerializable()
class _Comp {
  factory _Comp.fromJson(Map<String, dynamic> json) => _$CompFromJson(json);
  Map<String, dynamic> toJson() => _$CompToJson(this);

  _Comp({
    required this.rec_comp,
  });

  @JsonKey(defaultValue: "ok")
  String rec_comp;
}

@JsonSerializable()
class _Cd_backup {
  factory _Cd_backup.fromJson(Map<String, dynamic> json) => _$Cd_backupFromJson(json);
  Map<String, dynamic> toJson() => _$Cd_backupToJson(this);

  _Cd_backup({
    required this.ej_backup,
  });

  @JsonKey(defaultValue: "0000-00-00")
  String ej_backup;
}

