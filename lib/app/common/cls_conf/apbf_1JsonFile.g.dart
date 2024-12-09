// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apbf_1JsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apbf_1JsonFile _$Apbf_1JsonFileFromJson(Map<String, dynamic> json) =>
    Apbf_1JsonFile()
      ..settings = _Settings.fromJson(json['settings'] as Map<String, dynamic>);

Map<String, dynamic> _$Apbf_1JsonFileToJson(Apbf_1JsonFile instance) =>
    <String, dynamic>{
      'settings': instance.settings.toJson(),
    };

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
      port: json['port'] as String? ?? 'com1',
      baudrate: json['baudrate'] as int? ?? 57600,
      databit: json['databit'] as int? ?? 8,
      startbit: json['startbit'] as int? ?? 1,
      stopbit: json['stopbit'] as int? ?? 1,
      parity: json['parity'] as String? ?? 'none',
      id: json['id'] as int? ?? 1,
    );

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
      'port': instance.port,
      'baudrate': instance.baudrate,
      'databit': instance.databit,
      'startbit': instance.startbit,
      'stopbit': instance.stopbit,
      'parity': instance.parity,
      'id': instance.id,
    };
