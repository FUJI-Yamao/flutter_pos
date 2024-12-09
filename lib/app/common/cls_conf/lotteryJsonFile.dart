/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'lotteryJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class LotteryJsonFile extends ConfigJsonFile {
  static final LotteryJsonFile _instance = LotteryJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "lottery.json";

  LotteryJsonFile(){
    setPath(_confPath, _fileName);
  }
  LotteryJsonFile._internal();

  factory LotteryJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$LotteryJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$LotteryJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$LotteryJsonFileToJson(this));
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
    lottery_assist_amt                 : 0,
    lottery_assist_cnt                 : 0,
  );
}

@JsonSerializable()
class _Common {
  factory _Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);
  Map<String, dynamic> toJson() => _$CommonToJson(this);

  _Common({
    required this.lottery_assist_amt,
    required this.lottery_assist_cnt,
  });

  @JsonKey(defaultValue: 300)
  int    lottery_assist_amt;
  @JsonKey(defaultValue: 10)
  int    lottery_assist_cnt;
}

