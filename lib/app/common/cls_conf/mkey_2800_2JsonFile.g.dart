// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mkey_2800_2JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mkey_2800_2JsonFile _$Mkey_2800_2JsonFileFromJson(Map<String, dynamic> json) =>
    Mkey_2800_2JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Mkey_2800_2JsonFileToJson(
        Mkey_2800_2JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      id: json['id'] as int? ?? 2,
      connect: json['connect'] as int? ?? 6,
      comp_cnt: json['comp_cnt'] as int? ?? 1,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'id': instance.id,
      'connect': instance.connect,
      'comp_cnt': instance.comp_cnt,
    };
