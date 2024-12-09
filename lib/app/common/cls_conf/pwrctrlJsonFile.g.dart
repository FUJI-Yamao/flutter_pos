// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pwrctrlJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PwrctrlJsonFile _$PwrctrlJsonFileFromJson(Map<String, dynamic> json) =>
    PwrctrlJsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$PwrctrlJsonFileToJson(PwrctrlJsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
    };
