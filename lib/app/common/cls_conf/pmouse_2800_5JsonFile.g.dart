// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pmouse_2800_5JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pmouse_2800_5JsonFile _$Pmouse_2800_5JsonFileFromJson(
        Map<String, dynamic> json) =>
    Pmouse_2800_5JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Pmouse_2800_5JsonFileToJson(
        Pmouse_2800_5JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      dmcno: json['dmcno'] as int? ?? 0,
      dmcno2: json['dmcno2'] as int? ?? 2,
      reso_x: json['reso_x'] as int? ?? 1080,
      reso_y: json['reso_y'] as int? ?? 1920,
      x1: json['x1'] as int? ?? 16183,
      y1: json['y1'] as int? ?? 12,
      x2: json['x2'] as int? ?? 10,
      y2: json['y2'] as int? ?? 88,
      x3: json['x3'] as int? ?? 16232,
      y3: json['y3'] as int? ?? 9556,
      x4: json['x4'] as int? ?? 2,
      y4: json['y4'] as int? ?? 9594,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'dmcno': instance.dmcno,
      'dmcno2': instance.dmcno2,
      'reso_x': instance.reso_x,
      'reso_y': instance.reso_y,
      'x1': instance.x1,
      'y1': instance.y1,
      'x2': instance.x2,
      'y2': instance.y2,
      'x3': instance.x3,
      'y3': instance.y3,
      'x4': instance.x4,
      'y4': instance.y4,
    };