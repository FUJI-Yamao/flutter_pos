/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'meckey_2800JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Meckey_2800JsonFile extends ConfigJsonFile {
  static final Meckey_2800JsonFile _instance = Meckey_2800JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "meckey_2800.json";

  Meckey_2800JsonFile(){
    setPath(_confPath, _fileName);
  }
  Meckey_2800JsonFile._internal();

  factory Meckey_2800JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Meckey_2800JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Meckey_2800JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Meckey_2800JsonFileToJson(this));
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

  @JsonKey(defaultValue: "0x0804")
  String key0;
  @JsonKey(defaultValue: "0x0803")
  String key1;
  @JsonKey(defaultValue: "0x0903")
  String key2;
  @JsonKey(defaultValue: "0x1003")
  String key3;
  @JsonKey(defaultValue: "0x0802")
  String key4;
  @JsonKey(defaultValue: "0x0902")
  String key5;
  @JsonKey(defaultValue: "0x1002")
  String key6;
  @JsonKey(defaultValue: "0x0801")
  String key7;
  @JsonKey(defaultValue: "0x0901")
  String key8;
  @JsonKey(defaultValue: "0x1001")
  String key9;
  @JsonKey(defaultValue: "0x1004")
  String key00;
  @JsonKey(defaultValue: "")
  String key000;
  @JsonKey(defaultValue: "0x1404")
  String RET;
  @JsonKey(defaultValue: "0x0604")
  String CLS;
  @JsonKey(defaultValue: "")
  String FEED;
  @JsonKey(defaultValue: "0x0603")
  String PLU;
  @JsonKey(defaultValue: "0x1204")
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

  @JsonKey(defaultValue: "0x0804")
  String key0;
  @JsonKey(defaultValue: "0x0803")
  String key1;
  @JsonKey(defaultValue: "0x0903")
  String key2;
  @JsonKey(defaultValue: "0x1003")
  String key3;
  @JsonKey(defaultValue: "0x0802")
  String key4;
  @JsonKey(defaultValue: "0x0902")
  String key5;
  @JsonKey(defaultValue: "0x1002")
  String key6;
  @JsonKey(defaultValue: "0x0801")
  String key7;
  @JsonKey(defaultValue: "0x0901")
  String key8;
  @JsonKey(defaultValue: "0x1001")
  String key9;
  @JsonKey(defaultValue: "0x1004")
  String key00;
  @JsonKey(defaultValue: "")
  String key000;
  @JsonKey(defaultValue: "0x1404")
  String RET;
  @JsonKey(defaultValue: "0x0604")
  String CLS;
  @JsonKey(defaultValue: "")
  String FEED;
  @JsonKey(defaultValue: "0x0603")
  String PLU;
  @JsonKey(defaultValue: "0x1204")
  String STL;
}

