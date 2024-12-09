/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'scalermJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class ScalermJsonFile extends ConfigJsonFile {
  static final ScalermJsonFile _instance = ScalermJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "scalerm.json";

  ScalermJsonFile(){
    setPath(_confPath, _fileName);
  }
  ScalermJsonFile._internal();

  factory ScalermJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$ScalermJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$ScalermJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$ScalermJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        settings = _$SettingsFromJson(jsonD['settings']);
      } catch(e) {
        settings = _$SettingsFromJson({});
        ret = false;
      }
      try {
        info = _$InfoFromJson(jsonD['info']);
      } catch(e) {
        info = _$InfoFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Settings settings = _Settings(
    port                               : "",
    port2                              : "",
    baudrate                           : 0,
    databit                            : 0,
    startbit                           : 0,
    stopbit                            : 0,
    parity                             : "",
    bill                               : "",
    id                                 : 0,
    stability_cond                     : "",
    tare_accumutation                  : 0,
    tare_subtraction                   : 0,
    start_range                        : "",
    auto_zero_reset                    : 0,
    auto_tare_clear                    : 0,
    priority_tare                      : 0,
    auto_clear_cond                    : 0,
    tare_auto_clear                    : 0,
    zero_lamp                          : 0,
    manual_tare_cancel                 : 0,
    digital_tare                       : 0,
    weight_reset                       : 0,
    zero_tracking                      : 0,
    pos_of_decimal_point               : "",
    rezero_range                       : "",
    rezero_func                        : 0,
    single_or_multi                    : 0,
    negative_disp                      : "",
    tare_range                         : 0,
    type_of_point                      : 0,
    digital_filter                     : "",
  );

  _Info info = _Info(
    version                            : 0,
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.port,
    required this.port2,
    required this.baudrate,
    required this.databit,
    required this.startbit,
    required this.stopbit,
    required this.parity,
    required this.bill,
    required this.id,
    required this.stability_cond,
    required this.tare_accumutation,
    required this.tare_subtraction,
    required this.start_range,
    required this.auto_zero_reset,
    required this.auto_tare_clear,
    required this.priority_tare,
    required this.auto_clear_cond,
    required this.tare_auto_clear,
    required this.zero_lamp,
    required this.manual_tare_cancel,
    required this.digital_tare,
    required this.weight_reset,
    required this.zero_tracking,
    required this.pos_of_decimal_point,
    required this.rezero_range,
    required this.rezero_func,
    required this.single_or_multi,
    required this.negative_disp,
    required this.tare_range,
    required this.type_of_point,
    required this.digital_filter,
  });

  @JsonKey(defaultValue: "/dev/ttyS1")
  String port;
  @JsonKey(defaultValue: "/dev/ttyS3")
  String port2;
  @JsonKey(defaultValue: 19200)
  int    baudrate;
  @JsonKey(defaultValue: 8)
  int    databit;
  @JsonKey(defaultValue: 1)
  int    startbit;
  @JsonKey(defaultValue: 1)
  int    stopbit;
  @JsonKey(defaultValue: "even")
  String parity;
  @JsonKey(defaultValue: "no")
  String bill;
  @JsonKey(defaultValue: 1)
  int    id;
  @JsonKey(defaultValue: "01")
  String stability_cond;
  @JsonKey(defaultValue: 0)
  int    tare_accumutation;
  @JsonKey(defaultValue: 1)
  int    tare_subtraction;
  @JsonKey(defaultValue: "00")
  String start_range;
  @JsonKey(defaultValue: 1)
  int    auto_zero_reset;
  @JsonKey(defaultValue: 0)
  int    auto_tare_clear;
  @JsonKey(defaultValue: 1)
  int    priority_tare;
  @JsonKey(defaultValue: 0)
  int    auto_clear_cond;
  @JsonKey(defaultValue: 1)
  int    tare_auto_clear;
  @JsonKey(defaultValue: 0)
  int    zero_lamp;
  @JsonKey(defaultValue: 0)
  int    manual_tare_cancel;
  @JsonKey(defaultValue: 0)
  int    digital_tare;
  @JsonKey(defaultValue: 0)
  int    weight_reset;
  @JsonKey(defaultValue: 0)
  int    zero_tracking;
  @JsonKey(defaultValue: "000")
  String pos_of_decimal_point;
  @JsonKey(defaultValue: "000")
  String rezero_range;
  @JsonKey(defaultValue: 0)
  int    rezero_func;
  @JsonKey(defaultValue: 1)
  int    single_or_multi;
  @JsonKey(defaultValue: "00")
  String negative_disp;
  @JsonKey(defaultValue: 0)
  int    tare_range;
  @JsonKey(defaultValue: 0)
  int    type_of_point;
  @JsonKey(defaultValue: "01")
  String digital_filter;
}

@JsonSerializable()
class _Info {
  factory _Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);

  _Info({
    required this.version,
  });

  @JsonKey(defaultValue: 0)
  int    version;
}

