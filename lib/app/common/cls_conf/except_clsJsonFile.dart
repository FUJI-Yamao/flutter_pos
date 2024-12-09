/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'except_clsJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Except_clsJsonFile extends ConfigJsonFile {
  static final Except_clsJsonFile _instance = Except_clsJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "except_cls.json";

  Except_clsJsonFile(){
    setPath(_confPath, _fileName);
  }
  Except_clsJsonFile._internal();

  factory Except_clsJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Except_clsJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Except_clsJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Except_clsJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        except_cls = _$Except_clsFromJson(jsonD['except_cls']);
      } catch(e) {
        except_cls = _$Except_clsFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Except_cls except_cls = _Except_cls(
    lrgcls_cd                          : "",
    mdlcls_cd                          : "",
    smlcls_cd                          : "",
  );
}

@JsonSerializable()
class _Except_cls {
  factory _Except_cls.fromJson(Map<String, dynamic> json) => _$Except_clsFromJson(json);
  Map<String, dynamic> toJson() => _$Except_clsToJson(this);

  _Except_cls({
    required this.lrgcls_cd,
    required this.mdlcls_cd,
    required this.smlcls_cd,
  });

  @JsonKey(defaultValue: "")
  String lrgcls_cd;
  @JsonKey(defaultValue: "")
  String mdlcls_cd;
  @JsonKey(defaultValue: "")
  String smlcls_cd;
}

