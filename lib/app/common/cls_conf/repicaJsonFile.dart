/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'repicaJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class RepicaJsonFile extends ConfigJsonFile {
  static final RepicaJsonFile _instance = RepicaJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "repica.json";

  RepicaJsonFile(){
    setPath(_confPath, _fileName);
  }
  RepicaJsonFile._internal();

  factory RepicaJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$RepicaJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$RepicaJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$RepicaJsonFileToJson(this));
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
      try {
        cocona = _$CoconaFromJson(jsonD['cocona']);
      } catch(e) {
        cocona = _$CoconaFromJson({});
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
    validFlg                           : 0,
    debug_pntzan                       : 0,
  );

  _Cocona cocona = _Cocona(
    url                                : "",
    url_auto_cancel                    : "",
    client_signature                   : 0,
    debug_zan                          : 0,
    validFlg_cocona                    : 0,
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
    required this.validFlg,
    required this.debug_pntzan,
  });

  @JsonKey(defaultValue: "https://")
  String url;
  @JsonKey(defaultValue: "https://")
  String url_auto_cancel;
  @JsonKey(defaultValue: 5)
  int    timeout;
  @JsonKey(defaultValue: 0)
  int    client_signature;
  @JsonKey(defaultValue: 1000)
  int    debug_zan;
  @JsonKey(defaultValue: 0)
  int    validFlg;
  @JsonKey(defaultValue: 1000)
  int    debug_pntzan;
}

@JsonSerializable()
class _Cocona {
  factory _Cocona.fromJson(Map<String, dynamic> json) => _$CoconaFromJson(json);
  Map<String, dynamic> toJson() => _$CoconaToJson(this);

  _Cocona({
    required this.url,
    required this.url_auto_cancel,
    required this.client_signature,
    required this.debug_zan,
    required this.validFlg_cocona,
  });

  @JsonKey(defaultValue: "https://zz3401gzacts.pos.ppsys.jp/posv2.php?com_key=ZZ3401GZACTS")
  String url;
  @JsonKey(defaultValue: "https://zz3401gzacts.pos.ppsys.jp/posv2extend.php?actionName=TransactionConfirm&com_key=ZZ3401GZACTS")
  String url_auto_cancel;
  @JsonKey(defaultValue: 0)
  int    client_signature;
  @JsonKey(defaultValue: 1000)
  int    debug_zan;
  @JsonKey(defaultValue: 0)
  int    validFlg_cocona;
}

