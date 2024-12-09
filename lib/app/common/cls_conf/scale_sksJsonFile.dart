/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'scale_sksJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Scale_sksJsonFile extends ConfigJsonFile {
  static final Scale_sksJsonFile _instance = Scale_sksJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "scale_sks.json";

  Scale_sksJsonFile(){
    setPath(_confPath, _fileName);
  }
  Scale_sksJsonFile._internal();

  factory Scale_sksJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Scale_sksJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Scale_sksJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Scale_sksJsonFileToJson(this));
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
    baudrate                           : 0,
    databit                            : 0,
    startbit                           : 0,
    stopbit                            : 0,
    parity                             : "",
    bill                               : "",
    id                                 : 0,
    collect_num                        : 0,
    span_switch                        : 0,
    protect_span_spec                  : 0,
    protect_count                      : 0,
    protect_data                       : 0,
    data_auth                          : 0,
    decimal_point_shape                : 0,
    decimal_point_pos                  : "",
    tare_auto_clear                    : 0,
    preset_tare                        : 0,
    digital_tare_subtraction           : 0,
    digital_tare_addition              : 0,
    digital_tare                       : 0,
    onetouch_tare_subtraction          : 0,
    onetouch_tare_addition             : 0,
    tare_range                         : 0,
    priority_preset_digital            : 0,
    priority_preset_onetouch           : 0,
    priority_digital_preset            : 0,
    priority_digital_onetouch          : 0,
    priority_onetouch_preset           : 0,
    priority_onetouch_digital          : 0,
    zero_tracking_when_tare            : 0,
    zero_reset_when_tare               : 0,
    tare_disp_mode                     : 0,
    negative_disp                      : "",
    interval_typw                      : 0,
    input_sensitivity                  : 0,
    reg_mode_print_range               : "",
    pricing_mode_print_range           : "",
    kg_lb_switching                    : 0,
    percentage_tare_rounding           : 0,
    tare_rounding_for_upper_range      : 0,
    onetouch_tare                      : 0,
    zero_reset_range_at_start          : 0,
    zero_reset_range                   : 0,
    use_area                           : 0,
    setting_area                       : 0,
    price_decimal_point                : 0,
    unit_price_decimal_point           : 0,
    price_decimal_point_pos            : "",
    unit_price_decimal_point_pos       : "",
    second_price_calc                  : "",
    price_calc                         : "",
    special_rounding                   : "",
    quote                              : "",
    label_issuance_during_tare         : 0,
    tare_automatic_update              : 0,
    sws_f_to_f_scale_spec              : 0,
    zero_lamp_pos                      : 0,
    disp_print_type                    : 0,
    programmed_tare_clear              : 0,
    print_pre_discount_price           : 0,
    unit_price_digit                   : 0,
    inverse_calc_of_unit_price         : 0,
    weight_manual_input                : 0,
    weight_key_in                      : 0,
    ad_type                            : 0,
    weighing                           : "",
    price_printing_in_barcode          : 0,
    quarter_round                      : "",
    round_price_type                   : 0,
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
    required this.baudrate,
    required this.databit,
    required this.startbit,
    required this.stopbit,
    required this.parity,
    required this.bill,
    required this.id,
    required this.collect_num,
    required this.span_switch,
    required this.protect_span_spec,
    required this.protect_count,
    required this.protect_data,
    required this.data_auth,
    required this.decimal_point_shape,
    required this.decimal_point_pos,
    required this.tare_auto_clear,
    required this.preset_tare,
    required this.digital_tare_subtraction,
    required this.digital_tare_addition,
    required this.digital_tare,
    required this.onetouch_tare_subtraction,
    required this.onetouch_tare_addition,
    required this.tare_range,
    required this.priority_preset_digital,
    required this.priority_preset_onetouch,
    required this.priority_digital_preset,
    required this.priority_digital_onetouch,
    required this.priority_onetouch_preset,
    required this.priority_onetouch_digital,
    required this.zero_tracking_when_tare,
    required this.zero_reset_when_tare,
    required this.tare_disp_mode,
    required this.negative_disp,
    required this.interval_typw,
    required this.input_sensitivity,
    required this.reg_mode_print_range,
    required this.pricing_mode_print_range,
    required this.kg_lb_switching,
    required this.percentage_tare_rounding,
    required this.tare_rounding_for_upper_range,
    required this.onetouch_tare,
    required this.zero_reset_range_at_start,
    required this.zero_reset_range,
    required this.use_area,
    required this.setting_area,
    required this.price_decimal_point,
    required this.unit_price_decimal_point,
    required this.price_decimal_point_pos,
    required this.unit_price_decimal_point_pos,
    required this.second_price_calc,
    required this.price_calc,
    required this.special_rounding,
    required this.quote,
    required this.label_issuance_during_tare,
    required this.tare_automatic_update,
    required this.sws_f_to_f_scale_spec,
    required this.zero_lamp_pos,
    required this.disp_print_type,
    required this.programmed_tare_clear,
    required this.print_pre_discount_price,
    required this.unit_price_digit,
    required this.inverse_calc_of_unit_price,
    required this.weight_manual_input,
    required this.weight_key_in,
    required this.ad_type,
    required this.weighing,
    required this.price_printing_in_barcode,
    required this.quarter_round,
    required this.round_price_type,
  });

  @JsonKey(defaultValue: "")
  String port;
  @JsonKey(defaultValue: 38400)
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
  @JsonKey(defaultValue: 4)
  int    collect_num;
  @JsonKey(defaultValue: 0)
  int    span_switch;
  @JsonKey(defaultValue: 0)
  int    protect_span_spec;
  @JsonKey(defaultValue: 0)
  int    protect_count;
  @JsonKey(defaultValue: 0)
  int    protect_data;
  @JsonKey(defaultValue: 0)
  int    data_auth;
  @JsonKey(defaultValue: 0)
  int    decimal_point_shape;
  @JsonKey(defaultValue: "00")
  String decimal_point_pos;
  @JsonKey(defaultValue: 0)
  int    tare_auto_clear;
  @JsonKey(defaultValue: 1)
  int    preset_tare;
  @JsonKey(defaultValue: 1)
  int    digital_tare_subtraction;
  @JsonKey(defaultValue: 1)
  int    digital_tare_addition;
  @JsonKey(defaultValue: 1)
  int    digital_tare;
  @JsonKey(defaultValue: 1)
  int    onetouch_tare_subtraction;
  @JsonKey(defaultValue: 1)
  int    onetouch_tare_addition;
  @JsonKey(defaultValue: 1)
  int    tare_range;
  @JsonKey(defaultValue: 1)
  int    priority_preset_digital;
  @JsonKey(defaultValue: 0)
  int    priority_preset_onetouch;
  @JsonKey(defaultValue: 1)
  int    priority_digital_preset;
  @JsonKey(defaultValue: 0)
  int    priority_digital_onetouch;
  @JsonKey(defaultValue: 0)
  int    priority_onetouch_preset;
  @JsonKey(defaultValue: 0)
  int    priority_onetouch_digital;
  @JsonKey(defaultValue: 1)
  int    zero_tracking_when_tare;
  @JsonKey(defaultValue: 1)
  int    zero_reset_when_tare;
  @JsonKey(defaultValue: 1)
  int    tare_disp_mode;
  @JsonKey(defaultValue: "00")
  String negative_disp;
  @JsonKey(defaultValue: 1)
  int    interval_typw;
  @JsonKey(defaultValue: 1100)
  int    input_sensitivity;
  @JsonKey(defaultValue: "000")
  String reg_mode_print_range;
  @JsonKey(defaultValue: "000")
  String pricing_mode_print_range;
  @JsonKey(defaultValue: 0)
  int    kg_lb_switching;
  @JsonKey(defaultValue: 0)
  int    percentage_tare_rounding;
  @JsonKey(defaultValue: 0)
  int    tare_rounding_for_upper_range;
  @JsonKey(defaultValue: 0)
  int    onetouch_tare;
  @JsonKey(defaultValue: 0)
  int    zero_reset_range_at_start;
  @JsonKey(defaultValue: 0)
  int    zero_reset_range;
  @JsonKey(defaultValue: 0)
  int    use_area;
  @JsonKey(defaultValue: 0)
  int    setting_area;
  @JsonKey(defaultValue: 0)
  int    price_decimal_point;
  @JsonKey(defaultValue: 0)
  int    unit_price_decimal_point;
  @JsonKey(defaultValue: "00")
  String price_decimal_point_pos;
  @JsonKey(defaultValue: "00")
  String unit_price_decimal_point_pos;
  @JsonKey(defaultValue: "0000")
  String second_price_calc;
  @JsonKey(defaultValue: "0000")
  String price_calc;
  @JsonKey(defaultValue: "0000")
  String special_rounding;
  @JsonKey(defaultValue: "000")
  String quote;
  @JsonKey(defaultValue: 0)
  int    label_issuance_during_tare;
  @JsonKey(defaultValue: 0)
  int    tare_automatic_update;
  @JsonKey(defaultValue: 0)
  int    sws_f_to_f_scale_spec;
  @JsonKey(defaultValue: 0)
  int    zero_lamp_pos;
  @JsonKey(defaultValue: 0)
  int    disp_print_type;
  @JsonKey(defaultValue: 0)
  int    programmed_tare_clear;
  @JsonKey(defaultValue: 0)
  int    print_pre_discount_price;
  @JsonKey(defaultValue: 0)
  int    unit_price_digit;
  @JsonKey(defaultValue: 0)
  int    inverse_calc_of_unit_price;
  @JsonKey(defaultValue: 0)
  int    weight_manual_input;
  @JsonKey(defaultValue: 0)
  int    weight_key_in;
  @JsonKey(defaultValue: 0)
  int    ad_type;
  @JsonKey(defaultValue: "00000")
  String weighing;
  @JsonKey(defaultValue: 0)
  int    price_printing_in_barcode;
  @JsonKey(defaultValue: "00")
  String quarter_round;
  @JsonKey(defaultValue: 0)
  int    round_price_type;
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

