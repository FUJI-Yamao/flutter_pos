/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'gcat_timerJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Gcat_timerJsonFile extends ConfigJsonFile {
  static final Gcat_timerJsonFile _instance = Gcat_timerJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "gcat_timer.json";

  Gcat_timerJsonFile(){
    setPath(_confPath, _fileName);
  }
  Gcat_timerJsonFile._internal();

  factory Gcat_timerJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Gcat_timerJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Gcat_timerJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Gcat_timerJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        cat_timer = _$Cat_timerFromJson(jsonD['cat_timer']);
      } catch(e) {
        cat_timer = _$Cat_timerFromJson({});
        ret = false;
      }
      try {
        cct_timer = _$Cct_timerFromJson(jsonD['cct_timer']);
      } catch(e) {
        cct_timer = _$Cct_timerFromJson({});
        ret = false;
      }
      try {
        mst_timer = _$Mst_timerFromJson(jsonD['mst_timer']);
      } catch(e) {
        mst_timer = _$Mst_timerFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Cat_timer cat_timer = _Cat_timer(
    cat_stat_timer                     : 0,
    cat_recv_timer                     : 0,
  );

  _Cct_timer cct_timer = _Cct_timer(
    cct_rcv_timer                      : 0,
  );

  _Mst_timer mst_timer = _Mst_timer(
    mst_rcv_timer                      : 0,
  );
}

@JsonSerializable()
class _Cat_timer {
  factory _Cat_timer.fromJson(Map<String, dynamic> json) => _$Cat_timerFromJson(json);
  Map<String, dynamic> toJson() => _$Cat_timerToJson(this);

  _Cat_timer({
    required this.cat_stat_timer,
    required this.cat_recv_timer,
  });

  @JsonKey(defaultValue: 600)
  int    cat_stat_timer;
  @JsonKey(defaultValue: 3000)
  int    cat_recv_timer;
}

@JsonSerializable()
class _Cct_timer {
  factory _Cct_timer.fromJson(Map<String, dynamic> json) => _$Cct_timerFromJson(json);
  Map<String, dynamic> toJson() => _$Cct_timerToJson(this);

  _Cct_timer({
    required this.cct_rcv_timer,
  });

  @JsonKey(defaultValue: 240000)
  int    cct_rcv_timer;
}

@JsonSerializable()
class _Mst_timer {
  factory _Mst_timer.fromJson(Map<String, dynamic> json) => _$Mst_timerFromJson(json);
  Map<String, dynamic> toJson() => _$Mst_timerToJson(this);

  _Mst_timer({
    required this.mst_rcv_timer,
  });

  @JsonKey(defaultValue: 180000)
  int    mst_rcv_timer;
}

