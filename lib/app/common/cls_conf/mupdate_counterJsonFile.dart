/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'mupdate_counterJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Mupdate_counterJsonFile extends ConfigJsonFile {
  static final Mupdate_counterJsonFile _instance = Mupdate_counterJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "mupdate_counter.json";

  Mupdate_counterJsonFile(){
    setPath(_confPath, _fileName);
  }
  Mupdate_counterJsonFile._internal();

  factory Mupdate_counterJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Mupdate_counterJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Mupdate_counterJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Mupdate_counterJsonFileToJson(this));
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
    ttllog_m_cnt                       : 0,
  );
}

@JsonSerializable()
class _Tran {
  factory _Tran.fromJson(Map<String, dynamic> json) => _$TranFromJson(json);
  Map<String, dynamic> toJson() => _$TranToJson(this);

  _Tran({
    required this.ttllog_all_cnt,
    required this.ttllog_m_cnt,
  });

  @JsonKey(defaultValue: 0)
  int    ttllog_all_cnt;
  @JsonKey(defaultValue: 0)
  int    ttllog_m_cnt;
}

