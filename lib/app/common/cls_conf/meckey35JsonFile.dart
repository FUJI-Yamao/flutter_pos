/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'meckey35JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Meckey35JsonFile extends ConfigJsonFile {
  static final Meckey35JsonFile _instance = Meckey35JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "meckey35.json";

  Meckey35JsonFile(){
    setPath(_confPath, _fileName);
  }
  Meckey35JsonFile._internal();

  factory Meckey35JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Meckey35JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Meckey35JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Meckey35JsonFileToJson(this));
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

  @JsonKey(defaultValue: "0x0107")
  String key0;
  @JsonKey(defaultValue: "0x0106")
  String key1;
  @JsonKey(defaultValue: "0x0206")
  String key2;
  @JsonKey(defaultValue: "0x0306")
  String key3;
  @JsonKey(defaultValue: "0x0105")
  String key4;
  @JsonKey(defaultValue: "0x0205")
  String key5;
  @JsonKey(defaultValue: "0x0305")
  String key6;
  @JsonKey(defaultValue: "0x0104")
  String key7;
  @JsonKey(defaultValue: "0x0204")
  String key8;
  @JsonKey(defaultValue: "0x0304")
  String key9;
  @JsonKey(defaultValue: "0x0307")
  String key00;
  @JsonKey(defaultValue: "")
  String key000;
  @JsonKey(defaultValue: "0x0507")
  String RET;
  @JsonKey(defaultValue: "0x0103")
  String CLS;
  @JsonKey(defaultValue: "")
  String FEED;
  @JsonKey(defaultValue: "")
  String PLU;
  @JsonKey(defaultValue: "0x0405")
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

  @JsonKey(defaultValue: "0x0107")
  String key0;
  @JsonKey(defaultValue: "0x0106")
  String key1;
  @JsonKey(defaultValue: "0x0206")
  String key2;
  @JsonKey(defaultValue: "0x0306")
  String key3;
  @JsonKey(defaultValue: "0x0105")
  String key4;
  @JsonKey(defaultValue: "0x0205")
  String key5;
  @JsonKey(defaultValue: "0x0305")
  String key6;
  @JsonKey(defaultValue: "0x0104")
  String key7;
  @JsonKey(defaultValue: "0x0204")
  String key8;
  @JsonKey(defaultValue: "0x0304")
  String key9;
  @JsonKey(defaultValue: "0x0307")
  String key00;
  @JsonKey(defaultValue: "")
  String key000;
  @JsonKey(defaultValue: "0x0507")
  String RET;
  @JsonKey(defaultValue: "0x0103")
  String CLS;
  @JsonKey(defaultValue: "")
  String FEED;
  @JsonKey(defaultValue: "")
  String PLU;
  @JsonKey(defaultValue: "0x0405")
  String STL;
}

