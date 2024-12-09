/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'auto_updateJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Auto_updateJsonFile extends ConfigJsonFile {
  static final Auto_updateJsonFile _instance = Auto_updateJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "auto_update.json";

  Auto_updateJsonFile(){
    setPath(_confPath, _fileName);
  }
  Auto_updateJsonFile._internal();

  factory Auto_updateJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Auto_updateJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Auto_updateJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Auto_updateJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        comm = _$CommFromJson(jsonD['comm']);
      } catch(e) {
        comm = _$CommFromJson({});
        ret = false;
      }
      try {
        system = _$SystemFromJson(jsonD['system']);
      } catch(e) {
        system = _$SystemFromJson({});
        ret = false;
      }
      try {
        ver01 = _$Ver01FromJson(jsonD['ver01']);
      } catch(e) {
        ver01 = _$Ver01FromJson({});
        ret = false;
      }
      try {
        ver02 = _$Ver02FromJson(jsonD['ver02']);
      } catch(e) {
        ver02 = _$Ver02FromJson({});
        ret = false;
      }
      try {
        ver03 = _$Ver03FromJson(jsonD['ver03']);
      } catch(e) {
        ver03 = _$Ver03FromJson({});
        ret = false;
      }
      try {
        ver04 = _$Ver04FromJson(jsonD['ver04']);
      } catch(e) {
        ver04 = _$Ver04FromJson({});
        ret = false;
      }
      try {
        ver05 = _$Ver05FromJson(jsonD['ver05']);
      } catch(e) {
        ver05 = _$Ver05FromJson({});
        ret = false;
      }
      try {
        ver06 = _$Ver06FromJson(jsonD['ver06']);
      } catch(e) {
        ver06 = _$Ver06FromJson({});
        ret = false;
      }
      try {
        ver07 = _$Ver07FromJson(jsonD['ver07']);
      } catch(e) {
        ver07 = _$Ver07FromJson({});
        ret = false;
      }
      try {
        result = _$ResultFromJson(jsonD['result']);
      } catch(e) {
        result = _$ResultFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Comm comm = _Comm(
    rest_url                           : "",
    get_result_url                     : "",
    vup_result_url                     : "",
    time_out                           : 0,
    retry                              : 0,
    zhq_rest_url                       : "",
    zhq_get_result_url                 : "",
    zhq_vup_result_url                 : "",
    nxt_rest_ctrl                      : 0,
  );

  _System system = _System(
    system                             : 0,
  );

  _Ver01 ver01 = _Ver01(
    ver01_name                         : 0,
    date01                             : 0,
    updateid01                         : 0,
    power01                            : 0,
  );

  _Ver02 ver02 = _Ver02(
    ver02_name                         : 0,
    date02                             : 0,
    updateid02                         : 0,
    power02                            : 0,
  );

  _Ver03 ver03 = _Ver03(
    ver03_name                         : 0,
    date03                             : 0,
    updateid03                         : 0,
    power03                            : 0,
    stat03                             : 0,
  );

  _Ver04 ver04 = _Ver04(
    ver04_name                         : 0,
    date04                             : 0,
    updateid04                         : 0,
    power04                            : 0,
  );

  _Ver05 ver05 = _Ver05(
    ver05_name                         : 0,
    date05                             : 0,
    updateid05                         : 0,
    power05                            : 0,
  );

  _Ver06 ver06 = _Ver06(
    ver06_name                         : 0,
    date06                             : 0,
    updateid06                         : 0,
    power06                            : 0,
  );

  _Ver07 ver07 = _Ver07(
    ver07_name                         : 0,
    date07                             : 0,
    updateid07                         : 0,
    power07                            : 0,
  );

  _Result result = _Result(
    get01                              : 0,
    get02                              : 0,
    get03                              : 0,
    get04                              : 0,
    get05                              : 0,
    get06                              : 0,
    get07                              : 0,
    file_name                          : 0,
  );
}

@JsonSerializable()
class _Comm {
  factory _Comm.fromJson(Map<String, dynamic> json) => _$CommFromJson(json);
  Map<String, dynamic> toJson() => _$CommToJson(this);

  _Comm({
    required this.rest_url,
    required this.get_result_url,
    required this.vup_result_url,
    required this.time_out,
    required this.retry,
    required this.zhq_rest_url,
    required this.zhq_get_result_url,
    required this.zhq_vup_result_url,
    required this.nxt_rest_ctrl,
  });

  @JsonKey(defaultValue: "http://118.243.93.122/autoupdates?")
  String rest_url;
  @JsonKey(defaultValue: "http://118.243.93.122/getfileresults?")
  String get_result_url;
  @JsonKey(defaultValue: "http://118.243.93.122/updateresults?")
  String vup_result_url;
  @JsonKey(defaultValue: 180)
  int    time_out;
  @JsonKey(defaultValue: 3)
  int    retry;
  @JsonKey(defaultValue: "http://10.147.1.102/autoupdates?")
  String zhq_rest_url;
  @JsonKey(defaultValue: "http://10.147.1.102/getfileresults?")
  String zhq_get_result_url;
  @JsonKey(defaultValue: "http://10.147.1.102/updateresults?")
  String zhq_vup_result_url;
  @JsonKey(defaultValue: 1)
  int    nxt_rest_ctrl;
}

@JsonSerializable()
class _System {
  factory _System.fromJson(Map<String, dynamic> json) => _$SystemFromJson(json);
  Map<String, dynamic> toJson() => _$SystemToJson(this);

  _System({
    required this.system,
  });

  @JsonKey(defaultValue: 0)
  int    system;
}

@JsonSerializable()
class _Ver01 {
  factory _Ver01.fromJson(Map<String, dynamic> json) => _$Ver01FromJson(json);
  Map<String, dynamic> toJson() => _$Ver01ToJson(this);

  _Ver01({
    required this.ver01_name,
    required this.date01,
    required this.updateid01,
    required this.power01,
  });

  @JsonKey(defaultValue: 0)
  int    ver01_name;
  @JsonKey(defaultValue: 0)
  int    date01;
  @JsonKey(defaultValue: 0)
  int    updateid01;
  @JsonKey(defaultValue: 0)
  int    power01;
}

@JsonSerializable()
class _Ver02 {
  factory _Ver02.fromJson(Map<String, dynamic> json) => _$Ver02FromJson(json);
  Map<String, dynamic> toJson() => _$Ver02ToJson(this);

  _Ver02({
    required this.ver02_name,
    required this.date02,
    required this.updateid02,
    required this.power02,
  });

  @JsonKey(defaultValue: 0)
  int    ver02_name;
  @JsonKey(defaultValue: 0)
  int    date02;
  @JsonKey(defaultValue: 0)
  int    updateid02;
  @JsonKey(defaultValue: 0)
  int    power02;
}

@JsonSerializable()
class _Ver03 {
  factory _Ver03.fromJson(Map<String, dynamic> json) => _$Ver03FromJson(json);
  Map<String, dynamic> toJson() => _$Ver03ToJson(this);

  _Ver03({
    required this.ver03_name,
    required this.date03,
    required this.updateid03,
    required this.power03,
    required this.stat03,
  });

  @JsonKey(defaultValue: 0)
  int    ver03_name;
  @JsonKey(defaultValue: 0)
  int    date03;
  @JsonKey(defaultValue: 0)
  int    updateid03;
  @JsonKey(defaultValue: 0)
  int    power03;
  @JsonKey(defaultValue: 0)
  int    stat03;
}

@JsonSerializable()
class _Ver04 {
  factory _Ver04.fromJson(Map<String, dynamic> json) => _$Ver04FromJson(json);
  Map<String, dynamic> toJson() => _$Ver04ToJson(this);

  _Ver04({
    required this.ver04_name,
    required this.date04,
    required this.updateid04,
    required this.power04,
  });

  @JsonKey(defaultValue: 0)
  int    ver04_name;
  @JsonKey(defaultValue: 0)
  int    date04;
  @JsonKey(defaultValue: 0)
  int    updateid04;
  @JsonKey(defaultValue: 0)
  int    power04;
}

@JsonSerializable()
class _Ver05 {
  factory _Ver05.fromJson(Map<String, dynamic> json) => _$Ver05FromJson(json);
  Map<String, dynamic> toJson() => _$Ver05ToJson(this);

  _Ver05({
    required this.ver05_name,
    required this.date05,
    required this.updateid05,
    required this.power05,
  });

  @JsonKey(defaultValue: 0)
  int    ver05_name;
  @JsonKey(defaultValue: 0)
  int    date05;
  @JsonKey(defaultValue: 0)
  int    updateid05;
  @JsonKey(defaultValue: 0)
  int    power05;
}

@JsonSerializable()
class _Ver06 {
  factory _Ver06.fromJson(Map<String, dynamic> json) => _$Ver06FromJson(json);
  Map<String, dynamic> toJson() => _$Ver06ToJson(this);

  _Ver06({
    required this.ver06_name,
    required this.date06,
    required this.updateid06,
    required this.power06,
  });

  @JsonKey(defaultValue: 0)
  int    ver06_name;
  @JsonKey(defaultValue: 0)
  int    date06;
  @JsonKey(defaultValue: 0)
  int    updateid06;
  @JsonKey(defaultValue: 0)
  int    power06;
}

@JsonSerializable()
class _Ver07 {
  factory _Ver07.fromJson(Map<String, dynamic> json) => _$Ver07FromJson(json);
  Map<String, dynamic> toJson() => _$Ver07ToJson(this);

  _Ver07({
    required this.ver07_name,
    required this.date07,
    required this.updateid07,
    required this.power07,
  });

  @JsonKey(defaultValue: 0)
  int    ver07_name;
  @JsonKey(defaultValue: 0)
  int    date07;
  @JsonKey(defaultValue: 0)
  int    updateid07;
  @JsonKey(defaultValue: 0)
  int    power07;
}

@JsonSerializable()
class _Result {
  factory _Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  _Result({
    required this.get01,
    required this.get02,
    required this.get03,
    required this.get04,
    required this.get05,
    required this.get06,
    required this.get07,
    required this.file_name,
  });

  @JsonKey(defaultValue: 0)
  int    get01;
  @JsonKey(defaultValue: 0)
  int    get02;
  @JsonKey(defaultValue: 0)
  int    get03;
  @JsonKey(defaultValue: 0)
  int    get04;
  @JsonKey(defaultValue: 0)
  int    get05;
  @JsonKey(defaultValue: 0)
  int    get06;
  @JsonKey(defaultValue: 0)
  int    get07;
  @JsonKey(defaultValue: 0)
  int    file_name;
}

