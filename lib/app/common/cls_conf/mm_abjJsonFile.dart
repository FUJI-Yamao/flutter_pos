/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'mm_abjJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Mm_abjJsonFile extends ConfigJsonFile {
  static final Mm_abjJsonFile _instance = Mm_abjJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "mm_abj.json";

  Mm_abjJsonFile(){
    setPath(_confPath, _fileName);
  }
  Mm_abjJsonFile._internal();

  factory Mm_abjJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Mm_abjJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Mm_abjJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Mm_abjJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        now = _$NowFromJson(jsonD['now']);
      } catch(e) {
        now = _$NowFromJson({});
        ret = false;
      }
      try {
        bkup = _$BkupFromJson(jsonD['bkup']);
      } catch(e) {
        bkup = _$BkupFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Now now = _Now(
    now_exe_date                       : "",
    now_rcpt_no                        : 0,
    now_sale_date                      : "",
  );

  _Bkup bkup = _Bkup(
    bkup_exe_date                      : "",
    bkup_rcpt_no                       : 0,
    bkup_sale_date                     : "",
  );
}

@JsonSerializable()
class _Now {
  factory _Now.fromJson(Map<String, dynamic> json) => _$NowFromJson(json);
  Map<String, dynamic> toJson() => _$NowToJson(this);

  _Now({
    required this.now_exe_date,
    required this.now_rcpt_no,
    required this.now_sale_date,
  });

  @JsonKey(defaultValue: "0000-00-00 00:00:00")
  String now_exe_date;
  @JsonKey(defaultValue: 0)
  int    now_rcpt_no;
  @JsonKey(defaultValue: "0000-00-00")
  String now_sale_date;
}

@JsonSerializable()
class _Bkup {
  factory _Bkup.fromJson(Map<String, dynamic> json) => _$BkupFromJson(json);
  Map<String, dynamic> toJson() => _$BkupToJson(this);

  _Bkup({
    required this.bkup_exe_date,
    required this.bkup_rcpt_no,
    required this.bkup_sale_date,
  });

  @JsonKey(defaultValue: "0000-00-00 00:00:00")
  String bkup_exe_date;
  @JsonKey(defaultValue: 0)
  int    bkup_rcpt_no;
  @JsonKey(defaultValue: "0000-00-00")
  String bkup_sale_date;
}

