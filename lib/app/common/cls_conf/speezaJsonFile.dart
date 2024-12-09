/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'speezaJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class SpeezaJsonFile extends ConfigJsonFile {
  static final SpeezaJsonFile _instance = SpeezaJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "speeza.json";

  SpeezaJsonFile(){
    setPath(_confPath, _fileName);
  }
  SpeezaJsonFile._internal();

  factory SpeezaJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$SpeezaJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$SpeezaJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$SpeezaJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        QcSelect = _$QQcSelectFromJson(jsonD['QcSelect']);
      } catch(e) {
        QcSelect = _$QQcSelectFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _QQcSelect QcSelect = _QQcSelect(
    ConMacNo1                          : 0,
    ConMacName1                        : "",
    ConMacNo2                          : 0,
    ConMacName2                        : "",
    ConMacNo3                          : 0,
    ConMacName3                        : "",
    ReceiptPrint                       : 0,
    ConPrint1                          : 0,
    ConPrint2                          : 0,
    ConPrint3                          : 0,
    ConColor1                          : 0,
    ConColor2                          : 0,
    ConColor3                          : 0,
    ConPosi1                           : 0,
    ConPosi2                           : 0,
    ConPosi3                           : 0,
  );
}

@JsonSerializable()
class _QQcSelect {
  factory _QQcSelect.fromJson(Map<String, dynamic> json) => _$QQcSelectFromJson(json);
  Map<String, dynamic> toJson() => _$QQcSelectToJson(this);

  _QQcSelect({
    required this.ConMacNo1,
    required this.ConMacName1,
    required this.ConMacNo2,
    required this.ConMacName2,
    required this.ConMacNo3,
    required this.ConMacName3,
    required this.ReceiptPrint,
    required this.ConPrint1,
    required this.ConPrint2,
    required this.ConPrint3,
    required this.ConColor1,
    required this.ConColor2,
    required this.ConColor3,
    required this.ConPosi1,
    required this.ConPosi2,
    required this.ConPosi3,
  });

  @JsonKey(defaultValue: 0)
  int    ConMacNo1;
  @JsonKey(defaultValue: "")
  String ConMacName1;
  @JsonKey(defaultValue: 0)
  int    ConMacNo2;
  @JsonKey(defaultValue: "")
  String ConMacName2;
  @JsonKey(defaultValue: 0)
  int    ConMacNo3;
  @JsonKey(defaultValue: "")
  String ConMacName3;
  @JsonKey(defaultValue: 0)
  int    ReceiptPrint;
  @JsonKey(defaultValue: 0)
  int    ConPrint1;
  @JsonKey(defaultValue: 0)
  int    ConPrint2;
  @JsonKey(defaultValue: 0)
  int    ConPrint3;
  @JsonKey(defaultValue: 204)
  int    ConColor1;
  @JsonKey(defaultValue: 207)
  int    ConColor2;
  @JsonKey(defaultValue: 209)
  int    ConColor3;
  @JsonKey(defaultValue: 2)
  int    ConPosi1;
  @JsonKey(defaultValue: 1)
  int    ConPosi2;
  @JsonKey(defaultValue: 0)
  int    ConPosi3;
}

