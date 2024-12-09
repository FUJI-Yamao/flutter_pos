/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'tprtim_counterJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Tprtim_counterJsonFile extends ConfigJsonFile {
  static final Tprtim_counterJsonFile _instance = Tprtim_counterJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "tprtim_counter.json";

  Tprtim_counterJsonFile(){
    setPath(_confPath, _fileName);
  }
  Tprtim_counterJsonFile._internal();

  factory Tprtim_counterJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Tprtim_counterJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Tprtim_counterJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Tprtim_counterJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        tran = _$TranFromJson(jsonD['tran']);
      } catch(e) {
        tran = _$TranFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Tran tran = _Tran(
    nearend_base                       : 0,
    nearend_curr                       : 0,
    nearend_check_fail                 : 0,
  );
}

@JsonSerializable()
class _Tran {
  factory _Tran.fromJson(Map<String, dynamic> json) => _$TranFromJson(json);
  Map<String, dynamic> toJson() => _$TranToJson(this);

  _Tran({
    required this.nearend_base,
    required this.nearend_curr,
    required this.nearend_check_fail,
  });

  @JsonKey(defaultValue: 0)
  int    nearend_base;
  @JsonKey(defaultValue: 0)
  int    nearend_curr;
  @JsonKey(defaultValue: 0)
  int    nearend_check_fail;
}

