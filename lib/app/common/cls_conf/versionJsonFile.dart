/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'versionJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class VersionJsonFile extends ConfigJsonFile {
  static final VersionJsonFile _instance = VersionJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "version.json";

  VersionJsonFile(){
    setPath(_confPath, _fileName);
  }
  VersionJsonFile._internal();

  factory VersionJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$VersionJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$VersionJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$VersionJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        version = _$VersionFromJson(jsonD['version']);
      } catch(e) {
        version = _$VersionFromJson({});
        ret = false;
      }
      try {
        apl = _$AplFromJson(jsonD['apl']);
      } catch(e) {
        apl = _$AplFromJson({});
        ret = false;
      }
      try {
        base_db = _$Base_dbFromJson(jsonD['base_db']);
      } catch(e) {
        base_db = _$Base_dbFromJson({});
        ret = false;
      }
      try {
        FSI_apl = _$FFSI_aplFromJson(jsonD['FSI_apl']);
      } catch(e) {
        FSI_apl = _$FFSI_aplFromJson({});
        ret = false;
      }
      try {
        IC_Card = _$IIC_CardFromJson(jsonD['IC_Card']);
      } catch(e) {
        IC_Card = _$IIC_CardFromJson({});
        ret = false;
      }
      try {
        self_data = _$Self_dataFromJson(jsonD['self_data']);
      } catch(e) {
        self_data = _$Self_dataFromJson({});
        ret = false;
      }
      try {
        IC_Card_Multi = _$IIC_Card_MultiFromJson(jsonD['IC_Card_Multi']);
      } catch(e) {
        IC_Card_Multi = _$IIC_Card_MultiFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Version version = _Version(
    max                                : 0,
    section01                          : "",
    section02                          : "",
    section03                          : "",
    section04                          : "",
  );

  _Apl apl = _Apl(
    ver                                : "",
  );

  _Base_db base_db = _Base_db(
    ver                                : "",
  );

  _FFSI_apl FSI_apl = _FFSI_apl(
    ver                                : "",
  );

  _IIC_Card IC_Card = _IIC_Card(
    ver                                : "",
  );

  _Self_data self_data = _Self_data(
    ver                                : "",
  );

  _IIC_Card_Multi IC_Card_Multi = _IIC_Card_Multi(
    ver                                : "",
  );
}

@JsonSerializable()
class _Version {
  factory _Version.fromJson(Map<String, dynamic> json) => _$VersionFromJson(json);
  Map<String, dynamic> toJson() => _$VersionToJson(this);

  _Version({
    required this.max,
    required this.section01,
    required this.section02,
    required this.section03,
    required this.section04,
  });

  @JsonKey(defaultValue: 4)
  int    max;
  @JsonKey(defaultValue: "apl")
  String section01;
  @JsonKey(defaultValue: "base_db")
  String section02;
  @JsonKey(defaultValue: "IC_Card")
  String section03;
  @JsonKey(defaultValue: "IC_Card_Multi")
  String section04;
}

@JsonSerializable()
class _Apl {
  factory _Apl.fromJson(Map<String, dynamic> json) => _$AplFromJson(json);
  Map<String, dynamic> toJson() => _$AplToJson(this);

  _Apl({
    required this.ver,
  });

  @JsonKey(defaultValue: "")
  String ver;
}

@JsonSerializable()
class _Base_db {
  factory _Base_db.fromJson(Map<String, dynamic> json) => _$Base_dbFromJson(json);
  Map<String, dynamic> toJson() => _$Base_dbToJson(this);

  _Base_db({
    required this.ver,
  });

  @JsonKey(defaultValue: "")
  String ver;
}

@JsonSerializable()
class _FFSI_apl {
  factory _FFSI_apl.fromJson(Map<String, dynamic> json) => _$FFSI_aplFromJson(json);
  Map<String, dynamic> toJson() => _$FFSI_aplToJson(this);

  _FFSI_apl({
    required this.ver,
  });

  @JsonKey(defaultValue: "v3.21 2004/04/28 20:00")
  String ver;
}

@JsonSerializable()
class _IIC_Card {
  factory _IIC_Card.fromJson(Map<String, dynamic> json) => _$IIC_CardFromJson(json);
  Map<String, dynamic> toJson() => _$IIC_CardToJson(this);

  _IIC_Card({
    required this.ver,
  });

  @JsonKey(defaultValue: "v2.17")
  String ver;
}

@JsonSerializable()
class _Self_data {
  factory _Self_data.fromJson(Map<String, dynamic> json) => _$Self_dataFromJson(json);
  Map<String, dynamic> toJson() => _$Self_dataToJson(this);

  _Self_data({
    required this.ver,
  });

  @JsonKey(defaultValue: "v2.44")
  String ver;
}

@JsonSerializable()
class _IIC_Card_Multi {
  factory _IIC_Card_Multi.fromJson(Map<String, dynamic> json) => _$IIC_Card_MultiFromJson(json);
  Map<String, dynamic> toJson() => _$IIC_Card_MultiToJson(this);

  _IIC_Card_Multi({
    required this.ver,
  });

  @JsonKey(defaultValue: "vX.XX")
  String ver;
}

