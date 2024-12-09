import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'environmentJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class EnvironmentJsonFile extends ConfigJsonFile {
  static final EnvironmentJsonFile _instance = EnvironmentJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "environment.json";

  EnvironmentJsonFile(){
    setPath(_confPath, _fileName);
  }
  EnvironmentJsonFile._internal();

  factory EnvironmentJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$EnvironmentJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$EnvironmentJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$EnvironmentJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        environment = _$EnvironmentFromJson(jsonD['environment']);
      } catch(e) {
        environment = _$EnvironmentFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Environment environment = _Environment(
    HOME                               : "",
    PATH                               : "",
    SHELL                              : "",
    BASE_ENV                           : "",
    LC_ALL                             : "",
    LANG                               : "",
    LINGUAS                            : "",
    TPRX_HOME                          : "",
    DISPLAY                            : "",
    WINDOW                             : "",
    CONTENT_LENGTH                     : "",
    PGPASSWORD                         : "",
    PGUSER                             : "",
    PGDATA                             : "",
    PGDATABASE                         : "",
    PGHOST                             : "",
    PGOPTIONS                          : "",
    PGPORT                             : "",
    PGTTY                              : "",
    PGCLIENTENCODING                   : "",
    SMX_HOME                           : "",
    TUO_SEND_ENV                       : "",
  );
}

@JsonSerializable()
class _Environment {
  factory _Environment.fromJson(Map<String, dynamic> json) => _$EnvironmentFromJson(json);
  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);

  _Environment({
    required this.HOME,
    required this.PATH,
    required this.SHELL,
    required this.BASE_ENV,
    required this.LC_ALL,
    required this.LANG,
    required this.LINGUAS,
    required this.TPRX_HOME,
    required this.DISPLAY,
    required this.WINDOW,
    required this.CONTENT_LENGTH,
    required this.PGPASSWORD,
    required this.PGUSER,
    required this.PGDATA,
    required this.PGDATABASE,
    required this.PGHOST,
    required this.PGOPTIONS,
    required this.PGPORT,
    required this.PGTTY,
    required this.PGCLIENTENCODING,
    required this.SMX_HOME,
    required this.TUO_SEND_ENV,
  });

  @JsonKey(defaultValue: "/pj/tprx")
  String HOME;
  @JsonKey(defaultValue: "")
  String PATH;
  @JsonKey(defaultValue: "/bin/bash")
  String SHELL;
  @JsonKey(defaultValue: "")
  String BASE_ENV;
  @JsonKey(defaultValue: "")
  String LC_ALL;
  @JsonKey(defaultValue: "")
  String LANG;
  @JsonKey(defaultValue: "")
  String LINGUAS;
  @JsonKey(defaultValue: "/pj/tprx/")
  String TPRX_HOME;
  @JsonKey(defaultValue: "")
  String DISPLAY;
  @JsonKey(defaultValue: "")
  String WINDOW;
  @JsonKey(defaultValue: "")
  String CONTENT_LENGTH;
  @JsonKey(defaultValue: "")
  String PGPASSWORD;
  @JsonKey(defaultValue: "")
  String PGUSER;
  @JsonKey(defaultValue: "/usr/local/pgsql/data")
  String PGDATA;
  @JsonKey(defaultValue: "")
  String PGDATABASE;
  @JsonKey(defaultValue: "")
  String PGHOST;
  @JsonKey(defaultValue: "")
  String PGOPTIONS;
  @JsonKey(defaultValue: "")
  String PGPORT;
  @JsonKey(defaultValue: "")
  String PGTTY;
  @JsonKey(defaultValue: "")
  String PGCLIENTENCODING;
  @JsonKey(defaultValue: "")
  String SMX_HOME;
  @JsonKey(defaultValue: "")
  String TUO_SEND_ENV;
}

