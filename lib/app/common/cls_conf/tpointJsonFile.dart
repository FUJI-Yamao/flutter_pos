/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'tpointJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class TpointJsonFile extends ConfigJsonFile {
  static final TpointJsonFile _instance = TpointJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "tpoint.json";

  TpointJsonFile(){
    setPath(_confPath, _fileName);
  }
  TpointJsonFile._internal();

  factory TpointJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$TpointJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$TpointJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$TpointJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        comm = _$CommFromJson(jsonD['comm']);
      } catch(e) {
        comm = _$CommFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Comm comm = _Comm(
    passwd                             : "",
    timeout                            : 0,
    retrycnt                           : 0,
  );
}

@JsonSerializable()
class _Comm {
  factory _Comm.fromJson(Map<String, dynamic> json) => _$CommFromJson(json);
  Map<String, dynamic> toJson() => _$CommToJson(this);

  _Comm({
    required this.passwd,
    required this.timeout,
    required this.retrycnt,
  });

  @JsonKey(defaultValue: "pass")
  String passwd;
  @JsonKey(defaultValue: 3)
  int    timeout;
  @JsonKey(defaultValue: 0)
  int    retrycnt;
}

