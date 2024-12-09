// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tprtimJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TprtimJsonFile _$TprtimJsonFileFromJson(Map<String, dynamic> json) =>
    TprtimJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$TprtimJsonFileToJson(TprtimJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      priority: json['priority'] as int? ?? 0,
      drw_number: json['drw_number'] as int? ?? 0,
      drw_on_time: json['drw_on_time'] as int? ?? 10,
      drw_off_time: json['drw_off_time'] as int? ?? 50,
      prime_plus_flag: json['prime_plus_flag'] as int? ?? 0,
      mode_bit6: json['mode_bit6'] as int? ?? 0,
      mode_bit7: json['mode_bit7'] as int? ?? 1,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'priority': instance.priority,
      'drw_number': instance.drw_number,
      'drw_on_time': instance.drw_on_time,
      'drw_off_time': instance.drw_off_time,
      'prime_plus_flag': instance.prime_plus_flag,
      'mode_bit6': instance.mode_bit6,
      'mode_bit7': instance.mode_bit7,
    };
