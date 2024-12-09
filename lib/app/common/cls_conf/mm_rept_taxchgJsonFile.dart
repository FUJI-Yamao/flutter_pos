/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'mm_rept_taxchgJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Mm_rept_taxchgJsonFile extends ConfigJsonFile {
  static final Mm_rept_taxchgJsonFile _instance = Mm_rept_taxchgJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "mm_rept_taxchg.json";

  Mm_rept_taxchgJsonFile(){
    setPath(_confPath, _fileName);
  }
  Mm_rept_taxchgJsonFile._internal();

  factory Mm_rept_taxchgJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Mm_rept_taxchgJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Mm_rept_taxchgJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Mm_rept_taxchgJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        tax_chg = _$Tax_chgFromJson(jsonD['tax_chg']);
      } catch(e) {
        tax_chg = _$Tax_chgFromJson({});
        ret = false;
      }
      try {
        tax_chage_1 = _$Tax_chage_1FromJson(jsonD['tax_chage_1']);
      } catch(e) {
        tax_chage_1 = _$Tax_chage_1FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Tax_chg tax_chg = _Tax_chg(
    date                               : "",
  );

  _Tax_chage_1 tax_chage_1 = _Tax_chage_1(
    date                               : 0,
  );
}

@JsonSerializable()
class _Tax_chg {
  factory _Tax_chg.fromJson(Map<String, dynamic> json) => _$Tax_chgFromJson(json);
  Map<String, dynamic> toJson() => _$Tax_chgToJson(this);

  _Tax_chg({
    required this.date,
  });

  @JsonKey(defaultValue: "2014-04-01")
  String date;
}

@JsonSerializable()
class _Tax_chage_1 {
  factory _Tax_chage_1.fromJson(Map<String, dynamic> json) => _$Tax_chage_1FromJson(json);
  Map<String, dynamic> toJson() => _$Tax_chage_1ToJson(this);

  _Tax_chage_1({
    required this.date,
  });

  @JsonKey(defaultValue: 20191001)
  int    date;
}

