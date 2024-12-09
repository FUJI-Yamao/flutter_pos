// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tprtsJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TprtsJsonFile _$TprtsJsonFileFromJson(Map<String, dynamic> json) =>
    TprtsJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$TprtsJsonFileToJson(TprtsJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      priority: json['priority'] as int? ?? 0,
      drw_number: json['drw_number'] as int? ?? 0,
      drw_on_time: json['drw_on_time'] as int? ?? 10,
      drw_off_time: json['drw_off_time'] as int? ?? 50,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'priority': instance.priority,
      'drw_number': instance.drw_number,
      'drw_on_time': instance.drw_on_time,
      'drw_off_time': instance.drw_off_time,
    };
