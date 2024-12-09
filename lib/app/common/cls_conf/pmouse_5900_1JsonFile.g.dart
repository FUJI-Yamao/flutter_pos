// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pmouse_5900_1JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pmouse_5900_1JsonFile _$Pmouse_5900_1JsonFileFromJson(
        Map<String, dynamic> json) =>
    Pmouse_5900_1JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Pmouse_5900_1JsonFileToJson(
        Pmouse_5900_1JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      dmcno: json['dmcno'] as int? ?? 0,
      reso_x: json['reso_x'] as int? ?? 1024,
      reso_y: json['reso_y'] as int? ?? 600,
      x1: json['x1'] as int? ?? 32,
      y1: json['y1'] as int? ?? 20,
      x2: json['x2'] as int? ?? 16,
      y2: json['y2'] as int? ?? 1008,
      x3: json['x3'] as int? ?? 1004,
      y3: json['y3'] as int? ?? 12,
      x4: json['x4'] as int? ?? 999,
      y4: json['y4'] as int? ?? 1000,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'dmcno': instance.dmcno,
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
