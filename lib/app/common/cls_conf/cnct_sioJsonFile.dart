/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'cnct_sioJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Cnct_sioJsonFile extends ConfigJsonFile {
  static final Cnct_sioJsonFile _instance = Cnct_sioJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "cnct_sio.json";

  Cnct_sioJsonFile(){
    setPath(_confPath, _fileName);
  }
  Cnct_sioJsonFile._internal();

  factory Cnct_sioJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Cnct_sioJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Cnct_sioJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Cnct_sioJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        sio1 = _$Sio1FromJson(jsonD['sio1']);
      } catch(e) {
        sio1 = _$Sio1FromJson({});
        ret = false;
      }
      try {
        sio2 = _$Sio2FromJson(jsonD['sio2']);
      } catch(e) {
        sio2 = _$Sio2FromJson({});
        ret = false;
      }
      try {
        sio3 = _$Sio3FromJson(jsonD['sio3']);
      } catch(e) {
        sio3 = _$Sio3FromJson({});
        ret = false;
      }
      try {
        sio4 = _$Sio4FromJson(jsonD['sio4']);
      } catch(e) {
        sio4 = _$Sio4FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Sio1 sio1 = _Sio1(
    qcjc_typ                           : 0,
  );

  _Sio2 sio2 = _Sio2(
    qcjc_typ                           : 0,
  );

  _Sio3 sio3 = _Sio3(
    qcjc_typ                           : 0,
  );

  _Sio4 sio4 = _Sio4(
    qcjc_typ                           : 0,
  );
}

@JsonSerializable()
class _Sio1 {
  factory _Sio1.fromJson(Map<String, dynamic> json) => _$Sio1FromJson(json);
  Map<String, dynamic> toJson() => _$Sio1ToJson(this);

  _Sio1({
    required this.qcjc_typ,
  });

  @JsonKey(defaultValue: 0)
  int    qcjc_typ;
}

@JsonSerializable()
class _Sio2 {
  factory _Sio2.fromJson(Map<String, dynamic> json) => _$Sio2FromJson(json);
  Map<String, dynamic> toJson() => _$Sio2ToJson(this);

  _Sio2({
    required this.qcjc_typ,
  });

  @JsonKey(defaultValue: 0)
  int    qcjc_typ;
}

@JsonSerializable()
class _Sio3 {
  factory _Sio3.fromJson(Map<String, dynamic> json) => _$Sio3FromJson(json);
  Map<String, dynamic> toJson() => _$Sio3ToJson(this);

  _Sio3({
    required this.qcjc_typ,
  });

  @JsonKey(defaultValue: 0)
  int    qcjc_typ;
}

@JsonSerializable()
class _Sio4 {
  factory _Sio4.fromJson(Map<String, dynamic> json) => _$Sio4FromJson(json);
  Map<String, dynamic> toJson() => _$Sio4ToJson(this);

  _Sio4({
    required this.qcjc_typ,
  });

  @JsonKey(defaultValue: 0)
  int    qcjc_typ;
}

