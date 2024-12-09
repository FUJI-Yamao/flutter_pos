/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'taxfree_chgJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Taxfree_chgJsonFile extends ConfigJsonFile {
  static final Taxfree_chgJsonFile _instance = Taxfree_chgJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "taxfree_chg.json";

  Taxfree_chgJsonFile(){
    setPath(_confPath, _fileName);
  }
  Taxfree_chgJsonFile._internal();

  factory Taxfree_chgJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Taxfree_chgJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Taxfree_chgJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Taxfree_chgJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        reform_date = _$Reform_dateFromJson(jsonD['reform_date']);
      } catch(e) {
        reform_date = _$Reform_dateFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Reform_date reform_date = _Reform_date(
    typ_reform_date                    : "",
    resid_reform_date                  : "",
  );
}

@JsonSerializable()
class _Reform_date {
  factory _Reform_date.fromJson(Map<String, dynamic> json) => _$Reform_dateFromJson(json);
  Map<String, dynamic> toJson() => _$Reform_dateToJson(this);

  _Reform_date({
    required this.typ_reform_date,
    required this.resid_reform_date,
  });

  @JsonKey(defaultValue: "0000-00-00")
  String typ_reform_date;
  @JsonKey(defaultValue: "0000-00-00")
  String resid_reform_date;
}

