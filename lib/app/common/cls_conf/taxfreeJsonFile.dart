/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'taxfreeJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class TaxfreeJsonFile extends ConfigJsonFile {
  static final TaxfreeJsonFile _instance = TaxfreeJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "taxfree.json";

  TaxfreeJsonFile(){
    setPath(_confPath, _fileName);
  }
  TaxfreeJsonFile._internal();

  factory TaxfreeJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$TaxfreeJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$TaxfreeJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$TaxfreeJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        term_info = _$Term_infoFromJson(jsonD['term_info']);
      } catch(e) {
        term_info = _$Term_infoFromJson({});
        ret = false;
      }
      try {
        term_info_demo = _$Term_info_demoFromJson(jsonD['term_info_demo']);
      } catch(e) {
        term_info_demo = _$Term_info_demoFromJson({});
        ret = false;
      }
      try {
        url_info = _$Url_infoFromJson(jsonD['url_info']);
      } catch(e) {
        url_info = _$Url_infoFromJson({});
        ret = false;
      }
      try {
        data = _$DataFromJson(jsonD['data']);
      } catch(e) {
        data = _$DataFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Term_info term_info = _Term_info(
    corp_code                          : 0,
    shop_code                          : 0,
    licence_key                        : "",
    licence_get                        : "",
    master_get                         : "",
    country_get                        : "",
    term_code                          : "",
  );

  _Term_info_demo term_info_demo = _Term_info_demo(
    corp_code                          : 0,
    shop_code                          : 0,
    licence_key                        : "",
    licence_get                        : "",
    term_code                          : "",
  );

  _Url_info url_info = _Url_info(
    server_typ                         : 0,
    url_business                       : "",
    url_demo                           : "",
    timeout                            : 0,
  );

  _Data data = _Data(
    keep_day                           : 0,
  );
}

@JsonSerializable()
class _Term_info {
  factory _Term_info.fromJson(Map<String, dynamic> json) => _$Term_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Term_infoToJson(this);

  _Term_info({
    required this.corp_code,
    required this.shop_code,
    required this.licence_key,
    required this.licence_get,
    required this.master_get,
    required this.country_get,
    required this.term_code,
  });

  @JsonKey(defaultValue: 1)
  int    corp_code;
  @JsonKey(defaultValue: 1)
  int    shop_code;
  @JsonKey(defaultValue: "")
  String licence_key;
  @JsonKey(defaultValue: "")
  String licence_get;
  @JsonKey(defaultValue: "")
  String master_get;
  @JsonKey(defaultValue: "")
  String country_get;
  @JsonKey(defaultValue: "")
  String term_code;
}

@JsonSerializable()
class _Term_info_demo {
  factory _Term_info_demo.fromJson(Map<String, dynamic> json) => _$Term_info_demoFromJson(json);
  Map<String, dynamic> toJson() => _$Term_info_demoToJson(this);

  _Term_info_demo({
    required this.corp_code,
    required this.shop_code,
    required this.licence_key,
    required this.licence_get,
    required this.term_code,
  });

  @JsonKey(defaultValue: 855)
  int    corp_code;
  @JsonKey(defaultValue: 1)
  int    shop_code;
  @JsonKey(defaultValue: "vd3href2dz4s")
  String licence_key;
  @JsonKey(defaultValue: "")
  String licence_get;
  @JsonKey(defaultValue: "")
  String term_code;
}

@JsonSerializable()
class _Url_info {
  factory _Url_info.fromJson(Map<String, dynamic> json) => _$Url_infoFromJson(json);
  Map<String, dynamic> toJson() => _$Url_infoToJson(this);

  _Url_info({
    required this.server_typ,
    required this.url_business,
    required this.url_demo,
    required this.timeout,
  });

  @JsonKey(defaultValue: 0)
  int    server_typ;
  @JsonKey(defaultValue: "https://j-taxfree.com/ceapi/")
  String url_business;
  @JsonKey(defaultValue: "https://japantaxfree.com/ceapi/")
  String url_demo;
  @JsonKey(defaultValue: 10)
  int    timeout;
}

@JsonSerializable()
class _Data {
  factory _Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  _Data({
    required this.keep_day,
  });

  @JsonKey(defaultValue: 7)
  int    keep_day;
}

