/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'mail_senderJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Mail_senderJsonFile extends ConfigJsonFile {
  static final Mail_senderJsonFile _instance = Mail_senderJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "mail_sender.json";

  Mail_senderJsonFile(){
    setPath(_confPath, _fileName);
  }
  Mail_senderJsonFile._internal();

  factory Mail_senderJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Mail_senderJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Mail_senderJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Mail_senderJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        network = _$NetworkFromJson(jsonD['network']);
      } catch(e) {
        network = _$NetworkFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Network network = _Network(
    url                                : "",
    timeout                            : 0,
    api_key                            : "",
    ex_api_key                         : "",
  );
}

@JsonSerializable()
class _Network {
  factory _Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkToJson(this);

  _Network({
    required this.url,
    required this.timeout,
    required this.api_key,
    required this.ex_api_key,
  });

  @JsonKey(defaultValue: "http://")
  String url;
  @JsonKey(defaultValue: 40)
  int    timeout;
  @JsonKey(defaultValue: "none")
  String api_key;
  @JsonKey(defaultValue: "none")
  String ex_api_key;
}

