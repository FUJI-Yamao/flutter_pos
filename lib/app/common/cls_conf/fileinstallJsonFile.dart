/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'fileinstallJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class FileinstallJsonFile extends ConfigJsonFile {
  static final FileinstallJsonFile _instance = FileinstallJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "fileinstall.json";

  FileinstallJsonFile(){
    setPath(_confPath, _fileName);
  }
  FileinstallJsonFile._internal();

  factory FileinstallJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$FileinstallJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$FileinstallJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$FileinstallJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        info = _$InfoFromJson(jsonD['info']);
      } catch(e) {
        info = _$InfoFromJson({});
        ret = false;
      }
      try {
        file1 = _$File1FromJson(jsonD['file1']);
      } catch(e) {
        file1 = _$File1FromJson({});
        ret = false;
      }
      try {
        file2 = _$File2FromJson(jsonD['file2']);
      } catch(e) {
        file2 = _$File2FromJson({});
        ret = false;
      }
      try {
        file3 = _$File3FromJson(jsonD['file3']);
      } catch(e) {
        file3 = _$File3FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Info info = _Info(
    field_max                          : 0,
  );

  _File1 file1 = _File1(
    name                               : "",
    place                              : "",
  );

  _File2 file2 = _File2(
    name                               : "",
    place                              : "",
  );

  _File3 file3 = _File3(
    name                               : "",
    place                              : "",
  );
}

@JsonSerializable()
class _Info {
  factory _Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);

  _Info({
    required this.field_max,
  });

  @JsonKey(defaultValue: 3)
  int    field_max;
}

@JsonSerializable()
class _File1 {
  factory _File1.fromJson(Map<String, dynamic> json) => _$File1FromJson(json);
  Map<String, dynamic> toJson() => _$File1ToJson(this);

  _File1({
    required this.name,
    required this.place,
  });

  @JsonKey(defaultValue: "CANALPAY_LCL_RSA_PRIKEY.pem")
  String name;
  @JsonKey(defaultValue: "conf")
  String place;
}

@JsonSerializable()
class _File2 {
  factory _File2.fromJson(Map<String, dynamic> json) => _$File2FromJson(json);
  Map<String, dynamic> toJson() => _$File2ToJson(this);

  _File2({
    required this.name,
    required this.place,
  });

  @JsonKey(defaultValue: "CANALPAY_LCL_RSA_PUBKEY.pem")
  String name;
  @JsonKey(defaultValue: "conf")
  String place;
}

@JsonSerializable()
class _File3 {
  factory _File3.fromJson(Map<String, dynamic> json) => _$File3FromJson(json);
  Map<String, dynamic> toJson() => _$File3ToJson(this);

  _File3({
    required this.name,
    required this.place,
  });

  @JsonKey(defaultValue: "CANALPAY_SRV_RSA_PUBKEY.pem")
  String name;
  @JsonKey(defaultValue: "conf")
  String place;
}

