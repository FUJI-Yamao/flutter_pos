/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'apl2JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Apl2JsonFile extends ConfigJsonFile {
  static final Apl2JsonFile _instance = Apl2JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "apl2.json";

  Apl2JsonFile(){
    setPath(_confPath, _fileName);
  }
  Apl2JsonFile._internal();

  factory Apl2JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Apl2JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Apl2JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Apl2JsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        boot = _$BootFromJson(jsonD['boot']);
      } catch(e) {
        boot = _$BootFromJson({});
        ret = false;
      }
      try {
        boot_dual = _$Boot_dualFromJson(jsonD['boot_dual']);
      } catch(e) {
        boot_dual = _$Boot_dualFromJson({});
        ret = false;
      }
      try {
        apl1 = _$Apl1FromJson(jsonD['apl1']);
      } catch(e) {
        apl1 = _$Apl1FromJson({});
        ret = false;
      }
      try {
        apl2 = _$Apl2FromJson(jsonD['apl2']);
      } catch(e) {
        apl2 = _$Apl2FromJson({});
        ret = false;
      }
      try {
        apl3 = _$Apl3FromJson(jsonD['apl3']);
      } catch(e) {
        apl3 = _$Apl3FromJson({});
        ret = false;
      }
      try {
        apl4 = _$Apl4FromJson(jsonD['apl4']);
      } catch(e) {
        apl4 = _$Apl4FromJson({});
        ret = false;
      }
      try {
        apl5 = _$Apl5FromJson(jsonD['apl5']);
      } catch(e) {
        apl5 = _$Apl5FromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Boot boot = _Boot(
    tasks01                            : "",
    tasks02                            : "",
    tasks03                            : "",
    tasks04                            : "",
  );

  _Boot_dual boot_dual = _Boot_dual(
    tasks01                            : "",
    tasks02                            : "",
    tasks03                            : "",
    tasks04                            : "",
    tasks05                            : "",
  );

  _Apl1 apl1 = _Apl1(
    entry                              : "",
  );

  _Apl2 apl2 = _Apl2(
    entry                              : "",
  );

  _Apl3 apl3 = _Apl3(
    entry                              : "",
  );

  _Apl4 apl4 = _Apl4(
    entry                              : "",
  );

  _Apl5 apl5 = _Apl5(
    entry                              : "",
  );
}

@JsonSerializable()
class _Boot {
  factory _Boot.fromJson(Map<String, dynamic> json) => _$BootFromJson(json);
  Map<String, dynamic> toJson() => _$BootToJson(this);

  _Boot({
    required this.tasks01,
    required this.tasks02,
    required this.tasks03,
    required this.tasks04,
  });

  @JsonKey(defaultValue: "apl1")
  String tasks01;
  @JsonKey(defaultValue: "apl2")
  String tasks02;
  @JsonKey(defaultValue: "apl3")
  String tasks03;
  @JsonKey(defaultValue: "apl4")
  String tasks04;
}

@JsonSerializable()
class _Boot_dual {
  factory _Boot_dual.fromJson(Map<String, dynamic> json) => _$Boot_dualFromJson(json);
  Map<String, dynamic> toJson() => _$Boot_dualToJson(this);

  _Boot_dual({
    required this.tasks01,
    required this.tasks02,
    required this.tasks03,
    required this.tasks04,
    required this.tasks05,
  });

  @JsonKey(defaultValue: "apl1")
  String tasks01;
  @JsonKey(defaultValue: "apl2")
  String tasks02;
  @JsonKey(defaultValue: "apl3")
  String tasks03;
  @JsonKey(defaultValue: "apl4")
  String tasks04;
  @JsonKey(defaultValue: "apl5")
  String tasks05;
}

@JsonSerializable()
class _Apl1 {
  factory _Apl1.fromJson(Map<String, dynamic> json) => _$Apl1FromJson(json);
  Map<String, dynamic> toJson() => _$Apl1ToJson(this);

  _Apl1({
    required this.entry,
  });

  @JsonKey(defaultValue: "proc_con")
  String entry;
}

@JsonSerializable()
class _Apl2 {
  factory _Apl2.fromJson(Map<String, dynamic> json) => _$Apl2FromJson(json);
  Map<String, dynamic> toJson() => _$Apl2ToJson(this);

  _Apl2({
    required this.entry,
  });

  @JsonKey(defaultValue: "csvserver")
  String entry;
}

@JsonSerializable()
class _Apl3 {
  factory _Apl3.fromJson(Map<String, dynamic> json) => _$Apl3FromJson(json);
  Map<String, dynamic> toJson() => _$Apl3ToJson(this);

  _Apl3({
    required this.entry,
  });

  @JsonKey(defaultValue: "csvsend2")
  String entry;
}

@JsonSerializable()
class _Apl4 {
  factory _Apl4.fromJson(Map<String, dynamic> json) => _$Apl4FromJson(json);
  Map<String, dynamic> toJson() => _$Apl4ToJson(this);

  _Apl4({
    required this.entry,
  });

  @JsonKey(defaultValue: "checker")
  String entry;
}

@JsonSerializable()
class _Apl5 {
  factory _Apl5.fromJson(Map<String, dynamic> json) => _$Apl5FromJson(json);
  Map<String, dynamic> toJson() => _$Apl5ToJson(this);

  _Apl5({
    required this.entry,
  });

  @JsonKey(defaultValue: "cashier")
  String entry;
}

