/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'systemCheckJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class SystemCheckJsonFile extends ConfigJsonFile {
  static final SystemCheckJsonFile _instance = SystemCheckJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "systemCheck.json";

  SystemCheckJsonFile(){
    setPath(_confPath, _fileName);
  }
  SystemCheckJsonFile._internal();

  factory SystemCheckJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$SystemCheckJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$SystemCheckJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$SystemCheckJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        systemcheck = _$SystemcheckFromJson(jsonD['systemcheck']);
      } catch(e) {
        systemcheck = _$SystemcheckFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Systemcheck systemcheck = _Systemcheck(
    check_sys                          : "",
    check_wait_time                    : 0,
    check_proc                         : "",
    check_disk                         : "",
    disk_thresh                        : 0,
    check_hdd                          : "",
    check_mb                           : "",
    mail_to                            : "",
    mail_from                          : "",
  );
}

@JsonSerializable()
class _Systemcheck {
  factory _Systemcheck.fromJson(Map<String, dynamic> json) => _$SystemcheckFromJson(json);
  Map<String, dynamic> toJson() => _$SystemcheckToJson(this);

  _Systemcheck({
    required this.check_sys,
    required this.check_wait_time,
    required this.check_proc,
    required this.check_disk,
    required this.disk_thresh,
    required this.check_hdd,
    required this.check_mb,
    required this.mail_to,
    required this.mail_from,
  });

  @JsonKey(defaultValue: "no")
  String check_sys;
  @JsonKey(defaultValue: 600)
  int    check_wait_time;
  @JsonKey(defaultValue: "yes")
  String check_proc;
  @JsonKey(defaultValue: "yes")
  String check_disk;
  @JsonKey(defaultValue: 90)
  int    disk_thresh;
  @JsonKey(defaultValue: "yes")
  String check_hdd;
  @JsonKey(defaultValue: "yes")
  String check_mb;
  @JsonKey(defaultValue: "remote_mail@digi.jp")
  String mail_to;
  @JsonKey(defaultValue: "webseries_syschk@digi.jp")
  String mail_from;
}

