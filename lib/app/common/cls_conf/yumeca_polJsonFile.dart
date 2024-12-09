/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'yumeca_polJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Yumeca_polJsonFile extends ConfigJsonFile {
  static final Yumeca_polJsonFile _instance = Yumeca_polJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "yumeca_pol.json";

  Yumeca_polJsonFile(){
    setPath(_confPath, _fileName);
  }
  Yumeca_polJsonFile._internal();

  factory Yumeca_polJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Yumeca_polJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Yumeca_polJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Yumeca_polJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        normal = _$NormalFromJson(jsonD['normal']);
      } catch(e) {
        normal = _$NormalFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Normal normal = _Normal(
    url                                : "",
    url_auto_cancel                    : "",
    timeout                            : 0,
    client_signature                   : 0,
    debug_zan                          : 0,
    comp_no                            : 0,
  );
}

@JsonSerializable()
class _Normal {
  factory _Normal.fromJson(Map<String, dynamic> json) => _$NormalFromJson(json);
  Map<String, dynamic> toJson() => _$NormalToJson(this);

  _Normal({
    required this.url,
    required this.url_auto_cancel,
    required this.timeout,
    required this.client_signature,
    required this.debug_zan,
    required this.comp_no,
  });

  @JsonKey(defaultValue: "0.0.0.0")
  String url;
  @JsonKey(defaultValue: "0.0.0.0")
  String url_auto_cancel;
  @JsonKey(defaultValue: 5)
  int    timeout;
  @JsonKey(defaultValue: 0)
  int    client_signature;
  @JsonKey(defaultValue: 1000)
  int    debug_zan;
  @JsonKey(defaultValue: 0)
  int    comp_no;
}

