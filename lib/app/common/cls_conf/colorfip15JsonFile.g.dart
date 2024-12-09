// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colorfip15JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Colorfip15JsonFile _$Colorfip15JsonFileFromJson(Map<String, dynamic> json) =>
    Colorfip15JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>)
      ..png_name = _Png_name.fromJson(json['png_name'] as Map<String, dynamic>);

Map<String, dynamic> _$Colorfip15JsonFileToJson(Colorfip15JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
      'png_name': instance.png_name.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      swap_horizontal: json['swap_horizontal'] as int? ?? 0,
      swap_vertical: json['swap_vertical'] as int? ?? 0,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'swap_horizontal': instance.swap_horizontal,
      'swap_vertical': instance.swap_vertical,
    };

_Png_name _$Png_nameFromJson(Map<String, dynamic> json) => _Png_name(
      image_areaA_bg_name: json['image_areaA_bg_name'] as String? ??
          'colorfip15_areaA_bg_01.png',
      image_areaA_bg_mov_name:
          json['image_areaA_bg_mov_name'] as String? ?? 'NoData',
      image_areaCD_bg_name:
          json['image_areaCD_bg_name'] as String? ?? 'colorfip15_areaCD_bg.png',
      image_left_amt_title_name: json['image_left_amt_title_name'] as String? ??
          'colorfip15_total_left.png',
      image_right_amt_title_name:
          json['image_right_amt_title_name'] as String? ??
              'colorfip15_total_right.png',
      image_left_shadow_name: json['image_left_shadow_name'] as String? ??
          'colorfip15_areaDleft_shadow.png',
      image_right_shadow_name: json['image_right_shadow_name'] as String? ??
          'colorfip15_areaDright_shadow.png',
      image_left_regs_end_name: json['image_left_regs_end_name'] as String? ??
          'colorfip15_regsend_left.png',
      image_right_regs_end_name: json['image_right_regs_end_name'] as String? ??
          'colorfip15_regsend_right.png',
      image_offmode_name:
          json['image_offmode_name'] as String? ?? 'colorfip15_off.png',
      image_alert_txt_name: json['image_alert_txt_name'] as String? ??
          'colorfip15_20over_txt.png',
      image_alert_btn_name: json['image_alert_btn_name'] as String? ??
          'colorfip15_yes_btn_on.png',
      image_alert_btn_off_name: json['image_alert_btn_off_name'] as String? ??
          'colorfip15_yes_btn_off.png',
      image_popup_name: json['image_popup_name'] as String? ?? 'popup.png',
      image_areaCD_training_name:
          json['image_areaCD_training_name'] as String? ??
              'colorfip15_areaCD_training.png',
    );

Map<String, dynamic> _$Png_nameToJson(_Png_name instance) => <String, dynamic>{
      'image_areaA_bg_name': instance.image_areaA_bg_name,
      'image_areaA_bg_mov_name': instance.image_areaA_bg_mov_name,
      'image_areaCD_bg_name': instance.image_areaCD_bg_name,
      'image_left_amt_title_name': instance.image_left_amt_title_name,
      'image_right_amt_title_name': instance.image_right_amt_title_name,
      'image_left_shadow_name': instance.image_left_shadow_name,
      'image_right_shadow_name': instance.image_right_shadow_name,
      'image_left_regs_end_name': instance.image_left_regs_end_name,
      'image_right_regs_end_name': instance.image_right_regs_end_name,
      'image_offmode_name': instance.image_offmode_name,
      'image_alert_txt_name': instance.image_alert_txt_name,
      'image_alert_btn_name': instance.image_alert_btn_name,
      'image_alert_btn_off_name': instance.image_alert_btn_off_name,
      'image_popup_name': instance.image_popup_name,
      'image_areaCD_training_name': instance.image_areaCD_training_name,
    };
