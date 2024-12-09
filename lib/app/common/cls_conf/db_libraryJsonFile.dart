/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../inc/sys/tpr_log.dart';
import 'configJsonFile.dart';

part 'db_libraryJsonFile.g.dart';

@JsonSerializable(explicitToJson: true)
class Db_libraryJsonFile extends ConfigJsonFile {
  static final Db_libraryJsonFile _instance = Db_libraryJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "db_library.json";

  Db_libraryJsonFile() {
    setPath(_confPath, _fileName);
  }

  Db_libraryJsonFile._internal();

  factory Db_libraryJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Db_libraryJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Db_libraryJsonFileToJson(this);

  String jsonFileToJson() {
    return jsonEncode(_$Db_libraryJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        windows = _$WindowsFromJson(jsonD['windows']);
      } catch(e) {
        windows = _$WindowsFromJson({});
        ret = false;
      }
      try {
        ubuntu = _$UbuntuFromJson(jsonD['ubuntu']);
      } catch(e) {
        ubuntu = _$UbuntuFromJson({});
        ret = false;
      }
      try {
        android = _$AndroidFromJson(jsonD['android']);
      } catch(e) {
        android = _$AndroidFromJson({});
        ret = false;
      }
    } catch (e) {
      debugPrint("JSONファイルデータ展開失敗");
      TprLog().logAdd(0, LogLevelDefine.normal, "JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Windows windows = _Windows(
    isDbPathValid: "",
    dbPath: "",
    subDir: "",
    dbName: "",
    version: "",
  );

  _Ubuntu ubuntu = _Ubuntu(
    isDbPathValid: "",
    dbPath: "",
    subDir: "",
    dbName: "",
    version: "",
  );

  _Android android = _Android(
    isDbPathValid: "",
    dbPath: "",
    subDir: "",
    dbName: "",
    version: "",
  );
}

@JsonSerializable()
class _Windows {
  factory _Windows.fromJson(Map<String, dynamic> json) =>
      _$WindowsFromJson(json);

  Map<String, dynamic> toJson() => _$WindowsToJson(this);

  _Windows({
    required this.isDbPathValid,
    required this.dbPath,
    required this.subDir,
    required this.dbName,
    required this.version,
  });

  @JsonKey(defaultValue: "true")
  String isDbPathValid;
  @JsonKey(defaultValue: "C:\\pos")
  String dbPath;
  @JsonKey(defaultValue: "data")
  String subDir;
  @JsonKey(defaultValue: "tpr.db")
  String dbName;
  @JsonKey(defaultValue: "1")
  String version;
}

@JsonSerializable()
class _Ubuntu {
  factory _Ubuntu.fromJson(Map<String, dynamic> json) => _$UbuntuFromJson(json);

  Map<String, dynamic> toJson() => _$UbuntuToJson(this);

  _Ubuntu({
    required this.isDbPathValid,
    required this.dbPath,
    required this.subDir,
    required this.dbName,
    required this.version,
  });

  @JsonKey(defaultValue: "false")
  String isDbPathValid;
  @JsonKey(defaultValue: "")
  String dbPath;
  @JsonKey(defaultValue: "data")
  String subDir;
  @JsonKey(defaultValue: "tpr.db")
  String dbName;
  @JsonKey(defaultValue: "1")
  String version;
}

@JsonSerializable()
class _Android {
  factory _Android.fromJson(Map<String, dynamic> json) =>
      _$AndroidFromJson(json);

  Map<String, dynamic> toJson() => _$AndroidToJson(this);

  _Android({
    required this.isDbPathValid,
    required this.dbPath,
    required this.subDir,
    required this.dbName,
    required this.version,
  });

  @JsonKey(defaultValue: "true")
  String isDbPathValid;
  @JsonKey(defaultValue: "/data/user/0/jp.co.fsi.flutter_pos/app_flutter")
  String dbPath;
  @JsonKey(defaultValue: "data")
  String subDir;
  @JsonKey(defaultValue: "tpr.db")
  String dbName;
  @JsonKey(defaultValue: "1")
  String version;
}
