/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'mbrrealJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class MbrrealJsonFile extends ConfigJsonFile {
  static final MbrrealJsonFile _instance = MbrrealJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "mbrreal.json";

  MbrrealJsonFile(){
    setPath(_confPath, _fileName);
  }
  MbrrealJsonFile._internal();

  factory MbrrealJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$MbrrealJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$MbrrealJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$MbrrealJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        JA = _$JJAFromJson(jsonD['JA']);
      } catch(e) {
        JA = _$JJAFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _JJA JA = _JJA(
    KEN_CD                             : 0,
    JA_CD                              : 0,
    HND_BRCH_CD                        : "",
    KANGEN_KBN                         : 0,
    KANGEN_CD                          : "",
    DTL_CD                             : "",
    BUSINESS_CD                        : 0,
    DEAL_CD                            : 0,
    CND_CD                             : "",
    POINT_PT_CD                        : 0,
    USER_ID                            : "",
    PASSWORD                           : "",
  );
}

@JsonSerializable()
class _JJA {
  factory _JJA.fromJson(Map<String, dynamic> json) => _$JJAFromJson(json);
  Map<String, dynamic> toJson() => _$JJAToJson(this);

  _JJA({
    required this.KEN_CD,
    required this.JA_CD,
    required this.HND_BRCH_CD,
    required this.KANGEN_KBN,
    required this.KANGEN_CD,
    required this.DTL_CD,
    required this.BUSINESS_CD,
    required this.DEAL_CD,
    required this.CND_CD,
    required this.POINT_PT_CD,
    required this.USER_ID,
    required this.PASSWORD,
  });

  @JsonKey(defaultValue: 11)
  int    KEN_CD;
  @JsonKey(defaultValue: 4735)
  int    JA_CD;
  @JsonKey(defaultValue: "0000")
  String HND_BRCH_CD;
  @JsonKey(defaultValue: 5)
  int    KANGEN_KBN;
  @JsonKey(defaultValue: "001")
  String KANGEN_CD;
  @JsonKey(defaultValue: "00001")
  String DTL_CD;
  @JsonKey(defaultValue: 3)
  int    BUSINESS_CD;
  @JsonKey(defaultValue: 101)
  int    DEAL_CD;
  @JsonKey(defaultValue: "000001")
  String CND_CD;
  @JsonKey(defaultValue: 2)
  int    POINT_PT_CD;
  @JsonKey(defaultValue: "")
  String USER_ID;
  @JsonKey(defaultValue: "")
  String PASSWORD;
}

