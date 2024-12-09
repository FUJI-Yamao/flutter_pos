/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'rsv_custrealJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Rsv_custrealJsonFile extends ConfigJsonFile {
  static final Rsv_custrealJsonFile _instance = Rsv_custrealJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "rsv_custreal.json";

  Rsv_custrealJsonFile(){
    setPath(_confPath, _fileName);
  }
  Rsv_custrealJsonFile._internal();

  factory Rsv_custrealJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Rsv_custrealJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Rsv_custrealJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Rsv_custrealJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        custreal = _$CustrealFromJson(jsonD['custreal']);
      } catch(e) {
        custreal = _$CustrealFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Custreal custreal = _Custreal(
    user                               : 0,
    exec_flg                           : 0,
    exec_date                          : "",
    custrealsvr_cnct                   : 0,
  );
}

@JsonSerializable()
class _Custreal {
  factory _Custreal.fromJson(Map<String, dynamic> json) => _$CustrealFromJson(json);
  Map<String, dynamic> toJson() => _$CustrealToJson(this);

  _Custreal({
    required this.user,
    required this.exec_flg,
    required this.exec_date,
    required this.custrealsvr_cnct,
  });

  @JsonKey(defaultValue: 2)
  int    user;
  @JsonKey(defaultValue: 0)
  int    exec_flg;
  @JsonKey(defaultValue: "0000-00-00")
  String exec_date;
  @JsonKey(defaultValue: 1)
  int    custrealsvr_cnct;
}

