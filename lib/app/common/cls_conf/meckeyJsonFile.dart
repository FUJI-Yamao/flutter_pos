/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'meckeyJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class MeckeyJsonFile extends ConfigJsonFile {
  static final MeckeyJsonFile _instance = MeckeyJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "meckey.json";

  MeckeyJsonFile(){
    setPath(_confPath, _fileName);
  }
  MeckeyJsonFile._internal();

  factory MeckeyJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$MeckeyJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$MeckeyJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$MeckeyJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        meckey1 = _$Meckey1FromJson(jsonD['meckey1']);
      } catch(e) {
        meckey1 = _$Meckey1FromJson({});
        ret = false;
      }
      try {
        meckey2 = _$Meckey2FromJson(jsonD['meckey2']);
      } catch(e) {
        meckey2 = _$Meckey2FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Meckey1 meckey1 = _Meckey1(
    key0                               : "",
    key1                               : "",
    key2                               : "",
    key3                               : "",
    key4                               : "",
    key5                               : "",
    key6                               : "",
    key7                               : "",
    key8                               : "",
    key9                               : "",
    key00                              : "",
    key000                             : "",
    RET                                : "",
    CLS                                : "",
    FEED                               : "",
    PLU                                : "",
    STL                                : "",
  );

  _Meckey2 meckey2 = _Meckey2(
    key0                               : "",
    key1                               : "",
    key2                               : "",
    key3                               : "",
    key4                               : "",
    key5                               : "",
    key6                               : "",
    key7                               : "",
    key8                               : "",
    key9                               : "",
    key00                              : "",
    key000                             : "",
    RET                                : "",
    CLS                                : "",
    FEED                               : "",
    PLU                                : "",
    STL                                : "",
  );
}

@JsonSerializable()
class _Meckey1 {
  factory _Meckey1.fromJson(Map<String, dynamic> json) => _$Meckey1FromJson(json);
  Map<String, dynamic> toJson() => _$Meckey1ToJson(this);

  _Meckey1({
    required this.key0,
    required this.key1,
    required this.key2,
    required this.key3,
    required this.key4,
    required this.key5,
    required this.key6,
    required this.key7,
    required this.key8,
    required this.key9,
    required this.key00,
    required this.key000,
    required this.RET,
    required this.CLS,
    required this.FEED,
    required this.PLU,
    required this.STL,
  });

  @JsonKey(defaultValue: "0x1640")
  String key0;
  @JsonKey(defaultValue: "0x1610")
  String key1;
  @JsonKey(defaultValue: "0x1020")
  String key2;
  @JsonKey(defaultValue: "0x1120")
  String key3;
  @JsonKey(defaultValue: "0x1604")
  String key4;
  @JsonKey(defaultValue: "0x1008")
  String key5;
  @JsonKey(defaultValue: "0x1108")
  String key6;
  @JsonKey(defaultValue: "0x1601")
  String key7;
  @JsonKey(defaultValue: "0x1002")
  String key8;
  @JsonKey(defaultValue: "0x1102")
  String key9;
  @JsonKey(defaultValue: "0x1180")
  String key00;
  @JsonKey(defaultValue: "")
  String key000;
  @JsonKey(defaultValue: "0x1580")
  String RET;
  @JsonKey(defaultValue: "0x1440")
  String CLS;
  @JsonKey(defaultValue: "0x1004")
  String FEED;
  @JsonKey(defaultValue: "0x1320")
  String PLU;
  @JsonKey(defaultValue: "0x1380")
  String STL;
}

@JsonSerializable()
class _Meckey2 {
  factory _Meckey2.fromJson(Map<String, dynamic> json) => _$Meckey2FromJson(json);
  Map<String, dynamic> toJson() => _$Meckey2ToJson(this);

  _Meckey2({
    required this.key0,
    required this.key1,
    required this.key2,
    required this.key3,
    required this.key4,
    required this.key5,
    required this.key6,
    required this.key7,
    required this.key8,
    required this.key9,
    required this.key00,
    required this.key000,
    required this.RET,
    required this.CLS,
    required this.FEED,
    required this.PLU,
    required this.STL,
  });

  @JsonKey(defaultValue: "0x1004")
  String key0;
  @JsonKey(defaultValue: "0x1002")
  String key1;
  @JsonKey(defaultValue: "0x1102")
  String key2;
  @JsonKey(defaultValue: "0x1202")
  String key3;
  @JsonKey(defaultValue: "0x1001")
  String key4;
  @JsonKey(defaultValue: "0x1101")
  String key5;
  @JsonKey(defaultValue: "0x1201")
  String key6;
  @JsonKey(defaultValue: "0x1020")
  String key7;
  @JsonKey(defaultValue: "0x1120")
  String key8;
  @JsonKey(defaultValue: "0x1220")
  String key9;
  @JsonKey(defaultValue: "0x1204")
  String key00;
  @JsonKey(defaultValue: "")
  String key000;
  @JsonKey(defaultValue: "0x1304")
  String RET;
  @JsonKey(defaultValue: "0x1040")
  String CLS;
  @JsonKey(defaultValue: "")
  String FEED;
  @JsonKey(defaultValue: "0x1320")
  String PLU;
  @JsonKey(defaultValue: "0x1302")
  String STL;
}

