/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'rpointJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class RpointJsonFile extends ConfigJsonFile {
  static final RpointJsonFile _instance = RpointJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "rpoint.json";

  RpointJsonFile(){
    setPath(_confPath, _fileName);
  }
  RpointJsonFile._internal();

  factory RpointJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$RpointJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$RpointJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$RpointJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        communicate = _$CommunicateFromJson(jsonD['communicate']);
      } catch(e) {
        communicate = _$CommunicateFromJson({});
        ret = false;
      }
      try {
        training = _$TrainingFromJson(jsonD['training']);
      } catch(e) {
        training = _$TrainingFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Communicate communicate = _Communicate(
    url                                : "",
    hmac_key                           : "",
    timeout                            : 0,
    access_key                         : "",
  );

  _Training training = _Training(
    tr_points                          : 0,
  );
}

@JsonSerializable()
class _Communicate {
  factory _Communicate.fromJson(Map<String, dynamic> json) => _$CommunicateFromJson(json);
  Map<String, dynamic> toJson() => _$CommunicateToJson(this);

  _Communicate({
    required this.url,
    required this.hmac_key,
    required this.timeout,
    required this.access_key,
  });

  @JsonKey(defaultValue: "https://")
  String url;
  @JsonKey(defaultValue: "none")
  String hmac_key;
  @JsonKey(defaultValue: 5)
  int    timeout;
  @JsonKey(defaultValue: "none")
  String access_key;
}

@JsonSerializable()
class _Training {
  factory _Training.fromJson(Map<String, dynamic> json) => _$TrainingFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingToJson(this);

  _Training({
    required this.tr_points,
  });

  @JsonKey(defaultValue: 1000)
  int    tr_points;
}

