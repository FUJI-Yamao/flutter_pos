/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'ecs_specJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Ecs_specJsonFile extends ConfigJsonFile {
  static final Ecs_specJsonFile _instance = Ecs_specJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "ecs_spec.json";

  Ecs_specJsonFile(){
    setPath(_confPath, _fileName);
  }
  Ecs_specJsonFile._internal();

  factory Ecs_specJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Ecs_specJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Ecs_specJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Ecs_specJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        ecs_spec = _$Ecs_specFromJson(jsonD['ecs_spec']);
      } catch(e) {
        ecs_spec = _$Ecs_specFromJson({});
        ret = false;
      }
      try {
        datetime = _$DatetimeFromJson(jsonD['datetime']);
      } catch(e) {
        datetime = _$DatetimeFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Ecs_spec ecs_spec = _Ecs_spec(
    ecs_gp0_1_0                        : 0,
    ecs_gp0_1_2                        : 0,
    ecs_gp0_2_0                        : 0,
    ecs_gp0_2_2                        : 0,
    ecs_gp0_3_0                        : 0,
    ecs_gp0_3_1                        : 0,
    ecs_gp0_3_2                        : 0,
    ecs_gp0_3_3                        : 0,
    ecs_gp0_4_0                        : 0,
    ecs_gp0_5_0                        : 0,
    ecs_gp0_5_2                        : 0,
    ecs_gp1_1_0                        : 0,
    ecs_gp1_1_2                        : 0,
    ecs_gp1_2_0                        : 0,
    ecs_gp1_2_2                        : 0,
    ecs_gp1_3_0                        : 0,
    ecs_gp1_3_1                        : 0,
    ecs_gp1_3_2                        : 0,
    ecs_gp1_4_0                        : 0,
    ecs_gp1_4_2                        : 0,
    ecs_gp1_4_3                        : 0,
    ecs_gp1_5_0                        : 0,
    ecs_gp2_1_0                        : 0,
    ecs_gp2_1_2                        : 0,
    ecs_gp2_2_0                        : 0,
    ecs_gp2_2_2                        : 0,
    ecs_gp2_3_0                        : 0,
    ecs_gp2_3_1                        : 0,
    ecs_gp2_3_2                        : 0,
    ecs_gp2_4_0                        : 0,
    ecs_gp2_4_1                        : 0,
    ecs_gp2_5_0                        : 0,
    ecs_gp3_1_0                        : 0,
    ecs_gp3_1_1                        : 0,
    ecs_gp3_1_2                        : 0,
    ecs_gp3_1_3                        : 0,
    ecs_gp3_2_0                        : 0,
    ecs_gp3_2_1                        : 0,
    ecs_gp3_2_2                        : 0,
    ecs_gp3_2_3                        : 0,
    ecs_gp3_3_0                        : 0,
    ecs_gp3_3_2                        : 0,
    ecs_gp3_4_0                        : 0,
    ecs_gp4_1_0                        : 0,
    ecs_gp4_1_1                        : 0,
    ecs_gp4_1_2                        : 0,
    ecs_gp4_1_3                        : 0,
    ecs_gp4_2_0                        : 0,
    ecs_gp4_2_1                        : 0,
    ecs_gp4_2_2                        : 0,
    ecs_gp4_2_3                        : 0,
    ecs_gp4_3_0                        : 0,
    ecs_gp4_3_1                        : 0,
    ecs_gp4_3_2                        : 0,
    ecs_gp4_3_3                        : 0,
    ecs_gp4_4_0                        : 0,
    ecs_gp4_4_2                        : 0,
    ecs_gp5_1_0                        : 0,
    ecs_gp5_3_0                        : 0,
    ecs_gp5_5_0                        : 0,
    ecs_gp5_5_1                        : 0,
    ecs_gp5_5_2                        : 0,
    ecs_gp6_1_0                        : 0,
    ecs_gp6_3_0                        : 0,
    ecs_gp6_5_0                        : 0,
    ecs_gp7_1_0                        : 0,
    ecs_gp7_1_1                        : 0,
    ecs_gp7_1_2                        : 0,
    ecs_gp7_2_0                        : 0,
    ecs_gp7_2_1                        : 0,
    ecs_gp7_2_2                        : 0,
    ecs_gp7_3_0                        : 0,
    ecs_gp7_5_0                        : 0,
    ecs_gp7_5_2                        : 0,
    ecs_gp8_1_0                        : 0,
    ecs_gp8_1_1                        : 0,
    ecs_gp8_1_3                        : 0,
    ecs_gp8_2_0                        : 0,
    ecs_gp8_2_1                        : 0,
    ecs_gp8_2_2                        : 0,
    ecs_gp8_3_0                        : 0,
    ecs_gp8_3_1                        : 0,
    ecs_gp8_3_2                        : 0,
    ecs_gp8_4_0                        : 0,
    ecs_gp9_1_0                        : 0,
    ecs_gp9_1_1                        : 0,
    ecs_gp9_1_2                        : 0,
    ecs_gp9_2_0                        : 0,
    ecs_gp9_4_0                        : 0,
    ecs_gp9_4_2                        : 0,
    ecs_gp9_5_0                        : 0,
    ecs_gp9_5_1                        : 0,
    ecs_gp9_5_2                        : 0,
    ecs_gp9_5_3                        : 0,
    ecs_gpa_1_0                        : 0,
    ecs_gpa_1_1                        : 0,
    ecs_gpa_1_2                        : 0,
    ecs_gpa_2_0                        : 0,
    ecs_gpa_2_1                        : 0,
    ecs_gpa_2_2                        : 0,
    ecs_gpa_3_0                        : 0,
    ecs_gpa_3_1                        : 0,
    ecs_gpa_3_2                        : 0,
    ecs_gpa_4_0                        : 0,
    ecs_gpa_4_3                        : 0,
    ecs_gpa_5_0                        : 0,
    ecs_gpa_5_1                        : 0,
    ecs_gpb_1_0                        : 0,
    ecs_gpb_1_2                        : 0,
    ecs_gpb_2_0                        : 0,
    ecs_gpb_2_1                        : 0,
    ecs_gpb_2_2                        : 0,
    ecs_gpb_3_0                        : 0,
    ecs_gpb_3_2                        : 0,
    ecs_gpb_4_0                        : 0,
    ecs_gpb_4_2                        : 0,
    ecs_gpb_4_3                        : 0,
    ecs_gpb_5_0                        : 0,
    ecs_gpb_5_2                        : 0,
    ecs_gpc_1_0                        : 0,
    ecs_gpc_3_0                        : 0,
    ecs_gpc_3_2                        : 0,
    ecs_gpc_3_3                        : 0,
    ecs_gpc_4_0                        : 0,
    ecs_gpc_4_3                        : 0,
    ecs_gpc_5_0                        : 0,
    ecs_gpc_5_1                        : 0,
    ecs_gpc_5_2                        : 0,
    ecs_gpc_5_3                        : 0,
    ecs_gpd_1_0                        : 0,
    ecs_gpd_1_2                        : 0,
    ecs_gpd_2_0                        : 0,
    ecs_gpd_2_3                        : 0,
    ecs_gpd_3_0                        : 0,
    ecs_gpd_3_2                        : 0,
    ecs_gpd_4_0                        : 0,
    ecs_gpd_5_0                        : 0,
    ecs_gpd_5_1                        : 0,
    ecs_gpd_5_3                        : 0,
    ecs_gpe_1_0                        : 0,
    ecs_gpe_1_3                        : 0,
    ecs_gpe_2_0                        : 0,
    ecs_gpe_2_2                        : 0,
    ecs_gpe_2_3                        : 0,
    ecs_gpe_3_0                        : 0,
    ecs_gpe_3_1                        : 0,
    ecs_gpe_3_3                        : 0,
    ecs_gpe_4_0                        : 0,
    ecs_gpe_4_1                        : 0,
    ecs_gpe_5_0                        : 0,
    ecs_gpf_1_0                        : 0,
    ecs_gpf_1_1                        : 0,
    ecs_gpf_1_2                        : 0,
    ecs_gpf_2_0                        : 0,
    ecs_gpf_5_0                        : 0,
    ecs_gp11_2_0                       : 0,
    ecs_gp11_2_2                       : 0,
    ecs_gp12_1_0                       : 0,
    ecs_gp12_3_0                       : 0,
    ecs_gp12_3_1                       : 0,
    ecs_gp12_3_2                       : 0,
    ecs_gp12_3_3                       : 0,
    ecs_gp12_4_0                       : 0,
    ecs_gp13_1_0                       : 0,
    ecs_gp13_2_0                       : 0,
    ecs_gp13_2_2                       : 0,
    ecs_gp13_3_0                       : 0,
    ecs_gp13_4_0                       : 0,
    ecs_gp13_5_0                       : 0,
    ecs_gp14_2_0                       : 0,
    ecs_gp14_2_1                       : 0,
    ecs_gp14_2_2                       : 0,
    ecs_gp14_3_0                       : 0,
    ecs_gp14_3_1                       : 0,
    ecs_gp14_3_2                       : 0,
    ecs_gp14_3_3                       : 0,
    ecs_gp14_4_0                       : 0,
    ecs_gp15_1_0                       : 0,
    ecs_gp15_1_2                       : 0,
    ecs_gp15_2_0                       : 0,
    ecs_gp15_3_0                       : 0,
    ecs_gp15_5_0                       : 0,
    ecs_gp17_1_0                       : 0,
    ecs_gp17_1_2                       : 0,
    ecs_gp17_1_3                       : 0,
    ecs_gp17_2_0                       : 0,
    ecs_gp17_2_1                       : 0,
    ecs_gp17_5_0                       : 0,
    ecs_gp18_2_0                       : 0,
    ecs_gp18_2_1                       : 0,
    ecs_gp18_2_2                       : 0,
    ecs_gp18_2_3                       : 0,
    ecs_gp18_3_0                       : 0,
    ecs_gp18_3_1                       : 0,
    ecs_gp18_3_2                       : 0,
    ecs_gp18_3_3                       : 0,
    ecs_gp18_4_2                       : 0,
    ecs_gp18_4_3                       : 0,
    ecs_gp18_5_0                       : 0,
    ecs_gp19_1_0                       : 0,
    ecs_gp19_3_2                       : 0,
    ecs_gp19_4_0                       : 0,
    ecs_gp19_5_0                       : 0,
    ecs_gp1a_1_2                       : 0,
    ecs_gp1a_3_0                       : 0,
    ecs_gp1a_4_0                       : 0,
    ecs_gp1a_4_3                       : 0,
    ecs_gp1a_5_0                       : 0,
    ecs_gp1a_5_1                       : 0,
    ecs_gp1a_5_2                       : 0,
    ecs_gp1e_1_0                       : 0,
    ecs_gp1e_4_0                       : 0,
    ecs_gp1f_1_0                       : 0,
    ecs_gp1f_3_0                       : 0,
    ecs_gp1f_5_0                       : 0,
    ecs_gp1f_5_2                       : 0,
  );

  _Datetime datetime = _Datetime(
    save_datetime                      : "",
    acb_select                         : 0,
  );
}

@JsonSerializable()
class _Ecs_spec {
  factory _Ecs_spec.fromJson(Map<String, dynamic> json) => _$Ecs_specFromJson(json);
  Map<String, dynamic> toJson() => _$Ecs_specToJson(this);

  _Ecs_spec({
    required this.ecs_gp0_1_0,
    required this.ecs_gp0_1_2,
    required this.ecs_gp0_2_0,
    required this.ecs_gp0_2_2,
    required this.ecs_gp0_3_0,
    required this.ecs_gp0_3_1,
    required this.ecs_gp0_3_2,
    required this.ecs_gp0_3_3,
    required this.ecs_gp0_4_0,
    required this.ecs_gp0_5_0,
    required this.ecs_gp0_5_2,
    required this.ecs_gp1_1_0,
    required this.ecs_gp1_1_2,
    required this.ecs_gp1_2_0,
    required this.ecs_gp1_2_2,
    required this.ecs_gp1_3_0,
    required this.ecs_gp1_3_1,
    required this.ecs_gp1_3_2,
    required this.ecs_gp1_4_0,
    required this.ecs_gp1_4_2,
    required this.ecs_gp1_4_3,
    required this.ecs_gp1_5_0,
    required this.ecs_gp2_1_0,
    required this.ecs_gp2_1_2,
    required this.ecs_gp2_2_0,
    required this.ecs_gp2_2_2,
    required this.ecs_gp2_3_0,
    required this.ecs_gp2_3_1,
    required this.ecs_gp2_3_2,
    required this.ecs_gp2_4_0,
    required this.ecs_gp2_4_1,
    required this.ecs_gp2_5_0,
    required this.ecs_gp3_1_0,
    required this.ecs_gp3_1_1,
    required this.ecs_gp3_1_2,
    required this.ecs_gp3_1_3,
    required this.ecs_gp3_2_0,
    required this.ecs_gp3_2_1,
    required this.ecs_gp3_2_2,
    required this.ecs_gp3_2_3,
    required this.ecs_gp3_3_0,
    required this.ecs_gp3_3_2,
    required this.ecs_gp3_4_0,
    required this.ecs_gp4_1_0,
    required this.ecs_gp4_1_1,
    required this.ecs_gp4_1_2,
    required this.ecs_gp4_1_3,
    required this.ecs_gp4_2_0,
    required this.ecs_gp4_2_1,
    required this.ecs_gp4_2_2,
    required this.ecs_gp4_2_3,
    required this.ecs_gp4_3_0,
    required this.ecs_gp4_3_1,
    required this.ecs_gp4_3_2,
    required this.ecs_gp4_3_3,
    required this.ecs_gp4_4_0,
    required this.ecs_gp4_4_2,
    required this.ecs_gp5_1_0,
    required this.ecs_gp5_3_0,
    required this.ecs_gp5_5_0,
    required this.ecs_gp5_5_1,
    required this.ecs_gp5_5_2,
    required this.ecs_gp6_1_0,
    required this.ecs_gp6_3_0,
    required this.ecs_gp6_5_0,
    required this.ecs_gp7_1_0,
    required this.ecs_gp7_1_1,
    required this.ecs_gp7_1_2,
    required this.ecs_gp7_2_0,
    required this.ecs_gp7_2_1,
    required this.ecs_gp7_2_2,
    required this.ecs_gp7_3_0,
    required this.ecs_gp7_5_0,
    required this.ecs_gp7_5_2,
    required this.ecs_gp8_1_0,
    required this.ecs_gp8_1_1,
    required this.ecs_gp8_1_3,
    required this.ecs_gp8_2_0,
    required this.ecs_gp8_2_1,
    required this.ecs_gp8_2_2,
    required this.ecs_gp8_3_0,
    required this.ecs_gp8_3_1,
    required this.ecs_gp8_3_2,
    required this.ecs_gp8_4_0,
    required this.ecs_gp9_1_0,
    required this.ecs_gp9_1_1,
    required this.ecs_gp9_1_2,
    required this.ecs_gp9_2_0,
    required this.ecs_gp9_4_0,
    required this.ecs_gp9_4_2,
    required this.ecs_gp9_5_0,
    required this.ecs_gp9_5_1,
    required this.ecs_gp9_5_2,
    required this.ecs_gp9_5_3,
    required this.ecs_gpa_1_0,
    required this.ecs_gpa_1_1,
    required this.ecs_gpa_1_2,
    required this.ecs_gpa_2_0,
    required this.ecs_gpa_2_1,
    required this.ecs_gpa_2_2,
    required this.ecs_gpa_3_0,
    required this.ecs_gpa_3_1,
    required this.ecs_gpa_3_2,
    required this.ecs_gpa_4_0,
    required this.ecs_gpa_4_3,
    required this.ecs_gpa_5_0,
    required this.ecs_gpa_5_1,
    required this.ecs_gpb_1_0,
    required this.ecs_gpb_1_2,
    required this.ecs_gpb_2_0,
    required this.ecs_gpb_2_1,
    required this.ecs_gpb_2_2,
    required this.ecs_gpb_3_0,
    required this.ecs_gpb_3_2,
    required this.ecs_gpb_4_0,
    required this.ecs_gpb_4_2,
    required this.ecs_gpb_4_3,
    required this.ecs_gpb_5_0,
    required this.ecs_gpb_5_2,
    required this.ecs_gpc_1_0,
    required this.ecs_gpc_3_0,
    required this.ecs_gpc_3_2,
    required this.ecs_gpc_3_3,
    required this.ecs_gpc_4_0,
    required this.ecs_gpc_4_3,
    required this.ecs_gpc_5_0,
    required this.ecs_gpc_5_1,
    required this.ecs_gpc_5_2,
    required this.ecs_gpc_5_3,
    required this.ecs_gpd_1_0,
    required this.ecs_gpd_1_2,
    required this.ecs_gpd_2_0,
    required this.ecs_gpd_2_3,
    required this.ecs_gpd_3_0,
    required this.ecs_gpd_3_2,
    required this.ecs_gpd_4_0,
    required this.ecs_gpd_5_0,
    required this.ecs_gpd_5_1,
    required this.ecs_gpd_5_3,
    required this.ecs_gpe_1_0,
    required this.ecs_gpe_1_3,
    required this.ecs_gpe_2_0,
    required this.ecs_gpe_2_2,
    required this.ecs_gpe_2_3,
    required this.ecs_gpe_3_0,
    required this.ecs_gpe_3_1,
    required this.ecs_gpe_3_3,
    required this.ecs_gpe_4_0,
    required this.ecs_gpe_4_1,
    required this.ecs_gpe_5_0,
    required this.ecs_gpf_1_0,
    required this.ecs_gpf_1_1,
    required this.ecs_gpf_1_2,
    required this.ecs_gpf_2_0,
    required this.ecs_gpf_5_0,
    required this.ecs_gp11_2_0,
    required this.ecs_gp11_2_2,
    required this.ecs_gp12_1_0,
    required this.ecs_gp12_3_0,
    required this.ecs_gp12_3_1,
    required this.ecs_gp12_3_2,
    required this.ecs_gp12_3_3,
    required this.ecs_gp12_4_0,
    required this.ecs_gp13_1_0,
    required this.ecs_gp13_2_0,
    required this.ecs_gp13_2_2,
    required this.ecs_gp13_3_0,
    required this.ecs_gp13_4_0,
    required this.ecs_gp13_5_0,
    required this.ecs_gp14_2_0,
    required this.ecs_gp14_2_1,
    required this.ecs_gp14_2_2,
    required this.ecs_gp14_3_0,
    required this.ecs_gp14_3_1,
    required this.ecs_gp14_3_2,
    required this.ecs_gp14_3_3,
    required this.ecs_gp14_4_0,
    required this.ecs_gp15_1_0,
    required this.ecs_gp15_1_2,
    required this.ecs_gp15_2_0,
    required this.ecs_gp15_3_0,
    required this.ecs_gp15_5_0,
    required this.ecs_gp17_1_0,
    required this.ecs_gp17_1_2,
    required this.ecs_gp17_1_3,
    required this.ecs_gp17_2_0,
    required this.ecs_gp17_2_1,
    required this.ecs_gp17_5_0,
    required this.ecs_gp18_2_0,
    required this.ecs_gp18_2_1,
    required this.ecs_gp18_2_2,
    required this.ecs_gp18_2_3,
    required this.ecs_gp18_3_0,
    required this.ecs_gp18_3_1,
    required this.ecs_gp18_3_2,
    required this.ecs_gp18_3_3,
    required this.ecs_gp18_4_2,
    required this.ecs_gp18_4_3,
    required this.ecs_gp18_5_0,
    required this.ecs_gp19_1_0,
    required this.ecs_gp19_3_2,
    required this.ecs_gp19_4_0,
    required this.ecs_gp19_5_0,
    required this.ecs_gp1a_1_2,
    required this.ecs_gp1a_3_0,
    required this.ecs_gp1a_4_0,
    required this.ecs_gp1a_4_3,
    required this.ecs_gp1a_5_0,
    required this.ecs_gp1a_5_1,
    required this.ecs_gp1a_5_2,
    required this.ecs_gp1e_1_0,
    required this.ecs_gp1e_4_0,
    required this.ecs_gp1f_1_0,
    required this.ecs_gp1f_3_0,
    required this.ecs_gp1f_5_0,
    required this.ecs_gp1f_5_2,
  });

  @JsonKey(defaultValue: 0)
  int    ecs_gp0_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_3_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp0_5_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_4_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_4_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_4_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp2_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_1_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_2_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp3_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_1_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_2_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_3_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp4_4_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp5_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp5_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp5_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp5_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp5_5_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp6_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp6_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp6_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp7_5_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_1_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp8_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_4_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_5_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp9_5_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_4_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpa_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_4_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_4_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpb_5_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_3_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_4_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_5_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpc_5_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_2_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpd_5_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_1_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_2_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_3_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_4_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpe_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpf_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpf_1_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gpf_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gpf_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gpf_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp11_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp11_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp12_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp12_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp12_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp12_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp12_3_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp12_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp13_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp13_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp13_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp13_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp13_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp13_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp14_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp14_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp14_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp14_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp14_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp14_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp14_3_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp14_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp15_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp15_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp15_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp15_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp15_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp17_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp17_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp17_1_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp17_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp17_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp17_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_2_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_2_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_2_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_2_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_3_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_3_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_4_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_4_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp18_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp19_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp19_3_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp19_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp19_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1a_1_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1a_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1a_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1a_4_3;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1a_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1a_5_1;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1a_5_2;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1e_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1e_4_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1f_1_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1f_3_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1f_5_0;
  @JsonKey(defaultValue: 0)
  int    ecs_gp1f_5_2;
}

@JsonSerializable()
class _Datetime {
  factory _Datetime.fromJson(Map<String, dynamic> json) => _$DatetimeFromJson(json);
  Map<String, dynamic> toJson() => _$DatetimeToJson(this);

  _Datetime({
    required this.save_datetime,
    required this.acb_select,
  });

  @JsonKey(defaultValue: "0000/00/00 00:00")
  String save_datetime;
  @JsonKey(defaultValue: 0)
  int    acb_select;
}

