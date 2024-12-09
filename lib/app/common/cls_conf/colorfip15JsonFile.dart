/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'colorfip15JsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Colorfip15JsonFile extends ConfigJsonFile {
  static final Colorfip15JsonFile _instance = Colorfip15JsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "colorfip15.json";

  Colorfip15JsonFile(){
    setPath(_confPath, _fileName);
  }
  Colorfip15JsonFile._internal();

  factory Colorfip15JsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Colorfip15JsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Colorfip15JsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Colorfip15JsonFileToJson(this));
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
        png_name = _$Png_nameFromJson(jsonD['png_name']);
      } catch(e) {
        png_name = _$Png_nameFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Settings settings = _Settings(
    swap_horizontal                    : 0,
    swap_vertical                      : 0,
  );

  _Png_name png_name = _Png_name(
    image_areaA_bg_name                : "",
    image_areaA_bg_mov_name            : "",
    image_areaCD_bg_name               : "",
    image_left_amt_title_name          : "",
    image_right_amt_title_name         : "",
    image_left_shadow_name             : "",
    image_right_shadow_name            : "",
    image_left_regs_end_name           : "",
    image_right_regs_end_name          : "",
    image_offmode_name                 : "",
    image_alert_txt_name               : "",
    image_alert_btn_name               : "",
    image_alert_btn_off_name           : "",
    image_popup_name                   : "",
    image_areaCD_training_name         : "",
  );
}

@JsonSerializable()
class _Settings {
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  _Settings({
    required this.swap_horizontal,
    required this.swap_vertical,
  });

  @JsonKey(defaultValue: 0)
  int    swap_horizontal;
  @JsonKey(defaultValue: 0)
  int    swap_vertical;
}

@JsonSerializable()
class _Png_name {
  factory _Png_name.fromJson(Map<String, dynamic> json) => _$Png_nameFromJson(json);
  Map<String, dynamic> toJson() => _$Png_nameToJson(this);

  _Png_name({
    required this.image_areaA_bg_name,
    required this.image_areaA_bg_mov_name,
    required this.image_areaCD_bg_name,
    required this.image_left_amt_title_name,
    required this.image_right_amt_title_name,
    required this.image_left_shadow_name,
    required this.image_right_shadow_name,
    required this.image_left_regs_end_name,
    required this.image_right_regs_end_name,
    required this.image_offmode_name,
    required this.image_alert_txt_name,
    required this.image_alert_btn_name,
    required this.image_alert_btn_off_name,
    required this.image_popup_name,
    required this.image_areaCD_training_name,
  });

  @JsonKey(defaultValue: "colorfip15_areaA_bg_01.png")
  String image_areaA_bg_name;
  @JsonKey(defaultValue: "NoData")
  String image_areaA_bg_mov_name;
  @JsonKey(defaultValue: "colorfip15_areaCD_bg.png")
  String image_areaCD_bg_name;
  @JsonKey(defaultValue: "colorfip15_total_left.png")
  String image_left_amt_title_name;
  @JsonKey(defaultValue: "colorfip15_total_right.png")
  String image_right_amt_title_name;
  @JsonKey(defaultValue: "colorfip15_areaDleft_shadow.png")
  String image_left_shadow_name;
  @JsonKey(defaultValue: "colorfip15_areaDright_shadow.png")
  String image_right_shadow_name;
  @JsonKey(defaultValue: "colorfip15_regsend_left.png")
  String image_left_regs_end_name;
  @JsonKey(defaultValue: "colorfip15_regsend_right.png")
  String image_right_regs_end_name;
  @JsonKey(defaultValue: "colorfip15_off.png")
  String image_offmode_name;
  @JsonKey(defaultValue: "colorfip15_20over_txt.png")
  String image_alert_txt_name;
  @JsonKey(defaultValue: "colorfip15_yes_btn_on.png")
  String image_alert_btn_name;
  @JsonKey(defaultValue: "colorfip15_yes_btn_off.png")
  String image_alert_btn_off_name;
  @JsonKey(defaultValue: "popup.png")
  String image_popup_name;
  @JsonKey(defaultValue: "colorfip15_areaCD_training.png")
  String image_areaCD_training_name;
}

