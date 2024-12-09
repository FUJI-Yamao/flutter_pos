/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'boot_testJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Boot_testJsonFile extends ConfigJsonFile {
  static final Boot_testJsonFile _instance = Boot_testJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "boot_test.json";

  Boot_testJsonFile(){
    setPath(_confPath, _fileName);
  }
  Boot_testJsonFile._internal();

  factory Boot_testJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Boot_testJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Boot_testJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Boot_testJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        boot_test = _$Boot_testFromJson(jsonD['boot_test']);
      } catch(e) {
        boot_test = _$Boot_testFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Boot_test boot_test = _Boot_test(
    boot_test                          : 0,
    test_count_max                     : 0,
    test_count                         : 0,
    usb_mem_ng_count                   : 0,
    usb_con_ng_count                   : 0,
  );
}

@JsonSerializable()
class _Boot_test {
  factory _Boot_test.fromJson(Map<String, dynamic> json) => _$Boot_testFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_testToJson(this);

  _Boot_test({
    required this.boot_test,
    required this.test_count_max,
    required this.test_count,
    required this.usb_mem_ng_count,
    required this.usb_con_ng_count,
  });

  @JsonKey(defaultValue: 0)
  int    boot_test;
  @JsonKey(defaultValue: 0)
  int    test_count_max;
  @JsonKey(defaultValue: 0)
  int    test_count;
  @JsonKey(defaultValue: 0)
  int    usb_mem_ng_count;
  @JsonKey(defaultValue: 0)
  int    usb_con_ng_count;
}

