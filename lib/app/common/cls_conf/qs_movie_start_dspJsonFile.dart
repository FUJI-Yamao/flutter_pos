/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'qs_movie_start_dspJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Qs_movie_start_dspJsonFile extends ConfigJsonFile {
  static final Qs_movie_start_dspJsonFile _instance = Qs_movie_start_dspJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "qs_movie_start_dsp.json";

  Qs_movie_start_dspJsonFile(){
    setPath(_confPath, _fileName);
  }
  Qs_movie_start_dspJsonFile._internal();

  factory Qs_movie_start_dspJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Qs_movie_start_dspJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Qs_movie_start_dspJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Qs_movie_start_dspJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        common = _$CommonFromJson(jsonD['common']);
      } catch(e) {
        common = _$CommonFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Common common = _Common(
    brand_typ                          : 0,
    logo_typ                           : 0,
  );
}

@JsonSerializable()
class _Common {
  factory _Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);
  Map<String, dynamic> toJson() => _$CommonToJson(this);

  _Common({
    required this.brand_typ,
    required this.logo_typ,
  });

  @JsonKey(defaultValue: 0)
  int    brand_typ;
  @JsonKey(defaultValue: 0)
  int    logo_typ;
}

