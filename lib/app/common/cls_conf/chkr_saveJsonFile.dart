/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'chkr_saveJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Chkr_saveJsonFile extends ConfigJsonFile {
  static final Chkr_saveJsonFile _instance = Chkr_saveJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "chkr_save.json";

  Chkr_saveJsonFile(){
    setPath(_confPath, _fileName);
  }
  Chkr_saveJsonFile._internal();

  factory Chkr_saveJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Chkr_saveJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Chkr_saveJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Chkr_saveJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        loan = _$LoanFromJson(jsonD['loan']);
      } catch(e) {
        loan = _$LoanFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Loan loan = _Loan(
    inout_10000                        : 0,
    inout_5000                         : 0,
    inout_2000                         : 0,
    inout_1000                         : 0,
    inout_500                          : 0,
    inout_100                          : 0,
    inout_50                           : 0,
    inout_10                           : 0,
    inout_5                            : 0,
    inout_1                            : 0,
  );
}

@JsonSerializable()
class _Loan {
  factory _Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);
  Map<String, dynamic> toJson() => _$LoanToJson(this);

  _Loan({
    required this.inout_10000,
    required this.inout_5000,
    required this.inout_2000,
    required this.inout_1000,
    required this.inout_500,
    required this.inout_100,
    required this.inout_50,
    required this.inout_10,
    required this.inout_5,
    required this.inout_1,
  });

  @JsonKey(defaultValue: 0)
  int    inout_10000;
  @JsonKey(defaultValue: 0)
  int    inout_5000;
  @JsonKey(defaultValue: 0)
  int    inout_2000;
  @JsonKey(defaultValue: 0)
  int    inout_1000;
  @JsonKey(defaultValue: 0)
  int    inout_500;
  @JsonKey(defaultValue: 0)
  int    inout_100;
  @JsonKey(defaultValue: 0)
  int    inout_50;
  @JsonKey(defaultValue: 0)
  int    inout_10;
  @JsonKey(defaultValue: 0)
  int    inout_5;
  @JsonKey(defaultValue: 0)
  int    inout_1;
}

