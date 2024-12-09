// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_settingsJsonFile_ps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Init_settingsJsonFile_ps _$Init_settingsJsonFile_psFromJson(
        Map<String, dynamic> json) =>
    Init_settingsJsonFile_ps()
      ..settings_ps =
          _Settings_ps.fromJson(json['settings_ps'] as Map<String, dynamic>);

Map<String, dynamic> _$Init_settingsJsonFile_psToJson(
        Init_settingsJsonFile_ps instance) =>
    <String, dynamic>{
      'settings_ps': instance.settings_ps.toJson(),
    };

_Settings_ps _$Settings_psFromJson(Map<String, dynamic> json) => _Settings_ps(
      language: json['language'] as String,
    );

Map<String, dynamic> _$Settings_psToJson(_Settings_ps instance) =>
    <String, dynamic>{
      'language': instance.language,
    };
