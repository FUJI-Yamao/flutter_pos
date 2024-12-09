/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'update_counterJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Update_counterJsonFile extends ConfigJsonFile {
  static final Update_counterJsonFile _instance = Update_counterJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "update_counter.json";

  Update_counterJsonFile(){
    setPath(_confPath, _fileName);
  }
  Update_counterJsonFile._internal();

  factory Update_counterJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Update_counterJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Update_counterJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Update_counterJsonFileToJson(this));
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
    ttllog_all_cnt                     : 0,
  );
}

@JsonSerializable()
class _Tran {
  factory _Tran.fromJson(Map<String, dynamic> json) => _$TranFromJson(json);
  Map<String, dynamic> toJson() => _$TranToJson(this);

  _Tran({
    required this.ttllog_all_cnt,
  });

  @JsonKey(defaultValue: 0)
  int    ttllog_all_cnt;
}

