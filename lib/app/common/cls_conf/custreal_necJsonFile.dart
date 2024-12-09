/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'custreal_necJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Custreal_necJsonFile extends ConfigJsonFile {
  static final Custreal_necJsonFile _instance = Custreal_necJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "custreal_nec.json";

  Custreal_necJsonFile(){
    setPath(_confPath, _fileName);
  }
  Custreal_necJsonFile._internal();

  factory Custreal_necJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Custreal_necJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Custreal_necJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Custreal_necJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        nec = _$NecFromJson(jsonD['nec']);
      } catch(e) {
        nec = _$NecFromJson({});
        ret = false;
      }
      try {
        custrealsvr = _$CustrealsvrFromJson(jsonD['custrealsvr']);
      } catch(e) {
        custrealsvr = _$CustrealsvrFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Nec nec = _Nec(
    compcd                             : 0,
    tenantcd                           : 0,
    url                                : "",
  );

  _Custrealsvr custrealsvr = _Custrealsvr(
    timeout                            : 0,
    opentimeout                        : 0,
    openretrycnt                       : 0,
    openretrywait                      : 0,
    retrywaittime                      : 0,
    retrycnt                           : 0,
  );
}

@JsonSerializable()
class _Nec {
  factory _Nec.fromJson(Map<String, dynamic> json) => _$NecFromJson(json);
  Map<String, dynamic> toJson() => _$NecToJson(this);

  _Nec({
    required this.compcd,
    required this.tenantcd,
    required this.url,
  });

  @JsonKey(defaultValue: 1)
  int    compcd;
  @JsonKey(defaultValue: 1006001)
  int    tenantcd;
  @JsonKey(defaultValue: "http:")
  String url;
}

@JsonSerializable()
class _Custrealsvr {
  factory _Custrealsvr.fromJson(Map<String, dynamic> json) => _$CustrealsvrFromJson(json);
  Map<String, dynamic> toJson() => _$CustrealsvrToJson(this);

  _Custrealsvr({
    required this.timeout,
    required this.opentimeout,
    required this.openretrycnt,
    required this.openretrywait,
    required this.retrywaittime,
    required this.retrycnt,
  });

  @JsonKey(defaultValue: 5)
  int    timeout;
  @JsonKey(defaultValue: 1)
  int    opentimeout;
  @JsonKey(defaultValue: 3)
  int    openretrycnt;
  @JsonKey(defaultValue: 500)
  int    openretrywait;
  @JsonKey(defaultValue: 1)
  int    retrywaittime;
  @JsonKey(defaultValue: 1)
  int    retrycnt;
}

