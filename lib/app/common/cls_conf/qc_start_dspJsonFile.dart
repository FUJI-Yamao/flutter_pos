/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'qc_start_dspJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Qc_start_dspJsonFile extends ConfigJsonFile {
  static final Qc_start_dspJsonFile _instance = Qc_start_dspJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "qc_start_dsp.json";

  Qc_start_dspJsonFile(){
    setPath(_confPath, _fileName);
  }
  Qc_start_dspJsonFile._internal();

  factory Qc_start_dspJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Qc_start_dspJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Qc_start_dspJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Qc_start_dspJsonFileToJson(this));
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
      try {
        Private = _$PPrivateFromJson(jsonD['Private']);
      } catch(e) {
        Private = _$PPrivateFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Common common = _Common(
    select_typ                         : 0,
    select_str_msg                     : 0,
  );

  _PPrivate Private = _PPrivate(
    TranReceiveQty                     : 0,
    ChangeChk                          : 0,
  );
}

@JsonSerializable()
class _Common {
  factory _Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);
  Map<String, dynamic> toJson() => _$CommonToJson(this);

  _Common({
    required this.select_typ,
    required this.select_str_msg,
  });

  @JsonKey(defaultValue: 0)
  int    select_typ;
  @JsonKey(defaultValue: 0)
  int    select_str_msg;
}

@JsonSerializable()
class _PPrivate {
  factory _PPrivate.fromJson(Map<String, dynamic> json) => _$PPrivateFromJson(json);
  Map<String, dynamic> toJson() => _$PPrivateToJson(this);

  _PPrivate({
    required this.TranReceiveQty,
    required this.ChangeChk,
  });

  @JsonKey(defaultValue: 0)
  int    TranReceiveQty;
  @JsonKey(defaultValue: 1)
  int    ChangeChk;
}

