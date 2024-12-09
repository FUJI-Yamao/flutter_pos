/*
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../inc/sys/tpr_log.dart';
import 'configJsonFile.dart';

part 'db_libraryJsonFile_ps.g.dart';

@JsonSerializable(explicitToJson: true)
class Db_libraryJsonFile_Ps extends ConfigJsonFile {
  static final Db_libraryJsonFile_Ps _instance = Db_libraryJsonFile_Ps._internal();

  final String _confPath = "conf/";
  final String _fileName = "db_library_ps.json";

  Db_libraryJsonFile_Ps() {
    setPath(_confPath, _fileName);
  }
  Db_libraryJsonFile_Ps._internal();

  factory Db_libraryJsonFile_Ps.fromJson(Map<String, dynamic> json_T) =>
      _$Db_libraryJsonFile_PsFromJson(json_T);

  Map<String, dynamic> toJson() => _$Db_libraryJsonFile_PsToJson(this);

  String jsonFileToJson() {
    return jsonEncode(_$Db_libraryJsonFile_PsToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        localdb = _$LocaldbFromJson(jsonD['localdb']);
      } catch(e) {
        localdb = _$LocaldbFromJson({});
        ret = false;
      }
      try {
        externaldb = _$ExternaldbFromJson(jsonD['externaldb']);
      } catch(e) {
        externaldb = _$ExternaldbFromJson({});
        ret = false;
      }
    } catch (e) {
      debugPrint("JSONファイルデータ展開失敗");
      TprLog().logAdd(0, LogLevelDefine.normal, "JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Localdb localdb = _Localdb(
    dbName: "",
    host: "",
    port: "",
    username: "",
    password: "",
    connectionTimeout: "",
  );

  _Externaldb externaldb = _Externaldb(
    dbName: "",
    host: "",
    port: "",
    username: "",
    password: "",
    connectionTimeout: "",
  );

}

@JsonSerializable()
class _Localdb {
  factory _Localdb.fromJson(Map<String, dynamic> json) =>
      _$LocaldbFromJson(json);
  Map<String, dynamic> toJson() => _$LocaldbToJson(this);

  _Localdb({
    required this.dbName,
    required this.host,
    required this.port,
    required this.username,
    required this.password,
    required this.connectionTimeout,
  });

  @JsonKey(defaultValue: "tpr.db")
  String dbName;
  @JsonKey(defaultValue: "localhost")
  String host;
  @JsonKey(defaultValue: "5432")
  String port;
  @JsonKey(defaultValue: "postgres")
  String username;
  @JsonKey(defaultValue: "postgres")
  String password;
  @JsonKey(defaultValue: "7")
  String connectionTimeout;
}

@JsonSerializable()
class _Externaldb {
  factory _Externaldb.fromJson(Map<String, dynamic> json) =>
      _$ExternaldbFromJson(json);
  Map<String, dynamic> toJson() => _$ExternaldbToJson(this);

  _Externaldb({
    required this.dbName,
    required this.host,
    required this.port,
    required this.username,
    required this.password,
    required this.connectionTimeout,
  });

  @JsonKey(defaultValue: "tpr.db")
  String dbName;
  @JsonKey(defaultValue: "")
  String host;
  @JsonKey(defaultValue: "5432")
  String port;
  @JsonKey(defaultValue: "postgres")
  String username;
  @JsonKey(defaultValue: "postgres")
  String password;
  @JsonKey(defaultValue: "7")
  String connectionTimeout;
}

