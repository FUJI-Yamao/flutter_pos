/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'custreal_pt_dumJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Custreal_pt_dumJsonFile extends ConfigJsonFile {
  static final Custreal_pt_dumJsonFile _instance = Custreal_pt_dumJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "custreal_pt_dum.json";

  Custreal_pt_dumJsonFile(){
    setPath(_confPath, _fileName);
  }
  Custreal_pt_dumJsonFile._internal();

  factory Custreal_pt_dumJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Custreal_pt_dumJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Custreal_pt_dumJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Custreal_pt_dumJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        pts = _$PtsFromJson(jsonD['pts']);
      } catch(e) {
        pts = _$PtsFromJson({});
        ret = false;
      }
      try {
        enq = _$EnqFromJson(jsonD['enq']);
      } catch(e) {
        enq = _$EnqFromJson({});
        ret = false;
      }
      try {
        exc = _$ExcFromJson(jsonD['exc']);
      } catch(e) {
        exc = _$ExcFromJson({});
        ret = false;
      }
      try {
        exc_vd = _$Exc_vdFromJson(jsonD['exc_vd']);
      } catch(e) {
        exc_vd = _$Exc_vdFromJson({});
        ret = false;
      }
      try {
        add = _$AddFromJson(jsonD['add']);
      } catch(e) {
        add = _$AddFromJson({});
        ret = false;
      }
      try {
        add_vd = _$Add_vdFromJson(jsonD['add_vd']);
      } catch(e) {
        add_vd = _$Add_vdFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Pts pts = _Pts(
    pts                                : 0,
  );

  _Enq enq = _Enq(
    rt                                 : "",
    offl                               : 0,
  );

  _Exc exc = _Exc(
    rt                                 : "",
    offl                               : 0,
  );

  _Exc_vd exc_vd = _Exc_vd(
    rt                                 : "",
    offl                               : 0,
  );

  _Add add = _Add(
    rt                                 : "",
    offl                               : 0,
  );

  _Add_vd add_vd = _Add_vd(
    rt                                 : "",
    offl                               : 0,
  );
}

@JsonSerializable()
class _Pts {
  factory _Pts.fromJson(Map<String, dynamic> json) => _$PtsFromJson(json);
  Map<String, dynamic> toJson() => _$PtsToJson(this);

  _Pts({
    required this.pts,
  });

  @JsonKey(defaultValue: 10000)
  int    pts;
}

@JsonSerializable()
class _Enq {
  factory _Enq.fromJson(Map<String, dynamic> json) => _$EnqFromJson(json);
  Map<String, dynamic> toJson() => _$EnqToJson(this);

  _Enq({
    required this.rt,
    required this.offl,
  });

  @JsonKey(defaultValue: "0000")
  String rt;
  @JsonKey(defaultValue: 0)
  int    offl;
}

@JsonSerializable()
class _Exc {
  factory _Exc.fromJson(Map<String, dynamic> json) => _$ExcFromJson(json);
  Map<String, dynamic> toJson() => _$ExcToJson(this);

  _Exc({
    required this.rt,
    required this.offl,
  });

  @JsonKey(defaultValue: "0000")
  String rt;
  @JsonKey(defaultValue: 0)
  int    offl;
}

@JsonSerializable()
class _Exc_vd {
  factory _Exc_vd.fromJson(Map<String, dynamic> json) => _$Exc_vdFromJson(json);
  Map<String, dynamic> toJson() => _$Exc_vdToJson(this);

  _Exc_vd({
    required this.rt,
    required this.offl,
  });

  @JsonKey(defaultValue: "0000")
  String rt;
  @JsonKey(defaultValue: 0)
  int    offl;
}

@JsonSerializable()
class _Add {
  factory _Add.fromJson(Map<String, dynamic> json) => _$AddFromJson(json);
  Map<String, dynamic> toJson() => _$AddToJson(this);

  _Add({
    required this.rt,
    required this.offl,
  });

  @JsonKey(defaultValue: "0000")
  String rt;
  @JsonKey(defaultValue: 0)
  int    offl;
}

@JsonSerializable()
class _Add_vd {
  factory _Add_vd.fromJson(Map<String, dynamic> json) => _$Add_vdFromJson(json);
  Map<String, dynamic> toJson() => _$Add_vdToJson(this);

  _Add_vd({
    required this.rt,
    required this.offl,
  });

  @JsonKey(defaultValue: "0000")
  String rt;
  @JsonKey(defaultValue: 0)
  int    offl;
}

