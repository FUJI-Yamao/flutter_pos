/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'pbchg_testJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Pbchg_testJsonFile extends ConfigJsonFile {
  static final Pbchg_testJsonFile _instance = Pbchg_testJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "pbchg_test.json";

  Pbchg_testJsonFile(){
    setPath(_confPath, _fileName);
  }
  Pbchg_testJsonFile._internal();

  factory Pbchg_testJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Pbchg_testJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Pbchg_testJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Pbchg_testJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        system = _$SystemFromJson(jsonD['system']);
      } catch(e) {
        system = _$SystemFromJson({});
        ret = false;
      }
      try {
        balance = _$BalanceFromJson(jsonD['balance']);
      } catch(e) {
        balance = _$BalanceFromJson({});
        ret = false;
      }
      try {
        stre = _$StreFromJson(jsonD['stre']);
      } catch(e) {
        stre = _$StreFromJson({});
        ret = false;
      }
      try {
        corp = _$CorpFromJson(jsonD['corp']);
      } catch(e) {
        corp = _$CorpFromJson({});
        ret = false;
      }
      try {
        corp_result = _$Corp_resultFromJson(jsonD['corp_result']);
      } catch(e) {
        corp_result = _$Corp_resultFromJson({});
        ret = false;
      }
      try {
        ntte = _$NtteFromJson(jsonD['ntte']);
      } catch(e) {
        ntte = _$NtteFromJson({});
        ret = false;
      }
      try {
        receipt = _$ReceiptFromJson(jsonD['receipt']);
      } catch(e) {
        receipt = _$ReceiptFromJson({});
        ret = false;
      }
      try {
        matching = _$MatchingFromJson(jsonD['matching']);
      } catch(e) {
        matching = _$MatchingFromJson({});
        ret = false;
      }
      try {
        check = _$CheckFromJson(jsonD['check']);
      } catch(e) {
        check = _$CheckFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _System system = _System(
    test                               : 0,
  );

  _Balance balance = _Balance(
    amount                             : 0,
    result                             : 0,
  );

  _Stre stre = _Stre(
    result                             : 0,
  );

  _Corp corp = _Corp(
    result                             : 0,
  );

  _Corp_result corp_result = _Corp_result(
    result                             : 0,
  );

  _Ntte ntte = _Ntte(
    result                             : 0,
  );

  _Receipt receipt = _Receipt(
    result                             : 0,
  );

  _Matching matching = _Matching(
    result                             : 0,
  );

  _Check check = _Check(
    result                             : 0,
  );
}

@JsonSerializable()
class _System {
  factory _System.fromJson(Map<String, dynamic> json) => _$SystemFromJson(json);
  Map<String, dynamic> toJson() => _$SystemToJson(this);

  _System({
    required this.test,
  });

  @JsonKey(defaultValue: 0)
  int    test;
}

@JsonSerializable()
class _Balance {
  factory _Balance.fromJson(Map<String, dynamic> json) => _$BalanceFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceToJson(this);

  _Balance({
    required this.amount,
    required this.result,
  });

  @JsonKey(defaultValue: 500000)
  int    amount;
  @JsonKey(defaultValue: 1)
  int    result;
}

@JsonSerializable()
class _Stre {
  factory _Stre.fromJson(Map<String, dynamic> json) => _$StreFromJson(json);
  Map<String, dynamic> toJson() => _$StreToJson(this);

  _Stre({
    required this.result,
  });

  @JsonKey(defaultValue: 1)
  int    result;
}

@JsonSerializable()
class _Corp {
  factory _Corp.fromJson(Map<String, dynamic> json) => _$CorpFromJson(json);
  Map<String, dynamic> toJson() => _$CorpToJson(this);

  _Corp({
    required this.result,
  });

  @JsonKey(defaultValue: 1)
  int    result;
}

@JsonSerializable()
class _Corp_result {
  factory _Corp_result.fromJson(Map<String, dynamic> json) => _$Corp_resultFromJson(json);
  Map<String, dynamic> toJson() => _$Corp_resultToJson(this);

  _Corp_result({
    required this.result,
  });

  @JsonKey(defaultValue: 1)
  int    result;
}

@JsonSerializable()
class _Ntte {
  factory _Ntte.fromJson(Map<String, dynamic> json) => _$NtteFromJson(json);
  Map<String, dynamic> toJson() => _$NtteToJson(this);

  _Ntte({
    required this.result,
  });

  @JsonKey(defaultValue: 1)
  int    result;
}

@JsonSerializable()
class _Receipt {
  factory _Receipt.fromJson(Map<String, dynamic> json) => _$ReceiptFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiptToJson(this);

  _Receipt({
    required this.result,
  });

  @JsonKey(defaultValue: 1)
  int    result;
}

@JsonSerializable()
class _Matching {
  factory _Matching.fromJson(Map<String, dynamic> json) => _$MatchingFromJson(json);
  Map<String, dynamic> toJson() => _$MatchingToJson(this);

  _Matching({
    required this.result,
  });

  @JsonKey(defaultValue: 1)
  int    result;
}

@JsonSerializable()
class _Check {
  factory _Check.fromJson(Map<String, dynamic> json) => _$CheckFromJson(json);
  Map<String, dynamic> toJson() => _$CheckToJson(this);

  _Check({
    required this.result,
  });

  @JsonKey(defaultValue: 1)
  int    result;
}

