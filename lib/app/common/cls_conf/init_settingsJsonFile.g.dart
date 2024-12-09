// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_settingsJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Init_settingsJsonFile _$Init_settingsJsonFileFromJson(
        Map<String, dynamic> json) =>
    Init_settingsJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Init_settingsJsonFileToJson(
        Init_settingsJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      language: json['language'] as String? ?? 'jp',
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'language': instance.language,
    };
